///===
/// extcore/signal_filter_iir

pub(all) struct SignalfilteriirPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_iir_make_point(x : Double, y : Double) -> SignalfilteriirPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_iir_make_point3(x : Double, y : Double, z : Double) -> SignalfilteriirPoint {
  { x, y, z, label: 0 }
}

pub fn signal_filter_iir_point_x(pt : SignalfilteriirPoint) -> Double { pt.x }

pub fn signal_filter_iir_point_y(pt : SignalfilteriirPoint) -> Double { pt.y }

pub fn signal_filter_iir_point_z(pt : SignalfilteriirPoint) -> Double { pt.z }

pub fn signal_filter_iir_point_label(pt : SignalfilteriirPoint) -> Int { pt.label }

pub fn signal_filter_iir_point_dist(a : SignalfilteriirPoint, b : SignalfilteriirPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_filter_iir_point_add(a : SignalfilteriirPoint, b : SignalfilteriirPoint) -> SignalfilteriirPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_filter_iir_point_sub(a : SignalfilteriirPoint, b : SignalfilteriirPoint) -> SignalfilteriirPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_filter_iir_point_scale(pt : SignalfilteriirPoint, s : Double) -> SignalfilteriirPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_filter_iir_point_dot(a : SignalfilteriirPoint, b : SignalfilteriirPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_filter_iir_point_cross(a : SignalfilteriirPoint, b : SignalfilteriirPoint) -> SignalfilteriirPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_filter_iir_point_norm(pt : SignalfilteriirPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_filter_iir_point_normalize(pt : SignalfilteriirPoint) -> SignalfilteriirPoint {
  let n = signal_filter_iir_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_filter_iir_point_scale(pt, 1.0 / n) }
}

pub fn signal_filter_iir_point_negate(pt : SignalfilteriirPoint) -> SignalfilteriirPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_filter_iir_point_mid(a : SignalfilteriirPoint, b : SignalfilteriirPoint) -> SignalfilteriirPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_filter_iir_point_lerp(a : SignalfilteriirPoint, b : SignalfilteriirPoint, t : Double) -> SignalfilteriirPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_filter_iir_point_to_string(pt : SignalfilteriirPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalfilteriirSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_iir_make_series(vals : Array[Double], name : String) -> SignalfilteriirSeries {
  { vals, name, meta: 0 }
}

pub fn signal_filter_iir_series_len(s : SignalfilteriirSeries) -> Int { s.vals.length() }

pub fn signal_filter_iir_series_sum(s : SignalfilteriirSeries) -> Double { @_common.sum(s.vals) }

pub fn signal_filter_iir_series_mean(s : SignalfilteriirSeries) -> Double { @_common.mean(s.vals) }

pub fn signal_filter_iir_series_min(s : SignalfilteriirSeries) -> Double { @_common.min(s.vals) }

pub fn signal_filter_iir_series_max(s : SignalfilteriirSeries) -> Double { @_common.max(s.vals) }

pub fn signal_filter_iir_series_range(s : SignalfilteriirSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn signal_filter_iir_series_var(s : SignalfilteriirSeries) -> Double { @_common.variance(s.vals) }

pub fn signal_filter_iir_series_std(s : SignalfilteriirSeries) -> Double { @_common.std(s.vals) }

pub fn signal_filter_iir_series_median(s : SignalfilteriirSeries) -> Double { @_common.median(s.vals) }

pub fn signal_filter_iir_series_scale(s : SignalfilteriirSeries, f : Double) -> SignalfilteriirSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_filter_iir_series_add(a : SignalfilteriirSeries, b : SignalfilteriirSeries) -> SignalfilteriirSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_filter_iir_series_sub(a : SignalfilteriirSeries, b : SignalfilteriirSeries) -> SignalfilteriirSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_filter_iir_series_normalize(s : SignalfilteriirSeries) -> SignalfilteriirSeries {
  let mn = signal_filter_iir_series_min(s)
  let mx = signal_filter_iir_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_filter_iir_series_cumsum(s : SignalfilteriirSeries) -> SignalfilteriirSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_filter_iir_series_to_string(s : SignalfilteriirSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilteriirMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_iir_make_matrix(rows : Int, cols : Int, val : Double) -> SignalfilteriirMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_iir_matrix_identity(n : Int) -> SignalfilteriirMatrix {
  let m = signal_filter_iir_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_filter_iir_matrix_get(m : SignalfilteriirMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_filter_iir_matrix_transpose(m : SignalfilteriirMatrix) -> SignalfilteriirMatrix {
  let result = signal_filter_iir_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_filter_iir_matrix_add(a : SignalfilteriirMatrix, b : SignalfilteriirMatrix) -> SignalfilteriirMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_filter_iir_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_filter_iir_matrix_scale(m : SignalfilteriirMatrix, s : Double) -> SignalfilteriirMatrix {
  let result = signal_filter_iir_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_filter_iir_matrix_multiply(a : SignalfilteriirMatrix, b : SignalfilteriirMatrix) -> SignalfilteriirMatrix {
  if a.cols != b.rows { return signal_filter_iir_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_filter_iir_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_filter_iir_matrix_trace(m : SignalfilteriirMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_filter_iir_matrix_det(m : SignalfilteriirMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_filter_iir_matrix_norm(m : SignalfilteriirMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_filter_iir_matrix_to_string(m : SignalfilteriirMatrix) -> String {
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

pub(all) struct SignalfilteriirVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_iir_make_vector(comps : Array[Double]) -> SignalfilteriirVector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_iir_vector_zero(dim : Int) -> SignalfilteriirVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_filter_iir_vector_add(a : SignalfilteriirVector, b : SignalfilteriirVector) -> SignalfilteriirVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_filter_iir_vector_sub(a : SignalfilteriirVector, b : SignalfilteriirVector) -> SignalfilteriirVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_filter_iir_vector_scale(v : SignalfilteriirVector, s : Double) -> SignalfilteriirVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_filter_iir_vector_dot(a : SignalfilteriirVector, b : SignalfilteriirVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_filter_iir_vector_norm(v : SignalfilteriirVector) -> Double { @_common.sqrt(signal_filter_iir_vector_dot(v, v)) }

pub fn signal_filter_iir_vector_normalize(v : SignalfilteriirVector) -> SignalfilteriirVector {
  let n = signal_filter_iir_vector_norm(v)
  if n < 0.0000001 { v } else { signal_filter_iir_vector_scale(v, 1.0 / n) }
}

pub fn signal_filter_iir_vector_dist(a : SignalfilteriirVector, b : SignalfilteriirVector) -> Double {
  signal_filter_iir_vector_norm(signal_filter_iir_vector_sub(a, b))
}

pub fn signal_filter_iir_vector_to_string(v : SignalfilteriirVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_filter_iir_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_filter_iir_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_filter_iir_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_filter_iir_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_filter_iir_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_filter_iir_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_filter_iir_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_filter_iir_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_filter_iir_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_filter_iir_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_filter_iir_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_filter_iir_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_filter_iir_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_filter_iir_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_filter_iir_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_filter_iir_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_filter_iir_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_filter_iir_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_filter_iir_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_filter_iir_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_filter_iir_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_filter_iir_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_filter_iir_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_filter_iir_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_filter_iir_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_filter_iir_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_filter_iir_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_filter_iir_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_filter_iir_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalfilteriirFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_frame_make(size : Int) -> SignalfilteriirFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_frame_len(s : SignalfilteriirFrame) -> Int { s.size }

pub fn signal_filter_iir_frame_get(s : SignalfilteriirFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_frame_set(s : SignalfilteriirFrame, i : Int, v : Double) -> SignalfilteriirFrame {
  let result = signal_filter_iir_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_frame_sum(s : SignalfilteriirFrame) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_frame_mean(s : SignalfilteriirFrame) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_frame_scale(s : SignalfilteriirFrame, f : Double) -> SignalfilteriirFrame {
  let result = signal_filter_iir_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_iir_frame_add(a : SignalfilteriirFrame, b : SignalfilteriirFrame) -> SignalfilteriirFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_iir_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_iir_frame_copy(s : SignalfilteriirFrame) -> SignalfilteriirFrame {
  let result = signal_filter_iir_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_iir_frame_fill(s : SignalfilteriirFrame, v : Double) -> SignalfilteriirFrame {
  let result = signal_filter_iir_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_frame_min(s : SignalfilteriirFrame) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_frame_max(s : SignalfilteriirFrame) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_frame_to_string(s : SignalfilteriirFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_table_make(size : Int) -> SignalfilteriirTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_table_len(s : SignalfilteriirTable) -> Int { s.size }

pub fn signal_filter_iir_table_get(s : SignalfilteriirTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_table_set(s : SignalfilteriirTable, i : Int, v : Double) -> SignalfilteriirTable {
  let result = signal_filter_iir_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_table_sum(s : SignalfilteriirTable) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_table_mean(s : SignalfilteriirTable) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_table_scale(s : SignalfilteriirTable, f : Double) -> SignalfilteriirTable {
  let result = signal_filter_iir_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_iir_table_add(a : SignalfilteriirTable, b : SignalfilteriirTable) -> SignalfilteriirTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_iir_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_iir_table_copy(s : SignalfilteriirTable) -> SignalfilteriirTable {
  let result = signal_filter_iir_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_iir_table_fill(s : SignalfilteriirTable, v : Double) -> SignalfilteriirTable {
  let result = signal_filter_iir_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_table_min(s : SignalfilteriirTable) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_table_max(s : SignalfilteriirTable) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_table_to_string(s : SignalfilteriirTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_graphn_make(size : Int) -> SignalfilteriirGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_graphn_len(s : SignalfilteriirGraphN) -> Int { s.size }

pub fn signal_filter_iir_graphn_get(s : SignalfilteriirGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_graphn_set(s : SignalfilteriirGraphN, i : Int, v : Double) -> SignalfilteriirGraphN {
  let result = signal_filter_iir_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_graphn_sum(s : SignalfilteriirGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_graphn_mean(s : SignalfilteriirGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_graphn_scale(s : SignalfilteriirGraphN, f : Double) -> SignalfilteriirGraphN {
  let result = signal_filter_iir_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_iir_graphn_add(a : SignalfilteriirGraphN, b : SignalfilteriirGraphN) -> SignalfilteriirGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_iir_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_iir_graphn_copy(s : SignalfilteriirGraphN) -> SignalfilteriirGraphN {
  let result = signal_filter_iir_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_iir_graphn_fill(s : SignalfilteriirGraphN, v : Double) -> SignalfilteriirGraphN {
  let result = signal_filter_iir_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_graphn_min(s : SignalfilteriirGraphN) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_graphn_max(s : SignalfilteriirGraphN) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_graphn_to_string(s : SignalfilteriirGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_node_make(size : Int) -> SignalfilteriirNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_node_len(s : SignalfilteriirNode) -> Int { s.size }

pub fn signal_filter_iir_node_get(s : SignalfilteriirNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_node_set(s : SignalfilteriirNode, i : Int, v : Double) -> SignalfilteriirNode {
  let result = signal_filter_iir_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_node_sum(s : SignalfilteriirNode) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_node_mean(s : SignalfilteriirNode) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_node_scale(s : SignalfilteriirNode, f : Double) -> SignalfilteriirNode {
  let result = signal_filter_iir_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_iir_node_add(a : SignalfilteriirNode, b : SignalfilteriirNode) -> SignalfilteriirNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_iir_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_iir_node_copy(s : SignalfilteriirNode) -> SignalfilteriirNode {
  let result = signal_filter_iir_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_iir_node_fill(s : SignalfilteriirNode, v : Double) -> SignalfilteriirNode {
  let result = signal_filter_iir_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_node_min(s : SignalfilteriirNode) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_node_max(s : SignalfilteriirNode) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_node_to_string(s : SignalfilteriirNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_edge_make(size : Int) -> SignalfilteriirEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_edge_len(s : SignalfilteriirEdge) -> Int { s.size }

pub fn signal_filter_iir_edge_get(s : SignalfilteriirEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_edge_set(s : SignalfilteriirEdge, i : Int, v : Double) -> SignalfilteriirEdge {
  let result = signal_filter_iir_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_edge_sum(s : SignalfilteriirEdge) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_edge_mean(s : SignalfilteriirEdge) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_edge_scale(s : SignalfilteriirEdge, f : Double) -> SignalfilteriirEdge {
  let result = signal_filter_iir_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_iir_edge_add(a : SignalfilteriirEdge, b : SignalfilteriirEdge) -> SignalfilteriirEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_iir_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_iir_edge_copy(s : SignalfilteriirEdge) -> SignalfilteriirEdge {
  let result = signal_filter_iir_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_iir_edge_fill(s : SignalfilteriirEdge, v : Double) -> SignalfilteriirEdge {
  let result = signal_filter_iir_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_edge_min(s : SignalfilteriirEdge) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_edge_max(s : SignalfilteriirEdge) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_edge_to_string(s : SignalfilteriirEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_path_make(size : Int) -> SignalfilteriirPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_path_len(s : SignalfilteriirPath) -> Int { s.size }

pub fn signal_filter_iir_path_get(s : SignalfilteriirPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_path_set(s : SignalfilteriirPath, i : Int, v : Double) -> SignalfilteriirPath {
  let result = signal_filter_iir_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_path_sum(s : SignalfilteriirPath) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_path_mean(s : SignalfilteriirPath) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_path_scale(s : SignalfilteriirPath, f : Double) -> SignalfilteriirPath {
  let result = signal_filter_iir_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_iir_path_add(a : SignalfilteriirPath, b : SignalfilteriirPath) -> SignalfilteriirPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_iir_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_iir_path_copy(s : SignalfilteriirPath) -> SignalfilteriirPath {
  let result = signal_filter_iir_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_iir_path_fill(s : SignalfilteriirPath, v : Double) -> SignalfilteriirPath {
  let result = signal_filter_iir_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_path_min(s : SignalfilteriirPath) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_path_max(s : SignalfilteriirPath) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_path_to_string(s : SignalfilteriirPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_cluster_make(size : Int) -> SignalfilteriirCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_cluster_len(s : SignalfilteriirCluster) -> Int { s.size }

pub fn signal_filter_iir_cluster_get(s : SignalfilteriirCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_cluster_set(s : SignalfilteriirCluster, i : Int, v : Double) -> SignalfilteriirCluster {
  let result = signal_filter_iir_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_cluster_sum(s : SignalfilteriirCluster) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_cluster_mean(s : SignalfilteriirCluster) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_cluster_scale(s : SignalfilteriirCluster, f : Double) -> SignalfilteriirCluster {
  let result = signal_filter_iir_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_iir_cluster_add(a : SignalfilteriirCluster, b : SignalfilteriirCluster) -> SignalfilteriirCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_iir_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_iir_cluster_copy(s : SignalfilteriirCluster) -> SignalfilteriirCluster {
  let result = signal_filter_iir_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_iir_cluster_fill(s : SignalfilteriirCluster, v : Double) -> SignalfilteriirCluster {
  let result = signal_filter_iir_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_cluster_min(s : SignalfilteriirCluster) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_cluster_max(s : SignalfilteriirCluster) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_cluster_to_string(s : SignalfilteriirCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_model_make(size : Int) -> SignalfilteriirModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_model_len(s : SignalfilteriirModel) -> Int { s.size }

pub fn signal_filter_iir_model_get(s : SignalfilteriirModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_model_set(s : SignalfilteriirModel, i : Int, v : Double) -> SignalfilteriirModel {
  let result = signal_filter_iir_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_model_sum(s : SignalfilteriirModel) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_model_mean(s : SignalfilteriirModel) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_model_scale(s : SignalfilteriirModel, f : Double) -> SignalfilteriirModel {
  let result = signal_filter_iir_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_iir_model_add(a : SignalfilteriirModel, b : SignalfilteriirModel) -> SignalfilteriirModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_iir_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_iir_model_copy(s : SignalfilteriirModel) -> SignalfilteriirModel {
  let result = signal_filter_iir_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_iir_model_fill(s : SignalfilteriirModel, v : Double) -> SignalfilteriirModel {
  let result = signal_filter_iir_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_model_min(s : SignalfilteriirModel) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_model_max(s : SignalfilteriirModel) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_model_to_string(s : SignalfilteriirModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_layer_make(size : Int) -> SignalfilteriirLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_layer_len(s : SignalfilteriirLayer) -> Int { s.size }

pub fn signal_filter_iir_layer_get(s : SignalfilteriirLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_layer_set(s : SignalfilteriirLayer, i : Int, v : Double) -> SignalfilteriirLayer {
  let result = signal_filter_iir_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_layer_sum(s : SignalfilteriirLayer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_layer_mean(s : SignalfilteriirLayer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_layer_scale(s : SignalfilteriirLayer, f : Double) -> SignalfilteriirLayer {
  let result = signal_filter_iir_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_iir_layer_add(a : SignalfilteriirLayer, b : SignalfilteriirLayer) -> SignalfilteriirLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_iir_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_iir_layer_copy(s : SignalfilteriirLayer) -> SignalfilteriirLayer {
  let result = signal_filter_iir_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_iir_layer_fill(s : SignalfilteriirLayer, v : Double) -> SignalfilteriirLayer {
  let result = signal_filter_iir_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_layer_min(s : SignalfilteriirLayer) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_layer_max(s : SignalfilteriirLayer) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_layer_to_string(s : SignalfilteriirLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_buffer_make(size : Int) -> SignalfilteriirBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_buffer_len(s : SignalfilteriirBuffer) -> Int { s.size }

pub fn signal_filter_iir_buffer_get(s : SignalfilteriirBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_buffer_set(s : SignalfilteriirBuffer, i : Int, v : Double) -> SignalfilteriirBuffer {
  let result = signal_filter_iir_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_buffer_sum(s : SignalfilteriirBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_buffer_mean(s : SignalfilteriirBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_buffer_scale(s : SignalfilteriirBuffer, f : Double) -> SignalfilteriirBuffer {
  let result = signal_filter_iir_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_iir_buffer_add(a : SignalfilteriirBuffer, b : SignalfilteriirBuffer) -> SignalfilteriirBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_iir_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_iir_buffer_copy(s : SignalfilteriirBuffer) -> SignalfilteriirBuffer {
  let result = signal_filter_iir_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_iir_buffer_fill(s : SignalfilteriirBuffer, v : Double) -> SignalfilteriirBuffer {
  let result = signal_filter_iir_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_buffer_min(s : SignalfilteriirBuffer) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_buffer_max(s : SignalfilteriirBuffer) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_buffer_to_string(s : SignalfilteriirBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_cursor_make(size : Int) -> SignalfilteriirCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_cursor_len(s : SignalfilteriirCursor) -> Int { s.size }

pub fn signal_filter_iir_cursor_get(s : SignalfilteriirCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_cursor_set(s : SignalfilteriirCursor, i : Int, v : Double) -> SignalfilteriirCursor {
  let result = signal_filter_iir_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_cursor_sum(s : SignalfilteriirCursor) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_cursor_mean(s : SignalfilteriirCursor) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_cursor_scale(s : SignalfilteriirCursor, f : Double) -> SignalfilteriirCursor {
  let result = signal_filter_iir_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_iir_cursor_add(a : SignalfilteriirCursor, b : SignalfilteriirCursor) -> SignalfilteriirCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_iir_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_iir_cursor_copy(s : SignalfilteriirCursor) -> SignalfilteriirCursor {
  let result = signal_filter_iir_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_iir_cursor_fill(s : SignalfilteriirCursor, v : Double) -> SignalfilteriirCursor {
  let result = signal_filter_iir_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_cursor_min(s : SignalfilteriirCursor) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_cursor_max(s : SignalfilteriirCursor) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_cursor_to_string(s : SignalfilteriirCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_view_make(size : Int) -> SignalfilteriirView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_view_len(s : SignalfilteriirView) -> Int { s.size }

pub fn signal_filter_iir_view_get(s : SignalfilteriirView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_view_set(s : SignalfilteriirView, i : Int, v : Double) -> SignalfilteriirView {
  let result = signal_filter_iir_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_view_sum(s : SignalfilteriirView) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_view_mean(s : SignalfilteriirView) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_view_scale(s : SignalfilteriirView, f : Double) -> SignalfilteriirView {
  let result = signal_filter_iir_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_iir_view_add(a : SignalfilteriirView, b : SignalfilteriirView) -> SignalfilteriirView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_iir_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_iir_view_copy(s : SignalfilteriirView) -> SignalfilteriirView {
  let result = signal_filter_iir_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_iir_view_fill(s : SignalfilteriirView, v : Double) -> SignalfilteriirView {
  let result = signal_filter_iir_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_view_min(s : SignalfilteriirView) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_view_max(s : SignalfilteriirView) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_view_to_string(s : SignalfilteriirView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_range_make(size : Int) -> SignalfilteriirRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_range_len(s : SignalfilteriirRange) -> Int { s.size }

pub fn signal_filter_iir_range_get(s : SignalfilteriirRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_range_set(s : SignalfilteriirRange, i : Int, v : Double) -> SignalfilteriirRange {
  let result = signal_filter_iir_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_range_sum(s : SignalfilteriirRange) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_range_mean(s : SignalfilteriirRange) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_range_scale(s : SignalfilteriirRange, f : Double) -> SignalfilteriirRange {
  let result = signal_filter_iir_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_iir_range_add(a : SignalfilteriirRange, b : SignalfilteriirRange) -> SignalfilteriirRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_iir_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_iir_range_copy(s : SignalfilteriirRange) -> SignalfilteriirRange {
  let result = signal_filter_iir_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_iir_range_fill(s : SignalfilteriirRange, v : Double) -> SignalfilteriirRange {
  let result = signal_filter_iir_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_range_min(s : SignalfilteriirRange) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_range_max(s : SignalfilteriirRange) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_range_to_string(s : SignalfilteriirRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_slice_make(size : Int) -> SignalfilteriirSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_slice_len(s : SignalfilteriirSlice) -> Int { s.size }

pub fn signal_filter_iir_slice_get(s : SignalfilteriirSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_slice_set(s : SignalfilteriirSlice, i : Int, v : Double) -> SignalfilteriirSlice {
  let result = signal_filter_iir_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_slice_sum(s : SignalfilteriirSlice) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_slice_mean(s : SignalfilteriirSlice) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_slice_scale(s : SignalfilteriirSlice, f : Double) -> SignalfilteriirSlice {
  let result = signal_filter_iir_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_iir_slice_add(a : SignalfilteriirSlice, b : SignalfilteriirSlice) -> SignalfilteriirSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_iir_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_iir_slice_copy(s : SignalfilteriirSlice) -> SignalfilteriirSlice {
  let result = signal_filter_iir_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_iir_slice_fill(s : SignalfilteriirSlice, v : Double) -> SignalfilteriirSlice {
  let result = signal_filter_iir_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_iir_slice_min(s : SignalfilteriirSlice) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_slice_max(s : SignalfilteriirSlice) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_slice_to_string(s : SignalfilteriirSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

