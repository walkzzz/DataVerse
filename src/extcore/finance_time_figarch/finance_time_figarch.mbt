///===
/// extcore/finance_time_figarch

pub(all) struct FinancetimefigarchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_figarch_make_point(x : Double, y : Double) -> FinancetimefigarchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_figarch_make_point3(x : Double, y : Double, z : Double) -> FinancetimefigarchPoint {
  { x, y, z, label: 0 }
}

pub fn finance_time_figarch_point_x(pt : FinancetimefigarchPoint) -> Double { pt.x }

pub fn finance_time_figarch_point_y(pt : FinancetimefigarchPoint) -> Double { pt.y }

pub fn finance_time_figarch_point_z(pt : FinancetimefigarchPoint) -> Double { pt.z }

pub fn finance_time_figarch_point_label(pt : FinancetimefigarchPoint) -> Int { pt.label }

pub fn finance_time_figarch_point_dist(a : FinancetimefigarchPoint, b : FinancetimefigarchPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  finance_time_figarch_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_time_figarch_point_add(a : FinancetimefigarchPoint, b : FinancetimefigarchPoint) -> FinancetimefigarchPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_time_figarch_point_sub(a : FinancetimefigarchPoint, b : FinancetimefigarchPoint) -> FinancetimefigarchPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_time_figarch_point_scale(pt : FinancetimefigarchPoint, s : Double) -> FinancetimefigarchPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_time_figarch_point_dot(a : FinancetimefigarchPoint, b : FinancetimefigarchPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_time_figarch_point_cross(a : FinancetimefigarchPoint, b : FinancetimefigarchPoint) -> FinancetimefigarchPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_time_figarch_point_norm(pt : FinancetimefigarchPoint) -> Double {
  finance_time_figarch_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_time_figarch_point_normalize(pt : FinancetimefigarchPoint) -> FinancetimefigarchPoint {
  let n = finance_time_figarch_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_time_figarch_point_scale(pt, 1.0 / n) }
}

pub fn finance_time_figarch_point_negate(pt : FinancetimefigarchPoint) -> FinancetimefigarchPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_time_figarch_point_mid(a : FinancetimefigarchPoint, b : FinancetimefigarchPoint) -> FinancetimefigarchPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_time_figarch_point_lerp(a : FinancetimefigarchPoint, b : FinancetimefigarchPoint, t : Double) -> FinancetimefigarchPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_time_figarch_point_to_string(pt : FinancetimefigarchPoint) -> String {
  "(" + finance_time_figarch_dbl(pt.x) + ", " + finance_time_figarch_dbl(pt.y) + ", " + finance_time_figarch_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancetimefigarchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_figarch_make_series(vals : Array[Double], name : String) -> FinancetimefigarchSeries {
  { vals, name, meta: 0 }
}

pub fn finance_time_figarch_series_len(s : FinancetimefigarchSeries) -> Int { s.vals.length() }

pub fn finance_time_figarch_series_sum(s : FinancetimefigarchSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_time_figarch_series_mean(s : FinancetimefigarchSeries) -> Double {
  let n = finance_time_figarch_series_len(s)
  if n == 0 { 0.0 } else { finance_time_figarch_series_sum(s) / n.to_double() }
}

pub fn finance_time_figarch_series_min(s : FinancetimefigarchSeries) -> Double {
  let n = finance_time_figarch_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_time_figarch_series_max(s : FinancetimefigarchSeries) -> Double {
  let n = finance_time_figarch_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_time_figarch_series_range(s : FinancetimefigarchSeries) -> Double {
  finance_time_figarch_series_max(s) - finance_time_figarch_series_min(s)
}

pub fn finance_time_figarch_series_var(s : FinancetimefigarchSeries) -> Double {
  let n = finance_time_figarch_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_time_figarch_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_time_figarch_series_std(s : FinancetimefigarchSeries) -> Double { finance_time_figarch_sqrt(finance_time_figarch_series_var(s)) }

pub fn finance_time_figarch_series_median(s : FinancetimefigarchSeries) -> Double {
  let n = finance_time_figarch_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_time_figarch_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_time_figarch_series_scale(s : FinancetimefigarchSeries, f : Double) -> FinancetimefigarchSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = finance_time_figarch_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_time_figarch_series_add(a : FinancetimefigarchSeries, b : FinancetimefigarchSeries) -> FinancetimefigarchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_time_figarch_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_time_figarch_series_sub(a : FinancetimefigarchSeries, b : FinancetimefigarchSeries) -> FinancetimefigarchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_time_figarch_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_time_figarch_series_normalize(s : FinancetimefigarchSeries) -> FinancetimefigarchSeries {
  let mn = finance_time_figarch_series_min(s)
  let mx = finance_time_figarch_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = finance_time_figarch_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_time_figarch_series_cumsum(s : FinancetimefigarchSeries) -> FinancetimefigarchSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = finance_time_figarch_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_time_figarch_series_to_string(s : FinancetimefigarchSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_time_figarch_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimefigarchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_figarch_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimefigarchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_figarch_matrix_identity(n : Int) -> FinancetimefigarchMatrix {
  let m = finance_time_figarch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_time_figarch_matrix_get(m : FinancetimefigarchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_time_figarch_matrix_transpose(m : FinancetimefigarchMatrix) -> FinancetimefigarchMatrix {
  let result = finance_time_figarch_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_time_figarch_matrix_add(a : FinancetimefigarchMatrix, b : FinancetimefigarchMatrix) -> FinancetimefigarchMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_time_figarch_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_time_figarch_matrix_scale(m : FinancetimefigarchMatrix, s : Double) -> FinancetimefigarchMatrix {
  let result = finance_time_figarch_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_time_figarch_matrix_multiply(a : FinancetimefigarchMatrix, b : FinancetimefigarchMatrix) -> FinancetimefigarchMatrix {
  if a.cols != b.rows { return finance_time_figarch_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_time_figarch_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_time_figarch_matrix_trace(m : FinancetimefigarchMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_time_figarch_matrix_det(m : FinancetimefigarchMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_time_figarch_matrix_norm(m : FinancetimefigarchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  finance_time_figarch_sqrt(sum)
}

pub fn finance_time_figarch_matrix_to_string(m : FinancetimefigarchMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + finance_time_figarch_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct FinancetimefigarchVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_figarch_make_vector(comps : Array[Double]) -> FinancetimefigarchVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_figarch_vector_zero(dim : Int) -> FinancetimefigarchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_time_figarch_vector_add(a : FinancetimefigarchVector, b : FinancetimefigarchVector) -> FinancetimefigarchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_time_figarch_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_figarch_vector_sub(a : FinancetimefigarchVector, b : FinancetimefigarchVector) -> FinancetimefigarchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_time_figarch_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_figarch_vector_scale(v : FinancetimefigarchVector, s : Double) -> FinancetimefigarchVector {
  let mut result = []
  for i in 0..<v.dim { result = finance_time_figarch_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_time_figarch_vector_dot(a : FinancetimefigarchVector, b : FinancetimefigarchVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_time_figarch_vector_norm(v : FinancetimefigarchVector) -> Double { finance_time_figarch_sqrt(finance_time_figarch_vector_dot(v, v)) }

pub fn finance_time_figarch_vector_normalize(v : FinancetimefigarchVector) -> FinancetimefigarchVector {
  let n = finance_time_figarch_vector_norm(v)
  if n < 0.0000001 { v } else { finance_time_figarch_vector_scale(v, 1.0 / n) }
}

pub fn finance_time_figarch_vector_dist(a : FinancetimefigarchVector, b : FinancetimefigarchVector) -> Double {
  finance_time_figarch_vector_norm(finance_time_figarch_vector_sub(a, b))
}

pub fn finance_time_figarch_vector_to_string(v : FinancetimefigarchVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_time_figarch_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_time_figarch_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn finance_time_figarch_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = finance_time_figarch_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_time_figarch_std(data : Array[Double]) -> Double { finance_time_figarch_sqrt(finance_time_figarch_var(data)) }

pub fn finance_time_figarch_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = finance_time_figarch_mean(a); let mb = finance_time_figarch_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn finance_time_figarch_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = finance_time_figarch_std(a); let sb = finance_time_figarch_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { finance_time_figarch_cov(a, b) / (sa * sb) }
}

pub fn finance_time_figarch_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = finance_time_figarch_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_time_figarch_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn finance_time_figarch_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_time_figarch_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  finance_time_figarch_sqrt(finance_time_figarch_mse(pred, labels))
}

pub fn finance_time_figarch_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + finance_time_figarch_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn finance_time_figarch_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = finance_time_figarch_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn finance_time_figarch_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn finance_time_figarch_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn finance_time_figarch_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = finance_time_figarch_precision(pred, labels, pos); let r = finance_time_figarch_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn finance_time_figarch_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn finance_time_figarch_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = finance_time_figarch_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn finance_time_figarch_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn finance_time_figarch_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn finance_time_figarch_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = finance_time_figarch_gcd(a, b)
    (a / g) * b
  }
}

pub fn finance_time_figarch_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn finance_time_figarch_fibonacci(n : Int) -> Int {
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

pub fn finance_time_figarch_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = finance_time_figarch_min(data); let mx = finance_time_figarch_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn finance_time_figarch_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = finance_time_figarch_mean(data); let sd = finance_time_figarch_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn finance_time_figarch_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn finance_time_figarch_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn finance_time_figarch_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn finance_time_figarch_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn finance_time_figarch_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn finance_time_figarch_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn finance_time_figarch_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn finance_time_figarch_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn finance_time_figarch_dbl(x : Double) -> String {
  let i = if x >= 0.0 { finance_time_figarch_int(x) } else { -finance_time_figarch_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { finance_time_figarch_int(f * 1000000.0) } else { finance_time_figarch_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn finance_time_figarch_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn finance_time_figarch_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct FinancetimefigarchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_frame_make(size : Int) -> FinancetimefigarchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_frame_len(s : FinancetimefigarchFrame) -> Int { s.size }

pub fn finance_time_figarch_frame_get(s : FinancetimefigarchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_frame_set(s : FinancetimefigarchFrame, i : Int, v : Double) -> FinancetimefigarchFrame {
  let result = finance_time_figarch_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_frame_sum(s : FinancetimefigarchFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_figarch_frame_mean(s : FinancetimefigarchFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_figarch_frame_sum(s) / s.size.to_double() }
}

pub fn finance_time_figarch_frame_scale(s : FinancetimefigarchFrame, f : Double) -> FinancetimefigarchFrame {
  let result = finance_time_figarch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_figarch_frame_add(a : FinancetimefigarchFrame, b : FinancetimefigarchFrame) -> FinancetimefigarchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_figarch_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_figarch_frame_copy(s : FinancetimefigarchFrame) -> FinancetimefigarchFrame {
  let result = finance_time_figarch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_figarch_frame_fill(s : FinancetimefigarchFrame, v : Double) -> FinancetimefigarchFrame {
  let result = finance_time_figarch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_frame_min(s : FinancetimefigarchFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_frame_max(s : FinancetimefigarchFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_frame_to_string(s : FinancetimefigarchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_table_make(size : Int) -> FinancetimefigarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_table_len(s : FinancetimefigarchTable) -> Int { s.size }

pub fn finance_time_figarch_table_get(s : FinancetimefigarchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_table_set(s : FinancetimefigarchTable, i : Int, v : Double) -> FinancetimefigarchTable {
  let result = finance_time_figarch_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_table_sum(s : FinancetimefigarchTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_figarch_table_mean(s : FinancetimefigarchTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_figarch_table_sum(s) / s.size.to_double() }
}

pub fn finance_time_figarch_table_scale(s : FinancetimefigarchTable, f : Double) -> FinancetimefigarchTable {
  let result = finance_time_figarch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_figarch_table_add(a : FinancetimefigarchTable, b : FinancetimefigarchTable) -> FinancetimefigarchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_figarch_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_figarch_table_copy(s : FinancetimefigarchTable) -> FinancetimefigarchTable {
  let result = finance_time_figarch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_figarch_table_fill(s : FinancetimefigarchTable, v : Double) -> FinancetimefigarchTable {
  let result = finance_time_figarch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_table_min(s : FinancetimefigarchTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_table_max(s : FinancetimefigarchTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_table_to_string(s : FinancetimefigarchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_graphn_make(size : Int) -> FinancetimefigarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_graphn_len(s : FinancetimefigarchGraphN) -> Int { s.size }

pub fn finance_time_figarch_graphn_get(s : FinancetimefigarchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_graphn_set(s : FinancetimefigarchGraphN, i : Int, v : Double) -> FinancetimefigarchGraphN {
  let result = finance_time_figarch_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_graphn_sum(s : FinancetimefigarchGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_figarch_graphn_mean(s : FinancetimefigarchGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_figarch_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_time_figarch_graphn_scale(s : FinancetimefigarchGraphN, f : Double) -> FinancetimefigarchGraphN {
  let result = finance_time_figarch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_figarch_graphn_add(a : FinancetimefigarchGraphN, b : FinancetimefigarchGraphN) -> FinancetimefigarchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_figarch_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_figarch_graphn_copy(s : FinancetimefigarchGraphN) -> FinancetimefigarchGraphN {
  let result = finance_time_figarch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_figarch_graphn_fill(s : FinancetimefigarchGraphN, v : Double) -> FinancetimefigarchGraphN {
  let result = finance_time_figarch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_graphn_min(s : FinancetimefigarchGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_graphn_max(s : FinancetimefigarchGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_graphn_to_string(s : FinancetimefigarchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_node_make(size : Int) -> FinancetimefigarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_node_len(s : FinancetimefigarchNode) -> Int { s.size }

pub fn finance_time_figarch_node_get(s : FinancetimefigarchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_node_set(s : FinancetimefigarchNode, i : Int, v : Double) -> FinancetimefigarchNode {
  let result = finance_time_figarch_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_node_sum(s : FinancetimefigarchNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_figarch_node_mean(s : FinancetimefigarchNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_figarch_node_sum(s) / s.size.to_double() }
}

pub fn finance_time_figarch_node_scale(s : FinancetimefigarchNode, f : Double) -> FinancetimefigarchNode {
  let result = finance_time_figarch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_figarch_node_add(a : FinancetimefigarchNode, b : FinancetimefigarchNode) -> FinancetimefigarchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_figarch_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_figarch_node_copy(s : FinancetimefigarchNode) -> FinancetimefigarchNode {
  let result = finance_time_figarch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_figarch_node_fill(s : FinancetimefigarchNode, v : Double) -> FinancetimefigarchNode {
  let result = finance_time_figarch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_node_min(s : FinancetimefigarchNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_node_max(s : FinancetimefigarchNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_node_to_string(s : FinancetimefigarchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_edge_make(size : Int) -> FinancetimefigarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_edge_len(s : FinancetimefigarchEdge) -> Int { s.size }

pub fn finance_time_figarch_edge_get(s : FinancetimefigarchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_edge_set(s : FinancetimefigarchEdge, i : Int, v : Double) -> FinancetimefigarchEdge {
  let result = finance_time_figarch_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_edge_sum(s : FinancetimefigarchEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_figarch_edge_mean(s : FinancetimefigarchEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_figarch_edge_sum(s) / s.size.to_double() }
}

pub fn finance_time_figarch_edge_scale(s : FinancetimefigarchEdge, f : Double) -> FinancetimefigarchEdge {
  let result = finance_time_figarch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_figarch_edge_add(a : FinancetimefigarchEdge, b : FinancetimefigarchEdge) -> FinancetimefigarchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_figarch_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_figarch_edge_copy(s : FinancetimefigarchEdge) -> FinancetimefigarchEdge {
  let result = finance_time_figarch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_figarch_edge_fill(s : FinancetimefigarchEdge, v : Double) -> FinancetimefigarchEdge {
  let result = finance_time_figarch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_edge_min(s : FinancetimefigarchEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_edge_max(s : FinancetimefigarchEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_edge_to_string(s : FinancetimefigarchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_path_make(size : Int) -> FinancetimefigarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_path_len(s : FinancetimefigarchPath) -> Int { s.size }

pub fn finance_time_figarch_path_get(s : FinancetimefigarchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_path_set(s : FinancetimefigarchPath, i : Int, v : Double) -> FinancetimefigarchPath {
  let result = finance_time_figarch_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_path_sum(s : FinancetimefigarchPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_figarch_path_mean(s : FinancetimefigarchPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_figarch_path_sum(s) / s.size.to_double() }
}

pub fn finance_time_figarch_path_scale(s : FinancetimefigarchPath, f : Double) -> FinancetimefigarchPath {
  let result = finance_time_figarch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_figarch_path_add(a : FinancetimefigarchPath, b : FinancetimefigarchPath) -> FinancetimefigarchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_figarch_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_figarch_path_copy(s : FinancetimefigarchPath) -> FinancetimefigarchPath {
  let result = finance_time_figarch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_figarch_path_fill(s : FinancetimefigarchPath, v : Double) -> FinancetimefigarchPath {
  let result = finance_time_figarch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_path_min(s : FinancetimefigarchPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_path_max(s : FinancetimefigarchPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_path_to_string(s : FinancetimefigarchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_cluster_make(size : Int) -> FinancetimefigarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_cluster_len(s : FinancetimefigarchCluster) -> Int { s.size }

pub fn finance_time_figarch_cluster_get(s : FinancetimefigarchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_cluster_set(s : FinancetimefigarchCluster, i : Int, v : Double) -> FinancetimefigarchCluster {
  let result = finance_time_figarch_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_cluster_sum(s : FinancetimefigarchCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_figarch_cluster_mean(s : FinancetimefigarchCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_figarch_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_time_figarch_cluster_scale(s : FinancetimefigarchCluster, f : Double) -> FinancetimefigarchCluster {
  let result = finance_time_figarch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_figarch_cluster_add(a : FinancetimefigarchCluster, b : FinancetimefigarchCluster) -> FinancetimefigarchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_figarch_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_figarch_cluster_copy(s : FinancetimefigarchCluster) -> FinancetimefigarchCluster {
  let result = finance_time_figarch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_figarch_cluster_fill(s : FinancetimefigarchCluster, v : Double) -> FinancetimefigarchCluster {
  let result = finance_time_figarch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_cluster_min(s : FinancetimefigarchCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_cluster_max(s : FinancetimefigarchCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_cluster_to_string(s : FinancetimefigarchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_model_make(size : Int) -> FinancetimefigarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_model_len(s : FinancetimefigarchModel) -> Int { s.size }

pub fn finance_time_figarch_model_get(s : FinancetimefigarchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_model_set(s : FinancetimefigarchModel, i : Int, v : Double) -> FinancetimefigarchModel {
  let result = finance_time_figarch_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_model_sum(s : FinancetimefigarchModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_figarch_model_mean(s : FinancetimefigarchModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_figarch_model_sum(s) / s.size.to_double() }
}

pub fn finance_time_figarch_model_scale(s : FinancetimefigarchModel, f : Double) -> FinancetimefigarchModel {
  let result = finance_time_figarch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_figarch_model_add(a : FinancetimefigarchModel, b : FinancetimefigarchModel) -> FinancetimefigarchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_figarch_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_figarch_model_copy(s : FinancetimefigarchModel) -> FinancetimefigarchModel {
  let result = finance_time_figarch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_figarch_model_fill(s : FinancetimefigarchModel, v : Double) -> FinancetimefigarchModel {
  let result = finance_time_figarch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_model_min(s : FinancetimefigarchModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_model_max(s : FinancetimefigarchModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_model_to_string(s : FinancetimefigarchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_layer_make(size : Int) -> FinancetimefigarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_layer_len(s : FinancetimefigarchLayer) -> Int { s.size }

pub fn finance_time_figarch_layer_get(s : FinancetimefigarchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_layer_set(s : FinancetimefigarchLayer, i : Int, v : Double) -> FinancetimefigarchLayer {
  let result = finance_time_figarch_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_layer_sum(s : FinancetimefigarchLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_figarch_layer_mean(s : FinancetimefigarchLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_figarch_layer_sum(s) / s.size.to_double() }
}

pub fn finance_time_figarch_layer_scale(s : FinancetimefigarchLayer, f : Double) -> FinancetimefigarchLayer {
  let result = finance_time_figarch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_figarch_layer_add(a : FinancetimefigarchLayer, b : FinancetimefigarchLayer) -> FinancetimefigarchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_figarch_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_figarch_layer_copy(s : FinancetimefigarchLayer) -> FinancetimefigarchLayer {
  let result = finance_time_figarch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_figarch_layer_fill(s : FinancetimefigarchLayer, v : Double) -> FinancetimefigarchLayer {
  let result = finance_time_figarch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_layer_min(s : FinancetimefigarchLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_layer_max(s : FinancetimefigarchLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_layer_to_string(s : FinancetimefigarchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_buffer_make(size : Int) -> FinancetimefigarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_buffer_len(s : FinancetimefigarchBuffer) -> Int { s.size }

pub fn finance_time_figarch_buffer_get(s : FinancetimefigarchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_buffer_set(s : FinancetimefigarchBuffer, i : Int, v : Double) -> FinancetimefigarchBuffer {
  let result = finance_time_figarch_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_buffer_sum(s : FinancetimefigarchBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_figarch_buffer_mean(s : FinancetimefigarchBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_figarch_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_time_figarch_buffer_scale(s : FinancetimefigarchBuffer, f : Double) -> FinancetimefigarchBuffer {
  let result = finance_time_figarch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_figarch_buffer_add(a : FinancetimefigarchBuffer, b : FinancetimefigarchBuffer) -> FinancetimefigarchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_figarch_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_figarch_buffer_copy(s : FinancetimefigarchBuffer) -> FinancetimefigarchBuffer {
  let result = finance_time_figarch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_figarch_buffer_fill(s : FinancetimefigarchBuffer, v : Double) -> FinancetimefigarchBuffer {
  let result = finance_time_figarch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_buffer_min(s : FinancetimefigarchBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_buffer_max(s : FinancetimefigarchBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_buffer_to_string(s : FinancetimefigarchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_cursor_make(size : Int) -> FinancetimefigarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_cursor_len(s : FinancetimefigarchCursor) -> Int { s.size }

pub fn finance_time_figarch_cursor_get(s : FinancetimefigarchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_cursor_set(s : FinancetimefigarchCursor, i : Int, v : Double) -> FinancetimefigarchCursor {
  let result = finance_time_figarch_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_cursor_sum(s : FinancetimefigarchCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_figarch_cursor_mean(s : FinancetimefigarchCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_figarch_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_time_figarch_cursor_scale(s : FinancetimefigarchCursor, f : Double) -> FinancetimefigarchCursor {
  let result = finance_time_figarch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_figarch_cursor_add(a : FinancetimefigarchCursor, b : FinancetimefigarchCursor) -> FinancetimefigarchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_figarch_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_figarch_cursor_copy(s : FinancetimefigarchCursor) -> FinancetimefigarchCursor {
  let result = finance_time_figarch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_figarch_cursor_fill(s : FinancetimefigarchCursor, v : Double) -> FinancetimefigarchCursor {
  let result = finance_time_figarch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_cursor_min(s : FinancetimefigarchCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_cursor_max(s : FinancetimefigarchCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_cursor_to_string(s : FinancetimefigarchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_view_make(size : Int) -> FinancetimefigarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_view_len(s : FinancetimefigarchView) -> Int { s.size }

pub fn finance_time_figarch_view_get(s : FinancetimefigarchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_view_set(s : FinancetimefigarchView, i : Int, v : Double) -> FinancetimefigarchView {
  let result = finance_time_figarch_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_view_sum(s : FinancetimefigarchView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_figarch_view_mean(s : FinancetimefigarchView) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_figarch_view_sum(s) / s.size.to_double() }
}

pub fn finance_time_figarch_view_scale(s : FinancetimefigarchView, f : Double) -> FinancetimefigarchView {
  let result = finance_time_figarch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_figarch_view_add(a : FinancetimefigarchView, b : FinancetimefigarchView) -> FinancetimefigarchView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_figarch_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_figarch_view_copy(s : FinancetimefigarchView) -> FinancetimefigarchView {
  let result = finance_time_figarch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_figarch_view_fill(s : FinancetimefigarchView, v : Double) -> FinancetimefigarchView {
  let result = finance_time_figarch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_view_min(s : FinancetimefigarchView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_view_max(s : FinancetimefigarchView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_view_to_string(s : FinancetimefigarchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_range_make(size : Int) -> FinancetimefigarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_range_len(s : FinancetimefigarchRange) -> Int { s.size }

pub fn finance_time_figarch_range_get(s : FinancetimefigarchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_range_set(s : FinancetimefigarchRange, i : Int, v : Double) -> FinancetimefigarchRange {
  let result = finance_time_figarch_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_range_sum(s : FinancetimefigarchRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_figarch_range_mean(s : FinancetimefigarchRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_figarch_range_sum(s) / s.size.to_double() }
}

pub fn finance_time_figarch_range_scale(s : FinancetimefigarchRange, f : Double) -> FinancetimefigarchRange {
  let result = finance_time_figarch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_figarch_range_add(a : FinancetimefigarchRange, b : FinancetimefigarchRange) -> FinancetimefigarchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_figarch_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_figarch_range_copy(s : FinancetimefigarchRange) -> FinancetimefigarchRange {
  let result = finance_time_figarch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_figarch_range_fill(s : FinancetimefigarchRange, v : Double) -> FinancetimefigarchRange {
  let result = finance_time_figarch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_range_min(s : FinancetimefigarchRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_range_max(s : FinancetimefigarchRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_range_to_string(s : FinancetimefigarchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_slice_make(size : Int) -> FinancetimefigarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_slice_len(s : FinancetimefigarchSlice) -> Int { s.size }

pub fn finance_time_figarch_slice_get(s : FinancetimefigarchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_slice_set(s : FinancetimefigarchSlice, i : Int, v : Double) -> FinancetimefigarchSlice {
  let result = finance_time_figarch_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_slice_sum(s : FinancetimefigarchSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_figarch_slice_mean(s : FinancetimefigarchSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_figarch_slice_sum(s) / s.size.to_double() }
}

pub fn finance_time_figarch_slice_scale(s : FinancetimefigarchSlice, f : Double) -> FinancetimefigarchSlice {
  let result = finance_time_figarch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_figarch_slice_add(a : FinancetimefigarchSlice, b : FinancetimefigarchSlice) -> FinancetimefigarchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_figarch_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_figarch_slice_copy(s : FinancetimefigarchSlice) -> FinancetimefigarchSlice {
  let result = finance_time_figarch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_figarch_slice_fill(s : FinancetimefigarchSlice, v : Double) -> FinancetimefigarchSlice {
  let result = finance_time_figarch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_figarch_slice_min(s : FinancetimefigarchSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_slice_max(s : FinancetimefigarchSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_figarch_slice_to_string(s : FinancetimefigarchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn finance_time_figarch_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_figarch_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_figarch_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_figarch_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_figarch_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_figarch_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_figarch_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_figarch_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_figarch_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_figarch_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_figarch_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_figarch_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_figarch_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_figarch_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_figarch_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_figarch_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_figarch_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_figarch_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_figarch_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_figarch_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_figarch_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_figarch_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_figarch_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_figarch_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_figarch_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

