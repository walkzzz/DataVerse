///===
/// extcore/finance_risk_stress

pub(all) struct FinanceriskstressPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_stress_make_point(x : Double, y : Double) -> FinanceriskstressPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_stress_make_point3(x : Double, y : Double, z : Double) -> FinanceriskstressPoint {
  { x, y, z, label: 0 }
}

pub fn finance_risk_stress_point_x(pt : FinanceriskstressPoint) -> Double { pt.x }

pub fn finance_risk_stress_point_y(pt : FinanceriskstressPoint) -> Double { pt.y }

pub fn finance_risk_stress_point_z(pt : FinanceriskstressPoint) -> Double { pt.z }

pub fn finance_risk_stress_point_label(pt : FinanceriskstressPoint) -> Int { pt.label }

pub fn finance_risk_stress_point_dist(a : FinanceriskstressPoint, b : FinanceriskstressPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  finance_risk_stress_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_risk_stress_point_add(a : FinanceriskstressPoint, b : FinanceriskstressPoint) -> FinanceriskstressPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_risk_stress_point_sub(a : FinanceriskstressPoint, b : FinanceriskstressPoint) -> FinanceriskstressPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_risk_stress_point_scale(pt : FinanceriskstressPoint, s : Double) -> FinanceriskstressPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_risk_stress_point_dot(a : FinanceriskstressPoint, b : FinanceriskstressPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_risk_stress_point_cross(a : FinanceriskstressPoint, b : FinanceriskstressPoint) -> FinanceriskstressPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_risk_stress_point_norm(pt : FinanceriskstressPoint) -> Double {
  finance_risk_stress_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_risk_stress_point_normalize(pt : FinanceriskstressPoint) -> FinanceriskstressPoint {
  let n = finance_risk_stress_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_risk_stress_point_scale(pt, 1.0 / n) }
}

pub fn finance_risk_stress_point_negate(pt : FinanceriskstressPoint) -> FinanceriskstressPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_risk_stress_point_mid(a : FinanceriskstressPoint, b : FinanceriskstressPoint) -> FinanceriskstressPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_risk_stress_point_lerp(a : FinanceriskstressPoint, b : FinanceriskstressPoint, t : Double) -> FinanceriskstressPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_risk_stress_point_to_string(pt : FinanceriskstressPoint) -> String {
  "(" + finance_risk_stress_dbl(pt.x) + ", " + finance_risk_stress_dbl(pt.y) + ", " + finance_risk_stress_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinanceriskstressSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_stress_make_series(vals : Array[Double], name : String) -> FinanceriskstressSeries {
  { vals, name, meta: 0 }
}

pub fn finance_risk_stress_series_len(s : FinanceriskstressSeries) -> Int { s.vals.length() }

pub fn finance_risk_stress_series_sum(s : FinanceriskstressSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_risk_stress_series_mean(s : FinanceriskstressSeries) -> Double {
  let n = finance_risk_stress_series_len(s)
  if n == 0 { 0.0 } else { finance_risk_stress_series_sum(s) / n.to_double() }
}

pub fn finance_risk_stress_series_min(s : FinanceriskstressSeries) -> Double {
  let n = finance_risk_stress_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_risk_stress_series_max(s : FinanceriskstressSeries) -> Double {
  let n = finance_risk_stress_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_risk_stress_series_range(s : FinanceriskstressSeries) -> Double {
  finance_risk_stress_series_max(s) - finance_risk_stress_series_min(s)
}

pub fn finance_risk_stress_series_var(s : FinanceriskstressSeries) -> Double {
  let n = finance_risk_stress_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_risk_stress_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_risk_stress_series_std(s : FinanceriskstressSeries) -> Double { finance_risk_stress_sqrt(finance_risk_stress_series_var(s)) }

pub fn finance_risk_stress_series_median(s : FinanceriskstressSeries) -> Double {
  let n = finance_risk_stress_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_risk_stress_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_risk_stress_series_scale(s : FinanceriskstressSeries, f : Double) -> FinanceriskstressSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = finance_risk_stress_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_risk_stress_series_add(a : FinanceriskstressSeries, b : FinanceriskstressSeries) -> FinanceriskstressSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_risk_stress_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_risk_stress_series_sub(a : FinanceriskstressSeries, b : FinanceriskstressSeries) -> FinanceriskstressSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_risk_stress_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_risk_stress_series_normalize(s : FinanceriskstressSeries) -> FinanceriskstressSeries {
  let mn = finance_risk_stress_series_min(s)
  let mx = finance_risk_stress_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = finance_risk_stress_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_risk_stress_series_cumsum(s : FinanceriskstressSeries) -> FinanceriskstressSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = finance_risk_stress_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_risk_stress_series_to_string(s : FinanceriskstressSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_risk_stress_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskstressMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_stress_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskstressMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_risk_stress_matrix_identity(n : Int) -> FinanceriskstressMatrix {
  let m = finance_risk_stress_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_risk_stress_matrix_get(m : FinanceriskstressMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_risk_stress_matrix_transpose(m : FinanceriskstressMatrix) -> FinanceriskstressMatrix {
  let result = finance_risk_stress_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_risk_stress_matrix_add(a : FinanceriskstressMatrix, b : FinanceriskstressMatrix) -> FinanceriskstressMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_risk_stress_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_risk_stress_matrix_scale(m : FinanceriskstressMatrix, s : Double) -> FinanceriskstressMatrix {
  let result = finance_risk_stress_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_risk_stress_matrix_multiply(a : FinanceriskstressMatrix, b : FinanceriskstressMatrix) -> FinanceriskstressMatrix {
  if a.cols != b.rows { return finance_risk_stress_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_risk_stress_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_risk_stress_matrix_trace(m : FinanceriskstressMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_risk_stress_matrix_det(m : FinanceriskstressMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_risk_stress_matrix_norm(m : FinanceriskstressMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  finance_risk_stress_sqrt(sum)
}

pub fn finance_risk_stress_matrix_to_string(m : FinanceriskstressMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + finance_risk_stress_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct FinanceriskstressVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_stress_make_vector(comps : Array[Double]) -> FinanceriskstressVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_stress_vector_zero(dim : Int) -> FinanceriskstressVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_risk_stress_vector_add(a : FinanceriskstressVector, b : FinanceriskstressVector) -> FinanceriskstressVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_risk_stress_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_risk_stress_vector_sub(a : FinanceriskstressVector, b : FinanceriskstressVector) -> FinanceriskstressVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_risk_stress_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_risk_stress_vector_scale(v : FinanceriskstressVector, s : Double) -> FinanceriskstressVector {
  let mut result = []
  for i in 0..<v.dim { result = finance_risk_stress_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_risk_stress_vector_dot(a : FinanceriskstressVector, b : FinanceriskstressVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_risk_stress_vector_norm(v : FinanceriskstressVector) -> Double { finance_risk_stress_sqrt(finance_risk_stress_vector_dot(v, v)) }

pub fn finance_risk_stress_vector_normalize(v : FinanceriskstressVector) -> FinanceriskstressVector {
  let n = finance_risk_stress_vector_norm(v)
  if n < 0.0000001 { v } else { finance_risk_stress_vector_scale(v, 1.0 / n) }
}

pub fn finance_risk_stress_vector_dist(a : FinanceriskstressVector, b : FinanceriskstressVector) -> Double {
  finance_risk_stress_vector_norm(finance_risk_stress_vector_sub(a, b))
}

pub fn finance_risk_stress_vector_to_string(v : FinanceriskstressVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_risk_stress_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_risk_stress_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn finance_risk_stress_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = finance_risk_stress_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_risk_stress_std(data : Array[Double]) -> Double { finance_risk_stress_sqrt(finance_risk_stress_var(data)) }

pub fn finance_risk_stress_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = finance_risk_stress_mean(a); let mb = finance_risk_stress_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn finance_risk_stress_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = finance_risk_stress_std(a); let sb = finance_risk_stress_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { finance_risk_stress_cov(a, b) / (sa * sb) }
}

pub fn finance_risk_stress_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = finance_risk_stress_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_risk_stress_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn finance_risk_stress_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_risk_stress_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  finance_risk_stress_sqrt(finance_risk_stress_mse(pred, labels))
}

pub fn finance_risk_stress_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + finance_risk_stress_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn finance_risk_stress_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = finance_risk_stress_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn finance_risk_stress_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn finance_risk_stress_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn finance_risk_stress_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = finance_risk_stress_precision(pred, labels, pos); let r = finance_risk_stress_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn finance_risk_stress_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn finance_risk_stress_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = finance_risk_stress_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn finance_risk_stress_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn finance_risk_stress_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn finance_risk_stress_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = finance_risk_stress_gcd(a, b)
    (a / g) * b
  }
}

pub fn finance_risk_stress_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn finance_risk_stress_fibonacci(n : Int) -> Int {
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

pub fn finance_risk_stress_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = finance_risk_stress_min(data); let mx = finance_risk_stress_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn finance_risk_stress_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = finance_risk_stress_mean(data); let sd = finance_risk_stress_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn finance_risk_stress_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn finance_risk_stress_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn finance_risk_stress_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn finance_risk_stress_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn finance_risk_stress_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn finance_risk_stress_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn finance_risk_stress_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn finance_risk_stress_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn finance_risk_stress_dbl(x : Double) -> String {
  let i = if x >= 0.0 { finance_risk_stress_int(x) } else { -finance_risk_stress_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { finance_risk_stress_int(f * 1000000.0) } else { finance_risk_stress_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn finance_risk_stress_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn finance_risk_stress_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct FinanceriskstressFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_frame_make(size : Int) -> FinanceriskstressFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_frame_len(s : FinanceriskstressFrame) -> Int { s.size }

pub fn finance_risk_stress_frame_get(s : FinanceriskstressFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_frame_set(s : FinanceriskstressFrame, i : Int, v : Double) -> FinanceriskstressFrame {
  let result = finance_risk_stress_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_frame_sum(s : FinanceriskstressFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_stress_frame_mean(s : FinanceriskstressFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_stress_frame_sum(s) / s.size.to_double() }
}

pub fn finance_risk_stress_frame_scale(s : FinanceriskstressFrame, f : Double) -> FinanceriskstressFrame {
  let result = finance_risk_stress_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_stress_frame_add(a : FinanceriskstressFrame, b : FinanceriskstressFrame) -> FinanceriskstressFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_stress_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_stress_frame_copy(s : FinanceriskstressFrame) -> FinanceriskstressFrame {
  let result = finance_risk_stress_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_stress_frame_fill(s : FinanceriskstressFrame, v : Double) -> FinanceriskstressFrame {
  let result = finance_risk_stress_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_frame_min(s : FinanceriskstressFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_frame_max(s : FinanceriskstressFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_frame_to_string(s : FinanceriskstressFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_table_make(size : Int) -> FinanceriskstressTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_table_len(s : FinanceriskstressTable) -> Int { s.size }

pub fn finance_risk_stress_table_get(s : FinanceriskstressTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_table_set(s : FinanceriskstressTable, i : Int, v : Double) -> FinanceriskstressTable {
  let result = finance_risk_stress_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_table_sum(s : FinanceriskstressTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_stress_table_mean(s : FinanceriskstressTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_stress_table_sum(s) / s.size.to_double() }
}

pub fn finance_risk_stress_table_scale(s : FinanceriskstressTable, f : Double) -> FinanceriskstressTable {
  let result = finance_risk_stress_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_stress_table_add(a : FinanceriskstressTable, b : FinanceriskstressTable) -> FinanceriskstressTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_stress_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_stress_table_copy(s : FinanceriskstressTable) -> FinanceriskstressTable {
  let result = finance_risk_stress_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_stress_table_fill(s : FinanceriskstressTable, v : Double) -> FinanceriskstressTable {
  let result = finance_risk_stress_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_table_min(s : FinanceriskstressTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_table_max(s : FinanceriskstressTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_table_to_string(s : FinanceriskstressTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_graphn_make(size : Int) -> FinanceriskstressGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_graphn_len(s : FinanceriskstressGraphN) -> Int { s.size }

pub fn finance_risk_stress_graphn_get(s : FinanceriskstressGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_graphn_set(s : FinanceriskstressGraphN, i : Int, v : Double) -> FinanceriskstressGraphN {
  let result = finance_risk_stress_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_graphn_sum(s : FinanceriskstressGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_stress_graphn_mean(s : FinanceriskstressGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_stress_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_risk_stress_graphn_scale(s : FinanceriskstressGraphN, f : Double) -> FinanceriskstressGraphN {
  let result = finance_risk_stress_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_stress_graphn_add(a : FinanceriskstressGraphN, b : FinanceriskstressGraphN) -> FinanceriskstressGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_stress_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_stress_graphn_copy(s : FinanceriskstressGraphN) -> FinanceriskstressGraphN {
  let result = finance_risk_stress_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_stress_graphn_fill(s : FinanceriskstressGraphN, v : Double) -> FinanceriskstressGraphN {
  let result = finance_risk_stress_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_graphn_min(s : FinanceriskstressGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_graphn_max(s : FinanceriskstressGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_graphn_to_string(s : FinanceriskstressGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_node_make(size : Int) -> FinanceriskstressNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_node_len(s : FinanceriskstressNode) -> Int { s.size }

pub fn finance_risk_stress_node_get(s : FinanceriskstressNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_node_set(s : FinanceriskstressNode, i : Int, v : Double) -> FinanceriskstressNode {
  let result = finance_risk_stress_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_node_sum(s : FinanceriskstressNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_stress_node_mean(s : FinanceriskstressNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_stress_node_sum(s) / s.size.to_double() }
}

pub fn finance_risk_stress_node_scale(s : FinanceriskstressNode, f : Double) -> FinanceriskstressNode {
  let result = finance_risk_stress_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_stress_node_add(a : FinanceriskstressNode, b : FinanceriskstressNode) -> FinanceriskstressNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_stress_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_stress_node_copy(s : FinanceriskstressNode) -> FinanceriskstressNode {
  let result = finance_risk_stress_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_stress_node_fill(s : FinanceriskstressNode, v : Double) -> FinanceriskstressNode {
  let result = finance_risk_stress_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_node_min(s : FinanceriskstressNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_node_max(s : FinanceriskstressNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_node_to_string(s : FinanceriskstressNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_edge_make(size : Int) -> FinanceriskstressEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_edge_len(s : FinanceriskstressEdge) -> Int { s.size }

pub fn finance_risk_stress_edge_get(s : FinanceriskstressEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_edge_set(s : FinanceriskstressEdge, i : Int, v : Double) -> FinanceriskstressEdge {
  let result = finance_risk_stress_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_edge_sum(s : FinanceriskstressEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_stress_edge_mean(s : FinanceriskstressEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_stress_edge_sum(s) / s.size.to_double() }
}

pub fn finance_risk_stress_edge_scale(s : FinanceriskstressEdge, f : Double) -> FinanceriskstressEdge {
  let result = finance_risk_stress_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_stress_edge_add(a : FinanceriskstressEdge, b : FinanceriskstressEdge) -> FinanceriskstressEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_stress_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_stress_edge_copy(s : FinanceriskstressEdge) -> FinanceriskstressEdge {
  let result = finance_risk_stress_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_stress_edge_fill(s : FinanceriskstressEdge, v : Double) -> FinanceriskstressEdge {
  let result = finance_risk_stress_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_edge_min(s : FinanceriskstressEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_edge_max(s : FinanceriskstressEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_edge_to_string(s : FinanceriskstressEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_path_make(size : Int) -> FinanceriskstressPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_path_len(s : FinanceriskstressPath) -> Int { s.size }

pub fn finance_risk_stress_path_get(s : FinanceriskstressPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_path_set(s : FinanceriskstressPath, i : Int, v : Double) -> FinanceriskstressPath {
  let result = finance_risk_stress_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_path_sum(s : FinanceriskstressPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_stress_path_mean(s : FinanceriskstressPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_stress_path_sum(s) / s.size.to_double() }
}

pub fn finance_risk_stress_path_scale(s : FinanceriskstressPath, f : Double) -> FinanceriskstressPath {
  let result = finance_risk_stress_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_stress_path_add(a : FinanceriskstressPath, b : FinanceriskstressPath) -> FinanceriskstressPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_stress_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_stress_path_copy(s : FinanceriskstressPath) -> FinanceriskstressPath {
  let result = finance_risk_stress_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_stress_path_fill(s : FinanceriskstressPath, v : Double) -> FinanceriskstressPath {
  let result = finance_risk_stress_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_path_min(s : FinanceriskstressPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_path_max(s : FinanceriskstressPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_path_to_string(s : FinanceriskstressPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_cluster_make(size : Int) -> FinanceriskstressCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_cluster_len(s : FinanceriskstressCluster) -> Int { s.size }

pub fn finance_risk_stress_cluster_get(s : FinanceriskstressCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_cluster_set(s : FinanceriskstressCluster, i : Int, v : Double) -> FinanceriskstressCluster {
  let result = finance_risk_stress_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_cluster_sum(s : FinanceriskstressCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_stress_cluster_mean(s : FinanceriskstressCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_stress_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_risk_stress_cluster_scale(s : FinanceriskstressCluster, f : Double) -> FinanceriskstressCluster {
  let result = finance_risk_stress_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_stress_cluster_add(a : FinanceriskstressCluster, b : FinanceriskstressCluster) -> FinanceriskstressCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_stress_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_stress_cluster_copy(s : FinanceriskstressCluster) -> FinanceriskstressCluster {
  let result = finance_risk_stress_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_stress_cluster_fill(s : FinanceriskstressCluster, v : Double) -> FinanceriskstressCluster {
  let result = finance_risk_stress_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_cluster_min(s : FinanceriskstressCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_cluster_max(s : FinanceriskstressCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_cluster_to_string(s : FinanceriskstressCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_model_make(size : Int) -> FinanceriskstressModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_model_len(s : FinanceriskstressModel) -> Int { s.size }

pub fn finance_risk_stress_model_get(s : FinanceriskstressModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_model_set(s : FinanceriskstressModel, i : Int, v : Double) -> FinanceriskstressModel {
  let result = finance_risk_stress_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_model_sum(s : FinanceriskstressModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_stress_model_mean(s : FinanceriskstressModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_stress_model_sum(s) / s.size.to_double() }
}

pub fn finance_risk_stress_model_scale(s : FinanceriskstressModel, f : Double) -> FinanceriskstressModel {
  let result = finance_risk_stress_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_stress_model_add(a : FinanceriskstressModel, b : FinanceriskstressModel) -> FinanceriskstressModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_stress_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_stress_model_copy(s : FinanceriskstressModel) -> FinanceriskstressModel {
  let result = finance_risk_stress_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_stress_model_fill(s : FinanceriskstressModel, v : Double) -> FinanceriskstressModel {
  let result = finance_risk_stress_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_model_min(s : FinanceriskstressModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_model_max(s : FinanceriskstressModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_model_to_string(s : FinanceriskstressModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_layer_make(size : Int) -> FinanceriskstressLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_layer_len(s : FinanceriskstressLayer) -> Int { s.size }

pub fn finance_risk_stress_layer_get(s : FinanceriskstressLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_layer_set(s : FinanceriskstressLayer, i : Int, v : Double) -> FinanceriskstressLayer {
  let result = finance_risk_stress_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_layer_sum(s : FinanceriskstressLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_stress_layer_mean(s : FinanceriskstressLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_stress_layer_sum(s) / s.size.to_double() }
}

pub fn finance_risk_stress_layer_scale(s : FinanceriskstressLayer, f : Double) -> FinanceriskstressLayer {
  let result = finance_risk_stress_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_stress_layer_add(a : FinanceriskstressLayer, b : FinanceriskstressLayer) -> FinanceriskstressLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_stress_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_stress_layer_copy(s : FinanceriskstressLayer) -> FinanceriskstressLayer {
  let result = finance_risk_stress_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_stress_layer_fill(s : FinanceriskstressLayer, v : Double) -> FinanceriskstressLayer {
  let result = finance_risk_stress_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_layer_min(s : FinanceriskstressLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_layer_max(s : FinanceriskstressLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_layer_to_string(s : FinanceriskstressLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_buffer_make(size : Int) -> FinanceriskstressBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_buffer_len(s : FinanceriskstressBuffer) -> Int { s.size }

pub fn finance_risk_stress_buffer_get(s : FinanceriskstressBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_buffer_set(s : FinanceriskstressBuffer, i : Int, v : Double) -> FinanceriskstressBuffer {
  let result = finance_risk_stress_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_buffer_sum(s : FinanceriskstressBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_stress_buffer_mean(s : FinanceriskstressBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_stress_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_risk_stress_buffer_scale(s : FinanceriskstressBuffer, f : Double) -> FinanceriskstressBuffer {
  let result = finance_risk_stress_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_stress_buffer_add(a : FinanceriskstressBuffer, b : FinanceriskstressBuffer) -> FinanceriskstressBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_stress_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_stress_buffer_copy(s : FinanceriskstressBuffer) -> FinanceriskstressBuffer {
  let result = finance_risk_stress_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_stress_buffer_fill(s : FinanceriskstressBuffer, v : Double) -> FinanceriskstressBuffer {
  let result = finance_risk_stress_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_buffer_min(s : FinanceriskstressBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_buffer_max(s : FinanceriskstressBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_buffer_to_string(s : FinanceriskstressBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_cursor_make(size : Int) -> FinanceriskstressCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_cursor_len(s : FinanceriskstressCursor) -> Int { s.size }

pub fn finance_risk_stress_cursor_get(s : FinanceriskstressCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_cursor_set(s : FinanceriskstressCursor, i : Int, v : Double) -> FinanceriskstressCursor {
  let result = finance_risk_stress_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_cursor_sum(s : FinanceriskstressCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_stress_cursor_mean(s : FinanceriskstressCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_stress_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_risk_stress_cursor_scale(s : FinanceriskstressCursor, f : Double) -> FinanceriskstressCursor {
  let result = finance_risk_stress_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_stress_cursor_add(a : FinanceriskstressCursor, b : FinanceriskstressCursor) -> FinanceriskstressCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_stress_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_stress_cursor_copy(s : FinanceriskstressCursor) -> FinanceriskstressCursor {
  let result = finance_risk_stress_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_stress_cursor_fill(s : FinanceriskstressCursor, v : Double) -> FinanceriskstressCursor {
  let result = finance_risk_stress_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_cursor_min(s : FinanceriskstressCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_cursor_max(s : FinanceriskstressCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_cursor_to_string(s : FinanceriskstressCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_view_make(size : Int) -> FinanceriskstressView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_view_len(s : FinanceriskstressView) -> Int { s.size }

pub fn finance_risk_stress_view_get(s : FinanceriskstressView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_view_set(s : FinanceriskstressView, i : Int, v : Double) -> FinanceriskstressView {
  let result = finance_risk_stress_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_view_sum(s : FinanceriskstressView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_stress_view_mean(s : FinanceriskstressView) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_stress_view_sum(s) / s.size.to_double() }
}

pub fn finance_risk_stress_view_scale(s : FinanceriskstressView, f : Double) -> FinanceriskstressView {
  let result = finance_risk_stress_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_stress_view_add(a : FinanceriskstressView, b : FinanceriskstressView) -> FinanceriskstressView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_stress_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_stress_view_copy(s : FinanceriskstressView) -> FinanceriskstressView {
  let result = finance_risk_stress_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_stress_view_fill(s : FinanceriskstressView, v : Double) -> FinanceriskstressView {
  let result = finance_risk_stress_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_view_min(s : FinanceriskstressView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_view_max(s : FinanceriskstressView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_view_to_string(s : FinanceriskstressView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_range_make(size : Int) -> FinanceriskstressRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_range_len(s : FinanceriskstressRange) -> Int { s.size }

pub fn finance_risk_stress_range_get(s : FinanceriskstressRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_range_set(s : FinanceriskstressRange, i : Int, v : Double) -> FinanceriskstressRange {
  let result = finance_risk_stress_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_range_sum(s : FinanceriskstressRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_stress_range_mean(s : FinanceriskstressRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_stress_range_sum(s) / s.size.to_double() }
}

pub fn finance_risk_stress_range_scale(s : FinanceriskstressRange, f : Double) -> FinanceriskstressRange {
  let result = finance_risk_stress_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_stress_range_add(a : FinanceriskstressRange, b : FinanceriskstressRange) -> FinanceriskstressRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_stress_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_stress_range_copy(s : FinanceriskstressRange) -> FinanceriskstressRange {
  let result = finance_risk_stress_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_stress_range_fill(s : FinanceriskstressRange, v : Double) -> FinanceriskstressRange {
  let result = finance_risk_stress_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_range_min(s : FinanceriskstressRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_range_max(s : FinanceriskstressRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_range_to_string(s : FinanceriskstressRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_slice_make(size : Int) -> FinanceriskstressSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_slice_len(s : FinanceriskstressSlice) -> Int { s.size }

pub fn finance_risk_stress_slice_get(s : FinanceriskstressSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_slice_set(s : FinanceriskstressSlice, i : Int, v : Double) -> FinanceriskstressSlice {
  let result = finance_risk_stress_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_slice_sum(s : FinanceriskstressSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_stress_slice_mean(s : FinanceriskstressSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_stress_slice_sum(s) / s.size.to_double() }
}

pub fn finance_risk_stress_slice_scale(s : FinanceriskstressSlice, f : Double) -> FinanceriskstressSlice {
  let result = finance_risk_stress_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_stress_slice_add(a : FinanceriskstressSlice, b : FinanceriskstressSlice) -> FinanceriskstressSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_stress_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_stress_slice_copy(s : FinanceriskstressSlice) -> FinanceriskstressSlice {
  let result = finance_risk_stress_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_stress_slice_fill(s : FinanceriskstressSlice, v : Double) -> FinanceriskstressSlice {
  let result = finance_risk_stress_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_stress_slice_min(s : FinanceriskstressSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_slice_max(s : FinanceriskstressSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_stress_slice_to_string(s : FinanceriskstressSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn finance_risk_stress_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_stress_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_stress_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_stress_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_stress_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_stress_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_stress_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_stress_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_stress_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_stress_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_stress_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_stress_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_stress_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_stress_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_stress_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_stress_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_stress_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_stress_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_stress_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_stress_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_stress_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_stress_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_stress_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_stress_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_stress_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

