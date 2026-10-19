///===
/// extcore/finance_portfolio_robust

pub(all) struct FinanceportfoliorobustPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_portfolio_robust_make_point(x : Double, y : Double) -> FinanceportfoliorobustPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_portfolio_robust_make_point3(x : Double, y : Double, z : Double) -> FinanceportfoliorobustPoint {
  { x, y, z, label: 0 }
}

pub fn finance_portfolio_robust_point_x(pt : FinanceportfoliorobustPoint) -> Double { pt.x }

pub fn finance_portfolio_robust_point_y(pt : FinanceportfoliorobustPoint) -> Double { pt.y }

pub fn finance_portfolio_robust_point_z(pt : FinanceportfoliorobustPoint) -> Double { pt.z }

pub fn finance_portfolio_robust_point_label(pt : FinanceportfoliorobustPoint) -> Int { pt.label }

pub fn finance_portfolio_robust_point_dist(a : FinanceportfoliorobustPoint, b : FinanceportfoliorobustPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  finance_portfolio_robust_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_portfolio_robust_point_add(a : FinanceportfoliorobustPoint, b : FinanceportfoliorobustPoint) -> FinanceportfoliorobustPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_portfolio_robust_point_sub(a : FinanceportfoliorobustPoint, b : FinanceportfoliorobustPoint) -> FinanceportfoliorobustPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_portfolio_robust_point_scale(pt : FinanceportfoliorobustPoint, s : Double) -> FinanceportfoliorobustPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_portfolio_robust_point_dot(a : FinanceportfoliorobustPoint, b : FinanceportfoliorobustPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_portfolio_robust_point_cross(a : FinanceportfoliorobustPoint, b : FinanceportfoliorobustPoint) -> FinanceportfoliorobustPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_portfolio_robust_point_norm(pt : FinanceportfoliorobustPoint) -> Double {
  finance_portfolio_robust_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_portfolio_robust_point_normalize(pt : FinanceportfoliorobustPoint) -> FinanceportfoliorobustPoint {
  let n = finance_portfolio_robust_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_portfolio_robust_point_scale(pt, 1.0 / n) }
}

pub fn finance_portfolio_robust_point_negate(pt : FinanceportfoliorobustPoint) -> FinanceportfoliorobustPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_portfolio_robust_point_mid(a : FinanceportfoliorobustPoint, b : FinanceportfoliorobustPoint) -> FinanceportfoliorobustPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_portfolio_robust_point_lerp(a : FinanceportfoliorobustPoint, b : FinanceportfoliorobustPoint, t : Double) -> FinanceportfoliorobustPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_portfolio_robust_point_to_string(pt : FinanceportfoliorobustPoint) -> String {
  "(" + finance_portfolio_robust_dbl(pt.x) + ", " + finance_portfolio_robust_dbl(pt.y) + ", " + finance_portfolio_robust_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_portfolio_robust_make_series(vals : Array[Double], name : String) -> FinanceportfoliorobustSeries {
  { vals, name, meta: 0 }
}

pub fn finance_portfolio_robust_series_len(s : FinanceportfoliorobustSeries) -> Int { s.vals.length() }

pub fn finance_portfolio_robust_series_sum(s : FinanceportfoliorobustSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_portfolio_robust_series_mean(s : FinanceportfoliorobustSeries) -> Double {
  let n = finance_portfolio_robust_series_len(s)
  if n == 0 { 0.0 } else { finance_portfolio_robust_series_sum(s) / n.to_double() }
}

pub fn finance_portfolio_robust_series_min(s : FinanceportfoliorobustSeries) -> Double {
  let n = finance_portfolio_robust_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_portfolio_robust_series_max(s : FinanceportfoliorobustSeries) -> Double {
  let n = finance_portfolio_robust_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_portfolio_robust_series_range(s : FinanceportfoliorobustSeries) -> Double {
  finance_portfolio_robust_series_max(s) - finance_portfolio_robust_series_min(s)
}

pub fn finance_portfolio_robust_series_var(s : FinanceportfoliorobustSeries) -> Double {
  let n = finance_portfolio_robust_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_portfolio_robust_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_portfolio_robust_series_std(s : FinanceportfoliorobustSeries) -> Double { finance_portfolio_robust_sqrt(finance_portfolio_robust_series_var(s)) }

pub fn finance_portfolio_robust_series_median(s : FinanceportfoliorobustSeries) -> Double {
  let n = finance_portfolio_robust_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_portfolio_robust_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_portfolio_robust_series_scale(s : FinanceportfoliorobustSeries, f : Double) -> FinanceportfoliorobustSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = finance_portfolio_robust_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_portfolio_robust_series_add(a : FinanceportfoliorobustSeries, b : FinanceportfoliorobustSeries) -> FinanceportfoliorobustSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_portfolio_robust_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_portfolio_robust_series_sub(a : FinanceportfoliorobustSeries, b : FinanceportfoliorobustSeries) -> FinanceportfoliorobustSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_portfolio_robust_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_portfolio_robust_series_normalize(s : FinanceportfoliorobustSeries) -> FinanceportfoliorobustSeries {
  let mn = finance_portfolio_robust_series_min(s)
  let mx = finance_portfolio_robust_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = finance_portfolio_robust_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_portfolio_robust_series_cumsum(s : FinanceportfoliorobustSeries) -> FinanceportfoliorobustSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = finance_portfolio_robust_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_portfolio_robust_series_to_string(s : FinanceportfoliorobustSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_portfolio_robust_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfoliorobustMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_portfolio_robust_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceportfoliorobustMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_portfolio_robust_matrix_identity(n : Int) -> FinanceportfoliorobustMatrix {
  let m = finance_portfolio_robust_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_portfolio_robust_matrix_get(m : FinanceportfoliorobustMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_portfolio_robust_matrix_transpose(m : FinanceportfoliorobustMatrix) -> FinanceportfoliorobustMatrix {
  let result = finance_portfolio_robust_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_portfolio_robust_matrix_add(a : FinanceportfoliorobustMatrix, b : FinanceportfoliorobustMatrix) -> FinanceportfoliorobustMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_portfolio_robust_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_portfolio_robust_matrix_scale(m : FinanceportfoliorobustMatrix, s : Double) -> FinanceportfoliorobustMatrix {
  let result = finance_portfolio_robust_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_portfolio_robust_matrix_multiply(a : FinanceportfoliorobustMatrix, b : FinanceportfoliorobustMatrix) -> FinanceportfoliorobustMatrix {
  if a.cols != b.rows { return finance_portfolio_robust_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_portfolio_robust_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_portfolio_robust_matrix_trace(m : FinanceportfoliorobustMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_portfolio_robust_matrix_det(m : FinanceportfoliorobustMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_portfolio_robust_matrix_norm(m : FinanceportfoliorobustMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  finance_portfolio_robust_sqrt(sum)
}

pub fn finance_portfolio_robust_matrix_to_string(m : FinanceportfoliorobustMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + finance_portfolio_robust_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct FinanceportfoliorobustVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_portfolio_robust_make_vector(comps : Array[Double]) -> FinanceportfoliorobustVector {
  { comps, dim: comps.length() }
}

pub fn finance_portfolio_robust_vector_zero(dim : Int) -> FinanceportfoliorobustVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_portfolio_robust_vector_add(a : FinanceportfoliorobustVector, b : FinanceportfoliorobustVector) -> FinanceportfoliorobustVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_portfolio_robust_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_portfolio_robust_vector_sub(a : FinanceportfoliorobustVector, b : FinanceportfoliorobustVector) -> FinanceportfoliorobustVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_portfolio_robust_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_portfolio_robust_vector_scale(v : FinanceportfoliorobustVector, s : Double) -> FinanceportfoliorobustVector {
  let mut result = []
  for i in 0..<v.dim { result = finance_portfolio_robust_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_portfolio_robust_vector_dot(a : FinanceportfoliorobustVector, b : FinanceportfoliorobustVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_portfolio_robust_vector_norm(v : FinanceportfoliorobustVector) -> Double { finance_portfolio_robust_sqrt(finance_portfolio_robust_vector_dot(v, v)) }

pub fn finance_portfolio_robust_vector_normalize(v : FinanceportfoliorobustVector) -> FinanceportfoliorobustVector {
  let n = finance_portfolio_robust_vector_norm(v)
  if n < 0.0000001 { v } else { finance_portfolio_robust_vector_scale(v, 1.0 / n) }
}

pub fn finance_portfolio_robust_vector_dist(a : FinanceportfoliorobustVector, b : FinanceportfoliorobustVector) -> Double {
  finance_portfolio_robust_vector_norm(finance_portfolio_robust_vector_sub(a, b))
}

pub fn finance_portfolio_robust_vector_to_string(v : FinanceportfoliorobustVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_portfolio_robust_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_portfolio_robust_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_robust_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = finance_portfolio_robust_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_robust_std(data : Array[Double]) -> Double { finance_portfolio_robust_sqrt(finance_portfolio_robust_var(data)) }

pub fn finance_portfolio_robust_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = finance_portfolio_robust_mean(a); let mb = finance_portfolio_robust_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_robust_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = finance_portfolio_robust_std(a); let sb = finance_portfolio_robust_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { finance_portfolio_robust_cov(a, b) / (sa * sb) }
}

pub fn finance_portfolio_robust_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = finance_portfolio_robust_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_portfolio_robust_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn finance_portfolio_robust_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_robust_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  finance_portfolio_robust_sqrt(finance_portfolio_robust_mse(pred, labels))
}

pub fn finance_portfolio_robust_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + finance_portfolio_robust_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_robust_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = finance_portfolio_robust_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn finance_portfolio_robust_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn finance_portfolio_robust_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn finance_portfolio_robust_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = finance_portfolio_robust_precision(pred, labels, pos); let r = finance_portfolio_robust_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn finance_portfolio_robust_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn finance_portfolio_robust_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = finance_portfolio_robust_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn finance_portfolio_robust_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn finance_portfolio_robust_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn finance_portfolio_robust_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = finance_portfolio_robust_gcd(a, b)
    (a / g) * b
  }
}

pub fn finance_portfolio_robust_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn finance_portfolio_robust_fibonacci(n : Int) -> Int {
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

pub fn finance_portfolio_robust_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = finance_portfolio_robust_min(data); let mx = finance_portfolio_robust_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn finance_portfolio_robust_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = finance_portfolio_robust_mean(data); let sd = finance_portfolio_robust_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn finance_portfolio_robust_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn finance_portfolio_robust_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn finance_portfolio_robust_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn finance_portfolio_robust_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn finance_portfolio_robust_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn finance_portfolio_robust_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn finance_portfolio_robust_dbl(x : Double) -> String {
  let i = if x >= 0.0 { finance_portfolio_robust_int(x) } else { -finance_portfolio_robust_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { finance_portfolio_robust_int(f * 1000000.0) } else { finance_portfolio_robust_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn finance_portfolio_robust_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn finance_portfolio_robust_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct FinanceportfoliorobustFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_frame_make(size : Int) -> FinanceportfoliorobustFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_frame_len(s : FinanceportfoliorobustFrame) -> Int { s.size }

pub fn finance_portfolio_robust_frame_get(s : FinanceportfoliorobustFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_frame_set(s : FinanceportfoliorobustFrame, i : Int, v : Double) -> FinanceportfoliorobustFrame {
  let result = finance_portfolio_robust_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_frame_sum(s : FinanceportfoliorobustFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_robust_frame_mean(s : FinanceportfoliorobustFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_robust_frame_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_robust_frame_scale(s : FinanceportfoliorobustFrame, f : Double) -> FinanceportfoliorobustFrame {
  let result = finance_portfolio_robust_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_robust_frame_add(a : FinanceportfoliorobustFrame, b : FinanceportfoliorobustFrame) -> FinanceportfoliorobustFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_robust_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_robust_frame_copy(s : FinanceportfoliorobustFrame) -> FinanceportfoliorobustFrame {
  let result = finance_portfolio_robust_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_robust_frame_fill(s : FinanceportfoliorobustFrame, v : Double) -> FinanceportfoliorobustFrame {
  let result = finance_portfolio_robust_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_frame_min(s : FinanceportfoliorobustFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_frame_max(s : FinanceportfoliorobustFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_frame_to_string(s : FinanceportfoliorobustFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_table_make(size : Int) -> FinanceportfoliorobustTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_table_len(s : FinanceportfoliorobustTable) -> Int { s.size }

pub fn finance_portfolio_robust_table_get(s : FinanceportfoliorobustTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_table_set(s : FinanceportfoliorobustTable, i : Int, v : Double) -> FinanceportfoliorobustTable {
  let result = finance_portfolio_robust_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_table_sum(s : FinanceportfoliorobustTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_robust_table_mean(s : FinanceportfoliorobustTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_robust_table_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_robust_table_scale(s : FinanceportfoliorobustTable, f : Double) -> FinanceportfoliorobustTable {
  let result = finance_portfolio_robust_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_robust_table_add(a : FinanceportfoliorobustTable, b : FinanceportfoliorobustTable) -> FinanceportfoliorobustTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_robust_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_robust_table_copy(s : FinanceportfoliorobustTable) -> FinanceportfoliorobustTable {
  let result = finance_portfolio_robust_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_robust_table_fill(s : FinanceportfoliorobustTable, v : Double) -> FinanceportfoliorobustTable {
  let result = finance_portfolio_robust_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_table_min(s : FinanceportfoliorobustTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_table_max(s : FinanceportfoliorobustTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_table_to_string(s : FinanceportfoliorobustTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_graphn_make(size : Int) -> FinanceportfoliorobustGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_graphn_len(s : FinanceportfoliorobustGraphN) -> Int { s.size }

pub fn finance_portfolio_robust_graphn_get(s : FinanceportfoliorobustGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_graphn_set(s : FinanceportfoliorobustGraphN, i : Int, v : Double) -> FinanceportfoliorobustGraphN {
  let result = finance_portfolio_robust_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_graphn_sum(s : FinanceportfoliorobustGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_robust_graphn_mean(s : FinanceportfoliorobustGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_robust_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_robust_graphn_scale(s : FinanceportfoliorobustGraphN, f : Double) -> FinanceportfoliorobustGraphN {
  let result = finance_portfolio_robust_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_robust_graphn_add(a : FinanceportfoliorobustGraphN, b : FinanceportfoliorobustGraphN) -> FinanceportfoliorobustGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_robust_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_robust_graphn_copy(s : FinanceportfoliorobustGraphN) -> FinanceportfoliorobustGraphN {
  let result = finance_portfolio_robust_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_robust_graphn_fill(s : FinanceportfoliorobustGraphN, v : Double) -> FinanceportfoliorobustGraphN {
  let result = finance_portfolio_robust_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_graphn_min(s : FinanceportfoliorobustGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_graphn_max(s : FinanceportfoliorobustGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_graphn_to_string(s : FinanceportfoliorobustGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_node_make(size : Int) -> FinanceportfoliorobustNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_node_len(s : FinanceportfoliorobustNode) -> Int { s.size }

pub fn finance_portfolio_robust_node_get(s : FinanceportfoliorobustNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_node_set(s : FinanceportfoliorobustNode, i : Int, v : Double) -> FinanceportfoliorobustNode {
  let result = finance_portfolio_robust_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_node_sum(s : FinanceportfoliorobustNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_robust_node_mean(s : FinanceportfoliorobustNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_robust_node_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_robust_node_scale(s : FinanceportfoliorobustNode, f : Double) -> FinanceportfoliorobustNode {
  let result = finance_portfolio_robust_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_robust_node_add(a : FinanceportfoliorobustNode, b : FinanceportfoliorobustNode) -> FinanceportfoliorobustNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_robust_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_robust_node_copy(s : FinanceportfoliorobustNode) -> FinanceportfoliorobustNode {
  let result = finance_portfolio_robust_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_robust_node_fill(s : FinanceportfoliorobustNode, v : Double) -> FinanceportfoliorobustNode {
  let result = finance_portfolio_robust_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_node_min(s : FinanceportfoliorobustNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_node_max(s : FinanceportfoliorobustNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_node_to_string(s : FinanceportfoliorobustNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_edge_make(size : Int) -> FinanceportfoliorobustEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_edge_len(s : FinanceportfoliorobustEdge) -> Int { s.size }

pub fn finance_portfolio_robust_edge_get(s : FinanceportfoliorobustEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_edge_set(s : FinanceportfoliorobustEdge, i : Int, v : Double) -> FinanceportfoliorobustEdge {
  let result = finance_portfolio_robust_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_edge_sum(s : FinanceportfoliorobustEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_robust_edge_mean(s : FinanceportfoliorobustEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_robust_edge_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_robust_edge_scale(s : FinanceportfoliorobustEdge, f : Double) -> FinanceportfoliorobustEdge {
  let result = finance_portfolio_robust_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_robust_edge_add(a : FinanceportfoliorobustEdge, b : FinanceportfoliorobustEdge) -> FinanceportfoliorobustEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_robust_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_robust_edge_copy(s : FinanceportfoliorobustEdge) -> FinanceportfoliorobustEdge {
  let result = finance_portfolio_robust_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_robust_edge_fill(s : FinanceportfoliorobustEdge, v : Double) -> FinanceportfoliorobustEdge {
  let result = finance_portfolio_robust_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_edge_min(s : FinanceportfoliorobustEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_edge_max(s : FinanceportfoliorobustEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_edge_to_string(s : FinanceportfoliorobustEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_path_make(size : Int) -> FinanceportfoliorobustPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_path_len(s : FinanceportfoliorobustPath) -> Int { s.size }

pub fn finance_portfolio_robust_path_get(s : FinanceportfoliorobustPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_path_set(s : FinanceportfoliorobustPath, i : Int, v : Double) -> FinanceportfoliorobustPath {
  let result = finance_portfolio_robust_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_path_sum(s : FinanceportfoliorobustPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_robust_path_mean(s : FinanceportfoliorobustPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_robust_path_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_robust_path_scale(s : FinanceportfoliorobustPath, f : Double) -> FinanceportfoliorobustPath {
  let result = finance_portfolio_robust_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_robust_path_add(a : FinanceportfoliorobustPath, b : FinanceportfoliorobustPath) -> FinanceportfoliorobustPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_robust_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_robust_path_copy(s : FinanceportfoliorobustPath) -> FinanceportfoliorobustPath {
  let result = finance_portfolio_robust_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_robust_path_fill(s : FinanceportfoliorobustPath, v : Double) -> FinanceportfoliorobustPath {
  let result = finance_portfolio_robust_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_path_min(s : FinanceportfoliorobustPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_path_max(s : FinanceportfoliorobustPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_path_to_string(s : FinanceportfoliorobustPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_cluster_make(size : Int) -> FinanceportfoliorobustCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_cluster_len(s : FinanceportfoliorobustCluster) -> Int { s.size }

pub fn finance_portfolio_robust_cluster_get(s : FinanceportfoliorobustCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_cluster_set(s : FinanceportfoliorobustCluster, i : Int, v : Double) -> FinanceportfoliorobustCluster {
  let result = finance_portfolio_robust_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_cluster_sum(s : FinanceportfoliorobustCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_robust_cluster_mean(s : FinanceportfoliorobustCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_robust_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_robust_cluster_scale(s : FinanceportfoliorobustCluster, f : Double) -> FinanceportfoliorobustCluster {
  let result = finance_portfolio_robust_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_robust_cluster_add(a : FinanceportfoliorobustCluster, b : FinanceportfoliorobustCluster) -> FinanceportfoliorobustCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_robust_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_robust_cluster_copy(s : FinanceportfoliorobustCluster) -> FinanceportfoliorobustCluster {
  let result = finance_portfolio_robust_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_robust_cluster_fill(s : FinanceportfoliorobustCluster, v : Double) -> FinanceportfoliorobustCluster {
  let result = finance_portfolio_robust_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_cluster_min(s : FinanceportfoliorobustCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_cluster_max(s : FinanceportfoliorobustCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_cluster_to_string(s : FinanceportfoliorobustCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_model_make(size : Int) -> FinanceportfoliorobustModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_model_len(s : FinanceportfoliorobustModel) -> Int { s.size }

pub fn finance_portfolio_robust_model_get(s : FinanceportfoliorobustModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_model_set(s : FinanceportfoliorobustModel, i : Int, v : Double) -> FinanceportfoliorobustModel {
  let result = finance_portfolio_robust_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_model_sum(s : FinanceportfoliorobustModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_robust_model_mean(s : FinanceportfoliorobustModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_robust_model_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_robust_model_scale(s : FinanceportfoliorobustModel, f : Double) -> FinanceportfoliorobustModel {
  let result = finance_portfolio_robust_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_robust_model_add(a : FinanceportfoliorobustModel, b : FinanceportfoliorobustModel) -> FinanceportfoliorobustModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_robust_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_robust_model_copy(s : FinanceportfoliorobustModel) -> FinanceportfoliorobustModel {
  let result = finance_portfolio_robust_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_robust_model_fill(s : FinanceportfoliorobustModel, v : Double) -> FinanceportfoliorobustModel {
  let result = finance_portfolio_robust_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_model_min(s : FinanceportfoliorobustModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_model_max(s : FinanceportfoliorobustModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_model_to_string(s : FinanceportfoliorobustModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_layer_make(size : Int) -> FinanceportfoliorobustLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_layer_len(s : FinanceportfoliorobustLayer) -> Int { s.size }

pub fn finance_portfolio_robust_layer_get(s : FinanceportfoliorobustLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_layer_set(s : FinanceportfoliorobustLayer, i : Int, v : Double) -> FinanceportfoliorobustLayer {
  let result = finance_portfolio_robust_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_layer_sum(s : FinanceportfoliorobustLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_robust_layer_mean(s : FinanceportfoliorobustLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_robust_layer_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_robust_layer_scale(s : FinanceportfoliorobustLayer, f : Double) -> FinanceportfoliorobustLayer {
  let result = finance_portfolio_robust_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_robust_layer_add(a : FinanceportfoliorobustLayer, b : FinanceportfoliorobustLayer) -> FinanceportfoliorobustLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_robust_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_robust_layer_copy(s : FinanceportfoliorobustLayer) -> FinanceportfoliorobustLayer {
  let result = finance_portfolio_robust_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_robust_layer_fill(s : FinanceportfoliorobustLayer, v : Double) -> FinanceportfoliorobustLayer {
  let result = finance_portfolio_robust_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_layer_min(s : FinanceportfoliorobustLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_layer_max(s : FinanceportfoliorobustLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_layer_to_string(s : FinanceportfoliorobustLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_buffer_make(size : Int) -> FinanceportfoliorobustBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_buffer_len(s : FinanceportfoliorobustBuffer) -> Int { s.size }

pub fn finance_portfolio_robust_buffer_get(s : FinanceportfoliorobustBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_buffer_set(s : FinanceportfoliorobustBuffer, i : Int, v : Double) -> FinanceportfoliorobustBuffer {
  let result = finance_portfolio_robust_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_buffer_sum(s : FinanceportfoliorobustBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_robust_buffer_mean(s : FinanceportfoliorobustBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_robust_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_robust_buffer_scale(s : FinanceportfoliorobustBuffer, f : Double) -> FinanceportfoliorobustBuffer {
  let result = finance_portfolio_robust_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_robust_buffer_add(a : FinanceportfoliorobustBuffer, b : FinanceportfoliorobustBuffer) -> FinanceportfoliorobustBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_robust_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_robust_buffer_copy(s : FinanceportfoliorobustBuffer) -> FinanceportfoliorobustBuffer {
  let result = finance_portfolio_robust_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_robust_buffer_fill(s : FinanceportfoliorobustBuffer, v : Double) -> FinanceportfoliorobustBuffer {
  let result = finance_portfolio_robust_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_buffer_min(s : FinanceportfoliorobustBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_buffer_max(s : FinanceportfoliorobustBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_buffer_to_string(s : FinanceportfoliorobustBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_cursor_make(size : Int) -> FinanceportfoliorobustCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_cursor_len(s : FinanceportfoliorobustCursor) -> Int { s.size }

pub fn finance_portfolio_robust_cursor_get(s : FinanceportfoliorobustCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_cursor_set(s : FinanceportfoliorobustCursor, i : Int, v : Double) -> FinanceportfoliorobustCursor {
  let result = finance_portfolio_robust_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_cursor_sum(s : FinanceportfoliorobustCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_robust_cursor_mean(s : FinanceportfoliorobustCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_robust_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_robust_cursor_scale(s : FinanceportfoliorobustCursor, f : Double) -> FinanceportfoliorobustCursor {
  let result = finance_portfolio_robust_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_robust_cursor_add(a : FinanceportfoliorobustCursor, b : FinanceportfoliorobustCursor) -> FinanceportfoliorobustCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_robust_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_robust_cursor_copy(s : FinanceportfoliorobustCursor) -> FinanceportfoliorobustCursor {
  let result = finance_portfolio_robust_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_robust_cursor_fill(s : FinanceportfoliorobustCursor, v : Double) -> FinanceportfoliorobustCursor {
  let result = finance_portfolio_robust_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_cursor_min(s : FinanceportfoliorobustCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_cursor_max(s : FinanceportfoliorobustCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_cursor_to_string(s : FinanceportfoliorobustCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_view_make(size : Int) -> FinanceportfoliorobustView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_view_len(s : FinanceportfoliorobustView) -> Int { s.size }

pub fn finance_portfolio_robust_view_get(s : FinanceportfoliorobustView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_view_set(s : FinanceportfoliorobustView, i : Int, v : Double) -> FinanceportfoliorobustView {
  let result = finance_portfolio_robust_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_view_sum(s : FinanceportfoliorobustView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_robust_view_mean(s : FinanceportfoliorobustView) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_robust_view_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_robust_view_scale(s : FinanceportfoliorobustView, f : Double) -> FinanceportfoliorobustView {
  let result = finance_portfolio_robust_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_robust_view_add(a : FinanceportfoliorobustView, b : FinanceportfoliorobustView) -> FinanceportfoliorobustView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_robust_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_robust_view_copy(s : FinanceportfoliorobustView) -> FinanceportfoliorobustView {
  let result = finance_portfolio_robust_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_robust_view_fill(s : FinanceportfoliorobustView, v : Double) -> FinanceportfoliorobustView {
  let result = finance_portfolio_robust_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_view_min(s : FinanceportfoliorobustView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_view_max(s : FinanceportfoliorobustView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_view_to_string(s : FinanceportfoliorobustView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_range_make(size : Int) -> FinanceportfoliorobustRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_range_len(s : FinanceportfoliorobustRange) -> Int { s.size }

pub fn finance_portfolio_robust_range_get(s : FinanceportfoliorobustRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_range_set(s : FinanceportfoliorobustRange, i : Int, v : Double) -> FinanceportfoliorobustRange {
  let result = finance_portfolio_robust_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_range_sum(s : FinanceportfoliorobustRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_robust_range_mean(s : FinanceportfoliorobustRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_robust_range_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_robust_range_scale(s : FinanceportfoliorobustRange, f : Double) -> FinanceportfoliorobustRange {
  let result = finance_portfolio_robust_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_robust_range_add(a : FinanceportfoliorobustRange, b : FinanceportfoliorobustRange) -> FinanceportfoliorobustRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_robust_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_robust_range_copy(s : FinanceportfoliorobustRange) -> FinanceportfoliorobustRange {
  let result = finance_portfolio_robust_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_robust_range_fill(s : FinanceportfoliorobustRange, v : Double) -> FinanceportfoliorobustRange {
  let result = finance_portfolio_robust_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_range_min(s : FinanceportfoliorobustRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_range_max(s : FinanceportfoliorobustRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_range_to_string(s : FinanceportfoliorobustRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_slice_make(size : Int) -> FinanceportfoliorobustSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_slice_len(s : FinanceportfoliorobustSlice) -> Int { s.size }

pub fn finance_portfolio_robust_slice_get(s : FinanceportfoliorobustSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_slice_set(s : FinanceportfoliorobustSlice, i : Int, v : Double) -> FinanceportfoliorobustSlice {
  let result = finance_portfolio_robust_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_slice_sum(s : FinanceportfoliorobustSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_robust_slice_mean(s : FinanceportfoliorobustSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_robust_slice_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_robust_slice_scale(s : FinanceportfoliorobustSlice, f : Double) -> FinanceportfoliorobustSlice {
  let result = finance_portfolio_robust_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_robust_slice_add(a : FinanceportfoliorobustSlice, b : FinanceportfoliorobustSlice) -> FinanceportfoliorobustSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_robust_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_robust_slice_copy(s : FinanceportfoliorobustSlice) -> FinanceportfoliorobustSlice {
  let result = finance_portfolio_robust_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_robust_slice_fill(s : FinanceportfoliorobustSlice, v : Double) -> FinanceportfoliorobustSlice {
  let result = finance_portfolio_robust_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_robust_slice_min(s : FinanceportfoliorobustSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_slice_max(s : FinanceportfoliorobustSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_robust_slice_to_string(s : FinanceportfoliorobustSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn finance_portfolio_robust_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_robust_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_robust_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_robust_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_robust_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_robust_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_robust_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_robust_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_robust_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_robust_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_robust_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_robust_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_robust_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_robust_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_robust_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_robust_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_robust_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_robust_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_robust_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_robust_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_robust_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_robust_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_robust_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_robust_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_robust_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

