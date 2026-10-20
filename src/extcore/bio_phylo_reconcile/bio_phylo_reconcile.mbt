///===
/// extcore/bio_phylo_reconcile

pub(all) struct BiophyloreconcilePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_reconcile_make_point(x : Double, y : Double) -> BiophyloreconcilePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_reconcile_make_point3(x : Double, y : Double, z : Double) -> BiophyloreconcilePoint {
  { x, y, z, label: 0 }
}

pub fn bio_phylo_reconcile_point_x(pt : BiophyloreconcilePoint) -> Double { pt.x }

pub fn bio_phylo_reconcile_point_y(pt : BiophyloreconcilePoint) -> Double { pt.y }

pub fn bio_phylo_reconcile_point_z(pt : BiophyloreconcilePoint) -> Double { pt.z }

pub fn bio_phylo_reconcile_point_label(pt : BiophyloreconcilePoint) -> Int { pt.label }

pub fn bio_phylo_reconcile_point_dist(a : BiophyloreconcilePoint, b : BiophyloreconcilePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_phylo_reconcile_point_add(a : BiophyloreconcilePoint, b : BiophyloreconcilePoint) -> BiophyloreconcilePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_phylo_reconcile_point_sub(a : BiophyloreconcilePoint, b : BiophyloreconcilePoint) -> BiophyloreconcilePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_phylo_reconcile_point_scale(pt : BiophyloreconcilePoint, s : Double) -> BiophyloreconcilePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_phylo_reconcile_point_dot(a : BiophyloreconcilePoint, b : BiophyloreconcilePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_phylo_reconcile_point_cross(a : BiophyloreconcilePoint, b : BiophyloreconcilePoint) -> BiophyloreconcilePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_phylo_reconcile_point_norm(pt : BiophyloreconcilePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_phylo_reconcile_point_normalize(pt : BiophyloreconcilePoint) -> BiophyloreconcilePoint {
  let n = bio_phylo_reconcile_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_phylo_reconcile_point_scale(pt, 1.0 / n) }
}

pub fn bio_phylo_reconcile_point_negate(pt : BiophyloreconcilePoint) -> BiophyloreconcilePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_phylo_reconcile_point_mid(a : BiophyloreconcilePoint, b : BiophyloreconcilePoint) -> BiophyloreconcilePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_phylo_reconcile_point_lerp(a : BiophyloreconcilePoint, b : BiophyloreconcilePoint, t : Double) -> BiophyloreconcilePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_phylo_reconcile_point_to_string(pt : BiophyloreconcilePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BiophyloreconcileSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_reconcile_make_series(vals : Array[Double], name : String) -> BiophyloreconcileSeries {
  { vals, name, meta: 0 }
}

pub fn bio_phylo_reconcile_series_len(s : BiophyloreconcileSeries) -> Int { s.vals.length() }

pub fn bio_phylo_reconcile_series_sum(s : BiophyloreconcileSeries) -> Double { @_common.sum(s.vals) }

pub fn bio_phylo_reconcile_series_mean(s : BiophyloreconcileSeries) -> Double { @_common.mean(s.vals) }

pub fn bio_phylo_reconcile_series_min(s : BiophyloreconcileSeries) -> Double { @_common.min(s.vals) }

pub fn bio_phylo_reconcile_series_max(s : BiophyloreconcileSeries) -> Double { @_common.max(s.vals) }

pub fn bio_phylo_reconcile_series_range(s : BiophyloreconcileSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn bio_phylo_reconcile_series_var(s : BiophyloreconcileSeries) -> Double { @_common.variance(s.vals) }

pub fn bio_phylo_reconcile_series_std(s : BiophyloreconcileSeries) -> Double { @_common.std(s.vals) }

pub fn bio_phylo_reconcile_series_median(s : BiophyloreconcileSeries) -> Double { @_common.median(s.vals) }

pub fn bio_phylo_reconcile_series_scale(s : BiophyloreconcileSeries, f : Double) -> BiophyloreconcileSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn bio_phylo_reconcile_series_add(a : BiophyloreconcileSeries, b : BiophyloreconcileSeries) -> BiophyloreconcileSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_phylo_reconcile_series_sub(a : BiophyloreconcileSeries, b : BiophyloreconcileSeries) -> BiophyloreconcileSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_phylo_reconcile_series_normalize(s : BiophyloreconcileSeries) -> BiophyloreconcileSeries {
  let mn = bio_phylo_reconcile_series_min(s)
  let mx = bio_phylo_reconcile_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_phylo_reconcile_series_cumsum(s : BiophyloreconcileSeries) -> BiophyloreconcileSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_phylo_reconcile_series_to_string(s : BiophyloreconcileSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophyloreconcileMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_reconcile_make_matrix(rows : Int, cols : Int, val : Double) -> BiophyloreconcileMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_phylo_reconcile_matrix_identity(n : Int) -> BiophyloreconcileMatrix {
  let m = bio_phylo_reconcile_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_phylo_reconcile_matrix_get(m : BiophyloreconcileMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_phylo_reconcile_matrix_transpose(m : BiophyloreconcileMatrix) -> BiophyloreconcileMatrix {
  let result = bio_phylo_reconcile_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_phylo_reconcile_matrix_add(a : BiophyloreconcileMatrix, b : BiophyloreconcileMatrix) -> BiophyloreconcileMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_phylo_reconcile_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_phylo_reconcile_matrix_scale(m : BiophyloreconcileMatrix, s : Double) -> BiophyloreconcileMatrix {
  let result = bio_phylo_reconcile_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_phylo_reconcile_matrix_multiply(a : BiophyloreconcileMatrix, b : BiophyloreconcileMatrix) -> BiophyloreconcileMatrix {
  if a.cols != b.rows { return bio_phylo_reconcile_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_phylo_reconcile_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_phylo_reconcile_matrix_trace(m : BiophyloreconcileMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_phylo_reconcile_matrix_det(m : BiophyloreconcileMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_phylo_reconcile_matrix_norm(m : BiophyloreconcileMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_phylo_reconcile_matrix_to_string(m : BiophyloreconcileMatrix) -> String {
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

pub(all) struct BiophyloreconcileVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_reconcile_make_vector(comps : Array[Double]) -> BiophyloreconcileVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_reconcile_vector_zero(dim : Int) -> BiophyloreconcileVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_phylo_reconcile_vector_add(a : BiophyloreconcileVector, b : BiophyloreconcileVector) -> BiophyloreconcileVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn bio_phylo_reconcile_vector_sub(a : BiophyloreconcileVector, b : BiophyloreconcileVector) -> BiophyloreconcileVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn bio_phylo_reconcile_vector_scale(v : BiophyloreconcileVector, s : Double) -> BiophyloreconcileVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn bio_phylo_reconcile_vector_dot(a : BiophyloreconcileVector, b : BiophyloreconcileVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_phylo_reconcile_vector_norm(v : BiophyloreconcileVector) -> Double { @_common.sqrt(bio_phylo_reconcile_vector_dot(v, v)) }

pub fn bio_phylo_reconcile_vector_normalize(v : BiophyloreconcileVector) -> BiophyloreconcileVector {
  let n = bio_phylo_reconcile_vector_norm(v)
  if n < 0.0000001 { v } else { bio_phylo_reconcile_vector_scale(v, 1.0 / n) }
}

pub fn bio_phylo_reconcile_vector_dist(a : BiophyloreconcileVector, b : BiophyloreconcileVector) -> Double {
  bio_phylo_reconcile_vector_norm(bio_phylo_reconcile_vector_sub(a, b))
}

pub fn bio_phylo_reconcile_vector_to_string(v : BiophyloreconcileVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_phylo_reconcile_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_phylo_reconcile_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_phylo_reconcile_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_phylo_reconcile_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_phylo_reconcile_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_phylo_reconcile_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_phylo_reconcile_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_phylo_reconcile_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_phylo_reconcile_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_phylo_reconcile_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_phylo_reconcile_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_phylo_reconcile_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_phylo_reconcile_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_phylo_reconcile_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_phylo_reconcile_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_phylo_reconcile_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_phylo_reconcile_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_phylo_reconcile_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_phylo_reconcile_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_phylo_reconcile_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_phylo_reconcile_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_phylo_reconcile_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_phylo_reconcile_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_phylo_reconcile_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_phylo_reconcile_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_phylo_reconcile_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_phylo_reconcile_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_phylo_reconcile_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_phylo_reconcile_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiophyloreconcileFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_frame_make(size : Int) -> BiophyloreconcileFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_frame_len(s : BiophyloreconcileFrame) -> Int { s.size }

pub fn bio_phylo_reconcile_frame_get(s : BiophyloreconcileFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_frame_set(s : BiophyloreconcileFrame, i : Int, v : Double) -> BiophyloreconcileFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_frame_sum(s : BiophyloreconcileFrame) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_frame_mean(s : BiophyloreconcileFrame) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_frame_scale(s : BiophyloreconcileFrame, f : Double) -> BiophyloreconcileFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_frame_add(a : BiophyloreconcileFrame, b : BiophyloreconcileFrame) -> BiophyloreconcileFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_frame_copy(s : BiophyloreconcileFrame) -> BiophyloreconcileFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_frame_fill(s : BiophyloreconcileFrame, v : Double) -> BiophyloreconcileFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_frame_min(s : BiophyloreconcileFrame) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_frame_max(s : BiophyloreconcileFrame) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_frame_to_string(s : BiophyloreconcileFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_table_make(size : Int) -> BiophyloreconcileTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_table_len(s : BiophyloreconcileTable) -> Int { s.size }

pub fn bio_phylo_reconcile_table_get(s : BiophyloreconcileTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_table_set(s : BiophyloreconcileTable, i : Int, v : Double) -> BiophyloreconcileTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_table_sum(s : BiophyloreconcileTable) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_table_mean(s : BiophyloreconcileTable) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_table_scale(s : BiophyloreconcileTable, f : Double) -> BiophyloreconcileTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_table_add(a : BiophyloreconcileTable, b : BiophyloreconcileTable) -> BiophyloreconcileTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_table_copy(s : BiophyloreconcileTable) -> BiophyloreconcileTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_table_fill(s : BiophyloreconcileTable, v : Double) -> BiophyloreconcileTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_table_min(s : BiophyloreconcileTable) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_table_max(s : BiophyloreconcileTable) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_table_to_string(s : BiophyloreconcileTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_graphn_make(size : Int) -> BiophyloreconcileGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_graphn_len(s : BiophyloreconcileGraphN) -> Int { s.size }

pub fn bio_phylo_reconcile_graphn_get(s : BiophyloreconcileGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_graphn_set(s : BiophyloreconcileGraphN, i : Int, v : Double) -> BiophyloreconcileGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_graphn_sum(s : BiophyloreconcileGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_graphn_mean(s : BiophyloreconcileGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_graphn_scale(s : BiophyloreconcileGraphN, f : Double) -> BiophyloreconcileGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_graphn_add(a : BiophyloreconcileGraphN, b : BiophyloreconcileGraphN) -> BiophyloreconcileGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_graphn_copy(s : BiophyloreconcileGraphN) -> BiophyloreconcileGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_graphn_fill(s : BiophyloreconcileGraphN, v : Double) -> BiophyloreconcileGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_graphn_min(s : BiophyloreconcileGraphN) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_graphn_max(s : BiophyloreconcileGraphN) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_graphn_to_string(s : BiophyloreconcileGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_node_make(size : Int) -> BiophyloreconcileNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_node_len(s : BiophyloreconcileNode) -> Int { s.size }

pub fn bio_phylo_reconcile_node_get(s : BiophyloreconcileNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_node_set(s : BiophyloreconcileNode, i : Int, v : Double) -> BiophyloreconcileNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_node_sum(s : BiophyloreconcileNode) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_node_mean(s : BiophyloreconcileNode) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_node_scale(s : BiophyloreconcileNode, f : Double) -> BiophyloreconcileNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_node_add(a : BiophyloreconcileNode, b : BiophyloreconcileNode) -> BiophyloreconcileNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_node_copy(s : BiophyloreconcileNode) -> BiophyloreconcileNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_node_fill(s : BiophyloreconcileNode, v : Double) -> BiophyloreconcileNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_node_min(s : BiophyloreconcileNode) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_node_max(s : BiophyloreconcileNode) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_node_to_string(s : BiophyloreconcileNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_edge_make(size : Int) -> BiophyloreconcileEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_edge_len(s : BiophyloreconcileEdge) -> Int { s.size }

pub fn bio_phylo_reconcile_edge_get(s : BiophyloreconcileEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_edge_set(s : BiophyloreconcileEdge, i : Int, v : Double) -> BiophyloreconcileEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_edge_sum(s : BiophyloreconcileEdge) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_edge_mean(s : BiophyloreconcileEdge) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_edge_scale(s : BiophyloreconcileEdge, f : Double) -> BiophyloreconcileEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_edge_add(a : BiophyloreconcileEdge, b : BiophyloreconcileEdge) -> BiophyloreconcileEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_edge_copy(s : BiophyloreconcileEdge) -> BiophyloreconcileEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_edge_fill(s : BiophyloreconcileEdge, v : Double) -> BiophyloreconcileEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_edge_min(s : BiophyloreconcileEdge) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_edge_max(s : BiophyloreconcileEdge) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_edge_to_string(s : BiophyloreconcileEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcilePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_path_make(size : Int) -> BiophyloreconcilePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_path_len(s : BiophyloreconcilePath) -> Int { s.size }

pub fn bio_phylo_reconcile_path_get(s : BiophyloreconcilePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_path_set(s : BiophyloreconcilePath, i : Int, v : Double) -> BiophyloreconcilePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_path_sum(s : BiophyloreconcilePath) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_path_mean(s : BiophyloreconcilePath) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_path_scale(s : BiophyloreconcilePath, f : Double) -> BiophyloreconcilePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_path_add(a : BiophyloreconcilePath, b : BiophyloreconcilePath) -> BiophyloreconcilePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_path_copy(s : BiophyloreconcilePath) -> BiophyloreconcilePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_path_fill(s : BiophyloreconcilePath, v : Double) -> BiophyloreconcilePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_path_min(s : BiophyloreconcilePath) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_path_max(s : BiophyloreconcilePath) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_path_to_string(s : BiophyloreconcilePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_cluster_make(size : Int) -> BiophyloreconcileCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_cluster_len(s : BiophyloreconcileCluster) -> Int { s.size }

pub fn bio_phylo_reconcile_cluster_get(s : BiophyloreconcileCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_cluster_set(s : BiophyloreconcileCluster, i : Int, v : Double) -> BiophyloreconcileCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_cluster_sum(s : BiophyloreconcileCluster) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_cluster_mean(s : BiophyloreconcileCluster) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_cluster_scale(s : BiophyloreconcileCluster, f : Double) -> BiophyloreconcileCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_cluster_add(a : BiophyloreconcileCluster, b : BiophyloreconcileCluster) -> BiophyloreconcileCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_cluster_copy(s : BiophyloreconcileCluster) -> BiophyloreconcileCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_cluster_fill(s : BiophyloreconcileCluster, v : Double) -> BiophyloreconcileCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_cluster_min(s : BiophyloreconcileCluster) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_cluster_max(s : BiophyloreconcileCluster) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_cluster_to_string(s : BiophyloreconcileCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_model_make(size : Int) -> BiophyloreconcileModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_model_len(s : BiophyloreconcileModel) -> Int { s.size }

pub fn bio_phylo_reconcile_model_get(s : BiophyloreconcileModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_model_set(s : BiophyloreconcileModel, i : Int, v : Double) -> BiophyloreconcileModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_model_sum(s : BiophyloreconcileModel) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_model_mean(s : BiophyloreconcileModel) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_model_scale(s : BiophyloreconcileModel, f : Double) -> BiophyloreconcileModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_model_add(a : BiophyloreconcileModel, b : BiophyloreconcileModel) -> BiophyloreconcileModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_model_copy(s : BiophyloreconcileModel) -> BiophyloreconcileModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_model_fill(s : BiophyloreconcileModel, v : Double) -> BiophyloreconcileModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_model_min(s : BiophyloreconcileModel) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_model_max(s : BiophyloreconcileModel) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_model_to_string(s : BiophyloreconcileModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_layer_make(size : Int) -> BiophyloreconcileLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_layer_len(s : BiophyloreconcileLayer) -> Int { s.size }

pub fn bio_phylo_reconcile_layer_get(s : BiophyloreconcileLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_layer_set(s : BiophyloreconcileLayer, i : Int, v : Double) -> BiophyloreconcileLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_layer_sum(s : BiophyloreconcileLayer) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_layer_mean(s : BiophyloreconcileLayer) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_layer_scale(s : BiophyloreconcileLayer, f : Double) -> BiophyloreconcileLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_layer_add(a : BiophyloreconcileLayer, b : BiophyloreconcileLayer) -> BiophyloreconcileLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_layer_copy(s : BiophyloreconcileLayer) -> BiophyloreconcileLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_layer_fill(s : BiophyloreconcileLayer, v : Double) -> BiophyloreconcileLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_layer_min(s : BiophyloreconcileLayer) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_layer_max(s : BiophyloreconcileLayer) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_layer_to_string(s : BiophyloreconcileLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_buffer_make(size : Int) -> BiophyloreconcileBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_buffer_len(s : BiophyloreconcileBuffer) -> Int { s.size }

pub fn bio_phylo_reconcile_buffer_get(s : BiophyloreconcileBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_buffer_set(s : BiophyloreconcileBuffer, i : Int, v : Double) -> BiophyloreconcileBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_buffer_sum(s : BiophyloreconcileBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_buffer_mean(s : BiophyloreconcileBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_buffer_scale(s : BiophyloreconcileBuffer, f : Double) -> BiophyloreconcileBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_buffer_add(a : BiophyloreconcileBuffer, b : BiophyloreconcileBuffer) -> BiophyloreconcileBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_buffer_copy(s : BiophyloreconcileBuffer) -> BiophyloreconcileBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_buffer_fill(s : BiophyloreconcileBuffer, v : Double) -> BiophyloreconcileBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_buffer_min(s : BiophyloreconcileBuffer) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_buffer_max(s : BiophyloreconcileBuffer) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_buffer_to_string(s : BiophyloreconcileBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_cursor_make(size : Int) -> BiophyloreconcileCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_cursor_len(s : BiophyloreconcileCursor) -> Int { s.size }

pub fn bio_phylo_reconcile_cursor_get(s : BiophyloreconcileCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_cursor_set(s : BiophyloreconcileCursor, i : Int, v : Double) -> BiophyloreconcileCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_cursor_sum(s : BiophyloreconcileCursor) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_cursor_mean(s : BiophyloreconcileCursor) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_cursor_scale(s : BiophyloreconcileCursor, f : Double) -> BiophyloreconcileCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_cursor_add(a : BiophyloreconcileCursor, b : BiophyloreconcileCursor) -> BiophyloreconcileCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_cursor_copy(s : BiophyloreconcileCursor) -> BiophyloreconcileCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_cursor_fill(s : BiophyloreconcileCursor, v : Double) -> BiophyloreconcileCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_cursor_min(s : BiophyloreconcileCursor) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_cursor_max(s : BiophyloreconcileCursor) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_cursor_to_string(s : BiophyloreconcileCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_view_make(size : Int) -> BiophyloreconcileView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_view_len(s : BiophyloreconcileView) -> Int { s.size }

pub fn bio_phylo_reconcile_view_get(s : BiophyloreconcileView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_view_set(s : BiophyloreconcileView, i : Int, v : Double) -> BiophyloreconcileView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_view_sum(s : BiophyloreconcileView) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_view_mean(s : BiophyloreconcileView) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_view_scale(s : BiophyloreconcileView, f : Double) -> BiophyloreconcileView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_view_add(a : BiophyloreconcileView, b : BiophyloreconcileView) -> BiophyloreconcileView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_view_copy(s : BiophyloreconcileView) -> BiophyloreconcileView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_view_fill(s : BiophyloreconcileView, v : Double) -> BiophyloreconcileView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_view_min(s : BiophyloreconcileView) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_view_max(s : BiophyloreconcileView) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_view_to_string(s : BiophyloreconcileView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_range_make(size : Int) -> BiophyloreconcileRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_range_len(s : BiophyloreconcileRange) -> Int { s.size }

pub fn bio_phylo_reconcile_range_get(s : BiophyloreconcileRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_range_set(s : BiophyloreconcileRange, i : Int, v : Double) -> BiophyloreconcileRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_range_sum(s : BiophyloreconcileRange) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_range_mean(s : BiophyloreconcileRange) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_range_scale(s : BiophyloreconcileRange, f : Double) -> BiophyloreconcileRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_range_add(a : BiophyloreconcileRange, b : BiophyloreconcileRange) -> BiophyloreconcileRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_range_copy(s : BiophyloreconcileRange) -> BiophyloreconcileRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_range_fill(s : BiophyloreconcileRange, v : Double) -> BiophyloreconcileRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_range_min(s : BiophyloreconcileRange) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_range_max(s : BiophyloreconcileRange) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_range_to_string(s : BiophyloreconcileRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_slice_make(size : Int) -> BiophyloreconcileSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_slice_len(s : BiophyloreconcileSlice) -> Int { s.size }

pub fn bio_phylo_reconcile_slice_get(s : BiophyloreconcileSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_slice_set(s : BiophyloreconcileSlice, i : Int, v : Double) -> BiophyloreconcileSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_slice_sum(s : BiophyloreconcileSlice) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_slice_mean(s : BiophyloreconcileSlice) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_slice_scale(s : BiophyloreconcileSlice, f : Double) -> BiophyloreconcileSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_slice_add(a : BiophyloreconcileSlice, b : BiophyloreconcileSlice) -> BiophyloreconcileSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_slice_copy(s : BiophyloreconcileSlice) -> BiophyloreconcileSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_slice_fill(s : BiophyloreconcileSlice, v : Double) -> BiophyloreconcileSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_slice_min(s : BiophyloreconcileSlice) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_slice_max(s : BiophyloreconcileSlice) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_slice_to_string(s : BiophyloreconcileSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

