///===
/// extcore/math_special_laguerre

pub(all) struct MathspeciallaguerrePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_laguerre_make_point(x : Double, y : Double) -> MathspeciallaguerrePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_laguerre_make_point3(x : Double, y : Double, z : Double) -> MathspeciallaguerrePoint {
  { x, y, z, label: 0 }
}

pub fn math_special_laguerre_point_x(pt : MathspeciallaguerrePoint) -> Double { pt.x }

pub fn math_special_laguerre_point_y(pt : MathspeciallaguerrePoint) -> Double { pt.y }

pub fn math_special_laguerre_point_z(pt : MathspeciallaguerrePoint) -> Double { pt.z }

pub fn math_special_laguerre_point_label(pt : MathspeciallaguerrePoint) -> Int { pt.label }

pub fn math_special_laguerre_point_dist(a : MathspeciallaguerrePoint, b : MathspeciallaguerrePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_special_laguerre_point_add(a : MathspeciallaguerrePoint, b : MathspeciallaguerrePoint) -> MathspeciallaguerrePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_special_laguerre_point_sub(a : MathspeciallaguerrePoint, b : MathspeciallaguerrePoint) -> MathspeciallaguerrePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_special_laguerre_point_scale(pt : MathspeciallaguerrePoint, s : Double) -> MathspeciallaguerrePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_special_laguerre_point_dot(a : MathspeciallaguerrePoint, b : MathspeciallaguerrePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_special_laguerre_point_cross(a : MathspeciallaguerrePoint, b : MathspeciallaguerrePoint) -> MathspeciallaguerrePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_special_laguerre_point_norm(pt : MathspeciallaguerrePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_special_laguerre_point_normalize(pt : MathspeciallaguerrePoint) -> MathspeciallaguerrePoint {
  let n = math_special_laguerre_point_norm(pt)
  if n < 0.0000001 { pt } else { math_special_laguerre_point_scale(pt, 1.0 / n) }
}

pub fn math_special_laguerre_point_negate(pt : MathspeciallaguerrePoint) -> MathspeciallaguerrePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_special_laguerre_point_mid(a : MathspeciallaguerrePoint, b : MathspeciallaguerrePoint) -> MathspeciallaguerrePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_special_laguerre_point_lerp(a : MathspeciallaguerrePoint, b : MathspeciallaguerrePoint, t : Double) -> MathspeciallaguerrePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_special_laguerre_point_to_string(pt : MathspeciallaguerrePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathspeciallaguerreSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_laguerre_make_series(vals : Array[Double], name : String) -> MathspeciallaguerreSeries {
  { vals, name, meta: 0 }
}

pub fn math_special_laguerre_series_len(s : MathspeciallaguerreSeries) -> Int { s.vals.length() }

pub fn math_special_laguerre_series_sum(s : MathspeciallaguerreSeries) -> Double { @_common.sum(s.vals) }

pub fn math_special_laguerre_series_mean(s : MathspeciallaguerreSeries) -> Double { @_common.mean(s.vals) }

pub fn math_special_laguerre_series_min(s : MathspeciallaguerreSeries) -> Double { @_common.min(s.vals) }

pub fn math_special_laguerre_series_max(s : MathspeciallaguerreSeries) -> Double { @_common.max(s.vals) }

pub fn math_special_laguerre_series_range(s : MathspeciallaguerreSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn math_special_laguerre_series_var(s : MathspeciallaguerreSeries) -> Double { @_common.variance(s.vals) }

pub fn math_special_laguerre_series_std(s : MathspeciallaguerreSeries) -> Double { @_common.std(s.vals) }

pub fn math_special_laguerre_series_median(s : MathspeciallaguerreSeries) -> Double { @_common.median(s.vals) }

pub fn math_special_laguerre_series_scale(s : MathspeciallaguerreSeries, f : Double) -> MathspeciallaguerreSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn math_special_laguerre_series_add(a : MathspeciallaguerreSeries, b : MathspeciallaguerreSeries) -> MathspeciallaguerreSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_special_laguerre_series_sub(a : MathspeciallaguerreSeries, b : MathspeciallaguerreSeries) -> MathspeciallaguerreSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_special_laguerre_series_normalize(s : MathspeciallaguerreSeries) -> MathspeciallaguerreSeries {
  let mn = math_special_laguerre_series_min(s)
  let mx = math_special_laguerre_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_special_laguerre_series_cumsum(s : MathspeciallaguerreSeries) -> MathspeciallaguerreSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_special_laguerre_series_to_string(s : MathspeciallaguerreSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspeciallaguerreMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_laguerre_make_matrix(rows : Int, cols : Int, val : Double) -> MathspeciallaguerreMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_laguerre_matrix_identity(n : Int) -> MathspeciallaguerreMatrix {
  let m = math_special_laguerre_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_special_laguerre_matrix_get(m : MathspeciallaguerreMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_special_laguerre_matrix_transpose(m : MathspeciallaguerreMatrix) -> MathspeciallaguerreMatrix {
  let result = math_special_laguerre_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_special_laguerre_matrix_add(a : MathspeciallaguerreMatrix, b : MathspeciallaguerreMatrix) -> MathspeciallaguerreMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_special_laguerre_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_special_laguerre_matrix_scale(m : MathspeciallaguerreMatrix, s : Double) -> MathspeciallaguerreMatrix {
  let result = math_special_laguerre_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_special_laguerre_matrix_multiply(a : MathspeciallaguerreMatrix, b : MathspeciallaguerreMatrix) -> MathspeciallaguerreMatrix {
  if a.cols != b.rows { return math_special_laguerre_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_special_laguerre_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_special_laguerre_matrix_trace(m : MathspeciallaguerreMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_special_laguerre_matrix_det(m : MathspeciallaguerreMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_special_laguerre_matrix_norm(m : MathspeciallaguerreMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_special_laguerre_matrix_to_string(m : MathspeciallaguerreMatrix) -> String {
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

pub(all) struct MathspeciallaguerreVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_laguerre_make_vector(comps : Array[Double]) -> MathspeciallaguerreVector {
  { comps, dim: comps.length() }
}

pub fn math_special_laguerre_vector_zero(dim : Int) -> MathspeciallaguerreVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_special_laguerre_vector_add(a : MathspeciallaguerreVector, b : MathspeciallaguerreVector) -> MathspeciallaguerreVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn math_special_laguerre_vector_sub(a : MathspeciallaguerreVector, b : MathspeciallaguerreVector) -> MathspeciallaguerreVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn math_special_laguerre_vector_scale(v : MathspeciallaguerreVector, s : Double) -> MathspeciallaguerreVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn math_special_laguerre_vector_dot(a : MathspeciallaguerreVector, b : MathspeciallaguerreVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_special_laguerre_vector_norm(v : MathspeciallaguerreVector) -> Double { @_common.sqrt(math_special_laguerre_vector_dot(v, v)) }

pub fn math_special_laguerre_vector_normalize(v : MathspeciallaguerreVector) -> MathspeciallaguerreVector {
  let n = math_special_laguerre_vector_norm(v)
  if n < 0.0000001 { v } else { math_special_laguerre_vector_scale(v, 1.0 / n) }
}

pub fn math_special_laguerre_vector_dist(a : MathspeciallaguerreVector, b : MathspeciallaguerreVector) -> Double {
  math_special_laguerre_vector_norm(math_special_laguerre_vector_sub(a, b))
}

pub fn math_special_laguerre_vector_to_string(v : MathspeciallaguerreVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_laguerre_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_special_laguerre_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_special_laguerre_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_special_laguerre_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_special_laguerre_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_special_laguerre_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_special_laguerre_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_special_laguerre_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_special_laguerre_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_special_laguerre_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_special_laguerre_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_special_laguerre_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_special_laguerre_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_special_laguerre_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_special_laguerre_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_special_laguerre_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_special_laguerre_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_special_laguerre_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_special_laguerre_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_special_laguerre_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_special_laguerre_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_special_laguerre_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_special_laguerre_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_special_laguerre_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_special_laguerre_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_special_laguerre_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_special_laguerre_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_special_laguerre_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_special_laguerre_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathspeciallaguerreFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_frame_make(size : Int) -> MathspeciallaguerreFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_frame_len(s : MathspeciallaguerreFrame) -> Int { s.size }

pub fn math_special_laguerre_frame_get(s : MathspeciallaguerreFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_frame_set(s : MathspeciallaguerreFrame, i : Int, v : Double) -> MathspeciallaguerreFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_frame_sum(s : MathspeciallaguerreFrame) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_frame_mean(s : MathspeciallaguerreFrame) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_frame_scale(s : MathspeciallaguerreFrame, f : Double) -> MathspeciallaguerreFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_frame_add(a : MathspeciallaguerreFrame, b : MathspeciallaguerreFrame) -> MathspeciallaguerreFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_frame_copy(s : MathspeciallaguerreFrame) -> MathspeciallaguerreFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_frame_fill(s : MathspeciallaguerreFrame, v : Double) -> MathspeciallaguerreFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_frame_min(s : MathspeciallaguerreFrame) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_frame_max(s : MathspeciallaguerreFrame) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_frame_to_string(s : MathspeciallaguerreFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_table_make(size : Int) -> MathspeciallaguerreTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_table_len(s : MathspeciallaguerreTable) -> Int { s.size }

pub fn math_special_laguerre_table_get(s : MathspeciallaguerreTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_table_set(s : MathspeciallaguerreTable, i : Int, v : Double) -> MathspeciallaguerreTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_table_sum(s : MathspeciallaguerreTable) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_table_mean(s : MathspeciallaguerreTable) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_table_scale(s : MathspeciallaguerreTable, f : Double) -> MathspeciallaguerreTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_table_add(a : MathspeciallaguerreTable, b : MathspeciallaguerreTable) -> MathspeciallaguerreTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_table_copy(s : MathspeciallaguerreTable) -> MathspeciallaguerreTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_table_fill(s : MathspeciallaguerreTable, v : Double) -> MathspeciallaguerreTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_table_min(s : MathspeciallaguerreTable) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_table_max(s : MathspeciallaguerreTable) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_table_to_string(s : MathspeciallaguerreTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_graphn_make(size : Int) -> MathspeciallaguerreGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_graphn_len(s : MathspeciallaguerreGraphN) -> Int { s.size }

pub fn math_special_laguerre_graphn_get(s : MathspeciallaguerreGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_graphn_set(s : MathspeciallaguerreGraphN, i : Int, v : Double) -> MathspeciallaguerreGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_graphn_sum(s : MathspeciallaguerreGraphN) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_graphn_mean(s : MathspeciallaguerreGraphN) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_graphn_scale(s : MathspeciallaguerreGraphN, f : Double) -> MathspeciallaguerreGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_graphn_add(a : MathspeciallaguerreGraphN, b : MathspeciallaguerreGraphN) -> MathspeciallaguerreGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_graphn_copy(s : MathspeciallaguerreGraphN) -> MathspeciallaguerreGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_graphn_fill(s : MathspeciallaguerreGraphN, v : Double) -> MathspeciallaguerreGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_graphn_min(s : MathspeciallaguerreGraphN) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_graphn_max(s : MathspeciallaguerreGraphN) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_graphn_to_string(s : MathspeciallaguerreGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_node_make(size : Int) -> MathspeciallaguerreNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_node_len(s : MathspeciallaguerreNode) -> Int { s.size }

pub fn math_special_laguerre_node_get(s : MathspeciallaguerreNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_node_set(s : MathspeciallaguerreNode, i : Int, v : Double) -> MathspeciallaguerreNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_node_sum(s : MathspeciallaguerreNode) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_node_mean(s : MathspeciallaguerreNode) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_node_scale(s : MathspeciallaguerreNode, f : Double) -> MathspeciallaguerreNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_node_add(a : MathspeciallaguerreNode, b : MathspeciallaguerreNode) -> MathspeciallaguerreNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_node_copy(s : MathspeciallaguerreNode) -> MathspeciallaguerreNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_node_fill(s : MathspeciallaguerreNode, v : Double) -> MathspeciallaguerreNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_node_min(s : MathspeciallaguerreNode) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_node_max(s : MathspeciallaguerreNode) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_node_to_string(s : MathspeciallaguerreNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_edge_make(size : Int) -> MathspeciallaguerreEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_edge_len(s : MathspeciallaguerreEdge) -> Int { s.size }

pub fn math_special_laguerre_edge_get(s : MathspeciallaguerreEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_edge_set(s : MathspeciallaguerreEdge, i : Int, v : Double) -> MathspeciallaguerreEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_edge_sum(s : MathspeciallaguerreEdge) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_edge_mean(s : MathspeciallaguerreEdge) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_edge_scale(s : MathspeciallaguerreEdge, f : Double) -> MathspeciallaguerreEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_edge_add(a : MathspeciallaguerreEdge, b : MathspeciallaguerreEdge) -> MathspeciallaguerreEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_edge_copy(s : MathspeciallaguerreEdge) -> MathspeciallaguerreEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_edge_fill(s : MathspeciallaguerreEdge, v : Double) -> MathspeciallaguerreEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_edge_min(s : MathspeciallaguerreEdge) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_edge_max(s : MathspeciallaguerreEdge) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_edge_to_string(s : MathspeciallaguerreEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerrePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_path_make(size : Int) -> MathspeciallaguerrePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_path_len(s : MathspeciallaguerrePath) -> Int { s.size }

pub fn math_special_laguerre_path_get(s : MathspeciallaguerrePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_path_set(s : MathspeciallaguerrePath, i : Int, v : Double) -> MathspeciallaguerrePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_path_sum(s : MathspeciallaguerrePath) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_path_mean(s : MathspeciallaguerrePath) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_path_scale(s : MathspeciallaguerrePath, f : Double) -> MathspeciallaguerrePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_path_add(a : MathspeciallaguerrePath, b : MathspeciallaguerrePath) -> MathspeciallaguerrePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_path_copy(s : MathspeciallaguerrePath) -> MathspeciallaguerrePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_path_fill(s : MathspeciallaguerrePath, v : Double) -> MathspeciallaguerrePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_path_min(s : MathspeciallaguerrePath) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_path_max(s : MathspeciallaguerrePath) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_path_to_string(s : MathspeciallaguerrePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_cluster_make(size : Int) -> MathspeciallaguerreCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_cluster_len(s : MathspeciallaguerreCluster) -> Int { s.size }

pub fn math_special_laguerre_cluster_get(s : MathspeciallaguerreCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_cluster_set(s : MathspeciallaguerreCluster, i : Int, v : Double) -> MathspeciallaguerreCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_cluster_sum(s : MathspeciallaguerreCluster) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_cluster_mean(s : MathspeciallaguerreCluster) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_cluster_scale(s : MathspeciallaguerreCluster, f : Double) -> MathspeciallaguerreCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_cluster_add(a : MathspeciallaguerreCluster, b : MathspeciallaguerreCluster) -> MathspeciallaguerreCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_cluster_copy(s : MathspeciallaguerreCluster) -> MathspeciallaguerreCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_cluster_fill(s : MathspeciallaguerreCluster, v : Double) -> MathspeciallaguerreCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_cluster_min(s : MathspeciallaguerreCluster) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_cluster_max(s : MathspeciallaguerreCluster) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_cluster_to_string(s : MathspeciallaguerreCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_model_make(size : Int) -> MathspeciallaguerreModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_model_len(s : MathspeciallaguerreModel) -> Int { s.size }

pub fn math_special_laguerre_model_get(s : MathspeciallaguerreModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_model_set(s : MathspeciallaguerreModel, i : Int, v : Double) -> MathspeciallaguerreModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_model_sum(s : MathspeciallaguerreModel) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_model_mean(s : MathspeciallaguerreModel) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_model_scale(s : MathspeciallaguerreModel, f : Double) -> MathspeciallaguerreModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_model_add(a : MathspeciallaguerreModel, b : MathspeciallaguerreModel) -> MathspeciallaguerreModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_model_copy(s : MathspeciallaguerreModel) -> MathspeciallaguerreModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_model_fill(s : MathspeciallaguerreModel, v : Double) -> MathspeciallaguerreModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_model_min(s : MathspeciallaguerreModel) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_model_max(s : MathspeciallaguerreModel) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_model_to_string(s : MathspeciallaguerreModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_layer_make(size : Int) -> MathspeciallaguerreLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_layer_len(s : MathspeciallaguerreLayer) -> Int { s.size }

pub fn math_special_laguerre_layer_get(s : MathspeciallaguerreLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_layer_set(s : MathspeciallaguerreLayer, i : Int, v : Double) -> MathspeciallaguerreLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_layer_sum(s : MathspeciallaguerreLayer) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_layer_mean(s : MathspeciallaguerreLayer) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_layer_scale(s : MathspeciallaguerreLayer, f : Double) -> MathspeciallaguerreLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_layer_add(a : MathspeciallaguerreLayer, b : MathspeciallaguerreLayer) -> MathspeciallaguerreLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_layer_copy(s : MathspeciallaguerreLayer) -> MathspeciallaguerreLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_layer_fill(s : MathspeciallaguerreLayer, v : Double) -> MathspeciallaguerreLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_layer_min(s : MathspeciallaguerreLayer) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_layer_max(s : MathspeciallaguerreLayer) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_layer_to_string(s : MathspeciallaguerreLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_buffer_make(size : Int) -> MathspeciallaguerreBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_buffer_len(s : MathspeciallaguerreBuffer) -> Int { s.size }

pub fn math_special_laguerre_buffer_get(s : MathspeciallaguerreBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_buffer_set(s : MathspeciallaguerreBuffer, i : Int, v : Double) -> MathspeciallaguerreBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_buffer_sum(s : MathspeciallaguerreBuffer) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_buffer_mean(s : MathspeciallaguerreBuffer) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_buffer_scale(s : MathspeciallaguerreBuffer, f : Double) -> MathspeciallaguerreBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_buffer_add(a : MathspeciallaguerreBuffer, b : MathspeciallaguerreBuffer) -> MathspeciallaguerreBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_buffer_copy(s : MathspeciallaguerreBuffer) -> MathspeciallaguerreBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_buffer_fill(s : MathspeciallaguerreBuffer, v : Double) -> MathspeciallaguerreBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_buffer_min(s : MathspeciallaguerreBuffer) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_buffer_max(s : MathspeciallaguerreBuffer) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_buffer_to_string(s : MathspeciallaguerreBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_cursor_make(size : Int) -> MathspeciallaguerreCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_cursor_len(s : MathspeciallaguerreCursor) -> Int { s.size }

pub fn math_special_laguerre_cursor_get(s : MathspeciallaguerreCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_cursor_set(s : MathspeciallaguerreCursor, i : Int, v : Double) -> MathspeciallaguerreCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_cursor_sum(s : MathspeciallaguerreCursor) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_cursor_mean(s : MathspeciallaguerreCursor) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_cursor_scale(s : MathspeciallaguerreCursor, f : Double) -> MathspeciallaguerreCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_cursor_add(a : MathspeciallaguerreCursor, b : MathspeciallaguerreCursor) -> MathspeciallaguerreCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_cursor_copy(s : MathspeciallaguerreCursor) -> MathspeciallaguerreCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_cursor_fill(s : MathspeciallaguerreCursor, v : Double) -> MathspeciallaguerreCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_cursor_min(s : MathspeciallaguerreCursor) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_cursor_max(s : MathspeciallaguerreCursor) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_cursor_to_string(s : MathspeciallaguerreCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_view_make(size : Int) -> MathspeciallaguerreView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_view_len(s : MathspeciallaguerreView) -> Int { s.size }

pub fn math_special_laguerre_view_get(s : MathspeciallaguerreView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_view_set(s : MathspeciallaguerreView, i : Int, v : Double) -> MathspeciallaguerreView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_view_sum(s : MathspeciallaguerreView) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_view_mean(s : MathspeciallaguerreView) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_view_scale(s : MathspeciallaguerreView, f : Double) -> MathspeciallaguerreView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_view_add(a : MathspeciallaguerreView, b : MathspeciallaguerreView) -> MathspeciallaguerreView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_view_copy(s : MathspeciallaguerreView) -> MathspeciallaguerreView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_view_fill(s : MathspeciallaguerreView, v : Double) -> MathspeciallaguerreView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_view_min(s : MathspeciallaguerreView) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_view_max(s : MathspeciallaguerreView) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_view_to_string(s : MathspeciallaguerreView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_range_make(size : Int) -> MathspeciallaguerreRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_range_len(s : MathspeciallaguerreRange) -> Int { s.size }

pub fn math_special_laguerre_range_get(s : MathspeciallaguerreRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_range_set(s : MathspeciallaguerreRange, i : Int, v : Double) -> MathspeciallaguerreRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_range_sum(s : MathspeciallaguerreRange) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_range_mean(s : MathspeciallaguerreRange) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_range_scale(s : MathspeciallaguerreRange, f : Double) -> MathspeciallaguerreRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_range_add(a : MathspeciallaguerreRange, b : MathspeciallaguerreRange) -> MathspeciallaguerreRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_range_copy(s : MathspeciallaguerreRange) -> MathspeciallaguerreRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_range_fill(s : MathspeciallaguerreRange, v : Double) -> MathspeciallaguerreRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_range_min(s : MathspeciallaguerreRange) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_range_max(s : MathspeciallaguerreRange) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_range_to_string(s : MathspeciallaguerreRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_slice_make(size : Int) -> MathspeciallaguerreSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_slice_len(s : MathspeciallaguerreSlice) -> Int { s.size }

pub fn math_special_laguerre_slice_get(s : MathspeciallaguerreSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_slice_set(s : MathspeciallaguerreSlice, i : Int, v : Double) -> MathspeciallaguerreSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_slice_sum(s : MathspeciallaguerreSlice) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_slice_mean(s : MathspeciallaguerreSlice) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_slice_scale(s : MathspeciallaguerreSlice, f : Double) -> MathspeciallaguerreSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_slice_add(a : MathspeciallaguerreSlice, b : MathspeciallaguerreSlice) -> MathspeciallaguerreSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_slice_copy(s : MathspeciallaguerreSlice) -> MathspeciallaguerreSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_slice_fill(s : MathspeciallaguerreSlice, v : Double) -> MathspeciallaguerreSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_slice_min(s : MathspeciallaguerreSlice) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_slice_max(s : MathspeciallaguerreSlice) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_slice_to_string(s : MathspeciallaguerreSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

