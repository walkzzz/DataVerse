///===
/// extcore/signal_transform_radar

pub(all) struct SignaltransformradarPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_radar_make_point(x : Double, y : Double) -> SignaltransformradarPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_radar_make_point3(x : Double, y : Double, z : Double) -> SignaltransformradarPoint {
  { x, y, z, label: 0 }
}

pub fn signal_transform_radar_point_x(pt : SignaltransformradarPoint) -> Double { pt.x }

pub fn signal_transform_radar_point_y(pt : SignaltransformradarPoint) -> Double { pt.y }

pub fn signal_transform_radar_point_z(pt : SignaltransformradarPoint) -> Double { pt.z }

pub fn signal_transform_radar_point_label(pt : SignaltransformradarPoint) -> Int { pt.label }

pub fn signal_transform_radar_point_dist(a : SignaltransformradarPoint, b : SignaltransformradarPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_transform_radar_point_add(a : SignaltransformradarPoint, b : SignaltransformradarPoint) -> SignaltransformradarPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_transform_radar_point_sub(a : SignaltransformradarPoint, b : SignaltransformradarPoint) -> SignaltransformradarPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_transform_radar_point_scale(pt : SignaltransformradarPoint, s : Double) -> SignaltransformradarPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_transform_radar_point_dot(a : SignaltransformradarPoint, b : SignaltransformradarPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_transform_radar_point_cross(a : SignaltransformradarPoint, b : SignaltransformradarPoint) -> SignaltransformradarPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_transform_radar_point_norm(pt : SignaltransformradarPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_transform_radar_point_normalize(pt : SignaltransformradarPoint) -> SignaltransformradarPoint {
  let n = signal_transform_radar_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_transform_radar_point_scale(pt, 1.0 / n) }
}

pub fn signal_transform_radar_point_negate(pt : SignaltransformradarPoint) -> SignaltransformradarPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_transform_radar_point_mid(a : SignaltransformradarPoint, b : SignaltransformradarPoint) -> SignaltransformradarPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_transform_radar_point_lerp(a : SignaltransformradarPoint, b : SignaltransformradarPoint, t : Double) -> SignaltransformradarPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_transform_radar_point_to_string(pt : SignaltransformradarPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignaltransformradarSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_radar_make_series(vals : Array[Double], name : String) -> SignaltransformradarSeries {
  { vals, name, meta: 0 }
}

pub fn signal_transform_radar_series_len(s : SignaltransformradarSeries) -> Int { s.vals.length() }

pub fn signal_transform_radar_series_sum(s : SignaltransformradarSeries) -> Double { @_common.sum(s.vals) }

pub fn signal_transform_radar_series_mean(s : SignaltransformradarSeries) -> Double { @_common.mean(s.vals) }

pub fn signal_transform_radar_series_min(s : SignaltransformradarSeries) -> Double { @_common.min(s.vals) }

pub fn signal_transform_radar_series_max(s : SignaltransformradarSeries) -> Double { @_common.max(s.vals) }

pub fn signal_transform_radar_series_range(s : SignaltransformradarSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn signal_transform_radar_series_var(s : SignaltransformradarSeries) -> Double { @_common.variance(s.vals) }

pub fn signal_transform_radar_series_std(s : SignaltransformradarSeries) -> Double { @_common.std(s.vals) }

pub fn signal_transform_radar_series_median(s : SignaltransformradarSeries) -> Double { @_common.median(s.vals) }

pub fn signal_transform_radar_series_scale(s : SignaltransformradarSeries, f : Double) -> SignaltransformradarSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_transform_radar_series_add(a : SignaltransformradarSeries, b : SignaltransformradarSeries) -> SignaltransformradarSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_transform_radar_series_sub(a : SignaltransformradarSeries, b : SignaltransformradarSeries) -> SignaltransformradarSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_transform_radar_series_normalize(s : SignaltransformradarSeries) -> SignaltransformradarSeries {
  let mn = signal_transform_radar_series_min(s)
  let mx = signal_transform_radar_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_transform_radar_series_cumsum(s : SignaltransformradarSeries) -> SignaltransformradarSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_transform_radar_series_to_string(s : SignaltransformradarSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformradarMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_radar_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformradarMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_radar_matrix_identity(n : Int) -> SignaltransformradarMatrix {
  let m = signal_transform_radar_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_transform_radar_matrix_get(m : SignaltransformradarMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_transform_radar_matrix_transpose(m : SignaltransformradarMatrix) -> SignaltransformradarMatrix {
  let result = signal_transform_radar_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_transform_radar_matrix_add(a : SignaltransformradarMatrix, b : SignaltransformradarMatrix) -> SignaltransformradarMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_transform_radar_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_transform_radar_matrix_scale(m : SignaltransformradarMatrix, s : Double) -> SignaltransformradarMatrix {
  let result = signal_transform_radar_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_transform_radar_matrix_multiply(a : SignaltransformradarMatrix, b : SignaltransformradarMatrix) -> SignaltransformradarMatrix {
  if a.cols != b.rows { return signal_transform_radar_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_transform_radar_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_transform_radar_matrix_trace(m : SignaltransformradarMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_transform_radar_matrix_det(m : SignaltransformradarMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_transform_radar_matrix_norm(m : SignaltransformradarMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_transform_radar_matrix_to_string(m : SignaltransformradarMatrix) -> String {
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

pub(all) struct SignaltransformradarVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_radar_make_vector(comps : Array[Double]) -> SignaltransformradarVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_radar_vector_zero(dim : Int) -> SignaltransformradarVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_transform_radar_vector_add(a : SignaltransformradarVector, b : SignaltransformradarVector) -> SignaltransformradarVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_transform_radar_vector_sub(a : SignaltransformradarVector, b : SignaltransformradarVector) -> SignaltransformradarVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_transform_radar_vector_scale(v : SignaltransformradarVector, s : Double) -> SignaltransformradarVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_transform_radar_vector_dot(a : SignaltransformradarVector, b : SignaltransformradarVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_transform_radar_vector_norm(v : SignaltransformradarVector) -> Double { @_common.sqrt(signal_transform_radar_vector_dot(v, v)) }

pub fn signal_transform_radar_vector_normalize(v : SignaltransformradarVector) -> SignaltransformradarVector {
  let n = signal_transform_radar_vector_norm(v)
  if n < 0.0000001 { v } else { signal_transform_radar_vector_scale(v, 1.0 / n) }
}

pub fn signal_transform_radar_vector_dist(a : SignaltransformradarVector, b : SignaltransformradarVector) -> Double {
  signal_transform_radar_vector_norm(signal_transform_radar_vector_sub(a, b))
}

pub fn signal_transform_radar_vector_to_string(v : SignaltransformradarVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_transform_radar_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_transform_radar_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_transform_radar_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_transform_radar_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_transform_radar_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_transform_radar_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_transform_radar_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_transform_radar_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_transform_radar_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_transform_radar_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_transform_radar_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_transform_radar_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_transform_radar_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_transform_radar_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_transform_radar_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_transform_radar_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_transform_radar_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_transform_radar_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_transform_radar_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_transform_radar_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_transform_radar_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_transform_radar_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_transform_radar_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_transform_radar_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_transform_radar_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_transform_radar_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_transform_radar_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_transform_radar_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_transform_radar_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignaltransformradarFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_frame_make(size : Int) -> SignaltransformradarFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_frame_len(s : SignaltransformradarFrame) -> Int { s.size }

pub fn signal_transform_radar_frame_get(s : SignaltransformradarFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_frame_set(s : SignaltransformradarFrame, i : Int, v : Double) -> SignaltransformradarFrame {
  let result = signal_transform_radar_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_radar_frame_sum(s : SignaltransformradarFrame) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_frame_mean(s : SignaltransformradarFrame) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_frame_scale(s : SignaltransformradarFrame, f : Double) -> SignaltransformradarFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_frame_add(a : SignaltransformradarFrame, b : SignaltransformradarFrame) -> SignaltransformradarFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_frame_copy(s : SignaltransformradarFrame) -> SignaltransformradarFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_frame_fill(s : SignaltransformradarFrame, v : Double) -> SignaltransformradarFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_frame_min(s : SignaltransformradarFrame) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_frame_max(s : SignaltransformradarFrame) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_frame_to_string(s : SignaltransformradarFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_table_make(size : Int) -> SignaltransformradarTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_table_len(s : SignaltransformradarTable) -> Int { s.size }

pub fn signal_transform_radar_table_get(s : SignaltransformradarTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_table_set(s : SignaltransformradarTable, i : Int, v : Double) -> SignaltransformradarTable {
  let result = signal_transform_radar_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_radar_table_sum(s : SignaltransformradarTable) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_table_mean(s : SignaltransformradarTable) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_table_scale(s : SignaltransformradarTable, f : Double) -> SignaltransformradarTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_table_add(a : SignaltransformradarTable, b : SignaltransformradarTable) -> SignaltransformradarTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_table_copy(s : SignaltransformradarTable) -> SignaltransformradarTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_table_fill(s : SignaltransformradarTable, v : Double) -> SignaltransformradarTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_table_min(s : SignaltransformradarTable) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_table_max(s : SignaltransformradarTable) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_table_to_string(s : SignaltransformradarTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_graphn_make(size : Int) -> SignaltransformradarGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_graphn_len(s : SignaltransformradarGraphN) -> Int { s.size }

pub fn signal_transform_radar_graphn_get(s : SignaltransformradarGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_graphn_set(s : SignaltransformradarGraphN, i : Int, v : Double) -> SignaltransformradarGraphN {
  let result = signal_transform_radar_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_radar_graphn_sum(s : SignaltransformradarGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_graphn_mean(s : SignaltransformradarGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_graphn_scale(s : SignaltransformradarGraphN, f : Double) -> SignaltransformradarGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_graphn_add(a : SignaltransformradarGraphN, b : SignaltransformradarGraphN) -> SignaltransformradarGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_graphn_copy(s : SignaltransformradarGraphN) -> SignaltransformradarGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_graphn_fill(s : SignaltransformradarGraphN, v : Double) -> SignaltransformradarGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_graphn_min(s : SignaltransformradarGraphN) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_graphn_max(s : SignaltransformradarGraphN) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_graphn_to_string(s : SignaltransformradarGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_node_make(size : Int) -> SignaltransformradarNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_node_len(s : SignaltransformradarNode) -> Int { s.size }

pub fn signal_transform_radar_node_get(s : SignaltransformradarNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_node_set(s : SignaltransformradarNode, i : Int, v : Double) -> SignaltransformradarNode {
  let result = signal_transform_radar_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_radar_node_sum(s : SignaltransformradarNode) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_node_mean(s : SignaltransformradarNode) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_node_scale(s : SignaltransformradarNode, f : Double) -> SignaltransformradarNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_node_add(a : SignaltransformradarNode, b : SignaltransformradarNode) -> SignaltransformradarNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_node_copy(s : SignaltransformradarNode) -> SignaltransformradarNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_node_fill(s : SignaltransformradarNode, v : Double) -> SignaltransformradarNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_node_min(s : SignaltransformradarNode) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_node_max(s : SignaltransformradarNode) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_node_to_string(s : SignaltransformradarNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_edge_make(size : Int) -> SignaltransformradarEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_edge_len(s : SignaltransformradarEdge) -> Int { s.size }

pub fn signal_transform_radar_edge_get(s : SignaltransformradarEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_edge_set(s : SignaltransformradarEdge, i : Int, v : Double) -> SignaltransformradarEdge {
  let result = signal_transform_radar_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_radar_edge_sum(s : SignaltransformradarEdge) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_edge_mean(s : SignaltransformradarEdge) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_edge_scale(s : SignaltransformradarEdge, f : Double) -> SignaltransformradarEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_edge_add(a : SignaltransformradarEdge, b : SignaltransformradarEdge) -> SignaltransformradarEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_edge_copy(s : SignaltransformradarEdge) -> SignaltransformradarEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_edge_fill(s : SignaltransformradarEdge, v : Double) -> SignaltransformradarEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_edge_min(s : SignaltransformradarEdge) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_edge_max(s : SignaltransformradarEdge) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_edge_to_string(s : SignaltransformradarEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_path_make(size : Int) -> SignaltransformradarPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_path_len(s : SignaltransformradarPath) -> Int { s.size }

pub fn signal_transform_radar_path_get(s : SignaltransformradarPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_path_set(s : SignaltransformradarPath, i : Int, v : Double) -> SignaltransformradarPath {
  let result = signal_transform_radar_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_radar_path_sum(s : SignaltransformradarPath) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_path_mean(s : SignaltransformradarPath) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_path_scale(s : SignaltransformradarPath, f : Double) -> SignaltransformradarPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_path_add(a : SignaltransformradarPath, b : SignaltransformradarPath) -> SignaltransformradarPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_path_copy(s : SignaltransformradarPath) -> SignaltransformradarPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_path_fill(s : SignaltransformradarPath, v : Double) -> SignaltransformradarPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_path_min(s : SignaltransformradarPath) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_path_max(s : SignaltransformradarPath) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_path_to_string(s : SignaltransformradarPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_cluster_make(size : Int) -> SignaltransformradarCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_cluster_len(s : SignaltransformradarCluster) -> Int { s.size }

pub fn signal_transform_radar_cluster_get(s : SignaltransformradarCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_cluster_set(s : SignaltransformradarCluster, i : Int, v : Double) -> SignaltransformradarCluster {
  let result = signal_transform_radar_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_radar_cluster_sum(s : SignaltransformradarCluster) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_cluster_mean(s : SignaltransformradarCluster) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_cluster_scale(s : SignaltransformradarCluster, f : Double) -> SignaltransformradarCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_cluster_add(a : SignaltransformradarCluster, b : SignaltransformradarCluster) -> SignaltransformradarCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_cluster_copy(s : SignaltransformradarCluster) -> SignaltransformradarCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_cluster_fill(s : SignaltransformradarCluster, v : Double) -> SignaltransformradarCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_cluster_min(s : SignaltransformradarCluster) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_cluster_max(s : SignaltransformradarCluster) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_cluster_to_string(s : SignaltransformradarCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_model_make(size : Int) -> SignaltransformradarModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_model_len(s : SignaltransformradarModel) -> Int { s.size }

pub fn signal_transform_radar_model_get(s : SignaltransformradarModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_model_set(s : SignaltransformradarModel, i : Int, v : Double) -> SignaltransformradarModel {
  let result = signal_transform_radar_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_radar_model_sum(s : SignaltransformradarModel) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_model_mean(s : SignaltransformradarModel) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_model_scale(s : SignaltransformradarModel, f : Double) -> SignaltransformradarModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_model_add(a : SignaltransformradarModel, b : SignaltransformradarModel) -> SignaltransformradarModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_model_copy(s : SignaltransformradarModel) -> SignaltransformradarModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_model_fill(s : SignaltransformradarModel, v : Double) -> SignaltransformradarModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_model_min(s : SignaltransformradarModel) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_model_max(s : SignaltransformradarModel) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_model_to_string(s : SignaltransformradarModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_layer_make(size : Int) -> SignaltransformradarLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_layer_len(s : SignaltransformradarLayer) -> Int { s.size }

pub fn signal_transform_radar_layer_get(s : SignaltransformradarLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_layer_set(s : SignaltransformradarLayer, i : Int, v : Double) -> SignaltransformradarLayer {
  let result = signal_transform_radar_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_radar_layer_sum(s : SignaltransformradarLayer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_layer_mean(s : SignaltransformradarLayer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_layer_scale(s : SignaltransformradarLayer, f : Double) -> SignaltransformradarLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_layer_add(a : SignaltransformradarLayer, b : SignaltransformradarLayer) -> SignaltransformradarLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_layer_copy(s : SignaltransformradarLayer) -> SignaltransformradarLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_layer_fill(s : SignaltransformradarLayer, v : Double) -> SignaltransformradarLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_layer_min(s : SignaltransformradarLayer) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_layer_max(s : SignaltransformradarLayer) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_layer_to_string(s : SignaltransformradarLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_buffer_make(size : Int) -> SignaltransformradarBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_buffer_len(s : SignaltransformradarBuffer) -> Int { s.size }

pub fn signal_transform_radar_buffer_get(s : SignaltransformradarBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_buffer_set(s : SignaltransformradarBuffer, i : Int, v : Double) -> SignaltransformradarBuffer {
  let result = signal_transform_radar_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_radar_buffer_sum(s : SignaltransformradarBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_buffer_mean(s : SignaltransformradarBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_buffer_scale(s : SignaltransformradarBuffer, f : Double) -> SignaltransformradarBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_buffer_add(a : SignaltransformradarBuffer, b : SignaltransformradarBuffer) -> SignaltransformradarBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_buffer_copy(s : SignaltransformradarBuffer) -> SignaltransformradarBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_buffer_fill(s : SignaltransformradarBuffer, v : Double) -> SignaltransformradarBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_buffer_min(s : SignaltransformradarBuffer) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_buffer_max(s : SignaltransformradarBuffer) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_buffer_to_string(s : SignaltransformradarBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_cursor_make(size : Int) -> SignaltransformradarCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_cursor_len(s : SignaltransformradarCursor) -> Int { s.size }

pub fn signal_transform_radar_cursor_get(s : SignaltransformradarCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_cursor_set(s : SignaltransformradarCursor, i : Int, v : Double) -> SignaltransformradarCursor {
  let result = signal_transform_radar_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_radar_cursor_sum(s : SignaltransformradarCursor) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_cursor_mean(s : SignaltransformradarCursor) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_cursor_scale(s : SignaltransformradarCursor, f : Double) -> SignaltransformradarCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_cursor_add(a : SignaltransformradarCursor, b : SignaltransformradarCursor) -> SignaltransformradarCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_cursor_copy(s : SignaltransformradarCursor) -> SignaltransformradarCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_cursor_fill(s : SignaltransformradarCursor, v : Double) -> SignaltransformradarCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_cursor_min(s : SignaltransformradarCursor) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_cursor_max(s : SignaltransformradarCursor) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_cursor_to_string(s : SignaltransformradarCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_view_make(size : Int) -> SignaltransformradarView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_view_len(s : SignaltransformradarView) -> Int { s.size }

pub fn signal_transform_radar_view_get(s : SignaltransformradarView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_view_set(s : SignaltransformradarView, i : Int, v : Double) -> SignaltransformradarView {
  let result = signal_transform_radar_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_radar_view_sum(s : SignaltransformradarView) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_view_mean(s : SignaltransformradarView) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_view_scale(s : SignaltransformradarView, f : Double) -> SignaltransformradarView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_view_add(a : SignaltransformradarView, b : SignaltransformradarView) -> SignaltransformradarView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_view_copy(s : SignaltransformradarView) -> SignaltransformradarView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_view_fill(s : SignaltransformradarView, v : Double) -> SignaltransformradarView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_view_min(s : SignaltransformradarView) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_view_max(s : SignaltransformradarView) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_view_to_string(s : SignaltransformradarView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_range_make(size : Int) -> SignaltransformradarRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_range_len(s : SignaltransformradarRange) -> Int { s.size }

pub fn signal_transform_radar_range_get(s : SignaltransformradarRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_range_set(s : SignaltransformradarRange, i : Int, v : Double) -> SignaltransformradarRange {
  let result = signal_transform_radar_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_radar_range_sum(s : SignaltransformradarRange) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_range_mean(s : SignaltransformradarRange) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_range_scale(s : SignaltransformradarRange, f : Double) -> SignaltransformradarRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_range_add(a : SignaltransformradarRange, b : SignaltransformradarRange) -> SignaltransformradarRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_range_copy(s : SignaltransformradarRange) -> SignaltransformradarRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_range_fill(s : SignaltransformradarRange, v : Double) -> SignaltransformradarRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_range_min(s : SignaltransformradarRange) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_range_max(s : SignaltransformradarRange) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_range_to_string(s : SignaltransformradarRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_slice_make(size : Int) -> SignaltransformradarSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_slice_len(s : SignaltransformradarSlice) -> Int { s.size }

pub fn signal_transform_radar_slice_get(s : SignaltransformradarSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_slice_set(s : SignaltransformradarSlice, i : Int, v : Double) -> SignaltransformradarSlice {
  let result = signal_transform_radar_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_radar_slice_sum(s : SignaltransformradarSlice) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_slice_mean(s : SignaltransformradarSlice) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_slice_scale(s : SignaltransformradarSlice, f : Double) -> SignaltransformradarSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_slice_add(a : SignaltransformradarSlice, b : SignaltransformradarSlice) -> SignaltransformradarSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_slice_copy(s : SignaltransformradarSlice) -> SignaltransformradarSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_slice_fill(s : SignaltransformradarSlice, v : Double) -> SignaltransformradarSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_slice_min(s : SignaltransformradarSlice) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_slice_max(s : SignaltransformradarSlice) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_slice_to_string(s : SignaltransformradarSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

