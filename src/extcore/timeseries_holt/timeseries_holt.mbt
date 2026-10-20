///===
/// extcore/timeseries_holt

pub(all) struct TimeseriesholtPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_holt_make_point(x : Double, y : Double) -> TimeseriesholtPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_holt_make_point3(x : Double, y : Double, z : Double) -> TimeseriesholtPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_holt_point_x(pt : TimeseriesholtPoint) -> Double { pt.x }

pub fn timeseries_holt_point_y(pt : TimeseriesholtPoint) -> Double { pt.y }

pub fn timeseries_holt_point_z(pt : TimeseriesholtPoint) -> Double { pt.z }

pub fn timeseries_holt_point_label(pt : TimeseriesholtPoint) -> Int { pt.label }

pub fn timeseries_holt_point_dist(a : TimeseriesholtPoint, b : TimeseriesholtPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_holt_point_add(a : TimeseriesholtPoint, b : TimeseriesholtPoint) -> TimeseriesholtPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_holt_point_sub(a : TimeseriesholtPoint, b : TimeseriesholtPoint) -> TimeseriesholtPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_holt_point_scale(pt : TimeseriesholtPoint, s : Double) -> TimeseriesholtPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_holt_point_dot(a : TimeseriesholtPoint, b : TimeseriesholtPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_holt_point_cross(a : TimeseriesholtPoint, b : TimeseriesholtPoint) -> TimeseriesholtPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_holt_point_norm(pt : TimeseriesholtPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_holt_point_normalize(pt : TimeseriesholtPoint) -> TimeseriesholtPoint {
  let n = timeseries_holt_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_holt_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_holt_point_negate(pt : TimeseriesholtPoint) -> TimeseriesholtPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_holt_point_mid(a : TimeseriesholtPoint, b : TimeseriesholtPoint) -> TimeseriesholtPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_holt_point_lerp(a : TimeseriesholtPoint, b : TimeseriesholtPoint, t : Double) -> TimeseriesholtPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_holt_point_to_string(pt : TimeseriesholtPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesholtSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_holt_make_series(vals : Array[Double], name : String) -> TimeseriesholtSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_holt_series_len(s : TimeseriesholtSeries) -> Int { s.vals.length() }

pub fn timeseries_holt_series_sum(s : TimeseriesholtSeries) -> Double { @_common.sum(s.vals) }

pub fn timeseries_holt_series_mean(s : TimeseriesholtSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_holt_series_min(s : TimeseriesholtSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_holt_series_max(s : TimeseriesholtSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_holt_series_range(s : TimeseriesholtSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_holt_series_var(s : TimeseriesholtSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_holt_series_std(s : TimeseriesholtSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_holt_series_median(s : TimeseriesholtSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_holt_series_scale(s : TimeseriesholtSeries, f : Double) -> TimeseriesholtSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_holt_series_add(a : TimeseriesholtSeries, b : TimeseriesholtSeries) -> TimeseriesholtSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_holt_series_sub(a : TimeseriesholtSeries, b : TimeseriesholtSeries) -> TimeseriesholtSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_holt_series_normalize(s : TimeseriesholtSeries) -> TimeseriesholtSeries {
  let mn = timeseries_holt_series_min(s)
  let mx = timeseries_holt_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_holt_series_cumsum(s : TimeseriesholtSeries) -> TimeseriesholtSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_holt_series_to_string(s : TimeseriesholtSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesholtMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_holt_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesholtMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_holt_matrix_identity(n : Int) -> TimeseriesholtMatrix {
  let m = timeseries_holt_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_holt_matrix_get(m : TimeseriesholtMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_holt_matrix_transpose(m : TimeseriesholtMatrix) -> TimeseriesholtMatrix {
  let result = timeseries_holt_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_holt_matrix_add(a : TimeseriesholtMatrix, b : TimeseriesholtMatrix) -> TimeseriesholtMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_holt_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_holt_matrix_scale(m : TimeseriesholtMatrix, s : Double) -> TimeseriesholtMatrix {
  let result = timeseries_holt_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_holt_matrix_multiply(a : TimeseriesholtMatrix, b : TimeseriesholtMatrix) -> TimeseriesholtMatrix {
  if a.cols != b.rows { return timeseries_holt_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_holt_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_holt_matrix_trace(m : TimeseriesholtMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_holt_matrix_det(m : TimeseriesholtMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_holt_matrix_norm(m : TimeseriesholtMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_holt_matrix_to_string(m : TimeseriesholtMatrix) -> String {
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

pub(all) struct TimeseriesholtVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_holt_make_vector(comps : Array[Double]) -> TimeseriesholtVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_holt_vector_zero(dim : Int) -> TimeseriesholtVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_holt_vector_add(a : TimeseriesholtVector, b : TimeseriesholtVector) -> TimeseriesholtVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_holt_vector_sub(a : TimeseriesholtVector, b : TimeseriesholtVector) -> TimeseriesholtVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_holt_vector_scale(v : TimeseriesholtVector, s : Double) -> TimeseriesholtVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_holt_vector_dot(a : TimeseriesholtVector, b : TimeseriesholtVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_holt_vector_norm(v : TimeseriesholtVector) -> Double { @_common.sqrt(timeseries_holt_vector_dot(v, v)) }

pub fn timeseries_holt_vector_normalize(v : TimeseriesholtVector) -> TimeseriesholtVector {
  let n = timeseries_holt_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_holt_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_holt_vector_dist(a : TimeseriesholtVector, b : TimeseriesholtVector) -> Double {
  timeseries_holt_vector_norm(timeseries_holt_vector_sub(a, b))
}

pub fn timeseries_holt_vector_to_string(v : TimeseriesholtVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_holt_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_holt_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_holt_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_holt_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_holt_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_holt_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_holt_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_holt_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_holt_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_holt_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_holt_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_holt_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_holt_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_holt_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_holt_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_holt_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_holt_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_holt_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_holt_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_holt_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_holt_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_holt_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_holt_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_holt_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_holt_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_holt_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_holt_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_holt_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_holt_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesholtFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_frame_make(size : Int) -> TimeseriesholtFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_frame_len(s : TimeseriesholtFrame) -> Int { s.size }

pub fn timeseries_holt_frame_get(s : TimeseriesholtFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_frame_set(s : TimeseriesholtFrame, i : Int, v : Double) -> TimeseriesholtFrame {
  let result = timeseries_holt_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_holt_frame_sum(s : TimeseriesholtFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_frame_mean(s : TimeseriesholtFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_frame_scale(s : TimeseriesholtFrame, f : Double) -> TimeseriesholtFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_frame_add(a : TimeseriesholtFrame, b : TimeseriesholtFrame) -> TimeseriesholtFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_frame_copy(s : TimeseriesholtFrame) -> TimeseriesholtFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_frame_fill(s : TimeseriesholtFrame, v : Double) -> TimeseriesholtFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_frame_min(s : TimeseriesholtFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_frame_max(s : TimeseriesholtFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_frame_to_string(s : TimeseriesholtFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_table_make(size : Int) -> TimeseriesholtTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_table_len(s : TimeseriesholtTable) -> Int { s.size }

pub fn timeseries_holt_table_get(s : TimeseriesholtTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_table_set(s : TimeseriesholtTable, i : Int, v : Double) -> TimeseriesholtTable {
  let result = timeseries_holt_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_holt_table_sum(s : TimeseriesholtTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_table_mean(s : TimeseriesholtTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_table_scale(s : TimeseriesholtTable, f : Double) -> TimeseriesholtTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_table_add(a : TimeseriesholtTable, b : TimeseriesholtTable) -> TimeseriesholtTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_table_copy(s : TimeseriesholtTable) -> TimeseriesholtTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_table_fill(s : TimeseriesholtTable, v : Double) -> TimeseriesholtTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_table_min(s : TimeseriesholtTable) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_table_max(s : TimeseriesholtTable) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_table_to_string(s : TimeseriesholtTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_graphn_make(size : Int) -> TimeseriesholtGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_graphn_len(s : TimeseriesholtGraphN) -> Int { s.size }

pub fn timeseries_holt_graphn_get(s : TimeseriesholtGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_graphn_set(s : TimeseriesholtGraphN, i : Int, v : Double) -> TimeseriesholtGraphN {
  let result = timeseries_holt_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_holt_graphn_sum(s : TimeseriesholtGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_graphn_mean(s : TimeseriesholtGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_graphn_scale(s : TimeseriesholtGraphN, f : Double) -> TimeseriesholtGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_graphn_add(a : TimeseriesholtGraphN, b : TimeseriesholtGraphN) -> TimeseriesholtGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_graphn_copy(s : TimeseriesholtGraphN) -> TimeseriesholtGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_graphn_fill(s : TimeseriesholtGraphN, v : Double) -> TimeseriesholtGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_graphn_min(s : TimeseriesholtGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_graphn_max(s : TimeseriesholtGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_graphn_to_string(s : TimeseriesholtGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_node_make(size : Int) -> TimeseriesholtNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_node_len(s : TimeseriesholtNode) -> Int { s.size }

pub fn timeseries_holt_node_get(s : TimeseriesholtNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_node_set(s : TimeseriesholtNode, i : Int, v : Double) -> TimeseriesholtNode {
  let result = timeseries_holt_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_holt_node_sum(s : TimeseriesholtNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_node_mean(s : TimeseriesholtNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_node_scale(s : TimeseriesholtNode, f : Double) -> TimeseriesholtNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_node_add(a : TimeseriesholtNode, b : TimeseriesholtNode) -> TimeseriesholtNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_node_copy(s : TimeseriesholtNode) -> TimeseriesholtNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_node_fill(s : TimeseriesholtNode, v : Double) -> TimeseriesholtNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_node_min(s : TimeseriesholtNode) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_node_max(s : TimeseriesholtNode) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_node_to_string(s : TimeseriesholtNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_edge_make(size : Int) -> TimeseriesholtEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_edge_len(s : TimeseriesholtEdge) -> Int { s.size }

pub fn timeseries_holt_edge_get(s : TimeseriesholtEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_edge_set(s : TimeseriesholtEdge, i : Int, v : Double) -> TimeseriesholtEdge {
  let result = timeseries_holt_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_holt_edge_sum(s : TimeseriesholtEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_edge_mean(s : TimeseriesholtEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_edge_scale(s : TimeseriesholtEdge, f : Double) -> TimeseriesholtEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_edge_add(a : TimeseriesholtEdge, b : TimeseriesholtEdge) -> TimeseriesholtEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_edge_copy(s : TimeseriesholtEdge) -> TimeseriesholtEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_edge_fill(s : TimeseriesholtEdge, v : Double) -> TimeseriesholtEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_edge_min(s : TimeseriesholtEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_edge_max(s : TimeseriesholtEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_edge_to_string(s : TimeseriesholtEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_path_make(size : Int) -> TimeseriesholtPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_path_len(s : TimeseriesholtPath) -> Int { s.size }

pub fn timeseries_holt_path_get(s : TimeseriesholtPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_path_set(s : TimeseriesholtPath, i : Int, v : Double) -> TimeseriesholtPath {
  let result = timeseries_holt_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_holt_path_sum(s : TimeseriesholtPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_path_mean(s : TimeseriesholtPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_path_scale(s : TimeseriesholtPath, f : Double) -> TimeseriesholtPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_path_add(a : TimeseriesholtPath, b : TimeseriesholtPath) -> TimeseriesholtPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_path_copy(s : TimeseriesholtPath) -> TimeseriesholtPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_path_fill(s : TimeseriesholtPath, v : Double) -> TimeseriesholtPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_path_min(s : TimeseriesholtPath) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_path_max(s : TimeseriesholtPath) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_path_to_string(s : TimeseriesholtPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_cluster_make(size : Int) -> TimeseriesholtCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_cluster_len(s : TimeseriesholtCluster) -> Int { s.size }

pub fn timeseries_holt_cluster_get(s : TimeseriesholtCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_cluster_set(s : TimeseriesholtCluster, i : Int, v : Double) -> TimeseriesholtCluster {
  let result = timeseries_holt_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_holt_cluster_sum(s : TimeseriesholtCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_cluster_mean(s : TimeseriesholtCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_cluster_scale(s : TimeseriesholtCluster, f : Double) -> TimeseriesholtCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_cluster_add(a : TimeseriesholtCluster, b : TimeseriesholtCluster) -> TimeseriesholtCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_cluster_copy(s : TimeseriesholtCluster) -> TimeseriesholtCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_cluster_fill(s : TimeseriesholtCluster, v : Double) -> TimeseriesholtCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_cluster_min(s : TimeseriesholtCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_cluster_max(s : TimeseriesholtCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_cluster_to_string(s : TimeseriesholtCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_model_make(size : Int) -> TimeseriesholtModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_model_len(s : TimeseriesholtModel) -> Int { s.size }

pub fn timeseries_holt_model_get(s : TimeseriesholtModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_model_set(s : TimeseriesholtModel, i : Int, v : Double) -> TimeseriesholtModel {
  let result = timeseries_holt_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_holt_model_sum(s : TimeseriesholtModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_model_mean(s : TimeseriesholtModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_model_scale(s : TimeseriesholtModel, f : Double) -> TimeseriesholtModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_model_add(a : TimeseriesholtModel, b : TimeseriesholtModel) -> TimeseriesholtModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_model_copy(s : TimeseriesholtModel) -> TimeseriesholtModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_model_fill(s : TimeseriesholtModel, v : Double) -> TimeseriesholtModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_model_min(s : TimeseriesholtModel) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_model_max(s : TimeseriesholtModel) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_model_to_string(s : TimeseriesholtModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_layer_make(size : Int) -> TimeseriesholtLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_layer_len(s : TimeseriesholtLayer) -> Int { s.size }

pub fn timeseries_holt_layer_get(s : TimeseriesholtLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_layer_set(s : TimeseriesholtLayer, i : Int, v : Double) -> TimeseriesholtLayer {
  let result = timeseries_holt_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_holt_layer_sum(s : TimeseriesholtLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_layer_mean(s : TimeseriesholtLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_layer_scale(s : TimeseriesholtLayer, f : Double) -> TimeseriesholtLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_layer_add(a : TimeseriesholtLayer, b : TimeseriesholtLayer) -> TimeseriesholtLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_layer_copy(s : TimeseriesholtLayer) -> TimeseriesholtLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_layer_fill(s : TimeseriesholtLayer, v : Double) -> TimeseriesholtLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_layer_min(s : TimeseriesholtLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_layer_max(s : TimeseriesholtLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_layer_to_string(s : TimeseriesholtLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_buffer_make(size : Int) -> TimeseriesholtBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_buffer_len(s : TimeseriesholtBuffer) -> Int { s.size }

pub fn timeseries_holt_buffer_get(s : TimeseriesholtBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_buffer_set(s : TimeseriesholtBuffer, i : Int, v : Double) -> TimeseriesholtBuffer {
  let result = timeseries_holt_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_holt_buffer_sum(s : TimeseriesholtBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_buffer_mean(s : TimeseriesholtBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_buffer_scale(s : TimeseriesholtBuffer, f : Double) -> TimeseriesholtBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_buffer_add(a : TimeseriesholtBuffer, b : TimeseriesholtBuffer) -> TimeseriesholtBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_buffer_copy(s : TimeseriesholtBuffer) -> TimeseriesholtBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_buffer_fill(s : TimeseriesholtBuffer, v : Double) -> TimeseriesholtBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_buffer_min(s : TimeseriesholtBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_buffer_max(s : TimeseriesholtBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_buffer_to_string(s : TimeseriesholtBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_cursor_make(size : Int) -> TimeseriesholtCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_cursor_len(s : TimeseriesholtCursor) -> Int { s.size }

pub fn timeseries_holt_cursor_get(s : TimeseriesholtCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_cursor_set(s : TimeseriesholtCursor, i : Int, v : Double) -> TimeseriesholtCursor {
  let result = timeseries_holt_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_holt_cursor_sum(s : TimeseriesholtCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_cursor_mean(s : TimeseriesholtCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_cursor_scale(s : TimeseriesholtCursor, f : Double) -> TimeseriesholtCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_cursor_add(a : TimeseriesholtCursor, b : TimeseriesholtCursor) -> TimeseriesholtCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_cursor_copy(s : TimeseriesholtCursor) -> TimeseriesholtCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_cursor_fill(s : TimeseriesholtCursor, v : Double) -> TimeseriesholtCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_cursor_min(s : TimeseriesholtCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_cursor_max(s : TimeseriesholtCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_cursor_to_string(s : TimeseriesholtCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_view_make(size : Int) -> TimeseriesholtView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_view_len(s : TimeseriesholtView) -> Int { s.size }

pub fn timeseries_holt_view_get(s : TimeseriesholtView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_view_set(s : TimeseriesholtView, i : Int, v : Double) -> TimeseriesholtView {
  let result = timeseries_holt_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_holt_view_sum(s : TimeseriesholtView) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_view_mean(s : TimeseriesholtView) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_view_scale(s : TimeseriesholtView, f : Double) -> TimeseriesholtView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_view_add(a : TimeseriesholtView, b : TimeseriesholtView) -> TimeseriesholtView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_view_copy(s : TimeseriesholtView) -> TimeseriesholtView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_view_fill(s : TimeseriesholtView, v : Double) -> TimeseriesholtView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_view_min(s : TimeseriesholtView) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_view_max(s : TimeseriesholtView) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_view_to_string(s : TimeseriesholtView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_range_make(size : Int) -> TimeseriesholtRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_range_len(s : TimeseriesholtRange) -> Int { s.size }

pub fn timeseries_holt_range_get(s : TimeseriesholtRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_range_set(s : TimeseriesholtRange, i : Int, v : Double) -> TimeseriesholtRange {
  let result = timeseries_holt_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_holt_range_sum(s : TimeseriesholtRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_range_mean(s : TimeseriesholtRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_range_scale(s : TimeseriesholtRange, f : Double) -> TimeseriesholtRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_range_add(a : TimeseriesholtRange, b : TimeseriesholtRange) -> TimeseriesholtRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_range_copy(s : TimeseriesholtRange) -> TimeseriesholtRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_range_fill(s : TimeseriesholtRange, v : Double) -> TimeseriesholtRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_range_min(s : TimeseriesholtRange) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_range_max(s : TimeseriesholtRange) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_range_to_string(s : TimeseriesholtRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_slice_make(size : Int) -> TimeseriesholtSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_slice_len(s : TimeseriesholtSlice) -> Int { s.size }

pub fn timeseries_holt_slice_get(s : TimeseriesholtSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_slice_set(s : TimeseriesholtSlice, i : Int, v : Double) -> TimeseriesholtSlice {
  let result = timeseries_holt_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_holt_slice_sum(s : TimeseriesholtSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_slice_mean(s : TimeseriesholtSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_slice_scale(s : TimeseriesholtSlice, f : Double) -> TimeseriesholtSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_slice_add(a : TimeseriesholtSlice, b : TimeseriesholtSlice) -> TimeseriesholtSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_slice_copy(s : TimeseriesholtSlice) -> TimeseriesholtSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_slice_fill(s : TimeseriesholtSlice, v : Double) -> TimeseriesholtSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_slice_min(s : TimeseriesholtSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_slice_max(s : TimeseriesholtSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_slice_to_string(s : TimeseriesholtSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

