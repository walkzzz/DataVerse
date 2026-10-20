///===
/// extcore/sort_dist_msd

pub(all) struct SortdistmsdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_msd_make_point(x : Double, y : Double) -> SortdistmsdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_msd_make_point3(x : Double, y : Double, z : Double) -> SortdistmsdPoint {
  { x, y, z, label: 0 }
}

pub fn sort_dist_msd_point_x(pt : SortdistmsdPoint) -> Double { pt.x }

pub fn sort_dist_msd_point_y(pt : SortdistmsdPoint) -> Double { pt.y }

pub fn sort_dist_msd_point_z(pt : SortdistmsdPoint) -> Double { pt.z }

pub fn sort_dist_msd_point_label(pt : SortdistmsdPoint) -> Int { pt.label }

pub fn sort_dist_msd_point_dist(a : SortdistmsdPoint, b : SortdistmsdPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_dist_msd_point_add(a : SortdistmsdPoint, b : SortdistmsdPoint) -> SortdistmsdPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_dist_msd_point_sub(a : SortdistmsdPoint, b : SortdistmsdPoint) -> SortdistmsdPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_dist_msd_point_scale(pt : SortdistmsdPoint, s : Double) -> SortdistmsdPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_dist_msd_point_dot(a : SortdistmsdPoint, b : SortdistmsdPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_dist_msd_point_cross(a : SortdistmsdPoint, b : SortdistmsdPoint) -> SortdistmsdPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_dist_msd_point_norm(pt : SortdistmsdPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_dist_msd_point_normalize(pt : SortdistmsdPoint) -> SortdistmsdPoint {
  let n = sort_dist_msd_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_dist_msd_point_scale(pt, 1.0 / n) }
}

pub fn sort_dist_msd_point_negate(pt : SortdistmsdPoint) -> SortdistmsdPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_dist_msd_point_mid(a : SortdistmsdPoint, b : SortdistmsdPoint) -> SortdistmsdPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_dist_msd_point_lerp(a : SortdistmsdPoint, b : SortdistmsdPoint, t : Double) -> SortdistmsdPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_dist_msd_point_to_string(pt : SortdistmsdPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortdistmsdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_msd_make_series(vals : Array[Double], name : String) -> SortdistmsdSeries {
  { vals, name, meta: 0 }
}

pub fn sort_dist_msd_series_len(s : SortdistmsdSeries) -> Int { s.vals.length() }

pub fn sort_dist_msd_series_sum(s : SortdistmsdSeries) -> Double { @_common.sum(s.vals) }

pub fn sort_dist_msd_series_mean(s : SortdistmsdSeries) -> Double { @_common.mean(s.vals) }

pub fn sort_dist_msd_series_min(s : SortdistmsdSeries) -> Double { @_common.min(s.vals) }

pub fn sort_dist_msd_series_max(s : SortdistmsdSeries) -> Double { @_common.max(s.vals) }

pub fn sort_dist_msd_series_range(s : SortdistmsdSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn sort_dist_msd_series_var(s : SortdistmsdSeries) -> Double { @_common.variance(s.vals) }

pub fn sort_dist_msd_series_std(s : SortdistmsdSeries) -> Double { @_common.std(s.vals) }

pub fn sort_dist_msd_series_median(s : SortdistmsdSeries) -> Double { @_common.median(s.vals) }

pub fn sort_dist_msd_series_scale(s : SortdistmsdSeries, f : Double) -> SortdistmsdSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn sort_dist_msd_series_add(a : SortdistmsdSeries, b : SortdistmsdSeries) -> SortdistmsdSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_dist_msd_series_sub(a : SortdistmsdSeries, b : SortdistmsdSeries) -> SortdistmsdSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_dist_msd_series_normalize(s : SortdistmsdSeries) -> SortdistmsdSeries {
  let mn = sort_dist_msd_series_min(s)
  let mx = sort_dist_msd_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_dist_msd_series_cumsum(s : SortdistmsdSeries) -> SortdistmsdSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_dist_msd_series_to_string(s : SortdistmsdSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistmsdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_msd_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistmsdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_msd_matrix_identity(n : Int) -> SortdistmsdMatrix {
  let m = sort_dist_msd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_dist_msd_matrix_get(m : SortdistmsdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_dist_msd_matrix_transpose(m : SortdistmsdMatrix) -> SortdistmsdMatrix {
  let result = sort_dist_msd_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_dist_msd_matrix_add(a : SortdistmsdMatrix, b : SortdistmsdMatrix) -> SortdistmsdMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_dist_msd_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_dist_msd_matrix_scale(m : SortdistmsdMatrix, s : Double) -> SortdistmsdMatrix {
  let result = sort_dist_msd_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_dist_msd_matrix_multiply(a : SortdistmsdMatrix, b : SortdistmsdMatrix) -> SortdistmsdMatrix {
  if a.cols != b.rows { return sort_dist_msd_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_dist_msd_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_dist_msd_matrix_trace(m : SortdistmsdMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_dist_msd_matrix_det(m : SortdistmsdMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_dist_msd_matrix_norm(m : SortdistmsdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_dist_msd_matrix_to_string(m : SortdistmsdMatrix) -> String {
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

pub(all) struct SortdistmsdVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_msd_make_vector(comps : Array[Double]) -> SortdistmsdVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_msd_vector_zero(dim : Int) -> SortdistmsdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_dist_msd_vector_add(a : SortdistmsdVector, b : SortdistmsdVector) -> SortdistmsdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn sort_dist_msd_vector_sub(a : SortdistmsdVector, b : SortdistmsdVector) -> SortdistmsdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn sort_dist_msd_vector_scale(v : SortdistmsdVector, s : Double) -> SortdistmsdVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn sort_dist_msd_vector_dot(a : SortdistmsdVector, b : SortdistmsdVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_dist_msd_vector_norm(v : SortdistmsdVector) -> Double { @_common.sqrt(sort_dist_msd_vector_dot(v, v)) }

pub fn sort_dist_msd_vector_normalize(v : SortdistmsdVector) -> SortdistmsdVector {
  let n = sort_dist_msd_vector_norm(v)
  if n < 0.0000001 { v } else { sort_dist_msd_vector_scale(v, 1.0 / n) }
}

pub fn sort_dist_msd_vector_dist(a : SortdistmsdVector, b : SortdistmsdVector) -> Double {
  sort_dist_msd_vector_norm(sort_dist_msd_vector_sub(a, b))
}

pub fn sort_dist_msd_vector_to_string(v : SortdistmsdVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_dist_msd_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_dist_msd_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_dist_msd_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_dist_msd_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_dist_msd_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_dist_msd_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_dist_msd_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_dist_msd_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_dist_msd_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_dist_msd_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_dist_msd_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_dist_msd_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_dist_msd_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_dist_msd_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_dist_msd_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_dist_msd_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_dist_msd_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_dist_msd_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_dist_msd_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_dist_msd_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_dist_msd_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_dist_msd_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_dist_msd_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_dist_msd_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_dist_msd_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_dist_msd_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_dist_msd_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_dist_msd_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_dist_msd_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortdistmsdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_frame_make(size : Int) -> SortdistmsdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_msd_frame_len(s : SortdistmsdFrame) -> Int { s.size }

pub fn sort_dist_msd_frame_get(s : SortdistmsdFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_msd_frame_set(s : SortdistmsdFrame, i : Int, v : Double) -> SortdistmsdFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_frame_sum(s : SortdistmsdFrame) -> Double { @_common.sum(s.data) }

pub fn sort_dist_msd_frame_mean(s : SortdistmsdFrame) -> Double { @_common.mean(s.data) }

pub fn sort_dist_msd_frame_scale(s : SortdistmsdFrame, f : Double) -> SortdistmsdFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_frame_add(a : SortdistmsdFrame, b : SortdistmsdFrame) -> SortdistmsdFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_msd_frame_copy(s : SortdistmsdFrame) -> SortdistmsdFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_frame_fill(s : SortdistmsdFrame, v : Double) -> SortdistmsdFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_frame_min(s : SortdistmsdFrame) -> Double { @_common.min(s.data) }

pub fn sort_dist_msd_frame_max(s : SortdistmsdFrame) -> Double { @_common.max(s.data) }

pub fn sort_dist_msd_frame_to_string(s : SortdistmsdFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistmsdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_table_make(size : Int) -> SortdistmsdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_msd_table_len(s : SortdistmsdTable) -> Int { s.size }

pub fn sort_dist_msd_table_get(s : SortdistmsdTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_msd_table_set(s : SortdistmsdTable, i : Int, v : Double) -> SortdistmsdTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_table_sum(s : SortdistmsdTable) -> Double { @_common.sum(s.data) }

pub fn sort_dist_msd_table_mean(s : SortdistmsdTable) -> Double { @_common.mean(s.data) }

pub fn sort_dist_msd_table_scale(s : SortdistmsdTable, f : Double) -> SortdistmsdTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_table_add(a : SortdistmsdTable, b : SortdistmsdTable) -> SortdistmsdTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_msd_table_copy(s : SortdistmsdTable) -> SortdistmsdTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_table_fill(s : SortdistmsdTable, v : Double) -> SortdistmsdTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_table_min(s : SortdistmsdTable) -> Double { @_common.min(s.data) }

pub fn sort_dist_msd_table_max(s : SortdistmsdTable) -> Double { @_common.max(s.data) }

pub fn sort_dist_msd_table_to_string(s : SortdistmsdTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistmsdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_graphn_make(size : Int) -> SortdistmsdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_msd_graphn_len(s : SortdistmsdGraphN) -> Int { s.size }

pub fn sort_dist_msd_graphn_get(s : SortdistmsdGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_msd_graphn_set(s : SortdistmsdGraphN, i : Int, v : Double) -> SortdistmsdGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_graphn_sum(s : SortdistmsdGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_dist_msd_graphn_mean(s : SortdistmsdGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_dist_msd_graphn_scale(s : SortdistmsdGraphN, f : Double) -> SortdistmsdGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_graphn_add(a : SortdistmsdGraphN, b : SortdistmsdGraphN) -> SortdistmsdGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_msd_graphn_copy(s : SortdistmsdGraphN) -> SortdistmsdGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_graphn_fill(s : SortdistmsdGraphN, v : Double) -> SortdistmsdGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_graphn_min(s : SortdistmsdGraphN) -> Double { @_common.min(s.data) }

pub fn sort_dist_msd_graphn_max(s : SortdistmsdGraphN) -> Double { @_common.max(s.data) }

pub fn sort_dist_msd_graphn_to_string(s : SortdistmsdGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistmsdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_node_make(size : Int) -> SortdistmsdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_msd_node_len(s : SortdistmsdNode) -> Int { s.size }

pub fn sort_dist_msd_node_get(s : SortdistmsdNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_msd_node_set(s : SortdistmsdNode, i : Int, v : Double) -> SortdistmsdNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_node_sum(s : SortdistmsdNode) -> Double { @_common.sum(s.data) }

pub fn sort_dist_msd_node_mean(s : SortdistmsdNode) -> Double { @_common.mean(s.data) }

pub fn sort_dist_msd_node_scale(s : SortdistmsdNode, f : Double) -> SortdistmsdNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_node_add(a : SortdistmsdNode, b : SortdistmsdNode) -> SortdistmsdNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_msd_node_copy(s : SortdistmsdNode) -> SortdistmsdNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_node_fill(s : SortdistmsdNode, v : Double) -> SortdistmsdNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_node_min(s : SortdistmsdNode) -> Double { @_common.min(s.data) }

pub fn sort_dist_msd_node_max(s : SortdistmsdNode) -> Double { @_common.max(s.data) }

pub fn sort_dist_msd_node_to_string(s : SortdistmsdNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistmsdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_edge_make(size : Int) -> SortdistmsdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_msd_edge_len(s : SortdistmsdEdge) -> Int { s.size }

pub fn sort_dist_msd_edge_get(s : SortdistmsdEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_msd_edge_set(s : SortdistmsdEdge, i : Int, v : Double) -> SortdistmsdEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_edge_sum(s : SortdistmsdEdge) -> Double { @_common.sum(s.data) }

pub fn sort_dist_msd_edge_mean(s : SortdistmsdEdge) -> Double { @_common.mean(s.data) }

pub fn sort_dist_msd_edge_scale(s : SortdistmsdEdge, f : Double) -> SortdistmsdEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_edge_add(a : SortdistmsdEdge, b : SortdistmsdEdge) -> SortdistmsdEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_msd_edge_copy(s : SortdistmsdEdge) -> SortdistmsdEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_edge_fill(s : SortdistmsdEdge, v : Double) -> SortdistmsdEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_edge_min(s : SortdistmsdEdge) -> Double { @_common.min(s.data) }

pub fn sort_dist_msd_edge_max(s : SortdistmsdEdge) -> Double { @_common.max(s.data) }

pub fn sort_dist_msd_edge_to_string(s : SortdistmsdEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistmsdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_path_make(size : Int) -> SortdistmsdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_msd_path_len(s : SortdistmsdPath) -> Int { s.size }

pub fn sort_dist_msd_path_get(s : SortdistmsdPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_msd_path_set(s : SortdistmsdPath, i : Int, v : Double) -> SortdistmsdPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_path_sum(s : SortdistmsdPath) -> Double { @_common.sum(s.data) }

pub fn sort_dist_msd_path_mean(s : SortdistmsdPath) -> Double { @_common.mean(s.data) }

pub fn sort_dist_msd_path_scale(s : SortdistmsdPath, f : Double) -> SortdistmsdPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_path_add(a : SortdistmsdPath, b : SortdistmsdPath) -> SortdistmsdPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_msd_path_copy(s : SortdistmsdPath) -> SortdistmsdPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_path_fill(s : SortdistmsdPath, v : Double) -> SortdistmsdPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_path_min(s : SortdistmsdPath) -> Double { @_common.min(s.data) }

pub fn sort_dist_msd_path_max(s : SortdistmsdPath) -> Double { @_common.max(s.data) }

pub fn sort_dist_msd_path_to_string(s : SortdistmsdPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistmsdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_cluster_make(size : Int) -> SortdistmsdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_msd_cluster_len(s : SortdistmsdCluster) -> Int { s.size }

pub fn sort_dist_msd_cluster_get(s : SortdistmsdCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_msd_cluster_set(s : SortdistmsdCluster, i : Int, v : Double) -> SortdistmsdCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_cluster_sum(s : SortdistmsdCluster) -> Double { @_common.sum(s.data) }

pub fn sort_dist_msd_cluster_mean(s : SortdistmsdCluster) -> Double { @_common.mean(s.data) }

pub fn sort_dist_msd_cluster_scale(s : SortdistmsdCluster, f : Double) -> SortdistmsdCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_cluster_add(a : SortdistmsdCluster, b : SortdistmsdCluster) -> SortdistmsdCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_msd_cluster_copy(s : SortdistmsdCluster) -> SortdistmsdCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_cluster_fill(s : SortdistmsdCluster, v : Double) -> SortdistmsdCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_cluster_min(s : SortdistmsdCluster) -> Double { @_common.min(s.data) }

pub fn sort_dist_msd_cluster_max(s : SortdistmsdCluster) -> Double { @_common.max(s.data) }

pub fn sort_dist_msd_cluster_to_string(s : SortdistmsdCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistmsdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_model_make(size : Int) -> SortdistmsdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_msd_model_len(s : SortdistmsdModel) -> Int { s.size }

pub fn sort_dist_msd_model_get(s : SortdistmsdModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_msd_model_set(s : SortdistmsdModel, i : Int, v : Double) -> SortdistmsdModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_model_sum(s : SortdistmsdModel) -> Double { @_common.sum(s.data) }

pub fn sort_dist_msd_model_mean(s : SortdistmsdModel) -> Double { @_common.mean(s.data) }

pub fn sort_dist_msd_model_scale(s : SortdistmsdModel, f : Double) -> SortdistmsdModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_model_add(a : SortdistmsdModel, b : SortdistmsdModel) -> SortdistmsdModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_msd_model_copy(s : SortdistmsdModel) -> SortdistmsdModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_model_fill(s : SortdistmsdModel, v : Double) -> SortdistmsdModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_model_min(s : SortdistmsdModel) -> Double { @_common.min(s.data) }

pub fn sort_dist_msd_model_max(s : SortdistmsdModel) -> Double { @_common.max(s.data) }

pub fn sort_dist_msd_model_to_string(s : SortdistmsdModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistmsdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_layer_make(size : Int) -> SortdistmsdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_msd_layer_len(s : SortdistmsdLayer) -> Int { s.size }

pub fn sort_dist_msd_layer_get(s : SortdistmsdLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_msd_layer_set(s : SortdistmsdLayer, i : Int, v : Double) -> SortdistmsdLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_layer_sum(s : SortdistmsdLayer) -> Double { @_common.sum(s.data) }

pub fn sort_dist_msd_layer_mean(s : SortdistmsdLayer) -> Double { @_common.mean(s.data) }

pub fn sort_dist_msd_layer_scale(s : SortdistmsdLayer, f : Double) -> SortdistmsdLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_layer_add(a : SortdistmsdLayer, b : SortdistmsdLayer) -> SortdistmsdLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_msd_layer_copy(s : SortdistmsdLayer) -> SortdistmsdLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_layer_fill(s : SortdistmsdLayer, v : Double) -> SortdistmsdLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_layer_min(s : SortdistmsdLayer) -> Double { @_common.min(s.data) }

pub fn sort_dist_msd_layer_max(s : SortdistmsdLayer) -> Double { @_common.max(s.data) }

pub fn sort_dist_msd_layer_to_string(s : SortdistmsdLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistmsdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_buffer_make(size : Int) -> SortdistmsdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_msd_buffer_len(s : SortdistmsdBuffer) -> Int { s.size }

pub fn sort_dist_msd_buffer_get(s : SortdistmsdBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_msd_buffer_set(s : SortdistmsdBuffer, i : Int, v : Double) -> SortdistmsdBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_buffer_sum(s : SortdistmsdBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_dist_msd_buffer_mean(s : SortdistmsdBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_dist_msd_buffer_scale(s : SortdistmsdBuffer, f : Double) -> SortdistmsdBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_buffer_add(a : SortdistmsdBuffer, b : SortdistmsdBuffer) -> SortdistmsdBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_msd_buffer_copy(s : SortdistmsdBuffer) -> SortdistmsdBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_buffer_fill(s : SortdistmsdBuffer, v : Double) -> SortdistmsdBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_buffer_min(s : SortdistmsdBuffer) -> Double { @_common.min(s.data) }

pub fn sort_dist_msd_buffer_max(s : SortdistmsdBuffer) -> Double { @_common.max(s.data) }

pub fn sort_dist_msd_buffer_to_string(s : SortdistmsdBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistmsdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_cursor_make(size : Int) -> SortdistmsdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_msd_cursor_len(s : SortdistmsdCursor) -> Int { s.size }

pub fn sort_dist_msd_cursor_get(s : SortdistmsdCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_msd_cursor_set(s : SortdistmsdCursor, i : Int, v : Double) -> SortdistmsdCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_cursor_sum(s : SortdistmsdCursor) -> Double { @_common.sum(s.data) }

pub fn sort_dist_msd_cursor_mean(s : SortdistmsdCursor) -> Double { @_common.mean(s.data) }

pub fn sort_dist_msd_cursor_scale(s : SortdistmsdCursor, f : Double) -> SortdistmsdCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_cursor_add(a : SortdistmsdCursor, b : SortdistmsdCursor) -> SortdistmsdCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_msd_cursor_copy(s : SortdistmsdCursor) -> SortdistmsdCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_cursor_fill(s : SortdistmsdCursor, v : Double) -> SortdistmsdCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_cursor_min(s : SortdistmsdCursor) -> Double { @_common.min(s.data) }

pub fn sort_dist_msd_cursor_max(s : SortdistmsdCursor) -> Double { @_common.max(s.data) }

pub fn sort_dist_msd_cursor_to_string(s : SortdistmsdCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistmsdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_view_make(size : Int) -> SortdistmsdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_msd_view_len(s : SortdistmsdView) -> Int { s.size }

pub fn sort_dist_msd_view_get(s : SortdistmsdView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_msd_view_set(s : SortdistmsdView, i : Int, v : Double) -> SortdistmsdView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_view_sum(s : SortdistmsdView) -> Double { @_common.sum(s.data) }

pub fn sort_dist_msd_view_mean(s : SortdistmsdView) -> Double { @_common.mean(s.data) }

pub fn sort_dist_msd_view_scale(s : SortdistmsdView, f : Double) -> SortdistmsdView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_view_add(a : SortdistmsdView, b : SortdistmsdView) -> SortdistmsdView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_msd_view_copy(s : SortdistmsdView) -> SortdistmsdView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_view_fill(s : SortdistmsdView, v : Double) -> SortdistmsdView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_view_min(s : SortdistmsdView) -> Double { @_common.min(s.data) }

pub fn sort_dist_msd_view_max(s : SortdistmsdView) -> Double { @_common.max(s.data) }

pub fn sort_dist_msd_view_to_string(s : SortdistmsdView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistmsdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_range_make(size : Int) -> SortdistmsdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_msd_range_len(s : SortdistmsdRange) -> Int { s.size }

pub fn sort_dist_msd_range_get(s : SortdistmsdRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_msd_range_set(s : SortdistmsdRange, i : Int, v : Double) -> SortdistmsdRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_range_sum(s : SortdistmsdRange) -> Double { @_common.sum(s.data) }

pub fn sort_dist_msd_range_mean(s : SortdistmsdRange) -> Double { @_common.mean(s.data) }

pub fn sort_dist_msd_range_scale(s : SortdistmsdRange, f : Double) -> SortdistmsdRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_range_add(a : SortdistmsdRange, b : SortdistmsdRange) -> SortdistmsdRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_msd_range_copy(s : SortdistmsdRange) -> SortdistmsdRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_range_fill(s : SortdistmsdRange, v : Double) -> SortdistmsdRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_range_min(s : SortdistmsdRange) -> Double { @_common.min(s.data) }

pub fn sort_dist_msd_range_max(s : SortdistmsdRange) -> Double { @_common.max(s.data) }

pub fn sort_dist_msd_range_to_string(s : SortdistmsdRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistmsdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_slice_make(size : Int) -> SortdistmsdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_msd_slice_len(s : SortdistmsdSlice) -> Int { s.size }

pub fn sort_dist_msd_slice_get(s : SortdistmsdSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_msd_slice_set(s : SortdistmsdSlice, i : Int, v : Double) -> SortdistmsdSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_slice_sum(s : SortdistmsdSlice) -> Double { @_common.sum(s.data) }

pub fn sort_dist_msd_slice_mean(s : SortdistmsdSlice) -> Double { @_common.mean(s.data) }

pub fn sort_dist_msd_slice_scale(s : SortdistmsdSlice, f : Double) -> SortdistmsdSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_slice_add(a : SortdistmsdSlice, b : SortdistmsdSlice) -> SortdistmsdSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_msd_slice_copy(s : SortdistmsdSlice) -> SortdistmsdSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_slice_fill(s : SortdistmsdSlice, v : Double) -> SortdistmsdSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_msd_slice_min(s : SortdistmsdSlice) -> Double { @_common.min(s.data) }

pub fn sort_dist_msd_slice_max(s : SortdistmsdSlice) -> Double { @_common.max(s.data) }

pub fn sort_dist_msd_slice_to_string(s : SortdistmsdSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

