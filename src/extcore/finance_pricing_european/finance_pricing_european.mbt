///===
/// extcore/finance_pricing_european

pub(all) struct FinancepricingeuropeanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_european_make_point(x : Double, y : Double) -> FinancepricingeuropeanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_european_make_point3(x : Double, y : Double, z : Double) -> FinancepricingeuropeanPoint {
  { x, y, z, label: 0 }
}

pub fn finance_pricing_european_point_x(pt : FinancepricingeuropeanPoint) -> Double { pt.x }

pub fn finance_pricing_european_point_y(pt : FinancepricingeuropeanPoint) -> Double { pt.y }

pub fn finance_pricing_european_point_z(pt : FinancepricingeuropeanPoint) -> Double { pt.z }

pub fn finance_pricing_european_point_label(pt : FinancepricingeuropeanPoint) -> Int { pt.label }

pub fn finance_pricing_european_point_dist(a : FinancepricingeuropeanPoint, b : FinancepricingeuropeanPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  finance_pricing_european_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_pricing_european_point_add(a : FinancepricingeuropeanPoint, b : FinancepricingeuropeanPoint) -> FinancepricingeuropeanPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_pricing_european_point_sub(a : FinancepricingeuropeanPoint, b : FinancepricingeuropeanPoint) -> FinancepricingeuropeanPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_pricing_european_point_scale(pt : FinancepricingeuropeanPoint, s : Double) -> FinancepricingeuropeanPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_pricing_european_point_dot(a : FinancepricingeuropeanPoint, b : FinancepricingeuropeanPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_pricing_european_point_cross(a : FinancepricingeuropeanPoint, b : FinancepricingeuropeanPoint) -> FinancepricingeuropeanPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_pricing_european_point_norm(pt : FinancepricingeuropeanPoint) -> Double {
  finance_pricing_european_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_pricing_european_point_normalize(pt : FinancepricingeuropeanPoint) -> FinancepricingeuropeanPoint {
  let n = finance_pricing_european_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_pricing_european_point_scale(pt, 1.0 / n) }
}

pub fn finance_pricing_european_point_negate(pt : FinancepricingeuropeanPoint) -> FinancepricingeuropeanPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_pricing_european_point_mid(a : FinancepricingeuropeanPoint, b : FinancepricingeuropeanPoint) -> FinancepricingeuropeanPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_pricing_european_point_lerp(a : FinancepricingeuropeanPoint, b : FinancepricingeuropeanPoint, t : Double) -> FinancepricingeuropeanPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_pricing_european_point_to_string(pt : FinancepricingeuropeanPoint) -> String {
  "(" + finance_pricing_european_dbl(pt.x) + ", " + finance_pricing_european_dbl(pt.y) + ", " + finance_pricing_european_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_european_make_series(vals : Array[Double], name : String) -> FinancepricingeuropeanSeries {
  { vals, name, meta: 0 }
}

pub fn finance_pricing_european_series_len(s : FinancepricingeuropeanSeries) -> Int { s.vals.length() }

pub fn finance_pricing_european_series_sum(s : FinancepricingeuropeanSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_pricing_european_series_mean(s : FinancepricingeuropeanSeries) -> Double {
  let n = finance_pricing_european_series_len(s)
  if n == 0 { 0.0 } else { finance_pricing_european_series_sum(s) / n.to_double() }
}

pub fn finance_pricing_european_series_min(s : FinancepricingeuropeanSeries) -> Double {
  let n = finance_pricing_european_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_pricing_european_series_max(s : FinancepricingeuropeanSeries) -> Double {
  let n = finance_pricing_european_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_pricing_european_series_range(s : FinancepricingeuropeanSeries) -> Double {
  finance_pricing_european_series_max(s) - finance_pricing_european_series_min(s)
}

pub fn finance_pricing_european_series_var(s : FinancepricingeuropeanSeries) -> Double {
  let n = finance_pricing_european_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_pricing_european_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_pricing_european_series_std(s : FinancepricingeuropeanSeries) -> Double { finance_pricing_european_sqrt(finance_pricing_european_series_var(s)) }

pub fn finance_pricing_european_series_median(s : FinancepricingeuropeanSeries) -> Double {
  let n = finance_pricing_european_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_pricing_european_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_pricing_european_series_scale(s : FinancepricingeuropeanSeries, f : Double) -> FinancepricingeuropeanSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = finance_pricing_european_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_pricing_european_series_add(a : FinancepricingeuropeanSeries, b : FinancepricingeuropeanSeries) -> FinancepricingeuropeanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_pricing_european_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_pricing_european_series_sub(a : FinancepricingeuropeanSeries, b : FinancepricingeuropeanSeries) -> FinancepricingeuropeanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_pricing_european_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_pricing_european_series_normalize(s : FinancepricingeuropeanSeries) -> FinancepricingeuropeanSeries {
  let mn = finance_pricing_european_series_min(s)
  let mx = finance_pricing_european_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = finance_pricing_european_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_pricing_european_series_cumsum(s : FinancepricingeuropeanSeries) -> FinancepricingeuropeanSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = finance_pricing_european_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_pricing_european_series_to_string(s : FinancepricingeuropeanSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_pricing_european_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingeuropeanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_european_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingeuropeanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_european_matrix_identity(n : Int) -> FinancepricingeuropeanMatrix {
  let m = finance_pricing_european_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_pricing_european_matrix_get(m : FinancepricingeuropeanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_pricing_european_matrix_transpose(m : FinancepricingeuropeanMatrix) -> FinancepricingeuropeanMatrix {
  let result = finance_pricing_european_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_pricing_european_matrix_add(a : FinancepricingeuropeanMatrix, b : FinancepricingeuropeanMatrix) -> FinancepricingeuropeanMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_pricing_european_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_pricing_european_matrix_scale(m : FinancepricingeuropeanMatrix, s : Double) -> FinancepricingeuropeanMatrix {
  let result = finance_pricing_european_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_pricing_european_matrix_multiply(a : FinancepricingeuropeanMatrix, b : FinancepricingeuropeanMatrix) -> FinancepricingeuropeanMatrix {
  if a.cols != b.rows { return finance_pricing_european_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_pricing_european_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_pricing_european_matrix_trace(m : FinancepricingeuropeanMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_pricing_european_matrix_det(m : FinancepricingeuropeanMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_pricing_european_matrix_norm(m : FinancepricingeuropeanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  finance_pricing_european_sqrt(sum)
}

pub fn finance_pricing_european_matrix_to_string(m : FinancepricingeuropeanMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + finance_pricing_european_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct FinancepricingeuropeanVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_european_make_vector(comps : Array[Double]) -> FinancepricingeuropeanVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_european_vector_zero(dim : Int) -> FinancepricingeuropeanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_pricing_european_vector_add(a : FinancepricingeuropeanVector, b : FinancepricingeuropeanVector) -> FinancepricingeuropeanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_pricing_european_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_pricing_european_vector_sub(a : FinancepricingeuropeanVector, b : FinancepricingeuropeanVector) -> FinancepricingeuropeanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_pricing_european_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_pricing_european_vector_scale(v : FinancepricingeuropeanVector, s : Double) -> FinancepricingeuropeanVector {
  let mut result = []
  for i in 0..<v.dim { result = finance_pricing_european_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_pricing_european_vector_dot(a : FinancepricingeuropeanVector, b : FinancepricingeuropeanVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_pricing_european_vector_norm(v : FinancepricingeuropeanVector) -> Double { finance_pricing_european_sqrt(finance_pricing_european_vector_dot(v, v)) }

pub fn finance_pricing_european_vector_normalize(v : FinancepricingeuropeanVector) -> FinancepricingeuropeanVector {
  let n = finance_pricing_european_vector_norm(v)
  if n < 0.0000001 { v } else { finance_pricing_european_vector_scale(v, 1.0 / n) }
}

pub fn finance_pricing_european_vector_dist(a : FinancepricingeuropeanVector, b : FinancepricingeuropeanVector) -> Double {
  finance_pricing_european_vector_norm(finance_pricing_european_vector_sub(a, b))
}

pub fn finance_pricing_european_vector_to_string(v : FinancepricingeuropeanVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_pricing_european_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_pricing_european_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn finance_pricing_european_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = finance_pricing_european_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_pricing_european_std(data : Array[Double]) -> Double { finance_pricing_european_sqrt(finance_pricing_european_var(data)) }

pub fn finance_pricing_european_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = finance_pricing_european_mean(a); let mb = finance_pricing_european_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn finance_pricing_european_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = finance_pricing_european_std(a); let sb = finance_pricing_european_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { finance_pricing_european_cov(a, b) / (sa * sb) }
}

pub fn finance_pricing_european_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = finance_pricing_european_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_pricing_european_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn finance_pricing_european_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_pricing_european_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  finance_pricing_european_sqrt(finance_pricing_european_mse(pred, labels))
}

pub fn finance_pricing_european_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + finance_pricing_european_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn finance_pricing_european_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = finance_pricing_european_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn finance_pricing_european_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn finance_pricing_european_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn finance_pricing_european_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = finance_pricing_european_precision(pred, labels, pos); let r = finance_pricing_european_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn finance_pricing_european_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn finance_pricing_european_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = finance_pricing_european_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn finance_pricing_european_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn finance_pricing_european_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn finance_pricing_european_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = finance_pricing_european_gcd(a, b)
    (a / g) * b
  }
}

pub fn finance_pricing_european_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn finance_pricing_european_fibonacci(n : Int) -> Int {
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

pub fn finance_pricing_european_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = finance_pricing_european_min(data); let mx = finance_pricing_european_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn finance_pricing_european_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = finance_pricing_european_mean(data); let sd = finance_pricing_european_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn finance_pricing_european_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn finance_pricing_european_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn finance_pricing_european_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn finance_pricing_european_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn finance_pricing_european_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn finance_pricing_european_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn finance_pricing_european_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn finance_pricing_european_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn finance_pricing_european_dbl(x : Double) -> String {
  let i = if x >= 0.0 { finance_pricing_european_int(x) } else { -finance_pricing_european_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { finance_pricing_european_int(f * 1000000.0) } else { finance_pricing_european_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn finance_pricing_european_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn finance_pricing_european_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct FinancepricingeuropeanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_frame_make(size : Int) -> FinancepricingeuropeanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_frame_len(s : FinancepricingeuropeanFrame) -> Int { s.size }

pub fn finance_pricing_european_frame_get(s : FinancepricingeuropeanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_frame_set(s : FinancepricingeuropeanFrame, i : Int, v : Double) -> FinancepricingeuropeanFrame {
  let result = finance_pricing_european_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_frame_sum(s : FinancepricingeuropeanFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_european_frame_mean(s : FinancepricingeuropeanFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_european_frame_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_european_frame_scale(s : FinancepricingeuropeanFrame, f : Double) -> FinancepricingeuropeanFrame {
  let result = finance_pricing_european_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_european_frame_add(a : FinancepricingeuropeanFrame, b : FinancepricingeuropeanFrame) -> FinancepricingeuropeanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_european_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_european_frame_copy(s : FinancepricingeuropeanFrame) -> FinancepricingeuropeanFrame {
  let result = finance_pricing_european_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_european_frame_fill(s : FinancepricingeuropeanFrame, v : Double) -> FinancepricingeuropeanFrame {
  let result = finance_pricing_european_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_frame_min(s : FinancepricingeuropeanFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_frame_max(s : FinancepricingeuropeanFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_frame_to_string(s : FinancepricingeuropeanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_table_make(size : Int) -> FinancepricingeuropeanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_table_len(s : FinancepricingeuropeanTable) -> Int { s.size }

pub fn finance_pricing_european_table_get(s : FinancepricingeuropeanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_table_set(s : FinancepricingeuropeanTable, i : Int, v : Double) -> FinancepricingeuropeanTable {
  let result = finance_pricing_european_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_table_sum(s : FinancepricingeuropeanTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_european_table_mean(s : FinancepricingeuropeanTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_european_table_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_european_table_scale(s : FinancepricingeuropeanTable, f : Double) -> FinancepricingeuropeanTable {
  let result = finance_pricing_european_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_european_table_add(a : FinancepricingeuropeanTable, b : FinancepricingeuropeanTable) -> FinancepricingeuropeanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_european_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_european_table_copy(s : FinancepricingeuropeanTable) -> FinancepricingeuropeanTable {
  let result = finance_pricing_european_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_european_table_fill(s : FinancepricingeuropeanTable, v : Double) -> FinancepricingeuropeanTable {
  let result = finance_pricing_european_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_table_min(s : FinancepricingeuropeanTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_table_max(s : FinancepricingeuropeanTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_table_to_string(s : FinancepricingeuropeanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_graphn_make(size : Int) -> FinancepricingeuropeanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_graphn_len(s : FinancepricingeuropeanGraphN) -> Int { s.size }

pub fn finance_pricing_european_graphn_get(s : FinancepricingeuropeanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_graphn_set(s : FinancepricingeuropeanGraphN, i : Int, v : Double) -> FinancepricingeuropeanGraphN {
  let result = finance_pricing_european_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_graphn_sum(s : FinancepricingeuropeanGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_european_graphn_mean(s : FinancepricingeuropeanGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_european_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_european_graphn_scale(s : FinancepricingeuropeanGraphN, f : Double) -> FinancepricingeuropeanGraphN {
  let result = finance_pricing_european_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_european_graphn_add(a : FinancepricingeuropeanGraphN, b : FinancepricingeuropeanGraphN) -> FinancepricingeuropeanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_european_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_european_graphn_copy(s : FinancepricingeuropeanGraphN) -> FinancepricingeuropeanGraphN {
  let result = finance_pricing_european_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_european_graphn_fill(s : FinancepricingeuropeanGraphN, v : Double) -> FinancepricingeuropeanGraphN {
  let result = finance_pricing_european_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_graphn_min(s : FinancepricingeuropeanGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_graphn_max(s : FinancepricingeuropeanGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_graphn_to_string(s : FinancepricingeuropeanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_node_make(size : Int) -> FinancepricingeuropeanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_node_len(s : FinancepricingeuropeanNode) -> Int { s.size }

pub fn finance_pricing_european_node_get(s : FinancepricingeuropeanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_node_set(s : FinancepricingeuropeanNode, i : Int, v : Double) -> FinancepricingeuropeanNode {
  let result = finance_pricing_european_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_node_sum(s : FinancepricingeuropeanNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_european_node_mean(s : FinancepricingeuropeanNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_european_node_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_european_node_scale(s : FinancepricingeuropeanNode, f : Double) -> FinancepricingeuropeanNode {
  let result = finance_pricing_european_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_european_node_add(a : FinancepricingeuropeanNode, b : FinancepricingeuropeanNode) -> FinancepricingeuropeanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_european_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_european_node_copy(s : FinancepricingeuropeanNode) -> FinancepricingeuropeanNode {
  let result = finance_pricing_european_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_european_node_fill(s : FinancepricingeuropeanNode, v : Double) -> FinancepricingeuropeanNode {
  let result = finance_pricing_european_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_node_min(s : FinancepricingeuropeanNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_node_max(s : FinancepricingeuropeanNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_node_to_string(s : FinancepricingeuropeanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_edge_make(size : Int) -> FinancepricingeuropeanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_edge_len(s : FinancepricingeuropeanEdge) -> Int { s.size }

pub fn finance_pricing_european_edge_get(s : FinancepricingeuropeanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_edge_set(s : FinancepricingeuropeanEdge, i : Int, v : Double) -> FinancepricingeuropeanEdge {
  let result = finance_pricing_european_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_edge_sum(s : FinancepricingeuropeanEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_european_edge_mean(s : FinancepricingeuropeanEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_european_edge_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_european_edge_scale(s : FinancepricingeuropeanEdge, f : Double) -> FinancepricingeuropeanEdge {
  let result = finance_pricing_european_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_european_edge_add(a : FinancepricingeuropeanEdge, b : FinancepricingeuropeanEdge) -> FinancepricingeuropeanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_european_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_european_edge_copy(s : FinancepricingeuropeanEdge) -> FinancepricingeuropeanEdge {
  let result = finance_pricing_european_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_european_edge_fill(s : FinancepricingeuropeanEdge, v : Double) -> FinancepricingeuropeanEdge {
  let result = finance_pricing_european_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_edge_min(s : FinancepricingeuropeanEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_edge_max(s : FinancepricingeuropeanEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_edge_to_string(s : FinancepricingeuropeanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_path_make(size : Int) -> FinancepricingeuropeanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_path_len(s : FinancepricingeuropeanPath) -> Int { s.size }

pub fn finance_pricing_european_path_get(s : FinancepricingeuropeanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_path_set(s : FinancepricingeuropeanPath, i : Int, v : Double) -> FinancepricingeuropeanPath {
  let result = finance_pricing_european_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_path_sum(s : FinancepricingeuropeanPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_european_path_mean(s : FinancepricingeuropeanPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_european_path_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_european_path_scale(s : FinancepricingeuropeanPath, f : Double) -> FinancepricingeuropeanPath {
  let result = finance_pricing_european_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_european_path_add(a : FinancepricingeuropeanPath, b : FinancepricingeuropeanPath) -> FinancepricingeuropeanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_european_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_european_path_copy(s : FinancepricingeuropeanPath) -> FinancepricingeuropeanPath {
  let result = finance_pricing_european_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_european_path_fill(s : FinancepricingeuropeanPath, v : Double) -> FinancepricingeuropeanPath {
  let result = finance_pricing_european_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_path_min(s : FinancepricingeuropeanPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_path_max(s : FinancepricingeuropeanPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_path_to_string(s : FinancepricingeuropeanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_cluster_make(size : Int) -> FinancepricingeuropeanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_cluster_len(s : FinancepricingeuropeanCluster) -> Int { s.size }

pub fn finance_pricing_european_cluster_get(s : FinancepricingeuropeanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_cluster_set(s : FinancepricingeuropeanCluster, i : Int, v : Double) -> FinancepricingeuropeanCluster {
  let result = finance_pricing_european_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_cluster_sum(s : FinancepricingeuropeanCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_european_cluster_mean(s : FinancepricingeuropeanCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_european_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_european_cluster_scale(s : FinancepricingeuropeanCluster, f : Double) -> FinancepricingeuropeanCluster {
  let result = finance_pricing_european_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_european_cluster_add(a : FinancepricingeuropeanCluster, b : FinancepricingeuropeanCluster) -> FinancepricingeuropeanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_european_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_european_cluster_copy(s : FinancepricingeuropeanCluster) -> FinancepricingeuropeanCluster {
  let result = finance_pricing_european_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_european_cluster_fill(s : FinancepricingeuropeanCluster, v : Double) -> FinancepricingeuropeanCluster {
  let result = finance_pricing_european_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_cluster_min(s : FinancepricingeuropeanCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_cluster_max(s : FinancepricingeuropeanCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_cluster_to_string(s : FinancepricingeuropeanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_model_make(size : Int) -> FinancepricingeuropeanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_model_len(s : FinancepricingeuropeanModel) -> Int { s.size }

pub fn finance_pricing_european_model_get(s : FinancepricingeuropeanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_model_set(s : FinancepricingeuropeanModel, i : Int, v : Double) -> FinancepricingeuropeanModel {
  let result = finance_pricing_european_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_model_sum(s : FinancepricingeuropeanModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_european_model_mean(s : FinancepricingeuropeanModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_european_model_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_european_model_scale(s : FinancepricingeuropeanModel, f : Double) -> FinancepricingeuropeanModel {
  let result = finance_pricing_european_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_european_model_add(a : FinancepricingeuropeanModel, b : FinancepricingeuropeanModel) -> FinancepricingeuropeanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_european_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_european_model_copy(s : FinancepricingeuropeanModel) -> FinancepricingeuropeanModel {
  let result = finance_pricing_european_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_european_model_fill(s : FinancepricingeuropeanModel, v : Double) -> FinancepricingeuropeanModel {
  let result = finance_pricing_european_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_model_min(s : FinancepricingeuropeanModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_model_max(s : FinancepricingeuropeanModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_model_to_string(s : FinancepricingeuropeanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_layer_make(size : Int) -> FinancepricingeuropeanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_layer_len(s : FinancepricingeuropeanLayer) -> Int { s.size }

pub fn finance_pricing_european_layer_get(s : FinancepricingeuropeanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_layer_set(s : FinancepricingeuropeanLayer, i : Int, v : Double) -> FinancepricingeuropeanLayer {
  let result = finance_pricing_european_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_layer_sum(s : FinancepricingeuropeanLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_european_layer_mean(s : FinancepricingeuropeanLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_european_layer_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_european_layer_scale(s : FinancepricingeuropeanLayer, f : Double) -> FinancepricingeuropeanLayer {
  let result = finance_pricing_european_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_european_layer_add(a : FinancepricingeuropeanLayer, b : FinancepricingeuropeanLayer) -> FinancepricingeuropeanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_european_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_european_layer_copy(s : FinancepricingeuropeanLayer) -> FinancepricingeuropeanLayer {
  let result = finance_pricing_european_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_european_layer_fill(s : FinancepricingeuropeanLayer, v : Double) -> FinancepricingeuropeanLayer {
  let result = finance_pricing_european_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_layer_min(s : FinancepricingeuropeanLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_layer_max(s : FinancepricingeuropeanLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_layer_to_string(s : FinancepricingeuropeanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_buffer_make(size : Int) -> FinancepricingeuropeanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_buffer_len(s : FinancepricingeuropeanBuffer) -> Int { s.size }

pub fn finance_pricing_european_buffer_get(s : FinancepricingeuropeanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_buffer_set(s : FinancepricingeuropeanBuffer, i : Int, v : Double) -> FinancepricingeuropeanBuffer {
  let result = finance_pricing_european_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_buffer_sum(s : FinancepricingeuropeanBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_european_buffer_mean(s : FinancepricingeuropeanBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_european_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_european_buffer_scale(s : FinancepricingeuropeanBuffer, f : Double) -> FinancepricingeuropeanBuffer {
  let result = finance_pricing_european_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_european_buffer_add(a : FinancepricingeuropeanBuffer, b : FinancepricingeuropeanBuffer) -> FinancepricingeuropeanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_european_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_european_buffer_copy(s : FinancepricingeuropeanBuffer) -> FinancepricingeuropeanBuffer {
  let result = finance_pricing_european_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_european_buffer_fill(s : FinancepricingeuropeanBuffer, v : Double) -> FinancepricingeuropeanBuffer {
  let result = finance_pricing_european_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_buffer_min(s : FinancepricingeuropeanBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_buffer_max(s : FinancepricingeuropeanBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_buffer_to_string(s : FinancepricingeuropeanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_cursor_make(size : Int) -> FinancepricingeuropeanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_cursor_len(s : FinancepricingeuropeanCursor) -> Int { s.size }

pub fn finance_pricing_european_cursor_get(s : FinancepricingeuropeanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_cursor_set(s : FinancepricingeuropeanCursor, i : Int, v : Double) -> FinancepricingeuropeanCursor {
  let result = finance_pricing_european_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_cursor_sum(s : FinancepricingeuropeanCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_european_cursor_mean(s : FinancepricingeuropeanCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_european_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_european_cursor_scale(s : FinancepricingeuropeanCursor, f : Double) -> FinancepricingeuropeanCursor {
  let result = finance_pricing_european_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_european_cursor_add(a : FinancepricingeuropeanCursor, b : FinancepricingeuropeanCursor) -> FinancepricingeuropeanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_european_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_european_cursor_copy(s : FinancepricingeuropeanCursor) -> FinancepricingeuropeanCursor {
  let result = finance_pricing_european_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_european_cursor_fill(s : FinancepricingeuropeanCursor, v : Double) -> FinancepricingeuropeanCursor {
  let result = finance_pricing_european_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_cursor_min(s : FinancepricingeuropeanCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_cursor_max(s : FinancepricingeuropeanCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_cursor_to_string(s : FinancepricingeuropeanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_view_make(size : Int) -> FinancepricingeuropeanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_view_len(s : FinancepricingeuropeanView) -> Int { s.size }

pub fn finance_pricing_european_view_get(s : FinancepricingeuropeanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_view_set(s : FinancepricingeuropeanView, i : Int, v : Double) -> FinancepricingeuropeanView {
  let result = finance_pricing_european_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_view_sum(s : FinancepricingeuropeanView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_european_view_mean(s : FinancepricingeuropeanView) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_european_view_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_european_view_scale(s : FinancepricingeuropeanView, f : Double) -> FinancepricingeuropeanView {
  let result = finance_pricing_european_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_european_view_add(a : FinancepricingeuropeanView, b : FinancepricingeuropeanView) -> FinancepricingeuropeanView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_european_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_european_view_copy(s : FinancepricingeuropeanView) -> FinancepricingeuropeanView {
  let result = finance_pricing_european_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_european_view_fill(s : FinancepricingeuropeanView, v : Double) -> FinancepricingeuropeanView {
  let result = finance_pricing_european_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_view_min(s : FinancepricingeuropeanView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_view_max(s : FinancepricingeuropeanView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_view_to_string(s : FinancepricingeuropeanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_range_make(size : Int) -> FinancepricingeuropeanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_range_len(s : FinancepricingeuropeanRange) -> Int { s.size }

pub fn finance_pricing_european_range_get(s : FinancepricingeuropeanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_range_set(s : FinancepricingeuropeanRange, i : Int, v : Double) -> FinancepricingeuropeanRange {
  let result = finance_pricing_european_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_range_sum(s : FinancepricingeuropeanRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_european_range_mean(s : FinancepricingeuropeanRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_european_range_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_european_range_scale(s : FinancepricingeuropeanRange, f : Double) -> FinancepricingeuropeanRange {
  let result = finance_pricing_european_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_european_range_add(a : FinancepricingeuropeanRange, b : FinancepricingeuropeanRange) -> FinancepricingeuropeanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_european_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_european_range_copy(s : FinancepricingeuropeanRange) -> FinancepricingeuropeanRange {
  let result = finance_pricing_european_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_european_range_fill(s : FinancepricingeuropeanRange, v : Double) -> FinancepricingeuropeanRange {
  let result = finance_pricing_european_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_range_min(s : FinancepricingeuropeanRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_range_max(s : FinancepricingeuropeanRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_range_to_string(s : FinancepricingeuropeanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_slice_make(size : Int) -> FinancepricingeuropeanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_slice_len(s : FinancepricingeuropeanSlice) -> Int { s.size }

pub fn finance_pricing_european_slice_get(s : FinancepricingeuropeanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_slice_set(s : FinancepricingeuropeanSlice, i : Int, v : Double) -> FinancepricingeuropeanSlice {
  let result = finance_pricing_european_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_slice_sum(s : FinancepricingeuropeanSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_european_slice_mean(s : FinancepricingeuropeanSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_european_slice_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_european_slice_scale(s : FinancepricingeuropeanSlice, f : Double) -> FinancepricingeuropeanSlice {
  let result = finance_pricing_european_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_european_slice_add(a : FinancepricingeuropeanSlice, b : FinancepricingeuropeanSlice) -> FinancepricingeuropeanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_european_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_european_slice_copy(s : FinancepricingeuropeanSlice) -> FinancepricingeuropeanSlice {
  let result = finance_pricing_european_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_european_slice_fill(s : FinancepricingeuropeanSlice, v : Double) -> FinancepricingeuropeanSlice {
  let result = finance_pricing_european_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_european_slice_min(s : FinancepricingeuropeanSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_slice_max(s : FinancepricingeuropeanSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_european_slice_to_string(s : FinancepricingeuropeanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn finance_pricing_european_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_european_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_european_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_european_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_european_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_european_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_european_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_european_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_european_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_european_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_european_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_european_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_european_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_european_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_european_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_european_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_european_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_european_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_european_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_european_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_european_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_european_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_european_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_european_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_european_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

