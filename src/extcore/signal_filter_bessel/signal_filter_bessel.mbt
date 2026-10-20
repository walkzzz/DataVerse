///===
/// extcore/signal_filter_bessel

pub(all) struct SignalfilterbesselPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_bessel_make_point(x : Double, y : Double) -> SignalfilterbesselPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_bessel_make_point3(x : Double, y : Double, z : Double) -> SignalfilterbesselPoint {
  { x, y, z, label: 0 }
}

pub fn signal_filter_bessel_point_x(pt : SignalfilterbesselPoint) -> Double { pt.x }

pub fn signal_filter_bessel_point_y(pt : SignalfilterbesselPoint) -> Double { pt.y }

pub fn signal_filter_bessel_point_z(pt : SignalfilterbesselPoint) -> Double { pt.z }

pub fn signal_filter_bessel_point_label(pt : SignalfilterbesselPoint) -> Int { pt.label }

pub fn signal_filter_bessel_point_dist(a : SignalfilterbesselPoint, b : SignalfilterbesselPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_filter_bessel_point_add(a : SignalfilterbesselPoint, b : SignalfilterbesselPoint) -> SignalfilterbesselPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_filter_bessel_point_sub(a : SignalfilterbesselPoint, b : SignalfilterbesselPoint) -> SignalfilterbesselPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_filter_bessel_point_scale(pt : SignalfilterbesselPoint, s : Double) -> SignalfilterbesselPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_filter_bessel_point_dot(a : SignalfilterbesselPoint, b : SignalfilterbesselPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_filter_bessel_point_cross(a : SignalfilterbesselPoint, b : SignalfilterbesselPoint) -> SignalfilterbesselPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_filter_bessel_point_norm(pt : SignalfilterbesselPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_filter_bessel_point_normalize(pt : SignalfilterbesselPoint) -> SignalfilterbesselPoint {
  let n = signal_filter_bessel_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_filter_bessel_point_scale(pt, 1.0 / n) }
}

pub fn signal_filter_bessel_point_negate(pt : SignalfilterbesselPoint) -> SignalfilterbesselPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_filter_bessel_point_mid(a : SignalfilterbesselPoint, b : SignalfilterbesselPoint) -> SignalfilterbesselPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_filter_bessel_point_lerp(a : SignalfilterbesselPoint, b : SignalfilterbesselPoint, t : Double) -> SignalfilterbesselPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_filter_bessel_point_to_string(pt : SignalfilterbesselPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalfilterbesselSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_bessel_make_series(vals : Array[Double], name : String) -> SignalfilterbesselSeries {
  { vals, name, meta: 0 }
}

pub fn signal_filter_bessel_series_len(s : SignalfilterbesselSeries) -> Int { s.vals.length() }

pub fn signal_filter_bessel_series_sum(s : SignalfilterbesselSeries) -> Double { @_common.sum(s.vals) }

pub fn signal_filter_bessel_series_mean(s : SignalfilterbesselSeries) -> Double { @_common.mean(s.vals) }

pub fn signal_filter_bessel_series_min(s : SignalfilterbesselSeries) -> Double { @_common.min(s.vals) }

pub fn signal_filter_bessel_series_max(s : SignalfilterbesselSeries) -> Double { @_common.max(s.vals) }

pub fn signal_filter_bessel_series_range(s : SignalfilterbesselSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn signal_filter_bessel_series_var(s : SignalfilterbesselSeries) -> Double { @_common.variance(s.vals) }

pub fn signal_filter_bessel_series_std(s : SignalfilterbesselSeries) -> Double { @_common.std(s.vals) }

pub fn signal_filter_bessel_series_median(s : SignalfilterbesselSeries) -> Double { @_common.median(s.vals) }

pub fn signal_filter_bessel_series_scale(s : SignalfilterbesselSeries, f : Double) -> SignalfilterbesselSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_filter_bessel_series_add(a : SignalfilterbesselSeries, b : SignalfilterbesselSeries) -> SignalfilterbesselSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_filter_bessel_series_sub(a : SignalfilterbesselSeries, b : SignalfilterbesselSeries) -> SignalfilterbesselSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_filter_bessel_series_normalize(s : SignalfilterbesselSeries) -> SignalfilterbesselSeries {
  let mn = signal_filter_bessel_series_min(s)
  let mx = signal_filter_bessel_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_filter_bessel_series_cumsum(s : SignalfilterbesselSeries) -> SignalfilterbesselSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_filter_bessel_series_to_string(s : SignalfilterbesselSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilterbesselMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_bessel_make_matrix(rows : Int, cols : Int, val : Double) -> SignalfilterbesselMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_bessel_matrix_identity(n : Int) -> SignalfilterbesselMatrix {
  let m = signal_filter_bessel_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_filter_bessel_matrix_get(m : SignalfilterbesselMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_filter_bessel_matrix_transpose(m : SignalfilterbesselMatrix) -> SignalfilterbesselMatrix {
  let result = signal_filter_bessel_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_filter_bessel_matrix_add(a : SignalfilterbesselMatrix, b : SignalfilterbesselMatrix) -> SignalfilterbesselMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_filter_bessel_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_filter_bessel_matrix_scale(m : SignalfilterbesselMatrix, s : Double) -> SignalfilterbesselMatrix {
  let result = signal_filter_bessel_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_filter_bessel_matrix_multiply(a : SignalfilterbesselMatrix, b : SignalfilterbesselMatrix) -> SignalfilterbesselMatrix {
  if a.cols != b.rows { return signal_filter_bessel_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_filter_bessel_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_filter_bessel_matrix_trace(m : SignalfilterbesselMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_filter_bessel_matrix_det(m : SignalfilterbesselMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_filter_bessel_matrix_norm(m : SignalfilterbesselMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_filter_bessel_matrix_to_string(m : SignalfilterbesselMatrix) -> String {
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

pub(all) struct SignalfilterbesselVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_bessel_make_vector(comps : Array[Double]) -> SignalfilterbesselVector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_bessel_vector_zero(dim : Int) -> SignalfilterbesselVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_filter_bessel_vector_add(a : SignalfilterbesselVector, b : SignalfilterbesselVector) -> SignalfilterbesselVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_filter_bessel_vector_sub(a : SignalfilterbesselVector, b : SignalfilterbesselVector) -> SignalfilterbesselVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_filter_bessel_vector_scale(v : SignalfilterbesselVector, s : Double) -> SignalfilterbesselVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_filter_bessel_vector_dot(a : SignalfilterbesselVector, b : SignalfilterbesselVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_filter_bessel_vector_norm(v : SignalfilterbesselVector) -> Double { @_common.sqrt(signal_filter_bessel_vector_dot(v, v)) }

pub fn signal_filter_bessel_vector_normalize(v : SignalfilterbesselVector) -> SignalfilterbesselVector {
  let n = signal_filter_bessel_vector_norm(v)
  if n < 0.0000001 { v } else { signal_filter_bessel_vector_scale(v, 1.0 / n) }
}

pub fn signal_filter_bessel_vector_dist(a : SignalfilterbesselVector, b : SignalfilterbesselVector) -> Double {
  signal_filter_bessel_vector_norm(signal_filter_bessel_vector_sub(a, b))
}

pub fn signal_filter_bessel_vector_to_string(v : SignalfilterbesselVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_filter_bessel_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_filter_bessel_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_filter_bessel_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_filter_bessel_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_filter_bessel_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_filter_bessel_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_filter_bessel_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_filter_bessel_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_filter_bessel_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_filter_bessel_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_filter_bessel_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_filter_bessel_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_filter_bessel_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_filter_bessel_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_filter_bessel_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_filter_bessel_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_filter_bessel_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_filter_bessel_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_filter_bessel_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_filter_bessel_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_filter_bessel_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_filter_bessel_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_filter_bessel_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_filter_bessel_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_filter_bessel_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_filter_bessel_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_filter_bessel_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_filter_bessel_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_filter_bessel_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalfilterbesselFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_frame_make(size : Int) -> SignalfilterbesselFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_frame_len(s : SignalfilterbesselFrame) -> Int { s.size }

pub fn signal_filter_bessel_frame_get(s : SignalfilterbesselFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_frame_set(s : SignalfilterbesselFrame, i : Int, v : Double) -> SignalfilterbesselFrame {
  let result = signal_filter_bessel_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_frame_sum(s : SignalfilterbesselFrame) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_frame_mean(s : SignalfilterbesselFrame) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_frame_scale(s : SignalfilterbesselFrame, f : Double) -> SignalfilterbesselFrame {
  let result = signal_filter_bessel_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_bessel_frame_add(a : SignalfilterbesselFrame, b : SignalfilterbesselFrame) -> SignalfilterbesselFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_bessel_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_bessel_frame_copy(s : SignalfilterbesselFrame) -> SignalfilterbesselFrame {
  let result = signal_filter_bessel_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_bessel_frame_fill(s : SignalfilterbesselFrame, v : Double) -> SignalfilterbesselFrame {
  let result = signal_filter_bessel_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_frame_min(s : SignalfilterbesselFrame) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_frame_max(s : SignalfilterbesselFrame) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_frame_to_string(s : SignalfilterbesselFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_table_make(size : Int) -> SignalfilterbesselTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_table_len(s : SignalfilterbesselTable) -> Int { s.size }

pub fn signal_filter_bessel_table_get(s : SignalfilterbesselTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_table_set(s : SignalfilterbesselTable, i : Int, v : Double) -> SignalfilterbesselTable {
  let result = signal_filter_bessel_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_table_sum(s : SignalfilterbesselTable) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_table_mean(s : SignalfilterbesselTable) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_table_scale(s : SignalfilterbesselTable, f : Double) -> SignalfilterbesselTable {
  let result = signal_filter_bessel_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_bessel_table_add(a : SignalfilterbesselTable, b : SignalfilterbesselTable) -> SignalfilterbesselTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_bessel_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_bessel_table_copy(s : SignalfilterbesselTable) -> SignalfilterbesselTable {
  let result = signal_filter_bessel_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_bessel_table_fill(s : SignalfilterbesselTable, v : Double) -> SignalfilterbesselTable {
  let result = signal_filter_bessel_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_table_min(s : SignalfilterbesselTable) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_table_max(s : SignalfilterbesselTable) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_table_to_string(s : SignalfilterbesselTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_graphn_make(size : Int) -> SignalfilterbesselGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_graphn_len(s : SignalfilterbesselGraphN) -> Int { s.size }

pub fn signal_filter_bessel_graphn_get(s : SignalfilterbesselGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_graphn_set(s : SignalfilterbesselGraphN, i : Int, v : Double) -> SignalfilterbesselGraphN {
  let result = signal_filter_bessel_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_graphn_sum(s : SignalfilterbesselGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_graphn_mean(s : SignalfilterbesselGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_graphn_scale(s : SignalfilterbesselGraphN, f : Double) -> SignalfilterbesselGraphN {
  let result = signal_filter_bessel_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_bessel_graphn_add(a : SignalfilterbesselGraphN, b : SignalfilterbesselGraphN) -> SignalfilterbesselGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_bessel_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_bessel_graphn_copy(s : SignalfilterbesselGraphN) -> SignalfilterbesselGraphN {
  let result = signal_filter_bessel_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_bessel_graphn_fill(s : SignalfilterbesselGraphN, v : Double) -> SignalfilterbesselGraphN {
  let result = signal_filter_bessel_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_graphn_min(s : SignalfilterbesselGraphN) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_graphn_max(s : SignalfilterbesselGraphN) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_graphn_to_string(s : SignalfilterbesselGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_node_make(size : Int) -> SignalfilterbesselNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_node_len(s : SignalfilterbesselNode) -> Int { s.size }

pub fn signal_filter_bessel_node_get(s : SignalfilterbesselNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_node_set(s : SignalfilterbesselNode, i : Int, v : Double) -> SignalfilterbesselNode {
  let result = signal_filter_bessel_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_node_sum(s : SignalfilterbesselNode) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_node_mean(s : SignalfilterbesselNode) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_node_scale(s : SignalfilterbesselNode, f : Double) -> SignalfilterbesselNode {
  let result = signal_filter_bessel_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_bessel_node_add(a : SignalfilterbesselNode, b : SignalfilterbesselNode) -> SignalfilterbesselNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_bessel_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_bessel_node_copy(s : SignalfilterbesselNode) -> SignalfilterbesselNode {
  let result = signal_filter_bessel_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_bessel_node_fill(s : SignalfilterbesselNode, v : Double) -> SignalfilterbesselNode {
  let result = signal_filter_bessel_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_node_min(s : SignalfilterbesselNode) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_node_max(s : SignalfilterbesselNode) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_node_to_string(s : SignalfilterbesselNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_edge_make(size : Int) -> SignalfilterbesselEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_edge_len(s : SignalfilterbesselEdge) -> Int { s.size }

pub fn signal_filter_bessel_edge_get(s : SignalfilterbesselEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_edge_set(s : SignalfilterbesselEdge, i : Int, v : Double) -> SignalfilterbesselEdge {
  let result = signal_filter_bessel_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_edge_sum(s : SignalfilterbesselEdge) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_edge_mean(s : SignalfilterbesselEdge) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_edge_scale(s : SignalfilterbesselEdge, f : Double) -> SignalfilterbesselEdge {
  let result = signal_filter_bessel_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_bessel_edge_add(a : SignalfilterbesselEdge, b : SignalfilterbesselEdge) -> SignalfilterbesselEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_bessel_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_bessel_edge_copy(s : SignalfilterbesselEdge) -> SignalfilterbesselEdge {
  let result = signal_filter_bessel_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_bessel_edge_fill(s : SignalfilterbesselEdge, v : Double) -> SignalfilterbesselEdge {
  let result = signal_filter_bessel_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_edge_min(s : SignalfilterbesselEdge) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_edge_max(s : SignalfilterbesselEdge) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_edge_to_string(s : SignalfilterbesselEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_path_make(size : Int) -> SignalfilterbesselPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_path_len(s : SignalfilterbesselPath) -> Int { s.size }

pub fn signal_filter_bessel_path_get(s : SignalfilterbesselPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_path_set(s : SignalfilterbesselPath, i : Int, v : Double) -> SignalfilterbesselPath {
  let result = signal_filter_bessel_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_path_sum(s : SignalfilterbesselPath) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_path_mean(s : SignalfilterbesselPath) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_path_scale(s : SignalfilterbesselPath, f : Double) -> SignalfilterbesselPath {
  let result = signal_filter_bessel_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_bessel_path_add(a : SignalfilterbesselPath, b : SignalfilterbesselPath) -> SignalfilterbesselPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_bessel_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_bessel_path_copy(s : SignalfilterbesselPath) -> SignalfilterbesselPath {
  let result = signal_filter_bessel_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_bessel_path_fill(s : SignalfilterbesselPath, v : Double) -> SignalfilterbesselPath {
  let result = signal_filter_bessel_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_path_min(s : SignalfilterbesselPath) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_path_max(s : SignalfilterbesselPath) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_path_to_string(s : SignalfilterbesselPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_cluster_make(size : Int) -> SignalfilterbesselCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_cluster_len(s : SignalfilterbesselCluster) -> Int { s.size }

pub fn signal_filter_bessel_cluster_get(s : SignalfilterbesselCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_cluster_set(s : SignalfilterbesselCluster, i : Int, v : Double) -> SignalfilterbesselCluster {
  let result = signal_filter_bessel_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_cluster_sum(s : SignalfilterbesselCluster) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_cluster_mean(s : SignalfilterbesselCluster) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_cluster_scale(s : SignalfilterbesselCluster, f : Double) -> SignalfilterbesselCluster {
  let result = signal_filter_bessel_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_bessel_cluster_add(a : SignalfilterbesselCluster, b : SignalfilterbesselCluster) -> SignalfilterbesselCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_bessel_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_bessel_cluster_copy(s : SignalfilterbesselCluster) -> SignalfilterbesselCluster {
  let result = signal_filter_bessel_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_bessel_cluster_fill(s : SignalfilterbesselCluster, v : Double) -> SignalfilterbesselCluster {
  let result = signal_filter_bessel_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_cluster_min(s : SignalfilterbesselCluster) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_cluster_max(s : SignalfilterbesselCluster) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_cluster_to_string(s : SignalfilterbesselCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_model_make(size : Int) -> SignalfilterbesselModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_model_len(s : SignalfilterbesselModel) -> Int { s.size }

pub fn signal_filter_bessel_model_get(s : SignalfilterbesselModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_model_set(s : SignalfilterbesselModel, i : Int, v : Double) -> SignalfilterbesselModel {
  let result = signal_filter_bessel_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_model_sum(s : SignalfilterbesselModel) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_model_mean(s : SignalfilterbesselModel) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_model_scale(s : SignalfilterbesselModel, f : Double) -> SignalfilterbesselModel {
  let result = signal_filter_bessel_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_bessel_model_add(a : SignalfilterbesselModel, b : SignalfilterbesselModel) -> SignalfilterbesselModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_bessel_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_bessel_model_copy(s : SignalfilterbesselModel) -> SignalfilterbesselModel {
  let result = signal_filter_bessel_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_bessel_model_fill(s : SignalfilterbesselModel, v : Double) -> SignalfilterbesselModel {
  let result = signal_filter_bessel_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_model_min(s : SignalfilterbesselModel) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_model_max(s : SignalfilterbesselModel) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_model_to_string(s : SignalfilterbesselModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_layer_make(size : Int) -> SignalfilterbesselLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_layer_len(s : SignalfilterbesselLayer) -> Int { s.size }

pub fn signal_filter_bessel_layer_get(s : SignalfilterbesselLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_layer_set(s : SignalfilterbesselLayer, i : Int, v : Double) -> SignalfilterbesselLayer {
  let result = signal_filter_bessel_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_layer_sum(s : SignalfilterbesselLayer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_layer_mean(s : SignalfilterbesselLayer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_layer_scale(s : SignalfilterbesselLayer, f : Double) -> SignalfilterbesselLayer {
  let result = signal_filter_bessel_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_bessel_layer_add(a : SignalfilterbesselLayer, b : SignalfilterbesselLayer) -> SignalfilterbesselLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_bessel_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_bessel_layer_copy(s : SignalfilterbesselLayer) -> SignalfilterbesselLayer {
  let result = signal_filter_bessel_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_bessel_layer_fill(s : SignalfilterbesselLayer, v : Double) -> SignalfilterbesselLayer {
  let result = signal_filter_bessel_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_layer_min(s : SignalfilterbesselLayer) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_layer_max(s : SignalfilterbesselLayer) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_layer_to_string(s : SignalfilterbesselLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_buffer_make(size : Int) -> SignalfilterbesselBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_buffer_len(s : SignalfilterbesselBuffer) -> Int { s.size }

pub fn signal_filter_bessel_buffer_get(s : SignalfilterbesselBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_buffer_set(s : SignalfilterbesselBuffer, i : Int, v : Double) -> SignalfilterbesselBuffer {
  let result = signal_filter_bessel_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_buffer_sum(s : SignalfilterbesselBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_buffer_mean(s : SignalfilterbesselBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_buffer_scale(s : SignalfilterbesselBuffer, f : Double) -> SignalfilterbesselBuffer {
  let result = signal_filter_bessel_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_bessel_buffer_add(a : SignalfilterbesselBuffer, b : SignalfilterbesselBuffer) -> SignalfilterbesselBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_bessel_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_bessel_buffer_copy(s : SignalfilterbesselBuffer) -> SignalfilterbesselBuffer {
  let result = signal_filter_bessel_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_bessel_buffer_fill(s : SignalfilterbesselBuffer, v : Double) -> SignalfilterbesselBuffer {
  let result = signal_filter_bessel_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_buffer_min(s : SignalfilterbesselBuffer) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_buffer_max(s : SignalfilterbesselBuffer) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_buffer_to_string(s : SignalfilterbesselBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_cursor_make(size : Int) -> SignalfilterbesselCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_cursor_len(s : SignalfilterbesselCursor) -> Int { s.size }

pub fn signal_filter_bessel_cursor_get(s : SignalfilterbesselCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_cursor_set(s : SignalfilterbesselCursor, i : Int, v : Double) -> SignalfilterbesselCursor {
  let result = signal_filter_bessel_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_cursor_sum(s : SignalfilterbesselCursor) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_cursor_mean(s : SignalfilterbesselCursor) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_cursor_scale(s : SignalfilterbesselCursor, f : Double) -> SignalfilterbesselCursor {
  let result = signal_filter_bessel_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_bessel_cursor_add(a : SignalfilterbesselCursor, b : SignalfilterbesselCursor) -> SignalfilterbesselCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_bessel_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_bessel_cursor_copy(s : SignalfilterbesselCursor) -> SignalfilterbesselCursor {
  let result = signal_filter_bessel_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_bessel_cursor_fill(s : SignalfilterbesselCursor, v : Double) -> SignalfilterbesselCursor {
  let result = signal_filter_bessel_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_cursor_min(s : SignalfilterbesselCursor) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_cursor_max(s : SignalfilterbesselCursor) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_cursor_to_string(s : SignalfilterbesselCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_view_make(size : Int) -> SignalfilterbesselView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_view_len(s : SignalfilterbesselView) -> Int { s.size }

pub fn signal_filter_bessel_view_get(s : SignalfilterbesselView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_view_set(s : SignalfilterbesselView, i : Int, v : Double) -> SignalfilterbesselView {
  let result = signal_filter_bessel_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_view_sum(s : SignalfilterbesselView) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_view_mean(s : SignalfilterbesselView) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_view_scale(s : SignalfilterbesselView, f : Double) -> SignalfilterbesselView {
  let result = signal_filter_bessel_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_bessel_view_add(a : SignalfilterbesselView, b : SignalfilterbesselView) -> SignalfilterbesselView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_bessel_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_bessel_view_copy(s : SignalfilterbesselView) -> SignalfilterbesselView {
  let result = signal_filter_bessel_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_bessel_view_fill(s : SignalfilterbesselView, v : Double) -> SignalfilterbesselView {
  let result = signal_filter_bessel_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_view_min(s : SignalfilterbesselView) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_view_max(s : SignalfilterbesselView) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_view_to_string(s : SignalfilterbesselView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_range_make(size : Int) -> SignalfilterbesselRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_range_len(s : SignalfilterbesselRange) -> Int { s.size }

pub fn signal_filter_bessel_range_get(s : SignalfilterbesselRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_range_set(s : SignalfilterbesselRange, i : Int, v : Double) -> SignalfilterbesselRange {
  let result = signal_filter_bessel_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_range_sum(s : SignalfilterbesselRange) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_range_mean(s : SignalfilterbesselRange) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_range_scale(s : SignalfilterbesselRange, f : Double) -> SignalfilterbesselRange {
  let result = signal_filter_bessel_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_bessel_range_add(a : SignalfilterbesselRange, b : SignalfilterbesselRange) -> SignalfilterbesselRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_bessel_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_bessel_range_copy(s : SignalfilterbesselRange) -> SignalfilterbesselRange {
  let result = signal_filter_bessel_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_bessel_range_fill(s : SignalfilterbesselRange, v : Double) -> SignalfilterbesselRange {
  let result = signal_filter_bessel_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_range_min(s : SignalfilterbesselRange) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_range_max(s : SignalfilterbesselRange) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_range_to_string(s : SignalfilterbesselRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_slice_make(size : Int) -> SignalfilterbesselSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_slice_len(s : SignalfilterbesselSlice) -> Int { s.size }

pub fn signal_filter_bessel_slice_get(s : SignalfilterbesselSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_slice_set(s : SignalfilterbesselSlice, i : Int, v : Double) -> SignalfilterbesselSlice {
  let result = signal_filter_bessel_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_slice_sum(s : SignalfilterbesselSlice) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_slice_mean(s : SignalfilterbesselSlice) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_slice_scale(s : SignalfilterbesselSlice, f : Double) -> SignalfilterbesselSlice {
  let result = signal_filter_bessel_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_bessel_slice_add(a : SignalfilterbesselSlice, b : SignalfilterbesselSlice) -> SignalfilterbesselSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_bessel_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_bessel_slice_copy(s : SignalfilterbesselSlice) -> SignalfilterbesselSlice {
  let result = signal_filter_bessel_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_bessel_slice_fill(s : SignalfilterbesselSlice, v : Double) -> SignalfilterbesselSlice {
  let result = signal_filter_bessel_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_bessel_slice_min(s : SignalfilterbesselSlice) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_slice_max(s : SignalfilterbesselSlice) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_slice_to_string(s : SignalfilterbesselSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

