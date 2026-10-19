///===
/// extcore/finance_pricing_monte_carlo

pub(all) struct FinancepricingmontecarloPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_monte_carlo_make_point(x : Double, y : Double) -> FinancepricingmontecarloPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_monte_carlo_make_point3(x : Double, y : Double, z : Double) -> FinancepricingmontecarloPoint {
  { x, y, z, label: 0 }
}

pub fn finance_pricing_monte_carlo_point_x(pt : FinancepricingmontecarloPoint) -> Double { pt.x }

pub fn finance_pricing_monte_carlo_point_y(pt : FinancepricingmontecarloPoint) -> Double { pt.y }

pub fn finance_pricing_monte_carlo_point_z(pt : FinancepricingmontecarloPoint) -> Double { pt.z }

pub fn finance_pricing_monte_carlo_point_label(pt : FinancepricingmontecarloPoint) -> Int { pt.label }

pub fn finance_pricing_monte_carlo_point_dist(a : FinancepricingmontecarloPoint, b : FinancepricingmontecarloPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  finance_pricing_monte_carlo_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_pricing_monte_carlo_point_add(a : FinancepricingmontecarloPoint, b : FinancepricingmontecarloPoint) -> FinancepricingmontecarloPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_pricing_monte_carlo_point_sub(a : FinancepricingmontecarloPoint, b : FinancepricingmontecarloPoint) -> FinancepricingmontecarloPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_pricing_monte_carlo_point_scale(pt : FinancepricingmontecarloPoint, s : Double) -> FinancepricingmontecarloPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_pricing_monte_carlo_point_dot(a : FinancepricingmontecarloPoint, b : FinancepricingmontecarloPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_pricing_monte_carlo_point_cross(a : FinancepricingmontecarloPoint, b : FinancepricingmontecarloPoint) -> FinancepricingmontecarloPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_pricing_monte_carlo_point_norm(pt : FinancepricingmontecarloPoint) -> Double {
  finance_pricing_monte_carlo_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_pricing_monte_carlo_point_normalize(pt : FinancepricingmontecarloPoint) -> FinancepricingmontecarloPoint {
  let n = finance_pricing_monte_carlo_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_pricing_monte_carlo_point_scale(pt, 1.0 / n) }
}

pub fn finance_pricing_monte_carlo_point_negate(pt : FinancepricingmontecarloPoint) -> FinancepricingmontecarloPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_pricing_monte_carlo_point_mid(a : FinancepricingmontecarloPoint, b : FinancepricingmontecarloPoint) -> FinancepricingmontecarloPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_pricing_monte_carlo_point_lerp(a : FinancepricingmontecarloPoint, b : FinancepricingmontecarloPoint, t : Double) -> FinancepricingmontecarloPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_pricing_monte_carlo_point_to_string(pt : FinancepricingmontecarloPoint) -> String {
  "(" + finance_pricing_monte_carlo_dbl(pt.x) + ", " + finance_pricing_monte_carlo_dbl(pt.y) + ", " + finance_pricing_monte_carlo_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_monte_carlo_make_series(vals : Array[Double], name : String) -> FinancepricingmontecarloSeries {
  { vals, name, meta: 0 }
}

pub fn finance_pricing_monte_carlo_series_len(s : FinancepricingmontecarloSeries) -> Int { s.vals.length() }

pub fn finance_pricing_monte_carlo_series_sum(s : FinancepricingmontecarloSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_pricing_monte_carlo_series_mean(s : FinancepricingmontecarloSeries) -> Double {
  let n = finance_pricing_monte_carlo_series_len(s)
  if n == 0 { 0.0 } else { finance_pricing_monte_carlo_series_sum(s) / n.to_double() }
}

pub fn finance_pricing_monte_carlo_series_min(s : FinancepricingmontecarloSeries) -> Double {
  let n = finance_pricing_monte_carlo_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_series_max(s : FinancepricingmontecarloSeries) -> Double {
  let n = finance_pricing_monte_carlo_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_series_range(s : FinancepricingmontecarloSeries) -> Double {
  finance_pricing_monte_carlo_series_max(s) - finance_pricing_monte_carlo_series_min(s)
}

pub fn finance_pricing_monte_carlo_series_var(s : FinancepricingmontecarloSeries) -> Double {
  let n = finance_pricing_monte_carlo_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_pricing_monte_carlo_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_series_std(s : FinancepricingmontecarloSeries) -> Double { finance_pricing_monte_carlo_sqrt(finance_pricing_monte_carlo_series_var(s)) }

pub fn finance_pricing_monte_carlo_series_median(s : FinancepricingmontecarloSeries) -> Double {
  let n = finance_pricing_monte_carlo_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_pricing_monte_carlo_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_pricing_monte_carlo_series_scale(s : FinancepricingmontecarloSeries, f : Double) -> FinancepricingmontecarloSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = finance_pricing_monte_carlo_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_pricing_monte_carlo_series_add(a : FinancepricingmontecarloSeries, b : FinancepricingmontecarloSeries) -> FinancepricingmontecarloSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_pricing_monte_carlo_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_pricing_monte_carlo_series_sub(a : FinancepricingmontecarloSeries, b : FinancepricingmontecarloSeries) -> FinancepricingmontecarloSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_pricing_monte_carlo_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_pricing_monte_carlo_series_normalize(s : FinancepricingmontecarloSeries) -> FinancepricingmontecarloSeries {
  let mn = finance_pricing_monte_carlo_series_min(s)
  let mx = finance_pricing_monte_carlo_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = finance_pricing_monte_carlo_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_pricing_monte_carlo_series_cumsum(s : FinancepricingmontecarloSeries) -> FinancepricingmontecarloSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = finance_pricing_monte_carlo_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_pricing_monte_carlo_series_to_string(s : FinancepricingmontecarloSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_pricing_monte_carlo_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingmontecarloMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_monte_carlo_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingmontecarloMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_monte_carlo_matrix_identity(n : Int) -> FinancepricingmontecarloMatrix {
  let m = finance_pricing_monte_carlo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_pricing_monte_carlo_matrix_get(m : FinancepricingmontecarloMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_pricing_monte_carlo_matrix_transpose(m : FinancepricingmontecarloMatrix) -> FinancepricingmontecarloMatrix {
  let result = finance_pricing_monte_carlo_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_pricing_monte_carlo_matrix_add(a : FinancepricingmontecarloMatrix, b : FinancepricingmontecarloMatrix) -> FinancepricingmontecarloMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_pricing_monte_carlo_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_pricing_monte_carlo_matrix_scale(m : FinancepricingmontecarloMatrix, s : Double) -> FinancepricingmontecarloMatrix {
  let result = finance_pricing_monte_carlo_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_pricing_monte_carlo_matrix_multiply(a : FinancepricingmontecarloMatrix, b : FinancepricingmontecarloMatrix) -> FinancepricingmontecarloMatrix {
  if a.cols != b.rows { return finance_pricing_monte_carlo_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_pricing_monte_carlo_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_pricing_monte_carlo_matrix_trace(m : FinancepricingmontecarloMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_pricing_monte_carlo_matrix_det(m : FinancepricingmontecarloMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_pricing_monte_carlo_matrix_norm(m : FinancepricingmontecarloMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  finance_pricing_monte_carlo_sqrt(sum)
}

pub fn finance_pricing_monte_carlo_matrix_to_string(m : FinancepricingmontecarloMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + finance_pricing_monte_carlo_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct FinancepricingmontecarloVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_monte_carlo_make_vector(comps : Array[Double]) -> FinancepricingmontecarloVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_monte_carlo_vector_zero(dim : Int) -> FinancepricingmontecarloVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_pricing_monte_carlo_vector_add(a : FinancepricingmontecarloVector, b : FinancepricingmontecarloVector) -> FinancepricingmontecarloVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_pricing_monte_carlo_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_pricing_monte_carlo_vector_sub(a : FinancepricingmontecarloVector, b : FinancepricingmontecarloVector) -> FinancepricingmontecarloVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_pricing_monte_carlo_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_pricing_monte_carlo_vector_scale(v : FinancepricingmontecarloVector, s : Double) -> FinancepricingmontecarloVector {
  let mut result = []
  for i in 0..<v.dim { result = finance_pricing_monte_carlo_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_pricing_monte_carlo_vector_dot(a : FinancepricingmontecarloVector, b : FinancepricingmontecarloVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_pricing_monte_carlo_vector_norm(v : FinancepricingmontecarloVector) -> Double { finance_pricing_monte_carlo_sqrt(finance_pricing_monte_carlo_vector_dot(v, v)) }

pub fn finance_pricing_monte_carlo_vector_normalize(v : FinancepricingmontecarloVector) -> FinancepricingmontecarloVector {
  let n = finance_pricing_monte_carlo_vector_norm(v)
  if n < 0.0000001 { v } else { finance_pricing_monte_carlo_vector_scale(v, 1.0 / n) }
}

pub fn finance_pricing_monte_carlo_vector_dist(a : FinancepricingmontecarloVector, b : FinancepricingmontecarloVector) -> Double {
  finance_pricing_monte_carlo_vector_norm(finance_pricing_monte_carlo_vector_sub(a, b))
}

pub fn finance_pricing_monte_carlo_vector_to_string(v : FinancepricingmontecarloVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_pricing_monte_carlo_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_pricing_monte_carlo_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = finance_pricing_monte_carlo_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_std(data : Array[Double]) -> Double { finance_pricing_monte_carlo_sqrt(finance_pricing_monte_carlo_var(data)) }

pub fn finance_pricing_monte_carlo_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = finance_pricing_monte_carlo_mean(a); let mb = finance_pricing_monte_carlo_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = finance_pricing_monte_carlo_std(a); let sb = finance_pricing_monte_carlo_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { finance_pricing_monte_carlo_cov(a, b) / (sa * sb) }
}

pub fn finance_pricing_monte_carlo_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = finance_pricing_monte_carlo_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_pricing_monte_carlo_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  finance_pricing_monte_carlo_sqrt(finance_pricing_monte_carlo_mse(pred, labels))
}

pub fn finance_pricing_monte_carlo_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + finance_pricing_monte_carlo_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = finance_pricing_monte_carlo_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn finance_pricing_monte_carlo_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn finance_pricing_monte_carlo_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn finance_pricing_monte_carlo_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = finance_pricing_monte_carlo_precision(pred, labels, pos); let r = finance_pricing_monte_carlo_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn finance_pricing_monte_carlo_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn finance_pricing_monte_carlo_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = finance_pricing_monte_carlo_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn finance_pricing_monte_carlo_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn finance_pricing_monte_carlo_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn finance_pricing_monte_carlo_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = finance_pricing_monte_carlo_gcd(a, b)
    (a / g) * b
  }
}

pub fn finance_pricing_monte_carlo_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn finance_pricing_monte_carlo_fibonacci(n : Int) -> Int {
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

pub fn finance_pricing_monte_carlo_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = finance_pricing_monte_carlo_min(data); let mx = finance_pricing_monte_carlo_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn finance_pricing_monte_carlo_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = finance_pricing_monte_carlo_mean(data); let sd = finance_pricing_monte_carlo_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn finance_pricing_monte_carlo_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn finance_pricing_monte_carlo_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn finance_pricing_monte_carlo_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn finance_pricing_monte_carlo_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn finance_pricing_monte_carlo_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn finance_pricing_monte_carlo_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn finance_pricing_monte_carlo_dbl(x : Double) -> String {
  let i = if x >= 0.0 { finance_pricing_monte_carlo_int(x) } else { -finance_pricing_monte_carlo_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { finance_pricing_monte_carlo_int(f * 1000000.0) } else { finance_pricing_monte_carlo_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn finance_pricing_monte_carlo_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn finance_pricing_monte_carlo_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct FinancepricingmontecarloFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_frame_make(size : Int) -> FinancepricingmontecarloFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_frame_len(s : FinancepricingmontecarloFrame) -> Int { s.size }

pub fn finance_pricing_monte_carlo_frame_get(s : FinancepricingmontecarloFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_frame_set(s : FinancepricingmontecarloFrame, i : Int, v : Double) -> FinancepricingmontecarloFrame {
  let result = finance_pricing_monte_carlo_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_frame_sum(s : FinancepricingmontecarloFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_monte_carlo_frame_mean(s : FinancepricingmontecarloFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_monte_carlo_frame_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_monte_carlo_frame_scale(s : FinancepricingmontecarloFrame, f : Double) -> FinancepricingmontecarloFrame {
  let result = finance_pricing_monte_carlo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_monte_carlo_frame_add(a : FinancepricingmontecarloFrame, b : FinancepricingmontecarloFrame) -> FinancepricingmontecarloFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_monte_carlo_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_frame_copy(s : FinancepricingmontecarloFrame) -> FinancepricingmontecarloFrame {
  let result = finance_pricing_monte_carlo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_frame_fill(s : FinancepricingmontecarloFrame, v : Double) -> FinancepricingmontecarloFrame {
  let result = finance_pricing_monte_carlo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_frame_min(s : FinancepricingmontecarloFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_frame_max(s : FinancepricingmontecarloFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_frame_to_string(s : FinancepricingmontecarloFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_table_make(size : Int) -> FinancepricingmontecarloTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_table_len(s : FinancepricingmontecarloTable) -> Int { s.size }

pub fn finance_pricing_monte_carlo_table_get(s : FinancepricingmontecarloTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_table_set(s : FinancepricingmontecarloTable, i : Int, v : Double) -> FinancepricingmontecarloTable {
  let result = finance_pricing_monte_carlo_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_table_sum(s : FinancepricingmontecarloTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_monte_carlo_table_mean(s : FinancepricingmontecarloTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_monte_carlo_table_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_monte_carlo_table_scale(s : FinancepricingmontecarloTable, f : Double) -> FinancepricingmontecarloTable {
  let result = finance_pricing_monte_carlo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_monte_carlo_table_add(a : FinancepricingmontecarloTable, b : FinancepricingmontecarloTable) -> FinancepricingmontecarloTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_monte_carlo_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_table_copy(s : FinancepricingmontecarloTable) -> FinancepricingmontecarloTable {
  let result = finance_pricing_monte_carlo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_table_fill(s : FinancepricingmontecarloTable, v : Double) -> FinancepricingmontecarloTable {
  let result = finance_pricing_monte_carlo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_table_min(s : FinancepricingmontecarloTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_table_max(s : FinancepricingmontecarloTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_table_to_string(s : FinancepricingmontecarloTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_graphn_make(size : Int) -> FinancepricingmontecarloGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_graphn_len(s : FinancepricingmontecarloGraphN) -> Int { s.size }

pub fn finance_pricing_monte_carlo_graphn_get(s : FinancepricingmontecarloGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_graphn_set(s : FinancepricingmontecarloGraphN, i : Int, v : Double) -> FinancepricingmontecarloGraphN {
  let result = finance_pricing_monte_carlo_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_graphn_sum(s : FinancepricingmontecarloGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_monte_carlo_graphn_mean(s : FinancepricingmontecarloGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_monte_carlo_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_monte_carlo_graphn_scale(s : FinancepricingmontecarloGraphN, f : Double) -> FinancepricingmontecarloGraphN {
  let result = finance_pricing_monte_carlo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_monte_carlo_graphn_add(a : FinancepricingmontecarloGraphN, b : FinancepricingmontecarloGraphN) -> FinancepricingmontecarloGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_monte_carlo_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_graphn_copy(s : FinancepricingmontecarloGraphN) -> FinancepricingmontecarloGraphN {
  let result = finance_pricing_monte_carlo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_graphn_fill(s : FinancepricingmontecarloGraphN, v : Double) -> FinancepricingmontecarloGraphN {
  let result = finance_pricing_monte_carlo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_graphn_min(s : FinancepricingmontecarloGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_graphn_max(s : FinancepricingmontecarloGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_graphn_to_string(s : FinancepricingmontecarloGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_node_make(size : Int) -> FinancepricingmontecarloNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_node_len(s : FinancepricingmontecarloNode) -> Int { s.size }

pub fn finance_pricing_monte_carlo_node_get(s : FinancepricingmontecarloNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_node_set(s : FinancepricingmontecarloNode, i : Int, v : Double) -> FinancepricingmontecarloNode {
  let result = finance_pricing_monte_carlo_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_node_sum(s : FinancepricingmontecarloNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_monte_carlo_node_mean(s : FinancepricingmontecarloNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_monte_carlo_node_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_monte_carlo_node_scale(s : FinancepricingmontecarloNode, f : Double) -> FinancepricingmontecarloNode {
  let result = finance_pricing_monte_carlo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_monte_carlo_node_add(a : FinancepricingmontecarloNode, b : FinancepricingmontecarloNode) -> FinancepricingmontecarloNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_monte_carlo_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_node_copy(s : FinancepricingmontecarloNode) -> FinancepricingmontecarloNode {
  let result = finance_pricing_monte_carlo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_node_fill(s : FinancepricingmontecarloNode, v : Double) -> FinancepricingmontecarloNode {
  let result = finance_pricing_monte_carlo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_node_min(s : FinancepricingmontecarloNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_node_max(s : FinancepricingmontecarloNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_node_to_string(s : FinancepricingmontecarloNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_edge_make(size : Int) -> FinancepricingmontecarloEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_edge_len(s : FinancepricingmontecarloEdge) -> Int { s.size }

pub fn finance_pricing_monte_carlo_edge_get(s : FinancepricingmontecarloEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_edge_set(s : FinancepricingmontecarloEdge, i : Int, v : Double) -> FinancepricingmontecarloEdge {
  let result = finance_pricing_monte_carlo_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_edge_sum(s : FinancepricingmontecarloEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_monte_carlo_edge_mean(s : FinancepricingmontecarloEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_monte_carlo_edge_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_monte_carlo_edge_scale(s : FinancepricingmontecarloEdge, f : Double) -> FinancepricingmontecarloEdge {
  let result = finance_pricing_monte_carlo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_monte_carlo_edge_add(a : FinancepricingmontecarloEdge, b : FinancepricingmontecarloEdge) -> FinancepricingmontecarloEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_monte_carlo_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_edge_copy(s : FinancepricingmontecarloEdge) -> FinancepricingmontecarloEdge {
  let result = finance_pricing_monte_carlo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_edge_fill(s : FinancepricingmontecarloEdge, v : Double) -> FinancepricingmontecarloEdge {
  let result = finance_pricing_monte_carlo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_edge_min(s : FinancepricingmontecarloEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_edge_max(s : FinancepricingmontecarloEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_edge_to_string(s : FinancepricingmontecarloEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_path_make(size : Int) -> FinancepricingmontecarloPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_path_len(s : FinancepricingmontecarloPath) -> Int { s.size }

pub fn finance_pricing_monte_carlo_path_get(s : FinancepricingmontecarloPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_path_set(s : FinancepricingmontecarloPath, i : Int, v : Double) -> FinancepricingmontecarloPath {
  let result = finance_pricing_monte_carlo_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_path_sum(s : FinancepricingmontecarloPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_monte_carlo_path_mean(s : FinancepricingmontecarloPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_monte_carlo_path_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_monte_carlo_path_scale(s : FinancepricingmontecarloPath, f : Double) -> FinancepricingmontecarloPath {
  let result = finance_pricing_monte_carlo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_monte_carlo_path_add(a : FinancepricingmontecarloPath, b : FinancepricingmontecarloPath) -> FinancepricingmontecarloPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_monte_carlo_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_path_copy(s : FinancepricingmontecarloPath) -> FinancepricingmontecarloPath {
  let result = finance_pricing_monte_carlo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_path_fill(s : FinancepricingmontecarloPath, v : Double) -> FinancepricingmontecarloPath {
  let result = finance_pricing_monte_carlo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_path_min(s : FinancepricingmontecarloPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_path_max(s : FinancepricingmontecarloPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_path_to_string(s : FinancepricingmontecarloPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_cluster_make(size : Int) -> FinancepricingmontecarloCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_cluster_len(s : FinancepricingmontecarloCluster) -> Int { s.size }

pub fn finance_pricing_monte_carlo_cluster_get(s : FinancepricingmontecarloCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_cluster_set(s : FinancepricingmontecarloCluster, i : Int, v : Double) -> FinancepricingmontecarloCluster {
  let result = finance_pricing_monte_carlo_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_cluster_sum(s : FinancepricingmontecarloCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_monte_carlo_cluster_mean(s : FinancepricingmontecarloCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_monte_carlo_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_monte_carlo_cluster_scale(s : FinancepricingmontecarloCluster, f : Double) -> FinancepricingmontecarloCluster {
  let result = finance_pricing_monte_carlo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_monte_carlo_cluster_add(a : FinancepricingmontecarloCluster, b : FinancepricingmontecarloCluster) -> FinancepricingmontecarloCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_monte_carlo_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_cluster_copy(s : FinancepricingmontecarloCluster) -> FinancepricingmontecarloCluster {
  let result = finance_pricing_monte_carlo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_cluster_fill(s : FinancepricingmontecarloCluster, v : Double) -> FinancepricingmontecarloCluster {
  let result = finance_pricing_monte_carlo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_cluster_min(s : FinancepricingmontecarloCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_cluster_max(s : FinancepricingmontecarloCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_cluster_to_string(s : FinancepricingmontecarloCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_model_make(size : Int) -> FinancepricingmontecarloModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_model_len(s : FinancepricingmontecarloModel) -> Int { s.size }

pub fn finance_pricing_monte_carlo_model_get(s : FinancepricingmontecarloModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_model_set(s : FinancepricingmontecarloModel, i : Int, v : Double) -> FinancepricingmontecarloModel {
  let result = finance_pricing_monte_carlo_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_model_sum(s : FinancepricingmontecarloModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_monte_carlo_model_mean(s : FinancepricingmontecarloModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_monte_carlo_model_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_monte_carlo_model_scale(s : FinancepricingmontecarloModel, f : Double) -> FinancepricingmontecarloModel {
  let result = finance_pricing_monte_carlo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_monte_carlo_model_add(a : FinancepricingmontecarloModel, b : FinancepricingmontecarloModel) -> FinancepricingmontecarloModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_monte_carlo_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_model_copy(s : FinancepricingmontecarloModel) -> FinancepricingmontecarloModel {
  let result = finance_pricing_monte_carlo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_model_fill(s : FinancepricingmontecarloModel, v : Double) -> FinancepricingmontecarloModel {
  let result = finance_pricing_monte_carlo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_model_min(s : FinancepricingmontecarloModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_model_max(s : FinancepricingmontecarloModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_model_to_string(s : FinancepricingmontecarloModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_layer_make(size : Int) -> FinancepricingmontecarloLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_layer_len(s : FinancepricingmontecarloLayer) -> Int { s.size }

pub fn finance_pricing_monte_carlo_layer_get(s : FinancepricingmontecarloLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_layer_set(s : FinancepricingmontecarloLayer, i : Int, v : Double) -> FinancepricingmontecarloLayer {
  let result = finance_pricing_monte_carlo_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_layer_sum(s : FinancepricingmontecarloLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_monte_carlo_layer_mean(s : FinancepricingmontecarloLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_monte_carlo_layer_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_monte_carlo_layer_scale(s : FinancepricingmontecarloLayer, f : Double) -> FinancepricingmontecarloLayer {
  let result = finance_pricing_monte_carlo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_monte_carlo_layer_add(a : FinancepricingmontecarloLayer, b : FinancepricingmontecarloLayer) -> FinancepricingmontecarloLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_monte_carlo_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_layer_copy(s : FinancepricingmontecarloLayer) -> FinancepricingmontecarloLayer {
  let result = finance_pricing_monte_carlo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_layer_fill(s : FinancepricingmontecarloLayer, v : Double) -> FinancepricingmontecarloLayer {
  let result = finance_pricing_monte_carlo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_layer_min(s : FinancepricingmontecarloLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_layer_max(s : FinancepricingmontecarloLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_layer_to_string(s : FinancepricingmontecarloLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_buffer_make(size : Int) -> FinancepricingmontecarloBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_buffer_len(s : FinancepricingmontecarloBuffer) -> Int { s.size }

pub fn finance_pricing_monte_carlo_buffer_get(s : FinancepricingmontecarloBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_buffer_set(s : FinancepricingmontecarloBuffer, i : Int, v : Double) -> FinancepricingmontecarloBuffer {
  let result = finance_pricing_monte_carlo_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_buffer_sum(s : FinancepricingmontecarloBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_monte_carlo_buffer_mean(s : FinancepricingmontecarloBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_monte_carlo_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_monte_carlo_buffer_scale(s : FinancepricingmontecarloBuffer, f : Double) -> FinancepricingmontecarloBuffer {
  let result = finance_pricing_monte_carlo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_monte_carlo_buffer_add(a : FinancepricingmontecarloBuffer, b : FinancepricingmontecarloBuffer) -> FinancepricingmontecarloBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_monte_carlo_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_buffer_copy(s : FinancepricingmontecarloBuffer) -> FinancepricingmontecarloBuffer {
  let result = finance_pricing_monte_carlo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_buffer_fill(s : FinancepricingmontecarloBuffer, v : Double) -> FinancepricingmontecarloBuffer {
  let result = finance_pricing_monte_carlo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_buffer_min(s : FinancepricingmontecarloBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_buffer_max(s : FinancepricingmontecarloBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_buffer_to_string(s : FinancepricingmontecarloBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_cursor_make(size : Int) -> FinancepricingmontecarloCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_cursor_len(s : FinancepricingmontecarloCursor) -> Int { s.size }

pub fn finance_pricing_monte_carlo_cursor_get(s : FinancepricingmontecarloCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_cursor_set(s : FinancepricingmontecarloCursor, i : Int, v : Double) -> FinancepricingmontecarloCursor {
  let result = finance_pricing_monte_carlo_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_cursor_sum(s : FinancepricingmontecarloCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_monte_carlo_cursor_mean(s : FinancepricingmontecarloCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_monte_carlo_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_monte_carlo_cursor_scale(s : FinancepricingmontecarloCursor, f : Double) -> FinancepricingmontecarloCursor {
  let result = finance_pricing_monte_carlo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_monte_carlo_cursor_add(a : FinancepricingmontecarloCursor, b : FinancepricingmontecarloCursor) -> FinancepricingmontecarloCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_monte_carlo_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_cursor_copy(s : FinancepricingmontecarloCursor) -> FinancepricingmontecarloCursor {
  let result = finance_pricing_monte_carlo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_cursor_fill(s : FinancepricingmontecarloCursor, v : Double) -> FinancepricingmontecarloCursor {
  let result = finance_pricing_monte_carlo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_cursor_min(s : FinancepricingmontecarloCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_cursor_max(s : FinancepricingmontecarloCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_cursor_to_string(s : FinancepricingmontecarloCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_view_make(size : Int) -> FinancepricingmontecarloView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_view_len(s : FinancepricingmontecarloView) -> Int { s.size }

pub fn finance_pricing_monte_carlo_view_get(s : FinancepricingmontecarloView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_view_set(s : FinancepricingmontecarloView, i : Int, v : Double) -> FinancepricingmontecarloView {
  let result = finance_pricing_monte_carlo_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_view_sum(s : FinancepricingmontecarloView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_monte_carlo_view_mean(s : FinancepricingmontecarloView) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_monte_carlo_view_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_monte_carlo_view_scale(s : FinancepricingmontecarloView, f : Double) -> FinancepricingmontecarloView {
  let result = finance_pricing_monte_carlo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_monte_carlo_view_add(a : FinancepricingmontecarloView, b : FinancepricingmontecarloView) -> FinancepricingmontecarloView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_monte_carlo_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_view_copy(s : FinancepricingmontecarloView) -> FinancepricingmontecarloView {
  let result = finance_pricing_monte_carlo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_view_fill(s : FinancepricingmontecarloView, v : Double) -> FinancepricingmontecarloView {
  let result = finance_pricing_monte_carlo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_view_min(s : FinancepricingmontecarloView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_view_max(s : FinancepricingmontecarloView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_view_to_string(s : FinancepricingmontecarloView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_range_make(size : Int) -> FinancepricingmontecarloRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_range_len(s : FinancepricingmontecarloRange) -> Int { s.size }

pub fn finance_pricing_monte_carlo_range_get(s : FinancepricingmontecarloRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_range_set(s : FinancepricingmontecarloRange, i : Int, v : Double) -> FinancepricingmontecarloRange {
  let result = finance_pricing_monte_carlo_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_range_sum(s : FinancepricingmontecarloRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_monte_carlo_range_mean(s : FinancepricingmontecarloRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_monte_carlo_range_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_monte_carlo_range_scale(s : FinancepricingmontecarloRange, f : Double) -> FinancepricingmontecarloRange {
  let result = finance_pricing_monte_carlo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_monte_carlo_range_add(a : FinancepricingmontecarloRange, b : FinancepricingmontecarloRange) -> FinancepricingmontecarloRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_monte_carlo_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_range_copy(s : FinancepricingmontecarloRange) -> FinancepricingmontecarloRange {
  let result = finance_pricing_monte_carlo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_range_fill(s : FinancepricingmontecarloRange, v : Double) -> FinancepricingmontecarloRange {
  let result = finance_pricing_monte_carlo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_range_min(s : FinancepricingmontecarloRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_range_max(s : FinancepricingmontecarloRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_range_to_string(s : FinancepricingmontecarloRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_slice_make(size : Int) -> FinancepricingmontecarloSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_slice_len(s : FinancepricingmontecarloSlice) -> Int { s.size }

pub fn finance_pricing_monte_carlo_slice_get(s : FinancepricingmontecarloSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_slice_set(s : FinancepricingmontecarloSlice, i : Int, v : Double) -> FinancepricingmontecarloSlice {
  let result = finance_pricing_monte_carlo_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_slice_sum(s : FinancepricingmontecarloSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_monte_carlo_slice_mean(s : FinancepricingmontecarloSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_monte_carlo_slice_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_monte_carlo_slice_scale(s : FinancepricingmontecarloSlice, f : Double) -> FinancepricingmontecarloSlice {
  let result = finance_pricing_monte_carlo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_monte_carlo_slice_add(a : FinancepricingmontecarloSlice, b : FinancepricingmontecarloSlice) -> FinancepricingmontecarloSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_monte_carlo_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_slice_copy(s : FinancepricingmontecarloSlice) -> FinancepricingmontecarloSlice {
  let result = finance_pricing_monte_carlo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_monte_carlo_slice_fill(s : FinancepricingmontecarloSlice, v : Double) -> FinancepricingmontecarloSlice {
  let result = finance_pricing_monte_carlo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_monte_carlo_slice_min(s : FinancepricingmontecarloSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_slice_max(s : FinancepricingmontecarloSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_monte_carlo_slice_to_string(s : FinancepricingmontecarloSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn finance_pricing_monte_carlo_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_pricing_monte_carlo_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

