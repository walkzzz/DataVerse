///===
/// extcore/ml_rl_trpo

pub(all) struct MlrltrpoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_trpo_make_point(x : Double, y : Double) -> MlrltrpoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_trpo_make_point3(x : Double, y : Double, z : Double) -> MlrltrpoPoint {
  { x, y, z, label: 0 }
}

pub fn ml_rl_trpo_point_x(pt : MlrltrpoPoint) -> Double { pt.x }

pub fn ml_rl_trpo_point_y(pt : MlrltrpoPoint) -> Double { pt.y }

pub fn ml_rl_trpo_point_z(pt : MlrltrpoPoint) -> Double { pt.z }

pub fn ml_rl_trpo_point_label(pt : MlrltrpoPoint) -> Int { pt.label }

pub fn ml_rl_trpo_point_dist(a : MlrltrpoPoint, b : MlrltrpoPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_rl_trpo_point_add(a : MlrltrpoPoint, b : MlrltrpoPoint) -> MlrltrpoPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_rl_trpo_point_sub(a : MlrltrpoPoint, b : MlrltrpoPoint) -> MlrltrpoPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_rl_trpo_point_scale(pt : MlrltrpoPoint, s : Double) -> MlrltrpoPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_rl_trpo_point_dot(a : MlrltrpoPoint, b : MlrltrpoPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_rl_trpo_point_cross(a : MlrltrpoPoint, b : MlrltrpoPoint) -> MlrltrpoPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_rl_trpo_point_norm(pt : MlrltrpoPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_rl_trpo_point_normalize(pt : MlrltrpoPoint) -> MlrltrpoPoint {
  let n = ml_rl_trpo_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_rl_trpo_point_scale(pt, 1.0 / n) }
}

pub fn ml_rl_trpo_point_negate(pt : MlrltrpoPoint) -> MlrltrpoPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_rl_trpo_point_mid(a : MlrltrpoPoint, b : MlrltrpoPoint) -> MlrltrpoPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_rl_trpo_point_lerp(a : MlrltrpoPoint, b : MlrltrpoPoint, t : Double) -> MlrltrpoPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_rl_trpo_point_to_string(pt : MlrltrpoPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlrltrpoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_trpo_make_series(vals : Array[Double], name : String) -> MlrltrpoSeries {
  { vals, name, meta: 0 }
}

pub fn ml_rl_trpo_series_len(s : MlrltrpoSeries) -> Int { s.vals.length() }

pub fn ml_rl_trpo_series_sum(s : MlrltrpoSeries) -> Double { @_common.sum(s.vals) }

pub fn ml_rl_trpo_series_mean(s : MlrltrpoSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_rl_trpo_series_min(s : MlrltrpoSeries) -> Double { @_common.min(s.vals) }

pub fn ml_rl_trpo_series_max(s : MlrltrpoSeries) -> Double { @_common.max(s.vals) }

pub fn ml_rl_trpo_series_range(s : MlrltrpoSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_rl_trpo_series_var(s : MlrltrpoSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_rl_trpo_series_std(s : MlrltrpoSeries) -> Double { @_common.std(s.vals) }

pub fn ml_rl_trpo_series_median(s : MlrltrpoSeries) -> Double { @_common.median(s.vals) }

pub fn ml_rl_trpo_series_scale(s : MlrltrpoSeries, f : Double) -> MlrltrpoSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn ml_rl_trpo_series_add(a : MlrltrpoSeries, b : MlrltrpoSeries) -> MlrltrpoSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_rl_trpo_series_sub(a : MlrltrpoSeries, b : MlrltrpoSeries) -> MlrltrpoSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_rl_trpo_series_normalize(s : MlrltrpoSeries) -> MlrltrpoSeries {
  let mn = ml_rl_trpo_series_min(s)
  let mx = ml_rl_trpo_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_rl_trpo_series_cumsum(s : MlrltrpoSeries) -> MlrltrpoSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_rl_trpo_series_to_string(s : MlrltrpoSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrltrpoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_trpo_make_matrix(rows : Int, cols : Int, val : Double) -> MlrltrpoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_trpo_matrix_identity(n : Int) -> MlrltrpoMatrix {
  let m = ml_rl_trpo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_rl_trpo_matrix_get(m : MlrltrpoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_rl_trpo_matrix_transpose(m : MlrltrpoMatrix) -> MlrltrpoMatrix {
  let result = ml_rl_trpo_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_rl_trpo_matrix_add(a : MlrltrpoMatrix, b : MlrltrpoMatrix) -> MlrltrpoMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_rl_trpo_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_rl_trpo_matrix_scale(m : MlrltrpoMatrix, s : Double) -> MlrltrpoMatrix {
  let result = ml_rl_trpo_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_rl_trpo_matrix_multiply(a : MlrltrpoMatrix, b : MlrltrpoMatrix) -> MlrltrpoMatrix {
  if a.cols != b.rows { return ml_rl_trpo_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_rl_trpo_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_rl_trpo_matrix_trace(m : MlrltrpoMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_rl_trpo_matrix_det(m : MlrltrpoMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_rl_trpo_matrix_norm(m : MlrltrpoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_rl_trpo_matrix_to_string(m : MlrltrpoMatrix) -> String {
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

pub(all) struct MlrltrpoVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_trpo_make_vector(comps : Array[Double]) -> MlrltrpoVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_trpo_vector_zero(dim : Int) -> MlrltrpoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_rl_trpo_vector_add(a : MlrltrpoVector, b : MlrltrpoVector) -> MlrltrpoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn ml_rl_trpo_vector_sub(a : MlrltrpoVector, b : MlrltrpoVector) -> MlrltrpoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn ml_rl_trpo_vector_scale(v : MlrltrpoVector, s : Double) -> MlrltrpoVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn ml_rl_trpo_vector_dot(a : MlrltrpoVector, b : MlrltrpoVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_rl_trpo_vector_norm(v : MlrltrpoVector) -> Double { @_common.sqrt(ml_rl_trpo_vector_dot(v, v)) }

pub fn ml_rl_trpo_vector_normalize(v : MlrltrpoVector) -> MlrltrpoVector {
  let n = ml_rl_trpo_vector_norm(v)
  if n < 0.0000001 { v } else { ml_rl_trpo_vector_scale(v, 1.0 / n) }
}

pub fn ml_rl_trpo_vector_dist(a : MlrltrpoVector, b : MlrltrpoVector) -> Double {
  ml_rl_trpo_vector_norm(ml_rl_trpo_vector_sub(a, b))
}

pub fn ml_rl_trpo_vector_to_string(v : MlrltrpoVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_rl_trpo_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_rl_trpo_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_rl_trpo_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_rl_trpo_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_rl_trpo_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_rl_trpo_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_rl_trpo_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_rl_trpo_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_rl_trpo_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_rl_trpo_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_rl_trpo_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_rl_trpo_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_rl_trpo_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_rl_trpo_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_rl_trpo_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_rl_trpo_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_rl_trpo_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_rl_trpo_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_rl_trpo_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_rl_trpo_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_rl_trpo_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_rl_trpo_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_rl_trpo_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_rl_trpo_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_rl_trpo_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_rl_trpo_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_rl_trpo_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_rl_trpo_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_rl_trpo_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlrltrpoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_frame_make(size : Int) -> MlrltrpoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_frame_len(s : MlrltrpoFrame) -> Int { s.size }

pub fn ml_rl_trpo_frame_get(s : MlrltrpoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_frame_set(s : MlrltrpoFrame, i : Int, v : Double) -> MlrltrpoFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_frame_sum(s : MlrltrpoFrame) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_frame_mean(s : MlrltrpoFrame) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_frame_scale(s : MlrltrpoFrame, f : Double) -> MlrltrpoFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_frame_add(a : MlrltrpoFrame, b : MlrltrpoFrame) -> MlrltrpoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_frame_copy(s : MlrltrpoFrame) -> MlrltrpoFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_frame_fill(s : MlrltrpoFrame, v : Double) -> MlrltrpoFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_frame_min(s : MlrltrpoFrame) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_frame_max(s : MlrltrpoFrame) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_frame_to_string(s : MlrltrpoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_table_make(size : Int) -> MlrltrpoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_table_len(s : MlrltrpoTable) -> Int { s.size }

pub fn ml_rl_trpo_table_get(s : MlrltrpoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_table_set(s : MlrltrpoTable, i : Int, v : Double) -> MlrltrpoTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_table_sum(s : MlrltrpoTable) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_table_mean(s : MlrltrpoTable) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_table_scale(s : MlrltrpoTable, f : Double) -> MlrltrpoTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_table_add(a : MlrltrpoTable, b : MlrltrpoTable) -> MlrltrpoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_table_copy(s : MlrltrpoTable) -> MlrltrpoTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_table_fill(s : MlrltrpoTable, v : Double) -> MlrltrpoTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_table_min(s : MlrltrpoTable) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_table_max(s : MlrltrpoTable) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_table_to_string(s : MlrltrpoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_graphn_make(size : Int) -> MlrltrpoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_graphn_len(s : MlrltrpoGraphN) -> Int { s.size }

pub fn ml_rl_trpo_graphn_get(s : MlrltrpoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_graphn_set(s : MlrltrpoGraphN, i : Int, v : Double) -> MlrltrpoGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_graphn_sum(s : MlrltrpoGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_graphn_mean(s : MlrltrpoGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_graphn_scale(s : MlrltrpoGraphN, f : Double) -> MlrltrpoGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_graphn_add(a : MlrltrpoGraphN, b : MlrltrpoGraphN) -> MlrltrpoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_graphn_copy(s : MlrltrpoGraphN) -> MlrltrpoGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_graphn_fill(s : MlrltrpoGraphN, v : Double) -> MlrltrpoGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_graphn_min(s : MlrltrpoGraphN) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_graphn_max(s : MlrltrpoGraphN) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_graphn_to_string(s : MlrltrpoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_node_make(size : Int) -> MlrltrpoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_node_len(s : MlrltrpoNode) -> Int { s.size }

pub fn ml_rl_trpo_node_get(s : MlrltrpoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_node_set(s : MlrltrpoNode, i : Int, v : Double) -> MlrltrpoNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_node_sum(s : MlrltrpoNode) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_node_mean(s : MlrltrpoNode) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_node_scale(s : MlrltrpoNode, f : Double) -> MlrltrpoNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_node_add(a : MlrltrpoNode, b : MlrltrpoNode) -> MlrltrpoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_node_copy(s : MlrltrpoNode) -> MlrltrpoNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_node_fill(s : MlrltrpoNode, v : Double) -> MlrltrpoNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_node_min(s : MlrltrpoNode) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_node_max(s : MlrltrpoNode) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_node_to_string(s : MlrltrpoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_edge_make(size : Int) -> MlrltrpoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_edge_len(s : MlrltrpoEdge) -> Int { s.size }

pub fn ml_rl_trpo_edge_get(s : MlrltrpoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_edge_set(s : MlrltrpoEdge, i : Int, v : Double) -> MlrltrpoEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_edge_sum(s : MlrltrpoEdge) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_edge_mean(s : MlrltrpoEdge) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_edge_scale(s : MlrltrpoEdge, f : Double) -> MlrltrpoEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_edge_add(a : MlrltrpoEdge, b : MlrltrpoEdge) -> MlrltrpoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_edge_copy(s : MlrltrpoEdge) -> MlrltrpoEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_edge_fill(s : MlrltrpoEdge, v : Double) -> MlrltrpoEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_edge_min(s : MlrltrpoEdge) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_edge_max(s : MlrltrpoEdge) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_edge_to_string(s : MlrltrpoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_path_make(size : Int) -> MlrltrpoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_path_len(s : MlrltrpoPath) -> Int { s.size }

pub fn ml_rl_trpo_path_get(s : MlrltrpoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_path_set(s : MlrltrpoPath, i : Int, v : Double) -> MlrltrpoPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_path_sum(s : MlrltrpoPath) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_path_mean(s : MlrltrpoPath) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_path_scale(s : MlrltrpoPath, f : Double) -> MlrltrpoPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_path_add(a : MlrltrpoPath, b : MlrltrpoPath) -> MlrltrpoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_path_copy(s : MlrltrpoPath) -> MlrltrpoPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_path_fill(s : MlrltrpoPath, v : Double) -> MlrltrpoPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_path_min(s : MlrltrpoPath) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_path_max(s : MlrltrpoPath) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_path_to_string(s : MlrltrpoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_cluster_make(size : Int) -> MlrltrpoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_cluster_len(s : MlrltrpoCluster) -> Int { s.size }

pub fn ml_rl_trpo_cluster_get(s : MlrltrpoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_cluster_set(s : MlrltrpoCluster, i : Int, v : Double) -> MlrltrpoCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_cluster_sum(s : MlrltrpoCluster) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_cluster_mean(s : MlrltrpoCluster) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_cluster_scale(s : MlrltrpoCluster, f : Double) -> MlrltrpoCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_cluster_add(a : MlrltrpoCluster, b : MlrltrpoCluster) -> MlrltrpoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_cluster_copy(s : MlrltrpoCluster) -> MlrltrpoCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_cluster_fill(s : MlrltrpoCluster, v : Double) -> MlrltrpoCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_cluster_min(s : MlrltrpoCluster) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_cluster_max(s : MlrltrpoCluster) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_cluster_to_string(s : MlrltrpoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_model_make(size : Int) -> MlrltrpoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_model_len(s : MlrltrpoModel) -> Int { s.size }

pub fn ml_rl_trpo_model_get(s : MlrltrpoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_model_set(s : MlrltrpoModel, i : Int, v : Double) -> MlrltrpoModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_model_sum(s : MlrltrpoModel) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_model_mean(s : MlrltrpoModel) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_model_scale(s : MlrltrpoModel, f : Double) -> MlrltrpoModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_model_add(a : MlrltrpoModel, b : MlrltrpoModel) -> MlrltrpoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_model_copy(s : MlrltrpoModel) -> MlrltrpoModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_model_fill(s : MlrltrpoModel, v : Double) -> MlrltrpoModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_model_min(s : MlrltrpoModel) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_model_max(s : MlrltrpoModel) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_model_to_string(s : MlrltrpoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_layer_make(size : Int) -> MlrltrpoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_layer_len(s : MlrltrpoLayer) -> Int { s.size }

pub fn ml_rl_trpo_layer_get(s : MlrltrpoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_layer_set(s : MlrltrpoLayer, i : Int, v : Double) -> MlrltrpoLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_layer_sum(s : MlrltrpoLayer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_layer_mean(s : MlrltrpoLayer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_layer_scale(s : MlrltrpoLayer, f : Double) -> MlrltrpoLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_layer_add(a : MlrltrpoLayer, b : MlrltrpoLayer) -> MlrltrpoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_layer_copy(s : MlrltrpoLayer) -> MlrltrpoLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_layer_fill(s : MlrltrpoLayer, v : Double) -> MlrltrpoLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_layer_min(s : MlrltrpoLayer) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_layer_max(s : MlrltrpoLayer) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_layer_to_string(s : MlrltrpoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_buffer_make(size : Int) -> MlrltrpoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_buffer_len(s : MlrltrpoBuffer) -> Int { s.size }

pub fn ml_rl_trpo_buffer_get(s : MlrltrpoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_buffer_set(s : MlrltrpoBuffer, i : Int, v : Double) -> MlrltrpoBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_buffer_sum(s : MlrltrpoBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_buffer_mean(s : MlrltrpoBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_buffer_scale(s : MlrltrpoBuffer, f : Double) -> MlrltrpoBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_buffer_add(a : MlrltrpoBuffer, b : MlrltrpoBuffer) -> MlrltrpoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_buffer_copy(s : MlrltrpoBuffer) -> MlrltrpoBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_buffer_fill(s : MlrltrpoBuffer, v : Double) -> MlrltrpoBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_buffer_min(s : MlrltrpoBuffer) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_buffer_max(s : MlrltrpoBuffer) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_buffer_to_string(s : MlrltrpoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_cursor_make(size : Int) -> MlrltrpoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_cursor_len(s : MlrltrpoCursor) -> Int { s.size }

pub fn ml_rl_trpo_cursor_get(s : MlrltrpoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_cursor_set(s : MlrltrpoCursor, i : Int, v : Double) -> MlrltrpoCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_cursor_sum(s : MlrltrpoCursor) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_cursor_mean(s : MlrltrpoCursor) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_cursor_scale(s : MlrltrpoCursor, f : Double) -> MlrltrpoCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_cursor_add(a : MlrltrpoCursor, b : MlrltrpoCursor) -> MlrltrpoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_cursor_copy(s : MlrltrpoCursor) -> MlrltrpoCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_cursor_fill(s : MlrltrpoCursor, v : Double) -> MlrltrpoCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_cursor_min(s : MlrltrpoCursor) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_cursor_max(s : MlrltrpoCursor) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_cursor_to_string(s : MlrltrpoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_view_make(size : Int) -> MlrltrpoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_view_len(s : MlrltrpoView) -> Int { s.size }

pub fn ml_rl_trpo_view_get(s : MlrltrpoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_view_set(s : MlrltrpoView, i : Int, v : Double) -> MlrltrpoView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_view_sum(s : MlrltrpoView) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_view_mean(s : MlrltrpoView) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_view_scale(s : MlrltrpoView, f : Double) -> MlrltrpoView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_view_add(a : MlrltrpoView, b : MlrltrpoView) -> MlrltrpoView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_view_copy(s : MlrltrpoView) -> MlrltrpoView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_view_fill(s : MlrltrpoView, v : Double) -> MlrltrpoView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_view_min(s : MlrltrpoView) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_view_max(s : MlrltrpoView) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_view_to_string(s : MlrltrpoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_range_make(size : Int) -> MlrltrpoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_range_len(s : MlrltrpoRange) -> Int { s.size }

pub fn ml_rl_trpo_range_get(s : MlrltrpoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_range_set(s : MlrltrpoRange, i : Int, v : Double) -> MlrltrpoRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_range_sum(s : MlrltrpoRange) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_range_mean(s : MlrltrpoRange) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_range_scale(s : MlrltrpoRange, f : Double) -> MlrltrpoRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_range_add(a : MlrltrpoRange, b : MlrltrpoRange) -> MlrltrpoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_range_copy(s : MlrltrpoRange) -> MlrltrpoRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_range_fill(s : MlrltrpoRange, v : Double) -> MlrltrpoRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_range_min(s : MlrltrpoRange) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_range_max(s : MlrltrpoRange) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_range_to_string(s : MlrltrpoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_slice_make(size : Int) -> MlrltrpoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_slice_len(s : MlrltrpoSlice) -> Int { s.size }

pub fn ml_rl_trpo_slice_get(s : MlrltrpoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_slice_set(s : MlrltrpoSlice, i : Int, v : Double) -> MlrltrpoSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_slice_sum(s : MlrltrpoSlice) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_slice_mean(s : MlrltrpoSlice) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_slice_scale(s : MlrltrpoSlice, f : Double) -> MlrltrpoSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_slice_add(a : MlrltrpoSlice, b : MlrltrpoSlice) -> MlrltrpoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_slice_copy(s : MlrltrpoSlice) -> MlrltrpoSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_slice_fill(s : MlrltrpoSlice, v : Double) -> MlrltrpoSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_slice_min(s : MlrltrpoSlice) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_slice_max(s : MlrltrpoSlice) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_slice_to_string(s : MlrltrpoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

