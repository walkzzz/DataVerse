///===
/// extcore/bio_phylo_tree_split

pub(all) struct BiophylotreesplitPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_tree_split_make_point(x : Double, y : Double) -> BiophylotreesplitPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_tree_split_make_point3(x : Double, y : Double, z : Double) -> BiophylotreesplitPoint {
  { x, y, z, label: 0 }
}

pub fn bio_phylo_tree_split_point_x(pt : BiophylotreesplitPoint) -> Double { pt.x }

pub fn bio_phylo_tree_split_point_y(pt : BiophylotreesplitPoint) -> Double { pt.y }

pub fn bio_phylo_tree_split_point_z(pt : BiophylotreesplitPoint) -> Double { pt.z }

pub fn bio_phylo_tree_split_point_label(pt : BiophylotreesplitPoint) -> Int { pt.label }

pub fn bio_phylo_tree_split_point_dist(a : BiophylotreesplitPoint, b : BiophylotreesplitPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_phylo_tree_split_point_add(a : BiophylotreesplitPoint, b : BiophylotreesplitPoint) -> BiophylotreesplitPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_phylo_tree_split_point_sub(a : BiophylotreesplitPoint, b : BiophylotreesplitPoint) -> BiophylotreesplitPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_phylo_tree_split_point_scale(pt : BiophylotreesplitPoint, s : Double) -> BiophylotreesplitPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_phylo_tree_split_point_dot(a : BiophylotreesplitPoint, b : BiophylotreesplitPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_phylo_tree_split_point_cross(a : BiophylotreesplitPoint, b : BiophylotreesplitPoint) -> BiophylotreesplitPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_phylo_tree_split_point_norm(pt : BiophylotreesplitPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_phylo_tree_split_point_normalize(pt : BiophylotreesplitPoint) -> BiophylotreesplitPoint {
  let n = bio_phylo_tree_split_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_phylo_tree_split_point_scale(pt, 1.0 / n) }
}

pub fn bio_phylo_tree_split_point_negate(pt : BiophylotreesplitPoint) -> BiophylotreesplitPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_phylo_tree_split_point_mid(a : BiophylotreesplitPoint, b : BiophylotreesplitPoint) -> BiophylotreesplitPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_phylo_tree_split_point_lerp(a : BiophylotreesplitPoint, b : BiophylotreesplitPoint, t : Double) -> BiophylotreesplitPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_phylo_tree_split_point_to_string(pt : BiophylotreesplitPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BiophylotreesplitSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_tree_split_make_series(vals : Array[Double], name : String) -> BiophylotreesplitSeries {
  { vals, name, meta: 0 }
}

pub fn bio_phylo_tree_split_series_len(s : BiophylotreesplitSeries) -> Int { s.vals.length() }

pub fn bio_phylo_tree_split_series_sum(s : BiophylotreesplitSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_phylo_tree_split_series_mean(s : BiophylotreesplitSeries) -> Double { @_common.mean(s.vals) }

pub fn bio_phylo_tree_split_series_min(s : BiophylotreesplitSeries) -> Double { @_common.min(s.vals) }

pub fn bio_phylo_tree_split_series_max(s : BiophylotreesplitSeries) -> Double { @_common.max(s.vals) }

pub fn bio_phylo_tree_split_series_range(s : BiophylotreesplitSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn bio_phylo_tree_split_series_var(s : BiophylotreesplitSeries) -> Double { @_common.variance(s.vals) }

pub fn bio_phylo_tree_split_series_std(s : BiophylotreesplitSeries) -> Double { @_common.std(s.vals) }

pub fn bio_phylo_tree_split_series_median(s : BiophylotreesplitSeries) -> Double { @_common.median(s.vals) }

pub fn bio_phylo_tree_split_series_scale(s : BiophylotreesplitSeries, f : Double) -> BiophylotreesplitSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_phylo_tree_split_series_add(a : BiophylotreesplitSeries, b : BiophylotreesplitSeries) -> BiophylotreesplitSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_phylo_tree_split_series_sub(a : BiophylotreesplitSeries, b : BiophylotreesplitSeries) -> BiophylotreesplitSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_phylo_tree_split_series_normalize(s : BiophylotreesplitSeries) -> BiophylotreesplitSeries {
  let mn = bio_phylo_tree_split_series_min(s)
  let mx = bio_phylo_tree_split_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_phylo_tree_split_series_cumsum(s : BiophylotreesplitSeries) -> BiophylotreesplitSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_phylo_tree_split_series_to_string(s : BiophylotreesplitSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophylotreesplitMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_tree_split_make_matrix(rows : Int, cols : Int, val : Double) -> BiophylotreesplitMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_phylo_tree_split_matrix_identity(n : Int) -> BiophylotreesplitMatrix {
  let m = bio_phylo_tree_split_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_phylo_tree_split_matrix_get(m : BiophylotreesplitMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_phylo_tree_split_matrix_transpose(m : BiophylotreesplitMatrix) -> BiophylotreesplitMatrix {
  let result = bio_phylo_tree_split_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_phylo_tree_split_matrix_add(a : BiophylotreesplitMatrix, b : BiophylotreesplitMatrix) -> BiophylotreesplitMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_phylo_tree_split_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_phylo_tree_split_matrix_scale(m : BiophylotreesplitMatrix, s : Double) -> BiophylotreesplitMatrix {
  let result = bio_phylo_tree_split_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_phylo_tree_split_matrix_multiply(a : BiophylotreesplitMatrix, b : BiophylotreesplitMatrix) -> BiophylotreesplitMatrix {
  if a.cols != b.rows { return bio_phylo_tree_split_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_phylo_tree_split_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_phylo_tree_split_matrix_trace(m : BiophylotreesplitMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_phylo_tree_split_matrix_det(m : BiophylotreesplitMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_phylo_tree_split_matrix_norm(m : BiophylotreesplitMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_phylo_tree_split_matrix_to_string(m : BiophylotreesplitMatrix) -> String {
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

pub(all) struct BiophylotreesplitVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_tree_split_make_vector(comps : Array[Double]) -> BiophylotreesplitVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_tree_split_vector_zero(dim : Int) -> BiophylotreesplitVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_phylo_tree_split_vector_add(a : BiophylotreesplitVector, b : BiophylotreesplitVector) -> BiophylotreesplitVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_phylo_tree_split_vector_sub(a : BiophylotreesplitVector, b : BiophylotreesplitVector) -> BiophylotreesplitVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_phylo_tree_split_vector_scale(v : BiophylotreesplitVector, s : Double) -> BiophylotreesplitVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_phylo_tree_split_vector_dot(a : BiophylotreesplitVector, b : BiophylotreesplitVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_phylo_tree_split_vector_norm(v : BiophylotreesplitVector) -> Double { @_common.sqrt(bio_phylo_tree_split_vector_dot(v, v)) }

pub fn bio_phylo_tree_split_vector_normalize(v : BiophylotreesplitVector) -> BiophylotreesplitVector {
  let n = bio_phylo_tree_split_vector_norm(v)
  if n < 0.0000001 { v } else { bio_phylo_tree_split_vector_scale(v, 1.0 / n) }
}

pub fn bio_phylo_tree_split_vector_dist(a : BiophylotreesplitVector, b : BiophylotreesplitVector) -> Double {
  bio_phylo_tree_split_vector_norm(bio_phylo_tree_split_vector_sub(a, b))
}

pub fn bio_phylo_tree_split_vector_to_string(v : BiophylotreesplitVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_phylo_tree_split_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_phylo_tree_split_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_phylo_tree_split_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_phylo_tree_split_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_phylo_tree_split_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_phylo_tree_split_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_phylo_tree_split_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_phylo_tree_split_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_phylo_tree_split_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_phylo_tree_split_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_phylo_tree_split_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_phylo_tree_split_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_phylo_tree_split_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_phylo_tree_split_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_phylo_tree_split_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_phylo_tree_split_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_phylo_tree_split_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_phylo_tree_split_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_phylo_tree_split_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_phylo_tree_split_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_phylo_tree_split_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_phylo_tree_split_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_phylo_tree_split_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_phylo_tree_split_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_phylo_tree_split_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_phylo_tree_split_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_phylo_tree_split_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_phylo_tree_split_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_phylo_tree_split_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiophylotreesplitFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_frame_make(size : Int) -> BiophylotreesplitFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_frame_len(s : BiophylotreesplitFrame) -> Int { s.size }

pub fn bio_phylo_tree_split_frame_get(s : BiophylotreesplitFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_frame_set(s : BiophylotreesplitFrame, i : Int, v : Double) -> BiophylotreesplitFrame {
  let result = bio_phylo_tree_split_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_frame_sum(s : BiophylotreesplitFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_tree_split_frame_mean(s : BiophylotreesplitFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_tree_split_frame_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_tree_split_frame_scale(s : BiophylotreesplitFrame, f : Double) -> BiophylotreesplitFrame {
  let result = bio_phylo_tree_split_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_tree_split_frame_add(a : BiophylotreesplitFrame, b : BiophylotreesplitFrame) -> BiophylotreesplitFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_tree_split_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_tree_split_frame_copy(s : BiophylotreesplitFrame) -> BiophylotreesplitFrame {
  let result = bio_phylo_tree_split_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_tree_split_frame_fill(s : BiophylotreesplitFrame, v : Double) -> BiophylotreesplitFrame {
  let result = bio_phylo_tree_split_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_frame_min(s : BiophylotreesplitFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_frame_max(s : BiophylotreesplitFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_frame_to_string(s : BiophylotreesplitFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_table_make(size : Int) -> BiophylotreesplitTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_table_len(s : BiophylotreesplitTable) -> Int { s.size }

pub fn bio_phylo_tree_split_table_get(s : BiophylotreesplitTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_table_set(s : BiophylotreesplitTable, i : Int, v : Double) -> BiophylotreesplitTable {
  let result = bio_phylo_tree_split_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_table_sum(s : BiophylotreesplitTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_tree_split_table_mean(s : BiophylotreesplitTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_tree_split_table_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_tree_split_table_scale(s : BiophylotreesplitTable, f : Double) -> BiophylotreesplitTable {
  let result = bio_phylo_tree_split_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_tree_split_table_add(a : BiophylotreesplitTable, b : BiophylotreesplitTable) -> BiophylotreesplitTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_tree_split_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_tree_split_table_copy(s : BiophylotreesplitTable) -> BiophylotreesplitTable {
  let result = bio_phylo_tree_split_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_tree_split_table_fill(s : BiophylotreesplitTable, v : Double) -> BiophylotreesplitTable {
  let result = bio_phylo_tree_split_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_table_min(s : BiophylotreesplitTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_table_max(s : BiophylotreesplitTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_table_to_string(s : BiophylotreesplitTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_graphn_make(size : Int) -> BiophylotreesplitGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_graphn_len(s : BiophylotreesplitGraphN) -> Int { s.size }

pub fn bio_phylo_tree_split_graphn_get(s : BiophylotreesplitGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_graphn_set(s : BiophylotreesplitGraphN, i : Int, v : Double) -> BiophylotreesplitGraphN {
  let result = bio_phylo_tree_split_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_graphn_sum(s : BiophylotreesplitGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_tree_split_graphn_mean(s : BiophylotreesplitGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_tree_split_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_tree_split_graphn_scale(s : BiophylotreesplitGraphN, f : Double) -> BiophylotreesplitGraphN {
  let result = bio_phylo_tree_split_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_tree_split_graphn_add(a : BiophylotreesplitGraphN, b : BiophylotreesplitGraphN) -> BiophylotreesplitGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_tree_split_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_tree_split_graphn_copy(s : BiophylotreesplitGraphN) -> BiophylotreesplitGraphN {
  let result = bio_phylo_tree_split_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_tree_split_graphn_fill(s : BiophylotreesplitGraphN, v : Double) -> BiophylotreesplitGraphN {
  let result = bio_phylo_tree_split_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_graphn_min(s : BiophylotreesplitGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_graphn_max(s : BiophylotreesplitGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_graphn_to_string(s : BiophylotreesplitGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_node_make(size : Int) -> BiophylotreesplitNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_node_len(s : BiophylotreesplitNode) -> Int { s.size }

pub fn bio_phylo_tree_split_node_get(s : BiophylotreesplitNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_node_set(s : BiophylotreesplitNode, i : Int, v : Double) -> BiophylotreesplitNode {
  let result = bio_phylo_tree_split_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_node_sum(s : BiophylotreesplitNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_tree_split_node_mean(s : BiophylotreesplitNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_tree_split_node_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_tree_split_node_scale(s : BiophylotreesplitNode, f : Double) -> BiophylotreesplitNode {
  let result = bio_phylo_tree_split_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_tree_split_node_add(a : BiophylotreesplitNode, b : BiophylotreesplitNode) -> BiophylotreesplitNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_tree_split_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_tree_split_node_copy(s : BiophylotreesplitNode) -> BiophylotreesplitNode {
  let result = bio_phylo_tree_split_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_tree_split_node_fill(s : BiophylotreesplitNode, v : Double) -> BiophylotreesplitNode {
  let result = bio_phylo_tree_split_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_node_min(s : BiophylotreesplitNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_node_max(s : BiophylotreesplitNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_node_to_string(s : BiophylotreesplitNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_edge_make(size : Int) -> BiophylotreesplitEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_edge_len(s : BiophylotreesplitEdge) -> Int { s.size }

pub fn bio_phylo_tree_split_edge_get(s : BiophylotreesplitEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_edge_set(s : BiophylotreesplitEdge, i : Int, v : Double) -> BiophylotreesplitEdge {
  let result = bio_phylo_tree_split_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_edge_sum(s : BiophylotreesplitEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_tree_split_edge_mean(s : BiophylotreesplitEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_tree_split_edge_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_tree_split_edge_scale(s : BiophylotreesplitEdge, f : Double) -> BiophylotreesplitEdge {
  let result = bio_phylo_tree_split_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_tree_split_edge_add(a : BiophylotreesplitEdge, b : BiophylotreesplitEdge) -> BiophylotreesplitEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_tree_split_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_tree_split_edge_copy(s : BiophylotreesplitEdge) -> BiophylotreesplitEdge {
  let result = bio_phylo_tree_split_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_tree_split_edge_fill(s : BiophylotreesplitEdge, v : Double) -> BiophylotreesplitEdge {
  let result = bio_phylo_tree_split_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_edge_min(s : BiophylotreesplitEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_edge_max(s : BiophylotreesplitEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_edge_to_string(s : BiophylotreesplitEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_path_make(size : Int) -> BiophylotreesplitPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_path_len(s : BiophylotreesplitPath) -> Int { s.size }

pub fn bio_phylo_tree_split_path_get(s : BiophylotreesplitPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_path_set(s : BiophylotreesplitPath, i : Int, v : Double) -> BiophylotreesplitPath {
  let result = bio_phylo_tree_split_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_path_sum(s : BiophylotreesplitPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_tree_split_path_mean(s : BiophylotreesplitPath) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_tree_split_path_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_tree_split_path_scale(s : BiophylotreesplitPath, f : Double) -> BiophylotreesplitPath {
  let result = bio_phylo_tree_split_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_tree_split_path_add(a : BiophylotreesplitPath, b : BiophylotreesplitPath) -> BiophylotreesplitPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_tree_split_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_tree_split_path_copy(s : BiophylotreesplitPath) -> BiophylotreesplitPath {
  let result = bio_phylo_tree_split_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_tree_split_path_fill(s : BiophylotreesplitPath, v : Double) -> BiophylotreesplitPath {
  let result = bio_phylo_tree_split_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_path_min(s : BiophylotreesplitPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_path_max(s : BiophylotreesplitPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_path_to_string(s : BiophylotreesplitPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_cluster_make(size : Int) -> BiophylotreesplitCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_cluster_len(s : BiophylotreesplitCluster) -> Int { s.size }

pub fn bio_phylo_tree_split_cluster_get(s : BiophylotreesplitCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_cluster_set(s : BiophylotreesplitCluster, i : Int, v : Double) -> BiophylotreesplitCluster {
  let result = bio_phylo_tree_split_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_cluster_sum(s : BiophylotreesplitCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_tree_split_cluster_mean(s : BiophylotreesplitCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_tree_split_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_tree_split_cluster_scale(s : BiophylotreesplitCluster, f : Double) -> BiophylotreesplitCluster {
  let result = bio_phylo_tree_split_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_tree_split_cluster_add(a : BiophylotreesplitCluster, b : BiophylotreesplitCluster) -> BiophylotreesplitCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_tree_split_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_tree_split_cluster_copy(s : BiophylotreesplitCluster) -> BiophylotreesplitCluster {
  let result = bio_phylo_tree_split_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_tree_split_cluster_fill(s : BiophylotreesplitCluster, v : Double) -> BiophylotreesplitCluster {
  let result = bio_phylo_tree_split_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_cluster_min(s : BiophylotreesplitCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_cluster_max(s : BiophylotreesplitCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_cluster_to_string(s : BiophylotreesplitCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_model_make(size : Int) -> BiophylotreesplitModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_model_len(s : BiophylotreesplitModel) -> Int { s.size }

pub fn bio_phylo_tree_split_model_get(s : BiophylotreesplitModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_model_set(s : BiophylotreesplitModel, i : Int, v : Double) -> BiophylotreesplitModel {
  let result = bio_phylo_tree_split_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_model_sum(s : BiophylotreesplitModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_tree_split_model_mean(s : BiophylotreesplitModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_tree_split_model_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_tree_split_model_scale(s : BiophylotreesplitModel, f : Double) -> BiophylotreesplitModel {
  let result = bio_phylo_tree_split_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_tree_split_model_add(a : BiophylotreesplitModel, b : BiophylotreesplitModel) -> BiophylotreesplitModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_tree_split_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_tree_split_model_copy(s : BiophylotreesplitModel) -> BiophylotreesplitModel {
  let result = bio_phylo_tree_split_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_tree_split_model_fill(s : BiophylotreesplitModel, v : Double) -> BiophylotreesplitModel {
  let result = bio_phylo_tree_split_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_model_min(s : BiophylotreesplitModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_model_max(s : BiophylotreesplitModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_model_to_string(s : BiophylotreesplitModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_layer_make(size : Int) -> BiophylotreesplitLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_layer_len(s : BiophylotreesplitLayer) -> Int { s.size }

pub fn bio_phylo_tree_split_layer_get(s : BiophylotreesplitLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_layer_set(s : BiophylotreesplitLayer, i : Int, v : Double) -> BiophylotreesplitLayer {
  let result = bio_phylo_tree_split_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_layer_sum(s : BiophylotreesplitLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_tree_split_layer_mean(s : BiophylotreesplitLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_tree_split_layer_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_tree_split_layer_scale(s : BiophylotreesplitLayer, f : Double) -> BiophylotreesplitLayer {
  let result = bio_phylo_tree_split_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_tree_split_layer_add(a : BiophylotreesplitLayer, b : BiophylotreesplitLayer) -> BiophylotreesplitLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_tree_split_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_tree_split_layer_copy(s : BiophylotreesplitLayer) -> BiophylotreesplitLayer {
  let result = bio_phylo_tree_split_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_tree_split_layer_fill(s : BiophylotreesplitLayer, v : Double) -> BiophylotreesplitLayer {
  let result = bio_phylo_tree_split_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_layer_min(s : BiophylotreesplitLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_layer_max(s : BiophylotreesplitLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_layer_to_string(s : BiophylotreesplitLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_buffer_make(size : Int) -> BiophylotreesplitBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_buffer_len(s : BiophylotreesplitBuffer) -> Int { s.size }

pub fn bio_phylo_tree_split_buffer_get(s : BiophylotreesplitBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_buffer_set(s : BiophylotreesplitBuffer, i : Int, v : Double) -> BiophylotreesplitBuffer {
  let result = bio_phylo_tree_split_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_buffer_sum(s : BiophylotreesplitBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_tree_split_buffer_mean(s : BiophylotreesplitBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_tree_split_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_tree_split_buffer_scale(s : BiophylotreesplitBuffer, f : Double) -> BiophylotreesplitBuffer {
  let result = bio_phylo_tree_split_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_tree_split_buffer_add(a : BiophylotreesplitBuffer, b : BiophylotreesplitBuffer) -> BiophylotreesplitBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_tree_split_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_tree_split_buffer_copy(s : BiophylotreesplitBuffer) -> BiophylotreesplitBuffer {
  let result = bio_phylo_tree_split_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_tree_split_buffer_fill(s : BiophylotreesplitBuffer, v : Double) -> BiophylotreesplitBuffer {
  let result = bio_phylo_tree_split_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_buffer_min(s : BiophylotreesplitBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_buffer_max(s : BiophylotreesplitBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_buffer_to_string(s : BiophylotreesplitBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_cursor_make(size : Int) -> BiophylotreesplitCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_cursor_len(s : BiophylotreesplitCursor) -> Int { s.size }

pub fn bio_phylo_tree_split_cursor_get(s : BiophylotreesplitCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_cursor_set(s : BiophylotreesplitCursor, i : Int, v : Double) -> BiophylotreesplitCursor {
  let result = bio_phylo_tree_split_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_cursor_sum(s : BiophylotreesplitCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_tree_split_cursor_mean(s : BiophylotreesplitCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_tree_split_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_tree_split_cursor_scale(s : BiophylotreesplitCursor, f : Double) -> BiophylotreesplitCursor {
  let result = bio_phylo_tree_split_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_tree_split_cursor_add(a : BiophylotreesplitCursor, b : BiophylotreesplitCursor) -> BiophylotreesplitCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_tree_split_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_tree_split_cursor_copy(s : BiophylotreesplitCursor) -> BiophylotreesplitCursor {
  let result = bio_phylo_tree_split_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_tree_split_cursor_fill(s : BiophylotreesplitCursor, v : Double) -> BiophylotreesplitCursor {
  let result = bio_phylo_tree_split_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_cursor_min(s : BiophylotreesplitCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_cursor_max(s : BiophylotreesplitCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_cursor_to_string(s : BiophylotreesplitCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_view_make(size : Int) -> BiophylotreesplitView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_view_len(s : BiophylotreesplitView) -> Int { s.size }

pub fn bio_phylo_tree_split_view_get(s : BiophylotreesplitView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_view_set(s : BiophylotreesplitView, i : Int, v : Double) -> BiophylotreesplitView {
  let result = bio_phylo_tree_split_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_view_sum(s : BiophylotreesplitView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_tree_split_view_mean(s : BiophylotreesplitView) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_tree_split_view_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_tree_split_view_scale(s : BiophylotreesplitView, f : Double) -> BiophylotreesplitView {
  let result = bio_phylo_tree_split_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_tree_split_view_add(a : BiophylotreesplitView, b : BiophylotreesplitView) -> BiophylotreesplitView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_tree_split_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_tree_split_view_copy(s : BiophylotreesplitView) -> BiophylotreesplitView {
  let result = bio_phylo_tree_split_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_tree_split_view_fill(s : BiophylotreesplitView, v : Double) -> BiophylotreesplitView {
  let result = bio_phylo_tree_split_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_view_min(s : BiophylotreesplitView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_view_max(s : BiophylotreesplitView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_view_to_string(s : BiophylotreesplitView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_range_make(size : Int) -> BiophylotreesplitRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_range_len(s : BiophylotreesplitRange) -> Int { s.size }

pub fn bio_phylo_tree_split_range_get(s : BiophylotreesplitRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_range_set(s : BiophylotreesplitRange, i : Int, v : Double) -> BiophylotreesplitRange {
  let result = bio_phylo_tree_split_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_range_sum(s : BiophylotreesplitRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_tree_split_range_mean(s : BiophylotreesplitRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_tree_split_range_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_tree_split_range_scale(s : BiophylotreesplitRange, f : Double) -> BiophylotreesplitRange {
  let result = bio_phylo_tree_split_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_tree_split_range_add(a : BiophylotreesplitRange, b : BiophylotreesplitRange) -> BiophylotreesplitRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_tree_split_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_tree_split_range_copy(s : BiophylotreesplitRange) -> BiophylotreesplitRange {
  let result = bio_phylo_tree_split_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_tree_split_range_fill(s : BiophylotreesplitRange, v : Double) -> BiophylotreesplitRange {
  let result = bio_phylo_tree_split_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_range_min(s : BiophylotreesplitRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_range_max(s : BiophylotreesplitRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_range_to_string(s : BiophylotreesplitRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_slice_make(size : Int) -> BiophylotreesplitSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_slice_len(s : BiophylotreesplitSlice) -> Int { s.size }

pub fn bio_phylo_tree_split_slice_get(s : BiophylotreesplitSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_slice_set(s : BiophylotreesplitSlice, i : Int, v : Double) -> BiophylotreesplitSlice {
  let result = bio_phylo_tree_split_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_slice_sum(s : BiophylotreesplitSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_tree_split_slice_mean(s : BiophylotreesplitSlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_tree_split_slice_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_tree_split_slice_scale(s : BiophylotreesplitSlice, f : Double) -> BiophylotreesplitSlice {
  let result = bio_phylo_tree_split_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_tree_split_slice_add(a : BiophylotreesplitSlice, b : BiophylotreesplitSlice) -> BiophylotreesplitSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_tree_split_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_tree_split_slice_copy(s : BiophylotreesplitSlice) -> BiophylotreesplitSlice {
  let result = bio_phylo_tree_split_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_tree_split_slice_fill(s : BiophylotreesplitSlice, v : Double) -> BiophylotreesplitSlice {
  let result = bio_phylo_tree_split_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_tree_split_slice_min(s : BiophylotreesplitSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_slice_max(s : BiophylotreesplitSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_tree_split_slice_to_string(s : BiophylotreesplitSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

