///===
/// extcore/ml_metric_pr

pub(all) struct MlmetricprPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_pr_make_point(x : Double, y : Double) -> MlmetricprPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_pr_make_point3(x : Double, y : Double, z : Double) -> MlmetricprPoint {
  { x, y, z, label: 0 }
}

pub fn ml_metric_pr_point_x(pt : MlmetricprPoint) -> Double { pt.x }

pub fn ml_metric_pr_point_y(pt : MlmetricprPoint) -> Double { pt.y }

pub fn ml_metric_pr_point_z(pt : MlmetricprPoint) -> Double { pt.z }

pub fn ml_metric_pr_point_label(pt : MlmetricprPoint) -> Int { pt.label }

pub fn ml_metric_pr_point_dist(a : MlmetricprPoint, b : MlmetricprPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_metric_pr_point_add(a : MlmetricprPoint, b : MlmetricprPoint) -> MlmetricprPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_metric_pr_point_sub(a : MlmetricprPoint, b : MlmetricprPoint) -> MlmetricprPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_metric_pr_point_scale(pt : MlmetricprPoint, s : Double) -> MlmetricprPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_metric_pr_point_dot(a : MlmetricprPoint, b : MlmetricprPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_metric_pr_point_cross(a : MlmetricprPoint, b : MlmetricprPoint) -> MlmetricprPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_metric_pr_point_norm(pt : MlmetricprPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_metric_pr_point_normalize(pt : MlmetricprPoint) -> MlmetricprPoint {
  let n = ml_metric_pr_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_metric_pr_point_scale(pt, 1.0 / n) }
}

pub fn ml_metric_pr_point_negate(pt : MlmetricprPoint) -> MlmetricprPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_metric_pr_point_mid(a : MlmetricprPoint, b : MlmetricprPoint) -> MlmetricprPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_metric_pr_point_lerp(a : MlmetricprPoint, b : MlmetricprPoint, t : Double) -> MlmetricprPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_metric_pr_point_to_string(pt : MlmetricprPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlmetricprSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_pr_make_series(vals : Array[Double], name : String) -> MlmetricprSeries {
  { vals, name, meta: 0 }
}

pub fn ml_metric_pr_series_len(s : MlmetricprSeries) -> Int { s.vals.length() }

pub fn ml_metric_pr_series_sum(s : MlmetricprSeries) -> Double { @_common.sum(s.vals) }

pub fn ml_metric_pr_series_mean(s : MlmetricprSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_metric_pr_series_min(s : MlmetricprSeries) -> Double { @_common.min(s.vals) }

pub fn ml_metric_pr_series_max(s : MlmetricprSeries) -> Double { @_common.max(s.vals) }

pub fn ml_metric_pr_series_range(s : MlmetricprSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_metric_pr_series_var(s : MlmetricprSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_metric_pr_series_std(s : MlmetricprSeries) -> Double { @_common.std(s.vals) }

pub fn ml_metric_pr_series_median(s : MlmetricprSeries) -> Double { @_common.median(s.vals) }

pub fn ml_metric_pr_series_scale(s : MlmetricprSeries, f : Double) -> MlmetricprSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn ml_metric_pr_series_add(a : MlmetricprSeries, b : MlmetricprSeries) -> MlmetricprSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_metric_pr_series_sub(a : MlmetricprSeries, b : MlmetricprSeries) -> MlmetricprSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_metric_pr_series_normalize(s : MlmetricprSeries) -> MlmetricprSeries {
  let mn = ml_metric_pr_series_min(s)
  let mx = ml_metric_pr_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_metric_pr_series_cumsum(s : MlmetricprSeries) -> MlmetricprSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_metric_pr_series_to_string(s : MlmetricprSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricprMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_pr_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetricprMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_pr_matrix_identity(n : Int) -> MlmetricprMatrix {
  let m = ml_metric_pr_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_metric_pr_matrix_get(m : MlmetricprMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_metric_pr_matrix_transpose(m : MlmetricprMatrix) -> MlmetricprMatrix {
  let result = ml_metric_pr_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_metric_pr_matrix_add(a : MlmetricprMatrix, b : MlmetricprMatrix) -> MlmetricprMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_metric_pr_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_metric_pr_matrix_scale(m : MlmetricprMatrix, s : Double) -> MlmetricprMatrix {
  let result = ml_metric_pr_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_metric_pr_matrix_multiply(a : MlmetricprMatrix, b : MlmetricprMatrix) -> MlmetricprMatrix {
  if a.cols != b.rows { return ml_metric_pr_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_metric_pr_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_metric_pr_matrix_trace(m : MlmetricprMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_metric_pr_matrix_det(m : MlmetricprMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_metric_pr_matrix_norm(m : MlmetricprMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_metric_pr_matrix_to_string(m : MlmetricprMatrix) -> String {
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

pub(all) struct MlmetricprVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_pr_make_vector(comps : Array[Double]) -> MlmetricprVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_pr_vector_zero(dim : Int) -> MlmetricprVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_metric_pr_vector_add(a : MlmetricprVector, b : MlmetricprVector) -> MlmetricprVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn ml_metric_pr_vector_sub(a : MlmetricprVector, b : MlmetricprVector) -> MlmetricprVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn ml_metric_pr_vector_scale(v : MlmetricprVector, s : Double) -> MlmetricprVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn ml_metric_pr_vector_dot(a : MlmetricprVector, b : MlmetricprVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_metric_pr_vector_norm(v : MlmetricprVector) -> Double { @_common.sqrt(ml_metric_pr_vector_dot(v, v)) }

pub fn ml_metric_pr_vector_normalize(v : MlmetricprVector) -> MlmetricprVector {
  let n = ml_metric_pr_vector_norm(v)
  if n < 0.0000001 { v } else { ml_metric_pr_vector_scale(v, 1.0 / n) }
}

pub fn ml_metric_pr_vector_dist(a : MlmetricprVector, b : MlmetricprVector) -> Double {
  ml_metric_pr_vector_norm(ml_metric_pr_vector_sub(a, b))
}

pub fn ml_metric_pr_vector_to_string(v : MlmetricprVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_metric_pr_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_metric_pr_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_metric_pr_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_metric_pr_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_metric_pr_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_metric_pr_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_metric_pr_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_metric_pr_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_metric_pr_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_metric_pr_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_metric_pr_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_metric_pr_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_metric_pr_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_metric_pr_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_metric_pr_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_metric_pr_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_metric_pr_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_metric_pr_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_metric_pr_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_metric_pr_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_metric_pr_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_metric_pr_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_metric_pr_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_metric_pr_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_metric_pr_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_metric_pr_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_metric_pr_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_metric_pr_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_metric_pr_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlmetricprFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_frame_make(size : Int) -> MlmetricprFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_frame_len(s : MlmetricprFrame) -> Int { s.size }

pub fn ml_metric_pr_frame_get(s : MlmetricprFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_frame_set(s : MlmetricprFrame, i : Int, v : Double) -> MlmetricprFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_frame_sum(s : MlmetricprFrame) -> Double { @_common.sum(s.data) }

pub fn ml_metric_pr_frame_mean(s : MlmetricprFrame) -> Double { @_common.mean(s.data) }

pub fn ml_metric_pr_frame_scale(s : MlmetricprFrame, f : Double) -> MlmetricprFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_frame_add(a : MlmetricprFrame, b : MlmetricprFrame) -> MlmetricprFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_pr_frame_copy(s : MlmetricprFrame) -> MlmetricprFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_frame_fill(s : MlmetricprFrame, v : Double) -> MlmetricprFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_frame_min(s : MlmetricprFrame) -> Double { @_common.min(s.data) }

pub fn ml_metric_pr_frame_max(s : MlmetricprFrame) -> Double { @_common.max(s.data) }

pub fn ml_metric_pr_frame_to_string(s : MlmetricprFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_table_make(size : Int) -> MlmetricprTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_table_len(s : MlmetricprTable) -> Int { s.size }

pub fn ml_metric_pr_table_get(s : MlmetricprTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_table_set(s : MlmetricprTable, i : Int, v : Double) -> MlmetricprTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_table_sum(s : MlmetricprTable) -> Double { @_common.sum(s.data) }

pub fn ml_metric_pr_table_mean(s : MlmetricprTable) -> Double { @_common.mean(s.data) }

pub fn ml_metric_pr_table_scale(s : MlmetricprTable, f : Double) -> MlmetricprTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_table_add(a : MlmetricprTable, b : MlmetricprTable) -> MlmetricprTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_pr_table_copy(s : MlmetricprTable) -> MlmetricprTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_table_fill(s : MlmetricprTable, v : Double) -> MlmetricprTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_table_min(s : MlmetricprTable) -> Double { @_common.min(s.data) }

pub fn ml_metric_pr_table_max(s : MlmetricprTable) -> Double { @_common.max(s.data) }

pub fn ml_metric_pr_table_to_string(s : MlmetricprTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_graphn_make(size : Int) -> MlmetricprGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_graphn_len(s : MlmetricprGraphN) -> Int { s.size }

pub fn ml_metric_pr_graphn_get(s : MlmetricprGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_graphn_set(s : MlmetricprGraphN, i : Int, v : Double) -> MlmetricprGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_graphn_sum(s : MlmetricprGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_metric_pr_graphn_mean(s : MlmetricprGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_metric_pr_graphn_scale(s : MlmetricprGraphN, f : Double) -> MlmetricprGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_graphn_add(a : MlmetricprGraphN, b : MlmetricprGraphN) -> MlmetricprGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_pr_graphn_copy(s : MlmetricprGraphN) -> MlmetricprGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_graphn_fill(s : MlmetricprGraphN, v : Double) -> MlmetricprGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_graphn_min(s : MlmetricprGraphN) -> Double { @_common.min(s.data) }

pub fn ml_metric_pr_graphn_max(s : MlmetricprGraphN) -> Double { @_common.max(s.data) }

pub fn ml_metric_pr_graphn_to_string(s : MlmetricprGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_node_make(size : Int) -> MlmetricprNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_node_len(s : MlmetricprNode) -> Int { s.size }

pub fn ml_metric_pr_node_get(s : MlmetricprNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_node_set(s : MlmetricprNode, i : Int, v : Double) -> MlmetricprNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_node_sum(s : MlmetricprNode) -> Double { @_common.sum(s.data) }

pub fn ml_metric_pr_node_mean(s : MlmetricprNode) -> Double { @_common.mean(s.data) }

pub fn ml_metric_pr_node_scale(s : MlmetricprNode, f : Double) -> MlmetricprNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_node_add(a : MlmetricprNode, b : MlmetricprNode) -> MlmetricprNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_pr_node_copy(s : MlmetricprNode) -> MlmetricprNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_node_fill(s : MlmetricprNode, v : Double) -> MlmetricprNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_node_min(s : MlmetricprNode) -> Double { @_common.min(s.data) }

pub fn ml_metric_pr_node_max(s : MlmetricprNode) -> Double { @_common.max(s.data) }

pub fn ml_metric_pr_node_to_string(s : MlmetricprNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_edge_make(size : Int) -> MlmetricprEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_edge_len(s : MlmetricprEdge) -> Int { s.size }

pub fn ml_metric_pr_edge_get(s : MlmetricprEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_edge_set(s : MlmetricprEdge, i : Int, v : Double) -> MlmetricprEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_edge_sum(s : MlmetricprEdge) -> Double { @_common.sum(s.data) }

pub fn ml_metric_pr_edge_mean(s : MlmetricprEdge) -> Double { @_common.mean(s.data) }

pub fn ml_metric_pr_edge_scale(s : MlmetricprEdge, f : Double) -> MlmetricprEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_edge_add(a : MlmetricprEdge, b : MlmetricprEdge) -> MlmetricprEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_pr_edge_copy(s : MlmetricprEdge) -> MlmetricprEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_edge_fill(s : MlmetricprEdge, v : Double) -> MlmetricprEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_edge_min(s : MlmetricprEdge) -> Double { @_common.min(s.data) }

pub fn ml_metric_pr_edge_max(s : MlmetricprEdge) -> Double { @_common.max(s.data) }

pub fn ml_metric_pr_edge_to_string(s : MlmetricprEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_path_make(size : Int) -> MlmetricprPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_path_len(s : MlmetricprPath) -> Int { s.size }

pub fn ml_metric_pr_path_get(s : MlmetricprPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_path_set(s : MlmetricprPath, i : Int, v : Double) -> MlmetricprPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_path_sum(s : MlmetricprPath) -> Double { @_common.sum(s.data) }

pub fn ml_metric_pr_path_mean(s : MlmetricprPath) -> Double { @_common.mean(s.data) }

pub fn ml_metric_pr_path_scale(s : MlmetricprPath, f : Double) -> MlmetricprPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_path_add(a : MlmetricprPath, b : MlmetricprPath) -> MlmetricprPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_pr_path_copy(s : MlmetricprPath) -> MlmetricprPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_path_fill(s : MlmetricprPath, v : Double) -> MlmetricprPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_path_min(s : MlmetricprPath) -> Double { @_common.min(s.data) }

pub fn ml_metric_pr_path_max(s : MlmetricprPath) -> Double { @_common.max(s.data) }

pub fn ml_metric_pr_path_to_string(s : MlmetricprPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_cluster_make(size : Int) -> MlmetricprCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_cluster_len(s : MlmetricprCluster) -> Int { s.size }

pub fn ml_metric_pr_cluster_get(s : MlmetricprCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_cluster_set(s : MlmetricprCluster, i : Int, v : Double) -> MlmetricprCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_cluster_sum(s : MlmetricprCluster) -> Double { @_common.sum(s.data) }

pub fn ml_metric_pr_cluster_mean(s : MlmetricprCluster) -> Double { @_common.mean(s.data) }

pub fn ml_metric_pr_cluster_scale(s : MlmetricprCluster, f : Double) -> MlmetricprCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_cluster_add(a : MlmetricprCluster, b : MlmetricprCluster) -> MlmetricprCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_pr_cluster_copy(s : MlmetricprCluster) -> MlmetricprCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_cluster_fill(s : MlmetricprCluster, v : Double) -> MlmetricprCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_cluster_min(s : MlmetricprCluster) -> Double { @_common.min(s.data) }

pub fn ml_metric_pr_cluster_max(s : MlmetricprCluster) -> Double { @_common.max(s.data) }

pub fn ml_metric_pr_cluster_to_string(s : MlmetricprCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_model_make(size : Int) -> MlmetricprModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_model_len(s : MlmetricprModel) -> Int { s.size }

pub fn ml_metric_pr_model_get(s : MlmetricprModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_model_set(s : MlmetricprModel, i : Int, v : Double) -> MlmetricprModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_model_sum(s : MlmetricprModel) -> Double { @_common.sum(s.data) }

pub fn ml_metric_pr_model_mean(s : MlmetricprModel) -> Double { @_common.mean(s.data) }

pub fn ml_metric_pr_model_scale(s : MlmetricprModel, f : Double) -> MlmetricprModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_model_add(a : MlmetricprModel, b : MlmetricprModel) -> MlmetricprModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_pr_model_copy(s : MlmetricprModel) -> MlmetricprModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_model_fill(s : MlmetricprModel, v : Double) -> MlmetricprModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_model_min(s : MlmetricprModel) -> Double { @_common.min(s.data) }

pub fn ml_metric_pr_model_max(s : MlmetricprModel) -> Double { @_common.max(s.data) }

pub fn ml_metric_pr_model_to_string(s : MlmetricprModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_layer_make(size : Int) -> MlmetricprLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_layer_len(s : MlmetricprLayer) -> Int { s.size }

pub fn ml_metric_pr_layer_get(s : MlmetricprLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_layer_set(s : MlmetricprLayer, i : Int, v : Double) -> MlmetricprLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_layer_sum(s : MlmetricprLayer) -> Double { @_common.sum(s.data) }

pub fn ml_metric_pr_layer_mean(s : MlmetricprLayer) -> Double { @_common.mean(s.data) }

pub fn ml_metric_pr_layer_scale(s : MlmetricprLayer, f : Double) -> MlmetricprLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_layer_add(a : MlmetricprLayer, b : MlmetricprLayer) -> MlmetricprLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_pr_layer_copy(s : MlmetricprLayer) -> MlmetricprLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_layer_fill(s : MlmetricprLayer, v : Double) -> MlmetricprLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_layer_min(s : MlmetricprLayer) -> Double { @_common.min(s.data) }

pub fn ml_metric_pr_layer_max(s : MlmetricprLayer) -> Double { @_common.max(s.data) }

pub fn ml_metric_pr_layer_to_string(s : MlmetricprLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_buffer_make(size : Int) -> MlmetricprBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_buffer_len(s : MlmetricprBuffer) -> Int { s.size }

pub fn ml_metric_pr_buffer_get(s : MlmetricprBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_buffer_set(s : MlmetricprBuffer, i : Int, v : Double) -> MlmetricprBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_buffer_sum(s : MlmetricprBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_metric_pr_buffer_mean(s : MlmetricprBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_metric_pr_buffer_scale(s : MlmetricprBuffer, f : Double) -> MlmetricprBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_buffer_add(a : MlmetricprBuffer, b : MlmetricprBuffer) -> MlmetricprBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_pr_buffer_copy(s : MlmetricprBuffer) -> MlmetricprBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_buffer_fill(s : MlmetricprBuffer, v : Double) -> MlmetricprBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_buffer_min(s : MlmetricprBuffer) -> Double { @_common.min(s.data) }

pub fn ml_metric_pr_buffer_max(s : MlmetricprBuffer) -> Double { @_common.max(s.data) }

pub fn ml_metric_pr_buffer_to_string(s : MlmetricprBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_cursor_make(size : Int) -> MlmetricprCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_cursor_len(s : MlmetricprCursor) -> Int { s.size }

pub fn ml_metric_pr_cursor_get(s : MlmetricprCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_cursor_set(s : MlmetricprCursor, i : Int, v : Double) -> MlmetricprCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_cursor_sum(s : MlmetricprCursor) -> Double { @_common.sum(s.data) }

pub fn ml_metric_pr_cursor_mean(s : MlmetricprCursor) -> Double { @_common.mean(s.data) }

pub fn ml_metric_pr_cursor_scale(s : MlmetricprCursor, f : Double) -> MlmetricprCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_cursor_add(a : MlmetricprCursor, b : MlmetricprCursor) -> MlmetricprCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_pr_cursor_copy(s : MlmetricprCursor) -> MlmetricprCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_cursor_fill(s : MlmetricprCursor, v : Double) -> MlmetricprCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_cursor_min(s : MlmetricprCursor) -> Double { @_common.min(s.data) }

pub fn ml_metric_pr_cursor_max(s : MlmetricprCursor) -> Double { @_common.max(s.data) }

pub fn ml_metric_pr_cursor_to_string(s : MlmetricprCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_view_make(size : Int) -> MlmetricprView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_view_len(s : MlmetricprView) -> Int { s.size }

pub fn ml_metric_pr_view_get(s : MlmetricprView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_view_set(s : MlmetricprView, i : Int, v : Double) -> MlmetricprView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_view_sum(s : MlmetricprView) -> Double { @_common.sum(s.data) }

pub fn ml_metric_pr_view_mean(s : MlmetricprView) -> Double { @_common.mean(s.data) }

pub fn ml_metric_pr_view_scale(s : MlmetricprView, f : Double) -> MlmetricprView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_view_add(a : MlmetricprView, b : MlmetricprView) -> MlmetricprView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_pr_view_copy(s : MlmetricprView) -> MlmetricprView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_view_fill(s : MlmetricprView, v : Double) -> MlmetricprView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_view_min(s : MlmetricprView) -> Double { @_common.min(s.data) }

pub fn ml_metric_pr_view_max(s : MlmetricprView) -> Double { @_common.max(s.data) }

pub fn ml_metric_pr_view_to_string(s : MlmetricprView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_range_make(size : Int) -> MlmetricprRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_range_len(s : MlmetricprRange) -> Int { s.size }

pub fn ml_metric_pr_range_get(s : MlmetricprRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_range_set(s : MlmetricprRange, i : Int, v : Double) -> MlmetricprRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_range_sum(s : MlmetricprRange) -> Double { @_common.sum(s.data) }

pub fn ml_metric_pr_range_mean(s : MlmetricprRange) -> Double { @_common.mean(s.data) }

pub fn ml_metric_pr_range_scale(s : MlmetricprRange, f : Double) -> MlmetricprRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_range_add(a : MlmetricprRange, b : MlmetricprRange) -> MlmetricprRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_pr_range_copy(s : MlmetricprRange) -> MlmetricprRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_range_fill(s : MlmetricprRange, v : Double) -> MlmetricprRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_range_min(s : MlmetricprRange) -> Double { @_common.min(s.data) }

pub fn ml_metric_pr_range_max(s : MlmetricprRange) -> Double { @_common.max(s.data) }

pub fn ml_metric_pr_range_to_string(s : MlmetricprRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_slice_make(size : Int) -> MlmetricprSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_slice_len(s : MlmetricprSlice) -> Int { s.size }

pub fn ml_metric_pr_slice_get(s : MlmetricprSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_slice_set(s : MlmetricprSlice, i : Int, v : Double) -> MlmetricprSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_slice_sum(s : MlmetricprSlice) -> Double { @_common.sum(s.data) }

pub fn ml_metric_pr_slice_mean(s : MlmetricprSlice) -> Double { @_common.mean(s.data) }

pub fn ml_metric_pr_slice_scale(s : MlmetricprSlice, f : Double) -> MlmetricprSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_slice_add(a : MlmetricprSlice, b : MlmetricprSlice) -> MlmetricprSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_pr_slice_copy(s : MlmetricprSlice) -> MlmetricprSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_slice_fill(s : MlmetricprSlice, v : Double) -> MlmetricprSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_pr_slice_min(s : MlmetricprSlice) -> Double { @_common.min(s.data) }

pub fn ml_metric_pr_slice_max(s : MlmetricprSlice) -> Double { @_common.max(s.data) }

pub fn ml_metric_pr_slice_to_string(s : MlmetricprSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

