///===
/// extcore/stats_test_normality

pub(all) struct StatstestnormalityPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_normality_make_point(x : Double, y : Double) -> StatstestnormalityPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_normality_make_point3(x : Double, y : Double, z : Double) -> StatstestnormalityPoint {
  { x, y, z, label: 0 }
}

pub fn stats_test_normality_point_x(pt : StatstestnormalityPoint) -> Double { pt.x }

pub fn stats_test_normality_point_y(pt : StatstestnormalityPoint) -> Double { pt.y }

pub fn stats_test_normality_point_z(pt : StatstestnormalityPoint) -> Double { pt.z }

pub fn stats_test_normality_point_label(pt : StatstestnormalityPoint) -> Int { pt.label }

pub fn stats_test_normality_point_dist(a : StatstestnormalityPoint, b : StatstestnormalityPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_test_normality_point_add(a : StatstestnormalityPoint, b : StatstestnormalityPoint) -> StatstestnormalityPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_test_normality_point_sub(a : StatstestnormalityPoint, b : StatstestnormalityPoint) -> StatstestnormalityPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_test_normality_point_scale(pt : StatstestnormalityPoint, s : Double) -> StatstestnormalityPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_test_normality_point_dot(a : StatstestnormalityPoint, b : StatstestnormalityPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_test_normality_point_cross(a : StatstestnormalityPoint, b : StatstestnormalityPoint) -> StatstestnormalityPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_test_normality_point_norm(pt : StatstestnormalityPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_test_normality_point_normalize(pt : StatstestnormalityPoint) -> StatstestnormalityPoint {
  let n = stats_test_normality_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_test_normality_point_scale(pt, 1.0 / n) }
}

pub fn stats_test_normality_point_negate(pt : StatstestnormalityPoint) -> StatstestnormalityPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_test_normality_point_mid(a : StatstestnormalityPoint, b : StatstestnormalityPoint) -> StatstestnormalityPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_test_normality_point_lerp(a : StatstestnormalityPoint, b : StatstestnormalityPoint, t : Double) -> StatstestnormalityPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_test_normality_point_to_string(pt : StatstestnormalityPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatstestnormalitySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_normality_make_series(vals : Array[Double], name : String) -> StatstestnormalitySeries {
  { vals, name, meta: 0 }
}

pub fn stats_test_normality_series_len(s : StatstestnormalitySeries) -> Int { s.vals.length() }

pub fn stats_test_normality_series_sum(s : StatstestnormalitySeries) -> Double { @_common.sum(s.vals) }

pub fn stats_test_normality_series_mean(s : StatstestnormalitySeries) -> Double { @_common.mean(s.vals) }

pub fn stats_test_normality_series_min(s : StatstestnormalitySeries) -> Double { @_common.min(s.vals) }

pub fn stats_test_normality_series_max(s : StatstestnormalitySeries) -> Double { @_common.max(s.vals) }

pub fn stats_test_normality_series_range(s : StatstestnormalitySeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_test_normality_series_var(s : StatstestnormalitySeries) -> Double { @_common.variance(s.vals) }

pub fn stats_test_normality_series_std(s : StatstestnormalitySeries) -> Double { @_common.std(s.vals) }

pub fn stats_test_normality_series_median(s : StatstestnormalitySeries) -> Double { @_common.median(s.vals) }

pub fn stats_test_normality_series_scale(s : StatstestnormalitySeries, f : Double) -> StatstestnormalitySeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn stats_test_normality_series_add(a : StatstestnormalitySeries, b : StatstestnormalitySeries) -> StatstestnormalitySeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_test_normality_series_sub(a : StatstestnormalitySeries, b : StatstestnormalitySeries) -> StatstestnormalitySeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_test_normality_series_normalize(s : StatstestnormalitySeries) -> StatstestnormalitySeries {
  let mn = stats_test_normality_series_min(s)
  let mx = stats_test_normality_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_test_normality_series_cumsum(s : StatstestnormalitySeries) -> StatstestnormalitySeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_test_normality_series_to_string(s : StatstestnormalitySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestnormalityMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_normality_make_matrix(rows : Int, cols : Int, val : Double) -> StatstestnormalityMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_normality_matrix_identity(n : Int) -> StatstestnormalityMatrix {
  let m = stats_test_normality_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_test_normality_matrix_get(m : StatstestnormalityMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_test_normality_matrix_transpose(m : StatstestnormalityMatrix) -> StatstestnormalityMatrix {
  let result = stats_test_normality_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_test_normality_matrix_add(a : StatstestnormalityMatrix, b : StatstestnormalityMatrix) -> StatstestnormalityMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_test_normality_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_test_normality_matrix_scale(m : StatstestnormalityMatrix, s : Double) -> StatstestnormalityMatrix {
  let result = stats_test_normality_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_test_normality_matrix_multiply(a : StatstestnormalityMatrix, b : StatstestnormalityMatrix) -> StatstestnormalityMatrix {
  if a.cols != b.rows { return stats_test_normality_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_test_normality_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_test_normality_matrix_trace(m : StatstestnormalityMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_test_normality_matrix_det(m : StatstestnormalityMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_test_normality_matrix_norm(m : StatstestnormalityMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_test_normality_matrix_to_string(m : StatstestnormalityMatrix) -> String {
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

pub(all) struct StatstestnormalityVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_normality_make_vector(comps : Array[Double]) -> StatstestnormalityVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_normality_vector_zero(dim : Int) -> StatstestnormalityVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_test_normality_vector_add(a : StatstestnormalityVector, b : StatstestnormalityVector) -> StatstestnormalityVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn stats_test_normality_vector_sub(a : StatstestnormalityVector, b : StatstestnormalityVector) -> StatstestnormalityVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn stats_test_normality_vector_scale(v : StatstestnormalityVector, s : Double) -> StatstestnormalityVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn stats_test_normality_vector_dot(a : StatstestnormalityVector, b : StatstestnormalityVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_test_normality_vector_norm(v : StatstestnormalityVector) -> Double { @_common.sqrt(stats_test_normality_vector_dot(v, v)) }

pub fn stats_test_normality_vector_normalize(v : StatstestnormalityVector) -> StatstestnormalityVector {
  let n = stats_test_normality_vector_norm(v)
  if n < 0.0000001 { v } else { stats_test_normality_vector_scale(v, 1.0 / n) }
}

pub fn stats_test_normality_vector_dist(a : StatstestnormalityVector, b : StatstestnormalityVector) -> Double {
  stats_test_normality_vector_norm(stats_test_normality_vector_sub(a, b))
}

pub fn stats_test_normality_vector_to_string(v : StatstestnormalityVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_test_normality_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_test_normality_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_test_normality_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_test_normality_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_test_normality_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_test_normality_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_test_normality_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_test_normality_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_test_normality_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_test_normality_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_test_normality_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_test_normality_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_test_normality_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_test_normality_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_test_normality_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_test_normality_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_test_normality_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_test_normality_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_test_normality_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_test_normality_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_test_normality_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_test_normality_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_test_normality_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_test_normality_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_test_normality_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_test_normality_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_test_normality_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_test_normality_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_test_normality_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatstestnormalityFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_frame_make(size : Int) -> StatstestnormalityFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_frame_len(s : StatstestnormalityFrame) -> Int { s.size }

pub fn stats_test_normality_frame_get(s : StatstestnormalityFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_frame_set(s : StatstestnormalityFrame, i : Int, v : Double) -> StatstestnormalityFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_frame_sum(s : StatstestnormalityFrame) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_frame_mean(s : StatstestnormalityFrame) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_frame_scale(s : StatstestnormalityFrame, f : Double) -> StatstestnormalityFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_frame_add(a : StatstestnormalityFrame, b : StatstestnormalityFrame) -> StatstestnormalityFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_frame_copy(s : StatstestnormalityFrame) -> StatstestnormalityFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_frame_fill(s : StatstestnormalityFrame, v : Double) -> StatstestnormalityFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_frame_min(s : StatstestnormalityFrame) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_frame_max(s : StatstestnormalityFrame) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_frame_to_string(s : StatstestnormalityFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_table_make(size : Int) -> StatstestnormalityTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_table_len(s : StatstestnormalityTable) -> Int { s.size }

pub fn stats_test_normality_table_get(s : StatstestnormalityTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_table_set(s : StatstestnormalityTable, i : Int, v : Double) -> StatstestnormalityTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_table_sum(s : StatstestnormalityTable) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_table_mean(s : StatstestnormalityTable) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_table_scale(s : StatstestnormalityTable, f : Double) -> StatstestnormalityTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_table_add(a : StatstestnormalityTable, b : StatstestnormalityTable) -> StatstestnormalityTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_table_copy(s : StatstestnormalityTable) -> StatstestnormalityTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_table_fill(s : StatstestnormalityTable, v : Double) -> StatstestnormalityTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_table_min(s : StatstestnormalityTable) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_table_max(s : StatstestnormalityTable) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_table_to_string(s : StatstestnormalityTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_graphn_make(size : Int) -> StatstestnormalityGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_graphn_len(s : StatstestnormalityGraphN) -> Int { s.size }

pub fn stats_test_normality_graphn_get(s : StatstestnormalityGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_graphn_set(s : StatstestnormalityGraphN, i : Int, v : Double) -> StatstestnormalityGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_graphn_sum(s : StatstestnormalityGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_graphn_mean(s : StatstestnormalityGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_graphn_scale(s : StatstestnormalityGraphN, f : Double) -> StatstestnormalityGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_graphn_add(a : StatstestnormalityGraphN, b : StatstestnormalityGraphN) -> StatstestnormalityGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_graphn_copy(s : StatstestnormalityGraphN) -> StatstestnormalityGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_graphn_fill(s : StatstestnormalityGraphN, v : Double) -> StatstestnormalityGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_graphn_min(s : StatstestnormalityGraphN) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_graphn_max(s : StatstestnormalityGraphN) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_graphn_to_string(s : StatstestnormalityGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_node_make(size : Int) -> StatstestnormalityNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_node_len(s : StatstestnormalityNode) -> Int { s.size }

pub fn stats_test_normality_node_get(s : StatstestnormalityNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_node_set(s : StatstestnormalityNode, i : Int, v : Double) -> StatstestnormalityNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_node_sum(s : StatstestnormalityNode) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_node_mean(s : StatstestnormalityNode) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_node_scale(s : StatstestnormalityNode, f : Double) -> StatstestnormalityNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_node_add(a : StatstestnormalityNode, b : StatstestnormalityNode) -> StatstestnormalityNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_node_copy(s : StatstestnormalityNode) -> StatstestnormalityNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_node_fill(s : StatstestnormalityNode, v : Double) -> StatstestnormalityNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_node_min(s : StatstestnormalityNode) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_node_max(s : StatstestnormalityNode) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_node_to_string(s : StatstestnormalityNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_edge_make(size : Int) -> StatstestnormalityEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_edge_len(s : StatstestnormalityEdge) -> Int { s.size }

pub fn stats_test_normality_edge_get(s : StatstestnormalityEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_edge_set(s : StatstestnormalityEdge, i : Int, v : Double) -> StatstestnormalityEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_edge_sum(s : StatstestnormalityEdge) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_edge_mean(s : StatstestnormalityEdge) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_edge_scale(s : StatstestnormalityEdge, f : Double) -> StatstestnormalityEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_edge_add(a : StatstestnormalityEdge, b : StatstestnormalityEdge) -> StatstestnormalityEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_edge_copy(s : StatstestnormalityEdge) -> StatstestnormalityEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_edge_fill(s : StatstestnormalityEdge, v : Double) -> StatstestnormalityEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_edge_min(s : StatstestnormalityEdge) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_edge_max(s : StatstestnormalityEdge) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_edge_to_string(s : StatstestnormalityEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_path_make(size : Int) -> StatstestnormalityPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_path_len(s : StatstestnormalityPath) -> Int { s.size }

pub fn stats_test_normality_path_get(s : StatstestnormalityPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_path_set(s : StatstestnormalityPath, i : Int, v : Double) -> StatstestnormalityPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_path_sum(s : StatstestnormalityPath) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_path_mean(s : StatstestnormalityPath) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_path_scale(s : StatstestnormalityPath, f : Double) -> StatstestnormalityPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_path_add(a : StatstestnormalityPath, b : StatstestnormalityPath) -> StatstestnormalityPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_path_copy(s : StatstestnormalityPath) -> StatstestnormalityPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_path_fill(s : StatstestnormalityPath, v : Double) -> StatstestnormalityPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_path_min(s : StatstestnormalityPath) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_path_max(s : StatstestnormalityPath) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_path_to_string(s : StatstestnormalityPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_cluster_make(size : Int) -> StatstestnormalityCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_cluster_len(s : StatstestnormalityCluster) -> Int { s.size }

pub fn stats_test_normality_cluster_get(s : StatstestnormalityCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_cluster_set(s : StatstestnormalityCluster, i : Int, v : Double) -> StatstestnormalityCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_cluster_sum(s : StatstestnormalityCluster) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_cluster_mean(s : StatstestnormalityCluster) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_cluster_scale(s : StatstestnormalityCluster, f : Double) -> StatstestnormalityCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_cluster_add(a : StatstestnormalityCluster, b : StatstestnormalityCluster) -> StatstestnormalityCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_cluster_copy(s : StatstestnormalityCluster) -> StatstestnormalityCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_cluster_fill(s : StatstestnormalityCluster, v : Double) -> StatstestnormalityCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_cluster_min(s : StatstestnormalityCluster) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_cluster_max(s : StatstestnormalityCluster) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_cluster_to_string(s : StatstestnormalityCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_model_make(size : Int) -> StatstestnormalityModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_model_len(s : StatstestnormalityModel) -> Int { s.size }

pub fn stats_test_normality_model_get(s : StatstestnormalityModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_model_set(s : StatstestnormalityModel, i : Int, v : Double) -> StatstestnormalityModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_model_sum(s : StatstestnormalityModel) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_model_mean(s : StatstestnormalityModel) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_model_scale(s : StatstestnormalityModel, f : Double) -> StatstestnormalityModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_model_add(a : StatstestnormalityModel, b : StatstestnormalityModel) -> StatstestnormalityModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_model_copy(s : StatstestnormalityModel) -> StatstestnormalityModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_model_fill(s : StatstestnormalityModel, v : Double) -> StatstestnormalityModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_model_min(s : StatstestnormalityModel) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_model_max(s : StatstestnormalityModel) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_model_to_string(s : StatstestnormalityModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_layer_make(size : Int) -> StatstestnormalityLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_layer_len(s : StatstestnormalityLayer) -> Int { s.size }

pub fn stats_test_normality_layer_get(s : StatstestnormalityLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_layer_set(s : StatstestnormalityLayer, i : Int, v : Double) -> StatstestnormalityLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_layer_sum(s : StatstestnormalityLayer) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_layer_mean(s : StatstestnormalityLayer) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_layer_scale(s : StatstestnormalityLayer, f : Double) -> StatstestnormalityLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_layer_add(a : StatstestnormalityLayer, b : StatstestnormalityLayer) -> StatstestnormalityLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_layer_copy(s : StatstestnormalityLayer) -> StatstestnormalityLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_layer_fill(s : StatstestnormalityLayer, v : Double) -> StatstestnormalityLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_layer_min(s : StatstestnormalityLayer) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_layer_max(s : StatstestnormalityLayer) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_layer_to_string(s : StatstestnormalityLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_buffer_make(size : Int) -> StatstestnormalityBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_buffer_len(s : StatstestnormalityBuffer) -> Int { s.size }

pub fn stats_test_normality_buffer_get(s : StatstestnormalityBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_buffer_set(s : StatstestnormalityBuffer, i : Int, v : Double) -> StatstestnormalityBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_buffer_sum(s : StatstestnormalityBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_buffer_mean(s : StatstestnormalityBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_buffer_scale(s : StatstestnormalityBuffer, f : Double) -> StatstestnormalityBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_buffer_add(a : StatstestnormalityBuffer, b : StatstestnormalityBuffer) -> StatstestnormalityBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_buffer_copy(s : StatstestnormalityBuffer) -> StatstestnormalityBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_buffer_fill(s : StatstestnormalityBuffer, v : Double) -> StatstestnormalityBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_buffer_min(s : StatstestnormalityBuffer) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_buffer_max(s : StatstestnormalityBuffer) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_buffer_to_string(s : StatstestnormalityBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_cursor_make(size : Int) -> StatstestnormalityCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_cursor_len(s : StatstestnormalityCursor) -> Int { s.size }

pub fn stats_test_normality_cursor_get(s : StatstestnormalityCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_cursor_set(s : StatstestnormalityCursor, i : Int, v : Double) -> StatstestnormalityCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_cursor_sum(s : StatstestnormalityCursor) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_cursor_mean(s : StatstestnormalityCursor) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_cursor_scale(s : StatstestnormalityCursor, f : Double) -> StatstestnormalityCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_cursor_add(a : StatstestnormalityCursor, b : StatstestnormalityCursor) -> StatstestnormalityCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_cursor_copy(s : StatstestnormalityCursor) -> StatstestnormalityCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_cursor_fill(s : StatstestnormalityCursor, v : Double) -> StatstestnormalityCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_cursor_min(s : StatstestnormalityCursor) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_cursor_max(s : StatstestnormalityCursor) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_cursor_to_string(s : StatstestnormalityCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_view_make(size : Int) -> StatstestnormalityView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_view_len(s : StatstestnormalityView) -> Int { s.size }

pub fn stats_test_normality_view_get(s : StatstestnormalityView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_view_set(s : StatstestnormalityView, i : Int, v : Double) -> StatstestnormalityView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_view_sum(s : StatstestnormalityView) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_view_mean(s : StatstestnormalityView) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_view_scale(s : StatstestnormalityView, f : Double) -> StatstestnormalityView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_view_add(a : StatstestnormalityView, b : StatstestnormalityView) -> StatstestnormalityView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_view_copy(s : StatstestnormalityView) -> StatstestnormalityView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_view_fill(s : StatstestnormalityView, v : Double) -> StatstestnormalityView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_view_min(s : StatstestnormalityView) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_view_max(s : StatstestnormalityView) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_view_to_string(s : StatstestnormalityView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_range_make(size : Int) -> StatstestnormalityRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_range_len(s : StatstestnormalityRange) -> Int { s.size }

pub fn stats_test_normality_range_get(s : StatstestnormalityRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_range_set(s : StatstestnormalityRange, i : Int, v : Double) -> StatstestnormalityRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_range_sum(s : StatstestnormalityRange) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_range_mean(s : StatstestnormalityRange) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_range_scale(s : StatstestnormalityRange, f : Double) -> StatstestnormalityRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_range_add(a : StatstestnormalityRange, b : StatstestnormalityRange) -> StatstestnormalityRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_range_copy(s : StatstestnormalityRange) -> StatstestnormalityRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_range_fill(s : StatstestnormalityRange, v : Double) -> StatstestnormalityRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_range_min(s : StatstestnormalityRange) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_range_max(s : StatstestnormalityRange) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_range_to_string(s : StatstestnormalityRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalitySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_slice_make(size : Int) -> StatstestnormalitySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_slice_len(s : StatstestnormalitySlice) -> Int { s.size }

pub fn stats_test_normality_slice_get(s : StatstestnormalitySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_slice_set(s : StatstestnormalitySlice, i : Int, v : Double) -> StatstestnormalitySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_normality_slice_sum(s : StatstestnormalitySlice) -> Double { @_common.sum(s.data) }

pub fn stats_test_normality_slice_mean(s : StatstestnormalitySlice) -> Double { @_common.mean(s.data) }

pub fn stats_test_normality_slice_scale(s : StatstestnormalitySlice, f : Double) -> StatstestnormalitySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_slice_add(a : StatstestnormalitySlice, b : StatstestnormalitySlice) -> StatstestnormalitySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_normality_slice_copy(s : StatstestnormalitySlice) -> StatstestnormalitySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_slice_fill(s : StatstestnormalitySlice, v : Double) -> StatstestnormalitySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_normality_slice_min(s : StatstestnormalitySlice) -> Double { @_common.min(s.data) }

pub fn stats_test_normality_slice_max(s : StatstestnormalitySlice) -> Double { @_common.max(s.data) }

pub fn stats_test_normality_slice_to_string(s : StatstestnormalitySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

