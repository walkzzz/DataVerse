///===
/// extcore/bio_phylo_bayesian

pub(all) struct BiophylobayesianPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_bayesian_make_point(x : Double, y : Double) -> BiophylobayesianPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_bayesian_make_point3(x : Double, y : Double, z : Double) -> BiophylobayesianPoint {
  { x, y, z, label: 0 }
}

pub fn bio_phylo_bayesian_point_x(pt : BiophylobayesianPoint) -> Double { pt.x }

pub fn bio_phylo_bayesian_point_y(pt : BiophylobayesianPoint) -> Double { pt.y }

pub fn bio_phylo_bayesian_point_z(pt : BiophylobayesianPoint) -> Double { pt.z }

pub fn bio_phylo_bayesian_point_label(pt : BiophylobayesianPoint) -> Int { pt.label }

pub fn bio_phylo_bayesian_point_dist(a : BiophylobayesianPoint, b : BiophylobayesianPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_phylo_bayesian_point_add(a : BiophylobayesianPoint, b : BiophylobayesianPoint) -> BiophylobayesianPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_phylo_bayesian_point_sub(a : BiophylobayesianPoint, b : BiophylobayesianPoint) -> BiophylobayesianPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_phylo_bayesian_point_scale(pt : BiophylobayesianPoint, s : Double) -> BiophylobayesianPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_phylo_bayesian_point_dot(a : BiophylobayesianPoint, b : BiophylobayesianPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_phylo_bayesian_point_cross(a : BiophylobayesianPoint, b : BiophylobayesianPoint) -> BiophylobayesianPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_phylo_bayesian_point_norm(pt : BiophylobayesianPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_phylo_bayesian_point_normalize(pt : BiophylobayesianPoint) -> BiophylobayesianPoint {
  let n = bio_phylo_bayesian_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_phylo_bayesian_point_scale(pt, 1.0 / n) }
}

pub fn bio_phylo_bayesian_point_negate(pt : BiophylobayesianPoint) -> BiophylobayesianPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_phylo_bayesian_point_mid(a : BiophylobayesianPoint, b : BiophylobayesianPoint) -> BiophylobayesianPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_phylo_bayesian_point_lerp(a : BiophylobayesianPoint, b : BiophylobayesianPoint, t : Double) -> BiophylobayesianPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_phylo_bayesian_point_to_string(pt : BiophylobayesianPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BiophylobayesianSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_bayesian_make_series(vals : Array[Double], name : String) -> BiophylobayesianSeries {
  { vals, name, meta: 0 }
}

pub fn bio_phylo_bayesian_series_len(s : BiophylobayesianSeries) -> Int { s.vals.length() }

pub fn bio_phylo_bayesian_series_sum(s : BiophylobayesianSeries) -> Double { @_common.sum(s.vals) }

pub fn bio_phylo_bayesian_series_mean(s : BiophylobayesianSeries) -> Double { @_common.mean(s.vals) }

pub fn bio_phylo_bayesian_series_min(s : BiophylobayesianSeries) -> Double { @_common.min(s.vals) }

pub fn bio_phylo_bayesian_series_max(s : BiophylobayesianSeries) -> Double { @_common.max(s.vals) }

pub fn bio_phylo_bayesian_series_range(s : BiophylobayesianSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn bio_phylo_bayesian_series_var(s : BiophylobayesianSeries) -> Double { @_common.variance(s.vals) }

pub fn bio_phylo_bayesian_series_std(s : BiophylobayesianSeries) -> Double { @_common.std(s.vals) }

pub fn bio_phylo_bayesian_series_median(s : BiophylobayesianSeries) -> Double { @_common.median(s.vals) }

pub fn bio_phylo_bayesian_series_scale(s : BiophylobayesianSeries, f : Double) -> BiophylobayesianSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn bio_phylo_bayesian_series_add(a : BiophylobayesianSeries, b : BiophylobayesianSeries) -> BiophylobayesianSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_phylo_bayesian_series_sub(a : BiophylobayesianSeries, b : BiophylobayesianSeries) -> BiophylobayesianSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_phylo_bayesian_series_normalize(s : BiophylobayesianSeries) -> BiophylobayesianSeries {
  let mn = bio_phylo_bayesian_series_min(s)
  let mx = bio_phylo_bayesian_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_phylo_bayesian_series_cumsum(s : BiophylobayesianSeries) -> BiophylobayesianSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_phylo_bayesian_series_to_string(s : BiophylobayesianSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophylobayesianMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_bayesian_make_matrix(rows : Int, cols : Int, val : Double) -> BiophylobayesianMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_phylo_bayesian_matrix_identity(n : Int) -> BiophylobayesianMatrix {
  let m = bio_phylo_bayesian_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_phylo_bayesian_matrix_get(m : BiophylobayesianMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_phylo_bayesian_matrix_transpose(m : BiophylobayesianMatrix) -> BiophylobayesianMatrix {
  let result = bio_phylo_bayesian_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_phylo_bayesian_matrix_add(a : BiophylobayesianMatrix, b : BiophylobayesianMatrix) -> BiophylobayesianMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_phylo_bayesian_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_phylo_bayesian_matrix_scale(m : BiophylobayesianMatrix, s : Double) -> BiophylobayesianMatrix {
  let result = bio_phylo_bayesian_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_phylo_bayesian_matrix_multiply(a : BiophylobayesianMatrix, b : BiophylobayesianMatrix) -> BiophylobayesianMatrix {
  if a.cols != b.rows { return bio_phylo_bayesian_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_phylo_bayesian_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_phylo_bayesian_matrix_trace(m : BiophylobayesianMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_phylo_bayesian_matrix_det(m : BiophylobayesianMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_phylo_bayesian_matrix_norm(m : BiophylobayesianMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_phylo_bayesian_matrix_to_string(m : BiophylobayesianMatrix) -> String {
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

pub(all) struct BiophylobayesianVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_bayesian_make_vector(comps : Array[Double]) -> BiophylobayesianVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_bayesian_vector_zero(dim : Int) -> BiophylobayesianVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_phylo_bayesian_vector_add(a : BiophylobayesianVector, b : BiophylobayesianVector) -> BiophylobayesianVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn bio_phylo_bayesian_vector_sub(a : BiophylobayesianVector, b : BiophylobayesianVector) -> BiophylobayesianVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn bio_phylo_bayesian_vector_scale(v : BiophylobayesianVector, s : Double) -> BiophylobayesianVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn bio_phylo_bayesian_vector_dot(a : BiophylobayesianVector, b : BiophylobayesianVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_phylo_bayesian_vector_norm(v : BiophylobayesianVector) -> Double { @_common.sqrt(bio_phylo_bayesian_vector_dot(v, v)) }

pub fn bio_phylo_bayesian_vector_normalize(v : BiophylobayesianVector) -> BiophylobayesianVector {
  let n = bio_phylo_bayesian_vector_norm(v)
  if n < 0.0000001 { v } else { bio_phylo_bayesian_vector_scale(v, 1.0 / n) }
}

pub fn bio_phylo_bayesian_vector_dist(a : BiophylobayesianVector, b : BiophylobayesianVector) -> Double {
  bio_phylo_bayesian_vector_norm(bio_phylo_bayesian_vector_sub(a, b))
}

pub fn bio_phylo_bayesian_vector_to_string(v : BiophylobayesianVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_phylo_bayesian_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_phylo_bayesian_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_phylo_bayesian_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_phylo_bayesian_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_phylo_bayesian_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_phylo_bayesian_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_phylo_bayesian_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_phylo_bayesian_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_phylo_bayesian_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_phylo_bayesian_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_phylo_bayesian_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_phylo_bayesian_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_phylo_bayesian_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_phylo_bayesian_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_phylo_bayesian_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_phylo_bayesian_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_phylo_bayesian_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_phylo_bayesian_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_phylo_bayesian_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_phylo_bayesian_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_phylo_bayesian_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_phylo_bayesian_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_phylo_bayesian_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_phylo_bayesian_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_phylo_bayesian_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_phylo_bayesian_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_phylo_bayesian_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_phylo_bayesian_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_phylo_bayesian_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiophylobayesianFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_frame_make(size : Int) -> BiophylobayesianFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_frame_len(s : BiophylobayesianFrame) -> Int { s.size }

pub fn bio_phylo_bayesian_frame_get(s : BiophylobayesianFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_frame_set(s : BiophylobayesianFrame, i : Int, v : Double) -> BiophylobayesianFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_frame_sum(s : BiophylobayesianFrame) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_frame_mean(s : BiophylobayesianFrame) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_frame_scale(s : BiophylobayesianFrame, f : Double) -> BiophylobayesianFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_frame_add(a : BiophylobayesianFrame, b : BiophylobayesianFrame) -> BiophylobayesianFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_frame_copy(s : BiophylobayesianFrame) -> BiophylobayesianFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_frame_fill(s : BiophylobayesianFrame, v : Double) -> BiophylobayesianFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_frame_min(s : BiophylobayesianFrame) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_frame_max(s : BiophylobayesianFrame) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_frame_to_string(s : BiophylobayesianFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_table_make(size : Int) -> BiophylobayesianTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_table_len(s : BiophylobayesianTable) -> Int { s.size }

pub fn bio_phylo_bayesian_table_get(s : BiophylobayesianTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_table_set(s : BiophylobayesianTable, i : Int, v : Double) -> BiophylobayesianTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_table_sum(s : BiophylobayesianTable) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_table_mean(s : BiophylobayesianTable) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_table_scale(s : BiophylobayesianTable, f : Double) -> BiophylobayesianTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_table_add(a : BiophylobayesianTable, b : BiophylobayesianTable) -> BiophylobayesianTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_table_copy(s : BiophylobayesianTable) -> BiophylobayesianTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_table_fill(s : BiophylobayesianTable, v : Double) -> BiophylobayesianTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_table_min(s : BiophylobayesianTable) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_table_max(s : BiophylobayesianTable) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_table_to_string(s : BiophylobayesianTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_graphn_make(size : Int) -> BiophylobayesianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_graphn_len(s : BiophylobayesianGraphN) -> Int { s.size }

pub fn bio_phylo_bayesian_graphn_get(s : BiophylobayesianGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_graphn_set(s : BiophylobayesianGraphN, i : Int, v : Double) -> BiophylobayesianGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_graphn_sum(s : BiophylobayesianGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_graphn_mean(s : BiophylobayesianGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_graphn_scale(s : BiophylobayesianGraphN, f : Double) -> BiophylobayesianGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_graphn_add(a : BiophylobayesianGraphN, b : BiophylobayesianGraphN) -> BiophylobayesianGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_graphn_copy(s : BiophylobayesianGraphN) -> BiophylobayesianGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_graphn_fill(s : BiophylobayesianGraphN, v : Double) -> BiophylobayesianGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_graphn_min(s : BiophylobayesianGraphN) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_graphn_max(s : BiophylobayesianGraphN) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_graphn_to_string(s : BiophylobayesianGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_node_make(size : Int) -> BiophylobayesianNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_node_len(s : BiophylobayesianNode) -> Int { s.size }

pub fn bio_phylo_bayesian_node_get(s : BiophylobayesianNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_node_set(s : BiophylobayesianNode, i : Int, v : Double) -> BiophylobayesianNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_node_sum(s : BiophylobayesianNode) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_node_mean(s : BiophylobayesianNode) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_node_scale(s : BiophylobayesianNode, f : Double) -> BiophylobayesianNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_node_add(a : BiophylobayesianNode, b : BiophylobayesianNode) -> BiophylobayesianNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_node_copy(s : BiophylobayesianNode) -> BiophylobayesianNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_node_fill(s : BiophylobayesianNode, v : Double) -> BiophylobayesianNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_node_min(s : BiophylobayesianNode) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_node_max(s : BiophylobayesianNode) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_node_to_string(s : BiophylobayesianNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_edge_make(size : Int) -> BiophylobayesianEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_edge_len(s : BiophylobayesianEdge) -> Int { s.size }

pub fn bio_phylo_bayesian_edge_get(s : BiophylobayesianEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_edge_set(s : BiophylobayesianEdge, i : Int, v : Double) -> BiophylobayesianEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_edge_sum(s : BiophylobayesianEdge) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_edge_mean(s : BiophylobayesianEdge) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_edge_scale(s : BiophylobayesianEdge, f : Double) -> BiophylobayesianEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_edge_add(a : BiophylobayesianEdge, b : BiophylobayesianEdge) -> BiophylobayesianEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_edge_copy(s : BiophylobayesianEdge) -> BiophylobayesianEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_edge_fill(s : BiophylobayesianEdge, v : Double) -> BiophylobayesianEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_edge_min(s : BiophylobayesianEdge) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_edge_max(s : BiophylobayesianEdge) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_edge_to_string(s : BiophylobayesianEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_path_make(size : Int) -> BiophylobayesianPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_path_len(s : BiophylobayesianPath) -> Int { s.size }

pub fn bio_phylo_bayesian_path_get(s : BiophylobayesianPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_path_set(s : BiophylobayesianPath, i : Int, v : Double) -> BiophylobayesianPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_path_sum(s : BiophylobayesianPath) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_path_mean(s : BiophylobayesianPath) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_path_scale(s : BiophylobayesianPath, f : Double) -> BiophylobayesianPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_path_add(a : BiophylobayesianPath, b : BiophylobayesianPath) -> BiophylobayesianPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_path_copy(s : BiophylobayesianPath) -> BiophylobayesianPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_path_fill(s : BiophylobayesianPath, v : Double) -> BiophylobayesianPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_path_min(s : BiophylobayesianPath) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_path_max(s : BiophylobayesianPath) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_path_to_string(s : BiophylobayesianPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_cluster_make(size : Int) -> BiophylobayesianCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_cluster_len(s : BiophylobayesianCluster) -> Int { s.size }

pub fn bio_phylo_bayesian_cluster_get(s : BiophylobayesianCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_cluster_set(s : BiophylobayesianCluster, i : Int, v : Double) -> BiophylobayesianCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_cluster_sum(s : BiophylobayesianCluster) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_cluster_mean(s : BiophylobayesianCluster) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_cluster_scale(s : BiophylobayesianCluster, f : Double) -> BiophylobayesianCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_cluster_add(a : BiophylobayesianCluster, b : BiophylobayesianCluster) -> BiophylobayesianCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_cluster_copy(s : BiophylobayesianCluster) -> BiophylobayesianCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_cluster_fill(s : BiophylobayesianCluster, v : Double) -> BiophylobayesianCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_cluster_min(s : BiophylobayesianCluster) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_cluster_max(s : BiophylobayesianCluster) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_cluster_to_string(s : BiophylobayesianCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_model_make(size : Int) -> BiophylobayesianModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_model_len(s : BiophylobayesianModel) -> Int { s.size }

pub fn bio_phylo_bayesian_model_get(s : BiophylobayesianModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_model_set(s : BiophylobayesianModel, i : Int, v : Double) -> BiophylobayesianModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_model_sum(s : BiophylobayesianModel) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_model_mean(s : BiophylobayesianModel) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_model_scale(s : BiophylobayesianModel, f : Double) -> BiophylobayesianModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_model_add(a : BiophylobayesianModel, b : BiophylobayesianModel) -> BiophylobayesianModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_model_copy(s : BiophylobayesianModel) -> BiophylobayesianModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_model_fill(s : BiophylobayesianModel, v : Double) -> BiophylobayesianModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_model_min(s : BiophylobayesianModel) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_model_max(s : BiophylobayesianModel) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_model_to_string(s : BiophylobayesianModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_layer_make(size : Int) -> BiophylobayesianLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_layer_len(s : BiophylobayesianLayer) -> Int { s.size }

pub fn bio_phylo_bayesian_layer_get(s : BiophylobayesianLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_layer_set(s : BiophylobayesianLayer, i : Int, v : Double) -> BiophylobayesianLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_layer_sum(s : BiophylobayesianLayer) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_layer_mean(s : BiophylobayesianLayer) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_layer_scale(s : BiophylobayesianLayer, f : Double) -> BiophylobayesianLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_layer_add(a : BiophylobayesianLayer, b : BiophylobayesianLayer) -> BiophylobayesianLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_layer_copy(s : BiophylobayesianLayer) -> BiophylobayesianLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_layer_fill(s : BiophylobayesianLayer, v : Double) -> BiophylobayesianLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_layer_min(s : BiophylobayesianLayer) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_layer_max(s : BiophylobayesianLayer) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_layer_to_string(s : BiophylobayesianLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_buffer_make(size : Int) -> BiophylobayesianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_buffer_len(s : BiophylobayesianBuffer) -> Int { s.size }

pub fn bio_phylo_bayesian_buffer_get(s : BiophylobayesianBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_buffer_set(s : BiophylobayesianBuffer, i : Int, v : Double) -> BiophylobayesianBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_buffer_sum(s : BiophylobayesianBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_buffer_mean(s : BiophylobayesianBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_buffer_scale(s : BiophylobayesianBuffer, f : Double) -> BiophylobayesianBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_buffer_add(a : BiophylobayesianBuffer, b : BiophylobayesianBuffer) -> BiophylobayesianBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_buffer_copy(s : BiophylobayesianBuffer) -> BiophylobayesianBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_buffer_fill(s : BiophylobayesianBuffer, v : Double) -> BiophylobayesianBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_buffer_min(s : BiophylobayesianBuffer) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_buffer_max(s : BiophylobayesianBuffer) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_buffer_to_string(s : BiophylobayesianBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_cursor_make(size : Int) -> BiophylobayesianCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_cursor_len(s : BiophylobayesianCursor) -> Int { s.size }

pub fn bio_phylo_bayesian_cursor_get(s : BiophylobayesianCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_cursor_set(s : BiophylobayesianCursor, i : Int, v : Double) -> BiophylobayesianCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_cursor_sum(s : BiophylobayesianCursor) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_cursor_mean(s : BiophylobayesianCursor) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_cursor_scale(s : BiophylobayesianCursor, f : Double) -> BiophylobayesianCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_cursor_add(a : BiophylobayesianCursor, b : BiophylobayesianCursor) -> BiophylobayesianCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_cursor_copy(s : BiophylobayesianCursor) -> BiophylobayesianCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_cursor_fill(s : BiophylobayesianCursor, v : Double) -> BiophylobayesianCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_cursor_min(s : BiophylobayesianCursor) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_cursor_max(s : BiophylobayesianCursor) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_cursor_to_string(s : BiophylobayesianCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_view_make(size : Int) -> BiophylobayesianView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_view_len(s : BiophylobayesianView) -> Int { s.size }

pub fn bio_phylo_bayesian_view_get(s : BiophylobayesianView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_view_set(s : BiophylobayesianView, i : Int, v : Double) -> BiophylobayesianView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_view_sum(s : BiophylobayesianView) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_view_mean(s : BiophylobayesianView) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_view_scale(s : BiophylobayesianView, f : Double) -> BiophylobayesianView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_view_add(a : BiophylobayesianView, b : BiophylobayesianView) -> BiophylobayesianView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_view_copy(s : BiophylobayesianView) -> BiophylobayesianView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_view_fill(s : BiophylobayesianView, v : Double) -> BiophylobayesianView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_view_min(s : BiophylobayesianView) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_view_max(s : BiophylobayesianView) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_view_to_string(s : BiophylobayesianView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_range_make(size : Int) -> BiophylobayesianRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_range_len(s : BiophylobayesianRange) -> Int { s.size }

pub fn bio_phylo_bayesian_range_get(s : BiophylobayesianRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_range_set(s : BiophylobayesianRange, i : Int, v : Double) -> BiophylobayesianRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_range_sum(s : BiophylobayesianRange) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_range_mean(s : BiophylobayesianRange) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_range_scale(s : BiophylobayesianRange, f : Double) -> BiophylobayesianRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_range_add(a : BiophylobayesianRange, b : BiophylobayesianRange) -> BiophylobayesianRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_range_copy(s : BiophylobayesianRange) -> BiophylobayesianRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_range_fill(s : BiophylobayesianRange, v : Double) -> BiophylobayesianRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_range_min(s : BiophylobayesianRange) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_range_max(s : BiophylobayesianRange) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_range_to_string(s : BiophylobayesianRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_slice_make(size : Int) -> BiophylobayesianSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_slice_len(s : BiophylobayesianSlice) -> Int { s.size }

pub fn bio_phylo_bayesian_slice_get(s : BiophylobayesianSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_slice_set(s : BiophylobayesianSlice, i : Int, v : Double) -> BiophylobayesianSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_slice_sum(s : BiophylobayesianSlice) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_slice_mean(s : BiophylobayesianSlice) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_slice_scale(s : BiophylobayesianSlice, f : Double) -> BiophylobayesianSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_slice_add(a : BiophylobayesianSlice, b : BiophylobayesianSlice) -> BiophylobayesianSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_slice_copy(s : BiophylobayesianSlice) -> BiophylobayesianSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_slice_fill(s : BiophylobayesianSlice, v : Double) -> BiophylobayesianSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_slice_min(s : BiophylobayesianSlice) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_slice_max(s : BiophylobayesianSlice) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_slice_to_string(s : BiophylobayesianSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

