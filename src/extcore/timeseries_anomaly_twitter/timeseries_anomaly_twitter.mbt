///===
/// extcore/timeseries_anomaly_twitter

pub(all) struct TimeseriesanomalytwitterPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_twitter_make_point(x : Double, y : Double) -> TimeseriesanomalytwitterPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_twitter_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalytwitterPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_anomaly_twitter_point_x(pt : TimeseriesanomalytwitterPoint) -> Double { pt.x }

pub fn timeseries_anomaly_twitter_point_y(pt : TimeseriesanomalytwitterPoint) -> Double { pt.y }

pub fn timeseries_anomaly_twitter_point_z(pt : TimeseriesanomalytwitterPoint) -> Double { pt.z }

pub fn timeseries_anomaly_twitter_point_label(pt : TimeseriesanomalytwitterPoint) -> Int { pt.label }

pub fn timeseries_anomaly_twitter_point_dist(a : TimeseriesanomalytwitterPoint, b : TimeseriesanomalytwitterPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  timeseries_anomaly_twitter_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_anomaly_twitter_point_add(a : TimeseriesanomalytwitterPoint, b : TimeseriesanomalytwitterPoint) -> TimeseriesanomalytwitterPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_anomaly_twitter_point_sub(a : TimeseriesanomalytwitterPoint, b : TimeseriesanomalytwitterPoint) -> TimeseriesanomalytwitterPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_anomaly_twitter_point_scale(pt : TimeseriesanomalytwitterPoint, s : Double) -> TimeseriesanomalytwitterPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_anomaly_twitter_point_dot(a : TimeseriesanomalytwitterPoint, b : TimeseriesanomalytwitterPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_anomaly_twitter_point_cross(a : TimeseriesanomalytwitterPoint, b : TimeseriesanomalytwitterPoint) -> TimeseriesanomalytwitterPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_anomaly_twitter_point_norm(pt : TimeseriesanomalytwitterPoint) -> Double {
  timeseries_anomaly_twitter_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_anomaly_twitter_point_normalize(pt : TimeseriesanomalytwitterPoint) -> TimeseriesanomalytwitterPoint {
  let n = timeseries_anomaly_twitter_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_anomaly_twitter_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_anomaly_twitter_point_negate(pt : TimeseriesanomalytwitterPoint) -> TimeseriesanomalytwitterPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_anomaly_twitter_point_mid(a : TimeseriesanomalytwitterPoint, b : TimeseriesanomalytwitterPoint) -> TimeseriesanomalytwitterPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_anomaly_twitter_point_lerp(a : TimeseriesanomalytwitterPoint, b : TimeseriesanomalytwitterPoint, t : Double) -> TimeseriesanomalytwitterPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_anomaly_twitter_point_to_string(pt : TimeseriesanomalytwitterPoint) -> String {
  "(" + timeseries_anomaly_twitter_dbl(pt.x) + ", " + timeseries_anomaly_twitter_dbl(pt.y) + ", " + timeseries_anomaly_twitter_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_twitter_make_series(vals : Array[Double], name : String) -> TimeseriesanomalytwitterSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_anomaly_twitter_series_len(s : TimeseriesanomalytwitterSeries) -> Int { s.vals.length() }

pub fn timeseries_anomaly_twitter_series_sum(s : TimeseriesanomalytwitterSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_anomaly_twitter_series_mean(s : TimeseriesanomalytwitterSeries) -> Double {
  let n = timeseries_anomaly_twitter_series_len(s)
  if n == 0 { 0.0 } else { timeseries_anomaly_twitter_series_sum(s) / n.to_double() }
}

pub fn timeseries_anomaly_twitter_series_min(s : TimeseriesanomalytwitterSeries) -> Double {
  let n = timeseries_anomaly_twitter_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_series_max(s : TimeseriesanomalytwitterSeries) -> Double {
  let n = timeseries_anomaly_twitter_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_series_range(s : TimeseriesanomalytwitterSeries) -> Double {
  timeseries_anomaly_twitter_series_max(s) - timeseries_anomaly_twitter_series_min(s)
}

pub fn timeseries_anomaly_twitter_series_var(s : TimeseriesanomalytwitterSeries) -> Double {
  let n = timeseries_anomaly_twitter_series_len(s)
  if n == 0 { 0.0 } else {
    let m = timeseries_anomaly_twitter_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_series_std(s : TimeseriesanomalytwitterSeries) -> Double { timeseries_anomaly_twitter_sqrt(timeseries_anomaly_twitter_series_var(s)) }

pub fn timeseries_anomaly_twitter_series_median(s : TimeseriesanomalytwitterSeries) -> Double {
  let n = timeseries_anomaly_twitter_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = timeseries_anomaly_twitter_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_anomaly_twitter_series_scale(s : TimeseriesanomalytwitterSeries, f : Double) -> TimeseriesanomalytwitterSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = timeseries_anomaly_twitter_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_anomaly_twitter_series_add(a : TimeseriesanomalytwitterSeries, b : TimeseriesanomalytwitterSeries) -> TimeseriesanomalytwitterSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = timeseries_anomaly_twitter_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_anomaly_twitter_series_sub(a : TimeseriesanomalytwitterSeries, b : TimeseriesanomalytwitterSeries) -> TimeseriesanomalytwitterSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = timeseries_anomaly_twitter_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_anomaly_twitter_series_normalize(s : TimeseriesanomalytwitterSeries) -> TimeseriesanomalytwitterSeries {
  let mn = timeseries_anomaly_twitter_series_min(s)
  let mx = timeseries_anomaly_twitter_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = timeseries_anomaly_twitter_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_anomaly_twitter_series_cumsum(s : TimeseriesanomalytwitterSeries) -> TimeseriesanomalytwitterSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = timeseries_anomaly_twitter_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_anomaly_twitter_series_to_string(s : TimeseriesanomalytwitterSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + timeseries_anomaly_twitter_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalytwitterMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_twitter_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalytwitterMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_twitter_matrix_identity(n : Int) -> TimeseriesanomalytwitterMatrix {
  let m = timeseries_anomaly_twitter_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_anomaly_twitter_matrix_get(m : TimeseriesanomalytwitterMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_anomaly_twitter_matrix_transpose(m : TimeseriesanomalytwitterMatrix) -> TimeseriesanomalytwitterMatrix {
  let result = timeseries_anomaly_twitter_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_anomaly_twitter_matrix_add(a : TimeseriesanomalytwitterMatrix, b : TimeseriesanomalytwitterMatrix) -> TimeseriesanomalytwitterMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_anomaly_twitter_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_anomaly_twitter_matrix_scale(m : TimeseriesanomalytwitterMatrix, s : Double) -> TimeseriesanomalytwitterMatrix {
  let result = timeseries_anomaly_twitter_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_anomaly_twitter_matrix_multiply(a : TimeseriesanomalytwitterMatrix, b : TimeseriesanomalytwitterMatrix) -> TimeseriesanomalytwitterMatrix {
  if a.cols != b.rows { return timeseries_anomaly_twitter_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_anomaly_twitter_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_anomaly_twitter_matrix_trace(m : TimeseriesanomalytwitterMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_anomaly_twitter_matrix_det(m : TimeseriesanomalytwitterMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_anomaly_twitter_matrix_norm(m : TimeseriesanomalytwitterMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  timeseries_anomaly_twitter_sqrt(sum)
}

pub fn timeseries_anomaly_twitter_matrix_to_string(m : TimeseriesanomalytwitterMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + timeseries_anomaly_twitter_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct TimeseriesanomalytwitterVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_twitter_make_vector(comps : Array[Double]) -> TimeseriesanomalytwitterVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_twitter_vector_zero(dim : Int) -> TimeseriesanomalytwitterVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_anomaly_twitter_vector_add(a : TimeseriesanomalytwitterVector, b : TimeseriesanomalytwitterVector) -> TimeseriesanomalytwitterVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = timeseries_anomaly_twitter_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_anomaly_twitter_vector_sub(a : TimeseriesanomalytwitterVector, b : TimeseriesanomalytwitterVector) -> TimeseriesanomalytwitterVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = timeseries_anomaly_twitter_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_anomaly_twitter_vector_scale(v : TimeseriesanomalytwitterVector, s : Double) -> TimeseriesanomalytwitterVector {
  let mut result = []
  for i in 0..<v.dim { result = timeseries_anomaly_twitter_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_anomaly_twitter_vector_dot(a : TimeseriesanomalytwitterVector, b : TimeseriesanomalytwitterVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_anomaly_twitter_vector_norm(v : TimeseriesanomalytwitterVector) -> Double { timeseries_anomaly_twitter_sqrt(timeseries_anomaly_twitter_vector_dot(v, v)) }

pub fn timeseries_anomaly_twitter_vector_normalize(v : TimeseriesanomalytwitterVector) -> TimeseriesanomalytwitterVector {
  let n = timeseries_anomaly_twitter_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_anomaly_twitter_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_anomaly_twitter_vector_dist(a : TimeseriesanomalytwitterVector, b : TimeseriesanomalytwitterVector) -> Double {
  timeseries_anomaly_twitter_vector_norm(timeseries_anomaly_twitter_vector_sub(a, b))
}

pub fn timeseries_anomaly_twitter_vector_to_string(v : TimeseriesanomalytwitterVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + timeseries_anomaly_twitter_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_anomaly_twitter_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = timeseries_anomaly_twitter_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_std(data : Array[Double]) -> Double { timeseries_anomaly_twitter_sqrt(timeseries_anomaly_twitter_var(data)) }

pub fn timeseries_anomaly_twitter_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = timeseries_anomaly_twitter_mean(a); let mb = timeseries_anomaly_twitter_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = timeseries_anomaly_twitter_std(a); let sb = timeseries_anomaly_twitter_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { timeseries_anomaly_twitter_cov(a, b) / (sa * sb) }
}

pub fn timeseries_anomaly_twitter_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = timeseries_anomaly_twitter_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_anomaly_twitter_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  timeseries_anomaly_twitter_sqrt(timeseries_anomaly_twitter_mse(pred, labels))
}

pub fn timeseries_anomaly_twitter_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + timeseries_anomaly_twitter_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = timeseries_anomaly_twitter_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn timeseries_anomaly_twitter_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn timeseries_anomaly_twitter_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn timeseries_anomaly_twitter_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = timeseries_anomaly_twitter_precision(pred, labels, pos); let r = timeseries_anomaly_twitter_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn timeseries_anomaly_twitter_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn timeseries_anomaly_twitter_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = timeseries_anomaly_twitter_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn timeseries_anomaly_twitter_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn timeseries_anomaly_twitter_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn timeseries_anomaly_twitter_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = timeseries_anomaly_twitter_gcd(a, b)
    (a / g) * b
  }
}

pub fn timeseries_anomaly_twitter_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn timeseries_anomaly_twitter_fibonacci(n : Int) -> Int {
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

pub fn timeseries_anomaly_twitter_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = timeseries_anomaly_twitter_min(data); let mx = timeseries_anomaly_twitter_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn timeseries_anomaly_twitter_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = timeseries_anomaly_twitter_mean(data); let sd = timeseries_anomaly_twitter_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn timeseries_anomaly_twitter_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn timeseries_anomaly_twitter_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn timeseries_anomaly_twitter_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn timeseries_anomaly_twitter_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn timeseries_anomaly_twitter_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn timeseries_anomaly_twitter_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn timeseries_anomaly_twitter_dbl(x : Double) -> String {
  let i = if x >= 0.0 { timeseries_anomaly_twitter_int(x) } else { -timeseries_anomaly_twitter_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { timeseries_anomaly_twitter_int(f * 1000000.0) } else { timeseries_anomaly_twitter_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn timeseries_anomaly_twitter_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn timeseries_anomaly_twitter_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct TimeseriesanomalytwitterFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_frame_make(size : Int) -> TimeseriesanomalytwitterFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_frame_len(s : TimeseriesanomalytwitterFrame) -> Int { s.size }

pub fn timeseries_anomaly_twitter_frame_get(s : TimeseriesanomalytwitterFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_frame_set(s : TimeseriesanomalytwitterFrame, i : Int, v : Double) -> TimeseriesanomalytwitterFrame {
  let result = timeseries_anomaly_twitter_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_frame_sum(s : TimeseriesanomalytwitterFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_twitter_frame_mean(s : TimeseriesanomalytwitterFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_twitter_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_twitter_frame_scale(s : TimeseriesanomalytwitterFrame, f : Double) -> TimeseriesanomalytwitterFrame {
  let result = timeseries_anomaly_twitter_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_twitter_frame_add(a : TimeseriesanomalytwitterFrame, b : TimeseriesanomalytwitterFrame) -> TimeseriesanomalytwitterFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_twitter_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_frame_copy(s : TimeseriesanomalytwitterFrame) -> TimeseriesanomalytwitterFrame {
  let result = timeseries_anomaly_twitter_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_frame_fill(s : TimeseriesanomalytwitterFrame, v : Double) -> TimeseriesanomalytwitterFrame {
  let result = timeseries_anomaly_twitter_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_frame_min(s : TimeseriesanomalytwitterFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_frame_max(s : TimeseriesanomalytwitterFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_frame_to_string(s : TimeseriesanomalytwitterFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_table_make(size : Int) -> TimeseriesanomalytwitterTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_table_len(s : TimeseriesanomalytwitterTable) -> Int { s.size }

pub fn timeseries_anomaly_twitter_table_get(s : TimeseriesanomalytwitterTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_table_set(s : TimeseriesanomalytwitterTable, i : Int, v : Double) -> TimeseriesanomalytwitterTable {
  let result = timeseries_anomaly_twitter_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_table_sum(s : TimeseriesanomalytwitterTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_twitter_table_mean(s : TimeseriesanomalytwitterTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_twitter_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_twitter_table_scale(s : TimeseriesanomalytwitterTable, f : Double) -> TimeseriesanomalytwitterTable {
  let result = timeseries_anomaly_twitter_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_twitter_table_add(a : TimeseriesanomalytwitterTable, b : TimeseriesanomalytwitterTable) -> TimeseriesanomalytwitterTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_twitter_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_table_copy(s : TimeseriesanomalytwitterTable) -> TimeseriesanomalytwitterTable {
  let result = timeseries_anomaly_twitter_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_table_fill(s : TimeseriesanomalytwitterTable, v : Double) -> TimeseriesanomalytwitterTable {
  let result = timeseries_anomaly_twitter_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_table_min(s : TimeseriesanomalytwitterTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_table_max(s : TimeseriesanomalytwitterTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_table_to_string(s : TimeseriesanomalytwitterTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_graphn_make(size : Int) -> TimeseriesanomalytwitterGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_graphn_len(s : TimeseriesanomalytwitterGraphN) -> Int { s.size }

pub fn timeseries_anomaly_twitter_graphn_get(s : TimeseriesanomalytwitterGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_graphn_set(s : TimeseriesanomalytwitterGraphN, i : Int, v : Double) -> TimeseriesanomalytwitterGraphN {
  let result = timeseries_anomaly_twitter_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_graphn_sum(s : TimeseriesanomalytwitterGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_twitter_graphn_mean(s : TimeseriesanomalytwitterGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_twitter_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_twitter_graphn_scale(s : TimeseriesanomalytwitterGraphN, f : Double) -> TimeseriesanomalytwitterGraphN {
  let result = timeseries_anomaly_twitter_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_twitter_graphn_add(a : TimeseriesanomalytwitterGraphN, b : TimeseriesanomalytwitterGraphN) -> TimeseriesanomalytwitterGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_twitter_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_graphn_copy(s : TimeseriesanomalytwitterGraphN) -> TimeseriesanomalytwitterGraphN {
  let result = timeseries_anomaly_twitter_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_graphn_fill(s : TimeseriesanomalytwitterGraphN, v : Double) -> TimeseriesanomalytwitterGraphN {
  let result = timeseries_anomaly_twitter_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_graphn_min(s : TimeseriesanomalytwitterGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_graphn_max(s : TimeseriesanomalytwitterGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_graphn_to_string(s : TimeseriesanomalytwitterGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_node_make(size : Int) -> TimeseriesanomalytwitterNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_node_len(s : TimeseriesanomalytwitterNode) -> Int { s.size }

pub fn timeseries_anomaly_twitter_node_get(s : TimeseriesanomalytwitterNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_node_set(s : TimeseriesanomalytwitterNode, i : Int, v : Double) -> TimeseriesanomalytwitterNode {
  let result = timeseries_anomaly_twitter_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_node_sum(s : TimeseriesanomalytwitterNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_twitter_node_mean(s : TimeseriesanomalytwitterNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_twitter_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_twitter_node_scale(s : TimeseriesanomalytwitterNode, f : Double) -> TimeseriesanomalytwitterNode {
  let result = timeseries_anomaly_twitter_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_twitter_node_add(a : TimeseriesanomalytwitterNode, b : TimeseriesanomalytwitterNode) -> TimeseriesanomalytwitterNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_twitter_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_node_copy(s : TimeseriesanomalytwitterNode) -> TimeseriesanomalytwitterNode {
  let result = timeseries_anomaly_twitter_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_node_fill(s : TimeseriesanomalytwitterNode, v : Double) -> TimeseriesanomalytwitterNode {
  let result = timeseries_anomaly_twitter_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_node_min(s : TimeseriesanomalytwitterNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_node_max(s : TimeseriesanomalytwitterNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_node_to_string(s : TimeseriesanomalytwitterNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_edge_make(size : Int) -> TimeseriesanomalytwitterEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_edge_len(s : TimeseriesanomalytwitterEdge) -> Int { s.size }

pub fn timeseries_anomaly_twitter_edge_get(s : TimeseriesanomalytwitterEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_edge_set(s : TimeseriesanomalytwitterEdge, i : Int, v : Double) -> TimeseriesanomalytwitterEdge {
  let result = timeseries_anomaly_twitter_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_edge_sum(s : TimeseriesanomalytwitterEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_twitter_edge_mean(s : TimeseriesanomalytwitterEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_twitter_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_twitter_edge_scale(s : TimeseriesanomalytwitterEdge, f : Double) -> TimeseriesanomalytwitterEdge {
  let result = timeseries_anomaly_twitter_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_twitter_edge_add(a : TimeseriesanomalytwitterEdge, b : TimeseriesanomalytwitterEdge) -> TimeseriesanomalytwitterEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_twitter_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_edge_copy(s : TimeseriesanomalytwitterEdge) -> TimeseriesanomalytwitterEdge {
  let result = timeseries_anomaly_twitter_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_edge_fill(s : TimeseriesanomalytwitterEdge, v : Double) -> TimeseriesanomalytwitterEdge {
  let result = timeseries_anomaly_twitter_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_edge_min(s : TimeseriesanomalytwitterEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_edge_max(s : TimeseriesanomalytwitterEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_edge_to_string(s : TimeseriesanomalytwitterEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_path_make(size : Int) -> TimeseriesanomalytwitterPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_path_len(s : TimeseriesanomalytwitterPath) -> Int { s.size }

pub fn timeseries_anomaly_twitter_path_get(s : TimeseriesanomalytwitterPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_path_set(s : TimeseriesanomalytwitterPath, i : Int, v : Double) -> TimeseriesanomalytwitterPath {
  let result = timeseries_anomaly_twitter_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_path_sum(s : TimeseriesanomalytwitterPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_twitter_path_mean(s : TimeseriesanomalytwitterPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_twitter_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_twitter_path_scale(s : TimeseriesanomalytwitterPath, f : Double) -> TimeseriesanomalytwitterPath {
  let result = timeseries_anomaly_twitter_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_twitter_path_add(a : TimeseriesanomalytwitterPath, b : TimeseriesanomalytwitterPath) -> TimeseriesanomalytwitterPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_twitter_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_path_copy(s : TimeseriesanomalytwitterPath) -> TimeseriesanomalytwitterPath {
  let result = timeseries_anomaly_twitter_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_path_fill(s : TimeseriesanomalytwitterPath, v : Double) -> TimeseriesanomalytwitterPath {
  let result = timeseries_anomaly_twitter_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_path_min(s : TimeseriesanomalytwitterPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_path_max(s : TimeseriesanomalytwitterPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_path_to_string(s : TimeseriesanomalytwitterPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_cluster_make(size : Int) -> TimeseriesanomalytwitterCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_cluster_len(s : TimeseriesanomalytwitterCluster) -> Int { s.size }

pub fn timeseries_anomaly_twitter_cluster_get(s : TimeseriesanomalytwitterCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_cluster_set(s : TimeseriesanomalytwitterCluster, i : Int, v : Double) -> TimeseriesanomalytwitterCluster {
  let result = timeseries_anomaly_twitter_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_cluster_sum(s : TimeseriesanomalytwitterCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_twitter_cluster_mean(s : TimeseriesanomalytwitterCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_twitter_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_twitter_cluster_scale(s : TimeseriesanomalytwitterCluster, f : Double) -> TimeseriesanomalytwitterCluster {
  let result = timeseries_anomaly_twitter_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_twitter_cluster_add(a : TimeseriesanomalytwitterCluster, b : TimeseriesanomalytwitterCluster) -> TimeseriesanomalytwitterCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_twitter_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_cluster_copy(s : TimeseriesanomalytwitterCluster) -> TimeseriesanomalytwitterCluster {
  let result = timeseries_anomaly_twitter_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_cluster_fill(s : TimeseriesanomalytwitterCluster, v : Double) -> TimeseriesanomalytwitterCluster {
  let result = timeseries_anomaly_twitter_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_cluster_min(s : TimeseriesanomalytwitterCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_cluster_max(s : TimeseriesanomalytwitterCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_cluster_to_string(s : TimeseriesanomalytwitterCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_model_make(size : Int) -> TimeseriesanomalytwitterModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_model_len(s : TimeseriesanomalytwitterModel) -> Int { s.size }

pub fn timeseries_anomaly_twitter_model_get(s : TimeseriesanomalytwitterModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_model_set(s : TimeseriesanomalytwitterModel, i : Int, v : Double) -> TimeseriesanomalytwitterModel {
  let result = timeseries_anomaly_twitter_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_model_sum(s : TimeseriesanomalytwitterModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_twitter_model_mean(s : TimeseriesanomalytwitterModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_twitter_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_twitter_model_scale(s : TimeseriesanomalytwitterModel, f : Double) -> TimeseriesanomalytwitterModel {
  let result = timeseries_anomaly_twitter_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_twitter_model_add(a : TimeseriesanomalytwitterModel, b : TimeseriesanomalytwitterModel) -> TimeseriesanomalytwitterModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_twitter_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_model_copy(s : TimeseriesanomalytwitterModel) -> TimeseriesanomalytwitterModel {
  let result = timeseries_anomaly_twitter_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_model_fill(s : TimeseriesanomalytwitterModel, v : Double) -> TimeseriesanomalytwitterModel {
  let result = timeseries_anomaly_twitter_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_model_min(s : TimeseriesanomalytwitterModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_model_max(s : TimeseriesanomalytwitterModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_model_to_string(s : TimeseriesanomalytwitterModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_layer_make(size : Int) -> TimeseriesanomalytwitterLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_layer_len(s : TimeseriesanomalytwitterLayer) -> Int { s.size }

pub fn timeseries_anomaly_twitter_layer_get(s : TimeseriesanomalytwitterLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_layer_set(s : TimeseriesanomalytwitterLayer, i : Int, v : Double) -> TimeseriesanomalytwitterLayer {
  let result = timeseries_anomaly_twitter_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_layer_sum(s : TimeseriesanomalytwitterLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_twitter_layer_mean(s : TimeseriesanomalytwitterLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_twitter_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_twitter_layer_scale(s : TimeseriesanomalytwitterLayer, f : Double) -> TimeseriesanomalytwitterLayer {
  let result = timeseries_anomaly_twitter_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_twitter_layer_add(a : TimeseriesanomalytwitterLayer, b : TimeseriesanomalytwitterLayer) -> TimeseriesanomalytwitterLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_twitter_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_layer_copy(s : TimeseriesanomalytwitterLayer) -> TimeseriesanomalytwitterLayer {
  let result = timeseries_anomaly_twitter_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_layer_fill(s : TimeseriesanomalytwitterLayer, v : Double) -> TimeseriesanomalytwitterLayer {
  let result = timeseries_anomaly_twitter_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_layer_min(s : TimeseriesanomalytwitterLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_layer_max(s : TimeseriesanomalytwitterLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_layer_to_string(s : TimeseriesanomalytwitterLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_buffer_make(size : Int) -> TimeseriesanomalytwitterBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_buffer_len(s : TimeseriesanomalytwitterBuffer) -> Int { s.size }

pub fn timeseries_anomaly_twitter_buffer_get(s : TimeseriesanomalytwitterBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_buffer_set(s : TimeseriesanomalytwitterBuffer, i : Int, v : Double) -> TimeseriesanomalytwitterBuffer {
  let result = timeseries_anomaly_twitter_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_buffer_sum(s : TimeseriesanomalytwitterBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_twitter_buffer_mean(s : TimeseriesanomalytwitterBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_twitter_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_twitter_buffer_scale(s : TimeseriesanomalytwitterBuffer, f : Double) -> TimeseriesanomalytwitterBuffer {
  let result = timeseries_anomaly_twitter_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_twitter_buffer_add(a : TimeseriesanomalytwitterBuffer, b : TimeseriesanomalytwitterBuffer) -> TimeseriesanomalytwitterBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_twitter_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_buffer_copy(s : TimeseriesanomalytwitterBuffer) -> TimeseriesanomalytwitterBuffer {
  let result = timeseries_anomaly_twitter_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_buffer_fill(s : TimeseriesanomalytwitterBuffer, v : Double) -> TimeseriesanomalytwitterBuffer {
  let result = timeseries_anomaly_twitter_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_buffer_min(s : TimeseriesanomalytwitterBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_buffer_max(s : TimeseriesanomalytwitterBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_buffer_to_string(s : TimeseriesanomalytwitterBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_cursor_make(size : Int) -> TimeseriesanomalytwitterCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_cursor_len(s : TimeseriesanomalytwitterCursor) -> Int { s.size }

pub fn timeseries_anomaly_twitter_cursor_get(s : TimeseriesanomalytwitterCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_cursor_set(s : TimeseriesanomalytwitterCursor, i : Int, v : Double) -> TimeseriesanomalytwitterCursor {
  let result = timeseries_anomaly_twitter_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_cursor_sum(s : TimeseriesanomalytwitterCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_twitter_cursor_mean(s : TimeseriesanomalytwitterCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_twitter_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_twitter_cursor_scale(s : TimeseriesanomalytwitterCursor, f : Double) -> TimeseriesanomalytwitterCursor {
  let result = timeseries_anomaly_twitter_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_twitter_cursor_add(a : TimeseriesanomalytwitterCursor, b : TimeseriesanomalytwitterCursor) -> TimeseriesanomalytwitterCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_twitter_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_cursor_copy(s : TimeseriesanomalytwitterCursor) -> TimeseriesanomalytwitterCursor {
  let result = timeseries_anomaly_twitter_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_cursor_fill(s : TimeseriesanomalytwitterCursor, v : Double) -> TimeseriesanomalytwitterCursor {
  let result = timeseries_anomaly_twitter_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_cursor_min(s : TimeseriesanomalytwitterCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_cursor_max(s : TimeseriesanomalytwitterCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_cursor_to_string(s : TimeseriesanomalytwitterCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_view_make(size : Int) -> TimeseriesanomalytwitterView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_view_len(s : TimeseriesanomalytwitterView) -> Int { s.size }

pub fn timeseries_anomaly_twitter_view_get(s : TimeseriesanomalytwitterView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_view_set(s : TimeseriesanomalytwitterView, i : Int, v : Double) -> TimeseriesanomalytwitterView {
  let result = timeseries_anomaly_twitter_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_view_sum(s : TimeseriesanomalytwitterView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_twitter_view_mean(s : TimeseriesanomalytwitterView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_twitter_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_twitter_view_scale(s : TimeseriesanomalytwitterView, f : Double) -> TimeseriesanomalytwitterView {
  let result = timeseries_anomaly_twitter_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_twitter_view_add(a : TimeseriesanomalytwitterView, b : TimeseriesanomalytwitterView) -> TimeseriesanomalytwitterView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_twitter_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_view_copy(s : TimeseriesanomalytwitterView) -> TimeseriesanomalytwitterView {
  let result = timeseries_anomaly_twitter_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_view_fill(s : TimeseriesanomalytwitterView, v : Double) -> TimeseriesanomalytwitterView {
  let result = timeseries_anomaly_twitter_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_view_min(s : TimeseriesanomalytwitterView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_view_max(s : TimeseriesanomalytwitterView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_view_to_string(s : TimeseriesanomalytwitterView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_range_make(size : Int) -> TimeseriesanomalytwitterRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_range_len(s : TimeseriesanomalytwitterRange) -> Int { s.size }

pub fn timeseries_anomaly_twitter_range_get(s : TimeseriesanomalytwitterRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_range_set(s : TimeseriesanomalytwitterRange, i : Int, v : Double) -> TimeseriesanomalytwitterRange {
  let result = timeseries_anomaly_twitter_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_range_sum(s : TimeseriesanomalytwitterRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_twitter_range_mean(s : TimeseriesanomalytwitterRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_twitter_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_twitter_range_scale(s : TimeseriesanomalytwitterRange, f : Double) -> TimeseriesanomalytwitterRange {
  let result = timeseries_anomaly_twitter_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_twitter_range_add(a : TimeseriesanomalytwitterRange, b : TimeseriesanomalytwitterRange) -> TimeseriesanomalytwitterRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_twitter_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_range_copy(s : TimeseriesanomalytwitterRange) -> TimeseriesanomalytwitterRange {
  let result = timeseries_anomaly_twitter_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_range_fill(s : TimeseriesanomalytwitterRange, v : Double) -> TimeseriesanomalytwitterRange {
  let result = timeseries_anomaly_twitter_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_range_min(s : TimeseriesanomalytwitterRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_range_max(s : TimeseriesanomalytwitterRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_range_to_string(s : TimeseriesanomalytwitterRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_slice_make(size : Int) -> TimeseriesanomalytwitterSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_slice_len(s : TimeseriesanomalytwitterSlice) -> Int { s.size }

pub fn timeseries_anomaly_twitter_slice_get(s : TimeseriesanomalytwitterSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_slice_set(s : TimeseriesanomalytwitterSlice, i : Int, v : Double) -> TimeseriesanomalytwitterSlice {
  let result = timeseries_anomaly_twitter_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_slice_sum(s : TimeseriesanomalytwitterSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_twitter_slice_mean(s : TimeseriesanomalytwitterSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_twitter_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_twitter_slice_scale(s : TimeseriesanomalytwitterSlice, f : Double) -> TimeseriesanomalytwitterSlice {
  let result = timeseries_anomaly_twitter_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_twitter_slice_add(a : TimeseriesanomalytwitterSlice, b : TimeseriesanomalytwitterSlice) -> TimeseriesanomalytwitterSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_twitter_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_slice_copy(s : TimeseriesanomalytwitterSlice) -> TimeseriesanomalytwitterSlice {
  let result = timeseries_anomaly_twitter_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_twitter_slice_fill(s : TimeseriesanomalytwitterSlice, v : Double) -> TimeseriesanomalytwitterSlice {
  let result = timeseries_anomaly_twitter_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_slice_min(s : TimeseriesanomalytwitterSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_slice_max(s : TimeseriesanomalytwitterSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_twitter_slice_to_string(s : TimeseriesanomalytwitterSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn timeseries_anomaly_twitter_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_anomaly_twitter_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

