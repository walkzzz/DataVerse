///===
/// extcore/finance_time_mgarch

pub(all) struct FinancetimemgarchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_mgarch_make_point(x : Double, y : Double) -> FinancetimemgarchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_mgarch_make_point3(x : Double, y : Double, z : Double) -> FinancetimemgarchPoint {
  { x, y, z, label: 0 }
}

pub fn finance_time_mgarch_point_x(pt : FinancetimemgarchPoint) -> Double { pt.x }

pub fn finance_time_mgarch_point_y(pt : FinancetimemgarchPoint) -> Double { pt.y }

pub fn finance_time_mgarch_point_z(pt : FinancetimemgarchPoint) -> Double { pt.z }

pub fn finance_time_mgarch_point_label(pt : FinancetimemgarchPoint) -> Int { pt.label }

pub fn finance_time_mgarch_point_dist(a : FinancetimemgarchPoint, b : FinancetimemgarchPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_time_mgarch_point_add(a : FinancetimemgarchPoint, b : FinancetimemgarchPoint) -> FinancetimemgarchPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_time_mgarch_point_sub(a : FinancetimemgarchPoint, b : FinancetimemgarchPoint) -> FinancetimemgarchPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_time_mgarch_point_scale(pt : FinancetimemgarchPoint, s : Double) -> FinancetimemgarchPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_time_mgarch_point_dot(a : FinancetimemgarchPoint, b : FinancetimemgarchPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_time_mgarch_point_cross(a : FinancetimemgarchPoint, b : FinancetimemgarchPoint) -> FinancetimemgarchPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_time_mgarch_point_norm(pt : FinancetimemgarchPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_time_mgarch_point_normalize(pt : FinancetimemgarchPoint) -> FinancetimemgarchPoint {
  let n = finance_time_mgarch_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_time_mgarch_point_scale(pt, 1.0 / n) }
}

pub fn finance_time_mgarch_point_negate(pt : FinancetimemgarchPoint) -> FinancetimemgarchPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_time_mgarch_point_mid(a : FinancetimemgarchPoint, b : FinancetimemgarchPoint) -> FinancetimemgarchPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_time_mgarch_point_lerp(a : FinancetimemgarchPoint, b : FinancetimemgarchPoint, t : Double) -> FinancetimemgarchPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_time_mgarch_point_to_string(pt : FinancetimemgarchPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancetimemgarchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_mgarch_make_series(vals : Array[Double], name : String) -> FinancetimemgarchSeries {
  { vals, name, meta: 0 }
}

pub fn finance_time_mgarch_series_len(s : FinancetimemgarchSeries) -> Int { s.vals.length() }

pub fn finance_time_mgarch_series_sum(s : FinancetimemgarchSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_time_mgarch_series_mean(s : FinancetimemgarchSeries) -> Double {
  let n = finance_time_mgarch_series_len(s)
  if n == 0 { 0.0 } else { finance_time_mgarch_series_sum(s) / n.to_double() }
}

pub fn finance_time_mgarch_series_min(s : FinancetimemgarchSeries) -> Double {
  let n = finance_time_mgarch_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_time_mgarch_series_max(s : FinancetimemgarchSeries) -> Double {
  let n = finance_time_mgarch_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_time_mgarch_series_range(s : FinancetimemgarchSeries) -> Double {
  finance_time_mgarch_series_max(s) - finance_time_mgarch_series_min(s)
}

pub fn finance_time_mgarch_series_var(s : FinancetimemgarchSeries) -> Double {
  let n = finance_time_mgarch_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_time_mgarch_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_time_mgarch_series_std(s : FinancetimemgarchSeries) -> Double { @_common.sqrt(finance_time_mgarch_series_var(s)) }

pub fn finance_time_mgarch_series_median(s : FinancetimemgarchSeries) -> Double {
  let n = finance_time_mgarch_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_time_mgarch_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_time_mgarch_series_scale(s : FinancetimemgarchSeries, f : Double) -> FinancetimemgarchSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_time_mgarch_series_add(a : FinancetimemgarchSeries, b : FinancetimemgarchSeries) -> FinancetimemgarchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_time_mgarch_series_sub(a : FinancetimemgarchSeries, b : FinancetimemgarchSeries) -> FinancetimemgarchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_time_mgarch_series_normalize(s : FinancetimemgarchSeries) -> FinancetimemgarchSeries {
  let mn = finance_time_mgarch_series_min(s)
  let mx = finance_time_mgarch_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_time_mgarch_series_cumsum(s : FinancetimemgarchSeries) -> FinancetimemgarchSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_time_mgarch_series_to_string(s : FinancetimemgarchSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimemgarchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_mgarch_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimemgarchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_mgarch_matrix_identity(n : Int) -> FinancetimemgarchMatrix {
  let m = finance_time_mgarch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_time_mgarch_matrix_get(m : FinancetimemgarchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_time_mgarch_matrix_transpose(m : FinancetimemgarchMatrix) -> FinancetimemgarchMatrix {
  let result = finance_time_mgarch_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_time_mgarch_matrix_add(a : FinancetimemgarchMatrix, b : FinancetimemgarchMatrix) -> FinancetimemgarchMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_time_mgarch_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_time_mgarch_matrix_scale(m : FinancetimemgarchMatrix, s : Double) -> FinancetimemgarchMatrix {
  let result = finance_time_mgarch_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_time_mgarch_matrix_multiply(a : FinancetimemgarchMatrix, b : FinancetimemgarchMatrix) -> FinancetimemgarchMatrix {
  if a.cols != b.rows { return finance_time_mgarch_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_time_mgarch_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_time_mgarch_matrix_trace(m : FinancetimemgarchMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_time_mgarch_matrix_det(m : FinancetimemgarchMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_time_mgarch_matrix_norm(m : FinancetimemgarchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_time_mgarch_matrix_to_string(m : FinancetimemgarchMatrix) -> String {
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

pub(all) struct FinancetimemgarchVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_mgarch_make_vector(comps : Array[Double]) -> FinancetimemgarchVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_mgarch_vector_zero(dim : Int) -> FinancetimemgarchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_time_mgarch_vector_add(a : FinancetimemgarchVector, b : FinancetimemgarchVector) -> FinancetimemgarchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_mgarch_vector_sub(a : FinancetimemgarchVector, b : FinancetimemgarchVector) -> FinancetimemgarchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_mgarch_vector_scale(v : FinancetimemgarchVector, s : Double) -> FinancetimemgarchVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_time_mgarch_vector_dot(a : FinancetimemgarchVector, b : FinancetimemgarchVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_time_mgarch_vector_norm(v : FinancetimemgarchVector) -> Double { @_common.sqrt(finance_time_mgarch_vector_dot(v, v)) }

pub fn finance_time_mgarch_vector_normalize(v : FinancetimemgarchVector) -> FinancetimemgarchVector {
  let n = finance_time_mgarch_vector_norm(v)
  if n < 0.0000001 { v } else { finance_time_mgarch_vector_scale(v, 1.0 / n) }
}

pub fn finance_time_mgarch_vector_dist(a : FinancetimemgarchVector, b : FinancetimemgarchVector) -> Double {
  finance_time_mgarch_vector_norm(finance_time_mgarch_vector_sub(a, b))
}

pub fn finance_time_mgarch_vector_to_string(v : FinancetimemgarchVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_time_mgarch_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn finance_time_mgarch_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = finance_time_mgarch_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_time_mgarch_std(data : Array[Double]) -> Double { @_common.sqrt(finance_time_mgarch_var(data)) }

pub fn finance_time_mgarch_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = finance_time_mgarch_mean(a); let mb = finance_time_mgarch_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn finance_time_mgarch_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = finance_time_mgarch_std(a); let sb = finance_time_mgarch_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { finance_time_mgarch_cov(a, b) / (sa * sb) }
}

pub fn finance_time_mgarch_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = finance_time_mgarch_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_time_mgarch_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn finance_time_mgarch_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_time_mgarch_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(finance_time_mgarch_mse(pred, labels))
}

pub fn finance_time_mgarch_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn finance_time_mgarch_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = finance_time_mgarch_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn finance_time_mgarch_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn finance_time_mgarch_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn finance_time_mgarch_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = finance_time_mgarch_precision(pred, labels, pos); let r = finance_time_mgarch_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn finance_time_mgarch_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn finance_time_mgarch_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = finance_time_mgarch_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn finance_time_mgarch_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn finance_time_mgarch_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn finance_time_mgarch_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = finance_time_mgarch_gcd(a, b)
    (a / g) * b
  }
}

pub fn finance_time_mgarch_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn finance_time_mgarch_fibonacci(n : Int) -> Int {
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

pub fn finance_time_mgarch_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = finance_time_mgarch_min(data); let mx = finance_time_mgarch_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn finance_time_mgarch_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = finance_time_mgarch_mean(data); let sd = finance_time_mgarch_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn finance_time_mgarch_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn finance_time_mgarch_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn finance_time_mgarch_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn finance_time_mgarch_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn finance_time_mgarch_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn finance_time_mgarch_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct FinancetimemgarchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_frame_make(size : Int) -> FinancetimemgarchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_frame_len(s : FinancetimemgarchFrame) -> Int { s.size }

pub fn finance_time_mgarch_frame_get(s : FinancetimemgarchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_frame_set(s : FinancetimemgarchFrame, i : Int, v : Double) -> FinancetimemgarchFrame {
  let result = finance_time_mgarch_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_frame_sum(s : FinancetimemgarchFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_mgarch_frame_mean(s : FinancetimemgarchFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_mgarch_frame_sum(s) / s.size.to_double() }
}

pub fn finance_time_mgarch_frame_scale(s : FinancetimemgarchFrame, f : Double) -> FinancetimemgarchFrame {
  let result = finance_time_mgarch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_mgarch_frame_add(a : FinancetimemgarchFrame, b : FinancetimemgarchFrame) -> FinancetimemgarchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_mgarch_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_mgarch_frame_copy(s : FinancetimemgarchFrame) -> FinancetimemgarchFrame {
  let result = finance_time_mgarch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_mgarch_frame_fill(s : FinancetimemgarchFrame, v : Double) -> FinancetimemgarchFrame {
  let result = finance_time_mgarch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_frame_min(s : FinancetimemgarchFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_frame_max(s : FinancetimemgarchFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_frame_to_string(s : FinancetimemgarchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_table_make(size : Int) -> FinancetimemgarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_table_len(s : FinancetimemgarchTable) -> Int { s.size }

pub fn finance_time_mgarch_table_get(s : FinancetimemgarchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_table_set(s : FinancetimemgarchTable, i : Int, v : Double) -> FinancetimemgarchTable {
  let result = finance_time_mgarch_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_table_sum(s : FinancetimemgarchTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_mgarch_table_mean(s : FinancetimemgarchTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_mgarch_table_sum(s) / s.size.to_double() }
}

pub fn finance_time_mgarch_table_scale(s : FinancetimemgarchTable, f : Double) -> FinancetimemgarchTable {
  let result = finance_time_mgarch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_mgarch_table_add(a : FinancetimemgarchTable, b : FinancetimemgarchTable) -> FinancetimemgarchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_mgarch_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_mgarch_table_copy(s : FinancetimemgarchTable) -> FinancetimemgarchTable {
  let result = finance_time_mgarch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_mgarch_table_fill(s : FinancetimemgarchTable, v : Double) -> FinancetimemgarchTable {
  let result = finance_time_mgarch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_table_min(s : FinancetimemgarchTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_table_max(s : FinancetimemgarchTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_table_to_string(s : FinancetimemgarchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_graphn_make(size : Int) -> FinancetimemgarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_graphn_len(s : FinancetimemgarchGraphN) -> Int { s.size }

pub fn finance_time_mgarch_graphn_get(s : FinancetimemgarchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_graphn_set(s : FinancetimemgarchGraphN, i : Int, v : Double) -> FinancetimemgarchGraphN {
  let result = finance_time_mgarch_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_graphn_sum(s : FinancetimemgarchGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_mgarch_graphn_mean(s : FinancetimemgarchGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_mgarch_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_time_mgarch_graphn_scale(s : FinancetimemgarchGraphN, f : Double) -> FinancetimemgarchGraphN {
  let result = finance_time_mgarch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_mgarch_graphn_add(a : FinancetimemgarchGraphN, b : FinancetimemgarchGraphN) -> FinancetimemgarchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_mgarch_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_mgarch_graphn_copy(s : FinancetimemgarchGraphN) -> FinancetimemgarchGraphN {
  let result = finance_time_mgarch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_mgarch_graphn_fill(s : FinancetimemgarchGraphN, v : Double) -> FinancetimemgarchGraphN {
  let result = finance_time_mgarch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_graphn_min(s : FinancetimemgarchGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_graphn_max(s : FinancetimemgarchGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_graphn_to_string(s : FinancetimemgarchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_node_make(size : Int) -> FinancetimemgarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_node_len(s : FinancetimemgarchNode) -> Int { s.size }

pub fn finance_time_mgarch_node_get(s : FinancetimemgarchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_node_set(s : FinancetimemgarchNode, i : Int, v : Double) -> FinancetimemgarchNode {
  let result = finance_time_mgarch_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_node_sum(s : FinancetimemgarchNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_mgarch_node_mean(s : FinancetimemgarchNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_mgarch_node_sum(s) / s.size.to_double() }
}

pub fn finance_time_mgarch_node_scale(s : FinancetimemgarchNode, f : Double) -> FinancetimemgarchNode {
  let result = finance_time_mgarch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_mgarch_node_add(a : FinancetimemgarchNode, b : FinancetimemgarchNode) -> FinancetimemgarchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_mgarch_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_mgarch_node_copy(s : FinancetimemgarchNode) -> FinancetimemgarchNode {
  let result = finance_time_mgarch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_mgarch_node_fill(s : FinancetimemgarchNode, v : Double) -> FinancetimemgarchNode {
  let result = finance_time_mgarch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_node_min(s : FinancetimemgarchNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_node_max(s : FinancetimemgarchNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_node_to_string(s : FinancetimemgarchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_edge_make(size : Int) -> FinancetimemgarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_edge_len(s : FinancetimemgarchEdge) -> Int { s.size }

pub fn finance_time_mgarch_edge_get(s : FinancetimemgarchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_edge_set(s : FinancetimemgarchEdge, i : Int, v : Double) -> FinancetimemgarchEdge {
  let result = finance_time_mgarch_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_edge_sum(s : FinancetimemgarchEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_mgarch_edge_mean(s : FinancetimemgarchEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_mgarch_edge_sum(s) / s.size.to_double() }
}

pub fn finance_time_mgarch_edge_scale(s : FinancetimemgarchEdge, f : Double) -> FinancetimemgarchEdge {
  let result = finance_time_mgarch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_mgarch_edge_add(a : FinancetimemgarchEdge, b : FinancetimemgarchEdge) -> FinancetimemgarchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_mgarch_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_mgarch_edge_copy(s : FinancetimemgarchEdge) -> FinancetimemgarchEdge {
  let result = finance_time_mgarch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_mgarch_edge_fill(s : FinancetimemgarchEdge, v : Double) -> FinancetimemgarchEdge {
  let result = finance_time_mgarch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_edge_min(s : FinancetimemgarchEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_edge_max(s : FinancetimemgarchEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_edge_to_string(s : FinancetimemgarchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_path_make(size : Int) -> FinancetimemgarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_path_len(s : FinancetimemgarchPath) -> Int { s.size }

pub fn finance_time_mgarch_path_get(s : FinancetimemgarchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_path_set(s : FinancetimemgarchPath, i : Int, v : Double) -> FinancetimemgarchPath {
  let result = finance_time_mgarch_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_path_sum(s : FinancetimemgarchPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_mgarch_path_mean(s : FinancetimemgarchPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_mgarch_path_sum(s) / s.size.to_double() }
}

pub fn finance_time_mgarch_path_scale(s : FinancetimemgarchPath, f : Double) -> FinancetimemgarchPath {
  let result = finance_time_mgarch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_mgarch_path_add(a : FinancetimemgarchPath, b : FinancetimemgarchPath) -> FinancetimemgarchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_mgarch_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_mgarch_path_copy(s : FinancetimemgarchPath) -> FinancetimemgarchPath {
  let result = finance_time_mgarch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_mgarch_path_fill(s : FinancetimemgarchPath, v : Double) -> FinancetimemgarchPath {
  let result = finance_time_mgarch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_path_min(s : FinancetimemgarchPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_path_max(s : FinancetimemgarchPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_path_to_string(s : FinancetimemgarchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_cluster_make(size : Int) -> FinancetimemgarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_cluster_len(s : FinancetimemgarchCluster) -> Int { s.size }

pub fn finance_time_mgarch_cluster_get(s : FinancetimemgarchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_cluster_set(s : FinancetimemgarchCluster, i : Int, v : Double) -> FinancetimemgarchCluster {
  let result = finance_time_mgarch_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_cluster_sum(s : FinancetimemgarchCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_mgarch_cluster_mean(s : FinancetimemgarchCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_mgarch_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_time_mgarch_cluster_scale(s : FinancetimemgarchCluster, f : Double) -> FinancetimemgarchCluster {
  let result = finance_time_mgarch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_mgarch_cluster_add(a : FinancetimemgarchCluster, b : FinancetimemgarchCluster) -> FinancetimemgarchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_mgarch_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_mgarch_cluster_copy(s : FinancetimemgarchCluster) -> FinancetimemgarchCluster {
  let result = finance_time_mgarch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_mgarch_cluster_fill(s : FinancetimemgarchCluster, v : Double) -> FinancetimemgarchCluster {
  let result = finance_time_mgarch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_cluster_min(s : FinancetimemgarchCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_cluster_max(s : FinancetimemgarchCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_cluster_to_string(s : FinancetimemgarchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_model_make(size : Int) -> FinancetimemgarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_model_len(s : FinancetimemgarchModel) -> Int { s.size }

pub fn finance_time_mgarch_model_get(s : FinancetimemgarchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_model_set(s : FinancetimemgarchModel, i : Int, v : Double) -> FinancetimemgarchModel {
  let result = finance_time_mgarch_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_model_sum(s : FinancetimemgarchModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_mgarch_model_mean(s : FinancetimemgarchModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_mgarch_model_sum(s) / s.size.to_double() }
}

pub fn finance_time_mgarch_model_scale(s : FinancetimemgarchModel, f : Double) -> FinancetimemgarchModel {
  let result = finance_time_mgarch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_mgarch_model_add(a : FinancetimemgarchModel, b : FinancetimemgarchModel) -> FinancetimemgarchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_mgarch_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_mgarch_model_copy(s : FinancetimemgarchModel) -> FinancetimemgarchModel {
  let result = finance_time_mgarch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_mgarch_model_fill(s : FinancetimemgarchModel, v : Double) -> FinancetimemgarchModel {
  let result = finance_time_mgarch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_model_min(s : FinancetimemgarchModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_model_max(s : FinancetimemgarchModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_model_to_string(s : FinancetimemgarchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_layer_make(size : Int) -> FinancetimemgarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_layer_len(s : FinancetimemgarchLayer) -> Int { s.size }

pub fn finance_time_mgarch_layer_get(s : FinancetimemgarchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_layer_set(s : FinancetimemgarchLayer, i : Int, v : Double) -> FinancetimemgarchLayer {
  let result = finance_time_mgarch_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_layer_sum(s : FinancetimemgarchLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_mgarch_layer_mean(s : FinancetimemgarchLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_mgarch_layer_sum(s) / s.size.to_double() }
}

pub fn finance_time_mgarch_layer_scale(s : FinancetimemgarchLayer, f : Double) -> FinancetimemgarchLayer {
  let result = finance_time_mgarch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_mgarch_layer_add(a : FinancetimemgarchLayer, b : FinancetimemgarchLayer) -> FinancetimemgarchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_mgarch_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_mgarch_layer_copy(s : FinancetimemgarchLayer) -> FinancetimemgarchLayer {
  let result = finance_time_mgarch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_mgarch_layer_fill(s : FinancetimemgarchLayer, v : Double) -> FinancetimemgarchLayer {
  let result = finance_time_mgarch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_layer_min(s : FinancetimemgarchLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_layer_max(s : FinancetimemgarchLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_layer_to_string(s : FinancetimemgarchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_buffer_make(size : Int) -> FinancetimemgarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_buffer_len(s : FinancetimemgarchBuffer) -> Int { s.size }

pub fn finance_time_mgarch_buffer_get(s : FinancetimemgarchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_buffer_set(s : FinancetimemgarchBuffer, i : Int, v : Double) -> FinancetimemgarchBuffer {
  let result = finance_time_mgarch_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_buffer_sum(s : FinancetimemgarchBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_mgarch_buffer_mean(s : FinancetimemgarchBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_mgarch_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_time_mgarch_buffer_scale(s : FinancetimemgarchBuffer, f : Double) -> FinancetimemgarchBuffer {
  let result = finance_time_mgarch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_mgarch_buffer_add(a : FinancetimemgarchBuffer, b : FinancetimemgarchBuffer) -> FinancetimemgarchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_mgarch_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_mgarch_buffer_copy(s : FinancetimemgarchBuffer) -> FinancetimemgarchBuffer {
  let result = finance_time_mgarch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_mgarch_buffer_fill(s : FinancetimemgarchBuffer, v : Double) -> FinancetimemgarchBuffer {
  let result = finance_time_mgarch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_buffer_min(s : FinancetimemgarchBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_buffer_max(s : FinancetimemgarchBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_buffer_to_string(s : FinancetimemgarchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_cursor_make(size : Int) -> FinancetimemgarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_cursor_len(s : FinancetimemgarchCursor) -> Int { s.size }

pub fn finance_time_mgarch_cursor_get(s : FinancetimemgarchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_cursor_set(s : FinancetimemgarchCursor, i : Int, v : Double) -> FinancetimemgarchCursor {
  let result = finance_time_mgarch_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_cursor_sum(s : FinancetimemgarchCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_mgarch_cursor_mean(s : FinancetimemgarchCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_mgarch_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_time_mgarch_cursor_scale(s : FinancetimemgarchCursor, f : Double) -> FinancetimemgarchCursor {
  let result = finance_time_mgarch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_mgarch_cursor_add(a : FinancetimemgarchCursor, b : FinancetimemgarchCursor) -> FinancetimemgarchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_mgarch_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_mgarch_cursor_copy(s : FinancetimemgarchCursor) -> FinancetimemgarchCursor {
  let result = finance_time_mgarch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_mgarch_cursor_fill(s : FinancetimemgarchCursor, v : Double) -> FinancetimemgarchCursor {
  let result = finance_time_mgarch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_cursor_min(s : FinancetimemgarchCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_cursor_max(s : FinancetimemgarchCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_cursor_to_string(s : FinancetimemgarchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_view_make(size : Int) -> FinancetimemgarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_view_len(s : FinancetimemgarchView) -> Int { s.size }

pub fn finance_time_mgarch_view_get(s : FinancetimemgarchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_view_set(s : FinancetimemgarchView, i : Int, v : Double) -> FinancetimemgarchView {
  let result = finance_time_mgarch_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_view_sum(s : FinancetimemgarchView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_mgarch_view_mean(s : FinancetimemgarchView) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_mgarch_view_sum(s) / s.size.to_double() }
}

pub fn finance_time_mgarch_view_scale(s : FinancetimemgarchView, f : Double) -> FinancetimemgarchView {
  let result = finance_time_mgarch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_mgarch_view_add(a : FinancetimemgarchView, b : FinancetimemgarchView) -> FinancetimemgarchView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_mgarch_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_mgarch_view_copy(s : FinancetimemgarchView) -> FinancetimemgarchView {
  let result = finance_time_mgarch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_mgarch_view_fill(s : FinancetimemgarchView, v : Double) -> FinancetimemgarchView {
  let result = finance_time_mgarch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_view_min(s : FinancetimemgarchView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_view_max(s : FinancetimemgarchView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_view_to_string(s : FinancetimemgarchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_range_make(size : Int) -> FinancetimemgarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_range_len(s : FinancetimemgarchRange) -> Int { s.size }

pub fn finance_time_mgarch_range_get(s : FinancetimemgarchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_range_set(s : FinancetimemgarchRange, i : Int, v : Double) -> FinancetimemgarchRange {
  let result = finance_time_mgarch_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_range_sum(s : FinancetimemgarchRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_mgarch_range_mean(s : FinancetimemgarchRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_mgarch_range_sum(s) / s.size.to_double() }
}

pub fn finance_time_mgarch_range_scale(s : FinancetimemgarchRange, f : Double) -> FinancetimemgarchRange {
  let result = finance_time_mgarch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_mgarch_range_add(a : FinancetimemgarchRange, b : FinancetimemgarchRange) -> FinancetimemgarchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_mgarch_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_mgarch_range_copy(s : FinancetimemgarchRange) -> FinancetimemgarchRange {
  let result = finance_time_mgarch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_mgarch_range_fill(s : FinancetimemgarchRange, v : Double) -> FinancetimemgarchRange {
  let result = finance_time_mgarch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_range_min(s : FinancetimemgarchRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_range_max(s : FinancetimemgarchRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_range_to_string(s : FinancetimemgarchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_slice_make(size : Int) -> FinancetimemgarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_slice_len(s : FinancetimemgarchSlice) -> Int { s.size }

pub fn finance_time_mgarch_slice_get(s : FinancetimemgarchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_slice_set(s : FinancetimemgarchSlice, i : Int, v : Double) -> FinancetimemgarchSlice {
  let result = finance_time_mgarch_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_slice_sum(s : FinancetimemgarchSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_mgarch_slice_mean(s : FinancetimemgarchSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_mgarch_slice_sum(s) / s.size.to_double() }
}

pub fn finance_time_mgarch_slice_scale(s : FinancetimemgarchSlice, f : Double) -> FinancetimemgarchSlice {
  let result = finance_time_mgarch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_mgarch_slice_add(a : FinancetimemgarchSlice, b : FinancetimemgarchSlice) -> FinancetimemgarchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_mgarch_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_mgarch_slice_copy(s : FinancetimemgarchSlice) -> FinancetimemgarchSlice {
  let result = finance_time_mgarch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_mgarch_slice_fill(s : FinancetimemgarchSlice, v : Double) -> FinancetimemgarchSlice {
  let result = finance_time_mgarch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_mgarch_slice_min(s : FinancetimemgarchSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_slice_max(s : FinancetimemgarchSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_mgarch_slice_to_string(s : FinancetimemgarchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

