///===
/// extcore/ml_feature_pca

pub(all) struct MlfeaturepcaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_pca_make_point(x : Double, y : Double) -> MlfeaturepcaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_pca_make_point3(x : Double, y : Double, z : Double) -> MlfeaturepcaPoint {
  { x, y, z, label: 0 }
}

pub fn ml_feature_pca_point_x(pt : MlfeaturepcaPoint) -> Double { pt.x }

pub fn ml_feature_pca_point_y(pt : MlfeaturepcaPoint) -> Double { pt.y }

pub fn ml_feature_pca_point_z(pt : MlfeaturepcaPoint) -> Double { pt.z }

pub fn ml_feature_pca_point_label(pt : MlfeaturepcaPoint) -> Int { pt.label }

pub fn ml_feature_pca_point_dist(a : MlfeaturepcaPoint, b : MlfeaturepcaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_feature_pca_point_add(a : MlfeaturepcaPoint, b : MlfeaturepcaPoint) -> MlfeaturepcaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_feature_pca_point_sub(a : MlfeaturepcaPoint, b : MlfeaturepcaPoint) -> MlfeaturepcaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_feature_pca_point_scale(pt : MlfeaturepcaPoint, s : Double) -> MlfeaturepcaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_feature_pca_point_dot(a : MlfeaturepcaPoint, b : MlfeaturepcaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_feature_pca_point_cross(a : MlfeaturepcaPoint, b : MlfeaturepcaPoint) -> MlfeaturepcaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_feature_pca_point_norm(pt : MlfeaturepcaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_feature_pca_point_normalize(pt : MlfeaturepcaPoint) -> MlfeaturepcaPoint {
  let n = ml_feature_pca_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_feature_pca_point_scale(pt, 1.0 / n) }
}

pub fn ml_feature_pca_point_negate(pt : MlfeaturepcaPoint) -> MlfeaturepcaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_feature_pca_point_mid(a : MlfeaturepcaPoint, b : MlfeaturepcaPoint) -> MlfeaturepcaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_feature_pca_point_lerp(a : MlfeaturepcaPoint, b : MlfeaturepcaPoint, t : Double) -> MlfeaturepcaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_feature_pca_point_to_string(pt : MlfeaturepcaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlfeaturepcaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_pca_make_series(vals : Array[Double], name : String) -> MlfeaturepcaSeries {
  { vals, name, meta: 0 }
}

pub fn ml_feature_pca_series_len(s : MlfeaturepcaSeries) -> Int { s.vals.length() }

pub fn ml_feature_pca_series_sum(s : MlfeaturepcaSeries) -> Double { @_common.sum(s.vals) }

pub fn ml_feature_pca_series_mean(s : MlfeaturepcaSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_feature_pca_series_min(s : MlfeaturepcaSeries) -> Double { @_common.min(s.vals) }

pub fn ml_feature_pca_series_max(s : MlfeaturepcaSeries) -> Double { @_common.max(s.vals) }

pub fn ml_feature_pca_series_range(s : MlfeaturepcaSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_feature_pca_series_var(s : MlfeaturepcaSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_feature_pca_series_std(s : MlfeaturepcaSeries) -> Double { @_common.std(s.vals) }

pub fn ml_feature_pca_series_median(s : MlfeaturepcaSeries) -> Double { @_common.median(s.vals) }

pub fn ml_feature_pca_series_scale(s : MlfeaturepcaSeries, f : Double) -> MlfeaturepcaSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn ml_feature_pca_series_add(a : MlfeaturepcaSeries, b : MlfeaturepcaSeries) -> MlfeaturepcaSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_feature_pca_series_sub(a : MlfeaturepcaSeries, b : MlfeaturepcaSeries) -> MlfeaturepcaSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_feature_pca_series_normalize(s : MlfeaturepcaSeries) -> MlfeaturepcaSeries {
  let mn = ml_feature_pca_series_min(s)
  let mx = ml_feature_pca_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_feature_pca_series_cumsum(s : MlfeaturepcaSeries) -> MlfeaturepcaSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_feature_pca_series_to_string(s : MlfeaturepcaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeaturepcaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_pca_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeaturepcaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_pca_matrix_identity(n : Int) -> MlfeaturepcaMatrix {
  let m = ml_feature_pca_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_feature_pca_matrix_get(m : MlfeaturepcaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_feature_pca_matrix_transpose(m : MlfeaturepcaMatrix) -> MlfeaturepcaMatrix {
  let result = ml_feature_pca_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_feature_pca_matrix_add(a : MlfeaturepcaMatrix, b : MlfeaturepcaMatrix) -> MlfeaturepcaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_feature_pca_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_feature_pca_matrix_scale(m : MlfeaturepcaMatrix, s : Double) -> MlfeaturepcaMatrix {
  let result = ml_feature_pca_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_feature_pca_matrix_multiply(a : MlfeaturepcaMatrix, b : MlfeaturepcaMatrix) -> MlfeaturepcaMatrix {
  if a.cols != b.rows { return ml_feature_pca_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_feature_pca_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_feature_pca_matrix_trace(m : MlfeaturepcaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_feature_pca_matrix_det(m : MlfeaturepcaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_feature_pca_matrix_norm(m : MlfeaturepcaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_feature_pca_matrix_to_string(m : MlfeaturepcaMatrix) -> String {
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

pub(all) struct MlfeaturepcaVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_pca_make_vector(comps : Array[Double]) -> MlfeaturepcaVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_pca_vector_zero(dim : Int) -> MlfeaturepcaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_feature_pca_vector_add(a : MlfeaturepcaVector, b : MlfeaturepcaVector) -> MlfeaturepcaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn ml_feature_pca_vector_sub(a : MlfeaturepcaVector, b : MlfeaturepcaVector) -> MlfeaturepcaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn ml_feature_pca_vector_scale(v : MlfeaturepcaVector, s : Double) -> MlfeaturepcaVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn ml_feature_pca_vector_dot(a : MlfeaturepcaVector, b : MlfeaturepcaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_feature_pca_vector_norm(v : MlfeaturepcaVector) -> Double { @_common.sqrt(ml_feature_pca_vector_dot(v, v)) }

pub fn ml_feature_pca_vector_normalize(v : MlfeaturepcaVector) -> MlfeaturepcaVector {
  let n = ml_feature_pca_vector_norm(v)
  if n < 0.0000001 { v } else { ml_feature_pca_vector_scale(v, 1.0 / n) }
}

pub fn ml_feature_pca_vector_dist(a : MlfeaturepcaVector, b : MlfeaturepcaVector) -> Double {
  ml_feature_pca_vector_norm(ml_feature_pca_vector_sub(a, b))
}

pub fn ml_feature_pca_vector_to_string(v : MlfeaturepcaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_feature_pca_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_feature_pca_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_feature_pca_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_feature_pca_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_feature_pca_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_feature_pca_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_feature_pca_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_feature_pca_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_feature_pca_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_feature_pca_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_feature_pca_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_feature_pca_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_feature_pca_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_feature_pca_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_feature_pca_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_feature_pca_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_feature_pca_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_feature_pca_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_feature_pca_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_feature_pca_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_feature_pca_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_feature_pca_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_feature_pca_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_feature_pca_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_feature_pca_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_feature_pca_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_feature_pca_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_feature_pca_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_feature_pca_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlfeaturepcaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_frame_make(size : Int) -> MlfeaturepcaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_frame_len(s : MlfeaturepcaFrame) -> Int { s.size }

pub fn ml_feature_pca_frame_get(s : MlfeaturepcaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_frame_set(s : MlfeaturepcaFrame, i : Int, v : Double) -> MlfeaturepcaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_frame_sum(s : MlfeaturepcaFrame) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_frame_mean(s : MlfeaturepcaFrame) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_frame_scale(s : MlfeaturepcaFrame, f : Double) -> MlfeaturepcaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_frame_add(a : MlfeaturepcaFrame, b : MlfeaturepcaFrame) -> MlfeaturepcaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_frame_copy(s : MlfeaturepcaFrame) -> MlfeaturepcaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_frame_fill(s : MlfeaturepcaFrame, v : Double) -> MlfeaturepcaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_frame_min(s : MlfeaturepcaFrame) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_frame_max(s : MlfeaturepcaFrame) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_frame_to_string(s : MlfeaturepcaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_table_make(size : Int) -> MlfeaturepcaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_table_len(s : MlfeaturepcaTable) -> Int { s.size }

pub fn ml_feature_pca_table_get(s : MlfeaturepcaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_table_set(s : MlfeaturepcaTable, i : Int, v : Double) -> MlfeaturepcaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_table_sum(s : MlfeaturepcaTable) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_table_mean(s : MlfeaturepcaTable) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_table_scale(s : MlfeaturepcaTable, f : Double) -> MlfeaturepcaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_table_add(a : MlfeaturepcaTable, b : MlfeaturepcaTable) -> MlfeaturepcaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_table_copy(s : MlfeaturepcaTable) -> MlfeaturepcaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_table_fill(s : MlfeaturepcaTable, v : Double) -> MlfeaturepcaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_table_min(s : MlfeaturepcaTable) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_table_max(s : MlfeaturepcaTable) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_table_to_string(s : MlfeaturepcaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_graphn_make(size : Int) -> MlfeaturepcaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_graphn_len(s : MlfeaturepcaGraphN) -> Int { s.size }

pub fn ml_feature_pca_graphn_get(s : MlfeaturepcaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_graphn_set(s : MlfeaturepcaGraphN, i : Int, v : Double) -> MlfeaturepcaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_graphn_sum(s : MlfeaturepcaGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_graphn_mean(s : MlfeaturepcaGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_graphn_scale(s : MlfeaturepcaGraphN, f : Double) -> MlfeaturepcaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_graphn_add(a : MlfeaturepcaGraphN, b : MlfeaturepcaGraphN) -> MlfeaturepcaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_graphn_copy(s : MlfeaturepcaGraphN) -> MlfeaturepcaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_graphn_fill(s : MlfeaturepcaGraphN, v : Double) -> MlfeaturepcaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_graphn_min(s : MlfeaturepcaGraphN) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_graphn_max(s : MlfeaturepcaGraphN) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_graphn_to_string(s : MlfeaturepcaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_node_make(size : Int) -> MlfeaturepcaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_node_len(s : MlfeaturepcaNode) -> Int { s.size }

pub fn ml_feature_pca_node_get(s : MlfeaturepcaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_node_set(s : MlfeaturepcaNode, i : Int, v : Double) -> MlfeaturepcaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_node_sum(s : MlfeaturepcaNode) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_node_mean(s : MlfeaturepcaNode) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_node_scale(s : MlfeaturepcaNode, f : Double) -> MlfeaturepcaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_node_add(a : MlfeaturepcaNode, b : MlfeaturepcaNode) -> MlfeaturepcaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_node_copy(s : MlfeaturepcaNode) -> MlfeaturepcaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_node_fill(s : MlfeaturepcaNode, v : Double) -> MlfeaturepcaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_node_min(s : MlfeaturepcaNode) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_node_max(s : MlfeaturepcaNode) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_node_to_string(s : MlfeaturepcaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_edge_make(size : Int) -> MlfeaturepcaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_edge_len(s : MlfeaturepcaEdge) -> Int { s.size }

pub fn ml_feature_pca_edge_get(s : MlfeaturepcaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_edge_set(s : MlfeaturepcaEdge, i : Int, v : Double) -> MlfeaturepcaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_edge_sum(s : MlfeaturepcaEdge) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_edge_mean(s : MlfeaturepcaEdge) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_edge_scale(s : MlfeaturepcaEdge, f : Double) -> MlfeaturepcaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_edge_add(a : MlfeaturepcaEdge, b : MlfeaturepcaEdge) -> MlfeaturepcaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_edge_copy(s : MlfeaturepcaEdge) -> MlfeaturepcaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_edge_fill(s : MlfeaturepcaEdge, v : Double) -> MlfeaturepcaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_edge_min(s : MlfeaturepcaEdge) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_edge_max(s : MlfeaturepcaEdge) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_edge_to_string(s : MlfeaturepcaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_path_make(size : Int) -> MlfeaturepcaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_path_len(s : MlfeaturepcaPath) -> Int { s.size }

pub fn ml_feature_pca_path_get(s : MlfeaturepcaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_path_set(s : MlfeaturepcaPath, i : Int, v : Double) -> MlfeaturepcaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_path_sum(s : MlfeaturepcaPath) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_path_mean(s : MlfeaturepcaPath) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_path_scale(s : MlfeaturepcaPath, f : Double) -> MlfeaturepcaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_path_add(a : MlfeaturepcaPath, b : MlfeaturepcaPath) -> MlfeaturepcaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_path_copy(s : MlfeaturepcaPath) -> MlfeaturepcaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_path_fill(s : MlfeaturepcaPath, v : Double) -> MlfeaturepcaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_path_min(s : MlfeaturepcaPath) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_path_max(s : MlfeaturepcaPath) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_path_to_string(s : MlfeaturepcaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_cluster_make(size : Int) -> MlfeaturepcaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_cluster_len(s : MlfeaturepcaCluster) -> Int { s.size }

pub fn ml_feature_pca_cluster_get(s : MlfeaturepcaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_cluster_set(s : MlfeaturepcaCluster, i : Int, v : Double) -> MlfeaturepcaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_cluster_sum(s : MlfeaturepcaCluster) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_cluster_mean(s : MlfeaturepcaCluster) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_cluster_scale(s : MlfeaturepcaCluster, f : Double) -> MlfeaturepcaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_cluster_add(a : MlfeaturepcaCluster, b : MlfeaturepcaCluster) -> MlfeaturepcaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_cluster_copy(s : MlfeaturepcaCluster) -> MlfeaturepcaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_cluster_fill(s : MlfeaturepcaCluster, v : Double) -> MlfeaturepcaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_cluster_min(s : MlfeaturepcaCluster) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_cluster_max(s : MlfeaturepcaCluster) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_cluster_to_string(s : MlfeaturepcaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_model_make(size : Int) -> MlfeaturepcaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_model_len(s : MlfeaturepcaModel) -> Int { s.size }

pub fn ml_feature_pca_model_get(s : MlfeaturepcaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_model_set(s : MlfeaturepcaModel, i : Int, v : Double) -> MlfeaturepcaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_model_sum(s : MlfeaturepcaModel) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_model_mean(s : MlfeaturepcaModel) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_model_scale(s : MlfeaturepcaModel, f : Double) -> MlfeaturepcaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_model_add(a : MlfeaturepcaModel, b : MlfeaturepcaModel) -> MlfeaturepcaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_model_copy(s : MlfeaturepcaModel) -> MlfeaturepcaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_model_fill(s : MlfeaturepcaModel, v : Double) -> MlfeaturepcaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_model_min(s : MlfeaturepcaModel) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_model_max(s : MlfeaturepcaModel) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_model_to_string(s : MlfeaturepcaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_layer_make(size : Int) -> MlfeaturepcaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_layer_len(s : MlfeaturepcaLayer) -> Int { s.size }

pub fn ml_feature_pca_layer_get(s : MlfeaturepcaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_layer_set(s : MlfeaturepcaLayer, i : Int, v : Double) -> MlfeaturepcaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_layer_sum(s : MlfeaturepcaLayer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_layer_mean(s : MlfeaturepcaLayer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_layer_scale(s : MlfeaturepcaLayer, f : Double) -> MlfeaturepcaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_layer_add(a : MlfeaturepcaLayer, b : MlfeaturepcaLayer) -> MlfeaturepcaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_layer_copy(s : MlfeaturepcaLayer) -> MlfeaturepcaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_layer_fill(s : MlfeaturepcaLayer, v : Double) -> MlfeaturepcaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_layer_min(s : MlfeaturepcaLayer) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_layer_max(s : MlfeaturepcaLayer) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_layer_to_string(s : MlfeaturepcaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_buffer_make(size : Int) -> MlfeaturepcaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_buffer_len(s : MlfeaturepcaBuffer) -> Int { s.size }

pub fn ml_feature_pca_buffer_get(s : MlfeaturepcaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_buffer_set(s : MlfeaturepcaBuffer, i : Int, v : Double) -> MlfeaturepcaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_buffer_sum(s : MlfeaturepcaBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_buffer_mean(s : MlfeaturepcaBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_buffer_scale(s : MlfeaturepcaBuffer, f : Double) -> MlfeaturepcaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_buffer_add(a : MlfeaturepcaBuffer, b : MlfeaturepcaBuffer) -> MlfeaturepcaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_buffer_copy(s : MlfeaturepcaBuffer) -> MlfeaturepcaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_buffer_fill(s : MlfeaturepcaBuffer, v : Double) -> MlfeaturepcaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_buffer_min(s : MlfeaturepcaBuffer) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_buffer_max(s : MlfeaturepcaBuffer) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_buffer_to_string(s : MlfeaturepcaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_cursor_make(size : Int) -> MlfeaturepcaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_cursor_len(s : MlfeaturepcaCursor) -> Int { s.size }

pub fn ml_feature_pca_cursor_get(s : MlfeaturepcaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_cursor_set(s : MlfeaturepcaCursor, i : Int, v : Double) -> MlfeaturepcaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_cursor_sum(s : MlfeaturepcaCursor) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_cursor_mean(s : MlfeaturepcaCursor) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_cursor_scale(s : MlfeaturepcaCursor, f : Double) -> MlfeaturepcaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_cursor_add(a : MlfeaturepcaCursor, b : MlfeaturepcaCursor) -> MlfeaturepcaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_cursor_copy(s : MlfeaturepcaCursor) -> MlfeaturepcaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_cursor_fill(s : MlfeaturepcaCursor, v : Double) -> MlfeaturepcaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_cursor_min(s : MlfeaturepcaCursor) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_cursor_max(s : MlfeaturepcaCursor) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_cursor_to_string(s : MlfeaturepcaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_view_make(size : Int) -> MlfeaturepcaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_view_len(s : MlfeaturepcaView) -> Int { s.size }

pub fn ml_feature_pca_view_get(s : MlfeaturepcaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_view_set(s : MlfeaturepcaView, i : Int, v : Double) -> MlfeaturepcaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_view_sum(s : MlfeaturepcaView) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_view_mean(s : MlfeaturepcaView) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_view_scale(s : MlfeaturepcaView, f : Double) -> MlfeaturepcaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_view_add(a : MlfeaturepcaView, b : MlfeaturepcaView) -> MlfeaturepcaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_view_copy(s : MlfeaturepcaView) -> MlfeaturepcaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_view_fill(s : MlfeaturepcaView, v : Double) -> MlfeaturepcaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_view_min(s : MlfeaturepcaView) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_view_max(s : MlfeaturepcaView) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_view_to_string(s : MlfeaturepcaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_range_make(size : Int) -> MlfeaturepcaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_range_len(s : MlfeaturepcaRange) -> Int { s.size }

pub fn ml_feature_pca_range_get(s : MlfeaturepcaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_range_set(s : MlfeaturepcaRange, i : Int, v : Double) -> MlfeaturepcaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_range_sum(s : MlfeaturepcaRange) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_range_mean(s : MlfeaturepcaRange) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_range_scale(s : MlfeaturepcaRange, f : Double) -> MlfeaturepcaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_range_add(a : MlfeaturepcaRange, b : MlfeaturepcaRange) -> MlfeaturepcaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_range_copy(s : MlfeaturepcaRange) -> MlfeaturepcaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_range_fill(s : MlfeaturepcaRange, v : Double) -> MlfeaturepcaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_range_min(s : MlfeaturepcaRange) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_range_max(s : MlfeaturepcaRange) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_range_to_string(s : MlfeaturepcaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_slice_make(size : Int) -> MlfeaturepcaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_slice_len(s : MlfeaturepcaSlice) -> Int { s.size }

pub fn ml_feature_pca_slice_get(s : MlfeaturepcaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_slice_set(s : MlfeaturepcaSlice, i : Int, v : Double) -> MlfeaturepcaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_slice_sum(s : MlfeaturepcaSlice) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_slice_mean(s : MlfeaturepcaSlice) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_slice_scale(s : MlfeaturepcaSlice, f : Double) -> MlfeaturepcaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_slice_add(a : MlfeaturepcaSlice, b : MlfeaturepcaSlice) -> MlfeaturepcaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_slice_copy(s : MlfeaturepcaSlice) -> MlfeaturepcaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_slice_fill(s : MlfeaturepcaSlice, v : Double) -> MlfeaturepcaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_slice_min(s : MlfeaturepcaSlice) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_slice_max(s : MlfeaturepcaSlice) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_slice_to_string(s : MlfeaturepcaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

