///===
/// extcore/bio_seq_assembly_scaffold

pub(all) struct BioseqassemblyscaffoldPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_scaffold_make_point(x : Double, y : Double) -> BioseqassemblyscaffoldPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_scaffold_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblyscaffoldPoint {
  { x, y, z, label: 0 }
}

pub fn bio_seq_assembly_scaffold_point_x(pt : BioseqassemblyscaffoldPoint) -> Double { pt.x }

pub fn bio_seq_assembly_scaffold_point_y(pt : BioseqassemblyscaffoldPoint) -> Double { pt.y }

pub fn bio_seq_assembly_scaffold_point_z(pt : BioseqassemblyscaffoldPoint) -> Double { pt.z }

pub fn bio_seq_assembly_scaffold_point_label(pt : BioseqassemblyscaffoldPoint) -> Int { pt.label }

pub fn bio_seq_assembly_scaffold_point_dist(a : BioseqassemblyscaffoldPoint, b : BioseqassemblyscaffoldPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_seq_assembly_scaffold_point_add(a : BioseqassemblyscaffoldPoint, b : BioseqassemblyscaffoldPoint) -> BioseqassemblyscaffoldPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_seq_assembly_scaffold_point_sub(a : BioseqassemblyscaffoldPoint, b : BioseqassemblyscaffoldPoint) -> BioseqassemblyscaffoldPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_seq_assembly_scaffold_point_scale(pt : BioseqassemblyscaffoldPoint, s : Double) -> BioseqassemblyscaffoldPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_seq_assembly_scaffold_point_dot(a : BioseqassemblyscaffoldPoint, b : BioseqassemblyscaffoldPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_seq_assembly_scaffold_point_cross(a : BioseqassemblyscaffoldPoint, b : BioseqassemblyscaffoldPoint) -> BioseqassemblyscaffoldPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_seq_assembly_scaffold_point_norm(pt : BioseqassemblyscaffoldPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_seq_assembly_scaffold_point_normalize(pt : BioseqassemblyscaffoldPoint) -> BioseqassemblyscaffoldPoint {
  let n = bio_seq_assembly_scaffold_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_seq_assembly_scaffold_point_scale(pt, 1.0 / n) }
}

pub fn bio_seq_assembly_scaffold_point_negate(pt : BioseqassemblyscaffoldPoint) -> BioseqassemblyscaffoldPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_seq_assembly_scaffold_point_mid(a : BioseqassemblyscaffoldPoint, b : BioseqassemblyscaffoldPoint) -> BioseqassemblyscaffoldPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_seq_assembly_scaffold_point_lerp(a : BioseqassemblyscaffoldPoint, b : BioseqassemblyscaffoldPoint, t : Double) -> BioseqassemblyscaffoldPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_seq_assembly_scaffold_point_to_string(pt : BioseqassemblyscaffoldPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_scaffold_make_series(vals : Array[Double], name : String) -> BioseqassemblyscaffoldSeries {
  { vals, name, meta: 0 }
}

pub fn bio_seq_assembly_scaffold_series_len(s : BioseqassemblyscaffoldSeries) -> Int { s.vals.length() }

pub fn bio_seq_assembly_scaffold_series_sum(s : BioseqassemblyscaffoldSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_seq_assembly_scaffold_series_mean(s : BioseqassemblyscaffoldSeries) -> Double { @_common.mean(s.vals) }

pub fn bio_seq_assembly_scaffold_series_min(s : BioseqassemblyscaffoldSeries) -> Double { @_common.min(s.vals) }

pub fn bio_seq_assembly_scaffold_series_max(s : BioseqassemblyscaffoldSeries) -> Double { @_common.max(s.vals) }

pub fn bio_seq_assembly_scaffold_series_range(s : BioseqassemblyscaffoldSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn bio_seq_assembly_scaffold_series_var(s : BioseqassemblyscaffoldSeries) -> Double { @_common.variance(s.vals) }

pub fn bio_seq_assembly_scaffold_series_std(s : BioseqassemblyscaffoldSeries) -> Double { @_common.std(s.vals) }

pub fn bio_seq_assembly_scaffold_series_median(s : BioseqassemblyscaffoldSeries) -> Double { @_common.median(s.vals) }

pub fn bio_seq_assembly_scaffold_series_scale(s : BioseqassemblyscaffoldSeries, f : Double) -> BioseqassemblyscaffoldSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_seq_assembly_scaffold_series_add(a : BioseqassemblyscaffoldSeries, b : BioseqassemblyscaffoldSeries) -> BioseqassemblyscaffoldSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_seq_assembly_scaffold_series_sub(a : BioseqassemblyscaffoldSeries, b : BioseqassemblyscaffoldSeries) -> BioseqassemblyscaffoldSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_seq_assembly_scaffold_series_normalize(s : BioseqassemblyscaffoldSeries) -> BioseqassemblyscaffoldSeries {
  let mn = bio_seq_assembly_scaffold_series_min(s)
  let mx = bio_seq_assembly_scaffold_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_seq_assembly_scaffold_series_cumsum(s : BioseqassemblyscaffoldSeries) -> BioseqassemblyscaffoldSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_seq_assembly_scaffold_series_to_string(s : BioseqassemblyscaffoldSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblyscaffoldMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_scaffold_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblyscaffoldMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_scaffold_matrix_identity(n : Int) -> BioseqassemblyscaffoldMatrix {
  let m = bio_seq_assembly_scaffold_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_seq_assembly_scaffold_matrix_get(m : BioseqassemblyscaffoldMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_seq_assembly_scaffold_matrix_transpose(m : BioseqassemblyscaffoldMatrix) -> BioseqassemblyscaffoldMatrix {
  let result = bio_seq_assembly_scaffold_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_seq_assembly_scaffold_matrix_add(a : BioseqassemblyscaffoldMatrix, b : BioseqassemblyscaffoldMatrix) -> BioseqassemblyscaffoldMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_seq_assembly_scaffold_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_seq_assembly_scaffold_matrix_scale(m : BioseqassemblyscaffoldMatrix, s : Double) -> BioseqassemblyscaffoldMatrix {
  let result = bio_seq_assembly_scaffold_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_seq_assembly_scaffold_matrix_multiply(a : BioseqassemblyscaffoldMatrix, b : BioseqassemblyscaffoldMatrix) -> BioseqassemblyscaffoldMatrix {
  if a.cols != b.rows { return bio_seq_assembly_scaffold_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_seq_assembly_scaffold_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_seq_assembly_scaffold_matrix_trace(m : BioseqassemblyscaffoldMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_seq_assembly_scaffold_matrix_det(m : BioseqassemblyscaffoldMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_seq_assembly_scaffold_matrix_norm(m : BioseqassemblyscaffoldMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_seq_assembly_scaffold_matrix_to_string(m : BioseqassemblyscaffoldMatrix) -> String {
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

pub(all) struct BioseqassemblyscaffoldVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_scaffold_make_vector(comps : Array[Double]) -> BioseqassemblyscaffoldVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_scaffold_vector_zero(dim : Int) -> BioseqassemblyscaffoldVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_seq_assembly_scaffold_vector_add(a : BioseqassemblyscaffoldVector, b : BioseqassemblyscaffoldVector) -> BioseqassemblyscaffoldVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_assembly_scaffold_vector_sub(a : BioseqassemblyscaffoldVector, b : BioseqassemblyscaffoldVector) -> BioseqassemblyscaffoldVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_assembly_scaffold_vector_scale(v : BioseqassemblyscaffoldVector, s : Double) -> BioseqassemblyscaffoldVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_seq_assembly_scaffold_vector_dot(a : BioseqassemblyscaffoldVector, b : BioseqassemblyscaffoldVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_seq_assembly_scaffold_vector_norm(v : BioseqassemblyscaffoldVector) -> Double { @_common.sqrt(bio_seq_assembly_scaffold_vector_dot(v, v)) }

pub fn bio_seq_assembly_scaffold_vector_normalize(v : BioseqassemblyscaffoldVector) -> BioseqassemblyscaffoldVector {
  let n = bio_seq_assembly_scaffold_vector_norm(v)
  if n < 0.0000001 { v } else { bio_seq_assembly_scaffold_vector_scale(v, 1.0 / n) }
}

pub fn bio_seq_assembly_scaffold_vector_dist(a : BioseqassemblyscaffoldVector, b : BioseqassemblyscaffoldVector) -> Double {
  bio_seq_assembly_scaffold_vector_norm(bio_seq_assembly_scaffold_vector_sub(a, b))
}

pub fn bio_seq_assembly_scaffold_vector_to_string(v : BioseqassemblyscaffoldVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_assembly_scaffold_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_assembly_scaffold_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_assembly_scaffold_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_assembly_scaffold_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_assembly_scaffold_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_assembly_scaffold_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_assembly_scaffold_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_assembly_scaffold_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_assembly_scaffold_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_assembly_scaffold_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_assembly_scaffold_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_assembly_scaffold_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_assembly_scaffold_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_assembly_scaffold_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_assembly_scaffold_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_assembly_scaffold_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_assembly_scaffold_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_assembly_scaffold_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_assembly_scaffold_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_assembly_scaffold_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_assembly_scaffold_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_assembly_scaffold_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_assembly_scaffold_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_assembly_scaffold_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_assembly_scaffold_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_assembly_scaffold_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_assembly_scaffold_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_assembly_scaffold_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_assembly_scaffold_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqassemblyscaffoldFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_frame_make(size : Int) -> BioseqassemblyscaffoldFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_frame_len(s : BioseqassemblyscaffoldFrame) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_frame_get(s : BioseqassemblyscaffoldFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_frame_set(s : BioseqassemblyscaffoldFrame, i : Int, v : Double) -> BioseqassemblyscaffoldFrame {
  let result = bio_seq_assembly_scaffold_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_frame_sum(s : BioseqassemblyscaffoldFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_scaffold_frame_mean(s : BioseqassemblyscaffoldFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_scaffold_frame_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_scaffold_frame_scale(s : BioseqassemblyscaffoldFrame, f : Double) -> BioseqassemblyscaffoldFrame {
  let result = bio_seq_assembly_scaffold_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_scaffold_frame_add(a : BioseqassemblyscaffoldFrame, b : BioseqassemblyscaffoldFrame) -> BioseqassemblyscaffoldFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_scaffold_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_frame_copy(s : BioseqassemblyscaffoldFrame) -> BioseqassemblyscaffoldFrame {
  let result = bio_seq_assembly_scaffold_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_frame_fill(s : BioseqassemblyscaffoldFrame, v : Double) -> BioseqassemblyscaffoldFrame {
  let result = bio_seq_assembly_scaffold_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_frame_min(s : BioseqassemblyscaffoldFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_frame_max(s : BioseqassemblyscaffoldFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_frame_to_string(s : BioseqassemblyscaffoldFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_table_make(size : Int) -> BioseqassemblyscaffoldTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_table_len(s : BioseqassemblyscaffoldTable) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_table_get(s : BioseqassemblyscaffoldTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_table_set(s : BioseqassemblyscaffoldTable, i : Int, v : Double) -> BioseqassemblyscaffoldTable {
  let result = bio_seq_assembly_scaffold_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_table_sum(s : BioseqassemblyscaffoldTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_scaffold_table_mean(s : BioseqassemblyscaffoldTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_scaffold_table_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_scaffold_table_scale(s : BioseqassemblyscaffoldTable, f : Double) -> BioseqassemblyscaffoldTable {
  let result = bio_seq_assembly_scaffold_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_scaffold_table_add(a : BioseqassemblyscaffoldTable, b : BioseqassemblyscaffoldTable) -> BioseqassemblyscaffoldTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_scaffold_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_table_copy(s : BioseqassemblyscaffoldTable) -> BioseqassemblyscaffoldTable {
  let result = bio_seq_assembly_scaffold_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_table_fill(s : BioseqassemblyscaffoldTable, v : Double) -> BioseqassemblyscaffoldTable {
  let result = bio_seq_assembly_scaffold_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_table_min(s : BioseqassemblyscaffoldTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_table_max(s : BioseqassemblyscaffoldTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_table_to_string(s : BioseqassemblyscaffoldTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_graphn_make(size : Int) -> BioseqassemblyscaffoldGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_graphn_len(s : BioseqassemblyscaffoldGraphN) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_graphn_get(s : BioseqassemblyscaffoldGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_graphn_set(s : BioseqassemblyscaffoldGraphN, i : Int, v : Double) -> BioseqassemblyscaffoldGraphN {
  let result = bio_seq_assembly_scaffold_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_graphn_sum(s : BioseqassemblyscaffoldGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_scaffold_graphn_mean(s : BioseqassemblyscaffoldGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_scaffold_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_scaffold_graphn_scale(s : BioseqassemblyscaffoldGraphN, f : Double) -> BioseqassemblyscaffoldGraphN {
  let result = bio_seq_assembly_scaffold_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_scaffold_graphn_add(a : BioseqassemblyscaffoldGraphN, b : BioseqassemblyscaffoldGraphN) -> BioseqassemblyscaffoldGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_scaffold_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_graphn_copy(s : BioseqassemblyscaffoldGraphN) -> BioseqassemblyscaffoldGraphN {
  let result = bio_seq_assembly_scaffold_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_graphn_fill(s : BioseqassemblyscaffoldGraphN, v : Double) -> BioseqassemblyscaffoldGraphN {
  let result = bio_seq_assembly_scaffold_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_graphn_min(s : BioseqassemblyscaffoldGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_graphn_max(s : BioseqassemblyscaffoldGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_graphn_to_string(s : BioseqassemblyscaffoldGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_node_make(size : Int) -> BioseqassemblyscaffoldNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_node_len(s : BioseqassemblyscaffoldNode) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_node_get(s : BioseqassemblyscaffoldNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_node_set(s : BioseqassemblyscaffoldNode, i : Int, v : Double) -> BioseqassemblyscaffoldNode {
  let result = bio_seq_assembly_scaffold_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_node_sum(s : BioseqassemblyscaffoldNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_scaffold_node_mean(s : BioseqassemblyscaffoldNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_scaffold_node_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_scaffold_node_scale(s : BioseqassemblyscaffoldNode, f : Double) -> BioseqassemblyscaffoldNode {
  let result = bio_seq_assembly_scaffold_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_scaffold_node_add(a : BioseqassemblyscaffoldNode, b : BioseqassemblyscaffoldNode) -> BioseqassemblyscaffoldNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_scaffold_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_node_copy(s : BioseqassemblyscaffoldNode) -> BioseqassemblyscaffoldNode {
  let result = bio_seq_assembly_scaffold_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_node_fill(s : BioseqassemblyscaffoldNode, v : Double) -> BioseqassemblyscaffoldNode {
  let result = bio_seq_assembly_scaffold_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_node_min(s : BioseqassemblyscaffoldNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_node_max(s : BioseqassemblyscaffoldNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_node_to_string(s : BioseqassemblyscaffoldNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_edge_make(size : Int) -> BioseqassemblyscaffoldEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_edge_len(s : BioseqassemblyscaffoldEdge) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_edge_get(s : BioseqassemblyscaffoldEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_edge_set(s : BioseqassemblyscaffoldEdge, i : Int, v : Double) -> BioseqassemblyscaffoldEdge {
  let result = bio_seq_assembly_scaffold_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_edge_sum(s : BioseqassemblyscaffoldEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_scaffold_edge_mean(s : BioseqassemblyscaffoldEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_scaffold_edge_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_scaffold_edge_scale(s : BioseqassemblyscaffoldEdge, f : Double) -> BioseqassemblyscaffoldEdge {
  let result = bio_seq_assembly_scaffold_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_scaffold_edge_add(a : BioseqassemblyscaffoldEdge, b : BioseqassemblyscaffoldEdge) -> BioseqassemblyscaffoldEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_scaffold_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_edge_copy(s : BioseqassemblyscaffoldEdge) -> BioseqassemblyscaffoldEdge {
  let result = bio_seq_assembly_scaffold_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_edge_fill(s : BioseqassemblyscaffoldEdge, v : Double) -> BioseqassemblyscaffoldEdge {
  let result = bio_seq_assembly_scaffold_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_edge_min(s : BioseqassemblyscaffoldEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_edge_max(s : BioseqassemblyscaffoldEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_edge_to_string(s : BioseqassemblyscaffoldEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_path_make(size : Int) -> BioseqassemblyscaffoldPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_path_len(s : BioseqassemblyscaffoldPath) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_path_get(s : BioseqassemblyscaffoldPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_path_set(s : BioseqassemblyscaffoldPath, i : Int, v : Double) -> BioseqassemblyscaffoldPath {
  let result = bio_seq_assembly_scaffold_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_path_sum(s : BioseqassemblyscaffoldPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_scaffold_path_mean(s : BioseqassemblyscaffoldPath) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_scaffold_path_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_scaffold_path_scale(s : BioseqassemblyscaffoldPath, f : Double) -> BioseqassemblyscaffoldPath {
  let result = bio_seq_assembly_scaffold_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_scaffold_path_add(a : BioseqassemblyscaffoldPath, b : BioseqassemblyscaffoldPath) -> BioseqassemblyscaffoldPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_scaffold_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_path_copy(s : BioseqassemblyscaffoldPath) -> BioseqassemblyscaffoldPath {
  let result = bio_seq_assembly_scaffold_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_path_fill(s : BioseqassemblyscaffoldPath, v : Double) -> BioseqassemblyscaffoldPath {
  let result = bio_seq_assembly_scaffold_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_path_min(s : BioseqassemblyscaffoldPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_path_max(s : BioseqassemblyscaffoldPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_path_to_string(s : BioseqassemblyscaffoldPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_cluster_make(size : Int) -> BioseqassemblyscaffoldCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_cluster_len(s : BioseqassemblyscaffoldCluster) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_cluster_get(s : BioseqassemblyscaffoldCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_cluster_set(s : BioseqassemblyscaffoldCluster, i : Int, v : Double) -> BioseqassemblyscaffoldCluster {
  let result = bio_seq_assembly_scaffold_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_cluster_sum(s : BioseqassemblyscaffoldCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_scaffold_cluster_mean(s : BioseqassemblyscaffoldCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_scaffold_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_scaffold_cluster_scale(s : BioseqassemblyscaffoldCluster, f : Double) -> BioseqassemblyscaffoldCluster {
  let result = bio_seq_assembly_scaffold_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_scaffold_cluster_add(a : BioseqassemblyscaffoldCluster, b : BioseqassemblyscaffoldCluster) -> BioseqassemblyscaffoldCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_scaffold_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_cluster_copy(s : BioseqassemblyscaffoldCluster) -> BioseqassemblyscaffoldCluster {
  let result = bio_seq_assembly_scaffold_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_cluster_fill(s : BioseqassemblyscaffoldCluster, v : Double) -> BioseqassemblyscaffoldCluster {
  let result = bio_seq_assembly_scaffold_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_cluster_min(s : BioseqassemblyscaffoldCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_cluster_max(s : BioseqassemblyscaffoldCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_cluster_to_string(s : BioseqassemblyscaffoldCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_model_make(size : Int) -> BioseqassemblyscaffoldModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_model_len(s : BioseqassemblyscaffoldModel) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_model_get(s : BioseqassemblyscaffoldModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_model_set(s : BioseqassemblyscaffoldModel, i : Int, v : Double) -> BioseqassemblyscaffoldModel {
  let result = bio_seq_assembly_scaffold_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_model_sum(s : BioseqassemblyscaffoldModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_scaffold_model_mean(s : BioseqassemblyscaffoldModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_scaffold_model_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_scaffold_model_scale(s : BioseqassemblyscaffoldModel, f : Double) -> BioseqassemblyscaffoldModel {
  let result = bio_seq_assembly_scaffold_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_scaffold_model_add(a : BioseqassemblyscaffoldModel, b : BioseqassemblyscaffoldModel) -> BioseqassemblyscaffoldModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_scaffold_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_model_copy(s : BioseqassemblyscaffoldModel) -> BioseqassemblyscaffoldModel {
  let result = bio_seq_assembly_scaffold_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_model_fill(s : BioseqassemblyscaffoldModel, v : Double) -> BioseqassemblyscaffoldModel {
  let result = bio_seq_assembly_scaffold_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_model_min(s : BioseqassemblyscaffoldModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_model_max(s : BioseqassemblyscaffoldModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_model_to_string(s : BioseqassemblyscaffoldModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_layer_make(size : Int) -> BioseqassemblyscaffoldLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_layer_len(s : BioseqassemblyscaffoldLayer) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_layer_get(s : BioseqassemblyscaffoldLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_layer_set(s : BioseqassemblyscaffoldLayer, i : Int, v : Double) -> BioseqassemblyscaffoldLayer {
  let result = bio_seq_assembly_scaffold_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_layer_sum(s : BioseqassemblyscaffoldLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_scaffold_layer_mean(s : BioseqassemblyscaffoldLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_scaffold_layer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_scaffold_layer_scale(s : BioseqassemblyscaffoldLayer, f : Double) -> BioseqassemblyscaffoldLayer {
  let result = bio_seq_assembly_scaffold_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_scaffold_layer_add(a : BioseqassemblyscaffoldLayer, b : BioseqassemblyscaffoldLayer) -> BioseqassemblyscaffoldLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_scaffold_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_layer_copy(s : BioseqassemblyscaffoldLayer) -> BioseqassemblyscaffoldLayer {
  let result = bio_seq_assembly_scaffold_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_layer_fill(s : BioseqassemblyscaffoldLayer, v : Double) -> BioseqassemblyscaffoldLayer {
  let result = bio_seq_assembly_scaffold_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_layer_min(s : BioseqassemblyscaffoldLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_layer_max(s : BioseqassemblyscaffoldLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_layer_to_string(s : BioseqassemblyscaffoldLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_buffer_make(size : Int) -> BioseqassemblyscaffoldBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_buffer_len(s : BioseqassemblyscaffoldBuffer) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_buffer_get(s : BioseqassemblyscaffoldBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_buffer_set(s : BioseqassemblyscaffoldBuffer, i : Int, v : Double) -> BioseqassemblyscaffoldBuffer {
  let result = bio_seq_assembly_scaffold_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_buffer_sum(s : BioseqassemblyscaffoldBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_scaffold_buffer_mean(s : BioseqassemblyscaffoldBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_scaffold_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_scaffold_buffer_scale(s : BioseqassemblyscaffoldBuffer, f : Double) -> BioseqassemblyscaffoldBuffer {
  let result = bio_seq_assembly_scaffold_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_scaffold_buffer_add(a : BioseqassemblyscaffoldBuffer, b : BioseqassemblyscaffoldBuffer) -> BioseqassemblyscaffoldBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_scaffold_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_buffer_copy(s : BioseqassemblyscaffoldBuffer) -> BioseqassemblyscaffoldBuffer {
  let result = bio_seq_assembly_scaffold_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_buffer_fill(s : BioseqassemblyscaffoldBuffer, v : Double) -> BioseqassemblyscaffoldBuffer {
  let result = bio_seq_assembly_scaffold_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_buffer_min(s : BioseqassemblyscaffoldBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_buffer_max(s : BioseqassemblyscaffoldBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_buffer_to_string(s : BioseqassemblyscaffoldBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_cursor_make(size : Int) -> BioseqassemblyscaffoldCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_cursor_len(s : BioseqassemblyscaffoldCursor) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_cursor_get(s : BioseqassemblyscaffoldCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_cursor_set(s : BioseqassemblyscaffoldCursor, i : Int, v : Double) -> BioseqassemblyscaffoldCursor {
  let result = bio_seq_assembly_scaffold_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_cursor_sum(s : BioseqassemblyscaffoldCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_scaffold_cursor_mean(s : BioseqassemblyscaffoldCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_scaffold_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_scaffold_cursor_scale(s : BioseqassemblyscaffoldCursor, f : Double) -> BioseqassemblyscaffoldCursor {
  let result = bio_seq_assembly_scaffold_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_scaffold_cursor_add(a : BioseqassemblyscaffoldCursor, b : BioseqassemblyscaffoldCursor) -> BioseqassemblyscaffoldCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_scaffold_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_cursor_copy(s : BioseqassemblyscaffoldCursor) -> BioseqassemblyscaffoldCursor {
  let result = bio_seq_assembly_scaffold_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_cursor_fill(s : BioseqassemblyscaffoldCursor, v : Double) -> BioseqassemblyscaffoldCursor {
  let result = bio_seq_assembly_scaffold_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_cursor_min(s : BioseqassemblyscaffoldCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_cursor_max(s : BioseqassemblyscaffoldCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_cursor_to_string(s : BioseqassemblyscaffoldCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_view_make(size : Int) -> BioseqassemblyscaffoldView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_view_len(s : BioseqassemblyscaffoldView) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_view_get(s : BioseqassemblyscaffoldView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_view_set(s : BioseqassemblyscaffoldView, i : Int, v : Double) -> BioseqassemblyscaffoldView {
  let result = bio_seq_assembly_scaffold_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_view_sum(s : BioseqassemblyscaffoldView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_scaffold_view_mean(s : BioseqassemblyscaffoldView) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_scaffold_view_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_scaffold_view_scale(s : BioseqassemblyscaffoldView, f : Double) -> BioseqassemblyscaffoldView {
  let result = bio_seq_assembly_scaffold_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_scaffold_view_add(a : BioseqassemblyscaffoldView, b : BioseqassemblyscaffoldView) -> BioseqassemblyscaffoldView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_scaffold_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_view_copy(s : BioseqassemblyscaffoldView) -> BioseqassemblyscaffoldView {
  let result = bio_seq_assembly_scaffold_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_view_fill(s : BioseqassemblyscaffoldView, v : Double) -> BioseqassemblyscaffoldView {
  let result = bio_seq_assembly_scaffold_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_view_min(s : BioseqassemblyscaffoldView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_view_max(s : BioseqassemblyscaffoldView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_view_to_string(s : BioseqassemblyscaffoldView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_range_make(size : Int) -> BioseqassemblyscaffoldRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_range_len(s : BioseqassemblyscaffoldRange) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_range_get(s : BioseqassemblyscaffoldRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_range_set(s : BioseqassemblyscaffoldRange, i : Int, v : Double) -> BioseqassemblyscaffoldRange {
  let result = bio_seq_assembly_scaffold_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_range_sum(s : BioseqassemblyscaffoldRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_scaffold_range_mean(s : BioseqassemblyscaffoldRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_scaffold_range_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_scaffold_range_scale(s : BioseqassemblyscaffoldRange, f : Double) -> BioseqassemblyscaffoldRange {
  let result = bio_seq_assembly_scaffold_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_scaffold_range_add(a : BioseqassemblyscaffoldRange, b : BioseqassemblyscaffoldRange) -> BioseqassemblyscaffoldRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_scaffold_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_range_copy(s : BioseqassemblyscaffoldRange) -> BioseqassemblyscaffoldRange {
  let result = bio_seq_assembly_scaffold_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_range_fill(s : BioseqassemblyscaffoldRange, v : Double) -> BioseqassemblyscaffoldRange {
  let result = bio_seq_assembly_scaffold_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_range_min(s : BioseqassemblyscaffoldRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_range_max(s : BioseqassemblyscaffoldRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_range_to_string(s : BioseqassemblyscaffoldRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_slice_make(size : Int) -> BioseqassemblyscaffoldSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_scaffold_slice_len(s : BioseqassemblyscaffoldSlice) -> Int { s.size }

pub fn bio_seq_assembly_scaffold_slice_get(s : BioseqassemblyscaffoldSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_scaffold_slice_set(s : BioseqassemblyscaffoldSlice, i : Int, v : Double) -> BioseqassemblyscaffoldSlice {
  let result = bio_seq_assembly_scaffold_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_slice_sum(s : BioseqassemblyscaffoldSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_scaffold_slice_mean(s : BioseqassemblyscaffoldSlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_scaffold_slice_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_scaffold_slice_scale(s : BioseqassemblyscaffoldSlice, f : Double) -> BioseqassemblyscaffoldSlice {
  let result = bio_seq_assembly_scaffold_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_scaffold_slice_add(a : BioseqassemblyscaffoldSlice, b : BioseqassemblyscaffoldSlice) -> BioseqassemblyscaffoldSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_scaffold_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_slice_copy(s : BioseqassemblyscaffoldSlice) -> BioseqassemblyscaffoldSlice {
  let result = bio_seq_assembly_scaffold_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_scaffold_slice_fill(s : BioseqassemblyscaffoldSlice, v : Double) -> BioseqassemblyscaffoldSlice {
  let result = bio_seq_assembly_scaffold_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_scaffold_slice_min(s : BioseqassemblyscaffoldSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_slice_max(s : BioseqassemblyscaffoldSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_scaffold_slice_to_string(s : BioseqassemblyscaffoldSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

