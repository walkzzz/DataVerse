///===
/// extcore/crypto_asym_rsa

pub(all) struct CryptoasymrsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_rsa_make_point(x : Double, y : Double) -> CryptoasymrsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_rsa_make_point3(x : Double, y : Double, z : Double) -> CryptoasymrsaPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_asym_rsa_point_x(pt : CryptoasymrsaPoint) -> Double { pt.x }

pub fn crypto_asym_rsa_point_y(pt : CryptoasymrsaPoint) -> Double { pt.y }

pub fn crypto_asym_rsa_point_z(pt : CryptoasymrsaPoint) -> Double { pt.z }

pub fn crypto_asym_rsa_point_label(pt : CryptoasymrsaPoint) -> Int { pt.label }

pub fn crypto_asym_rsa_point_dist(a : CryptoasymrsaPoint, b : CryptoasymrsaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_asym_rsa_point_add(a : CryptoasymrsaPoint, b : CryptoasymrsaPoint) -> CryptoasymrsaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_asym_rsa_point_sub(a : CryptoasymrsaPoint, b : CryptoasymrsaPoint) -> CryptoasymrsaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_asym_rsa_point_scale(pt : CryptoasymrsaPoint, s : Double) -> CryptoasymrsaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_asym_rsa_point_dot(a : CryptoasymrsaPoint, b : CryptoasymrsaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_asym_rsa_point_cross(a : CryptoasymrsaPoint, b : CryptoasymrsaPoint) -> CryptoasymrsaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_asym_rsa_point_norm(pt : CryptoasymrsaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_asym_rsa_point_normalize(pt : CryptoasymrsaPoint) -> CryptoasymrsaPoint {
  let n = crypto_asym_rsa_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_asym_rsa_point_scale(pt, 1.0 / n) }
}

pub fn crypto_asym_rsa_point_negate(pt : CryptoasymrsaPoint) -> CryptoasymrsaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_asym_rsa_point_mid(a : CryptoasymrsaPoint, b : CryptoasymrsaPoint) -> CryptoasymrsaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_asym_rsa_point_lerp(a : CryptoasymrsaPoint, b : CryptoasymrsaPoint, t : Double) -> CryptoasymrsaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_asym_rsa_point_to_string(pt : CryptoasymrsaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptoasymrsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_rsa_make_series(vals : Array[Double], name : String) -> CryptoasymrsaSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_asym_rsa_series_len(s : CryptoasymrsaSeries) -> Int { s.vals.length() }

pub fn crypto_asym_rsa_series_sum(s : CryptoasymrsaSeries) -> Double { @_common.sum(s.vals) }

pub fn crypto_asym_rsa_series_mean(s : CryptoasymrsaSeries) -> Double { @_common.mean(s.vals) }

pub fn crypto_asym_rsa_series_min(s : CryptoasymrsaSeries) -> Double { @_common.min(s.vals) }

pub fn crypto_asym_rsa_series_max(s : CryptoasymrsaSeries) -> Double { @_common.max(s.vals) }

pub fn crypto_asym_rsa_series_range(s : CryptoasymrsaSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_asym_rsa_series_var(s : CryptoasymrsaSeries) -> Double { @_common.variance(s.vals) }

pub fn crypto_asym_rsa_series_std(s : CryptoasymrsaSeries) -> Double { @_common.std(s.vals) }

pub fn crypto_asym_rsa_series_median(s : CryptoasymrsaSeries) -> Double { @_common.median(s.vals) }

pub fn crypto_asym_rsa_series_scale(s : CryptoasymrsaSeries, f : Double) -> CryptoasymrsaSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn crypto_asym_rsa_series_add(a : CryptoasymrsaSeries, b : CryptoasymrsaSeries) -> CryptoasymrsaSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_asym_rsa_series_sub(a : CryptoasymrsaSeries, b : CryptoasymrsaSeries) -> CryptoasymrsaSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_asym_rsa_series_normalize(s : CryptoasymrsaSeries) -> CryptoasymrsaSeries {
  let mn = crypto_asym_rsa_series_min(s)
  let mx = crypto_asym_rsa_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_asym_rsa_series_cumsum(s : CryptoasymrsaSeries) -> CryptoasymrsaSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_asym_rsa_series_to_string(s : CryptoasymrsaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymrsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_rsa_make_matrix(rows : Int, cols : Int, val : Double) -> CryptoasymrsaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_asym_rsa_matrix_identity(n : Int) -> CryptoasymrsaMatrix {
  let m = crypto_asym_rsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_asym_rsa_matrix_get(m : CryptoasymrsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_asym_rsa_matrix_transpose(m : CryptoasymrsaMatrix) -> CryptoasymrsaMatrix {
  let result = crypto_asym_rsa_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_asym_rsa_matrix_add(a : CryptoasymrsaMatrix, b : CryptoasymrsaMatrix) -> CryptoasymrsaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_asym_rsa_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_asym_rsa_matrix_scale(m : CryptoasymrsaMatrix, s : Double) -> CryptoasymrsaMatrix {
  let result = crypto_asym_rsa_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_asym_rsa_matrix_multiply(a : CryptoasymrsaMatrix, b : CryptoasymrsaMatrix) -> CryptoasymrsaMatrix {
  if a.cols != b.rows { return crypto_asym_rsa_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_asym_rsa_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_asym_rsa_matrix_trace(m : CryptoasymrsaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_asym_rsa_matrix_det(m : CryptoasymrsaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_asym_rsa_matrix_norm(m : CryptoasymrsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_asym_rsa_matrix_to_string(m : CryptoasymrsaMatrix) -> String {
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

pub(all) struct CryptoasymrsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_rsa_make_vector(comps : Array[Double]) -> CryptoasymrsaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_rsa_vector_zero(dim : Int) -> CryptoasymrsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_asym_rsa_vector_add(a : CryptoasymrsaVector, b : CryptoasymrsaVector) -> CryptoasymrsaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn crypto_asym_rsa_vector_sub(a : CryptoasymrsaVector, b : CryptoasymrsaVector) -> CryptoasymrsaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn crypto_asym_rsa_vector_scale(v : CryptoasymrsaVector, s : Double) -> CryptoasymrsaVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn crypto_asym_rsa_vector_dot(a : CryptoasymrsaVector, b : CryptoasymrsaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_asym_rsa_vector_norm(v : CryptoasymrsaVector) -> Double { @_common.sqrt(crypto_asym_rsa_vector_dot(v, v)) }

pub fn crypto_asym_rsa_vector_normalize(v : CryptoasymrsaVector) -> CryptoasymrsaVector {
  let n = crypto_asym_rsa_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_asym_rsa_vector_scale(v, 1.0 / n) }
}

pub fn crypto_asym_rsa_vector_dist(a : CryptoasymrsaVector, b : CryptoasymrsaVector) -> Double {
  crypto_asym_rsa_vector_norm(crypto_asym_rsa_vector_sub(a, b))
}

pub fn crypto_asym_rsa_vector_to_string(v : CryptoasymrsaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_asym_rsa_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_asym_rsa_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_asym_rsa_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_asym_rsa_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_asym_rsa_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_asym_rsa_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_asym_rsa_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_asym_rsa_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_asym_rsa_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_asym_rsa_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_asym_rsa_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_asym_rsa_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_asym_rsa_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_asym_rsa_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_asym_rsa_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_asym_rsa_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_asym_rsa_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_asym_rsa_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_asym_rsa_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_asym_rsa_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_asym_rsa_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_asym_rsa_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_asym_rsa_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_asym_rsa_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_asym_rsa_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_asym_rsa_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_asym_rsa_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_asym_rsa_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_asym_rsa_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptoasymrsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_frame_make(size : Int) -> CryptoasymrsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_frame_len(s : CryptoasymrsaFrame) -> Int { s.size }

pub fn crypto_asym_rsa_frame_get(s : CryptoasymrsaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_frame_set(s : CryptoasymrsaFrame, i : Int, v : Double) -> CryptoasymrsaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_frame_sum(s : CryptoasymrsaFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_frame_mean(s : CryptoasymrsaFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_frame_scale(s : CryptoasymrsaFrame, f : Double) -> CryptoasymrsaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_frame_add(a : CryptoasymrsaFrame, b : CryptoasymrsaFrame) -> CryptoasymrsaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_frame_copy(s : CryptoasymrsaFrame) -> CryptoasymrsaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_frame_fill(s : CryptoasymrsaFrame, v : Double) -> CryptoasymrsaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_frame_min(s : CryptoasymrsaFrame) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_frame_max(s : CryptoasymrsaFrame) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_frame_to_string(s : CryptoasymrsaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_table_make(size : Int) -> CryptoasymrsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_table_len(s : CryptoasymrsaTable) -> Int { s.size }

pub fn crypto_asym_rsa_table_get(s : CryptoasymrsaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_table_set(s : CryptoasymrsaTable, i : Int, v : Double) -> CryptoasymrsaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_table_sum(s : CryptoasymrsaTable) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_table_mean(s : CryptoasymrsaTable) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_table_scale(s : CryptoasymrsaTable, f : Double) -> CryptoasymrsaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_table_add(a : CryptoasymrsaTable, b : CryptoasymrsaTable) -> CryptoasymrsaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_table_copy(s : CryptoasymrsaTable) -> CryptoasymrsaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_table_fill(s : CryptoasymrsaTable, v : Double) -> CryptoasymrsaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_table_min(s : CryptoasymrsaTable) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_table_max(s : CryptoasymrsaTable) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_table_to_string(s : CryptoasymrsaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_graphn_make(size : Int) -> CryptoasymrsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_graphn_len(s : CryptoasymrsaGraphN) -> Int { s.size }

pub fn crypto_asym_rsa_graphn_get(s : CryptoasymrsaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_graphn_set(s : CryptoasymrsaGraphN, i : Int, v : Double) -> CryptoasymrsaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_graphn_sum(s : CryptoasymrsaGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_graphn_mean(s : CryptoasymrsaGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_graphn_scale(s : CryptoasymrsaGraphN, f : Double) -> CryptoasymrsaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_graphn_add(a : CryptoasymrsaGraphN, b : CryptoasymrsaGraphN) -> CryptoasymrsaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_graphn_copy(s : CryptoasymrsaGraphN) -> CryptoasymrsaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_graphn_fill(s : CryptoasymrsaGraphN, v : Double) -> CryptoasymrsaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_graphn_min(s : CryptoasymrsaGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_graphn_max(s : CryptoasymrsaGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_graphn_to_string(s : CryptoasymrsaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_node_make(size : Int) -> CryptoasymrsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_node_len(s : CryptoasymrsaNode) -> Int { s.size }

pub fn crypto_asym_rsa_node_get(s : CryptoasymrsaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_node_set(s : CryptoasymrsaNode, i : Int, v : Double) -> CryptoasymrsaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_node_sum(s : CryptoasymrsaNode) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_node_mean(s : CryptoasymrsaNode) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_node_scale(s : CryptoasymrsaNode, f : Double) -> CryptoasymrsaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_node_add(a : CryptoasymrsaNode, b : CryptoasymrsaNode) -> CryptoasymrsaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_node_copy(s : CryptoasymrsaNode) -> CryptoasymrsaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_node_fill(s : CryptoasymrsaNode, v : Double) -> CryptoasymrsaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_node_min(s : CryptoasymrsaNode) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_node_max(s : CryptoasymrsaNode) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_node_to_string(s : CryptoasymrsaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_edge_make(size : Int) -> CryptoasymrsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_edge_len(s : CryptoasymrsaEdge) -> Int { s.size }

pub fn crypto_asym_rsa_edge_get(s : CryptoasymrsaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_edge_set(s : CryptoasymrsaEdge, i : Int, v : Double) -> CryptoasymrsaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_edge_sum(s : CryptoasymrsaEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_edge_mean(s : CryptoasymrsaEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_edge_scale(s : CryptoasymrsaEdge, f : Double) -> CryptoasymrsaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_edge_add(a : CryptoasymrsaEdge, b : CryptoasymrsaEdge) -> CryptoasymrsaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_edge_copy(s : CryptoasymrsaEdge) -> CryptoasymrsaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_edge_fill(s : CryptoasymrsaEdge, v : Double) -> CryptoasymrsaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_edge_min(s : CryptoasymrsaEdge) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_edge_max(s : CryptoasymrsaEdge) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_edge_to_string(s : CryptoasymrsaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_path_make(size : Int) -> CryptoasymrsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_path_len(s : CryptoasymrsaPath) -> Int { s.size }

pub fn crypto_asym_rsa_path_get(s : CryptoasymrsaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_path_set(s : CryptoasymrsaPath, i : Int, v : Double) -> CryptoasymrsaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_path_sum(s : CryptoasymrsaPath) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_path_mean(s : CryptoasymrsaPath) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_path_scale(s : CryptoasymrsaPath, f : Double) -> CryptoasymrsaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_path_add(a : CryptoasymrsaPath, b : CryptoasymrsaPath) -> CryptoasymrsaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_path_copy(s : CryptoasymrsaPath) -> CryptoasymrsaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_path_fill(s : CryptoasymrsaPath, v : Double) -> CryptoasymrsaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_path_min(s : CryptoasymrsaPath) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_path_max(s : CryptoasymrsaPath) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_path_to_string(s : CryptoasymrsaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_cluster_make(size : Int) -> CryptoasymrsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_cluster_len(s : CryptoasymrsaCluster) -> Int { s.size }

pub fn crypto_asym_rsa_cluster_get(s : CryptoasymrsaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_cluster_set(s : CryptoasymrsaCluster, i : Int, v : Double) -> CryptoasymrsaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_cluster_sum(s : CryptoasymrsaCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_cluster_mean(s : CryptoasymrsaCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_cluster_scale(s : CryptoasymrsaCluster, f : Double) -> CryptoasymrsaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_cluster_add(a : CryptoasymrsaCluster, b : CryptoasymrsaCluster) -> CryptoasymrsaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_cluster_copy(s : CryptoasymrsaCluster) -> CryptoasymrsaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_cluster_fill(s : CryptoasymrsaCluster, v : Double) -> CryptoasymrsaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_cluster_min(s : CryptoasymrsaCluster) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_cluster_max(s : CryptoasymrsaCluster) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_cluster_to_string(s : CryptoasymrsaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_model_make(size : Int) -> CryptoasymrsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_model_len(s : CryptoasymrsaModel) -> Int { s.size }

pub fn crypto_asym_rsa_model_get(s : CryptoasymrsaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_model_set(s : CryptoasymrsaModel, i : Int, v : Double) -> CryptoasymrsaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_model_sum(s : CryptoasymrsaModel) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_model_mean(s : CryptoasymrsaModel) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_model_scale(s : CryptoasymrsaModel, f : Double) -> CryptoasymrsaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_model_add(a : CryptoasymrsaModel, b : CryptoasymrsaModel) -> CryptoasymrsaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_model_copy(s : CryptoasymrsaModel) -> CryptoasymrsaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_model_fill(s : CryptoasymrsaModel, v : Double) -> CryptoasymrsaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_model_min(s : CryptoasymrsaModel) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_model_max(s : CryptoasymrsaModel) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_model_to_string(s : CryptoasymrsaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_layer_make(size : Int) -> CryptoasymrsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_layer_len(s : CryptoasymrsaLayer) -> Int { s.size }

pub fn crypto_asym_rsa_layer_get(s : CryptoasymrsaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_layer_set(s : CryptoasymrsaLayer, i : Int, v : Double) -> CryptoasymrsaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_layer_sum(s : CryptoasymrsaLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_layer_mean(s : CryptoasymrsaLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_layer_scale(s : CryptoasymrsaLayer, f : Double) -> CryptoasymrsaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_layer_add(a : CryptoasymrsaLayer, b : CryptoasymrsaLayer) -> CryptoasymrsaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_layer_copy(s : CryptoasymrsaLayer) -> CryptoasymrsaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_layer_fill(s : CryptoasymrsaLayer, v : Double) -> CryptoasymrsaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_layer_min(s : CryptoasymrsaLayer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_layer_max(s : CryptoasymrsaLayer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_layer_to_string(s : CryptoasymrsaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_buffer_make(size : Int) -> CryptoasymrsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_buffer_len(s : CryptoasymrsaBuffer) -> Int { s.size }

pub fn crypto_asym_rsa_buffer_get(s : CryptoasymrsaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_buffer_set(s : CryptoasymrsaBuffer, i : Int, v : Double) -> CryptoasymrsaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_buffer_sum(s : CryptoasymrsaBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_buffer_mean(s : CryptoasymrsaBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_buffer_scale(s : CryptoasymrsaBuffer, f : Double) -> CryptoasymrsaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_buffer_add(a : CryptoasymrsaBuffer, b : CryptoasymrsaBuffer) -> CryptoasymrsaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_buffer_copy(s : CryptoasymrsaBuffer) -> CryptoasymrsaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_buffer_fill(s : CryptoasymrsaBuffer, v : Double) -> CryptoasymrsaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_buffer_min(s : CryptoasymrsaBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_buffer_max(s : CryptoasymrsaBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_buffer_to_string(s : CryptoasymrsaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_cursor_make(size : Int) -> CryptoasymrsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_cursor_len(s : CryptoasymrsaCursor) -> Int { s.size }

pub fn crypto_asym_rsa_cursor_get(s : CryptoasymrsaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_cursor_set(s : CryptoasymrsaCursor, i : Int, v : Double) -> CryptoasymrsaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_cursor_sum(s : CryptoasymrsaCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_cursor_mean(s : CryptoasymrsaCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_cursor_scale(s : CryptoasymrsaCursor, f : Double) -> CryptoasymrsaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_cursor_add(a : CryptoasymrsaCursor, b : CryptoasymrsaCursor) -> CryptoasymrsaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_cursor_copy(s : CryptoasymrsaCursor) -> CryptoasymrsaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_cursor_fill(s : CryptoasymrsaCursor, v : Double) -> CryptoasymrsaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_cursor_min(s : CryptoasymrsaCursor) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_cursor_max(s : CryptoasymrsaCursor) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_cursor_to_string(s : CryptoasymrsaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_view_make(size : Int) -> CryptoasymrsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_view_len(s : CryptoasymrsaView) -> Int { s.size }

pub fn crypto_asym_rsa_view_get(s : CryptoasymrsaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_view_set(s : CryptoasymrsaView, i : Int, v : Double) -> CryptoasymrsaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_view_sum(s : CryptoasymrsaView) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_view_mean(s : CryptoasymrsaView) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_view_scale(s : CryptoasymrsaView, f : Double) -> CryptoasymrsaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_view_add(a : CryptoasymrsaView, b : CryptoasymrsaView) -> CryptoasymrsaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_view_copy(s : CryptoasymrsaView) -> CryptoasymrsaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_view_fill(s : CryptoasymrsaView, v : Double) -> CryptoasymrsaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_view_min(s : CryptoasymrsaView) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_view_max(s : CryptoasymrsaView) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_view_to_string(s : CryptoasymrsaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_range_make(size : Int) -> CryptoasymrsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_range_len(s : CryptoasymrsaRange) -> Int { s.size }

pub fn crypto_asym_rsa_range_get(s : CryptoasymrsaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_range_set(s : CryptoasymrsaRange, i : Int, v : Double) -> CryptoasymrsaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_range_sum(s : CryptoasymrsaRange) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_range_mean(s : CryptoasymrsaRange) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_range_scale(s : CryptoasymrsaRange, f : Double) -> CryptoasymrsaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_range_add(a : CryptoasymrsaRange, b : CryptoasymrsaRange) -> CryptoasymrsaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_range_copy(s : CryptoasymrsaRange) -> CryptoasymrsaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_range_fill(s : CryptoasymrsaRange, v : Double) -> CryptoasymrsaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_range_min(s : CryptoasymrsaRange) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_range_max(s : CryptoasymrsaRange) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_range_to_string(s : CryptoasymrsaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_slice_make(size : Int) -> CryptoasymrsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_slice_len(s : CryptoasymrsaSlice) -> Int { s.size }

pub fn crypto_asym_rsa_slice_get(s : CryptoasymrsaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_slice_set(s : CryptoasymrsaSlice, i : Int, v : Double) -> CryptoasymrsaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_slice_sum(s : CryptoasymrsaSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_slice_mean(s : CryptoasymrsaSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_slice_scale(s : CryptoasymrsaSlice, f : Double) -> CryptoasymrsaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_slice_add(a : CryptoasymrsaSlice, b : CryptoasymrsaSlice) -> CryptoasymrsaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_slice_copy(s : CryptoasymrsaSlice) -> CryptoasymrsaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_slice_fill(s : CryptoasymrsaSlice, v : Double) -> CryptoasymrsaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_slice_min(s : CryptoasymrsaSlice) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_slice_max(s : CryptoasymrsaSlice) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_slice_to_string(s : CryptoasymrsaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

