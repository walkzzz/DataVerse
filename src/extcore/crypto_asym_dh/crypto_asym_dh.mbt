///===
/// extcore/crypto_asym_dh

pub(all) struct CryptoasymdhPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_dh_make_point(x : Double, y : Double) -> CryptoasymdhPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_dh_make_point3(x : Double, y : Double, z : Double) -> CryptoasymdhPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_asym_dh_point_x(pt : CryptoasymdhPoint) -> Double { pt.x }

pub fn crypto_asym_dh_point_y(pt : CryptoasymdhPoint) -> Double { pt.y }

pub fn crypto_asym_dh_point_z(pt : CryptoasymdhPoint) -> Double { pt.z }

pub fn crypto_asym_dh_point_label(pt : CryptoasymdhPoint) -> Int { pt.label }

pub fn crypto_asym_dh_point_dist(a : CryptoasymdhPoint, b : CryptoasymdhPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_asym_dh_point_add(a : CryptoasymdhPoint, b : CryptoasymdhPoint) -> CryptoasymdhPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_asym_dh_point_sub(a : CryptoasymdhPoint, b : CryptoasymdhPoint) -> CryptoasymdhPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_asym_dh_point_scale(pt : CryptoasymdhPoint, s : Double) -> CryptoasymdhPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_asym_dh_point_dot(a : CryptoasymdhPoint, b : CryptoasymdhPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_asym_dh_point_cross(a : CryptoasymdhPoint, b : CryptoasymdhPoint) -> CryptoasymdhPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_asym_dh_point_norm(pt : CryptoasymdhPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_asym_dh_point_normalize(pt : CryptoasymdhPoint) -> CryptoasymdhPoint {
  let n = crypto_asym_dh_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_asym_dh_point_scale(pt, 1.0 / n) }
}

pub fn crypto_asym_dh_point_negate(pt : CryptoasymdhPoint) -> CryptoasymdhPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_asym_dh_point_mid(a : CryptoasymdhPoint, b : CryptoasymdhPoint) -> CryptoasymdhPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_asym_dh_point_lerp(a : CryptoasymdhPoint, b : CryptoasymdhPoint, t : Double) -> CryptoasymdhPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_asym_dh_point_to_string(pt : CryptoasymdhPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptoasymdhSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_dh_make_series(vals : Array[Double], name : String) -> CryptoasymdhSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_asym_dh_series_len(s : CryptoasymdhSeries) -> Int { s.vals.length() }

pub fn crypto_asym_dh_series_sum(s : CryptoasymdhSeries) -> Double { @_common.sum(s.vals) }

pub fn crypto_asym_dh_series_mean(s : CryptoasymdhSeries) -> Double { @_common.mean(s.vals) }

pub fn crypto_asym_dh_series_min(s : CryptoasymdhSeries) -> Double { @_common.min(s.vals) }

pub fn crypto_asym_dh_series_max(s : CryptoasymdhSeries) -> Double { @_common.max(s.vals) }

pub fn crypto_asym_dh_series_range(s : CryptoasymdhSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_asym_dh_series_var(s : CryptoasymdhSeries) -> Double { @_common.variance(s.vals) }

pub fn crypto_asym_dh_series_std(s : CryptoasymdhSeries) -> Double { @_common.std(s.vals) }

pub fn crypto_asym_dh_series_median(s : CryptoasymdhSeries) -> Double { @_common.median(s.vals) }

pub fn crypto_asym_dh_series_scale(s : CryptoasymdhSeries, f : Double) -> CryptoasymdhSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn crypto_asym_dh_series_add(a : CryptoasymdhSeries, b : CryptoasymdhSeries) -> CryptoasymdhSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_asym_dh_series_sub(a : CryptoasymdhSeries, b : CryptoasymdhSeries) -> CryptoasymdhSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_asym_dh_series_normalize(s : CryptoasymdhSeries) -> CryptoasymdhSeries {
  let mn = crypto_asym_dh_series_min(s)
  let mx = crypto_asym_dh_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_asym_dh_series_cumsum(s : CryptoasymdhSeries) -> CryptoasymdhSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_asym_dh_series_to_string(s : CryptoasymdhSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymdhMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_dh_make_matrix(rows : Int, cols : Int, val : Double) -> CryptoasymdhMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_asym_dh_matrix_identity(n : Int) -> CryptoasymdhMatrix {
  let m = crypto_asym_dh_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_asym_dh_matrix_get(m : CryptoasymdhMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_asym_dh_matrix_transpose(m : CryptoasymdhMatrix) -> CryptoasymdhMatrix {
  let result = crypto_asym_dh_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_asym_dh_matrix_add(a : CryptoasymdhMatrix, b : CryptoasymdhMatrix) -> CryptoasymdhMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_asym_dh_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_asym_dh_matrix_scale(m : CryptoasymdhMatrix, s : Double) -> CryptoasymdhMatrix {
  let result = crypto_asym_dh_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_asym_dh_matrix_multiply(a : CryptoasymdhMatrix, b : CryptoasymdhMatrix) -> CryptoasymdhMatrix {
  if a.cols != b.rows { return crypto_asym_dh_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_asym_dh_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_asym_dh_matrix_trace(m : CryptoasymdhMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_asym_dh_matrix_det(m : CryptoasymdhMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_asym_dh_matrix_norm(m : CryptoasymdhMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_asym_dh_matrix_to_string(m : CryptoasymdhMatrix) -> String {
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

pub(all) struct CryptoasymdhVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_dh_make_vector(comps : Array[Double]) -> CryptoasymdhVector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_dh_vector_zero(dim : Int) -> CryptoasymdhVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_asym_dh_vector_add(a : CryptoasymdhVector, b : CryptoasymdhVector) -> CryptoasymdhVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn crypto_asym_dh_vector_sub(a : CryptoasymdhVector, b : CryptoasymdhVector) -> CryptoasymdhVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn crypto_asym_dh_vector_scale(v : CryptoasymdhVector, s : Double) -> CryptoasymdhVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn crypto_asym_dh_vector_dot(a : CryptoasymdhVector, b : CryptoasymdhVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_asym_dh_vector_norm(v : CryptoasymdhVector) -> Double { @_common.sqrt(crypto_asym_dh_vector_dot(v, v)) }

pub fn crypto_asym_dh_vector_normalize(v : CryptoasymdhVector) -> CryptoasymdhVector {
  let n = crypto_asym_dh_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_asym_dh_vector_scale(v, 1.0 / n) }
}

pub fn crypto_asym_dh_vector_dist(a : CryptoasymdhVector, b : CryptoasymdhVector) -> Double {
  crypto_asym_dh_vector_norm(crypto_asym_dh_vector_sub(a, b))
}

pub fn crypto_asym_dh_vector_to_string(v : CryptoasymdhVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_asym_dh_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_asym_dh_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_asym_dh_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_asym_dh_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_asym_dh_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_asym_dh_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_asym_dh_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_asym_dh_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_asym_dh_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_asym_dh_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_asym_dh_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_asym_dh_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_asym_dh_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_asym_dh_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_asym_dh_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_asym_dh_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_asym_dh_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_asym_dh_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_asym_dh_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_asym_dh_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_asym_dh_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_asym_dh_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_asym_dh_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_asym_dh_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_asym_dh_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_asym_dh_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_asym_dh_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_asym_dh_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_asym_dh_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptoasymdhFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_frame_make(size : Int) -> CryptoasymdhFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dh_frame_len(s : CryptoasymdhFrame) -> Int { s.size }

pub fn crypto_asym_dh_frame_get(s : CryptoasymdhFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dh_frame_set(s : CryptoasymdhFrame, i : Int, v : Double) -> CryptoasymdhFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_frame_sum(s : CryptoasymdhFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dh_frame_mean(s : CryptoasymdhFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dh_frame_scale(s : CryptoasymdhFrame, f : Double) -> CryptoasymdhFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_frame_add(a : CryptoasymdhFrame, b : CryptoasymdhFrame) -> CryptoasymdhFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dh_frame_copy(s : CryptoasymdhFrame) -> CryptoasymdhFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_frame_fill(s : CryptoasymdhFrame, v : Double) -> CryptoasymdhFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_frame_min(s : CryptoasymdhFrame) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dh_frame_max(s : CryptoasymdhFrame) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dh_frame_to_string(s : CryptoasymdhFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_table_make(size : Int) -> CryptoasymdhTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dh_table_len(s : CryptoasymdhTable) -> Int { s.size }

pub fn crypto_asym_dh_table_get(s : CryptoasymdhTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dh_table_set(s : CryptoasymdhTable, i : Int, v : Double) -> CryptoasymdhTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_table_sum(s : CryptoasymdhTable) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dh_table_mean(s : CryptoasymdhTable) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dh_table_scale(s : CryptoasymdhTable, f : Double) -> CryptoasymdhTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_table_add(a : CryptoasymdhTable, b : CryptoasymdhTable) -> CryptoasymdhTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dh_table_copy(s : CryptoasymdhTable) -> CryptoasymdhTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_table_fill(s : CryptoasymdhTable, v : Double) -> CryptoasymdhTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_table_min(s : CryptoasymdhTable) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dh_table_max(s : CryptoasymdhTable) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dh_table_to_string(s : CryptoasymdhTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_graphn_make(size : Int) -> CryptoasymdhGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dh_graphn_len(s : CryptoasymdhGraphN) -> Int { s.size }

pub fn crypto_asym_dh_graphn_get(s : CryptoasymdhGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dh_graphn_set(s : CryptoasymdhGraphN, i : Int, v : Double) -> CryptoasymdhGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_graphn_sum(s : CryptoasymdhGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dh_graphn_mean(s : CryptoasymdhGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dh_graphn_scale(s : CryptoasymdhGraphN, f : Double) -> CryptoasymdhGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_graphn_add(a : CryptoasymdhGraphN, b : CryptoasymdhGraphN) -> CryptoasymdhGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dh_graphn_copy(s : CryptoasymdhGraphN) -> CryptoasymdhGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_graphn_fill(s : CryptoasymdhGraphN, v : Double) -> CryptoasymdhGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_graphn_min(s : CryptoasymdhGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dh_graphn_max(s : CryptoasymdhGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dh_graphn_to_string(s : CryptoasymdhGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_node_make(size : Int) -> CryptoasymdhNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dh_node_len(s : CryptoasymdhNode) -> Int { s.size }

pub fn crypto_asym_dh_node_get(s : CryptoasymdhNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dh_node_set(s : CryptoasymdhNode, i : Int, v : Double) -> CryptoasymdhNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_node_sum(s : CryptoasymdhNode) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dh_node_mean(s : CryptoasymdhNode) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dh_node_scale(s : CryptoasymdhNode, f : Double) -> CryptoasymdhNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_node_add(a : CryptoasymdhNode, b : CryptoasymdhNode) -> CryptoasymdhNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dh_node_copy(s : CryptoasymdhNode) -> CryptoasymdhNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_node_fill(s : CryptoasymdhNode, v : Double) -> CryptoasymdhNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_node_min(s : CryptoasymdhNode) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dh_node_max(s : CryptoasymdhNode) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dh_node_to_string(s : CryptoasymdhNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_edge_make(size : Int) -> CryptoasymdhEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dh_edge_len(s : CryptoasymdhEdge) -> Int { s.size }

pub fn crypto_asym_dh_edge_get(s : CryptoasymdhEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dh_edge_set(s : CryptoasymdhEdge, i : Int, v : Double) -> CryptoasymdhEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_edge_sum(s : CryptoasymdhEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dh_edge_mean(s : CryptoasymdhEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dh_edge_scale(s : CryptoasymdhEdge, f : Double) -> CryptoasymdhEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_edge_add(a : CryptoasymdhEdge, b : CryptoasymdhEdge) -> CryptoasymdhEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dh_edge_copy(s : CryptoasymdhEdge) -> CryptoasymdhEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_edge_fill(s : CryptoasymdhEdge, v : Double) -> CryptoasymdhEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_edge_min(s : CryptoasymdhEdge) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dh_edge_max(s : CryptoasymdhEdge) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dh_edge_to_string(s : CryptoasymdhEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_path_make(size : Int) -> CryptoasymdhPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dh_path_len(s : CryptoasymdhPath) -> Int { s.size }

pub fn crypto_asym_dh_path_get(s : CryptoasymdhPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dh_path_set(s : CryptoasymdhPath, i : Int, v : Double) -> CryptoasymdhPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_path_sum(s : CryptoasymdhPath) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dh_path_mean(s : CryptoasymdhPath) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dh_path_scale(s : CryptoasymdhPath, f : Double) -> CryptoasymdhPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_path_add(a : CryptoasymdhPath, b : CryptoasymdhPath) -> CryptoasymdhPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dh_path_copy(s : CryptoasymdhPath) -> CryptoasymdhPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_path_fill(s : CryptoasymdhPath, v : Double) -> CryptoasymdhPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_path_min(s : CryptoasymdhPath) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dh_path_max(s : CryptoasymdhPath) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dh_path_to_string(s : CryptoasymdhPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_cluster_make(size : Int) -> CryptoasymdhCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dh_cluster_len(s : CryptoasymdhCluster) -> Int { s.size }

pub fn crypto_asym_dh_cluster_get(s : CryptoasymdhCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dh_cluster_set(s : CryptoasymdhCluster, i : Int, v : Double) -> CryptoasymdhCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_cluster_sum(s : CryptoasymdhCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dh_cluster_mean(s : CryptoasymdhCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dh_cluster_scale(s : CryptoasymdhCluster, f : Double) -> CryptoasymdhCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_cluster_add(a : CryptoasymdhCluster, b : CryptoasymdhCluster) -> CryptoasymdhCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dh_cluster_copy(s : CryptoasymdhCluster) -> CryptoasymdhCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_cluster_fill(s : CryptoasymdhCluster, v : Double) -> CryptoasymdhCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_cluster_min(s : CryptoasymdhCluster) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dh_cluster_max(s : CryptoasymdhCluster) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dh_cluster_to_string(s : CryptoasymdhCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_model_make(size : Int) -> CryptoasymdhModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dh_model_len(s : CryptoasymdhModel) -> Int { s.size }

pub fn crypto_asym_dh_model_get(s : CryptoasymdhModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dh_model_set(s : CryptoasymdhModel, i : Int, v : Double) -> CryptoasymdhModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_model_sum(s : CryptoasymdhModel) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dh_model_mean(s : CryptoasymdhModel) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dh_model_scale(s : CryptoasymdhModel, f : Double) -> CryptoasymdhModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_model_add(a : CryptoasymdhModel, b : CryptoasymdhModel) -> CryptoasymdhModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dh_model_copy(s : CryptoasymdhModel) -> CryptoasymdhModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_model_fill(s : CryptoasymdhModel, v : Double) -> CryptoasymdhModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_model_min(s : CryptoasymdhModel) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dh_model_max(s : CryptoasymdhModel) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dh_model_to_string(s : CryptoasymdhModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_layer_make(size : Int) -> CryptoasymdhLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dh_layer_len(s : CryptoasymdhLayer) -> Int { s.size }

pub fn crypto_asym_dh_layer_get(s : CryptoasymdhLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dh_layer_set(s : CryptoasymdhLayer, i : Int, v : Double) -> CryptoasymdhLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_layer_sum(s : CryptoasymdhLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dh_layer_mean(s : CryptoasymdhLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dh_layer_scale(s : CryptoasymdhLayer, f : Double) -> CryptoasymdhLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_layer_add(a : CryptoasymdhLayer, b : CryptoasymdhLayer) -> CryptoasymdhLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dh_layer_copy(s : CryptoasymdhLayer) -> CryptoasymdhLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_layer_fill(s : CryptoasymdhLayer, v : Double) -> CryptoasymdhLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_layer_min(s : CryptoasymdhLayer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dh_layer_max(s : CryptoasymdhLayer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dh_layer_to_string(s : CryptoasymdhLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_buffer_make(size : Int) -> CryptoasymdhBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dh_buffer_len(s : CryptoasymdhBuffer) -> Int { s.size }

pub fn crypto_asym_dh_buffer_get(s : CryptoasymdhBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dh_buffer_set(s : CryptoasymdhBuffer, i : Int, v : Double) -> CryptoasymdhBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_buffer_sum(s : CryptoasymdhBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dh_buffer_mean(s : CryptoasymdhBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dh_buffer_scale(s : CryptoasymdhBuffer, f : Double) -> CryptoasymdhBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_buffer_add(a : CryptoasymdhBuffer, b : CryptoasymdhBuffer) -> CryptoasymdhBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dh_buffer_copy(s : CryptoasymdhBuffer) -> CryptoasymdhBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_buffer_fill(s : CryptoasymdhBuffer, v : Double) -> CryptoasymdhBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_buffer_min(s : CryptoasymdhBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dh_buffer_max(s : CryptoasymdhBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dh_buffer_to_string(s : CryptoasymdhBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_cursor_make(size : Int) -> CryptoasymdhCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dh_cursor_len(s : CryptoasymdhCursor) -> Int { s.size }

pub fn crypto_asym_dh_cursor_get(s : CryptoasymdhCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dh_cursor_set(s : CryptoasymdhCursor, i : Int, v : Double) -> CryptoasymdhCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_cursor_sum(s : CryptoasymdhCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dh_cursor_mean(s : CryptoasymdhCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dh_cursor_scale(s : CryptoasymdhCursor, f : Double) -> CryptoasymdhCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_cursor_add(a : CryptoasymdhCursor, b : CryptoasymdhCursor) -> CryptoasymdhCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dh_cursor_copy(s : CryptoasymdhCursor) -> CryptoasymdhCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_cursor_fill(s : CryptoasymdhCursor, v : Double) -> CryptoasymdhCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_cursor_min(s : CryptoasymdhCursor) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dh_cursor_max(s : CryptoasymdhCursor) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dh_cursor_to_string(s : CryptoasymdhCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_view_make(size : Int) -> CryptoasymdhView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dh_view_len(s : CryptoasymdhView) -> Int { s.size }

pub fn crypto_asym_dh_view_get(s : CryptoasymdhView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dh_view_set(s : CryptoasymdhView, i : Int, v : Double) -> CryptoasymdhView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_view_sum(s : CryptoasymdhView) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dh_view_mean(s : CryptoasymdhView) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dh_view_scale(s : CryptoasymdhView, f : Double) -> CryptoasymdhView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_view_add(a : CryptoasymdhView, b : CryptoasymdhView) -> CryptoasymdhView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dh_view_copy(s : CryptoasymdhView) -> CryptoasymdhView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_view_fill(s : CryptoasymdhView, v : Double) -> CryptoasymdhView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_view_min(s : CryptoasymdhView) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dh_view_max(s : CryptoasymdhView) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dh_view_to_string(s : CryptoasymdhView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_range_make(size : Int) -> CryptoasymdhRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dh_range_len(s : CryptoasymdhRange) -> Int { s.size }

pub fn crypto_asym_dh_range_get(s : CryptoasymdhRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dh_range_set(s : CryptoasymdhRange, i : Int, v : Double) -> CryptoasymdhRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_range_sum(s : CryptoasymdhRange) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dh_range_mean(s : CryptoasymdhRange) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dh_range_scale(s : CryptoasymdhRange, f : Double) -> CryptoasymdhRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_range_add(a : CryptoasymdhRange, b : CryptoasymdhRange) -> CryptoasymdhRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dh_range_copy(s : CryptoasymdhRange) -> CryptoasymdhRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_range_fill(s : CryptoasymdhRange, v : Double) -> CryptoasymdhRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_range_min(s : CryptoasymdhRange) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dh_range_max(s : CryptoasymdhRange) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dh_range_to_string(s : CryptoasymdhRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_slice_make(size : Int) -> CryptoasymdhSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dh_slice_len(s : CryptoasymdhSlice) -> Int { s.size }

pub fn crypto_asym_dh_slice_get(s : CryptoasymdhSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dh_slice_set(s : CryptoasymdhSlice, i : Int, v : Double) -> CryptoasymdhSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_slice_sum(s : CryptoasymdhSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_dh_slice_mean(s : CryptoasymdhSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_dh_slice_scale(s : CryptoasymdhSlice, f : Double) -> CryptoasymdhSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_slice_add(a : CryptoasymdhSlice, b : CryptoasymdhSlice) -> CryptoasymdhSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_dh_slice_copy(s : CryptoasymdhSlice) -> CryptoasymdhSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_slice_fill(s : CryptoasymdhSlice, v : Double) -> CryptoasymdhSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_dh_slice_min(s : CryptoasymdhSlice) -> Double { @_common.min(s.data) }

pub fn crypto_asym_dh_slice_max(s : CryptoasymdhSlice) -> Double { @_common.max(s.data) }

pub fn crypto_asym_dh_slice_to_string(s : CryptoasymdhSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

