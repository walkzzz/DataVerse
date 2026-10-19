///===
/// extcore/finance_pricing_lookback

pub(all) struct FinancepricinglookbackPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_lookback_make_point(x : Double, y : Double) -> FinancepricinglookbackPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_lookback_make_point3(x : Double, y : Double, z : Double) -> FinancepricinglookbackPoint {
  { x, y, z, label: 0 }
}

pub fn finance_pricing_lookback_point_x(pt : FinancepricinglookbackPoint) -> Double { pt.x }

pub fn finance_pricing_lookback_point_y(pt : FinancepricinglookbackPoint) -> Double { pt.y }

pub fn finance_pricing_lookback_point_z(pt : FinancepricinglookbackPoint) -> Double { pt.z }

pub fn finance_pricing_lookback_point_label(pt : FinancepricinglookbackPoint) -> Int { pt.label }

pub fn finance_pricing_lookback_point_dist(a : FinancepricinglookbackPoint, b : FinancepricinglookbackPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_pricing_lookback_point_add(a : FinancepricinglookbackPoint, b : FinancepricinglookbackPoint) -> FinancepricinglookbackPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_pricing_lookback_point_sub(a : FinancepricinglookbackPoint, b : FinancepricinglookbackPoint) -> FinancepricinglookbackPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_pricing_lookback_point_scale(pt : FinancepricinglookbackPoint, s : Double) -> FinancepricinglookbackPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_pricing_lookback_point_dot(a : FinancepricinglookbackPoint, b : FinancepricinglookbackPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_pricing_lookback_point_cross(a : FinancepricinglookbackPoint, b : FinancepricinglookbackPoint) -> FinancepricinglookbackPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_pricing_lookback_point_norm(pt : FinancepricinglookbackPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_pricing_lookback_point_normalize(pt : FinancepricinglookbackPoint) -> FinancepricinglookbackPoint {
  let n = finance_pricing_lookback_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_pricing_lookback_point_scale(pt, 1.0 / n) }
}

pub fn finance_pricing_lookback_point_negate(pt : FinancepricinglookbackPoint) -> FinancepricinglookbackPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_pricing_lookback_point_mid(a : FinancepricinglookbackPoint, b : FinancepricinglookbackPoint) -> FinancepricinglookbackPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_pricing_lookback_point_lerp(a : FinancepricinglookbackPoint, b : FinancepricinglookbackPoint, t : Double) -> FinancepricinglookbackPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_pricing_lookback_point_to_string(pt : FinancepricinglookbackPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancepricinglookbackSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_lookback_make_series(vals : Array[Double], name : String) -> FinancepricinglookbackSeries {
  { vals, name, meta: 0 }
}

pub fn finance_pricing_lookback_series_len(s : FinancepricinglookbackSeries) -> Int { s.vals.length() }

pub fn finance_pricing_lookback_series_sum(s : FinancepricinglookbackSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_pricing_lookback_series_mean(s : FinancepricinglookbackSeries) -> Double {
  let n = finance_pricing_lookback_series_len(s)
  if n == 0 { 0.0 } else { finance_pricing_lookback_series_sum(s) / n.to_double() }
}

pub fn finance_pricing_lookback_series_min(s : FinancepricinglookbackSeries) -> Double {
  let n = finance_pricing_lookback_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_pricing_lookback_series_max(s : FinancepricinglookbackSeries) -> Double {
  let n = finance_pricing_lookback_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_pricing_lookback_series_range(s : FinancepricinglookbackSeries) -> Double {
  finance_pricing_lookback_series_max(s) - finance_pricing_lookback_series_min(s)
}

pub fn finance_pricing_lookback_series_var(s : FinancepricinglookbackSeries) -> Double {
  let n = finance_pricing_lookback_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_pricing_lookback_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_pricing_lookback_series_std(s : FinancepricinglookbackSeries) -> Double { @_common.sqrt(finance_pricing_lookback_series_var(s)) }

pub fn finance_pricing_lookback_series_median(s : FinancepricinglookbackSeries) -> Double {
  let n = finance_pricing_lookback_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_pricing_lookback_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_pricing_lookback_series_scale(s : FinancepricinglookbackSeries, f : Double) -> FinancepricinglookbackSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_pricing_lookback_series_add(a : FinancepricinglookbackSeries, b : FinancepricinglookbackSeries) -> FinancepricinglookbackSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_pricing_lookback_series_sub(a : FinancepricinglookbackSeries, b : FinancepricinglookbackSeries) -> FinancepricinglookbackSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_pricing_lookback_series_normalize(s : FinancepricinglookbackSeries) -> FinancepricinglookbackSeries {
  let mn = finance_pricing_lookback_series_min(s)
  let mx = finance_pricing_lookback_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_pricing_lookback_series_cumsum(s : FinancepricinglookbackSeries) -> FinancepricinglookbackSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_pricing_lookback_series_to_string(s : FinancepricinglookbackSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricinglookbackMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_lookback_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricinglookbackMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_lookback_matrix_identity(n : Int) -> FinancepricinglookbackMatrix {
  let m = finance_pricing_lookback_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_pricing_lookback_matrix_get(m : FinancepricinglookbackMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_pricing_lookback_matrix_transpose(m : FinancepricinglookbackMatrix) -> FinancepricinglookbackMatrix {
  let result = finance_pricing_lookback_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_pricing_lookback_matrix_add(a : FinancepricinglookbackMatrix, b : FinancepricinglookbackMatrix) -> FinancepricinglookbackMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_pricing_lookback_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_pricing_lookback_matrix_scale(m : FinancepricinglookbackMatrix, s : Double) -> FinancepricinglookbackMatrix {
  let result = finance_pricing_lookback_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_pricing_lookback_matrix_multiply(a : FinancepricinglookbackMatrix, b : FinancepricinglookbackMatrix) -> FinancepricinglookbackMatrix {
  if a.cols != b.rows { return finance_pricing_lookback_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_pricing_lookback_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_pricing_lookback_matrix_trace(m : FinancepricinglookbackMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_pricing_lookback_matrix_det(m : FinancepricinglookbackMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_pricing_lookback_matrix_norm(m : FinancepricinglookbackMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_pricing_lookback_matrix_to_string(m : FinancepricinglookbackMatrix) -> String {
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

pub(all) struct FinancepricinglookbackVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_lookback_make_vector(comps : Array[Double]) -> FinancepricinglookbackVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_lookback_vector_zero(dim : Int) -> FinancepricinglookbackVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_pricing_lookback_vector_add(a : FinancepricinglookbackVector, b : FinancepricinglookbackVector) -> FinancepricinglookbackVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_pricing_lookback_vector_sub(a : FinancepricinglookbackVector, b : FinancepricinglookbackVector) -> FinancepricinglookbackVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_pricing_lookback_vector_scale(v : FinancepricinglookbackVector, s : Double) -> FinancepricinglookbackVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_pricing_lookback_vector_dot(a : FinancepricinglookbackVector, b : FinancepricinglookbackVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_pricing_lookback_vector_norm(v : FinancepricinglookbackVector) -> Double { @_common.sqrt(finance_pricing_lookback_vector_dot(v, v)) }

pub fn finance_pricing_lookback_vector_normalize(v : FinancepricinglookbackVector) -> FinancepricinglookbackVector {
  let n = finance_pricing_lookback_vector_norm(v)
  if n < 0.0000001 { v } else { finance_pricing_lookback_vector_scale(v, 1.0 / n) }
}

pub fn finance_pricing_lookback_vector_dist(a : FinancepricinglookbackVector, b : FinancepricinglookbackVector) -> Double {
  finance_pricing_lookback_vector_norm(finance_pricing_lookback_vector_sub(a, b))
}

pub fn finance_pricing_lookback_vector_to_string(v : FinancepricinglookbackVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_pricing_lookback_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn finance_pricing_lookback_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = finance_pricing_lookback_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_pricing_lookback_std(data : Array[Double]) -> Double { @_common.sqrt(finance_pricing_lookback_var(data)) }

pub fn finance_pricing_lookback_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = finance_pricing_lookback_mean(a); let mb = finance_pricing_lookback_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn finance_pricing_lookback_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = finance_pricing_lookback_std(a); let sb = finance_pricing_lookback_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { finance_pricing_lookback_cov(a, b) / (sa * sb) }
}

pub fn finance_pricing_lookback_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = finance_pricing_lookback_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_pricing_lookback_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn finance_pricing_lookback_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_pricing_lookback_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(finance_pricing_lookback_mse(pred, labels))
}

pub fn finance_pricing_lookback_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn finance_pricing_lookback_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = finance_pricing_lookback_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn finance_pricing_lookback_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn finance_pricing_lookback_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn finance_pricing_lookback_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = finance_pricing_lookback_precision(pred, labels, pos); let r = finance_pricing_lookback_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn finance_pricing_lookback_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn finance_pricing_lookback_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = finance_pricing_lookback_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn finance_pricing_lookback_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn finance_pricing_lookback_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn finance_pricing_lookback_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = finance_pricing_lookback_gcd(a, b)
    (a / g) * b
  }
}

pub fn finance_pricing_lookback_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn finance_pricing_lookback_fibonacci(n : Int) -> Int {
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

pub fn finance_pricing_lookback_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = finance_pricing_lookback_min(data); let mx = finance_pricing_lookback_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn finance_pricing_lookback_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = finance_pricing_lookback_mean(data); let sd = finance_pricing_lookback_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn finance_pricing_lookback_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn finance_pricing_lookback_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn finance_pricing_lookback_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn finance_pricing_lookback_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct FinancepricinglookbackFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_frame_make(size : Int) -> FinancepricinglookbackFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_frame_len(s : FinancepricinglookbackFrame) -> Int { s.size }

pub fn finance_pricing_lookback_frame_get(s : FinancepricinglookbackFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_frame_set(s : FinancepricinglookbackFrame, i : Int, v : Double) -> FinancepricinglookbackFrame {
  let result = finance_pricing_lookback_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_frame_sum(s : FinancepricinglookbackFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_lookback_frame_mean(s : FinancepricinglookbackFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_lookback_frame_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_lookback_frame_scale(s : FinancepricinglookbackFrame, f : Double) -> FinancepricinglookbackFrame {
  let result = finance_pricing_lookback_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_lookback_frame_add(a : FinancepricinglookbackFrame, b : FinancepricinglookbackFrame) -> FinancepricinglookbackFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_lookback_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_lookback_frame_copy(s : FinancepricinglookbackFrame) -> FinancepricinglookbackFrame {
  let result = finance_pricing_lookback_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_lookback_frame_fill(s : FinancepricinglookbackFrame, v : Double) -> FinancepricinglookbackFrame {
  let result = finance_pricing_lookback_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_frame_min(s : FinancepricinglookbackFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_frame_max(s : FinancepricinglookbackFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_frame_to_string(s : FinancepricinglookbackFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_table_make(size : Int) -> FinancepricinglookbackTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_table_len(s : FinancepricinglookbackTable) -> Int { s.size }

pub fn finance_pricing_lookback_table_get(s : FinancepricinglookbackTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_table_set(s : FinancepricinglookbackTable, i : Int, v : Double) -> FinancepricinglookbackTable {
  let result = finance_pricing_lookback_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_table_sum(s : FinancepricinglookbackTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_lookback_table_mean(s : FinancepricinglookbackTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_lookback_table_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_lookback_table_scale(s : FinancepricinglookbackTable, f : Double) -> FinancepricinglookbackTable {
  let result = finance_pricing_lookback_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_lookback_table_add(a : FinancepricinglookbackTable, b : FinancepricinglookbackTable) -> FinancepricinglookbackTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_lookback_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_lookback_table_copy(s : FinancepricinglookbackTable) -> FinancepricinglookbackTable {
  let result = finance_pricing_lookback_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_lookback_table_fill(s : FinancepricinglookbackTable, v : Double) -> FinancepricinglookbackTable {
  let result = finance_pricing_lookback_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_table_min(s : FinancepricinglookbackTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_table_max(s : FinancepricinglookbackTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_table_to_string(s : FinancepricinglookbackTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_graphn_make(size : Int) -> FinancepricinglookbackGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_graphn_len(s : FinancepricinglookbackGraphN) -> Int { s.size }

pub fn finance_pricing_lookback_graphn_get(s : FinancepricinglookbackGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_graphn_set(s : FinancepricinglookbackGraphN, i : Int, v : Double) -> FinancepricinglookbackGraphN {
  let result = finance_pricing_lookback_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_graphn_sum(s : FinancepricinglookbackGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_lookback_graphn_mean(s : FinancepricinglookbackGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_lookback_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_lookback_graphn_scale(s : FinancepricinglookbackGraphN, f : Double) -> FinancepricinglookbackGraphN {
  let result = finance_pricing_lookback_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_lookback_graphn_add(a : FinancepricinglookbackGraphN, b : FinancepricinglookbackGraphN) -> FinancepricinglookbackGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_lookback_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_lookback_graphn_copy(s : FinancepricinglookbackGraphN) -> FinancepricinglookbackGraphN {
  let result = finance_pricing_lookback_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_lookback_graphn_fill(s : FinancepricinglookbackGraphN, v : Double) -> FinancepricinglookbackGraphN {
  let result = finance_pricing_lookback_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_graphn_min(s : FinancepricinglookbackGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_graphn_max(s : FinancepricinglookbackGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_graphn_to_string(s : FinancepricinglookbackGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_node_make(size : Int) -> FinancepricinglookbackNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_node_len(s : FinancepricinglookbackNode) -> Int { s.size }

pub fn finance_pricing_lookback_node_get(s : FinancepricinglookbackNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_node_set(s : FinancepricinglookbackNode, i : Int, v : Double) -> FinancepricinglookbackNode {
  let result = finance_pricing_lookback_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_node_sum(s : FinancepricinglookbackNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_lookback_node_mean(s : FinancepricinglookbackNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_lookback_node_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_lookback_node_scale(s : FinancepricinglookbackNode, f : Double) -> FinancepricinglookbackNode {
  let result = finance_pricing_lookback_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_lookback_node_add(a : FinancepricinglookbackNode, b : FinancepricinglookbackNode) -> FinancepricinglookbackNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_lookback_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_lookback_node_copy(s : FinancepricinglookbackNode) -> FinancepricinglookbackNode {
  let result = finance_pricing_lookback_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_lookback_node_fill(s : FinancepricinglookbackNode, v : Double) -> FinancepricinglookbackNode {
  let result = finance_pricing_lookback_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_node_min(s : FinancepricinglookbackNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_node_max(s : FinancepricinglookbackNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_node_to_string(s : FinancepricinglookbackNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_edge_make(size : Int) -> FinancepricinglookbackEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_edge_len(s : FinancepricinglookbackEdge) -> Int { s.size }

pub fn finance_pricing_lookback_edge_get(s : FinancepricinglookbackEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_edge_set(s : FinancepricinglookbackEdge, i : Int, v : Double) -> FinancepricinglookbackEdge {
  let result = finance_pricing_lookback_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_edge_sum(s : FinancepricinglookbackEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_lookback_edge_mean(s : FinancepricinglookbackEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_lookback_edge_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_lookback_edge_scale(s : FinancepricinglookbackEdge, f : Double) -> FinancepricinglookbackEdge {
  let result = finance_pricing_lookback_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_lookback_edge_add(a : FinancepricinglookbackEdge, b : FinancepricinglookbackEdge) -> FinancepricinglookbackEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_lookback_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_lookback_edge_copy(s : FinancepricinglookbackEdge) -> FinancepricinglookbackEdge {
  let result = finance_pricing_lookback_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_lookback_edge_fill(s : FinancepricinglookbackEdge, v : Double) -> FinancepricinglookbackEdge {
  let result = finance_pricing_lookback_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_edge_min(s : FinancepricinglookbackEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_edge_max(s : FinancepricinglookbackEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_edge_to_string(s : FinancepricinglookbackEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_path_make(size : Int) -> FinancepricinglookbackPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_path_len(s : FinancepricinglookbackPath) -> Int { s.size }

pub fn finance_pricing_lookback_path_get(s : FinancepricinglookbackPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_path_set(s : FinancepricinglookbackPath, i : Int, v : Double) -> FinancepricinglookbackPath {
  let result = finance_pricing_lookback_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_path_sum(s : FinancepricinglookbackPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_lookback_path_mean(s : FinancepricinglookbackPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_lookback_path_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_lookback_path_scale(s : FinancepricinglookbackPath, f : Double) -> FinancepricinglookbackPath {
  let result = finance_pricing_lookback_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_lookback_path_add(a : FinancepricinglookbackPath, b : FinancepricinglookbackPath) -> FinancepricinglookbackPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_lookback_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_lookback_path_copy(s : FinancepricinglookbackPath) -> FinancepricinglookbackPath {
  let result = finance_pricing_lookback_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_lookback_path_fill(s : FinancepricinglookbackPath, v : Double) -> FinancepricinglookbackPath {
  let result = finance_pricing_lookback_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_path_min(s : FinancepricinglookbackPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_path_max(s : FinancepricinglookbackPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_path_to_string(s : FinancepricinglookbackPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_cluster_make(size : Int) -> FinancepricinglookbackCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_cluster_len(s : FinancepricinglookbackCluster) -> Int { s.size }

pub fn finance_pricing_lookback_cluster_get(s : FinancepricinglookbackCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_cluster_set(s : FinancepricinglookbackCluster, i : Int, v : Double) -> FinancepricinglookbackCluster {
  let result = finance_pricing_lookback_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_cluster_sum(s : FinancepricinglookbackCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_lookback_cluster_mean(s : FinancepricinglookbackCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_lookback_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_lookback_cluster_scale(s : FinancepricinglookbackCluster, f : Double) -> FinancepricinglookbackCluster {
  let result = finance_pricing_lookback_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_lookback_cluster_add(a : FinancepricinglookbackCluster, b : FinancepricinglookbackCluster) -> FinancepricinglookbackCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_lookback_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_lookback_cluster_copy(s : FinancepricinglookbackCluster) -> FinancepricinglookbackCluster {
  let result = finance_pricing_lookback_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_lookback_cluster_fill(s : FinancepricinglookbackCluster, v : Double) -> FinancepricinglookbackCluster {
  let result = finance_pricing_lookback_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_cluster_min(s : FinancepricinglookbackCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_cluster_max(s : FinancepricinglookbackCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_cluster_to_string(s : FinancepricinglookbackCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_model_make(size : Int) -> FinancepricinglookbackModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_model_len(s : FinancepricinglookbackModel) -> Int { s.size }

pub fn finance_pricing_lookback_model_get(s : FinancepricinglookbackModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_model_set(s : FinancepricinglookbackModel, i : Int, v : Double) -> FinancepricinglookbackModel {
  let result = finance_pricing_lookback_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_model_sum(s : FinancepricinglookbackModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_lookback_model_mean(s : FinancepricinglookbackModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_lookback_model_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_lookback_model_scale(s : FinancepricinglookbackModel, f : Double) -> FinancepricinglookbackModel {
  let result = finance_pricing_lookback_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_lookback_model_add(a : FinancepricinglookbackModel, b : FinancepricinglookbackModel) -> FinancepricinglookbackModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_lookback_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_lookback_model_copy(s : FinancepricinglookbackModel) -> FinancepricinglookbackModel {
  let result = finance_pricing_lookback_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_lookback_model_fill(s : FinancepricinglookbackModel, v : Double) -> FinancepricinglookbackModel {
  let result = finance_pricing_lookback_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_model_min(s : FinancepricinglookbackModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_model_max(s : FinancepricinglookbackModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_model_to_string(s : FinancepricinglookbackModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_layer_make(size : Int) -> FinancepricinglookbackLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_layer_len(s : FinancepricinglookbackLayer) -> Int { s.size }

pub fn finance_pricing_lookback_layer_get(s : FinancepricinglookbackLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_layer_set(s : FinancepricinglookbackLayer, i : Int, v : Double) -> FinancepricinglookbackLayer {
  let result = finance_pricing_lookback_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_layer_sum(s : FinancepricinglookbackLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_lookback_layer_mean(s : FinancepricinglookbackLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_lookback_layer_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_lookback_layer_scale(s : FinancepricinglookbackLayer, f : Double) -> FinancepricinglookbackLayer {
  let result = finance_pricing_lookback_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_lookback_layer_add(a : FinancepricinglookbackLayer, b : FinancepricinglookbackLayer) -> FinancepricinglookbackLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_lookback_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_lookback_layer_copy(s : FinancepricinglookbackLayer) -> FinancepricinglookbackLayer {
  let result = finance_pricing_lookback_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_lookback_layer_fill(s : FinancepricinglookbackLayer, v : Double) -> FinancepricinglookbackLayer {
  let result = finance_pricing_lookback_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_layer_min(s : FinancepricinglookbackLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_layer_max(s : FinancepricinglookbackLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_layer_to_string(s : FinancepricinglookbackLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_buffer_make(size : Int) -> FinancepricinglookbackBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_buffer_len(s : FinancepricinglookbackBuffer) -> Int { s.size }

pub fn finance_pricing_lookback_buffer_get(s : FinancepricinglookbackBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_buffer_set(s : FinancepricinglookbackBuffer, i : Int, v : Double) -> FinancepricinglookbackBuffer {
  let result = finance_pricing_lookback_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_buffer_sum(s : FinancepricinglookbackBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_lookback_buffer_mean(s : FinancepricinglookbackBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_lookback_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_lookback_buffer_scale(s : FinancepricinglookbackBuffer, f : Double) -> FinancepricinglookbackBuffer {
  let result = finance_pricing_lookback_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_lookback_buffer_add(a : FinancepricinglookbackBuffer, b : FinancepricinglookbackBuffer) -> FinancepricinglookbackBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_lookback_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_lookback_buffer_copy(s : FinancepricinglookbackBuffer) -> FinancepricinglookbackBuffer {
  let result = finance_pricing_lookback_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_lookback_buffer_fill(s : FinancepricinglookbackBuffer, v : Double) -> FinancepricinglookbackBuffer {
  let result = finance_pricing_lookback_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_buffer_min(s : FinancepricinglookbackBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_buffer_max(s : FinancepricinglookbackBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_buffer_to_string(s : FinancepricinglookbackBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_cursor_make(size : Int) -> FinancepricinglookbackCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_cursor_len(s : FinancepricinglookbackCursor) -> Int { s.size }

pub fn finance_pricing_lookback_cursor_get(s : FinancepricinglookbackCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_cursor_set(s : FinancepricinglookbackCursor, i : Int, v : Double) -> FinancepricinglookbackCursor {
  let result = finance_pricing_lookback_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_cursor_sum(s : FinancepricinglookbackCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_lookback_cursor_mean(s : FinancepricinglookbackCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_lookback_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_lookback_cursor_scale(s : FinancepricinglookbackCursor, f : Double) -> FinancepricinglookbackCursor {
  let result = finance_pricing_lookback_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_lookback_cursor_add(a : FinancepricinglookbackCursor, b : FinancepricinglookbackCursor) -> FinancepricinglookbackCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_lookback_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_lookback_cursor_copy(s : FinancepricinglookbackCursor) -> FinancepricinglookbackCursor {
  let result = finance_pricing_lookback_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_lookback_cursor_fill(s : FinancepricinglookbackCursor, v : Double) -> FinancepricinglookbackCursor {
  let result = finance_pricing_lookback_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_cursor_min(s : FinancepricinglookbackCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_cursor_max(s : FinancepricinglookbackCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_cursor_to_string(s : FinancepricinglookbackCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_view_make(size : Int) -> FinancepricinglookbackView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_view_len(s : FinancepricinglookbackView) -> Int { s.size }

pub fn finance_pricing_lookback_view_get(s : FinancepricinglookbackView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_view_set(s : FinancepricinglookbackView, i : Int, v : Double) -> FinancepricinglookbackView {
  let result = finance_pricing_lookback_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_view_sum(s : FinancepricinglookbackView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_lookback_view_mean(s : FinancepricinglookbackView) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_lookback_view_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_lookback_view_scale(s : FinancepricinglookbackView, f : Double) -> FinancepricinglookbackView {
  let result = finance_pricing_lookback_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_lookback_view_add(a : FinancepricinglookbackView, b : FinancepricinglookbackView) -> FinancepricinglookbackView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_lookback_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_lookback_view_copy(s : FinancepricinglookbackView) -> FinancepricinglookbackView {
  let result = finance_pricing_lookback_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_lookback_view_fill(s : FinancepricinglookbackView, v : Double) -> FinancepricinglookbackView {
  let result = finance_pricing_lookback_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_view_min(s : FinancepricinglookbackView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_view_max(s : FinancepricinglookbackView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_view_to_string(s : FinancepricinglookbackView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_range_make(size : Int) -> FinancepricinglookbackRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_range_len(s : FinancepricinglookbackRange) -> Int { s.size }

pub fn finance_pricing_lookback_range_get(s : FinancepricinglookbackRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_range_set(s : FinancepricinglookbackRange, i : Int, v : Double) -> FinancepricinglookbackRange {
  let result = finance_pricing_lookback_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_range_sum(s : FinancepricinglookbackRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_lookback_range_mean(s : FinancepricinglookbackRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_lookback_range_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_lookback_range_scale(s : FinancepricinglookbackRange, f : Double) -> FinancepricinglookbackRange {
  let result = finance_pricing_lookback_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_lookback_range_add(a : FinancepricinglookbackRange, b : FinancepricinglookbackRange) -> FinancepricinglookbackRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_lookback_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_lookback_range_copy(s : FinancepricinglookbackRange) -> FinancepricinglookbackRange {
  let result = finance_pricing_lookback_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_lookback_range_fill(s : FinancepricinglookbackRange, v : Double) -> FinancepricinglookbackRange {
  let result = finance_pricing_lookback_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_range_min(s : FinancepricinglookbackRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_range_max(s : FinancepricinglookbackRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_range_to_string(s : FinancepricinglookbackRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_slice_make(size : Int) -> FinancepricinglookbackSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_slice_len(s : FinancepricinglookbackSlice) -> Int { s.size }

pub fn finance_pricing_lookback_slice_get(s : FinancepricinglookbackSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_slice_set(s : FinancepricinglookbackSlice, i : Int, v : Double) -> FinancepricinglookbackSlice {
  let result = finance_pricing_lookback_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_slice_sum(s : FinancepricinglookbackSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_lookback_slice_mean(s : FinancepricinglookbackSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_lookback_slice_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_lookback_slice_scale(s : FinancepricinglookbackSlice, f : Double) -> FinancepricinglookbackSlice {
  let result = finance_pricing_lookback_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_lookback_slice_add(a : FinancepricinglookbackSlice, b : FinancepricinglookbackSlice) -> FinancepricinglookbackSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_lookback_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_lookback_slice_copy(s : FinancepricinglookbackSlice) -> FinancepricinglookbackSlice {
  let result = finance_pricing_lookback_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_lookback_slice_fill(s : FinancepricinglookbackSlice, v : Double) -> FinancepricinglookbackSlice {
  let result = finance_pricing_lookback_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_lookback_slice_min(s : FinancepricinglookbackSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_slice_max(s : FinancepricinglookbackSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_lookback_slice_to_string(s : FinancepricinglookbackSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

