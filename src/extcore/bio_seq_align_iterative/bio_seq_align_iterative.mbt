///===
/// extcore/bio_seq_align_iterative

pub(all) struct BioseqaligniterativePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_align_iterative_make_point(x : Double, y : Double) -> BioseqaligniterativePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_align_iterative_make_point3(x : Double, y : Double, z : Double) -> BioseqaligniterativePoint {
  { x, y, z, label: 0 }
}

pub fn bio_seq_align_iterative_point_x(pt : BioseqaligniterativePoint) -> Double { pt.x }

pub fn bio_seq_align_iterative_point_y(pt : BioseqaligniterativePoint) -> Double { pt.y }

pub fn bio_seq_align_iterative_point_z(pt : BioseqaligniterativePoint) -> Double { pt.z }

pub fn bio_seq_align_iterative_point_label(pt : BioseqaligniterativePoint) -> Int { pt.label }

pub fn bio_seq_align_iterative_point_dist(a : BioseqaligniterativePoint, b : BioseqaligniterativePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_seq_align_iterative_point_add(a : BioseqaligniterativePoint, b : BioseqaligniterativePoint) -> BioseqaligniterativePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_seq_align_iterative_point_sub(a : BioseqaligniterativePoint, b : BioseqaligniterativePoint) -> BioseqaligniterativePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_seq_align_iterative_point_scale(pt : BioseqaligniterativePoint, s : Double) -> BioseqaligniterativePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_seq_align_iterative_point_dot(a : BioseqaligniterativePoint, b : BioseqaligniterativePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_seq_align_iterative_point_cross(a : BioseqaligniterativePoint, b : BioseqaligniterativePoint) -> BioseqaligniterativePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_seq_align_iterative_point_norm(pt : BioseqaligniterativePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_seq_align_iterative_point_normalize(pt : BioseqaligniterativePoint) -> BioseqaligniterativePoint {
  let n = bio_seq_align_iterative_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_seq_align_iterative_point_scale(pt, 1.0 / n) }
}

pub fn bio_seq_align_iterative_point_negate(pt : BioseqaligniterativePoint) -> BioseqaligniterativePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_seq_align_iterative_point_mid(a : BioseqaligniterativePoint, b : BioseqaligniterativePoint) -> BioseqaligniterativePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_seq_align_iterative_point_lerp(a : BioseqaligniterativePoint, b : BioseqaligniterativePoint, t : Double) -> BioseqaligniterativePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_seq_align_iterative_point_to_string(pt : BioseqaligniterativePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BioseqaligniterativeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_align_iterative_make_series(vals : Array[Double], name : String) -> BioseqaligniterativeSeries {
  { vals, name, meta: 0 }
}

pub fn bio_seq_align_iterative_series_len(s : BioseqaligniterativeSeries) -> Int { s.vals.length() }

pub fn bio_seq_align_iterative_series_sum(s : BioseqaligniterativeSeries) -> Double { @_common.sum(s.vals) }

pub fn bio_seq_align_iterative_series_mean(s : BioseqaligniterativeSeries) -> Double { @_common.mean(s.vals) }

pub fn bio_seq_align_iterative_series_min(s : BioseqaligniterativeSeries) -> Double { @_common.min(s.vals) }

pub fn bio_seq_align_iterative_series_max(s : BioseqaligniterativeSeries) -> Double { @_common.max(s.vals) }

pub fn bio_seq_align_iterative_series_range(s : BioseqaligniterativeSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn bio_seq_align_iterative_series_var(s : BioseqaligniterativeSeries) -> Double { @_common.variance(s.vals) }

pub fn bio_seq_align_iterative_series_std(s : BioseqaligniterativeSeries) -> Double { @_common.std(s.vals) }

pub fn bio_seq_align_iterative_series_median(s : BioseqaligniterativeSeries) -> Double { @_common.median(s.vals) }

pub fn bio_seq_align_iterative_series_scale(s : BioseqaligniterativeSeries, f : Double) -> BioseqaligniterativeSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn bio_seq_align_iterative_series_add(a : BioseqaligniterativeSeries, b : BioseqaligniterativeSeries) -> BioseqaligniterativeSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_seq_align_iterative_series_sub(a : BioseqaligniterativeSeries, b : BioseqaligniterativeSeries) -> BioseqaligniterativeSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_seq_align_iterative_series_normalize(s : BioseqaligniterativeSeries) -> BioseqaligniterativeSeries {
  let mn = bio_seq_align_iterative_series_min(s)
  let mx = bio_seq_align_iterative_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_seq_align_iterative_series_cumsum(s : BioseqaligniterativeSeries) -> BioseqaligniterativeSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_seq_align_iterative_series_to_string(s : BioseqaligniterativeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqaligniterativeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_align_iterative_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqaligniterativeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_align_iterative_matrix_identity(n : Int) -> BioseqaligniterativeMatrix {
  let m = bio_seq_align_iterative_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_seq_align_iterative_matrix_get(m : BioseqaligniterativeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_seq_align_iterative_matrix_transpose(m : BioseqaligniterativeMatrix) -> BioseqaligniterativeMatrix {
  let result = bio_seq_align_iterative_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_seq_align_iterative_matrix_add(a : BioseqaligniterativeMatrix, b : BioseqaligniterativeMatrix) -> BioseqaligniterativeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_seq_align_iterative_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_seq_align_iterative_matrix_scale(m : BioseqaligniterativeMatrix, s : Double) -> BioseqaligniterativeMatrix {
  let result = bio_seq_align_iterative_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_seq_align_iterative_matrix_multiply(a : BioseqaligniterativeMatrix, b : BioseqaligniterativeMatrix) -> BioseqaligniterativeMatrix {
  if a.cols != b.rows { return bio_seq_align_iterative_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_seq_align_iterative_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_seq_align_iterative_matrix_trace(m : BioseqaligniterativeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_seq_align_iterative_matrix_det(m : BioseqaligniterativeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_seq_align_iterative_matrix_norm(m : BioseqaligniterativeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_seq_align_iterative_matrix_to_string(m : BioseqaligniterativeMatrix) -> String {
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

pub(all) struct BioseqaligniterativeVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_align_iterative_make_vector(comps : Array[Double]) -> BioseqaligniterativeVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_align_iterative_vector_zero(dim : Int) -> BioseqaligniterativeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_seq_align_iterative_vector_add(a : BioseqaligniterativeVector, b : BioseqaligniterativeVector) -> BioseqaligniterativeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn bio_seq_align_iterative_vector_sub(a : BioseqaligniterativeVector, b : BioseqaligniterativeVector) -> BioseqaligniterativeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn bio_seq_align_iterative_vector_scale(v : BioseqaligniterativeVector, s : Double) -> BioseqaligniterativeVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn bio_seq_align_iterative_vector_dot(a : BioseqaligniterativeVector, b : BioseqaligniterativeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_seq_align_iterative_vector_norm(v : BioseqaligniterativeVector) -> Double { @_common.sqrt(bio_seq_align_iterative_vector_dot(v, v)) }

pub fn bio_seq_align_iterative_vector_normalize(v : BioseqaligniterativeVector) -> BioseqaligniterativeVector {
  let n = bio_seq_align_iterative_vector_norm(v)
  if n < 0.0000001 { v } else { bio_seq_align_iterative_vector_scale(v, 1.0 / n) }
}

pub fn bio_seq_align_iterative_vector_dist(a : BioseqaligniterativeVector, b : BioseqaligniterativeVector) -> Double {
  bio_seq_align_iterative_vector_norm(bio_seq_align_iterative_vector_sub(a, b))
}

pub fn bio_seq_align_iterative_vector_to_string(v : BioseqaligniterativeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_align_iterative_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_align_iterative_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_align_iterative_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_align_iterative_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_align_iterative_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_align_iterative_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_align_iterative_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_align_iterative_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_align_iterative_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_align_iterative_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_align_iterative_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_align_iterative_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_align_iterative_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_align_iterative_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_align_iterative_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_align_iterative_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_align_iterative_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_align_iterative_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_align_iterative_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_align_iterative_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_align_iterative_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_align_iterative_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_align_iterative_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_align_iterative_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_align_iterative_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_align_iterative_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_align_iterative_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_align_iterative_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_align_iterative_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqaligniterativeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_frame_make(size : Int) -> BioseqaligniterativeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_frame_len(s : BioseqaligniterativeFrame) -> Int { s.size }

pub fn bio_seq_align_iterative_frame_get(s : BioseqaligniterativeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_frame_set(s : BioseqaligniterativeFrame, i : Int, v : Double) -> BioseqaligniterativeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_frame_sum(s : BioseqaligniterativeFrame) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_frame_mean(s : BioseqaligniterativeFrame) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_frame_scale(s : BioseqaligniterativeFrame, f : Double) -> BioseqaligniterativeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_frame_add(a : BioseqaligniterativeFrame, b : BioseqaligniterativeFrame) -> BioseqaligniterativeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_frame_copy(s : BioseqaligniterativeFrame) -> BioseqaligniterativeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_frame_fill(s : BioseqaligniterativeFrame, v : Double) -> BioseqaligniterativeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_frame_min(s : BioseqaligniterativeFrame) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_frame_max(s : BioseqaligniterativeFrame) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_frame_to_string(s : BioseqaligniterativeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_table_make(size : Int) -> BioseqaligniterativeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_table_len(s : BioseqaligniterativeTable) -> Int { s.size }

pub fn bio_seq_align_iterative_table_get(s : BioseqaligniterativeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_table_set(s : BioseqaligniterativeTable, i : Int, v : Double) -> BioseqaligniterativeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_table_sum(s : BioseqaligniterativeTable) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_table_mean(s : BioseqaligniterativeTable) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_table_scale(s : BioseqaligniterativeTable, f : Double) -> BioseqaligniterativeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_table_add(a : BioseqaligniterativeTable, b : BioseqaligniterativeTable) -> BioseqaligniterativeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_table_copy(s : BioseqaligniterativeTable) -> BioseqaligniterativeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_table_fill(s : BioseqaligniterativeTable, v : Double) -> BioseqaligniterativeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_table_min(s : BioseqaligniterativeTable) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_table_max(s : BioseqaligniterativeTable) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_table_to_string(s : BioseqaligniterativeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_graphn_make(size : Int) -> BioseqaligniterativeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_graphn_len(s : BioseqaligniterativeGraphN) -> Int { s.size }

pub fn bio_seq_align_iterative_graphn_get(s : BioseqaligniterativeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_graphn_set(s : BioseqaligniterativeGraphN, i : Int, v : Double) -> BioseqaligniterativeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_graphn_sum(s : BioseqaligniterativeGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_graphn_mean(s : BioseqaligniterativeGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_graphn_scale(s : BioseqaligniterativeGraphN, f : Double) -> BioseqaligniterativeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_graphn_add(a : BioseqaligniterativeGraphN, b : BioseqaligniterativeGraphN) -> BioseqaligniterativeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_graphn_copy(s : BioseqaligniterativeGraphN) -> BioseqaligniterativeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_graphn_fill(s : BioseqaligniterativeGraphN, v : Double) -> BioseqaligniterativeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_graphn_min(s : BioseqaligniterativeGraphN) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_graphn_max(s : BioseqaligniterativeGraphN) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_graphn_to_string(s : BioseqaligniterativeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_node_make(size : Int) -> BioseqaligniterativeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_node_len(s : BioseqaligniterativeNode) -> Int { s.size }

pub fn bio_seq_align_iterative_node_get(s : BioseqaligniterativeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_node_set(s : BioseqaligniterativeNode, i : Int, v : Double) -> BioseqaligniterativeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_node_sum(s : BioseqaligniterativeNode) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_node_mean(s : BioseqaligniterativeNode) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_node_scale(s : BioseqaligniterativeNode, f : Double) -> BioseqaligniterativeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_node_add(a : BioseqaligniterativeNode, b : BioseqaligniterativeNode) -> BioseqaligniterativeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_node_copy(s : BioseqaligniterativeNode) -> BioseqaligniterativeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_node_fill(s : BioseqaligniterativeNode, v : Double) -> BioseqaligniterativeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_node_min(s : BioseqaligniterativeNode) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_node_max(s : BioseqaligniterativeNode) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_node_to_string(s : BioseqaligniterativeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_edge_make(size : Int) -> BioseqaligniterativeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_edge_len(s : BioseqaligniterativeEdge) -> Int { s.size }

pub fn bio_seq_align_iterative_edge_get(s : BioseqaligniterativeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_edge_set(s : BioseqaligniterativeEdge, i : Int, v : Double) -> BioseqaligniterativeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_edge_sum(s : BioseqaligniterativeEdge) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_edge_mean(s : BioseqaligniterativeEdge) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_edge_scale(s : BioseqaligniterativeEdge, f : Double) -> BioseqaligniterativeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_edge_add(a : BioseqaligniterativeEdge, b : BioseqaligniterativeEdge) -> BioseqaligniterativeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_edge_copy(s : BioseqaligniterativeEdge) -> BioseqaligniterativeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_edge_fill(s : BioseqaligniterativeEdge, v : Double) -> BioseqaligniterativeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_edge_min(s : BioseqaligniterativeEdge) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_edge_max(s : BioseqaligniterativeEdge) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_edge_to_string(s : BioseqaligniterativeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_path_make(size : Int) -> BioseqaligniterativePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_path_len(s : BioseqaligniterativePath) -> Int { s.size }

pub fn bio_seq_align_iterative_path_get(s : BioseqaligniterativePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_path_set(s : BioseqaligniterativePath, i : Int, v : Double) -> BioseqaligniterativePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_path_sum(s : BioseqaligniterativePath) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_path_mean(s : BioseqaligniterativePath) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_path_scale(s : BioseqaligniterativePath, f : Double) -> BioseqaligniterativePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_path_add(a : BioseqaligniterativePath, b : BioseqaligniterativePath) -> BioseqaligniterativePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_path_copy(s : BioseqaligniterativePath) -> BioseqaligniterativePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_path_fill(s : BioseqaligniterativePath, v : Double) -> BioseqaligniterativePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_path_min(s : BioseqaligniterativePath) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_path_max(s : BioseqaligniterativePath) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_path_to_string(s : BioseqaligniterativePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_cluster_make(size : Int) -> BioseqaligniterativeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_cluster_len(s : BioseqaligniterativeCluster) -> Int { s.size }

pub fn bio_seq_align_iterative_cluster_get(s : BioseqaligniterativeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_cluster_set(s : BioseqaligniterativeCluster, i : Int, v : Double) -> BioseqaligniterativeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_cluster_sum(s : BioseqaligniterativeCluster) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_cluster_mean(s : BioseqaligniterativeCluster) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_cluster_scale(s : BioseqaligniterativeCluster, f : Double) -> BioseqaligniterativeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_cluster_add(a : BioseqaligniterativeCluster, b : BioseqaligniterativeCluster) -> BioseqaligniterativeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_cluster_copy(s : BioseqaligniterativeCluster) -> BioseqaligniterativeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_cluster_fill(s : BioseqaligniterativeCluster, v : Double) -> BioseqaligniterativeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_cluster_min(s : BioseqaligniterativeCluster) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_cluster_max(s : BioseqaligniterativeCluster) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_cluster_to_string(s : BioseqaligniterativeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_model_make(size : Int) -> BioseqaligniterativeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_model_len(s : BioseqaligniterativeModel) -> Int { s.size }

pub fn bio_seq_align_iterative_model_get(s : BioseqaligniterativeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_model_set(s : BioseqaligniterativeModel, i : Int, v : Double) -> BioseqaligniterativeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_model_sum(s : BioseqaligniterativeModel) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_model_mean(s : BioseqaligniterativeModel) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_model_scale(s : BioseqaligniterativeModel, f : Double) -> BioseqaligniterativeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_model_add(a : BioseqaligniterativeModel, b : BioseqaligniterativeModel) -> BioseqaligniterativeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_model_copy(s : BioseqaligniterativeModel) -> BioseqaligniterativeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_model_fill(s : BioseqaligniterativeModel, v : Double) -> BioseqaligniterativeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_model_min(s : BioseqaligniterativeModel) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_model_max(s : BioseqaligniterativeModel) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_model_to_string(s : BioseqaligniterativeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_layer_make(size : Int) -> BioseqaligniterativeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_layer_len(s : BioseqaligniterativeLayer) -> Int { s.size }

pub fn bio_seq_align_iterative_layer_get(s : BioseqaligniterativeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_layer_set(s : BioseqaligniterativeLayer, i : Int, v : Double) -> BioseqaligniterativeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_layer_sum(s : BioseqaligniterativeLayer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_layer_mean(s : BioseqaligniterativeLayer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_layer_scale(s : BioseqaligniterativeLayer, f : Double) -> BioseqaligniterativeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_layer_add(a : BioseqaligniterativeLayer, b : BioseqaligniterativeLayer) -> BioseqaligniterativeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_layer_copy(s : BioseqaligniterativeLayer) -> BioseqaligniterativeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_layer_fill(s : BioseqaligniterativeLayer, v : Double) -> BioseqaligniterativeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_layer_min(s : BioseqaligniterativeLayer) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_layer_max(s : BioseqaligniterativeLayer) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_layer_to_string(s : BioseqaligniterativeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_buffer_make(size : Int) -> BioseqaligniterativeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_buffer_len(s : BioseqaligniterativeBuffer) -> Int { s.size }

pub fn bio_seq_align_iterative_buffer_get(s : BioseqaligniterativeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_buffer_set(s : BioseqaligniterativeBuffer, i : Int, v : Double) -> BioseqaligniterativeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_buffer_sum(s : BioseqaligniterativeBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_buffer_mean(s : BioseqaligniterativeBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_buffer_scale(s : BioseqaligniterativeBuffer, f : Double) -> BioseqaligniterativeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_buffer_add(a : BioseqaligniterativeBuffer, b : BioseqaligniterativeBuffer) -> BioseqaligniterativeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_buffer_copy(s : BioseqaligniterativeBuffer) -> BioseqaligniterativeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_buffer_fill(s : BioseqaligniterativeBuffer, v : Double) -> BioseqaligniterativeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_buffer_min(s : BioseqaligniterativeBuffer) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_buffer_max(s : BioseqaligniterativeBuffer) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_buffer_to_string(s : BioseqaligniterativeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_cursor_make(size : Int) -> BioseqaligniterativeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_cursor_len(s : BioseqaligniterativeCursor) -> Int { s.size }

pub fn bio_seq_align_iterative_cursor_get(s : BioseqaligniterativeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_cursor_set(s : BioseqaligniterativeCursor, i : Int, v : Double) -> BioseqaligniterativeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_cursor_sum(s : BioseqaligniterativeCursor) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_cursor_mean(s : BioseqaligniterativeCursor) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_cursor_scale(s : BioseqaligniterativeCursor, f : Double) -> BioseqaligniterativeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_cursor_add(a : BioseqaligniterativeCursor, b : BioseqaligniterativeCursor) -> BioseqaligniterativeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_cursor_copy(s : BioseqaligniterativeCursor) -> BioseqaligniterativeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_cursor_fill(s : BioseqaligniterativeCursor, v : Double) -> BioseqaligniterativeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_cursor_min(s : BioseqaligniterativeCursor) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_cursor_max(s : BioseqaligniterativeCursor) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_cursor_to_string(s : BioseqaligniterativeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_view_make(size : Int) -> BioseqaligniterativeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_view_len(s : BioseqaligniterativeView) -> Int { s.size }

pub fn bio_seq_align_iterative_view_get(s : BioseqaligniterativeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_view_set(s : BioseqaligniterativeView, i : Int, v : Double) -> BioseqaligniterativeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_view_sum(s : BioseqaligniterativeView) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_view_mean(s : BioseqaligniterativeView) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_view_scale(s : BioseqaligniterativeView, f : Double) -> BioseqaligniterativeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_view_add(a : BioseqaligniterativeView, b : BioseqaligniterativeView) -> BioseqaligniterativeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_view_copy(s : BioseqaligniterativeView) -> BioseqaligniterativeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_view_fill(s : BioseqaligniterativeView, v : Double) -> BioseqaligniterativeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_view_min(s : BioseqaligniterativeView) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_view_max(s : BioseqaligniterativeView) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_view_to_string(s : BioseqaligniterativeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_range_make(size : Int) -> BioseqaligniterativeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_range_len(s : BioseqaligniterativeRange) -> Int { s.size }

pub fn bio_seq_align_iterative_range_get(s : BioseqaligniterativeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_range_set(s : BioseqaligniterativeRange, i : Int, v : Double) -> BioseqaligniterativeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_range_sum(s : BioseqaligniterativeRange) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_range_mean(s : BioseqaligniterativeRange) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_range_scale(s : BioseqaligniterativeRange, f : Double) -> BioseqaligniterativeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_range_add(a : BioseqaligniterativeRange, b : BioseqaligniterativeRange) -> BioseqaligniterativeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_range_copy(s : BioseqaligniterativeRange) -> BioseqaligniterativeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_range_fill(s : BioseqaligniterativeRange, v : Double) -> BioseqaligniterativeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_range_min(s : BioseqaligniterativeRange) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_range_max(s : BioseqaligniterativeRange) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_range_to_string(s : BioseqaligniterativeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_slice_make(size : Int) -> BioseqaligniterativeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_slice_len(s : BioseqaligniterativeSlice) -> Int { s.size }

pub fn bio_seq_align_iterative_slice_get(s : BioseqaligniterativeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_slice_set(s : BioseqaligniterativeSlice, i : Int, v : Double) -> BioseqaligniterativeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_slice_sum(s : BioseqaligniterativeSlice) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_slice_mean(s : BioseqaligniterativeSlice) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_slice_scale(s : BioseqaligniterativeSlice, f : Double) -> BioseqaligniterativeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_slice_add(a : BioseqaligniterativeSlice, b : BioseqaligniterativeSlice) -> BioseqaligniterativeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_slice_copy(s : BioseqaligniterativeSlice) -> BioseqaligniterativeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_slice_fill(s : BioseqaligniterativeSlice, v : Double) -> BioseqaligniterativeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_slice_min(s : BioseqaligniterativeSlice) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_slice_max(s : BioseqaligniterativeSlice) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_slice_to_string(s : BioseqaligniterativeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

