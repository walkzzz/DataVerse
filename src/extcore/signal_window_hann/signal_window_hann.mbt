///===
/// extcore/signal_window_hann

pub(all) struct SignalwindowhannPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_hann_make_point(x : Double, y : Double) -> SignalwindowhannPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_hann_make_point3(x : Double, y : Double, z : Double) -> SignalwindowhannPoint {
  { x, y, z, label: 0 }
}

pub fn signal_window_hann_point_x(pt : SignalwindowhannPoint) -> Double { pt.x }

pub fn signal_window_hann_point_y(pt : SignalwindowhannPoint) -> Double { pt.y }

pub fn signal_window_hann_point_z(pt : SignalwindowhannPoint) -> Double { pt.z }

pub fn signal_window_hann_point_label(pt : SignalwindowhannPoint) -> Int { pt.label }

pub fn signal_window_hann_point_dist(a : SignalwindowhannPoint, b : SignalwindowhannPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_window_hann_point_add(a : SignalwindowhannPoint, b : SignalwindowhannPoint) -> SignalwindowhannPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_window_hann_point_sub(a : SignalwindowhannPoint, b : SignalwindowhannPoint) -> SignalwindowhannPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_window_hann_point_scale(pt : SignalwindowhannPoint, s : Double) -> SignalwindowhannPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_window_hann_point_dot(a : SignalwindowhannPoint, b : SignalwindowhannPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_window_hann_point_cross(a : SignalwindowhannPoint, b : SignalwindowhannPoint) -> SignalwindowhannPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_window_hann_point_norm(pt : SignalwindowhannPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_window_hann_point_normalize(pt : SignalwindowhannPoint) -> SignalwindowhannPoint {
  let n = signal_window_hann_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_window_hann_point_scale(pt, 1.0 / n) }
}

pub fn signal_window_hann_point_negate(pt : SignalwindowhannPoint) -> SignalwindowhannPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_window_hann_point_mid(a : SignalwindowhannPoint, b : SignalwindowhannPoint) -> SignalwindowhannPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_window_hann_point_lerp(a : SignalwindowhannPoint, b : SignalwindowhannPoint, t : Double) -> SignalwindowhannPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_window_hann_point_to_string(pt : SignalwindowhannPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalwindowhannSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_hann_make_series(vals : Array[Double], name : String) -> SignalwindowhannSeries {
  { vals, name, meta: 0 }
}

pub fn signal_window_hann_series_len(s : SignalwindowhannSeries) -> Int { s.vals.length() }

pub fn signal_window_hann_series_sum(s : SignalwindowhannSeries) -> Double { @_common.sum(s.vals) }

pub fn signal_window_hann_series_mean(s : SignalwindowhannSeries) -> Double { @_common.mean(s.vals) }

pub fn signal_window_hann_series_min(s : SignalwindowhannSeries) -> Double { @_common.min(s.vals) }

pub fn signal_window_hann_series_max(s : SignalwindowhannSeries) -> Double { @_common.max(s.vals) }

pub fn signal_window_hann_series_range(s : SignalwindowhannSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn signal_window_hann_series_var(s : SignalwindowhannSeries) -> Double { @_common.variance(s.vals) }

pub fn signal_window_hann_series_std(s : SignalwindowhannSeries) -> Double { @_common.std(s.vals) }

pub fn signal_window_hann_series_median(s : SignalwindowhannSeries) -> Double { @_common.median(s.vals) }

pub fn signal_window_hann_series_scale(s : SignalwindowhannSeries, f : Double) -> SignalwindowhannSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_window_hann_series_add(a : SignalwindowhannSeries, b : SignalwindowhannSeries) -> SignalwindowhannSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_window_hann_series_sub(a : SignalwindowhannSeries, b : SignalwindowhannSeries) -> SignalwindowhannSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_window_hann_series_normalize(s : SignalwindowhannSeries) -> SignalwindowhannSeries {
  let mn = signal_window_hann_series_min(s)
  let mx = signal_window_hann_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_window_hann_series_cumsum(s : SignalwindowhannSeries) -> SignalwindowhannSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_window_hann_series_to_string(s : SignalwindowhannSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowhannMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_hann_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowhannMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_window_hann_matrix_identity(n : Int) -> SignalwindowhannMatrix {
  let m = signal_window_hann_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_window_hann_matrix_get(m : SignalwindowhannMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_window_hann_matrix_transpose(m : SignalwindowhannMatrix) -> SignalwindowhannMatrix {
  let result = signal_window_hann_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_window_hann_matrix_add(a : SignalwindowhannMatrix, b : SignalwindowhannMatrix) -> SignalwindowhannMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_window_hann_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_window_hann_matrix_scale(m : SignalwindowhannMatrix, s : Double) -> SignalwindowhannMatrix {
  let result = signal_window_hann_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_window_hann_matrix_multiply(a : SignalwindowhannMatrix, b : SignalwindowhannMatrix) -> SignalwindowhannMatrix {
  if a.cols != b.rows { return signal_window_hann_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_window_hann_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_window_hann_matrix_trace(m : SignalwindowhannMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_window_hann_matrix_det(m : SignalwindowhannMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_window_hann_matrix_norm(m : SignalwindowhannMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_window_hann_matrix_to_string(m : SignalwindowhannMatrix) -> String {
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

pub(all) struct SignalwindowhannVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_hann_make_vector(comps : Array[Double]) -> SignalwindowhannVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_hann_vector_zero(dim : Int) -> SignalwindowhannVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_window_hann_vector_add(a : SignalwindowhannVector, b : SignalwindowhannVector) -> SignalwindowhannVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_window_hann_vector_sub(a : SignalwindowhannVector, b : SignalwindowhannVector) -> SignalwindowhannVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_window_hann_vector_scale(v : SignalwindowhannVector, s : Double) -> SignalwindowhannVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_window_hann_vector_dot(a : SignalwindowhannVector, b : SignalwindowhannVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_window_hann_vector_norm(v : SignalwindowhannVector) -> Double { @_common.sqrt(signal_window_hann_vector_dot(v, v)) }

pub fn signal_window_hann_vector_normalize(v : SignalwindowhannVector) -> SignalwindowhannVector {
  let n = signal_window_hann_vector_norm(v)
  if n < 0.0000001 { v } else { signal_window_hann_vector_scale(v, 1.0 / n) }
}

pub fn signal_window_hann_vector_dist(a : SignalwindowhannVector, b : SignalwindowhannVector) -> Double {
  signal_window_hann_vector_norm(signal_window_hann_vector_sub(a, b))
}

pub fn signal_window_hann_vector_to_string(v : SignalwindowhannVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_window_hann_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_window_hann_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_window_hann_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_window_hann_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_window_hann_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_window_hann_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_window_hann_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_window_hann_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_window_hann_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_window_hann_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_window_hann_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_window_hann_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_window_hann_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_window_hann_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_window_hann_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_window_hann_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_window_hann_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_window_hann_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_window_hann_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_window_hann_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_window_hann_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_window_hann_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_window_hann_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_window_hann_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_window_hann_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_window_hann_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_window_hann_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_window_hann_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_window_hann_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalwindowhannFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_frame_make(size : Int) -> SignalwindowhannFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_frame_len(s : SignalwindowhannFrame) -> Int { s.size }

pub fn signal_window_hann_frame_get(s : SignalwindowhannFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_frame_set(s : SignalwindowhannFrame, i : Int, v : Double) -> SignalwindowhannFrame {
  let result = signal_window_hann_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_frame_sum(s : SignalwindowhannFrame) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_frame_mean(s : SignalwindowhannFrame) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_frame_scale(s : SignalwindowhannFrame, f : Double) -> SignalwindowhannFrame {
  let result = signal_window_hann_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_frame_add(a : SignalwindowhannFrame, b : SignalwindowhannFrame) -> SignalwindowhannFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_frame_copy(s : SignalwindowhannFrame) -> SignalwindowhannFrame {
  let result = signal_window_hann_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_frame_fill(s : SignalwindowhannFrame, v : Double) -> SignalwindowhannFrame {
  let result = signal_window_hann_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_frame_min(s : SignalwindowhannFrame) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_frame_max(s : SignalwindowhannFrame) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_frame_to_string(s : SignalwindowhannFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_table_make(size : Int) -> SignalwindowhannTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_table_len(s : SignalwindowhannTable) -> Int { s.size }

pub fn signal_window_hann_table_get(s : SignalwindowhannTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_table_set(s : SignalwindowhannTable, i : Int, v : Double) -> SignalwindowhannTable {
  let result = signal_window_hann_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_table_sum(s : SignalwindowhannTable) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_table_mean(s : SignalwindowhannTable) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_table_scale(s : SignalwindowhannTable, f : Double) -> SignalwindowhannTable {
  let result = signal_window_hann_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_table_add(a : SignalwindowhannTable, b : SignalwindowhannTable) -> SignalwindowhannTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_table_copy(s : SignalwindowhannTable) -> SignalwindowhannTable {
  let result = signal_window_hann_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_table_fill(s : SignalwindowhannTable, v : Double) -> SignalwindowhannTable {
  let result = signal_window_hann_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_table_min(s : SignalwindowhannTable) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_table_max(s : SignalwindowhannTable) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_table_to_string(s : SignalwindowhannTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_graphn_make(size : Int) -> SignalwindowhannGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_graphn_len(s : SignalwindowhannGraphN) -> Int { s.size }

pub fn signal_window_hann_graphn_get(s : SignalwindowhannGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_graphn_set(s : SignalwindowhannGraphN, i : Int, v : Double) -> SignalwindowhannGraphN {
  let result = signal_window_hann_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_graphn_sum(s : SignalwindowhannGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_graphn_mean(s : SignalwindowhannGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_graphn_scale(s : SignalwindowhannGraphN, f : Double) -> SignalwindowhannGraphN {
  let result = signal_window_hann_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_graphn_add(a : SignalwindowhannGraphN, b : SignalwindowhannGraphN) -> SignalwindowhannGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_graphn_copy(s : SignalwindowhannGraphN) -> SignalwindowhannGraphN {
  let result = signal_window_hann_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_graphn_fill(s : SignalwindowhannGraphN, v : Double) -> SignalwindowhannGraphN {
  let result = signal_window_hann_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_graphn_min(s : SignalwindowhannGraphN) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_graphn_max(s : SignalwindowhannGraphN) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_graphn_to_string(s : SignalwindowhannGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_node_make(size : Int) -> SignalwindowhannNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_node_len(s : SignalwindowhannNode) -> Int { s.size }

pub fn signal_window_hann_node_get(s : SignalwindowhannNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_node_set(s : SignalwindowhannNode, i : Int, v : Double) -> SignalwindowhannNode {
  let result = signal_window_hann_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_node_sum(s : SignalwindowhannNode) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_node_mean(s : SignalwindowhannNode) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_node_scale(s : SignalwindowhannNode, f : Double) -> SignalwindowhannNode {
  let result = signal_window_hann_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_node_add(a : SignalwindowhannNode, b : SignalwindowhannNode) -> SignalwindowhannNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_node_copy(s : SignalwindowhannNode) -> SignalwindowhannNode {
  let result = signal_window_hann_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_node_fill(s : SignalwindowhannNode, v : Double) -> SignalwindowhannNode {
  let result = signal_window_hann_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_node_min(s : SignalwindowhannNode) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_node_max(s : SignalwindowhannNode) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_node_to_string(s : SignalwindowhannNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_edge_make(size : Int) -> SignalwindowhannEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_edge_len(s : SignalwindowhannEdge) -> Int { s.size }

pub fn signal_window_hann_edge_get(s : SignalwindowhannEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_edge_set(s : SignalwindowhannEdge, i : Int, v : Double) -> SignalwindowhannEdge {
  let result = signal_window_hann_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_edge_sum(s : SignalwindowhannEdge) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_edge_mean(s : SignalwindowhannEdge) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_edge_scale(s : SignalwindowhannEdge, f : Double) -> SignalwindowhannEdge {
  let result = signal_window_hann_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_edge_add(a : SignalwindowhannEdge, b : SignalwindowhannEdge) -> SignalwindowhannEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_edge_copy(s : SignalwindowhannEdge) -> SignalwindowhannEdge {
  let result = signal_window_hann_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_edge_fill(s : SignalwindowhannEdge, v : Double) -> SignalwindowhannEdge {
  let result = signal_window_hann_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_edge_min(s : SignalwindowhannEdge) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_edge_max(s : SignalwindowhannEdge) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_edge_to_string(s : SignalwindowhannEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_path_make(size : Int) -> SignalwindowhannPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_path_len(s : SignalwindowhannPath) -> Int { s.size }

pub fn signal_window_hann_path_get(s : SignalwindowhannPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_path_set(s : SignalwindowhannPath, i : Int, v : Double) -> SignalwindowhannPath {
  let result = signal_window_hann_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_path_sum(s : SignalwindowhannPath) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_path_mean(s : SignalwindowhannPath) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_path_scale(s : SignalwindowhannPath, f : Double) -> SignalwindowhannPath {
  let result = signal_window_hann_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_path_add(a : SignalwindowhannPath, b : SignalwindowhannPath) -> SignalwindowhannPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_path_copy(s : SignalwindowhannPath) -> SignalwindowhannPath {
  let result = signal_window_hann_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_path_fill(s : SignalwindowhannPath, v : Double) -> SignalwindowhannPath {
  let result = signal_window_hann_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_path_min(s : SignalwindowhannPath) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_path_max(s : SignalwindowhannPath) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_path_to_string(s : SignalwindowhannPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_cluster_make(size : Int) -> SignalwindowhannCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_cluster_len(s : SignalwindowhannCluster) -> Int { s.size }

pub fn signal_window_hann_cluster_get(s : SignalwindowhannCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_cluster_set(s : SignalwindowhannCluster, i : Int, v : Double) -> SignalwindowhannCluster {
  let result = signal_window_hann_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_cluster_sum(s : SignalwindowhannCluster) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_cluster_mean(s : SignalwindowhannCluster) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_cluster_scale(s : SignalwindowhannCluster, f : Double) -> SignalwindowhannCluster {
  let result = signal_window_hann_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_cluster_add(a : SignalwindowhannCluster, b : SignalwindowhannCluster) -> SignalwindowhannCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_cluster_copy(s : SignalwindowhannCluster) -> SignalwindowhannCluster {
  let result = signal_window_hann_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_cluster_fill(s : SignalwindowhannCluster, v : Double) -> SignalwindowhannCluster {
  let result = signal_window_hann_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_cluster_min(s : SignalwindowhannCluster) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_cluster_max(s : SignalwindowhannCluster) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_cluster_to_string(s : SignalwindowhannCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_model_make(size : Int) -> SignalwindowhannModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_model_len(s : SignalwindowhannModel) -> Int { s.size }

pub fn signal_window_hann_model_get(s : SignalwindowhannModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_model_set(s : SignalwindowhannModel, i : Int, v : Double) -> SignalwindowhannModel {
  let result = signal_window_hann_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_model_sum(s : SignalwindowhannModel) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_model_mean(s : SignalwindowhannModel) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_model_scale(s : SignalwindowhannModel, f : Double) -> SignalwindowhannModel {
  let result = signal_window_hann_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_model_add(a : SignalwindowhannModel, b : SignalwindowhannModel) -> SignalwindowhannModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_model_copy(s : SignalwindowhannModel) -> SignalwindowhannModel {
  let result = signal_window_hann_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_model_fill(s : SignalwindowhannModel, v : Double) -> SignalwindowhannModel {
  let result = signal_window_hann_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_model_min(s : SignalwindowhannModel) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_model_max(s : SignalwindowhannModel) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_model_to_string(s : SignalwindowhannModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_layer_make(size : Int) -> SignalwindowhannLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_layer_len(s : SignalwindowhannLayer) -> Int { s.size }

pub fn signal_window_hann_layer_get(s : SignalwindowhannLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_layer_set(s : SignalwindowhannLayer, i : Int, v : Double) -> SignalwindowhannLayer {
  let result = signal_window_hann_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_layer_sum(s : SignalwindowhannLayer) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_layer_mean(s : SignalwindowhannLayer) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_layer_scale(s : SignalwindowhannLayer, f : Double) -> SignalwindowhannLayer {
  let result = signal_window_hann_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_layer_add(a : SignalwindowhannLayer, b : SignalwindowhannLayer) -> SignalwindowhannLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_layer_copy(s : SignalwindowhannLayer) -> SignalwindowhannLayer {
  let result = signal_window_hann_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_layer_fill(s : SignalwindowhannLayer, v : Double) -> SignalwindowhannLayer {
  let result = signal_window_hann_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_layer_min(s : SignalwindowhannLayer) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_layer_max(s : SignalwindowhannLayer) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_layer_to_string(s : SignalwindowhannLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_buffer_make(size : Int) -> SignalwindowhannBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_buffer_len(s : SignalwindowhannBuffer) -> Int { s.size }

pub fn signal_window_hann_buffer_get(s : SignalwindowhannBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_buffer_set(s : SignalwindowhannBuffer, i : Int, v : Double) -> SignalwindowhannBuffer {
  let result = signal_window_hann_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_buffer_sum(s : SignalwindowhannBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_buffer_mean(s : SignalwindowhannBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_buffer_scale(s : SignalwindowhannBuffer, f : Double) -> SignalwindowhannBuffer {
  let result = signal_window_hann_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_buffer_add(a : SignalwindowhannBuffer, b : SignalwindowhannBuffer) -> SignalwindowhannBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_buffer_copy(s : SignalwindowhannBuffer) -> SignalwindowhannBuffer {
  let result = signal_window_hann_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_buffer_fill(s : SignalwindowhannBuffer, v : Double) -> SignalwindowhannBuffer {
  let result = signal_window_hann_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_buffer_min(s : SignalwindowhannBuffer) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_buffer_max(s : SignalwindowhannBuffer) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_buffer_to_string(s : SignalwindowhannBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_cursor_make(size : Int) -> SignalwindowhannCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_cursor_len(s : SignalwindowhannCursor) -> Int { s.size }

pub fn signal_window_hann_cursor_get(s : SignalwindowhannCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_cursor_set(s : SignalwindowhannCursor, i : Int, v : Double) -> SignalwindowhannCursor {
  let result = signal_window_hann_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_cursor_sum(s : SignalwindowhannCursor) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_cursor_mean(s : SignalwindowhannCursor) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_cursor_scale(s : SignalwindowhannCursor, f : Double) -> SignalwindowhannCursor {
  let result = signal_window_hann_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_cursor_add(a : SignalwindowhannCursor, b : SignalwindowhannCursor) -> SignalwindowhannCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_cursor_copy(s : SignalwindowhannCursor) -> SignalwindowhannCursor {
  let result = signal_window_hann_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_cursor_fill(s : SignalwindowhannCursor, v : Double) -> SignalwindowhannCursor {
  let result = signal_window_hann_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_cursor_min(s : SignalwindowhannCursor) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_cursor_max(s : SignalwindowhannCursor) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_cursor_to_string(s : SignalwindowhannCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_view_make(size : Int) -> SignalwindowhannView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_view_len(s : SignalwindowhannView) -> Int { s.size }

pub fn signal_window_hann_view_get(s : SignalwindowhannView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_view_set(s : SignalwindowhannView, i : Int, v : Double) -> SignalwindowhannView {
  let result = signal_window_hann_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_view_sum(s : SignalwindowhannView) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_view_mean(s : SignalwindowhannView) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_view_scale(s : SignalwindowhannView, f : Double) -> SignalwindowhannView {
  let result = signal_window_hann_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_view_add(a : SignalwindowhannView, b : SignalwindowhannView) -> SignalwindowhannView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_view_copy(s : SignalwindowhannView) -> SignalwindowhannView {
  let result = signal_window_hann_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_view_fill(s : SignalwindowhannView, v : Double) -> SignalwindowhannView {
  let result = signal_window_hann_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_view_min(s : SignalwindowhannView) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_view_max(s : SignalwindowhannView) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_view_to_string(s : SignalwindowhannView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_range_make(size : Int) -> SignalwindowhannRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_range_len(s : SignalwindowhannRange) -> Int { s.size }

pub fn signal_window_hann_range_get(s : SignalwindowhannRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_range_set(s : SignalwindowhannRange, i : Int, v : Double) -> SignalwindowhannRange {
  let result = signal_window_hann_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_range_sum(s : SignalwindowhannRange) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_range_mean(s : SignalwindowhannRange) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_range_scale(s : SignalwindowhannRange, f : Double) -> SignalwindowhannRange {
  let result = signal_window_hann_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_range_add(a : SignalwindowhannRange, b : SignalwindowhannRange) -> SignalwindowhannRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_range_copy(s : SignalwindowhannRange) -> SignalwindowhannRange {
  let result = signal_window_hann_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_range_fill(s : SignalwindowhannRange, v : Double) -> SignalwindowhannRange {
  let result = signal_window_hann_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_range_min(s : SignalwindowhannRange) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_range_max(s : SignalwindowhannRange) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_range_to_string(s : SignalwindowhannRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_slice_make(size : Int) -> SignalwindowhannSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_slice_len(s : SignalwindowhannSlice) -> Int { s.size }

pub fn signal_window_hann_slice_get(s : SignalwindowhannSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_slice_set(s : SignalwindowhannSlice, i : Int, v : Double) -> SignalwindowhannSlice {
  let result = signal_window_hann_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_slice_sum(s : SignalwindowhannSlice) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_slice_mean(s : SignalwindowhannSlice) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_slice_scale(s : SignalwindowhannSlice, f : Double) -> SignalwindowhannSlice {
  let result = signal_window_hann_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_slice_add(a : SignalwindowhannSlice, b : SignalwindowhannSlice) -> SignalwindowhannSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_slice_copy(s : SignalwindowhannSlice) -> SignalwindowhannSlice {
  let result = signal_window_hann_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_slice_fill(s : SignalwindowhannSlice, v : Double) -> SignalwindowhannSlice {
  let result = signal_window_hann_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_slice_min(s : SignalwindowhannSlice) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_slice_max(s : SignalwindowhannSlice) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_slice_to_string(s : SignalwindowhannSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

