///===
/// extcore/ds_list_block

pub(all) struct DslistblockPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_block_make_point(x : Double, y : Double) -> DslistblockPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_block_make_point3(x : Double, y : Double, z : Double) -> DslistblockPoint {
  { x, y, z, label: 0 }
}

pub fn ds_list_block_point_x(pt : DslistblockPoint) -> Double { pt.x }

pub fn ds_list_block_point_y(pt : DslistblockPoint) -> Double { pt.y }

pub fn ds_list_block_point_z(pt : DslistblockPoint) -> Double { pt.z }

pub fn ds_list_block_point_label(pt : DslistblockPoint) -> Int { pt.label }

pub fn ds_list_block_point_dist(a : DslistblockPoint, b : DslistblockPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_list_block_point_add(a : DslistblockPoint, b : DslistblockPoint) -> DslistblockPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_list_block_point_sub(a : DslistblockPoint, b : DslistblockPoint) -> DslistblockPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_list_block_point_scale(pt : DslistblockPoint, s : Double) -> DslistblockPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_list_block_point_dot(a : DslistblockPoint, b : DslistblockPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_list_block_point_cross(a : DslistblockPoint, b : DslistblockPoint) -> DslistblockPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_list_block_point_norm(pt : DslistblockPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_list_block_point_normalize(pt : DslistblockPoint) -> DslistblockPoint {
  let n = ds_list_block_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_list_block_point_scale(pt, 1.0 / n) }
}

pub fn ds_list_block_point_negate(pt : DslistblockPoint) -> DslistblockPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_list_block_point_mid(a : DslistblockPoint, b : DslistblockPoint) -> DslistblockPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_list_block_point_lerp(a : DslistblockPoint, b : DslistblockPoint, t : Double) -> DslistblockPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_list_block_point_to_string(pt : DslistblockPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DslistblockSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_block_make_series(vals : Array[Double], name : String) -> DslistblockSeries {
  { vals, name, meta: 0 }
}

pub fn ds_list_block_series_len(s : DslistblockSeries) -> Int { s.vals.length() }

pub fn ds_list_block_series_sum(s : DslistblockSeries) -> Double { @_common.sum(s.vals) }

pub fn ds_list_block_series_mean(s : DslistblockSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_list_block_series_min(s : DslistblockSeries) -> Double { @_common.min(s.vals) }

pub fn ds_list_block_series_max(s : DslistblockSeries) -> Double { @_common.max(s.vals) }

pub fn ds_list_block_series_range(s : DslistblockSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_list_block_series_var(s : DslistblockSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_list_block_series_std(s : DslistblockSeries) -> Double { @_common.std(s.vals) }

pub fn ds_list_block_series_median(s : DslistblockSeries) -> Double { @_common.median(s.vals) }

pub fn ds_list_block_series_scale(s : DslistblockSeries, f : Double) -> DslistblockSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_list_block_series_add(a : DslistblockSeries, b : DslistblockSeries) -> DslistblockSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_list_block_series_sub(a : DslistblockSeries, b : DslistblockSeries) -> DslistblockSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_list_block_series_normalize(s : DslistblockSeries) -> DslistblockSeries {
  let mn = ds_list_block_series_min(s)
  let mx = ds_list_block_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_list_block_series_cumsum(s : DslistblockSeries) -> DslistblockSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_list_block_series_to_string(s : DslistblockSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistblockMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_block_make_matrix(rows : Int, cols : Int, val : Double) -> DslistblockMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_block_matrix_identity(n : Int) -> DslistblockMatrix {
  let m = ds_list_block_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_list_block_matrix_get(m : DslistblockMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_list_block_matrix_transpose(m : DslistblockMatrix) -> DslistblockMatrix {
  let result = ds_list_block_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_list_block_matrix_add(a : DslistblockMatrix, b : DslistblockMatrix) -> DslistblockMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_list_block_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_list_block_matrix_scale(m : DslistblockMatrix, s : Double) -> DslistblockMatrix {
  let result = ds_list_block_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_list_block_matrix_multiply(a : DslistblockMatrix, b : DslistblockMatrix) -> DslistblockMatrix {
  if a.cols != b.rows { return ds_list_block_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_list_block_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_list_block_matrix_trace(m : DslistblockMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_list_block_matrix_det(m : DslistblockMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_list_block_matrix_norm(m : DslistblockMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_list_block_matrix_to_string(m : DslistblockMatrix) -> String {
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

pub(all) struct DslistblockVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_block_make_vector(comps : Array[Double]) -> DslistblockVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_block_vector_zero(dim : Int) -> DslistblockVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_list_block_vector_add(a : DslistblockVector, b : DslistblockVector) -> DslistblockVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_list_block_vector_sub(a : DslistblockVector, b : DslistblockVector) -> DslistblockVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_list_block_vector_scale(v : DslistblockVector, s : Double) -> DslistblockVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_list_block_vector_dot(a : DslistblockVector, b : DslistblockVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_list_block_vector_norm(v : DslistblockVector) -> Double { @_common.sqrt(ds_list_block_vector_dot(v, v)) }

pub fn ds_list_block_vector_normalize(v : DslistblockVector) -> DslistblockVector {
  let n = ds_list_block_vector_norm(v)
  if n < 0.0000001 { v } else { ds_list_block_vector_scale(v, 1.0 / n) }
}

pub fn ds_list_block_vector_dist(a : DslistblockVector, b : DslistblockVector) -> Double {
  ds_list_block_vector_norm(ds_list_block_vector_sub(a, b))
}

pub fn ds_list_block_vector_to_string(v : DslistblockVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_block_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_list_block_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_list_block_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_list_block_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_list_block_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_list_block_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_list_block_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_list_block_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_list_block_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_list_block_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_list_block_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_list_block_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_list_block_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_list_block_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_list_block_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_list_block_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_list_block_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_list_block_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_list_block_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_list_block_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_list_block_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_list_block_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_list_block_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_list_block_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_list_block_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_list_block_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_list_block_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_list_block_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_list_block_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DslistblockFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_frame_make(size : Int) -> DslistblockFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_frame_len(s : DslistblockFrame) -> Int { s.size }

pub fn ds_list_block_frame_get(s : DslistblockFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_frame_set(s : DslistblockFrame, i : Int, v : Double) -> DslistblockFrame {
  let result = ds_list_block_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_frame_sum(s : DslistblockFrame) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_frame_mean(s : DslistblockFrame) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_frame_scale(s : DslistblockFrame, f : Double) -> DslistblockFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_frame_add(a : DslistblockFrame, b : DslistblockFrame) -> DslistblockFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_frame_copy(s : DslistblockFrame) -> DslistblockFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_frame_fill(s : DslistblockFrame, v : Double) -> DslistblockFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_frame_min(s : DslistblockFrame) -> Double { @_common.min(s.data) }

pub fn ds_list_block_frame_max(s : DslistblockFrame) -> Double { @_common.max(s.data) }

pub fn ds_list_block_frame_to_string(s : DslistblockFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_table_make(size : Int) -> DslistblockTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_table_len(s : DslistblockTable) -> Int { s.size }

pub fn ds_list_block_table_get(s : DslistblockTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_table_set(s : DslistblockTable, i : Int, v : Double) -> DslistblockTable {
  let result = ds_list_block_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_table_sum(s : DslistblockTable) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_table_mean(s : DslistblockTable) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_table_scale(s : DslistblockTable, f : Double) -> DslistblockTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_table_add(a : DslistblockTable, b : DslistblockTable) -> DslistblockTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_table_copy(s : DslistblockTable) -> DslistblockTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_table_fill(s : DslistblockTable, v : Double) -> DslistblockTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_table_min(s : DslistblockTable) -> Double { @_common.min(s.data) }

pub fn ds_list_block_table_max(s : DslistblockTable) -> Double { @_common.max(s.data) }

pub fn ds_list_block_table_to_string(s : DslistblockTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_graphn_make(size : Int) -> DslistblockGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_graphn_len(s : DslistblockGraphN) -> Int { s.size }

pub fn ds_list_block_graphn_get(s : DslistblockGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_graphn_set(s : DslistblockGraphN, i : Int, v : Double) -> DslistblockGraphN {
  let result = ds_list_block_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_graphn_sum(s : DslistblockGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_graphn_mean(s : DslistblockGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_graphn_scale(s : DslistblockGraphN, f : Double) -> DslistblockGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_graphn_add(a : DslistblockGraphN, b : DslistblockGraphN) -> DslistblockGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_graphn_copy(s : DslistblockGraphN) -> DslistblockGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_graphn_fill(s : DslistblockGraphN, v : Double) -> DslistblockGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_graphn_min(s : DslistblockGraphN) -> Double { @_common.min(s.data) }

pub fn ds_list_block_graphn_max(s : DslistblockGraphN) -> Double { @_common.max(s.data) }

pub fn ds_list_block_graphn_to_string(s : DslistblockGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_node_make(size : Int) -> DslistblockNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_node_len(s : DslistblockNode) -> Int { s.size }

pub fn ds_list_block_node_get(s : DslistblockNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_node_set(s : DslistblockNode, i : Int, v : Double) -> DslistblockNode {
  let result = ds_list_block_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_node_sum(s : DslistblockNode) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_node_mean(s : DslistblockNode) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_node_scale(s : DslistblockNode, f : Double) -> DslistblockNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_node_add(a : DslistblockNode, b : DslistblockNode) -> DslistblockNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_node_copy(s : DslistblockNode) -> DslistblockNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_node_fill(s : DslistblockNode, v : Double) -> DslistblockNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_node_min(s : DslistblockNode) -> Double { @_common.min(s.data) }

pub fn ds_list_block_node_max(s : DslistblockNode) -> Double { @_common.max(s.data) }

pub fn ds_list_block_node_to_string(s : DslistblockNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_edge_make(size : Int) -> DslistblockEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_edge_len(s : DslistblockEdge) -> Int { s.size }

pub fn ds_list_block_edge_get(s : DslistblockEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_edge_set(s : DslistblockEdge, i : Int, v : Double) -> DslistblockEdge {
  let result = ds_list_block_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_edge_sum(s : DslistblockEdge) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_edge_mean(s : DslistblockEdge) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_edge_scale(s : DslistblockEdge, f : Double) -> DslistblockEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_edge_add(a : DslistblockEdge, b : DslistblockEdge) -> DslistblockEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_edge_copy(s : DslistblockEdge) -> DslistblockEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_edge_fill(s : DslistblockEdge, v : Double) -> DslistblockEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_edge_min(s : DslistblockEdge) -> Double { @_common.min(s.data) }

pub fn ds_list_block_edge_max(s : DslistblockEdge) -> Double { @_common.max(s.data) }

pub fn ds_list_block_edge_to_string(s : DslistblockEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_path_make(size : Int) -> DslistblockPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_path_len(s : DslistblockPath) -> Int { s.size }

pub fn ds_list_block_path_get(s : DslistblockPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_path_set(s : DslistblockPath, i : Int, v : Double) -> DslistblockPath {
  let result = ds_list_block_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_path_sum(s : DslistblockPath) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_path_mean(s : DslistblockPath) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_path_scale(s : DslistblockPath, f : Double) -> DslistblockPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_path_add(a : DslistblockPath, b : DslistblockPath) -> DslistblockPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_path_copy(s : DslistblockPath) -> DslistblockPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_path_fill(s : DslistblockPath, v : Double) -> DslistblockPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_path_min(s : DslistblockPath) -> Double { @_common.min(s.data) }

pub fn ds_list_block_path_max(s : DslistblockPath) -> Double { @_common.max(s.data) }

pub fn ds_list_block_path_to_string(s : DslistblockPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_cluster_make(size : Int) -> DslistblockCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_cluster_len(s : DslistblockCluster) -> Int { s.size }

pub fn ds_list_block_cluster_get(s : DslistblockCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_cluster_set(s : DslistblockCluster, i : Int, v : Double) -> DslistblockCluster {
  let result = ds_list_block_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_cluster_sum(s : DslistblockCluster) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_cluster_mean(s : DslistblockCluster) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_cluster_scale(s : DslistblockCluster, f : Double) -> DslistblockCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_cluster_add(a : DslistblockCluster, b : DslistblockCluster) -> DslistblockCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_cluster_copy(s : DslistblockCluster) -> DslistblockCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_cluster_fill(s : DslistblockCluster, v : Double) -> DslistblockCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_cluster_min(s : DslistblockCluster) -> Double { @_common.min(s.data) }

pub fn ds_list_block_cluster_max(s : DslistblockCluster) -> Double { @_common.max(s.data) }

pub fn ds_list_block_cluster_to_string(s : DslistblockCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_model_make(size : Int) -> DslistblockModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_model_len(s : DslistblockModel) -> Int { s.size }

pub fn ds_list_block_model_get(s : DslistblockModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_model_set(s : DslistblockModel, i : Int, v : Double) -> DslistblockModel {
  let result = ds_list_block_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_model_sum(s : DslistblockModel) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_model_mean(s : DslistblockModel) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_model_scale(s : DslistblockModel, f : Double) -> DslistblockModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_model_add(a : DslistblockModel, b : DslistblockModel) -> DslistblockModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_model_copy(s : DslistblockModel) -> DslistblockModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_model_fill(s : DslistblockModel, v : Double) -> DslistblockModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_model_min(s : DslistblockModel) -> Double { @_common.min(s.data) }

pub fn ds_list_block_model_max(s : DslistblockModel) -> Double { @_common.max(s.data) }

pub fn ds_list_block_model_to_string(s : DslistblockModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_layer_make(size : Int) -> DslistblockLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_layer_len(s : DslistblockLayer) -> Int { s.size }

pub fn ds_list_block_layer_get(s : DslistblockLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_layer_set(s : DslistblockLayer, i : Int, v : Double) -> DslistblockLayer {
  let result = ds_list_block_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_layer_sum(s : DslistblockLayer) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_layer_mean(s : DslistblockLayer) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_layer_scale(s : DslistblockLayer, f : Double) -> DslistblockLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_layer_add(a : DslistblockLayer, b : DslistblockLayer) -> DslistblockLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_layer_copy(s : DslistblockLayer) -> DslistblockLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_layer_fill(s : DslistblockLayer, v : Double) -> DslistblockLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_layer_min(s : DslistblockLayer) -> Double { @_common.min(s.data) }

pub fn ds_list_block_layer_max(s : DslistblockLayer) -> Double { @_common.max(s.data) }

pub fn ds_list_block_layer_to_string(s : DslistblockLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_buffer_make(size : Int) -> DslistblockBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_buffer_len(s : DslistblockBuffer) -> Int { s.size }

pub fn ds_list_block_buffer_get(s : DslistblockBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_buffer_set(s : DslistblockBuffer, i : Int, v : Double) -> DslistblockBuffer {
  let result = ds_list_block_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_buffer_sum(s : DslistblockBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_buffer_mean(s : DslistblockBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_buffer_scale(s : DslistblockBuffer, f : Double) -> DslistblockBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_buffer_add(a : DslistblockBuffer, b : DslistblockBuffer) -> DslistblockBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_buffer_copy(s : DslistblockBuffer) -> DslistblockBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_buffer_fill(s : DslistblockBuffer, v : Double) -> DslistblockBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_buffer_min(s : DslistblockBuffer) -> Double { @_common.min(s.data) }

pub fn ds_list_block_buffer_max(s : DslistblockBuffer) -> Double { @_common.max(s.data) }

pub fn ds_list_block_buffer_to_string(s : DslistblockBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_cursor_make(size : Int) -> DslistblockCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_cursor_len(s : DslistblockCursor) -> Int { s.size }

pub fn ds_list_block_cursor_get(s : DslistblockCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_cursor_set(s : DslistblockCursor, i : Int, v : Double) -> DslistblockCursor {
  let result = ds_list_block_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_cursor_sum(s : DslistblockCursor) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_cursor_mean(s : DslistblockCursor) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_cursor_scale(s : DslistblockCursor, f : Double) -> DslistblockCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_cursor_add(a : DslistblockCursor, b : DslistblockCursor) -> DslistblockCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_cursor_copy(s : DslistblockCursor) -> DslistblockCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_cursor_fill(s : DslistblockCursor, v : Double) -> DslistblockCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_cursor_min(s : DslistblockCursor) -> Double { @_common.min(s.data) }

pub fn ds_list_block_cursor_max(s : DslistblockCursor) -> Double { @_common.max(s.data) }

pub fn ds_list_block_cursor_to_string(s : DslistblockCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_view_make(size : Int) -> DslistblockView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_view_len(s : DslistblockView) -> Int { s.size }

pub fn ds_list_block_view_get(s : DslistblockView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_view_set(s : DslistblockView, i : Int, v : Double) -> DslistblockView {
  let result = ds_list_block_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_view_sum(s : DslistblockView) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_view_mean(s : DslistblockView) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_view_scale(s : DslistblockView, f : Double) -> DslistblockView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_view_add(a : DslistblockView, b : DslistblockView) -> DslistblockView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_view_copy(s : DslistblockView) -> DslistblockView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_view_fill(s : DslistblockView, v : Double) -> DslistblockView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_view_min(s : DslistblockView) -> Double { @_common.min(s.data) }

pub fn ds_list_block_view_max(s : DslistblockView) -> Double { @_common.max(s.data) }

pub fn ds_list_block_view_to_string(s : DslistblockView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_range_make(size : Int) -> DslistblockRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_range_len(s : DslistblockRange) -> Int { s.size }

pub fn ds_list_block_range_get(s : DslistblockRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_range_set(s : DslistblockRange, i : Int, v : Double) -> DslistblockRange {
  let result = ds_list_block_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_range_sum(s : DslistblockRange) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_range_mean(s : DslistblockRange) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_range_scale(s : DslistblockRange, f : Double) -> DslistblockRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_range_add(a : DslistblockRange, b : DslistblockRange) -> DslistblockRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_range_copy(s : DslistblockRange) -> DslistblockRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_range_fill(s : DslistblockRange, v : Double) -> DslistblockRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_range_min(s : DslistblockRange) -> Double { @_common.min(s.data) }

pub fn ds_list_block_range_max(s : DslistblockRange) -> Double { @_common.max(s.data) }

pub fn ds_list_block_range_to_string(s : DslistblockRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_slice_make(size : Int) -> DslistblockSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_slice_len(s : DslistblockSlice) -> Int { s.size }

pub fn ds_list_block_slice_get(s : DslistblockSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_slice_set(s : DslistblockSlice, i : Int, v : Double) -> DslistblockSlice {
  let result = ds_list_block_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_slice_sum(s : DslistblockSlice) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_slice_mean(s : DslistblockSlice) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_slice_scale(s : DslistblockSlice, f : Double) -> DslistblockSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_slice_add(a : DslistblockSlice, b : DslistblockSlice) -> DslistblockSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_slice_copy(s : DslistblockSlice) -> DslistblockSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_slice_fill(s : DslistblockSlice, v : Double) -> DslistblockSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_slice_min(s : DslistblockSlice) -> Double { @_common.min(s.data) }

pub fn ds_list_block_slice_max(s : DslistblockSlice) -> Double { @_common.max(s.data) }

pub fn ds_list_block_slice_to_string(s : DslistblockSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

