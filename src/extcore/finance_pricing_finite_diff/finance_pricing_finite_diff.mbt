///===
/// extcore/finance_pricing_finite_diff

pub(all) struct FinancepricingfinitediffPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_finite_diff_make_point(x : Double, y : Double) -> FinancepricingfinitediffPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_finite_diff_make_point3(x : Double, y : Double, z : Double) -> FinancepricingfinitediffPoint {
  { x, y, z, label: 0 }
}

pub fn finance_pricing_finite_diff_point_x(pt : FinancepricingfinitediffPoint) -> Double { pt.x }

pub fn finance_pricing_finite_diff_point_y(pt : FinancepricingfinitediffPoint) -> Double { pt.y }

pub fn finance_pricing_finite_diff_point_z(pt : FinancepricingfinitediffPoint) -> Double { pt.z }

pub fn finance_pricing_finite_diff_point_label(pt : FinancepricingfinitediffPoint) -> Int { pt.label }

pub fn finance_pricing_finite_diff_point_dist(a : FinancepricingfinitediffPoint, b : FinancepricingfinitediffPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_pricing_finite_diff_point_add(a : FinancepricingfinitediffPoint, b : FinancepricingfinitediffPoint) -> FinancepricingfinitediffPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_pricing_finite_diff_point_sub(a : FinancepricingfinitediffPoint, b : FinancepricingfinitediffPoint) -> FinancepricingfinitediffPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_pricing_finite_diff_point_scale(pt : FinancepricingfinitediffPoint, s : Double) -> FinancepricingfinitediffPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_pricing_finite_diff_point_dot(a : FinancepricingfinitediffPoint, b : FinancepricingfinitediffPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_pricing_finite_diff_point_cross(a : FinancepricingfinitediffPoint, b : FinancepricingfinitediffPoint) -> FinancepricingfinitediffPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_pricing_finite_diff_point_norm(pt : FinancepricingfinitediffPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_pricing_finite_diff_point_normalize(pt : FinancepricingfinitediffPoint) -> FinancepricingfinitediffPoint {
  let n = finance_pricing_finite_diff_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_pricing_finite_diff_point_scale(pt, 1.0 / n) }
}

pub fn finance_pricing_finite_diff_point_negate(pt : FinancepricingfinitediffPoint) -> FinancepricingfinitediffPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_pricing_finite_diff_point_mid(a : FinancepricingfinitediffPoint, b : FinancepricingfinitediffPoint) -> FinancepricingfinitediffPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_pricing_finite_diff_point_lerp(a : FinancepricingfinitediffPoint, b : FinancepricingfinitediffPoint, t : Double) -> FinancepricingfinitediffPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_pricing_finite_diff_point_to_string(pt : FinancepricingfinitediffPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_finite_diff_make_series(vals : Array[Double], name : String) -> FinancepricingfinitediffSeries {
  { vals, name, meta: 0 }
}

pub fn finance_pricing_finite_diff_series_len(s : FinancepricingfinitediffSeries) -> Int { s.vals.length() }

pub fn finance_pricing_finite_diff_series_sum(s : FinancepricingfinitediffSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_pricing_finite_diff_series_mean(s : FinancepricingfinitediffSeries) -> Double {
  let n = finance_pricing_finite_diff_series_len(s)
  if n == 0 { 0.0 } else { finance_pricing_finite_diff_series_sum(s) / n.to_double() }
}

pub fn finance_pricing_finite_diff_series_min(s : FinancepricingfinitediffSeries) -> Double {
  let n = finance_pricing_finite_diff_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_series_max(s : FinancepricingfinitediffSeries) -> Double {
  let n = finance_pricing_finite_diff_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_series_range(s : FinancepricingfinitediffSeries) -> Double {
  finance_pricing_finite_diff_series_max(s) - finance_pricing_finite_diff_series_min(s)
}

pub fn finance_pricing_finite_diff_series_var(s : FinancepricingfinitediffSeries) -> Double {
  let n = finance_pricing_finite_diff_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_pricing_finite_diff_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_pricing_finite_diff_series_std(s : FinancepricingfinitediffSeries) -> Double { @_common.sqrt(finance_pricing_finite_diff_series_var(s)) }

pub fn finance_pricing_finite_diff_series_median(s : FinancepricingfinitediffSeries) -> Double {
  let n = finance_pricing_finite_diff_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_pricing_finite_diff_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_pricing_finite_diff_series_scale(s : FinancepricingfinitediffSeries, f : Double) -> FinancepricingfinitediffSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_pricing_finite_diff_series_add(a : FinancepricingfinitediffSeries, b : FinancepricingfinitediffSeries) -> FinancepricingfinitediffSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_pricing_finite_diff_series_sub(a : FinancepricingfinitediffSeries, b : FinancepricingfinitediffSeries) -> FinancepricingfinitediffSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_pricing_finite_diff_series_normalize(s : FinancepricingfinitediffSeries) -> FinancepricingfinitediffSeries {
  let mn = finance_pricing_finite_diff_series_min(s)
  let mx = finance_pricing_finite_diff_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_pricing_finite_diff_series_cumsum(s : FinancepricingfinitediffSeries) -> FinancepricingfinitediffSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_pricing_finite_diff_series_to_string(s : FinancepricingfinitediffSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingfinitediffMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_finite_diff_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingfinitediffMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_finite_diff_matrix_identity(n : Int) -> FinancepricingfinitediffMatrix {
  let m = finance_pricing_finite_diff_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_pricing_finite_diff_matrix_get(m : FinancepricingfinitediffMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_pricing_finite_diff_matrix_transpose(m : FinancepricingfinitediffMatrix) -> FinancepricingfinitediffMatrix {
  let result = finance_pricing_finite_diff_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_pricing_finite_diff_matrix_add(a : FinancepricingfinitediffMatrix, b : FinancepricingfinitediffMatrix) -> FinancepricingfinitediffMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_pricing_finite_diff_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_pricing_finite_diff_matrix_scale(m : FinancepricingfinitediffMatrix, s : Double) -> FinancepricingfinitediffMatrix {
  let result = finance_pricing_finite_diff_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_pricing_finite_diff_matrix_multiply(a : FinancepricingfinitediffMatrix, b : FinancepricingfinitediffMatrix) -> FinancepricingfinitediffMatrix {
  if a.cols != b.rows { return finance_pricing_finite_diff_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_pricing_finite_diff_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_pricing_finite_diff_matrix_trace(m : FinancepricingfinitediffMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_pricing_finite_diff_matrix_det(m : FinancepricingfinitediffMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_pricing_finite_diff_matrix_norm(m : FinancepricingfinitediffMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_pricing_finite_diff_matrix_to_string(m : FinancepricingfinitediffMatrix) -> String {
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

pub(all) struct FinancepricingfinitediffVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_finite_diff_make_vector(comps : Array[Double]) -> FinancepricingfinitediffVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_finite_diff_vector_zero(dim : Int) -> FinancepricingfinitediffVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_pricing_finite_diff_vector_add(a : FinancepricingfinitediffVector, b : FinancepricingfinitediffVector) -> FinancepricingfinitediffVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_pricing_finite_diff_vector_sub(a : FinancepricingfinitediffVector, b : FinancepricingfinitediffVector) -> FinancepricingfinitediffVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_pricing_finite_diff_vector_scale(v : FinancepricingfinitediffVector, s : Double) -> FinancepricingfinitediffVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_pricing_finite_diff_vector_dot(a : FinancepricingfinitediffVector, b : FinancepricingfinitediffVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_pricing_finite_diff_vector_norm(v : FinancepricingfinitediffVector) -> Double { @_common.sqrt(finance_pricing_finite_diff_vector_dot(v, v)) }

pub fn finance_pricing_finite_diff_vector_normalize(v : FinancepricingfinitediffVector) -> FinancepricingfinitediffVector {
  let n = finance_pricing_finite_diff_vector_norm(v)
  if n < 0.0000001 { v } else { finance_pricing_finite_diff_vector_scale(v, 1.0 / n) }
}

pub fn finance_pricing_finite_diff_vector_dist(a : FinancepricingfinitediffVector, b : FinancepricingfinitediffVector) -> Double {
  finance_pricing_finite_diff_vector_norm(finance_pricing_finite_diff_vector_sub(a, b))
}

pub fn finance_pricing_finite_diff_vector_to_string(v : FinancepricingfinitediffVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_pricing_finite_diff_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn finance_pricing_finite_diff_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = finance_pricing_finite_diff_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_pricing_finite_diff_std(data : Array[Double]) -> Double { @_common.sqrt(finance_pricing_finite_diff_var(data)) }

pub fn finance_pricing_finite_diff_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = finance_pricing_finite_diff_mean(a); let mb = finance_pricing_finite_diff_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn finance_pricing_finite_diff_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = finance_pricing_finite_diff_std(a); let sb = finance_pricing_finite_diff_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { finance_pricing_finite_diff_cov(a, b) / (sa * sb) }
}

pub fn finance_pricing_finite_diff_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = finance_pricing_finite_diff_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_pricing_finite_diff_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn finance_pricing_finite_diff_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_pricing_finite_diff_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(finance_pricing_finite_diff_mse(pred, labels))
}

pub fn finance_pricing_finite_diff_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn finance_pricing_finite_diff_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = finance_pricing_finite_diff_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn finance_pricing_finite_diff_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn finance_pricing_finite_diff_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn finance_pricing_finite_diff_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = finance_pricing_finite_diff_precision(pred, labels, pos); let r = finance_pricing_finite_diff_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn finance_pricing_finite_diff_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn finance_pricing_finite_diff_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = finance_pricing_finite_diff_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn finance_pricing_finite_diff_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn finance_pricing_finite_diff_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn finance_pricing_finite_diff_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = finance_pricing_finite_diff_gcd(a, b)
    (a / g) * b
  }
}

pub fn finance_pricing_finite_diff_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn finance_pricing_finite_diff_fibonacci(n : Int) -> Int {
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

pub fn finance_pricing_finite_diff_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = finance_pricing_finite_diff_min(data); let mx = finance_pricing_finite_diff_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn finance_pricing_finite_diff_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = finance_pricing_finite_diff_mean(data); let sd = finance_pricing_finite_diff_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn finance_pricing_finite_diff_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn finance_pricing_finite_diff_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn finance_pricing_finite_diff_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn finance_pricing_finite_diff_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct FinancepricingfinitediffFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_frame_make(size : Int) -> FinancepricingfinitediffFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_frame_len(s : FinancepricingfinitediffFrame) -> Int { s.size }

pub fn finance_pricing_finite_diff_frame_get(s : FinancepricingfinitediffFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_frame_set(s : FinancepricingfinitediffFrame, i : Int, v : Double) -> FinancepricingfinitediffFrame {
  let result = finance_pricing_finite_diff_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_frame_sum(s : FinancepricingfinitediffFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_finite_diff_frame_mean(s : FinancepricingfinitediffFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_finite_diff_frame_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_finite_diff_frame_scale(s : FinancepricingfinitediffFrame, f : Double) -> FinancepricingfinitediffFrame {
  let result = finance_pricing_finite_diff_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_finite_diff_frame_add(a : FinancepricingfinitediffFrame, b : FinancepricingfinitediffFrame) -> FinancepricingfinitediffFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_finite_diff_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_finite_diff_frame_copy(s : FinancepricingfinitediffFrame) -> FinancepricingfinitediffFrame {
  let result = finance_pricing_finite_diff_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_finite_diff_frame_fill(s : FinancepricingfinitediffFrame, v : Double) -> FinancepricingfinitediffFrame {
  let result = finance_pricing_finite_diff_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_frame_min(s : FinancepricingfinitediffFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_frame_max(s : FinancepricingfinitediffFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_frame_to_string(s : FinancepricingfinitediffFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_table_make(size : Int) -> FinancepricingfinitediffTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_table_len(s : FinancepricingfinitediffTable) -> Int { s.size }

pub fn finance_pricing_finite_diff_table_get(s : FinancepricingfinitediffTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_table_set(s : FinancepricingfinitediffTable, i : Int, v : Double) -> FinancepricingfinitediffTable {
  let result = finance_pricing_finite_diff_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_table_sum(s : FinancepricingfinitediffTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_finite_diff_table_mean(s : FinancepricingfinitediffTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_finite_diff_table_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_finite_diff_table_scale(s : FinancepricingfinitediffTable, f : Double) -> FinancepricingfinitediffTable {
  let result = finance_pricing_finite_diff_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_finite_diff_table_add(a : FinancepricingfinitediffTable, b : FinancepricingfinitediffTable) -> FinancepricingfinitediffTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_finite_diff_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_finite_diff_table_copy(s : FinancepricingfinitediffTable) -> FinancepricingfinitediffTable {
  let result = finance_pricing_finite_diff_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_finite_diff_table_fill(s : FinancepricingfinitediffTable, v : Double) -> FinancepricingfinitediffTable {
  let result = finance_pricing_finite_diff_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_table_min(s : FinancepricingfinitediffTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_table_max(s : FinancepricingfinitediffTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_table_to_string(s : FinancepricingfinitediffTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_graphn_make(size : Int) -> FinancepricingfinitediffGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_graphn_len(s : FinancepricingfinitediffGraphN) -> Int { s.size }

pub fn finance_pricing_finite_diff_graphn_get(s : FinancepricingfinitediffGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_graphn_set(s : FinancepricingfinitediffGraphN, i : Int, v : Double) -> FinancepricingfinitediffGraphN {
  let result = finance_pricing_finite_diff_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_graphn_sum(s : FinancepricingfinitediffGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_finite_diff_graphn_mean(s : FinancepricingfinitediffGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_finite_diff_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_finite_diff_graphn_scale(s : FinancepricingfinitediffGraphN, f : Double) -> FinancepricingfinitediffGraphN {
  let result = finance_pricing_finite_diff_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_finite_diff_graphn_add(a : FinancepricingfinitediffGraphN, b : FinancepricingfinitediffGraphN) -> FinancepricingfinitediffGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_finite_diff_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_finite_diff_graphn_copy(s : FinancepricingfinitediffGraphN) -> FinancepricingfinitediffGraphN {
  let result = finance_pricing_finite_diff_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_finite_diff_graphn_fill(s : FinancepricingfinitediffGraphN, v : Double) -> FinancepricingfinitediffGraphN {
  let result = finance_pricing_finite_diff_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_graphn_min(s : FinancepricingfinitediffGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_graphn_max(s : FinancepricingfinitediffGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_graphn_to_string(s : FinancepricingfinitediffGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_node_make(size : Int) -> FinancepricingfinitediffNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_node_len(s : FinancepricingfinitediffNode) -> Int { s.size }

pub fn finance_pricing_finite_diff_node_get(s : FinancepricingfinitediffNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_node_set(s : FinancepricingfinitediffNode, i : Int, v : Double) -> FinancepricingfinitediffNode {
  let result = finance_pricing_finite_diff_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_node_sum(s : FinancepricingfinitediffNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_finite_diff_node_mean(s : FinancepricingfinitediffNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_finite_diff_node_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_finite_diff_node_scale(s : FinancepricingfinitediffNode, f : Double) -> FinancepricingfinitediffNode {
  let result = finance_pricing_finite_diff_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_finite_diff_node_add(a : FinancepricingfinitediffNode, b : FinancepricingfinitediffNode) -> FinancepricingfinitediffNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_finite_diff_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_finite_diff_node_copy(s : FinancepricingfinitediffNode) -> FinancepricingfinitediffNode {
  let result = finance_pricing_finite_diff_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_finite_diff_node_fill(s : FinancepricingfinitediffNode, v : Double) -> FinancepricingfinitediffNode {
  let result = finance_pricing_finite_diff_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_node_min(s : FinancepricingfinitediffNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_node_max(s : FinancepricingfinitediffNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_node_to_string(s : FinancepricingfinitediffNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_edge_make(size : Int) -> FinancepricingfinitediffEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_edge_len(s : FinancepricingfinitediffEdge) -> Int { s.size }

pub fn finance_pricing_finite_diff_edge_get(s : FinancepricingfinitediffEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_edge_set(s : FinancepricingfinitediffEdge, i : Int, v : Double) -> FinancepricingfinitediffEdge {
  let result = finance_pricing_finite_diff_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_edge_sum(s : FinancepricingfinitediffEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_finite_diff_edge_mean(s : FinancepricingfinitediffEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_finite_diff_edge_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_finite_diff_edge_scale(s : FinancepricingfinitediffEdge, f : Double) -> FinancepricingfinitediffEdge {
  let result = finance_pricing_finite_diff_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_finite_diff_edge_add(a : FinancepricingfinitediffEdge, b : FinancepricingfinitediffEdge) -> FinancepricingfinitediffEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_finite_diff_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_finite_diff_edge_copy(s : FinancepricingfinitediffEdge) -> FinancepricingfinitediffEdge {
  let result = finance_pricing_finite_diff_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_finite_diff_edge_fill(s : FinancepricingfinitediffEdge, v : Double) -> FinancepricingfinitediffEdge {
  let result = finance_pricing_finite_diff_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_edge_min(s : FinancepricingfinitediffEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_edge_max(s : FinancepricingfinitediffEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_edge_to_string(s : FinancepricingfinitediffEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_path_make(size : Int) -> FinancepricingfinitediffPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_path_len(s : FinancepricingfinitediffPath) -> Int { s.size }

pub fn finance_pricing_finite_diff_path_get(s : FinancepricingfinitediffPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_path_set(s : FinancepricingfinitediffPath, i : Int, v : Double) -> FinancepricingfinitediffPath {
  let result = finance_pricing_finite_diff_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_path_sum(s : FinancepricingfinitediffPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_finite_diff_path_mean(s : FinancepricingfinitediffPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_finite_diff_path_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_finite_diff_path_scale(s : FinancepricingfinitediffPath, f : Double) -> FinancepricingfinitediffPath {
  let result = finance_pricing_finite_diff_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_finite_diff_path_add(a : FinancepricingfinitediffPath, b : FinancepricingfinitediffPath) -> FinancepricingfinitediffPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_finite_diff_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_finite_diff_path_copy(s : FinancepricingfinitediffPath) -> FinancepricingfinitediffPath {
  let result = finance_pricing_finite_diff_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_finite_diff_path_fill(s : FinancepricingfinitediffPath, v : Double) -> FinancepricingfinitediffPath {
  let result = finance_pricing_finite_diff_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_path_min(s : FinancepricingfinitediffPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_path_max(s : FinancepricingfinitediffPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_path_to_string(s : FinancepricingfinitediffPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_cluster_make(size : Int) -> FinancepricingfinitediffCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_cluster_len(s : FinancepricingfinitediffCluster) -> Int { s.size }

pub fn finance_pricing_finite_diff_cluster_get(s : FinancepricingfinitediffCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_cluster_set(s : FinancepricingfinitediffCluster, i : Int, v : Double) -> FinancepricingfinitediffCluster {
  let result = finance_pricing_finite_diff_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_cluster_sum(s : FinancepricingfinitediffCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_finite_diff_cluster_mean(s : FinancepricingfinitediffCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_finite_diff_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_finite_diff_cluster_scale(s : FinancepricingfinitediffCluster, f : Double) -> FinancepricingfinitediffCluster {
  let result = finance_pricing_finite_diff_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_finite_diff_cluster_add(a : FinancepricingfinitediffCluster, b : FinancepricingfinitediffCluster) -> FinancepricingfinitediffCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_finite_diff_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_finite_diff_cluster_copy(s : FinancepricingfinitediffCluster) -> FinancepricingfinitediffCluster {
  let result = finance_pricing_finite_diff_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_finite_diff_cluster_fill(s : FinancepricingfinitediffCluster, v : Double) -> FinancepricingfinitediffCluster {
  let result = finance_pricing_finite_diff_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_cluster_min(s : FinancepricingfinitediffCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_cluster_max(s : FinancepricingfinitediffCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_cluster_to_string(s : FinancepricingfinitediffCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_model_make(size : Int) -> FinancepricingfinitediffModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_model_len(s : FinancepricingfinitediffModel) -> Int { s.size }

pub fn finance_pricing_finite_diff_model_get(s : FinancepricingfinitediffModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_model_set(s : FinancepricingfinitediffModel, i : Int, v : Double) -> FinancepricingfinitediffModel {
  let result = finance_pricing_finite_diff_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_model_sum(s : FinancepricingfinitediffModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_finite_diff_model_mean(s : FinancepricingfinitediffModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_finite_diff_model_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_finite_diff_model_scale(s : FinancepricingfinitediffModel, f : Double) -> FinancepricingfinitediffModel {
  let result = finance_pricing_finite_diff_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_finite_diff_model_add(a : FinancepricingfinitediffModel, b : FinancepricingfinitediffModel) -> FinancepricingfinitediffModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_finite_diff_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_finite_diff_model_copy(s : FinancepricingfinitediffModel) -> FinancepricingfinitediffModel {
  let result = finance_pricing_finite_diff_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_finite_diff_model_fill(s : FinancepricingfinitediffModel, v : Double) -> FinancepricingfinitediffModel {
  let result = finance_pricing_finite_diff_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_model_min(s : FinancepricingfinitediffModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_model_max(s : FinancepricingfinitediffModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_model_to_string(s : FinancepricingfinitediffModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_layer_make(size : Int) -> FinancepricingfinitediffLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_layer_len(s : FinancepricingfinitediffLayer) -> Int { s.size }

pub fn finance_pricing_finite_diff_layer_get(s : FinancepricingfinitediffLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_layer_set(s : FinancepricingfinitediffLayer, i : Int, v : Double) -> FinancepricingfinitediffLayer {
  let result = finance_pricing_finite_diff_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_layer_sum(s : FinancepricingfinitediffLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_finite_diff_layer_mean(s : FinancepricingfinitediffLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_finite_diff_layer_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_finite_diff_layer_scale(s : FinancepricingfinitediffLayer, f : Double) -> FinancepricingfinitediffLayer {
  let result = finance_pricing_finite_diff_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_finite_diff_layer_add(a : FinancepricingfinitediffLayer, b : FinancepricingfinitediffLayer) -> FinancepricingfinitediffLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_finite_diff_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_finite_diff_layer_copy(s : FinancepricingfinitediffLayer) -> FinancepricingfinitediffLayer {
  let result = finance_pricing_finite_diff_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_finite_diff_layer_fill(s : FinancepricingfinitediffLayer, v : Double) -> FinancepricingfinitediffLayer {
  let result = finance_pricing_finite_diff_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_layer_min(s : FinancepricingfinitediffLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_layer_max(s : FinancepricingfinitediffLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_layer_to_string(s : FinancepricingfinitediffLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_buffer_make(size : Int) -> FinancepricingfinitediffBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_buffer_len(s : FinancepricingfinitediffBuffer) -> Int { s.size }

pub fn finance_pricing_finite_diff_buffer_get(s : FinancepricingfinitediffBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_buffer_set(s : FinancepricingfinitediffBuffer, i : Int, v : Double) -> FinancepricingfinitediffBuffer {
  let result = finance_pricing_finite_diff_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_buffer_sum(s : FinancepricingfinitediffBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_finite_diff_buffer_mean(s : FinancepricingfinitediffBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_finite_diff_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_finite_diff_buffer_scale(s : FinancepricingfinitediffBuffer, f : Double) -> FinancepricingfinitediffBuffer {
  let result = finance_pricing_finite_diff_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_finite_diff_buffer_add(a : FinancepricingfinitediffBuffer, b : FinancepricingfinitediffBuffer) -> FinancepricingfinitediffBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_finite_diff_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_finite_diff_buffer_copy(s : FinancepricingfinitediffBuffer) -> FinancepricingfinitediffBuffer {
  let result = finance_pricing_finite_diff_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_finite_diff_buffer_fill(s : FinancepricingfinitediffBuffer, v : Double) -> FinancepricingfinitediffBuffer {
  let result = finance_pricing_finite_diff_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_buffer_min(s : FinancepricingfinitediffBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_buffer_max(s : FinancepricingfinitediffBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_buffer_to_string(s : FinancepricingfinitediffBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_cursor_make(size : Int) -> FinancepricingfinitediffCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_cursor_len(s : FinancepricingfinitediffCursor) -> Int { s.size }

pub fn finance_pricing_finite_diff_cursor_get(s : FinancepricingfinitediffCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_cursor_set(s : FinancepricingfinitediffCursor, i : Int, v : Double) -> FinancepricingfinitediffCursor {
  let result = finance_pricing_finite_diff_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_cursor_sum(s : FinancepricingfinitediffCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_finite_diff_cursor_mean(s : FinancepricingfinitediffCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_finite_diff_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_finite_diff_cursor_scale(s : FinancepricingfinitediffCursor, f : Double) -> FinancepricingfinitediffCursor {
  let result = finance_pricing_finite_diff_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_finite_diff_cursor_add(a : FinancepricingfinitediffCursor, b : FinancepricingfinitediffCursor) -> FinancepricingfinitediffCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_finite_diff_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_finite_diff_cursor_copy(s : FinancepricingfinitediffCursor) -> FinancepricingfinitediffCursor {
  let result = finance_pricing_finite_diff_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_finite_diff_cursor_fill(s : FinancepricingfinitediffCursor, v : Double) -> FinancepricingfinitediffCursor {
  let result = finance_pricing_finite_diff_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_cursor_min(s : FinancepricingfinitediffCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_cursor_max(s : FinancepricingfinitediffCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_cursor_to_string(s : FinancepricingfinitediffCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_view_make(size : Int) -> FinancepricingfinitediffView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_view_len(s : FinancepricingfinitediffView) -> Int { s.size }

pub fn finance_pricing_finite_diff_view_get(s : FinancepricingfinitediffView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_view_set(s : FinancepricingfinitediffView, i : Int, v : Double) -> FinancepricingfinitediffView {
  let result = finance_pricing_finite_diff_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_view_sum(s : FinancepricingfinitediffView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_finite_diff_view_mean(s : FinancepricingfinitediffView) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_finite_diff_view_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_finite_diff_view_scale(s : FinancepricingfinitediffView, f : Double) -> FinancepricingfinitediffView {
  let result = finance_pricing_finite_diff_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_finite_diff_view_add(a : FinancepricingfinitediffView, b : FinancepricingfinitediffView) -> FinancepricingfinitediffView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_finite_diff_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_finite_diff_view_copy(s : FinancepricingfinitediffView) -> FinancepricingfinitediffView {
  let result = finance_pricing_finite_diff_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_finite_diff_view_fill(s : FinancepricingfinitediffView, v : Double) -> FinancepricingfinitediffView {
  let result = finance_pricing_finite_diff_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_view_min(s : FinancepricingfinitediffView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_view_max(s : FinancepricingfinitediffView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_view_to_string(s : FinancepricingfinitediffView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_range_make(size : Int) -> FinancepricingfinitediffRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_range_len(s : FinancepricingfinitediffRange) -> Int { s.size }

pub fn finance_pricing_finite_diff_range_get(s : FinancepricingfinitediffRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_range_set(s : FinancepricingfinitediffRange, i : Int, v : Double) -> FinancepricingfinitediffRange {
  let result = finance_pricing_finite_diff_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_range_sum(s : FinancepricingfinitediffRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_finite_diff_range_mean(s : FinancepricingfinitediffRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_finite_diff_range_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_finite_diff_range_scale(s : FinancepricingfinitediffRange, f : Double) -> FinancepricingfinitediffRange {
  let result = finance_pricing_finite_diff_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_finite_diff_range_add(a : FinancepricingfinitediffRange, b : FinancepricingfinitediffRange) -> FinancepricingfinitediffRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_finite_diff_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_finite_diff_range_copy(s : FinancepricingfinitediffRange) -> FinancepricingfinitediffRange {
  let result = finance_pricing_finite_diff_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_finite_diff_range_fill(s : FinancepricingfinitediffRange, v : Double) -> FinancepricingfinitediffRange {
  let result = finance_pricing_finite_diff_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_range_min(s : FinancepricingfinitediffRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_range_max(s : FinancepricingfinitediffRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_range_to_string(s : FinancepricingfinitediffRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_slice_make(size : Int) -> FinancepricingfinitediffSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_slice_len(s : FinancepricingfinitediffSlice) -> Int { s.size }

pub fn finance_pricing_finite_diff_slice_get(s : FinancepricingfinitediffSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_slice_set(s : FinancepricingfinitediffSlice, i : Int, v : Double) -> FinancepricingfinitediffSlice {
  let result = finance_pricing_finite_diff_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_slice_sum(s : FinancepricingfinitediffSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_finite_diff_slice_mean(s : FinancepricingfinitediffSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_finite_diff_slice_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_finite_diff_slice_scale(s : FinancepricingfinitediffSlice, f : Double) -> FinancepricingfinitediffSlice {
  let result = finance_pricing_finite_diff_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_finite_diff_slice_add(a : FinancepricingfinitediffSlice, b : FinancepricingfinitediffSlice) -> FinancepricingfinitediffSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_finite_diff_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_finite_diff_slice_copy(s : FinancepricingfinitediffSlice) -> FinancepricingfinitediffSlice {
  let result = finance_pricing_finite_diff_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_finite_diff_slice_fill(s : FinancepricingfinitediffSlice, v : Double) -> FinancepricingfinitediffSlice {
  let result = finance_pricing_finite_diff_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_finite_diff_slice_min(s : FinancepricingfinitediffSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_slice_max(s : FinancepricingfinitediffSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_finite_diff_slice_to_string(s : FinancepricingfinitediffSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

