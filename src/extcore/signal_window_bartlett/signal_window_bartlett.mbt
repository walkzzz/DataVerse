///===
/// extcore/signal_window_bartlett

pub(all) struct SignalwindowbartlettPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_bartlett_make_point(x : Double, y : Double) -> SignalwindowbartlettPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_bartlett_make_point3(x : Double, y : Double, z : Double) -> SignalwindowbartlettPoint {
  { x, y, z, label: 0 }
}

pub fn signal_window_bartlett_point_x(pt : SignalwindowbartlettPoint) -> Double { pt.x }

pub fn signal_window_bartlett_point_y(pt : SignalwindowbartlettPoint) -> Double { pt.y }

pub fn signal_window_bartlett_point_z(pt : SignalwindowbartlettPoint) -> Double { pt.z }

pub fn signal_window_bartlett_point_label(pt : SignalwindowbartlettPoint) -> Int { pt.label }

pub fn signal_window_bartlett_point_dist(a : SignalwindowbartlettPoint, b : SignalwindowbartlettPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_window_bartlett_point_add(a : SignalwindowbartlettPoint, b : SignalwindowbartlettPoint) -> SignalwindowbartlettPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_window_bartlett_point_sub(a : SignalwindowbartlettPoint, b : SignalwindowbartlettPoint) -> SignalwindowbartlettPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_window_bartlett_point_scale(pt : SignalwindowbartlettPoint, s : Double) -> SignalwindowbartlettPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_window_bartlett_point_dot(a : SignalwindowbartlettPoint, b : SignalwindowbartlettPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_window_bartlett_point_cross(a : SignalwindowbartlettPoint, b : SignalwindowbartlettPoint) -> SignalwindowbartlettPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_window_bartlett_point_norm(pt : SignalwindowbartlettPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_window_bartlett_point_normalize(pt : SignalwindowbartlettPoint) -> SignalwindowbartlettPoint {
  let n = signal_window_bartlett_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_window_bartlett_point_scale(pt, 1.0 / n) }
}

pub fn signal_window_bartlett_point_negate(pt : SignalwindowbartlettPoint) -> SignalwindowbartlettPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_window_bartlett_point_mid(a : SignalwindowbartlettPoint, b : SignalwindowbartlettPoint) -> SignalwindowbartlettPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_window_bartlett_point_lerp(a : SignalwindowbartlettPoint, b : SignalwindowbartlettPoint, t : Double) -> SignalwindowbartlettPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_window_bartlett_point_to_string(pt : SignalwindowbartlettPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalwindowbartlettSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_bartlett_make_series(vals : Array[Double], name : String) -> SignalwindowbartlettSeries {
  { vals, name, meta: 0 }
}

pub fn signal_window_bartlett_series_len(s : SignalwindowbartlettSeries) -> Int { s.vals.length() }

pub fn signal_window_bartlett_series_sum(s : SignalwindowbartlettSeries) -> Double { @_common.sum(s.vals) }

pub fn signal_window_bartlett_series_mean(s : SignalwindowbartlettSeries) -> Double { @_common.mean(s.vals) }

pub fn signal_window_bartlett_series_min(s : SignalwindowbartlettSeries) -> Double { @_common.min(s.vals) }

pub fn signal_window_bartlett_series_max(s : SignalwindowbartlettSeries) -> Double { @_common.max(s.vals) }

pub fn signal_window_bartlett_series_range(s : SignalwindowbartlettSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn signal_window_bartlett_series_var(s : SignalwindowbartlettSeries) -> Double { @_common.variance(s.vals) }

pub fn signal_window_bartlett_series_std(s : SignalwindowbartlettSeries) -> Double { @_common.std(s.vals) }

pub fn signal_window_bartlett_series_median(s : SignalwindowbartlettSeries) -> Double { @_common.median(s.vals) }

pub fn signal_window_bartlett_series_scale(s : SignalwindowbartlettSeries, f : Double) -> SignalwindowbartlettSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_window_bartlett_series_add(a : SignalwindowbartlettSeries, b : SignalwindowbartlettSeries) -> SignalwindowbartlettSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_window_bartlett_series_sub(a : SignalwindowbartlettSeries, b : SignalwindowbartlettSeries) -> SignalwindowbartlettSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_window_bartlett_series_normalize(s : SignalwindowbartlettSeries) -> SignalwindowbartlettSeries {
  let mn = signal_window_bartlett_series_min(s)
  let mx = signal_window_bartlett_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_window_bartlett_series_cumsum(s : SignalwindowbartlettSeries) -> SignalwindowbartlettSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_window_bartlett_series_to_string(s : SignalwindowbartlettSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowbartlettMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_bartlett_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowbartlettMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_window_bartlett_matrix_identity(n : Int) -> SignalwindowbartlettMatrix {
  let m = signal_window_bartlett_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_window_bartlett_matrix_get(m : SignalwindowbartlettMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_window_bartlett_matrix_transpose(m : SignalwindowbartlettMatrix) -> SignalwindowbartlettMatrix {
  let result = signal_window_bartlett_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_window_bartlett_matrix_add(a : SignalwindowbartlettMatrix, b : SignalwindowbartlettMatrix) -> SignalwindowbartlettMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_window_bartlett_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_window_bartlett_matrix_scale(m : SignalwindowbartlettMatrix, s : Double) -> SignalwindowbartlettMatrix {
  let result = signal_window_bartlett_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_window_bartlett_matrix_multiply(a : SignalwindowbartlettMatrix, b : SignalwindowbartlettMatrix) -> SignalwindowbartlettMatrix {
  if a.cols != b.rows { return signal_window_bartlett_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_window_bartlett_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_window_bartlett_matrix_trace(m : SignalwindowbartlettMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_window_bartlett_matrix_det(m : SignalwindowbartlettMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_window_bartlett_matrix_norm(m : SignalwindowbartlettMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_window_bartlett_matrix_to_string(m : SignalwindowbartlettMatrix) -> String {
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

pub(all) struct SignalwindowbartlettVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_bartlett_make_vector(comps : Array[Double]) -> SignalwindowbartlettVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_bartlett_vector_zero(dim : Int) -> SignalwindowbartlettVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_window_bartlett_vector_add(a : SignalwindowbartlettVector, b : SignalwindowbartlettVector) -> SignalwindowbartlettVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_window_bartlett_vector_sub(a : SignalwindowbartlettVector, b : SignalwindowbartlettVector) -> SignalwindowbartlettVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_window_bartlett_vector_scale(v : SignalwindowbartlettVector, s : Double) -> SignalwindowbartlettVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_window_bartlett_vector_dot(a : SignalwindowbartlettVector, b : SignalwindowbartlettVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_window_bartlett_vector_norm(v : SignalwindowbartlettVector) -> Double { @_common.sqrt(signal_window_bartlett_vector_dot(v, v)) }

pub fn signal_window_bartlett_vector_normalize(v : SignalwindowbartlettVector) -> SignalwindowbartlettVector {
  let n = signal_window_bartlett_vector_norm(v)
  if n < 0.0000001 { v } else { signal_window_bartlett_vector_scale(v, 1.0 / n) }
}

pub fn signal_window_bartlett_vector_dist(a : SignalwindowbartlettVector, b : SignalwindowbartlettVector) -> Double {
  signal_window_bartlett_vector_norm(signal_window_bartlett_vector_sub(a, b))
}

pub fn signal_window_bartlett_vector_to_string(v : SignalwindowbartlettVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_window_bartlett_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_window_bartlett_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_window_bartlett_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_window_bartlett_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_window_bartlett_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_window_bartlett_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_window_bartlett_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_window_bartlett_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_window_bartlett_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_window_bartlett_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_window_bartlett_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_window_bartlett_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_window_bartlett_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_window_bartlett_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_window_bartlett_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_window_bartlett_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_window_bartlett_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_window_bartlett_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_window_bartlett_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_window_bartlett_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_window_bartlett_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_window_bartlett_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_window_bartlett_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_window_bartlett_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_window_bartlett_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_window_bartlett_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_window_bartlett_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_window_bartlett_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_window_bartlett_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalwindowbartlettFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_frame_make(size : Int) -> SignalwindowbartlettFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_frame_len(s : SignalwindowbartlettFrame) -> Int { s.size }

pub fn signal_window_bartlett_frame_get(s : SignalwindowbartlettFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_frame_set(s : SignalwindowbartlettFrame, i : Int, v : Double) -> SignalwindowbartlettFrame {
  let result = signal_window_bartlett_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_frame_sum(s : SignalwindowbartlettFrame) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_frame_mean(s : SignalwindowbartlettFrame) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_frame_scale(s : SignalwindowbartlettFrame, f : Double) -> SignalwindowbartlettFrame {
  let result = signal_window_bartlett_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_bartlett_frame_add(a : SignalwindowbartlettFrame, b : SignalwindowbartlettFrame) -> SignalwindowbartlettFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_bartlett_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_bartlett_frame_copy(s : SignalwindowbartlettFrame) -> SignalwindowbartlettFrame {
  let result = signal_window_bartlett_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_bartlett_frame_fill(s : SignalwindowbartlettFrame, v : Double) -> SignalwindowbartlettFrame {
  let result = signal_window_bartlett_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_frame_min(s : SignalwindowbartlettFrame) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_frame_max(s : SignalwindowbartlettFrame) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_frame_to_string(s : SignalwindowbartlettFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_table_make(size : Int) -> SignalwindowbartlettTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_table_len(s : SignalwindowbartlettTable) -> Int { s.size }

pub fn signal_window_bartlett_table_get(s : SignalwindowbartlettTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_table_set(s : SignalwindowbartlettTable, i : Int, v : Double) -> SignalwindowbartlettTable {
  let result = signal_window_bartlett_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_table_sum(s : SignalwindowbartlettTable) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_table_mean(s : SignalwindowbartlettTable) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_table_scale(s : SignalwindowbartlettTable, f : Double) -> SignalwindowbartlettTable {
  let result = signal_window_bartlett_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_bartlett_table_add(a : SignalwindowbartlettTable, b : SignalwindowbartlettTable) -> SignalwindowbartlettTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_bartlett_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_bartlett_table_copy(s : SignalwindowbartlettTable) -> SignalwindowbartlettTable {
  let result = signal_window_bartlett_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_bartlett_table_fill(s : SignalwindowbartlettTable, v : Double) -> SignalwindowbartlettTable {
  let result = signal_window_bartlett_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_table_min(s : SignalwindowbartlettTable) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_table_max(s : SignalwindowbartlettTable) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_table_to_string(s : SignalwindowbartlettTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_graphn_make(size : Int) -> SignalwindowbartlettGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_graphn_len(s : SignalwindowbartlettGraphN) -> Int { s.size }

pub fn signal_window_bartlett_graphn_get(s : SignalwindowbartlettGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_graphn_set(s : SignalwindowbartlettGraphN, i : Int, v : Double) -> SignalwindowbartlettGraphN {
  let result = signal_window_bartlett_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_graphn_sum(s : SignalwindowbartlettGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_graphn_mean(s : SignalwindowbartlettGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_graphn_scale(s : SignalwindowbartlettGraphN, f : Double) -> SignalwindowbartlettGraphN {
  let result = signal_window_bartlett_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_bartlett_graphn_add(a : SignalwindowbartlettGraphN, b : SignalwindowbartlettGraphN) -> SignalwindowbartlettGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_bartlett_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_bartlett_graphn_copy(s : SignalwindowbartlettGraphN) -> SignalwindowbartlettGraphN {
  let result = signal_window_bartlett_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_bartlett_graphn_fill(s : SignalwindowbartlettGraphN, v : Double) -> SignalwindowbartlettGraphN {
  let result = signal_window_bartlett_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_graphn_min(s : SignalwindowbartlettGraphN) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_graphn_max(s : SignalwindowbartlettGraphN) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_graphn_to_string(s : SignalwindowbartlettGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_node_make(size : Int) -> SignalwindowbartlettNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_node_len(s : SignalwindowbartlettNode) -> Int { s.size }

pub fn signal_window_bartlett_node_get(s : SignalwindowbartlettNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_node_set(s : SignalwindowbartlettNode, i : Int, v : Double) -> SignalwindowbartlettNode {
  let result = signal_window_bartlett_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_node_sum(s : SignalwindowbartlettNode) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_node_mean(s : SignalwindowbartlettNode) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_node_scale(s : SignalwindowbartlettNode, f : Double) -> SignalwindowbartlettNode {
  let result = signal_window_bartlett_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_bartlett_node_add(a : SignalwindowbartlettNode, b : SignalwindowbartlettNode) -> SignalwindowbartlettNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_bartlett_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_bartlett_node_copy(s : SignalwindowbartlettNode) -> SignalwindowbartlettNode {
  let result = signal_window_bartlett_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_bartlett_node_fill(s : SignalwindowbartlettNode, v : Double) -> SignalwindowbartlettNode {
  let result = signal_window_bartlett_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_node_min(s : SignalwindowbartlettNode) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_node_max(s : SignalwindowbartlettNode) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_node_to_string(s : SignalwindowbartlettNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_edge_make(size : Int) -> SignalwindowbartlettEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_edge_len(s : SignalwindowbartlettEdge) -> Int { s.size }

pub fn signal_window_bartlett_edge_get(s : SignalwindowbartlettEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_edge_set(s : SignalwindowbartlettEdge, i : Int, v : Double) -> SignalwindowbartlettEdge {
  let result = signal_window_bartlett_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_edge_sum(s : SignalwindowbartlettEdge) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_edge_mean(s : SignalwindowbartlettEdge) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_edge_scale(s : SignalwindowbartlettEdge, f : Double) -> SignalwindowbartlettEdge {
  let result = signal_window_bartlett_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_bartlett_edge_add(a : SignalwindowbartlettEdge, b : SignalwindowbartlettEdge) -> SignalwindowbartlettEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_bartlett_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_bartlett_edge_copy(s : SignalwindowbartlettEdge) -> SignalwindowbartlettEdge {
  let result = signal_window_bartlett_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_bartlett_edge_fill(s : SignalwindowbartlettEdge, v : Double) -> SignalwindowbartlettEdge {
  let result = signal_window_bartlett_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_edge_min(s : SignalwindowbartlettEdge) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_edge_max(s : SignalwindowbartlettEdge) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_edge_to_string(s : SignalwindowbartlettEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_path_make(size : Int) -> SignalwindowbartlettPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_path_len(s : SignalwindowbartlettPath) -> Int { s.size }

pub fn signal_window_bartlett_path_get(s : SignalwindowbartlettPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_path_set(s : SignalwindowbartlettPath, i : Int, v : Double) -> SignalwindowbartlettPath {
  let result = signal_window_bartlett_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_path_sum(s : SignalwindowbartlettPath) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_path_mean(s : SignalwindowbartlettPath) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_path_scale(s : SignalwindowbartlettPath, f : Double) -> SignalwindowbartlettPath {
  let result = signal_window_bartlett_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_bartlett_path_add(a : SignalwindowbartlettPath, b : SignalwindowbartlettPath) -> SignalwindowbartlettPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_bartlett_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_bartlett_path_copy(s : SignalwindowbartlettPath) -> SignalwindowbartlettPath {
  let result = signal_window_bartlett_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_bartlett_path_fill(s : SignalwindowbartlettPath, v : Double) -> SignalwindowbartlettPath {
  let result = signal_window_bartlett_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_path_min(s : SignalwindowbartlettPath) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_path_max(s : SignalwindowbartlettPath) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_path_to_string(s : SignalwindowbartlettPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_cluster_make(size : Int) -> SignalwindowbartlettCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_cluster_len(s : SignalwindowbartlettCluster) -> Int { s.size }

pub fn signal_window_bartlett_cluster_get(s : SignalwindowbartlettCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_cluster_set(s : SignalwindowbartlettCluster, i : Int, v : Double) -> SignalwindowbartlettCluster {
  let result = signal_window_bartlett_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_cluster_sum(s : SignalwindowbartlettCluster) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_cluster_mean(s : SignalwindowbartlettCluster) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_cluster_scale(s : SignalwindowbartlettCluster, f : Double) -> SignalwindowbartlettCluster {
  let result = signal_window_bartlett_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_bartlett_cluster_add(a : SignalwindowbartlettCluster, b : SignalwindowbartlettCluster) -> SignalwindowbartlettCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_bartlett_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_bartlett_cluster_copy(s : SignalwindowbartlettCluster) -> SignalwindowbartlettCluster {
  let result = signal_window_bartlett_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_bartlett_cluster_fill(s : SignalwindowbartlettCluster, v : Double) -> SignalwindowbartlettCluster {
  let result = signal_window_bartlett_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_cluster_min(s : SignalwindowbartlettCluster) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_cluster_max(s : SignalwindowbartlettCluster) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_cluster_to_string(s : SignalwindowbartlettCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_model_make(size : Int) -> SignalwindowbartlettModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_model_len(s : SignalwindowbartlettModel) -> Int { s.size }

pub fn signal_window_bartlett_model_get(s : SignalwindowbartlettModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_model_set(s : SignalwindowbartlettModel, i : Int, v : Double) -> SignalwindowbartlettModel {
  let result = signal_window_bartlett_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_model_sum(s : SignalwindowbartlettModel) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_model_mean(s : SignalwindowbartlettModel) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_model_scale(s : SignalwindowbartlettModel, f : Double) -> SignalwindowbartlettModel {
  let result = signal_window_bartlett_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_bartlett_model_add(a : SignalwindowbartlettModel, b : SignalwindowbartlettModel) -> SignalwindowbartlettModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_bartlett_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_bartlett_model_copy(s : SignalwindowbartlettModel) -> SignalwindowbartlettModel {
  let result = signal_window_bartlett_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_bartlett_model_fill(s : SignalwindowbartlettModel, v : Double) -> SignalwindowbartlettModel {
  let result = signal_window_bartlett_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_model_min(s : SignalwindowbartlettModel) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_model_max(s : SignalwindowbartlettModel) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_model_to_string(s : SignalwindowbartlettModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_layer_make(size : Int) -> SignalwindowbartlettLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_layer_len(s : SignalwindowbartlettLayer) -> Int { s.size }

pub fn signal_window_bartlett_layer_get(s : SignalwindowbartlettLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_layer_set(s : SignalwindowbartlettLayer, i : Int, v : Double) -> SignalwindowbartlettLayer {
  let result = signal_window_bartlett_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_layer_sum(s : SignalwindowbartlettLayer) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_layer_mean(s : SignalwindowbartlettLayer) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_layer_scale(s : SignalwindowbartlettLayer, f : Double) -> SignalwindowbartlettLayer {
  let result = signal_window_bartlett_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_bartlett_layer_add(a : SignalwindowbartlettLayer, b : SignalwindowbartlettLayer) -> SignalwindowbartlettLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_bartlett_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_bartlett_layer_copy(s : SignalwindowbartlettLayer) -> SignalwindowbartlettLayer {
  let result = signal_window_bartlett_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_bartlett_layer_fill(s : SignalwindowbartlettLayer, v : Double) -> SignalwindowbartlettLayer {
  let result = signal_window_bartlett_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_layer_min(s : SignalwindowbartlettLayer) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_layer_max(s : SignalwindowbartlettLayer) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_layer_to_string(s : SignalwindowbartlettLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_buffer_make(size : Int) -> SignalwindowbartlettBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_buffer_len(s : SignalwindowbartlettBuffer) -> Int { s.size }

pub fn signal_window_bartlett_buffer_get(s : SignalwindowbartlettBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_buffer_set(s : SignalwindowbartlettBuffer, i : Int, v : Double) -> SignalwindowbartlettBuffer {
  let result = signal_window_bartlett_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_buffer_sum(s : SignalwindowbartlettBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_buffer_mean(s : SignalwindowbartlettBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_buffer_scale(s : SignalwindowbartlettBuffer, f : Double) -> SignalwindowbartlettBuffer {
  let result = signal_window_bartlett_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_bartlett_buffer_add(a : SignalwindowbartlettBuffer, b : SignalwindowbartlettBuffer) -> SignalwindowbartlettBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_bartlett_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_bartlett_buffer_copy(s : SignalwindowbartlettBuffer) -> SignalwindowbartlettBuffer {
  let result = signal_window_bartlett_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_bartlett_buffer_fill(s : SignalwindowbartlettBuffer, v : Double) -> SignalwindowbartlettBuffer {
  let result = signal_window_bartlett_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_buffer_min(s : SignalwindowbartlettBuffer) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_buffer_max(s : SignalwindowbartlettBuffer) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_buffer_to_string(s : SignalwindowbartlettBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_cursor_make(size : Int) -> SignalwindowbartlettCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_cursor_len(s : SignalwindowbartlettCursor) -> Int { s.size }

pub fn signal_window_bartlett_cursor_get(s : SignalwindowbartlettCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_cursor_set(s : SignalwindowbartlettCursor, i : Int, v : Double) -> SignalwindowbartlettCursor {
  let result = signal_window_bartlett_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_cursor_sum(s : SignalwindowbartlettCursor) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_cursor_mean(s : SignalwindowbartlettCursor) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_cursor_scale(s : SignalwindowbartlettCursor, f : Double) -> SignalwindowbartlettCursor {
  let result = signal_window_bartlett_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_bartlett_cursor_add(a : SignalwindowbartlettCursor, b : SignalwindowbartlettCursor) -> SignalwindowbartlettCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_bartlett_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_bartlett_cursor_copy(s : SignalwindowbartlettCursor) -> SignalwindowbartlettCursor {
  let result = signal_window_bartlett_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_bartlett_cursor_fill(s : SignalwindowbartlettCursor, v : Double) -> SignalwindowbartlettCursor {
  let result = signal_window_bartlett_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_cursor_min(s : SignalwindowbartlettCursor) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_cursor_max(s : SignalwindowbartlettCursor) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_cursor_to_string(s : SignalwindowbartlettCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_view_make(size : Int) -> SignalwindowbartlettView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_view_len(s : SignalwindowbartlettView) -> Int { s.size }

pub fn signal_window_bartlett_view_get(s : SignalwindowbartlettView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_view_set(s : SignalwindowbartlettView, i : Int, v : Double) -> SignalwindowbartlettView {
  let result = signal_window_bartlett_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_view_sum(s : SignalwindowbartlettView) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_view_mean(s : SignalwindowbartlettView) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_view_scale(s : SignalwindowbartlettView, f : Double) -> SignalwindowbartlettView {
  let result = signal_window_bartlett_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_bartlett_view_add(a : SignalwindowbartlettView, b : SignalwindowbartlettView) -> SignalwindowbartlettView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_bartlett_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_bartlett_view_copy(s : SignalwindowbartlettView) -> SignalwindowbartlettView {
  let result = signal_window_bartlett_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_bartlett_view_fill(s : SignalwindowbartlettView, v : Double) -> SignalwindowbartlettView {
  let result = signal_window_bartlett_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_view_min(s : SignalwindowbartlettView) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_view_max(s : SignalwindowbartlettView) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_view_to_string(s : SignalwindowbartlettView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_range_make(size : Int) -> SignalwindowbartlettRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_range_len(s : SignalwindowbartlettRange) -> Int { s.size }

pub fn signal_window_bartlett_range_get(s : SignalwindowbartlettRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_range_set(s : SignalwindowbartlettRange, i : Int, v : Double) -> SignalwindowbartlettRange {
  let result = signal_window_bartlett_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_range_sum(s : SignalwindowbartlettRange) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_range_mean(s : SignalwindowbartlettRange) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_range_scale(s : SignalwindowbartlettRange, f : Double) -> SignalwindowbartlettRange {
  let result = signal_window_bartlett_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_bartlett_range_add(a : SignalwindowbartlettRange, b : SignalwindowbartlettRange) -> SignalwindowbartlettRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_bartlett_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_bartlett_range_copy(s : SignalwindowbartlettRange) -> SignalwindowbartlettRange {
  let result = signal_window_bartlett_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_bartlett_range_fill(s : SignalwindowbartlettRange, v : Double) -> SignalwindowbartlettRange {
  let result = signal_window_bartlett_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_range_min(s : SignalwindowbartlettRange) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_range_max(s : SignalwindowbartlettRange) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_range_to_string(s : SignalwindowbartlettRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_slice_make(size : Int) -> SignalwindowbartlettSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_slice_len(s : SignalwindowbartlettSlice) -> Int { s.size }

pub fn signal_window_bartlett_slice_get(s : SignalwindowbartlettSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_slice_set(s : SignalwindowbartlettSlice, i : Int, v : Double) -> SignalwindowbartlettSlice {
  let result = signal_window_bartlett_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_slice_sum(s : SignalwindowbartlettSlice) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_slice_mean(s : SignalwindowbartlettSlice) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_slice_scale(s : SignalwindowbartlettSlice, f : Double) -> SignalwindowbartlettSlice {
  let result = signal_window_bartlett_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_bartlett_slice_add(a : SignalwindowbartlettSlice, b : SignalwindowbartlettSlice) -> SignalwindowbartlettSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_bartlett_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_bartlett_slice_copy(s : SignalwindowbartlettSlice) -> SignalwindowbartlettSlice {
  let result = signal_window_bartlett_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_bartlett_slice_fill(s : SignalwindowbartlettSlice, v : Double) -> SignalwindowbartlettSlice {
  let result = signal_window_bartlett_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_bartlett_slice_min(s : SignalwindowbartlettSlice) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_slice_max(s : SignalwindowbartlettSlice) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_slice_to_string(s : SignalwindowbartlettSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

