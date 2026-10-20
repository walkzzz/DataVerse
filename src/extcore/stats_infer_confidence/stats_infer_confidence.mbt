///===
/// extcore/stats_infer_confidence

pub(all) struct StatsinferconfidencePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_infer_confidence_make_point(x : Double, y : Double) -> StatsinferconfidencePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_infer_confidence_make_point3(x : Double, y : Double, z : Double) -> StatsinferconfidencePoint {
  { x, y, z, label: 0 }
}

pub fn stats_infer_confidence_point_x(pt : StatsinferconfidencePoint) -> Double { pt.x }

pub fn stats_infer_confidence_point_y(pt : StatsinferconfidencePoint) -> Double { pt.y }

pub fn stats_infer_confidence_point_z(pt : StatsinferconfidencePoint) -> Double { pt.z }

pub fn stats_infer_confidence_point_label(pt : StatsinferconfidencePoint) -> Int { pt.label }

pub fn stats_infer_confidence_point_dist(a : StatsinferconfidencePoint, b : StatsinferconfidencePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_infer_confidence_point_add(a : StatsinferconfidencePoint, b : StatsinferconfidencePoint) -> StatsinferconfidencePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_infer_confidence_point_sub(a : StatsinferconfidencePoint, b : StatsinferconfidencePoint) -> StatsinferconfidencePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_infer_confidence_point_scale(pt : StatsinferconfidencePoint, s : Double) -> StatsinferconfidencePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_infer_confidence_point_dot(a : StatsinferconfidencePoint, b : StatsinferconfidencePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_infer_confidence_point_cross(a : StatsinferconfidencePoint, b : StatsinferconfidencePoint) -> StatsinferconfidencePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_infer_confidence_point_norm(pt : StatsinferconfidencePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_infer_confidence_point_normalize(pt : StatsinferconfidencePoint) -> StatsinferconfidencePoint {
  let n = stats_infer_confidence_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_infer_confidence_point_scale(pt, 1.0 / n) }
}

pub fn stats_infer_confidence_point_negate(pt : StatsinferconfidencePoint) -> StatsinferconfidencePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_infer_confidence_point_mid(a : StatsinferconfidencePoint, b : StatsinferconfidencePoint) -> StatsinferconfidencePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_infer_confidence_point_lerp(a : StatsinferconfidencePoint, b : StatsinferconfidencePoint, t : Double) -> StatsinferconfidencePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_infer_confidence_point_to_string(pt : StatsinferconfidencePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsinferconfidenceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_infer_confidence_make_series(vals : Array[Double], name : String) -> StatsinferconfidenceSeries {
  { vals, name, meta: 0 }
}

pub fn stats_infer_confidence_series_len(s : StatsinferconfidenceSeries) -> Int { s.vals.length() }

pub fn stats_infer_confidence_series_sum(s : StatsinferconfidenceSeries) -> Double { @_common.sum(s.vals) }

pub fn stats_infer_confidence_series_mean(s : StatsinferconfidenceSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_infer_confidence_series_min(s : StatsinferconfidenceSeries) -> Double { @_common.min(s.vals) }

pub fn stats_infer_confidence_series_max(s : StatsinferconfidenceSeries) -> Double { @_common.max(s.vals) }

pub fn stats_infer_confidence_series_range(s : StatsinferconfidenceSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_infer_confidence_series_var(s : StatsinferconfidenceSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_infer_confidence_series_std(s : StatsinferconfidenceSeries) -> Double { @_common.std(s.vals) }

pub fn stats_infer_confidence_series_median(s : StatsinferconfidenceSeries) -> Double { @_common.median(s.vals) }

pub fn stats_infer_confidence_series_scale(s : StatsinferconfidenceSeries, f : Double) -> StatsinferconfidenceSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_infer_confidence_series_add(a : StatsinferconfidenceSeries, b : StatsinferconfidenceSeries) -> StatsinferconfidenceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_infer_confidence_series_sub(a : StatsinferconfidenceSeries, b : StatsinferconfidenceSeries) -> StatsinferconfidenceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_infer_confidence_series_normalize(s : StatsinferconfidenceSeries) -> StatsinferconfidenceSeries {
  let mn = stats_infer_confidence_series_min(s)
  let mx = stats_infer_confidence_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_infer_confidence_series_cumsum(s : StatsinferconfidenceSeries) -> StatsinferconfidenceSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_infer_confidence_series_to_string(s : StatsinferconfidenceSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsinferconfidenceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_infer_confidence_make_matrix(rows : Int, cols : Int, val : Double) -> StatsinferconfidenceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_infer_confidence_matrix_identity(n : Int) -> StatsinferconfidenceMatrix {
  let m = stats_infer_confidence_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_infer_confidence_matrix_get(m : StatsinferconfidenceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_infer_confidence_matrix_transpose(m : StatsinferconfidenceMatrix) -> StatsinferconfidenceMatrix {
  let result = stats_infer_confidence_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_infer_confidence_matrix_add(a : StatsinferconfidenceMatrix, b : StatsinferconfidenceMatrix) -> StatsinferconfidenceMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_infer_confidence_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_infer_confidence_matrix_scale(m : StatsinferconfidenceMatrix, s : Double) -> StatsinferconfidenceMatrix {
  let result = stats_infer_confidence_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_infer_confidence_matrix_multiply(a : StatsinferconfidenceMatrix, b : StatsinferconfidenceMatrix) -> StatsinferconfidenceMatrix {
  if a.cols != b.rows { return stats_infer_confidence_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_infer_confidence_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_infer_confidence_matrix_trace(m : StatsinferconfidenceMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_infer_confidence_matrix_det(m : StatsinferconfidenceMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_infer_confidence_matrix_norm(m : StatsinferconfidenceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_infer_confidence_matrix_to_string(m : StatsinferconfidenceMatrix) -> String {
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

pub(all) struct StatsinferconfidenceVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_infer_confidence_make_vector(comps : Array[Double]) -> StatsinferconfidenceVector {
  { comps, dim: comps.length() }
}

pub fn stats_infer_confidence_vector_zero(dim : Int) -> StatsinferconfidenceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_infer_confidence_vector_add(a : StatsinferconfidenceVector, b : StatsinferconfidenceVector) -> StatsinferconfidenceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_infer_confidence_vector_sub(a : StatsinferconfidenceVector, b : StatsinferconfidenceVector) -> StatsinferconfidenceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_infer_confidence_vector_scale(v : StatsinferconfidenceVector, s : Double) -> StatsinferconfidenceVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_infer_confidence_vector_dot(a : StatsinferconfidenceVector, b : StatsinferconfidenceVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_infer_confidence_vector_norm(v : StatsinferconfidenceVector) -> Double { @_common.sqrt(stats_infer_confidence_vector_dot(v, v)) }

pub fn stats_infer_confidence_vector_normalize(v : StatsinferconfidenceVector) -> StatsinferconfidenceVector {
  let n = stats_infer_confidence_vector_norm(v)
  if n < 0.0000001 { v } else { stats_infer_confidence_vector_scale(v, 1.0 / n) }
}

pub fn stats_infer_confidence_vector_dist(a : StatsinferconfidenceVector, b : StatsinferconfidenceVector) -> Double {
  stats_infer_confidence_vector_norm(stats_infer_confidence_vector_sub(a, b))
}

pub fn stats_infer_confidence_vector_to_string(v : StatsinferconfidenceVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_infer_confidence_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_infer_confidence_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_infer_confidence_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_infer_confidence_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_infer_confidence_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_infer_confidence_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_infer_confidence_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_infer_confidence_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_infer_confidence_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_infer_confidence_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_infer_confidence_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_infer_confidence_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_infer_confidence_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_infer_confidence_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_infer_confidence_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_infer_confidence_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_infer_confidence_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_infer_confidence_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_infer_confidence_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_infer_confidence_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_infer_confidence_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_infer_confidence_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_infer_confidence_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_infer_confidence_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_infer_confidence_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_infer_confidence_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_infer_confidence_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_infer_confidence_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_infer_confidence_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsinferconfidenceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_frame_make(size : Int) -> StatsinferconfidenceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_frame_len(s : StatsinferconfidenceFrame) -> Int { s.size }

pub fn stats_infer_confidence_frame_get(s : StatsinferconfidenceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_frame_set(s : StatsinferconfidenceFrame, i : Int, v : Double) -> StatsinferconfidenceFrame {
  let result = stats_infer_confidence_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_confidence_frame_sum(s : StatsinferconfidenceFrame) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_frame_mean(s : StatsinferconfidenceFrame) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_frame_scale(s : StatsinferconfidenceFrame, f : Double) -> StatsinferconfidenceFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_frame_add(a : StatsinferconfidenceFrame, b : StatsinferconfidenceFrame) -> StatsinferconfidenceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_frame_copy(s : StatsinferconfidenceFrame) -> StatsinferconfidenceFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_frame_fill(s : StatsinferconfidenceFrame, v : Double) -> StatsinferconfidenceFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_frame_min(s : StatsinferconfidenceFrame) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_frame_max(s : StatsinferconfidenceFrame) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_frame_to_string(s : StatsinferconfidenceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_table_make(size : Int) -> StatsinferconfidenceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_table_len(s : StatsinferconfidenceTable) -> Int { s.size }

pub fn stats_infer_confidence_table_get(s : StatsinferconfidenceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_table_set(s : StatsinferconfidenceTable, i : Int, v : Double) -> StatsinferconfidenceTable {
  let result = stats_infer_confidence_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_confidence_table_sum(s : StatsinferconfidenceTable) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_table_mean(s : StatsinferconfidenceTable) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_table_scale(s : StatsinferconfidenceTable, f : Double) -> StatsinferconfidenceTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_table_add(a : StatsinferconfidenceTable, b : StatsinferconfidenceTable) -> StatsinferconfidenceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_table_copy(s : StatsinferconfidenceTable) -> StatsinferconfidenceTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_table_fill(s : StatsinferconfidenceTable, v : Double) -> StatsinferconfidenceTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_table_min(s : StatsinferconfidenceTable) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_table_max(s : StatsinferconfidenceTable) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_table_to_string(s : StatsinferconfidenceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_graphn_make(size : Int) -> StatsinferconfidenceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_graphn_len(s : StatsinferconfidenceGraphN) -> Int { s.size }

pub fn stats_infer_confidence_graphn_get(s : StatsinferconfidenceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_graphn_set(s : StatsinferconfidenceGraphN, i : Int, v : Double) -> StatsinferconfidenceGraphN {
  let result = stats_infer_confidence_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_confidence_graphn_sum(s : StatsinferconfidenceGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_graphn_mean(s : StatsinferconfidenceGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_graphn_scale(s : StatsinferconfidenceGraphN, f : Double) -> StatsinferconfidenceGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_graphn_add(a : StatsinferconfidenceGraphN, b : StatsinferconfidenceGraphN) -> StatsinferconfidenceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_graphn_copy(s : StatsinferconfidenceGraphN) -> StatsinferconfidenceGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_graphn_fill(s : StatsinferconfidenceGraphN, v : Double) -> StatsinferconfidenceGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_graphn_min(s : StatsinferconfidenceGraphN) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_graphn_max(s : StatsinferconfidenceGraphN) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_graphn_to_string(s : StatsinferconfidenceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_node_make(size : Int) -> StatsinferconfidenceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_node_len(s : StatsinferconfidenceNode) -> Int { s.size }

pub fn stats_infer_confidence_node_get(s : StatsinferconfidenceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_node_set(s : StatsinferconfidenceNode, i : Int, v : Double) -> StatsinferconfidenceNode {
  let result = stats_infer_confidence_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_confidence_node_sum(s : StatsinferconfidenceNode) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_node_mean(s : StatsinferconfidenceNode) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_node_scale(s : StatsinferconfidenceNode, f : Double) -> StatsinferconfidenceNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_node_add(a : StatsinferconfidenceNode, b : StatsinferconfidenceNode) -> StatsinferconfidenceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_node_copy(s : StatsinferconfidenceNode) -> StatsinferconfidenceNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_node_fill(s : StatsinferconfidenceNode, v : Double) -> StatsinferconfidenceNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_node_min(s : StatsinferconfidenceNode) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_node_max(s : StatsinferconfidenceNode) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_node_to_string(s : StatsinferconfidenceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_edge_make(size : Int) -> StatsinferconfidenceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_edge_len(s : StatsinferconfidenceEdge) -> Int { s.size }

pub fn stats_infer_confidence_edge_get(s : StatsinferconfidenceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_edge_set(s : StatsinferconfidenceEdge, i : Int, v : Double) -> StatsinferconfidenceEdge {
  let result = stats_infer_confidence_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_confidence_edge_sum(s : StatsinferconfidenceEdge) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_edge_mean(s : StatsinferconfidenceEdge) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_edge_scale(s : StatsinferconfidenceEdge, f : Double) -> StatsinferconfidenceEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_edge_add(a : StatsinferconfidenceEdge, b : StatsinferconfidenceEdge) -> StatsinferconfidenceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_edge_copy(s : StatsinferconfidenceEdge) -> StatsinferconfidenceEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_edge_fill(s : StatsinferconfidenceEdge, v : Double) -> StatsinferconfidenceEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_edge_min(s : StatsinferconfidenceEdge) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_edge_max(s : StatsinferconfidenceEdge) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_edge_to_string(s : StatsinferconfidenceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidencePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_path_make(size : Int) -> StatsinferconfidencePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_path_len(s : StatsinferconfidencePath) -> Int { s.size }

pub fn stats_infer_confidence_path_get(s : StatsinferconfidencePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_path_set(s : StatsinferconfidencePath, i : Int, v : Double) -> StatsinferconfidencePath {
  let result = stats_infer_confidence_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_confidence_path_sum(s : StatsinferconfidencePath) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_path_mean(s : StatsinferconfidencePath) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_path_scale(s : StatsinferconfidencePath, f : Double) -> StatsinferconfidencePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_path_add(a : StatsinferconfidencePath, b : StatsinferconfidencePath) -> StatsinferconfidencePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_path_copy(s : StatsinferconfidencePath) -> StatsinferconfidencePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_path_fill(s : StatsinferconfidencePath, v : Double) -> StatsinferconfidencePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_path_min(s : StatsinferconfidencePath) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_path_max(s : StatsinferconfidencePath) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_path_to_string(s : StatsinferconfidencePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_cluster_make(size : Int) -> StatsinferconfidenceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_cluster_len(s : StatsinferconfidenceCluster) -> Int { s.size }

pub fn stats_infer_confidence_cluster_get(s : StatsinferconfidenceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_cluster_set(s : StatsinferconfidenceCluster, i : Int, v : Double) -> StatsinferconfidenceCluster {
  let result = stats_infer_confidence_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_confidence_cluster_sum(s : StatsinferconfidenceCluster) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_cluster_mean(s : StatsinferconfidenceCluster) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_cluster_scale(s : StatsinferconfidenceCluster, f : Double) -> StatsinferconfidenceCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_cluster_add(a : StatsinferconfidenceCluster, b : StatsinferconfidenceCluster) -> StatsinferconfidenceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_cluster_copy(s : StatsinferconfidenceCluster) -> StatsinferconfidenceCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_cluster_fill(s : StatsinferconfidenceCluster, v : Double) -> StatsinferconfidenceCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_cluster_min(s : StatsinferconfidenceCluster) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_cluster_max(s : StatsinferconfidenceCluster) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_cluster_to_string(s : StatsinferconfidenceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_model_make(size : Int) -> StatsinferconfidenceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_model_len(s : StatsinferconfidenceModel) -> Int { s.size }

pub fn stats_infer_confidence_model_get(s : StatsinferconfidenceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_model_set(s : StatsinferconfidenceModel, i : Int, v : Double) -> StatsinferconfidenceModel {
  let result = stats_infer_confidence_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_confidence_model_sum(s : StatsinferconfidenceModel) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_model_mean(s : StatsinferconfidenceModel) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_model_scale(s : StatsinferconfidenceModel, f : Double) -> StatsinferconfidenceModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_model_add(a : StatsinferconfidenceModel, b : StatsinferconfidenceModel) -> StatsinferconfidenceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_model_copy(s : StatsinferconfidenceModel) -> StatsinferconfidenceModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_model_fill(s : StatsinferconfidenceModel, v : Double) -> StatsinferconfidenceModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_model_min(s : StatsinferconfidenceModel) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_model_max(s : StatsinferconfidenceModel) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_model_to_string(s : StatsinferconfidenceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_layer_make(size : Int) -> StatsinferconfidenceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_layer_len(s : StatsinferconfidenceLayer) -> Int { s.size }

pub fn stats_infer_confidence_layer_get(s : StatsinferconfidenceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_layer_set(s : StatsinferconfidenceLayer, i : Int, v : Double) -> StatsinferconfidenceLayer {
  let result = stats_infer_confidence_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_confidence_layer_sum(s : StatsinferconfidenceLayer) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_layer_mean(s : StatsinferconfidenceLayer) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_layer_scale(s : StatsinferconfidenceLayer, f : Double) -> StatsinferconfidenceLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_layer_add(a : StatsinferconfidenceLayer, b : StatsinferconfidenceLayer) -> StatsinferconfidenceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_layer_copy(s : StatsinferconfidenceLayer) -> StatsinferconfidenceLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_layer_fill(s : StatsinferconfidenceLayer, v : Double) -> StatsinferconfidenceLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_layer_min(s : StatsinferconfidenceLayer) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_layer_max(s : StatsinferconfidenceLayer) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_layer_to_string(s : StatsinferconfidenceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_buffer_make(size : Int) -> StatsinferconfidenceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_buffer_len(s : StatsinferconfidenceBuffer) -> Int { s.size }

pub fn stats_infer_confidence_buffer_get(s : StatsinferconfidenceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_buffer_set(s : StatsinferconfidenceBuffer, i : Int, v : Double) -> StatsinferconfidenceBuffer {
  let result = stats_infer_confidence_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_confidence_buffer_sum(s : StatsinferconfidenceBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_buffer_mean(s : StatsinferconfidenceBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_buffer_scale(s : StatsinferconfidenceBuffer, f : Double) -> StatsinferconfidenceBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_buffer_add(a : StatsinferconfidenceBuffer, b : StatsinferconfidenceBuffer) -> StatsinferconfidenceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_buffer_copy(s : StatsinferconfidenceBuffer) -> StatsinferconfidenceBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_buffer_fill(s : StatsinferconfidenceBuffer, v : Double) -> StatsinferconfidenceBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_buffer_min(s : StatsinferconfidenceBuffer) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_buffer_max(s : StatsinferconfidenceBuffer) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_buffer_to_string(s : StatsinferconfidenceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_cursor_make(size : Int) -> StatsinferconfidenceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_cursor_len(s : StatsinferconfidenceCursor) -> Int { s.size }

pub fn stats_infer_confidence_cursor_get(s : StatsinferconfidenceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_cursor_set(s : StatsinferconfidenceCursor, i : Int, v : Double) -> StatsinferconfidenceCursor {
  let result = stats_infer_confidence_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_confidence_cursor_sum(s : StatsinferconfidenceCursor) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_cursor_mean(s : StatsinferconfidenceCursor) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_cursor_scale(s : StatsinferconfidenceCursor, f : Double) -> StatsinferconfidenceCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_cursor_add(a : StatsinferconfidenceCursor, b : StatsinferconfidenceCursor) -> StatsinferconfidenceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_cursor_copy(s : StatsinferconfidenceCursor) -> StatsinferconfidenceCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_cursor_fill(s : StatsinferconfidenceCursor, v : Double) -> StatsinferconfidenceCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_cursor_min(s : StatsinferconfidenceCursor) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_cursor_max(s : StatsinferconfidenceCursor) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_cursor_to_string(s : StatsinferconfidenceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_view_make(size : Int) -> StatsinferconfidenceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_view_len(s : StatsinferconfidenceView) -> Int { s.size }

pub fn stats_infer_confidence_view_get(s : StatsinferconfidenceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_view_set(s : StatsinferconfidenceView, i : Int, v : Double) -> StatsinferconfidenceView {
  let result = stats_infer_confidence_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_confidence_view_sum(s : StatsinferconfidenceView) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_view_mean(s : StatsinferconfidenceView) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_view_scale(s : StatsinferconfidenceView, f : Double) -> StatsinferconfidenceView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_view_add(a : StatsinferconfidenceView, b : StatsinferconfidenceView) -> StatsinferconfidenceView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_view_copy(s : StatsinferconfidenceView) -> StatsinferconfidenceView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_view_fill(s : StatsinferconfidenceView, v : Double) -> StatsinferconfidenceView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_view_min(s : StatsinferconfidenceView) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_view_max(s : StatsinferconfidenceView) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_view_to_string(s : StatsinferconfidenceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_range_make(size : Int) -> StatsinferconfidenceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_range_len(s : StatsinferconfidenceRange) -> Int { s.size }

pub fn stats_infer_confidence_range_get(s : StatsinferconfidenceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_range_set(s : StatsinferconfidenceRange, i : Int, v : Double) -> StatsinferconfidenceRange {
  let result = stats_infer_confidence_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_confidence_range_sum(s : StatsinferconfidenceRange) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_range_mean(s : StatsinferconfidenceRange) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_range_scale(s : StatsinferconfidenceRange, f : Double) -> StatsinferconfidenceRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_range_add(a : StatsinferconfidenceRange, b : StatsinferconfidenceRange) -> StatsinferconfidenceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_range_copy(s : StatsinferconfidenceRange) -> StatsinferconfidenceRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_range_fill(s : StatsinferconfidenceRange, v : Double) -> StatsinferconfidenceRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_range_min(s : StatsinferconfidenceRange) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_range_max(s : StatsinferconfidenceRange) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_range_to_string(s : StatsinferconfidenceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_slice_make(size : Int) -> StatsinferconfidenceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_slice_len(s : StatsinferconfidenceSlice) -> Int { s.size }

pub fn stats_infer_confidence_slice_get(s : StatsinferconfidenceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_slice_set(s : StatsinferconfidenceSlice, i : Int, v : Double) -> StatsinferconfidenceSlice {
  let result = stats_infer_confidence_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_confidence_slice_sum(s : StatsinferconfidenceSlice) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_slice_mean(s : StatsinferconfidenceSlice) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_slice_scale(s : StatsinferconfidenceSlice, f : Double) -> StatsinferconfidenceSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_slice_add(a : StatsinferconfidenceSlice, b : StatsinferconfidenceSlice) -> StatsinferconfidenceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_slice_copy(s : StatsinferconfidenceSlice) -> StatsinferconfidenceSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_slice_fill(s : StatsinferconfidenceSlice, v : Double) -> StatsinferconfidenceSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_slice_min(s : StatsinferconfidenceSlice) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_slice_max(s : StatsinferconfidenceSlice) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_slice_to_string(s : StatsinferconfidenceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

