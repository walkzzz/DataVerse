///===
/// extcore/timeseries_exponential

pub(all) struct TimeseriesexponentialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_exponential_make_point(x : Double, y : Double) -> TimeseriesexponentialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_exponential_make_point3(x : Double, y : Double, z : Double) -> TimeseriesexponentialPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_exponential_point_x(pt : TimeseriesexponentialPoint) -> Double { pt.x }

pub fn timeseries_exponential_point_y(pt : TimeseriesexponentialPoint) -> Double { pt.y }

pub fn timeseries_exponential_point_z(pt : TimeseriesexponentialPoint) -> Double { pt.z }

pub fn timeseries_exponential_point_label(pt : TimeseriesexponentialPoint) -> Int { pt.label }

pub fn timeseries_exponential_point_dist(a : TimeseriesexponentialPoint, b : TimeseriesexponentialPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  timeseries_exponential_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_exponential_point_add(a : TimeseriesexponentialPoint, b : TimeseriesexponentialPoint) -> TimeseriesexponentialPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_exponential_point_sub(a : TimeseriesexponentialPoint, b : TimeseriesexponentialPoint) -> TimeseriesexponentialPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_exponential_point_scale(pt : TimeseriesexponentialPoint, s : Double) -> TimeseriesexponentialPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_exponential_point_dot(a : TimeseriesexponentialPoint, b : TimeseriesexponentialPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_exponential_point_cross(a : TimeseriesexponentialPoint, b : TimeseriesexponentialPoint) -> TimeseriesexponentialPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_exponential_point_norm(pt : TimeseriesexponentialPoint) -> Double {
  timeseries_exponential_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_exponential_point_normalize(pt : TimeseriesexponentialPoint) -> TimeseriesexponentialPoint {
  let n = timeseries_exponential_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_exponential_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_exponential_point_negate(pt : TimeseriesexponentialPoint) -> TimeseriesexponentialPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_exponential_point_mid(a : TimeseriesexponentialPoint, b : TimeseriesexponentialPoint) -> TimeseriesexponentialPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_exponential_point_lerp(a : TimeseriesexponentialPoint, b : TimeseriesexponentialPoint, t : Double) -> TimeseriesexponentialPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_exponential_point_to_string(pt : TimeseriesexponentialPoint) -> String {
  "(" + timeseries_exponential_dbl(pt.x) + ", " + timeseries_exponential_dbl(pt.y) + ", " + timeseries_exponential_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesexponentialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_exponential_make_series(vals : Array[Double], name : String) -> TimeseriesexponentialSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_exponential_series_len(s : TimeseriesexponentialSeries) -> Int { s.vals.length() }

pub fn timeseries_exponential_series_sum(s : TimeseriesexponentialSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_exponential_series_mean(s : TimeseriesexponentialSeries) -> Double {
  let n = timeseries_exponential_series_len(s)
  if n == 0 { 0.0 } else { timeseries_exponential_series_sum(s) / n.to_double() }
}

pub fn timeseries_exponential_series_min(s : TimeseriesexponentialSeries) -> Double {
  let n = timeseries_exponential_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_exponential_series_max(s : TimeseriesexponentialSeries) -> Double {
  let n = timeseries_exponential_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_exponential_series_range(s : TimeseriesexponentialSeries) -> Double {
  timeseries_exponential_series_max(s) - timeseries_exponential_series_min(s)
}

pub fn timeseries_exponential_series_var(s : TimeseriesexponentialSeries) -> Double {
  let n = timeseries_exponential_series_len(s)
  if n == 0 { 0.0 } else {
    let m = timeseries_exponential_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn timeseries_exponential_series_std(s : TimeseriesexponentialSeries) -> Double { timeseries_exponential_sqrt(timeseries_exponential_series_var(s)) }

pub fn timeseries_exponential_series_median(s : TimeseriesexponentialSeries) -> Double {
  let n = timeseries_exponential_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = timeseries_exponential_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_exponential_series_scale(s : TimeseriesexponentialSeries, f : Double) -> TimeseriesexponentialSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = timeseries_exponential_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_exponential_series_add(a : TimeseriesexponentialSeries, b : TimeseriesexponentialSeries) -> TimeseriesexponentialSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = timeseries_exponential_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_exponential_series_sub(a : TimeseriesexponentialSeries, b : TimeseriesexponentialSeries) -> TimeseriesexponentialSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = timeseries_exponential_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_exponential_series_normalize(s : TimeseriesexponentialSeries) -> TimeseriesexponentialSeries {
  let mn = timeseries_exponential_series_min(s)
  let mx = timeseries_exponential_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = timeseries_exponential_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_exponential_series_cumsum(s : TimeseriesexponentialSeries) -> TimeseriesexponentialSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = timeseries_exponential_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_exponential_series_to_string(s : TimeseriesexponentialSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + timeseries_exponential_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesexponentialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_exponential_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesexponentialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_exponential_matrix_identity(n : Int) -> TimeseriesexponentialMatrix {
  let m = timeseries_exponential_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_exponential_matrix_get(m : TimeseriesexponentialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_exponential_matrix_transpose(m : TimeseriesexponentialMatrix) -> TimeseriesexponentialMatrix {
  let result = timeseries_exponential_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_exponential_matrix_add(a : TimeseriesexponentialMatrix, b : TimeseriesexponentialMatrix) -> TimeseriesexponentialMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_exponential_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_exponential_matrix_scale(m : TimeseriesexponentialMatrix, s : Double) -> TimeseriesexponentialMatrix {
  let result = timeseries_exponential_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_exponential_matrix_multiply(a : TimeseriesexponentialMatrix, b : TimeseriesexponentialMatrix) -> TimeseriesexponentialMatrix {
  if a.cols != b.rows { return timeseries_exponential_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_exponential_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_exponential_matrix_trace(m : TimeseriesexponentialMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_exponential_matrix_det(m : TimeseriesexponentialMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_exponential_matrix_norm(m : TimeseriesexponentialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  timeseries_exponential_sqrt(sum)
}

pub fn timeseries_exponential_matrix_to_string(m : TimeseriesexponentialMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + timeseries_exponential_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct TimeseriesexponentialVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_exponential_make_vector(comps : Array[Double]) -> TimeseriesexponentialVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_exponential_vector_zero(dim : Int) -> TimeseriesexponentialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_exponential_vector_add(a : TimeseriesexponentialVector, b : TimeseriesexponentialVector) -> TimeseriesexponentialVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = timeseries_exponential_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_exponential_vector_sub(a : TimeseriesexponentialVector, b : TimeseriesexponentialVector) -> TimeseriesexponentialVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = timeseries_exponential_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_exponential_vector_scale(v : TimeseriesexponentialVector, s : Double) -> TimeseriesexponentialVector {
  let mut result = []
  for i in 0..<v.dim { result = timeseries_exponential_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_exponential_vector_dot(a : TimeseriesexponentialVector, b : TimeseriesexponentialVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_exponential_vector_norm(v : TimeseriesexponentialVector) -> Double { timeseries_exponential_sqrt(timeseries_exponential_vector_dot(v, v)) }

pub fn timeseries_exponential_vector_normalize(v : TimeseriesexponentialVector) -> TimeseriesexponentialVector {
  let n = timeseries_exponential_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_exponential_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_exponential_vector_dist(a : TimeseriesexponentialVector, b : TimeseriesexponentialVector) -> Double {
  timeseries_exponential_vector_norm(timeseries_exponential_vector_sub(a, b))
}

pub fn timeseries_exponential_vector_to_string(v : TimeseriesexponentialVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + timeseries_exponential_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_exponential_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn timeseries_exponential_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = timeseries_exponential_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_exponential_std(data : Array[Double]) -> Double { timeseries_exponential_sqrt(timeseries_exponential_var(data)) }

pub fn timeseries_exponential_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = timeseries_exponential_mean(a); let mb = timeseries_exponential_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn timeseries_exponential_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = timeseries_exponential_std(a); let sb = timeseries_exponential_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { timeseries_exponential_cov(a, b) / (sa * sb) }
}

pub fn timeseries_exponential_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = timeseries_exponential_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_exponential_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn timeseries_exponential_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_exponential_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  timeseries_exponential_sqrt(timeseries_exponential_mse(pred, labels))
}

pub fn timeseries_exponential_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + timeseries_exponential_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn timeseries_exponential_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = timeseries_exponential_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn timeseries_exponential_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn timeseries_exponential_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn timeseries_exponential_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = timeseries_exponential_precision(pred, labels, pos); let r = timeseries_exponential_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn timeseries_exponential_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn timeseries_exponential_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = timeseries_exponential_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn timeseries_exponential_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn timeseries_exponential_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn timeseries_exponential_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = timeseries_exponential_gcd(a, b)
    (a / g) * b
  }
}

pub fn timeseries_exponential_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn timeseries_exponential_fibonacci(n : Int) -> Int {
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

pub fn timeseries_exponential_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = timeseries_exponential_min(data); let mx = timeseries_exponential_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn timeseries_exponential_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = timeseries_exponential_mean(data); let sd = timeseries_exponential_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn timeseries_exponential_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn timeseries_exponential_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn timeseries_exponential_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn timeseries_exponential_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn timeseries_exponential_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn timeseries_exponential_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn timeseries_exponential_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn timeseries_exponential_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn timeseries_exponential_dbl(x : Double) -> String {
  let i = if x >= 0.0 { timeseries_exponential_int(x) } else { -timeseries_exponential_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { timeseries_exponential_int(f * 1000000.0) } else { timeseries_exponential_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn timeseries_exponential_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn timeseries_exponential_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct TimeseriesexponentialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_frame_make(size : Int) -> TimeseriesexponentialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_frame_len(s : TimeseriesexponentialFrame) -> Int { s.size }

pub fn timeseries_exponential_frame_get(s : TimeseriesexponentialFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_frame_set(s : TimeseriesexponentialFrame, i : Int, v : Double) -> TimeseriesexponentialFrame {
  let result = timeseries_exponential_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_frame_sum(s : TimeseriesexponentialFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_exponential_frame_mean(s : TimeseriesexponentialFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_exponential_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_exponential_frame_scale(s : TimeseriesexponentialFrame, f : Double) -> TimeseriesexponentialFrame {
  let result = timeseries_exponential_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_exponential_frame_add(a : TimeseriesexponentialFrame, b : TimeseriesexponentialFrame) -> TimeseriesexponentialFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_exponential_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_exponential_frame_copy(s : TimeseriesexponentialFrame) -> TimeseriesexponentialFrame {
  let result = timeseries_exponential_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_exponential_frame_fill(s : TimeseriesexponentialFrame, v : Double) -> TimeseriesexponentialFrame {
  let result = timeseries_exponential_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_frame_min(s : TimeseriesexponentialFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_frame_max(s : TimeseriesexponentialFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_frame_to_string(s : TimeseriesexponentialFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_table_make(size : Int) -> TimeseriesexponentialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_table_len(s : TimeseriesexponentialTable) -> Int { s.size }

pub fn timeseries_exponential_table_get(s : TimeseriesexponentialTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_table_set(s : TimeseriesexponentialTable, i : Int, v : Double) -> TimeseriesexponentialTable {
  let result = timeseries_exponential_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_table_sum(s : TimeseriesexponentialTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_exponential_table_mean(s : TimeseriesexponentialTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_exponential_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_exponential_table_scale(s : TimeseriesexponentialTable, f : Double) -> TimeseriesexponentialTable {
  let result = timeseries_exponential_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_exponential_table_add(a : TimeseriesexponentialTable, b : TimeseriesexponentialTable) -> TimeseriesexponentialTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_exponential_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_exponential_table_copy(s : TimeseriesexponentialTable) -> TimeseriesexponentialTable {
  let result = timeseries_exponential_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_exponential_table_fill(s : TimeseriesexponentialTable, v : Double) -> TimeseriesexponentialTable {
  let result = timeseries_exponential_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_table_min(s : TimeseriesexponentialTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_table_max(s : TimeseriesexponentialTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_table_to_string(s : TimeseriesexponentialTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_graphn_make(size : Int) -> TimeseriesexponentialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_graphn_len(s : TimeseriesexponentialGraphN) -> Int { s.size }

pub fn timeseries_exponential_graphn_get(s : TimeseriesexponentialGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_graphn_set(s : TimeseriesexponentialGraphN, i : Int, v : Double) -> TimeseriesexponentialGraphN {
  let result = timeseries_exponential_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_graphn_sum(s : TimeseriesexponentialGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_exponential_graphn_mean(s : TimeseriesexponentialGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_exponential_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_exponential_graphn_scale(s : TimeseriesexponentialGraphN, f : Double) -> TimeseriesexponentialGraphN {
  let result = timeseries_exponential_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_exponential_graphn_add(a : TimeseriesexponentialGraphN, b : TimeseriesexponentialGraphN) -> TimeseriesexponentialGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_exponential_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_exponential_graphn_copy(s : TimeseriesexponentialGraphN) -> TimeseriesexponentialGraphN {
  let result = timeseries_exponential_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_exponential_graphn_fill(s : TimeseriesexponentialGraphN, v : Double) -> TimeseriesexponentialGraphN {
  let result = timeseries_exponential_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_graphn_min(s : TimeseriesexponentialGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_graphn_max(s : TimeseriesexponentialGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_graphn_to_string(s : TimeseriesexponentialGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_node_make(size : Int) -> TimeseriesexponentialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_node_len(s : TimeseriesexponentialNode) -> Int { s.size }

pub fn timeseries_exponential_node_get(s : TimeseriesexponentialNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_node_set(s : TimeseriesexponentialNode, i : Int, v : Double) -> TimeseriesexponentialNode {
  let result = timeseries_exponential_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_node_sum(s : TimeseriesexponentialNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_exponential_node_mean(s : TimeseriesexponentialNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_exponential_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_exponential_node_scale(s : TimeseriesexponentialNode, f : Double) -> TimeseriesexponentialNode {
  let result = timeseries_exponential_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_exponential_node_add(a : TimeseriesexponentialNode, b : TimeseriesexponentialNode) -> TimeseriesexponentialNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_exponential_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_exponential_node_copy(s : TimeseriesexponentialNode) -> TimeseriesexponentialNode {
  let result = timeseries_exponential_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_exponential_node_fill(s : TimeseriesexponentialNode, v : Double) -> TimeseriesexponentialNode {
  let result = timeseries_exponential_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_node_min(s : TimeseriesexponentialNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_node_max(s : TimeseriesexponentialNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_node_to_string(s : TimeseriesexponentialNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_edge_make(size : Int) -> TimeseriesexponentialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_edge_len(s : TimeseriesexponentialEdge) -> Int { s.size }

pub fn timeseries_exponential_edge_get(s : TimeseriesexponentialEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_edge_set(s : TimeseriesexponentialEdge, i : Int, v : Double) -> TimeseriesexponentialEdge {
  let result = timeseries_exponential_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_edge_sum(s : TimeseriesexponentialEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_exponential_edge_mean(s : TimeseriesexponentialEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_exponential_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_exponential_edge_scale(s : TimeseriesexponentialEdge, f : Double) -> TimeseriesexponentialEdge {
  let result = timeseries_exponential_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_exponential_edge_add(a : TimeseriesexponentialEdge, b : TimeseriesexponentialEdge) -> TimeseriesexponentialEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_exponential_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_exponential_edge_copy(s : TimeseriesexponentialEdge) -> TimeseriesexponentialEdge {
  let result = timeseries_exponential_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_exponential_edge_fill(s : TimeseriesexponentialEdge, v : Double) -> TimeseriesexponentialEdge {
  let result = timeseries_exponential_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_edge_min(s : TimeseriesexponentialEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_edge_max(s : TimeseriesexponentialEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_edge_to_string(s : TimeseriesexponentialEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_path_make(size : Int) -> TimeseriesexponentialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_path_len(s : TimeseriesexponentialPath) -> Int { s.size }

pub fn timeseries_exponential_path_get(s : TimeseriesexponentialPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_path_set(s : TimeseriesexponentialPath, i : Int, v : Double) -> TimeseriesexponentialPath {
  let result = timeseries_exponential_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_path_sum(s : TimeseriesexponentialPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_exponential_path_mean(s : TimeseriesexponentialPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_exponential_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_exponential_path_scale(s : TimeseriesexponentialPath, f : Double) -> TimeseriesexponentialPath {
  let result = timeseries_exponential_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_exponential_path_add(a : TimeseriesexponentialPath, b : TimeseriesexponentialPath) -> TimeseriesexponentialPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_exponential_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_exponential_path_copy(s : TimeseriesexponentialPath) -> TimeseriesexponentialPath {
  let result = timeseries_exponential_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_exponential_path_fill(s : TimeseriesexponentialPath, v : Double) -> TimeseriesexponentialPath {
  let result = timeseries_exponential_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_path_min(s : TimeseriesexponentialPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_path_max(s : TimeseriesexponentialPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_path_to_string(s : TimeseriesexponentialPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_cluster_make(size : Int) -> TimeseriesexponentialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_cluster_len(s : TimeseriesexponentialCluster) -> Int { s.size }

pub fn timeseries_exponential_cluster_get(s : TimeseriesexponentialCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_cluster_set(s : TimeseriesexponentialCluster, i : Int, v : Double) -> TimeseriesexponentialCluster {
  let result = timeseries_exponential_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_cluster_sum(s : TimeseriesexponentialCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_exponential_cluster_mean(s : TimeseriesexponentialCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_exponential_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_exponential_cluster_scale(s : TimeseriesexponentialCluster, f : Double) -> TimeseriesexponentialCluster {
  let result = timeseries_exponential_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_exponential_cluster_add(a : TimeseriesexponentialCluster, b : TimeseriesexponentialCluster) -> TimeseriesexponentialCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_exponential_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_exponential_cluster_copy(s : TimeseriesexponentialCluster) -> TimeseriesexponentialCluster {
  let result = timeseries_exponential_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_exponential_cluster_fill(s : TimeseriesexponentialCluster, v : Double) -> TimeseriesexponentialCluster {
  let result = timeseries_exponential_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_cluster_min(s : TimeseriesexponentialCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_cluster_max(s : TimeseriesexponentialCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_cluster_to_string(s : TimeseriesexponentialCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_model_make(size : Int) -> TimeseriesexponentialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_model_len(s : TimeseriesexponentialModel) -> Int { s.size }

pub fn timeseries_exponential_model_get(s : TimeseriesexponentialModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_model_set(s : TimeseriesexponentialModel, i : Int, v : Double) -> TimeseriesexponentialModel {
  let result = timeseries_exponential_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_model_sum(s : TimeseriesexponentialModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_exponential_model_mean(s : TimeseriesexponentialModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_exponential_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_exponential_model_scale(s : TimeseriesexponentialModel, f : Double) -> TimeseriesexponentialModel {
  let result = timeseries_exponential_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_exponential_model_add(a : TimeseriesexponentialModel, b : TimeseriesexponentialModel) -> TimeseriesexponentialModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_exponential_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_exponential_model_copy(s : TimeseriesexponentialModel) -> TimeseriesexponentialModel {
  let result = timeseries_exponential_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_exponential_model_fill(s : TimeseriesexponentialModel, v : Double) -> TimeseriesexponentialModel {
  let result = timeseries_exponential_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_model_min(s : TimeseriesexponentialModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_model_max(s : TimeseriesexponentialModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_model_to_string(s : TimeseriesexponentialModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_layer_make(size : Int) -> TimeseriesexponentialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_layer_len(s : TimeseriesexponentialLayer) -> Int { s.size }

pub fn timeseries_exponential_layer_get(s : TimeseriesexponentialLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_layer_set(s : TimeseriesexponentialLayer, i : Int, v : Double) -> TimeseriesexponentialLayer {
  let result = timeseries_exponential_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_layer_sum(s : TimeseriesexponentialLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_exponential_layer_mean(s : TimeseriesexponentialLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_exponential_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_exponential_layer_scale(s : TimeseriesexponentialLayer, f : Double) -> TimeseriesexponentialLayer {
  let result = timeseries_exponential_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_exponential_layer_add(a : TimeseriesexponentialLayer, b : TimeseriesexponentialLayer) -> TimeseriesexponentialLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_exponential_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_exponential_layer_copy(s : TimeseriesexponentialLayer) -> TimeseriesexponentialLayer {
  let result = timeseries_exponential_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_exponential_layer_fill(s : TimeseriesexponentialLayer, v : Double) -> TimeseriesexponentialLayer {
  let result = timeseries_exponential_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_layer_min(s : TimeseriesexponentialLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_layer_max(s : TimeseriesexponentialLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_layer_to_string(s : TimeseriesexponentialLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_buffer_make(size : Int) -> TimeseriesexponentialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_buffer_len(s : TimeseriesexponentialBuffer) -> Int { s.size }

pub fn timeseries_exponential_buffer_get(s : TimeseriesexponentialBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_buffer_set(s : TimeseriesexponentialBuffer, i : Int, v : Double) -> TimeseriesexponentialBuffer {
  let result = timeseries_exponential_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_buffer_sum(s : TimeseriesexponentialBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_exponential_buffer_mean(s : TimeseriesexponentialBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_exponential_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_exponential_buffer_scale(s : TimeseriesexponentialBuffer, f : Double) -> TimeseriesexponentialBuffer {
  let result = timeseries_exponential_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_exponential_buffer_add(a : TimeseriesexponentialBuffer, b : TimeseriesexponentialBuffer) -> TimeseriesexponentialBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_exponential_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_exponential_buffer_copy(s : TimeseriesexponentialBuffer) -> TimeseriesexponentialBuffer {
  let result = timeseries_exponential_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_exponential_buffer_fill(s : TimeseriesexponentialBuffer, v : Double) -> TimeseriesexponentialBuffer {
  let result = timeseries_exponential_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_buffer_min(s : TimeseriesexponentialBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_buffer_max(s : TimeseriesexponentialBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_buffer_to_string(s : TimeseriesexponentialBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_cursor_make(size : Int) -> TimeseriesexponentialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_cursor_len(s : TimeseriesexponentialCursor) -> Int { s.size }

pub fn timeseries_exponential_cursor_get(s : TimeseriesexponentialCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_cursor_set(s : TimeseriesexponentialCursor, i : Int, v : Double) -> TimeseriesexponentialCursor {
  let result = timeseries_exponential_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_cursor_sum(s : TimeseriesexponentialCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_exponential_cursor_mean(s : TimeseriesexponentialCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_exponential_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_exponential_cursor_scale(s : TimeseriesexponentialCursor, f : Double) -> TimeseriesexponentialCursor {
  let result = timeseries_exponential_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_exponential_cursor_add(a : TimeseriesexponentialCursor, b : TimeseriesexponentialCursor) -> TimeseriesexponentialCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_exponential_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_exponential_cursor_copy(s : TimeseriesexponentialCursor) -> TimeseriesexponentialCursor {
  let result = timeseries_exponential_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_exponential_cursor_fill(s : TimeseriesexponentialCursor, v : Double) -> TimeseriesexponentialCursor {
  let result = timeseries_exponential_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_cursor_min(s : TimeseriesexponentialCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_cursor_max(s : TimeseriesexponentialCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_cursor_to_string(s : TimeseriesexponentialCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_view_make(size : Int) -> TimeseriesexponentialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_view_len(s : TimeseriesexponentialView) -> Int { s.size }

pub fn timeseries_exponential_view_get(s : TimeseriesexponentialView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_view_set(s : TimeseriesexponentialView, i : Int, v : Double) -> TimeseriesexponentialView {
  let result = timeseries_exponential_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_view_sum(s : TimeseriesexponentialView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_exponential_view_mean(s : TimeseriesexponentialView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_exponential_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_exponential_view_scale(s : TimeseriesexponentialView, f : Double) -> TimeseriesexponentialView {
  let result = timeseries_exponential_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_exponential_view_add(a : TimeseriesexponentialView, b : TimeseriesexponentialView) -> TimeseriesexponentialView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_exponential_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_exponential_view_copy(s : TimeseriesexponentialView) -> TimeseriesexponentialView {
  let result = timeseries_exponential_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_exponential_view_fill(s : TimeseriesexponentialView, v : Double) -> TimeseriesexponentialView {
  let result = timeseries_exponential_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_view_min(s : TimeseriesexponentialView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_view_max(s : TimeseriesexponentialView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_view_to_string(s : TimeseriesexponentialView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_range_make(size : Int) -> TimeseriesexponentialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_range_len(s : TimeseriesexponentialRange) -> Int { s.size }

pub fn timeseries_exponential_range_get(s : TimeseriesexponentialRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_range_set(s : TimeseriesexponentialRange, i : Int, v : Double) -> TimeseriesexponentialRange {
  let result = timeseries_exponential_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_range_sum(s : TimeseriesexponentialRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_exponential_range_mean(s : TimeseriesexponentialRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_exponential_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_exponential_range_scale(s : TimeseriesexponentialRange, f : Double) -> TimeseriesexponentialRange {
  let result = timeseries_exponential_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_exponential_range_add(a : TimeseriesexponentialRange, b : TimeseriesexponentialRange) -> TimeseriesexponentialRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_exponential_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_exponential_range_copy(s : TimeseriesexponentialRange) -> TimeseriesexponentialRange {
  let result = timeseries_exponential_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_exponential_range_fill(s : TimeseriesexponentialRange, v : Double) -> TimeseriesexponentialRange {
  let result = timeseries_exponential_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_range_min(s : TimeseriesexponentialRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_range_max(s : TimeseriesexponentialRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_range_to_string(s : TimeseriesexponentialRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_slice_make(size : Int) -> TimeseriesexponentialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_slice_len(s : TimeseriesexponentialSlice) -> Int { s.size }

pub fn timeseries_exponential_slice_get(s : TimeseriesexponentialSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_slice_set(s : TimeseriesexponentialSlice, i : Int, v : Double) -> TimeseriesexponentialSlice {
  let result = timeseries_exponential_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_slice_sum(s : TimeseriesexponentialSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_exponential_slice_mean(s : TimeseriesexponentialSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_exponential_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_exponential_slice_scale(s : TimeseriesexponentialSlice, f : Double) -> TimeseriesexponentialSlice {
  let result = timeseries_exponential_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_exponential_slice_add(a : TimeseriesexponentialSlice, b : TimeseriesexponentialSlice) -> TimeseriesexponentialSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_exponential_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_exponential_slice_copy(s : TimeseriesexponentialSlice) -> TimeseriesexponentialSlice {
  let result = timeseries_exponential_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_exponential_slice_fill(s : TimeseriesexponentialSlice, v : Double) -> TimeseriesexponentialSlice {
  let result = timeseries_exponential_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_exponential_slice_min(s : TimeseriesexponentialSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_slice_max(s : TimeseriesexponentialSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_exponential_slice_to_string(s : TimeseriesexponentialSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn timeseries_exponential_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_exponential_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_exponential_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_exponential_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_exponential_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_exponential_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_exponential_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_exponential_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_exponential_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_exponential_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_exponential_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_exponential_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_exponential_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_exponential_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_exponential_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_exponential_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_exponential_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_exponential_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_exponential_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_exponential_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_exponential_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_exponential_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_exponential_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_exponential_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_exponential_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

