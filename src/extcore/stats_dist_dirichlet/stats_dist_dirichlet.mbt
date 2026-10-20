///===
/// extcore/stats_dist_dirichlet

pub(all) struct StatsdistdirichletPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_dirichlet_make_point(x : Double, y : Double) -> StatsdistdirichletPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_dirichlet_make_point3(x : Double, y : Double, z : Double) -> StatsdistdirichletPoint {
  { x, y, z, label: 0 }
}

pub fn stats_dist_dirichlet_point_x(pt : StatsdistdirichletPoint) -> Double { pt.x }

pub fn stats_dist_dirichlet_point_y(pt : StatsdistdirichletPoint) -> Double { pt.y }

pub fn stats_dist_dirichlet_point_z(pt : StatsdistdirichletPoint) -> Double { pt.z }

pub fn stats_dist_dirichlet_point_label(pt : StatsdistdirichletPoint) -> Int { pt.label }

pub fn stats_dist_dirichlet_point_dist(a : StatsdistdirichletPoint, b : StatsdistdirichletPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_dist_dirichlet_point_add(a : StatsdistdirichletPoint, b : StatsdistdirichletPoint) -> StatsdistdirichletPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_dist_dirichlet_point_sub(a : StatsdistdirichletPoint, b : StatsdistdirichletPoint) -> StatsdistdirichletPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_dist_dirichlet_point_scale(pt : StatsdistdirichletPoint, s : Double) -> StatsdistdirichletPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_dist_dirichlet_point_dot(a : StatsdistdirichletPoint, b : StatsdistdirichletPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_dist_dirichlet_point_cross(a : StatsdistdirichletPoint, b : StatsdistdirichletPoint) -> StatsdistdirichletPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_dist_dirichlet_point_norm(pt : StatsdistdirichletPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_dist_dirichlet_point_normalize(pt : StatsdistdirichletPoint) -> StatsdistdirichletPoint {
  let n = stats_dist_dirichlet_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_dist_dirichlet_point_scale(pt, 1.0 / n) }
}

pub fn stats_dist_dirichlet_point_negate(pt : StatsdistdirichletPoint) -> StatsdistdirichletPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_dist_dirichlet_point_mid(a : StatsdistdirichletPoint, b : StatsdistdirichletPoint) -> StatsdistdirichletPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_dist_dirichlet_point_lerp(a : StatsdistdirichletPoint, b : StatsdistdirichletPoint, t : Double) -> StatsdistdirichletPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_dist_dirichlet_point_to_string(pt : StatsdistdirichletPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdistdirichletSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_dirichlet_make_series(vals : Array[Double], name : String) -> StatsdistdirichletSeries {
  { vals, name, meta: 0 }
}

pub fn stats_dist_dirichlet_series_len(s : StatsdistdirichletSeries) -> Int { s.vals.length() }

pub fn stats_dist_dirichlet_series_sum(s : StatsdistdirichletSeries) -> Double { @_common.sum(s.vals) }

pub fn stats_dist_dirichlet_series_mean(s : StatsdistdirichletSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_dist_dirichlet_series_min(s : StatsdistdirichletSeries) -> Double { @_common.min(s.vals) }

pub fn stats_dist_dirichlet_series_max(s : StatsdistdirichletSeries) -> Double { @_common.max(s.vals) }

pub fn stats_dist_dirichlet_series_range(s : StatsdistdirichletSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_dist_dirichlet_series_var(s : StatsdistdirichletSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_dist_dirichlet_series_std(s : StatsdistdirichletSeries) -> Double { @_common.std(s.vals) }

pub fn stats_dist_dirichlet_series_median(s : StatsdistdirichletSeries) -> Double { @_common.median(s.vals) }

pub fn stats_dist_dirichlet_series_scale(s : StatsdistdirichletSeries, f : Double) -> StatsdistdirichletSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn stats_dist_dirichlet_series_add(a : StatsdistdirichletSeries, b : StatsdistdirichletSeries) -> StatsdistdirichletSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_dist_dirichlet_series_sub(a : StatsdistdirichletSeries, b : StatsdistdirichletSeries) -> StatsdistdirichletSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_dist_dirichlet_series_normalize(s : StatsdistdirichletSeries) -> StatsdistdirichletSeries {
  let mn = stats_dist_dirichlet_series_min(s)
  let mx = stats_dist_dirichlet_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_dist_dirichlet_series_cumsum(s : StatsdistdirichletSeries) -> StatsdistdirichletSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_dist_dirichlet_series_to_string(s : StatsdistdirichletSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistdirichletMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_dirichlet_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistdirichletMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_dirichlet_matrix_identity(n : Int) -> StatsdistdirichletMatrix {
  let m = stats_dist_dirichlet_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_dist_dirichlet_matrix_get(m : StatsdistdirichletMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_dist_dirichlet_matrix_transpose(m : StatsdistdirichletMatrix) -> StatsdistdirichletMatrix {
  let result = stats_dist_dirichlet_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_dist_dirichlet_matrix_add(a : StatsdistdirichletMatrix, b : StatsdistdirichletMatrix) -> StatsdistdirichletMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_dist_dirichlet_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_dist_dirichlet_matrix_scale(m : StatsdistdirichletMatrix, s : Double) -> StatsdistdirichletMatrix {
  let result = stats_dist_dirichlet_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_dist_dirichlet_matrix_multiply(a : StatsdistdirichletMatrix, b : StatsdistdirichletMatrix) -> StatsdistdirichletMatrix {
  if a.cols != b.rows { return stats_dist_dirichlet_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_dist_dirichlet_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_dist_dirichlet_matrix_trace(m : StatsdistdirichletMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_dist_dirichlet_matrix_det(m : StatsdistdirichletMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_dist_dirichlet_matrix_norm(m : StatsdistdirichletMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_dist_dirichlet_matrix_to_string(m : StatsdistdirichletMatrix) -> String {
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

pub(all) struct StatsdistdirichletVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_dirichlet_make_vector(comps : Array[Double]) -> StatsdistdirichletVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_dirichlet_vector_zero(dim : Int) -> StatsdistdirichletVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_dist_dirichlet_vector_add(a : StatsdistdirichletVector, b : StatsdistdirichletVector) -> StatsdistdirichletVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn stats_dist_dirichlet_vector_sub(a : StatsdistdirichletVector, b : StatsdistdirichletVector) -> StatsdistdirichletVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn stats_dist_dirichlet_vector_scale(v : StatsdistdirichletVector, s : Double) -> StatsdistdirichletVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn stats_dist_dirichlet_vector_dot(a : StatsdistdirichletVector, b : StatsdistdirichletVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_dist_dirichlet_vector_norm(v : StatsdistdirichletVector) -> Double { @_common.sqrt(stats_dist_dirichlet_vector_dot(v, v)) }

pub fn stats_dist_dirichlet_vector_normalize(v : StatsdistdirichletVector) -> StatsdistdirichletVector {
  let n = stats_dist_dirichlet_vector_norm(v)
  if n < 0.0000001 { v } else { stats_dist_dirichlet_vector_scale(v, 1.0 / n) }
}

pub fn stats_dist_dirichlet_vector_dist(a : StatsdistdirichletVector, b : StatsdistdirichletVector) -> Double {
  stats_dist_dirichlet_vector_norm(stats_dist_dirichlet_vector_sub(a, b))
}

pub fn stats_dist_dirichlet_vector_to_string(v : StatsdistdirichletVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_dirichlet_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_dirichlet_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_dirichlet_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_dirichlet_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_dirichlet_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_dirichlet_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_dirichlet_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_dirichlet_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_dirichlet_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_dirichlet_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_dirichlet_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_dirichlet_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_dirichlet_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_dirichlet_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_dirichlet_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_dirichlet_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_dirichlet_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_dirichlet_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_dirichlet_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_dirichlet_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_dirichlet_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_dirichlet_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_dirichlet_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_dirichlet_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_dirichlet_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_dirichlet_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_dirichlet_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_dirichlet_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_dirichlet_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistdirichletFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_frame_make(size : Int) -> StatsdistdirichletFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_frame_len(s : StatsdistdirichletFrame) -> Int { s.size }

pub fn stats_dist_dirichlet_frame_get(s : StatsdistdirichletFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_frame_set(s : StatsdistdirichletFrame, i : Int, v : Double) -> StatsdistdirichletFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_frame_sum(s : StatsdistdirichletFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_frame_mean(s : StatsdistdirichletFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_frame_scale(s : StatsdistdirichletFrame, f : Double) -> StatsdistdirichletFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_frame_add(a : StatsdistdirichletFrame, b : StatsdistdirichletFrame) -> StatsdistdirichletFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_frame_copy(s : StatsdistdirichletFrame) -> StatsdistdirichletFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_frame_fill(s : StatsdistdirichletFrame, v : Double) -> StatsdistdirichletFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_frame_min(s : StatsdistdirichletFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_frame_max(s : StatsdistdirichletFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_frame_to_string(s : StatsdistdirichletFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_table_make(size : Int) -> StatsdistdirichletTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_table_len(s : StatsdistdirichletTable) -> Int { s.size }

pub fn stats_dist_dirichlet_table_get(s : StatsdistdirichletTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_table_set(s : StatsdistdirichletTable, i : Int, v : Double) -> StatsdistdirichletTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_table_sum(s : StatsdistdirichletTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_table_mean(s : StatsdistdirichletTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_table_scale(s : StatsdistdirichletTable, f : Double) -> StatsdistdirichletTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_table_add(a : StatsdistdirichletTable, b : StatsdistdirichletTable) -> StatsdistdirichletTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_table_copy(s : StatsdistdirichletTable) -> StatsdistdirichletTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_table_fill(s : StatsdistdirichletTable, v : Double) -> StatsdistdirichletTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_table_min(s : StatsdistdirichletTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_table_max(s : StatsdistdirichletTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_table_to_string(s : StatsdistdirichletTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_graphn_make(size : Int) -> StatsdistdirichletGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_graphn_len(s : StatsdistdirichletGraphN) -> Int { s.size }

pub fn stats_dist_dirichlet_graphn_get(s : StatsdistdirichletGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_graphn_set(s : StatsdistdirichletGraphN, i : Int, v : Double) -> StatsdistdirichletGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_graphn_sum(s : StatsdistdirichletGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_graphn_mean(s : StatsdistdirichletGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_graphn_scale(s : StatsdistdirichletGraphN, f : Double) -> StatsdistdirichletGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_graphn_add(a : StatsdistdirichletGraphN, b : StatsdistdirichletGraphN) -> StatsdistdirichletGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_graphn_copy(s : StatsdistdirichletGraphN) -> StatsdistdirichletGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_graphn_fill(s : StatsdistdirichletGraphN, v : Double) -> StatsdistdirichletGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_graphn_min(s : StatsdistdirichletGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_graphn_max(s : StatsdistdirichletGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_graphn_to_string(s : StatsdistdirichletGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_node_make(size : Int) -> StatsdistdirichletNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_node_len(s : StatsdistdirichletNode) -> Int { s.size }

pub fn stats_dist_dirichlet_node_get(s : StatsdistdirichletNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_node_set(s : StatsdistdirichletNode, i : Int, v : Double) -> StatsdistdirichletNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_node_sum(s : StatsdistdirichletNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_node_mean(s : StatsdistdirichletNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_node_scale(s : StatsdistdirichletNode, f : Double) -> StatsdistdirichletNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_node_add(a : StatsdistdirichletNode, b : StatsdistdirichletNode) -> StatsdistdirichletNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_node_copy(s : StatsdistdirichletNode) -> StatsdistdirichletNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_node_fill(s : StatsdistdirichletNode, v : Double) -> StatsdistdirichletNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_node_min(s : StatsdistdirichletNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_node_max(s : StatsdistdirichletNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_node_to_string(s : StatsdistdirichletNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_edge_make(size : Int) -> StatsdistdirichletEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_edge_len(s : StatsdistdirichletEdge) -> Int { s.size }

pub fn stats_dist_dirichlet_edge_get(s : StatsdistdirichletEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_edge_set(s : StatsdistdirichletEdge, i : Int, v : Double) -> StatsdistdirichletEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_edge_sum(s : StatsdistdirichletEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_edge_mean(s : StatsdistdirichletEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_edge_scale(s : StatsdistdirichletEdge, f : Double) -> StatsdistdirichletEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_edge_add(a : StatsdistdirichletEdge, b : StatsdistdirichletEdge) -> StatsdistdirichletEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_edge_copy(s : StatsdistdirichletEdge) -> StatsdistdirichletEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_edge_fill(s : StatsdistdirichletEdge, v : Double) -> StatsdistdirichletEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_edge_min(s : StatsdistdirichletEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_edge_max(s : StatsdistdirichletEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_edge_to_string(s : StatsdistdirichletEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_path_make(size : Int) -> StatsdistdirichletPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_path_len(s : StatsdistdirichletPath) -> Int { s.size }

pub fn stats_dist_dirichlet_path_get(s : StatsdistdirichletPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_path_set(s : StatsdistdirichletPath, i : Int, v : Double) -> StatsdistdirichletPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_path_sum(s : StatsdistdirichletPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_path_mean(s : StatsdistdirichletPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_path_scale(s : StatsdistdirichletPath, f : Double) -> StatsdistdirichletPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_path_add(a : StatsdistdirichletPath, b : StatsdistdirichletPath) -> StatsdistdirichletPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_path_copy(s : StatsdistdirichletPath) -> StatsdistdirichletPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_path_fill(s : StatsdistdirichletPath, v : Double) -> StatsdistdirichletPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_path_min(s : StatsdistdirichletPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_path_max(s : StatsdistdirichletPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_path_to_string(s : StatsdistdirichletPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_cluster_make(size : Int) -> StatsdistdirichletCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_cluster_len(s : StatsdistdirichletCluster) -> Int { s.size }

pub fn stats_dist_dirichlet_cluster_get(s : StatsdistdirichletCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_cluster_set(s : StatsdistdirichletCluster, i : Int, v : Double) -> StatsdistdirichletCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_cluster_sum(s : StatsdistdirichletCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_cluster_mean(s : StatsdistdirichletCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_cluster_scale(s : StatsdistdirichletCluster, f : Double) -> StatsdistdirichletCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_cluster_add(a : StatsdistdirichletCluster, b : StatsdistdirichletCluster) -> StatsdistdirichletCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_cluster_copy(s : StatsdistdirichletCluster) -> StatsdistdirichletCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_cluster_fill(s : StatsdistdirichletCluster, v : Double) -> StatsdistdirichletCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_cluster_min(s : StatsdistdirichletCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_cluster_max(s : StatsdistdirichletCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_cluster_to_string(s : StatsdistdirichletCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_model_make(size : Int) -> StatsdistdirichletModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_model_len(s : StatsdistdirichletModel) -> Int { s.size }

pub fn stats_dist_dirichlet_model_get(s : StatsdistdirichletModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_model_set(s : StatsdistdirichletModel, i : Int, v : Double) -> StatsdistdirichletModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_model_sum(s : StatsdistdirichletModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_model_mean(s : StatsdistdirichletModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_model_scale(s : StatsdistdirichletModel, f : Double) -> StatsdistdirichletModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_model_add(a : StatsdistdirichletModel, b : StatsdistdirichletModel) -> StatsdistdirichletModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_model_copy(s : StatsdistdirichletModel) -> StatsdistdirichletModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_model_fill(s : StatsdistdirichletModel, v : Double) -> StatsdistdirichletModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_model_min(s : StatsdistdirichletModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_model_max(s : StatsdistdirichletModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_model_to_string(s : StatsdistdirichletModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_layer_make(size : Int) -> StatsdistdirichletLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_layer_len(s : StatsdistdirichletLayer) -> Int { s.size }

pub fn stats_dist_dirichlet_layer_get(s : StatsdistdirichletLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_layer_set(s : StatsdistdirichletLayer, i : Int, v : Double) -> StatsdistdirichletLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_layer_sum(s : StatsdistdirichletLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_layer_mean(s : StatsdistdirichletLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_layer_scale(s : StatsdistdirichletLayer, f : Double) -> StatsdistdirichletLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_layer_add(a : StatsdistdirichletLayer, b : StatsdistdirichletLayer) -> StatsdistdirichletLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_layer_copy(s : StatsdistdirichletLayer) -> StatsdistdirichletLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_layer_fill(s : StatsdistdirichletLayer, v : Double) -> StatsdistdirichletLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_layer_min(s : StatsdistdirichletLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_layer_max(s : StatsdistdirichletLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_layer_to_string(s : StatsdistdirichletLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_buffer_make(size : Int) -> StatsdistdirichletBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_buffer_len(s : StatsdistdirichletBuffer) -> Int { s.size }

pub fn stats_dist_dirichlet_buffer_get(s : StatsdistdirichletBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_buffer_set(s : StatsdistdirichletBuffer, i : Int, v : Double) -> StatsdistdirichletBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_buffer_sum(s : StatsdistdirichletBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_buffer_mean(s : StatsdistdirichletBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_buffer_scale(s : StatsdistdirichletBuffer, f : Double) -> StatsdistdirichletBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_buffer_add(a : StatsdistdirichletBuffer, b : StatsdistdirichletBuffer) -> StatsdistdirichletBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_buffer_copy(s : StatsdistdirichletBuffer) -> StatsdistdirichletBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_buffer_fill(s : StatsdistdirichletBuffer, v : Double) -> StatsdistdirichletBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_buffer_min(s : StatsdistdirichletBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_buffer_max(s : StatsdistdirichletBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_buffer_to_string(s : StatsdistdirichletBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_cursor_make(size : Int) -> StatsdistdirichletCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_cursor_len(s : StatsdistdirichletCursor) -> Int { s.size }

pub fn stats_dist_dirichlet_cursor_get(s : StatsdistdirichletCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_cursor_set(s : StatsdistdirichletCursor, i : Int, v : Double) -> StatsdistdirichletCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_cursor_sum(s : StatsdistdirichletCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_cursor_mean(s : StatsdistdirichletCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_cursor_scale(s : StatsdistdirichletCursor, f : Double) -> StatsdistdirichletCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_cursor_add(a : StatsdistdirichletCursor, b : StatsdistdirichletCursor) -> StatsdistdirichletCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_cursor_copy(s : StatsdistdirichletCursor) -> StatsdistdirichletCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_cursor_fill(s : StatsdistdirichletCursor, v : Double) -> StatsdistdirichletCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_cursor_min(s : StatsdistdirichletCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_cursor_max(s : StatsdistdirichletCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_cursor_to_string(s : StatsdistdirichletCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_view_make(size : Int) -> StatsdistdirichletView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_view_len(s : StatsdistdirichletView) -> Int { s.size }

pub fn stats_dist_dirichlet_view_get(s : StatsdistdirichletView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_view_set(s : StatsdistdirichletView, i : Int, v : Double) -> StatsdistdirichletView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_view_sum(s : StatsdistdirichletView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_view_mean(s : StatsdistdirichletView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_view_scale(s : StatsdistdirichletView, f : Double) -> StatsdistdirichletView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_view_add(a : StatsdistdirichletView, b : StatsdistdirichletView) -> StatsdistdirichletView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_view_copy(s : StatsdistdirichletView) -> StatsdistdirichletView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_view_fill(s : StatsdistdirichletView, v : Double) -> StatsdistdirichletView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_view_min(s : StatsdistdirichletView) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_view_max(s : StatsdistdirichletView) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_view_to_string(s : StatsdistdirichletView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_range_make(size : Int) -> StatsdistdirichletRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_range_len(s : StatsdistdirichletRange) -> Int { s.size }

pub fn stats_dist_dirichlet_range_get(s : StatsdistdirichletRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_range_set(s : StatsdistdirichletRange, i : Int, v : Double) -> StatsdistdirichletRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_range_sum(s : StatsdistdirichletRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_range_mean(s : StatsdistdirichletRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_range_scale(s : StatsdistdirichletRange, f : Double) -> StatsdistdirichletRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_range_add(a : StatsdistdirichletRange, b : StatsdistdirichletRange) -> StatsdistdirichletRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_range_copy(s : StatsdistdirichletRange) -> StatsdistdirichletRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_range_fill(s : StatsdistdirichletRange, v : Double) -> StatsdistdirichletRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_range_min(s : StatsdistdirichletRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_range_max(s : StatsdistdirichletRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_range_to_string(s : StatsdistdirichletRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_slice_make(size : Int) -> StatsdistdirichletSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_slice_len(s : StatsdistdirichletSlice) -> Int { s.size }

pub fn stats_dist_dirichlet_slice_get(s : StatsdistdirichletSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_slice_set(s : StatsdistdirichletSlice, i : Int, v : Double) -> StatsdistdirichletSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_slice_sum(s : StatsdistdirichletSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_slice_mean(s : StatsdistdirichletSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_slice_scale(s : StatsdistdirichletSlice, f : Double) -> StatsdistdirichletSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_slice_add(a : StatsdistdirichletSlice, b : StatsdistdirichletSlice) -> StatsdistdirichletSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_slice_copy(s : StatsdistdirichletSlice) -> StatsdistdirichletSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_slice_fill(s : StatsdistdirichletSlice, v : Double) -> StatsdistdirichletSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_slice_min(s : StatsdistdirichletSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_slice_max(s : StatsdistdirichletSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_slice_to_string(s : StatsdistdirichletSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

