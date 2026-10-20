///===
/// extcore/ml_neural_autoencoder

pub(all) struct MlneuralautoencoderPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_autoencoder_make_point(x : Double, y : Double) -> MlneuralautoencoderPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_autoencoder_make_point3(x : Double, y : Double, z : Double) -> MlneuralautoencoderPoint {
  { x, y, z, label: 0 }
}

pub fn ml_neural_autoencoder_point_x(pt : MlneuralautoencoderPoint) -> Double { pt.x }

pub fn ml_neural_autoencoder_point_y(pt : MlneuralautoencoderPoint) -> Double { pt.y }

pub fn ml_neural_autoencoder_point_z(pt : MlneuralautoencoderPoint) -> Double { pt.z }

pub fn ml_neural_autoencoder_point_label(pt : MlneuralautoencoderPoint) -> Int { pt.label }

pub fn ml_neural_autoencoder_point_dist(a : MlneuralautoencoderPoint, b : MlneuralautoencoderPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_neural_autoencoder_point_add(a : MlneuralautoencoderPoint, b : MlneuralautoencoderPoint) -> MlneuralautoencoderPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_neural_autoencoder_point_sub(a : MlneuralautoencoderPoint, b : MlneuralautoencoderPoint) -> MlneuralautoencoderPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_neural_autoencoder_point_scale(pt : MlneuralautoencoderPoint, s : Double) -> MlneuralautoencoderPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_neural_autoencoder_point_dot(a : MlneuralautoencoderPoint, b : MlneuralautoencoderPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_neural_autoencoder_point_cross(a : MlneuralautoencoderPoint, b : MlneuralautoencoderPoint) -> MlneuralautoencoderPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_neural_autoencoder_point_norm(pt : MlneuralautoencoderPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_neural_autoencoder_point_normalize(pt : MlneuralautoencoderPoint) -> MlneuralautoencoderPoint {
  let n = ml_neural_autoencoder_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_neural_autoencoder_point_scale(pt, 1.0 / n) }
}

pub fn ml_neural_autoencoder_point_negate(pt : MlneuralautoencoderPoint) -> MlneuralautoencoderPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_neural_autoencoder_point_mid(a : MlneuralautoencoderPoint, b : MlneuralautoencoderPoint) -> MlneuralautoencoderPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_neural_autoencoder_point_lerp(a : MlneuralautoencoderPoint, b : MlneuralautoencoderPoint, t : Double) -> MlneuralautoencoderPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_neural_autoencoder_point_to_string(pt : MlneuralautoencoderPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlneuralautoencoderSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_autoencoder_make_series(vals : Array[Double], name : String) -> MlneuralautoencoderSeries {
  { vals, name, meta: 0 }
}

pub fn ml_neural_autoencoder_series_len(s : MlneuralautoencoderSeries) -> Int { s.vals.length() }

pub fn ml_neural_autoencoder_series_sum(s : MlneuralautoencoderSeries) -> Double { @_common.sum(s.vals) }

pub fn ml_neural_autoencoder_series_mean(s : MlneuralautoencoderSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_neural_autoencoder_series_min(s : MlneuralautoencoderSeries) -> Double { @_common.min(s.vals) }

pub fn ml_neural_autoencoder_series_max(s : MlneuralautoencoderSeries) -> Double { @_common.max(s.vals) }

pub fn ml_neural_autoencoder_series_range(s : MlneuralautoencoderSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_neural_autoencoder_series_var(s : MlneuralautoencoderSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_neural_autoencoder_series_std(s : MlneuralautoencoderSeries) -> Double { @_common.std(s.vals) }

pub fn ml_neural_autoencoder_series_median(s : MlneuralautoencoderSeries) -> Double { @_common.median(s.vals) }

pub fn ml_neural_autoencoder_series_scale(s : MlneuralautoencoderSeries, f : Double) -> MlneuralautoencoderSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn ml_neural_autoencoder_series_add(a : MlneuralautoencoderSeries, b : MlneuralautoencoderSeries) -> MlneuralautoencoderSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_neural_autoencoder_series_sub(a : MlneuralautoencoderSeries, b : MlneuralautoencoderSeries) -> MlneuralautoencoderSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_neural_autoencoder_series_normalize(s : MlneuralautoencoderSeries) -> MlneuralautoencoderSeries {
  let mn = ml_neural_autoencoder_series_min(s)
  let mx = ml_neural_autoencoder_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_neural_autoencoder_series_cumsum(s : MlneuralautoencoderSeries) -> MlneuralautoencoderSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_neural_autoencoder_series_to_string(s : MlneuralautoencoderSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuralautoencoderMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_autoencoder_make_matrix(rows : Int, cols : Int, val : Double) -> MlneuralautoencoderMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_neural_autoencoder_matrix_identity(n : Int) -> MlneuralautoencoderMatrix {
  let m = ml_neural_autoencoder_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_neural_autoencoder_matrix_get(m : MlneuralautoencoderMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_neural_autoencoder_matrix_transpose(m : MlneuralautoencoderMatrix) -> MlneuralautoencoderMatrix {
  let result = ml_neural_autoencoder_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_neural_autoencoder_matrix_add(a : MlneuralautoencoderMatrix, b : MlneuralautoencoderMatrix) -> MlneuralautoencoderMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_neural_autoencoder_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_neural_autoencoder_matrix_scale(m : MlneuralautoencoderMatrix, s : Double) -> MlneuralautoencoderMatrix {
  let result = ml_neural_autoencoder_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_neural_autoencoder_matrix_multiply(a : MlneuralautoencoderMatrix, b : MlneuralautoencoderMatrix) -> MlneuralautoencoderMatrix {
  if a.cols != b.rows { return ml_neural_autoencoder_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_neural_autoencoder_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_neural_autoencoder_matrix_trace(m : MlneuralautoencoderMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_neural_autoencoder_matrix_det(m : MlneuralautoencoderMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_neural_autoencoder_matrix_norm(m : MlneuralautoencoderMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_neural_autoencoder_matrix_to_string(m : MlneuralautoencoderMatrix) -> String {
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

pub(all) struct MlneuralautoencoderVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_autoencoder_make_vector(comps : Array[Double]) -> MlneuralautoencoderVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_autoencoder_vector_zero(dim : Int) -> MlneuralautoencoderVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_neural_autoencoder_vector_add(a : MlneuralautoencoderVector, b : MlneuralautoencoderVector) -> MlneuralautoencoderVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn ml_neural_autoencoder_vector_sub(a : MlneuralautoencoderVector, b : MlneuralautoencoderVector) -> MlneuralautoencoderVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn ml_neural_autoencoder_vector_scale(v : MlneuralautoencoderVector, s : Double) -> MlneuralautoencoderVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn ml_neural_autoencoder_vector_dot(a : MlneuralautoencoderVector, b : MlneuralautoencoderVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_neural_autoencoder_vector_norm(v : MlneuralautoencoderVector) -> Double { @_common.sqrt(ml_neural_autoencoder_vector_dot(v, v)) }

pub fn ml_neural_autoencoder_vector_normalize(v : MlneuralautoencoderVector) -> MlneuralautoencoderVector {
  let n = ml_neural_autoencoder_vector_norm(v)
  if n < 0.0000001 { v } else { ml_neural_autoencoder_vector_scale(v, 1.0 / n) }
}

pub fn ml_neural_autoencoder_vector_dist(a : MlneuralautoencoderVector, b : MlneuralautoencoderVector) -> Double {
  ml_neural_autoencoder_vector_norm(ml_neural_autoencoder_vector_sub(a, b))
}

pub fn ml_neural_autoencoder_vector_to_string(v : MlneuralautoencoderVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_neural_autoencoder_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_neural_autoencoder_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_neural_autoencoder_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_neural_autoencoder_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_neural_autoencoder_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_neural_autoencoder_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_neural_autoencoder_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_neural_autoencoder_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_neural_autoencoder_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_neural_autoencoder_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_neural_autoencoder_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_neural_autoencoder_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_neural_autoencoder_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_neural_autoencoder_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_neural_autoencoder_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_neural_autoencoder_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_neural_autoencoder_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_neural_autoencoder_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_neural_autoencoder_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_neural_autoencoder_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_neural_autoencoder_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_neural_autoencoder_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_neural_autoencoder_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_neural_autoencoder_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_neural_autoencoder_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_neural_autoencoder_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_neural_autoencoder_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_neural_autoencoder_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_neural_autoencoder_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlneuralautoencoderFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_frame_make(size : Int) -> MlneuralautoencoderFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_autoencoder_frame_len(s : MlneuralautoencoderFrame) -> Int { s.size }

pub fn ml_neural_autoencoder_frame_get(s : MlneuralautoencoderFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_autoencoder_frame_set(s : MlneuralautoencoderFrame, i : Int, v : Double) -> MlneuralautoencoderFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_frame_sum(s : MlneuralautoencoderFrame) -> Double { @_common.sum(s.data) }

pub fn ml_neural_autoencoder_frame_mean(s : MlneuralautoencoderFrame) -> Double { @_common.mean(s.data) }

pub fn ml_neural_autoencoder_frame_scale(s : MlneuralautoencoderFrame, f : Double) -> MlneuralautoencoderFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_frame_add(a : MlneuralautoencoderFrame, b : MlneuralautoencoderFrame) -> MlneuralautoencoderFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_autoencoder_frame_copy(s : MlneuralautoencoderFrame) -> MlneuralautoencoderFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_frame_fill(s : MlneuralautoencoderFrame, v : Double) -> MlneuralautoencoderFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_frame_min(s : MlneuralautoencoderFrame) -> Double { @_common.min(s.data) }

pub fn ml_neural_autoencoder_frame_max(s : MlneuralautoencoderFrame) -> Double { @_common.max(s.data) }

pub fn ml_neural_autoencoder_frame_to_string(s : MlneuralautoencoderFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_table_make(size : Int) -> MlneuralautoencoderTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_autoencoder_table_len(s : MlneuralautoencoderTable) -> Int { s.size }

pub fn ml_neural_autoencoder_table_get(s : MlneuralautoencoderTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_autoencoder_table_set(s : MlneuralautoencoderTable, i : Int, v : Double) -> MlneuralautoencoderTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_table_sum(s : MlneuralautoencoderTable) -> Double { @_common.sum(s.data) }

pub fn ml_neural_autoencoder_table_mean(s : MlneuralautoencoderTable) -> Double { @_common.mean(s.data) }

pub fn ml_neural_autoencoder_table_scale(s : MlneuralautoencoderTable, f : Double) -> MlneuralautoencoderTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_table_add(a : MlneuralautoencoderTable, b : MlneuralautoencoderTable) -> MlneuralautoencoderTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_autoencoder_table_copy(s : MlneuralautoencoderTable) -> MlneuralautoencoderTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_table_fill(s : MlneuralautoencoderTable, v : Double) -> MlneuralautoencoderTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_table_min(s : MlneuralautoencoderTable) -> Double { @_common.min(s.data) }

pub fn ml_neural_autoencoder_table_max(s : MlneuralautoencoderTable) -> Double { @_common.max(s.data) }

pub fn ml_neural_autoencoder_table_to_string(s : MlneuralautoencoderTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_graphn_make(size : Int) -> MlneuralautoencoderGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_autoencoder_graphn_len(s : MlneuralautoencoderGraphN) -> Int { s.size }

pub fn ml_neural_autoencoder_graphn_get(s : MlneuralautoencoderGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_autoencoder_graphn_set(s : MlneuralautoencoderGraphN, i : Int, v : Double) -> MlneuralautoencoderGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_graphn_sum(s : MlneuralautoencoderGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_neural_autoencoder_graphn_mean(s : MlneuralautoencoderGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_neural_autoencoder_graphn_scale(s : MlneuralautoencoderGraphN, f : Double) -> MlneuralautoencoderGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_graphn_add(a : MlneuralautoencoderGraphN, b : MlneuralautoencoderGraphN) -> MlneuralautoencoderGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_autoencoder_graphn_copy(s : MlneuralautoencoderGraphN) -> MlneuralautoencoderGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_graphn_fill(s : MlneuralautoencoderGraphN, v : Double) -> MlneuralautoencoderGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_graphn_min(s : MlneuralautoencoderGraphN) -> Double { @_common.min(s.data) }

pub fn ml_neural_autoencoder_graphn_max(s : MlneuralautoencoderGraphN) -> Double { @_common.max(s.data) }

pub fn ml_neural_autoencoder_graphn_to_string(s : MlneuralautoencoderGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_node_make(size : Int) -> MlneuralautoencoderNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_autoencoder_node_len(s : MlneuralautoencoderNode) -> Int { s.size }

pub fn ml_neural_autoencoder_node_get(s : MlneuralautoencoderNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_autoencoder_node_set(s : MlneuralautoencoderNode, i : Int, v : Double) -> MlneuralautoencoderNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_node_sum(s : MlneuralautoencoderNode) -> Double { @_common.sum(s.data) }

pub fn ml_neural_autoencoder_node_mean(s : MlneuralautoencoderNode) -> Double { @_common.mean(s.data) }

pub fn ml_neural_autoencoder_node_scale(s : MlneuralautoencoderNode, f : Double) -> MlneuralautoencoderNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_node_add(a : MlneuralautoencoderNode, b : MlneuralautoencoderNode) -> MlneuralautoencoderNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_autoencoder_node_copy(s : MlneuralautoencoderNode) -> MlneuralautoencoderNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_node_fill(s : MlneuralautoencoderNode, v : Double) -> MlneuralautoencoderNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_node_min(s : MlneuralautoencoderNode) -> Double { @_common.min(s.data) }

pub fn ml_neural_autoencoder_node_max(s : MlneuralautoencoderNode) -> Double { @_common.max(s.data) }

pub fn ml_neural_autoencoder_node_to_string(s : MlneuralautoencoderNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_edge_make(size : Int) -> MlneuralautoencoderEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_autoencoder_edge_len(s : MlneuralautoencoderEdge) -> Int { s.size }

pub fn ml_neural_autoencoder_edge_get(s : MlneuralautoencoderEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_autoencoder_edge_set(s : MlneuralautoencoderEdge, i : Int, v : Double) -> MlneuralautoencoderEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_edge_sum(s : MlneuralautoencoderEdge) -> Double { @_common.sum(s.data) }

pub fn ml_neural_autoencoder_edge_mean(s : MlneuralautoencoderEdge) -> Double { @_common.mean(s.data) }

pub fn ml_neural_autoencoder_edge_scale(s : MlneuralautoencoderEdge, f : Double) -> MlneuralautoencoderEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_edge_add(a : MlneuralautoencoderEdge, b : MlneuralautoencoderEdge) -> MlneuralautoencoderEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_autoencoder_edge_copy(s : MlneuralautoencoderEdge) -> MlneuralautoencoderEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_edge_fill(s : MlneuralautoencoderEdge, v : Double) -> MlneuralautoencoderEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_edge_min(s : MlneuralautoencoderEdge) -> Double { @_common.min(s.data) }

pub fn ml_neural_autoencoder_edge_max(s : MlneuralautoencoderEdge) -> Double { @_common.max(s.data) }

pub fn ml_neural_autoencoder_edge_to_string(s : MlneuralautoencoderEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_path_make(size : Int) -> MlneuralautoencoderPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_autoencoder_path_len(s : MlneuralautoencoderPath) -> Int { s.size }

pub fn ml_neural_autoencoder_path_get(s : MlneuralautoencoderPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_autoencoder_path_set(s : MlneuralautoencoderPath, i : Int, v : Double) -> MlneuralautoencoderPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_path_sum(s : MlneuralautoencoderPath) -> Double { @_common.sum(s.data) }

pub fn ml_neural_autoencoder_path_mean(s : MlneuralautoencoderPath) -> Double { @_common.mean(s.data) }

pub fn ml_neural_autoencoder_path_scale(s : MlneuralautoencoderPath, f : Double) -> MlneuralautoencoderPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_path_add(a : MlneuralautoencoderPath, b : MlneuralautoencoderPath) -> MlneuralautoencoderPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_autoencoder_path_copy(s : MlneuralautoencoderPath) -> MlneuralautoencoderPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_path_fill(s : MlneuralautoencoderPath, v : Double) -> MlneuralautoencoderPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_path_min(s : MlneuralautoencoderPath) -> Double { @_common.min(s.data) }

pub fn ml_neural_autoencoder_path_max(s : MlneuralautoencoderPath) -> Double { @_common.max(s.data) }

pub fn ml_neural_autoencoder_path_to_string(s : MlneuralautoencoderPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_cluster_make(size : Int) -> MlneuralautoencoderCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_autoencoder_cluster_len(s : MlneuralautoencoderCluster) -> Int { s.size }

pub fn ml_neural_autoencoder_cluster_get(s : MlneuralautoencoderCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_autoencoder_cluster_set(s : MlneuralautoencoderCluster, i : Int, v : Double) -> MlneuralautoencoderCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_cluster_sum(s : MlneuralautoencoderCluster) -> Double { @_common.sum(s.data) }

pub fn ml_neural_autoencoder_cluster_mean(s : MlneuralautoencoderCluster) -> Double { @_common.mean(s.data) }

pub fn ml_neural_autoencoder_cluster_scale(s : MlneuralautoencoderCluster, f : Double) -> MlneuralautoencoderCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_cluster_add(a : MlneuralautoencoderCluster, b : MlneuralautoencoderCluster) -> MlneuralautoencoderCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_autoencoder_cluster_copy(s : MlneuralautoencoderCluster) -> MlneuralautoencoderCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_cluster_fill(s : MlneuralautoencoderCluster, v : Double) -> MlneuralautoencoderCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_cluster_min(s : MlneuralautoencoderCluster) -> Double { @_common.min(s.data) }

pub fn ml_neural_autoencoder_cluster_max(s : MlneuralautoencoderCluster) -> Double { @_common.max(s.data) }

pub fn ml_neural_autoencoder_cluster_to_string(s : MlneuralautoencoderCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_model_make(size : Int) -> MlneuralautoencoderModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_autoencoder_model_len(s : MlneuralautoencoderModel) -> Int { s.size }

pub fn ml_neural_autoencoder_model_get(s : MlneuralautoencoderModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_autoencoder_model_set(s : MlneuralautoencoderModel, i : Int, v : Double) -> MlneuralautoencoderModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_model_sum(s : MlneuralautoencoderModel) -> Double { @_common.sum(s.data) }

pub fn ml_neural_autoencoder_model_mean(s : MlneuralautoencoderModel) -> Double { @_common.mean(s.data) }

pub fn ml_neural_autoencoder_model_scale(s : MlneuralautoencoderModel, f : Double) -> MlneuralautoencoderModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_model_add(a : MlneuralautoencoderModel, b : MlneuralautoencoderModel) -> MlneuralautoencoderModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_autoencoder_model_copy(s : MlneuralautoencoderModel) -> MlneuralautoencoderModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_model_fill(s : MlneuralautoencoderModel, v : Double) -> MlneuralautoencoderModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_model_min(s : MlneuralautoencoderModel) -> Double { @_common.min(s.data) }

pub fn ml_neural_autoencoder_model_max(s : MlneuralautoencoderModel) -> Double { @_common.max(s.data) }

pub fn ml_neural_autoencoder_model_to_string(s : MlneuralautoencoderModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_layer_make(size : Int) -> MlneuralautoencoderLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_autoencoder_layer_len(s : MlneuralautoencoderLayer) -> Int { s.size }

pub fn ml_neural_autoencoder_layer_get(s : MlneuralautoencoderLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_autoencoder_layer_set(s : MlneuralautoencoderLayer, i : Int, v : Double) -> MlneuralautoencoderLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_layer_sum(s : MlneuralautoencoderLayer) -> Double { @_common.sum(s.data) }

pub fn ml_neural_autoencoder_layer_mean(s : MlneuralautoencoderLayer) -> Double { @_common.mean(s.data) }

pub fn ml_neural_autoencoder_layer_scale(s : MlneuralautoencoderLayer, f : Double) -> MlneuralautoencoderLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_layer_add(a : MlneuralautoencoderLayer, b : MlneuralautoencoderLayer) -> MlneuralautoencoderLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_autoencoder_layer_copy(s : MlneuralautoencoderLayer) -> MlneuralautoencoderLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_layer_fill(s : MlneuralautoencoderLayer, v : Double) -> MlneuralautoencoderLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_layer_min(s : MlneuralautoencoderLayer) -> Double { @_common.min(s.data) }

pub fn ml_neural_autoencoder_layer_max(s : MlneuralautoencoderLayer) -> Double { @_common.max(s.data) }

pub fn ml_neural_autoencoder_layer_to_string(s : MlneuralautoencoderLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_buffer_make(size : Int) -> MlneuralautoencoderBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_autoencoder_buffer_len(s : MlneuralautoencoderBuffer) -> Int { s.size }

pub fn ml_neural_autoencoder_buffer_get(s : MlneuralautoencoderBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_autoencoder_buffer_set(s : MlneuralautoencoderBuffer, i : Int, v : Double) -> MlneuralautoencoderBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_buffer_sum(s : MlneuralautoencoderBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_neural_autoencoder_buffer_mean(s : MlneuralautoencoderBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_neural_autoencoder_buffer_scale(s : MlneuralautoencoderBuffer, f : Double) -> MlneuralautoencoderBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_buffer_add(a : MlneuralautoencoderBuffer, b : MlneuralautoencoderBuffer) -> MlneuralautoencoderBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_autoencoder_buffer_copy(s : MlneuralautoencoderBuffer) -> MlneuralautoencoderBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_buffer_fill(s : MlneuralautoencoderBuffer, v : Double) -> MlneuralautoencoderBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_buffer_min(s : MlneuralautoencoderBuffer) -> Double { @_common.min(s.data) }

pub fn ml_neural_autoencoder_buffer_max(s : MlneuralautoencoderBuffer) -> Double { @_common.max(s.data) }

pub fn ml_neural_autoencoder_buffer_to_string(s : MlneuralautoencoderBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_cursor_make(size : Int) -> MlneuralautoencoderCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_autoencoder_cursor_len(s : MlneuralautoencoderCursor) -> Int { s.size }

pub fn ml_neural_autoencoder_cursor_get(s : MlneuralautoencoderCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_autoencoder_cursor_set(s : MlneuralautoencoderCursor, i : Int, v : Double) -> MlneuralautoencoderCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_cursor_sum(s : MlneuralautoencoderCursor) -> Double { @_common.sum(s.data) }

pub fn ml_neural_autoencoder_cursor_mean(s : MlneuralautoencoderCursor) -> Double { @_common.mean(s.data) }

pub fn ml_neural_autoencoder_cursor_scale(s : MlneuralautoencoderCursor, f : Double) -> MlneuralautoencoderCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_cursor_add(a : MlneuralautoencoderCursor, b : MlneuralautoencoderCursor) -> MlneuralautoencoderCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_autoencoder_cursor_copy(s : MlneuralautoencoderCursor) -> MlneuralautoencoderCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_cursor_fill(s : MlneuralautoencoderCursor, v : Double) -> MlneuralautoencoderCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_cursor_min(s : MlneuralautoencoderCursor) -> Double { @_common.min(s.data) }

pub fn ml_neural_autoencoder_cursor_max(s : MlneuralautoencoderCursor) -> Double { @_common.max(s.data) }

pub fn ml_neural_autoencoder_cursor_to_string(s : MlneuralautoencoderCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_view_make(size : Int) -> MlneuralautoencoderView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_autoencoder_view_len(s : MlneuralautoencoderView) -> Int { s.size }

pub fn ml_neural_autoencoder_view_get(s : MlneuralautoencoderView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_autoencoder_view_set(s : MlneuralautoencoderView, i : Int, v : Double) -> MlneuralautoencoderView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_view_sum(s : MlneuralautoencoderView) -> Double { @_common.sum(s.data) }

pub fn ml_neural_autoencoder_view_mean(s : MlneuralautoencoderView) -> Double { @_common.mean(s.data) }

pub fn ml_neural_autoencoder_view_scale(s : MlneuralautoencoderView, f : Double) -> MlneuralautoencoderView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_view_add(a : MlneuralautoencoderView, b : MlneuralautoencoderView) -> MlneuralautoencoderView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_autoencoder_view_copy(s : MlneuralautoencoderView) -> MlneuralautoencoderView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_view_fill(s : MlneuralautoencoderView, v : Double) -> MlneuralautoencoderView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_view_min(s : MlneuralautoencoderView) -> Double { @_common.min(s.data) }

pub fn ml_neural_autoencoder_view_max(s : MlneuralautoencoderView) -> Double { @_common.max(s.data) }

pub fn ml_neural_autoencoder_view_to_string(s : MlneuralautoencoderView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_range_make(size : Int) -> MlneuralautoencoderRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_autoencoder_range_len(s : MlneuralautoencoderRange) -> Int { s.size }

pub fn ml_neural_autoencoder_range_get(s : MlneuralautoencoderRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_autoencoder_range_set(s : MlneuralautoencoderRange, i : Int, v : Double) -> MlneuralautoencoderRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_range_sum(s : MlneuralautoencoderRange) -> Double { @_common.sum(s.data) }

pub fn ml_neural_autoencoder_range_mean(s : MlneuralautoencoderRange) -> Double { @_common.mean(s.data) }

pub fn ml_neural_autoencoder_range_scale(s : MlneuralautoencoderRange, f : Double) -> MlneuralautoencoderRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_range_add(a : MlneuralautoencoderRange, b : MlneuralautoencoderRange) -> MlneuralautoencoderRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_autoencoder_range_copy(s : MlneuralautoencoderRange) -> MlneuralautoencoderRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_range_fill(s : MlneuralautoencoderRange, v : Double) -> MlneuralautoencoderRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_range_min(s : MlneuralautoencoderRange) -> Double { @_common.min(s.data) }

pub fn ml_neural_autoencoder_range_max(s : MlneuralautoencoderRange) -> Double { @_common.max(s.data) }

pub fn ml_neural_autoencoder_range_to_string(s : MlneuralautoencoderRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_slice_make(size : Int) -> MlneuralautoencoderSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_autoencoder_slice_len(s : MlneuralautoencoderSlice) -> Int { s.size }

pub fn ml_neural_autoencoder_slice_get(s : MlneuralautoencoderSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_autoencoder_slice_set(s : MlneuralautoencoderSlice, i : Int, v : Double) -> MlneuralautoencoderSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_slice_sum(s : MlneuralautoencoderSlice) -> Double { @_common.sum(s.data) }

pub fn ml_neural_autoencoder_slice_mean(s : MlneuralautoencoderSlice) -> Double { @_common.mean(s.data) }

pub fn ml_neural_autoencoder_slice_scale(s : MlneuralautoencoderSlice, f : Double) -> MlneuralautoencoderSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_slice_add(a : MlneuralautoencoderSlice, b : MlneuralautoencoderSlice) -> MlneuralautoencoderSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_autoencoder_slice_copy(s : MlneuralautoencoderSlice) -> MlneuralautoencoderSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_slice_fill(s : MlneuralautoencoderSlice, v : Double) -> MlneuralautoencoderSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_autoencoder_slice_min(s : MlneuralautoencoderSlice) -> Double { @_common.min(s.data) }

pub fn ml_neural_autoencoder_slice_max(s : MlneuralautoencoderSlice) -> Double { @_common.max(s.data) }

pub fn ml_neural_autoencoder_slice_to_string(s : MlneuralautoencoderSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

