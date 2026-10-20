///===
/// extcore/signal_window_gaussian

pub(all) struct SignalwindowgaussianPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_gaussian_make_point(x : Double, y : Double) -> SignalwindowgaussianPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_gaussian_make_point3(x : Double, y : Double, z : Double) -> SignalwindowgaussianPoint {
  { x, y, z, label: 0 }
}

pub fn signal_window_gaussian_point_x(pt : SignalwindowgaussianPoint) -> Double { pt.x }

pub fn signal_window_gaussian_point_y(pt : SignalwindowgaussianPoint) -> Double { pt.y }

pub fn signal_window_gaussian_point_z(pt : SignalwindowgaussianPoint) -> Double { pt.z }

pub fn signal_window_gaussian_point_label(pt : SignalwindowgaussianPoint) -> Int { pt.label }

pub fn signal_window_gaussian_point_dist(a : SignalwindowgaussianPoint, b : SignalwindowgaussianPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_window_gaussian_point_add(a : SignalwindowgaussianPoint, b : SignalwindowgaussianPoint) -> SignalwindowgaussianPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_window_gaussian_point_sub(a : SignalwindowgaussianPoint, b : SignalwindowgaussianPoint) -> SignalwindowgaussianPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_window_gaussian_point_scale(pt : SignalwindowgaussianPoint, s : Double) -> SignalwindowgaussianPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_window_gaussian_point_dot(a : SignalwindowgaussianPoint, b : SignalwindowgaussianPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_window_gaussian_point_cross(a : SignalwindowgaussianPoint, b : SignalwindowgaussianPoint) -> SignalwindowgaussianPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_window_gaussian_point_norm(pt : SignalwindowgaussianPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_window_gaussian_point_normalize(pt : SignalwindowgaussianPoint) -> SignalwindowgaussianPoint {
  let n = signal_window_gaussian_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_window_gaussian_point_scale(pt, 1.0 / n) }
}

pub fn signal_window_gaussian_point_negate(pt : SignalwindowgaussianPoint) -> SignalwindowgaussianPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_window_gaussian_point_mid(a : SignalwindowgaussianPoint, b : SignalwindowgaussianPoint) -> SignalwindowgaussianPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_window_gaussian_point_lerp(a : SignalwindowgaussianPoint, b : SignalwindowgaussianPoint, t : Double) -> SignalwindowgaussianPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_window_gaussian_point_to_string(pt : SignalwindowgaussianPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalwindowgaussianSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_gaussian_make_series(vals : Array[Double], name : String) -> SignalwindowgaussianSeries {
  { vals, name, meta: 0 }
}

pub fn signal_window_gaussian_series_len(s : SignalwindowgaussianSeries) -> Int { s.vals.length() }

pub fn signal_window_gaussian_series_sum(s : SignalwindowgaussianSeries) -> Double { @_common.sum(s.vals) }

pub fn signal_window_gaussian_series_mean(s : SignalwindowgaussianSeries) -> Double { @_common.mean(s.vals) }

pub fn signal_window_gaussian_series_min(s : SignalwindowgaussianSeries) -> Double { @_common.min(s.vals) }

pub fn signal_window_gaussian_series_max(s : SignalwindowgaussianSeries) -> Double { @_common.max(s.vals) }

pub fn signal_window_gaussian_series_range(s : SignalwindowgaussianSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn signal_window_gaussian_series_var(s : SignalwindowgaussianSeries) -> Double { @_common.variance(s.vals) }

pub fn signal_window_gaussian_series_std(s : SignalwindowgaussianSeries) -> Double { @_common.std(s.vals) }

pub fn signal_window_gaussian_series_median(s : SignalwindowgaussianSeries) -> Double { @_common.median(s.vals) }

pub fn signal_window_gaussian_series_scale(s : SignalwindowgaussianSeries, f : Double) -> SignalwindowgaussianSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn signal_window_gaussian_series_add(a : SignalwindowgaussianSeries, b : SignalwindowgaussianSeries) -> SignalwindowgaussianSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_window_gaussian_series_sub(a : SignalwindowgaussianSeries, b : SignalwindowgaussianSeries) -> SignalwindowgaussianSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_window_gaussian_series_normalize(s : SignalwindowgaussianSeries) -> SignalwindowgaussianSeries {
  let mn = signal_window_gaussian_series_min(s)
  let mx = signal_window_gaussian_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_window_gaussian_series_cumsum(s : SignalwindowgaussianSeries) -> SignalwindowgaussianSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_window_gaussian_series_to_string(s : SignalwindowgaussianSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowgaussianMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_gaussian_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowgaussianMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_window_gaussian_matrix_identity(n : Int) -> SignalwindowgaussianMatrix {
  let m = signal_window_gaussian_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_window_gaussian_matrix_get(m : SignalwindowgaussianMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_window_gaussian_matrix_transpose(m : SignalwindowgaussianMatrix) -> SignalwindowgaussianMatrix {
  let result = signal_window_gaussian_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_window_gaussian_matrix_add(a : SignalwindowgaussianMatrix, b : SignalwindowgaussianMatrix) -> SignalwindowgaussianMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_window_gaussian_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_window_gaussian_matrix_scale(m : SignalwindowgaussianMatrix, s : Double) -> SignalwindowgaussianMatrix {
  let result = signal_window_gaussian_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_window_gaussian_matrix_multiply(a : SignalwindowgaussianMatrix, b : SignalwindowgaussianMatrix) -> SignalwindowgaussianMatrix {
  if a.cols != b.rows { return signal_window_gaussian_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_window_gaussian_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_window_gaussian_matrix_trace(m : SignalwindowgaussianMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_window_gaussian_matrix_det(m : SignalwindowgaussianMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_window_gaussian_matrix_norm(m : SignalwindowgaussianMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_window_gaussian_matrix_to_string(m : SignalwindowgaussianMatrix) -> String {
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

pub(all) struct SignalwindowgaussianVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_gaussian_make_vector(comps : Array[Double]) -> SignalwindowgaussianVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_gaussian_vector_zero(dim : Int) -> SignalwindowgaussianVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_window_gaussian_vector_add(a : SignalwindowgaussianVector, b : SignalwindowgaussianVector) -> SignalwindowgaussianVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn signal_window_gaussian_vector_sub(a : SignalwindowgaussianVector, b : SignalwindowgaussianVector) -> SignalwindowgaussianVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn signal_window_gaussian_vector_scale(v : SignalwindowgaussianVector, s : Double) -> SignalwindowgaussianVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn signal_window_gaussian_vector_dot(a : SignalwindowgaussianVector, b : SignalwindowgaussianVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_window_gaussian_vector_norm(v : SignalwindowgaussianVector) -> Double { @_common.sqrt(signal_window_gaussian_vector_dot(v, v)) }

pub fn signal_window_gaussian_vector_normalize(v : SignalwindowgaussianVector) -> SignalwindowgaussianVector {
  let n = signal_window_gaussian_vector_norm(v)
  if n < 0.0000001 { v } else { signal_window_gaussian_vector_scale(v, 1.0 / n) }
}

pub fn signal_window_gaussian_vector_dist(a : SignalwindowgaussianVector, b : SignalwindowgaussianVector) -> Double {
  signal_window_gaussian_vector_norm(signal_window_gaussian_vector_sub(a, b))
}

pub fn signal_window_gaussian_vector_to_string(v : SignalwindowgaussianVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_window_gaussian_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_window_gaussian_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_window_gaussian_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_window_gaussian_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_window_gaussian_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_window_gaussian_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_window_gaussian_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_window_gaussian_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_window_gaussian_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_window_gaussian_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_window_gaussian_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_window_gaussian_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_window_gaussian_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_window_gaussian_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_window_gaussian_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_window_gaussian_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_window_gaussian_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_window_gaussian_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_window_gaussian_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_window_gaussian_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_window_gaussian_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_window_gaussian_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_window_gaussian_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_window_gaussian_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_window_gaussian_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_window_gaussian_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_window_gaussian_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_window_gaussian_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_window_gaussian_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalwindowgaussianFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_frame_make(size : Int) -> SignalwindowgaussianFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_frame_len(s : SignalwindowgaussianFrame) -> Int { s.size }

pub fn signal_window_gaussian_frame_get(s : SignalwindowgaussianFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_frame_set(s : SignalwindowgaussianFrame, i : Int, v : Double) -> SignalwindowgaussianFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_frame_sum(s : SignalwindowgaussianFrame) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_frame_mean(s : SignalwindowgaussianFrame) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_frame_scale(s : SignalwindowgaussianFrame, f : Double) -> SignalwindowgaussianFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_frame_add(a : SignalwindowgaussianFrame, b : SignalwindowgaussianFrame) -> SignalwindowgaussianFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_frame_copy(s : SignalwindowgaussianFrame) -> SignalwindowgaussianFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_frame_fill(s : SignalwindowgaussianFrame, v : Double) -> SignalwindowgaussianFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_frame_min(s : SignalwindowgaussianFrame) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_frame_max(s : SignalwindowgaussianFrame) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_frame_to_string(s : SignalwindowgaussianFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_table_make(size : Int) -> SignalwindowgaussianTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_table_len(s : SignalwindowgaussianTable) -> Int { s.size }

pub fn signal_window_gaussian_table_get(s : SignalwindowgaussianTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_table_set(s : SignalwindowgaussianTable, i : Int, v : Double) -> SignalwindowgaussianTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_table_sum(s : SignalwindowgaussianTable) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_table_mean(s : SignalwindowgaussianTable) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_table_scale(s : SignalwindowgaussianTable, f : Double) -> SignalwindowgaussianTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_table_add(a : SignalwindowgaussianTable, b : SignalwindowgaussianTable) -> SignalwindowgaussianTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_table_copy(s : SignalwindowgaussianTable) -> SignalwindowgaussianTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_table_fill(s : SignalwindowgaussianTable, v : Double) -> SignalwindowgaussianTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_table_min(s : SignalwindowgaussianTable) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_table_max(s : SignalwindowgaussianTable) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_table_to_string(s : SignalwindowgaussianTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_graphn_make(size : Int) -> SignalwindowgaussianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_graphn_len(s : SignalwindowgaussianGraphN) -> Int { s.size }

pub fn signal_window_gaussian_graphn_get(s : SignalwindowgaussianGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_graphn_set(s : SignalwindowgaussianGraphN, i : Int, v : Double) -> SignalwindowgaussianGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_graphn_sum(s : SignalwindowgaussianGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_graphn_mean(s : SignalwindowgaussianGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_graphn_scale(s : SignalwindowgaussianGraphN, f : Double) -> SignalwindowgaussianGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_graphn_add(a : SignalwindowgaussianGraphN, b : SignalwindowgaussianGraphN) -> SignalwindowgaussianGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_graphn_copy(s : SignalwindowgaussianGraphN) -> SignalwindowgaussianGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_graphn_fill(s : SignalwindowgaussianGraphN, v : Double) -> SignalwindowgaussianGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_graphn_min(s : SignalwindowgaussianGraphN) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_graphn_max(s : SignalwindowgaussianGraphN) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_graphn_to_string(s : SignalwindowgaussianGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_node_make(size : Int) -> SignalwindowgaussianNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_node_len(s : SignalwindowgaussianNode) -> Int { s.size }

pub fn signal_window_gaussian_node_get(s : SignalwindowgaussianNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_node_set(s : SignalwindowgaussianNode, i : Int, v : Double) -> SignalwindowgaussianNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_node_sum(s : SignalwindowgaussianNode) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_node_mean(s : SignalwindowgaussianNode) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_node_scale(s : SignalwindowgaussianNode, f : Double) -> SignalwindowgaussianNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_node_add(a : SignalwindowgaussianNode, b : SignalwindowgaussianNode) -> SignalwindowgaussianNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_node_copy(s : SignalwindowgaussianNode) -> SignalwindowgaussianNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_node_fill(s : SignalwindowgaussianNode, v : Double) -> SignalwindowgaussianNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_node_min(s : SignalwindowgaussianNode) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_node_max(s : SignalwindowgaussianNode) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_node_to_string(s : SignalwindowgaussianNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_edge_make(size : Int) -> SignalwindowgaussianEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_edge_len(s : SignalwindowgaussianEdge) -> Int { s.size }

pub fn signal_window_gaussian_edge_get(s : SignalwindowgaussianEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_edge_set(s : SignalwindowgaussianEdge, i : Int, v : Double) -> SignalwindowgaussianEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_edge_sum(s : SignalwindowgaussianEdge) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_edge_mean(s : SignalwindowgaussianEdge) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_edge_scale(s : SignalwindowgaussianEdge, f : Double) -> SignalwindowgaussianEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_edge_add(a : SignalwindowgaussianEdge, b : SignalwindowgaussianEdge) -> SignalwindowgaussianEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_edge_copy(s : SignalwindowgaussianEdge) -> SignalwindowgaussianEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_edge_fill(s : SignalwindowgaussianEdge, v : Double) -> SignalwindowgaussianEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_edge_min(s : SignalwindowgaussianEdge) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_edge_max(s : SignalwindowgaussianEdge) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_edge_to_string(s : SignalwindowgaussianEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_path_make(size : Int) -> SignalwindowgaussianPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_path_len(s : SignalwindowgaussianPath) -> Int { s.size }

pub fn signal_window_gaussian_path_get(s : SignalwindowgaussianPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_path_set(s : SignalwindowgaussianPath, i : Int, v : Double) -> SignalwindowgaussianPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_path_sum(s : SignalwindowgaussianPath) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_path_mean(s : SignalwindowgaussianPath) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_path_scale(s : SignalwindowgaussianPath, f : Double) -> SignalwindowgaussianPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_path_add(a : SignalwindowgaussianPath, b : SignalwindowgaussianPath) -> SignalwindowgaussianPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_path_copy(s : SignalwindowgaussianPath) -> SignalwindowgaussianPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_path_fill(s : SignalwindowgaussianPath, v : Double) -> SignalwindowgaussianPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_path_min(s : SignalwindowgaussianPath) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_path_max(s : SignalwindowgaussianPath) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_path_to_string(s : SignalwindowgaussianPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_cluster_make(size : Int) -> SignalwindowgaussianCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_cluster_len(s : SignalwindowgaussianCluster) -> Int { s.size }

pub fn signal_window_gaussian_cluster_get(s : SignalwindowgaussianCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_cluster_set(s : SignalwindowgaussianCluster, i : Int, v : Double) -> SignalwindowgaussianCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_cluster_sum(s : SignalwindowgaussianCluster) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_cluster_mean(s : SignalwindowgaussianCluster) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_cluster_scale(s : SignalwindowgaussianCluster, f : Double) -> SignalwindowgaussianCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_cluster_add(a : SignalwindowgaussianCluster, b : SignalwindowgaussianCluster) -> SignalwindowgaussianCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_cluster_copy(s : SignalwindowgaussianCluster) -> SignalwindowgaussianCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_cluster_fill(s : SignalwindowgaussianCluster, v : Double) -> SignalwindowgaussianCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_cluster_min(s : SignalwindowgaussianCluster) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_cluster_max(s : SignalwindowgaussianCluster) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_cluster_to_string(s : SignalwindowgaussianCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_model_make(size : Int) -> SignalwindowgaussianModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_model_len(s : SignalwindowgaussianModel) -> Int { s.size }

pub fn signal_window_gaussian_model_get(s : SignalwindowgaussianModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_model_set(s : SignalwindowgaussianModel, i : Int, v : Double) -> SignalwindowgaussianModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_model_sum(s : SignalwindowgaussianModel) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_model_mean(s : SignalwindowgaussianModel) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_model_scale(s : SignalwindowgaussianModel, f : Double) -> SignalwindowgaussianModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_model_add(a : SignalwindowgaussianModel, b : SignalwindowgaussianModel) -> SignalwindowgaussianModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_model_copy(s : SignalwindowgaussianModel) -> SignalwindowgaussianModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_model_fill(s : SignalwindowgaussianModel, v : Double) -> SignalwindowgaussianModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_model_min(s : SignalwindowgaussianModel) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_model_max(s : SignalwindowgaussianModel) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_model_to_string(s : SignalwindowgaussianModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_layer_make(size : Int) -> SignalwindowgaussianLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_layer_len(s : SignalwindowgaussianLayer) -> Int { s.size }

pub fn signal_window_gaussian_layer_get(s : SignalwindowgaussianLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_layer_set(s : SignalwindowgaussianLayer, i : Int, v : Double) -> SignalwindowgaussianLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_layer_sum(s : SignalwindowgaussianLayer) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_layer_mean(s : SignalwindowgaussianLayer) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_layer_scale(s : SignalwindowgaussianLayer, f : Double) -> SignalwindowgaussianLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_layer_add(a : SignalwindowgaussianLayer, b : SignalwindowgaussianLayer) -> SignalwindowgaussianLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_layer_copy(s : SignalwindowgaussianLayer) -> SignalwindowgaussianLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_layer_fill(s : SignalwindowgaussianLayer, v : Double) -> SignalwindowgaussianLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_layer_min(s : SignalwindowgaussianLayer) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_layer_max(s : SignalwindowgaussianLayer) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_layer_to_string(s : SignalwindowgaussianLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_buffer_make(size : Int) -> SignalwindowgaussianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_buffer_len(s : SignalwindowgaussianBuffer) -> Int { s.size }

pub fn signal_window_gaussian_buffer_get(s : SignalwindowgaussianBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_buffer_set(s : SignalwindowgaussianBuffer, i : Int, v : Double) -> SignalwindowgaussianBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_buffer_sum(s : SignalwindowgaussianBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_buffer_mean(s : SignalwindowgaussianBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_buffer_scale(s : SignalwindowgaussianBuffer, f : Double) -> SignalwindowgaussianBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_buffer_add(a : SignalwindowgaussianBuffer, b : SignalwindowgaussianBuffer) -> SignalwindowgaussianBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_buffer_copy(s : SignalwindowgaussianBuffer) -> SignalwindowgaussianBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_buffer_fill(s : SignalwindowgaussianBuffer, v : Double) -> SignalwindowgaussianBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_buffer_min(s : SignalwindowgaussianBuffer) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_buffer_max(s : SignalwindowgaussianBuffer) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_buffer_to_string(s : SignalwindowgaussianBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_cursor_make(size : Int) -> SignalwindowgaussianCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_cursor_len(s : SignalwindowgaussianCursor) -> Int { s.size }

pub fn signal_window_gaussian_cursor_get(s : SignalwindowgaussianCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_cursor_set(s : SignalwindowgaussianCursor, i : Int, v : Double) -> SignalwindowgaussianCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_cursor_sum(s : SignalwindowgaussianCursor) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_cursor_mean(s : SignalwindowgaussianCursor) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_cursor_scale(s : SignalwindowgaussianCursor, f : Double) -> SignalwindowgaussianCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_cursor_add(a : SignalwindowgaussianCursor, b : SignalwindowgaussianCursor) -> SignalwindowgaussianCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_cursor_copy(s : SignalwindowgaussianCursor) -> SignalwindowgaussianCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_cursor_fill(s : SignalwindowgaussianCursor, v : Double) -> SignalwindowgaussianCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_cursor_min(s : SignalwindowgaussianCursor) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_cursor_max(s : SignalwindowgaussianCursor) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_cursor_to_string(s : SignalwindowgaussianCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_view_make(size : Int) -> SignalwindowgaussianView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_view_len(s : SignalwindowgaussianView) -> Int { s.size }

pub fn signal_window_gaussian_view_get(s : SignalwindowgaussianView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_view_set(s : SignalwindowgaussianView, i : Int, v : Double) -> SignalwindowgaussianView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_view_sum(s : SignalwindowgaussianView) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_view_mean(s : SignalwindowgaussianView) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_view_scale(s : SignalwindowgaussianView, f : Double) -> SignalwindowgaussianView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_view_add(a : SignalwindowgaussianView, b : SignalwindowgaussianView) -> SignalwindowgaussianView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_view_copy(s : SignalwindowgaussianView) -> SignalwindowgaussianView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_view_fill(s : SignalwindowgaussianView, v : Double) -> SignalwindowgaussianView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_view_min(s : SignalwindowgaussianView) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_view_max(s : SignalwindowgaussianView) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_view_to_string(s : SignalwindowgaussianView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_range_make(size : Int) -> SignalwindowgaussianRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_range_len(s : SignalwindowgaussianRange) -> Int { s.size }

pub fn signal_window_gaussian_range_get(s : SignalwindowgaussianRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_range_set(s : SignalwindowgaussianRange, i : Int, v : Double) -> SignalwindowgaussianRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_range_sum(s : SignalwindowgaussianRange) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_range_mean(s : SignalwindowgaussianRange) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_range_scale(s : SignalwindowgaussianRange, f : Double) -> SignalwindowgaussianRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_range_add(a : SignalwindowgaussianRange, b : SignalwindowgaussianRange) -> SignalwindowgaussianRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_range_copy(s : SignalwindowgaussianRange) -> SignalwindowgaussianRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_range_fill(s : SignalwindowgaussianRange, v : Double) -> SignalwindowgaussianRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_range_min(s : SignalwindowgaussianRange) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_range_max(s : SignalwindowgaussianRange) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_range_to_string(s : SignalwindowgaussianRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_slice_make(size : Int) -> SignalwindowgaussianSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_slice_len(s : SignalwindowgaussianSlice) -> Int { s.size }

pub fn signal_window_gaussian_slice_get(s : SignalwindowgaussianSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_slice_set(s : SignalwindowgaussianSlice, i : Int, v : Double) -> SignalwindowgaussianSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_slice_sum(s : SignalwindowgaussianSlice) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_slice_mean(s : SignalwindowgaussianSlice) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_slice_scale(s : SignalwindowgaussianSlice, f : Double) -> SignalwindowgaussianSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_slice_add(a : SignalwindowgaussianSlice, b : SignalwindowgaussianSlice) -> SignalwindowgaussianSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_slice_copy(s : SignalwindowgaussianSlice) -> SignalwindowgaussianSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_slice_fill(s : SignalwindowgaussianSlice, v : Double) -> SignalwindowgaussianSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_slice_min(s : SignalwindowgaussianSlice) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_slice_max(s : SignalwindowgaussianSlice) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_slice_to_string(s : SignalwindowgaussianSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

