///===
/// extcore/timeseries_anomaly_lof

pub(all) struct TimeseriesanomalylofPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_lof_make_point(x : Double, y : Double) -> TimeseriesanomalylofPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_lof_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalylofPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_anomaly_lof_point_x(pt : TimeseriesanomalylofPoint) -> Double { pt.x }

pub fn timeseries_anomaly_lof_point_y(pt : TimeseriesanomalylofPoint) -> Double { pt.y }

pub fn timeseries_anomaly_lof_point_z(pt : TimeseriesanomalylofPoint) -> Double { pt.z }

pub fn timeseries_anomaly_lof_point_label(pt : TimeseriesanomalylofPoint) -> Int { pt.label }

pub fn timeseries_anomaly_lof_point_dist(a : TimeseriesanomalylofPoint, b : TimeseriesanomalylofPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_anomaly_lof_point_add(a : TimeseriesanomalylofPoint, b : TimeseriesanomalylofPoint) -> TimeseriesanomalylofPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_anomaly_lof_point_sub(a : TimeseriesanomalylofPoint, b : TimeseriesanomalylofPoint) -> TimeseriesanomalylofPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_anomaly_lof_point_scale(pt : TimeseriesanomalylofPoint, s : Double) -> TimeseriesanomalylofPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_anomaly_lof_point_dot(a : TimeseriesanomalylofPoint, b : TimeseriesanomalylofPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_anomaly_lof_point_cross(a : TimeseriesanomalylofPoint, b : TimeseriesanomalylofPoint) -> TimeseriesanomalylofPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_anomaly_lof_point_norm(pt : TimeseriesanomalylofPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_anomaly_lof_point_normalize(pt : TimeseriesanomalylofPoint) -> TimeseriesanomalylofPoint {
  let n = timeseries_anomaly_lof_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_anomaly_lof_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_anomaly_lof_point_negate(pt : TimeseriesanomalylofPoint) -> TimeseriesanomalylofPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_anomaly_lof_point_mid(a : TimeseriesanomalylofPoint, b : TimeseriesanomalylofPoint) -> TimeseriesanomalylofPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_anomaly_lof_point_lerp(a : TimeseriesanomalylofPoint, b : TimeseriesanomalylofPoint, t : Double) -> TimeseriesanomalylofPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_anomaly_lof_point_to_string(pt : TimeseriesanomalylofPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_lof_make_series(vals : Array[Double], name : String) -> TimeseriesanomalylofSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_anomaly_lof_series_len(s : TimeseriesanomalylofSeries) -> Int { s.vals.length() }

pub fn timeseries_anomaly_lof_series_sum(s : TimeseriesanomalylofSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_anomaly_lof_series_mean(s : TimeseriesanomalylofSeries) -> Double {
  let n = timeseries_anomaly_lof_series_len(s)
  if n == 0 { 0.0 } else { timeseries_anomaly_lof_series_sum(s) / n.to_double() }
}

pub fn timeseries_anomaly_lof_series_min(s : TimeseriesanomalylofSeries) -> Double {
  let n = timeseries_anomaly_lof_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_series_max(s : TimeseriesanomalylofSeries) -> Double {
  let n = timeseries_anomaly_lof_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_series_range(s : TimeseriesanomalylofSeries) -> Double {
  timeseries_anomaly_lof_series_max(s) - timeseries_anomaly_lof_series_min(s)
}

pub fn timeseries_anomaly_lof_series_var(s : TimeseriesanomalylofSeries) -> Double {
  let n = timeseries_anomaly_lof_series_len(s)
  if n == 0 { 0.0 } else {
    let m = timeseries_anomaly_lof_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn timeseries_anomaly_lof_series_std(s : TimeseriesanomalylofSeries) -> Double { @_common.sqrt(timeseries_anomaly_lof_series_var(s)) }

pub fn timeseries_anomaly_lof_series_median(s : TimeseriesanomalylofSeries) -> Double {
  let n = timeseries_anomaly_lof_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = timeseries_anomaly_lof_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_anomaly_lof_series_scale(s : TimeseriesanomalylofSeries, f : Double) -> TimeseriesanomalylofSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_anomaly_lof_series_add(a : TimeseriesanomalylofSeries, b : TimeseriesanomalylofSeries) -> TimeseriesanomalylofSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_anomaly_lof_series_sub(a : TimeseriesanomalylofSeries, b : TimeseriesanomalylofSeries) -> TimeseriesanomalylofSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_anomaly_lof_series_normalize(s : TimeseriesanomalylofSeries) -> TimeseriesanomalylofSeries {
  let mn = timeseries_anomaly_lof_series_min(s)
  let mx = timeseries_anomaly_lof_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_anomaly_lof_series_cumsum(s : TimeseriesanomalylofSeries) -> TimeseriesanomalylofSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_anomaly_lof_series_to_string(s : TimeseriesanomalylofSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalylofMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_lof_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalylofMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_lof_matrix_identity(n : Int) -> TimeseriesanomalylofMatrix {
  let m = timeseries_anomaly_lof_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_anomaly_lof_matrix_get(m : TimeseriesanomalylofMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_anomaly_lof_matrix_transpose(m : TimeseriesanomalylofMatrix) -> TimeseriesanomalylofMatrix {
  let result = timeseries_anomaly_lof_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_anomaly_lof_matrix_add(a : TimeseriesanomalylofMatrix, b : TimeseriesanomalylofMatrix) -> TimeseriesanomalylofMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_anomaly_lof_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_anomaly_lof_matrix_scale(m : TimeseriesanomalylofMatrix, s : Double) -> TimeseriesanomalylofMatrix {
  let result = timeseries_anomaly_lof_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_anomaly_lof_matrix_multiply(a : TimeseriesanomalylofMatrix, b : TimeseriesanomalylofMatrix) -> TimeseriesanomalylofMatrix {
  if a.cols != b.rows { return timeseries_anomaly_lof_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_anomaly_lof_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_anomaly_lof_matrix_trace(m : TimeseriesanomalylofMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_anomaly_lof_matrix_det(m : TimeseriesanomalylofMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_anomaly_lof_matrix_norm(m : TimeseriesanomalylofMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_anomaly_lof_matrix_to_string(m : TimeseriesanomalylofMatrix) -> String {
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

pub(all) struct TimeseriesanomalylofVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_lof_make_vector(comps : Array[Double]) -> TimeseriesanomalylofVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_lof_vector_zero(dim : Int) -> TimeseriesanomalylofVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_anomaly_lof_vector_add(a : TimeseriesanomalylofVector, b : TimeseriesanomalylofVector) -> TimeseriesanomalylofVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_anomaly_lof_vector_sub(a : TimeseriesanomalylofVector, b : TimeseriesanomalylofVector) -> TimeseriesanomalylofVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_anomaly_lof_vector_scale(v : TimeseriesanomalylofVector, s : Double) -> TimeseriesanomalylofVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_anomaly_lof_vector_dot(a : TimeseriesanomalylofVector, b : TimeseriesanomalylofVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_anomaly_lof_vector_norm(v : TimeseriesanomalylofVector) -> Double { @_common.sqrt(timeseries_anomaly_lof_vector_dot(v, v)) }

pub fn timeseries_anomaly_lof_vector_normalize(v : TimeseriesanomalylofVector) -> TimeseriesanomalylofVector {
  let n = timeseries_anomaly_lof_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_anomaly_lof_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_anomaly_lof_vector_dist(a : TimeseriesanomalylofVector, b : TimeseriesanomalylofVector) -> Double {
  timeseries_anomaly_lof_vector_norm(timeseries_anomaly_lof_vector_sub(a, b))
}

pub fn timeseries_anomaly_lof_vector_to_string(v : TimeseriesanomalylofVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_anomaly_lof_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn timeseries_anomaly_lof_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = timeseries_anomaly_lof_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_anomaly_lof_std(data : Array[Double]) -> Double { @_common.sqrt(timeseries_anomaly_lof_var(data)) }

pub fn timeseries_anomaly_lof_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = timeseries_anomaly_lof_mean(a); let mb = timeseries_anomaly_lof_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn timeseries_anomaly_lof_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = timeseries_anomaly_lof_std(a); let sb = timeseries_anomaly_lof_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { timeseries_anomaly_lof_cov(a, b) / (sa * sb) }
}

pub fn timeseries_anomaly_lof_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = timeseries_anomaly_lof_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_anomaly_lof_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn timeseries_anomaly_lof_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_anomaly_lof_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(timeseries_anomaly_lof_mse(pred, labels))
}

pub fn timeseries_anomaly_lof_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn timeseries_anomaly_lof_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = timeseries_anomaly_lof_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn timeseries_anomaly_lof_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn timeseries_anomaly_lof_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn timeseries_anomaly_lof_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = timeseries_anomaly_lof_precision(pred, labels, pos); let r = timeseries_anomaly_lof_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn timeseries_anomaly_lof_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn timeseries_anomaly_lof_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = timeseries_anomaly_lof_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn timeseries_anomaly_lof_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn timeseries_anomaly_lof_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn timeseries_anomaly_lof_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = timeseries_anomaly_lof_gcd(a, b)
    (a / g) * b
  }
}

pub fn timeseries_anomaly_lof_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn timeseries_anomaly_lof_fibonacci(n : Int) -> Int {
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

pub fn timeseries_anomaly_lof_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = timeseries_anomaly_lof_min(data); let mx = timeseries_anomaly_lof_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn timeseries_anomaly_lof_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = timeseries_anomaly_lof_mean(data); let sd = timeseries_anomaly_lof_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn timeseries_anomaly_lof_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn timeseries_anomaly_lof_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn timeseries_anomaly_lof_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn timeseries_anomaly_lof_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct TimeseriesanomalylofFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_frame_make(size : Int) -> TimeseriesanomalylofFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_frame_len(s : TimeseriesanomalylofFrame) -> Int { s.size }

pub fn timeseries_anomaly_lof_frame_get(s : TimeseriesanomalylofFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_frame_set(s : TimeseriesanomalylofFrame, i : Int, v : Double) -> TimeseriesanomalylofFrame {
  let result = timeseries_anomaly_lof_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_frame_sum(s : TimeseriesanomalylofFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lof_frame_mean(s : TimeseriesanomalylofFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lof_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lof_frame_scale(s : TimeseriesanomalylofFrame, f : Double) -> TimeseriesanomalylofFrame {
  let result = timeseries_anomaly_lof_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lof_frame_add(a : TimeseriesanomalylofFrame, b : TimeseriesanomalylofFrame) -> TimeseriesanomalylofFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lof_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lof_frame_copy(s : TimeseriesanomalylofFrame) -> TimeseriesanomalylofFrame {
  let result = timeseries_anomaly_lof_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lof_frame_fill(s : TimeseriesanomalylofFrame, v : Double) -> TimeseriesanomalylofFrame {
  let result = timeseries_anomaly_lof_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_frame_min(s : TimeseriesanomalylofFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_frame_max(s : TimeseriesanomalylofFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_frame_to_string(s : TimeseriesanomalylofFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_table_make(size : Int) -> TimeseriesanomalylofTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_table_len(s : TimeseriesanomalylofTable) -> Int { s.size }

pub fn timeseries_anomaly_lof_table_get(s : TimeseriesanomalylofTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_table_set(s : TimeseriesanomalylofTable, i : Int, v : Double) -> TimeseriesanomalylofTable {
  let result = timeseries_anomaly_lof_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_table_sum(s : TimeseriesanomalylofTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lof_table_mean(s : TimeseriesanomalylofTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lof_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lof_table_scale(s : TimeseriesanomalylofTable, f : Double) -> TimeseriesanomalylofTable {
  let result = timeseries_anomaly_lof_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lof_table_add(a : TimeseriesanomalylofTable, b : TimeseriesanomalylofTable) -> TimeseriesanomalylofTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lof_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lof_table_copy(s : TimeseriesanomalylofTable) -> TimeseriesanomalylofTable {
  let result = timeseries_anomaly_lof_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lof_table_fill(s : TimeseriesanomalylofTable, v : Double) -> TimeseriesanomalylofTable {
  let result = timeseries_anomaly_lof_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_table_min(s : TimeseriesanomalylofTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_table_max(s : TimeseriesanomalylofTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_table_to_string(s : TimeseriesanomalylofTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_graphn_make(size : Int) -> TimeseriesanomalylofGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_graphn_len(s : TimeseriesanomalylofGraphN) -> Int { s.size }

pub fn timeseries_anomaly_lof_graphn_get(s : TimeseriesanomalylofGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_graphn_set(s : TimeseriesanomalylofGraphN, i : Int, v : Double) -> TimeseriesanomalylofGraphN {
  let result = timeseries_anomaly_lof_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_graphn_sum(s : TimeseriesanomalylofGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lof_graphn_mean(s : TimeseriesanomalylofGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lof_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lof_graphn_scale(s : TimeseriesanomalylofGraphN, f : Double) -> TimeseriesanomalylofGraphN {
  let result = timeseries_anomaly_lof_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lof_graphn_add(a : TimeseriesanomalylofGraphN, b : TimeseriesanomalylofGraphN) -> TimeseriesanomalylofGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lof_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lof_graphn_copy(s : TimeseriesanomalylofGraphN) -> TimeseriesanomalylofGraphN {
  let result = timeseries_anomaly_lof_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lof_graphn_fill(s : TimeseriesanomalylofGraphN, v : Double) -> TimeseriesanomalylofGraphN {
  let result = timeseries_anomaly_lof_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_graphn_min(s : TimeseriesanomalylofGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_graphn_max(s : TimeseriesanomalylofGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_graphn_to_string(s : TimeseriesanomalylofGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_node_make(size : Int) -> TimeseriesanomalylofNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_node_len(s : TimeseriesanomalylofNode) -> Int { s.size }

pub fn timeseries_anomaly_lof_node_get(s : TimeseriesanomalylofNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_node_set(s : TimeseriesanomalylofNode, i : Int, v : Double) -> TimeseriesanomalylofNode {
  let result = timeseries_anomaly_lof_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_node_sum(s : TimeseriesanomalylofNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lof_node_mean(s : TimeseriesanomalylofNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lof_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lof_node_scale(s : TimeseriesanomalylofNode, f : Double) -> TimeseriesanomalylofNode {
  let result = timeseries_anomaly_lof_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lof_node_add(a : TimeseriesanomalylofNode, b : TimeseriesanomalylofNode) -> TimeseriesanomalylofNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lof_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lof_node_copy(s : TimeseriesanomalylofNode) -> TimeseriesanomalylofNode {
  let result = timeseries_anomaly_lof_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lof_node_fill(s : TimeseriesanomalylofNode, v : Double) -> TimeseriesanomalylofNode {
  let result = timeseries_anomaly_lof_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_node_min(s : TimeseriesanomalylofNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_node_max(s : TimeseriesanomalylofNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_node_to_string(s : TimeseriesanomalylofNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_edge_make(size : Int) -> TimeseriesanomalylofEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_edge_len(s : TimeseriesanomalylofEdge) -> Int { s.size }

pub fn timeseries_anomaly_lof_edge_get(s : TimeseriesanomalylofEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_edge_set(s : TimeseriesanomalylofEdge, i : Int, v : Double) -> TimeseriesanomalylofEdge {
  let result = timeseries_anomaly_lof_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_edge_sum(s : TimeseriesanomalylofEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lof_edge_mean(s : TimeseriesanomalylofEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lof_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lof_edge_scale(s : TimeseriesanomalylofEdge, f : Double) -> TimeseriesanomalylofEdge {
  let result = timeseries_anomaly_lof_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lof_edge_add(a : TimeseriesanomalylofEdge, b : TimeseriesanomalylofEdge) -> TimeseriesanomalylofEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lof_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lof_edge_copy(s : TimeseriesanomalylofEdge) -> TimeseriesanomalylofEdge {
  let result = timeseries_anomaly_lof_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lof_edge_fill(s : TimeseriesanomalylofEdge, v : Double) -> TimeseriesanomalylofEdge {
  let result = timeseries_anomaly_lof_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_edge_min(s : TimeseriesanomalylofEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_edge_max(s : TimeseriesanomalylofEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_edge_to_string(s : TimeseriesanomalylofEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_path_make(size : Int) -> TimeseriesanomalylofPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_path_len(s : TimeseriesanomalylofPath) -> Int { s.size }

pub fn timeseries_anomaly_lof_path_get(s : TimeseriesanomalylofPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_path_set(s : TimeseriesanomalylofPath, i : Int, v : Double) -> TimeseriesanomalylofPath {
  let result = timeseries_anomaly_lof_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_path_sum(s : TimeseriesanomalylofPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lof_path_mean(s : TimeseriesanomalylofPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lof_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lof_path_scale(s : TimeseriesanomalylofPath, f : Double) -> TimeseriesanomalylofPath {
  let result = timeseries_anomaly_lof_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lof_path_add(a : TimeseriesanomalylofPath, b : TimeseriesanomalylofPath) -> TimeseriesanomalylofPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lof_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lof_path_copy(s : TimeseriesanomalylofPath) -> TimeseriesanomalylofPath {
  let result = timeseries_anomaly_lof_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lof_path_fill(s : TimeseriesanomalylofPath, v : Double) -> TimeseriesanomalylofPath {
  let result = timeseries_anomaly_lof_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_path_min(s : TimeseriesanomalylofPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_path_max(s : TimeseriesanomalylofPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_path_to_string(s : TimeseriesanomalylofPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_cluster_make(size : Int) -> TimeseriesanomalylofCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_cluster_len(s : TimeseriesanomalylofCluster) -> Int { s.size }

pub fn timeseries_anomaly_lof_cluster_get(s : TimeseriesanomalylofCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_cluster_set(s : TimeseriesanomalylofCluster, i : Int, v : Double) -> TimeseriesanomalylofCluster {
  let result = timeseries_anomaly_lof_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_cluster_sum(s : TimeseriesanomalylofCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lof_cluster_mean(s : TimeseriesanomalylofCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lof_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lof_cluster_scale(s : TimeseriesanomalylofCluster, f : Double) -> TimeseriesanomalylofCluster {
  let result = timeseries_anomaly_lof_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lof_cluster_add(a : TimeseriesanomalylofCluster, b : TimeseriesanomalylofCluster) -> TimeseriesanomalylofCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lof_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lof_cluster_copy(s : TimeseriesanomalylofCluster) -> TimeseriesanomalylofCluster {
  let result = timeseries_anomaly_lof_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lof_cluster_fill(s : TimeseriesanomalylofCluster, v : Double) -> TimeseriesanomalylofCluster {
  let result = timeseries_anomaly_lof_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_cluster_min(s : TimeseriesanomalylofCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_cluster_max(s : TimeseriesanomalylofCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_cluster_to_string(s : TimeseriesanomalylofCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_model_make(size : Int) -> TimeseriesanomalylofModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_model_len(s : TimeseriesanomalylofModel) -> Int { s.size }

pub fn timeseries_anomaly_lof_model_get(s : TimeseriesanomalylofModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_model_set(s : TimeseriesanomalylofModel, i : Int, v : Double) -> TimeseriesanomalylofModel {
  let result = timeseries_anomaly_lof_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_model_sum(s : TimeseriesanomalylofModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lof_model_mean(s : TimeseriesanomalylofModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lof_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lof_model_scale(s : TimeseriesanomalylofModel, f : Double) -> TimeseriesanomalylofModel {
  let result = timeseries_anomaly_lof_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lof_model_add(a : TimeseriesanomalylofModel, b : TimeseriesanomalylofModel) -> TimeseriesanomalylofModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lof_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lof_model_copy(s : TimeseriesanomalylofModel) -> TimeseriesanomalylofModel {
  let result = timeseries_anomaly_lof_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lof_model_fill(s : TimeseriesanomalylofModel, v : Double) -> TimeseriesanomalylofModel {
  let result = timeseries_anomaly_lof_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_model_min(s : TimeseriesanomalylofModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_model_max(s : TimeseriesanomalylofModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_model_to_string(s : TimeseriesanomalylofModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_layer_make(size : Int) -> TimeseriesanomalylofLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_layer_len(s : TimeseriesanomalylofLayer) -> Int { s.size }

pub fn timeseries_anomaly_lof_layer_get(s : TimeseriesanomalylofLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_layer_set(s : TimeseriesanomalylofLayer, i : Int, v : Double) -> TimeseriesanomalylofLayer {
  let result = timeseries_anomaly_lof_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_layer_sum(s : TimeseriesanomalylofLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lof_layer_mean(s : TimeseriesanomalylofLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lof_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lof_layer_scale(s : TimeseriesanomalylofLayer, f : Double) -> TimeseriesanomalylofLayer {
  let result = timeseries_anomaly_lof_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lof_layer_add(a : TimeseriesanomalylofLayer, b : TimeseriesanomalylofLayer) -> TimeseriesanomalylofLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lof_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lof_layer_copy(s : TimeseriesanomalylofLayer) -> TimeseriesanomalylofLayer {
  let result = timeseries_anomaly_lof_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lof_layer_fill(s : TimeseriesanomalylofLayer, v : Double) -> TimeseriesanomalylofLayer {
  let result = timeseries_anomaly_lof_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_layer_min(s : TimeseriesanomalylofLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_layer_max(s : TimeseriesanomalylofLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_layer_to_string(s : TimeseriesanomalylofLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_buffer_make(size : Int) -> TimeseriesanomalylofBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_buffer_len(s : TimeseriesanomalylofBuffer) -> Int { s.size }

pub fn timeseries_anomaly_lof_buffer_get(s : TimeseriesanomalylofBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_buffer_set(s : TimeseriesanomalylofBuffer, i : Int, v : Double) -> TimeseriesanomalylofBuffer {
  let result = timeseries_anomaly_lof_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_buffer_sum(s : TimeseriesanomalylofBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lof_buffer_mean(s : TimeseriesanomalylofBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lof_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lof_buffer_scale(s : TimeseriesanomalylofBuffer, f : Double) -> TimeseriesanomalylofBuffer {
  let result = timeseries_anomaly_lof_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lof_buffer_add(a : TimeseriesanomalylofBuffer, b : TimeseriesanomalylofBuffer) -> TimeseriesanomalylofBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lof_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lof_buffer_copy(s : TimeseriesanomalylofBuffer) -> TimeseriesanomalylofBuffer {
  let result = timeseries_anomaly_lof_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lof_buffer_fill(s : TimeseriesanomalylofBuffer, v : Double) -> TimeseriesanomalylofBuffer {
  let result = timeseries_anomaly_lof_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_buffer_min(s : TimeseriesanomalylofBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_buffer_max(s : TimeseriesanomalylofBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_buffer_to_string(s : TimeseriesanomalylofBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_cursor_make(size : Int) -> TimeseriesanomalylofCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_cursor_len(s : TimeseriesanomalylofCursor) -> Int { s.size }

pub fn timeseries_anomaly_lof_cursor_get(s : TimeseriesanomalylofCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_cursor_set(s : TimeseriesanomalylofCursor, i : Int, v : Double) -> TimeseriesanomalylofCursor {
  let result = timeseries_anomaly_lof_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_cursor_sum(s : TimeseriesanomalylofCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lof_cursor_mean(s : TimeseriesanomalylofCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lof_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lof_cursor_scale(s : TimeseriesanomalylofCursor, f : Double) -> TimeseriesanomalylofCursor {
  let result = timeseries_anomaly_lof_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lof_cursor_add(a : TimeseriesanomalylofCursor, b : TimeseriesanomalylofCursor) -> TimeseriesanomalylofCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lof_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lof_cursor_copy(s : TimeseriesanomalylofCursor) -> TimeseriesanomalylofCursor {
  let result = timeseries_anomaly_lof_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lof_cursor_fill(s : TimeseriesanomalylofCursor, v : Double) -> TimeseriesanomalylofCursor {
  let result = timeseries_anomaly_lof_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_cursor_min(s : TimeseriesanomalylofCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_cursor_max(s : TimeseriesanomalylofCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_cursor_to_string(s : TimeseriesanomalylofCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_view_make(size : Int) -> TimeseriesanomalylofView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_view_len(s : TimeseriesanomalylofView) -> Int { s.size }

pub fn timeseries_anomaly_lof_view_get(s : TimeseriesanomalylofView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_view_set(s : TimeseriesanomalylofView, i : Int, v : Double) -> TimeseriesanomalylofView {
  let result = timeseries_anomaly_lof_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_view_sum(s : TimeseriesanomalylofView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lof_view_mean(s : TimeseriesanomalylofView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lof_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lof_view_scale(s : TimeseriesanomalylofView, f : Double) -> TimeseriesanomalylofView {
  let result = timeseries_anomaly_lof_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lof_view_add(a : TimeseriesanomalylofView, b : TimeseriesanomalylofView) -> TimeseriesanomalylofView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lof_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lof_view_copy(s : TimeseriesanomalylofView) -> TimeseriesanomalylofView {
  let result = timeseries_anomaly_lof_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lof_view_fill(s : TimeseriesanomalylofView, v : Double) -> TimeseriesanomalylofView {
  let result = timeseries_anomaly_lof_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_view_min(s : TimeseriesanomalylofView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_view_max(s : TimeseriesanomalylofView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_view_to_string(s : TimeseriesanomalylofView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_range_make(size : Int) -> TimeseriesanomalylofRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_range_len(s : TimeseriesanomalylofRange) -> Int { s.size }

pub fn timeseries_anomaly_lof_range_get(s : TimeseriesanomalylofRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_range_set(s : TimeseriesanomalylofRange, i : Int, v : Double) -> TimeseriesanomalylofRange {
  let result = timeseries_anomaly_lof_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_range_sum(s : TimeseriesanomalylofRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lof_range_mean(s : TimeseriesanomalylofRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lof_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lof_range_scale(s : TimeseriesanomalylofRange, f : Double) -> TimeseriesanomalylofRange {
  let result = timeseries_anomaly_lof_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lof_range_add(a : TimeseriesanomalylofRange, b : TimeseriesanomalylofRange) -> TimeseriesanomalylofRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lof_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lof_range_copy(s : TimeseriesanomalylofRange) -> TimeseriesanomalylofRange {
  let result = timeseries_anomaly_lof_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lof_range_fill(s : TimeseriesanomalylofRange, v : Double) -> TimeseriesanomalylofRange {
  let result = timeseries_anomaly_lof_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_range_min(s : TimeseriesanomalylofRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_range_max(s : TimeseriesanomalylofRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_range_to_string(s : TimeseriesanomalylofRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_slice_make(size : Int) -> TimeseriesanomalylofSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_slice_len(s : TimeseriesanomalylofSlice) -> Int { s.size }

pub fn timeseries_anomaly_lof_slice_get(s : TimeseriesanomalylofSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_slice_set(s : TimeseriesanomalylofSlice, i : Int, v : Double) -> TimeseriesanomalylofSlice {
  let result = timeseries_anomaly_lof_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_slice_sum(s : TimeseriesanomalylofSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_lof_slice_mean(s : TimeseriesanomalylofSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_lof_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_lof_slice_scale(s : TimeseriesanomalylofSlice, f : Double) -> TimeseriesanomalylofSlice {
  let result = timeseries_anomaly_lof_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_lof_slice_add(a : TimeseriesanomalylofSlice, b : TimeseriesanomalylofSlice) -> TimeseriesanomalylofSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_lof_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_lof_slice_copy(s : TimeseriesanomalylofSlice) -> TimeseriesanomalylofSlice {
  let result = timeseries_anomaly_lof_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_lof_slice_fill(s : TimeseriesanomalylofSlice, v : Double) -> TimeseriesanomalylofSlice {
  let result = timeseries_anomaly_lof_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_lof_slice_min(s : TimeseriesanomalylofSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_slice_max(s : TimeseriesanomalylofSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_lof_slice_to_string(s : TimeseriesanomalylofSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

