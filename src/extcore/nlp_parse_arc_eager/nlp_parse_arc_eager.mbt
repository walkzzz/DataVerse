///===
/// extcore/nlp_parse_arc_eager

pub(all) struct NlpparsearceagerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_arc_eager_make_point(x : Double, y : Double) -> NlpparsearceagerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_arc_eager_make_point3(x : Double, y : Double, z : Double) -> NlpparsearceagerPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_parse_arc_eager_point_x(pt : NlpparsearceagerPoint) -> Double { pt.x }

pub fn nlp_parse_arc_eager_point_y(pt : NlpparsearceagerPoint) -> Double { pt.y }

pub fn nlp_parse_arc_eager_point_z(pt : NlpparsearceagerPoint) -> Double { pt.z }

pub fn nlp_parse_arc_eager_point_label(pt : NlpparsearceagerPoint) -> Int { pt.label }

pub fn nlp_parse_arc_eager_point_dist(a : NlpparsearceagerPoint, b : NlpparsearceagerPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  nlp_parse_arc_eager_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_parse_arc_eager_point_add(a : NlpparsearceagerPoint, b : NlpparsearceagerPoint) -> NlpparsearceagerPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_parse_arc_eager_point_sub(a : NlpparsearceagerPoint, b : NlpparsearceagerPoint) -> NlpparsearceagerPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_parse_arc_eager_point_scale(pt : NlpparsearceagerPoint, s : Double) -> NlpparsearceagerPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_parse_arc_eager_point_dot(a : NlpparsearceagerPoint, b : NlpparsearceagerPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_parse_arc_eager_point_cross(a : NlpparsearceagerPoint, b : NlpparsearceagerPoint) -> NlpparsearceagerPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_parse_arc_eager_point_norm(pt : NlpparsearceagerPoint) -> Double {
  nlp_parse_arc_eager_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_parse_arc_eager_point_normalize(pt : NlpparsearceagerPoint) -> NlpparsearceagerPoint {
  let n = nlp_parse_arc_eager_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_parse_arc_eager_point_scale(pt, 1.0 / n) }
}

pub fn nlp_parse_arc_eager_point_negate(pt : NlpparsearceagerPoint) -> NlpparsearceagerPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_parse_arc_eager_point_mid(a : NlpparsearceagerPoint, b : NlpparsearceagerPoint) -> NlpparsearceagerPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_parse_arc_eager_point_lerp(a : NlpparsearceagerPoint, b : NlpparsearceagerPoint, t : Double) -> NlpparsearceagerPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_parse_arc_eager_point_to_string(pt : NlpparsearceagerPoint) -> String {
  "(" + nlp_parse_arc_eager_dbl(pt.x) + ", " + nlp_parse_arc_eager_dbl(pt.y) + ", " + nlp_parse_arc_eager_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpparsearceagerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_arc_eager_make_series(vals : Array[Double], name : String) -> NlpparsearceagerSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_parse_arc_eager_series_len(s : NlpparsearceagerSeries) -> Int { s.vals.length() }

pub fn nlp_parse_arc_eager_series_sum(s : NlpparsearceagerSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_parse_arc_eager_series_mean(s : NlpparsearceagerSeries) -> Double {
  let n = nlp_parse_arc_eager_series_len(s)
  if n == 0 { 0.0 } else { nlp_parse_arc_eager_series_sum(s) / n.to_double() }
}

pub fn nlp_parse_arc_eager_series_min(s : NlpparsearceagerSeries) -> Double {
  let n = nlp_parse_arc_eager_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_series_max(s : NlpparsearceagerSeries) -> Double {
  let n = nlp_parse_arc_eager_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_series_range(s : NlpparsearceagerSeries) -> Double {
  nlp_parse_arc_eager_series_max(s) - nlp_parse_arc_eager_series_min(s)
}

pub fn nlp_parse_arc_eager_series_var(s : NlpparsearceagerSeries) -> Double {
  let n = nlp_parse_arc_eager_series_len(s)
  if n == 0 { 0.0 } else {
    let m = nlp_parse_arc_eager_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_series_std(s : NlpparsearceagerSeries) -> Double { nlp_parse_arc_eager_sqrt(nlp_parse_arc_eager_series_var(s)) }

pub fn nlp_parse_arc_eager_series_median(s : NlpparsearceagerSeries) -> Double {
  let n = nlp_parse_arc_eager_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = nlp_parse_arc_eager_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_parse_arc_eager_series_scale(s : NlpparsearceagerSeries, f : Double) -> NlpparsearceagerSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = nlp_parse_arc_eager_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_parse_arc_eager_series_add(a : NlpparsearceagerSeries, b : NlpparsearceagerSeries) -> NlpparsearceagerSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = nlp_parse_arc_eager_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_parse_arc_eager_series_sub(a : NlpparsearceagerSeries, b : NlpparsearceagerSeries) -> NlpparsearceagerSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = nlp_parse_arc_eager_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_parse_arc_eager_series_normalize(s : NlpparsearceagerSeries) -> NlpparsearceagerSeries {
  let mn = nlp_parse_arc_eager_series_min(s)
  let mx = nlp_parse_arc_eager_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = nlp_parse_arc_eager_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_parse_arc_eager_series_cumsum(s : NlpparsearceagerSeries) -> NlpparsearceagerSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = nlp_parse_arc_eager_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_parse_arc_eager_series_to_string(s : NlpparsearceagerSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + nlp_parse_arc_eager_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparsearceagerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_arc_eager_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparsearceagerMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_parse_arc_eager_matrix_identity(n : Int) -> NlpparsearceagerMatrix {
  let m = nlp_parse_arc_eager_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_parse_arc_eager_matrix_get(m : NlpparsearceagerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_parse_arc_eager_matrix_transpose(m : NlpparsearceagerMatrix) -> NlpparsearceagerMatrix {
  let result = nlp_parse_arc_eager_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_parse_arc_eager_matrix_add(a : NlpparsearceagerMatrix, b : NlpparsearceagerMatrix) -> NlpparsearceagerMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_parse_arc_eager_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_parse_arc_eager_matrix_scale(m : NlpparsearceagerMatrix, s : Double) -> NlpparsearceagerMatrix {
  let result = nlp_parse_arc_eager_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_parse_arc_eager_matrix_multiply(a : NlpparsearceagerMatrix, b : NlpparsearceagerMatrix) -> NlpparsearceagerMatrix {
  if a.cols != b.rows { return nlp_parse_arc_eager_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_parse_arc_eager_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_parse_arc_eager_matrix_trace(m : NlpparsearceagerMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_parse_arc_eager_matrix_det(m : NlpparsearceagerMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_parse_arc_eager_matrix_norm(m : NlpparsearceagerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  nlp_parse_arc_eager_sqrt(sum)
}

pub fn nlp_parse_arc_eager_matrix_to_string(m : NlpparsearceagerMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + nlp_parse_arc_eager_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct NlpparsearceagerVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_arc_eager_make_vector(comps : Array[Double]) -> NlpparsearceagerVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_arc_eager_vector_zero(dim : Int) -> NlpparsearceagerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_parse_arc_eager_vector_add(a : NlpparsearceagerVector, b : NlpparsearceagerVector) -> NlpparsearceagerVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = nlp_parse_arc_eager_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_parse_arc_eager_vector_sub(a : NlpparsearceagerVector, b : NlpparsearceagerVector) -> NlpparsearceagerVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = nlp_parse_arc_eager_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_parse_arc_eager_vector_scale(v : NlpparsearceagerVector, s : Double) -> NlpparsearceagerVector {
  let mut result = []
  for i in 0..<v.dim { result = nlp_parse_arc_eager_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_parse_arc_eager_vector_dot(a : NlpparsearceagerVector, b : NlpparsearceagerVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_parse_arc_eager_vector_norm(v : NlpparsearceagerVector) -> Double { nlp_parse_arc_eager_sqrt(nlp_parse_arc_eager_vector_dot(v, v)) }

pub fn nlp_parse_arc_eager_vector_normalize(v : NlpparsearceagerVector) -> NlpparsearceagerVector {
  let n = nlp_parse_arc_eager_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_parse_arc_eager_vector_scale(v, 1.0 / n) }
}

pub fn nlp_parse_arc_eager_vector_dist(a : NlpparsearceagerVector, b : NlpparsearceagerVector) -> Double {
  nlp_parse_arc_eager_vector_norm(nlp_parse_arc_eager_vector_sub(a, b))
}

pub fn nlp_parse_arc_eager_vector_to_string(v : NlpparsearceagerVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + nlp_parse_arc_eager_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_parse_arc_eager_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = nlp_parse_arc_eager_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_std(data : Array[Double]) -> Double { nlp_parse_arc_eager_sqrt(nlp_parse_arc_eager_var(data)) }

pub fn nlp_parse_arc_eager_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = nlp_parse_arc_eager_mean(a); let mb = nlp_parse_arc_eager_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = nlp_parse_arc_eager_std(a); let sb = nlp_parse_arc_eager_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { nlp_parse_arc_eager_cov(a, b) / (sa * sb) }
}

pub fn nlp_parse_arc_eager_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = nlp_parse_arc_eager_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_parse_arc_eager_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  nlp_parse_arc_eager_sqrt(nlp_parse_arc_eager_mse(pred, labels))
}

pub fn nlp_parse_arc_eager_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + nlp_parse_arc_eager_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = nlp_parse_arc_eager_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn nlp_parse_arc_eager_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn nlp_parse_arc_eager_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn nlp_parse_arc_eager_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = nlp_parse_arc_eager_precision(pred, labels, pos); let r = nlp_parse_arc_eager_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn nlp_parse_arc_eager_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn nlp_parse_arc_eager_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = nlp_parse_arc_eager_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn nlp_parse_arc_eager_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn nlp_parse_arc_eager_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn nlp_parse_arc_eager_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = nlp_parse_arc_eager_gcd(a, b)
    (a / g) * b
  }
}

pub fn nlp_parse_arc_eager_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn nlp_parse_arc_eager_fibonacci(n : Int) -> Int {
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

pub fn nlp_parse_arc_eager_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = nlp_parse_arc_eager_min(data); let mx = nlp_parse_arc_eager_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn nlp_parse_arc_eager_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = nlp_parse_arc_eager_mean(data); let sd = nlp_parse_arc_eager_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn nlp_parse_arc_eager_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn nlp_parse_arc_eager_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn nlp_parse_arc_eager_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn nlp_parse_arc_eager_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn nlp_parse_arc_eager_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn nlp_parse_arc_eager_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn nlp_parse_arc_eager_dbl(x : Double) -> String {
  let i = if x >= 0.0 { nlp_parse_arc_eager_int(x) } else { -nlp_parse_arc_eager_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { nlp_parse_arc_eager_int(f * 1000000.0) } else { nlp_parse_arc_eager_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn nlp_parse_arc_eager_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn nlp_parse_arc_eager_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct NlpparsearceagerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_frame_make(size : Int) -> NlpparsearceagerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_frame_len(s : NlpparsearceagerFrame) -> Int { s.size }

pub fn nlp_parse_arc_eager_frame_get(s : NlpparsearceagerFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_frame_set(s : NlpparsearceagerFrame, i : Int, v : Double) -> NlpparsearceagerFrame {
  let result = nlp_parse_arc_eager_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_frame_sum(s : NlpparsearceagerFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_eager_frame_mean(s : NlpparsearceagerFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_eager_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_eager_frame_scale(s : NlpparsearceagerFrame, f : Double) -> NlpparsearceagerFrame {
  let result = nlp_parse_arc_eager_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_eager_frame_add(a : NlpparsearceagerFrame, b : NlpparsearceagerFrame) -> NlpparsearceagerFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_eager_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_eager_frame_copy(s : NlpparsearceagerFrame) -> NlpparsearceagerFrame {
  let result = nlp_parse_arc_eager_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_eager_frame_fill(s : NlpparsearceagerFrame, v : Double) -> NlpparsearceagerFrame {
  let result = nlp_parse_arc_eager_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_frame_min(s : NlpparsearceagerFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_frame_max(s : NlpparsearceagerFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_frame_to_string(s : NlpparsearceagerFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_table_make(size : Int) -> NlpparsearceagerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_table_len(s : NlpparsearceagerTable) -> Int { s.size }

pub fn nlp_parse_arc_eager_table_get(s : NlpparsearceagerTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_table_set(s : NlpparsearceagerTable, i : Int, v : Double) -> NlpparsearceagerTable {
  let result = nlp_parse_arc_eager_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_table_sum(s : NlpparsearceagerTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_eager_table_mean(s : NlpparsearceagerTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_eager_table_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_eager_table_scale(s : NlpparsearceagerTable, f : Double) -> NlpparsearceagerTable {
  let result = nlp_parse_arc_eager_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_eager_table_add(a : NlpparsearceagerTable, b : NlpparsearceagerTable) -> NlpparsearceagerTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_eager_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_eager_table_copy(s : NlpparsearceagerTable) -> NlpparsearceagerTable {
  let result = nlp_parse_arc_eager_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_eager_table_fill(s : NlpparsearceagerTable, v : Double) -> NlpparsearceagerTable {
  let result = nlp_parse_arc_eager_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_table_min(s : NlpparsearceagerTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_table_max(s : NlpparsearceagerTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_table_to_string(s : NlpparsearceagerTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_graphn_make(size : Int) -> NlpparsearceagerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_graphn_len(s : NlpparsearceagerGraphN) -> Int { s.size }

pub fn nlp_parse_arc_eager_graphn_get(s : NlpparsearceagerGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_graphn_set(s : NlpparsearceagerGraphN, i : Int, v : Double) -> NlpparsearceagerGraphN {
  let result = nlp_parse_arc_eager_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_graphn_sum(s : NlpparsearceagerGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_eager_graphn_mean(s : NlpparsearceagerGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_eager_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_eager_graphn_scale(s : NlpparsearceagerGraphN, f : Double) -> NlpparsearceagerGraphN {
  let result = nlp_parse_arc_eager_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_eager_graphn_add(a : NlpparsearceagerGraphN, b : NlpparsearceagerGraphN) -> NlpparsearceagerGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_eager_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_eager_graphn_copy(s : NlpparsearceagerGraphN) -> NlpparsearceagerGraphN {
  let result = nlp_parse_arc_eager_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_eager_graphn_fill(s : NlpparsearceagerGraphN, v : Double) -> NlpparsearceagerGraphN {
  let result = nlp_parse_arc_eager_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_graphn_min(s : NlpparsearceagerGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_graphn_max(s : NlpparsearceagerGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_graphn_to_string(s : NlpparsearceagerGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_node_make(size : Int) -> NlpparsearceagerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_node_len(s : NlpparsearceagerNode) -> Int { s.size }

pub fn nlp_parse_arc_eager_node_get(s : NlpparsearceagerNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_node_set(s : NlpparsearceagerNode, i : Int, v : Double) -> NlpparsearceagerNode {
  let result = nlp_parse_arc_eager_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_node_sum(s : NlpparsearceagerNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_eager_node_mean(s : NlpparsearceagerNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_eager_node_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_eager_node_scale(s : NlpparsearceagerNode, f : Double) -> NlpparsearceagerNode {
  let result = nlp_parse_arc_eager_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_eager_node_add(a : NlpparsearceagerNode, b : NlpparsearceagerNode) -> NlpparsearceagerNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_eager_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_eager_node_copy(s : NlpparsearceagerNode) -> NlpparsearceagerNode {
  let result = nlp_parse_arc_eager_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_eager_node_fill(s : NlpparsearceagerNode, v : Double) -> NlpparsearceagerNode {
  let result = nlp_parse_arc_eager_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_node_min(s : NlpparsearceagerNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_node_max(s : NlpparsearceagerNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_node_to_string(s : NlpparsearceagerNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_edge_make(size : Int) -> NlpparsearceagerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_edge_len(s : NlpparsearceagerEdge) -> Int { s.size }

pub fn nlp_parse_arc_eager_edge_get(s : NlpparsearceagerEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_edge_set(s : NlpparsearceagerEdge, i : Int, v : Double) -> NlpparsearceagerEdge {
  let result = nlp_parse_arc_eager_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_edge_sum(s : NlpparsearceagerEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_eager_edge_mean(s : NlpparsearceagerEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_eager_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_eager_edge_scale(s : NlpparsearceagerEdge, f : Double) -> NlpparsearceagerEdge {
  let result = nlp_parse_arc_eager_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_eager_edge_add(a : NlpparsearceagerEdge, b : NlpparsearceagerEdge) -> NlpparsearceagerEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_eager_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_eager_edge_copy(s : NlpparsearceagerEdge) -> NlpparsearceagerEdge {
  let result = nlp_parse_arc_eager_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_eager_edge_fill(s : NlpparsearceagerEdge, v : Double) -> NlpparsearceagerEdge {
  let result = nlp_parse_arc_eager_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_edge_min(s : NlpparsearceagerEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_edge_max(s : NlpparsearceagerEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_edge_to_string(s : NlpparsearceagerEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_path_make(size : Int) -> NlpparsearceagerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_path_len(s : NlpparsearceagerPath) -> Int { s.size }

pub fn nlp_parse_arc_eager_path_get(s : NlpparsearceagerPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_path_set(s : NlpparsearceagerPath, i : Int, v : Double) -> NlpparsearceagerPath {
  let result = nlp_parse_arc_eager_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_path_sum(s : NlpparsearceagerPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_eager_path_mean(s : NlpparsearceagerPath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_eager_path_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_eager_path_scale(s : NlpparsearceagerPath, f : Double) -> NlpparsearceagerPath {
  let result = nlp_parse_arc_eager_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_eager_path_add(a : NlpparsearceagerPath, b : NlpparsearceagerPath) -> NlpparsearceagerPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_eager_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_eager_path_copy(s : NlpparsearceagerPath) -> NlpparsearceagerPath {
  let result = nlp_parse_arc_eager_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_eager_path_fill(s : NlpparsearceagerPath, v : Double) -> NlpparsearceagerPath {
  let result = nlp_parse_arc_eager_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_path_min(s : NlpparsearceagerPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_path_max(s : NlpparsearceagerPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_path_to_string(s : NlpparsearceagerPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_cluster_make(size : Int) -> NlpparsearceagerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_cluster_len(s : NlpparsearceagerCluster) -> Int { s.size }

pub fn nlp_parse_arc_eager_cluster_get(s : NlpparsearceagerCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_cluster_set(s : NlpparsearceagerCluster, i : Int, v : Double) -> NlpparsearceagerCluster {
  let result = nlp_parse_arc_eager_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_cluster_sum(s : NlpparsearceagerCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_eager_cluster_mean(s : NlpparsearceagerCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_eager_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_eager_cluster_scale(s : NlpparsearceagerCluster, f : Double) -> NlpparsearceagerCluster {
  let result = nlp_parse_arc_eager_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_eager_cluster_add(a : NlpparsearceagerCluster, b : NlpparsearceagerCluster) -> NlpparsearceagerCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_eager_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_eager_cluster_copy(s : NlpparsearceagerCluster) -> NlpparsearceagerCluster {
  let result = nlp_parse_arc_eager_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_eager_cluster_fill(s : NlpparsearceagerCluster, v : Double) -> NlpparsearceagerCluster {
  let result = nlp_parse_arc_eager_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_cluster_min(s : NlpparsearceagerCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_cluster_max(s : NlpparsearceagerCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_cluster_to_string(s : NlpparsearceagerCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_model_make(size : Int) -> NlpparsearceagerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_model_len(s : NlpparsearceagerModel) -> Int { s.size }

pub fn nlp_parse_arc_eager_model_get(s : NlpparsearceagerModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_model_set(s : NlpparsearceagerModel, i : Int, v : Double) -> NlpparsearceagerModel {
  let result = nlp_parse_arc_eager_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_model_sum(s : NlpparsearceagerModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_eager_model_mean(s : NlpparsearceagerModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_eager_model_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_eager_model_scale(s : NlpparsearceagerModel, f : Double) -> NlpparsearceagerModel {
  let result = nlp_parse_arc_eager_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_eager_model_add(a : NlpparsearceagerModel, b : NlpparsearceagerModel) -> NlpparsearceagerModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_eager_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_eager_model_copy(s : NlpparsearceagerModel) -> NlpparsearceagerModel {
  let result = nlp_parse_arc_eager_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_eager_model_fill(s : NlpparsearceagerModel, v : Double) -> NlpparsearceagerModel {
  let result = nlp_parse_arc_eager_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_model_min(s : NlpparsearceagerModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_model_max(s : NlpparsearceagerModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_model_to_string(s : NlpparsearceagerModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_layer_make(size : Int) -> NlpparsearceagerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_layer_len(s : NlpparsearceagerLayer) -> Int { s.size }

pub fn nlp_parse_arc_eager_layer_get(s : NlpparsearceagerLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_layer_set(s : NlpparsearceagerLayer, i : Int, v : Double) -> NlpparsearceagerLayer {
  let result = nlp_parse_arc_eager_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_layer_sum(s : NlpparsearceagerLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_eager_layer_mean(s : NlpparsearceagerLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_eager_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_eager_layer_scale(s : NlpparsearceagerLayer, f : Double) -> NlpparsearceagerLayer {
  let result = nlp_parse_arc_eager_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_eager_layer_add(a : NlpparsearceagerLayer, b : NlpparsearceagerLayer) -> NlpparsearceagerLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_eager_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_eager_layer_copy(s : NlpparsearceagerLayer) -> NlpparsearceagerLayer {
  let result = nlp_parse_arc_eager_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_eager_layer_fill(s : NlpparsearceagerLayer, v : Double) -> NlpparsearceagerLayer {
  let result = nlp_parse_arc_eager_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_layer_min(s : NlpparsearceagerLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_layer_max(s : NlpparsearceagerLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_layer_to_string(s : NlpparsearceagerLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_buffer_make(size : Int) -> NlpparsearceagerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_buffer_len(s : NlpparsearceagerBuffer) -> Int { s.size }

pub fn nlp_parse_arc_eager_buffer_get(s : NlpparsearceagerBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_buffer_set(s : NlpparsearceagerBuffer, i : Int, v : Double) -> NlpparsearceagerBuffer {
  let result = nlp_parse_arc_eager_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_buffer_sum(s : NlpparsearceagerBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_eager_buffer_mean(s : NlpparsearceagerBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_eager_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_eager_buffer_scale(s : NlpparsearceagerBuffer, f : Double) -> NlpparsearceagerBuffer {
  let result = nlp_parse_arc_eager_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_eager_buffer_add(a : NlpparsearceagerBuffer, b : NlpparsearceagerBuffer) -> NlpparsearceagerBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_eager_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_eager_buffer_copy(s : NlpparsearceagerBuffer) -> NlpparsearceagerBuffer {
  let result = nlp_parse_arc_eager_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_eager_buffer_fill(s : NlpparsearceagerBuffer, v : Double) -> NlpparsearceagerBuffer {
  let result = nlp_parse_arc_eager_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_buffer_min(s : NlpparsearceagerBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_buffer_max(s : NlpparsearceagerBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_buffer_to_string(s : NlpparsearceagerBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_cursor_make(size : Int) -> NlpparsearceagerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_cursor_len(s : NlpparsearceagerCursor) -> Int { s.size }

pub fn nlp_parse_arc_eager_cursor_get(s : NlpparsearceagerCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_cursor_set(s : NlpparsearceagerCursor, i : Int, v : Double) -> NlpparsearceagerCursor {
  let result = nlp_parse_arc_eager_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_cursor_sum(s : NlpparsearceagerCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_eager_cursor_mean(s : NlpparsearceagerCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_eager_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_eager_cursor_scale(s : NlpparsearceagerCursor, f : Double) -> NlpparsearceagerCursor {
  let result = nlp_parse_arc_eager_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_eager_cursor_add(a : NlpparsearceagerCursor, b : NlpparsearceagerCursor) -> NlpparsearceagerCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_eager_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_eager_cursor_copy(s : NlpparsearceagerCursor) -> NlpparsearceagerCursor {
  let result = nlp_parse_arc_eager_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_eager_cursor_fill(s : NlpparsearceagerCursor, v : Double) -> NlpparsearceagerCursor {
  let result = nlp_parse_arc_eager_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_cursor_min(s : NlpparsearceagerCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_cursor_max(s : NlpparsearceagerCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_cursor_to_string(s : NlpparsearceagerCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_view_make(size : Int) -> NlpparsearceagerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_view_len(s : NlpparsearceagerView) -> Int { s.size }

pub fn nlp_parse_arc_eager_view_get(s : NlpparsearceagerView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_view_set(s : NlpparsearceagerView, i : Int, v : Double) -> NlpparsearceagerView {
  let result = nlp_parse_arc_eager_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_view_sum(s : NlpparsearceagerView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_eager_view_mean(s : NlpparsearceagerView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_eager_view_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_eager_view_scale(s : NlpparsearceagerView, f : Double) -> NlpparsearceagerView {
  let result = nlp_parse_arc_eager_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_eager_view_add(a : NlpparsearceagerView, b : NlpparsearceagerView) -> NlpparsearceagerView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_eager_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_eager_view_copy(s : NlpparsearceagerView) -> NlpparsearceagerView {
  let result = nlp_parse_arc_eager_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_eager_view_fill(s : NlpparsearceagerView, v : Double) -> NlpparsearceagerView {
  let result = nlp_parse_arc_eager_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_view_min(s : NlpparsearceagerView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_view_max(s : NlpparsearceagerView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_view_to_string(s : NlpparsearceagerView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_range_make(size : Int) -> NlpparsearceagerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_range_len(s : NlpparsearceagerRange) -> Int { s.size }

pub fn nlp_parse_arc_eager_range_get(s : NlpparsearceagerRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_range_set(s : NlpparsearceagerRange, i : Int, v : Double) -> NlpparsearceagerRange {
  let result = nlp_parse_arc_eager_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_range_sum(s : NlpparsearceagerRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_eager_range_mean(s : NlpparsearceagerRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_eager_range_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_eager_range_scale(s : NlpparsearceagerRange, f : Double) -> NlpparsearceagerRange {
  let result = nlp_parse_arc_eager_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_eager_range_add(a : NlpparsearceagerRange, b : NlpparsearceagerRange) -> NlpparsearceagerRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_eager_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_eager_range_copy(s : NlpparsearceagerRange) -> NlpparsearceagerRange {
  let result = nlp_parse_arc_eager_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_eager_range_fill(s : NlpparsearceagerRange, v : Double) -> NlpparsearceagerRange {
  let result = nlp_parse_arc_eager_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_range_min(s : NlpparsearceagerRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_range_max(s : NlpparsearceagerRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_range_to_string(s : NlpparsearceagerRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearceagerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_eager_slice_make(size : Int) -> NlpparsearceagerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_eager_slice_len(s : NlpparsearceagerSlice) -> Int { s.size }

pub fn nlp_parse_arc_eager_slice_get(s : NlpparsearceagerSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_eager_slice_set(s : NlpparsearceagerSlice, i : Int, v : Double) -> NlpparsearceagerSlice {
  let result = nlp_parse_arc_eager_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_slice_sum(s : NlpparsearceagerSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_eager_slice_mean(s : NlpparsearceagerSlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_eager_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_eager_slice_scale(s : NlpparsearceagerSlice, f : Double) -> NlpparsearceagerSlice {
  let result = nlp_parse_arc_eager_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_eager_slice_add(a : NlpparsearceagerSlice, b : NlpparsearceagerSlice) -> NlpparsearceagerSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_eager_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_eager_slice_copy(s : NlpparsearceagerSlice) -> NlpparsearceagerSlice {
  let result = nlp_parse_arc_eager_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_eager_slice_fill(s : NlpparsearceagerSlice, v : Double) -> NlpparsearceagerSlice {
  let result = nlp_parse_arc_eager_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_eager_slice_min(s : NlpparsearceagerSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_slice_max(s : NlpparsearceagerSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_eager_slice_to_string(s : NlpparsearceagerSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn nlp_parse_arc_eager_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_arc_eager_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

