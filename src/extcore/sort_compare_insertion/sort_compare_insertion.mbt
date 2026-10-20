///===
/// extcore/sort_compare_insertion

pub(all) struct SortcompareinsertionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_insertion_make_point(x : Double, y : Double) -> SortcompareinsertionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_insertion_make_point3(x : Double, y : Double, z : Double) -> SortcompareinsertionPoint {
  { x, y, z, label: 0 }
}

pub fn sort_compare_insertion_point_x(pt : SortcompareinsertionPoint) -> Double { pt.x }

pub fn sort_compare_insertion_point_y(pt : SortcompareinsertionPoint) -> Double { pt.y }

pub fn sort_compare_insertion_point_z(pt : SortcompareinsertionPoint) -> Double { pt.z }

pub fn sort_compare_insertion_point_label(pt : SortcompareinsertionPoint) -> Int { pt.label }

pub fn sort_compare_insertion_point_dist(a : SortcompareinsertionPoint, b : SortcompareinsertionPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_compare_insertion_point_add(a : SortcompareinsertionPoint, b : SortcompareinsertionPoint) -> SortcompareinsertionPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_compare_insertion_point_sub(a : SortcompareinsertionPoint, b : SortcompareinsertionPoint) -> SortcompareinsertionPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_compare_insertion_point_scale(pt : SortcompareinsertionPoint, s : Double) -> SortcompareinsertionPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_compare_insertion_point_dot(a : SortcompareinsertionPoint, b : SortcompareinsertionPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_compare_insertion_point_cross(a : SortcompareinsertionPoint, b : SortcompareinsertionPoint) -> SortcompareinsertionPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_compare_insertion_point_norm(pt : SortcompareinsertionPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_compare_insertion_point_normalize(pt : SortcompareinsertionPoint) -> SortcompareinsertionPoint {
  let n = sort_compare_insertion_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_compare_insertion_point_scale(pt, 1.0 / n) }
}

pub fn sort_compare_insertion_point_negate(pt : SortcompareinsertionPoint) -> SortcompareinsertionPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_compare_insertion_point_mid(a : SortcompareinsertionPoint, b : SortcompareinsertionPoint) -> SortcompareinsertionPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_compare_insertion_point_lerp(a : SortcompareinsertionPoint, b : SortcompareinsertionPoint, t : Double) -> SortcompareinsertionPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_compare_insertion_point_to_string(pt : SortcompareinsertionPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortcompareinsertionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_insertion_make_series(vals : Array[Double], name : String) -> SortcompareinsertionSeries {
  { vals, name, meta: 0 }
}

pub fn sort_compare_insertion_series_len(s : SortcompareinsertionSeries) -> Int { s.vals.length() }

pub fn sort_compare_insertion_series_sum(s : SortcompareinsertionSeries) -> Double { @_common.sum(s.vals) }

pub fn sort_compare_insertion_series_mean(s : SortcompareinsertionSeries) -> Double { @_common.mean(s.vals) }

pub fn sort_compare_insertion_series_min(s : SortcompareinsertionSeries) -> Double { @_common.min(s.vals) }

pub fn sort_compare_insertion_series_max(s : SortcompareinsertionSeries) -> Double { @_common.max(s.vals) }

pub fn sort_compare_insertion_series_range(s : SortcompareinsertionSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn sort_compare_insertion_series_var(s : SortcompareinsertionSeries) -> Double { @_common.variance(s.vals) }

pub fn sort_compare_insertion_series_std(s : SortcompareinsertionSeries) -> Double { @_common.std(s.vals) }

pub fn sort_compare_insertion_series_median(s : SortcompareinsertionSeries) -> Double { @_common.median(s.vals) }

pub fn sort_compare_insertion_series_scale(s : SortcompareinsertionSeries, f : Double) -> SortcompareinsertionSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_compare_insertion_series_add(a : SortcompareinsertionSeries, b : SortcompareinsertionSeries) -> SortcompareinsertionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_compare_insertion_series_sub(a : SortcompareinsertionSeries, b : SortcompareinsertionSeries) -> SortcompareinsertionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_compare_insertion_series_normalize(s : SortcompareinsertionSeries) -> SortcompareinsertionSeries {
  let mn = sort_compare_insertion_series_min(s)
  let mx = sort_compare_insertion_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_compare_insertion_series_cumsum(s : SortcompareinsertionSeries) -> SortcompareinsertionSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_compare_insertion_series_to_string(s : SortcompareinsertionSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcompareinsertionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_insertion_make_matrix(rows : Int, cols : Int, val : Double) -> SortcompareinsertionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_insertion_matrix_identity(n : Int) -> SortcompareinsertionMatrix {
  let m = sort_compare_insertion_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_compare_insertion_matrix_get(m : SortcompareinsertionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_compare_insertion_matrix_transpose(m : SortcompareinsertionMatrix) -> SortcompareinsertionMatrix {
  let result = sort_compare_insertion_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_compare_insertion_matrix_add(a : SortcompareinsertionMatrix, b : SortcompareinsertionMatrix) -> SortcompareinsertionMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_compare_insertion_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_compare_insertion_matrix_scale(m : SortcompareinsertionMatrix, s : Double) -> SortcompareinsertionMatrix {
  let result = sort_compare_insertion_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_compare_insertion_matrix_multiply(a : SortcompareinsertionMatrix, b : SortcompareinsertionMatrix) -> SortcompareinsertionMatrix {
  if a.cols != b.rows { return sort_compare_insertion_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_compare_insertion_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_compare_insertion_matrix_trace(m : SortcompareinsertionMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_compare_insertion_matrix_det(m : SortcompareinsertionMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_compare_insertion_matrix_norm(m : SortcompareinsertionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_compare_insertion_matrix_to_string(m : SortcompareinsertionMatrix) -> String {
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

pub(all) struct SortcompareinsertionVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_insertion_make_vector(comps : Array[Double]) -> SortcompareinsertionVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_insertion_vector_zero(dim : Int) -> SortcompareinsertionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_compare_insertion_vector_add(a : SortcompareinsertionVector, b : SortcompareinsertionVector) -> SortcompareinsertionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_compare_insertion_vector_sub(a : SortcompareinsertionVector, b : SortcompareinsertionVector) -> SortcompareinsertionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_compare_insertion_vector_scale(v : SortcompareinsertionVector, s : Double) -> SortcompareinsertionVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_compare_insertion_vector_dot(a : SortcompareinsertionVector, b : SortcompareinsertionVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_compare_insertion_vector_norm(v : SortcompareinsertionVector) -> Double { @_common.sqrt(sort_compare_insertion_vector_dot(v, v)) }

pub fn sort_compare_insertion_vector_normalize(v : SortcompareinsertionVector) -> SortcompareinsertionVector {
  let n = sort_compare_insertion_vector_norm(v)
  if n < 0.0000001 { v } else { sort_compare_insertion_vector_scale(v, 1.0 / n) }
}

pub fn sort_compare_insertion_vector_dist(a : SortcompareinsertionVector, b : SortcompareinsertionVector) -> Double {
  sort_compare_insertion_vector_norm(sort_compare_insertion_vector_sub(a, b))
}

pub fn sort_compare_insertion_vector_to_string(v : SortcompareinsertionVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_insertion_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_compare_insertion_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_compare_insertion_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_compare_insertion_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_compare_insertion_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_compare_insertion_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_compare_insertion_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_compare_insertion_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_compare_insertion_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_compare_insertion_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_compare_insertion_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_compare_insertion_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_compare_insertion_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_compare_insertion_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_compare_insertion_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_compare_insertion_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_compare_insertion_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_compare_insertion_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_compare_insertion_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_compare_insertion_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_compare_insertion_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_compare_insertion_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_compare_insertion_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_compare_insertion_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_compare_insertion_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_compare_insertion_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_compare_insertion_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_compare_insertion_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_compare_insertion_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortcompareinsertionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_frame_make(size : Int) -> SortcompareinsertionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_frame_len(s : SortcompareinsertionFrame) -> Int { s.size }

pub fn sort_compare_insertion_frame_get(s : SortcompareinsertionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_frame_set(s : SortcompareinsertionFrame, i : Int, v : Double) -> SortcompareinsertionFrame {
  let result = sort_compare_insertion_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_frame_sum(s : SortcompareinsertionFrame) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_frame_mean(s : SortcompareinsertionFrame) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_frame_scale(s : SortcompareinsertionFrame, f : Double) -> SortcompareinsertionFrame {
  let result = sort_compare_insertion_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_frame_add(a : SortcompareinsertionFrame, b : SortcompareinsertionFrame) -> SortcompareinsertionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_frame_copy(s : SortcompareinsertionFrame) -> SortcompareinsertionFrame {
  let result = sort_compare_insertion_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_frame_fill(s : SortcompareinsertionFrame, v : Double) -> SortcompareinsertionFrame {
  let result = sort_compare_insertion_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_frame_min(s : SortcompareinsertionFrame) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_frame_max(s : SortcompareinsertionFrame) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_frame_to_string(s : SortcompareinsertionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_table_make(size : Int) -> SortcompareinsertionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_table_len(s : SortcompareinsertionTable) -> Int { s.size }

pub fn sort_compare_insertion_table_get(s : SortcompareinsertionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_table_set(s : SortcompareinsertionTable, i : Int, v : Double) -> SortcompareinsertionTable {
  let result = sort_compare_insertion_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_table_sum(s : SortcompareinsertionTable) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_table_mean(s : SortcompareinsertionTable) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_table_scale(s : SortcompareinsertionTable, f : Double) -> SortcompareinsertionTable {
  let result = sort_compare_insertion_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_table_add(a : SortcompareinsertionTable, b : SortcompareinsertionTable) -> SortcompareinsertionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_table_copy(s : SortcompareinsertionTable) -> SortcompareinsertionTable {
  let result = sort_compare_insertion_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_table_fill(s : SortcompareinsertionTable, v : Double) -> SortcompareinsertionTable {
  let result = sort_compare_insertion_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_table_min(s : SortcompareinsertionTable) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_table_max(s : SortcompareinsertionTable) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_table_to_string(s : SortcompareinsertionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_graphn_make(size : Int) -> SortcompareinsertionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_graphn_len(s : SortcompareinsertionGraphN) -> Int { s.size }

pub fn sort_compare_insertion_graphn_get(s : SortcompareinsertionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_graphn_set(s : SortcompareinsertionGraphN, i : Int, v : Double) -> SortcompareinsertionGraphN {
  let result = sort_compare_insertion_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_graphn_sum(s : SortcompareinsertionGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_graphn_mean(s : SortcompareinsertionGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_graphn_scale(s : SortcompareinsertionGraphN, f : Double) -> SortcompareinsertionGraphN {
  let result = sort_compare_insertion_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_graphn_add(a : SortcompareinsertionGraphN, b : SortcompareinsertionGraphN) -> SortcompareinsertionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_graphn_copy(s : SortcompareinsertionGraphN) -> SortcompareinsertionGraphN {
  let result = sort_compare_insertion_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_graphn_fill(s : SortcompareinsertionGraphN, v : Double) -> SortcompareinsertionGraphN {
  let result = sort_compare_insertion_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_graphn_min(s : SortcompareinsertionGraphN) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_graphn_max(s : SortcompareinsertionGraphN) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_graphn_to_string(s : SortcompareinsertionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_node_make(size : Int) -> SortcompareinsertionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_node_len(s : SortcompareinsertionNode) -> Int { s.size }

pub fn sort_compare_insertion_node_get(s : SortcompareinsertionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_node_set(s : SortcompareinsertionNode, i : Int, v : Double) -> SortcompareinsertionNode {
  let result = sort_compare_insertion_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_node_sum(s : SortcompareinsertionNode) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_node_mean(s : SortcompareinsertionNode) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_node_scale(s : SortcompareinsertionNode, f : Double) -> SortcompareinsertionNode {
  let result = sort_compare_insertion_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_node_add(a : SortcompareinsertionNode, b : SortcompareinsertionNode) -> SortcompareinsertionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_node_copy(s : SortcompareinsertionNode) -> SortcompareinsertionNode {
  let result = sort_compare_insertion_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_node_fill(s : SortcompareinsertionNode, v : Double) -> SortcompareinsertionNode {
  let result = sort_compare_insertion_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_node_min(s : SortcompareinsertionNode) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_node_max(s : SortcompareinsertionNode) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_node_to_string(s : SortcompareinsertionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_edge_make(size : Int) -> SortcompareinsertionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_edge_len(s : SortcompareinsertionEdge) -> Int { s.size }

pub fn sort_compare_insertion_edge_get(s : SortcompareinsertionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_edge_set(s : SortcompareinsertionEdge, i : Int, v : Double) -> SortcompareinsertionEdge {
  let result = sort_compare_insertion_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_edge_sum(s : SortcompareinsertionEdge) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_edge_mean(s : SortcompareinsertionEdge) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_edge_scale(s : SortcompareinsertionEdge, f : Double) -> SortcompareinsertionEdge {
  let result = sort_compare_insertion_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_edge_add(a : SortcompareinsertionEdge, b : SortcompareinsertionEdge) -> SortcompareinsertionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_edge_copy(s : SortcompareinsertionEdge) -> SortcompareinsertionEdge {
  let result = sort_compare_insertion_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_edge_fill(s : SortcompareinsertionEdge, v : Double) -> SortcompareinsertionEdge {
  let result = sort_compare_insertion_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_edge_min(s : SortcompareinsertionEdge) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_edge_max(s : SortcompareinsertionEdge) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_edge_to_string(s : SortcompareinsertionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_path_make(size : Int) -> SortcompareinsertionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_path_len(s : SortcompareinsertionPath) -> Int { s.size }

pub fn sort_compare_insertion_path_get(s : SortcompareinsertionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_path_set(s : SortcompareinsertionPath, i : Int, v : Double) -> SortcompareinsertionPath {
  let result = sort_compare_insertion_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_path_sum(s : SortcompareinsertionPath) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_path_mean(s : SortcompareinsertionPath) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_path_scale(s : SortcompareinsertionPath, f : Double) -> SortcompareinsertionPath {
  let result = sort_compare_insertion_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_path_add(a : SortcompareinsertionPath, b : SortcompareinsertionPath) -> SortcompareinsertionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_path_copy(s : SortcompareinsertionPath) -> SortcompareinsertionPath {
  let result = sort_compare_insertion_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_path_fill(s : SortcompareinsertionPath, v : Double) -> SortcompareinsertionPath {
  let result = sort_compare_insertion_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_path_min(s : SortcompareinsertionPath) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_path_max(s : SortcompareinsertionPath) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_path_to_string(s : SortcompareinsertionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_cluster_make(size : Int) -> SortcompareinsertionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_cluster_len(s : SortcompareinsertionCluster) -> Int { s.size }

pub fn sort_compare_insertion_cluster_get(s : SortcompareinsertionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_cluster_set(s : SortcompareinsertionCluster, i : Int, v : Double) -> SortcompareinsertionCluster {
  let result = sort_compare_insertion_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_cluster_sum(s : SortcompareinsertionCluster) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_cluster_mean(s : SortcompareinsertionCluster) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_cluster_scale(s : SortcompareinsertionCluster, f : Double) -> SortcompareinsertionCluster {
  let result = sort_compare_insertion_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_cluster_add(a : SortcompareinsertionCluster, b : SortcompareinsertionCluster) -> SortcompareinsertionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_cluster_copy(s : SortcompareinsertionCluster) -> SortcompareinsertionCluster {
  let result = sort_compare_insertion_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_cluster_fill(s : SortcompareinsertionCluster, v : Double) -> SortcompareinsertionCluster {
  let result = sort_compare_insertion_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_cluster_min(s : SortcompareinsertionCluster) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_cluster_max(s : SortcompareinsertionCluster) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_cluster_to_string(s : SortcompareinsertionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_model_make(size : Int) -> SortcompareinsertionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_model_len(s : SortcompareinsertionModel) -> Int { s.size }

pub fn sort_compare_insertion_model_get(s : SortcompareinsertionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_model_set(s : SortcompareinsertionModel, i : Int, v : Double) -> SortcompareinsertionModel {
  let result = sort_compare_insertion_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_model_sum(s : SortcompareinsertionModel) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_model_mean(s : SortcompareinsertionModel) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_model_scale(s : SortcompareinsertionModel, f : Double) -> SortcompareinsertionModel {
  let result = sort_compare_insertion_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_model_add(a : SortcompareinsertionModel, b : SortcompareinsertionModel) -> SortcompareinsertionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_model_copy(s : SortcompareinsertionModel) -> SortcompareinsertionModel {
  let result = sort_compare_insertion_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_model_fill(s : SortcompareinsertionModel, v : Double) -> SortcompareinsertionModel {
  let result = sort_compare_insertion_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_model_min(s : SortcompareinsertionModel) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_model_max(s : SortcompareinsertionModel) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_model_to_string(s : SortcompareinsertionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_layer_make(size : Int) -> SortcompareinsertionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_layer_len(s : SortcompareinsertionLayer) -> Int { s.size }

pub fn sort_compare_insertion_layer_get(s : SortcompareinsertionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_layer_set(s : SortcompareinsertionLayer, i : Int, v : Double) -> SortcompareinsertionLayer {
  let result = sort_compare_insertion_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_layer_sum(s : SortcompareinsertionLayer) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_layer_mean(s : SortcompareinsertionLayer) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_layer_scale(s : SortcompareinsertionLayer, f : Double) -> SortcompareinsertionLayer {
  let result = sort_compare_insertion_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_layer_add(a : SortcompareinsertionLayer, b : SortcompareinsertionLayer) -> SortcompareinsertionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_layer_copy(s : SortcompareinsertionLayer) -> SortcompareinsertionLayer {
  let result = sort_compare_insertion_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_layer_fill(s : SortcompareinsertionLayer, v : Double) -> SortcompareinsertionLayer {
  let result = sort_compare_insertion_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_layer_min(s : SortcompareinsertionLayer) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_layer_max(s : SortcompareinsertionLayer) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_layer_to_string(s : SortcompareinsertionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_buffer_make(size : Int) -> SortcompareinsertionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_buffer_len(s : SortcompareinsertionBuffer) -> Int { s.size }

pub fn sort_compare_insertion_buffer_get(s : SortcompareinsertionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_buffer_set(s : SortcompareinsertionBuffer, i : Int, v : Double) -> SortcompareinsertionBuffer {
  let result = sort_compare_insertion_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_buffer_sum(s : SortcompareinsertionBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_buffer_mean(s : SortcompareinsertionBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_buffer_scale(s : SortcompareinsertionBuffer, f : Double) -> SortcompareinsertionBuffer {
  let result = sort_compare_insertion_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_buffer_add(a : SortcompareinsertionBuffer, b : SortcompareinsertionBuffer) -> SortcompareinsertionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_buffer_copy(s : SortcompareinsertionBuffer) -> SortcompareinsertionBuffer {
  let result = sort_compare_insertion_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_buffer_fill(s : SortcompareinsertionBuffer, v : Double) -> SortcompareinsertionBuffer {
  let result = sort_compare_insertion_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_buffer_min(s : SortcompareinsertionBuffer) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_buffer_max(s : SortcompareinsertionBuffer) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_buffer_to_string(s : SortcompareinsertionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_cursor_make(size : Int) -> SortcompareinsertionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_cursor_len(s : SortcompareinsertionCursor) -> Int { s.size }

pub fn sort_compare_insertion_cursor_get(s : SortcompareinsertionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_cursor_set(s : SortcompareinsertionCursor, i : Int, v : Double) -> SortcompareinsertionCursor {
  let result = sort_compare_insertion_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_cursor_sum(s : SortcompareinsertionCursor) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_cursor_mean(s : SortcompareinsertionCursor) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_cursor_scale(s : SortcompareinsertionCursor, f : Double) -> SortcompareinsertionCursor {
  let result = sort_compare_insertion_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_cursor_add(a : SortcompareinsertionCursor, b : SortcompareinsertionCursor) -> SortcompareinsertionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_cursor_copy(s : SortcompareinsertionCursor) -> SortcompareinsertionCursor {
  let result = sort_compare_insertion_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_cursor_fill(s : SortcompareinsertionCursor, v : Double) -> SortcompareinsertionCursor {
  let result = sort_compare_insertion_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_cursor_min(s : SortcompareinsertionCursor) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_cursor_max(s : SortcompareinsertionCursor) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_cursor_to_string(s : SortcompareinsertionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_view_make(size : Int) -> SortcompareinsertionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_view_len(s : SortcompareinsertionView) -> Int { s.size }

pub fn sort_compare_insertion_view_get(s : SortcompareinsertionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_view_set(s : SortcompareinsertionView, i : Int, v : Double) -> SortcompareinsertionView {
  let result = sort_compare_insertion_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_view_sum(s : SortcompareinsertionView) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_view_mean(s : SortcompareinsertionView) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_view_scale(s : SortcompareinsertionView, f : Double) -> SortcompareinsertionView {
  let result = sort_compare_insertion_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_view_add(a : SortcompareinsertionView, b : SortcompareinsertionView) -> SortcompareinsertionView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_view_copy(s : SortcompareinsertionView) -> SortcompareinsertionView {
  let result = sort_compare_insertion_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_view_fill(s : SortcompareinsertionView, v : Double) -> SortcompareinsertionView {
  let result = sort_compare_insertion_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_view_min(s : SortcompareinsertionView) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_view_max(s : SortcompareinsertionView) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_view_to_string(s : SortcompareinsertionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_range_make(size : Int) -> SortcompareinsertionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_range_len(s : SortcompareinsertionRange) -> Int { s.size }

pub fn sort_compare_insertion_range_get(s : SortcompareinsertionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_range_set(s : SortcompareinsertionRange, i : Int, v : Double) -> SortcompareinsertionRange {
  let result = sort_compare_insertion_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_range_sum(s : SortcompareinsertionRange) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_range_mean(s : SortcompareinsertionRange) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_range_scale(s : SortcompareinsertionRange, f : Double) -> SortcompareinsertionRange {
  let result = sort_compare_insertion_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_range_add(a : SortcompareinsertionRange, b : SortcompareinsertionRange) -> SortcompareinsertionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_range_copy(s : SortcompareinsertionRange) -> SortcompareinsertionRange {
  let result = sort_compare_insertion_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_range_fill(s : SortcompareinsertionRange, v : Double) -> SortcompareinsertionRange {
  let result = sort_compare_insertion_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_range_min(s : SortcompareinsertionRange) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_range_max(s : SortcompareinsertionRange) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_range_to_string(s : SortcompareinsertionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_slice_make(size : Int) -> SortcompareinsertionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_slice_len(s : SortcompareinsertionSlice) -> Int { s.size }

pub fn sort_compare_insertion_slice_get(s : SortcompareinsertionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_slice_set(s : SortcompareinsertionSlice, i : Int, v : Double) -> SortcompareinsertionSlice {
  let result = sort_compare_insertion_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_slice_sum(s : SortcompareinsertionSlice) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_slice_mean(s : SortcompareinsertionSlice) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_slice_scale(s : SortcompareinsertionSlice, f : Double) -> SortcompareinsertionSlice {
  let result = sort_compare_insertion_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_slice_add(a : SortcompareinsertionSlice, b : SortcompareinsertionSlice) -> SortcompareinsertionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_slice_copy(s : SortcompareinsertionSlice) -> SortcompareinsertionSlice {
  let result = sort_compare_insertion_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_slice_fill(s : SortcompareinsertionSlice, v : Double) -> SortcompareinsertionSlice {
  let result = sort_compare_insertion_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_slice_min(s : SortcompareinsertionSlice) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_slice_max(s : SortcompareinsertionSlice) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_slice_to_string(s : SortcompareinsertionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

