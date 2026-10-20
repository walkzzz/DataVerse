///===
/// extcore/sort_dist_proxmap

pub(all) struct SortdistproxmapPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_proxmap_make_point(x : Double, y : Double) -> SortdistproxmapPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_proxmap_make_point3(x : Double, y : Double, z : Double) -> SortdistproxmapPoint {
  { x, y, z, label: 0 }
}

pub fn sort_dist_proxmap_point_x(pt : SortdistproxmapPoint) -> Double { pt.x }

pub fn sort_dist_proxmap_point_y(pt : SortdistproxmapPoint) -> Double { pt.y }

pub fn sort_dist_proxmap_point_z(pt : SortdistproxmapPoint) -> Double { pt.z }

pub fn sort_dist_proxmap_point_label(pt : SortdistproxmapPoint) -> Int { pt.label }

pub fn sort_dist_proxmap_point_dist(a : SortdistproxmapPoint, b : SortdistproxmapPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_dist_proxmap_point_add(a : SortdistproxmapPoint, b : SortdistproxmapPoint) -> SortdistproxmapPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_dist_proxmap_point_sub(a : SortdistproxmapPoint, b : SortdistproxmapPoint) -> SortdistproxmapPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_dist_proxmap_point_scale(pt : SortdistproxmapPoint, s : Double) -> SortdistproxmapPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_dist_proxmap_point_dot(a : SortdistproxmapPoint, b : SortdistproxmapPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_dist_proxmap_point_cross(a : SortdistproxmapPoint, b : SortdistproxmapPoint) -> SortdistproxmapPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_dist_proxmap_point_norm(pt : SortdistproxmapPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_dist_proxmap_point_normalize(pt : SortdistproxmapPoint) -> SortdistproxmapPoint {
  let n = sort_dist_proxmap_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_dist_proxmap_point_scale(pt, 1.0 / n) }
}

pub fn sort_dist_proxmap_point_negate(pt : SortdistproxmapPoint) -> SortdistproxmapPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_dist_proxmap_point_mid(a : SortdistproxmapPoint, b : SortdistproxmapPoint) -> SortdistproxmapPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_dist_proxmap_point_lerp(a : SortdistproxmapPoint, b : SortdistproxmapPoint, t : Double) -> SortdistproxmapPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_dist_proxmap_point_to_string(pt : SortdistproxmapPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortdistproxmapSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_proxmap_make_series(vals : Array[Double], name : String) -> SortdistproxmapSeries {
  { vals, name, meta: 0 }
}

pub fn sort_dist_proxmap_series_len(s : SortdistproxmapSeries) -> Int { s.vals.length() }

pub fn sort_dist_proxmap_series_sum(s : SortdistproxmapSeries) -> Double { @_common.sum(s.vals) }

pub fn sort_dist_proxmap_series_mean(s : SortdistproxmapSeries) -> Double { @_common.mean(s.vals) }

pub fn sort_dist_proxmap_series_min(s : SortdistproxmapSeries) -> Double { @_common.min(s.vals) }

pub fn sort_dist_proxmap_series_max(s : SortdistproxmapSeries) -> Double { @_common.max(s.vals) }

pub fn sort_dist_proxmap_series_range(s : SortdistproxmapSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn sort_dist_proxmap_series_var(s : SortdistproxmapSeries) -> Double { @_common.variance(s.vals) }

pub fn sort_dist_proxmap_series_std(s : SortdistproxmapSeries) -> Double { @_common.std(s.vals) }

pub fn sort_dist_proxmap_series_median(s : SortdistproxmapSeries) -> Double { @_common.median(s.vals) }

pub fn sort_dist_proxmap_series_scale(s : SortdistproxmapSeries, f : Double) -> SortdistproxmapSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn sort_dist_proxmap_series_add(a : SortdistproxmapSeries, b : SortdistproxmapSeries) -> SortdistproxmapSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_dist_proxmap_series_sub(a : SortdistproxmapSeries, b : SortdistproxmapSeries) -> SortdistproxmapSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_dist_proxmap_series_normalize(s : SortdistproxmapSeries) -> SortdistproxmapSeries {
  let mn = sort_dist_proxmap_series_min(s)
  let mx = sort_dist_proxmap_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_dist_proxmap_series_cumsum(s : SortdistproxmapSeries) -> SortdistproxmapSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_dist_proxmap_series_to_string(s : SortdistproxmapSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistproxmapMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_proxmap_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistproxmapMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_proxmap_matrix_identity(n : Int) -> SortdistproxmapMatrix {
  let m = sort_dist_proxmap_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_dist_proxmap_matrix_get(m : SortdistproxmapMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_dist_proxmap_matrix_transpose(m : SortdistproxmapMatrix) -> SortdistproxmapMatrix {
  let result = sort_dist_proxmap_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_dist_proxmap_matrix_add(a : SortdistproxmapMatrix, b : SortdistproxmapMatrix) -> SortdistproxmapMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_dist_proxmap_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_dist_proxmap_matrix_scale(m : SortdistproxmapMatrix, s : Double) -> SortdistproxmapMatrix {
  let result = sort_dist_proxmap_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_dist_proxmap_matrix_multiply(a : SortdistproxmapMatrix, b : SortdistproxmapMatrix) -> SortdistproxmapMatrix {
  if a.cols != b.rows { return sort_dist_proxmap_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_dist_proxmap_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_dist_proxmap_matrix_trace(m : SortdistproxmapMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_dist_proxmap_matrix_det(m : SortdistproxmapMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_dist_proxmap_matrix_norm(m : SortdistproxmapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_dist_proxmap_matrix_to_string(m : SortdistproxmapMatrix) -> String {
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

pub(all) struct SortdistproxmapVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_proxmap_make_vector(comps : Array[Double]) -> SortdistproxmapVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_proxmap_vector_zero(dim : Int) -> SortdistproxmapVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_dist_proxmap_vector_add(a : SortdistproxmapVector, b : SortdistproxmapVector) -> SortdistproxmapVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn sort_dist_proxmap_vector_sub(a : SortdistproxmapVector, b : SortdistproxmapVector) -> SortdistproxmapVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn sort_dist_proxmap_vector_scale(v : SortdistproxmapVector, s : Double) -> SortdistproxmapVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn sort_dist_proxmap_vector_dot(a : SortdistproxmapVector, b : SortdistproxmapVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_dist_proxmap_vector_norm(v : SortdistproxmapVector) -> Double { @_common.sqrt(sort_dist_proxmap_vector_dot(v, v)) }

pub fn sort_dist_proxmap_vector_normalize(v : SortdistproxmapVector) -> SortdistproxmapVector {
  let n = sort_dist_proxmap_vector_norm(v)
  if n < 0.0000001 { v } else { sort_dist_proxmap_vector_scale(v, 1.0 / n) }
}

pub fn sort_dist_proxmap_vector_dist(a : SortdistproxmapVector, b : SortdistproxmapVector) -> Double {
  sort_dist_proxmap_vector_norm(sort_dist_proxmap_vector_sub(a, b))
}

pub fn sort_dist_proxmap_vector_to_string(v : SortdistproxmapVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_dist_proxmap_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_dist_proxmap_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_dist_proxmap_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_dist_proxmap_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_dist_proxmap_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_dist_proxmap_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_dist_proxmap_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_dist_proxmap_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_dist_proxmap_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_dist_proxmap_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_dist_proxmap_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_dist_proxmap_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_dist_proxmap_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_dist_proxmap_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_dist_proxmap_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_dist_proxmap_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_dist_proxmap_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_dist_proxmap_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_dist_proxmap_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_dist_proxmap_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_dist_proxmap_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_dist_proxmap_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_dist_proxmap_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_dist_proxmap_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_dist_proxmap_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_dist_proxmap_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_dist_proxmap_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_dist_proxmap_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_dist_proxmap_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortdistproxmapFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_frame_make(size : Int) -> SortdistproxmapFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_frame_len(s : SortdistproxmapFrame) -> Int { s.size }

pub fn sort_dist_proxmap_frame_get(s : SortdistproxmapFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_frame_set(s : SortdistproxmapFrame, i : Int, v : Double) -> SortdistproxmapFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_frame_sum(s : SortdistproxmapFrame) -> Double { @_common.sum(s.data) }

pub fn sort_dist_proxmap_frame_mean(s : SortdistproxmapFrame) -> Double { @_common.mean(s.data) }

pub fn sort_dist_proxmap_frame_scale(s : SortdistproxmapFrame, f : Double) -> SortdistproxmapFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_frame_add(a : SortdistproxmapFrame, b : SortdistproxmapFrame) -> SortdistproxmapFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_proxmap_frame_copy(s : SortdistproxmapFrame) -> SortdistproxmapFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_frame_fill(s : SortdistproxmapFrame, v : Double) -> SortdistproxmapFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_frame_min(s : SortdistproxmapFrame) -> Double { @_common.min(s.data) }

pub fn sort_dist_proxmap_frame_max(s : SortdistproxmapFrame) -> Double { @_common.max(s.data) }

pub fn sort_dist_proxmap_frame_to_string(s : SortdistproxmapFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_table_make(size : Int) -> SortdistproxmapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_table_len(s : SortdistproxmapTable) -> Int { s.size }

pub fn sort_dist_proxmap_table_get(s : SortdistproxmapTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_table_set(s : SortdistproxmapTable, i : Int, v : Double) -> SortdistproxmapTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_table_sum(s : SortdistproxmapTable) -> Double { @_common.sum(s.data) }

pub fn sort_dist_proxmap_table_mean(s : SortdistproxmapTable) -> Double { @_common.mean(s.data) }

pub fn sort_dist_proxmap_table_scale(s : SortdistproxmapTable, f : Double) -> SortdistproxmapTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_table_add(a : SortdistproxmapTable, b : SortdistproxmapTable) -> SortdistproxmapTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_proxmap_table_copy(s : SortdistproxmapTable) -> SortdistproxmapTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_table_fill(s : SortdistproxmapTable, v : Double) -> SortdistproxmapTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_table_min(s : SortdistproxmapTable) -> Double { @_common.min(s.data) }

pub fn sort_dist_proxmap_table_max(s : SortdistproxmapTable) -> Double { @_common.max(s.data) }

pub fn sort_dist_proxmap_table_to_string(s : SortdistproxmapTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_graphn_make(size : Int) -> SortdistproxmapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_graphn_len(s : SortdistproxmapGraphN) -> Int { s.size }

pub fn sort_dist_proxmap_graphn_get(s : SortdistproxmapGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_graphn_set(s : SortdistproxmapGraphN, i : Int, v : Double) -> SortdistproxmapGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_graphn_sum(s : SortdistproxmapGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_dist_proxmap_graphn_mean(s : SortdistproxmapGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_dist_proxmap_graphn_scale(s : SortdistproxmapGraphN, f : Double) -> SortdistproxmapGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_graphn_add(a : SortdistproxmapGraphN, b : SortdistproxmapGraphN) -> SortdistproxmapGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_proxmap_graphn_copy(s : SortdistproxmapGraphN) -> SortdistproxmapGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_graphn_fill(s : SortdistproxmapGraphN, v : Double) -> SortdistproxmapGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_graphn_min(s : SortdistproxmapGraphN) -> Double { @_common.min(s.data) }

pub fn sort_dist_proxmap_graphn_max(s : SortdistproxmapGraphN) -> Double { @_common.max(s.data) }

pub fn sort_dist_proxmap_graphn_to_string(s : SortdistproxmapGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_node_make(size : Int) -> SortdistproxmapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_node_len(s : SortdistproxmapNode) -> Int { s.size }

pub fn sort_dist_proxmap_node_get(s : SortdistproxmapNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_node_set(s : SortdistproxmapNode, i : Int, v : Double) -> SortdistproxmapNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_node_sum(s : SortdistproxmapNode) -> Double { @_common.sum(s.data) }

pub fn sort_dist_proxmap_node_mean(s : SortdistproxmapNode) -> Double { @_common.mean(s.data) }

pub fn sort_dist_proxmap_node_scale(s : SortdistproxmapNode, f : Double) -> SortdistproxmapNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_node_add(a : SortdistproxmapNode, b : SortdistproxmapNode) -> SortdistproxmapNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_proxmap_node_copy(s : SortdistproxmapNode) -> SortdistproxmapNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_node_fill(s : SortdistproxmapNode, v : Double) -> SortdistproxmapNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_node_min(s : SortdistproxmapNode) -> Double { @_common.min(s.data) }

pub fn sort_dist_proxmap_node_max(s : SortdistproxmapNode) -> Double { @_common.max(s.data) }

pub fn sort_dist_proxmap_node_to_string(s : SortdistproxmapNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_edge_make(size : Int) -> SortdistproxmapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_edge_len(s : SortdistproxmapEdge) -> Int { s.size }

pub fn sort_dist_proxmap_edge_get(s : SortdistproxmapEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_edge_set(s : SortdistproxmapEdge, i : Int, v : Double) -> SortdistproxmapEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_edge_sum(s : SortdistproxmapEdge) -> Double { @_common.sum(s.data) }

pub fn sort_dist_proxmap_edge_mean(s : SortdistproxmapEdge) -> Double { @_common.mean(s.data) }

pub fn sort_dist_proxmap_edge_scale(s : SortdistproxmapEdge, f : Double) -> SortdistproxmapEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_edge_add(a : SortdistproxmapEdge, b : SortdistproxmapEdge) -> SortdistproxmapEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_proxmap_edge_copy(s : SortdistproxmapEdge) -> SortdistproxmapEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_edge_fill(s : SortdistproxmapEdge, v : Double) -> SortdistproxmapEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_edge_min(s : SortdistproxmapEdge) -> Double { @_common.min(s.data) }

pub fn sort_dist_proxmap_edge_max(s : SortdistproxmapEdge) -> Double { @_common.max(s.data) }

pub fn sort_dist_proxmap_edge_to_string(s : SortdistproxmapEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_path_make(size : Int) -> SortdistproxmapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_path_len(s : SortdistproxmapPath) -> Int { s.size }

pub fn sort_dist_proxmap_path_get(s : SortdistproxmapPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_path_set(s : SortdistproxmapPath, i : Int, v : Double) -> SortdistproxmapPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_path_sum(s : SortdistproxmapPath) -> Double { @_common.sum(s.data) }

pub fn sort_dist_proxmap_path_mean(s : SortdistproxmapPath) -> Double { @_common.mean(s.data) }

pub fn sort_dist_proxmap_path_scale(s : SortdistproxmapPath, f : Double) -> SortdistproxmapPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_path_add(a : SortdistproxmapPath, b : SortdistproxmapPath) -> SortdistproxmapPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_proxmap_path_copy(s : SortdistproxmapPath) -> SortdistproxmapPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_path_fill(s : SortdistproxmapPath, v : Double) -> SortdistproxmapPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_path_min(s : SortdistproxmapPath) -> Double { @_common.min(s.data) }

pub fn sort_dist_proxmap_path_max(s : SortdistproxmapPath) -> Double { @_common.max(s.data) }

pub fn sort_dist_proxmap_path_to_string(s : SortdistproxmapPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_cluster_make(size : Int) -> SortdistproxmapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_cluster_len(s : SortdistproxmapCluster) -> Int { s.size }

pub fn sort_dist_proxmap_cluster_get(s : SortdistproxmapCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_cluster_set(s : SortdistproxmapCluster, i : Int, v : Double) -> SortdistproxmapCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_cluster_sum(s : SortdistproxmapCluster) -> Double { @_common.sum(s.data) }

pub fn sort_dist_proxmap_cluster_mean(s : SortdistproxmapCluster) -> Double { @_common.mean(s.data) }

pub fn sort_dist_proxmap_cluster_scale(s : SortdistproxmapCluster, f : Double) -> SortdistproxmapCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_cluster_add(a : SortdistproxmapCluster, b : SortdistproxmapCluster) -> SortdistproxmapCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_proxmap_cluster_copy(s : SortdistproxmapCluster) -> SortdistproxmapCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_cluster_fill(s : SortdistproxmapCluster, v : Double) -> SortdistproxmapCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_cluster_min(s : SortdistproxmapCluster) -> Double { @_common.min(s.data) }

pub fn sort_dist_proxmap_cluster_max(s : SortdistproxmapCluster) -> Double { @_common.max(s.data) }

pub fn sort_dist_proxmap_cluster_to_string(s : SortdistproxmapCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_model_make(size : Int) -> SortdistproxmapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_model_len(s : SortdistproxmapModel) -> Int { s.size }

pub fn sort_dist_proxmap_model_get(s : SortdistproxmapModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_model_set(s : SortdistproxmapModel, i : Int, v : Double) -> SortdistproxmapModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_model_sum(s : SortdistproxmapModel) -> Double { @_common.sum(s.data) }

pub fn sort_dist_proxmap_model_mean(s : SortdistproxmapModel) -> Double { @_common.mean(s.data) }

pub fn sort_dist_proxmap_model_scale(s : SortdistproxmapModel, f : Double) -> SortdistproxmapModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_model_add(a : SortdistproxmapModel, b : SortdistproxmapModel) -> SortdistproxmapModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_proxmap_model_copy(s : SortdistproxmapModel) -> SortdistproxmapModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_model_fill(s : SortdistproxmapModel, v : Double) -> SortdistproxmapModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_model_min(s : SortdistproxmapModel) -> Double { @_common.min(s.data) }

pub fn sort_dist_proxmap_model_max(s : SortdistproxmapModel) -> Double { @_common.max(s.data) }

pub fn sort_dist_proxmap_model_to_string(s : SortdistproxmapModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_layer_make(size : Int) -> SortdistproxmapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_layer_len(s : SortdistproxmapLayer) -> Int { s.size }

pub fn sort_dist_proxmap_layer_get(s : SortdistproxmapLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_layer_set(s : SortdistproxmapLayer, i : Int, v : Double) -> SortdistproxmapLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_layer_sum(s : SortdistproxmapLayer) -> Double { @_common.sum(s.data) }

pub fn sort_dist_proxmap_layer_mean(s : SortdistproxmapLayer) -> Double { @_common.mean(s.data) }

pub fn sort_dist_proxmap_layer_scale(s : SortdistproxmapLayer, f : Double) -> SortdistproxmapLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_layer_add(a : SortdistproxmapLayer, b : SortdistproxmapLayer) -> SortdistproxmapLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_proxmap_layer_copy(s : SortdistproxmapLayer) -> SortdistproxmapLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_layer_fill(s : SortdistproxmapLayer, v : Double) -> SortdistproxmapLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_layer_min(s : SortdistproxmapLayer) -> Double { @_common.min(s.data) }

pub fn sort_dist_proxmap_layer_max(s : SortdistproxmapLayer) -> Double { @_common.max(s.data) }

pub fn sort_dist_proxmap_layer_to_string(s : SortdistproxmapLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_buffer_make(size : Int) -> SortdistproxmapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_buffer_len(s : SortdistproxmapBuffer) -> Int { s.size }

pub fn sort_dist_proxmap_buffer_get(s : SortdistproxmapBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_buffer_set(s : SortdistproxmapBuffer, i : Int, v : Double) -> SortdistproxmapBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_buffer_sum(s : SortdistproxmapBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_dist_proxmap_buffer_mean(s : SortdistproxmapBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_dist_proxmap_buffer_scale(s : SortdistproxmapBuffer, f : Double) -> SortdistproxmapBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_buffer_add(a : SortdistproxmapBuffer, b : SortdistproxmapBuffer) -> SortdistproxmapBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_proxmap_buffer_copy(s : SortdistproxmapBuffer) -> SortdistproxmapBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_buffer_fill(s : SortdistproxmapBuffer, v : Double) -> SortdistproxmapBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_buffer_min(s : SortdistproxmapBuffer) -> Double { @_common.min(s.data) }

pub fn sort_dist_proxmap_buffer_max(s : SortdistproxmapBuffer) -> Double { @_common.max(s.data) }

pub fn sort_dist_proxmap_buffer_to_string(s : SortdistproxmapBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_cursor_make(size : Int) -> SortdistproxmapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_cursor_len(s : SortdistproxmapCursor) -> Int { s.size }

pub fn sort_dist_proxmap_cursor_get(s : SortdistproxmapCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_cursor_set(s : SortdistproxmapCursor, i : Int, v : Double) -> SortdistproxmapCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_cursor_sum(s : SortdistproxmapCursor) -> Double { @_common.sum(s.data) }

pub fn sort_dist_proxmap_cursor_mean(s : SortdistproxmapCursor) -> Double { @_common.mean(s.data) }

pub fn sort_dist_proxmap_cursor_scale(s : SortdistproxmapCursor, f : Double) -> SortdistproxmapCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_cursor_add(a : SortdistproxmapCursor, b : SortdistproxmapCursor) -> SortdistproxmapCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_proxmap_cursor_copy(s : SortdistproxmapCursor) -> SortdistproxmapCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_cursor_fill(s : SortdistproxmapCursor, v : Double) -> SortdistproxmapCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_cursor_min(s : SortdistproxmapCursor) -> Double { @_common.min(s.data) }

pub fn sort_dist_proxmap_cursor_max(s : SortdistproxmapCursor) -> Double { @_common.max(s.data) }

pub fn sort_dist_proxmap_cursor_to_string(s : SortdistproxmapCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_view_make(size : Int) -> SortdistproxmapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_view_len(s : SortdistproxmapView) -> Int { s.size }

pub fn sort_dist_proxmap_view_get(s : SortdistproxmapView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_view_set(s : SortdistproxmapView, i : Int, v : Double) -> SortdistproxmapView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_view_sum(s : SortdistproxmapView) -> Double { @_common.sum(s.data) }

pub fn sort_dist_proxmap_view_mean(s : SortdistproxmapView) -> Double { @_common.mean(s.data) }

pub fn sort_dist_proxmap_view_scale(s : SortdistproxmapView, f : Double) -> SortdistproxmapView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_view_add(a : SortdistproxmapView, b : SortdistproxmapView) -> SortdistproxmapView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_proxmap_view_copy(s : SortdistproxmapView) -> SortdistproxmapView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_view_fill(s : SortdistproxmapView, v : Double) -> SortdistproxmapView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_view_min(s : SortdistproxmapView) -> Double { @_common.min(s.data) }

pub fn sort_dist_proxmap_view_max(s : SortdistproxmapView) -> Double { @_common.max(s.data) }

pub fn sort_dist_proxmap_view_to_string(s : SortdistproxmapView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_range_make(size : Int) -> SortdistproxmapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_range_len(s : SortdistproxmapRange) -> Int { s.size }

pub fn sort_dist_proxmap_range_get(s : SortdistproxmapRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_range_set(s : SortdistproxmapRange, i : Int, v : Double) -> SortdistproxmapRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_range_sum(s : SortdistproxmapRange) -> Double { @_common.sum(s.data) }

pub fn sort_dist_proxmap_range_mean(s : SortdistproxmapRange) -> Double { @_common.mean(s.data) }

pub fn sort_dist_proxmap_range_scale(s : SortdistproxmapRange, f : Double) -> SortdistproxmapRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_range_add(a : SortdistproxmapRange, b : SortdistproxmapRange) -> SortdistproxmapRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_proxmap_range_copy(s : SortdistproxmapRange) -> SortdistproxmapRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_range_fill(s : SortdistproxmapRange, v : Double) -> SortdistproxmapRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_range_min(s : SortdistproxmapRange) -> Double { @_common.min(s.data) }

pub fn sort_dist_proxmap_range_max(s : SortdistproxmapRange) -> Double { @_common.max(s.data) }

pub fn sort_dist_proxmap_range_to_string(s : SortdistproxmapRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_slice_make(size : Int) -> SortdistproxmapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_slice_len(s : SortdistproxmapSlice) -> Int { s.size }

pub fn sort_dist_proxmap_slice_get(s : SortdistproxmapSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_slice_set(s : SortdistproxmapSlice, i : Int, v : Double) -> SortdistproxmapSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_slice_sum(s : SortdistproxmapSlice) -> Double { @_common.sum(s.data) }

pub fn sort_dist_proxmap_slice_mean(s : SortdistproxmapSlice) -> Double { @_common.mean(s.data) }

pub fn sort_dist_proxmap_slice_scale(s : SortdistproxmapSlice, f : Double) -> SortdistproxmapSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_slice_add(a : SortdistproxmapSlice, b : SortdistproxmapSlice) -> SortdistproxmapSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_proxmap_slice_copy(s : SortdistproxmapSlice) -> SortdistproxmapSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_slice_fill(s : SortdistproxmapSlice, v : Double) -> SortdistproxmapSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_proxmap_slice_min(s : SortdistproxmapSlice) -> Double { @_common.min(s.data) }

pub fn sort_dist_proxmap_slice_max(s : SortdistproxmapSlice) -> Double { @_common.max(s.data) }

pub fn sort_dist_proxmap_slice_to_string(s : SortdistproxmapSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

