///===
/// extcore/bio_seq_assembly_gap

pub(all) struct BioseqassemblygapPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_gap_make_point(x : Double, y : Double) -> BioseqassemblygapPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_gap_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblygapPoint {
  { x, y, z, label: 0 }
}

pub fn bio_seq_assembly_gap_point_x(pt : BioseqassemblygapPoint) -> Double { pt.x }

pub fn bio_seq_assembly_gap_point_y(pt : BioseqassemblygapPoint) -> Double { pt.y }

pub fn bio_seq_assembly_gap_point_z(pt : BioseqassemblygapPoint) -> Double { pt.z }

pub fn bio_seq_assembly_gap_point_label(pt : BioseqassemblygapPoint) -> Int { pt.label }

pub fn bio_seq_assembly_gap_point_dist(a : BioseqassemblygapPoint, b : BioseqassemblygapPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_seq_assembly_gap_point_add(a : BioseqassemblygapPoint, b : BioseqassemblygapPoint) -> BioseqassemblygapPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_seq_assembly_gap_point_sub(a : BioseqassemblygapPoint, b : BioseqassemblygapPoint) -> BioseqassemblygapPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_seq_assembly_gap_point_scale(pt : BioseqassemblygapPoint, s : Double) -> BioseqassemblygapPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_seq_assembly_gap_point_dot(a : BioseqassemblygapPoint, b : BioseqassemblygapPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_seq_assembly_gap_point_cross(a : BioseqassemblygapPoint, b : BioseqassemblygapPoint) -> BioseqassemblygapPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_seq_assembly_gap_point_norm(pt : BioseqassemblygapPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_seq_assembly_gap_point_normalize(pt : BioseqassemblygapPoint) -> BioseqassemblygapPoint {
  let n = bio_seq_assembly_gap_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_seq_assembly_gap_point_scale(pt, 1.0 / n) }
}

pub fn bio_seq_assembly_gap_point_negate(pt : BioseqassemblygapPoint) -> BioseqassemblygapPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_seq_assembly_gap_point_mid(a : BioseqassemblygapPoint, b : BioseqassemblygapPoint) -> BioseqassemblygapPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_seq_assembly_gap_point_lerp(a : BioseqassemblygapPoint, b : BioseqassemblygapPoint, t : Double) -> BioseqassemblygapPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_seq_assembly_gap_point_to_string(pt : BioseqassemblygapPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BioseqassemblygapSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_gap_make_series(vals : Array[Double], name : String) -> BioseqassemblygapSeries {
  { vals, name, meta: 0 }
}

pub fn bio_seq_assembly_gap_series_len(s : BioseqassemblygapSeries) -> Int { s.vals.length() }

pub fn bio_seq_assembly_gap_series_sum(s : BioseqassemblygapSeries) -> Double { @_common.sum(s.vals) }

pub fn bio_seq_assembly_gap_series_mean(s : BioseqassemblygapSeries) -> Double { @_common.mean(s.vals) }

pub fn bio_seq_assembly_gap_series_min(s : BioseqassemblygapSeries) -> Double { @_common.min(s.vals) }

pub fn bio_seq_assembly_gap_series_max(s : BioseqassemblygapSeries) -> Double { @_common.max(s.vals) }

pub fn bio_seq_assembly_gap_series_range(s : BioseqassemblygapSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn bio_seq_assembly_gap_series_var(s : BioseqassemblygapSeries) -> Double { @_common.variance(s.vals) }

pub fn bio_seq_assembly_gap_series_std(s : BioseqassemblygapSeries) -> Double { @_common.std(s.vals) }

pub fn bio_seq_assembly_gap_series_median(s : BioseqassemblygapSeries) -> Double { @_common.median(s.vals) }

pub fn bio_seq_assembly_gap_series_scale(s : BioseqassemblygapSeries, f : Double) -> BioseqassemblygapSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_seq_assembly_gap_series_add(a : BioseqassemblygapSeries, b : BioseqassemblygapSeries) -> BioseqassemblygapSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_seq_assembly_gap_series_sub(a : BioseqassemblygapSeries, b : BioseqassemblygapSeries) -> BioseqassemblygapSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_seq_assembly_gap_series_normalize(s : BioseqassemblygapSeries) -> BioseqassemblygapSeries {
  let mn = bio_seq_assembly_gap_series_min(s)
  let mx = bio_seq_assembly_gap_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_seq_assembly_gap_series_cumsum(s : BioseqassemblygapSeries) -> BioseqassemblygapSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_seq_assembly_gap_series_to_string(s : BioseqassemblygapSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblygapMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_gap_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblygapMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_gap_matrix_identity(n : Int) -> BioseqassemblygapMatrix {
  let m = bio_seq_assembly_gap_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_seq_assembly_gap_matrix_get(m : BioseqassemblygapMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_seq_assembly_gap_matrix_transpose(m : BioseqassemblygapMatrix) -> BioseqassemblygapMatrix {
  let result = bio_seq_assembly_gap_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_seq_assembly_gap_matrix_add(a : BioseqassemblygapMatrix, b : BioseqassemblygapMatrix) -> BioseqassemblygapMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_seq_assembly_gap_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_seq_assembly_gap_matrix_scale(m : BioseqassemblygapMatrix, s : Double) -> BioseqassemblygapMatrix {
  let result = bio_seq_assembly_gap_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_seq_assembly_gap_matrix_multiply(a : BioseqassemblygapMatrix, b : BioseqassemblygapMatrix) -> BioseqassemblygapMatrix {
  if a.cols != b.rows { return bio_seq_assembly_gap_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_seq_assembly_gap_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_seq_assembly_gap_matrix_trace(m : BioseqassemblygapMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_seq_assembly_gap_matrix_det(m : BioseqassemblygapMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_seq_assembly_gap_matrix_norm(m : BioseqassemblygapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_seq_assembly_gap_matrix_to_string(m : BioseqassemblygapMatrix) -> String {
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

pub(all) struct BioseqassemblygapVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_gap_make_vector(comps : Array[Double]) -> BioseqassemblygapVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_gap_vector_zero(dim : Int) -> BioseqassemblygapVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_seq_assembly_gap_vector_add(a : BioseqassemblygapVector, b : BioseqassemblygapVector) -> BioseqassemblygapVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_assembly_gap_vector_sub(a : BioseqassemblygapVector, b : BioseqassemblygapVector) -> BioseqassemblygapVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_assembly_gap_vector_scale(v : BioseqassemblygapVector, s : Double) -> BioseqassemblygapVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_seq_assembly_gap_vector_dot(a : BioseqassemblygapVector, b : BioseqassemblygapVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_seq_assembly_gap_vector_norm(v : BioseqassemblygapVector) -> Double { @_common.sqrt(bio_seq_assembly_gap_vector_dot(v, v)) }

pub fn bio_seq_assembly_gap_vector_normalize(v : BioseqassemblygapVector) -> BioseqassemblygapVector {
  let n = bio_seq_assembly_gap_vector_norm(v)
  if n < 0.0000001 { v } else { bio_seq_assembly_gap_vector_scale(v, 1.0 / n) }
}

pub fn bio_seq_assembly_gap_vector_dist(a : BioseqassemblygapVector, b : BioseqassemblygapVector) -> Double {
  bio_seq_assembly_gap_vector_norm(bio_seq_assembly_gap_vector_sub(a, b))
}

pub fn bio_seq_assembly_gap_vector_to_string(v : BioseqassemblygapVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_assembly_gap_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_assembly_gap_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_assembly_gap_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_assembly_gap_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_assembly_gap_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_assembly_gap_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_assembly_gap_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_assembly_gap_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_assembly_gap_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_assembly_gap_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_assembly_gap_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_assembly_gap_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_assembly_gap_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_assembly_gap_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_assembly_gap_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_assembly_gap_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_assembly_gap_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_assembly_gap_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_assembly_gap_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_assembly_gap_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_assembly_gap_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_assembly_gap_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_assembly_gap_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_assembly_gap_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_assembly_gap_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_assembly_gap_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_assembly_gap_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_assembly_gap_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_assembly_gap_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqassemblygapFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_frame_make(size : Int) -> BioseqassemblygapFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_frame_len(s : BioseqassemblygapFrame) -> Int { s.size }

pub fn bio_seq_assembly_gap_frame_get(s : BioseqassemblygapFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_frame_set(s : BioseqassemblygapFrame, i : Int, v : Double) -> BioseqassemblygapFrame {
  let result = bio_seq_assembly_gap_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_frame_sum(s : BioseqassemblygapFrame) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_frame_mean(s : BioseqassemblygapFrame) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_frame_scale(s : BioseqassemblygapFrame, f : Double) -> BioseqassemblygapFrame {
  let result = bio_seq_assembly_gap_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_gap_frame_add(a : BioseqassemblygapFrame, b : BioseqassemblygapFrame) -> BioseqassemblygapFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_gap_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_gap_frame_copy(s : BioseqassemblygapFrame) -> BioseqassemblygapFrame {
  let result = bio_seq_assembly_gap_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_gap_frame_fill(s : BioseqassemblygapFrame, v : Double) -> BioseqassemblygapFrame {
  let result = bio_seq_assembly_gap_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_frame_min(s : BioseqassemblygapFrame) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_frame_max(s : BioseqassemblygapFrame) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_frame_to_string(s : BioseqassemblygapFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_table_make(size : Int) -> BioseqassemblygapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_table_len(s : BioseqassemblygapTable) -> Int { s.size }

pub fn bio_seq_assembly_gap_table_get(s : BioseqassemblygapTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_table_set(s : BioseqassemblygapTable, i : Int, v : Double) -> BioseqassemblygapTable {
  let result = bio_seq_assembly_gap_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_table_sum(s : BioseqassemblygapTable) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_table_mean(s : BioseqassemblygapTable) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_table_scale(s : BioseqassemblygapTable, f : Double) -> BioseqassemblygapTable {
  let result = bio_seq_assembly_gap_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_gap_table_add(a : BioseqassemblygapTable, b : BioseqassemblygapTable) -> BioseqassemblygapTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_gap_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_gap_table_copy(s : BioseqassemblygapTable) -> BioseqassemblygapTable {
  let result = bio_seq_assembly_gap_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_gap_table_fill(s : BioseqassemblygapTable, v : Double) -> BioseqassemblygapTable {
  let result = bio_seq_assembly_gap_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_table_min(s : BioseqassemblygapTable) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_table_max(s : BioseqassemblygapTable) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_table_to_string(s : BioseqassemblygapTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_graphn_make(size : Int) -> BioseqassemblygapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_graphn_len(s : BioseqassemblygapGraphN) -> Int { s.size }

pub fn bio_seq_assembly_gap_graphn_get(s : BioseqassemblygapGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_graphn_set(s : BioseqassemblygapGraphN, i : Int, v : Double) -> BioseqassemblygapGraphN {
  let result = bio_seq_assembly_gap_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_graphn_sum(s : BioseqassemblygapGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_graphn_mean(s : BioseqassemblygapGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_graphn_scale(s : BioseqassemblygapGraphN, f : Double) -> BioseqassemblygapGraphN {
  let result = bio_seq_assembly_gap_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_gap_graphn_add(a : BioseqassemblygapGraphN, b : BioseqassemblygapGraphN) -> BioseqassemblygapGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_gap_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_gap_graphn_copy(s : BioseqassemblygapGraphN) -> BioseqassemblygapGraphN {
  let result = bio_seq_assembly_gap_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_gap_graphn_fill(s : BioseqassemblygapGraphN, v : Double) -> BioseqassemblygapGraphN {
  let result = bio_seq_assembly_gap_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_graphn_min(s : BioseqassemblygapGraphN) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_graphn_max(s : BioseqassemblygapGraphN) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_graphn_to_string(s : BioseqassemblygapGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_node_make(size : Int) -> BioseqassemblygapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_node_len(s : BioseqassemblygapNode) -> Int { s.size }

pub fn bio_seq_assembly_gap_node_get(s : BioseqassemblygapNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_node_set(s : BioseqassemblygapNode, i : Int, v : Double) -> BioseqassemblygapNode {
  let result = bio_seq_assembly_gap_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_node_sum(s : BioseqassemblygapNode) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_node_mean(s : BioseqassemblygapNode) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_node_scale(s : BioseqassemblygapNode, f : Double) -> BioseqassemblygapNode {
  let result = bio_seq_assembly_gap_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_gap_node_add(a : BioseqassemblygapNode, b : BioseqassemblygapNode) -> BioseqassemblygapNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_gap_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_gap_node_copy(s : BioseqassemblygapNode) -> BioseqassemblygapNode {
  let result = bio_seq_assembly_gap_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_gap_node_fill(s : BioseqassemblygapNode, v : Double) -> BioseqassemblygapNode {
  let result = bio_seq_assembly_gap_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_node_min(s : BioseqassemblygapNode) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_node_max(s : BioseqassemblygapNode) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_node_to_string(s : BioseqassemblygapNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_edge_make(size : Int) -> BioseqassemblygapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_edge_len(s : BioseqassemblygapEdge) -> Int { s.size }

pub fn bio_seq_assembly_gap_edge_get(s : BioseqassemblygapEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_edge_set(s : BioseqassemblygapEdge, i : Int, v : Double) -> BioseqassemblygapEdge {
  let result = bio_seq_assembly_gap_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_edge_sum(s : BioseqassemblygapEdge) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_edge_mean(s : BioseqassemblygapEdge) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_edge_scale(s : BioseqassemblygapEdge, f : Double) -> BioseqassemblygapEdge {
  let result = bio_seq_assembly_gap_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_gap_edge_add(a : BioseqassemblygapEdge, b : BioseqassemblygapEdge) -> BioseqassemblygapEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_gap_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_gap_edge_copy(s : BioseqassemblygapEdge) -> BioseqassemblygapEdge {
  let result = bio_seq_assembly_gap_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_gap_edge_fill(s : BioseqassemblygapEdge, v : Double) -> BioseqassemblygapEdge {
  let result = bio_seq_assembly_gap_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_edge_min(s : BioseqassemblygapEdge) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_edge_max(s : BioseqassemblygapEdge) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_edge_to_string(s : BioseqassemblygapEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_path_make(size : Int) -> BioseqassemblygapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_path_len(s : BioseqassemblygapPath) -> Int { s.size }

pub fn bio_seq_assembly_gap_path_get(s : BioseqassemblygapPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_path_set(s : BioseqassemblygapPath, i : Int, v : Double) -> BioseqassemblygapPath {
  let result = bio_seq_assembly_gap_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_path_sum(s : BioseqassemblygapPath) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_path_mean(s : BioseqassemblygapPath) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_path_scale(s : BioseqassemblygapPath, f : Double) -> BioseqassemblygapPath {
  let result = bio_seq_assembly_gap_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_gap_path_add(a : BioseqassemblygapPath, b : BioseqassemblygapPath) -> BioseqassemblygapPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_gap_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_gap_path_copy(s : BioseqassemblygapPath) -> BioseqassemblygapPath {
  let result = bio_seq_assembly_gap_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_gap_path_fill(s : BioseqassemblygapPath, v : Double) -> BioseqassemblygapPath {
  let result = bio_seq_assembly_gap_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_path_min(s : BioseqassemblygapPath) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_path_max(s : BioseqassemblygapPath) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_path_to_string(s : BioseqassemblygapPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_cluster_make(size : Int) -> BioseqassemblygapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_cluster_len(s : BioseqassemblygapCluster) -> Int { s.size }

pub fn bio_seq_assembly_gap_cluster_get(s : BioseqassemblygapCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_cluster_set(s : BioseqassemblygapCluster, i : Int, v : Double) -> BioseqassemblygapCluster {
  let result = bio_seq_assembly_gap_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_cluster_sum(s : BioseqassemblygapCluster) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_cluster_mean(s : BioseqassemblygapCluster) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_cluster_scale(s : BioseqassemblygapCluster, f : Double) -> BioseqassemblygapCluster {
  let result = bio_seq_assembly_gap_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_gap_cluster_add(a : BioseqassemblygapCluster, b : BioseqassemblygapCluster) -> BioseqassemblygapCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_gap_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_gap_cluster_copy(s : BioseqassemblygapCluster) -> BioseqassemblygapCluster {
  let result = bio_seq_assembly_gap_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_gap_cluster_fill(s : BioseqassemblygapCluster, v : Double) -> BioseqassemblygapCluster {
  let result = bio_seq_assembly_gap_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_cluster_min(s : BioseqassemblygapCluster) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_cluster_max(s : BioseqassemblygapCluster) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_cluster_to_string(s : BioseqassemblygapCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_model_make(size : Int) -> BioseqassemblygapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_model_len(s : BioseqassemblygapModel) -> Int { s.size }

pub fn bio_seq_assembly_gap_model_get(s : BioseqassemblygapModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_model_set(s : BioseqassemblygapModel, i : Int, v : Double) -> BioseqassemblygapModel {
  let result = bio_seq_assembly_gap_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_model_sum(s : BioseqassemblygapModel) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_model_mean(s : BioseqassemblygapModel) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_model_scale(s : BioseqassemblygapModel, f : Double) -> BioseqassemblygapModel {
  let result = bio_seq_assembly_gap_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_gap_model_add(a : BioseqassemblygapModel, b : BioseqassemblygapModel) -> BioseqassemblygapModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_gap_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_gap_model_copy(s : BioseqassemblygapModel) -> BioseqassemblygapModel {
  let result = bio_seq_assembly_gap_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_gap_model_fill(s : BioseqassemblygapModel, v : Double) -> BioseqassemblygapModel {
  let result = bio_seq_assembly_gap_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_model_min(s : BioseqassemblygapModel) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_model_max(s : BioseqassemblygapModel) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_model_to_string(s : BioseqassemblygapModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_layer_make(size : Int) -> BioseqassemblygapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_layer_len(s : BioseqassemblygapLayer) -> Int { s.size }

pub fn bio_seq_assembly_gap_layer_get(s : BioseqassemblygapLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_layer_set(s : BioseqassemblygapLayer, i : Int, v : Double) -> BioseqassemblygapLayer {
  let result = bio_seq_assembly_gap_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_layer_sum(s : BioseqassemblygapLayer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_layer_mean(s : BioseqassemblygapLayer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_layer_scale(s : BioseqassemblygapLayer, f : Double) -> BioseqassemblygapLayer {
  let result = bio_seq_assembly_gap_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_gap_layer_add(a : BioseqassemblygapLayer, b : BioseqassemblygapLayer) -> BioseqassemblygapLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_gap_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_gap_layer_copy(s : BioseqassemblygapLayer) -> BioseqassemblygapLayer {
  let result = bio_seq_assembly_gap_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_gap_layer_fill(s : BioseqassemblygapLayer, v : Double) -> BioseqassemblygapLayer {
  let result = bio_seq_assembly_gap_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_layer_min(s : BioseqassemblygapLayer) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_layer_max(s : BioseqassemblygapLayer) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_layer_to_string(s : BioseqassemblygapLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_buffer_make(size : Int) -> BioseqassemblygapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_buffer_len(s : BioseqassemblygapBuffer) -> Int { s.size }

pub fn bio_seq_assembly_gap_buffer_get(s : BioseqassemblygapBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_buffer_set(s : BioseqassemblygapBuffer, i : Int, v : Double) -> BioseqassemblygapBuffer {
  let result = bio_seq_assembly_gap_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_buffer_sum(s : BioseqassemblygapBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_buffer_mean(s : BioseqassemblygapBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_buffer_scale(s : BioseqassemblygapBuffer, f : Double) -> BioseqassemblygapBuffer {
  let result = bio_seq_assembly_gap_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_gap_buffer_add(a : BioseqassemblygapBuffer, b : BioseqassemblygapBuffer) -> BioseqassemblygapBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_gap_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_gap_buffer_copy(s : BioseqassemblygapBuffer) -> BioseqassemblygapBuffer {
  let result = bio_seq_assembly_gap_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_gap_buffer_fill(s : BioseqassemblygapBuffer, v : Double) -> BioseqassemblygapBuffer {
  let result = bio_seq_assembly_gap_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_buffer_min(s : BioseqassemblygapBuffer) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_buffer_max(s : BioseqassemblygapBuffer) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_buffer_to_string(s : BioseqassemblygapBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_cursor_make(size : Int) -> BioseqassemblygapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_cursor_len(s : BioseqassemblygapCursor) -> Int { s.size }

pub fn bio_seq_assembly_gap_cursor_get(s : BioseqassemblygapCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_cursor_set(s : BioseqassemblygapCursor, i : Int, v : Double) -> BioseqassemblygapCursor {
  let result = bio_seq_assembly_gap_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_cursor_sum(s : BioseqassemblygapCursor) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_cursor_mean(s : BioseqassemblygapCursor) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_cursor_scale(s : BioseqassemblygapCursor, f : Double) -> BioseqassemblygapCursor {
  let result = bio_seq_assembly_gap_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_gap_cursor_add(a : BioseqassemblygapCursor, b : BioseqassemblygapCursor) -> BioseqassemblygapCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_gap_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_gap_cursor_copy(s : BioseqassemblygapCursor) -> BioseqassemblygapCursor {
  let result = bio_seq_assembly_gap_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_gap_cursor_fill(s : BioseqassemblygapCursor, v : Double) -> BioseqassemblygapCursor {
  let result = bio_seq_assembly_gap_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_cursor_min(s : BioseqassemblygapCursor) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_cursor_max(s : BioseqassemblygapCursor) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_cursor_to_string(s : BioseqassemblygapCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_view_make(size : Int) -> BioseqassemblygapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_view_len(s : BioseqassemblygapView) -> Int { s.size }

pub fn bio_seq_assembly_gap_view_get(s : BioseqassemblygapView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_view_set(s : BioseqassemblygapView, i : Int, v : Double) -> BioseqassemblygapView {
  let result = bio_seq_assembly_gap_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_view_sum(s : BioseqassemblygapView) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_view_mean(s : BioseqassemblygapView) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_view_scale(s : BioseqassemblygapView, f : Double) -> BioseqassemblygapView {
  let result = bio_seq_assembly_gap_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_gap_view_add(a : BioseqassemblygapView, b : BioseqassemblygapView) -> BioseqassemblygapView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_gap_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_gap_view_copy(s : BioseqassemblygapView) -> BioseqassemblygapView {
  let result = bio_seq_assembly_gap_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_gap_view_fill(s : BioseqassemblygapView, v : Double) -> BioseqassemblygapView {
  let result = bio_seq_assembly_gap_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_view_min(s : BioseqassemblygapView) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_view_max(s : BioseqassemblygapView) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_view_to_string(s : BioseqassemblygapView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_range_make(size : Int) -> BioseqassemblygapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_range_len(s : BioseqassemblygapRange) -> Int { s.size }

pub fn bio_seq_assembly_gap_range_get(s : BioseqassemblygapRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_range_set(s : BioseqassemblygapRange, i : Int, v : Double) -> BioseqassemblygapRange {
  let result = bio_seq_assembly_gap_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_range_sum(s : BioseqassemblygapRange) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_range_mean(s : BioseqassemblygapRange) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_range_scale(s : BioseqassemblygapRange, f : Double) -> BioseqassemblygapRange {
  let result = bio_seq_assembly_gap_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_gap_range_add(a : BioseqassemblygapRange, b : BioseqassemblygapRange) -> BioseqassemblygapRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_gap_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_gap_range_copy(s : BioseqassemblygapRange) -> BioseqassemblygapRange {
  let result = bio_seq_assembly_gap_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_gap_range_fill(s : BioseqassemblygapRange, v : Double) -> BioseqassemblygapRange {
  let result = bio_seq_assembly_gap_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_range_min(s : BioseqassemblygapRange) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_range_max(s : BioseqassemblygapRange) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_range_to_string(s : BioseqassemblygapRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_slice_make(size : Int) -> BioseqassemblygapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_slice_len(s : BioseqassemblygapSlice) -> Int { s.size }

pub fn bio_seq_assembly_gap_slice_get(s : BioseqassemblygapSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_slice_set(s : BioseqassemblygapSlice, i : Int, v : Double) -> BioseqassemblygapSlice {
  let result = bio_seq_assembly_gap_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_slice_sum(s : BioseqassemblygapSlice) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_slice_mean(s : BioseqassemblygapSlice) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_slice_scale(s : BioseqassemblygapSlice, f : Double) -> BioseqassemblygapSlice {
  let result = bio_seq_assembly_gap_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_gap_slice_add(a : BioseqassemblygapSlice, b : BioseqassemblygapSlice) -> BioseqassemblygapSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_gap_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_gap_slice_copy(s : BioseqassemblygapSlice) -> BioseqassemblygapSlice {
  let result = bio_seq_assembly_gap_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_gap_slice_fill(s : BioseqassemblygapSlice, v : Double) -> BioseqassemblygapSlice {
  let result = bio_seq_assembly_gap_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_gap_slice_min(s : BioseqassemblygapSlice) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_slice_max(s : BioseqassemblygapSlice) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_slice_to_string(s : BioseqassemblygapSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

