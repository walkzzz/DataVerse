///===
/// extcore/timeseries_decomp_emd

pub(all) struct TimeseriesdecompemdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_emd_make_point(x : Double, y : Double) -> TimeseriesdecompemdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_emd_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecompemdPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_decomp_emd_point_x(pt : TimeseriesdecompemdPoint) -> Double { pt.x }

pub fn timeseries_decomp_emd_point_y(pt : TimeseriesdecompemdPoint) -> Double { pt.y }

pub fn timeseries_decomp_emd_point_z(pt : TimeseriesdecompemdPoint) -> Double { pt.z }

pub fn timeseries_decomp_emd_point_label(pt : TimeseriesdecompemdPoint) -> Int { pt.label }

pub fn timeseries_decomp_emd_point_dist(a : TimeseriesdecompemdPoint, b : TimeseriesdecompemdPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_decomp_emd_point_add(a : TimeseriesdecompemdPoint, b : TimeseriesdecompemdPoint) -> TimeseriesdecompemdPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_decomp_emd_point_sub(a : TimeseriesdecompemdPoint, b : TimeseriesdecompemdPoint) -> TimeseriesdecompemdPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_decomp_emd_point_scale(pt : TimeseriesdecompemdPoint, s : Double) -> TimeseriesdecompemdPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_decomp_emd_point_dot(a : TimeseriesdecompemdPoint, b : TimeseriesdecompemdPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_decomp_emd_point_cross(a : TimeseriesdecompemdPoint, b : TimeseriesdecompemdPoint) -> TimeseriesdecompemdPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_decomp_emd_point_norm(pt : TimeseriesdecompemdPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_decomp_emd_point_normalize(pt : TimeseriesdecompemdPoint) -> TimeseriesdecompemdPoint {
  let n = timeseries_decomp_emd_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_decomp_emd_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_decomp_emd_point_negate(pt : TimeseriesdecompemdPoint) -> TimeseriesdecompemdPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_decomp_emd_point_mid(a : TimeseriesdecompemdPoint, b : TimeseriesdecompemdPoint) -> TimeseriesdecompemdPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_decomp_emd_point_lerp(a : TimeseriesdecompemdPoint, b : TimeseriesdecompemdPoint, t : Double) -> TimeseriesdecompemdPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_decomp_emd_point_to_string(pt : TimeseriesdecompemdPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_emd_make_series(vals : Array[Double], name : String) -> TimeseriesdecompemdSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_decomp_emd_series_len(s : TimeseriesdecompemdSeries) -> Int { s.vals.length() }

pub fn timeseries_decomp_emd_series_sum(s : TimeseriesdecompemdSeries) -> Double { @_common.sum(s.vals) }

pub fn timeseries_decomp_emd_series_mean(s : TimeseriesdecompemdSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_decomp_emd_series_min(s : TimeseriesdecompemdSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_decomp_emd_series_max(s : TimeseriesdecompemdSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_decomp_emd_series_range(s : TimeseriesdecompemdSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_decomp_emd_series_var(s : TimeseriesdecompemdSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_decomp_emd_series_std(s : TimeseriesdecompemdSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_decomp_emd_series_median(s : TimeseriesdecompemdSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_decomp_emd_series_scale(s : TimeseriesdecompemdSeries, f : Double) -> TimeseriesdecompemdSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn timeseries_decomp_emd_series_add(a : TimeseriesdecompemdSeries, b : TimeseriesdecompemdSeries) -> TimeseriesdecompemdSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_decomp_emd_series_sub(a : TimeseriesdecompemdSeries, b : TimeseriesdecompemdSeries) -> TimeseriesdecompemdSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_decomp_emd_series_normalize(s : TimeseriesdecompemdSeries) -> TimeseriesdecompemdSeries {
  let mn = timeseries_decomp_emd_series_min(s)
  let mx = timeseries_decomp_emd_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_decomp_emd_series_cumsum(s : TimeseriesdecompemdSeries) -> TimeseriesdecompemdSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_decomp_emd_series_to_string(s : TimeseriesdecompemdSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompemdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_emd_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecompemdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_emd_matrix_identity(n : Int) -> TimeseriesdecompemdMatrix {
  let m = timeseries_decomp_emd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_decomp_emd_matrix_get(m : TimeseriesdecompemdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_decomp_emd_matrix_transpose(m : TimeseriesdecompemdMatrix) -> TimeseriesdecompemdMatrix {
  let result = timeseries_decomp_emd_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_decomp_emd_matrix_add(a : TimeseriesdecompemdMatrix, b : TimeseriesdecompemdMatrix) -> TimeseriesdecompemdMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_decomp_emd_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_decomp_emd_matrix_scale(m : TimeseriesdecompemdMatrix, s : Double) -> TimeseriesdecompemdMatrix {
  let result = timeseries_decomp_emd_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_decomp_emd_matrix_multiply(a : TimeseriesdecompemdMatrix, b : TimeseriesdecompemdMatrix) -> TimeseriesdecompemdMatrix {
  if a.cols != b.rows { return timeseries_decomp_emd_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_decomp_emd_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_decomp_emd_matrix_trace(m : TimeseriesdecompemdMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_decomp_emd_matrix_det(m : TimeseriesdecompemdMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_decomp_emd_matrix_norm(m : TimeseriesdecompemdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_decomp_emd_matrix_to_string(m : TimeseriesdecompemdMatrix) -> String {
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

pub(all) struct TimeseriesdecompemdVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_emd_make_vector(comps : Array[Double]) -> TimeseriesdecompemdVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_emd_vector_zero(dim : Int) -> TimeseriesdecompemdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_decomp_emd_vector_add(a : TimeseriesdecompemdVector, b : TimeseriesdecompemdVector) -> TimeseriesdecompemdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn timeseries_decomp_emd_vector_sub(a : TimeseriesdecompemdVector, b : TimeseriesdecompemdVector) -> TimeseriesdecompemdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn timeseries_decomp_emd_vector_scale(v : TimeseriesdecompemdVector, s : Double) -> TimeseriesdecompemdVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn timeseries_decomp_emd_vector_dot(a : TimeseriesdecompemdVector, b : TimeseriesdecompemdVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_decomp_emd_vector_norm(v : TimeseriesdecompemdVector) -> Double { @_common.sqrt(timeseries_decomp_emd_vector_dot(v, v)) }

pub fn timeseries_decomp_emd_vector_normalize(v : TimeseriesdecompemdVector) -> TimeseriesdecompemdVector {
  let n = timeseries_decomp_emd_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_decomp_emd_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_decomp_emd_vector_dist(a : TimeseriesdecompemdVector, b : TimeseriesdecompemdVector) -> Double {
  timeseries_decomp_emd_vector_norm(timeseries_decomp_emd_vector_sub(a, b))
}

pub fn timeseries_decomp_emd_vector_to_string(v : TimeseriesdecompemdVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_decomp_emd_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_decomp_emd_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_decomp_emd_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_decomp_emd_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_decomp_emd_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_decomp_emd_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_decomp_emd_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_decomp_emd_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_decomp_emd_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_decomp_emd_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_decomp_emd_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_decomp_emd_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_decomp_emd_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_decomp_emd_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_decomp_emd_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_decomp_emd_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_decomp_emd_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_decomp_emd_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_decomp_emd_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_decomp_emd_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_decomp_emd_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_decomp_emd_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_decomp_emd_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_decomp_emd_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_decomp_emd_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_decomp_emd_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_decomp_emd_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_decomp_emd_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_decomp_emd_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesdecompemdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_frame_make(size : Int) -> TimeseriesdecompemdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_frame_len(s : TimeseriesdecompemdFrame) -> Int { s.size }

pub fn timeseries_decomp_emd_frame_get(s : TimeseriesdecompemdFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_frame_set(s : TimeseriesdecompemdFrame, i : Int, v : Double) -> TimeseriesdecompemdFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_frame_sum(s : TimeseriesdecompemdFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_emd_frame_mean(s : TimeseriesdecompemdFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_emd_frame_scale(s : TimeseriesdecompemdFrame, f : Double) -> TimeseriesdecompemdFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_frame_add(a : TimeseriesdecompemdFrame, b : TimeseriesdecompemdFrame) -> TimeseriesdecompemdFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_emd_frame_copy(s : TimeseriesdecompemdFrame) -> TimeseriesdecompemdFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_frame_fill(s : TimeseriesdecompemdFrame, v : Double) -> TimeseriesdecompemdFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_frame_min(s : TimeseriesdecompemdFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_emd_frame_max(s : TimeseriesdecompemdFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_emd_frame_to_string(s : TimeseriesdecompemdFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_table_make(size : Int) -> TimeseriesdecompemdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_table_len(s : TimeseriesdecompemdTable) -> Int { s.size }

pub fn timeseries_decomp_emd_table_get(s : TimeseriesdecompemdTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_table_set(s : TimeseriesdecompemdTable, i : Int, v : Double) -> TimeseriesdecompemdTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_table_sum(s : TimeseriesdecompemdTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_emd_table_mean(s : TimeseriesdecompemdTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_emd_table_scale(s : TimeseriesdecompemdTable, f : Double) -> TimeseriesdecompemdTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_table_add(a : TimeseriesdecompemdTable, b : TimeseriesdecompemdTable) -> TimeseriesdecompemdTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_emd_table_copy(s : TimeseriesdecompemdTable) -> TimeseriesdecompemdTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_table_fill(s : TimeseriesdecompemdTable, v : Double) -> TimeseriesdecompemdTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_table_min(s : TimeseriesdecompemdTable) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_emd_table_max(s : TimeseriesdecompemdTable) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_emd_table_to_string(s : TimeseriesdecompemdTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_graphn_make(size : Int) -> TimeseriesdecompemdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_graphn_len(s : TimeseriesdecompemdGraphN) -> Int { s.size }

pub fn timeseries_decomp_emd_graphn_get(s : TimeseriesdecompemdGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_graphn_set(s : TimeseriesdecompemdGraphN, i : Int, v : Double) -> TimeseriesdecompemdGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_graphn_sum(s : TimeseriesdecompemdGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_emd_graphn_mean(s : TimeseriesdecompemdGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_emd_graphn_scale(s : TimeseriesdecompemdGraphN, f : Double) -> TimeseriesdecompemdGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_graphn_add(a : TimeseriesdecompemdGraphN, b : TimeseriesdecompemdGraphN) -> TimeseriesdecompemdGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_emd_graphn_copy(s : TimeseriesdecompemdGraphN) -> TimeseriesdecompemdGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_graphn_fill(s : TimeseriesdecompemdGraphN, v : Double) -> TimeseriesdecompemdGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_graphn_min(s : TimeseriesdecompemdGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_emd_graphn_max(s : TimeseriesdecompemdGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_emd_graphn_to_string(s : TimeseriesdecompemdGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_node_make(size : Int) -> TimeseriesdecompemdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_node_len(s : TimeseriesdecompemdNode) -> Int { s.size }

pub fn timeseries_decomp_emd_node_get(s : TimeseriesdecompemdNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_node_set(s : TimeseriesdecompemdNode, i : Int, v : Double) -> TimeseriesdecompemdNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_node_sum(s : TimeseriesdecompemdNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_emd_node_mean(s : TimeseriesdecompemdNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_emd_node_scale(s : TimeseriesdecompemdNode, f : Double) -> TimeseriesdecompemdNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_node_add(a : TimeseriesdecompemdNode, b : TimeseriesdecompemdNode) -> TimeseriesdecompemdNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_emd_node_copy(s : TimeseriesdecompemdNode) -> TimeseriesdecompemdNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_node_fill(s : TimeseriesdecompemdNode, v : Double) -> TimeseriesdecompemdNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_node_min(s : TimeseriesdecompemdNode) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_emd_node_max(s : TimeseriesdecompemdNode) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_emd_node_to_string(s : TimeseriesdecompemdNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_edge_make(size : Int) -> TimeseriesdecompemdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_edge_len(s : TimeseriesdecompemdEdge) -> Int { s.size }

pub fn timeseries_decomp_emd_edge_get(s : TimeseriesdecompemdEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_edge_set(s : TimeseriesdecompemdEdge, i : Int, v : Double) -> TimeseriesdecompemdEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_edge_sum(s : TimeseriesdecompemdEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_emd_edge_mean(s : TimeseriesdecompemdEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_emd_edge_scale(s : TimeseriesdecompemdEdge, f : Double) -> TimeseriesdecompemdEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_edge_add(a : TimeseriesdecompemdEdge, b : TimeseriesdecompemdEdge) -> TimeseriesdecompemdEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_emd_edge_copy(s : TimeseriesdecompemdEdge) -> TimeseriesdecompemdEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_edge_fill(s : TimeseriesdecompemdEdge, v : Double) -> TimeseriesdecompemdEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_edge_min(s : TimeseriesdecompemdEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_emd_edge_max(s : TimeseriesdecompemdEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_emd_edge_to_string(s : TimeseriesdecompemdEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_path_make(size : Int) -> TimeseriesdecompemdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_path_len(s : TimeseriesdecompemdPath) -> Int { s.size }

pub fn timeseries_decomp_emd_path_get(s : TimeseriesdecompemdPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_path_set(s : TimeseriesdecompemdPath, i : Int, v : Double) -> TimeseriesdecompemdPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_path_sum(s : TimeseriesdecompemdPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_emd_path_mean(s : TimeseriesdecompemdPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_emd_path_scale(s : TimeseriesdecompemdPath, f : Double) -> TimeseriesdecompemdPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_path_add(a : TimeseriesdecompemdPath, b : TimeseriesdecompemdPath) -> TimeseriesdecompemdPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_emd_path_copy(s : TimeseriesdecompemdPath) -> TimeseriesdecompemdPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_path_fill(s : TimeseriesdecompemdPath, v : Double) -> TimeseriesdecompemdPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_path_min(s : TimeseriesdecompemdPath) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_emd_path_max(s : TimeseriesdecompemdPath) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_emd_path_to_string(s : TimeseriesdecompemdPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_cluster_make(size : Int) -> TimeseriesdecompemdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_cluster_len(s : TimeseriesdecompemdCluster) -> Int { s.size }

pub fn timeseries_decomp_emd_cluster_get(s : TimeseriesdecompemdCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_cluster_set(s : TimeseriesdecompemdCluster, i : Int, v : Double) -> TimeseriesdecompemdCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_cluster_sum(s : TimeseriesdecompemdCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_emd_cluster_mean(s : TimeseriesdecompemdCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_emd_cluster_scale(s : TimeseriesdecompemdCluster, f : Double) -> TimeseriesdecompemdCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_cluster_add(a : TimeseriesdecompemdCluster, b : TimeseriesdecompemdCluster) -> TimeseriesdecompemdCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_emd_cluster_copy(s : TimeseriesdecompemdCluster) -> TimeseriesdecompemdCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_cluster_fill(s : TimeseriesdecompemdCluster, v : Double) -> TimeseriesdecompemdCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_cluster_min(s : TimeseriesdecompemdCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_emd_cluster_max(s : TimeseriesdecompemdCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_emd_cluster_to_string(s : TimeseriesdecompemdCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_model_make(size : Int) -> TimeseriesdecompemdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_model_len(s : TimeseriesdecompemdModel) -> Int { s.size }

pub fn timeseries_decomp_emd_model_get(s : TimeseriesdecompemdModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_model_set(s : TimeseriesdecompemdModel, i : Int, v : Double) -> TimeseriesdecompemdModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_model_sum(s : TimeseriesdecompemdModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_emd_model_mean(s : TimeseriesdecompemdModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_emd_model_scale(s : TimeseriesdecompemdModel, f : Double) -> TimeseriesdecompemdModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_model_add(a : TimeseriesdecompemdModel, b : TimeseriesdecompemdModel) -> TimeseriesdecompemdModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_emd_model_copy(s : TimeseriesdecompemdModel) -> TimeseriesdecompemdModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_model_fill(s : TimeseriesdecompemdModel, v : Double) -> TimeseriesdecompemdModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_model_min(s : TimeseriesdecompemdModel) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_emd_model_max(s : TimeseriesdecompemdModel) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_emd_model_to_string(s : TimeseriesdecompemdModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_layer_make(size : Int) -> TimeseriesdecompemdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_layer_len(s : TimeseriesdecompemdLayer) -> Int { s.size }

pub fn timeseries_decomp_emd_layer_get(s : TimeseriesdecompemdLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_layer_set(s : TimeseriesdecompemdLayer, i : Int, v : Double) -> TimeseriesdecompemdLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_layer_sum(s : TimeseriesdecompemdLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_emd_layer_mean(s : TimeseriesdecompemdLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_emd_layer_scale(s : TimeseriesdecompemdLayer, f : Double) -> TimeseriesdecompemdLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_layer_add(a : TimeseriesdecompemdLayer, b : TimeseriesdecompemdLayer) -> TimeseriesdecompemdLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_emd_layer_copy(s : TimeseriesdecompemdLayer) -> TimeseriesdecompemdLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_layer_fill(s : TimeseriesdecompemdLayer, v : Double) -> TimeseriesdecompemdLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_layer_min(s : TimeseriesdecompemdLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_emd_layer_max(s : TimeseriesdecompemdLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_emd_layer_to_string(s : TimeseriesdecompemdLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_buffer_make(size : Int) -> TimeseriesdecompemdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_buffer_len(s : TimeseriesdecompemdBuffer) -> Int { s.size }

pub fn timeseries_decomp_emd_buffer_get(s : TimeseriesdecompemdBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_buffer_set(s : TimeseriesdecompemdBuffer, i : Int, v : Double) -> TimeseriesdecompemdBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_buffer_sum(s : TimeseriesdecompemdBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_emd_buffer_mean(s : TimeseriesdecompemdBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_emd_buffer_scale(s : TimeseriesdecompemdBuffer, f : Double) -> TimeseriesdecompemdBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_buffer_add(a : TimeseriesdecompemdBuffer, b : TimeseriesdecompemdBuffer) -> TimeseriesdecompemdBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_emd_buffer_copy(s : TimeseriesdecompemdBuffer) -> TimeseriesdecompemdBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_buffer_fill(s : TimeseriesdecompemdBuffer, v : Double) -> TimeseriesdecompemdBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_buffer_min(s : TimeseriesdecompemdBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_emd_buffer_max(s : TimeseriesdecompemdBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_emd_buffer_to_string(s : TimeseriesdecompemdBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_cursor_make(size : Int) -> TimeseriesdecompemdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_cursor_len(s : TimeseriesdecompemdCursor) -> Int { s.size }

pub fn timeseries_decomp_emd_cursor_get(s : TimeseriesdecompemdCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_cursor_set(s : TimeseriesdecompemdCursor, i : Int, v : Double) -> TimeseriesdecompemdCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_cursor_sum(s : TimeseriesdecompemdCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_emd_cursor_mean(s : TimeseriesdecompemdCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_emd_cursor_scale(s : TimeseriesdecompemdCursor, f : Double) -> TimeseriesdecompemdCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_cursor_add(a : TimeseriesdecompemdCursor, b : TimeseriesdecompemdCursor) -> TimeseriesdecompemdCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_emd_cursor_copy(s : TimeseriesdecompemdCursor) -> TimeseriesdecompemdCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_cursor_fill(s : TimeseriesdecompemdCursor, v : Double) -> TimeseriesdecompemdCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_cursor_min(s : TimeseriesdecompemdCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_emd_cursor_max(s : TimeseriesdecompemdCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_emd_cursor_to_string(s : TimeseriesdecompemdCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_view_make(size : Int) -> TimeseriesdecompemdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_view_len(s : TimeseriesdecompemdView) -> Int { s.size }

pub fn timeseries_decomp_emd_view_get(s : TimeseriesdecompemdView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_view_set(s : TimeseriesdecompemdView, i : Int, v : Double) -> TimeseriesdecompemdView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_view_sum(s : TimeseriesdecompemdView) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_emd_view_mean(s : TimeseriesdecompemdView) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_emd_view_scale(s : TimeseriesdecompemdView, f : Double) -> TimeseriesdecompemdView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_view_add(a : TimeseriesdecompemdView, b : TimeseriesdecompemdView) -> TimeseriesdecompemdView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_emd_view_copy(s : TimeseriesdecompemdView) -> TimeseriesdecompemdView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_view_fill(s : TimeseriesdecompemdView, v : Double) -> TimeseriesdecompemdView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_view_min(s : TimeseriesdecompemdView) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_emd_view_max(s : TimeseriesdecompemdView) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_emd_view_to_string(s : TimeseriesdecompemdView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_range_make(size : Int) -> TimeseriesdecompemdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_range_len(s : TimeseriesdecompemdRange) -> Int { s.size }

pub fn timeseries_decomp_emd_range_get(s : TimeseriesdecompemdRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_range_set(s : TimeseriesdecompemdRange, i : Int, v : Double) -> TimeseriesdecompemdRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_range_sum(s : TimeseriesdecompemdRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_emd_range_mean(s : TimeseriesdecompemdRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_emd_range_scale(s : TimeseriesdecompemdRange, f : Double) -> TimeseriesdecompemdRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_range_add(a : TimeseriesdecompemdRange, b : TimeseriesdecompemdRange) -> TimeseriesdecompemdRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_emd_range_copy(s : TimeseriesdecompemdRange) -> TimeseriesdecompemdRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_range_fill(s : TimeseriesdecompemdRange, v : Double) -> TimeseriesdecompemdRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_range_min(s : TimeseriesdecompemdRange) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_emd_range_max(s : TimeseriesdecompemdRange) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_emd_range_to_string(s : TimeseriesdecompemdRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_slice_make(size : Int) -> TimeseriesdecompemdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_slice_len(s : TimeseriesdecompemdSlice) -> Int { s.size }

pub fn timeseries_decomp_emd_slice_get(s : TimeseriesdecompemdSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_slice_set(s : TimeseriesdecompemdSlice, i : Int, v : Double) -> TimeseriesdecompemdSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_slice_sum(s : TimeseriesdecompemdSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_emd_slice_mean(s : TimeseriesdecompemdSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_emd_slice_scale(s : TimeseriesdecompemdSlice, f : Double) -> TimeseriesdecompemdSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_slice_add(a : TimeseriesdecompemdSlice, b : TimeseriesdecompemdSlice) -> TimeseriesdecompemdSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_emd_slice_copy(s : TimeseriesdecompemdSlice) -> TimeseriesdecompemdSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_slice_fill(s : TimeseriesdecompemdSlice, v : Double) -> TimeseriesdecompemdSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_emd_slice_min(s : TimeseriesdecompemdSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_emd_slice_max(s : TimeseriesdecompemdSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_emd_slice_to_string(s : TimeseriesdecompemdSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

