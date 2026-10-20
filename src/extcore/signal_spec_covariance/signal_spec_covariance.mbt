///===
/// extcore/signal_spec_covariance

pub(all) struct SignalspeccovariancePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_covariance_make_point(x : Double, y : Double) -> SignalspeccovariancePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_covariance_make_point3(x : Double, y : Double, z : Double) -> SignalspeccovariancePoint {
  { x, y, z, label: 0 }
}

pub fn signal_spec_covariance_point_x(pt : SignalspeccovariancePoint) -> Double { pt.x }

pub fn signal_spec_covariance_point_y(pt : SignalspeccovariancePoint) -> Double { pt.y }

pub fn signal_spec_covariance_point_z(pt : SignalspeccovariancePoint) -> Double { pt.z }

pub fn signal_spec_covariance_point_label(pt : SignalspeccovariancePoint) -> Int { pt.label }

pub fn signal_spec_covariance_point_dist(a : SignalspeccovariancePoint, b : SignalspeccovariancePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_spec_covariance_point_add(a : SignalspeccovariancePoint, b : SignalspeccovariancePoint) -> SignalspeccovariancePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_spec_covariance_point_sub(a : SignalspeccovariancePoint, b : SignalspeccovariancePoint) -> SignalspeccovariancePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_spec_covariance_point_scale(pt : SignalspeccovariancePoint, s : Double) -> SignalspeccovariancePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_spec_covariance_point_dot(a : SignalspeccovariancePoint, b : SignalspeccovariancePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_spec_covariance_point_cross(a : SignalspeccovariancePoint, b : SignalspeccovariancePoint) -> SignalspeccovariancePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_spec_covariance_point_norm(pt : SignalspeccovariancePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_spec_covariance_point_normalize(pt : SignalspeccovariancePoint) -> SignalspeccovariancePoint {
  let n = signal_spec_covariance_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_spec_covariance_point_scale(pt, 1.0 / n) }
}

pub fn signal_spec_covariance_point_negate(pt : SignalspeccovariancePoint) -> SignalspeccovariancePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_spec_covariance_point_mid(a : SignalspeccovariancePoint, b : SignalspeccovariancePoint) -> SignalspeccovariancePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_spec_covariance_point_lerp(a : SignalspeccovariancePoint, b : SignalspeccovariancePoint, t : Double) -> SignalspeccovariancePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_spec_covariance_point_to_string(pt : SignalspeccovariancePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalspeccovarianceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_covariance_make_series(vals : Array[Double], name : String) -> SignalspeccovarianceSeries {
  { vals, name, meta: 0 }
}

pub fn signal_spec_covariance_series_len(s : SignalspeccovarianceSeries) -> Int { s.vals.length() }

pub fn signal_spec_covariance_series_sum(s : SignalspeccovarianceSeries) -> Double { @_common.sum(s.vals) }

pub fn signal_spec_covariance_series_mean(s : SignalspeccovarianceSeries) -> Double { @_common.mean(s.vals) }

pub fn signal_spec_covariance_series_min(s : SignalspeccovarianceSeries) -> Double { @_common.min(s.vals) }

pub fn signal_spec_covariance_series_max(s : SignalspeccovarianceSeries) -> Double { @_common.max(s.vals) }

pub fn signal_spec_covariance_series_range(s : SignalspeccovarianceSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn signal_spec_covariance_series_var(s : SignalspeccovarianceSeries) -> Double { @_common.variance(s.vals) }

pub fn signal_spec_covariance_series_std(s : SignalspeccovarianceSeries) -> Double { @_common.std(s.vals) }

pub fn signal_spec_covariance_series_median(s : SignalspeccovarianceSeries) -> Double { @_common.median(s.vals) }

pub fn signal_spec_covariance_series_scale(s : SignalspeccovarianceSeries, f : Double) -> SignalspeccovarianceSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn signal_spec_covariance_series_add(a : SignalspeccovarianceSeries, b : SignalspeccovarianceSeries) -> SignalspeccovarianceSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_spec_covariance_series_sub(a : SignalspeccovarianceSeries, b : SignalspeccovarianceSeries) -> SignalspeccovarianceSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_spec_covariance_series_normalize(s : SignalspeccovarianceSeries) -> SignalspeccovarianceSeries {
  let mn = signal_spec_covariance_series_min(s)
  let mx = signal_spec_covariance_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_spec_covariance_series_cumsum(s : SignalspeccovarianceSeries) -> SignalspeccovarianceSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_spec_covariance_series_to_string(s : SignalspeccovarianceSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspeccovarianceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_covariance_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspeccovarianceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_covariance_matrix_identity(n : Int) -> SignalspeccovarianceMatrix {
  let m = signal_spec_covariance_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_spec_covariance_matrix_get(m : SignalspeccovarianceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_spec_covariance_matrix_transpose(m : SignalspeccovarianceMatrix) -> SignalspeccovarianceMatrix {
  let result = signal_spec_covariance_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_spec_covariance_matrix_add(a : SignalspeccovarianceMatrix, b : SignalspeccovarianceMatrix) -> SignalspeccovarianceMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_spec_covariance_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_spec_covariance_matrix_scale(m : SignalspeccovarianceMatrix, s : Double) -> SignalspeccovarianceMatrix {
  let result = signal_spec_covariance_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_spec_covariance_matrix_multiply(a : SignalspeccovarianceMatrix, b : SignalspeccovarianceMatrix) -> SignalspeccovarianceMatrix {
  if a.cols != b.rows { return signal_spec_covariance_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_spec_covariance_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_spec_covariance_matrix_trace(m : SignalspeccovarianceMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_spec_covariance_matrix_det(m : SignalspeccovarianceMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_spec_covariance_matrix_norm(m : SignalspeccovarianceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_spec_covariance_matrix_to_string(m : SignalspeccovarianceMatrix) -> String {
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

pub(all) struct SignalspeccovarianceVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_covariance_make_vector(comps : Array[Double]) -> SignalspeccovarianceVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_covariance_vector_zero(dim : Int) -> SignalspeccovarianceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_spec_covariance_vector_add(a : SignalspeccovarianceVector, b : SignalspeccovarianceVector) -> SignalspeccovarianceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn signal_spec_covariance_vector_sub(a : SignalspeccovarianceVector, b : SignalspeccovarianceVector) -> SignalspeccovarianceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn signal_spec_covariance_vector_scale(v : SignalspeccovarianceVector, s : Double) -> SignalspeccovarianceVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn signal_spec_covariance_vector_dot(a : SignalspeccovarianceVector, b : SignalspeccovarianceVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_spec_covariance_vector_norm(v : SignalspeccovarianceVector) -> Double { @_common.sqrt(signal_spec_covariance_vector_dot(v, v)) }

pub fn signal_spec_covariance_vector_normalize(v : SignalspeccovarianceVector) -> SignalspeccovarianceVector {
  let n = signal_spec_covariance_vector_norm(v)
  if n < 0.0000001 { v } else { signal_spec_covariance_vector_scale(v, 1.0 / n) }
}

pub fn signal_spec_covariance_vector_dist(a : SignalspeccovarianceVector, b : SignalspeccovarianceVector) -> Double {
  signal_spec_covariance_vector_norm(signal_spec_covariance_vector_sub(a, b))
}

pub fn signal_spec_covariance_vector_to_string(v : SignalspeccovarianceVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_spec_covariance_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_spec_covariance_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_spec_covariance_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_spec_covariance_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_spec_covariance_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_spec_covariance_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_spec_covariance_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_spec_covariance_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_spec_covariance_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_spec_covariance_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_spec_covariance_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_spec_covariance_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_spec_covariance_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_spec_covariance_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_spec_covariance_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_spec_covariance_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_spec_covariance_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_spec_covariance_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_spec_covariance_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_spec_covariance_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_spec_covariance_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_spec_covariance_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_spec_covariance_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_spec_covariance_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_spec_covariance_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_spec_covariance_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_spec_covariance_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_spec_covariance_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_spec_covariance_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalspeccovarianceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_frame_make(size : Int) -> SignalspeccovarianceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_frame_len(s : SignalspeccovarianceFrame) -> Int { s.size }

pub fn signal_spec_covariance_frame_get(s : SignalspeccovarianceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_frame_set(s : SignalspeccovarianceFrame, i : Int, v : Double) -> SignalspeccovarianceFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_frame_sum(s : SignalspeccovarianceFrame) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_frame_mean(s : SignalspeccovarianceFrame) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_frame_scale(s : SignalspeccovarianceFrame, f : Double) -> SignalspeccovarianceFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_frame_add(a : SignalspeccovarianceFrame, b : SignalspeccovarianceFrame) -> SignalspeccovarianceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_frame_copy(s : SignalspeccovarianceFrame) -> SignalspeccovarianceFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_frame_fill(s : SignalspeccovarianceFrame, v : Double) -> SignalspeccovarianceFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_frame_min(s : SignalspeccovarianceFrame) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_frame_max(s : SignalspeccovarianceFrame) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_frame_to_string(s : SignalspeccovarianceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovarianceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_table_make(size : Int) -> SignalspeccovarianceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_table_len(s : SignalspeccovarianceTable) -> Int { s.size }

pub fn signal_spec_covariance_table_get(s : SignalspeccovarianceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_table_set(s : SignalspeccovarianceTable, i : Int, v : Double) -> SignalspeccovarianceTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_table_sum(s : SignalspeccovarianceTable) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_table_mean(s : SignalspeccovarianceTable) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_table_scale(s : SignalspeccovarianceTable, f : Double) -> SignalspeccovarianceTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_table_add(a : SignalspeccovarianceTable, b : SignalspeccovarianceTable) -> SignalspeccovarianceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_table_copy(s : SignalspeccovarianceTable) -> SignalspeccovarianceTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_table_fill(s : SignalspeccovarianceTable, v : Double) -> SignalspeccovarianceTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_table_min(s : SignalspeccovarianceTable) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_table_max(s : SignalspeccovarianceTable) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_table_to_string(s : SignalspeccovarianceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovarianceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_graphn_make(size : Int) -> SignalspeccovarianceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_graphn_len(s : SignalspeccovarianceGraphN) -> Int { s.size }

pub fn signal_spec_covariance_graphn_get(s : SignalspeccovarianceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_graphn_set(s : SignalspeccovarianceGraphN, i : Int, v : Double) -> SignalspeccovarianceGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_graphn_sum(s : SignalspeccovarianceGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_graphn_mean(s : SignalspeccovarianceGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_graphn_scale(s : SignalspeccovarianceGraphN, f : Double) -> SignalspeccovarianceGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_graphn_add(a : SignalspeccovarianceGraphN, b : SignalspeccovarianceGraphN) -> SignalspeccovarianceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_graphn_copy(s : SignalspeccovarianceGraphN) -> SignalspeccovarianceGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_graphn_fill(s : SignalspeccovarianceGraphN, v : Double) -> SignalspeccovarianceGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_graphn_min(s : SignalspeccovarianceGraphN) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_graphn_max(s : SignalspeccovarianceGraphN) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_graphn_to_string(s : SignalspeccovarianceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovarianceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_node_make(size : Int) -> SignalspeccovarianceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_node_len(s : SignalspeccovarianceNode) -> Int { s.size }

pub fn signal_spec_covariance_node_get(s : SignalspeccovarianceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_node_set(s : SignalspeccovarianceNode, i : Int, v : Double) -> SignalspeccovarianceNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_node_sum(s : SignalspeccovarianceNode) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_node_mean(s : SignalspeccovarianceNode) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_node_scale(s : SignalspeccovarianceNode, f : Double) -> SignalspeccovarianceNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_node_add(a : SignalspeccovarianceNode, b : SignalspeccovarianceNode) -> SignalspeccovarianceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_node_copy(s : SignalspeccovarianceNode) -> SignalspeccovarianceNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_node_fill(s : SignalspeccovarianceNode, v : Double) -> SignalspeccovarianceNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_node_min(s : SignalspeccovarianceNode) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_node_max(s : SignalspeccovarianceNode) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_node_to_string(s : SignalspeccovarianceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovarianceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_edge_make(size : Int) -> SignalspeccovarianceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_edge_len(s : SignalspeccovarianceEdge) -> Int { s.size }

pub fn signal_spec_covariance_edge_get(s : SignalspeccovarianceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_edge_set(s : SignalspeccovarianceEdge, i : Int, v : Double) -> SignalspeccovarianceEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_edge_sum(s : SignalspeccovarianceEdge) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_edge_mean(s : SignalspeccovarianceEdge) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_edge_scale(s : SignalspeccovarianceEdge, f : Double) -> SignalspeccovarianceEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_edge_add(a : SignalspeccovarianceEdge, b : SignalspeccovarianceEdge) -> SignalspeccovarianceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_edge_copy(s : SignalspeccovarianceEdge) -> SignalspeccovarianceEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_edge_fill(s : SignalspeccovarianceEdge, v : Double) -> SignalspeccovarianceEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_edge_min(s : SignalspeccovarianceEdge) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_edge_max(s : SignalspeccovarianceEdge) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_edge_to_string(s : SignalspeccovarianceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovariancePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_path_make(size : Int) -> SignalspeccovariancePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_path_len(s : SignalspeccovariancePath) -> Int { s.size }

pub fn signal_spec_covariance_path_get(s : SignalspeccovariancePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_path_set(s : SignalspeccovariancePath, i : Int, v : Double) -> SignalspeccovariancePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_path_sum(s : SignalspeccovariancePath) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_path_mean(s : SignalspeccovariancePath) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_path_scale(s : SignalspeccovariancePath, f : Double) -> SignalspeccovariancePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_path_add(a : SignalspeccovariancePath, b : SignalspeccovariancePath) -> SignalspeccovariancePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_path_copy(s : SignalspeccovariancePath) -> SignalspeccovariancePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_path_fill(s : SignalspeccovariancePath, v : Double) -> SignalspeccovariancePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_path_min(s : SignalspeccovariancePath) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_path_max(s : SignalspeccovariancePath) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_path_to_string(s : SignalspeccovariancePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovarianceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_cluster_make(size : Int) -> SignalspeccovarianceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_cluster_len(s : SignalspeccovarianceCluster) -> Int { s.size }

pub fn signal_spec_covariance_cluster_get(s : SignalspeccovarianceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_cluster_set(s : SignalspeccovarianceCluster, i : Int, v : Double) -> SignalspeccovarianceCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_cluster_sum(s : SignalspeccovarianceCluster) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_cluster_mean(s : SignalspeccovarianceCluster) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_cluster_scale(s : SignalspeccovarianceCluster, f : Double) -> SignalspeccovarianceCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_cluster_add(a : SignalspeccovarianceCluster, b : SignalspeccovarianceCluster) -> SignalspeccovarianceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_cluster_copy(s : SignalspeccovarianceCluster) -> SignalspeccovarianceCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_cluster_fill(s : SignalspeccovarianceCluster, v : Double) -> SignalspeccovarianceCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_cluster_min(s : SignalspeccovarianceCluster) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_cluster_max(s : SignalspeccovarianceCluster) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_cluster_to_string(s : SignalspeccovarianceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovarianceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_model_make(size : Int) -> SignalspeccovarianceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_model_len(s : SignalspeccovarianceModel) -> Int { s.size }

pub fn signal_spec_covariance_model_get(s : SignalspeccovarianceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_model_set(s : SignalspeccovarianceModel, i : Int, v : Double) -> SignalspeccovarianceModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_model_sum(s : SignalspeccovarianceModel) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_model_mean(s : SignalspeccovarianceModel) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_model_scale(s : SignalspeccovarianceModel, f : Double) -> SignalspeccovarianceModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_model_add(a : SignalspeccovarianceModel, b : SignalspeccovarianceModel) -> SignalspeccovarianceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_model_copy(s : SignalspeccovarianceModel) -> SignalspeccovarianceModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_model_fill(s : SignalspeccovarianceModel, v : Double) -> SignalspeccovarianceModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_model_min(s : SignalspeccovarianceModel) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_model_max(s : SignalspeccovarianceModel) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_model_to_string(s : SignalspeccovarianceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovarianceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_layer_make(size : Int) -> SignalspeccovarianceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_layer_len(s : SignalspeccovarianceLayer) -> Int { s.size }

pub fn signal_spec_covariance_layer_get(s : SignalspeccovarianceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_layer_set(s : SignalspeccovarianceLayer, i : Int, v : Double) -> SignalspeccovarianceLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_layer_sum(s : SignalspeccovarianceLayer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_layer_mean(s : SignalspeccovarianceLayer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_layer_scale(s : SignalspeccovarianceLayer, f : Double) -> SignalspeccovarianceLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_layer_add(a : SignalspeccovarianceLayer, b : SignalspeccovarianceLayer) -> SignalspeccovarianceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_layer_copy(s : SignalspeccovarianceLayer) -> SignalspeccovarianceLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_layer_fill(s : SignalspeccovarianceLayer, v : Double) -> SignalspeccovarianceLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_layer_min(s : SignalspeccovarianceLayer) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_layer_max(s : SignalspeccovarianceLayer) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_layer_to_string(s : SignalspeccovarianceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovarianceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_buffer_make(size : Int) -> SignalspeccovarianceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_buffer_len(s : SignalspeccovarianceBuffer) -> Int { s.size }

pub fn signal_spec_covariance_buffer_get(s : SignalspeccovarianceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_buffer_set(s : SignalspeccovarianceBuffer, i : Int, v : Double) -> SignalspeccovarianceBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_buffer_sum(s : SignalspeccovarianceBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_buffer_mean(s : SignalspeccovarianceBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_buffer_scale(s : SignalspeccovarianceBuffer, f : Double) -> SignalspeccovarianceBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_buffer_add(a : SignalspeccovarianceBuffer, b : SignalspeccovarianceBuffer) -> SignalspeccovarianceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_buffer_copy(s : SignalspeccovarianceBuffer) -> SignalspeccovarianceBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_buffer_fill(s : SignalspeccovarianceBuffer, v : Double) -> SignalspeccovarianceBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_buffer_min(s : SignalspeccovarianceBuffer) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_buffer_max(s : SignalspeccovarianceBuffer) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_buffer_to_string(s : SignalspeccovarianceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovarianceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_cursor_make(size : Int) -> SignalspeccovarianceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_cursor_len(s : SignalspeccovarianceCursor) -> Int { s.size }

pub fn signal_spec_covariance_cursor_get(s : SignalspeccovarianceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_cursor_set(s : SignalspeccovarianceCursor, i : Int, v : Double) -> SignalspeccovarianceCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_cursor_sum(s : SignalspeccovarianceCursor) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_cursor_mean(s : SignalspeccovarianceCursor) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_cursor_scale(s : SignalspeccovarianceCursor, f : Double) -> SignalspeccovarianceCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_cursor_add(a : SignalspeccovarianceCursor, b : SignalspeccovarianceCursor) -> SignalspeccovarianceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_cursor_copy(s : SignalspeccovarianceCursor) -> SignalspeccovarianceCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_cursor_fill(s : SignalspeccovarianceCursor, v : Double) -> SignalspeccovarianceCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_cursor_min(s : SignalspeccovarianceCursor) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_cursor_max(s : SignalspeccovarianceCursor) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_cursor_to_string(s : SignalspeccovarianceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovarianceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_view_make(size : Int) -> SignalspeccovarianceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_view_len(s : SignalspeccovarianceView) -> Int { s.size }

pub fn signal_spec_covariance_view_get(s : SignalspeccovarianceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_view_set(s : SignalspeccovarianceView, i : Int, v : Double) -> SignalspeccovarianceView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_view_sum(s : SignalspeccovarianceView) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_view_mean(s : SignalspeccovarianceView) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_view_scale(s : SignalspeccovarianceView, f : Double) -> SignalspeccovarianceView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_view_add(a : SignalspeccovarianceView, b : SignalspeccovarianceView) -> SignalspeccovarianceView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_view_copy(s : SignalspeccovarianceView) -> SignalspeccovarianceView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_view_fill(s : SignalspeccovarianceView, v : Double) -> SignalspeccovarianceView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_view_min(s : SignalspeccovarianceView) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_view_max(s : SignalspeccovarianceView) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_view_to_string(s : SignalspeccovarianceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovarianceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_range_make(size : Int) -> SignalspeccovarianceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_range_len(s : SignalspeccovarianceRange) -> Int { s.size }

pub fn signal_spec_covariance_range_get(s : SignalspeccovarianceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_range_set(s : SignalspeccovarianceRange, i : Int, v : Double) -> SignalspeccovarianceRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_range_sum(s : SignalspeccovarianceRange) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_range_mean(s : SignalspeccovarianceRange) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_range_scale(s : SignalspeccovarianceRange, f : Double) -> SignalspeccovarianceRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_range_add(a : SignalspeccovarianceRange, b : SignalspeccovarianceRange) -> SignalspeccovarianceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_range_copy(s : SignalspeccovarianceRange) -> SignalspeccovarianceRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_range_fill(s : SignalspeccovarianceRange, v : Double) -> SignalspeccovarianceRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_range_min(s : SignalspeccovarianceRange) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_range_max(s : SignalspeccovarianceRange) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_range_to_string(s : SignalspeccovarianceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovarianceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_slice_make(size : Int) -> SignalspeccovarianceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_slice_len(s : SignalspeccovarianceSlice) -> Int { s.size }

pub fn signal_spec_covariance_slice_get(s : SignalspeccovarianceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_slice_set(s : SignalspeccovarianceSlice, i : Int, v : Double) -> SignalspeccovarianceSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_slice_sum(s : SignalspeccovarianceSlice) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_slice_mean(s : SignalspeccovarianceSlice) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_slice_scale(s : SignalspeccovarianceSlice, f : Double) -> SignalspeccovarianceSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_slice_add(a : SignalspeccovarianceSlice, b : SignalspeccovarianceSlice) -> SignalspeccovarianceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_slice_copy(s : SignalspeccovarianceSlice) -> SignalspeccovarianceSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_slice_fill(s : SignalspeccovarianceSlice, v : Double) -> SignalspeccovarianceSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_slice_min(s : SignalspeccovarianceSlice) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_slice_max(s : SignalspeccovarianceSlice) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_slice_to_string(s : SignalspeccovarianceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

