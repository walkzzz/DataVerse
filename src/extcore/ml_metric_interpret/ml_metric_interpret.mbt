///===
/// extcore/ml_metric_interpret

pub(all) struct MlmetricinterpretPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_interpret_make_point(x : Double, y : Double) -> MlmetricinterpretPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_interpret_make_point3(x : Double, y : Double, z : Double) -> MlmetricinterpretPoint {
  { x, y, z, label: 0 }
}

pub fn ml_metric_interpret_point_x(pt : MlmetricinterpretPoint) -> Double { pt.x }

pub fn ml_metric_interpret_point_y(pt : MlmetricinterpretPoint) -> Double { pt.y }

pub fn ml_metric_interpret_point_z(pt : MlmetricinterpretPoint) -> Double { pt.z }

pub fn ml_metric_interpret_point_label(pt : MlmetricinterpretPoint) -> Int { pt.label }

pub fn ml_metric_interpret_point_dist(a : MlmetricinterpretPoint, b : MlmetricinterpretPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_metric_interpret_point_add(a : MlmetricinterpretPoint, b : MlmetricinterpretPoint) -> MlmetricinterpretPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_metric_interpret_point_sub(a : MlmetricinterpretPoint, b : MlmetricinterpretPoint) -> MlmetricinterpretPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_metric_interpret_point_scale(pt : MlmetricinterpretPoint, s : Double) -> MlmetricinterpretPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_metric_interpret_point_dot(a : MlmetricinterpretPoint, b : MlmetricinterpretPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_metric_interpret_point_cross(a : MlmetricinterpretPoint, b : MlmetricinterpretPoint) -> MlmetricinterpretPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_metric_interpret_point_norm(pt : MlmetricinterpretPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_metric_interpret_point_normalize(pt : MlmetricinterpretPoint) -> MlmetricinterpretPoint {
  let n = ml_metric_interpret_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_metric_interpret_point_scale(pt, 1.0 / n) }
}

pub fn ml_metric_interpret_point_negate(pt : MlmetricinterpretPoint) -> MlmetricinterpretPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_metric_interpret_point_mid(a : MlmetricinterpretPoint, b : MlmetricinterpretPoint) -> MlmetricinterpretPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_metric_interpret_point_lerp(a : MlmetricinterpretPoint, b : MlmetricinterpretPoint, t : Double) -> MlmetricinterpretPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_metric_interpret_point_to_string(pt : MlmetricinterpretPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlmetricinterpretSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_interpret_make_series(vals : Array[Double], name : String) -> MlmetricinterpretSeries {
  { vals, name, meta: 0 }
}

pub fn ml_metric_interpret_series_len(s : MlmetricinterpretSeries) -> Int { s.vals.length() }

pub fn ml_metric_interpret_series_sum(s : MlmetricinterpretSeries) -> Double { @_common.sum(s.vals) }

pub fn ml_metric_interpret_series_mean(s : MlmetricinterpretSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_metric_interpret_series_min(s : MlmetricinterpretSeries) -> Double { @_common.min(s.vals) }

pub fn ml_metric_interpret_series_max(s : MlmetricinterpretSeries) -> Double { @_common.max(s.vals) }

pub fn ml_metric_interpret_series_range(s : MlmetricinterpretSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_metric_interpret_series_var(s : MlmetricinterpretSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_metric_interpret_series_std(s : MlmetricinterpretSeries) -> Double { @_common.std(s.vals) }

pub fn ml_metric_interpret_series_median(s : MlmetricinterpretSeries) -> Double { @_common.median(s.vals) }

pub fn ml_metric_interpret_series_scale(s : MlmetricinterpretSeries, f : Double) -> MlmetricinterpretSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_metric_interpret_series_add(a : MlmetricinterpretSeries, b : MlmetricinterpretSeries) -> MlmetricinterpretSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_metric_interpret_series_sub(a : MlmetricinterpretSeries, b : MlmetricinterpretSeries) -> MlmetricinterpretSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_metric_interpret_series_normalize(s : MlmetricinterpretSeries) -> MlmetricinterpretSeries {
  let mn = ml_metric_interpret_series_min(s)
  let mx = ml_metric_interpret_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_metric_interpret_series_cumsum(s : MlmetricinterpretSeries) -> MlmetricinterpretSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_metric_interpret_series_to_string(s : MlmetricinterpretSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricinterpretMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_interpret_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetricinterpretMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_interpret_matrix_identity(n : Int) -> MlmetricinterpretMatrix {
  let m = ml_metric_interpret_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_metric_interpret_matrix_get(m : MlmetricinterpretMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_metric_interpret_matrix_transpose(m : MlmetricinterpretMatrix) -> MlmetricinterpretMatrix {
  let result = ml_metric_interpret_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_metric_interpret_matrix_add(a : MlmetricinterpretMatrix, b : MlmetricinterpretMatrix) -> MlmetricinterpretMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_metric_interpret_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_metric_interpret_matrix_scale(m : MlmetricinterpretMatrix, s : Double) -> MlmetricinterpretMatrix {
  let result = ml_metric_interpret_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_metric_interpret_matrix_multiply(a : MlmetricinterpretMatrix, b : MlmetricinterpretMatrix) -> MlmetricinterpretMatrix {
  if a.cols != b.rows { return ml_metric_interpret_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_metric_interpret_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_metric_interpret_matrix_trace(m : MlmetricinterpretMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_metric_interpret_matrix_det(m : MlmetricinterpretMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_metric_interpret_matrix_norm(m : MlmetricinterpretMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_metric_interpret_matrix_to_string(m : MlmetricinterpretMatrix) -> String {
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

pub(all) struct MlmetricinterpretVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_interpret_make_vector(comps : Array[Double]) -> MlmetricinterpretVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_interpret_vector_zero(dim : Int) -> MlmetricinterpretVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_metric_interpret_vector_add(a : MlmetricinterpretVector, b : MlmetricinterpretVector) -> MlmetricinterpretVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_metric_interpret_vector_sub(a : MlmetricinterpretVector, b : MlmetricinterpretVector) -> MlmetricinterpretVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_metric_interpret_vector_scale(v : MlmetricinterpretVector, s : Double) -> MlmetricinterpretVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_metric_interpret_vector_dot(a : MlmetricinterpretVector, b : MlmetricinterpretVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_metric_interpret_vector_norm(v : MlmetricinterpretVector) -> Double { @_common.sqrt(ml_metric_interpret_vector_dot(v, v)) }

pub fn ml_metric_interpret_vector_normalize(v : MlmetricinterpretVector) -> MlmetricinterpretVector {
  let n = ml_metric_interpret_vector_norm(v)
  if n < 0.0000001 { v } else { ml_metric_interpret_vector_scale(v, 1.0 / n) }
}

pub fn ml_metric_interpret_vector_dist(a : MlmetricinterpretVector, b : MlmetricinterpretVector) -> Double {
  ml_metric_interpret_vector_norm(ml_metric_interpret_vector_sub(a, b))
}

pub fn ml_metric_interpret_vector_to_string(v : MlmetricinterpretVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_metric_interpret_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_metric_interpret_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_metric_interpret_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_metric_interpret_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_metric_interpret_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_metric_interpret_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_metric_interpret_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_metric_interpret_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_metric_interpret_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_metric_interpret_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_metric_interpret_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_metric_interpret_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_metric_interpret_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_metric_interpret_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_metric_interpret_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_metric_interpret_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_metric_interpret_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_metric_interpret_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_metric_interpret_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_metric_interpret_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_metric_interpret_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_metric_interpret_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_metric_interpret_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_metric_interpret_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_metric_interpret_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_metric_interpret_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_metric_interpret_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_metric_interpret_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_metric_interpret_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlmetricinterpretFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_frame_make(size : Int) -> MlmetricinterpretFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_frame_len(s : MlmetricinterpretFrame) -> Int { s.size }

pub fn ml_metric_interpret_frame_get(s : MlmetricinterpretFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_frame_set(s : MlmetricinterpretFrame, i : Int, v : Double) -> MlmetricinterpretFrame {
  let result = ml_metric_interpret_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_interpret_frame_sum(s : MlmetricinterpretFrame) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_frame_mean(s : MlmetricinterpretFrame) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_frame_scale(s : MlmetricinterpretFrame, f : Double) -> MlmetricinterpretFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_frame_add(a : MlmetricinterpretFrame, b : MlmetricinterpretFrame) -> MlmetricinterpretFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_frame_copy(s : MlmetricinterpretFrame) -> MlmetricinterpretFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_frame_fill(s : MlmetricinterpretFrame, v : Double) -> MlmetricinterpretFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_frame_min(s : MlmetricinterpretFrame) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_frame_max(s : MlmetricinterpretFrame) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_frame_to_string(s : MlmetricinterpretFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_table_make(size : Int) -> MlmetricinterpretTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_table_len(s : MlmetricinterpretTable) -> Int { s.size }

pub fn ml_metric_interpret_table_get(s : MlmetricinterpretTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_table_set(s : MlmetricinterpretTable, i : Int, v : Double) -> MlmetricinterpretTable {
  let result = ml_metric_interpret_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_interpret_table_sum(s : MlmetricinterpretTable) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_table_mean(s : MlmetricinterpretTable) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_table_scale(s : MlmetricinterpretTable, f : Double) -> MlmetricinterpretTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_table_add(a : MlmetricinterpretTable, b : MlmetricinterpretTable) -> MlmetricinterpretTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_table_copy(s : MlmetricinterpretTable) -> MlmetricinterpretTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_table_fill(s : MlmetricinterpretTable, v : Double) -> MlmetricinterpretTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_table_min(s : MlmetricinterpretTable) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_table_max(s : MlmetricinterpretTable) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_table_to_string(s : MlmetricinterpretTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_graphn_make(size : Int) -> MlmetricinterpretGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_graphn_len(s : MlmetricinterpretGraphN) -> Int { s.size }

pub fn ml_metric_interpret_graphn_get(s : MlmetricinterpretGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_graphn_set(s : MlmetricinterpretGraphN, i : Int, v : Double) -> MlmetricinterpretGraphN {
  let result = ml_metric_interpret_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_interpret_graphn_sum(s : MlmetricinterpretGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_graphn_mean(s : MlmetricinterpretGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_graphn_scale(s : MlmetricinterpretGraphN, f : Double) -> MlmetricinterpretGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_graphn_add(a : MlmetricinterpretGraphN, b : MlmetricinterpretGraphN) -> MlmetricinterpretGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_graphn_copy(s : MlmetricinterpretGraphN) -> MlmetricinterpretGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_graphn_fill(s : MlmetricinterpretGraphN, v : Double) -> MlmetricinterpretGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_graphn_min(s : MlmetricinterpretGraphN) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_graphn_max(s : MlmetricinterpretGraphN) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_graphn_to_string(s : MlmetricinterpretGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_node_make(size : Int) -> MlmetricinterpretNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_node_len(s : MlmetricinterpretNode) -> Int { s.size }

pub fn ml_metric_interpret_node_get(s : MlmetricinterpretNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_node_set(s : MlmetricinterpretNode, i : Int, v : Double) -> MlmetricinterpretNode {
  let result = ml_metric_interpret_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_interpret_node_sum(s : MlmetricinterpretNode) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_node_mean(s : MlmetricinterpretNode) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_node_scale(s : MlmetricinterpretNode, f : Double) -> MlmetricinterpretNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_node_add(a : MlmetricinterpretNode, b : MlmetricinterpretNode) -> MlmetricinterpretNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_node_copy(s : MlmetricinterpretNode) -> MlmetricinterpretNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_node_fill(s : MlmetricinterpretNode, v : Double) -> MlmetricinterpretNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_node_min(s : MlmetricinterpretNode) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_node_max(s : MlmetricinterpretNode) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_node_to_string(s : MlmetricinterpretNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_edge_make(size : Int) -> MlmetricinterpretEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_edge_len(s : MlmetricinterpretEdge) -> Int { s.size }

pub fn ml_metric_interpret_edge_get(s : MlmetricinterpretEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_edge_set(s : MlmetricinterpretEdge, i : Int, v : Double) -> MlmetricinterpretEdge {
  let result = ml_metric_interpret_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_interpret_edge_sum(s : MlmetricinterpretEdge) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_edge_mean(s : MlmetricinterpretEdge) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_edge_scale(s : MlmetricinterpretEdge, f : Double) -> MlmetricinterpretEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_edge_add(a : MlmetricinterpretEdge, b : MlmetricinterpretEdge) -> MlmetricinterpretEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_edge_copy(s : MlmetricinterpretEdge) -> MlmetricinterpretEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_edge_fill(s : MlmetricinterpretEdge, v : Double) -> MlmetricinterpretEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_edge_min(s : MlmetricinterpretEdge) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_edge_max(s : MlmetricinterpretEdge) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_edge_to_string(s : MlmetricinterpretEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_path_make(size : Int) -> MlmetricinterpretPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_path_len(s : MlmetricinterpretPath) -> Int { s.size }

pub fn ml_metric_interpret_path_get(s : MlmetricinterpretPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_path_set(s : MlmetricinterpretPath, i : Int, v : Double) -> MlmetricinterpretPath {
  let result = ml_metric_interpret_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_interpret_path_sum(s : MlmetricinterpretPath) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_path_mean(s : MlmetricinterpretPath) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_path_scale(s : MlmetricinterpretPath, f : Double) -> MlmetricinterpretPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_path_add(a : MlmetricinterpretPath, b : MlmetricinterpretPath) -> MlmetricinterpretPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_path_copy(s : MlmetricinterpretPath) -> MlmetricinterpretPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_path_fill(s : MlmetricinterpretPath, v : Double) -> MlmetricinterpretPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_path_min(s : MlmetricinterpretPath) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_path_max(s : MlmetricinterpretPath) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_path_to_string(s : MlmetricinterpretPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_cluster_make(size : Int) -> MlmetricinterpretCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_cluster_len(s : MlmetricinterpretCluster) -> Int { s.size }

pub fn ml_metric_interpret_cluster_get(s : MlmetricinterpretCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_cluster_set(s : MlmetricinterpretCluster, i : Int, v : Double) -> MlmetricinterpretCluster {
  let result = ml_metric_interpret_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_interpret_cluster_sum(s : MlmetricinterpretCluster) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_cluster_mean(s : MlmetricinterpretCluster) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_cluster_scale(s : MlmetricinterpretCluster, f : Double) -> MlmetricinterpretCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_cluster_add(a : MlmetricinterpretCluster, b : MlmetricinterpretCluster) -> MlmetricinterpretCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_cluster_copy(s : MlmetricinterpretCluster) -> MlmetricinterpretCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_cluster_fill(s : MlmetricinterpretCluster, v : Double) -> MlmetricinterpretCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_cluster_min(s : MlmetricinterpretCluster) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_cluster_max(s : MlmetricinterpretCluster) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_cluster_to_string(s : MlmetricinterpretCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_model_make(size : Int) -> MlmetricinterpretModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_model_len(s : MlmetricinterpretModel) -> Int { s.size }

pub fn ml_metric_interpret_model_get(s : MlmetricinterpretModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_model_set(s : MlmetricinterpretModel, i : Int, v : Double) -> MlmetricinterpretModel {
  let result = ml_metric_interpret_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_interpret_model_sum(s : MlmetricinterpretModel) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_model_mean(s : MlmetricinterpretModel) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_model_scale(s : MlmetricinterpretModel, f : Double) -> MlmetricinterpretModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_model_add(a : MlmetricinterpretModel, b : MlmetricinterpretModel) -> MlmetricinterpretModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_model_copy(s : MlmetricinterpretModel) -> MlmetricinterpretModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_model_fill(s : MlmetricinterpretModel, v : Double) -> MlmetricinterpretModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_model_min(s : MlmetricinterpretModel) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_model_max(s : MlmetricinterpretModel) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_model_to_string(s : MlmetricinterpretModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_layer_make(size : Int) -> MlmetricinterpretLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_layer_len(s : MlmetricinterpretLayer) -> Int { s.size }

pub fn ml_metric_interpret_layer_get(s : MlmetricinterpretLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_layer_set(s : MlmetricinterpretLayer, i : Int, v : Double) -> MlmetricinterpretLayer {
  let result = ml_metric_interpret_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_interpret_layer_sum(s : MlmetricinterpretLayer) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_layer_mean(s : MlmetricinterpretLayer) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_layer_scale(s : MlmetricinterpretLayer, f : Double) -> MlmetricinterpretLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_layer_add(a : MlmetricinterpretLayer, b : MlmetricinterpretLayer) -> MlmetricinterpretLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_layer_copy(s : MlmetricinterpretLayer) -> MlmetricinterpretLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_layer_fill(s : MlmetricinterpretLayer, v : Double) -> MlmetricinterpretLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_layer_min(s : MlmetricinterpretLayer) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_layer_max(s : MlmetricinterpretLayer) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_layer_to_string(s : MlmetricinterpretLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_buffer_make(size : Int) -> MlmetricinterpretBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_buffer_len(s : MlmetricinterpretBuffer) -> Int { s.size }

pub fn ml_metric_interpret_buffer_get(s : MlmetricinterpretBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_buffer_set(s : MlmetricinterpretBuffer, i : Int, v : Double) -> MlmetricinterpretBuffer {
  let result = ml_metric_interpret_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_interpret_buffer_sum(s : MlmetricinterpretBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_buffer_mean(s : MlmetricinterpretBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_buffer_scale(s : MlmetricinterpretBuffer, f : Double) -> MlmetricinterpretBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_buffer_add(a : MlmetricinterpretBuffer, b : MlmetricinterpretBuffer) -> MlmetricinterpretBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_buffer_copy(s : MlmetricinterpretBuffer) -> MlmetricinterpretBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_buffer_fill(s : MlmetricinterpretBuffer, v : Double) -> MlmetricinterpretBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_buffer_min(s : MlmetricinterpretBuffer) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_buffer_max(s : MlmetricinterpretBuffer) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_buffer_to_string(s : MlmetricinterpretBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_cursor_make(size : Int) -> MlmetricinterpretCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_cursor_len(s : MlmetricinterpretCursor) -> Int { s.size }

pub fn ml_metric_interpret_cursor_get(s : MlmetricinterpretCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_cursor_set(s : MlmetricinterpretCursor, i : Int, v : Double) -> MlmetricinterpretCursor {
  let result = ml_metric_interpret_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_interpret_cursor_sum(s : MlmetricinterpretCursor) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_cursor_mean(s : MlmetricinterpretCursor) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_cursor_scale(s : MlmetricinterpretCursor, f : Double) -> MlmetricinterpretCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_cursor_add(a : MlmetricinterpretCursor, b : MlmetricinterpretCursor) -> MlmetricinterpretCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_cursor_copy(s : MlmetricinterpretCursor) -> MlmetricinterpretCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_cursor_fill(s : MlmetricinterpretCursor, v : Double) -> MlmetricinterpretCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_cursor_min(s : MlmetricinterpretCursor) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_cursor_max(s : MlmetricinterpretCursor) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_cursor_to_string(s : MlmetricinterpretCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_view_make(size : Int) -> MlmetricinterpretView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_view_len(s : MlmetricinterpretView) -> Int { s.size }

pub fn ml_metric_interpret_view_get(s : MlmetricinterpretView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_view_set(s : MlmetricinterpretView, i : Int, v : Double) -> MlmetricinterpretView {
  let result = ml_metric_interpret_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_interpret_view_sum(s : MlmetricinterpretView) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_view_mean(s : MlmetricinterpretView) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_view_scale(s : MlmetricinterpretView, f : Double) -> MlmetricinterpretView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_view_add(a : MlmetricinterpretView, b : MlmetricinterpretView) -> MlmetricinterpretView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_view_copy(s : MlmetricinterpretView) -> MlmetricinterpretView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_view_fill(s : MlmetricinterpretView, v : Double) -> MlmetricinterpretView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_view_min(s : MlmetricinterpretView) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_view_max(s : MlmetricinterpretView) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_view_to_string(s : MlmetricinterpretView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_range_make(size : Int) -> MlmetricinterpretRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_range_len(s : MlmetricinterpretRange) -> Int { s.size }

pub fn ml_metric_interpret_range_get(s : MlmetricinterpretRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_range_set(s : MlmetricinterpretRange, i : Int, v : Double) -> MlmetricinterpretRange {
  let result = ml_metric_interpret_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_interpret_range_sum(s : MlmetricinterpretRange) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_range_mean(s : MlmetricinterpretRange) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_range_scale(s : MlmetricinterpretRange, f : Double) -> MlmetricinterpretRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_range_add(a : MlmetricinterpretRange, b : MlmetricinterpretRange) -> MlmetricinterpretRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_range_copy(s : MlmetricinterpretRange) -> MlmetricinterpretRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_range_fill(s : MlmetricinterpretRange, v : Double) -> MlmetricinterpretRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_range_min(s : MlmetricinterpretRange) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_range_max(s : MlmetricinterpretRange) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_range_to_string(s : MlmetricinterpretRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_slice_make(size : Int) -> MlmetricinterpretSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_slice_len(s : MlmetricinterpretSlice) -> Int { s.size }

pub fn ml_metric_interpret_slice_get(s : MlmetricinterpretSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_slice_set(s : MlmetricinterpretSlice, i : Int, v : Double) -> MlmetricinterpretSlice {
  let result = ml_metric_interpret_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_interpret_slice_sum(s : MlmetricinterpretSlice) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_slice_mean(s : MlmetricinterpretSlice) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_slice_scale(s : MlmetricinterpretSlice, f : Double) -> MlmetricinterpretSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_slice_add(a : MlmetricinterpretSlice, b : MlmetricinterpretSlice) -> MlmetricinterpretSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_slice_copy(s : MlmetricinterpretSlice) -> MlmetricinterpretSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_slice_fill(s : MlmetricinterpretSlice, v : Double) -> MlmetricinterpretSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_slice_min(s : MlmetricinterpretSlice) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_slice_max(s : MlmetricinterpretSlice) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_slice_to_string(s : MlmetricinterpretSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

