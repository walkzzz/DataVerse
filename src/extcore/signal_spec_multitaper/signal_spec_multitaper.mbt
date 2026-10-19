///===
/// extcore/signal_spec_multitaper

pub(all) struct SignalspecmultitaperPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_multitaper_make_point(x : Double, y : Double) -> SignalspecmultitaperPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_multitaper_make_point3(x : Double, y : Double, z : Double) -> SignalspecmultitaperPoint {
  { x, y, z, label: 0 }
}

pub fn signal_spec_multitaper_point_x(pt : SignalspecmultitaperPoint) -> Double { pt.x }

pub fn signal_spec_multitaper_point_y(pt : SignalspecmultitaperPoint) -> Double { pt.y }

pub fn signal_spec_multitaper_point_z(pt : SignalspecmultitaperPoint) -> Double { pt.z }

pub fn signal_spec_multitaper_point_label(pt : SignalspecmultitaperPoint) -> Int { pt.label }

pub fn signal_spec_multitaper_point_dist(a : SignalspecmultitaperPoint, b : SignalspecmultitaperPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  signal_spec_multitaper_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_spec_multitaper_point_add(a : SignalspecmultitaperPoint, b : SignalspecmultitaperPoint) -> SignalspecmultitaperPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_spec_multitaper_point_sub(a : SignalspecmultitaperPoint, b : SignalspecmultitaperPoint) -> SignalspecmultitaperPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_spec_multitaper_point_scale(pt : SignalspecmultitaperPoint, s : Double) -> SignalspecmultitaperPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_spec_multitaper_point_dot(a : SignalspecmultitaperPoint, b : SignalspecmultitaperPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_spec_multitaper_point_cross(a : SignalspecmultitaperPoint, b : SignalspecmultitaperPoint) -> SignalspecmultitaperPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_spec_multitaper_point_norm(pt : SignalspecmultitaperPoint) -> Double {
  signal_spec_multitaper_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_spec_multitaper_point_normalize(pt : SignalspecmultitaperPoint) -> SignalspecmultitaperPoint {
  let n = signal_spec_multitaper_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_spec_multitaper_point_scale(pt, 1.0 / n) }
}

pub fn signal_spec_multitaper_point_negate(pt : SignalspecmultitaperPoint) -> SignalspecmultitaperPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_spec_multitaper_point_mid(a : SignalspecmultitaperPoint, b : SignalspecmultitaperPoint) -> SignalspecmultitaperPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_spec_multitaper_point_lerp(a : SignalspecmultitaperPoint, b : SignalspecmultitaperPoint, t : Double) -> SignalspecmultitaperPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_spec_multitaper_point_to_string(pt : SignalspecmultitaperPoint) -> String {
  "(" + signal_spec_multitaper_dbl(pt.x) + ", " + signal_spec_multitaper_dbl(pt.y) + ", " + signal_spec_multitaper_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalspecmultitaperSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_multitaper_make_series(vals : Array[Double], name : String) -> SignalspecmultitaperSeries {
  { vals, name, meta: 0 }
}

pub fn signal_spec_multitaper_series_len(s : SignalspecmultitaperSeries) -> Int { s.vals.length() }

pub fn signal_spec_multitaper_series_sum(s : SignalspecmultitaperSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn signal_spec_multitaper_series_mean(s : SignalspecmultitaperSeries) -> Double {
  let n = signal_spec_multitaper_series_len(s)
  if n == 0 { 0.0 } else { signal_spec_multitaper_series_sum(s) / n.to_double() }
}

pub fn signal_spec_multitaper_series_min(s : SignalspecmultitaperSeries) -> Double {
  let n = signal_spec_multitaper_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn signal_spec_multitaper_series_max(s : SignalspecmultitaperSeries) -> Double {
  let n = signal_spec_multitaper_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn signal_spec_multitaper_series_range(s : SignalspecmultitaperSeries) -> Double {
  signal_spec_multitaper_series_max(s) - signal_spec_multitaper_series_min(s)
}

pub fn signal_spec_multitaper_series_var(s : SignalspecmultitaperSeries) -> Double {
  let n = signal_spec_multitaper_series_len(s)
  if n == 0 { 0.0 } else {
    let m = signal_spec_multitaper_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn signal_spec_multitaper_series_std(s : SignalspecmultitaperSeries) -> Double { signal_spec_multitaper_sqrt(signal_spec_multitaper_series_var(s)) }

pub fn signal_spec_multitaper_series_median(s : SignalspecmultitaperSeries) -> Double {
  let n = signal_spec_multitaper_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = signal_spec_multitaper_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_spec_multitaper_series_scale(s : SignalspecmultitaperSeries, f : Double) -> SignalspecmultitaperSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = signal_spec_multitaper_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_spec_multitaper_series_add(a : SignalspecmultitaperSeries, b : SignalspecmultitaperSeries) -> SignalspecmultitaperSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = signal_spec_multitaper_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_spec_multitaper_series_sub(a : SignalspecmultitaperSeries, b : SignalspecmultitaperSeries) -> SignalspecmultitaperSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = signal_spec_multitaper_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_spec_multitaper_series_normalize(s : SignalspecmultitaperSeries) -> SignalspecmultitaperSeries {
  let mn = signal_spec_multitaper_series_min(s)
  let mx = signal_spec_multitaper_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = signal_spec_multitaper_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_spec_multitaper_series_cumsum(s : SignalspecmultitaperSeries) -> SignalspecmultitaperSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = signal_spec_multitaper_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_spec_multitaper_series_to_string(s : SignalspecmultitaperSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + signal_spec_multitaper_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecmultitaperMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_multitaper_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecmultitaperMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_multitaper_matrix_identity(n : Int) -> SignalspecmultitaperMatrix {
  let m = signal_spec_multitaper_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_spec_multitaper_matrix_get(m : SignalspecmultitaperMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_spec_multitaper_matrix_transpose(m : SignalspecmultitaperMatrix) -> SignalspecmultitaperMatrix {
  let result = signal_spec_multitaper_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_spec_multitaper_matrix_add(a : SignalspecmultitaperMatrix, b : SignalspecmultitaperMatrix) -> SignalspecmultitaperMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_spec_multitaper_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_spec_multitaper_matrix_scale(m : SignalspecmultitaperMatrix, s : Double) -> SignalspecmultitaperMatrix {
  let result = signal_spec_multitaper_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_spec_multitaper_matrix_multiply(a : SignalspecmultitaperMatrix, b : SignalspecmultitaperMatrix) -> SignalspecmultitaperMatrix {
  if a.cols != b.rows { return signal_spec_multitaper_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_spec_multitaper_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_spec_multitaper_matrix_trace(m : SignalspecmultitaperMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_spec_multitaper_matrix_det(m : SignalspecmultitaperMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_spec_multitaper_matrix_norm(m : SignalspecmultitaperMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  signal_spec_multitaper_sqrt(sum)
}

pub fn signal_spec_multitaper_matrix_to_string(m : SignalspecmultitaperMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + signal_spec_multitaper_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct SignalspecmultitaperVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_multitaper_make_vector(comps : Array[Double]) -> SignalspecmultitaperVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_multitaper_vector_zero(dim : Int) -> SignalspecmultitaperVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_spec_multitaper_vector_add(a : SignalspecmultitaperVector, b : SignalspecmultitaperVector) -> SignalspecmultitaperVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = signal_spec_multitaper_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_spec_multitaper_vector_sub(a : SignalspecmultitaperVector, b : SignalspecmultitaperVector) -> SignalspecmultitaperVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = signal_spec_multitaper_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_spec_multitaper_vector_scale(v : SignalspecmultitaperVector, s : Double) -> SignalspecmultitaperVector {
  let mut result = []
  for i in 0..<v.dim { result = signal_spec_multitaper_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_spec_multitaper_vector_dot(a : SignalspecmultitaperVector, b : SignalspecmultitaperVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_spec_multitaper_vector_norm(v : SignalspecmultitaperVector) -> Double { signal_spec_multitaper_sqrt(signal_spec_multitaper_vector_dot(v, v)) }

pub fn signal_spec_multitaper_vector_normalize(v : SignalspecmultitaperVector) -> SignalspecmultitaperVector {
  let n = signal_spec_multitaper_vector_norm(v)
  if n < 0.0000001 { v } else { signal_spec_multitaper_vector_scale(v, 1.0 / n) }
}

pub fn signal_spec_multitaper_vector_dist(a : SignalspecmultitaperVector, b : SignalspecmultitaperVector) -> Double {
  signal_spec_multitaper_vector_norm(signal_spec_multitaper_vector_sub(a, b))
}

pub fn signal_spec_multitaper_vector_to_string(v : SignalspecmultitaperVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + signal_spec_multitaper_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_spec_multitaper_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn signal_spec_multitaper_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = signal_spec_multitaper_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_spec_multitaper_std(data : Array[Double]) -> Double { signal_spec_multitaper_sqrt(signal_spec_multitaper_var(data)) }

pub fn signal_spec_multitaper_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = signal_spec_multitaper_mean(a); let mb = signal_spec_multitaper_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn signal_spec_multitaper_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = signal_spec_multitaper_std(a); let sb = signal_spec_multitaper_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { signal_spec_multitaper_cov(a, b) / (sa * sb) }
}

pub fn signal_spec_multitaper_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = signal_spec_multitaper_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_spec_multitaper_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn signal_spec_multitaper_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_spec_multitaper_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  signal_spec_multitaper_sqrt(signal_spec_multitaper_mse(pred, labels))
}

pub fn signal_spec_multitaper_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + signal_spec_multitaper_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn signal_spec_multitaper_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = signal_spec_multitaper_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn signal_spec_multitaper_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn signal_spec_multitaper_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn signal_spec_multitaper_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = signal_spec_multitaper_precision(pred, labels, pos); let r = signal_spec_multitaper_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn signal_spec_multitaper_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn signal_spec_multitaper_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = signal_spec_multitaper_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn signal_spec_multitaper_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn signal_spec_multitaper_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn signal_spec_multitaper_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = signal_spec_multitaper_gcd(a, b)
    (a / g) * b
  }
}

pub fn signal_spec_multitaper_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn signal_spec_multitaper_fibonacci(n : Int) -> Int {
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

pub fn signal_spec_multitaper_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = signal_spec_multitaper_min(data); let mx = signal_spec_multitaper_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn signal_spec_multitaper_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = signal_spec_multitaper_mean(data); let sd = signal_spec_multitaper_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn signal_spec_multitaper_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn signal_spec_multitaper_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn signal_spec_multitaper_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn signal_spec_multitaper_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn signal_spec_multitaper_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn signal_spec_multitaper_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn signal_spec_multitaper_dbl(x : Double) -> String {
  let i = if x >= 0.0 { signal_spec_multitaper_int(x) } else { -signal_spec_multitaper_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { signal_spec_multitaper_int(f * 1000000.0) } else { signal_spec_multitaper_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn signal_spec_multitaper_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn signal_spec_multitaper_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct SignalspecmultitaperFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_frame_make(size : Int) -> SignalspecmultitaperFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_frame_len(s : SignalspecmultitaperFrame) -> Int { s.size }

pub fn signal_spec_multitaper_frame_get(s : SignalspecmultitaperFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_frame_set(s : SignalspecmultitaperFrame, i : Int, v : Double) -> SignalspecmultitaperFrame {
  let result = signal_spec_multitaper_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_frame_sum(s : SignalspecmultitaperFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_multitaper_frame_mean(s : SignalspecmultitaperFrame) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_multitaper_frame_sum(s) / s.size.to_double() }
}

pub fn signal_spec_multitaper_frame_scale(s : SignalspecmultitaperFrame, f : Double) -> SignalspecmultitaperFrame {
  let result = signal_spec_multitaper_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_multitaper_frame_add(a : SignalspecmultitaperFrame, b : SignalspecmultitaperFrame) -> SignalspecmultitaperFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_multitaper_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_multitaper_frame_copy(s : SignalspecmultitaperFrame) -> SignalspecmultitaperFrame {
  let result = signal_spec_multitaper_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_multitaper_frame_fill(s : SignalspecmultitaperFrame, v : Double) -> SignalspecmultitaperFrame {
  let result = signal_spec_multitaper_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_frame_min(s : SignalspecmultitaperFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_frame_max(s : SignalspecmultitaperFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_frame_to_string(s : SignalspecmultitaperFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_table_make(size : Int) -> SignalspecmultitaperTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_table_len(s : SignalspecmultitaperTable) -> Int { s.size }

pub fn signal_spec_multitaper_table_get(s : SignalspecmultitaperTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_table_set(s : SignalspecmultitaperTable, i : Int, v : Double) -> SignalspecmultitaperTable {
  let result = signal_spec_multitaper_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_table_sum(s : SignalspecmultitaperTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_multitaper_table_mean(s : SignalspecmultitaperTable) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_multitaper_table_sum(s) / s.size.to_double() }
}

pub fn signal_spec_multitaper_table_scale(s : SignalspecmultitaperTable, f : Double) -> SignalspecmultitaperTable {
  let result = signal_spec_multitaper_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_multitaper_table_add(a : SignalspecmultitaperTable, b : SignalspecmultitaperTable) -> SignalspecmultitaperTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_multitaper_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_multitaper_table_copy(s : SignalspecmultitaperTable) -> SignalspecmultitaperTable {
  let result = signal_spec_multitaper_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_multitaper_table_fill(s : SignalspecmultitaperTable, v : Double) -> SignalspecmultitaperTable {
  let result = signal_spec_multitaper_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_table_min(s : SignalspecmultitaperTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_table_max(s : SignalspecmultitaperTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_table_to_string(s : SignalspecmultitaperTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_graphn_make(size : Int) -> SignalspecmultitaperGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_graphn_len(s : SignalspecmultitaperGraphN) -> Int { s.size }

pub fn signal_spec_multitaper_graphn_get(s : SignalspecmultitaperGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_graphn_set(s : SignalspecmultitaperGraphN, i : Int, v : Double) -> SignalspecmultitaperGraphN {
  let result = signal_spec_multitaper_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_graphn_sum(s : SignalspecmultitaperGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_multitaper_graphn_mean(s : SignalspecmultitaperGraphN) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_multitaper_graphn_sum(s) / s.size.to_double() }
}

pub fn signal_spec_multitaper_graphn_scale(s : SignalspecmultitaperGraphN, f : Double) -> SignalspecmultitaperGraphN {
  let result = signal_spec_multitaper_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_multitaper_graphn_add(a : SignalspecmultitaperGraphN, b : SignalspecmultitaperGraphN) -> SignalspecmultitaperGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_multitaper_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_multitaper_graphn_copy(s : SignalspecmultitaperGraphN) -> SignalspecmultitaperGraphN {
  let result = signal_spec_multitaper_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_multitaper_graphn_fill(s : SignalspecmultitaperGraphN, v : Double) -> SignalspecmultitaperGraphN {
  let result = signal_spec_multitaper_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_graphn_min(s : SignalspecmultitaperGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_graphn_max(s : SignalspecmultitaperGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_graphn_to_string(s : SignalspecmultitaperGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_node_make(size : Int) -> SignalspecmultitaperNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_node_len(s : SignalspecmultitaperNode) -> Int { s.size }

pub fn signal_spec_multitaper_node_get(s : SignalspecmultitaperNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_node_set(s : SignalspecmultitaperNode, i : Int, v : Double) -> SignalspecmultitaperNode {
  let result = signal_spec_multitaper_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_node_sum(s : SignalspecmultitaperNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_multitaper_node_mean(s : SignalspecmultitaperNode) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_multitaper_node_sum(s) / s.size.to_double() }
}

pub fn signal_spec_multitaper_node_scale(s : SignalspecmultitaperNode, f : Double) -> SignalspecmultitaperNode {
  let result = signal_spec_multitaper_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_multitaper_node_add(a : SignalspecmultitaperNode, b : SignalspecmultitaperNode) -> SignalspecmultitaperNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_multitaper_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_multitaper_node_copy(s : SignalspecmultitaperNode) -> SignalspecmultitaperNode {
  let result = signal_spec_multitaper_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_multitaper_node_fill(s : SignalspecmultitaperNode, v : Double) -> SignalspecmultitaperNode {
  let result = signal_spec_multitaper_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_node_min(s : SignalspecmultitaperNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_node_max(s : SignalspecmultitaperNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_node_to_string(s : SignalspecmultitaperNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_edge_make(size : Int) -> SignalspecmultitaperEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_edge_len(s : SignalspecmultitaperEdge) -> Int { s.size }

pub fn signal_spec_multitaper_edge_get(s : SignalspecmultitaperEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_edge_set(s : SignalspecmultitaperEdge, i : Int, v : Double) -> SignalspecmultitaperEdge {
  let result = signal_spec_multitaper_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_edge_sum(s : SignalspecmultitaperEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_multitaper_edge_mean(s : SignalspecmultitaperEdge) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_multitaper_edge_sum(s) / s.size.to_double() }
}

pub fn signal_spec_multitaper_edge_scale(s : SignalspecmultitaperEdge, f : Double) -> SignalspecmultitaperEdge {
  let result = signal_spec_multitaper_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_multitaper_edge_add(a : SignalspecmultitaperEdge, b : SignalspecmultitaperEdge) -> SignalspecmultitaperEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_multitaper_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_multitaper_edge_copy(s : SignalspecmultitaperEdge) -> SignalspecmultitaperEdge {
  let result = signal_spec_multitaper_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_multitaper_edge_fill(s : SignalspecmultitaperEdge, v : Double) -> SignalspecmultitaperEdge {
  let result = signal_spec_multitaper_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_edge_min(s : SignalspecmultitaperEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_edge_max(s : SignalspecmultitaperEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_edge_to_string(s : SignalspecmultitaperEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_path_make(size : Int) -> SignalspecmultitaperPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_path_len(s : SignalspecmultitaperPath) -> Int { s.size }

pub fn signal_spec_multitaper_path_get(s : SignalspecmultitaperPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_path_set(s : SignalspecmultitaperPath, i : Int, v : Double) -> SignalspecmultitaperPath {
  let result = signal_spec_multitaper_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_path_sum(s : SignalspecmultitaperPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_multitaper_path_mean(s : SignalspecmultitaperPath) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_multitaper_path_sum(s) / s.size.to_double() }
}

pub fn signal_spec_multitaper_path_scale(s : SignalspecmultitaperPath, f : Double) -> SignalspecmultitaperPath {
  let result = signal_spec_multitaper_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_multitaper_path_add(a : SignalspecmultitaperPath, b : SignalspecmultitaperPath) -> SignalspecmultitaperPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_multitaper_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_multitaper_path_copy(s : SignalspecmultitaperPath) -> SignalspecmultitaperPath {
  let result = signal_spec_multitaper_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_multitaper_path_fill(s : SignalspecmultitaperPath, v : Double) -> SignalspecmultitaperPath {
  let result = signal_spec_multitaper_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_path_min(s : SignalspecmultitaperPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_path_max(s : SignalspecmultitaperPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_path_to_string(s : SignalspecmultitaperPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_cluster_make(size : Int) -> SignalspecmultitaperCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_cluster_len(s : SignalspecmultitaperCluster) -> Int { s.size }

pub fn signal_spec_multitaper_cluster_get(s : SignalspecmultitaperCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_cluster_set(s : SignalspecmultitaperCluster, i : Int, v : Double) -> SignalspecmultitaperCluster {
  let result = signal_spec_multitaper_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_cluster_sum(s : SignalspecmultitaperCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_multitaper_cluster_mean(s : SignalspecmultitaperCluster) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_multitaper_cluster_sum(s) / s.size.to_double() }
}

pub fn signal_spec_multitaper_cluster_scale(s : SignalspecmultitaperCluster, f : Double) -> SignalspecmultitaperCluster {
  let result = signal_spec_multitaper_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_multitaper_cluster_add(a : SignalspecmultitaperCluster, b : SignalspecmultitaperCluster) -> SignalspecmultitaperCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_multitaper_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_multitaper_cluster_copy(s : SignalspecmultitaperCluster) -> SignalspecmultitaperCluster {
  let result = signal_spec_multitaper_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_multitaper_cluster_fill(s : SignalspecmultitaperCluster, v : Double) -> SignalspecmultitaperCluster {
  let result = signal_spec_multitaper_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_cluster_min(s : SignalspecmultitaperCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_cluster_max(s : SignalspecmultitaperCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_cluster_to_string(s : SignalspecmultitaperCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_model_make(size : Int) -> SignalspecmultitaperModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_model_len(s : SignalspecmultitaperModel) -> Int { s.size }

pub fn signal_spec_multitaper_model_get(s : SignalspecmultitaperModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_model_set(s : SignalspecmultitaperModel, i : Int, v : Double) -> SignalspecmultitaperModel {
  let result = signal_spec_multitaper_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_model_sum(s : SignalspecmultitaperModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_multitaper_model_mean(s : SignalspecmultitaperModel) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_multitaper_model_sum(s) / s.size.to_double() }
}

pub fn signal_spec_multitaper_model_scale(s : SignalspecmultitaperModel, f : Double) -> SignalspecmultitaperModel {
  let result = signal_spec_multitaper_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_multitaper_model_add(a : SignalspecmultitaperModel, b : SignalspecmultitaperModel) -> SignalspecmultitaperModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_multitaper_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_multitaper_model_copy(s : SignalspecmultitaperModel) -> SignalspecmultitaperModel {
  let result = signal_spec_multitaper_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_multitaper_model_fill(s : SignalspecmultitaperModel, v : Double) -> SignalspecmultitaperModel {
  let result = signal_spec_multitaper_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_model_min(s : SignalspecmultitaperModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_model_max(s : SignalspecmultitaperModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_model_to_string(s : SignalspecmultitaperModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_layer_make(size : Int) -> SignalspecmultitaperLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_layer_len(s : SignalspecmultitaperLayer) -> Int { s.size }

pub fn signal_spec_multitaper_layer_get(s : SignalspecmultitaperLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_layer_set(s : SignalspecmultitaperLayer, i : Int, v : Double) -> SignalspecmultitaperLayer {
  let result = signal_spec_multitaper_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_layer_sum(s : SignalspecmultitaperLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_multitaper_layer_mean(s : SignalspecmultitaperLayer) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_multitaper_layer_sum(s) / s.size.to_double() }
}

pub fn signal_spec_multitaper_layer_scale(s : SignalspecmultitaperLayer, f : Double) -> SignalspecmultitaperLayer {
  let result = signal_spec_multitaper_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_multitaper_layer_add(a : SignalspecmultitaperLayer, b : SignalspecmultitaperLayer) -> SignalspecmultitaperLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_multitaper_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_multitaper_layer_copy(s : SignalspecmultitaperLayer) -> SignalspecmultitaperLayer {
  let result = signal_spec_multitaper_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_multitaper_layer_fill(s : SignalspecmultitaperLayer, v : Double) -> SignalspecmultitaperLayer {
  let result = signal_spec_multitaper_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_layer_min(s : SignalspecmultitaperLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_layer_max(s : SignalspecmultitaperLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_layer_to_string(s : SignalspecmultitaperLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_buffer_make(size : Int) -> SignalspecmultitaperBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_buffer_len(s : SignalspecmultitaperBuffer) -> Int { s.size }

pub fn signal_spec_multitaper_buffer_get(s : SignalspecmultitaperBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_buffer_set(s : SignalspecmultitaperBuffer, i : Int, v : Double) -> SignalspecmultitaperBuffer {
  let result = signal_spec_multitaper_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_buffer_sum(s : SignalspecmultitaperBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_multitaper_buffer_mean(s : SignalspecmultitaperBuffer) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_multitaper_buffer_sum(s) / s.size.to_double() }
}

pub fn signal_spec_multitaper_buffer_scale(s : SignalspecmultitaperBuffer, f : Double) -> SignalspecmultitaperBuffer {
  let result = signal_spec_multitaper_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_multitaper_buffer_add(a : SignalspecmultitaperBuffer, b : SignalspecmultitaperBuffer) -> SignalspecmultitaperBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_multitaper_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_multitaper_buffer_copy(s : SignalspecmultitaperBuffer) -> SignalspecmultitaperBuffer {
  let result = signal_spec_multitaper_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_multitaper_buffer_fill(s : SignalspecmultitaperBuffer, v : Double) -> SignalspecmultitaperBuffer {
  let result = signal_spec_multitaper_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_buffer_min(s : SignalspecmultitaperBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_buffer_max(s : SignalspecmultitaperBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_buffer_to_string(s : SignalspecmultitaperBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_cursor_make(size : Int) -> SignalspecmultitaperCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_cursor_len(s : SignalspecmultitaperCursor) -> Int { s.size }

pub fn signal_spec_multitaper_cursor_get(s : SignalspecmultitaperCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_cursor_set(s : SignalspecmultitaperCursor, i : Int, v : Double) -> SignalspecmultitaperCursor {
  let result = signal_spec_multitaper_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_cursor_sum(s : SignalspecmultitaperCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_multitaper_cursor_mean(s : SignalspecmultitaperCursor) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_multitaper_cursor_sum(s) / s.size.to_double() }
}

pub fn signal_spec_multitaper_cursor_scale(s : SignalspecmultitaperCursor, f : Double) -> SignalspecmultitaperCursor {
  let result = signal_spec_multitaper_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_multitaper_cursor_add(a : SignalspecmultitaperCursor, b : SignalspecmultitaperCursor) -> SignalspecmultitaperCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_multitaper_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_multitaper_cursor_copy(s : SignalspecmultitaperCursor) -> SignalspecmultitaperCursor {
  let result = signal_spec_multitaper_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_multitaper_cursor_fill(s : SignalspecmultitaperCursor, v : Double) -> SignalspecmultitaperCursor {
  let result = signal_spec_multitaper_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_cursor_min(s : SignalspecmultitaperCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_cursor_max(s : SignalspecmultitaperCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_cursor_to_string(s : SignalspecmultitaperCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_view_make(size : Int) -> SignalspecmultitaperView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_view_len(s : SignalspecmultitaperView) -> Int { s.size }

pub fn signal_spec_multitaper_view_get(s : SignalspecmultitaperView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_view_set(s : SignalspecmultitaperView, i : Int, v : Double) -> SignalspecmultitaperView {
  let result = signal_spec_multitaper_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_view_sum(s : SignalspecmultitaperView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_multitaper_view_mean(s : SignalspecmultitaperView) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_multitaper_view_sum(s) / s.size.to_double() }
}

pub fn signal_spec_multitaper_view_scale(s : SignalspecmultitaperView, f : Double) -> SignalspecmultitaperView {
  let result = signal_spec_multitaper_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_multitaper_view_add(a : SignalspecmultitaperView, b : SignalspecmultitaperView) -> SignalspecmultitaperView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_multitaper_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_multitaper_view_copy(s : SignalspecmultitaperView) -> SignalspecmultitaperView {
  let result = signal_spec_multitaper_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_multitaper_view_fill(s : SignalspecmultitaperView, v : Double) -> SignalspecmultitaperView {
  let result = signal_spec_multitaper_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_view_min(s : SignalspecmultitaperView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_view_max(s : SignalspecmultitaperView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_view_to_string(s : SignalspecmultitaperView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_range_make(size : Int) -> SignalspecmultitaperRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_range_len(s : SignalspecmultitaperRange) -> Int { s.size }

pub fn signal_spec_multitaper_range_get(s : SignalspecmultitaperRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_range_set(s : SignalspecmultitaperRange, i : Int, v : Double) -> SignalspecmultitaperRange {
  let result = signal_spec_multitaper_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_range_sum(s : SignalspecmultitaperRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_multitaper_range_mean(s : SignalspecmultitaperRange) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_multitaper_range_sum(s) / s.size.to_double() }
}

pub fn signal_spec_multitaper_range_scale(s : SignalspecmultitaperRange, f : Double) -> SignalspecmultitaperRange {
  let result = signal_spec_multitaper_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_multitaper_range_add(a : SignalspecmultitaperRange, b : SignalspecmultitaperRange) -> SignalspecmultitaperRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_multitaper_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_multitaper_range_copy(s : SignalspecmultitaperRange) -> SignalspecmultitaperRange {
  let result = signal_spec_multitaper_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_multitaper_range_fill(s : SignalspecmultitaperRange, v : Double) -> SignalspecmultitaperRange {
  let result = signal_spec_multitaper_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_range_min(s : SignalspecmultitaperRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_range_max(s : SignalspecmultitaperRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_range_to_string(s : SignalspecmultitaperRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_slice_make(size : Int) -> SignalspecmultitaperSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_slice_len(s : SignalspecmultitaperSlice) -> Int { s.size }

pub fn signal_spec_multitaper_slice_get(s : SignalspecmultitaperSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_slice_set(s : SignalspecmultitaperSlice, i : Int, v : Double) -> SignalspecmultitaperSlice {
  let result = signal_spec_multitaper_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_slice_sum(s : SignalspecmultitaperSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_multitaper_slice_mean(s : SignalspecmultitaperSlice) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_multitaper_slice_sum(s) / s.size.to_double() }
}

pub fn signal_spec_multitaper_slice_scale(s : SignalspecmultitaperSlice, f : Double) -> SignalspecmultitaperSlice {
  let result = signal_spec_multitaper_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_multitaper_slice_add(a : SignalspecmultitaperSlice, b : SignalspecmultitaperSlice) -> SignalspecmultitaperSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_multitaper_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_multitaper_slice_copy(s : SignalspecmultitaperSlice) -> SignalspecmultitaperSlice {
  let result = signal_spec_multitaper_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_multitaper_slice_fill(s : SignalspecmultitaperSlice, v : Double) -> SignalspecmultitaperSlice {
  let result = signal_spec_multitaper_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_slice_min(s : SignalspecmultitaperSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_slice_max(s : SignalspecmultitaperSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_multitaper_slice_to_string(s : SignalspecmultitaperSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn signal_spec_multitaper_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_multitaper_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_multitaper_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_multitaper_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_multitaper_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_multitaper_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_multitaper_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_multitaper_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_multitaper_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_multitaper_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_multitaper_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_multitaper_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_multitaper_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_multitaper_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_multitaper_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_multitaper_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_multitaper_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_multitaper_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_multitaper_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_multitaper_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_multitaper_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_multitaper_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_multitaper_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_multitaper_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_multitaper_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

