///===
/// extcore/timeseries_forecast_drift

pub(all) struct TimeseriesforecastdriftPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_drift_make_point(x : Double, y : Double) -> TimeseriesforecastdriftPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_drift_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastdriftPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_forecast_drift_point_x(pt : TimeseriesforecastdriftPoint) -> Double { pt.x }

pub fn timeseries_forecast_drift_point_y(pt : TimeseriesforecastdriftPoint) -> Double { pt.y }

pub fn timeseries_forecast_drift_point_z(pt : TimeseriesforecastdriftPoint) -> Double { pt.z }

pub fn timeseries_forecast_drift_point_label(pt : TimeseriesforecastdriftPoint) -> Int { pt.label }

pub fn timeseries_forecast_drift_point_dist(a : TimeseriesforecastdriftPoint, b : TimeseriesforecastdriftPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  timeseries_forecast_drift_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_forecast_drift_point_add(a : TimeseriesforecastdriftPoint, b : TimeseriesforecastdriftPoint) -> TimeseriesforecastdriftPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_forecast_drift_point_sub(a : TimeseriesforecastdriftPoint, b : TimeseriesforecastdriftPoint) -> TimeseriesforecastdriftPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_forecast_drift_point_scale(pt : TimeseriesforecastdriftPoint, s : Double) -> TimeseriesforecastdriftPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_forecast_drift_point_dot(a : TimeseriesforecastdriftPoint, b : TimeseriesforecastdriftPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_forecast_drift_point_cross(a : TimeseriesforecastdriftPoint, b : TimeseriesforecastdriftPoint) -> TimeseriesforecastdriftPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_forecast_drift_point_norm(pt : TimeseriesforecastdriftPoint) -> Double {
  timeseries_forecast_drift_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_forecast_drift_point_normalize(pt : TimeseriesforecastdriftPoint) -> TimeseriesforecastdriftPoint {
  let n = timeseries_forecast_drift_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_forecast_drift_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_forecast_drift_point_negate(pt : TimeseriesforecastdriftPoint) -> TimeseriesforecastdriftPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_forecast_drift_point_mid(a : TimeseriesforecastdriftPoint, b : TimeseriesforecastdriftPoint) -> TimeseriesforecastdriftPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_forecast_drift_point_lerp(a : TimeseriesforecastdriftPoint, b : TimeseriesforecastdriftPoint, t : Double) -> TimeseriesforecastdriftPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_forecast_drift_point_to_string(pt : TimeseriesforecastdriftPoint) -> String {
  "(" + timeseries_forecast_drift_dbl(pt.x) + ", " + timeseries_forecast_drift_dbl(pt.y) + ", " + timeseries_forecast_drift_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_drift_make_series(vals : Array[Double], name : String) -> TimeseriesforecastdriftSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_forecast_drift_series_len(s : TimeseriesforecastdriftSeries) -> Int { s.vals.length() }

pub fn timeseries_forecast_drift_series_sum(s : TimeseriesforecastdriftSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_forecast_drift_series_mean(s : TimeseriesforecastdriftSeries) -> Double {
  let n = timeseries_forecast_drift_series_len(s)
  if n == 0 { 0.0 } else { timeseries_forecast_drift_series_sum(s) / n.to_double() }
}

pub fn timeseries_forecast_drift_series_min(s : TimeseriesforecastdriftSeries) -> Double {
  let n = timeseries_forecast_drift_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_series_max(s : TimeseriesforecastdriftSeries) -> Double {
  let n = timeseries_forecast_drift_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_series_range(s : TimeseriesforecastdriftSeries) -> Double {
  timeseries_forecast_drift_series_max(s) - timeseries_forecast_drift_series_min(s)
}

pub fn timeseries_forecast_drift_series_var(s : TimeseriesforecastdriftSeries) -> Double {
  let n = timeseries_forecast_drift_series_len(s)
  if n == 0 { 0.0 } else {
    let m = timeseries_forecast_drift_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn timeseries_forecast_drift_series_std(s : TimeseriesforecastdriftSeries) -> Double { timeseries_forecast_drift_sqrt(timeseries_forecast_drift_series_var(s)) }

pub fn timeseries_forecast_drift_series_median(s : TimeseriesforecastdriftSeries) -> Double {
  let n = timeseries_forecast_drift_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = timeseries_forecast_drift_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_forecast_drift_series_scale(s : TimeseriesforecastdriftSeries, f : Double) -> TimeseriesforecastdriftSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = timeseries_forecast_drift_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_forecast_drift_series_add(a : TimeseriesforecastdriftSeries, b : TimeseriesforecastdriftSeries) -> TimeseriesforecastdriftSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = timeseries_forecast_drift_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_drift_series_sub(a : TimeseriesforecastdriftSeries, b : TimeseriesforecastdriftSeries) -> TimeseriesforecastdriftSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = timeseries_forecast_drift_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_drift_series_normalize(s : TimeseriesforecastdriftSeries) -> TimeseriesforecastdriftSeries {
  let mn = timeseries_forecast_drift_series_min(s)
  let mx = timeseries_forecast_drift_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = timeseries_forecast_drift_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_forecast_drift_series_cumsum(s : TimeseriesforecastdriftSeries) -> TimeseriesforecastdriftSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = timeseries_forecast_drift_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_forecast_drift_series_to_string(s : TimeseriesforecastdriftSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + timeseries_forecast_drift_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastdriftMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_drift_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastdriftMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_drift_matrix_identity(n : Int) -> TimeseriesforecastdriftMatrix {
  let m = timeseries_forecast_drift_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_forecast_drift_matrix_get(m : TimeseriesforecastdriftMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_forecast_drift_matrix_transpose(m : TimeseriesforecastdriftMatrix) -> TimeseriesforecastdriftMatrix {
  let result = timeseries_forecast_drift_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_forecast_drift_matrix_add(a : TimeseriesforecastdriftMatrix, b : TimeseriesforecastdriftMatrix) -> TimeseriesforecastdriftMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_forecast_drift_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_forecast_drift_matrix_scale(m : TimeseriesforecastdriftMatrix, s : Double) -> TimeseriesforecastdriftMatrix {
  let result = timeseries_forecast_drift_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_forecast_drift_matrix_multiply(a : TimeseriesforecastdriftMatrix, b : TimeseriesforecastdriftMatrix) -> TimeseriesforecastdriftMatrix {
  if a.cols != b.rows { return timeseries_forecast_drift_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_forecast_drift_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_forecast_drift_matrix_trace(m : TimeseriesforecastdriftMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_forecast_drift_matrix_det(m : TimeseriesforecastdriftMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_forecast_drift_matrix_norm(m : TimeseriesforecastdriftMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  timeseries_forecast_drift_sqrt(sum)
}

pub fn timeseries_forecast_drift_matrix_to_string(m : TimeseriesforecastdriftMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + timeseries_forecast_drift_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct TimeseriesforecastdriftVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_drift_make_vector(comps : Array[Double]) -> TimeseriesforecastdriftVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_drift_vector_zero(dim : Int) -> TimeseriesforecastdriftVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_forecast_drift_vector_add(a : TimeseriesforecastdriftVector, b : TimeseriesforecastdriftVector) -> TimeseriesforecastdriftVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = timeseries_forecast_drift_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_forecast_drift_vector_sub(a : TimeseriesforecastdriftVector, b : TimeseriesforecastdriftVector) -> TimeseriesforecastdriftVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = timeseries_forecast_drift_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_forecast_drift_vector_scale(v : TimeseriesforecastdriftVector, s : Double) -> TimeseriesforecastdriftVector {
  let mut result = []
  for i in 0..<v.dim { result = timeseries_forecast_drift_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_forecast_drift_vector_dot(a : TimeseriesforecastdriftVector, b : TimeseriesforecastdriftVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_forecast_drift_vector_norm(v : TimeseriesforecastdriftVector) -> Double { timeseries_forecast_drift_sqrt(timeseries_forecast_drift_vector_dot(v, v)) }

pub fn timeseries_forecast_drift_vector_normalize(v : TimeseriesforecastdriftVector) -> TimeseriesforecastdriftVector {
  let n = timeseries_forecast_drift_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_forecast_drift_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_forecast_drift_vector_dist(a : TimeseriesforecastdriftVector, b : TimeseriesforecastdriftVector) -> Double {
  timeseries_forecast_drift_vector_norm(timeseries_forecast_drift_vector_sub(a, b))
}

pub fn timeseries_forecast_drift_vector_to_string(v : TimeseriesforecastdriftVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + timeseries_forecast_drift_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_drift_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_drift_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = timeseries_forecast_drift_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_drift_std(data : Array[Double]) -> Double { timeseries_forecast_drift_sqrt(timeseries_forecast_drift_var(data)) }

pub fn timeseries_forecast_drift_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = timeseries_forecast_drift_mean(a); let mb = timeseries_forecast_drift_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_drift_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = timeseries_forecast_drift_std(a); let sb = timeseries_forecast_drift_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { timeseries_forecast_drift_cov(a, b) / (sa * sb) }
}

pub fn timeseries_forecast_drift_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = timeseries_forecast_drift_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_forecast_drift_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn timeseries_forecast_drift_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_drift_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  timeseries_forecast_drift_sqrt(timeseries_forecast_drift_mse(pred, labels))
}

pub fn timeseries_forecast_drift_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + timeseries_forecast_drift_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_drift_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = timeseries_forecast_drift_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn timeseries_forecast_drift_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn timeseries_forecast_drift_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn timeseries_forecast_drift_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = timeseries_forecast_drift_precision(pred, labels, pos); let r = timeseries_forecast_drift_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn timeseries_forecast_drift_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn timeseries_forecast_drift_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = timeseries_forecast_drift_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn timeseries_forecast_drift_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn timeseries_forecast_drift_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn timeseries_forecast_drift_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = timeseries_forecast_drift_gcd(a, b)
    (a / g) * b
  }
}

pub fn timeseries_forecast_drift_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn timeseries_forecast_drift_fibonacci(n : Int) -> Int {
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

pub fn timeseries_forecast_drift_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = timeseries_forecast_drift_min(data); let mx = timeseries_forecast_drift_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn timeseries_forecast_drift_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = timeseries_forecast_drift_mean(data); let sd = timeseries_forecast_drift_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn timeseries_forecast_drift_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn timeseries_forecast_drift_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn timeseries_forecast_drift_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn timeseries_forecast_drift_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn timeseries_forecast_drift_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn timeseries_forecast_drift_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn timeseries_forecast_drift_dbl(x : Double) -> String {
  let i = if x >= 0.0 { timeseries_forecast_drift_int(x) } else { -timeseries_forecast_drift_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { timeseries_forecast_drift_int(f * 1000000.0) } else { timeseries_forecast_drift_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn timeseries_forecast_drift_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn timeseries_forecast_drift_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct TimeseriesforecastdriftFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_frame_make(size : Int) -> TimeseriesforecastdriftFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_frame_len(s : TimeseriesforecastdriftFrame) -> Int { s.size }

pub fn timeseries_forecast_drift_frame_get(s : TimeseriesforecastdriftFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_frame_set(s : TimeseriesforecastdriftFrame, i : Int, v : Double) -> TimeseriesforecastdriftFrame {
  let result = timeseries_forecast_drift_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_frame_sum(s : TimeseriesforecastdriftFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_drift_frame_mean(s : TimeseriesforecastdriftFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_drift_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_drift_frame_scale(s : TimeseriesforecastdriftFrame, f : Double) -> TimeseriesforecastdriftFrame {
  let result = timeseries_forecast_drift_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_drift_frame_add(a : TimeseriesforecastdriftFrame, b : TimeseriesforecastdriftFrame) -> TimeseriesforecastdriftFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_drift_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_drift_frame_copy(s : TimeseriesforecastdriftFrame) -> TimeseriesforecastdriftFrame {
  let result = timeseries_forecast_drift_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_drift_frame_fill(s : TimeseriesforecastdriftFrame, v : Double) -> TimeseriesforecastdriftFrame {
  let result = timeseries_forecast_drift_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_frame_min(s : TimeseriesforecastdriftFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_frame_max(s : TimeseriesforecastdriftFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_frame_to_string(s : TimeseriesforecastdriftFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_table_make(size : Int) -> TimeseriesforecastdriftTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_table_len(s : TimeseriesforecastdriftTable) -> Int { s.size }

pub fn timeseries_forecast_drift_table_get(s : TimeseriesforecastdriftTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_table_set(s : TimeseriesforecastdriftTable, i : Int, v : Double) -> TimeseriesforecastdriftTable {
  let result = timeseries_forecast_drift_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_table_sum(s : TimeseriesforecastdriftTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_drift_table_mean(s : TimeseriesforecastdriftTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_drift_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_drift_table_scale(s : TimeseriesforecastdriftTable, f : Double) -> TimeseriesforecastdriftTable {
  let result = timeseries_forecast_drift_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_drift_table_add(a : TimeseriesforecastdriftTable, b : TimeseriesforecastdriftTable) -> TimeseriesforecastdriftTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_drift_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_drift_table_copy(s : TimeseriesforecastdriftTable) -> TimeseriesforecastdriftTable {
  let result = timeseries_forecast_drift_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_drift_table_fill(s : TimeseriesforecastdriftTable, v : Double) -> TimeseriesforecastdriftTable {
  let result = timeseries_forecast_drift_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_table_min(s : TimeseriesforecastdriftTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_table_max(s : TimeseriesforecastdriftTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_table_to_string(s : TimeseriesforecastdriftTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_graphn_make(size : Int) -> TimeseriesforecastdriftGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_graphn_len(s : TimeseriesforecastdriftGraphN) -> Int { s.size }

pub fn timeseries_forecast_drift_graphn_get(s : TimeseriesforecastdriftGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_graphn_set(s : TimeseriesforecastdriftGraphN, i : Int, v : Double) -> TimeseriesforecastdriftGraphN {
  let result = timeseries_forecast_drift_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_graphn_sum(s : TimeseriesforecastdriftGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_drift_graphn_mean(s : TimeseriesforecastdriftGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_drift_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_drift_graphn_scale(s : TimeseriesforecastdriftGraphN, f : Double) -> TimeseriesforecastdriftGraphN {
  let result = timeseries_forecast_drift_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_drift_graphn_add(a : TimeseriesforecastdriftGraphN, b : TimeseriesforecastdriftGraphN) -> TimeseriesforecastdriftGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_drift_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_drift_graphn_copy(s : TimeseriesforecastdriftGraphN) -> TimeseriesforecastdriftGraphN {
  let result = timeseries_forecast_drift_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_drift_graphn_fill(s : TimeseriesforecastdriftGraphN, v : Double) -> TimeseriesforecastdriftGraphN {
  let result = timeseries_forecast_drift_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_graphn_min(s : TimeseriesforecastdriftGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_graphn_max(s : TimeseriesforecastdriftGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_graphn_to_string(s : TimeseriesforecastdriftGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_node_make(size : Int) -> TimeseriesforecastdriftNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_node_len(s : TimeseriesforecastdriftNode) -> Int { s.size }

pub fn timeseries_forecast_drift_node_get(s : TimeseriesforecastdriftNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_node_set(s : TimeseriesforecastdriftNode, i : Int, v : Double) -> TimeseriesforecastdriftNode {
  let result = timeseries_forecast_drift_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_node_sum(s : TimeseriesforecastdriftNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_drift_node_mean(s : TimeseriesforecastdriftNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_drift_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_drift_node_scale(s : TimeseriesforecastdriftNode, f : Double) -> TimeseriesforecastdriftNode {
  let result = timeseries_forecast_drift_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_drift_node_add(a : TimeseriesforecastdriftNode, b : TimeseriesforecastdriftNode) -> TimeseriesforecastdriftNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_drift_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_drift_node_copy(s : TimeseriesforecastdriftNode) -> TimeseriesforecastdriftNode {
  let result = timeseries_forecast_drift_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_drift_node_fill(s : TimeseriesforecastdriftNode, v : Double) -> TimeseriesforecastdriftNode {
  let result = timeseries_forecast_drift_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_node_min(s : TimeseriesforecastdriftNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_node_max(s : TimeseriesforecastdriftNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_node_to_string(s : TimeseriesforecastdriftNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_edge_make(size : Int) -> TimeseriesforecastdriftEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_edge_len(s : TimeseriesforecastdriftEdge) -> Int { s.size }

pub fn timeseries_forecast_drift_edge_get(s : TimeseriesforecastdriftEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_edge_set(s : TimeseriesforecastdriftEdge, i : Int, v : Double) -> TimeseriesforecastdriftEdge {
  let result = timeseries_forecast_drift_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_edge_sum(s : TimeseriesforecastdriftEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_drift_edge_mean(s : TimeseriesforecastdriftEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_drift_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_drift_edge_scale(s : TimeseriesforecastdriftEdge, f : Double) -> TimeseriesforecastdriftEdge {
  let result = timeseries_forecast_drift_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_drift_edge_add(a : TimeseriesforecastdriftEdge, b : TimeseriesforecastdriftEdge) -> TimeseriesforecastdriftEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_drift_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_drift_edge_copy(s : TimeseriesforecastdriftEdge) -> TimeseriesforecastdriftEdge {
  let result = timeseries_forecast_drift_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_drift_edge_fill(s : TimeseriesforecastdriftEdge, v : Double) -> TimeseriesforecastdriftEdge {
  let result = timeseries_forecast_drift_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_edge_min(s : TimeseriesforecastdriftEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_edge_max(s : TimeseriesforecastdriftEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_edge_to_string(s : TimeseriesforecastdriftEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_path_make(size : Int) -> TimeseriesforecastdriftPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_path_len(s : TimeseriesforecastdriftPath) -> Int { s.size }

pub fn timeseries_forecast_drift_path_get(s : TimeseriesforecastdriftPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_path_set(s : TimeseriesforecastdriftPath, i : Int, v : Double) -> TimeseriesforecastdriftPath {
  let result = timeseries_forecast_drift_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_path_sum(s : TimeseriesforecastdriftPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_drift_path_mean(s : TimeseriesforecastdriftPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_drift_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_drift_path_scale(s : TimeseriesforecastdriftPath, f : Double) -> TimeseriesforecastdriftPath {
  let result = timeseries_forecast_drift_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_drift_path_add(a : TimeseriesforecastdriftPath, b : TimeseriesforecastdriftPath) -> TimeseriesforecastdriftPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_drift_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_drift_path_copy(s : TimeseriesforecastdriftPath) -> TimeseriesforecastdriftPath {
  let result = timeseries_forecast_drift_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_drift_path_fill(s : TimeseriesforecastdriftPath, v : Double) -> TimeseriesforecastdriftPath {
  let result = timeseries_forecast_drift_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_path_min(s : TimeseriesforecastdriftPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_path_max(s : TimeseriesforecastdriftPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_path_to_string(s : TimeseriesforecastdriftPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_cluster_make(size : Int) -> TimeseriesforecastdriftCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_cluster_len(s : TimeseriesforecastdriftCluster) -> Int { s.size }

pub fn timeseries_forecast_drift_cluster_get(s : TimeseriesforecastdriftCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_cluster_set(s : TimeseriesforecastdriftCluster, i : Int, v : Double) -> TimeseriesforecastdriftCluster {
  let result = timeseries_forecast_drift_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_cluster_sum(s : TimeseriesforecastdriftCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_drift_cluster_mean(s : TimeseriesforecastdriftCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_drift_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_drift_cluster_scale(s : TimeseriesforecastdriftCluster, f : Double) -> TimeseriesforecastdriftCluster {
  let result = timeseries_forecast_drift_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_drift_cluster_add(a : TimeseriesforecastdriftCluster, b : TimeseriesforecastdriftCluster) -> TimeseriesforecastdriftCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_drift_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_drift_cluster_copy(s : TimeseriesforecastdriftCluster) -> TimeseriesforecastdriftCluster {
  let result = timeseries_forecast_drift_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_drift_cluster_fill(s : TimeseriesforecastdriftCluster, v : Double) -> TimeseriesforecastdriftCluster {
  let result = timeseries_forecast_drift_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_cluster_min(s : TimeseriesforecastdriftCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_cluster_max(s : TimeseriesforecastdriftCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_cluster_to_string(s : TimeseriesforecastdriftCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_model_make(size : Int) -> TimeseriesforecastdriftModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_model_len(s : TimeseriesforecastdriftModel) -> Int { s.size }

pub fn timeseries_forecast_drift_model_get(s : TimeseriesforecastdriftModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_model_set(s : TimeseriesforecastdriftModel, i : Int, v : Double) -> TimeseriesforecastdriftModel {
  let result = timeseries_forecast_drift_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_model_sum(s : TimeseriesforecastdriftModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_drift_model_mean(s : TimeseriesforecastdriftModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_drift_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_drift_model_scale(s : TimeseriesforecastdriftModel, f : Double) -> TimeseriesforecastdriftModel {
  let result = timeseries_forecast_drift_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_drift_model_add(a : TimeseriesforecastdriftModel, b : TimeseriesforecastdriftModel) -> TimeseriesforecastdriftModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_drift_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_drift_model_copy(s : TimeseriesforecastdriftModel) -> TimeseriesforecastdriftModel {
  let result = timeseries_forecast_drift_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_drift_model_fill(s : TimeseriesforecastdriftModel, v : Double) -> TimeseriesforecastdriftModel {
  let result = timeseries_forecast_drift_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_model_min(s : TimeseriesforecastdriftModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_model_max(s : TimeseriesforecastdriftModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_model_to_string(s : TimeseriesforecastdriftModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_layer_make(size : Int) -> TimeseriesforecastdriftLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_layer_len(s : TimeseriesforecastdriftLayer) -> Int { s.size }

pub fn timeseries_forecast_drift_layer_get(s : TimeseriesforecastdriftLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_layer_set(s : TimeseriesforecastdriftLayer, i : Int, v : Double) -> TimeseriesforecastdriftLayer {
  let result = timeseries_forecast_drift_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_layer_sum(s : TimeseriesforecastdriftLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_drift_layer_mean(s : TimeseriesforecastdriftLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_drift_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_drift_layer_scale(s : TimeseriesforecastdriftLayer, f : Double) -> TimeseriesforecastdriftLayer {
  let result = timeseries_forecast_drift_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_drift_layer_add(a : TimeseriesforecastdriftLayer, b : TimeseriesforecastdriftLayer) -> TimeseriesforecastdriftLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_drift_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_drift_layer_copy(s : TimeseriesforecastdriftLayer) -> TimeseriesforecastdriftLayer {
  let result = timeseries_forecast_drift_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_drift_layer_fill(s : TimeseriesforecastdriftLayer, v : Double) -> TimeseriesforecastdriftLayer {
  let result = timeseries_forecast_drift_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_layer_min(s : TimeseriesforecastdriftLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_layer_max(s : TimeseriesforecastdriftLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_layer_to_string(s : TimeseriesforecastdriftLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_buffer_make(size : Int) -> TimeseriesforecastdriftBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_buffer_len(s : TimeseriesforecastdriftBuffer) -> Int { s.size }

pub fn timeseries_forecast_drift_buffer_get(s : TimeseriesforecastdriftBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_buffer_set(s : TimeseriesforecastdriftBuffer, i : Int, v : Double) -> TimeseriesforecastdriftBuffer {
  let result = timeseries_forecast_drift_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_buffer_sum(s : TimeseriesforecastdriftBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_drift_buffer_mean(s : TimeseriesforecastdriftBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_drift_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_drift_buffer_scale(s : TimeseriesforecastdriftBuffer, f : Double) -> TimeseriesforecastdriftBuffer {
  let result = timeseries_forecast_drift_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_drift_buffer_add(a : TimeseriesforecastdriftBuffer, b : TimeseriesforecastdriftBuffer) -> TimeseriesforecastdriftBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_drift_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_drift_buffer_copy(s : TimeseriesforecastdriftBuffer) -> TimeseriesforecastdriftBuffer {
  let result = timeseries_forecast_drift_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_drift_buffer_fill(s : TimeseriesforecastdriftBuffer, v : Double) -> TimeseriesforecastdriftBuffer {
  let result = timeseries_forecast_drift_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_buffer_min(s : TimeseriesforecastdriftBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_buffer_max(s : TimeseriesforecastdriftBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_buffer_to_string(s : TimeseriesforecastdriftBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_cursor_make(size : Int) -> TimeseriesforecastdriftCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_cursor_len(s : TimeseriesforecastdriftCursor) -> Int { s.size }

pub fn timeseries_forecast_drift_cursor_get(s : TimeseriesforecastdriftCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_cursor_set(s : TimeseriesforecastdriftCursor, i : Int, v : Double) -> TimeseriesforecastdriftCursor {
  let result = timeseries_forecast_drift_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_cursor_sum(s : TimeseriesforecastdriftCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_drift_cursor_mean(s : TimeseriesforecastdriftCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_drift_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_drift_cursor_scale(s : TimeseriesforecastdriftCursor, f : Double) -> TimeseriesforecastdriftCursor {
  let result = timeseries_forecast_drift_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_drift_cursor_add(a : TimeseriesforecastdriftCursor, b : TimeseriesforecastdriftCursor) -> TimeseriesforecastdriftCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_drift_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_drift_cursor_copy(s : TimeseriesforecastdriftCursor) -> TimeseriesforecastdriftCursor {
  let result = timeseries_forecast_drift_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_drift_cursor_fill(s : TimeseriesforecastdriftCursor, v : Double) -> TimeseriesforecastdriftCursor {
  let result = timeseries_forecast_drift_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_cursor_min(s : TimeseriesforecastdriftCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_cursor_max(s : TimeseriesforecastdriftCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_cursor_to_string(s : TimeseriesforecastdriftCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_view_make(size : Int) -> TimeseriesforecastdriftView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_view_len(s : TimeseriesforecastdriftView) -> Int { s.size }

pub fn timeseries_forecast_drift_view_get(s : TimeseriesforecastdriftView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_view_set(s : TimeseriesforecastdriftView, i : Int, v : Double) -> TimeseriesforecastdriftView {
  let result = timeseries_forecast_drift_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_view_sum(s : TimeseriesforecastdriftView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_drift_view_mean(s : TimeseriesforecastdriftView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_drift_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_drift_view_scale(s : TimeseriesforecastdriftView, f : Double) -> TimeseriesforecastdriftView {
  let result = timeseries_forecast_drift_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_drift_view_add(a : TimeseriesforecastdriftView, b : TimeseriesforecastdriftView) -> TimeseriesforecastdriftView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_drift_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_drift_view_copy(s : TimeseriesforecastdriftView) -> TimeseriesforecastdriftView {
  let result = timeseries_forecast_drift_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_drift_view_fill(s : TimeseriesforecastdriftView, v : Double) -> TimeseriesforecastdriftView {
  let result = timeseries_forecast_drift_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_view_min(s : TimeseriesforecastdriftView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_view_max(s : TimeseriesforecastdriftView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_view_to_string(s : TimeseriesforecastdriftView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_range_make(size : Int) -> TimeseriesforecastdriftRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_range_len(s : TimeseriesforecastdriftRange) -> Int { s.size }

pub fn timeseries_forecast_drift_range_get(s : TimeseriesforecastdriftRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_range_set(s : TimeseriesforecastdriftRange, i : Int, v : Double) -> TimeseriesforecastdriftRange {
  let result = timeseries_forecast_drift_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_range_sum(s : TimeseriesforecastdriftRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_drift_range_mean(s : TimeseriesforecastdriftRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_drift_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_drift_range_scale(s : TimeseriesforecastdriftRange, f : Double) -> TimeseriesforecastdriftRange {
  let result = timeseries_forecast_drift_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_drift_range_add(a : TimeseriesforecastdriftRange, b : TimeseriesforecastdriftRange) -> TimeseriesforecastdriftRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_drift_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_drift_range_copy(s : TimeseriesforecastdriftRange) -> TimeseriesforecastdriftRange {
  let result = timeseries_forecast_drift_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_drift_range_fill(s : TimeseriesforecastdriftRange, v : Double) -> TimeseriesforecastdriftRange {
  let result = timeseries_forecast_drift_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_range_min(s : TimeseriesforecastdriftRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_range_max(s : TimeseriesforecastdriftRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_range_to_string(s : TimeseriesforecastdriftRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_slice_make(size : Int) -> TimeseriesforecastdriftSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_slice_len(s : TimeseriesforecastdriftSlice) -> Int { s.size }

pub fn timeseries_forecast_drift_slice_get(s : TimeseriesforecastdriftSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_slice_set(s : TimeseriesforecastdriftSlice, i : Int, v : Double) -> TimeseriesforecastdriftSlice {
  let result = timeseries_forecast_drift_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_slice_sum(s : TimeseriesforecastdriftSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_drift_slice_mean(s : TimeseriesforecastdriftSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_drift_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_drift_slice_scale(s : TimeseriesforecastdriftSlice, f : Double) -> TimeseriesforecastdriftSlice {
  let result = timeseries_forecast_drift_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_drift_slice_add(a : TimeseriesforecastdriftSlice, b : TimeseriesforecastdriftSlice) -> TimeseriesforecastdriftSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_drift_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_drift_slice_copy(s : TimeseriesforecastdriftSlice) -> TimeseriesforecastdriftSlice {
  let result = timeseries_forecast_drift_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_drift_slice_fill(s : TimeseriesforecastdriftSlice, v : Double) -> TimeseriesforecastdriftSlice {
  let result = timeseries_forecast_drift_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_slice_min(s : TimeseriesforecastdriftSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_slice_max(s : TimeseriesforecastdriftSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_drift_slice_to_string(s : TimeseriesforecastdriftSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn timeseries_forecast_drift_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_drift_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_drift_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_drift_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_drift_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_drift_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_drift_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_drift_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_drift_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_drift_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_drift_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_drift_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_drift_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_drift_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_drift_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_drift_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_drift_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_drift_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_drift_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_drift_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_drift_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_drift_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_drift_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_drift_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_drift_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

