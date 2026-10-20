///===
/// extcore/ds_graph_multi

pub(all) struct DsgraphmultiPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_multi_make_point(x : Double, y : Double) -> DsgraphmultiPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_multi_make_point3(x : Double, y : Double, z : Double) -> DsgraphmultiPoint {
  { x, y, z, label: 0 }
}

pub fn ds_graph_multi_point_x(pt : DsgraphmultiPoint) -> Double { pt.x }

pub fn ds_graph_multi_point_y(pt : DsgraphmultiPoint) -> Double { pt.y }

pub fn ds_graph_multi_point_z(pt : DsgraphmultiPoint) -> Double { pt.z }

pub fn ds_graph_multi_point_label(pt : DsgraphmultiPoint) -> Int { pt.label }

pub fn ds_graph_multi_point_dist(a : DsgraphmultiPoint, b : DsgraphmultiPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_graph_multi_point_add(a : DsgraphmultiPoint, b : DsgraphmultiPoint) -> DsgraphmultiPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_graph_multi_point_sub(a : DsgraphmultiPoint, b : DsgraphmultiPoint) -> DsgraphmultiPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_graph_multi_point_scale(pt : DsgraphmultiPoint, s : Double) -> DsgraphmultiPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_graph_multi_point_dot(a : DsgraphmultiPoint, b : DsgraphmultiPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_graph_multi_point_cross(a : DsgraphmultiPoint, b : DsgraphmultiPoint) -> DsgraphmultiPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_graph_multi_point_norm(pt : DsgraphmultiPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_graph_multi_point_normalize(pt : DsgraphmultiPoint) -> DsgraphmultiPoint {
  let n = ds_graph_multi_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_graph_multi_point_scale(pt, 1.0 / n) }
}

pub fn ds_graph_multi_point_negate(pt : DsgraphmultiPoint) -> DsgraphmultiPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_graph_multi_point_mid(a : DsgraphmultiPoint, b : DsgraphmultiPoint) -> DsgraphmultiPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_graph_multi_point_lerp(a : DsgraphmultiPoint, b : DsgraphmultiPoint, t : Double) -> DsgraphmultiPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_graph_multi_point_to_string(pt : DsgraphmultiPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsgraphmultiSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_multi_make_series(vals : Array[Double], name : String) -> DsgraphmultiSeries {
  { vals, name, meta: 0 }
}

pub fn ds_graph_multi_series_len(s : DsgraphmultiSeries) -> Int { s.vals.length() }

pub fn ds_graph_multi_series_sum(s : DsgraphmultiSeries) -> Double { @_common.sum(s.vals) }

pub fn ds_graph_multi_series_mean(s : DsgraphmultiSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_graph_multi_series_min(s : DsgraphmultiSeries) -> Double { @_common.min(s.vals) }

pub fn ds_graph_multi_series_max(s : DsgraphmultiSeries) -> Double { @_common.max(s.vals) }

pub fn ds_graph_multi_series_range(s : DsgraphmultiSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_graph_multi_series_var(s : DsgraphmultiSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_graph_multi_series_std(s : DsgraphmultiSeries) -> Double { @_common.std(s.vals) }

pub fn ds_graph_multi_series_median(s : DsgraphmultiSeries) -> Double { @_common.median(s.vals) }

pub fn ds_graph_multi_series_scale(s : DsgraphmultiSeries, f : Double) -> DsgraphmultiSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_graph_multi_series_add(a : DsgraphmultiSeries, b : DsgraphmultiSeries) -> DsgraphmultiSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_graph_multi_series_sub(a : DsgraphmultiSeries, b : DsgraphmultiSeries) -> DsgraphmultiSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_graph_multi_series_normalize(s : DsgraphmultiSeries) -> DsgraphmultiSeries {
  let mn = ds_graph_multi_series_min(s)
  let mx = ds_graph_multi_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_graph_multi_series_cumsum(s : DsgraphmultiSeries) -> DsgraphmultiSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_graph_multi_series_to_string(s : DsgraphmultiSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphmultiMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_multi_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphmultiMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_multi_matrix_identity(n : Int) -> DsgraphmultiMatrix {
  let m = ds_graph_multi_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_graph_multi_matrix_get(m : DsgraphmultiMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_graph_multi_matrix_transpose(m : DsgraphmultiMatrix) -> DsgraphmultiMatrix {
  let result = ds_graph_multi_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_graph_multi_matrix_add(a : DsgraphmultiMatrix, b : DsgraphmultiMatrix) -> DsgraphmultiMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_graph_multi_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_graph_multi_matrix_scale(m : DsgraphmultiMatrix, s : Double) -> DsgraphmultiMatrix {
  let result = ds_graph_multi_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_graph_multi_matrix_multiply(a : DsgraphmultiMatrix, b : DsgraphmultiMatrix) -> DsgraphmultiMatrix {
  if a.cols != b.rows { return ds_graph_multi_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_graph_multi_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_graph_multi_matrix_trace(m : DsgraphmultiMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_graph_multi_matrix_det(m : DsgraphmultiMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_graph_multi_matrix_norm(m : DsgraphmultiMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_graph_multi_matrix_to_string(m : DsgraphmultiMatrix) -> String {
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

pub(all) struct DsgraphmultiVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_multi_make_vector(comps : Array[Double]) -> DsgraphmultiVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_multi_vector_zero(dim : Int) -> DsgraphmultiVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_graph_multi_vector_add(a : DsgraphmultiVector, b : DsgraphmultiVector) -> DsgraphmultiVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_graph_multi_vector_sub(a : DsgraphmultiVector, b : DsgraphmultiVector) -> DsgraphmultiVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_graph_multi_vector_scale(v : DsgraphmultiVector, s : Double) -> DsgraphmultiVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_graph_multi_vector_dot(a : DsgraphmultiVector, b : DsgraphmultiVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_graph_multi_vector_norm(v : DsgraphmultiVector) -> Double { @_common.sqrt(ds_graph_multi_vector_dot(v, v)) }

pub fn ds_graph_multi_vector_normalize(v : DsgraphmultiVector) -> DsgraphmultiVector {
  let n = ds_graph_multi_vector_norm(v)
  if n < 0.0000001 { v } else { ds_graph_multi_vector_scale(v, 1.0 / n) }
}

pub fn ds_graph_multi_vector_dist(a : DsgraphmultiVector, b : DsgraphmultiVector) -> Double {
  ds_graph_multi_vector_norm(ds_graph_multi_vector_sub(a, b))
}

pub fn ds_graph_multi_vector_to_string(v : DsgraphmultiVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_graph_multi_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_graph_multi_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_graph_multi_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_graph_multi_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_graph_multi_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_graph_multi_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_graph_multi_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_graph_multi_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_graph_multi_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_graph_multi_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_graph_multi_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_graph_multi_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_graph_multi_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_graph_multi_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_graph_multi_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_graph_multi_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_graph_multi_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_graph_multi_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_graph_multi_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_graph_multi_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_graph_multi_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_graph_multi_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_graph_multi_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_graph_multi_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_graph_multi_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_graph_multi_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_graph_multi_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_graph_multi_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_graph_multi_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsgraphmultiFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_frame_make(size : Int) -> DsgraphmultiFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_frame_len(s : DsgraphmultiFrame) -> Int { s.size }

pub fn ds_graph_multi_frame_get(s : DsgraphmultiFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_frame_set(s : DsgraphmultiFrame, i : Int, v : Double) -> DsgraphmultiFrame {
  let result = ds_graph_multi_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_frame_sum(s : DsgraphmultiFrame) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_frame_mean(s : DsgraphmultiFrame) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_frame_scale(s : DsgraphmultiFrame, f : Double) -> DsgraphmultiFrame {
  let result = ds_graph_multi_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_frame_add(a : DsgraphmultiFrame, b : DsgraphmultiFrame) -> DsgraphmultiFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_frame_copy(s : DsgraphmultiFrame) -> DsgraphmultiFrame {
  let result = ds_graph_multi_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_frame_fill(s : DsgraphmultiFrame, v : Double) -> DsgraphmultiFrame {
  let result = ds_graph_multi_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_frame_min(s : DsgraphmultiFrame) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_frame_max(s : DsgraphmultiFrame) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_frame_to_string(s : DsgraphmultiFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_table_make(size : Int) -> DsgraphmultiTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_table_len(s : DsgraphmultiTable) -> Int { s.size }

pub fn ds_graph_multi_table_get(s : DsgraphmultiTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_table_set(s : DsgraphmultiTable, i : Int, v : Double) -> DsgraphmultiTable {
  let result = ds_graph_multi_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_table_sum(s : DsgraphmultiTable) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_table_mean(s : DsgraphmultiTable) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_table_scale(s : DsgraphmultiTable, f : Double) -> DsgraphmultiTable {
  let result = ds_graph_multi_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_table_add(a : DsgraphmultiTable, b : DsgraphmultiTable) -> DsgraphmultiTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_table_copy(s : DsgraphmultiTable) -> DsgraphmultiTable {
  let result = ds_graph_multi_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_table_fill(s : DsgraphmultiTable, v : Double) -> DsgraphmultiTable {
  let result = ds_graph_multi_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_table_min(s : DsgraphmultiTable) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_table_max(s : DsgraphmultiTable) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_table_to_string(s : DsgraphmultiTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_graphn_make(size : Int) -> DsgraphmultiGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_graphn_len(s : DsgraphmultiGraphN) -> Int { s.size }

pub fn ds_graph_multi_graphn_get(s : DsgraphmultiGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_graphn_set(s : DsgraphmultiGraphN, i : Int, v : Double) -> DsgraphmultiGraphN {
  let result = ds_graph_multi_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_graphn_sum(s : DsgraphmultiGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_graphn_mean(s : DsgraphmultiGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_graphn_scale(s : DsgraphmultiGraphN, f : Double) -> DsgraphmultiGraphN {
  let result = ds_graph_multi_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_graphn_add(a : DsgraphmultiGraphN, b : DsgraphmultiGraphN) -> DsgraphmultiGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_graphn_copy(s : DsgraphmultiGraphN) -> DsgraphmultiGraphN {
  let result = ds_graph_multi_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_graphn_fill(s : DsgraphmultiGraphN, v : Double) -> DsgraphmultiGraphN {
  let result = ds_graph_multi_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_graphn_min(s : DsgraphmultiGraphN) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_graphn_max(s : DsgraphmultiGraphN) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_graphn_to_string(s : DsgraphmultiGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_node_make(size : Int) -> DsgraphmultiNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_node_len(s : DsgraphmultiNode) -> Int { s.size }

pub fn ds_graph_multi_node_get(s : DsgraphmultiNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_node_set(s : DsgraphmultiNode, i : Int, v : Double) -> DsgraphmultiNode {
  let result = ds_graph_multi_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_node_sum(s : DsgraphmultiNode) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_node_mean(s : DsgraphmultiNode) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_node_scale(s : DsgraphmultiNode, f : Double) -> DsgraphmultiNode {
  let result = ds_graph_multi_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_node_add(a : DsgraphmultiNode, b : DsgraphmultiNode) -> DsgraphmultiNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_node_copy(s : DsgraphmultiNode) -> DsgraphmultiNode {
  let result = ds_graph_multi_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_node_fill(s : DsgraphmultiNode, v : Double) -> DsgraphmultiNode {
  let result = ds_graph_multi_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_node_min(s : DsgraphmultiNode) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_node_max(s : DsgraphmultiNode) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_node_to_string(s : DsgraphmultiNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_edge_make(size : Int) -> DsgraphmultiEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_edge_len(s : DsgraphmultiEdge) -> Int { s.size }

pub fn ds_graph_multi_edge_get(s : DsgraphmultiEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_edge_set(s : DsgraphmultiEdge, i : Int, v : Double) -> DsgraphmultiEdge {
  let result = ds_graph_multi_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_edge_sum(s : DsgraphmultiEdge) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_edge_mean(s : DsgraphmultiEdge) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_edge_scale(s : DsgraphmultiEdge, f : Double) -> DsgraphmultiEdge {
  let result = ds_graph_multi_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_edge_add(a : DsgraphmultiEdge, b : DsgraphmultiEdge) -> DsgraphmultiEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_edge_copy(s : DsgraphmultiEdge) -> DsgraphmultiEdge {
  let result = ds_graph_multi_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_edge_fill(s : DsgraphmultiEdge, v : Double) -> DsgraphmultiEdge {
  let result = ds_graph_multi_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_edge_min(s : DsgraphmultiEdge) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_edge_max(s : DsgraphmultiEdge) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_edge_to_string(s : DsgraphmultiEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_path_make(size : Int) -> DsgraphmultiPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_path_len(s : DsgraphmultiPath) -> Int { s.size }

pub fn ds_graph_multi_path_get(s : DsgraphmultiPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_path_set(s : DsgraphmultiPath, i : Int, v : Double) -> DsgraphmultiPath {
  let result = ds_graph_multi_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_path_sum(s : DsgraphmultiPath) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_path_mean(s : DsgraphmultiPath) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_path_scale(s : DsgraphmultiPath, f : Double) -> DsgraphmultiPath {
  let result = ds_graph_multi_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_path_add(a : DsgraphmultiPath, b : DsgraphmultiPath) -> DsgraphmultiPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_path_copy(s : DsgraphmultiPath) -> DsgraphmultiPath {
  let result = ds_graph_multi_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_path_fill(s : DsgraphmultiPath, v : Double) -> DsgraphmultiPath {
  let result = ds_graph_multi_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_path_min(s : DsgraphmultiPath) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_path_max(s : DsgraphmultiPath) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_path_to_string(s : DsgraphmultiPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_cluster_make(size : Int) -> DsgraphmultiCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_cluster_len(s : DsgraphmultiCluster) -> Int { s.size }

pub fn ds_graph_multi_cluster_get(s : DsgraphmultiCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_cluster_set(s : DsgraphmultiCluster, i : Int, v : Double) -> DsgraphmultiCluster {
  let result = ds_graph_multi_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_cluster_sum(s : DsgraphmultiCluster) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_cluster_mean(s : DsgraphmultiCluster) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_cluster_scale(s : DsgraphmultiCluster, f : Double) -> DsgraphmultiCluster {
  let result = ds_graph_multi_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_cluster_add(a : DsgraphmultiCluster, b : DsgraphmultiCluster) -> DsgraphmultiCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_cluster_copy(s : DsgraphmultiCluster) -> DsgraphmultiCluster {
  let result = ds_graph_multi_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_cluster_fill(s : DsgraphmultiCluster, v : Double) -> DsgraphmultiCluster {
  let result = ds_graph_multi_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_cluster_min(s : DsgraphmultiCluster) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_cluster_max(s : DsgraphmultiCluster) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_cluster_to_string(s : DsgraphmultiCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_model_make(size : Int) -> DsgraphmultiModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_model_len(s : DsgraphmultiModel) -> Int { s.size }

pub fn ds_graph_multi_model_get(s : DsgraphmultiModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_model_set(s : DsgraphmultiModel, i : Int, v : Double) -> DsgraphmultiModel {
  let result = ds_graph_multi_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_model_sum(s : DsgraphmultiModel) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_model_mean(s : DsgraphmultiModel) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_model_scale(s : DsgraphmultiModel, f : Double) -> DsgraphmultiModel {
  let result = ds_graph_multi_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_model_add(a : DsgraphmultiModel, b : DsgraphmultiModel) -> DsgraphmultiModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_model_copy(s : DsgraphmultiModel) -> DsgraphmultiModel {
  let result = ds_graph_multi_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_model_fill(s : DsgraphmultiModel, v : Double) -> DsgraphmultiModel {
  let result = ds_graph_multi_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_model_min(s : DsgraphmultiModel) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_model_max(s : DsgraphmultiModel) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_model_to_string(s : DsgraphmultiModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_layer_make(size : Int) -> DsgraphmultiLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_layer_len(s : DsgraphmultiLayer) -> Int { s.size }

pub fn ds_graph_multi_layer_get(s : DsgraphmultiLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_layer_set(s : DsgraphmultiLayer, i : Int, v : Double) -> DsgraphmultiLayer {
  let result = ds_graph_multi_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_layer_sum(s : DsgraphmultiLayer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_layer_mean(s : DsgraphmultiLayer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_layer_scale(s : DsgraphmultiLayer, f : Double) -> DsgraphmultiLayer {
  let result = ds_graph_multi_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_layer_add(a : DsgraphmultiLayer, b : DsgraphmultiLayer) -> DsgraphmultiLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_layer_copy(s : DsgraphmultiLayer) -> DsgraphmultiLayer {
  let result = ds_graph_multi_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_layer_fill(s : DsgraphmultiLayer, v : Double) -> DsgraphmultiLayer {
  let result = ds_graph_multi_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_layer_min(s : DsgraphmultiLayer) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_layer_max(s : DsgraphmultiLayer) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_layer_to_string(s : DsgraphmultiLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_buffer_make(size : Int) -> DsgraphmultiBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_buffer_len(s : DsgraphmultiBuffer) -> Int { s.size }

pub fn ds_graph_multi_buffer_get(s : DsgraphmultiBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_buffer_set(s : DsgraphmultiBuffer, i : Int, v : Double) -> DsgraphmultiBuffer {
  let result = ds_graph_multi_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_buffer_sum(s : DsgraphmultiBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_buffer_mean(s : DsgraphmultiBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_buffer_scale(s : DsgraphmultiBuffer, f : Double) -> DsgraphmultiBuffer {
  let result = ds_graph_multi_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_buffer_add(a : DsgraphmultiBuffer, b : DsgraphmultiBuffer) -> DsgraphmultiBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_buffer_copy(s : DsgraphmultiBuffer) -> DsgraphmultiBuffer {
  let result = ds_graph_multi_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_buffer_fill(s : DsgraphmultiBuffer, v : Double) -> DsgraphmultiBuffer {
  let result = ds_graph_multi_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_buffer_min(s : DsgraphmultiBuffer) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_buffer_max(s : DsgraphmultiBuffer) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_buffer_to_string(s : DsgraphmultiBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_cursor_make(size : Int) -> DsgraphmultiCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_cursor_len(s : DsgraphmultiCursor) -> Int { s.size }

pub fn ds_graph_multi_cursor_get(s : DsgraphmultiCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_cursor_set(s : DsgraphmultiCursor, i : Int, v : Double) -> DsgraphmultiCursor {
  let result = ds_graph_multi_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_cursor_sum(s : DsgraphmultiCursor) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_cursor_mean(s : DsgraphmultiCursor) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_cursor_scale(s : DsgraphmultiCursor, f : Double) -> DsgraphmultiCursor {
  let result = ds_graph_multi_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_cursor_add(a : DsgraphmultiCursor, b : DsgraphmultiCursor) -> DsgraphmultiCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_cursor_copy(s : DsgraphmultiCursor) -> DsgraphmultiCursor {
  let result = ds_graph_multi_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_cursor_fill(s : DsgraphmultiCursor, v : Double) -> DsgraphmultiCursor {
  let result = ds_graph_multi_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_cursor_min(s : DsgraphmultiCursor) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_cursor_max(s : DsgraphmultiCursor) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_cursor_to_string(s : DsgraphmultiCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_view_make(size : Int) -> DsgraphmultiView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_view_len(s : DsgraphmultiView) -> Int { s.size }

pub fn ds_graph_multi_view_get(s : DsgraphmultiView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_view_set(s : DsgraphmultiView, i : Int, v : Double) -> DsgraphmultiView {
  let result = ds_graph_multi_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_view_sum(s : DsgraphmultiView) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_view_mean(s : DsgraphmultiView) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_view_scale(s : DsgraphmultiView, f : Double) -> DsgraphmultiView {
  let result = ds_graph_multi_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_view_add(a : DsgraphmultiView, b : DsgraphmultiView) -> DsgraphmultiView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_view_copy(s : DsgraphmultiView) -> DsgraphmultiView {
  let result = ds_graph_multi_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_view_fill(s : DsgraphmultiView, v : Double) -> DsgraphmultiView {
  let result = ds_graph_multi_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_view_min(s : DsgraphmultiView) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_view_max(s : DsgraphmultiView) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_view_to_string(s : DsgraphmultiView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_range_make(size : Int) -> DsgraphmultiRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_range_len(s : DsgraphmultiRange) -> Int { s.size }

pub fn ds_graph_multi_range_get(s : DsgraphmultiRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_range_set(s : DsgraphmultiRange, i : Int, v : Double) -> DsgraphmultiRange {
  let result = ds_graph_multi_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_range_sum(s : DsgraphmultiRange) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_range_mean(s : DsgraphmultiRange) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_range_scale(s : DsgraphmultiRange, f : Double) -> DsgraphmultiRange {
  let result = ds_graph_multi_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_range_add(a : DsgraphmultiRange, b : DsgraphmultiRange) -> DsgraphmultiRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_range_copy(s : DsgraphmultiRange) -> DsgraphmultiRange {
  let result = ds_graph_multi_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_range_fill(s : DsgraphmultiRange, v : Double) -> DsgraphmultiRange {
  let result = ds_graph_multi_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_range_min(s : DsgraphmultiRange) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_range_max(s : DsgraphmultiRange) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_range_to_string(s : DsgraphmultiRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_slice_make(size : Int) -> DsgraphmultiSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_slice_len(s : DsgraphmultiSlice) -> Int { s.size }

pub fn ds_graph_multi_slice_get(s : DsgraphmultiSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_slice_set(s : DsgraphmultiSlice, i : Int, v : Double) -> DsgraphmultiSlice {
  let result = ds_graph_multi_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_slice_sum(s : DsgraphmultiSlice) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_slice_mean(s : DsgraphmultiSlice) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_slice_scale(s : DsgraphmultiSlice, f : Double) -> DsgraphmultiSlice {
  let result = ds_graph_multi_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_slice_add(a : DsgraphmultiSlice, b : DsgraphmultiSlice) -> DsgraphmultiSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_slice_copy(s : DsgraphmultiSlice) -> DsgraphmultiSlice {
  let result = ds_graph_multi_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_slice_fill(s : DsgraphmultiSlice, v : Double) -> DsgraphmultiSlice {
  let result = ds_graph_multi_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_slice_min(s : DsgraphmultiSlice) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_slice_max(s : DsgraphmultiSlice) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_slice_to_string(s : DsgraphmultiSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

