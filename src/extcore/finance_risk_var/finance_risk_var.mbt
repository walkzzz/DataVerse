///===
/// extcore/finance_risk_var

pub(all) struct FinanceriskvarPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_var_make_point(x : Double, y : Double) -> FinanceriskvarPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_var_make_point3(x : Double, y : Double, z : Double) -> FinanceriskvarPoint {
  { x, y, z, label: 0 }
}

pub fn finance_risk_var_point_x(pt : FinanceriskvarPoint) -> Double { pt.x }

pub fn finance_risk_var_point_y(pt : FinanceriskvarPoint) -> Double { pt.y }

pub fn finance_risk_var_point_z(pt : FinanceriskvarPoint) -> Double { pt.z }

pub fn finance_risk_var_point_label(pt : FinanceriskvarPoint) -> Int { pt.label }

pub fn finance_risk_var_point_dist(a : FinanceriskvarPoint, b : FinanceriskvarPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  finance_risk_var_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_risk_var_point_add(a : FinanceriskvarPoint, b : FinanceriskvarPoint) -> FinanceriskvarPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_risk_var_point_sub(a : FinanceriskvarPoint, b : FinanceriskvarPoint) -> FinanceriskvarPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_risk_var_point_scale(pt : FinanceriskvarPoint, s : Double) -> FinanceriskvarPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_risk_var_point_dot(a : FinanceriskvarPoint, b : FinanceriskvarPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_risk_var_point_cross(a : FinanceriskvarPoint, b : FinanceriskvarPoint) -> FinanceriskvarPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_risk_var_point_norm(pt : FinanceriskvarPoint) -> Double {
  finance_risk_var_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_risk_var_point_normalize(pt : FinanceriskvarPoint) -> FinanceriskvarPoint {
  let n = finance_risk_var_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_risk_var_point_scale(pt, 1.0 / n) }
}

pub fn finance_risk_var_point_negate(pt : FinanceriskvarPoint) -> FinanceriskvarPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_risk_var_point_mid(a : FinanceriskvarPoint, b : FinanceriskvarPoint) -> FinanceriskvarPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_risk_var_point_lerp(a : FinanceriskvarPoint, b : FinanceriskvarPoint, t : Double) -> FinanceriskvarPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_risk_var_point_to_string(pt : FinanceriskvarPoint) -> String {
  "(" + finance_risk_var_dbl(pt.x) + ", " + finance_risk_var_dbl(pt.y) + ", " + finance_risk_var_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinanceriskvarSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_var_make_series(vals : Array[Double], name : String) -> FinanceriskvarSeries {
  { vals, name, meta: 0 }
}

pub fn finance_risk_var_series_len(s : FinanceriskvarSeries) -> Int { s.vals.length() }

pub fn finance_risk_var_series_sum(s : FinanceriskvarSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_risk_var_series_mean(s : FinanceriskvarSeries) -> Double {
  let n = finance_risk_var_series_len(s)
  if n == 0 { 0.0 } else { finance_risk_var_series_sum(s) / n.to_double() }
}

pub fn finance_risk_var_series_min(s : FinanceriskvarSeries) -> Double {
  let n = finance_risk_var_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_risk_var_series_max(s : FinanceriskvarSeries) -> Double {
  let n = finance_risk_var_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_risk_var_series_range(s : FinanceriskvarSeries) -> Double {
  finance_risk_var_series_max(s) - finance_risk_var_series_min(s)
}

pub fn finance_risk_var_series_var(s : FinanceriskvarSeries) -> Double {
  let n = finance_risk_var_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_risk_var_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_risk_var_series_std(s : FinanceriskvarSeries) -> Double { finance_risk_var_sqrt(finance_risk_var_series_var(s)) }

pub fn finance_risk_var_series_median(s : FinanceriskvarSeries) -> Double {
  let n = finance_risk_var_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_risk_var_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_risk_var_series_scale(s : FinanceriskvarSeries, f : Double) -> FinanceriskvarSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = finance_risk_var_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_risk_var_series_add(a : FinanceriskvarSeries, b : FinanceriskvarSeries) -> FinanceriskvarSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_risk_var_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_risk_var_series_sub(a : FinanceriskvarSeries, b : FinanceriskvarSeries) -> FinanceriskvarSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_risk_var_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_risk_var_series_normalize(s : FinanceriskvarSeries) -> FinanceriskvarSeries {
  let mn = finance_risk_var_series_min(s)
  let mx = finance_risk_var_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = finance_risk_var_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_risk_var_series_cumsum(s : FinanceriskvarSeries) -> FinanceriskvarSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = finance_risk_var_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_risk_var_series_to_string(s : FinanceriskvarSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_risk_var_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskvarMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_var_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskvarMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_risk_var_matrix_identity(n : Int) -> FinanceriskvarMatrix {
  let m = finance_risk_var_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_risk_var_matrix_get(m : FinanceriskvarMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_risk_var_matrix_transpose(m : FinanceriskvarMatrix) -> FinanceriskvarMatrix {
  let result = finance_risk_var_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_risk_var_matrix_add(a : FinanceriskvarMatrix, b : FinanceriskvarMatrix) -> FinanceriskvarMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_risk_var_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_risk_var_matrix_scale(m : FinanceriskvarMatrix, s : Double) -> FinanceriskvarMatrix {
  let result = finance_risk_var_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_risk_var_matrix_multiply(a : FinanceriskvarMatrix, b : FinanceriskvarMatrix) -> FinanceriskvarMatrix {
  if a.cols != b.rows { return finance_risk_var_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_risk_var_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_risk_var_matrix_trace(m : FinanceriskvarMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_risk_var_matrix_det(m : FinanceriskvarMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_risk_var_matrix_norm(m : FinanceriskvarMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  finance_risk_var_sqrt(sum)
}

pub fn finance_risk_var_matrix_to_string(m : FinanceriskvarMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + finance_risk_var_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct FinanceriskvarVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_var_make_vector(comps : Array[Double]) -> FinanceriskvarVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_var_vector_zero(dim : Int) -> FinanceriskvarVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_risk_var_vector_add(a : FinanceriskvarVector, b : FinanceriskvarVector) -> FinanceriskvarVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_risk_var_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_risk_var_vector_sub(a : FinanceriskvarVector, b : FinanceriskvarVector) -> FinanceriskvarVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_risk_var_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_risk_var_vector_scale(v : FinanceriskvarVector, s : Double) -> FinanceriskvarVector {
  let mut result = []
  for i in 0..<v.dim { result = finance_risk_var_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_risk_var_vector_dot(a : FinanceriskvarVector, b : FinanceriskvarVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_risk_var_vector_norm(v : FinanceriskvarVector) -> Double { finance_risk_var_sqrt(finance_risk_var_vector_dot(v, v)) }

pub fn finance_risk_var_vector_normalize(v : FinanceriskvarVector) -> FinanceriskvarVector {
  let n = finance_risk_var_vector_norm(v)
  if n < 0.0000001 { v } else { finance_risk_var_vector_scale(v, 1.0 / n) }
}

pub fn finance_risk_var_vector_dist(a : FinanceriskvarVector, b : FinanceriskvarVector) -> Double {
  finance_risk_var_vector_norm(finance_risk_var_vector_sub(a, b))
}

pub fn finance_risk_var_vector_to_string(v : FinanceriskvarVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_risk_var_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_risk_var_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn finance_risk_var_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = finance_risk_var_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_risk_var_std(data : Array[Double]) -> Double { finance_risk_var_sqrt(finance_risk_var_var(data)) }

pub fn finance_risk_var_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = finance_risk_var_mean(a); let mb = finance_risk_var_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn finance_risk_var_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = finance_risk_var_std(a); let sb = finance_risk_var_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { finance_risk_var_cov(a, b) / (sa * sb) }
}

pub fn finance_risk_var_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = finance_risk_var_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_risk_var_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn finance_risk_var_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_risk_var_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  finance_risk_var_sqrt(finance_risk_var_mse(pred, labels))
}

pub fn finance_risk_var_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + finance_risk_var_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn finance_risk_var_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = finance_risk_var_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn finance_risk_var_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn finance_risk_var_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn finance_risk_var_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = finance_risk_var_precision(pred, labels, pos); let r = finance_risk_var_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn finance_risk_var_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn finance_risk_var_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = finance_risk_var_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn finance_risk_var_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn finance_risk_var_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn finance_risk_var_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = finance_risk_var_gcd(a, b)
    (a / g) * b
  }
}

pub fn finance_risk_var_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn finance_risk_var_fibonacci(n : Int) -> Int {
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

pub fn finance_risk_var_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = finance_risk_var_min(data); let mx = finance_risk_var_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn finance_risk_var_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = finance_risk_var_mean(data); let sd = finance_risk_var_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn finance_risk_var_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn finance_risk_var_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn finance_risk_var_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn finance_risk_var_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn finance_risk_var_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn finance_risk_var_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn finance_risk_var_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn finance_risk_var_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn finance_risk_var_dbl(x : Double) -> String {
  let i = if x >= 0.0 { finance_risk_var_int(x) } else { -finance_risk_var_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { finance_risk_var_int(f * 1000000.0) } else { finance_risk_var_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn finance_risk_var_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn finance_risk_var_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct FinanceriskvarFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_frame_make(size : Int) -> FinanceriskvarFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_frame_len(s : FinanceriskvarFrame) -> Int { s.size }

pub fn finance_risk_var_frame_get(s : FinanceriskvarFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_frame_set(s : FinanceriskvarFrame, i : Int, v : Double) -> FinanceriskvarFrame {
  let result = finance_risk_var_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_frame_sum(s : FinanceriskvarFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_var_frame_mean(s : FinanceriskvarFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_var_frame_sum(s) / s.size.to_double() }
}

pub fn finance_risk_var_frame_scale(s : FinanceriskvarFrame, f : Double) -> FinanceriskvarFrame {
  let result = finance_risk_var_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_var_frame_add(a : FinanceriskvarFrame, b : FinanceriskvarFrame) -> FinanceriskvarFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_var_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_var_frame_copy(s : FinanceriskvarFrame) -> FinanceriskvarFrame {
  let result = finance_risk_var_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_var_frame_fill(s : FinanceriskvarFrame, v : Double) -> FinanceriskvarFrame {
  let result = finance_risk_var_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_frame_min(s : FinanceriskvarFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_frame_max(s : FinanceriskvarFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_frame_to_string(s : FinanceriskvarFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_table_make(size : Int) -> FinanceriskvarTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_table_len(s : FinanceriskvarTable) -> Int { s.size }

pub fn finance_risk_var_table_get(s : FinanceriskvarTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_table_set(s : FinanceriskvarTable, i : Int, v : Double) -> FinanceriskvarTable {
  let result = finance_risk_var_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_table_sum(s : FinanceriskvarTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_var_table_mean(s : FinanceriskvarTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_var_table_sum(s) / s.size.to_double() }
}

pub fn finance_risk_var_table_scale(s : FinanceriskvarTable, f : Double) -> FinanceriskvarTable {
  let result = finance_risk_var_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_var_table_add(a : FinanceriskvarTable, b : FinanceriskvarTable) -> FinanceriskvarTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_var_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_var_table_copy(s : FinanceriskvarTable) -> FinanceriskvarTable {
  let result = finance_risk_var_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_var_table_fill(s : FinanceriskvarTable, v : Double) -> FinanceriskvarTable {
  let result = finance_risk_var_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_table_min(s : FinanceriskvarTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_table_max(s : FinanceriskvarTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_table_to_string(s : FinanceriskvarTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_graphn_make(size : Int) -> FinanceriskvarGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_graphn_len(s : FinanceriskvarGraphN) -> Int { s.size }

pub fn finance_risk_var_graphn_get(s : FinanceriskvarGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_graphn_set(s : FinanceriskvarGraphN, i : Int, v : Double) -> FinanceriskvarGraphN {
  let result = finance_risk_var_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_graphn_sum(s : FinanceriskvarGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_var_graphn_mean(s : FinanceriskvarGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_var_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_risk_var_graphn_scale(s : FinanceriskvarGraphN, f : Double) -> FinanceriskvarGraphN {
  let result = finance_risk_var_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_var_graphn_add(a : FinanceriskvarGraphN, b : FinanceriskvarGraphN) -> FinanceriskvarGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_var_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_var_graphn_copy(s : FinanceriskvarGraphN) -> FinanceriskvarGraphN {
  let result = finance_risk_var_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_var_graphn_fill(s : FinanceriskvarGraphN, v : Double) -> FinanceriskvarGraphN {
  let result = finance_risk_var_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_graphn_min(s : FinanceriskvarGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_graphn_max(s : FinanceriskvarGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_graphn_to_string(s : FinanceriskvarGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_node_make(size : Int) -> FinanceriskvarNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_node_len(s : FinanceriskvarNode) -> Int { s.size }

pub fn finance_risk_var_node_get(s : FinanceriskvarNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_node_set(s : FinanceriskvarNode, i : Int, v : Double) -> FinanceriskvarNode {
  let result = finance_risk_var_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_node_sum(s : FinanceriskvarNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_var_node_mean(s : FinanceriskvarNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_var_node_sum(s) / s.size.to_double() }
}

pub fn finance_risk_var_node_scale(s : FinanceriskvarNode, f : Double) -> FinanceriskvarNode {
  let result = finance_risk_var_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_var_node_add(a : FinanceriskvarNode, b : FinanceriskvarNode) -> FinanceriskvarNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_var_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_var_node_copy(s : FinanceriskvarNode) -> FinanceriskvarNode {
  let result = finance_risk_var_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_var_node_fill(s : FinanceriskvarNode, v : Double) -> FinanceriskvarNode {
  let result = finance_risk_var_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_node_min(s : FinanceriskvarNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_node_max(s : FinanceriskvarNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_node_to_string(s : FinanceriskvarNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_edge_make(size : Int) -> FinanceriskvarEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_edge_len(s : FinanceriskvarEdge) -> Int { s.size }

pub fn finance_risk_var_edge_get(s : FinanceriskvarEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_edge_set(s : FinanceriskvarEdge, i : Int, v : Double) -> FinanceriskvarEdge {
  let result = finance_risk_var_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_edge_sum(s : FinanceriskvarEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_var_edge_mean(s : FinanceriskvarEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_var_edge_sum(s) / s.size.to_double() }
}

pub fn finance_risk_var_edge_scale(s : FinanceriskvarEdge, f : Double) -> FinanceriskvarEdge {
  let result = finance_risk_var_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_var_edge_add(a : FinanceriskvarEdge, b : FinanceriskvarEdge) -> FinanceriskvarEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_var_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_var_edge_copy(s : FinanceriskvarEdge) -> FinanceriskvarEdge {
  let result = finance_risk_var_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_var_edge_fill(s : FinanceriskvarEdge, v : Double) -> FinanceriskvarEdge {
  let result = finance_risk_var_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_edge_min(s : FinanceriskvarEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_edge_max(s : FinanceriskvarEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_edge_to_string(s : FinanceriskvarEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_path_make(size : Int) -> FinanceriskvarPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_path_len(s : FinanceriskvarPath) -> Int { s.size }

pub fn finance_risk_var_path_get(s : FinanceriskvarPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_path_set(s : FinanceriskvarPath, i : Int, v : Double) -> FinanceriskvarPath {
  let result = finance_risk_var_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_path_sum(s : FinanceriskvarPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_var_path_mean(s : FinanceriskvarPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_var_path_sum(s) / s.size.to_double() }
}

pub fn finance_risk_var_path_scale(s : FinanceriskvarPath, f : Double) -> FinanceriskvarPath {
  let result = finance_risk_var_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_var_path_add(a : FinanceriskvarPath, b : FinanceriskvarPath) -> FinanceriskvarPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_var_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_var_path_copy(s : FinanceriskvarPath) -> FinanceriskvarPath {
  let result = finance_risk_var_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_var_path_fill(s : FinanceriskvarPath, v : Double) -> FinanceriskvarPath {
  let result = finance_risk_var_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_path_min(s : FinanceriskvarPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_path_max(s : FinanceriskvarPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_path_to_string(s : FinanceriskvarPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_cluster_make(size : Int) -> FinanceriskvarCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_cluster_len(s : FinanceriskvarCluster) -> Int { s.size }

pub fn finance_risk_var_cluster_get(s : FinanceriskvarCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_cluster_set(s : FinanceriskvarCluster, i : Int, v : Double) -> FinanceriskvarCluster {
  let result = finance_risk_var_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_cluster_sum(s : FinanceriskvarCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_var_cluster_mean(s : FinanceriskvarCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_var_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_risk_var_cluster_scale(s : FinanceriskvarCluster, f : Double) -> FinanceriskvarCluster {
  let result = finance_risk_var_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_var_cluster_add(a : FinanceriskvarCluster, b : FinanceriskvarCluster) -> FinanceriskvarCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_var_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_var_cluster_copy(s : FinanceriskvarCluster) -> FinanceriskvarCluster {
  let result = finance_risk_var_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_var_cluster_fill(s : FinanceriskvarCluster, v : Double) -> FinanceriskvarCluster {
  let result = finance_risk_var_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_cluster_min(s : FinanceriskvarCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_cluster_max(s : FinanceriskvarCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_cluster_to_string(s : FinanceriskvarCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_model_make(size : Int) -> FinanceriskvarModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_model_len(s : FinanceriskvarModel) -> Int { s.size }

pub fn finance_risk_var_model_get(s : FinanceriskvarModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_model_set(s : FinanceriskvarModel, i : Int, v : Double) -> FinanceriskvarModel {
  let result = finance_risk_var_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_model_sum(s : FinanceriskvarModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_var_model_mean(s : FinanceriskvarModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_var_model_sum(s) / s.size.to_double() }
}

pub fn finance_risk_var_model_scale(s : FinanceriskvarModel, f : Double) -> FinanceriskvarModel {
  let result = finance_risk_var_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_var_model_add(a : FinanceriskvarModel, b : FinanceriskvarModel) -> FinanceriskvarModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_var_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_var_model_copy(s : FinanceriskvarModel) -> FinanceriskvarModel {
  let result = finance_risk_var_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_var_model_fill(s : FinanceriskvarModel, v : Double) -> FinanceriskvarModel {
  let result = finance_risk_var_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_model_min(s : FinanceriskvarModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_model_max(s : FinanceriskvarModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_model_to_string(s : FinanceriskvarModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_layer_make(size : Int) -> FinanceriskvarLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_layer_len(s : FinanceriskvarLayer) -> Int { s.size }

pub fn finance_risk_var_layer_get(s : FinanceriskvarLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_layer_set(s : FinanceriskvarLayer, i : Int, v : Double) -> FinanceriskvarLayer {
  let result = finance_risk_var_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_layer_sum(s : FinanceriskvarLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_var_layer_mean(s : FinanceriskvarLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_var_layer_sum(s) / s.size.to_double() }
}

pub fn finance_risk_var_layer_scale(s : FinanceriskvarLayer, f : Double) -> FinanceriskvarLayer {
  let result = finance_risk_var_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_var_layer_add(a : FinanceriskvarLayer, b : FinanceriskvarLayer) -> FinanceriskvarLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_var_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_var_layer_copy(s : FinanceriskvarLayer) -> FinanceriskvarLayer {
  let result = finance_risk_var_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_var_layer_fill(s : FinanceriskvarLayer, v : Double) -> FinanceriskvarLayer {
  let result = finance_risk_var_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_layer_min(s : FinanceriskvarLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_layer_max(s : FinanceriskvarLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_layer_to_string(s : FinanceriskvarLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_buffer_make(size : Int) -> FinanceriskvarBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_buffer_len(s : FinanceriskvarBuffer) -> Int { s.size }

pub fn finance_risk_var_buffer_get(s : FinanceriskvarBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_buffer_set(s : FinanceriskvarBuffer, i : Int, v : Double) -> FinanceriskvarBuffer {
  let result = finance_risk_var_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_buffer_sum(s : FinanceriskvarBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_var_buffer_mean(s : FinanceriskvarBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_var_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_risk_var_buffer_scale(s : FinanceriskvarBuffer, f : Double) -> FinanceriskvarBuffer {
  let result = finance_risk_var_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_var_buffer_add(a : FinanceriskvarBuffer, b : FinanceriskvarBuffer) -> FinanceriskvarBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_var_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_var_buffer_copy(s : FinanceriskvarBuffer) -> FinanceriskvarBuffer {
  let result = finance_risk_var_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_var_buffer_fill(s : FinanceriskvarBuffer, v : Double) -> FinanceriskvarBuffer {
  let result = finance_risk_var_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_buffer_min(s : FinanceriskvarBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_buffer_max(s : FinanceriskvarBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_buffer_to_string(s : FinanceriskvarBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_cursor_make(size : Int) -> FinanceriskvarCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_cursor_len(s : FinanceriskvarCursor) -> Int { s.size }

pub fn finance_risk_var_cursor_get(s : FinanceriskvarCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_cursor_set(s : FinanceriskvarCursor, i : Int, v : Double) -> FinanceriskvarCursor {
  let result = finance_risk_var_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_cursor_sum(s : FinanceriskvarCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_var_cursor_mean(s : FinanceriskvarCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_var_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_risk_var_cursor_scale(s : FinanceriskvarCursor, f : Double) -> FinanceriskvarCursor {
  let result = finance_risk_var_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_var_cursor_add(a : FinanceriskvarCursor, b : FinanceriskvarCursor) -> FinanceriskvarCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_var_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_var_cursor_copy(s : FinanceriskvarCursor) -> FinanceriskvarCursor {
  let result = finance_risk_var_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_var_cursor_fill(s : FinanceriskvarCursor, v : Double) -> FinanceriskvarCursor {
  let result = finance_risk_var_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_cursor_min(s : FinanceriskvarCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_cursor_max(s : FinanceriskvarCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_cursor_to_string(s : FinanceriskvarCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_view_make(size : Int) -> FinanceriskvarView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_view_len(s : FinanceriskvarView) -> Int { s.size }

pub fn finance_risk_var_view_get(s : FinanceriskvarView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_view_set(s : FinanceriskvarView, i : Int, v : Double) -> FinanceriskvarView {
  let result = finance_risk_var_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_view_sum(s : FinanceriskvarView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_var_view_mean(s : FinanceriskvarView) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_var_view_sum(s) / s.size.to_double() }
}

pub fn finance_risk_var_view_scale(s : FinanceriskvarView, f : Double) -> FinanceriskvarView {
  let result = finance_risk_var_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_var_view_add(a : FinanceriskvarView, b : FinanceriskvarView) -> FinanceriskvarView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_var_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_var_view_copy(s : FinanceriskvarView) -> FinanceriskvarView {
  let result = finance_risk_var_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_var_view_fill(s : FinanceriskvarView, v : Double) -> FinanceriskvarView {
  let result = finance_risk_var_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_view_min(s : FinanceriskvarView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_view_max(s : FinanceriskvarView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_view_to_string(s : FinanceriskvarView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_range_make(size : Int) -> FinanceriskvarRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_range_len(s : FinanceriskvarRange) -> Int { s.size }

pub fn finance_risk_var_range_get(s : FinanceriskvarRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_range_set(s : FinanceriskvarRange, i : Int, v : Double) -> FinanceriskvarRange {
  let result = finance_risk_var_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_range_sum(s : FinanceriskvarRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_var_range_mean(s : FinanceriskvarRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_var_range_sum(s) / s.size.to_double() }
}

pub fn finance_risk_var_range_scale(s : FinanceriskvarRange, f : Double) -> FinanceriskvarRange {
  let result = finance_risk_var_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_var_range_add(a : FinanceriskvarRange, b : FinanceriskvarRange) -> FinanceriskvarRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_var_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_var_range_copy(s : FinanceriskvarRange) -> FinanceriskvarRange {
  let result = finance_risk_var_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_var_range_fill(s : FinanceriskvarRange, v : Double) -> FinanceriskvarRange {
  let result = finance_risk_var_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_range_min(s : FinanceriskvarRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_range_max(s : FinanceriskvarRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_range_to_string(s : FinanceriskvarRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_slice_make(size : Int) -> FinanceriskvarSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_slice_len(s : FinanceriskvarSlice) -> Int { s.size }

pub fn finance_risk_var_slice_get(s : FinanceriskvarSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_slice_set(s : FinanceriskvarSlice, i : Int, v : Double) -> FinanceriskvarSlice {
  let result = finance_risk_var_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_slice_sum(s : FinanceriskvarSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_var_slice_mean(s : FinanceriskvarSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_var_slice_sum(s) / s.size.to_double() }
}

pub fn finance_risk_var_slice_scale(s : FinanceriskvarSlice, f : Double) -> FinanceriskvarSlice {
  let result = finance_risk_var_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_var_slice_add(a : FinanceriskvarSlice, b : FinanceriskvarSlice) -> FinanceriskvarSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_var_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_var_slice_copy(s : FinanceriskvarSlice) -> FinanceriskvarSlice {
  let result = finance_risk_var_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_var_slice_fill(s : FinanceriskvarSlice, v : Double) -> FinanceriskvarSlice {
  let result = finance_risk_var_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_var_slice_min(s : FinanceriskvarSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_slice_max(s : FinanceriskvarSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_var_slice_to_string(s : FinanceriskvarSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn finance_risk_var_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_var_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_var_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_var_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_var_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_var_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_var_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_var_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_var_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_var_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_var_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_var_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_var_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_var_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_var_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_var_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_var_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_var_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_var_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_var_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_var_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_var_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_var_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_var_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_var_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

