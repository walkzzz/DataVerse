///===
/// extcore/ml_metric_fairness

pub(all) struct MlmetricfairnessPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_fairness_make_point(x : Double, y : Double) -> MlmetricfairnessPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_fairness_make_point3(x : Double, y : Double, z : Double) -> MlmetricfairnessPoint {
  { x, y, z, label: 0 }
}

pub fn ml_metric_fairness_point_x(pt : MlmetricfairnessPoint) -> Double { pt.x }

pub fn ml_metric_fairness_point_y(pt : MlmetricfairnessPoint) -> Double { pt.y }

pub fn ml_metric_fairness_point_z(pt : MlmetricfairnessPoint) -> Double { pt.z }

pub fn ml_metric_fairness_point_label(pt : MlmetricfairnessPoint) -> Int { pt.label }

pub fn ml_metric_fairness_point_dist(a : MlmetricfairnessPoint, b : MlmetricfairnessPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_metric_fairness_point_add(a : MlmetricfairnessPoint, b : MlmetricfairnessPoint) -> MlmetricfairnessPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_metric_fairness_point_sub(a : MlmetricfairnessPoint, b : MlmetricfairnessPoint) -> MlmetricfairnessPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_metric_fairness_point_scale(pt : MlmetricfairnessPoint, s : Double) -> MlmetricfairnessPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_metric_fairness_point_dot(a : MlmetricfairnessPoint, b : MlmetricfairnessPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_metric_fairness_point_cross(a : MlmetricfairnessPoint, b : MlmetricfairnessPoint) -> MlmetricfairnessPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_metric_fairness_point_norm(pt : MlmetricfairnessPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_metric_fairness_point_normalize(pt : MlmetricfairnessPoint) -> MlmetricfairnessPoint {
  let n = ml_metric_fairness_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_metric_fairness_point_scale(pt, 1.0 / n) }
}

pub fn ml_metric_fairness_point_negate(pt : MlmetricfairnessPoint) -> MlmetricfairnessPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_metric_fairness_point_mid(a : MlmetricfairnessPoint, b : MlmetricfairnessPoint) -> MlmetricfairnessPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_metric_fairness_point_lerp(a : MlmetricfairnessPoint, b : MlmetricfairnessPoint, t : Double) -> MlmetricfairnessPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_metric_fairness_point_to_string(pt : MlmetricfairnessPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlmetricfairnessSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_fairness_make_series(vals : Array[Double], name : String) -> MlmetricfairnessSeries {
  { vals, name, meta: 0 }
}

pub fn ml_metric_fairness_series_len(s : MlmetricfairnessSeries) -> Int { s.vals.length() }

pub fn ml_metric_fairness_series_sum(s : MlmetricfairnessSeries) -> Double { @_common.sum(s.vals) }

pub fn ml_metric_fairness_series_mean(s : MlmetricfairnessSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_metric_fairness_series_min(s : MlmetricfairnessSeries) -> Double { @_common.min(s.vals) }

pub fn ml_metric_fairness_series_max(s : MlmetricfairnessSeries) -> Double { @_common.max(s.vals) }

pub fn ml_metric_fairness_series_range(s : MlmetricfairnessSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_metric_fairness_series_var(s : MlmetricfairnessSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_metric_fairness_series_std(s : MlmetricfairnessSeries) -> Double { @_common.std(s.vals) }

pub fn ml_metric_fairness_series_median(s : MlmetricfairnessSeries) -> Double { @_common.median(s.vals) }

pub fn ml_metric_fairness_series_scale(s : MlmetricfairnessSeries, f : Double) -> MlmetricfairnessSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn ml_metric_fairness_series_add(a : MlmetricfairnessSeries, b : MlmetricfairnessSeries) -> MlmetricfairnessSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_metric_fairness_series_sub(a : MlmetricfairnessSeries, b : MlmetricfairnessSeries) -> MlmetricfairnessSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_metric_fairness_series_normalize(s : MlmetricfairnessSeries) -> MlmetricfairnessSeries {
  let mn = ml_metric_fairness_series_min(s)
  let mx = ml_metric_fairness_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_metric_fairness_series_cumsum(s : MlmetricfairnessSeries) -> MlmetricfairnessSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_metric_fairness_series_to_string(s : MlmetricfairnessSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricfairnessMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_fairness_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetricfairnessMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_fairness_matrix_identity(n : Int) -> MlmetricfairnessMatrix {
  let m = ml_metric_fairness_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_metric_fairness_matrix_get(m : MlmetricfairnessMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_metric_fairness_matrix_transpose(m : MlmetricfairnessMatrix) -> MlmetricfairnessMatrix {
  let result = ml_metric_fairness_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_metric_fairness_matrix_add(a : MlmetricfairnessMatrix, b : MlmetricfairnessMatrix) -> MlmetricfairnessMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_metric_fairness_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_metric_fairness_matrix_scale(m : MlmetricfairnessMatrix, s : Double) -> MlmetricfairnessMatrix {
  let result = ml_metric_fairness_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_metric_fairness_matrix_multiply(a : MlmetricfairnessMatrix, b : MlmetricfairnessMatrix) -> MlmetricfairnessMatrix {
  if a.cols != b.rows { return ml_metric_fairness_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_metric_fairness_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_metric_fairness_matrix_trace(m : MlmetricfairnessMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_metric_fairness_matrix_det(m : MlmetricfairnessMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_metric_fairness_matrix_norm(m : MlmetricfairnessMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_metric_fairness_matrix_to_string(m : MlmetricfairnessMatrix) -> String {
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

pub(all) struct MlmetricfairnessVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_fairness_make_vector(comps : Array[Double]) -> MlmetricfairnessVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_fairness_vector_zero(dim : Int) -> MlmetricfairnessVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_metric_fairness_vector_add(a : MlmetricfairnessVector, b : MlmetricfairnessVector) -> MlmetricfairnessVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn ml_metric_fairness_vector_sub(a : MlmetricfairnessVector, b : MlmetricfairnessVector) -> MlmetricfairnessVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn ml_metric_fairness_vector_scale(v : MlmetricfairnessVector, s : Double) -> MlmetricfairnessVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn ml_metric_fairness_vector_dot(a : MlmetricfairnessVector, b : MlmetricfairnessVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_metric_fairness_vector_norm(v : MlmetricfairnessVector) -> Double { @_common.sqrt(ml_metric_fairness_vector_dot(v, v)) }

pub fn ml_metric_fairness_vector_normalize(v : MlmetricfairnessVector) -> MlmetricfairnessVector {
  let n = ml_metric_fairness_vector_norm(v)
  if n < 0.0000001 { v } else { ml_metric_fairness_vector_scale(v, 1.0 / n) }
}

pub fn ml_metric_fairness_vector_dist(a : MlmetricfairnessVector, b : MlmetricfairnessVector) -> Double {
  ml_metric_fairness_vector_norm(ml_metric_fairness_vector_sub(a, b))
}

pub fn ml_metric_fairness_vector_to_string(v : MlmetricfairnessVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_metric_fairness_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_metric_fairness_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_metric_fairness_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_metric_fairness_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_metric_fairness_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_metric_fairness_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_metric_fairness_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_metric_fairness_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_metric_fairness_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_metric_fairness_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_metric_fairness_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_metric_fairness_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_metric_fairness_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_metric_fairness_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_metric_fairness_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_metric_fairness_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_metric_fairness_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_metric_fairness_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_metric_fairness_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_metric_fairness_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_metric_fairness_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_metric_fairness_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_metric_fairness_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_metric_fairness_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_metric_fairness_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_metric_fairness_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_metric_fairness_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_metric_fairness_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_metric_fairness_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlmetricfairnessFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_frame_make(size : Int) -> MlmetricfairnessFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_fairness_frame_len(s : MlmetricfairnessFrame) -> Int { s.size }

pub fn ml_metric_fairness_frame_get(s : MlmetricfairnessFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_fairness_frame_set(s : MlmetricfairnessFrame, i : Int, v : Double) -> MlmetricfairnessFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_frame_sum(s : MlmetricfairnessFrame) -> Double { @_common.sum(s.data) }

pub fn ml_metric_fairness_frame_mean(s : MlmetricfairnessFrame) -> Double { @_common.mean(s.data) }

pub fn ml_metric_fairness_frame_scale(s : MlmetricfairnessFrame, f : Double) -> MlmetricfairnessFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_frame_add(a : MlmetricfairnessFrame, b : MlmetricfairnessFrame) -> MlmetricfairnessFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_fairness_frame_copy(s : MlmetricfairnessFrame) -> MlmetricfairnessFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_frame_fill(s : MlmetricfairnessFrame, v : Double) -> MlmetricfairnessFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_frame_min(s : MlmetricfairnessFrame) -> Double { @_common.min(s.data) }

pub fn ml_metric_fairness_frame_max(s : MlmetricfairnessFrame) -> Double { @_common.max(s.data) }

pub fn ml_metric_fairness_frame_to_string(s : MlmetricfairnessFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_table_make(size : Int) -> MlmetricfairnessTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_fairness_table_len(s : MlmetricfairnessTable) -> Int { s.size }

pub fn ml_metric_fairness_table_get(s : MlmetricfairnessTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_fairness_table_set(s : MlmetricfairnessTable, i : Int, v : Double) -> MlmetricfairnessTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_table_sum(s : MlmetricfairnessTable) -> Double { @_common.sum(s.data) }

pub fn ml_metric_fairness_table_mean(s : MlmetricfairnessTable) -> Double { @_common.mean(s.data) }

pub fn ml_metric_fairness_table_scale(s : MlmetricfairnessTable, f : Double) -> MlmetricfairnessTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_table_add(a : MlmetricfairnessTable, b : MlmetricfairnessTable) -> MlmetricfairnessTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_fairness_table_copy(s : MlmetricfairnessTable) -> MlmetricfairnessTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_table_fill(s : MlmetricfairnessTable, v : Double) -> MlmetricfairnessTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_table_min(s : MlmetricfairnessTable) -> Double { @_common.min(s.data) }

pub fn ml_metric_fairness_table_max(s : MlmetricfairnessTable) -> Double { @_common.max(s.data) }

pub fn ml_metric_fairness_table_to_string(s : MlmetricfairnessTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_graphn_make(size : Int) -> MlmetricfairnessGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_fairness_graphn_len(s : MlmetricfairnessGraphN) -> Int { s.size }

pub fn ml_metric_fairness_graphn_get(s : MlmetricfairnessGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_fairness_graphn_set(s : MlmetricfairnessGraphN, i : Int, v : Double) -> MlmetricfairnessGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_graphn_sum(s : MlmetricfairnessGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_metric_fairness_graphn_mean(s : MlmetricfairnessGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_metric_fairness_graphn_scale(s : MlmetricfairnessGraphN, f : Double) -> MlmetricfairnessGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_graphn_add(a : MlmetricfairnessGraphN, b : MlmetricfairnessGraphN) -> MlmetricfairnessGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_fairness_graphn_copy(s : MlmetricfairnessGraphN) -> MlmetricfairnessGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_graphn_fill(s : MlmetricfairnessGraphN, v : Double) -> MlmetricfairnessGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_graphn_min(s : MlmetricfairnessGraphN) -> Double { @_common.min(s.data) }

pub fn ml_metric_fairness_graphn_max(s : MlmetricfairnessGraphN) -> Double { @_common.max(s.data) }

pub fn ml_metric_fairness_graphn_to_string(s : MlmetricfairnessGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_node_make(size : Int) -> MlmetricfairnessNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_fairness_node_len(s : MlmetricfairnessNode) -> Int { s.size }

pub fn ml_metric_fairness_node_get(s : MlmetricfairnessNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_fairness_node_set(s : MlmetricfairnessNode, i : Int, v : Double) -> MlmetricfairnessNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_node_sum(s : MlmetricfairnessNode) -> Double { @_common.sum(s.data) }

pub fn ml_metric_fairness_node_mean(s : MlmetricfairnessNode) -> Double { @_common.mean(s.data) }

pub fn ml_metric_fairness_node_scale(s : MlmetricfairnessNode, f : Double) -> MlmetricfairnessNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_node_add(a : MlmetricfairnessNode, b : MlmetricfairnessNode) -> MlmetricfairnessNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_fairness_node_copy(s : MlmetricfairnessNode) -> MlmetricfairnessNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_node_fill(s : MlmetricfairnessNode, v : Double) -> MlmetricfairnessNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_node_min(s : MlmetricfairnessNode) -> Double { @_common.min(s.data) }

pub fn ml_metric_fairness_node_max(s : MlmetricfairnessNode) -> Double { @_common.max(s.data) }

pub fn ml_metric_fairness_node_to_string(s : MlmetricfairnessNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_edge_make(size : Int) -> MlmetricfairnessEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_fairness_edge_len(s : MlmetricfairnessEdge) -> Int { s.size }

pub fn ml_metric_fairness_edge_get(s : MlmetricfairnessEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_fairness_edge_set(s : MlmetricfairnessEdge, i : Int, v : Double) -> MlmetricfairnessEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_edge_sum(s : MlmetricfairnessEdge) -> Double { @_common.sum(s.data) }

pub fn ml_metric_fairness_edge_mean(s : MlmetricfairnessEdge) -> Double { @_common.mean(s.data) }

pub fn ml_metric_fairness_edge_scale(s : MlmetricfairnessEdge, f : Double) -> MlmetricfairnessEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_edge_add(a : MlmetricfairnessEdge, b : MlmetricfairnessEdge) -> MlmetricfairnessEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_fairness_edge_copy(s : MlmetricfairnessEdge) -> MlmetricfairnessEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_edge_fill(s : MlmetricfairnessEdge, v : Double) -> MlmetricfairnessEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_edge_min(s : MlmetricfairnessEdge) -> Double { @_common.min(s.data) }

pub fn ml_metric_fairness_edge_max(s : MlmetricfairnessEdge) -> Double { @_common.max(s.data) }

pub fn ml_metric_fairness_edge_to_string(s : MlmetricfairnessEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_path_make(size : Int) -> MlmetricfairnessPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_fairness_path_len(s : MlmetricfairnessPath) -> Int { s.size }

pub fn ml_metric_fairness_path_get(s : MlmetricfairnessPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_fairness_path_set(s : MlmetricfairnessPath, i : Int, v : Double) -> MlmetricfairnessPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_path_sum(s : MlmetricfairnessPath) -> Double { @_common.sum(s.data) }

pub fn ml_metric_fairness_path_mean(s : MlmetricfairnessPath) -> Double { @_common.mean(s.data) }

pub fn ml_metric_fairness_path_scale(s : MlmetricfairnessPath, f : Double) -> MlmetricfairnessPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_path_add(a : MlmetricfairnessPath, b : MlmetricfairnessPath) -> MlmetricfairnessPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_fairness_path_copy(s : MlmetricfairnessPath) -> MlmetricfairnessPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_path_fill(s : MlmetricfairnessPath, v : Double) -> MlmetricfairnessPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_path_min(s : MlmetricfairnessPath) -> Double { @_common.min(s.data) }

pub fn ml_metric_fairness_path_max(s : MlmetricfairnessPath) -> Double { @_common.max(s.data) }

pub fn ml_metric_fairness_path_to_string(s : MlmetricfairnessPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_cluster_make(size : Int) -> MlmetricfairnessCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_fairness_cluster_len(s : MlmetricfairnessCluster) -> Int { s.size }

pub fn ml_metric_fairness_cluster_get(s : MlmetricfairnessCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_fairness_cluster_set(s : MlmetricfairnessCluster, i : Int, v : Double) -> MlmetricfairnessCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_cluster_sum(s : MlmetricfairnessCluster) -> Double { @_common.sum(s.data) }

pub fn ml_metric_fairness_cluster_mean(s : MlmetricfairnessCluster) -> Double { @_common.mean(s.data) }

pub fn ml_metric_fairness_cluster_scale(s : MlmetricfairnessCluster, f : Double) -> MlmetricfairnessCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_cluster_add(a : MlmetricfairnessCluster, b : MlmetricfairnessCluster) -> MlmetricfairnessCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_fairness_cluster_copy(s : MlmetricfairnessCluster) -> MlmetricfairnessCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_cluster_fill(s : MlmetricfairnessCluster, v : Double) -> MlmetricfairnessCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_cluster_min(s : MlmetricfairnessCluster) -> Double { @_common.min(s.data) }

pub fn ml_metric_fairness_cluster_max(s : MlmetricfairnessCluster) -> Double { @_common.max(s.data) }

pub fn ml_metric_fairness_cluster_to_string(s : MlmetricfairnessCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_model_make(size : Int) -> MlmetricfairnessModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_fairness_model_len(s : MlmetricfairnessModel) -> Int { s.size }

pub fn ml_metric_fairness_model_get(s : MlmetricfairnessModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_fairness_model_set(s : MlmetricfairnessModel, i : Int, v : Double) -> MlmetricfairnessModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_model_sum(s : MlmetricfairnessModel) -> Double { @_common.sum(s.data) }

pub fn ml_metric_fairness_model_mean(s : MlmetricfairnessModel) -> Double { @_common.mean(s.data) }

pub fn ml_metric_fairness_model_scale(s : MlmetricfairnessModel, f : Double) -> MlmetricfairnessModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_model_add(a : MlmetricfairnessModel, b : MlmetricfairnessModel) -> MlmetricfairnessModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_fairness_model_copy(s : MlmetricfairnessModel) -> MlmetricfairnessModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_model_fill(s : MlmetricfairnessModel, v : Double) -> MlmetricfairnessModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_model_min(s : MlmetricfairnessModel) -> Double { @_common.min(s.data) }

pub fn ml_metric_fairness_model_max(s : MlmetricfairnessModel) -> Double { @_common.max(s.data) }

pub fn ml_metric_fairness_model_to_string(s : MlmetricfairnessModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_layer_make(size : Int) -> MlmetricfairnessLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_fairness_layer_len(s : MlmetricfairnessLayer) -> Int { s.size }

pub fn ml_metric_fairness_layer_get(s : MlmetricfairnessLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_fairness_layer_set(s : MlmetricfairnessLayer, i : Int, v : Double) -> MlmetricfairnessLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_layer_sum(s : MlmetricfairnessLayer) -> Double { @_common.sum(s.data) }

pub fn ml_metric_fairness_layer_mean(s : MlmetricfairnessLayer) -> Double { @_common.mean(s.data) }

pub fn ml_metric_fairness_layer_scale(s : MlmetricfairnessLayer, f : Double) -> MlmetricfairnessLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_layer_add(a : MlmetricfairnessLayer, b : MlmetricfairnessLayer) -> MlmetricfairnessLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_fairness_layer_copy(s : MlmetricfairnessLayer) -> MlmetricfairnessLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_layer_fill(s : MlmetricfairnessLayer, v : Double) -> MlmetricfairnessLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_layer_min(s : MlmetricfairnessLayer) -> Double { @_common.min(s.data) }

pub fn ml_metric_fairness_layer_max(s : MlmetricfairnessLayer) -> Double { @_common.max(s.data) }

pub fn ml_metric_fairness_layer_to_string(s : MlmetricfairnessLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_buffer_make(size : Int) -> MlmetricfairnessBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_fairness_buffer_len(s : MlmetricfairnessBuffer) -> Int { s.size }

pub fn ml_metric_fairness_buffer_get(s : MlmetricfairnessBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_fairness_buffer_set(s : MlmetricfairnessBuffer, i : Int, v : Double) -> MlmetricfairnessBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_buffer_sum(s : MlmetricfairnessBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_metric_fairness_buffer_mean(s : MlmetricfairnessBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_metric_fairness_buffer_scale(s : MlmetricfairnessBuffer, f : Double) -> MlmetricfairnessBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_buffer_add(a : MlmetricfairnessBuffer, b : MlmetricfairnessBuffer) -> MlmetricfairnessBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_fairness_buffer_copy(s : MlmetricfairnessBuffer) -> MlmetricfairnessBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_buffer_fill(s : MlmetricfairnessBuffer, v : Double) -> MlmetricfairnessBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_buffer_min(s : MlmetricfairnessBuffer) -> Double { @_common.min(s.data) }

pub fn ml_metric_fairness_buffer_max(s : MlmetricfairnessBuffer) -> Double { @_common.max(s.data) }

pub fn ml_metric_fairness_buffer_to_string(s : MlmetricfairnessBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_cursor_make(size : Int) -> MlmetricfairnessCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_fairness_cursor_len(s : MlmetricfairnessCursor) -> Int { s.size }

pub fn ml_metric_fairness_cursor_get(s : MlmetricfairnessCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_fairness_cursor_set(s : MlmetricfairnessCursor, i : Int, v : Double) -> MlmetricfairnessCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_cursor_sum(s : MlmetricfairnessCursor) -> Double { @_common.sum(s.data) }

pub fn ml_metric_fairness_cursor_mean(s : MlmetricfairnessCursor) -> Double { @_common.mean(s.data) }

pub fn ml_metric_fairness_cursor_scale(s : MlmetricfairnessCursor, f : Double) -> MlmetricfairnessCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_cursor_add(a : MlmetricfairnessCursor, b : MlmetricfairnessCursor) -> MlmetricfairnessCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_fairness_cursor_copy(s : MlmetricfairnessCursor) -> MlmetricfairnessCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_cursor_fill(s : MlmetricfairnessCursor, v : Double) -> MlmetricfairnessCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_cursor_min(s : MlmetricfairnessCursor) -> Double { @_common.min(s.data) }

pub fn ml_metric_fairness_cursor_max(s : MlmetricfairnessCursor) -> Double { @_common.max(s.data) }

pub fn ml_metric_fairness_cursor_to_string(s : MlmetricfairnessCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_view_make(size : Int) -> MlmetricfairnessView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_fairness_view_len(s : MlmetricfairnessView) -> Int { s.size }

pub fn ml_metric_fairness_view_get(s : MlmetricfairnessView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_fairness_view_set(s : MlmetricfairnessView, i : Int, v : Double) -> MlmetricfairnessView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_view_sum(s : MlmetricfairnessView) -> Double { @_common.sum(s.data) }

pub fn ml_metric_fairness_view_mean(s : MlmetricfairnessView) -> Double { @_common.mean(s.data) }

pub fn ml_metric_fairness_view_scale(s : MlmetricfairnessView, f : Double) -> MlmetricfairnessView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_view_add(a : MlmetricfairnessView, b : MlmetricfairnessView) -> MlmetricfairnessView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_fairness_view_copy(s : MlmetricfairnessView) -> MlmetricfairnessView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_view_fill(s : MlmetricfairnessView, v : Double) -> MlmetricfairnessView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_view_min(s : MlmetricfairnessView) -> Double { @_common.min(s.data) }

pub fn ml_metric_fairness_view_max(s : MlmetricfairnessView) -> Double { @_common.max(s.data) }

pub fn ml_metric_fairness_view_to_string(s : MlmetricfairnessView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_range_make(size : Int) -> MlmetricfairnessRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_fairness_range_len(s : MlmetricfairnessRange) -> Int { s.size }

pub fn ml_metric_fairness_range_get(s : MlmetricfairnessRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_fairness_range_set(s : MlmetricfairnessRange, i : Int, v : Double) -> MlmetricfairnessRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_range_sum(s : MlmetricfairnessRange) -> Double { @_common.sum(s.data) }

pub fn ml_metric_fairness_range_mean(s : MlmetricfairnessRange) -> Double { @_common.mean(s.data) }

pub fn ml_metric_fairness_range_scale(s : MlmetricfairnessRange, f : Double) -> MlmetricfairnessRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_range_add(a : MlmetricfairnessRange, b : MlmetricfairnessRange) -> MlmetricfairnessRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_fairness_range_copy(s : MlmetricfairnessRange) -> MlmetricfairnessRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_range_fill(s : MlmetricfairnessRange, v : Double) -> MlmetricfairnessRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_range_min(s : MlmetricfairnessRange) -> Double { @_common.min(s.data) }

pub fn ml_metric_fairness_range_max(s : MlmetricfairnessRange) -> Double { @_common.max(s.data) }

pub fn ml_metric_fairness_range_to_string(s : MlmetricfairnessRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricfairnessSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_fairness_slice_make(size : Int) -> MlmetricfairnessSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_fairness_slice_len(s : MlmetricfairnessSlice) -> Int { s.size }

pub fn ml_metric_fairness_slice_get(s : MlmetricfairnessSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_fairness_slice_set(s : MlmetricfairnessSlice, i : Int, v : Double) -> MlmetricfairnessSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_slice_sum(s : MlmetricfairnessSlice) -> Double { @_common.sum(s.data) }

pub fn ml_metric_fairness_slice_mean(s : MlmetricfairnessSlice) -> Double { @_common.mean(s.data) }

pub fn ml_metric_fairness_slice_scale(s : MlmetricfairnessSlice, f : Double) -> MlmetricfairnessSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_slice_add(a : MlmetricfairnessSlice, b : MlmetricfairnessSlice) -> MlmetricfairnessSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_fairness_slice_copy(s : MlmetricfairnessSlice) -> MlmetricfairnessSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_slice_fill(s : MlmetricfairnessSlice, v : Double) -> MlmetricfairnessSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_fairness_slice_min(s : MlmetricfairnessSlice) -> Double { @_common.min(s.data) }

pub fn ml_metric_fairness_slice_max(s : MlmetricfairnessSlice) -> Double { @_common.max(s.data) }

pub fn ml_metric_fairness_slice_to_string(s : MlmetricfairnessSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

