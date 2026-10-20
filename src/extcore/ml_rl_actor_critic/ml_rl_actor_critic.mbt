///===
/// extcore/ml_rl_actor_critic

pub(all) struct MlrlactorcriticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_actor_critic_make_point(x : Double, y : Double) -> MlrlactorcriticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_actor_critic_make_point3(x : Double, y : Double, z : Double) -> MlrlactorcriticPoint {
  { x, y, z, label: 0 }
}

pub fn ml_rl_actor_critic_point_x(pt : MlrlactorcriticPoint) -> Double { pt.x }

pub fn ml_rl_actor_critic_point_y(pt : MlrlactorcriticPoint) -> Double { pt.y }

pub fn ml_rl_actor_critic_point_z(pt : MlrlactorcriticPoint) -> Double { pt.z }

pub fn ml_rl_actor_critic_point_label(pt : MlrlactorcriticPoint) -> Int { pt.label }

pub fn ml_rl_actor_critic_point_dist(a : MlrlactorcriticPoint, b : MlrlactorcriticPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_rl_actor_critic_point_add(a : MlrlactorcriticPoint, b : MlrlactorcriticPoint) -> MlrlactorcriticPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_rl_actor_critic_point_sub(a : MlrlactorcriticPoint, b : MlrlactorcriticPoint) -> MlrlactorcriticPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_rl_actor_critic_point_scale(pt : MlrlactorcriticPoint, s : Double) -> MlrlactorcriticPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_rl_actor_critic_point_dot(a : MlrlactorcriticPoint, b : MlrlactorcriticPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_rl_actor_critic_point_cross(a : MlrlactorcriticPoint, b : MlrlactorcriticPoint) -> MlrlactorcriticPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_rl_actor_critic_point_norm(pt : MlrlactorcriticPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_rl_actor_critic_point_normalize(pt : MlrlactorcriticPoint) -> MlrlactorcriticPoint {
  let n = ml_rl_actor_critic_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_rl_actor_critic_point_scale(pt, 1.0 / n) }
}

pub fn ml_rl_actor_critic_point_negate(pt : MlrlactorcriticPoint) -> MlrlactorcriticPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_rl_actor_critic_point_mid(a : MlrlactorcriticPoint, b : MlrlactorcriticPoint) -> MlrlactorcriticPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_rl_actor_critic_point_lerp(a : MlrlactorcriticPoint, b : MlrlactorcriticPoint, t : Double) -> MlrlactorcriticPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_rl_actor_critic_point_to_string(pt : MlrlactorcriticPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlrlactorcriticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_actor_critic_make_series(vals : Array[Double], name : String) -> MlrlactorcriticSeries {
  { vals, name, meta: 0 }
}

pub fn ml_rl_actor_critic_series_len(s : MlrlactorcriticSeries) -> Int { s.vals.length() }

pub fn ml_rl_actor_critic_series_sum(s : MlrlactorcriticSeries) -> Double { @_common.sum(s.vals) }

pub fn ml_rl_actor_critic_series_mean(s : MlrlactorcriticSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_rl_actor_critic_series_min(s : MlrlactorcriticSeries) -> Double { @_common.min(s.vals) }

pub fn ml_rl_actor_critic_series_max(s : MlrlactorcriticSeries) -> Double { @_common.max(s.vals) }

pub fn ml_rl_actor_critic_series_range(s : MlrlactorcriticSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_rl_actor_critic_series_var(s : MlrlactorcriticSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_rl_actor_critic_series_std(s : MlrlactorcriticSeries) -> Double { @_common.std(s.vals) }

pub fn ml_rl_actor_critic_series_median(s : MlrlactorcriticSeries) -> Double { @_common.median(s.vals) }

pub fn ml_rl_actor_critic_series_scale(s : MlrlactorcriticSeries, f : Double) -> MlrlactorcriticSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_rl_actor_critic_series_add(a : MlrlactorcriticSeries, b : MlrlactorcriticSeries) -> MlrlactorcriticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_rl_actor_critic_series_sub(a : MlrlactorcriticSeries, b : MlrlactorcriticSeries) -> MlrlactorcriticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_rl_actor_critic_series_normalize(s : MlrlactorcriticSeries) -> MlrlactorcriticSeries {
  let mn = ml_rl_actor_critic_series_min(s)
  let mx = ml_rl_actor_critic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_rl_actor_critic_series_cumsum(s : MlrlactorcriticSeries) -> MlrlactorcriticSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_rl_actor_critic_series_to_string(s : MlrlactorcriticSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlactorcriticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_actor_critic_make_matrix(rows : Int, cols : Int, val : Double) -> MlrlactorcriticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_actor_critic_matrix_identity(n : Int) -> MlrlactorcriticMatrix {
  let m = ml_rl_actor_critic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_rl_actor_critic_matrix_get(m : MlrlactorcriticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_rl_actor_critic_matrix_transpose(m : MlrlactorcriticMatrix) -> MlrlactorcriticMatrix {
  let result = ml_rl_actor_critic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_rl_actor_critic_matrix_add(a : MlrlactorcriticMatrix, b : MlrlactorcriticMatrix) -> MlrlactorcriticMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_rl_actor_critic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_rl_actor_critic_matrix_scale(m : MlrlactorcriticMatrix, s : Double) -> MlrlactorcriticMatrix {
  let result = ml_rl_actor_critic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_rl_actor_critic_matrix_multiply(a : MlrlactorcriticMatrix, b : MlrlactorcriticMatrix) -> MlrlactorcriticMatrix {
  if a.cols != b.rows { return ml_rl_actor_critic_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_rl_actor_critic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_rl_actor_critic_matrix_trace(m : MlrlactorcriticMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_rl_actor_critic_matrix_det(m : MlrlactorcriticMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_rl_actor_critic_matrix_norm(m : MlrlactorcriticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_rl_actor_critic_matrix_to_string(m : MlrlactorcriticMatrix) -> String {
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

pub(all) struct MlrlactorcriticVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_actor_critic_make_vector(comps : Array[Double]) -> MlrlactorcriticVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_actor_critic_vector_zero(dim : Int) -> MlrlactorcriticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_rl_actor_critic_vector_add(a : MlrlactorcriticVector, b : MlrlactorcriticVector) -> MlrlactorcriticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_rl_actor_critic_vector_sub(a : MlrlactorcriticVector, b : MlrlactorcriticVector) -> MlrlactorcriticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_rl_actor_critic_vector_scale(v : MlrlactorcriticVector, s : Double) -> MlrlactorcriticVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_rl_actor_critic_vector_dot(a : MlrlactorcriticVector, b : MlrlactorcriticVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_rl_actor_critic_vector_norm(v : MlrlactorcriticVector) -> Double { @_common.sqrt(ml_rl_actor_critic_vector_dot(v, v)) }

pub fn ml_rl_actor_critic_vector_normalize(v : MlrlactorcriticVector) -> MlrlactorcriticVector {
  let n = ml_rl_actor_critic_vector_norm(v)
  if n < 0.0000001 { v } else { ml_rl_actor_critic_vector_scale(v, 1.0 / n) }
}

pub fn ml_rl_actor_critic_vector_dist(a : MlrlactorcriticVector, b : MlrlactorcriticVector) -> Double {
  ml_rl_actor_critic_vector_norm(ml_rl_actor_critic_vector_sub(a, b))
}

pub fn ml_rl_actor_critic_vector_to_string(v : MlrlactorcriticVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_rl_actor_critic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_rl_actor_critic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_rl_actor_critic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_rl_actor_critic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_rl_actor_critic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_rl_actor_critic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_rl_actor_critic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_rl_actor_critic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_rl_actor_critic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_rl_actor_critic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_rl_actor_critic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_rl_actor_critic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_rl_actor_critic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_rl_actor_critic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_rl_actor_critic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_rl_actor_critic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_rl_actor_critic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_rl_actor_critic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_rl_actor_critic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_rl_actor_critic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_rl_actor_critic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_rl_actor_critic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_rl_actor_critic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_rl_actor_critic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_rl_actor_critic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_rl_actor_critic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_rl_actor_critic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_rl_actor_critic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_rl_actor_critic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlrlactorcriticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_frame_make(size : Int) -> MlrlactorcriticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_frame_len(s : MlrlactorcriticFrame) -> Int { s.size }

pub fn ml_rl_actor_critic_frame_get(s : MlrlactorcriticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_frame_set(s : MlrlactorcriticFrame, i : Int, v : Double) -> MlrlactorcriticFrame {
  let result = ml_rl_actor_critic_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_frame_sum(s : MlrlactorcriticFrame) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_frame_mean(s : MlrlactorcriticFrame) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_frame_scale(s : MlrlactorcriticFrame, f : Double) -> MlrlactorcriticFrame {
  let result = ml_rl_actor_critic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_frame_add(a : MlrlactorcriticFrame, b : MlrlactorcriticFrame) -> MlrlactorcriticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_frame_copy(s : MlrlactorcriticFrame) -> MlrlactorcriticFrame {
  let result = ml_rl_actor_critic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_frame_fill(s : MlrlactorcriticFrame, v : Double) -> MlrlactorcriticFrame {
  let result = ml_rl_actor_critic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_frame_min(s : MlrlactorcriticFrame) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_frame_max(s : MlrlactorcriticFrame) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_frame_to_string(s : MlrlactorcriticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_table_make(size : Int) -> MlrlactorcriticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_table_len(s : MlrlactorcriticTable) -> Int { s.size }

pub fn ml_rl_actor_critic_table_get(s : MlrlactorcriticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_table_set(s : MlrlactorcriticTable, i : Int, v : Double) -> MlrlactorcriticTable {
  let result = ml_rl_actor_critic_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_table_sum(s : MlrlactorcriticTable) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_table_mean(s : MlrlactorcriticTable) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_table_scale(s : MlrlactorcriticTable, f : Double) -> MlrlactorcriticTable {
  let result = ml_rl_actor_critic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_table_add(a : MlrlactorcriticTable, b : MlrlactorcriticTable) -> MlrlactorcriticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_table_copy(s : MlrlactorcriticTable) -> MlrlactorcriticTable {
  let result = ml_rl_actor_critic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_table_fill(s : MlrlactorcriticTable, v : Double) -> MlrlactorcriticTable {
  let result = ml_rl_actor_critic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_table_min(s : MlrlactorcriticTable) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_table_max(s : MlrlactorcriticTable) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_table_to_string(s : MlrlactorcriticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_graphn_make(size : Int) -> MlrlactorcriticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_graphn_len(s : MlrlactorcriticGraphN) -> Int { s.size }

pub fn ml_rl_actor_critic_graphn_get(s : MlrlactorcriticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_graphn_set(s : MlrlactorcriticGraphN, i : Int, v : Double) -> MlrlactorcriticGraphN {
  let result = ml_rl_actor_critic_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_graphn_sum(s : MlrlactorcriticGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_graphn_mean(s : MlrlactorcriticGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_graphn_scale(s : MlrlactorcriticGraphN, f : Double) -> MlrlactorcriticGraphN {
  let result = ml_rl_actor_critic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_graphn_add(a : MlrlactorcriticGraphN, b : MlrlactorcriticGraphN) -> MlrlactorcriticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_graphn_copy(s : MlrlactorcriticGraphN) -> MlrlactorcriticGraphN {
  let result = ml_rl_actor_critic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_graphn_fill(s : MlrlactorcriticGraphN, v : Double) -> MlrlactorcriticGraphN {
  let result = ml_rl_actor_critic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_graphn_min(s : MlrlactorcriticGraphN) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_graphn_max(s : MlrlactorcriticGraphN) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_graphn_to_string(s : MlrlactorcriticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_node_make(size : Int) -> MlrlactorcriticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_node_len(s : MlrlactorcriticNode) -> Int { s.size }

pub fn ml_rl_actor_critic_node_get(s : MlrlactorcriticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_node_set(s : MlrlactorcriticNode, i : Int, v : Double) -> MlrlactorcriticNode {
  let result = ml_rl_actor_critic_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_node_sum(s : MlrlactorcriticNode) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_node_mean(s : MlrlactorcriticNode) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_node_scale(s : MlrlactorcriticNode, f : Double) -> MlrlactorcriticNode {
  let result = ml_rl_actor_critic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_node_add(a : MlrlactorcriticNode, b : MlrlactorcriticNode) -> MlrlactorcriticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_node_copy(s : MlrlactorcriticNode) -> MlrlactorcriticNode {
  let result = ml_rl_actor_critic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_node_fill(s : MlrlactorcriticNode, v : Double) -> MlrlactorcriticNode {
  let result = ml_rl_actor_critic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_node_min(s : MlrlactorcriticNode) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_node_max(s : MlrlactorcriticNode) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_node_to_string(s : MlrlactorcriticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_edge_make(size : Int) -> MlrlactorcriticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_edge_len(s : MlrlactorcriticEdge) -> Int { s.size }

pub fn ml_rl_actor_critic_edge_get(s : MlrlactorcriticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_edge_set(s : MlrlactorcriticEdge, i : Int, v : Double) -> MlrlactorcriticEdge {
  let result = ml_rl_actor_critic_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_edge_sum(s : MlrlactorcriticEdge) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_edge_mean(s : MlrlactorcriticEdge) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_edge_scale(s : MlrlactorcriticEdge, f : Double) -> MlrlactorcriticEdge {
  let result = ml_rl_actor_critic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_edge_add(a : MlrlactorcriticEdge, b : MlrlactorcriticEdge) -> MlrlactorcriticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_edge_copy(s : MlrlactorcriticEdge) -> MlrlactorcriticEdge {
  let result = ml_rl_actor_critic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_edge_fill(s : MlrlactorcriticEdge, v : Double) -> MlrlactorcriticEdge {
  let result = ml_rl_actor_critic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_edge_min(s : MlrlactorcriticEdge) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_edge_max(s : MlrlactorcriticEdge) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_edge_to_string(s : MlrlactorcriticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_path_make(size : Int) -> MlrlactorcriticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_path_len(s : MlrlactorcriticPath) -> Int { s.size }

pub fn ml_rl_actor_critic_path_get(s : MlrlactorcriticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_path_set(s : MlrlactorcriticPath, i : Int, v : Double) -> MlrlactorcriticPath {
  let result = ml_rl_actor_critic_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_path_sum(s : MlrlactorcriticPath) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_path_mean(s : MlrlactorcriticPath) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_path_scale(s : MlrlactorcriticPath, f : Double) -> MlrlactorcriticPath {
  let result = ml_rl_actor_critic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_path_add(a : MlrlactorcriticPath, b : MlrlactorcriticPath) -> MlrlactorcriticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_path_copy(s : MlrlactorcriticPath) -> MlrlactorcriticPath {
  let result = ml_rl_actor_critic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_path_fill(s : MlrlactorcriticPath, v : Double) -> MlrlactorcriticPath {
  let result = ml_rl_actor_critic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_path_min(s : MlrlactorcriticPath) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_path_max(s : MlrlactorcriticPath) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_path_to_string(s : MlrlactorcriticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_cluster_make(size : Int) -> MlrlactorcriticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_cluster_len(s : MlrlactorcriticCluster) -> Int { s.size }

pub fn ml_rl_actor_critic_cluster_get(s : MlrlactorcriticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_cluster_set(s : MlrlactorcriticCluster, i : Int, v : Double) -> MlrlactorcriticCluster {
  let result = ml_rl_actor_critic_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_cluster_sum(s : MlrlactorcriticCluster) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_cluster_mean(s : MlrlactorcriticCluster) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_cluster_scale(s : MlrlactorcriticCluster, f : Double) -> MlrlactorcriticCluster {
  let result = ml_rl_actor_critic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_cluster_add(a : MlrlactorcriticCluster, b : MlrlactorcriticCluster) -> MlrlactorcriticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_cluster_copy(s : MlrlactorcriticCluster) -> MlrlactorcriticCluster {
  let result = ml_rl_actor_critic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_cluster_fill(s : MlrlactorcriticCluster, v : Double) -> MlrlactorcriticCluster {
  let result = ml_rl_actor_critic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_cluster_min(s : MlrlactorcriticCluster) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_cluster_max(s : MlrlactorcriticCluster) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_cluster_to_string(s : MlrlactorcriticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_model_make(size : Int) -> MlrlactorcriticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_model_len(s : MlrlactorcriticModel) -> Int { s.size }

pub fn ml_rl_actor_critic_model_get(s : MlrlactorcriticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_model_set(s : MlrlactorcriticModel, i : Int, v : Double) -> MlrlactorcriticModel {
  let result = ml_rl_actor_critic_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_model_sum(s : MlrlactorcriticModel) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_model_mean(s : MlrlactorcriticModel) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_model_scale(s : MlrlactorcriticModel, f : Double) -> MlrlactorcriticModel {
  let result = ml_rl_actor_critic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_model_add(a : MlrlactorcriticModel, b : MlrlactorcriticModel) -> MlrlactorcriticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_model_copy(s : MlrlactorcriticModel) -> MlrlactorcriticModel {
  let result = ml_rl_actor_critic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_model_fill(s : MlrlactorcriticModel, v : Double) -> MlrlactorcriticModel {
  let result = ml_rl_actor_critic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_model_min(s : MlrlactorcriticModel) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_model_max(s : MlrlactorcriticModel) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_model_to_string(s : MlrlactorcriticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_layer_make(size : Int) -> MlrlactorcriticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_layer_len(s : MlrlactorcriticLayer) -> Int { s.size }

pub fn ml_rl_actor_critic_layer_get(s : MlrlactorcriticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_layer_set(s : MlrlactorcriticLayer, i : Int, v : Double) -> MlrlactorcriticLayer {
  let result = ml_rl_actor_critic_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_layer_sum(s : MlrlactorcriticLayer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_layer_mean(s : MlrlactorcriticLayer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_layer_scale(s : MlrlactorcriticLayer, f : Double) -> MlrlactorcriticLayer {
  let result = ml_rl_actor_critic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_layer_add(a : MlrlactorcriticLayer, b : MlrlactorcriticLayer) -> MlrlactorcriticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_layer_copy(s : MlrlactorcriticLayer) -> MlrlactorcriticLayer {
  let result = ml_rl_actor_critic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_layer_fill(s : MlrlactorcriticLayer, v : Double) -> MlrlactorcriticLayer {
  let result = ml_rl_actor_critic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_layer_min(s : MlrlactorcriticLayer) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_layer_max(s : MlrlactorcriticLayer) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_layer_to_string(s : MlrlactorcriticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_buffer_make(size : Int) -> MlrlactorcriticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_buffer_len(s : MlrlactorcriticBuffer) -> Int { s.size }

pub fn ml_rl_actor_critic_buffer_get(s : MlrlactorcriticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_buffer_set(s : MlrlactorcriticBuffer, i : Int, v : Double) -> MlrlactorcriticBuffer {
  let result = ml_rl_actor_critic_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_buffer_sum(s : MlrlactorcriticBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_buffer_mean(s : MlrlactorcriticBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_buffer_scale(s : MlrlactorcriticBuffer, f : Double) -> MlrlactorcriticBuffer {
  let result = ml_rl_actor_critic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_buffer_add(a : MlrlactorcriticBuffer, b : MlrlactorcriticBuffer) -> MlrlactorcriticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_buffer_copy(s : MlrlactorcriticBuffer) -> MlrlactorcriticBuffer {
  let result = ml_rl_actor_critic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_buffer_fill(s : MlrlactorcriticBuffer, v : Double) -> MlrlactorcriticBuffer {
  let result = ml_rl_actor_critic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_buffer_min(s : MlrlactorcriticBuffer) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_buffer_max(s : MlrlactorcriticBuffer) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_buffer_to_string(s : MlrlactorcriticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_cursor_make(size : Int) -> MlrlactorcriticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_cursor_len(s : MlrlactorcriticCursor) -> Int { s.size }

pub fn ml_rl_actor_critic_cursor_get(s : MlrlactorcriticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_cursor_set(s : MlrlactorcriticCursor, i : Int, v : Double) -> MlrlactorcriticCursor {
  let result = ml_rl_actor_critic_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_cursor_sum(s : MlrlactorcriticCursor) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_cursor_mean(s : MlrlactorcriticCursor) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_cursor_scale(s : MlrlactorcriticCursor, f : Double) -> MlrlactorcriticCursor {
  let result = ml_rl_actor_critic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_cursor_add(a : MlrlactorcriticCursor, b : MlrlactorcriticCursor) -> MlrlactorcriticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_cursor_copy(s : MlrlactorcriticCursor) -> MlrlactorcriticCursor {
  let result = ml_rl_actor_critic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_cursor_fill(s : MlrlactorcriticCursor, v : Double) -> MlrlactorcriticCursor {
  let result = ml_rl_actor_critic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_cursor_min(s : MlrlactorcriticCursor) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_cursor_max(s : MlrlactorcriticCursor) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_cursor_to_string(s : MlrlactorcriticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_view_make(size : Int) -> MlrlactorcriticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_view_len(s : MlrlactorcriticView) -> Int { s.size }

pub fn ml_rl_actor_critic_view_get(s : MlrlactorcriticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_view_set(s : MlrlactorcriticView, i : Int, v : Double) -> MlrlactorcriticView {
  let result = ml_rl_actor_critic_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_view_sum(s : MlrlactorcriticView) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_view_mean(s : MlrlactorcriticView) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_view_scale(s : MlrlactorcriticView, f : Double) -> MlrlactorcriticView {
  let result = ml_rl_actor_critic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_view_add(a : MlrlactorcriticView, b : MlrlactorcriticView) -> MlrlactorcriticView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_view_copy(s : MlrlactorcriticView) -> MlrlactorcriticView {
  let result = ml_rl_actor_critic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_view_fill(s : MlrlactorcriticView, v : Double) -> MlrlactorcriticView {
  let result = ml_rl_actor_critic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_view_min(s : MlrlactorcriticView) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_view_max(s : MlrlactorcriticView) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_view_to_string(s : MlrlactorcriticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_range_make(size : Int) -> MlrlactorcriticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_range_len(s : MlrlactorcriticRange) -> Int { s.size }

pub fn ml_rl_actor_critic_range_get(s : MlrlactorcriticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_range_set(s : MlrlactorcriticRange, i : Int, v : Double) -> MlrlactorcriticRange {
  let result = ml_rl_actor_critic_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_range_sum(s : MlrlactorcriticRange) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_range_mean(s : MlrlactorcriticRange) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_range_scale(s : MlrlactorcriticRange, f : Double) -> MlrlactorcriticRange {
  let result = ml_rl_actor_critic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_range_add(a : MlrlactorcriticRange, b : MlrlactorcriticRange) -> MlrlactorcriticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_range_copy(s : MlrlactorcriticRange) -> MlrlactorcriticRange {
  let result = ml_rl_actor_critic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_range_fill(s : MlrlactorcriticRange, v : Double) -> MlrlactorcriticRange {
  let result = ml_rl_actor_critic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_range_min(s : MlrlactorcriticRange) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_range_max(s : MlrlactorcriticRange) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_range_to_string(s : MlrlactorcriticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_slice_make(size : Int) -> MlrlactorcriticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_slice_len(s : MlrlactorcriticSlice) -> Int { s.size }

pub fn ml_rl_actor_critic_slice_get(s : MlrlactorcriticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_slice_set(s : MlrlactorcriticSlice, i : Int, v : Double) -> MlrlactorcriticSlice {
  let result = ml_rl_actor_critic_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_slice_sum(s : MlrlactorcriticSlice) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_slice_mean(s : MlrlactorcriticSlice) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_slice_scale(s : MlrlactorcriticSlice, f : Double) -> MlrlactorcriticSlice {
  let result = ml_rl_actor_critic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_slice_add(a : MlrlactorcriticSlice, b : MlrlactorcriticSlice) -> MlrlactorcriticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_slice_copy(s : MlrlactorcriticSlice) -> MlrlactorcriticSlice {
  let result = ml_rl_actor_critic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_slice_fill(s : MlrlactorcriticSlice, v : Double) -> MlrlactorcriticSlice {
  let result = ml_rl_actor_critic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_slice_min(s : MlrlactorcriticSlice) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_slice_max(s : MlrlactorcriticSlice) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_slice_to_string(s : MlrlactorcriticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

