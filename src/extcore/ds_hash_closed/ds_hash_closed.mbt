///===
/// extcore/ds_hash_closed

pub(all) struct DshashclosedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_closed_make_point(x : Double, y : Double) -> DshashclosedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_closed_make_point3(x : Double, y : Double, z : Double) -> DshashclosedPoint {
  { x, y, z, label: 0 }
}

pub fn ds_hash_closed_point_x(pt : DshashclosedPoint) -> Double { pt.x }

pub fn ds_hash_closed_point_y(pt : DshashclosedPoint) -> Double { pt.y }

pub fn ds_hash_closed_point_z(pt : DshashclosedPoint) -> Double { pt.z }

pub fn ds_hash_closed_point_label(pt : DshashclosedPoint) -> Int { pt.label }

pub fn ds_hash_closed_point_dist(a : DshashclosedPoint, b : DshashclosedPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_hash_closed_point_add(a : DshashclosedPoint, b : DshashclosedPoint) -> DshashclosedPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_hash_closed_point_sub(a : DshashclosedPoint, b : DshashclosedPoint) -> DshashclosedPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_hash_closed_point_scale(pt : DshashclosedPoint, s : Double) -> DshashclosedPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_hash_closed_point_dot(a : DshashclosedPoint, b : DshashclosedPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_hash_closed_point_cross(a : DshashclosedPoint, b : DshashclosedPoint) -> DshashclosedPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_hash_closed_point_norm(pt : DshashclosedPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_hash_closed_point_normalize(pt : DshashclosedPoint) -> DshashclosedPoint {
  let n = ds_hash_closed_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_hash_closed_point_scale(pt, 1.0 / n) }
}

pub fn ds_hash_closed_point_negate(pt : DshashclosedPoint) -> DshashclosedPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_hash_closed_point_mid(a : DshashclosedPoint, b : DshashclosedPoint) -> DshashclosedPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_hash_closed_point_lerp(a : DshashclosedPoint, b : DshashclosedPoint, t : Double) -> DshashclosedPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_hash_closed_point_to_string(pt : DshashclosedPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DshashclosedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_closed_make_series(vals : Array[Double], name : String) -> DshashclosedSeries {
  { vals, name, meta: 0 }
}

pub fn ds_hash_closed_series_len(s : DshashclosedSeries) -> Int { s.vals.length() }

pub fn ds_hash_closed_series_sum(s : DshashclosedSeries) -> Double { @_common.sum(s.vals) }

pub fn ds_hash_closed_series_mean(s : DshashclosedSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_hash_closed_series_min(s : DshashclosedSeries) -> Double { @_common.min(s.vals) }

pub fn ds_hash_closed_series_max(s : DshashclosedSeries) -> Double { @_common.max(s.vals) }

pub fn ds_hash_closed_series_range(s : DshashclosedSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_hash_closed_series_var(s : DshashclosedSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_hash_closed_series_std(s : DshashclosedSeries) -> Double { @_common.std(s.vals) }

pub fn ds_hash_closed_series_median(s : DshashclosedSeries) -> Double { @_common.median(s.vals) }

pub fn ds_hash_closed_series_scale(s : DshashclosedSeries, f : Double) -> DshashclosedSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_hash_closed_series_add(a : DshashclosedSeries, b : DshashclosedSeries) -> DshashclosedSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_hash_closed_series_sub(a : DshashclosedSeries, b : DshashclosedSeries) -> DshashclosedSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_hash_closed_series_normalize(s : DshashclosedSeries) -> DshashclosedSeries {
  let mn = ds_hash_closed_series_min(s)
  let mx = ds_hash_closed_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_hash_closed_series_cumsum(s : DshashclosedSeries) -> DshashclosedSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_hash_closed_series_to_string(s : DshashclosedSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashclosedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_closed_make_matrix(rows : Int, cols : Int, val : Double) -> DshashclosedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_closed_matrix_identity(n : Int) -> DshashclosedMatrix {
  let m = ds_hash_closed_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_hash_closed_matrix_get(m : DshashclosedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_hash_closed_matrix_transpose(m : DshashclosedMatrix) -> DshashclosedMatrix {
  let result = ds_hash_closed_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_hash_closed_matrix_add(a : DshashclosedMatrix, b : DshashclosedMatrix) -> DshashclosedMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_hash_closed_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_hash_closed_matrix_scale(m : DshashclosedMatrix, s : Double) -> DshashclosedMatrix {
  let result = ds_hash_closed_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_hash_closed_matrix_multiply(a : DshashclosedMatrix, b : DshashclosedMatrix) -> DshashclosedMatrix {
  if a.cols != b.rows { return ds_hash_closed_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_hash_closed_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_hash_closed_matrix_trace(m : DshashclosedMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_hash_closed_matrix_det(m : DshashclosedMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_hash_closed_matrix_norm(m : DshashclosedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_hash_closed_matrix_to_string(m : DshashclosedMatrix) -> String {
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

pub(all) struct DshashclosedVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_closed_make_vector(comps : Array[Double]) -> DshashclosedVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_closed_vector_zero(dim : Int) -> DshashclosedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_hash_closed_vector_add(a : DshashclosedVector, b : DshashclosedVector) -> DshashclosedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_closed_vector_sub(a : DshashclosedVector, b : DshashclosedVector) -> DshashclosedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_closed_vector_scale(v : DshashclosedVector, s : Double) -> DshashclosedVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_hash_closed_vector_dot(a : DshashclosedVector, b : DshashclosedVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_hash_closed_vector_norm(v : DshashclosedVector) -> Double { @_common.sqrt(ds_hash_closed_vector_dot(v, v)) }

pub fn ds_hash_closed_vector_normalize(v : DshashclosedVector) -> DshashclosedVector {
  let n = ds_hash_closed_vector_norm(v)
  if n < 0.0000001 { v } else { ds_hash_closed_vector_scale(v, 1.0 / n) }
}

pub fn ds_hash_closed_vector_dist(a : DshashclosedVector, b : DshashclosedVector) -> Double {
  ds_hash_closed_vector_norm(ds_hash_closed_vector_sub(a, b))
}

pub fn ds_hash_closed_vector_to_string(v : DshashclosedVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_hash_closed_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_hash_closed_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_hash_closed_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_hash_closed_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_hash_closed_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_hash_closed_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_hash_closed_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_hash_closed_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_hash_closed_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_hash_closed_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_hash_closed_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_hash_closed_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_hash_closed_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_hash_closed_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_hash_closed_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_hash_closed_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_hash_closed_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_hash_closed_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_hash_closed_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_hash_closed_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_hash_closed_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_hash_closed_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_hash_closed_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_hash_closed_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_hash_closed_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_hash_closed_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_hash_closed_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_hash_closed_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_hash_closed_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DshashclosedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_frame_make(size : Int) -> DshashclosedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_frame_len(s : DshashclosedFrame) -> Int { s.size }

pub fn ds_hash_closed_frame_get(s : DshashclosedFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_frame_set(s : DshashclosedFrame, i : Int, v : Double) -> DshashclosedFrame {
  let result = ds_hash_closed_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_frame_sum(s : DshashclosedFrame) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_frame_mean(s : DshashclosedFrame) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_frame_scale(s : DshashclosedFrame, f : Double) -> DshashclosedFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_frame_add(a : DshashclosedFrame, b : DshashclosedFrame) -> DshashclosedFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_frame_copy(s : DshashclosedFrame) -> DshashclosedFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_frame_fill(s : DshashclosedFrame, v : Double) -> DshashclosedFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_frame_min(s : DshashclosedFrame) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_frame_max(s : DshashclosedFrame) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_frame_to_string(s : DshashclosedFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_table_make(size : Int) -> DshashclosedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_table_len(s : DshashclosedTable) -> Int { s.size }

pub fn ds_hash_closed_table_get(s : DshashclosedTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_table_set(s : DshashclosedTable, i : Int, v : Double) -> DshashclosedTable {
  let result = ds_hash_closed_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_table_sum(s : DshashclosedTable) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_table_mean(s : DshashclosedTable) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_table_scale(s : DshashclosedTable, f : Double) -> DshashclosedTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_table_add(a : DshashclosedTable, b : DshashclosedTable) -> DshashclosedTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_table_copy(s : DshashclosedTable) -> DshashclosedTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_table_fill(s : DshashclosedTable, v : Double) -> DshashclosedTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_table_min(s : DshashclosedTable) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_table_max(s : DshashclosedTable) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_table_to_string(s : DshashclosedTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_graphn_make(size : Int) -> DshashclosedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_graphn_len(s : DshashclosedGraphN) -> Int { s.size }

pub fn ds_hash_closed_graphn_get(s : DshashclosedGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_graphn_set(s : DshashclosedGraphN, i : Int, v : Double) -> DshashclosedGraphN {
  let result = ds_hash_closed_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_graphn_sum(s : DshashclosedGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_graphn_mean(s : DshashclosedGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_graphn_scale(s : DshashclosedGraphN, f : Double) -> DshashclosedGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_graphn_add(a : DshashclosedGraphN, b : DshashclosedGraphN) -> DshashclosedGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_graphn_copy(s : DshashclosedGraphN) -> DshashclosedGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_graphn_fill(s : DshashclosedGraphN, v : Double) -> DshashclosedGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_graphn_min(s : DshashclosedGraphN) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_graphn_max(s : DshashclosedGraphN) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_graphn_to_string(s : DshashclosedGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_node_make(size : Int) -> DshashclosedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_node_len(s : DshashclosedNode) -> Int { s.size }

pub fn ds_hash_closed_node_get(s : DshashclosedNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_node_set(s : DshashclosedNode, i : Int, v : Double) -> DshashclosedNode {
  let result = ds_hash_closed_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_node_sum(s : DshashclosedNode) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_node_mean(s : DshashclosedNode) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_node_scale(s : DshashclosedNode, f : Double) -> DshashclosedNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_node_add(a : DshashclosedNode, b : DshashclosedNode) -> DshashclosedNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_node_copy(s : DshashclosedNode) -> DshashclosedNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_node_fill(s : DshashclosedNode, v : Double) -> DshashclosedNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_node_min(s : DshashclosedNode) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_node_max(s : DshashclosedNode) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_node_to_string(s : DshashclosedNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_edge_make(size : Int) -> DshashclosedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_edge_len(s : DshashclosedEdge) -> Int { s.size }

pub fn ds_hash_closed_edge_get(s : DshashclosedEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_edge_set(s : DshashclosedEdge, i : Int, v : Double) -> DshashclosedEdge {
  let result = ds_hash_closed_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_edge_sum(s : DshashclosedEdge) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_edge_mean(s : DshashclosedEdge) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_edge_scale(s : DshashclosedEdge, f : Double) -> DshashclosedEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_edge_add(a : DshashclosedEdge, b : DshashclosedEdge) -> DshashclosedEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_edge_copy(s : DshashclosedEdge) -> DshashclosedEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_edge_fill(s : DshashclosedEdge, v : Double) -> DshashclosedEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_edge_min(s : DshashclosedEdge) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_edge_max(s : DshashclosedEdge) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_edge_to_string(s : DshashclosedEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_path_make(size : Int) -> DshashclosedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_path_len(s : DshashclosedPath) -> Int { s.size }

pub fn ds_hash_closed_path_get(s : DshashclosedPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_path_set(s : DshashclosedPath, i : Int, v : Double) -> DshashclosedPath {
  let result = ds_hash_closed_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_path_sum(s : DshashclosedPath) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_path_mean(s : DshashclosedPath) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_path_scale(s : DshashclosedPath, f : Double) -> DshashclosedPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_path_add(a : DshashclosedPath, b : DshashclosedPath) -> DshashclosedPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_path_copy(s : DshashclosedPath) -> DshashclosedPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_path_fill(s : DshashclosedPath, v : Double) -> DshashclosedPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_path_min(s : DshashclosedPath) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_path_max(s : DshashclosedPath) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_path_to_string(s : DshashclosedPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_cluster_make(size : Int) -> DshashclosedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_cluster_len(s : DshashclosedCluster) -> Int { s.size }

pub fn ds_hash_closed_cluster_get(s : DshashclosedCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_cluster_set(s : DshashclosedCluster, i : Int, v : Double) -> DshashclosedCluster {
  let result = ds_hash_closed_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_cluster_sum(s : DshashclosedCluster) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_cluster_mean(s : DshashclosedCluster) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_cluster_scale(s : DshashclosedCluster, f : Double) -> DshashclosedCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_cluster_add(a : DshashclosedCluster, b : DshashclosedCluster) -> DshashclosedCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_cluster_copy(s : DshashclosedCluster) -> DshashclosedCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_cluster_fill(s : DshashclosedCluster, v : Double) -> DshashclosedCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_cluster_min(s : DshashclosedCluster) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_cluster_max(s : DshashclosedCluster) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_cluster_to_string(s : DshashclosedCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_model_make(size : Int) -> DshashclosedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_model_len(s : DshashclosedModel) -> Int { s.size }

pub fn ds_hash_closed_model_get(s : DshashclosedModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_model_set(s : DshashclosedModel, i : Int, v : Double) -> DshashclosedModel {
  let result = ds_hash_closed_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_model_sum(s : DshashclosedModel) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_model_mean(s : DshashclosedModel) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_model_scale(s : DshashclosedModel, f : Double) -> DshashclosedModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_model_add(a : DshashclosedModel, b : DshashclosedModel) -> DshashclosedModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_model_copy(s : DshashclosedModel) -> DshashclosedModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_model_fill(s : DshashclosedModel, v : Double) -> DshashclosedModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_model_min(s : DshashclosedModel) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_model_max(s : DshashclosedModel) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_model_to_string(s : DshashclosedModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_layer_make(size : Int) -> DshashclosedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_layer_len(s : DshashclosedLayer) -> Int { s.size }

pub fn ds_hash_closed_layer_get(s : DshashclosedLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_layer_set(s : DshashclosedLayer, i : Int, v : Double) -> DshashclosedLayer {
  let result = ds_hash_closed_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_layer_sum(s : DshashclosedLayer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_layer_mean(s : DshashclosedLayer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_layer_scale(s : DshashclosedLayer, f : Double) -> DshashclosedLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_layer_add(a : DshashclosedLayer, b : DshashclosedLayer) -> DshashclosedLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_layer_copy(s : DshashclosedLayer) -> DshashclosedLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_layer_fill(s : DshashclosedLayer, v : Double) -> DshashclosedLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_layer_min(s : DshashclosedLayer) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_layer_max(s : DshashclosedLayer) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_layer_to_string(s : DshashclosedLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_buffer_make(size : Int) -> DshashclosedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_buffer_len(s : DshashclosedBuffer) -> Int { s.size }

pub fn ds_hash_closed_buffer_get(s : DshashclosedBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_buffer_set(s : DshashclosedBuffer, i : Int, v : Double) -> DshashclosedBuffer {
  let result = ds_hash_closed_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_buffer_sum(s : DshashclosedBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_buffer_mean(s : DshashclosedBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_buffer_scale(s : DshashclosedBuffer, f : Double) -> DshashclosedBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_buffer_add(a : DshashclosedBuffer, b : DshashclosedBuffer) -> DshashclosedBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_buffer_copy(s : DshashclosedBuffer) -> DshashclosedBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_buffer_fill(s : DshashclosedBuffer, v : Double) -> DshashclosedBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_buffer_min(s : DshashclosedBuffer) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_buffer_max(s : DshashclosedBuffer) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_buffer_to_string(s : DshashclosedBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_cursor_make(size : Int) -> DshashclosedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_cursor_len(s : DshashclosedCursor) -> Int { s.size }

pub fn ds_hash_closed_cursor_get(s : DshashclosedCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_cursor_set(s : DshashclosedCursor, i : Int, v : Double) -> DshashclosedCursor {
  let result = ds_hash_closed_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_cursor_sum(s : DshashclosedCursor) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_cursor_mean(s : DshashclosedCursor) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_cursor_scale(s : DshashclosedCursor, f : Double) -> DshashclosedCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_cursor_add(a : DshashclosedCursor, b : DshashclosedCursor) -> DshashclosedCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_cursor_copy(s : DshashclosedCursor) -> DshashclosedCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_cursor_fill(s : DshashclosedCursor, v : Double) -> DshashclosedCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_cursor_min(s : DshashclosedCursor) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_cursor_max(s : DshashclosedCursor) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_cursor_to_string(s : DshashclosedCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_view_make(size : Int) -> DshashclosedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_view_len(s : DshashclosedView) -> Int { s.size }

pub fn ds_hash_closed_view_get(s : DshashclosedView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_view_set(s : DshashclosedView, i : Int, v : Double) -> DshashclosedView {
  let result = ds_hash_closed_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_view_sum(s : DshashclosedView) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_view_mean(s : DshashclosedView) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_view_scale(s : DshashclosedView, f : Double) -> DshashclosedView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_view_add(a : DshashclosedView, b : DshashclosedView) -> DshashclosedView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_view_copy(s : DshashclosedView) -> DshashclosedView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_view_fill(s : DshashclosedView, v : Double) -> DshashclosedView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_view_min(s : DshashclosedView) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_view_max(s : DshashclosedView) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_view_to_string(s : DshashclosedView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_range_make(size : Int) -> DshashclosedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_range_len(s : DshashclosedRange) -> Int { s.size }

pub fn ds_hash_closed_range_get(s : DshashclosedRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_range_set(s : DshashclosedRange, i : Int, v : Double) -> DshashclosedRange {
  let result = ds_hash_closed_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_range_sum(s : DshashclosedRange) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_range_mean(s : DshashclosedRange) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_range_scale(s : DshashclosedRange, f : Double) -> DshashclosedRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_range_add(a : DshashclosedRange, b : DshashclosedRange) -> DshashclosedRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_range_copy(s : DshashclosedRange) -> DshashclosedRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_range_fill(s : DshashclosedRange, v : Double) -> DshashclosedRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_range_min(s : DshashclosedRange) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_range_max(s : DshashclosedRange) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_range_to_string(s : DshashclosedRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_slice_make(size : Int) -> DshashclosedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_slice_len(s : DshashclosedSlice) -> Int { s.size }

pub fn ds_hash_closed_slice_get(s : DshashclosedSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_slice_set(s : DshashclosedSlice, i : Int, v : Double) -> DshashclosedSlice {
  let result = ds_hash_closed_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_slice_sum(s : DshashclosedSlice) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_slice_mean(s : DshashclosedSlice) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_slice_scale(s : DshashclosedSlice, f : Double) -> DshashclosedSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_slice_add(a : DshashclosedSlice, b : DshashclosedSlice) -> DshashclosedSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_slice_copy(s : DshashclosedSlice) -> DshashclosedSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_slice_fill(s : DshashclosedSlice, v : Double) -> DshashclosedSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_slice_min(s : DshashclosedSlice) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_slice_max(s : DshashclosedSlice) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_slice_to_string(s : DshashclosedSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

