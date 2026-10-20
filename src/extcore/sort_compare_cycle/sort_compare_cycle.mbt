///===
/// extcore/sort_compare_cycle

pub(all) struct SortcomparecyclePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_cycle_make_point(x : Double, y : Double) -> SortcomparecyclePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_cycle_make_point3(x : Double, y : Double, z : Double) -> SortcomparecyclePoint {
  { x, y, z, label: 0 }
}

pub fn sort_compare_cycle_point_x(pt : SortcomparecyclePoint) -> Double { pt.x }

pub fn sort_compare_cycle_point_y(pt : SortcomparecyclePoint) -> Double { pt.y }

pub fn sort_compare_cycle_point_z(pt : SortcomparecyclePoint) -> Double { pt.z }

pub fn sort_compare_cycle_point_label(pt : SortcomparecyclePoint) -> Int { pt.label }

pub fn sort_compare_cycle_point_dist(a : SortcomparecyclePoint, b : SortcomparecyclePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_compare_cycle_point_add(a : SortcomparecyclePoint, b : SortcomparecyclePoint) -> SortcomparecyclePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_compare_cycle_point_sub(a : SortcomparecyclePoint, b : SortcomparecyclePoint) -> SortcomparecyclePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_compare_cycle_point_scale(pt : SortcomparecyclePoint, s : Double) -> SortcomparecyclePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_compare_cycle_point_dot(a : SortcomparecyclePoint, b : SortcomparecyclePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_compare_cycle_point_cross(a : SortcomparecyclePoint, b : SortcomparecyclePoint) -> SortcomparecyclePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_compare_cycle_point_norm(pt : SortcomparecyclePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_compare_cycle_point_normalize(pt : SortcomparecyclePoint) -> SortcomparecyclePoint {
  let n = sort_compare_cycle_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_compare_cycle_point_scale(pt, 1.0 / n) }
}

pub fn sort_compare_cycle_point_negate(pt : SortcomparecyclePoint) -> SortcomparecyclePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_compare_cycle_point_mid(a : SortcomparecyclePoint, b : SortcomparecyclePoint) -> SortcomparecyclePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_compare_cycle_point_lerp(a : SortcomparecyclePoint, b : SortcomparecyclePoint, t : Double) -> SortcomparecyclePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_compare_cycle_point_to_string(pt : SortcomparecyclePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortcomparecycleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_cycle_make_series(vals : Array[Double], name : String) -> SortcomparecycleSeries {
  { vals, name, meta: 0 }
}

pub fn sort_compare_cycle_series_len(s : SortcomparecycleSeries) -> Int { s.vals.length() }

pub fn sort_compare_cycle_series_sum(s : SortcomparecycleSeries) -> Double { @_common.sum(s.vals) }

pub fn sort_compare_cycle_series_mean(s : SortcomparecycleSeries) -> Double { @_common.mean(s.vals) }

pub fn sort_compare_cycle_series_min(s : SortcomparecycleSeries) -> Double { @_common.min(s.vals) }

pub fn sort_compare_cycle_series_max(s : SortcomparecycleSeries) -> Double { @_common.max(s.vals) }

pub fn sort_compare_cycle_series_range(s : SortcomparecycleSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn sort_compare_cycle_series_var(s : SortcomparecycleSeries) -> Double { @_common.variance(s.vals) }

pub fn sort_compare_cycle_series_std(s : SortcomparecycleSeries) -> Double { @_common.std(s.vals) }

pub fn sort_compare_cycle_series_median(s : SortcomparecycleSeries) -> Double { @_common.median(s.vals) }

pub fn sort_compare_cycle_series_scale(s : SortcomparecycleSeries, f : Double) -> SortcomparecycleSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_compare_cycle_series_add(a : SortcomparecycleSeries, b : SortcomparecycleSeries) -> SortcomparecycleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_compare_cycle_series_sub(a : SortcomparecycleSeries, b : SortcomparecycleSeries) -> SortcomparecycleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_compare_cycle_series_normalize(s : SortcomparecycleSeries) -> SortcomparecycleSeries {
  let mn = sort_compare_cycle_series_min(s)
  let mx = sort_compare_cycle_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_compare_cycle_series_cumsum(s : SortcomparecycleSeries) -> SortcomparecycleSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_compare_cycle_series_to_string(s : SortcomparecycleSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcomparecycleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_cycle_make_matrix(rows : Int, cols : Int, val : Double) -> SortcomparecycleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_cycle_matrix_identity(n : Int) -> SortcomparecycleMatrix {
  let m = sort_compare_cycle_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_compare_cycle_matrix_get(m : SortcomparecycleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_compare_cycle_matrix_transpose(m : SortcomparecycleMatrix) -> SortcomparecycleMatrix {
  let result = sort_compare_cycle_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_compare_cycle_matrix_add(a : SortcomparecycleMatrix, b : SortcomparecycleMatrix) -> SortcomparecycleMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_compare_cycle_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_compare_cycle_matrix_scale(m : SortcomparecycleMatrix, s : Double) -> SortcomparecycleMatrix {
  let result = sort_compare_cycle_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_compare_cycle_matrix_multiply(a : SortcomparecycleMatrix, b : SortcomparecycleMatrix) -> SortcomparecycleMatrix {
  if a.cols != b.rows { return sort_compare_cycle_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_compare_cycle_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_compare_cycle_matrix_trace(m : SortcomparecycleMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_compare_cycle_matrix_det(m : SortcomparecycleMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_compare_cycle_matrix_norm(m : SortcomparecycleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_compare_cycle_matrix_to_string(m : SortcomparecycleMatrix) -> String {
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

pub(all) struct SortcomparecycleVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_cycle_make_vector(comps : Array[Double]) -> SortcomparecycleVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_cycle_vector_zero(dim : Int) -> SortcomparecycleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_compare_cycle_vector_add(a : SortcomparecycleVector, b : SortcomparecycleVector) -> SortcomparecycleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_compare_cycle_vector_sub(a : SortcomparecycleVector, b : SortcomparecycleVector) -> SortcomparecycleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_compare_cycle_vector_scale(v : SortcomparecycleVector, s : Double) -> SortcomparecycleVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_compare_cycle_vector_dot(a : SortcomparecycleVector, b : SortcomparecycleVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_compare_cycle_vector_norm(v : SortcomparecycleVector) -> Double { @_common.sqrt(sort_compare_cycle_vector_dot(v, v)) }

pub fn sort_compare_cycle_vector_normalize(v : SortcomparecycleVector) -> SortcomparecycleVector {
  let n = sort_compare_cycle_vector_norm(v)
  if n < 0.0000001 { v } else { sort_compare_cycle_vector_scale(v, 1.0 / n) }
}

pub fn sort_compare_cycle_vector_dist(a : SortcomparecycleVector, b : SortcomparecycleVector) -> Double {
  sort_compare_cycle_vector_norm(sort_compare_cycle_vector_sub(a, b))
}

pub fn sort_compare_cycle_vector_to_string(v : SortcomparecycleVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_cycle_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_compare_cycle_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_compare_cycle_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_compare_cycle_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_compare_cycle_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_compare_cycle_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_compare_cycle_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_compare_cycle_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_compare_cycle_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_compare_cycle_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_compare_cycle_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_compare_cycle_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_compare_cycle_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_compare_cycle_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_compare_cycle_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_compare_cycle_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_compare_cycle_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_compare_cycle_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_compare_cycle_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_compare_cycle_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_compare_cycle_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_compare_cycle_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_compare_cycle_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_compare_cycle_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_compare_cycle_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_compare_cycle_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_compare_cycle_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_compare_cycle_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_compare_cycle_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortcomparecycleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_frame_make(size : Int) -> SortcomparecycleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_frame_len(s : SortcomparecycleFrame) -> Int { s.size }

pub fn sort_compare_cycle_frame_get(s : SortcomparecycleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_frame_set(s : SortcomparecycleFrame, i : Int, v : Double) -> SortcomparecycleFrame {
  let result = sort_compare_cycle_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_frame_sum(s : SortcomparecycleFrame) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_frame_mean(s : SortcomparecycleFrame) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_frame_scale(s : SortcomparecycleFrame, f : Double) -> SortcomparecycleFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_frame_add(a : SortcomparecycleFrame, b : SortcomparecycleFrame) -> SortcomparecycleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_frame_copy(s : SortcomparecycleFrame) -> SortcomparecycleFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_frame_fill(s : SortcomparecycleFrame, v : Double) -> SortcomparecycleFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_frame_min(s : SortcomparecycleFrame) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_frame_max(s : SortcomparecycleFrame) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_frame_to_string(s : SortcomparecycleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_table_make(size : Int) -> SortcomparecycleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_table_len(s : SortcomparecycleTable) -> Int { s.size }

pub fn sort_compare_cycle_table_get(s : SortcomparecycleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_table_set(s : SortcomparecycleTable, i : Int, v : Double) -> SortcomparecycleTable {
  let result = sort_compare_cycle_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_table_sum(s : SortcomparecycleTable) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_table_mean(s : SortcomparecycleTable) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_table_scale(s : SortcomparecycleTable, f : Double) -> SortcomparecycleTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_table_add(a : SortcomparecycleTable, b : SortcomparecycleTable) -> SortcomparecycleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_table_copy(s : SortcomparecycleTable) -> SortcomparecycleTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_table_fill(s : SortcomparecycleTable, v : Double) -> SortcomparecycleTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_table_min(s : SortcomparecycleTable) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_table_max(s : SortcomparecycleTable) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_table_to_string(s : SortcomparecycleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_graphn_make(size : Int) -> SortcomparecycleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_graphn_len(s : SortcomparecycleGraphN) -> Int { s.size }

pub fn sort_compare_cycle_graphn_get(s : SortcomparecycleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_graphn_set(s : SortcomparecycleGraphN, i : Int, v : Double) -> SortcomparecycleGraphN {
  let result = sort_compare_cycle_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_graphn_sum(s : SortcomparecycleGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_graphn_mean(s : SortcomparecycleGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_graphn_scale(s : SortcomparecycleGraphN, f : Double) -> SortcomparecycleGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_graphn_add(a : SortcomparecycleGraphN, b : SortcomparecycleGraphN) -> SortcomparecycleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_graphn_copy(s : SortcomparecycleGraphN) -> SortcomparecycleGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_graphn_fill(s : SortcomparecycleGraphN, v : Double) -> SortcomparecycleGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_graphn_min(s : SortcomparecycleGraphN) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_graphn_max(s : SortcomparecycleGraphN) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_graphn_to_string(s : SortcomparecycleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_node_make(size : Int) -> SortcomparecycleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_node_len(s : SortcomparecycleNode) -> Int { s.size }

pub fn sort_compare_cycle_node_get(s : SortcomparecycleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_node_set(s : SortcomparecycleNode, i : Int, v : Double) -> SortcomparecycleNode {
  let result = sort_compare_cycle_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_node_sum(s : SortcomparecycleNode) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_node_mean(s : SortcomparecycleNode) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_node_scale(s : SortcomparecycleNode, f : Double) -> SortcomparecycleNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_node_add(a : SortcomparecycleNode, b : SortcomparecycleNode) -> SortcomparecycleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_node_copy(s : SortcomparecycleNode) -> SortcomparecycleNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_node_fill(s : SortcomparecycleNode, v : Double) -> SortcomparecycleNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_node_min(s : SortcomparecycleNode) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_node_max(s : SortcomparecycleNode) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_node_to_string(s : SortcomparecycleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_edge_make(size : Int) -> SortcomparecycleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_edge_len(s : SortcomparecycleEdge) -> Int { s.size }

pub fn sort_compare_cycle_edge_get(s : SortcomparecycleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_edge_set(s : SortcomparecycleEdge, i : Int, v : Double) -> SortcomparecycleEdge {
  let result = sort_compare_cycle_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_edge_sum(s : SortcomparecycleEdge) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_edge_mean(s : SortcomparecycleEdge) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_edge_scale(s : SortcomparecycleEdge, f : Double) -> SortcomparecycleEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_edge_add(a : SortcomparecycleEdge, b : SortcomparecycleEdge) -> SortcomparecycleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_edge_copy(s : SortcomparecycleEdge) -> SortcomparecycleEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_edge_fill(s : SortcomparecycleEdge, v : Double) -> SortcomparecycleEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_edge_min(s : SortcomparecycleEdge) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_edge_max(s : SortcomparecycleEdge) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_edge_to_string(s : SortcomparecycleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecyclePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_path_make(size : Int) -> SortcomparecyclePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_path_len(s : SortcomparecyclePath) -> Int { s.size }

pub fn sort_compare_cycle_path_get(s : SortcomparecyclePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_path_set(s : SortcomparecyclePath, i : Int, v : Double) -> SortcomparecyclePath {
  let result = sort_compare_cycle_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_path_sum(s : SortcomparecyclePath) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_path_mean(s : SortcomparecyclePath) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_path_scale(s : SortcomparecyclePath, f : Double) -> SortcomparecyclePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_path_add(a : SortcomparecyclePath, b : SortcomparecyclePath) -> SortcomparecyclePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_path_copy(s : SortcomparecyclePath) -> SortcomparecyclePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_path_fill(s : SortcomparecyclePath, v : Double) -> SortcomparecyclePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_path_min(s : SortcomparecyclePath) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_path_max(s : SortcomparecyclePath) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_path_to_string(s : SortcomparecyclePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_cluster_make(size : Int) -> SortcomparecycleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_cluster_len(s : SortcomparecycleCluster) -> Int { s.size }

pub fn sort_compare_cycle_cluster_get(s : SortcomparecycleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_cluster_set(s : SortcomparecycleCluster, i : Int, v : Double) -> SortcomparecycleCluster {
  let result = sort_compare_cycle_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_cluster_sum(s : SortcomparecycleCluster) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_cluster_mean(s : SortcomparecycleCluster) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_cluster_scale(s : SortcomparecycleCluster, f : Double) -> SortcomparecycleCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_cluster_add(a : SortcomparecycleCluster, b : SortcomparecycleCluster) -> SortcomparecycleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_cluster_copy(s : SortcomparecycleCluster) -> SortcomparecycleCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_cluster_fill(s : SortcomparecycleCluster, v : Double) -> SortcomparecycleCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_cluster_min(s : SortcomparecycleCluster) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_cluster_max(s : SortcomparecycleCluster) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_cluster_to_string(s : SortcomparecycleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_model_make(size : Int) -> SortcomparecycleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_model_len(s : SortcomparecycleModel) -> Int { s.size }

pub fn sort_compare_cycle_model_get(s : SortcomparecycleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_model_set(s : SortcomparecycleModel, i : Int, v : Double) -> SortcomparecycleModel {
  let result = sort_compare_cycle_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_model_sum(s : SortcomparecycleModel) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_model_mean(s : SortcomparecycleModel) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_model_scale(s : SortcomparecycleModel, f : Double) -> SortcomparecycleModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_model_add(a : SortcomparecycleModel, b : SortcomparecycleModel) -> SortcomparecycleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_model_copy(s : SortcomparecycleModel) -> SortcomparecycleModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_model_fill(s : SortcomparecycleModel, v : Double) -> SortcomparecycleModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_model_min(s : SortcomparecycleModel) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_model_max(s : SortcomparecycleModel) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_model_to_string(s : SortcomparecycleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_layer_make(size : Int) -> SortcomparecycleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_layer_len(s : SortcomparecycleLayer) -> Int { s.size }

pub fn sort_compare_cycle_layer_get(s : SortcomparecycleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_layer_set(s : SortcomparecycleLayer, i : Int, v : Double) -> SortcomparecycleLayer {
  let result = sort_compare_cycle_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_layer_sum(s : SortcomparecycleLayer) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_layer_mean(s : SortcomparecycleLayer) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_layer_scale(s : SortcomparecycleLayer, f : Double) -> SortcomparecycleLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_layer_add(a : SortcomparecycleLayer, b : SortcomparecycleLayer) -> SortcomparecycleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_layer_copy(s : SortcomparecycleLayer) -> SortcomparecycleLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_layer_fill(s : SortcomparecycleLayer, v : Double) -> SortcomparecycleLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_layer_min(s : SortcomparecycleLayer) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_layer_max(s : SortcomparecycleLayer) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_layer_to_string(s : SortcomparecycleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_buffer_make(size : Int) -> SortcomparecycleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_buffer_len(s : SortcomparecycleBuffer) -> Int { s.size }

pub fn sort_compare_cycle_buffer_get(s : SortcomparecycleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_buffer_set(s : SortcomparecycleBuffer, i : Int, v : Double) -> SortcomparecycleBuffer {
  let result = sort_compare_cycle_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_buffer_sum(s : SortcomparecycleBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_buffer_mean(s : SortcomparecycleBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_buffer_scale(s : SortcomparecycleBuffer, f : Double) -> SortcomparecycleBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_buffer_add(a : SortcomparecycleBuffer, b : SortcomparecycleBuffer) -> SortcomparecycleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_buffer_copy(s : SortcomparecycleBuffer) -> SortcomparecycleBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_buffer_fill(s : SortcomparecycleBuffer, v : Double) -> SortcomparecycleBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_buffer_min(s : SortcomparecycleBuffer) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_buffer_max(s : SortcomparecycleBuffer) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_buffer_to_string(s : SortcomparecycleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_cursor_make(size : Int) -> SortcomparecycleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_cursor_len(s : SortcomparecycleCursor) -> Int { s.size }

pub fn sort_compare_cycle_cursor_get(s : SortcomparecycleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_cursor_set(s : SortcomparecycleCursor, i : Int, v : Double) -> SortcomparecycleCursor {
  let result = sort_compare_cycle_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_cursor_sum(s : SortcomparecycleCursor) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_cursor_mean(s : SortcomparecycleCursor) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_cursor_scale(s : SortcomparecycleCursor, f : Double) -> SortcomparecycleCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_cursor_add(a : SortcomparecycleCursor, b : SortcomparecycleCursor) -> SortcomparecycleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_cursor_copy(s : SortcomparecycleCursor) -> SortcomparecycleCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_cursor_fill(s : SortcomparecycleCursor, v : Double) -> SortcomparecycleCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_cursor_min(s : SortcomparecycleCursor) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_cursor_max(s : SortcomparecycleCursor) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_cursor_to_string(s : SortcomparecycleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_view_make(size : Int) -> SortcomparecycleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_view_len(s : SortcomparecycleView) -> Int { s.size }

pub fn sort_compare_cycle_view_get(s : SortcomparecycleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_view_set(s : SortcomparecycleView, i : Int, v : Double) -> SortcomparecycleView {
  let result = sort_compare_cycle_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_view_sum(s : SortcomparecycleView) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_view_mean(s : SortcomparecycleView) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_view_scale(s : SortcomparecycleView, f : Double) -> SortcomparecycleView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_view_add(a : SortcomparecycleView, b : SortcomparecycleView) -> SortcomparecycleView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_view_copy(s : SortcomparecycleView) -> SortcomparecycleView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_view_fill(s : SortcomparecycleView, v : Double) -> SortcomparecycleView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_view_min(s : SortcomparecycleView) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_view_max(s : SortcomparecycleView) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_view_to_string(s : SortcomparecycleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_range_make(size : Int) -> SortcomparecycleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_range_len(s : SortcomparecycleRange) -> Int { s.size }

pub fn sort_compare_cycle_range_get(s : SortcomparecycleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_range_set(s : SortcomparecycleRange, i : Int, v : Double) -> SortcomparecycleRange {
  let result = sort_compare_cycle_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_range_sum(s : SortcomparecycleRange) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_range_mean(s : SortcomparecycleRange) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_range_scale(s : SortcomparecycleRange, f : Double) -> SortcomparecycleRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_range_add(a : SortcomparecycleRange, b : SortcomparecycleRange) -> SortcomparecycleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_range_copy(s : SortcomparecycleRange) -> SortcomparecycleRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_range_fill(s : SortcomparecycleRange, v : Double) -> SortcomparecycleRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_range_min(s : SortcomparecycleRange) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_range_max(s : SortcomparecycleRange) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_range_to_string(s : SortcomparecycleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_slice_make(size : Int) -> SortcomparecycleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_slice_len(s : SortcomparecycleSlice) -> Int { s.size }

pub fn sort_compare_cycle_slice_get(s : SortcomparecycleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_slice_set(s : SortcomparecycleSlice, i : Int, v : Double) -> SortcomparecycleSlice {
  let result = sort_compare_cycle_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_slice_sum(s : SortcomparecycleSlice) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_slice_mean(s : SortcomparecycleSlice) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_slice_scale(s : SortcomparecycleSlice, f : Double) -> SortcomparecycleSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_slice_add(a : SortcomparecycleSlice, b : SortcomparecycleSlice) -> SortcomparecycleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_slice_copy(s : SortcomparecycleSlice) -> SortcomparecycleSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_slice_fill(s : SortcomparecycleSlice, v : Double) -> SortcomparecycleSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_slice_min(s : SortcomparecycleSlice) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_slice_max(s : SortcomparecycleSlice) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_slice_to_string(s : SortcomparecycleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

