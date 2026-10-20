///===
/// extcore/bio_phylo_maximum

pub(all) struct BiophylomaximumPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_maximum_make_point(x : Double, y : Double) -> BiophylomaximumPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_maximum_make_point3(x : Double, y : Double, z : Double) -> BiophylomaximumPoint {
  { x, y, z, label: 0 }
}

pub fn bio_phylo_maximum_point_x(pt : BiophylomaximumPoint) -> Double { pt.x }

pub fn bio_phylo_maximum_point_y(pt : BiophylomaximumPoint) -> Double { pt.y }

pub fn bio_phylo_maximum_point_z(pt : BiophylomaximumPoint) -> Double { pt.z }

pub fn bio_phylo_maximum_point_label(pt : BiophylomaximumPoint) -> Int { pt.label }

pub fn bio_phylo_maximum_point_dist(a : BiophylomaximumPoint, b : BiophylomaximumPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_phylo_maximum_point_add(a : BiophylomaximumPoint, b : BiophylomaximumPoint) -> BiophylomaximumPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_phylo_maximum_point_sub(a : BiophylomaximumPoint, b : BiophylomaximumPoint) -> BiophylomaximumPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_phylo_maximum_point_scale(pt : BiophylomaximumPoint, s : Double) -> BiophylomaximumPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_phylo_maximum_point_dot(a : BiophylomaximumPoint, b : BiophylomaximumPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_phylo_maximum_point_cross(a : BiophylomaximumPoint, b : BiophylomaximumPoint) -> BiophylomaximumPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_phylo_maximum_point_norm(pt : BiophylomaximumPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_phylo_maximum_point_normalize(pt : BiophylomaximumPoint) -> BiophylomaximumPoint {
  let n = bio_phylo_maximum_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_phylo_maximum_point_scale(pt, 1.0 / n) }
}

pub fn bio_phylo_maximum_point_negate(pt : BiophylomaximumPoint) -> BiophylomaximumPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_phylo_maximum_point_mid(a : BiophylomaximumPoint, b : BiophylomaximumPoint) -> BiophylomaximumPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_phylo_maximum_point_lerp(a : BiophylomaximumPoint, b : BiophylomaximumPoint, t : Double) -> BiophylomaximumPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_phylo_maximum_point_to_string(pt : BiophylomaximumPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BiophylomaximumSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_maximum_make_series(vals : Array[Double], name : String) -> BiophylomaximumSeries {
  { vals, name, meta: 0 }
}

pub fn bio_phylo_maximum_series_len(s : BiophylomaximumSeries) -> Int { s.vals.length() }

pub fn bio_phylo_maximum_series_sum(s : BiophylomaximumSeries) -> Double { @_common.sum(s.vals) }

pub fn bio_phylo_maximum_series_mean(s : BiophylomaximumSeries) -> Double { @_common.mean(s.vals) }

pub fn bio_phylo_maximum_series_min(s : BiophylomaximumSeries) -> Double { @_common.min(s.vals) }

pub fn bio_phylo_maximum_series_max(s : BiophylomaximumSeries) -> Double { @_common.max(s.vals) }

pub fn bio_phylo_maximum_series_range(s : BiophylomaximumSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn bio_phylo_maximum_series_var(s : BiophylomaximumSeries) -> Double { @_common.variance(s.vals) }

pub fn bio_phylo_maximum_series_std(s : BiophylomaximumSeries) -> Double { @_common.std(s.vals) }

pub fn bio_phylo_maximum_series_median(s : BiophylomaximumSeries) -> Double { @_common.median(s.vals) }

pub fn bio_phylo_maximum_series_scale(s : BiophylomaximumSeries, f : Double) -> BiophylomaximumSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_phylo_maximum_series_add(a : BiophylomaximumSeries, b : BiophylomaximumSeries) -> BiophylomaximumSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_phylo_maximum_series_sub(a : BiophylomaximumSeries, b : BiophylomaximumSeries) -> BiophylomaximumSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_phylo_maximum_series_normalize(s : BiophylomaximumSeries) -> BiophylomaximumSeries {
  let mn = bio_phylo_maximum_series_min(s)
  let mx = bio_phylo_maximum_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_phylo_maximum_series_cumsum(s : BiophylomaximumSeries) -> BiophylomaximumSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_phylo_maximum_series_to_string(s : BiophylomaximumSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophylomaximumMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_maximum_make_matrix(rows : Int, cols : Int, val : Double) -> BiophylomaximumMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_phylo_maximum_matrix_identity(n : Int) -> BiophylomaximumMatrix {
  let m = bio_phylo_maximum_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_phylo_maximum_matrix_get(m : BiophylomaximumMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_phylo_maximum_matrix_transpose(m : BiophylomaximumMatrix) -> BiophylomaximumMatrix {
  let result = bio_phylo_maximum_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_phylo_maximum_matrix_add(a : BiophylomaximumMatrix, b : BiophylomaximumMatrix) -> BiophylomaximumMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_phylo_maximum_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_phylo_maximum_matrix_scale(m : BiophylomaximumMatrix, s : Double) -> BiophylomaximumMatrix {
  let result = bio_phylo_maximum_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_phylo_maximum_matrix_multiply(a : BiophylomaximumMatrix, b : BiophylomaximumMatrix) -> BiophylomaximumMatrix {
  if a.cols != b.rows { return bio_phylo_maximum_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_phylo_maximum_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_phylo_maximum_matrix_trace(m : BiophylomaximumMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_phylo_maximum_matrix_det(m : BiophylomaximumMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_phylo_maximum_matrix_norm(m : BiophylomaximumMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_phylo_maximum_matrix_to_string(m : BiophylomaximumMatrix) -> String {
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

pub(all) struct BiophylomaximumVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_maximum_make_vector(comps : Array[Double]) -> BiophylomaximumVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_maximum_vector_zero(dim : Int) -> BiophylomaximumVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_phylo_maximum_vector_add(a : BiophylomaximumVector, b : BiophylomaximumVector) -> BiophylomaximumVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_phylo_maximum_vector_sub(a : BiophylomaximumVector, b : BiophylomaximumVector) -> BiophylomaximumVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_phylo_maximum_vector_scale(v : BiophylomaximumVector, s : Double) -> BiophylomaximumVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_phylo_maximum_vector_dot(a : BiophylomaximumVector, b : BiophylomaximumVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_phylo_maximum_vector_norm(v : BiophylomaximumVector) -> Double { @_common.sqrt(bio_phylo_maximum_vector_dot(v, v)) }

pub fn bio_phylo_maximum_vector_normalize(v : BiophylomaximumVector) -> BiophylomaximumVector {
  let n = bio_phylo_maximum_vector_norm(v)
  if n < 0.0000001 { v } else { bio_phylo_maximum_vector_scale(v, 1.0 / n) }
}

pub fn bio_phylo_maximum_vector_dist(a : BiophylomaximumVector, b : BiophylomaximumVector) -> Double {
  bio_phylo_maximum_vector_norm(bio_phylo_maximum_vector_sub(a, b))
}

pub fn bio_phylo_maximum_vector_to_string(v : BiophylomaximumVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_phylo_maximum_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_phylo_maximum_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_phylo_maximum_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_phylo_maximum_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_phylo_maximum_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_phylo_maximum_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_phylo_maximum_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_phylo_maximum_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_phylo_maximum_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_phylo_maximum_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_phylo_maximum_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_phylo_maximum_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_phylo_maximum_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_phylo_maximum_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_phylo_maximum_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_phylo_maximum_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_phylo_maximum_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_phylo_maximum_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_phylo_maximum_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_phylo_maximum_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_phylo_maximum_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_phylo_maximum_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_phylo_maximum_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_phylo_maximum_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_phylo_maximum_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_phylo_maximum_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_phylo_maximum_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_phylo_maximum_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_phylo_maximum_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiophylomaximumFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_frame_make(size : Int) -> BiophylomaximumFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_frame_len(s : BiophylomaximumFrame) -> Int { s.size }

pub fn bio_phylo_maximum_frame_get(s : BiophylomaximumFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_frame_set(s : BiophylomaximumFrame, i : Int, v : Double) -> BiophylomaximumFrame {
  let result = bio_phylo_maximum_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_frame_sum(s : BiophylomaximumFrame) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_frame_mean(s : BiophylomaximumFrame) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_frame_scale(s : BiophylomaximumFrame, f : Double) -> BiophylomaximumFrame {
  let result = bio_phylo_maximum_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_maximum_frame_add(a : BiophylomaximumFrame, b : BiophylomaximumFrame) -> BiophylomaximumFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_maximum_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_maximum_frame_copy(s : BiophylomaximumFrame) -> BiophylomaximumFrame {
  let result = bio_phylo_maximum_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_maximum_frame_fill(s : BiophylomaximumFrame, v : Double) -> BiophylomaximumFrame {
  let result = bio_phylo_maximum_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_frame_min(s : BiophylomaximumFrame) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_frame_max(s : BiophylomaximumFrame) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_frame_to_string(s : BiophylomaximumFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_table_make(size : Int) -> BiophylomaximumTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_table_len(s : BiophylomaximumTable) -> Int { s.size }

pub fn bio_phylo_maximum_table_get(s : BiophylomaximumTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_table_set(s : BiophylomaximumTable, i : Int, v : Double) -> BiophylomaximumTable {
  let result = bio_phylo_maximum_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_table_sum(s : BiophylomaximumTable) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_table_mean(s : BiophylomaximumTable) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_table_scale(s : BiophylomaximumTable, f : Double) -> BiophylomaximumTable {
  let result = bio_phylo_maximum_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_maximum_table_add(a : BiophylomaximumTable, b : BiophylomaximumTable) -> BiophylomaximumTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_maximum_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_maximum_table_copy(s : BiophylomaximumTable) -> BiophylomaximumTable {
  let result = bio_phylo_maximum_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_maximum_table_fill(s : BiophylomaximumTable, v : Double) -> BiophylomaximumTable {
  let result = bio_phylo_maximum_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_table_min(s : BiophylomaximumTable) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_table_max(s : BiophylomaximumTable) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_table_to_string(s : BiophylomaximumTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_graphn_make(size : Int) -> BiophylomaximumGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_graphn_len(s : BiophylomaximumGraphN) -> Int { s.size }

pub fn bio_phylo_maximum_graphn_get(s : BiophylomaximumGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_graphn_set(s : BiophylomaximumGraphN, i : Int, v : Double) -> BiophylomaximumGraphN {
  let result = bio_phylo_maximum_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_graphn_sum(s : BiophylomaximumGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_graphn_mean(s : BiophylomaximumGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_graphn_scale(s : BiophylomaximumGraphN, f : Double) -> BiophylomaximumGraphN {
  let result = bio_phylo_maximum_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_maximum_graphn_add(a : BiophylomaximumGraphN, b : BiophylomaximumGraphN) -> BiophylomaximumGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_maximum_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_maximum_graphn_copy(s : BiophylomaximumGraphN) -> BiophylomaximumGraphN {
  let result = bio_phylo_maximum_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_maximum_graphn_fill(s : BiophylomaximumGraphN, v : Double) -> BiophylomaximumGraphN {
  let result = bio_phylo_maximum_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_graphn_min(s : BiophylomaximumGraphN) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_graphn_max(s : BiophylomaximumGraphN) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_graphn_to_string(s : BiophylomaximumGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_node_make(size : Int) -> BiophylomaximumNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_node_len(s : BiophylomaximumNode) -> Int { s.size }

pub fn bio_phylo_maximum_node_get(s : BiophylomaximumNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_node_set(s : BiophylomaximumNode, i : Int, v : Double) -> BiophylomaximumNode {
  let result = bio_phylo_maximum_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_node_sum(s : BiophylomaximumNode) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_node_mean(s : BiophylomaximumNode) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_node_scale(s : BiophylomaximumNode, f : Double) -> BiophylomaximumNode {
  let result = bio_phylo_maximum_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_maximum_node_add(a : BiophylomaximumNode, b : BiophylomaximumNode) -> BiophylomaximumNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_maximum_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_maximum_node_copy(s : BiophylomaximumNode) -> BiophylomaximumNode {
  let result = bio_phylo_maximum_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_maximum_node_fill(s : BiophylomaximumNode, v : Double) -> BiophylomaximumNode {
  let result = bio_phylo_maximum_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_node_min(s : BiophylomaximumNode) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_node_max(s : BiophylomaximumNode) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_node_to_string(s : BiophylomaximumNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_edge_make(size : Int) -> BiophylomaximumEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_edge_len(s : BiophylomaximumEdge) -> Int { s.size }

pub fn bio_phylo_maximum_edge_get(s : BiophylomaximumEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_edge_set(s : BiophylomaximumEdge, i : Int, v : Double) -> BiophylomaximumEdge {
  let result = bio_phylo_maximum_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_edge_sum(s : BiophylomaximumEdge) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_edge_mean(s : BiophylomaximumEdge) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_edge_scale(s : BiophylomaximumEdge, f : Double) -> BiophylomaximumEdge {
  let result = bio_phylo_maximum_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_maximum_edge_add(a : BiophylomaximumEdge, b : BiophylomaximumEdge) -> BiophylomaximumEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_maximum_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_maximum_edge_copy(s : BiophylomaximumEdge) -> BiophylomaximumEdge {
  let result = bio_phylo_maximum_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_maximum_edge_fill(s : BiophylomaximumEdge, v : Double) -> BiophylomaximumEdge {
  let result = bio_phylo_maximum_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_edge_min(s : BiophylomaximumEdge) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_edge_max(s : BiophylomaximumEdge) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_edge_to_string(s : BiophylomaximumEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_path_make(size : Int) -> BiophylomaximumPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_path_len(s : BiophylomaximumPath) -> Int { s.size }

pub fn bio_phylo_maximum_path_get(s : BiophylomaximumPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_path_set(s : BiophylomaximumPath, i : Int, v : Double) -> BiophylomaximumPath {
  let result = bio_phylo_maximum_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_path_sum(s : BiophylomaximumPath) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_path_mean(s : BiophylomaximumPath) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_path_scale(s : BiophylomaximumPath, f : Double) -> BiophylomaximumPath {
  let result = bio_phylo_maximum_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_maximum_path_add(a : BiophylomaximumPath, b : BiophylomaximumPath) -> BiophylomaximumPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_maximum_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_maximum_path_copy(s : BiophylomaximumPath) -> BiophylomaximumPath {
  let result = bio_phylo_maximum_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_maximum_path_fill(s : BiophylomaximumPath, v : Double) -> BiophylomaximumPath {
  let result = bio_phylo_maximum_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_path_min(s : BiophylomaximumPath) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_path_max(s : BiophylomaximumPath) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_path_to_string(s : BiophylomaximumPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_cluster_make(size : Int) -> BiophylomaximumCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_cluster_len(s : BiophylomaximumCluster) -> Int { s.size }

pub fn bio_phylo_maximum_cluster_get(s : BiophylomaximumCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_cluster_set(s : BiophylomaximumCluster, i : Int, v : Double) -> BiophylomaximumCluster {
  let result = bio_phylo_maximum_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_cluster_sum(s : BiophylomaximumCluster) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_cluster_mean(s : BiophylomaximumCluster) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_cluster_scale(s : BiophylomaximumCluster, f : Double) -> BiophylomaximumCluster {
  let result = bio_phylo_maximum_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_maximum_cluster_add(a : BiophylomaximumCluster, b : BiophylomaximumCluster) -> BiophylomaximumCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_maximum_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_maximum_cluster_copy(s : BiophylomaximumCluster) -> BiophylomaximumCluster {
  let result = bio_phylo_maximum_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_maximum_cluster_fill(s : BiophylomaximumCluster, v : Double) -> BiophylomaximumCluster {
  let result = bio_phylo_maximum_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_cluster_min(s : BiophylomaximumCluster) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_cluster_max(s : BiophylomaximumCluster) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_cluster_to_string(s : BiophylomaximumCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_model_make(size : Int) -> BiophylomaximumModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_model_len(s : BiophylomaximumModel) -> Int { s.size }

pub fn bio_phylo_maximum_model_get(s : BiophylomaximumModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_model_set(s : BiophylomaximumModel, i : Int, v : Double) -> BiophylomaximumModel {
  let result = bio_phylo_maximum_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_model_sum(s : BiophylomaximumModel) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_model_mean(s : BiophylomaximumModel) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_model_scale(s : BiophylomaximumModel, f : Double) -> BiophylomaximumModel {
  let result = bio_phylo_maximum_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_maximum_model_add(a : BiophylomaximumModel, b : BiophylomaximumModel) -> BiophylomaximumModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_maximum_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_maximum_model_copy(s : BiophylomaximumModel) -> BiophylomaximumModel {
  let result = bio_phylo_maximum_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_maximum_model_fill(s : BiophylomaximumModel, v : Double) -> BiophylomaximumModel {
  let result = bio_phylo_maximum_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_model_min(s : BiophylomaximumModel) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_model_max(s : BiophylomaximumModel) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_model_to_string(s : BiophylomaximumModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_layer_make(size : Int) -> BiophylomaximumLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_layer_len(s : BiophylomaximumLayer) -> Int { s.size }

pub fn bio_phylo_maximum_layer_get(s : BiophylomaximumLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_layer_set(s : BiophylomaximumLayer, i : Int, v : Double) -> BiophylomaximumLayer {
  let result = bio_phylo_maximum_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_layer_sum(s : BiophylomaximumLayer) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_layer_mean(s : BiophylomaximumLayer) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_layer_scale(s : BiophylomaximumLayer, f : Double) -> BiophylomaximumLayer {
  let result = bio_phylo_maximum_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_maximum_layer_add(a : BiophylomaximumLayer, b : BiophylomaximumLayer) -> BiophylomaximumLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_maximum_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_maximum_layer_copy(s : BiophylomaximumLayer) -> BiophylomaximumLayer {
  let result = bio_phylo_maximum_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_maximum_layer_fill(s : BiophylomaximumLayer, v : Double) -> BiophylomaximumLayer {
  let result = bio_phylo_maximum_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_layer_min(s : BiophylomaximumLayer) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_layer_max(s : BiophylomaximumLayer) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_layer_to_string(s : BiophylomaximumLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_buffer_make(size : Int) -> BiophylomaximumBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_buffer_len(s : BiophylomaximumBuffer) -> Int { s.size }

pub fn bio_phylo_maximum_buffer_get(s : BiophylomaximumBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_buffer_set(s : BiophylomaximumBuffer, i : Int, v : Double) -> BiophylomaximumBuffer {
  let result = bio_phylo_maximum_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_buffer_sum(s : BiophylomaximumBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_buffer_mean(s : BiophylomaximumBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_buffer_scale(s : BiophylomaximumBuffer, f : Double) -> BiophylomaximumBuffer {
  let result = bio_phylo_maximum_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_maximum_buffer_add(a : BiophylomaximumBuffer, b : BiophylomaximumBuffer) -> BiophylomaximumBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_maximum_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_maximum_buffer_copy(s : BiophylomaximumBuffer) -> BiophylomaximumBuffer {
  let result = bio_phylo_maximum_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_maximum_buffer_fill(s : BiophylomaximumBuffer, v : Double) -> BiophylomaximumBuffer {
  let result = bio_phylo_maximum_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_buffer_min(s : BiophylomaximumBuffer) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_buffer_max(s : BiophylomaximumBuffer) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_buffer_to_string(s : BiophylomaximumBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_cursor_make(size : Int) -> BiophylomaximumCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_cursor_len(s : BiophylomaximumCursor) -> Int { s.size }

pub fn bio_phylo_maximum_cursor_get(s : BiophylomaximumCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_cursor_set(s : BiophylomaximumCursor, i : Int, v : Double) -> BiophylomaximumCursor {
  let result = bio_phylo_maximum_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_cursor_sum(s : BiophylomaximumCursor) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_cursor_mean(s : BiophylomaximumCursor) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_cursor_scale(s : BiophylomaximumCursor, f : Double) -> BiophylomaximumCursor {
  let result = bio_phylo_maximum_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_maximum_cursor_add(a : BiophylomaximumCursor, b : BiophylomaximumCursor) -> BiophylomaximumCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_maximum_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_maximum_cursor_copy(s : BiophylomaximumCursor) -> BiophylomaximumCursor {
  let result = bio_phylo_maximum_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_maximum_cursor_fill(s : BiophylomaximumCursor, v : Double) -> BiophylomaximumCursor {
  let result = bio_phylo_maximum_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_cursor_min(s : BiophylomaximumCursor) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_cursor_max(s : BiophylomaximumCursor) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_cursor_to_string(s : BiophylomaximumCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_view_make(size : Int) -> BiophylomaximumView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_view_len(s : BiophylomaximumView) -> Int { s.size }

pub fn bio_phylo_maximum_view_get(s : BiophylomaximumView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_view_set(s : BiophylomaximumView, i : Int, v : Double) -> BiophylomaximumView {
  let result = bio_phylo_maximum_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_view_sum(s : BiophylomaximumView) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_view_mean(s : BiophylomaximumView) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_view_scale(s : BiophylomaximumView, f : Double) -> BiophylomaximumView {
  let result = bio_phylo_maximum_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_maximum_view_add(a : BiophylomaximumView, b : BiophylomaximumView) -> BiophylomaximumView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_maximum_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_maximum_view_copy(s : BiophylomaximumView) -> BiophylomaximumView {
  let result = bio_phylo_maximum_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_maximum_view_fill(s : BiophylomaximumView, v : Double) -> BiophylomaximumView {
  let result = bio_phylo_maximum_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_view_min(s : BiophylomaximumView) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_view_max(s : BiophylomaximumView) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_view_to_string(s : BiophylomaximumView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_range_make(size : Int) -> BiophylomaximumRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_range_len(s : BiophylomaximumRange) -> Int { s.size }

pub fn bio_phylo_maximum_range_get(s : BiophylomaximumRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_range_set(s : BiophylomaximumRange, i : Int, v : Double) -> BiophylomaximumRange {
  let result = bio_phylo_maximum_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_range_sum(s : BiophylomaximumRange) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_range_mean(s : BiophylomaximumRange) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_range_scale(s : BiophylomaximumRange, f : Double) -> BiophylomaximumRange {
  let result = bio_phylo_maximum_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_maximum_range_add(a : BiophylomaximumRange, b : BiophylomaximumRange) -> BiophylomaximumRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_maximum_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_maximum_range_copy(s : BiophylomaximumRange) -> BiophylomaximumRange {
  let result = bio_phylo_maximum_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_maximum_range_fill(s : BiophylomaximumRange, v : Double) -> BiophylomaximumRange {
  let result = bio_phylo_maximum_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_range_min(s : BiophylomaximumRange) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_range_max(s : BiophylomaximumRange) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_range_to_string(s : BiophylomaximumRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_slice_make(size : Int) -> BiophylomaximumSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_slice_len(s : BiophylomaximumSlice) -> Int { s.size }

pub fn bio_phylo_maximum_slice_get(s : BiophylomaximumSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_slice_set(s : BiophylomaximumSlice, i : Int, v : Double) -> BiophylomaximumSlice {
  let result = bio_phylo_maximum_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_slice_sum(s : BiophylomaximumSlice) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_slice_mean(s : BiophylomaximumSlice) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_slice_scale(s : BiophylomaximumSlice, f : Double) -> BiophylomaximumSlice {
  let result = bio_phylo_maximum_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_maximum_slice_add(a : BiophylomaximumSlice, b : BiophylomaximumSlice) -> BiophylomaximumSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_maximum_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_maximum_slice_copy(s : BiophylomaximumSlice) -> BiophylomaximumSlice {
  let result = bio_phylo_maximum_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_maximum_slice_fill(s : BiophylomaximumSlice, v : Double) -> BiophylomaximumSlice {
  let result = bio_phylo_maximum_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_maximum_slice_min(s : BiophylomaximumSlice) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_slice_max(s : BiophylomaximumSlice) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_slice_to_string(s : BiophylomaximumSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

