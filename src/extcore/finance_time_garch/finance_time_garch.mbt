///===
/// extcore/finance_time_garch

pub(all) struct FinancetimegarchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_garch_make_point(x : Double, y : Double) -> FinancetimegarchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_garch_make_point3(x : Double, y : Double, z : Double) -> FinancetimegarchPoint {
  { x, y, z, label: 0 }
}

pub fn finance_time_garch_point_x(pt : FinancetimegarchPoint) -> Double { pt.x }

pub fn finance_time_garch_point_y(pt : FinancetimegarchPoint) -> Double { pt.y }

pub fn finance_time_garch_point_z(pt : FinancetimegarchPoint) -> Double { pt.z }

pub fn finance_time_garch_point_label(pt : FinancetimegarchPoint) -> Int { pt.label }

pub fn finance_time_garch_point_dist(a : FinancetimegarchPoint, b : FinancetimegarchPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  finance_time_garch_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_time_garch_point_add(a : FinancetimegarchPoint, b : FinancetimegarchPoint) -> FinancetimegarchPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_time_garch_point_sub(a : FinancetimegarchPoint, b : FinancetimegarchPoint) -> FinancetimegarchPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_time_garch_point_scale(pt : FinancetimegarchPoint, s : Double) -> FinancetimegarchPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_time_garch_point_dot(a : FinancetimegarchPoint, b : FinancetimegarchPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_time_garch_point_cross(a : FinancetimegarchPoint, b : FinancetimegarchPoint) -> FinancetimegarchPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_time_garch_point_norm(pt : FinancetimegarchPoint) -> Double {
  finance_time_garch_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_time_garch_point_normalize(pt : FinancetimegarchPoint) -> FinancetimegarchPoint {
  let n = finance_time_garch_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_time_garch_point_scale(pt, 1.0 / n) }
}

pub fn finance_time_garch_point_negate(pt : FinancetimegarchPoint) -> FinancetimegarchPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_time_garch_point_mid(a : FinancetimegarchPoint, b : FinancetimegarchPoint) -> FinancetimegarchPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_time_garch_point_lerp(a : FinancetimegarchPoint, b : FinancetimegarchPoint, t : Double) -> FinancetimegarchPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_time_garch_point_to_string(pt : FinancetimegarchPoint) -> String {
  "(" + finance_time_garch_dbl(pt.x) + ", " + finance_time_garch_dbl(pt.y) + ", " + finance_time_garch_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancetimegarchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_garch_make_series(vals : Array[Double], name : String) -> FinancetimegarchSeries {
  { vals, name, meta: 0 }
}

pub fn finance_time_garch_series_len(s : FinancetimegarchSeries) -> Int { s.vals.length() }

pub fn finance_time_garch_series_sum(s : FinancetimegarchSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_time_garch_series_mean(s : FinancetimegarchSeries) -> Double {
  let n = finance_time_garch_series_len(s)
  if n == 0 { 0.0 } else { finance_time_garch_series_sum(s) / n.to_double() }
}

pub fn finance_time_garch_series_min(s : FinancetimegarchSeries) -> Double {
  let n = finance_time_garch_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_time_garch_series_max(s : FinancetimegarchSeries) -> Double {
  let n = finance_time_garch_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_time_garch_series_range(s : FinancetimegarchSeries) -> Double {
  finance_time_garch_series_max(s) - finance_time_garch_series_min(s)
}

pub fn finance_time_garch_series_var(s : FinancetimegarchSeries) -> Double {
  let n = finance_time_garch_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_time_garch_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_time_garch_series_std(s : FinancetimegarchSeries) -> Double { finance_time_garch_sqrt(finance_time_garch_series_var(s)) }

pub fn finance_time_garch_series_median(s : FinancetimegarchSeries) -> Double {
  let n = finance_time_garch_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_time_garch_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_time_garch_series_scale(s : FinancetimegarchSeries, f : Double) -> FinancetimegarchSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = finance_time_garch_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_time_garch_series_add(a : FinancetimegarchSeries, b : FinancetimegarchSeries) -> FinancetimegarchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_time_garch_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_time_garch_series_sub(a : FinancetimegarchSeries, b : FinancetimegarchSeries) -> FinancetimegarchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_time_garch_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_time_garch_series_normalize(s : FinancetimegarchSeries) -> FinancetimegarchSeries {
  let mn = finance_time_garch_series_min(s)
  let mx = finance_time_garch_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = finance_time_garch_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_time_garch_series_cumsum(s : FinancetimegarchSeries) -> FinancetimegarchSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = finance_time_garch_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_time_garch_series_to_string(s : FinancetimegarchSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_time_garch_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimegarchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_garch_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimegarchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_garch_matrix_identity(n : Int) -> FinancetimegarchMatrix {
  let m = finance_time_garch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_time_garch_matrix_get(m : FinancetimegarchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_time_garch_matrix_transpose(m : FinancetimegarchMatrix) -> FinancetimegarchMatrix {
  let result = finance_time_garch_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_time_garch_matrix_add(a : FinancetimegarchMatrix, b : FinancetimegarchMatrix) -> FinancetimegarchMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_time_garch_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_time_garch_matrix_scale(m : FinancetimegarchMatrix, s : Double) -> FinancetimegarchMatrix {
  let result = finance_time_garch_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_time_garch_matrix_multiply(a : FinancetimegarchMatrix, b : FinancetimegarchMatrix) -> FinancetimegarchMatrix {
  if a.cols != b.rows { return finance_time_garch_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_time_garch_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_time_garch_matrix_trace(m : FinancetimegarchMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_time_garch_matrix_det(m : FinancetimegarchMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_time_garch_matrix_norm(m : FinancetimegarchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  finance_time_garch_sqrt(sum)
}

pub fn finance_time_garch_matrix_to_string(m : FinancetimegarchMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + finance_time_garch_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct FinancetimegarchVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_garch_make_vector(comps : Array[Double]) -> FinancetimegarchVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_garch_vector_zero(dim : Int) -> FinancetimegarchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_time_garch_vector_add(a : FinancetimegarchVector, b : FinancetimegarchVector) -> FinancetimegarchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_time_garch_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_garch_vector_sub(a : FinancetimegarchVector, b : FinancetimegarchVector) -> FinancetimegarchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_time_garch_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_garch_vector_scale(v : FinancetimegarchVector, s : Double) -> FinancetimegarchVector {
  let mut result = []
  for i in 0..<v.dim { result = finance_time_garch_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_time_garch_vector_dot(a : FinancetimegarchVector, b : FinancetimegarchVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_time_garch_vector_norm(v : FinancetimegarchVector) -> Double { finance_time_garch_sqrt(finance_time_garch_vector_dot(v, v)) }

pub fn finance_time_garch_vector_normalize(v : FinancetimegarchVector) -> FinancetimegarchVector {
  let n = finance_time_garch_vector_norm(v)
  if n < 0.0000001 { v } else { finance_time_garch_vector_scale(v, 1.0 / n) }
}

pub fn finance_time_garch_vector_dist(a : FinancetimegarchVector, b : FinancetimegarchVector) -> Double {
  finance_time_garch_vector_norm(finance_time_garch_vector_sub(a, b))
}

pub fn finance_time_garch_vector_to_string(v : FinancetimegarchVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_time_garch_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_time_garch_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn finance_time_garch_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = finance_time_garch_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_time_garch_std(data : Array[Double]) -> Double { finance_time_garch_sqrt(finance_time_garch_var(data)) }

pub fn finance_time_garch_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = finance_time_garch_mean(a); let mb = finance_time_garch_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn finance_time_garch_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = finance_time_garch_std(a); let sb = finance_time_garch_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { finance_time_garch_cov(a, b) / (sa * sb) }
}

pub fn finance_time_garch_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = finance_time_garch_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_time_garch_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn finance_time_garch_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_time_garch_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  finance_time_garch_sqrt(finance_time_garch_mse(pred, labels))
}

pub fn finance_time_garch_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + finance_time_garch_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn finance_time_garch_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = finance_time_garch_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn finance_time_garch_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn finance_time_garch_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn finance_time_garch_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = finance_time_garch_precision(pred, labels, pos); let r = finance_time_garch_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn finance_time_garch_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn finance_time_garch_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = finance_time_garch_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn finance_time_garch_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn finance_time_garch_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn finance_time_garch_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = finance_time_garch_gcd(a, b)
    (a / g) * b
  }
}

pub fn finance_time_garch_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn finance_time_garch_fibonacci(n : Int) -> Int {
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

pub fn finance_time_garch_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = finance_time_garch_min(data); let mx = finance_time_garch_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn finance_time_garch_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = finance_time_garch_mean(data); let sd = finance_time_garch_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn finance_time_garch_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn finance_time_garch_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn finance_time_garch_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn finance_time_garch_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn finance_time_garch_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn finance_time_garch_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn finance_time_garch_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn finance_time_garch_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn finance_time_garch_dbl(x : Double) -> String {
  let i = if x >= 0.0 { finance_time_garch_int(x) } else { -finance_time_garch_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { finance_time_garch_int(f * 1000000.0) } else { finance_time_garch_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn finance_time_garch_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn finance_time_garch_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct FinancetimegarchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_frame_make(size : Int) -> FinancetimegarchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_frame_len(s : FinancetimegarchFrame) -> Int { s.size }

pub fn finance_time_garch_frame_get(s : FinancetimegarchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_frame_set(s : FinancetimegarchFrame, i : Int, v : Double) -> FinancetimegarchFrame {
  let result = finance_time_garch_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_frame_sum(s : FinancetimegarchFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_garch_frame_mean(s : FinancetimegarchFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_garch_frame_sum(s) / s.size.to_double() }
}

pub fn finance_time_garch_frame_scale(s : FinancetimegarchFrame, f : Double) -> FinancetimegarchFrame {
  let result = finance_time_garch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_frame_add(a : FinancetimegarchFrame, b : FinancetimegarchFrame) -> FinancetimegarchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_frame_copy(s : FinancetimegarchFrame) -> FinancetimegarchFrame {
  let result = finance_time_garch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_frame_fill(s : FinancetimegarchFrame, v : Double) -> FinancetimegarchFrame {
  let result = finance_time_garch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_frame_min(s : FinancetimegarchFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_frame_max(s : FinancetimegarchFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_frame_to_string(s : FinancetimegarchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_table_make(size : Int) -> FinancetimegarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_table_len(s : FinancetimegarchTable) -> Int { s.size }

pub fn finance_time_garch_table_get(s : FinancetimegarchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_table_set(s : FinancetimegarchTable, i : Int, v : Double) -> FinancetimegarchTable {
  let result = finance_time_garch_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_table_sum(s : FinancetimegarchTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_garch_table_mean(s : FinancetimegarchTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_garch_table_sum(s) / s.size.to_double() }
}

pub fn finance_time_garch_table_scale(s : FinancetimegarchTable, f : Double) -> FinancetimegarchTable {
  let result = finance_time_garch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_table_add(a : FinancetimegarchTable, b : FinancetimegarchTable) -> FinancetimegarchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_table_copy(s : FinancetimegarchTable) -> FinancetimegarchTable {
  let result = finance_time_garch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_table_fill(s : FinancetimegarchTable, v : Double) -> FinancetimegarchTable {
  let result = finance_time_garch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_table_min(s : FinancetimegarchTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_table_max(s : FinancetimegarchTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_table_to_string(s : FinancetimegarchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_graphn_make(size : Int) -> FinancetimegarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_graphn_len(s : FinancetimegarchGraphN) -> Int { s.size }

pub fn finance_time_garch_graphn_get(s : FinancetimegarchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_graphn_set(s : FinancetimegarchGraphN, i : Int, v : Double) -> FinancetimegarchGraphN {
  let result = finance_time_garch_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_graphn_sum(s : FinancetimegarchGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_garch_graphn_mean(s : FinancetimegarchGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_garch_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_time_garch_graphn_scale(s : FinancetimegarchGraphN, f : Double) -> FinancetimegarchGraphN {
  let result = finance_time_garch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_graphn_add(a : FinancetimegarchGraphN, b : FinancetimegarchGraphN) -> FinancetimegarchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_graphn_copy(s : FinancetimegarchGraphN) -> FinancetimegarchGraphN {
  let result = finance_time_garch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_graphn_fill(s : FinancetimegarchGraphN, v : Double) -> FinancetimegarchGraphN {
  let result = finance_time_garch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_graphn_min(s : FinancetimegarchGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_graphn_max(s : FinancetimegarchGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_graphn_to_string(s : FinancetimegarchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_node_make(size : Int) -> FinancetimegarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_node_len(s : FinancetimegarchNode) -> Int { s.size }

pub fn finance_time_garch_node_get(s : FinancetimegarchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_node_set(s : FinancetimegarchNode, i : Int, v : Double) -> FinancetimegarchNode {
  let result = finance_time_garch_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_node_sum(s : FinancetimegarchNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_garch_node_mean(s : FinancetimegarchNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_garch_node_sum(s) / s.size.to_double() }
}

pub fn finance_time_garch_node_scale(s : FinancetimegarchNode, f : Double) -> FinancetimegarchNode {
  let result = finance_time_garch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_node_add(a : FinancetimegarchNode, b : FinancetimegarchNode) -> FinancetimegarchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_node_copy(s : FinancetimegarchNode) -> FinancetimegarchNode {
  let result = finance_time_garch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_node_fill(s : FinancetimegarchNode, v : Double) -> FinancetimegarchNode {
  let result = finance_time_garch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_node_min(s : FinancetimegarchNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_node_max(s : FinancetimegarchNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_node_to_string(s : FinancetimegarchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_edge_make(size : Int) -> FinancetimegarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_edge_len(s : FinancetimegarchEdge) -> Int { s.size }

pub fn finance_time_garch_edge_get(s : FinancetimegarchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_edge_set(s : FinancetimegarchEdge, i : Int, v : Double) -> FinancetimegarchEdge {
  let result = finance_time_garch_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_edge_sum(s : FinancetimegarchEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_garch_edge_mean(s : FinancetimegarchEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_garch_edge_sum(s) / s.size.to_double() }
}

pub fn finance_time_garch_edge_scale(s : FinancetimegarchEdge, f : Double) -> FinancetimegarchEdge {
  let result = finance_time_garch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_edge_add(a : FinancetimegarchEdge, b : FinancetimegarchEdge) -> FinancetimegarchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_edge_copy(s : FinancetimegarchEdge) -> FinancetimegarchEdge {
  let result = finance_time_garch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_edge_fill(s : FinancetimegarchEdge, v : Double) -> FinancetimegarchEdge {
  let result = finance_time_garch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_edge_min(s : FinancetimegarchEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_edge_max(s : FinancetimegarchEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_edge_to_string(s : FinancetimegarchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_path_make(size : Int) -> FinancetimegarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_path_len(s : FinancetimegarchPath) -> Int { s.size }

pub fn finance_time_garch_path_get(s : FinancetimegarchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_path_set(s : FinancetimegarchPath, i : Int, v : Double) -> FinancetimegarchPath {
  let result = finance_time_garch_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_path_sum(s : FinancetimegarchPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_garch_path_mean(s : FinancetimegarchPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_garch_path_sum(s) / s.size.to_double() }
}

pub fn finance_time_garch_path_scale(s : FinancetimegarchPath, f : Double) -> FinancetimegarchPath {
  let result = finance_time_garch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_path_add(a : FinancetimegarchPath, b : FinancetimegarchPath) -> FinancetimegarchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_path_copy(s : FinancetimegarchPath) -> FinancetimegarchPath {
  let result = finance_time_garch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_path_fill(s : FinancetimegarchPath, v : Double) -> FinancetimegarchPath {
  let result = finance_time_garch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_path_min(s : FinancetimegarchPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_path_max(s : FinancetimegarchPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_path_to_string(s : FinancetimegarchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_cluster_make(size : Int) -> FinancetimegarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_cluster_len(s : FinancetimegarchCluster) -> Int { s.size }

pub fn finance_time_garch_cluster_get(s : FinancetimegarchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_cluster_set(s : FinancetimegarchCluster, i : Int, v : Double) -> FinancetimegarchCluster {
  let result = finance_time_garch_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_cluster_sum(s : FinancetimegarchCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_garch_cluster_mean(s : FinancetimegarchCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_garch_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_time_garch_cluster_scale(s : FinancetimegarchCluster, f : Double) -> FinancetimegarchCluster {
  let result = finance_time_garch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_cluster_add(a : FinancetimegarchCluster, b : FinancetimegarchCluster) -> FinancetimegarchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_cluster_copy(s : FinancetimegarchCluster) -> FinancetimegarchCluster {
  let result = finance_time_garch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_cluster_fill(s : FinancetimegarchCluster, v : Double) -> FinancetimegarchCluster {
  let result = finance_time_garch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_cluster_min(s : FinancetimegarchCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_cluster_max(s : FinancetimegarchCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_cluster_to_string(s : FinancetimegarchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_model_make(size : Int) -> FinancetimegarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_model_len(s : FinancetimegarchModel) -> Int { s.size }

pub fn finance_time_garch_model_get(s : FinancetimegarchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_model_set(s : FinancetimegarchModel, i : Int, v : Double) -> FinancetimegarchModel {
  let result = finance_time_garch_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_model_sum(s : FinancetimegarchModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_garch_model_mean(s : FinancetimegarchModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_garch_model_sum(s) / s.size.to_double() }
}

pub fn finance_time_garch_model_scale(s : FinancetimegarchModel, f : Double) -> FinancetimegarchModel {
  let result = finance_time_garch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_model_add(a : FinancetimegarchModel, b : FinancetimegarchModel) -> FinancetimegarchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_model_copy(s : FinancetimegarchModel) -> FinancetimegarchModel {
  let result = finance_time_garch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_model_fill(s : FinancetimegarchModel, v : Double) -> FinancetimegarchModel {
  let result = finance_time_garch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_model_min(s : FinancetimegarchModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_model_max(s : FinancetimegarchModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_model_to_string(s : FinancetimegarchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_layer_make(size : Int) -> FinancetimegarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_layer_len(s : FinancetimegarchLayer) -> Int { s.size }

pub fn finance_time_garch_layer_get(s : FinancetimegarchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_layer_set(s : FinancetimegarchLayer, i : Int, v : Double) -> FinancetimegarchLayer {
  let result = finance_time_garch_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_layer_sum(s : FinancetimegarchLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_garch_layer_mean(s : FinancetimegarchLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_garch_layer_sum(s) / s.size.to_double() }
}

pub fn finance_time_garch_layer_scale(s : FinancetimegarchLayer, f : Double) -> FinancetimegarchLayer {
  let result = finance_time_garch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_layer_add(a : FinancetimegarchLayer, b : FinancetimegarchLayer) -> FinancetimegarchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_layer_copy(s : FinancetimegarchLayer) -> FinancetimegarchLayer {
  let result = finance_time_garch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_layer_fill(s : FinancetimegarchLayer, v : Double) -> FinancetimegarchLayer {
  let result = finance_time_garch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_layer_min(s : FinancetimegarchLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_layer_max(s : FinancetimegarchLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_layer_to_string(s : FinancetimegarchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_buffer_make(size : Int) -> FinancetimegarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_buffer_len(s : FinancetimegarchBuffer) -> Int { s.size }

pub fn finance_time_garch_buffer_get(s : FinancetimegarchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_buffer_set(s : FinancetimegarchBuffer, i : Int, v : Double) -> FinancetimegarchBuffer {
  let result = finance_time_garch_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_buffer_sum(s : FinancetimegarchBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_garch_buffer_mean(s : FinancetimegarchBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_garch_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_time_garch_buffer_scale(s : FinancetimegarchBuffer, f : Double) -> FinancetimegarchBuffer {
  let result = finance_time_garch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_buffer_add(a : FinancetimegarchBuffer, b : FinancetimegarchBuffer) -> FinancetimegarchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_buffer_copy(s : FinancetimegarchBuffer) -> FinancetimegarchBuffer {
  let result = finance_time_garch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_buffer_fill(s : FinancetimegarchBuffer, v : Double) -> FinancetimegarchBuffer {
  let result = finance_time_garch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_buffer_min(s : FinancetimegarchBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_buffer_max(s : FinancetimegarchBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_buffer_to_string(s : FinancetimegarchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_cursor_make(size : Int) -> FinancetimegarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_cursor_len(s : FinancetimegarchCursor) -> Int { s.size }

pub fn finance_time_garch_cursor_get(s : FinancetimegarchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_cursor_set(s : FinancetimegarchCursor, i : Int, v : Double) -> FinancetimegarchCursor {
  let result = finance_time_garch_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_cursor_sum(s : FinancetimegarchCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_garch_cursor_mean(s : FinancetimegarchCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_garch_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_time_garch_cursor_scale(s : FinancetimegarchCursor, f : Double) -> FinancetimegarchCursor {
  let result = finance_time_garch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_cursor_add(a : FinancetimegarchCursor, b : FinancetimegarchCursor) -> FinancetimegarchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_cursor_copy(s : FinancetimegarchCursor) -> FinancetimegarchCursor {
  let result = finance_time_garch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_cursor_fill(s : FinancetimegarchCursor, v : Double) -> FinancetimegarchCursor {
  let result = finance_time_garch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_cursor_min(s : FinancetimegarchCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_cursor_max(s : FinancetimegarchCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_cursor_to_string(s : FinancetimegarchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_view_make(size : Int) -> FinancetimegarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_view_len(s : FinancetimegarchView) -> Int { s.size }

pub fn finance_time_garch_view_get(s : FinancetimegarchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_view_set(s : FinancetimegarchView, i : Int, v : Double) -> FinancetimegarchView {
  let result = finance_time_garch_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_view_sum(s : FinancetimegarchView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_garch_view_mean(s : FinancetimegarchView) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_garch_view_sum(s) / s.size.to_double() }
}

pub fn finance_time_garch_view_scale(s : FinancetimegarchView, f : Double) -> FinancetimegarchView {
  let result = finance_time_garch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_view_add(a : FinancetimegarchView, b : FinancetimegarchView) -> FinancetimegarchView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_view_copy(s : FinancetimegarchView) -> FinancetimegarchView {
  let result = finance_time_garch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_view_fill(s : FinancetimegarchView, v : Double) -> FinancetimegarchView {
  let result = finance_time_garch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_view_min(s : FinancetimegarchView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_view_max(s : FinancetimegarchView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_view_to_string(s : FinancetimegarchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_range_make(size : Int) -> FinancetimegarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_range_len(s : FinancetimegarchRange) -> Int { s.size }

pub fn finance_time_garch_range_get(s : FinancetimegarchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_range_set(s : FinancetimegarchRange, i : Int, v : Double) -> FinancetimegarchRange {
  let result = finance_time_garch_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_range_sum(s : FinancetimegarchRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_garch_range_mean(s : FinancetimegarchRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_garch_range_sum(s) / s.size.to_double() }
}

pub fn finance_time_garch_range_scale(s : FinancetimegarchRange, f : Double) -> FinancetimegarchRange {
  let result = finance_time_garch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_range_add(a : FinancetimegarchRange, b : FinancetimegarchRange) -> FinancetimegarchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_range_copy(s : FinancetimegarchRange) -> FinancetimegarchRange {
  let result = finance_time_garch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_range_fill(s : FinancetimegarchRange, v : Double) -> FinancetimegarchRange {
  let result = finance_time_garch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_range_min(s : FinancetimegarchRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_range_max(s : FinancetimegarchRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_range_to_string(s : FinancetimegarchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_slice_make(size : Int) -> FinancetimegarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_slice_len(s : FinancetimegarchSlice) -> Int { s.size }

pub fn finance_time_garch_slice_get(s : FinancetimegarchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_slice_set(s : FinancetimegarchSlice, i : Int, v : Double) -> FinancetimegarchSlice {
  let result = finance_time_garch_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_slice_sum(s : FinancetimegarchSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_garch_slice_mean(s : FinancetimegarchSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_garch_slice_sum(s) / s.size.to_double() }
}

pub fn finance_time_garch_slice_scale(s : FinancetimegarchSlice, f : Double) -> FinancetimegarchSlice {
  let result = finance_time_garch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_slice_add(a : FinancetimegarchSlice, b : FinancetimegarchSlice) -> FinancetimegarchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_slice_copy(s : FinancetimegarchSlice) -> FinancetimegarchSlice {
  let result = finance_time_garch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_slice_fill(s : FinancetimegarchSlice, v : Double) -> FinancetimegarchSlice {
  let result = finance_time_garch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_slice_min(s : FinancetimegarchSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_slice_max(s : FinancetimegarchSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_garch_slice_to_string(s : FinancetimegarchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn finance_time_garch_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_garch_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_garch_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_garch_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_garch_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_garch_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_garch_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_garch_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_garch_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_garch_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_garch_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_garch_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_garch_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_garch_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_garch_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_garch_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_garch_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_garch_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_garch_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_garch_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_garch_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_garch_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_garch_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_garch_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_garch_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

