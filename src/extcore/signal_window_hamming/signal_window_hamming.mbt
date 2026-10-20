///===
/// extcore/signal_window_hamming

pub(all) struct SignalwindowhammingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_hamming_make_point(x : Double, y : Double) -> SignalwindowhammingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_hamming_make_point3(x : Double, y : Double, z : Double) -> SignalwindowhammingPoint {
  { x, y, z, label: 0 }
}

pub fn signal_window_hamming_point_x(pt : SignalwindowhammingPoint) -> Double { pt.x }

pub fn signal_window_hamming_point_y(pt : SignalwindowhammingPoint) -> Double { pt.y }

pub fn signal_window_hamming_point_z(pt : SignalwindowhammingPoint) -> Double { pt.z }

pub fn signal_window_hamming_point_label(pt : SignalwindowhammingPoint) -> Int { pt.label }

pub fn signal_window_hamming_point_dist(a : SignalwindowhammingPoint, b : SignalwindowhammingPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_window_hamming_point_add(a : SignalwindowhammingPoint, b : SignalwindowhammingPoint) -> SignalwindowhammingPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_window_hamming_point_sub(a : SignalwindowhammingPoint, b : SignalwindowhammingPoint) -> SignalwindowhammingPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_window_hamming_point_scale(pt : SignalwindowhammingPoint, s : Double) -> SignalwindowhammingPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_window_hamming_point_dot(a : SignalwindowhammingPoint, b : SignalwindowhammingPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_window_hamming_point_cross(a : SignalwindowhammingPoint, b : SignalwindowhammingPoint) -> SignalwindowhammingPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_window_hamming_point_norm(pt : SignalwindowhammingPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_window_hamming_point_normalize(pt : SignalwindowhammingPoint) -> SignalwindowhammingPoint {
  let n = signal_window_hamming_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_window_hamming_point_scale(pt, 1.0 / n) }
}

pub fn signal_window_hamming_point_negate(pt : SignalwindowhammingPoint) -> SignalwindowhammingPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_window_hamming_point_mid(a : SignalwindowhammingPoint, b : SignalwindowhammingPoint) -> SignalwindowhammingPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_window_hamming_point_lerp(a : SignalwindowhammingPoint, b : SignalwindowhammingPoint, t : Double) -> SignalwindowhammingPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_window_hamming_point_to_string(pt : SignalwindowhammingPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalwindowhammingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_hamming_make_series(vals : Array[Double], name : String) -> SignalwindowhammingSeries {
  { vals, name, meta: 0 }
}

pub fn signal_window_hamming_series_len(s : SignalwindowhammingSeries) -> Int { s.vals.length() }

pub fn signal_window_hamming_series_sum(s : SignalwindowhammingSeries) -> Double { @_common.sum(s.vals) }

pub fn signal_window_hamming_series_mean(s : SignalwindowhammingSeries) -> Double { @_common.mean(s.vals) }

pub fn signal_window_hamming_series_min(s : SignalwindowhammingSeries) -> Double { @_common.min(s.vals) }

pub fn signal_window_hamming_series_max(s : SignalwindowhammingSeries) -> Double { @_common.max(s.vals) }

pub fn signal_window_hamming_series_range(s : SignalwindowhammingSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn signal_window_hamming_series_var(s : SignalwindowhammingSeries) -> Double { @_common.variance(s.vals) }

pub fn signal_window_hamming_series_std(s : SignalwindowhammingSeries) -> Double { @_common.std(s.vals) }

pub fn signal_window_hamming_series_median(s : SignalwindowhammingSeries) -> Double { @_common.median(s.vals) }

pub fn signal_window_hamming_series_scale(s : SignalwindowhammingSeries, f : Double) -> SignalwindowhammingSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_window_hamming_series_add(a : SignalwindowhammingSeries, b : SignalwindowhammingSeries) -> SignalwindowhammingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_window_hamming_series_sub(a : SignalwindowhammingSeries, b : SignalwindowhammingSeries) -> SignalwindowhammingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_window_hamming_series_normalize(s : SignalwindowhammingSeries) -> SignalwindowhammingSeries {
  let mn = signal_window_hamming_series_min(s)
  let mx = signal_window_hamming_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_window_hamming_series_cumsum(s : SignalwindowhammingSeries) -> SignalwindowhammingSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_window_hamming_series_to_string(s : SignalwindowhammingSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowhammingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_hamming_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowhammingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_window_hamming_matrix_identity(n : Int) -> SignalwindowhammingMatrix {
  let m = signal_window_hamming_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_window_hamming_matrix_get(m : SignalwindowhammingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_window_hamming_matrix_transpose(m : SignalwindowhammingMatrix) -> SignalwindowhammingMatrix {
  let result = signal_window_hamming_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_window_hamming_matrix_add(a : SignalwindowhammingMatrix, b : SignalwindowhammingMatrix) -> SignalwindowhammingMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_window_hamming_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_window_hamming_matrix_scale(m : SignalwindowhammingMatrix, s : Double) -> SignalwindowhammingMatrix {
  let result = signal_window_hamming_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_window_hamming_matrix_multiply(a : SignalwindowhammingMatrix, b : SignalwindowhammingMatrix) -> SignalwindowhammingMatrix {
  if a.cols != b.rows { return signal_window_hamming_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_window_hamming_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_window_hamming_matrix_trace(m : SignalwindowhammingMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_window_hamming_matrix_det(m : SignalwindowhammingMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_window_hamming_matrix_norm(m : SignalwindowhammingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_window_hamming_matrix_to_string(m : SignalwindowhammingMatrix) -> String {
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

pub(all) struct SignalwindowhammingVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_hamming_make_vector(comps : Array[Double]) -> SignalwindowhammingVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_hamming_vector_zero(dim : Int) -> SignalwindowhammingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_window_hamming_vector_add(a : SignalwindowhammingVector, b : SignalwindowhammingVector) -> SignalwindowhammingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_window_hamming_vector_sub(a : SignalwindowhammingVector, b : SignalwindowhammingVector) -> SignalwindowhammingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_window_hamming_vector_scale(v : SignalwindowhammingVector, s : Double) -> SignalwindowhammingVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_window_hamming_vector_dot(a : SignalwindowhammingVector, b : SignalwindowhammingVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_window_hamming_vector_norm(v : SignalwindowhammingVector) -> Double { @_common.sqrt(signal_window_hamming_vector_dot(v, v)) }

pub fn signal_window_hamming_vector_normalize(v : SignalwindowhammingVector) -> SignalwindowhammingVector {
  let n = signal_window_hamming_vector_norm(v)
  if n < 0.0000001 { v } else { signal_window_hamming_vector_scale(v, 1.0 / n) }
}

pub fn signal_window_hamming_vector_dist(a : SignalwindowhammingVector, b : SignalwindowhammingVector) -> Double {
  signal_window_hamming_vector_norm(signal_window_hamming_vector_sub(a, b))
}

pub fn signal_window_hamming_vector_to_string(v : SignalwindowhammingVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_window_hamming_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_window_hamming_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_window_hamming_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_window_hamming_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_window_hamming_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_window_hamming_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_window_hamming_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_window_hamming_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_window_hamming_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_window_hamming_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_window_hamming_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_window_hamming_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_window_hamming_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_window_hamming_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_window_hamming_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_window_hamming_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_window_hamming_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_window_hamming_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_window_hamming_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_window_hamming_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_window_hamming_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_window_hamming_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_window_hamming_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_window_hamming_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_window_hamming_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_window_hamming_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_window_hamming_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_window_hamming_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_window_hamming_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalwindowhammingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_frame_make(size : Int) -> SignalwindowhammingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_frame_len(s : SignalwindowhammingFrame) -> Int { s.size }

pub fn signal_window_hamming_frame_get(s : SignalwindowhammingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_frame_set(s : SignalwindowhammingFrame, i : Int, v : Double) -> SignalwindowhammingFrame {
  let result = signal_window_hamming_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hamming_frame_sum(s : SignalwindowhammingFrame) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_frame_mean(s : SignalwindowhammingFrame) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_frame_scale(s : SignalwindowhammingFrame, f : Double) -> SignalwindowhammingFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_frame_add(a : SignalwindowhammingFrame, b : SignalwindowhammingFrame) -> SignalwindowhammingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_frame_copy(s : SignalwindowhammingFrame) -> SignalwindowhammingFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_frame_fill(s : SignalwindowhammingFrame, v : Double) -> SignalwindowhammingFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_frame_min(s : SignalwindowhammingFrame) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_frame_max(s : SignalwindowhammingFrame) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_frame_to_string(s : SignalwindowhammingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_table_make(size : Int) -> SignalwindowhammingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_table_len(s : SignalwindowhammingTable) -> Int { s.size }

pub fn signal_window_hamming_table_get(s : SignalwindowhammingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_table_set(s : SignalwindowhammingTable, i : Int, v : Double) -> SignalwindowhammingTable {
  let result = signal_window_hamming_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hamming_table_sum(s : SignalwindowhammingTable) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_table_mean(s : SignalwindowhammingTable) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_table_scale(s : SignalwindowhammingTable, f : Double) -> SignalwindowhammingTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_table_add(a : SignalwindowhammingTable, b : SignalwindowhammingTable) -> SignalwindowhammingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_table_copy(s : SignalwindowhammingTable) -> SignalwindowhammingTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_table_fill(s : SignalwindowhammingTable, v : Double) -> SignalwindowhammingTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_table_min(s : SignalwindowhammingTable) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_table_max(s : SignalwindowhammingTable) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_table_to_string(s : SignalwindowhammingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_graphn_make(size : Int) -> SignalwindowhammingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_graphn_len(s : SignalwindowhammingGraphN) -> Int { s.size }

pub fn signal_window_hamming_graphn_get(s : SignalwindowhammingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_graphn_set(s : SignalwindowhammingGraphN, i : Int, v : Double) -> SignalwindowhammingGraphN {
  let result = signal_window_hamming_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hamming_graphn_sum(s : SignalwindowhammingGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_graphn_mean(s : SignalwindowhammingGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_graphn_scale(s : SignalwindowhammingGraphN, f : Double) -> SignalwindowhammingGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_graphn_add(a : SignalwindowhammingGraphN, b : SignalwindowhammingGraphN) -> SignalwindowhammingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_graphn_copy(s : SignalwindowhammingGraphN) -> SignalwindowhammingGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_graphn_fill(s : SignalwindowhammingGraphN, v : Double) -> SignalwindowhammingGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_graphn_min(s : SignalwindowhammingGraphN) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_graphn_max(s : SignalwindowhammingGraphN) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_graphn_to_string(s : SignalwindowhammingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_node_make(size : Int) -> SignalwindowhammingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_node_len(s : SignalwindowhammingNode) -> Int { s.size }

pub fn signal_window_hamming_node_get(s : SignalwindowhammingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_node_set(s : SignalwindowhammingNode, i : Int, v : Double) -> SignalwindowhammingNode {
  let result = signal_window_hamming_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hamming_node_sum(s : SignalwindowhammingNode) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_node_mean(s : SignalwindowhammingNode) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_node_scale(s : SignalwindowhammingNode, f : Double) -> SignalwindowhammingNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_node_add(a : SignalwindowhammingNode, b : SignalwindowhammingNode) -> SignalwindowhammingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_node_copy(s : SignalwindowhammingNode) -> SignalwindowhammingNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_node_fill(s : SignalwindowhammingNode, v : Double) -> SignalwindowhammingNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_node_min(s : SignalwindowhammingNode) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_node_max(s : SignalwindowhammingNode) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_node_to_string(s : SignalwindowhammingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_edge_make(size : Int) -> SignalwindowhammingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_edge_len(s : SignalwindowhammingEdge) -> Int { s.size }

pub fn signal_window_hamming_edge_get(s : SignalwindowhammingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_edge_set(s : SignalwindowhammingEdge, i : Int, v : Double) -> SignalwindowhammingEdge {
  let result = signal_window_hamming_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hamming_edge_sum(s : SignalwindowhammingEdge) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_edge_mean(s : SignalwindowhammingEdge) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_edge_scale(s : SignalwindowhammingEdge, f : Double) -> SignalwindowhammingEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_edge_add(a : SignalwindowhammingEdge, b : SignalwindowhammingEdge) -> SignalwindowhammingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_edge_copy(s : SignalwindowhammingEdge) -> SignalwindowhammingEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_edge_fill(s : SignalwindowhammingEdge, v : Double) -> SignalwindowhammingEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_edge_min(s : SignalwindowhammingEdge) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_edge_max(s : SignalwindowhammingEdge) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_edge_to_string(s : SignalwindowhammingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_path_make(size : Int) -> SignalwindowhammingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_path_len(s : SignalwindowhammingPath) -> Int { s.size }

pub fn signal_window_hamming_path_get(s : SignalwindowhammingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_path_set(s : SignalwindowhammingPath, i : Int, v : Double) -> SignalwindowhammingPath {
  let result = signal_window_hamming_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hamming_path_sum(s : SignalwindowhammingPath) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_path_mean(s : SignalwindowhammingPath) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_path_scale(s : SignalwindowhammingPath, f : Double) -> SignalwindowhammingPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_path_add(a : SignalwindowhammingPath, b : SignalwindowhammingPath) -> SignalwindowhammingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_path_copy(s : SignalwindowhammingPath) -> SignalwindowhammingPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_path_fill(s : SignalwindowhammingPath, v : Double) -> SignalwindowhammingPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_path_min(s : SignalwindowhammingPath) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_path_max(s : SignalwindowhammingPath) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_path_to_string(s : SignalwindowhammingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_cluster_make(size : Int) -> SignalwindowhammingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_cluster_len(s : SignalwindowhammingCluster) -> Int { s.size }

pub fn signal_window_hamming_cluster_get(s : SignalwindowhammingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_cluster_set(s : SignalwindowhammingCluster, i : Int, v : Double) -> SignalwindowhammingCluster {
  let result = signal_window_hamming_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hamming_cluster_sum(s : SignalwindowhammingCluster) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_cluster_mean(s : SignalwindowhammingCluster) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_cluster_scale(s : SignalwindowhammingCluster, f : Double) -> SignalwindowhammingCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_cluster_add(a : SignalwindowhammingCluster, b : SignalwindowhammingCluster) -> SignalwindowhammingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_cluster_copy(s : SignalwindowhammingCluster) -> SignalwindowhammingCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_cluster_fill(s : SignalwindowhammingCluster, v : Double) -> SignalwindowhammingCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_cluster_min(s : SignalwindowhammingCluster) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_cluster_max(s : SignalwindowhammingCluster) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_cluster_to_string(s : SignalwindowhammingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_model_make(size : Int) -> SignalwindowhammingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_model_len(s : SignalwindowhammingModel) -> Int { s.size }

pub fn signal_window_hamming_model_get(s : SignalwindowhammingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_model_set(s : SignalwindowhammingModel, i : Int, v : Double) -> SignalwindowhammingModel {
  let result = signal_window_hamming_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hamming_model_sum(s : SignalwindowhammingModel) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_model_mean(s : SignalwindowhammingModel) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_model_scale(s : SignalwindowhammingModel, f : Double) -> SignalwindowhammingModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_model_add(a : SignalwindowhammingModel, b : SignalwindowhammingModel) -> SignalwindowhammingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_model_copy(s : SignalwindowhammingModel) -> SignalwindowhammingModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_model_fill(s : SignalwindowhammingModel, v : Double) -> SignalwindowhammingModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_model_min(s : SignalwindowhammingModel) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_model_max(s : SignalwindowhammingModel) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_model_to_string(s : SignalwindowhammingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_layer_make(size : Int) -> SignalwindowhammingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_layer_len(s : SignalwindowhammingLayer) -> Int { s.size }

pub fn signal_window_hamming_layer_get(s : SignalwindowhammingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_layer_set(s : SignalwindowhammingLayer, i : Int, v : Double) -> SignalwindowhammingLayer {
  let result = signal_window_hamming_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hamming_layer_sum(s : SignalwindowhammingLayer) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_layer_mean(s : SignalwindowhammingLayer) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_layer_scale(s : SignalwindowhammingLayer, f : Double) -> SignalwindowhammingLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_layer_add(a : SignalwindowhammingLayer, b : SignalwindowhammingLayer) -> SignalwindowhammingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_layer_copy(s : SignalwindowhammingLayer) -> SignalwindowhammingLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_layer_fill(s : SignalwindowhammingLayer, v : Double) -> SignalwindowhammingLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_layer_min(s : SignalwindowhammingLayer) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_layer_max(s : SignalwindowhammingLayer) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_layer_to_string(s : SignalwindowhammingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_buffer_make(size : Int) -> SignalwindowhammingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_buffer_len(s : SignalwindowhammingBuffer) -> Int { s.size }

pub fn signal_window_hamming_buffer_get(s : SignalwindowhammingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_buffer_set(s : SignalwindowhammingBuffer, i : Int, v : Double) -> SignalwindowhammingBuffer {
  let result = signal_window_hamming_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hamming_buffer_sum(s : SignalwindowhammingBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_buffer_mean(s : SignalwindowhammingBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_buffer_scale(s : SignalwindowhammingBuffer, f : Double) -> SignalwindowhammingBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_buffer_add(a : SignalwindowhammingBuffer, b : SignalwindowhammingBuffer) -> SignalwindowhammingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_buffer_copy(s : SignalwindowhammingBuffer) -> SignalwindowhammingBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_buffer_fill(s : SignalwindowhammingBuffer, v : Double) -> SignalwindowhammingBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_buffer_min(s : SignalwindowhammingBuffer) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_buffer_max(s : SignalwindowhammingBuffer) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_buffer_to_string(s : SignalwindowhammingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_cursor_make(size : Int) -> SignalwindowhammingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_cursor_len(s : SignalwindowhammingCursor) -> Int { s.size }

pub fn signal_window_hamming_cursor_get(s : SignalwindowhammingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_cursor_set(s : SignalwindowhammingCursor, i : Int, v : Double) -> SignalwindowhammingCursor {
  let result = signal_window_hamming_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hamming_cursor_sum(s : SignalwindowhammingCursor) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_cursor_mean(s : SignalwindowhammingCursor) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_cursor_scale(s : SignalwindowhammingCursor, f : Double) -> SignalwindowhammingCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_cursor_add(a : SignalwindowhammingCursor, b : SignalwindowhammingCursor) -> SignalwindowhammingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_cursor_copy(s : SignalwindowhammingCursor) -> SignalwindowhammingCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_cursor_fill(s : SignalwindowhammingCursor, v : Double) -> SignalwindowhammingCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_cursor_min(s : SignalwindowhammingCursor) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_cursor_max(s : SignalwindowhammingCursor) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_cursor_to_string(s : SignalwindowhammingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_view_make(size : Int) -> SignalwindowhammingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_view_len(s : SignalwindowhammingView) -> Int { s.size }

pub fn signal_window_hamming_view_get(s : SignalwindowhammingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_view_set(s : SignalwindowhammingView, i : Int, v : Double) -> SignalwindowhammingView {
  let result = signal_window_hamming_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hamming_view_sum(s : SignalwindowhammingView) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_view_mean(s : SignalwindowhammingView) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_view_scale(s : SignalwindowhammingView, f : Double) -> SignalwindowhammingView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_view_add(a : SignalwindowhammingView, b : SignalwindowhammingView) -> SignalwindowhammingView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_view_copy(s : SignalwindowhammingView) -> SignalwindowhammingView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_view_fill(s : SignalwindowhammingView, v : Double) -> SignalwindowhammingView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_view_min(s : SignalwindowhammingView) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_view_max(s : SignalwindowhammingView) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_view_to_string(s : SignalwindowhammingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_range_make(size : Int) -> SignalwindowhammingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_range_len(s : SignalwindowhammingRange) -> Int { s.size }

pub fn signal_window_hamming_range_get(s : SignalwindowhammingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_range_set(s : SignalwindowhammingRange, i : Int, v : Double) -> SignalwindowhammingRange {
  let result = signal_window_hamming_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hamming_range_sum(s : SignalwindowhammingRange) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_range_mean(s : SignalwindowhammingRange) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_range_scale(s : SignalwindowhammingRange, f : Double) -> SignalwindowhammingRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_range_add(a : SignalwindowhammingRange, b : SignalwindowhammingRange) -> SignalwindowhammingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_range_copy(s : SignalwindowhammingRange) -> SignalwindowhammingRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_range_fill(s : SignalwindowhammingRange, v : Double) -> SignalwindowhammingRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_range_min(s : SignalwindowhammingRange) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_range_max(s : SignalwindowhammingRange) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_range_to_string(s : SignalwindowhammingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_slice_make(size : Int) -> SignalwindowhammingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_slice_len(s : SignalwindowhammingSlice) -> Int { s.size }

pub fn signal_window_hamming_slice_get(s : SignalwindowhammingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_slice_set(s : SignalwindowhammingSlice, i : Int, v : Double) -> SignalwindowhammingSlice {
  let result = signal_window_hamming_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hamming_slice_sum(s : SignalwindowhammingSlice) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_slice_mean(s : SignalwindowhammingSlice) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_slice_scale(s : SignalwindowhammingSlice, f : Double) -> SignalwindowhammingSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_slice_add(a : SignalwindowhammingSlice, b : SignalwindowhammingSlice) -> SignalwindowhammingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_slice_copy(s : SignalwindowhammingSlice) -> SignalwindowhammingSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_slice_fill(s : SignalwindowhammingSlice, v : Double) -> SignalwindowhammingSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_slice_min(s : SignalwindowhammingSlice) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_slice_max(s : SignalwindowhammingSlice) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_slice_to_string(s : SignalwindowhammingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

