///===
/// extcore/graph_tree_mst_prim

pub(all) struct GraphtreemstprimPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_tree_mst_prim_make_point(x : Double, y : Double) -> GraphtreemstprimPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_tree_mst_prim_make_point3(x : Double, y : Double, z : Double) -> GraphtreemstprimPoint {
  { x, y, z, label: 0 }
}

pub fn graph_tree_mst_prim_point_x(pt : GraphtreemstprimPoint) -> Double { pt.x }

pub fn graph_tree_mst_prim_point_y(pt : GraphtreemstprimPoint) -> Double { pt.y }

pub fn graph_tree_mst_prim_point_z(pt : GraphtreemstprimPoint) -> Double { pt.z }

pub fn graph_tree_mst_prim_point_label(pt : GraphtreemstprimPoint) -> Int { pt.label }

pub fn graph_tree_mst_prim_point_dist(a : GraphtreemstprimPoint, b : GraphtreemstprimPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_tree_mst_prim_point_add(a : GraphtreemstprimPoint, b : GraphtreemstprimPoint) -> GraphtreemstprimPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_tree_mst_prim_point_sub(a : GraphtreemstprimPoint, b : GraphtreemstprimPoint) -> GraphtreemstprimPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_tree_mst_prim_point_scale(pt : GraphtreemstprimPoint, s : Double) -> GraphtreemstprimPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_tree_mst_prim_point_dot(a : GraphtreemstprimPoint, b : GraphtreemstprimPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_tree_mst_prim_point_cross(a : GraphtreemstprimPoint, b : GraphtreemstprimPoint) -> GraphtreemstprimPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_tree_mst_prim_point_norm(pt : GraphtreemstprimPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_tree_mst_prim_point_normalize(pt : GraphtreemstprimPoint) -> GraphtreemstprimPoint {
  let n = graph_tree_mst_prim_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_tree_mst_prim_point_scale(pt, 1.0 / n) }
}

pub fn graph_tree_mst_prim_point_negate(pt : GraphtreemstprimPoint) -> GraphtreemstprimPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_tree_mst_prim_point_mid(a : GraphtreemstprimPoint, b : GraphtreemstprimPoint) -> GraphtreemstprimPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_tree_mst_prim_point_lerp(a : GraphtreemstprimPoint, b : GraphtreemstprimPoint, t : Double) -> GraphtreemstprimPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_tree_mst_prim_point_to_string(pt : GraphtreemstprimPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphtreemstprimSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_tree_mst_prim_make_series(vals : Array[Double], name : String) -> GraphtreemstprimSeries {
  { vals, name, meta: 0 }
}

pub fn graph_tree_mst_prim_series_len(s : GraphtreemstprimSeries) -> Int { s.vals.length() }

pub fn graph_tree_mst_prim_series_sum(s : GraphtreemstprimSeries) -> Double { @_common.sum(s.vals) }

pub fn graph_tree_mst_prim_series_mean(s : GraphtreemstprimSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_tree_mst_prim_series_min(s : GraphtreemstprimSeries) -> Double { @_common.min(s.vals) }

pub fn graph_tree_mst_prim_series_max(s : GraphtreemstprimSeries) -> Double { @_common.max(s.vals) }

pub fn graph_tree_mst_prim_series_range(s : GraphtreemstprimSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_tree_mst_prim_series_var(s : GraphtreemstprimSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_tree_mst_prim_series_std(s : GraphtreemstprimSeries) -> Double { @_common.std(s.vals) }

pub fn graph_tree_mst_prim_series_median(s : GraphtreemstprimSeries) -> Double { @_common.median(s.vals) }

pub fn graph_tree_mst_prim_series_scale(s : GraphtreemstprimSeries, f : Double) -> GraphtreemstprimSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn graph_tree_mst_prim_series_add(a : GraphtreemstprimSeries, b : GraphtreemstprimSeries) -> GraphtreemstprimSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_tree_mst_prim_series_sub(a : GraphtreemstprimSeries, b : GraphtreemstprimSeries) -> GraphtreemstprimSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_tree_mst_prim_series_normalize(s : GraphtreemstprimSeries) -> GraphtreemstprimSeries {
  let mn = graph_tree_mst_prim_series_min(s)
  let mx = graph_tree_mst_prim_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_tree_mst_prim_series_cumsum(s : GraphtreemstprimSeries) -> GraphtreemstprimSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_tree_mst_prim_series_to_string(s : GraphtreemstprimSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreemstprimMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_tree_mst_prim_make_matrix(rows : Int, cols : Int, val : Double) -> GraphtreemstprimMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_tree_mst_prim_matrix_identity(n : Int) -> GraphtreemstprimMatrix {
  let m = graph_tree_mst_prim_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_tree_mst_prim_matrix_get(m : GraphtreemstprimMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_tree_mst_prim_matrix_transpose(m : GraphtreemstprimMatrix) -> GraphtreemstprimMatrix {
  let result = graph_tree_mst_prim_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_tree_mst_prim_matrix_add(a : GraphtreemstprimMatrix, b : GraphtreemstprimMatrix) -> GraphtreemstprimMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_tree_mst_prim_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_tree_mst_prim_matrix_scale(m : GraphtreemstprimMatrix, s : Double) -> GraphtreemstprimMatrix {
  let result = graph_tree_mst_prim_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_tree_mst_prim_matrix_multiply(a : GraphtreemstprimMatrix, b : GraphtreemstprimMatrix) -> GraphtreemstprimMatrix {
  if a.cols != b.rows { return graph_tree_mst_prim_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_tree_mst_prim_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_tree_mst_prim_matrix_trace(m : GraphtreemstprimMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_tree_mst_prim_matrix_det(m : GraphtreemstprimMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_tree_mst_prim_matrix_norm(m : GraphtreemstprimMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_tree_mst_prim_matrix_to_string(m : GraphtreemstprimMatrix) -> String {
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

pub(all) struct GraphtreemstprimVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_tree_mst_prim_make_vector(comps : Array[Double]) -> GraphtreemstprimVector {
  { comps, dim: comps.length() }
}

pub fn graph_tree_mst_prim_vector_zero(dim : Int) -> GraphtreemstprimVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_tree_mst_prim_vector_add(a : GraphtreemstprimVector, b : GraphtreemstprimVector) -> GraphtreemstprimVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn graph_tree_mst_prim_vector_sub(a : GraphtreemstprimVector, b : GraphtreemstprimVector) -> GraphtreemstprimVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn graph_tree_mst_prim_vector_scale(v : GraphtreemstprimVector, s : Double) -> GraphtreemstprimVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn graph_tree_mst_prim_vector_dot(a : GraphtreemstprimVector, b : GraphtreemstprimVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_tree_mst_prim_vector_norm(v : GraphtreemstprimVector) -> Double { @_common.sqrt(graph_tree_mst_prim_vector_dot(v, v)) }

pub fn graph_tree_mst_prim_vector_normalize(v : GraphtreemstprimVector) -> GraphtreemstprimVector {
  let n = graph_tree_mst_prim_vector_norm(v)
  if n < 0.0000001 { v } else { graph_tree_mst_prim_vector_scale(v, 1.0 / n) }
}

pub fn graph_tree_mst_prim_vector_dist(a : GraphtreemstprimVector, b : GraphtreemstprimVector) -> Double {
  graph_tree_mst_prim_vector_norm(graph_tree_mst_prim_vector_sub(a, b))
}

pub fn graph_tree_mst_prim_vector_to_string(v : GraphtreemstprimVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_tree_mst_prim_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_tree_mst_prim_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_tree_mst_prim_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_tree_mst_prim_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_tree_mst_prim_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_tree_mst_prim_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_tree_mst_prim_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_tree_mst_prim_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_tree_mst_prim_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_tree_mst_prim_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_tree_mst_prim_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_tree_mst_prim_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_tree_mst_prim_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_tree_mst_prim_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_tree_mst_prim_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_tree_mst_prim_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_tree_mst_prim_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_tree_mst_prim_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_tree_mst_prim_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_tree_mst_prim_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_tree_mst_prim_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_tree_mst_prim_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_tree_mst_prim_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_tree_mst_prim_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_tree_mst_prim_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_tree_mst_prim_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_tree_mst_prim_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_tree_mst_prim_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_tree_mst_prim_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphtreemstprimFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_frame_make(size : Int) -> GraphtreemstprimFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_prim_frame_len(s : GraphtreemstprimFrame) -> Int { s.size }

pub fn graph_tree_mst_prim_frame_get(s : GraphtreemstprimFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_prim_frame_set(s : GraphtreemstprimFrame, i : Int, v : Double) -> GraphtreemstprimFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_frame_sum(s : GraphtreemstprimFrame) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_prim_frame_mean(s : GraphtreemstprimFrame) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_prim_frame_scale(s : GraphtreemstprimFrame, f : Double) -> GraphtreemstprimFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_frame_add(a : GraphtreemstprimFrame, b : GraphtreemstprimFrame) -> GraphtreemstprimFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_prim_frame_copy(s : GraphtreemstprimFrame) -> GraphtreemstprimFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_frame_fill(s : GraphtreemstprimFrame, v : Double) -> GraphtreemstprimFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_frame_min(s : GraphtreemstprimFrame) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_prim_frame_max(s : GraphtreemstprimFrame) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_prim_frame_to_string(s : GraphtreemstprimFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_table_make(size : Int) -> GraphtreemstprimTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_prim_table_len(s : GraphtreemstprimTable) -> Int { s.size }

pub fn graph_tree_mst_prim_table_get(s : GraphtreemstprimTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_prim_table_set(s : GraphtreemstprimTable, i : Int, v : Double) -> GraphtreemstprimTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_table_sum(s : GraphtreemstprimTable) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_prim_table_mean(s : GraphtreemstprimTable) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_prim_table_scale(s : GraphtreemstprimTable, f : Double) -> GraphtreemstprimTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_table_add(a : GraphtreemstprimTable, b : GraphtreemstprimTable) -> GraphtreemstprimTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_prim_table_copy(s : GraphtreemstprimTable) -> GraphtreemstprimTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_table_fill(s : GraphtreemstprimTable, v : Double) -> GraphtreemstprimTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_table_min(s : GraphtreemstprimTable) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_prim_table_max(s : GraphtreemstprimTable) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_prim_table_to_string(s : GraphtreemstprimTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_graphn_make(size : Int) -> GraphtreemstprimGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_prim_graphn_len(s : GraphtreemstprimGraphN) -> Int { s.size }

pub fn graph_tree_mst_prim_graphn_get(s : GraphtreemstprimGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_prim_graphn_set(s : GraphtreemstprimGraphN, i : Int, v : Double) -> GraphtreemstprimGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_graphn_sum(s : GraphtreemstprimGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_prim_graphn_mean(s : GraphtreemstprimGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_prim_graphn_scale(s : GraphtreemstprimGraphN, f : Double) -> GraphtreemstprimGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_graphn_add(a : GraphtreemstprimGraphN, b : GraphtreemstprimGraphN) -> GraphtreemstprimGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_prim_graphn_copy(s : GraphtreemstprimGraphN) -> GraphtreemstprimGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_graphn_fill(s : GraphtreemstprimGraphN, v : Double) -> GraphtreemstprimGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_graphn_min(s : GraphtreemstprimGraphN) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_prim_graphn_max(s : GraphtreemstprimGraphN) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_prim_graphn_to_string(s : GraphtreemstprimGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_node_make(size : Int) -> GraphtreemstprimNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_prim_node_len(s : GraphtreemstprimNode) -> Int { s.size }

pub fn graph_tree_mst_prim_node_get(s : GraphtreemstprimNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_prim_node_set(s : GraphtreemstprimNode, i : Int, v : Double) -> GraphtreemstprimNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_node_sum(s : GraphtreemstprimNode) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_prim_node_mean(s : GraphtreemstprimNode) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_prim_node_scale(s : GraphtreemstprimNode, f : Double) -> GraphtreemstprimNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_node_add(a : GraphtreemstprimNode, b : GraphtreemstprimNode) -> GraphtreemstprimNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_prim_node_copy(s : GraphtreemstprimNode) -> GraphtreemstprimNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_node_fill(s : GraphtreemstprimNode, v : Double) -> GraphtreemstprimNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_node_min(s : GraphtreemstprimNode) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_prim_node_max(s : GraphtreemstprimNode) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_prim_node_to_string(s : GraphtreemstprimNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_edge_make(size : Int) -> GraphtreemstprimEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_prim_edge_len(s : GraphtreemstprimEdge) -> Int { s.size }

pub fn graph_tree_mst_prim_edge_get(s : GraphtreemstprimEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_prim_edge_set(s : GraphtreemstprimEdge, i : Int, v : Double) -> GraphtreemstprimEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_edge_sum(s : GraphtreemstprimEdge) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_prim_edge_mean(s : GraphtreemstprimEdge) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_prim_edge_scale(s : GraphtreemstprimEdge, f : Double) -> GraphtreemstprimEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_edge_add(a : GraphtreemstprimEdge, b : GraphtreemstprimEdge) -> GraphtreemstprimEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_prim_edge_copy(s : GraphtreemstprimEdge) -> GraphtreemstprimEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_edge_fill(s : GraphtreemstprimEdge, v : Double) -> GraphtreemstprimEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_edge_min(s : GraphtreemstprimEdge) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_prim_edge_max(s : GraphtreemstprimEdge) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_prim_edge_to_string(s : GraphtreemstprimEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_path_make(size : Int) -> GraphtreemstprimPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_prim_path_len(s : GraphtreemstprimPath) -> Int { s.size }

pub fn graph_tree_mst_prim_path_get(s : GraphtreemstprimPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_prim_path_set(s : GraphtreemstprimPath, i : Int, v : Double) -> GraphtreemstprimPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_path_sum(s : GraphtreemstprimPath) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_prim_path_mean(s : GraphtreemstprimPath) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_prim_path_scale(s : GraphtreemstprimPath, f : Double) -> GraphtreemstprimPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_path_add(a : GraphtreemstprimPath, b : GraphtreemstprimPath) -> GraphtreemstprimPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_prim_path_copy(s : GraphtreemstprimPath) -> GraphtreemstprimPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_path_fill(s : GraphtreemstprimPath, v : Double) -> GraphtreemstprimPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_path_min(s : GraphtreemstprimPath) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_prim_path_max(s : GraphtreemstprimPath) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_prim_path_to_string(s : GraphtreemstprimPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_cluster_make(size : Int) -> GraphtreemstprimCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_prim_cluster_len(s : GraphtreemstprimCluster) -> Int { s.size }

pub fn graph_tree_mst_prim_cluster_get(s : GraphtreemstprimCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_prim_cluster_set(s : GraphtreemstprimCluster, i : Int, v : Double) -> GraphtreemstprimCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_cluster_sum(s : GraphtreemstprimCluster) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_prim_cluster_mean(s : GraphtreemstprimCluster) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_prim_cluster_scale(s : GraphtreemstprimCluster, f : Double) -> GraphtreemstprimCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_cluster_add(a : GraphtreemstprimCluster, b : GraphtreemstprimCluster) -> GraphtreemstprimCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_prim_cluster_copy(s : GraphtreemstprimCluster) -> GraphtreemstprimCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_cluster_fill(s : GraphtreemstprimCluster, v : Double) -> GraphtreemstprimCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_cluster_min(s : GraphtreemstprimCluster) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_prim_cluster_max(s : GraphtreemstprimCluster) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_prim_cluster_to_string(s : GraphtreemstprimCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_model_make(size : Int) -> GraphtreemstprimModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_prim_model_len(s : GraphtreemstprimModel) -> Int { s.size }

pub fn graph_tree_mst_prim_model_get(s : GraphtreemstprimModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_prim_model_set(s : GraphtreemstprimModel, i : Int, v : Double) -> GraphtreemstprimModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_model_sum(s : GraphtreemstprimModel) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_prim_model_mean(s : GraphtreemstprimModel) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_prim_model_scale(s : GraphtreemstprimModel, f : Double) -> GraphtreemstprimModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_model_add(a : GraphtreemstprimModel, b : GraphtreemstprimModel) -> GraphtreemstprimModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_prim_model_copy(s : GraphtreemstprimModel) -> GraphtreemstprimModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_model_fill(s : GraphtreemstprimModel, v : Double) -> GraphtreemstprimModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_model_min(s : GraphtreemstprimModel) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_prim_model_max(s : GraphtreemstprimModel) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_prim_model_to_string(s : GraphtreemstprimModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_layer_make(size : Int) -> GraphtreemstprimLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_prim_layer_len(s : GraphtreemstprimLayer) -> Int { s.size }

pub fn graph_tree_mst_prim_layer_get(s : GraphtreemstprimLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_prim_layer_set(s : GraphtreemstprimLayer, i : Int, v : Double) -> GraphtreemstprimLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_layer_sum(s : GraphtreemstprimLayer) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_prim_layer_mean(s : GraphtreemstprimLayer) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_prim_layer_scale(s : GraphtreemstprimLayer, f : Double) -> GraphtreemstprimLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_layer_add(a : GraphtreemstprimLayer, b : GraphtreemstprimLayer) -> GraphtreemstprimLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_prim_layer_copy(s : GraphtreemstprimLayer) -> GraphtreemstprimLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_layer_fill(s : GraphtreemstprimLayer, v : Double) -> GraphtreemstprimLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_layer_min(s : GraphtreemstprimLayer) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_prim_layer_max(s : GraphtreemstprimLayer) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_prim_layer_to_string(s : GraphtreemstprimLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_buffer_make(size : Int) -> GraphtreemstprimBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_prim_buffer_len(s : GraphtreemstprimBuffer) -> Int { s.size }

pub fn graph_tree_mst_prim_buffer_get(s : GraphtreemstprimBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_prim_buffer_set(s : GraphtreemstprimBuffer, i : Int, v : Double) -> GraphtreemstprimBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_buffer_sum(s : GraphtreemstprimBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_prim_buffer_mean(s : GraphtreemstprimBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_prim_buffer_scale(s : GraphtreemstprimBuffer, f : Double) -> GraphtreemstprimBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_buffer_add(a : GraphtreemstprimBuffer, b : GraphtreemstprimBuffer) -> GraphtreemstprimBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_prim_buffer_copy(s : GraphtreemstprimBuffer) -> GraphtreemstprimBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_buffer_fill(s : GraphtreemstprimBuffer, v : Double) -> GraphtreemstprimBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_buffer_min(s : GraphtreemstprimBuffer) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_prim_buffer_max(s : GraphtreemstprimBuffer) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_prim_buffer_to_string(s : GraphtreemstprimBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_cursor_make(size : Int) -> GraphtreemstprimCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_prim_cursor_len(s : GraphtreemstprimCursor) -> Int { s.size }

pub fn graph_tree_mst_prim_cursor_get(s : GraphtreemstprimCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_prim_cursor_set(s : GraphtreemstprimCursor, i : Int, v : Double) -> GraphtreemstprimCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_cursor_sum(s : GraphtreemstprimCursor) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_prim_cursor_mean(s : GraphtreemstprimCursor) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_prim_cursor_scale(s : GraphtreemstprimCursor, f : Double) -> GraphtreemstprimCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_cursor_add(a : GraphtreemstprimCursor, b : GraphtreemstprimCursor) -> GraphtreemstprimCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_prim_cursor_copy(s : GraphtreemstprimCursor) -> GraphtreemstprimCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_cursor_fill(s : GraphtreemstprimCursor, v : Double) -> GraphtreemstprimCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_cursor_min(s : GraphtreemstprimCursor) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_prim_cursor_max(s : GraphtreemstprimCursor) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_prim_cursor_to_string(s : GraphtreemstprimCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_view_make(size : Int) -> GraphtreemstprimView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_prim_view_len(s : GraphtreemstprimView) -> Int { s.size }

pub fn graph_tree_mst_prim_view_get(s : GraphtreemstprimView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_prim_view_set(s : GraphtreemstprimView, i : Int, v : Double) -> GraphtreemstprimView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_view_sum(s : GraphtreemstprimView) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_prim_view_mean(s : GraphtreemstprimView) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_prim_view_scale(s : GraphtreemstprimView, f : Double) -> GraphtreemstprimView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_view_add(a : GraphtreemstprimView, b : GraphtreemstprimView) -> GraphtreemstprimView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_prim_view_copy(s : GraphtreemstprimView) -> GraphtreemstprimView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_view_fill(s : GraphtreemstprimView, v : Double) -> GraphtreemstprimView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_view_min(s : GraphtreemstprimView) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_prim_view_max(s : GraphtreemstprimView) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_prim_view_to_string(s : GraphtreemstprimView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_range_make(size : Int) -> GraphtreemstprimRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_prim_range_len(s : GraphtreemstprimRange) -> Int { s.size }

pub fn graph_tree_mst_prim_range_get(s : GraphtreemstprimRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_prim_range_set(s : GraphtreemstprimRange, i : Int, v : Double) -> GraphtreemstprimRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_range_sum(s : GraphtreemstprimRange) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_prim_range_mean(s : GraphtreemstprimRange) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_prim_range_scale(s : GraphtreemstprimRange, f : Double) -> GraphtreemstprimRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_range_add(a : GraphtreemstprimRange, b : GraphtreemstprimRange) -> GraphtreemstprimRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_prim_range_copy(s : GraphtreemstprimRange) -> GraphtreemstprimRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_range_fill(s : GraphtreemstprimRange, v : Double) -> GraphtreemstprimRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_range_min(s : GraphtreemstprimRange) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_prim_range_max(s : GraphtreemstprimRange) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_prim_range_to_string(s : GraphtreemstprimRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstprimSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_prim_slice_make(size : Int) -> GraphtreemstprimSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_prim_slice_len(s : GraphtreemstprimSlice) -> Int { s.size }

pub fn graph_tree_mst_prim_slice_get(s : GraphtreemstprimSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_prim_slice_set(s : GraphtreemstprimSlice, i : Int, v : Double) -> GraphtreemstprimSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_slice_sum(s : GraphtreemstprimSlice) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_prim_slice_mean(s : GraphtreemstprimSlice) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_prim_slice_scale(s : GraphtreemstprimSlice, f : Double) -> GraphtreemstprimSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_slice_add(a : GraphtreemstprimSlice, b : GraphtreemstprimSlice) -> GraphtreemstprimSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_prim_slice_copy(s : GraphtreemstprimSlice) -> GraphtreemstprimSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_slice_fill(s : GraphtreemstprimSlice, v : Double) -> GraphtreemstprimSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_prim_slice_min(s : GraphtreemstprimSlice) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_prim_slice_max(s : GraphtreemstprimSlice) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_prim_slice_to_string(s : GraphtreemstprimSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

