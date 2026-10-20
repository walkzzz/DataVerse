///===
/// extcore/ml_cluster_birch

pub(all) struct MlclusterbirchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_birch_make_point(x : Double, y : Double) -> MlclusterbirchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_birch_make_point3(x : Double, y : Double, z : Double) -> MlclusterbirchPoint {
  { x, y, z, label: 0 }
}

pub fn ml_cluster_birch_point_x(pt : MlclusterbirchPoint) -> Double { pt.x }

pub fn ml_cluster_birch_point_y(pt : MlclusterbirchPoint) -> Double { pt.y }

pub fn ml_cluster_birch_point_z(pt : MlclusterbirchPoint) -> Double { pt.z }

pub fn ml_cluster_birch_point_label(pt : MlclusterbirchPoint) -> Int { pt.label }

pub fn ml_cluster_birch_point_dist(a : MlclusterbirchPoint, b : MlclusterbirchPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_cluster_birch_point_add(a : MlclusterbirchPoint, b : MlclusterbirchPoint) -> MlclusterbirchPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_cluster_birch_point_sub(a : MlclusterbirchPoint, b : MlclusterbirchPoint) -> MlclusterbirchPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_cluster_birch_point_scale(pt : MlclusterbirchPoint, s : Double) -> MlclusterbirchPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_cluster_birch_point_dot(a : MlclusterbirchPoint, b : MlclusterbirchPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_cluster_birch_point_cross(a : MlclusterbirchPoint, b : MlclusterbirchPoint) -> MlclusterbirchPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_cluster_birch_point_norm(pt : MlclusterbirchPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_cluster_birch_point_normalize(pt : MlclusterbirchPoint) -> MlclusterbirchPoint {
  let n = ml_cluster_birch_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_cluster_birch_point_scale(pt, 1.0 / n) }
}

pub fn ml_cluster_birch_point_negate(pt : MlclusterbirchPoint) -> MlclusterbirchPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_cluster_birch_point_mid(a : MlclusterbirchPoint, b : MlclusterbirchPoint) -> MlclusterbirchPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_cluster_birch_point_lerp(a : MlclusterbirchPoint, b : MlclusterbirchPoint, t : Double) -> MlclusterbirchPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_cluster_birch_point_to_string(pt : MlclusterbirchPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlclusterbirchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_birch_make_series(vals : Array[Double], name : String) -> MlclusterbirchSeries {
  { vals, name, meta: 0 }
}

pub fn ml_cluster_birch_series_len(s : MlclusterbirchSeries) -> Int { s.vals.length() }

pub fn ml_cluster_birch_series_sum(s : MlclusterbirchSeries) -> Double { @_common.sum(s.vals) }

pub fn ml_cluster_birch_series_mean(s : MlclusterbirchSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_cluster_birch_series_min(s : MlclusterbirchSeries) -> Double { @_common.min(s.vals) }

pub fn ml_cluster_birch_series_max(s : MlclusterbirchSeries) -> Double { @_common.max(s.vals) }

pub fn ml_cluster_birch_series_range(s : MlclusterbirchSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_cluster_birch_series_var(s : MlclusterbirchSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_cluster_birch_series_std(s : MlclusterbirchSeries) -> Double { @_common.std(s.vals) }

pub fn ml_cluster_birch_series_median(s : MlclusterbirchSeries) -> Double { @_common.median(s.vals) }

pub fn ml_cluster_birch_series_scale(s : MlclusterbirchSeries, f : Double) -> MlclusterbirchSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn ml_cluster_birch_series_add(a : MlclusterbirchSeries, b : MlclusterbirchSeries) -> MlclusterbirchSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_cluster_birch_series_sub(a : MlclusterbirchSeries, b : MlclusterbirchSeries) -> MlclusterbirchSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_cluster_birch_series_normalize(s : MlclusterbirchSeries) -> MlclusterbirchSeries {
  let mn = ml_cluster_birch_series_min(s)
  let mx = ml_cluster_birch_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_cluster_birch_series_cumsum(s : MlclusterbirchSeries) -> MlclusterbirchSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_cluster_birch_series_to_string(s : MlclusterbirchSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclusterbirchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_birch_make_matrix(rows : Int, cols : Int, val : Double) -> MlclusterbirchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_birch_matrix_identity(n : Int) -> MlclusterbirchMatrix {
  let m = ml_cluster_birch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_cluster_birch_matrix_get(m : MlclusterbirchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_cluster_birch_matrix_transpose(m : MlclusterbirchMatrix) -> MlclusterbirchMatrix {
  let result = ml_cluster_birch_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_cluster_birch_matrix_add(a : MlclusterbirchMatrix, b : MlclusterbirchMatrix) -> MlclusterbirchMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_cluster_birch_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_cluster_birch_matrix_scale(m : MlclusterbirchMatrix, s : Double) -> MlclusterbirchMatrix {
  let result = ml_cluster_birch_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_cluster_birch_matrix_multiply(a : MlclusterbirchMatrix, b : MlclusterbirchMatrix) -> MlclusterbirchMatrix {
  if a.cols != b.rows { return ml_cluster_birch_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_cluster_birch_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_cluster_birch_matrix_trace(m : MlclusterbirchMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_cluster_birch_matrix_det(m : MlclusterbirchMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_cluster_birch_matrix_norm(m : MlclusterbirchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_cluster_birch_matrix_to_string(m : MlclusterbirchMatrix) -> String {
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

pub(all) struct MlclusterbirchVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_birch_make_vector(comps : Array[Double]) -> MlclusterbirchVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_birch_vector_zero(dim : Int) -> MlclusterbirchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_cluster_birch_vector_add(a : MlclusterbirchVector, b : MlclusterbirchVector) -> MlclusterbirchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn ml_cluster_birch_vector_sub(a : MlclusterbirchVector, b : MlclusterbirchVector) -> MlclusterbirchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn ml_cluster_birch_vector_scale(v : MlclusterbirchVector, s : Double) -> MlclusterbirchVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn ml_cluster_birch_vector_dot(a : MlclusterbirchVector, b : MlclusterbirchVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_cluster_birch_vector_norm(v : MlclusterbirchVector) -> Double { @_common.sqrt(ml_cluster_birch_vector_dot(v, v)) }

pub fn ml_cluster_birch_vector_normalize(v : MlclusterbirchVector) -> MlclusterbirchVector {
  let n = ml_cluster_birch_vector_norm(v)
  if n < 0.0000001 { v } else { ml_cluster_birch_vector_scale(v, 1.0 / n) }
}

pub fn ml_cluster_birch_vector_dist(a : MlclusterbirchVector, b : MlclusterbirchVector) -> Double {
  ml_cluster_birch_vector_norm(ml_cluster_birch_vector_sub(a, b))
}

pub fn ml_cluster_birch_vector_to_string(v : MlclusterbirchVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_cluster_birch_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_cluster_birch_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_cluster_birch_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_cluster_birch_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_cluster_birch_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_cluster_birch_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_cluster_birch_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_cluster_birch_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_cluster_birch_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_cluster_birch_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_cluster_birch_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_cluster_birch_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_cluster_birch_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_cluster_birch_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_cluster_birch_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_cluster_birch_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_cluster_birch_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_cluster_birch_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_cluster_birch_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_cluster_birch_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_cluster_birch_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_cluster_birch_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_cluster_birch_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_cluster_birch_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_cluster_birch_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_cluster_birch_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_cluster_birch_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_cluster_birch_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_cluster_birch_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclusterbirchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_frame_make(size : Int) -> MlclusterbirchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_frame_len(s : MlclusterbirchFrame) -> Int { s.size }

pub fn ml_cluster_birch_frame_get(s : MlclusterbirchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_frame_set(s : MlclusterbirchFrame, i : Int, v : Double) -> MlclusterbirchFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_frame_sum(s : MlclusterbirchFrame) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_frame_mean(s : MlclusterbirchFrame) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_frame_scale(s : MlclusterbirchFrame, f : Double) -> MlclusterbirchFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_frame_add(a : MlclusterbirchFrame, b : MlclusterbirchFrame) -> MlclusterbirchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_frame_copy(s : MlclusterbirchFrame) -> MlclusterbirchFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_frame_fill(s : MlclusterbirchFrame, v : Double) -> MlclusterbirchFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_frame_min(s : MlclusterbirchFrame) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_frame_max(s : MlclusterbirchFrame) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_frame_to_string(s : MlclusterbirchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_table_make(size : Int) -> MlclusterbirchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_table_len(s : MlclusterbirchTable) -> Int { s.size }

pub fn ml_cluster_birch_table_get(s : MlclusterbirchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_table_set(s : MlclusterbirchTable, i : Int, v : Double) -> MlclusterbirchTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_table_sum(s : MlclusterbirchTable) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_table_mean(s : MlclusterbirchTable) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_table_scale(s : MlclusterbirchTable, f : Double) -> MlclusterbirchTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_table_add(a : MlclusterbirchTable, b : MlclusterbirchTable) -> MlclusterbirchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_table_copy(s : MlclusterbirchTable) -> MlclusterbirchTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_table_fill(s : MlclusterbirchTable, v : Double) -> MlclusterbirchTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_table_min(s : MlclusterbirchTable) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_table_max(s : MlclusterbirchTable) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_table_to_string(s : MlclusterbirchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_graphn_make(size : Int) -> MlclusterbirchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_graphn_len(s : MlclusterbirchGraphN) -> Int { s.size }

pub fn ml_cluster_birch_graphn_get(s : MlclusterbirchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_graphn_set(s : MlclusterbirchGraphN, i : Int, v : Double) -> MlclusterbirchGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_graphn_sum(s : MlclusterbirchGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_graphn_mean(s : MlclusterbirchGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_graphn_scale(s : MlclusterbirchGraphN, f : Double) -> MlclusterbirchGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_graphn_add(a : MlclusterbirchGraphN, b : MlclusterbirchGraphN) -> MlclusterbirchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_graphn_copy(s : MlclusterbirchGraphN) -> MlclusterbirchGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_graphn_fill(s : MlclusterbirchGraphN, v : Double) -> MlclusterbirchGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_graphn_min(s : MlclusterbirchGraphN) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_graphn_max(s : MlclusterbirchGraphN) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_graphn_to_string(s : MlclusterbirchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_node_make(size : Int) -> MlclusterbirchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_node_len(s : MlclusterbirchNode) -> Int { s.size }

pub fn ml_cluster_birch_node_get(s : MlclusterbirchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_node_set(s : MlclusterbirchNode, i : Int, v : Double) -> MlclusterbirchNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_node_sum(s : MlclusterbirchNode) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_node_mean(s : MlclusterbirchNode) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_node_scale(s : MlclusterbirchNode, f : Double) -> MlclusterbirchNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_node_add(a : MlclusterbirchNode, b : MlclusterbirchNode) -> MlclusterbirchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_node_copy(s : MlclusterbirchNode) -> MlclusterbirchNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_node_fill(s : MlclusterbirchNode, v : Double) -> MlclusterbirchNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_node_min(s : MlclusterbirchNode) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_node_max(s : MlclusterbirchNode) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_node_to_string(s : MlclusterbirchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_edge_make(size : Int) -> MlclusterbirchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_edge_len(s : MlclusterbirchEdge) -> Int { s.size }

pub fn ml_cluster_birch_edge_get(s : MlclusterbirchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_edge_set(s : MlclusterbirchEdge, i : Int, v : Double) -> MlclusterbirchEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_edge_sum(s : MlclusterbirchEdge) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_edge_mean(s : MlclusterbirchEdge) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_edge_scale(s : MlclusterbirchEdge, f : Double) -> MlclusterbirchEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_edge_add(a : MlclusterbirchEdge, b : MlclusterbirchEdge) -> MlclusterbirchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_edge_copy(s : MlclusterbirchEdge) -> MlclusterbirchEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_edge_fill(s : MlclusterbirchEdge, v : Double) -> MlclusterbirchEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_edge_min(s : MlclusterbirchEdge) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_edge_max(s : MlclusterbirchEdge) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_edge_to_string(s : MlclusterbirchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_path_make(size : Int) -> MlclusterbirchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_path_len(s : MlclusterbirchPath) -> Int { s.size }

pub fn ml_cluster_birch_path_get(s : MlclusterbirchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_path_set(s : MlclusterbirchPath, i : Int, v : Double) -> MlclusterbirchPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_path_sum(s : MlclusterbirchPath) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_path_mean(s : MlclusterbirchPath) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_path_scale(s : MlclusterbirchPath, f : Double) -> MlclusterbirchPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_path_add(a : MlclusterbirchPath, b : MlclusterbirchPath) -> MlclusterbirchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_path_copy(s : MlclusterbirchPath) -> MlclusterbirchPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_path_fill(s : MlclusterbirchPath, v : Double) -> MlclusterbirchPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_path_min(s : MlclusterbirchPath) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_path_max(s : MlclusterbirchPath) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_path_to_string(s : MlclusterbirchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_cluster_make(size : Int) -> MlclusterbirchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_cluster_len(s : MlclusterbirchCluster) -> Int { s.size }

pub fn ml_cluster_birch_cluster_get(s : MlclusterbirchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_cluster_set(s : MlclusterbirchCluster, i : Int, v : Double) -> MlclusterbirchCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_cluster_sum(s : MlclusterbirchCluster) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_cluster_mean(s : MlclusterbirchCluster) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_cluster_scale(s : MlclusterbirchCluster, f : Double) -> MlclusterbirchCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_cluster_add(a : MlclusterbirchCluster, b : MlclusterbirchCluster) -> MlclusterbirchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_cluster_copy(s : MlclusterbirchCluster) -> MlclusterbirchCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_cluster_fill(s : MlclusterbirchCluster, v : Double) -> MlclusterbirchCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_cluster_min(s : MlclusterbirchCluster) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_cluster_max(s : MlclusterbirchCluster) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_cluster_to_string(s : MlclusterbirchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_model_make(size : Int) -> MlclusterbirchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_model_len(s : MlclusterbirchModel) -> Int { s.size }

pub fn ml_cluster_birch_model_get(s : MlclusterbirchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_model_set(s : MlclusterbirchModel, i : Int, v : Double) -> MlclusterbirchModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_model_sum(s : MlclusterbirchModel) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_model_mean(s : MlclusterbirchModel) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_model_scale(s : MlclusterbirchModel, f : Double) -> MlclusterbirchModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_model_add(a : MlclusterbirchModel, b : MlclusterbirchModel) -> MlclusterbirchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_model_copy(s : MlclusterbirchModel) -> MlclusterbirchModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_model_fill(s : MlclusterbirchModel, v : Double) -> MlclusterbirchModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_model_min(s : MlclusterbirchModel) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_model_max(s : MlclusterbirchModel) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_model_to_string(s : MlclusterbirchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_layer_make(size : Int) -> MlclusterbirchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_layer_len(s : MlclusterbirchLayer) -> Int { s.size }

pub fn ml_cluster_birch_layer_get(s : MlclusterbirchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_layer_set(s : MlclusterbirchLayer, i : Int, v : Double) -> MlclusterbirchLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_layer_sum(s : MlclusterbirchLayer) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_layer_mean(s : MlclusterbirchLayer) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_layer_scale(s : MlclusterbirchLayer, f : Double) -> MlclusterbirchLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_layer_add(a : MlclusterbirchLayer, b : MlclusterbirchLayer) -> MlclusterbirchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_layer_copy(s : MlclusterbirchLayer) -> MlclusterbirchLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_layer_fill(s : MlclusterbirchLayer, v : Double) -> MlclusterbirchLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_layer_min(s : MlclusterbirchLayer) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_layer_max(s : MlclusterbirchLayer) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_layer_to_string(s : MlclusterbirchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_buffer_make(size : Int) -> MlclusterbirchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_buffer_len(s : MlclusterbirchBuffer) -> Int { s.size }

pub fn ml_cluster_birch_buffer_get(s : MlclusterbirchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_buffer_set(s : MlclusterbirchBuffer, i : Int, v : Double) -> MlclusterbirchBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_buffer_sum(s : MlclusterbirchBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_buffer_mean(s : MlclusterbirchBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_buffer_scale(s : MlclusterbirchBuffer, f : Double) -> MlclusterbirchBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_buffer_add(a : MlclusterbirchBuffer, b : MlclusterbirchBuffer) -> MlclusterbirchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_buffer_copy(s : MlclusterbirchBuffer) -> MlclusterbirchBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_buffer_fill(s : MlclusterbirchBuffer, v : Double) -> MlclusterbirchBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_buffer_min(s : MlclusterbirchBuffer) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_buffer_max(s : MlclusterbirchBuffer) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_buffer_to_string(s : MlclusterbirchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_cursor_make(size : Int) -> MlclusterbirchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_cursor_len(s : MlclusterbirchCursor) -> Int { s.size }

pub fn ml_cluster_birch_cursor_get(s : MlclusterbirchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_cursor_set(s : MlclusterbirchCursor, i : Int, v : Double) -> MlclusterbirchCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_cursor_sum(s : MlclusterbirchCursor) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_cursor_mean(s : MlclusterbirchCursor) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_cursor_scale(s : MlclusterbirchCursor, f : Double) -> MlclusterbirchCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_cursor_add(a : MlclusterbirchCursor, b : MlclusterbirchCursor) -> MlclusterbirchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_cursor_copy(s : MlclusterbirchCursor) -> MlclusterbirchCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_cursor_fill(s : MlclusterbirchCursor, v : Double) -> MlclusterbirchCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_cursor_min(s : MlclusterbirchCursor) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_cursor_max(s : MlclusterbirchCursor) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_cursor_to_string(s : MlclusterbirchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_view_make(size : Int) -> MlclusterbirchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_view_len(s : MlclusterbirchView) -> Int { s.size }

pub fn ml_cluster_birch_view_get(s : MlclusterbirchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_view_set(s : MlclusterbirchView, i : Int, v : Double) -> MlclusterbirchView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_view_sum(s : MlclusterbirchView) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_view_mean(s : MlclusterbirchView) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_view_scale(s : MlclusterbirchView, f : Double) -> MlclusterbirchView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_view_add(a : MlclusterbirchView, b : MlclusterbirchView) -> MlclusterbirchView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_view_copy(s : MlclusterbirchView) -> MlclusterbirchView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_view_fill(s : MlclusterbirchView, v : Double) -> MlclusterbirchView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_view_min(s : MlclusterbirchView) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_view_max(s : MlclusterbirchView) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_view_to_string(s : MlclusterbirchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_range_make(size : Int) -> MlclusterbirchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_range_len(s : MlclusterbirchRange) -> Int { s.size }

pub fn ml_cluster_birch_range_get(s : MlclusterbirchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_range_set(s : MlclusterbirchRange, i : Int, v : Double) -> MlclusterbirchRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_range_sum(s : MlclusterbirchRange) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_range_mean(s : MlclusterbirchRange) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_range_scale(s : MlclusterbirchRange, f : Double) -> MlclusterbirchRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_range_add(a : MlclusterbirchRange, b : MlclusterbirchRange) -> MlclusterbirchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_range_copy(s : MlclusterbirchRange) -> MlclusterbirchRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_range_fill(s : MlclusterbirchRange, v : Double) -> MlclusterbirchRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_range_min(s : MlclusterbirchRange) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_range_max(s : MlclusterbirchRange) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_range_to_string(s : MlclusterbirchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_slice_make(size : Int) -> MlclusterbirchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_slice_len(s : MlclusterbirchSlice) -> Int { s.size }

pub fn ml_cluster_birch_slice_get(s : MlclusterbirchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_slice_set(s : MlclusterbirchSlice, i : Int, v : Double) -> MlclusterbirchSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_slice_sum(s : MlclusterbirchSlice) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_slice_mean(s : MlclusterbirchSlice) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_slice_scale(s : MlclusterbirchSlice, f : Double) -> MlclusterbirchSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_slice_add(a : MlclusterbirchSlice, b : MlclusterbirchSlice) -> MlclusterbirchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_slice_copy(s : MlclusterbirchSlice) -> MlclusterbirchSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_slice_fill(s : MlclusterbirchSlice, v : Double) -> MlclusterbirchSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_slice_min(s : MlclusterbirchSlice) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_slice_max(s : MlclusterbirchSlice) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_slice_to_string(s : MlclusterbirchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

