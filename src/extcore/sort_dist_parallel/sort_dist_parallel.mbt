///===
/// extcore/sort_dist_parallel

pub(all) struct SortdistparallelPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_parallel_make_point(x : Double, y : Double) -> SortdistparallelPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_parallel_make_point3(x : Double, y : Double, z : Double) -> SortdistparallelPoint {
  { x, y, z, label: 0 }
}

pub fn sort_dist_parallel_point_x(pt : SortdistparallelPoint) -> Double { pt.x }

pub fn sort_dist_parallel_point_y(pt : SortdistparallelPoint) -> Double { pt.y }

pub fn sort_dist_parallel_point_z(pt : SortdistparallelPoint) -> Double { pt.z }

pub fn sort_dist_parallel_point_label(pt : SortdistparallelPoint) -> Int { pt.label }

pub fn sort_dist_parallel_point_dist(a : SortdistparallelPoint, b : SortdistparallelPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_dist_parallel_point_add(a : SortdistparallelPoint, b : SortdistparallelPoint) -> SortdistparallelPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_dist_parallel_point_sub(a : SortdistparallelPoint, b : SortdistparallelPoint) -> SortdistparallelPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_dist_parallel_point_scale(pt : SortdistparallelPoint, s : Double) -> SortdistparallelPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_dist_parallel_point_dot(a : SortdistparallelPoint, b : SortdistparallelPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_dist_parallel_point_cross(a : SortdistparallelPoint, b : SortdistparallelPoint) -> SortdistparallelPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_dist_parallel_point_norm(pt : SortdistparallelPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_dist_parallel_point_normalize(pt : SortdistparallelPoint) -> SortdistparallelPoint {
  let n = sort_dist_parallel_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_dist_parallel_point_scale(pt, 1.0 / n) }
}

pub fn sort_dist_parallel_point_negate(pt : SortdistparallelPoint) -> SortdistparallelPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_dist_parallel_point_mid(a : SortdistparallelPoint, b : SortdistparallelPoint) -> SortdistparallelPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_dist_parallel_point_lerp(a : SortdistparallelPoint, b : SortdistparallelPoint, t : Double) -> SortdistparallelPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_dist_parallel_point_to_string(pt : SortdistparallelPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortdistparallelSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_parallel_make_series(vals : Array[Double], name : String) -> SortdistparallelSeries {
  { vals, name, meta: 0 }
}

pub fn sort_dist_parallel_series_len(s : SortdistparallelSeries) -> Int { s.vals.length() }

pub fn sort_dist_parallel_series_sum(s : SortdistparallelSeries) -> Double { @_common.sum(s.vals) }

pub fn sort_dist_parallel_series_mean(s : SortdistparallelSeries) -> Double { @_common.mean(s.vals) }

pub fn sort_dist_parallel_series_min(s : SortdistparallelSeries) -> Double { @_common.min(s.vals) }

pub fn sort_dist_parallel_series_max(s : SortdistparallelSeries) -> Double { @_common.max(s.vals) }

pub fn sort_dist_parallel_series_range(s : SortdistparallelSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn sort_dist_parallel_series_var(s : SortdistparallelSeries) -> Double { @_common.variance(s.vals) }

pub fn sort_dist_parallel_series_std(s : SortdistparallelSeries) -> Double { @_common.std(s.vals) }

pub fn sort_dist_parallel_series_median(s : SortdistparallelSeries) -> Double { @_common.median(s.vals) }

pub fn sort_dist_parallel_series_scale(s : SortdistparallelSeries, f : Double) -> SortdistparallelSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn sort_dist_parallel_series_add(a : SortdistparallelSeries, b : SortdistparallelSeries) -> SortdistparallelSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_dist_parallel_series_sub(a : SortdistparallelSeries, b : SortdistparallelSeries) -> SortdistparallelSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_dist_parallel_series_normalize(s : SortdistparallelSeries) -> SortdistparallelSeries {
  let mn = sort_dist_parallel_series_min(s)
  let mx = sort_dist_parallel_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_dist_parallel_series_cumsum(s : SortdistparallelSeries) -> SortdistparallelSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_dist_parallel_series_to_string(s : SortdistparallelSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistparallelMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_parallel_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistparallelMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_parallel_matrix_identity(n : Int) -> SortdistparallelMatrix {
  let m = sort_dist_parallel_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_dist_parallel_matrix_get(m : SortdistparallelMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_dist_parallel_matrix_transpose(m : SortdistparallelMatrix) -> SortdistparallelMatrix {
  let result = sort_dist_parallel_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_dist_parallel_matrix_add(a : SortdistparallelMatrix, b : SortdistparallelMatrix) -> SortdistparallelMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_dist_parallel_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_dist_parallel_matrix_scale(m : SortdistparallelMatrix, s : Double) -> SortdistparallelMatrix {
  let result = sort_dist_parallel_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_dist_parallel_matrix_multiply(a : SortdistparallelMatrix, b : SortdistparallelMatrix) -> SortdistparallelMatrix {
  if a.cols != b.rows { return sort_dist_parallel_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_dist_parallel_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_dist_parallel_matrix_trace(m : SortdistparallelMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_dist_parallel_matrix_det(m : SortdistparallelMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_dist_parallel_matrix_norm(m : SortdistparallelMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_dist_parallel_matrix_to_string(m : SortdistparallelMatrix) -> String {
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

pub(all) struct SortdistparallelVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_parallel_make_vector(comps : Array[Double]) -> SortdistparallelVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_parallel_vector_zero(dim : Int) -> SortdistparallelVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_dist_parallel_vector_add(a : SortdistparallelVector, b : SortdistparallelVector) -> SortdistparallelVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn sort_dist_parallel_vector_sub(a : SortdistparallelVector, b : SortdistparallelVector) -> SortdistparallelVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn sort_dist_parallel_vector_scale(v : SortdistparallelVector, s : Double) -> SortdistparallelVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn sort_dist_parallel_vector_dot(a : SortdistparallelVector, b : SortdistparallelVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_dist_parallel_vector_norm(v : SortdistparallelVector) -> Double { @_common.sqrt(sort_dist_parallel_vector_dot(v, v)) }

pub fn sort_dist_parallel_vector_normalize(v : SortdistparallelVector) -> SortdistparallelVector {
  let n = sort_dist_parallel_vector_norm(v)
  if n < 0.0000001 { v } else { sort_dist_parallel_vector_scale(v, 1.0 / n) }
}

pub fn sort_dist_parallel_vector_dist(a : SortdistparallelVector, b : SortdistparallelVector) -> Double {
  sort_dist_parallel_vector_norm(sort_dist_parallel_vector_sub(a, b))
}

pub fn sort_dist_parallel_vector_to_string(v : SortdistparallelVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_dist_parallel_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_dist_parallel_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_dist_parallel_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_dist_parallel_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_dist_parallel_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_dist_parallel_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_dist_parallel_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_dist_parallel_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_dist_parallel_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_dist_parallel_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_dist_parallel_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_dist_parallel_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_dist_parallel_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_dist_parallel_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_dist_parallel_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_dist_parallel_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_dist_parallel_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_dist_parallel_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_dist_parallel_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_dist_parallel_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_dist_parallel_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_dist_parallel_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_dist_parallel_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_dist_parallel_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_dist_parallel_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_dist_parallel_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_dist_parallel_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_dist_parallel_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_dist_parallel_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortdistparallelFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_frame_make(size : Int) -> SortdistparallelFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_frame_len(s : SortdistparallelFrame) -> Int { s.size }

pub fn sort_dist_parallel_frame_get(s : SortdistparallelFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_frame_set(s : SortdistparallelFrame, i : Int, v : Double) -> SortdistparallelFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_frame_sum(s : SortdistparallelFrame) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_frame_mean(s : SortdistparallelFrame) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_frame_scale(s : SortdistparallelFrame, f : Double) -> SortdistparallelFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_frame_add(a : SortdistparallelFrame, b : SortdistparallelFrame) -> SortdistparallelFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_frame_copy(s : SortdistparallelFrame) -> SortdistparallelFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_frame_fill(s : SortdistparallelFrame, v : Double) -> SortdistparallelFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_frame_min(s : SortdistparallelFrame) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_frame_max(s : SortdistparallelFrame) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_frame_to_string(s : SortdistparallelFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_table_make(size : Int) -> SortdistparallelTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_table_len(s : SortdistparallelTable) -> Int { s.size }

pub fn sort_dist_parallel_table_get(s : SortdistparallelTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_table_set(s : SortdistparallelTable, i : Int, v : Double) -> SortdistparallelTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_table_sum(s : SortdistparallelTable) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_table_mean(s : SortdistparallelTable) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_table_scale(s : SortdistparallelTable, f : Double) -> SortdistparallelTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_table_add(a : SortdistparallelTable, b : SortdistparallelTable) -> SortdistparallelTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_table_copy(s : SortdistparallelTable) -> SortdistparallelTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_table_fill(s : SortdistparallelTable, v : Double) -> SortdistparallelTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_table_min(s : SortdistparallelTable) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_table_max(s : SortdistparallelTable) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_table_to_string(s : SortdistparallelTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_graphn_make(size : Int) -> SortdistparallelGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_graphn_len(s : SortdistparallelGraphN) -> Int { s.size }

pub fn sort_dist_parallel_graphn_get(s : SortdistparallelGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_graphn_set(s : SortdistparallelGraphN, i : Int, v : Double) -> SortdistparallelGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_graphn_sum(s : SortdistparallelGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_graphn_mean(s : SortdistparallelGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_graphn_scale(s : SortdistparallelGraphN, f : Double) -> SortdistparallelGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_graphn_add(a : SortdistparallelGraphN, b : SortdistparallelGraphN) -> SortdistparallelGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_graphn_copy(s : SortdistparallelGraphN) -> SortdistparallelGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_graphn_fill(s : SortdistparallelGraphN, v : Double) -> SortdistparallelGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_graphn_min(s : SortdistparallelGraphN) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_graphn_max(s : SortdistparallelGraphN) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_graphn_to_string(s : SortdistparallelGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_node_make(size : Int) -> SortdistparallelNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_node_len(s : SortdistparallelNode) -> Int { s.size }

pub fn sort_dist_parallel_node_get(s : SortdistparallelNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_node_set(s : SortdistparallelNode, i : Int, v : Double) -> SortdistparallelNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_node_sum(s : SortdistparallelNode) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_node_mean(s : SortdistparallelNode) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_node_scale(s : SortdistparallelNode, f : Double) -> SortdistparallelNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_node_add(a : SortdistparallelNode, b : SortdistparallelNode) -> SortdistparallelNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_node_copy(s : SortdistparallelNode) -> SortdistparallelNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_node_fill(s : SortdistparallelNode, v : Double) -> SortdistparallelNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_node_min(s : SortdistparallelNode) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_node_max(s : SortdistparallelNode) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_node_to_string(s : SortdistparallelNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_edge_make(size : Int) -> SortdistparallelEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_edge_len(s : SortdistparallelEdge) -> Int { s.size }

pub fn sort_dist_parallel_edge_get(s : SortdistparallelEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_edge_set(s : SortdistparallelEdge, i : Int, v : Double) -> SortdistparallelEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_edge_sum(s : SortdistparallelEdge) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_edge_mean(s : SortdistparallelEdge) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_edge_scale(s : SortdistparallelEdge, f : Double) -> SortdistparallelEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_edge_add(a : SortdistparallelEdge, b : SortdistparallelEdge) -> SortdistparallelEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_edge_copy(s : SortdistparallelEdge) -> SortdistparallelEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_edge_fill(s : SortdistparallelEdge, v : Double) -> SortdistparallelEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_edge_min(s : SortdistparallelEdge) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_edge_max(s : SortdistparallelEdge) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_edge_to_string(s : SortdistparallelEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_path_make(size : Int) -> SortdistparallelPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_path_len(s : SortdistparallelPath) -> Int { s.size }

pub fn sort_dist_parallel_path_get(s : SortdistparallelPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_path_set(s : SortdistparallelPath, i : Int, v : Double) -> SortdistparallelPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_path_sum(s : SortdistparallelPath) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_path_mean(s : SortdistparallelPath) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_path_scale(s : SortdistparallelPath, f : Double) -> SortdistparallelPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_path_add(a : SortdistparallelPath, b : SortdistparallelPath) -> SortdistparallelPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_path_copy(s : SortdistparallelPath) -> SortdistparallelPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_path_fill(s : SortdistparallelPath, v : Double) -> SortdistparallelPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_path_min(s : SortdistparallelPath) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_path_max(s : SortdistparallelPath) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_path_to_string(s : SortdistparallelPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_cluster_make(size : Int) -> SortdistparallelCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_cluster_len(s : SortdistparallelCluster) -> Int { s.size }

pub fn sort_dist_parallel_cluster_get(s : SortdistparallelCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_cluster_set(s : SortdistparallelCluster, i : Int, v : Double) -> SortdistparallelCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_cluster_sum(s : SortdistparallelCluster) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_cluster_mean(s : SortdistparallelCluster) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_cluster_scale(s : SortdistparallelCluster, f : Double) -> SortdistparallelCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_cluster_add(a : SortdistparallelCluster, b : SortdistparallelCluster) -> SortdistparallelCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_cluster_copy(s : SortdistparallelCluster) -> SortdistparallelCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_cluster_fill(s : SortdistparallelCluster, v : Double) -> SortdistparallelCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_cluster_min(s : SortdistparallelCluster) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_cluster_max(s : SortdistparallelCluster) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_cluster_to_string(s : SortdistparallelCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_model_make(size : Int) -> SortdistparallelModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_model_len(s : SortdistparallelModel) -> Int { s.size }

pub fn sort_dist_parallel_model_get(s : SortdistparallelModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_model_set(s : SortdistparallelModel, i : Int, v : Double) -> SortdistparallelModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_model_sum(s : SortdistparallelModel) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_model_mean(s : SortdistparallelModel) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_model_scale(s : SortdistparallelModel, f : Double) -> SortdistparallelModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_model_add(a : SortdistparallelModel, b : SortdistparallelModel) -> SortdistparallelModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_model_copy(s : SortdistparallelModel) -> SortdistparallelModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_model_fill(s : SortdistparallelModel, v : Double) -> SortdistparallelModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_model_min(s : SortdistparallelModel) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_model_max(s : SortdistparallelModel) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_model_to_string(s : SortdistparallelModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_layer_make(size : Int) -> SortdistparallelLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_layer_len(s : SortdistparallelLayer) -> Int { s.size }

pub fn sort_dist_parallel_layer_get(s : SortdistparallelLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_layer_set(s : SortdistparallelLayer, i : Int, v : Double) -> SortdistparallelLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_layer_sum(s : SortdistparallelLayer) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_layer_mean(s : SortdistparallelLayer) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_layer_scale(s : SortdistparallelLayer, f : Double) -> SortdistparallelLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_layer_add(a : SortdistparallelLayer, b : SortdistparallelLayer) -> SortdistparallelLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_layer_copy(s : SortdistparallelLayer) -> SortdistparallelLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_layer_fill(s : SortdistparallelLayer, v : Double) -> SortdistparallelLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_layer_min(s : SortdistparallelLayer) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_layer_max(s : SortdistparallelLayer) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_layer_to_string(s : SortdistparallelLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_buffer_make(size : Int) -> SortdistparallelBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_buffer_len(s : SortdistparallelBuffer) -> Int { s.size }

pub fn sort_dist_parallel_buffer_get(s : SortdistparallelBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_buffer_set(s : SortdistparallelBuffer, i : Int, v : Double) -> SortdistparallelBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_buffer_sum(s : SortdistparallelBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_buffer_mean(s : SortdistparallelBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_buffer_scale(s : SortdistparallelBuffer, f : Double) -> SortdistparallelBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_buffer_add(a : SortdistparallelBuffer, b : SortdistparallelBuffer) -> SortdistparallelBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_buffer_copy(s : SortdistparallelBuffer) -> SortdistparallelBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_buffer_fill(s : SortdistparallelBuffer, v : Double) -> SortdistparallelBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_buffer_min(s : SortdistparallelBuffer) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_buffer_max(s : SortdistparallelBuffer) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_buffer_to_string(s : SortdistparallelBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_cursor_make(size : Int) -> SortdistparallelCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_cursor_len(s : SortdistparallelCursor) -> Int { s.size }

pub fn sort_dist_parallel_cursor_get(s : SortdistparallelCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_cursor_set(s : SortdistparallelCursor, i : Int, v : Double) -> SortdistparallelCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_cursor_sum(s : SortdistparallelCursor) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_cursor_mean(s : SortdistparallelCursor) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_cursor_scale(s : SortdistparallelCursor, f : Double) -> SortdistparallelCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_cursor_add(a : SortdistparallelCursor, b : SortdistparallelCursor) -> SortdistparallelCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_cursor_copy(s : SortdistparallelCursor) -> SortdistparallelCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_cursor_fill(s : SortdistparallelCursor, v : Double) -> SortdistparallelCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_cursor_min(s : SortdistparallelCursor) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_cursor_max(s : SortdistparallelCursor) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_cursor_to_string(s : SortdistparallelCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_view_make(size : Int) -> SortdistparallelView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_view_len(s : SortdistparallelView) -> Int { s.size }

pub fn sort_dist_parallel_view_get(s : SortdistparallelView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_view_set(s : SortdistparallelView, i : Int, v : Double) -> SortdistparallelView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_view_sum(s : SortdistparallelView) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_view_mean(s : SortdistparallelView) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_view_scale(s : SortdistparallelView, f : Double) -> SortdistparallelView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_view_add(a : SortdistparallelView, b : SortdistparallelView) -> SortdistparallelView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_view_copy(s : SortdistparallelView) -> SortdistparallelView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_view_fill(s : SortdistparallelView, v : Double) -> SortdistparallelView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_view_min(s : SortdistparallelView) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_view_max(s : SortdistparallelView) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_view_to_string(s : SortdistparallelView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_range_make(size : Int) -> SortdistparallelRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_range_len(s : SortdistparallelRange) -> Int { s.size }

pub fn sort_dist_parallel_range_get(s : SortdistparallelRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_range_set(s : SortdistparallelRange, i : Int, v : Double) -> SortdistparallelRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_range_sum(s : SortdistparallelRange) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_range_mean(s : SortdistparallelRange) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_range_scale(s : SortdistparallelRange, f : Double) -> SortdistparallelRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_range_add(a : SortdistparallelRange, b : SortdistparallelRange) -> SortdistparallelRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_range_copy(s : SortdistparallelRange) -> SortdistparallelRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_range_fill(s : SortdistparallelRange, v : Double) -> SortdistparallelRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_range_min(s : SortdistparallelRange) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_range_max(s : SortdistparallelRange) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_range_to_string(s : SortdistparallelRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_slice_make(size : Int) -> SortdistparallelSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_slice_len(s : SortdistparallelSlice) -> Int { s.size }

pub fn sort_dist_parallel_slice_get(s : SortdistparallelSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_slice_set(s : SortdistparallelSlice, i : Int, v : Double) -> SortdistparallelSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_slice_sum(s : SortdistparallelSlice) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_slice_mean(s : SortdistparallelSlice) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_slice_scale(s : SortdistparallelSlice, f : Double) -> SortdistparallelSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_slice_add(a : SortdistparallelSlice, b : SortdistparallelSlice) -> SortdistparallelSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_slice_copy(s : SortdistparallelSlice) -> SortdistparallelSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_slice_fill(s : SortdistparallelSlice, v : Double) -> SortdistparallelSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_slice_min(s : SortdistparallelSlice) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_slice_max(s : SortdistparallelSlice) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_slice_to_string(s : SortdistparallelSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

