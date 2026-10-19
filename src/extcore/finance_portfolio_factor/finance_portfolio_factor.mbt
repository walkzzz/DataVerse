///===
/// extcore/finance_portfolio_factor

pub(all) struct FinanceportfoliofactorPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_portfolio_factor_make_point(x : Double, y : Double) -> FinanceportfoliofactorPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_portfolio_factor_make_point3(x : Double, y : Double, z : Double) -> FinanceportfoliofactorPoint {
  { x, y, z, label: 0 }
}

pub fn finance_portfolio_factor_point_x(pt : FinanceportfoliofactorPoint) -> Double { pt.x }

pub fn finance_portfolio_factor_point_y(pt : FinanceportfoliofactorPoint) -> Double { pt.y }

pub fn finance_portfolio_factor_point_z(pt : FinanceportfoliofactorPoint) -> Double { pt.z }

pub fn finance_portfolio_factor_point_label(pt : FinanceportfoliofactorPoint) -> Int { pt.label }

pub fn finance_portfolio_factor_point_dist(a : FinanceportfoliofactorPoint, b : FinanceportfoliofactorPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_portfolio_factor_point_add(a : FinanceportfoliofactorPoint, b : FinanceportfoliofactorPoint) -> FinanceportfoliofactorPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_portfolio_factor_point_sub(a : FinanceportfoliofactorPoint, b : FinanceportfoliofactorPoint) -> FinanceportfoliofactorPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_portfolio_factor_point_scale(pt : FinanceportfoliofactorPoint, s : Double) -> FinanceportfoliofactorPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_portfolio_factor_point_dot(a : FinanceportfoliofactorPoint, b : FinanceportfoliofactorPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_portfolio_factor_point_cross(a : FinanceportfoliofactorPoint, b : FinanceportfoliofactorPoint) -> FinanceportfoliofactorPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_portfolio_factor_point_norm(pt : FinanceportfoliofactorPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_portfolio_factor_point_normalize(pt : FinanceportfoliofactorPoint) -> FinanceportfoliofactorPoint {
  let n = finance_portfolio_factor_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_portfolio_factor_point_scale(pt, 1.0 / n) }
}

pub fn finance_portfolio_factor_point_negate(pt : FinanceportfoliofactorPoint) -> FinanceportfoliofactorPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_portfolio_factor_point_mid(a : FinanceportfoliofactorPoint, b : FinanceportfoliofactorPoint) -> FinanceportfoliofactorPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_portfolio_factor_point_lerp(a : FinanceportfoliofactorPoint, b : FinanceportfoliofactorPoint, t : Double) -> FinanceportfoliofactorPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_portfolio_factor_point_to_string(pt : FinanceportfoliofactorPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_portfolio_factor_make_series(vals : Array[Double], name : String) -> FinanceportfoliofactorSeries {
  { vals, name, meta: 0 }
}

pub fn finance_portfolio_factor_series_len(s : FinanceportfoliofactorSeries) -> Int { s.vals.length() }

pub fn finance_portfolio_factor_series_sum(s : FinanceportfoliofactorSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_portfolio_factor_series_mean(s : FinanceportfoliofactorSeries) -> Double {
  let n = finance_portfolio_factor_series_len(s)
  if n == 0 { 0.0 } else { finance_portfolio_factor_series_sum(s) / n.to_double() }
}

pub fn finance_portfolio_factor_series_min(s : FinanceportfoliofactorSeries) -> Double {
  let n = finance_portfolio_factor_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_portfolio_factor_series_max(s : FinanceportfoliofactorSeries) -> Double {
  let n = finance_portfolio_factor_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_portfolio_factor_series_range(s : FinanceportfoliofactorSeries) -> Double {
  finance_portfolio_factor_series_max(s) - finance_portfolio_factor_series_min(s)
}

pub fn finance_portfolio_factor_series_var(s : FinanceportfoliofactorSeries) -> Double {
  let n = finance_portfolio_factor_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_portfolio_factor_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_portfolio_factor_series_std(s : FinanceportfoliofactorSeries) -> Double { @_common.sqrt(finance_portfolio_factor_series_var(s)) }

pub fn finance_portfolio_factor_series_median(s : FinanceportfoliofactorSeries) -> Double {
  let n = finance_portfolio_factor_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_portfolio_factor_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_portfolio_factor_series_scale(s : FinanceportfoliofactorSeries, f : Double) -> FinanceportfoliofactorSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_portfolio_factor_series_add(a : FinanceportfoliofactorSeries, b : FinanceportfoliofactorSeries) -> FinanceportfoliofactorSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_portfolio_factor_series_sub(a : FinanceportfoliofactorSeries, b : FinanceportfoliofactorSeries) -> FinanceportfoliofactorSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_portfolio_factor_series_normalize(s : FinanceportfoliofactorSeries) -> FinanceportfoliofactorSeries {
  let mn = finance_portfolio_factor_series_min(s)
  let mx = finance_portfolio_factor_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_portfolio_factor_series_cumsum(s : FinanceportfoliofactorSeries) -> FinanceportfoliofactorSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_portfolio_factor_series_to_string(s : FinanceportfoliofactorSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfoliofactorMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_portfolio_factor_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceportfoliofactorMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_portfolio_factor_matrix_identity(n : Int) -> FinanceportfoliofactorMatrix {
  let m = finance_portfolio_factor_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_portfolio_factor_matrix_get(m : FinanceportfoliofactorMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_portfolio_factor_matrix_transpose(m : FinanceportfoliofactorMatrix) -> FinanceportfoliofactorMatrix {
  let result = finance_portfolio_factor_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_portfolio_factor_matrix_add(a : FinanceportfoliofactorMatrix, b : FinanceportfoliofactorMatrix) -> FinanceportfoliofactorMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_portfolio_factor_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_portfolio_factor_matrix_scale(m : FinanceportfoliofactorMatrix, s : Double) -> FinanceportfoliofactorMatrix {
  let result = finance_portfolio_factor_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_portfolio_factor_matrix_multiply(a : FinanceportfoliofactorMatrix, b : FinanceportfoliofactorMatrix) -> FinanceportfoliofactorMatrix {
  if a.cols != b.rows { return finance_portfolio_factor_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_portfolio_factor_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_portfolio_factor_matrix_trace(m : FinanceportfoliofactorMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_portfolio_factor_matrix_det(m : FinanceportfoliofactorMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_portfolio_factor_matrix_norm(m : FinanceportfoliofactorMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_portfolio_factor_matrix_to_string(m : FinanceportfoliofactorMatrix) -> String {
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

pub(all) struct FinanceportfoliofactorVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_portfolio_factor_make_vector(comps : Array[Double]) -> FinanceportfoliofactorVector {
  { comps, dim: comps.length() }
}

pub fn finance_portfolio_factor_vector_zero(dim : Int) -> FinanceportfoliofactorVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_portfolio_factor_vector_add(a : FinanceportfoliofactorVector, b : FinanceportfoliofactorVector) -> FinanceportfoliofactorVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_portfolio_factor_vector_sub(a : FinanceportfoliofactorVector, b : FinanceportfoliofactorVector) -> FinanceportfoliofactorVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_portfolio_factor_vector_scale(v : FinanceportfoliofactorVector, s : Double) -> FinanceportfoliofactorVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_portfolio_factor_vector_dot(a : FinanceportfoliofactorVector, b : FinanceportfoliofactorVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_portfolio_factor_vector_norm(v : FinanceportfoliofactorVector) -> Double { @_common.sqrt(finance_portfolio_factor_vector_dot(v, v)) }

pub fn finance_portfolio_factor_vector_normalize(v : FinanceportfoliofactorVector) -> FinanceportfoliofactorVector {
  let n = finance_portfolio_factor_vector_norm(v)
  if n < 0.0000001 { v } else { finance_portfolio_factor_vector_scale(v, 1.0 / n) }
}

pub fn finance_portfolio_factor_vector_dist(a : FinanceportfoliofactorVector, b : FinanceportfoliofactorVector) -> Double {
  finance_portfolio_factor_vector_norm(finance_portfolio_factor_vector_sub(a, b))
}

pub fn finance_portfolio_factor_vector_to_string(v : FinanceportfoliofactorVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_portfolio_factor_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_factor_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = finance_portfolio_factor_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_factor_std(data : Array[Double]) -> Double { @_common.sqrt(finance_portfolio_factor_var(data)) }

pub fn finance_portfolio_factor_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = finance_portfolio_factor_mean(a); let mb = finance_portfolio_factor_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_factor_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = finance_portfolio_factor_std(a); let sb = finance_portfolio_factor_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { finance_portfolio_factor_cov(a, b) / (sa * sb) }
}

pub fn finance_portfolio_factor_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = finance_portfolio_factor_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_portfolio_factor_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn finance_portfolio_factor_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_factor_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(finance_portfolio_factor_mse(pred, labels))
}

pub fn finance_portfolio_factor_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_factor_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = finance_portfolio_factor_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn finance_portfolio_factor_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn finance_portfolio_factor_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn finance_portfolio_factor_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = finance_portfolio_factor_precision(pred, labels, pos); let r = finance_portfolio_factor_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn finance_portfolio_factor_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn finance_portfolio_factor_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = finance_portfolio_factor_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn finance_portfolio_factor_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn finance_portfolio_factor_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn finance_portfolio_factor_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = finance_portfolio_factor_gcd(a, b)
    (a / g) * b
  }
}

pub fn finance_portfolio_factor_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn finance_portfolio_factor_fibonacci(n : Int) -> Int {
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

pub fn finance_portfolio_factor_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = finance_portfolio_factor_min(data); let mx = finance_portfolio_factor_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn finance_portfolio_factor_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = finance_portfolio_factor_mean(data); let sd = finance_portfolio_factor_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn finance_portfolio_factor_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn finance_portfolio_factor_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn finance_portfolio_factor_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn finance_portfolio_factor_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct FinanceportfoliofactorFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_frame_make(size : Int) -> FinanceportfoliofactorFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_frame_len(s : FinanceportfoliofactorFrame) -> Int { s.size }

pub fn finance_portfolio_factor_frame_get(s : FinanceportfoliofactorFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_frame_set(s : FinanceportfoliofactorFrame, i : Int, v : Double) -> FinanceportfoliofactorFrame {
  let result = finance_portfolio_factor_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_frame_sum(s : FinanceportfoliofactorFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_factor_frame_mean(s : FinanceportfoliofactorFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_factor_frame_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_factor_frame_scale(s : FinanceportfoliofactorFrame, f : Double) -> FinanceportfoliofactorFrame {
  let result = finance_portfolio_factor_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_factor_frame_add(a : FinanceportfoliofactorFrame, b : FinanceportfoliofactorFrame) -> FinanceportfoliofactorFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_factor_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_factor_frame_copy(s : FinanceportfoliofactorFrame) -> FinanceportfoliofactorFrame {
  let result = finance_portfolio_factor_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_factor_frame_fill(s : FinanceportfoliofactorFrame, v : Double) -> FinanceportfoliofactorFrame {
  let result = finance_portfolio_factor_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_frame_min(s : FinanceportfoliofactorFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_frame_max(s : FinanceportfoliofactorFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_frame_to_string(s : FinanceportfoliofactorFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_table_make(size : Int) -> FinanceportfoliofactorTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_table_len(s : FinanceportfoliofactorTable) -> Int { s.size }

pub fn finance_portfolio_factor_table_get(s : FinanceportfoliofactorTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_table_set(s : FinanceportfoliofactorTable, i : Int, v : Double) -> FinanceportfoliofactorTable {
  let result = finance_portfolio_factor_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_table_sum(s : FinanceportfoliofactorTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_factor_table_mean(s : FinanceportfoliofactorTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_factor_table_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_factor_table_scale(s : FinanceportfoliofactorTable, f : Double) -> FinanceportfoliofactorTable {
  let result = finance_portfolio_factor_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_factor_table_add(a : FinanceportfoliofactorTable, b : FinanceportfoliofactorTable) -> FinanceportfoliofactorTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_factor_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_factor_table_copy(s : FinanceportfoliofactorTable) -> FinanceportfoliofactorTable {
  let result = finance_portfolio_factor_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_factor_table_fill(s : FinanceportfoliofactorTable, v : Double) -> FinanceportfoliofactorTable {
  let result = finance_portfolio_factor_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_table_min(s : FinanceportfoliofactorTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_table_max(s : FinanceportfoliofactorTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_table_to_string(s : FinanceportfoliofactorTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_graphn_make(size : Int) -> FinanceportfoliofactorGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_graphn_len(s : FinanceportfoliofactorGraphN) -> Int { s.size }

pub fn finance_portfolio_factor_graphn_get(s : FinanceportfoliofactorGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_graphn_set(s : FinanceportfoliofactorGraphN, i : Int, v : Double) -> FinanceportfoliofactorGraphN {
  let result = finance_portfolio_factor_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_graphn_sum(s : FinanceportfoliofactorGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_factor_graphn_mean(s : FinanceportfoliofactorGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_factor_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_factor_graphn_scale(s : FinanceportfoliofactorGraphN, f : Double) -> FinanceportfoliofactorGraphN {
  let result = finance_portfolio_factor_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_factor_graphn_add(a : FinanceportfoliofactorGraphN, b : FinanceportfoliofactorGraphN) -> FinanceportfoliofactorGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_factor_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_factor_graphn_copy(s : FinanceportfoliofactorGraphN) -> FinanceportfoliofactorGraphN {
  let result = finance_portfolio_factor_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_factor_graphn_fill(s : FinanceportfoliofactorGraphN, v : Double) -> FinanceportfoliofactorGraphN {
  let result = finance_portfolio_factor_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_graphn_min(s : FinanceportfoliofactorGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_graphn_max(s : FinanceportfoliofactorGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_graphn_to_string(s : FinanceportfoliofactorGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_node_make(size : Int) -> FinanceportfoliofactorNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_node_len(s : FinanceportfoliofactorNode) -> Int { s.size }

pub fn finance_portfolio_factor_node_get(s : FinanceportfoliofactorNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_node_set(s : FinanceportfoliofactorNode, i : Int, v : Double) -> FinanceportfoliofactorNode {
  let result = finance_portfolio_factor_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_node_sum(s : FinanceportfoliofactorNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_factor_node_mean(s : FinanceportfoliofactorNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_factor_node_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_factor_node_scale(s : FinanceportfoliofactorNode, f : Double) -> FinanceportfoliofactorNode {
  let result = finance_portfolio_factor_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_factor_node_add(a : FinanceportfoliofactorNode, b : FinanceportfoliofactorNode) -> FinanceportfoliofactorNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_factor_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_factor_node_copy(s : FinanceportfoliofactorNode) -> FinanceportfoliofactorNode {
  let result = finance_portfolio_factor_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_factor_node_fill(s : FinanceportfoliofactorNode, v : Double) -> FinanceportfoliofactorNode {
  let result = finance_portfolio_factor_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_node_min(s : FinanceportfoliofactorNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_node_max(s : FinanceportfoliofactorNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_node_to_string(s : FinanceportfoliofactorNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_edge_make(size : Int) -> FinanceportfoliofactorEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_edge_len(s : FinanceportfoliofactorEdge) -> Int { s.size }

pub fn finance_portfolio_factor_edge_get(s : FinanceportfoliofactorEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_edge_set(s : FinanceportfoliofactorEdge, i : Int, v : Double) -> FinanceportfoliofactorEdge {
  let result = finance_portfolio_factor_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_edge_sum(s : FinanceportfoliofactorEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_factor_edge_mean(s : FinanceportfoliofactorEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_factor_edge_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_factor_edge_scale(s : FinanceportfoliofactorEdge, f : Double) -> FinanceportfoliofactorEdge {
  let result = finance_portfolio_factor_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_factor_edge_add(a : FinanceportfoliofactorEdge, b : FinanceportfoliofactorEdge) -> FinanceportfoliofactorEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_factor_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_factor_edge_copy(s : FinanceportfoliofactorEdge) -> FinanceportfoliofactorEdge {
  let result = finance_portfolio_factor_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_factor_edge_fill(s : FinanceportfoliofactorEdge, v : Double) -> FinanceportfoliofactorEdge {
  let result = finance_portfolio_factor_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_edge_min(s : FinanceportfoliofactorEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_edge_max(s : FinanceportfoliofactorEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_edge_to_string(s : FinanceportfoliofactorEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_path_make(size : Int) -> FinanceportfoliofactorPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_path_len(s : FinanceportfoliofactorPath) -> Int { s.size }

pub fn finance_portfolio_factor_path_get(s : FinanceportfoliofactorPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_path_set(s : FinanceportfoliofactorPath, i : Int, v : Double) -> FinanceportfoliofactorPath {
  let result = finance_portfolio_factor_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_path_sum(s : FinanceportfoliofactorPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_factor_path_mean(s : FinanceportfoliofactorPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_factor_path_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_factor_path_scale(s : FinanceportfoliofactorPath, f : Double) -> FinanceportfoliofactorPath {
  let result = finance_portfolio_factor_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_factor_path_add(a : FinanceportfoliofactorPath, b : FinanceportfoliofactorPath) -> FinanceportfoliofactorPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_factor_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_factor_path_copy(s : FinanceportfoliofactorPath) -> FinanceportfoliofactorPath {
  let result = finance_portfolio_factor_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_factor_path_fill(s : FinanceportfoliofactorPath, v : Double) -> FinanceportfoliofactorPath {
  let result = finance_portfolio_factor_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_path_min(s : FinanceportfoliofactorPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_path_max(s : FinanceportfoliofactorPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_path_to_string(s : FinanceportfoliofactorPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_cluster_make(size : Int) -> FinanceportfoliofactorCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_cluster_len(s : FinanceportfoliofactorCluster) -> Int { s.size }

pub fn finance_portfolio_factor_cluster_get(s : FinanceportfoliofactorCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_cluster_set(s : FinanceportfoliofactorCluster, i : Int, v : Double) -> FinanceportfoliofactorCluster {
  let result = finance_portfolio_factor_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_cluster_sum(s : FinanceportfoliofactorCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_factor_cluster_mean(s : FinanceportfoliofactorCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_factor_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_factor_cluster_scale(s : FinanceportfoliofactorCluster, f : Double) -> FinanceportfoliofactorCluster {
  let result = finance_portfolio_factor_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_factor_cluster_add(a : FinanceportfoliofactorCluster, b : FinanceportfoliofactorCluster) -> FinanceportfoliofactorCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_factor_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_factor_cluster_copy(s : FinanceportfoliofactorCluster) -> FinanceportfoliofactorCluster {
  let result = finance_portfolio_factor_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_factor_cluster_fill(s : FinanceportfoliofactorCluster, v : Double) -> FinanceportfoliofactorCluster {
  let result = finance_portfolio_factor_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_cluster_min(s : FinanceportfoliofactorCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_cluster_max(s : FinanceportfoliofactorCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_cluster_to_string(s : FinanceportfoliofactorCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_model_make(size : Int) -> FinanceportfoliofactorModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_model_len(s : FinanceportfoliofactorModel) -> Int { s.size }

pub fn finance_portfolio_factor_model_get(s : FinanceportfoliofactorModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_model_set(s : FinanceportfoliofactorModel, i : Int, v : Double) -> FinanceportfoliofactorModel {
  let result = finance_portfolio_factor_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_model_sum(s : FinanceportfoliofactorModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_factor_model_mean(s : FinanceportfoliofactorModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_factor_model_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_factor_model_scale(s : FinanceportfoliofactorModel, f : Double) -> FinanceportfoliofactorModel {
  let result = finance_portfolio_factor_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_factor_model_add(a : FinanceportfoliofactorModel, b : FinanceportfoliofactorModel) -> FinanceportfoliofactorModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_factor_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_factor_model_copy(s : FinanceportfoliofactorModel) -> FinanceportfoliofactorModel {
  let result = finance_portfolio_factor_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_factor_model_fill(s : FinanceportfoliofactorModel, v : Double) -> FinanceportfoliofactorModel {
  let result = finance_portfolio_factor_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_model_min(s : FinanceportfoliofactorModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_model_max(s : FinanceportfoliofactorModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_model_to_string(s : FinanceportfoliofactorModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_layer_make(size : Int) -> FinanceportfoliofactorLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_layer_len(s : FinanceportfoliofactorLayer) -> Int { s.size }

pub fn finance_portfolio_factor_layer_get(s : FinanceportfoliofactorLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_layer_set(s : FinanceportfoliofactorLayer, i : Int, v : Double) -> FinanceportfoliofactorLayer {
  let result = finance_portfolio_factor_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_layer_sum(s : FinanceportfoliofactorLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_factor_layer_mean(s : FinanceportfoliofactorLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_factor_layer_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_factor_layer_scale(s : FinanceportfoliofactorLayer, f : Double) -> FinanceportfoliofactorLayer {
  let result = finance_portfolio_factor_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_factor_layer_add(a : FinanceportfoliofactorLayer, b : FinanceportfoliofactorLayer) -> FinanceportfoliofactorLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_factor_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_factor_layer_copy(s : FinanceportfoliofactorLayer) -> FinanceportfoliofactorLayer {
  let result = finance_portfolio_factor_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_factor_layer_fill(s : FinanceportfoliofactorLayer, v : Double) -> FinanceportfoliofactorLayer {
  let result = finance_portfolio_factor_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_layer_min(s : FinanceportfoliofactorLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_layer_max(s : FinanceportfoliofactorLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_layer_to_string(s : FinanceportfoliofactorLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_buffer_make(size : Int) -> FinanceportfoliofactorBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_buffer_len(s : FinanceportfoliofactorBuffer) -> Int { s.size }

pub fn finance_portfolio_factor_buffer_get(s : FinanceportfoliofactorBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_buffer_set(s : FinanceportfoliofactorBuffer, i : Int, v : Double) -> FinanceportfoliofactorBuffer {
  let result = finance_portfolio_factor_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_buffer_sum(s : FinanceportfoliofactorBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_factor_buffer_mean(s : FinanceportfoliofactorBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_factor_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_factor_buffer_scale(s : FinanceportfoliofactorBuffer, f : Double) -> FinanceportfoliofactorBuffer {
  let result = finance_portfolio_factor_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_factor_buffer_add(a : FinanceportfoliofactorBuffer, b : FinanceportfoliofactorBuffer) -> FinanceportfoliofactorBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_factor_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_factor_buffer_copy(s : FinanceportfoliofactorBuffer) -> FinanceportfoliofactorBuffer {
  let result = finance_portfolio_factor_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_factor_buffer_fill(s : FinanceportfoliofactorBuffer, v : Double) -> FinanceportfoliofactorBuffer {
  let result = finance_portfolio_factor_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_buffer_min(s : FinanceportfoliofactorBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_buffer_max(s : FinanceportfoliofactorBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_buffer_to_string(s : FinanceportfoliofactorBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_cursor_make(size : Int) -> FinanceportfoliofactorCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_cursor_len(s : FinanceportfoliofactorCursor) -> Int { s.size }

pub fn finance_portfolio_factor_cursor_get(s : FinanceportfoliofactorCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_cursor_set(s : FinanceportfoliofactorCursor, i : Int, v : Double) -> FinanceportfoliofactorCursor {
  let result = finance_portfolio_factor_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_cursor_sum(s : FinanceportfoliofactorCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_factor_cursor_mean(s : FinanceportfoliofactorCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_factor_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_factor_cursor_scale(s : FinanceportfoliofactorCursor, f : Double) -> FinanceportfoliofactorCursor {
  let result = finance_portfolio_factor_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_factor_cursor_add(a : FinanceportfoliofactorCursor, b : FinanceportfoliofactorCursor) -> FinanceportfoliofactorCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_factor_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_factor_cursor_copy(s : FinanceportfoliofactorCursor) -> FinanceportfoliofactorCursor {
  let result = finance_portfolio_factor_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_factor_cursor_fill(s : FinanceportfoliofactorCursor, v : Double) -> FinanceportfoliofactorCursor {
  let result = finance_portfolio_factor_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_cursor_min(s : FinanceportfoliofactorCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_cursor_max(s : FinanceportfoliofactorCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_cursor_to_string(s : FinanceportfoliofactorCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_view_make(size : Int) -> FinanceportfoliofactorView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_view_len(s : FinanceportfoliofactorView) -> Int { s.size }

pub fn finance_portfolio_factor_view_get(s : FinanceportfoliofactorView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_view_set(s : FinanceportfoliofactorView, i : Int, v : Double) -> FinanceportfoliofactorView {
  let result = finance_portfolio_factor_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_view_sum(s : FinanceportfoliofactorView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_factor_view_mean(s : FinanceportfoliofactorView) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_factor_view_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_factor_view_scale(s : FinanceportfoliofactorView, f : Double) -> FinanceportfoliofactorView {
  let result = finance_portfolio_factor_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_factor_view_add(a : FinanceportfoliofactorView, b : FinanceportfoliofactorView) -> FinanceportfoliofactorView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_factor_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_factor_view_copy(s : FinanceportfoliofactorView) -> FinanceportfoliofactorView {
  let result = finance_portfolio_factor_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_factor_view_fill(s : FinanceportfoliofactorView, v : Double) -> FinanceportfoliofactorView {
  let result = finance_portfolio_factor_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_view_min(s : FinanceportfoliofactorView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_view_max(s : FinanceportfoliofactorView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_view_to_string(s : FinanceportfoliofactorView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_range_make(size : Int) -> FinanceportfoliofactorRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_range_len(s : FinanceportfoliofactorRange) -> Int { s.size }

pub fn finance_portfolio_factor_range_get(s : FinanceportfoliofactorRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_range_set(s : FinanceportfoliofactorRange, i : Int, v : Double) -> FinanceportfoliofactorRange {
  let result = finance_portfolio_factor_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_range_sum(s : FinanceportfoliofactorRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_factor_range_mean(s : FinanceportfoliofactorRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_factor_range_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_factor_range_scale(s : FinanceportfoliofactorRange, f : Double) -> FinanceportfoliofactorRange {
  let result = finance_portfolio_factor_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_factor_range_add(a : FinanceportfoliofactorRange, b : FinanceportfoliofactorRange) -> FinanceportfoliofactorRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_factor_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_factor_range_copy(s : FinanceportfoliofactorRange) -> FinanceportfoliofactorRange {
  let result = finance_portfolio_factor_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_factor_range_fill(s : FinanceportfoliofactorRange, v : Double) -> FinanceportfoliofactorRange {
  let result = finance_portfolio_factor_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_range_min(s : FinanceportfoliofactorRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_range_max(s : FinanceportfoliofactorRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_range_to_string(s : FinanceportfoliofactorRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_slice_make(size : Int) -> FinanceportfoliofactorSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_slice_len(s : FinanceportfoliofactorSlice) -> Int { s.size }

pub fn finance_portfolio_factor_slice_get(s : FinanceportfoliofactorSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_slice_set(s : FinanceportfoliofactorSlice, i : Int, v : Double) -> FinanceportfoliofactorSlice {
  let result = finance_portfolio_factor_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_slice_sum(s : FinanceportfoliofactorSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_factor_slice_mean(s : FinanceportfoliofactorSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_factor_slice_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_factor_slice_scale(s : FinanceportfoliofactorSlice, f : Double) -> FinanceportfoliofactorSlice {
  let result = finance_portfolio_factor_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_factor_slice_add(a : FinanceportfoliofactorSlice, b : FinanceportfoliofactorSlice) -> FinanceportfoliofactorSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_factor_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_factor_slice_copy(s : FinanceportfoliofactorSlice) -> FinanceportfoliofactorSlice {
  let result = finance_portfolio_factor_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_factor_slice_fill(s : FinanceportfoliofactorSlice, v : Double) -> FinanceportfoliofactorSlice {
  let result = finance_portfolio_factor_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_factor_slice_min(s : FinanceportfoliofactorSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_slice_max(s : FinanceportfoliofactorSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_factor_slice_to_string(s : FinanceportfoliofactorSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

