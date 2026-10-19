///===
/// extcore/finance_risk_scenario

pub(all) struct FinanceriskscenarioPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_scenario_make_point(x : Double, y : Double) -> FinanceriskscenarioPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_scenario_make_point3(x : Double, y : Double, z : Double) -> FinanceriskscenarioPoint {
  { x, y, z, label: 0 }
}

pub fn finance_risk_scenario_point_x(pt : FinanceriskscenarioPoint) -> Double { pt.x }

pub fn finance_risk_scenario_point_y(pt : FinanceriskscenarioPoint) -> Double { pt.y }

pub fn finance_risk_scenario_point_z(pt : FinanceriskscenarioPoint) -> Double { pt.z }

pub fn finance_risk_scenario_point_label(pt : FinanceriskscenarioPoint) -> Int { pt.label }

pub fn finance_risk_scenario_point_dist(a : FinanceriskscenarioPoint, b : FinanceriskscenarioPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_risk_scenario_point_add(a : FinanceriskscenarioPoint, b : FinanceriskscenarioPoint) -> FinanceriskscenarioPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_risk_scenario_point_sub(a : FinanceriskscenarioPoint, b : FinanceriskscenarioPoint) -> FinanceriskscenarioPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_risk_scenario_point_scale(pt : FinanceriskscenarioPoint, s : Double) -> FinanceriskscenarioPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_risk_scenario_point_dot(a : FinanceriskscenarioPoint, b : FinanceriskscenarioPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_risk_scenario_point_cross(a : FinanceriskscenarioPoint, b : FinanceriskscenarioPoint) -> FinanceriskscenarioPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_risk_scenario_point_norm(pt : FinanceriskscenarioPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_risk_scenario_point_normalize(pt : FinanceriskscenarioPoint) -> FinanceriskscenarioPoint {
  let n = finance_risk_scenario_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_risk_scenario_point_scale(pt, 1.0 / n) }
}

pub fn finance_risk_scenario_point_negate(pt : FinanceriskscenarioPoint) -> FinanceriskscenarioPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_risk_scenario_point_mid(a : FinanceriskscenarioPoint, b : FinanceriskscenarioPoint) -> FinanceriskscenarioPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_risk_scenario_point_lerp(a : FinanceriskscenarioPoint, b : FinanceriskscenarioPoint, t : Double) -> FinanceriskscenarioPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_risk_scenario_point_to_string(pt : FinanceriskscenarioPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinanceriskscenarioSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_scenario_make_series(vals : Array[Double], name : String) -> FinanceriskscenarioSeries {
  { vals, name, meta: 0 }
}

pub fn finance_risk_scenario_series_len(s : FinanceriskscenarioSeries) -> Int { s.vals.length() }

pub fn finance_risk_scenario_series_sum(s : FinanceriskscenarioSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_risk_scenario_series_mean(s : FinanceriskscenarioSeries) -> Double {
  let n = finance_risk_scenario_series_len(s)
  if n == 0 { 0.0 } else { finance_risk_scenario_series_sum(s) / n.to_double() }
}

pub fn finance_risk_scenario_series_min(s : FinanceriskscenarioSeries) -> Double {
  let n = finance_risk_scenario_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_risk_scenario_series_max(s : FinanceriskscenarioSeries) -> Double {
  let n = finance_risk_scenario_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_risk_scenario_series_range(s : FinanceriskscenarioSeries) -> Double {
  finance_risk_scenario_series_max(s) - finance_risk_scenario_series_min(s)
}

pub fn finance_risk_scenario_series_var(s : FinanceriskscenarioSeries) -> Double {
  let n = finance_risk_scenario_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_risk_scenario_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_risk_scenario_series_std(s : FinanceriskscenarioSeries) -> Double { @_common.sqrt(finance_risk_scenario_series_var(s)) }

pub fn finance_risk_scenario_series_median(s : FinanceriskscenarioSeries) -> Double {
  let n = finance_risk_scenario_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_risk_scenario_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_risk_scenario_series_scale(s : FinanceriskscenarioSeries, f : Double) -> FinanceriskscenarioSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_risk_scenario_series_add(a : FinanceriskscenarioSeries, b : FinanceriskscenarioSeries) -> FinanceriskscenarioSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_risk_scenario_series_sub(a : FinanceriskscenarioSeries, b : FinanceriskscenarioSeries) -> FinanceriskscenarioSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_risk_scenario_series_normalize(s : FinanceriskscenarioSeries) -> FinanceriskscenarioSeries {
  let mn = finance_risk_scenario_series_min(s)
  let mx = finance_risk_scenario_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_risk_scenario_series_cumsum(s : FinanceriskscenarioSeries) -> FinanceriskscenarioSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_risk_scenario_series_to_string(s : FinanceriskscenarioSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskscenarioMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_scenario_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskscenarioMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_risk_scenario_matrix_identity(n : Int) -> FinanceriskscenarioMatrix {
  let m = finance_risk_scenario_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_risk_scenario_matrix_get(m : FinanceriskscenarioMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_risk_scenario_matrix_transpose(m : FinanceriskscenarioMatrix) -> FinanceriskscenarioMatrix {
  let result = finance_risk_scenario_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_risk_scenario_matrix_add(a : FinanceriskscenarioMatrix, b : FinanceriskscenarioMatrix) -> FinanceriskscenarioMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_risk_scenario_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_risk_scenario_matrix_scale(m : FinanceriskscenarioMatrix, s : Double) -> FinanceriskscenarioMatrix {
  let result = finance_risk_scenario_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_risk_scenario_matrix_multiply(a : FinanceriskscenarioMatrix, b : FinanceriskscenarioMatrix) -> FinanceriskscenarioMatrix {
  if a.cols != b.rows { return finance_risk_scenario_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_risk_scenario_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_risk_scenario_matrix_trace(m : FinanceriskscenarioMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_risk_scenario_matrix_det(m : FinanceriskscenarioMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_risk_scenario_matrix_norm(m : FinanceriskscenarioMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_risk_scenario_matrix_to_string(m : FinanceriskscenarioMatrix) -> String {
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

pub(all) struct FinanceriskscenarioVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_scenario_make_vector(comps : Array[Double]) -> FinanceriskscenarioVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_scenario_vector_zero(dim : Int) -> FinanceriskscenarioVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_risk_scenario_vector_add(a : FinanceriskscenarioVector, b : FinanceriskscenarioVector) -> FinanceriskscenarioVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_risk_scenario_vector_sub(a : FinanceriskscenarioVector, b : FinanceriskscenarioVector) -> FinanceriskscenarioVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_risk_scenario_vector_scale(v : FinanceriskscenarioVector, s : Double) -> FinanceriskscenarioVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_risk_scenario_vector_dot(a : FinanceriskscenarioVector, b : FinanceriskscenarioVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_risk_scenario_vector_norm(v : FinanceriskscenarioVector) -> Double { @_common.sqrt(finance_risk_scenario_vector_dot(v, v)) }

pub fn finance_risk_scenario_vector_normalize(v : FinanceriskscenarioVector) -> FinanceriskscenarioVector {
  let n = finance_risk_scenario_vector_norm(v)
  if n < 0.0000001 { v } else { finance_risk_scenario_vector_scale(v, 1.0 / n) }
}

pub fn finance_risk_scenario_vector_dist(a : FinanceriskscenarioVector, b : FinanceriskscenarioVector) -> Double {
  finance_risk_scenario_vector_norm(finance_risk_scenario_vector_sub(a, b))
}

pub fn finance_risk_scenario_vector_to_string(v : FinanceriskscenarioVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_risk_scenario_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn finance_risk_scenario_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = finance_risk_scenario_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_risk_scenario_std(data : Array[Double]) -> Double { @_common.sqrt(finance_risk_scenario_var(data)) }

pub fn finance_risk_scenario_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = finance_risk_scenario_mean(a); let mb = finance_risk_scenario_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn finance_risk_scenario_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = finance_risk_scenario_std(a); let sb = finance_risk_scenario_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { finance_risk_scenario_cov(a, b) / (sa * sb) }
}

pub fn finance_risk_scenario_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = finance_risk_scenario_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_risk_scenario_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn finance_risk_scenario_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_risk_scenario_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(finance_risk_scenario_mse(pred, labels))
}

pub fn finance_risk_scenario_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn finance_risk_scenario_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = finance_risk_scenario_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn finance_risk_scenario_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn finance_risk_scenario_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn finance_risk_scenario_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = finance_risk_scenario_precision(pred, labels, pos); let r = finance_risk_scenario_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn finance_risk_scenario_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn finance_risk_scenario_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = finance_risk_scenario_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn finance_risk_scenario_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn finance_risk_scenario_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn finance_risk_scenario_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = finance_risk_scenario_gcd(a, b)
    (a / g) * b
  }
}

pub fn finance_risk_scenario_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn finance_risk_scenario_fibonacci(n : Int) -> Int {
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

pub fn finance_risk_scenario_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = finance_risk_scenario_min(data); let mx = finance_risk_scenario_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn finance_risk_scenario_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = finance_risk_scenario_mean(data); let sd = finance_risk_scenario_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn finance_risk_scenario_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn finance_risk_scenario_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn finance_risk_scenario_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn finance_risk_scenario_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn finance_risk_scenario_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn finance_risk_scenario_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct FinanceriskscenarioFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_frame_make(size : Int) -> FinanceriskscenarioFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_frame_len(s : FinanceriskscenarioFrame) -> Int { s.size }

pub fn finance_risk_scenario_frame_get(s : FinanceriskscenarioFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_frame_set(s : FinanceriskscenarioFrame, i : Int, v : Double) -> FinanceriskscenarioFrame {
  let result = finance_risk_scenario_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_frame_sum(s : FinanceriskscenarioFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_scenario_frame_mean(s : FinanceriskscenarioFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_scenario_frame_sum(s) / s.size.to_double() }
}

pub fn finance_risk_scenario_frame_scale(s : FinanceriskscenarioFrame, f : Double) -> FinanceriskscenarioFrame {
  let result = finance_risk_scenario_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_scenario_frame_add(a : FinanceriskscenarioFrame, b : FinanceriskscenarioFrame) -> FinanceriskscenarioFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_scenario_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_scenario_frame_copy(s : FinanceriskscenarioFrame) -> FinanceriskscenarioFrame {
  let result = finance_risk_scenario_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_scenario_frame_fill(s : FinanceriskscenarioFrame, v : Double) -> FinanceriskscenarioFrame {
  let result = finance_risk_scenario_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_frame_min(s : FinanceriskscenarioFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_frame_max(s : FinanceriskscenarioFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_frame_to_string(s : FinanceriskscenarioFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_table_make(size : Int) -> FinanceriskscenarioTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_table_len(s : FinanceriskscenarioTable) -> Int { s.size }

pub fn finance_risk_scenario_table_get(s : FinanceriskscenarioTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_table_set(s : FinanceriskscenarioTable, i : Int, v : Double) -> FinanceriskscenarioTable {
  let result = finance_risk_scenario_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_table_sum(s : FinanceriskscenarioTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_scenario_table_mean(s : FinanceriskscenarioTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_scenario_table_sum(s) / s.size.to_double() }
}

pub fn finance_risk_scenario_table_scale(s : FinanceriskscenarioTable, f : Double) -> FinanceriskscenarioTable {
  let result = finance_risk_scenario_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_scenario_table_add(a : FinanceriskscenarioTable, b : FinanceriskscenarioTable) -> FinanceriskscenarioTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_scenario_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_scenario_table_copy(s : FinanceriskscenarioTable) -> FinanceriskscenarioTable {
  let result = finance_risk_scenario_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_scenario_table_fill(s : FinanceriskscenarioTable, v : Double) -> FinanceriskscenarioTable {
  let result = finance_risk_scenario_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_table_min(s : FinanceriskscenarioTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_table_max(s : FinanceriskscenarioTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_table_to_string(s : FinanceriskscenarioTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_graphn_make(size : Int) -> FinanceriskscenarioGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_graphn_len(s : FinanceriskscenarioGraphN) -> Int { s.size }

pub fn finance_risk_scenario_graphn_get(s : FinanceriskscenarioGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_graphn_set(s : FinanceriskscenarioGraphN, i : Int, v : Double) -> FinanceriskscenarioGraphN {
  let result = finance_risk_scenario_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_graphn_sum(s : FinanceriskscenarioGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_scenario_graphn_mean(s : FinanceriskscenarioGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_scenario_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_risk_scenario_graphn_scale(s : FinanceriskscenarioGraphN, f : Double) -> FinanceriskscenarioGraphN {
  let result = finance_risk_scenario_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_scenario_graphn_add(a : FinanceriskscenarioGraphN, b : FinanceriskscenarioGraphN) -> FinanceriskscenarioGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_scenario_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_scenario_graphn_copy(s : FinanceriskscenarioGraphN) -> FinanceriskscenarioGraphN {
  let result = finance_risk_scenario_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_scenario_graphn_fill(s : FinanceriskscenarioGraphN, v : Double) -> FinanceriskscenarioGraphN {
  let result = finance_risk_scenario_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_graphn_min(s : FinanceriskscenarioGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_graphn_max(s : FinanceriskscenarioGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_graphn_to_string(s : FinanceriskscenarioGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_node_make(size : Int) -> FinanceriskscenarioNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_node_len(s : FinanceriskscenarioNode) -> Int { s.size }

pub fn finance_risk_scenario_node_get(s : FinanceriskscenarioNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_node_set(s : FinanceriskscenarioNode, i : Int, v : Double) -> FinanceriskscenarioNode {
  let result = finance_risk_scenario_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_node_sum(s : FinanceriskscenarioNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_scenario_node_mean(s : FinanceriskscenarioNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_scenario_node_sum(s) / s.size.to_double() }
}

pub fn finance_risk_scenario_node_scale(s : FinanceriskscenarioNode, f : Double) -> FinanceriskscenarioNode {
  let result = finance_risk_scenario_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_scenario_node_add(a : FinanceriskscenarioNode, b : FinanceriskscenarioNode) -> FinanceriskscenarioNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_scenario_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_scenario_node_copy(s : FinanceriskscenarioNode) -> FinanceriskscenarioNode {
  let result = finance_risk_scenario_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_scenario_node_fill(s : FinanceriskscenarioNode, v : Double) -> FinanceriskscenarioNode {
  let result = finance_risk_scenario_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_node_min(s : FinanceriskscenarioNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_node_max(s : FinanceriskscenarioNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_node_to_string(s : FinanceriskscenarioNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_edge_make(size : Int) -> FinanceriskscenarioEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_edge_len(s : FinanceriskscenarioEdge) -> Int { s.size }

pub fn finance_risk_scenario_edge_get(s : FinanceriskscenarioEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_edge_set(s : FinanceriskscenarioEdge, i : Int, v : Double) -> FinanceriskscenarioEdge {
  let result = finance_risk_scenario_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_edge_sum(s : FinanceriskscenarioEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_scenario_edge_mean(s : FinanceriskscenarioEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_scenario_edge_sum(s) / s.size.to_double() }
}

pub fn finance_risk_scenario_edge_scale(s : FinanceriskscenarioEdge, f : Double) -> FinanceriskscenarioEdge {
  let result = finance_risk_scenario_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_scenario_edge_add(a : FinanceriskscenarioEdge, b : FinanceriskscenarioEdge) -> FinanceriskscenarioEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_scenario_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_scenario_edge_copy(s : FinanceriskscenarioEdge) -> FinanceriskscenarioEdge {
  let result = finance_risk_scenario_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_scenario_edge_fill(s : FinanceriskscenarioEdge, v : Double) -> FinanceriskscenarioEdge {
  let result = finance_risk_scenario_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_edge_min(s : FinanceriskscenarioEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_edge_max(s : FinanceriskscenarioEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_edge_to_string(s : FinanceriskscenarioEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_path_make(size : Int) -> FinanceriskscenarioPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_path_len(s : FinanceriskscenarioPath) -> Int { s.size }

pub fn finance_risk_scenario_path_get(s : FinanceriskscenarioPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_path_set(s : FinanceriskscenarioPath, i : Int, v : Double) -> FinanceriskscenarioPath {
  let result = finance_risk_scenario_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_path_sum(s : FinanceriskscenarioPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_scenario_path_mean(s : FinanceriskscenarioPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_scenario_path_sum(s) / s.size.to_double() }
}

pub fn finance_risk_scenario_path_scale(s : FinanceriskscenarioPath, f : Double) -> FinanceriskscenarioPath {
  let result = finance_risk_scenario_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_scenario_path_add(a : FinanceriskscenarioPath, b : FinanceriskscenarioPath) -> FinanceriskscenarioPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_scenario_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_scenario_path_copy(s : FinanceriskscenarioPath) -> FinanceriskscenarioPath {
  let result = finance_risk_scenario_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_scenario_path_fill(s : FinanceriskscenarioPath, v : Double) -> FinanceriskscenarioPath {
  let result = finance_risk_scenario_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_path_min(s : FinanceriskscenarioPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_path_max(s : FinanceriskscenarioPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_path_to_string(s : FinanceriskscenarioPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_cluster_make(size : Int) -> FinanceriskscenarioCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_cluster_len(s : FinanceriskscenarioCluster) -> Int { s.size }

pub fn finance_risk_scenario_cluster_get(s : FinanceriskscenarioCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_cluster_set(s : FinanceriskscenarioCluster, i : Int, v : Double) -> FinanceriskscenarioCluster {
  let result = finance_risk_scenario_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_cluster_sum(s : FinanceriskscenarioCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_scenario_cluster_mean(s : FinanceriskscenarioCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_scenario_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_risk_scenario_cluster_scale(s : FinanceriskscenarioCluster, f : Double) -> FinanceriskscenarioCluster {
  let result = finance_risk_scenario_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_scenario_cluster_add(a : FinanceriskscenarioCluster, b : FinanceriskscenarioCluster) -> FinanceriskscenarioCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_scenario_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_scenario_cluster_copy(s : FinanceriskscenarioCluster) -> FinanceriskscenarioCluster {
  let result = finance_risk_scenario_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_scenario_cluster_fill(s : FinanceriskscenarioCluster, v : Double) -> FinanceriskscenarioCluster {
  let result = finance_risk_scenario_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_cluster_min(s : FinanceriskscenarioCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_cluster_max(s : FinanceriskscenarioCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_cluster_to_string(s : FinanceriskscenarioCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_model_make(size : Int) -> FinanceriskscenarioModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_model_len(s : FinanceriskscenarioModel) -> Int { s.size }

pub fn finance_risk_scenario_model_get(s : FinanceriskscenarioModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_model_set(s : FinanceriskscenarioModel, i : Int, v : Double) -> FinanceriskscenarioModel {
  let result = finance_risk_scenario_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_model_sum(s : FinanceriskscenarioModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_scenario_model_mean(s : FinanceriskscenarioModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_scenario_model_sum(s) / s.size.to_double() }
}

pub fn finance_risk_scenario_model_scale(s : FinanceriskscenarioModel, f : Double) -> FinanceriskscenarioModel {
  let result = finance_risk_scenario_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_scenario_model_add(a : FinanceriskscenarioModel, b : FinanceriskscenarioModel) -> FinanceriskscenarioModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_scenario_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_scenario_model_copy(s : FinanceriskscenarioModel) -> FinanceriskscenarioModel {
  let result = finance_risk_scenario_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_scenario_model_fill(s : FinanceriskscenarioModel, v : Double) -> FinanceriskscenarioModel {
  let result = finance_risk_scenario_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_model_min(s : FinanceriskscenarioModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_model_max(s : FinanceriskscenarioModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_model_to_string(s : FinanceriskscenarioModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_layer_make(size : Int) -> FinanceriskscenarioLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_layer_len(s : FinanceriskscenarioLayer) -> Int { s.size }

pub fn finance_risk_scenario_layer_get(s : FinanceriskscenarioLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_layer_set(s : FinanceriskscenarioLayer, i : Int, v : Double) -> FinanceriskscenarioLayer {
  let result = finance_risk_scenario_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_layer_sum(s : FinanceriskscenarioLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_scenario_layer_mean(s : FinanceriskscenarioLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_scenario_layer_sum(s) / s.size.to_double() }
}

pub fn finance_risk_scenario_layer_scale(s : FinanceriskscenarioLayer, f : Double) -> FinanceriskscenarioLayer {
  let result = finance_risk_scenario_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_scenario_layer_add(a : FinanceriskscenarioLayer, b : FinanceriskscenarioLayer) -> FinanceriskscenarioLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_scenario_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_scenario_layer_copy(s : FinanceriskscenarioLayer) -> FinanceriskscenarioLayer {
  let result = finance_risk_scenario_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_scenario_layer_fill(s : FinanceriskscenarioLayer, v : Double) -> FinanceriskscenarioLayer {
  let result = finance_risk_scenario_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_layer_min(s : FinanceriskscenarioLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_layer_max(s : FinanceriskscenarioLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_layer_to_string(s : FinanceriskscenarioLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_buffer_make(size : Int) -> FinanceriskscenarioBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_buffer_len(s : FinanceriskscenarioBuffer) -> Int { s.size }

pub fn finance_risk_scenario_buffer_get(s : FinanceriskscenarioBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_buffer_set(s : FinanceriskscenarioBuffer, i : Int, v : Double) -> FinanceriskscenarioBuffer {
  let result = finance_risk_scenario_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_buffer_sum(s : FinanceriskscenarioBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_scenario_buffer_mean(s : FinanceriskscenarioBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_scenario_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_risk_scenario_buffer_scale(s : FinanceriskscenarioBuffer, f : Double) -> FinanceriskscenarioBuffer {
  let result = finance_risk_scenario_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_scenario_buffer_add(a : FinanceriskscenarioBuffer, b : FinanceriskscenarioBuffer) -> FinanceriskscenarioBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_scenario_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_scenario_buffer_copy(s : FinanceriskscenarioBuffer) -> FinanceriskscenarioBuffer {
  let result = finance_risk_scenario_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_scenario_buffer_fill(s : FinanceriskscenarioBuffer, v : Double) -> FinanceriskscenarioBuffer {
  let result = finance_risk_scenario_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_buffer_min(s : FinanceriskscenarioBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_buffer_max(s : FinanceriskscenarioBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_buffer_to_string(s : FinanceriskscenarioBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_cursor_make(size : Int) -> FinanceriskscenarioCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_cursor_len(s : FinanceriskscenarioCursor) -> Int { s.size }

pub fn finance_risk_scenario_cursor_get(s : FinanceriskscenarioCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_cursor_set(s : FinanceriskscenarioCursor, i : Int, v : Double) -> FinanceriskscenarioCursor {
  let result = finance_risk_scenario_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_cursor_sum(s : FinanceriskscenarioCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_scenario_cursor_mean(s : FinanceriskscenarioCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_scenario_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_risk_scenario_cursor_scale(s : FinanceriskscenarioCursor, f : Double) -> FinanceriskscenarioCursor {
  let result = finance_risk_scenario_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_scenario_cursor_add(a : FinanceriskscenarioCursor, b : FinanceriskscenarioCursor) -> FinanceriskscenarioCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_scenario_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_scenario_cursor_copy(s : FinanceriskscenarioCursor) -> FinanceriskscenarioCursor {
  let result = finance_risk_scenario_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_scenario_cursor_fill(s : FinanceriskscenarioCursor, v : Double) -> FinanceriskscenarioCursor {
  let result = finance_risk_scenario_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_cursor_min(s : FinanceriskscenarioCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_cursor_max(s : FinanceriskscenarioCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_cursor_to_string(s : FinanceriskscenarioCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_view_make(size : Int) -> FinanceriskscenarioView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_view_len(s : FinanceriskscenarioView) -> Int { s.size }

pub fn finance_risk_scenario_view_get(s : FinanceriskscenarioView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_view_set(s : FinanceriskscenarioView, i : Int, v : Double) -> FinanceriskscenarioView {
  let result = finance_risk_scenario_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_view_sum(s : FinanceriskscenarioView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_scenario_view_mean(s : FinanceriskscenarioView) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_scenario_view_sum(s) / s.size.to_double() }
}

pub fn finance_risk_scenario_view_scale(s : FinanceriskscenarioView, f : Double) -> FinanceriskscenarioView {
  let result = finance_risk_scenario_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_scenario_view_add(a : FinanceriskscenarioView, b : FinanceriskscenarioView) -> FinanceriskscenarioView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_scenario_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_scenario_view_copy(s : FinanceriskscenarioView) -> FinanceriskscenarioView {
  let result = finance_risk_scenario_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_scenario_view_fill(s : FinanceriskscenarioView, v : Double) -> FinanceriskscenarioView {
  let result = finance_risk_scenario_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_view_min(s : FinanceriskscenarioView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_view_max(s : FinanceriskscenarioView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_view_to_string(s : FinanceriskscenarioView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_range_make(size : Int) -> FinanceriskscenarioRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_range_len(s : FinanceriskscenarioRange) -> Int { s.size }

pub fn finance_risk_scenario_range_get(s : FinanceriskscenarioRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_range_set(s : FinanceriskscenarioRange, i : Int, v : Double) -> FinanceriskscenarioRange {
  let result = finance_risk_scenario_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_range_sum(s : FinanceriskscenarioRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_scenario_range_mean(s : FinanceriskscenarioRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_scenario_range_sum(s) / s.size.to_double() }
}

pub fn finance_risk_scenario_range_scale(s : FinanceriskscenarioRange, f : Double) -> FinanceriskscenarioRange {
  let result = finance_risk_scenario_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_scenario_range_add(a : FinanceriskscenarioRange, b : FinanceriskscenarioRange) -> FinanceriskscenarioRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_scenario_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_scenario_range_copy(s : FinanceriskscenarioRange) -> FinanceriskscenarioRange {
  let result = finance_risk_scenario_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_scenario_range_fill(s : FinanceriskscenarioRange, v : Double) -> FinanceriskscenarioRange {
  let result = finance_risk_scenario_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_range_min(s : FinanceriskscenarioRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_range_max(s : FinanceriskscenarioRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_range_to_string(s : FinanceriskscenarioRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_slice_make(size : Int) -> FinanceriskscenarioSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_slice_len(s : FinanceriskscenarioSlice) -> Int { s.size }

pub fn finance_risk_scenario_slice_get(s : FinanceriskscenarioSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_slice_set(s : FinanceriskscenarioSlice, i : Int, v : Double) -> FinanceriskscenarioSlice {
  let result = finance_risk_scenario_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_slice_sum(s : FinanceriskscenarioSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_scenario_slice_mean(s : FinanceriskscenarioSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_scenario_slice_sum(s) / s.size.to_double() }
}

pub fn finance_risk_scenario_slice_scale(s : FinanceriskscenarioSlice, f : Double) -> FinanceriskscenarioSlice {
  let result = finance_risk_scenario_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_scenario_slice_add(a : FinanceriskscenarioSlice, b : FinanceriskscenarioSlice) -> FinanceriskscenarioSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_scenario_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_scenario_slice_copy(s : FinanceriskscenarioSlice) -> FinanceriskscenarioSlice {
  let result = finance_risk_scenario_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_scenario_slice_fill(s : FinanceriskscenarioSlice, v : Double) -> FinanceriskscenarioSlice {
  let result = finance_risk_scenario_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_scenario_slice_min(s : FinanceriskscenarioSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_slice_max(s : FinanceriskscenarioSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_scenario_slice_to_string(s : FinanceriskscenarioSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

