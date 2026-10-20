///===
/// extcore/ml_neural_gru

pub(all) struct MlneuralgruPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_gru_make_point(x : Double, y : Double) -> MlneuralgruPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_gru_make_point3(x : Double, y : Double, z : Double) -> MlneuralgruPoint {
  { x, y, z, label: 0 }
}

pub fn ml_neural_gru_point_x(pt : MlneuralgruPoint) -> Double { pt.x }

pub fn ml_neural_gru_point_y(pt : MlneuralgruPoint) -> Double { pt.y }

pub fn ml_neural_gru_point_z(pt : MlneuralgruPoint) -> Double { pt.z }

pub fn ml_neural_gru_point_label(pt : MlneuralgruPoint) -> Int { pt.label }

pub fn ml_neural_gru_point_dist(a : MlneuralgruPoint, b : MlneuralgruPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_neural_gru_point_add(a : MlneuralgruPoint, b : MlneuralgruPoint) -> MlneuralgruPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_neural_gru_point_sub(a : MlneuralgruPoint, b : MlneuralgruPoint) -> MlneuralgruPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_neural_gru_point_scale(pt : MlneuralgruPoint, s : Double) -> MlneuralgruPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_neural_gru_point_dot(a : MlneuralgruPoint, b : MlneuralgruPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_neural_gru_point_cross(a : MlneuralgruPoint, b : MlneuralgruPoint) -> MlneuralgruPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_neural_gru_point_norm(pt : MlneuralgruPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_neural_gru_point_normalize(pt : MlneuralgruPoint) -> MlneuralgruPoint {
  let n = ml_neural_gru_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_neural_gru_point_scale(pt, 1.0 / n) }
}

pub fn ml_neural_gru_point_negate(pt : MlneuralgruPoint) -> MlneuralgruPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_neural_gru_point_mid(a : MlneuralgruPoint, b : MlneuralgruPoint) -> MlneuralgruPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_neural_gru_point_lerp(a : MlneuralgruPoint, b : MlneuralgruPoint, t : Double) -> MlneuralgruPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_neural_gru_point_to_string(pt : MlneuralgruPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlneuralgruSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_gru_make_series(vals : Array[Double], name : String) -> MlneuralgruSeries {
  { vals, name, meta: 0 }
}

pub fn ml_neural_gru_series_len(s : MlneuralgruSeries) -> Int { s.vals.length() }

pub fn ml_neural_gru_series_sum(s : MlneuralgruSeries) -> Double { @_common.sum(s.vals) }

pub fn ml_neural_gru_series_mean(s : MlneuralgruSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_neural_gru_series_min(s : MlneuralgruSeries) -> Double { @_common.min(s.vals) }

pub fn ml_neural_gru_series_max(s : MlneuralgruSeries) -> Double { @_common.max(s.vals) }

pub fn ml_neural_gru_series_range(s : MlneuralgruSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_neural_gru_series_var(s : MlneuralgruSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_neural_gru_series_std(s : MlneuralgruSeries) -> Double { @_common.std(s.vals) }

pub fn ml_neural_gru_series_median(s : MlneuralgruSeries) -> Double { @_common.median(s.vals) }

pub fn ml_neural_gru_series_scale(s : MlneuralgruSeries, f : Double) -> MlneuralgruSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn ml_neural_gru_series_add(a : MlneuralgruSeries, b : MlneuralgruSeries) -> MlneuralgruSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_neural_gru_series_sub(a : MlneuralgruSeries, b : MlneuralgruSeries) -> MlneuralgruSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_neural_gru_series_normalize(s : MlneuralgruSeries) -> MlneuralgruSeries {
  let mn = ml_neural_gru_series_min(s)
  let mx = ml_neural_gru_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_neural_gru_series_cumsum(s : MlneuralgruSeries) -> MlneuralgruSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_neural_gru_series_to_string(s : MlneuralgruSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuralgruMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_gru_make_matrix(rows : Int, cols : Int, val : Double) -> MlneuralgruMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_neural_gru_matrix_identity(n : Int) -> MlneuralgruMatrix {
  let m = ml_neural_gru_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_neural_gru_matrix_get(m : MlneuralgruMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_neural_gru_matrix_transpose(m : MlneuralgruMatrix) -> MlneuralgruMatrix {
  let result = ml_neural_gru_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_neural_gru_matrix_add(a : MlneuralgruMatrix, b : MlneuralgruMatrix) -> MlneuralgruMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_neural_gru_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_neural_gru_matrix_scale(m : MlneuralgruMatrix, s : Double) -> MlneuralgruMatrix {
  let result = ml_neural_gru_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_neural_gru_matrix_multiply(a : MlneuralgruMatrix, b : MlneuralgruMatrix) -> MlneuralgruMatrix {
  if a.cols != b.rows { return ml_neural_gru_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_neural_gru_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_neural_gru_matrix_trace(m : MlneuralgruMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_neural_gru_matrix_det(m : MlneuralgruMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_neural_gru_matrix_norm(m : MlneuralgruMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_neural_gru_matrix_to_string(m : MlneuralgruMatrix) -> String {
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

pub(all) struct MlneuralgruVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_gru_make_vector(comps : Array[Double]) -> MlneuralgruVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_gru_vector_zero(dim : Int) -> MlneuralgruVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_neural_gru_vector_add(a : MlneuralgruVector, b : MlneuralgruVector) -> MlneuralgruVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn ml_neural_gru_vector_sub(a : MlneuralgruVector, b : MlneuralgruVector) -> MlneuralgruVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn ml_neural_gru_vector_scale(v : MlneuralgruVector, s : Double) -> MlneuralgruVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn ml_neural_gru_vector_dot(a : MlneuralgruVector, b : MlneuralgruVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_neural_gru_vector_norm(v : MlneuralgruVector) -> Double { @_common.sqrt(ml_neural_gru_vector_dot(v, v)) }

pub fn ml_neural_gru_vector_normalize(v : MlneuralgruVector) -> MlneuralgruVector {
  let n = ml_neural_gru_vector_norm(v)
  if n < 0.0000001 { v } else { ml_neural_gru_vector_scale(v, 1.0 / n) }
}

pub fn ml_neural_gru_vector_dist(a : MlneuralgruVector, b : MlneuralgruVector) -> Double {
  ml_neural_gru_vector_norm(ml_neural_gru_vector_sub(a, b))
}

pub fn ml_neural_gru_vector_to_string(v : MlneuralgruVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_neural_gru_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_neural_gru_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_neural_gru_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_neural_gru_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_neural_gru_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_neural_gru_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_neural_gru_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_neural_gru_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_neural_gru_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_neural_gru_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_neural_gru_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_neural_gru_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_neural_gru_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_neural_gru_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_neural_gru_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_neural_gru_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_neural_gru_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_neural_gru_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_neural_gru_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_neural_gru_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_neural_gru_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_neural_gru_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_neural_gru_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_neural_gru_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_neural_gru_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_neural_gru_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_neural_gru_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_neural_gru_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_neural_gru_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlneuralgruFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_frame_make(size : Int) -> MlneuralgruFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_frame_len(s : MlneuralgruFrame) -> Int { s.size }

pub fn ml_neural_gru_frame_get(s : MlneuralgruFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_frame_set(s : MlneuralgruFrame, i : Int, v : Double) -> MlneuralgruFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_frame_sum(s : MlneuralgruFrame) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_frame_mean(s : MlneuralgruFrame) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_frame_scale(s : MlneuralgruFrame, f : Double) -> MlneuralgruFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_frame_add(a : MlneuralgruFrame, b : MlneuralgruFrame) -> MlneuralgruFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_frame_copy(s : MlneuralgruFrame) -> MlneuralgruFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_frame_fill(s : MlneuralgruFrame, v : Double) -> MlneuralgruFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_frame_min(s : MlneuralgruFrame) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_frame_max(s : MlneuralgruFrame) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_frame_to_string(s : MlneuralgruFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_table_make(size : Int) -> MlneuralgruTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_table_len(s : MlneuralgruTable) -> Int { s.size }

pub fn ml_neural_gru_table_get(s : MlneuralgruTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_table_set(s : MlneuralgruTable, i : Int, v : Double) -> MlneuralgruTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_table_sum(s : MlneuralgruTable) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_table_mean(s : MlneuralgruTable) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_table_scale(s : MlneuralgruTable, f : Double) -> MlneuralgruTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_table_add(a : MlneuralgruTable, b : MlneuralgruTable) -> MlneuralgruTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_table_copy(s : MlneuralgruTable) -> MlneuralgruTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_table_fill(s : MlneuralgruTable, v : Double) -> MlneuralgruTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_table_min(s : MlneuralgruTable) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_table_max(s : MlneuralgruTable) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_table_to_string(s : MlneuralgruTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_graphn_make(size : Int) -> MlneuralgruGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_graphn_len(s : MlneuralgruGraphN) -> Int { s.size }

pub fn ml_neural_gru_graphn_get(s : MlneuralgruGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_graphn_set(s : MlneuralgruGraphN, i : Int, v : Double) -> MlneuralgruGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_graphn_sum(s : MlneuralgruGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_graphn_mean(s : MlneuralgruGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_graphn_scale(s : MlneuralgruGraphN, f : Double) -> MlneuralgruGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_graphn_add(a : MlneuralgruGraphN, b : MlneuralgruGraphN) -> MlneuralgruGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_graphn_copy(s : MlneuralgruGraphN) -> MlneuralgruGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_graphn_fill(s : MlneuralgruGraphN, v : Double) -> MlneuralgruGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_graphn_min(s : MlneuralgruGraphN) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_graphn_max(s : MlneuralgruGraphN) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_graphn_to_string(s : MlneuralgruGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_node_make(size : Int) -> MlneuralgruNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_node_len(s : MlneuralgruNode) -> Int { s.size }

pub fn ml_neural_gru_node_get(s : MlneuralgruNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_node_set(s : MlneuralgruNode, i : Int, v : Double) -> MlneuralgruNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_node_sum(s : MlneuralgruNode) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_node_mean(s : MlneuralgruNode) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_node_scale(s : MlneuralgruNode, f : Double) -> MlneuralgruNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_node_add(a : MlneuralgruNode, b : MlneuralgruNode) -> MlneuralgruNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_node_copy(s : MlneuralgruNode) -> MlneuralgruNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_node_fill(s : MlneuralgruNode, v : Double) -> MlneuralgruNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_node_min(s : MlneuralgruNode) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_node_max(s : MlneuralgruNode) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_node_to_string(s : MlneuralgruNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_edge_make(size : Int) -> MlneuralgruEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_edge_len(s : MlneuralgruEdge) -> Int { s.size }

pub fn ml_neural_gru_edge_get(s : MlneuralgruEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_edge_set(s : MlneuralgruEdge, i : Int, v : Double) -> MlneuralgruEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_edge_sum(s : MlneuralgruEdge) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_edge_mean(s : MlneuralgruEdge) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_edge_scale(s : MlneuralgruEdge, f : Double) -> MlneuralgruEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_edge_add(a : MlneuralgruEdge, b : MlneuralgruEdge) -> MlneuralgruEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_edge_copy(s : MlneuralgruEdge) -> MlneuralgruEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_edge_fill(s : MlneuralgruEdge, v : Double) -> MlneuralgruEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_edge_min(s : MlneuralgruEdge) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_edge_max(s : MlneuralgruEdge) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_edge_to_string(s : MlneuralgruEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_path_make(size : Int) -> MlneuralgruPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_path_len(s : MlneuralgruPath) -> Int { s.size }

pub fn ml_neural_gru_path_get(s : MlneuralgruPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_path_set(s : MlneuralgruPath, i : Int, v : Double) -> MlneuralgruPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_path_sum(s : MlneuralgruPath) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_path_mean(s : MlneuralgruPath) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_path_scale(s : MlneuralgruPath, f : Double) -> MlneuralgruPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_path_add(a : MlneuralgruPath, b : MlneuralgruPath) -> MlneuralgruPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_path_copy(s : MlneuralgruPath) -> MlneuralgruPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_path_fill(s : MlneuralgruPath, v : Double) -> MlneuralgruPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_path_min(s : MlneuralgruPath) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_path_max(s : MlneuralgruPath) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_path_to_string(s : MlneuralgruPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_cluster_make(size : Int) -> MlneuralgruCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_cluster_len(s : MlneuralgruCluster) -> Int { s.size }

pub fn ml_neural_gru_cluster_get(s : MlneuralgruCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_cluster_set(s : MlneuralgruCluster, i : Int, v : Double) -> MlneuralgruCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_cluster_sum(s : MlneuralgruCluster) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_cluster_mean(s : MlneuralgruCluster) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_cluster_scale(s : MlneuralgruCluster, f : Double) -> MlneuralgruCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_cluster_add(a : MlneuralgruCluster, b : MlneuralgruCluster) -> MlneuralgruCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_cluster_copy(s : MlneuralgruCluster) -> MlneuralgruCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_cluster_fill(s : MlneuralgruCluster, v : Double) -> MlneuralgruCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_cluster_min(s : MlneuralgruCluster) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_cluster_max(s : MlneuralgruCluster) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_cluster_to_string(s : MlneuralgruCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_model_make(size : Int) -> MlneuralgruModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_model_len(s : MlneuralgruModel) -> Int { s.size }

pub fn ml_neural_gru_model_get(s : MlneuralgruModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_model_set(s : MlneuralgruModel, i : Int, v : Double) -> MlneuralgruModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_model_sum(s : MlneuralgruModel) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_model_mean(s : MlneuralgruModel) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_model_scale(s : MlneuralgruModel, f : Double) -> MlneuralgruModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_model_add(a : MlneuralgruModel, b : MlneuralgruModel) -> MlneuralgruModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_model_copy(s : MlneuralgruModel) -> MlneuralgruModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_model_fill(s : MlneuralgruModel, v : Double) -> MlneuralgruModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_model_min(s : MlneuralgruModel) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_model_max(s : MlneuralgruModel) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_model_to_string(s : MlneuralgruModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_layer_make(size : Int) -> MlneuralgruLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_layer_len(s : MlneuralgruLayer) -> Int { s.size }

pub fn ml_neural_gru_layer_get(s : MlneuralgruLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_layer_set(s : MlneuralgruLayer, i : Int, v : Double) -> MlneuralgruLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_layer_sum(s : MlneuralgruLayer) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_layer_mean(s : MlneuralgruLayer) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_layer_scale(s : MlneuralgruLayer, f : Double) -> MlneuralgruLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_layer_add(a : MlneuralgruLayer, b : MlneuralgruLayer) -> MlneuralgruLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_layer_copy(s : MlneuralgruLayer) -> MlneuralgruLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_layer_fill(s : MlneuralgruLayer, v : Double) -> MlneuralgruLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_layer_min(s : MlneuralgruLayer) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_layer_max(s : MlneuralgruLayer) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_layer_to_string(s : MlneuralgruLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_buffer_make(size : Int) -> MlneuralgruBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_buffer_len(s : MlneuralgruBuffer) -> Int { s.size }

pub fn ml_neural_gru_buffer_get(s : MlneuralgruBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_buffer_set(s : MlneuralgruBuffer, i : Int, v : Double) -> MlneuralgruBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_buffer_sum(s : MlneuralgruBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_buffer_mean(s : MlneuralgruBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_buffer_scale(s : MlneuralgruBuffer, f : Double) -> MlneuralgruBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_buffer_add(a : MlneuralgruBuffer, b : MlneuralgruBuffer) -> MlneuralgruBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_buffer_copy(s : MlneuralgruBuffer) -> MlneuralgruBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_buffer_fill(s : MlneuralgruBuffer, v : Double) -> MlneuralgruBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_buffer_min(s : MlneuralgruBuffer) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_buffer_max(s : MlneuralgruBuffer) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_buffer_to_string(s : MlneuralgruBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_cursor_make(size : Int) -> MlneuralgruCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_cursor_len(s : MlneuralgruCursor) -> Int { s.size }

pub fn ml_neural_gru_cursor_get(s : MlneuralgruCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_cursor_set(s : MlneuralgruCursor, i : Int, v : Double) -> MlneuralgruCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_cursor_sum(s : MlneuralgruCursor) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_cursor_mean(s : MlneuralgruCursor) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_cursor_scale(s : MlneuralgruCursor, f : Double) -> MlneuralgruCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_cursor_add(a : MlneuralgruCursor, b : MlneuralgruCursor) -> MlneuralgruCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_cursor_copy(s : MlneuralgruCursor) -> MlneuralgruCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_cursor_fill(s : MlneuralgruCursor, v : Double) -> MlneuralgruCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_cursor_min(s : MlneuralgruCursor) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_cursor_max(s : MlneuralgruCursor) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_cursor_to_string(s : MlneuralgruCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_view_make(size : Int) -> MlneuralgruView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_view_len(s : MlneuralgruView) -> Int { s.size }

pub fn ml_neural_gru_view_get(s : MlneuralgruView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_view_set(s : MlneuralgruView, i : Int, v : Double) -> MlneuralgruView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_view_sum(s : MlneuralgruView) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_view_mean(s : MlneuralgruView) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_view_scale(s : MlneuralgruView, f : Double) -> MlneuralgruView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_view_add(a : MlneuralgruView, b : MlneuralgruView) -> MlneuralgruView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_view_copy(s : MlneuralgruView) -> MlneuralgruView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_view_fill(s : MlneuralgruView, v : Double) -> MlneuralgruView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_view_min(s : MlneuralgruView) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_view_max(s : MlneuralgruView) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_view_to_string(s : MlneuralgruView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_range_make(size : Int) -> MlneuralgruRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_range_len(s : MlneuralgruRange) -> Int { s.size }

pub fn ml_neural_gru_range_get(s : MlneuralgruRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_range_set(s : MlneuralgruRange, i : Int, v : Double) -> MlneuralgruRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_range_sum(s : MlneuralgruRange) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_range_mean(s : MlneuralgruRange) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_range_scale(s : MlneuralgruRange, f : Double) -> MlneuralgruRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_range_add(a : MlneuralgruRange, b : MlneuralgruRange) -> MlneuralgruRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_range_copy(s : MlneuralgruRange) -> MlneuralgruRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_range_fill(s : MlneuralgruRange, v : Double) -> MlneuralgruRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_range_min(s : MlneuralgruRange) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_range_max(s : MlneuralgruRange) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_range_to_string(s : MlneuralgruRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_slice_make(size : Int) -> MlneuralgruSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_slice_len(s : MlneuralgruSlice) -> Int { s.size }

pub fn ml_neural_gru_slice_get(s : MlneuralgruSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_slice_set(s : MlneuralgruSlice, i : Int, v : Double) -> MlneuralgruSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_slice_sum(s : MlneuralgruSlice) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_slice_mean(s : MlneuralgruSlice) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_slice_scale(s : MlneuralgruSlice, f : Double) -> MlneuralgruSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_slice_add(a : MlneuralgruSlice, b : MlneuralgruSlice) -> MlneuralgruSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_slice_copy(s : MlneuralgruSlice) -> MlneuralgruSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_slice_fill(s : MlneuralgruSlice, v : Double) -> MlneuralgruSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_slice_min(s : MlneuralgruSlice) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_slice_max(s : MlneuralgruSlice) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_slice_to_string(s : MlneuralgruSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

