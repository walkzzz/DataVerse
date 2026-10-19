///===
/// extcore/finance_portfolio_apt

pub(all) struct FinanceportfolioaptPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_portfolio_apt_make_point(x : Double, y : Double) -> FinanceportfolioaptPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_portfolio_apt_make_point3(x : Double, y : Double, z : Double) -> FinanceportfolioaptPoint {
  { x, y, z, label: 0 }
}

pub fn finance_portfolio_apt_point_x(pt : FinanceportfolioaptPoint) -> Double { pt.x }

pub fn finance_portfolio_apt_point_y(pt : FinanceportfolioaptPoint) -> Double { pt.y }

pub fn finance_portfolio_apt_point_z(pt : FinanceportfolioaptPoint) -> Double { pt.z }

pub fn finance_portfolio_apt_point_label(pt : FinanceportfolioaptPoint) -> Int { pt.label }

pub fn finance_portfolio_apt_point_dist(a : FinanceportfolioaptPoint, b : FinanceportfolioaptPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  finance_portfolio_apt_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_portfolio_apt_point_add(a : FinanceportfolioaptPoint, b : FinanceportfolioaptPoint) -> FinanceportfolioaptPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_portfolio_apt_point_sub(a : FinanceportfolioaptPoint, b : FinanceportfolioaptPoint) -> FinanceportfolioaptPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_portfolio_apt_point_scale(pt : FinanceportfolioaptPoint, s : Double) -> FinanceportfolioaptPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_portfolio_apt_point_dot(a : FinanceportfolioaptPoint, b : FinanceportfolioaptPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_portfolio_apt_point_cross(a : FinanceportfolioaptPoint, b : FinanceportfolioaptPoint) -> FinanceportfolioaptPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_portfolio_apt_point_norm(pt : FinanceportfolioaptPoint) -> Double {
  finance_portfolio_apt_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_portfolio_apt_point_normalize(pt : FinanceportfolioaptPoint) -> FinanceportfolioaptPoint {
  let n = finance_portfolio_apt_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_portfolio_apt_point_scale(pt, 1.0 / n) }
}

pub fn finance_portfolio_apt_point_negate(pt : FinanceportfolioaptPoint) -> FinanceportfolioaptPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_portfolio_apt_point_mid(a : FinanceportfolioaptPoint, b : FinanceportfolioaptPoint) -> FinanceportfolioaptPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_portfolio_apt_point_lerp(a : FinanceportfolioaptPoint, b : FinanceportfolioaptPoint, t : Double) -> FinanceportfolioaptPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_portfolio_apt_point_to_string(pt : FinanceportfolioaptPoint) -> String {
  "(" + finance_portfolio_apt_dbl(pt.x) + ", " + finance_portfolio_apt_dbl(pt.y) + ", " + finance_portfolio_apt_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinanceportfolioaptSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_portfolio_apt_make_series(vals : Array[Double], name : String) -> FinanceportfolioaptSeries {
  { vals, name, meta: 0 }
}

pub fn finance_portfolio_apt_series_len(s : FinanceportfolioaptSeries) -> Int { s.vals.length() }

pub fn finance_portfolio_apt_series_sum(s : FinanceportfolioaptSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_portfolio_apt_series_mean(s : FinanceportfolioaptSeries) -> Double {
  let n = finance_portfolio_apt_series_len(s)
  if n == 0 { 0.0 } else { finance_portfolio_apt_series_sum(s) / n.to_double() }
}

pub fn finance_portfolio_apt_series_min(s : FinanceportfolioaptSeries) -> Double {
  let n = finance_portfolio_apt_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_portfolio_apt_series_max(s : FinanceportfolioaptSeries) -> Double {
  let n = finance_portfolio_apt_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_portfolio_apt_series_range(s : FinanceportfolioaptSeries) -> Double {
  finance_portfolio_apt_series_max(s) - finance_portfolio_apt_series_min(s)
}

pub fn finance_portfolio_apt_series_var(s : FinanceportfolioaptSeries) -> Double {
  let n = finance_portfolio_apt_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_portfolio_apt_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_portfolio_apt_series_std(s : FinanceportfolioaptSeries) -> Double { finance_portfolio_apt_sqrt(finance_portfolio_apt_series_var(s)) }

pub fn finance_portfolio_apt_series_median(s : FinanceportfolioaptSeries) -> Double {
  let n = finance_portfolio_apt_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_portfolio_apt_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_portfolio_apt_series_scale(s : FinanceportfolioaptSeries, f : Double) -> FinanceportfolioaptSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = finance_portfolio_apt_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_portfolio_apt_series_add(a : FinanceportfolioaptSeries, b : FinanceportfolioaptSeries) -> FinanceportfolioaptSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_portfolio_apt_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_portfolio_apt_series_sub(a : FinanceportfolioaptSeries, b : FinanceportfolioaptSeries) -> FinanceportfolioaptSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_portfolio_apt_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_portfolio_apt_series_normalize(s : FinanceportfolioaptSeries) -> FinanceportfolioaptSeries {
  let mn = finance_portfolio_apt_series_min(s)
  let mx = finance_portfolio_apt_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = finance_portfolio_apt_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_portfolio_apt_series_cumsum(s : FinanceportfolioaptSeries) -> FinanceportfolioaptSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = finance_portfolio_apt_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_portfolio_apt_series_to_string(s : FinanceportfolioaptSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_portfolio_apt_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfolioaptMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_portfolio_apt_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceportfolioaptMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_portfolio_apt_matrix_identity(n : Int) -> FinanceportfolioaptMatrix {
  let m = finance_portfolio_apt_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_portfolio_apt_matrix_get(m : FinanceportfolioaptMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_portfolio_apt_matrix_transpose(m : FinanceportfolioaptMatrix) -> FinanceportfolioaptMatrix {
  let result = finance_portfolio_apt_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_portfolio_apt_matrix_add(a : FinanceportfolioaptMatrix, b : FinanceportfolioaptMatrix) -> FinanceportfolioaptMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_portfolio_apt_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_portfolio_apt_matrix_scale(m : FinanceportfolioaptMatrix, s : Double) -> FinanceportfolioaptMatrix {
  let result = finance_portfolio_apt_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_portfolio_apt_matrix_multiply(a : FinanceportfolioaptMatrix, b : FinanceportfolioaptMatrix) -> FinanceportfolioaptMatrix {
  if a.cols != b.rows { return finance_portfolio_apt_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_portfolio_apt_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_portfolio_apt_matrix_trace(m : FinanceportfolioaptMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_portfolio_apt_matrix_det(m : FinanceportfolioaptMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_portfolio_apt_matrix_norm(m : FinanceportfolioaptMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  finance_portfolio_apt_sqrt(sum)
}

pub fn finance_portfolio_apt_matrix_to_string(m : FinanceportfolioaptMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + finance_portfolio_apt_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct FinanceportfolioaptVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_portfolio_apt_make_vector(comps : Array[Double]) -> FinanceportfolioaptVector {
  { comps, dim: comps.length() }
}

pub fn finance_portfolio_apt_vector_zero(dim : Int) -> FinanceportfolioaptVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_portfolio_apt_vector_add(a : FinanceportfolioaptVector, b : FinanceportfolioaptVector) -> FinanceportfolioaptVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_portfolio_apt_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_portfolio_apt_vector_sub(a : FinanceportfolioaptVector, b : FinanceportfolioaptVector) -> FinanceportfolioaptVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_portfolio_apt_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_portfolio_apt_vector_scale(v : FinanceportfolioaptVector, s : Double) -> FinanceportfolioaptVector {
  let mut result = []
  for i in 0..<v.dim { result = finance_portfolio_apt_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_portfolio_apt_vector_dot(a : FinanceportfolioaptVector, b : FinanceportfolioaptVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_portfolio_apt_vector_norm(v : FinanceportfolioaptVector) -> Double { finance_portfolio_apt_sqrt(finance_portfolio_apt_vector_dot(v, v)) }

pub fn finance_portfolio_apt_vector_normalize(v : FinanceportfolioaptVector) -> FinanceportfolioaptVector {
  let n = finance_portfolio_apt_vector_norm(v)
  if n < 0.0000001 { v } else { finance_portfolio_apt_vector_scale(v, 1.0 / n) }
}

pub fn finance_portfolio_apt_vector_dist(a : FinanceportfolioaptVector, b : FinanceportfolioaptVector) -> Double {
  finance_portfolio_apt_vector_norm(finance_portfolio_apt_vector_sub(a, b))
}

pub fn finance_portfolio_apt_vector_to_string(v : FinanceportfolioaptVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_portfolio_apt_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_portfolio_apt_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_apt_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = finance_portfolio_apt_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_apt_std(data : Array[Double]) -> Double { finance_portfolio_apt_sqrt(finance_portfolio_apt_var(data)) }

pub fn finance_portfolio_apt_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = finance_portfolio_apt_mean(a); let mb = finance_portfolio_apt_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_apt_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = finance_portfolio_apt_std(a); let sb = finance_portfolio_apt_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { finance_portfolio_apt_cov(a, b) / (sa * sb) }
}

pub fn finance_portfolio_apt_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = finance_portfolio_apt_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_portfolio_apt_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn finance_portfolio_apt_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_apt_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  finance_portfolio_apt_sqrt(finance_portfolio_apt_mse(pred, labels))
}

pub fn finance_portfolio_apt_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + finance_portfolio_apt_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_apt_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = finance_portfolio_apt_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn finance_portfolio_apt_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn finance_portfolio_apt_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn finance_portfolio_apt_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = finance_portfolio_apt_precision(pred, labels, pos); let r = finance_portfolio_apt_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn finance_portfolio_apt_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn finance_portfolio_apt_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = finance_portfolio_apt_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn finance_portfolio_apt_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn finance_portfolio_apt_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn finance_portfolio_apt_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = finance_portfolio_apt_gcd(a, b)
    (a / g) * b
  }
}

pub fn finance_portfolio_apt_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn finance_portfolio_apt_fibonacci(n : Int) -> Int {
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

pub fn finance_portfolio_apt_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = finance_portfolio_apt_min(data); let mx = finance_portfolio_apt_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn finance_portfolio_apt_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = finance_portfolio_apt_mean(data); let sd = finance_portfolio_apt_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn finance_portfolio_apt_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn finance_portfolio_apt_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn finance_portfolio_apt_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn finance_portfolio_apt_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn finance_portfolio_apt_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn finance_portfolio_apt_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn finance_portfolio_apt_dbl(x : Double) -> String {
  let i = if x >= 0.0 { finance_portfolio_apt_int(x) } else { -finance_portfolio_apt_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { finance_portfolio_apt_int(f * 1000000.0) } else { finance_portfolio_apt_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn finance_portfolio_apt_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn finance_portfolio_apt_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct FinanceportfolioaptFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_frame_make(size : Int) -> FinanceportfolioaptFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_frame_len(s : FinanceportfolioaptFrame) -> Int { s.size }

pub fn finance_portfolio_apt_frame_get(s : FinanceportfolioaptFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_frame_set(s : FinanceportfolioaptFrame, i : Int, v : Double) -> FinanceportfolioaptFrame {
  let result = finance_portfolio_apt_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_frame_sum(s : FinanceportfolioaptFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_apt_frame_mean(s : FinanceportfolioaptFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_apt_frame_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_apt_frame_scale(s : FinanceportfolioaptFrame, f : Double) -> FinanceportfolioaptFrame {
  let result = finance_portfolio_apt_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_apt_frame_add(a : FinanceportfolioaptFrame, b : FinanceportfolioaptFrame) -> FinanceportfolioaptFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_apt_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_apt_frame_copy(s : FinanceportfolioaptFrame) -> FinanceportfolioaptFrame {
  let result = finance_portfolio_apt_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_apt_frame_fill(s : FinanceportfolioaptFrame, v : Double) -> FinanceportfolioaptFrame {
  let result = finance_portfolio_apt_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_frame_min(s : FinanceportfolioaptFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_frame_max(s : FinanceportfolioaptFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_frame_to_string(s : FinanceportfolioaptFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_table_make(size : Int) -> FinanceportfolioaptTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_table_len(s : FinanceportfolioaptTable) -> Int { s.size }

pub fn finance_portfolio_apt_table_get(s : FinanceportfolioaptTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_table_set(s : FinanceportfolioaptTable, i : Int, v : Double) -> FinanceportfolioaptTable {
  let result = finance_portfolio_apt_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_table_sum(s : FinanceportfolioaptTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_apt_table_mean(s : FinanceportfolioaptTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_apt_table_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_apt_table_scale(s : FinanceportfolioaptTable, f : Double) -> FinanceportfolioaptTable {
  let result = finance_portfolio_apt_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_apt_table_add(a : FinanceportfolioaptTable, b : FinanceportfolioaptTable) -> FinanceportfolioaptTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_apt_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_apt_table_copy(s : FinanceportfolioaptTable) -> FinanceportfolioaptTable {
  let result = finance_portfolio_apt_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_apt_table_fill(s : FinanceportfolioaptTable, v : Double) -> FinanceportfolioaptTable {
  let result = finance_portfolio_apt_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_table_min(s : FinanceportfolioaptTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_table_max(s : FinanceportfolioaptTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_table_to_string(s : FinanceportfolioaptTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_graphn_make(size : Int) -> FinanceportfolioaptGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_graphn_len(s : FinanceportfolioaptGraphN) -> Int { s.size }

pub fn finance_portfolio_apt_graphn_get(s : FinanceportfolioaptGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_graphn_set(s : FinanceportfolioaptGraphN, i : Int, v : Double) -> FinanceportfolioaptGraphN {
  let result = finance_portfolio_apt_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_graphn_sum(s : FinanceportfolioaptGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_apt_graphn_mean(s : FinanceportfolioaptGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_apt_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_apt_graphn_scale(s : FinanceportfolioaptGraphN, f : Double) -> FinanceportfolioaptGraphN {
  let result = finance_portfolio_apt_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_apt_graphn_add(a : FinanceportfolioaptGraphN, b : FinanceportfolioaptGraphN) -> FinanceportfolioaptGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_apt_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_apt_graphn_copy(s : FinanceportfolioaptGraphN) -> FinanceportfolioaptGraphN {
  let result = finance_portfolio_apt_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_apt_graphn_fill(s : FinanceportfolioaptGraphN, v : Double) -> FinanceportfolioaptGraphN {
  let result = finance_portfolio_apt_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_graphn_min(s : FinanceportfolioaptGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_graphn_max(s : FinanceportfolioaptGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_graphn_to_string(s : FinanceportfolioaptGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_node_make(size : Int) -> FinanceportfolioaptNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_node_len(s : FinanceportfolioaptNode) -> Int { s.size }

pub fn finance_portfolio_apt_node_get(s : FinanceportfolioaptNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_node_set(s : FinanceportfolioaptNode, i : Int, v : Double) -> FinanceportfolioaptNode {
  let result = finance_portfolio_apt_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_node_sum(s : FinanceportfolioaptNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_apt_node_mean(s : FinanceportfolioaptNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_apt_node_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_apt_node_scale(s : FinanceportfolioaptNode, f : Double) -> FinanceportfolioaptNode {
  let result = finance_portfolio_apt_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_apt_node_add(a : FinanceportfolioaptNode, b : FinanceportfolioaptNode) -> FinanceportfolioaptNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_apt_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_apt_node_copy(s : FinanceportfolioaptNode) -> FinanceportfolioaptNode {
  let result = finance_portfolio_apt_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_apt_node_fill(s : FinanceportfolioaptNode, v : Double) -> FinanceportfolioaptNode {
  let result = finance_portfolio_apt_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_node_min(s : FinanceportfolioaptNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_node_max(s : FinanceportfolioaptNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_node_to_string(s : FinanceportfolioaptNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_edge_make(size : Int) -> FinanceportfolioaptEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_edge_len(s : FinanceportfolioaptEdge) -> Int { s.size }

pub fn finance_portfolio_apt_edge_get(s : FinanceportfolioaptEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_edge_set(s : FinanceportfolioaptEdge, i : Int, v : Double) -> FinanceportfolioaptEdge {
  let result = finance_portfolio_apt_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_edge_sum(s : FinanceportfolioaptEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_apt_edge_mean(s : FinanceportfolioaptEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_apt_edge_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_apt_edge_scale(s : FinanceportfolioaptEdge, f : Double) -> FinanceportfolioaptEdge {
  let result = finance_portfolio_apt_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_apt_edge_add(a : FinanceportfolioaptEdge, b : FinanceportfolioaptEdge) -> FinanceportfolioaptEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_apt_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_apt_edge_copy(s : FinanceportfolioaptEdge) -> FinanceportfolioaptEdge {
  let result = finance_portfolio_apt_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_apt_edge_fill(s : FinanceportfolioaptEdge, v : Double) -> FinanceportfolioaptEdge {
  let result = finance_portfolio_apt_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_edge_min(s : FinanceportfolioaptEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_edge_max(s : FinanceportfolioaptEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_edge_to_string(s : FinanceportfolioaptEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_path_make(size : Int) -> FinanceportfolioaptPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_path_len(s : FinanceportfolioaptPath) -> Int { s.size }

pub fn finance_portfolio_apt_path_get(s : FinanceportfolioaptPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_path_set(s : FinanceportfolioaptPath, i : Int, v : Double) -> FinanceportfolioaptPath {
  let result = finance_portfolio_apt_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_path_sum(s : FinanceportfolioaptPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_apt_path_mean(s : FinanceportfolioaptPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_apt_path_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_apt_path_scale(s : FinanceportfolioaptPath, f : Double) -> FinanceportfolioaptPath {
  let result = finance_portfolio_apt_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_apt_path_add(a : FinanceportfolioaptPath, b : FinanceportfolioaptPath) -> FinanceportfolioaptPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_apt_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_apt_path_copy(s : FinanceportfolioaptPath) -> FinanceportfolioaptPath {
  let result = finance_portfolio_apt_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_apt_path_fill(s : FinanceportfolioaptPath, v : Double) -> FinanceportfolioaptPath {
  let result = finance_portfolio_apt_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_path_min(s : FinanceportfolioaptPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_path_max(s : FinanceportfolioaptPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_path_to_string(s : FinanceportfolioaptPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_cluster_make(size : Int) -> FinanceportfolioaptCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_cluster_len(s : FinanceportfolioaptCluster) -> Int { s.size }

pub fn finance_portfolio_apt_cluster_get(s : FinanceportfolioaptCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_cluster_set(s : FinanceportfolioaptCluster, i : Int, v : Double) -> FinanceportfolioaptCluster {
  let result = finance_portfolio_apt_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_cluster_sum(s : FinanceportfolioaptCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_apt_cluster_mean(s : FinanceportfolioaptCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_apt_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_apt_cluster_scale(s : FinanceportfolioaptCluster, f : Double) -> FinanceportfolioaptCluster {
  let result = finance_portfolio_apt_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_apt_cluster_add(a : FinanceportfolioaptCluster, b : FinanceportfolioaptCluster) -> FinanceportfolioaptCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_apt_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_apt_cluster_copy(s : FinanceportfolioaptCluster) -> FinanceportfolioaptCluster {
  let result = finance_portfolio_apt_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_apt_cluster_fill(s : FinanceportfolioaptCluster, v : Double) -> FinanceportfolioaptCluster {
  let result = finance_portfolio_apt_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_cluster_min(s : FinanceportfolioaptCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_cluster_max(s : FinanceportfolioaptCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_cluster_to_string(s : FinanceportfolioaptCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_model_make(size : Int) -> FinanceportfolioaptModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_model_len(s : FinanceportfolioaptModel) -> Int { s.size }

pub fn finance_portfolio_apt_model_get(s : FinanceportfolioaptModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_model_set(s : FinanceportfolioaptModel, i : Int, v : Double) -> FinanceportfolioaptModel {
  let result = finance_portfolio_apt_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_model_sum(s : FinanceportfolioaptModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_apt_model_mean(s : FinanceportfolioaptModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_apt_model_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_apt_model_scale(s : FinanceportfolioaptModel, f : Double) -> FinanceportfolioaptModel {
  let result = finance_portfolio_apt_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_apt_model_add(a : FinanceportfolioaptModel, b : FinanceportfolioaptModel) -> FinanceportfolioaptModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_apt_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_apt_model_copy(s : FinanceportfolioaptModel) -> FinanceportfolioaptModel {
  let result = finance_portfolio_apt_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_apt_model_fill(s : FinanceportfolioaptModel, v : Double) -> FinanceportfolioaptModel {
  let result = finance_portfolio_apt_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_model_min(s : FinanceportfolioaptModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_model_max(s : FinanceportfolioaptModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_model_to_string(s : FinanceportfolioaptModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_layer_make(size : Int) -> FinanceportfolioaptLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_layer_len(s : FinanceportfolioaptLayer) -> Int { s.size }

pub fn finance_portfolio_apt_layer_get(s : FinanceportfolioaptLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_layer_set(s : FinanceportfolioaptLayer, i : Int, v : Double) -> FinanceportfolioaptLayer {
  let result = finance_portfolio_apt_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_layer_sum(s : FinanceportfolioaptLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_apt_layer_mean(s : FinanceportfolioaptLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_apt_layer_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_apt_layer_scale(s : FinanceportfolioaptLayer, f : Double) -> FinanceportfolioaptLayer {
  let result = finance_portfolio_apt_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_apt_layer_add(a : FinanceportfolioaptLayer, b : FinanceportfolioaptLayer) -> FinanceportfolioaptLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_apt_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_apt_layer_copy(s : FinanceportfolioaptLayer) -> FinanceportfolioaptLayer {
  let result = finance_portfolio_apt_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_apt_layer_fill(s : FinanceportfolioaptLayer, v : Double) -> FinanceportfolioaptLayer {
  let result = finance_portfolio_apt_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_layer_min(s : FinanceportfolioaptLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_layer_max(s : FinanceportfolioaptLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_layer_to_string(s : FinanceportfolioaptLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_buffer_make(size : Int) -> FinanceportfolioaptBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_buffer_len(s : FinanceportfolioaptBuffer) -> Int { s.size }

pub fn finance_portfolio_apt_buffer_get(s : FinanceportfolioaptBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_buffer_set(s : FinanceportfolioaptBuffer, i : Int, v : Double) -> FinanceportfolioaptBuffer {
  let result = finance_portfolio_apt_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_buffer_sum(s : FinanceportfolioaptBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_apt_buffer_mean(s : FinanceportfolioaptBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_apt_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_apt_buffer_scale(s : FinanceportfolioaptBuffer, f : Double) -> FinanceportfolioaptBuffer {
  let result = finance_portfolio_apt_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_apt_buffer_add(a : FinanceportfolioaptBuffer, b : FinanceportfolioaptBuffer) -> FinanceportfolioaptBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_apt_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_apt_buffer_copy(s : FinanceportfolioaptBuffer) -> FinanceportfolioaptBuffer {
  let result = finance_portfolio_apt_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_apt_buffer_fill(s : FinanceportfolioaptBuffer, v : Double) -> FinanceportfolioaptBuffer {
  let result = finance_portfolio_apt_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_buffer_min(s : FinanceportfolioaptBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_buffer_max(s : FinanceportfolioaptBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_buffer_to_string(s : FinanceportfolioaptBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_cursor_make(size : Int) -> FinanceportfolioaptCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_cursor_len(s : FinanceportfolioaptCursor) -> Int { s.size }

pub fn finance_portfolio_apt_cursor_get(s : FinanceportfolioaptCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_cursor_set(s : FinanceportfolioaptCursor, i : Int, v : Double) -> FinanceportfolioaptCursor {
  let result = finance_portfolio_apt_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_cursor_sum(s : FinanceportfolioaptCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_apt_cursor_mean(s : FinanceportfolioaptCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_apt_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_apt_cursor_scale(s : FinanceportfolioaptCursor, f : Double) -> FinanceportfolioaptCursor {
  let result = finance_portfolio_apt_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_apt_cursor_add(a : FinanceportfolioaptCursor, b : FinanceportfolioaptCursor) -> FinanceportfolioaptCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_apt_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_apt_cursor_copy(s : FinanceportfolioaptCursor) -> FinanceportfolioaptCursor {
  let result = finance_portfolio_apt_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_apt_cursor_fill(s : FinanceportfolioaptCursor, v : Double) -> FinanceportfolioaptCursor {
  let result = finance_portfolio_apt_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_cursor_min(s : FinanceportfolioaptCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_cursor_max(s : FinanceportfolioaptCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_cursor_to_string(s : FinanceportfolioaptCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_view_make(size : Int) -> FinanceportfolioaptView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_view_len(s : FinanceportfolioaptView) -> Int { s.size }

pub fn finance_portfolio_apt_view_get(s : FinanceportfolioaptView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_view_set(s : FinanceportfolioaptView, i : Int, v : Double) -> FinanceportfolioaptView {
  let result = finance_portfolio_apt_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_view_sum(s : FinanceportfolioaptView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_apt_view_mean(s : FinanceportfolioaptView) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_apt_view_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_apt_view_scale(s : FinanceportfolioaptView, f : Double) -> FinanceportfolioaptView {
  let result = finance_portfolio_apt_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_apt_view_add(a : FinanceportfolioaptView, b : FinanceportfolioaptView) -> FinanceportfolioaptView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_apt_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_apt_view_copy(s : FinanceportfolioaptView) -> FinanceportfolioaptView {
  let result = finance_portfolio_apt_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_apt_view_fill(s : FinanceportfolioaptView, v : Double) -> FinanceportfolioaptView {
  let result = finance_portfolio_apt_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_view_min(s : FinanceportfolioaptView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_view_max(s : FinanceportfolioaptView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_view_to_string(s : FinanceportfolioaptView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_range_make(size : Int) -> FinanceportfolioaptRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_range_len(s : FinanceportfolioaptRange) -> Int { s.size }

pub fn finance_portfolio_apt_range_get(s : FinanceportfolioaptRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_range_set(s : FinanceportfolioaptRange, i : Int, v : Double) -> FinanceportfolioaptRange {
  let result = finance_portfolio_apt_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_range_sum(s : FinanceportfolioaptRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_apt_range_mean(s : FinanceportfolioaptRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_apt_range_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_apt_range_scale(s : FinanceportfolioaptRange, f : Double) -> FinanceportfolioaptRange {
  let result = finance_portfolio_apt_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_apt_range_add(a : FinanceportfolioaptRange, b : FinanceportfolioaptRange) -> FinanceportfolioaptRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_apt_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_apt_range_copy(s : FinanceportfolioaptRange) -> FinanceportfolioaptRange {
  let result = finance_portfolio_apt_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_apt_range_fill(s : FinanceportfolioaptRange, v : Double) -> FinanceportfolioaptRange {
  let result = finance_portfolio_apt_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_range_min(s : FinanceportfolioaptRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_range_max(s : FinanceportfolioaptRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_range_to_string(s : FinanceportfolioaptRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_slice_make(size : Int) -> FinanceportfolioaptSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_slice_len(s : FinanceportfolioaptSlice) -> Int { s.size }

pub fn finance_portfolio_apt_slice_get(s : FinanceportfolioaptSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_slice_set(s : FinanceportfolioaptSlice, i : Int, v : Double) -> FinanceportfolioaptSlice {
  let result = finance_portfolio_apt_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_slice_sum(s : FinanceportfolioaptSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_apt_slice_mean(s : FinanceportfolioaptSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_apt_slice_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_apt_slice_scale(s : FinanceportfolioaptSlice, f : Double) -> FinanceportfolioaptSlice {
  let result = finance_portfolio_apt_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_apt_slice_add(a : FinanceportfolioaptSlice, b : FinanceportfolioaptSlice) -> FinanceportfolioaptSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_apt_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_apt_slice_copy(s : FinanceportfolioaptSlice) -> FinanceportfolioaptSlice {
  let result = finance_portfolio_apt_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_apt_slice_fill(s : FinanceportfolioaptSlice, v : Double) -> FinanceportfolioaptSlice {
  let result = finance_portfolio_apt_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_apt_slice_min(s : FinanceportfolioaptSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_slice_max(s : FinanceportfolioaptSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_apt_slice_to_string(s : FinanceportfolioaptSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn finance_portfolio_apt_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_apt_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_apt_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_apt_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_apt_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_apt_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_apt_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_apt_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_apt_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_apt_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_apt_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_apt_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_apt_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_apt_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_apt_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_apt_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_apt_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_apt_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_apt_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_apt_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_apt_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_apt_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_apt_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_apt_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_apt_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

