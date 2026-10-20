///===
/// extcore/timeseries_decomp_vmd

pub(all) struct TimeseriesdecompvmdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_vmd_make_point(x : Double, y : Double) -> TimeseriesdecompvmdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_vmd_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecompvmdPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_decomp_vmd_point_x(pt : TimeseriesdecompvmdPoint) -> Double { pt.x }

pub fn timeseries_decomp_vmd_point_y(pt : TimeseriesdecompvmdPoint) -> Double { pt.y }

pub fn timeseries_decomp_vmd_point_z(pt : TimeseriesdecompvmdPoint) -> Double { pt.z }

pub fn timeseries_decomp_vmd_point_label(pt : TimeseriesdecompvmdPoint) -> Int { pt.label }

pub fn timeseries_decomp_vmd_point_dist(a : TimeseriesdecompvmdPoint, b : TimeseriesdecompvmdPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_decomp_vmd_point_add(a : TimeseriesdecompvmdPoint, b : TimeseriesdecompvmdPoint) -> TimeseriesdecompvmdPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_decomp_vmd_point_sub(a : TimeseriesdecompvmdPoint, b : TimeseriesdecompvmdPoint) -> TimeseriesdecompvmdPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_decomp_vmd_point_scale(pt : TimeseriesdecompvmdPoint, s : Double) -> TimeseriesdecompvmdPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_decomp_vmd_point_dot(a : TimeseriesdecompvmdPoint, b : TimeseriesdecompvmdPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_decomp_vmd_point_cross(a : TimeseriesdecompvmdPoint, b : TimeseriesdecompvmdPoint) -> TimeseriesdecompvmdPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_decomp_vmd_point_norm(pt : TimeseriesdecompvmdPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_decomp_vmd_point_normalize(pt : TimeseriesdecompvmdPoint) -> TimeseriesdecompvmdPoint {
  let n = timeseries_decomp_vmd_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_decomp_vmd_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_decomp_vmd_point_negate(pt : TimeseriesdecompvmdPoint) -> TimeseriesdecompvmdPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_decomp_vmd_point_mid(a : TimeseriesdecompvmdPoint, b : TimeseriesdecompvmdPoint) -> TimeseriesdecompvmdPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_decomp_vmd_point_lerp(a : TimeseriesdecompvmdPoint, b : TimeseriesdecompvmdPoint, t : Double) -> TimeseriesdecompvmdPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_decomp_vmd_point_to_string(pt : TimeseriesdecompvmdPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_vmd_make_series(vals : Array[Double], name : String) -> TimeseriesdecompvmdSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_decomp_vmd_series_len(s : TimeseriesdecompvmdSeries) -> Int { s.vals.length() }

pub fn timeseries_decomp_vmd_series_sum(s : TimeseriesdecompvmdSeries) -> Double { @_common.sum(s.vals) }

pub fn timeseries_decomp_vmd_series_mean(s : TimeseriesdecompvmdSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_decomp_vmd_series_min(s : TimeseriesdecompvmdSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_decomp_vmd_series_max(s : TimeseriesdecompvmdSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_decomp_vmd_series_range(s : TimeseriesdecompvmdSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_decomp_vmd_series_var(s : TimeseriesdecompvmdSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_decomp_vmd_series_std(s : TimeseriesdecompvmdSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_decomp_vmd_series_median(s : TimeseriesdecompvmdSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_decomp_vmd_series_scale(s : TimeseriesdecompvmdSeries, f : Double) -> TimeseriesdecompvmdSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_decomp_vmd_series_add(a : TimeseriesdecompvmdSeries, b : TimeseriesdecompvmdSeries) -> TimeseriesdecompvmdSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_decomp_vmd_series_sub(a : TimeseriesdecompvmdSeries, b : TimeseriesdecompvmdSeries) -> TimeseriesdecompvmdSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_decomp_vmd_series_normalize(s : TimeseriesdecompvmdSeries) -> TimeseriesdecompvmdSeries {
  let mn = timeseries_decomp_vmd_series_min(s)
  let mx = timeseries_decomp_vmd_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_decomp_vmd_series_cumsum(s : TimeseriesdecompvmdSeries) -> TimeseriesdecompvmdSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_decomp_vmd_series_to_string(s : TimeseriesdecompvmdSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompvmdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_vmd_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecompvmdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_vmd_matrix_identity(n : Int) -> TimeseriesdecompvmdMatrix {
  let m = timeseries_decomp_vmd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_decomp_vmd_matrix_get(m : TimeseriesdecompvmdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_decomp_vmd_matrix_transpose(m : TimeseriesdecompvmdMatrix) -> TimeseriesdecompvmdMatrix {
  let result = timeseries_decomp_vmd_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_decomp_vmd_matrix_add(a : TimeseriesdecompvmdMatrix, b : TimeseriesdecompvmdMatrix) -> TimeseriesdecompvmdMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_decomp_vmd_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_decomp_vmd_matrix_scale(m : TimeseriesdecompvmdMatrix, s : Double) -> TimeseriesdecompvmdMatrix {
  let result = timeseries_decomp_vmd_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_decomp_vmd_matrix_multiply(a : TimeseriesdecompvmdMatrix, b : TimeseriesdecompvmdMatrix) -> TimeseriesdecompvmdMatrix {
  if a.cols != b.rows { return timeseries_decomp_vmd_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_decomp_vmd_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_decomp_vmd_matrix_trace(m : TimeseriesdecompvmdMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_decomp_vmd_matrix_det(m : TimeseriesdecompvmdMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_decomp_vmd_matrix_norm(m : TimeseriesdecompvmdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_decomp_vmd_matrix_to_string(m : TimeseriesdecompvmdMatrix) -> String {
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

pub(all) struct TimeseriesdecompvmdVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_vmd_make_vector(comps : Array[Double]) -> TimeseriesdecompvmdVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_vmd_vector_zero(dim : Int) -> TimeseriesdecompvmdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_decomp_vmd_vector_add(a : TimeseriesdecompvmdVector, b : TimeseriesdecompvmdVector) -> TimeseriesdecompvmdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_decomp_vmd_vector_sub(a : TimeseriesdecompvmdVector, b : TimeseriesdecompvmdVector) -> TimeseriesdecompvmdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_decomp_vmd_vector_scale(v : TimeseriesdecompvmdVector, s : Double) -> TimeseriesdecompvmdVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_decomp_vmd_vector_dot(a : TimeseriesdecompvmdVector, b : TimeseriesdecompvmdVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_decomp_vmd_vector_norm(v : TimeseriesdecompvmdVector) -> Double { @_common.sqrt(timeseries_decomp_vmd_vector_dot(v, v)) }

pub fn timeseries_decomp_vmd_vector_normalize(v : TimeseriesdecompvmdVector) -> TimeseriesdecompvmdVector {
  let n = timeseries_decomp_vmd_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_decomp_vmd_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_decomp_vmd_vector_dist(a : TimeseriesdecompvmdVector, b : TimeseriesdecompvmdVector) -> Double {
  timeseries_decomp_vmd_vector_norm(timeseries_decomp_vmd_vector_sub(a, b))
}

pub fn timeseries_decomp_vmd_vector_to_string(v : TimeseriesdecompvmdVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_decomp_vmd_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_decomp_vmd_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_decomp_vmd_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_decomp_vmd_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_decomp_vmd_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_decomp_vmd_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_decomp_vmd_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_decomp_vmd_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_decomp_vmd_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_decomp_vmd_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_decomp_vmd_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_decomp_vmd_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_decomp_vmd_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_decomp_vmd_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_decomp_vmd_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_decomp_vmd_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_decomp_vmd_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_decomp_vmd_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_decomp_vmd_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_decomp_vmd_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_decomp_vmd_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_decomp_vmd_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_decomp_vmd_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_decomp_vmd_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_decomp_vmd_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_decomp_vmd_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_decomp_vmd_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_decomp_vmd_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_decomp_vmd_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesdecompvmdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_frame_make(size : Int) -> TimeseriesdecompvmdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_frame_len(s : TimeseriesdecompvmdFrame) -> Int { s.size }

pub fn timeseries_decomp_vmd_frame_get(s : TimeseriesdecompvmdFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_frame_set(s : TimeseriesdecompvmdFrame, i : Int, v : Double) -> TimeseriesdecompvmdFrame {
  let result = timeseries_decomp_vmd_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_frame_sum(s : TimeseriesdecompvmdFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_frame_mean(s : TimeseriesdecompvmdFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_frame_scale(s : TimeseriesdecompvmdFrame, f : Double) -> TimeseriesdecompvmdFrame {
  let result = timeseries_decomp_vmd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_vmd_frame_add(a : TimeseriesdecompvmdFrame, b : TimeseriesdecompvmdFrame) -> TimeseriesdecompvmdFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_vmd_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_vmd_frame_copy(s : TimeseriesdecompvmdFrame) -> TimeseriesdecompvmdFrame {
  let result = timeseries_decomp_vmd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_vmd_frame_fill(s : TimeseriesdecompvmdFrame, v : Double) -> TimeseriesdecompvmdFrame {
  let result = timeseries_decomp_vmd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_frame_min(s : TimeseriesdecompvmdFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_frame_max(s : TimeseriesdecompvmdFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_frame_to_string(s : TimeseriesdecompvmdFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_table_make(size : Int) -> TimeseriesdecompvmdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_table_len(s : TimeseriesdecompvmdTable) -> Int { s.size }

pub fn timeseries_decomp_vmd_table_get(s : TimeseriesdecompvmdTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_table_set(s : TimeseriesdecompvmdTable, i : Int, v : Double) -> TimeseriesdecompvmdTable {
  let result = timeseries_decomp_vmd_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_table_sum(s : TimeseriesdecompvmdTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_table_mean(s : TimeseriesdecompvmdTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_table_scale(s : TimeseriesdecompvmdTable, f : Double) -> TimeseriesdecompvmdTable {
  let result = timeseries_decomp_vmd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_vmd_table_add(a : TimeseriesdecompvmdTable, b : TimeseriesdecompvmdTable) -> TimeseriesdecompvmdTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_vmd_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_vmd_table_copy(s : TimeseriesdecompvmdTable) -> TimeseriesdecompvmdTable {
  let result = timeseries_decomp_vmd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_vmd_table_fill(s : TimeseriesdecompvmdTable, v : Double) -> TimeseriesdecompvmdTable {
  let result = timeseries_decomp_vmd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_table_min(s : TimeseriesdecompvmdTable) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_table_max(s : TimeseriesdecompvmdTable) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_table_to_string(s : TimeseriesdecompvmdTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_graphn_make(size : Int) -> TimeseriesdecompvmdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_graphn_len(s : TimeseriesdecompvmdGraphN) -> Int { s.size }

pub fn timeseries_decomp_vmd_graphn_get(s : TimeseriesdecompvmdGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_graphn_set(s : TimeseriesdecompvmdGraphN, i : Int, v : Double) -> TimeseriesdecompvmdGraphN {
  let result = timeseries_decomp_vmd_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_graphn_sum(s : TimeseriesdecompvmdGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_graphn_mean(s : TimeseriesdecompvmdGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_graphn_scale(s : TimeseriesdecompvmdGraphN, f : Double) -> TimeseriesdecompvmdGraphN {
  let result = timeseries_decomp_vmd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_vmd_graphn_add(a : TimeseriesdecompvmdGraphN, b : TimeseriesdecompvmdGraphN) -> TimeseriesdecompvmdGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_vmd_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_vmd_graphn_copy(s : TimeseriesdecompvmdGraphN) -> TimeseriesdecompvmdGraphN {
  let result = timeseries_decomp_vmd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_vmd_graphn_fill(s : TimeseriesdecompvmdGraphN, v : Double) -> TimeseriesdecompvmdGraphN {
  let result = timeseries_decomp_vmd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_graphn_min(s : TimeseriesdecompvmdGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_graphn_max(s : TimeseriesdecompvmdGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_graphn_to_string(s : TimeseriesdecompvmdGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_node_make(size : Int) -> TimeseriesdecompvmdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_node_len(s : TimeseriesdecompvmdNode) -> Int { s.size }

pub fn timeseries_decomp_vmd_node_get(s : TimeseriesdecompvmdNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_node_set(s : TimeseriesdecompvmdNode, i : Int, v : Double) -> TimeseriesdecompvmdNode {
  let result = timeseries_decomp_vmd_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_node_sum(s : TimeseriesdecompvmdNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_node_mean(s : TimeseriesdecompvmdNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_node_scale(s : TimeseriesdecompvmdNode, f : Double) -> TimeseriesdecompvmdNode {
  let result = timeseries_decomp_vmd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_vmd_node_add(a : TimeseriesdecompvmdNode, b : TimeseriesdecompvmdNode) -> TimeseriesdecompvmdNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_vmd_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_vmd_node_copy(s : TimeseriesdecompvmdNode) -> TimeseriesdecompvmdNode {
  let result = timeseries_decomp_vmd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_vmd_node_fill(s : TimeseriesdecompvmdNode, v : Double) -> TimeseriesdecompvmdNode {
  let result = timeseries_decomp_vmd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_node_min(s : TimeseriesdecompvmdNode) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_node_max(s : TimeseriesdecompvmdNode) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_node_to_string(s : TimeseriesdecompvmdNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_edge_make(size : Int) -> TimeseriesdecompvmdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_edge_len(s : TimeseriesdecompvmdEdge) -> Int { s.size }

pub fn timeseries_decomp_vmd_edge_get(s : TimeseriesdecompvmdEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_edge_set(s : TimeseriesdecompvmdEdge, i : Int, v : Double) -> TimeseriesdecompvmdEdge {
  let result = timeseries_decomp_vmd_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_edge_sum(s : TimeseriesdecompvmdEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_edge_mean(s : TimeseriesdecompvmdEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_edge_scale(s : TimeseriesdecompvmdEdge, f : Double) -> TimeseriesdecompvmdEdge {
  let result = timeseries_decomp_vmd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_vmd_edge_add(a : TimeseriesdecompvmdEdge, b : TimeseriesdecompvmdEdge) -> TimeseriesdecompvmdEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_vmd_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_vmd_edge_copy(s : TimeseriesdecompvmdEdge) -> TimeseriesdecompvmdEdge {
  let result = timeseries_decomp_vmd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_vmd_edge_fill(s : TimeseriesdecompvmdEdge, v : Double) -> TimeseriesdecompvmdEdge {
  let result = timeseries_decomp_vmd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_edge_min(s : TimeseriesdecompvmdEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_edge_max(s : TimeseriesdecompvmdEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_edge_to_string(s : TimeseriesdecompvmdEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_path_make(size : Int) -> TimeseriesdecompvmdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_path_len(s : TimeseriesdecompvmdPath) -> Int { s.size }

pub fn timeseries_decomp_vmd_path_get(s : TimeseriesdecompvmdPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_path_set(s : TimeseriesdecompvmdPath, i : Int, v : Double) -> TimeseriesdecompvmdPath {
  let result = timeseries_decomp_vmd_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_path_sum(s : TimeseriesdecompvmdPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_path_mean(s : TimeseriesdecompvmdPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_path_scale(s : TimeseriesdecompvmdPath, f : Double) -> TimeseriesdecompvmdPath {
  let result = timeseries_decomp_vmd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_vmd_path_add(a : TimeseriesdecompvmdPath, b : TimeseriesdecompvmdPath) -> TimeseriesdecompvmdPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_vmd_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_vmd_path_copy(s : TimeseriesdecompvmdPath) -> TimeseriesdecompvmdPath {
  let result = timeseries_decomp_vmd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_vmd_path_fill(s : TimeseriesdecompvmdPath, v : Double) -> TimeseriesdecompvmdPath {
  let result = timeseries_decomp_vmd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_path_min(s : TimeseriesdecompvmdPath) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_path_max(s : TimeseriesdecompvmdPath) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_path_to_string(s : TimeseriesdecompvmdPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_cluster_make(size : Int) -> TimeseriesdecompvmdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_cluster_len(s : TimeseriesdecompvmdCluster) -> Int { s.size }

pub fn timeseries_decomp_vmd_cluster_get(s : TimeseriesdecompvmdCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_cluster_set(s : TimeseriesdecompvmdCluster, i : Int, v : Double) -> TimeseriesdecompvmdCluster {
  let result = timeseries_decomp_vmd_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_cluster_sum(s : TimeseriesdecompvmdCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_cluster_mean(s : TimeseriesdecompvmdCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_cluster_scale(s : TimeseriesdecompvmdCluster, f : Double) -> TimeseriesdecompvmdCluster {
  let result = timeseries_decomp_vmd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_vmd_cluster_add(a : TimeseriesdecompvmdCluster, b : TimeseriesdecompvmdCluster) -> TimeseriesdecompvmdCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_vmd_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_vmd_cluster_copy(s : TimeseriesdecompvmdCluster) -> TimeseriesdecompvmdCluster {
  let result = timeseries_decomp_vmd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_vmd_cluster_fill(s : TimeseriesdecompvmdCluster, v : Double) -> TimeseriesdecompvmdCluster {
  let result = timeseries_decomp_vmd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_cluster_min(s : TimeseriesdecompvmdCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_cluster_max(s : TimeseriesdecompvmdCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_cluster_to_string(s : TimeseriesdecompvmdCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_model_make(size : Int) -> TimeseriesdecompvmdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_model_len(s : TimeseriesdecompvmdModel) -> Int { s.size }

pub fn timeseries_decomp_vmd_model_get(s : TimeseriesdecompvmdModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_model_set(s : TimeseriesdecompvmdModel, i : Int, v : Double) -> TimeseriesdecompvmdModel {
  let result = timeseries_decomp_vmd_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_model_sum(s : TimeseriesdecompvmdModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_model_mean(s : TimeseriesdecompvmdModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_model_scale(s : TimeseriesdecompvmdModel, f : Double) -> TimeseriesdecompvmdModel {
  let result = timeseries_decomp_vmd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_vmd_model_add(a : TimeseriesdecompvmdModel, b : TimeseriesdecompvmdModel) -> TimeseriesdecompvmdModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_vmd_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_vmd_model_copy(s : TimeseriesdecompvmdModel) -> TimeseriesdecompvmdModel {
  let result = timeseries_decomp_vmd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_vmd_model_fill(s : TimeseriesdecompvmdModel, v : Double) -> TimeseriesdecompvmdModel {
  let result = timeseries_decomp_vmd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_model_min(s : TimeseriesdecompvmdModel) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_model_max(s : TimeseriesdecompvmdModel) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_model_to_string(s : TimeseriesdecompvmdModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_layer_make(size : Int) -> TimeseriesdecompvmdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_layer_len(s : TimeseriesdecompvmdLayer) -> Int { s.size }

pub fn timeseries_decomp_vmd_layer_get(s : TimeseriesdecompvmdLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_layer_set(s : TimeseriesdecompvmdLayer, i : Int, v : Double) -> TimeseriesdecompvmdLayer {
  let result = timeseries_decomp_vmd_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_layer_sum(s : TimeseriesdecompvmdLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_layer_mean(s : TimeseriesdecompvmdLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_layer_scale(s : TimeseriesdecompvmdLayer, f : Double) -> TimeseriesdecompvmdLayer {
  let result = timeseries_decomp_vmd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_vmd_layer_add(a : TimeseriesdecompvmdLayer, b : TimeseriesdecompvmdLayer) -> TimeseriesdecompvmdLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_vmd_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_vmd_layer_copy(s : TimeseriesdecompvmdLayer) -> TimeseriesdecompvmdLayer {
  let result = timeseries_decomp_vmd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_vmd_layer_fill(s : TimeseriesdecompvmdLayer, v : Double) -> TimeseriesdecompvmdLayer {
  let result = timeseries_decomp_vmd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_layer_min(s : TimeseriesdecompvmdLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_layer_max(s : TimeseriesdecompvmdLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_layer_to_string(s : TimeseriesdecompvmdLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_buffer_make(size : Int) -> TimeseriesdecompvmdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_buffer_len(s : TimeseriesdecompvmdBuffer) -> Int { s.size }

pub fn timeseries_decomp_vmd_buffer_get(s : TimeseriesdecompvmdBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_buffer_set(s : TimeseriesdecompvmdBuffer, i : Int, v : Double) -> TimeseriesdecompvmdBuffer {
  let result = timeseries_decomp_vmd_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_buffer_sum(s : TimeseriesdecompvmdBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_buffer_mean(s : TimeseriesdecompvmdBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_buffer_scale(s : TimeseriesdecompvmdBuffer, f : Double) -> TimeseriesdecompvmdBuffer {
  let result = timeseries_decomp_vmd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_vmd_buffer_add(a : TimeseriesdecompvmdBuffer, b : TimeseriesdecompvmdBuffer) -> TimeseriesdecompvmdBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_vmd_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_vmd_buffer_copy(s : TimeseriesdecompvmdBuffer) -> TimeseriesdecompvmdBuffer {
  let result = timeseries_decomp_vmd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_vmd_buffer_fill(s : TimeseriesdecompvmdBuffer, v : Double) -> TimeseriesdecompvmdBuffer {
  let result = timeseries_decomp_vmd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_buffer_min(s : TimeseriesdecompvmdBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_buffer_max(s : TimeseriesdecompvmdBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_buffer_to_string(s : TimeseriesdecompvmdBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_cursor_make(size : Int) -> TimeseriesdecompvmdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_cursor_len(s : TimeseriesdecompvmdCursor) -> Int { s.size }

pub fn timeseries_decomp_vmd_cursor_get(s : TimeseriesdecompvmdCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_cursor_set(s : TimeseriesdecompvmdCursor, i : Int, v : Double) -> TimeseriesdecompvmdCursor {
  let result = timeseries_decomp_vmd_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_cursor_sum(s : TimeseriesdecompvmdCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_cursor_mean(s : TimeseriesdecompvmdCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_cursor_scale(s : TimeseriesdecompvmdCursor, f : Double) -> TimeseriesdecompvmdCursor {
  let result = timeseries_decomp_vmd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_vmd_cursor_add(a : TimeseriesdecompvmdCursor, b : TimeseriesdecompvmdCursor) -> TimeseriesdecompvmdCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_vmd_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_vmd_cursor_copy(s : TimeseriesdecompvmdCursor) -> TimeseriesdecompvmdCursor {
  let result = timeseries_decomp_vmd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_vmd_cursor_fill(s : TimeseriesdecompvmdCursor, v : Double) -> TimeseriesdecompvmdCursor {
  let result = timeseries_decomp_vmd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_cursor_min(s : TimeseriesdecompvmdCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_cursor_max(s : TimeseriesdecompvmdCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_cursor_to_string(s : TimeseriesdecompvmdCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_view_make(size : Int) -> TimeseriesdecompvmdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_view_len(s : TimeseriesdecompvmdView) -> Int { s.size }

pub fn timeseries_decomp_vmd_view_get(s : TimeseriesdecompvmdView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_view_set(s : TimeseriesdecompvmdView, i : Int, v : Double) -> TimeseriesdecompvmdView {
  let result = timeseries_decomp_vmd_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_view_sum(s : TimeseriesdecompvmdView) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_view_mean(s : TimeseriesdecompvmdView) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_view_scale(s : TimeseriesdecompvmdView, f : Double) -> TimeseriesdecompvmdView {
  let result = timeseries_decomp_vmd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_vmd_view_add(a : TimeseriesdecompvmdView, b : TimeseriesdecompvmdView) -> TimeseriesdecompvmdView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_vmd_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_vmd_view_copy(s : TimeseriesdecompvmdView) -> TimeseriesdecompvmdView {
  let result = timeseries_decomp_vmd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_vmd_view_fill(s : TimeseriesdecompvmdView, v : Double) -> TimeseriesdecompvmdView {
  let result = timeseries_decomp_vmd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_view_min(s : TimeseriesdecompvmdView) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_view_max(s : TimeseriesdecompvmdView) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_view_to_string(s : TimeseriesdecompvmdView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_range_make(size : Int) -> TimeseriesdecompvmdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_range_len(s : TimeseriesdecompvmdRange) -> Int { s.size }

pub fn timeseries_decomp_vmd_range_get(s : TimeseriesdecompvmdRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_range_set(s : TimeseriesdecompvmdRange, i : Int, v : Double) -> TimeseriesdecompvmdRange {
  let result = timeseries_decomp_vmd_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_range_sum(s : TimeseriesdecompvmdRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_range_mean(s : TimeseriesdecompvmdRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_range_scale(s : TimeseriesdecompvmdRange, f : Double) -> TimeseriesdecompvmdRange {
  let result = timeseries_decomp_vmd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_vmd_range_add(a : TimeseriesdecompvmdRange, b : TimeseriesdecompvmdRange) -> TimeseriesdecompvmdRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_vmd_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_vmd_range_copy(s : TimeseriesdecompvmdRange) -> TimeseriesdecompvmdRange {
  let result = timeseries_decomp_vmd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_vmd_range_fill(s : TimeseriesdecompvmdRange, v : Double) -> TimeseriesdecompvmdRange {
  let result = timeseries_decomp_vmd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_range_min(s : TimeseriesdecompvmdRange) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_range_max(s : TimeseriesdecompvmdRange) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_range_to_string(s : TimeseriesdecompvmdRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_slice_make(size : Int) -> TimeseriesdecompvmdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_slice_len(s : TimeseriesdecompvmdSlice) -> Int { s.size }

pub fn timeseries_decomp_vmd_slice_get(s : TimeseriesdecompvmdSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_slice_set(s : TimeseriesdecompvmdSlice, i : Int, v : Double) -> TimeseriesdecompvmdSlice {
  let result = timeseries_decomp_vmd_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_slice_sum(s : TimeseriesdecompvmdSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_slice_mean(s : TimeseriesdecompvmdSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_slice_scale(s : TimeseriesdecompvmdSlice, f : Double) -> TimeseriesdecompvmdSlice {
  let result = timeseries_decomp_vmd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_vmd_slice_add(a : TimeseriesdecompvmdSlice, b : TimeseriesdecompvmdSlice) -> TimeseriesdecompvmdSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_vmd_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_vmd_slice_copy(s : TimeseriesdecompvmdSlice) -> TimeseriesdecompvmdSlice {
  let result = timeseries_decomp_vmd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_vmd_slice_fill(s : TimeseriesdecompvmdSlice, v : Double) -> TimeseriesdecompvmdSlice {
  let result = timeseries_decomp_vmd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_vmd_slice_min(s : TimeseriesdecompvmdSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_slice_max(s : TimeseriesdecompvmdSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_slice_to_string(s : TimeseriesdecompvmdSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

