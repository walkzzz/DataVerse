///===
/// extcore/ml_rl_dqn

pub(all) struct MlrldqnPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_dqn_make_point(x : Double, y : Double) -> MlrldqnPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_dqn_make_point3(x : Double, y : Double, z : Double) -> MlrldqnPoint {
  { x, y, z, label: 0 }
}

pub fn ml_rl_dqn_point_x(pt : MlrldqnPoint) -> Double { pt.x }

pub fn ml_rl_dqn_point_y(pt : MlrldqnPoint) -> Double { pt.y }

pub fn ml_rl_dqn_point_z(pt : MlrldqnPoint) -> Double { pt.z }

pub fn ml_rl_dqn_point_label(pt : MlrldqnPoint) -> Int { pt.label }

pub fn ml_rl_dqn_point_dist(a : MlrldqnPoint, b : MlrldqnPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_rl_dqn_point_add(a : MlrldqnPoint, b : MlrldqnPoint) -> MlrldqnPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_rl_dqn_point_sub(a : MlrldqnPoint, b : MlrldqnPoint) -> MlrldqnPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_rl_dqn_point_scale(pt : MlrldqnPoint, s : Double) -> MlrldqnPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_rl_dqn_point_dot(a : MlrldqnPoint, b : MlrldqnPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_rl_dqn_point_cross(a : MlrldqnPoint, b : MlrldqnPoint) -> MlrldqnPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_rl_dqn_point_norm(pt : MlrldqnPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_rl_dqn_point_normalize(pt : MlrldqnPoint) -> MlrldqnPoint {
  let n = ml_rl_dqn_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_rl_dqn_point_scale(pt, 1.0 / n) }
}

pub fn ml_rl_dqn_point_negate(pt : MlrldqnPoint) -> MlrldqnPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_rl_dqn_point_mid(a : MlrldqnPoint, b : MlrldqnPoint) -> MlrldqnPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_rl_dqn_point_lerp(a : MlrldqnPoint, b : MlrldqnPoint, t : Double) -> MlrldqnPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_rl_dqn_point_to_string(pt : MlrldqnPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlrldqnSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_dqn_make_series(vals : Array[Double], name : String) -> MlrldqnSeries {
  { vals, name, meta: 0 }
}

pub fn ml_rl_dqn_series_len(s : MlrldqnSeries) -> Int { s.vals.length() }

pub fn ml_rl_dqn_series_sum(s : MlrldqnSeries) -> Double { @_common.sum(s.vals) }

pub fn ml_rl_dqn_series_mean(s : MlrldqnSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_rl_dqn_series_min(s : MlrldqnSeries) -> Double { @_common.min(s.vals) }

pub fn ml_rl_dqn_series_max(s : MlrldqnSeries) -> Double { @_common.max(s.vals) }

pub fn ml_rl_dqn_series_range(s : MlrldqnSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_rl_dqn_series_var(s : MlrldqnSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_rl_dqn_series_std(s : MlrldqnSeries) -> Double { @_common.std(s.vals) }

pub fn ml_rl_dqn_series_median(s : MlrldqnSeries) -> Double { @_common.median(s.vals) }

pub fn ml_rl_dqn_series_scale(s : MlrldqnSeries, f : Double) -> MlrldqnSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_rl_dqn_series_add(a : MlrldqnSeries, b : MlrldqnSeries) -> MlrldqnSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_rl_dqn_series_sub(a : MlrldqnSeries, b : MlrldqnSeries) -> MlrldqnSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_rl_dqn_series_normalize(s : MlrldqnSeries) -> MlrldqnSeries {
  let mn = ml_rl_dqn_series_min(s)
  let mx = ml_rl_dqn_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_rl_dqn_series_cumsum(s : MlrldqnSeries) -> MlrldqnSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_rl_dqn_series_to_string(s : MlrldqnSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrldqnMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_dqn_make_matrix(rows : Int, cols : Int, val : Double) -> MlrldqnMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_dqn_matrix_identity(n : Int) -> MlrldqnMatrix {
  let m = ml_rl_dqn_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_rl_dqn_matrix_get(m : MlrldqnMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_rl_dqn_matrix_transpose(m : MlrldqnMatrix) -> MlrldqnMatrix {
  let result = ml_rl_dqn_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_rl_dqn_matrix_add(a : MlrldqnMatrix, b : MlrldqnMatrix) -> MlrldqnMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_rl_dqn_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_rl_dqn_matrix_scale(m : MlrldqnMatrix, s : Double) -> MlrldqnMatrix {
  let result = ml_rl_dqn_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_rl_dqn_matrix_multiply(a : MlrldqnMatrix, b : MlrldqnMatrix) -> MlrldqnMatrix {
  if a.cols != b.rows { return ml_rl_dqn_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_rl_dqn_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_rl_dqn_matrix_trace(m : MlrldqnMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_rl_dqn_matrix_det(m : MlrldqnMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_rl_dqn_matrix_norm(m : MlrldqnMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_rl_dqn_matrix_to_string(m : MlrldqnMatrix) -> String {
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

pub(all) struct MlrldqnVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_dqn_make_vector(comps : Array[Double]) -> MlrldqnVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_dqn_vector_zero(dim : Int) -> MlrldqnVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_rl_dqn_vector_add(a : MlrldqnVector, b : MlrldqnVector) -> MlrldqnVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_rl_dqn_vector_sub(a : MlrldqnVector, b : MlrldqnVector) -> MlrldqnVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_rl_dqn_vector_scale(v : MlrldqnVector, s : Double) -> MlrldqnVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_rl_dqn_vector_dot(a : MlrldqnVector, b : MlrldqnVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_rl_dqn_vector_norm(v : MlrldqnVector) -> Double { @_common.sqrt(ml_rl_dqn_vector_dot(v, v)) }

pub fn ml_rl_dqn_vector_normalize(v : MlrldqnVector) -> MlrldqnVector {
  let n = ml_rl_dqn_vector_norm(v)
  if n < 0.0000001 { v } else { ml_rl_dqn_vector_scale(v, 1.0 / n) }
}

pub fn ml_rl_dqn_vector_dist(a : MlrldqnVector, b : MlrldqnVector) -> Double {
  ml_rl_dqn_vector_norm(ml_rl_dqn_vector_sub(a, b))
}

pub fn ml_rl_dqn_vector_to_string(v : MlrldqnVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_rl_dqn_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_rl_dqn_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_rl_dqn_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_rl_dqn_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_rl_dqn_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_rl_dqn_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_rl_dqn_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_rl_dqn_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_rl_dqn_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_rl_dqn_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_rl_dqn_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_rl_dqn_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_rl_dqn_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_rl_dqn_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_rl_dqn_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_rl_dqn_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_rl_dqn_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_rl_dqn_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_rl_dqn_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_rl_dqn_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_rl_dqn_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_rl_dqn_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_rl_dqn_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_rl_dqn_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_rl_dqn_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_rl_dqn_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_rl_dqn_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_rl_dqn_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_rl_dqn_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlrldqnFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_frame_make(size : Int) -> MlrldqnFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_frame_len(s : MlrldqnFrame) -> Int { s.size }

pub fn ml_rl_dqn_frame_get(s : MlrldqnFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_frame_set(s : MlrldqnFrame, i : Int, v : Double) -> MlrldqnFrame {
  let result = ml_rl_dqn_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_dqn_frame_sum(s : MlrldqnFrame) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_frame_mean(s : MlrldqnFrame) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_frame_scale(s : MlrldqnFrame, f : Double) -> MlrldqnFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_frame_add(a : MlrldqnFrame, b : MlrldqnFrame) -> MlrldqnFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_frame_copy(s : MlrldqnFrame) -> MlrldqnFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_frame_fill(s : MlrldqnFrame, v : Double) -> MlrldqnFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_frame_min(s : MlrldqnFrame) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_frame_max(s : MlrldqnFrame) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_frame_to_string(s : MlrldqnFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_table_make(size : Int) -> MlrldqnTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_table_len(s : MlrldqnTable) -> Int { s.size }

pub fn ml_rl_dqn_table_get(s : MlrldqnTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_table_set(s : MlrldqnTable, i : Int, v : Double) -> MlrldqnTable {
  let result = ml_rl_dqn_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_dqn_table_sum(s : MlrldqnTable) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_table_mean(s : MlrldqnTable) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_table_scale(s : MlrldqnTable, f : Double) -> MlrldqnTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_table_add(a : MlrldqnTable, b : MlrldqnTable) -> MlrldqnTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_table_copy(s : MlrldqnTable) -> MlrldqnTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_table_fill(s : MlrldqnTable, v : Double) -> MlrldqnTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_table_min(s : MlrldqnTable) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_table_max(s : MlrldqnTable) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_table_to_string(s : MlrldqnTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_graphn_make(size : Int) -> MlrldqnGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_graphn_len(s : MlrldqnGraphN) -> Int { s.size }

pub fn ml_rl_dqn_graphn_get(s : MlrldqnGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_graphn_set(s : MlrldqnGraphN, i : Int, v : Double) -> MlrldqnGraphN {
  let result = ml_rl_dqn_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_dqn_graphn_sum(s : MlrldqnGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_graphn_mean(s : MlrldqnGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_graphn_scale(s : MlrldqnGraphN, f : Double) -> MlrldqnGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_graphn_add(a : MlrldqnGraphN, b : MlrldqnGraphN) -> MlrldqnGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_graphn_copy(s : MlrldqnGraphN) -> MlrldqnGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_graphn_fill(s : MlrldqnGraphN, v : Double) -> MlrldqnGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_graphn_min(s : MlrldqnGraphN) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_graphn_max(s : MlrldqnGraphN) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_graphn_to_string(s : MlrldqnGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_node_make(size : Int) -> MlrldqnNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_node_len(s : MlrldqnNode) -> Int { s.size }

pub fn ml_rl_dqn_node_get(s : MlrldqnNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_node_set(s : MlrldqnNode, i : Int, v : Double) -> MlrldqnNode {
  let result = ml_rl_dqn_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_dqn_node_sum(s : MlrldqnNode) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_node_mean(s : MlrldqnNode) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_node_scale(s : MlrldqnNode, f : Double) -> MlrldqnNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_node_add(a : MlrldqnNode, b : MlrldqnNode) -> MlrldqnNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_node_copy(s : MlrldqnNode) -> MlrldqnNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_node_fill(s : MlrldqnNode, v : Double) -> MlrldqnNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_node_min(s : MlrldqnNode) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_node_max(s : MlrldqnNode) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_node_to_string(s : MlrldqnNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_edge_make(size : Int) -> MlrldqnEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_edge_len(s : MlrldqnEdge) -> Int { s.size }

pub fn ml_rl_dqn_edge_get(s : MlrldqnEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_edge_set(s : MlrldqnEdge, i : Int, v : Double) -> MlrldqnEdge {
  let result = ml_rl_dqn_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_dqn_edge_sum(s : MlrldqnEdge) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_edge_mean(s : MlrldqnEdge) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_edge_scale(s : MlrldqnEdge, f : Double) -> MlrldqnEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_edge_add(a : MlrldqnEdge, b : MlrldqnEdge) -> MlrldqnEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_edge_copy(s : MlrldqnEdge) -> MlrldqnEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_edge_fill(s : MlrldqnEdge, v : Double) -> MlrldqnEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_edge_min(s : MlrldqnEdge) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_edge_max(s : MlrldqnEdge) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_edge_to_string(s : MlrldqnEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_path_make(size : Int) -> MlrldqnPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_path_len(s : MlrldqnPath) -> Int { s.size }

pub fn ml_rl_dqn_path_get(s : MlrldqnPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_path_set(s : MlrldqnPath, i : Int, v : Double) -> MlrldqnPath {
  let result = ml_rl_dqn_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_dqn_path_sum(s : MlrldqnPath) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_path_mean(s : MlrldqnPath) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_path_scale(s : MlrldqnPath, f : Double) -> MlrldqnPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_path_add(a : MlrldqnPath, b : MlrldqnPath) -> MlrldqnPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_path_copy(s : MlrldqnPath) -> MlrldqnPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_path_fill(s : MlrldqnPath, v : Double) -> MlrldqnPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_path_min(s : MlrldqnPath) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_path_max(s : MlrldqnPath) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_path_to_string(s : MlrldqnPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_cluster_make(size : Int) -> MlrldqnCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_cluster_len(s : MlrldqnCluster) -> Int { s.size }

pub fn ml_rl_dqn_cluster_get(s : MlrldqnCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_cluster_set(s : MlrldqnCluster, i : Int, v : Double) -> MlrldqnCluster {
  let result = ml_rl_dqn_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_dqn_cluster_sum(s : MlrldqnCluster) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_cluster_mean(s : MlrldqnCluster) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_cluster_scale(s : MlrldqnCluster, f : Double) -> MlrldqnCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_cluster_add(a : MlrldqnCluster, b : MlrldqnCluster) -> MlrldqnCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_cluster_copy(s : MlrldqnCluster) -> MlrldqnCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_cluster_fill(s : MlrldqnCluster, v : Double) -> MlrldqnCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_cluster_min(s : MlrldqnCluster) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_cluster_max(s : MlrldqnCluster) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_cluster_to_string(s : MlrldqnCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_model_make(size : Int) -> MlrldqnModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_model_len(s : MlrldqnModel) -> Int { s.size }

pub fn ml_rl_dqn_model_get(s : MlrldqnModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_model_set(s : MlrldqnModel, i : Int, v : Double) -> MlrldqnModel {
  let result = ml_rl_dqn_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_dqn_model_sum(s : MlrldqnModel) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_model_mean(s : MlrldqnModel) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_model_scale(s : MlrldqnModel, f : Double) -> MlrldqnModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_model_add(a : MlrldqnModel, b : MlrldqnModel) -> MlrldqnModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_model_copy(s : MlrldqnModel) -> MlrldqnModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_model_fill(s : MlrldqnModel, v : Double) -> MlrldqnModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_model_min(s : MlrldqnModel) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_model_max(s : MlrldqnModel) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_model_to_string(s : MlrldqnModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_layer_make(size : Int) -> MlrldqnLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_layer_len(s : MlrldqnLayer) -> Int { s.size }

pub fn ml_rl_dqn_layer_get(s : MlrldqnLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_layer_set(s : MlrldqnLayer, i : Int, v : Double) -> MlrldqnLayer {
  let result = ml_rl_dqn_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_dqn_layer_sum(s : MlrldqnLayer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_layer_mean(s : MlrldqnLayer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_layer_scale(s : MlrldqnLayer, f : Double) -> MlrldqnLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_layer_add(a : MlrldqnLayer, b : MlrldqnLayer) -> MlrldqnLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_layer_copy(s : MlrldqnLayer) -> MlrldqnLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_layer_fill(s : MlrldqnLayer, v : Double) -> MlrldqnLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_layer_min(s : MlrldqnLayer) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_layer_max(s : MlrldqnLayer) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_layer_to_string(s : MlrldqnLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_buffer_make(size : Int) -> MlrldqnBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_buffer_len(s : MlrldqnBuffer) -> Int { s.size }

pub fn ml_rl_dqn_buffer_get(s : MlrldqnBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_buffer_set(s : MlrldqnBuffer, i : Int, v : Double) -> MlrldqnBuffer {
  let result = ml_rl_dqn_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_dqn_buffer_sum(s : MlrldqnBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_buffer_mean(s : MlrldqnBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_buffer_scale(s : MlrldqnBuffer, f : Double) -> MlrldqnBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_buffer_add(a : MlrldqnBuffer, b : MlrldqnBuffer) -> MlrldqnBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_buffer_copy(s : MlrldqnBuffer) -> MlrldqnBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_buffer_fill(s : MlrldqnBuffer, v : Double) -> MlrldqnBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_buffer_min(s : MlrldqnBuffer) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_buffer_max(s : MlrldqnBuffer) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_buffer_to_string(s : MlrldqnBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_cursor_make(size : Int) -> MlrldqnCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_cursor_len(s : MlrldqnCursor) -> Int { s.size }

pub fn ml_rl_dqn_cursor_get(s : MlrldqnCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_cursor_set(s : MlrldqnCursor, i : Int, v : Double) -> MlrldqnCursor {
  let result = ml_rl_dqn_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_dqn_cursor_sum(s : MlrldqnCursor) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_cursor_mean(s : MlrldqnCursor) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_cursor_scale(s : MlrldqnCursor, f : Double) -> MlrldqnCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_cursor_add(a : MlrldqnCursor, b : MlrldqnCursor) -> MlrldqnCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_cursor_copy(s : MlrldqnCursor) -> MlrldqnCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_cursor_fill(s : MlrldqnCursor, v : Double) -> MlrldqnCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_cursor_min(s : MlrldqnCursor) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_cursor_max(s : MlrldqnCursor) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_cursor_to_string(s : MlrldqnCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_view_make(size : Int) -> MlrldqnView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_view_len(s : MlrldqnView) -> Int { s.size }

pub fn ml_rl_dqn_view_get(s : MlrldqnView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_view_set(s : MlrldqnView, i : Int, v : Double) -> MlrldqnView {
  let result = ml_rl_dqn_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_dqn_view_sum(s : MlrldqnView) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_view_mean(s : MlrldqnView) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_view_scale(s : MlrldqnView, f : Double) -> MlrldqnView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_view_add(a : MlrldqnView, b : MlrldqnView) -> MlrldqnView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_view_copy(s : MlrldqnView) -> MlrldqnView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_view_fill(s : MlrldqnView, v : Double) -> MlrldqnView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_view_min(s : MlrldqnView) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_view_max(s : MlrldqnView) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_view_to_string(s : MlrldqnView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_range_make(size : Int) -> MlrldqnRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_range_len(s : MlrldqnRange) -> Int { s.size }

pub fn ml_rl_dqn_range_get(s : MlrldqnRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_range_set(s : MlrldqnRange, i : Int, v : Double) -> MlrldqnRange {
  let result = ml_rl_dqn_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_dqn_range_sum(s : MlrldqnRange) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_range_mean(s : MlrldqnRange) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_range_scale(s : MlrldqnRange, f : Double) -> MlrldqnRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_range_add(a : MlrldqnRange, b : MlrldqnRange) -> MlrldqnRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_range_copy(s : MlrldqnRange) -> MlrldqnRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_range_fill(s : MlrldqnRange, v : Double) -> MlrldqnRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_range_min(s : MlrldqnRange) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_range_max(s : MlrldqnRange) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_range_to_string(s : MlrldqnRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_slice_make(size : Int) -> MlrldqnSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_slice_len(s : MlrldqnSlice) -> Int { s.size }

pub fn ml_rl_dqn_slice_get(s : MlrldqnSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_slice_set(s : MlrldqnSlice, i : Int, v : Double) -> MlrldqnSlice {
  let result = ml_rl_dqn_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_dqn_slice_sum(s : MlrldqnSlice) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_slice_mean(s : MlrldqnSlice) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_slice_scale(s : MlrldqnSlice, f : Double) -> MlrldqnSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_slice_add(a : MlrldqnSlice, b : MlrldqnSlice) -> MlrldqnSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_slice_copy(s : MlrldqnSlice) -> MlrldqnSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_slice_fill(s : MlrldqnSlice, v : Double) -> MlrldqnSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_slice_min(s : MlrldqnSlice) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_slice_max(s : MlrldqnSlice) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_slice_to_string(s : MlrldqnSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

