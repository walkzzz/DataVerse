///===
/// extcore/bio_seq_assembly_greedy

pub(all) struct BioseqassemblygreedyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_greedy_make_point(x : Double, y : Double) -> BioseqassemblygreedyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_greedy_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblygreedyPoint {
  { x, y, z, label: 0 }
}

pub fn bio_seq_assembly_greedy_point_x(pt : BioseqassemblygreedyPoint) -> Double { pt.x }

pub fn bio_seq_assembly_greedy_point_y(pt : BioseqassemblygreedyPoint) -> Double { pt.y }

pub fn bio_seq_assembly_greedy_point_z(pt : BioseqassemblygreedyPoint) -> Double { pt.z }

pub fn bio_seq_assembly_greedy_point_label(pt : BioseqassemblygreedyPoint) -> Int { pt.label }

pub fn bio_seq_assembly_greedy_point_dist(a : BioseqassemblygreedyPoint, b : BioseqassemblygreedyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_seq_assembly_greedy_point_add(a : BioseqassemblygreedyPoint, b : BioseqassemblygreedyPoint) -> BioseqassemblygreedyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_seq_assembly_greedy_point_sub(a : BioseqassemblygreedyPoint, b : BioseqassemblygreedyPoint) -> BioseqassemblygreedyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_seq_assembly_greedy_point_scale(pt : BioseqassemblygreedyPoint, s : Double) -> BioseqassemblygreedyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_seq_assembly_greedy_point_dot(a : BioseqassemblygreedyPoint, b : BioseqassemblygreedyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_seq_assembly_greedy_point_cross(a : BioseqassemblygreedyPoint, b : BioseqassemblygreedyPoint) -> BioseqassemblygreedyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_seq_assembly_greedy_point_norm(pt : BioseqassemblygreedyPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_seq_assembly_greedy_point_normalize(pt : BioseqassemblygreedyPoint) -> BioseqassemblygreedyPoint {
  let n = bio_seq_assembly_greedy_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_seq_assembly_greedy_point_scale(pt, 1.0 / n) }
}

pub fn bio_seq_assembly_greedy_point_negate(pt : BioseqassemblygreedyPoint) -> BioseqassemblygreedyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_seq_assembly_greedy_point_mid(a : BioseqassemblygreedyPoint, b : BioseqassemblygreedyPoint) -> BioseqassemblygreedyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_seq_assembly_greedy_point_lerp(a : BioseqassemblygreedyPoint, b : BioseqassemblygreedyPoint, t : Double) -> BioseqassemblygreedyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_seq_assembly_greedy_point_to_string(pt : BioseqassemblygreedyPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BioseqassemblygreedySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_greedy_make_series(vals : Array[Double], name : String) -> BioseqassemblygreedySeries {
  { vals, name, meta: 0 }
}

pub fn bio_seq_assembly_greedy_series_len(s : BioseqassemblygreedySeries) -> Int { s.vals.length() }

pub fn bio_seq_assembly_greedy_series_sum(s : BioseqassemblygreedySeries) -> Double { @_common.sum(s.vals) }

pub fn bio_seq_assembly_greedy_series_mean(s : BioseqassemblygreedySeries) -> Double { @_common.mean(s.vals) }

pub fn bio_seq_assembly_greedy_series_min(s : BioseqassemblygreedySeries) -> Double { @_common.min(s.vals) }

pub fn bio_seq_assembly_greedy_series_max(s : BioseqassemblygreedySeries) -> Double { @_common.max(s.vals) }

pub fn bio_seq_assembly_greedy_series_range(s : BioseqassemblygreedySeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn bio_seq_assembly_greedy_series_var(s : BioseqassemblygreedySeries) -> Double { @_common.variance(s.vals) }

pub fn bio_seq_assembly_greedy_series_std(s : BioseqassemblygreedySeries) -> Double { @_common.std(s.vals) }

pub fn bio_seq_assembly_greedy_series_median(s : BioseqassemblygreedySeries) -> Double { @_common.median(s.vals) }

pub fn bio_seq_assembly_greedy_series_scale(s : BioseqassemblygreedySeries, f : Double) -> BioseqassemblygreedySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_seq_assembly_greedy_series_add(a : BioseqassemblygreedySeries, b : BioseqassemblygreedySeries) -> BioseqassemblygreedySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_seq_assembly_greedy_series_sub(a : BioseqassemblygreedySeries, b : BioseqassemblygreedySeries) -> BioseqassemblygreedySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_seq_assembly_greedy_series_normalize(s : BioseqassemblygreedySeries) -> BioseqassemblygreedySeries {
  let mn = bio_seq_assembly_greedy_series_min(s)
  let mx = bio_seq_assembly_greedy_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_seq_assembly_greedy_series_cumsum(s : BioseqassemblygreedySeries) -> BioseqassemblygreedySeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_seq_assembly_greedy_series_to_string(s : BioseqassemblygreedySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblygreedyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_greedy_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblygreedyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_greedy_matrix_identity(n : Int) -> BioseqassemblygreedyMatrix {
  let m = bio_seq_assembly_greedy_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_seq_assembly_greedy_matrix_get(m : BioseqassemblygreedyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_seq_assembly_greedy_matrix_transpose(m : BioseqassemblygreedyMatrix) -> BioseqassemblygreedyMatrix {
  let result = bio_seq_assembly_greedy_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_seq_assembly_greedy_matrix_add(a : BioseqassemblygreedyMatrix, b : BioseqassemblygreedyMatrix) -> BioseqassemblygreedyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_seq_assembly_greedy_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_seq_assembly_greedy_matrix_scale(m : BioseqassemblygreedyMatrix, s : Double) -> BioseqassemblygreedyMatrix {
  let result = bio_seq_assembly_greedy_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_seq_assembly_greedy_matrix_multiply(a : BioseqassemblygreedyMatrix, b : BioseqassemblygreedyMatrix) -> BioseqassemblygreedyMatrix {
  if a.cols != b.rows { return bio_seq_assembly_greedy_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_seq_assembly_greedy_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_seq_assembly_greedy_matrix_trace(m : BioseqassemblygreedyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_seq_assembly_greedy_matrix_det(m : BioseqassemblygreedyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_seq_assembly_greedy_matrix_norm(m : BioseqassemblygreedyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_seq_assembly_greedy_matrix_to_string(m : BioseqassemblygreedyMatrix) -> String {
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

pub(all) struct BioseqassemblygreedyVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_greedy_make_vector(comps : Array[Double]) -> BioseqassemblygreedyVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_greedy_vector_zero(dim : Int) -> BioseqassemblygreedyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_seq_assembly_greedy_vector_add(a : BioseqassemblygreedyVector, b : BioseqassemblygreedyVector) -> BioseqassemblygreedyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_assembly_greedy_vector_sub(a : BioseqassemblygreedyVector, b : BioseqassemblygreedyVector) -> BioseqassemblygreedyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_assembly_greedy_vector_scale(v : BioseqassemblygreedyVector, s : Double) -> BioseqassemblygreedyVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_seq_assembly_greedy_vector_dot(a : BioseqassemblygreedyVector, b : BioseqassemblygreedyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_seq_assembly_greedy_vector_norm(v : BioseqassemblygreedyVector) -> Double { @_common.sqrt(bio_seq_assembly_greedy_vector_dot(v, v)) }

pub fn bio_seq_assembly_greedy_vector_normalize(v : BioseqassemblygreedyVector) -> BioseqassemblygreedyVector {
  let n = bio_seq_assembly_greedy_vector_norm(v)
  if n < 0.0000001 { v } else { bio_seq_assembly_greedy_vector_scale(v, 1.0 / n) }
}

pub fn bio_seq_assembly_greedy_vector_dist(a : BioseqassemblygreedyVector, b : BioseqassemblygreedyVector) -> Double {
  bio_seq_assembly_greedy_vector_norm(bio_seq_assembly_greedy_vector_sub(a, b))
}

pub fn bio_seq_assembly_greedy_vector_to_string(v : BioseqassemblygreedyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_assembly_greedy_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_assembly_greedy_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_assembly_greedy_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_assembly_greedy_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_assembly_greedy_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_assembly_greedy_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_assembly_greedy_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_assembly_greedy_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_assembly_greedy_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_assembly_greedy_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_assembly_greedy_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_assembly_greedy_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_assembly_greedy_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_assembly_greedy_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_assembly_greedy_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_assembly_greedy_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_assembly_greedy_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_assembly_greedy_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_assembly_greedy_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_assembly_greedy_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_assembly_greedy_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_assembly_greedy_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_assembly_greedy_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_assembly_greedy_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_assembly_greedy_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_assembly_greedy_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_assembly_greedy_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_assembly_greedy_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_assembly_greedy_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqassemblygreedyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_frame_make(size : Int) -> BioseqassemblygreedyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_frame_len(s : BioseqassemblygreedyFrame) -> Int { s.size }

pub fn bio_seq_assembly_greedy_frame_get(s : BioseqassemblygreedyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_frame_set(s : BioseqassemblygreedyFrame, i : Int, v : Double) -> BioseqassemblygreedyFrame {
  let result = bio_seq_assembly_greedy_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_frame_sum(s : BioseqassemblygreedyFrame) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_frame_mean(s : BioseqassemblygreedyFrame) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_frame_scale(s : BioseqassemblygreedyFrame, f : Double) -> BioseqassemblygreedyFrame {
  let result = bio_seq_assembly_greedy_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_greedy_frame_add(a : BioseqassemblygreedyFrame, b : BioseqassemblygreedyFrame) -> BioseqassemblygreedyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_greedy_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_frame_copy(s : BioseqassemblygreedyFrame) -> BioseqassemblygreedyFrame {
  let result = bio_seq_assembly_greedy_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_frame_fill(s : BioseqassemblygreedyFrame, v : Double) -> BioseqassemblygreedyFrame {
  let result = bio_seq_assembly_greedy_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_frame_min(s : BioseqassemblygreedyFrame) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_frame_max(s : BioseqassemblygreedyFrame) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_frame_to_string(s : BioseqassemblygreedyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_table_make(size : Int) -> BioseqassemblygreedyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_table_len(s : BioseqassemblygreedyTable) -> Int { s.size }

pub fn bio_seq_assembly_greedy_table_get(s : BioseqassemblygreedyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_table_set(s : BioseqassemblygreedyTable, i : Int, v : Double) -> BioseqassemblygreedyTable {
  let result = bio_seq_assembly_greedy_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_table_sum(s : BioseqassemblygreedyTable) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_table_mean(s : BioseqassemblygreedyTable) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_table_scale(s : BioseqassemblygreedyTable, f : Double) -> BioseqassemblygreedyTable {
  let result = bio_seq_assembly_greedy_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_greedy_table_add(a : BioseqassemblygreedyTable, b : BioseqassemblygreedyTable) -> BioseqassemblygreedyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_greedy_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_table_copy(s : BioseqassemblygreedyTable) -> BioseqassemblygreedyTable {
  let result = bio_seq_assembly_greedy_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_table_fill(s : BioseqassemblygreedyTable, v : Double) -> BioseqassemblygreedyTable {
  let result = bio_seq_assembly_greedy_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_table_min(s : BioseqassemblygreedyTable) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_table_max(s : BioseqassemblygreedyTable) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_table_to_string(s : BioseqassemblygreedyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_graphn_make(size : Int) -> BioseqassemblygreedyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_graphn_len(s : BioseqassemblygreedyGraphN) -> Int { s.size }

pub fn bio_seq_assembly_greedy_graphn_get(s : BioseqassemblygreedyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_graphn_set(s : BioseqassemblygreedyGraphN, i : Int, v : Double) -> BioseqassemblygreedyGraphN {
  let result = bio_seq_assembly_greedy_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_graphn_sum(s : BioseqassemblygreedyGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_graphn_mean(s : BioseqassemblygreedyGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_graphn_scale(s : BioseqassemblygreedyGraphN, f : Double) -> BioseqassemblygreedyGraphN {
  let result = bio_seq_assembly_greedy_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_greedy_graphn_add(a : BioseqassemblygreedyGraphN, b : BioseqassemblygreedyGraphN) -> BioseqassemblygreedyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_greedy_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_graphn_copy(s : BioseqassemblygreedyGraphN) -> BioseqassemblygreedyGraphN {
  let result = bio_seq_assembly_greedy_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_graphn_fill(s : BioseqassemblygreedyGraphN, v : Double) -> BioseqassemblygreedyGraphN {
  let result = bio_seq_assembly_greedy_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_graphn_min(s : BioseqassemblygreedyGraphN) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_graphn_max(s : BioseqassemblygreedyGraphN) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_graphn_to_string(s : BioseqassemblygreedyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_node_make(size : Int) -> BioseqassemblygreedyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_node_len(s : BioseqassemblygreedyNode) -> Int { s.size }

pub fn bio_seq_assembly_greedy_node_get(s : BioseqassemblygreedyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_node_set(s : BioseqassemblygreedyNode, i : Int, v : Double) -> BioseqassemblygreedyNode {
  let result = bio_seq_assembly_greedy_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_node_sum(s : BioseqassemblygreedyNode) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_node_mean(s : BioseqassemblygreedyNode) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_node_scale(s : BioseqassemblygreedyNode, f : Double) -> BioseqassemblygreedyNode {
  let result = bio_seq_assembly_greedy_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_greedy_node_add(a : BioseqassemblygreedyNode, b : BioseqassemblygreedyNode) -> BioseqassemblygreedyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_greedy_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_node_copy(s : BioseqassemblygreedyNode) -> BioseqassemblygreedyNode {
  let result = bio_seq_assembly_greedy_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_node_fill(s : BioseqassemblygreedyNode, v : Double) -> BioseqassemblygreedyNode {
  let result = bio_seq_assembly_greedy_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_node_min(s : BioseqassemblygreedyNode) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_node_max(s : BioseqassemblygreedyNode) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_node_to_string(s : BioseqassemblygreedyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_edge_make(size : Int) -> BioseqassemblygreedyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_edge_len(s : BioseqassemblygreedyEdge) -> Int { s.size }

pub fn bio_seq_assembly_greedy_edge_get(s : BioseqassemblygreedyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_edge_set(s : BioseqassemblygreedyEdge, i : Int, v : Double) -> BioseqassemblygreedyEdge {
  let result = bio_seq_assembly_greedy_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_edge_sum(s : BioseqassemblygreedyEdge) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_edge_mean(s : BioseqassemblygreedyEdge) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_edge_scale(s : BioseqassemblygreedyEdge, f : Double) -> BioseqassemblygreedyEdge {
  let result = bio_seq_assembly_greedy_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_greedy_edge_add(a : BioseqassemblygreedyEdge, b : BioseqassemblygreedyEdge) -> BioseqassemblygreedyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_greedy_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_edge_copy(s : BioseqassemblygreedyEdge) -> BioseqassemblygreedyEdge {
  let result = bio_seq_assembly_greedy_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_edge_fill(s : BioseqassemblygreedyEdge, v : Double) -> BioseqassemblygreedyEdge {
  let result = bio_seq_assembly_greedy_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_edge_min(s : BioseqassemblygreedyEdge) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_edge_max(s : BioseqassemblygreedyEdge) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_edge_to_string(s : BioseqassemblygreedyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_path_make(size : Int) -> BioseqassemblygreedyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_path_len(s : BioseqassemblygreedyPath) -> Int { s.size }

pub fn bio_seq_assembly_greedy_path_get(s : BioseqassemblygreedyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_path_set(s : BioseqassemblygreedyPath, i : Int, v : Double) -> BioseqassemblygreedyPath {
  let result = bio_seq_assembly_greedy_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_path_sum(s : BioseqassemblygreedyPath) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_path_mean(s : BioseqassemblygreedyPath) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_path_scale(s : BioseqassemblygreedyPath, f : Double) -> BioseqassemblygreedyPath {
  let result = bio_seq_assembly_greedy_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_greedy_path_add(a : BioseqassemblygreedyPath, b : BioseqassemblygreedyPath) -> BioseqassemblygreedyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_greedy_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_path_copy(s : BioseqassemblygreedyPath) -> BioseqassemblygreedyPath {
  let result = bio_seq_assembly_greedy_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_path_fill(s : BioseqassemblygreedyPath, v : Double) -> BioseqassemblygreedyPath {
  let result = bio_seq_assembly_greedy_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_path_min(s : BioseqassemblygreedyPath) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_path_max(s : BioseqassemblygreedyPath) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_path_to_string(s : BioseqassemblygreedyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_cluster_make(size : Int) -> BioseqassemblygreedyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_cluster_len(s : BioseqassemblygreedyCluster) -> Int { s.size }

pub fn bio_seq_assembly_greedy_cluster_get(s : BioseqassemblygreedyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_cluster_set(s : BioseqassemblygreedyCluster, i : Int, v : Double) -> BioseqassemblygreedyCluster {
  let result = bio_seq_assembly_greedy_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_cluster_sum(s : BioseqassemblygreedyCluster) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_cluster_mean(s : BioseqassemblygreedyCluster) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_cluster_scale(s : BioseqassemblygreedyCluster, f : Double) -> BioseqassemblygreedyCluster {
  let result = bio_seq_assembly_greedy_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_greedy_cluster_add(a : BioseqassemblygreedyCluster, b : BioseqassemblygreedyCluster) -> BioseqassemblygreedyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_greedy_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_cluster_copy(s : BioseqassemblygreedyCluster) -> BioseqassemblygreedyCluster {
  let result = bio_seq_assembly_greedy_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_cluster_fill(s : BioseqassemblygreedyCluster, v : Double) -> BioseqassemblygreedyCluster {
  let result = bio_seq_assembly_greedy_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_cluster_min(s : BioseqassemblygreedyCluster) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_cluster_max(s : BioseqassemblygreedyCluster) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_cluster_to_string(s : BioseqassemblygreedyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_model_make(size : Int) -> BioseqassemblygreedyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_model_len(s : BioseqassemblygreedyModel) -> Int { s.size }

pub fn bio_seq_assembly_greedy_model_get(s : BioseqassemblygreedyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_model_set(s : BioseqassemblygreedyModel, i : Int, v : Double) -> BioseqassemblygreedyModel {
  let result = bio_seq_assembly_greedy_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_model_sum(s : BioseqassemblygreedyModel) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_model_mean(s : BioseqassemblygreedyModel) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_model_scale(s : BioseqassemblygreedyModel, f : Double) -> BioseqassemblygreedyModel {
  let result = bio_seq_assembly_greedy_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_greedy_model_add(a : BioseqassemblygreedyModel, b : BioseqassemblygreedyModel) -> BioseqassemblygreedyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_greedy_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_model_copy(s : BioseqassemblygreedyModel) -> BioseqassemblygreedyModel {
  let result = bio_seq_assembly_greedy_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_model_fill(s : BioseqassemblygreedyModel, v : Double) -> BioseqassemblygreedyModel {
  let result = bio_seq_assembly_greedy_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_model_min(s : BioseqassemblygreedyModel) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_model_max(s : BioseqassemblygreedyModel) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_model_to_string(s : BioseqassemblygreedyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_layer_make(size : Int) -> BioseqassemblygreedyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_layer_len(s : BioseqassemblygreedyLayer) -> Int { s.size }

pub fn bio_seq_assembly_greedy_layer_get(s : BioseqassemblygreedyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_layer_set(s : BioseqassemblygreedyLayer, i : Int, v : Double) -> BioseqassemblygreedyLayer {
  let result = bio_seq_assembly_greedy_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_layer_sum(s : BioseqassemblygreedyLayer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_layer_mean(s : BioseqassemblygreedyLayer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_layer_scale(s : BioseqassemblygreedyLayer, f : Double) -> BioseqassemblygreedyLayer {
  let result = bio_seq_assembly_greedy_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_greedy_layer_add(a : BioseqassemblygreedyLayer, b : BioseqassemblygreedyLayer) -> BioseqassemblygreedyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_greedy_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_layer_copy(s : BioseqassemblygreedyLayer) -> BioseqassemblygreedyLayer {
  let result = bio_seq_assembly_greedy_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_layer_fill(s : BioseqassemblygreedyLayer, v : Double) -> BioseqassemblygreedyLayer {
  let result = bio_seq_assembly_greedy_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_layer_min(s : BioseqassemblygreedyLayer) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_layer_max(s : BioseqassemblygreedyLayer) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_layer_to_string(s : BioseqassemblygreedyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_buffer_make(size : Int) -> BioseqassemblygreedyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_buffer_len(s : BioseqassemblygreedyBuffer) -> Int { s.size }

pub fn bio_seq_assembly_greedy_buffer_get(s : BioseqassemblygreedyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_buffer_set(s : BioseqassemblygreedyBuffer, i : Int, v : Double) -> BioseqassemblygreedyBuffer {
  let result = bio_seq_assembly_greedy_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_buffer_sum(s : BioseqassemblygreedyBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_buffer_mean(s : BioseqassemblygreedyBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_buffer_scale(s : BioseqassemblygreedyBuffer, f : Double) -> BioseqassemblygreedyBuffer {
  let result = bio_seq_assembly_greedy_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_greedy_buffer_add(a : BioseqassemblygreedyBuffer, b : BioseqassemblygreedyBuffer) -> BioseqassemblygreedyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_greedy_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_buffer_copy(s : BioseqassemblygreedyBuffer) -> BioseqassemblygreedyBuffer {
  let result = bio_seq_assembly_greedy_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_buffer_fill(s : BioseqassemblygreedyBuffer, v : Double) -> BioseqassemblygreedyBuffer {
  let result = bio_seq_assembly_greedy_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_buffer_min(s : BioseqassemblygreedyBuffer) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_buffer_max(s : BioseqassemblygreedyBuffer) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_buffer_to_string(s : BioseqassemblygreedyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_cursor_make(size : Int) -> BioseqassemblygreedyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_cursor_len(s : BioseqassemblygreedyCursor) -> Int { s.size }

pub fn bio_seq_assembly_greedy_cursor_get(s : BioseqassemblygreedyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_cursor_set(s : BioseqassemblygreedyCursor, i : Int, v : Double) -> BioseqassemblygreedyCursor {
  let result = bio_seq_assembly_greedy_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_cursor_sum(s : BioseqassemblygreedyCursor) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_cursor_mean(s : BioseqassemblygreedyCursor) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_cursor_scale(s : BioseqassemblygreedyCursor, f : Double) -> BioseqassemblygreedyCursor {
  let result = bio_seq_assembly_greedy_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_greedy_cursor_add(a : BioseqassemblygreedyCursor, b : BioseqassemblygreedyCursor) -> BioseqassemblygreedyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_greedy_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_cursor_copy(s : BioseqassemblygreedyCursor) -> BioseqassemblygreedyCursor {
  let result = bio_seq_assembly_greedy_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_cursor_fill(s : BioseqassemblygreedyCursor, v : Double) -> BioseqassemblygreedyCursor {
  let result = bio_seq_assembly_greedy_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_cursor_min(s : BioseqassemblygreedyCursor) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_cursor_max(s : BioseqassemblygreedyCursor) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_cursor_to_string(s : BioseqassemblygreedyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_view_make(size : Int) -> BioseqassemblygreedyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_view_len(s : BioseqassemblygreedyView) -> Int { s.size }

pub fn bio_seq_assembly_greedy_view_get(s : BioseqassemblygreedyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_view_set(s : BioseqassemblygreedyView, i : Int, v : Double) -> BioseqassemblygreedyView {
  let result = bio_seq_assembly_greedy_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_view_sum(s : BioseqassemblygreedyView) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_view_mean(s : BioseqassemblygreedyView) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_view_scale(s : BioseqassemblygreedyView, f : Double) -> BioseqassemblygreedyView {
  let result = bio_seq_assembly_greedy_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_greedy_view_add(a : BioseqassemblygreedyView, b : BioseqassemblygreedyView) -> BioseqassemblygreedyView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_greedy_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_view_copy(s : BioseqassemblygreedyView) -> BioseqassemblygreedyView {
  let result = bio_seq_assembly_greedy_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_view_fill(s : BioseqassemblygreedyView, v : Double) -> BioseqassemblygreedyView {
  let result = bio_seq_assembly_greedy_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_view_min(s : BioseqassemblygreedyView) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_view_max(s : BioseqassemblygreedyView) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_view_to_string(s : BioseqassemblygreedyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_range_make(size : Int) -> BioseqassemblygreedyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_range_len(s : BioseqassemblygreedyRange) -> Int { s.size }

pub fn bio_seq_assembly_greedy_range_get(s : BioseqassemblygreedyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_range_set(s : BioseqassemblygreedyRange, i : Int, v : Double) -> BioseqassemblygreedyRange {
  let result = bio_seq_assembly_greedy_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_range_sum(s : BioseqassemblygreedyRange) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_range_mean(s : BioseqassemblygreedyRange) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_range_scale(s : BioseqassemblygreedyRange, f : Double) -> BioseqassemblygreedyRange {
  let result = bio_seq_assembly_greedy_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_greedy_range_add(a : BioseqassemblygreedyRange, b : BioseqassemblygreedyRange) -> BioseqassemblygreedyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_greedy_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_range_copy(s : BioseqassemblygreedyRange) -> BioseqassemblygreedyRange {
  let result = bio_seq_assembly_greedy_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_range_fill(s : BioseqassemblygreedyRange, v : Double) -> BioseqassemblygreedyRange {
  let result = bio_seq_assembly_greedy_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_range_min(s : BioseqassemblygreedyRange) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_range_max(s : BioseqassemblygreedyRange) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_range_to_string(s : BioseqassemblygreedyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_slice_make(size : Int) -> BioseqassemblygreedySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_slice_len(s : BioseqassemblygreedySlice) -> Int { s.size }

pub fn bio_seq_assembly_greedy_slice_get(s : BioseqassemblygreedySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_slice_set(s : BioseqassemblygreedySlice, i : Int, v : Double) -> BioseqassemblygreedySlice {
  let result = bio_seq_assembly_greedy_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_slice_sum(s : BioseqassemblygreedySlice) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_slice_mean(s : BioseqassemblygreedySlice) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_slice_scale(s : BioseqassemblygreedySlice, f : Double) -> BioseqassemblygreedySlice {
  let result = bio_seq_assembly_greedy_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_greedy_slice_add(a : BioseqassemblygreedySlice, b : BioseqassemblygreedySlice) -> BioseqassemblygreedySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_greedy_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_slice_copy(s : BioseqassemblygreedySlice) -> BioseqassemblygreedySlice {
  let result = bio_seq_assembly_greedy_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_greedy_slice_fill(s : BioseqassemblygreedySlice, v : Double) -> BioseqassemblygreedySlice {
  let result = bio_seq_assembly_greedy_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_greedy_slice_min(s : BioseqassemblygreedySlice) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_slice_max(s : BioseqassemblygreedySlice) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_slice_to_string(s : BioseqassemblygreedySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

