///===
/// extcore/finance_pricing_black_scholes

pub(all) struct FinancepricingblackscholesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_black_scholes_make_point(x : Double, y : Double) -> FinancepricingblackscholesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_black_scholes_make_point3(x : Double, y : Double, z : Double) -> FinancepricingblackscholesPoint {
  { x, y, z, label: 0 }
}

pub fn finance_pricing_black_scholes_point_x(pt : FinancepricingblackscholesPoint) -> Double { pt.x }

pub fn finance_pricing_black_scholes_point_y(pt : FinancepricingblackscholesPoint) -> Double { pt.y }

pub fn finance_pricing_black_scholes_point_z(pt : FinancepricingblackscholesPoint) -> Double { pt.z }

pub fn finance_pricing_black_scholes_point_label(pt : FinancepricingblackscholesPoint) -> Int { pt.label }

pub fn finance_pricing_black_scholes_point_dist(a : FinancepricingblackscholesPoint, b : FinancepricingblackscholesPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_pricing_black_scholes_point_add(a : FinancepricingblackscholesPoint, b : FinancepricingblackscholesPoint) -> FinancepricingblackscholesPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_pricing_black_scholes_point_sub(a : FinancepricingblackscholesPoint, b : FinancepricingblackscholesPoint) -> FinancepricingblackscholesPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_pricing_black_scholes_point_scale(pt : FinancepricingblackscholesPoint, s : Double) -> FinancepricingblackscholesPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_pricing_black_scholes_point_dot(a : FinancepricingblackscholesPoint, b : FinancepricingblackscholesPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_pricing_black_scholes_point_cross(a : FinancepricingblackscholesPoint, b : FinancepricingblackscholesPoint) -> FinancepricingblackscholesPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_pricing_black_scholes_point_norm(pt : FinancepricingblackscholesPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_pricing_black_scholes_point_normalize(pt : FinancepricingblackscholesPoint) -> FinancepricingblackscholesPoint {
  let n = finance_pricing_black_scholes_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_pricing_black_scholes_point_scale(pt, 1.0 / n) }
}

pub fn finance_pricing_black_scholes_point_negate(pt : FinancepricingblackscholesPoint) -> FinancepricingblackscholesPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_pricing_black_scholes_point_mid(a : FinancepricingblackscholesPoint, b : FinancepricingblackscholesPoint) -> FinancepricingblackscholesPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_pricing_black_scholes_point_lerp(a : FinancepricingblackscholesPoint, b : FinancepricingblackscholesPoint, t : Double) -> FinancepricingblackscholesPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_pricing_black_scholes_point_to_string(pt : FinancepricingblackscholesPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_black_scholes_make_series(vals : Array[Double], name : String) -> FinancepricingblackscholesSeries {
  { vals, name, meta: 0 }
}

pub fn finance_pricing_black_scholes_series_len(s : FinancepricingblackscholesSeries) -> Int { s.vals.length() }

pub fn finance_pricing_black_scholes_series_sum(s : FinancepricingblackscholesSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_pricing_black_scholes_series_mean(s : FinancepricingblackscholesSeries) -> Double {
  let n = finance_pricing_black_scholes_series_len(s)
  if n == 0 { 0.0 } else { finance_pricing_black_scholes_series_sum(s) / n.to_double() }
}

pub fn finance_pricing_black_scholes_series_min(s : FinancepricingblackscholesSeries) -> Double {
  let n = finance_pricing_black_scholes_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_series_max(s : FinancepricingblackscholesSeries) -> Double {
  let n = finance_pricing_black_scholes_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_series_range(s : FinancepricingblackscholesSeries) -> Double {
  finance_pricing_black_scholes_series_max(s) - finance_pricing_black_scholes_series_min(s)
}

pub fn finance_pricing_black_scholes_series_var(s : FinancepricingblackscholesSeries) -> Double {
  let n = finance_pricing_black_scholes_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_pricing_black_scholes_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_pricing_black_scholes_series_std(s : FinancepricingblackscholesSeries) -> Double { @_common.sqrt(finance_pricing_black_scholes_series_var(s)) }

pub fn finance_pricing_black_scholes_series_median(s : FinancepricingblackscholesSeries) -> Double {
  let n = finance_pricing_black_scholes_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_pricing_black_scholes_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_pricing_black_scholes_series_scale(s : FinancepricingblackscholesSeries, f : Double) -> FinancepricingblackscholesSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_pricing_black_scholes_series_add(a : FinancepricingblackscholesSeries, b : FinancepricingblackscholesSeries) -> FinancepricingblackscholesSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_pricing_black_scholes_series_sub(a : FinancepricingblackscholesSeries, b : FinancepricingblackscholesSeries) -> FinancepricingblackscholesSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_pricing_black_scholes_series_normalize(s : FinancepricingblackscholesSeries) -> FinancepricingblackscholesSeries {
  let mn = finance_pricing_black_scholes_series_min(s)
  let mx = finance_pricing_black_scholes_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_pricing_black_scholes_series_cumsum(s : FinancepricingblackscholesSeries) -> FinancepricingblackscholesSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_pricing_black_scholes_series_to_string(s : FinancepricingblackscholesSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingblackscholesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_black_scholes_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingblackscholesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_black_scholes_matrix_identity(n : Int) -> FinancepricingblackscholesMatrix {
  let m = finance_pricing_black_scholes_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_pricing_black_scholes_matrix_get(m : FinancepricingblackscholesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_pricing_black_scholes_matrix_transpose(m : FinancepricingblackscholesMatrix) -> FinancepricingblackscholesMatrix {
  let result = finance_pricing_black_scholes_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_pricing_black_scholes_matrix_add(a : FinancepricingblackscholesMatrix, b : FinancepricingblackscholesMatrix) -> FinancepricingblackscholesMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_pricing_black_scholes_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_pricing_black_scholes_matrix_scale(m : FinancepricingblackscholesMatrix, s : Double) -> FinancepricingblackscholesMatrix {
  let result = finance_pricing_black_scholes_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_pricing_black_scholes_matrix_multiply(a : FinancepricingblackscholesMatrix, b : FinancepricingblackscholesMatrix) -> FinancepricingblackscholesMatrix {
  if a.cols != b.rows { return finance_pricing_black_scholes_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_pricing_black_scholes_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_pricing_black_scholes_matrix_trace(m : FinancepricingblackscholesMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_pricing_black_scholes_matrix_det(m : FinancepricingblackscholesMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_pricing_black_scholes_matrix_norm(m : FinancepricingblackscholesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_pricing_black_scholes_matrix_to_string(m : FinancepricingblackscholesMatrix) -> String {
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

pub(all) struct FinancepricingblackscholesVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_black_scholes_make_vector(comps : Array[Double]) -> FinancepricingblackscholesVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_black_scholes_vector_zero(dim : Int) -> FinancepricingblackscholesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_pricing_black_scholes_vector_add(a : FinancepricingblackscholesVector, b : FinancepricingblackscholesVector) -> FinancepricingblackscholesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_pricing_black_scholes_vector_sub(a : FinancepricingblackscholesVector, b : FinancepricingblackscholesVector) -> FinancepricingblackscholesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_pricing_black_scholes_vector_scale(v : FinancepricingblackscholesVector, s : Double) -> FinancepricingblackscholesVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_pricing_black_scholes_vector_dot(a : FinancepricingblackscholesVector, b : FinancepricingblackscholesVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_pricing_black_scholes_vector_norm(v : FinancepricingblackscholesVector) -> Double { @_common.sqrt(finance_pricing_black_scholes_vector_dot(v, v)) }

pub fn finance_pricing_black_scholes_vector_normalize(v : FinancepricingblackscholesVector) -> FinancepricingblackscholesVector {
  let n = finance_pricing_black_scholes_vector_norm(v)
  if n < 0.0000001 { v } else { finance_pricing_black_scholes_vector_scale(v, 1.0 / n) }
}

pub fn finance_pricing_black_scholes_vector_dist(a : FinancepricingblackscholesVector, b : FinancepricingblackscholesVector) -> Double {
  finance_pricing_black_scholes_vector_norm(finance_pricing_black_scholes_vector_sub(a, b))
}

pub fn finance_pricing_black_scholes_vector_to_string(v : FinancepricingblackscholesVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_pricing_black_scholes_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn finance_pricing_black_scholes_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = finance_pricing_black_scholes_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_pricing_black_scholes_std(data : Array[Double]) -> Double { @_common.sqrt(finance_pricing_black_scholes_var(data)) }

pub fn finance_pricing_black_scholes_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = finance_pricing_black_scholes_mean(a); let mb = finance_pricing_black_scholes_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn finance_pricing_black_scholes_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = finance_pricing_black_scholes_std(a); let sb = finance_pricing_black_scholes_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { finance_pricing_black_scholes_cov(a, b) / (sa * sb) }
}

pub fn finance_pricing_black_scholes_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = finance_pricing_black_scholes_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_pricing_black_scholes_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn finance_pricing_black_scholes_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_pricing_black_scholes_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(finance_pricing_black_scholes_mse(pred, labels))
}

pub fn finance_pricing_black_scholes_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn finance_pricing_black_scholes_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = finance_pricing_black_scholes_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn finance_pricing_black_scholes_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn finance_pricing_black_scholes_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn finance_pricing_black_scholes_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = finance_pricing_black_scholes_precision(pred, labels, pos); let r = finance_pricing_black_scholes_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn finance_pricing_black_scholes_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn finance_pricing_black_scholes_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = finance_pricing_black_scholes_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn finance_pricing_black_scholes_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn finance_pricing_black_scholes_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn finance_pricing_black_scholes_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = finance_pricing_black_scholes_gcd(a, b)
    (a / g) * b
  }
}

pub fn finance_pricing_black_scholes_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn finance_pricing_black_scholes_fibonacci(n : Int) -> Int {
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

pub fn finance_pricing_black_scholes_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = finance_pricing_black_scholes_min(data); let mx = finance_pricing_black_scholes_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn finance_pricing_black_scholes_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = finance_pricing_black_scholes_mean(data); let sd = finance_pricing_black_scholes_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn finance_pricing_black_scholes_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn finance_pricing_black_scholes_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn finance_pricing_black_scholes_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn finance_pricing_black_scholes_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct FinancepricingblackscholesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_frame_make(size : Int) -> FinancepricingblackscholesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_frame_len(s : FinancepricingblackscholesFrame) -> Int { s.size }

pub fn finance_pricing_black_scholes_frame_get(s : FinancepricingblackscholesFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_frame_set(s : FinancepricingblackscholesFrame, i : Int, v : Double) -> FinancepricingblackscholesFrame {
  let result = finance_pricing_black_scholes_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_frame_sum(s : FinancepricingblackscholesFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_black_scholes_frame_mean(s : FinancepricingblackscholesFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_black_scholes_frame_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_black_scholes_frame_scale(s : FinancepricingblackscholesFrame, f : Double) -> FinancepricingblackscholesFrame {
  let result = finance_pricing_black_scholes_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_black_scholes_frame_add(a : FinancepricingblackscholesFrame, b : FinancepricingblackscholesFrame) -> FinancepricingblackscholesFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_black_scholes_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_black_scholes_frame_copy(s : FinancepricingblackscholesFrame) -> FinancepricingblackscholesFrame {
  let result = finance_pricing_black_scholes_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_black_scholes_frame_fill(s : FinancepricingblackscholesFrame, v : Double) -> FinancepricingblackscholesFrame {
  let result = finance_pricing_black_scholes_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_frame_min(s : FinancepricingblackscholesFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_frame_max(s : FinancepricingblackscholesFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_frame_to_string(s : FinancepricingblackscholesFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_table_make(size : Int) -> FinancepricingblackscholesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_table_len(s : FinancepricingblackscholesTable) -> Int { s.size }

pub fn finance_pricing_black_scholes_table_get(s : FinancepricingblackscholesTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_table_set(s : FinancepricingblackscholesTable, i : Int, v : Double) -> FinancepricingblackscholesTable {
  let result = finance_pricing_black_scholes_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_table_sum(s : FinancepricingblackscholesTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_black_scholes_table_mean(s : FinancepricingblackscholesTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_black_scholes_table_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_black_scholes_table_scale(s : FinancepricingblackscholesTable, f : Double) -> FinancepricingblackscholesTable {
  let result = finance_pricing_black_scholes_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_black_scholes_table_add(a : FinancepricingblackscholesTable, b : FinancepricingblackscholesTable) -> FinancepricingblackscholesTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_black_scholes_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_black_scholes_table_copy(s : FinancepricingblackscholesTable) -> FinancepricingblackscholesTable {
  let result = finance_pricing_black_scholes_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_black_scholes_table_fill(s : FinancepricingblackscholesTable, v : Double) -> FinancepricingblackscholesTable {
  let result = finance_pricing_black_scholes_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_table_min(s : FinancepricingblackscholesTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_table_max(s : FinancepricingblackscholesTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_table_to_string(s : FinancepricingblackscholesTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_graphn_make(size : Int) -> FinancepricingblackscholesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_graphn_len(s : FinancepricingblackscholesGraphN) -> Int { s.size }

pub fn finance_pricing_black_scholes_graphn_get(s : FinancepricingblackscholesGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_graphn_set(s : FinancepricingblackscholesGraphN, i : Int, v : Double) -> FinancepricingblackscholesGraphN {
  let result = finance_pricing_black_scholes_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_graphn_sum(s : FinancepricingblackscholesGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_black_scholes_graphn_mean(s : FinancepricingblackscholesGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_black_scholes_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_black_scholes_graphn_scale(s : FinancepricingblackscholesGraphN, f : Double) -> FinancepricingblackscholesGraphN {
  let result = finance_pricing_black_scholes_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_black_scholes_graphn_add(a : FinancepricingblackscholesGraphN, b : FinancepricingblackscholesGraphN) -> FinancepricingblackscholesGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_black_scholes_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_black_scholes_graphn_copy(s : FinancepricingblackscholesGraphN) -> FinancepricingblackscholesGraphN {
  let result = finance_pricing_black_scholes_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_black_scholes_graphn_fill(s : FinancepricingblackscholesGraphN, v : Double) -> FinancepricingblackscholesGraphN {
  let result = finance_pricing_black_scholes_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_graphn_min(s : FinancepricingblackscholesGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_graphn_max(s : FinancepricingblackscholesGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_graphn_to_string(s : FinancepricingblackscholesGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_node_make(size : Int) -> FinancepricingblackscholesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_node_len(s : FinancepricingblackscholesNode) -> Int { s.size }

pub fn finance_pricing_black_scholes_node_get(s : FinancepricingblackscholesNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_node_set(s : FinancepricingblackscholesNode, i : Int, v : Double) -> FinancepricingblackscholesNode {
  let result = finance_pricing_black_scholes_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_node_sum(s : FinancepricingblackscholesNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_black_scholes_node_mean(s : FinancepricingblackscholesNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_black_scholes_node_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_black_scholes_node_scale(s : FinancepricingblackscholesNode, f : Double) -> FinancepricingblackscholesNode {
  let result = finance_pricing_black_scholes_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_black_scholes_node_add(a : FinancepricingblackscholesNode, b : FinancepricingblackscholesNode) -> FinancepricingblackscholesNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_black_scholes_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_black_scholes_node_copy(s : FinancepricingblackscholesNode) -> FinancepricingblackscholesNode {
  let result = finance_pricing_black_scholes_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_black_scholes_node_fill(s : FinancepricingblackscholesNode, v : Double) -> FinancepricingblackscholesNode {
  let result = finance_pricing_black_scholes_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_node_min(s : FinancepricingblackscholesNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_node_max(s : FinancepricingblackscholesNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_node_to_string(s : FinancepricingblackscholesNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_edge_make(size : Int) -> FinancepricingblackscholesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_edge_len(s : FinancepricingblackscholesEdge) -> Int { s.size }

pub fn finance_pricing_black_scholes_edge_get(s : FinancepricingblackscholesEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_edge_set(s : FinancepricingblackscholesEdge, i : Int, v : Double) -> FinancepricingblackscholesEdge {
  let result = finance_pricing_black_scholes_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_edge_sum(s : FinancepricingblackscholesEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_black_scholes_edge_mean(s : FinancepricingblackscholesEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_black_scholes_edge_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_black_scholes_edge_scale(s : FinancepricingblackscholesEdge, f : Double) -> FinancepricingblackscholesEdge {
  let result = finance_pricing_black_scholes_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_black_scholes_edge_add(a : FinancepricingblackscholesEdge, b : FinancepricingblackscholesEdge) -> FinancepricingblackscholesEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_black_scholes_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_black_scholes_edge_copy(s : FinancepricingblackscholesEdge) -> FinancepricingblackscholesEdge {
  let result = finance_pricing_black_scholes_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_black_scholes_edge_fill(s : FinancepricingblackscholesEdge, v : Double) -> FinancepricingblackscholesEdge {
  let result = finance_pricing_black_scholes_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_edge_min(s : FinancepricingblackscholesEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_edge_max(s : FinancepricingblackscholesEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_edge_to_string(s : FinancepricingblackscholesEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_path_make(size : Int) -> FinancepricingblackscholesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_path_len(s : FinancepricingblackscholesPath) -> Int { s.size }

pub fn finance_pricing_black_scholes_path_get(s : FinancepricingblackscholesPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_path_set(s : FinancepricingblackscholesPath, i : Int, v : Double) -> FinancepricingblackscholesPath {
  let result = finance_pricing_black_scholes_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_path_sum(s : FinancepricingblackscholesPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_black_scholes_path_mean(s : FinancepricingblackscholesPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_black_scholes_path_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_black_scholes_path_scale(s : FinancepricingblackscholesPath, f : Double) -> FinancepricingblackscholesPath {
  let result = finance_pricing_black_scholes_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_black_scholes_path_add(a : FinancepricingblackscholesPath, b : FinancepricingblackscholesPath) -> FinancepricingblackscholesPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_black_scholes_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_black_scholes_path_copy(s : FinancepricingblackscholesPath) -> FinancepricingblackscholesPath {
  let result = finance_pricing_black_scholes_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_black_scholes_path_fill(s : FinancepricingblackscholesPath, v : Double) -> FinancepricingblackscholesPath {
  let result = finance_pricing_black_scholes_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_path_min(s : FinancepricingblackscholesPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_path_max(s : FinancepricingblackscholesPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_path_to_string(s : FinancepricingblackscholesPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_cluster_make(size : Int) -> FinancepricingblackscholesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_cluster_len(s : FinancepricingblackscholesCluster) -> Int { s.size }

pub fn finance_pricing_black_scholes_cluster_get(s : FinancepricingblackscholesCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_cluster_set(s : FinancepricingblackscholesCluster, i : Int, v : Double) -> FinancepricingblackscholesCluster {
  let result = finance_pricing_black_scholes_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_cluster_sum(s : FinancepricingblackscholesCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_black_scholes_cluster_mean(s : FinancepricingblackscholesCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_black_scholes_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_black_scholes_cluster_scale(s : FinancepricingblackscholesCluster, f : Double) -> FinancepricingblackscholesCluster {
  let result = finance_pricing_black_scholes_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_black_scholes_cluster_add(a : FinancepricingblackscholesCluster, b : FinancepricingblackscholesCluster) -> FinancepricingblackscholesCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_black_scholes_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_black_scholes_cluster_copy(s : FinancepricingblackscholesCluster) -> FinancepricingblackscholesCluster {
  let result = finance_pricing_black_scholes_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_black_scholes_cluster_fill(s : FinancepricingblackscholesCluster, v : Double) -> FinancepricingblackscholesCluster {
  let result = finance_pricing_black_scholes_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_cluster_min(s : FinancepricingblackscholesCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_cluster_max(s : FinancepricingblackscholesCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_cluster_to_string(s : FinancepricingblackscholesCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_model_make(size : Int) -> FinancepricingblackscholesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_model_len(s : FinancepricingblackscholesModel) -> Int { s.size }

pub fn finance_pricing_black_scholes_model_get(s : FinancepricingblackscholesModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_model_set(s : FinancepricingblackscholesModel, i : Int, v : Double) -> FinancepricingblackscholesModel {
  let result = finance_pricing_black_scholes_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_model_sum(s : FinancepricingblackscholesModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_black_scholes_model_mean(s : FinancepricingblackscholesModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_black_scholes_model_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_black_scholes_model_scale(s : FinancepricingblackscholesModel, f : Double) -> FinancepricingblackscholesModel {
  let result = finance_pricing_black_scholes_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_black_scholes_model_add(a : FinancepricingblackscholesModel, b : FinancepricingblackscholesModel) -> FinancepricingblackscholesModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_black_scholes_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_black_scholes_model_copy(s : FinancepricingblackscholesModel) -> FinancepricingblackscholesModel {
  let result = finance_pricing_black_scholes_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_black_scholes_model_fill(s : FinancepricingblackscholesModel, v : Double) -> FinancepricingblackscholesModel {
  let result = finance_pricing_black_scholes_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_model_min(s : FinancepricingblackscholesModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_model_max(s : FinancepricingblackscholesModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_model_to_string(s : FinancepricingblackscholesModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_layer_make(size : Int) -> FinancepricingblackscholesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_layer_len(s : FinancepricingblackscholesLayer) -> Int { s.size }

pub fn finance_pricing_black_scholes_layer_get(s : FinancepricingblackscholesLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_layer_set(s : FinancepricingblackscholesLayer, i : Int, v : Double) -> FinancepricingblackscholesLayer {
  let result = finance_pricing_black_scholes_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_layer_sum(s : FinancepricingblackscholesLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_black_scholes_layer_mean(s : FinancepricingblackscholesLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_black_scholes_layer_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_black_scholes_layer_scale(s : FinancepricingblackscholesLayer, f : Double) -> FinancepricingblackscholesLayer {
  let result = finance_pricing_black_scholes_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_black_scholes_layer_add(a : FinancepricingblackscholesLayer, b : FinancepricingblackscholesLayer) -> FinancepricingblackscholesLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_black_scholes_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_black_scholes_layer_copy(s : FinancepricingblackscholesLayer) -> FinancepricingblackscholesLayer {
  let result = finance_pricing_black_scholes_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_black_scholes_layer_fill(s : FinancepricingblackscholesLayer, v : Double) -> FinancepricingblackscholesLayer {
  let result = finance_pricing_black_scholes_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_layer_min(s : FinancepricingblackscholesLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_layer_max(s : FinancepricingblackscholesLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_layer_to_string(s : FinancepricingblackscholesLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_buffer_make(size : Int) -> FinancepricingblackscholesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_buffer_len(s : FinancepricingblackscholesBuffer) -> Int { s.size }

pub fn finance_pricing_black_scholes_buffer_get(s : FinancepricingblackscholesBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_buffer_set(s : FinancepricingblackscholesBuffer, i : Int, v : Double) -> FinancepricingblackscholesBuffer {
  let result = finance_pricing_black_scholes_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_buffer_sum(s : FinancepricingblackscholesBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_black_scholes_buffer_mean(s : FinancepricingblackscholesBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_black_scholes_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_black_scholes_buffer_scale(s : FinancepricingblackscholesBuffer, f : Double) -> FinancepricingblackscholesBuffer {
  let result = finance_pricing_black_scholes_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_black_scholes_buffer_add(a : FinancepricingblackscholesBuffer, b : FinancepricingblackscholesBuffer) -> FinancepricingblackscholesBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_black_scholes_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_black_scholes_buffer_copy(s : FinancepricingblackscholesBuffer) -> FinancepricingblackscholesBuffer {
  let result = finance_pricing_black_scholes_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_black_scholes_buffer_fill(s : FinancepricingblackscholesBuffer, v : Double) -> FinancepricingblackscholesBuffer {
  let result = finance_pricing_black_scholes_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_buffer_min(s : FinancepricingblackscholesBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_buffer_max(s : FinancepricingblackscholesBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_buffer_to_string(s : FinancepricingblackscholesBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_cursor_make(size : Int) -> FinancepricingblackscholesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_cursor_len(s : FinancepricingblackscholesCursor) -> Int { s.size }

pub fn finance_pricing_black_scholes_cursor_get(s : FinancepricingblackscholesCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_cursor_set(s : FinancepricingblackscholesCursor, i : Int, v : Double) -> FinancepricingblackscholesCursor {
  let result = finance_pricing_black_scholes_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_cursor_sum(s : FinancepricingblackscholesCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_black_scholes_cursor_mean(s : FinancepricingblackscholesCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_black_scholes_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_black_scholes_cursor_scale(s : FinancepricingblackscholesCursor, f : Double) -> FinancepricingblackscholesCursor {
  let result = finance_pricing_black_scholes_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_black_scholes_cursor_add(a : FinancepricingblackscholesCursor, b : FinancepricingblackscholesCursor) -> FinancepricingblackscholesCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_black_scholes_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_black_scholes_cursor_copy(s : FinancepricingblackscholesCursor) -> FinancepricingblackscholesCursor {
  let result = finance_pricing_black_scholes_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_black_scholes_cursor_fill(s : FinancepricingblackscholesCursor, v : Double) -> FinancepricingblackscholesCursor {
  let result = finance_pricing_black_scholes_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_cursor_min(s : FinancepricingblackscholesCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_cursor_max(s : FinancepricingblackscholesCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_cursor_to_string(s : FinancepricingblackscholesCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_view_make(size : Int) -> FinancepricingblackscholesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_view_len(s : FinancepricingblackscholesView) -> Int { s.size }

pub fn finance_pricing_black_scholes_view_get(s : FinancepricingblackscholesView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_view_set(s : FinancepricingblackscholesView, i : Int, v : Double) -> FinancepricingblackscholesView {
  let result = finance_pricing_black_scholes_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_view_sum(s : FinancepricingblackscholesView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_black_scholes_view_mean(s : FinancepricingblackscholesView) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_black_scholes_view_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_black_scholes_view_scale(s : FinancepricingblackscholesView, f : Double) -> FinancepricingblackscholesView {
  let result = finance_pricing_black_scholes_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_black_scholes_view_add(a : FinancepricingblackscholesView, b : FinancepricingblackscholesView) -> FinancepricingblackscholesView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_black_scholes_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_black_scholes_view_copy(s : FinancepricingblackscholesView) -> FinancepricingblackscholesView {
  let result = finance_pricing_black_scholes_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_black_scholes_view_fill(s : FinancepricingblackscholesView, v : Double) -> FinancepricingblackscholesView {
  let result = finance_pricing_black_scholes_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_view_min(s : FinancepricingblackscholesView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_view_max(s : FinancepricingblackscholesView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_view_to_string(s : FinancepricingblackscholesView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_range_make(size : Int) -> FinancepricingblackscholesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_range_len(s : FinancepricingblackscholesRange) -> Int { s.size }

pub fn finance_pricing_black_scholes_range_get(s : FinancepricingblackscholesRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_range_set(s : FinancepricingblackscholesRange, i : Int, v : Double) -> FinancepricingblackscholesRange {
  let result = finance_pricing_black_scholes_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_range_sum(s : FinancepricingblackscholesRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_black_scholes_range_mean(s : FinancepricingblackscholesRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_black_scholes_range_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_black_scholes_range_scale(s : FinancepricingblackscholesRange, f : Double) -> FinancepricingblackscholesRange {
  let result = finance_pricing_black_scholes_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_black_scholes_range_add(a : FinancepricingblackscholesRange, b : FinancepricingblackscholesRange) -> FinancepricingblackscholesRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_black_scholes_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_black_scholes_range_copy(s : FinancepricingblackscholesRange) -> FinancepricingblackscholesRange {
  let result = finance_pricing_black_scholes_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_black_scholes_range_fill(s : FinancepricingblackscholesRange, v : Double) -> FinancepricingblackscholesRange {
  let result = finance_pricing_black_scholes_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_range_min(s : FinancepricingblackscholesRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_range_max(s : FinancepricingblackscholesRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_range_to_string(s : FinancepricingblackscholesRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_slice_make(size : Int) -> FinancepricingblackscholesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_slice_len(s : FinancepricingblackscholesSlice) -> Int { s.size }

pub fn finance_pricing_black_scholes_slice_get(s : FinancepricingblackscholesSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_slice_set(s : FinancepricingblackscholesSlice, i : Int, v : Double) -> FinancepricingblackscholesSlice {
  let result = finance_pricing_black_scholes_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_slice_sum(s : FinancepricingblackscholesSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_black_scholes_slice_mean(s : FinancepricingblackscholesSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_black_scholes_slice_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_black_scholes_slice_scale(s : FinancepricingblackscholesSlice, f : Double) -> FinancepricingblackscholesSlice {
  let result = finance_pricing_black_scholes_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_black_scholes_slice_add(a : FinancepricingblackscholesSlice, b : FinancepricingblackscholesSlice) -> FinancepricingblackscholesSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_black_scholes_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_black_scholes_slice_copy(s : FinancepricingblackscholesSlice) -> FinancepricingblackscholesSlice {
  let result = finance_pricing_black_scholes_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_black_scholes_slice_fill(s : FinancepricingblackscholesSlice, v : Double) -> FinancepricingblackscholesSlice {
  let result = finance_pricing_black_scholes_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_black_scholes_slice_min(s : FinancepricingblackscholesSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_slice_max(s : FinancepricingblackscholesSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_black_scholes_slice_to_string(s : FinancepricingblackscholesSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

