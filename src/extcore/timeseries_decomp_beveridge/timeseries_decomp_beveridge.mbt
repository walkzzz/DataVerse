///===
/// extcore/timeseries_decomp_beveridge

pub(all) struct TimeseriesdecompbeveridgePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_beveridge_make_point(x : Double, y : Double) -> TimeseriesdecompbeveridgePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_beveridge_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecompbeveridgePoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_decomp_beveridge_point_x(pt : TimeseriesdecompbeveridgePoint) -> Double { pt.x }

pub fn timeseries_decomp_beveridge_point_y(pt : TimeseriesdecompbeveridgePoint) -> Double { pt.y }

pub fn timeseries_decomp_beveridge_point_z(pt : TimeseriesdecompbeveridgePoint) -> Double { pt.z }

pub fn timeseries_decomp_beveridge_point_label(pt : TimeseriesdecompbeveridgePoint) -> Int { pt.label }

pub fn timeseries_decomp_beveridge_point_dist(a : TimeseriesdecompbeveridgePoint, b : TimeseriesdecompbeveridgePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_decomp_beveridge_point_add(a : TimeseriesdecompbeveridgePoint, b : TimeseriesdecompbeveridgePoint) -> TimeseriesdecompbeveridgePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_decomp_beveridge_point_sub(a : TimeseriesdecompbeveridgePoint, b : TimeseriesdecompbeveridgePoint) -> TimeseriesdecompbeveridgePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_decomp_beveridge_point_scale(pt : TimeseriesdecompbeveridgePoint, s : Double) -> TimeseriesdecompbeveridgePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_decomp_beveridge_point_dot(a : TimeseriesdecompbeveridgePoint, b : TimeseriesdecompbeveridgePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_decomp_beveridge_point_cross(a : TimeseriesdecompbeveridgePoint, b : TimeseriesdecompbeveridgePoint) -> TimeseriesdecompbeveridgePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_decomp_beveridge_point_norm(pt : TimeseriesdecompbeveridgePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_decomp_beveridge_point_normalize(pt : TimeseriesdecompbeveridgePoint) -> TimeseriesdecompbeveridgePoint {
  let n = timeseries_decomp_beveridge_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_decomp_beveridge_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_decomp_beveridge_point_negate(pt : TimeseriesdecompbeveridgePoint) -> TimeseriesdecompbeveridgePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_decomp_beveridge_point_mid(a : TimeseriesdecompbeveridgePoint, b : TimeseriesdecompbeveridgePoint) -> TimeseriesdecompbeveridgePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_decomp_beveridge_point_lerp(a : TimeseriesdecompbeveridgePoint, b : TimeseriesdecompbeveridgePoint, t : Double) -> TimeseriesdecompbeveridgePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_decomp_beveridge_point_to_string(pt : TimeseriesdecompbeveridgePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_beveridge_make_series(vals : Array[Double], name : String) -> TimeseriesdecompbeveridgeSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_decomp_beveridge_series_len(s : TimeseriesdecompbeveridgeSeries) -> Int { s.vals.length() }

pub fn timeseries_decomp_beveridge_series_sum(s : TimeseriesdecompbeveridgeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_decomp_beveridge_series_mean(s : TimeseriesdecompbeveridgeSeries) -> Double {
  let n = timeseries_decomp_beveridge_series_len(s)
  if n == 0 { 0.0 } else { timeseries_decomp_beveridge_series_sum(s) / n.to_double() }
}

pub fn timeseries_decomp_beveridge_series_min(s : TimeseriesdecompbeveridgeSeries) -> Double {
  let n = timeseries_decomp_beveridge_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_series_max(s : TimeseriesdecompbeveridgeSeries) -> Double {
  let n = timeseries_decomp_beveridge_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_series_range(s : TimeseriesdecompbeveridgeSeries) -> Double {
  timeseries_decomp_beveridge_series_max(s) - timeseries_decomp_beveridge_series_min(s)
}

pub fn timeseries_decomp_beveridge_series_var(s : TimeseriesdecompbeveridgeSeries) -> Double {
  let n = timeseries_decomp_beveridge_series_len(s)
  if n == 0 { 0.0 } else {
    let m = timeseries_decomp_beveridge_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn timeseries_decomp_beveridge_series_std(s : TimeseriesdecompbeveridgeSeries) -> Double { @_common.sqrt(timeseries_decomp_beveridge_series_var(s)) }

pub fn timeseries_decomp_beveridge_series_median(s : TimeseriesdecompbeveridgeSeries) -> Double {
  let n = timeseries_decomp_beveridge_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = timeseries_decomp_beveridge_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_decomp_beveridge_series_scale(s : TimeseriesdecompbeveridgeSeries, f : Double) -> TimeseriesdecompbeveridgeSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_decomp_beveridge_series_add(a : TimeseriesdecompbeveridgeSeries, b : TimeseriesdecompbeveridgeSeries) -> TimeseriesdecompbeveridgeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_decomp_beveridge_series_sub(a : TimeseriesdecompbeveridgeSeries, b : TimeseriesdecompbeveridgeSeries) -> TimeseriesdecompbeveridgeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_decomp_beveridge_series_normalize(s : TimeseriesdecompbeveridgeSeries) -> TimeseriesdecompbeveridgeSeries {
  let mn = timeseries_decomp_beveridge_series_min(s)
  let mx = timeseries_decomp_beveridge_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_decomp_beveridge_series_cumsum(s : TimeseriesdecompbeveridgeSeries) -> TimeseriesdecompbeveridgeSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_decomp_beveridge_series_to_string(s : TimeseriesdecompbeveridgeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompbeveridgeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_beveridge_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecompbeveridgeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_beveridge_matrix_identity(n : Int) -> TimeseriesdecompbeveridgeMatrix {
  let m = timeseries_decomp_beveridge_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_decomp_beveridge_matrix_get(m : TimeseriesdecompbeveridgeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_decomp_beveridge_matrix_transpose(m : TimeseriesdecompbeveridgeMatrix) -> TimeseriesdecompbeveridgeMatrix {
  let result = timeseries_decomp_beveridge_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_decomp_beveridge_matrix_add(a : TimeseriesdecompbeveridgeMatrix, b : TimeseriesdecompbeveridgeMatrix) -> TimeseriesdecompbeveridgeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_decomp_beveridge_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_decomp_beveridge_matrix_scale(m : TimeseriesdecompbeveridgeMatrix, s : Double) -> TimeseriesdecompbeveridgeMatrix {
  let result = timeseries_decomp_beveridge_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_decomp_beveridge_matrix_multiply(a : TimeseriesdecompbeveridgeMatrix, b : TimeseriesdecompbeveridgeMatrix) -> TimeseriesdecompbeveridgeMatrix {
  if a.cols != b.rows { return timeseries_decomp_beveridge_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_decomp_beveridge_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_decomp_beveridge_matrix_trace(m : TimeseriesdecompbeveridgeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_decomp_beveridge_matrix_det(m : TimeseriesdecompbeveridgeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_decomp_beveridge_matrix_norm(m : TimeseriesdecompbeveridgeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_decomp_beveridge_matrix_to_string(m : TimeseriesdecompbeveridgeMatrix) -> String {
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

pub(all) struct TimeseriesdecompbeveridgeVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_beveridge_make_vector(comps : Array[Double]) -> TimeseriesdecompbeveridgeVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_beveridge_vector_zero(dim : Int) -> TimeseriesdecompbeveridgeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_decomp_beveridge_vector_add(a : TimeseriesdecompbeveridgeVector, b : TimeseriesdecompbeveridgeVector) -> TimeseriesdecompbeveridgeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_decomp_beveridge_vector_sub(a : TimeseriesdecompbeveridgeVector, b : TimeseriesdecompbeveridgeVector) -> TimeseriesdecompbeveridgeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_decomp_beveridge_vector_scale(v : TimeseriesdecompbeveridgeVector, s : Double) -> TimeseriesdecompbeveridgeVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_decomp_beveridge_vector_dot(a : TimeseriesdecompbeveridgeVector, b : TimeseriesdecompbeveridgeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_decomp_beveridge_vector_norm(v : TimeseriesdecompbeveridgeVector) -> Double { @_common.sqrt(timeseries_decomp_beveridge_vector_dot(v, v)) }

pub fn timeseries_decomp_beveridge_vector_normalize(v : TimeseriesdecompbeveridgeVector) -> TimeseriesdecompbeveridgeVector {
  let n = timeseries_decomp_beveridge_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_decomp_beveridge_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_decomp_beveridge_vector_dist(a : TimeseriesdecompbeveridgeVector, b : TimeseriesdecompbeveridgeVector) -> Double {
  timeseries_decomp_beveridge_vector_norm(timeseries_decomp_beveridge_vector_sub(a, b))
}

pub fn timeseries_decomp_beveridge_vector_to_string(v : TimeseriesdecompbeveridgeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_decomp_beveridge_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_beveridge_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = timeseries_decomp_beveridge_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_beveridge_std(data : Array[Double]) -> Double { @_common.sqrt(timeseries_decomp_beveridge_var(data)) }

pub fn timeseries_decomp_beveridge_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = timeseries_decomp_beveridge_mean(a); let mb = timeseries_decomp_beveridge_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_beveridge_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = timeseries_decomp_beveridge_std(a); let sb = timeseries_decomp_beveridge_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { timeseries_decomp_beveridge_cov(a, b) / (sa * sb) }
}

pub fn timeseries_decomp_beveridge_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = timeseries_decomp_beveridge_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_decomp_beveridge_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn timeseries_decomp_beveridge_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_beveridge_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(timeseries_decomp_beveridge_mse(pred, labels))
}

pub fn timeseries_decomp_beveridge_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_beveridge_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = timeseries_decomp_beveridge_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn timeseries_decomp_beveridge_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn timeseries_decomp_beveridge_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn timeseries_decomp_beveridge_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = timeseries_decomp_beveridge_precision(pred, labels, pos); let r = timeseries_decomp_beveridge_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn timeseries_decomp_beveridge_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn timeseries_decomp_beveridge_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = timeseries_decomp_beveridge_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn timeseries_decomp_beveridge_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn timeseries_decomp_beveridge_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn timeseries_decomp_beveridge_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = timeseries_decomp_beveridge_gcd(a, b)
    (a / g) * b
  }
}

pub fn timeseries_decomp_beveridge_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn timeseries_decomp_beveridge_fibonacci(n : Int) -> Int {
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

pub fn timeseries_decomp_beveridge_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = timeseries_decomp_beveridge_min(data); let mx = timeseries_decomp_beveridge_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn timeseries_decomp_beveridge_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = timeseries_decomp_beveridge_mean(data); let sd = timeseries_decomp_beveridge_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn timeseries_decomp_beveridge_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn timeseries_decomp_beveridge_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn timeseries_decomp_beveridge_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn timeseries_decomp_beveridge_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct TimeseriesdecompbeveridgeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_frame_make(size : Int) -> TimeseriesdecompbeveridgeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_frame_len(s : TimeseriesdecompbeveridgeFrame) -> Int { s.size }

pub fn timeseries_decomp_beveridge_frame_get(s : TimeseriesdecompbeveridgeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_frame_set(s : TimeseriesdecompbeveridgeFrame, i : Int, v : Double) -> TimeseriesdecompbeveridgeFrame {
  let result = timeseries_decomp_beveridge_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_frame_sum(s : TimeseriesdecompbeveridgeFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_beveridge_frame_mean(s : TimeseriesdecompbeveridgeFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_beveridge_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_beveridge_frame_scale(s : TimeseriesdecompbeveridgeFrame, f : Double) -> TimeseriesdecompbeveridgeFrame {
  let result = timeseries_decomp_beveridge_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_beveridge_frame_add(a : TimeseriesdecompbeveridgeFrame, b : TimeseriesdecompbeveridgeFrame) -> TimeseriesdecompbeveridgeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_beveridge_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_frame_copy(s : TimeseriesdecompbeveridgeFrame) -> TimeseriesdecompbeveridgeFrame {
  let result = timeseries_decomp_beveridge_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_frame_fill(s : TimeseriesdecompbeveridgeFrame, v : Double) -> TimeseriesdecompbeveridgeFrame {
  let result = timeseries_decomp_beveridge_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_frame_min(s : TimeseriesdecompbeveridgeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_frame_max(s : TimeseriesdecompbeveridgeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_frame_to_string(s : TimeseriesdecompbeveridgeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_table_make(size : Int) -> TimeseriesdecompbeveridgeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_table_len(s : TimeseriesdecompbeveridgeTable) -> Int { s.size }

pub fn timeseries_decomp_beveridge_table_get(s : TimeseriesdecompbeveridgeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_table_set(s : TimeseriesdecompbeveridgeTable, i : Int, v : Double) -> TimeseriesdecompbeveridgeTable {
  let result = timeseries_decomp_beveridge_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_table_sum(s : TimeseriesdecompbeveridgeTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_beveridge_table_mean(s : TimeseriesdecompbeveridgeTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_beveridge_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_beveridge_table_scale(s : TimeseriesdecompbeveridgeTable, f : Double) -> TimeseriesdecompbeveridgeTable {
  let result = timeseries_decomp_beveridge_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_beveridge_table_add(a : TimeseriesdecompbeveridgeTable, b : TimeseriesdecompbeveridgeTable) -> TimeseriesdecompbeveridgeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_beveridge_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_table_copy(s : TimeseriesdecompbeveridgeTable) -> TimeseriesdecompbeveridgeTable {
  let result = timeseries_decomp_beveridge_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_table_fill(s : TimeseriesdecompbeveridgeTable, v : Double) -> TimeseriesdecompbeveridgeTable {
  let result = timeseries_decomp_beveridge_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_table_min(s : TimeseriesdecompbeveridgeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_table_max(s : TimeseriesdecompbeveridgeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_table_to_string(s : TimeseriesdecompbeveridgeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_graphn_make(size : Int) -> TimeseriesdecompbeveridgeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_graphn_len(s : TimeseriesdecompbeveridgeGraphN) -> Int { s.size }

pub fn timeseries_decomp_beveridge_graphn_get(s : TimeseriesdecompbeveridgeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_graphn_set(s : TimeseriesdecompbeveridgeGraphN, i : Int, v : Double) -> TimeseriesdecompbeveridgeGraphN {
  let result = timeseries_decomp_beveridge_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_graphn_sum(s : TimeseriesdecompbeveridgeGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_beveridge_graphn_mean(s : TimeseriesdecompbeveridgeGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_beveridge_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_beveridge_graphn_scale(s : TimeseriesdecompbeveridgeGraphN, f : Double) -> TimeseriesdecompbeveridgeGraphN {
  let result = timeseries_decomp_beveridge_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_beveridge_graphn_add(a : TimeseriesdecompbeveridgeGraphN, b : TimeseriesdecompbeveridgeGraphN) -> TimeseriesdecompbeveridgeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_beveridge_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_graphn_copy(s : TimeseriesdecompbeveridgeGraphN) -> TimeseriesdecompbeveridgeGraphN {
  let result = timeseries_decomp_beveridge_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_graphn_fill(s : TimeseriesdecompbeveridgeGraphN, v : Double) -> TimeseriesdecompbeveridgeGraphN {
  let result = timeseries_decomp_beveridge_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_graphn_min(s : TimeseriesdecompbeveridgeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_graphn_max(s : TimeseriesdecompbeveridgeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_graphn_to_string(s : TimeseriesdecompbeveridgeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_node_make(size : Int) -> TimeseriesdecompbeveridgeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_node_len(s : TimeseriesdecompbeveridgeNode) -> Int { s.size }

pub fn timeseries_decomp_beveridge_node_get(s : TimeseriesdecompbeveridgeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_node_set(s : TimeseriesdecompbeveridgeNode, i : Int, v : Double) -> TimeseriesdecompbeveridgeNode {
  let result = timeseries_decomp_beveridge_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_node_sum(s : TimeseriesdecompbeveridgeNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_beveridge_node_mean(s : TimeseriesdecompbeveridgeNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_beveridge_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_beveridge_node_scale(s : TimeseriesdecompbeveridgeNode, f : Double) -> TimeseriesdecompbeveridgeNode {
  let result = timeseries_decomp_beveridge_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_beveridge_node_add(a : TimeseriesdecompbeveridgeNode, b : TimeseriesdecompbeveridgeNode) -> TimeseriesdecompbeveridgeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_beveridge_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_node_copy(s : TimeseriesdecompbeveridgeNode) -> TimeseriesdecompbeveridgeNode {
  let result = timeseries_decomp_beveridge_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_node_fill(s : TimeseriesdecompbeveridgeNode, v : Double) -> TimeseriesdecompbeveridgeNode {
  let result = timeseries_decomp_beveridge_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_node_min(s : TimeseriesdecompbeveridgeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_node_max(s : TimeseriesdecompbeveridgeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_node_to_string(s : TimeseriesdecompbeveridgeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_edge_make(size : Int) -> TimeseriesdecompbeveridgeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_edge_len(s : TimeseriesdecompbeveridgeEdge) -> Int { s.size }

pub fn timeseries_decomp_beveridge_edge_get(s : TimeseriesdecompbeveridgeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_edge_set(s : TimeseriesdecompbeveridgeEdge, i : Int, v : Double) -> TimeseriesdecompbeveridgeEdge {
  let result = timeseries_decomp_beveridge_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_edge_sum(s : TimeseriesdecompbeveridgeEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_beveridge_edge_mean(s : TimeseriesdecompbeveridgeEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_beveridge_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_beveridge_edge_scale(s : TimeseriesdecompbeveridgeEdge, f : Double) -> TimeseriesdecompbeveridgeEdge {
  let result = timeseries_decomp_beveridge_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_beveridge_edge_add(a : TimeseriesdecompbeveridgeEdge, b : TimeseriesdecompbeveridgeEdge) -> TimeseriesdecompbeveridgeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_beveridge_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_edge_copy(s : TimeseriesdecompbeveridgeEdge) -> TimeseriesdecompbeveridgeEdge {
  let result = timeseries_decomp_beveridge_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_edge_fill(s : TimeseriesdecompbeveridgeEdge, v : Double) -> TimeseriesdecompbeveridgeEdge {
  let result = timeseries_decomp_beveridge_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_edge_min(s : TimeseriesdecompbeveridgeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_edge_max(s : TimeseriesdecompbeveridgeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_edge_to_string(s : TimeseriesdecompbeveridgeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_path_make(size : Int) -> TimeseriesdecompbeveridgePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_path_len(s : TimeseriesdecompbeveridgePath) -> Int { s.size }

pub fn timeseries_decomp_beveridge_path_get(s : TimeseriesdecompbeveridgePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_path_set(s : TimeseriesdecompbeveridgePath, i : Int, v : Double) -> TimeseriesdecompbeveridgePath {
  let result = timeseries_decomp_beveridge_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_path_sum(s : TimeseriesdecompbeveridgePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_beveridge_path_mean(s : TimeseriesdecompbeveridgePath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_beveridge_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_beveridge_path_scale(s : TimeseriesdecompbeveridgePath, f : Double) -> TimeseriesdecompbeveridgePath {
  let result = timeseries_decomp_beveridge_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_beveridge_path_add(a : TimeseriesdecompbeveridgePath, b : TimeseriesdecompbeveridgePath) -> TimeseriesdecompbeveridgePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_beveridge_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_path_copy(s : TimeseriesdecompbeveridgePath) -> TimeseriesdecompbeveridgePath {
  let result = timeseries_decomp_beveridge_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_path_fill(s : TimeseriesdecompbeveridgePath, v : Double) -> TimeseriesdecompbeveridgePath {
  let result = timeseries_decomp_beveridge_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_path_min(s : TimeseriesdecompbeveridgePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_path_max(s : TimeseriesdecompbeveridgePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_path_to_string(s : TimeseriesdecompbeveridgePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_cluster_make(size : Int) -> TimeseriesdecompbeveridgeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_cluster_len(s : TimeseriesdecompbeveridgeCluster) -> Int { s.size }

pub fn timeseries_decomp_beveridge_cluster_get(s : TimeseriesdecompbeveridgeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_cluster_set(s : TimeseriesdecompbeveridgeCluster, i : Int, v : Double) -> TimeseriesdecompbeveridgeCluster {
  let result = timeseries_decomp_beveridge_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_cluster_sum(s : TimeseriesdecompbeveridgeCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_beveridge_cluster_mean(s : TimeseriesdecompbeveridgeCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_beveridge_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_beveridge_cluster_scale(s : TimeseriesdecompbeveridgeCluster, f : Double) -> TimeseriesdecompbeveridgeCluster {
  let result = timeseries_decomp_beveridge_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_beveridge_cluster_add(a : TimeseriesdecompbeveridgeCluster, b : TimeseriesdecompbeveridgeCluster) -> TimeseriesdecompbeveridgeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_beveridge_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_cluster_copy(s : TimeseriesdecompbeveridgeCluster) -> TimeseriesdecompbeveridgeCluster {
  let result = timeseries_decomp_beveridge_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_cluster_fill(s : TimeseriesdecompbeveridgeCluster, v : Double) -> TimeseriesdecompbeveridgeCluster {
  let result = timeseries_decomp_beveridge_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_cluster_min(s : TimeseriesdecompbeveridgeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_cluster_max(s : TimeseriesdecompbeveridgeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_cluster_to_string(s : TimeseriesdecompbeveridgeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_model_make(size : Int) -> TimeseriesdecompbeveridgeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_model_len(s : TimeseriesdecompbeveridgeModel) -> Int { s.size }

pub fn timeseries_decomp_beveridge_model_get(s : TimeseriesdecompbeveridgeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_model_set(s : TimeseriesdecompbeveridgeModel, i : Int, v : Double) -> TimeseriesdecompbeveridgeModel {
  let result = timeseries_decomp_beveridge_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_model_sum(s : TimeseriesdecompbeveridgeModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_beveridge_model_mean(s : TimeseriesdecompbeveridgeModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_beveridge_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_beveridge_model_scale(s : TimeseriesdecompbeveridgeModel, f : Double) -> TimeseriesdecompbeveridgeModel {
  let result = timeseries_decomp_beveridge_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_beveridge_model_add(a : TimeseriesdecompbeveridgeModel, b : TimeseriesdecompbeveridgeModel) -> TimeseriesdecompbeveridgeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_beveridge_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_model_copy(s : TimeseriesdecompbeveridgeModel) -> TimeseriesdecompbeveridgeModel {
  let result = timeseries_decomp_beveridge_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_model_fill(s : TimeseriesdecompbeveridgeModel, v : Double) -> TimeseriesdecompbeveridgeModel {
  let result = timeseries_decomp_beveridge_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_model_min(s : TimeseriesdecompbeveridgeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_model_max(s : TimeseriesdecompbeveridgeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_model_to_string(s : TimeseriesdecompbeveridgeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_layer_make(size : Int) -> TimeseriesdecompbeveridgeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_layer_len(s : TimeseriesdecompbeveridgeLayer) -> Int { s.size }

pub fn timeseries_decomp_beveridge_layer_get(s : TimeseriesdecompbeveridgeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_layer_set(s : TimeseriesdecompbeveridgeLayer, i : Int, v : Double) -> TimeseriesdecompbeveridgeLayer {
  let result = timeseries_decomp_beveridge_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_layer_sum(s : TimeseriesdecompbeveridgeLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_beveridge_layer_mean(s : TimeseriesdecompbeveridgeLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_beveridge_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_beveridge_layer_scale(s : TimeseriesdecompbeveridgeLayer, f : Double) -> TimeseriesdecompbeveridgeLayer {
  let result = timeseries_decomp_beveridge_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_beveridge_layer_add(a : TimeseriesdecompbeveridgeLayer, b : TimeseriesdecompbeveridgeLayer) -> TimeseriesdecompbeveridgeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_beveridge_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_layer_copy(s : TimeseriesdecompbeveridgeLayer) -> TimeseriesdecompbeveridgeLayer {
  let result = timeseries_decomp_beveridge_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_layer_fill(s : TimeseriesdecompbeveridgeLayer, v : Double) -> TimeseriesdecompbeveridgeLayer {
  let result = timeseries_decomp_beveridge_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_layer_min(s : TimeseriesdecompbeveridgeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_layer_max(s : TimeseriesdecompbeveridgeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_layer_to_string(s : TimeseriesdecompbeveridgeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_buffer_make(size : Int) -> TimeseriesdecompbeveridgeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_buffer_len(s : TimeseriesdecompbeveridgeBuffer) -> Int { s.size }

pub fn timeseries_decomp_beveridge_buffer_get(s : TimeseriesdecompbeveridgeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_buffer_set(s : TimeseriesdecompbeveridgeBuffer, i : Int, v : Double) -> TimeseriesdecompbeveridgeBuffer {
  let result = timeseries_decomp_beveridge_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_buffer_sum(s : TimeseriesdecompbeveridgeBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_beveridge_buffer_mean(s : TimeseriesdecompbeveridgeBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_beveridge_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_beveridge_buffer_scale(s : TimeseriesdecompbeveridgeBuffer, f : Double) -> TimeseriesdecompbeveridgeBuffer {
  let result = timeseries_decomp_beveridge_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_beveridge_buffer_add(a : TimeseriesdecompbeveridgeBuffer, b : TimeseriesdecompbeveridgeBuffer) -> TimeseriesdecompbeveridgeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_beveridge_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_buffer_copy(s : TimeseriesdecompbeveridgeBuffer) -> TimeseriesdecompbeveridgeBuffer {
  let result = timeseries_decomp_beveridge_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_buffer_fill(s : TimeseriesdecompbeveridgeBuffer, v : Double) -> TimeseriesdecompbeveridgeBuffer {
  let result = timeseries_decomp_beveridge_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_buffer_min(s : TimeseriesdecompbeveridgeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_buffer_max(s : TimeseriesdecompbeveridgeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_buffer_to_string(s : TimeseriesdecompbeveridgeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_cursor_make(size : Int) -> TimeseriesdecompbeveridgeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_cursor_len(s : TimeseriesdecompbeveridgeCursor) -> Int { s.size }

pub fn timeseries_decomp_beveridge_cursor_get(s : TimeseriesdecompbeveridgeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_cursor_set(s : TimeseriesdecompbeveridgeCursor, i : Int, v : Double) -> TimeseriesdecompbeveridgeCursor {
  let result = timeseries_decomp_beveridge_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_cursor_sum(s : TimeseriesdecompbeveridgeCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_beveridge_cursor_mean(s : TimeseriesdecompbeveridgeCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_beveridge_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_beveridge_cursor_scale(s : TimeseriesdecompbeveridgeCursor, f : Double) -> TimeseriesdecompbeveridgeCursor {
  let result = timeseries_decomp_beveridge_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_beveridge_cursor_add(a : TimeseriesdecompbeveridgeCursor, b : TimeseriesdecompbeveridgeCursor) -> TimeseriesdecompbeveridgeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_beveridge_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_cursor_copy(s : TimeseriesdecompbeveridgeCursor) -> TimeseriesdecompbeveridgeCursor {
  let result = timeseries_decomp_beveridge_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_cursor_fill(s : TimeseriesdecompbeveridgeCursor, v : Double) -> TimeseriesdecompbeveridgeCursor {
  let result = timeseries_decomp_beveridge_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_cursor_min(s : TimeseriesdecompbeveridgeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_cursor_max(s : TimeseriesdecompbeveridgeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_cursor_to_string(s : TimeseriesdecompbeveridgeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_view_make(size : Int) -> TimeseriesdecompbeveridgeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_view_len(s : TimeseriesdecompbeveridgeView) -> Int { s.size }

pub fn timeseries_decomp_beveridge_view_get(s : TimeseriesdecompbeveridgeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_view_set(s : TimeseriesdecompbeveridgeView, i : Int, v : Double) -> TimeseriesdecompbeveridgeView {
  let result = timeseries_decomp_beveridge_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_view_sum(s : TimeseriesdecompbeveridgeView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_beveridge_view_mean(s : TimeseriesdecompbeveridgeView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_beveridge_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_beveridge_view_scale(s : TimeseriesdecompbeveridgeView, f : Double) -> TimeseriesdecompbeveridgeView {
  let result = timeseries_decomp_beveridge_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_beveridge_view_add(a : TimeseriesdecompbeveridgeView, b : TimeseriesdecompbeveridgeView) -> TimeseriesdecompbeveridgeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_beveridge_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_view_copy(s : TimeseriesdecompbeveridgeView) -> TimeseriesdecompbeveridgeView {
  let result = timeseries_decomp_beveridge_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_view_fill(s : TimeseriesdecompbeveridgeView, v : Double) -> TimeseriesdecompbeveridgeView {
  let result = timeseries_decomp_beveridge_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_view_min(s : TimeseriesdecompbeveridgeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_view_max(s : TimeseriesdecompbeveridgeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_view_to_string(s : TimeseriesdecompbeveridgeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_range_make(size : Int) -> TimeseriesdecompbeveridgeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_range_len(s : TimeseriesdecompbeveridgeRange) -> Int { s.size }

pub fn timeseries_decomp_beveridge_range_get(s : TimeseriesdecompbeveridgeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_range_set(s : TimeseriesdecompbeveridgeRange, i : Int, v : Double) -> TimeseriesdecompbeveridgeRange {
  let result = timeseries_decomp_beveridge_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_range_sum(s : TimeseriesdecompbeveridgeRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_beveridge_range_mean(s : TimeseriesdecompbeveridgeRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_beveridge_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_beveridge_range_scale(s : TimeseriesdecompbeveridgeRange, f : Double) -> TimeseriesdecompbeveridgeRange {
  let result = timeseries_decomp_beveridge_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_beveridge_range_add(a : TimeseriesdecompbeveridgeRange, b : TimeseriesdecompbeveridgeRange) -> TimeseriesdecompbeveridgeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_beveridge_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_range_copy(s : TimeseriesdecompbeveridgeRange) -> TimeseriesdecompbeveridgeRange {
  let result = timeseries_decomp_beveridge_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_range_fill(s : TimeseriesdecompbeveridgeRange, v : Double) -> TimeseriesdecompbeveridgeRange {
  let result = timeseries_decomp_beveridge_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_range_min(s : TimeseriesdecompbeveridgeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_range_max(s : TimeseriesdecompbeveridgeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_range_to_string(s : TimeseriesdecompbeveridgeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_slice_make(size : Int) -> TimeseriesdecompbeveridgeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_slice_len(s : TimeseriesdecompbeveridgeSlice) -> Int { s.size }

pub fn timeseries_decomp_beveridge_slice_get(s : TimeseriesdecompbeveridgeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_slice_set(s : TimeseriesdecompbeveridgeSlice, i : Int, v : Double) -> TimeseriesdecompbeveridgeSlice {
  let result = timeseries_decomp_beveridge_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_slice_sum(s : TimeseriesdecompbeveridgeSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_beveridge_slice_mean(s : TimeseriesdecompbeveridgeSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_beveridge_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_beveridge_slice_scale(s : TimeseriesdecompbeveridgeSlice, f : Double) -> TimeseriesdecompbeveridgeSlice {
  let result = timeseries_decomp_beveridge_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_beveridge_slice_add(a : TimeseriesdecompbeveridgeSlice, b : TimeseriesdecompbeveridgeSlice) -> TimeseriesdecompbeveridgeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_beveridge_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_slice_copy(s : TimeseriesdecompbeveridgeSlice) -> TimeseriesdecompbeveridgeSlice {
  let result = timeseries_decomp_beveridge_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_beveridge_slice_fill(s : TimeseriesdecompbeveridgeSlice, v : Double) -> TimeseriesdecompbeveridgeSlice {
  let result = timeseries_decomp_beveridge_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_beveridge_slice_min(s : TimeseriesdecompbeveridgeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_slice_max(s : TimeseriesdecompbeveridgeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_beveridge_slice_to_string(s : TimeseriesdecompbeveridgeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

