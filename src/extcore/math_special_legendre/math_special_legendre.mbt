///===
/// extcore/math_special_legendre

pub(all) struct MathspeciallegendrePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_legendre_make_point(x : Double, y : Double) -> MathspeciallegendrePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_legendre_make_point3(x : Double, y : Double, z : Double) -> MathspeciallegendrePoint {
  { x, y, z, label: 0 }
}

pub fn math_special_legendre_point_x(pt : MathspeciallegendrePoint) -> Double { pt.x }

pub fn math_special_legendre_point_y(pt : MathspeciallegendrePoint) -> Double { pt.y }

pub fn math_special_legendre_point_z(pt : MathspeciallegendrePoint) -> Double { pt.z }

pub fn math_special_legendre_point_label(pt : MathspeciallegendrePoint) -> Int { pt.label }

pub fn math_special_legendre_point_dist(a : MathspeciallegendrePoint, b : MathspeciallegendrePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_special_legendre_point_add(a : MathspeciallegendrePoint, b : MathspeciallegendrePoint) -> MathspeciallegendrePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_special_legendre_point_sub(a : MathspeciallegendrePoint, b : MathspeciallegendrePoint) -> MathspeciallegendrePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_special_legendre_point_scale(pt : MathspeciallegendrePoint, s : Double) -> MathspeciallegendrePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_special_legendre_point_dot(a : MathspeciallegendrePoint, b : MathspeciallegendrePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_special_legendre_point_cross(a : MathspeciallegendrePoint, b : MathspeciallegendrePoint) -> MathspeciallegendrePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_special_legendre_point_norm(pt : MathspeciallegendrePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_special_legendre_point_normalize(pt : MathspeciallegendrePoint) -> MathspeciallegendrePoint {
  let n = math_special_legendre_point_norm(pt)
  if n < 0.0000001 { pt } else { math_special_legendre_point_scale(pt, 1.0 / n) }
}

pub fn math_special_legendre_point_negate(pt : MathspeciallegendrePoint) -> MathspeciallegendrePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_special_legendre_point_mid(a : MathspeciallegendrePoint, b : MathspeciallegendrePoint) -> MathspeciallegendrePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_special_legendre_point_lerp(a : MathspeciallegendrePoint, b : MathspeciallegendrePoint, t : Double) -> MathspeciallegendrePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_special_legendre_point_to_string(pt : MathspeciallegendrePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathspeciallegendreSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_legendre_make_series(vals : Array[Double], name : String) -> MathspeciallegendreSeries {
  { vals, name, meta: 0 }
}

pub fn math_special_legendre_series_len(s : MathspeciallegendreSeries) -> Int { s.vals.length() }

pub fn math_special_legendre_series_sum(s : MathspeciallegendreSeries) -> Double { @_common.sum(s.vals) }

pub fn math_special_legendre_series_mean(s : MathspeciallegendreSeries) -> Double { @_common.mean(s.vals) }

pub fn math_special_legendre_series_min(s : MathspeciallegendreSeries) -> Double { @_common.min(s.vals) }

pub fn math_special_legendre_series_max(s : MathspeciallegendreSeries) -> Double { @_common.max(s.vals) }

pub fn math_special_legendre_series_range(s : MathspeciallegendreSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn math_special_legendre_series_var(s : MathspeciallegendreSeries) -> Double { @_common.variance(s.vals) }

pub fn math_special_legendre_series_std(s : MathspeciallegendreSeries) -> Double { @_common.std(s.vals) }

pub fn math_special_legendre_series_median(s : MathspeciallegendreSeries) -> Double { @_common.median(s.vals) }

pub fn math_special_legendre_series_scale(s : MathspeciallegendreSeries, f : Double) -> MathspeciallegendreSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn math_special_legendre_series_add(a : MathspeciallegendreSeries, b : MathspeciallegendreSeries) -> MathspeciallegendreSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_special_legendre_series_sub(a : MathspeciallegendreSeries, b : MathspeciallegendreSeries) -> MathspeciallegendreSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_special_legendre_series_normalize(s : MathspeciallegendreSeries) -> MathspeciallegendreSeries {
  let mn = math_special_legendre_series_min(s)
  let mx = math_special_legendre_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_special_legendre_series_cumsum(s : MathspeciallegendreSeries) -> MathspeciallegendreSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_special_legendre_series_to_string(s : MathspeciallegendreSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspeciallegendreMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_legendre_make_matrix(rows : Int, cols : Int, val : Double) -> MathspeciallegendreMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_legendre_matrix_identity(n : Int) -> MathspeciallegendreMatrix {
  let m = math_special_legendre_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_special_legendre_matrix_get(m : MathspeciallegendreMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_special_legendre_matrix_transpose(m : MathspeciallegendreMatrix) -> MathspeciallegendreMatrix {
  let result = math_special_legendre_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_special_legendre_matrix_add(a : MathspeciallegendreMatrix, b : MathspeciallegendreMatrix) -> MathspeciallegendreMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_special_legendre_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_special_legendre_matrix_scale(m : MathspeciallegendreMatrix, s : Double) -> MathspeciallegendreMatrix {
  let result = math_special_legendre_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_special_legendre_matrix_multiply(a : MathspeciallegendreMatrix, b : MathspeciallegendreMatrix) -> MathspeciallegendreMatrix {
  if a.cols != b.rows { return math_special_legendre_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_special_legendre_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_special_legendre_matrix_trace(m : MathspeciallegendreMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_special_legendre_matrix_det(m : MathspeciallegendreMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_special_legendre_matrix_norm(m : MathspeciallegendreMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_special_legendre_matrix_to_string(m : MathspeciallegendreMatrix) -> String {
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

pub(all) struct MathspeciallegendreVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_legendre_make_vector(comps : Array[Double]) -> MathspeciallegendreVector {
  { comps, dim: comps.length() }
}

pub fn math_special_legendre_vector_zero(dim : Int) -> MathspeciallegendreVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_special_legendre_vector_add(a : MathspeciallegendreVector, b : MathspeciallegendreVector) -> MathspeciallegendreVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn math_special_legendre_vector_sub(a : MathspeciallegendreVector, b : MathspeciallegendreVector) -> MathspeciallegendreVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn math_special_legendre_vector_scale(v : MathspeciallegendreVector, s : Double) -> MathspeciallegendreVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn math_special_legendre_vector_dot(a : MathspeciallegendreVector, b : MathspeciallegendreVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_special_legendre_vector_norm(v : MathspeciallegendreVector) -> Double { @_common.sqrt(math_special_legendre_vector_dot(v, v)) }

pub fn math_special_legendre_vector_normalize(v : MathspeciallegendreVector) -> MathspeciallegendreVector {
  let n = math_special_legendre_vector_norm(v)
  if n < 0.0000001 { v } else { math_special_legendre_vector_scale(v, 1.0 / n) }
}

pub fn math_special_legendre_vector_dist(a : MathspeciallegendreVector, b : MathspeciallegendreVector) -> Double {
  math_special_legendre_vector_norm(math_special_legendre_vector_sub(a, b))
}

pub fn math_special_legendre_vector_to_string(v : MathspeciallegendreVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_legendre_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_special_legendre_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_special_legendre_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_special_legendre_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_special_legendre_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_special_legendre_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_special_legendre_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_special_legendre_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_special_legendre_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_special_legendre_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_special_legendre_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_special_legendre_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_special_legendre_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_special_legendre_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_special_legendre_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_special_legendre_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_special_legendre_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_special_legendre_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_special_legendre_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_special_legendre_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_special_legendre_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_special_legendre_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_special_legendre_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_special_legendre_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_special_legendre_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_special_legendre_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_special_legendre_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_special_legendre_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_special_legendre_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathspeciallegendreFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_frame_make(size : Int) -> MathspeciallegendreFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_frame_len(s : MathspeciallegendreFrame) -> Int { s.size }

pub fn math_special_legendre_frame_get(s : MathspeciallegendreFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_frame_set(s : MathspeciallegendreFrame, i : Int, v : Double) -> MathspeciallegendreFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_frame_sum(s : MathspeciallegendreFrame) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_frame_mean(s : MathspeciallegendreFrame) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_frame_scale(s : MathspeciallegendreFrame, f : Double) -> MathspeciallegendreFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_frame_add(a : MathspeciallegendreFrame, b : MathspeciallegendreFrame) -> MathspeciallegendreFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_frame_copy(s : MathspeciallegendreFrame) -> MathspeciallegendreFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_frame_fill(s : MathspeciallegendreFrame, v : Double) -> MathspeciallegendreFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_frame_min(s : MathspeciallegendreFrame) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_frame_max(s : MathspeciallegendreFrame) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_frame_to_string(s : MathspeciallegendreFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_table_make(size : Int) -> MathspeciallegendreTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_table_len(s : MathspeciallegendreTable) -> Int { s.size }

pub fn math_special_legendre_table_get(s : MathspeciallegendreTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_table_set(s : MathspeciallegendreTable, i : Int, v : Double) -> MathspeciallegendreTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_table_sum(s : MathspeciallegendreTable) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_table_mean(s : MathspeciallegendreTable) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_table_scale(s : MathspeciallegendreTable, f : Double) -> MathspeciallegendreTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_table_add(a : MathspeciallegendreTable, b : MathspeciallegendreTable) -> MathspeciallegendreTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_table_copy(s : MathspeciallegendreTable) -> MathspeciallegendreTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_table_fill(s : MathspeciallegendreTable, v : Double) -> MathspeciallegendreTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_table_min(s : MathspeciallegendreTable) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_table_max(s : MathspeciallegendreTable) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_table_to_string(s : MathspeciallegendreTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_graphn_make(size : Int) -> MathspeciallegendreGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_graphn_len(s : MathspeciallegendreGraphN) -> Int { s.size }

pub fn math_special_legendre_graphn_get(s : MathspeciallegendreGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_graphn_set(s : MathspeciallegendreGraphN, i : Int, v : Double) -> MathspeciallegendreGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_graphn_sum(s : MathspeciallegendreGraphN) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_graphn_mean(s : MathspeciallegendreGraphN) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_graphn_scale(s : MathspeciallegendreGraphN, f : Double) -> MathspeciallegendreGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_graphn_add(a : MathspeciallegendreGraphN, b : MathspeciallegendreGraphN) -> MathspeciallegendreGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_graphn_copy(s : MathspeciallegendreGraphN) -> MathspeciallegendreGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_graphn_fill(s : MathspeciallegendreGraphN, v : Double) -> MathspeciallegendreGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_graphn_min(s : MathspeciallegendreGraphN) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_graphn_max(s : MathspeciallegendreGraphN) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_graphn_to_string(s : MathspeciallegendreGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_node_make(size : Int) -> MathspeciallegendreNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_node_len(s : MathspeciallegendreNode) -> Int { s.size }

pub fn math_special_legendre_node_get(s : MathspeciallegendreNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_node_set(s : MathspeciallegendreNode, i : Int, v : Double) -> MathspeciallegendreNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_node_sum(s : MathspeciallegendreNode) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_node_mean(s : MathspeciallegendreNode) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_node_scale(s : MathspeciallegendreNode, f : Double) -> MathspeciallegendreNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_node_add(a : MathspeciallegendreNode, b : MathspeciallegendreNode) -> MathspeciallegendreNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_node_copy(s : MathspeciallegendreNode) -> MathspeciallegendreNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_node_fill(s : MathspeciallegendreNode, v : Double) -> MathspeciallegendreNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_node_min(s : MathspeciallegendreNode) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_node_max(s : MathspeciallegendreNode) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_node_to_string(s : MathspeciallegendreNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_edge_make(size : Int) -> MathspeciallegendreEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_edge_len(s : MathspeciallegendreEdge) -> Int { s.size }

pub fn math_special_legendre_edge_get(s : MathspeciallegendreEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_edge_set(s : MathspeciallegendreEdge, i : Int, v : Double) -> MathspeciallegendreEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_edge_sum(s : MathspeciallegendreEdge) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_edge_mean(s : MathspeciallegendreEdge) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_edge_scale(s : MathspeciallegendreEdge, f : Double) -> MathspeciallegendreEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_edge_add(a : MathspeciallegendreEdge, b : MathspeciallegendreEdge) -> MathspeciallegendreEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_edge_copy(s : MathspeciallegendreEdge) -> MathspeciallegendreEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_edge_fill(s : MathspeciallegendreEdge, v : Double) -> MathspeciallegendreEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_edge_min(s : MathspeciallegendreEdge) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_edge_max(s : MathspeciallegendreEdge) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_edge_to_string(s : MathspeciallegendreEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendrePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_path_make(size : Int) -> MathspeciallegendrePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_path_len(s : MathspeciallegendrePath) -> Int { s.size }

pub fn math_special_legendre_path_get(s : MathspeciallegendrePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_path_set(s : MathspeciallegendrePath, i : Int, v : Double) -> MathspeciallegendrePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_path_sum(s : MathspeciallegendrePath) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_path_mean(s : MathspeciallegendrePath) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_path_scale(s : MathspeciallegendrePath, f : Double) -> MathspeciallegendrePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_path_add(a : MathspeciallegendrePath, b : MathspeciallegendrePath) -> MathspeciallegendrePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_path_copy(s : MathspeciallegendrePath) -> MathspeciallegendrePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_path_fill(s : MathspeciallegendrePath, v : Double) -> MathspeciallegendrePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_path_min(s : MathspeciallegendrePath) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_path_max(s : MathspeciallegendrePath) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_path_to_string(s : MathspeciallegendrePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_cluster_make(size : Int) -> MathspeciallegendreCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_cluster_len(s : MathspeciallegendreCluster) -> Int { s.size }

pub fn math_special_legendre_cluster_get(s : MathspeciallegendreCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_cluster_set(s : MathspeciallegendreCluster, i : Int, v : Double) -> MathspeciallegendreCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_cluster_sum(s : MathspeciallegendreCluster) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_cluster_mean(s : MathspeciallegendreCluster) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_cluster_scale(s : MathspeciallegendreCluster, f : Double) -> MathspeciallegendreCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_cluster_add(a : MathspeciallegendreCluster, b : MathspeciallegendreCluster) -> MathspeciallegendreCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_cluster_copy(s : MathspeciallegendreCluster) -> MathspeciallegendreCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_cluster_fill(s : MathspeciallegendreCluster, v : Double) -> MathspeciallegendreCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_cluster_min(s : MathspeciallegendreCluster) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_cluster_max(s : MathspeciallegendreCluster) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_cluster_to_string(s : MathspeciallegendreCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_model_make(size : Int) -> MathspeciallegendreModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_model_len(s : MathspeciallegendreModel) -> Int { s.size }

pub fn math_special_legendre_model_get(s : MathspeciallegendreModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_model_set(s : MathspeciallegendreModel, i : Int, v : Double) -> MathspeciallegendreModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_model_sum(s : MathspeciallegendreModel) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_model_mean(s : MathspeciallegendreModel) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_model_scale(s : MathspeciallegendreModel, f : Double) -> MathspeciallegendreModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_model_add(a : MathspeciallegendreModel, b : MathspeciallegendreModel) -> MathspeciallegendreModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_model_copy(s : MathspeciallegendreModel) -> MathspeciallegendreModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_model_fill(s : MathspeciallegendreModel, v : Double) -> MathspeciallegendreModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_model_min(s : MathspeciallegendreModel) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_model_max(s : MathspeciallegendreModel) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_model_to_string(s : MathspeciallegendreModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_layer_make(size : Int) -> MathspeciallegendreLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_layer_len(s : MathspeciallegendreLayer) -> Int { s.size }

pub fn math_special_legendre_layer_get(s : MathspeciallegendreLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_layer_set(s : MathspeciallegendreLayer, i : Int, v : Double) -> MathspeciallegendreLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_layer_sum(s : MathspeciallegendreLayer) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_layer_mean(s : MathspeciallegendreLayer) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_layer_scale(s : MathspeciallegendreLayer, f : Double) -> MathspeciallegendreLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_layer_add(a : MathspeciallegendreLayer, b : MathspeciallegendreLayer) -> MathspeciallegendreLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_layer_copy(s : MathspeciallegendreLayer) -> MathspeciallegendreLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_layer_fill(s : MathspeciallegendreLayer, v : Double) -> MathspeciallegendreLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_layer_min(s : MathspeciallegendreLayer) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_layer_max(s : MathspeciallegendreLayer) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_layer_to_string(s : MathspeciallegendreLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_buffer_make(size : Int) -> MathspeciallegendreBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_buffer_len(s : MathspeciallegendreBuffer) -> Int { s.size }

pub fn math_special_legendre_buffer_get(s : MathspeciallegendreBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_buffer_set(s : MathspeciallegendreBuffer, i : Int, v : Double) -> MathspeciallegendreBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_buffer_sum(s : MathspeciallegendreBuffer) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_buffer_mean(s : MathspeciallegendreBuffer) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_buffer_scale(s : MathspeciallegendreBuffer, f : Double) -> MathspeciallegendreBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_buffer_add(a : MathspeciallegendreBuffer, b : MathspeciallegendreBuffer) -> MathspeciallegendreBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_buffer_copy(s : MathspeciallegendreBuffer) -> MathspeciallegendreBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_buffer_fill(s : MathspeciallegendreBuffer, v : Double) -> MathspeciallegendreBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_buffer_min(s : MathspeciallegendreBuffer) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_buffer_max(s : MathspeciallegendreBuffer) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_buffer_to_string(s : MathspeciallegendreBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_cursor_make(size : Int) -> MathspeciallegendreCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_cursor_len(s : MathspeciallegendreCursor) -> Int { s.size }

pub fn math_special_legendre_cursor_get(s : MathspeciallegendreCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_cursor_set(s : MathspeciallegendreCursor, i : Int, v : Double) -> MathspeciallegendreCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_cursor_sum(s : MathspeciallegendreCursor) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_cursor_mean(s : MathspeciallegendreCursor) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_cursor_scale(s : MathspeciallegendreCursor, f : Double) -> MathspeciallegendreCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_cursor_add(a : MathspeciallegendreCursor, b : MathspeciallegendreCursor) -> MathspeciallegendreCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_cursor_copy(s : MathspeciallegendreCursor) -> MathspeciallegendreCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_cursor_fill(s : MathspeciallegendreCursor, v : Double) -> MathspeciallegendreCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_cursor_min(s : MathspeciallegendreCursor) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_cursor_max(s : MathspeciallegendreCursor) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_cursor_to_string(s : MathspeciallegendreCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_view_make(size : Int) -> MathspeciallegendreView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_view_len(s : MathspeciallegendreView) -> Int { s.size }

pub fn math_special_legendre_view_get(s : MathspeciallegendreView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_view_set(s : MathspeciallegendreView, i : Int, v : Double) -> MathspeciallegendreView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_view_sum(s : MathspeciallegendreView) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_view_mean(s : MathspeciallegendreView) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_view_scale(s : MathspeciallegendreView, f : Double) -> MathspeciallegendreView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_view_add(a : MathspeciallegendreView, b : MathspeciallegendreView) -> MathspeciallegendreView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_view_copy(s : MathspeciallegendreView) -> MathspeciallegendreView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_view_fill(s : MathspeciallegendreView, v : Double) -> MathspeciallegendreView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_view_min(s : MathspeciallegendreView) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_view_max(s : MathspeciallegendreView) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_view_to_string(s : MathspeciallegendreView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_range_make(size : Int) -> MathspeciallegendreRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_range_len(s : MathspeciallegendreRange) -> Int { s.size }

pub fn math_special_legendre_range_get(s : MathspeciallegendreRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_range_set(s : MathspeciallegendreRange, i : Int, v : Double) -> MathspeciallegendreRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_range_sum(s : MathspeciallegendreRange) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_range_mean(s : MathspeciallegendreRange) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_range_scale(s : MathspeciallegendreRange, f : Double) -> MathspeciallegendreRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_range_add(a : MathspeciallegendreRange, b : MathspeciallegendreRange) -> MathspeciallegendreRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_range_copy(s : MathspeciallegendreRange) -> MathspeciallegendreRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_range_fill(s : MathspeciallegendreRange, v : Double) -> MathspeciallegendreRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_range_min(s : MathspeciallegendreRange) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_range_max(s : MathspeciallegendreRange) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_range_to_string(s : MathspeciallegendreRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_slice_make(size : Int) -> MathspeciallegendreSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_slice_len(s : MathspeciallegendreSlice) -> Int { s.size }

pub fn math_special_legendre_slice_get(s : MathspeciallegendreSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_slice_set(s : MathspeciallegendreSlice, i : Int, v : Double) -> MathspeciallegendreSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_slice_sum(s : MathspeciallegendreSlice) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_slice_mean(s : MathspeciallegendreSlice) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_slice_scale(s : MathspeciallegendreSlice, f : Double) -> MathspeciallegendreSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_slice_add(a : MathspeciallegendreSlice, b : MathspeciallegendreSlice) -> MathspeciallegendreSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_slice_copy(s : MathspeciallegendreSlice) -> MathspeciallegendreSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_slice_fill(s : MathspeciallegendreSlice, v : Double) -> MathspeciallegendreSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_slice_min(s : MathspeciallegendreSlice) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_slice_max(s : MathspeciallegendreSlice) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_slice_to_string(s : MathspeciallegendreSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

