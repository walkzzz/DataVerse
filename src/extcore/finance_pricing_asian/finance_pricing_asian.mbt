///===
/// extcore/finance_pricing_asian

pub(all) struct FinancepricingasianPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_asian_make_point(x : Double, y : Double) -> FinancepricingasianPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_asian_make_point3(x : Double, y : Double, z : Double) -> FinancepricingasianPoint {
  { x, y, z, label: 0 }
}

pub fn finance_pricing_asian_point_x(pt : FinancepricingasianPoint) -> Double { pt.x }

pub fn finance_pricing_asian_point_y(pt : FinancepricingasianPoint) -> Double { pt.y }

pub fn finance_pricing_asian_point_z(pt : FinancepricingasianPoint) -> Double { pt.z }

pub fn finance_pricing_asian_point_label(pt : FinancepricingasianPoint) -> Int { pt.label }

pub fn finance_pricing_asian_point_dist(a : FinancepricingasianPoint, b : FinancepricingasianPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_pricing_asian_point_add(a : FinancepricingasianPoint, b : FinancepricingasianPoint) -> FinancepricingasianPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_pricing_asian_point_sub(a : FinancepricingasianPoint, b : FinancepricingasianPoint) -> FinancepricingasianPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_pricing_asian_point_scale(pt : FinancepricingasianPoint, s : Double) -> FinancepricingasianPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_pricing_asian_point_dot(a : FinancepricingasianPoint, b : FinancepricingasianPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_pricing_asian_point_cross(a : FinancepricingasianPoint, b : FinancepricingasianPoint) -> FinancepricingasianPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_pricing_asian_point_norm(pt : FinancepricingasianPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_pricing_asian_point_normalize(pt : FinancepricingasianPoint) -> FinancepricingasianPoint {
  let n = finance_pricing_asian_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_pricing_asian_point_scale(pt, 1.0 / n) }
}

pub fn finance_pricing_asian_point_negate(pt : FinancepricingasianPoint) -> FinancepricingasianPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_pricing_asian_point_mid(a : FinancepricingasianPoint, b : FinancepricingasianPoint) -> FinancepricingasianPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_pricing_asian_point_lerp(a : FinancepricingasianPoint, b : FinancepricingasianPoint, t : Double) -> FinancepricingasianPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_pricing_asian_point_to_string(pt : FinancepricingasianPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancepricingasianSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_asian_make_series(vals : Array[Double], name : String) -> FinancepricingasianSeries {
  { vals, name, meta: 0 }
}

pub fn finance_pricing_asian_series_len(s : FinancepricingasianSeries) -> Int { s.vals.length() }

pub fn finance_pricing_asian_series_sum(s : FinancepricingasianSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_pricing_asian_series_mean(s : FinancepricingasianSeries) -> Double {
  let n = finance_pricing_asian_series_len(s)
  if n == 0 { 0.0 } else { finance_pricing_asian_series_sum(s) / n.to_double() }
}

pub fn finance_pricing_asian_series_min(s : FinancepricingasianSeries) -> Double {
  let n = finance_pricing_asian_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_pricing_asian_series_max(s : FinancepricingasianSeries) -> Double {
  let n = finance_pricing_asian_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_pricing_asian_series_range(s : FinancepricingasianSeries) -> Double {
  finance_pricing_asian_series_max(s) - finance_pricing_asian_series_min(s)
}

pub fn finance_pricing_asian_series_var(s : FinancepricingasianSeries) -> Double {
  let n = finance_pricing_asian_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_pricing_asian_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_pricing_asian_series_std(s : FinancepricingasianSeries) -> Double { @_common.sqrt(finance_pricing_asian_series_var(s)) }

pub fn finance_pricing_asian_series_median(s : FinancepricingasianSeries) -> Double {
  let n = finance_pricing_asian_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_pricing_asian_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_pricing_asian_series_scale(s : FinancepricingasianSeries, f : Double) -> FinancepricingasianSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_pricing_asian_series_add(a : FinancepricingasianSeries, b : FinancepricingasianSeries) -> FinancepricingasianSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_pricing_asian_series_sub(a : FinancepricingasianSeries, b : FinancepricingasianSeries) -> FinancepricingasianSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_pricing_asian_series_normalize(s : FinancepricingasianSeries) -> FinancepricingasianSeries {
  let mn = finance_pricing_asian_series_min(s)
  let mx = finance_pricing_asian_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_pricing_asian_series_cumsum(s : FinancepricingasianSeries) -> FinancepricingasianSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_pricing_asian_series_to_string(s : FinancepricingasianSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingasianMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_asian_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingasianMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_asian_matrix_identity(n : Int) -> FinancepricingasianMatrix {
  let m = finance_pricing_asian_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_pricing_asian_matrix_get(m : FinancepricingasianMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_pricing_asian_matrix_transpose(m : FinancepricingasianMatrix) -> FinancepricingasianMatrix {
  let result = finance_pricing_asian_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_pricing_asian_matrix_add(a : FinancepricingasianMatrix, b : FinancepricingasianMatrix) -> FinancepricingasianMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_pricing_asian_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_pricing_asian_matrix_scale(m : FinancepricingasianMatrix, s : Double) -> FinancepricingasianMatrix {
  let result = finance_pricing_asian_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_pricing_asian_matrix_multiply(a : FinancepricingasianMatrix, b : FinancepricingasianMatrix) -> FinancepricingasianMatrix {
  if a.cols != b.rows { return finance_pricing_asian_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_pricing_asian_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_pricing_asian_matrix_trace(m : FinancepricingasianMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_pricing_asian_matrix_det(m : FinancepricingasianMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_pricing_asian_matrix_norm(m : FinancepricingasianMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_pricing_asian_matrix_to_string(m : FinancepricingasianMatrix) -> String {
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

pub(all) struct FinancepricingasianVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_asian_make_vector(comps : Array[Double]) -> FinancepricingasianVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_asian_vector_zero(dim : Int) -> FinancepricingasianVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_pricing_asian_vector_add(a : FinancepricingasianVector, b : FinancepricingasianVector) -> FinancepricingasianVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_pricing_asian_vector_sub(a : FinancepricingasianVector, b : FinancepricingasianVector) -> FinancepricingasianVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_pricing_asian_vector_scale(v : FinancepricingasianVector, s : Double) -> FinancepricingasianVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_pricing_asian_vector_dot(a : FinancepricingasianVector, b : FinancepricingasianVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_pricing_asian_vector_norm(v : FinancepricingasianVector) -> Double { @_common.sqrt(finance_pricing_asian_vector_dot(v, v)) }

pub fn finance_pricing_asian_vector_normalize(v : FinancepricingasianVector) -> FinancepricingasianVector {
  let n = finance_pricing_asian_vector_norm(v)
  if n < 0.0000001 { v } else { finance_pricing_asian_vector_scale(v, 1.0 / n) }
}

pub fn finance_pricing_asian_vector_dist(a : FinancepricingasianVector, b : FinancepricingasianVector) -> Double {
  finance_pricing_asian_vector_norm(finance_pricing_asian_vector_sub(a, b))
}

pub fn finance_pricing_asian_vector_to_string(v : FinancepricingasianVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_pricing_asian_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn finance_pricing_asian_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = finance_pricing_asian_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_pricing_asian_std(data : Array[Double]) -> Double { @_common.sqrt(finance_pricing_asian_var(data)) }

pub fn finance_pricing_asian_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = finance_pricing_asian_mean(a); let mb = finance_pricing_asian_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn finance_pricing_asian_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = finance_pricing_asian_std(a); let sb = finance_pricing_asian_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { finance_pricing_asian_cov(a, b) / (sa * sb) }
}

pub fn finance_pricing_asian_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = finance_pricing_asian_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_pricing_asian_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn finance_pricing_asian_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_pricing_asian_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(finance_pricing_asian_mse(pred, labels))
}

pub fn finance_pricing_asian_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn finance_pricing_asian_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = finance_pricing_asian_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn finance_pricing_asian_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn finance_pricing_asian_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn finance_pricing_asian_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = finance_pricing_asian_precision(pred, labels, pos); let r = finance_pricing_asian_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn finance_pricing_asian_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn finance_pricing_asian_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = finance_pricing_asian_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn finance_pricing_asian_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn finance_pricing_asian_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn finance_pricing_asian_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = finance_pricing_asian_gcd(a, b)
    (a / g) * b
  }
}

pub fn finance_pricing_asian_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn finance_pricing_asian_fibonacci(n : Int) -> Int {
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

pub fn finance_pricing_asian_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = finance_pricing_asian_min(data); let mx = finance_pricing_asian_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn finance_pricing_asian_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = finance_pricing_asian_mean(data); let sd = finance_pricing_asian_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn finance_pricing_asian_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn finance_pricing_asian_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn finance_pricing_asian_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn finance_pricing_asian_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn finance_pricing_asian_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn finance_pricing_asian_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct FinancepricingasianFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_frame_make(size : Int) -> FinancepricingasianFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_frame_len(s : FinancepricingasianFrame) -> Int { s.size }

pub fn finance_pricing_asian_frame_get(s : FinancepricingasianFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_frame_set(s : FinancepricingasianFrame, i : Int, v : Double) -> FinancepricingasianFrame {
  let result = finance_pricing_asian_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_frame_sum(s : FinancepricingasianFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_asian_frame_mean(s : FinancepricingasianFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_asian_frame_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_asian_frame_scale(s : FinancepricingasianFrame, f : Double) -> FinancepricingasianFrame {
  let result = finance_pricing_asian_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_asian_frame_add(a : FinancepricingasianFrame, b : FinancepricingasianFrame) -> FinancepricingasianFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_asian_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_asian_frame_copy(s : FinancepricingasianFrame) -> FinancepricingasianFrame {
  let result = finance_pricing_asian_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_asian_frame_fill(s : FinancepricingasianFrame, v : Double) -> FinancepricingasianFrame {
  let result = finance_pricing_asian_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_frame_min(s : FinancepricingasianFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_frame_max(s : FinancepricingasianFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_frame_to_string(s : FinancepricingasianFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_table_make(size : Int) -> FinancepricingasianTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_table_len(s : FinancepricingasianTable) -> Int { s.size }

pub fn finance_pricing_asian_table_get(s : FinancepricingasianTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_table_set(s : FinancepricingasianTable, i : Int, v : Double) -> FinancepricingasianTable {
  let result = finance_pricing_asian_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_table_sum(s : FinancepricingasianTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_asian_table_mean(s : FinancepricingasianTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_asian_table_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_asian_table_scale(s : FinancepricingasianTable, f : Double) -> FinancepricingasianTable {
  let result = finance_pricing_asian_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_asian_table_add(a : FinancepricingasianTable, b : FinancepricingasianTable) -> FinancepricingasianTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_asian_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_asian_table_copy(s : FinancepricingasianTable) -> FinancepricingasianTable {
  let result = finance_pricing_asian_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_asian_table_fill(s : FinancepricingasianTable, v : Double) -> FinancepricingasianTable {
  let result = finance_pricing_asian_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_table_min(s : FinancepricingasianTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_table_max(s : FinancepricingasianTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_table_to_string(s : FinancepricingasianTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_graphn_make(size : Int) -> FinancepricingasianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_graphn_len(s : FinancepricingasianGraphN) -> Int { s.size }

pub fn finance_pricing_asian_graphn_get(s : FinancepricingasianGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_graphn_set(s : FinancepricingasianGraphN, i : Int, v : Double) -> FinancepricingasianGraphN {
  let result = finance_pricing_asian_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_graphn_sum(s : FinancepricingasianGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_asian_graphn_mean(s : FinancepricingasianGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_asian_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_asian_graphn_scale(s : FinancepricingasianGraphN, f : Double) -> FinancepricingasianGraphN {
  let result = finance_pricing_asian_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_asian_graphn_add(a : FinancepricingasianGraphN, b : FinancepricingasianGraphN) -> FinancepricingasianGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_asian_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_asian_graphn_copy(s : FinancepricingasianGraphN) -> FinancepricingasianGraphN {
  let result = finance_pricing_asian_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_asian_graphn_fill(s : FinancepricingasianGraphN, v : Double) -> FinancepricingasianGraphN {
  let result = finance_pricing_asian_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_graphn_min(s : FinancepricingasianGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_graphn_max(s : FinancepricingasianGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_graphn_to_string(s : FinancepricingasianGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_node_make(size : Int) -> FinancepricingasianNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_node_len(s : FinancepricingasianNode) -> Int { s.size }

pub fn finance_pricing_asian_node_get(s : FinancepricingasianNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_node_set(s : FinancepricingasianNode, i : Int, v : Double) -> FinancepricingasianNode {
  let result = finance_pricing_asian_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_node_sum(s : FinancepricingasianNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_asian_node_mean(s : FinancepricingasianNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_asian_node_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_asian_node_scale(s : FinancepricingasianNode, f : Double) -> FinancepricingasianNode {
  let result = finance_pricing_asian_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_asian_node_add(a : FinancepricingasianNode, b : FinancepricingasianNode) -> FinancepricingasianNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_asian_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_asian_node_copy(s : FinancepricingasianNode) -> FinancepricingasianNode {
  let result = finance_pricing_asian_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_asian_node_fill(s : FinancepricingasianNode, v : Double) -> FinancepricingasianNode {
  let result = finance_pricing_asian_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_node_min(s : FinancepricingasianNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_node_max(s : FinancepricingasianNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_node_to_string(s : FinancepricingasianNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_edge_make(size : Int) -> FinancepricingasianEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_edge_len(s : FinancepricingasianEdge) -> Int { s.size }

pub fn finance_pricing_asian_edge_get(s : FinancepricingasianEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_edge_set(s : FinancepricingasianEdge, i : Int, v : Double) -> FinancepricingasianEdge {
  let result = finance_pricing_asian_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_edge_sum(s : FinancepricingasianEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_asian_edge_mean(s : FinancepricingasianEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_asian_edge_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_asian_edge_scale(s : FinancepricingasianEdge, f : Double) -> FinancepricingasianEdge {
  let result = finance_pricing_asian_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_asian_edge_add(a : FinancepricingasianEdge, b : FinancepricingasianEdge) -> FinancepricingasianEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_asian_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_asian_edge_copy(s : FinancepricingasianEdge) -> FinancepricingasianEdge {
  let result = finance_pricing_asian_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_asian_edge_fill(s : FinancepricingasianEdge, v : Double) -> FinancepricingasianEdge {
  let result = finance_pricing_asian_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_edge_min(s : FinancepricingasianEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_edge_max(s : FinancepricingasianEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_edge_to_string(s : FinancepricingasianEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_path_make(size : Int) -> FinancepricingasianPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_path_len(s : FinancepricingasianPath) -> Int { s.size }

pub fn finance_pricing_asian_path_get(s : FinancepricingasianPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_path_set(s : FinancepricingasianPath, i : Int, v : Double) -> FinancepricingasianPath {
  let result = finance_pricing_asian_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_path_sum(s : FinancepricingasianPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_asian_path_mean(s : FinancepricingasianPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_asian_path_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_asian_path_scale(s : FinancepricingasianPath, f : Double) -> FinancepricingasianPath {
  let result = finance_pricing_asian_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_asian_path_add(a : FinancepricingasianPath, b : FinancepricingasianPath) -> FinancepricingasianPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_asian_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_asian_path_copy(s : FinancepricingasianPath) -> FinancepricingasianPath {
  let result = finance_pricing_asian_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_asian_path_fill(s : FinancepricingasianPath, v : Double) -> FinancepricingasianPath {
  let result = finance_pricing_asian_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_path_min(s : FinancepricingasianPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_path_max(s : FinancepricingasianPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_path_to_string(s : FinancepricingasianPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_cluster_make(size : Int) -> FinancepricingasianCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_cluster_len(s : FinancepricingasianCluster) -> Int { s.size }

pub fn finance_pricing_asian_cluster_get(s : FinancepricingasianCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_cluster_set(s : FinancepricingasianCluster, i : Int, v : Double) -> FinancepricingasianCluster {
  let result = finance_pricing_asian_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_cluster_sum(s : FinancepricingasianCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_asian_cluster_mean(s : FinancepricingasianCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_asian_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_asian_cluster_scale(s : FinancepricingasianCluster, f : Double) -> FinancepricingasianCluster {
  let result = finance_pricing_asian_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_asian_cluster_add(a : FinancepricingasianCluster, b : FinancepricingasianCluster) -> FinancepricingasianCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_asian_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_asian_cluster_copy(s : FinancepricingasianCluster) -> FinancepricingasianCluster {
  let result = finance_pricing_asian_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_asian_cluster_fill(s : FinancepricingasianCluster, v : Double) -> FinancepricingasianCluster {
  let result = finance_pricing_asian_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_cluster_min(s : FinancepricingasianCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_cluster_max(s : FinancepricingasianCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_cluster_to_string(s : FinancepricingasianCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_model_make(size : Int) -> FinancepricingasianModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_model_len(s : FinancepricingasianModel) -> Int { s.size }

pub fn finance_pricing_asian_model_get(s : FinancepricingasianModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_model_set(s : FinancepricingasianModel, i : Int, v : Double) -> FinancepricingasianModel {
  let result = finance_pricing_asian_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_model_sum(s : FinancepricingasianModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_asian_model_mean(s : FinancepricingasianModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_asian_model_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_asian_model_scale(s : FinancepricingasianModel, f : Double) -> FinancepricingasianModel {
  let result = finance_pricing_asian_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_asian_model_add(a : FinancepricingasianModel, b : FinancepricingasianModel) -> FinancepricingasianModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_asian_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_asian_model_copy(s : FinancepricingasianModel) -> FinancepricingasianModel {
  let result = finance_pricing_asian_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_asian_model_fill(s : FinancepricingasianModel, v : Double) -> FinancepricingasianModel {
  let result = finance_pricing_asian_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_model_min(s : FinancepricingasianModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_model_max(s : FinancepricingasianModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_model_to_string(s : FinancepricingasianModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_layer_make(size : Int) -> FinancepricingasianLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_layer_len(s : FinancepricingasianLayer) -> Int { s.size }

pub fn finance_pricing_asian_layer_get(s : FinancepricingasianLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_layer_set(s : FinancepricingasianLayer, i : Int, v : Double) -> FinancepricingasianLayer {
  let result = finance_pricing_asian_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_layer_sum(s : FinancepricingasianLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_asian_layer_mean(s : FinancepricingasianLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_asian_layer_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_asian_layer_scale(s : FinancepricingasianLayer, f : Double) -> FinancepricingasianLayer {
  let result = finance_pricing_asian_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_asian_layer_add(a : FinancepricingasianLayer, b : FinancepricingasianLayer) -> FinancepricingasianLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_asian_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_asian_layer_copy(s : FinancepricingasianLayer) -> FinancepricingasianLayer {
  let result = finance_pricing_asian_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_asian_layer_fill(s : FinancepricingasianLayer, v : Double) -> FinancepricingasianLayer {
  let result = finance_pricing_asian_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_layer_min(s : FinancepricingasianLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_layer_max(s : FinancepricingasianLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_layer_to_string(s : FinancepricingasianLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_buffer_make(size : Int) -> FinancepricingasianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_buffer_len(s : FinancepricingasianBuffer) -> Int { s.size }

pub fn finance_pricing_asian_buffer_get(s : FinancepricingasianBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_buffer_set(s : FinancepricingasianBuffer, i : Int, v : Double) -> FinancepricingasianBuffer {
  let result = finance_pricing_asian_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_buffer_sum(s : FinancepricingasianBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_asian_buffer_mean(s : FinancepricingasianBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_asian_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_asian_buffer_scale(s : FinancepricingasianBuffer, f : Double) -> FinancepricingasianBuffer {
  let result = finance_pricing_asian_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_asian_buffer_add(a : FinancepricingasianBuffer, b : FinancepricingasianBuffer) -> FinancepricingasianBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_asian_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_asian_buffer_copy(s : FinancepricingasianBuffer) -> FinancepricingasianBuffer {
  let result = finance_pricing_asian_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_asian_buffer_fill(s : FinancepricingasianBuffer, v : Double) -> FinancepricingasianBuffer {
  let result = finance_pricing_asian_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_buffer_min(s : FinancepricingasianBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_buffer_max(s : FinancepricingasianBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_buffer_to_string(s : FinancepricingasianBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_cursor_make(size : Int) -> FinancepricingasianCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_cursor_len(s : FinancepricingasianCursor) -> Int { s.size }

pub fn finance_pricing_asian_cursor_get(s : FinancepricingasianCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_cursor_set(s : FinancepricingasianCursor, i : Int, v : Double) -> FinancepricingasianCursor {
  let result = finance_pricing_asian_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_cursor_sum(s : FinancepricingasianCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_asian_cursor_mean(s : FinancepricingasianCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_asian_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_asian_cursor_scale(s : FinancepricingasianCursor, f : Double) -> FinancepricingasianCursor {
  let result = finance_pricing_asian_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_asian_cursor_add(a : FinancepricingasianCursor, b : FinancepricingasianCursor) -> FinancepricingasianCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_asian_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_asian_cursor_copy(s : FinancepricingasianCursor) -> FinancepricingasianCursor {
  let result = finance_pricing_asian_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_asian_cursor_fill(s : FinancepricingasianCursor, v : Double) -> FinancepricingasianCursor {
  let result = finance_pricing_asian_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_cursor_min(s : FinancepricingasianCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_cursor_max(s : FinancepricingasianCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_cursor_to_string(s : FinancepricingasianCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_view_make(size : Int) -> FinancepricingasianView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_view_len(s : FinancepricingasianView) -> Int { s.size }

pub fn finance_pricing_asian_view_get(s : FinancepricingasianView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_view_set(s : FinancepricingasianView, i : Int, v : Double) -> FinancepricingasianView {
  let result = finance_pricing_asian_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_view_sum(s : FinancepricingasianView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_asian_view_mean(s : FinancepricingasianView) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_asian_view_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_asian_view_scale(s : FinancepricingasianView, f : Double) -> FinancepricingasianView {
  let result = finance_pricing_asian_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_asian_view_add(a : FinancepricingasianView, b : FinancepricingasianView) -> FinancepricingasianView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_asian_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_asian_view_copy(s : FinancepricingasianView) -> FinancepricingasianView {
  let result = finance_pricing_asian_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_asian_view_fill(s : FinancepricingasianView, v : Double) -> FinancepricingasianView {
  let result = finance_pricing_asian_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_view_min(s : FinancepricingasianView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_view_max(s : FinancepricingasianView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_view_to_string(s : FinancepricingasianView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_range_make(size : Int) -> FinancepricingasianRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_range_len(s : FinancepricingasianRange) -> Int { s.size }

pub fn finance_pricing_asian_range_get(s : FinancepricingasianRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_range_set(s : FinancepricingasianRange, i : Int, v : Double) -> FinancepricingasianRange {
  let result = finance_pricing_asian_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_range_sum(s : FinancepricingasianRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_asian_range_mean(s : FinancepricingasianRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_asian_range_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_asian_range_scale(s : FinancepricingasianRange, f : Double) -> FinancepricingasianRange {
  let result = finance_pricing_asian_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_asian_range_add(a : FinancepricingasianRange, b : FinancepricingasianRange) -> FinancepricingasianRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_asian_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_asian_range_copy(s : FinancepricingasianRange) -> FinancepricingasianRange {
  let result = finance_pricing_asian_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_asian_range_fill(s : FinancepricingasianRange, v : Double) -> FinancepricingasianRange {
  let result = finance_pricing_asian_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_range_min(s : FinancepricingasianRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_range_max(s : FinancepricingasianRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_range_to_string(s : FinancepricingasianRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_slice_make(size : Int) -> FinancepricingasianSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_slice_len(s : FinancepricingasianSlice) -> Int { s.size }

pub fn finance_pricing_asian_slice_get(s : FinancepricingasianSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_slice_set(s : FinancepricingasianSlice, i : Int, v : Double) -> FinancepricingasianSlice {
  let result = finance_pricing_asian_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_slice_sum(s : FinancepricingasianSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_asian_slice_mean(s : FinancepricingasianSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_asian_slice_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_asian_slice_scale(s : FinancepricingasianSlice, f : Double) -> FinancepricingasianSlice {
  let result = finance_pricing_asian_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_asian_slice_add(a : FinancepricingasianSlice, b : FinancepricingasianSlice) -> FinancepricingasianSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_asian_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_asian_slice_copy(s : FinancepricingasianSlice) -> FinancepricingasianSlice {
  let result = finance_pricing_asian_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_asian_slice_fill(s : FinancepricingasianSlice, v : Double) -> FinancepricingasianSlice {
  let result = finance_pricing_asian_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_asian_slice_min(s : FinancepricingasianSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_slice_max(s : FinancepricingasianSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_asian_slice_to_string(s : FinancepricingasianSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

