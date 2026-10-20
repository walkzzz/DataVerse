///===
/// extcore/chem_desc_fingerprint

pub(all) struct ChemdescfingerprintPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_fingerprint_make_point(x : Double, y : Double) -> ChemdescfingerprintPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_fingerprint_make_point3(x : Double, y : Double, z : Double) -> ChemdescfingerprintPoint {
  { x, y, z, label: 0 }
}

pub fn chem_desc_fingerprint_point_x(pt : ChemdescfingerprintPoint) -> Double { pt.x }

pub fn chem_desc_fingerprint_point_y(pt : ChemdescfingerprintPoint) -> Double { pt.y }

pub fn chem_desc_fingerprint_point_z(pt : ChemdescfingerprintPoint) -> Double { pt.z }

pub fn chem_desc_fingerprint_point_label(pt : ChemdescfingerprintPoint) -> Int { pt.label }

pub fn chem_desc_fingerprint_point_dist(a : ChemdescfingerprintPoint, b : ChemdescfingerprintPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_desc_fingerprint_point_add(a : ChemdescfingerprintPoint, b : ChemdescfingerprintPoint) -> ChemdescfingerprintPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_desc_fingerprint_point_sub(a : ChemdescfingerprintPoint, b : ChemdescfingerprintPoint) -> ChemdescfingerprintPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_desc_fingerprint_point_scale(pt : ChemdescfingerprintPoint, s : Double) -> ChemdescfingerprintPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_desc_fingerprint_point_dot(a : ChemdescfingerprintPoint, b : ChemdescfingerprintPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_desc_fingerprint_point_cross(a : ChemdescfingerprintPoint, b : ChemdescfingerprintPoint) -> ChemdescfingerprintPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_desc_fingerprint_point_norm(pt : ChemdescfingerprintPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_desc_fingerprint_point_normalize(pt : ChemdescfingerprintPoint) -> ChemdescfingerprintPoint {
  let n = chem_desc_fingerprint_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_desc_fingerprint_point_scale(pt, 1.0 / n) }
}

pub fn chem_desc_fingerprint_point_negate(pt : ChemdescfingerprintPoint) -> ChemdescfingerprintPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_desc_fingerprint_point_mid(a : ChemdescfingerprintPoint, b : ChemdescfingerprintPoint) -> ChemdescfingerprintPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_desc_fingerprint_point_lerp(a : ChemdescfingerprintPoint, b : ChemdescfingerprintPoint, t : Double) -> ChemdescfingerprintPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_desc_fingerprint_point_to_string(pt : ChemdescfingerprintPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemdescfingerprintSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_fingerprint_make_series(vals : Array[Double], name : String) -> ChemdescfingerprintSeries {
  { vals, name, meta: 0 }
}

pub fn chem_desc_fingerprint_series_len(s : ChemdescfingerprintSeries) -> Int { s.vals.length() }

pub fn chem_desc_fingerprint_series_sum(s : ChemdescfingerprintSeries) -> Double { @_common.sum(s.vals) }

pub fn chem_desc_fingerprint_series_mean(s : ChemdescfingerprintSeries) -> Double { @_common.mean(s.vals) }

pub fn chem_desc_fingerprint_series_min(s : ChemdescfingerprintSeries) -> Double { @_common.min(s.vals) }

pub fn chem_desc_fingerprint_series_max(s : ChemdescfingerprintSeries) -> Double { @_common.max(s.vals) }

pub fn chem_desc_fingerprint_series_range(s : ChemdescfingerprintSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn chem_desc_fingerprint_series_var(s : ChemdescfingerprintSeries) -> Double { @_common.variance(s.vals) }

pub fn chem_desc_fingerprint_series_std(s : ChemdescfingerprintSeries) -> Double { @_common.std(s.vals) }

pub fn chem_desc_fingerprint_series_median(s : ChemdescfingerprintSeries) -> Double { @_common.median(s.vals) }

pub fn chem_desc_fingerprint_series_scale(s : ChemdescfingerprintSeries, f : Double) -> ChemdescfingerprintSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_desc_fingerprint_series_add(a : ChemdescfingerprintSeries, b : ChemdescfingerprintSeries) -> ChemdescfingerprintSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_desc_fingerprint_series_sub(a : ChemdescfingerprintSeries, b : ChemdescfingerprintSeries) -> ChemdescfingerprintSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_desc_fingerprint_series_normalize(s : ChemdescfingerprintSeries) -> ChemdescfingerprintSeries {
  let mn = chem_desc_fingerprint_series_min(s)
  let mx = chem_desc_fingerprint_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_desc_fingerprint_series_cumsum(s : ChemdescfingerprintSeries) -> ChemdescfingerprintSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_desc_fingerprint_series_to_string(s : ChemdescfingerprintSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescfingerprintMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_fingerprint_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdescfingerprintMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_desc_fingerprint_matrix_identity(n : Int) -> ChemdescfingerprintMatrix {
  let m = chem_desc_fingerprint_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_desc_fingerprint_matrix_get(m : ChemdescfingerprintMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_desc_fingerprint_matrix_transpose(m : ChemdescfingerprintMatrix) -> ChemdescfingerprintMatrix {
  let result = chem_desc_fingerprint_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_desc_fingerprint_matrix_add(a : ChemdescfingerprintMatrix, b : ChemdescfingerprintMatrix) -> ChemdescfingerprintMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_desc_fingerprint_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_desc_fingerprint_matrix_scale(m : ChemdescfingerprintMatrix, s : Double) -> ChemdescfingerprintMatrix {
  let result = chem_desc_fingerprint_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_desc_fingerprint_matrix_multiply(a : ChemdescfingerprintMatrix, b : ChemdescfingerprintMatrix) -> ChemdescfingerprintMatrix {
  if a.cols != b.rows { return chem_desc_fingerprint_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_desc_fingerprint_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_desc_fingerprint_matrix_trace(m : ChemdescfingerprintMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_desc_fingerprint_matrix_det(m : ChemdescfingerprintMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_desc_fingerprint_matrix_norm(m : ChemdescfingerprintMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_desc_fingerprint_matrix_to_string(m : ChemdescfingerprintMatrix) -> String {
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

pub(all) struct ChemdescfingerprintVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_fingerprint_make_vector(comps : Array[Double]) -> ChemdescfingerprintVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_fingerprint_vector_zero(dim : Int) -> ChemdescfingerprintVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_desc_fingerprint_vector_add(a : ChemdescfingerprintVector, b : ChemdescfingerprintVector) -> ChemdescfingerprintVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_desc_fingerprint_vector_sub(a : ChemdescfingerprintVector, b : ChemdescfingerprintVector) -> ChemdescfingerprintVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_desc_fingerprint_vector_scale(v : ChemdescfingerprintVector, s : Double) -> ChemdescfingerprintVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_desc_fingerprint_vector_dot(a : ChemdescfingerprintVector, b : ChemdescfingerprintVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_desc_fingerprint_vector_norm(v : ChemdescfingerprintVector) -> Double { @_common.sqrt(chem_desc_fingerprint_vector_dot(v, v)) }

pub fn chem_desc_fingerprint_vector_normalize(v : ChemdescfingerprintVector) -> ChemdescfingerprintVector {
  let n = chem_desc_fingerprint_vector_norm(v)
  if n < 0.0000001 { v } else { chem_desc_fingerprint_vector_scale(v, 1.0 / n) }
}

pub fn chem_desc_fingerprint_vector_dist(a : ChemdescfingerprintVector, b : ChemdescfingerprintVector) -> Double {
  chem_desc_fingerprint_vector_norm(chem_desc_fingerprint_vector_sub(a, b))
}

pub fn chem_desc_fingerprint_vector_to_string(v : ChemdescfingerprintVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_desc_fingerprint_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_desc_fingerprint_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_desc_fingerprint_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_desc_fingerprint_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_desc_fingerprint_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_desc_fingerprint_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_desc_fingerprint_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_desc_fingerprint_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_desc_fingerprint_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_desc_fingerprint_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_desc_fingerprint_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_desc_fingerprint_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_desc_fingerprint_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_desc_fingerprint_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_desc_fingerprint_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_desc_fingerprint_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_desc_fingerprint_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_desc_fingerprint_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_desc_fingerprint_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_desc_fingerprint_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_desc_fingerprint_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_desc_fingerprint_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_desc_fingerprint_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_desc_fingerprint_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_desc_fingerprint_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_desc_fingerprint_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_desc_fingerprint_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_desc_fingerprint_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_desc_fingerprint_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemdescfingerprintFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_frame_make(size : Int) -> ChemdescfingerprintFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_frame_len(s : ChemdescfingerprintFrame) -> Int { s.size }

pub fn chem_desc_fingerprint_frame_get(s : ChemdescfingerprintFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_frame_set(s : ChemdescfingerprintFrame, i : Int, v : Double) -> ChemdescfingerprintFrame {
  let result = chem_desc_fingerprint_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_frame_sum(s : ChemdescfingerprintFrame) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_frame_mean(s : ChemdescfingerprintFrame) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_frame_scale(s : ChemdescfingerprintFrame, f : Double) -> ChemdescfingerprintFrame {
  let result = chem_desc_fingerprint_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fingerprint_frame_add(a : ChemdescfingerprintFrame, b : ChemdescfingerprintFrame) -> ChemdescfingerprintFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fingerprint_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fingerprint_frame_copy(s : ChemdescfingerprintFrame) -> ChemdescfingerprintFrame {
  let result = chem_desc_fingerprint_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fingerprint_frame_fill(s : ChemdescfingerprintFrame, v : Double) -> ChemdescfingerprintFrame {
  let result = chem_desc_fingerprint_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_frame_min(s : ChemdescfingerprintFrame) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_frame_max(s : ChemdescfingerprintFrame) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_frame_to_string(s : ChemdescfingerprintFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_table_make(size : Int) -> ChemdescfingerprintTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_table_len(s : ChemdescfingerprintTable) -> Int { s.size }

pub fn chem_desc_fingerprint_table_get(s : ChemdescfingerprintTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_table_set(s : ChemdescfingerprintTable, i : Int, v : Double) -> ChemdescfingerprintTable {
  let result = chem_desc_fingerprint_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_table_sum(s : ChemdescfingerprintTable) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_table_mean(s : ChemdescfingerprintTable) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_table_scale(s : ChemdescfingerprintTable, f : Double) -> ChemdescfingerprintTable {
  let result = chem_desc_fingerprint_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fingerprint_table_add(a : ChemdescfingerprintTable, b : ChemdescfingerprintTable) -> ChemdescfingerprintTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fingerprint_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fingerprint_table_copy(s : ChemdescfingerprintTable) -> ChemdescfingerprintTable {
  let result = chem_desc_fingerprint_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fingerprint_table_fill(s : ChemdescfingerprintTable, v : Double) -> ChemdescfingerprintTable {
  let result = chem_desc_fingerprint_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_table_min(s : ChemdescfingerprintTable) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_table_max(s : ChemdescfingerprintTable) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_table_to_string(s : ChemdescfingerprintTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_graphn_make(size : Int) -> ChemdescfingerprintGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_graphn_len(s : ChemdescfingerprintGraphN) -> Int { s.size }

pub fn chem_desc_fingerprint_graphn_get(s : ChemdescfingerprintGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_graphn_set(s : ChemdescfingerprintGraphN, i : Int, v : Double) -> ChemdescfingerprintGraphN {
  let result = chem_desc_fingerprint_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_graphn_sum(s : ChemdescfingerprintGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_graphn_mean(s : ChemdescfingerprintGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_graphn_scale(s : ChemdescfingerprintGraphN, f : Double) -> ChemdescfingerprintGraphN {
  let result = chem_desc_fingerprint_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fingerprint_graphn_add(a : ChemdescfingerprintGraphN, b : ChemdescfingerprintGraphN) -> ChemdescfingerprintGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fingerprint_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fingerprint_graphn_copy(s : ChemdescfingerprintGraphN) -> ChemdescfingerprintGraphN {
  let result = chem_desc_fingerprint_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fingerprint_graphn_fill(s : ChemdescfingerprintGraphN, v : Double) -> ChemdescfingerprintGraphN {
  let result = chem_desc_fingerprint_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_graphn_min(s : ChemdescfingerprintGraphN) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_graphn_max(s : ChemdescfingerprintGraphN) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_graphn_to_string(s : ChemdescfingerprintGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_node_make(size : Int) -> ChemdescfingerprintNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_node_len(s : ChemdescfingerprintNode) -> Int { s.size }

pub fn chem_desc_fingerprint_node_get(s : ChemdescfingerprintNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_node_set(s : ChemdescfingerprintNode, i : Int, v : Double) -> ChemdescfingerprintNode {
  let result = chem_desc_fingerprint_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_node_sum(s : ChemdescfingerprintNode) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_node_mean(s : ChemdescfingerprintNode) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_node_scale(s : ChemdescfingerprintNode, f : Double) -> ChemdescfingerprintNode {
  let result = chem_desc_fingerprint_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fingerprint_node_add(a : ChemdescfingerprintNode, b : ChemdescfingerprintNode) -> ChemdescfingerprintNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fingerprint_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fingerprint_node_copy(s : ChemdescfingerprintNode) -> ChemdescfingerprintNode {
  let result = chem_desc_fingerprint_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fingerprint_node_fill(s : ChemdescfingerprintNode, v : Double) -> ChemdescfingerprintNode {
  let result = chem_desc_fingerprint_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_node_min(s : ChemdescfingerprintNode) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_node_max(s : ChemdescfingerprintNode) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_node_to_string(s : ChemdescfingerprintNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_edge_make(size : Int) -> ChemdescfingerprintEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_edge_len(s : ChemdescfingerprintEdge) -> Int { s.size }

pub fn chem_desc_fingerprint_edge_get(s : ChemdescfingerprintEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_edge_set(s : ChemdescfingerprintEdge, i : Int, v : Double) -> ChemdescfingerprintEdge {
  let result = chem_desc_fingerprint_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_edge_sum(s : ChemdescfingerprintEdge) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_edge_mean(s : ChemdescfingerprintEdge) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_edge_scale(s : ChemdescfingerprintEdge, f : Double) -> ChemdescfingerprintEdge {
  let result = chem_desc_fingerprint_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fingerprint_edge_add(a : ChemdescfingerprintEdge, b : ChemdescfingerprintEdge) -> ChemdescfingerprintEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fingerprint_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fingerprint_edge_copy(s : ChemdescfingerprintEdge) -> ChemdescfingerprintEdge {
  let result = chem_desc_fingerprint_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fingerprint_edge_fill(s : ChemdescfingerprintEdge, v : Double) -> ChemdescfingerprintEdge {
  let result = chem_desc_fingerprint_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_edge_min(s : ChemdescfingerprintEdge) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_edge_max(s : ChemdescfingerprintEdge) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_edge_to_string(s : ChemdescfingerprintEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_path_make(size : Int) -> ChemdescfingerprintPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_path_len(s : ChemdescfingerprintPath) -> Int { s.size }

pub fn chem_desc_fingerprint_path_get(s : ChemdescfingerprintPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_path_set(s : ChemdescfingerprintPath, i : Int, v : Double) -> ChemdescfingerprintPath {
  let result = chem_desc_fingerprint_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_path_sum(s : ChemdescfingerprintPath) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_path_mean(s : ChemdescfingerprintPath) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_path_scale(s : ChemdescfingerprintPath, f : Double) -> ChemdescfingerprintPath {
  let result = chem_desc_fingerprint_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fingerprint_path_add(a : ChemdescfingerprintPath, b : ChemdescfingerprintPath) -> ChemdescfingerprintPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fingerprint_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fingerprint_path_copy(s : ChemdescfingerprintPath) -> ChemdescfingerprintPath {
  let result = chem_desc_fingerprint_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fingerprint_path_fill(s : ChemdescfingerprintPath, v : Double) -> ChemdescfingerprintPath {
  let result = chem_desc_fingerprint_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_path_min(s : ChemdescfingerprintPath) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_path_max(s : ChemdescfingerprintPath) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_path_to_string(s : ChemdescfingerprintPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_cluster_make(size : Int) -> ChemdescfingerprintCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_cluster_len(s : ChemdescfingerprintCluster) -> Int { s.size }

pub fn chem_desc_fingerprint_cluster_get(s : ChemdescfingerprintCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_cluster_set(s : ChemdescfingerprintCluster, i : Int, v : Double) -> ChemdescfingerprintCluster {
  let result = chem_desc_fingerprint_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_cluster_sum(s : ChemdescfingerprintCluster) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_cluster_mean(s : ChemdescfingerprintCluster) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_cluster_scale(s : ChemdescfingerprintCluster, f : Double) -> ChemdescfingerprintCluster {
  let result = chem_desc_fingerprint_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fingerprint_cluster_add(a : ChemdescfingerprintCluster, b : ChemdescfingerprintCluster) -> ChemdescfingerprintCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fingerprint_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fingerprint_cluster_copy(s : ChemdescfingerprintCluster) -> ChemdescfingerprintCluster {
  let result = chem_desc_fingerprint_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fingerprint_cluster_fill(s : ChemdescfingerprintCluster, v : Double) -> ChemdescfingerprintCluster {
  let result = chem_desc_fingerprint_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_cluster_min(s : ChemdescfingerprintCluster) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_cluster_max(s : ChemdescfingerprintCluster) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_cluster_to_string(s : ChemdescfingerprintCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_model_make(size : Int) -> ChemdescfingerprintModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_model_len(s : ChemdescfingerprintModel) -> Int { s.size }

pub fn chem_desc_fingerprint_model_get(s : ChemdescfingerprintModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_model_set(s : ChemdescfingerprintModel, i : Int, v : Double) -> ChemdescfingerprintModel {
  let result = chem_desc_fingerprint_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_model_sum(s : ChemdescfingerprintModel) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_model_mean(s : ChemdescfingerprintModel) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_model_scale(s : ChemdescfingerprintModel, f : Double) -> ChemdescfingerprintModel {
  let result = chem_desc_fingerprint_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fingerprint_model_add(a : ChemdescfingerprintModel, b : ChemdescfingerprintModel) -> ChemdescfingerprintModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fingerprint_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fingerprint_model_copy(s : ChemdescfingerprintModel) -> ChemdescfingerprintModel {
  let result = chem_desc_fingerprint_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fingerprint_model_fill(s : ChemdescfingerprintModel, v : Double) -> ChemdescfingerprintModel {
  let result = chem_desc_fingerprint_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_model_min(s : ChemdescfingerprintModel) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_model_max(s : ChemdescfingerprintModel) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_model_to_string(s : ChemdescfingerprintModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_layer_make(size : Int) -> ChemdescfingerprintLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_layer_len(s : ChemdescfingerprintLayer) -> Int { s.size }

pub fn chem_desc_fingerprint_layer_get(s : ChemdescfingerprintLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_layer_set(s : ChemdescfingerprintLayer, i : Int, v : Double) -> ChemdescfingerprintLayer {
  let result = chem_desc_fingerprint_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_layer_sum(s : ChemdescfingerprintLayer) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_layer_mean(s : ChemdescfingerprintLayer) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_layer_scale(s : ChemdescfingerprintLayer, f : Double) -> ChemdescfingerprintLayer {
  let result = chem_desc_fingerprint_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fingerprint_layer_add(a : ChemdescfingerprintLayer, b : ChemdescfingerprintLayer) -> ChemdescfingerprintLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fingerprint_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fingerprint_layer_copy(s : ChemdescfingerprintLayer) -> ChemdescfingerprintLayer {
  let result = chem_desc_fingerprint_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fingerprint_layer_fill(s : ChemdescfingerprintLayer, v : Double) -> ChemdescfingerprintLayer {
  let result = chem_desc_fingerprint_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_layer_min(s : ChemdescfingerprintLayer) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_layer_max(s : ChemdescfingerprintLayer) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_layer_to_string(s : ChemdescfingerprintLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_buffer_make(size : Int) -> ChemdescfingerprintBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_buffer_len(s : ChemdescfingerprintBuffer) -> Int { s.size }

pub fn chem_desc_fingerprint_buffer_get(s : ChemdescfingerprintBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_buffer_set(s : ChemdescfingerprintBuffer, i : Int, v : Double) -> ChemdescfingerprintBuffer {
  let result = chem_desc_fingerprint_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_buffer_sum(s : ChemdescfingerprintBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_buffer_mean(s : ChemdescfingerprintBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_buffer_scale(s : ChemdescfingerprintBuffer, f : Double) -> ChemdescfingerprintBuffer {
  let result = chem_desc_fingerprint_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fingerprint_buffer_add(a : ChemdescfingerprintBuffer, b : ChemdescfingerprintBuffer) -> ChemdescfingerprintBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fingerprint_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fingerprint_buffer_copy(s : ChemdescfingerprintBuffer) -> ChemdescfingerprintBuffer {
  let result = chem_desc_fingerprint_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fingerprint_buffer_fill(s : ChemdescfingerprintBuffer, v : Double) -> ChemdescfingerprintBuffer {
  let result = chem_desc_fingerprint_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_buffer_min(s : ChemdescfingerprintBuffer) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_buffer_max(s : ChemdescfingerprintBuffer) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_buffer_to_string(s : ChemdescfingerprintBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_cursor_make(size : Int) -> ChemdescfingerprintCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_cursor_len(s : ChemdescfingerprintCursor) -> Int { s.size }

pub fn chem_desc_fingerprint_cursor_get(s : ChemdescfingerprintCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_cursor_set(s : ChemdescfingerprintCursor, i : Int, v : Double) -> ChemdescfingerprintCursor {
  let result = chem_desc_fingerprint_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_cursor_sum(s : ChemdescfingerprintCursor) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_cursor_mean(s : ChemdescfingerprintCursor) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_cursor_scale(s : ChemdescfingerprintCursor, f : Double) -> ChemdescfingerprintCursor {
  let result = chem_desc_fingerprint_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fingerprint_cursor_add(a : ChemdescfingerprintCursor, b : ChemdescfingerprintCursor) -> ChemdescfingerprintCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fingerprint_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fingerprint_cursor_copy(s : ChemdescfingerprintCursor) -> ChemdescfingerprintCursor {
  let result = chem_desc_fingerprint_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fingerprint_cursor_fill(s : ChemdescfingerprintCursor, v : Double) -> ChemdescfingerprintCursor {
  let result = chem_desc_fingerprint_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_cursor_min(s : ChemdescfingerprintCursor) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_cursor_max(s : ChemdescfingerprintCursor) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_cursor_to_string(s : ChemdescfingerprintCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_view_make(size : Int) -> ChemdescfingerprintView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_view_len(s : ChemdescfingerprintView) -> Int { s.size }

pub fn chem_desc_fingerprint_view_get(s : ChemdescfingerprintView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_view_set(s : ChemdescfingerprintView, i : Int, v : Double) -> ChemdescfingerprintView {
  let result = chem_desc_fingerprint_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_view_sum(s : ChemdescfingerprintView) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_view_mean(s : ChemdescfingerprintView) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_view_scale(s : ChemdescfingerprintView, f : Double) -> ChemdescfingerprintView {
  let result = chem_desc_fingerprint_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fingerprint_view_add(a : ChemdescfingerprintView, b : ChemdescfingerprintView) -> ChemdescfingerprintView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fingerprint_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fingerprint_view_copy(s : ChemdescfingerprintView) -> ChemdescfingerprintView {
  let result = chem_desc_fingerprint_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fingerprint_view_fill(s : ChemdescfingerprintView, v : Double) -> ChemdescfingerprintView {
  let result = chem_desc_fingerprint_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_view_min(s : ChemdescfingerprintView) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_view_max(s : ChemdescfingerprintView) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_view_to_string(s : ChemdescfingerprintView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_range_make(size : Int) -> ChemdescfingerprintRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_range_len(s : ChemdescfingerprintRange) -> Int { s.size }

pub fn chem_desc_fingerprint_range_get(s : ChemdescfingerprintRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_range_set(s : ChemdescfingerprintRange, i : Int, v : Double) -> ChemdescfingerprintRange {
  let result = chem_desc_fingerprint_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_range_sum(s : ChemdescfingerprintRange) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_range_mean(s : ChemdescfingerprintRange) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_range_scale(s : ChemdescfingerprintRange, f : Double) -> ChemdescfingerprintRange {
  let result = chem_desc_fingerprint_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fingerprint_range_add(a : ChemdescfingerprintRange, b : ChemdescfingerprintRange) -> ChemdescfingerprintRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fingerprint_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fingerprint_range_copy(s : ChemdescfingerprintRange) -> ChemdescfingerprintRange {
  let result = chem_desc_fingerprint_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fingerprint_range_fill(s : ChemdescfingerprintRange, v : Double) -> ChemdescfingerprintRange {
  let result = chem_desc_fingerprint_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_range_min(s : ChemdescfingerprintRange) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_range_max(s : ChemdescfingerprintRange) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_range_to_string(s : ChemdescfingerprintRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_slice_make(size : Int) -> ChemdescfingerprintSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_slice_len(s : ChemdescfingerprintSlice) -> Int { s.size }

pub fn chem_desc_fingerprint_slice_get(s : ChemdescfingerprintSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_slice_set(s : ChemdescfingerprintSlice, i : Int, v : Double) -> ChemdescfingerprintSlice {
  let result = chem_desc_fingerprint_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_slice_sum(s : ChemdescfingerprintSlice) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_slice_mean(s : ChemdescfingerprintSlice) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_slice_scale(s : ChemdescfingerprintSlice, f : Double) -> ChemdescfingerprintSlice {
  let result = chem_desc_fingerprint_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fingerprint_slice_add(a : ChemdescfingerprintSlice, b : ChemdescfingerprintSlice) -> ChemdescfingerprintSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fingerprint_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fingerprint_slice_copy(s : ChemdescfingerprintSlice) -> ChemdescfingerprintSlice {
  let result = chem_desc_fingerprint_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fingerprint_slice_fill(s : ChemdescfingerprintSlice, v : Double) -> ChemdescfingerprintSlice {
  let result = chem_desc_fingerprint_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fingerprint_slice_min(s : ChemdescfingerprintSlice) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_slice_max(s : ChemdescfingerprintSlice) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_slice_to_string(s : ChemdescfingerprintSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

