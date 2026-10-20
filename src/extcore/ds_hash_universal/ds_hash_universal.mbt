///===
/// extcore/ds_hash_universal

pub(all) struct DshashuniversalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_universal_make_point(x : Double, y : Double) -> DshashuniversalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_universal_make_point3(x : Double, y : Double, z : Double) -> DshashuniversalPoint {
  { x, y, z, label: 0 }
}

pub fn ds_hash_universal_point_x(pt : DshashuniversalPoint) -> Double { pt.x }

pub fn ds_hash_universal_point_y(pt : DshashuniversalPoint) -> Double { pt.y }

pub fn ds_hash_universal_point_z(pt : DshashuniversalPoint) -> Double { pt.z }

pub fn ds_hash_universal_point_label(pt : DshashuniversalPoint) -> Int { pt.label }

pub fn ds_hash_universal_point_dist(a : DshashuniversalPoint, b : DshashuniversalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_hash_universal_point_add(a : DshashuniversalPoint, b : DshashuniversalPoint) -> DshashuniversalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_hash_universal_point_sub(a : DshashuniversalPoint, b : DshashuniversalPoint) -> DshashuniversalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_hash_universal_point_scale(pt : DshashuniversalPoint, s : Double) -> DshashuniversalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_hash_universal_point_dot(a : DshashuniversalPoint, b : DshashuniversalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_hash_universal_point_cross(a : DshashuniversalPoint, b : DshashuniversalPoint) -> DshashuniversalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_hash_universal_point_norm(pt : DshashuniversalPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_hash_universal_point_normalize(pt : DshashuniversalPoint) -> DshashuniversalPoint {
  let n = ds_hash_universal_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_hash_universal_point_scale(pt, 1.0 / n) }
}

pub fn ds_hash_universal_point_negate(pt : DshashuniversalPoint) -> DshashuniversalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_hash_universal_point_mid(a : DshashuniversalPoint, b : DshashuniversalPoint) -> DshashuniversalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_hash_universal_point_lerp(a : DshashuniversalPoint, b : DshashuniversalPoint, t : Double) -> DshashuniversalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_hash_universal_point_to_string(pt : DshashuniversalPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DshashuniversalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_universal_make_series(vals : Array[Double], name : String) -> DshashuniversalSeries {
  { vals, name, meta: 0 }
}

pub fn ds_hash_universal_series_len(s : DshashuniversalSeries) -> Int { s.vals.length() }

pub fn ds_hash_universal_series_sum(s : DshashuniversalSeries) -> Double { @_common.sum(s.vals) }

pub fn ds_hash_universal_series_mean(s : DshashuniversalSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_hash_universal_series_min(s : DshashuniversalSeries) -> Double { @_common.min(s.vals) }

pub fn ds_hash_universal_series_max(s : DshashuniversalSeries) -> Double { @_common.max(s.vals) }

pub fn ds_hash_universal_series_range(s : DshashuniversalSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_hash_universal_series_var(s : DshashuniversalSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_hash_universal_series_std(s : DshashuniversalSeries) -> Double { @_common.std(s.vals) }

pub fn ds_hash_universal_series_median(s : DshashuniversalSeries) -> Double { @_common.median(s.vals) }

pub fn ds_hash_universal_series_scale(s : DshashuniversalSeries, f : Double) -> DshashuniversalSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_hash_universal_series_add(a : DshashuniversalSeries, b : DshashuniversalSeries) -> DshashuniversalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_hash_universal_series_sub(a : DshashuniversalSeries, b : DshashuniversalSeries) -> DshashuniversalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_hash_universal_series_normalize(s : DshashuniversalSeries) -> DshashuniversalSeries {
  let mn = ds_hash_universal_series_min(s)
  let mx = ds_hash_universal_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_hash_universal_series_cumsum(s : DshashuniversalSeries) -> DshashuniversalSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_hash_universal_series_to_string(s : DshashuniversalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashuniversalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_universal_make_matrix(rows : Int, cols : Int, val : Double) -> DshashuniversalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_universal_matrix_identity(n : Int) -> DshashuniversalMatrix {
  let m = ds_hash_universal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_hash_universal_matrix_get(m : DshashuniversalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_hash_universal_matrix_transpose(m : DshashuniversalMatrix) -> DshashuniversalMatrix {
  let result = ds_hash_universal_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_hash_universal_matrix_add(a : DshashuniversalMatrix, b : DshashuniversalMatrix) -> DshashuniversalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_hash_universal_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_hash_universal_matrix_scale(m : DshashuniversalMatrix, s : Double) -> DshashuniversalMatrix {
  let result = ds_hash_universal_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_hash_universal_matrix_multiply(a : DshashuniversalMatrix, b : DshashuniversalMatrix) -> DshashuniversalMatrix {
  if a.cols != b.rows { return ds_hash_universal_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_hash_universal_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_hash_universal_matrix_trace(m : DshashuniversalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_hash_universal_matrix_det(m : DshashuniversalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_hash_universal_matrix_norm(m : DshashuniversalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_hash_universal_matrix_to_string(m : DshashuniversalMatrix) -> String {
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

pub(all) struct DshashuniversalVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_universal_make_vector(comps : Array[Double]) -> DshashuniversalVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_universal_vector_zero(dim : Int) -> DshashuniversalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_hash_universal_vector_add(a : DshashuniversalVector, b : DshashuniversalVector) -> DshashuniversalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_universal_vector_sub(a : DshashuniversalVector, b : DshashuniversalVector) -> DshashuniversalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_universal_vector_scale(v : DshashuniversalVector, s : Double) -> DshashuniversalVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_hash_universal_vector_dot(a : DshashuniversalVector, b : DshashuniversalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_hash_universal_vector_norm(v : DshashuniversalVector) -> Double { @_common.sqrt(ds_hash_universal_vector_dot(v, v)) }

pub fn ds_hash_universal_vector_normalize(v : DshashuniversalVector) -> DshashuniversalVector {
  let n = ds_hash_universal_vector_norm(v)
  if n < 0.0000001 { v } else { ds_hash_universal_vector_scale(v, 1.0 / n) }
}

pub fn ds_hash_universal_vector_dist(a : DshashuniversalVector, b : DshashuniversalVector) -> Double {
  ds_hash_universal_vector_norm(ds_hash_universal_vector_sub(a, b))
}

pub fn ds_hash_universal_vector_to_string(v : DshashuniversalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_hash_universal_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_hash_universal_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_hash_universal_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_hash_universal_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_hash_universal_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_hash_universal_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_hash_universal_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_hash_universal_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_hash_universal_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_hash_universal_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_hash_universal_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_hash_universal_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_hash_universal_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_hash_universal_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_hash_universal_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_hash_universal_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_hash_universal_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_hash_universal_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_hash_universal_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_hash_universal_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_hash_universal_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_hash_universal_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_hash_universal_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_hash_universal_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_hash_universal_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_hash_universal_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_hash_universal_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_hash_universal_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_hash_universal_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DshashuniversalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_frame_make(size : Int) -> DshashuniversalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_frame_len(s : DshashuniversalFrame) -> Int { s.size }

pub fn ds_hash_universal_frame_get(s : DshashuniversalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_frame_set(s : DshashuniversalFrame, i : Int, v : Double) -> DshashuniversalFrame {
  let result = ds_hash_universal_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_frame_sum(s : DshashuniversalFrame) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_frame_mean(s : DshashuniversalFrame) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_frame_scale(s : DshashuniversalFrame, f : Double) -> DshashuniversalFrame {
  let result = ds_hash_universal_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_universal_frame_add(a : DshashuniversalFrame, b : DshashuniversalFrame) -> DshashuniversalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_universal_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_universal_frame_copy(s : DshashuniversalFrame) -> DshashuniversalFrame {
  let result = ds_hash_universal_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_universal_frame_fill(s : DshashuniversalFrame, v : Double) -> DshashuniversalFrame {
  let result = ds_hash_universal_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_frame_min(s : DshashuniversalFrame) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_frame_max(s : DshashuniversalFrame) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_frame_to_string(s : DshashuniversalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_table_make(size : Int) -> DshashuniversalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_table_len(s : DshashuniversalTable) -> Int { s.size }

pub fn ds_hash_universal_table_get(s : DshashuniversalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_table_set(s : DshashuniversalTable, i : Int, v : Double) -> DshashuniversalTable {
  let result = ds_hash_universal_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_table_sum(s : DshashuniversalTable) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_table_mean(s : DshashuniversalTable) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_table_scale(s : DshashuniversalTable, f : Double) -> DshashuniversalTable {
  let result = ds_hash_universal_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_universal_table_add(a : DshashuniversalTable, b : DshashuniversalTable) -> DshashuniversalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_universal_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_universal_table_copy(s : DshashuniversalTable) -> DshashuniversalTable {
  let result = ds_hash_universal_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_universal_table_fill(s : DshashuniversalTable, v : Double) -> DshashuniversalTable {
  let result = ds_hash_universal_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_table_min(s : DshashuniversalTable) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_table_max(s : DshashuniversalTable) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_table_to_string(s : DshashuniversalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_graphn_make(size : Int) -> DshashuniversalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_graphn_len(s : DshashuniversalGraphN) -> Int { s.size }

pub fn ds_hash_universal_graphn_get(s : DshashuniversalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_graphn_set(s : DshashuniversalGraphN, i : Int, v : Double) -> DshashuniversalGraphN {
  let result = ds_hash_universal_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_graphn_sum(s : DshashuniversalGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_graphn_mean(s : DshashuniversalGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_graphn_scale(s : DshashuniversalGraphN, f : Double) -> DshashuniversalGraphN {
  let result = ds_hash_universal_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_universal_graphn_add(a : DshashuniversalGraphN, b : DshashuniversalGraphN) -> DshashuniversalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_universal_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_universal_graphn_copy(s : DshashuniversalGraphN) -> DshashuniversalGraphN {
  let result = ds_hash_universal_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_universal_graphn_fill(s : DshashuniversalGraphN, v : Double) -> DshashuniversalGraphN {
  let result = ds_hash_universal_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_graphn_min(s : DshashuniversalGraphN) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_graphn_max(s : DshashuniversalGraphN) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_graphn_to_string(s : DshashuniversalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_node_make(size : Int) -> DshashuniversalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_node_len(s : DshashuniversalNode) -> Int { s.size }

pub fn ds_hash_universal_node_get(s : DshashuniversalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_node_set(s : DshashuniversalNode, i : Int, v : Double) -> DshashuniversalNode {
  let result = ds_hash_universal_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_node_sum(s : DshashuniversalNode) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_node_mean(s : DshashuniversalNode) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_node_scale(s : DshashuniversalNode, f : Double) -> DshashuniversalNode {
  let result = ds_hash_universal_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_universal_node_add(a : DshashuniversalNode, b : DshashuniversalNode) -> DshashuniversalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_universal_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_universal_node_copy(s : DshashuniversalNode) -> DshashuniversalNode {
  let result = ds_hash_universal_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_universal_node_fill(s : DshashuniversalNode, v : Double) -> DshashuniversalNode {
  let result = ds_hash_universal_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_node_min(s : DshashuniversalNode) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_node_max(s : DshashuniversalNode) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_node_to_string(s : DshashuniversalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_edge_make(size : Int) -> DshashuniversalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_edge_len(s : DshashuniversalEdge) -> Int { s.size }

pub fn ds_hash_universal_edge_get(s : DshashuniversalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_edge_set(s : DshashuniversalEdge, i : Int, v : Double) -> DshashuniversalEdge {
  let result = ds_hash_universal_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_edge_sum(s : DshashuniversalEdge) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_edge_mean(s : DshashuniversalEdge) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_edge_scale(s : DshashuniversalEdge, f : Double) -> DshashuniversalEdge {
  let result = ds_hash_universal_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_universal_edge_add(a : DshashuniversalEdge, b : DshashuniversalEdge) -> DshashuniversalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_universal_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_universal_edge_copy(s : DshashuniversalEdge) -> DshashuniversalEdge {
  let result = ds_hash_universal_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_universal_edge_fill(s : DshashuniversalEdge, v : Double) -> DshashuniversalEdge {
  let result = ds_hash_universal_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_edge_min(s : DshashuniversalEdge) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_edge_max(s : DshashuniversalEdge) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_edge_to_string(s : DshashuniversalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_path_make(size : Int) -> DshashuniversalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_path_len(s : DshashuniversalPath) -> Int { s.size }

pub fn ds_hash_universal_path_get(s : DshashuniversalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_path_set(s : DshashuniversalPath, i : Int, v : Double) -> DshashuniversalPath {
  let result = ds_hash_universal_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_path_sum(s : DshashuniversalPath) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_path_mean(s : DshashuniversalPath) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_path_scale(s : DshashuniversalPath, f : Double) -> DshashuniversalPath {
  let result = ds_hash_universal_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_universal_path_add(a : DshashuniversalPath, b : DshashuniversalPath) -> DshashuniversalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_universal_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_universal_path_copy(s : DshashuniversalPath) -> DshashuniversalPath {
  let result = ds_hash_universal_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_universal_path_fill(s : DshashuniversalPath, v : Double) -> DshashuniversalPath {
  let result = ds_hash_universal_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_path_min(s : DshashuniversalPath) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_path_max(s : DshashuniversalPath) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_path_to_string(s : DshashuniversalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_cluster_make(size : Int) -> DshashuniversalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_cluster_len(s : DshashuniversalCluster) -> Int { s.size }

pub fn ds_hash_universal_cluster_get(s : DshashuniversalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_cluster_set(s : DshashuniversalCluster, i : Int, v : Double) -> DshashuniversalCluster {
  let result = ds_hash_universal_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_cluster_sum(s : DshashuniversalCluster) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_cluster_mean(s : DshashuniversalCluster) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_cluster_scale(s : DshashuniversalCluster, f : Double) -> DshashuniversalCluster {
  let result = ds_hash_universal_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_universal_cluster_add(a : DshashuniversalCluster, b : DshashuniversalCluster) -> DshashuniversalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_universal_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_universal_cluster_copy(s : DshashuniversalCluster) -> DshashuniversalCluster {
  let result = ds_hash_universal_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_universal_cluster_fill(s : DshashuniversalCluster, v : Double) -> DshashuniversalCluster {
  let result = ds_hash_universal_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_cluster_min(s : DshashuniversalCluster) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_cluster_max(s : DshashuniversalCluster) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_cluster_to_string(s : DshashuniversalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_model_make(size : Int) -> DshashuniversalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_model_len(s : DshashuniversalModel) -> Int { s.size }

pub fn ds_hash_universal_model_get(s : DshashuniversalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_model_set(s : DshashuniversalModel, i : Int, v : Double) -> DshashuniversalModel {
  let result = ds_hash_universal_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_model_sum(s : DshashuniversalModel) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_model_mean(s : DshashuniversalModel) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_model_scale(s : DshashuniversalModel, f : Double) -> DshashuniversalModel {
  let result = ds_hash_universal_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_universal_model_add(a : DshashuniversalModel, b : DshashuniversalModel) -> DshashuniversalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_universal_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_universal_model_copy(s : DshashuniversalModel) -> DshashuniversalModel {
  let result = ds_hash_universal_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_universal_model_fill(s : DshashuniversalModel, v : Double) -> DshashuniversalModel {
  let result = ds_hash_universal_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_model_min(s : DshashuniversalModel) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_model_max(s : DshashuniversalModel) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_model_to_string(s : DshashuniversalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_layer_make(size : Int) -> DshashuniversalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_layer_len(s : DshashuniversalLayer) -> Int { s.size }

pub fn ds_hash_universal_layer_get(s : DshashuniversalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_layer_set(s : DshashuniversalLayer, i : Int, v : Double) -> DshashuniversalLayer {
  let result = ds_hash_universal_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_layer_sum(s : DshashuniversalLayer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_layer_mean(s : DshashuniversalLayer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_layer_scale(s : DshashuniversalLayer, f : Double) -> DshashuniversalLayer {
  let result = ds_hash_universal_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_universal_layer_add(a : DshashuniversalLayer, b : DshashuniversalLayer) -> DshashuniversalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_universal_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_universal_layer_copy(s : DshashuniversalLayer) -> DshashuniversalLayer {
  let result = ds_hash_universal_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_universal_layer_fill(s : DshashuniversalLayer, v : Double) -> DshashuniversalLayer {
  let result = ds_hash_universal_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_layer_min(s : DshashuniversalLayer) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_layer_max(s : DshashuniversalLayer) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_layer_to_string(s : DshashuniversalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_buffer_make(size : Int) -> DshashuniversalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_buffer_len(s : DshashuniversalBuffer) -> Int { s.size }

pub fn ds_hash_universal_buffer_get(s : DshashuniversalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_buffer_set(s : DshashuniversalBuffer, i : Int, v : Double) -> DshashuniversalBuffer {
  let result = ds_hash_universal_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_buffer_sum(s : DshashuniversalBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_buffer_mean(s : DshashuniversalBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_buffer_scale(s : DshashuniversalBuffer, f : Double) -> DshashuniversalBuffer {
  let result = ds_hash_universal_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_universal_buffer_add(a : DshashuniversalBuffer, b : DshashuniversalBuffer) -> DshashuniversalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_universal_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_universal_buffer_copy(s : DshashuniversalBuffer) -> DshashuniversalBuffer {
  let result = ds_hash_universal_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_universal_buffer_fill(s : DshashuniversalBuffer, v : Double) -> DshashuniversalBuffer {
  let result = ds_hash_universal_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_buffer_min(s : DshashuniversalBuffer) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_buffer_max(s : DshashuniversalBuffer) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_buffer_to_string(s : DshashuniversalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_cursor_make(size : Int) -> DshashuniversalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_cursor_len(s : DshashuniversalCursor) -> Int { s.size }

pub fn ds_hash_universal_cursor_get(s : DshashuniversalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_cursor_set(s : DshashuniversalCursor, i : Int, v : Double) -> DshashuniversalCursor {
  let result = ds_hash_universal_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_cursor_sum(s : DshashuniversalCursor) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_cursor_mean(s : DshashuniversalCursor) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_cursor_scale(s : DshashuniversalCursor, f : Double) -> DshashuniversalCursor {
  let result = ds_hash_universal_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_universal_cursor_add(a : DshashuniversalCursor, b : DshashuniversalCursor) -> DshashuniversalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_universal_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_universal_cursor_copy(s : DshashuniversalCursor) -> DshashuniversalCursor {
  let result = ds_hash_universal_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_universal_cursor_fill(s : DshashuniversalCursor, v : Double) -> DshashuniversalCursor {
  let result = ds_hash_universal_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_cursor_min(s : DshashuniversalCursor) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_cursor_max(s : DshashuniversalCursor) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_cursor_to_string(s : DshashuniversalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_view_make(size : Int) -> DshashuniversalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_view_len(s : DshashuniversalView) -> Int { s.size }

pub fn ds_hash_universal_view_get(s : DshashuniversalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_view_set(s : DshashuniversalView, i : Int, v : Double) -> DshashuniversalView {
  let result = ds_hash_universal_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_view_sum(s : DshashuniversalView) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_view_mean(s : DshashuniversalView) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_view_scale(s : DshashuniversalView, f : Double) -> DshashuniversalView {
  let result = ds_hash_universal_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_universal_view_add(a : DshashuniversalView, b : DshashuniversalView) -> DshashuniversalView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_universal_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_universal_view_copy(s : DshashuniversalView) -> DshashuniversalView {
  let result = ds_hash_universal_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_universal_view_fill(s : DshashuniversalView, v : Double) -> DshashuniversalView {
  let result = ds_hash_universal_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_view_min(s : DshashuniversalView) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_view_max(s : DshashuniversalView) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_view_to_string(s : DshashuniversalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_range_make(size : Int) -> DshashuniversalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_range_len(s : DshashuniversalRange) -> Int { s.size }

pub fn ds_hash_universal_range_get(s : DshashuniversalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_range_set(s : DshashuniversalRange, i : Int, v : Double) -> DshashuniversalRange {
  let result = ds_hash_universal_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_range_sum(s : DshashuniversalRange) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_range_mean(s : DshashuniversalRange) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_range_scale(s : DshashuniversalRange, f : Double) -> DshashuniversalRange {
  let result = ds_hash_universal_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_universal_range_add(a : DshashuniversalRange, b : DshashuniversalRange) -> DshashuniversalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_universal_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_universal_range_copy(s : DshashuniversalRange) -> DshashuniversalRange {
  let result = ds_hash_universal_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_universal_range_fill(s : DshashuniversalRange, v : Double) -> DshashuniversalRange {
  let result = ds_hash_universal_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_range_min(s : DshashuniversalRange) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_range_max(s : DshashuniversalRange) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_range_to_string(s : DshashuniversalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_slice_make(size : Int) -> DshashuniversalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_slice_len(s : DshashuniversalSlice) -> Int { s.size }

pub fn ds_hash_universal_slice_get(s : DshashuniversalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_slice_set(s : DshashuniversalSlice, i : Int, v : Double) -> DshashuniversalSlice {
  let result = ds_hash_universal_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_slice_sum(s : DshashuniversalSlice) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_slice_mean(s : DshashuniversalSlice) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_slice_scale(s : DshashuniversalSlice, f : Double) -> DshashuniversalSlice {
  let result = ds_hash_universal_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_universal_slice_add(a : DshashuniversalSlice, b : DshashuniversalSlice) -> DshashuniversalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_universal_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_universal_slice_copy(s : DshashuniversalSlice) -> DshashuniversalSlice {
  let result = ds_hash_universal_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_universal_slice_fill(s : DshashuniversalSlice, v : Double) -> DshashuniversalSlice {
  let result = ds_hash_universal_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_universal_slice_min(s : DshashuniversalSlice) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_slice_max(s : DshashuniversalSlice) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_slice_to_string(s : DshashuniversalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

