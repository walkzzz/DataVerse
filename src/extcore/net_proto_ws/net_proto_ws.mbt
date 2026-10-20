///===
/// extcore/net_proto_ws

pub(all) struct NetprotowsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_proto_ws_make_point(x : Double, y : Double) -> NetprotowsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_proto_ws_make_point3(x : Double, y : Double, z : Double) -> NetprotowsPoint {
  { x, y, z, label: 0 }
}

pub fn net_proto_ws_point_x(pt : NetprotowsPoint) -> Double { pt.x }

pub fn net_proto_ws_point_y(pt : NetprotowsPoint) -> Double { pt.y }

pub fn net_proto_ws_point_z(pt : NetprotowsPoint) -> Double { pt.z }

pub fn net_proto_ws_point_label(pt : NetprotowsPoint) -> Int { pt.label }

pub fn net_proto_ws_point_dist(a : NetprotowsPoint, b : NetprotowsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_proto_ws_point_add(a : NetprotowsPoint, b : NetprotowsPoint) -> NetprotowsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_proto_ws_point_sub(a : NetprotowsPoint, b : NetprotowsPoint) -> NetprotowsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_proto_ws_point_scale(pt : NetprotowsPoint, s : Double) -> NetprotowsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_proto_ws_point_dot(a : NetprotowsPoint, b : NetprotowsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_proto_ws_point_cross(a : NetprotowsPoint, b : NetprotowsPoint) -> NetprotowsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_proto_ws_point_norm(pt : NetprotowsPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_proto_ws_point_normalize(pt : NetprotowsPoint) -> NetprotowsPoint {
  let n = net_proto_ws_point_norm(pt)
  if n < 0.0000001 { pt } else { net_proto_ws_point_scale(pt, 1.0 / n) }
}

pub fn net_proto_ws_point_negate(pt : NetprotowsPoint) -> NetprotowsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_proto_ws_point_mid(a : NetprotowsPoint, b : NetprotowsPoint) -> NetprotowsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_proto_ws_point_lerp(a : NetprotowsPoint, b : NetprotowsPoint, t : Double) -> NetprotowsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_proto_ws_point_to_string(pt : NetprotowsPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetprotowsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_proto_ws_make_series(vals : Array[Double], name : String) -> NetprotowsSeries {
  { vals, name, meta: 0 }
}

pub fn net_proto_ws_series_len(s : NetprotowsSeries) -> Int { s.vals.length() }

pub fn net_proto_ws_series_sum(s : NetprotowsSeries) -> Double { @_common.sum(s.vals) }

pub fn net_proto_ws_series_mean(s : NetprotowsSeries) -> Double { @_common.mean(s.vals) }

pub fn net_proto_ws_series_min(s : NetprotowsSeries) -> Double { @_common.min(s.vals) }

pub fn net_proto_ws_series_max(s : NetprotowsSeries) -> Double { @_common.max(s.vals) }

pub fn net_proto_ws_series_range(s : NetprotowsSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn net_proto_ws_series_var(s : NetprotowsSeries) -> Double { @_common.variance(s.vals) }

pub fn net_proto_ws_series_std(s : NetprotowsSeries) -> Double { @_common.std(s.vals) }

pub fn net_proto_ws_series_median(s : NetprotowsSeries) -> Double { @_common.median(s.vals) }

pub fn net_proto_ws_series_scale(s : NetprotowsSeries, f : Double) -> NetprotowsSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn net_proto_ws_series_add(a : NetprotowsSeries, b : NetprotowsSeries) -> NetprotowsSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_proto_ws_series_sub(a : NetprotowsSeries, b : NetprotowsSeries) -> NetprotowsSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_proto_ws_series_normalize(s : NetprotowsSeries) -> NetprotowsSeries {
  let mn = net_proto_ws_series_min(s)
  let mx = net_proto_ws_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_proto_ws_series_cumsum(s : NetprotowsSeries) -> NetprotowsSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_proto_ws_series_to_string(s : NetprotowsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetprotowsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_proto_ws_make_matrix(rows : Int, cols : Int, val : Double) -> NetprotowsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_proto_ws_matrix_identity(n : Int) -> NetprotowsMatrix {
  let m = net_proto_ws_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_proto_ws_matrix_get(m : NetprotowsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_proto_ws_matrix_transpose(m : NetprotowsMatrix) -> NetprotowsMatrix {
  let result = net_proto_ws_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_proto_ws_matrix_add(a : NetprotowsMatrix, b : NetprotowsMatrix) -> NetprotowsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_proto_ws_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_proto_ws_matrix_scale(m : NetprotowsMatrix, s : Double) -> NetprotowsMatrix {
  let result = net_proto_ws_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_proto_ws_matrix_multiply(a : NetprotowsMatrix, b : NetprotowsMatrix) -> NetprotowsMatrix {
  if a.cols != b.rows { return net_proto_ws_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_proto_ws_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_proto_ws_matrix_trace(m : NetprotowsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_proto_ws_matrix_det(m : NetprotowsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_proto_ws_matrix_norm(m : NetprotowsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_proto_ws_matrix_to_string(m : NetprotowsMatrix) -> String {
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

pub(all) struct NetprotowsVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_proto_ws_make_vector(comps : Array[Double]) -> NetprotowsVector {
  { comps, dim: comps.length() }
}

pub fn net_proto_ws_vector_zero(dim : Int) -> NetprotowsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_proto_ws_vector_add(a : NetprotowsVector, b : NetprotowsVector) -> NetprotowsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn net_proto_ws_vector_sub(a : NetprotowsVector, b : NetprotowsVector) -> NetprotowsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn net_proto_ws_vector_scale(v : NetprotowsVector, s : Double) -> NetprotowsVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn net_proto_ws_vector_dot(a : NetprotowsVector, b : NetprotowsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_proto_ws_vector_norm(v : NetprotowsVector) -> Double { @_common.sqrt(net_proto_ws_vector_dot(v, v)) }

pub fn net_proto_ws_vector_normalize(v : NetprotowsVector) -> NetprotowsVector {
  let n = net_proto_ws_vector_norm(v)
  if n < 0.0000001 { v } else { net_proto_ws_vector_scale(v, 1.0 / n) }
}

pub fn net_proto_ws_vector_dist(a : NetprotowsVector, b : NetprotowsVector) -> Double {
  net_proto_ws_vector_norm(net_proto_ws_vector_sub(a, b))
}

pub fn net_proto_ws_vector_to_string(v : NetprotowsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_proto_ws_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_proto_ws_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_proto_ws_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_proto_ws_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_proto_ws_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_proto_ws_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_proto_ws_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_proto_ws_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_proto_ws_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_proto_ws_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_proto_ws_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_proto_ws_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_proto_ws_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_proto_ws_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_proto_ws_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_proto_ws_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_proto_ws_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_proto_ws_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_proto_ws_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_proto_ws_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_proto_ws_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_proto_ws_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_proto_ws_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_proto_ws_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_proto_ws_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_proto_ws_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_proto_ws_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_proto_ws_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_proto_ws_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetprotowsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_frame_make(size : Int) -> NetprotowsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_frame_len(s : NetprotowsFrame) -> Int { s.size }

pub fn net_proto_ws_frame_get(s : NetprotowsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_frame_set(s : NetprotowsFrame, i : Int, v : Double) -> NetprotowsFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_ws_frame_sum(s : NetprotowsFrame) -> Double { @_common.sum(s.data) }

pub fn net_proto_ws_frame_mean(s : NetprotowsFrame) -> Double { @_common.mean(s.data) }

pub fn net_proto_ws_frame_scale(s : NetprotowsFrame, f : Double) -> NetprotowsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_frame_add(a : NetprotowsFrame, b : NetprotowsFrame) -> NetprotowsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_ws_frame_copy(s : NetprotowsFrame) -> NetprotowsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_frame_fill(s : NetprotowsFrame, v : Double) -> NetprotowsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_frame_min(s : NetprotowsFrame) -> Double { @_common.min(s.data) }

pub fn net_proto_ws_frame_max(s : NetprotowsFrame) -> Double { @_common.max(s.data) }

pub fn net_proto_ws_frame_to_string(s : NetprotowsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_table_make(size : Int) -> NetprotowsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_table_len(s : NetprotowsTable) -> Int { s.size }

pub fn net_proto_ws_table_get(s : NetprotowsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_table_set(s : NetprotowsTable, i : Int, v : Double) -> NetprotowsTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_ws_table_sum(s : NetprotowsTable) -> Double { @_common.sum(s.data) }

pub fn net_proto_ws_table_mean(s : NetprotowsTable) -> Double { @_common.mean(s.data) }

pub fn net_proto_ws_table_scale(s : NetprotowsTable, f : Double) -> NetprotowsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_table_add(a : NetprotowsTable, b : NetprotowsTable) -> NetprotowsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_ws_table_copy(s : NetprotowsTable) -> NetprotowsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_table_fill(s : NetprotowsTable, v : Double) -> NetprotowsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_table_min(s : NetprotowsTable) -> Double { @_common.min(s.data) }

pub fn net_proto_ws_table_max(s : NetprotowsTable) -> Double { @_common.max(s.data) }

pub fn net_proto_ws_table_to_string(s : NetprotowsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_graphn_make(size : Int) -> NetprotowsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_graphn_len(s : NetprotowsGraphN) -> Int { s.size }

pub fn net_proto_ws_graphn_get(s : NetprotowsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_graphn_set(s : NetprotowsGraphN, i : Int, v : Double) -> NetprotowsGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_ws_graphn_sum(s : NetprotowsGraphN) -> Double { @_common.sum(s.data) }

pub fn net_proto_ws_graphn_mean(s : NetprotowsGraphN) -> Double { @_common.mean(s.data) }

pub fn net_proto_ws_graphn_scale(s : NetprotowsGraphN, f : Double) -> NetprotowsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_graphn_add(a : NetprotowsGraphN, b : NetprotowsGraphN) -> NetprotowsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_ws_graphn_copy(s : NetprotowsGraphN) -> NetprotowsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_graphn_fill(s : NetprotowsGraphN, v : Double) -> NetprotowsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_graphn_min(s : NetprotowsGraphN) -> Double { @_common.min(s.data) }

pub fn net_proto_ws_graphn_max(s : NetprotowsGraphN) -> Double { @_common.max(s.data) }

pub fn net_proto_ws_graphn_to_string(s : NetprotowsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_node_make(size : Int) -> NetprotowsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_node_len(s : NetprotowsNode) -> Int { s.size }

pub fn net_proto_ws_node_get(s : NetprotowsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_node_set(s : NetprotowsNode, i : Int, v : Double) -> NetprotowsNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_ws_node_sum(s : NetprotowsNode) -> Double { @_common.sum(s.data) }

pub fn net_proto_ws_node_mean(s : NetprotowsNode) -> Double { @_common.mean(s.data) }

pub fn net_proto_ws_node_scale(s : NetprotowsNode, f : Double) -> NetprotowsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_node_add(a : NetprotowsNode, b : NetprotowsNode) -> NetprotowsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_ws_node_copy(s : NetprotowsNode) -> NetprotowsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_node_fill(s : NetprotowsNode, v : Double) -> NetprotowsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_node_min(s : NetprotowsNode) -> Double { @_common.min(s.data) }

pub fn net_proto_ws_node_max(s : NetprotowsNode) -> Double { @_common.max(s.data) }

pub fn net_proto_ws_node_to_string(s : NetprotowsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_edge_make(size : Int) -> NetprotowsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_edge_len(s : NetprotowsEdge) -> Int { s.size }

pub fn net_proto_ws_edge_get(s : NetprotowsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_edge_set(s : NetprotowsEdge, i : Int, v : Double) -> NetprotowsEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_ws_edge_sum(s : NetprotowsEdge) -> Double { @_common.sum(s.data) }

pub fn net_proto_ws_edge_mean(s : NetprotowsEdge) -> Double { @_common.mean(s.data) }

pub fn net_proto_ws_edge_scale(s : NetprotowsEdge, f : Double) -> NetprotowsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_edge_add(a : NetprotowsEdge, b : NetprotowsEdge) -> NetprotowsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_ws_edge_copy(s : NetprotowsEdge) -> NetprotowsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_edge_fill(s : NetprotowsEdge, v : Double) -> NetprotowsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_edge_min(s : NetprotowsEdge) -> Double { @_common.min(s.data) }

pub fn net_proto_ws_edge_max(s : NetprotowsEdge) -> Double { @_common.max(s.data) }

pub fn net_proto_ws_edge_to_string(s : NetprotowsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_path_make(size : Int) -> NetprotowsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_path_len(s : NetprotowsPath) -> Int { s.size }

pub fn net_proto_ws_path_get(s : NetprotowsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_path_set(s : NetprotowsPath, i : Int, v : Double) -> NetprotowsPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_ws_path_sum(s : NetprotowsPath) -> Double { @_common.sum(s.data) }

pub fn net_proto_ws_path_mean(s : NetprotowsPath) -> Double { @_common.mean(s.data) }

pub fn net_proto_ws_path_scale(s : NetprotowsPath, f : Double) -> NetprotowsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_path_add(a : NetprotowsPath, b : NetprotowsPath) -> NetprotowsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_ws_path_copy(s : NetprotowsPath) -> NetprotowsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_path_fill(s : NetprotowsPath, v : Double) -> NetprotowsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_path_min(s : NetprotowsPath) -> Double { @_common.min(s.data) }

pub fn net_proto_ws_path_max(s : NetprotowsPath) -> Double { @_common.max(s.data) }

pub fn net_proto_ws_path_to_string(s : NetprotowsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_cluster_make(size : Int) -> NetprotowsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_cluster_len(s : NetprotowsCluster) -> Int { s.size }

pub fn net_proto_ws_cluster_get(s : NetprotowsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_cluster_set(s : NetprotowsCluster, i : Int, v : Double) -> NetprotowsCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_ws_cluster_sum(s : NetprotowsCluster) -> Double { @_common.sum(s.data) }

pub fn net_proto_ws_cluster_mean(s : NetprotowsCluster) -> Double { @_common.mean(s.data) }

pub fn net_proto_ws_cluster_scale(s : NetprotowsCluster, f : Double) -> NetprotowsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_cluster_add(a : NetprotowsCluster, b : NetprotowsCluster) -> NetprotowsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_ws_cluster_copy(s : NetprotowsCluster) -> NetprotowsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_cluster_fill(s : NetprotowsCluster, v : Double) -> NetprotowsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_cluster_min(s : NetprotowsCluster) -> Double { @_common.min(s.data) }

pub fn net_proto_ws_cluster_max(s : NetprotowsCluster) -> Double { @_common.max(s.data) }

pub fn net_proto_ws_cluster_to_string(s : NetprotowsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_model_make(size : Int) -> NetprotowsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_model_len(s : NetprotowsModel) -> Int { s.size }

pub fn net_proto_ws_model_get(s : NetprotowsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_model_set(s : NetprotowsModel, i : Int, v : Double) -> NetprotowsModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_ws_model_sum(s : NetprotowsModel) -> Double { @_common.sum(s.data) }

pub fn net_proto_ws_model_mean(s : NetprotowsModel) -> Double { @_common.mean(s.data) }

pub fn net_proto_ws_model_scale(s : NetprotowsModel, f : Double) -> NetprotowsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_model_add(a : NetprotowsModel, b : NetprotowsModel) -> NetprotowsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_ws_model_copy(s : NetprotowsModel) -> NetprotowsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_model_fill(s : NetprotowsModel, v : Double) -> NetprotowsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_model_min(s : NetprotowsModel) -> Double { @_common.min(s.data) }

pub fn net_proto_ws_model_max(s : NetprotowsModel) -> Double { @_common.max(s.data) }

pub fn net_proto_ws_model_to_string(s : NetprotowsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_layer_make(size : Int) -> NetprotowsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_layer_len(s : NetprotowsLayer) -> Int { s.size }

pub fn net_proto_ws_layer_get(s : NetprotowsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_layer_set(s : NetprotowsLayer, i : Int, v : Double) -> NetprotowsLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_ws_layer_sum(s : NetprotowsLayer) -> Double { @_common.sum(s.data) }

pub fn net_proto_ws_layer_mean(s : NetprotowsLayer) -> Double { @_common.mean(s.data) }

pub fn net_proto_ws_layer_scale(s : NetprotowsLayer, f : Double) -> NetprotowsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_layer_add(a : NetprotowsLayer, b : NetprotowsLayer) -> NetprotowsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_ws_layer_copy(s : NetprotowsLayer) -> NetprotowsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_layer_fill(s : NetprotowsLayer, v : Double) -> NetprotowsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_layer_min(s : NetprotowsLayer) -> Double { @_common.min(s.data) }

pub fn net_proto_ws_layer_max(s : NetprotowsLayer) -> Double { @_common.max(s.data) }

pub fn net_proto_ws_layer_to_string(s : NetprotowsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_buffer_make(size : Int) -> NetprotowsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_buffer_len(s : NetprotowsBuffer) -> Int { s.size }

pub fn net_proto_ws_buffer_get(s : NetprotowsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_buffer_set(s : NetprotowsBuffer, i : Int, v : Double) -> NetprotowsBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_ws_buffer_sum(s : NetprotowsBuffer) -> Double { @_common.sum(s.data) }

pub fn net_proto_ws_buffer_mean(s : NetprotowsBuffer) -> Double { @_common.mean(s.data) }

pub fn net_proto_ws_buffer_scale(s : NetprotowsBuffer, f : Double) -> NetprotowsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_buffer_add(a : NetprotowsBuffer, b : NetprotowsBuffer) -> NetprotowsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_ws_buffer_copy(s : NetprotowsBuffer) -> NetprotowsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_buffer_fill(s : NetprotowsBuffer, v : Double) -> NetprotowsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_buffer_min(s : NetprotowsBuffer) -> Double { @_common.min(s.data) }

pub fn net_proto_ws_buffer_max(s : NetprotowsBuffer) -> Double { @_common.max(s.data) }

pub fn net_proto_ws_buffer_to_string(s : NetprotowsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_cursor_make(size : Int) -> NetprotowsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_cursor_len(s : NetprotowsCursor) -> Int { s.size }

pub fn net_proto_ws_cursor_get(s : NetprotowsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_cursor_set(s : NetprotowsCursor, i : Int, v : Double) -> NetprotowsCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_ws_cursor_sum(s : NetprotowsCursor) -> Double { @_common.sum(s.data) }

pub fn net_proto_ws_cursor_mean(s : NetprotowsCursor) -> Double { @_common.mean(s.data) }

pub fn net_proto_ws_cursor_scale(s : NetprotowsCursor, f : Double) -> NetprotowsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_cursor_add(a : NetprotowsCursor, b : NetprotowsCursor) -> NetprotowsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_ws_cursor_copy(s : NetprotowsCursor) -> NetprotowsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_cursor_fill(s : NetprotowsCursor, v : Double) -> NetprotowsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_cursor_min(s : NetprotowsCursor) -> Double { @_common.min(s.data) }

pub fn net_proto_ws_cursor_max(s : NetprotowsCursor) -> Double { @_common.max(s.data) }

pub fn net_proto_ws_cursor_to_string(s : NetprotowsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_view_make(size : Int) -> NetprotowsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_view_len(s : NetprotowsView) -> Int { s.size }

pub fn net_proto_ws_view_get(s : NetprotowsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_view_set(s : NetprotowsView, i : Int, v : Double) -> NetprotowsView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_ws_view_sum(s : NetprotowsView) -> Double { @_common.sum(s.data) }

pub fn net_proto_ws_view_mean(s : NetprotowsView) -> Double { @_common.mean(s.data) }

pub fn net_proto_ws_view_scale(s : NetprotowsView, f : Double) -> NetprotowsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_view_add(a : NetprotowsView, b : NetprotowsView) -> NetprotowsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_ws_view_copy(s : NetprotowsView) -> NetprotowsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_view_fill(s : NetprotowsView, v : Double) -> NetprotowsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_view_min(s : NetprotowsView) -> Double { @_common.min(s.data) }

pub fn net_proto_ws_view_max(s : NetprotowsView) -> Double { @_common.max(s.data) }

pub fn net_proto_ws_view_to_string(s : NetprotowsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_range_make(size : Int) -> NetprotowsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_range_len(s : NetprotowsRange) -> Int { s.size }

pub fn net_proto_ws_range_get(s : NetprotowsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_range_set(s : NetprotowsRange, i : Int, v : Double) -> NetprotowsRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_ws_range_sum(s : NetprotowsRange) -> Double { @_common.sum(s.data) }

pub fn net_proto_ws_range_mean(s : NetprotowsRange) -> Double { @_common.mean(s.data) }

pub fn net_proto_ws_range_scale(s : NetprotowsRange, f : Double) -> NetprotowsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_range_add(a : NetprotowsRange, b : NetprotowsRange) -> NetprotowsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_ws_range_copy(s : NetprotowsRange) -> NetprotowsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_range_fill(s : NetprotowsRange, v : Double) -> NetprotowsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_range_min(s : NetprotowsRange) -> Double { @_common.min(s.data) }

pub fn net_proto_ws_range_max(s : NetprotowsRange) -> Double { @_common.max(s.data) }

pub fn net_proto_ws_range_to_string(s : NetprotowsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_slice_make(size : Int) -> NetprotowsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_slice_len(s : NetprotowsSlice) -> Int { s.size }

pub fn net_proto_ws_slice_get(s : NetprotowsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_slice_set(s : NetprotowsSlice, i : Int, v : Double) -> NetprotowsSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_ws_slice_sum(s : NetprotowsSlice) -> Double { @_common.sum(s.data) }

pub fn net_proto_ws_slice_mean(s : NetprotowsSlice) -> Double { @_common.mean(s.data) }

pub fn net_proto_ws_slice_scale(s : NetprotowsSlice, f : Double) -> NetprotowsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_slice_add(a : NetprotowsSlice, b : NetprotowsSlice) -> NetprotowsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_ws_slice_copy(s : NetprotowsSlice) -> NetprotowsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_slice_fill(s : NetprotowsSlice, v : Double) -> NetprotowsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_ws_slice_min(s : NetprotowsSlice) -> Double { @_common.min(s.data) }

pub fn net_proto_ws_slice_max(s : NetprotowsSlice) -> Double { @_common.max(s.data) }

pub fn net_proto_ws_slice_to_string(s : NetprotowsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

