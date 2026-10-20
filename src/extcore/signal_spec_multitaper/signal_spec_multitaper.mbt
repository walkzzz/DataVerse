///===
/// extcore/signal_spec_multitaper

pub(all) struct SignalspecmultitaperPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_multitaper_make_point(x : Double, y : Double) -> SignalspecmultitaperPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_multitaper_make_point3(x : Double, y : Double, z : Double) -> SignalspecmultitaperPoint {
  { x, y, z, label: 0 }
}

pub fn signal_spec_multitaper_point_x(pt : SignalspecmultitaperPoint) -> Double { pt.x }

pub fn signal_spec_multitaper_point_y(pt : SignalspecmultitaperPoint) -> Double { pt.y }

pub fn signal_spec_multitaper_point_z(pt : SignalspecmultitaperPoint) -> Double { pt.z }

pub fn signal_spec_multitaper_point_label(pt : SignalspecmultitaperPoint) -> Int { pt.label }

pub fn signal_spec_multitaper_point_dist(a : SignalspecmultitaperPoint, b : SignalspecmultitaperPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_spec_multitaper_point_add(a : SignalspecmultitaperPoint, b : SignalspecmultitaperPoint) -> SignalspecmultitaperPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_spec_multitaper_point_sub(a : SignalspecmultitaperPoint, b : SignalspecmultitaperPoint) -> SignalspecmultitaperPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_spec_multitaper_point_scale(pt : SignalspecmultitaperPoint, s : Double) -> SignalspecmultitaperPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_spec_multitaper_point_dot(a : SignalspecmultitaperPoint, b : SignalspecmultitaperPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_spec_multitaper_point_cross(a : SignalspecmultitaperPoint, b : SignalspecmultitaperPoint) -> SignalspecmultitaperPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_spec_multitaper_point_norm(pt : SignalspecmultitaperPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_spec_multitaper_point_normalize(pt : SignalspecmultitaperPoint) -> SignalspecmultitaperPoint {
  let n = signal_spec_multitaper_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_spec_multitaper_point_scale(pt, 1.0 / n) }
}

pub fn signal_spec_multitaper_point_negate(pt : SignalspecmultitaperPoint) -> SignalspecmultitaperPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_spec_multitaper_point_mid(a : SignalspecmultitaperPoint, b : SignalspecmultitaperPoint) -> SignalspecmultitaperPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_spec_multitaper_point_lerp(a : SignalspecmultitaperPoint, b : SignalspecmultitaperPoint, t : Double) -> SignalspecmultitaperPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_spec_multitaper_point_to_string(pt : SignalspecmultitaperPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalspecmultitaperSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_multitaper_make_series(vals : Array[Double], name : String) -> SignalspecmultitaperSeries {
  { vals, name, meta: 0 }
}

pub fn signal_spec_multitaper_series_len(s : SignalspecmultitaperSeries) -> Int { s.vals.length() }

pub fn signal_spec_multitaper_series_sum(s : SignalspecmultitaperSeries) -> Double { @_common.sum(s.vals) }

pub fn signal_spec_multitaper_series_mean(s : SignalspecmultitaperSeries) -> Double { @_common.mean(s.vals) }

pub fn signal_spec_multitaper_series_min(s : SignalspecmultitaperSeries) -> Double { @_common.min(s.vals) }

pub fn signal_spec_multitaper_series_max(s : SignalspecmultitaperSeries) -> Double { @_common.max(s.vals) }

pub fn signal_spec_multitaper_series_range(s : SignalspecmultitaperSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn signal_spec_multitaper_series_var(s : SignalspecmultitaperSeries) -> Double { @_common.variance(s.vals) }

pub fn signal_spec_multitaper_series_std(s : SignalspecmultitaperSeries) -> Double { @_common.std(s.vals) }

pub fn signal_spec_multitaper_series_median(s : SignalspecmultitaperSeries) -> Double { @_common.median(s.vals) }

pub fn signal_spec_multitaper_series_scale(s : SignalspecmultitaperSeries, f : Double) -> SignalspecmultitaperSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_spec_multitaper_series_add(a : SignalspecmultitaperSeries, b : SignalspecmultitaperSeries) -> SignalspecmultitaperSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_spec_multitaper_series_sub(a : SignalspecmultitaperSeries, b : SignalspecmultitaperSeries) -> SignalspecmultitaperSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_spec_multitaper_series_normalize(s : SignalspecmultitaperSeries) -> SignalspecmultitaperSeries {
  let mn = signal_spec_multitaper_series_min(s)
  let mx = signal_spec_multitaper_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_spec_multitaper_series_cumsum(s : SignalspecmultitaperSeries) -> SignalspecmultitaperSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_spec_multitaper_series_to_string(s : SignalspecmultitaperSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecmultitaperMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_multitaper_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecmultitaperMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_multitaper_matrix_identity(n : Int) -> SignalspecmultitaperMatrix {
  let m = signal_spec_multitaper_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_spec_multitaper_matrix_get(m : SignalspecmultitaperMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_spec_multitaper_matrix_transpose(m : SignalspecmultitaperMatrix) -> SignalspecmultitaperMatrix {
  let result = signal_spec_multitaper_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_spec_multitaper_matrix_add(a : SignalspecmultitaperMatrix, b : SignalspecmultitaperMatrix) -> SignalspecmultitaperMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_spec_multitaper_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_spec_multitaper_matrix_scale(m : SignalspecmultitaperMatrix, s : Double) -> SignalspecmultitaperMatrix {
  let result = signal_spec_multitaper_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_spec_multitaper_matrix_multiply(a : SignalspecmultitaperMatrix, b : SignalspecmultitaperMatrix) -> SignalspecmultitaperMatrix {
  if a.cols != b.rows { return signal_spec_multitaper_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_spec_multitaper_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_spec_multitaper_matrix_trace(m : SignalspecmultitaperMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_spec_multitaper_matrix_det(m : SignalspecmultitaperMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_spec_multitaper_matrix_norm(m : SignalspecmultitaperMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_spec_multitaper_matrix_to_string(m : SignalspecmultitaperMatrix) -> String {
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

pub(all) struct SignalspecmultitaperVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_multitaper_make_vector(comps : Array[Double]) -> SignalspecmultitaperVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_multitaper_vector_zero(dim : Int) -> SignalspecmultitaperVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_spec_multitaper_vector_add(a : SignalspecmultitaperVector, b : SignalspecmultitaperVector) -> SignalspecmultitaperVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_spec_multitaper_vector_sub(a : SignalspecmultitaperVector, b : SignalspecmultitaperVector) -> SignalspecmultitaperVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_spec_multitaper_vector_scale(v : SignalspecmultitaperVector, s : Double) -> SignalspecmultitaperVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_spec_multitaper_vector_dot(a : SignalspecmultitaperVector, b : SignalspecmultitaperVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_spec_multitaper_vector_norm(v : SignalspecmultitaperVector) -> Double { @_common.sqrt(signal_spec_multitaper_vector_dot(v, v)) }

pub fn signal_spec_multitaper_vector_normalize(v : SignalspecmultitaperVector) -> SignalspecmultitaperVector {
  let n = signal_spec_multitaper_vector_norm(v)
  if n < 0.0000001 { v } else { signal_spec_multitaper_vector_scale(v, 1.0 / n) }
}

pub fn signal_spec_multitaper_vector_dist(a : SignalspecmultitaperVector, b : SignalspecmultitaperVector) -> Double {
  signal_spec_multitaper_vector_norm(signal_spec_multitaper_vector_sub(a, b))
}

pub fn signal_spec_multitaper_vector_to_string(v : SignalspecmultitaperVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_spec_multitaper_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_spec_multitaper_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_spec_multitaper_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_spec_multitaper_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_spec_multitaper_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_spec_multitaper_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_spec_multitaper_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_spec_multitaper_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_spec_multitaper_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_spec_multitaper_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_spec_multitaper_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_spec_multitaper_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_spec_multitaper_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_spec_multitaper_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_spec_multitaper_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_spec_multitaper_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_spec_multitaper_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_spec_multitaper_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_spec_multitaper_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_spec_multitaper_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_spec_multitaper_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_spec_multitaper_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_spec_multitaper_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_spec_multitaper_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_spec_multitaper_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_spec_multitaper_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_spec_multitaper_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_spec_multitaper_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_spec_multitaper_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalspecmultitaperFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_frame_make(size : Int) -> SignalspecmultitaperFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_frame_len(s : SignalspecmultitaperFrame) -> Int { s.size }

pub fn signal_spec_multitaper_frame_get(s : SignalspecmultitaperFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_frame_set(s : SignalspecmultitaperFrame, i : Int, v : Double) -> SignalspecmultitaperFrame {
  let result = signal_spec_multitaper_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_frame_sum(s : SignalspecmultitaperFrame) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_frame_mean(s : SignalspecmultitaperFrame) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_frame_scale(s : SignalspecmultitaperFrame, f : Double) -> SignalspecmultitaperFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_frame_add(a : SignalspecmultitaperFrame, b : SignalspecmultitaperFrame) -> SignalspecmultitaperFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_frame_copy(s : SignalspecmultitaperFrame) -> SignalspecmultitaperFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_frame_fill(s : SignalspecmultitaperFrame, v : Double) -> SignalspecmultitaperFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_frame_min(s : SignalspecmultitaperFrame) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_frame_max(s : SignalspecmultitaperFrame) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_frame_to_string(s : SignalspecmultitaperFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_table_make(size : Int) -> SignalspecmultitaperTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_table_len(s : SignalspecmultitaperTable) -> Int { s.size }

pub fn signal_spec_multitaper_table_get(s : SignalspecmultitaperTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_table_set(s : SignalspecmultitaperTable, i : Int, v : Double) -> SignalspecmultitaperTable {
  let result = signal_spec_multitaper_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_table_sum(s : SignalspecmultitaperTable) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_table_mean(s : SignalspecmultitaperTable) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_table_scale(s : SignalspecmultitaperTable, f : Double) -> SignalspecmultitaperTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_table_add(a : SignalspecmultitaperTable, b : SignalspecmultitaperTable) -> SignalspecmultitaperTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_table_copy(s : SignalspecmultitaperTable) -> SignalspecmultitaperTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_table_fill(s : SignalspecmultitaperTable, v : Double) -> SignalspecmultitaperTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_table_min(s : SignalspecmultitaperTable) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_table_max(s : SignalspecmultitaperTable) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_table_to_string(s : SignalspecmultitaperTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_graphn_make(size : Int) -> SignalspecmultitaperGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_graphn_len(s : SignalspecmultitaperGraphN) -> Int { s.size }

pub fn signal_spec_multitaper_graphn_get(s : SignalspecmultitaperGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_graphn_set(s : SignalspecmultitaperGraphN, i : Int, v : Double) -> SignalspecmultitaperGraphN {
  let result = signal_spec_multitaper_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_graphn_sum(s : SignalspecmultitaperGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_graphn_mean(s : SignalspecmultitaperGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_graphn_scale(s : SignalspecmultitaperGraphN, f : Double) -> SignalspecmultitaperGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_graphn_add(a : SignalspecmultitaperGraphN, b : SignalspecmultitaperGraphN) -> SignalspecmultitaperGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_graphn_copy(s : SignalspecmultitaperGraphN) -> SignalspecmultitaperGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_graphn_fill(s : SignalspecmultitaperGraphN, v : Double) -> SignalspecmultitaperGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_graphn_min(s : SignalspecmultitaperGraphN) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_graphn_max(s : SignalspecmultitaperGraphN) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_graphn_to_string(s : SignalspecmultitaperGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_node_make(size : Int) -> SignalspecmultitaperNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_node_len(s : SignalspecmultitaperNode) -> Int { s.size }

pub fn signal_spec_multitaper_node_get(s : SignalspecmultitaperNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_node_set(s : SignalspecmultitaperNode, i : Int, v : Double) -> SignalspecmultitaperNode {
  let result = signal_spec_multitaper_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_node_sum(s : SignalspecmultitaperNode) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_node_mean(s : SignalspecmultitaperNode) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_node_scale(s : SignalspecmultitaperNode, f : Double) -> SignalspecmultitaperNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_node_add(a : SignalspecmultitaperNode, b : SignalspecmultitaperNode) -> SignalspecmultitaperNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_node_copy(s : SignalspecmultitaperNode) -> SignalspecmultitaperNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_node_fill(s : SignalspecmultitaperNode, v : Double) -> SignalspecmultitaperNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_node_min(s : SignalspecmultitaperNode) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_node_max(s : SignalspecmultitaperNode) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_node_to_string(s : SignalspecmultitaperNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_edge_make(size : Int) -> SignalspecmultitaperEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_edge_len(s : SignalspecmultitaperEdge) -> Int { s.size }

pub fn signal_spec_multitaper_edge_get(s : SignalspecmultitaperEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_edge_set(s : SignalspecmultitaperEdge, i : Int, v : Double) -> SignalspecmultitaperEdge {
  let result = signal_spec_multitaper_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_edge_sum(s : SignalspecmultitaperEdge) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_edge_mean(s : SignalspecmultitaperEdge) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_edge_scale(s : SignalspecmultitaperEdge, f : Double) -> SignalspecmultitaperEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_edge_add(a : SignalspecmultitaperEdge, b : SignalspecmultitaperEdge) -> SignalspecmultitaperEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_edge_copy(s : SignalspecmultitaperEdge) -> SignalspecmultitaperEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_edge_fill(s : SignalspecmultitaperEdge, v : Double) -> SignalspecmultitaperEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_edge_min(s : SignalspecmultitaperEdge) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_edge_max(s : SignalspecmultitaperEdge) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_edge_to_string(s : SignalspecmultitaperEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_path_make(size : Int) -> SignalspecmultitaperPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_path_len(s : SignalspecmultitaperPath) -> Int { s.size }

pub fn signal_spec_multitaper_path_get(s : SignalspecmultitaperPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_path_set(s : SignalspecmultitaperPath, i : Int, v : Double) -> SignalspecmultitaperPath {
  let result = signal_spec_multitaper_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_path_sum(s : SignalspecmultitaperPath) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_path_mean(s : SignalspecmultitaperPath) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_path_scale(s : SignalspecmultitaperPath, f : Double) -> SignalspecmultitaperPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_path_add(a : SignalspecmultitaperPath, b : SignalspecmultitaperPath) -> SignalspecmultitaperPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_path_copy(s : SignalspecmultitaperPath) -> SignalspecmultitaperPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_path_fill(s : SignalspecmultitaperPath, v : Double) -> SignalspecmultitaperPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_path_min(s : SignalspecmultitaperPath) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_path_max(s : SignalspecmultitaperPath) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_path_to_string(s : SignalspecmultitaperPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_cluster_make(size : Int) -> SignalspecmultitaperCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_cluster_len(s : SignalspecmultitaperCluster) -> Int { s.size }

pub fn signal_spec_multitaper_cluster_get(s : SignalspecmultitaperCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_cluster_set(s : SignalspecmultitaperCluster, i : Int, v : Double) -> SignalspecmultitaperCluster {
  let result = signal_spec_multitaper_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_cluster_sum(s : SignalspecmultitaperCluster) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_cluster_mean(s : SignalspecmultitaperCluster) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_cluster_scale(s : SignalspecmultitaperCluster, f : Double) -> SignalspecmultitaperCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_cluster_add(a : SignalspecmultitaperCluster, b : SignalspecmultitaperCluster) -> SignalspecmultitaperCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_cluster_copy(s : SignalspecmultitaperCluster) -> SignalspecmultitaperCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_cluster_fill(s : SignalspecmultitaperCluster, v : Double) -> SignalspecmultitaperCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_cluster_min(s : SignalspecmultitaperCluster) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_cluster_max(s : SignalspecmultitaperCluster) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_cluster_to_string(s : SignalspecmultitaperCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_model_make(size : Int) -> SignalspecmultitaperModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_model_len(s : SignalspecmultitaperModel) -> Int { s.size }

pub fn signal_spec_multitaper_model_get(s : SignalspecmultitaperModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_model_set(s : SignalspecmultitaperModel, i : Int, v : Double) -> SignalspecmultitaperModel {
  let result = signal_spec_multitaper_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_model_sum(s : SignalspecmultitaperModel) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_model_mean(s : SignalspecmultitaperModel) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_model_scale(s : SignalspecmultitaperModel, f : Double) -> SignalspecmultitaperModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_model_add(a : SignalspecmultitaperModel, b : SignalspecmultitaperModel) -> SignalspecmultitaperModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_model_copy(s : SignalspecmultitaperModel) -> SignalspecmultitaperModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_model_fill(s : SignalspecmultitaperModel, v : Double) -> SignalspecmultitaperModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_model_min(s : SignalspecmultitaperModel) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_model_max(s : SignalspecmultitaperModel) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_model_to_string(s : SignalspecmultitaperModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_layer_make(size : Int) -> SignalspecmultitaperLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_layer_len(s : SignalspecmultitaperLayer) -> Int { s.size }

pub fn signal_spec_multitaper_layer_get(s : SignalspecmultitaperLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_layer_set(s : SignalspecmultitaperLayer, i : Int, v : Double) -> SignalspecmultitaperLayer {
  let result = signal_spec_multitaper_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_layer_sum(s : SignalspecmultitaperLayer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_layer_mean(s : SignalspecmultitaperLayer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_layer_scale(s : SignalspecmultitaperLayer, f : Double) -> SignalspecmultitaperLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_layer_add(a : SignalspecmultitaperLayer, b : SignalspecmultitaperLayer) -> SignalspecmultitaperLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_layer_copy(s : SignalspecmultitaperLayer) -> SignalspecmultitaperLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_layer_fill(s : SignalspecmultitaperLayer, v : Double) -> SignalspecmultitaperLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_layer_min(s : SignalspecmultitaperLayer) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_layer_max(s : SignalspecmultitaperLayer) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_layer_to_string(s : SignalspecmultitaperLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_buffer_make(size : Int) -> SignalspecmultitaperBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_buffer_len(s : SignalspecmultitaperBuffer) -> Int { s.size }

pub fn signal_spec_multitaper_buffer_get(s : SignalspecmultitaperBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_buffer_set(s : SignalspecmultitaperBuffer, i : Int, v : Double) -> SignalspecmultitaperBuffer {
  let result = signal_spec_multitaper_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_buffer_sum(s : SignalspecmultitaperBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_buffer_mean(s : SignalspecmultitaperBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_buffer_scale(s : SignalspecmultitaperBuffer, f : Double) -> SignalspecmultitaperBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_buffer_add(a : SignalspecmultitaperBuffer, b : SignalspecmultitaperBuffer) -> SignalspecmultitaperBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_buffer_copy(s : SignalspecmultitaperBuffer) -> SignalspecmultitaperBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_buffer_fill(s : SignalspecmultitaperBuffer, v : Double) -> SignalspecmultitaperBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_buffer_min(s : SignalspecmultitaperBuffer) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_buffer_max(s : SignalspecmultitaperBuffer) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_buffer_to_string(s : SignalspecmultitaperBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_cursor_make(size : Int) -> SignalspecmultitaperCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_cursor_len(s : SignalspecmultitaperCursor) -> Int { s.size }

pub fn signal_spec_multitaper_cursor_get(s : SignalspecmultitaperCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_cursor_set(s : SignalspecmultitaperCursor, i : Int, v : Double) -> SignalspecmultitaperCursor {
  let result = signal_spec_multitaper_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_cursor_sum(s : SignalspecmultitaperCursor) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_cursor_mean(s : SignalspecmultitaperCursor) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_cursor_scale(s : SignalspecmultitaperCursor, f : Double) -> SignalspecmultitaperCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_cursor_add(a : SignalspecmultitaperCursor, b : SignalspecmultitaperCursor) -> SignalspecmultitaperCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_cursor_copy(s : SignalspecmultitaperCursor) -> SignalspecmultitaperCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_cursor_fill(s : SignalspecmultitaperCursor, v : Double) -> SignalspecmultitaperCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_cursor_min(s : SignalspecmultitaperCursor) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_cursor_max(s : SignalspecmultitaperCursor) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_cursor_to_string(s : SignalspecmultitaperCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_view_make(size : Int) -> SignalspecmultitaperView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_view_len(s : SignalspecmultitaperView) -> Int { s.size }

pub fn signal_spec_multitaper_view_get(s : SignalspecmultitaperView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_view_set(s : SignalspecmultitaperView, i : Int, v : Double) -> SignalspecmultitaperView {
  let result = signal_spec_multitaper_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_view_sum(s : SignalspecmultitaperView) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_view_mean(s : SignalspecmultitaperView) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_view_scale(s : SignalspecmultitaperView, f : Double) -> SignalspecmultitaperView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_view_add(a : SignalspecmultitaperView, b : SignalspecmultitaperView) -> SignalspecmultitaperView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_view_copy(s : SignalspecmultitaperView) -> SignalspecmultitaperView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_view_fill(s : SignalspecmultitaperView, v : Double) -> SignalspecmultitaperView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_view_min(s : SignalspecmultitaperView) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_view_max(s : SignalspecmultitaperView) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_view_to_string(s : SignalspecmultitaperView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_range_make(size : Int) -> SignalspecmultitaperRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_range_len(s : SignalspecmultitaperRange) -> Int { s.size }

pub fn signal_spec_multitaper_range_get(s : SignalspecmultitaperRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_range_set(s : SignalspecmultitaperRange, i : Int, v : Double) -> SignalspecmultitaperRange {
  let result = signal_spec_multitaper_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_range_sum(s : SignalspecmultitaperRange) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_range_mean(s : SignalspecmultitaperRange) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_range_scale(s : SignalspecmultitaperRange, f : Double) -> SignalspecmultitaperRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_range_add(a : SignalspecmultitaperRange, b : SignalspecmultitaperRange) -> SignalspecmultitaperRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_range_copy(s : SignalspecmultitaperRange) -> SignalspecmultitaperRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_range_fill(s : SignalspecmultitaperRange, v : Double) -> SignalspecmultitaperRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_range_min(s : SignalspecmultitaperRange) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_range_max(s : SignalspecmultitaperRange) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_range_to_string(s : SignalspecmultitaperRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_slice_make(size : Int) -> SignalspecmultitaperSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_slice_len(s : SignalspecmultitaperSlice) -> Int { s.size }

pub fn signal_spec_multitaper_slice_get(s : SignalspecmultitaperSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_slice_set(s : SignalspecmultitaperSlice, i : Int, v : Double) -> SignalspecmultitaperSlice {
  let result = signal_spec_multitaper_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_multitaper_slice_sum(s : SignalspecmultitaperSlice) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_slice_mean(s : SignalspecmultitaperSlice) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_slice_scale(s : SignalspecmultitaperSlice, f : Double) -> SignalspecmultitaperSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_slice_add(a : SignalspecmultitaperSlice, b : SignalspecmultitaperSlice) -> SignalspecmultitaperSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_slice_copy(s : SignalspecmultitaperSlice) -> SignalspecmultitaperSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_slice_fill(s : SignalspecmultitaperSlice, v : Double) -> SignalspecmultitaperSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_slice_min(s : SignalspecmultitaperSlice) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_slice_max(s : SignalspecmultitaperSlice) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_slice_to_string(s : SignalspecmultitaperSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

