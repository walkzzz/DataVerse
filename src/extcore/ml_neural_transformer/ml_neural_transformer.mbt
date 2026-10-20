///===
/// extcore/ml_neural_transformer

pub(all) struct MlneuraltransformerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_transformer_make_point(x : Double, y : Double) -> MlneuraltransformerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_transformer_make_point3(x : Double, y : Double, z : Double) -> MlneuraltransformerPoint {
  { x, y, z, label: 0 }
}

pub fn ml_neural_transformer_point_x(pt : MlneuraltransformerPoint) -> Double { pt.x }

pub fn ml_neural_transformer_point_y(pt : MlneuraltransformerPoint) -> Double { pt.y }

pub fn ml_neural_transformer_point_z(pt : MlneuraltransformerPoint) -> Double { pt.z }

pub fn ml_neural_transformer_point_label(pt : MlneuraltransformerPoint) -> Int { pt.label }

pub fn ml_neural_transformer_point_dist(a : MlneuraltransformerPoint, b : MlneuraltransformerPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_neural_transformer_point_add(a : MlneuraltransformerPoint, b : MlneuraltransformerPoint) -> MlneuraltransformerPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_neural_transformer_point_sub(a : MlneuraltransformerPoint, b : MlneuraltransformerPoint) -> MlneuraltransformerPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_neural_transformer_point_scale(pt : MlneuraltransformerPoint, s : Double) -> MlneuraltransformerPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_neural_transformer_point_dot(a : MlneuraltransformerPoint, b : MlneuraltransformerPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_neural_transformer_point_cross(a : MlneuraltransformerPoint, b : MlneuraltransformerPoint) -> MlneuraltransformerPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_neural_transformer_point_norm(pt : MlneuraltransformerPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_neural_transformer_point_normalize(pt : MlneuraltransformerPoint) -> MlneuraltransformerPoint {
  let n = ml_neural_transformer_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_neural_transformer_point_scale(pt, 1.0 / n) }
}

pub fn ml_neural_transformer_point_negate(pt : MlneuraltransformerPoint) -> MlneuraltransformerPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_neural_transformer_point_mid(a : MlneuraltransformerPoint, b : MlneuraltransformerPoint) -> MlneuraltransformerPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_neural_transformer_point_lerp(a : MlneuraltransformerPoint, b : MlneuraltransformerPoint, t : Double) -> MlneuraltransformerPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_neural_transformer_point_to_string(pt : MlneuraltransformerPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlneuraltransformerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_transformer_make_series(vals : Array[Double], name : String) -> MlneuraltransformerSeries {
  { vals, name, meta: 0 }
}

pub fn ml_neural_transformer_series_len(s : MlneuraltransformerSeries) -> Int { s.vals.length() }

pub fn ml_neural_transformer_series_sum(s : MlneuraltransformerSeries) -> Double { @_common.sum(s.vals) }

pub fn ml_neural_transformer_series_mean(s : MlneuraltransformerSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_neural_transformer_series_min(s : MlneuraltransformerSeries) -> Double { @_common.min(s.vals) }

pub fn ml_neural_transformer_series_max(s : MlneuraltransformerSeries) -> Double { @_common.max(s.vals) }

pub fn ml_neural_transformer_series_range(s : MlneuraltransformerSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_neural_transformer_series_var(s : MlneuraltransformerSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_neural_transformer_series_std(s : MlneuraltransformerSeries) -> Double { @_common.std(s.vals) }

pub fn ml_neural_transformer_series_median(s : MlneuraltransformerSeries) -> Double { @_common.median(s.vals) }

pub fn ml_neural_transformer_series_scale(s : MlneuraltransformerSeries, f : Double) -> MlneuraltransformerSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_neural_transformer_series_add(a : MlneuraltransformerSeries, b : MlneuraltransformerSeries) -> MlneuraltransformerSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_neural_transformer_series_sub(a : MlneuraltransformerSeries, b : MlneuraltransformerSeries) -> MlneuraltransformerSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_neural_transformer_series_normalize(s : MlneuraltransformerSeries) -> MlneuraltransformerSeries {
  let mn = ml_neural_transformer_series_min(s)
  let mx = ml_neural_transformer_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_neural_transformer_series_cumsum(s : MlneuraltransformerSeries) -> MlneuraltransformerSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_neural_transformer_series_to_string(s : MlneuraltransformerSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuraltransformerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_transformer_make_matrix(rows : Int, cols : Int, val : Double) -> MlneuraltransformerMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_neural_transformer_matrix_identity(n : Int) -> MlneuraltransformerMatrix {
  let m = ml_neural_transformer_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_neural_transformer_matrix_get(m : MlneuraltransformerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_neural_transformer_matrix_transpose(m : MlneuraltransformerMatrix) -> MlneuraltransformerMatrix {
  let result = ml_neural_transformer_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_neural_transformer_matrix_add(a : MlneuraltransformerMatrix, b : MlneuraltransformerMatrix) -> MlneuraltransformerMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_neural_transformer_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_neural_transformer_matrix_scale(m : MlneuraltransformerMatrix, s : Double) -> MlneuraltransformerMatrix {
  let result = ml_neural_transformer_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_neural_transformer_matrix_multiply(a : MlneuraltransformerMatrix, b : MlneuraltransformerMatrix) -> MlneuraltransformerMatrix {
  if a.cols != b.rows { return ml_neural_transformer_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_neural_transformer_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_neural_transformer_matrix_trace(m : MlneuraltransformerMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_neural_transformer_matrix_det(m : MlneuraltransformerMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_neural_transformer_matrix_norm(m : MlneuraltransformerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_neural_transformer_matrix_to_string(m : MlneuraltransformerMatrix) -> String {
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

pub(all) struct MlneuraltransformerVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_transformer_make_vector(comps : Array[Double]) -> MlneuraltransformerVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_transformer_vector_zero(dim : Int) -> MlneuraltransformerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_neural_transformer_vector_add(a : MlneuraltransformerVector, b : MlneuraltransformerVector) -> MlneuraltransformerVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_neural_transformer_vector_sub(a : MlneuraltransformerVector, b : MlneuraltransformerVector) -> MlneuraltransformerVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_neural_transformer_vector_scale(v : MlneuraltransformerVector, s : Double) -> MlneuraltransformerVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_neural_transformer_vector_dot(a : MlneuraltransformerVector, b : MlneuraltransformerVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_neural_transformer_vector_norm(v : MlneuraltransformerVector) -> Double { @_common.sqrt(ml_neural_transformer_vector_dot(v, v)) }

pub fn ml_neural_transformer_vector_normalize(v : MlneuraltransformerVector) -> MlneuraltransformerVector {
  let n = ml_neural_transformer_vector_norm(v)
  if n < 0.0000001 { v } else { ml_neural_transformer_vector_scale(v, 1.0 / n) }
}

pub fn ml_neural_transformer_vector_dist(a : MlneuraltransformerVector, b : MlneuraltransformerVector) -> Double {
  ml_neural_transformer_vector_norm(ml_neural_transformer_vector_sub(a, b))
}

pub fn ml_neural_transformer_vector_to_string(v : MlneuraltransformerVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_neural_transformer_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_neural_transformer_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_neural_transformer_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_neural_transformer_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_neural_transformer_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_neural_transformer_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_neural_transformer_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_neural_transformer_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_neural_transformer_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_neural_transformer_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_neural_transformer_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_neural_transformer_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_neural_transformer_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_neural_transformer_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_neural_transformer_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_neural_transformer_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_neural_transformer_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_neural_transformer_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_neural_transformer_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_neural_transformer_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_neural_transformer_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_neural_transformer_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_neural_transformer_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_neural_transformer_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_neural_transformer_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_neural_transformer_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_neural_transformer_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_neural_transformer_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_neural_transformer_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlneuraltransformerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_frame_make(size : Int) -> MlneuraltransformerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_frame_len(s : MlneuraltransformerFrame) -> Int { s.size }

pub fn ml_neural_transformer_frame_get(s : MlneuraltransformerFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_frame_set(s : MlneuraltransformerFrame, i : Int, v : Double) -> MlneuraltransformerFrame {
  let result = ml_neural_transformer_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_frame_sum(s : MlneuraltransformerFrame) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_frame_mean(s : MlneuraltransformerFrame) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_frame_scale(s : MlneuraltransformerFrame, f : Double) -> MlneuraltransformerFrame {
  let result = ml_neural_transformer_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_transformer_frame_add(a : MlneuraltransformerFrame, b : MlneuraltransformerFrame) -> MlneuraltransformerFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_transformer_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_transformer_frame_copy(s : MlneuraltransformerFrame) -> MlneuraltransformerFrame {
  let result = ml_neural_transformer_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_transformer_frame_fill(s : MlneuraltransformerFrame, v : Double) -> MlneuraltransformerFrame {
  let result = ml_neural_transformer_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_frame_min(s : MlneuraltransformerFrame) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_frame_max(s : MlneuraltransformerFrame) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_frame_to_string(s : MlneuraltransformerFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_table_make(size : Int) -> MlneuraltransformerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_table_len(s : MlneuraltransformerTable) -> Int { s.size }

pub fn ml_neural_transformer_table_get(s : MlneuraltransformerTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_table_set(s : MlneuraltransformerTable, i : Int, v : Double) -> MlneuraltransformerTable {
  let result = ml_neural_transformer_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_table_sum(s : MlneuraltransformerTable) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_table_mean(s : MlneuraltransformerTable) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_table_scale(s : MlneuraltransformerTable, f : Double) -> MlneuraltransformerTable {
  let result = ml_neural_transformer_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_transformer_table_add(a : MlneuraltransformerTable, b : MlneuraltransformerTable) -> MlneuraltransformerTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_transformer_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_transformer_table_copy(s : MlneuraltransformerTable) -> MlneuraltransformerTable {
  let result = ml_neural_transformer_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_transformer_table_fill(s : MlneuraltransformerTable, v : Double) -> MlneuraltransformerTable {
  let result = ml_neural_transformer_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_table_min(s : MlneuraltransformerTable) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_table_max(s : MlneuraltransformerTable) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_table_to_string(s : MlneuraltransformerTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_graphn_make(size : Int) -> MlneuraltransformerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_graphn_len(s : MlneuraltransformerGraphN) -> Int { s.size }

pub fn ml_neural_transformer_graphn_get(s : MlneuraltransformerGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_graphn_set(s : MlneuraltransformerGraphN, i : Int, v : Double) -> MlneuraltransformerGraphN {
  let result = ml_neural_transformer_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_graphn_sum(s : MlneuraltransformerGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_graphn_mean(s : MlneuraltransformerGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_graphn_scale(s : MlneuraltransformerGraphN, f : Double) -> MlneuraltransformerGraphN {
  let result = ml_neural_transformer_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_transformer_graphn_add(a : MlneuraltransformerGraphN, b : MlneuraltransformerGraphN) -> MlneuraltransformerGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_transformer_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_transformer_graphn_copy(s : MlneuraltransformerGraphN) -> MlneuraltransformerGraphN {
  let result = ml_neural_transformer_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_transformer_graphn_fill(s : MlneuraltransformerGraphN, v : Double) -> MlneuraltransformerGraphN {
  let result = ml_neural_transformer_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_graphn_min(s : MlneuraltransformerGraphN) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_graphn_max(s : MlneuraltransformerGraphN) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_graphn_to_string(s : MlneuraltransformerGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_node_make(size : Int) -> MlneuraltransformerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_node_len(s : MlneuraltransformerNode) -> Int { s.size }

pub fn ml_neural_transformer_node_get(s : MlneuraltransformerNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_node_set(s : MlneuraltransformerNode, i : Int, v : Double) -> MlneuraltransformerNode {
  let result = ml_neural_transformer_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_node_sum(s : MlneuraltransformerNode) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_node_mean(s : MlneuraltransformerNode) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_node_scale(s : MlneuraltransformerNode, f : Double) -> MlneuraltransformerNode {
  let result = ml_neural_transformer_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_transformer_node_add(a : MlneuraltransformerNode, b : MlneuraltransformerNode) -> MlneuraltransformerNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_transformer_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_transformer_node_copy(s : MlneuraltransformerNode) -> MlneuraltransformerNode {
  let result = ml_neural_transformer_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_transformer_node_fill(s : MlneuraltransformerNode, v : Double) -> MlneuraltransformerNode {
  let result = ml_neural_transformer_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_node_min(s : MlneuraltransformerNode) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_node_max(s : MlneuraltransformerNode) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_node_to_string(s : MlneuraltransformerNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_edge_make(size : Int) -> MlneuraltransformerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_edge_len(s : MlneuraltransformerEdge) -> Int { s.size }

pub fn ml_neural_transformer_edge_get(s : MlneuraltransformerEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_edge_set(s : MlneuraltransformerEdge, i : Int, v : Double) -> MlneuraltransformerEdge {
  let result = ml_neural_transformer_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_edge_sum(s : MlneuraltransformerEdge) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_edge_mean(s : MlneuraltransformerEdge) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_edge_scale(s : MlneuraltransformerEdge, f : Double) -> MlneuraltransformerEdge {
  let result = ml_neural_transformer_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_transformer_edge_add(a : MlneuraltransformerEdge, b : MlneuraltransformerEdge) -> MlneuraltransformerEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_transformer_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_transformer_edge_copy(s : MlneuraltransformerEdge) -> MlneuraltransformerEdge {
  let result = ml_neural_transformer_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_transformer_edge_fill(s : MlneuraltransformerEdge, v : Double) -> MlneuraltransformerEdge {
  let result = ml_neural_transformer_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_edge_min(s : MlneuraltransformerEdge) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_edge_max(s : MlneuraltransformerEdge) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_edge_to_string(s : MlneuraltransformerEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_path_make(size : Int) -> MlneuraltransformerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_path_len(s : MlneuraltransformerPath) -> Int { s.size }

pub fn ml_neural_transformer_path_get(s : MlneuraltransformerPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_path_set(s : MlneuraltransformerPath, i : Int, v : Double) -> MlneuraltransformerPath {
  let result = ml_neural_transformer_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_path_sum(s : MlneuraltransformerPath) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_path_mean(s : MlneuraltransformerPath) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_path_scale(s : MlneuraltransformerPath, f : Double) -> MlneuraltransformerPath {
  let result = ml_neural_transformer_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_transformer_path_add(a : MlneuraltransformerPath, b : MlneuraltransformerPath) -> MlneuraltransformerPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_transformer_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_transformer_path_copy(s : MlneuraltransformerPath) -> MlneuraltransformerPath {
  let result = ml_neural_transformer_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_transformer_path_fill(s : MlneuraltransformerPath, v : Double) -> MlneuraltransformerPath {
  let result = ml_neural_transformer_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_path_min(s : MlneuraltransformerPath) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_path_max(s : MlneuraltransformerPath) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_path_to_string(s : MlneuraltransformerPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_cluster_make(size : Int) -> MlneuraltransformerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_cluster_len(s : MlneuraltransformerCluster) -> Int { s.size }

pub fn ml_neural_transformer_cluster_get(s : MlneuraltransformerCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_cluster_set(s : MlneuraltransformerCluster, i : Int, v : Double) -> MlneuraltransformerCluster {
  let result = ml_neural_transformer_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_cluster_sum(s : MlneuraltransformerCluster) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_cluster_mean(s : MlneuraltransformerCluster) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_cluster_scale(s : MlneuraltransformerCluster, f : Double) -> MlneuraltransformerCluster {
  let result = ml_neural_transformer_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_transformer_cluster_add(a : MlneuraltransformerCluster, b : MlneuraltransformerCluster) -> MlneuraltransformerCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_transformer_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_transformer_cluster_copy(s : MlneuraltransformerCluster) -> MlneuraltransformerCluster {
  let result = ml_neural_transformer_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_transformer_cluster_fill(s : MlneuraltransformerCluster, v : Double) -> MlneuraltransformerCluster {
  let result = ml_neural_transformer_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_cluster_min(s : MlneuraltransformerCluster) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_cluster_max(s : MlneuraltransformerCluster) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_cluster_to_string(s : MlneuraltransformerCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_model_make(size : Int) -> MlneuraltransformerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_model_len(s : MlneuraltransformerModel) -> Int { s.size }

pub fn ml_neural_transformer_model_get(s : MlneuraltransformerModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_model_set(s : MlneuraltransformerModel, i : Int, v : Double) -> MlneuraltransformerModel {
  let result = ml_neural_transformer_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_model_sum(s : MlneuraltransformerModel) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_model_mean(s : MlneuraltransformerModel) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_model_scale(s : MlneuraltransformerModel, f : Double) -> MlneuraltransformerModel {
  let result = ml_neural_transformer_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_transformer_model_add(a : MlneuraltransformerModel, b : MlneuraltransformerModel) -> MlneuraltransformerModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_transformer_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_transformer_model_copy(s : MlneuraltransformerModel) -> MlneuraltransformerModel {
  let result = ml_neural_transformer_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_transformer_model_fill(s : MlneuraltransformerModel, v : Double) -> MlneuraltransformerModel {
  let result = ml_neural_transformer_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_model_min(s : MlneuraltransformerModel) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_model_max(s : MlneuraltransformerModel) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_model_to_string(s : MlneuraltransformerModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_layer_make(size : Int) -> MlneuraltransformerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_layer_len(s : MlneuraltransformerLayer) -> Int { s.size }

pub fn ml_neural_transformer_layer_get(s : MlneuraltransformerLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_layer_set(s : MlneuraltransformerLayer, i : Int, v : Double) -> MlneuraltransformerLayer {
  let result = ml_neural_transformer_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_layer_sum(s : MlneuraltransformerLayer) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_layer_mean(s : MlneuraltransformerLayer) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_layer_scale(s : MlneuraltransformerLayer, f : Double) -> MlneuraltransformerLayer {
  let result = ml_neural_transformer_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_transformer_layer_add(a : MlneuraltransformerLayer, b : MlneuraltransformerLayer) -> MlneuraltransformerLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_transformer_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_transformer_layer_copy(s : MlneuraltransformerLayer) -> MlneuraltransformerLayer {
  let result = ml_neural_transformer_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_transformer_layer_fill(s : MlneuraltransformerLayer, v : Double) -> MlneuraltransformerLayer {
  let result = ml_neural_transformer_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_layer_min(s : MlneuraltransformerLayer) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_layer_max(s : MlneuraltransformerLayer) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_layer_to_string(s : MlneuraltransformerLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_buffer_make(size : Int) -> MlneuraltransformerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_buffer_len(s : MlneuraltransformerBuffer) -> Int { s.size }

pub fn ml_neural_transformer_buffer_get(s : MlneuraltransformerBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_buffer_set(s : MlneuraltransformerBuffer, i : Int, v : Double) -> MlneuraltransformerBuffer {
  let result = ml_neural_transformer_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_buffer_sum(s : MlneuraltransformerBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_buffer_mean(s : MlneuraltransformerBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_buffer_scale(s : MlneuraltransformerBuffer, f : Double) -> MlneuraltransformerBuffer {
  let result = ml_neural_transformer_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_transformer_buffer_add(a : MlneuraltransformerBuffer, b : MlneuraltransformerBuffer) -> MlneuraltransformerBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_transformer_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_transformer_buffer_copy(s : MlneuraltransformerBuffer) -> MlneuraltransformerBuffer {
  let result = ml_neural_transformer_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_transformer_buffer_fill(s : MlneuraltransformerBuffer, v : Double) -> MlneuraltransformerBuffer {
  let result = ml_neural_transformer_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_buffer_min(s : MlneuraltransformerBuffer) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_buffer_max(s : MlneuraltransformerBuffer) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_buffer_to_string(s : MlneuraltransformerBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_cursor_make(size : Int) -> MlneuraltransformerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_cursor_len(s : MlneuraltransformerCursor) -> Int { s.size }

pub fn ml_neural_transformer_cursor_get(s : MlneuraltransformerCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_cursor_set(s : MlneuraltransformerCursor, i : Int, v : Double) -> MlneuraltransformerCursor {
  let result = ml_neural_transformer_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_cursor_sum(s : MlneuraltransformerCursor) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_cursor_mean(s : MlneuraltransformerCursor) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_cursor_scale(s : MlneuraltransformerCursor, f : Double) -> MlneuraltransformerCursor {
  let result = ml_neural_transformer_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_transformer_cursor_add(a : MlneuraltransformerCursor, b : MlneuraltransformerCursor) -> MlneuraltransformerCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_transformer_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_transformer_cursor_copy(s : MlneuraltransformerCursor) -> MlneuraltransformerCursor {
  let result = ml_neural_transformer_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_transformer_cursor_fill(s : MlneuraltransformerCursor, v : Double) -> MlneuraltransformerCursor {
  let result = ml_neural_transformer_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_cursor_min(s : MlneuraltransformerCursor) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_cursor_max(s : MlneuraltransformerCursor) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_cursor_to_string(s : MlneuraltransformerCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_view_make(size : Int) -> MlneuraltransformerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_view_len(s : MlneuraltransformerView) -> Int { s.size }

pub fn ml_neural_transformer_view_get(s : MlneuraltransformerView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_view_set(s : MlneuraltransformerView, i : Int, v : Double) -> MlneuraltransformerView {
  let result = ml_neural_transformer_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_view_sum(s : MlneuraltransformerView) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_view_mean(s : MlneuraltransformerView) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_view_scale(s : MlneuraltransformerView, f : Double) -> MlneuraltransformerView {
  let result = ml_neural_transformer_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_transformer_view_add(a : MlneuraltransformerView, b : MlneuraltransformerView) -> MlneuraltransformerView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_transformer_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_transformer_view_copy(s : MlneuraltransformerView) -> MlneuraltransformerView {
  let result = ml_neural_transformer_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_transformer_view_fill(s : MlneuraltransformerView, v : Double) -> MlneuraltransformerView {
  let result = ml_neural_transformer_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_view_min(s : MlneuraltransformerView) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_view_max(s : MlneuraltransformerView) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_view_to_string(s : MlneuraltransformerView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_range_make(size : Int) -> MlneuraltransformerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_range_len(s : MlneuraltransformerRange) -> Int { s.size }

pub fn ml_neural_transformer_range_get(s : MlneuraltransformerRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_range_set(s : MlneuraltransformerRange, i : Int, v : Double) -> MlneuraltransformerRange {
  let result = ml_neural_transformer_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_range_sum(s : MlneuraltransformerRange) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_range_mean(s : MlneuraltransformerRange) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_range_scale(s : MlneuraltransformerRange, f : Double) -> MlneuraltransformerRange {
  let result = ml_neural_transformer_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_transformer_range_add(a : MlneuraltransformerRange, b : MlneuraltransformerRange) -> MlneuraltransformerRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_transformer_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_transformer_range_copy(s : MlneuraltransformerRange) -> MlneuraltransformerRange {
  let result = ml_neural_transformer_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_transformer_range_fill(s : MlneuraltransformerRange, v : Double) -> MlneuraltransformerRange {
  let result = ml_neural_transformer_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_range_min(s : MlneuraltransformerRange) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_range_max(s : MlneuraltransformerRange) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_range_to_string(s : MlneuraltransformerRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_slice_make(size : Int) -> MlneuraltransformerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_slice_len(s : MlneuraltransformerSlice) -> Int { s.size }

pub fn ml_neural_transformer_slice_get(s : MlneuraltransformerSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_slice_set(s : MlneuraltransformerSlice, i : Int, v : Double) -> MlneuraltransformerSlice {
  let result = ml_neural_transformer_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_slice_sum(s : MlneuraltransformerSlice) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_slice_mean(s : MlneuraltransformerSlice) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_slice_scale(s : MlneuraltransformerSlice, f : Double) -> MlneuraltransformerSlice {
  let result = ml_neural_transformer_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_transformer_slice_add(a : MlneuraltransformerSlice, b : MlneuraltransformerSlice) -> MlneuraltransformerSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_transformer_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_transformer_slice_copy(s : MlneuraltransformerSlice) -> MlneuraltransformerSlice {
  let result = ml_neural_transformer_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_transformer_slice_fill(s : MlneuraltransformerSlice, v : Double) -> MlneuraltransformerSlice {
  let result = ml_neural_transformer_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_transformer_slice_min(s : MlneuraltransformerSlice) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_slice_max(s : MlneuraltransformerSlice) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_slice_to_string(s : MlneuraltransformerSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

