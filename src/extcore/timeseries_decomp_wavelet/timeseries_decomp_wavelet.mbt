///===
/// extcore/timeseries_decomp_wavelet

pub(all) struct TimeseriesdecompwaveletPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_wavelet_make_point(x : Double, y : Double) -> TimeseriesdecompwaveletPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_wavelet_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecompwaveletPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_decomp_wavelet_point_x(pt : TimeseriesdecompwaveletPoint) -> Double { pt.x }

pub fn timeseries_decomp_wavelet_point_y(pt : TimeseriesdecompwaveletPoint) -> Double { pt.y }

pub fn timeseries_decomp_wavelet_point_z(pt : TimeseriesdecompwaveletPoint) -> Double { pt.z }

pub fn timeseries_decomp_wavelet_point_label(pt : TimeseriesdecompwaveletPoint) -> Int { pt.label }

pub fn timeseries_decomp_wavelet_point_dist(a : TimeseriesdecompwaveletPoint, b : TimeseriesdecompwaveletPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_decomp_wavelet_point_add(a : TimeseriesdecompwaveletPoint, b : TimeseriesdecompwaveletPoint) -> TimeseriesdecompwaveletPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_decomp_wavelet_point_sub(a : TimeseriesdecompwaveletPoint, b : TimeseriesdecompwaveletPoint) -> TimeseriesdecompwaveletPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_decomp_wavelet_point_scale(pt : TimeseriesdecompwaveletPoint, s : Double) -> TimeseriesdecompwaveletPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_decomp_wavelet_point_dot(a : TimeseriesdecompwaveletPoint, b : TimeseriesdecompwaveletPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_decomp_wavelet_point_cross(a : TimeseriesdecompwaveletPoint, b : TimeseriesdecompwaveletPoint) -> TimeseriesdecompwaveletPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_decomp_wavelet_point_norm(pt : TimeseriesdecompwaveletPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_decomp_wavelet_point_normalize(pt : TimeseriesdecompwaveletPoint) -> TimeseriesdecompwaveletPoint {
  let n = timeseries_decomp_wavelet_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_decomp_wavelet_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_decomp_wavelet_point_negate(pt : TimeseriesdecompwaveletPoint) -> TimeseriesdecompwaveletPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_decomp_wavelet_point_mid(a : TimeseriesdecompwaveletPoint, b : TimeseriesdecompwaveletPoint) -> TimeseriesdecompwaveletPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_decomp_wavelet_point_lerp(a : TimeseriesdecompwaveletPoint, b : TimeseriesdecompwaveletPoint, t : Double) -> TimeseriesdecompwaveletPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_decomp_wavelet_point_to_string(pt : TimeseriesdecompwaveletPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_wavelet_make_series(vals : Array[Double], name : String) -> TimeseriesdecompwaveletSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_decomp_wavelet_series_len(s : TimeseriesdecompwaveletSeries) -> Int { s.vals.length() }

pub fn timeseries_decomp_wavelet_series_sum(s : TimeseriesdecompwaveletSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_decomp_wavelet_series_mean(s : TimeseriesdecompwaveletSeries) -> Double {
  let n = timeseries_decomp_wavelet_series_len(s)
  if n == 0 { 0.0 } else { timeseries_decomp_wavelet_series_sum(s) / n.to_double() }
}

pub fn timeseries_decomp_wavelet_series_min(s : TimeseriesdecompwaveletSeries) -> Double {
  let n = timeseries_decomp_wavelet_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_series_max(s : TimeseriesdecompwaveletSeries) -> Double {
  let n = timeseries_decomp_wavelet_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_series_range(s : TimeseriesdecompwaveletSeries) -> Double {
  timeseries_decomp_wavelet_series_max(s) - timeseries_decomp_wavelet_series_min(s)
}

pub fn timeseries_decomp_wavelet_series_var(s : TimeseriesdecompwaveletSeries) -> Double {
  let n = timeseries_decomp_wavelet_series_len(s)
  if n == 0 { 0.0 } else {
    let m = timeseries_decomp_wavelet_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn timeseries_decomp_wavelet_series_std(s : TimeseriesdecompwaveletSeries) -> Double { @_common.sqrt(timeseries_decomp_wavelet_series_var(s)) }

pub fn timeseries_decomp_wavelet_series_median(s : TimeseriesdecompwaveletSeries) -> Double {
  let n = timeseries_decomp_wavelet_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = timeseries_decomp_wavelet_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_decomp_wavelet_series_scale(s : TimeseriesdecompwaveletSeries, f : Double) -> TimeseriesdecompwaveletSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_decomp_wavelet_series_add(a : TimeseriesdecompwaveletSeries, b : TimeseriesdecompwaveletSeries) -> TimeseriesdecompwaveletSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_decomp_wavelet_series_sub(a : TimeseriesdecompwaveletSeries, b : TimeseriesdecompwaveletSeries) -> TimeseriesdecompwaveletSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_decomp_wavelet_series_normalize(s : TimeseriesdecompwaveletSeries) -> TimeseriesdecompwaveletSeries {
  let mn = timeseries_decomp_wavelet_series_min(s)
  let mx = timeseries_decomp_wavelet_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_decomp_wavelet_series_cumsum(s : TimeseriesdecompwaveletSeries) -> TimeseriesdecompwaveletSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_decomp_wavelet_series_to_string(s : TimeseriesdecompwaveletSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompwaveletMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_wavelet_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecompwaveletMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_wavelet_matrix_identity(n : Int) -> TimeseriesdecompwaveletMatrix {
  let m = timeseries_decomp_wavelet_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_decomp_wavelet_matrix_get(m : TimeseriesdecompwaveletMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_decomp_wavelet_matrix_transpose(m : TimeseriesdecompwaveletMatrix) -> TimeseriesdecompwaveletMatrix {
  let result = timeseries_decomp_wavelet_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_decomp_wavelet_matrix_add(a : TimeseriesdecompwaveletMatrix, b : TimeseriesdecompwaveletMatrix) -> TimeseriesdecompwaveletMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_decomp_wavelet_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_decomp_wavelet_matrix_scale(m : TimeseriesdecompwaveletMatrix, s : Double) -> TimeseriesdecompwaveletMatrix {
  let result = timeseries_decomp_wavelet_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_decomp_wavelet_matrix_multiply(a : TimeseriesdecompwaveletMatrix, b : TimeseriesdecompwaveletMatrix) -> TimeseriesdecompwaveletMatrix {
  if a.cols != b.rows { return timeseries_decomp_wavelet_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_decomp_wavelet_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_decomp_wavelet_matrix_trace(m : TimeseriesdecompwaveletMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_decomp_wavelet_matrix_det(m : TimeseriesdecompwaveletMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_decomp_wavelet_matrix_norm(m : TimeseriesdecompwaveletMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_decomp_wavelet_matrix_to_string(m : TimeseriesdecompwaveletMatrix) -> String {
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

pub(all) struct TimeseriesdecompwaveletVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_wavelet_make_vector(comps : Array[Double]) -> TimeseriesdecompwaveletVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_wavelet_vector_zero(dim : Int) -> TimeseriesdecompwaveletVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_decomp_wavelet_vector_add(a : TimeseriesdecompwaveletVector, b : TimeseriesdecompwaveletVector) -> TimeseriesdecompwaveletVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_decomp_wavelet_vector_sub(a : TimeseriesdecompwaveletVector, b : TimeseriesdecompwaveletVector) -> TimeseriesdecompwaveletVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_decomp_wavelet_vector_scale(v : TimeseriesdecompwaveletVector, s : Double) -> TimeseriesdecompwaveletVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_decomp_wavelet_vector_dot(a : TimeseriesdecompwaveletVector, b : TimeseriesdecompwaveletVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_decomp_wavelet_vector_norm(v : TimeseriesdecompwaveletVector) -> Double { @_common.sqrt(timeseries_decomp_wavelet_vector_dot(v, v)) }

pub fn timeseries_decomp_wavelet_vector_normalize(v : TimeseriesdecompwaveletVector) -> TimeseriesdecompwaveletVector {
  let n = timeseries_decomp_wavelet_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_decomp_wavelet_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_decomp_wavelet_vector_dist(a : TimeseriesdecompwaveletVector, b : TimeseriesdecompwaveletVector) -> Double {
  timeseries_decomp_wavelet_vector_norm(timeseries_decomp_wavelet_vector_sub(a, b))
}

pub fn timeseries_decomp_wavelet_vector_to_string(v : TimeseriesdecompwaveletVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_decomp_wavelet_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_wavelet_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = timeseries_decomp_wavelet_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_wavelet_std(data : Array[Double]) -> Double { @_common.sqrt(timeseries_decomp_wavelet_var(data)) }

pub fn timeseries_decomp_wavelet_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = timeseries_decomp_wavelet_mean(a); let mb = timeseries_decomp_wavelet_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_wavelet_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = timeseries_decomp_wavelet_std(a); let sb = timeseries_decomp_wavelet_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { timeseries_decomp_wavelet_cov(a, b) / (sa * sb) }
}

pub fn timeseries_decomp_wavelet_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = timeseries_decomp_wavelet_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_decomp_wavelet_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn timeseries_decomp_wavelet_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_wavelet_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(timeseries_decomp_wavelet_mse(pred, labels))
}

pub fn timeseries_decomp_wavelet_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_wavelet_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = timeseries_decomp_wavelet_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn timeseries_decomp_wavelet_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn timeseries_decomp_wavelet_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn timeseries_decomp_wavelet_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = timeseries_decomp_wavelet_precision(pred, labels, pos); let r = timeseries_decomp_wavelet_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn timeseries_decomp_wavelet_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn timeseries_decomp_wavelet_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = timeseries_decomp_wavelet_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn timeseries_decomp_wavelet_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn timeseries_decomp_wavelet_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn timeseries_decomp_wavelet_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = timeseries_decomp_wavelet_gcd(a, b)
    (a / g) * b
  }
}

pub fn timeseries_decomp_wavelet_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn timeseries_decomp_wavelet_fibonacci(n : Int) -> Int {
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

pub fn timeseries_decomp_wavelet_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = timeseries_decomp_wavelet_min(data); let mx = timeseries_decomp_wavelet_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn timeseries_decomp_wavelet_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = timeseries_decomp_wavelet_mean(data); let sd = timeseries_decomp_wavelet_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn timeseries_decomp_wavelet_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn timeseries_decomp_wavelet_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn timeseries_decomp_wavelet_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn timeseries_decomp_wavelet_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct TimeseriesdecompwaveletFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_frame_make(size : Int) -> TimeseriesdecompwaveletFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_frame_len(s : TimeseriesdecompwaveletFrame) -> Int { s.size }

pub fn timeseries_decomp_wavelet_frame_get(s : TimeseriesdecompwaveletFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_frame_set(s : TimeseriesdecompwaveletFrame, i : Int, v : Double) -> TimeseriesdecompwaveletFrame {
  let result = timeseries_decomp_wavelet_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_frame_sum(s : TimeseriesdecompwaveletFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_wavelet_frame_mean(s : TimeseriesdecompwaveletFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_wavelet_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_wavelet_frame_scale(s : TimeseriesdecompwaveletFrame, f : Double) -> TimeseriesdecompwaveletFrame {
  let result = timeseries_decomp_wavelet_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_wavelet_frame_add(a : TimeseriesdecompwaveletFrame, b : TimeseriesdecompwaveletFrame) -> TimeseriesdecompwaveletFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_wavelet_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_frame_copy(s : TimeseriesdecompwaveletFrame) -> TimeseriesdecompwaveletFrame {
  let result = timeseries_decomp_wavelet_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_frame_fill(s : TimeseriesdecompwaveletFrame, v : Double) -> TimeseriesdecompwaveletFrame {
  let result = timeseries_decomp_wavelet_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_frame_min(s : TimeseriesdecompwaveletFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_frame_max(s : TimeseriesdecompwaveletFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_frame_to_string(s : TimeseriesdecompwaveletFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_table_make(size : Int) -> TimeseriesdecompwaveletTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_table_len(s : TimeseriesdecompwaveletTable) -> Int { s.size }

pub fn timeseries_decomp_wavelet_table_get(s : TimeseriesdecompwaveletTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_table_set(s : TimeseriesdecompwaveletTable, i : Int, v : Double) -> TimeseriesdecompwaveletTable {
  let result = timeseries_decomp_wavelet_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_table_sum(s : TimeseriesdecompwaveletTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_wavelet_table_mean(s : TimeseriesdecompwaveletTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_wavelet_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_wavelet_table_scale(s : TimeseriesdecompwaveletTable, f : Double) -> TimeseriesdecompwaveletTable {
  let result = timeseries_decomp_wavelet_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_wavelet_table_add(a : TimeseriesdecompwaveletTable, b : TimeseriesdecompwaveletTable) -> TimeseriesdecompwaveletTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_wavelet_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_table_copy(s : TimeseriesdecompwaveletTable) -> TimeseriesdecompwaveletTable {
  let result = timeseries_decomp_wavelet_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_table_fill(s : TimeseriesdecompwaveletTable, v : Double) -> TimeseriesdecompwaveletTable {
  let result = timeseries_decomp_wavelet_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_table_min(s : TimeseriesdecompwaveletTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_table_max(s : TimeseriesdecompwaveletTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_table_to_string(s : TimeseriesdecompwaveletTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_graphn_make(size : Int) -> TimeseriesdecompwaveletGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_graphn_len(s : TimeseriesdecompwaveletGraphN) -> Int { s.size }

pub fn timeseries_decomp_wavelet_graphn_get(s : TimeseriesdecompwaveletGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_graphn_set(s : TimeseriesdecompwaveletGraphN, i : Int, v : Double) -> TimeseriesdecompwaveletGraphN {
  let result = timeseries_decomp_wavelet_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_graphn_sum(s : TimeseriesdecompwaveletGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_wavelet_graphn_mean(s : TimeseriesdecompwaveletGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_wavelet_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_wavelet_graphn_scale(s : TimeseriesdecompwaveletGraphN, f : Double) -> TimeseriesdecompwaveletGraphN {
  let result = timeseries_decomp_wavelet_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_wavelet_graphn_add(a : TimeseriesdecompwaveletGraphN, b : TimeseriesdecompwaveletGraphN) -> TimeseriesdecompwaveletGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_wavelet_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_graphn_copy(s : TimeseriesdecompwaveletGraphN) -> TimeseriesdecompwaveletGraphN {
  let result = timeseries_decomp_wavelet_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_graphn_fill(s : TimeseriesdecompwaveletGraphN, v : Double) -> TimeseriesdecompwaveletGraphN {
  let result = timeseries_decomp_wavelet_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_graphn_min(s : TimeseriesdecompwaveletGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_graphn_max(s : TimeseriesdecompwaveletGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_graphn_to_string(s : TimeseriesdecompwaveletGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_node_make(size : Int) -> TimeseriesdecompwaveletNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_node_len(s : TimeseriesdecompwaveletNode) -> Int { s.size }

pub fn timeseries_decomp_wavelet_node_get(s : TimeseriesdecompwaveletNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_node_set(s : TimeseriesdecompwaveletNode, i : Int, v : Double) -> TimeseriesdecompwaveletNode {
  let result = timeseries_decomp_wavelet_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_node_sum(s : TimeseriesdecompwaveletNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_wavelet_node_mean(s : TimeseriesdecompwaveletNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_wavelet_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_wavelet_node_scale(s : TimeseriesdecompwaveletNode, f : Double) -> TimeseriesdecompwaveletNode {
  let result = timeseries_decomp_wavelet_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_wavelet_node_add(a : TimeseriesdecompwaveletNode, b : TimeseriesdecompwaveletNode) -> TimeseriesdecompwaveletNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_wavelet_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_node_copy(s : TimeseriesdecompwaveletNode) -> TimeseriesdecompwaveletNode {
  let result = timeseries_decomp_wavelet_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_node_fill(s : TimeseriesdecompwaveletNode, v : Double) -> TimeseriesdecompwaveletNode {
  let result = timeseries_decomp_wavelet_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_node_min(s : TimeseriesdecompwaveletNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_node_max(s : TimeseriesdecompwaveletNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_node_to_string(s : TimeseriesdecompwaveletNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_edge_make(size : Int) -> TimeseriesdecompwaveletEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_edge_len(s : TimeseriesdecompwaveletEdge) -> Int { s.size }

pub fn timeseries_decomp_wavelet_edge_get(s : TimeseriesdecompwaveletEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_edge_set(s : TimeseriesdecompwaveletEdge, i : Int, v : Double) -> TimeseriesdecompwaveletEdge {
  let result = timeseries_decomp_wavelet_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_edge_sum(s : TimeseriesdecompwaveletEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_wavelet_edge_mean(s : TimeseriesdecompwaveletEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_wavelet_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_wavelet_edge_scale(s : TimeseriesdecompwaveletEdge, f : Double) -> TimeseriesdecompwaveletEdge {
  let result = timeseries_decomp_wavelet_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_wavelet_edge_add(a : TimeseriesdecompwaveletEdge, b : TimeseriesdecompwaveletEdge) -> TimeseriesdecompwaveletEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_wavelet_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_edge_copy(s : TimeseriesdecompwaveletEdge) -> TimeseriesdecompwaveletEdge {
  let result = timeseries_decomp_wavelet_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_edge_fill(s : TimeseriesdecompwaveletEdge, v : Double) -> TimeseriesdecompwaveletEdge {
  let result = timeseries_decomp_wavelet_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_edge_min(s : TimeseriesdecompwaveletEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_edge_max(s : TimeseriesdecompwaveletEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_edge_to_string(s : TimeseriesdecompwaveletEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_path_make(size : Int) -> TimeseriesdecompwaveletPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_path_len(s : TimeseriesdecompwaveletPath) -> Int { s.size }

pub fn timeseries_decomp_wavelet_path_get(s : TimeseriesdecompwaveletPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_path_set(s : TimeseriesdecompwaveletPath, i : Int, v : Double) -> TimeseriesdecompwaveletPath {
  let result = timeseries_decomp_wavelet_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_path_sum(s : TimeseriesdecompwaveletPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_wavelet_path_mean(s : TimeseriesdecompwaveletPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_wavelet_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_wavelet_path_scale(s : TimeseriesdecompwaveletPath, f : Double) -> TimeseriesdecompwaveletPath {
  let result = timeseries_decomp_wavelet_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_wavelet_path_add(a : TimeseriesdecompwaveletPath, b : TimeseriesdecompwaveletPath) -> TimeseriesdecompwaveletPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_wavelet_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_path_copy(s : TimeseriesdecompwaveletPath) -> TimeseriesdecompwaveletPath {
  let result = timeseries_decomp_wavelet_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_path_fill(s : TimeseriesdecompwaveletPath, v : Double) -> TimeseriesdecompwaveletPath {
  let result = timeseries_decomp_wavelet_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_path_min(s : TimeseriesdecompwaveletPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_path_max(s : TimeseriesdecompwaveletPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_path_to_string(s : TimeseriesdecompwaveletPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_cluster_make(size : Int) -> TimeseriesdecompwaveletCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_cluster_len(s : TimeseriesdecompwaveletCluster) -> Int { s.size }

pub fn timeseries_decomp_wavelet_cluster_get(s : TimeseriesdecompwaveletCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_cluster_set(s : TimeseriesdecompwaveletCluster, i : Int, v : Double) -> TimeseriesdecompwaveletCluster {
  let result = timeseries_decomp_wavelet_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_cluster_sum(s : TimeseriesdecompwaveletCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_wavelet_cluster_mean(s : TimeseriesdecompwaveletCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_wavelet_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_wavelet_cluster_scale(s : TimeseriesdecompwaveletCluster, f : Double) -> TimeseriesdecompwaveletCluster {
  let result = timeseries_decomp_wavelet_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_wavelet_cluster_add(a : TimeseriesdecompwaveletCluster, b : TimeseriesdecompwaveletCluster) -> TimeseriesdecompwaveletCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_wavelet_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_cluster_copy(s : TimeseriesdecompwaveletCluster) -> TimeseriesdecompwaveletCluster {
  let result = timeseries_decomp_wavelet_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_cluster_fill(s : TimeseriesdecompwaveletCluster, v : Double) -> TimeseriesdecompwaveletCluster {
  let result = timeseries_decomp_wavelet_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_cluster_min(s : TimeseriesdecompwaveletCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_cluster_max(s : TimeseriesdecompwaveletCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_cluster_to_string(s : TimeseriesdecompwaveletCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_model_make(size : Int) -> TimeseriesdecompwaveletModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_model_len(s : TimeseriesdecompwaveletModel) -> Int { s.size }

pub fn timeseries_decomp_wavelet_model_get(s : TimeseriesdecompwaveletModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_model_set(s : TimeseriesdecompwaveletModel, i : Int, v : Double) -> TimeseriesdecompwaveletModel {
  let result = timeseries_decomp_wavelet_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_model_sum(s : TimeseriesdecompwaveletModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_wavelet_model_mean(s : TimeseriesdecompwaveletModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_wavelet_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_wavelet_model_scale(s : TimeseriesdecompwaveletModel, f : Double) -> TimeseriesdecompwaveletModel {
  let result = timeseries_decomp_wavelet_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_wavelet_model_add(a : TimeseriesdecompwaveletModel, b : TimeseriesdecompwaveletModel) -> TimeseriesdecompwaveletModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_wavelet_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_model_copy(s : TimeseriesdecompwaveletModel) -> TimeseriesdecompwaveletModel {
  let result = timeseries_decomp_wavelet_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_model_fill(s : TimeseriesdecompwaveletModel, v : Double) -> TimeseriesdecompwaveletModel {
  let result = timeseries_decomp_wavelet_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_model_min(s : TimeseriesdecompwaveletModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_model_max(s : TimeseriesdecompwaveletModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_model_to_string(s : TimeseriesdecompwaveletModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_layer_make(size : Int) -> TimeseriesdecompwaveletLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_layer_len(s : TimeseriesdecompwaveletLayer) -> Int { s.size }

pub fn timeseries_decomp_wavelet_layer_get(s : TimeseriesdecompwaveletLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_layer_set(s : TimeseriesdecompwaveletLayer, i : Int, v : Double) -> TimeseriesdecompwaveletLayer {
  let result = timeseries_decomp_wavelet_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_layer_sum(s : TimeseriesdecompwaveletLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_wavelet_layer_mean(s : TimeseriesdecompwaveletLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_wavelet_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_wavelet_layer_scale(s : TimeseriesdecompwaveletLayer, f : Double) -> TimeseriesdecompwaveletLayer {
  let result = timeseries_decomp_wavelet_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_wavelet_layer_add(a : TimeseriesdecompwaveletLayer, b : TimeseriesdecompwaveletLayer) -> TimeseriesdecompwaveletLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_wavelet_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_layer_copy(s : TimeseriesdecompwaveletLayer) -> TimeseriesdecompwaveletLayer {
  let result = timeseries_decomp_wavelet_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_layer_fill(s : TimeseriesdecompwaveletLayer, v : Double) -> TimeseriesdecompwaveletLayer {
  let result = timeseries_decomp_wavelet_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_layer_min(s : TimeseriesdecompwaveletLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_layer_max(s : TimeseriesdecompwaveletLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_layer_to_string(s : TimeseriesdecompwaveletLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_buffer_make(size : Int) -> TimeseriesdecompwaveletBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_buffer_len(s : TimeseriesdecompwaveletBuffer) -> Int { s.size }

pub fn timeseries_decomp_wavelet_buffer_get(s : TimeseriesdecompwaveletBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_buffer_set(s : TimeseriesdecompwaveletBuffer, i : Int, v : Double) -> TimeseriesdecompwaveletBuffer {
  let result = timeseries_decomp_wavelet_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_buffer_sum(s : TimeseriesdecompwaveletBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_wavelet_buffer_mean(s : TimeseriesdecompwaveletBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_wavelet_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_wavelet_buffer_scale(s : TimeseriesdecompwaveletBuffer, f : Double) -> TimeseriesdecompwaveletBuffer {
  let result = timeseries_decomp_wavelet_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_wavelet_buffer_add(a : TimeseriesdecompwaveletBuffer, b : TimeseriesdecompwaveletBuffer) -> TimeseriesdecompwaveletBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_wavelet_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_buffer_copy(s : TimeseriesdecompwaveletBuffer) -> TimeseriesdecompwaveletBuffer {
  let result = timeseries_decomp_wavelet_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_buffer_fill(s : TimeseriesdecompwaveletBuffer, v : Double) -> TimeseriesdecompwaveletBuffer {
  let result = timeseries_decomp_wavelet_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_buffer_min(s : TimeseriesdecompwaveletBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_buffer_max(s : TimeseriesdecompwaveletBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_buffer_to_string(s : TimeseriesdecompwaveletBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_cursor_make(size : Int) -> TimeseriesdecompwaveletCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_cursor_len(s : TimeseriesdecompwaveletCursor) -> Int { s.size }

pub fn timeseries_decomp_wavelet_cursor_get(s : TimeseriesdecompwaveletCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_cursor_set(s : TimeseriesdecompwaveletCursor, i : Int, v : Double) -> TimeseriesdecompwaveletCursor {
  let result = timeseries_decomp_wavelet_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_cursor_sum(s : TimeseriesdecompwaveletCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_wavelet_cursor_mean(s : TimeseriesdecompwaveletCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_wavelet_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_wavelet_cursor_scale(s : TimeseriesdecompwaveletCursor, f : Double) -> TimeseriesdecompwaveletCursor {
  let result = timeseries_decomp_wavelet_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_wavelet_cursor_add(a : TimeseriesdecompwaveletCursor, b : TimeseriesdecompwaveletCursor) -> TimeseriesdecompwaveletCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_wavelet_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_cursor_copy(s : TimeseriesdecompwaveletCursor) -> TimeseriesdecompwaveletCursor {
  let result = timeseries_decomp_wavelet_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_cursor_fill(s : TimeseriesdecompwaveletCursor, v : Double) -> TimeseriesdecompwaveletCursor {
  let result = timeseries_decomp_wavelet_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_cursor_min(s : TimeseriesdecompwaveletCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_cursor_max(s : TimeseriesdecompwaveletCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_cursor_to_string(s : TimeseriesdecompwaveletCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_view_make(size : Int) -> TimeseriesdecompwaveletView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_view_len(s : TimeseriesdecompwaveletView) -> Int { s.size }

pub fn timeseries_decomp_wavelet_view_get(s : TimeseriesdecompwaveletView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_view_set(s : TimeseriesdecompwaveletView, i : Int, v : Double) -> TimeseriesdecompwaveletView {
  let result = timeseries_decomp_wavelet_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_view_sum(s : TimeseriesdecompwaveletView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_wavelet_view_mean(s : TimeseriesdecompwaveletView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_wavelet_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_wavelet_view_scale(s : TimeseriesdecompwaveletView, f : Double) -> TimeseriesdecompwaveletView {
  let result = timeseries_decomp_wavelet_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_wavelet_view_add(a : TimeseriesdecompwaveletView, b : TimeseriesdecompwaveletView) -> TimeseriesdecompwaveletView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_wavelet_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_view_copy(s : TimeseriesdecompwaveletView) -> TimeseriesdecompwaveletView {
  let result = timeseries_decomp_wavelet_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_view_fill(s : TimeseriesdecompwaveletView, v : Double) -> TimeseriesdecompwaveletView {
  let result = timeseries_decomp_wavelet_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_view_min(s : TimeseriesdecompwaveletView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_view_max(s : TimeseriesdecompwaveletView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_view_to_string(s : TimeseriesdecompwaveletView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_range_make(size : Int) -> TimeseriesdecompwaveletRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_range_len(s : TimeseriesdecompwaveletRange) -> Int { s.size }

pub fn timeseries_decomp_wavelet_range_get(s : TimeseriesdecompwaveletRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_range_set(s : TimeseriesdecompwaveletRange, i : Int, v : Double) -> TimeseriesdecompwaveletRange {
  let result = timeseries_decomp_wavelet_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_range_sum(s : TimeseriesdecompwaveletRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_wavelet_range_mean(s : TimeseriesdecompwaveletRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_wavelet_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_wavelet_range_scale(s : TimeseriesdecompwaveletRange, f : Double) -> TimeseriesdecompwaveletRange {
  let result = timeseries_decomp_wavelet_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_wavelet_range_add(a : TimeseriesdecompwaveletRange, b : TimeseriesdecompwaveletRange) -> TimeseriesdecompwaveletRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_wavelet_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_range_copy(s : TimeseriesdecompwaveletRange) -> TimeseriesdecompwaveletRange {
  let result = timeseries_decomp_wavelet_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_range_fill(s : TimeseriesdecompwaveletRange, v : Double) -> TimeseriesdecompwaveletRange {
  let result = timeseries_decomp_wavelet_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_range_min(s : TimeseriesdecompwaveletRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_range_max(s : TimeseriesdecompwaveletRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_range_to_string(s : TimeseriesdecompwaveletRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_slice_make(size : Int) -> TimeseriesdecompwaveletSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_slice_len(s : TimeseriesdecompwaveletSlice) -> Int { s.size }

pub fn timeseries_decomp_wavelet_slice_get(s : TimeseriesdecompwaveletSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_slice_set(s : TimeseriesdecompwaveletSlice, i : Int, v : Double) -> TimeseriesdecompwaveletSlice {
  let result = timeseries_decomp_wavelet_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_slice_sum(s : TimeseriesdecompwaveletSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_wavelet_slice_mean(s : TimeseriesdecompwaveletSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_wavelet_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_wavelet_slice_scale(s : TimeseriesdecompwaveletSlice, f : Double) -> TimeseriesdecompwaveletSlice {
  let result = timeseries_decomp_wavelet_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_wavelet_slice_add(a : TimeseriesdecompwaveletSlice, b : TimeseriesdecompwaveletSlice) -> TimeseriesdecompwaveletSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_wavelet_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_slice_copy(s : TimeseriesdecompwaveletSlice) -> TimeseriesdecompwaveletSlice {
  let result = timeseries_decomp_wavelet_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_wavelet_slice_fill(s : TimeseriesdecompwaveletSlice, v : Double) -> TimeseriesdecompwaveletSlice {
  let result = timeseries_decomp_wavelet_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_wavelet_slice_min(s : TimeseriesdecompwaveletSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_slice_max(s : TimeseriesdecompwaveletSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_wavelet_slice_to_string(s : TimeseriesdecompwaveletSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

