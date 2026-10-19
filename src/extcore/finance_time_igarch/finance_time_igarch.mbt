///===
/// extcore/finance_time_igarch

pub(all) struct FinancetimeigarchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_igarch_make_point(x : Double, y : Double) -> FinancetimeigarchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_igarch_make_point3(x : Double, y : Double, z : Double) -> FinancetimeigarchPoint {
  { x, y, z, label: 0 }
}

pub fn finance_time_igarch_point_x(pt : FinancetimeigarchPoint) -> Double { pt.x }

pub fn finance_time_igarch_point_y(pt : FinancetimeigarchPoint) -> Double { pt.y }

pub fn finance_time_igarch_point_z(pt : FinancetimeigarchPoint) -> Double { pt.z }

pub fn finance_time_igarch_point_label(pt : FinancetimeigarchPoint) -> Int { pt.label }

pub fn finance_time_igarch_point_dist(a : FinancetimeigarchPoint, b : FinancetimeigarchPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  finance_time_igarch_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_time_igarch_point_add(a : FinancetimeigarchPoint, b : FinancetimeigarchPoint) -> FinancetimeigarchPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_time_igarch_point_sub(a : FinancetimeigarchPoint, b : FinancetimeigarchPoint) -> FinancetimeigarchPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_time_igarch_point_scale(pt : FinancetimeigarchPoint, s : Double) -> FinancetimeigarchPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_time_igarch_point_dot(a : FinancetimeigarchPoint, b : FinancetimeigarchPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_time_igarch_point_cross(a : FinancetimeigarchPoint, b : FinancetimeigarchPoint) -> FinancetimeigarchPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_time_igarch_point_norm(pt : FinancetimeigarchPoint) -> Double {
  finance_time_igarch_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_time_igarch_point_normalize(pt : FinancetimeigarchPoint) -> FinancetimeigarchPoint {
  let n = finance_time_igarch_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_time_igarch_point_scale(pt, 1.0 / n) }
}

pub fn finance_time_igarch_point_negate(pt : FinancetimeigarchPoint) -> FinancetimeigarchPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_time_igarch_point_mid(a : FinancetimeigarchPoint, b : FinancetimeigarchPoint) -> FinancetimeigarchPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_time_igarch_point_lerp(a : FinancetimeigarchPoint, b : FinancetimeigarchPoint, t : Double) -> FinancetimeigarchPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_time_igarch_point_to_string(pt : FinancetimeigarchPoint) -> String {
  "(" + finance_time_igarch_dbl(pt.x) + ", " + finance_time_igarch_dbl(pt.y) + ", " + finance_time_igarch_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancetimeigarchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_igarch_make_series(vals : Array[Double], name : String) -> FinancetimeigarchSeries {
  { vals, name, meta: 0 }
}

pub fn finance_time_igarch_series_len(s : FinancetimeigarchSeries) -> Int { s.vals.length() }

pub fn finance_time_igarch_series_sum(s : FinancetimeigarchSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_time_igarch_series_mean(s : FinancetimeigarchSeries) -> Double {
  let n = finance_time_igarch_series_len(s)
  if n == 0 { 0.0 } else { finance_time_igarch_series_sum(s) / n.to_double() }
}

pub fn finance_time_igarch_series_min(s : FinancetimeigarchSeries) -> Double {
  let n = finance_time_igarch_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_time_igarch_series_max(s : FinancetimeigarchSeries) -> Double {
  let n = finance_time_igarch_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_time_igarch_series_range(s : FinancetimeigarchSeries) -> Double {
  finance_time_igarch_series_max(s) - finance_time_igarch_series_min(s)
}

pub fn finance_time_igarch_series_var(s : FinancetimeigarchSeries) -> Double {
  let n = finance_time_igarch_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_time_igarch_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_time_igarch_series_std(s : FinancetimeigarchSeries) -> Double { finance_time_igarch_sqrt(finance_time_igarch_series_var(s)) }

pub fn finance_time_igarch_series_median(s : FinancetimeigarchSeries) -> Double {
  let n = finance_time_igarch_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_time_igarch_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_time_igarch_series_scale(s : FinancetimeigarchSeries, f : Double) -> FinancetimeigarchSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = finance_time_igarch_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_time_igarch_series_add(a : FinancetimeigarchSeries, b : FinancetimeigarchSeries) -> FinancetimeigarchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_time_igarch_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_time_igarch_series_sub(a : FinancetimeigarchSeries, b : FinancetimeigarchSeries) -> FinancetimeigarchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_time_igarch_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_time_igarch_series_normalize(s : FinancetimeigarchSeries) -> FinancetimeigarchSeries {
  let mn = finance_time_igarch_series_min(s)
  let mx = finance_time_igarch_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = finance_time_igarch_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_time_igarch_series_cumsum(s : FinancetimeigarchSeries) -> FinancetimeigarchSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = finance_time_igarch_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_time_igarch_series_to_string(s : FinancetimeigarchSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_time_igarch_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimeigarchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_igarch_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimeigarchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_igarch_matrix_identity(n : Int) -> FinancetimeigarchMatrix {
  let m = finance_time_igarch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_time_igarch_matrix_get(m : FinancetimeigarchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_time_igarch_matrix_transpose(m : FinancetimeigarchMatrix) -> FinancetimeigarchMatrix {
  let result = finance_time_igarch_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_time_igarch_matrix_add(a : FinancetimeigarchMatrix, b : FinancetimeigarchMatrix) -> FinancetimeigarchMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_time_igarch_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_time_igarch_matrix_scale(m : FinancetimeigarchMatrix, s : Double) -> FinancetimeigarchMatrix {
  let result = finance_time_igarch_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_time_igarch_matrix_multiply(a : FinancetimeigarchMatrix, b : FinancetimeigarchMatrix) -> FinancetimeigarchMatrix {
  if a.cols != b.rows { return finance_time_igarch_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_time_igarch_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_time_igarch_matrix_trace(m : FinancetimeigarchMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_time_igarch_matrix_det(m : FinancetimeigarchMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_time_igarch_matrix_norm(m : FinancetimeigarchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  finance_time_igarch_sqrt(sum)
}

pub fn finance_time_igarch_matrix_to_string(m : FinancetimeigarchMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + finance_time_igarch_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct FinancetimeigarchVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_igarch_make_vector(comps : Array[Double]) -> FinancetimeigarchVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_igarch_vector_zero(dim : Int) -> FinancetimeigarchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_time_igarch_vector_add(a : FinancetimeigarchVector, b : FinancetimeigarchVector) -> FinancetimeigarchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_time_igarch_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_igarch_vector_sub(a : FinancetimeigarchVector, b : FinancetimeigarchVector) -> FinancetimeigarchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_time_igarch_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_igarch_vector_scale(v : FinancetimeigarchVector, s : Double) -> FinancetimeigarchVector {
  let mut result = []
  for i in 0..<v.dim { result = finance_time_igarch_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_time_igarch_vector_dot(a : FinancetimeigarchVector, b : FinancetimeigarchVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_time_igarch_vector_norm(v : FinancetimeigarchVector) -> Double { finance_time_igarch_sqrt(finance_time_igarch_vector_dot(v, v)) }

pub fn finance_time_igarch_vector_normalize(v : FinancetimeigarchVector) -> FinancetimeigarchVector {
  let n = finance_time_igarch_vector_norm(v)
  if n < 0.0000001 { v } else { finance_time_igarch_vector_scale(v, 1.0 / n) }
}

pub fn finance_time_igarch_vector_dist(a : FinancetimeigarchVector, b : FinancetimeigarchVector) -> Double {
  finance_time_igarch_vector_norm(finance_time_igarch_vector_sub(a, b))
}

pub fn finance_time_igarch_vector_to_string(v : FinancetimeigarchVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_time_igarch_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_time_igarch_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn finance_time_igarch_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = finance_time_igarch_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_time_igarch_std(data : Array[Double]) -> Double { finance_time_igarch_sqrt(finance_time_igarch_var(data)) }

pub fn finance_time_igarch_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = finance_time_igarch_mean(a); let mb = finance_time_igarch_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn finance_time_igarch_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = finance_time_igarch_std(a); let sb = finance_time_igarch_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { finance_time_igarch_cov(a, b) / (sa * sb) }
}

pub fn finance_time_igarch_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = finance_time_igarch_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_time_igarch_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn finance_time_igarch_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_time_igarch_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  finance_time_igarch_sqrt(finance_time_igarch_mse(pred, labels))
}

pub fn finance_time_igarch_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + finance_time_igarch_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn finance_time_igarch_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = finance_time_igarch_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn finance_time_igarch_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn finance_time_igarch_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn finance_time_igarch_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = finance_time_igarch_precision(pred, labels, pos); let r = finance_time_igarch_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn finance_time_igarch_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn finance_time_igarch_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = finance_time_igarch_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn finance_time_igarch_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn finance_time_igarch_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn finance_time_igarch_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = finance_time_igarch_gcd(a, b)
    (a / g) * b
  }
}

pub fn finance_time_igarch_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn finance_time_igarch_fibonacci(n : Int) -> Int {
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

pub fn finance_time_igarch_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = finance_time_igarch_min(data); let mx = finance_time_igarch_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn finance_time_igarch_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = finance_time_igarch_mean(data); let sd = finance_time_igarch_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn finance_time_igarch_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn finance_time_igarch_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn finance_time_igarch_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn finance_time_igarch_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn finance_time_igarch_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn finance_time_igarch_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn finance_time_igarch_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn finance_time_igarch_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn finance_time_igarch_dbl(x : Double) -> String {
  let i = if x >= 0.0 { finance_time_igarch_int(x) } else { -finance_time_igarch_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { finance_time_igarch_int(f * 1000000.0) } else { finance_time_igarch_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn finance_time_igarch_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn finance_time_igarch_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct FinancetimeigarchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_frame_make(size : Int) -> FinancetimeigarchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_frame_len(s : FinancetimeigarchFrame) -> Int { s.size }

pub fn finance_time_igarch_frame_get(s : FinancetimeigarchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_frame_set(s : FinancetimeigarchFrame, i : Int, v : Double) -> FinancetimeigarchFrame {
  let result = finance_time_igarch_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_frame_sum(s : FinancetimeigarchFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_igarch_frame_mean(s : FinancetimeigarchFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_igarch_frame_sum(s) / s.size.to_double() }
}

pub fn finance_time_igarch_frame_scale(s : FinancetimeigarchFrame, f : Double) -> FinancetimeigarchFrame {
  let result = finance_time_igarch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_igarch_frame_add(a : FinancetimeigarchFrame, b : FinancetimeigarchFrame) -> FinancetimeigarchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_igarch_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_igarch_frame_copy(s : FinancetimeigarchFrame) -> FinancetimeigarchFrame {
  let result = finance_time_igarch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_igarch_frame_fill(s : FinancetimeigarchFrame, v : Double) -> FinancetimeigarchFrame {
  let result = finance_time_igarch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_frame_min(s : FinancetimeigarchFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_frame_max(s : FinancetimeigarchFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_frame_to_string(s : FinancetimeigarchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_table_make(size : Int) -> FinancetimeigarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_table_len(s : FinancetimeigarchTable) -> Int { s.size }

pub fn finance_time_igarch_table_get(s : FinancetimeigarchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_table_set(s : FinancetimeigarchTable, i : Int, v : Double) -> FinancetimeigarchTable {
  let result = finance_time_igarch_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_table_sum(s : FinancetimeigarchTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_igarch_table_mean(s : FinancetimeigarchTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_igarch_table_sum(s) / s.size.to_double() }
}

pub fn finance_time_igarch_table_scale(s : FinancetimeigarchTable, f : Double) -> FinancetimeigarchTable {
  let result = finance_time_igarch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_igarch_table_add(a : FinancetimeigarchTable, b : FinancetimeigarchTable) -> FinancetimeigarchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_igarch_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_igarch_table_copy(s : FinancetimeigarchTable) -> FinancetimeigarchTable {
  let result = finance_time_igarch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_igarch_table_fill(s : FinancetimeigarchTable, v : Double) -> FinancetimeigarchTable {
  let result = finance_time_igarch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_table_min(s : FinancetimeigarchTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_table_max(s : FinancetimeigarchTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_table_to_string(s : FinancetimeigarchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_graphn_make(size : Int) -> FinancetimeigarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_graphn_len(s : FinancetimeigarchGraphN) -> Int { s.size }

pub fn finance_time_igarch_graphn_get(s : FinancetimeigarchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_graphn_set(s : FinancetimeigarchGraphN, i : Int, v : Double) -> FinancetimeigarchGraphN {
  let result = finance_time_igarch_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_graphn_sum(s : FinancetimeigarchGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_igarch_graphn_mean(s : FinancetimeigarchGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_igarch_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_time_igarch_graphn_scale(s : FinancetimeigarchGraphN, f : Double) -> FinancetimeigarchGraphN {
  let result = finance_time_igarch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_igarch_graphn_add(a : FinancetimeigarchGraphN, b : FinancetimeigarchGraphN) -> FinancetimeigarchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_igarch_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_igarch_graphn_copy(s : FinancetimeigarchGraphN) -> FinancetimeigarchGraphN {
  let result = finance_time_igarch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_igarch_graphn_fill(s : FinancetimeigarchGraphN, v : Double) -> FinancetimeigarchGraphN {
  let result = finance_time_igarch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_graphn_min(s : FinancetimeigarchGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_graphn_max(s : FinancetimeigarchGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_graphn_to_string(s : FinancetimeigarchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_node_make(size : Int) -> FinancetimeigarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_node_len(s : FinancetimeigarchNode) -> Int { s.size }

pub fn finance_time_igarch_node_get(s : FinancetimeigarchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_node_set(s : FinancetimeigarchNode, i : Int, v : Double) -> FinancetimeigarchNode {
  let result = finance_time_igarch_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_node_sum(s : FinancetimeigarchNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_igarch_node_mean(s : FinancetimeigarchNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_igarch_node_sum(s) / s.size.to_double() }
}

pub fn finance_time_igarch_node_scale(s : FinancetimeigarchNode, f : Double) -> FinancetimeigarchNode {
  let result = finance_time_igarch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_igarch_node_add(a : FinancetimeigarchNode, b : FinancetimeigarchNode) -> FinancetimeigarchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_igarch_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_igarch_node_copy(s : FinancetimeigarchNode) -> FinancetimeigarchNode {
  let result = finance_time_igarch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_igarch_node_fill(s : FinancetimeigarchNode, v : Double) -> FinancetimeigarchNode {
  let result = finance_time_igarch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_node_min(s : FinancetimeigarchNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_node_max(s : FinancetimeigarchNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_node_to_string(s : FinancetimeigarchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_edge_make(size : Int) -> FinancetimeigarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_edge_len(s : FinancetimeigarchEdge) -> Int { s.size }

pub fn finance_time_igarch_edge_get(s : FinancetimeigarchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_edge_set(s : FinancetimeigarchEdge, i : Int, v : Double) -> FinancetimeigarchEdge {
  let result = finance_time_igarch_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_edge_sum(s : FinancetimeigarchEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_igarch_edge_mean(s : FinancetimeigarchEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_igarch_edge_sum(s) / s.size.to_double() }
}

pub fn finance_time_igarch_edge_scale(s : FinancetimeigarchEdge, f : Double) -> FinancetimeigarchEdge {
  let result = finance_time_igarch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_igarch_edge_add(a : FinancetimeigarchEdge, b : FinancetimeigarchEdge) -> FinancetimeigarchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_igarch_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_igarch_edge_copy(s : FinancetimeigarchEdge) -> FinancetimeigarchEdge {
  let result = finance_time_igarch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_igarch_edge_fill(s : FinancetimeigarchEdge, v : Double) -> FinancetimeigarchEdge {
  let result = finance_time_igarch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_edge_min(s : FinancetimeigarchEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_edge_max(s : FinancetimeigarchEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_edge_to_string(s : FinancetimeigarchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_path_make(size : Int) -> FinancetimeigarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_path_len(s : FinancetimeigarchPath) -> Int { s.size }

pub fn finance_time_igarch_path_get(s : FinancetimeigarchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_path_set(s : FinancetimeigarchPath, i : Int, v : Double) -> FinancetimeigarchPath {
  let result = finance_time_igarch_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_path_sum(s : FinancetimeigarchPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_igarch_path_mean(s : FinancetimeigarchPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_igarch_path_sum(s) / s.size.to_double() }
}

pub fn finance_time_igarch_path_scale(s : FinancetimeigarchPath, f : Double) -> FinancetimeigarchPath {
  let result = finance_time_igarch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_igarch_path_add(a : FinancetimeigarchPath, b : FinancetimeigarchPath) -> FinancetimeigarchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_igarch_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_igarch_path_copy(s : FinancetimeigarchPath) -> FinancetimeigarchPath {
  let result = finance_time_igarch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_igarch_path_fill(s : FinancetimeigarchPath, v : Double) -> FinancetimeigarchPath {
  let result = finance_time_igarch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_path_min(s : FinancetimeigarchPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_path_max(s : FinancetimeigarchPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_path_to_string(s : FinancetimeigarchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_cluster_make(size : Int) -> FinancetimeigarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_cluster_len(s : FinancetimeigarchCluster) -> Int { s.size }

pub fn finance_time_igarch_cluster_get(s : FinancetimeigarchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_cluster_set(s : FinancetimeigarchCluster, i : Int, v : Double) -> FinancetimeigarchCluster {
  let result = finance_time_igarch_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_cluster_sum(s : FinancetimeigarchCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_igarch_cluster_mean(s : FinancetimeigarchCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_igarch_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_time_igarch_cluster_scale(s : FinancetimeigarchCluster, f : Double) -> FinancetimeigarchCluster {
  let result = finance_time_igarch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_igarch_cluster_add(a : FinancetimeigarchCluster, b : FinancetimeigarchCluster) -> FinancetimeigarchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_igarch_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_igarch_cluster_copy(s : FinancetimeigarchCluster) -> FinancetimeigarchCluster {
  let result = finance_time_igarch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_igarch_cluster_fill(s : FinancetimeigarchCluster, v : Double) -> FinancetimeigarchCluster {
  let result = finance_time_igarch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_cluster_min(s : FinancetimeigarchCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_cluster_max(s : FinancetimeigarchCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_cluster_to_string(s : FinancetimeigarchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_model_make(size : Int) -> FinancetimeigarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_model_len(s : FinancetimeigarchModel) -> Int { s.size }

pub fn finance_time_igarch_model_get(s : FinancetimeigarchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_model_set(s : FinancetimeigarchModel, i : Int, v : Double) -> FinancetimeigarchModel {
  let result = finance_time_igarch_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_model_sum(s : FinancetimeigarchModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_igarch_model_mean(s : FinancetimeigarchModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_igarch_model_sum(s) / s.size.to_double() }
}

pub fn finance_time_igarch_model_scale(s : FinancetimeigarchModel, f : Double) -> FinancetimeigarchModel {
  let result = finance_time_igarch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_igarch_model_add(a : FinancetimeigarchModel, b : FinancetimeigarchModel) -> FinancetimeigarchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_igarch_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_igarch_model_copy(s : FinancetimeigarchModel) -> FinancetimeigarchModel {
  let result = finance_time_igarch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_igarch_model_fill(s : FinancetimeigarchModel, v : Double) -> FinancetimeigarchModel {
  let result = finance_time_igarch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_model_min(s : FinancetimeigarchModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_model_max(s : FinancetimeigarchModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_model_to_string(s : FinancetimeigarchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_layer_make(size : Int) -> FinancetimeigarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_layer_len(s : FinancetimeigarchLayer) -> Int { s.size }

pub fn finance_time_igarch_layer_get(s : FinancetimeigarchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_layer_set(s : FinancetimeigarchLayer, i : Int, v : Double) -> FinancetimeigarchLayer {
  let result = finance_time_igarch_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_layer_sum(s : FinancetimeigarchLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_igarch_layer_mean(s : FinancetimeigarchLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_igarch_layer_sum(s) / s.size.to_double() }
}

pub fn finance_time_igarch_layer_scale(s : FinancetimeigarchLayer, f : Double) -> FinancetimeigarchLayer {
  let result = finance_time_igarch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_igarch_layer_add(a : FinancetimeigarchLayer, b : FinancetimeigarchLayer) -> FinancetimeigarchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_igarch_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_igarch_layer_copy(s : FinancetimeigarchLayer) -> FinancetimeigarchLayer {
  let result = finance_time_igarch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_igarch_layer_fill(s : FinancetimeigarchLayer, v : Double) -> FinancetimeigarchLayer {
  let result = finance_time_igarch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_layer_min(s : FinancetimeigarchLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_layer_max(s : FinancetimeigarchLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_layer_to_string(s : FinancetimeigarchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_buffer_make(size : Int) -> FinancetimeigarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_buffer_len(s : FinancetimeigarchBuffer) -> Int { s.size }

pub fn finance_time_igarch_buffer_get(s : FinancetimeigarchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_buffer_set(s : FinancetimeigarchBuffer, i : Int, v : Double) -> FinancetimeigarchBuffer {
  let result = finance_time_igarch_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_buffer_sum(s : FinancetimeigarchBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_igarch_buffer_mean(s : FinancetimeigarchBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_igarch_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_time_igarch_buffer_scale(s : FinancetimeigarchBuffer, f : Double) -> FinancetimeigarchBuffer {
  let result = finance_time_igarch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_igarch_buffer_add(a : FinancetimeigarchBuffer, b : FinancetimeigarchBuffer) -> FinancetimeigarchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_igarch_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_igarch_buffer_copy(s : FinancetimeigarchBuffer) -> FinancetimeigarchBuffer {
  let result = finance_time_igarch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_igarch_buffer_fill(s : FinancetimeigarchBuffer, v : Double) -> FinancetimeigarchBuffer {
  let result = finance_time_igarch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_buffer_min(s : FinancetimeigarchBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_buffer_max(s : FinancetimeigarchBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_buffer_to_string(s : FinancetimeigarchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_cursor_make(size : Int) -> FinancetimeigarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_cursor_len(s : FinancetimeigarchCursor) -> Int { s.size }

pub fn finance_time_igarch_cursor_get(s : FinancetimeigarchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_cursor_set(s : FinancetimeigarchCursor, i : Int, v : Double) -> FinancetimeigarchCursor {
  let result = finance_time_igarch_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_cursor_sum(s : FinancetimeigarchCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_igarch_cursor_mean(s : FinancetimeigarchCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_igarch_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_time_igarch_cursor_scale(s : FinancetimeigarchCursor, f : Double) -> FinancetimeigarchCursor {
  let result = finance_time_igarch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_igarch_cursor_add(a : FinancetimeigarchCursor, b : FinancetimeigarchCursor) -> FinancetimeigarchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_igarch_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_igarch_cursor_copy(s : FinancetimeigarchCursor) -> FinancetimeigarchCursor {
  let result = finance_time_igarch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_igarch_cursor_fill(s : FinancetimeigarchCursor, v : Double) -> FinancetimeigarchCursor {
  let result = finance_time_igarch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_cursor_min(s : FinancetimeigarchCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_cursor_max(s : FinancetimeigarchCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_cursor_to_string(s : FinancetimeigarchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_view_make(size : Int) -> FinancetimeigarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_view_len(s : FinancetimeigarchView) -> Int { s.size }

pub fn finance_time_igarch_view_get(s : FinancetimeigarchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_view_set(s : FinancetimeigarchView, i : Int, v : Double) -> FinancetimeigarchView {
  let result = finance_time_igarch_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_view_sum(s : FinancetimeigarchView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_igarch_view_mean(s : FinancetimeigarchView) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_igarch_view_sum(s) / s.size.to_double() }
}

pub fn finance_time_igarch_view_scale(s : FinancetimeigarchView, f : Double) -> FinancetimeigarchView {
  let result = finance_time_igarch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_igarch_view_add(a : FinancetimeigarchView, b : FinancetimeigarchView) -> FinancetimeigarchView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_igarch_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_igarch_view_copy(s : FinancetimeigarchView) -> FinancetimeigarchView {
  let result = finance_time_igarch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_igarch_view_fill(s : FinancetimeigarchView, v : Double) -> FinancetimeigarchView {
  let result = finance_time_igarch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_view_min(s : FinancetimeigarchView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_view_max(s : FinancetimeigarchView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_view_to_string(s : FinancetimeigarchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_range_make(size : Int) -> FinancetimeigarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_range_len(s : FinancetimeigarchRange) -> Int { s.size }

pub fn finance_time_igarch_range_get(s : FinancetimeigarchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_range_set(s : FinancetimeigarchRange, i : Int, v : Double) -> FinancetimeigarchRange {
  let result = finance_time_igarch_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_range_sum(s : FinancetimeigarchRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_igarch_range_mean(s : FinancetimeigarchRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_igarch_range_sum(s) / s.size.to_double() }
}

pub fn finance_time_igarch_range_scale(s : FinancetimeigarchRange, f : Double) -> FinancetimeigarchRange {
  let result = finance_time_igarch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_igarch_range_add(a : FinancetimeigarchRange, b : FinancetimeigarchRange) -> FinancetimeigarchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_igarch_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_igarch_range_copy(s : FinancetimeigarchRange) -> FinancetimeigarchRange {
  let result = finance_time_igarch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_igarch_range_fill(s : FinancetimeigarchRange, v : Double) -> FinancetimeigarchRange {
  let result = finance_time_igarch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_range_min(s : FinancetimeigarchRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_range_max(s : FinancetimeigarchRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_range_to_string(s : FinancetimeigarchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_slice_make(size : Int) -> FinancetimeigarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_slice_len(s : FinancetimeigarchSlice) -> Int { s.size }

pub fn finance_time_igarch_slice_get(s : FinancetimeigarchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_slice_set(s : FinancetimeigarchSlice, i : Int, v : Double) -> FinancetimeigarchSlice {
  let result = finance_time_igarch_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_slice_sum(s : FinancetimeigarchSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_igarch_slice_mean(s : FinancetimeigarchSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_igarch_slice_sum(s) / s.size.to_double() }
}

pub fn finance_time_igarch_slice_scale(s : FinancetimeigarchSlice, f : Double) -> FinancetimeigarchSlice {
  let result = finance_time_igarch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_igarch_slice_add(a : FinancetimeigarchSlice, b : FinancetimeigarchSlice) -> FinancetimeigarchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_igarch_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_igarch_slice_copy(s : FinancetimeigarchSlice) -> FinancetimeigarchSlice {
  let result = finance_time_igarch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_igarch_slice_fill(s : FinancetimeigarchSlice, v : Double) -> FinancetimeigarchSlice {
  let result = finance_time_igarch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_igarch_slice_min(s : FinancetimeigarchSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_slice_max(s : FinancetimeigarchSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_igarch_slice_to_string(s : FinancetimeigarchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn finance_time_igarch_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_igarch_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_igarch_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_igarch_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_igarch_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_igarch_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_igarch_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_igarch_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_igarch_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_igarch_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_igarch_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_igarch_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_igarch_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_igarch_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_igarch_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_igarch_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_igarch_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_igarch_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_igarch_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_igarch_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_igarch_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_igarch_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_igarch_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_igarch_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_igarch_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

