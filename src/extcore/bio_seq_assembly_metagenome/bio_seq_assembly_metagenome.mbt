///===
/// extcore/bio_seq_assembly_metagenome

pub(all) struct BioseqassemblymetagenomePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_metagenome_make_point(x : Double, y : Double) -> BioseqassemblymetagenomePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_metagenome_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblymetagenomePoint {
  { x, y, z, label: 0 }
}

pub fn bio_seq_assembly_metagenome_point_x(pt : BioseqassemblymetagenomePoint) -> Double { pt.x }

pub fn bio_seq_assembly_metagenome_point_y(pt : BioseqassemblymetagenomePoint) -> Double { pt.y }

pub fn bio_seq_assembly_metagenome_point_z(pt : BioseqassemblymetagenomePoint) -> Double { pt.z }

pub fn bio_seq_assembly_metagenome_point_label(pt : BioseqassemblymetagenomePoint) -> Int { pt.label }

pub fn bio_seq_assembly_metagenome_point_dist(a : BioseqassemblymetagenomePoint, b : BioseqassemblymetagenomePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_seq_assembly_metagenome_point_add(a : BioseqassemblymetagenomePoint, b : BioseqassemblymetagenomePoint) -> BioseqassemblymetagenomePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_seq_assembly_metagenome_point_sub(a : BioseqassemblymetagenomePoint, b : BioseqassemblymetagenomePoint) -> BioseqassemblymetagenomePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_seq_assembly_metagenome_point_scale(pt : BioseqassemblymetagenomePoint, s : Double) -> BioseqassemblymetagenomePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_seq_assembly_metagenome_point_dot(a : BioseqassemblymetagenomePoint, b : BioseqassemblymetagenomePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_seq_assembly_metagenome_point_cross(a : BioseqassemblymetagenomePoint, b : BioseqassemblymetagenomePoint) -> BioseqassemblymetagenomePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_seq_assembly_metagenome_point_norm(pt : BioseqassemblymetagenomePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_seq_assembly_metagenome_point_normalize(pt : BioseqassemblymetagenomePoint) -> BioseqassemblymetagenomePoint {
  let n = bio_seq_assembly_metagenome_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_seq_assembly_metagenome_point_scale(pt, 1.0 / n) }
}

pub fn bio_seq_assembly_metagenome_point_negate(pt : BioseqassemblymetagenomePoint) -> BioseqassemblymetagenomePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_seq_assembly_metagenome_point_mid(a : BioseqassemblymetagenomePoint, b : BioseqassemblymetagenomePoint) -> BioseqassemblymetagenomePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_seq_assembly_metagenome_point_lerp(a : BioseqassemblymetagenomePoint, b : BioseqassemblymetagenomePoint, t : Double) -> BioseqassemblymetagenomePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_seq_assembly_metagenome_point_to_string(pt : BioseqassemblymetagenomePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_metagenome_make_series(vals : Array[Double], name : String) -> BioseqassemblymetagenomeSeries {
  { vals, name, meta: 0 }
}

pub fn bio_seq_assembly_metagenome_series_len(s : BioseqassemblymetagenomeSeries) -> Int { s.vals.length() }

pub fn bio_seq_assembly_metagenome_series_sum(s : BioseqassemblymetagenomeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_seq_assembly_metagenome_series_mean(s : BioseqassemblymetagenomeSeries) -> Double { @_common.mean(s.vals) }

pub fn bio_seq_assembly_metagenome_series_min(s : BioseqassemblymetagenomeSeries) -> Double { @_common.min(s.vals) }

pub fn bio_seq_assembly_metagenome_series_max(s : BioseqassemblymetagenomeSeries) -> Double { @_common.max(s.vals) }

pub fn bio_seq_assembly_metagenome_series_range(s : BioseqassemblymetagenomeSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn bio_seq_assembly_metagenome_series_var(s : BioseqassemblymetagenomeSeries) -> Double { @_common.variance(s.vals) }

pub fn bio_seq_assembly_metagenome_series_std(s : BioseqassemblymetagenomeSeries) -> Double { @_common.std(s.vals) }

pub fn bio_seq_assembly_metagenome_series_median(s : BioseqassemblymetagenomeSeries) -> Double { @_common.median(s.vals) }

pub fn bio_seq_assembly_metagenome_series_scale(s : BioseqassemblymetagenomeSeries, f : Double) -> BioseqassemblymetagenomeSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_seq_assembly_metagenome_series_add(a : BioseqassemblymetagenomeSeries, b : BioseqassemblymetagenomeSeries) -> BioseqassemblymetagenomeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_seq_assembly_metagenome_series_sub(a : BioseqassemblymetagenomeSeries, b : BioseqassemblymetagenomeSeries) -> BioseqassemblymetagenomeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_seq_assembly_metagenome_series_normalize(s : BioseqassemblymetagenomeSeries) -> BioseqassemblymetagenomeSeries {
  let mn = bio_seq_assembly_metagenome_series_min(s)
  let mx = bio_seq_assembly_metagenome_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_seq_assembly_metagenome_series_cumsum(s : BioseqassemblymetagenomeSeries) -> BioseqassemblymetagenomeSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_seq_assembly_metagenome_series_to_string(s : BioseqassemblymetagenomeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblymetagenomeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_metagenome_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblymetagenomeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_metagenome_matrix_identity(n : Int) -> BioseqassemblymetagenomeMatrix {
  let m = bio_seq_assembly_metagenome_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_seq_assembly_metagenome_matrix_get(m : BioseqassemblymetagenomeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_seq_assembly_metagenome_matrix_transpose(m : BioseqassemblymetagenomeMatrix) -> BioseqassemblymetagenomeMatrix {
  let result = bio_seq_assembly_metagenome_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_seq_assembly_metagenome_matrix_add(a : BioseqassemblymetagenomeMatrix, b : BioseqassemblymetagenomeMatrix) -> BioseqassemblymetagenomeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_seq_assembly_metagenome_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_seq_assembly_metagenome_matrix_scale(m : BioseqassemblymetagenomeMatrix, s : Double) -> BioseqassemblymetagenomeMatrix {
  let result = bio_seq_assembly_metagenome_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_seq_assembly_metagenome_matrix_multiply(a : BioseqassemblymetagenomeMatrix, b : BioseqassemblymetagenomeMatrix) -> BioseqassemblymetagenomeMatrix {
  if a.cols != b.rows { return bio_seq_assembly_metagenome_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_seq_assembly_metagenome_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_seq_assembly_metagenome_matrix_trace(m : BioseqassemblymetagenomeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_seq_assembly_metagenome_matrix_det(m : BioseqassemblymetagenomeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_seq_assembly_metagenome_matrix_norm(m : BioseqassemblymetagenomeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_seq_assembly_metagenome_matrix_to_string(m : BioseqassemblymetagenomeMatrix) -> String {
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

pub(all) struct BioseqassemblymetagenomeVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_metagenome_make_vector(comps : Array[Double]) -> BioseqassemblymetagenomeVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_metagenome_vector_zero(dim : Int) -> BioseqassemblymetagenomeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_seq_assembly_metagenome_vector_add(a : BioseqassemblymetagenomeVector, b : BioseqassemblymetagenomeVector) -> BioseqassemblymetagenomeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_assembly_metagenome_vector_sub(a : BioseqassemblymetagenomeVector, b : BioseqassemblymetagenomeVector) -> BioseqassemblymetagenomeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_assembly_metagenome_vector_scale(v : BioseqassemblymetagenomeVector, s : Double) -> BioseqassemblymetagenomeVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_seq_assembly_metagenome_vector_dot(a : BioseqassemblymetagenomeVector, b : BioseqassemblymetagenomeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_seq_assembly_metagenome_vector_norm(v : BioseqassemblymetagenomeVector) -> Double { @_common.sqrt(bio_seq_assembly_metagenome_vector_dot(v, v)) }

pub fn bio_seq_assembly_metagenome_vector_normalize(v : BioseqassemblymetagenomeVector) -> BioseqassemblymetagenomeVector {
  let n = bio_seq_assembly_metagenome_vector_norm(v)
  if n < 0.0000001 { v } else { bio_seq_assembly_metagenome_vector_scale(v, 1.0 / n) }
}

pub fn bio_seq_assembly_metagenome_vector_dist(a : BioseqassemblymetagenomeVector, b : BioseqassemblymetagenomeVector) -> Double {
  bio_seq_assembly_metagenome_vector_norm(bio_seq_assembly_metagenome_vector_sub(a, b))
}

pub fn bio_seq_assembly_metagenome_vector_to_string(v : BioseqassemblymetagenomeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_assembly_metagenome_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_assembly_metagenome_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_assembly_metagenome_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_assembly_metagenome_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_assembly_metagenome_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_assembly_metagenome_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_assembly_metagenome_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_assembly_metagenome_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_assembly_metagenome_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_assembly_metagenome_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_assembly_metagenome_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_assembly_metagenome_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_assembly_metagenome_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_assembly_metagenome_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_assembly_metagenome_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_assembly_metagenome_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_assembly_metagenome_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_assembly_metagenome_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_assembly_metagenome_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_assembly_metagenome_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_assembly_metagenome_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_assembly_metagenome_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_assembly_metagenome_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_assembly_metagenome_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_assembly_metagenome_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_assembly_metagenome_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_assembly_metagenome_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_assembly_metagenome_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_assembly_metagenome_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqassemblymetagenomeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_frame_make(size : Int) -> BioseqassemblymetagenomeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_frame_len(s : BioseqassemblymetagenomeFrame) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_frame_get(s : BioseqassemblymetagenomeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_frame_set(s : BioseqassemblymetagenomeFrame, i : Int, v : Double) -> BioseqassemblymetagenomeFrame {
  let result = bio_seq_assembly_metagenome_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_frame_sum(s : BioseqassemblymetagenomeFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_metagenome_frame_mean(s : BioseqassemblymetagenomeFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_metagenome_frame_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_metagenome_frame_scale(s : BioseqassemblymetagenomeFrame, f : Double) -> BioseqassemblymetagenomeFrame {
  let result = bio_seq_assembly_metagenome_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_metagenome_frame_add(a : BioseqassemblymetagenomeFrame, b : BioseqassemblymetagenomeFrame) -> BioseqassemblymetagenomeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_metagenome_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_frame_copy(s : BioseqassemblymetagenomeFrame) -> BioseqassemblymetagenomeFrame {
  let result = bio_seq_assembly_metagenome_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_frame_fill(s : BioseqassemblymetagenomeFrame, v : Double) -> BioseqassemblymetagenomeFrame {
  let result = bio_seq_assembly_metagenome_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_frame_min(s : BioseqassemblymetagenomeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_frame_max(s : BioseqassemblymetagenomeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_frame_to_string(s : BioseqassemblymetagenomeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_table_make(size : Int) -> BioseqassemblymetagenomeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_table_len(s : BioseqassemblymetagenomeTable) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_table_get(s : BioseqassemblymetagenomeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_table_set(s : BioseqassemblymetagenomeTable, i : Int, v : Double) -> BioseqassemblymetagenomeTable {
  let result = bio_seq_assembly_metagenome_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_table_sum(s : BioseqassemblymetagenomeTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_metagenome_table_mean(s : BioseqassemblymetagenomeTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_metagenome_table_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_metagenome_table_scale(s : BioseqassemblymetagenomeTable, f : Double) -> BioseqassemblymetagenomeTable {
  let result = bio_seq_assembly_metagenome_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_metagenome_table_add(a : BioseqassemblymetagenomeTable, b : BioseqassemblymetagenomeTable) -> BioseqassemblymetagenomeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_metagenome_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_table_copy(s : BioseqassemblymetagenomeTable) -> BioseqassemblymetagenomeTable {
  let result = bio_seq_assembly_metagenome_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_table_fill(s : BioseqassemblymetagenomeTable, v : Double) -> BioseqassemblymetagenomeTable {
  let result = bio_seq_assembly_metagenome_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_table_min(s : BioseqassemblymetagenomeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_table_max(s : BioseqassemblymetagenomeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_table_to_string(s : BioseqassemblymetagenomeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_graphn_make(size : Int) -> BioseqassemblymetagenomeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_graphn_len(s : BioseqassemblymetagenomeGraphN) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_graphn_get(s : BioseqassemblymetagenomeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_graphn_set(s : BioseqassemblymetagenomeGraphN, i : Int, v : Double) -> BioseqassemblymetagenomeGraphN {
  let result = bio_seq_assembly_metagenome_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_graphn_sum(s : BioseqassemblymetagenomeGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_metagenome_graphn_mean(s : BioseqassemblymetagenomeGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_metagenome_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_metagenome_graphn_scale(s : BioseqassemblymetagenomeGraphN, f : Double) -> BioseqassemblymetagenomeGraphN {
  let result = bio_seq_assembly_metagenome_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_metagenome_graphn_add(a : BioseqassemblymetagenomeGraphN, b : BioseqassemblymetagenomeGraphN) -> BioseqassemblymetagenomeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_metagenome_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_graphn_copy(s : BioseqassemblymetagenomeGraphN) -> BioseqassemblymetagenomeGraphN {
  let result = bio_seq_assembly_metagenome_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_graphn_fill(s : BioseqassemblymetagenomeGraphN, v : Double) -> BioseqassemblymetagenomeGraphN {
  let result = bio_seq_assembly_metagenome_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_graphn_min(s : BioseqassemblymetagenomeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_graphn_max(s : BioseqassemblymetagenomeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_graphn_to_string(s : BioseqassemblymetagenomeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_node_make(size : Int) -> BioseqassemblymetagenomeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_node_len(s : BioseqassemblymetagenomeNode) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_node_get(s : BioseqassemblymetagenomeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_node_set(s : BioseqassemblymetagenomeNode, i : Int, v : Double) -> BioseqassemblymetagenomeNode {
  let result = bio_seq_assembly_metagenome_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_node_sum(s : BioseqassemblymetagenomeNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_metagenome_node_mean(s : BioseqassemblymetagenomeNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_metagenome_node_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_metagenome_node_scale(s : BioseqassemblymetagenomeNode, f : Double) -> BioseqassemblymetagenomeNode {
  let result = bio_seq_assembly_metagenome_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_metagenome_node_add(a : BioseqassemblymetagenomeNode, b : BioseqassemblymetagenomeNode) -> BioseqassemblymetagenomeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_metagenome_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_node_copy(s : BioseqassemblymetagenomeNode) -> BioseqassemblymetagenomeNode {
  let result = bio_seq_assembly_metagenome_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_node_fill(s : BioseqassemblymetagenomeNode, v : Double) -> BioseqassemblymetagenomeNode {
  let result = bio_seq_assembly_metagenome_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_node_min(s : BioseqassemblymetagenomeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_node_max(s : BioseqassemblymetagenomeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_node_to_string(s : BioseqassemblymetagenomeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_edge_make(size : Int) -> BioseqassemblymetagenomeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_edge_len(s : BioseqassemblymetagenomeEdge) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_edge_get(s : BioseqassemblymetagenomeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_edge_set(s : BioseqassemblymetagenomeEdge, i : Int, v : Double) -> BioseqassemblymetagenomeEdge {
  let result = bio_seq_assembly_metagenome_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_edge_sum(s : BioseqassemblymetagenomeEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_metagenome_edge_mean(s : BioseqassemblymetagenomeEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_metagenome_edge_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_metagenome_edge_scale(s : BioseqassemblymetagenomeEdge, f : Double) -> BioseqassemblymetagenomeEdge {
  let result = bio_seq_assembly_metagenome_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_metagenome_edge_add(a : BioseqassemblymetagenomeEdge, b : BioseqassemblymetagenomeEdge) -> BioseqassemblymetagenomeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_metagenome_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_edge_copy(s : BioseqassemblymetagenomeEdge) -> BioseqassemblymetagenomeEdge {
  let result = bio_seq_assembly_metagenome_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_edge_fill(s : BioseqassemblymetagenomeEdge, v : Double) -> BioseqassemblymetagenomeEdge {
  let result = bio_seq_assembly_metagenome_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_edge_min(s : BioseqassemblymetagenomeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_edge_max(s : BioseqassemblymetagenomeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_edge_to_string(s : BioseqassemblymetagenomeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_path_make(size : Int) -> BioseqassemblymetagenomePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_path_len(s : BioseqassemblymetagenomePath) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_path_get(s : BioseqassemblymetagenomePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_path_set(s : BioseqassemblymetagenomePath, i : Int, v : Double) -> BioseqassemblymetagenomePath {
  let result = bio_seq_assembly_metagenome_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_path_sum(s : BioseqassemblymetagenomePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_metagenome_path_mean(s : BioseqassemblymetagenomePath) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_metagenome_path_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_metagenome_path_scale(s : BioseqassemblymetagenomePath, f : Double) -> BioseqassemblymetagenomePath {
  let result = bio_seq_assembly_metagenome_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_metagenome_path_add(a : BioseqassemblymetagenomePath, b : BioseqassemblymetagenomePath) -> BioseqassemblymetagenomePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_metagenome_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_path_copy(s : BioseqassemblymetagenomePath) -> BioseqassemblymetagenomePath {
  let result = bio_seq_assembly_metagenome_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_path_fill(s : BioseqassemblymetagenomePath, v : Double) -> BioseqassemblymetagenomePath {
  let result = bio_seq_assembly_metagenome_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_path_min(s : BioseqassemblymetagenomePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_path_max(s : BioseqassemblymetagenomePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_path_to_string(s : BioseqassemblymetagenomePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_cluster_make(size : Int) -> BioseqassemblymetagenomeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_cluster_len(s : BioseqassemblymetagenomeCluster) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_cluster_get(s : BioseqassemblymetagenomeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_cluster_set(s : BioseqassemblymetagenomeCluster, i : Int, v : Double) -> BioseqassemblymetagenomeCluster {
  let result = bio_seq_assembly_metagenome_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_cluster_sum(s : BioseqassemblymetagenomeCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_metagenome_cluster_mean(s : BioseqassemblymetagenomeCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_metagenome_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_metagenome_cluster_scale(s : BioseqassemblymetagenomeCluster, f : Double) -> BioseqassemblymetagenomeCluster {
  let result = bio_seq_assembly_metagenome_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_metagenome_cluster_add(a : BioseqassemblymetagenomeCluster, b : BioseqassemblymetagenomeCluster) -> BioseqassemblymetagenomeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_metagenome_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_cluster_copy(s : BioseqassemblymetagenomeCluster) -> BioseqassemblymetagenomeCluster {
  let result = bio_seq_assembly_metagenome_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_cluster_fill(s : BioseqassemblymetagenomeCluster, v : Double) -> BioseqassemblymetagenomeCluster {
  let result = bio_seq_assembly_metagenome_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_cluster_min(s : BioseqassemblymetagenomeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_cluster_max(s : BioseqassemblymetagenomeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_cluster_to_string(s : BioseqassemblymetagenomeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_model_make(size : Int) -> BioseqassemblymetagenomeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_model_len(s : BioseqassemblymetagenomeModel) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_model_get(s : BioseqassemblymetagenomeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_model_set(s : BioseqassemblymetagenomeModel, i : Int, v : Double) -> BioseqassemblymetagenomeModel {
  let result = bio_seq_assembly_metagenome_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_model_sum(s : BioseqassemblymetagenomeModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_metagenome_model_mean(s : BioseqassemblymetagenomeModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_metagenome_model_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_metagenome_model_scale(s : BioseqassemblymetagenomeModel, f : Double) -> BioseqassemblymetagenomeModel {
  let result = bio_seq_assembly_metagenome_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_metagenome_model_add(a : BioseqassemblymetagenomeModel, b : BioseqassemblymetagenomeModel) -> BioseqassemblymetagenomeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_metagenome_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_model_copy(s : BioseqassemblymetagenomeModel) -> BioseqassemblymetagenomeModel {
  let result = bio_seq_assembly_metagenome_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_model_fill(s : BioseqassemblymetagenomeModel, v : Double) -> BioseqassemblymetagenomeModel {
  let result = bio_seq_assembly_metagenome_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_model_min(s : BioseqassemblymetagenomeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_model_max(s : BioseqassemblymetagenomeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_model_to_string(s : BioseqassemblymetagenomeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_layer_make(size : Int) -> BioseqassemblymetagenomeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_layer_len(s : BioseqassemblymetagenomeLayer) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_layer_get(s : BioseqassemblymetagenomeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_layer_set(s : BioseqassemblymetagenomeLayer, i : Int, v : Double) -> BioseqassemblymetagenomeLayer {
  let result = bio_seq_assembly_metagenome_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_layer_sum(s : BioseqassemblymetagenomeLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_metagenome_layer_mean(s : BioseqassemblymetagenomeLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_metagenome_layer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_metagenome_layer_scale(s : BioseqassemblymetagenomeLayer, f : Double) -> BioseqassemblymetagenomeLayer {
  let result = bio_seq_assembly_metagenome_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_metagenome_layer_add(a : BioseqassemblymetagenomeLayer, b : BioseqassemblymetagenomeLayer) -> BioseqassemblymetagenomeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_metagenome_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_layer_copy(s : BioseqassemblymetagenomeLayer) -> BioseqassemblymetagenomeLayer {
  let result = bio_seq_assembly_metagenome_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_layer_fill(s : BioseqassemblymetagenomeLayer, v : Double) -> BioseqassemblymetagenomeLayer {
  let result = bio_seq_assembly_metagenome_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_layer_min(s : BioseqassemblymetagenomeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_layer_max(s : BioseqassemblymetagenomeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_layer_to_string(s : BioseqassemblymetagenomeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_buffer_make(size : Int) -> BioseqassemblymetagenomeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_buffer_len(s : BioseqassemblymetagenomeBuffer) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_buffer_get(s : BioseqassemblymetagenomeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_buffer_set(s : BioseqassemblymetagenomeBuffer, i : Int, v : Double) -> BioseqassemblymetagenomeBuffer {
  let result = bio_seq_assembly_metagenome_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_buffer_sum(s : BioseqassemblymetagenomeBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_metagenome_buffer_mean(s : BioseqassemblymetagenomeBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_metagenome_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_metagenome_buffer_scale(s : BioseqassemblymetagenomeBuffer, f : Double) -> BioseqassemblymetagenomeBuffer {
  let result = bio_seq_assembly_metagenome_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_metagenome_buffer_add(a : BioseqassemblymetagenomeBuffer, b : BioseqassemblymetagenomeBuffer) -> BioseqassemblymetagenomeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_metagenome_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_buffer_copy(s : BioseqassemblymetagenomeBuffer) -> BioseqassemblymetagenomeBuffer {
  let result = bio_seq_assembly_metagenome_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_buffer_fill(s : BioseqassemblymetagenomeBuffer, v : Double) -> BioseqassemblymetagenomeBuffer {
  let result = bio_seq_assembly_metagenome_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_buffer_min(s : BioseqassemblymetagenomeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_buffer_max(s : BioseqassemblymetagenomeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_buffer_to_string(s : BioseqassemblymetagenomeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_cursor_make(size : Int) -> BioseqassemblymetagenomeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_cursor_len(s : BioseqassemblymetagenomeCursor) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_cursor_get(s : BioseqassemblymetagenomeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_cursor_set(s : BioseqassemblymetagenomeCursor, i : Int, v : Double) -> BioseqassemblymetagenomeCursor {
  let result = bio_seq_assembly_metagenome_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_cursor_sum(s : BioseqassemblymetagenomeCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_metagenome_cursor_mean(s : BioseqassemblymetagenomeCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_metagenome_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_metagenome_cursor_scale(s : BioseqassemblymetagenomeCursor, f : Double) -> BioseqassemblymetagenomeCursor {
  let result = bio_seq_assembly_metagenome_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_metagenome_cursor_add(a : BioseqassemblymetagenomeCursor, b : BioseqassemblymetagenomeCursor) -> BioseqassemblymetagenomeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_metagenome_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_cursor_copy(s : BioseqassemblymetagenomeCursor) -> BioseqassemblymetagenomeCursor {
  let result = bio_seq_assembly_metagenome_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_cursor_fill(s : BioseqassemblymetagenomeCursor, v : Double) -> BioseqassemblymetagenomeCursor {
  let result = bio_seq_assembly_metagenome_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_cursor_min(s : BioseqassemblymetagenomeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_cursor_max(s : BioseqassemblymetagenomeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_cursor_to_string(s : BioseqassemblymetagenomeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_view_make(size : Int) -> BioseqassemblymetagenomeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_view_len(s : BioseqassemblymetagenomeView) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_view_get(s : BioseqassemblymetagenomeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_view_set(s : BioseqassemblymetagenomeView, i : Int, v : Double) -> BioseqassemblymetagenomeView {
  let result = bio_seq_assembly_metagenome_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_view_sum(s : BioseqassemblymetagenomeView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_metagenome_view_mean(s : BioseqassemblymetagenomeView) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_metagenome_view_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_metagenome_view_scale(s : BioseqassemblymetagenomeView, f : Double) -> BioseqassemblymetagenomeView {
  let result = bio_seq_assembly_metagenome_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_metagenome_view_add(a : BioseqassemblymetagenomeView, b : BioseqassemblymetagenomeView) -> BioseqassemblymetagenomeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_metagenome_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_view_copy(s : BioseqassemblymetagenomeView) -> BioseqassemblymetagenomeView {
  let result = bio_seq_assembly_metagenome_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_view_fill(s : BioseqassemblymetagenomeView, v : Double) -> BioseqassemblymetagenomeView {
  let result = bio_seq_assembly_metagenome_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_view_min(s : BioseqassemblymetagenomeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_view_max(s : BioseqassemblymetagenomeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_view_to_string(s : BioseqassemblymetagenomeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_range_make(size : Int) -> BioseqassemblymetagenomeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_range_len(s : BioseqassemblymetagenomeRange) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_range_get(s : BioseqassemblymetagenomeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_range_set(s : BioseqassemblymetagenomeRange, i : Int, v : Double) -> BioseqassemblymetagenomeRange {
  let result = bio_seq_assembly_metagenome_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_range_sum(s : BioseqassemblymetagenomeRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_metagenome_range_mean(s : BioseqassemblymetagenomeRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_metagenome_range_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_metagenome_range_scale(s : BioseqassemblymetagenomeRange, f : Double) -> BioseqassemblymetagenomeRange {
  let result = bio_seq_assembly_metagenome_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_metagenome_range_add(a : BioseqassemblymetagenomeRange, b : BioseqassemblymetagenomeRange) -> BioseqassemblymetagenomeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_metagenome_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_range_copy(s : BioseqassemblymetagenomeRange) -> BioseqassemblymetagenomeRange {
  let result = bio_seq_assembly_metagenome_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_range_fill(s : BioseqassemblymetagenomeRange, v : Double) -> BioseqassemblymetagenomeRange {
  let result = bio_seq_assembly_metagenome_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_range_min(s : BioseqassemblymetagenomeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_range_max(s : BioseqassemblymetagenomeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_range_to_string(s : BioseqassemblymetagenomeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_slice_make(size : Int) -> BioseqassemblymetagenomeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_slice_len(s : BioseqassemblymetagenomeSlice) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_slice_get(s : BioseqassemblymetagenomeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_slice_set(s : BioseqassemblymetagenomeSlice, i : Int, v : Double) -> BioseqassemblymetagenomeSlice {
  let result = bio_seq_assembly_metagenome_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_slice_sum(s : BioseqassemblymetagenomeSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_metagenome_slice_mean(s : BioseqassemblymetagenomeSlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_metagenome_slice_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_metagenome_slice_scale(s : BioseqassemblymetagenomeSlice, f : Double) -> BioseqassemblymetagenomeSlice {
  let result = bio_seq_assembly_metagenome_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_metagenome_slice_add(a : BioseqassemblymetagenomeSlice, b : BioseqassemblymetagenomeSlice) -> BioseqassemblymetagenomeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_metagenome_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_slice_copy(s : BioseqassemblymetagenomeSlice) -> BioseqassemblymetagenomeSlice {
  let result = bio_seq_assembly_metagenome_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_metagenome_slice_fill(s : BioseqassemblymetagenomeSlice, v : Double) -> BioseqassemblymetagenomeSlice {
  let result = bio_seq_assembly_metagenome_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_metagenome_slice_min(s : BioseqassemblymetagenomeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_slice_max(s : BioseqassemblymetagenomeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_metagenome_slice_to_string(s : BioseqassemblymetagenomeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

