///===
/// extcore/finance_time_extreme

pub(all) struct FinancetimeextremePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_extreme_make_point(x : Double, y : Double) -> FinancetimeextremePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_extreme_make_point3(x : Double, y : Double, z : Double) -> FinancetimeextremePoint {
  { x, y, z, label: 0 }
}

pub fn finance_time_extreme_point_x(pt : FinancetimeextremePoint) -> Double { pt.x }

pub fn finance_time_extreme_point_y(pt : FinancetimeextremePoint) -> Double { pt.y }

pub fn finance_time_extreme_point_z(pt : FinancetimeextremePoint) -> Double { pt.z }

pub fn finance_time_extreme_point_label(pt : FinancetimeextremePoint) -> Int { pt.label }

pub fn finance_time_extreme_point_dist(a : FinancetimeextremePoint, b : FinancetimeextremePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  finance_time_extreme_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_time_extreme_point_add(a : FinancetimeextremePoint, b : FinancetimeextremePoint) -> FinancetimeextremePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_time_extreme_point_sub(a : FinancetimeextremePoint, b : FinancetimeextremePoint) -> FinancetimeextremePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_time_extreme_point_scale(pt : FinancetimeextremePoint, s : Double) -> FinancetimeextremePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_time_extreme_point_dot(a : FinancetimeextremePoint, b : FinancetimeextremePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_time_extreme_point_cross(a : FinancetimeextremePoint, b : FinancetimeextremePoint) -> FinancetimeextremePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_time_extreme_point_norm(pt : FinancetimeextremePoint) -> Double {
  finance_time_extreme_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_time_extreme_point_normalize(pt : FinancetimeextremePoint) -> FinancetimeextremePoint {
  let n = finance_time_extreme_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_time_extreme_point_scale(pt, 1.0 / n) }
}

pub fn finance_time_extreme_point_negate(pt : FinancetimeextremePoint) -> FinancetimeextremePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_time_extreme_point_mid(a : FinancetimeextremePoint, b : FinancetimeextremePoint) -> FinancetimeextremePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_time_extreme_point_lerp(a : FinancetimeextremePoint, b : FinancetimeextremePoint, t : Double) -> FinancetimeextremePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_time_extreme_point_to_string(pt : FinancetimeextremePoint) -> String {
  "(" + finance_time_extreme_dbl(pt.x) + ", " + finance_time_extreme_dbl(pt.y) + ", " + finance_time_extreme_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancetimeextremeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_extreme_make_series(vals : Array[Double], name : String) -> FinancetimeextremeSeries {
  { vals, name, meta: 0 }
}

pub fn finance_time_extreme_series_len(s : FinancetimeextremeSeries) -> Int { s.vals.length() }

pub fn finance_time_extreme_series_sum(s : FinancetimeextremeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_time_extreme_series_mean(s : FinancetimeextremeSeries) -> Double {
  let n = finance_time_extreme_series_len(s)
  if n == 0 { 0.0 } else { finance_time_extreme_series_sum(s) / n.to_double() }
}

pub fn finance_time_extreme_series_min(s : FinancetimeextremeSeries) -> Double {
  let n = finance_time_extreme_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_time_extreme_series_max(s : FinancetimeextremeSeries) -> Double {
  let n = finance_time_extreme_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_time_extreme_series_range(s : FinancetimeextremeSeries) -> Double {
  finance_time_extreme_series_max(s) - finance_time_extreme_series_min(s)
}

pub fn finance_time_extreme_series_var(s : FinancetimeextremeSeries) -> Double {
  let n = finance_time_extreme_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_time_extreme_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_time_extreme_series_std(s : FinancetimeextremeSeries) -> Double { finance_time_extreme_sqrt(finance_time_extreme_series_var(s)) }

pub fn finance_time_extreme_series_median(s : FinancetimeextremeSeries) -> Double {
  let n = finance_time_extreme_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_time_extreme_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_time_extreme_series_scale(s : FinancetimeextremeSeries, f : Double) -> FinancetimeextremeSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = finance_time_extreme_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_time_extreme_series_add(a : FinancetimeextremeSeries, b : FinancetimeextremeSeries) -> FinancetimeextremeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_time_extreme_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_time_extreme_series_sub(a : FinancetimeextremeSeries, b : FinancetimeextremeSeries) -> FinancetimeextremeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_time_extreme_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_time_extreme_series_normalize(s : FinancetimeextremeSeries) -> FinancetimeextremeSeries {
  let mn = finance_time_extreme_series_min(s)
  let mx = finance_time_extreme_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = finance_time_extreme_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_time_extreme_series_cumsum(s : FinancetimeextremeSeries) -> FinancetimeextremeSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = finance_time_extreme_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_time_extreme_series_to_string(s : FinancetimeextremeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_time_extreme_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimeextremeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_extreme_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimeextremeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_extreme_matrix_identity(n : Int) -> FinancetimeextremeMatrix {
  let m = finance_time_extreme_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_time_extreme_matrix_get(m : FinancetimeextremeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_time_extreme_matrix_transpose(m : FinancetimeextremeMatrix) -> FinancetimeextremeMatrix {
  let result = finance_time_extreme_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_time_extreme_matrix_add(a : FinancetimeextremeMatrix, b : FinancetimeextremeMatrix) -> FinancetimeextremeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_time_extreme_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_time_extreme_matrix_scale(m : FinancetimeextremeMatrix, s : Double) -> FinancetimeextremeMatrix {
  let result = finance_time_extreme_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_time_extreme_matrix_multiply(a : FinancetimeextremeMatrix, b : FinancetimeextremeMatrix) -> FinancetimeextremeMatrix {
  if a.cols != b.rows { return finance_time_extreme_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_time_extreme_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_time_extreme_matrix_trace(m : FinancetimeextremeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_time_extreme_matrix_det(m : FinancetimeextremeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_time_extreme_matrix_norm(m : FinancetimeextremeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  finance_time_extreme_sqrt(sum)
}

pub fn finance_time_extreme_matrix_to_string(m : FinancetimeextremeMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + finance_time_extreme_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct FinancetimeextremeVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_extreme_make_vector(comps : Array[Double]) -> FinancetimeextremeVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_extreme_vector_zero(dim : Int) -> FinancetimeextremeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_time_extreme_vector_add(a : FinancetimeextremeVector, b : FinancetimeextremeVector) -> FinancetimeextremeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_time_extreme_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_extreme_vector_sub(a : FinancetimeextremeVector, b : FinancetimeextremeVector) -> FinancetimeextremeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_time_extreme_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_extreme_vector_scale(v : FinancetimeextremeVector, s : Double) -> FinancetimeextremeVector {
  let mut result = []
  for i in 0..<v.dim { result = finance_time_extreme_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_time_extreme_vector_dot(a : FinancetimeextremeVector, b : FinancetimeextremeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_time_extreme_vector_norm(v : FinancetimeextremeVector) -> Double { finance_time_extreme_sqrt(finance_time_extreme_vector_dot(v, v)) }

pub fn finance_time_extreme_vector_normalize(v : FinancetimeextremeVector) -> FinancetimeextremeVector {
  let n = finance_time_extreme_vector_norm(v)
  if n < 0.0000001 { v } else { finance_time_extreme_vector_scale(v, 1.0 / n) }
}

pub fn finance_time_extreme_vector_dist(a : FinancetimeextremeVector, b : FinancetimeextremeVector) -> Double {
  finance_time_extreme_vector_norm(finance_time_extreme_vector_sub(a, b))
}

pub fn finance_time_extreme_vector_to_string(v : FinancetimeextremeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_time_extreme_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_time_extreme_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn finance_time_extreme_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = finance_time_extreme_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_time_extreme_std(data : Array[Double]) -> Double { finance_time_extreme_sqrt(finance_time_extreme_var(data)) }

pub fn finance_time_extreme_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = finance_time_extreme_mean(a); let mb = finance_time_extreme_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn finance_time_extreme_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = finance_time_extreme_std(a); let sb = finance_time_extreme_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { finance_time_extreme_cov(a, b) / (sa * sb) }
}

pub fn finance_time_extreme_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = finance_time_extreme_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_time_extreme_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn finance_time_extreme_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_time_extreme_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  finance_time_extreme_sqrt(finance_time_extreme_mse(pred, labels))
}

pub fn finance_time_extreme_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + finance_time_extreme_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn finance_time_extreme_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = finance_time_extreme_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn finance_time_extreme_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn finance_time_extreme_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn finance_time_extreme_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = finance_time_extreme_precision(pred, labels, pos); let r = finance_time_extreme_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn finance_time_extreme_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn finance_time_extreme_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = finance_time_extreme_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn finance_time_extreme_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn finance_time_extreme_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn finance_time_extreme_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = finance_time_extreme_gcd(a, b)
    (a / g) * b
  }
}

pub fn finance_time_extreme_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn finance_time_extreme_fibonacci(n : Int) -> Int {
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

pub fn finance_time_extreme_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = finance_time_extreme_min(data); let mx = finance_time_extreme_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn finance_time_extreme_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = finance_time_extreme_mean(data); let sd = finance_time_extreme_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn finance_time_extreme_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn finance_time_extreme_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn finance_time_extreme_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn finance_time_extreme_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn finance_time_extreme_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn finance_time_extreme_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn finance_time_extreme_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn finance_time_extreme_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn finance_time_extreme_dbl(x : Double) -> String {
  let i = if x >= 0.0 { finance_time_extreme_int(x) } else { -finance_time_extreme_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { finance_time_extreme_int(f * 1000000.0) } else { finance_time_extreme_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn finance_time_extreme_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn finance_time_extreme_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct FinancetimeextremeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_frame_make(size : Int) -> FinancetimeextremeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_frame_len(s : FinancetimeextremeFrame) -> Int { s.size }

pub fn finance_time_extreme_frame_get(s : FinancetimeextremeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_frame_set(s : FinancetimeextremeFrame, i : Int, v : Double) -> FinancetimeextremeFrame {
  let result = finance_time_extreme_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_frame_sum(s : FinancetimeextremeFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_extreme_frame_mean(s : FinancetimeextremeFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_extreme_frame_sum(s) / s.size.to_double() }
}

pub fn finance_time_extreme_frame_scale(s : FinancetimeextremeFrame, f : Double) -> FinancetimeextremeFrame {
  let result = finance_time_extreme_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_extreme_frame_add(a : FinancetimeextremeFrame, b : FinancetimeextremeFrame) -> FinancetimeextremeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_extreme_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_extreme_frame_copy(s : FinancetimeextremeFrame) -> FinancetimeextremeFrame {
  let result = finance_time_extreme_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_extreme_frame_fill(s : FinancetimeextremeFrame, v : Double) -> FinancetimeextremeFrame {
  let result = finance_time_extreme_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_frame_min(s : FinancetimeextremeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_frame_max(s : FinancetimeextremeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_frame_to_string(s : FinancetimeextremeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_table_make(size : Int) -> FinancetimeextremeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_table_len(s : FinancetimeextremeTable) -> Int { s.size }

pub fn finance_time_extreme_table_get(s : FinancetimeextremeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_table_set(s : FinancetimeextremeTable, i : Int, v : Double) -> FinancetimeextremeTable {
  let result = finance_time_extreme_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_table_sum(s : FinancetimeextremeTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_extreme_table_mean(s : FinancetimeextremeTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_extreme_table_sum(s) / s.size.to_double() }
}

pub fn finance_time_extreme_table_scale(s : FinancetimeextremeTable, f : Double) -> FinancetimeextremeTable {
  let result = finance_time_extreme_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_extreme_table_add(a : FinancetimeextremeTable, b : FinancetimeextremeTable) -> FinancetimeextremeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_extreme_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_extreme_table_copy(s : FinancetimeextremeTable) -> FinancetimeextremeTable {
  let result = finance_time_extreme_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_extreme_table_fill(s : FinancetimeextremeTable, v : Double) -> FinancetimeextremeTable {
  let result = finance_time_extreme_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_table_min(s : FinancetimeextremeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_table_max(s : FinancetimeextremeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_table_to_string(s : FinancetimeextremeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_graphn_make(size : Int) -> FinancetimeextremeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_graphn_len(s : FinancetimeextremeGraphN) -> Int { s.size }

pub fn finance_time_extreme_graphn_get(s : FinancetimeextremeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_graphn_set(s : FinancetimeextremeGraphN, i : Int, v : Double) -> FinancetimeextremeGraphN {
  let result = finance_time_extreme_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_graphn_sum(s : FinancetimeextremeGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_extreme_graphn_mean(s : FinancetimeextremeGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_extreme_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_time_extreme_graphn_scale(s : FinancetimeextremeGraphN, f : Double) -> FinancetimeextremeGraphN {
  let result = finance_time_extreme_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_extreme_graphn_add(a : FinancetimeextremeGraphN, b : FinancetimeextremeGraphN) -> FinancetimeextremeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_extreme_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_extreme_graphn_copy(s : FinancetimeextremeGraphN) -> FinancetimeextremeGraphN {
  let result = finance_time_extreme_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_extreme_graphn_fill(s : FinancetimeextremeGraphN, v : Double) -> FinancetimeextremeGraphN {
  let result = finance_time_extreme_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_graphn_min(s : FinancetimeextremeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_graphn_max(s : FinancetimeextremeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_graphn_to_string(s : FinancetimeextremeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_node_make(size : Int) -> FinancetimeextremeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_node_len(s : FinancetimeextremeNode) -> Int { s.size }

pub fn finance_time_extreme_node_get(s : FinancetimeextremeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_node_set(s : FinancetimeextremeNode, i : Int, v : Double) -> FinancetimeextremeNode {
  let result = finance_time_extreme_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_node_sum(s : FinancetimeextremeNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_extreme_node_mean(s : FinancetimeextremeNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_extreme_node_sum(s) / s.size.to_double() }
}

pub fn finance_time_extreme_node_scale(s : FinancetimeextremeNode, f : Double) -> FinancetimeextremeNode {
  let result = finance_time_extreme_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_extreme_node_add(a : FinancetimeextremeNode, b : FinancetimeextremeNode) -> FinancetimeextremeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_extreme_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_extreme_node_copy(s : FinancetimeextremeNode) -> FinancetimeextremeNode {
  let result = finance_time_extreme_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_extreme_node_fill(s : FinancetimeextremeNode, v : Double) -> FinancetimeextremeNode {
  let result = finance_time_extreme_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_node_min(s : FinancetimeextremeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_node_max(s : FinancetimeextremeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_node_to_string(s : FinancetimeextremeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_edge_make(size : Int) -> FinancetimeextremeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_edge_len(s : FinancetimeextremeEdge) -> Int { s.size }

pub fn finance_time_extreme_edge_get(s : FinancetimeextremeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_edge_set(s : FinancetimeextremeEdge, i : Int, v : Double) -> FinancetimeextremeEdge {
  let result = finance_time_extreme_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_edge_sum(s : FinancetimeextremeEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_extreme_edge_mean(s : FinancetimeextremeEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_extreme_edge_sum(s) / s.size.to_double() }
}

pub fn finance_time_extreme_edge_scale(s : FinancetimeextremeEdge, f : Double) -> FinancetimeextremeEdge {
  let result = finance_time_extreme_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_extreme_edge_add(a : FinancetimeextremeEdge, b : FinancetimeextremeEdge) -> FinancetimeextremeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_extreme_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_extreme_edge_copy(s : FinancetimeextremeEdge) -> FinancetimeextremeEdge {
  let result = finance_time_extreme_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_extreme_edge_fill(s : FinancetimeextremeEdge, v : Double) -> FinancetimeextremeEdge {
  let result = finance_time_extreme_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_edge_min(s : FinancetimeextremeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_edge_max(s : FinancetimeextremeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_edge_to_string(s : FinancetimeextremeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_path_make(size : Int) -> FinancetimeextremePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_path_len(s : FinancetimeextremePath) -> Int { s.size }

pub fn finance_time_extreme_path_get(s : FinancetimeextremePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_path_set(s : FinancetimeextremePath, i : Int, v : Double) -> FinancetimeextremePath {
  let result = finance_time_extreme_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_path_sum(s : FinancetimeextremePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_extreme_path_mean(s : FinancetimeextremePath) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_extreme_path_sum(s) / s.size.to_double() }
}

pub fn finance_time_extreme_path_scale(s : FinancetimeextremePath, f : Double) -> FinancetimeextremePath {
  let result = finance_time_extreme_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_extreme_path_add(a : FinancetimeextremePath, b : FinancetimeextremePath) -> FinancetimeextremePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_extreme_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_extreme_path_copy(s : FinancetimeextremePath) -> FinancetimeextremePath {
  let result = finance_time_extreme_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_extreme_path_fill(s : FinancetimeextremePath, v : Double) -> FinancetimeextremePath {
  let result = finance_time_extreme_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_path_min(s : FinancetimeextremePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_path_max(s : FinancetimeextremePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_path_to_string(s : FinancetimeextremePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_cluster_make(size : Int) -> FinancetimeextremeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_cluster_len(s : FinancetimeextremeCluster) -> Int { s.size }

pub fn finance_time_extreme_cluster_get(s : FinancetimeextremeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_cluster_set(s : FinancetimeextremeCluster, i : Int, v : Double) -> FinancetimeextremeCluster {
  let result = finance_time_extreme_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_cluster_sum(s : FinancetimeextremeCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_extreme_cluster_mean(s : FinancetimeextremeCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_extreme_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_time_extreme_cluster_scale(s : FinancetimeextremeCluster, f : Double) -> FinancetimeextremeCluster {
  let result = finance_time_extreme_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_extreme_cluster_add(a : FinancetimeextremeCluster, b : FinancetimeextremeCluster) -> FinancetimeextremeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_extreme_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_extreme_cluster_copy(s : FinancetimeextremeCluster) -> FinancetimeextremeCluster {
  let result = finance_time_extreme_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_extreme_cluster_fill(s : FinancetimeextremeCluster, v : Double) -> FinancetimeextremeCluster {
  let result = finance_time_extreme_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_cluster_min(s : FinancetimeextremeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_cluster_max(s : FinancetimeextremeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_cluster_to_string(s : FinancetimeextremeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_model_make(size : Int) -> FinancetimeextremeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_model_len(s : FinancetimeextremeModel) -> Int { s.size }

pub fn finance_time_extreme_model_get(s : FinancetimeextremeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_model_set(s : FinancetimeextremeModel, i : Int, v : Double) -> FinancetimeextremeModel {
  let result = finance_time_extreme_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_model_sum(s : FinancetimeextremeModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_extreme_model_mean(s : FinancetimeextremeModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_extreme_model_sum(s) / s.size.to_double() }
}

pub fn finance_time_extreme_model_scale(s : FinancetimeextremeModel, f : Double) -> FinancetimeextremeModel {
  let result = finance_time_extreme_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_extreme_model_add(a : FinancetimeextremeModel, b : FinancetimeextremeModel) -> FinancetimeextremeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_extreme_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_extreme_model_copy(s : FinancetimeextremeModel) -> FinancetimeextremeModel {
  let result = finance_time_extreme_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_extreme_model_fill(s : FinancetimeextremeModel, v : Double) -> FinancetimeextremeModel {
  let result = finance_time_extreme_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_model_min(s : FinancetimeextremeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_model_max(s : FinancetimeextremeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_model_to_string(s : FinancetimeextremeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_layer_make(size : Int) -> FinancetimeextremeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_layer_len(s : FinancetimeextremeLayer) -> Int { s.size }

pub fn finance_time_extreme_layer_get(s : FinancetimeextremeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_layer_set(s : FinancetimeextremeLayer, i : Int, v : Double) -> FinancetimeextremeLayer {
  let result = finance_time_extreme_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_layer_sum(s : FinancetimeextremeLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_extreme_layer_mean(s : FinancetimeextremeLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_extreme_layer_sum(s) / s.size.to_double() }
}

pub fn finance_time_extreme_layer_scale(s : FinancetimeextremeLayer, f : Double) -> FinancetimeextremeLayer {
  let result = finance_time_extreme_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_extreme_layer_add(a : FinancetimeextremeLayer, b : FinancetimeextremeLayer) -> FinancetimeextremeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_extreme_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_extreme_layer_copy(s : FinancetimeextremeLayer) -> FinancetimeextremeLayer {
  let result = finance_time_extreme_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_extreme_layer_fill(s : FinancetimeextremeLayer, v : Double) -> FinancetimeextremeLayer {
  let result = finance_time_extreme_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_layer_min(s : FinancetimeextremeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_layer_max(s : FinancetimeextremeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_layer_to_string(s : FinancetimeextremeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_buffer_make(size : Int) -> FinancetimeextremeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_buffer_len(s : FinancetimeextremeBuffer) -> Int { s.size }

pub fn finance_time_extreme_buffer_get(s : FinancetimeextremeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_buffer_set(s : FinancetimeextremeBuffer, i : Int, v : Double) -> FinancetimeextremeBuffer {
  let result = finance_time_extreme_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_buffer_sum(s : FinancetimeextremeBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_extreme_buffer_mean(s : FinancetimeextremeBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_extreme_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_time_extreme_buffer_scale(s : FinancetimeextremeBuffer, f : Double) -> FinancetimeextremeBuffer {
  let result = finance_time_extreme_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_extreme_buffer_add(a : FinancetimeextremeBuffer, b : FinancetimeextremeBuffer) -> FinancetimeextremeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_extreme_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_extreme_buffer_copy(s : FinancetimeextremeBuffer) -> FinancetimeextremeBuffer {
  let result = finance_time_extreme_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_extreme_buffer_fill(s : FinancetimeextremeBuffer, v : Double) -> FinancetimeextremeBuffer {
  let result = finance_time_extreme_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_buffer_min(s : FinancetimeextremeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_buffer_max(s : FinancetimeextremeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_buffer_to_string(s : FinancetimeextremeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_cursor_make(size : Int) -> FinancetimeextremeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_cursor_len(s : FinancetimeextremeCursor) -> Int { s.size }

pub fn finance_time_extreme_cursor_get(s : FinancetimeextremeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_cursor_set(s : FinancetimeextremeCursor, i : Int, v : Double) -> FinancetimeextremeCursor {
  let result = finance_time_extreme_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_cursor_sum(s : FinancetimeextremeCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_extreme_cursor_mean(s : FinancetimeextremeCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_extreme_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_time_extreme_cursor_scale(s : FinancetimeextremeCursor, f : Double) -> FinancetimeextremeCursor {
  let result = finance_time_extreme_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_extreme_cursor_add(a : FinancetimeextremeCursor, b : FinancetimeextremeCursor) -> FinancetimeextremeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_extreme_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_extreme_cursor_copy(s : FinancetimeextremeCursor) -> FinancetimeextremeCursor {
  let result = finance_time_extreme_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_extreme_cursor_fill(s : FinancetimeextremeCursor, v : Double) -> FinancetimeextremeCursor {
  let result = finance_time_extreme_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_cursor_min(s : FinancetimeextremeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_cursor_max(s : FinancetimeextremeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_cursor_to_string(s : FinancetimeextremeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_view_make(size : Int) -> FinancetimeextremeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_view_len(s : FinancetimeextremeView) -> Int { s.size }

pub fn finance_time_extreme_view_get(s : FinancetimeextremeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_view_set(s : FinancetimeextremeView, i : Int, v : Double) -> FinancetimeextremeView {
  let result = finance_time_extreme_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_view_sum(s : FinancetimeextremeView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_extreme_view_mean(s : FinancetimeextremeView) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_extreme_view_sum(s) / s.size.to_double() }
}

pub fn finance_time_extreme_view_scale(s : FinancetimeextremeView, f : Double) -> FinancetimeextremeView {
  let result = finance_time_extreme_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_extreme_view_add(a : FinancetimeextremeView, b : FinancetimeextremeView) -> FinancetimeextremeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_extreme_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_extreme_view_copy(s : FinancetimeextremeView) -> FinancetimeextremeView {
  let result = finance_time_extreme_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_extreme_view_fill(s : FinancetimeextremeView, v : Double) -> FinancetimeextremeView {
  let result = finance_time_extreme_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_view_min(s : FinancetimeextremeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_view_max(s : FinancetimeextremeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_view_to_string(s : FinancetimeextremeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_range_make(size : Int) -> FinancetimeextremeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_range_len(s : FinancetimeextremeRange) -> Int { s.size }

pub fn finance_time_extreme_range_get(s : FinancetimeextremeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_range_set(s : FinancetimeextremeRange, i : Int, v : Double) -> FinancetimeextremeRange {
  let result = finance_time_extreme_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_range_sum(s : FinancetimeextremeRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_extreme_range_mean(s : FinancetimeextremeRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_extreme_range_sum(s) / s.size.to_double() }
}

pub fn finance_time_extreme_range_scale(s : FinancetimeextremeRange, f : Double) -> FinancetimeextremeRange {
  let result = finance_time_extreme_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_extreme_range_add(a : FinancetimeextremeRange, b : FinancetimeextremeRange) -> FinancetimeextremeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_extreme_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_extreme_range_copy(s : FinancetimeextremeRange) -> FinancetimeextremeRange {
  let result = finance_time_extreme_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_extreme_range_fill(s : FinancetimeextremeRange, v : Double) -> FinancetimeextremeRange {
  let result = finance_time_extreme_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_range_min(s : FinancetimeextremeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_range_max(s : FinancetimeextremeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_range_to_string(s : FinancetimeextremeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_slice_make(size : Int) -> FinancetimeextremeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_slice_len(s : FinancetimeextremeSlice) -> Int { s.size }

pub fn finance_time_extreme_slice_get(s : FinancetimeextremeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_slice_set(s : FinancetimeextremeSlice, i : Int, v : Double) -> FinancetimeextremeSlice {
  let result = finance_time_extreme_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_slice_sum(s : FinancetimeextremeSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_extreme_slice_mean(s : FinancetimeextremeSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_extreme_slice_sum(s) / s.size.to_double() }
}

pub fn finance_time_extreme_slice_scale(s : FinancetimeextremeSlice, f : Double) -> FinancetimeextremeSlice {
  let result = finance_time_extreme_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_extreme_slice_add(a : FinancetimeextremeSlice, b : FinancetimeextremeSlice) -> FinancetimeextremeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_extreme_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_extreme_slice_copy(s : FinancetimeextremeSlice) -> FinancetimeextremeSlice {
  let result = finance_time_extreme_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_extreme_slice_fill(s : FinancetimeextremeSlice, v : Double) -> FinancetimeextremeSlice {
  let result = finance_time_extreme_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_slice_min(s : FinancetimeextremeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_slice_max(s : FinancetimeextremeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_extreme_slice_to_string(s : FinancetimeextremeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn finance_time_extreme_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_extreme_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_extreme_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_extreme_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_extreme_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_extreme_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_extreme_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_extreme_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_extreme_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_extreme_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_extreme_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_extreme_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_extreme_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_extreme_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_extreme_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_extreme_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_extreme_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_extreme_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_extreme_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_extreme_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_extreme_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_extreme_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_extreme_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_extreme_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_extreme_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

