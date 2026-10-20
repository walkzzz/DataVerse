///===
/// extcore/timeseries_forecast_deepar

pub(all) struct TimeseriesforecastdeeparPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_deepar_make_point(x : Double, y : Double) -> TimeseriesforecastdeeparPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_deepar_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastdeeparPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_forecast_deepar_point_x(pt : TimeseriesforecastdeeparPoint) -> Double { pt.x }

pub fn timeseries_forecast_deepar_point_y(pt : TimeseriesforecastdeeparPoint) -> Double { pt.y }

pub fn timeseries_forecast_deepar_point_z(pt : TimeseriesforecastdeeparPoint) -> Double { pt.z }

pub fn timeseries_forecast_deepar_point_label(pt : TimeseriesforecastdeeparPoint) -> Int { pt.label }

pub fn timeseries_forecast_deepar_point_dist(a : TimeseriesforecastdeeparPoint, b : TimeseriesforecastdeeparPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_forecast_deepar_point_add(a : TimeseriesforecastdeeparPoint, b : TimeseriesforecastdeeparPoint) -> TimeseriesforecastdeeparPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_forecast_deepar_point_sub(a : TimeseriesforecastdeeparPoint, b : TimeseriesforecastdeeparPoint) -> TimeseriesforecastdeeparPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_forecast_deepar_point_scale(pt : TimeseriesforecastdeeparPoint, s : Double) -> TimeseriesforecastdeeparPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_forecast_deepar_point_dot(a : TimeseriesforecastdeeparPoint, b : TimeseriesforecastdeeparPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_forecast_deepar_point_cross(a : TimeseriesforecastdeeparPoint, b : TimeseriesforecastdeeparPoint) -> TimeseriesforecastdeeparPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_forecast_deepar_point_norm(pt : TimeseriesforecastdeeparPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_forecast_deepar_point_normalize(pt : TimeseriesforecastdeeparPoint) -> TimeseriesforecastdeeparPoint {
  let n = timeseries_forecast_deepar_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_forecast_deepar_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_forecast_deepar_point_negate(pt : TimeseriesforecastdeeparPoint) -> TimeseriesforecastdeeparPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_forecast_deepar_point_mid(a : TimeseriesforecastdeeparPoint, b : TimeseriesforecastdeeparPoint) -> TimeseriesforecastdeeparPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_forecast_deepar_point_lerp(a : TimeseriesforecastdeeparPoint, b : TimeseriesforecastdeeparPoint, t : Double) -> TimeseriesforecastdeeparPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_forecast_deepar_point_to_string(pt : TimeseriesforecastdeeparPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_deepar_make_series(vals : Array[Double], name : String) -> TimeseriesforecastdeeparSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_forecast_deepar_series_len(s : TimeseriesforecastdeeparSeries) -> Int { s.vals.length() }

pub fn timeseries_forecast_deepar_series_sum(s : TimeseriesforecastdeeparSeries) -> Double { @_common.sum(s.vals) }

pub fn timeseries_forecast_deepar_series_mean(s : TimeseriesforecastdeeparSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_forecast_deepar_series_min(s : TimeseriesforecastdeeparSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_forecast_deepar_series_max(s : TimeseriesforecastdeeparSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_forecast_deepar_series_range(s : TimeseriesforecastdeeparSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_forecast_deepar_series_var(s : TimeseriesforecastdeeparSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_forecast_deepar_series_std(s : TimeseriesforecastdeeparSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_forecast_deepar_series_median(s : TimeseriesforecastdeeparSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_forecast_deepar_series_scale(s : TimeseriesforecastdeeparSeries, f : Double) -> TimeseriesforecastdeeparSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_forecast_deepar_series_add(a : TimeseriesforecastdeeparSeries, b : TimeseriesforecastdeeparSeries) -> TimeseriesforecastdeeparSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_deepar_series_sub(a : TimeseriesforecastdeeparSeries, b : TimeseriesforecastdeeparSeries) -> TimeseriesforecastdeeparSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_deepar_series_normalize(s : TimeseriesforecastdeeparSeries) -> TimeseriesforecastdeeparSeries {
  let mn = timeseries_forecast_deepar_series_min(s)
  let mx = timeseries_forecast_deepar_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_forecast_deepar_series_cumsum(s : TimeseriesforecastdeeparSeries) -> TimeseriesforecastdeeparSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_forecast_deepar_series_to_string(s : TimeseriesforecastdeeparSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastdeeparMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_deepar_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastdeeparMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_deepar_matrix_identity(n : Int) -> TimeseriesforecastdeeparMatrix {
  let m = timeseries_forecast_deepar_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_forecast_deepar_matrix_get(m : TimeseriesforecastdeeparMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_forecast_deepar_matrix_transpose(m : TimeseriesforecastdeeparMatrix) -> TimeseriesforecastdeeparMatrix {
  let result = timeseries_forecast_deepar_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_forecast_deepar_matrix_add(a : TimeseriesforecastdeeparMatrix, b : TimeseriesforecastdeeparMatrix) -> TimeseriesforecastdeeparMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_forecast_deepar_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_forecast_deepar_matrix_scale(m : TimeseriesforecastdeeparMatrix, s : Double) -> TimeseriesforecastdeeparMatrix {
  let result = timeseries_forecast_deepar_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_forecast_deepar_matrix_multiply(a : TimeseriesforecastdeeparMatrix, b : TimeseriesforecastdeeparMatrix) -> TimeseriesforecastdeeparMatrix {
  if a.cols != b.rows { return timeseries_forecast_deepar_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_forecast_deepar_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_forecast_deepar_matrix_trace(m : TimeseriesforecastdeeparMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_forecast_deepar_matrix_det(m : TimeseriesforecastdeeparMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_forecast_deepar_matrix_norm(m : TimeseriesforecastdeeparMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_forecast_deepar_matrix_to_string(m : TimeseriesforecastdeeparMatrix) -> String {
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

pub(all) struct TimeseriesforecastdeeparVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_deepar_make_vector(comps : Array[Double]) -> TimeseriesforecastdeeparVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_deepar_vector_zero(dim : Int) -> TimeseriesforecastdeeparVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_forecast_deepar_vector_add(a : TimeseriesforecastdeeparVector, b : TimeseriesforecastdeeparVector) -> TimeseriesforecastdeeparVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_forecast_deepar_vector_sub(a : TimeseriesforecastdeeparVector, b : TimeseriesforecastdeeparVector) -> TimeseriesforecastdeeparVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_forecast_deepar_vector_scale(v : TimeseriesforecastdeeparVector, s : Double) -> TimeseriesforecastdeeparVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_forecast_deepar_vector_dot(a : TimeseriesforecastdeeparVector, b : TimeseriesforecastdeeparVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_forecast_deepar_vector_norm(v : TimeseriesforecastdeeparVector) -> Double { @_common.sqrt(timeseries_forecast_deepar_vector_dot(v, v)) }

pub fn timeseries_forecast_deepar_vector_normalize(v : TimeseriesforecastdeeparVector) -> TimeseriesforecastdeeparVector {
  let n = timeseries_forecast_deepar_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_forecast_deepar_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_forecast_deepar_vector_dist(a : TimeseriesforecastdeeparVector, b : TimeseriesforecastdeeparVector) -> Double {
  timeseries_forecast_deepar_vector_norm(timeseries_forecast_deepar_vector_sub(a, b))
}

pub fn timeseries_forecast_deepar_vector_to_string(v : TimeseriesforecastdeeparVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_deepar_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_forecast_deepar_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_forecast_deepar_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_forecast_deepar_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_forecast_deepar_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_forecast_deepar_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_forecast_deepar_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_forecast_deepar_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_forecast_deepar_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_forecast_deepar_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_forecast_deepar_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_forecast_deepar_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_forecast_deepar_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_forecast_deepar_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_forecast_deepar_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_forecast_deepar_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_forecast_deepar_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_forecast_deepar_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_forecast_deepar_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_forecast_deepar_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_forecast_deepar_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_forecast_deepar_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_forecast_deepar_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_forecast_deepar_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_forecast_deepar_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_forecast_deepar_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_forecast_deepar_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_forecast_deepar_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_forecast_deepar_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesforecastdeeparFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_frame_make(size : Int) -> TimeseriesforecastdeeparFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_frame_len(s : TimeseriesforecastdeeparFrame) -> Int { s.size }

pub fn timeseries_forecast_deepar_frame_get(s : TimeseriesforecastdeeparFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_frame_set(s : TimeseriesforecastdeeparFrame, i : Int, v : Double) -> TimeseriesforecastdeeparFrame {
  let result = timeseries_forecast_deepar_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_deepar_frame_sum(s : TimeseriesforecastdeeparFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_frame_mean(s : TimeseriesforecastdeeparFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_frame_scale(s : TimeseriesforecastdeeparFrame, f : Double) -> TimeseriesforecastdeeparFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_frame_add(a : TimeseriesforecastdeeparFrame, b : TimeseriesforecastdeeparFrame) -> TimeseriesforecastdeeparFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_frame_copy(s : TimeseriesforecastdeeparFrame) -> TimeseriesforecastdeeparFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_frame_fill(s : TimeseriesforecastdeeparFrame, v : Double) -> TimeseriesforecastdeeparFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_frame_min(s : TimeseriesforecastdeeparFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_frame_max(s : TimeseriesforecastdeeparFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_frame_to_string(s : TimeseriesforecastdeeparFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_table_make(size : Int) -> TimeseriesforecastdeeparTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_table_len(s : TimeseriesforecastdeeparTable) -> Int { s.size }

pub fn timeseries_forecast_deepar_table_get(s : TimeseriesforecastdeeparTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_table_set(s : TimeseriesforecastdeeparTable, i : Int, v : Double) -> TimeseriesforecastdeeparTable {
  let result = timeseries_forecast_deepar_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_deepar_table_sum(s : TimeseriesforecastdeeparTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_table_mean(s : TimeseriesforecastdeeparTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_table_scale(s : TimeseriesforecastdeeparTable, f : Double) -> TimeseriesforecastdeeparTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_table_add(a : TimeseriesforecastdeeparTable, b : TimeseriesforecastdeeparTable) -> TimeseriesforecastdeeparTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_table_copy(s : TimeseriesforecastdeeparTable) -> TimeseriesforecastdeeparTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_table_fill(s : TimeseriesforecastdeeparTable, v : Double) -> TimeseriesforecastdeeparTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_table_min(s : TimeseriesforecastdeeparTable) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_table_max(s : TimeseriesforecastdeeparTable) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_table_to_string(s : TimeseriesforecastdeeparTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_graphn_make(size : Int) -> TimeseriesforecastdeeparGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_graphn_len(s : TimeseriesforecastdeeparGraphN) -> Int { s.size }

pub fn timeseries_forecast_deepar_graphn_get(s : TimeseriesforecastdeeparGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_graphn_set(s : TimeseriesforecastdeeparGraphN, i : Int, v : Double) -> TimeseriesforecastdeeparGraphN {
  let result = timeseries_forecast_deepar_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_deepar_graphn_sum(s : TimeseriesforecastdeeparGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_graphn_mean(s : TimeseriesforecastdeeparGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_graphn_scale(s : TimeseriesforecastdeeparGraphN, f : Double) -> TimeseriesforecastdeeparGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_graphn_add(a : TimeseriesforecastdeeparGraphN, b : TimeseriesforecastdeeparGraphN) -> TimeseriesforecastdeeparGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_graphn_copy(s : TimeseriesforecastdeeparGraphN) -> TimeseriesforecastdeeparGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_graphn_fill(s : TimeseriesforecastdeeparGraphN, v : Double) -> TimeseriesforecastdeeparGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_graphn_min(s : TimeseriesforecastdeeparGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_graphn_max(s : TimeseriesforecastdeeparGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_graphn_to_string(s : TimeseriesforecastdeeparGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_node_make(size : Int) -> TimeseriesforecastdeeparNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_node_len(s : TimeseriesforecastdeeparNode) -> Int { s.size }

pub fn timeseries_forecast_deepar_node_get(s : TimeseriesforecastdeeparNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_node_set(s : TimeseriesforecastdeeparNode, i : Int, v : Double) -> TimeseriesforecastdeeparNode {
  let result = timeseries_forecast_deepar_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_deepar_node_sum(s : TimeseriesforecastdeeparNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_node_mean(s : TimeseriesforecastdeeparNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_node_scale(s : TimeseriesforecastdeeparNode, f : Double) -> TimeseriesforecastdeeparNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_node_add(a : TimeseriesforecastdeeparNode, b : TimeseriesforecastdeeparNode) -> TimeseriesforecastdeeparNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_node_copy(s : TimeseriesforecastdeeparNode) -> TimeseriesforecastdeeparNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_node_fill(s : TimeseriesforecastdeeparNode, v : Double) -> TimeseriesforecastdeeparNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_node_min(s : TimeseriesforecastdeeparNode) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_node_max(s : TimeseriesforecastdeeparNode) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_node_to_string(s : TimeseriesforecastdeeparNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_edge_make(size : Int) -> TimeseriesforecastdeeparEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_edge_len(s : TimeseriesforecastdeeparEdge) -> Int { s.size }

pub fn timeseries_forecast_deepar_edge_get(s : TimeseriesforecastdeeparEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_edge_set(s : TimeseriesforecastdeeparEdge, i : Int, v : Double) -> TimeseriesforecastdeeparEdge {
  let result = timeseries_forecast_deepar_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_deepar_edge_sum(s : TimeseriesforecastdeeparEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_edge_mean(s : TimeseriesforecastdeeparEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_edge_scale(s : TimeseriesforecastdeeparEdge, f : Double) -> TimeseriesforecastdeeparEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_edge_add(a : TimeseriesforecastdeeparEdge, b : TimeseriesforecastdeeparEdge) -> TimeseriesforecastdeeparEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_edge_copy(s : TimeseriesforecastdeeparEdge) -> TimeseriesforecastdeeparEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_edge_fill(s : TimeseriesforecastdeeparEdge, v : Double) -> TimeseriesforecastdeeparEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_edge_min(s : TimeseriesforecastdeeparEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_edge_max(s : TimeseriesforecastdeeparEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_edge_to_string(s : TimeseriesforecastdeeparEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_path_make(size : Int) -> TimeseriesforecastdeeparPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_path_len(s : TimeseriesforecastdeeparPath) -> Int { s.size }

pub fn timeseries_forecast_deepar_path_get(s : TimeseriesforecastdeeparPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_path_set(s : TimeseriesforecastdeeparPath, i : Int, v : Double) -> TimeseriesforecastdeeparPath {
  let result = timeseries_forecast_deepar_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_deepar_path_sum(s : TimeseriesforecastdeeparPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_path_mean(s : TimeseriesforecastdeeparPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_path_scale(s : TimeseriesforecastdeeparPath, f : Double) -> TimeseriesforecastdeeparPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_path_add(a : TimeseriesforecastdeeparPath, b : TimeseriesforecastdeeparPath) -> TimeseriesforecastdeeparPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_path_copy(s : TimeseriesforecastdeeparPath) -> TimeseriesforecastdeeparPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_path_fill(s : TimeseriesforecastdeeparPath, v : Double) -> TimeseriesforecastdeeparPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_path_min(s : TimeseriesforecastdeeparPath) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_path_max(s : TimeseriesforecastdeeparPath) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_path_to_string(s : TimeseriesforecastdeeparPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_cluster_make(size : Int) -> TimeseriesforecastdeeparCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_cluster_len(s : TimeseriesforecastdeeparCluster) -> Int { s.size }

pub fn timeseries_forecast_deepar_cluster_get(s : TimeseriesforecastdeeparCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_cluster_set(s : TimeseriesforecastdeeparCluster, i : Int, v : Double) -> TimeseriesforecastdeeparCluster {
  let result = timeseries_forecast_deepar_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_deepar_cluster_sum(s : TimeseriesforecastdeeparCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_cluster_mean(s : TimeseriesforecastdeeparCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_cluster_scale(s : TimeseriesforecastdeeparCluster, f : Double) -> TimeseriesforecastdeeparCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_cluster_add(a : TimeseriesforecastdeeparCluster, b : TimeseriesforecastdeeparCluster) -> TimeseriesforecastdeeparCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_cluster_copy(s : TimeseriesforecastdeeparCluster) -> TimeseriesforecastdeeparCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_cluster_fill(s : TimeseriesforecastdeeparCluster, v : Double) -> TimeseriesforecastdeeparCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_cluster_min(s : TimeseriesforecastdeeparCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_cluster_max(s : TimeseriesforecastdeeparCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_cluster_to_string(s : TimeseriesforecastdeeparCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_model_make(size : Int) -> TimeseriesforecastdeeparModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_model_len(s : TimeseriesforecastdeeparModel) -> Int { s.size }

pub fn timeseries_forecast_deepar_model_get(s : TimeseriesforecastdeeparModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_model_set(s : TimeseriesforecastdeeparModel, i : Int, v : Double) -> TimeseriesforecastdeeparModel {
  let result = timeseries_forecast_deepar_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_deepar_model_sum(s : TimeseriesforecastdeeparModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_model_mean(s : TimeseriesforecastdeeparModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_model_scale(s : TimeseriesforecastdeeparModel, f : Double) -> TimeseriesforecastdeeparModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_model_add(a : TimeseriesforecastdeeparModel, b : TimeseriesforecastdeeparModel) -> TimeseriesforecastdeeparModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_model_copy(s : TimeseriesforecastdeeparModel) -> TimeseriesforecastdeeparModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_model_fill(s : TimeseriesforecastdeeparModel, v : Double) -> TimeseriesforecastdeeparModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_model_min(s : TimeseriesforecastdeeparModel) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_model_max(s : TimeseriesforecastdeeparModel) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_model_to_string(s : TimeseriesforecastdeeparModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_layer_make(size : Int) -> TimeseriesforecastdeeparLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_layer_len(s : TimeseriesforecastdeeparLayer) -> Int { s.size }

pub fn timeseries_forecast_deepar_layer_get(s : TimeseriesforecastdeeparLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_layer_set(s : TimeseriesforecastdeeparLayer, i : Int, v : Double) -> TimeseriesforecastdeeparLayer {
  let result = timeseries_forecast_deepar_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_deepar_layer_sum(s : TimeseriesforecastdeeparLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_layer_mean(s : TimeseriesforecastdeeparLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_layer_scale(s : TimeseriesforecastdeeparLayer, f : Double) -> TimeseriesforecastdeeparLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_layer_add(a : TimeseriesforecastdeeparLayer, b : TimeseriesforecastdeeparLayer) -> TimeseriesforecastdeeparLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_layer_copy(s : TimeseriesforecastdeeparLayer) -> TimeseriesforecastdeeparLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_layer_fill(s : TimeseriesforecastdeeparLayer, v : Double) -> TimeseriesforecastdeeparLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_layer_min(s : TimeseriesforecastdeeparLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_layer_max(s : TimeseriesforecastdeeparLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_layer_to_string(s : TimeseriesforecastdeeparLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_buffer_make(size : Int) -> TimeseriesforecastdeeparBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_buffer_len(s : TimeseriesforecastdeeparBuffer) -> Int { s.size }

pub fn timeseries_forecast_deepar_buffer_get(s : TimeseriesforecastdeeparBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_buffer_set(s : TimeseriesforecastdeeparBuffer, i : Int, v : Double) -> TimeseriesforecastdeeparBuffer {
  let result = timeseries_forecast_deepar_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_deepar_buffer_sum(s : TimeseriesforecastdeeparBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_buffer_mean(s : TimeseriesforecastdeeparBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_buffer_scale(s : TimeseriesforecastdeeparBuffer, f : Double) -> TimeseriesforecastdeeparBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_buffer_add(a : TimeseriesforecastdeeparBuffer, b : TimeseriesforecastdeeparBuffer) -> TimeseriesforecastdeeparBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_buffer_copy(s : TimeseriesforecastdeeparBuffer) -> TimeseriesforecastdeeparBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_buffer_fill(s : TimeseriesforecastdeeparBuffer, v : Double) -> TimeseriesforecastdeeparBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_buffer_min(s : TimeseriesforecastdeeparBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_buffer_max(s : TimeseriesforecastdeeparBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_buffer_to_string(s : TimeseriesforecastdeeparBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_cursor_make(size : Int) -> TimeseriesforecastdeeparCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_cursor_len(s : TimeseriesforecastdeeparCursor) -> Int { s.size }

pub fn timeseries_forecast_deepar_cursor_get(s : TimeseriesforecastdeeparCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_cursor_set(s : TimeseriesforecastdeeparCursor, i : Int, v : Double) -> TimeseriesforecastdeeparCursor {
  let result = timeseries_forecast_deepar_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_deepar_cursor_sum(s : TimeseriesforecastdeeparCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_cursor_mean(s : TimeseriesforecastdeeparCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_cursor_scale(s : TimeseriesforecastdeeparCursor, f : Double) -> TimeseriesforecastdeeparCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_cursor_add(a : TimeseriesforecastdeeparCursor, b : TimeseriesforecastdeeparCursor) -> TimeseriesforecastdeeparCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_cursor_copy(s : TimeseriesforecastdeeparCursor) -> TimeseriesforecastdeeparCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_cursor_fill(s : TimeseriesforecastdeeparCursor, v : Double) -> TimeseriesforecastdeeparCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_cursor_min(s : TimeseriesforecastdeeparCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_cursor_max(s : TimeseriesforecastdeeparCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_cursor_to_string(s : TimeseriesforecastdeeparCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_view_make(size : Int) -> TimeseriesforecastdeeparView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_view_len(s : TimeseriesforecastdeeparView) -> Int { s.size }

pub fn timeseries_forecast_deepar_view_get(s : TimeseriesforecastdeeparView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_view_set(s : TimeseriesforecastdeeparView, i : Int, v : Double) -> TimeseriesforecastdeeparView {
  let result = timeseries_forecast_deepar_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_deepar_view_sum(s : TimeseriesforecastdeeparView) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_view_mean(s : TimeseriesforecastdeeparView) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_view_scale(s : TimeseriesforecastdeeparView, f : Double) -> TimeseriesforecastdeeparView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_view_add(a : TimeseriesforecastdeeparView, b : TimeseriesforecastdeeparView) -> TimeseriesforecastdeeparView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_view_copy(s : TimeseriesforecastdeeparView) -> TimeseriesforecastdeeparView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_view_fill(s : TimeseriesforecastdeeparView, v : Double) -> TimeseriesforecastdeeparView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_view_min(s : TimeseriesforecastdeeparView) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_view_max(s : TimeseriesforecastdeeparView) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_view_to_string(s : TimeseriesforecastdeeparView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_range_make(size : Int) -> TimeseriesforecastdeeparRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_range_len(s : TimeseriesforecastdeeparRange) -> Int { s.size }

pub fn timeseries_forecast_deepar_range_get(s : TimeseriesforecastdeeparRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_range_set(s : TimeseriesforecastdeeparRange, i : Int, v : Double) -> TimeseriesforecastdeeparRange {
  let result = timeseries_forecast_deepar_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_deepar_range_sum(s : TimeseriesforecastdeeparRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_range_mean(s : TimeseriesforecastdeeparRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_range_scale(s : TimeseriesforecastdeeparRange, f : Double) -> TimeseriesforecastdeeparRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_range_add(a : TimeseriesforecastdeeparRange, b : TimeseriesforecastdeeparRange) -> TimeseriesforecastdeeparRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_range_copy(s : TimeseriesforecastdeeparRange) -> TimeseriesforecastdeeparRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_range_fill(s : TimeseriesforecastdeeparRange, v : Double) -> TimeseriesforecastdeeparRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_range_min(s : TimeseriesforecastdeeparRange) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_range_max(s : TimeseriesforecastdeeparRange) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_range_to_string(s : TimeseriesforecastdeeparRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_slice_make(size : Int) -> TimeseriesforecastdeeparSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_slice_len(s : TimeseriesforecastdeeparSlice) -> Int { s.size }

pub fn timeseries_forecast_deepar_slice_get(s : TimeseriesforecastdeeparSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_slice_set(s : TimeseriesforecastdeeparSlice, i : Int, v : Double) -> TimeseriesforecastdeeparSlice {
  let result = timeseries_forecast_deepar_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_deepar_slice_sum(s : TimeseriesforecastdeeparSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_slice_mean(s : TimeseriesforecastdeeparSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_slice_scale(s : TimeseriesforecastdeeparSlice, f : Double) -> TimeseriesforecastdeeparSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_slice_add(a : TimeseriesforecastdeeparSlice, b : TimeseriesforecastdeeparSlice) -> TimeseriesforecastdeeparSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_slice_copy(s : TimeseriesforecastdeeparSlice) -> TimeseriesforecastdeeparSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_slice_fill(s : TimeseriesforecastdeeparSlice, v : Double) -> TimeseriesforecastdeeparSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_slice_min(s : TimeseriesforecastdeeparSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_slice_max(s : TimeseriesforecastdeeparSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_slice_to_string(s : TimeseriesforecastdeeparSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

