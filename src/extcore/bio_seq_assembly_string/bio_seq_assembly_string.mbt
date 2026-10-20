///===
/// extcore/bio_seq_assembly_string

pub(all) struct BioseqassemblystringPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_string_make_point(x : Double, y : Double) -> BioseqassemblystringPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_string_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblystringPoint {
  { x, y, z, label: 0 }
}

pub fn bio_seq_assembly_string_point_x(pt : BioseqassemblystringPoint) -> Double { pt.x }

pub fn bio_seq_assembly_string_point_y(pt : BioseqassemblystringPoint) -> Double { pt.y }

pub fn bio_seq_assembly_string_point_z(pt : BioseqassemblystringPoint) -> Double { pt.z }

pub fn bio_seq_assembly_string_point_label(pt : BioseqassemblystringPoint) -> Int { pt.label }

pub fn bio_seq_assembly_string_point_dist(a : BioseqassemblystringPoint, b : BioseqassemblystringPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_seq_assembly_string_point_add(a : BioseqassemblystringPoint, b : BioseqassemblystringPoint) -> BioseqassemblystringPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_seq_assembly_string_point_sub(a : BioseqassemblystringPoint, b : BioseqassemblystringPoint) -> BioseqassemblystringPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_seq_assembly_string_point_scale(pt : BioseqassemblystringPoint, s : Double) -> BioseqassemblystringPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_seq_assembly_string_point_dot(a : BioseqassemblystringPoint, b : BioseqassemblystringPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_seq_assembly_string_point_cross(a : BioseqassemblystringPoint, b : BioseqassemblystringPoint) -> BioseqassemblystringPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_seq_assembly_string_point_norm(pt : BioseqassemblystringPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_seq_assembly_string_point_normalize(pt : BioseqassemblystringPoint) -> BioseqassemblystringPoint {
  let n = bio_seq_assembly_string_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_seq_assembly_string_point_scale(pt, 1.0 / n) }
}

pub fn bio_seq_assembly_string_point_negate(pt : BioseqassemblystringPoint) -> BioseqassemblystringPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_seq_assembly_string_point_mid(a : BioseqassemblystringPoint, b : BioseqassemblystringPoint) -> BioseqassemblystringPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_seq_assembly_string_point_lerp(a : BioseqassemblystringPoint, b : BioseqassemblystringPoint, t : Double) -> BioseqassemblystringPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_seq_assembly_string_point_to_string(pt : BioseqassemblystringPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BioseqassemblystringSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_string_make_series(vals : Array[Double], name : String) -> BioseqassemblystringSeries {
  { vals, name, meta: 0 }
}

pub fn bio_seq_assembly_string_series_len(s : BioseqassemblystringSeries) -> Int { s.vals.length() }

pub fn bio_seq_assembly_string_series_sum(s : BioseqassemblystringSeries) -> Double { @_common.sum(s.vals) }

pub fn bio_seq_assembly_string_series_mean(s : BioseqassemblystringSeries) -> Double { @_common.mean(s.vals) }

pub fn bio_seq_assembly_string_series_min(s : BioseqassemblystringSeries) -> Double { @_common.min(s.vals) }

pub fn bio_seq_assembly_string_series_max(s : BioseqassemblystringSeries) -> Double { @_common.max(s.vals) }

pub fn bio_seq_assembly_string_series_range(s : BioseqassemblystringSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn bio_seq_assembly_string_series_var(s : BioseqassemblystringSeries) -> Double { @_common.variance(s.vals) }

pub fn bio_seq_assembly_string_series_std(s : BioseqassemblystringSeries) -> Double { @_common.std(s.vals) }

pub fn bio_seq_assembly_string_series_median(s : BioseqassemblystringSeries) -> Double { @_common.median(s.vals) }

pub fn bio_seq_assembly_string_series_scale(s : BioseqassemblystringSeries, f : Double) -> BioseqassemblystringSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_seq_assembly_string_series_add(a : BioseqassemblystringSeries, b : BioseqassemblystringSeries) -> BioseqassemblystringSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_seq_assembly_string_series_sub(a : BioseqassemblystringSeries, b : BioseqassemblystringSeries) -> BioseqassemblystringSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_seq_assembly_string_series_normalize(s : BioseqassemblystringSeries) -> BioseqassemblystringSeries {
  let mn = bio_seq_assembly_string_series_min(s)
  let mx = bio_seq_assembly_string_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_seq_assembly_string_series_cumsum(s : BioseqassemblystringSeries) -> BioseqassemblystringSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_seq_assembly_string_series_to_string(s : BioseqassemblystringSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblystringMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_string_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblystringMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_string_matrix_identity(n : Int) -> BioseqassemblystringMatrix {
  let m = bio_seq_assembly_string_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_seq_assembly_string_matrix_get(m : BioseqassemblystringMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_seq_assembly_string_matrix_transpose(m : BioseqassemblystringMatrix) -> BioseqassemblystringMatrix {
  let result = bio_seq_assembly_string_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_seq_assembly_string_matrix_add(a : BioseqassemblystringMatrix, b : BioseqassemblystringMatrix) -> BioseqassemblystringMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_seq_assembly_string_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_seq_assembly_string_matrix_scale(m : BioseqassemblystringMatrix, s : Double) -> BioseqassemblystringMatrix {
  let result = bio_seq_assembly_string_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_seq_assembly_string_matrix_multiply(a : BioseqassemblystringMatrix, b : BioseqassemblystringMatrix) -> BioseqassemblystringMatrix {
  if a.cols != b.rows { return bio_seq_assembly_string_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_seq_assembly_string_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_seq_assembly_string_matrix_trace(m : BioseqassemblystringMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_seq_assembly_string_matrix_det(m : BioseqassemblystringMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_seq_assembly_string_matrix_norm(m : BioseqassemblystringMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_seq_assembly_string_matrix_to_string(m : BioseqassemblystringMatrix) -> String {
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

pub(all) struct BioseqassemblystringVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_string_make_vector(comps : Array[Double]) -> BioseqassemblystringVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_string_vector_zero(dim : Int) -> BioseqassemblystringVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_seq_assembly_string_vector_add(a : BioseqassemblystringVector, b : BioseqassemblystringVector) -> BioseqassemblystringVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_assembly_string_vector_sub(a : BioseqassemblystringVector, b : BioseqassemblystringVector) -> BioseqassemblystringVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_assembly_string_vector_scale(v : BioseqassemblystringVector, s : Double) -> BioseqassemblystringVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_seq_assembly_string_vector_dot(a : BioseqassemblystringVector, b : BioseqassemblystringVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_seq_assembly_string_vector_norm(v : BioseqassemblystringVector) -> Double { @_common.sqrt(bio_seq_assembly_string_vector_dot(v, v)) }

pub fn bio_seq_assembly_string_vector_normalize(v : BioseqassemblystringVector) -> BioseqassemblystringVector {
  let n = bio_seq_assembly_string_vector_norm(v)
  if n < 0.0000001 { v } else { bio_seq_assembly_string_vector_scale(v, 1.0 / n) }
}

pub fn bio_seq_assembly_string_vector_dist(a : BioseqassemblystringVector, b : BioseqassemblystringVector) -> Double {
  bio_seq_assembly_string_vector_norm(bio_seq_assembly_string_vector_sub(a, b))
}

pub fn bio_seq_assembly_string_vector_to_string(v : BioseqassemblystringVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_assembly_string_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_assembly_string_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_assembly_string_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_assembly_string_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_assembly_string_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_assembly_string_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_assembly_string_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_assembly_string_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_assembly_string_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_assembly_string_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_assembly_string_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_assembly_string_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_assembly_string_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_assembly_string_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_assembly_string_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_assembly_string_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_assembly_string_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_assembly_string_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_assembly_string_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_assembly_string_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_assembly_string_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_assembly_string_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_assembly_string_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_assembly_string_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_assembly_string_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_assembly_string_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_assembly_string_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_assembly_string_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_assembly_string_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqassemblystringFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_frame_make(size : Int) -> BioseqassemblystringFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_frame_len(s : BioseqassemblystringFrame) -> Int { s.size }

pub fn bio_seq_assembly_string_frame_get(s : BioseqassemblystringFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_frame_set(s : BioseqassemblystringFrame, i : Int, v : Double) -> BioseqassemblystringFrame {
  let result = bio_seq_assembly_string_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_frame_sum(s : BioseqassemblystringFrame) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_string_frame_mean(s : BioseqassemblystringFrame) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_string_frame_scale(s : BioseqassemblystringFrame, f : Double) -> BioseqassemblystringFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_frame_add(a : BioseqassemblystringFrame, b : BioseqassemblystringFrame) -> BioseqassemblystringFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_string_frame_copy(s : BioseqassemblystringFrame) -> BioseqassemblystringFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_frame_fill(s : BioseqassemblystringFrame, v : Double) -> BioseqassemblystringFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_frame_min(s : BioseqassemblystringFrame) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_string_frame_max(s : BioseqassemblystringFrame) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_string_frame_to_string(s : BioseqassemblystringFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_table_make(size : Int) -> BioseqassemblystringTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_table_len(s : BioseqassemblystringTable) -> Int { s.size }

pub fn bio_seq_assembly_string_table_get(s : BioseqassemblystringTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_table_set(s : BioseqassemblystringTable, i : Int, v : Double) -> BioseqassemblystringTable {
  let result = bio_seq_assembly_string_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_table_sum(s : BioseqassemblystringTable) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_string_table_mean(s : BioseqassemblystringTable) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_string_table_scale(s : BioseqassemblystringTable, f : Double) -> BioseqassemblystringTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_table_add(a : BioseqassemblystringTable, b : BioseqassemblystringTable) -> BioseqassemblystringTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_string_table_copy(s : BioseqassemblystringTable) -> BioseqassemblystringTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_table_fill(s : BioseqassemblystringTable, v : Double) -> BioseqassemblystringTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_table_min(s : BioseqassemblystringTable) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_string_table_max(s : BioseqassemblystringTable) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_string_table_to_string(s : BioseqassemblystringTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_graphn_make(size : Int) -> BioseqassemblystringGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_graphn_len(s : BioseqassemblystringGraphN) -> Int { s.size }

pub fn bio_seq_assembly_string_graphn_get(s : BioseqassemblystringGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_graphn_set(s : BioseqassemblystringGraphN, i : Int, v : Double) -> BioseqassemblystringGraphN {
  let result = bio_seq_assembly_string_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_graphn_sum(s : BioseqassemblystringGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_string_graphn_mean(s : BioseqassemblystringGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_string_graphn_scale(s : BioseqassemblystringGraphN, f : Double) -> BioseqassemblystringGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_graphn_add(a : BioseqassemblystringGraphN, b : BioseqassemblystringGraphN) -> BioseqassemblystringGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_string_graphn_copy(s : BioseqassemblystringGraphN) -> BioseqassemblystringGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_graphn_fill(s : BioseqassemblystringGraphN, v : Double) -> BioseqassemblystringGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_graphn_min(s : BioseqassemblystringGraphN) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_string_graphn_max(s : BioseqassemblystringGraphN) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_string_graphn_to_string(s : BioseqassemblystringGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_node_make(size : Int) -> BioseqassemblystringNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_node_len(s : BioseqassemblystringNode) -> Int { s.size }

pub fn bio_seq_assembly_string_node_get(s : BioseqassemblystringNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_node_set(s : BioseqassemblystringNode, i : Int, v : Double) -> BioseqassemblystringNode {
  let result = bio_seq_assembly_string_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_node_sum(s : BioseqassemblystringNode) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_string_node_mean(s : BioseqassemblystringNode) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_string_node_scale(s : BioseqassemblystringNode, f : Double) -> BioseqassemblystringNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_node_add(a : BioseqassemblystringNode, b : BioseqassemblystringNode) -> BioseqassemblystringNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_string_node_copy(s : BioseqassemblystringNode) -> BioseqassemblystringNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_node_fill(s : BioseqassemblystringNode, v : Double) -> BioseqassemblystringNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_node_min(s : BioseqassemblystringNode) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_string_node_max(s : BioseqassemblystringNode) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_string_node_to_string(s : BioseqassemblystringNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_edge_make(size : Int) -> BioseqassemblystringEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_edge_len(s : BioseqassemblystringEdge) -> Int { s.size }

pub fn bio_seq_assembly_string_edge_get(s : BioseqassemblystringEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_edge_set(s : BioseqassemblystringEdge, i : Int, v : Double) -> BioseqassemblystringEdge {
  let result = bio_seq_assembly_string_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_edge_sum(s : BioseqassemblystringEdge) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_string_edge_mean(s : BioseqassemblystringEdge) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_string_edge_scale(s : BioseqassemblystringEdge, f : Double) -> BioseqassemblystringEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_edge_add(a : BioseqassemblystringEdge, b : BioseqassemblystringEdge) -> BioseqassemblystringEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_string_edge_copy(s : BioseqassemblystringEdge) -> BioseqassemblystringEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_edge_fill(s : BioseqassemblystringEdge, v : Double) -> BioseqassemblystringEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_edge_min(s : BioseqassemblystringEdge) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_string_edge_max(s : BioseqassemblystringEdge) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_string_edge_to_string(s : BioseqassemblystringEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_path_make(size : Int) -> BioseqassemblystringPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_path_len(s : BioseqassemblystringPath) -> Int { s.size }

pub fn bio_seq_assembly_string_path_get(s : BioseqassemblystringPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_path_set(s : BioseqassemblystringPath, i : Int, v : Double) -> BioseqassemblystringPath {
  let result = bio_seq_assembly_string_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_path_sum(s : BioseqassemblystringPath) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_string_path_mean(s : BioseqassemblystringPath) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_string_path_scale(s : BioseqassemblystringPath, f : Double) -> BioseqassemblystringPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_path_add(a : BioseqassemblystringPath, b : BioseqassemblystringPath) -> BioseqassemblystringPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_string_path_copy(s : BioseqassemblystringPath) -> BioseqassemblystringPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_path_fill(s : BioseqassemblystringPath, v : Double) -> BioseqassemblystringPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_path_min(s : BioseqassemblystringPath) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_string_path_max(s : BioseqassemblystringPath) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_string_path_to_string(s : BioseqassemblystringPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_cluster_make(size : Int) -> BioseqassemblystringCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_cluster_len(s : BioseqassemblystringCluster) -> Int { s.size }

pub fn bio_seq_assembly_string_cluster_get(s : BioseqassemblystringCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_cluster_set(s : BioseqassemblystringCluster, i : Int, v : Double) -> BioseqassemblystringCluster {
  let result = bio_seq_assembly_string_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_cluster_sum(s : BioseqassemblystringCluster) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_string_cluster_mean(s : BioseqassemblystringCluster) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_string_cluster_scale(s : BioseqassemblystringCluster, f : Double) -> BioseqassemblystringCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_cluster_add(a : BioseqassemblystringCluster, b : BioseqassemblystringCluster) -> BioseqassemblystringCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_string_cluster_copy(s : BioseqassemblystringCluster) -> BioseqassemblystringCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_cluster_fill(s : BioseqassemblystringCluster, v : Double) -> BioseqassemblystringCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_cluster_min(s : BioseqassemblystringCluster) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_string_cluster_max(s : BioseqassemblystringCluster) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_string_cluster_to_string(s : BioseqassemblystringCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_model_make(size : Int) -> BioseqassemblystringModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_model_len(s : BioseqassemblystringModel) -> Int { s.size }

pub fn bio_seq_assembly_string_model_get(s : BioseqassemblystringModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_model_set(s : BioseqassemblystringModel, i : Int, v : Double) -> BioseqassemblystringModel {
  let result = bio_seq_assembly_string_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_model_sum(s : BioseqassemblystringModel) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_string_model_mean(s : BioseqassemblystringModel) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_string_model_scale(s : BioseqassemblystringModel, f : Double) -> BioseqassemblystringModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_model_add(a : BioseqassemblystringModel, b : BioseqassemblystringModel) -> BioseqassemblystringModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_string_model_copy(s : BioseqassemblystringModel) -> BioseqassemblystringModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_model_fill(s : BioseqassemblystringModel, v : Double) -> BioseqassemblystringModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_model_min(s : BioseqassemblystringModel) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_string_model_max(s : BioseqassemblystringModel) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_string_model_to_string(s : BioseqassemblystringModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_layer_make(size : Int) -> BioseqassemblystringLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_layer_len(s : BioseqassemblystringLayer) -> Int { s.size }

pub fn bio_seq_assembly_string_layer_get(s : BioseqassemblystringLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_layer_set(s : BioseqassemblystringLayer, i : Int, v : Double) -> BioseqassemblystringLayer {
  let result = bio_seq_assembly_string_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_layer_sum(s : BioseqassemblystringLayer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_string_layer_mean(s : BioseqassemblystringLayer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_string_layer_scale(s : BioseqassemblystringLayer, f : Double) -> BioseqassemblystringLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_layer_add(a : BioseqassemblystringLayer, b : BioseqassemblystringLayer) -> BioseqassemblystringLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_string_layer_copy(s : BioseqassemblystringLayer) -> BioseqassemblystringLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_layer_fill(s : BioseqassemblystringLayer, v : Double) -> BioseqassemblystringLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_layer_min(s : BioseqassemblystringLayer) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_string_layer_max(s : BioseqassemblystringLayer) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_string_layer_to_string(s : BioseqassemblystringLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_buffer_make(size : Int) -> BioseqassemblystringBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_buffer_len(s : BioseqassemblystringBuffer) -> Int { s.size }

pub fn bio_seq_assembly_string_buffer_get(s : BioseqassemblystringBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_buffer_set(s : BioseqassemblystringBuffer, i : Int, v : Double) -> BioseqassemblystringBuffer {
  let result = bio_seq_assembly_string_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_buffer_sum(s : BioseqassemblystringBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_string_buffer_mean(s : BioseqassemblystringBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_string_buffer_scale(s : BioseqassemblystringBuffer, f : Double) -> BioseqassemblystringBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_buffer_add(a : BioseqassemblystringBuffer, b : BioseqassemblystringBuffer) -> BioseqassemblystringBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_string_buffer_copy(s : BioseqassemblystringBuffer) -> BioseqassemblystringBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_buffer_fill(s : BioseqassemblystringBuffer, v : Double) -> BioseqassemblystringBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_buffer_min(s : BioseqassemblystringBuffer) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_string_buffer_max(s : BioseqassemblystringBuffer) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_string_buffer_to_string(s : BioseqassemblystringBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_cursor_make(size : Int) -> BioseqassemblystringCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_cursor_len(s : BioseqassemblystringCursor) -> Int { s.size }

pub fn bio_seq_assembly_string_cursor_get(s : BioseqassemblystringCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_cursor_set(s : BioseqassemblystringCursor, i : Int, v : Double) -> BioseqassemblystringCursor {
  let result = bio_seq_assembly_string_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_cursor_sum(s : BioseqassemblystringCursor) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_string_cursor_mean(s : BioseqassemblystringCursor) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_string_cursor_scale(s : BioseqassemblystringCursor, f : Double) -> BioseqassemblystringCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_cursor_add(a : BioseqassemblystringCursor, b : BioseqassemblystringCursor) -> BioseqassemblystringCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_string_cursor_copy(s : BioseqassemblystringCursor) -> BioseqassemblystringCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_cursor_fill(s : BioseqassemblystringCursor, v : Double) -> BioseqassemblystringCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_cursor_min(s : BioseqassemblystringCursor) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_string_cursor_max(s : BioseqassemblystringCursor) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_string_cursor_to_string(s : BioseqassemblystringCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_view_make(size : Int) -> BioseqassemblystringView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_view_len(s : BioseqassemblystringView) -> Int { s.size }

pub fn bio_seq_assembly_string_view_get(s : BioseqassemblystringView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_view_set(s : BioseqassemblystringView, i : Int, v : Double) -> BioseqassemblystringView {
  let result = bio_seq_assembly_string_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_view_sum(s : BioseqassemblystringView) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_string_view_mean(s : BioseqassemblystringView) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_string_view_scale(s : BioseqassemblystringView, f : Double) -> BioseqassemblystringView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_view_add(a : BioseqassemblystringView, b : BioseqassemblystringView) -> BioseqassemblystringView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_string_view_copy(s : BioseqassemblystringView) -> BioseqassemblystringView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_view_fill(s : BioseqassemblystringView, v : Double) -> BioseqassemblystringView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_view_min(s : BioseqassemblystringView) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_string_view_max(s : BioseqassemblystringView) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_string_view_to_string(s : BioseqassemblystringView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_range_make(size : Int) -> BioseqassemblystringRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_range_len(s : BioseqassemblystringRange) -> Int { s.size }

pub fn bio_seq_assembly_string_range_get(s : BioseqassemblystringRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_range_set(s : BioseqassemblystringRange, i : Int, v : Double) -> BioseqassemblystringRange {
  let result = bio_seq_assembly_string_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_range_sum(s : BioseqassemblystringRange) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_string_range_mean(s : BioseqassemblystringRange) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_string_range_scale(s : BioseqassemblystringRange, f : Double) -> BioseqassemblystringRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_range_add(a : BioseqassemblystringRange, b : BioseqassemblystringRange) -> BioseqassemblystringRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_string_range_copy(s : BioseqassemblystringRange) -> BioseqassemblystringRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_range_fill(s : BioseqassemblystringRange, v : Double) -> BioseqassemblystringRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_range_min(s : BioseqassemblystringRange) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_string_range_max(s : BioseqassemblystringRange) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_string_range_to_string(s : BioseqassemblystringRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_slice_make(size : Int) -> BioseqassemblystringSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_slice_len(s : BioseqassemblystringSlice) -> Int { s.size }

pub fn bio_seq_assembly_string_slice_get(s : BioseqassemblystringSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_slice_set(s : BioseqassemblystringSlice, i : Int, v : Double) -> BioseqassemblystringSlice {
  let result = bio_seq_assembly_string_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_slice_sum(s : BioseqassemblystringSlice) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_string_slice_mean(s : BioseqassemblystringSlice) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_string_slice_scale(s : BioseqassemblystringSlice, f : Double) -> BioseqassemblystringSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_slice_add(a : BioseqassemblystringSlice, b : BioseqassemblystringSlice) -> BioseqassemblystringSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_string_slice_copy(s : BioseqassemblystringSlice) -> BioseqassemblystringSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_slice_fill(s : BioseqassemblystringSlice, v : Double) -> BioseqassemblystringSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_string_slice_min(s : BioseqassemblystringSlice) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_string_slice_max(s : BioseqassemblystringSlice) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_string_slice_to_string(s : BioseqassemblystringSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

