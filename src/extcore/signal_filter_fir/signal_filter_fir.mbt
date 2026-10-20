///===
/// extcore/signal_filter_fir

pub(all) struct SignalfilterfirPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_fir_make_point(x : Double, y : Double) -> SignalfilterfirPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_fir_make_point3(x : Double, y : Double, z : Double) -> SignalfilterfirPoint {
  { x, y, z, label: 0 }
}

pub fn signal_filter_fir_point_x(pt : SignalfilterfirPoint) -> Double { pt.x }

pub fn signal_filter_fir_point_y(pt : SignalfilterfirPoint) -> Double { pt.y }

pub fn signal_filter_fir_point_z(pt : SignalfilterfirPoint) -> Double { pt.z }

pub fn signal_filter_fir_point_label(pt : SignalfilterfirPoint) -> Int { pt.label }

pub fn signal_filter_fir_point_dist(a : SignalfilterfirPoint, b : SignalfilterfirPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_filter_fir_point_add(a : SignalfilterfirPoint, b : SignalfilterfirPoint) -> SignalfilterfirPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_filter_fir_point_sub(a : SignalfilterfirPoint, b : SignalfilterfirPoint) -> SignalfilterfirPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_filter_fir_point_scale(pt : SignalfilterfirPoint, s : Double) -> SignalfilterfirPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_filter_fir_point_dot(a : SignalfilterfirPoint, b : SignalfilterfirPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_filter_fir_point_cross(a : SignalfilterfirPoint, b : SignalfilterfirPoint) -> SignalfilterfirPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_filter_fir_point_norm(pt : SignalfilterfirPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_filter_fir_point_normalize(pt : SignalfilterfirPoint) -> SignalfilterfirPoint {
  let n = signal_filter_fir_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_filter_fir_point_scale(pt, 1.0 / n) }
}

pub fn signal_filter_fir_point_negate(pt : SignalfilterfirPoint) -> SignalfilterfirPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_filter_fir_point_mid(a : SignalfilterfirPoint, b : SignalfilterfirPoint) -> SignalfilterfirPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_filter_fir_point_lerp(a : SignalfilterfirPoint, b : SignalfilterfirPoint, t : Double) -> SignalfilterfirPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_filter_fir_point_to_string(pt : SignalfilterfirPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalfilterfirSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_fir_make_series(vals : Array[Double], name : String) -> SignalfilterfirSeries {
  { vals, name, meta: 0 }
}

pub fn signal_filter_fir_series_len(s : SignalfilterfirSeries) -> Int { s.vals.length() }

pub fn signal_filter_fir_series_sum(s : SignalfilterfirSeries) -> Double { @_common.sum(s.vals) }

pub fn signal_filter_fir_series_mean(s : SignalfilterfirSeries) -> Double { @_common.mean(s.vals) }

pub fn signal_filter_fir_series_min(s : SignalfilterfirSeries) -> Double { @_common.min(s.vals) }

pub fn signal_filter_fir_series_max(s : SignalfilterfirSeries) -> Double { @_common.max(s.vals) }

pub fn signal_filter_fir_series_range(s : SignalfilterfirSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn signal_filter_fir_series_var(s : SignalfilterfirSeries) -> Double { @_common.variance(s.vals) }

pub fn signal_filter_fir_series_std(s : SignalfilterfirSeries) -> Double { @_common.std(s.vals) }

pub fn signal_filter_fir_series_median(s : SignalfilterfirSeries) -> Double { @_common.median(s.vals) }

pub fn signal_filter_fir_series_scale(s : SignalfilterfirSeries, f : Double) -> SignalfilterfirSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_filter_fir_series_add(a : SignalfilterfirSeries, b : SignalfilterfirSeries) -> SignalfilterfirSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_filter_fir_series_sub(a : SignalfilterfirSeries, b : SignalfilterfirSeries) -> SignalfilterfirSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_filter_fir_series_normalize(s : SignalfilterfirSeries) -> SignalfilterfirSeries {
  let mn = signal_filter_fir_series_min(s)
  let mx = signal_filter_fir_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_filter_fir_series_cumsum(s : SignalfilterfirSeries) -> SignalfilterfirSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_filter_fir_series_to_string(s : SignalfilterfirSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilterfirMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_fir_make_matrix(rows : Int, cols : Int, val : Double) -> SignalfilterfirMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_fir_matrix_identity(n : Int) -> SignalfilterfirMatrix {
  let m = signal_filter_fir_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_filter_fir_matrix_get(m : SignalfilterfirMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_filter_fir_matrix_transpose(m : SignalfilterfirMatrix) -> SignalfilterfirMatrix {
  let result = signal_filter_fir_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_filter_fir_matrix_add(a : SignalfilterfirMatrix, b : SignalfilterfirMatrix) -> SignalfilterfirMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_filter_fir_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_filter_fir_matrix_scale(m : SignalfilterfirMatrix, s : Double) -> SignalfilterfirMatrix {
  let result = signal_filter_fir_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_filter_fir_matrix_multiply(a : SignalfilterfirMatrix, b : SignalfilterfirMatrix) -> SignalfilterfirMatrix {
  if a.cols != b.rows { return signal_filter_fir_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_filter_fir_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_filter_fir_matrix_trace(m : SignalfilterfirMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_filter_fir_matrix_det(m : SignalfilterfirMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_filter_fir_matrix_norm(m : SignalfilterfirMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_filter_fir_matrix_to_string(m : SignalfilterfirMatrix) -> String {
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

pub(all) struct SignalfilterfirVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_fir_make_vector(comps : Array[Double]) -> SignalfilterfirVector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_fir_vector_zero(dim : Int) -> SignalfilterfirVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_filter_fir_vector_add(a : SignalfilterfirVector, b : SignalfilterfirVector) -> SignalfilterfirVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_filter_fir_vector_sub(a : SignalfilterfirVector, b : SignalfilterfirVector) -> SignalfilterfirVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_filter_fir_vector_scale(v : SignalfilterfirVector, s : Double) -> SignalfilterfirVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_filter_fir_vector_dot(a : SignalfilterfirVector, b : SignalfilterfirVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_filter_fir_vector_norm(v : SignalfilterfirVector) -> Double { @_common.sqrt(signal_filter_fir_vector_dot(v, v)) }

pub fn signal_filter_fir_vector_normalize(v : SignalfilterfirVector) -> SignalfilterfirVector {
  let n = signal_filter_fir_vector_norm(v)
  if n < 0.0000001 { v } else { signal_filter_fir_vector_scale(v, 1.0 / n) }
}

pub fn signal_filter_fir_vector_dist(a : SignalfilterfirVector, b : SignalfilterfirVector) -> Double {
  signal_filter_fir_vector_norm(signal_filter_fir_vector_sub(a, b))
}

pub fn signal_filter_fir_vector_to_string(v : SignalfilterfirVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_filter_fir_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_filter_fir_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_filter_fir_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_filter_fir_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_filter_fir_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_filter_fir_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_filter_fir_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_filter_fir_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_filter_fir_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_filter_fir_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_filter_fir_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_filter_fir_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_filter_fir_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_filter_fir_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_filter_fir_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_filter_fir_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_filter_fir_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_filter_fir_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_filter_fir_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_filter_fir_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_filter_fir_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_filter_fir_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_filter_fir_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_filter_fir_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_filter_fir_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_filter_fir_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_filter_fir_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_filter_fir_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_filter_fir_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalfilterfirFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_frame_make(size : Int) -> SignalfilterfirFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_frame_len(s : SignalfilterfirFrame) -> Int { s.size }

pub fn signal_filter_fir_frame_get(s : SignalfilterfirFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_frame_set(s : SignalfilterfirFrame, i : Int, v : Double) -> SignalfilterfirFrame {
  let result = signal_filter_fir_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_frame_sum(s : SignalfilterfirFrame) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_frame_mean(s : SignalfilterfirFrame) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_frame_scale(s : SignalfilterfirFrame, f : Double) -> SignalfilterfirFrame {
  let result = signal_filter_fir_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_fir_frame_add(a : SignalfilterfirFrame, b : SignalfilterfirFrame) -> SignalfilterfirFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_fir_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_fir_frame_copy(s : SignalfilterfirFrame) -> SignalfilterfirFrame {
  let result = signal_filter_fir_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_fir_frame_fill(s : SignalfilterfirFrame, v : Double) -> SignalfilterfirFrame {
  let result = signal_filter_fir_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_frame_min(s : SignalfilterfirFrame) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_frame_max(s : SignalfilterfirFrame) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_frame_to_string(s : SignalfilterfirFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_table_make(size : Int) -> SignalfilterfirTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_table_len(s : SignalfilterfirTable) -> Int { s.size }

pub fn signal_filter_fir_table_get(s : SignalfilterfirTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_table_set(s : SignalfilterfirTable, i : Int, v : Double) -> SignalfilterfirTable {
  let result = signal_filter_fir_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_table_sum(s : SignalfilterfirTable) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_table_mean(s : SignalfilterfirTable) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_table_scale(s : SignalfilterfirTable, f : Double) -> SignalfilterfirTable {
  let result = signal_filter_fir_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_fir_table_add(a : SignalfilterfirTable, b : SignalfilterfirTable) -> SignalfilterfirTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_fir_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_fir_table_copy(s : SignalfilterfirTable) -> SignalfilterfirTable {
  let result = signal_filter_fir_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_fir_table_fill(s : SignalfilterfirTable, v : Double) -> SignalfilterfirTable {
  let result = signal_filter_fir_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_table_min(s : SignalfilterfirTable) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_table_max(s : SignalfilterfirTable) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_table_to_string(s : SignalfilterfirTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_graphn_make(size : Int) -> SignalfilterfirGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_graphn_len(s : SignalfilterfirGraphN) -> Int { s.size }

pub fn signal_filter_fir_graphn_get(s : SignalfilterfirGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_graphn_set(s : SignalfilterfirGraphN, i : Int, v : Double) -> SignalfilterfirGraphN {
  let result = signal_filter_fir_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_graphn_sum(s : SignalfilterfirGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_graphn_mean(s : SignalfilterfirGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_graphn_scale(s : SignalfilterfirGraphN, f : Double) -> SignalfilterfirGraphN {
  let result = signal_filter_fir_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_fir_graphn_add(a : SignalfilterfirGraphN, b : SignalfilterfirGraphN) -> SignalfilterfirGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_fir_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_fir_graphn_copy(s : SignalfilterfirGraphN) -> SignalfilterfirGraphN {
  let result = signal_filter_fir_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_fir_graphn_fill(s : SignalfilterfirGraphN, v : Double) -> SignalfilterfirGraphN {
  let result = signal_filter_fir_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_graphn_min(s : SignalfilterfirGraphN) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_graphn_max(s : SignalfilterfirGraphN) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_graphn_to_string(s : SignalfilterfirGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_node_make(size : Int) -> SignalfilterfirNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_node_len(s : SignalfilterfirNode) -> Int { s.size }

pub fn signal_filter_fir_node_get(s : SignalfilterfirNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_node_set(s : SignalfilterfirNode, i : Int, v : Double) -> SignalfilterfirNode {
  let result = signal_filter_fir_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_node_sum(s : SignalfilterfirNode) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_node_mean(s : SignalfilterfirNode) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_node_scale(s : SignalfilterfirNode, f : Double) -> SignalfilterfirNode {
  let result = signal_filter_fir_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_fir_node_add(a : SignalfilterfirNode, b : SignalfilterfirNode) -> SignalfilterfirNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_fir_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_fir_node_copy(s : SignalfilterfirNode) -> SignalfilterfirNode {
  let result = signal_filter_fir_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_fir_node_fill(s : SignalfilterfirNode, v : Double) -> SignalfilterfirNode {
  let result = signal_filter_fir_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_node_min(s : SignalfilterfirNode) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_node_max(s : SignalfilterfirNode) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_node_to_string(s : SignalfilterfirNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_edge_make(size : Int) -> SignalfilterfirEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_edge_len(s : SignalfilterfirEdge) -> Int { s.size }

pub fn signal_filter_fir_edge_get(s : SignalfilterfirEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_edge_set(s : SignalfilterfirEdge, i : Int, v : Double) -> SignalfilterfirEdge {
  let result = signal_filter_fir_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_edge_sum(s : SignalfilterfirEdge) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_edge_mean(s : SignalfilterfirEdge) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_edge_scale(s : SignalfilterfirEdge, f : Double) -> SignalfilterfirEdge {
  let result = signal_filter_fir_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_fir_edge_add(a : SignalfilterfirEdge, b : SignalfilterfirEdge) -> SignalfilterfirEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_fir_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_fir_edge_copy(s : SignalfilterfirEdge) -> SignalfilterfirEdge {
  let result = signal_filter_fir_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_fir_edge_fill(s : SignalfilterfirEdge, v : Double) -> SignalfilterfirEdge {
  let result = signal_filter_fir_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_edge_min(s : SignalfilterfirEdge) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_edge_max(s : SignalfilterfirEdge) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_edge_to_string(s : SignalfilterfirEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_path_make(size : Int) -> SignalfilterfirPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_path_len(s : SignalfilterfirPath) -> Int { s.size }

pub fn signal_filter_fir_path_get(s : SignalfilterfirPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_path_set(s : SignalfilterfirPath, i : Int, v : Double) -> SignalfilterfirPath {
  let result = signal_filter_fir_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_path_sum(s : SignalfilterfirPath) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_path_mean(s : SignalfilterfirPath) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_path_scale(s : SignalfilterfirPath, f : Double) -> SignalfilterfirPath {
  let result = signal_filter_fir_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_fir_path_add(a : SignalfilterfirPath, b : SignalfilterfirPath) -> SignalfilterfirPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_fir_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_fir_path_copy(s : SignalfilterfirPath) -> SignalfilterfirPath {
  let result = signal_filter_fir_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_fir_path_fill(s : SignalfilterfirPath, v : Double) -> SignalfilterfirPath {
  let result = signal_filter_fir_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_path_min(s : SignalfilterfirPath) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_path_max(s : SignalfilterfirPath) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_path_to_string(s : SignalfilterfirPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_cluster_make(size : Int) -> SignalfilterfirCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_cluster_len(s : SignalfilterfirCluster) -> Int { s.size }

pub fn signal_filter_fir_cluster_get(s : SignalfilterfirCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_cluster_set(s : SignalfilterfirCluster, i : Int, v : Double) -> SignalfilterfirCluster {
  let result = signal_filter_fir_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_cluster_sum(s : SignalfilterfirCluster) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_cluster_mean(s : SignalfilterfirCluster) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_cluster_scale(s : SignalfilterfirCluster, f : Double) -> SignalfilterfirCluster {
  let result = signal_filter_fir_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_fir_cluster_add(a : SignalfilterfirCluster, b : SignalfilterfirCluster) -> SignalfilterfirCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_fir_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_fir_cluster_copy(s : SignalfilterfirCluster) -> SignalfilterfirCluster {
  let result = signal_filter_fir_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_fir_cluster_fill(s : SignalfilterfirCluster, v : Double) -> SignalfilterfirCluster {
  let result = signal_filter_fir_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_cluster_min(s : SignalfilterfirCluster) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_cluster_max(s : SignalfilterfirCluster) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_cluster_to_string(s : SignalfilterfirCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_model_make(size : Int) -> SignalfilterfirModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_model_len(s : SignalfilterfirModel) -> Int { s.size }

pub fn signal_filter_fir_model_get(s : SignalfilterfirModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_model_set(s : SignalfilterfirModel, i : Int, v : Double) -> SignalfilterfirModel {
  let result = signal_filter_fir_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_model_sum(s : SignalfilterfirModel) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_model_mean(s : SignalfilterfirModel) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_model_scale(s : SignalfilterfirModel, f : Double) -> SignalfilterfirModel {
  let result = signal_filter_fir_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_fir_model_add(a : SignalfilterfirModel, b : SignalfilterfirModel) -> SignalfilterfirModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_fir_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_fir_model_copy(s : SignalfilterfirModel) -> SignalfilterfirModel {
  let result = signal_filter_fir_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_fir_model_fill(s : SignalfilterfirModel, v : Double) -> SignalfilterfirModel {
  let result = signal_filter_fir_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_model_min(s : SignalfilterfirModel) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_model_max(s : SignalfilterfirModel) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_model_to_string(s : SignalfilterfirModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_layer_make(size : Int) -> SignalfilterfirLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_layer_len(s : SignalfilterfirLayer) -> Int { s.size }

pub fn signal_filter_fir_layer_get(s : SignalfilterfirLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_layer_set(s : SignalfilterfirLayer, i : Int, v : Double) -> SignalfilterfirLayer {
  let result = signal_filter_fir_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_layer_sum(s : SignalfilterfirLayer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_layer_mean(s : SignalfilterfirLayer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_layer_scale(s : SignalfilterfirLayer, f : Double) -> SignalfilterfirLayer {
  let result = signal_filter_fir_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_fir_layer_add(a : SignalfilterfirLayer, b : SignalfilterfirLayer) -> SignalfilterfirLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_fir_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_fir_layer_copy(s : SignalfilterfirLayer) -> SignalfilterfirLayer {
  let result = signal_filter_fir_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_fir_layer_fill(s : SignalfilterfirLayer, v : Double) -> SignalfilterfirLayer {
  let result = signal_filter_fir_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_layer_min(s : SignalfilterfirLayer) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_layer_max(s : SignalfilterfirLayer) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_layer_to_string(s : SignalfilterfirLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_buffer_make(size : Int) -> SignalfilterfirBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_buffer_len(s : SignalfilterfirBuffer) -> Int { s.size }

pub fn signal_filter_fir_buffer_get(s : SignalfilterfirBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_buffer_set(s : SignalfilterfirBuffer, i : Int, v : Double) -> SignalfilterfirBuffer {
  let result = signal_filter_fir_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_buffer_sum(s : SignalfilterfirBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_buffer_mean(s : SignalfilterfirBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_buffer_scale(s : SignalfilterfirBuffer, f : Double) -> SignalfilterfirBuffer {
  let result = signal_filter_fir_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_fir_buffer_add(a : SignalfilterfirBuffer, b : SignalfilterfirBuffer) -> SignalfilterfirBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_fir_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_fir_buffer_copy(s : SignalfilterfirBuffer) -> SignalfilterfirBuffer {
  let result = signal_filter_fir_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_fir_buffer_fill(s : SignalfilterfirBuffer, v : Double) -> SignalfilterfirBuffer {
  let result = signal_filter_fir_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_buffer_min(s : SignalfilterfirBuffer) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_buffer_max(s : SignalfilterfirBuffer) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_buffer_to_string(s : SignalfilterfirBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_cursor_make(size : Int) -> SignalfilterfirCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_cursor_len(s : SignalfilterfirCursor) -> Int { s.size }

pub fn signal_filter_fir_cursor_get(s : SignalfilterfirCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_cursor_set(s : SignalfilterfirCursor, i : Int, v : Double) -> SignalfilterfirCursor {
  let result = signal_filter_fir_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_cursor_sum(s : SignalfilterfirCursor) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_cursor_mean(s : SignalfilterfirCursor) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_cursor_scale(s : SignalfilterfirCursor, f : Double) -> SignalfilterfirCursor {
  let result = signal_filter_fir_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_fir_cursor_add(a : SignalfilterfirCursor, b : SignalfilterfirCursor) -> SignalfilterfirCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_fir_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_fir_cursor_copy(s : SignalfilterfirCursor) -> SignalfilterfirCursor {
  let result = signal_filter_fir_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_fir_cursor_fill(s : SignalfilterfirCursor, v : Double) -> SignalfilterfirCursor {
  let result = signal_filter_fir_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_cursor_min(s : SignalfilterfirCursor) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_cursor_max(s : SignalfilterfirCursor) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_cursor_to_string(s : SignalfilterfirCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_view_make(size : Int) -> SignalfilterfirView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_view_len(s : SignalfilterfirView) -> Int { s.size }

pub fn signal_filter_fir_view_get(s : SignalfilterfirView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_view_set(s : SignalfilterfirView, i : Int, v : Double) -> SignalfilterfirView {
  let result = signal_filter_fir_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_view_sum(s : SignalfilterfirView) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_view_mean(s : SignalfilterfirView) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_view_scale(s : SignalfilterfirView, f : Double) -> SignalfilterfirView {
  let result = signal_filter_fir_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_fir_view_add(a : SignalfilterfirView, b : SignalfilterfirView) -> SignalfilterfirView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_fir_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_fir_view_copy(s : SignalfilterfirView) -> SignalfilterfirView {
  let result = signal_filter_fir_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_fir_view_fill(s : SignalfilterfirView, v : Double) -> SignalfilterfirView {
  let result = signal_filter_fir_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_view_min(s : SignalfilterfirView) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_view_max(s : SignalfilterfirView) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_view_to_string(s : SignalfilterfirView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_range_make(size : Int) -> SignalfilterfirRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_range_len(s : SignalfilterfirRange) -> Int { s.size }

pub fn signal_filter_fir_range_get(s : SignalfilterfirRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_range_set(s : SignalfilterfirRange, i : Int, v : Double) -> SignalfilterfirRange {
  let result = signal_filter_fir_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_range_sum(s : SignalfilterfirRange) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_range_mean(s : SignalfilterfirRange) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_range_scale(s : SignalfilterfirRange, f : Double) -> SignalfilterfirRange {
  let result = signal_filter_fir_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_fir_range_add(a : SignalfilterfirRange, b : SignalfilterfirRange) -> SignalfilterfirRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_fir_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_fir_range_copy(s : SignalfilterfirRange) -> SignalfilterfirRange {
  let result = signal_filter_fir_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_fir_range_fill(s : SignalfilterfirRange, v : Double) -> SignalfilterfirRange {
  let result = signal_filter_fir_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_range_min(s : SignalfilterfirRange) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_range_max(s : SignalfilterfirRange) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_range_to_string(s : SignalfilterfirRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_slice_make(size : Int) -> SignalfilterfirSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_slice_len(s : SignalfilterfirSlice) -> Int { s.size }

pub fn signal_filter_fir_slice_get(s : SignalfilterfirSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_slice_set(s : SignalfilterfirSlice, i : Int, v : Double) -> SignalfilterfirSlice {
  let result = signal_filter_fir_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_slice_sum(s : SignalfilterfirSlice) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_slice_mean(s : SignalfilterfirSlice) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_slice_scale(s : SignalfilterfirSlice, f : Double) -> SignalfilterfirSlice {
  let result = signal_filter_fir_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_fir_slice_add(a : SignalfilterfirSlice, b : SignalfilterfirSlice) -> SignalfilterfirSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_fir_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_fir_slice_copy(s : SignalfilterfirSlice) -> SignalfilterfirSlice {
  let result = signal_filter_fir_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_fir_slice_fill(s : SignalfilterfirSlice, v : Double) -> SignalfilterfirSlice {
  let result = signal_filter_fir_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_fir_slice_min(s : SignalfilterfirSlice) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_slice_max(s : SignalfilterfirSlice) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_slice_to_string(s : SignalfilterfirSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

