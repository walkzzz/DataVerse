///===
/// extcore/timeseries_forecast_stacking

pub(all) struct TimeseriesforecaststackingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_stacking_make_point(x : Double, y : Double) -> TimeseriesforecaststackingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_stacking_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecaststackingPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_forecast_stacking_point_x(pt : TimeseriesforecaststackingPoint) -> Double { pt.x }

pub fn timeseries_forecast_stacking_point_y(pt : TimeseriesforecaststackingPoint) -> Double { pt.y }

pub fn timeseries_forecast_stacking_point_z(pt : TimeseriesforecaststackingPoint) -> Double { pt.z }

pub fn timeseries_forecast_stacking_point_label(pt : TimeseriesforecaststackingPoint) -> Int { pt.label }

pub fn timeseries_forecast_stacking_point_dist(a : TimeseriesforecaststackingPoint, b : TimeseriesforecaststackingPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  timeseries_forecast_stacking_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_forecast_stacking_point_add(a : TimeseriesforecaststackingPoint, b : TimeseriesforecaststackingPoint) -> TimeseriesforecaststackingPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_forecast_stacking_point_sub(a : TimeseriesforecaststackingPoint, b : TimeseriesforecaststackingPoint) -> TimeseriesforecaststackingPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_forecast_stacking_point_scale(pt : TimeseriesforecaststackingPoint, s : Double) -> TimeseriesforecaststackingPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_forecast_stacking_point_dot(a : TimeseriesforecaststackingPoint, b : TimeseriesforecaststackingPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_forecast_stacking_point_cross(a : TimeseriesforecaststackingPoint, b : TimeseriesforecaststackingPoint) -> TimeseriesforecaststackingPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_forecast_stacking_point_norm(pt : TimeseriesforecaststackingPoint) -> Double {
  timeseries_forecast_stacking_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_forecast_stacking_point_normalize(pt : TimeseriesforecaststackingPoint) -> TimeseriesforecaststackingPoint {
  let n = timeseries_forecast_stacking_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_forecast_stacking_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_forecast_stacking_point_negate(pt : TimeseriesforecaststackingPoint) -> TimeseriesforecaststackingPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_forecast_stacking_point_mid(a : TimeseriesforecaststackingPoint, b : TimeseriesforecaststackingPoint) -> TimeseriesforecaststackingPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_forecast_stacking_point_lerp(a : TimeseriesforecaststackingPoint, b : TimeseriesforecaststackingPoint, t : Double) -> TimeseriesforecaststackingPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_forecast_stacking_point_to_string(pt : TimeseriesforecaststackingPoint) -> String {
  "(" + timeseries_forecast_stacking_dbl(pt.x) + ", " + timeseries_forecast_stacking_dbl(pt.y) + ", " + timeseries_forecast_stacking_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_stacking_make_series(vals : Array[Double], name : String) -> TimeseriesforecaststackingSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_forecast_stacking_series_len(s : TimeseriesforecaststackingSeries) -> Int { s.vals.length() }

pub fn timeseries_forecast_stacking_series_sum(s : TimeseriesforecaststackingSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_forecast_stacking_series_mean(s : TimeseriesforecaststackingSeries) -> Double {
  let n = timeseries_forecast_stacking_series_len(s)
  if n == 0 { 0.0 } else { timeseries_forecast_stacking_series_sum(s) / n.to_double() }
}

pub fn timeseries_forecast_stacking_series_min(s : TimeseriesforecaststackingSeries) -> Double {
  let n = timeseries_forecast_stacking_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_series_max(s : TimeseriesforecaststackingSeries) -> Double {
  let n = timeseries_forecast_stacking_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_series_range(s : TimeseriesforecaststackingSeries) -> Double {
  timeseries_forecast_stacking_series_max(s) - timeseries_forecast_stacking_series_min(s)
}

pub fn timeseries_forecast_stacking_series_var(s : TimeseriesforecaststackingSeries) -> Double {
  let n = timeseries_forecast_stacking_series_len(s)
  if n == 0 { 0.0 } else {
    let m = timeseries_forecast_stacking_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_series_std(s : TimeseriesforecaststackingSeries) -> Double { timeseries_forecast_stacking_sqrt(timeseries_forecast_stacking_series_var(s)) }

pub fn timeseries_forecast_stacking_series_median(s : TimeseriesforecaststackingSeries) -> Double {
  let n = timeseries_forecast_stacking_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = timeseries_forecast_stacking_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_forecast_stacking_series_scale(s : TimeseriesforecaststackingSeries, f : Double) -> TimeseriesforecaststackingSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = timeseries_forecast_stacking_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_forecast_stacking_series_add(a : TimeseriesforecaststackingSeries, b : TimeseriesforecaststackingSeries) -> TimeseriesforecaststackingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = timeseries_forecast_stacking_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_stacking_series_sub(a : TimeseriesforecaststackingSeries, b : TimeseriesforecaststackingSeries) -> TimeseriesforecaststackingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = timeseries_forecast_stacking_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_stacking_series_normalize(s : TimeseriesforecaststackingSeries) -> TimeseriesforecaststackingSeries {
  let mn = timeseries_forecast_stacking_series_min(s)
  let mx = timeseries_forecast_stacking_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = timeseries_forecast_stacking_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_forecast_stacking_series_cumsum(s : TimeseriesforecaststackingSeries) -> TimeseriesforecaststackingSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = timeseries_forecast_stacking_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_forecast_stacking_series_to_string(s : TimeseriesforecaststackingSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + timeseries_forecast_stacking_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecaststackingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_stacking_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecaststackingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_stacking_matrix_identity(n : Int) -> TimeseriesforecaststackingMatrix {
  let m = timeseries_forecast_stacking_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_forecast_stacking_matrix_get(m : TimeseriesforecaststackingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_forecast_stacking_matrix_transpose(m : TimeseriesforecaststackingMatrix) -> TimeseriesforecaststackingMatrix {
  let result = timeseries_forecast_stacking_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_forecast_stacking_matrix_add(a : TimeseriesforecaststackingMatrix, b : TimeseriesforecaststackingMatrix) -> TimeseriesforecaststackingMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_forecast_stacking_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_forecast_stacking_matrix_scale(m : TimeseriesforecaststackingMatrix, s : Double) -> TimeseriesforecaststackingMatrix {
  let result = timeseries_forecast_stacking_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_forecast_stacking_matrix_multiply(a : TimeseriesforecaststackingMatrix, b : TimeseriesforecaststackingMatrix) -> TimeseriesforecaststackingMatrix {
  if a.cols != b.rows { return timeseries_forecast_stacking_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_forecast_stacking_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_forecast_stacking_matrix_trace(m : TimeseriesforecaststackingMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_forecast_stacking_matrix_det(m : TimeseriesforecaststackingMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_forecast_stacking_matrix_norm(m : TimeseriesforecaststackingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  timeseries_forecast_stacking_sqrt(sum)
}

pub fn timeseries_forecast_stacking_matrix_to_string(m : TimeseriesforecaststackingMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + timeseries_forecast_stacking_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct TimeseriesforecaststackingVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_stacking_make_vector(comps : Array[Double]) -> TimeseriesforecaststackingVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_stacking_vector_zero(dim : Int) -> TimeseriesforecaststackingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_forecast_stacking_vector_add(a : TimeseriesforecaststackingVector, b : TimeseriesforecaststackingVector) -> TimeseriesforecaststackingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = timeseries_forecast_stacking_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_forecast_stacking_vector_sub(a : TimeseriesforecaststackingVector, b : TimeseriesforecaststackingVector) -> TimeseriesforecaststackingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = timeseries_forecast_stacking_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_forecast_stacking_vector_scale(v : TimeseriesforecaststackingVector, s : Double) -> TimeseriesforecaststackingVector {
  let mut result = []
  for i in 0..<v.dim { result = timeseries_forecast_stacking_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_forecast_stacking_vector_dot(a : TimeseriesforecaststackingVector, b : TimeseriesforecaststackingVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_forecast_stacking_vector_norm(v : TimeseriesforecaststackingVector) -> Double { timeseries_forecast_stacking_sqrt(timeseries_forecast_stacking_vector_dot(v, v)) }

pub fn timeseries_forecast_stacking_vector_normalize(v : TimeseriesforecaststackingVector) -> TimeseriesforecaststackingVector {
  let n = timeseries_forecast_stacking_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_forecast_stacking_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_forecast_stacking_vector_dist(a : TimeseriesforecaststackingVector, b : TimeseriesforecaststackingVector) -> Double {
  timeseries_forecast_stacking_vector_norm(timeseries_forecast_stacking_vector_sub(a, b))
}

pub fn timeseries_forecast_stacking_vector_to_string(v : TimeseriesforecaststackingVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + timeseries_forecast_stacking_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_stacking_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = timeseries_forecast_stacking_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_std(data : Array[Double]) -> Double { timeseries_forecast_stacking_sqrt(timeseries_forecast_stacking_var(data)) }

pub fn timeseries_forecast_stacking_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = timeseries_forecast_stacking_mean(a); let mb = timeseries_forecast_stacking_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = timeseries_forecast_stacking_std(a); let sb = timeseries_forecast_stacking_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { timeseries_forecast_stacking_cov(a, b) / (sa * sb) }
}

pub fn timeseries_forecast_stacking_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = timeseries_forecast_stacking_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_forecast_stacking_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  timeseries_forecast_stacking_sqrt(timeseries_forecast_stacking_mse(pred, labels))
}

pub fn timeseries_forecast_stacking_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + timeseries_forecast_stacking_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = timeseries_forecast_stacking_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn timeseries_forecast_stacking_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn timeseries_forecast_stacking_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn timeseries_forecast_stacking_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = timeseries_forecast_stacking_precision(pred, labels, pos); let r = timeseries_forecast_stacking_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn timeseries_forecast_stacking_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn timeseries_forecast_stacking_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = timeseries_forecast_stacking_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn timeseries_forecast_stacking_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn timeseries_forecast_stacking_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn timeseries_forecast_stacking_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = timeseries_forecast_stacking_gcd(a, b)
    (a / g) * b
  }
}

pub fn timeseries_forecast_stacking_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn timeseries_forecast_stacking_fibonacci(n : Int) -> Int {
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

pub fn timeseries_forecast_stacking_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = timeseries_forecast_stacking_min(data); let mx = timeseries_forecast_stacking_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn timeseries_forecast_stacking_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = timeseries_forecast_stacking_mean(data); let sd = timeseries_forecast_stacking_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn timeseries_forecast_stacking_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn timeseries_forecast_stacking_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn timeseries_forecast_stacking_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn timeseries_forecast_stacking_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn timeseries_forecast_stacking_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn timeseries_forecast_stacking_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn timeseries_forecast_stacking_dbl(x : Double) -> String {
  let i = if x >= 0.0 { timeseries_forecast_stacking_int(x) } else { -timeseries_forecast_stacking_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { timeseries_forecast_stacking_int(f * 1000000.0) } else { timeseries_forecast_stacking_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn timeseries_forecast_stacking_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn timeseries_forecast_stacking_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct TimeseriesforecaststackingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_frame_make(size : Int) -> TimeseriesforecaststackingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_frame_len(s : TimeseriesforecaststackingFrame) -> Int { s.size }

pub fn timeseries_forecast_stacking_frame_get(s : TimeseriesforecaststackingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_frame_set(s : TimeseriesforecaststackingFrame, i : Int, v : Double) -> TimeseriesforecaststackingFrame {
  let result = timeseries_forecast_stacking_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_frame_sum(s : TimeseriesforecaststackingFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_stacking_frame_mean(s : TimeseriesforecaststackingFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_stacking_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_stacking_frame_scale(s : TimeseriesforecaststackingFrame, f : Double) -> TimeseriesforecaststackingFrame {
  let result = timeseries_forecast_stacking_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_stacking_frame_add(a : TimeseriesforecaststackingFrame, b : TimeseriesforecaststackingFrame) -> TimeseriesforecaststackingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_stacking_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_stacking_frame_copy(s : TimeseriesforecaststackingFrame) -> TimeseriesforecaststackingFrame {
  let result = timeseries_forecast_stacking_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_stacking_frame_fill(s : TimeseriesforecaststackingFrame, v : Double) -> TimeseriesforecaststackingFrame {
  let result = timeseries_forecast_stacking_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_frame_min(s : TimeseriesforecaststackingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_frame_max(s : TimeseriesforecaststackingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_frame_to_string(s : TimeseriesforecaststackingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_table_make(size : Int) -> TimeseriesforecaststackingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_table_len(s : TimeseriesforecaststackingTable) -> Int { s.size }

pub fn timeseries_forecast_stacking_table_get(s : TimeseriesforecaststackingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_table_set(s : TimeseriesforecaststackingTable, i : Int, v : Double) -> TimeseriesforecaststackingTable {
  let result = timeseries_forecast_stacking_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_table_sum(s : TimeseriesforecaststackingTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_stacking_table_mean(s : TimeseriesforecaststackingTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_stacking_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_stacking_table_scale(s : TimeseriesforecaststackingTable, f : Double) -> TimeseriesforecaststackingTable {
  let result = timeseries_forecast_stacking_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_stacking_table_add(a : TimeseriesforecaststackingTable, b : TimeseriesforecaststackingTable) -> TimeseriesforecaststackingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_stacking_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_stacking_table_copy(s : TimeseriesforecaststackingTable) -> TimeseriesforecaststackingTable {
  let result = timeseries_forecast_stacking_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_stacking_table_fill(s : TimeseriesforecaststackingTable, v : Double) -> TimeseriesforecaststackingTable {
  let result = timeseries_forecast_stacking_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_table_min(s : TimeseriesforecaststackingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_table_max(s : TimeseriesforecaststackingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_table_to_string(s : TimeseriesforecaststackingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_graphn_make(size : Int) -> TimeseriesforecaststackingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_graphn_len(s : TimeseriesforecaststackingGraphN) -> Int { s.size }

pub fn timeseries_forecast_stacking_graphn_get(s : TimeseriesforecaststackingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_graphn_set(s : TimeseriesforecaststackingGraphN, i : Int, v : Double) -> TimeseriesforecaststackingGraphN {
  let result = timeseries_forecast_stacking_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_graphn_sum(s : TimeseriesforecaststackingGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_stacking_graphn_mean(s : TimeseriesforecaststackingGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_stacking_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_stacking_graphn_scale(s : TimeseriesforecaststackingGraphN, f : Double) -> TimeseriesforecaststackingGraphN {
  let result = timeseries_forecast_stacking_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_stacking_graphn_add(a : TimeseriesforecaststackingGraphN, b : TimeseriesforecaststackingGraphN) -> TimeseriesforecaststackingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_stacking_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_stacking_graphn_copy(s : TimeseriesforecaststackingGraphN) -> TimeseriesforecaststackingGraphN {
  let result = timeseries_forecast_stacking_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_stacking_graphn_fill(s : TimeseriesforecaststackingGraphN, v : Double) -> TimeseriesforecaststackingGraphN {
  let result = timeseries_forecast_stacking_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_graphn_min(s : TimeseriesforecaststackingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_graphn_max(s : TimeseriesforecaststackingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_graphn_to_string(s : TimeseriesforecaststackingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_node_make(size : Int) -> TimeseriesforecaststackingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_node_len(s : TimeseriesforecaststackingNode) -> Int { s.size }

pub fn timeseries_forecast_stacking_node_get(s : TimeseriesforecaststackingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_node_set(s : TimeseriesforecaststackingNode, i : Int, v : Double) -> TimeseriesforecaststackingNode {
  let result = timeseries_forecast_stacking_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_node_sum(s : TimeseriesforecaststackingNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_stacking_node_mean(s : TimeseriesforecaststackingNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_stacking_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_stacking_node_scale(s : TimeseriesforecaststackingNode, f : Double) -> TimeseriesforecaststackingNode {
  let result = timeseries_forecast_stacking_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_stacking_node_add(a : TimeseriesforecaststackingNode, b : TimeseriesforecaststackingNode) -> TimeseriesforecaststackingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_stacking_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_stacking_node_copy(s : TimeseriesforecaststackingNode) -> TimeseriesforecaststackingNode {
  let result = timeseries_forecast_stacking_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_stacking_node_fill(s : TimeseriesforecaststackingNode, v : Double) -> TimeseriesforecaststackingNode {
  let result = timeseries_forecast_stacking_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_node_min(s : TimeseriesforecaststackingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_node_max(s : TimeseriesforecaststackingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_node_to_string(s : TimeseriesforecaststackingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_edge_make(size : Int) -> TimeseriesforecaststackingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_edge_len(s : TimeseriesforecaststackingEdge) -> Int { s.size }

pub fn timeseries_forecast_stacking_edge_get(s : TimeseriesforecaststackingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_edge_set(s : TimeseriesforecaststackingEdge, i : Int, v : Double) -> TimeseriesforecaststackingEdge {
  let result = timeseries_forecast_stacking_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_edge_sum(s : TimeseriesforecaststackingEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_stacking_edge_mean(s : TimeseriesforecaststackingEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_stacking_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_stacking_edge_scale(s : TimeseriesforecaststackingEdge, f : Double) -> TimeseriesforecaststackingEdge {
  let result = timeseries_forecast_stacking_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_stacking_edge_add(a : TimeseriesforecaststackingEdge, b : TimeseriesforecaststackingEdge) -> TimeseriesforecaststackingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_stacking_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_stacking_edge_copy(s : TimeseriesforecaststackingEdge) -> TimeseriesforecaststackingEdge {
  let result = timeseries_forecast_stacking_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_stacking_edge_fill(s : TimeseriesforecaststackingEdge, v : Double) -> TimeseriesforecaststackingEdge {
  let result = timeseries_forecast_stacking_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_edge_min(s : TimeseriesforecaststackingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_edge_max(s : TimeseriesforecaststackingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_edge_to_string(s : TimeseriesforecaststackingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_path_make(size : Int) -> TimeseriesforecaststackingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_path_len(s : TimeseriesforecaststackingPath) -> Int { s.size }

pub fn timeseries_forecast_stacking_path_get(s : TimeseriesforecaststackingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_path_set(s : TimeseriesforecaststackingPath, i : Int, v : Double) -> TimeseriesforecaststackingPath {
  let result = timeseries_forecast_stacking_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_path_sum(s : TimeseriesforecaststackingPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_stacking_path_mean(s : TimeseriesforecaststackingPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_stacking_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_stacking_path_scale(s : TimeseriesforecaststackingPath, f : Double) -> TimeseriesforecaststackingPath {
  let result = timeseries_forecast_stacking_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_stacking_path_add(a : TimeseriesforecaststackingPath, b : TimeseriesforecaststackingPath) -> TimeseriesforecaststackingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_stacking_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_stacking_path_copy(s : TimeseriesforecaststackingPath) -> TimeseriesforecaststackingPath {
  let result = timeseries_forecast_stacking_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_stacking_path_fill(s : TimeseriesforecaststackingPath, v : Double) -> TimeseriesforecaststackingPath {
  let result = timeseries_forecast_stacking_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_path_min(s : TimeseriesforecaststackingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_path_max(s : TimeseriesforecaststackingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_path_to_string(s : TimeseriesforecaststackingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_cluster_make(size : Int) -> TimeseriesforecaststackingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_cluster_len(s : TimeseriesforecaststackingCluster) -> Int { s.size }

pub fn timeseries_forecast_stacking_cluster_get(s : TimeseriesforecaststackingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_cluster_set(s : TimeseriesforecaststackingCluster, i : Int, v : Double) -> TimeseriesforecaststackingCluster {
  let result = timeseries_forecast_stacking_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_cluster_sum(s : TimeseriesforecaststackingCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_stacking_cluster_mean(s : TimeseriesforecaststackingCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_stacking_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_stacking_cluster_scale(s : TimeseriesforecaststackingCluster, f : Double) -> TimeseriesforecaststackingCluster {
  let result = timeseries_forecast_stacking_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_stacking_cluster_add(a : TimeseriesforecaststackingCluster, b : TimeseriesforecaststackingCluster) -> TimeseriesforecaststackingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_stacking_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_stacking_cluster_copy(s : TimeseriesforecaststackingCluster) -> TimeseriesforecaststackingCluster {
  let result = timeseries_forecast_stacking_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_stacking_cluster_fill(s : TimeseriesforecaststackingCluster, v : Double) -> TimeseriesforecaststackingCluster {
  let result = timeseries_forecast_stacking_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_cluster_min(s : TimeseriesforecaststackingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_cluster_max(s : TimeseriesforecaststackingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_cluster_to_string(s : TimeseriesforecaststackingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_model_make(size : Int) -> TimeseriesforecaststackingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_model_len(s : TimeseriesforecaststackingModel) -> Int { s.size }

pub fn timeseries_forecast_stacking_model_get(s : TimeseriesforecaststackingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_model_set(s : TimeseriesforecaststackingModel, i : Int, v : Double) -> TimeseriesforecaststackingModel {
  let result = timeseries_forecast_stacking_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_model_sum(s : TimeseriesforecaststackingModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_stacking_model_mean(s : TimeseriesforecaststackingModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_stacking_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_stacking_model_scale(s : TimeseriesforecaststackingModel, f : Double) -> TimeseriesforecaststackingModel {
  let result = timeseries_forecast_stacking_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_stacking_model_add(a : TimeseriesforecaststackingModel, b : TimeseriesforecaststackingModel) -> TimeseriesforecaststackingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_stacking_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_stacking_model_copy(s : TimeseriesforecaststackingModel) -> TimeseriesforecaststackingModel {
  let result = timeseries_forecast_stacking_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_stacking_model_fill(s : TimeseriesforecaststackingModel, v : Double) -> TimeseriesforecaststackingModel {
  let result = timeseries_forecast_stacking_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_model_min(s : TimeseriesforecaststackingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_model_max(s : TimeseriesforecaststackingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_model_to_string(s : TimeseriesforecaststackingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_layer_make(size : Int) -> TimeseriesforecaststackingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_layer_len(s : TimeseriesforecaststackingLayer) -> Int { s.size }

pub fn timeseries_forecast_stacking_layer_get(s : TimeseriesforecaststackingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_layer_set(s : TimeseriesforecaststackingLayer, i : Int, v : Double) -> TimeseriesforecaststackingLayer {
  let result = timeseries_forecast_stacking_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_layer_sum(s : TimeseriesforecaststackingLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_stacking_layer_mean(s : TimeseriesforecaststackingLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_stacking_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_stacking_layer_scale(s : TimeseriesforecaststackingLayer, f : Double) -> TimeseriesforecaststackingLayer {
  let result = timeseries_forecast_stacking_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_stacking_layer_add(a : TimeseriesforecaststackingLayer, b : TimeseriesforecaststackingLayer) -> TimeseriesforecaststackingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_stacking_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_stacking_layer_copy(s : TimeseriesforecaststackingLayer) -> TimeseriesforecaststackingLayer {
  let result = timeseries_forecast_stacking_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_stacking_layer_fill(s : TimeseriesforecaststackingLayer, v : Double) -> TimeseriesforecaststackingLayer {
  let result = timeseries_forecast_stacking_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_layer_min(s : TimeseriesforecaststackingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_layer_max(s : TimeseriesforecaststackingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_layer_to_string(s : TimeseriesforecaststackingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_buffer_make(size : Int) -> TimeseriesforecaststackingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_buffer_len(s : TimeseriesforecaststackingBuffer) -> Int { s.size }

pub fn timeseries_forecast_stacking_buffer_get(s : TimeseriesforecaststackingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_buffer_set(s : TimeseriesforecaststackingBuffer, i : Int, v : Double) -> TimeseriesforecaststackingBuffer {
  let result = timeseries_forecast_stacking_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_buffer_sum(s : TimeseriesforecaststackingBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_stacking_buffer_mean(s : TimeseriesforecaststackingBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_stacking_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_stacking_buffer_scale(s : TimeseriesforecaststackingBuffer, f : Double) -> TimeseriesforecaststackingBuffer {
  let result = timeseries_forecast_stacking_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_stacking_buffer_add(a : TimeseriesforecaststackingBuffer, b : TimeseriesforecaststackingBuffer) -> TimeseriesforecaststackingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_stacking_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_stacking_buffer_copy(s : TimeseriesforecaststackingBuffer) -> TimeseriesforecaststackingBuffer {
  let result = timeseries_forecast_stacking_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_stacking_buffer_fill(s : TimeseriesforecaststackingBuffer, v : Double) -> TimeseriesforecaststackingBuffer {
  let result = timeseries_forecast_stacking_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_buffer_min(s : TimeseriesforecaststackingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_buffer_max(s : TimeseriesforecaststackingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_buffer_to_string(s : TimeseriesforecaststackingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_cursor_make(size : Int) -> TimeseriesforecaststackingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_cursor_len(s : TimeseriesforecaststackingCursor) -> Int { s.size }

pub fn timeseries_forecast_stacking_cursor_get(s : TimeseriesforecaststackingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_cursor_set(s : TimeseriesforecaststackingCursor, i : Int, v : Double) -> TimeseriesforecaststackingCursor {
  let result = timeseries_forecast_stacking_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_cursor_sum(s : TimeseriesforecaststackingCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_stacking_cursor_mean(s : TimeseriesforecaststackingCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_stacking_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_stacking_cursor_scale(s : TimeseriesforecaststackingCursor, f : Double) -> TimeseriesforecaststackingCursor {
  let result = timeseries_forecast_stacking_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_stacking_cursor_add(a : TimeseriesforecaststackingCursor, b : TimeseriesforecaststackingCursor) -> TimeseriesforecaststackingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_stacking_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_stacking_cursor_copy(s : TimeseriesforecaststackingCursor) -> TimeseriesforecaststackingCursor {
  let result = timeseries_forecast_stacking_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_stacking_cursor_fill(s : TimeseriesforecaststackingCursor, v : Double) -> TimeseriesforecaststackingCursor {
  let result = timeseries_forecast_stacking_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_cursor_min(s : TimeseriesforecaststackingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_cursor_max(s : TimeseriesforecaststackingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_cursor_to_string(s : TimeseriesforecaststackingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_view_make(size : Int) -> TimeseriesforecaststackingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_view_len(s : TimeseriesforecaststackingView) -> Int { s.size }

pub fn timeseries_forecast_stacking_view_get(s : TimeseriesforecaststackingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_view_set(s : TimeseriesforecaststackingView, i : Int, v : Double) -> TimeseriesforecaststackingView {
  let result = timeseries_forecast_stacking_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_view_sum(s : TimeseriesforecaststackingView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_stacking_view_mean(s : TimeseriesforecaststackingView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_stacking_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_stacking_view_scale(s : TimeseriesforecaststackingView, f : Double) -> TimeseriesforecaststackingView {
  let result = timeseries_forecast_stacking_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_stacking_view_add(a : TimeseriesforecaststackingView, b : TimeseriesforecaststackingView) -> TimeseriesforecaststackingView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_stacking_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_stacking_view_copy(s : TimeseriesforecaststackingView) -> TimeseriesforecaststackingView {
  let result = timeseries_forecast_stacking_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_stacking_view_fill(s : TimeseriesforecaststackingView, v : Double) -> TimeseriesforecaststackingView {
  let result = timeseries_forecast_stacking_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_view_min(s : TimeseriesforecaststackingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_view_max(s : TimeseriesforecaststackingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_view_to_string(s : TimeseriesforecaststackingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_range_make(size : Int) -> TimeseriesforecaststackingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_range_len(s : TimeseriesforecaststackingRange) -> Int { s.size }

pub fn timeseries_forecast_stacking_range_get(s : TimeseriesforecaststackingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_range_set(s : TimeseriesforecaststackingRange, i : Int, v : Double) -> TimeseriesforecaststackingRange {
  let result = timeseries_forecast_stacking_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_range_sum(s : TimeseriesforecaststackingRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_stacking_range_mean(s : TimeseriesforecaststackingRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_stacking_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_stacking_range_scale(s : TimeseriesforecaststackingRange, f : Double) -> TimeseriesforecaststackingRange {
  let result = timeseries_forecast_stacking_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_stacking_range_add(a : TimeseriesforecaststackingRange, b : TimeseriesforecaststackingRange) -> TimeseriesforecaststackingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_stacking_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_stacking_range_copy(s : TimeseriesforecaststackingRange) -> TimeseriesforecaststackingRange {
  let result = timeseries_forecast_stacking_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_stacking_range_fill(s : TimeseriesforecaststackingRange, v : Double) -> TimeseriesforecaststackingRange {
  let result = timeseries_forecast_stacking_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_range_min(s : TimeseriesforecaststackingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_range_max(s : TimeseriesforecaststackingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_range_to_string(s : TimeseriesforecaststackingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_slice_make(size : Int) -> TimeseriesforecaststackingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_slice_len(s : TimeseriesforecaststackingSlice) -> Int { s.size }

pub fn timeseries_forecast_stacking_slice_get(s : TimeseriesforecaststackingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_slice_set(s : TimeseriesforecaststackingSlice, i : Int, v : Double) -> TimeseriesforecaststackingSlice {
  let result = timeseries_forecast_stacking_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_slice_sum(s : TimeseriesforecaststackingSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_stacking_slice_mean(s : TimeseriesforecaststackingSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_stacking_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_stacking_slice_scale(s : TimeseriesforecaststackingSlice, f : Double) -> TimeseriesforecaststackingSlice {
  let result = timeseries_forecast_stacking_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_stacking_slice_add(a : TimeseriesforecaststackingSlice, b : TimeseriesforecaststackingSlice) -> TimeseriesforecaststackingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_stacking_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_stacking_slice_copy(s : TimeseriesforecaststackingSlice) -> TimeseriesforecaststackingSlice {
  let result = timeseries_forecast_stacking_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_stacking_slice_fill(s : TimeseriesforecaststackingSlice, v : Double) -> TimeseriesforecaststackingSlice {
  let result = timeseries_forecast_stacking_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_stacking_slice_min(s : TimeseriesforecaststackingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_slice_max(s : TimeseriesforecaststackingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_stacking_slice_to_string(s : TimeseriesforecaststackingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn timeseries_forecast_stacking_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_forecast_stacking_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

