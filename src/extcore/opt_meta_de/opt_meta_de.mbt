///===
/// extcore/opt_meta_de

pub(all) struct OptmetadePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_de_make_point(x : Double, y : Double) -> OptmetadePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_de_make_point3(x : Double, y : Double, z : Double) -> OptmetadePoint {
  { x, y, z, label: 0 }
}

pub fn opt_meta_de_point_x(pt : OptmetadePoint) -> Double { pt.x }

pub fn opt_meta_de_point_y(pt : OptmetadePoint) -> Double { pt.y }

pub fn opt_meta_de_point_z(pt : OptmetadePoint) -> Double { pt.z }

pub fn opt_meta_de_point_label(pt : OptmetadePoint) -> Int { pt.label }

pub fn opt_meta_de_point_dist(a : OptmetadePoint, b : OptmetadePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_meta_de_point_add(a : OptmetadePoint, b : OptmetadePoint) -> OptmetadePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_meta_de_point_sub(a : OptmetadePoint, b : OptmetadePoint) -> OptmetadePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_meta_de_point_scale(pt : OptmetadePoint, s : Double) -> OptmetadePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_meta_de_point_dot(a : OptmetadePoint, b : OptmetadePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_meta_de_point_cross(a : OptmetadePoint, b : OptmetadePoint) -> OptmetadePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_meta_de_point_norm(pt : OptmetadePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_meta_de_point_normalize(pt : OptmetadePoint) -> OptmetadePoint {
  let n = opt_meta_de_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_meta_de_point_scale(pt, 1.0 / n) }
}

pub fn opt_meta_de_point_negate(pt : OptmetadePoint) -> OptmetadePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_meta_de_point_mid(a : OptmetadePoint, b : OptmetadePoint) -> OptmetadePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_meta_de_point_lerp(a : OptmetadePoint, b : OptmetadePoint, t : Double) -> OptmetadePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_meta_de_point_to_string(pt : OptmetadePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptmetadeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_de_make_series(vals : Array[Double], name : String) -> OptmetadeSeries {
  { vals, name, meta: 0 }
}

pub fn opt_meta_de_series_len(s : OptmetadeSeries) -> Int { s.vals.length() }

pub fn opt_meta_de_series_sum(s : OptmetadeSeries) -> Double { @_common.sum(s.vals) }

pub fn opt_meta_de_series_mean(s : OptmetadeSeries) -> Double { @_common.mean(s.vals) }

pub fn opt_meta_de_series_min(s : OptmetadeSeries) -> Double { @_common.min(s.vals) }

pub fn opt_meta_de_series_max(s : OptmetadeSeries) -> Double { @_common.max(s.vals) }

pub fn opt_meta_de_series_range(s : OptmetadeSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn opt_meta_de_series_var(s : OptmetadeSeries) -> Double { @_common.variance(s.vals) }

pub fn opt_meta_de_series_std(s : OptmetadeSeries) -> Double { @_common.std(s.vals) }

pub fn opt_meta_de_series_median(s : OptmetadeSeries) -> Double { @_common.median(s.vals) }

pub fn opt_meta_de_series_scale(s : OptmetadeSeries, f : Double) -> OptmetadeSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn opt_meta_de_series_add(a : OptmetadeSeries, b : OptmetadeSeries) -> OptmetadeSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_meta_de_series_sub(a : OptmetadeSeries, b : OptmetadeSeries) -> OptmetadeSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_meta_de_series_normalize(s : OptmetadeSeries) -> OptmetadeSeries {
  let mn = opt_meta_de_series_min(s)
  let mx = opt_meta_de_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_meta_de_series_cumsum(s : OptmetadeSeries) -> OptmetadeSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_meta_de_series_to_string(s : OptmetadeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetadeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_de_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetadeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_de_matrix_identity(n : Int) -> OptmetadeMatrix {
  let m = opt_meta_de_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_meta_de_matrix_get(m : OptmetadeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_meta_de_matrix_transpose(m : OptmetadeMatrix) -> OptmetadeMatrix {
  let result = opt_meta_de_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_meta_de_matrix_add(a : OptmetadeMatrix, b : OptmetadeMatrix) -> OptmetadeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_meta_de_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_meta_de_matrix_scale(m : OptmetadeMatrix, s : Double) -> OptmetadeMatrix {
  let result = opt_meta_de_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_meta_de_matrix_multiply(a : OptmetadeMatrix, b : OptmetadeMatrix) -> OptmetadeMatrix {
  if a.cols != b.rows { return opt_meta_de_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_meta_de_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_meta_de_matrix_trace(m : OptmetadeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_meta_de_matrix_det(m : OptmetadeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_meta_de_matrix_norm(m : OptmetadeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn opt_meta_de_matrix_to_string(m : OptmetadeMatrix) -> String {
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

pub(all) struct OptmetadeVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_de_make_vector(comps : Array[Double]) -> OptmetadeVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_de_vector_zero(dim : Int) -> OptmetadeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_meta_de_vector_add(a : OptmetadeVector, b : OptmetadeVector) -> OptmetadeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn opt_meta_de_vector_sub(a : OptmetadeVector, b : OptmetadeVector) -> OptmetadeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn opt_meta_de_vector_scale(v : OptmetadeVector, s : Double) -> OptmetadeVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn opt_meta_de_vector_dot(a : OptmetadeVector, b : OptmetadeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_meta_de_vector_norm(v : OptmetadeVector) -> Double { @_common.sqrt(opt_meta_de_vector_dot(v, v)) }

pub fn opt_meta_de_vector_normalize(v : OptmetadeVector) -> OptmetadeVector {
  let n = opt_meta_de_vector_norm(v)
  if n < 0.0000001 { v } else { opt_meta_de_vector_scale(v, 1.0 / n) }
}

pub fn opt_meta_de_vector_dist(a : OptmetadeVector, b : OptmetadeVector) -> Double {
  opt_meta_de_vector_norm(opt_meta_de_vector_sub(a, b))
}

pub fn opt_meta_de_vector_to_string(v : OptmetadeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_meta_de_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_meta_de_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_meta_de_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_meta_de_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_meta_de_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_meta_de_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_meta_de_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_meta_de_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_meta_de_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_meta_de_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_meta_de_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_meta_de_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_meta_de_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_meta_de_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_meta_de_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_meta_de_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_meta_de_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_meta_de_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_meta_de_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_meta_de_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_meta_de_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_meta_de_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_meta_de_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_meta_de_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_meta_de_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_meta_de_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_meta_de_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_meta_de_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_meta_de_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptmetadeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_frame_make(size : Int) -> OptmetadeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_de_frame_len(s : OptmetadeFrame) -> Int { s.size }

pub fn opt_meta_de_frame_get(s : OptmetadeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_de_frame_set(s : OptmetadeFrame, i : Int, v : Double) -> OptmetadeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_de_frame_sum(s : OptmetadeFrame) -> Double { @_common.sum(s.data) }

pub fn opt_meta_de_frame_mean(s : OptmetadeFrame) -> Double { @_common.mean(s.data) }

pub fn opt_meta_de_frame_scale(s : OptmetadeFrame, f : Double) -> OptmetadeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_frame_add(a : OptmetadeFrame, b : OptmetadeFrame) -> OptmetadeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_de_frame_copy(s : OptmetadeFrame) -> OptmetadeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_frame_fill(s : OptmetadeFrame, v : Double) -> OptmetadeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_frame_min(s : OptmetadeFrame) -> Double { @_common.min(s.data) }

pub fn opt_meta_de_frame_max(s : OptmetadeFrame) -> Double { @_common.max(s.data) }

pub fn opt_meta_de_frame_to_string(s : OptmetadeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_table_make(size : Int) -> OptmetadeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_de_table_len(s : OptmetadeTable) -> Int { s.size }

pub fn opt_meta_de_table_get(s : OptmetadeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_de_table_set(s : OptmetadeTable, i : Int, v : Double) -> OptmetadeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_de_table_sum(s : OptmetadeTable) -> Double { @_common.sum(s.data) }

pub fn opt_meta_de_table_mean(s : OptmetadeTable) -> Double { @_common.mean(s.data) }

pub fn opt_meta_de_table_scale(s : OptmetadeTable, f : Double) -> OptmetadeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_table_add(a : OptmetadeTable, b : OptmetadeTable) -> OptmetadeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_de_table_copy(s : OptmetadeTable) -> OptmetadeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_table_fill(s : OptmetadeTable, v : Double) -> OptmetadeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_table_min(s : OptmetadeTable) -> Double { @_common.min(s.data) }

pub fn opt_meta_de_table_max(s : OptmetadeTable) -> Double { @_common.max(s.data) }

pub fn opt_meta_de_table_to_string(s : OptmetadeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_graphn_make(size : Int) -> OptmetadeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_de_graphn_len(s : OptmetadeGraphN) -> Int { s.size }

pub fn opt_meta_de_graphn_get(s : OptmetadeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_de_graphn_set(s : OptmetadeGraphN, i : Int, v : Double) -> OptmetadeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_de_graphn_sum(s : OptmetadeGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_meta_de_graphn_mean(s : OptmetadeGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_meta_de_graphn_scale(s : OptmetadeGraphN, f : Double) -> OptmetadeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_graphn_add(a : OptmetadeGraphN, b : OptmetadeGraphN) -> OptmetadeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_de_graphn_copy(s : OptmetadeGraphN) -> OptmetadeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_graphn_fill(s : OptmetadeGraphN, v : Double) -> OptmetadeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_graphn_min(s : OptmetadeGraphN) -> Double { @_common.min(s.data) }

pub fn opt_meta_de_graphn_max(s : OptmetadeGraphN) -> Double { @_common.max(s.data) }

pub fn opt_meta_de_graphn_to_string(s : OptmetadeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_node_make(size : Int) -> OptmetadeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_de_node_len(s : OptmetadeNode) -> Int { s.size }

pub fn opt_meta_de_node_get(s : OptmetadeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_de_node_set(s : OptmetadeNode, i : Int, v : Double) -> OptmetadeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_de_node_sum(s : OptmetadeNode) -> Double { @_common.sum(s.data) }

pub fn opt_meta_de_node_mean(s : OptmetadeNode) -> Double { @_common.mean(s.data) }

pub fn opt_meta_de_node_scale(s : OptmetadeNode, f : Double) -> OptmetadeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_node_add(a : OptmetadeNode, b : OptmetadeNode) -> OptmetadeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_de_node_copy(s : OptmetadeNode) -> OptmetadeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_node_fill(s : OptmetadeNode, v : Double) -> OptmetadeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_node_min(s : OptmetadeNode) -> Double { @_common.min(s.data) }

pub fn opt_meta_de_node_max(s : OptmetadeNode) -> Double { @_common.max(s.data) }

pub fn opt_meta_de_node_to_string(s : OptmetadeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_edge_make(size : Int) -> OptmetadeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_de_edge_len(s : OptmetadeEdge) -> Int { s.size }

pub fn opt_meta_de_edge_get(s : OptmetadeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_de_edge_set(s : OptmetadeEdge, i : Int, v : Double) -> OptmetadeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_de_edge_sum(s : OptmetadeEdge) -> Double { @_common.sum(s.data) }

pub fn opt_meta_de_edge_mean(s : OptmetadeEdge) -> Double { @_common.mean(s.data) }

pub fn opt_meta_de_edge_scale(s : OptmetadeEdge, f : Double) -> OptmetadeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_edge_add(a : OptmetadeEdge, b : OptmetadeEdge) -> OptmetadeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_de_edge_copy(s : OptmetadeEdge) -> OptmetadeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_edge_fill(s : OptmetadeEdge, v : Double) -> OptmetadeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_edge_min(s : OptmetadeEdge) -> Double { @_common.min(s.data) }

pub fn opt_meta_de_edge_max(s : OptmetadeEdge) -> Double { @_common.max(s.data) }

pub fn opt_meta_de_edge_to_string(s : OptmetadeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_path_make(size : Int) -> OptmetadePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_de_path_len(s : OptmetadePath) -> Int { s.size }

pub fn opt_meta_de_path_get(s : OptmetadePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_de_path_set(s : OptmetadePath, i : Int, v : Double) -> OptmetadePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_de_path_sum(s : OptmetadePath) -> Double { @_common.sum(s.data) }

pub fn opt_meta_de_path_mean(s : OptmetadePath) -> Double { @_common.mean(s.data) }

pub fn opt_meta_de_path_scale(s : OptmetadePath, f : Double) -> OptmetadePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_path_add(a : OptmetadePath, b : OptmetadePath) -> OptmetadePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_de_path_copy(s : OptmetadePath) -> OptmetadePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_path_fill(s : OptmetadePath, v : Double) -> OptmetadePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_path_min(s : OptmetadePath) -> Double { @_common.min(s.data) }

pub fn opt_meta_de_path_max(s : OptmetadePath) -> Double { @_common.max(s.data) }

pub fn opt_meta_de_path_to_string(s : OptmetadePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_cluster_make(size : Int) -> OptmetadeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_de_cluster_len(s : OptmetadeCluster) -> Int { s.size }

pub fn opt_meta_de_cluster_get(s : OptmetadeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_de_cluster_set(s : OptmetadeCluster, i : Int, v : Double) -> OptmetadeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_de_cluster_sum(s : OptmetadeCluster) -> Double { @_common.sum(s.data) }

pub fn opt_meta_de_cluster_mean(s : OptmetadeCluster) -> Double { @_common.mean(s.data) }

pub fn opt_meta_de_cluster_scale(s : OptmetadeCluster, f : Double) -> OptmetadeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_cluster_add(a : OptmetadeCluster, b : OptmetadeCluster) -> OptmetadeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_de_cluster_copy(s : OptmetadeCluster) -> OptmetadeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_cluster_fill(s : OptmetadeCluster, v : Double) -> OptmetadeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_cluster_min(s : OptmetadeCluster) -> Double { @_common.min(s.data) }

pub fn opt_meta_de_cluster_max(s : OptmetadeCluster) -> Double { @_common.max(s.data) }

pub fn opt_meta_de_cluster_to_string(s : OptmetadeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_model_make(size : Int) -> OptmetadeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_de_model_len(s : OptmetadeModel) -> Int { s.size }

pub fn opt_meta_de_model_get(s : OptmetadeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_de_model_set(s : OptmetadeModel, i : Int, v : Double) -> OptmetadeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_de_model_sum(s : OptmetadeModel) -> Double { @_common.sum(s.data) }

pub fn opt_meta_de_model_mean(s : OptmetadeModel) -> Double { @_common.mean(s.data) }

pub fn opt_meta_de_model_scale(s : OptmetadeModel, f : Double) -> OptmetadeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_model_add(a : OptmetadeModel, b : OptmetadeModel) -> OptmetadeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_de_model_copy(s : OptmetadeModel) -> OptmetadeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_model_fill(s : OptmetadeModel, v : Double) -> OptmetadeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_model_min(s : OptmetadeModel) -> Double { @_common.min(s.data) }

pub fn opt_meta_de_model_max(s : OptmetadeModel) -> Double { @_common.max(s.data) }

pub fn opt_meta_de_model_to_string(s : OptmetadeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_layer_make(size : Int) -> OptmetadeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_de_layer_len(s : OptmetadeLayer) -> Int { s.size }

pub fn opt_meta_de_layer_get(s : OptmetadeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_de_layer_set(s : OptmetadeLayer, i : Int, v : Double) -> OptmetadeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_de_layer_sum(s : OptmetadeLayer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_de_layer_mean(s : OptmetadeLayer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_de_layer_scale(s : OptmetadeLayer, f : Double) -> OptmetadeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_layer_add(a : OptmetadeLayer, b : OptmetadeLayer) -> OptmetadeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_de_layer_copy(s : OptmetadeLayer) -> OptmetadeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_layer_fill(s : OptmetadeLayer, v : Double) -> OptmetadeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_layer_min(s : OptmetadeLayer) -> Double { @_common.min(s.data) }

pub fn opt_meta_de_layer_max(s : OptmetadeLayer) -> Double { @_common.max(s.data) }

pub fn opt_meta_de_layer_to_string(s : OptmetadeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_buffer_make(size : Int) -> OptmetadeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_de_buffer_len(s : OptmetadeBuffer) -> Int { s.size }

pub fn opt_meta_de_buffer_get(s : OptmetadeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_de_buffer_set(s : OptmetadeBuffer, i : Int, v : Double) -> OptmetadeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_de_buffer_sum(s : OptmetadeBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_de_buffer_mean(s : OptmetadeBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_de_buffer_scale(s : OptmetadeBuffer, f : Double) -> OptmetadeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_buffer_add(a : OptmetadeBuffer, b : OptmetadeBuffer) -> OptmetadeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_de_buffer_copy(s : OptmetadeBuffer) -> OptmetadeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_buffer_fill(s : OptmetadeBuffer, v : Double) -> OptmetadeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_buffer_min(s : OptmetadeBuffer) -> Double { @_common.min(s.data) }

pub fn opt_meta_de_buffer_max(s : OptmetadeBuffer) -> Double { @_common.max(s.data) }

pub fn opt_meta_de_buffer_to_string(s : OptmetadeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_cursor_make(size : Int) -> OptmetadeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_de_cursor_len(s : OptmetadeCursor) -> Int { s.size }

pub fn opt_meta_de_cursor_get(s : OptmetadeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_de_cursor_set(s : OptmetadeCursor, i : Int, v : Double) -> OptmetadeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_de_cursor_sum(s : OptmetadeCursor) -> Double { @_common.sum(s.data) }

pub fn opt_meta_de_cursor_mean(s : OptmetadeCursor) -> Double { @_common.mean(s.data) }

pub fn opt_meta_de_cursor_scale(s : OptmetadeCursor, f : Double) -> OptmetadeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_cursor_add(a : OptmetadeCursor, b : OptmetadeCursor) -> OptmetadeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_de_cursor_copy(s : OptmetadeCursor) -> OptmetadeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_cursor_fill(s : OptmetadeCursor, v : Double) -> OptmetadeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_cursor_min(s : OptmetadeCursor) -> Double { @_common.min(s.data) }

pub fn opt_meta_de_cursor_max(s : OptmetadeCursor) -> Double { @_common.max(s.data) }

pub fn opt_meta_de_cursor_to_string(s : OptmetadeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_view_make(size : Int) -> OptmetadeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_de_view_len(s : OptmetadeView) -> Int { s.size }

pub fn opt_meta_de_view_get(s : OptmetadeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_de_view_set(s : OptmetadeView, i : Int, v : Double) -> OptmetadeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_de_view_sum(s : OptmetadeView) -> Double { @_common.sum(s.data) }

pub fn opt_meta_de_view_mean(s : OptmetadeView) -> Double { @_common.mean(s.data) }

pub fn opt_meta_de_view_scale(s : OptmetadeView, f : Double) -> OptmetadeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_view_add(a : OptmetadeView, b : OptmetadeView) -> OptmetadeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_de_view_copy(s : OptmetadeView) -> OptmetadeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_view_fill(s : OptmetadeView, v : Double) -> OptmetadeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_view_min(s : OptmetadeView) -> Double { @_common.min(s.data) }

pub fn opt_meta_de_view_max(s : OptmetadeView) -> Double { @_common.max(s.data) }

pub fn opt_meta_de_view_to_string(s : OptmetadeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_range_make(size : Int) -> OptmetadeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_de_range_len(s : OptmetadeRange) -> Int { s.size }

pub fn opt_meta_de_range_get(s : OptmetadeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_de_range_set(s : OptmetadeRange, i : Int, v : Double) -> OptmetadeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_de_range_sum(s : OptmetadeRange) -> Double { @_common.sum(s.data) }

pub fn opt_meta_de_range_mean(s : OptmetadeRange) -> Double { @_common.mean(s.data) }

pub fn opt_meta_de_range_scale(s : OptmetadeRange, f : Double) -> OptmetadeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_range_add(a : OptmetadeRange, b : OptmetadeRange) -> OptmetadeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_de_range_copy(s : OptmetadeRange) -> OptmetadeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_range_fill(s : OptmetadeRange, v : Double) -> OptmetadeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_range_min(s : OptmetadeRange) -> Double { @_common.min(s.data) }

pub fn opt_meta_de_range_max(s : OptmetadeRange) -> Double { @_common.max(s.data) }

pub fn opt_meta_de_range_to_string(s : OptmetadeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_slice_make(size : Int) -> OptmetadeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_de_slice_len(s : OptmetadeSlice) -> Int { s.size }

pub fn opt_meta_de_slice_get(s : OptmetadeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_de_slice_set(s : OptmetadeSlice, i : Int, v : Double) -> OptmetadeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_de_slice_sum(s : OptmetadeSlice) -> Double { @_common.sum(s.data) }

pub fn opt_meta_de_slice_mean(s : OptmetadeSlice) -> Double { @_common.mean(s.data) }

pub fn opt_meta_de_slice_scale(s : OptmetadeSlice, f : Double) -> OptmetadeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_slice_add(a : OptmetadeSlice, b : OptmetadeSlice) -> OptmetadeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_de_slice_copy(s : OptmetadeSlice) -> OptmetadeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_slice_fill(s : OptmetadeSlice, v : Double) -> OptmetadeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_de_slice_min(s : OptmetadeSlice) -> Double { @_common.min(s.data) }

pub fn opt_meta_de_slice_max(s : OptmetadeSlice) -> Double { @_common.max(s.data) }

pub fn opt_meta_de_slice_to_string(s : OptmetadeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

