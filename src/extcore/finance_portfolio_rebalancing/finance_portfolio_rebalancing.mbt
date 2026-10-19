///===
/// extcore/finance_portfolio_rebalancing

pub(all) struct FinanceportfoliorebalancingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_portfolio_rebalancing_make_point(x : Double, y : Double) -> FinanceportfoliorebalancingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_portfolio_rebalancing_make_point3(x : Double, y : Double, z : Double) -> FinanceportfoliorebalancingPoint {
  { x, y, z, label: 0 }
}

pub fn finance_portfolio_rebalancing_point_x(pt : FinanceportfoliorebalancingPoint) -> Double { pt.x }

pub fn finance_portfolio_rebalancing_point_y(pt : FinanceportfoliorebalancingPoint) -> Double { pt.y }

pub fn finance_portfolio_rebalancing_point_z(pt : FinanceportfoliorebalancingPoint) -> Double { pt.z }

pub fn finance_portfolio_rebalancing_point_label(pt : FinanceportfoliorebalancingPoint) -> Int { pt.label }

pub fn finance_portfolio_rebalancing_point_dist(a : FinanceportfoliorebalancingPoint, b : FinanceportfoliorebalancingPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  finance_portfolio_rebalancing_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_portfolio_rebalancing_point_add(a : FinanceportfoliorebalancingPoint, b : FinanceportfoliorebalancingPoint) -> FinanceportfoliorebalancingPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_portfolio_rebalancing_point_sub(a : FinanceportfoliorebalancingPoint, b : FinanceportfoliorebalancingPoint) -> FinanceportfoliorebalancingPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_portfolio_rebalancing_point_scale(pt : FinanceportfoliorebalancingPoint, s : Double) -> FinanceportfoliorebalancingPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_portfolio_rebalancing_point_dot(a : FinanceportfoliorebalancingPoint, b : FinanceportfoliorebalancingPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_portfolio_rebalancing_point_cross(a : FinanceportfoliorebalancingPoint, b : FinanceportfoliorebalancingPoint) -> FinanceportfoliorebalancingPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_portfolio_rebalancing_point_norm(pt : FinanceportfoliorebalancingPoint) -> Double {
  finance_portfolio_rebalancing_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_portfolio_rebalancing_point_normalize(pt : FinanceportfoliorebalancingPoint) -> FinanceportfoliorebalancingPoint {
  let n = finance_portfolio_rebalancing_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_portfolio_rebalancing_point_scale(pt, 1.0 / n) }
}

pub fn finance_portfolio_rebalancing_point_negate(pt : FinanceportfoliorebalancingPoint) -> FinanceportfoliorebalancingPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_portfolio_rebalancing_point_mid(a : FinanceportfoliorebalancingPoint, b : FinanceportfoliorebalancingPoint) -> FinanceportfoliorebalancingPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_portfolio_rebalancing_point_lerp(a : FinanceportfoliorebalancingPoint, b : FinanceportfoliorebalancingPoint, t : Double) -> FinanceportfoliorebalancingPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_portfolio_rebalancing_point_to_string(pt : FinanceportfoliorebalancingPoint) -> String {
  "(" + finance_portfolio_rebalancing_dbl(pt.x) + ", " + finance_portfolio_rebalancing_dbl(pt.y) + ", " + finance_portfolio_rebalancing_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_portfolio_rebalancing_make_series(vals : Array[Double], name : String) -> FinanceportfoliorebalancingSeries {
  { vals, name, meta: 0 }
}

pub fn finance_portfolio_rebalancing_series_len(s : FinanceportfoliorebalancingSeries) -> Int { s.vals.length() }

pub fn finance_portfolio_rebalancing_series_sum(s : FinanceportfoliorebalancingSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_portfolio_rebalancing_series_mean(s : FinanceportfoliorebalancingSeries) -> Double {
  let n = finance_portfolio_rebalancing_series_len(s)
  if n == 0 { 0.0 } else { finance_portfolio_rebalancing_series_sum(s) / n.to_double() }
}

pub fn finance_portfolio_rebalancing_series_min(s : FinanceportfoliorebalancingSeries) -> Double {
  let n = finance_portfolio_rebalancing_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_series_max(s : FinanceportfoliorebalancingSeries) -> Double {
  let n = finance_portfolio_rebalancing_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_series_range(s : FinanceportfoliorebalancingSeries) -> Double {
  finance_portfolio_rebalancing_series_max(s) - finance_portfolio_rebalancing_series_min(s)
}

pub fn finance_portfolio_rebalancing_series_var(s : FinanceportfoliorebalancingSeries) -> Double {
  let n = finance_portfolio_rebalancing_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_portfolio_rebalancing_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_series_std(s : FinanceportfoliorebalancingSeries) -> Double { finance_portfolio_rebalancing_sqrt(finance_portfolio_rebalancing_series_var(s)) }

pub fn finance_portfolio_rebalancing_series_median(s : FinanceportfoliorebalancingSeries) -> Double {
  let n = finance_portfolio_rebalancing_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_portfolio_rebalancing_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_portfolio_rebalancing_series_scale(s : FinanceportfoliorebalancingSeries, f : Double) -> FinanceportfoliorebalancingSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = finance_portfolio_rebalancing_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_portfolio_rebalancing_series_add(a : FinanceportfoliorebalancingSeries, b : FinanceportfoliorebalancingSeries) -> FinanceportfoliorebalancingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_portfolio_rebalancing_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_portfolio_rebalancing_series_sub(a : FinanceportfoliorebalancingSeries, b : FinanceportfoliorebalancingSeries) -> FinanceportfoliorebalancingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_portfolio_rebalancing_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_portfolio_rebalancing_series_normalize(s : FinanceportfoliorebalancingSeries) -> FinanceportfoliorebalancingSeries {
  let mn = finance_portfolio_rebalancing_series_min(s)
  let mx = finance_portfolio_rebalancing_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = finance_portfolio_rebalancing_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_portfolio_rebalancing_series_cumsum(s : FinanceportfoliorebalancingSeries) -> FinanceportfoliorebalancingSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = finance_portfolio_rebalancing_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_portfolio_rebalancing_series_to_string(s : FinanceportfoliorebalancingSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_portfolio_rebalancing_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfoliorebalancingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_portfolio_rebalancing_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceportfoliorebalancingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_portfolio_rebalancing_matrix_identity(n : Int) -> FinanceportfoliorebalancingMatrix {
  let m = finance_portfolio_rebalancing_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_portfolio_rebalancing_matrix_get(m : FinanceportfoliorebalancingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_portfolio_rebalancing_matrix_transpose(m : FinanceportfoliorebalancingMatrix) -> FinanceportfoliorebalancingMatrix {
  let result = finance_portfolio_rebalancing_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_portfolio_rebalancing_matrix_add(a : FinanceportfoliorebalancingMatrix, b : FinanceportfoliorebalancingMatrix) -> FinanceportfoliorebalancingMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_portfolio_rebalancing_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_portfolio_rebalancing_matrix_scale(m : FinanceportfoliorebalancingMatrix, s : Double) -> FinanceportfoliorebalancingMatrix {
  let result = finance_portfolio_rebalancing_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_portfolio_rebalancing_matrix_multiply(a : FinanceportfoliorebalancingMatrix, b : FinanceportfoliorebalancingMatrix) -> FinanceportfoliorebalancingMatrix {
  if a.cols != b.rows { return finance_portfolio_rebalancing_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_portfolio_rebalancing_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_portfolio_rebalancing_matrix_trace(m : FinanceportfoliorebalancingMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_portfolio_rebalancing_matrix_det(m : FinanceportfoliorebalancingMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_portfolio_rebalancing_matrix_norm(m : FinanceportfoliorebalancingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  finance_portfolio_rebalancing_sqrt(sum)
}

pub fn finance_portfolio_rebalancing_matrix_to_string(m : FinanceportfoliorebalancingMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + finance_portfolio_rebalancing_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct FinanceportfoliorebalancingVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_portfolio_rebalancing_make_vector(comps : Array[Double]) -> FinanceportfoliorebalancingVector {
  { comps, dim: comps.length() }
}

pub fn finance_portfolio_rebalancing_vector_zero(dim : Int) -> FinanceportfoliorebalancingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_portfolio_rebalancing_vector_add(a : FinanceportfoliorebalancingVector, b : FinanceportfoliorebalancingVector) -> FinanceportfoliorebalancingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_portfolio_rebalancing_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_portfolio_rebalancing_vector_sub(a : FinanceportfoliorebalancingVector, b : FinanceportfoliorebalancingVector) -> FinanceportfoliorebalancingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_portfolio_rebalancing_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_portfolio_rebalancing_vector_scale(v : FinanceportfoliorebalancingVector, s : Double) -> FinanceportfoliorebalancingVector {
  let mut result = []
  for i in 0..<v.dim { result = finance_portfolio_rebalancing_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_portfolio_rebalancing_vector_dot(a : FinanceportfoliorebalancingVector, b : FinanceportfoliorebalancingVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_portfolio_rebalancing_vector_norm(v : FinanceportfoliorebalancingVector) -> Double { finance_portfolio_rebalancing_sqrt(finance_portfolio_rebalancing_vector_dot(v, v)) }

pub fn finance_portfolio_rebalancing_vector_normalize(v : FinanceportfoliorebalancingVector) -> FinanceportfoliorebalancingVector {
  let n = finance_portfolio_rebalancing_vector_norm(v)
  if n < 0.0000001 { v } else { finance_portfolio_rebalancing_vector_scale(v, 1.0 / n) }
}

pub fn finance_portfolio_rebalancing_vector_dist(a : FinanceportfoliorebalancingVector, b : FinanceportfoliorebalancingVector) -> Double {
  finance_portfolio_rebalancing_vector_norm(finance_portfolio_rebalancing_vector_sub(a, b))
}

pub fn finance_portfolio_rebalancing_vector_to_string(v : FinanceportfoliorebalancingVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_portfolio_rebalancing_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_portfolio_rebalancing_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = finance_portfolio_rebalancing_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_std(data : Array[Double]) -> Double { finance_portfolio_rebalancing_sqrt(finance_portfolio_rebalancing_var(data)) }

pub fn finance_portfolio_rebalancing_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = finance_portfolio_rebalancing_mean(a); let mb = finance_portfolio_rebalancing_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = finance_portfolio_rebalancing_std(a); let sb = finance_portfolio_rebalancing_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { finance_portfolio_rebalancing_cov(a, b) / (sa * sb) }
}

pub fn finance_portfolio_rebalancing_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = finance_portfolio_rebalancing_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_portfolio_rebalancing_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  finance_portfolio_rebalancing_sqrt(finance_portfolio_rebalancing_mse(pred, labels))
}

pub fn finance_portfolio_rebalancing_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + finance_portfolio_rebalancing_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = finance_portfolio_rebalancing_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn finance_portfolio_rebalancing_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn finance_portfolio_rebalancing_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn finance_portfolio_rebalancing_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = finance_portfolio_rebalancing_precision(pred, labels, pos); let r = finance_portfolio_rebalancing_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn finance_portfolio_rebalancing_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn finance_portfolio_rebalancing_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = finance_portfolio_rebalancing_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn finance_portfolio_rebalancing_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn finance_portfolio_rebalancing_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn finance_portfolio_rebalancing_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = finance_portfolio_rebalancing_gcd(a, b)
    (a / g) * b
  }
}

pub fn finance_portfolio_rebalancing_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn finance_portfolio_rebalancing_fibonacci(n : Int) -> Int {
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

pub fn finance_portfolio_rebalancing_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = finance_portfolio_rebalancing_min(data); let mx = finance_portfolio_rebalancing_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn finance_portfolio_rebalancing_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = finance_portfolio_rebalancing_mean(data); let sd = finance_portfolio_rebalancing_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn finance_portfolio_rebalancing_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn finance_portfolio_rebalancing_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn finance_portfolio_rebalancing_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn finance_portfolio_rebalancing_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn finance_portfolio_rebalancing_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn finance_portfolio_rebalancing_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn finance_portfolio_rebalancing_dbl(x : Double) -> String {
  let i = if x >= 0.0 { finance_portfolio_rebalancing_int(x) } else { -finance_portfolio_rebalancing_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { finance_portfolio_rebalancing_int(f * 1000000.0) } else { finance_portfolio_rebalancing_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn finance_portfolio_rebalancing_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn finance_portfolio_rebalancing_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct FinanceportfoliorebalancingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_frame_make(size : Int) -> FinanceportfoliorebalancingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_frame_len(s : FinanceportfoliorebalancingFrame) -> Int { s.size }

pub fn finance_portfolio_rebalancing_frame_get(s : FinanceportfoliorebalancingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_frame_set(s : FinanceportfoliorebalancingFrame, i : Int, v : Double) -> FinanceportfoliorebalancingFrame {
  let result = finance_portfolio_rebalancing_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_frame_sum(s : FinanceportfoliorebalancingFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_rebalancing_frame_mean(s : FinanceportfoliorebalancingFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_rebalancing_frame_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_rebalancing_frame_scale(s : FinanceportfoliorebalancingFrame, f : Double) -> FinanceportfoliorebalancingFrame {
  let result = finance_portfolio_rebalancing_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_rebalancing_frame_add(a : FinanceportfoliorebalancingFrame, b : FinanceportfoliorebalancingFrame) -> FinanceportfoliorebalancingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_rebalancing_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_frame_copy(s : FinanceportfoliorebalancingFrame) -> FinanceportfoliorebalancingFrame {
  let result = finance_portfolio_rebalancing_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_frame_fill(s : FinanceportfoliorebalancingFrame, v : Double) -> FinanceportfoliorebalancingFrame {
  let result = finance_portfolio_rebalancing_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_frame_min(s : FinanceportfoliorebalancingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_frame_max(s : FinanceportfoliorebalancingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_frame_to_string(s : FinanceportfoliorebalancingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_table_make(size : Int) -> FinanceportfoliorebalancingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_table_len(s : FinanceportfoliorebalancingTable) -> Int { s.size }

pub fn finance_portfolio_rebalancing_table_get(s : FinanceportfoliorebalancingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_table_set(s : FinanceportfoliorebalancingTable, i : Int, v : Double) -> FinanceportfoliorebalancingTable {
  let result = finance_portfolio_rebalancing_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_table_sum(s : FinanceportfoliorebalancingTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_rebalancing_table_mean(s : FinanceportfoliorebalancingTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_rebalancing_table_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_rebalancing_table_scale(s : FinanceportfoliorebalancingTable, f : Double) -> FinanceportfoliorebalancingTable {
  let result = finance_portfolio_rebalancing_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_rebalancing_table_add(a : FinanceportfoliorebalancingTable, b : FinanceportfoliorebalancingTable) -> FinanceportfoliorebalancingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_rebalancing_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_table_copy(s : FinanceportfoliorebalancingTable) -> FinanceportfoliorebalancingTable {
  let result = finance_portfolio_rebalancing_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_table_fill(s : FinanceportfoliorebalancingTable, v : Double) -> FinanceportfoliorebalancingTable {
  let result = finance_portfolio_rebalancing_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_table_min(s : FinanceportfoliorebalancingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_table_max(s : FinanceportfoliorebalancingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_table_to_string(s : FinanceportfoliorebalancingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_graphn_make(size : Int) -> FinanceportfoliorebalancingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_graphn_len(s : FinanceportfoliorebalancingGraphN) -> Int { s.size }

pub fn finance_portfolio_rebalancing_graphn_get(s : FinanceportfoliorebalancingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_graphn_set(s : FinanceportfoliorebalancingGraphN, i : Int, v : Double) -> FinanceportfoliorebalancingGraphN {
  let result = finance_portfolio_rebalancing_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_graphn_sum(s : FinanceportfoliorebalancingGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_rebalancing_graphn_mean(s : FinanceportfoliorebalancingGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_rebalancing_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_rebalancing_graphn_scale(s : FinanceportfoliorebalancingGraphN, f : Double) -> FinanceportfoliorebalancingGraphN {
  let result = finance_portfolio_rebalancing_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_rebalancing_graphn_add(a : FinanceportfoliorebalancingGraphN, b : FinanceportfoliorebalancingGraphN) -> FinanceportfoliorebalancingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_rebalancing_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_graphn_copy(s : FinanceportfoliorebalancingGraphN) -> FinanceportfoliorebalancingGraphN {
  let result = finance_portfolio_rebalancing_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_graphn_fill(s : FinanceportfoliorebalancingGraphN, v : Double) -> FinanceportfoliorebalancingGraphN {
  let result = finance_portfolio_rebalancing_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_graphn_min(s : FinanceportfoliorebalancingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_graphn_max(s : FinanceportfoliorebalancingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_graphn_to_string(s : FinanceportfoliorebalancingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_node_make(size : Int) -> FinanceportfoliorebalancingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_node_len(s : FinanceportfoliorebalancingNode) -> Int { s.size }

pub fn finance_portfolio_rebalancing_node_get(s : FinanceportfoliorebalancingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_node_set(s : FinanceportfoliorebalancingNode, i : Int, v : Double) -> FinanceportfoliorebalancingNode {
  let result = finance_portfolio_rebalancing_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_node_sum(s : FinanceportfoliorebalancingNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_rebalancing_node_mean(s : FinanceportfoliorebalancingNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_rebalancing_node_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_rebalancing_node_scale(s : FinanceportfoliorebalancingNode, f : Double) -> FinanceportfoliorebalancingNode {
  let result = finance_portfolio_rebalancing_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_rebalancing_node_add(a : FinanceportfoliorebalancingNode, b : FinanceportfoliorebalancingNode) -> FinanceportfoliorebalancingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_rebalancing_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_node_copy(s : FinanceportfoliorebalancingNode) -> FinanceportfoliorebalancingNode {
  let result = finance_portfolio_rebalancing_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_node_fill(s : FinanceportfoliorebalancingNode, v : Double) -> FinanceportfoliorebalancingNode {
  let result = finance_portfolio_rebalancing_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_node_min(s : FinanceportfoliorebalancingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_node_max(s : FinanceportfoliorebalancingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_node_to_string(s : FinanceportfoliorebalancingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_edge_make(size : Int) -> FinanceportfoliorebalancingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_edge_len(s : FinanceportfoliorebalancingEdge) -> Int { s.size }

pub fn finance_portfolio_rebalancing_edge_get(s : FinanceportfoliorebalancingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_edge_set(s : FinanceportfoliorebalancingEdge, i : Int, v : Double) -> FinanceportfoliorebalancingEdge {
  let result = finance_portfolio_rebalancing_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_edge_sum(s : FinanceportfoliorebalancingEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_rebalancing_edge_mean(s : FinanceportfoliorebalancingEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_rebalancing_edge_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_rebalancing_edge_scale(s : FinanceportfoliorebalancingEdge, f : Double) -> FinanceportfoliorebalancingEdge {
  let result = finance_portfolio_rebalancing_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_rebalancing_edge_add(a : FinanceportfoliorebalancingEdge, b : FinanceportfoliorebalancingEdge) -> FinanceportfoliorebalancingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_rebalancing_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_edge_copy(s : FinanceportfoliorebalancingEdge) -> FinanceportfoliorebalancingEdge {
  let result = finance_portfolio_rebalancing_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_edge_fill(s : FinanceportfoliorebalancingEdge, v : Double) -> FinanceportfoliorebalancingEdge {
  let result = finance_portfolio_rebalancing_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_edge_min(s : FinanceportfoliorebalancingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_edge_max(s : FinanceportfoliorebalancingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_edge_to_string(s : FinanceportfoliorebalancingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_path_make(size : Int) -> FinanceportfoliorebalancingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_path_len(s : FinanceportfoliorebalancingPath) -> Int { s.size }

pub fn finance_portfolio_rebalancing_path_get(s : FinanceportfoliorebalancingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_path_set(s : FinanceportfoliorebalancingPath, i : Int, v : Double) -> FinanceportfoliorebalancingPath {
  let result = finance_portfolio_rebalancing_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_path_sum(s : FinanceportfoliorebalancingPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_rebalancing_path_mean(s : FinanceportfoliorebalancingPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_rebalancing_path_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_rebalancing_path_scale(s : FinanceportfoliorebalancingPath, f : Double) -> FinanceportfoliorebalancingPath {
  let result = finance_portfolio_rebalancing_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_rebalancing_path_add(a : FinanceportfoliorebalancingPath, b : FinanceportfoliorebalancingPath) -> FinanceportfoliorebalancingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_rebalancing_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_path_copy(s : FinanceportfoliorebalancingPath) -> FinanceportfoliorebalancingPath {
  let result = finance_portfolio_rebalancing_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_path_fill(s : FinanceportfoliorebalancingPath, v : Double) -> FinanceportfoliorebalancingPath {
  let result = finance_portfolio_rebalancing_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_path_min(s : FinanceportfoliorebalancingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_path_max(s : FinanceportfoliorebalancingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_path_to_string(s : FinanceportfoliorebalancingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_cluster_make(size : Int) -> FinanceportfoliorebalancingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_cluster_len(s : FinanceportfoliorebalancingCluster) -> Int { s.size }

pub fn finance_portfolio_rebalancing_cluster_get(s : FinanceportfoliorebalancingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_cluster_set(s : FinanceportfoliorebalancingCluster, i : Int, v : Double) -> FinanceportfoliorebalancingCluster {
  let result = finance_portfolio_rebalancing_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_cluster_sum(s : FinanceportfoliorebalancingCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_rebalancing_cluster_mean(s : FinanceportfoliorebalancingCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_rebalancing_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_rebalancing_cluster_scale(s : FinanceportfoliorebalancingCluster, f : Double) -> FinanceportfoliorebalancingCluster {
  let result = finance_portfolio_rebalancing_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_rebalancing_cluster_add(a : FinanceportfoliorebalancingCluster, b : FinanceportfoliorebalancingCluster) -> FinanceportfoliorebalancingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_rebalancing_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_cluster_copy(s : FinanceportfoliorebalancingCluster) -> FinanceportfoliorebalancingCluster {
  let result = finance_portfolio_rebalancing_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_cluster_fill(s : FinanceportfoliorebalancingCluster, v : Double) -> FinanceportfoliorebalancingCluster {
  let result = finance_portfolio_rebalancing_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_cluster_min(s : FinanceportfoliorebalancingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_cluster_max(s : FinanceportfoliorebalancingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_cluster_to_string(s : FinanceportfoliorebalancingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_model_make(size : Int) -> FinanceportfoliorebalancingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_model_len(s : FinanceportfoliorebalancingModel) -> Int { s.size }

pub fn finance_portfolio_rebalancing_model_get(s : FinanceportfoliorebalancingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_model_set(s : FinanceportfoliorebalancingModel, i : Int, v : Double) -> FinanceportfoliorebalancingModel {
  let result = finance_portfolio_rebalancing_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_model_sum(s : FinanceportfoliorebalancingModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_rebalancing_model_mean(s : FinanceportfoliorebalancingModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_rebalancing_model_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_rebalancing_model_scale(s : FinanceportfoliorebalancingModel, f : Double) -> FinanceportfoliorebalancingModel {
  let result = finance_portfolio_rebalancing_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_rebalancing_model_add(a : FinanceportfoliorebalancingModel, b : FinanceportfoliorebalancingModel) -> FinanceportfoliorebalancingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_rebalancing_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_model_copy(s : FinanceportfoliorebalancingModel) -> FinanceportfoliorebalancingModel {
  let result = finance_portfolio_rebalancing_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_model_fill(s : FinanceportfoliorebalancingModel, v : Double) -> FinanceportfoliorebalancingModel {
  let result = finance_portfolio_rebalancing_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_model_min(s : FinanceportfoliorebalancingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_model_max(s : FinanceportfoliorebalancingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_model_to_string(s : FinanceportfoliorebalancingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_layer_make(size : Int) -> FinanceportfoliorebalancingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_layer_len(s : FinanceportfoliorebalancingLayer) -> Int { s.size }

pub fn finance_portfolio_rebalancing_layer_get(s : FinanceportfoliorebalancingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_layer_set(s : FinanceportfoliorebalancingLayer, i : Int, v : Double) -> FinanceportfoliorebalancingLayer {
  let result = finance_portfolio_rebalancing_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_layer_sum(s : FinanceportfoliorebalancingLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_rebalancing_layer_mean(s : FinanceportfoliorebalancingLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_rebalancing_layer_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_rebalancing_layer_scale(s : FinanceportfoliorebalancingLayer, f : Double) -> FinanceportfoliorebalancingLayer {
  let result = finance_portfolio_rebalancing_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_rebalancing_layer_add(a : FinanceportfoliorebalancingLayer, b : FinanceportfoliorebalancingLayer) -> FinanceportfoliorebalancingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_rebalancing_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_layer_copy(s : FinanceportfoliorebalancingLayer) -> FinanceportfoliorebalancingLayer {
  let result = finance_portfolio_rebalancing_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_layer_fill(s : FinanceportfoliorebalancingLayer, v : Double) -> FinanceportfoliorebalancingLayer {
  let result = finance_portfolio_rebalancing_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_layer_min(s : FinanceportfoliorebalancingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_layer_max(s : FinanceportfoliorebalancingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_layer_to_string(s : FinanceportfoliorebalancingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_buffer_make(size : Int) -> FinanceportfoliorebalancingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_buffer_len(s : FinanceportfoliorebalancingBuffer) -> Int { s.size }

pub fn finance_portfolio_rebalancing_buffer_get(s : FinanceportfoliorebalancingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_buffer_set(s : FinanceportfoliorebalancingBuffer, i : Int, v : Double) -> FinanceportfoliorebalancingBuffer {
  let result = finance_portfolio_rebalancing_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_buffer_sum(s : FinanceportfoliorebalancingBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_rebalancing_buffer_mean(s : FinanceportfoliorebalancingBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_rebalancing_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_rebalancing_buffer_scale(s : FinanceportfoliorebalancingBuffer, f : Double) -> FinanceportfoliorebalancingBuffer {
  let result = finance_portfolio_rebalancing_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_rebalancing_buffer_add(a : FinanceportfoliorebalancingBuffer, b : FinanceportfoliorebalancingBuffer) -> FinanceportfoliorebalancingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_rebalancing_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_buffer_copy(s : FinanceportfoliorebalancingBuffer) -> FinanceportfoliorebalancingBuffer {
  let result = finance_portfolio_rebalancing_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_buffer_fill(s : FinanceportfoliorebalancingBuffer, v : Double) -> FinanceportfoliorebalancingBuffer {
  let result = finance_portfolio_rebalancing_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_buffer_min(s : FinanceportfoliorebalancingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_buffer_max(s : FinanceportfoliorebalancingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_buffer_to_string(s : FinanceportfoliorebalancingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_cursor_make(size : Int) -> FinanceportfoliorebalancingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_cursor_len(s : FinanceportfoliorebalancingCursor) -> Int { s.size }

pub fn finance_portfolio_rebalancing_cursor_get(s : FinanceportfoliorebalancingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_cursor_set(s : FinanceportfoliorebalancingCursor, i : Int, v : Double) -> FinanceportfoliorebalancingCursor {
  let result = finance_portfolio_rebalancing_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_cursor_sum(s : FinanceportfoliorebalancingCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_rebalancing_cursor_mean(s : FinanceportfoliorebalancingCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_rebalancing_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_rebalancing_cursor_scale(s : FinanceportfoliorebalancingCursor, f : Double) -> FinanceportfoliorebalancingCursor {
  let result = finance_portfolio_rebalancing_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_rebalancing_cursor_add(a : FinanceportfoliorebalancingCursor, b : FinanceportfoliorebalancingCursor) -> FinanceportfoliorebalancingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_rebalancing_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_cursor_copy(s : FinanceportfoliorebalancingCursor) -> FinanceportfoliorebalancingCursor {
  let result = finance_portfolio_rebalancing_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_cursor_fill(s : FinanceportfoliorebalancingCursor, v : Double) -> FinanceportfoliorebalancingCursor {
  let result = finance_portfolio_rebalancing_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_cursor_min(s : FinanceportfoliorebalancingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_cursor_max(s : FinanceportfoliorebalancingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_cursor_to_string(s : FinanceportfoliorebalancingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_view_make(size : Int) -> FinanceportfoliorebalancingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_view_len(s : FinanceportfoliorebalancingView) -> Int { s.size }

pub fn finance_portfolio_rebalancing_view_get(s : FinanceportfoliorebalancingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_view_set(s : FinanceportfoliorebalancingView, i : Int, v : Double) -> FinanceportfoliorebalancingView {
  let result = finance_portfolio_rebalancing_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_view_sum(s : FinanceportfoliorebalancingView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_rebalancing_view_mean(s : FinanceportfoliorebalancingView) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_rebalancing_view_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_rebalancing_view_scale(s : FinanceportfoliorebalancingView, f : Double) -> FinanceportfoliorebalancingView {
  let result = finance_portfolio_rebalancing_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_rebalancing_view_add(a : FinanceportfoliorebalancingView, b : FinanceportfoliorebalancingView) -> FinanceportfoliorebalancingView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_rebalancing_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_view_copy(s : FinanceportfoliorebalancingView) -> FinanceportfoliorebalancingView {
  let result = finance_portfolio_rebalancing_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_view_fill(s : FinanceportfoliorebalancingView, v : Double) -> FinanceportfoliorebalancingView {
  let result = finance_portfolio_rebalancing_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_view_min(s : FinanceportfoliorebalancingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_view_max(s : FinanceportfoliorebalancingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_view_to_string(s : FinanceportfoliorebalancingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_range_make(size : Int) -> FinanceportfoliorebalancingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_range_len(s : FinanceportfoliorebalancingRange) -> Int { s.size }

pub fn finance_portfolio_rebalancing_range_get(s : FinanceportfoliorebalancingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_range_set(s : FinanceportfoliorebalancingRange, i : Int, v : Double) -> FinanceportfoliorebalancingRange {
  let result = finance_portfolio_rebalancing_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_range_sum(s : FinanceportfoliorebalancingRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_rebalancing_range_mean(s : FinanceportfoliorebalancingRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_rebalancing_range_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_rebalancing_range_scale(s : FinanceportfoliorebalancingRange, f : Double) -> FinanceportfoliorebalancingRange {
  let result = finance_portfolio_rebalancing_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_rebalancing_range_add(a : FinanceportfoliorebalancingRange, b : FinanceportfoliorebalancingRange) -> FinanceportfoliorebalancingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_rebalancing_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_range_copy(s : FinanceportfoliorebalancingRange) -> FinanceportfoliorebalancingRange {
  let result = finance_portfolio_rebalancing_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_range_fill(s : FinanceportfoliorebalancingRange, v : Double) -> FinanceportfoliorebalancingRange {
  let result = finance_portfolio_rebalancing_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_range_min(s : FinanceportfoliorebalancingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_range_max(s : FinanceportfoliorebalancingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_range_to_string(s : FinanceportfoliorebalancingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_slice_make(size : Int) -> FinanceportfoliorebalancingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_slice_len(s : FinanceportfoliorebalancingSlice) -> Int { s.size }

pub fn finance_portfolio_rebalancing_slice_get(s : FinanceportfoliorebalancingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_slice_set(s : FinanceportfoliorebalancingSlice, i : Int, v : Double) -> FinanceportfoliorebalancingSlice {
  let result = finance_portfolio_rebalancing_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_slice_sum(s : FinanceportfoliorebalancingSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_rebalancing_slice_mean(s : FinanceportfoliorebalancingSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_rebalancing_slice_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_rebalancing_slice_scale(s : FinanceportfoliorebalancingSlice, f : Double) -> FinanceportfoliorebalancingSlice {
  let result = finance_portfolio_rebalancing_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_rebalancing_slice_add(a : FinanceportfoliorebalancingSlice, b : FinanceportfoliorebalancingSlice) -> FinanceportfoliorebalancingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_rebalancing_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_slice_copy(s : FinanceportfoliorebalancingSlice) -> FinanceportfoliorebalancingSlice {
  let result = finance_portfolio_rebalancing_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_rebalancing_slice_fill(s : FinanceportfoliorebalancingSlice, v : Double) -> FinanceportfoliorebalancingSlice {
  let result = finance_portfolio_rebalancing_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_rebalancing_slice_min(s : FinanceportfoliorebalancingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_slice_max(s : FinanceportfoliorebalancingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_rebalancing_slice_to_string(s : FinanceportfoliorebalancingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn finance_portfolio_rebalancing_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_portfolio_rebalancing_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

