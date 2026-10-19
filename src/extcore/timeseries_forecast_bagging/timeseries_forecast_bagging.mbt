///===
/// extcore/timeseries_forecast_bagging

pub(all) struct TimeseriesforecastbaggingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_bagging_make_point(x : Double, y : Double) -> TimeseriesforecastbaggingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_bagging_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastbaggingPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_forecast_bagging_point_x(pt : TimeseriesforecastbaggingPoint) -> Double { pt.x }

pub fn timeseries_forecast_bagging_point_y(pt : TimeseriesforecastbaggingPoint) -> Double { pt.y }

pub fn timeseries_forecast_bagging_point_z(pt : TimeseriesforecastbaggingPoint) -> Double { pt.z }

pub fn timeseries_forecast_bagging_point_label(pt : TimeseriesforecastbaggingPoint) -> Int { pt.label }

pub fn timeseries_forecast_bagging_point_dist(a : TimeseriesforecastbaggingPoint, b : TimeseriesforecastbaggingPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  timeseries_forecast_bagging_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_forecast_bagging_point_add(a : TimeseriesforecastbaggingPoint, b : TimeseriesforecastbaggingPoint) -> TimeseriesforecastbaggingPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_forecast_bagging_point_sub(a : TimeseriesforecastbaggingPoint, b : TimeseriesforecastbaggingPoint) -> TimeseriesforecastbaggingPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_forecast_bagging_point_scale(pt : TimeseriesforecastbaggingPoint, s : Double) -> TimeseriesforecastbaggingPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_forecast_bagging_point_dot(a : TimeseriesforecastbaggingPoint, b : TimeseriesforecastbaggingPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_forecast_bagging_point_cross(a : TimeseriesforecastbaggingPoint, b : TimeseriesforecastbaggingPoint) -> TimeseriesforecastbaggingPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_forecast_bagging_point_norm(pt : TimeseriesforecastbaggingPoint) -> Double {
  timeseries_forecast_bagging_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_forecast_bagging_point_normalize(pt : TimeseriesforecastbaggingPoint) -> TimeseriesforecastbaggingPoint {
  let n = timeseries_forecast_bagging_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_forecast_bagging_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_forecast_bagging_point_negate(pt : TimeseriesforecastbaggingPoint) -> TimeseriesforecastbaggingPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_forecast_bagging_point_mid(a : TimeseriesforecastbaggingPoint, b : TimeseriesforecastbaggingPoint) -> TimeseriesforecastbaggingPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_forecast_bagging_point_lerp(a : TimeseriesforecastbaggingPoint, b : TimeseriesforecastbaggingPoint, t : Double) -> TimeseriesforecastbaggingPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_forecast_bagging_point_to_string(pt : TimeseriesforecastbaggingPoint) -> String {
  "(" + timeseries_forecast_bagging_dbl(pt.x) + ", " + timeseries_forecast_bagging_dbl(pt.y) + ", " + timeseries_forecast_bagging_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_bagging_make_series(vals : Array[Double], name : String) -> TimeseriesforecastbaggingSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_forecast_bagging_series_len(s : TimeseriesforecastbaggingSeries) -> Int { s.vals.length() }

pub fn timeseries_forecast_bagging_series_sum(s : TimeseriesforecastbaggingSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_forecast_bagging_series_mean(s : TimeseriesforecastbaggingSeries) -> Double {
  let n = timeseries_forecast_bagging_series_len(s)
  if n == 0 { 0.0 } else { timeseries_forecast_bagging_series_sum(s) / n.to_double() }
}

pub fn timeseries_forecast_bagging_series_min(s : TimeseriesforecastbaggingSeries) -> Double {
  let n = timeseries_forecast_bagging_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_series_max(s : TimeseriesforecastbaggingSeries) -> Double {
  let n = timeseries_forecast_bagging_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_series_range(s : TimeseriesforecastbaggingSeries) -> Double {
  timeseries_forecast_bagging_series_max(s) - timeseries_forecast_bagging_series_min(s)
}

pub fn timeseries_forecast_bagging_series_var(s : TimeseriesforecastbaggingSeries) -> Double {
  let n = timeseries_forecast_bagging_series_len(s)
  if n == 0 { 0.0 } else {
    let m = timeseries_forecast_bagging_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_series_std(s : TimeseriesforecastbaggingSeries) -> Double { timeseries_forecast_bagging_sqrt(timeseries_forecast_bagging_series_var(s)) }

pub fn timeseries_forecast_bagging_series_median(s : TimeseriesforecastbaggingSeries) -> Double {
  let n = timeseries_forecast_bagging_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = timeseries_forecast_bagging_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_forecast_bagging_series_scale(s : TimeseriesforecastbaggingSeries, f : Double) -> TimeseriesforecastbaggingSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = timeseries_forecast_bagging_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_forecast_bagging_series_add(a : TimeseriesforecastbaggingSeries, b : TimeseriesforecastbaggingSeries) -> TimeseriesforecastbaggingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = timeseries_forecast_bagging_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_bagging_series_sub(a : TimeseriesforecastbaggingSeries, b : TimeseriesforecastbaggingSeries) -> TimeseriesforecastbaggingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = timeseries_forecast_bagging_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_bagging_series_normalize(s : TimeseriesforecastbaggingSeries) -> TimeseriesforecastbaggingSeries {
  let mn = timeseries_forecast_bagging_series_min(s)
  let mx = timeseries_forecast_bagging_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = timeseries_forecast_bagging_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_forecast_bagging_series_cumsum(s : TimeseriesforecastbaggingSeries) -> TimeseriesforecastbaggingSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = timeseries_forecast_bagging_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_forecast_bagging_series_to_string(s : TimeseriesforecastbaggingSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + timeseries_forecast_bagging_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastbaggingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_bagging_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastbaggingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_bagging_matrix_identity(n : Int) -> TimeseriesforecastbaggingMatrix {
  let m = timeseries_forecast_bagging_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_forecast_bagging_matrix_get(m : TimeseriesforecastbaggingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_forecast_bagging_matrix_transpose(m : TimeseriesforecastbaggingMatrix) -> TimeseriesforecastbaggingMatrix {
  let result = timeseries_forecast_bagging_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_forecast_bagging_matrix_add(a : TimeseriesforecastbaggingMatrix, b : TimeseriesforecastbaggingMatrix) -> TimeseriesforecastbaggingMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_forecast_bagging_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_forecast_bagging_matrix_scale(m : TimeseriesforecastbaggingMatrix, s : Double) -> TimeseriesforecastbaggingMatrix {
  let result = timeseries_forecast_bagging_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_forecast_bagging_matrix_multiply(a : TimeseriesforecastbaggingMatrix, b : TimeseriesforecastbaggingMatrix) -> TimeseriesforecastbaggingMatrix {
  if a.cols != b.rows { return timeseries_forecast_bagging_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_forecast_bagging_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_forecast_bagging_matrix_trace(m : TimeseriesforecastbaggingMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_forecast_bagging_matrix_det(m : TimeseriesforecastbaggingMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_forecast_bagging_matrix_norm(m : TimeseriesforecastbaggingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  timeseries_forecast_bagging_sqrt(sum)
}

pub fn timeseries_forecast_bagging_matrix_to_string(m : TimeseriesforecastbaggingMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + timeseries_forecast_bagging_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct TimeseriesforecastbaggingVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_bagging_make_vector(comps : Array[Double]) -> TimeseriesforecastbaggingVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_bagging_vector_zero(dim : Int) -> TimeseriesforecastbaggingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_forecast_bagging_vector_add(a : TimeseriesforecastbaggingVector, b : TimeseriesforecastbaggingVector) -> TimeseriesforecastbaggingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = timeseries_forecast_bagging_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_forecast_bagging_vector_sub(a : TimeseriesforecastbaggingVector, b : TimeseriesforecastbaggingVector) -> TimeseriesforecastbaggingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = timeseries_forecast_bagging_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_forecast_bagging_vector_scale(v : TimeseriesforecastbaggingVector, s : Double) -> TimeseriesforecastbaggingVector {
  let mut result = []
  for i in 0..<v.dim { result = timeseries_forecast_bagging_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_forecast_bagging_vector_dot(a : TimeseriesforecastbaggingVector, b : TimeseriesforecastbaggingVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_forecast_bagging_vector_norm(v : TimeseriesforecastbaggingVector) -> Double { timeseries_forecast_bagging_sqrt(timeseries_forecast_bagging_vector_dot(v, v)) }

pub fn timeseries_forecast_bagging_vector_normalize(v : TimeseriesforecastbaggingVector) -> TimeseriesforecastbaggingVector {
  let n = timeseries_forecast_bagging_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_forecast_bagging_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_forecast_bagging_vector_dist(a : TimeseriesforecastbaggingVector, b : TimeseriesforecastbaggingVector) -> Double {
  timeseries_forecast_bagging_vector_norm(timeseries_forecast_bagging_vector_sub(a, b))
}

pub fn timeseries_forecast_bagging_vector_to_string(v : TimeseriesforecastbaggingVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + timeseries_forecast_bagging_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_bagging_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = timeseries_forecast_bagging_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_std(data : Array[Double]) -> Double { timeseries_forecast_bagging_sqrt(timeseries_forecast_bagging_var(data)) }

pub fn timeseries_forecast_bagging_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = timeseries_forecast_bagging_mean(a); let mb = timeseries_forecast_bagging_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = timeseries_forecast_bagging_std(a); let sb = timeseries_forecast_bagging_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { timeseries_forecast_bagging_cov(a, b) / (sa * sb) }
}

pub fn timeseries_forecast_bagging_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = timeseries_forecast_bagging_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_forecast_bagging_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  timeseries_forecast_bagging_sqrt(timeseries_forecast_bagging_mse(pred, labels))
}

pub fn timeseries_forecast_bagging_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + timeseries_forecast_bagging_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = timeseries_forecast_bagging_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn timeseries_forecast_bagging_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn timeseries_forecast_bagging_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn timeseries_forecast_bagging_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = timeseries_forecast_bagging_precision(pred, labels, pos); let r = timeseries_forecast_bagging_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn timeseries_forecast_bagging_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn timeseries_forecast_bagging_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = timeseries_forecast_bagging_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn timeseries_forecast_bagging_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn timeseries_forecast_bagging_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn timeseries_forecast_bagging_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = timeseries_forecast_bagging_gcd(a, b)
    (a / g) * b
  }
}

pub fn timeseries_forecast_bagging_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn timeseries_forecast_bagging_fibonacci(n : Int) -> Int {
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

pub fn timeseries_forecast_bagging_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = timeseries_forecast_bagging_min(data); let mx = timeseries_forecast_bagging_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn timeseries_forecast_bagging_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = timeseries_forecast_bagging_mean(data); let sd = timeseries_forecast_bagging_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn timeseries_forecast_bagging_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn timeseries_forecast_bagging_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn timeseries_forecast_bagging_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn timeseries_forecast_bagging_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn timeseries_forecast_bagging_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn timeseries_forecast_bagging_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn timeseries_forecast_bagging_dbl(x : Double) -> String {
  let i = if x >= 0.0 { timeseries_forecast_bagging_int(x) } else { -timeseries_forecast_bagging_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { timeseries_forecast_bagging_int(f * 1000000.0) } else { timeseries_forecast_bagging_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn timeseries_forecast_bagging_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn timeseries_forecast_bagging_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct TimeseriesforecastbaggingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_frame_make(size : Int) -> TimeseriesforecastbaggingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_frame_len(s : TimeseriesforecastbaggingFrame) -> Int { s.size }

pub fn timeseries_forecast_bagging_frame_get(s : TimeseriesforecastbaggingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_frame_set(s : TimeseriesforecastbaggingFrame, i : Int, v : Double) -> TimeseriesforecastbaggingFrame {
  let result = timeseries_forecast_bagging_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_frame_sum(s : TimeseriesforecastbaggingFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_frame_mean(s : TimeseriesforecastbaggingFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_frame_scale(s : TimeseriesforecastbaggingFrame, f : Double) -> TimeseriesforecastbaggingFrame {
  let result = timeseries_forecast_bagging_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_frame_add(a : TimeseriesforecastbaggingFrame, b : TimeseriesforecastbaggingFrame) -> TimeseriesforecastbaggingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_frame_copy(s : TimeseriesforecastbaggingFrame) -> TimeseriesforecastbaggingFrame {
  let result = timeseries_forecast_bagging_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_frame_fill(s : TimeseriesforecastbaggingFrame, v : Double) -> TimeseriesforecastbaggingFrame {
  let result = timeseries_forecast_bagging_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_frame_min(s : TimeseriesforecastbaggingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_frame_max(s : TimeseriesforecastbaggingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_frame_to_string(s : TimeseriesforecastbaggingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_table_make(size : Int) -> TimeseriesforecastbaggingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_table_len(s : TimeseriesforecastbaggingTable) -> Int { s.size }

pub fn timeseries_forecast_bagging_table_get(s : TimeseriesforecastbaggingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_table_set(s : TimeseriesforecastbaggingTable, i : Int, v : Double) -> TimeseriesforecastbaggingTable {
  let result = timeseries_forecast_bagging_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_table_sum(s : TimeseriesforecastbaggingTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_table_mean(s : TimeseriesforecastbaggingTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_table_scale(s : TimeseriesforecastbaggingTable, f : Double) -> TimeseriesforecastbaggingTable {
  let result = timeseries_forecast_bagging_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_table_add(a : TimeseriesforecastbaggingTable, b : TimeseriesforecastbaggingTable) -> TimeseriesforecastbaggingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_table_copy(s : TimeseriesforecastbaggingTable) -> TimeseriesforecastbaggingTable {
  let result = timeseries_forecast_bagging_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_table_fill(s : TimeseriesforecastbaggingTable, v : Double) -> TimeseriesforecastbaggingTable {
  let result = timeseries_forecast_bagging_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_table_min(s : TimeseriesforecastbaggingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_table_max(s : TimeseriesforecastbaggingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_table_to_string(s : TimeseriesforecastbaggingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_graphn_make(size : Int) -> TimeseriesforecastbaggingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_graphn_len(s : TimeseriesforecastbaggingGraphN) -> Int { s.size }

pub fn timeseries_forecast_bagging_graphn_get(s : TimeseriesforecastbaggingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_graphn_set(s : TimeseriesforecastbaggingGraphN, i : Int, v : Double) -> TimeseriesforecastbaggingGraphN {
  let result = timeseries_forecast_bagging_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_graphn_sum(s : TimeseriesforecastbaggingGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_graphn_mean(s : TimeseriesforecastbaggingGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_graphn_scale(s : TimeseriesforecastbaggingGraphN, f : Double) -> TimeseriesforecastbaggingGraphN {
  let result = timeseries_forecast_bagging_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_graphn_add(a : TimeseriesforecastbaggingGraphN, b : TimeseriesforecastbaggingGraphN) -> TimeseriesforecastbaggingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_graphn_copy(s : TimeseriesforecastbaggingGraphN) -> TimeseriesforecastbaggingGraphN {
  let result = timeseries_forecast_bagging_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_graphn_fill(s : TimeseriesforecastbaggingGraphN, v : Double) -> TimeseriesforecastbaggingGraphN {
  let result = timeseries_forecast_bagging_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_graphn_min(s : TimeseriesforecastbaggingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_graphn_max(s : TimeseriesforecastbaggingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_graphn_to_string(s : TimeseriesforecastbaggingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_node_make(size : Int) -> TimeseriesforecastbaggingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_node_len(s : TimeseriesforecastbaggingNode) -> Int { s.size }

pub fn timeseries_forecast_bagging_node_get(s : TimeseriesforecastbaggingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_node_set(s : TimeseriesforecastbaggingNode, i : Int, v : Double) -> TimeseriesforecastbaggingNode {
  let result = timeseries_forecast_bagging_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_node_sum(s : TimeseriesforecastbaggingNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_node_mean(s : TimeseriesforecastbaggingNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_node_scale(s : TimeseriesforecastbaggingNode, f : Double) -> TimeseriesforecastbaggingNode {
  let result = timeseries_forecast_bagging_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_node_add(a : TimeseriesforecastbaggingNode, b : TimeseriesforecastbaggingNode) -> TimeseriesforecastbaggingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_node_copy(s : TimeseriesforecastbaggingNode) -> TimeseriesforecastbaggingNode {
  let result = timeseries_forecast_bagging_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_node_fill(s : TimeseriesforecastbaggingNode, v : Double) -> TimeseriesforecastbaggingNode {
  let result = timeseries_forecast_bagging_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_node_min(s : TimeseriesforecastbaggingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_node_max(s : TimeseriesforecastbaggingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_node_to_string(s : TimeseriesforecastbaggingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_edge_make(size : Int) -> TimeseriesforecastbaggingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_edge_len(s : TimeseriesforecastbaggingEdge) -> Int { s.size }

pub fn timeseries_forecast_bagging_edge_get(s : TimeseriesforecastbaggingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_edge_set(s : TimeseriesforecastbaggingEdge, i : Int, v : Double) -> TimeseriesforecastbaggingEdge {
  let result = timeseries_forecast_bagging_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_edge_sum(s : TimeseriesforecastbaggingEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_edge_mean(s : TimeseriesforecastbaggingEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_edge_scale(s : TimeseriesforecastbaggingEdge, f : Double) -> TimeseriesforecastbaggingEdge {
  let result = timeseries_forecast_bagging_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_edge_add(a : TimeseriesforecastbaggingEdge, b : TimeseriesforecastbaggingEdge) -> TimeseriesforecastbaggingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_edge_copy(s : TimeseriesforecastbaggingEdge) -> TimeseriesforecastbaggingEdge {
  let result = timeseries_forecast_bagging_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_edge_fill(s : TimeseriesforecastbaggingEdge, v : Double) -> TimeseriesforecastbaggingEdge {
  let result = timeseries_forecast_bagging_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_edge_min(s : TimeseriesforecastbaggingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_edge_max(s : TimeseriesforecastbaggingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_edge_to_string(s : TimeseriesforecastbaggingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_path_make(size : Int) -> TimeseriesforecastbaggingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_path_len(s : TimeseriesforecastbaggingPath) -> Int { s.size }

pub fn timeseries_forecast_bagging_path_get(s : TimeseriesforecastbaggingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_path_set(s : TimeseriesforecastbaggingPath, i : Int, v : Double) -> TimeseriesforecastbaggingPath {
  let result = timeseries_forecast_bagging_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_path_sum(s : TimeseriesforecastbaggingPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_path_mean(s : TimeseriesforecastbaggingPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_path_scale(s : TimeseriesforecastbaggingPath, f : Double) -> TimeseriesforecastbaggingPath {
  let result = timeseries_forecast_bagging_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_path_add(a : TimeseriesforecastbaggingPath, b : TimeseriesforecastbaggingPath) -> TimeseriesforecastbaggingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_path_copy(s : TimeseriesforecastbaggingPath) -> TimeseriesforecastbaggingPath {
  let result = timeseries_forecast_bagging_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_path_fill(s : TimeseriesforecastbaggingPath, v : Double) -> TimeseriesforecastbaggingPath {
  let result = timeseries_forecast_bagging_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_path_min(s : TimeseriesforecastbaggingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_path_max(s : TimeseriesforecastbaggingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_path_to_string(s : TimeseriesforecastbaggingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_cluster_make(size : Int) -> TimeseriesforecastbaggingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_cluster_len(s : TimeseriesforecastbaggingCluster) -> Int { s.size }

pub fn timeseries_forecast_bagging_cluster_get(s : TimeseriesforecastbaggingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_cluster_set(s : TimeseriesforecastbaggingCluster, i : Int, v : Double) -> TimeseriesforecastbaggingCluster {
  let result = timeseries_forecast_bagging_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_cluster_sum(s : TimeseriesforecastbaggingCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_cluster_mean(s : TimeseriesforecastbaggingCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_cluster_scale(s : TimeseriesforecastbaggingCluster, f : Double) -> TimeseriesforecastbaggingCluster {
  let result = timeseries_forecast_bagging_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_cluster_add(a : TimeseriesforecastbaggingCluster, b : TimeseriesforecastbaggingCluster) -> TimeseriesforecastbaggingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_cluster_copy(s : TimeseriesforecastbaggingCluster) -> TimeseriesforecastbaggingCluster {
  let result = timeseries_forecast_bagging_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_cluster_fill(s : TimeseriesforecastbaggingCluster, v : Double) -> TimeseriesforecastbaggingCluster {
  let result = timeseries_forecast_bagging_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_cluster_min(s : TimeseriesforecastbaggingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_cluster_max(s : TimeseriesforecastbaggingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_cluster_to_string(s : TimeseriesforecastbaggingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_model_make(size : Int) -> TimeseriesforecastbaggingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_model_len(s : TimeseriesforecastbaggingModel) -> Int { s.size }

pub fn timeseries_forecast_bagging_model_get(s : TimeseriesforecastbaggingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_model_set(s : TimeseriesforecastbaggingModel, i : Int, v : Double) -> TimeseriesforecastbaggingModel {
  let result = timeseries_forecast_bagging_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_model_sum(s : TimeseriesforecastbaggingModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_model_mean(s : TimeseriesforecastbaggingModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_model_scale(s : TimeseriesforecastbaggingModel, f : Double) -> TimeseriesforecastbaggingModel {
  let result = timeseries_forecast_bagging_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_model_add(a : TimeseriesforecastbaggingModel, b : TimeseriesforecastbaggingModel) -> TimeseriesforecastbaggingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_model_copy(s : TimeseriesforecastbaggingModel) -> TimeseriesforecastbaggingModel {
  let result = timeseries_forecast_bagging_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_model_fill(s : TimeseriesforecastbaggingModel, v : Double) -> TimeseriesforecastbaggingModel {
  let result = timeseries_forecast_bagging_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_model_min(s : TimeseriesforecastbaggingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_model_max(s : TimeseriesforecastbaggingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_model_to_string(s : TimeseriesforecastbaggingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_layer_make(size : Int) -> TimeseriesforecastbaggingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_layer_len(s : TimeseriesforecastbaggingLayer) -> Int { s.size }

pub fn timeseries_forecast_bagging_layer_get(s : TimeseriesforecastbaggingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_layer_set(s : TimeseriesforecastbaggingLayer, i : Int, v : Double) -> TimeseriesforecastbaggingLayer {
  let result = timeseries_forecast_bagging_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_layer_sum(s : TimeseriesforecastbaggingLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_layer_mean(s : TimeseriesforecastbaggingLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_layer_scale(s : TimeseriesforecastbaggingLayer, f : Double) -> TimeseriesforecastbaggingLayer {
  let result = timeseries_forecast_bagging_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_layer_add(a : TimeseriesforecastbaggingLayer, b : TimeseriesforecastbaggingLayer) -> TimeseriesforecastbaggingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_layer_copy(s : TimeseriesforecastbaggingLayer) -> TimeseriesforecastbaggingLayer {
  let result = timeseries_forecast_bagging_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_layer_fill(s : TimeseriesforecastbaggingLayer, v : Double) -> TimeseriesforecastbaggingLayer {
  let result = timeseries_forecast_bagging_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_layer_min(s : TimeseriesforecastbaggingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_layer_max(s : TimeseriesforecastbaggingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_layer_to_string(s : TimeseriesforecastbaggingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_buffer_make(size : Int) -> TimeseriesforecastbaggingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_buffer_len(s : TimeseriesforecastbaggingBuffer) -> Int { s.size }

pub fn timeseries_forecast_bagging_buffer_get(s : TimeseriesforecastbaggingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_buffer_set(s : TimeseriesforecastbaggingBuffer, i : Int, v : Double) -> TimeseriesforecastbaggingBuffer {
  let result = timeseries_forecast_bagging_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_buffer_sum(s : TimeseriesforecastbaggingBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_buffer_mean(s : TimeseriesforecastbaggingBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_buffer_scale(s : TimeseriesforecastbaggingBuffer, f : Double) -> TimeseriesforecastbaggingBuffer {
  let result = timeseries_forecast_bagging_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_buffer_add(a : TimeseriesforecastbaggingBuffer, b : TimeseriesforecastbaggingBuffer) -> TimeseriesforecastbaggingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_buffer_copy(s : TimeseriesforecastbaggingBuffer) -> TimeseriesforecastbaggingBuffer {
  let result = timeseries_forecast_bagging_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_buffer_fill(s : TimeseriesforecastbaggingBuffer, v : Double) -> TimeseriesforecastbaggingBuffer {
  let result = timeseries_forecast_bagging_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_buffer_min(s : TimeseriesforecastbaggingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_buffer_max(s : TimeseriesforecastbaggingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_buffer_to_string(s : TimeseriesforecastbaggingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_cursor_make(size : Int) -> TimeseriesforecastbaggingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_cursor_len(s : TimeseriesforecastbaggingCursor) -> Int { s.size }

pub fn timeseries_forecast_bagging_cursor_get(s : TimeseriesforecastbaggingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_cursor_set(s : TimeseriesforecastbaggingCursor, i : Int, v : Double) -> TimeseriesforecastbaggingCursor {
  let result = timeseries_forecast_bagging_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_cursor_sum(s : TimeseriesforecastbaggingCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_cursor_mean(s : TimeseriesforecastbaggingCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_cursor_scale(s : TimeseriesforecastbaggingCursor, f : Double) -> TimeseriesforecastbaggingCursor {
  let result = timeseries_forecast_bagging_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_cursor_add(a : TimeseriesforecastbaggingCursor, b : TimeseriesforecastbaggingCursor) -> TimeseriesforecastbaggingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_cursor_copy(s : TimeseriesforecastbaggingCursor) -> TimeseriesforecastbaggingCursor {
  let result = timeseries_forecast_bagging_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_cursor_fill(s : TimeseriesforecastbaggingCursor, v : Double) -> TimeseriesforecastbaggingCursor {
  let result = timeseries_forecast_bagging_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_cursor_min(s : TimeseriesforecastbaggingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_cursor_max(s : TimeseriesforecastbaggingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_cursor_to_string(s : TimeseriesforecastbaggingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_view_make(size : Int) -> TimeseriesforecastbaggingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_view_len(s : TimeseriesforecastbaggingView) -> Int { s.size }

pub fn timeseries_forecast_bagging_view_get(s : TimeseriesforecastbaggingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_view_set(s : TimeseriesforecastbaggingView, i : Int, v : Double) -> TimeseriesforecastbaggingView {
  let result = timeseries_forecast_bagging_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_view_sum(s : TimeseriesforecastbaggingView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_view_mean(s : TimeseriesforecastbaggingView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_view_scale(s : TimeseriesforecastbaggingView, f : Double) -> TimeseriesforecastbaggingView {
  let result = timeseries_forecast_bagging_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_view_add(a : TimeseriesforecastbaggingView, b : TimeseriesforecastbaggingView) -> TimeseriesforecastbaggingView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_view_copy(s : TimeseriesforecastbaggingView) -> TimeseriesforecastbaggingView {
  let result = timeseries_forecast_bagging_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_view_fill(s : TimeseriesforecastbaggingView, v : Double) -> TimeseriesforecastbaggingView {
  let result = timeseries_forecast_bagging_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_view_min(s : TimeseriesforecastbaggingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_view_max(s : TimeseriesforecastbaggingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_view_to_string(s : TimeseriesforecastbaggingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_range_make(size : Int) -> TimeseriesforecastbaggingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_range_len(s : TimeseriesforecastbaggingRange) -> Int { s.size }

pub fn timeseries_forecast_bagging_range_get(s : TimeseriesforecastbaggingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_range_set(s : TimeseriesforecastbaggingRange, i : Int, v : Double) -> TimeseriesforecastbaggingRange {
  let result = timeseries_forecast_bagging_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_range_sum(s : TimeseriesforecastbaggingRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_range_mean(s : TimeseriesforecastbaggingRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_range_scale(s : TimeseriesforecastbaggingRange, f : Double) -> TimeseriesforecastbaggingRange {
  let result = timeseries_forecast_bagging_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_range_add(a : TimeseriesforecastbaggingRange, b : TimeseriesforecastbaggingRange) -> TimeseriesforecastbaggingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_range_copy(s : TimeseriesforecastbaggingRange) -> TimeseriesforecastbaggingRange {
  let result = timeseries_forecast_bagging_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_range_fill(s : TimeseriesforecastbaggingRange, v : Double) -> TimeseriesforecastbaggingRange {
  let result = timeseries_forecast_bagging_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_range_min(s : TimeseriesforecastbaggingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_range_max(s : TimeseriesforecastbaggingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_range_to_string(s : TimeseriesforecastbaggingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_slice_make(size : Int) -> TimeseriesforecastbaggingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_slice_len(s : TimeseriesforecastbaggingSlice) -> Int { s.size }

pub fn timeseries_forecast_bagging_slice_get(s : TimeseriesforecastbaggingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_slice_set(s : TimeseriesforecastbaggingSlice, i : Int, v : Double) -> TimeseriesforecastbaggingSlice {
  let result = timeseries_forecast_bagging_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_slice_sum(s : TimeseriesforecastbaggingSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_slice_mean(s : TimeseriesforecastbaggingSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_slice_scale(s : TimeseriesforecastbaggingSlice, f : Double) -> TimeseriesforecastbaggingSlice {
  let result = timeseries_forecast_bagging_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_slice_add(a : TimeseriesforecastbaggingSlice, b : TimeseriesforecastbaggingSlice) -> TimeseriesforecastbaggingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_slice_copy(s : TimeseriesforecastbaggingSlice) -> TimeseriesforecastbaggingSlice {
  let result = timeseries_forecast_bagging_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_slice_fill(s : TimeseriesforecastbaggingSlice, v : Double) -> TimeseriesforecastbaggingSlice {
  let result = timeseries_forecast_bagging_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_slice_min(s : TimeseriesforecastbaggingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_slice_max(s : TimeseriesforecastbaggingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_slice_to_string(s : TimeseriesforecastbaggingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn timeseries_forecast_bagging_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_bagging_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

