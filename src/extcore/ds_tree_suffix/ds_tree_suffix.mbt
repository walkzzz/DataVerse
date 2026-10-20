///===
/// extcore/ds_tree_suffix

pub(all) struct DstreesuffixPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_suffix_make_point(x : Double, y : Double) -> DstreesuffixPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_suffix_make_point3(x : Double, y : Double, z : Double) -> DstreesuffixPoint {
  { x, y, z, label: 0 }
}

pub fn ds_tree_suffix_point_x(pt : DstreesuffixPoint) -> Double { pt.x }

pub fn ds_tree_suffix_point_y(pt : DstreesuffixPoint) -> Double { pt.y }

pub fn ds_tree_suffix_point_z(pt : DstreesuffixPoint) -> Double { pt.z }

pub fn ds_tree_suffix_point_label(pt : DstreesuffixPoint) -> Int { pt.label }

pub fn ds_tree_suffix_point_dist(a : DstreesuffixPoint, b : DstreesuffixPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_tree_suffix_point_add(a : DstreesuffixPoint, b : DstreesuffixPoint) -> DstreesuffixPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_tree_suffix_point_sub(a : DstreesuffixPoint, b : DstreesuffixPoint) -> DstreesuffixPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_tree_suffix_point_scale(pt : DstreesuffixPoint, s : Double) -> DstreesuffixPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_tree_suffix_point_dot(a : DstreesuffixPoint, b : DstreesuffixPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_tree_suffix_point_cross(a : DstreesuffixPoint, b : DstreesuffixPoint) -> DstreesuffixPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_tree_suffix_point_norm(pt : DstreesuffixPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_tree_suffix_point_normalize(pt : DstreesuffixPoint) -> DstreesuffixPoint {
  let n = ds_tree_suffix_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_tree_suffix_point_scale(pt, 1.0 / n) }
}

pub fn ds_tree_suffix_point_negate(pt : DstreesuffixPoint) -> DstreesuffixPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_tree_suffix_point_mid(a : DstreesuffixPoint, b : DstreesuffixPoint) -> DstreesuffixPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_tree_suffix_point_lerp(a : DstreesuffixPoint, b : DstreesuffixPoint, t : Double) -> DstreesuffixPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_tree_suffix_point_to_string(pt : DstreesuffixPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DstreesuffixSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_suffix_make_series(vals : Array[Double], name : String) -> DstreesuffixSeries {
  { vals, name, meta: 0 }
}

pub fn ds_tree_suffix_series_len(s : DstreesuffixSeries) -> Int { s.vals.length() }

pub fn ds_tree_suffix_series_sum(s : DstreesuffixSeries) -> Double { @_common.sum(s.vals) }

pub fn ds_tree_suffix_series_mean(s : DstreesuffixSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_tree_suffix_series_min(s : DstreesuffixSeries) -> Double { @_common.min(s.vals) }

pub fn ds_tree_suffix_series_max(s : DstreesuffixSeries) -> Double { @_common.max(s.vals) }

pub fn ds_tree_suffix_series_range(s : DstreesuffixSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_tree_suffix_series_var(s : DstreesuffixSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_tree_suffix_series_std(s : DstreesuffixSeries) -> Double { @_common.std(s.vals) }

pub fn ds_tree_suffix_series_median(s : DstreesuffixSeries) -> Double { @_common.median(s.vals) }

pub fn ds_tree_suffix_series_scale(s : DstreesuffixSeries, f : Double) -> DstreesuffixSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn ds_tree_suffix_series_add(a : DstreesuffixSeries, b : DstreesuffixSeries) -> DstreesuffixSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_tree_suffix_series_sub(a : DstreesuffixSeries, b : DstreesuffixSeries) -> DstreesuffixSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_tree_suffix_series_normalize(s : DstreesuffixSeries) -> DstreesuffixSeries {
  let mn = ds_tree_suffix_series_min(s)
  let mx = ds_tree_suffix_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_tree_suffix_series_cumsum(s : DstreesuffixSeries) -> DstreesuffixSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_tree_suffix_series_to_string(s : DstreesuffixSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreesuffixMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_suffix_make_matrix(rows : Int, cols : Int, val : Double) -> DstreesuffixMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_suffix_matrix_identity(n : Int) -> DstreesuffixMatrix {
  let m = ds_tree_suffix_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_tree_suffix_matrix_get(m : DstreesuffixMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_tree_suffix_matrix_transpose(m : DstreesuffixMatrix) -> DstreesuffixMatrix {
  let result = ds_tree_suffix_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_tree_suffix_matrix_add(a : DstreesuffixMatrix, b : DstreesuffixMatrix) -> DstreesuffixMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_tree_suffix_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_tree_suffix_matrix_scale(m : DstreesuffixMatrix, s : Double) -> DstreesuffixMatrix {
  let result = ds_tree_suffix_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_tree_suffix_matrix_multiply(a : DstreesuffixMatrix, b : DstreesuffixMatrix) -> DstreesuffixMatrix {
  if a.cols != b.rows { return ds_tree_suffix_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_tree_suffix_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_tree_suffix_matrix_trace(m : DstreesuffixMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_tree_suffix_matrix_det(m : DstreesuffixMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_tree_suffix_matrix_norm(m : DstreesuffixMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_tree_suffix_matrix_to_string(m : DstreesuffixMatrix) -> String {
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

pub(all) struct DstreesuffixVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_suffix_make_vector(comps : Array[Double]) -> DstreesuffixVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_suffix_vector_zero(dim : Int) -> DstreesuffixVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_tree_suffix_vector_add(a : DstreesuffixVector, b : DstreesuffixVector) -> DstreesuffixVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn ds_tree_suffix_vector_sub(a : DstreesuffixVector, b : DstreesuffixVector) -> DstreesuffixVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn ds_tree_suffix_vector_scale(v : DstreesuffixVector, s : Double) -> DstreesuffixVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn ds_tree_suffix_vector_dot(a : DstreesuffixVector, b : DstreesuffixVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_tree_suffix_vector_norm(v : DstreesuffixVector) -> Double { @_common.sqrt(ds_tree_suffix_vector_dot(v, v)) }

pub fn ds_tree_suffix_vector_normalize(v : DstreesuffixVector) -> DstreesuffixVector {
  let n = ds_tree_suffix_vector_norm(v)
  if n < 0.0000001 { v } else { ds_tree_suffix_vector_scale(v, 1.0 / n) }
}

pub fn ds_tree_suffix_vector_dist(a : DstreesuffixVector, b : DstreesuffixVector) -> Double {
  ds_tree_suffix_vector_norm(ds_tree_suffix_vector_sub(a, b))
}

pub fn ds_tree_suffix_vector_to_string(v : DstreesuffixVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_tree_suffix_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_tree_suffix_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_tree_suffix_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_tree_suffix_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_tree_suffix_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_tree_suffix_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_tree_suffix_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_tree_suffix_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_tree_suffix_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_tree_suffix_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_tree_suffix_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_tree_suffix_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_tree_suffix_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_tree_suffix_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_tree_suffix_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_tree_suffix_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_tree_suffix_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_tree_suffix_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_tree_suffix_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_tree_suffix_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_tree_suffix_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_tree_suffix_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_tree_suffix_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_tree_suffix_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_tree_suffix_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_tree_suffix_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_tree_suffix_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_tree_suffix_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_tree_suffix_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DstreesuffixFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_frame_make(size : Int) -> DstreesuffixFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_frame_len(s : DstreesuffixFrame) -> Int { s.size }

pub fn ds_tree_suffix_frame_get(s : DstreesuffixFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_frame_set(s : DstreesuffixFrame, i : Int, v : Double) -> DstreesuffixFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_frame_sum(s : DstreesuffixFrame) -> Double { @_common.sum(s.data) }

pub fn ds_tree_suffix_frame_mean(s : DstreesuffixFrame) -> Double { @_common.mean(s.data) }

pub fn ds_tree_suffix_frame_scale(s : DstreesuffixFrame, f : Double) -> DstreesuffixFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_frame_add(a : DstreesuffixFrame, b : DstreesuffixFrame) -> DstreesuffixFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_suffix_frame_copy(s : DstreesuffixFrame) -> DstreesuffixFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_frame_fill(s : DstreesuffixFrame, v : Double) -> DstreesuffixFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_frame_min(s : DstreesuffixFrame) -> Double { @_common.min(s.data) }

pub fn ds_tree_suffix_frame_max(s : DstreesuffixFrame) -> Double { @_common.max(s.data) }

pub fn ds_tree_suffix_frame_to_string(s : DstreesuffixFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_table_make(size : Int) -> DstreesuffixTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_table_len(s : DstreesuffixTable) -> Int { s.size }

pub fn ds_tree_suffix_table_get(s : DstreesuffixTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_table_set(s : DstreesuffixTable, i : Int, v : Double) -> DstreesuffixTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_table_sum(s : DstreesuffixTable) -> Double { @_common.sum(s.data) }

pub fn ds_tree_suffix_table_mean(s : DstreesuffixTable) -> Double { @_common.mean(s.data) }

pub fn ds_tree_suffix_table_scale(s : DstreesuffixTable, f : Double) -> DstreesuffixTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_table_add(a : DstreesuffixTable, b : DstreesuffixTable) -> DstreesuffixTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_suffix_table_copy(s : DstreesuffixTable) -> DstreesuffixTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_table_fill(s : DstreesuffixTable, v : Double) -> DstreesuffixTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_table_min(s : DstreesuffixTable) -> Double { @_common.min(s.data) }

pub fn ds_tree_suffix_table_max(s : DstreesuffixTable) -> Double { @_common.max(s.data) }

pub fn ds_tree_suffix_table_to_string(s : DstreesuffixTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_graphn_make(size : Int) -> DstreesuffixGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_graphn_len(s : DstreesuffixGraphN) -> Int { s.size }

pub fn ds_tree_suffix_graphn_get(s : DstreesuffixGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_graphn_set(s : DstreesuffixGraphN, i : Int, v : Double) -> DstreesuffixGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_graphn_sum(s : DstreesuffixGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_tree_suffix_graphn_mean(s : DstreesuffixGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_tree_suffix_graphn_scale(s : DstreesuffixGraphN, f : Double) -> DstreesuffixGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_graphn_add(a : DstreesuffixGraphN, b : DstreesuffixGraphN) -> DstreesuffixGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_suffix_graphn_copy(s : DstreesuffixGraphN) -> DstreesuffixGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_graphn_fill(s : DstreesuffixGraphN, v : Double) -> DstreesuffixGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_graphn_min(s : DstreesuffixGraphN) -> Double { @_common.min(s.data) }

pub fn ds_tree_suffix_graphn_max(s : DstreesuffixGraphN) -> Double { @_common.max(s.data) }

pub fn ds_tree_suffix_graphn_to_string(s : DstreesuffixGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_node_make(size : Int) -> DstreesuffixNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_node_len(s : DstreesuffixNode) -> Int { s.size }

pub fn ds_tree_suffix_node_get(s : DstreesuffixNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_node_set(s : DstreesuffixNode, i : Int, v : Double) -> DstreesuffixNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_node_sum(s : DstreesuffixNode) -> Double { @_common.sum(s.data) }

pub fn ds_tree_suffix_node_mean(s : DstreesuffixNode) -> Double { @_common.mean(s.data) }

pub fn ds_tree_suffix_node_scale(s : DstreesuffixNode, f : Double) -> DstreesuffixNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_node_add(a : DstreesuffixNode, b : DstreesuffixNode) -> DstreesuffixNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_suffix_node_copy(s : DstreesuffixNode) -> DstreesuffixNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_node_fill(s : DstreesuffixNode, v : Double) -> DstreesuffixNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_node_min(s : DstreesuffixNode) -> Double { @_common.min(s.data) }

pub fn ds_tree_suffix_node_max(s : DstreesuffixNode) -> Double { @_common.max(s.data) }

pub fn ds_tree_suffix_node_to_string(s : DstreesuffixNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_edge_make(size : Int) -> DstreesuffixEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_edge_len(s : DstreesuffixEdge) -> Int { s.size }

pub fn ds_tree_suffix_edge_get(s : DstreesuffixEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_edge_set(s : DstreesuffixEdge, i : Int, v : Double) -> DstreesuffixEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_edge_sum(s : DstreesuffixEdge) -> Double { @_common.sum(s.data) }

pub fn ds_tree_suffix_edge_mean(s : DstreesuffixEdge) -> Double { @_common.mean(s.data) }

pub fn ds_tree_suffix_edge_scale(s : DstreesuffixEdge, f : Double) -> DstreesuffixEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_edge_add(a : DstreesuffixEdge, b : DstreesuffixEdge) -> DstreesuffixEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_suffix_edge_copy(s : DstreesuffixEdge) -> DstreesuffixEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_edge_fill(s : DstreesuffixEdge, v : Double) -> DstreesuffixEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_edge_min(s : DstreesuffixEdge) -> Double { @_common.min(s.data) }

pub fn ds_tree_suffix_edge_max(s : DstreesuffixEdge) -> Double { @_common.max(s.data) }

pub fn ds_tree_suffix_edge_to_string(s : DstreesuffixEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_path_make(size : Int) -> DstreesuffixPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_path_len(s : DstreesuffixPath) -> Int { s.size }

pub fn ds_tree_suffix_path_get(s : DstreesuffixPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_path_set(s : DstreesuffixPath, i : Int, v : Double) -> DstreesuffixPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_path_sum(s : DstreesuffixPath) -> Double { @_common.sum(s.data) }

pub fn ds_tree_suffix_path_mean(s : DstreesuffixPath) -> Double { @_common.mean(s.data) }

pub fn ds_tree_suffix_path_scale(s : DstreesuffixPath, f : Double) -> DstreesuffixPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_path_add(a : DstreesuffixPath, b : DstreesuffixPath) -> DstreesuffixPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_suffix_path_copy(s : DstreesuffixPath) -> DstreesuffixPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_path_fill(s : DstreesuffixPath, v : Double) -> DstreesuffixPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_path_min(s : DstreesuffixPath) -> Double { @_common.min(s.data) }

pub fn ds_tree_suffix_path_max(s : DstreesuffixPath) -> Double { @_common.max(s.data) }

pub fn ds_tree_suffix_path_to_string(s : DstreesuffixPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_cluster_make(size : Int) -> DstreesuffixCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_cluster_len(s : DstreesuffixCluster) -> Int { s.size }

pub fn ds_tree_suffix_cluster_get(s : DstreesuffixCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_cluster_set(s : DstreesuffixCluster, i : Int, v : Double) -> DstreesuffixCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_cluster_sum(s : DstreesuffixCluster) -> Double { @_common.sum(s.data) }

pub fn ds_tree_suffix_cluster_mean(s : DstreesuffixCluster) -> Double { @_common.mean(s.data) }

pub fn ds_tree_suffix_cluster_scale(s : DstreesuffixCluster, f : Double) -> DstreesuffixCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_cluster_add(a : DstreesuffixCluster, b : DstreesuffixCluster) -> DstreesuffixCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_suffix_cluster_copy(s : DstreesuffixCluster) -> DstreesuffixCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_cluster_fill(s : DstreesuffixCluster, v : Double) -> DstreesuffixCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_cluster_min(s : DstreesuffixCluster) -> Double { @_common.min(s.data) }

pub fn ds_tree_suffix_cluster_max(s : DstreesuffixCluster) -> Double { @_common.max(s.data) }

pub fn ds_tree_suffix_cluster_to_string(s : DstreesuffixCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_model_make(size : Int) -> DstreesuffixModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_model_len(s : DstreesuffixModel) -> Int { s.size }

pub fn ds_tree_suffix_model_get(s : DstreesuffixModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_model_set(s : DstreesuffixModel, i : Int, v : Double) -> DstreesuffixModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_model_sum(s : DstreesuffixModel) -> Double { @_common.sum(s.data) }

pub fn ds_tree_suffix_model_mean(s : DstreesuffixModel) -> Double { @_common.mean(s.data) }

pub fn ds_tree_suffix_model_scale(s : DstreesuffixModel, f : Double) -> DstreesuffixModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_model_add(a : DstreesuffixModel, b : DstreesuffixModel) -> DstreesuffixModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_suffix_model_copy(s : DstreesuffixModel) -> DstreesuffixModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_model_fill(s : DstreesuffixModel, v : Double) -> DstreesuffixModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_model_min(s : DstreesuffixModel) -> Double { @_common.min(s.data) }

pub fn ds_tree_suffix_model_max(s : DstreesuffixModel) -> Double { @_common.max(s.data) }

pub fn ds_tree_suffix_model_to_string(s : DstreesuffixModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_layer_make(size : Int) -> DstreesuffixLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_layer_len(s : DstreesuffixLayer) -> Int { s.size }

pub fn ds_tree_suffix_layer_get(s : DstreesuffixLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_layer_set(s : DstreesuffixLayer, i : Int, v : Double) -> DstreesuffixLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_layer_sum(s : DstreesuffixLayer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_suffix_layer_mean(s : DstreesuffixLayer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_suffix_layer_scale(s : DstreesuffixLayer, f : Double) -> DstreesuffixLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_layer_add(a : DstreesuffixLayer, b : DstreesuffixLayer) -> DstreesuffixLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_suffix_layer_copy(s : DstreesuffixLayer) -> DstreesuffixLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_layer_fill(s : DstreesuffixLayer, v : Double) -> DstreesuffixLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_layer_min(s : DstreesuffixLayer) -> Double { @_common.min(s.data) }

pub fn ds_tree_suffix_layer_max(s : DstreesuffixLayer) -> Double { @_common.max(s.data) }

pub fn ds_tree_suffix_layer_to_string(s : DstreesuffixLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_buffer_make(size : Int) -> DstreesuffixBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_buffer_len(s : DstreesuffixBuffer) -> Int { s.size }

pub fn ds_tree_suffix_buffer_get(s : DstreesuffixBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_buffer_set(s : DstreesuffixBuffer, i : Int, v : Double) -> DstreesuffixBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_buffer_sum(s : DstreesuffixBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_suffix_buffer_mean(s : DstreesuffixBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_suffix_buffer_scale(s : DstreesuffixBuffer, f : Double) -> DstreesuffixBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_buffer_add(a : DstreesuffixBuffer, b : DstreesuffixBuffer) -> DstreesuffixBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_suffix_buffer_copy(s : DstreesuffixBuffer) -> DstreesuffixBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_buffer_fill(s : DstreesuffixBuffer, v : Double) -> DstreesuffixBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_buffer_min(s : DstreesuffixBuffer) -> Double { @_common.min(s.data) }

pub fn ds_tree_suffix_buffer_max(s : DstreesuffixBuffer) -> Double { @_common.max(s.data) }

pub fn ds_tree_suffix_buffer_to_string(s : DstreesuffixBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_cursor_make(size : Int) -> DstreesuffixCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_cursor_len(s : DstreesuffixCursor) -> Int { s.size }

pub fn ds_tree_suffix_cursor_get(s : DstreesuffixCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_cursor_set(s : DstreesuffixCursor, i : Int, v : Double) -> DstreesuffixCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_cursor_sum(s : DstreesuffixCursor) -> Double { @_common.sum(s.data) }

pub fn ds_tree_suffix_cursor_mean(s : DstreesuffixCursor) -> Double { @_common.mean(s.data) }

pub fn ds_tree_suffix_cursor_scale(s : DstreesuffixCursor, f : Double) -> DstreesuffixCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_cursor_add(a : DstreesuffixCursor, b : DstreesuffixCursor) -> DstreesuffixCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_suffix_cursor_copy(s : DstreesuffixCursor) -> DstreesuffixCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_cursor_fill(s : DstreesuffixCursor, v : Double) -> DstreesuffixCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_cursor_min(s : DstreesuffixCursor) -> Double { @_common.min(s.data) }

pub fn ds_tree_suffix_cursor_max(s : DstreesuffixCursor) -> Double { @_common.max(s.data) }

pub fn ds_tree_suffix_cursor_to_string(s : DstreesuffixCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_view_make(size : Int) -> DstreesuffixView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_view_len(s : DstreesuffixView) -> Int { s.size }

pub fn ds_tree_suffix_view_get(s : DstreesuffixView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_view_set(s : DstreesuffixView, i : Int, v : Double) -> DstreesuffixView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_view_sum(s : DstreesuffixView) -> Double { @_common.sum(s.data) }

pub fn ds_tree_suffix_view_mean(s : DstreesuffixView) -> Double { @_common.mean(s.data) }

pub fn ds_tree_suffix_view_scale(s : DstreesuffixView, f : Double) -> DstreesuffixView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_view_add(a : DstreesuffixView, b : DstreesuffixView) -> DstreesuffixView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_suffix_view_copy(s : DstreesuffixView) -> DstreesuffixView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_view_fill(s : DstreesuffixView, v : Double) -> DstreesuffixView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_view_min(s : DstreesuffixView) -> Double { @_common.min(s.data) }

pub fn ds_tree_suffix_view_max(s : DstreesuffixView) -> Double { @_common.max(s.data) }

pub fn ds_tree_suffix_view_to_string(s : DstreesuffixView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_range_make(size : Int) -> DstreesuffixRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_range_len(s : DstreesuffixRange) -> Int { s.size }

pub fn ds_tree_suffix_range_get(s : DstreesuffixRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_range_set(s : DstreesuffixRange, i : Int, v : Double) -> DstreesuffixRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_range_sum(s : DstreesuffixRange) -> Double { @_common.sum(s.data) }

pub fn ds_tree_suffix_range_mean(s : DstreesuffixRange) -> Double { @_common.mean(s.data) }

pub fn ds_tree_suffix_range_scale(s : DstreesuffixRange, f : Double) -> DstreesuffixRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_range_add(a : DstreesuffixRange, b : DstreesuffixRange) -> DstreesuffixRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_suffix_range_copy(s : DstreesuffixRange) -> DstreesuffixRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_range_fill(s : DstreesuffixRange, v : Double) -> DstreesuffixRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_range_min(s : DstreesuffixRange) -> Double { @_common.min(s.data) }

pub fn ds_tree_suffix_range_max(s : DstreesuffixRange) -> Double { @_common.max(s.data) }

pub fn ds_tree_suffix_range_to_string(s : DstreesuffixRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_slice_make(size : Int) -> DstreesuffixSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_slice_len(s : DstreesuffixSlice) -> Int { s.size }

pub fn ds_tree_suffix_slice_get(s : DstreesuffixSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_slice_set(s : DstreesuffixSlice, i : Int, v : Double) -> DstreesuffixSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_slice_sum(s : DstreesuffixSlice) -> Double { @_common.sum(s.data) }

pub fn ds_tree_suffix_slice_mean(s : DstreesuffixSlice) -> Double { @_common.mean(s.data) }

pub fn ds_tree_suffix_slice_scale(s : DstreesuffixSlice, f : Double) -> DstreesuffixSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_slice_add(a : DstreesuffixSlice, b : DstreesuffixSlice) -> DstreesuffixSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_suffix_slice_copy(s : DstreesuffixSlice) -> DstreesuffixSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_slice_fill(s : DstreesuffixSlice, v : Double) -> DstreesuffixSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_suffix_slice_min(s : DstreesuffixSlice) -> Double { @_common.min(s.data) }

pub fn ds_tree_suffix_slice_max(s : DstreesuffixSlice) -> Double { @_common.max(s.data) }

pub fn ds_tree_suffix_slice_to_string(s : DstreesuffixSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

