///===
/// extcore/ds_graph_adj_list

pub(all) struct DsgraphadjlistPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_adj_list_make_point(x : Double, y : Double) -> DsgraphadjlistPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_adj_list_make_point3(x : Double, y : Double, z : Double) -> DsgraphadjlistPoint {
  { x, y, z, label: 0 }
}

pub fn ds_graph_adj_list_point_x(pt : DsgraphadjlistPoint) -> Double { pt.x }

pub fn ds_graph_adj_list_point_y(pt : DsgraphadjlistPoint) -> Double { pt.y }

pub fn ds_graph_adj_list_point_z(pt : DsgraphadjlistPoint) -> Double { pt.z }

pub fn ds_graph_adj_list_point_label(pt : DsgraphadjlistPoint) -> Int { pt.label }

pub fn ds_graph_adj_list_point_dist(a : DsgraphadjlistPoint, b : DsgraphadjlistPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_graph_adj_list_point_add(a : DsgraphadjlistPoint, b : DsgraphadjlistPoint) -> DsgraphadjlistPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_graph_adj_list_point_sub(a : DsgraphadjlistPoint, b : DsgraphadjlistPoint) -> DsgraphadjlistPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_graph_adj_list_point_scale(pt : DsgraphadjlistPoint, s : Double) -> DsgraphadjlistPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_graph_adj_list_point_dot(a : DsgraphadjlistPoint, b : DsgraphadjlistPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_graph_adj_list_point_cross(a : DsgraphadjlistPoint, b : DsgraphadjlistPoint) -> DsgraphadjlistPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_graph_adj_list_point_norm(pt : DsgraphadjlistPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_graph_adj_list_point_normalize(pt : DsgraphadjlistPoint) -> DsgraphadjlistPoint {
  let n = ds_graph_adj_list_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_graph_adj_list_point_scale(pt, 1.0 / n) }
}

pub fn ds_graph_adj_list_point_negate(pt : DsgraphadjlistPoint) -> DsgraphadjlistPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_graph_adj_list_point_mid(a : DsgraphadjlistPoint, b : DsgraphadjlistPoint) -> DsgraphadjlistPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_graph_adj_list_point_lerp(a : DsgraphadjlistPoint, b : DsgraphadjlistPoint, t : Double) -> DsgraphadjlistPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_graph_adj_list_point_to_string(pt : DsgraphadjlistPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsgraphadjlistSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_adj_list_make_series(vals : Array[Double], name : String) -> DsgraphadjlistSeries {
  { vals, name, meta: 0 }
}

pub fn ds_graph_adj_list_series_len(s : DsgraphadjlistSeries) -> Int { s.vals.length() }

pub fn ds_graph_adj_list_series_sum(s : DsgraphadjlistSeries) -> Double { @_common.sum(s.vals) }

pub fn ds_graph_adj_list_series_mean(s : DsgraphadjlistSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_graph_adj_list_series_min(s : DsgraphadjlistSeries) -> Double { @_common.min(s.vals) }

pub fn ds_graph_adj_list_series_max(s : DsgraphadjlistSeries) -> Double { @_common.max(s.vals) }

pub fn ds_graph_adj_list_series_range(s : DsgraphadjlistSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_graph_adj_list_series_var(s : DsgraphadjlistSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_graph_adj_list_series_std(s : DsgraphadjlistSeries) -> Double { @_common.std(s.vals) }

pub fn ds_graph_adj_list_series_median(s : DsgraphadjlistSeries) -> Double { @_common.median(s.vals) }

pub fn ds_graph_adj_list_series_scale(s : DsgraphadjlistSeries, f : Double) -> DsgraphadjlistSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_graph_adj_list_series_add(a : DsgraphadjlistSeries, b : DsgraphadjlistSeries) -> DsgraphadjlistSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_graph_adj_list_series_sub(a : DsgraphadjlistSeries, b : DsgraphadjlistSeries) -> DsgraphadjlistSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_graph_adj_list_series_normalize(s : DsgraphadjlistSeries) -> DsgraphadjlistSeries {
  let mn = ds_graph_adj_list_series_min(s)
  let mx = ds_graph_adj_list_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_graph_adj_list_series_cumsum(s : DsgraphadjlistSeries) -> DsgraphadjlistSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_graph_adj_list_series_to_string(s : DsgraphadjlistSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphadjlistMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_adj_list_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphadjlistMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_adj_list_matrix_identity(n : Int) -> DsgraphadjlistMatrix {
  let m = ds_graph_adj_list_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_graph_adj_list_matrix_get(m : DsgraphadjlistMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_graph_adj_list_matrix_transpose(m : DsgraphadjlistMatrix) -> DsgraphadjlistMatrix {
  let result = ds_graph_adj_list_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_graph_adj_list_matrix_add(a : DsgraphadjlistMatrix, b : DsgraphadjlistMatrix) -> DsgraphadjlistMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_graph_adj_list_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_graph_adj_list_matrix_scale(m : DsgraphadjlistMatrix, s : Double) -> DsgraphadjlistMatrix {
  let result = ds_graph_adj_list_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_graph_adj_list_matrix_multiply(a : DsgraphadjlistMatrix, b : DsgraphadjlistMatrix) -> DsgraphadjlistMatrix {
  if a.cols != b.rows { return ds_graph_adj_list_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_graph_adj_list_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_graph_adj_list_matrix_trace(m : DsgraphadjlistMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_graph_adj_list_matrix_det(m : DsgraphadjlistMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_graph_adj_list_matrix_norm(m : DsgraphadjlistMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_graph_adj_list_matrix_to_string(m : DsgraphadjlistMatrix) -> String {
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

pub(all) struct DsgraphadjlistVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_adj_list_make_vector(comps : Array[Double]) -> DsgraphadjlistVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_adj_list_vector_zero(dim : Int) -> DsgraphadjlistVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_graph_adj_list_vector_add(a : DsgraphadjlistVector, b : DsgraphadjlistVector) -> DsgraphadjlistVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_graph_adj_list_vector_sub(a : DsgraphadjlistVector, b : DsgraphadjlistVector) -> DsgraphadjlistVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_graph_adj_list_vector_scale(v : DsgraphadjlistVector, s : Double) -> DsgraphadjlistVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_graph_adj_list_vector_dot(a : DsgraphadjlistVector, b : DsgraphadjlistVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_graph_adj_list_vector_norm(v : DsgraphadjlistVector) -> Double { @_common.sqrt(ds_graph_adj_list_vector_dot(v, v)) }

pub fn ds_graph_adj_list_vector_normalize(v : DsgraphadjlistVector) -> DsgraphadjlistVector {
  let n = ds_graph_adj_list_vector_norm(v)
  if n < 0.0000001 { v } else { ds_graph_adj_list_vector_scale(v, 1.0 / n) }
}

pub fn ds_graph_adj_list_vector_dist(a : DsgraphadjlistVector, b : DsgraphadjlistVector) -> Double {
  ds_graph_adj_list_vector_norm(ds_graph_adj_list_vector_sub(a, b))
}

pub fn ds_graph_adj_list_vector_to_string(v : DsgraphadjlistVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_graph_adj_list_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_graph_adj_list_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_graph_adj_list_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_graph_adj_list_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_graph_adj_list_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_graph_adj_list_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_graph_adj_list_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_graph_adj_list_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_graph_adj_list_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_graph_adj_list_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_graph_adj_list_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_graph_adj_list_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_graph_adj_list_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_graph_adj_list_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_graph_adj_list_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_graph_adj_list_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_graph_adj_list_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_graph_adj_list_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_graph_adj_list_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_graph_adj_list_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_graph_adj_list_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_graph_adj_list_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_graph_adj_list_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_graph_adj_list_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_graph_adj_list_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_graph_adj_list_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_graph_adj_list_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_graph_adj_list_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_graph_adj_list_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsgraphadjlistFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_frame_make(size : Int) -> DsgraphadjlistFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_frame_len(s : DsgraphadjlistFrame) -> Int { s.size }

pub fn ds_graph_adj_list_frame_get(s : DsgraphadjlistFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_frame_set(s : DsgraphadjlistFrame, i : Int, v : Double) -> DsgraphadjlistFrame {
  let result = ds_graph_adj_list_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_frame_sum(s : DsgraphadjlistFrame) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_frame_mean(s : DsgraphadjlistFrame) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_frame_scale(s : DsgraphadjlistFrame, f : Double) -> DsgraphadjlistFrame {
  let result = ds_graph_adj_list_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_list_frame_add(a : DsgraphadjlistFrame, b : DsgraphadjlistFrame) -> DsgraphadjlistFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_list_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_list_frame_copy(s : DsgraphadjlistFrame) -> DsgraphadjlistFrame {
  let result = ds_graph_adj_list_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_list_frame_fill(s : DsgraphadjlistFrame, v : Double) -> DsgraphadjlistFrame {
  let result = ds_graph_adj_list_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_frame_min(s : DsgraphadjlistFrame) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_frame_max(s : DsgraphadjlistFrame) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_frame_to_string(s : DsgraphadjlistFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_table_make(size : Int) -> DsgraphadjlistTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_table_len(s : DsgraphadjlistTable) -> Int { s.size }

pub fn ds_graph_adj_list_table_get(s : DsgraphadjlistTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_table_set(s : DsgraphadjlistTable, i : Int, v : Double) -> DsgraphadjlistTable {
  let result = ds_graph_adj_list_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_table_sum(s : DsgraphadjlistTable) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_table_mean(s : DsgraphadjlistTable) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_table_scale(s : DsgraphadjlistTable, f : Double) -> DsgraphadjlistTable {
  let result = ds_graph_adj_list_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_list_table_add(a : DsgraphadjlistTable, b : DsgraphadjlistTable) -> DsgraphadjlistTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_list_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_list_table_copy(s : DsgraphadjlistTable) -> DsgraphadjlistTable {
  let result = ds_graph_adj_list_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_list_table_fill(s : DsgraphadjlistTable, v : Double) -> DsgraphadjlistTable {
  let result = ds_graph_adj_list_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_table_min(s : DsgraphadjlistTable) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_table_max(s : DsgraphadjlistTable) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_table_to_string(s : DsgraphadjlistTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_graphn_make(size : Int) -> DsgraphadjlistGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_graphn_len(s : DsgraphadjlistGraphN) -> Int { s.size }

pub fn ds_graph_adj_list_graphn_get(s : DsgraphadjlistGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_graphn_set(s : DsgraphadjlistGraphN, i : Int, v : Double) -> DsgraphadjlistGraphN {
  let result = ds_graph_adj_list_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_graphn_sum(s : DsgraphadjlistGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_graphn_mean(s : DsgraphadjlistGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_graphn_scale(s : DsgraphadjlistGraphN, f : Double) -> DsgraphadjlistGraphN {
  let result = ds_graph_adj_list_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_list_graphn_add(a : DsgraphadjlistGraphN, b : DsgraphadjlistGraphN) -> DsgraphadjlistGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_list_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_list_graphn_copy(s : DsgraphadjlistGraphN) -> DsgraphadjlistGraphN {
  let result = ds_graph_adj_list_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_list_graphn_fill(s : DsgraphadjlistGraphN, v : Double) -> DsgraphadjlistGraphN {
  let result = ds_graph_adj_list_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_graphn_min(s : DsgraphadjlistGraphN) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_graphn_max(s : DsgraphadjlistGraphN) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_graphn_to_string(s : DsgraphadjlistGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_node_make(size : Int) -> DsgraphadjlistNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_node_len(s : DsgraphadjlistNode) -> Int { s.size }

pub fn ds_graph_adj_list_node_get(s : DsgraphadjlistNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_node_set(s : DsgraphadjlistNode, i : Int, v : Double) -> DsgraphadjlistNode {
  let result = ds_graph_adj_list_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_node_sum(s : DsgraphadjlistNode) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_node_mean(s : DsgraphadjlistNode) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_node_scale(s : DsgraphadjlistNode, f : Double) -> DsgraphadjlistNode {
  let result = ds_graph_adj_list_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_list_node_add(a : DsgraphadjlistNode, b : DsgraphadjlistNode) -> DsgraphadjlistNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_list_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_list_node_copy(s : DsgraphadjlistNode) -> DsgraphadjlistNode {
  let result = ds_graph_adj_list_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_list_node_fill(s : DsgraphadjlistNode, v : Double) -> DsgraphadjlistNode {
  let result = ds_graph_adj_list_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_node_min(s : DsgraphadjlistNode) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_node_max(s : DsgraphadjlistNode) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_node_to_string(s : DsgraphadjlistNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_edge_make(size : Int) -> DsgraphadjlistEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_edge_len(s : DsgraphadjlistEdge) -> Int { s.size }

pub fn ds_graph_adj_list_edge_get(s : DsgraphadjlistEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_edge_set(s : DsgraphadjlistEdge, i : Int, v : Double) -> DsgraphadjlistEdge {
  let result = ds_graph_adj_list_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_edge_sum(s : DsgraphadjlistEdge) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_edge_mean(s : DsgraphadjlistEdge) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_edge_scale(s : DsgraphadjlistEdge, f : Double) -> DsgraphadjlistEdge {
  let result = ds_graph_adj_list_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_list_edge_add(a : DsgraphadjlistEdge, b : DsgraphadjlistEdge) -> DsgraphadjlistEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_list_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_list_edge_copy(s : DsgraphadjlistEdge) -> DsgraphadjlistEdge {
  let result = ds_graph_adj_list_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_list_edge_fill(s : DsgraphadjlistEdge, v : Double) -> DsgraphadjlistEdge {
  let result = ds_graph_adj_list_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_edge_min(s : DsgraphadjlistEdge) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_edge_max(s : DsgraphadjlistEdge) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_edge_to_string(s : DsgraphadjlistEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_path_make(size : Int) -> DsgraphadjlistPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_path_len(s : DsgraphadjlistPath) -> Int { s.size }

pub fn ds_graph_adj_list_path_get(s : DsgraphadjlistPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_path_set(s : DsgraphadjlistPath, i : Int, v : Double) -> DsgraphadjlistPath {
  let result = ds_graph_adj_list_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_path_sum(s : DsgraphadjlistPath) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_path_mean(s : DsgraphadjlistPath) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_path_scale(s : DsgraphadjlistPath, f : Double) -> DsgraphadjlistPath {
  let result = ds_graph_adj_list_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_list_path_add(a : DsgraphadjlistPath, b : DsgraphadjlistPath) -> DsgraphadjlistPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_list_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_list_path_copy(s : DsgraphadjlistPath) -> DsgraphadjlistPath {
  let result = ds_graph_adj_list_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_list_path_fill(s : DsgraphadjlistPath, v : Double) -> DsgraphadjlistPath {
  let result = ds_graph_adj_list_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_path_min(s : DsgraphadjlistPath) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_path_max(s : DsgraphadjlistPath) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_path_to_string(s : DsgraphadjlistPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_cluster_make(size : Int) -> DsgraphadjlistCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_cluster_len(s : DsgraphadjlistCluster) -> Int { s.size }

pub fn ds_graph_adj_list_cluster_get(s : DsgraphadjlistCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_cluster_set(s : DsgraphadjlistCluster, i : Int, v : Double) -> DsgraphadjlistCluster {
  let result = ds_graph_adj_list_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_cluster_sum(s : DsgraphadjlistCluster) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_cluster_mean(s : DsgraphadjlistCluster) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_cluster_scale(s : DsgraphadjlistCluster, f : Double) -> DsgraphadjlistCluster {
  let result = ds_graph_adj_list_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_list_cluster_add(a : DsgraphadjlistCluster, b : DsgraphadjlistCluster) -> DsgraphadjlistCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_list_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_list_cluster_copy(s : DsgraphadjlistCluster) -> DsgraphadjlistCluster {
  let result = ds_graph_adj_list_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_list_cluster_fill(s : DsgraphadjlistCluster, v : Double) -> DsgraphadjlistCluster {
  let result = ds_graph_adj_list_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_cluster_min(s : DsgraphadjlistCluster) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_cluster_max(s : DsgraphadjlistCluster) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_cluster_to_string(s : DsgraphadjlistCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_model_make(size : Int) -> DsgraphadjlistModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_model_len(s : DsgraphadjlistModel) -> Int { s.size }

pub fn ds_graph_adj_list_model_get(s : DsgraphadjlistModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_model_set(s : DsgraphadjlistModel, i : Int, v : Double) -> DsgraphadjlistModel {
  let result = ds_graph_adj_list_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_model_sum(s : DsgraphadjlistModel) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_model_mean(s : DsgraphadjlistModel) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_model_scale(s : DsgraphadjlistModel, f : Double) -> DsgraphadjlistModel {
  let result = ds_graph_adj_list_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_list_model_add(a : DsgraphadjlistModel, b : DsgraphadjlistModel) -> DsgraphadjlistModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_list_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_list_model_copy(s : DsgraphadjlistModel) -> DsgraphadjlistModel {
  let result = ds_graph_adj_list_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_list_model_fill(s : DsgraphadjlistModel, v : Double) -> DsgraphadjlistModel {
  let result = ds_graph_adj_list_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_model_min(s : DsgraphadjlistModel) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_model_max(s : DsgraphadjlistModel) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_model_to_string(s : DsgraphadjlistModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_layer_make(size : Int) -> DsgraphadjlistLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_layer_len(s : DsgraphadjlistLayer) -> Int { s.size }

pub fn ds_graph_adj_list_layer_get(s : DsgraphadjlistLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_layer_set(s : DsgraphadjlistLayer, i : Int, v : Double) -> DsgraphadjlistLayer {
  let result = ds_graph_adj_list_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_layer_sum(s : DsgraphadjlistLayer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_layer_mean(s : DsgraphadjlistLayer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_layer_scale(s : DsgraphadjlistLayer, f : Double) -> DsgraphadjlistLayer {
  let result = ds_graph_adj_list_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_list_layer_add(a : DsgraphadjlistLayer, b : DsgraphadjlistLayer) -> DsgraphadjlistLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_list_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_list_layer_copy(s : DsgraphadjlistLayer) -> DsgraphadjlistLayer {
  let result = ds_graph_adj_list_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_list_layer_fill(s : DsgraphadjlistLayer, v : Double) -> DsgraphadjlistLayer {
  let result = ds_graph_adj_list_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_layer_min(s : DsgraphadjlistLayer) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_layer_max(s : DsgraphadjlistLayer) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_layer_to_string(s : DsgraphadjlistLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_buffer_make(size : Int) -> DsgraphadjlistBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_buffer_len(s : DsgraphadjlistBuffer) -> Int { s.size }

pub fn ds_graph_adj_list_buffer_get(s : DsgraphadjlistBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_buffer_set(s : DsgraphadjlistBuffer, i : Int, v : Double) -> DsgraphadjlistBuffer {
  let result = ds_graph_adj_list_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_buffer_sum(s : DsgraphadjlistBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_buffer_mean(s : DsgraphadjlistBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_buffer_scale(s : DsgraphadjlistBuffer, f : Double) -> DsgraphadjlistBuffer {
  let result = ds_graph_adj_list_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_list_buffer_add(a : DsgraphadjlistBuffer, b : DsgraphadjlistBuffer) -> DsgraphadjlistBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_list_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_list_buffer_copy(s : DsgraphadjlistBuffer) -> DsgraphadjlistBuffer {
  let result = ds_graph_adj_list_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_list_buffer_fill(s : DsgraphadjlistBuffer, v : Double) -> DsgraphadjlistBuffer {
  let result = ds_graph_adj_list_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_buffer_min(s : DsgraphadjlistBuffer) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_buffer_max(s : DsgraphadjlistBuffer) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_buffer_to_string(s : DsgraphadjlistBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_cursor_make(size : Int) -> DsgraphadjlistCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_cursor_len(s : DsgraphadjlistCursor) -> Int { s.size }

pub fn ds_graph_adj_list_cursor_get(s : DsgraphadjlistCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_cursor_set(s : DsgraphadjlistCursor, i : Int, v : Double) -> DsgraphadjlistCursor {
  let result = ds_graph_adj_list_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_cursor_sum(s : DsgraphadjlistCursor) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_cursor_mean(s : DsgraphadjlistCursor) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_cursor_scale(s : DsgraphadjlistCursor, f : Double) -> DsgraphadjlistCursor {
  let result = ds_graph_adj_list_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_list_cursor_add(a : DsgraphadjlistCursor, b : DsgraphadjlistCursor) -> DsgraphadjlistCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_list_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_list_cursor_copy(s : DsgraphadjlistCursor) -> DsgraphadjlistCursor {
  let result = ds_graph_adj_list_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_list_cursor_fill(s : DsgraphadjlistCursor, v : Double) -> DsgraphadjlistCursor {
  let result = ds_graph_adj_list_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_cursor_min(s : DsgraphadjlistCursor) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_cursor_max(s : DsgraphadjlistCursor) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_cursor_to_string(s : DsgraphadjlistCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_view_make(size : Int) -> DsgraphadjlistView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_view_len(s : DsgraphadjlistView) -> Int { s.size }

pub fn ds_graph_adj_list_view_get(s : DsgraphadjlistView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_view_set(s : DsgraphadjlistView, i : Int, v : Double) -> DsgraphadjlistView {
  let result = ds_graph_adj_list_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_view_sum(s : DsgraphadjlistView) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_view_mean(s : DsgraphadjlistView) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_view_scale(s : DsgraphadjlistView, f : Double) -> DsgraphadjlistView {
  let result = ds_graph_adj_list_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_list_view_add(a : DsgraphadjlistView, b : DsgraphadjlistView) -> DsgraphadjlistView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_list_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_list_view_copy(s : DsgraphadjlistView) -> DsgraphadjlistView {
  let result = ds_graph_adj_list_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_list_view_fill(s : DsgraphadjlistView, v : Double) -> DsgraphadjlistView {
  let result = ds_graph_adj_list_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_view_min(s : DsgraphadjlistView) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_view_max(s : DsgraphadjlistView) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_view_to_string(s : DsgraphadjlistView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_range_make(size : Int) -> DsgraphadjlistRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_range_len(s : DsgraphadjlistRange) -> Int { s.size }

pub fn ds_graph_adj_list_range_get(s : DsgraphadjlistRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_range_set(s : DsgraphadjlistRange, i : Int, v : Double) -> DsgraphadjlistRange {
  let result = ds_graph_adj_list_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_range_sum(s : DsgraphadjlistRange) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_range_mean(s : DsgraphadjlistRange) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_range_scale(s : DsgraphadjlistRange, f : Double) -> DsgraphadjlistRange {
  let result = ds_graph_adj_list_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_list_range_add(a : DsgraphadjlistRange, b : DsgraphadjlistRange) -> DsgraphadjlistRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_list_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_list_range_copy(s : DsgraphadjlistRange) -> DsgraphadjlistRange {
  let result = ds_graph_adj_list_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_list_range_fill(s : DsgraphadjlistRange, v : Double) -> DsgraphadjlistRange {
  let result = ds_graph_adj_list_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_range_min(s : DsgraphadjlistRange) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_range_max(s : DsgraphadjlistRange) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_range_to_string(s : DsgraphadjlistRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_slice_make(size : Int) -> DsgraphadjlistSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_slice_len(s : DsgraphadjlistSlice) -> Int { s.size }

pub fn ds_graph_adj_list_slice_get(s : DsgraphadjlistSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_slice_set(s : DsgraphadjlistSlice, i : Int, v : Double) -> DsgraphadjlistSlice {
  let result = ds_graph_adj_list_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_slice_sum(s : DsgraphadjlistSlice) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_slice_mean(s : DsgraphadjlistSlice) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_slice_scale(s : DsgraphadjlistSlice, f : Double) -> DsgraphadjlistSlice {
  let result = ds_graph_adj_list_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_list_slice_add(a : DsgraphadjlistSlice, b : DsgraphadjlistSlice) -> DsgraphadjlistSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_list_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_list_slice_copy(s : DsgraphadjlistSlice) -> DsgraphadjlistSlice {
  let result = ds_graph_adj_list_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_list_slice_fill(s : DsgraphadjlistSlice, v : Double) -> DsgraphadjlistSlice {
  let result = ds_graph_adj_list_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_list_slice_min(s : DsgraphadjlistSlice) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_slice_max(s : DsgraphadjlistSlice) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_slice_to_string(s : DsgraphadjlistSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

