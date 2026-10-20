///===
/// extcore/bio_seq_assembly_validate

pub(all) struct BioseqassemblyvalidatePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_validate_make_point(x : Double, y : Double) -> BioseqassemblyvalidatePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_validate_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblyvalidatePoint {
  { x, y, z, label: 0 }
}

pub fn bio_seq_assembly_validate_point_x(pt : BioseqassemblyvalidatePoint) -> Double { pt.x }

pub fn bio_seq_assembly_validate_point_y(pt : BioseqassemblyvalidatePoint) -> Double { pt.y }

pub fn bio_seq_assembly_validate_point_z(pt : BioseqassemblyvalidatePoint) -> Double { pt.z }

pub fn bio_seq_assembly_validate_point_label(pt : BioseqassemblyvalidatePoint) -> Int { pt.label }

pub fn bio_seq_assembly_validate_point_dist(a : BioseqassemblyvalidatePoint, b : BioseqassemblyvalidatePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_seq_assembly_validate_point_add(a : BioseqassemblyvalidatePoint, b : BioseqassemblyvalidatePoint) -> BioseqassemblyvalidatePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_seq_assembly_validate_point_sub(a : BioseqassemblyvalidatePoint, b : BioseqassemblyvalidatePoint) -> BioseqassemblyvalidatePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_seq_assembly_validate_point_scale(pt : BioseqassemblyvalidatePoint, s : Double) -> BioseqassemblyvalidatePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_seq_assembly_validate_point_dot(a : BioseqassemblyvalidatePoint, b : BioseqassemblyvalidatePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_seq_assembly_validate_point_cross(a : BioseqassemblyvalidatePoint, b : BioseqassemblyvalidatePoint) -> BioseqassemblyvalidatePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_seq_assembly_validate_point_norm(pt : BioseqassemblyvalidatePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_seq_assembly_validate_point_normalize(pt : BioseqassemblyvalidatePoint) -> BioseqassemblyvalidatePoint {
  let n = bio_seq_assembly_validate_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_seq_assembly_validate_point_scale(pt, 1.0 / n) }
}

pub fn bio_seq_assembly_validate_point_negate(pt : BioseqassemblyvalidatePoint) -> BioseqassemblyvalidatePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_seq_assembly_validate_point_mid(a : BioseqassemblyvalidatePoint, b : BioseqassemblyvalidatePoint) -> BioseqassemblyvalidatePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_seq_assembly_validate_point_lerp(a : BioseqassemblyvalidatePoint, b : BioseqassemblyvalidatePoint, t : Double) -> BioseqassemblyvalidatePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_seq_assembly_validate_point_to_string(pt : BioseqassemblyvalidatePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_validate_make_series(vals : Array[Double], name : String) -> BioseqassemblyvalidateSeries {
  { vals, name, meta: 0 }
}

pub fn bio_seq_assembly_validate_series_len(s : BioseqassemblyvalidateSeries) -> Int { s.vals.length() }

pub fn bio_seq_assembly_validate_series_sum(s : BioseqassemblyvalidateSeries) -> Double { @_common.sum(s.vals) }

pub fn bio_seq_assembly_validate_series_mean(s : BioseqassemblyvalidateSeries) -> Double { @_common.mean(s.vals) }

pub fn bio_seq_assembly_validate_series_min(s : BioseqassemblyvalidateSeries) -> Double { @_common.min(s.vals) }

pub fn bio_seq_assembly_validate_series_max(s : BioseqassemblyvalidateSeries) -> Double { @_common.max(s.vals) }

pub fn bio_seq_assembly_validate_series_range(s : BioseqassemblyvalidateSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn bio_seq_assembly_validate_series_var(s : BioseqassemblyvalidateSeries) -> Double { @_common.variance(s.vals) }

pub fn bio_seq_assembly_validate_series_std(s : BioseqassemblyvalidateSeries) -> Double { @_common.std(s.vals) }

pub fn bio_seq_assembly_validate_series_median(s : BioseqassemblyvalidateSeries) -> Double { @_common.median(s.vals) }

pub fn bio_seq_assembly_validate_series_scale(s : BioseqassemblyvalidateSeries, f : Double) -> BioseqassemblyvalidateSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn bio_seq_assembly_validate_series_add(a : BioseqassemblyvalidateSeries, b : BioseqassemblyvalidateSeries) -> BioseqassemblyvalidateSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_seq_assembly_validate_series_sub(a : BioseqassemblyvalidateSeries, b : BioseqassemblyvalidateSeries) -> BioseqassemblyvalidateSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_seq_assembly_validate_series_normalize(s : BioseqassemblyvalidateSeries) -> BioseqassemblyvalidateSeries {
  let mn = bio_seq_assembly_validate_series_min(s)
  let mx = bio_seq_assembly_validate_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_seq_assembly_validate_series_cumsum(s : BioseqassemblyvalidateSeries) -> BioseqassemblyvalidateSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_seq_assembly_validate_series_to_string(s : BioseqassemblyvalidateSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblyvalidateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_validate_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblyvalidateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_validate_matrix_identity(n : Int) -> BioseqassemblyvalidateMatrix {
  let m = bio_seq_assembly_validate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_seq_assembly_validate_matrix_get(m : BioseqassemblyvalidateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_seq_assembly_validate_matrix_transpose(m : BioseqassemblyvalidateMatrix) -> BioseqassemblyvalidateMatrix {
  let result = bio_seq_assembly_validate_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_seq_assembly_validate_matrix_add(a : BioseqassemblyvalidateMatrix, b : BioseqassemblyvalidateMatrix) -> BioseqassemblyvalidateMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_seq_assembly_validate_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_seq_assembly_validate_matrix_scale(m : BioseqassemblyvalidateMatrix, s : Double) -> BioseqassemblyvalidateMatrix {
  let result = bio_seq_assembly_validate_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_seq_assembly_validate_matrix_multiply(a : BioseqassemblyvalidateMatrix, b : BioseqassemblyvalidateMatrix) -> BioseqassemblyvalidateMatrix {
  if a.cols != b.rows { return bio_seq_assembly_validate_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_seq_assembly_validate_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_seq_assembly_validate_matrix_trace(m : BioseqassemblyvalidateMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_seq_assembly_validate_matrix_det(m : BioseqassemblyvalidateMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_seq_assembly_validate_matrix_norm(m : BioseqassemblyvalidateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_seq_assembly_validate_matrix_to_string(m : BioseqassemblyvalidateMatrix) -> String {
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

pub(all) struct BioseqassemblyvalidateVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_validate_make_vector(comps : Array[Double]) -> BioseqassemblyvalidateVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_validate_vector_zero(dim : Int) -> BioseqassemblyvalidateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_seq_assembly_validate_vector_add(a : BioseqassemblyvalidateVector, b : BioseqassemblyvalidateVector) -> BioseqassemblyvalidateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn bio_seq_assembly_validate_vector_sub(a : BioseqassemblyvalidateVector, b : BioseqassemblyvalidateVector) -> BioseqassemblyvalidateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn bio_seq_assembly_validate_vector_scale(v : BioseqassemblyvalidateVector, s : Double) -> BioseqassemblyvalidateVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn bio_seq_assembly_validate_vector_dot(a : BioseqassemblyvalidateVector, b : BioseqassemblyvalidateVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_seq_assembly_validate_vector_norm(v : BioseqassemblyvalidateVector) -> Double { @_common.sqrt(bio_seq_assembly_validate_vector_dot(v, v)) }

pub fn bio_seq_assembly_validate_vector_normalize(v : BioseqassemblyvalidateVector) -> BioseqassemblyvalidateVector {
  let n = bio_seq_assembly_validate_vector_norm(v)
  if n < 0.0000001 { v } else { bio_seq_assembly_validate_vector_scale(v, 1.0 / n) }
}

pub fn bio_seq_assembly_validate_vector_dist(a : BioseqassemblyvalidateVector, b : BioseqassemblyvalidateVector) -> Double {
  bio_seq_assembly_validate_vector_norm(bio_seq_assembly_validate_vector_sub(a, b))
}

pub fn bio_seq_assembly_validate_vector_to_string(v : BioseqassemblyvalidateVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_assembly_validate_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_assembly_validate_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_assembly_validate_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_assembly_validate_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_assembly_validate_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_assembly_validate_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_assembly_validate_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_assembly_validate_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_assembly_validate_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_assembly_validate_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_assembly_validate_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_assembly_validate_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_assembly_validate_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_assembly_validate_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_assembly_validate_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_assembly_validate_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_assembly_validate_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_assembly_validate_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_assembly_validate_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_assembly_validate_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_assembly_validate_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_assembly_validate_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_assembly_validate_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_assembly_validate_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_assembly_validate_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_assembly_validate_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_assembly_validate_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_assembly_validate_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_assembly_validate_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqassemblyvalidateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_frame_make(size : Int) -> BioseqassemblyvalidateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_validate_frame_len(s : BioseqassemblyvalidateFrame) -> Int { s.size }

pub fn bio_seq_assembly_validate_frame_get(s : BioseqassemblyvalidateFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_validate_frame_set(s : BioseqassemblyvalidateFrame, i : Int, v : Double) -> BioseqassemblyvalidateFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_frame_sum(s : BioseqassemblyvalidateFrame) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_validate_frame_mean(s : BioseqassemblyvalidateFrame) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_validate_frame_scale(s : BioseqassemblyvalidateFrame, f : Double) -> BioseqassemblyvalidateFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_frame_add(a : BioseqassemblyvalidateFrame, b : BioseqassemblyvalidateFrame) -> BioseqassemblyvalidateFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_validate_frame_copy(s : BioseqassemblyvalidateFrame) -> BioseqassemblyvalidateFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_frame_fill(s : BioseqassemblyvalidateFrame, v : Double) -> BioseqassemblyvalidateFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_frame_min(s : BioseqassemblyvalidateFrame) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_validate_frame_max(s : BioseqassemblyvalidateFrame) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_validate_frame_to_string(s : BioseqassemblyvalidateFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_table_make(size : Int) -> BioseqassemblyvalidateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_validate_table_len(s : BioseqassemblyvalidateTable) -> Int { s.size }

pub fn bio_seq_assembly_validate_table_get(s : BioseqassemblyvalidateTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_validate_table_set(s : BioseqassemblyvalidateTable, i : Int, v : Double) -> BioseqassemblyvalidateTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_table_sum(s : BioseqassemblyvalidateTable) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_validate_table_mean(s : BioseqassemblyvalidateTable) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_validate_table_scale(s : BioseqassemblyvalidateTable, f : Double) -> BioseqassemblyvalidateTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_table_add(a : BioseqassemblyvalidateTable, b : BioseqassemblyvalidateTable) -> BioseqassemblyvalidateTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_validate_table_copy(s : BioseqassemblyvalidateTable) -> BioseqassemblyvalidateTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_table_fill(s : BioseqassemblyvalidateTable, v : Double) -> BioseqassemblyvalidateTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_table_min(s : BioseqassemblyvalidateTable) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_validate_table_max(s : BioseqassemblyvalidateTable) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_validate_table_to_string(s : BioseqassemblyvalidateTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_graphn_make(size : Int) -> BioseqassemblyvalidateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_validate_graphn_len(s : BioseqassemblyvalidateGraphN) -> Int { s.size }

pub fn bio_seq_assembly_validate_graphn_get(s : BioseqassemblyvalidateGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_validate_graphn_set(s : BioseqassemblyvalidateGraphN, i : Int, v : Double) -> BioseqassemblyvalidateGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_graphn_sum(s : BioseqassemblyvalidateGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_validate_graphn_mean(s : BioseqassemblyvalidateGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_validate_graphn_scale(s : BioseqassemblyvalidateGraphN, f : Double) -> BioseqassemblyvalidateGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_graphn_add(a : BioseqassemblyvalidateGraphN, b : BioseqassemblyvalidateGraphN) -> BioseqassemblyvalidateGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_validate_graphn_copy(s : BioseqassemblyvalidateGraphN) -> BioseqassemblyvalidateGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_graphn_fill(s : BioseqassemblyvalidateGraphN, v : Double) -> BioseqassemblyvalidateGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_graphn_min(s : BioseqassemblyvalidateGraphN) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_validate_graphn_max(s : BioseqassemblyvalidateGraphN) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_validate_graphn_to_string(s : BioseqassemblyvalidateGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_node_make(size : Int) -> BioseqassemblyvalidateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_validate_node_len(s : BioseqassemblyvalidateNode) -> Int { s.size }

pub fn bio_seq_assembly_validate_node_get(s : BioseqassemblyvalidateNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_validate_node_set(s : BioseqassemblyvalidateNode, i : Int, v : Double) -> BioseqassemblyvalidateNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_node_sum(s : BioseqassemblyvalidateNode) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_validate_node_mean(s : BioseqassemblyvalidateNode) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_validate_node_scale(s : BioseqassemblyvalidateNode, f : Double) -> BioseqassemblyvalidateNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_node_add(a : BioseqassemblyvalidateNode, b : BioseqassemblyvalidateNode) -> BioseqassemblyvalidateNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_validate_node_copy(s : BioseqassemblyvalidateNode) -> BioseqassemblyvalidateNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_node_fill(s : BioseqassemblyvalidateNode, v : Double) -> BioseqassemblyvalidateNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_node_min(s : BioseqassemblyvalidateNode) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_validate_node_max(s : BioseqassemblyvalidateNode) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_validate_node_to_string(s : BioseqassemblyvalidateNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_edge_make(size : Int) -> BioseqassemblyvalidateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_validate_edge_len(s : BioseqassemblyvalidateEdge) -> Int { s.size }

pub fn bio_seq_assembly_validate_edge_get(s : BioseqassemblyvalidateEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_validate_edge_set(s : BioseqassemblyvalidateEdge, i : Int, v : Double) -> BioseqassemblyvalidateEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_edge_sum(s : BioseqassemblyvalidateEdge) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_validate_edge_mean(s : BioseqassemblyvalidateEdge) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_validate_edge_scale(s : BioseqassemblyvalidateEdge, f : Double) -> BioseqassemblyvalidateEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_edge_add(a : BioseqassemblyvalidateEdge, b : BioseqassemblyvalidateEdge) -> BioseqassemblyvalidateEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_validate_edge_copy(s : BioseqassemblyvalidateEdge) -> BioseqassemblyvalidateEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_edge_fill(s : BioseqassemblyvalidateEdge, v : Double) -> BioseqassemblyvalidateEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_edge_min(s : BioseqassemblyvalidateEdge) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_validate_edge_max(s : BioseqassemblyvalidateEdge) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_validate_edge_to_string(s : BioseqassemblyvalidateEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidatePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_path_make(size : Int) -> BioseqassemblyvalidatePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_validate_path_len(s : BioseqassemblyvalidatePath) -> Int { s.size }

pub fn bio_seq_assembly_validate_path_get(s : BioseqassemblyvalidatePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_validate_path_set(s : BioseqassemblyvalidatePath, i : Int, v : Double) -> BioseqassemblyvalidatePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_path_sum(s : BioseqassemblyvalidatePath) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_validate_path_mean(s : BioseqassemblyvalidatePath) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_validate_path_scale(s : BioseqassemblyvalidatePath, f : Double) -> BioseqassemblyvalidatePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_path_add(a : BioseqassemblyvalidatePath, b : BioseqassemblyvalidatePath) -> BioseqassemblyvalidatePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_validate_path_copy(s : BioseqassemblyvalidatePath) -> BioseqassemblyvalidatePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_path_fill(s : BioseqassemblyvalidatePath, v : Double) -> BioseqassemblyvalidatePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_path_min(s : BioseqassemblyvalidatePath) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_validate_path_max(s : BioseqassemblyvalidatePath) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_validate_path_to_string(s : BioseqassemblyvalidatePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_cluster_make(size : Int) -> BioseqassemblyvalidateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_validate_cluster_len(s : BioseqassemblyvalidateCluster) -> Int { s.size }

pub fn bio_seq_assembly_validate_cluster_get(s : BioseqassemblyvalidateCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_validate_cluster_set(s : BioseqassemblyvalidateCluster, i : Int, v : Double) -> BioseqassemblyvalidateCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_cluster_sum(s : BioseqassemblyvalidateCluster) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_validate_cluster_mean(s : BioseqassemblyvalidateCluster) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_validate_cluster_scale(s : BioseqassemblyvalidateCluster, f : Double) -> BioseqassemblyvalidateCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_cluster_add(a : BioseqassemblyvalidateCluster, b : BioseqassemblyvalidateCluster) -> BioseqassemblyvalidateCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_validate_cluster_copy(s : BioseqassemblyvalidateCluster) -> BioseqassemblyvalidateCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_cluster_fill(s : BioseqassemblyvalidateCluster, v : Double) -> BioseqassemblyvalidateCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_cluster_min(s : BioseqassemblyvalidateCluster) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_validate_cluster_max(s : BioseqassemblyvalidateCluster) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_validate_cluster_to_string(s : BioseqassemblyvalidateCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_model_make(size : Int) -> BioseqassemblyvalidateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_validate_model_len(s : BioseqassemblyvalidateModel) -> Int { s.size }

pub fn bio_seq_assembly_validate_model_get(s : BioseqassemblyvalidateModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_validate_model_set(s : BioseqassemblyvalidateModel, i : Int, v : Double) -> BioseqassemblyvalidateModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_model_sum(s : BioseqassemblyvalidateModel) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_validate_model_mean(s : BioseqassemblyvalidateModel) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_validate_model_scale(s : BioseqassemblyvalidateModel, f : Double) -> BioseqassemblyvalidateModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_model_add(a : BioseqassemblyvalidateModel, b : BioseqassemblyvalidateModel) -> BioseqassemblyvalidateModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_validate_model_copy(s : BioseqassemblyvalidateModel) -> BioseqassemblyvalidateModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_model_fill(s : BioseqassemblyvalidateModel, v : Double) -> BioseqassemblyvalidateModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_model_min(s : BioseqassemblyvalidateModel) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_validate_model_max(s : BioseqassemblyvalidateModel) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_validate_model_to_string(s : BioseqassemblyvalidateModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_layer_make(size : Int) -> BioseqassemblyvalidateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_validate_layer_len(s : BioseqassemblyvalidateLayer) -> Int { s.size }

pub fn bio_seq_assembly_validate_layer_get(s : BioseqassemblyvalidateLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_validate_layer_set(s : BioseqassemblyvalidateLayer, i : Int, v : Double) -> BioseqassemblyvalidateLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_layer_sum(s : BioseqassemblyvalidateLayer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_validate_layer_mean(s : BioseqassemblyvalidateLayer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_validate_layer_scale(s : BioseqassemblyvalidateLayer, f : Double) -> BioseqassemblyvalidateLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_layer_add(a : BioseqassemblyvalidateLayer, b : BioseqassemblyvalidateLayer) -> BioseqassemblyvalidateLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_validate_layer_copy(s : BioseqassemblyvalidateLayer) -> BioseqassemblyvalidateLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_layer_fill(s : BioseqassemblyvalidateLayer, v : Double) -> BioseqassemblyvalidateLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_layer_min(s : BioseqassemblyvalidateLayer) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_validate_layer_max(s : BioseqassemblyvalidateLayer) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_validate_layer_to_string(s : BioseqassemblyvalidateLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_buffer_make(size : Int) -> BioseqassemblyvalidateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_validate_buffer_len(s : BioseqassemblyvalidateBuffer) -> Int { s.size }

pub fn bio_seq_assembly_validate_buffer_get(s : BioseqassemblyvalidateBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_validate_buffer_set(s : BioseqassemblyvalidateBuffer, i : Int, v : Double) -> BioseqassemblyvalidateBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_buffer_sum(s : BioseqassemblyvalidateBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_validate_buffer_mean(s : BioseqassemblyvalidateBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_validate_buffer_scale(s : BioseqassemblyvalidateBuffer, f : Double) -> BioseqassemblyvalidateBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_buffer_add(a : BioseqassemblyvalidateBuffer, b : BioseqassemblyvalidateBuffer) -> BioseqassemblyvalidateBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_validate_buffer_copy(s : BioseqassemblyvalidateBuffer) -> BioseqassemblyvalidateBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_buffer_fill(s : BioseqassemblyvalidateBuffer, v : Double) -> BioseqassemblyvalidateBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_buffer_min(s : BioseqassemblyvalidateBuffer) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_validate_buffer_max(s : BioseqassemblyvalidateBuffer) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_validate_buffer_to_string(s : BioseqassemblyvalidateBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_cursor_make(size : Int) -> BioseqassemblyvalidateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_validate_cursor_len(s : BioseqassemblyvalidateCursor) -> Int { s.size }

pub fn bio_seq_assembly_validate_cursor_get(s : BioseqassemblyvalidateCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_validate_cursor_set(s : BioseqassemblyvalidateCursor, i : Int, v : Double) -> BioseqassemblyvalidateCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_cursor_sum(s : BioseqassemblyvalidateCursor) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_validate_cursor_mean(s : BioseqassemblyvalidateCursor) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_validate_cursor_scale(s : BioseqassemblyvalidateCursor, f : Double) -> BioseqassemblyvalidateCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_cursor_add(a : BioseqassemblyvalidateCursor, b : BioseqassemblyvalidateCursor) -> BioseqassemblyvalidateCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_validate_cursor_copy(s : BioseqassemblyvalidateCursor) -> BioseqassemblyvalidateCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_cursor_fill(s : BioseqassemblyvalidateCursor, v : Double) -> BioseqassemblyvalidateCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_cursor_min(s : BioseqassemblyvalidateCursor) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_validate_cursor_max(s : BioseqassemblyvalidateCursor) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_validate_cursor_to_string(s : BioseqassemblyvalidateCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_view_make(size : Int) -> BioseqassemblyvalidateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_validate_view_len(s : BioseqassemblyvalidateView) -> Int { s.size }

pub fn bio_seq_assembly_validate_view_get(s : BioseqassemblyvalidateView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_validate_view_set(s : BioseqassemblyvalidateView, i : Int, v : Double) -> BioseqassemblyvalidateView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_view_sum(s : BioseqassemblyvalidateView) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_validate_view_mean(s : BioseqassemblyvalidateView) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_validate_view_scale(s : BioseqassemblyvalidateView, f : Double) -> BioseqassemblyvalidateView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_view_add(a : BioseqassemblyvalidateView, b : BioseqassemblyvalidateView) -> BioseqassemblyvalidateView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_validate_view_copy(s : BioseqassemblyvalidateView) -> BioseqassemblyvalidateView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_view_fill(s : BioseqassemblyvalidateView, v : Double) -> BioseqassemblyvalidateView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_view_min(s : BioseqassemblyvalidateView) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_validate_view_max(s : BioseqassemblyvalidateView) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_validate_view_to_string(s : BioseqassemblyvalidateView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_range_make(size : Int) -> BioseqassemblyvalidateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_validate_range_len(s : BioseqassemblyvalidateRange) -> Int { s.size }

pub fn bio_seq_assembly_validate_range_get(s : BioseqassemblyvalidateRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_validate_range_set(s : BioseqassemblyvalidateRange, i : Int, v : Double) -> BioseqassemblyvalidateRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_range_sum(s : BioseqassemblyvalidateRange) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_validate_range_mean(s : BioseqassemblyvalidateRange) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_validate_range_scale(s : BioseqassemblyvalidateRange, f : Double) -> BioseqassemblyvalidateRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_range_add(a : BioseqassemblyvalidateRange, b : BioseqassemblyvalidateRange) -> BioseqassemblyvalidateRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_validate_range_copy(s : BioseqassemblyvalidateRange) -> BioseqassemblyvalidateRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_range_fill(s : BioseqassemblyvalidateRange, v : Double) -> BioseqassemblyvalidateRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_range_min(s : BioseqassemblyvalidateRange) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_validate_range_max(s : BioseqassemblyvalidateRange) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_validate_range_to_string(s : BioseqassemblyvalidateRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyvalidateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_validate_slice_make(size : Int) -> BioseqassemblyvalidateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_validate_slice_len(s : BioseqassemblyvalidateSlice) -> Int { s.size }

pub fn bio_seq_assembly_validate_slice_get(s : BioseqassemblyvalidateSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_validate_slice_set(s : BioseqassemblyvalidateSlice, i : Int, v : Double) -> BioseqassemblyvalidateSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_slice_sum(s : BioseqassemblyvalidateSlice) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_validate_slice_mean(s : BioseqassemblyvalidateSlice) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_validate_slice_scale(s : BioseqassemblyvalidateSlice, f : Double) -> BioseqassemblyvalidateSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_slice_add(a : BioseqassemblyvalidateSlice, b : BioseqassemblyvalidateSlice) -> BioseqassemblyvalidateSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_validate_slice_copy(s : BioseqassemblyvalidateSlice) -> BioseqassemblyvalidateSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_slice_fill(s : BioseqassemblyvalidateSlice, v : Double) -> BioseqassemblyvalidateSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_validate_slice_min(s : BioseqassemblyvalidateSlice) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_validate_slice_max(s : BioseqassemblyvalidateSlice) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_validate_slice_to_string(s : BioseqassemblyvalidateSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

