///===
/// extcore/signal_filter_median

pub(all) struct SignalfiltermedianPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_median_make_point(x : Double, y : Double) -> SignalfiltermedianPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_median_make_point3(x : Double, y : Double, z : Double) -> SignalfiltermedianPoint {
  { x, y, z, label: 0 }
}

pub fn signal_filter_median_point_x(pt : SignalfiltermedianPoint) -> Double { pt.x }

pub fn signal_filter_median_point_y(pt : SignalfiltermedianPoint) -> Double { pt.y }

pub fn signal_filter_median_point_z(pt : SignalfiltermedianPoint) -> Double { pt.z }

pub fn signal_filter_median_point_label(pt : SignalfiltermedianPoint) -> Int { pt.label }

pub fn signal_filter_median_point_dist(a : SignalfiltermedianPoint, b : SignalfiltermedianPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_filter_median_point_add(a : SignalfiltermedianPoint, b : SignalfiltermedianPoint) -> SignalfiltermedianPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_filter_median_point_sub(a : SignalfiltermedianPoint, b : SignalfiltermedianPoint) -> SignalfiltermedianPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_filter_median_point_scale(pt : SignalfiltermedianPoint, s : Double) -> SignalfiltermedianPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_filter_median_point_dot(a : SignalfiltermedianPoint, b : SignalfiltermedianPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_filter_median_point_cross(a : SignalfiltermedianPoint, b : SignalfiltermedianPoint) -> SignalfiltermedianPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_filter_median_point_norm(pt : SignalfiltermedianPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_filter_median_point_normalize(pt : SignalfiltermedianPoint) -> SignalfiltermedianPoint {
  let n = signal_filter_median_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_filter_median_point_scale(pt, 1.0 / n) }
}

pub fn signal_filter_median_point_negate(pt : SignalfiltermedianPoint) -> SignalfiltermedianPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_filter_median_point_mid(a : SignalfiltermedianPoint, b : SignalfiltermedianPoint) -> SignalfiltermedianPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_filter_median_point_lerp(a : SignalfiltermedianPoint, b : SignalfiltermedianPoint, t : Double) -> SignalfiltermedianPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_filter_median_point_to_string(pt : SignalfiltermedianPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalfiltermedianSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_median_make_series(vals : Array[Double], name : String) -> SignalfiltermedianSeries {
  { vals, name, meta: 0 }
}

pub fn signal_filter_median_series_len(s : SignalfiltermedianSeries) -> Int { s.vals.length() }

pub fn signal_filter_median_series_sum(s : SignalfiltermedianSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn signal_filter_median_series_mean(s : SignalfiltermedianSeries) -> Double {
  let n = signal_filter_median_series_len(s)
  if n == 0 { 0.0 } else { signal_filter_median_series_sum(s) / n.to_double() }
}

pub fn signal_filter_median_series_min(s : SignalfiltermedianSeries) -> Double {
  let n = signal_filter_median_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn signal_filter_median_series_max(s : SignalfiltermedianSeries) -> Double {
  let n = signal_filter_median_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn signal_filter_median_series_range(s : SignalfiltermedianSeries) -> Double {
  signal_filter_median_series_max(s) - signal_filter_median_series_min(s)
}

pub fn signal_filter_median_series_var(s : SignalfiltermedianSeries) -> Double {
  let n = signal_filter_median_series_len(s)
  if n == 0 { 0.0 } else {
    let m = signal_filter_median_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn signal_filter_median_series_std(s : SignalfiltermedianSeries) -> Double { @_common.sqrt(signal_filter_median_series_var(s)) }

pub fn signal_filter_median_series_median(s : SignalfiltermedianSeries) -> Double {
  let n = signal_filter_median_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = signal_filter_median_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_filter_median_series_scale(s : SignalfiltermedianSeries, f : Double) -> SignalfiltermedianSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_filter_median_series_add(a : SignalfiltermedianSeries, b : SignalfiltermedianSeries) -> SignalfiltermedianSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_filter_median_series_sub(a : SignalfiltermedianSeries, b : SignalfiltermedianSeries) -> SignalfiltermedianSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_filter_median_series_normalize(s : SignalfiltermedianSeries) -> SignalfiltermedianSeries {
  let mn = signal_filter_median_series_min(s)
  let mx = signal_filter_median_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_filter_median_series_cumsum(s : SignalfiltermedianSeries) -> SignalfiltermedianSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_filter_median_series_to_string(s : SignalfiltermedianSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfiltermedianMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_median_make_matrix(rows : Int, cols : Int, val : Double) -> SignalfiltermedianMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_median_matrix_identity(n : Int) -> SignalfiltermedianMatrix {
  let m = signal_filter_median_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_filter_median_matrix_get(m : SignalfiltermedianMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_filter_median_matrix_transpose(m : SignalfiltermedianMatrix) -> SignalfiltermedianMatrix {
  let result = signal_filter_median_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_filter_median_matrix_add(a : SignalfiltermedianMatrix, b : SignalfiltermedianMatrix) -> SignalfiltermedianMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_filter_median_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_filter_median_matrix_scale(m : SignalfiltermedianMatrix, s : Double) -> SignalfiltermedianMatrix {
  let result = signal_filter_median_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_filter_median_matrix_multiply(a : SignalfiltermedianMatrix, b : SignalfiltermedianMatrix) -> SignalfiltermedianMatrix {
  if a.cols != b.rows { return signal_filter_median_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_filter_median_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_filter_median_matrix_trace(m : SignalfiltermedianMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_filter_median_matrix_det(m : SignalfiltermedianMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_filter_median_matrix_norm(m : SignalfiltermedianMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_filter_median_matrix_to_string(m : SignalfiltermedianMatrix) -> String {
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

pub(all) struct SignalfiltermedianVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_median_make_vector(comps : Array[Double]) -> SignalfiltermedianVector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_median_vector_zero(dim : Int) -> SignalfiltermedianVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_filter_median_vector_add(a : SignalfiltermedianVector, b : SignalfiltermedianVector) -> SignalfiltermedianVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_filter_median_vector_sub(a : SignalfiltermedianVector, b : SignalfiltermedianVector) -> SignalfiltermedianVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_filter_median_vector_scale(v : SignalfiltermedianVector, s : Double) -> SignalfiltermedianVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_filter_median_vector_dot(a : SignalfiltermedianVector, b : SignalfiltermedianVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_filter_median_vector_norm(v : SignalfiltermedianVector) -> Double { @_common.sqrt(signal_filter_median_vector_dot(v, v)) }

pub fn signal_filter_median_vector_normalize(v : SignalfiltermedianVector) -> SignalfiltermedianVector {
  let n = signal_filter_median_vector_norm(v)
  if n < 0.0000001 { v } else { signal_filter_median_vector_scale(v, 1.0 / n) }
}

pub fn signal_filter_median_vector_dist(a : SignalfiltermedianVector, b : SignalfiltermedianVector) -> Double {
  signal_filter_median_vector_norm(signal_filter_median_vector_sub(a, b))
}

pub fn signal_filter_median_vector_to_string(v : SignalfiltermedianVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_filter_median_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn signal_filter_median_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = signal_filter_median_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_filter_median_std(data : Array[Double]) -> Double { @_common.sqrt(signal_filter_median_var(data)) }

pub fn signal_filter_median_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = signal_filter_median_mean(a); let mb = signal_filter_median_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn signal_filter_median_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = signal_filter_median_std(a); let sb = signal_filter_median_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { signal_filter_median_cov(a, b) / (sa * sb) }
}

pub fn signal_filter_median_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = signal_filter_median_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_filter_median_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn signal_filter_median_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_filter_median_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(signal_filter_median_mse(pred, labels))
}

pub fn signal_filter_median_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn signal_filter_median_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = signal_filter_median_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn signal_filter_median_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn signal_filter_median_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn signal_filter_median_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = signal_filter_median_precision(pred, labels, pos); let r = signal_filter_median_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn signal_filter_median_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn signal_filter_median_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = signal_filter_median_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn signal_filter_median_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn signal_filter_median_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn signal_filter_median_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = signal_filter_median_gcd(a, b)
    (a / g) * b
  }
}

pub fn signal_filter_median_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn signal_filter_median_fibonacci(n : Int) -> Int {
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

pub fn signal_filter_median_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = signal_filter_median_min(data); let mx = signal_filter_median_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn signal_filter_median_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = signal_filter_median_mean(data); let sd = signal_filter_median_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn signal_filter_median_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn signal_filter_median_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn signal_filter_median_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn signal_filter_median_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn signal_filter_median_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn signal_filter_median_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct SignalfiltermedianFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_frame_make(size : Int) -> SignalfiltermedianFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_frame_len(s : SignalfiltermedianFrame) -> Int { s.size }

pub fn signal_filter_median_frame_get(s : SignalfiltermedianFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_frame_set(s : SignalfiltermedianFrame, i : Int, v : Double) -> SignalfiltermedianFrame {
  let result = signal_filter_median_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_frame_sum(s : SignalfiltermedianFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_median_frame_mean(s : SignalfiltermedianFrame) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_median_frame_sum(s) / s.size.to_double() }
}

pub fn signal_filter_median_frame_scale(s : SignalfiltermedianFrame, f : Double) -> SignalfiltermedianFrame {
  let result = signal_filter_median_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_median_frame_add(a : SignalfiltermedianFrame, b : SignalfiltermedianFrame) -> SignalfiltermedianFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_median_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_median_frame_copy(s : SignalfiltermedianFrame) -> SignalfiltermedianFrame {
  let result = signal_filter_median_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_median_frame_fill(s : SignalfiltermedianFrame, v : Double) -> SignalfiltermedianFrame {
  let result = signal_filter_median_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_frame_min(s : SignalfiltermedianFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_frame_max(s : SignalfiltermedianFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_frame_to_string(s : SignalfiltermedianFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_table_make(size : Int) -> SignalfiltermedianTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_table_len(s : SignalfiltermedianTable) -> Int { s.size }

pub fn signal_filter_median_table_get(s : SignalfiltermedianTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_table_set(s : SignalfiltermedianTable, i : Int, v : Double) -> SignalfiltermedianTable {
  let result = signal_filter_median_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_table_sum(s : SignalfiltermedianTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_median_table_mean(s : SignalfiltermedianTable) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_median_table_sum(s) / s.size.to_double() }
}

pub fn signal_filter_median_table_scale(s : SignalfiltermedianTable, f : Double) -> SignalfiltermedianTable {
  let result = signal_filter_median_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_median_table_add(a : SignalfiltermedianTable, b : SignalfiltermedianTable) -> SignalfiltermedianTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_median_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_median_table_copy(s : SignalfiltermedianTable) -> SignalfiltermedianTable {
  let result = signal_filter_median_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_median_table_fill(s : SignalfiltermedianTable, v : Double) -> SignalfiltermedianTable {
  let result = signal_filter_median_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_table_min(s : SignalfiltermedianTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_table_max(s : SignalfiltermedianTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_table_to_string(s : SignalfiltermedianTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_graphn_make(size : Int) -> SignalfiltermedianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_graphn_len(s : SignalfiltermedianGraphN) -> Int { s.size }

pub fn signal_filter_median_graphn_get(s : SignalfiltermedianGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_graphn_set(s : SignalfiltermedianGraphN, i : Int, v : Double) -> SignalfiltermedianGraphN {
  let result = signal_filter_median_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_graphn_sum(s : SignalfiltermedianGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_median_graphn_mean(s : SignalfiltermedianGraphN) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_median_graphn_sum(s) / s.size.to_double() }
}

pub fn signal_filter_median_graphn_scale(s : SignalfiltermedianGraphN, f : Double) -> SignalfiltermedianGraphN {
  let result = signal_filter_median_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_median_graphn_add(a : SignalfiltermedianGraphN, b : SignalfiltermedianGraphN) -> SignalfiltermedianGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_median_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_median_graphn_copy(s : SignalfiltermedianGraphN) -> SignalfiltermedianGraphN {
  let result = signal_filter_median_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_median_graphn_fill(s : SignalfiltermedianGraphN, v : Double) -> SignalfiltermedianGraphN {
  let result = signal_filter_median_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_graphn_min(s : SignalfiltermedianGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_graphn_max(s : SignalfiltermedianGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_graphn_to_string(s : SignalfiltermedianGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_node_make(size : Int) -> SignalfiltermedianNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_node_len(s : SignalfiltermedianNode) -> Int { s.size }

pub fn signal_filter_median_node_get(s : SignalfiltermedianNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_node_set(s : SignalfiltermedianNode, i : Int, v : Double) -> SignalfiltermedianNode {
  let result = signal_filter_median_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_node_sum(s : SignalfiltermedianNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_median_node_mean(s : SignalfiltermedianNode) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_median_node_sum(s) / s.size.to_double() }
}

pub fn signal_filter_median_node_scale(s : SignalfiltermedianNode, f : Double) -> SignalfiltermedianNode {
  let result = signal_filter_median_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_median_node_add(a : SignalfiltermedianNode, b : SignalfiltermedianNode) -> SignalfiltermedianNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_median_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_median_node_copy(s : SignalfiltermedianNode) -> SignalfiltermedianNode {
  let result = signal_filter_median_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_median_node_fill(s : SignalfiltermedianNode, v : Double) -> SignalfiltermedianNode {
  let result = signal_filter_median_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_node_min(s : SignalfiltermedianNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_node_max(s : SignalfiltermedianNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_node_to_string(s : SignalfiltermedianNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_edge_make(size : Int) -> SignalfiltermedianEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_edge_len(s : SignalfiltermedianEdge) -> Int { s.size }

pub fn signal_filter_median_edge_get(s : SignalfiltermedianEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_edge_set(s : SignalfiltermedianEdge, i : Int, v : Double) -> SignalfiltermedianEdge {
  let result = signal_filter_median_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_edge_sum(s : SignalfiltermedianEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_median_edge_mean(s : SignalfiltermedianEdge) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_median_edge_sum(s) / s.size.to_double() }
}

pub fn signal_filter_median_edge_scale(s : SignalfiltermedianEdge, f : Double) -> SignalfiltermedianEdge {
  let result = signal_filter_median_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_median_edge_add(a : SignalfiltermedianEdge, b : SignalfiltermedianEdge) -> SignalfiltermedianEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_median_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_median_edge_copy(s : SignalfiltermedianEdge) -> SignalfiltermedianEdge {
  let result = signal_filter_median_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_median_edge_fill(s : SignalfiltermedianEdge, v : Double) -> SignalfiltermedianEdge {
  let result = signal_filter_median_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_edge_min(s : SignalfiltermedianEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_edge_max(s : SignalfiltermedianEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_edge_to_string(s : SignalfiltermedianEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_path_make(size : Int) -> SignalfiltermedianPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_path_len(s : SignalfiltermedianPath) -> Int { s.size }

pub fn signal_filter_median_path_get(s : SignalfiltermedianPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_path_set(s : SignalfiltermedianPath, i : Int, v : Double) -> SignalfiltermedianPath {
  let result = signal_filter_median_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_path_sum(s : SignalfiltermedianPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_median_path_mean(s : SignalfiltermedianPath) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_median_path_sum(s) / s.size.to_double() }
}

pub fn signal_filter_median_path_scale(s : SignalfiltermedianPath, f : Double) -> SignalfiltermedianPath {
  let result = signal_filter_median_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_median_path_add(a : SignalfiltermedianPath, b : SignalfiltermedianPath) -> SignalfiltermedianPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_median_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_median_path_copy(s : SignalfiltermedianPath) -> SignalfiltermedianPath {
  let result = signal_filter_median_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_median_path_fill(s : SignalfiltermedianPath, v : Double) -> SignalfiltermedianPath {
  let result = signal_filter_median_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_path_min(s : SignalfiltermedianPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_path_max(s : SignalfiltermedianPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_path_to_string(s : SignalfiltermedianPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_cluster_make(size : Int) -> SignalfiltermedianCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_cluster_len(s : SignalfiltermedianCluster) -> Int { s.size }

pub fn signal_filter_median_cluster_get(s : SignalfiltermedianCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_cluster_set(s : SignalfiltermedianCluster, i : Int, v : Double) -> SignalfiltermedianCluster {
  let result = signal_filter_median_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_cluster_sum(s : SignalfiltermedianCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_median_cluster_mean(s : SignalfiltermedianCluster) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_median_cluster_sum(s) / s.size.to_double() }
}

pub fn signal_filter_median_cluster_scale(s : SignalfiltermedianCluster, f : Double) -> SignalfiltermedianCluster {
  let result = signal_filter_median_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_median_cluster_add(a : SignalfiltermedianCluster, b : SignalfiltermedianCluster) -> SignalfiltermedianCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_median_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_median_cluster_copy(s : SignalfiltermedianCluster) -> SignalfiltermedianCluster {
  let result = signal_filter_median_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_median_cluster_fill(s : SignalfiltermedianCluster, v : Double) -> SignalfiltermedianCluster {
  let result = signal_filter_median_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_cluster_min(s : SignalfiltermedianCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_cluster_max(s : SignalfiltermedianCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_cluster_to_string(s : SignalfiltermedianCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_model_make(size : Int) -> SignalfiltermedianModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_model_len(s : SignalfiltermedianModel) -> Int { s.size }

pub fn signal_filter_median_model_get(s : SignalfiltermedianModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_model_set(s : SignalfiltermedianModel, i : Int, v : Double) -> SignalfiltermedianModel {
  let result = signal_filter_median_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_model_sum(s : SignalfiltermedianModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_median_model_mean(s : SignalfiltermedianModel) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_median_model_sum(s) / s.size.to_double() }
}

pub fn signal_filter_median_model_scale(s : SignalfiltermedianModel, f : Double) -> SignalfiltermedianModel {
  let result = signal_filter_median_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_median_model_add(a : SignalfiltermedianModel, b : SignalfiltermedianModel) -> SignalfiltermedianModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_median_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_median_model_copy(s : SignalfiltermedianModel) -> SignalfiltermedianModel {
  let result = signal_filter_median_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_median_model_fill(s : SignalfiltermedianModel, v : Double) -> SignalfiltermedianModel {
  let result = signal_filter_median_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_model_min(s : SignalfiltermedianModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_model_max(s : SignalfiltermedianModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_model_to_string(s : SignalfiltermedianModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_layer_make(size : Int) -> SignalfiltermedianLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_layer_len(s : SignalfiltermedianLayer) -> Int { s.size }

pub fn signal_filter_median_layer_get(s : SignalfiltermedianLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_layer_set(s : SignalfiltermedianLayer, i : Int, v : Double) -> SignalfiltermedianLayer {
  let result = signal_filter_median_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_layer_sum(s : SignalfiltermedianLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_median_layer_mean(s : SignalfiltermedianLayer) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_median_layer_sum(s) / s.size.to_double() }
}

pub fn signal_filter_median_layer_scale(s : SignalfiltermedianLayer, f : Double) -> SignalfiltermedianLayer {
  let result = signal_filter_median_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_median_layer_add(a : SignalfiltermedianLayer, b : SignalfiltermedianLayer) -> SignalfiltermedianLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_median_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_median_layer_copy(s : SignalfiltermedianLayer) -> SignalfiltermedianLayer {
  let result = signal_filter_median_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_median_layer_fill(s : SignalfiltermedianLayer, v : Double) -> SignalfiltermedianLayer {
  let result = signal_filter_median_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_layer_min(s : SignalfiltermedianLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_layer_max(s : SignalfiltermedianLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_layer_to_string(s : SignalfiltermedianLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_buffer_make(size : Int) -> SignalfiltermedianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_buffer_len(s : SignalfiltermedianBuffer) -> Int { s.size }

pub fn signal_filter_median_buffer_get(s : SignalfiltermedianBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_buffer_set(s : SignalfiltermedianBuffer, i : Int, v : Double) -> SignalfiltermedianBuffer {
  let result = signal_filter_median_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_buffer_sum(s : SignalfiltermedianBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_median_buffer_mean(s : SignalfiltermedianBuffer) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_median_buffer_sum(s) / s.size.to_double() }
}

pub fn signal_filter_median_buffer_scale(s : SignalfiltermedianBuffer, f : Double) -> SignalfiltermedianBuffer {
  let result = signal_filter_median_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_median_buffer_add(a : SignalfiltermedianBuffer, b : SignalfiltermedianBuffer) -> SignalfiltermedianBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_median_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_median_buffer_copy(s : SignalfiltermedianBuffer) -> SignalfiltermedianBuffer {
  let result = signal_filter_median_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_median_buffer_fill(s : SignalfiltermedianBuffer, v : Double) -> SignalfiltermedianBuffer {
  let result = signal_filter_median_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_buffer_min(s : SignalfiltermedianBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_buffer_max(s : SignalfiltermedianBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_buffer_to_string(s : SignalfiltermedianBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_cursor_make(size : Int) -> SignalfiltermedianCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_cursor_len(s : SignalfiltermedianCursor) -> Int { s.size }

pub fn signal_filter_median_cursor_get(s : SignalfiltermedianCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_cursor_set(s : SignalfiltermedianCursor, i : Int, v : Double) -> SignalfiltermedianCursor {
  let result = signal_filter_median_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_cursor_sum(s : SignalfiltermedianCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_median_cursor_mean(s : SignalfiltermedianCursor) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_median_cursor_sum(s) / s.size.to_double() }
}

pub fn signal_filter_median_cursor_scale(s : SignalfiltermedianCursor, f : Double) -> SignalfiltermedianCursor {
  let result = signal_filter_median_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_median_cursor_add(a : SignalfiltermedianCursor, b : SignalfiltermedianCursor) -> SignalfiltermedianCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_median_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_median_cursor_copy(s : SignalfiltermedianCursor) -> SignalfiltermedianCursor {
  let result = signal_filter_median_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_median_cursor_fill(s : SignalfiltermedianCursor, v : Double) -> SignalfiltermedianCursor {
  let result = signal_filter_median_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_cursor_min(s : SignalfiltermedianCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_cursor_max(s : SignalfiltermedianCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_cursor_to_string(s : SignalfiltermedianCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_view_make(size : Int) -> SignalfiltermedianView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_view_len(s : SignalfiltermedianView) -> Int { s.size }

pub fn signal_filter_median_view_get(s : SignalfiltermedianView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_view_set(s : SignalfiltermedianView, i : Int, v : Double) -> SignalfiltermedianView {
  let result = signal_filter_median_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_view_sum(s : SignalfiltermedianView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_median_view_mean(s : SignalfiltermedianView) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_median_view_sum(s) / s.size.to_double() }
}

pub fn signal_filter_median_view_scale(s : SignalfiltermedianView, f : Double) -> SignalfiltermedianView {
  let result = signal_filter_median_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_median_view_add(a : SignalfiltermedianView, b : SignalfiltermedianView) -> SignalfiltermedianView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_median_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_median_view_copy(s : SignalfiltermedianView) -> SignalfiltermedianView {
  let result = signal_filter_median_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_median_view_fill(s : SignalfiltermedianView, v : Double) -> SignalfiltermedianView {
  let result = signal_filter_median_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_view_min(s : SignalfiltermedianView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_view_max(s : SignalfiltermedianView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_view_to_string(s : SignalfiltermedianView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_range_make(size : Int) -> SignalfiltermedianRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_range_len(s : SignalfiltermedianRange) -> Int { s.size }

pub fn signal_filter_median_range_get(s : SignalfiltermedianRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_range_set(s : SignalfiltermedianRange, i : Int, v : Double) -> SignalfiltermedianRange {
  let result = signal_filter_median_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_range_sum(s : SignalfiltermedianRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_median_range_mean(s : SignalfiltermedianRange) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_median_range_sum(s) / s.size.to_double() }
}

pub fn signal_filter_median_range_scale(s : SignalfiltermedianRange, f : Double) -> SignalfiltermedianRange {
  let result = signal_filter_median_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_median_range_add(a : SignalfiltermedianRange, b : SignalfiltermedianRange) -> SignalfiltermedianRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_median_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_median_range_copy(s : SignalfiltermedianRange) -> SignalfiltermedianRange {
  let result = signal_filter_median_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_median_range_fill(s : SignalfiltermedianRange, v : Double) -> SignalfiltermedianRange {
  let result = signal_filter_median_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_range_min(s : SignalfiltermedianRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_range_max(s : SignalfiltermedianRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_range_to_string(s : SignalfiltermedianRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_slice_make(size : Int) -> SignalfiltermedianSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_slice_len(s : SignalfiltermedianSlice) -> Int { s.size }

pub fn signal_filter_median_slice_get(s : SignalfiltermedianSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_slice_set(s : SignalfiltermedianSlice, i : Int, v : Double) -> SignalfiltermedianSlice {
  let result = signal_filter_median_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_slice_sum(s : SignalfiltermedianSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_median_slice_mean(s : SignalfiltermedianSlice) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_median_slice_sum(s) / s.size.to_double() }
}

pub fn signal_filter_median_slice_scale(s : SignalfiltermedianSlice, f : Double) -> SignalfiltermedianSlice {
  let result = signal_filter_median_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_median_slice_add(a : SignalfiltermedianSlice, b : SignalfiltermedianSlice) -> SignalfiltermedianSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_median_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_median_slice_copy(s : SignalfiltermedianSlice) -> SignalfiltermedianSlice {
  let result = signal_filter_median_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_median_slice_fill(s : SignalfiltermedianSlice, v : Double) -> SignalfiltermedianSlice {
  let result = signal_filter_median_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_median_slice_min(s : SignalfiltermedianSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_slice_max(s : SignalfiltermedianSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_median_slice_to_string(s : SignalfiltermedianSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

