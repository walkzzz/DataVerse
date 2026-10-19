///===
/// extcore/finance_pricing_american

pub(all) struct FinancepricingamericanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_american_make_point(x : Double, y : Double) -> FinancepricingamericanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_american_make_point3(x : Double, y : Double, z : Double) -> FinancepricingamericanPoint {
  { x, y, z, label: 0 }
}

pub fn finance_pricing_american_point_x(pt : FinancepricingamericanPoint) -> Double { pt.x }

pub fn finance_pricing_american_point_y(pt : FinancepricingamericanPoint) -> Double { pt.y }

pub fn finance_pricing_american_point_z(pt : FinancepricingamericanPoint) -> Double { pt.z }

pub fn finance_pricing_american_point_label(pt : FinancepricingamericanPoint) -> Int { pt.label }

pub fn finance_pricing_american_point_dist(a : FinancepricingamericanPoint, b : FinancepricingamericanPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_pricing_american_point_add(a : FinancepricingamericanPoint, b : FinancepricingamericanPoint) -> FinancepricingamericanPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_pricing_american_point_sub(a : FinancepricingamericanPoint, b : FinancepricingamericanPoint) -> FinancepricingamericanPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_pricing_american_point_scale(pt : FinancepricingamericanPoint, s : Double) -> FinancepricingamericanPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_pricing_american_point_dot(a : FinancepricingamericanPoint, b : FinancepricingamericanPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_pricing_american_point_cross(a : FinancepricingamericanPoint, b : FinancepricingamericanPoint) -> FinancepricingamericanPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_pricing_american_point_norm(pt : FinancepricingamericanPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_pricing_american_point_normalize(pt : FinancepricingamericanPoint) -> FinancepricingamericanPoint {
  let n = finance_pricing_american_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_pricing_american_point_scale(pt, 1.0 / n) }
}

pub fn finance_pricing_american_point_negate(pt : FinancepricingamericanPoint) -> FinancepricingamericanPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_pricing_american_point_mid(a : FinancepricingamericanPoint, b : FinancepricingamericanPoint) -> FinancepricingamericanPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_pricing_american_point_lerp(a : FinancepricingamericanPoint, b : FinancepricingamericanPoint, t : Double) -> FinancepricingamericanPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_pricing_american_point_to_string(pt : FinancepricingamericanPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancepricingamericanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_american_make_series(vals : Array[Double], name : String) -> FinancepricingamericanSeries {
  { vals, name, meta: 0 }
}

pub fn finance_pricing_american_series_len(s : FinancepricingamericanSeries) -> Int { s.vals.length() }

pub fn finance_pricing_american_series_sum(s : FinancepricingamericanSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_pricing_american_series_mean(s : FinancepricingamericanSeries) -> Double {
  let n = finance_pricing_american_series_len(s)
  if n == 0 { 0.0 } else { finance_pricing_american_series_sum(s) / n.to_double() }
}

pub fn finance_pricing_american_series_min(s : FinancepricingamericanSeries) -> Double {
  let n = finance_pricing_american_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_pricing_american_series_max(s : FinancepricingamericanSeries) -> Double {
  let n = finance_pricing_american_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_pricing_american_series_range(s : FinancepricingamericanSeries) -> Double {
  finance_pricing_american_series_max(s) - finance_pricing_american_series_min(s)
}

pub fn finance_pricing_american_series_var(s : FinancepricingamericanSeries) -> Double {
  let n = finance_pricing_american_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_pricing_american_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_pricing_american_series_std(s : FinancepricingamericanSeries) -> Double { @_common.sqrt(finance_pricing_american_series_var(s)) }

pub fn finance_pricing_american_series_median(s : FinancepricingamericanSeries) -> Double {
  let n = finance_pricing_american_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_pricing_american_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_pricing_american_series_scale(s : FinancepricingamericanSeries, f : Double) -> FinancepricingamericanSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_pricing_american_series_add(a : FinancepricingamericanSeries, b : FinancepricingamericanSeries) -> FinancepricingamericanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_pricing_american_series_sub(a : FinancepricingamericanSeries, b : FinancepricingamericanSeries) -> FinancepricingamericanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_pricing_american_series_normalize(s : FinancepricingamericanSeries) -> FinancepricingamericanSeries {
  let mn = finance_pricing_american_series_min(s)
  let mx = finance_pricing_american_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_pricing_american_series_cumsum(s : FinancepricingamericanSeries) -> FinancepricingamericanSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_pricing_american_series_to_string(s : FinancepricingamericanSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingamericanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_american_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingamericanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_american_matrix_identity(n : Int) -> FinancepricingamericanMatrix {
  let m = finance_pricing_american_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_pricing_american_matrix_get(m : FinancepricingamericanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_pricing_american_matrix_transpose(m : FinancepricingamericanMatrix) -> FinancepricingamericanMatrix {
  let result = finance_pricing_american_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_pricing_american_matrix_add(a : FinancepricingamericanMatrix, b : FinancepricingamericanMatrix) -> FinancepricingamericanMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_pricing_american_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_pricing_american_matrix_scale(m : FinancepricingamericanMatrix, s : Double) -> FinancepricingamericanMatrix {
  let result = finance_pricing_american_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_pricing_american_matrix_multiply(a : FinancepricingamericanMatrix, b : FinancepricingamericanMatrix) -> FinancepricingamericanMatrix {
  if a.cols != b.rows { return finance_pricing_american_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_pricing_american_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_pricing_american_matrix_trace(m : FinancepricingamericanMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_pricing_american_matrix_det(m : FinancepricingamericanMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_pricing_american_matrix_norm(m : FinancepricingamericanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_pricing_american_matrix_to_string(m : FinancepricingamericanMatrix) -> String {
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

pub(all) struct FinancepricingamericanVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_american_make_vector(comps : Array[Double]) -> FinancepricingamericanVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_american_vector_zero(dim : Int) -> FinancepricingamericanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_pricing_american_vector_add(a : FinancepricingamericanVector, b : FinancepricingamericanVector) -> FinancepricingamericanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_pricing_american_vector_sub(a : FinancepricingamericanVector, b : FinancepricingamericanVector) -> FinancepricingamericanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_pricing_american_vector_scale(v : FinancepricingamericanVector, s : Double) -> FinancepricingamericanVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_pricing_american_vector_dot(a : FinancepricingamericanVector, b : FinancepricingamericanVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_pricing_american_vector_norm(v : FinancepricingamericanVector) -> Double { @_common.sqrt(finance_pricing_american_vector_dot(v, v)) }

pub fn finance_pricing_american_vector_normalize(v : FinancepricingamericanVector) -> FinancepricingamericanVector {
  let n = finance_pricing_american_vector_norm(v)
  if n < 0.0000001 { v } else { finance_pricing_american_vector_scale(v, 1.0 / n) }
}

pub fn finance_pricing_american_vector_dist(a : FinancepricingamericanVector, b : FinancepricingamericanVector) -> Double {
  finance_pricing_american_vector_norm(finance_pricing_american_vector_sub(a, b))
}

pub fn finance_pricing_american_vector_to_string(v : FinancepricingamericanVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_pricing_american_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn finance_pricing_american_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = finance_pricing_american_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_pricing_american_std(data : Array[Double]) -> Double { @_common.sqrt(finance_pricing_american_var(data)) }

pub fn finance_pricing_american_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = finance_pricing_american_mean(a); let mb = finance_pricing_american_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn finance_pricing_american_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = finance_pricing_american_std(a); let sb = finance_pricing_american_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { finance_pricing_american_cov(a, b) / (sa * sb) }
}

pub fn finance_pricing_american_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = finance_pricing_american_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_pricing_american_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn finance_pricing_american_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_pricing_american_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(finance_pricing_american_mse(pred, labels))
}

pub fn finance_pricing_american_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn finance_pricing_american_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = finance_pricing_american_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn finance_pricing_american_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn finance_pricing_american_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn finance_pricing_american_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = finance_pricing_american_precision(pred, labels, pos); let r = finance_pricing_american_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn finance_pricing_american_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn finance_pricing_american_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = finance_pricing_american_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn finance_pricing_american_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn finance_pricing_american_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn finance_pricing_american_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = finance_pricing_american_gcd(a, b)
    (a / g) * b
  }
}

pub fn finance_pricing_american_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn finance_pricing_american_fibonacci(n : Int) -> Int {
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

pub fn finance_pricing_american_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = finance_pricing_american_min(data); let mx = finance_pricing_american_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn finance_pricing_american_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = finance_pricing_american_mean(data); let sd = finance_pricing_american_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn finance_pricing_american_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn finance_pricing_american_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn finance_pricing_american_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn finance_pricing_american_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn finance_pricing_american_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn finance_pricing_american_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct FinancepricingamericanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_frame_make(size : Int) -> FinancepricingamericanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_frame_len(s : FinancepricingamericanFrame) -> Int { s.size }

pub fn finance_pricing_american_frame_get(s : FinancepricingamericanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_frame_set(s : FinancepricingamericanFrame, i : Int, v : Double) -> FinancepricingamericanFrame {
  let result = finance_pricing_american_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_frame_sum(s : FinancepricingamericanFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_american_frame_mean(s : FinancepricingamericanFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_american_frame_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_american_frame_scale(s : FinancepricingamericanFrame, f : Double) -> FinancepricingamericanFrame {
  let result = finance_pricing_american_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_american_frame_add(a : FinancepricingamericanFrame, b : FinancepricingamericanFrame) -> FinancepricingamericanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_american_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_american_frame_copy(s : FinancepricingamericanFrame) -> FinancepricingamericanFrame {
  let result = finance_pricing_american_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_american_frame_fill(s : FinancepricingamericanFrame, v : Double) -> FinancepricingamericanFrame {
  let result = finance_pricing_american_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_frame_min(s : FinancepricingamericanFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_frame_max(s : FinancepricingamericanFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_frame_to_string(s : FinancepricingamericanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_table_make(size : Int) -> FinancepricingamericanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_table_len(s : FinancepricingamericanTable) -> Int { s.size }

pub fn finance_pricing_american_table_get(s : FinancepricingamericanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_table_set(s : FinancepricingamericanTable, i : Int, v : Double) -> FinancepricingamericanTable {
  let result = finance_pricing_american_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_table_sum(s : FinancepricingamericanTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_american_table_mean(s : FinancepricingamericanTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_american_table_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_american_table_scale(s : FinancepricingamericanTable, f : Double) -> FinancepricingamericanTable {
  let result = finance_pricing_american_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_american_table_add(a : FinancepricingamericanTable, b : FinancepricingamericanTable) -> FinancepricingamericanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_american_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_american_table_copy(s : FinancepricingamericanTable) -> FinancepricingamericanTable {
  let result = finance_pricing_american_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_american_table_fill(s : FinancepricingamericanTable, v : Double) -> FinancepricingamericanTable {
  let result = finance_pricing_american_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_table_min(s : FinancepricingamericanTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_table_max(s : FinancepricingamericanTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_table_to_string(s : FinancepricingamericanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_graphn_make(size : Int) -> FinancepricingamericanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_graphn_len(s : FinancepricingamericanGraphN) -> Int { s.size }

pub fn finance_pricing_american_graphn_get(s : FinancepricingamericanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_graphn_set(s : FinancepricingamericanGraphN, i : Int, v : Double) -> FinancepricingamericanGraphN {
  let result = finance_pricing_american_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_graphn_sum(s : FinancepricingamericanGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_american_graphn_mean(s : FinancepricingamericanGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_american_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_american_graphn_scale(s : FinancepricingamericanGraphN, f : Double) -> FinancepricingamericanGraphN {
  let result = finance_pricing_american_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_american_graphn_add(a : FinancepricingamericanGraphN, b : FinancepricingamericanGraphN) -> FinancepricingamericanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_american_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_american_graphn_copy(s : FinancepricingamericanGraphN) -> FinancepricingamericanGraphN {
  let result = finance_pricing_american_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_american_graphn_fill(s : FinancepricingamericanGraphN, v : Double) -> FinancepricingamericanGraphN {
  let result = finance_pricing_american_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_graphn_min(s : FinancepricingamericanGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_graphn_max(s : FinancepricingamericanGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_graphn_to_string(s : FinancepricingamericanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_node_make(size : Int) -> FinancepricingamericanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_node_len(s : FinancepricingamericanNode) -> Int { s.size }

pub fn finance_pricing_american_node_get(s : FinancepricingamericanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_node_set(s : FinancepricingamericanNode, i : Int, v : Double) -> FinancepricingamericanNode {
  let result = finance_pricing_american_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_node_sum(s : FinancepricingamericanNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_american_node_mean(s : FinancepricingamericanNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_american_node_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_american_node_scale(s : FinancepricingamericanNode, f : Double) -> FinancepricingamericanNode {
  let result = finance_pricing_american_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_american_node_add(a : FinancepricingamericanNode, b : FinancepricingamericanNode) -> FinancepricingamericanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_american_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_american_node_copy(s : FinancepricingamericanNode) -> FinancepricingamericanNode {
  let result = finance_pricing_american_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_american_node_fill(s : FinancepricingamericanNode, v : Double) -> FinancepricingamericanNode {
  let result = finance_pricing_american_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_node_min(s : FinancepricingamericanNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_node_max(s : FinancepricingamericanNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_node_to_string(s : FinancepricingamericanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_edge_make(size : Int) -> FinancepricingamericanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_edge_len(s : FinancepricingamericanEdge) -> Int { s.size }

pub fn finance_pricing_american_edge_get(s : FinancepricingamericanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_edge_set(s : FinancepricingamericanEdge, i : Int, v : Double) -> FinancepricingamericanEdge {
  let result = finance_pricing_american_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_edge_sum(s : FinancepricingamericanEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_american_edge_mean(s : FinancepricingamericanEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_american_edge_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_american_edge_scale(s : FinancepricingamericanEdge, f : Double) -> FinancepricingamericanEdge {
  let result = finance_pricing_american_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_american_edge_add(a : FinancepricingamericanEdge, b : FinancepricingamericanEdge) -> FinancepricingamericanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_american_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_american_edge_copy(s : FinancepricingamericanEdge) -> FinancepricingamericanEdge {
  let result = finance_pricing_american_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_american_edge_fill(s : FinancepricingamericanEdge, v : Double) -> FinancepricingamericanEdge {
  let result = finance_pricing_american_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_edge_min(s : FinancepricingamericanEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_edge_max(s : FinancepricingamericanEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_edge_to_string(s : FinancepricingamericanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_path_make(size : Int) -> FinancepricingamericanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_path_len(s : FinancepricingamericanPath) -> Int { s.size }

pub fn finance_pricing_american_path_get(s : FinancepricingamericanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_path_set(s : FinancepricingamericanPath, i : Int, v : Double) -> FinancepricingamericanPath {
  let result = finance_pricing_american_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_path_sum(s : FinancepricingamericanPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_american_path_mean(s : FinancepricingamericanPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_american_path_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_american_path_scale(s : FinancepricingamericanPath, f : Double) -> FinancepricingamericanPath {
  let result = finance_pricing_american_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_american_path_add(a : FinancepricingamericanPath, b : FinancepricingamericanPath) -> FinancepricingamericanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_american_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_american_path_copy(s : FinancepricingamericanPath) -> FinancepricingamericanPath {
  let result = finance_pricing_american_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_american_path_fill(s : FinancepricingamericanPath, v : Double) -> FinancepricingamericanPath {
  let result = finance_pricing_american_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_path_min(s : FinancepricingamericanPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_path_max(s : FinancepricingamericanPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_path_to_string(s : FinancepricingamericanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_cluster_make(size : Int) -> FinancepricingamericanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_cluster_len(s : FinancepricingamericanCluster) -> Int { s.size }

pub fn finance_pricing_american_cluster_get(s : FinancepricingamericanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_cluster_set(s : FinancepricingamericanCluster, i : Int, v : Double) -> FinancepricingamericanCluster {
  let result = finance_pricing_american_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_cluster_sum(s : FinancepricingamericanCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_american_cluster_mean(s : FinancepricingamericanCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_american_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_american_cluster_scale(s : FinancepricingamericanCluster, f : Double) -> FinancepricingamericanCluster {
  let result = finance_pricing_american_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_american_cluster_add(a : FinancepricingamericanCluster, b : FinancepricingamericanCluster) -> FinancepricingamericanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_american_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_american_cluster_copy(s : FinancepricingamericanCluster) -> FinancepricingamericanCluster {
  let result = finance_pricing_american_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_american_cluster_fill(s : FinancepricingamericanCluster, v : Double) -> FinancepricingamericanCluster {
  let result = finance_pricing_american_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_cluster_min(s : FinancepricingamericanCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_cluster_max(s : FinancepricingamericanCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_cluster_to_string(s : FinancepricingamericanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_model_make(size : Int) -> FinancepricingamericanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_model_len(s : FinancepricingamericanModel) -> Int { s.size }

pub fn finance_pricing_american_model_get(s : FinancepricingamericanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_model_set(s : FinancepricingamericanModel, i : Int, v : Double) -> FinancepricingamericanModel {
  let result = finance_pricing_american_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_model_sum(s : FinancepricingamericanModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_american_model_mean(s : FinancepricingamericanModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_american_model_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_american_model_scale(s : FinancepricingamericanModel, f : Double) -> FinancepricingamericanModel {
  let result = finance_pricing_american_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_american_model_add(a : FinancepricingamericanModel, b : FinancepricingamericanModel) -> FinancepricingamericanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_american_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_american_model_copy(s : FinancepricingamericanModel) -> FinancepricingamericanModel {
  let result = finance_pricing_american_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_american_model_fill(s : FinancepricingamericanModel, v : Double) -> FinancepricingamericanModel {
  let result = finance_pricing_american_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_model_min(s : FinancepricingamericanModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_model_max(s : FinancepricingamericanModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_model_to_string(s : FinancepricingamericanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_layer_make(size : Int) -> FinancepricingamericanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_layer_len(s : FinancepricingamericanLayer) -> Int { s.size }

pub fn finance_pricing_american_layer_get(s : FinancepricingamericanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_layer_set(s : FinancepricingamericanLayer, i : Int, v : Double) -> FinancepricingamericanLayer {
  let result = finance_pricing_american_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_layer_sum(s : FinancepricingamericanLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_american_layer_mean(s : FinancepricingamericanLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_american_layer_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_american_layer_scale(s : FinancepricingamericanLayer, f : Double) -> FinancepricingamericanLayer {
  let result = finance_pricing_american_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_american_layer_add(a : FinancepricingamericanLayer, b : FinancepricingamericanLayer) -> FinancepricingamericanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_american_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_american_layer_copy(s : FinancepricingamericanLayer) -> FinancepricingamericanLayer {
  let result = finance_pricing_american_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_american_layer_fill(s : FinancepricingamericanLayer, v : Double) -> FinancepricingamericanLayer {
  let result = finance_pricing_american_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_layer_min(s : FinancepricingamericanLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_layer_max(s : FinancepricingamericanLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_layer_to_string(s : FinancepricingamericanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_buffer_make(size : Int) -> FinancepricingamericanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_buffer_len(s : FinancepricingamericanBuffer) -> Int { s.size }

pub fn finance_pricing_american_buffer_get(s : FinancepricingamericanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_buffer_set(s : FinancepricingamericanBuffer, i : Int, v : Double) -> FinancepricingamericanBuffer {
  let result = finance_pricing_american_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_buffer_sum(s : FinancepricingamericanBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_american_buffer_mean(s : FinancepricingamericanBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_american_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_american_buffer_scale(s : FinancepricingamericanBuffer, f : Double) -> FinancepricingamericanBuffer {
  let result = finance_pricing_american_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_american_buffer_add(a : FinancepricingamericanBuffer, b : FinancepricingamericanBuffer) -> FinancepricingamericanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_american_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_american_buffer_copy(s : FinancepricingamericanBuffer) -> FinancepricingamericanBuffer {
  let result = finance_pricing_american_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_american_buffer_fill(s : FinancepricingamericanBuffer, v : Double) -> FinancepricingamericanBuffer {
  let result = finance_pricing_american_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_buffer_min(s : FinancepricingamericanBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_buffer_max(s : FinancepricingamericanBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_buffer_to_string(s : FinancepricingamericanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_cursor_make(size : Int) -> FinancepricingamericanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_cursor_len(s : FinancepricingamericanCursor) -> Int { s.size }

pub fn finance_pricing_american_cursor_get(s : FinancepricingamericanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_cursor_set(s : FinancepricingamericanCursor, i : Int, v : Double) -> FinancepricingamericanCursor {
  let result = finance_pricing_american_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_cursor_sum(s : FinancepricingamericanCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_american_cursor_mean(s : FinancepricingamericanCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_american_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_american_cursor_scale(s : FinancepricingamericanCursor, f : Double) -> FinancepricingamericanCursor {
  let result = finance_pricing_american_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_american_cursor_add(a : FinancepricingamericanCursor, b : FinancepricingamericanCursor) -> FinancepricingamericanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_american_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_american_cursor_copy(s : FinancepricingamericanCursor) -> FinancepricingamericanCursor {
  let result = finance_pricing_american_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_american_cursor_fill(s : FinancepricingamericanCursor, v : Double) -> FinancepricingamericanCursor {
  let result = finance_pricing_american_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_cursor_min(s : FinancepricingamericanCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_cursor_max(s : FinancepricingamericanCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_cursor_to_string(s : FinancepricingamericanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_view_make(size : Int) -> FinancepricingamericanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_view_len(s : FinancepricingamericanView) -> Int { s.size }

pub fn finance_pricing_american_view_get(s : FinancepricingamericanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_view_set(s : FinancepricingamericanView, i : Int, v : Double) -> FinancepricingamericanView {
  let result = finance_pricing_american_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_view_sum(s : FinancepricingamericanView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_american_view_mean(s : FinancepricingamericanView) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_american_view_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_american_view_scale(s : FinancepricingamericanView, f : Double) -> FinancepricingamericanView {
  let result = finance_pricing_american_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_american_view_add(a : FinancepricingamericanView, b : FinancepricingamericanView) -> FinancepricingamericanView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_american_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_american_view_copy(s : FinancepricingamericanView) -> FinancepricingamericanView {
  let result = finance_pricing_american_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_american_view_fill(s : FinancepricingamericanView, v : Double) -> FinancepricingamericanView {
  let result = finance_pricing_american_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_view_min(s : FinancepricingamericanView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_view_max(s : FinancepricingamericanView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_view_to_string(s : FinancepricingamericanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_range_make(size : Int) -> FinancepricingamericanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_range_len(s : FinancepricingamericanRange) -> Int { s.size }

pub fn finance_pricing_american_range_get(s : FinancepricingamericanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_range_set(s : FinancepricingamericanRange, i : Int, v : Double) -> FinancepricingamericanRange {
  let result = finance_pricing_american_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_range_sum(s : FinancepricingamericanRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_american_range_mean(s : FinancepricingamericanRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_american_range_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_american_range_scale(s : FinancepricingamericanRange, f : Double) -> FinancepricingamericanRange {
  let result = finance_pricing_american_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_american_range_add(a : FinancepricingamericanRange, b : FinancepricingamericanRange) -> FinancepricingamericanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_american_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_american_range_copy(s : FinancepricingamericanRange) -> FinancepricingamericanRange {
  let result = finance_pricing_american_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_american_range_fill(s : FinancepricingamericanRange, v : Double) -> FinancepricingamericanRange {
  let result = finance_pricing_american_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_range_min(s : FinancepricingamericanRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_range_max(s : FinancepricingamericanRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_range_to_string(s : FinancepricingamericanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_slice_make(size : Int) -> FinancepricingamericanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_slice_len(s : FinancepricingamericanSlice) -> Int { s.size }

pub fn finance_pricing_american_slice_get(s : FinancepricingamericanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_slice_set(s : FinancepricingamericanSlice, i : Int, v : Double) -> FinancepricingamericanSlice {
  let result = finance_pricing_american_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_slice_sum(s : FinancepricingamericanSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_american_slice_mean(s : FinancepricingamericanSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_american_slice_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_american_slice_scale(s : FinancepricingamericanSlice, f : Double) -> FinancepricingamericanSlice {
  let result = finance_pricing_american_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_american_slice_add(a : FinancepricingamericanSlice, b : FinancepricingamericanSlice) -> FinancepricingamericanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_american_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_american_slice_copy(s : FinancepricingamericanSlice) -> FinancepricingamericanSlice {
  let result = finance_pricing_american_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_american_slice_fill(s : FinancepricingamericanSlice, v : Double) -> FinancepricingamericanSlice {
  let result = finance_pricing_american_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_american_slice_min(s : FinancepricingamericanSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_slice_max(s : FinancepricingamericanSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_american_slice_to_string(s : FinancepricingamericanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

