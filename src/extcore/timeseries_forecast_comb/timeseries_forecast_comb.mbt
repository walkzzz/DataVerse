///===
/// extcore/timeseries_forecast_comb

pub(all) struct TimeseriesforecastcombPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_comb_make_point(x : Double, y : Double) -> TimeseriesforecastcombPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_comb_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastcombPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_forecast_comb_point_x(pt : TimeseriesforecastcombPoint) -> Double { pt.x }

pub fn timeseries_forecast_comb_point_y(pt : TimeseriesforecastcombPoint) -> Double { pt.y }

pub fn timeseries_forecast_comb_point_z(pt : TimeseriesforecastcombPoint) -> Double { pt.z }

pub fn timeseries_forecast_comb_point_label(pt : TimeseriesforecastcombPoint) -> Int { pt.label }

pub fn timeseries_forecast_comb_point_dist(a : TimeseriesforecastcombPoint, b : TimeseriesforecastcombPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_forecast_comb_point_add(a : TimeseriesforecastcombPoint, b : TimeseriesforecastcombPoint) -> TimeseriesforecastcombPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_forecast_comb_point_sub(a : TimeseriesforecastcombPoint, b : TimeseriesforecastcombPoint) -> TimeseriesforecastcombPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_forecast_comb_point_scale(pt : TimeseriesforecastcombPoint, s : Double) -> TimeseriesforecastcombPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_forecast_comb_point_dot(a : TimeseriesforecastcombPoint, b : TimeseriesforecastcombPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_forecast_comb_point_cross(a : TimeseriesforecastcombPoint, b : TimeseriesforecastcombPoint) -> TimeseriesforecastcombPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_forecast_comb_point_norm(pt : TimeseriesforecastcombPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_forecast_comb_point_normalize(pt : TimeseriesforecastcombPoint) -> TimeseriesforecastcombPoint {
  let n = timeseries_forecast_comb_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_forecast_comb_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_forecast_comb_point_negate(pt : TimeseriesforecastcombPoint) -> TimeseriesforecastcombPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_forecast_comb_point_mid(a : TimeseriesforecastcombPoint, b : TimeseriesforecastcombPoint) -> TimeseriesforecastcombPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_forecast_comb_point_lerp(a : TimeseriesforecastcombPoint, b : TimeseriesforecastcombPoint, t : Double) -> TimeseriesforecastcombPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_forecast_comb_point_to_string(pt : TimeseriesforecastcombPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_comb_make_series(vals : Array[Double], name : String) -> TimeseriesforecastcombSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_forecast_comb_series_len(s : TimeseriesforecastcombSeries) -> Int { s.vals.length() }

pub fn timeseries_forecast_comb_series_sum(s : TimeseriesforecastcombSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_forecast_comb_series_mean(s : TimeseriesforecastcombSeries) -> Double {
  let n = timeseries_forecast_comb_series_len(s)
  if n == 0 { 0.0 } else { timeseries_forecast_comb_series_sum(s) / n.to_double() }
}

pub fn timeseries_forecast_comb_series_min(s : TimeseriesforecastcombSeries) -> Double {
  let n = timeseries_forecast_comb_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_series_max(s : TimeseriesforecastcombSeries) -> Double {
  let n = timeseries_forecast_comb_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_series_range(s : TimeseriesforecastcombSeries) -> Double {
  timeseries_forecast_comb_series_max(s) - timeseries_forecast_comb_series_min(s)
}

pub fn timeseries_forecast_comb_series_var(s : TimeseriesforecastcombSeries) -> Double {
  let n = timeseries_forecast_comb_series_len(s)
  if n == 0 { 0.0 } else {
    let m = timeseries_forecast_comb_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn timeseries_forecast_comb_series_std(s : TimeseriesforecastcombSeries) -> Double { @_common.sqrt(timeseries_forecast_comb_series_var(s)) }

pub fn timeseries_forecast_comb_series_median(s : TimeseriesforecastcombSeries) -> Double {
  let n = timeseries_forecast_comb_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = timeseries_forecast_comb_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_forecast_comb_series_scale(s : TimeseriesforecastcombSeries, f : Double) -> TimeseriesforecastcombSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_forecast_comb_series_add(a : TimeseriesforecastcombSeries, b : TimeseriesforecastcombSeries) -> TimeseriesforecastcombSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_comb_series_sub(a : TimeseriesforecastcombSeries, b : TimeseriesforecastcombSeries) -> TimeseriesforecastcombSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_comb_series_normalize(s : TimeseriesforecastcombSeries) -> TimeseriesforecastcombSeries {
  let mn = timeseries_forecast_comb_series_min(s)
  let mx = timeseries_forecast_comb_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_forecast_comb_series_cumsum(s : TimeseriesforecastcombSeries) -> TimeseriesforecastcombSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_forecast_comb_series_to_string(s : TimeseriesforecastcombSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastcombMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_comb_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastcombMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_comb_matrix_identity(n : Int) -> TimeseriesforecastcombMatrix {
  let m = timeseries_forecast_comb_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_forecast_comb_matrix_get(m : TimeseriesforecastcombMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_forecast_comb_matrix_transpose(m : TimeseriesforecastcombMatrix) -> TimeseriesforecastcombMatrix {
  let result = timeseries_forecast_comb_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_forecast_comb_matrix_add(a : TimeseriesforecastcombMatrix, b : TimeseriesforecastcombMatrix) -> TimeseriesforecastcombMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_forecast_comb_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_forecast_comb_matrix_scale(m : TimeseriesforecastcombMatrix, s : Double) -> TimeseriesforecastcombMatrix {
  let result = timeseries_forecast_comb_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_forecast_comb_matrix_multiply(a : TimeseriesforecastcombMatrix, b : TimeseriesforecastcombMatrix) -> TimeseriesforecastcombMatrix {
  if a.cols != b.rows { return timeseries_forecast_comb_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_forecast_comb_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_forecast_comb_matrix_trace(m : TimeseriesforecastcombMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_forecast_comb_matrix_det(m : TimeseriesforecastcombMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_forecast_comb_matrix_norm(m : TimeseriesforecastcombMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_forecast_comb_matrix_to_string(m : TimeseriesforecastcombMatrix) -> String {
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

pub(all) struct TimeseriesforecastcombVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_comb_make_vector(comps : Array[Double]) -> TimeseriesforecastcombVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_comb_vector_zero(dim : Int) -> TimeseriesforecastcombVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_forecast_comb_vector_add(a : TimeseriesforecastcombVector, b : TimeseriesforecastcombVector) -> TimeseriesforecastcombVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_forecast_comb_vector_sub(a : TimeseriesforecastcombVector, b : TimeseriesforecastcombVector) -> TimeseriesforecastcombVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_forecast_comb_vector_scale(v : TimeseriesforecastcombVector, s : Double) -> TimeseriesforecastcombVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_forecast_comb_vector_dot(a : TimeseriesforecastcombVector, b : TimeseriesforecastcombVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_forecast_comb_vector_norm(v : TimeseriesforecastcombVector) -> Double { @_common.sqrt(timeseries_forecast_comb_vector_dot(v, v)) }

pub fn timeseries_forecast_comb_vector_normalize(v : TimeseriesforecastcombVector) -> TimeseriesforecastcombVector {
  let n = timeseries_forecast_comb_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_forecast_comb_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_forecast_comb_vector_dist(a : TimeseriesforecastcombVector, b : TimeseriesforecastcombVector) -> Double {
  timeseries_forecast_comb_vector_norm(timeseries_forecast_comb_vector_sub(a, b))
}

pub fn timeseries_forecast_comb_vector_to_string(v : TimeseriesforecastcombVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_comb_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_forecast_comb_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_forecast_comb_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_forecast_comb_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_forecast_comb_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_forecast_comb_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_forecast_comb_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_forecast_comb_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_forecast_comb_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_forecast_comb_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_forecast_comb_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_forecast_comb_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_forecast_comb_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_forecast_comb_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_forecast_comb_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_forecast_comb_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_forecast_comb_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_forecast_comb_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_forecast_comb_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_forecast_comb_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_forecast_comb_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_forecast_comb_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_forecast_comb_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_forecast_comb_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_forecast_comb_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_forecast_comb_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_forecast_comb_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_forecast_comb_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_forecast_comb_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesforecastcombFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_frame_make(size : Int) -> TimeseriesforecastcombFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_frame_len(s : TimeseriesforecastcombFrame) -> Int { s.size }

pub fn timeseries_forecast_comb_frame_get(s : TimeseriesforecastcombFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_frame_set(s : TimeseriesforecastcombFrame, i : Int, v : Double) -> TimeseriesforecastcombFrame {
  let result = timeseries_forecast_comb_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_frame_sum(s : TimeseriesforecastcombFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_comb_frame_mean(s : TimeseriesforecastcombFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_comb_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_comb_frame_scale(s : TimeseriesforecastcombFrame, f : Double) -> TimeseriesforecastcombFrame {
  let result = timeseries_forecast_comb_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_comb_frame_add(a : TimeseriesforecastcombFrame, b : TimeseriesforecastcombFrame) -> TimeseriesforecastcombFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_comb_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_comb_frame_copy(s : TimeseriesforecastcombFrame) -> TimeseriesforecastcombFrame {
  let result = timeseries_forecast_comb_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_comb_frame_fill(s : TimeseriesforecastcombFrame, v : Double) -> TimeseriesforecastcombFrame {
  let result = timeseries_forecast_comb_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_frame_min(s : TimeseriesforecastcombFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_frame_max(s : TimeseriesforecastcombFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_frame_to_string(s : TimeseriesforecastcombFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_table_make(size : Int) -> TimeseriesforecastcombTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_table_len(s : TimeseriesforecastcombTable) -> Int { s.size }

pub fn timeseries_forecast_comb_table_get(s : TimeseriesforecastcombTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_table_set(s : TimeseriesforecastcombTable, i : Int, v : Double) -> TimeseriesforecastcombTable {
  let result = timeseries_forecast_comb_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_table_sum(s : TimeseriesforecastcombTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_comb_table_mean(s : TimeseriesforecastcombTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_comb_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_comb_table_scale(s : TimeseriesforecastcombTable, f : Double) -> TimeseriesforecastcombTable {
  let result = timeseries_forecast_comb_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_comb_table_add(a : TimeseriesforecastcombTable, b : TimeseriesforecastcombTable) -> TimeseriesforecastcombTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_comb_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_comb_table_copy(s : TimeseriesforecastcombTable) -> TimeseriesforecastcombTable {
  let result = timeseries_forecast_comb_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_comb_table_fill(s : TimeseriesforecastcombTable, v : Double) -> TimeseriesforecastcombTable {
  let result = timeseries_forecast_comb_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_table_min(s : TimeseriesforecastcombTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_table_max(s : TimeseriesforecastcombTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_table_to_string(s : TimeseriesforecastcombTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_graphn_make(size : Int) -> TimeseriesforecastcombGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_graphn_len(s : TimeseriesforecastcombGraphN) -> Int { s.size }

pub fn timeseries_forecast_comb_graphn_get(s : TimeseriesforecastcombGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_graphn_set(s : TimeseriesforecastcombGraphN, i : Int, v : Double) -> TimeseriesforecastcombGraphN {
  let result = timeseries_forecast_comb_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_graphn_sum(s : TimeseriesforecastcombGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_comb_graphn_mean(s : TimeseriesforecastcombGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_comb_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_comb_graphn_scale(s : TimeseriesforecastcombGraphN, f : Double) -> TimeseriesforecastcombGraphN {
  let result = timeseries_forecast_comb_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_comb_graphn_add(a : TimeseriesforecastcombGraphN, b : TimeseriesforecastcombGraphN) -> TimeseriesforecastcombGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_comb_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_comb_graphn_copy(s : TimeseriesforecastcombGraphN) -> TimeseriesforecastcombGraphN {
  let result = timeseries_forecast_comb_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_comb_graphn_fill(s : TimeseriesforecastcombGraphN, v : Double) -> TimeseriesforecastcombGraphN {
  let result = timeseries_forecast_comb_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_graphn_min(s : TimeseriesforecastcombGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_graphn_max(s : TimeseriesforecastcombGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_graphn_to_string(s : TimeseriesforecastcombGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_node_make(size : Int) -> TimeseriesforecastcombNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_node_len(s : TimeseriesforecastcombNode) -> Int { s.size }

pub fn timeseries_forecast_comb_node_get(s : TimeseriesforecastcombNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_node_set(s : TimeseriesforecastcombNode, i : Int, v : Double) -> TimeseriesforecastcombNode {
  let result = timeseries_forecast_comb_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_node_sum(s : TimeseriesforecastcombNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_comb_node_mean(s : TimeseriesforecastcombNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_comb_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_comb_node_scale(s : TimeseriesforecastcombNode, f : Double) -> TimeseriesforecastcombNode {
  let result = timeseries_forecast_comb_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_comb_node_add(a : TimeseriesforecastcombNode, b : TimeseriesforecastcombNode) -> TimeseriesforecastcombNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_comb_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_comb_node_copy(s : TimeseriesforecastcombNode) -> TimeseriesforecastcombNode {
  let result = timeseries_forecast_comb_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_comb_node_fill(s : TimeseriesforecastcombNode, v : Double) -> TimeseriesforecastcombNode {
  let result = timeseries_forecast_comb_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_node_min(s : TimeseriesforecastcombNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_node_max(s : TimeseriesforecastcombNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_node_to_string(s : TimeseriesforecastcombNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_edge_make(size : Int) -> TimeseriesforecastcombEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_edge_len(s : TimeseriesforecastcombEdge) -> Int { s.size }

pub fn timeseries_forecast_comb_edge_get(s : TimeseriesforecastcombEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_edge_set(s : TimeseriesforecastcombEdge, i : Int, v : Double) -> TimeseriesforecastcombEdge {
  let result = timeseries_forecast_comb_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_edge_sum(s : TimeseriesforecastcombEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_comb_edge_mean(s : TimeseriesforecastcombEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_comb_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_comb_edge_scale(s : TimeseriesforecastcombEdge, f : Double) -> TimeseriesforecastcombEdge {
  let result = timeseries_forecast_comb_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_comb_edge_add(a : TimeseriesforecastcombEdge, b : TimeseriesforecastcombEdge) -> TimeseriesforecastcombEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_comb_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_comb_edge_copy(s : TimeseriesforecastcombEdge) -> TimeseriesforecastcombEdge {
  let result = timeseries_forecast_comb_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_comb_edge_fill(s : TimeseriesforecastcombEdge, v : Double) -> TimeseriesforecastcombEdge {
  let result = timeseries_forecast_comb_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_edge_min(s : TimeseriesforecastcombEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_edge_max(s : TimeseriesforecastcombEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_edge_to_string(s : TimeseriesforecastcombEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_path_make(size : Int) -> TimeseriesforecastcombPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_path_len(s : TimeseriesforecastcombPath) -> Int { s.size }

pub fn timeseries_forecast_comb_path_get(s : TimeseriesforecastcombPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_path_set(s : TimeseriesforecastcombPath, i : Int, v : Double) -> TimeseriesforecastcombPath {
  let result = timeseries_forecast_comb_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_path_sum(s : TimeseriesforecastcombPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_comb_path_mean(s : TimeseriesforecastcombPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_comb_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_comb_path_scale(s : TimeseriesforecastcombPath, f : Double) -> TimeseriesforecastcombPath {
  let result = timeseries_forecast_comb_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_comb_path_add(a : TimeseriesforecastcombPath, b : TimeseriesforecastcombPath) -> TimeseriesforecastcombPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_comb_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_comb_path_copy(s : TimeseriesforecastcombPath) -> TimeseriesforecastcombPath {
  let result = timeseries_forecast_comb_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_comb_path_fill(s : TimeseriesforecastcombPath, v : Double) -> TimeseriesforecastcombPath {
  let result = timeseries_forecast_comb_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_path_min(s : TimeseriesforecastcombPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_path_max(s : TimeseriesforecastcombPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_path_to_string(s : TimeseriesforecastcombPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_cluster_make(size : Int) -> TimeseriesforecastcombCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_cluster_len(s : TimeseriesforecastcombCluster) -> Int { s.size }

pub fn timeseries_forecast_comb_cluster_get(s : TimeseriesforecastcombCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_cluster_set(s : TimeseriesforecastcombCluster, i : Int, v : Double) -> TimeseriesforecastcombCluster {
  let result = timeseries_forecast_comb_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_cluster_sum(s : TimeseriesforecastcombCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_comb_cluster_mean(s : TimeseriesforecastcombCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_comb_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_comb_cluster_scale(s : TimeseriesforecastcombCluster, f : Double) -> TimeseriesforecastcombCluster {
  let result = timeseries_forecast_comb_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_comb_cluster_add(a : TimeseriesforecastcombCluster, b : TimeseriesforecastcombCluster) -> TimeseriesforecastcombCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_comb_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_comb_cluster_copy(s : TimeseriesforecastcombCluster) -> TimeseriesforecastcombCluster {
  let result = timeseries_forecast_comb_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_comb_cluster_fill(s : TimeseriesforecastcombCluster, v : Double) -> TimeseriesforecastcombCluster {
  let result = timeseries_forecast_comb_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_cluster_min(s : TimeseriesforecastcombCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_cluster_max(s : TimeseriesforecastcombCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_cluster_to_string(s : TimeseriesforecastcombCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_model_make(size : Int) -> TimeseriesforecastcombModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_model_len(s : TimeseriesforecastcombModel) -> Int { s.size }

pub fn timeseries_forecast_comb_model_get(s : TimeseriesforecastcombModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_model_set(s : TimeseriesforecastcombModel, i : Int, v : Double) -> TimeseriesforecastcombModel {
  let result = timeseries_forecast_comb_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_model_sum(s : TimeseriesforecastcombModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_comb_model_mean(s : TimeseriesforecastcombModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_comb_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_comb_model_scale(s : TimeseriesforecastcombModel, f : Double) -> TimeseriesforecastcombModel {
  let result = timeseries_forecast_comb_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_comb_model_add(a : TimeseriesforecastcombModel, b : TimeseriesforecastcombModel) -> TimeseriesforecastcombModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_comb_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_comb_model_copy(s : TimeseriesforecastcombModel) -> TimeseriesforecastcombModel {
  let result = timeseries_forecast_comb_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_comb_model_fill(s : TimeseriesforecastcombModel, v : Double) -> TimeseriesforecastcombModel {
  let result = timeseries_forecast_comb_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_model_min(s : TimeseriesforecastcombModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_model_max(s : TimeseriesforecastcombModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_model_to_string(s : TimeseriesforecastcombModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_layer_make(size : Int) -> TimeseriesforecastcombLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_layer_len(s : TimeseriesforecastcombLayer) -> Int { s.size }

pub fn timeseries_forecast_comb_layer_get(s : TimeseriesforecastcombLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_layer_set(s : TimeseriesforecastcombLayer, i : Int, v : Double) -> TimeseriesforecastcombLayer {
  let result = timeseries_forecast_comb_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_layer_sum(s : TimeseriesforecastcombLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_comb_layer_mean(s : TimeseriesforecastcombLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_comb_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_comb_layer_scale(s : TimeseriesforecastcombLayer, f : Double) -> TimeseriesforecastcombLayer {
  let result = timeseries_forecast_comb_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_comb_layer_add(a : TimeseriesforecastcombLayer, b : TimeseriesforecastcombLayer) -> TimeseriesforecastcombLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_comb_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_comb_layer_copy(s : TimeseriesforecastcombLayer) -> TimeseriesforecastcombLayer {
  let result = timeseries_forecast_comb_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_comb_layer_fill(s : TimeseriesforecastcombLayer, v : Double) -> TimeseriesforecastcombLayer {
  let result = timeseries_forecast_comb_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_layer_min(s : TimeseriesforecastcombLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_layer_max(s : TimeseriesforecastcombLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_layer_to_string(s : TimeseriesforecastcombLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_buffer_make(size : Int) -> TimeseriesforecastcombBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_buffer_len(s : TimeseriesforecastcombBuffer) -> Int { s.size }

pub fn timeseries_forecast_comb_buffer_get(s : TimeseriesforecastcombBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_buffer_set(s : TimeseriesforecastcombBuffer, i : Int, v : Double) -> TimeseriesforecastcombBuffer {
  let result = timeseries_forecast_comb_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_buffer_sum(s : TimeseriesforecastcombBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_comb_buffer_mean(s : TimeseriesforecastcombBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_comb_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_comb_buffer_scale(s : TimeseriesforecastcombBuffer, f : Double) -> TimeseriesforecastcombBuffer {
  let result = timeseries_forecast_comb_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_comb_buffer_add(a : TimeseriesforecastcombBuffer, b : TimeseriesforecastcombBuffer) -> TimeseriesforecastcombBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_comb_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_comb_buffer_copy(s : TimeseriesforecastcombBuffer) -> TimeseriesforecastcombBuffer {
  let result = timeseries_forecast_comb_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_comb_buffer_fill(s : TimeseriesforecastcombBuffer, v : Double) -> TimeseriesforecastcombBuffer {
  let result = timeseries_forecast_comb_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_buffer_min(s : TimeseriesforecastcombBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_buffer_max(s : TimeseriesforecastcombBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_buffer_to_string(s : TimeseriesforecastcombBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_cursor_make(size : Int) -> TimeseriesforecastcombCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_cursor_len(s : TimeseriesforecastcombCursor) -> Int { s.size }

pub fn timeseries_forecast_comb_cursor_get(s : TimeseriesforecastcombCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_cursor_set(s : TimeseriesforecastcombCursor, i : Int, v : Double) -> TimeseriesforecastcombCursor {
  let result = timeseries_forecast_comb_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_cursor_sum(s : TimeseriesforecastcombCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_comb_cursor_mean(s : TimeseriesforecastcombCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_comb_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_comb_cursor_scale(s : TimeseriesforecastcombCursor, f : Double) -> TimeseriesforecastcombCursor {
  let result = timeseries_forecast_comb_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_comb_cursor_add(a : TimeseriesforecastcombCursor, b : TimeseriesforecastcombCursor) -> TimeseriesforecastcombCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_comb_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_comb_cursor_copy(s : TimeseriesforecastcombCursor) -> TimeseriesforecastcombCursor {
  let result = timeseries_forecast_comb_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_comb_cursor_fill(s : TimeseriesforecastcombCursor, v : Double) -> TimeseriesforecastcombCursor {
  let result = timeseries_forecast_comb_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_cursor_min(s : TimeseriesforecastcombCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_cursor_max(s : TimeseriesforecastcombCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_cursor_to_string(s : TimeseriesforecastcombCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_view_make(size : Int) -> TimeseriesforecastcombView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_view_len(s : TimeseriesforecastcombView) -> Int { s.size }

pub fn timeseries_forecast_comb_view_get(s : TimeseriesforecastcombView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_view_set(s : TimeseriesforecastcombView, i : Int, v : Double) -> TimeseriesforecastcombView {
  let result = timeseries_forecast_comb_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_view_sum(s : TimeseriesforecastcombView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_comb_view_mean(s : TimeseriesforecastcombView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_comb_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_comb_view_scale(s : TimeseriesforecastcombView, f : Double) -> TimeseriesforecastcombView {
  let result = timeseries_forecast_comb_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_comb_view_add(a : TimeseriesforecastcombView, b : TimeseriesforecastcombView) -> TimeseriesforecastcombView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_comb_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_comb_view_copy(s : TimeseriesforecastcombView) -> TimeseriesforecastcombView {
  let result = timeseries_forecast_comb_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_comb_view_fill(s : TimeseriesforecastcombView, v : Double) -> TimeseriesforecastcombView {
  let result = timeseries_forecast_comb_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_view_min(s : TimeseriesforecastcombView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_view_max(s : TimeseriesforecastcombView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_view_to_string(s : TimeseriesforecastcombView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_range_make(size : Int) -> TimeseriesforecastcombRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_range_len(s : TimeseriesforecastcombRange) -> Int { s.size }

pub fn timeseries_forecast_comb_range_get(s : TimeseriesforecastcombRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_range_set(s : TimeseriesforecastcombRange, i : Int, v : Double) -> TimeseriesforecastcombRange {
  let result = timeseries_forecast_comb_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_range_sum(s : TimeseriesforecastcombRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_comb_range_mean(s : TimeseriesforecastcombRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_comb_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_comb_range_scale(s : TimeseriesforecastcombRange, f : Double) -> TimeseriesforecastcombRange {
  let result = timeseries_forecast_comb_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_comb_range_add(a : TimeseriesforecastcombRange, b : TimeseriesforecastcombRange) -> TimeseriesforecastcombRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_comb_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_comb_range_copy(s : TimeseriesforecastcombRange) -> TimeseriesforecastcombRange {
  let result = timeseries_forecast_comb_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_comb_range_fill(s : TimeseriesforecastcombRange, v : Double) -> TimeseriesforecastcombRange {
  let result = timeseries_forecast_comb_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_range_min(s : TimeseriesforecastcombRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_range_max(s : TimeseriesforecastcombRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_range_to_string(s : TimeseriesforecastcombRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_slice_make(size : Int) -> TimeseriesforecastcombSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_slice_len(s : TimeseriesforecastcombSlice) -> Int { s.size }

pub fn timeseries_forecast_comb_slice_get(s : TimeseriesforecastcombSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_slice_set(s : TimeseriesforecastcombSlice, i : Int, v : Double) -> TimeseriesforecastcombSlice {
  let result = timeseries_forecast_comb_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_slice_sum(s : TimeseriesforecastcombSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_comb_slice_mean(s : TimeseriesforecastcombSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_comb_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_comb_slice_scale(s : TimeseriesforecastcombSlice, f : Double) -> TimeseriesforecastcombSlice {
  let result = timeseries_forecast_comb_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_comb_slice_add(a : TimeseriesforecastcombSlice, b : TimeseriesforecastcombSlice) -> TimeseriesforecastcombSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_comb_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_comb_slice_copy(s : TimeseriesforecastcombSlice) -> TimeseriesforecastcombSlice {
  let result = timeseries_forecast_comb_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_comb_slice_fill(s : TimeseriesforecastcombSlice, v : Double) -> TimeseriesforecastcombSlice {
  let result = timeseries_forecast_comb_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_comb_slice_min(s : TimeseriesforecastcombSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_slice_max(s : TimeseriesforecastcombSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_comb_slice_to_string(s : TimeseriesforecastcombSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

