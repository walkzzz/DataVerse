///===
/// extcore/timeseries_garch

pub(all) struct TimeseriesgarchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_garch_make_point(x : Double, y : Double) -> TimeseriesgarchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_garch_make_point3(x : Double, y : Double, z : Double) -> TimeseriesgarchPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_garch_point_x(pt : TimeseriesgarchPoint) -> Double { pt.x }

pub fn timeseries_garch_point_y(pt : TimeseriesgarchPoint) -> Double { pt.y }

pub fn timeseries_garch_point_z(pt : TimeseriesgarchPoint) -> Double { pt.z }

pub fn timeseries_garch_point_label(pt : TimeseriesgarchPoint) -> Int { pt.label }

pub fn timeseries_garch_point_dist(a : TimeseriesgarchPoint, b : TimeseriesgarchPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  timeseries_garch_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_garch_point_add(a : TimeseriesgarchPoint, b : TimeseriesgarchPoint) -> TimeseriesgarchPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_garch_point_sub(a : TimeseriesgarchPoint, b : TimeseriesgarchPoint) -> TimeseriesgarchPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_garch_point_scale(pt : TimeseriesgarchPoint, s : Double) -> TimeseriesgarchPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_garch_point_dot(a : TimeseriesgarchPoint, b : TimeseriesgarchPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_garch_point_cross(a : TimeseriesgarchPoint, b : TimeseriesgarchPoint) -> TimeseriesgarchPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_garch_point_norm(pt : TimeseriesgarchPoint) -> Double {
  timeseries_garch_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_garch_point_normalize(pt : TimeseriesgarchPoint) -> TimeseriesgarchPoint {
  let n = timeseries_garch_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_garch_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_garch_point_negate(pt : TimeseriesgarchPoint) -> TimeseriesgarchPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_garch_point_mid(a : TimeseriesgarchPoint, b : TimeseriesgarchPoint) -> TimeseriesgarchPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_garch_point_lerp(a : TimeseriesgarchPoint, b : TimeseriesgarchPoint, t : Double) -> TimeseriesgarchPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_garch_point_to_string(pt : TimeseriesgarchPoint) -> String {
  "(" + timeseries_garch_dbl(pt.x) + ", " + timeseries_garch_dbl(pt.y) + ", " + timeseries_garch_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesgarchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_garch_make_series(vals : Array[Double], name : String) -> TimeseriesgarchSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_garch_series_len(s : TimeseriesgarchSeries) -> Int { s.vals.length() }

pub fn timeseries_garch_series_sum(s : TimeseriesgarchSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_garch_series_mean(s : TimeseriesgarchSeries) -> Double {
  let n = timeseries_garch_series_len(s)
  if n == 0 { 0.0 } else { timeseries_garch_series_sum(s) / n.to_double() }
}

pub fn timeseries_garch_series_min(s : TimeseriesgarchSeries) -> Double {
  let n = timeseries_garch_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_garch_series_max(s : TimeseriesgarchSeries) -> Double {
  let n = timeseries_garch_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_garch_series_range(s : TimeseriesgarchSeries) -> Double {
  timeseries_garch_series_max(s) - timeseries_garch_series_min(s)
}

pub fn timeseries_garch_series_var(s : TimeseriesgarchSeries) -> Double {
  let n = timeseries_garch_series_len(s)
  if n == 0 { 0.0 } else {
    let m = timeseries_garch_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn timeseries_garch_series_std(s : TimeseriesgarchSeries) -> Double { timeseries_garch_sqrt(timeseries_garch_series_var(s)) }

pub fn timeseries_garch_series_median(s : TimeseriesgarchSeries) -> Double {
  let n = timeseries_garch_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = timeseries_garch_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_garch_series_scale(s : TimeseriesgarchSeries, f : Double) -> TimeseriesgarchSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = timeseries_garch_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_garch_series_add(a : TimeseriesgarchSeries, b : TimeseriesgarchSeries) -> TimeseriesgarchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = timeseries_garch_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_garch_series_sub(a : TimeseriesgarchSeries, b : TimeseriesgarchSeries) -> TimeseriesgarchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = timeseries_garch_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_garch_series_normalize(s : TimeseriesgarchSeries) -> TimeseriesgarchSeries {
  let mn = timeseries_garch_series_min(s)
  let mx = timeseries_garch_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = timeseries_garch_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_garch_series_cumsum(s : TimeseriesgarchSeries) -> TimeseriesgarchSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = timeseries_garch_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_garch_series_to_string(s : TimeseriesgarchSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + timeseries_garch_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesgarchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_garch_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesgarchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_garch_matrix_identity(n : Int) -> TimeseriesgarchMatrix {
  let m = timeseries_garch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_garch_matrix_get(m : TimeseriesgarchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_garch_matrix_transpose(m : TimeseriesgarchMatrix) -> TimeseriesgarchMatrix {
  let result = timeseries_garch_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_garch_matrix_add(a : TimeseriesgarchMatrix, b : TimeseriesgarchMatrix) -> TimeseriesgarchMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_garch_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_garch_matrix_scale(m : TimeseriesgarchMatrix, s : Double) -> TimeseriesgarchMatrix {
  let result = timeseries_garch_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_garch_matrix_multiply(a : TimeseriesgarchMatrix, b : TimeseriesgarchMatrix) -> TimeseriesgarchMatrix {
  if a.cols != b.rows { return timeseries_garch_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_garch_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_garch_matrix_trace(m : TimeseriesgarchMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_garch_matrix_det(m : TimeseriesgarchMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_garch_matrix_norm(m : TimeseriesgarchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  timeseries_garch_sqrt(sum)
}

pub fn timeseries_garch_matrix_to_string(m : TimeseriesgarchMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + timeseries_garch_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct TimeseriesgarchVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_garch_make_vector(comps : Array[Double]) -> TimeseriesgarchVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_garch_vector_zero(dim : Int) -> TimeseriesgarchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_garch_vector_add(a : TimeseriesgarchVector, b : TimeseriesgarchVector) -> TimeseriesgarchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = timeseries_garch_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_garch_vector_sub(a : TimeseriesgarchVector, b : TimeseriesgarchVector) -> TimeseriesgarchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = timeseries_garch_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_garch_vector_scale(v : TimeseriesgarchVector, s : Double) -> TimeseriesgarchVector {
  let mut result = []
  for i in 0..<v.dim { result = timeseries_garch_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_garch_vector_dot(a : TimeseriesgarchVector, b : TimeseriesgarchVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_garch_vector_norm(v : TimeseriesgarchVector) -> Double { timeseries_garch_sqrt(timeseries_garch_vector_dot(v, v)) }

pub fn timeseries_garch_vector_normalize(v : TimeseriesgarchVector) -> TimeseriesgarchVector {
  let n = timeseries_garch_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_garch_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_garch_vector_dist(a : TimeseriesgarchVector, b : TimeseriesgarchVector) -> Double {
  timeseries_garch_vector_norm(timeseries_garch_vector_sub(a, b))
}

pub fn timeseries_garch_vector_to_string(v : TimeseriesgarchVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + timeseries_garch_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_garch_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn timeseries_garch_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = timeseries_garch_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_garch_std(data : Array[Double]) -> Double { timeseries_garch_sqrt(timeseries_garch_var(data)) }

pub fn timeseries_garch_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = timeseries_garch_mean(a); let mb = timeseries_garch_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn timeseries_garch_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = timeseries_garch_std(a); let sb = timeseries_garch_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { timeseries_garch_cov(a, b) / (sa * sb) }
}

pub fn timeseries_garch_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = timeseries_garch_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_garch_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn timeseries_garch_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_garch_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  timeseries_garch_sqrt(timeseries_garch_mse(pred, labels))
}

pub fn timeseries_garch_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + timeseries_garch_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn timeseries_garch_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = timeseries_garch_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn timeseries_garch_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn timeseries_garch_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn timeseries_garch_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = timeseries_garch_precision(pred, labels, pos); let r = timeseries_garch_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn timeseries_garch_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn timeseries_garch_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = timeseries_garch_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn timeseries_garch_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn timeseries_garch_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn timeseries_garch_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = timeseries_garch_gcd(a, b)
    (a / g) * b
  }
}

pub fn timeseries_garch_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn timeseries_garch_fibonacci(n : Int) -> Int {
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

pub fn timeseries_garch_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = timeseries_garch_min(data); let mx = timeseries_garch_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn timeseries_garch_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = timeseries_garch_mean(data); let sd = timeseries_garch_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn timeseries_garch_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn timeseries_garch_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn timeseries_garch_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn timeseries_garch_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn timeseries_garch_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn timeseries_garch_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn timeseries_garch_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn timeseries_garch_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn timeseries_garch_dbl(x : Double) -> String {
  let i = if x >= 0.0 { timeseries_garch_int(x) } else { -timeseries_garch_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { timeseries_garch_int(f * 1000000.0) } else { timeseries_garch_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn timeseries_garch_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn timeseries_garch_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct TimeseriesgarchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_frame_make(size : Int) -> TimeseriesgarchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_frame_len(s : TimeseriesgarchFrame) -> Int { s.size }

pub fn timeseries_garch_frame_get(s : TimeseriesgarchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_frame_set(s : TimeseriesgarchFrame, i : Int, v : Double) -> TimeseriesgarchFrame {
  let result = timeseries_garch_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_frame_sum(s : TimeseriesgarchFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_garch_frame_mean(s : TimeseriesgarchFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_garch_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_garch_frame_scale(s : TimeseriesgarchFrame, f : Double) -> TimeseriesgarchFrame {
  let result = timeseries_garch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_garch_frame_add(a : TimeseriesgarchFrame, b : TimeseriesgarchFrame) -> TimeseriesgarchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_garch_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_garch_frame_copy(s : TimeseriesgarchFrame) -> TimeseriesgarchFrame {
  let result = timeseries_garch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_garch_frame_fill(s : TimeseriesgarchFrame, v : Double) -> TimeseriesgarchFrame {
  let result = timeseries_garch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_frame_min(s : TimeseriesgarchFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_frame_max(s : TimeseriesgarchFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_frame_to_string(s : TimeseriesgarchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_table_make(size : Int) -> TimeseriesgarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_table_len(s : TimeseriesgarchTable) -> Int { s.size }

pub fn timeseries_garch_table_get(s : TimeseriesgarchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_table_set(s : TimeseriesgarchTable, i : Int, v : Double) -> TimeseriesgarchTable {
  let result = timeseries_garch_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_table_sum(s : TimeseriesgarchTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_garch_table_mean(s : TimeseriesgarchTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_garch_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_garch_table_scale(s : TimeseriesgarchTable, f : Double) -> TimeseriesgarchTable {
  let result = timeseries_garch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_garch_table_add(a : TimeseriesgarchTable, b : TimeseriesgarchTable) -> TimeseriesgarchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_garch_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_garch_table_copy(s : TimeseriesgarchTable) -> TimeseriesgarchTable {
  let result = timeseries_garch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_garch_table_fill(s : TimeseriesgarchTable, v : Double) -> TimeseriesgarchTable {
  let result = timeseries_garch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_table_min(s : TimeseriesgarchTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_table_max(s : TimeseriesgarchTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_table_to_string(s : TimeseriesgarchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_graphn_make(size : Int) -> TimeseriesgarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_graphn_len(s : TimeseriesgarchGraphN) -> Int { s.size }

pub fn timeseries_garch_graphn_get(s : TimeseriesgarchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_graphn_set(s : TimeseriesgarchGraphN, i : Int, v : Double) -> TimeseriesgarchGraphN {
  let result = timeseries_garch_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_graphn_sum(s : TimeseriesgarchGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_garch_graphn_mean(s : TimeseriesgarchGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_garch_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_garch_graphn_scale(s : TimeseriesgarchGraphN, f : Double) -> TimeseriesgarchGraphN {
  let result = timeseries_garch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_garch_graphn_add(a : TimeseriesgarchGraphN, b : TimeseriesgarchGraphN) -> TimeseriesgarchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_garch_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_garch_graphn_copy(s : TimeseriesgarchGraphN) -> TimeseriesgarchGraphN {
  let result = timeseries_garch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_garch_graphn_fill(s : TimeseriesgarchGraphN, v : Double) -> TimeseriesgarchGraphN {
  let result = timeseries_garch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_graphn_min(s : TimeseriesgarchGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_graphn_max(s : TimeseriesgarchGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_graphn_to_string(s : TimeseriesgarchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_node_make(size : Int) -> TimeseriesgarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_node_len(s : TimeseriesgarchNode) -> Int { s.size }

pub fn timeseries_garch_node_get(s : TimeseriesgarchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_node_set(s : TimeseriesgarchNode, i : Int, v : Double) -> TimeseriesgarchNode {
  let result = timeseries_garch_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_node_sum(s : TimeseriesgarchNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_garch_node_mean(s : TimeseriesgarchNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_garch_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_garch_node_scale(s : TimeseriesgarchNode, f : Double) -> TimeseriesgarchNode {
  let result = timeseries_garch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_garch_node_add(a : TimeseriesgarchNode, b : TimeseriesgarchNode) -> TimeseriesgarchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_garch_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_garch_node_copy(s : TimeseriesgarchNode) -> TimeseriesgarchNode {
  let result = timeseries_garch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_garch_node_fill(s : TimeseriesgarchNode, v : Double) -> TimeseriesgarchNode {
  let result = timeseries_garch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_node_min(s : TimeseriesgarchNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_node_max(s : TimeseriesgarchNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_node_to_string(s : TimeseriesgarchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_edge_make(size : Int) -> TimeseriesgarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_edge_len(s : TimeseriesgarchEdge) -> Int { s.size }

pub fn timeseries_garch_edge_get(s : TimeseriesgarchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_edge_set(s : TimeseriesgarchEdge, i : Int, v : Double) -> TimeseriesgarchEdge {
  let result = timeseries_garch_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_edge_sum(s : TimeseriesgarchEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_garch_edge_mean(s : TimeseriesgarchEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_garch_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_garch_edge_scale(s : TimeseriesgarchEdge, f : Double) -> TimeseriesgarchEdge {
  let result = timeseries_garch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_garch_edge_add(a : TimeseriesgarchEdge, b : TimeseriesgarchEdge) -> TimeseriesgarchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_garch_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_garch_edge_copy(s : TimeseriesgarchEdge) -> TimeseriesgarchEdge {
  let result = timeseries_garch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_garch_edge_fill(s : TimeseriesgarchEdge, v : Double) -> TimeseriesgarchEdge {
  let result = timeseries_garch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_edge_min(s : TimeseriesgarchEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_edge_max(s : TimeseriesgarchEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_edge_to_string(s : TimeseriesgarchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_path_make(size : Int) -> TimeseriesgarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_path_len(s : TimeseriesgarchPath) -> Int { s.size }

pub fn timeseries_garch_path_get(s : TimeseriesgarchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_path_set(s : TimeseriesgarchPath, i : Int, v : Double) -> TimeseriesgarchPath {
  let result = timeseries_garch_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_path_sum(s : TimeseriesgarchPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_garch_path_mean(s : TimeseriesgarchPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_garch_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_garch_path_scale(s : TimeseriesgarchPath, f : Double) -> TimeseriesgarchPath {
  let result = timeseries_garch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_garch_path_add(a : TimeseriesgarchPath, b : TimeseriesgarchPath) -> TimeseriesgarchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_garch_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_garch_path_copy(s : TimeseriesgarchPath) -> TimeseriesgarchPath {
  let result = timeseries_garch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_garch_path_fill(s : TimeseriesgarchPath, v : Double) -> TimeseriesgarchPath {
  let result = timeseries_garch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_path_min(s : TimeseriesgarchPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_path_max(s : TimeseriesgarchPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_path_to_string(s : TimeseriesgarchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_cluster_make(size : Int) -> TimeseriesgarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_cluster_len(s : TimeseriesgarchCluster) -> Int { s.size }

pub fn timeseries_garch_cluster_get(s : TimeseriesgarchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_cluster_set(s : TimeseriesgarchCluster, i : Int, v : Double) -> TimeseriesgarchCluster {
  let result = timeseries_garch_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_cluster_sum(s : TimeseriesgarchCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_garch_cluster_mean(s : TimeseriesgarchCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_garch_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_garch_cluster_scale(s : TimeseriesgarchCluster, f : Double) -> TimeseriesgarchCluster {
  let result = timeseries_garch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_garch_cluster_add(a : TimeseriesgarchCluster, b : TimeseriesgarchCluster) -> TimeseriesgarchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_garch_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_garch_cluster_copy(s : TimeseriesgarchCluster) -> TimeseriesgarchCluster {
  let result = timeseries_garch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_garch_cluster_fill(s : TimeseriesgarchCluster, v : Double) -> TimeseriesgarchCluster {
  let result = timeseries_garch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_cluster_min(s : TimeseriesgarchCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_cluster_max(s : TimeseriesgarchCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_cluster_to_string(s : TimeseriesgarchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_model_make(size : Int) -> TimeseriesgarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_model_len(s : TimeseriesgarchModel) -> Int { s.size }

pub fn timeseries_garch_model_get(s : TimeseriesgarchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_model_set(s : TimeseriesgarchModel, i : Int, v : Double) -> TimeseriesgarchModel {
  let result = timeseries_garch_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_model_sum(s : TimeseriesgarchModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_garch_model_mean(s : TimeseriesgarchModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_garch_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_garch_model_scale(s : TimeseriesgarchModel, f : Double) -> TimeseriesgarchModel {
  let result = timeseries_garch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_garch_model_add(a : TimeseriesgarchModel, b : TimeseriesgarchModel) -> TimeseriesgarchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_garch_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_garch_model_copy(s : TimeseriesgarchModel) -> TimeseriesgarchModel {
  let result = timeseries_garch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_garch_model_fill(s : TimeseriesgarchModel, v : Double) -> TimeseriesgarchModel {
  let result = timeseries_garch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_model_min(s : TimeseriesgarchModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_model_max(s : TimeseriesgarchModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_model_to_string(s : TimeseriesgarchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_layer_make(size : Int) -> TimeseriesgarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_layer_len(s : TimeseriesgarchLayer) -> Int { s.size }

pub fn timeseries_garch_layer_get(s : TimeseriesgarchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_layer_set(s : TimeseriesgarchLayer, i : Int, v : Double) -> TimeseriesgarchLayer {
  let result = timeseries_garch_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_layer_sum(s : TimeseriesgarchLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_garch_layer_mean(s : TimeseriesgarchLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_garch_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_garch_layer_scale(s : TimeseriesgarchLayer, f : Double) -> TimeseriesgarchLayer {
  let result = timeseries_garch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_garch_layer_add(a : TimeseriesgarchLayer, b : TimeseriesgarchLayer) -> TimeseriesgarchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_garch_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_garch_layer_copy(s : TimeseriesgarchLayer) -> TimeseriesgarchLayer {
  let result = timeseries_garch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_garch_layer_fill(s : TimeseriesgarchLayer, v : Double) -> TimeseriesgarchLayer {
  let result = timeseries_garch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_layer_min(s : TimeseriesgarchLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_layer_max(s : TimeseriesgarchLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_layer_to_string(s : TimeseriesgarchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_buffer_make(size : Int) -> TimeseriesgarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_buffer_len(s : TimeseriesgarchBuffer) -> Int { s.size }

pub fn timeseries_garch_buffer_get(s : TimeseriesgarchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_buffer_set(s : TimeseriesgarchBuffer, i : Int, v : Double) -> TimeseriesgarchBuffer {
  let result = timeseries_garch_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_buffer_sum(s : TimeseriesgarchBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_garch_buffer_mean(s : TimeseriesgarchBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_garch_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_garch_buffer_scale(s : TimeseriesgarchBuffer, f : Double) -> TimeseriesgarchBuffer {
  let result = timeseries_garch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_garch_buffer_add(a : TimeseriesgarchBuffer, b : TimeseriesgarchBuffer) -> TimeseriesgarchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_garch_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_garch_buffer_copy(s : TimeseriesgarchBuffer) -> TimeseriesgarchBuffer {
  let result = timeseries_garch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_garch_buffer_fill(s : TimeseriesgarchBuffer, v : Double) -> TimeseriesgarchBuffer {
  let result = timeseries_garch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_buffer_min(s : TimeseriesgarchBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_buffer_max(s : TimeseriesgarchBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_buffer_to_string(s : TimeseriesgarchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_cursor_make(size : Int) -> TimeseriesgarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_cursor_len(s : TimeseriesgarchCursor) -> Int { s.size }

pub fn timeseries_garch_cursor_get(s : TimeseriesgarchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_cursor_set(s : TimeseriesgarchCursor, i : Int, v : Double) -> TimeseriesgarchCursor {
  let result = timeseries_garch_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_cursor_sum(s : TimeseriesgarchCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_garch_cursor_mean(s : TimeseriesgarchCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_garch_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_garch_cursor_scale(s : TimeseriesgarchCursor, f : Double) -> TimeseriesgarchCursor {
  let result = timeseries_garch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_garch_cursor_add(a : TimeseriesgarchCursor, b : TimeseriesgarchCursor) -> TimeseriesgarchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_garch_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_garch_cursor_copy(s : TimeseriesgarchCursor) -> TimeseriesgarchCursor {
  let result = timeseries_garch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_garch_cursor_fill(s : TimeseriesgarchCursor, v : Double) -> TimeseriesgarchCursor {
  let result = timeseries_garch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_cursor_min(s : TimeseriesgarchCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_cursor_max(s : TimeseriesgarchCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_cursor_to_string(s : TimeseriesgarchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_view_make(size : Int) -> TimeseriesgarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_view_len(s : TimeseriesgarchView) -> Int { s.size }

pub fn timeseries_garch_view_get(s : TimeseriesgarchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_view_set(s : TimeseriesgarchView, i : Int, v : Double) -> TimeseriesgarchView {
  let result = timeseries_garch_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_view_sum(s : TimeseriesgarchView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_garch_view_mean(s : TimeseriesgarchView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_garch_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_garch_view_scale(s : TimeseriesgarchView, f : Double) -> TimeseriesgarchView {
  let result = timeseries_garch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_garch_view_add(a : TimeseriesgarchView, b : TimeseriesgarchView) -> TimeseriesgarchView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_garch_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_garch_view_copy(s : TimeseriesgarchView) -> TimeseriesgarchView {
  let result = timeseries_garch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_garch_view_fill(s : TimeseriesgarchView, v : Double) -> TimeseriesgarchView {
  let result = timeseries_garch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_view_min(s : TimeseriesgarchView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_view_max(s : TimeseriesgarchView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_view_to_string(s : TimeseriesgarchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_range_make(size : Int) -> TimeseriesgarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_range_len(s : TimeseriesgarchRange) -> Int { s.size }

pub fn timeseries_garch_range_get(s : TimeseriesgarchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_range_set(s : TimeseriesgarchRange, i : Int, v : Double) -> TimeseriesgarchRange {
  let result = timeseries_garch_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_range_sum(s : TimeseriesgarchRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_garch_range_mean(s : TimeseriesgarchRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_garch_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_garch_range_scale(s : TimeseriesgarchRange, f : Double) -> TimeseriesgarchRange {
  let result = timeseries_garch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_garch_range_add(a : TimeseriesgarchRange, b : TimeseriesgarchRange) -> TimeseriesgarchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_garch_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_garch_range_copy(s : TimeseriesgarchRange) -> TimeseriesgarchRange {
  let result = timeseries_garch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_garch_range_fill(s : TimeseriesgarchRange, v : Double) -> TimeseriesgarchRange {
  let result = timeseries_garch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_range_min(s : TimeseriesgarchRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_range_max(s : TimeseriesgarchRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_range_to_string(s : TimeseriesgarchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_slice_make(size : Int) -> TimeseriesgarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_slice_len(s : TimeseriesgarchSlice) -> Int { s.size }

pub fn timeseries_garch_slice_get(s : TimeseriesgarchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_slice_set(s : TimeseriesgarchSlice, i : Int, v : Double) -> TimeseriesgarchSlice {
  let result = timeseries_garch_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_slice_sum(s : TimeseriesgarchSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_garch_slice_mean(s : TimeseriesgarchSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_garch_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_garch_slice_scale(s : TimeseriesgarchSlice, f : Double) -> TimeseriesgarchSlice {
  let result = timeseries_garch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_garch_slice_add(a : TimeseriesgarchSlice, b : TimeseriesgarchSlice) -> TimeseriesgarchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_garch_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_garch_slice_copy(s : TimeseriesgarchSlice) -> TimeseriesgarchSlice {
  let result = timeseries_garch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_garch_slice_fill(s : TimeseriesgarchSlice, v : Double) -> TimeseriesgarchSlice {
  let result = timeseries_garch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_slice_min(s : TimeseriesgarchSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_slice_max(s : TimeseriesgarchSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_garch_slice_to_string(s : TimeseriesgarchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn timeseries_garch_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_garch_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_garch_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_garch_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_garch_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_garch_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_garch_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_garch_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_garch_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_garch_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_garch_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_garch_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_garch_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_garch_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_garch_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_garch_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_garch_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_garch_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_garch_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_garch_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_garch_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_garch_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_garch_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_garch_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_garch_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

