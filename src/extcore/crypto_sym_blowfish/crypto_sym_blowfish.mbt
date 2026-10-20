///===
/// extcore/crypto_sym_blowfish

pub(all) struct CryptosymblowfishPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_blowfish_make_point(x : Double, y : Double) -> CryptosymblowfishPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_blowfish_make_point3(x : Double, y : Double, z : Double) -> CryptosymblowfishPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_sym_blowfish_point_x(pt : CryptosymblowfishPoint) -> Double { pt.x }

pub fn crypto_sym_blowfish_point_y(pt : CryptosymblowfishPoint) -> Double { pt.y }

pub fn crypto_sym_blowfish_point_z(pt : CryptosymblowfishPoint) -> Double { pt.z }

pub fn crypto_sym_blowfish_point_label(pt : CryptosymblowfishPoint) -> Int { pt.label }

pub fn crypto_sym_blowfish_point_dist(a : CryptosymblowfishPoint, b : CryptosymblowfishPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_sym_blowfish_point_add(a : CryptosymblowfishPoint, b : CryptosymblowfishPoint) -> CryptosymblowfishPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_sym_blowfish_point_sub(a : CryptosymblowfishPoint, b : CryptosymblowfishPoint) -> CryptosymblowfishPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_sym_blowfish_point_scale(pt : CryptosymblowfishPoint, s : Double) -> CryptosymblowfishPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_sym_blowfish_point_dot(a : CryptosymblowfishPoint, b : CryptosymblowfishPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_sym_blowfish_point_cross(a : CryptosymblowfishPoint, b : CryptosymblowfishPoint) -> CryptosymblowfishPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_sym_blowfish_point_norm(pt : CryptosymblowfishPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_sym_blowfish_point_normalize(pt : CryptosymblowfishPoint) -> CryptosymblowfishPoint {
  let n = crypto_sym_blowfish_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_sym_blowfish_point_scale(pt, 1.0 / n) }
}

pub fn crypto_sym_blowfish_point_negate(pt : CryptosymblowfishPoint) -> CryptosymblowfishPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_sym_blowfish_point_mid(a : CryptosymblowfishPoint, b : CryptosymblowfishPoint) -> CryptosymblowfishPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_sym_blowfish_point_lerp(a : CryptosymblowfishPoint, b : CryptosymblowfishPoint, t : Double) -> CryptosymblowfishPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_sym_blowfish_point_to_string(pt : CryptosymblowfishPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptosymblowfishSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_blowfish_make_series(vals : Array[Double], name : String) -> CryptosymblowfishSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_sym_blowfish_series_len(s : CryptosymblowfishSeries) -> Int { s.vals.length() }

pub fn crypto_sym_blowfish_series_sum(s : CryptosymblowfishSeries) -> Double { @_common.sum(s.vals) }

pub fn crypto_sym_blowfish_series_mean(s : CryptosymblowfishSeries) -> Double { @_common.mean(s.vals) }

pub fn crypto_sym_blowfish_series_min(s : CryptosymblowfishSeries) -> Double { @_common.min(s.vals) }

pub fn crypto_sym_blowfish_series_max(s : CryptosymblowfishSeries) -> Double { @_common.max(s.vals) }

pub fn crypto_sym_blowfish_series_range(s : CryptosymblowfishSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_sym_blowfish_series_var(s : CryptosymblowfishSeries) -> Double { @_common.variance(s.vals) }

pub fn crypto_sym_blowfish_series_std(s : CryptosymblowfishSeries) -> Double { @_common.std(s.vals) }

pub fn crypto_sym_blowfish_series_median(s : CryptosymblowfishSeries) -> Double { @_common.median(s.vals) }

pub fn crypto_sym_blowfish_series_scale(s : CryptosymblowfishSeries, f : Double) -> CryptosymblowfishSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn crypto_sym_blowfish_series_add(a : CryptosymblowfishSeries, b : CryptosymblowfishSeries) -> CryptosymblowfishSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_sym_blowfish_series_sub(a : CryptosymblowfishSeries, b : CryptosymblowfishSeries) -> CryptosymblowfishSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_sym_blowfish_series_normalize(s : CryptosymblowfishSeries) -> CryptosymblowfishSeries {
  let mn = crypto_sym_blowfish_series_min(s)
  let mx = crypto_sym_blowfish_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_sym_blowfish_series_cumsum(s : CryptosymblowfishSeries) -> CryptosymblowfishSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_sym_blowfish_series_to_string(s : CryptosymblowfishSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymblowfishMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_blowfish_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymblowfishMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_blowfish_matrix_identity(n : Int) -> CryptosymblowfishMatrix {
  let m = crypto_sym_blowfish_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_sym_blowfish_matrix_get(m : CryptosymblowfishMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_sym_blowfish_matrix_transpose(m : CryptosymblowfishMatrix) -> CryptosymblowfishMatrix {
  let result = crypto_sym_blowfish_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_sym_blowfish_matrix_add(a : CryptosymblowfishMatrix, b : CryptosymblowfishMatrix) -> CryptosymblowfishMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_sym_blowfish_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_sym_blowfish_matrix_scale(m : CryptosymblowfishMatrix, s : Double) -> CryptosymblowfishMatrix {
  let result = crypto_sym_blowfish_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_sym_blowfish_matrix_multiply(a : CryptosymblowfishMatrix, b : CryptosymblowfishMatrix) -> CryptosymblowfishMatrix {
  if a.cols != b.rows { return crypto_sym_blowfish_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_sym_blowfish_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_sym_blowfish_matrix_trace(m : CryptosymblowfishMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_sym_blowfish_matrix_det(m : CryptosymblowfishMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_sym_blowfish_matrix_norm(m : CryptosymblowfishMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_sym_blowfish_matrix_to_string(m : CryptosymblowfishMatrix) -> String {
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

pub(all) struct CryptosymblowfishVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_blowfish_make_vector(comps : Array[Double]) -> CryptosymblowfishVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_blowfish_vector_zero(dim : Int) -> CryptosymblowfishVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_sym_blowfish_vector_add(a : CryptosymblowfishVector, b : CryptosymblowfishVector) -> CryptosymblowfishVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn crypto_sym_blowfish_vector_sub(a : CryptosymblowfishVector, b : CryptosymblowfishVector) -> CryptosymblowfishVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn crypto_sym_blowfish_vector_scale(v : CryptosymblowfishVector, s : Double) -> CryptosymblowfishVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn crypto_sym_blowfish_vector_dot(a : CryptosymblowfishVector, b : CryptosymblowfishVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_sym_blowfish_vector_norm(v : CryptosymblowfishVector) -> Double { @_common.sqrt(crypto_sym_blowfish_vector_dot(v, v)) }

pub fn crypto_sym_blowfish_vector_normalize(v : CryptosymblowfishVector) -> CryptosymblowfishVector {
  let n = crypto_sym_blowfish_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_sym_blowfish_vector_scale(v, 1.0 / n) }
}

pub fn crypto_sym_blowfish_vector_dist(a : CryptosymblowfishVector, b : CryptosymblowfishVector) -> Double {
  crypto_sym_blowfish_vector_norm(crypto_sym_blowfish_vector_sub(a, b))
}

pub fn crypto_sym_blowfish_vector_to_string(v : CryptosymblowfishVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sym_blowfish_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sym_blowfish_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sym_blowfish_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sym_blowfish_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sym_blowfish_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sym_blowfish_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sym_blowfish_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sym_blowfish_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sym_blowfish_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sym_blowfish_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sym_blowfish_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sym_blowfish_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sym_blowfish_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sym_blowfish_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sym_blowfish_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sym_blowfish_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sym_blowfish_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sym_blowfish_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sym_blowfish_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sym_blowfish_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sym_blowfish_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sym_blowfish_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sym_blowfish_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sym_blowfish_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sym_blowfish_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sym_blowfish_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sym_blowfish_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sym_blowfish_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sym_blowfish_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosymblowfishFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_frame_make(size : Int) -> CryptosymblowfishFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_frame_len(s : CryptosymblowfishFrame) -> Int { s.size }

pub fn crypto_sym_blowfish_frame_get(s : CryptosymblowfishFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_frame_set(s : CryptosymblowfishFrame, i : Int, v : Double) -> CryptosymblowfishFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_frame_sum(s : CryptosymblowfishFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_blowfish_frame_mean(s : CryptosymblowfishFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_blowfish_frame_scale(s : CryptosymblowfishFrame, f : Double) -> CryptosymblowfishFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_frame_add(a : CryptosymblowfishFrame, b : CryptosymblowfishFrame) -> CryptosymblowfishFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_blowfish_frame_copy(s : CryptosymblowfishFrame) -> CryptosymblowfishFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_frame_fill(s : CryptosymblowfishFrame, v : Double) -> CryptosymblowfishFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_frame_min(s : CryptosymblowfishFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sym_blowfish_frame_max(s : CryptosymblowfishFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sym_blowfish_frame_to_string(s : CryptosymblowfishFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_table_make(size : Int) -> CryptosymblowfishTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_table_len(s : CryptosymblowfishTable) -> Int { s.size }

pub fn crypto_sym_blowfish_table_get(s : CryptosymblowfishTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_table_set(s : CryptosymblowfishTable, i : Int, v : Double) -> CryptosymblowfishTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_table_sum(s : CryptosymblowfishTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_blowfish_table_mean(s : CryptosymblowfishTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_blowfish_table_scale(s : CryptosymblowfishTable, f : Double) -> CryptosymblowfishTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_table_add(a : CryptosymblowfishTable, b : CryptosymblowfishTable) -> CryptosymblowfishTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_blowfish_table_copy(s : CryptosymblowfishTable) -> CryptosymblowfishTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_table_fill(s : CryptosymblowfishTable, v : Double) -> CryptosymblowfishTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_table_min(s : CryptosymblowfishTable) -> Double { @_common.min(s.data) }

pub fn crypto_sym_blowfish_table_max(s : CryptosymblowfishTable) -> Double { @_common.max(s.data) }

pub fn crypto_sym_blowfish_table_to_string(s : CryptosymblowfishTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_graphn_make(size : Int) -> CryptosymblowfishGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_graphn_len(s : CryptosymblowfishGraphN) -> Int { s.size }

pub fn crypto_sym_blowfish_graphn_get(s : CryptosymblowfishGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_graphn_set(s : CryptosymblowfishGraphN, i : Int, v : Double) -> CryptosymblowfishGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_graphn_sum(s : CryptosymblowfishGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_blowfish_graphn_mean(s : CryptosymblowfishGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_blowfish_graphn_scale(s : CryptosymblowfishGraphN, f : Double) -> CryptosymblowfishGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_graphn_add(a : CryptosymblowfishGraphN, b : CryptosymblowfishGraphN) -> CryptosymblowfishGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_blowfish_graphn_copy(s : CryptosymblowfishGraphN) -> CryptosymblowfishGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_graphn_fill(s : CryptosymblowfishGraphN, v : Double) -> CryptosymblowfishGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_graphn_min(s : CryptosymblowfishGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sym_blowfish_graphn_max(s : CryptosymblowfishGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sym_blowfish_graphn_to_string(s : CryptosymblowfishGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_node_make(size : Int) -> CryptosymblowfishNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_node_len(s : CryptosymblowfishNode) -> Int { s.size }

pub fn crypto_sym_blowfish_node_get(s : CryptosymblowfishNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_node_set(s : CryptosymblowfishNode, i : Int, v : Double) -> CryptosymblowfishNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_node_sum(s : CryptosymblowfishNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_blowfish_node_mean(s : CryptosymblowfishNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_blowfish_node_scale(s : CryptosymblowfishNode, f : Double) -> CryptosymblowfishNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_node_add(a : CryptosymblowfishNode, b : CryptosymblowfishNode) -> CryptosymblowfishNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_blowfish_node_copy(s : CryptosymblowfishNode) -> CryptosymblowfishNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_node_fill(s : CryptosymblowfishNode, v : Double) -> CryptosymblowfishNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_node_min(s : CryptosymblowfishNode) -> Double { @_common.min(s.data) }

pub fn crypto_sym_blowfish_node_max(s : CryptosymblowfishNode) -> Double { @_common.max(s.data) }

pub fn crypto_sym_blowfish_node_to_string(s : CryptosymblowfishNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_edge_make(size : Int) -> CryptosymblowfishEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_edge_len(s : CryptosymblowfishEdge) -> Int { s.size }

pub fn crypto_sym_blowfish_edge_get(s : CryptosymblowfishEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_edge_set(s : CryptosymblowfishEdge, i : Int, v : Double) -> CryptosymblowfishEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_edge_sum(s : CryptosymblowfishEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_blowfish_edge_mean(s : CryptosymblowfishEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_blowfish_edge_scale(s : CryptosymblowfishEdge, f : Double) -> CryptosymblowfishEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_edge_add(a : CryptosymblowfishEdge, b : CryptosymblowfishEdge) -> CryptosymblowfishEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_blowfish_edge_copy(s : CryptosymblowfishEdge) -> CryptosymblowfishEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_edge_fill(s : CryptosymblowfishEdge, v : Double) -> CryptosymblowfishEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_edge_min(s : CryptosymblowfishEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sym_blowfish_edge_max(s : CryptosymblowfishEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sym_blowfish_edge_to_string(s : CryptosymblowfishEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_path_make(size : Int) -> CryptosymblowfishPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_path_len(s : CryptosymblowfishPath) -> Int { s.size }

pub fn crypto_sym_blowfish_path_get(s : CryptosymblowfishPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_path_set(s : CryptosymblowfishPath, i : Int, v : Double) -> CryptosymblowfishPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_path_sum(s : CryptosymblowfishPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_blowfish_path_mean(s : CryptosymblowfishPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_blowfish_path_scale(s : CryptosymblowfishPath, f : Double) -> CryptosymblowfishPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_path_add(a : CryptosymblowfishPath, b : CryptosymblowfishPath) -> CryptosymblowfishPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_blowfish_path_copy(s : CryptosymblowfishPath) -> CryptosymblowfishPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_path_fill(s : CryptosymblowfishPath, v : Double) -> CryptosymblowfishPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_path_min(s : CryptosymblowfishPath) -> Double { @_common.min(s.data) }

pub fn crypto_sym_blowfish_path_max(s : CryptosymblowfishPath) -> Double { @_common.max(s.data) }

pub fn crypto_sym_blowfish_path_to_string(s : CryptosymblowfishPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_cluster_make(size : Int) -> CryptosymblowfishCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_cluster_len(s : CryptosymblowfishCluster) -> Int { s.size }

pub fn crypto_sym_blowfish_cluster_get(s : CryptosymblowfishCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_cluster_set(s : CryptosymblowfishCluster, i : Int, v : Double) -> CryptosymblowfishCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_cluster_sum(s : CryptosymblowfishCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_blowfish_cluster_mean(s : CryptosymblowfishCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_blowfish_cluster_scale(s : CryptosymblowfishCluster, f : Double) -> CryptosymblowfishCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_cluster_add(a : CryptosymblowfishCluster, b : CryptosymblowfishCluster) -> CryptosymblowfishCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_blowfish_cluster_copy(s : CryptosymblowfishCluster) -> CryptosymblowfishCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_cluster_fill(s : CryptosymblowfishCluster, v : Double) -> CryptosymblowfishCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_cluster_min(s : CryptosymblowfishCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sym_blowfish_cluster_max(s : CryptosymblowfishCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sym_blowfish_cluster_to_string(s : CryptosymblowfishCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_model_make(size : Int) -> CryptosymblowfishModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_model_len(s : CryptosymblowfishModel) -> Int { s.size }

pub fn crypto_sym_blowfish_model_get(s : CryptosymblowfishModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_model_set(s : CryptosymblowfishModel, i : Int, v : Double) -> CryptosymblowfishModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_model_sum(s : CryptosymblowfishModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_blowfish_model_mean(s : CryptosymblowfishModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_blowfish_model_scale(s : CryptosymblowfishModel, f : Double) -> CryptosymblowfishModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_model_add(a : CryptosymblowfishModel, b : CryptosymblowfishModel) -> CryptosymblowfishModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_blowfish_model_copy(s : CryptosymblowfishModel) -> CryptosymblowfishModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_model_fill(s : CryptosymblowfishModel, v : Double) -> CryptosymblowfishModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_model_min(s : CryptosymblowfishModel) -> Double { @_common.min(s.data) }

pub fn crypto_sym_blowfish_model_max(s : CryptosymblowfishModel) -> Double { @_common.max(s.data) }

pub fn crypto_sym_blowfish_model_to_string(s : CryptosymblowfishModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_layer_make(size : Int) -> CryptosymblowfishLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_layer_len(s : CryptosymblowfishLayer) -> Int { s.size }

pub fn crypto_sym_blowfish_layer_get(s : CryptosymblowfishLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_layer_set(s : CryptosymblowfishLayer, i : Int, v : Double) -> CryptosymblowfishLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_layer_sum(s : CryptosymblowfishLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_blowfish_layer_mean(s : CryptosymblowfishLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_blowfish_layer_scale(s : CryptosymblowfishLayer, f : Double) -> CryptosymblowfishLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_layer_add(a : CryptosymblowfishLayer, b : CryptosymblowfishLayer) -> CryptosymblowfishLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_blowfish_layer_copy(s : CryptosymblowfishLayer) -> CryptosymblowfishLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_layer_fill(s : CryptosymblowfishLayer, v : Double) -> CryptosymblowfishLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_layer_min(s : CryptosymblowfishLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_blowfish_layer_max(s : CryptosymblowfishLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_blowfish_layer_to_string(s : CryptosymblowfishLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_buffer_make(size : Int) -> CryptosymblowfishBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_buffer_len(s : CryptosymblowfishBuffer) -> Int { s.size }

pub fn crypto_sym_blowfish_buffer_get(s : CryptosymblowfishBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_buffer_set(s : CryptosymblowfishBuffer, i : Int, v : Double) -> CryptosymblowfishBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_buffer_sum(s : CryptosymblowfishBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_blowfish_buffer_mean(s : CryptosymblowfishBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_blowfish_buffer_scale(s : CryptosymblowfishBuffer, f : Double) -> CryptosymblowfishBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_buffer_add(a : CryptosymblowfishBuffer, b : CryptosymblowfishBuffer) -> CryptosymblowfishBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_blowfish_buffer_copy(s : CryptosymblowfishBuffer) -> CryptosymblowfishBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_buffer_fill(s : CryptosymblowfishBuffer, v : Double) -> CryptosymblowfishBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_buffer_min(s : CryptosymblowfishBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_blowfish_buffer_max(s : CryptosymblowfishBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_blowfish_buffer_to_string(s : CryptosymblowfishBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_cursor_make(size : Int) -> CryptosymblowfishCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_cursor_len(s : CryptosymblowfishCursor) -> Int { s.size }

pub fn crypto_sym_blowfish_cursor_get(s : CryptosymblowfishCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_cursor_set(s : CryptosymblowfishCursor, i : Int, v : Double) -> CryptosymblowfishCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_cursor_sum(s : CryptosymblowfishCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_blowfish_cursor_mean(s : CryptosymblowfishCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_blowfish_cursor_scale(s : CryptosymblowfishCursor, f : Double) -> CryptosymblowfishCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_cursor_add(a : CryptosymblowfishCursor, b : CryptosymblowfishCursor) -> CryptosymblowfishCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_blowfish_cursor_copy(s : CryptosymblowfishCursor) -> CryptosymblowfishCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_cursor_fill(s : CryptosymblowfishCursor, v : Double) -> CryptosymblowfishCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_cursor_min(s : CryptosymblowfishCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sym_blowfish_cursor_max(s : CryptosymblowfishCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sym_blowfish_cursor_to_string(s : CryptosymblowfishCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_view_make(size : Int) -> CryptosymblowfishView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_view_len(s : CryptosymblowfishView) -> Int { s.size }

pub fn crypto_sym_blowfish_view_get(s : CryptosymblowfishView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_view_set(s : CryptosymblowfishView, i : Int, v : Double) -> CryptosymblowfishView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_view_sum(s : CryptosymblowfishView) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_blowfish_view_mean(s : CryptosymblowfishView) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_blowfish_view_scale(s : CryptosymblowfishView, f : Double) -> CryptosymblowfishView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_view_add(a : CryptosymblowfishView, b : CryptosymblowfishView) -> CryptosymblowfishView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_blowfish_view_copy(s : CryptosymblowfishView) -> CryptosymblowfishView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_view_fill(s : CryptosymblowfishView, v : Double) -> CryptosymblowfishView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_view_min(s : CryptosymblowfishView) -> Double { @_common.min(s.data) }

pub fn crypto_sym_blowfish_view_max(s : CryptosymblowfishView) -> Double { @_common.max(s.data) }

pub fn crypto_sym_blowfish_view_to_string(s : CryptosymblowfishView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_range_make(size : Int) -> CryptosymblowfishRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_range_len(s : CryptosymblowfishRange) -> Int { s.size }

pub fn crypto_sym_blowfish_range_get(s : CryptosymblowfishRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_range_set(s : CryptosymblowfishRange, i : Int, v : Double) -> CryptosymblowfishRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_range_sum(s : CryptosymblowfishRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_blowfish_range_mean(s : CryptosymblowfishRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_blowfish_range_scale(s : CryptosymblowfishRange, f : Double) -> CryptosymblowfishRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_range_add(a : CryptosymblowfishRange, b : CryptosymblowfishRange) -> CryptosymblowfishRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_blowfish_range_copy(s : CryptosymblowfishRange) -> CryptosymblowfishRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_range_fill(s : CryptosymblowfishRange, v : Double) -> CryptosymblowfishRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_range_min(s : CryptosymblowfishRange) -> Double { @_common.min(s.data) }

pub fn crypto_sym_blowfish_range_max(s : CryptosymblowfishRange) -> Double { @_common.max(s.data) }

pub fn crypto_sym_blowfish_range_to_string(s : CryptosymblowfishRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_slice_make(size : Int) -> CryptosymblowfishSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_slice_len(s : CryptosymblowfishSlice) -> Int { s.size }

pub fn crypto_sym_blowfish_slice_get(s : CryptosymblowfishSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_slice_set(s : CryptosymblowfishSlice, i : Int, v : Double) -> CryptosymblowfishSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_slice_sum(s : CryptosymblowfishSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_blowfish_slice_mean(s : CryptosymblowfishSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_blowfish_slice_scale(s : CryptosymblowfishSlice, f : Double) -> CryptosymblowfishSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_slice_add(a : CryptosymblowfishSlice, b : CryptosymblowfishSlice) -> CryptosymblowfishSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_blowfish_slice_copy(s : CryptosymblowfishSlice) -> CryptosymblowfishSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_slice_fill(s : CryptosymblowfishSlice, v : Double) -> CryptosymblowfishSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_blowfish_slice_min(s : CryptosymblowfishSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sym_blowfish_slice_max(s : CryptosymblowfishSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sym_blowfish_slice_to_string(s : CryptosymblowfishSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

