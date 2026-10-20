///===
/// extcore/bio_seq_align_progressive

pub(all) struct BioseqalignprogressivePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_align_progressive_make_point(x : Double, y : Double) -> BioseqalignprogressivePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_align_progressive_make_point3(x : Double, y : Double, z : Double) -> BioseqalignprogressivePoint {
  { x, y, z, label: 0 }
}

pub fn bio_seq_align_progressive_point_x(pt : BioseqalignprogressivePoint) -> Double { pt.x }

pub fn bio_seq_align_progressive_point_y(pt : BioseqalignprogressivePoint) -> Double { pt.y }

pub fn bio_seq_align_progressive_point_z(pt : BioseqalignprogressivePoint) -> Double { pt.z }

pub fn bio_seq_align_progressive_point_label(pt : BioseqalignprogressivePoint) -> Int { pt.label }

pub fn bio_seq_align_progressive_point_dist(a : BioseqalignprogressivePoint, b : BioseqalignprogressivePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_seq_align_progressive_point_add(a : BioseqalignprogressivePoint, b : BioseqalignprogressivePoint) -> BioseqalignprogressivePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_seq_align_progressive_point_sub(a : BioseqalignprogressivePoint, b : BioseqalignprogressivePoint) -> BioseqalignprogressivePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_seq_align_progressive_point_scale(pt : BioseqalignprogressivePoint, s : Double) -> BioseqalignprogressivePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_seq_align_progressive_point_dot(a : BioseqalignprogressivePoint, b : BioseqalignprogressivePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_seq_align_progressive_point_cross(a : BioseqalignprogressivePoint, b : BioseqalignprogressivePoint) -> BioseqalignprogressivePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_seq_align_progressive_point_norm(pt : BioseqalignprogressivePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_seq_align_progressive_point_normalize(pt : BioseqalignprogressivePoint) -> BioseqalignprogressivePoint {
  let n = bio_seq_align_progressive_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_seq_align_progressive_point_scale(pt, 1.0 / n) }
}

pub fn bio_seq_align_progressive_point_negate(pt : BioseqalignprogressivePoint) -> BioseqalignprogressivePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_seq_align_progressive_point_mid(a : BioseqalignprogressivePoint, b : BioseqalignprogressivePoint) -> BioseqalignprogressivePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_seq_align_progressive_point_lerp(a : BioseqalignprogressivePoint, b : BioseqalignprogressivePoint, t : Double) -> BioseqalignprogressivePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_seq_align_progressive_point_to_string(pt : BioseqalignprogressivePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_align_progressive_make_series(vals : Array[Double], name : String) -> BioseqalignprogressiveSeries {
  { vals, name, meta: 0 }
}

pub fn bio_seq_align_progressive_series_len(s : BioseqalignprogressiveSeries) -> Int { s.vals.length() }

pub fn bio_seq_align_progressive_series_sum(s : BioseqalignprogressiveSeries) -> Double { @_common.sum(s.vals) }

pub fn bio_seq_align_progressive_series_mean(s : BioseqalignprogressiveSeries) -> Double { @_common.mean(s.vals) }

pub fn bio_seq_align_progressive_series_min(s : BioseqalignprogressiveSeries) -> Double { @_common.min(s.vals) }

pub fn bio_seq_align_progressive_series_max(s : BioseqalignprogressiveSeries) -> Double { @_common.max(s.vals) }

pub fn bio_seq_align_progressive_series_range(s : BioseqalignprogressiveSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn bio_seq_align_progressive_series_var(s : BioseqalignprogressiveSeries) -> Double { @_common.variance(s.vals) }

pub fn bio_seq_align_progressive_series_std(s : BioseqalignprogressiveSeries) -> Double { @_common.std(s.vals) }

pub fn bio_seq_align_progressive_series_median(s : BioseqalignprogressiveSeries) -> Double { @_common.median(s.vals) }

pub fn bio_seq_align_progressive_series_scale(s : BioseqalignprogressiveSeries, f : Double) -> BioseqalignprogressiveSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_seq_align_progressive_series_add(a : BioseqalignprogressiveSeries, b : BioseqalignprogressiveSeries) -> BioseqalignprogressiveSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_seq_align_progressive_series_sub(a : BioseqalignprogressiveSeries, b : BioseqalignprogressiveSeries) -> BioseqalignprogressiveSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_seq_align_progressive_series_normalize(s : BioseqalignprogressiveSeries) -> BioseqalignprogressiveSeries {
  let mn = bio_seq_align_progressive_series_min(s)
  let mx = bio_seq_align_progressive_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_seq_align_progressive_series_cumsum(s : BioseqalignprogressiveSeries) -> BioseqalignprogressiveSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_seq_align_progressive_series_to_string(s : BioseqalignprogressiveSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqalignprogressiveMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_align_progressive_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqalignprogressiveMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_align_progressive_matrix_identity(n : Int) -> BioseqalignprogressiveMatrix {
  let m = bio_seq_align_progressive_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_seq_align_progressive_matrix_get(m : BioseqalignprogressiveMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_seq_align_progressive_matrix_transpose(m : BioseqalignprogressiveMatrix) -> BioseqalignprogressiveMatrix {
  let result = bio_seq_align_progressive_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_seq_align_progressive_matrix_add(a : BioseqalignprogressiveMatrix, b : BioseqalignprogressiveMatrix) -> BioseqalignprogressiveMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_seq_align_progressive_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_seq_align_progressive_matrix_scale(m : BioseqalignprogressiveMatrix, s : Double) -> BioseqalignprogressiveMatrix {
  let result = bio_seq_align_progressive_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_seq_align_progressive_matrix_multiply(a : BioseqalignprogressiveMatrix, b : BioseqalignprogressiveMatrix) -> BioseqalignprogressiveMatrix {
  if a.cols != b.rows { return bio_seq_align_progressive_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_seq_align_progressive_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_seq_align_progressive_matrix_trace(m : BioseqalignprogressiveMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_seq_align_progressive_matrix_det(m : BioseqalignprogressiveMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_seq_align_progressive_matrix_norm(m : BioseqalignprogressiveMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_seq_align_progressive_matrix_to_string(m : BioseqalignprogressiveMatrix) -> String {
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

pub(all) struct BioseqalignprogressiveVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_align_progressive_make_vector(comps : Array[Double]) -> BioseqalignprogressiveVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_align_progressive_vector_zero(dim : Int) -> BioseqalignprogressiveVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_seq_align_progressive_vector_add(a : BioseqalignprogressiveVector, b : BioseqalignprogressiveVector) -> BioseqalignprogressiveVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_align_progressive_vector_sub(a : BioseqalignprogressiveVector, b : BioseqalignprogressiveVector) -> BioseqalignprogressiveVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_align_progressive_vector_scale(v : BioseqalignprogressiveVector, s : Double) -> BioseqalignprogressiveVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_seq_align_progressive_vector_dot(a : BioseqalignprogressiveVector, b : BioseqalignprogressiveVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_seq_align_progressive_vector_norm(v : BioseqalignprogressiveVector) -> Double { @_common.sqrt(bio_seq_align_progressive_vector_dot(v, v)) }

pub fn bio_seq_align_progressive_vector_normalize(v : BioseqalignprogressiveVector) -> BioseqalignprogressiveVector {
  let n = bio_seq_align_progressive_vector_norm(v)
  if n < 0.0000001 { v } else { bio_seq_align_progressive_vector_scale(v, 1.0 / n) }
}

pub fn bio_seq_align_progressive_vector_dist(a : BioseqalignprogressiveVector, b : BioseqalignprogressiveVector) -> Double {
  bio_seq_align_progressive_vector_norm(bio_seq_align_progressive_vector_sub(a, b))
}

pub fn bio_seq_align_progressive_vector_to_string(v : BioseqalignprogressiveVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_align_progressive_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_align_progressive_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_align_progressive_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_align_progressive_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_align_progressive_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_align_progressive_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_align_progressive_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_align_progressive_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_align_progressive_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_align_progressive_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_align_progressive_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_align_progressive_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_align_progressive_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_align_progressive_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_align_progressive_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_align_progressive_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_align_progressive_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_align_progressive_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_align_progressive_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_align_progressive_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_align_progressive_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_align_progressive_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_align_progressive_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_align_progressive_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_align_progressive_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_align_progressive_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_align_progressive_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_align_progressive_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_align_progressive_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqalignprogressiveFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_frame_make(size : Int) -> BioseqalignprogressiveFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_frame_len(s : BioseqalignprogressiveFrame) -> Int { s.size }

pub fn bio_seq_align_progressive_frame_get(s : BioseqalignprogressiveFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_frame_set(s : BioseqalignprogressiveFrame, i : Int, v : Double) -> BioseqalignprogressiveFrame {
  let result = bio_seq_align_progressive_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_frame_sum(s : BioseqalignprogressiveFrame) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_frame_mean(s : BioseqalignprogressiveFrame) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_frame_scale(s : BioseqalignprogressiveFrame, f : Double) -> BioseqalignprogressiveFrame {
  let result = bio_seq_align_progressive_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_progressive_frame_add(a : BioseqalignprogressiveFrame, b : BioseqalignprogressiveFrame) -> BioseqalignprogressiveFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_progressive_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_progressive_frame_copy(s : BioseqalignprogressiveFrame) -> BioseqalignprogressiveFrame {
  let result = bio_seq_align_progressive_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_progressive_frame_fill(s : BioseqalignprogressiveFrame, v : Double) -> BioseqalignprogressiveFrame {
  let result = bio_seq_align_progressive_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_frame_min(s : BioseqalignprogressiveFrame) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_frame_max(s : BioseqalignprogressiveFrame) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_frame_to_string(s : BioseqalignprogressiveFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_table_make(size : Int) -> BioseqalignprogressiveTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_table_len(s : BioseqalignprogressiveTable) -> Int { s.size }

pub fn bio_seq_align_progressive_table_get(s : BioseqalignprogressiveTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_table_set(s : BioseqalignprogressiveTable, i : Int, v : Double) -> BioseqalignprogressiveTable {
  let result = bio_seq_align_progressive_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_table_sum(s : BioseqalignprogressiveTable) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_table_mean(s : BioseqalignprogressiveTable) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_table_scale(s : BioseqalignprogressiveTable, f : Double) -> BioseqalignprogressiveTable {
  let result = bio_seq_align_progressive_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_progressive_table_add(a : BioseqalignprogressiveTable, b : BioseqalignprogressiveTable) -> BioseqalignprogressiveTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_progressive_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_progressive_table_copy(s : BioseqalignprogressiveTable) -> BioseqalignprogressiveTable {
  let result = bio_seq_align_progressive_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_progressive_table_fill(s : BioseqalignprogressiveTable, v : Double) -> BioseqalignprogressiveTable {
  let result = bio_seq_align_progressive_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_table_min(s : BioseqalignprogressiveTable) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_table_max(s : BioseqalignprogressiveTable) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_table_to_string(s : BioseqalignprogressiveTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_graphn_make(size : Int) -> BioseqalignprogressiveGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_graphn_len(s : BioseqalignprogressiveGraphN) -> Int { s.size }

pub fn bio_seq_align_progressive_graphn_get(s : BioseqalignprogressiveGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_graphn_set(s : BioseqalignprogressiveGraphN, i : Int, v : Double) -> BioseqalignprogressiveGraphN {
  let result = bio_seq_align_progressive_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_graphn_sum(s : BioseqalignprogressiveGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_graphn_mean(s : BioseqalignprogressiveGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_graphn_scale(s : BioseqalignprogressiveGraphN, f : Double) -> BioseqalignprogressiveGraphN {
  let result = bio_seq_align_progressive_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_progressive_graphn_add(a : BioseqalignprogressiveGraphN, b : BioseqalignprogressiveGraphN) -> BioseqalignprogressiveGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_progressive_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_progressive_graphn_copy(s : BioseqalignprogressiveGraphN) -> BioseqalignprogressiveGraphN {
  let result = bio_seq_align_progressive_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_progressive_graphn_fill(s : BioseqalignprogressiveGraphN, v : Double) -> BioseqalignprogressiveGraphN {
  let result = bio_seq_align_progressive_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_graphn_min(s : BioseqalignprogressiveGraphN) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_graphn_max(s : BioseqalignprogressiveGraphN) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_graphn_to_string(s : BioseqalignprogressiveGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_node_make(size : Int) -> BioseqalignprogressiveNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_node_len(s : BioseqalignprogressiveNode) -> Int { s.size }

pub fn bio_seq_align_progressive_node_get(s : BioseqalignprogressiveNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_node_set(s : BioseqalignprogressiveNode, i : Int, v : Double) -> BioseqalignprogressiveNode {
  let result = bio_seq_align_progressive_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_node_sum(s : BioseqalignprogressiveNode) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_node_mean(s : BioseqalignprogressiveNode) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_node_scale(s : BioseqalignprogressiveNode, f : Double) -> BioseqalignprogressiveNode {
  let result = bio_seq_align_progressive_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_progressive_node_add(a : BioseqalignprogressiveNode, b : BioseqalignprogressiveNode) -> BioseqalignprogressiveNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_progressive_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_progressive_node_copy(s : BioseqalignprogressiveNode) -> BioseqalignprogressiveNode {
  let result = bio_seq_align_progressive_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_progressive_node_fill(s : BioseqalignprogressiveNode, v : Double) -> BioseqalignprogressiveNode {
  let result = bio_seq_align_progressive_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_node_min(s : BioseqalignprogressiveNode) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_node_max(s : BioseqalignprogressiveNode) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_node_to_string(s : BioseqalignprogressiveNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_edge_make(size : Int) -> BioseqalignprogressiveEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_edge_len(s : BioseqalignprogressiveEdge) -> Int { s.size }

pub fn bio_seq_align_progressive_edge_get(s : BioseqalignprogressiveEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_edge_set(s : BioseqalignprogressiveEdge, i : Int, v : Double) -> BioseqalignprogressiveEdge {
  let result = bio_seq_align_progressive_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_edge_sum(s : BioseqalignprogressiveEdge) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_edge_mean(s : BioseqalignprogressiveEdge) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_edge_scale(s : BioseqalignprogressiveEdge, f : Double) -> BioseqalignprogressiveEdge {
  let result = bio_seq_align_progressive_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_progressive_edge_add(a : BioseqalignprogressiveEdge, b : BioseqalignprogressiveEdge) -> BioseqalignprogressiveEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_progressive_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_progressive_edge_copy(s : BioseqalignprogressiveEdge) -> BioseqalignprogressiveEdge {
  let result = bio_seq_align_progressive_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_progressive_edge_fill(s : BioseqalignprogressiveEdge, v : Double) -> BioseqalignprogressiveEdge {
  let result = bio_seq_align_progressive_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_edge_min(s : BioseqalignprogressiveEdge) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_edge_max(s : BioseqalignprogressiveEdge) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_edge_to_string(s : BioseqalignprogressiveEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressivePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_path_make(size : Int) -> BioseqalignprogressivePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_path_len(s : BioseqalignprogressivePath) -> Int { s.size }

pub fn bio_seq_align_progressive_path_get(s : BioseqalignprogressivePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_path_set(s : BioseqalignprogressivePath, i : Int, v : Double) -> BioseqalignprogressivePath {
  let result = bio_seq_align_progressive_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_path_sum(s : BioseqalignprogressivePath) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_path_mean(s : BioseqalignprogressivePath) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_path_scale(s : BioseqalignprogressivePath, f : Double) -> BioseqalignprogressivePath {
  let result = bio_seq_align_progressive_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_progressive_path_add(a : BioseqalignprogressivePath, b : BioseqalignprogressivePath) -> BioseqalignprogressivePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_progressive_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_progressive_path_copy(s : BioseqalignprogressivePath) -> BioseqalignprogressivePath {
  let result = bio_seq_align_progressive_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_progressive_path_fill(s : BioseqalignprogressivePath, v : Double) -> BioseqalignprogressivePath {
  let result = bio_seq_align_progressive_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_path_min(s : BioseqalignprogressivePath) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_path_max(s : BioseqalignprogressivePath) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_path_to_string(s : BioseqalignprogressivePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_cluster_make(size : Int) -> BioseqalignprogressiveCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_cluster_len(s : BioseqalignprogressiveCluster) -> Int { s.size }

pub fn bio_seq_align_progressive_cluster_get(s : BioseqalignprogressiveCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_cluster_set(s : BioseqalignprogressiveCluster, i : Int, v : Double) -> BioseqalignprogressiveCluster {
  let result = bio_seq_align_progressive_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_cluster_sum(s : BioseqalignprogressiveCluster) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_cluster_mean(s : BioseqalignprogressiveCluster) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_cluster_scale(s : BioseqalignprogressiveCluster, f : Double) -> BioseqalignprogressiveCluster {
  let result = bio_seq_align_progressive_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_progressive_cluster_add(a : BioseqalignprogressiveCluster, b : BioseqalignprogressiveCluster) -> BioseqalignprogressiveCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_progressive_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_progressive_cluster_copy(s : BioseqalignprogressiveCluster) -> BioseqalignprogressiveCluster {
  let result = bio_seq_align_progressive_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_progressive_cluster_fill(s : BioseqalignprogressiveCluster, v : Double) -> BioseqalignprogressiveCluster {
  let result = bio_seq_align_progressive_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_cluster_min(s : BioseqalignprogressiveCluster) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_cluster_max(s : BioseqalignprogressiveCluster) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_cluster_to_string(s : BioseqalignprogressiveCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_model_make(size : Int) -> BioseqalignprogressiveModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_model_len(s : BioseqalignprogressiveModel) -> Int { s.size }

pub fn bio_seq_align_progressive_model_get(s : BioseqalignprogressiveModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_model_set(s : BioseqalignprogressiveModel, i : Int, v : Double) -> BioseqalignprogressiveModel {
  let result = bio_seq_align_progressive_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_model_sum(s : BioseqalignprogressiveModel) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_model_mean(s : BioseqalignprogressiveModel) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_model_scale(s : BioseqalignprogressiveModel, f : Double) -> BioseqalignprogressiveModel {
  let result = bio_seq_align_progressive_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_progressive_model_add(a : BioseqalignprogressiveModel, b : BioseqalignprogressiveModel) -> BioseqalignprogressiveModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_progressive_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_progressive_model_copy(s : BioseqalignprogressiveModel) -> BioseqalignprogressiveModel {
  let result = bio_seq_align_progressive_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_progressive_model_fill(s : BioseqalignprogressiveModel, v : Double) -> BioseqalignprogressiveModel {
  let result = bio_seq_align_progressive_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_model_min(s : BioseqalignprogressiveModel) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_model_max(s : BioseqalignprogressiveModel) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_model_to_string(s : BioseqalignprogressiveModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_layer_make(size : Int) -> BioseqalignprogressiveLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_layer_len(s : BioseqalignprogressiveLayer) -> Int { s.size }

pub fn bio_seq_align_progressive_layer_get(s : BioseqalignprogressiveLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_layer_set(s : BioseqalignprogressiveLayer, i : Int, v : Double) -> BioseqalignprogressiveLayer {
  let result = bio_seq_align_progressive_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_layer_sum(s : BioseqalignprogressiveLayer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_layer_mean(s : BioseqalignprogressiveLayer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_layer_scale(s : BioseqalignprogressiveLayer, f : Double) -> BioseqalignprogressiveLayer {
  let result = bio_seq_align_progressive_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_progressive_layer_add(a : BioseqalignprogressiveLayer, b : BioseqalignprogressiveLayer) -> BioseqalignprogressiveLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_progressive_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_progressive_layer_copy(s : BioseqalignprogressiveLayer) -> BioseqalignprogressiveLayer {
  let result = bio_seq_align_progressive_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_progressive_layer_fill(s : BioseqalignprogressiveLayer, v : Double) -> BioseqalignprogressiveLayer {
  let result = bio_seq_align_progressive_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_layer_min(s : BioseqalignprogressiveLayer) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_layer_max(s : BioseqalignprogressiveLayer) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_layer_to_string(s : BioseqalignprogressiveLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_buffer_make(size : Int) -> BioseqalignprogressiveBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_buffer_len(s : BioseqalignprogressiveBuffer) -> Int { s.size }

pub fn bio_seq_align_progressive_buffer_get(s : BioseqalignprogressiveBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_buffer_set(s : BioseqalignprogressiveBuffer, i : Int, v : Double) -> BioseqalignprogressiveBuffer {
  let result = bio_seq_align_progressive_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_buffer_sum(s : BioseqalignprogressiveBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_buffer_mean(s : BioseqalignprogressiveBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_buffer_scale(s : BioseqalignprogressiveBuffer, f : Double) -> BioseqalignprogressiveBuffer {
  let result = bio_seq_align_progressive_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_progressive_buffer_add(a : BioseqalignprogressiveBuffer, b : BioseqalignprogressiveBuffer) -> BioseqalignprogressiveBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_progressive_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_progressive_buffer_copy(s : BioseqalignprogressiveBuffer) -> BioseqalignprogressiveBuffer {
  let result = bio_seq_align_progressive_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_progressive_buffer_fill(s : BioseqalignprogressiveBuffer, v : Double) -> BioseqalignprogressiveBuffer {
  let result = bio_seq_align_progressive_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_buffer_min(s : BioseqalignprogressiveBuffer) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_buffer_max(s : BioseqalignprogressiveBuffer) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_buffer_to_string(s : BioseqalignprogressiveBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_cursor_make(size : Int) -> BioseqalignprogressiveCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_cursor_len(s : BioseqalignprogressiveCursor) -> Int { s.size }

pub fn bio_seq_align_progressive_cursor_get(s : BioseqalignprogressiveCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_cursor_set(s : BioseqalignprogressiveCursor, i : Int, v : Double) -> BioseqalignprogressiveCursor {
  let result = bio_seq_align_progressive_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_cursor_sum(s : BioseqalignprogressiveCursor) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_cursor_mean(s : BioseqalignprogressiveCursor) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_cursor_scale(s : BioseqalignprogressiveCursor, f : Double) -> BioseqalignprogressiveCursor {
  let result = bio_seq_align_progressive_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_progressive_cursor_add(a : BioseqalignprogressiveCursor, b : BioseqalignprogressiveCursor) -> BioseqalignprogressiveCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_progressive_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_progressive_cursor_copy(s : BioseqalignprogressiveCursor) -> BioseqalignprogressiveCursor {
  let result = bio_seq_align_progressive_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_progressive_cursor_fill(s : BioseqalignprogressiveCursor, v : Double) -> BioseqalignprogressiveCursor {
  let result = bio_seq_align_progressive_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_cursor_min(s : BioseqalignprogressiveCursor) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_cursor_max(s : BioseqalignprogressiveCursor) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_cursor_to_string(s : BioseqalignprogressiveCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_view_make(size : Int) -> BioseqalignprogressiveView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_view_len(s : BioseqalignprogressiveView) -> Int { s.size }

pub fn bio_seq_align_progressive_view_get(s : BioseqalignprogressiveView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_view_set(s : BioseqalignprogressiveView, i : Int, v : Double) -> BioseqalignprogressiveView {
  let result = bio_seq_align_progressive_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_view_sum(s : BioseqalignprogressiveView) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_view_mean(s : BioseqalignprogressiveView) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_view_scale(s : BioseqalignprogressiveView, f : Double) -> BioseqalignprogressiveView {
  let result = bio_seq_align_progressive_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_progressive_view_add(a : BioseqalignprogressiveView, b : BioseqalignprogressiveView) -> BioseqalignprogressiveView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_progressive_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_progressive_view_copy(s : BioseqalignprogressiveView) -> BioseqalignprogressiveView {
  let result = bio_seq_align_progressive_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_progressive_view_fill(s : BioseqalignprogressiveView, v : Double) -> BioseqalignprogressiveView {
  let result = bio_seq_align_progressive_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_view_min(s : BioseqalignprogressiveView) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_view_max(s : BioseqalignprogressiveView) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_view_to_string(s : BioseqalignprogressiveView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_range_make(size : Int) -> BioseqalignprogressiveRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_range_len(s : BioseqalignprogressiveRange) -> Int { s.size }

pub fn bio_seq_align_progressive_range_get(s : BioseqalignprogressiveRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_range_set(s : BioseqalignprogressiveRange, i : Int, v : Double) -> BioseqalignprogressiveRange {
  let result = bio_seq_align_progressive_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_range_sum(s : BioseqalignprogressiveRange) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_range_mean(s : BioseqalignprogressiveRange) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_range_scale(s : BioseqalignprogressiveRange, f : Double) -> BioseqalignprogressiveRange {
  let result = bio_seq_align_progressive_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_progressive_range_add(a : BioseqalignprogressiveRange, b : BioseqalignprogressiveRange) -> BioseqalignprogressiveRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_progressive_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_progressive_range_copy(s : BioseqalignprogressiveRange) -> BioseqalignprogressiveRange {
  let result = bio_seq_align_progressive_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_progressive_range_fill(s : BioseqalignprogressiveRange, v : Double) -> BioseqalignprogressiveRange {
  let result = bio_seq_align_progressive_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_range_min(s : BioseqalignprogressiveRange) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_range_max(s : BioseqalignprogressiveRange) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_range_to_string(s : BioseqalignprogressiveRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_slice_make(size : Int) -> BioseqalignprogressiveSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_slice_len(s : BioseqalignprogressiveSlice) -> Int { s.size }

pub fn bio_seq_align_progressive_slice_get(s : BioseqalignprogressiveSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_slice_set(s : BioseqalignprogressiveSlice, i : Int, v : Double) -> BioseqalignprogressiveSlice {
  let result = bio_seq_align_progressive_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_slice_sum(s : BioseqalignprogressiveSlice) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_slice_mean(s : BioseqalignprogressiveSlice) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_slice_scale(s : BioseqalignprogressiveSlice, f : Double) -> BioseqalignprogressiveSlice {
  let result = bio_seq_align_progressive_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_progressive_slice_add(a : BioseqalignprogressiveSlice, b : BioseqalignprogressiveSlice) -> BioseqalignprogressiveSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_progressive_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_progressive_slice_copy(s : BioseqalignprogressiveSlice) -> BioseqalignprogressiveSlice {
  let result = bio_seq_align_progressive_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_progressive_slice_fill(s : BioseqalignprogressiveSlice, v : Double) -> BioseqalignprogressiveSlice {
  let result = bio_seq_align_progressive_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_progressive_slice_min(s : BioseqalignprogressiveSlice) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_slice_max(s : BioseqalignprogressiveSlice) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_slice_to_string(s : BioseqalignprogressiveSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

