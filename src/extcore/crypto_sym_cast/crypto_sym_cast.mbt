///===
/// extcore/crypto_sym_cast

pub(all) struct CryptosymcastPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_cast_make_point(x : Double, y : Double) -> CryptosymcastPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_cast_make_point3(x : Double, y : Double, z : Double) -> CryptosymcastPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_sym_cast_point_x(pt : CryptosymcastPoint) -> Double { pt.x }

pub fn crypto_sym_cast_point_y(pt : CryptosymcastPoint) -> Double { pt.y }

pub fn crypto_sym_cast_point_z(pt : CryptosymcastPoint) -> Double { pt.z }

pub fn crypto_sym_cast_point_label(pt : CryptosymcastPoint) -> Int { pt.label }

pub fn crypto_sym_cast_point_dist(a : CryptosymcastPoint, b : CryptosymcastPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_sym_cast_point_add(a : CryptosymcastPoint, b : CryptosymcastPoint) -> CryptosymcastPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_sym_cast_point_sub(a : CryptosymcastPoint, b : CryptosymcastPoint) -> CryptosymcastPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_sym_cast_point_scale(pt : CryptosymcastPoint, s : Double) -> CryptosymcastPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_sym_cast_point_dot(a : CryptosymcastPoint, b : CryptosymcastPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_sym_cast_point_cross(a : CryptosymcastPoint, b : CryptosymcastPoint) -> CryptosymcastPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_sym_cast_point_norm(pt : CryptosymcastPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_sym_cast_point_normalize(pt : CryptosymcastPoint) -> CryptosymcastPoint {
  let n = crypto_sym_cast_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_sym_cast_point_scale(pt, 1.0 / n) }
}

pub fn crypto_sym_cast_point_negate(pt : CryptosymcastPoint) -> CryptosymcastPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_sym_cast_point_mid(a : CryptosymcastPoint, b : CryptosymcastPoint) -> CryptosymcastPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_sym_cast_point_lerp(a : CryptosymcastPoint, b : CryptosymcastPoint, t : Double) -> CryptosymcastPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_sym_cast_point_to_string(pt : CryptosymcastPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptosymcastSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_cast_make_series(vals : Array[Double], name : String) -> CryptosymcastSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_sym_cast_series_len(s : CryptosymcastSeries) -> Int { s.vals.length() }

pub fn crypto_sym_cast_series_sum(s : CryptosymcastSeries) -> Double { @_common.sum(s.vals) }

pub fn crypto_sym_cast_series_mean(s : CryptosymcastSeries) -> Double { @_common.mean(s.vals) }

pub fn crypto_sym_cast_series_min(s : CryptosymcastSeries) -> Double { @_common.min(s.vals) }

pub fn crypto_sym_cast_series_max(s : CryptosymcastSeries) -> Double { @_common.max(s.vals) }

pub fn crypto_sym_cast_series_range(s : CryptosymcastSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_sym_cast_series_var(s : CryptosymcastSeries) -> Double { @_common.variance(s.vals) }

pub fn crypto_sym_cast_series_std(s : CryptosymcastSeries) -> Double { @_common.std(s.vals) }

pub fn crypto_sym_cast_series_median(s : CryptosymcastSeries) -> Double { @_common.median(s.vals) }

pub fn crypto_sym_cast_series_scale(s : CryptosymcastSeries, f : Double) -> CryptosymcastSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn crypto_sym_cast_series_add(a : CryptosymcastSeries, b : CryptosymcastSeries) -> CryptosymcastSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_sym_cast_series_sub(a : CryptosymcastSeries, b : CryptosymcastSeries) -> CryptosymcastSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_sym_cast_series_normalize(s : CryptosymcastSeries) -> CryptosymcastSeries {
  let mn = crypto_sym_cast_series_min(s)
  let mx = crypto_sym_cast_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_sym_cast_series_cumsum(s : CryptosymcastSeries) -> CryptosymcastSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_sym_cast_series_to_string(s : CryptosymcastSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymcastMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_cast_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymcastMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_cast_matrix_identity(n : Int) -> CryptosymcastMatrix {
  let m = crypto_sym_cast_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_sym_cast_matrix_get(m : CryptosymcastMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_sym_cast_matrix_transpose(m : CryptosymcastMatrix) -> CryptosymcastMatrix {
  let result = crypto_sym_cast_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_sym_cast_matrix_add(a : CryptosymcastMatrix, b : CryptosymcastMatrix) -> CryptosymcastMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_sym_cast_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_sym_cast_matrix_scale(m : CryptosymcastMatrix, s : Double) -> CryptosymcastMatrix {
  let result = crypto_sym_cast_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_sym_cast_matrix_multiply(a : CryptosymcastMatrix, b : CryptosymcastMatrix) -> CryptosymcastMatrix {
  if a.cols != b.rows { return crypto_sym_cast_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_sym_cast_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_sym_cast_matrix_trace(m : CryptosymcastMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_sym_cast_matrix_det(m : CryptosymcastMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_sym_cast_matrix_norm(m : CryptosymcastMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_sym_cast_matrix_to_string(m : CryptosymcastMatrix) -> String {
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

pub(all) struct CryptosymcastVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_cast_make_vector(comps : Array[Double]) -> CryptosymcastVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_cast_vector_zero(dim : Int) -> CryptosymcastVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_sym_cast_vector_add(a : CryptosymcastVector, b : CryptosymcastVector) -> CryptosymcastVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn crypto_sym_cast_vector_sub(a : CryptosymcastVector, b : CryptosymcastVector) -> CryptosymcastVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn crypto_sym_cast_vector_scale(v : CryptosymcastVector, s : Double) -> CryptosymcastVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn crypto_sym_cast_vector_dot(a : CryptosymcastVector, b : CryptosymcastVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_sym_cast_vector_norm(v : CryptosymcastVector) -> Double { @_common.sqrt(crypto_sym_cast_vector_dot(v, v)) }

pub fn crypto_sym_cast_vector_normalize(v : CryptosymcastVector) -> CryptosymcastVector {
  let n = crypto_sym_cast_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_sym_cast_vector_scale(v, 1.0 / n) }
}

pub fn crypto_sym_cast_vector_dist(a : CryptosymcastVector, b : CryptosymcastVector) -> Double {
  crypto_sym_cast_vector_norm(crypto_sym_cast_vector_sub(a, b))
}

pub fn crypto_sym_cast_vector_to_string(v : CryptosymcastVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sym_cast_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sym_cast_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sym_cast_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sym_cast_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sym_cast_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sym_cast_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sym_cast_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sym_cast_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sym_cast_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sym_cast_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sym_cast_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sym_cast_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sym_cast_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sym_cast_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sym_cast_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sym_cast_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sym_cast_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sym_cast_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sym_cast_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sym_cast_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sym_cast_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sym_cast_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sym_cast_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sym_cast_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sym_cast_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sym_cast_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sym_cast_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sym_cast_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sym_cast_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosymcastFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_frame_make(size : Int) -> CryptosymcastFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_frame_len(s : CryptosymcastFrame) -> Int { s.size }

pub fn crypto_sym_cast_frame_get(s : CryptosymcastFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_frame_set(s : CryptosymcastFrame, i : Int, v : Double) -> CryptosymcastFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_frame_sum(s : CryptosymcastFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_frame_mean(s : CryptosymcastFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_frame_scale(s : CryptosymcastFrame, f : Double) -> CryptosymcastFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_frame_add(a : CryptosymcastFrame, b : CryptosymcastFrame) -> CryptosymcastFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_frame_copy(s : CryptosymcastFrame) -> CryptosymcastFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_frame_fill(s : CryptosymcastFrame, v : Double) -> CryptosymcastFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_frame_min(s : CryptosymcastFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_frame_max(s : CryptosymcastFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_frame_to_string(s : CryptosymcastFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_table_make(size : Int) -> CryptosymcastTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_table_len(s : CryptosymcastTable) -> Int { s.size }

pub fn crypto_sym_cast_table_get(s : CryptosymcastTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_table_set(s : CryptosymcastTable, i : Int, v : Double) -> CryptosymcastTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_table_sum(s : CryptosymcastTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_table_mean(s : CryptosymcastTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_table_scale(s : CryptosymcastTable, f : Double) -> CryptosymcastTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_table_add(a : CryptosymcastTable, b : CryptosymcastTable) -> CryptosymcastTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_table_copy(s : CryptosymcastTable) -> CryptosymcastTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_table_fill(s : CryptosymcastTable, v : Double) -> CryptosymcastTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_table_min(s : CryptosymcastTable) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_table_max(s : CryptosymcastTable) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_table_to_string(s : CryptosymcastTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_graphn_make(size : Int) -> CryptosymcastGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_graphn_len(s : CryptosymcastGraphN) -> Int { s.size }

pub fn crypto_sym_cast_graphn_get(s : CryptosymcastGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_graphn_set(s : CryptosymcastGraphN, i : Int, v : Double) -> CryptosymcastGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_graphn_sum(s : CryptosymcastGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_graphn_mean(s : CryptosymcastGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_graphn_scale(s : CryptosymcastGraphN, f : Double) -> CryptosymcastGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_graphn_add(a : CryptosymcastGraphN, b : CryptosymcastGraphN) -> CryptosymcastGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_graphn_copy(s : CryptosymcastGraphN) -> CryptosymcastGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_graphn_fill(s : CryptosymcastGraphN, v : Double) -> CryptosymcastGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_graphn_min(s : CryptosymcastGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_graphn_max(s : CryptosymcastGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_graphn_to_string(s : CryptosymcastGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_node_make(size : Int) -> CryptosymcastNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_node_len(s : CryptosymcastNode) -> Int { s.size }

pub fn crypto_sym_cast_node_get(s : CryptosymcastNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_node_set(s : CryptosymcastNode, i : Int, v : Double) -> CryptosymcastNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_node_sum(s : CryptosymcastNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_node_mean(s : CryptosymcastNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_node_scale(s : CryptosymcastNode, f : Double) -> CryptosymcastNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_node_add(a : CryptosymcastNode, b : CryptosymcastNode) -> CryptosymcastNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_node_copy(s : CryptosymcastNode) -> CryptosymcastNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_node_fill(s : CryptosymcastNode, v : Double) -> CryptosymcastNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_node_min(s : CryptosymcastNode) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_node_max(s : CryptosymcastNode) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_node_to_string(s : CryptosymcastNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_edge_make(size : Int) -> CryptosymcastEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_edge_len(s : CryptosymcastEdge) -> Int { s.size }

pub fn crypto_sym_cast_edge_get(s : CryptosymcastEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_edge_set(s : CryptosymcastEdge, i : Int, v : Double) -> CryptosymcastEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_edge_sum(s : CryptosymcastEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_edge_mean(s : CryptosymcastEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_edge_scale(s : CryptosymcastEdge, f : Double) -> CryptosymcastEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_edge_add(a : CryptosymcastEdge, b : CryptosymcastEdge) -> CryptosymcastEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_edge_copy(s : CryptosymcastEdge) -> CryptosymcastEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_edge_fill(s : CryptosymcastEdge, v : Double) -> CryptosymcastEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_edge_min(s : CryptosymcastEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_edge_max(s : CryptosymcastEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_edge_to_string(s : CryptosymcastEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_path_make(size : Int) -> CryptosymcastPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_path_len(s : CryptosymcastPath) -> Int { s.size }

pub fn crypto_sym_cast_path_get(s : CryptosymcastPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_path_set(s : CryptosymcastPath, i : Int, v : Double) -> CryptosymcastPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_path_sum(s : CryptosymcastPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_path_mean(s : CryptosymcastPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_path_scale(s : CryptosymcastPath, f : Double) -> CryptosymcastPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_path_add(a : CryptosymcastPath, b : CryptosymcastPath) -> CryptosymcastPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_path_copy(s : CryptosymcastPath) -> CryptosymcastPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_path_fill(s : CryptosymcastPath, v : Double) -> CryptosymcastPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_path_min(s : CryptosymcastPath) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_path_max(s : CryptosymcastPath) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_path_to_string(s : CryptosymcastPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_cluster_make(size : Int) -> CryptosymcastCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_cluster_len(s : CryptosymcastCluster) -> Int { s.size }

pub fn crypto_sym_cast_cluster_get(s : CryptosymcastCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_cluster_set(s : CryptosymcastCluster, i : Int, v : Double) -> CryptosymcastCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_cluster_sum(s : CryptosymcastCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_cluster_mean(s : CryptosymcastCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_cluster_scale(s : CryptosymcastCluster, f : Double) -> CryptosymcastCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_cluster_add(a : CryptosymcastCluster, b : CryptosymcastCluster) -> CryptosymcastCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_cluster_copy(s : CryptosymcastCluster) -> CryptosymcastCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_cluster_fill(s : CryptosymcastCluster, v : Double) -> CryptosymcastCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_cluster_min(s : CryptosymcastCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_cluster_max(s : CryptosymcastCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_cluster_to_string(s : CryptosymcastCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_model_make(size : Int) -> CryptosymcastModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_model_len(s : CryptosymcastModel) -> Int { s.size }

pub fn crypto_sym_cast_model_get(s : CryptosymcastModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_model_set(s : CryptosymcastModel, i : Int, v : Double) -> CryptosymcastModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_model_sum(s : CryptosymcastModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_model_mean(s : CryptosymcastModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_model_scale(s : CryptosymcastModel, f : Double) -> CryptosymcastModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_model_add(a : CryptosymcastModel, b : CryptosymcastModel) -> CryptosymcastModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_model_copy(s : CryptosymcastModel) -> CryptosymcastModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_model_fill(s : CryptosymcastModel, v : Double) -> CryptosymcastModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_model_min(s : CryptosymcastModel) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_model_max(s : CryptosymcastModel) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_model_to_string(s : CryptosymcastModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_layer_make(size : Int) -> CryptosymcastLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_layer_len(s : CryptosymcastLayer) -> Int { s.size }

pub fn crypto_sym_cast_layer_get(s : CryptosymcastLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_layer_set(s : CryptosymcastLayer, i : Int, v : Double) -> CryptosymcastLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_layer_sum(s : CryptosymcastLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_layer_mean(s : CryptosymcastLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_layer_scale(s : CryptosymcastLayer, f : Double) -> CryptosymcastLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_layer_add(a : CryptosymcastLayer, b : CryptosymcastLayer) -> CryptosymcastLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_layer_copy(s : CryptosymcastLayer) -> CryptosymcastLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_layer_fill(s : CryptosymcastLayer, v : Double) -> CryptosymcastLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_layer_min(s : CryptosymcastLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_layer_max(s : CryptosymcastLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_layer_to_string(s : CryptosymcastLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_buffer_make(size : Int) -> CryptosymcastBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_buffer_len(s : CryptosymcastBuffer) -> Int { s.size }

pub fn crypto_sym_cast_buffer_get(s : CryptosymcastBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_buffer_set(s : CryptosymcastBuffer, i : Int, v : Double) -> CryptosymcastBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_buffer_sum(s : CryptosymcastBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_buffer_mean(s : CryptosymcastBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_buffer_scale(s : CryptosymcastBuffer, f : Double) -> CryptosymcastBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_buffer_add(a : CryptosymcastBuffer, b : CryptosymcastBuffer) -> CryptosymcastBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_buffer_copy(s : CryptosymcastBuffer) -> CryptosymcastBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_buffer_fill(s : CryptosymcastBuffer, v : Double) -> CryptosymcastBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_buffer_min(s : CryptosymcastBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_buffer_max(s : CryptosymcastBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_buffer_to_string(s : CryptosymcastBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_cursor_make(size : Int) -> CryptosymcastCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_cursor_len(s : CryptosymcastCursor) -> Int { s.size }

pub fn crypto_sym_cast_cursor_get(s : CryptosymcastCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_cursor_set(s : CryptosymcastCursor, i : Int, v : Double) -> CryptosymcastCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_cursor_sum(s : CryptosymcastCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_cursor_mean(s : CryptosymcastCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_cursor_scale(s : CryptosymcastCursor, f : Double) -> CryptosymcastCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_cursor_add(a : CryptosymcastCursor, b : CryptosymcastCursor) -> CryptosymcastCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_cursor_copy(s : CryptosymcastCursor) -> CryptosymcastCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_cursor_fill(s : CryptosymcastCursor, v : Double) -> CryptosymcastCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_cursor_min(s : CryptosymcastCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_cursor_max(s : CryptosymcastCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_cursor_to_string(s : CryptosymcastCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_view_make(size : Int) -> CryptosymcastView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_view_len(s : CryptosymcastView) -> Int { s.size }

pub fn crypto_sym_cast_view_get(s : CryptosymcastView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_view_set(s : CryptosymcastView, i : Int, v : Double) -> CryptosymcastView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_view_sum(s : CryptosymcastView) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_view_mean(s : CryptosymcastView) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_view_scale(s : CryptosymcastView, f : Double) -> CryptosymcastView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_view_add(a : CryptosymcastView, b : CryptosymcastView) -> CryptosymcastView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_view_copy(s : CryptosymcastView) -> CryptosymcastView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_view_fill(s : CryptosymcastView, v : Double) -> CryptosymcastView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_view_min(s : CryptosymcastView) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_view_max(s : CryptosymcastView) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_view_to_string(s : CryptosymcastView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_range_make(size : Int) -> CryptosymcastRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_range_len(s : CryptosymcastRange) -> Int { s.size }

pub fn crypto_sym_cast_range_get(s : CryptosymcastRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_range_set(s : CryptosymcastRange, i : Int, v : Double) -> CryptosymcastRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_range_sum(s : CryptosymcastRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_range_mean(s : CryptosymcastRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_range_scale(s : CryptosymcastRange, f : Double) -> CryptosymcastRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_range_add(a : CryptosymcastRange, b : CryptosymcastRange) -> CryptosymcastRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_range_copy(s : CryptosymcastRange) -> CryptosymcastRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_range_fill(s : CryptosymcastRange, v : Double) -> CryptosymcastRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_range_min(s : CryptosymcastRange) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_range_max(s : CryptosymcastRange) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_range_to_string(s : CryptosymcastRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_slice_make(size : Int) -> CryptosymcastSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_slice_len(s : CryptosymcastSlice) -> Int { s.size }

pub fn crypto_sym_cast_slice_get(s : CryptosymcastSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_slice_set(s : CryptosymcastSlice, i : Int, v : Double) -> CryptosymcastSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_slice_sum(s : CryptosymcastSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_slice_mean(s : CryptosymcastSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_slice_scale(s : CryptosymcastSlice, f : Double) -> CryptosymcastSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_slice_add(a : CryptosymcastSlice, b : CryptosymcastSlice) -> CryptosymcastSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_slice_copy(s : CryptosymcastSlice) -> CryptosymcastSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_slice_fill(s : CryptosymcastSlice, v : Double) -> CryptosymcastSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_slice_min(s : CryptosymcastSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_slice_max(s : CryptosymcastSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_slice_to_string(s : CryptosymcastSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

