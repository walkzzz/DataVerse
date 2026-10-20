///===
/// extcore/signal_transform_chirp

pub(all) struct SignaltransformchirpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_chirp_make_point(x : Double, y : Double) -> SignaltransformchirpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_chirp_make_point3(x : Double, y : Double, z : Double) -> SignaltransformchirpPoint {
  { x, y, z, label: 0 }
}

pub fn signal_transform_chirp_point_x(pt : SignaltransformchirpPoint) -> Double { pt.x }

pub fn signal_transform_chirp_point_y(pt : SignaltransformchirpPoint) -> Double { pt.y }

pub fn signal_transform_chirp_point_z(pt : SignaltransformchirpPoint) -> Double { pt.z }

pub fn signal_transform_chirp_point_label(pt : SignaltransformchirpPoint) -> Int { pt.label }

pub fn signal_transform_chirp_point_dist(a : SignaltransformchirpPoint, b : SignaltransformchirpPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_transform_chirp_point_add(a : SignaltransformchirpPoint, b : SignaltransformchirpPoint) -> SignaltransformchirpPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_transform_chirp_point_sub(a : SignaltransformchirpPoint, b : SignaltransformchirpPoint) -> SignaltransformchirpPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_transform_chirp_point_scale(pt : SignaltransformchirpPoint, s : Double) -> SignaltransformchirpPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_transform_chirp_point_dot(a : SignaltransformchirpPoint, b : SignaltransformchirpPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_transform_chirp_point_cross(a : SignaltransformchirpPoint, b : SignaltransformchirpPoint) -> SignaltransformchirpPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_transform_chirp_point_norm(pt : SignaltransformchirpPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_transform_chirp_point_normalize(pt : SignaltransformchirpPoint) -> SignaltransformchirpPoint {
  let n = signal_transform_chirp_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_transform_chirp_point_scale(pt, 1.0 / n) }
}

pub fn signal_transform_chirp_point_negate(pt : SignaltransformchirpPoint) -> SignaltransformchirpPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_transform_chirp_point_mid(a : SignaltransformchirpPoint, b : SignaltransformchirpPoint) -> SignaltransformchirpPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_transform_chirp_point_lerp(a : SignaltransformchirpPoint, b : SignaltransformchirpPoint, t : Double) -> SignaltransformchirpPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_transform_chirp_point_to_string(pt : SignaltransformchirpPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignaltransformchirpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_chirp_make_series(vals : Array[Double], name : String) -> SignaltransformchirpSeries {
  { vals, name, meta: 0 }
}

pub fn signal_transform_chirp_series_len(s : SignaltransformchirpSeries) -> Int { s.vals.length() }

pub fn signal_transform_chirp_series_sum(s : SignaltransformchirpSeries) -> Double { @_common.sum(s.vals) }

pub fn signal_transform_chirp_series_mean(s : SignaltransformchirpSeries) -> Double { @_common.mean(s.vals) }

pub fn signal_transform_chirp_series_min(s : SignaltransformchirpSeries) -> Double { @_common.min(s.vals) }

pub fn signal_transform_chirp_series_max(s : SignaltransformchirpSeries) -> Double { @_common.max(s.vals) }

pub fn signal_transform_chirp_series_range(s : SignaltransformchirpSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn signal_transform_chirp_series_var(s : SignaltransformchirpSeries) -> Double { @_common.variance(s.vals) }

pub fn signal_transform_chirp_series_std(s : SignaltransformchirpSeries) -> Double { @_common.std(s.vals) }

pub fn signal_transform_chirp_series_median(s : SignaltransformchirpSeries) -> Double { @_common.median(s.vals) }

pub fn signal_transform_chirp_series_scale(s : SignaltransformchirpSeries, f : Double) -> SignaltransformchirpSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_transform_chirp_series_add(a : SignaltransformchirpSeries, b : SignaltransformchirpSeries) -> SignaltransformchirpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_transform_chirp_series_sub(a : SignaltransformchirpSeries, b : SignaltransformchirpSeries) -> SignaltransformchirpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_transform_chirp_series_normalize(s : SignaltransformchirpSeries) -> SignaltransformchirpSeries {
  let mn = signal_transform_chirp_series_min(s)
  let mx = signal_transform_chirp_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_transform_chirp_series_cumsum(s : SignaltransformchirpSeries) -> SignaltransformchirpSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_transform_chirp_series_to_string(s : SignaltransformchirpSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformchirpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_chirp_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformchirpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_chirp_matrix_identity(n : Int) -> SignaltransformchirpMatrix {
  let m = signal_transform_chirp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_transform_chirp_matrix_get(m : SignaltransformchirpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_transform_chirp_matrix_transpose(m : SignaltransformchirpMatrix) -> SignaltransformchirpMatrix {
  let result = signal_transform_chirp_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_transform_chirp_matrix_add(a : SignaltransformchirpMatrix, b : SignaltransformchirpMatrix) -> SignaltransformchirpMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_transform_chirp_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_transform_chirp_matrix_scale(m : SignaltransformchirpMatrix, s : Double) -> SignaltransformchirpMatrix {
  let result = signal_transform_chirp_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_transform_chirp_matrix_multiply(a : SignaltransformchirpMatrix, b : SignaltransformchirpMatrix) -> SignaltransformchirpMatrix {
  if a.cols != b.rows { return signal_transform_chirp_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_transform_chirp_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_transform_chirp_matrix_trace(m : SignaltransformchirpMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_transform_chirp_matrix_det(m : SignaltransformchirpMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_transform_chirp_matrix_norm(m : SignaltransformchirpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_transform_chirp_matrix_to_string(m : SignaltransformchirpMatrix) -> String {
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

pub(all) struct SignaltransformchirpVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_chirp_make_vector(comps : Array[Double]) -> SignaltransformchirpVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_chirp_vector_zero(dim : Int) -> SignaltransformchirpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_transform_chirp_vector_add(a : SignaltransformchirpVector, b : SignaltransformchirpVector) -> SignaltransformchirpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_transform_chirp_vector_sub(a : SignaltransformchirpVector, b : SignaltransformchirpVector) -> SignaltransformchirpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_transform_chirp_vector_scale(v : SignaltransformchirpVector, s : Double) -> SignaltransformchirpVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_transform_chirp_vector_dot(a : SignaltransformchirpVector, b : SignaltransformchirpVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_transform_chirp_vector_norm(v : SignaltransformchirpVector) -> Double { @_common.sqrt(signal_transform_chirp_vector_dot(v, v)) }

pub fn signal_transform_chirp_vector_normalize(v : SignaltransformchirpVector) -> SignaltransformchirpVector {
  let n = signal_transform_chirp_vector_norm(v)
  if n < 0.0000001 { v } else { signal_transform_chirp_vector_scale(v, 1.0 / n) }
}

pub fn signal_transform_chirp_vector_dist(a : SignaltransformchirpVector, b : SignaltransformchirpVector) -> Double {
  signal_transform_chirp_vector_norm(signal_transform_chirp_vector_sub(a, b))
}

pub fn signal_transform_chirp_vector_to_string(v : SignaltransformchirpVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_transform_chirp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_transform_chirp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_transform_chirp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_transform_chirp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_transform_chirp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_transform_chirp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_transform_chirp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_transform_chirp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_transform_chirp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_transform_chirp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_transform_chirp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_transform_chirp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_transform_chirp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_transform_chirp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_transform_chirp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_transform_chirp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_transform_chirp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_transform_chirp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_transform_chirp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_transform_chirp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_transform_chirp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_transform_chirp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_transform_chirp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_transform_chirp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_transform_chirp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_transform_chirp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_transform_chirp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_transform_chirp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_transform_chirp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignaltransformchirpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_frame_make(size : Int) -> SignaltransformchirpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_frame_len(s : SignaltransformchirpFrame) -> Int { s.size }

pub fn signal_transform_chirp_frame_get(s : SignaltransformchirpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_frame_set(s : SignaltransformchirpFrame, i : Int, v : Double) -> SignaltransformchirpFrame {
  let result = signal_transform_chirp_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_frame_sum(s : SignaltransformchirpFrame) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_frame_mean(s : SignaltransformchirpFrame) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_frame_scale(s : SignaltransformchirpFrame, f : Double) -> SignaltransformchirpFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_frame_add(a : SignaltransformchirpFrame, b : SignaltransformchirpFrame) -> SignaltransformchirpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_frame_copy(s : SignaltransformchirpFrame) -> SignaltransformchirpFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_frame_fill(s : SignaltransformchirpFrame, v : Double) -> SignaltransformchirpFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_frame_min(s : SignaltransformchirpFrame) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_frame_max(s : SignaltransformchirpFrame) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_frame_to_string(s : SignaltransformchirpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_table_make(size : Int) -> SignaltransformchirpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_table_len(s : SignaltransformchirpTable) -> Int { s.size }

pub fn signal_transform_chirp_table_get(s : SignaltransformchirpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_table_set(s : SignaltransformchirpTable, i : Int, v : Double) -> SignaltransformchirpTable {
  let result = signal_transform_chirp_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_table_sum(s : SignaltransformchirpTable) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_table_mean(s : SignaltransformchirpTable) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_table_scale(s : SignaltransformchirpTable, f : Double) -> SignaltransformchirpTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_table_add(a : SignaltransformchirpTable, b : SignaltransformchirpTable) -> SignaltransformchirpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_table_copy(s : SignaltransformchirpTable) -> SignaltransformchirpTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_table_fill(s : SignaltransformchirpTable, v : Double) -> SignaltransformchirpTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_table_min(s : SignaltransformchirpTable) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_table_max(s : SignaltransformchirpTable) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_table_to_string(s : SignaltransformchirpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_graphn_make(size : Int) -> SignaltransformchirpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_graphn_len(s : SignaltransformchirpGraphN) -> Int { s.size }

pub fn signal_transform_chirp_graphn_get(s : SignaltransformchirpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_graphn_set(s : SignaltransformchirpGraphN, i : Int, v : Double) -> SignaltransformchirpGraphN {
  let result = signal_transform_chirp_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_graphn_sum(s : SignaltransformchirpGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_graphn_mean(s : SignaltransformchirpGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_graphn_scale(s : SignaltransformchirpGraphN, f : Double) -> SignaltransformchirpGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_graphn_add(a : SignaltransformchirpGraphN, b : SignaltransformchirpGraphN) -> SignaltransformchirpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_graphn_copy(s : SignaltransformchirpGraphN) -> SignaltransformchirpGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_graphn_fill(s : SignaltransformchirpGraphN, v : Double) -> SignaltransformchirpGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_graphn_min(s : SignaltransformchirpGraphN) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_graphn_max(s : SignaltransformchirpGraphN) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_graphn_to_string(s : SignaltransformchirpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_node_make(size : Int) -> SignaltransformchirpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_node_len(s : SignaltransformchirpNode) -> Int { s.size }

pub fn signal_transform_chirp_node_get(s : SignaltransformchirpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_node_set(s : SignaltransformchirpNode, i : Int, v : Double) -> SignaltransformchirpNode {
  let result = signal_transform_chirp_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_node_sum(s : SignaltransformchirpNode) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_node_mean(s : SignaltransformchirpNode) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_node_scale(s : SignaltransformchirpNode, f : Double) -> SignaltransformchirpNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_node_add(a : SignaltransformchirpNode, b : SignaltransformchirpNode) -> SignaltransformchirpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_node_copy(s : SignaltransformchirpNode) -> SignaltransformchirpNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_node_fill(s : SignaltransformchirpNode, v : Double) -> SignaltransformchirpNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_node_min(s : SignaltransformchirpNode) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_node_max(s : SignaltransformchirpNode) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_node_to_string(s : SignaltransformchirpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_edge_make(size : Int) -> SignaltransformchirpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_edge_len(s : SignaltransformchirpEdge) -> Int { s.size }

pub fn signal_transform_chirp_edge_get(s : SignaltransformchirpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_edge_set(s : SignaltransformchirpEdge, i : Int, v : Double) -> SignaltransformchirpEdge {
  let result = signal_transform_chirp_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_edge_sum(s : SignaltransformchirpEdge) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_edge_mean(s : SignaltransformchirpEdge) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_edge_scale(s : SignaltransformchirpEdge, f : Double) -> SignaltransformchirpEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_edge_add(a : SignaltransformchirpEdge, b : SignaltransformchirpEdge) -> SignaltransformchirpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_edge_copy(s : SignaltransformchirpEdge) -> SignaltransformchirpEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_edge_fill(s : SignaltransformchirpEdge, v : Double) -> SignaltransformchirpEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_edge_min(s : SignaltransformchirpEdge) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_edge_max(s : SignaltransformchirpEdge) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_edge_to_string(s : SignaltransformchirpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_path_make(size : Int) -> SignaltransformchirpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_path_len(s : SignaltransformchirpPath) -> Int { s.size }

pub fn signal_transform_chirp_path_get(s : SignaltransformchirpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_path_set(s : SignaltransformchirpPath, i : Int, v : Double) -> SignaltransformchirpPath {
  let result = signal_transform_chirp_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_path_sum(s : SignaltransformchirpPath) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_path_mean(s : SignaltransformchirpPath) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_path_scale(s : SignaltransformchirpPath, f : Double) -> SignaltransformchirpPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_path_add(a : SignaltransformchirpPath, b : SignaltransformchirpPath) -> SignaltransformchirpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_path_copy(s : SignaltransformchirpPath) -> SignaltransformchirpPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_path_fill(s : SignaltransformchirpPath, v : Double) -> SignaltransformchirpPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_path_min(s : SignaltransformchirpPath) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_path_max(s : SignaltransformchirpPath) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_path_to_string(s : SignaltransformchirpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_cluster_make(size : Int) -> SignaltransformchirpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_cluster_len(s : SignaltransformchirpCluster) -> Int { s.size }

pub fn signal_transform_chirp_cluster_get(s : SignaltransformchirpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_cluster_set(s : SignaltransformchirpCluster, i : Int, v : Double) -> SignaltransformchirpCluster {
  let result = signal_transform_chirp_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_cluster_sum(s : SignaltransformchirpCluster) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_cluster_mean(s : SignaltransformchirpCluster) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_cluster_scale(s : SignaltransformchirpCluster, f : Double) -> SignaltransformchirpCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_cluster_add(a : SignaltransformchirpCluster, b : SignaltransformchirpCluster) -> SignaltransformchirpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_cluster_copy(s : SignaltransformchirpCluster) -> SignaltransformchirpCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_cluster_fill(s : SignaltransformchirpCluster, v : Double) -> SignaltransformchirpCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_cluster_min(s : SignaltransformchirpCluster) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_cluster_max(s : SignaltransformchirpCluster) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_cluster_to_string(s : SignaltransformchirpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_model_make(size : Int) -> SignaltransformchirpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_model_len(s : SignaltransformchirpModel) -> Int { s.size }

pub fn signal_transform_chirp_model_get(s : SignaltransformchirpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_model_set(s : SignaltransformchirpModel, i : Int, v : Double) -> SignaltransformchirpModel {
  let result = signal_transform_chirp_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_model_sum(s : SignaltransformchirpModel) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_model_mean(s : SignaltransformchirpModel) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_model_scale(s : SignaltransformchirpModel, f : Double) -> SignaltransformchirpModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_model_add(a : SignaltransformchirpModel, b : SignaltransformchirpModel) -> SignaltransformchirpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_model_copy(s : SignaltransformchirpModel) -> SignaltransformchirpModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_model_fill(s : SignaltransformchirpModel, v : Double) -> SignaltransformchirpModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_model_min(s : SignaltransformchirpModel) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_model_max(s : SignaltransformchirpModel) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_model_to_string(s : SignaltransformchirpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_layer_make(size : Int) -> SignaltransformchirpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_layer_len(s : SignaltransformchirpLayer) -> Int { s.size }

pub fn signal_transform_chirp_layer_get(s : SignaltransformchirpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_layer_set(s : SignaltransformchirpLayer, i : Int, v : Double) -> SignaltransformchirpLayer {
  let result = signal_transform_chirp_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_layer_sum(s : SignaltransformchirpLayer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_layer_mean(s : SignaltransformchirpLayer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_layer_scale(s : SignaltransformchirpLayer, f : Double) -> SignaltransformchirpLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_layer_add(a : SignaltransformchirpLayer, b : SignaltransformchirpLayer) -> SignaltransformchirpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_layer_copy(s : SignaltransformchirpLayer) -> SignaltransformchirpLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_layer_fill(s : SignaltransformchirpLayer, v : Double) -> SignaltransformchirpLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_layer_min(s : SignaltransformchirpLayer) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_layer_max(s : SignaltransformchirpLayer) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_layer_to_string(s : SignaltransformchirpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_buffer_make(size : Int) -> SignaltransformchirpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_buffer_len(s : SignaltransformchirpBuffer) -> Int { s.size }

pub fn signal_transform_chirp_buffer_get(s : SignaltransformchirpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_buffer_set(s : SignaltransformchirpBuffer, i : Int, v : Double) -> SignaltransformchirpBuffer {
  let result = signal_transform_chirp_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_buffer_sum(s : SignaltransformchirpBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_buffer_mean(s : SignaltransformchirpBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_buffer_scale(s : SignaltransformchirpBuffer, f : Double) -> SignaltransformchirpBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_buffer_add(a : SignaltransformchirpBuffer, b : SignaltransformchirpBuffer) -> SignaltransformchirpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_buffer_copy(s : SignaltransformchirpBuffer) -> SignaltransformchirpBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_buffer_fill(s : SignaltransformchirpBuffer, v : Double) -> SignaltransformchirpBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_buffer_min(s : SignaltransformchirpBuffer) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_buffer_max(s : SignaltransformchirpBuffer) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_buffer_to_string(s : SignaltransformchirpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_cursor_make(size : Int) -> SignaltransformchirpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_cursor_len(s : SignaltransformchirpCursor) -> Int { s.size }

pub fn signal_transform_chirp_cursor_get(s : SignaltransformchirpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_cursor_set(s : SignaltransformchirpCursor, i : Int, v : Double) -> SignaltransformchirpCursor {
  let result = signal_transform_chirp_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_cursor_sum(s : SignaltransformchirpCursor) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_cursor_mean(s : SignaltransformchirpCursor) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_cursor_scale(s : SignaltransformchirpCursor, f : Double) -> SignaltransformchirpCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_cursor_add(a : SignaltransformchirpCursor, b : SignaltransformchirpCursor) -> SignaltransformchirpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_cursor_copy(s : SignaltransformchirpCursor) -> SignaltransformchirpCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_cursor_fill(s : SignaltransformchirpCursor, v : Double) -> SignaltransformchirpCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_cursor_min(s : SignaltransformchirpCursor) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_cursor_max(s : SignaltransformchirpCursor) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_cursor_to_string(s : SignaltransformchirpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_view_make(size : Int) -> SignaltransformchirpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_view_len(s : SignaltransformchirpView) -> Int { s.size }

pub fn signal_transform_chirp_view_get(s : SignaltransformchirpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_view_set(s : SignaltransformchirpView, i : Int, v : Double) -> SignaltransformchirpView {
  let result = signal_transform_chirp_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_view_sum(s : SignaltransformchirpView) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_view_mean(s : SignaltransformchirpView) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_view_scale(s : SignaltransformchirpView, f : Double) -> SignaltransformchirpView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_view_add(a : SignaltransformchirpView, b : SignaltransformchirpView) -> SignaltransformchirpView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_view_copy(s : SignaltransformchirpView) -> SignaltransformchirpView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_view_fill(s : SignaltransformchirpView, v : Double) -> SignaltransformchirpView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_view_min(s : SignaltransformchirpView) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_view_max(s : SignaltransformchirpView) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_view_to_string(s : SignaltransformchirpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_range_make(size : Int) -> SignaltransformchirpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_range_len(s : SignaltransformchirpRange) -> Int { s.size }

pub fn signal_transform_chirp_range_get(s : SignaltransformchirpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_range_set(s : SignaltransformchirpRange, i : Int, v : Double) -> SignaltransformchirpRange {
  let result = signal_transform_chirp_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_range_sum(s : SignaltransformchirpRange) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_range_mean(s : SignaltransformchirpRange) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_range_scale(s : SignaltransformchirpRange, f : Double) -> SignaltransformchirpRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_range_add(a : SignaltransformchirpRange, b : SignaltransformchirpRange) -> SignaltransformchirpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_range_copy(s : SignaltransformchirpRange) -> SignaltransformchirpRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_range_fill(s : SignaltransformchirpRange, v : Double) -> SignaltransformchirpRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_range_min(s : SignaltransformchirpRange) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_range_max(s : SignaltransformchirpRange) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_range_to_string(s : SignaltransformchirpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_slice_make(size : Int) -> SignaltransformchirpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_slice_len(s : SignaltransformchirpSlice) -> Int { s.size }

pub fn signal_transform_chirp_slice_get(s : SignaltransformchirpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_slice_set(s : SignaltransformchirpSlice, i : Int, v : Double) -> SignaltransformchirpSlice {
  let result = signal_transform_chirp_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_slice_sum(s : SignaltransformchirpSlice) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_slice_mean(s : SignaltransformchirpSlice) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_slice_scale(s : SignaltransformchirpSlice, f : Double) -> SignaltransformchirpSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_slice_add(a : SignaltransformchirpSlice, b : SignaltransformchirpSlice) -> SignaltransformchirpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_slice_copy(s : SignaltransformchirpSlice) -> SignaltransformchirpSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_slice_fill(s : SignaltransformchirpSlice, v : Double) -> SignaltransformchirpSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_slice_min(s : SignaltransformchirpSlice) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_slice_max(s : SignaltransformchirpSlice) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_slice_to_string(s : SignaltransformchirpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

