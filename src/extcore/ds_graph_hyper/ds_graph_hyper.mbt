///===
/// extcore/ds_graph_hyper

pub(all) struct DsgraphhyperPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_hyper_make_point(x : Double, y : Double) -> DsgraphhyperPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_hyper_make_point3(x : Double, y : Double, z : Double) -> DsgraphhyperPoint {
  { x, y, z, label: 0 }
}

pub fn ds_graph_hyper_point_x(pt : DsgraphhyperPoint) -> Double { pt.x }

pub fn ds_graph_hyper_point_y(pt : DsgraphhyperPoint) -> Double { pt.y }

pub fn ds_graph_hyper_point_z(pt : DsgraphhyperPoint) -> Double { pt.z }

pub fn ds_graph_hyper_point_label(pt : DsgraphhyperPoint) -> Int { pt.label }

pub fn ds_graph_hyper_point_dist(a : DsgraphhyperPoint, b : DsgraphhyperPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_graph_hyper_point_add(a : DsgraphhyperPoint, b : DsgraphhyperPoint) -> DsgraphhyperPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_graph_hyper_point_sub(a : DsgraphhyperPoint, b : DsgraphhyperPoint) -> DsgraphhyperPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_graph_hyper_point_scale(pt : DsgraphhyperPoint, s : Double) -> DsgraphhyperPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_graph_hyper_point_dot(a : DsgraphhyperPoint, b : DsgraphhyperPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_graph_hyper_point_cross(a : DsgraphhyperPoint, b : DsgraphhyperPoint) -> DsgraphhyperPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_graph_hyper_point_norm(pt : DsgraphhyperPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_graph_hyper_point_normalize(pt : DsgraphhyperPoint) -> DsgraphhyperPoint {
  let n = ds_graph_hyper_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_graph_hyper_point_scale(pt, 1.0 / n) }
}

pub fn ds_graph_hyper_point_negate(pt : DsgraphhyperPoint) -> DsgraphhyperPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_graph_hyper_point_mid(a : DsgraphhyperPoint, b : DsgraphhyperPoint) -> DsgraphhyperPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_graph_hyper_point_lerp(a : DsgraphhyperPoint, b : DsgraphhyperPoint, t : Double) -> DsgraphhyperPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_graph_hyper_point_to_string(pt : DsgraphhyperPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsgraphhyperSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_hyper_make_series(vals : Array[Double], name : String) -> DsgraphhyperSeries {
  { vals, name, meta: 0 }
}

pub fn ds_graph_hyper_series_len(s : DsgraphhyperSeries) -> Int { s.vals.length() }

pub fn ds_graph_hyper_series_sum(s : DsgraphhyperSeries) -> Double { @_common.sum(s.vals) }

pub fn ds_graph_hyper_series_mean(s : DsgraphhyperSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_graph_hyper_series_min(s : DsgraphhyperSeries) -> Double { @_common.min(s.vals) }

pub fn ds_graph_hyper_series_max(s : DsgraphhyperSeries) -> Double { @_common.max(s.vals) }

pub fn ds_graph_hyper_series_range(s : DsgraphhyperSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_graph_hyper_series_var(s : DsgraphhyperSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_graph_hyper_series_std(s : DsgraphhyperSeries) -> Double { @_common.std(s.vals) }

pub fn ds_graph_hyper_series_median(s : DsgraphhyperSeries) -> Double { @_common.median(s.vals) }

pub fn ds_graph_hyper_series_scale(s : DsgraphhyperSeries, f : Double) -> DsgraphhyperSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn ds_graph_hyper_series_add(a : DsgraphhyperSeries, b : DsgraphhyperSeries) -> DsgraphhyperSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_graph_hyper_series_sub(a : DsgraphhyperSeries, b : DsgraphhyperSeries) -> DsgraphhyperSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_graph_hyper_series_normalize(s : DsgraphhyperSeries) -> DsgraphhyperSeries {
  let mn = ds_graph_hyper_series_min(s)
  let mx = ds_graph_hyper_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_graph_hyper_series_cumsum(s : DsgraphhyperSeries) -> DsgraphhyperSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_graph_hyper_series_to_string(s : DsgraphhyperSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphhyperMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_hyper_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphhyperMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_hyper_matrix_identity(n : Int) -> DsgraphhyperMatrix {
  let m = ds_graph_hyper_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_graph_hyper_matrix_get(m : DsgraphhyperMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_graph_hyper_matrix_transpose(m : DsgraphhyperMatrix) -> DsgraphhyperMatrix {
  let result = ds_graph_hyper_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_graph_hyper_matrix_add(a : DsgraphhyperMatrix, b : DsgraphhyperMatrix) -> DsgraphhyperMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_graph_hyper_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_graph_hyper_matrix_scale(m : DsgraphhyperMatrix, s : Double) -> DsgraphhyperMatrix {
  let result = ds_graph_hyper_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_graph_hyper_matrix_multiply(a : DsgraphhyperMatrix, b : DsgraphhyperMatrix) -> DsgraphhyperMatrix {
  if a.cols != b.rows { return ds_graph_hyper_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_graph_hyper_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_graph_hyper_matrix_trace(m : DsgraphhyperMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_graph_hyper_matrix_det(m : DsgraphhyperMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_graph_hyper_matrix_norm(m : DsgraphhyperMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_graph_hyper_matrix_to_string(m : DsgraphhyperMatrix) -> String {
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

pub(all) struct DsgraphhyperVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_hyper_make_vector(comps : Array[Double]) -> DsgraphhyperVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_hyper_vector_zero(dim : Int) -> DsgraphhyperVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_graph_hyper_vector_add(a : DsgraphhyperVector, b : DsgraphhyperVector) -> DsgraphhyperVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn ds_graph_hyper_vector_sub(a : DsgraphhyperVector, b : DsgraphhyperVector) -> DsgraphhyperVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn ds_graph_hyper_vector_scale(v : DsgraphhyperVector, s : Double) -> DsgraphhyperVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn ds_graph_hyper_vector_dot(a : DsgraphhyperVector, b : DsgraphhyperVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_graph_hyper_vector_norm(v : DsgraphhyperVector) -> Double { @_common.sqrt(ds_graph_hyper_vector_dot(v, v)) }

pub fn ds_graph_hyper_vector_normalize(v : DsgraphhyperVector) -> DsgraphhyperVector {
  let n = ds_graph_hyper_vector_norm(v)
  if n < 0.0000001 { v } else { ds_graph_hyper_vector_scale(v, 1.0 / n) }
}

pub fn ds_graph_hyper_vector_dist(a : DsgraphhyperVector, b : DsgraphhyperVector) -> Double {
  ds_graph_hyper_vector_norm(ds_graph_hyper_vector_sub(a, b))
}

pub fn ds_graph_hyper_vector_to_string(v : DsgraphhyperVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_graph_hyper_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_graph_hyper_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_graph_hyper_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_graph_hyper_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_graph_hyper_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_graph_hyper_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_graph_hyper_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_graph_hyper_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_graph_hyper_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_graph_hyper_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_graph_hyper_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_graph_hyper_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_graph_hyper_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_graph_hyper_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_graph_hyper_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_graph_hyper_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_graph_hyper_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_graph_hyper_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_graph_hyper_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_graph_hyper_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_graph_hyper_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_graph_hyper_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_graph_hyper_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_graph_hyper_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_graph_hyper_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_graph_hyper_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_graph_hyper_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_graph_hyper_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_graph_hyper_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsgraphhyperFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_frame_make(size : Int) -> DsgraphhyperFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_frame_len(s : DsgraphhyperFrame) -> Int { s.size }

pub fn ds_graph_hyper_frame_get(s : DsgraphhyperFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_frame_set(s : DsgraphhyperFrame, i : Int, v : Double) -> DsgraphhyperFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_frame_sum(s : DsgraphhyperFrame) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_frame_mean(s : DsgraphhyperFrame) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_frame_scale(s : DsgraphhyperFrame, f : Double) -> DsgraphhyperFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_frame_add(a : DsgraphhyperFrame, b : DsgraphhyperFrame) -> DsgraphhyperFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_frame_copy(s : DsgraphhyperFrame) -> DsgraphhyperFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_frame_fill(s : DsgraphhyperFrame, v : Double) -> DsgraphhyperFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_frame_min(s : DsgraphhyperFrame) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_frame_max(s : DsgraphhyperFrame) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_frame_to_string(s : DsgraphhyperFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_table_make(size : Int) -> DsgraphhyperTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_table_len(s : DsgraphhyperTable) -> Int { s.size }

pub fn ds_graph_hyper_table_get(s : DsgraphhyperTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_table_set(s : DsgraphhyperTable, i : Int, v : Double) -> DsgraphhyperTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_table_sum(s : DsgraphhyperTable) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_table_mean(s : DsgraphhyperTable) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_table_scale(s : DsgraphhyperTable, f : Double) -> DsgraphhyperTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_table_add(a : DsgraphhyperTable, b : DsgraphhyperTable) -> DsgraphhyperTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_table_copy(s : DsgraphhyperTable) -> DsgraphhyperTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_table_fill(s : DsgraphhyperTable, v : Double) -> DsgraphhyperTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_table_min(s : DsgraphhyperTable) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_table_max(s : DsgraphhyperTable) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_table_to_string(s : DsgraphhyperTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_graphn_make(size : Int) -> DsgraphhyperGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_graphn_len(s : DsgraphhyperGraphN) -> Int { s.size }

pub fn ds_graph_hyper_graphn_get(s : DsgraphhyperGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_graphn_set(s : DsgraphhyperGraphN, i : Int, v : Double) -> DsgraphhyperGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_graphn_sum(s : DsgraphhyperGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_graphn_mean(s : DsgraphhyperGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_graphn_scale(s : DsgraphhyperGraphN, f : Double) -> DsgraphhyperGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_graphn_add(a : DsgraphhyperGraphN, b : DsgraphhyperGraphN) -> DsgraphhyperGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_graphn_copy(s : DsgraphhyperGraphN) -> DsgraphhyperGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_graphn_fill(s : DsgraphhyperGraphN, v : Double) -> DsgraphhyperGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_graphn_min(s : DsgraphhyperGraphN) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_graphn_max(s : DsgraphhyperGraphN) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_graphn_to_string(s : DsgraphhyperGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_node_make(size : Int) -> DsgraphhyperNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_node_len(s : DsgraphhyperNode) -> Int { s.size }

pub fn ds_graph_hyper_node_get(s : DsgraphhyperNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_node_set(s : DsgraphhyperNode, i : Int, v : Double) -> DsgraphhyperNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_node_sum(s : DsgraphhyperNode) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_node_mean(s : DsgraphhyperNode) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_node_scale(s : DsgraphhyperNode, f : Double) -> DsgraphhyperNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_node_add(a : DsgraphhyperNode, b : DsgraphhyperNode) -> DsgraphhyperNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_node_copy(s : DsgraphhyperNode) -> DsgraphhyperNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_node_fill(s : DsgraphhyperNode, v : Double) -> DsgraphhyperNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_node_min(s : DsgraphhyperNode) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_node_max(s : DsgraphhyperNode) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_node_to_string(s : DsgraphhyperNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_edge_make(size : Int) -> DsgraphhyperEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_edge_len(s : DsgraphhyperEdge) -> Int { s.size }

pub fn ds_graph_hyper_edge_get(s : DsgraphhyperEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_edge_set(s : DsgraphhyperEdge, i : Int, v : Double) -> DsgraphhyperEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_edge_sum(s : DsgraphhyperEdge) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_edge_mean(s : DsgraphhyperEdge) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_edge_scale(s : DsgraphhyperEdge, f : Double) -> DsgraphhyperEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_edge_add(a : DsgraphhyperEdge, b : DsgraphhyperEdge) -> DsgraphhyperEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_edge_copy(s : DsgraphhyperEdge) -> DsgraphhyperEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_edge_fill(s : DsgraphhyperEdge, v : Double) -> DsgraphhyperEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_edge_min(s : DsgraphhyperEdge) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_edge_max(s : DsgraphhyperEdge) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_edge_to_string(s : DsgraphhyperEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_path_make(size : Int) -> DsgraphhyperPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_path_len(s : DsgraphhyperPath) -> Int { s.size }

pub fn ds_graph_hyper_path_get(s : DsgraphhyperPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_path_set(s : DsgraphhyperPath, i : Int, v : Double) -> DsgraphhyperPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_path_sum(s : DsgraphhyperPath) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_path_mean(s : DsgraphhyperPath) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_path_scale(s : DsgraphhyperPath, f : Double) -> DsgraphhyperPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_path_add(a : DsgraphhyperPath, b : DsgraphhyperPath) -> DsgraphhyperPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_path_copy(s : DsgraphhyperPath) -> DsgraphhyperPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_path_fill(s : DsgraphhyperPath, v : Double) -> DsgraphhyperPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_path_min(s : DsgraphhyperPath) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_path_max(s : DsgraphhyperPath) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_path_to_string(s : DsgraphhyperPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_cluster_make(size : Int) -> DsgraphhyperCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_cluster_len(s : DsgraphhyperCluster) -> Int { s.size }

pub fn ds_graph_hyper_cluster_get(s : DsgraphhyperCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_cluster_set(s : DsgraphhyperCluster, i : Int, v : Double) -> DsgraphhyperCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_cluster_sum(s : DsgraphhyperCluster) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_cluster_mean(s : DsgraphhyperCluster) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_cluster_scale(s : DsgraphhyperCluster, f : Double) -> DsgraphhyperCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_cluster_add(a : DsgraphhyperCluster, b : DsgraphhyperCluster) -> DsgraphhyperCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_cluster_copy(s : DsgraphhyperCluster) -> DsgraphhyperCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_cluster_fill(s : DsgraphhyperCluster, v : Double) -> DsgraphhyperCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_cluster_min(s : DsgraphhyperCluster) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_cluster_max(s : DsgraphhyperCluster) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_cluster_to_string(s : DsgraphhyperCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_model_make(size : Int) -> DsgraphhyperModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_model_len(s : DsgraphhyperModel) -> Int { s.size }

pub fn ds_graph_hyper_model_get(s : DsgraphhyperModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_model_set(s : DsgraphhyperModel, i : Int, v : Double) -> DsgraphhyperModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_model_sum(s : DsgraphhyperModel) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_model_mean(s : DsgraphhyperModel) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_model_scale(s : DsgraphhyperModel, f : Double) -> DsgraphhyperModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_model_add(a : DsgraphhyperModel, b : DsgraphhyperModel) -> DsgraphhyperModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_model_copy(s : DsgraphhyperModel) -> DsgraphhyperModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_model_fill(s : DsgraphhyperModel, v : Double) -> DsgraphhyperModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_model_min(s : DsgraphhyperModel) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_model_max(s : DsgraphhyperModel) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_model_to_string(s : DsgraphhyperModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_layer_make(size : Int) -> DsgraphhyperLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_layer_len(s : DsgraphhyperLayer) -> Int { s.size }

pub fn ds_graph_hyper_layer_get(s : DsgraphhyperLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_layer_set(s : DsgraphhyperLayer, i : Int, v : Double) -> DsgraphhyperLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_layer_sum(s : DsgraphhyperLayer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_layer_mean(s : DsgraphhyperLayer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_layer_scale(s : DsgraphhyperLayer, f : Double) -> DsgraphhyperLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_layer_add(a : DsgraphhyperLayer, b : DsgraphhyperLayer) -> DsgraphhyperLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_layer_copy(s : DsgraphhyperLayer) -> DsgraphhyperLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_layer_fill(s : DsgraphhyperLayer, v : Double) -> DsgraphhyperLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_layer_min(s : DsgraphhyperLayer) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_layer_max(s : DsgraphhyperLayer) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_layer_to_string(s : DsgraphhyperLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_buffer_make(size : Int) -> DsgraphhyperBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_buffer_len(s : DsgraphhyperBuffer) -> Int { s.size }

pub fn ds_graph_hyper_buffer_get(s : DsgraphhyperBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_buffer_set(s : DsgraphhyperBuffer, i : Int, v : Double) -> DsgraphhyperBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_buffer_sum(s : DsgraphhyperBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_buffer_mean(s : DsgraphhyperBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_buffer_scale(s : DsgraphhyperBuffer, f : Double) -> DsgraphhyperBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_buffer_add(a : DsgraphhyperBuffer, b : DsgraphhyperBuffer) -> DsgraphhyperBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_buffer_copy(s : DsgraphhyperBuffer) -> DsgraphhyperBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_buffer_fill(s : DsgraphhyperBuffer, v : Double) -> DsgraphhyperBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_buffer_min(s : DsgraphhyperBuffer) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_buffer_max(s : DsgraphhyperBuffer) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_buffer_to_string(s : DsgraphhyperBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_cursor_make(size : Int) -> DsgraphhyperCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_cursor_len(s : DsgraphhyperCursor) -> Int { s.size }

pub fn ds_graph_hyper_cursor_get(s : DsgraphhyperCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_cursor_set(s : DsgraphhyperCursor, i : Int, v : Double) -> DsgraphhyperCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_cursor_sum(s : DsgraphhyperCursor) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_cursor_mean(s : DsgraphhyperCursor) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_cursor_scale(s : DsgraphhyperCursor, f : Double) -> DsgraphhyperCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_cursor_add(a : DsgraphhyperCursor, b : DsgraphhyperCursor) -> DsgraphhyperCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_cursor_copy(s : DsgraphhyperCursor) -> DsgraphhyperCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_cursor_fill(s : DsgraphhyperCursor, v : Double) -> DsgraphhyperCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_cursor_min(s : DsgraphhyperCursor) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_cursor_max(s : DsgraphhyperCursor) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_cursor_to_string(s : DsgraphhyperCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_view_make(size : Int) -> DsgraphhyperView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_view_len(s : DsgraphhyperView) -> Int { s.size }

pub fn ds_graph_hyper_view_get(s : DsgraphhyperView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_view_set(s : DsgraphhyperView, i : Int, v : Double) -> DsgraphhyperView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_view_sum(s : DsgraphhyperView) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_view_mean(s : DsgraphhyperView) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_view_scale(s : DsgraphhyperView, f : Double) -> DsgraphhyperView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_view_add(a : DsgraphhyperView, b : DsgraphhyperView) -> DsgraphhyperView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_view_copy(s : DsgraphhyperView) -> DsgraphhyperView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_view_fill(s : DsgraphhyperView, v : Double) -> DsgraphhyperView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_view_min(s : DsgraphhyperView) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_view_max(s : DsgraphhyperView) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_view_to_string(s : DsgraphhyperView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_range_make(size : Int) -> DsgraphhyperRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_range_len(s : DsgraphhyperRange) -> Int { s.size }

pub fn ds_graph_hyper_range_get(s : DsgraphhyperRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_range_set(s : DsgraphhyperRange, i : Int, v : Double) -> DsgraphhyperRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_range_sum(s : DsgraphhyperRange) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_range_mean(s : DsgraphhyperRange) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_range_scale(s : DsgraphhyperRange, f : Double) -> DsgraphhyperRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_range_add(a : DsgraphhyperRange, b : DsgraphhyperRange) -> DsgraphhyperRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_range_copy(s : DsgraphhyperRange) -> DsgraphhyperRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_range_fill(s : DsgraphhyperRange, v : Double) -> DsgraphhyperRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_range_min(s : DsgraphhyperRange) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_range_max(s : DsgraphhyperRange) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_range_to_string(s : DsgraphhyperRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_slice_make(size : Int) -> DsgraphhyperSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_slice_len(s : DsgraphhyperSlice) -> Int { s.size }

pub fn ds_graph_hyper_slice_get(s : DsgraphhyperSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_slice_set(s : DsgraphhyperSlice, i : Int, v : Double) -> DsgraphhyperSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_slice_sum(s : DsgraphhyperSlice) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_slice_mean(s : DsgraphhyperSlice) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_slice_scale(s : DsgraphhyperSlice, f : Double) -> DsgraphhyperSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_slice_add(a : DsgraphhyperSlice, b : DsgraphhyperSlice) -> DsgraphhyperSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_slice_copy(s : DsgraphhyperSlice) -> DsgraphhyperSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_slice_fill(s : DsgraphhyperSlice, v : Double) -> DsgraphhyperSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_slice_min(s : DsgraphhyperSlice) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_slice_max(s : DsgraphhyperSlice) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_slice_to_string(s : DsgraphhyperSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

