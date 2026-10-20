///===
/// extcore/ml_feature_ica

pub(all) struct MlfeatureicaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_ica_make_point(x : Double, y : Double) -> MlfeatureicaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_ica_make_point3(x : Double, y : Double, z : Double) -> MlfeatureicaPoint {
  { x, y, z, label: 0 }
}

pub fn ml_feature_ica_point_x(pt : MlfeatureicaPoint) -> Double { pt.x }

pub fn ml_feature_ica_point_y(pt : MlfeatureicaPoint) -> Double { pt.y }

pub fn ml_feature_ica_point_z(pt : MlfeatureicaPoint) -> Double { pt.z }

pub fn ml_feature_ica_point_label(pt : MlfeatureicaPoint) -> Int { pt.label }

pub fn ml_feature_ica_point_dist(a : MlfeatureicaPoint, b : MlfeatureicaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_feature_ica_point_add(a : MlfeatureicaPoint, b : MlfeatureicaPoint) -> MlfeatureicaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_feature_ica_point_sub(a : MlfeatureicaPoint, b : MlfeatureicaPoint) -> MlfeatureicaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_feature_ica_point_scale(pt : MlfeatureicaPoint, s : Double) -> MlfeatureicaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_feature_ica_point_dot(a : MlfeatureicaPoint, b : MlfeatureicaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_feature_ica_point_cross(a : MlfeatureicaPoint, b : MlfeatureicaPoint) -> MlfeatureicaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_feature_ica_point_norm(pt : MlfeatureicaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_feature_ica_point_normalize(pt : MlfeatureicaPoint) -> MlfeatureicaPoint {
  let n = ml_feature_ica_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_feature_ica_point_scale(pt, 1.0 / n) }
}

pub fn ml_feature_ica_point_negate(pt : MlfeatureicaPoint) -> MlfeatureicaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_feature_ica_point_mid(a : MlfeatureicaPoint, b : MlfeatureicaPoint) -> MlfeatureicaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_feature_ica_point_lerp(a : MlfeatureicaPoint, b : MlfeatureicaPoint, t : Double) -> MlfeatureicaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_feature_ica_point_to_string(pt : MlfeatureicaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlfeatureicaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_ica_make_series(vals : Array[Double], name : String) -> MlfeatureicaSeries {
  { vals, name, meta: 0 }
}

pub fn ml_feature_ica_series_len(s : MlfeatureicaSeries) -> Int { s.vals.length() }

pub fn ml_feature_ica_series_sum(s : MlfeatureicaSeries) -> Double { @_common.sum(s.vals) }

pub fn ml_feature_ica_series_mean(s : MlfeatureicaSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_feature_ica_series_min(s : MlfeatureicaSeries) -> Double { @_common.min(s.vals) }

pub fn ml_feature_ica_series_max(s : MlfeatureicaSeries) -> Double { @_common.max(s.vals) }

pub fn ml_feature_ica_series_range(s : MlfeatureicaSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_feature_ica_series_var(s : MlfeatureicaSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_feature_ica_series_std(s : MlfeatureicaSeries) -> Double { @_common.std(s.vals) }

pub fn ml_feature_ica_series_median(s : MlfeatureicaSeries) -> Double { @_common.median(s.vals) }

pub fn ml_feature_ica_series_scale(s : MlfeatureicaSeries, f : Double) -> MlfeatureicaSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_feature_ica_series_add(a : MlfeatureicaSeries, b : MlfeatureicaSeries) -> MlfeatureicaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_feature_ica_series_sub(a : MlfeatureicaSeries, b : MlfeatureicaSeries) -> MlfeatureicaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_feature_ica_series_normalize(s : MlfeatureicaSeries) -> MlfeatureicaSeries {
  let mn = ml_feature_ica_series_min(s)
  let mx = ml_feature_ica_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_feature_ica_series_cumsum(s : MlfeatureicaSeries) -> MlfeatureicaSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_feature_ica_series_to_string(s : MlfeatureicaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeatureicaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_ica_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeatureicaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_ica_matrix_identity(n : Int) -> MlfeatureicaMatrix {
  let m = ml_feature_ica_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_feature_ica_matrix_get(m : MlfeatureicaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_feature_ica_matrix_transpose(m : MlfeatureicaMatrix) -> MlfeatureicaMatrix {
  let result = ml_feature_ica_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_feature_ica_matrix_add(a : MlfeatureicaMatrix, b : MlfeatureicaMatrix) -> MlfeatureicaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_feature_ica_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_feature_ica_matrix_scale(m : MlfeatureicaMatrix, s : Double) -> MlfeatureicaMatrix {
  let result = ml_feature_ica_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_feature_ica_matrix_multiply(a : MlfeatureicaMatrix, b : MlfeatureicaMatrix) -> MlfeatureicaMatrix {
  if a.cols != b.rows { return ml_feature_ica_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_feature_ica_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_feature_ica_matrix_trace(m : MlfeatureicaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_feature_ica_matrix_det(m : MlfeatureicaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_feature_ica_matrix_norm(m : MlfeatureicaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_feature_ica_matrix_to_string(m : MlfeatureicaMatrix) -> String {
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

pub(all) struct MlfeatureicaVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_ica_make_vector(comps : Array[Double]) -> MlfeatureicaVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_ica_vector_zero(dim : Int) -> MlfeatureicaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_feature_ica_vector_add(a : MlfeatureicaVector, b : MlfeatureicaVector) -> MlfeatureicaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_feature_ica_vector_sub(a : MlfeatureicaVector, b : MlfeatureicaVector) -> MlfeatureicaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_feature_ica_vector_scale(v : MlfeatureicaVector, s : Double) -> MlfeatureicaVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_feature_ica_vector_dot(a : MlfeatureicaVector, b : MlfeatureicaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_feature_ica_vector_norm(v : MlfeatureicaVector) -> Double { @_common.sqrt(ml_feature_ica_vector_dot(v, v)) }

pub fn ml_feature_ica_vector_normalize(v : MlfeatureicaVector) -> MlfeatureicaVector {
  let n = ml_feature_ica_vector_norm(v)
  if n < 0.0000001 { v } else { ml_feature_ica_vector_scale(v, 1.0 / n) }
}

pub fn ml_feature_ica_vector_dist(a : MlfeatureicaVector, b : MlfeatureicaVector) -> Double {
  ml_feature_ica_vector_norm(ml_feature_ica_vector_sub(a, b))
}

pub fn ml_feature_ica_vector_to_string(v : MlfeatureicaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_feature_ica_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_feature_ica_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_feature_ica_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_feature_ica_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_feature_ica_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_feature_ica_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_feature_ica_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_feature_ica_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_feature_ica_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_feature_ica_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_feature_ica_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_feature_ica_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_feature_ica_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_feature_ica_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_feature_ica_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_feature_ica_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_feature_ica_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_feature_ica_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_feature_ica_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_feature_ica_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_feature_ica_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_feature_ica_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_feature_ica_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_feature_ica_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_feature_ica_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_feature_ica_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_feature_ica_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_feature_ica_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_feature_ica_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlfeatureicaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_frame_make(size : Int) -> MlfeatureicaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_ica_frame_len(s : MlfeatureicaFrame) -> Int { s.size }

pub fn ml_feature_ica_frame_get(s : MlfeatureicaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_ica_frame_set(s : MlfeatureicaFrame, i : Int, v : Double) -> MlfeatureicaFrame {
  let result = ml_feature_ica_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_ica_frame_sum(s : MlfeatureicaFrame) -> Double { @_common.sum(s.data) }

pub fn ml_feature_ica_frame_mean(s : MlfeatureicaFrame) -> Double { @_common.mean(s.data) }

pub fn ml_feature_ica_frame_scale(s : MlfeatureicaFrame, f : Double) -> MlfeatureicaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_frame_add(a : MlfeatureicaFrame, b : MlfeatureicaFrame) -> MlfeatureicaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_ica_frame_copy(s : MlfeatureicaFrame) -> MlfeatureicaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_frame_fill(s : MlfeatureicaFrame, v : Double) -> MlfeatureicaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_frame_min(s : MlfeatureicaFrame) -> Double { @_common.min(s.data) }

pub fn ml_feature_ica_frame_max(s : MlfeatureicaFrame) -> Double { @_common.max(s.data) }

pub fn ml_feature_ica_frame_to_string(s : MlfeatureicaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_table_make(size : Int) -> MlfeatureicaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_ica_table_len(s : MlfeatureicaTable) -> Int { s.size }

pub fn ml_feature_ica_table_get(s : MlfeatureicaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_ica_table_set(s : MlfeatureicaTable, i : Int, v : Double) -> MlfeatureicaTable {
  let result = ml_feature_ica_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_ica_table_sum(s : MlfeatureicaTable) -> Double { @_common.sum(s.data) }

pub fn ml_feature_ica_table_mean(s : MlfeatureicaTable) -> Double { @_common.mean(s.data) }

pub fn ml_feature_ica_table_scale(s : MlfeatureicaTable, f : Double) -> MlfeatureicaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_table_add(a : MlfeatureicaTable, b : MlfeatureicaTable) -> MlfeatureicaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_ica_table_copy(s : MlfeatureicaTable) -> MlfeatureicaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_table_fill(s : MlfeatureicaTable, v : Double) -> MlfeatureicaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_table_min(s : MlfeatureicaTable) -> Double { @_common.min(s.data) }

pub fn ml_feature_ica_table_max(s : MlfeatureicaTable) -> Double { @_common.max(s.data) }

pub fn ml_feature_ica_table_to_string(s : MlfeatureicaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_graphn_make(size : Int) -> MlfeatureicaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_ica_graphn_len(s : MlfeatureicaGraphN) -> Int { s.size }

pub fn ml_feature_ica_graphn_get(s : MlfeatureicaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_ica_graphn_set(s : MlfeatureicaGraphN, i : Int, v : Double) -> MlfeatureicaGraphN {
  let result = ml_feature_ica_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_ica_graphn_sum(s : MlfeatureicaGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_feature_ica_graphn_mean(s : MlfeatureicaGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_feature_ica_graphn_scale(s : MlfeatureicaGraphN, f : Double) -> MlfeatureicaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_graphn_add(a : MlfeatureicaGraphN, b : MlfeatureicaGraphN) -> MlfeatureicaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_ica_graphn_copy(s : MlfeatureicaGraphN) -> MlfeatureicaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_graphn_fill(s : MlfeatureicaGraphN, v : Double) -> MlfeatureicaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_graphn_min(s : MlfeatureicaGraphN) -> Double { @_common.min(s.data) }

pub fn ml_feature_ica_graphn_max(s : MlfeatureicaGraphN) -> Double { @_common.max(s.data) }

pub fn ml_feature_ica_graphn_to_string(s : MlfeatureicaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_node_make(size : Int) -> MlfeatureicaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_ica_node_len(s : MlfeatureicaNode) -> Int { s.size }

pub fn ml_feature_ica_node_get(s : MlfeatureicaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_ica_node_set(s : MlfeatureicaNode, i : Int, v : Double) -> MlfeatureicaNode {
  let result = ml_feature_ica_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_ica_node_sum(s : MlfeatureicaNode) -> Double { @_common.sum(s.data) }

pub fn ml_feature_ica_node_mean(s : MlfeatureicaNode) -> Double { @_common.mean(s.data) }

pub fn ml_feature_ica_node_scale(s : MlfeatureicaNode, f : Double) -> MlfeatureicaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_node_add(a : MlfeatureicaNode, b : MlfeatureicaNode) -> MlfeatureicaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_ica_node_copy(s : MlfeatureicaNode) -> MlfeatureicaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_node_fill(s : MlfeatureicaNode, v : Double) -> MlfeatureicaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_node_min(s : MlfeatureicaNode) -> Double { @_common.min(s.data) }

pub fn ml_feature_ica_node_max(s : MlfeatureicaNode) -> Double { @_common.max(s.data) }

pub fn ml_feature_ica_node_to_string(s : MlfeatureicaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_edge_make(size : Int) -> MlfeatureicaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_ica_edge_len(s : MlfeatureicaEdge) -> Int { s.size }

pub fn ml_feature_ica_edge_get(s : MlfeatureicaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_ica_edge_set(s : MlfeatureicaEdge, i : Int, v : Double) -> MlfeatureicaEdge {
  let result = ml_feature_ica_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_ica_edge_sum(s : MlfeatureicaEdge) -> Double { @_common.sum(s.data) }

pub fn ml_feature_ica_edge_mean(s : MlfeatureicaEdge) -> Double { @_common.mean(s.data) }

pub fn ml_feature_ica_edge_scale(s : MlfeatureicaEdge, f : Double) -> MlfeatureicaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_edge_add(a : MlfeatureicaEdge, b : MlfeatureicaEdge) -> MlfeatureicaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_ica_edge_copy(s : MlfeatureicaEdge) -> MlfeatureicaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_edge_fill(s : MlfeatureicaEdge, v : Double) -> MlfeatureicaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_edge_min(s : MlfeatureicaEdge) -> Double { @_common.min(s.data) }

pub fn ml_feature_ica_edge_max(s : MlfeatureicaEdge) -> Double { @_common.max(s.data) }

pub fn ml_feature_ica_edge_to_string(s : MlfeatureicaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_path_make(size : Int) -> MlfeatureicaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_ica_path_len(s : MlfeatureicaPath) -> Int { s.size }

pub fn ml_feature_ica_path_get(s : MlfeatureicaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_ica_path_set(s : MlfeatureicaPath, i : Int, v : Double) -> MlfeatureicaPath {
  let result = ml_feature_ica_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_ica_path_sum(s : MlfeatureicaPath) -> Double { @_common.sum(s.data) }

pub fn ml_feature_ica_path_mean(s : MlfeatureicaPath) -> Double { @_common.mean(s.data) }

pub fn ml_feature_ica_path_scale(s : MlfeatureicaPath, f : Double) -> MlfeatureicaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_path_add(a : MlfeatureicaPath, b : MlfeatureicaPath) -> MlfeatureicaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_ica_path_copy(s : MlfeatureicaPath) -> MlfeatureicaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_path_fill(s : MlfeatureicaPath, v : Double) -> MlfeatureicaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_path_min(s : MlfeatureicaPath) -> Double { @_common.min(s.data) }

pub fn ml_feature_ica_path_max(s : MlfeatureicaPath) -> Double { @_common.max(s.data) }

pub fn ml_feature_ica_path_to_string(s : MlfeatureicaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_cluster_make(size : Int) -> MlfeatureicaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_ica_cluster_len(s : MlfeatureicaCluster) -> Int { s.size }

pub fn ml_feature_ica_cluster_get(s : MlfeatureicaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_ica_cluster_set(s : MlfeatureicaCluster, i : Int, v : Double) -> MlfeatureicaCluster {
  let result = ml_feature_ica_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_ica_cluster_sum(s : MlfeatureicaCluster) -> Double { @_common.sum(s.data) }

pub fn ml_feature_ica_cluster_mean(s : MlfeatureicaCluster) -> Double { @_common.mean(s.data) }

pub fn ml_feature_ica_cluster_scale(s : MlfeatureicaCluster, f : Double) -> MlfeatureicaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_cluster_add(a : MlfeatureicaCluster, b : MlfeatureicaCluster) -> MlfeatureicaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_ica_cluster_copy(s : MlfeatureicaCluster) -> MlfeatureicaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_cluster_fill(s : MlfeatureicaCluster, v : Double) -> MlfeatureicaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_cluster_min(s : MlfeatureicaCluster) -> Double { @_common.min(s.data) }

pub fn ml_feature_ica_cluster_max(s : MlfeatureicaCluster) -> Double { @_common.max(s.data) }

pub fn ml_feature_ica_cluster_to_string(s : MlfeatureicaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_model_make(size : Int) -> MlfeatureicaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_ica_model_len(s : MlfeatureicaModel) -> Int { s.size }

pub fn ml_feature_ica_model_get(s : MlfeatureicaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_ica_model_set(s : MlfeatureicaModel, i : Int, v : Double) -> MlfeatureicaModel {
  let result = ml_feature_ica_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_ica_model_sum(s : MlfeatureicaModel) -> Double { @_common.sum(s.data) }

pub fn ml_feature_ica_model_mean(s : MlfeatureicaModel) -> Double { @_common.mean(s.data) }

pub fn ml_feature_ica_model_scale(s : MlfeatureicaModel, f : Double) -> MlfeatureicaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_model_add(a : MlfeatureicaModel, b : MlfeatureicaModel) -> MlfeatureicaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_ica_model_copy(s : MlfeatureicaModel) -> MlfeatureicaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_model_fill(s : MlfeatureicaModel, v : Double) -> MlfeatureicaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_model_min(s : MlfeatureicaModel) -> Double { @_common.min(s.data) }

pub fn ml_feature_ica_model_max(s : MlfeatureicaModel) -> Double { @_common.max(s.data) }

pub fn ml_feature_ica_model_to_string(s : MlfeatureicaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_layer_make(size : Int) -> MlfeatureicaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_ica_layer_len(s : MlfeatureicaLayer) -> Int { s.size }

pub fn ml_feature_ica_layer_get(s : MlfeatureicaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_ica_layer_set(s : MlfeatureicaLayer, i : Int, v : Double) -> MlfeatureicaLayer {
  let result = ml_feature_ica_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_ica_layer_sum(s : MlfeatureicaLayer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_ica_layer_mean(s : MlfeatureicaLayer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_ica_layer_scale(s : MlfeatureicaLayer, f : Double) -> MlfeatureicaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_layer_add(a : MlfeatureicaLayer, b : MlfeatureicaLayer) -> MlfeatureicaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_ica_layer_copy(s : MlfeatureicaLayer) -> MlfeatureicaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_layer_fill(s : MlfeatureicaLayer, v : Double) -> MlfeatureicaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_layer_min(s : MlfeatureicaLayer) -> Double { @_common.min(s.data) }

pub fn ml_feature_ica_layer_max(s : MlfeatureicaLayer) -> Double { @_common.max(s.data) }

pub fn ml_feature_ica_layer_to_string(s : MlfeatureicaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_buffer_make(size : Int) -> MlfeatureicaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_ica_buffer_len(s : MlfeatureicaBuffer) -> Int { s.size }

pub fn ml_feature_ica_buffer_get(s : MlfeatureicaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_ica_buffer_set(s : MlfeatureicaBuffer, i : Int, v : Double) -> MlfeatureicaBuffer {
  let result = ml_feature_ica_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_ica_buffer_sum(s : MlfeatureicaBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_ica_buffer_mean(s : MlfeatureicaBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_ica_buffer_scale(s : MlfeatureicaBuffer, f : Double) -> MlfeatureicaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_buffer_add(a : MlfeatureicaBuffer, b : MlfeatureicaBuffer) -> MlfeatureicaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_ica_buffer_copy(s : MlfeatureicaBuffer) -> MlfeatureicaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_buffer_fill(s : MlfeatureicaBuffer, v : Double) -> MlfeatureicaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_buffer_min(s : MlfeatureicaBuffer) -> Double { @_common.min(s.data) }

pub fn ml_feature_ica_buffer_max(s : MlfeatureicaBuffer) -> Double { @_common.max(s.data) }

pub fn ml_feature_ica_buffer_to_string(s : MlfeatureicaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_cursor_make(size : Int) -> MlfeatureicaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_ica_cursor_len(s : MlfeatureicaCursor) -> Int { s.size }

pub fn ml_feature_ica_cursor_get(s : MlfeatureicaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_ica_cursor_set(s : MlfeatureicaCursor, i : Int, v : Double) -> MlfeatureicaCursor {
  let result = ml_feature_ica_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_ica_cursor_sum(s : MlfeatureicaCursor) -> Double { @_common.sum(s.data) }

pub fn ml_feature_ica_cursor_mean(s : MlfeatureicaCursor) -> Double { @_common.mean(s.data) }

pub fn ml_feature_ica_cursor_scale(s : MlfeatureicaCursor, f : Double) -> MlfeatureicaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_cursor_add(a : MlfeatureicaCursor, b : MlfeatureicaCursor) -> MlfeatureicaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_ica_cursor_copy(s : MlfeatureicaCursor) -> MlfeatureicaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_cursor_fill(s : MlfeatureicaCursor, v : Double) -> MlfeatureicaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_cursor_min(s : MlfeatureicaCursor) -> Double { @_common.min(s.data) }

pub fn ml_feature_ica_cursor_max(s : MlfeatureicaCursor) -> Double { @_common.max(s.data) }

pub fn ml_feature_ica_cursor_to_string(s : MlfeatureicaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_view_make(size : Int) -> MlfeatureicaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_ica_view_len(s : MlfeatureicaView) -> Int { s.size }

pub fn ml_feature_ica_view_get(s : MlfeatureicaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_ica_view_set(s : MlfeatureicaView, i : Int, v : Double) -> MlfeatureicaView {
  let result = ml_feature_ica_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_ica_view_sum(s : MlfeatureicaView) -> Double { @_common.sum(s.data) }

pub fn ml_feature_ica_view_mean(s : MlfeatureicaView) -> Double { @_common.mean(s.data) }

pub fn ml_feature_ica_view_scale(s : MlfeatureicaView, f : Double) -> MlfeatureicaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_view_add(a : MlfeatureicaView, b : MlfeatureicaView) -> MlfeatureicaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_ica_view_copy(s : MlfeatureicaView) -> MlfeatureicaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_view_fill(s : MlfeatureicaView, v : Double) -> MlfeatureicaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_view_min(s : MlfeatureicaView) -> Double { @_common.min(s.data) }

pub fn ml_feature_ica_view_max(s : MlfeatureicaView) -> Double { @_common.max(s.data) }

pub fn ml_feature_ica_view_to_string(s : MlfeatureicaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_range_make(size : Int) -> MlfeatureicaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_ica_range_len(s : MlfeatureicaRange) -> Int { s.size }

pub fn ml_feature_ica_range_get(s : MlfeatureicaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_ica_range_set(s : MlfeatureicaRange, i : Int, v : Double) -> MlfeatureicaRange {
  let result = ml_feature_ica_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_ica_range_sum(s : MlfeatureicaRange) -> Double { @_common.sum(s.data) }

pub fn ml_feature_ica_range_mean(s : MlfeatureicaRange) -> Double { @_common.mean(s.data) }

pub fn ml_feature_ica_range_scale(s : MlfeatureicaRange, f : Double) -> MlfeatureicaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_range_add(a : MlfeatureicaRange, b : MlfeatureicaRange) -> MlfeatureicaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_ica_range_copy(s : MlfeatureicaRange) -> MlfeatureicaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_range_fill(s : MlfeatureicaRange, v : Double) -> MlfeatureicaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_range_min(s : MlfeatureicaRange) -> Double { @_common.min(s.data) }

pub fn ml_feature_ica_range_max(s : MlfeatureicaRange) -> Double { @_common.max(s.data) }

pub fn ml_feature_ica_range_to_string(s : MlfeatureicaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_slice_make(size : Int) -> MlfeatureicaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_ica_slice_len(s : MlfeatureicaSlice) -> Int { s.size }

pub fn ml_feature_ica_slice_get(s : MlfeatureicaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_ica_slice_set(s : MlfeatureicaSlice, i : Int, v : Double) -> MlfeatureicaSlice {
  let result = ml_feature_ica_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_ica_slice_sum(s : MlfeatureicaSlice) -> Double { @_common.sum(s.data) }

pub fn ml_feature_ica_slice_mean(s : MlfeatureicaSlice) -> Double { @_common.mean(s.data) }

pub fn ml_feature_ica_slice_scale(s : MlfeatureicaSlice, f : Double) -> MlfeatureicaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_slice_add(a : MlfeatureicaSlice, b : MlfeatureicaSlice) -> MlfeatureicaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_ica_slice_copy(s : MlfeatureicaSlice) -> MlfeatureicaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_slice_fill(s : MlfeatureicaSlice, v : Double) -> MlfeatureicaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_ica_slice_min(s : MlfeatureicaSlice) -> Double { @_common.min(s.data) }

pub fn ml_feature_ica_slice_max(s : MlfeatureicaSlice) -> Double { @_common.max(s.data) }

pub fn ml_feature_ica_slice_to_string(s : MlfeatureicaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

