///===
/// extcore/signal_spec_yule_walker

pub(all) struct SignalspecyulewalkerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_yule_walker_make_point(x : Double, y : Double) -> SignalspecyulewalkerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_yule_walker_make_point3(x : Double, y : Double, z : Double) -> SignalspecyulewalkerPoint {
  { x, y, z, label: 0 }
}

pub fn signal_spec_yule_walker_point_x(pt : SignalspecyulewalkerPoint) -> Double { pt.x }

pub fn signal_spec_yule_walker_point_y(pt : SignalspecyulewalkerPoint) -> Double { pt.y }

pub fn signal_spec_yule_walker_point_z(pt : SignalspecyulewalkerPoint) -> Double { pt.z }

pub fn signal_spec_yule_walker_point_label(pt : SignalspecyulewalkerPoint) -> Int { pt.label }

pub fn signal_spec_yule_walker_point_dist(a : SignalspecyulewalkerPoint, b : SignalspecyulewalkerPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_spec_yule_walker_point_add(a : SignalspecyulewalkerPoint, b : SignalspecyulewalkerPoint) -> SignalspecyulewalkerPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_spec_yule_walker_point_sub(a : SignalspecyulewalkerPoint, b : SignalspecyulewalkerPoint) -> SignalspecyulewalkerPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_spec_yule_walker_point_scale(pt : SignalspecyulewalkerPoint, s : Double) -> SignalspecyulewalkerPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_spec_yule_walker_point_dot(a : SignalspecyulewalkerPoint, b : SignalspecyulewalkerPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_spec_yule_walker_point_cross(a : SignalspecyulewalkerPoint, b : SignalspecyulewalkerPoint) -> SignalspecyulewalkerPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_spec_yule_walker_point_norm(pt : SignalspecyulewalkerPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_spec_yule_walker_point_normalize(pt : SignalspecyulewalkerPoint) -> SignalspecyulewalkerPoint {
  let n = signal_spec_yule_walker_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_spec_yule_walker_point_scale(pt, 1.0 / n) }
}

pub fn signal_spec_yule_walker_point_negate(pt : SignalspecyulewalkerPoint) -> SignalspecyulewalkerPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_spec_yule_walker_point_mid(a : SignalspecyulewalkerPoint, b : SignalspecyulewalkerPoint) -> SignalspecyulewalkerPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_spec_yule_walker_point_lerp(a : SignalspecyulewalkerPoint, b : SignalspecyulewalkerPoint, t : Double) -> SignalspecyulewalkerPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_spec_yule_walker_point_to_string(pt : SignalspecyulewalkerPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_yule_walker_make_series(vals : Array[Double], name : String) -> SignalspecyulewalkerSeries {
  { vals, name, meta: 0 }
}

pub fn signal_spec_yule_walker_series_len(s : SignalspecyulewalkerSeries) -> Int { s.vals.length() }

pub fn signal_spec_yule_walker_series_sum(s : SignalspecyulewalkerSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn signal_spec_yule_walker_series_mean(s : SignalspecyulewalkerSeries) -> Double {
  let n = signal_spec_yule_walker_series_len(s)
  if n == 0 { 0.0 } else { signal_spec_yule_walker_series_sum(s) / n.to_double() }
}

pub fn signal_spec_yule_walker_series_min(s : SignalspecyulewalkerSeries) -> Double {
  let n = signal_spec_yule_walker_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_series_max(s : SignalspecyulewalkerSeries) -> Double {
  let n = signal_spec_yule_walker_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_series_range(s : SignalspecyulewalkerSeries) -> Double {
  signal_spec_yule_walker_series_max(s) - signal_spec_yule_walker_series_min(s)
}

pub fn signal_spec_yule_walker_series_var(s : SignalspecyulewalkerSeries) -> Double {
  let n = signal_spec_yule_walker_series_len(s)
  if n == 0 { 0.0 } else {
    let m = signal_spec_yule_walker_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn signal_spec_yule_walker_series_std(s : SignalspecyulewalkerSeries) -> Double { @_common.sqrt(signal_spec_yule_walker_series_var(s)) }

pub fn signal_spec_yule_walker_series_median(s : SignalspecyulewalkerSeries) -> Double {
  let n = signal_spec_yule_walker_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = signal_spec_yule_walker_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_spec_yule_walker_series_scale(s : SignalspecyulewalkerSeries, f : Double) -> SignalspecyulewalkerSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_spec_yule_walker_series_add(a : SignalspecyulewalkerSeries, b : SignalspecyulewalkerSeries) -> SignalspecyulewalkerSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_spec_yule_walker_series_sub(a : SignalspecyulewalkerSeries, b : SignalspecyulewalkerSeries) -> SignalspecyulewalkerSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_spec_yule_walker_series_normalize(s : SignalspecyulewalkerSeries) -> SignalspecyulewalkerSeries {
  let mn = signal_spec_yule_walker_series_min(s)
  let mx = signal_spec_yule_walker_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_spec_yule_walker_series_cumsum(s : SignalspecyulewalkerSeries) -> SignalspecyulewalkerSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_spec_yule_walker_series_to_string(s : SignalspecyulewalkerSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecyulewalkerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_yule_walker_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecyulewalkerMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_yule_walker_matrix_identity(n : Int) -> SignalspecyulewalkerMatrix {
  let m = signal_spec_yule_walker_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_spec_yule_walker_matrix_get(m : SignalspecyulewalkerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_spec_yule_walker_matrix_transpose(m : SignalspecyulewalkerMatrix) -> SignalspecyulewalkerMatrix {
  let result = signal_spec_yule_walker_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_spec_yule_walker_matrix_add(a : SignalspecyulewalkerMatrix, b : SignalspecyulewalkerMatrix) -> SignalspecyulewalkerMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_spec_yule_walker_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_spec_yule_walker_matrix_scale(m : SignalspecyulewalkerMatrix, s : Double) -> SignalspecyulewalkerMatrix {
  let result = signal_spec_yule_walker_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_spec_yule_walker_matrix_multiply(a : SignalspecyulewalkerMatrix, b : SignalspecyulewalkerMatrix) -> SignalspecyulewalkerMatrix {
  if a.cols != b.rows { return signal_spec_yule_walker_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_spec_yule_walker_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_spec_yule_walker_matrix_trace(m : SignalspecyulewalkerMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_spec_yule_walker_matrix_det(m : SignalspecyulewalkerMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_spec_yule_walker_matrix_norm(m : SignalspecyulewalkerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_spec_yule_walker_matrix_to_string(m : SignalspecyulewalkerMatrix) -> String {
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

pub(all) struct SignalspecyulewalkerVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_yule_walker_make_vector(comps : Array[Double]) -> SignalspecyulewalkerVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_yule_walker_vector_zero(dim : Int) -> SignalspecyulewalkerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_spec_yule_walker_vector_add(a : SignalspecyulewalkerVector, b : SignalspecyulewalkerVector) -> SignalspecyulewalkerVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_spec_yule_walker_vector_sub(a : SignalspecyulewalkerVector, b : SignalspecyulewalkerVector) -> SignalspecyulewalkerVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_spec_yule_walker_vector_scale(v : SignalspecyulewalkerVector, s : Double) -> SignalspecyulewalkerVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_spec_yule_walker_vector_dot(a : SignalspecyulewalkerVector, b : SignalspecyulewalkerVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_spec_yule_walker_vector_norm(v : SignalspecyulewalkerVector) -> Double { @_common.sqrt(signal_spec_yule_walker_vector_dot(v, v)) }

pub fn signal_spec_yule_walker_vector_normalize(v : SignalspecyulewalkerVector) -> SignalspecyulewalkerVector {
  let n = signal_spec_yule_walker_vector_norm(v)
  if n < 0.0000001 { v } else { signal_spec_yule_walker_vector_scale(v, 1.0 / n) }
}

pub fn signal_spec_yule_walker_vector_dist(a : SignalspecyulewalkerVector, b : SignalspecyulewalkerVector) -> Double {
  signal_spec_yule_walker_vector_norm(signal_spec_yule_walker_vector_sub(a, b))
}

pub fn signal_spec_yule_walker_vector_to_string(v : SignalspecyulewalkerVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_spec_yule_walker_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn signal_spec_yule_walker_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = signal_spec_yule_walker_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_spec_yule_walker_std(data : Array[Double]) -> Double { @_common.sqrt(signal_spec_yule_walker_var(data)) }

pub fn signal_spec_yule_walker_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = signal_spec_yule_walker_mean(a); let mb = signal_spec_yule_walker_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn signal_spec_yule_walker_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = signal_spec_yule_walker_std(a); let sb = signal_spec_yule_walker_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { signal_spec_yule_walker_cov(a, b) / (sa * sb) }
}

pub fn signal_spec_yule_walker_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = signal_spec_yule_walker_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_spec_yule_walker_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn signal_spec_yule_walker_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_spec_yule_walker_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(signal_spec_yule_walker_mse(pred, labels))
}

pub fn signal_spec_yule_walker_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn signal_spec_yule_walker_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = signal_spec_yule_walker_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn signal_spec_yule_walker_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn signal_spec_yule_walker_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn signal_spec_yule_walker_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = signal_spec_yule_walker_precision(pred, labels, pos); let r = signal_spec_yule_walker_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn signal_spec_yule_walker_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn signal_spec_yule_walker_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = signal_spec_yule_walker_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn signal_spec_yule_walker_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn signal_spec_yule_walker_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn signal_spec_yule_walker_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = signal_spec_yule_walker_gcd(a, b)
    (a / g) * b
  }
}

pub fn signal_spec_yule_walker_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn signal_spec_yule_walker_fibonacci(n : Int) -> Int {
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

pub fn signal_spec_yule_walker_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = signal_spec_yule_walker_min(data); let mx = signal_spec_yule_walker_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn signal_spec_yule_walker_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = signal_spec_yule_walker_mean(data); let sd = signal_spec_yule_walker_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn signal_spec_yule_walker_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn signal_spec_yule_walker_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn signal_spec_yule_walker_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn signal_spec_yule_walker_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct SignalspecyulewalkerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_frame_make(size : Int) -> SignalspecyulewalkerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_frame_len(s : SignalspecyulewalkerFrame) -> Int { s.size }

pub fn signal_spec_yule_walker_frame_get(s : SignalspecyulewalkerFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_frame_set(s : SignalspecyulewalkerFrame, i : Int, v : Double) -> SignalspecyulewalkerFrame {
  let result = signal_spec_yule_walker_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_frame_sum(s : SignalspecyulewalkerFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_yule_walker_frame_mean(s : SignalspecyulewalkerFrame) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_yule_walker_frame_sum(s) / s.size.to_double() }
}

pub fn signal_spec_yule_walker_frame_scale(s : SignalspecyulewalkerFrame, f : Double) -> SignalspecyulewalkerFrame {
  let result = signal_spec_yule_walker_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_yule_walker_frame_add(a : SignalspecyulewalkerFrame, b : SignalspecyulewalkerFrame) -> SignalspecyulewalkerFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_yule_walker_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_yule_walker_frame_copy(s : SignalspecyulewalkerFrame) -> SignalspecyulewalkerFrame {
  let result = signal_spec_yule_walker_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_yule_walker_frame_fill(s : SignalspecyulewalkerFrame, v : Double) -> SignalspecyulewalkerFrame {
  let result = signal_spec_yule_walker_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_frame_min(s : SignalspecyulewalkerFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_frame_max(s : SignalspecyulewalkerFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_frame_to_string(s : SignalspecyulewalkerFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_table_make(size : Int) -> SignalspecyulewalkerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_table_len(s : SignalspecyulewalkerTable) -> Int { s.size }

pub fn signal_spec_yule_walker_table_get(s : SignalspecyulewalkerTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_table_set(s : SignalspecyulewalkerTable, i : Int, v : Double) -> SignalspecyulewalkerTable {
  let result = signal_spec_yule_walker_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_table_sum(s : SignalspecyulewalkerTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_yule_walker_table_mean(s : SignalspecyulewalkerTable) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_yule_walker_table_sum(s) / s.size.to_double() }
}

pub fn signal_spec_yule_walker_table_scale(s : SignalspecyulewalkerTable, f : Double) -> SignalspecyulewalkerTable {
  let result = signal_spec_yule_walker_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_yule_walker_table_add(a : SignalspecyulewalkerTable, b : SignalspecyulewalkerTable) -> SignalspecyulewalkerTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_yule_walker_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_yule_walker_table_copy(s : SignalspecyulewalkerTable) -> SignalspecyulewalkerTable {
  let result = signal_spec_yule_walker_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_yule_walker_table_fill(s : SignalspecyulewalkerTable, v : Double) -> SignalspecyulewalkerTable {
  let result = signal_spec_yule_walker_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_table_min(s : SignalspecyulewalkerTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_table_max(s : SignalspecyulewalkerTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_table_to_string(s : SignalspecyulewalkerTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_graphn_make(size : Int) -> SignalspecyulewalkerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_graphn_len(s : SignalspecyulewalkerGraphN) -> Int { s.size }

pub fn signal_spec_yule_walker_graphn_get(s : SignalspecyulewalkerGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_graphn_set(s : SignalspecyulewalkerGraphN, i : Int, v : Double) -> SignalspecyulewalkerGraphN {
  let result = signal_spec_yule_walker_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_graphn_sum(s : SignalspecyulewalkerGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_yule_walker_graphn_mean(s : SignalspecyulewalkerGraphN) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_yule_walker_graphn_sum(s) / s.size.to_double() }
}

pub fn signal_spec_yule_walker_graphn_scale(s : SignalspecyulewalkerGraphN, f : Double) -> SignalspecyulewalkerGraphN {
  let result = signal_spec_yule_walker_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_yule_walker_graphn_add(a : SignalspecyulewalkerGraphN, b : SignalspecyulewalkerGraphN) -> SignalspecyulewalkerGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_yule_walker_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_yule_walker_graphn_copy(s : SignalspecyulewalkerGraphN) -> SignalspecyulewalkerGraphN {
  let result = signal_spec_yule_walker_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_yule_walker_graphn_fill(s : SignalspecyulewalkerGraphN, v : Double) -> SignalspecyulewalkerGraphN {
  let result = signal_spec_yule_walker_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_graphn_min(s : SignalspecyulewalkerGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_graphn_max(s : SignalspecyulewalkerGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_graphn_to_string(s : SignalspecyulewalkerGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_node_make(size : Int) -> SignalspecyulewalkerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_node_len(s : SignalspecyulewalkerNode) -> Int { s.size }

pub fn signal_spec_yule_walker_node_get(s : SignalspecyulewalkerNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_node_set(s : SignalspecyulewalkerNode, i : Int, v : Double) -> SignalspecyulewalkerNode {
  let result = signal_spec_yule_walker_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_node_sum(s : SignalspecyulewalkerNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_yule_walker_node_mean(s : SignalspecyulewalkerNode) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_yule_walker_node_sum(s) / s.size.to_double() }
}

pub fn signal_spec_yule_walker_node_scale(s : SignalspecyulewalkerNode, f : Double) -> SignalspecyulewalkerNode {
  let result = signal_spec_yule_walker_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_yule_walker_node_add(a : SignalspecyulewalkerNode, b : SignalspecyulewalkerNode) -> SignalspecyulewalkerNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_yule_walker_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_yule_walker_node_copy(s : SignalspecyulewalkerNode) -> SignalspecyulewalkerNode {
  let result = signal_spec_yule_walker_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_yule_walker_node_fill(s : SignalspecyulewalkerNode, v : Double) -> SignalspecyulewalkerNode {
  let result = signal_spec_yule_walker_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_node_min(s : SignalspecyulewalkerNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_node_max(s : SignalspecyulewalkerNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_node_to_string(s : SignalspecyulewalkerNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_edge_make(size : Int) -> SignalspecyulewalkerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_edge_len(s : SignalspecyulewalkerEdge) -> Int { s.size }

pub fn signal_spec_yule_walker_edge_get(s : SignalspecyulewalkerEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_edge_set(s : SignalspecyulewalkerEdge, i : Int, v : Double) -> SignalspecyulewalkerEdge {
  let result = signal_spec_yule_walker_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_edge_sum(s : SignalspecyulewalkerEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_yule_walker_edge_mean(s : SignalspecyulewalkerEdge) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_yule_walker_edge_sum(s) / s.size.to_double() }
}

pub fn signal_spec_yule_walker_edge_scale(s : SignalspecyulewalkerEdge, f : Double) -> SignalspecyulewalkerEdge {
  let result = signal_spec_yule_walker_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_yule_walker_edge_add(a : SignalspecyulewalkerEdge, b : SignalspecyulewalkerEdge) -> SignalspecyulewalkerEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_yule_walker_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_yule_walker_edge_copy(s : SignalspecyulewalkerEdge) -> SignalspecyulewalkerEdge {
  let result = signal_spec_yule_walker_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_yule_walker_edge_fill(s : SignalspecyulewalkerEdge, v : Double) -> SignalspecyulewalkerEdge {
  let result = signal_spec_yule_walker_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_edge_min(s : SignalspecyulewalkerEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_edge_max(s : SignalspecyulewalkerEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_edge_to_string(s : SignalspecyulewalkerEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_path_make(size : Int) -> SignalspecyulewalkerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_path_len(s : SignalspecyulewalkerPath) -> Int { s.size }

pub fn signal_spec_yule_walker_path_get(s : SignalspecyulewalkerPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_path_set(s : SignalspecyulewalkerPath, i : Int, v : Double) -> SignalspecyulewalkerPath {
  let result = signal_spec_yule_walker_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_path_sum(s : SignalspecyulewalkerPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_yule_walker_path_mean(s : SignalspecyulewalkerPath) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_yule_walker_path_sum(s) / s.size.to_double() }
}

pub fn signal_spec_yule_walker_path_scale(s : SignalspecyulewalkerPath, f : Double) -> SignalspecyulewalkerPath {
  let result = signal_spec_yule_walker_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_yule_walker_path_add(a : SignalspecyulewalkerPath, b : SignalspecyulewalkerPath) -> SignalspecyulewalkerPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_yule_walker_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_yule_walker_path_copy(s : SignalspecyulewalkerPath) -> SignalspecyulewalkerPath {
  let result = signal_spec_yule_walker_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_yule_walker_path_fill(s : SignalspecyulewalkerPath, v : Double) -> SignalspecyulewalkerPath {
  let result = signal_spec_yule_walker_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_path_min(s : SignalspecyulewalkerPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_path_max(s : SignalspecyulewalkerPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_path_to_string(s : SignalspecyulewalkerPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_cluster_make(size : Int) -> SignalspecyulewalkerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_cluster_len(s : SignalspecyulewalkerCluster) -> Int { s.size }

pub fn signal_spec_yule_walker_cluster_get(s : SignalspecyulewalkerCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_cluster_set(s : SignalspecyulewalkerCluster, i : Int, v : Double) -> SignalspecyulewalkerCluster {
  let result = signal_spec_yule_walker_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_cluster_sum(s : SignalspecyulewalkerCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_yule_walker_cluster_mean(s : SignalspecyulewalkerCluster) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_yule_walker_cluster_sum(s) / s.size.to_double() }
}

pub fn signal_spec_yule_walker_cluster_scale(s : SignalspecyulewalkerCluster, f : Double) -> SignalspecyulewalkerCluster {
  let result = signal_spec_yule_walker_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_yule_walker_cluster_add(a : SignalspecyulewalkerCluster, b : SignalspecyulewalkerCluster) -> SignalspecyulewalkerCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_yule_walker_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_yule_walker_cluster_copy(s : SignalspecyulewalkerCluster) -> SignalspecyulewalkerCluster {
  let result = signal_spec_yule_walker_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_yule_walker_cluster_fill(s : SignalspecyulewalkerCluster, v : Double) -> SignalspecyulewalkerCluster {
  let result = signal_spec_yule_walker_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_cluster_min(s : SignalspecyulewalkerCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_cluster_max(s : SignalspecyulewalkerCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_cluster_to_string(s : SignalspecyulewalkerCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_model_make(size : Int) -> SignalspecyulewalkerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_model_len(s : SignalspecyulewalkerModel) -> Int { s.size }

pub fn signal_spec_yule_walker_model_get(s : SignalspecyulewalkerModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_model_set(s : SignalspecyulewalkerModel, i : Int, v : Double) -> SignalspecyulewalkerModel {
  let result = signal_spec_yule_walker_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_model_sum(s : SignalspecyulewalkerModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_yule_walker_model_mean(s : SignalspecyulewalkerModel) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_yule_walker_model_sum(s) / s.size.to_double() }
}

pub fn signal_spec_yule_walker_model_scale(s : SignalspecyulewalkerModel, f : Double) -> SignalspecyulewalkerModel {
  let result = signal_spec_yule_walker_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_yule_walker_model_add(a : SignalspecyulewalkerModel, b : SignalspecyulewalkerModel) -> SignalspecyulewalkerModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_yule_walker_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_yule_walker_model_copy(s : SignalspecyulewalkerModel) -> SignalspecyulewalkerModel {
  let result = signal_spec_yule_walker_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_yule_walker_model_fill(s : SignalspecyulewalkerModel, v : Double) -> SignalspecyulewalkerModel {
  let result = signal_spec_yule_walker_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_model_min(s : SignalspecyulewalkerModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_model_max(s : SignalspecyulewalkerModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_model_to_string(s : SignalspecyulewalkerModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_layer_make(size : Int) -> SignalspecyulewalkerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_layer_len(s : SignalspecyulewalkerLayer) -> Int { s.size }

pub fn signal_spec_yule_walker_layer_get(s : SignalspecyulewalkerLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_layer_set(s : SignalspecyulewalkerLayer, i : Int, v : Double) -> SignalspecyulewalkerLayer {
  let result = signal_spec_yule_walker_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_layer_sum(s : SignalspecyulewalkerLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_yule_walker_layer_mean(s : SignalspecyulewalkerLayer) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_yule_walker_layer_sum(s) / s.size.to_double() }
}

pub fn signal_spec_yule_walker_layer_scale(s : SignalspecyulewalkerLayer, f : Double) -> SignalspecyulewalkerLayer {
  let result = signal_spec_yule_walker_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_yule_walker_layer_add(a : SignalspecyulewalkerLayer, b : SignalspecyulewalkerLayer) -> SignalspecyulewalkerLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_yule_walker_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_yule_walker_layer_copy(s : SignalspecyulewalkerLayer) -> SignalspecyulewalkerLayer {
  let result = signal_spec_yule_walker_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_yule_walker_layer_fill(s : SignalspecyulewalkerLayer, v : Double) -> SignalspecyulewalkerLayer {
  let result = signal_spec_yule_walker_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_layer_min(s : SignalspecyulewalkerLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_layer_max(s : SignalspecyulewalkerLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_layer_to_string(s : SignalspecyulewalkerLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_buffer_make(size : Int) -> SignalspecyulewalkerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_buffer_len(s : SignalspecyulewalkerBuffer) -> Int { s.size }

pub fn signal_spec_yule_walker_buffer_get(s : SignalspecyulewalkerBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_buffer_set(s : SignalspecyulewalkerBuffer, i : Int, v : Double) -> SignalspecyulewalkerBuffer {
  let result = signal_spec_yule_walker_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_buffer_sum(s : SignalspecyulewalkerBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_yule_walker_buffer_mean(s : SignalspecyulewalkerBuffer) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_yule_walker_buffer_sum(s) / s.size.to_double() }
}

pub fn signal_spec_yule_walker_buffer_scale(s : SignalspecyulewalkerBuffer, f : Double) -> SignalspecyulewalkerBuffer {
  let result = signal_spec_yule_walker_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_yule_walker_buffer_add(a : SignalspecyulewalkerBuffer, b : SignalspecyulewalkerBuffer) -> SignalspecyulewalkerBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_yule_walker_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_yule_walker_buffer_copy(s : SignalspecyulewalkerBuffer) -> SignalspecyulewalkerBuffer {
  let result = signal_spec_yule_walker_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_yule_walker_buffer_fill(s : SignalspecyulewalkerBuffer, v : Double) -> SignalspecyulewalkerBuffer {
  let result = signal_spec_yule_walker_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_buffer_min(s : SignalspecyulewalkerBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_buffer_max(s : SignalspecyulewalkerBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_buffer_to_string(s : SignalspecyulewalkerBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_cursor_make(size : Int) -> SignalspecyulewalkerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_cursor_len(s : SignalspecyulewalkerCursor) -> Int { s.size }

pub fn signal_spec_yule_walker_cursor_get(s : SignalspecyulewalkerCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_cursor_set(s : SignalspecyulewalkerCursor, i : Int, v : Double) -> SignalspecyulewalkerCursor {
  let result = signal_spec_yule_walker_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_cursor_sum(s : SignalspecyulewalkerCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_yule_walker_cursor_mean(s : SignalspecyulewalkerCursor) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_yule_walker_cursor_sum(s) / s.size.to_double() }
}

pub fn signal_spec_yule_walker_cursor_scale(s : SignalspecyulewalkerCursor, f : Double) -> SignalspecyulewalkerCursor {
  let result = signal_spec_yule_walker_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_yule_walker_cursor_add(a : SignalspecyulewalkerCursor, b : SignalspecyulewalkerCursor) -> SignalspecyulewalkerCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_yule_walker_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_yule_walker_cursor_copy(s : SignalspecyulewalkerCursor) -> SignalspecyulewalkerCursor {
  let result = signal_spec_yule_walker_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_yule_walker_cursor_fill(s : SignalspecyulewalkerCursor, v : Double) -> SignalspecyulewalkerCursor {
  let result = signal_spec_yule_walker_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_cursor_min(s : SignalspecyulewalkerCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_cursor_max(s : SignalspecyulewalkerCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_cursor_to_string(s : SignalspecyulewalkerCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_view_make(size : Int) -> SignalspecyulewalkerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_view_len(s : SignalspecyulewalkerView) -> Int { s.size }

pub fn signal_spec_yule_walker_view_get(s : SignalspecyulewalkerView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_view_set(s : SignalspecyulewalkerView, i : Int, v : Double) -> SignalspecyulewalkerView {
  let result = signal_spec_yule_walker_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_view_sum(s : SignalspecyulewalkerView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_yule_walker_view_mean(s : SignalspecyulewalkerView) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_yule_walker_view_sum(s) / s.size.to_double() }
}

pub fn signal_spec_yule_walker_view_scale(s : SignalspecyulewalkerView, f : Double) -> SignalspecyulewalkerView {
  let result = signal_spec_yule_walker_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_yule_walker_view_add(a : SignalspecyulewalkerView, b : SignalspecyulewalkerView) -> SignalspecyulewalkerView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_yule_walker_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_yule_walker_view_copy(s : SignalspecyulewalkerView) -> SignalspecyulewalkerView {
  let result = signal_spec_yule_walker_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_yule_walker_view_fill(s : SignalspecyulewalkerView, v : Double) -> SignalspecyulewalkerView {
  let result = signal_spec_yule_walker_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_view_min(s : SignalspecyulewalkerView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_view_max(s : SignalspecyulewalkerView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_view_to_string(s : SignalspecyulewalkerView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_range_make(size : Int) -> SignalspecyulewalkerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_range_len(s : SignalspecyulewalkerRange) -> Int { s.size }

pub fn signal_spec_yule_walker_range_get(s : SignalspecyulewalkerRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_range_set(s : SignalspecyulewalkerRange, i : Int, v : Double) -> SignalspecyulewalkerRange {
  let result = signal_spec_yule_walker_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_range_sum(s : SignalspecyulewalkerRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_yule_walker_range_mean(s : SignalspecyulewalkerRange) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_yule_walker_range_sum(s) / s.size.to_double() }
}

pub fn signal_spec_yule_walker_range_scale(s : SignalspecyulewalkerRange, f : Double) -> SignalspecyulewalkerRange {
  let result = signal_spec_yule_walker_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_yule_walker_range_add(a : SignalspecyulewalkerRange, b : SignalspecyulewalkerRange) -> SignalspecyulewalkerRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_yule_walker_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_yule_walker_range_copy(s : SignalspecyulewalkerRange) -> SignalspecyulewalkerRange {
  let result = signal_spec_yule_walker_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_yule_walker_range_fill(s : SignalspecyulewalkerRange, v : Double) -> SignalspecyulewalkerRange {
  let result = signal_spec_yule_walker_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_range_min(s : SignalspecyulewalkerRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_range_max(s : SignalspecyulewalkerRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_range_to_string(s : SignalspecyulewalkerRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_slice_make(size : Int) -> SignalspecyulewalkerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_slice_len(s : SignalspecyulewalkerSlice) -> Int { s.size }

pub fn signal_spec_yule_walker_slice_get(s : SignalspecyulewalkerSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_slice_set(s : SignalspecyulewalkerSlice, i : Int, v : Double) -> SignalspecyulewalkerSlice {
  let result = signal_spec_yule_walker_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_slice_sum(s : SignalspecyulewalkerSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_yule_walker_slice_mean(s : SignalspecyulewalkerSlice) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_yule_walker_slice_sum(s) / s.size.to_double() }
}

pub fn signal_spec_yule_walker_slice_scale(s : SignalspecyulewalkerSlice, f : Double) -> SignalspecyulewalkerSlice {
  let result = signal_spec_yule_walker_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_yule_walker_slice_add(a : SignalspecyulewalkerSlice, b : SignalspecyulewalkerSlice) -> SignalspecyulewalkerSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_yule_walker_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_yule_walker_slice_copy(s : SignalspecyulewalkerSlice) -> SignalspecyulewalkerSlice {
  let result = signal_spec_yule_walker_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_yule_walker_slice_fill(s : SignalspecyulewalkerSlice, v : Double) -> SignalspecyulewalkerSlice {
  let result = signal_spec_yule_walker_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_yule_walker_slice_min(s : SignalspecyulewalkerSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_slice_max(s : SignalspecyulewalkerSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_yule_walker_slice_to_string(s : SignalspecyulewalkerSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

