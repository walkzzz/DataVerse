///===
/// extcore/opt_grad_adam

pub(all) struct OptgradadamPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_adam_make_point(x : Double, y : Double) -> OptgradadamPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_adam_make_point3(x : Double, y : Double, z : Double) -> OptgradadamPoint {
  { x, y, z, label: 0 }
}

pub fn opt_grad_adam_point_x(pt : OptgradadamPoint) -> Double { pt.x }

pub fn opt_grad_adam_point_y(pt : OptgradadamPoint) -> Double { pt.y }

pub fn opt_grad_adam_point_z(pt : OptgradadamPoint) -> Double { pt.z }

pub fn opt_grad_adam_point_label(pt : OptgradadamPoint) -> Int { pt.label }

pub fn opt_grad_adam_point_dist(a : OptgradadamPoint, b : OptgradadamPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_grad_adam_point_add(a : OptgradadamPoint, b : OptgradadamPoint) -> OptgradadamPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_grad_adam_point_sub(a : OptgradadamPoint, b : OptgradadamPoint) -> OptgradadamPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_grad_adam_point_scale(pt : OptgradadamPoint, s : Double) -> OptgradadamPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_grad_adam_point_dot(a : OptgradadamPoint, b : OptgradadamPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_grad_adam_point_cross(a : OptgradadamPoint, b : OptgradadamPoint) -> OptgradadamPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_grad_adam_point_norm(pt : OptgradadamPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_grad_adam_point_normalize(pt : OptgradadamPoint) -> OptgradadamPoint {
  let n = opt_grad_adam_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_grad_adam_point_scale(pt, 1.0 / n) }
}

pub fn opt_grad_adam_point_negate(pt : OptgradadamPoint) -> OptgradadamPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_grad_adam_point_mid(a : OptgradadamPoint, b : OptgradadamPoint) -> OptgradadamPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_grad_adam_point_lerp(a : OptgradadamPoint, b : OptgradadamPoint, t : Double) -> OptgradadamPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_grad_adam_point_to_string(pt : OptgradadamPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptgradadamSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_adam_make_series(vals : Array[Double], name : String) -> OptgradadamSeries {
  { vals, name, meta: 0 }
}

pub fn opt_grad_adam_series_len(s : OptgradadamSeries) -> Int { s.vals.length() }

pub fn opt_grad_adam_series_sum(s : OptgradadamSeries) -> Double { @_common.sum(s.vals) }

pub fn opt_grad_adam_series_mean(s : OptgradadamSeries) -> Double { @_common.mean(s.vals) }

pub fn opt_grad_adam_series_min(s : OptgradadamSeries) -> Double { @_common.min(s.vals) }

pub fn opt_grad_adam_series_max(s : OptgradadamSeries) -> Double { @_common.max(s.vals) }

pub fn opt_grad_adam_series_range(s : OptgradadamSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn opt_grad_adam_series_var(s : OptgradadamSeries) -> Double { @_common.variance(s.vals) }

pub fn opt_grad_adam_series_std(s : OptgradadamSeries) -> Double { @_common.std(s.vals) }

pub fn opt_grad_adam_series_median(s : OptgradadamSeries) -> Double { @_common.median(s.vals) }

pub fn opt_grad_adam_series_scale(s : OptgradadamSeries, f : Double) -> OptgradadamSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn opt_grad_adam_series_add(a : OptgradadamSeries, b : OptgradadamSeries) -> OptgradadamSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_grad_adam_series_sub(a : OptgradadamSeries, b : OptgradadamSeries) -> OptgradadamSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_grad_adam_series_normalize(s : OptgradadamSeries) -> OptgradadamSeries {
  let mn = opt_grad_adam_series_min(s)
  let mx = opt_grad_adam_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_grad_adam_series_cumsum(s : OptgradadamSeries) -> OptgradadamSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_grad_adam_series_to_string(s : OptgradadamSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradadamMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_adam_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradadamMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_grad_adam_matrix_identity(n : Int) -> OptgradadamMatrix {
  let m = opt_grad_adam_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_grad_adam_matrix_get(m : OptgradadamMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_grad_adam_matrix_transpose(m : OptgradadamMatrix) -> OptgradadamMatrix {
  let result = opt_grad_adam_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_grad_adam_matrix_add(a : OptgradadamMatrix, b : OptgradadamMatrix) -> OptgradadamMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_grad_adam_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_grad_adam_matrix_scale(m : OptgradadamMatrix, s : Double) -> OptgradadamMatrix {
  let result = opt_grad_adam_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_grad_adam_matrix_multiply(a : OptgradadamMatrix, b : OptgradadamMatrix) -> OptgradadamMatrix {
  if a.cols != b.rows { return opt_grad_adam_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_grad_adam_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_grad_adam_matrix_trace(m : OptgradadamMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_grad_adam_matrix_det(m : OptgradadamMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_grad_adam_matrix_norm(m : OptgradadamMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn opt_grad_adam_matrix_to_string(m : OptgradadamMatrix) -> String {
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

pub(all) struct OptgradadamVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_adam_make_vector(comps : Array[Double]) -> OptgradadamVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_adam_vector_zero(dim : Int) -> OptgradadamVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_grad_adam_vector_add(a : OptgradadamVector, b : OptgradadamVector) -> OptgradadamVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn opt_grad_adam_vector_sub(a : OptgradadamVector, b : OptgradadamVector) -> OptgradadamVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn opt_grad_adam_vector_scale(v : OptgradadamVector, s : Double) -> OptgradadamVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn opt_grad_adam_vector_dot(a : OptgradadamVector, b : OptgradadamVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_grad_adam_vector_norm(v : OptgradadamVector) -> Double { @_common.sqrt(opt_grad_adam_vector_dot(v, v)) }

pub fn opt_grad_adam_vector_normalize(v : OptgradadamVector) -> OptgradadamVector {
  let n = opt_grad_adam_vector_norm(v)
  if n < 0.0000001 { v } else { opt_grad_adam_vector_scale(v, 1.0 / n) }
}

pub fn opt_grad_adam_vector_dist(a : OptgradadamVector, b : OptgradadamVector) -> Double {
  opt_grad_adam_vector_norm(opt_grad_adam_vector_sub(a, b))
}

pub fn opt_grad_adam_vector_to_string(v : OptgradadamVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_grad_adam_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_grad_adam_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_grad_adam_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_grad_adam_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_grad_adam_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_grad_adam_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_grad_adam_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_grad_adam_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_grad_adam_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_grad_adam_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_grad_adam_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_grad_adam_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_grad_adam_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_grad_adam_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_grad_adam_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_grad_adam_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_grad_adam_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_grad_adam_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_grad_adam_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_grad_adam_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_grad_adam_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_grad_adam_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_grad_adam_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_grad_adam_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_grad_adam_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_grad_adam_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_grad_adam_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_grad_adam_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_grad_adam_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptgradadamFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_frame_make(size : Int) -> OptgradadamFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_frame_len(s : OptgradadamFrame) -> Int { s.size }

pub fn opt_grad_adam_frame_get(s : OptgradadamFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_frame_set(s : OptgradadamFrame, i : Int, v : Double) -> OptgradadamFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_frame_sum(s : OptgradadamFrame) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_frame_mean(s : OptgradadamFrame) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_frame_scale(s : OptgradadamFrame, f : Double) -> OptgradadamFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_frame_add(a : OptgradadamFrame, b : OptgradadamFrame) -> OptgradadamFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_frame_copy(s : OptgradadamFrame) -> OptgradadamFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_frame_fill(s : OptgradadamFrame, v : Double) -> OptgradadamFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_frame_min(s : OptgradadamFrame) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_frame_max(s : OptgradadamFrame) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_frame_to_string(s : OptgradadamFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_table_make(size : Int) -> OptgradadamTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_table_len(s : OptgradadamTable) -> Int { s.size }

pub fn opt_grad_adam_table_get(s : OptgradadamTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_table_set(s : OptgradadamTable, i : Int, v : Double) -> OptgradadamTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_table_sum(s : OptgradadamTable) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_table_mean(s : OptgradadamTable) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_table_scale(s : OptgradadamTable, f : Double) -> OptgradadamTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_table_add(a : OptgradadamTable, b : OptgradadamTable) -> OptgradadamTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_table_copy(s : OptgradadamTable) -> OptgradadamTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_table_fill(s : OptgradadamTable, v : Double) -> OptgradadamTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_table_min(s : OptgradadamTable) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_table_max(s : OptgradadamTable) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_table_to_string(s : OptgradadamTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_graphn_make(size : Int) -> OptgradadamGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_graphn_len(s : OptgradadamGraphN) -> Int { s.size }

pub fn opt_grad_adam_graphn_get(s : OptgradadamGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_graphn_set(s : OptgradadamGraphN, i : Int, v : Double) -> OptgradadamGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_graphn_sum(s : OptgradadamGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_graphn_mean(s : OptgradadamGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_graphn_scale(s : OptgradadamGraphN, f : Double) -> OptgradadamGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_graphn_add(a : OptgradadamGraphN, b : OptgradadamGraphN) -> OptgradadamGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_graphn_copy(s : OptgradadamGraphN) -> OptgradadamGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_graphn_fill(s : OptgradadamGraphN, v : Double) -> OptgradadamGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_graphn_min(s : OptgradadamGraphN) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_graphn_max(s : OptgradadamGraphN) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_graphn_to_string(s : OptgradadamGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_node_make(size : Int) -> OptgradadamNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_node_len(s : OptgradadamNode) -> Int { s.size }

pub fn opt_grad_adam_node_get(s : OptgradadamNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_node_set(s : OptgradadamNode, i : Int, v : Double) -> OptgradadamNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_node_sum(s : OptgradadamNode) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_node_mean(s : OptgradadamNode) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_node_scale(s : OptgradadamNode, f : Double) -> OptgradadamNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_node_add(a : OptgradadamNode, b : OptgradadamNode) -> OptgradadamNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_node_copy(s : OptgradadamNode) -> OptgradadamNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_node_fill(s : OptgradadamNode, v : Double) -> OptgradadamNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_node_min(s : OptgradadamNode) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_node_max(s : OptgradadamNode) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_node_to_string(s : OptgradadamNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_edge_make(size : Int) -> OptgradadamEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_edge_len(s : OptgradadamEdge) -> Int { s.size }

pub fn opt_grad_adam_edge_get(s : OptgradadamEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_edge_set(s : OptgradadamEdge, i : Int, v : Double) -> OptgradadamEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_edge_sum(s : OptgradadamEdge) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_edge_mean(s : OptgradadamEdge) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_edge_scale(s : OptgradadamEdge, f : Double) -> OptgradadamEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_edge_add(a : OptgradadamEdge, b : OptgradadamEdge) -> OptgradadamEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_edge_copy(s : OptgradadamEdge) -> OptgradadamEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_edge_fill(s : OptgradadamEdge, v : Double) -> OptgradadamEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_edge_min(s : OptgradadamEdge) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_edge_max(s : OptgradadamEdge) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_edge_to_string(s : OptgradadamEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_path_make(size : Int) -> OptgradadamPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_path_len(s : OptgradadamPath) -> Int { s.size }

pub fn opt_grad_adam_path_get(s : OptgradadamPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_path_set(s : OptgradadamPath, i : Int, v : Double) -> OptgradadamPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_path_sum(s : OptgradadamPath) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_path_mean(s : OptgradadamPath) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_path_scale(s : OptgradadamPath, f : Double) -> OptgradadamPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_path_add(a : OptgradadamPath, b : OptgradadamPath) -> OptgradadamPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_path_copy(s : OptgradadamPath) -> OptgradadamPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_path_fill(s : OptgradadamPath, v : Double) -> OptgradadamPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_path_min(s : OptgradadamPath) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_path_max(s : OptgradadamPath) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_path_to_string(s : OptgradadamPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_cluster_make(size : Int) -> OptgradadamCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_cluster_len(s : OptgradadamCluster) -> Int { s.size }

pub fn opt_grad_adam_cluster_get(s : OptgradadamCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_cluster_set(s : OptgradadamCluster, i : Int, v : Double) -> OptgradadamCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_cluster_sum(s : OptgradadamCluster) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_cluster_mean(s : OptgradadamCluster) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_cluster_scale(s : OptgradadamCluster, f : Double) -> OptgradadamCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_cluster_add(a : OptgradadamCluster, b : OptgradadamCluster) -> OptgradadamCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_cluster_copy(s : OptgradadamCluster) -> OptgradadamCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_cluster_fill(s : OptgradadamCluster, v : Double) -> OptgradadamCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_cluster_min(s : OptgradadamCluster) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_cluster_max(s : OptgradadamCluster) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_cluster_to_string(s : OptgradadamCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_model_make(size : Int) -> OptgradadamModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_model_len(s : OptgradadamModel) -> Int { s.size }

pub fn opt_grad_adam_model_get(s : OptgradadamModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_model_set(s : OptgradadamModel, i : Int, v : Double) -> OptgradadamModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_model_sum(s : OptgradadamModel) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_model_mean(s : OptgradadamModel) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_model_scale(s : OptgradadamModel, f : Double) -> OptgradadamModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_model_add(a : OptgradadamModel, b : OptgradadamModel) -> OptgradadamModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_model_copy(s : OptgradadamModel) -> OptgradadamModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_model_fill(s : OptgradadamModel, v : Double) -> OptgradadamModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_model_min(s : OptgradadamModel) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_model_max(s : OptgradadamModel) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_model_to_string(s : OptgradadamModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_layer_make(size : Int) -> OptgradadamLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_layer_len(s : OptgradadamLayer) -> Int { s.size }

pub fn opt_grad_adam_layer_get(s : OptgradadamLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_layer_set(s : OptgradadamLayer, i : Int, v : Double) -> OptgradadamLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_layer_sum(s : OptgradadamLayer) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_layer_mean(s : OptgradadamLayer) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_layer_scale(s : OptgradadamLayer, f : Double) -> OptgradadamLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_layer_add(a : OptgradadamLayer, b : OptgradadamLayer) -> OptgradadamLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_layer_copy(s : OptgradadamLayer) -> OptgradadamLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_layer_fill(s : OptgradadamLayer, v : Double) -> OptgradadamLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_layer_min(s : OptgradadamLayer) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_layer_max(s : OptgradadamLayer) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_layer_to_string(s : OptgradadamLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_buffer_make(size : Int) -> OptgradadamBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_buffer_len(s : OptgradadamBuffer) -> Int { s.size }

pub fn opt_grad_adam_buffer_get(s : OptgradadamBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_buffer_set(s : OptgradadamBuffer, i : Int, v : Double) -> OptgradadamBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_buffer_sum(s : OptgradadamBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_buffer_mean(s : OptgradadamBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_buffer_scale(s : OptgradadamBuffer, f : Double) -> OptgradadamBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_buffer_add(a : OptgradadamBuffer, b : OptgradadamBuffer) -> OptgradadamBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_buffer_copy(s : OptgradadamBuffer) -> OptgradadamBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_buffer_fill(s : OptgradadamBuffer, v : Double) -> OptgradadamBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_buffer_min(s : OptgradadamBuffer) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_buffer_max(s : OptgradadamBuffer) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_buffer_to_string(s : OptgradadamBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_cursor_make(size : Int) -> OptgradadamCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_cursor_len(s : OptgradadamCursor) -> Int { s.size }

pub fn opt_grad_adam_cursor_get(s : OptgradadamCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_cursor_set(s : OptgradadamCursor, i : Int, v : Double) -> OptgradadamCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_cursor_sum(s : OptgradadamCursor) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_cursor_mean(s : OptgradadamCursor) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_cursor_scale(s : OptgradadamCursor, f : Double) -> OptgradadamCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_cursor_add(a : OptgradadamCursor, b : OptgradadamCursor) -> OptgradadamCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_cursor_copy(s : OptgradadamCursor) -> OptgradadamCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_cursor_fill(s : OptgradadamCursor, v : Double) -> OptgradadamCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_cursor_min(s : OptgradadamCursor) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_cursor_max(s : OptgradadamCursor) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_cursor_to_string(s : OptgradadamCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_view_make(size : Int) -> OptgradadamView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_view_len(s : OptgradadamView) -> Int { s.size }

pub fn opt_grad_adam_view_get(s : OptgradadamView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_view_set(s : OptgradadamView, i : Int, v : Double) -> OptgradadamView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_view_sum(s : OptgradadamView) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_view_mean(s : OptgradadamView) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_view_scale(s : OptgradadamView, f : Double) -> OptgradadamView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_view_add(a : OptgradadamView, b : OptgradadamView) -> OptgradadamView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_view_copy(s : OptgradadamView) -> OptgradadamView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_view_fill(s : OptgradadamView, v : Double) -> OptgradadamView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_view_min(s : OptgradadamView) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_view_max(s : OptgradadamView) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_view_to_string(s : OptgradadamView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_range_make(size : Int) -> OptgradadamRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_range_len(s : OptgradadamRange) -> Int { s.size }

pub fn opt_grad_adam_range_get(s : OptgradadamRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_range_set(s : OptgradadamRange, i : Int, v : Double) -> OptgradadamRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_range_sum(s : OptgradadamRange) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_range_mean(s : OptgradadamRange) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_range_scale(s : OptgradadamRange, f : Double) -> OptgradadamRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_range_add(a : OptgradadamRange, b : OptgradadamRange) -> OptgradadamRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_range_copy(s : OptgradadamRange) -> OptgradadamRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_range_fill(s : OptgradadamRange, v : Double) -> OptgradadamRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_range_min(s : OptgradadamRange) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_range_max(s : OptgradadamRange) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_range_to_string(s : OptgradadamRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_slice_make(size : Int) -> OptgradadamSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_slice_len(s : OptgradadamSlice) -> Int { s.size }

pub fn opt_grad_adam_slice_get(s : OptgradadamSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_slice_set(s : OptgradadamSlice, i : Int, v : Double) -> OptgradadamSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_slice_sum(s : OptgradadamSlice) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_slice_mean(s : OptgradadamSlice) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_slice_scale(s : OptgradadamSlice, f : Double) -> OptgradadamSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_slice_add(a : OptgradadamSlice, b : OptgradadamSlice) -> OptgradadamSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_slice_copy(s : OptgradadamSlice) -> OptgradadamSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_slice_fill(s : OptgradadamSlice, v : Double) -> OptgradadamSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_slice_min(s : OptgradadamSlice) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_slice_max(s : OptgradadamSlice) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_slice_to_string(s : OptgradadamSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

