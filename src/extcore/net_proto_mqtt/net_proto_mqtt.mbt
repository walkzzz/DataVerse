///===
/// extcore/net_proto_mqtt

pub(all) struct NetprotomqttPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_proto_mqtt_make_point(x : Double, y : Double) -> NetprotomqttPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_proto_mqtt_make_point3(x : Double, y : Double, z : Double) -> NetprotomqttPoint {
  { x, y, z, label: 0 }
}

pub fn net_proto_mqtt_point_x(pt : NetprotomqttPoint) -> Double { pt.x }

pub fn net_proto_mqtt_point_y(pt : NetprotomqttPoint) -> Double { pt.y }

pub fn net_proto_mqtt_point_z(pt : NetprotomqttPoint) -> Double { pt.z }

pub fn net_proto_mqtt_point_label(pt : NetprotomqttPoint) -> Int { pt.label }

pub fn net_proto_mqtt_point_dist(a : NetprotomqttPoint, b : NetprotomqttPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_proto_mqtt_point_add(a : NetprotomqttPoint, b : NetprotomqttPoint) -> NetprotomqttPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_proto_mqtt_point_sub(a : NetprotomqttPoint, b : NetprotomqttPoint) -> NetprotomqttPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_proto_mqtt_point_scale(pt : NetprotomqttPoint, s : Double) -> NetprotomqttPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_proto_mqtt_point_dot(a : NetprotomqttPoint, b : NetprotomqttPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_proto_mqtt_point_cross(a : NetprotomqttPoint, b : NetprotomqttPoint) -> NetprotomqttPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_proto_mqtt_point_norm(pt : NetprotomqttPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_proto_mqtt_point_normalize(pt : NetprotomqttPoint) -> NetprotomqttPoint {
  let n = net_proto_mqtt_point_norm(pt)
  if n < 0.0000001 { pt } else { net_proto_mqtt_point_scale(pt, 1.0 / n) }
}

pub fn net_proto_mqtt_point_negate(pt : NetprotomqttPoint) -> NetprotomqttPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_proto_mqtt_point_mid(a : NetprotomqttPoint, b : NetprotomqttPoint) -> NetprotomqttPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_proto_mqtt_point_lerp(a : NetprotomqttPoint, b : NetprotomqttPoint, t : Double) -> NetprotomqttPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_proto_mqtt_point_to_string(pt : NetprotomqttPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetprotomqttSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_proto_mqtt_make_series(vals : Array[Double], name : String) -> NetprotomqttSeries {
  { vals, name, meta: 0 }
}

pub fn net_proto_mqtt_series_len(s : NetprotomqttSeries) -> Int { s.vals.length() }

pub fn net_proto_mqtt_series_sum(s : NetprotomqttSeries) -> Double { @_common.sum(s.vals) }

pub fn net_proto_mqtt_series_mean(s : NetprotomqttSeries) -> Double { @_common.mean(s.vals) }

pub fn net_proto_mqtt_series_min(s : NetprotomqttSeries) -> Double { @_common.min(s.vals) }

pub fn net_proto_mqtt_series_max(s : NetprotomqttSeries) -> Double { @_common.max(s.vals) }

pub fn net_proto_mqtt_series_range(s : NetprotomqttSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn net_proto_mqtt_series_var(s : NetprotomqttSeries) -> Double { @_common.variance(s.vals) }

pub fn net_proto_mqtt_series_std(s : NetprotomqttSeries) -> Double { @_common.std(s.vals) }

pub fn net_proto_mqtt_series_median(s : NetprotomqttSeries) -> Double { @_common.median(s.vals) }

pub fn net_proto_mqtt_series_scale(s : NetprotomqttSeries, f : Double) -> NetprotomqttSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_proto_mqtt_series_add(a : NetprotomqttSeries, b : NetprotomqttSeries) -> NetprotomqttSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_proto_mqtt_series_sub(a : NetprotomqttSeries, b : NetprotomqttSeries) -> NetprotomqttSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_proto_mqtt_series_normalize(s : NetprotomqttSeries) -> NetprotomqttSeries {
  let mn = net_proto_mqtt_series_min(s)
  let mx = net_proto_mqtt_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_proto_mqtt_series_cumsum(s : NetprotomqttSeries) -> NetprotomqttSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_proto_mqtt_series_to_string(s : NetprotomqttSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetprotomqttMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_proto_mqtt_make_matrix(rows : Int, cols : Int, val : Double) -> NetprotomqttMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_proto_mqtt_matrix_identity(n : Int) -> NetprotomqttMatrix {
  let m = net_proto_mqtt_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_proto_mqtt_matrix_get(m : NetprotomqttMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_proto_mqtt_matrix_transpose(m : NetprotomqttMatrix) -> NetprotomqttMatrix {
  let result = net_proto_mqtt_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_proto_mqtt_matrix_add(a : NetprotomqttMatrix, b : NetprotomqttMatrix) -> NetprotomqttMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_proto_mqtt_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_proto_mqtt_matrix_scale(m : NetprotomqttMatrix, s : Double) -> NetprotomqttMatrix {
  let result = net_proto_mqtt_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_proto_mqtt_matrix_multiply(a : NetprotomqttMatrix, b : NetprotomqttMatrix) -> NetprotomqttMatrix {
  if a.cols != b.rows { return net_proto_mqtt_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_proto_mqtt_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_proto_mqtt_matrix_trace(m : NetprotomqttMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_proto_mqtt_matrix_det(m : NetprotomqttMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_proto_mqtt_matrix_norm(m : NetprotomqttMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_proto_mqtt_matrix_to_string(m : NetprotomqttMatrix) -> String {
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

pub(all) struct NetprotomqttVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_proto_mqtt_make_vector(comps : Array[Double]) -> NetprotomqttVector {
  { comps, dim: comps.length() }
}

pub fn net_proto_mqtt_vector_zero(dim : Int) -> NetprotomqttVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_proto_mqtt_vector_add(a : NetprotomqttVector, b : NetprotomqttVector) -> NetprotomqttVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_proto_mqtt_vector_sub(a : NetprotomqttVector, b : NetprotomqttVector) -> NetprotomqttVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_proto_mqtt_vector_scale(v : NetprotomqttVector, s : Double) -> NetprotomqttVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_proto_mqtt_vector_dot(a : NetprotomqttVector, b : NetprotomqttVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_proto_mqtt_vector_norm(v : NetprotomqttVector) -> Double { @_common.sqrt(net_proto_mqtt_vector_dot(v, v)) }

pub fn net_proto_mqtt_vector_normalize(v : NetprotomqttVector) -> NetprotomqttVector {
  let n = net_proto_mqtt_vector_norm(v)
  if n < 0.0000001 { v } else { net_proto_mqtt_vector_scale(v, 1.0 / n) }
}

pub fn net_proto_mqtt_vector_dist(a : NetprotomqttVector, b : NetprotomqttVector) -> Double {
  net_proto_mqtt_vector_norm(net_proto_mqtt_vector_sub(a, b))
}

pub fn net_proto_mqtt_vector_to_string(v : NetprotomqttVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_proto_mqtt_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_proto_mqtt_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_proto_mqtt_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_proto_mqtt_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_proto_mqtt_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_proto_mqtt_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_proto_mqtt_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_proto_mqtt_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_proto_mqtt_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_proto_mqtt_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_proto_mqtt_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_proto_mqtt_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_proto_mqtt_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_proto_mqtt_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_proto_mqtt_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_proto_mqtt_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_proto_mqtt_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_proto_mqtt_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_proto_mqtt_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_proto_mqtt_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_proto_mqtt_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_proto_mqtt_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_proto_mqtt_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_proto_mqtt_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_proto_mqtt_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_proto_mqtt_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_proto_mqtt_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_proto_mqtt_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_proto_mqtt_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetprotomqttFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_frame_make(size : Int) -> NetprotomqttFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_frame_len(s : NetprotomqttFrame) -> Int { s.size }

pub fn net_proto_mqtt_frame_get(s : NetprotomqttFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_frame_set(s : NetprotomqttFrame, i : Int, v : Double) -> NetprotomqttFrame {
  let result = net_proto_mqtt_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_mqtt_frame_sum(s : NetprotomqttFrame) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_frame_mean(s : NetprotomqttFrame) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_frame_scale(s : NetprotomqttFrame, f : Double) -> NetprotomqttFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_frame_add(a : NetprotomqttFrame, b : NetprotomqttFrame) -> NetprotomqttFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_frame_copy(s : NetprotomqttFrame) -> NetprotomqttFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_frame_fill(s : NetprotomqttFrame, v : Double) -> NetprotomqttFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_frame_min(s : NetprotomqttFrame) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_frame_max(s : NetprotomqttFrame) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_frame_to_string(s : NetprotomqttFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_table_make(size : Int) -> NetprotomqttTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_table_len(s : NetprotomqttTable) -> Int { s.size }

pub fn net_proto_mqtt_table_get(s : NetprotomqttTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_table_set(s : NetprotomqttTable, i : Int, v : Double) -> NetprotomqttTable {
  let result = net_proto_mqtt_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_mqtt_table_sum(s : NetprotomqttTable) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_table_mean(s : NetprotomqttTable) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_table_scale(s : NetprotomqttTable, f : Double) -> NetprotomqttTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_table_add(a : NetprotomqttTable, b : NetprotomqttTable) -> NetprotomqttTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_table_copy(s : NetprotomqttTable) -> NetprotomqttTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_table_fill(s : NetprotomqttTable, v : Double) -> NetprotomqttTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_table_min(s : NetprotomqttTable) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_table_max(s : NetprotomqttTable) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_table_to_string(s : NetprotomqttTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_graphn_make(size : Int) -> NetprotomqttGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_graphn_len(s : NetprotomqttGraphN) -> Int { s.size }

pub fn net_proto_mqtt_graphn_get(s : NetprotomqttGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_graphn_set(s : NetprotomqttGraphN, i : Int, v : Double) -> NetprotomqttGraphN {
  let result = net_proto_mqtt_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_mqtt_graphn_sum(s : NetprotomqttGraphN) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_graphn_mean(s : NetprotomqttGraphN) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_graphn_scale(s : NetprotomqttGraphN, f : Double) -> NetprotomqttGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_graphn_add(a : NetprotomqttGraphN, b : NetprotomqttGraphN) -> NetprotomqttGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_graphn_copy(s : NetprotomqttGraphN) -> NetprotomqttGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_graphn_fill(s : NetprotomqttGraphN, v : Double) -> NetprotomqttGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_graphn_min(s : NetprotomqttGraphN) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_graphn_max(s : NetprotomqttGraphN) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_graphn_to_string(s : NetprotomqttGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_node_make(size : Int) -> NetprotomqttNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_node_len(s : NetprotomqttNode) -> Int { s.size }

pub fn net_proto_mqtt_node_get(s : NetprotomqttNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_node_set(s : NetprotomqttNode, i : Int, v : Double) -> NetprotomqttNode {
  let result = net_proto_mqtt_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_mqtt_node_sum(s : NetprotomqttNode) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_node_mean(s : NetprotomqttNode) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_node_scale(s : NetprotomqttNode, f : Double) -> NetprotomqttNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_node_add(a : NetprotomqttNode, b : NetprotomqttNode) -> NetprotomqttNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_node_copy(s : NetprotomqttNode) -> NetprotomqttNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_node_fill(s : NetprotomqttNode, v : Double) -> NetprotomqttNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_node_min(s : NetprotomqttNode) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_node_max(s : NetprotomqttNode) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_node_to_string(s : NetprotomqttNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_edge_make(size : Int) -> NetprotomqttEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_edge_len(s : NetprotomqttEdge) -> Int { s.size }

pub fn net_proto_mqtt_edge_get(s : NetprotomqttEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_edge_set(s : NetprotomqttEdge, i : Int, v : Double) -> NetprotomqttEdge {
  let result = net_proto_mqtt_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_mqtt_edge_sum(s : NetprotomqttEdge) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_edge_mean(s : NetprotomqttEdge) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_edge_scale(s : NetprotomqttEdge, f : Double) -> NetprotomqttEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_edge_add(a : NetprotomqttEdge, b : NetprotomqttEdge) -> NetprotomqttEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_edge_copy(s : NetprotomqttEdge) -> NetprotomqttEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_edge_fill(s : NetprotomqttEdge, v : Double) -> NetprotomqttEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_edge_min(s : NetprotomqttEdge) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_edge_max(s : NetprotomqttEdge) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_edge_to_string(s : NetprotomqttEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_path_make(size : Int) -> NetprotomqttPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_path_len(s : NetprotomqttPath) -> Int { s.size }

pub fn net_proto_mqtt_path_get(s : NetprotomqttPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_path_set(s : NetprotomqttPath, i : Int, v : Double) -> NetprotomqttPath {
  let result = net_proto_mqtt_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_mqtt_path_sum(s : NetprotomqttPath) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_path_mean(s : NetprotomqttPath) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_path_scale(s : NetprotomqttPath, f : Double) -> NetprotomqttPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_path_add(a : NetprotomqttPath, b : NetprotomqttPath) -> NetprotomqttPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_path_copy(s : NetprotomqttPath) -> NetprotomqttPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_path_fill(s : NetprotomqttPath, v : Double) -> NetprotomqttPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_path_min(s : NetprotomqttPath) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_path_max(s : NetprotomqttPath) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_path_to_string(s : NetprotomqttPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_cluster_make(size : Int) -> NetprotomqttCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_cluster_len(s : NetprotomqttCluster) -> Int { s.size }

pub fn net_proto_mqtt_cluster_get(s : NetprotomqttCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_cluster_set(s : NetprotomqttCluster, i : Int, v : Double) -> NetprotomqttCluster {
  let result = net_proto_mqtt_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_mqtt_cluster_sum(s : NetprotomqttCluster) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_cluster_mean(s : NetprotomqttCluster) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_cluster_scale(s : NetprotomqttCluster, f : Double) -> NetprotomqttCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_cluster_add(a : NetprotomqttCluster, b : NetprotomqttCluster) -> NetprotomqttCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_cluster_copy(s : NetprotomqttCluster) -> NetprotomqttCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_cluster_fill(s : NetprotomqttCluster, v : Double) -> NetprotomqttCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_cluster_min(s : NetprotomqttCluster) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_cluster_max(s : NetprotomqttCluster) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_cluster_to_string(s : NetprotomqttCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_model_make(size : Int) -> NetprotomqttModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_model_len(s : NetprotomqttModel) -> Int { s.size }

pub fn net_proto_mqtt_model_get(s : NetprotomqttModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_model_set(s : NetprotomqttModel, i : Int, v : Double) -> NetprotomqttModel {
  let result = net_proto_mqtt_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_mqtt_model_sum(s : NetprotomqttModel) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_model_mean(s : NetprotomqttModel) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_model_scale(s : NetprotomqttModel, f : Double) -> NetprotomqttModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_model_add(a : NetprotomqttModel, b : NetprotomqttModel) -> NetprotomqttModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_model_copy(s : NetprotomqttModel) -> NetprotomqttModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_model_fill(s : NetprotomqttModel, v : Double) -> NetprotomqttModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_model_min(s : NetprotomqttModel) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_model_max(s : NetprotomqttModel) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_model_to_string(s : NetprotomqttModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_layer_make(size : Int) -> NetprotomqttLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_layer_len(s : NetprotomqttLayer) -> Int { s.size }

pub fn net_proto_mqtt_layer_get(s : NetprotomqttLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_layer_set(s : NetprotomqttLayer, i : Int, v : Double) -> NetprotomqttLayer {
  let result = net_proto_mqtt_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_mqtt_layer_sum(s : NetprotomqttLayer) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_layer_mean(s : NetprotomqttLayer) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_layer_scale(s : NetprotomqttLayer, f : Double) -> NetprotomqttLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_layer_add(a : NetprotomqttLayer, b : NetprotomqttLayer) -> NetprotomqttLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_layer_copy(s : NetprotomqttLayer) -> NetprotomqttLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_layer_fill(s : NetprotomqttLayer, v : Double) -> NetprotomqttLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_layer_min(s : NetprotomqttLayer) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_layer_max(s : NetprotomqttLayer) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_layer_to_string(s : NetprotomqttLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_buffer_make(size : Int) -> NetprotomqttBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_buffer_len(s : NetprotomqttBuffer) -> Int { s.size }

pub fn net_proto_mqtt_buffer_get(s : NetprotomqttBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_buffer_set(s : NetprotomqttBuffer, i : Int, v : Double) -> NetprotomqttBuffer {
  let result = net_proto_mqtt_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_mqtt_buffer_sum(s : NetprotomqttBuffer) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_buffer_mean(s : NetprotomqttBuffer) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_buffer_scale(s : NetprotomqttBuffer, f : Double) -> NetprotomqttBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_buffer_add(a : NetprotomqttBuffer, b : NetprotomqttBuffer) -> NetprotomqttBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_buffer_copy(s : NetprotomqttBuffer) -> NetprotomqttBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_buffer_fill(s : NetprotomqttBuffer, v : Double) -> NetprotomqttBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_buffer_min(s : NetprotomqttBuffer) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_buffer_max(s : NetprotomqttBuffer) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_buffer_to_string(s : NetprotomqttBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_cursor_make(size : Int) -> NetprotomqttCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_cursor_len(s : NetprotomqttCursor) -> Int { s.size }

pub fn net_proto_mqtt_cursor_get(s : NetprotomqttCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_cursor_set(s : NetprotomqttCursor, i : Int, v : Double) -> NetprotomqttCursor {
  let result = net_proto_mqtt_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_mqtt_cursor_sum(s : NetprotomqttCursor) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_cursor_mean(s : NetprotomqttCursor) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_cursor_scale(s : NetprotomqttCursor, f : Double) -> NetprotomqttCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_cursor_add(a : NetprotomqttCursor, b : NetprotomqttCursor) -> NetprotomqttCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_cursor_copy(s : NetprotomqttCursor) -> NetprotomqttCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_cursor_fill(s : NetprotomqttCursor, v : Double) -> NetprotomqttCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_cursor_min(s : NetprotomqttCursor) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_cursor_max(s : NetprotomqttCursor) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_cursor_to_string(s : NetprotomqttCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_view_make(size : Int) -> NetprotomqttView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_view_len(s : NetprotomqttView) -> Int { s.size }

pub fn net_proto_mqtt_view_get(s : NetprotomqttView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_view_set(s : NetprotomqttView, i : Int, v : Double) -> NetprotomqttView {
  let result = net_proto_mqtt_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_mqtt_view_sum(s : NetprotomqttView) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_view_mean(s : NetprotomqttView) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_view_scale(s : NetprotomqttView, f : Double) -> NetprotomqttView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_view_add(a : NetprotomqttView, b : NetprotomqttView) -> NetprotomqttView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_view_copy(s : NetprotomqttView) -> NetprotomqttView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_view_fill(s : NetprotomqttView, v : Double) -> NetprotomqttView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_view_min(s : NetprotomqttView) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_view_max(s : NetprotomqttView) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_view_to_string(s : NetprotomqttView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_range_make(size : Int) -> NetprotomqttRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_range_len(s : NetprotomqttRange) -> Int { s.size }

pub fn net_proto_mqtt_range_get(s : NetprotomqttRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_range_set(s : NetprotomqttRange, i : Int, v : Double) -> NetprotomqttRange {
  let result = net_proto_mqtt_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_mqtt_range_sum(s : NetprotomqttRange) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_range_mean(s : NetprotomqttRange) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_range_scale(s : NetprotomqttRange, f : Double) -> NetprotomqttRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_range_add(a : NetprotomqttRange, b : NetprotomqttRange) -> NetprotomqttRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_range_copy(s : NetprotomqttRange) -> NetprotomqttRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_range_fill(s : NetprotomqttRange, v : Double) -> NetprotomqttRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_range_min(s : NetprotomqttRange) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_range_max(s : NetprotomqttRange) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_range_to_string(s : NetprotomqttRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_slice_make(size : Int) -> NetprotomqttSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_slice_len(s : NetprotomqttSlice) -> Int { s.size }

pub fn net_proto_mqtt_slice_get(s : NetprotomqttSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_slice_set(s : NetprotomqttSlice, i : Int, v : Double) -> NetprotomqttSlice {
  let result = net_proto_mqtt_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_mqtt_slice_sum(s : NetprotomqttSlice) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_slice_mean(s : NetprotomqttSlice) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_slice_scale(s : NetprotomqttSlice, f : Double) -> NetprotomqttSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_slice_add(a : NetprotomqttSlice, b : NetprotomqttSlice) -> NetprotomqttSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_slice_copy(s : NetprotomqttSlice) -> NetprotomqttSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_slice_fill(s : NetprotomqttSlice, v : Double) -> NetprotomqttSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_slice_min(s : NetprotomqttSlice) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_slice_max(s : NetprotomqttSlice) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_slice_to_string(s : NetprotomqttSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

