///===
/// extcore/finance_portfolio_markowitz

pub(all) struct FinanceportfoliomarkowitzPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_portfolio_markowitz_make_point(x : Double, y : Double) -> FinanceportfoliomarkowitzPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_portfolio_markowitz_make_point3(x : Double, y : Double, z : Double) -> FinanceportfoliomarkowitzPoint {
  { x, y, z, label: 0 }
}

pub fn finance_portfolio_markowitz_point_x(pt : FinanceportfoliomarkowitzPoint) -> Double { pt.x }

pub fn finance_portfolio_markowitz_point_y(pt : FinanceportfoliomarkowitzPoint) -> Double { pt.y }

pub fn finance_portfolio_markowitz_point_z(pt : FinanceportfoliomarkowitzPoint) -> Double { pt.z }

pub fn finance_portfolio_markowitz_point_label(pt : FinanceportfoliomarkowitzPoint) -> Int { pt.label }

pub fn finance_portfolio_markowitz_point_dist(a : FinanceportfoliomarkowitzPoint, b : FinanceportfoliomarkowitzPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  finance_portfolio_markowitz_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_portfolio_markowitz_point_add(a : FinanceportfoliomarkowitzPoint, b : FinanceportfoliomarkowitzPoint) -> FinanceportfoliomarkowitzPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_portfolio_markowitz_point_sub(a : FinanceportfoliomarkowitzPoint, b : FinanceportfoliomarkowitzPoint) -> FinanceportfoliomarkowitzPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_portfolio_markowitz_point_scale(pt : FinanceportfoliomarkowitzPoint, s : Double) -> FinanceportfoliomarkowitzPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_portfolio_markowitz_point_dot(a : FinanceportfoliomarkowitzPoint, b : FinanceportfoliomarkowitzPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_portfolio_markowitz_point_cross(a : FinanceportfoliomarkowitzPoint, b : FinanceportfoliomarkowitzPoint) -> FinanceportfoliomarkowitzPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_portfolio_markowitz_point_norm(pt : FinanceportfoliomarkowitzPoint) -> Double {
  finance_portfolio_markowitz_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_portfolio_markowitz_point_normalize(pt : FinanceportfoliomarkowitzPoint) -> FinanceportfoliomarkowitzPoint {
  let n = finance_portfolio_markowitz_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_portfolio_markowitz_point_scale(pt, 1.0 / n) }
}

pub fn finance_portfolio_markowitz_point_negate(pt : FinanceportfoliomarkowitzPoint) -> FinanceportfoliomarkowitzPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_portfolio_markowitz_point_mid(a : FinanceportfoliomarkowitzPoint, b : FinanceportfoliomarkowitzPoint) -> FinanceportfoliomarkowitzPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_portfolio_markowitz_point_lerp(a : FinanceportfoliomarkowitzPoint, b : FinanceportfoliomarkowitzPoint, t : Double) -> FinanceportfoliomarkowitzPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_portfolio_markowitz_point_to_string(pt : FinanceportfoliomarkowitzPoint) -> String {
  "(" + finance_portfolio_markowitz_dbl(pt.x) + ", " + finance_portfolio_markowitz_dbl(pt.y) + ", " + finance_portfolio_markowitz_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_portfolio_markowitz_make_series(vals : Array[Double], name : String) -> FinanceportfoliomarkowitzSeries {
  { vals, name, meta: 0 }
}

pub fn finance_portfolio_markowitz_series_len(s : FinanceportfoliomarkowitzSeries) -> Int { s.vals.length() }

pub fn finance_portfolio_markowitz_series_sum(s : FinanceportfoliomarkowitzSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_portfolio_markowitz_series_mean(s : FinanceportfoliomarkowitzSeries) -> Double {
  let n = finance_portfolio_markowitz_series_len(s)
  if n == 0 { 0.0 } else { finance_portfolio_markowitz_series_sum(s) / n.to_double() }
}

pub fn finance_portfolio_markowitz_series_min(s : FinanceportfoliomarkowitzSeries) -> Double {
  let n = finance_portfolio_markowitz_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_series_max(s : FinanceportfoliomarkowitzSeries) -> Double {
  let n = finance_portfolio_markowitz_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_series_range(s : FinanceportfoliomarkowitzSeries) -> Double {
  finance_portfolio_markowitz_series_max(s) - finance_portfolio_markowitz_series_min(s)
}

pub fn finance_portfolio_markowitz_series_var(s : FinanceportfoliomarkowitzSeries) -> Double {
  let n = finance_portfolio_markowitz_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_portfolio_markowitz_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_series_std(s : FinanceportfoliomarkowitzSeries) -> Double { finance_portfolio_markowitz_sqrt(finance_portfolio_markowitz_series_var(s)) }

pub fn finance_portfolio_markowitz_series_median(s : FinanceportfoliomarkowitzSeries) -> Double {
  let n = finance_portfolio_markowitz_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_portfolio_markowitz_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_portfolio_markowitz_series_scale(s : FinanceportfoliomarkowitzSeries, f : Double) -> FinanceportfoliomarkowitzSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = finance_portfolio_markowitz_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_portfolio_markowitz_series_add(a : FinanceportfoliomarkowitzSeries, b : FinanceportfoliomarkowitzSeries) -> FinanceportfoliomarkowitzSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_portfolio_markowitz_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_portfolio_markowitz_series_sub(a : FinanceportfoliomarkowitzSeries, b : FinanceportfoliomarkowitzSeries) -> FinanceportfoliomarkowitzSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_portfolio_markowitz_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_portfolio_markowitz_series_normalize(s : FinanceportfoliomarkowitzSeries) -> FinanceportfoliomarkowitzSeries {
  let mn = finance_portfolio_markowitz_series_min(s)
  let mx = finance_portfolio_markowitz_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = finance_portfolio_markowitz_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_portfolio_markowitz_series_cumsum(s : FinanceportfoliomarkowitzSeries) -> FinanceportfoliomarkowitzSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = finance_portfolio_markowitz_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_portfolio_markowitz_series_to_string(s : FinanceportfoliomarkowitzSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_portfolio_markowitz_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfoliomarkowitzMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_portfolio_markowitz_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceportfoliomarkowitzMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_portfolio_markowitz_matrix_identity(n : Int) -> FinanceportfoliomarkowitzMatrix {
  let m = finance_portfolio_markowitz_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_portfolio_markowitz_matrix_get(m : FinanceportfoliomarkowitzMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_portfolio_markowitz_matrix_transpose(m : FinanceportfoliomarkowitzMatrix) -> FinanceportfoliomarkowitzMatrix {
  let result = finance_portfolio_markowitz_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_portfolio_markowitz_matrix_add(a : FinanceportfoliomarkowitzMatrix, b : FinanceportfoliomarkowitzMatrix) -> FinanceportfoliomarkowitzMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_portfolio_markowitz_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_portfolio_markowitz_matrix_scale(m : FinanceportfoliomarkowitzMatrix, s : Double) -> FinanceportfoliomarkowitzMatrix {
  let result = finance_portfolio_markowitz_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_portfolio_markowitz_matrix_multiply(a : FinanceportfoliomarkowitzMatrix, b : FinanceportfoliomarkowitzMatrix) -> FinanceportfoliomarkowitzMatrix {
  if a.cols != b.rows { return finance_portfolio_markowitz_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_portfolio_markowitz_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_portfolio_markowitz_matrix_trace(m : FinanceportfoliomarkowitzMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_portfolio_markowitz_matrix_det(m : FinanceportfoliomarkowitzMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_portfolio_markowitz_matrix_norm(m : FinanceportfoliomarkowitzMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  finance_portfolio_markowitz_sqrt(sum)
}

pub fn finance_portfolio_markowitz_matrix_to_string(m : FinanceportfoliomarkowitzMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + finance_portfolio_markowitz_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct FinanceportfoliomarkowitzVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_portfolio_markowitz_make_vector(comps : Array[Double]) -> FinanceportfoliomarkowitzVector {
  { comps, dim: comps.length() }
}

pub fn finance_portfolio_markowitz_vector_zero(dim : Int) -> FinanceportfoliomarkowitzVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_portfolio_markowitz_vector_add(a : FinanceportfoliomarkowitzVector, b : FinanceportfoliomarkowitzVector) -> FinanceportfoliomarkowitzVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_portfolio_markowitz_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_portfolio_markowitz_vector_sub(a : FinanceportfoliomarkowitzVector, b : FinanceportfoliomarkowitzVector) -> FinanceportfoliomarkowitzVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_portfolio_markowitz_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_portfolio_markowitz_vector_scale(v : FinanceportfoliomarkowitzVector, s : Double) -> FinanceportfoliomarkowitzVector {
  let mut result = []
  for i in 0..<v.dim { result = finance_portfolio_markowitz_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_portfolio_markowitz_vector_dot(a : FinanceportfoliomarkowitzVector, b : FinanceportfoliomarkowitzVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_portfolio_markowitz_vector_norm(v : FinanceportfoliomarkowitzVector) -> Double { finance_portfolio_markowitz_sqrt(finance_portfolio_markowitz_vector_dot(v, v)) }

pub fn finance_portfolio_markowitz_vector_normalize(v : FinanceportfoliomarkowitzVector) -> FinanceportfoliomarkowitzVector {
  let n = finance_portfolio_markowitz_vector_norm(v)
  if n < 0.0000001 { v } else { finance_portfolio_markowitz_vector_scale(v, 1.0 / n) }
}

pub fn finance_portfolio_markowitz_vector_dist(a : FinanceportfoliomarkowitzVector, b : FinanceportfoliomarkowitzVector) -> Double {
  finance_portfolio_markowitz_vector_norm(finance_portfolio_markowitz_vector_sub(a, b))
}

pub fn finance_portfolio_markowitz_vector_to_string(v : FinanceportfoliomarkowitzVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_portfolio_markowitz_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_portfolio_markowitz_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = finance_portfolio_markowitz_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_std(data : Array[Double]) -> Double { finance_portfolio_markowitz_sqrt(finance_portfolio_markowitz_var(data)) }

pub fn finance_portfolio_markowitz_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = finance_portfolio_markowitz_mean(a); let mb = finance_portfolio_markowitz_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = finance_portfolio_markowitz_std(a); let sb = finance_portfolio_markowitz_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { finance_portfolio_markowitz_cov(a, b) / (sa * sb) }
}

pub fn finance_portfolio_markowitz_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = finance_portfolio_markowitz_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_portfolio_markowitz_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  finance_portfolio_markowitz_sqrt(finance_portfolio_markowitz_mse(pred, labels))
}

pub fn finance_portfolio_markowitz_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + finance_portfolio_markowitz_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = finance_portfolio_markowitz_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn finance_portfolio_markowitz_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn finance_portfolio_markowitz_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn finance_portfolio_markowitz_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = finance_portfolio_markowitz_precision(pred, labels, pos); let r = finance_portfolio_markowitz_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn finance_portfolio_markowitz_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn finance_portfolio_markowitz_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = finance_portfolio_markowitz_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn finance_portfolio_markowitz_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn finance_portfolio_markowitz_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn finance_portfolio_markowitz_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = finance_portfolio_markowitz_gcd(a, b)
    (a / g) * b
  }
}

pub fn finance_portfolio_markowitz_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn finance_portfolio_markowitz_fibonacci(n : Int) -> Int {
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

pub fn finance_portfolio_markowitz_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = finance_portfolio_markowitz_min(data); let mx = finance_portfolio_markowitz_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn finance_portfolio_markowitz_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = finance_portfolio_markowitz_mean(data); let sd = finance_portfolio_markowitz_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn finance_portfolio_markowitz_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn finance_portfolio_markowitz_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn finance_portfolio_markowitz_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn finance_portfolio_markowitz_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn finance_portfolio_markowitz_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn finance_portfolio_markowitz_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn finance_portfolio_markowitz_dbl(x : Double) -> String {
  let i = if x >= 0.0 { finance_portfolio_markowitz_int(x) } else { -finance_portfolio_markowitz_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { finance_portfolio_markowitz_int(f * 1000000.0) } else { finance_portfolio_markowitz_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn finance_portfolio_markowitz_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn finance_portfolio_markowitz_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct FinanceportfoliomarkowitzFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_frame_make(size : Int) -> FinanceportfoliomarkowitzFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_frame_len(s : FinanceportfoliomarkowitzFrame) -> Int { s.size }

pub fn finance_portfolio_markowitz_frame_get(s : FinanceportfoliomarkowitzFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_frame_set(s : FinanceportfoliomarkowitzFrame, i : Int, v : Double) -> FinanceportfoliomarkowitzFrame {
  let result = finance_portfolio_markowitz_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_frame_sum(s : FinanceportfoliomarkowitzFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_markowitz_frame_mean(s : FinanceportfoliomarkowitzFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_markowitz_frame_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_markowitz_frame_scale(s : FinanceportfoliomarkowitzFrame, f : Double) -> FinanceportfoliomarkowitzFrame {
  let result = finance_portfolio_markowitz_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_markowitz_frame_add(a : FinanceportfoliomarkowitzFrame, b : FinanceportfoliomarkowitzFrame) -> FinanceportfoliomarkowitzFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_markowitz_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_markowitz_frame_copy(s : FinanceportfoliomarkowitzFrame) -> FinanceportfoliomarkowitzFrame {
  let result = finance_portfolio_markowitz_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_markowitz_frame_fill(s : FinanceportfoliomarkowitzFrame, v : Double) -> FinanceportfoliomarkowitzFrame {
  let result = finance_portfolio_markowitz_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_frame_min(s : FinanceportfoliomarkowitzFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_frame_max(s : FinanceportfoliomarkowitzFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_frame_to_string(s : FinanceportfoliomarkowitzFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_table_make(size : Int) -> FinanceportfoliomarkowitzTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_table_len(s : FinanceportfoliomarkowitzTable) -> Int { s.size }

pub fn finance_portfolio_markowitz_table_get(s : FinanceportfoliomarkowitzTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_table_set(s : FinanceportfoliomarkowitzTable, i : Int, v : Double) -> FinanceportfoliomarkowitzTable {
  let result = finance_portfolio_markowitz_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_table_sum(s : FinanceportfoliomarkowitzTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_markowitz_table_mean(s : FinanceportfoliomarkowitzTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_markowitz_table_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_markowitz_table_scale(s : FinanceportfoliomarkowitzTable, f : Double) -> FinanceportfoliomarkowitzTable {
  let result = finance_portfolio_markowitz_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_markowitz_table_add(a : FinanceportfoliomarkowitzTable, b : FinanceportfoliomarkowitzTable) -> FinanceportfoliomarkowitzTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_markowitz_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_markowitz_table_copy(s : FinanceportfoliomarkowitzTable) -> FinanceportfoliomarkowitzTable {
  let result = finance_portfolio_markowitz_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_markowitz_table_fill(s : FinanceportfoliomarkowitzTable, v : Double) -> FinanceportfoliomarkowitzTable {
  let result = finance_portfolio_markowitz_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_table_min(s : FinanceportfoliomarkowitzTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_table_max(s : FinanceportfoliomarkowitzTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_table_to_string(s : FinanceportfoliomarkowitzTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_graphn_make(size : Int) -> FinanceportfoliomarkowitzGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_graphn_len(s : FinanceportfoliomarkowitzGraphN) -> Int { s.size }

pub fn finance_portfolio_markowitz_graphn_get(s : FinanceportfoliomarkowitzGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_graphn_set(s : FinanceportfoliomarkowitzGraphN, i : Int, v : Double) -> FinanceportfoliomarkowitzGraphN {
  let result = finance_portfolio_markowitz_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_graphn_sum(s : FinanceportfoliomarkowitzGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_markowitz_graphn_mean(s : FinanceportfoliomarkowitzGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_markowitz_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_markowitz_graphn_scale(s : FinanceportfoliomarkowitzGraphN, f : Double) -> FinanceportfoliomarkowitzGraphN {
  let result = finance_portfolio_markowitz_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_markowitz_graphn_add(a : FinanceportfoliomarkowitzGraphN, b : FinanceportfoliomarkowitzGraphN) -> FinanceportfoliomarkowitzGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_markowitz_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_markowitz_graphn_copy(s : FinanceportfoliomarkowitzGraphN) -> FinanceportfoliomarkowitzGraphN {
  let result = finance_portfolio_markowitz_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_markowitz_graphn_fill(s : FinanceportfoliomarkowitzGraphN, v : Double) -> FinanceportfoliomarkowitzGraphN {
  let result = finance_portfolio_markowitz_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_graphn_min(s : FinanceportfoliomarkowitzGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_graphn_max(s : FinanceportfoliomarkowitzGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_graphn_to_string(s : FinanceportfoliomarkowitzGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_node_make(size : Int) -> FinanceportfoliomarkowitzNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_node_len(s : FinanceportfoliomarkowitzNode) -> Int { s.size }

pub fn finance_portfolio_markowitz_node_get(s : FinanceportfoliomarkowitzNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_node_set(s : FinanceportfoliomarkowitzNode, i : Int, v : Double) -> FinanceportfoliomarkowitzNode {
  let result = finance_portfolio_markowitz_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_node_sum(s : FinanceportfoliomarkowitzNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_markowitz_node_mean(s : FinanceportfoliomarkowitzNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_markowitz_node_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_markowitz_node_scale(s : FinanceportfoliomarkowitzNode, f : Double) -> FinanceportfoliomarkowitzNode {
  let result = finance_portfolio_markowitz_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_markowitz_node_add(a : FinanceportfoliomarkowitzNode, b : FinanceportfoliomarkowitzNode) -> FinanceportfoliomarkowitzNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_markowitz_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_markowitz_node_copy(s : FinanceportfoliomarkowitzNode) -> FinanceportfoliomarkowitzNode {
  let result = finance_portfolio_markowitz_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_markowitz_node_fill(s : FinanceportfoliomarkowitzNode, v : Double) -> FinanceportfoliomarkowitzNode {
  let result = finance_portfolio_markowitz_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_node_min(s : FinanceportfoliomarkowitzNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_node_max(s : FinanceportfoliomarkowitzNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_node_to_string(s : FinanceportfoliomarkowitzNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_edge_make(size : Int) -> FinanceportfoliomarkowitzEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_edge_len(s : FinanceportfoliomarkowitzEdge) -> Int { s.size }

pub fn finance_portfolio_markowitz_edge_get(s : FinanceportfoliomarkowitzEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_edge_set(s : FinanceportfoliomarkowitzEdge, i : Int, v : Double) -> FinanceportfoliomarkowitzEdge {
  let result = finance_portfolio_markowitz_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_edge_sum(s : FinanceportfoliomarkowitzEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_markowitz_edge_mean(s : FinanceportfoliomarkowitzEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_markowitz_edge_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_markowitz_edge_scale(s : FinanceportfoliomarkowitzEdge, f : Double) -> FinanceportfoliomarkowitzEdge {
  let result = finance_portfolio_markowitz_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_markowitz_edge_add(a : FinanceportfoliomarkowitzEdge, b : FinanceportfoliomarkowitzEdge) -> FinanceportfoliomarkowitzEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_markowitz_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_markowitz_edge_copy(s : FinanceportfoliomarkowitzEdge) -> FinanceportfoliomarkowitzEdge {
  let result = finance_portfolio_markowitz_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_markowitz_edge_fill(s : FinanceportfoliomarkowitzEdge, v : Double) -> FinanceportfoliomarkowitzEdge {
  let result = finance_portfolio_markowitz_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_edge_min(s : FinanceportfoliomarkowitzEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_edge_max(s : FinanceportfoliomarkowitzEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_edge_to_string(s : FinanceportfoliomarkowitzEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_path_make(size : Int) -> FinanceportfoliomarkowitzPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_path_len(s : FinanceportfoliomarkowitzPath) -> Int { s.size }

pub fn finance_portfolio_markowitz_path_get(s : FinanceportfoliomarkowitzPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_path_set(s : FinanceportfoliomarkowitzPath, i : Int, v : Double) -> FinanceportfoliomarkowitzPath {
  let result = finance_portfolio_markowitz_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_path_sum(s : FinanceportfoliomarkowitzPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_markowitz_path_mean(s : FinanceportfoliomarkowitzPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_markowitz_path_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_markowitz_path_scale(s : FinanceportfoliomarkowitzPath, f : Double) -> FinanceportfoliomarkowitzPath {
  let result = finance_portfolio_markowitz_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_markowitz_path_add(a : FinanceportfoliomarkowitzPath, b : FinanceportfoliomarkowitzPath) -> FinanceportfoliomarkowitzPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_markowitz_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_markowitz_path_copy(s : FinanceportfoliomarkowitzPath) -> FinanceportfoliomarkowitzPath {
  let result = finance_portfolio_markowitz_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_markowitz_path_fill(s : FinanceportfoliomarkowitzPath, v : Double) -> FinanceportfoliomarkowitzPath {
  let result = finance_portfolio_markowitz_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_path_min(s : FinanceportfoliomarkowitzPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_path_max(s : FinanceportfoliomarkowitzPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_path_to_string(s : FinanceportfoliomarkowitzPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_cluster_make(size : Int) -> FinanceportfoliomarkowitzCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_cluster_len(s : FinanceportfoliomarkowitzCluster) -> Int { s.size }

pub fn finance_portfolio_markowitz_cluster_get(s : FinanceportfoliomarkowitzCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_cluster_set(s : FinanceportfoliomarkowitzCluster, i : Int, v : Double) -> FinanceportfoliomarkowitzCluster {
  let result = finance_portfolio_markowitz_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_cluster_sum(s : FinanceportfoliomarkowitzCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_markowitz_cluster_mean(s : FinanceportfoliomarkowitzCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_markowitz_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_markowitz_cluster_scale(s : FinanceportfoliomarkowitzCluster, f : Double) -> FinanceportfoliomarkowitzCluster {
  let result = finance_portfolio_markowitz_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_markowitz_cluster_add(a : FinanceportfoliomarkowitzCluster, b : FinanceportfoliomarkowitzCluster) -> FinanceportfoliomarkowitzCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_markowitz_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_markowitz_cluster_copy(s : FinanceportfoliomarkowitzCluster) -> FinanceportfoliomarkowitzCluster {
  let result = finance_portfolio_markowitz_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_markowitz_cluster_fill(s : FinanceportfoliomarkowitzCluster, v : Double) -> FinanceportfoliomarkowitzCluster {
  let result = finance_portfolio_markowitz_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_cluster_min(s : FinanceportfoliomarkowitzCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_cluster_max(s : FinanceportfoliomarkowitzCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_cluster_to_string(s : FinanceportfoliomarkowitzCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_model_make(size : Int) -> FinanceportfoliomarkowitzModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_model_len(s : FinanceportfoliomarkowitzModel) -> Int { s.size }

pub fn finance_portfolio_markowitz_model_get(s : FinanceportfoliomarkowitzModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_model_set(s : FinanceportfoliomarkowitzModel, i : Int, v : Double) -> FinanceportfoliomarkowitzModel {
  let result = finance_portfolio_markowitz_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_model_sum(s : FinanceportfoliomarkowitzModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_markowitz_model_mean(s : FinanceportfoliomarkowitzModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_markowitz_model_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_markowitz_model_scale(s : FinanceportfoliomarkowitzModel, f : Double) -> FinanceportfoliomarkowitzModel {
  let result = finance_portfolio_markowitz_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_markowitz_model_add(a : FinanceportfoliomarkowitzModel, b : FinanceportfoliomarkowitzModel) -> FinanceportfoliomarkowitzModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_markowitz_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_markowitz_model_copy(s : FinanceportfoliomarkowitzModel) -> FinanceportfoliomarkowitzModel {
  let result = finance_portfolio_markowitz_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_markowitz_model_fill(s : FinanceportfoliomarkowitzModel, v : Double) -> FinanceportfoliomarkowitzModel {
  let result = finance_portfolio_markowitz_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_model_min(s : FinanceportfoliomarkowitzModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_model_max(s : FinanceportfoliomarkowitzModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_model_to_string(s : FinanceportfoliomarkowitzModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_layer_make(size : Int) -> FinanceportfoliomarkowitzLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_layer_len(s : FinanceportfoliomarkowitzLayer) -> Int { s.size }

pub fn finance_portfolio_markowitz_layer_get(s : FinanceportfoliomarkowitzLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_layer_set(s : FinanceportfoliomarkowitzLayer, i : Int, v : Double) -> FinanceportfoliomarkowitzLayer {
  let result = finance_portfolio_markowitz_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_layer_sum(s : FinanceportfoliomarkowitzLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_markowitz_layer_mean(s : FinanceportfoliomarkowitzLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_markowitz_layer_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_markowitz_layer_scale(s : FinanceportfoliomarkowitzLayer, f : Double) -> FinanceportfoliomarkowitzLayer {
  let result = finance_portfolio_markowitz_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_markowitz_layer_add(a : FinanceportfoliomarkowitzLayer, b : FinanceportfoliomarkowitzLayer) -> FinanceportfoliomarkowitzLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_markowitz_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_markowitz_layer_copy(s : FinanceportfoliomarkowitzLayer) -> FinanceportfoliomarkowitzLayer {
  let result = finance_portfolio_markowitz_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_markowitz_layer_fill(s : FinanceportfoliomarkowitzLayer, v : Double) -> FinanceportfoliomarkowitzLayer {
  let result = finance_portfolio_markowitz_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_layer_min(s : FinanceportfoliomarkowitzLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_layer_max(s : FinanceportfoliomarkowitzLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_layer_to_string(s : FinanceportfoliomarkowitzLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_buffer_make(size : Int) -> FinanceportfoliomarkowitzBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_buffer_len(s : FinanceportfoliomarkowitzBuffer) -> Int { s.size }

pub fn finance_portfolio_markowitz_buffer_get(s : FinanceportfoliomarkowitzBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_buffer_set(s : FinanceportfoliomarkowitzBuffer, i : Int, v : Double) -> FinanceportfoliomarkowitzBuffer {
  let result = finance_portfolio_markowitz_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_buffer_sum(s : FinanceportfoliomarkowitzBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_markowitz_buffer_mean(s : FinanceportfoliomarkowitzBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_markowitz_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_markowitz_buffer_scale(s : FinanceportfoliomarkowitzBuffer, f : Double) -> FinanceportfoliomarkowitzBuffer {
  let result = finance_portfolio_markowitz_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_markowitz_buffer_add(a : FinanceportfoliomarkowitzBuffer, b : FinanceportfoliomarkowitzBuffer) -> FinanceportfoliomarkowitzBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_markowitz_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_markowitz_buffer_copy(s : FinanceportfoliomarkowitzBuffer) -> FinanceportfoliomarkowitzBuffer {
  let result = finance_portfolio_markowitz_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_markowitz_buffer_fill(s : FinanceportfoliomarkowitzBuffer, v : Double) -> FinanceportfoliomarkowitzBuffer {
  let result = finance_portfolio_markowitz_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_buffer_min(s : FinanceportfoliomarkowitzBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_buffer_max(s : FinanceportfoliomarkowitzBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_buffer_to_string(s : FinanceportfoliomarkowitzBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_cursor_make(size : Int) -> FinanceportfoliomarkowitzCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_cursor_len(s : FinanceportfoliomarkowitzCursor) -> Int { s.size }

pub fn finance_portfolio_markowitz_cursor_get(s : FinanceportfoliomarkowitzCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_cursor_set(s : FinanceportfoliomarkowitzCursor, i : Int, v : Double) -> FinanceportfoliomarkowitzCursor {
  let result = finance_portfolio_markowitz_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_cursor_sum(s : FinanceportfoliomarkowitzCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_markowitz_cursor_mean(s : FinanceportfoliomarkowitzCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_markowitz_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_markowitz_cursor_scale(s : FinanceportfoliomarkowitzCursor, f : Double) -> FinanceportfoliomarkowitzCursor {
  let result = finance_portfolio_markowitz_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_markowitz_cursor_add(a : FinanceportfoliomarkowitzCursor, b : FinanceportfoliomarkowitzCursor) -> FinanceportfoliomarkowitzCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_markowitz_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_markowitz_cursor_copy(s : FinanceportfoliomarkowitzCursor) -> FinanceportfoliomarkowitzCursor {
  let result = finance_portfolio_markowitz_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_markowitz_cursor_fill(s : FinanceportfoliomarkowitzCursor, v : Double) -> FinanceportfoliomarkowitzCursor {
  let result = finance_portfolio_markowitz_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_cursor_min(s : FinanceportfoliomarkowitzCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_cursor_max(s : FinanceportfoliomarkowitzCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_cursor_to_string(s : FinanceportfoliomarkowitzCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_view_make(size : Int) -> FinanceportfoliomarkowitzView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_view_len(s : FinanceportfoliomarkowitzView) -> Int { s.size }

pub fn finance_portfolio_markowitz_view_get(s : FinanceportfoliomarkowitzView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_view_set(s : FinanceportfoliomarkowitzView, i : Int, v : Double) -> FinanceportfoliomarkowitzView {
  let result = finance_portfolio_markowitz_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_view_sum(s : FinanceportfoliomarkowitzView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_markowitz_view_mean(s : FinanceportfoliomarkowitzView) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_markowitz_view_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_markowitz_view_scale(s : FinanceportfoliomarkowitzView, f : Double) -> FinanceportfoliomarkowitzView {
  let result = finance_portfolio_markowitz_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_markowitz_view_add(a : FinanceportfoliomarkowitzView, b : FinanceportfoliomarkowitzView) -> FinanceportfoliomarkowitzView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_markowitz_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_markowitz_view_copy(s : FinanceportfoliomarkowitzView) -> FinanceportfoliomarkowitzView {
  let result = finance_portfolio_markowitz_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_markowitz_view_fill(s : FinanceportfoliomarkowitzView, v : Double) -> FinanceportfoliomarkowitzView {
  let result = finance_portfolio_markowitz_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_view_min(s : FinanceportfoliomarkowitzView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_view_max(s : FinanceportfoliomarkowitzView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_view_to_string(s : FinanceportfoliomarkowitzView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_range_make(size : Int) -> FinanceportfoliomarkowitzRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_range_len(s : FinanceportfoliomarkowitzRange) -> Int { s.size }

pub fn finance_portfolio_markowitz_range_get(s : FinanceportfoliomarkowitzRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_range_set(s : FinanceportfoliomarkowitzRange, i : Int, v : Double) -> FinanceportfoliomarkowitzRange {
  let result = finance_portfolio_markowitz_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_range_sum(s : FinanceportfoliomarkowitzRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_markowitz_range_mean(s : FinanceportfoliomarkowitzRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_markowitz_range_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_markowitz_range_scale(s : FinanceportfoliomarkowitzRange, f : Double) -> FinanceportfoliomarkowitzRange {
  let result = finance_portfolio_markowitz_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_markowitz_range_add(a : FinanceportfoliomarkowitzRange, b : FinanceportfoliomarkowitzRange) -> FinanceportfoliomarkowitzRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_markowitz_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_markowitz_range_copy(s : FinanceportfoliomarkowitzRange) -> FinanceportfoliomarkowitzRange {
  let result = finance_portfolio_markowitz_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_markowitz_range_fill(s : FinanceportfoliomarkowitzRange, v : Double) -> FinanceportfoliomarkowitzRange {
  let result = finance_portfolio_markowitz_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_range_min(s : FinanceportfoliomarkowitzRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_range_max(s : FinanceportfoliomarkowitzRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_range_to_string(s : FinanceportfoliomarkowitzRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_slice_make(size : Int) -> FinanceportfoliomarkowitzSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_slice_len(s : FinanceportfoliomarkowitzSlice) -> Int { s.size }

pub fn finance_portfolio_markowitz_slice_get(s : FinanceportfoliomarkowitzSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_slice_set(s : FinanceportfoliomarkowitzSlice, i : Int, v : Double) -> FinanceportfoliomarkowitzSlice {
  let result = finance_portfolio_markowitz_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_slice_sum(s : FinanceportfoliomarkowitzSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_markowitz_slice_mean(s : FinanceportfoliomarkowitzSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_markowitz_slice_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_markowitz_slice_scale(s : FinanceportfoliomarkowitzSlice, f : Double) -> FinanceportfoliomarkowitzSlice {
  let result = finance_portfolio_markowitz_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_markowitz_slice_add(a : FinanceportfoliomarkowitzSlice, b : FinanceportfoliomarkowitzSlice) -> FinanceportfoliomarkowitzSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_markowitz_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_markowitz_slice_copy(s : FinanceportfoliomarkowitzSlice) -> FinanceportfoliomarkowitzSlice {
  let result = finance_portfolio_markowitz_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_markowitz_slice_fill(s : FinanceportfoliomarkowitzSlice, v : Double) -> FinanceportfoliomarkowitzSlice {
  let result = finance_portfolio_markowitz_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_markowitz_slice_min(s : FinanceportfoliomarkowitzSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_slice_max(s : FinanceportfoliomarkowitzSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_markowitz_slice_to_string(s : FinanceportfoliomarkowitzSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn finance_portfolio_markowitz_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_markowitz_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

