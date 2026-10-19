///===
/// extcore/timeseries_forecast_ensemble

pub(all) struct TimeseriesforecastensemblePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_ensemble_make_point(x : Double, y : Double) -> TimeseriesforecastensemblePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_ensemble_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastensemblePoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_forecast_ensemble_point_x(pt : TimeseriesforecastensemblePoint) -> Double { pt.x }

pub fn timeseries_forecast_ensemble_point_y(pt : TimeseriesforecastensemblePoint) -> Double { pt.y }

pub fn timeseries_forecast_ensemble_point_z(pt : TimeseriesforecastensemblePoint) -> Double { pt.z }

pub fn timeseries_forecast_ensemble_point_label(pt : TimeseriesforecastensemblePoint) -> Int { pt.label }

pub fn timeseries_forecast_ensemble_point_dist(a : TimeseriesforecastensemblePoint, b : TimeseriesforecastensemblePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_forecast_ensemble_point_add(a : TimeseriesforecastensemblePoint, b : TimeseriesforecastensemblePoint) -> TimeseriesforecastensemblePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_forecast_ensemble_point_sub(a : TimeseriesforecastensemblePoint, b : TimeseriesforecastensemblePoint) -> TimeseriesforecastensemblePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_forecast_ensemble_point_scale(pt : TimeseriesforecastensemblePoint, s : Double) -> TimeseriesforecastensemblePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_forecast_ensemble_point_dot(a : TimeseriesforecastensemblePoint, b : TimeseriesforecastensemblePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_forecast_ensemble_point_cross(a : TimeseriesforecastensemblePoint, b : TimeseriesforecastensemblePoint) -> TimeseriesforecastensemblePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_forecast_ensemble_point_norm(pt : TimeseriesforecastensemblePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_forecast_ensemble_point_normalize(pt : TimeseriesforecastensemblePoint) -> TimeseriesforecastensemblePoint {
  let n = timeseries_forecast_ensemble_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_forecast_ensemble_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_forecast_ensemble_point_negate(pt : TimeseriesforecastensemblePoint) -> TimeseriesforecastensemblePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_forecast_ensemble_point_mid(a : TimeseriesforecastensemblePoint, b : TimeseriesforecastensemblePoint) -> TimeseriesforecastensemblePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_forecast_ensemble_point_lerp(a : TimeseriesforecastensemblePoint, b : TimeseriesforecastensemblePoint, t : Double) -> TimeseriesforecastensemblePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_forecast_ensemble_point_to_string(pt : TimeseriesforecastensemblePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_ensemble_make_series(vals : Array[Double], name : String) -> TimeseriesforecastensembleSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_forecast_ensemble_series_len(s : TimeseriesforecastensembleSeries) -> Int { s.vals.length() }

pub fn timeseries_forecast_ensemble_series_sum(s : TimeseriesforecastensembleSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_forecast_ensemble_series_mean(s : TimeseriesforecastensembleSeries) -> Double {
  let n = timeseries_forecast_ensemble_series_len(s)
  if n == 0 { 0.0 } else { timeseries_forecast_ensemble_series_sum(s) / n.to_double() }
}

pub fn timeseries_forecast_ensemble_series_min(s : TimeseriesforecastensembleSeries) -> Double {
  let n = timeseries_forecast_ensemble_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_series_max(s : TimeseriesforecastensembleSeries) -> Double {
  let n = timeseries_forecast_ensemble_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_series_range(s : TimeseriesforecastensembleSeries) -> Double {
  timeseries_forecast_ensemble_series_max(s) - timeseries_forecast_ensemble_series_min(s)
}

pub fn timeseries_forecast_ensemble_series_var(s : TimeseriesforecastensembleSeries) -> Double {
  let n = timeseries_forecast_ensemble_series_len(s)
  if n == 0 { 0.0 } else {
    let m = timeseries_forecast_ensemble_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn timeseries_forecast_ensemble_series_std(s : TimeseriesforecastensembleSeries) -> Double { @_common.sqrt(timeseries_forecast_ensemble_series_var(s)) }

pub fn timeseries_forecast_ensemble_series_median(s : TimeseriesforecastensembleSeries) -> Double {
  let n = timeseries_forecast_ensemble_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = timeseries_forecast_ensemble_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_forecast_ensemble_series_scale(s : TimeseriesforecastensembleSeries, f : Double) -> TimeseriesforecastensembleSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_forecast_ensemble_series_add(a : TimeseriesforecastensembleSeries, b : TimeseriesforecastensembleSeries) -> TimeseriesforecastensembleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_ensemble_series_sub(a : TimeseriesforecastensembleSeries, b : TimeseriesforecastensembleSeries) -> TimeseriesforecastensembleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_ensemble_series_normalize(s : TimeseriesforecastensembleSeries) -> TimeseriesforecastensembleSeries {
  let mn = timeseries_forecast_ensemble_series_min(s)
  let mx = timeseries_forecast_ensemble_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_forecast_ensemble_series_cumsum(s : TimeseriesforecastensembleSeries) -> TimeseriesforecastensembleSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_forecast_ensemble_series_to_string(s : TimeseriesforecastensembleSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastensembleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_ensemble_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastensembleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_ensemble_matrix_identity(n : Int) -> TimeseriesforecastensembleMatrix {
  let m = timeseries_forecast_ensemble_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_forecast_ensemble_matrix_get(m : TimeseriesforecastensembleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_forecast_ensemble_matrix_transpose(m : TimeseriesforecastensembleMatrix) -> TimeseriesforecastensembleMatrix {
  let result = timeseries_forecast_ensemble_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_forecast_ensemble_matrix_add(a : TimeseriesforecastensembleMatrix, b : TimeseriesforecastensembleMatrix) -> TimeseriesforecastensembleMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_forecast_ensemble_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_forecast_ensemble_matrix_scale(m : TimeseriesforecastensembleMatrix, s : Double) -> TimeseriesforecastensembleMatrix {
  let result = timeseries_forecast_ensemble_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_forecast_ensemble_matrix_multiply(a : TimeseriesforecastensembleMatrix, b : TimeseriesforecastensembleMatrix) -> TimeseriesforecastensembleMatrix {
  if a.cols != b.rows { return timeseries_forecast_ensemble_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_forecast_ensemble_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_forecast_ensemble_matrix_trace(m : TimeseriesforecastensembleMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_forecast_ensemble_matrix_det(m : TimeseriesforecastensembleMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_forecast_ensemble_matrix_norm(m : TimeseriesforecastensembleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_forecast_ensemble_matrix_to_string(m : TimeseriesforecastensembleMatrix) -> String {
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

pub(all) struct TimeseriesforecastensembleVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_ensemble_make_vector(comps : Array[Double]) -> TimeseriesforecastensembleVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_ensemble_vector_zero(dim : Int) -> TimeseriesforecastensembleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_forecast_ensemble_vector_add(a : TimeseriesforecastensembleVector, b : TimeseriesforecastensembleVector) -> TimeseriesforecastensembleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_forecast_ensemble_vector_sub(a : TimeseriesforecastensembleVector, b : TimeseriesforecastensembleVector) -> TimeseriesforecastensembleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_forecast_ensemble_vector_scale(v : TimeseriesforecastensembleVector, s : Double) -> TimeseriesforecastensembleVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_forecast_ensemble_vector_dot(a : TimeseriesforecastensembleVector, b : TimeseriesforecastensembleVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_forecast_ensemble_vector_norm(v : TimeseriesforecastensembleVector) -> Double { @_common.sqrt(timeseries_forecast_ensemble_vector_dot(v, v)) }

pub fn timeseries_forecast_ensemble_vector_normalize(v : TimeseriesforecastensembleVector) -> TimeseriesforecastensembleVector {
  let n = timeseries_forecast_ensemble_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_forecast_ensemble_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_forecast_ensemble_vector_dist(a : TimeseriesforecastensembleVector, b : TimeseriesforecastensembleVector) -> Double {
  timeseries_forecast_ensemble_vector_norm(timeseries_forecast_ensemble_vector_sub(a, b))
}

pub fn timeseries_forecast_ensemble_vector_to_string(v : TimeseriesforecastensembleVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_ensemble_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_ensemble_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = timeseries_forecast_ensemble_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_ensemble_std(data : Array[Double]) -> Double { @_common.sqrt(timeseries_forecast_ensemble_var(data)) }

pub fn timeseries_forecast_ensemble_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = timeseries_forecast_ensemble_mean(a); let mb = timeseries_forecast_ensemble_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_ensemble_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = timeseries_forecast_ensemble_std(a); let sb = timeseries_forecast_ensemble_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { timeseries_forecast_ensemble_cov(a, b) / (sa * sb) }
}

pub fn timeseries_forecast_ensemble_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = timeseries_forecast_ensemble_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_forecast_ensemble_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn timeseries_forecast_ensemble_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_ensemble_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(timeseries_forecast_ensemble_mse(pred, labels))
}

pub fn timeseries_forecast_ensemble_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn timeseries_forecast_ensemble_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = timeseries_forecast_ensemble_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn timeseries_forecast_ensemble_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn timeseries_forecast_ensemble_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn timeseries_forecast_ensemble_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = timeseries_forecast_ensemble_precision(pred, labels, pos); let r = timeseries_forecast_ensemble_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn timeseries_forecast_ensemble_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn timeseries_forecast_ensemble_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = timeseries_forecast_ensemble_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn timeseries_forecast_ensemble_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn timeseries_forecast_ensemble_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn timeseries_forecast_ensemble_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = timeseries_forecast_ensemble_gcd(a, b)
    (a / g) * b
  }
}

pub fn timeseries_forecast_ensemble_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn timeseries_forecast_ensemble_fibonacci(n : Int) -> Int {
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

pub fn timeseries_forecast_ensemble_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = timeseries_forecast_ensemble_min(data); let mx = timeseries_forecast_ensemble_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn timeseries_forecast_ensemble_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = timeseries_forecast_ensemble_mean(data); let sd = timeseries_forecast_ensemble_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn timeseries_forecast_ensemble_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn timeseries_forecast_ensemble_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn timeseries_forecast_ensemble_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn timeseries_forecast_ensemble_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct TimeseriesforecastensembleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_frame_make(size : Int) -> TimeseriesforecastensembleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_frame_len(s : TimeseriesforecastensembleFrame) -> Int { s.size }

pub fn timeseries_forecast_ensemble_frame_get(s : TimeseriesforecastensembleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_frame_set(s : TimeseriesforecastensembleFrame, i : Int, v : Double) -> TimeseriesforecastensembleFrame {
  let result = timeseries_forecast_ensemble_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_frame_sum(s : TimeseriesforecastensembleFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_ensemble_frame_mean(s : TimeseriesforecastensembleFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_ensemble_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_ensemble_frame_scale(s : TimeseriesforecastensembleFrame, f : Double) -> TimeseriesforecastensembleFrame {
  let result = timeseries_forecast_ensemble_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_ensemble_frame_add(a : TimeseriesforecastensembleFrame, b : TimeseriesforecastensembleFrame) -> TimeseriesforecastensembleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_ensemble_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_frame_copy(s : TimeseriesforecastensembleFrame) -> TimeseriesforecastensembleFrame {
  let result = timeseries_forecast_ensemble_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_frame_fill(s : TimeseriesforecastensembleFrame, v : Double) -> TimeseriesforecastensembleFrame {
  let result = timeseries_forecast_ensemble_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_frame_min(s : TimeseriesforecastensembleFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_frame_max(s : TimeseriesforecastensembleFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_frame_to_string(s : TimeseriesforecastensembleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_table_make(size : Int) -> TimeseriesforecastensembleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_table_len(s : TimeseriesforecastensembleTable) -> Int { s.size }

pub fn timeseries_forecast_ensemble_table_get(s : TimeseriesforecastensembleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_table_set(s : TimeseriesforecastensembleTable, i : Int, v : Double) -> TimeseriesforecastensembleTable {
  let result = timeseries_forecast_ensemble_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_table_sum(s : TimeseriesforecastensembleTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_ensemble_table_mean(s : TimeseriesforecastensembleTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_ensemble_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_ensemble_table_scale(s : TimeseriesforecastensembleTable, f : Double) -> TimeseriesforecastensembleTable {
  let result = timeseries_forecast_ensemble_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_ensemble_table_add(a : TimeseriesforecastensembleTable, b : TimeseriesforecastensembleTable) -> TimeseriesforecastensembleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_ensemble_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_table_copy(s : TimeseriesforecastensembleTable) -> TimeseriesforecastensembleTable {
  let result = timeseries_forecast_ensemble_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_table_fill(s : TimeseriesforecastensembleTable, v : Double) -> TimeseriesforecastensembleTable {
  let result = timeseries_forecast_ensemble_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_table_min(s : TimeseriesforecastensembleTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_table_max(s : TimeseriesforecastensembleTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_table_to_string(s : TimeseriesforecastensembleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_graphn_make(size : Int) -> TimeseriesforecastensembleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_graphn_len(s : TimeseriesforecastensembleGraphN) -> Int { s.size }

pub fn timeseries_forecast_ensemble_graphn_get(s : TimeseriesforecastensembleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_graphn_set(s : TimeseriesforecastensembleGraphN, i : Int, v : Double) -> TimeseriesforecastensembleGraphN {
  let result = timeseries_forecast_ensemble_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_graphn_sum(s : TimeseriesforecastensembleGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_ensemble_graphn_mean(s : TimeseriesforecastensembleGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_ensemble_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_ensemble_graphn_scale(s : TimeseriesforecastensembleGraphN, f : Double) -> TimeseriesforecastensembleGraphN {
  let result = timeseries_forecast_ensemble_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_ensemble_graphn_add(a : TimeseriesforecastensembleGraphN, b : TimeseriesforecastensembleGraphN) -> TimeseriesforecastensembleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_ensemble_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_graphn_copy(s : TimeseriesforecastensembleGraphN) -> TimeseriesforecastensembleGraphN {
  let result = timeseries_forecast_ensemble_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_graphn_fill(s : TimeseriesforecastensembleGraphN, v : Double) -> TimeseriesforecastensembleGraphN {
  let result = timeseries_forecast_ensemble_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_graphn_min(s : TimeseriesforecastensembleGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_graphn_max(s : TimeseriesforecastensembleGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_graphn_to_string(s : TimeseriesforecastensembleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_node_make(size : Int) -> TimeseriesforecastensembleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_node_len(s : TimeseriesforecastensembleNode) -> Int { s.size }

pub fn timeseries_forecast_ensemble_node_get(s : TimeseriesforecastensembleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_node_set(s : TimeseriesforecastensembleNode, i : Int, v : Double) -> TimeseriesforecastensembleNode {
  let result = timeseries_forecast_ensemble_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_node_sum(s : TimeseriesforecastensembleNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_ensemble_node_mean(s : TimeseriesforecastensembleNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_ensemble_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_ensemble_node_scale(s : TimeseriesforecastensembleNode, f : Double) -> TimeseriesforecastensembleNode {
  let result = timeseries_forecast_ensemble_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_ensemble_node_add(a : TimeseriesforecastensembleNode, b : TimeseriesforecastensembleNode) -> TimeseriesforecastensembleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_ensemble_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_node_copy(s : TimeseriesforecastensembleNode) -> TimeseriesforecastensembleNode {
  let result = timeseries_forecast_ensemble_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_node_fill(s : TimeseriesforecastensembleNode, v : Double) -> TimeseriesforecastensembleNode {
  let result = timeseries_forecast_ensemble_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_node_min(s : TimeseriesforecastensembleNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_node_max(s : TimeseriesforecastensembleNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_node_to_string(s : TimeseriesforecastensembleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_edge_make(size : Int) -> TimeseriesforecastensembleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_edge_len(s : TimeseriesforecastensembleEdge) -> Int { s.size }

pub fn timeseries_forecast_ensemble_edge_get(s : TimeseriesforecastensembleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_edge_set(s : TimeseriesforecastensembleEdge, i : Int, v : Double) -> TimeseriesforecastensembleEdge {
  let result = timeseries_forecast_ensemble_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_edge_sum(s : TimeseriesforecastensembleEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_ensemble_edge_mean(s : TimeseriesforecastensembleEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_ensemble_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_ensemble_edge_scale(s : TimeseriesforecastensembleEdge, f : Double) -> TimeseriesforecastensembleEdge {
  let result = timeseries_forecast_ensemble_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_ensemble_edge_add(a : TimeseriesforecastensembleEdge, b : TimeseriesforecastensembleEdge) -> TimeseriesforecastensembleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_ensemble_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_edge_copy(s : TimeseriesforecastensembleEdge) -> TimeseriesforecastensembleEdge {
  let result = timeseries_forecast_ensemble_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_edge_fill(s : TimeseriesforecastensembleEdge, v : Double) -> TimeseriesforecastensembleEdge {
  let result = timeseries_forecast_ensemble_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_edge_min(s : TimeseriesforecastensembleEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_edge_max(s : TimeseriesforecastensembleEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_edge_to_string(s : TimeseriesforecastensembleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensemblePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_path_make(size : Int) -> TimeseriesforecastensemblePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_path_len(s : TimeseriesforecastensemblePath) -> Int { s.size }

pub fn timeseries_forecast_ensemble_path_get(s : TimeseriesforecastensemblePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_path_set(s : TimeseriesforecastensemblePath, i : Int, v : Double) -> TimeseriesforecastensemblePath {
  let result = timeseries_forecast_ensemble_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_path_sum(s : TimeseriesforecastensemblePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_ensemble_path_mean(s : TimeseriesforecastensemblePath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_ensemble_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_ensemble_path_scale(s : TimeseriesforecastensemblePath, f : Double) -> TimeseriesforecastensemblePath {
  let result = timeseries_forecast_ensemble_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_ensemble_path_add(a : TimeseriesforecastensemblePath, b : TimeseriesforecastensemblePath) -> TimeseriesforecastensemblePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_ensemble_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_path_copy(s : TimeseriesforecastensemblePath) -> TimeseriesforecastensemblePath {
  let result = timeseries_forecast_ensemble_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_path_fill(s : TimeseriesforecastensemblePath, v : Double) -> TimeseriesforecastensemblePath {
  let result = timeseries_forecast_ensemble_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_path_min(s : TimeseriesforecastensemblePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_path_max(s : TimeseriesforecastensemblePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_path_to_string(s : TimeseriesforecastensemblePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_cluster_make(size : Int) -> TimeseriesforecastensembleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_cluster_len(s : TimeseriesforecastensembleCluster) -> Int { s.size }

pub fn timeseries_forecast_ensemble_cluster_get(s : TimeseriesforecastensembleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_cluster_set(s : TimeseriesforecastensembleCluster, i : Int, v : Double) -> TimeseriesforecastensembleCluster {
  let result = timeseries_forecast_ensemble_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_cluster_sum(s : TimeseriesforecastensembleCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_ensemble_cluster_mean(s : TimeseriesforecastensembleCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_ensemble_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_ensemble_cluster_scale(s : TimeseriesforecastensembleCluster, f : Double) -> TimeseriesforecastensembleCluster {
  let result = timeseries_forecast_ensemble_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_ensemble_cluster_add(a : TimeseriesforecastensembleCluster, b : TimeseriesforecastensembleCluster) -> TimeseriesforecastensembleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_ensemble_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_cluster_copy(s : TimeseriesforecastensembleCluster) -> TimeseriesforecastensembleCluster {
  let result = timeseries_forecast_ensemble_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_cluster_fill(s : TimeseriesforecastensembleCluster, v : Double) -> TimeseriesforecastensembleCluster {
  let result = timeseries_forecast_ensemble_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_cluster_min(s : TimeseriesforecastensembleCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_cluster_max(s : TimeseriesforecastensembleCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_cluster_to_string(s : TimeseriesforecastensembleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_model_make(size : Int) -> TimeseriesforecastensembleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_model_len(s : TimeseriesforecastensembleModel) -> Int { s.size }

pub fn timeseries_forecast_ensemble_model_get(s : TimeseriesforecastensembleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_model_set(s : TimeseriesforecastensembleModel, i : Int, v : Double) -> TimeseriesforecastensembleModel {
  let result = timeseries_forecast_ensemble_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_model_sum(s : TimeseriesforecastensembleModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_ensemble_model_mean(s : TimeseriesforecastensembleModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_ensemble_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_ensemble_model_scale(s : TimeseriesforecastensembleModel, f : Double) -> TimeseriesforecastensembleModel {
  let result = timeseries_forecast_ensemble_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_ensemble_model_add(a : TimeseriesforecastensembleModel, b : TimeseriesforecastensembleModel) -> TimeseriesforecastensembleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_ensemble_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_model_copy(s : TimeseriesforecastensembleModel) -> TimeseriesforecastensembleModel {
  let result = timeseries_forecast_ensemble_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_model_fill(s : TimeseriesforecastensembleModel, v : Double) -> TimeseriesforecastensembleModel {
  let result = timeseries_forecast_ensemble_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_model_min(s : TimeseriesforecastensembleModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_model_max(s : TimeseriesforecastensembleModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_model_to_string(s : TimeseriesforecastensembleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_layer_make(size : Int) -> TimeseriesforecastensembleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_layer_len(s : TimeseriesforecastensembleLayer) -> Int { s.size }

pub fn timeseries_forecast_ensemble_layer_get(s : TimeseriesforecastensembleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_layer_set(s : TimeseriesforecastensembleLayer, i : Int, v : Double) -> TimeseriesforecastensembleLayer {
  let result = timeseries_forecast_ensemble_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_layer_sum(s : TimeseriesforecastensembleLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_ensemble_layer_mean(s : TimeseriesforecastensembleLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_ensemble_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_ensemble_layer_scale(s : TimeseriesforecastensembleLayer, f : Double) -> TimeseriesforecastensembleLayer {
  let result = timeseries_forecast_ensemble_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_ensemble_layer_add(a : TimeseriesforecastensembleLayer, b : TimeseriesforecastensembleLayer) -> TimeseriesforecastensembleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_ensemble_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_layer_copy(s : TimeseriesforecastensembleLayer) -> TimeseriesforecastensembleLayer {
  let result = timeseries_forecast_ensemble_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_layer_fill(s : TimeseriesforecastensembleLayer, v : Double) -> TimeseriesforecastensembleLayer {
  let result = timeseries_forecast_ensemble_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_layer_min(s : TimeseriesforecastensembleLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_layer_max(s : TimeseriesforecastensembleLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_layer_to_string(s : TimeseriesforecastensembleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_buffer_make(size : Int) -> TimeseriesforecastensembleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_buffer_len(s : TimeseriesforecastensembleBuffer) -> Int { s.size }

pub fn timeseries_forecast_ensemble_buffer_get(s : TimeseriesforecastensembleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_buffer_set(s : TimeseriesforecastensembleBuffer, i : Int, v : Double) -> TimeseriesforecastensembleBuffer {
  let result = timeseries_forecast_ensemble_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_buffer_sum(s : TimeseriesforecastensembleBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_ensemble_buffer_mean(s : TimeseriesforecastensembleBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_ensemble_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_ensemble_buffer_scale(s : TimeseriesforecastensembleBuffer, f : Double) -> TimeseriesforecastensembleBuffer {
  let result = timeseries_forecast_ensemble_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_ensemble_buffer_add(a : TimeseriesforecastensembleBuffer, b : TimeseriesforecastensembleBuffer) -> TimeseriesforecastensembleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_ensemble_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_buffer_copy(s : TimeseriesforecastensembleBuffer) -> TimeseriesforecastensembleBuffer {
  let result = timeseries_forecast_ensemble_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_buffer_fill(s : TimeseriesforecastensembleBuffer, v : Double) -> TimeseriesforecastensembleBuffer {
  let result = timeseries_forecast_ensemble_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_buffer_min(s : TimeseriesforecastensembleBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_buffer_max(s : TimeseriesforecastensembleBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_buffer_to_string(s : TimeseriesforecastensembleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_cursor_make(size : Int) -> TimeseriesforecastensembleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_cursor_len(s : TimeseriesforecastensembleCursor) -> Int { s.size }

pub fn timeseries_forecast_ensemble_cursor_get(s : TimeseriesforecastensembleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_cursor_set(s : TimeseriesforecastensembleCursor, i : Int, v : Double) -> TimeseriesforecastensembleCursor {
  let result = timeseries_forecast_ensemble_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_cursor_sum(s : TimeseriesforecastensembleCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_ensemble_cursor_mean(s : TimeseriesforecastensembleCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_ensemble_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_ensemble_cursor_scale(s : TimeseriesforecastensembleCursor, f : Double) -> TimeseriesforecastensembleCursor {
  let result = timeseries_forecast_ensemble_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_ensemble_cursor_add(a : TimeseriesforecastensembleCursor, b : TimeseriesforecastensembleCursor) -> TimeseriesforecastensembleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_ensemble_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_cursor_copy(s : TimeseriesforecastensembleCursor) -> TimeseriesforecastensembleCursor {
  let result = timeseries_forecast_ensemble_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_cursor_fill(s : TimeseriesforecastensembleCursor, v : Double) -> TimeseriesforecastensembleCursor {
  let result = timeseries_forecast_ensemble_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_cursor_min(s : TimeseriesforecastensembleCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_cursor_max(s : TimeseriesforecastensembleCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_cursor_to_string(s : TimeseriesforecastensembleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_view_make(size : Int) -> TimeseriesforecastensembleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_view_len(s : TimeseriesforecastensembleView) -> Int { s.size }

pub fn timeseries_forecast_ensemble_view_get(s : TimeseriesforecastensembleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_view_set(s : TimeseriesforecastensembleView, i : Int, v : Double) -> TimeseriesforecastensembleView {
  let result = timeseries_forecast_ensemble_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_view_sum(s : TimeseriesforecastensembleView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_ensemble_view_mean(s : TimeseriesforecastensembleView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_ensemble_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_ensemble_view_scale(s : TimeseriesforecastensembleView, f : Double) -> TimeseriesforecastensembleView {
  let result = timeseries_forecast_ensemble_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_ensemble_view_add(a : TimeseriesforecastensembleView, b : TimeseriesforecastensembleView) -> TimeseriesforecastensembleView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_ensemble_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_view_copy(s : TimeseriesforecastensembleView) -> TimeseriesforecastensembleView {
  let result = timeseries_forecast_ensemble_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_view_fill(s : TimeseriesforecastensembleView, v : Double) -> TimeseriesforecastensembleView {
  let result = timeseries_forecast_ensemble_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_view_min(s : TimeseriesforecastensembleView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_view_max(s : TimeseriesforecastensembleView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_view_to_string(s : TimeseriesforecastensembleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_range_make(size : Int) -> TimeseriesforecastensembleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_range_len(s : TimeseriesforecastensembleRange) -> Int { s.size }

pub fn timeseries_forecast_ensemble_range_get(s : TimeseriesforecastensembleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_range_set(s : TimeseriesforecastensembleRange, i : Int, v : Double) -> TimeseriesforecastensembleRange {
  let result = timeseries_forecast_ensemble_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_range_sum(s : TimeseriesforecastensembleRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_ensemble_range_mean(s : TimeseriesforecastensembleRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_ensemble_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_ensemble_range_scale(s : TimeseriesforecastensembleRange, f : Double) -> TimeseriesforecastensembleRange {
  let result = timeseries_forecast_ensemble_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_ensemble_range_add(a : TimeseriesforecastensembleRange, b : TimeseriesforecastensembleRange) -> TimeseriesforecastensembleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_ensemble_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_range_copy(s : TimeseriesforecastensembleRange) -> TimeseriesforecastensembleRange {
  let result = timeseries_forecast_ensemble_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_range_fill(s : TimeseriesforecastensembleRange, v : Double) -> TimeseriesforecastensembleRange {
  let result = timeseries_forecast_ensemble_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_range_min(s : TimeseriesforecastensembleRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_range_max(s : TimeseriesforecastensembleRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_range_to_string(s : TimeseriesforecastensembleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_slice_make(size : Int) -> TimeseriesforecastensembleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_slice_len(s : TimeseriesforecastensembleSlice) -> Int { s.size }

pub fn timeseries_forecast_ensemble_slice_get(s : TimeseriesforecastensembleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_slice_set(s : TimeseriesforecastensembleSlice, i : Int, v : Double) -> TimeseriesforecastensembleSlice {
  let result = timeseries_forecast_ensemble_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_slice_sum(s : TimeseriesforecastensembleSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_ensemble_slice_mean(s : TimeseriesforecastensembleSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_ensemble_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_ensemble_slice_scale(s : TimeseriesforecastensembleSlice, f : Double) -> TimeseriesforecastensembleSlice {
  let result = timeseries_forecast_ensemble_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_ensemble_slice_add(a : TimeseriesforecastensembleSlice, b : TimeseriesforecastensembleSlice) -> TimeseriesforecastensembleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_ensemble_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_slice_copy(s : TimeseriesforecastensembleSlice) -> TimeseriesforecastensembleSlice {
  let result = timeseries_forecast_ensemble_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_ensemble_slice_fill(s : TimeseriesforecastensembleSlice, v : Double) -> TimeseriesforecastensembleSlice {
  let result = timeseries_forecast_ensemble_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_ensemble_slice_min(s : TimeseriesforecastensembleSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_slice_max(s : TimeseriesforecastensembleSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_ensemble_slice_to_string(s : TimeseriesforecastensembleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

