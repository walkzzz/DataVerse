///===
/// extcore/signal_spec_modified

pub(all) struct SignalspecmodifiedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_modified_make_point(x : Double, y : Double) -> SignalspecmodifiedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_modified_make_point3(x : Double, y : Double, z : Double) -> SignalspecmodifiedPoint {
  { x, y, z, label: 0 }
}

pub fn signal_spec_modified_point_x(pt : SignalspecmodifiedPoint) -> Double { pt.x }

pub fn signal_spec_modified_point_y(pt : SignalspecmodifiedPoint) -> Double { pt.y }

pub fn signal_spec_modified_point_z(pt : SignalspecmodifiedPoint) -> Double { pt.z }

pub fn signal_spec_modified_point_label(pt : SignalspecmodifiedPoint) -> Int { pt.label }

pub fn signal_spec_modified_point_dist(a : SignalspecmodifiedPoint, b : SignalspecmodifiedPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_spec_modified_point_add(a : SignalspecmodifiedPoint, b : SignalspecmodifiedPoint) -> SignalspecmodifiedPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_spec_modified_point_sub(a : SignalspecmodifiedPoint, b : SignalspecmodifiedPoint) -> SignalspecmodifiedPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_spec_modified_point_scale(pt : SignalspecmodifiedPoint, s : Double) -> SignalspecmodifiedPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_spec_modified_point_dot(a : SignalspecmodifiedPoint, b : SignalspecmodifiedPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_spec_modified_point_cross(a : SignalspecmodifiedPoint, b : SignalspecmodifiedPoint) -> SignalspecmodifiedPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_spec_modified_point_norm(pt : SignalspecmodifiedPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_spec_modified_point_normalize(pt : SignalspecmodifiedPoint) -> SignalspecmodifiedPoint {
  let n = signal_spec_modified_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_spec_modified_point_scale(pt, 1.0 / n) }
}

pub fn signal_spec_modified_point_negate(pt : SignalspecmodifiedPoint) -> SignalspecmodifiedPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_spec_modified_point_mid(a : SignalspecmodifiedPoint, b : SignalspecmodifiedPoint) -> SignalspecmodifiedPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_spec_modified_point_lerp(a : SignalspecmodifiedPoint, b : SignalspecmodifiedPoint, t : Double) -> SignalspecmodifiedPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_spec_modified_point_to_string(pt : SignalspecmodifiedPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalspecmodifiedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_modified_make_series(vals : Array[Double], name : String) -> SignalspecmodifiedSeries {
  { vals, name, meta: 0 }
}

pub fn signal_spec_modified_series_len(s : SignalspecmodifiedSeries) -> Int { s.vals.length() }

pub fn signal_spec_modified_series_sum(s : SignalspecmodifiedSeries) -> Double { @_common.sum(s.vals) }

pub fn signal_spec_modified_series_mean(s : SignalspecmodifiedSeries) -> Double { @_common.mean(s.vals) }

pub fn signal_spec_modified_series_min(s : SignalspecmodifiedSeries) -> Double { @_common.min(s.vals) }

pub fn signal_spec_modified_series_max(s : SignalspecmodifiedSeries) -> Double { @_common.max(s.vals) }

pub fn signal_spec_modified_series_range(s : SignalspecmodifiedSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn signal_spec_modified_series_var(s : SignalspecmodifiedSeries) -> Double { @_common.variance(s.vals) }

pub fn signal_spec_modified_series_std(s : SignalspecmodifiedSeries) -> Double { @_common.std(s.vals) }

pub fn signal_spec_modified_series_median(s : SignalspecmodifiedSeries) -> Double { @_common.median(s.vals) }

pub fn signal_spec_modified_series_scale(s : SignalspecmodifiedSeries, f : Double) -> SignalspecmodifiedSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_spec_modified_series_add(a : SignalspecmodifiedSeries, b : SignalspecmodifiedSeries) -> SignalspecmodifiedSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_spec_modified_series_sub(a : SignalspecmodifiedSeries, b : SignalspecmodifiedSeries) -> SignalspecmodifiedSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_spec_modified_series_normalize(s : SignalspecmodifiedSeries) -> SignalspecmodifiedSeries {
  let mn = signal_spec_modified_series_min(s)
  let mx = signal_spec_modified_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_spec_modified_series_cumsum(s : SignalspecmodifiedSeries) -> SignalspecmodifiedSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_spec_modified_series_to_string(s : SignalspecmodifiedSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecmodifiedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_modified_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecmodifiedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_modified_matrix_identity(n : Int) -> SignalspecmodifiedMatrix {
  let m = signal_spec_modified_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_spec_modified_matrix_get(m : SignalspecmodifiedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_spec_modified_matrix_transpose(m : SignalspecmodifiedMatrix) -> SignalspecmodifiedMatrix {
  let result = signal_spec_modified_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_spec_modified_matrix_add(a : SignalspecmodifiedMatrix, b : SignalspecmodifiedMatrix) -> SignalspecmodifiedMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_spec_modified_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_spec_modified_matrix_scale(m : SignalspecmodifiedMatrix, s : Double) -> SignalspecmodifiedMatrix {
  let result = signal_spec_modified_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_spec_modified_matrix_multiply(a : SignalspecmodifiedMatrix, b : SignalspecmodifiedMatrix) -> SignalspecmodifiedMatrix {
  if a.cols != b.rows { return signal_spec_modified_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_spec_modified_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_spec_modified_matrix_trace(m : SignalspecmodifiedMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_spec_modified_matrix_det(m : SignalspecmodifiedMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_spec_modified_matrix_norm(m : SignalspecmodifiedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_spec_modified_matrix_to_string(m : SignalspecmodifiedMatrix) -> String {
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

pub(all) struct SignalspecmodifiedVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_modified_make_vector(comps : Array[Double]) -> SignalspecmodifiedVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_modified_vector_zero(dim : Int) -> SignalspecmodifiedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_spec_modified_vector_add(a : SignalspecmodifiedVector, b : SignalspecmodifiedVector) -> SignalspecmodifiedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_spec_modified_vector_sub(a : SignalspecmodifiedVector, b : SignalspecmodifiedVector) -> SignalspecmodifiedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_spec_modified_vector_scale(v : SignalspecmodifiedVector, s : Double) -> SignalspecmodifiedVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_spec_modified_vector_dot(a : SignalspecmodifiedVector, b : SignalspecmodifiedVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_spec_modified_vector_norm(v : SignalspecmodifiedVector) -> Double { @_common.sqrt(signal_spec_modified_vector_dot(v, v)) }

pub fn signal_spec_modified_vector_normalize(v : SignalspecmodifiedVector) -> SignalspecmodifiedVector {
  let n = signal_spec_modified_vector_norm(v)
  if n < 0.0000001 { v } else { signal_spec_modified_vector_scale(v, 1.0 / n) }
}

pub fn signal_spec_modified_vector_dist(a : SignalspecmodifiedVector, b : SignalspecmodifiedVector) -> Double {
  signal_spec_modified_vector_norm(signal_spec_modified_vector_sub(a, b))
}

pub fn signal_spec_modified_vector_to_string(v : SignalspecmodifiedVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_spec_modified_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_spec_modified_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_spec_modified_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_spec_modified_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_spec_modified_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_spec_modified_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_spec_modified_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_spec_modified_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_spec_modified_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_spec_modified_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_spec_modified_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_spec_modified_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_spec_modified_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_spec_modified_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_spec_modified_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_spec_modified_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_spec_modified_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_spec_modified_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_spec_modified_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_spec_modified_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_spec_modified_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_spec_modified_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_spec_modified_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_spec_modified_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_spec_modified_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_spec_modified_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_spec_modified_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_spec_modified_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_spec_modified_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalspecmodifiedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_frame_make(size : Int) -> SignalspecmodifiedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_frame_len(s : SignalspecmodifiedFrame) -> Int { s.size }

pub fn signal_spec_modified_frame_get(s : SignalspecmodifiedFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_frame_set(s : SignalspecmodifiedFrame, i : Int, v : Double) -> SignalspecmodifiedFrame {
  let result = signal_spec_modified_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_modified_frame_sum(s : SignalspecmodifiedFrame) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_frame_mean(s : SignalspecmodifiedFrame) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_frame_scale(s : SignalspecmodifiedFrame, f : Double) -> SignalspecmodifiedFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_frame_add(a : SignalspecmodifiedFrame, b : SignalspecmodifiedFrame) -> SignalspecmodifiedFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_frame_copy(s : SignalspecmodifiedFrame) -> SignalspecmodifiedFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_frame_fill(s : SignalspecmodifiedFrame, v : Double) -> SignalspecmodifiedFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_frame_min(s : SignalspecmodifiedFrame) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_frame_max(s : SignalspecmodifiedFrame) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_frame_to_string(s : SignalspecmodifiedFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_table_make(size : Int) -> SignalspecmodifiedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_table_len(s : SignalspecmodifiedTable) -> Int { s.size }

pub fn signal_spec_modified_table_get(s : SignalspecmodifiedTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_table_set(s : SignalspecmodifiedTable, i : Int, v : Double) -> SignalspecmodifiedTable {
  let result = signal_spec_modified_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_modified_table_sum(s : SignalspecmodifiedTable) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_table_mean(s : SignalspecmodifiedTable) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_table_scale(s : SignalspecmodifiedTable, f : Double) -> SignalspecmodifiedTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_table_add(a : SignalspecmodifiedTable, b : SignalspecmodifiedTable) -> SignalspecmodifiedTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_table_copy(s : SignalspecmodifiedTable) -> SignalspecmodifiedTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_table_fill(s : SignalspecmodifiedTable, v : Double) -> SignalspecmodifiedTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_table_min(s : SignalspecmodifiedTable) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_table_max(s : SignalspecmodifiedTable) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_table_to_string(s : SignalspecmodifiedTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_graphn_make(size : Int) -> SignalspecmodifiedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_graphn_len(s : SignalspecmodifiedGraphN) -> Int { s.size }

pub fn signal_spec_modified_graphn_get(s : SignalspecmodifiedGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_graphn_set(s : SignalspecmodifiedGraphN, i : Int, v : Double) -> SignalspecmodifiedGraphN {
  let result = signal_spec_modified_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_modified_graphn_sum(s : SignalspecmodifiedGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_graphn_mean(s : SignalspecmodifiedGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_graphn_scale(s : SignalspecmodifiedGraphN, f : Double) -> SignalspecmodifiedGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_graphn_add(a : SignalspecmodifiedGraphN, b : SignalspecmodifiedGraphN) -> SignalspecmodifiedGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_graphn_copy(s : SignalspecmodifiedGraphN) -> SignalspecmodifiedGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_graphn_fill(s : SignalspecmodifiedGraphN, v : Double) -> SignalspecmodifiedGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_graphn_min(s : SignalspecmodifiedGraphN) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_graphn_max(s : SignalspecmodifiedGraphN) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_graphn_to_string(s : SignalspecmodifiedGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_node_make(size : Int) -> SignalspecmodifiedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_node_len(s : SignalspecmodifiedNode) -> Int { s.size }

pub fn signal_spec_modified_node_get(s : SignalspecmodifiedNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_node_set(s : SignalspecmodifiedNode, i : Int, v : Double) -> SignalspecmodifiedNode {
  let result = signal_spec_modified_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_modified_node_sum(s : SignalspecmodifiedNode) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_node_mean(s : SignalspecmodifiedNode) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_node_scale(s : SignalspecmodifiedNode, f : Double) -> SignalspecmodifiedNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_node_add(a : SignalspecmodifiedNode, b : SignalspecmodifiedNode) -> SignalspecmodifiedNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_node_copy(s : SignalspecmodifiedNode) -> SignalspecmodifiedNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_node_fill(s : SignalspecmodifiedNode, v : Double) -> SignalspecmodifiedNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_node_min(s : SignalspecmodifiedNode) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_node_max(s : SignalspecmodifiedNode) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_node_to_string(s : SignalspecmodifiedNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_edge_make(size : Int) -> SignalspecmodifiedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_edge_len(s : SignalspecmodifiedEdge) -> Int { s.size }

pub fn signal_spec_modified_edge_get(s : SignalspecmodifiedEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_edge_set(s : SignalspecmodifiedEdge, i : Int, v : Double) -> SignalspecmodifiedEdge {
  let result = signal_spec_modified_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_modified_edge_sum(s : SignalspecmodifiedEdge) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_edge_mean(s : SignalspecmodifiedEdge) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_edge_scale(s : SignalspecmodifiedEdge, f : Double) -> SignalspecmodifiedEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_edge_add(a : SignalspecmodifiedEdge, b : SignalspecmodifiedEdge) -> SignalspecmodifiedEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_edge_copy(s : SignalspecmodifiedEdge) -> SignalspecmodifiedEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_edge_fill(s : SignalspecmodifiedEdge, v : Double) -> SignalspecmodifiedEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_edge_min(s : SignalspecmodifiedEdge) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_edge_max(s : SignalspecmodifiedEdge) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_edge_to_string(s : SignalspecmodifiedEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_path_make(size : Int) -> SignalspecmodifiedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_path_len(s : SignalspecmodifiedPath) -> Int { s.size }

pub fn signal_spec_modified_path_get(s : SignalspecmodifiedPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_path_set(s : SignalspecmodifiedPath, i : Int, v : Double) -> SignalspecmodifiedPath {
  let result = signal_spec_modified_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_modified_path_sum(s : SignalspecmodifiedPath) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_path_mean(s : SignalspecmodifiedPath) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_path_scale(s : SignalspecmodifiedPath, f : Double) -> SignalspecmodifiedPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_path_add(a : SignalspecmodifiedPath, b : SignalspecmodifiedPath) -> SignalspecmodifiedPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_path_copy(s : SignalspecmodifiedPath) -> SignalspecmodifiedPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_path_fill(s : SignalspecmodifiedPath, v : Double) -> SignalspecmodifiedPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_path_min(s : SignalspecmodifiedPath) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_path_max(s : SignalspecmodifiedPath) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_path_to_string(s : SignalspecmodifiedPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_cluster_make(size : Int) -> SignalspecmodifiedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_cluster_len(s : SignalspecmodifiedCluster) -> Int { s.size }

pub fn signal_spec_modified_cluster_get(s : SignalspecmodifiedCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_cluster_set(s : SignalspecmodifiedCluster, i : Int, v : Double) -> SignalspecmodifiedCluster {
  let result = signal_spec_modified_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_modified_cluster_sum(s : SignalspecmodifiedCluster) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_cluster_mean(s : SignalspecmodifiedCluster) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_cluster_scale(s : SignalspecmodifiedCluster, f : Double) -> SignalspecmodifiedCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_cluster_add(a : SignalspecmodifiedCluster, b : SignalspecmodifiedCluster) -> SignalspecmodifiedCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_cluster_copy(s : SignalspecmodifiedCluster) -> SignalspecmodifiedCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_cluster_fill(s : SignalspecmodifiedCluster, v : Double) -> SignalspecmodifiedCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_cluster_min(s : SignalspecmodifiedCluster) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_cluster_max(s : SignalspecmodifiedCluster) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_cluster_to_string(s : SignalspecmodifiedCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_model_make(size : Int) -> SignalspecmodifiedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_model_len(s : SignalspecmodifiedModel) -> Int { s.size }

pub fn signal_spec_modified_model_get(s : SignalspecmodifiedModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_model_set(s : SignalspecmodifiedModel, i : Int, v : Double) -> SignalspecmodifiedModel {
  let result = signal_spec_modified_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_modified_model_sum(s : SignalspecmodifiedModel) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_model_mean(s : SignalspecmodifiedModel) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_model_scale(s : SignalspecmodifiedModel, f : Double) -> SignalspecmodifiedModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_model_add(a : SignalspecmodifiedModel, b : SignalspecmodifiedModel) -> SignalspecmodifiedModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_model_copy(s : SignalspecmodifiedModel) -> SignalspecmodifiedModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_model_fill(s : SignalspecmodifiedModel, v : Double) -> SignalspecmodifiedModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_model_min(s : SignalspecmodifiedModel) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_model_max(s : SignalspecmodifiedModel) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_model_to_string(s : SignalspecmodifiedModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_layer_make(size : Int) -> SignalspecmodifiedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_layer_len(s : SignalspecmodifiedLayer) -> Int { s.size }

pub fn signal_spec_modified_layer_get(s : SignalspecmodifiedLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_layer_set(s : SignalspecmodifiedLayer, i : Int, v : Double) -> SignalspecmodifiedLayer {
  let result = signal_spec_modified_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_modified_layer_sum(s : SignalspecmodifiedLayer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_layer_mean(s : SignalspecmodifiedLayer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_layer_scale(s : SignalspecmodifiedLayer, f : Double) -> SignalspecmodifiedLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_layer_add(a : SignalspecmodifiedLayer, b : SignalspecmodifiedLayer) -> SignalspecmodifiedLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_layer_copy(s : SignalspecmodifiedLayer) -> SignalspecmodifiedLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_layer_fill(s : SignalspecmodifiedLayer, v : Double) -> SignalspecmodifiedLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_layer_min(s : SignalspecmodifiedLayer) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_layer_max(s : SignalspecmodifiedLayer) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_layer_to_string(s : SignalspecmodifiedLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_buffer_make(size : Int) -> SignalspecmodifiedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_buffer_len(s : SignalspecmodifiedBuffer) -> Int { s.size }

pub fn signal_spec_modified_buffer_get(s : SignalspecmodifiedBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_buffer_set(s : SignalspecmodifiedBuffer, i : Int, v : Double) -> SignalspecmodifiedBuffer {
  let result = signal_spec_modified_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_modified_buffer_sum(s : SignalspecmodifiedBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_buffer_mean(s : SignalspecmodifiedBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_buffer_scale(s : SignalspecmodifiedBuffer, f : Double) -> SignalspecmodifiedBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_buffer_add(a : SignalspecmodifiedBuffer, b : SignalspecmodifiedBuffer) -> SignalspecmodifiedBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_buffer_copy(s : SignalspecmodifiedBuffer) -> SignalspecmodifiedBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_buffer_fill(s : SignalspecmodifiedBuffer, v : Double) -> SignalspecmodifiedBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_buffer_min(s : SignalspecmodifiedBuffer) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_buffer_max(s : SignalspecmodifiedBuffer) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_buffer_to_string(s : SignalspecmodifiedBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_cursor_make(size : Int) -> SignalspecmodifiedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_cursor_len(s : SignalspecmodifiedCursor) -> Int { s.size }

pub fn signal_spec_modified_cursor_get(s : SignalspecmodifiedCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_cursor_set(s : SignalspecmodifiedCursor, i : Int, v : Double) -> SignalspecmodifiedCursor {
  let result = signal_spec_modified_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_modified_cursor_sum(s : SignalspecmodifiedCursor) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_cursor_mean(s : SignalspecmodifiedCursor) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_cursor_scale(s : SignalspecmodifiedCursor, f : Double) -> SignalspecmodifiedCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_cursor_add(a : SignalspecmodifiedCursor, b : SignalspecmodifiedCursor) -> SignalspecmodifiedCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_cursor_copy(s : SignalspecmodifiedCursor) -> SignalspecmodifiedCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_cursor_fill(s : SignalspecmodifiedCursor, v : Double) -> SignalspecmodifiedCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_cursor_min(s : SignalspecmodifiedCursor) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_cursor_max(s : SignalspecmodifiedCursor) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_cursor_to_string(s : SignalspecmodifiedCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_view_make(size : Int) -> SignalspecmodifiedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_view_len(s : SignalspecmodifiedView) -> Int { s.size }

pub fn signal_spec_modified_view_get(s : SignalspecmodifiedView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_view_set(s : SignalspecmodifiedView, i : Int, v : Double) -> SignalspecmodifiedView {
  let result = signal_spec_modified_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_modified_view_sum(s : SignalspecmodifiedView) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_view_mean(s : SignalspecmodifiedView) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_view_scale(s : SignalspecmodifiedView, f : Double) -> SignalspecmodifiedView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_view_add(a : SignalspecmodifiedView, b : SignalspecmodifiedView) -> SignalspecmodifiedView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_view_copy(s : SignalspecmodifiedView) -> SignalspecmodifiedView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_view_fill(s : SignalspecmodifiedView, v : Double) -> SignalspecmodifiedView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_view_min(s : SignalspecmodifiedView) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_view_max(s : SignalspecmodifiedView) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_view_to_string(s : SignalspecmodifiedView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_range_make(size : Int) -> SignalspecmodifiedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_range_len(s : SignalspecmodifiedRange) -> Int { s.size }

pub fn signal_spec_modified_range_get(s : SignalspecmodifiedRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_range_set(s : SignalspecmodifiedRange, i : Int, v : Double) -> SignalspecmodifiedRange {
  let result = signal_spec_modified_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_modified_range_sum(s : SignalspecmodifiedRange) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_range_mean(s : SignalspecmodifiedRange) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_range_scale(s : SignalspecmodifiedRange, f : Double) -> SignalspecmodifiedRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_range_add(a : SignalspecmodifiedRange, b : SignalspecmodifiedRange) -> SignalspecmodifiedRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_range_copy(s : SignalspecmodifiedRange) -> SignalspecmodifiedRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_range_fill(s : SignalspecmodifiedRange, v : Double) -> SignalspecmodifiedRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_range_min(s : SignalspecmodifiedRange) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_range_max(s : SignalspecmodifiedRange) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_range_to_string(s : SignalspecmodifiedRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_slice_make(size : Int) -> SignalspecmodifiedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_slice_len(s : SignalspecmodifiedSlice) -> Int { s.size }

pub fn signal_spec_modified_slice_get(s : SignalspecmodifiedSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_slice_set(s : SignalspecmodifiedSlice, i : Int, v : Double) -> SignalspecmodifiedSlice {
  let result = signal_spec_modified_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_modified_slice_sum(s : SignalspecmodifiedSlice) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_slice_mean(s : SignalspecmodifiedSlice) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_slice_scale(s : SignalspecmodifiedSlice, f : Double) -> SignalspecmodifiedSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_slice_add(a : SignalspecmodifiedSlice, b : SignalspecmodifiedSlice) -> SignalspecmodifiedSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_slice_copy(s : SignalspecmodifiedSlice) -> SignalspecmodifiedSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_slice_fill(s : SignalspecmodifiedSlice, v : Double) -> SignalspecmodifiedSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_slice_min(s : SignalspecmodifiedSlice) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_slice_max(s : SignalspecmodifiedSlice) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_slice_to_string(s : SignalspecmodifiedSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

