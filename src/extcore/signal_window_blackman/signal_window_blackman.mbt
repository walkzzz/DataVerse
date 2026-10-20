///===
/// extcore/signal_window_blackman

pub(all) struct SignalwindowblackmanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_blackman_make_point(x : Double, y : Double) -> SignalwindowblackmanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_blackman_make_point3(x : Double, y : Double, z : Double) -> SignalwindowblackmanPoint {
  { x, y, z, label: 0 }
}

pub fn signal_window_blackman_point_x(pt : SignalwindowblackmanPoint) -> Double { pt.x }

pub fn signal_window_blackman_point_y(pt : SignalwindowblackmanPoint) -> Double { pt.y }

pub fn signal_window_blackman_point_z(pt : SignalwindowblackmanPoint) -> Double { pt.z }

pub fn signal_window_blackman_point_label(pt : SignalwindowblackmanPoint) -> Int { pt.label }

pub fn signal_window_blackman_point_dist(a : SignalwindowblackmanPoint, b : SignalwindowblackmanPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_window_blackman_point_add(a : SignalwindowblackmanPoint, b : SignalwindowblackmanPoint) -> SignalwindowblackmanPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_window_blackman_point_sub(a : SignalwindowblackmanPoint, b : SignalwindowblackmanPoint) -> SignalwindowblackmanPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_window_blackman_point_scale(pt : SignalwindowblackmanPoint, s : Double) -> SignalwindowblackmanPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_window_blackman_point_dot(a : SignalwindowblackmanPoint, b : SignalwindowblackmanPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_window_blackman_point_cross(a : SignalwindowblackmanPoint, b : SignalwindowblackmanPoint) -> SignalwindowblackmanPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_window_blackman_point_norm(pt : SignalwindowblackmanPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_window_blackman_point_normalize(pt : SignalwindowblackmanPoint) -> SignalwindowblackmanPoint {
  let n = signal_window_blackman_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_window_blackman_point_scale(pt, 1.0 / n) }
}

pub fn signal_window_blackman_point_negate(pt : SignalwindowblackmanPoint) -> SignalwindowblackmanPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_window_blackman_point_mid(a : SignalwindowblackmanPoint, b : SignalwindowblackmanPoint) -> SignalwindowblackmanPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_window_blackman_point_lerp(a : SignalwindowblackmanPoint, b : SignalwindowblackmanPoint, t : Double) -> SignalwindowblackmanPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_window_blackman_point_to_string(pt : SignalwindowblackmanPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalwindowblackmanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_blackman_make_series(vals : Array[Double], name : String) -> SignalwindowblackmanSeries {
  { vals, name, meta: 0 }
}

pub fn signal_window_blackman_series_len(s : SignalwindowblackmanSeries) -> Int { s.vals.length() }

pub fn signal_window_blackman_series_sum(s : SignalwindowblackmanSeries) -> Double { @_common.sum(s.vals) }

pub fn signal_window_blackman_series_mean(s : SignalwindowblackmanSeries) -> Double { @_common.mean(s.vals) }

pub fn signal_window_blackman_series_min(s : SignalwindowblackmanSeries) -> Double { @_common.min(s.vals) }

pub fn signal_window_blackman_series_max(s : SignalwindowblackmanSeries) -> Double { @_common.max(s.vals) }

pub fn signal_window_blackman_series_range(s : SignalwindowblackmanSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn signal_window_blackman_series_var(s : SignalwindowblackmanSeries) -> Double { @_common.variance(s.vals) }

pub fn signal_window_blackman_series_std(s : SignalwindowblackmanSeries) -> Double { @_common.std(s.vals) }

pub fn signal_window_blackman_series_median(s : SignalwindowblackmanSeries) -> Double { @_common.median(s.vals) }

pub fn signal_window_blackman_series_scale(s : SignalwindowblackmanSeries, f : Double) -> SignalwindowblackmanSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn signal_window_blackman_series_add(a : SignalwindowblackmanSeries, b : SignalwindowblackmanSeries) -> SignalwindowblackmanSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_window_blackman_series_sub(a : SignalwindowblackmanSeries, b : SignalwindowblackmanSeries) -> SignalwindowblackmanSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_window_blackman_series_normalize(s : SignalwindowblackmanSeries) -> SignalwindowblackmanSeries {
  let mn = signal_window_blackman_series_min(s)
  let mx = signal_window_blackman_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_window_blackman_series_cumsum(s : SignalwindowblackmanSeries) -> SignalwindowblackmanSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_window_blackman_series_to_string(s : SignalwindowblackmanSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowblackmanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_blackman_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowblackmanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_window_blackman_matrix_identity(n : Int) -> SignalwindowblackmanMatrix {
  let m = signal_window_blackman_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_window_blackman_matrix_get(m : SignalwindowblackmanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_window_blackman_matrix_transpose(m : SignalwindowblackmanMatrix) -> SignalwindowblackmanMatrix {
  let result = signal_window_blackman_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_window_blackman_matrix_add(a : SignalwindowblackmanMatrix, b : SignalwindowblackmanMatrix) -> SignalwindowblackmanMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_window_blackman_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_window_blackman_matrix_scale(m : SignalwindowblackmanMatrix, s : Double) -> SignalwindowblackmanMatrix {
  let result = signal_window_blackman_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_window_blackman_matrix_multiply(a : SignalwindowblackmanMatrix, b : SignalwindowblackmanMatrix) -> SignalwindowblackmanMatrix {
  if a.cols != b.rows { return signal_window_blackman_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_window_blackman_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_window_blackman_matrix_trace(m : SignalwindowblackmanMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_window_blackman_matrix_det(m : SignalwindowblackmanMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_window_blackman_matrix_norm(m : SignalwindowblackmanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_window_blackman_matrix_to_string(m : SignalwindowblackmanMatrix) -> String {
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

pub(all) struct SignalwindowblackmanVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_blackman_make_vector(comps : Array[Double]) -> SignalwindowblackmanVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_blackman_vector_zero(dim : Int) -> SignalwindowblackmanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_window_blackman_vector_add(a : SignalwindowblackmanVector, b : SignalwindowblackmanVector) -> SignalwindowblackmanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn signal_window_blackman_vector_sub(a : SignalwindowblackmanVector, b : SignalwindowblackmanVector) -> SignalwindowblackmanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn signal_window_blackman_vector_scale(v : SignalwindowblackmanVector, s : Double) -> SignalwindowblackmanVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn signal_window_blackman_vector_dot(a : SignalwindowblackmanVector, b : SignalwindowblackmanVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_window_blackman_vector_norm(v : SignalwindowblackmanVector) -> Double { @_common.sqrt(signal_window_blackman_vector_dot(v, v)) }

pub fn signal_window_blackman_vector_normalize(v : SignalwindowblackmanVector) -> SignalwindowblackmanVector {
  let n = signal_window_blackman_vector_norm(v)
  if n < 0.0000001 { v } else { signal_window_blackman_vector_scale(v, 1.0 / n) }
}

pub fn signal_window_blackman_vector_dist(a : SignalwindowblackmanVector, b : SignalwindowblackmanVector) -> Double {
  signal_window_blackman_vector_norm(signal_window_blackman_vector_sub(a, b))
}

pub fn signal_window_blackman_vector_to_string(v : SignalwindowblackmanVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_window_blackman_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_window_blackman_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_window_blackman_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_window_blackman_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_window_blackman_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_window_blackman_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_window_blackman_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_window_blackman_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_window_blackman_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_window_blackman_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_window_blackman_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_window_blackman_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_window_blackman_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_window_blackman_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_window_blackman_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_window_blackman_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_window_blackman_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_window_blackman_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_window_blackman_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_window_blackman_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_window_blackman_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_window_blackman_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_window_blackman_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_window_blackman_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_window_blackman_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_window_blackman_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_window_blackman_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_window_blackman_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_window_blackman_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalwindowblackmanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_frame_make(size : Int) -> SignalwindowblackmanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_frame_len(s : SignalwindowblackmanFrame) -> Int { s.size }

pub fn signal_window_blackman_frame_get(s : SignalwindowblackmanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_frame_set(s : SignalwindowblackmanFrame, i : Int, v : Double) -> SignalwindowblackmanFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_frame_sum(s : SignalwindowblackmanFrame) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_frame_mean(s : SignalwindowblackmanFrame) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_frame_scale(s : SignalwindowblackmanFrame, f : Double) -> SignalwindowblackmanFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_frame_add(a : SignalwindowblackmanFrame, b : SignalwindowblackmanFrame) -> SignalwindowblackmanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_frame_copy(s : SignalwindowblackmanFrame) -> SignalwindowblackmanFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_frame_fill(s : SignalwindowblackmanFrame, v : Double) -> SignalwindowblackmanFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_frame_min(s : SignalwindowblackmanFrame) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_frame_max(s : SignalwindowblackmanFrame) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_frame_to_string(s : SignalwindowblackmanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_table_make(size : Int) -> SignalwindowblackmanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_table_len(s : SignalwindowblackmanTable) -> Int { s.size }

pub fn signal_window_blackman_table_get(s : SignalwindowblackmanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_table_set(s : SignalwindowblackmanTable, i : Int, v : Double) -> SignalwindowblackmanTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_table_sum(s : SignalwindowblackmanTable) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_table_mean(s : SignalwindowblackmanTable) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_table_scale(s : SignalwindowblackmanTable, f : Double) -> SignalwindowblackmanTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_table_add(a : SignalwindowblackmanTable, b : SignalwindowblackmanTable) -> SignalwindowblackmanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_table_copy(s : SignalwindowblackmanTable) -> SignalwindowblackmanTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_table_fill(s : SignalwindowblackmanTable, v : Double) -> SignalwindowblackmanTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_table_min(s : SignalwindowblackmanTable) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_table_max(s : SignalwindowblackmanTable) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_table_to_string(s : SignalwindowblackmanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_graphn_make(size : Int) -> SignalwindowblackmanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_graphn_len(s : SignalwindowblackmanGraphN) -> Int { s.size }

pub fn signal_window_blackman_graphn_get(s : SignalwindowblackmanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_graphn_set(s : SignalwindowblackmanGraphN, i : Int, v : Double) -> SignalwindowblackmanGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_graphn_sum(s : SignalwindowblackmanGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_graphn_mean(s : SignalwindowblackmanGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_graphn_scale(s : SignalwindowblackmanGraphN, f : Double) -> SignalwindowblackmanGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_graphn_add(a : SignalwindowblackmanGraphN, b : SignalwindowblackmanGraphN) -> SignalwindowblackmanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_graphn_copy(s : SignalwindowblackmanGraphN) -> SignalwindowblackmanGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_graphn_fill(s : SignalwindowblackmanGraphN, v : Double) -> SignalwindowblackmanGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_graphn_min(s : SignalwindowblackmanGraphN) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_graphn_max(s : SignalwindowblackmanGraphN) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_graphn_to_string(s : SignalwindowblackmanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_node_make(size : Int) -> SignalwindowblackmanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_node_len(s : SignalwindowblackmanNode) -> Int { s.size }

pub fn signal_window_blackman_node_get(s : SignalwindowblackmanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_node_set(s : SignalwindowblackmanNode, i : Int, v : Double) -> SignalwindowblackmanNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_node_sum(s : SignalwindowblackmanNode) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_node_mean(s : SignalwindowblackmanNode) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_node_scale(s : SignalwindowblackmanNode, f : Double) -> SignalwindowblackmanNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_node_add(a : SignalwindowblackmanNode, b : SignalwindowblackmanNode) -> SignalwindowblackmanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_node_copy(s : SignalwindowblackmanNode) -> SignalwindowblackmanNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_node_fill(s : SignalwindowblackmanNode, v : Double) -> SignalwindowblackmanNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_node_min(s : SignalwindowblackmanNode) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_node_max(s : SignalwindowblackmanNode) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_node_to_string(s : SignalwindowblackmanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_edge_make(size : Int) -> SignalwindowblackmanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_edge_len(s : SignalwindowblackmanEdge) -> Int { s.size }

pub fn signal_window_blackman_edge_get(s : SignalwindowblackmanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_edge_set(s : SignalwindowblackmanEdge, i : Int, v : Double) -> SignalwindowblackmanEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_edge_sum(s : SignalwindowblackmanEdge) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_edge_mean(s : SignalwindowblackmanEdge) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_edge_scale(s : SignalwindowblackmanEdge, f : Double) -> SignalwindowblackmanEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_edge_add(a : SignalwindowblackmanEdge, b : SignalwindowblackmanEdge) -> SignalwindowblackmanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_edge_copy(s : SignalwindowblackmanEdge) -> SignalwindowblackmanEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_edge_fill(s : SignalwindowblackmanEdge, v : Double) -> SignalwindowblackmanEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_edge_min(s : SignalwindowblackmanEdge) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_edge_max(s : SignalwindowblackmanEdge) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_edge_to_string(s : SignalwindowblackmanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_path_make(size : Int) -> SignalwindowblackmanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_path_len(s : SignalwindowblackmanPath) -> Int { s.size }

pub fn signal_window_blackman_path_get(s : SignalwindowblackmanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_path_set(s : SignalwindowblackmanPath, i : Int, v : Double) -> SignalwindowblackmanPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_path_sum(s : SignalwindowblackmanPath) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_path_mean(s : SignalwindowblackmanPath) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_path_scale(s : SignalwindowblackmanPath, f : Double) -> SignalwindowblackmanPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_path_add(a : SignalwindowblackmanPath, b : SignalwindowblackmanPath) -> SignalwindowblackmanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_path_copy(s : SignalwindowblackmanPath) -> SignalwindowblackmanPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_path_fill(s : SignalwindowblackmanPath, v : Double) -> SignalwindowblackmanPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_path_min(s : SignalwindowblackmanPath) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_path_max(s : SignalwindowblackmanPath) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_path_to_string(s : SignalwindowblackmanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_cluster_make(size : Int) -> SignalwindowblackmanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_cluster_len(s : SignalwindowblackmanCluster) -> Int { s.size }

pub fn signal_window_blackman_cluster_get(s : SignalwindowblackmanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_cluster_set(s : SignalwindowblackmanCluster, i : Int, v : Double) -> SignalwindowblackmanCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_cluster_sum(s : SignalwindowblackmanCluster) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_cluster_mean(s : SignalwindowblackmanCluster) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_cluster_scale(s : SignalwindowblackmanCluster, f : Double) -> SignalwindowblackmanCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_cluster_add(a : SignalwindowblackmanCluster, b : SignalwindowblackmanCluster) -> SignalwindowblackmanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_cluster_copy(s : SignalwindowblackmanCluster) -> SignalwindowblackmanCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_cluster_fill(s : SignalwindowblackmanCluster, v : Double) -> SignalwindowblackmanCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_cluster_min(s : SignalwindowblackmanCluster) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_cluster_max(s : SignalwindowblackmanCluster) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_cluster_to_string(s : SignalwindowblackmanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_model_make(size : Int) -> SignalwindowblackmanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_model_len(s : SignalwindowblackmanModel) -> Int { s.size }

pub fn signal_window_blackman_model_get(s : SignalwindowblackmanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_model_set(s : SignalwindowblackmanModel, i : Int, v : Double) -> SignalwindowblackmanModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_model_sum(s : SignalwindowblackmanModel) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_model_mean(s : SignalwindowblackmanModel) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_model_scale(s : SignalwindowblackmanModel, f : Double) -> SignalwindowblackmanModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_model_add(a : SignalwindowblackmanModel, b : SignalwindowblackmanModel) -> SignalwindowblackmanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_model_copy(s : SignalwindowblackmanModel) -> SignalwindowblackmanModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_model_fill(s : SignalwindowblackmanModel, v : Double) -> SignalwindowblackmanModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_model_min(s : SignalwindowblackmanModel) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_model_max(s : SignalwindowblackmanModel) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_model_to_string(s : SignalwindowblackmanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_layer_make(size : Int) -> SignalwindowblackmanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_layer_len(s : SignalwindowblackmanLayer) -> Int { s.size }

pub fn signal_window_blackman_layer_get(s : SignalwindowblackmanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_layer_set(s : SignalwindowblackmanLayer, i : Int, v : Double) -> SignalwindowblackmanLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_layer_sum(s : SignalwindowblackmanLayer) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_layer_mean(s : SignalwindowblackmanLayer) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_layer_scale(s : SignalwindowblackmanLayer, f : Double) -> SignalwindowblackmanLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_layer_add(a : SignalwindowblackmanLayer, b : SignalwindowblackmanLayer) -> SignalwindowblackmanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_layer_copy(s : SignalwindowblackmanLayer) -> SignalwindowblackmanLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_layer_fill(s : SignalwindowblackmanLayer, v : Double) -> SignalwindowblackmanLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_layer_min(s : SignalwindowblackmanLayer) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_layer_max(s : SignalwindowblackmanLayer) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_layer_to_string(s : SignalwindowblackmanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_buffer_make(size : Int) -> SignalwindowblackmanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_buffer_len(s : SignalwindowblackmanBuffer) -> Int { s.size }

pub fn signal_window_blackman_buffer_get(s : SignalwindowblackmanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_buffer_set(s : SignalwindowblackmanBuffer, i : Int, v : Double) -> SignalwindowblackmanBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_buffer_sum(s : SignalwindowblackmanBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_buffer_mean(s : SignalwindowblackmanBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_buffer_scale(s : SignalwindowblackmanBuffer, f : Double) -> SignalwindowblackmanBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_buffer_add(a : SignalwindowblackmanBuffer, b : SignalwindowblackmanBuffer) -> SignalwindowblackmanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_buffer_copy(s : SignalwindowblackmanBuffer) -> SignalwindowblackmanBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_buffer_fill(s : SignalwindowblackmanBuffer, v : Double) -> SignalwindowblackmanBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_buffer_min(s : SignalwindowblackmanBuffer) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_buffer_max(s : SignalwindowblackmanBuffer) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_buffer_to_string(s : SignalwindowblackmanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_cursor_make(size : Int) -> SignalwindowblackmanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_cursor_len(s : SignalwindowblackmanCursor) -> Int { s.size }

pub fn signal_window_blackman_cursor_get(s : SignalwindowblackmanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_cursor_set(s : SignalwindowblackmanCursor, i : Int, v : Double) -> SignalwindowblackmanCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_cursor_sum(s : SignalwindowblackmanCursor) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_cursor_mean(s : SignalwindowblackmanCursor) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_cursor_scale(s : SignalwindowblackmanCursor, f : Double) -> SignalwindowblackmanCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_cursor_add(a : SignalwindowblackmanCursor, b : SignalwindowblackmanCursor) -> SignalwindowblackmanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_cursor_copy(s : SignalwindowblackmanCursor) -> SignalwindowblackmanCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_cursor_fill(s : SignalwindowblackmanCursor, v : Double) -> SignalwindowblackmanCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_cursor_min(s : SignalwindowblackmanCursor) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_cursor_max(s : SignalwindowblackmanCursor) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_cursor_to_string(s : SignalwindowblackmanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_view_make(size : Int) -> SignalwindowblackmanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_view_len(s : SignalwindowblackmanView) -> Int { s.size }

pub fn signal_window_blackman_view_get(s : SignalwindowblackmanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_view_set(s : SignalwindowblackmanView, i : Int, v : Double) -> SignalwindowblackmanView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_view_sum(s : SignalwindowblackmanView) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_view_mean(s : SignalwindowblackmanView) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_view_scale(s : SignalwindowblackmanView, f : Double) -> SignalwindowblackmanView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_view_add(a : SignalwindowblackmanView, b : SignalwindowblackmanView) -> SignalwindowblackmanView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_view_copy(s : SignalwindowblackmanView) -> SignalwindowblackmanView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_view_fill(s : SignalwindowblackmanView, v : Double) -> SignalwindowblackmanView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_view_min(s : SignalwindowblackmanView) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_view_max(s : SignalwindowblackmanView) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_view_to_string(s : SignalwindowblackmanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_range_make(size : Int) -> SignalwindowblackmanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_range_len(s : SignalwindowblackmanRange) -> Int { s.size }

pub fn signal_window_blackman_range_get(s : SignalwindowblackmanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_range_set(s : SignalwindowblackmanRange, i : Int, v : Double) -> SignalwindowblackmanRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_range_sum(s : SignalwindowblackmanRange) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_range_mean(s : SignalwindowblackmanRange) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_range_scale(s : SignalwindowblackmanRange, f : Double) -> SignalwindowblackmanRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_range_add(a : SignalwindowblackmanRange, b : SignalwindowblackmanRange) -> SignalwindowblackmanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_range_copy(s : SignalwindowblackmanRange) -> SignalwindowblackmanRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_range_fill(s : SignalwindowblackmanRange, v : Double) -> SignalwindowblackmanRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_range_min(s : SignalwindowblackmanRange) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_range_max(s : SignalwindowblackmanRange) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_range_to_string(s : SignalwindowblackmanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_slice_make(size : Int) -> SignalwindowblackmanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_slice_len(s : SignalwindowblackmanSlice) -> Int { s.size }

pub fn signal_window_blackman_slice_get(s : SignalwindowblackmanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_slice_set(s : SignalwindowblackmanSlice, i : Int, v : Double) -> SignalwindowblackmanSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_slice_sum(s : SignalwindowblackmanSlice) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_slice_mean(s : SignalwindowblackmanSlice) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_slice_scale(s : SignalwindowblackmanSlice, f : Double) -> SignalwindowblackmanSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_slice_add(a : SignalwindowblackmanSlice, b : SignalwindowblackmanSlice) -> SignalwindowblackmanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_slice_copy(s : SignalwindowblackmanSlice) -> SignalwindowblackmanSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_slice_fill(s : SignalwindowblackmanSlice, v : Double) -> SignalwindowblackmanSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_slice_min(s : SignalwindowblackmanSlice) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_slice_max(s : SignalwindowblackmanSlice) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_slice_to_string(s : SignalwindowblackmanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

