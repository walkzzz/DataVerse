///===
/// extcore/timeseries_anomaly_iqr

pub(all) struct TimeseriesanomalyiqrPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_iqr_make_point(x : Double, y : Double) -> TimeseriesanomalyiqrPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_iqr_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalyiqrPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_anomaly_iqr_point_x(pt : TimeseriesanomalyiqrPoint) -> Double { pt.x }

pub fn timeseries_anomaly_iqr_point_y(pt : TimeseriesanomalyiqrPoint) -> Double { pt.y }

pub fn timeseries_anomaly_iqr_point_z(pt : TimeseriesanomalyiqrPoint) -> Double { pt.z }

pub fn timeseries_anomaly_iqr_point_label(pt : TimeseriesanomalyiqrPoint) -> Int { pt.label }

pub fn timeseries_anomaly_iqr_point_dist(a : TimeseriesanomalyiqrPoint, b : TimeseriesanomalyiqrPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_anomaly_iqr_point_add(a : TimeseriesanomalyiqrPoint, b : TimeseriesanomalyiqrPoint) -> TimeseriesanomalyiqrPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_anomaly_iqr_point_sub(a : TimeseriesanomalyiqrPoint, b : TimeseriesanomalyiqrPoint) -> TimeseriesanomalyiqrPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_anomaly_iqr_point_scale(pt : TimeseriesanomalyiqrPoint, s : Double) -> TimeseriesanomalyiqrPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_anomaly_iqr_point_dot(a : TimeseriesanomalyiqrPoint, b : TimeseriesanomalyiqrPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_anomaly_iqr_point_cross(a : TimeseriesanomalyiqrPoint, b : TimeseriesanomalyiqrPoint) -> TimeseriesanomalyiqrPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_anomaly_iqr_point_norm(pt : TimeseriesanomalyiqrPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_anomaly_iqr_point_normalize(pt : TimeseriesanomalyiqrPoint) -> TimeseriesanomalyiqrPoint {
  let n = timeseries_anomaly_iqr_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_anomaly_iqr_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_anomaly_iqr_point_negate(pt : TimeseriesanomalyiqrPoint) -> TimeseriesanomalyiqrPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_anomaly_iqr_point_mid(a : TimeseriesanomalyiqrPoint, b : TimeseriesanomalyiqrPoint) -> TimeseriesanomalyiqrPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_anomaly_iqr_point_lerp(a : TimeseriesanomalyiqrPoint, b : TimeseriesanomalyiqrPoint, t : Double) -> TimeseriesanomalyiqrPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_anomaly_iqr_point_to_string(pt : TimeseriesanomalyiqrPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_iqr_make_series(vals : Array[Double], name : String) -> TimeseriesanomalyiqrSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_anomaly_iqr_series_len(s : TimeseriesanomalyiqrSeries) -> Int { s.vals.length() }

pub fn timeseries_anomaly_iqr_series_sum(s : TimeseriesanomalyiqrSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_anomaly_iqr_series_mean(s : TimeseriesanomalyiqrSeries) -> Double {
  let n = timeseries_anomaly_iqr_series_len(s)
  if n == 0 { 0.0 } else { timeseries_anomaly_iqr_series_sum(s) / n.to_double() }
}

pub fn timeseries_anomaly_iqr_series_min(s : TimeseriesanomalyiqrSeries) -> Double {
  let n = timeseries_anomaly_iqr_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_series_max(s : TimeseriesanomalyiqrSeries) -> Double {
  let n = timeseries_anomaly_iqr_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_series_range(s : TimeseriesanomalyiqrSeries) -> Double {
  timeseries_anomaly_iqr_series_max(s) - timeseries_anomaly_iqr_series_min(s)
}

pub fn timeseries_anomaly_iqr_series_var(s : TimeseriesanomalyiqrSeries) -> Double {
  let n = timeseries_anomaly_iqr_series_len(s)
  if n == 0 { 0.0 } else {
    let m = timeseries_anomaly_iqr_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn timeseries_anomaly_iqr_series_std(s : TimeseriesanomalyiqrSeries) -> Double { @_common.sqrt(timeseries_anomaly_iqr_series_var(s)) }

pub fn timeseries_anomaly_iqr_series_median(s : TimeseriesanomalyiqrSeries) -> Double {
  let n = timeseries_anomaly_iqr_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = timeseries_anomaly_iqr_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_anomaly_iqr_series_scale(s : TimeseriesanomalyiqrSeries, f : Double) -> TimeseriesanomalyiqrSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_anomaly_iqr_series_add(a : TimeseriesanomalyiqrSeries, b : TimeseriesanomalyiqrSeries) -> TimeseriesanomalyiqrSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_anomaly_iqr_series_sub(a : TimeseriesanomalyiqrSeries, b : TimeseriesanomalyiqrSeries) -> TimeseriesanomalyiqrSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_anomaly_iqr_series_normalize(s : TimeseriesanomalyiqrSeries) -> TimeseriesanomalyiqrSeries {
  let mn = timeseries_anomaly_iqr_series_min(s)
  let mx = timeseries_anomaly_iqr_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_anomaly_iqr_series_cumsum(s : TimeseriesanomalyiqrSeries) -> TimeseriesanomalyiqrSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_anomaly_iqr_series_to_string(s : TimeseriesanomalyiqrSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalyiqrMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_iqr_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalyiqrMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_iqr_matrix_identity(n : Int) -> TimeseriesanomalyiqrMatrix {
  let m = timeseries_anomaly_iqr_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_anomaly_iqr_matrix_get(m : TimeseriesanomalyiqrMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_anomaly_iqr_matrix_transpose(m : TimeseriesanomalyiqrMatrix) -> TimeseriesanomalyiqrMatrix {
  let result = timeseries_anomaly_iqr_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_anomaly_iqr_matrix_add(a : TimeseriesanomalyiqrMatrix, b : TimeseriesanomalyiqrMatrix) -> TimeseriesanomalyiqrMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_anomaly_iqr_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_anomaly_iqr_matrix_scale(m : TimeseriesanomalyiqrMatrix, s : Double) -> TimeseriesanomalyiqrMatrix {
  let result = timeseries_anomaly_iqr_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_anomaly_iqr_matrix_multiply(a : TimeseriesanomalyiqrMatrix, b : TimeseriesanomalyiqrMatrix) -> TimeseriesanomalyiqrMatrix {
  if a.cols != b.rows { return timeseries_anomaly_iqr_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_anomaly_iqr_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_anomaly_iqr_matrix_trace(m : TimeseriesanomalyiqrMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_anomaly_iqr_matrix_det(m : TimeseriesanomalyiqrMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_anomaly_iqr_matrix_norm(m : TimeseriesanomalyiqrMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_anomaly_iqr_matrix_to_string(m : TimeseriesanomalyiqrMatrix) -> String {
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

pub(all) struct TimeseriesanomalyiqrVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_iqr_make_vector(comps : Array[Double]) -> TimeseriesanomalyiqrVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_iqr_vector_zero(dim : Int) -> TimeseriesanomalyiqrVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_anomaly_iqr_vector_add(a : TimeseriesanomalyiqrVector, b : TimeseriesanomalyiqrVector) -> TimeseriesanomalyiqrVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_anomaly_iqr_vector_sub(a : TimeseriesanomalyiqrVector, b : TimeseriesanomalyiqrVector) -> TimeseriesanomalyiqrVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_anomaly_iqr_vector_scale(v : TimeseriesanomalyiqrVector, s : Double) -> TimeseriesanomalyiqrVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_anomaly_iqr_vector_dot(a : TimeseriesanomalyiqrVector, b : TimeseriesanomalyiqrVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_anomaly_iqr_vector_norm(v : TimeseriesanomalyiqrVector) -> Double { @_common.sqrt(timeseries_anomaly_iqr_vector_dot(v, v)) }

pub fn timeseries_anomaly_iqr_vector_normalize(v : TimeseriesanomalyiqrVector) -> TimeseriesanomalyiqrVector {
  let n = timeseries_anomaly_iqr_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_anomaly_iqr_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_anomaly_iqr_vector_dist(a : TimeseriesanomalyiqrVector, b : TimeseriesanomalyiqrVector) -> Double {
  timeseries_anomaly_iqr_vector_norm(timeseries_anomaly_iqr_vector_sub(a, b))
}

pub fn timeseries_anomaly_iqr_vector_to_string(v : TimeseriesanomalyiqrVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_anomaly_iqr_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn timeseries_anomaly_iqr_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = timeseries_anomaly_iqr_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_anomaly_iqr_std(data : Array[Double]) -> Double { @_common.sqrt(timeseries_anomaly_iqr_var(data)) }

pub fn timeseries_anomaly_iqr_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = timeseries_anomaly_iqr_mean(a); let mb = timeseries_anomaly_iqr_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn timeseries_anomaly_iqr_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = timeseries_anomaly_iqr_std(a); let sb = timeseries_anomaly_iqr_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { timeseries_anomaly_iqr_cov(a, b) / (sa * sb) }
}

pub fn timeseries_anomaly_iqr_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = timeseries_anomaly_iqr_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_anomaly_iqr_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn timeseries_anomaly_iqr_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_anomaly_iqr_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(timeseries_anomaly_iqr_mse(pred, labels))
}

pub fn timeseries_anomaly_iqr_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn timeseries_anomaly_iqr_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = timeseries_anomaly_iqr_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn timeseries_anomaly_iqr_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn timeseries_anomaly_iqr_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn timeseries_anomaly_iqr_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = timeseries_anomaly_iqr_precision(pred, labels, pos); let r = timeseries_anomaly_iqr_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn timeseries_anomaly_iqr_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn timeseries_anomaly_iqr_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = timeseries_anomaly_iqr_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn timeseries_anomaly_iqr_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn timeseries_anomaly_iqr_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn timeseries_anomaly_iqr_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = timeseries_anomaly_iqr_gcd(a, b)
    (a / g) * b
  }
}

pub fn timeseries_anomaly_iqr_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn timeseries_anomaly_iqr_fibonacci(n : Int) -> Int {
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

pub fn timeseries_anomaly_iqr_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = timeseries_anomaly_iqr_min(data); let mx = timeseries_anomaly_iqr_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn timeseries_anomaly_iqr_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = timeseries_anomaly_iqr_mean(data); let sd = timeseries_anomaly_iqr_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn timeseries_anomaly_iqr_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn timeseries_anomaly_iqr_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn timeseries_anomaly_iqr_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn timeseries_anomaly_iqr_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct TimeseriesanomalyiqrFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_frame_make(size : Int) -> TimeseriesanomalyiqrFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_frame_len(s : TimeseriesanomalyiqrFrame) -> Int { s.size }

pub fn timeseries_anomaly_iqr_frame_get(s : TimeseriesanomalyiqrFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_frame_set(s : TimeseriesanomalyiqrFrame, i : Int, v : Double) -> TimeseriesanomalyiqrFrame {
  let result = timeseries_anomaly_iqr_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_frame_sum(s : TimeseriesanomalyiqrFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_iqr_frame_mean(s : TimeseriesanomalyiqrFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_iqr_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_iqr_frame_scale(s : TimeseriesanomalyiqrFrame, f : Double) -> TimeseriesanomalyiqrFrame {
  let result = timeseries_anomaly_iqr_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_iqr_frame_add(a : TimeseriesanomalyiqrFrame, b : TimeseriesanomalyiqrFrame) -> TimeseriesanomalyiqrFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_iqr_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_frame_copy(s : TimeseriesanomalyiqrFrame) -> TimeseriesanomalyiqrFrame {
  let result = timeseries_anomaly_iqr_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_frame_fill(s : TimeseriesanomalyiqrFrame, v : Double) -> TimeseriesanomalyiqrFrame {
  let result = timeseries_anomaly_iqr_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_frame_min(s : TimeseriesanomalyiqrFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_frame_max(s : TimeseriesanomalyiqrFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_frame_to_string(s : TimeseriesanomalyiqrFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_table_make(size : Int) -> TimeseriesanomalyiqrTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_table_len(s : TimeseriesanomalyiqrTable) -> Int { s.size }

pub fn timeseries_anomaly_iqr_table_get(s : TimeseriesanomalyiqrTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_table_set(s : TimeseriesanomalyiqrTable, i : Int, v : Double) -> TimeseriesanomalyiqrTable {
  let result = timeseries_anomaly_iqr_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_table_sum(s : TimeseriesanomalyiqrTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_iqr_table_mean(s : TimeseriesanomalyiqrTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_iqr_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_iqr_table_scale(s : TimeseriesanomalyiqrTable, f : Double) -> TimeseriesanomalyiqrTable {
  let result = timeseries_anomaly_iqr_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_iqr_table_add(a : TimeseriesanomalyiqrTable, b : TimeseriesanomalyiqrTable) -> TimeseriesanomalyiqrTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_iqr_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_table_copy(s : TimeseriesanomalyiqrTable) -> TimeseriesanomalyiqrTable {
  let result = timeseries_anomaly_iqr_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_table_fill(s : TimeseriesanomalyiqrTable, v : Double) -> TimeseriesanomalyiqrTable {
  let result = timeseries_anomaly_iqr_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_table_min(s : TimeseriesanomalyiqrTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_table_max(s : TimeseriesanomalyiqrTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_table_to_string(s : TimeseriesanomalyiqrTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_graphn_make(size : Int) -> TimeseriesanomalyiqrGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_graphn_len(s : TimeseriesanomalyiqrGraphN) -> Int { s.size }

pub fn timeseries_anomaly_iqr_graphn_get(s : TimeseriesanomalyiqrGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_graphn_set(s : TimeseriesanomalyiqrGraphN, i : Int, v : Double) -> TimeseriesanomalyiqrGraphN {
  let result = timeseries_anomaly_iqr_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_graphn_sum(s : TimeseriesanomalyiqrGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_iqr_graphn_mean(s : TimeseriesanomalyiqrGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_iqr_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_iqr_graphn_scale(s : TimeseriesanomalyiqrGraphN, f : Double) -> TimeseriesanomalyiqrGraphN {
  let result = timeseries_anomaly_iqr_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_iqr_graphn_add(a : TimeseriesanomalyiqrGraphN, b : TimeseriesanomalyiqrGraphN) -> TimeseriesanomalyiqrGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_iqr_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_graphn_copy(s : TimeseriesanomalyiqrGraphN) -> TimeseriesanomalyiqrGraphN {
  let result = timeseries_anomaly_iqr_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_graphn_fill(s : TimeseriesanomalyiqrGraphN, v : Double) -> TimeseriesanomalyiqrGraphN {
  let result = timeseries_anomaly_iqr_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_graphn_min(s : TimeseriesanomalyiqrGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_graphn_max(s : TimeseriesanomalyiqrGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_graphn_to_string(s : TimeseriesanomalyiqrGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_node_make(size : Int) -> TimeseriesanomalyiqrNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_node_len(s : TimeseriesanomalyiqrNode) -> Int { s.size }

pub fn timeseries_anomaly_iqr_node_get(s : TimeseriesanomalyiqrNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_node_set(s : TimeseriesanomalyiqrNode, i : Int, v : Double) -> TimeseriesanomalyiqrNode {
  let result = timeseries_anomaly_iqr_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_node_sum(s : TimeseriesanomalyiqrNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_iqr_node_mean(s : TimeseriesanomalyiqrNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_iqr_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_iqr_node_scale(s : TimeseriesanomalyiqrNode, f : Double) -> TimeseriesanomalyiqrNode {
  let result = timeseries_anomaly_iqr_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_iqr_node_add(a : TimeseriesanomalyiqrNode, b : TimeseriesanomalyiqrNode) -> TimeseriesanomalyiqrNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_iqr_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_node_copy(s : TimeseriesanomalyiqrNode) -> TimeseriesanomalyiqrNode {
  let result = timeseries_anomaly_iqr_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_node_fill(s : TimeseriesanomalyiqrNode, v : Double) -> TimeseriesanomalyiqrNode {
  let result = timeseries_anomaly_iqr_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_node_min(s : TimeseriesanomalyiqrNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_node_max(s : TimeseriesanomalyiqrNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_node_to_string(s : TimeseriesanomalyiqrNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_edge_make(size : Int) -> TimeseriesanomalyiqrEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_edge_len(s : TimeseriesanomalyiqrEdge) -> Int { s.size }

pub fn timeseries_anomaly_iqr_edge_get(s : TimeseriesanomalyiqrEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_edge_set(s : TimeseriesanomalyiqrEdge, i : Int, v : Double) -> TimeseriesanomalyiqrEdge {
  let result = timeseries_anomaly_iqr_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_edge_sum(s : TimeseriesanomalyiqrEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_iqr_edge_mean(s : TimeseriesanomalyiqrEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_iqr_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_iqr_edge_scale(s : TimeseriesanomalyiqrEdge, f : Double) -> TimeseriesanomalyiqrEdge {
  let result = timeseries_anomaly_iqr_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_iqr_edge_add(a : TimeseriesanomalyiqrEdge, b : TimeseriesanomalyiqrEdge) -> TimeseriesanomalyiqrEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_iqr_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_edge_copy(s : TimeseriesanomalyiqrEdge) -> TimeseriesanomalyiqrEdge {
  let result = timeseries_anomaly_iqr_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_edge_fill(s : TimeseriesanomalyiqrEdge, v : Double) -> TimeseriesanomalyiqrEdge {
  let result = timeseries_anomaly_iqr_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_edge_min(s : TimeseriesanomalyiqrEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_edge_max(s : TimeseriesanomalyiqrEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_edge_to_string(s : TimeseriesanomalyiqrEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_path_make(size : Int) -> TimeseriesanomalyiqrPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_path_len(s : TimeseriesanomalyiqrPath) -> Int { s.size }

pub fn timeseries_anomaly_iqr_path_get(s : TimeseriesanomalyiqrPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_path_set(s : TimeseriesanomalyiqrPath, i : Int, v : Double) -> TimeseriesanomalyiqrPath {
  let result = timeseries_anomaly_iqr_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_path_sum(s : TimeseriesanomalyiqrPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_iqr_path_mean(s : TimeseriesanomalyiqrPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_iqr_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_iqr_path_scale(s : TimeseriesanomalyiqrPath, f : Double) -> TimeseriesanomalyiqrPath {
  let result = timeseries_anomaly_iqr_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_iqr_path_add(a : TimeseriesanomalyiqrPath, b : TimeseriesanomalyiqrPath) -> TimeseriesanomalyiqrPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_iqr_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_path_copy(s : TimeseriesanomalyiqrPath) -> TimeseriesanomalyiqrPath {
  let result = timeseries_anomaly_iqr_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_path_fill(s : TimeseriesanomalyiqrPath, v : Double) -> TimeseriesanomalyiqrPath {
  let result = timeseries_anomaly_iqr_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_path_min(s : TimeseriesanomalyiqrPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_path_max(s : TimeseriesanomalyiqrPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_path_to_string(s : TimeseriesanomalyiqrPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_cluster_make(size : Int) -> TimeseriesanomalyiqrCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_cluster_len(s : TimeseriesanomalyiqrCluster) -> Int { s.size }

pub fn timeseries_anomaly_iqr_cluster_get(s : TimeseriesanomalyiqrCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_cluster_set(s : TimeseriesanomalyiqrCluster, i : Int, v : Double) -> TimeseriesanomalyiqrCluster {
  let result = timeseries_anomaly_iqr_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_cluster_sum(s : TimeseriesanomalyiqrCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_iqr_cluster_mean(s : TimeseriesanomalyiqrCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_iqr_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_iqr_cluster_scale(s : TimeseriesanomalyiqrCluster, f : Double) -> TimeseriesanomalyiqrCluster {
  let result = timeseries_anomaly_iqr_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_iqr_cluster_add(a : TimeseriesanomalyiqrCluster, b : TimeseriesanomalyiqrCluster) -> TimeseriesanomalyiqrCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_iqr_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_cluster_copy(s : TimeseriesanomalyiqrCluster) -> TimeseriesanomalyiqrCluster {
  let result = timeseries_anomaly_iqr_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_cluster_fill(s : TimeseriesanomalyiqrCluster, v : Double) -> TimeseriesanomalyiqrCluster {
  let result = timeseries_anomaly_iqr_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_cluster_min(s : TimeseriesanomalyiqrCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_cluster_max(s : TimeseriesanomalyiqrCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_cluster_to_string(s : TimeseriesanomalyiqrCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_model_make(size : Int) -> TimeseriesanomalyiqrModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_model_len(s : TimeseriesanomalyiqrModel) -> Int { s.size }

pub fn timeseries_anomaly_iqr_model_get(s : TimeseriesanomalyiqrModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_model_set(s : TimeseriesanomalyiqrModel, i : Int, v : Double) -> TimeseriesanomalyiqrModel {
  let result = timeseries_anomaly_iqr_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_model_sum(s : TimeseriesanomalyiqrModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_iqr_model_mean(s : TimeseriesanomalyiqrModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_iqr_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_iqr_model_scale(s : TimeseriesanomalyiqrModel, f : Double) -> TimeseriesanomalyiqrModel {
  let result = timeseries_anomaly_iqr_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_iqr_model_add(a : TimeseriesanomalyiqrModel, b : TimeseriesanomalyiqrModel) -> TimeseriesanomalyiqrModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_iqr_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_model_copy(s : TimeseriesanomalyiqrModel) -> TimeseriesanomalyiqrModel {
  let result = timeseries_anomaly_iqr_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_model_fill(s : TimeseriesanomalyiqrModel, v : Double) -> TimeseriesanomalyiqrModel {
  let result = timeseries_anomaly_iqr_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_model_min(s : TimeseriesanomalyiqrModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_model_max(s : TimeseriesanomalyiqrModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_model_to_string(s : TimeseriesanomalyiqrModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_layer_make(size : Int) -> TimeseriesanomalyiqrLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_layer_len(s : TimeseriesanomalyiqrLayer) -> Int { s.size }

pub fn timeseries_anomaly_iqr_layer_get(s : TimeseriesanomalyiqrLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_layer_set(s : TimeseriesanomalyiqrLayer, i : Int, v : Double) -> TimeseriesanomalyiqrLayer {
  let result = timeseries_anomaly_iqr_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_layer_sum(s : TimeseriesanomalyiqrLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_iqr_layer_mean(s : TimeseriesanomalyiqrLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_iqr_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_iqr_layer_scale(s : TimeseriesanomalyiqrLayer, f : Double) -> TimeseriesanomalyiqrLayer {
  let result = timeseries_anomaly_iqr_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_iqr_layer_add(a : TimeseriesanomalyiqrLayer, b : TimeseriesanomalyiqrLayer) -> TimeseriesanomalyiqrLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_iqr_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_layer_copy(s : TimeseriesanomalyiqrLayer) -> TimeseriesanomalyiqrLayer {
  let result = timeseries_anomaly_iqr_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_layer_fill(s : TimeseriesanomalyiqrLayer, v : Double) -> TimeseriesanomalyiqrLayer {
  let result = timeseries_anomaly_iqr_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_layer_min(s : TimeseriesanomalyiqrLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_layer_max(s : TimeseriesanomalyiqrLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_layer_to_string(s : TimeseriesanomalyiqrLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_buffer_make(size : Int) -> TimeseriesanomalyiqrBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_buffer_len(s : TimeseriesanomalyiqrBuffer) -> Int { s.size }

pub fn timeseries_anomaly_iqr_buffer_get(s : TimeseriesanomalyiqrBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_buffer_set(s : TimeseriesanomalyiqrBuffer, i : Int, v : Double) -> TimeseriesanomalyiqrBuffer {
  let result = timeseries_anomaly_iqr_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_buffer_sum(s : TimeseriesanomalyiqrBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_iqr_buffer_mean(s : TimeseriesanomalyiqrBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_iqr_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_iqr_buffer_scale(s : TimeseriesanomalyiqrBuffer, f : Double) -> TimeseriesanomalyiqrBuffer {
  let result = timeseries_anomaly_iqr_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_iqr_buffer_add(a : TimeseriesanomalyiqrBuffer, b : TimeseriesanomalyiqrBuffer) -> TimeseriesanomalyiqrBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_iqr_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_buffer_copy(s : TimeseriesanomalyiqrBuffer) -> TimeseriesanomalyiqrBuffer {
  let result = timeseries_anomaly_iqr_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_buffer_fill(s : TimeseriesanomalyiqrBuffer, v : Double) -> TimeseriesanomalyiqrBuffer {
  let result = timeseries_anomaly_iqr_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_buffer_min(s : TimeseriesanomalyiqrBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_buffer_max(s : TimeseriesanomalyiqrBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_buffer_to_string(s : TimeseriesanomalyiqrBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_cursor_make(size : Int) -> TimeseriesanomalyiqrCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_cursor_len(s : TimeseriesanomalyiqrCursor) -> Int { s.size }

pub fn timeseries_anomaly_iqr_cursor_get(s : TimeseriesanomalyiqrCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_cursor_set(s : TimeseriesanomalyiqrCursor, i : Int, v : Double) -> TimeseriesanomalyiqrCursor {
  let result = timeseries_anomaly_iqr_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_cursor_sum(s : TimeseriesanomalyiqrCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_iqr_cursor_mean(s : TimeseriesanomalyiqrCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_iqr_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_iqr_cursor_scale(s : TimeseriesanomalyiqrCursor, f : Double) -> TimeseriesanomalyiqrCursor {
  let result = timeseries_anomaly_iqr_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_iqr_cursor_add(a : TimeseriesanomalyiqrCursor, b : TimeseriesanomalyiqrCursor) -> TimeseriesanomalyiqrCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_iqr_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_cursor_copy(s : TimeseriesanomalyiqrCursor) -> TimeseriesanomalyiqrCursor {
  let result = timeseries_anomaly_iqr_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_cursor_fill(s : TimeseriesanomalyiqrCursor, v : Double) -> TimeseriesanomalyiqrCursor {
  let result = timeseries_anomaly_iqr_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_cursor_min(s : TimeseriesanomalyiqrCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_cursor_max(s : TimeseriesanomalyiqrCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_cursor_to_string(s : TimeseriesanomalyiqrCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_view_make(size : Int) -> TimeseriesanomalyiqrView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_view_len(s : TimeseriesanomalyiqrView) -> Int { s.size }

pub fn timeseries_anomaly_iqr_view_get(s : TimeseriesanomalyiqrView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_view_set(s : TimeseriesanomalyiqrView, i : Int, v : Double) -> TimeseriesanomalyiqrView {
  let result = timeseries_anomaly_iqr_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_view_sum(s : TimeseriesanomalyiqrView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_iqr_view_mean(s : TimeseriesanomalyiqrView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_iqr_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_iqr_view_scale(s : TimeseriesanomalyiqrView, f : Double) -> TimeseriesanomalyiqrView {
  let result = timeseries_anomaly_iqr_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_iqr_view_add(a : TimeseriesanomalyiqrView, b : TimeseriesanomalyiqrView) -> TimeseriesanomalyiqrView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_iqr_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_view_copy(s : TimeseriesanomalyiqrView) -> TimeseriesanomalyiqrView {
  let result = timeseries_anomaly_iqr_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_view_fill(s : TimeseriesanomalyiqrView, v : Double) -> TimeseriesanomalyiqrView {
  let result = timeseries_anomaly_iqr_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_view_min(s : TimeseriesanomalyiqrView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_view_max(s : TimeseriesanomalyiqrView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_view_to_string(s : TimeseriesanomalyiqrView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_range_make(size : Int) -> TimeseriesanomalyiqrRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_range_len(s : TimeseriesanomalyiqrRange) -> Int { s.size }

pub fn timeseries_anomaly_iqr_range_get(s : TimeseriesanomalyiqrRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_range_set(s : TimeseriesanomalyiqrRange, i : Int, v : Double) -> TimeseriesanomalyiqrRange {
  let result = timeseries_anomaly_iqr_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_range_sum(s : TimeseriesanomalyiqrRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_iqr_range_mean(s : TimeseriesanomalyiqrRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_iqr_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_iqr_range_scale(s : TimeseriesanomalyiqrRange, f : Double) -> TimeseriesanomalyiqrRange {
  let result = timeseries_anomaly_iqr_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_iqr_range_add(a : TimeseriesanomalyiqrRange, b : TimeseriesanomalyiqrRange) -> TimeseriesanomalyiqrRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_iqr_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_range_copy(s : TimeseriesanomalyiqrRange) -> TimeseriesanomalyiqrRange {
  let result = timeseries_anomaly_iqr_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_range_fill(s : TimeseriesanomalyiqrRange, v : Double) -> TimeseriesanomalyiqrRange {
  let result = timeseries_anomaly_iqr_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_range_min(s : TimeseriesanomalyiqrRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_range_max(s : TimeseriesanomalyiqrRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_range_to_string(s : TimeseriesanomalyiqrRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_slice_make(size : Int) -> TimeseriesanomalyiqrSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_slice_len(s : TimeseriesanomalyiqrSlice) -> Int { s.size }

pub fn timeseries_anomaly_iqr_slice_get(s : TimeseriesanomalyiqrSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_slice_set(s : TimeseriesanomalyiqrSlice, i : Int, v : Double) -> TimeseriesanomalyiqrSlice {
  let result = timeseries_anomaly_iqr_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_slice_sum(s : TimeseriesanomalyiqrSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_iqr_slice_mean(s : TimeseriesanomalyiqrSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_iqr_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_iqr_slice_scale(s : TimeseriesanomalyiqrSlice, f : Double) -> TimeseriesanomalyiqrSlice {
  let result = timeseries_anomaly_iqr_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_iqr_slice_add(a : TimeseriesanomalyiqrSlice, b : TimeseriesanomalyiqrSlice) -> TimeseriesanomalyiqrSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_iqr_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_slice_copy(s : TimeseriesanomalyiqrSlice) -> TimeseriesanomalyiqrSlice {
  let result = timeseries_anomaly_iqr_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_iqr_slice_fill(s : TimeseriesanomalyiqrSlice, v : Double) -> TimeseriesanomalyiqrSlice {
  let result = timeseries_anomaly_iqr_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_iqr_slice_min(s : TimeseriesanomalyiqrSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_slice_max(s : TimeseriesanomalyiqrSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_iqr_slice_to_string(s : TimeseriesanomalyiqrSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

