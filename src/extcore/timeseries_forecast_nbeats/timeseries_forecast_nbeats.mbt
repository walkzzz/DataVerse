///===
/// extcore/timeseries_forecast_nbeats

pub(all) struct TimeseriesforecastnbeatsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_nbeats_make_point(x : Double, y : Double) -> TimeseriesforecastnbeatsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_nbeats_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastnbeatsPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_forecast_nbeats_point_x(pt : TimeseriesforecastnbeatsPoint) -> Double { pt.x }

pub fn timeseries_forecast_nbeats_point_y(pt : TimeseriesforecastnbeatsPoint) -> Double { pt.y }

pub fn timeseries_forecast_nbeats_point_z(pt : TimeseriesforecastnbeatsPoint) -> Double { pt.z }

pub fn timeseries_forecast_nbeats_point_label(pt : TimeseriesforecastnbeatsPoint) -> Int { pt.label }

pub fn timeseries_forecast_nbeats_point_dist(a : TimeseriesforecastnbeatsPoint, b : TimeseriesforecastnbeatsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_forecast_nbeats_point_add(a : TimeseriesforecastnbeatsPoint, b : TimeseriesforecastnbeatsPoint) -> TimeseriesforecastnbeatsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_forecast_nbeats_point_sub(a : TimeseriesforecastnbeatsPoint, b : TimeseriesforecastnbeatsPoint) -> TimeseriesforecastnbeatsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_forecast_nbeats_point_scale(pt : TimeseriesforecastnbeatsPoint, s : Double) -> TimeseriesforecastnbeatsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_forecast_nbeats_point_dot(a : TimeseriesforecastnbeatsPoint, b : TimeseriesforecastnbeatsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_forecast_nbeats_point_cross(a : TimeseriesforecastnbeatsPoint, b : TimeseriesforecastnbeatsPoint) -> TimeseriesforecastnbeatsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_forecast_nbeats_point_norm(pt : TimeseriesforecastnbeatsPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_forecast_nbeats_point_normalize(pt : TimeseriesforecastnbeatsPoint) -> TimeseriesforecastnbeatsPoint {
  let n = timeseries_forecast_nbeats_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_forecast_nbeats_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_forecast_nbeats_point_negate(pt : TimeseriesforecastnbeatsPoint) -> TimeseriesforecastnbeatsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_forecast_nbeats_point_mid(a : TimeseriesforecastnbeatsPoint, b : TimeseriesforecastnbeatsPoint) -> TimeseriesforecastnbeatsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_forecast_nbeats_point_lerp(a : TimeseriesforecastnbeatsPoint, b : TimeseriesforecastnbeatsPoint, t : Double) -> TimeseriesforecastnbeatsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_forecast_nbeats_point_to_string(pt : TimeseriesforecastnbeatsPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_nbeats_make_series(vals : Array[Double], name : String) -> TimeseriesforecastnbeatsSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_forecast_nbeats_series_len(s : TimeseriesforecastnbeatsSeries) -> Int { s.vals.length() }

pub fn timeseries_forecast_nbeats_series_sum(s : TimeseriesforecastnbeatsSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_forecast_nbeats_series_mean(s : TimeseriesforecastnbeatsSeries) -> Double {
  let n = timeseries_forecast_nbeats_series_len(s)
  if n == 0 { 0.0 } else { timeseries_forecast_nbeats_series_sum(s) / n.to_double() }
}

pub fn timeseries_forecast_nbeats_series_min(s : TimeseriesforecastnbeatsSeries) -> Double {
  let n = timeseries_forecast_nbeats_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_series_max(s : TimeseriesforecastnbeatsSeries) -> Double {
  let n = timeseries_forecast_nbeats_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_series_range(s : TimeseriesforecastnbeatsSeries) -> Double {
  timeseries_forecast_nbeats_series_max(s) - timeseries_forecast_nbeats_series_min(s)
}

pub fn timeseries_forecast_nbeats_series_var(s : TimeseriesforecastnbeatsSeries) -> Double {
  let n = timeseries_forecast_nbeats_series_len(s)
  if n == 0 { 0.0 } else {
    let m = timeseries_forecast_nbeats_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn timeseries_forecast_nbeats_series_std(s : TimeseriesforecastnbeatsSeries) -> Double { @_common.sqrt(timeseries_forecast_nbeats_series_var(s)) }

pub fn timeseries_forecast_nbeats_series_median(s : TimeseriesforecastnbeatsSeries) -> Double {
  let n = timeseries_forecast_nbeats_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = timeseries_forecast_nbeats_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_forecast_nbeats_series_scale(s : TimeseriesforecastnbeatsSeries, f : Double) -> TimeseriesforecastnbeatsSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_forecast_nbeats_series_add(a : TimeseriesforecastnbeatsSeries, b : TimeseriesforecastnbeatsSeries) -> TimeseriesforecastnbeatsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_nbeats_series_sub(a : TimeseriesforecastnbeatsSeries, b : TimeseriesforecastnbeatsSeries) -> TimeseriesforecastnbeatsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_nbeats_series_normalize(s : TimeseriesforecastnbeatsSeries) -> TimeseriesforecastnbeatsSeries {
  let mn = timeseries_forecast_nbeats_series_min(s)
  let mx = timeseries_forecast_nbeats_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_forecast_nbeats_series_cumsum(s : TimeseriesforecastnbeatsSeries) -> TimeseriesforecastnbeatsSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_forecast_nbeats_series_to_string(s : TimeseriesforecastnbeatsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastnbeatsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_nbeats_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastnbeatsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_nbeats_matrix_identity(n : Int) -> TimeseriesforecastnbeatsMatrix {
  let m = timeseries_forecast_nbeats_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_forecast_nbeats_matrix_get(m : TimeseriesforecastnbeatsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_forecast_nbeats_matrix_transpose(m : TimeseriesforecastnbeatsMatrix) -> TimeseriesforecastnbeatsMatrix {
  let result = timeseries_forecast_nbeats_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_forecast_nbeats_matrix_add(a : TimeseriesforecastnbeatsMatrix, b : TimeseriesforecastnbeatsMatrix) -> TimeseriesforecastnbeatsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_forecast_nbeats_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_forecast_nbeats_matrix_scale(m : TimeseriesforecastnbeatsMatrix, s : Double) -> TimeseriesforecastnbeatsMatrix {
  let result = timeseries_forecast_nbeats_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_forecast_nbeats_matrix_multiply(a : TimeseriesforecastnbeatsMatrix, b : TimeseriesforecastnbeatsMatrix) -> TimeseriesforecastnbeatsMatrix {
  if a.cols != b.rows { return timeseries_forecast_nbeats_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_forecast_nbeats_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_forecast_nbeats_matrix_trace(m : TimeseriesforecastnbeatsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_forecast_nbeats_matrix_det(m : TimeseriesforecastnbeatsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_forecast_nbeats_matrix_norm(m : TimeseriesforecastnbeatsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_forecast_nbeats_matrix_to_string(m : TimeseriesforecastnbeatsMatrix) -> String {
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

pub(all) struct TimeseriesforecastnbeatsVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_nbeats_make_vector(comps : Array[Double]) -> TimeseriesforecastnbeatsVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_nbeats_vector_zero(dim : Int) -> TimeseriesforecastnbeatsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_forecast_nbeats_vector_add(a : TimeseriesforecastnbeatsVector, b : TimeseriesforecastnbeatsVector) -> TimeseriesforecastnbeatsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_forecast_nbeats_vector_sub(a : TimeseriesforecastnbeatsVector, b : TimeseriesforecastnbeatsVector) -> TimeseriesforecastnbeatsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_forecast_nbeats_vector_scale(v : TimeseriesforecastnbeatsVector, s : Double) -> TimeseriesforecastnbeatsVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_forecast_nbeats_vector_dot(a : TimeseriesforecastnbeatsVector, b : TimeseriesforecastnbeatsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_forecast_nbeats_vector_norm(v : TimeseriesforecastnbeatsVector) -> Double { @_common.sqrt(timeseries_forecast_nbeats_vector_dot(v, v)) }

pub fn timeseries_forecast_nbeats_vector_normalize(v : TimeseriesforecastnbeatsVector) -> TimeseriesforecastnbeatsVector {
  let n = timeseries_forecast_nbeats_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_forecast_nbeats_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_forecast_nbeats_vector_dist(a : TimeseriesforecastnbeatsVector, b : TimeseriesforecastnbeatsVector) -> Double {
  timeseries_forecast_nbeats_vector_norm(timeseries_forecast_nbeats_vector_sub(a, b))
}

pub fn timeseries_forecast_nbeats_vector_to_string(v : TimeseriesforecastnbeatsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_nbeats_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_nbeats_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = timeseries_forecast_nbeats_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_nbeats_std(data : Array[Double]) -> Double { @_common.sqrt(timeseries_forecast_nbeats_var(data)) }

pub fn timeseries_forecast_nbeats_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = timeseries_forecast_nbeats_mean(a); let mb = timeseries_forecast_nbeats_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_nbeats_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = timeseries_forecast_nbeats_std(a); let sb = timeseries_forecast_nbeats_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { timeseries_forecast_nbeats_cov(a, b) / (sa * sb) }
}

pub fn timeseries_forecast_nbeats_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = timeseries_forecast_nbeats_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_forecast_nbeats_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn timeseries_forecast_nbeats_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_nbeats_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(timeseries_forecast_nbeats_mse(pred, labels))
}

pub fn timeseries_forecast_nbeats_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_nbeats_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = timeseries_forecast_nbeats_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn timeseries_forecast_nbeats_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn timeseries_forecast_nbeats_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn timeseries_forecast_nbeats_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = timeseries_forecast_nbeats_precision(pred, labels, pos); let r = timeseries_forecast_nbeats_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn timeseries_forecast_nbeats_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn timeseries_forecast_nbeats_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = timeseries_forecast_nbeats_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn timeseries_forecast_nbeats_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn timeseries_forecast_nbeats_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn timeseries_forecast_nbeats_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = timeseries_forecast_nbeats_gcd(a, b)
    (a / g) * b
  }
}

pub fn timeseries_forecast_nbeats_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn timeseries_forecast_nbeats_fibonacci(n : Int) -> Int {
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

pub fn timeseries_forecast_nbeats_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = timeseries_forecast_nbeats_min(data); let mx = timeseries_forecast_nbeats_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn timeseries_forecast_nbeats_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = timeseries_forecast_nbeats_mean(data); let sd = timeseries_forecast_nbeats_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn timeseries_forecast_nbeats_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn timeseries_forecast_nbeats_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn timeseries_forecast_nbeats_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn timeseries_forecast_nbeats_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct TimeseriesforecastnbeatsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_frame_make(size : Int) -> TimeseriesforecastnbeatsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_frame_len(s : TimeseriesforecastnbeatsFrame) -> Int { s.size }

pub fn timeseries_forecast_nbeats_frame_get(s : TimeseriesforecastnbeatsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_frame_set(s : TimeseriesforecastnbeatsFrame, i : Int, v : Double) -> TimeseriesforecastnbeatsFrame {
  let result = timeseries_forecast_nbeats_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_frame_sum(s : TimeseriesforecastnbeatsFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_nbeats_frame_mean(s : TimeseriesforecastnbeatsFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_nbeats_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_nbeats_frame_scale(s : TimeseriesforecastnbeatsFrame, f : Double) -> TimeseriesforecastnbeatsFrame {
  let result = timeseries_forecast_nbeats_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_nbeats_frame_add(a : TimeseriesforecastnbeatsFrame, b : TimeseriesforecastnbeatsFrame) -> TimeseriesforecastnbeatsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_nbeats_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_frame_copy(s : TimeseriesforecastnbeatsFrame) -> TimeseriesforecastnbeatsFrame {
  let result = timeseries_forecast_nbeats_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_frame_fill(s : TimeseriesforecastnbeatsFrame, v : Double) -> TimeseriesforecastnbeatsFrame {
  let result = timeseries_forecast_nbeats_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_frame_min(s : TimeseriesforecastnbeatsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_frame_max(s : TimeseriesforecastnbeatsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_frame_to_string(s : TimeseriesforecastnbeatsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_table_make(size : Int) -> TimeseriesforecastnbeatsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_table_len(s : TimeseriesforecastnbeatsTable) -> Int { s.size }

pub fn timeseries_forecast_nbeats_table_get(s : TimeseriesforecastnbeatsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_table_set(s : TimeseriesforecastnbeatsTable, i : Int, v : Double) -> TimeseriesforecastnbeatsTable {
  let result = timeseries_forecast_nbeats_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_table_sum(s : TimeseriesforecastnbeatsTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_nbeats_table_mean(s : TimeseriesforecastnbeatsTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_nbeats_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_nbeats_table_scale(s : TimeseriesforecastnbeatsTable, f : Double) -> TimeseriesforecastnbeatsTable {
  let result = timeseries_forecast_nbeats_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_nbeats_table_add(a : TimeseriesforecastnbeatsTable, b : TimeseriesforecastnbeatsTable) -> TimeseriesforecastnbeatsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_nbeats_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_table_copy(s : TimeseriesforecastnbeatsTable) -> TimeseriesforecastnbeatsTable {
  let result = timeseries_forecast_nbeats_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_table_fill(s : TimeseriesforecastnbeatsTable, v : Double) -> TimeseriesforecastnbeatsTable {
  let result = timeseries_forecast_nbeats_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_table_min(s : TimeseriesforecastnbeatsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_table_max(s : TimeseriesforecastnbeatsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_table_to_string(s : TimeseriesforecastnbeatsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_graphn_make(size : Int) -> TimeseriesforecastnbeatsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_graphn_len(s : TimeseriesforecastnbeatsGraphN) -> Int { s.size }

pub fn timeseries_forecast_nbeats_graphn_get(s : TimeseriesforecastnbeatsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_graphn_set(s : TimeseriesforecastnbeatsGraphN, i : Int, v : Double) -> TimeseriesforecastnbeatsGraphN {
  let result = timeseries_forecast_nbeats_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_graphn_sum(s : TimeseriesforecastnbeatsGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_nbeats_graphn_mean(s : TimeseriesforecastnbeatsGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_nbeats_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_nbeats_graphn_scale(s : TimeseriesforecastnbeatsGraphN, f : Double) -> TimeseriesforecastnbeatsGraphN {
  let result = timeseries_forecast_nbeats_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_nbeats_graphn_add(a : TimeseriesforecastnbeatsGraphN, b : TimeseriesforecastnbeatsGraphN) -> TimeseriesforecastnbeatsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_nbeats_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_graphn_copy(s : TimeseriesforecastnbeatsGraphN) -> TimeseriesforecastnbeatsGraphN {
  let result = timeseries_forecast_nbeats_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_graphn_fill(s : TimeseriesforecastnbeatsGraphN, v : Double) -> TimeseriesforecastnbeatsGraphN {
  let result = timeseries_forecast_nbeats_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_graphn_min(s : TimeseriesforecastnbeatsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_graphn_max(s : TimeseriesforecastnbeatsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_graphn_to_string(s : TimeseriesforecastnbeatsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_node_make(size : Int) -> TimeseriesforecastnbeatsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_node_len(s : TimeseriesforecastnbeatsNode) -> Int { s.size }

pub fn timeseries_forecast_nbeats_node_get(s : TimeseriesforecastnbeatsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_node_set(s : TimeseriesforecastnbeatsNode, i : Int, v : Double) -> TimeseriesforecastnbeatsNode {
  let result = timeseries_forecast_nbeats_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_node_sum(s : TimeseriesforecastnbeatsNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_nbeats_node_mean(s : TimeseriesforecastnbeatsNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_nbeats_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_nbeats_node_scale(s : TimeseriesforecastnbeatsNode, f : Double) -> TimeseriesforecastnbeatsNode {
  let result = timeseries_forecast_nbeats_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_nbeats_node_add(a : TimeseriesforecastnbeatsNode, b : TimeseriesforecastnbeatsNode) -> TimeseriesforecastnbeatsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_nbeats_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_node_copy(s : TimeseriesforecastnbeatsNode) -> TimeseriesforecastnbeatsNode {
  let result = timeseries_forecast_nbeats_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_node_fill(s : TimeseriesforecastnbeatsNode, v : Double) -> TimeseriesforecastnbeatsNode {
  let result = timeseries_forecast_nbeats_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_node_min(s : TimeseriesforecastnbeatsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_node_max(s : TimeseriesforecastnbeatsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_node_to_string(s : TimeseriesforecastnbeatsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_edge_make(size : Int) -> TimeseriesforecastnbeatsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_edge_len(s : TimeseriesforecastnbeatsEdge) -> Int { s.size }

pub fn timeseries_forecast_nbeats_edge_get(s : TimeseriesforecastnbeatsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_edge_set(s : TimeseriesforecastnbeatsEdge, i : Int, v : Double) -> TimeseriesforecastnbeatsEdge {
  let result = timeseries_forecast_nbeats_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_edge_sum(s : TimeseriesforecastnbeatsEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_nbeats_edge_mean(s : TimeseriesforecastnbeatsEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_nbeats_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_nbeats_edge_scale(s : TimeseriesforecastnbeatsEdge, f : Double) -> TimeseriesforecastnbeatsEdge {
  let result = timeseries_forecast_nbeats_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_nbeats_edge_add(a : TimeseriesforecastnbeatsEdge, b : TimeseriesforecastnbeatsEdge) -> TimeseriesforecastnbeatsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_nbeats_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_edge_copy(s : TimeseriesforecastnbeatsEdge) -> TimeseriesforecastnbeatsEdge {
  let result = timeseries_forecast_nbeats_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_edge_fill(s : TimeseriesforecastnbeatsEdge, v : Double) -> TimeseriesforecastnbeatsEdge {
  let result = timeseries_forecast_nbeats_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_edge_min(s : TimeseriesforecastnbeatsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_edge_max(s : TimeseriesforecastnbeatsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_edge_to_string(s : TimeseriesforecastnbeatsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_path_make(size : Int) -> TimeseriesforecastnbeatsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_path_len(s : TimeseriesforecastnbeatsPath) -> Int { s.size }

pub fn timeseries_forecast_nbeats_path_get(s : TimeseriesforecastnbeatsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_path_set(s : TimeseriesforecastnbeatsPath, i : Int, v : Double) -> TimeseriesforecastnbeatsPath {
  let result = timeseries_forecast_nbeats_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_path_sum(s : TimeseriesforecastnbeatsPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_nbeats_path_mean(s : TimeseriesforecastnbeatsPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_nbeats_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_nbeats_path_scale(s : TimeseriesforecastnbeatsPath, f : Double) -> TimeseriesforecastnbeatsPath {
  let result = timeseries_forecast_nbeats_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_nbeats_path_add(a : TimeseriesforecastnbeatsPath, b : TimeseriesforecastnbeatsPath) -> TimeseriesforecastnbeatsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_nbeats_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_path_copy(s : TimeseriesforecastnbeatsPath) -> TimeseriesforecastnbeatsPath {
  let result = timeseries_forecast_nbeats_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_path_fill(s : TimeseriesforecastnbeatsPath, v : Double) -> TimeseriesforecastnbeatsPath {
  let result = timeseries_forecast_nbeats_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_path_min(s : TimeseriesforecastnbeatsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_path_max(s : TimeseriesforecastnbeatsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_path_to_string(s : TimeseriesforecastnbeatsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_cluster_make(size : Int) -> TimeseriesforecastnbeatsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_cluster_len(s : TimeseriesforecastnbeatsCluster) -> Int { s.size }

pub fn timeseries_forecast_nbeats_cluster_get(s : TimeseriesforecastnbeatsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_cluster_set(s : TimeseriesforecastnbeatsCluster, i : Int, v : Double) -> TimeseriesforecastnbeatsCluster {
  let result = timeseries_forecast_nbeats_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_cluster_sum(s : TimeseriesforecastnbeatsCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_nbeats_cluster_mean(s : TimeseriesforecastnbeatsCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_nbeats_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_nbeats_cluster_scale(s : TimeseriesforecastnbeatsCluster, f : Double) -> TimeseriesforecastnbeatsCluster {
  let result = timeseries_forecast_nbeats_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_nbeats_cluster_add(a : TimeseriesforecastnbeatsCluster, b : TimeseriesforecastnbeatsCluster) -> TimeseriesforecastnbeatsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_nbeats_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_cluster_copy(s : TimeseriesforecastnbeatsCluster) -> TimeseriesforecastnbeatsCluster {
  let result = timeseries_forecast_nbeats_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_cluster_fill(s : TimeseriesforecastnbeatsCluster, v : Double) -> TimeseriesforecastnbeatsCluster {
  let result = timeseries_forecast_nbeats_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_cluster_min(s : TimeseriesforecastnbeatsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_cluster_max(s : TimeseriesforecastnbeatsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_cluster_to_string(s : TimeseriesforecastnbeatsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_model_make(size : Int) -> TimeseriesforecastnbeatsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_model_len(s : TimeseriesforecastnbeatsModel) -> Int { s.size }

pub fn timeseries_forecast_nbeats_model_get(s : TimeseriesforecastnbeatsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_model_set(s : TimeseriesforecastnbeatsModel, i : Int, v : Double) -> TimeseriesforecastnbeatsModel {
  let result = timeseries_forecast_nbeats_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_model_sum(s : TimeseriesforecastnbeatsModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_nbeats_model_mean(s : TimeseriesforecastnbeatsModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_nbeats_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_nbeats_model_scale(s : TimeseriesforecastnbeatsModel, f : Double) -> TimeseriesforecastnbeatsModel {
  let result = timeseries_forecast_nbeats_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_nbeats_model_add(a : TimeseriesforecastnbeatsModel, b : TimeseriesforecastnbeatsModel) -> TimeseriesforecastnbeatsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_nbeats_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_model_copy(s : TimeseriesforecastnbeatsModel) -> TimeseriesforecastnbeatsModel {
  let result = timeseries_forecast_nbeats_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_model_fill(s : TimeseriesforecastnbeatsModel, v : Double) -> TimeseriesforecastnbeatsModel {
  let result = timeseries_forecast_nbeats_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_model_min(s : TimeseriesforecastnbeatsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_model_max(s : TimeseriesforecastnbeatsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_model_to_string(s : TimeseriesforecastnbeatsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_layer_make(size : Int) -> TimeseriesforecastnbeatsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_layer_len(s : TimeseriesforecastnbeatsLayer) -> Int { s.size }

pub fn timeseries_forecast_nbeats_layer_get(s : TimeseriesforecastnbeatsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_layer_set(s : TimeseriesforecastnbeatsLayer, i : Int, v : Double) -> TimeseriesforecastnbeatsLayer {
  let result = timeseries_forecast_nbeats_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_layer_sum(s : TimeseriesforecastnbeatsLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_nbeats_layer_mean(s : TimeseriesforecastnbeatsLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_nbeats_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_nbeats_layer_scale(s : TimeseriesforecastnbeatsLayer, f : Double) -> TimeseriesforecastnbeatsLayer {
  let result = timeseries_forecast_nbeats_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_nbeats_layer_add(a : TimeseriesforecastnbeatsLayer, b : TimeseriesforecastnbeatsLayer) -> TimeseriesforecastnbeatsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_nbeats_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_layer_copy(s : TimeseriesforecastnbeatsLayer) -> TimeseriesforecastnbeatsLayer {
  let result = timeseries_forecast_nbeats_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_layer_fill(s : TimeseriesforecastnbeatsLayer, v : Double) -> TimeseriesforecastnbeatsLayer {
  let result = timeseries_forecast_nbeats_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_layer_min(s : TimeseriesforecastnbeatsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_layer_max(s : TimeseriesforecastnbeatsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_layer_to_string(s : TimeseriesforecastnbeatsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_buffer_make(size : Int) -> TimeseriesforecastnbeatsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_buffer_len(s : TimeseriesforecastnbeatsBuffer) -> Int { s.size }

pub fn timeseries_forecast_nbeats_buffer_get(s : TimeseriesforecastnbeatsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_buffer_set(s : TimeseriesforecastnbeatsBuffer, i : Int, v : Double) -> TimeseriesforecastnbeatsBuffer {
  let result = timeseries_forecast_nbeats_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_buffer_sum(s : TimeseriesforecastnbeatsBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_nbeats_buffer_mean(s : TimeseriesforecastnbeatsBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_nbeats_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_nbeats_buffer_scale(s : TimeseriesforecastnbeatsBuffer, f : Double) -> TimeseriesforecastnbeatsBuffer {
  let result = timeseries_forecast_nbeats_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_nbeats_buffer_add(a : TimeseriesforecastnbeatsBuffer, b : TimeseriesforecastnbeatsBuffer) -> TimeseriesforecastnbeatsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_nbeats_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_buffer_copy(s : TimeseriesforecastnbeatsBuffer) -> TimeseriesforecastnbeatsBuffer {
  let result = timeseries_forecast_nbeats_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_buffer_fill(s : TimeseriesforecastnbeatsBuffer, v : Double) -> TimeseriesforecastnbeatsBuffer {
  let result = timeseries_forecast_nbeats_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_buffer_min(s : TimeseriesforecastnbeatsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_buffer_max(s : TimeseriesforecastnbeatsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_buffer_to_string(s : TimeseriesforecastnbeatsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_cursor_make(size : Int) -> TimeseriesforecastnbeatsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_cursor_len(s : TimeseriesforecastnbeatsCursor) -> Int { s.size }

pub fn timeseries_forecast_nbeats_cursor_get(s : TimeseriesforecastnbeatsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_cursor_set(s : TimeseriesforecastnbeatsCursor, i : Int, v : Double) -> TimeseriesforecastnbeatsCursor {
  let result = timeseries_forecast_nbeats_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_cursor_sum(s : TimeseriesforecastnbeatsCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_nbeats_cursor_mean(s : TimeseriesforecastnbeatsCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_nbeats_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_nbeats_cursor_scale(s : TimeseriesforecastnbeatsCursor, f : Double) -> TimeseriesforecastnbeatsCursor {
  let result = timeseries_forecast_nbeats_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_nbeats_cursor_add(a : TimeseriesforecastnbeatsCursor, b : TimeseriesforecastnbeatsCursor) -> TimeseriesforecastnbeatsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_nbeats_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_cursor_copy(s : TimeseriesforecastnbeatsCursor) -> TimeseriesforecastnbeatsCursor {
  let result = timeseries_forecast_nbeats_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_cursor_fill(s : TimeseriesforecastnbeatsCursor, v : Double) -> TimeseriesforecastnbeatsCursor {
  let result = timeseries_forecast_nbeats_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_cursor_min(s : TimeseriesforecastnbeatsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_cursor_max(s : TimeseriesforecastnbeatsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_cursor_to_string(s : TimeseriesforecastnbeatsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_view_make(size : Int) -> TimeseriesforecastnbeatsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_view_len(s : TimeseriesforecastnbeatsView) -> Int { s.size }

pub fn timeseries_forecast_nbeats_view_get(s : TimeseriesforecastnbeatsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_view_set(s : TimeseriesforecastnbeatsView, i : Int, v : Double) -> TimeseriesforecastnbeatsView {
  let result = timeseries_forecast_nbeats_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_view_sum(s : TimeseriesforecastnbeatsView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_nbeats_view_mean(s : TimeseriesforecastnbeatsView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_nbeats_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_nbeats_view_scale(s : TimeseriesforecastnbeatsView, f : Double) -> TimeseriesforecastnbeatsView {
  let result = timeseries_forecast_nbeats_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_nbeats_view_add(a : TimeseriesforecastnbeatsView, b : TimeseriesforecastnbeatsView) -> TimeseriesforecastnbeatsView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_nbeats_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_view_copy(s : TimeseriesforecastnbeatsView) -> TimeseriesforecastnbeatsView {
  let result = timeseries_forecast_nbeats_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_view_fill(s : TimeseriesforecastnbeatsView, v : Double) -> TimeseriesforecastnbeatsView {
  let result = timeseries_forecast_nbeats_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_view_min(s : TimeseriesforecastnbeatsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_view_max(s : TimeseriesforecastnbeatsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_view_to_string(s : TimeseriesforecastnbeatsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_range_make(size : Int) -> TimeseriesforecastnbeatsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_range_len(s : TimeseriesforecastnbeatsRange) -> Int { s.size }

pub fn timeseries_forecast_nbeats_range_get(s : TimeseriesforecastnbeatsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_range_set(s : TimeseriesforecastnbeatsRange, i : Int, v : Double) -> TimeseriesforecastnbeatsRange {
  let result = timeseries_forecast_nbeats_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_range_sum(s : TimeseriesforecastnbeatsRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_nbeats_range_mean(s : TimeseriesforecastnbeatsRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_nbeats_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_nbeats_range_scale(s : TimeseriesforecastnbeatsRange, f : Double) -> TimeseriesforecastnbeatsRange {
  let result = timeseries_forecast_nbeats_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_nbeats_range_add(a : TimeseriesforecastnbeatsRange, b : TimeseriesforecastnbeatsRange) -> TimeseriesforecastnbeatsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_nbeats_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_range_copy(s : TimeseriesforecastnbeatsRange) -> TimeseriesforecastnbeatsRange {
  let result = timeseries_forecast_nbeats_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_range_fill(s : TimeseriesforecastnbeatsRange, v : Double) -> TimeseriesforecastnbeatsRange {
  let result = timeseries_forecast_nbeats_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_range_min(s : TimeseriesforecastnbeatsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_range_max(s : TimeseriesforecastnbeatsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_range_to_string(s : TimeseriesforecastnbeatsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_slice_make(size : Int) -> TimeseriesforecastnbeatsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_slice_len(s : TimeseriesforecastnbeatsSlice) -> Int { s.size }

pub fn timeseries_forecast_nbeats_slice_get(s : TimeseriesforecastnbeatsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_slice_set(s : TimeseriesforecastnbeatsSlice, i : Int, v : Double) -> TimeseriesforecastnbeatsSlice {
  let result = timeseries_forecast_nbeats_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_slice_sum(s : TimeseriesforecastnbeatsSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_nbeats_slice_mean(s : TimeseriesforecastnbeatsSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_nbeats_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_nbeats_slice_scale(s : TimeseriesforecastnbeatsSlice, f : Double) -> TimeseriesforecastnbeatsSlice {
  let result = timeseries_forecast_nbeats_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_nbeats_slice_add(a : TimeseriesforecastnbeatsSlice, b : TimeseriesforecastnbeatsSlice) -> TimeseriesforecastnbeatsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_nbeats_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_slice_copy(s : TimeseriesforecastnbeatsSlice) -> TimeseriesforecastnbeatsSlice {
  let result = timeseries_forecast_nbeats_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_nbeats_slice_fill(s : TimeseriesforecastnbeatsSlice, v : Double) -> TimeseriesforecastnbeatsSlice {
  let result = timeseries_forecast_nbeats_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_nbeats_slice_min(s : TimeseriesforecastnbeatsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_slice_max(s : TimeseriesforecastnbeatsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_nbeats_slice_to_string(s : TimeseriesforecastnbeatsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

