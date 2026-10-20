///===
/// extcore/ml_rl_sac

pub(all) struct MlrlsacPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_sac_make_point(x : Double, y : Double) -> MlrlsacPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_sac_make_point3(x : Double, y : Double, z : Double) -> MlrlsacPoint {
  { x, y, z, label: 0 }
}

pub fn ml_rl_sac_point_x(pt : MlrlsacPoint) -> Double { pt.x }

pub fn ml_rl_sac_point_y(pt : MlrlsacPoint) -> Double { pt.y }

pub fn ml_rl_sac_point_z(pt : MlrlsacPoint) -> Double { pt.z }

pub fn ml_rl_sac_point_label(pt : MlrlsacPoint) -> Int { pt.label }

pub fn ml_rl_sac_point_dist(a : MlrlsacPoint, b : MlrlsacPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_rl_sac_point_add(a : MlrlsacPoint, b : MlrlsacPoint) -> MlrlsacPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_rl_sac_point_sub(a : MlrlsacPoint, b : MlrlsacPoint) -> MlrlsacPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_rl_sac_point_scale(pt : MlrlsacPoint, s : Double) -> MlrlsacPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_rl_sac_point_dot(a : MlrlsacPoint, b : MlrlsacPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_rl_sac_point_cross(a : MlrlsacPoint, b : MlrlsacPoint) -> MlrlsacPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_rl_sac_point_norm(pt : MlrlsacPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_rl_sac_point_normalize(pt : MlrlsacPoint) -> MlrlsacPoint {
  let n = ml_rl_sac_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_rl_sac_point_scale(pt, 1.0 / n) }
}

pub fn ml_rl_sac_point_negate(pt : MlrlsacPoint) -> MlrlsacPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_rl_sac_point_mid(a : MlrlsacPoint, b : MlrlsacPoint) -> MlrlsacPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_rl_sac_point_lerp(a : MlrlsacPoint, b : MlrlsacPoint, t : Double) -> MlrlsacPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_rl_sac_point_to_string(pt : MlrlsacPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlrlsacSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_sac_make_series(vals : Array[Double], name : String) -> MlrlsacSeries {
  { vals, name, meta: 0 }
}

pub fn ml_rl_sac_series_len(s : MlrlsacSeries) -> Int { s.vals.length() }

pub fn ml_rl_sac_series_sum(s : MlrlsacSeries) -> Double { @_common.sum(s.vals) }

pub fn ml_rl_sac_series_mean(s : MlrlsacSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_rl_sac_series_min(s : MlrlsacSeries) -> Double { @_common.min(s.vals) }

pub fn ml_rl_sac_series_max(s : MlrlsacSeries) -> Double { @_common.max(s.vals) }

pub fn ml_rl_sac_series_range(s : MlrlsacSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_rl_sac_series_var(s : MlrlsacSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_rl_sac_series_std(s : MlrlsacSeries) -> Double { @_common.std(s.vals) }

pub fn ml_rl_sac_series_median(s : MlrlsacSeries) -> Double { @_common.median(s.vals) }

pub fn ml_rl_sac_series_scale(s : MlrlsacSeries, f : Double) -> MlrlsacSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_rl_sac_series_add(a : MlrlsacSeries, b : MlrlsacSeries) -> MlrlsacSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_rl_sac_series_sub(a : MlrlsacSeries, b : MlrlsacSeries) -> MlrlsacSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_rl_sac_series_normalize(s : MlrlsacSeries) -> MlrlsacSeries {
  let mn = ml_rl_sac_series_min(s)
  let mx = ml_rl_sac_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_rl_sac_series_cumsum(s : MlrlsacSeries) -> MlrlsacSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_rl_sac_series_to_string(s : MlrlsacSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlsacMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_sac_make_matrix(rows : Int, cols : Int, val : Double) -> MlrlsacMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_sac_matrix_identity(n : Int) -> MlrlsacMatrix {
  let m = ml_rl_sac_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_rl_sac_matrix_get(m : MlrlsacMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_rl_sac_matrix_transpose(m : MlrlsacMatrix) -> MlrlsacMatrix {
  let result = ml_rl_sac_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_rl_sac_matrix_add(a : MlrlsacMatrix, b : MlrlsacMatrix) -> MlrlsacMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_rl_sac_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_rl_sac_matrix_scale(m : MlrlsacMatrix, s : Double) -> MlrlsacMatrix {
  let result = ml_rl_sac_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_rl_sac_matrix_multiply(a : MlrlsacMatrix, b : MlrlsacMatrix) -> MlrlsacMatrix {
  if a.cols != b.rows { return ml_rl_sac_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_rl_sac_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_rl_sac_matrix_trace(m : MlrlsacMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_rl_sac_matrix_det(m : MlrlsacMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_rl_sac_matrix_norm(m : MlrlsacMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_rl_sac_matrix_to_string(m : MlrlsacMatrix) -> String {
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

pub(all) struct MlrlsacVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_sac_make_vector(comps : Array[Double]) -> MlrlsacVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_sac_vector_zero(dim : Int) -> MlrlsacVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_rl_sac_vector_add(a : MlrlsacVector, b : MlrlsacVector) -> MlrlsacVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_rl_sac_vector_sub(a : MlrlsacVector, b : MlrlsacVector) -> MlrlsacVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_rl_sac_vector_scale(v : MlrlsacVector, s : Double) -> MlrlsacVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_rl_sac_vector_dot(a : MlrlsacVector, b : MlrlsacVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_rl_sac_vector_norm(v : MlrlsacVector) -> Double { @_common.sqrt(ml_rl_sac_vector_dot(v, v)) }

pub fn ml_rl_sac_vector_normalize(v : MlrlsacVector) -> MlrlsacVector {
  let n = ml_rl_sac_vector_norm(v)
  if n < 0.0000001 { v } else { ml_rl_sac_vector_scale(v, 1.0 / n) }
}

pub fn ml_rl_sac_vector_dist(a : MlrlsacVector, b : MlrlsacVector) -> Double {
  ml_rl_sac_vector_norm(ml_rl_sac_vector_sub(a, b))
}

pub fn ml_rl_sac_vector_to_string(v : MlrlsacVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_rl_sac_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_rl_sac_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_rl_sac_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_rl_sac_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_rl_sac_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_rl_sac_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_rl_sac_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_rl_sac_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_rl_sac_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_rl_sac_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_rl_sac_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_rl_sac_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_rl_sac_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_rl_sac_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_rl_sac_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_rl_sac_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_rl_sac_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_rl_sac_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_rl_sac_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_rl_sac_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_rl_sac_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_rl_sac_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_rl_sac_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_rl_sac_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_rl_sac_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_rl_sac_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_rl_sac_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_rl_sac_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_rl_sac_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlrlsacFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_frame_make(size : Int) -> MlrlsacFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sac_frame_len(s : MlrlsacFrame) -> Int { s.size }

pub fn ml_rl_sac_frame_get(s : MlrlsacFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sac_frame_set(s : MlrlsacFrame, i : Int, v : Double) -> MlrlsacFrame {
  let result = ml_rl_sac_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sac_frame_sum(s : MlrlsacFrame) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sac_frame_mean(s : MlrlsacFrame) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sac_frame_scale(s : MlrlsacFrame, f : Double) -> MlrlsacFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_frame_add(a : MlrlsacFrame, b : MlrlsacFrame) -> MlrlsacFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_sac_frame_copy(s : MlrlsacFrame) -> MlrlsacFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_frame_fill(s : MlrlsacFrame, v : Double) -> MlrlsacFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_frame_min(s : MlrlsacFrame) -> Double { @_common.min(s.data) }

pub fn ml_rl_sac_frame_max(s : MlrlsacFrame) -> Double { @_common.max(s.data) }

pub fn ml_rl_sac_frame_to_string(s : MlrlsacFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsacTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_table_make(size : Int) -> MlrlsacTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sac_table_len(s : MlrlsacTable) -> Int { s.size }

pub fn ml_rl_sac_table_get(s : MlrlsacTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sac_table_set(s : MlrlsacTable, i : Int, v : Double) -> MlrlsacTable {
  let result = ml_rl_sac_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sac_table_sum(s : MlrlsacTable) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sac_table_mean(s : MlrlsacTable) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sac_table_scale(s : MlrlsacTable, f : Double) -> MlrlsacTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_table_add(a : MlrlsacTable, b : MlrlsacTable) -> MlrlsacTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_sac_table_copy(s : MlrlsacTable) -> MlrlsacTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_table_fill(s : MlrlsacTable, v : Double) -> MlrlsacTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_table_min(s : MlrlsacTable) -> Double { @_common.min(s.data) }

pub fn ml_rl_sac_table_max(s : MlrlsacTable) -> Double { @_common.max(s.data) }

pub fn ml_rl_sac_table_to_string(s : MlrlsacTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsacGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_graphn_make(size : Int) -> MlrlsacGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sac_graphn_len(s : MlrlsacGraphN) -> Int { s.size }

pub fn ml_rl_sac_graphn_get(s : MlrlsacGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sac_graphn_set(s : MlrlsacGraphN, i : Int, v : Double) -> MlrlsacGraphN {
  let result = ml_rl_sac_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sac_graphn_sum(s : MlrlsacGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sac_graphn_mean(s : MlrlsacGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sac_graphn_scale(s : MlrlsacGraphN, f : Double) -> MlrlsacGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_graphn_add(a : MlrlsacGraphN, b : MlrlsacGraphN) -> MlrlsacGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_sac_graphn_copy(s : MlrlsacGraphN) -> MlrlsacGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_graphn_fill(s : MlrlsacGraphN, v : Double) -> MlrlsacGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_graphn_min(s : MlrlsacGraphN) -> Double { @_common.min(s.data) }

pub fn ml_rl_sac_graphn_max(s : MlrlsacGraphN) -> Double { @_common.max(s.data) }

pub fn ml_rl_sac_graphn_to_string(s : MlrlsacGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsacNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_node_make(size : Int) -> MlrlsacNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sac_node_len(s : MlrlsacNode) -> Int { s.size }

pub fn ml_rl_sac_node_get(s : MlrlsacNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sac_node_set(s : MlrlsacNode, i : Int, v : Double) -> MlrlsacNode {
  let result = ml_rl_sac_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sac_node_sum(s : MlrlsacNode) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sac_node_mean(s : MlrlsacNode) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sac_node_scale(s : MlrlsacNode, f : Double) -> MlrlsacNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_node_add(a : MlrlsacNode, b : MlrlsacNode) -> MlrlsacNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_sac_node_copy(s : MlrlsacNode) -> MlrlsacNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_node_fill(s : MlrlsacNode, v : Double) -> MlrlsacNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_node_min(s : MlrlsacNode) -> Double { @_common.min(s.data) }

pub fn ml_rl_sac_node_max(s : MlrlsacNode) -> Double { @_common.max(s.data) }

pub fn ml_rl_sac_node_to_string(s : MlrlsacNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsacEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_edge_make(size : Int) -> MlrlsacEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sac_edge_len(s : MlrlsacEdge) -> Int { s.size }

pub fn ml_rl_sac_edge_get(s : MlrlsacEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sac_edge_set(s : MlrlsacEdge, i : Int, v : Double) -> MlrlsacEdge {
  let result = ml_rl_sac_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sac_edge_sum(s : MlrlsacEdge) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sac_edge_mean(s : MlrlsacEdge) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sac_edge_scale(s : MlrlsacEdge, f : Double) -> MlrlsacEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_edge_add(a : MlrlsacEdge, b : MlrlsacEdge) -> MlrlsacEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_sac_edge_copy(s : MlrlsacEdge) -> MlrlsacEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_edge_fill(s : MlrlsacEdge, v : Double) -> MlrlsacEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_edge_min(s : MlrlsacEdge) -> Double { @_common.min(s.data) }

pub fn ml_rl_sac_edge_max(s : MlrlsacEdge) -> Double { @_common.max(s.data) }

pub fn ml_rl_sac_edge_to_string(s : MlrlsacEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsacPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_path_make(size : Int) -> MlrlsacPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sac_path_len(s : MlrlsacPath) -> Int { s.size }

pub fn ml_rl_sac_path_get(s : MlrlsacPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sac_path_set(s : MlrlsacPath, i : Int, v : Double) -> MlrlsacPath {
  let result = ml_rl_sac_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sac_path_sum(s : MlrlsacPath) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sac_path_mean(s : MlrlsacPath) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sac_path_scale(s : MlrlsacPath, f : Double) -> MlrlsacPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_path_add(a : MlrlsacPath, b : MlrlsacPath) -> MlrlsacPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_sac_path_copy(s : MlrlsacPath) -> MlrlsacPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_path_fill(s : MlrlsacPath, v : Double) -> MlrlsacPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_path_min(s : MlrlsacPath) -> Double { @_common.min(s.data) }

pub fn ml_rl_sac_path_max(s : MlrlsacPath) -> Double { @_common.max(s.data) }

pub fn ml_rl_sac_path_to_string(s : MlrlsacPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsacCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_cluster_make(size : Int) -> MlrlsacCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sac_cluster_len(s : MlrlsacCluster) -> Int { s.size }

pub fn ml_rl_sac_cluster_get(s : MlrlsacCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sac_cluster_set(s : MlrlsacCluster, i : Int, v : Double) -> MlrlsacCluster {
  let result = ml_rl_sac_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sac_cluster_sum(s : MlrlsacCluster) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sac_cluster_mean(s : MlrlsacCluster) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sac_cluster_scale(s : MlrlsacCluster, f : Double) -> MlrlsacCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_cluster_add(a : MlrlsacCluster, b : MlrlsacCluster) -> MlrlsacCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_sac_cluster_copy(s : MlrlsacCluster) -> MlrlsacCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_cluster_fill(s : MlrlsacCluster, v : Double) -> MlrlsacCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_cluster_min(s : MlrlsacCluster) -> Double { @_common.min(s.data) }

pub fn ml_rl_sac_cluster_max(s : MlrlsacCluster) -> Double { @_common.max(s.data) }

pub fn ml_rl_sac_cluster_to_string(s : MlrlsacCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsacModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_model_make(size : Int) -> MlrlsacModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sac_model_len(s : MlrlsacModel) -> Int { s.size }

pub fn ml_rl_sac_model_get(s : MlrlsacModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sac_model_set(s : MlrlsacModel, i : Int, v : Double) -> MlrlsacModel {
  let result = ml_rl_sac_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sac_model_sum(s : MlrlsacModel) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sac_model_mean(s : MlrlsacModel) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sac_model_scale(s : MlrlsacModel, f : Double) -> MlrlsacModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_model_add(a : MlrlsacModel, b : MlrlsacModel) -> MlrlsacModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_sac_model_copy(s : MlrlsacModel) -> MlrlsacModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_model_fill(s : MlrlsacModel, v : Double) -> MlrlsacModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_model_min(s : MlrlsacModel) -> Double { @_common.min(s.data) }

pub fn ml_rl_sac_model_max(s : MlrlsacModel) -> Double { @_common.max(s.data) }

pub fn ml_rl_sac_model_to_string(s : MlrlsacModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsacLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_layer_make(size : Int) -> MlrlsacLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sac_layer_len(s : MlrlsacLayer) -> Int { s.size }

pub fn ml_rl_sac_layer_get(s : MlrlsacLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sac_layer_set(s : MlrlsacLayer, i : Int, v : Double) -> MlrlsacLayer {
  let result = ml_rl_sac_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sac_layer_sum(s : MlrlsacLayer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sac_layer_mean(s : MlrlsacLayer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sac_layer_scale(s : MlrlsacLayer, f : Double) -> MlrlsacLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_layer_add(a : MlrlsacLayer, b : MlrlsacLayer) -> MlrlsacLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_sac_layer_copy(s : MlrlsacLayer) -> MlrlsacLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_layer_fill(s : MlrlsacLayer, v : Double) -> MlrlsacLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_layer_min(s : MlrlsacLayer) -> Double { @_common.min(s.data) }

pub fn ml_rl_sac_layer_max(s : MlrlsacLayer) -> Double { @_common.max(s.data) }

pub fn ml_rl_sac_layer_to_string(s : MlrlsacLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsacBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_buffer_make(size : Int) -> MlrlsacBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sac_buffer_len(s : MlrlsacBuffer) -> Int { s.size }

pub fn ml_rl_sac_buffer_get(s : MlrlsacBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sac_buffer_set(s : MlrlsacBuffer, i : Int, v : Double) -> MlrlsacBuffer {
  let result = ml_rl_sac_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sac_buffer_sum(s : MlrlsacBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sac_buffer_mean(s : MlrlsacBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sac_buffer_scale(s : MlrlsacBuffer, f : Double) -> MlrlsacBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_buffer_add(a : MlrlsacBuffer, b : MlrlsacBuffer) -> MlrlsacBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_sac_buffer_copy(s : MlrlsacBuffer) -> MlrlsacBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_buffer_fill(s : MlrlsacBuffer, v : Double) -> MlrlsacBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_buffer_min(s : MlrlsacBuffer) -> Double { @_common.min(s.data) }

pub fn ml_rl_sac_buffer_max(s : MlrlsacBuffer) -> Double { @_common.max(s.data) }

pub fn ml_rl_sac_buffer_to_string(s : MlrlsacBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsacCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_cursor_make(size : Int) -> MlrlsacCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sac_cursor_len(s : MlrlsacCursor) -> Int { s.size }

pub fn ml_rl_sac_cursor_get(s : MlrlsacCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sac_cursor_set(s : MlrlsacCursor, i : Int, v : Double) -> MlrlsacCursor {
  let result = ml_rl_sac_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sac_cursor_sum(s : MlrlsacCursor) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sac_cursor_mean(s : MlrlsacCursor) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sac_cursor_scale(s : MlrlsacCursor, f : Double) -> MlrlsacCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_cursor_add(a : MlrlsacCursor, b : MlrlsacCursor) -> MlrlsacCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_sac_cursor_copy(s : MlrlsacCursor) -> MlrlsacCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_cursor_fill(s : MlrlsacCursor, v : Double) -> MlrlsacCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_cursor_min(s : MlrlsacCursor) -> Double { @_common.min(s.data) }

pub fn ml_rl_sac_cursor_max(s : MlrlsacCursor) -> Double { @_common.max(s.data) }

pub fn ml_rl_sac_cursor_to_string(s : MlrlsacCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsacView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_view_make(size : Int) -> MlrlsacView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sac_view_len(s : MlrlsacView) -> Int { s.size }

pub fn ml_rl_sac_view_get(s : MlrlsacView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sac_view_set(s : MlrlsacView, i : Int, v : Double) -> MlrlsacView {
  let result = ml_rl_sac_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sac_view_sum(s : MlrlsacView) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sac_view_mean(s : MlrlsacView) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sac_view_scale(s : MlrlsacView, f : Double) -> MlrlsacView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_view_add(a : MlrlsacView, b : MlrlsacView) -> MlrlsacView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_sac_view_copy(s : MlrlsacView) -> MlrlsacView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_view_fill(s : MlrlsacView, v : Double) -> MlrlsacView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_view_min(s : MlrlsacView) -> Double { @_common.min(s.data) }

pub fn ml_rl_sac_view_max(s : MlrlsacView) -> Double { @_common.max(s.data) }

pub fn ml_rl_sac_view_to_string(s : MlrlsacView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsacRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_range_make(size : Int) -> MlrlsacRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sac_range_len(s : MlrlsacRange) -> Int { s.size }

pub fn ml_rl_sac_range_get(s : MlrlsacRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sac_range_set(s : MlrlsacRange, i : Int, v : Double) -> MlrlsacRange {
  let result = ml_rl_sac_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sac_range_sum(s : MlrlsacRange) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sac_range_mean(s : MlrlsacRange) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sac_range_scale(s : MlrlsacRange, f : Double) -> MlrlsacRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_range_add(a : MlrlsacRange, b : MlrlsacRange) -> MlrlsacRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_sac_range_copy(s : MlrlsacRange) -> MlrlsacRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_range_fill(s : MlrlsacRange, v : Double) -> MlrlsacRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_range_min(s : MlrlsacRange) -> Double { @_common.min(s.data) }

pub fn ml_rl_sac_range_max(s : MlrlsacRange) -> Double { @_common.max(s.data) }

pub fn ml_rl_sac_range_to_string(s : MlrlsacRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsacSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sac_slice_make(size : Int) -> MlrlsacSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sac_slice_len(s : MlrlsacSlice) -> Int { s.size }

pub fn ml_rl_sac_slice_get(s : MlrlsacSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sac_slice_set(s : MlrlsacSlice, i : Int, v : Double) -> MlrlsacSlice {
  let result = ml_rl_sac_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sac_slice_sum(s : MlrlsacSlice) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sac_slice_mean(s : MlrlsacSlice) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sac_slice_scale(s : MlrlsacSlice, f : Double) -> MlrlsacSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_slice_add(a : MlrlsacSlice, b : MlrlsacSlice) -> MlrlsacSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_sac_slice_copy(s : MlrlsacSlice) -> MlrlsacSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_slice_fill(s : MlrlsacSlice, v : Double) -> MlrlsacSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_sac_slice_min(s : MlrlsacSlice) -> Double { @_common.min(s.data) }

pub fn ml_rl_sac_slice_max(s : MlrlsacSlice) -> Double { @_common.max(s.data) }

pub fn ml_rl_sac_slice_to_string(s : MlrlsacSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

