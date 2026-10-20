///===
/// extcore/timeseries_arch

pub(all) struct TimeseriesarchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_arch_make_point(x : Double, y : Double) -> TimeseriesarchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_arch_make_point3(x : Double, y : Double, z : Double) -> TimeseriesarchPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_arch_point_x(pt : TimeseriesarchPoint) -> Double { pt.x }

pub fn timeseries_arch_point_y(pt : TimeseriesarchPoint) -> Double { pt.y }

pub fn timeseries_arch_point_z(pt : TimeseriesarchPoint) -> Double { pt.z }

pub fn timeseries_arch_point_label(pt : TimeseriesarchPoint) -> Int { pt.label }

pub fn timeseries_arch_point_dist(a : TimeseriesarchPoint, b : TimeseriesarchPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_arch_point_add(a : TimeseriesarchPoint, b : TimeseriesarchPoint) -> TimeseriesarchPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_arch_point_sub(a : TimeseriesarchPoint, b : TimeseriesarchPoint) -> TimeseriesarchPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_arch_point_scale(pt : TimeseriesarchPoint, s : Double) -> TimeseriesarchPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_arch_point_dot(a : TimeseriesarchPoint, b : TimeseriesarchPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_arch_point_cross(a : TimeseriesarchPoint, b : TimeseriesarchPoint) -> TimeseriesarchPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_arch_point_norm(pt : TimeseriesarchPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_arch_point_normalize(pt : TimeseriesarchPoint) -> TimeseriesarchPoint {
  let n = timeseries_arch_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_arch_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_arch_point_negate(pt : TimeseriesarchPoint) -> TimeseriesarchPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_arch_point_mid(a : TimeseriesarchPoint, b : TimeseriesarchPoint) -> TimeseriesarchPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_arch_point_lerp(a : TimeseriesarchPoint, b : TimeseriesarchPoint, t : Double) -> TimeseriesarchPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_arch_point_to_string(pt : TimeseriesarchPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesarchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_arch_make_series(vals : Array[Double], name : String) -> TimeseriesarchSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_arch_series_len(s : TimeseriesarchSeries) -> Int { s.vals.length() }

pub fn timeseries_arch_series_sum(s : TimeseriesarchSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_arch_series_mean(s : TimeseriesarchSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_arch_series_min(s : TimeseriesarchSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_arch_series_max(s : TimeseriesarchSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_arch_series_range(s : TimeseriesarchSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_arch_series_var(s : TimeseriesarchSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_arch_series_std(s : TimeseriesarchSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_arch_series_median(s : TimeseriesarchSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_arch_series_scale(s : TimeseriesarchSeries, f : Double) -> TimeseriesarchSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_arch_series_add(a : TimeseriesarchSeries, b : TimeseriesarchSeries) -> TimeseriesarchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_arch_series_sub(a : TimeseriesarchSeries, b : TimeseriesarchSeries) -> TimeseriesarchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_arch_series_normalize(s : TimeseriesarchSeries) -> TimeseriesarchSeries {
  let mn = timeseries_arch_series_min(s)
  let mx = timeseries_arch_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_arch_series_cumsum(s : TimeseriesarchSeries) -> TimeseriesarchSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_arch_series_to_string(s : TimeseriesarchSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesarchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_arch_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesarchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_arch_matrix_identity(n : Int) -> TimeseriesarchMatrix {
  let m = timeseries_arch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_arch_matrix_get(m : TimeseriesarchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_arch_matrix_transpose(m : TimeseriesarchMatrix) -> TimeseriesarchMatrix {
  let result = timeseries_arch_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_arch_matrix_add(a : TimeseriesarchMatrix, b : TimeseriesarchMatrix) -> TimeseriesarchMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_arch_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_arch_matrix_scale(m : TimeseriesarchMatrix, s : Double) -> TimeseriesarchMatrix {
  let result = timeseries_arch_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_arch_matrix_multiply(a : TimeseriesarchMatrix, b : TimeseriesarchMatrix) -> TimeseriesarchMatrix {
  if a.cols != b.rows { return timeseries_arch_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_arch_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_arch_matrix_trace(m : TimeseriesarchMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_arch_matrix_det(m : TimeseriesarchMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_arch_matrix_norm(m : TimeseriesarchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_arch_matrix_to_string(m : TimeseriesarchMatrix) -> String {
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

pub(all) struct TimeseriesarchVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_arch_make_vector(comps : Array[Double]) -> TimeseriesarchVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_arch_vector_zero(dim : Int) -> TimeseriesarchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_arch_vector_add(a : TimeseriesarchVector, b : TimeseriesarchVector) -> TimeseriesarchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_arch_vector_sub(a : TimeseriesarchVector, b : TimeseriesarchVector) -> TimeseriesarchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_arch_vector_scale(v : TimeseriesarchVector, s : Double) -> TimeseriesarchVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_arch_vector_dot(a : TimeseriesarchVector, b : TimeseriesarchVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_arch_vector_norm(v : TimeseriesarchVector) -> Double { @_common.sqrt(timeseries_arch_vector_dot(v, v)) }

pub fn timeseries_arch_vector_normalize(v : TimeseriesarchVector) -> TimeseriesarchVector {
  let n = timeseries_arch_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_arch_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_arch_vector_dist(a : TimeseriesarchVector, b : TimeseriesarchVector) -> Double {
  timeseries_arch_vector_norm(timeseries_arch_vector_sub(a, b))
}

pub fn timeseries_arch_vector_to_string(v : TimeseriesarchVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_arch_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_arch_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_arch_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_arch_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_arch_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_arch_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_arch_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_arch_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_arch_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_arch_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_arch_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_arch_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_arch_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_arch_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_arch_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_arch_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_arch_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_arch_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_arch_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_arch_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_arch_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_arch_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_arch_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_arch_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_arch_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_arch_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_arch_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_arch_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_arch_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesarchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_frame_make(size : Int) -> TimeseriesarchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_frame_len(s : TimeseriesarchFrame) -> Int { s.size }

pub fn timeseries_arch_frame_get(s : TimeseriesarchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_frame_set(s : TimeseriesarchFrame, i : Int, v : Double) -> TimeseriesarchFrame {
  let result = timeseries_arch_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_frame_sum(s : TimeseriesarchFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_arch_frame_mean(s : TimeseriesarchFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_arch_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_arch_frame_scale(s : TimeseriesarchFrame, f : Double) -> TimeseriesarchFrame {
  let result = timeseries_arch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arch_frame_add(a : TimeseriesarchFrame, b : TimeseriesarchFrame) -> TimeseriesarchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arch_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arch_frame_copy(s : TimeseriesarchFrame) -> TimeseriesarchFrame {
  let result = timeseries_arch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arch_frame_fill(s : TimeseriesarchFrame, v : Double) -> TimeseriesarchFrame {
  let result = timeseries_arch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_frame_min(s : TimeseriesarchFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_frame_max(s : TimeseriesarchFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_frame_to_string(s : TimeseriesarchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_table_make(size : Int) -> TimeseriesarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_table_len(s : TimeseriesarchTable) -> Int { s.size }

pub fn timeseries_arch_table_get(s : TimeseriesarchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_table_set(s : TimeseriesarchTable, i : Int, v : Double) -> TimeseriesarchTable {
  let result = timeseries_arch_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_table_sum(s : TimeseriesarchTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_arch_table_mean(s : TimeseriesarchTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_arch_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_arch_table_scale(s : TimeseriesarchTable, f : Double) -> TimeseriesarchTable {
  let result = timeseries_arch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arch_table_add(a : TimeseriesarchTable, b : TimeseriesarchTable) -> TimeseriesarchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arch_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arch_table_copy(s : TimeseriesarchTable) -> TimeseriesarchTable {
  let result = timeseries_arch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arch_table_fill(s : TimeseriesarchTable, v : Double) -> TimeseriesarchTable {
  let result = timeseries_arch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_table_min(s : TimeseriesarchTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_table_max(s : TimeseriesarchTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_table_to_string(s : TimeseriesarchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_graphn_make(size : Int) -> TimeseriesarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_graphn_len(s : TimeseriesarchGraphN) -> Int { s.size }

pub fn timeseries_arch_graphn_get(s : TimeseriesarchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_graphn_set(s : TimeseriesarchGraphN, i : Int, v : Double) -> TimeseriesarchGraphN {
  let result = timeseries_arch_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_graphn_sum(s : TimeseriesarchGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_arch_graphn_mean(s : TimeseriesarchGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_arch_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_arch_graphn_scale(s : TimeseriesarchGraphN, f : Double) -> TimeseriesarchGraphN {
  let result = timeseries_arch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arch_graphn_add(a : TimeseriesarchGraphN, b : TimeseriesarchGraphN) -> TimeseriesarchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arch_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arch_graphn_copy(s : TimeseriesarchGraphN) -> TimeseriesarchGraphN {
  let result = timeseries_arch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arch_graphn_fill(s : TimeseriesarchGraphN, v : Double) -> TimeseriesarchGraphN {
  let result = timeseries_arch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_graphn_min(s : TimeseriesarchGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_graphn_max(s : TimeseriesarchGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_graphn_to_string(s : TimeseriesarchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_node_make(size : Int) -> TimeseriesarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_node_len(s : TimeseriesarchNode) -> Int { s.size }

pub fn timeseries_arch_node_get(s : TimeseriesarchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_node_set(s : TimeseriesarchNode, i : Int, v : Double) -> TimeseriesarchNode {
  let result = timeseries_arch_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_node_sum(s : TimeseriesarchNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_arch_node_mean(s : TimeseriesarchNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_arch_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_arch_node_scale(s : TimeseriesarchNode, f : Double) -> TimeseriesarchNode {
  let result = timeseries_arch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arch_node_add(a : TimeseriesarchNode, b : TimeseriesarchNode) -> TimeseriesarchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arch_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arch_node_copy(s : TimeseriesarchNode) -> TimeseriesarchNode {
  let result = timeseries_arch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arch_node_fill(s : TimeseriesarchNode, v : Double) -> TimeseriesarchNode {
  let result = timeseries_arch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_node_min(s : TimeseriesarchNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_node_max(s : TimeseriesarchNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_node_to_string(s : TimeseriesarchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_edge_make(size : Int) -> TimeseriesarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_edge_len(s : TimeseriesarchEdge) -> Int { s.size }

pub fn timeseries_arch_edge_get(s : TimeseriesarchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_edge_set(s : TimeseriesarchEdge, i : Int, v : Double) -> TimeseriesarchEdge {
  let result = timeseries_arch_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_edge_sum(s : TimeseriesarchEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_arch_edge_mean(s : TimeseriesarchEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_arch_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_arch_edge_scale(s : TimeseriesarchEdge, f : Double) -> TimeseriesarchEdge {
  let result = timeseries_arch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arch_edge_add(a : TimeseriesarchEdge, b : TimeseriesarchEdge) -> TimeseriesarchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arch_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arch_edge_copy(s : TimeseriesarchEdge) -> TimeseriesarchEdge {
  let result = timeseries_arch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arch_edge_fill(s : TimeseriesarchEdge, v : Double) -> TimeseriesarchEdge {
  let result = timeseries_arch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_edge_min(s : TimeseriesarchEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_edge_max(s : TimeseriesarchEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_edge_to_string(s : TimeseriesarchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_path_make(size : Int) -> TimeseriesarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_path_len(s : TimeseriesarchPath) -> Int { s.size }

pub fn timeseries_arch_path_get(s : TimeseriesarchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_path_set(s : TimeseriesarchPath, i : Int, v : Double) -> TimeseriesarchPath {
  let result = timeseries_arch_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_path_sum(s : TimeseriesarchPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_arch_path_mean(s : TimeseriesarchPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_arch_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_arch_path_scale(s : TimeseriesarchPath, f : Double) -> TimeseriesarchPath {
  let result = timeseries_arch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arch_path_add(a : TimeseriesarchPath, b : TimeseriesarchPath) -> TimeseriesarchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arch_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arch_path_copy(s : TimeseriesarchPath) -> TimeseriesarchPath {
  let result = timeseries_arch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arch_path_fill(s : TimeseriesarchPath, v : Double) -> TimeseriesarchPath {
  let result = timeseries_arch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_path_min(s : TimeseriesarchPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_path_max(s : TimeseriesarchPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_path_to_string(s : TimeseriesarchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_cluster_make(size : Int) -> TimeseriesarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_cluster_len(s : TimeseriesarchCluster) -> Int { s.size }

pub fn timeseries_arch_cluster_get(s : TimeseriesarchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_cluster_set(s : TimeseriesarchCluster, i : Int, v : Double) -> TimeseriesarchCluster {
  let result = timeseries_arch_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_cluster_sum(s : TimeseriesarchCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_arch_cluster_mean(s : TimeseriesarchCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_arch_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_arch_cluster_scale(s : TimeseriesarchCluster, f : Double) -> TimeseriesarchCluster {
  let result = timeseries_arch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arch_cluster_add(a : TimeseriesarchCluster, b : TimeseriesarchCluster) -> TimeseriesarchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arch_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arch_cluster_copy(s : TimeseriesarchCluster) -> TimeseriesarchCluster {
  let result = timeseries_arch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arch_cluster_fill(s : TimeseriesarchCluster, v : Double) -> TimeseriesarchCluster {
  let result = timeseries_arch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_cluster_min(s : TimeseriesarchCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_cluster_max(s : TimeseriesarchCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_cluster_to_string(s : TimeseriesarchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_model_make(size : Int) -> TimeseriesarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_model_len(s : TimeseriesarchModel) -> Int { s.size }

pub fn timeseries_arch_model_get(s : TimeseriesarchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_model_set(s : TimeseriesarchModel, i : Int, v : Double) -> TimeseriesarchModel {
  let result = timeseries_arch_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_model_sum(s : TimeseriesarchModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_arch_model_mean(s : TimeseriesarchModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_arch_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_arch_model_scale(s : TimeseriesarchModel, f : Double) -> TimeseriesarchModel {
  let result = timeseries_arch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arch_model_add(a : TimeseriesarchModel, b : TimeseriesarchModel) -> TimeseriesarchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arch_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arch_model_copy(s : TimeseriesarchModel) -> TimeseriesarchModel {
  let result = timeseries_arch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arch_model_fill(s : TimeseriesarchModel, v : Double) -> TimeseriesarchModel {
  let result = timeseries_arch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_model_min(s : TimeseriesarchModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_model_max(s : TimeseriesarchModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_model_to_string(s : TimeseriesarchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_layer_make(size : Int) -> TimeseriesarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_layer_len(s : TimeseriesarchLayer) -> Int { s.size }

pub fn timeseries_arch_layer_get(s : TimeseriesarchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_layer_set(s : TimeseriesarchLayer, i : Int, v : Double) -> TimeseriesarchLayer {
  let result = timeseries_arch_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_layer_sum(s : TimeseriesarchLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_arch_layer_mean(s : TimeseriesarchLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_arch_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_arch_layer_scale(s : TimeseriesarchLayer, f : Double) -> TimeseriesarchLayer {
  let result = timeseries_arch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arch_layer_add(a : TimeseriesarchLayer, b : TimeseriesarchLayer) -> TimeseriesarchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arch_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arch_layer_copy(s : TimeseriesarchLayer) -> TimeseriesarchLayer {
  let result = timeseries_arch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arch_layer_fill(s : TimeseriesarchLayer, v : Double) -> TimeseriesarchLayer {
  let result = timeseries_arch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_layer_min(s : TimeseriesarchLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_layer_max(s : TimeseriesarchLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_layer_to_string(s : TimeseriesarchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_buffer_make(size : Int) -> TimeseriesarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_buffer_len(s : TimeseriesarchBuffer) -> Int { s.size }

pub fn timeseries_arch_buffer_get(s : TimeseriesarchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_buffer_set(s : TimeseriesarchBuffer, i : Int, v : Double) -> TimeseriesarchBuffer {
  let result = timeseries_arch_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_buffer_sum(s : TimeseriesarchBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_arch_buffer_mean(s : TimeseriesarchBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_arch_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_arch_buffer_scale(s : TimeseriesarchBuffer, f : Double) -> TimeseriesarchBuffer {
  let result = timeseries_arch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arch_buffer_add(a : TimeseriesarchBuffer, b : TimeseriesarchBuffer) -> TimeseriesarchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arch_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arch_buffer_copy(s : TimeseriesarchBuffer) -> TimeseriesarchBuffer {
  let result = timeseries_arch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arch_buffer_fill(s : TimeseriesarchBuffer, v : Double) -> TimeseriesarchBuffer {
  let result = timeseries_arch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_buffer_min(s : TimeseriesarchBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_buffer_max(s : TimeseriesarchBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_buffer_to_string(s : TimeseriesarchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_cursor_make(size : Int) -> TimeseriesarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_cursor_len(s : TimeseriesarchCursor) -> Int { s.size }

pub fn timeseries_arch_cursor_get(s : TimeseriesarchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_cursor_set(s : TimeseriesarchCursor, i : Int, v : Double) -> TimeseriesarchCursor {
  let result = timeseries_arch_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_cursor_sum(s : TimeseriesarchCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_arch_cursor_mean(s : TimeseriesarchCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_arch_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_arch_cursor_scale(s : TimeseriesarchCursor, f : Double) -> TimeseriesarchCursor {
  let result = timeseries_arch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arch_cursor_add(a : TimeseriesarchCursor, b : TimeseriesarchCursor) -> TimeseriesarchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arch_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arch_cursor_copy(s : TimeseriesarchCursor) -> TimeseriesarchCursor {
  let result = timeseries_arch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arch_cursor_fill(s : TimeseriesarchCursor, v : Double) -> TimeseriesarchCursor {
  let result = timeseries_arch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_cursor_min(s : TimeseriesarchCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_cursor_max(s : TimeseriesarchCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_cursor_to_string(s : TimeseriesarchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_view_make(size : Int) -> TimeseriesarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_view_len(s : TimeseriesarchView) -> Int { s.size }

pub fn timeseries_arch_view_get(s : TimeseriesarchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_view_set(s : TimeseriesarchView, i : Int, v : Double) -> TimeseriesarchView {
  let result = timeseries_arch_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_view_sum(s : TimeseriesarchView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_arch_view_mean(s : TimeseriesarchView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_arch_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_arch_view_scale(s : TimeseriesarchView, f : Double) -> TimeseriesarchView {
  let result = timeseries_arch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arch_view_add(a : TimeseriesarchView, b : TimeseriesarchView) -> TimeseriesarchView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arch_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arch_view_copy(s : TimeseriesarchView) -> TimeseriesarchView {
  let result = timeseries_arch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arch_view_fill(s : TimeseriesarchView, v : Double) -> TimeseriesarchView {
  let result = timeseries_arch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_view_min(s : TimeseriesarchView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_view_max(s : TimeseriesarchView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_view_to_string(s : TimeseriesarchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_range_make(size : Int) -> TimeseriesarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_range_len(s : TimeseriesarchRange) -> Int { s.size }

pub fn timeseries_arch_range_get(s : TimeseriesarchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_range_set(s : TimeseriesarchRange, i : Int, v : Double) -> TimeseriesarchRange {
  let result = timeseries_arch_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_range_sum(s : TimeseriesarchRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_arch_range_mean(s : TimeseriesarchRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_arch_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_arch_range_scale(s : TimeseriesarchRange, f : Double) -> TimeseriesarchRange {
  let result = timeseries_arch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arch_range_add(a : TimeseriesarchRange, b : TimeseriesarchRange) -> TimeseriesarchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arch_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arch_range_copy(s : TimeseriesarchRange) -> TimeseriesarchRange {
  let result = timeseries_arch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arch_range_fill(s : TimeseriesarchRange, v : Double) -> TimeseriesarchRange {
  let result = timeseries_arch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_range_min(s : TimeseriesarchRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_range_max(s : TimeseriesarchRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_range_to_string(s : TimeseriesarchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_slice_make(size : Int) -> TimeseriesarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_slice_len(s : TimeseriesarchSlice) -> Int { s.size }

pub fn timeseries_arch_slice_get(s : TimeseriesarchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_slice_set(s : TimeseriesarchSlice, i : Int, v : Double) -> TimeseriesarchSlice {
  let result = timeseries_arch_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_slice_sum(s : TimeseriesarchSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_arch_slice_mean(s : TimeseriesarchSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_arch_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_arch_slice_scale(s : TimeseriesarchSlice, f : Double) -> TimeseriesarchSlice {
  let result = timeseries_arch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arch_slice_add(a : TimeseriesarchSlice, b : TimeseriesarchSlice) -> TimeseriesarchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arch_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arch_slice_copy(s : TimeseriesarchSlice) -> TimeseriesarchSlice {
  let result = timeseries_arch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arch_slice_fill(s : TimeseriesarchSlice, v : Double) -> TimeseriesarchSlice {
  let result = timeseries_arch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arch_slice_min(s : TimeseriesarchSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_slice_max(s : TimeseriesarchSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_arch_slice_to_string(s : TimeseriesarchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

