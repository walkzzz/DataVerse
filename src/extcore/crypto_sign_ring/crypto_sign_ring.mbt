///===
/// extcore/crypto_sign_ring

pub(all) struct CryptosignringPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sign_ring_make_point(x : Double, y : Double) -> CryptosignringPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sign_ring_make_point3(x : Double, y : Double, z : Double) -> CryptosignringPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_sign_ring_point_x(pt : CryptosignringPoint) -> Double { pt.x }

pub fn crypto_sign_ring_point_y(pt : CryptosignringPoint) -> Double { pt.y }

pub fn crypto_sign_ring_point_z(pt : CryptosignringPoint) -> Double { pt.z }

pub fn crypto_sign_ring_point_label(pt : CryptosignringPoint) -> Int { pt.label }

pub fn crypto_sign_ring_point_dist(a : CryptosignringPoint, b : CryptosignringPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_sign_ring_point_add(a : CryptosignringPoint, b : CryptosignringPoint) -> CryptosignringPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_sign_ring_point_sub(a : CryptosignringPoint, b : CryptosignringPoint) -> CryptosignringPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_sign_ring_point_scale(pt : CryptosignringPoint, s : Double) -> CryptosignringPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_sign_ring_point_dot(a : CryptosignringPoint, b : CryptosignringPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_sign_ring_point_cross(a : CryptosignringPoint, b : CryptosignringPoint) -> CryptosignringPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_sign_ring_point_norm(pt : CryptosignringPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_sign_ring_point_normalize(pt : CryptosignringPoint) -> CryptosignringPoint {
  let n = crypto_sign_ring_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_sign_ring_point_scale(pt, 1.0 / n) }
}

pub fn crypto_sign_ring_point_negate(pt : CryptosignringPoint) -> CryptosignringPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_sign_ring_point_mid(a : CryptosignringPoint, b : CryptosignringPoint) -> CryptosignringPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_sign_ring_point_lerp(a : CryptosignringPoint, b : CryptosignringPoint, t : Double) -> CryptosignringPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_sign_ring_point_to_string(pt : CryptosignringPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptosignringSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sign_ring_make_series(vals : Array[Double], name : String) -> CryptosignringSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_sign_ring_series_len(s : CryptosignringSeries) -> Int { s.vals.length() }

pub fn crypto_sign_ring_series_sum(s : CryptosignringSeries) -> Double { @_common.sum(s.vals) }

pub fn crypto_sign_ring_series_mean(s : CryptosignringSeries) -> Double { @_common.mean(s.vals) }

pub fn crypto_sign_ring_series_min(s : CryptosignringSeries) -> Double { @_common.min(s.vals) }

pub fn crypto_sign_ring_series_max(s : CryptosignringSeries) -> Double { @_common.max(s.vals) }

pub fn crypto_sign_ring_series_range(s : CryptosignringSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_sign_ring_series_var(s : CryptosignringSeries) -> Double { @_common.variance(s.vals) }

pub fn crypto_sign_ring_series_std(s : CryptosignringSeries) -> Double { @_common.std(s.vals) }

pub fn crypto_sign_ring_series_median(s : CryptosignringSeries) -> Double { @_common.median(s.vals) }

pub fn crypto_sign_ring_series_scale(s : CryptosignringSeries, f : Double) -> CryptosignringSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn crypto_sign_ring_series_add(a : CryptosignringSeries, b : CryptosignringSeries) -> CryptosignringSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_sign_ring_series_sub(a : CryptosignringSeries, b : CryptosignringSeries) -> CryptosignringSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_sign_ring_series_normalize(s : CryptosignringSeries) -> CryptosignringSeries {
  let mn = crypto_sign_ring_series_min(s)
  let mx = crypto_sign_ring_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_sign_ring_series_cumsum(s : CryptosignringSeries) -> CryptosignringSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_sign_ring_series_to_string(s : CryptosignringSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosignringMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sign_ring_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosignringMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sign_ring_matrix_identity(n : Int) -> CryptosignringMatrix {
  let m = crypto_sign_ring_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_sign_ring_matrix_get(m : CryptosignringMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_sign_ring_matrix_transpose(m : CryptosignringMatrix) -> CryptosignringMatrix {
  let result = crypto_sign_ring_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_sign_ring_matrix_add(a : CryptosignringMatrix, b : CryptosignringMatrix) -> CryptosignringMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_sign_ring_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_sign_ring_matrix_scale(m : CryptosignringMatrix, s : Double) -> CryptosignringMatrix {
  let result = crypto_sign_ring_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_sign_ring_matrix_multiply(a : CryptosignringMatrix, b : CryptosignringMatrix) -> CryptosignringMatrix {
  if a.cols != b.rows { return crypto_sign_ring_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_sign_ring_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_sign_ring_matrix_trace(m : CryptosignringMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_sign_ring_matrix_det(m : CryptosignringMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_sign_ring_matrix_norm(m : CryptosignringMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_sign_ring_matrix_to_string(m : CryptosignringMatrix) -> String {
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

pub(all) struct CryptosignringVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sign_ring_make_vector(comps : Array[Double]) -> CryptosignringVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sign_ring_vector_zero(dim : Int) -> CryptosignringVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_sign_ring_vector_add(a : CryptosignringVector, b : CryptosignringVector) -> CryptosignringVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn crypto_sign_ring_vector_sub(a : CryptosignringVector, b : CryptosignringVector) -> CryptosignringVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn crypto_sign_ring_vector_scale(v : CryptosignringVector, s : Double) -> CryptosignringVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn crypto_sign_ring_vector_dot(a : CryptosignringVector, b : CryptosignringVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_sign_ring_vector_norm(v : CryptosignringVector) -> Double { @_common.sqrt(crypto_sign_ring_vector_dot(v, v)) }

pub fn crypto_sign_ring_vector_normalize(v : CryptosignringVector) -> CryptosignringVector {
  let n = crypto_sign_ring_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_sign_ring_vector_scale(v, 1.0 / n) }
}

pub fn crypto_sign_ring_vector_dist(a : CryptosignringVector, b : CryptosignringVector) -> Double {
  crypto_sign_ring_vector_norm(crypto_sign_ring_vector_sub(a, b))
}

pub fn crypto_sign_ring_vector_to_string(v : CryptosignringVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sign_ring_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sign_ring_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sign_ring_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sign_ring_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sign_ring_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sign_ring_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sign_ring_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sign_ring_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sign_ring_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sign_ring_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sign_ring_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sign_ring_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sign_ring_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sign_ring_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sign_ring_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sign_ring_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sign_ring_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sign_ring_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sign_ring_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sign_ring_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sign_ring_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sign_ring_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sign_ring_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sign_ring_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sign_ring_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sign_ring_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sign_ring_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sign_ring_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sign_ring_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosignringFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_frame_make(size : Int) -> CryptosignringFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_frame_len(s : CryptosignringFrame) -> Int { s.size }

pub fn crypto_sign_ring_frame_get(s : CryptosignringFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_frame_set(s : CryptosignringFrame, i : Int, v : Double) -> CryptosignringFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_frame_sum(s : CryptosignringFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ring_frame_mean(s : CryptosignringFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ring_frame_scale(s : CryptosignringFrame, f : Double) -> CryptosignringFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_frame_add(a : CryptosignringFrame, b : CryptosignringFrame) -> CryptosignringFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ring_frame_copy(s : CryptosignringFrame) -> CryptosignringFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_frame_fill(s : CryptosignringFrame, v : Double) -> CryptosignringFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_frame_min(s : CryptosignringFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ring_frame_max(s : CryptosignringFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ring_frame_to_string(s : CryptosignringFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_table_make(size : Int) -> CryptosignringTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_table_len(s : CryptosignringTable) -> Int { s.size }

pub fn crypto_sign_ring_table_get(s : CryptosignringTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_table_set(s : CryptosignringTable, i : Int, v : Double) -> CryptosignringTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_table_sum(s : CryptosignringTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ring_table_mean(s : CryptosignringTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ring_table_scale(s : CryptosignringTable, f : Double) -> CryptosignringTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_table_add(a : CryptosignringTable, b : CryptosignringTable) -> CryptosignringTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ring_table_copy(s : CryptosignringTable) -> CryptosignringTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_table_fill(s : CryptosignringTable, v : Double) -> CryptosignringTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_table_min(s : CryptosignringTable) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ring_table_max(s : CryptosignringTable) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ring_table_to_string(s : CryptosignringTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_graphn_make(size : Int) -> CryptosignringGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_graphn_len(s : CryptosignringGraphN) -> Int { s.size }

pub fn crypto_sign_ring_graphn_get(s : CryptosignringGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_graphn_set(s : CryptosignringGraphN, i : Int, v : Double) -> CryptosignringGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_graphn_sum(s : CryptosignringGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ring_graphn_mean(s : CryptosignringGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ring_graphn_scale(s : CryptosignringGraphN, f : Double) -> CryptosignringGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_graphn_add(a : CryptosignringGraphN, b : CryptosignringGraphN) -> CryptosignringGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ring_graphn_copy(s : CryptosignringGraphN) -> CryptosignringGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_graphn_fill(s : CryptosignringGraphN, v : Double) -> CryptosignringGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_graphn_min(s : CryptosignringGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ring_graphn_max(s : CryptosignringGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ring_graphn_to_string(s : CryptosignringGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_node_make(size : Int) -> CryptosignringNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_node_len(s : CryptosignringNode) -> Int { s.size }

pub fn crypto_sign_ring_node_get(s : CryptosignringNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_node_set(s : CryptosignringNode, i : Int, v : Double) -> CryptosignringNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_node_sum(s : CryptosignringNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ring_node_mean(s : CryptosignringNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ring_node_scale(s : CryptosignringNode, f : Double) -> CryptosignringNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_node_add(a : CryptosignringNode, b : CryptosignringNode) -> CryptosignringNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ring_node_copy(s : CryptosignringNode) -> CryptosignringNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_node_fill(s : CryptosignringNode, v : Double) -> CryptosignringNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_node_min(s : CryptosignringNode) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ring_node_max(s : CryptosignringNode) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ring_node_to_string(s : CryptosignringNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_edge_make(size : Int) -> CryptosignringEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_edge_len(s : CryptosignringEdge) -> Int { s.size }

pub fn crypto_sign_ring_edge_get(s : CryptosignringEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_edge_set(s : CryptosignringEdge, i : Int, v : Double) -> CryptosignringEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_edge_sum(s : CryptosignringEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ring_edge_mean(s : CryptosignringEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ring_edge_scale(s : CryptosignringEdge, f : Double) -> CryptosignringEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_edge_add(a : CryptosignringEdge, b : CryptosignringEdge) -> CryptosignringEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ring_edge_copy(s : CryptosignringEdge) -> CryptosignringEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_edge_fill(s : CryptosignringEdge, v : Double) -> CryptosignringEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_edge_min(s : CryptosignringEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ring_edge_max(s : CryptosignringEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ring_edge_to_string(s : CryptosignringEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_path_make(size : Int) -> CryptosignringPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_path_len(s : CryptosignringPath) -> Int { s.size }

pub fn crypto_sign_ring_path_get(s : CryptosignringPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_path_set(s : CryptosignringPath, i : Int, v : Double) -> CryptosignringPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_path_sum(s : CryptosignringPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ring_path_mean(s : CryptosignringPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ring_path_scale(s : CryptosignringPath, f : Double) -> CryptosignringPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_path_add(a : CryptosignringPath, b : CryptosignringPath) -> CryptosignringPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ring_path_copy(s : CryptosignringPath) -> CryptosignringPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_path_fill(s : CryptosignringPath, v : Double) -> CryptosignringPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_path_min(s : CryptosignringPath) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ring_path_max(s : CryptosignringPath) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ring_path_to_string(s : CryptosignringPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_cluster_make(size : Int) -> CryptosignringCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_cluster_len(s : CryptosignringCluster) -> Int { s.size }

pub fn crypto_sign_ring_cluster_get(s : CryptosignringCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_cluster_set(s : CryptosignringCluster, i : Int, v : Double) -> CryptosignringCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_cluster_sum(s : CryptosignringCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ring_cluster_mean(s : CryptosignringCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ring_cluster_scale(s : CryptosignringCluster, f : Double) -> CryptosignringCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_cluster_add(a : CryptosignringCluster, b : CryptosignringCluster) -> CryptosignringCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ring_cluster_copy(s : CryptosignringCluster) -> CryptosignringCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_cluster_fill(s : CryptosignringCluster, v : Double) -> CryptosignringCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_cluster_min(s : CryptosignringCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ring_cluster_max(s : CryptosignringCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ring_cluster_to_string(s : CryptosignringCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_model_make(size : Int) -> CryptosignringModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_model_len(s : CryptosignringModel) -> Int { s.size }

pub fn crypto_sign_ring_model_get(s : CryptosignringModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_model_set(s : CryptosignringModel, i : Int, v : Double) -> CryptosignringModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_model_sum(s : CryptosignringModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ring_model_mean(s : CryptosignringModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ring_model_scale(s : CryptosignringModel, f : Double) -> CryptosignringModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_model_add(a : CryptosignringModel, b : CryptosignringModel) -> CryptosignringModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ring_model_copy(s : CryptosignringModel) -> CryptosignringModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_model_fill(s : CryptosignringModel, v : Double) -> CryptosignringModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_model_min(s : CryptosignringModel) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ring_model_max(s : CryptosignringModel) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ring_model_to_string(s : CryptosignringModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_layer_make(size : Int) -> CryptosignringLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_layer_len(s : CryptosignringLayer) -> Int { s.size }

pub fn crypto_sign_ring_layer_get(s : CryptosignringLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_layer_set(s : CryptosignringLayer, i : Int, v : Double) -> CryptosignringLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_layer_sum(s : CryptosignringLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ring_layer_mean(s : CryptosignringLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ring_layer_scale(s : CryptosignringLayer, f : Double) -> CryptosignringLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_layer_add(a : CryptosignringLayer, b : CryptosignringLayer) -> CryptosignringLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ring_layer_copy(s : CryptosignringLayer) -> CryptosignringLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_layer_fill(s : CryptosignringLayer, v : Double) -> CryptosignringLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_layer_min(s : CryptosignringLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ring_layer_max(s : CryptosignringLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ring_layer_to_string(s : CryptosignringLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_buffer_make(size : Int) -> CryptosignringBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_buffer_len(s : CryptosignringBuffer) -> Int { s.size }

pub fn crypto_sign_ring_buffer_get(s : CryptosignringBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_buffer_set(s : CryptosignringBuffer, i : Int, v : Double) -> CryptosignringBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_buffer_sum(s : CryptosignringBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ring_buffer_mean(s : CryptosignringBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ring_buffer_scale(s : CryptosignringBuffer, f : Double) -> CryptosignringBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_buffer_add(a : CryptosignringBuffer, b : CryptosignringBuffer) -> CryptosignringBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ring_buffer_copy(s : CryptosignringBuffer) -> CryptosignringBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_buffer_fill(s : CryptosignringBuffer, v : Double) -> CryptosignringBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_buffer_min(s : CryptosignringBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ring_buffer_max(s : CryptosignringBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ring_buffer_to_string(s : CryptosignringBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_cursor_make(size : Int) -> CryptosignringCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_cursor_len(s : CryptosignringCursor) -> Int { s.size }

pub fn crypto_sign_ring_cursor_get(s : CryptosignringCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_cursor_set(s : CryptosignringCursor, i : Int, v : Double) -> CryptosignringCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_cursor_sum(s : CryptosignringCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ring_cursor_mean(s : CryptosignringCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ring_cursor_scale(s : CryptosignringCursor, f : Double) -> CryptosignringCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_cursor_add(a : CryptosignringCursor, b : CryptosignringCursor) -> CryptosignringCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ring_cursor_copy(s : CryptosignringCursor) -> CryptosignringCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_cursor_fill(s : CryptosignringCursor, v : Double) -> CryptosignringCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_cursor_min(s : CryptosignringCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ring_cursor_max(s : CryptosignringCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ring_cursor_to_string(s : CryptosignringCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_view_make(size : Int) -> CryptosignringView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_view_len(s : CryptosignringView) -> Int { s.size }

pub fn crypto_sign_ring_view_get(s : CryptosignringView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_view_set(s : CryptosignringView, i : Int, v : Double) -> CryptosignringView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_view_sum(s : CryptosignringView) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ring_view_mean(s : CryptosignringView) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ring_view_scale(s : CryptosignringView, f : Double) -> CryptosignringView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_view_add(a : CryptosignringView, b : CryptosignringView) -> CryptosignringView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ring_view_copy(s : CryptosignringView) -> CryptosignringView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_view_fill(s : CryptosignringView, v : Double) -> CryptosignringView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_view_min(s : CryptosignringView) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ring_view_max(s : CryptosignringView) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ring_view_to_string(s : CryptosignringView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_range_make(size : Int) -> CryptosignringRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_range_len(s : CryptosignringRange) -> Int { s.size }

pub fn crypto_sign_ring_range_get(s : CryptosignringRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_range_set(s : CryptosignringRange, i : Int, v : Double) -> CryptosignringRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_range_sum(s : CryptosignringRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ring_range_mean(s : CryptosignringRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ring_range_scale(s : CryptosignringRange, f : Double) -> CryptosignringRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_range_add(a : CryptosignringRange, b : CryptosignringRange) -> CryptosignringRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ring_range_copy(s : CryptosignringRange) -> CryptosignringRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_range_fill(s : CryptosignringRange, v : Double) -> CryptosignringRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_range_min(s : CryptosignringRange) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ring_range_max(s : CryptosignringRange) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ring_range_to_string(s : CryptosignringRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_slice_make(size : Int) -> CryptosignringSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_slice_len(s : CryptosignringSlice) -> Int { s.size }

pub fn crypto_sign_ring_slice_get(s : CryptosignringSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_slice_set(s : CryptosignringSlice, i : Int, v : Double) -> CryptosignringSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_slice_sum(s : CryptosignringSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_ring_slice_mean(s : CryptosignringSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_ring_slice_scale(s : CryptosignringSlice, f : Double) -> CryptosignringSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_slice_add(a : CryptosignringSlice, b : CryptosignringSlice) -> CryptosignringSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_ring_slice_copy(s : CryptosignringSlice) -> CryptosignringSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_slice_fill(s : CryptosignringSlice, v : Double) -> CryptosignringSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_ring_slice_min(s : CryptosignringSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sign_ring_slice_max(s : CryptosignringSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sign_ring_slice_to_string(s : CryptosignringSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

