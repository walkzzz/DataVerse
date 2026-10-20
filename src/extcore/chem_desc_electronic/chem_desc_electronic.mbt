///===
/// extcore/chem_desc_electronic

pub(all) struct ChemdescelectronicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_electronic_make_point(x : Double, y : Double) -> ChemdescelectronicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_electronic_make_point3(x : Double, y : Double, z : Double) -> ChemdescelectronicPoint {
  { x, y, z, label: 0 }
}

pub fn chem_desc_electronic_point_x(pt : ChemdescelectronicPoint) -> Double { pt.x }

pub fn chem_desc_electronic_point_y(pt : ChemdescelectronicPoint) -> Double { pt.y }

pub fn chem_desc_electronic_point_z(pt : ChemdescelectronicPoint) -> Double { pt.z }

pub fn chem_desc_electronic_point_label(pt : ChemdescelectronicPoint) -> Int { pt.label }

pub fn chem_desc_electronic_point_dist(a : ChemdescelectronicPoint, b : ChemdescelectronicPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_desc_electronic_point_add(a : ChemdescelectronicPoint, b : ChemdescelectronicPoint) -> ChemdescelectronicPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_desc_electronic_point_sub(a : ChemdescelectronicPoint, b : ChemdescelectronicPoint) -> ChemdescelectronicPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_desc_electronic_point_scale(pt : ChemdescelectronicPoint, s : Double) -> ChemdescelectronicPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_desc_electronic_point_dot(a : ChemdescelectronicPoint, b : ChemdescelectronicPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_desc_electronic_point_cross(a : ChemdescelectronicPoint, b : ChemdescelectronicPoint) -> ChemdescelectronicPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_desc_electronic_point_norm(pt : ChemdescelectronicPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_desc_electronic_point_normalize(pt : ChemdescelectronicPoint) -> ChemdescelectronicPoint {
  let n = chem_desc_electronic_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_desc_electronic_point_scale(pt, 1.0 / n) }
}

pub fn chem_desc_electronic_point_negate(pt : ChemdescelectronicPoint) -> ChemdescelectronicPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_desc_electronic_point_mid(a : ChemdescelectronicPoint, b : ChemdescelectronicPoint) -> ChemdescelectronicPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_desc_electronic_point_lerp(a : ChemdescelectronicPoint, b : ChemdescelectronicPoint, t : Double) -> ChemdescelectronicPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_desc_electronic_point_to_string(pt : ChemdescelectronicPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemdescelectronicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_electronic_make_series(vals : Array[Double], name : String) -> ChemdescelectronicSeries {
  { vals, name, meta: 0 }
}

pub fn chem_desc_electronic_series_len(s : ChemdescelectronicSeries) -> Int { s.vals.length() }

pub fn chem_desc_electronic_series_sum(s : ChemdescelectronicSeries) -> Double { @_common.sum(s.vals) }

pub fn chem_desc_electronic_series_mean(s : ChemdescelectronicSeries) -> Double { @_common.mean(s.vals) }

pub fn chem_desc_electronic_series_min(s : ChemdescelectronicSeries) -> Double { @_common.min(s.vals) }

pub fn chem_desc_electronic_series_max(s : ChemdescelectronicSeries) -> Double { @_common.max(s.vals) }

pub fn chem_desc_electronic_series_range(s : ChemdescelectronicSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn chem_desc_electronic_series_var(s : ChemdescelectronicSeries) -> Double { @_common.variance(s.vals) }

pub fn chem_desc_electronic_series_std(s : ChemdescelectronicSeries) -> Double { @_common.std(s.vals) }

pub fn chem_desc_electronic_series_median(s : ChemdescelectronicSeries) -> Double { @_common.median(s.vals) }

pub fn chem_desc_electronic_series_scale(s : ChemdescelectronicSeries, f : Double) -> ChemdescelectronicSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_desc_electronic_series_add(a : ChemdescelectronicSeries, b : ChemdescelectronicSeries) -> ChemdescelectronicSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_desc_electronic_series_sub(a : ChemdescelectronicSeries, b : ChemdescelectronicSeries) -> ChemdescelectronicSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_desc_electronic_series_normalize(s : ChemdescelectronicSeries) -> ChemdescelectronicSeries {
  let mn = chem_desc_electronic_series_min(s)
  let mx = chem_desc_electronic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_desc_electronic_series_cumsum(s : ChemdescelectronicSeries) -> ChemdescelectronicSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_desc_electronic_series_to_string(s : ChemdescelectronicSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescelectronicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_electronic_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdescelectronicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_desc_electronic_matrix_identity(n : Int) -> ChemdescelectronicMatrix {
  let m = chem_desc_electronic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_desc_electronic_matrix_get(m : ChemdescelectronicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_desc_electronic_matrix_transpose(m : ChemdescelectronicMatrix) -> ChemdescelectronicMatrix {
  let result = chem_desc_electronic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_desc_electronic_matrix_add(a : ChemdescelectronicMatrix, b : ChemdescelectronicMatrix) -> ChemdescelectronicMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_desc_electronic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_desc_electronic_matrix_scale(m : ChemdescelectronicMatrix, s : Double) -> ChemdescelectronicMatrix {
  let result = chem_desc_electronic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_desc_electronic_matrix_multiply(a : ChemdescelectronicMatrix, b : ChemdescelectronicMatrix) -> ChemdescelectronicMatrix {
  if a.cols != b.rows { return chem_desc_electronic_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_desc_electronic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_desc_electronic_matrix_trace(m : ChemdescelectronicMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_desc_electronic_matrix_det(m : ChemdescelectronicMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_desc_electronic_matrix_norm(m : ChemdescelectronicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_desc_electronic_matrix_to_string(m : ChemdescelectronicMatrix) -> String {
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

pub(all) struct ChemdescelectronicVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_electronic_make_vector(comps : Array[Double]) -> ChemdescelectronicVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_electronic_vector_zero(dim : Int) -> ChemdescelectronicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_desc_electronic_vector_add(a : ChemdescelectronicVector, b : ChemdescelectronicVector) -> ChemdescelectronicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_desc_electronic_vector_sub(a : ChemdescelectronicVector, b : ChemdescelectronicVector) -> ChemdescelectronicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_desc_electronic_vector_scale(v : ChemdescelectronicVector, s : Double) -> ChemdescelectronicVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_desc_electronic_vector_dot(a : ChemdescelectronicVector, b : ChemdescelectronicVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_desc_electronic_vector_norm(v : ChemdescelectronicVector) -> Double { @_common.sqrt(chem_desc_electronic_vector_dot(v, v)) }

pub fn chem_desc_electronic_vector_normalize(v : ChemdescelectronicVector) -> ChemdescelectronicVector {
  let n = chem_desc_electronic_vector_norm(v)
  if n < 0.0000001 { v } else { chem_desc_electronic_vector_scale(v, 1.0 / n) }
}

pub fn chem_desc_electronic_vector_dist(a : ChemdescelectronicVector, b : ChemdescelectronicVector) -> Double {
  chem_desc_electronic_vector_norm(chem_desc_electronic_vector_sub(a, b))
}

pub fn chem_desc_electronic_vector_to_string(v : ChemdescelectronicVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_desc_electronic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_desc_electronic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_desc_electronic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_desc_electronic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_desc_electronic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_desc_electronic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_desc_electronic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_desc_electronic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_desc_electronic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_desc_electronic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_desc_electronic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_desc_electronic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_desc_electronic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_desc_electronic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_desc_electronic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_desc_electronic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_desc_electronic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_desc_electronic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_desc_electronic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_desc_electronic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_desc_electronic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_desc_electronic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_desc_electronic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_desc_electronic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_desc_electronic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_desc_electronic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_desc_electronic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_desc_electronic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_desc_electronic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemdescelectronicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_frame_make(size : Int) -> ChemdescelectronicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_frame_len(s : ChemdescelectronicFrame) -> Int { s.size }

pub fn chem_desc_electronic_frame_get(s : ChemdescelectronicFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_frame_set(s : ChemdescelectronicFrame, i : Int, v : Double) -> ChemdescelectronicFrame {
  let result = chem_desc_electronic_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_frame_sum(s : ChemdescelectronicFrame) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_frame_mean(s : ChemdescelectronicFrame) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_frame_scale(s : ChemdescelectronicFrame, f : Double) -> ChemdescelectronicFrame {
  let result = chem_desc_electronic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_electronic_frame_add(a : ChemdescelectronicFrame, b : ChemdescelectronicFrame) -> ChemdescelectronicFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_electronic_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_electronic_frame_copy(s : ChemdescelectronicFrame) -> ChemdescelectronicFrame {
  let result = chem_desc_electronic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_electronic_frame_fill(s : ChemdescelectronicFrame, v : Double) -> ChemdescelectronicFrame {
  let result = chem_desc_electronic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_frame_min(s : ChemdescelectronicFrame) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_frame_max(s : ChemdescelectronicFrame) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_frame_to_string(s : ChemdescelectronicFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_table_make(size : Int) -> ChemdescelectronicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_table_len(s : ChemdescelectronicTable) -> Int { s.size }

pub fn chem_desc_electronic_table_get(s : ChemdescelectronicTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_table_set(s : ChemdescelectronicTable, i : Int, v : Double) -> ChemdescelectronicTable {
  let result = chem_desc_electronic_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_table_sum(s : ChemdescelectronicTable) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_table_mean(s : ChemdescelectronicTable) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_table_scale(s : ChemdescelectronicTable, f : Double) -> ChemdescelectronicTable {
  let result = chem_desc_electronic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_electronic_table_add(a : ChemdescelectronicTable, b : ChemdescelectronicTable) -> ChemdescelectronicTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_electronic_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_electronic_table_copy(s : ChemdescelectronicTable) -> ChemdescelectronicTable {
  let result = chem_desc_electronic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_electronic_table_fill(s : ChemdescelectronicTable, v : Double) -> ChemdescelectronicTable {
  let result = chem_desc_electronic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_table_min(s : ChemdescelectronicTable) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_table_max(s : ChemdescelectronicTable) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_table_to_string(s : ChemdescelectronicTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_graphn_make(size : Int) -> ChemdescelectronicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_graphn_len(s : ChemdescelectronicGraphN) -> Int { s.size }

pub fn chem_desc_electronic_graphn_get(s : ChemdescelectronicGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_graphn_set(s : ChemdescelectronicGraphN, i : Int, v : Double) -> ChemdescelectronicGraphN {
  let result = chem_desc_electronic_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_graphn_sum(s : ChemdescelectronicGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_graphn_mean(s : ChemdescelectronicGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_graphn_scale(s : ChemdescelectronicGraphN, f : Double) -> ChemdescelectronicGraphN {
  let result = chem_desc_electronic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_electronic_graphn_add(a : ChemdescelectronicGraphN, b : ChemdescelectronicGraphN) -> ChemdescelectronicGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_electronic_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_electronic_graphn_copy(s : ChemdescelectronicGraphN) -> ChemdescelectronicGraphN {
  let result = chem_desc_electronic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_electronic_graphn_fill(s : ChemdescelectronicGraphN, v : Double) -> ChemdescelectronicGraphN {
  let result = chem_desc_electronic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_graphn_min(s : ChemdescelectronicGraphN) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_graphn_max(s : ChemdescelectronicGraphN) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_graphn_to_string(s : ChemdescelectronicGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_node_make(size : Int) -> ChemdescelectronicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_node_len(s : ChemdescelectronicNode) -> Int { s.size }

pub fn chem_desc_electronic_node_get(s : ChemdescelectronicNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_node_set(s : ChemdescelectronicNode, i : Int, v : Double) -> ChemdescelectronicNode {
  let result = chem_desc_electronic_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_node_sum(s : ChemdescelectronicNode) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_node_mean(s : ChemdescelectronicNode) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_node_scale(s : ChemdescelectronicNode, f : Double) -> ChemdescelectronicNode {
  let result = chem_desc_electronic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_electronic_node_add(a : ChemdescelectronicNode, b : ChemdescelectronicNode) -> ChemdescelectronicNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_electronic_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_electronic_node_copy(s : ChemdescelectronicNode) -> ChemdescelectronicNode {
  let result = chem_desc_electronic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_electronic_node_fill(s : ChemdescelectronicNode, v : Double) -> ChemdescelectronicNode {
  let result = chem_desc_electronic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_node_min(s : ChemdescelectronicNode) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_node_max(s : ChemdescelectronicNode) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_node_to_string(s : ChemdescelectronicNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_edge_make(size : Int) -> ChemdescelectronicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_edge_len(s : ChemdescelectronicEdge) -> Int { s.size }

pub fn chem_desc_electronic_edge_get(s : ChemdescelectronicEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_edge_set(s : ChemdescelectronicEdge, i : Int, v : Double) -> ChemdescelectronicEdge {
  let result = chem_desc_electronic_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_edge_sum(s : ChemdescelectronicEdge) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_edge_mean(s : ChemdescelectronicEdge) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_edge_scale(s : ChemdescelectronicEdge, f : Double) -> ChemdescelectronicEdge {
  let result = chem_desc_electronic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_electronic_edge_add(a : ChemdescelectronicEdge, b : ChemdescelectronicEdge) -> ChemdescelectronicEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_electronic_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_electronic_edge_copy(s : ChemdescelectronicEdge) -> ChemdescelectronicEdge {
  let result = chem_desc_electronic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_electronic_edge_fill(s : ChemdescelectronicEdge, v : Double) -> ChemdescelectronicEdge {
  let result = chem_desc_electronic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_edge_min(s : ChemdescelectronicEdge) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_edge_max(s : ChemdescelectronicEdge) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_edge_to_string(s : ChemdescelectronicEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_path_make(size : Int) -> ChemdescelectronicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_path_len(s : ChemdescelectronicPath) -> Int { s.size }

pub fn chem_desc_electronic_path_get(s : ChemdescelectronicPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_path_set(s : ChemdescelectronicPath, i : Int, v : Double) -> ChemdescelectronicPath {
  let result = chem_desc_electronic_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_path_sum(s : ChemdescelectronicPath) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_path_mean(s : ChemdescelectronicPath) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_path_scale(s : ChemdescelectronicPath, f : Double) -> ChemdescelectronicPath {
  let result = chem_desc_electronic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_electronic_path_add(a : ChemdescelectronicPath, b : ChemdescelectronicPath) -> ChemdescelectronicPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_electronic_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_electronic_path_copy(s : ChemdescelectronicPath) -> ChemdescelectronicPath {
  let result = chem_desc_electronic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_electronic_path_fill(s : ChemdescelectronicPath, v : Double) -> ChemdescelectronicPath {
  let result = chem_desc_electronic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_path_min(s : ChemdescelectronicPath) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_path_max(s : ChemdescelectronicPath) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_path_to_string(s : ChemdescelectronicPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_cluster_make(size : Int) -> ChemdescelectronicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_cluster_len(s : ChemdescelectronicCluster) -> Int { s.size }

pub fn chem_desc_electronic_cluster_get(s : ChemdescelectronicCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_cluster_set(s : ChemdescelectronicCluster, i : Int, v : Double) -> ChemdescelectronicCluster {
  let result = chem_desc_electronic_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_cluster_sum(s : ChemdescelectronicCluster) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_cluster_mean(s : ChemdescelectronicCluster) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_cluster_scale(s : ChemdescelectronicCluster, f : Double) -> ChemdescelectronicCluster {
  let result = chem_desc_electronic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_electronic_cluster_add(a : ChemdescelectronicCluster, b : ChemdescelectronicCluster) -> ChemdescelectronicCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_electronic_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_electronic_cluster_copy(s : ChemdescelectronicCluster) -> ChemdescelectronicCluster {
  let result = chem_desc_electronic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_electronic_cluster_fill(s : ChemdescelectronicCluster, v : Double) -> ChemdescelectronicCluster {
  let result = chem_desc_electronic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_cluster_min(s : ChemdescelectronicCluster) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_cluster_max(s : ChemdescelectronicCluster) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_cluster_to_string(s : ChemdescelectronicCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_model_make(size : Int) -> ChemdescelectronicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_model_len(s : ChemdescelectronicModel) -> Int { s.size }

pub fn chem_desc_electronic_model_get(s : ChemdescelectronicModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_model_set(s : ChemdescelectronicModel, i : Int, v : Double) -> ChemdescelectronicModel {
  let result = chem_desc_electronic_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_model_sum(s : ChemdescelectronicModel) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_model_mean(s : ChemdescelectronicModel) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_model_scale(s : ChemdescelectronicModel, f : Double) -> ChemdescelectronicModel {
  let result = chem_desc_electronic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_electronic_model_add(a : ChemdescelectronicModel, b : ChemdescelectronicModel) -> ChemdescelectronicModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_electronic_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_electronic_model_copy(s : ChemdescelectronicModel) -> ChemdescelectronicModel {
  let result = chem_desc_electronic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_electronic_model_fill(s : ChemdescelectronicModel, v : Double) -> ChemdescelectronicModel {
  let result = chem_desc_electronic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_model_min(s : ChemdescelectronicModel) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_model_max(s : ChemdescelectronicModel) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_model_to_string(s : ChemdescelectronicModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_layer_make(size : Int) -> ChemdescelectronicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_layer_len(s : ChemdescelectronicLayer) -> Int { s.size }

pub fn chem_desc_electronic_layer_get(s : ChemdescelectronicLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_layer_set(s : ChemdescelectronicLayer, i : Int, v : Double) -> ChemdescelectronicLayer {
  let result = chem_desc_electronic_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_layer_sum(s : ChemdescelectronicLayer) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_layer_mean(s : ChemdescelectronicLayer) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_layer_scale(s : ChemdescelectronicLayer, f : Double) -> ChemdescelectronicLayer {
  let result = chem_desc_electronic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_electronic_layer_add(a : ChemdescelectronicLayer, b : ChemdescelectronicLayer) -> ChemdescelectronicLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_electronic_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_electronic_layer_copy(s : ChemdescelectronicLayer) -> ChemdescelectronicLayer {
  let result = chem_desc_electronic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_electronic_layer_fill(s : ChemdescelectronicLayer, v : Double) -> ChemdescelectronicLayer {
  let result = chem_desc_electronic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_layer_min(s : ChemdescelectronicLayer) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_layer_max(s : ChemdescelectronicLayer) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_layer_to_string(s : ChemdescelectronicLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_buffer_make(size : Int) -> ChemdescelectronicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_buffer_len(s : ChemdescelectronicBuffer) -> Int { s.size }

pub fn chem_desc_electronic_buffer_get(s : ChemdescelectronicBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_buffer_set(s : ChemdescelectronicBuffer, i : Int, v : Double) -> ChemdescelectronicBuffer {
  let result = chem_desc_electronic_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_buffer_sum(s : ChemdescelectronicBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_buffer_mean(s : ChemdescelectronicBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_buffer_scale(s : ChemdescelectronicBuffer, f : Double) -> ChemdescelectronicBuffer {
  let result = chem_desc_electronic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_electronic_buffer_add(a : ChemdescelectronicBuffer, b : ChemdescelectronicBuffer) -> ChemdescelectronicBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_electronic_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_electronic_buffer_copy(s : ChemdescelectronicBuffer) -> ChemdescelectronicBuffer {
  let result = chem_desc_electronic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_electronic_buffer_fill(s : ChemdescelectronicBuffer, v : Double) -> ChemdescelectronicBuffer {
  let result = chem_desc_electronic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_buffer_min(s : ChemdescelectronicBuffer) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_buffer_max(s : ChemdescelectronicBuffer) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_buffer_to_string(s : ChemdescelectronicBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_cursor_make(size : Int) -> ChemdescelectronicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_cursor_len(s : ChemdescelectronicCursor) -> Int { s.size }

pub fn chem_desc_electronic_cursor_get(s : ChemdescelectronicCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_cursor_set(s : ChemdescelectronicCursor, i : Int, v : Double) -> ChemdescelectronicCursor {
  let result = chem_desc_electronic_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_cursor_sum(s : ChemdescelectronicCursor) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_cursor_mean(s : ChemdescelectronicCursor) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_cursor_scale(s : ChemdescelectronicCursor, f : Double) -> ChemdescelectronicCursor {
  let result = chem_desc_electronic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_electronic_cursor_add(a : ChemdescelectronicCursor, b : ChemdescelectronicCursor) -> ChemdescelectronicCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_electronic_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_electronic_cursor_copy(s : ChemdescelectronicCursor) -> ChemdescelectronicCursor {
  let result = chem_desc_electronic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_electronic_cursor_fill(s : ChemdescelectronicCursor, v : Double) -> ChemdescelectronicCursor {
  let result = chem_desc_electronic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_cursor_min(s : ChemdescelectronicCursor) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_cursor_max(s : ChemdescelectronicCursor) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_cursor_to_string(s : ChemdescelectronicCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_view_make(size : Int) -> ChemdescelectronicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_view_len(s : ChemdescelectronicView) -> Int { s.size }

pub fn chem_desc_electronic_view_get(s : ChemdescelectronicView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_view_set(s : ChemdescelectronicView, i : Int, v : Double) -> ChemdescelectronicView {
  let result = chem_desc_electronic_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_view_sum(s : ChemdescelectronicView) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_view_mean(s : ChemdescelectronicView) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_view_scale(s : ChemdescelectronicView, f : Double) -> ChemdescelectronicView {
  let result = chem_desc_electronic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_electronic_view_add(a : ChemdescelectronicView, b : ChemdescelectronicView) -> ChemdescelectronicView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_electronic_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_electronic_view_copy(s : ChemdescelectronicView) -> ChemdescelectronicView {
  let result = chem_desc_electronic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_electronic_view_fill(s : ChemdescelectronicView, v : Double) -> ChemdescelectronicView {
  let result = chem_desc_electronic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_view_min(s : ChemdescelectronicView) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_view_max(s : ChemdescelectronicView) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_view_to_string(s : ChemdescelectronicView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_range_make(size : Int) -> ChemdescelectronicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_range_len(s : ChemdescelectronicRange) -> Int { s.size }

pub fn chem_desc_electronic_range_get(s : ChemdescelectronicRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_range_set(s : ChemdescelectronicRange, i : Int, v : Double) -> ChemdescelectronicRange {
  let result = chem_desc_electronic_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_range_sum(s : ChemdescelectronicRange) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_range_mean(s : ChemdescelectronicRange) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_range_scale(s : ChemdescelectronicRange, f : Double) -> ChemdescelectronicRange {
  let result = chem_desc_electronic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_electronic_range_add(a : ChemdescelectronicRange, b : ChemdescelectronicRange) -> ChemdescelectronicRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_electronic_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_electronic_range_copy(s : ChemdescelectronicRange) -> ChemdescelectronicRange {
  let result = chem_desc_electronic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_electronic_range_fill(s : ChemdescelectronicRange, v : Double) -> ChemdescelectronicRange {
  let result = chem_desc_electronic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_range_min(s : ChemdescelectronicRange) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_range_max(s : ChemdescelectronicRange) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_range_to_string(s : ChemdescelectronicRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescelectronicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_electronic_slice_make(size : Int) -> ChemdescelectronicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_electronic_slice_len(s : ChemdescelectronicSlice) -> Int { s.size }

pub fn chem_desc_electronic_slice_get(s : ChemdescelectronicSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_electronic_slice_set(s : ChemdescelectronicSlice, i : Int, v : Double) -> ChemdescelectronicSlice {
  let result = chem_desc_electronic_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_slice_sum(s : ChemdescelectronicSlice) -> Double { @_common.sum(s.data) }

pub fn chem_desc_electronic_slice_mean(s : ChemdescelectronicSlice) -> Double { @_common.mean(s.data) }

pub fn chem_desc_electronic_slice_scale(s : ChemdescelectronicSlice, f : Double) -> ChemdescelectronicSlice {
  let result = chem_desc_electronic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_electronic_slice_add(a : ChemdescelectronicSlice, b : ChemdescelectronicSlice) -> ChemdescelectronicSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_electronic_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_electronic_slice_copy(s : ChemdescelectronicSlice) -> ChemdescelectronicSlice {
  let result = chem_desc_electronic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_electronic_slice_fill(s : ChemdescelectronicSlice, v : Double) -> ChemdescelectronicSlice {
  let result = chem_desc_electronic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_electronic_slice_min(s : ChemdescelectronicSlice) -> Double { @_common.min(s.data) }

pub fn chem_desc_electronic_slice_max(s : ChemdescelectronicSlice) -> Double { @_common.max(s.data) }

pub fn chem_desc_electronic_slice_to_string(s : ChemdescelectronicSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

