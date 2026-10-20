///===
/// extcore/ml_ensemble_adaboost

pub(all) struct MlensembleadaboostPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_adaboost_make_point(x : Double, y : Double) -> MlensembleadaboostPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_adaboost_make_point3(x : Double, y : Double, z : Double) -> MlensembleadaboostPoint {
  { x, y, z, label: 0 }
}

pub fn ml_ensemble_adaboost_point_x(pt : MlensembleadaboostPoint) -> Double { pt.x }

pub fn ml_ensemble_adaboost_point_y(pt : MlensembleadaboostPoint) -> Double { pt.y }

pub fn ml_ensemble_adaboost_point_z(pt : MlensembleadaboostPoint) -> Double { pt.z }

pub fn ml_ensemble_adaboost_point_label(pt : MlensembleadaboostPoint) -> Int { pt.label }

pub fn ml_ensemble_adaboost_point_dist(a : MlensembleadaboostPoint, b : MlensembleadaboostPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_ensemble_adaboost_point_add(a : MlensembleadaboostPoint, b : MlensembleadaboostPoint) -> MlensembleadaboostPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_ensemble_adaboost_point_sub(a : MlensembleadaboostPoint, b : MlensembleadaboostPoint) -> MlensembleadaboostPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_ensemble_adaboost_point_scale(pt : MlensembleadaboostPoint, s : Double) -> MlensembleadaboostPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_ensemble_adaboost_point_dot(a : MlensembleadaboostPoint, b : MlensembleadaboostPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_ensemble_adaboost_point_cross(a : MlensembleadaboostPoint, b : MlensembleadaboostPoint) -> MlensembleadaboostPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_ensemble_adaboost_point_norm(pt : MlensembleadaboostPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_ensemble_adaboost_point_normalize(pt : MlensembleadaboostPoint) -> MlensembleadaboostPoint {
  let n = ml_ensemble_adaboost_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_ensemble_adaboost_point_scale(pt, 1.0 / n) }
}

pub fn ml_ensemble_adaboost_point_negate(pt : MlensembleadaboostPoint) -> MlensembleadaboostPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_ensemble_adaboost_point_mid(a : MlensembleadaboostPoint, b : MlensembleadaboostPoint) -> MlensembleadaboostPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_ensemble_adaboost_point_lerp(a : MlensembleadaboostPoint, b : MlensembleadaboostPoint, t : Double) -> MlensembleadaboostPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_ensemble_adaboost_point_to_string(pt : MlensembleadaboostPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlensembleadaboostSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_adaboost_make_series(vals : Array[Double], name : String) -> MlensembleadaboostSeries {
  { vals, name, meta: 0 }
}

pub fn ml_ensemble_adaboost_series_len(s : MlensembleadaboostSeries) -> Int { s.vals.length() }

pub fn ml_ensemble_adaboost_series_sum(s : MlensembleadaboostSeries) -> Double { @_common.sum(s.vals) }

pub fn ml_ensemble_adaboost_series_mean(s : MlensembleadaboostSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_ensemble_adaboost_series_min(s : MlensembleadaboostSeries) -> Double { @_common.min(s.vals) }

pub fn ml_ensemble_adaboost_series_max(s : MlensembleadaboostSeries) -> Double { @_common.max(s.vals) }

pub fn ml_ensemble_adaboost_series_range(s : MlensembleadaboostSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_ensemble_adaboost_series_var(s : MlensembleadaboostSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_ensemble_adaboost_series_std(s : MlensembleadaboostSeries) -> Double { @_common.std(s.vals) }

pub fn ml_ensemble_adaboost_series_median(s : MlensembleadaboostSeries) -> Double { @_common.median(s.vals) }

pub fn ml_ensemble_adaboost_series_scale(s : MlensembleadaboostSeries, f : Double) -> MlensembleadaboostSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn ml_ensemble_adaboost_series_add(a : MlensembleadaboostSeries, b : MlensembleadaboostSeries) -> MlensembleadaboostSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_ensemble_adaboost_series_sub(a : MlensembleadaboostSeries, b : MlensembleadaboostSeries) -> MlensembleadaboostSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_ensemble_adaboost_series_normalize(s : MlensembleadaboostSeries) -> MlensembleadaboostSeries {
  let mn = ml_ensemble_adaboost_series_min(s)
  let mx = ml_ensemble_adaboost_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_ensemble_adaboost_series_cumsum(s : MlensembleadaboostSeries) -> MlensembleadaboostSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_ensemble_adaboost_series_to_string(s : MlensembleadaboostSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensembleadaboostMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_adaboost_make_matrix(rows : Int, cols : Int, val : Double) -> MlensembleadaboostMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_ensemble_adaboost_matrix_identity(n : Int) -> MlensembleadaboostMatrix {
  let m = ml_ensemble_adaboost_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_ensemble_adaboost_matrix_get(m : MlensembleadaboostMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_ensemble_adaboost_matrix_transpose(m : MlensembleadaboostMatrix) -> MlensembleadaboostMatrix {
  let result = ml_ensemble_adaboost_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_ensemble_adaboost_matrix_add(a : MlensembleadaboostMatrix, b : MlensembleadaboostMatrix) -> MlensembleadaboostMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_ensemble_adaboost_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_ensemble_adaboost_matrix_scale(m : MlensembleadaboostMatrix, s : Double) -> MlensembleadaboostMatrix {
  let result = ml_ensemble_adaboost_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_ensemble_adaboost_matrix_multiply(a : MlensembleadaboostMatrix, b : MlensembleadaboostMatrix) -> MlensembleadaboostMatrix {
  if a.cols != b.rows { return ml_ensemble_adaboost_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_ensemble_adaboost_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_ensemble_adaboost_matrix_trace(m : MlensembleadaboostMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_ensemble_adaboost_matrix_det(m : MlensembleadaboostMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_ensemble_adaboost_matrix_norm(m : MlensembleadaboostMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_ensemble_adaboost_matrix_to_string(m : MlensembleadaboostMatrix) -> String {
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

pub(all) struct MlensembleadaboostVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_adaboost_make_vector(comps : Array[Double]) -> MlensembleadaboostVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_adaboost_vector_zero(dim : Int) -> MlensembleadaboostVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_ensemble_adaboost_vector_add(a : MlensembleadaboostVector, b : MlensembleadaboostVector) -> MlensembleadaboostVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn ml_ensemble_adaboost_vector_sub(a : MlensembleadaboostVector, b : MlensembleadaboostVector) -> MlensembleadaboostVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn ml_ensemble_adaboost_vector_scale(v : MlensembleadaboostVector, s : Double) -> MlensembleadaboostVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn ml_ensemble_adaboost_vector_dot(a : MlensembleadaboostVector, b : MlensembleadaboostVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_ensemble_adaboost_vector_norm(v : MlensembleadaboostVector) -> Double { @_common.sqrt(ml_ensemble_adaboost_vector_dot(v, v)) }

pub fn ml_ensemble_adaboost_vector_normalize(v : MlensembleadaboostVector) -> MlensembleadaboostVector {
  let n = ml_ensemble_adaboost_vector_norm(v)
  if n < 0.0000001 { v } else { ml_ensemble_adaboost_vector_scale(v, 1.0 / n) }
}

pub fn ml_ensemble_adaboost_vector_dist(a : MlensembleadaboostVector, b : MlensembleadaboostVector) -> Double {
  ml_ensemble_adaboost_vector_norm(ml_ensemble_adaboost_vector_sub(a, b))
}

pub fn ml_ensemble_adaboost_vector_to_string(v : MlensembleadaboostVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_ensemble_adaboost_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_ensemble_adaboost_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_ensemble_adaboost_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_ensemble_adaboost_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_ensemble_adaboost_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_ensemble_adaboost_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_ensemble_adaboost_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_ensemble_adaboost_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_ensemble_adaboost_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_ensemble_adaboost_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_ensemble_adaboost_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_ensemble_adaboost_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_ensemble_adaboost_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_ensemble_adaboost_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_ensemble_adaboost_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_ensemble_adaboost_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_ensemble_adaboost_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_ensemble_adaboost_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_ensemble_adaboost_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_ensemble_adaboost_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_ensemble_adaboost_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_ensemble_adaboost_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_ensemble_adaboost_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_ensemble_adaboost_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_ensemble_adaboost_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_ensemble_adaboost_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_ensemble_adaboost_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_ensemble_adaboost_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_ensemble_adaboost_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlensembleadaboostFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_frame_make(size : Int) -> MlensembleadaboostFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_frame_len(s : MlensembleadaboostFrame) -> Int { s.size }

pub fn ml_ensemble_adaboost_frame_get(s : MlensembleadaboostFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_frame_set(s : MlensembleadaboostFrame, i : Int, v : Double) -> MlensembleadaboostFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_frame_sum(s : MlensembleadaboostFrame) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_frame_mean(s : MlensembleadaboostFrame) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_frame_scale(s : MlensembleadaboostFrame, f : Double) -> MlensembleadaboostFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_frame_add(a : MlensembleadaboostFrame, b : MlensembleadaboostFrame) -> MlensembleadaboostFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_frame_copy(s : MlensembleadaboostFrame) -> MlensembleadaboostFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_frame_fill(s : MlensembleadaboostFrame, v : Double) -> MlensembleadaboostFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_frame_min(s : MlensembleadaboostFrame) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_frame_max(s : MlensembleadaboostFrame) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_frame_to_string(s : MlensembleadaboostFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_table_make(size : Int) -> MlensembleadaboostTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_table_len(s : MlensembleadaboostTable) -> Int { s.size }

pub fn ml_ensemble_adaboost_table_get(s : MlensembleadaboostTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_table_set(s : MlensembleadaboostTable, i : Int, v : Double) -> MlensembleadaboostTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_table_sum(s : MlensembleadaboostTable) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_table_mean(s : MlensembleadaboostTable) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_table_scale(s : MlensembleadaboostTable, f : Double) -> MlensembleadaboostTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_table_add(a : MlensembleadaboostTable, b : MlensembleadaboostTable) -> MlensembleadaboostTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_table_copy(s : MlensembleadaboostTable) -> MlensembleadaboostTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_table_fill(s : MlensembleadaboostTable, v : Double) -> MlensembleadaboostTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_table_min(s : MlensembleadaboostTable) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_table_max(s : MlensembleadaboostTable) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_table_to_string(s : MlensembleadaboostTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_graphn_make(size : Int) -> MlensembleadaboostGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_graphn_len(s : MlensembleadaboostGraphN) -> Int { s.size }

pub fn ml_ensemble_adaboost_graphn_get(s : MlensembleadaboostGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_graphn_set(s : MlensembleadaboostGraphN, i : Int, v : Double) -> MlensembleadaboostGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_graphn_sum(s : MlensembleadaboostGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_graphn_mean(s : MlensembleadaboostGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_graphn_scale(s : MlensembleadaboostGraphN, f : Double) -> MlensembleadaboostGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_graphn_add(a : MlensembleadaboostGraphN, b : MlensembleadaboostGraphN) -> MlensembleadaboostGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_graphn_copy(s : MlensembleadaboostGraphN) -> MlensembleadaboostGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_graphn_fill(s : MlensembleadaboostGraphN, v : Double) -> MlensembleadaboostGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_graphn_min(s : MlensembleadaboostGraphN) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_graphn_max(s : MlensembleadaboostGraphN) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_graphn_to_string(s : MlensembleadaboostGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_node_make(size : Int) -> MlensembleadaboostNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_node_len(s : MlensembleadaboostNode) -> Int { s.size }

pub fn ml_ensemble_adaboost_node_get(s : MlensembleadaboostNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_node_set(s : MlensembleadaboostNode, i : Int, v : Double) -> MlensembleadaboostNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_node_sum(s : MlensembleadaboostNode) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_node_mean(s : MlensembleadaboostNode) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_node_scale(s : MlensembleadaboostNode, f : Double) -> MlensembleadaboostNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_node_add(a : MlensembleadaboostNode, b : MlensembleadaboostNode) -> MlensembleadaboostNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_node_copy(s : MlensembleadaboostNode) -> MlensembleadaboostNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_node_fill(s : MlensembleadaboostNode, v : Double) -> MlensembleadaboostNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_node_min(s : MlensembleadaboostNode) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_node_max(s : MlensembleadaboostNode) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_node_to_string(s : MlensembleadaboostNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_edge_make(size : Int) -> MlensembleadaboostEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_edge_len(s : MlensembleadaboostEdge) -> Int { s.size }

pub fn ml_ensemble_adaboost_edge_get(s : MlensembleadaboostEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_edge_set(s : MlensembleadaboostEdge, i : Int, v : Double) -> MlensembleadaboostEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_edge_sum(s : MlensembleadaboostEdge) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_edge_mean(s : MlensembleadaboostEdge) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_edge_scale(s : MlensembleadaboostEdge, f : Double) -> MlensembleadaboostEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_edge_add(a : MlensembleadaboostEdge, b : MlensembleadaboostEdge) -> MlensembleadaboostEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_edge_copy(s : MlensembleadaboostEdge) -> MlensembleadaboostEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_edge_fill(s : MlensembleadaboostEdge, v : Double) -> MlensembleadaboostEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_edge_min(s : MlensembleadaboostEdge) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_edge_max(s : MlensembleadaboostEdge) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_edge_to_string(s : MlensembleadaboostEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_path_make(size : Int) -> MlensembleadaboostPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_path_len(s : MlensembleadaboostPath) -> Int { s.size }

pub fn ml_ensemble_adaboost_path_get(s : MlensembleadaboostPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_path_set(s : MlensembleadaboostPath, i : Int, v : Double) -> MlensembleadaboostPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_path_sum(s : MlensembleadaboostPath) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_path_mean(s : MlensembleadaboostPath) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_path_scale(s : MlensembleadaboostPath, f : Double) -> MlensembleadaboostPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_path_add(a : MlensembleadaboostPath, b : MlensembleadaboostPath) -> MlensembleadaboostPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_path_copy(s : MlensembleadaboostPath) -> MlensembleadaboostPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_path_fill(s : MlensembleadaboostPath, v : Double) -> MlensembleadaboostPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_path_min(s : MlensembleadaboostPath) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_path_max(s : MlensembleadaboostPath) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_path_to_string(s : MlensembleadaboostPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_cluster_make(size : Int) -> MlensembleadaboostCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_cluster_len(s : MlensembleadaboostCluster) -> Int { s.size }

pub fn ml_ensemble_adaboost_cluster_get(s : MlensembleadaboostCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_cluster_set(s : MlensembleadaboostCluster, i : Int, v : Double) -> MlensembleadaboostCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_cluster_sum(s : MlensembleadaboostCluster) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_cluster_mean(s : MlensembleadaboostCluster) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_cluster_scale(s : MlensembleadaboostCluster, f : Double) -> MlensembleadaboostCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_cluster_add(a : MlensembleadaboostCluster, b : MlensembleadaboostCluster) -> MlensembleadaboostCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_cluster_copy(s : MlensembleadaboostCluster) -> MlensembleadaboostCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_cluster_fill(s : MlensembleadaboostCluster, v : Double) -> MlensembleadaboostCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_cluster_min(s : MlensembleadaboostCluster) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_cluster_max(s : MlensembleadaboostCluster) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_cluster_to_string(s : MlensembleadaboostCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_model_make(size : Int) -> MlensembleadaboostModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_model_len(s : MlensembleadaboostModel) -> Int { s.size }

pub fn ml_ensemble_adaboost_model_get(s : MlensembleadaboostModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_model_set(s : MlensembleadaboostModel, i : Int, v : Double) -> MlensembleadaboostModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_model_sum(s : MlensembleadaboostModel) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_model_mean(s : MlensembleadaboostModel) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_model_scale(s : MlensembleadaboostModel, f : Double) -> MlensembleadaboostModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_model_add(a : MlensembleadaboostModel, b : MlensembleadaboostModel) -> MlensembleadaboostModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_model_copy(s : MlensembleadaboostModel) -> MlensembleadaboostModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_model_fill(s : MlensembleadaboostModel, v : Double) -> MlensembleadaboostModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_model_min(s : MlensembleadaboostModel) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_model_max(s : MlensembleadaboostModel) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_model_to_string(s : MlensembleadaboostModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_layer_make(size : Int) -> MlensembleadaboostLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_layer_len(s : MlensembleadaboostLayer) -> Int { s.size }

pub fn ml_ensemble_adaboost_layer_get(s : MlensembleadaboostLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_layer_set(s : MlensembleadaboostLayer, i : Int, v : Double) -> MlensembleadaboostLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_layer_sum(s : MlensembleadaboostLayer) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_layer_mean(s : MlensembleadaboostLayer) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_layer_scale(s : MlensembleadaboostLayer, f : Double) -> MlensembleadaboostLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_layer_add(a : MlensembleadaboostLayer, b : MlensembleadaboostLayer) -> MlensembleadaboostLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_layer_copy(s : MlensembleadaboostLayer) -> MlensembleadaboostLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_layer_fill(s : MlensembleadaboostLayer, v : Double) -> MlensembleadaboostLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_layer_min(s : MlensembleadaboostLayer) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_layer_max(s : MlensembleadaboostLayer) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_layer_to_string(s : MlensembleadaboostLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_buffer_make(size : Int) -> MlensembleadaboostBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_buffer_len(s : MlensembleadaboostBuffer) -> Int { s.size }

pub fn ml_ensemble_adaboost_buffer_get(s : MlensembleadaboostBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_buffer_set(s : MlensembleadaboostBuffer, i : Int, v : Double) -> MlensembleadaboostBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_buffer_sum(s : MlensembleadaboostBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_buffer_mean(s : MlensembleadaboostBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_buffer_scale(s : MlensembleadaboostBuffer, f : Double) -> MlensembleadaboostBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_buffer_add(a : MlensembleadaboostBuffer, b : MlensembleadaboostBuffer) -> MlensembleadaboostBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_buffer_copy(s : MlensembleadaboostBuffer) -> MlensembleadaboostBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_buffer_fill(s : MlensembleadaboostBuffer, v : Double) -> MlensembleadaboostBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_buffer_min(s : MlensembleadaboostBuffer) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_buffer_max(s : MlensembleadaboostBuffer) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_buffer_to_string(s : MlensembleadaboostBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_cursor_make(size : Int) -> MlensembleadaboostCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_cursor_len(s : MlensembleadaboostCursor) -> Int { s.size }

pub fn ml_ensemble_adaboost_cursor_get(s : MlensembleadaboostCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_cursor_set(s : MlensembleadaboostCursor, i : Int, v : Double) -> MlensembleadaboostCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_cursor_sum(s : MlensembleadaboostCursor) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_cursor_mean(s : MlensembleadaboostCursor) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_cursor_scale(s : MlensembleadaboostCursor, f : Double) -> MlensembleadaboostCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_cursor_add(a : MlensembleadaboostCursor, b : MlensembleadaboostCursor) -> MlensembleadaboostCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_cursor_copy(s : MlensembleadaboostCursor) -> MlensembleadaboostCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_cursor_fill(s : MlensembleadaboostCursor, v : Double) -> MlensembleadaboostCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_cursor_min(s : MlensembleadaboostCursor) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_cursor_max(s : MlensembleadaboostCursor) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_cursor_to_string(s : MlensembleadaboostCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_view_make(size : Int) -> MlensembleadaboostView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_view_len(s : MlensembleadaboostView) -> Int { s.size }

pub fn ml_ensemble_adaboost_view_get(s : MlensembleadaboostView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_view_set(s : MlensembleadaboostView, i : Int, v : Double) -> MlensembleadaboostView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_view_sum(s : MlensembleadaboostView) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_view_mean(s : MlensembleadaboostView) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_view_scale(s : MlensembleadaboostView, f : Double) -> MlensembleadaboostView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_view_add(a : MlensembleadaboostView, b : MlensembleadaboostView) -> MlensembleadaboostView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_view_copy(s : MlensembleadaboostView) -> MlensembleadaboostView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_view_fill(s : MlensembleadaboostView, v : Double) -> MlensembleadaboostView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_view_min(s : MlensembleadaboostView) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_view_max(s : MlensembleadaboostView) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_view_to_string(s : MlensembleadaboostView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_range_make(size : Int) -> MlensembleadaboostRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_range_len(s : MlensembleadaboostRange) -> Int { s.size }

pub fn ml_ensemble_adaboost_range_get(s : MlensembleadaboostRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_range_set(s : MlensembleadaboostRange, i : Int, v : Double) -> MlensembleadaboostRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_range_sum(s : MlensembleadaboostRange) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_range_mean(s : MlensembleadaboostRange) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_range_scale(s : MlensembleadaboostRange, f : Double) -> MlensembleadaboostRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_range_add(a : MlensembleadaboostRange, b : MlensembleadaboostRange) -> MlensembleadaboostRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_range_copy(s : MlensembleadaboostRange) -> MlensembleadaboostRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_range_fill(s : MlensembleadaboostRange, v : Double) -> MlensembleadaboostRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_range_min(s : MlensembleadaboostRange) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_range_max(s : MlensembleadaboostRange) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_range_to_string(s : MlensembleadaboostRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_slice_make(size : Int) -> MlensembleadaboostSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_slice_len(s : MlensembleadaboostSlice) -> Int { s.size }

pub fn ml_ensemble_adaboost_slice_get(s : MlensembleadaboostSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_slice_set(s : MlensembleadaboostSlice, i : Int, v : Double) -> MlensembleadaboostSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_slice_sum(s : MlensembleadaboostSlice) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_slice_mean(s : MlensembleadaboostSlice) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_slice_scale(s : MlensembleadaboostSlice, f : Double) -> MlensembleadaboostSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_slice_add(a : MlensembleadaboostSlice, b : MlensembleadaboostSlice) -> MlensembleadaboostSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_slice_copy(s : MlensembleadaboostSlice) -> MlensembleadaboostSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_slice_fill(s : MlensembleadaboostSlice, v : Double) -> MlensembleadaboostSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_slice_min(s : MlensembleadaboostSlice) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_slice_max(s : MlensembleadaboostSlice) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_slice_to_string(s : MlensembleadaboostSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

