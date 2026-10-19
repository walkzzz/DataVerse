///===
/// extcore/timeseries_anomaly_lstm

pub(all) struct TimeseriesanomalylstmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_lstm_make_point(x : Double, y : Double) -> TimeseriesanomalylstmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_lstm_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalylstmPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_anomaly_lstm_point_x(pt : TimeseriesanomalylstmPoint) -> Double { pt.x }

pub fn timeseries_anomaly_lstm_point_y(pt : TimeseriesanomalylstmPoint) -> Double { pt.y }

pub fn timeseries_anomaly_lstm_point_z(pt : TimeseriesanomalylstmPoint) -> Double { pt.z }

pub fn timeseries_anomaly_lstm_point_label(pt : TimeseriesanomalylstmPoint) -> Int { pt.label }

pub fn timeseries_anomaly_lstm_point_dist(a : TimeseriesanomalylstmPoint, b : TimeseriesanomalylstmPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  timeseries_anomaly_lstm_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_anomaly_lstm_point_add(a : TimeseriesanomalylstmPoint, b : TimeseriesanomalylstmPoint) -> TimeseriesanomalylstmPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_anomaly_lstm_point_sub(a : TimeseriesanomalylstmPoint, b : TimeseriesanomalylstmPoint) -> TimeseriesanomalylstmPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_anomaly_lstm_point_scale(pt : TimeseriesanomalylstmPoint, s : Double) -> TimeseriesanomalylstmPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_anomaly_lstm_point_dot(a : TimeseriesanomalylstmPoint, b : TimeseriesanomalylstmPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_anomaly_lstm_point_cross(a : TimeseriesanomalylstmPoint, b : TimeseriesanomalylstmPoint) -> TimeseriesanomalylstmPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_anomaly_lstm_point_norm(pt : TimeseriesanomalylstmPoint) -> Double {
  timeseries_anomaly_lstm_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_anomaly_lstm_point_normalize(pt : TimeseriesanomalylstmPoint) -> TimeseriesanomalylstmPoint {
  let n = timeseries_anomaly_lstm_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_anomaly_lstm_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_anomaly_lstm_point_negate(pt : TimeseriesanomalylstmPoint) -> TimeseriesanomalylstmPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_anomaly_lstm_point_mid(a : TimeseriesanomalylstmPoint, b : TimeseriesanomalylstmPoint) -> TimeseriesanomalylstmPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_anomaly_lstm_point_lerp(a : TimeseriesanomalylstmPoint, b : TimeseriesanomalylstmPoint, t : Double) -> TimeseriesanomalylstmPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_anomaly_lstm_point_to_string(pt : TimeseriesanomalylstmPoint) -> String {
  "(" + timeseries_anomaly_lstm_dbl(pt.x) + ", " + timeseries_anomaly_lstm_dbl(pt.y) + ", " + timeseries_anomaly_lstm_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_lstm_make_series(vals : Array[Double], name : String) -> TimeseriesanomalylstmSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_anomaly_lstm_series_len(s : TimeseriesanomalylstmSeries) -> Int { s.vals.length() }

pub fn timeseries_anomaly_lstm_series_sum(s : TimeseriesanomalylstmSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_anomaly_lstm_series_mean(s : TimeseriesanomalylstmSeries) -> Double {
  let n = timeseries_anomaly_lstm_series_len(s)
  if n == 0 { 0.0 } else { timeseries_anomaly_lstm_series_sum(s) / n.to_double() }
}

pub fn timeseries_anomaly_lstm_series_min(s : TimeseriesanomalylstmSeries) -> Double {
  let n = timeseries_anomaly_lstm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_series_max(s : TimeseriesanomalylstmSeries) -> Double {
  let n = timeseries_anomaly_lstm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_series_range(s : TimeseriesanomalylstmSeries) -> Double {
  timeseries_anomaly_lstm_series_max(s) - timeseries_anomaly_lstm_series_min(s)
}

pub fn timeseries_anomaly_lstm_series_var(s : TimeseriesanomalylstmSeries) -> Double {
  let n = timeseries_anomaly_lstm_series_len(s)
  if n == 0 { 0.0 } else {
    let m = timeseries_anomaly_lstm_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_series_std(s : TimeseriesanomalylstmSeries) -> Double { timeseries_anomaly_lstm_sqrt(timeseries_anomaly_lstm_series_var(s)) }

pub fn timeseries_anomaly_lstm_series_median(s : TimeseriesanomalylstmSeries) -> Double {
  let n = timeseries_anomaly_lstm_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = timeseries_anomaly_lstm_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_anomaly_lstm_series_scale(s : TimeseriesanomalylstmSeries, f : Double) -> TimeseriesanomalylstmSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = timeseries_anomaly_lstm_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_anomaly_lstm_series_add(a : TimeseriesanomalylstmSeries, b : TimeseriesanomalylstmSeries) -> TimeseriesanomalylstmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = timeseries_anomaly_lstm_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_anomaly_lstm_series_sub(a : TimeseriesanomalylstmSeries, b : TimeseriesanomalylstmSeries) -> TimeseriesanomalylstmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = timeseries_anomaly_lstm_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_anomaly_lstm_series_normalize(s : TimeseriesanomalylstmSeries) -> TimeseriesanomalylstmSeries {
  let mn = timeseries_anomaly_lstm_series_min(s)
  let mx = timeseries_anomaly_lstm_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = timeseries_anomaly_lstm_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_anomaly_lstm_series_cumsum(s : TimeseriesanomalylstmSeries) -> TimeseriesanomalylstmSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = timeseries_anomaly_lstm_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_anomaly_lstm_series_to_string(s : TimeseriesanomalylstmSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + timeseries_anomaly_lstm_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalylstmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_lstm_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalylstmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_lstm_matrix_identity(n : Int) -> TimeseriesanomalylstmMatrix {
  let m = timeseries_anomaly_lstm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_anomaly_lstm_matrix_get(m : TimeseriesanomalylstmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_anomaly_lstm_matrix_transpose(m : TimeseriesanomalylstmMatrix) -> TimeseriesanomalylstmMatrix {
  let result = timeseries_anomaly_lstm_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_anomaly_lstm_matrix_add(a : TimeseriesanomalylstmMatrix, b : TimeseriesanomalylstmMatrix) -> TimeseriesanomalylstmMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_anomaly_lstm_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_anomaly_lstm_matrix_scale(m : TimeseriesanomalylstmMatrix, s : Double) -> TimeseriesanomalylstmMatrix {
  let result = timeseries_anomaly_lstm_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_anomaly_lstm_matrix_multiply(a : TimeseriesanomalylstmMatrix, b : TimeseriesanomalylstmMatrix) -> TimeseriesanomalylstmMatrix {
  if a.cols != b.rows { return timeseries_anomaly_lstm_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_anomaly_lstm_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_anomaly_lstm_matrix_trace(m : TimeseriesanomalylstmMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_anomaly_lstm_matrix_det(m : TimeseriesanomalylstmMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_anomaly_lstm_matrix_norm(m : TimeseriesanomalylstmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  timeseries_anomaly_lstm_sqrt(sum)
}

pub fn timeseries_anomaly_lstm_matrix_to_string(m : TimeseriesanomalylstmMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + timeseries_anomaly_lstm_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct TimeseriesanomalylstmVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_lstm_make_vector(comps : Array[Double]) -> TimeseriesanomalylstmVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_lstm_vector_zero(dim : Int) -> TimeseriesanomalylstmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_anomaly_lstm_vector_add(a : TimeseriesanomalylstmVector, b : TimeseriesanomalylstmVector) -> TimeseriesanomalylstmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = timeseries_anomaly_lstm_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_anomaly_lstm_vector_sub(a : TimeseriesanomalylstmVector, b : TimeseriesanomalylstmVector) -> TimeseriesanomalylstmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = timeseries_anomaly_lstm_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_anomaly_lstm_vector_scale(v : TimeseriesanomalylstmVector, s : Double) -> TimeseriesanomalylstmVector {
  let mut result = []
  for i in 0..<v.dim { result = timeseries_anomaly_lstm_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_anomaly_lstm_vector_dot(a : TimeseriesanomalylstmVector, b : TimeseriesanomalylstmVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_anomaly_lstm_vector_norm(v : TimeseriesanomalylstmVector) -> Double { timeseries_anomaly_lstm_sqrt(timeseries_anomaly_lstm_vector_dot(v, v)) }

pub fn timeseries_anomaly_lstm_vector_normalize(v : TimeseriesanomalylstmVector) -> TimeseriesanomalylstmVector {
  let n = timeseries_anomaly_lstm_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_anomaly_lstm_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_anomaly_lstm_vector_dist(a : TimeseriesanomalylstmVector, b : TimeseriesanomalylstmVector) -> Double {
  timeseries_anomaly_lstm_vector_norm(timeseries_anomaly_lstm_vector_sub(a, b))
}

pub fn timeseries_anomaly_lstm_vector_to_string(v : TimeseriesanomalylstmVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + timeseries_anomaly_lstm_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_anomaly_lstm_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = timeseries_anomaly_lstm_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_std(data : Array[Double]) -> Double { timeseries_anomaly_lstm_sqrt(timeseries_anomaly_lstm_var(data)) }

pub fn timeseries_anomaly_lstm_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = timeseries_anomaly_lstm_mean(a); let mb = timeseries_anomaly_lstm_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = timeseries_anomaly_lstm_std(a); let sb = timeseries_anomaly_lstm_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { timeseries_anomaly_lstm_cov(a, b) / (sa * sb) }
}

pub fn timeseries_anomaly_lstm_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = timeseries_anomaly_lstm_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_anomaly_lstm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  timeseries_anomaly_lstm_sqrt(timeseries_anomaly_lstm_mse(pred, labels))
}

pub fn timeseries_anomaly_lstm_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + timeseries_anomaly_lstm_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = timeseries_anomaly_lstm_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn timeseries_anomaly_lstm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn timeseries_anomaly_lstm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn timeseries_anomaly_lstm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = timeseries_anomaly_lstm_precision(pred, labels, pos); let r = timeseries_anomaly_lstm_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn timeseries_anomaly_lstm_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn timeseries_anomaly_lstm_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = timeseries_anomaly_lstm_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn timeseries_anomaly_lstm_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn timeseries_anomaly_lstm_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn timeseries_anomaly_lstm_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = timeseries_anomaly_lstm_gcd(a, b)
    (a / g) * b
  }
}

pub fn timeseries_anomaly_lstm_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn timeseries_anomaly_lstm_fibonacci(n : Int) -> Int {
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

pub fn timeseries_anomaly_lstm_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = timeseries_anomaly_lstm_min(data); let mx = timeseries_anomaly_lstm_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn timeseries_anomaly_lstm_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = timeseries_anomaly_lstm_mean(data); let sd = timeseries_anomaly_lstm_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn timeseries_anomaly_lstm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn timeseries_anomaly_lstm_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn timeseries_anomaly_lstm_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn timeseries_anomaly_lstm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn timeseries_anomaly_lstm_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn timeseries_anomaly_lstm_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn timeseries_anomaly_lstm_dbl(x : Double) -> String {
  let i = if x >= 0.0 { timeseries_anomaly_lstm_int(x) } else { -timeseries_anomaly_lstm_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { timeseries_anomaly_lstm_int(f * 1000000.0) } else { timeseries_anomaly_lstm_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn timeseries_anomaly_lstm_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn timeseries_anomaly_lstm_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct TimeseriesanomalylstmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_frame_make(size : Int) -> TimeseriesanomalylstmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_frame_len(s : TimeseriesanomalylstmFrame) -> Int { s.size }

pub fn timeseries_anomaly_lstm_frame_get(s : TimeseriesanomalylstmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_frame_set(s : TimeseriesanomalylstmFrame, i : Int, v : Double) -> TimeseriesanomalylstmFrame {
  let result = timeseries_anomaly_lstm_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_frame_sum(s : TimeseriesanomalylstmFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lstm_frame_mean(s : TimeseriesanomalylstmFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lstm_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lstm_frame_scale(s : TimeseriesanomalylstmFrame, f : Double) -> TimeseriesanomalylstmFrame {
  let result = timeseries_anomaly_lstm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lstm_frame_add(a : TimeseriesanomalylstmFrame, b : TimeseriesanomalylstmFrame) -> TimeseriesanomalylstmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lstm_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_frame_copy(s : TimeseriesanomalylstmFrame) -> TimeseriesanomalylstmFrame {
  let result = timeseries_anomaly_lstm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_frame_fill(s : TimeseriesanomalylstmFrame, v : Double) -> TimeseriesanomalylstmFrame {
  let result = timeseries_anomaly_lstm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_frame_min(s : TimeseriesanomalylstmFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_frame_max(s : TimeseriesanomalylstmFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_frame_to_string(s : TimeseriesanomalylstmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_table_make(size : Int) -> TimeseriesanomalylstmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_table_len(s : TimeseriesanomalylstmTable) -> Int { s.size }

pub fn timeseries_anomaly_lstm_table_get(s : TimeseriesanomalylstmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_table_set(s : TimeseriesanomalylstmTable, i : Int, v : Double) -> TimeseriesanomalylstmTable {
  let result = timeseries_anomaly_lstm_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_table_sum(s : TimeseriesanomalylstmTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lstm_table_mean(s : TimeseriesanomalylstmTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lstm_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lstm_table_scale(s : TimeseriesanomalylstmTable, f : Double) -> TimeseriesanomalylstmTable {
  let result = timeseries_anomaly_lstm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lstm_table_add(a : TimeseriesanomalylstmTable, b : TimeseriesanomalylstmTable) -> TimeseriesanomalylstmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lstm_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_table_copy(s : TimeseriesanomalylstmTable) -> TimeseriesanomalylstmTable {
  let result = timeseries_anomaly_lstm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_table_fill(s : TimeseriesanomalylstmTable, v : Double) -> TimeseriesanomalylstmTable {
  let result = timeseries_anomaly_lstm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_table_min(s : TimeseriesanomalylstmTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_table_max(s : TimeseriesanomalylstmTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_table_to_string(s : TimeseriesanomalylstmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_graphn_make(size : Int) -> TimeseriesanomalylstmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_graphn_len(s : TimeseriesanomalylstmGraphN) -> Int { s.size }

pub fn timeseries_anomaly_lstm_graphn_get(s : TimeseriesanomalylstmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_graphn_set(s : TimeseriesanomalylstmGraphN, i : Int, v : Double) -> TimeseriesanomalylstmGraphN {
  let result = timeseries_anomaly_lstm_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_graphn_sum(s : TimeseriesanomalylstmGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lstm_graphn_mean(s : TimeseriesanomalylstmGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lstm_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lstm_graphn_scale(s : TimeseriesanomalylstmGraphN, f : Double) -> TimeseriesanomalylstmGraphN {
  let result = timeseries_anomaly_lstm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lstm_graphn_add(a : TimeseriesanomalylstmGraphN, b : TimeseriesanomalylstmGraphN) -> TimeseriesanomalylstmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lstm_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_graphn_copy(s : TimeseriesanomalylstmGraphN) -> TimeseriesanomalylstmGraphN {
  let result = timeseries_anomaly_lstm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_graphn_fill(s : TimeseriesanomalylstmGraphN, v : Double) -> TimeseriesanomalylstmGraphN {
  let result = timeseries_anomaly_lstm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_graphn_min(s : TimeseriesanomalylstmGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_graphn_max(s : TimeseriesanomalylstmGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_graphn_to_string(s : TimeseriesanomalylstmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_node_make(size : Int) -> TimeseriesanomalylstmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_node_len(s : TimeseriesanomalylstmNode) -> Int { s.size }

pub fn timeseries_anomaly_lstm_node_get(s : TimeseriesanomalylstmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_node_set(s : TimeseriesanomalylstmNode, i : Int, v : Double) -> TimeseriesanomalylstmNode {
  let result = timeseries_anomaly_lstm_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_node_sum(s : TimeseriesanomalylstmNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lstm_node_mean(s : TimeseriesanomalylstmNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lstm_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lstm_node_scale(s : TimeseriesanomalylstmNode, f : Double) -> TimeseriesanomalylstmNode {
  let result = timeseries_anomaly_lstm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lstm_node_add(a : TimeseriesanomalylstmNode, b : TimeseriesanomalylstmNode) -> TimeseriesanomalylstmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lstm_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_node_copy(s : TimeseriesanomalylstmNode) -> TimeseriesanomalylstmNode {
  let result = timeseries_anomaly_lstm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_node_fill(s : TimeseriesanomalylstmNode, v : Double) -> TimeseriesanomalylstmNode {
  let result = timeseries_anomaly_lstm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_node_min(s : TimeseriesanomalylstmNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_node_max(s : TimeseriesanomalylstmNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_node_to_string(s : TimeseriesanomalylstmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_edge_make(size : Int) -> TimeseriesanomalylstmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_edge_len(s : TimeseriesanomalylstmEdge) -> Int { s.size }

pub fn timeseries_anomaly_lstm_edge_get(s : TimeseriesanomalylstmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_edge_set(s : TimeseriesanomalylstmEdge, i : Int, v : Double) -> TimeseriesanomalylstmEdge {
  let result = timeseries_anomaly_lstm_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_edge_sum(s : TimeseriesanomalylstmEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lstm_edge_mean(s : TimeseriesanomalylstmEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lstm_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lstm_edge_scale(s : TimeseriesanomalylstmEdge, f : Double) -> TimeseriesanomalylstmEdge {
  let result = timeseries_anomaly_lstm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lstm_edge_add(a : TimeseriesanomalylstmEdge, b : TimeseriesanomalylstmEdge) -> TimeseriesanomalylstmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lstm_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_edge_copy(s : TimeseriesanomalylstmEdge) -> TimeseriesanomalylstmEdge {
  let result = timeseries_anomaly_lstm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_edge_fill(s : TimeseriesanomalylstmEdge, v : Double) -> TimeseriesanomalylstmEdge {
  let result = timeseries_anomaly_lstm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_edge_min(s : TimeseriesanomalylstmEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_edge_max(s : TimeseriesanomalylstmEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_edge_to_string(s : TimeseriesanomalylstmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_path_make(size : Int) -> TimeseriesanomalylstmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_path_len(s : TimeseriesanomalylstmPath) -> Int { s.size }

pub fn timeseries_anomaly_lstm_path_get(s : TimeseriesanomalylstmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_path_set(s : TimeseriesanomalylstmPath, i : Int, v : Double) -> TimeseriesanomalylstmPath {
  let result = timeseries_anomaly_lstm_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_path_sum(s : TimeseriesanomalylstmPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lstm_path_mean(s : TimeseriesanomalylstmPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lstm_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lstm_path_scale(s : TimeseriesanomalylstmPath, f : Double) -> TimeseriesanomalylstmPath {
  let result = timeseries_anomaly_lstm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lstm_path_add(a : TimeseriesanomalylstmPath, b : TimeseriesanomalylstmPath) -> TimeseriesanomalylstmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lstm_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_path_copy(s : TimeseriesanomalylstmPath) -> TimeseriesanomalylstmPath {
  let result = timeseries_anomaly_lstm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_path_fill(s : TimeseriesanomalylstmPath, v : Double) -> TimeseriesanomalylstmPath {
  let result = timeseries_anomaly_lstm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_path_min(s : TimeseriesanomalylstmPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_path_max(s : TimeseriesanomalylstmPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_path_to_string(s : TimeseriesanomalylstmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_cluster_make(size : Int) -> TimeseriesanomalylstmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_cluster_len(s : TimeseriesanomalylstmCluster) -> Int { s.size }

pub fn timeseries_anomaly_lstm_cluster_get(s : TimeseriesanomalylstmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_cluster_set(s : TimeseriesanomalylstmCluster, i : Int, v : Double) -> TimeseriesanomalylstmCluster {
  let result = timeseries_anomaly_lstm_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_cluster_sum(s : TimeseriesanomalylstmCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lstm_cluster_mean(s : TimeseriesanomalylstmCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lstm_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lstm_cluster_scale(s : TimeseriesanomalylstmCluster, f : Double) -> TimeseriesanomalylstmCluster {
  let result = timeseries_anomaly_lstm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lstm_cluster_add(a : TimeseriesanomalylstmCluster, b : TimeseriesanomalylstmCluster) -> TimeseriesanomalylstmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lstm_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_cluster_copy(s : TimeseriesanomalylstmCluster) -> TimeseriesanomalylstmCluster {
  let result = timeseries_anomaly_lstm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_cluster_fill(s : TimeseriesanomalylstmCluster, v : Double) -> TimeseriesanomalylstmCluster {
  let result = timeseries_anomaly_lstm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_cluster_min(s : TimeseriesanomalylstmCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_cluster_max(s : TimeseriesanomalylstmCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_cluster_to_string(s : TimeseriesanomalylstmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_model_make(size : Int) -> TimeseriesanomalylstmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_model_len(s : TimeseriesanomalylstmModel) -> Int { s.size }

pub fn timeseries_anomaly_lstm_model_get(s : TimeseriesanomalylstmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_model_set(s : TimeseriesanomalylstmModel, i : Int, v : Double) -> TimeseriesanomalylstmModel {
  let result = timeseries_anomaly_lstm_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_model_sum(s : TimeseriesanomalylstmModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lstm_model_mean(s : TimeseriesanomalylstmModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lstm_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lstm_model_scale(s : TimeseriesanomalylstmModel, f : Double) -> TimeseriesanomalylstmModel {
  let result = timeseries_anomaly_lstm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lstm_model_add(a : TimeseriesanomalylstmModel, b : TimeseriesanomalylstmModel) -> TimeseriesanomalylstmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lstm_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_model_copy(s : TimeseriesanomalylstmModel) -> TimeseriesanomalylstmModel {
  let result = timeseries_anomaly_lstm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_model_fill(s : TimeseriesanomalylstmModel, v : Double) -> TimeseriesanomalylstmModel {
  let result = timeseries_anomaly_lstm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_model_min(s : TimeseriesanomalylstmModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_model_max(s : TimeseriesanomalylstmModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_model_to_string(s : TimeseriesanomalylstmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_layer_make(size : Int) -> TimeseriesanomalylstmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_layer_len(s : TimeseriesanomalylstmLayer) -> Int { s.size }

pub fn timeseries_anomaly_lstm_layer_get(s : TimeseriesanomalylstmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_layer_set(s : TimeseriesanomalylstmLayer, i : Int, v : Double) -> TimeseriesanomalylstmLayer {
  let result = timeseries_anomaly_lstm_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_layer_sum(s : TimeseriesanomalylstmLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lstm_layer_mean(s : TimeseriesanomalylstmLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lstm_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lstm_layer_scale(s : TimeseriesanomalylstmLayer, f : Double) -> TimeseriesanomalylstmLayer {
  let result = timeseries_anomaly_lstm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lstm_layer_add(a : TimeseriesanomalylstmLayer, b : TimeseriesanomalylstmLayer) -> TimeseriesanomalylstmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lstm_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_layer_copy(s : TimeseriesanomalylstmLayer) -> TimeseriesanomalylstmLayer {
  let result = timeseries_anomaly_lstm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_layer_fill(s : TimeseriesanomalylstmLayer, v : Double) -> TimeseriesanomalylstmLayer {
  let result = timeseries_anomaly_lstm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_layer_min(s : TimeseriesanomalylstmLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_layer_max(s : TimeseriesanomalylstmLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_layer_to_string(s : TimeseriesanomalylstmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_buffer_make(size : Int) -> TimeseriesanomalylstmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_buffer_len(s : TimeseriesanomalylstmBuffer) -> Int { s.size }

pub fn timeseries_anomaly_lstm_buffer_get(s : TimeseriesanomalylstmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_buffer_set(s : TimeseriesanomalylstmBuffer, i : Int, v : Double) -> TimeseriesanomalylstmBuffer {
  let result = timeseries_anomaly_lstm_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_buffer_sum(s : TimeseriesanomalylstmBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lstm_buffer_mean(s : TimeseriesanomalylstmBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lstm_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lstm_buffer_scale(s : TimeseriesanomalylstmBuffer, f : Double) -> TimeseriesanomalylstmBuffer {
  let result = timeseries_anomaly_lstm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lstm_buffer_add(a : TimeseriesanomalylstmBuffer, b : TimeseriesanomalylstmBuffer) -> TimeseriesanomalylstmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lstm_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_buffer_copy(s : TimeseriesanomalylstmBuffer) -> TimeseriesanomalylstmBuffer {
  let result = timeseries_anomaly_lstm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_buffer_fill(s : TimeseriesanomalylstmBuffer, v : Double) -> TimeseriesanomalylstmBuffer {
  let result = timeseries_anomaly_lstm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_buffer_min(s : TimeseriesanomalylstmBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_buffer_max(s : TimeseriesanomalylstmBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_buffer_to_string(s : TimeseriesanomalylstmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_cursor_make(size : Int) -> TimeseriesanomalylstmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_cursor_len(s : TimeseriesanomalylstmCursor) -> Int { s.size }

pub fn timeseries_anomaly_lstm_cursor_get(s : TimeseriesanomalylstmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_cursor_set(s : TimeseriesanomalylstmCursor, i : Int, v : Double) -> TimeseriesanomalylstmCursor {
  let result = timeseries_anomaly_lstm_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_cursor_sum(s : TimeseriesanomalylstmCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lstm_cursor_mean(s : TimeseriesanomalylstmCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lstm_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lstm_cursor_scale(s : TimeseriesanomalylstmCursor, f : Double) -> TimeseriesanomalylstmCursor {
  let result = timeseries_anomaly_lstm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lstm_cursor_add(a : TimeseriesanomalylstmCursor, b : TimeseriesanomalylstmCursor) -> TimeseriesanomalylstmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lstm_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_cursor_copy(s : TimeseriesanomalylstmCursor) -> TimeseriesanomalylstmCursor {
  let result = timeseries_anomaly_lstm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_cursor_fill(s : TimeseriesanomalylstmCursor, v : Double) -> TimeseriesanomalylstmCursor {
  let result = timeseries_anomaly_lstm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_cursor_min(s : TimeseriesanomalylstmCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_cursor_max(s : TimeseriesanomalylstmCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_cursor_to_string(s : TimeseriesanomalylstmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_view_make(size : Int) -> TimeseriesanomalylstmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_view_len(s : TimeseriesanomalylstmView) -> Int { s.size }

pub fn timeseries_anomaly_lstm_view_get(s : TimeseriesanomalylstmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_view_set(s : TimeseriesanomalylstmView, i : Int, v : Double) -> TimeseriesanomalylstmView {
  let result = timeseries_anomaly_lstm_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_view_sum(s : TimeseriesanomalylstmView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lstm_view_mean(s : TimeseriesanomalylstmView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lstm_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lstm_view_scale(s : TimeseriesanomalylstmView, f : Double) -> TimeseriesanomalylstmView {
  let result = timeseries_anomaly_lstm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lstm_view_add(a : TimeseriesanomalylstmView, b : TimeseriesanomalylstmView) -> TimeseriesanomalylstmView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lstm_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_view_copy(s : TimeseriesanomalylstmView) -> TimeseriesanomalylstmView {
  let result = timeseries_anomaly_lstm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_view_fill(s : TimeseriesanomalylstmView, v : Double) -> TimeseriesanomalylstmView {
  let result = timeseries_anomaly_lstm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_view_min(s : TimeseriesanomalylstmView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_view_max(s : TimeseriesanomalylstmView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_view_to_string(s : TimeseriesanomalylstmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_range_make(size : Int) -> TimeseriesanomalylstmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_range_len(s : TimeseriesanomalylstmRange) -> Int { s.size }

pub fn timeseries_anomaly_lstm_range_get(s : TimeseriesanomalylstmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_range_set(s : TimeseriesanomalylstmRange, i : Int, v : Double) -> TimeseriesanomalylstmRange {
  let result = timeseries_anomaly_lstm_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_range_sum(s : TimeseriesanomalylstmRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lstm_range_mean(s : TimeseriesanomalylstmRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lstm_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lstm_range_scale(s : TimeseriesanomalylstmRange, f : Double) -> TimeseriesanomalylstmRange {
  let result = timeseries_anomaly_lstm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lstm_range_add(a : TimeseriesanomalylstmRange, b : TimeseriesanomalylstmRange) -> TimeseriesanomalylstmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lstm_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_range_copy(s : TimeseriesanomalylstmRange) -> TimeseriesanomalylstmRange {
  let result = timeseries_anomaly_lstm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_range_fill(s : TimeseriesanomalylstmRange, v : Double) -> TimeseriesanomalylstmRange {
  let result = timeseries_anomaly_lstm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_range_min(s : TimeseriesanomalylstmRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_range_max(s : TimeseriesanomalylstmRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_range_to_string(s : TimeseriesanomalylstmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_slice_make(size : Int) -> TimeseriesanomalylstmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_slice_len(s : TimeseriesanomalylstmSlice) -> Int { s.size }

pub fn timeseries_anomaly_lstm_slice_get(s : TimeseriesanomalylstmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_slice_set(s : TimeseriesanomalylstmSlice, i : Int, v : Double) -> TimeseriesanomalylstmSlice {
  let result = timeseries_anomaly_lstm_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_slice_sum(s : TimeseriesanomalylstmSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lstm_slice_mean(s : TimeseriesanomalylstmSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lstm_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lstm_slice_scale(s : TimeseriesanomalylstmSlice, f : Double) -> TimeseriesanomalylstmSlice {
  let result = timeseries_anomaly_lstm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lstm_slice_add(a : TimeseriesanomalylstmSlice, b : TimeseriesanomalylstmSlice) -> TimeseriesanomalylstmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lstm_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_slice_copy(s : TimeseriesanomalylstmSlice) -> TimeseriesanomalylstmSlice {
  let result = timeseries_anomaly_lstm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lstm_slice_fill(s : TimeseriesanomalylstmSlice, v : Double) -> TimeseriesanomalylstmSlice {
  let result = timeseries_anomaly_lstm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lstm_slice_min(s : TimeseriesanomalylstmSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_slice_max(s : TimeseriesanomalylstmSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lstm_slice_to_string(s : TimeseriesanomalylstmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn timeseries_anomaly_lstm_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_lstm_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

