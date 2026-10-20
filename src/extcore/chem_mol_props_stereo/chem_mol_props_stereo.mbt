///===
/// extcore/chem_mol_props_stereo

pub(all) struct ChemmolpropsstereoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_stereo_make_point(x : Double, y : Double) -> ChemmolpropsstereoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_stereo_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropsstereoPoint {
  { x, y, z, label: 0 }
}

pub fn chem_mol_props_stereo_point_x(pt : ChemmolpropsstereoPoint) -> Double { pt.x }

pub fn chem_mol_props_stereo_point_y(pt : ChemmolpropsstereoPoint) -> Double { pt.y }

pub fn chem_mol_props_stereo_point_z(pt : ChemmolpropsstereoPoint) -> Double { pt.z }

pub fn chem_mol_props_stereo_point_label(pt : ChemmolpropsstereoPoint) -> Int { pt.label }

pub fn chem_mol_props_stereo_point_dist(a : ChemmolpropsstereoPoint, b : ChemmolpropsstereoPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_mol_props_stereo_point_add(a : ChemmolpropsstereoPoint, b : ChemmolpropsstereoPoint) -> ChemmolpropsstereoPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_mol_props_stereo_point_sub(a : ChemmolpropsstereoPoint, b : ChemmolpropsstereoPoint) -> ChemmolpropsstereoPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_mol_props_stereo_point_scale(pt : ChemmolpropsstereoPoint, s : Double) -> ChemmolpropsstereoPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_mol_props_stereo_point_dot(a : ChemmolpropsstereoPoint, b : ChemmolpropsstereoPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_mol_props_stereo_point_cross(a : ChemmolpropsstereoPoint, b : ChemmolpropsstereoPoint) -> ChemmolpropsstereoPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_mol_props_stereo_point_norm(pt : ChemmolpropsstereoPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_mol_props_stereo_point_normalize(pt : ChemmolpropsstereoPoint) -> ChemmolpropsstereoPoint {
  let n = chem_mol_props_stereo_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_mol_props_stereo_point_scale(pt, 1.0 / n) }
}

pub fn chem_mol_props_stereo_point_negate(pt : ChemmolpropsstereoPoint) -> ChemmolpropsstereoPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_mol_props_stereo_point_mid(a : ChemmolpropsstereoPoint, b : ChemmolpropsstereoPoint) -> ChemmolpropsstereoPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_mol_props_stereo_point_lerp(a : ChemmolpropsstereoPoint, b : ChemmolpropsstereoPoint, t : Double) -> ChemmolpropsstereoPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_mol_props_stereo_point_to_string(pt : ChemmolpropsstereoPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_stereo_make_series(vals : Array[Double], name : String) -> ChemmolpropsstereoSeries {
  { vals, name, meta: 0 }
}

pub fn chem_mol_props_stereo_series_len(s : ChemmolpropsstereoSeries) -> Int { s.vals.length() }

pub fn chem_mol_props_stereo_series_sum(s : ChemmolpropsstereoSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_mol_props_stereo_series_mean(s : ChemmolpropsstereoSeries) -> Double { @_common.mean(s.vals) }

pub fn chem_mol_props_stereo_series_min(s : ChemmolpropsstereoSeries) -> Double { @_common.min(s.vals) }

pub fn chem_mol_props_stereo_series_max(s : ChemmolpropsstereoSeries) -> Double { @_common.max(s.vals) }

pub fn chem_mol_props_stereo_series_range(s : ChemmolpropsstereoSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn chem_mol_props_stereo_series_var(s : ChemmolpropsstereoSeries) -> Double { @_common.variance(s.vals) }

pub fn chem_mol_props_stereo_series_std(s : ChemmolpropsstereoSeries) -> Double { @_common.std(s.vals) }

pub fn chem_mol_props_stereo_series_median(s : ChemmolpropsstereoSeries) -> Double { @_common.median(s.vals) }

pub fn chem_mol_props_stereo_series_scale(s : ChemmolpropsstereoSeries, f : Double) -> ChemmolpropsstereoSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_mol_props_stereo_series_add(a : ChemmolpropsstereoSeries, b : ChemmolpropsstereoSeries) -> ChemmolpropsstereoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_mol_props_stereo_series_sub(a : ChemmolpropsstereoSeries, b : ChemmolpropsstereoSeries) -> ChemmolpropsstereoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_mol_props_stereo_series_normalize(s : ChemmolpropsstereoSeries) -> ChemmolpropsstereoSeries {
  let mn = chem_mol_props_stereo_series_min(s)
  let mx = chem_mol_props_stereo_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_mol_props_stereo_series_cumsum(s : ChemmolpropsstereoSeries) -> ChemmolpropsstereoSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_mol_props_stereo_series_to_string(s : ChemmolpropsstereoSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropsstereoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_stereo_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropsstereoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_stereo_matrix_identity(n : Int) -> ChemmolpropsstereoMatrix {
  let m = chem_mol_props_stereo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_mol_props_stereo_matrix_get(m : ChemmolpropsstereoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_mol_props_stereo_matrix_transpose(m : ChemmolpropsstereoMatrix) -> ChemmolpropsstereoMatrix {
  let result = chem_mol_props_stereo_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_mol_props_stereo_matrix_add(a : ChemmolpropsstereoMatrix, b : ChemmolpropsstereoMatrix) -> ChemmolpropsstereoMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_mol_props_stereo_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_mol_props_stereo_matrix_scale(m : ChemmolpropsstereoMatrix, s : Double) -> ChemmolpropsstereoMatrix {
  let result = chem_mol_props_stereo_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_mol_props_stereo_matrix_multiply(a : ChemmolpropsstereoMatrix, b : ChemmolpropsstereoMatrix) -> ChemmolpropsstereoMatrix {
  if a.cols != b.rows { return chem_mol_props_stereo_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_mol_props_stereo_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_mol_props_stereo_matrix_trace(m : ChemmolpropsstereoMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_mol_props_stereo_matrix_det(m : ChemmolpropsstereoMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_mol_props_stereo_matrix_norm(m : ChemmolpropsstereoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_mol_props_stereo_matrix_to_string(m : ChemmolpropsstereoMatrix) -> String {
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

pub(all) struct ChemmolpropsstereoVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_stereo_make_vector(comps : Array[Double]) -> ChemmolpropsstereoVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_stereo_vector_zero(dim : Int) -> ChemmolpropsstereoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_mol_props_stereo_vector_add(a : ChemmolpropsstereoVector, b : ChemmolpropsstereoVector) -> ChemmolpropsstereoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_props_stereo_vector_sub(a : ChemmolpropsstereoVector, b : ChemmolpropsstereoVector) -> ChemmolpropsstereoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_props_stereo_vector_scale(v : ChemmolpropsstereoVector, s : Double) -> ChemmolpropsstereoVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_mol_props_stereo_vector_dot(a : ChemmolpropsstereoVector, b : ChemmolpropsstereoVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_mol_props_stereo_vector_norm(v : ChemmolpropsstereoVector) -> Double { @_common.sqrt(chem_mol_props_stereo_vector_dot(v, v)) }

pub fn chem_mol_props_stereo_vector_normalize(v : ChemmolpropsstereoVector) -> ChemmolpropsstereoVector {
  let n = chem_mol_props_stereo_vector_norm(v)
  if n < 0.0000001 { v } else { chem_mol_props_stereo_vector_scale(v, 1.0 / n) }
}

pub fn chem_mol_props_stereo_vector_dist(a : ChemmolpropsstereoVector, b : ChemmolpropsstereoVector) -> Double {
  chem_mol_props_stereo_vector_norm(chem_mol_props_stereo_vector_sub(a, b))
}

pub fn chem_mol_props_stereo_vector_to_string(v : ChemmolpropsstereoVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_props_stereo_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_props_stereo_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_props_stereo_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_props_stereo_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_props_stereo_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_props_stereo_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_props_stereo_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_props_stereo_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_props_stereo_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_props_stereo_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_props_stereo_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_props_stereo_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_props_stereo_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_props_stereo_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_props_stereo_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_props_stereo_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_props_stereo_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_props_stereo_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_props_stereo_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_props_stereo_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_props_stereo_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_props_stereo_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_props_stereo_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_props_stereo_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_props_stereo_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_props_stereo_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_props_stereo_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_props_stereo_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_props_stereo_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolpropsstereoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_frame_make(size : Int) -> ChemmolpropsstereoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_frame_len(s : ChemmolpropsstereoFrame) -> Int { s.size }

pub fn chem_mol_props_stereo_frame_get(s : ChemmolpropsstereoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_frame_set(s : ChemmolpropsstereoFrame, i : Int, v : Double) -> ChemmolpropsstereoFrame {
  let result = chem_mol_props_stereo_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_frame_sum(s : ChemmolpropsstereoFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_stereo_frame_mean(s : ChemmolpropsstereoFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_stereo_frame_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_stereo_frame_scale(s : ChemmolpropsstereoFrame, f : Double) -> ChemmolpropsstereoFrame {
  let result = chem_mol_props_stereo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_stereo_frame_add(a : ChemmolpropsstereoFrame, b : ChemmolpropsstereoFrame) -> ChemmolpropsstereoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_stereo_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_stereo_frame_copy(s : ChemmolpropsstereoFrame) -> ChemmolpropsstereoFrame {
  let result = chem_mol_props_stereo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_stereo_frame_fill(s : ChemmolpropsstereoFrame, v : Double) -> ChemmolpropsstereoFrame {
  let result = chem_mol_props_stereo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_frame_min(s : ChemmolpropsstereoFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_frame_max(s : ChemmolpropsstereoFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_frame_to_string(s : ChemmolpropsstereoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_table_make(size : Int) -> ChemmolpropsstereoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_table_len(s : ChemmolpropsstereoTable) -> Int { s.size }

pub fn chem_mol_props_stereo_table_get(s : ChemmolpropsstereoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_table_set(s : ChemmolpropsstereoTable, i : Int, v : Double) -> ChemmolpropsstereoTable {
  let result = chem_mol_props_stereo_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_table_sum(s : ChemmolpropsstereoTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_stereo_table_mean(s : ChemmolpropsstereoTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_stereo_table_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_stereo_table_scale(s : ChemmolpropsstereoTable, f : Double) -> ChemmolpropsstereoTable {
  let result = chem_mol_props_stereo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_stereo_table_add(a : ChemmolpropsstereoTable, b : ChemmolpropsstereoTable) -> ChemmolpropsstereoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_stereo_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_stereo_table_copy(s : ChemmolpropsstereoTable) -> ChemmolpropsstereoTable {
  let result = chem_mol_props_stereo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_stereo_table_fill(s : ChemmolpropsstereoTable, v : Double) -> ChemmolpropsstereoTable {
  let result = chem_mol_props_stereo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_table_min(s : ChemmolpropsstereoTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_table_max(s : ChemmolpropsstereoTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_table_to_string(s : ChemmolpropsstereoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_graphn_make(size : Int) -> ChemmolpropsstereoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_graphn_len(s : ChemmolpropsstereoGraphN) -> Int { s.size }

pub fn chem_mol_props_stereo_graphn_get(s : ChemmolpropsstereoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_graphn_set(s : ChemmolpropsstereoGraphN, i : Int, v : Double) -> ChemmolpropsstereoGraphN {
  let result = chem_mol_props_stereo_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_graphn_sum(s : ChemmolpropsstereoGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_stereo_graphn_mean(s : ChemmolpropsstereoGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_stereo_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_stereo_graphn_scale(s : ChemmolpropsstereoGraphN, f : Double) -> ChemmolpropsstereoGraphN {
  let result = chem_mol_props_stereo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_stereo_graphn_add(a : ChemmolpropsstereoGraphN, b : ChemmolpropsstereoGraphN) -> ChemmolpropsstereoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_stereo_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_stereo_graphn_copy(s : ChemmolpropsstereoGraphN) -> ChemmolpropsstereoGraphN {
  let result = chem_mol_props_stereo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_stereo_graphn_fill(s : ChemmolpropsstereoGraphN, v : Double) -> ChemmolpropsstereoGraphN {
  let result = chem_mol_props_stereo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_graphn_min(s : ChemmolpropsstereoGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_graphn_max(s : ChemmolpropsstereoGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_graphn_to_string(s : ChemmolpropsstereoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_node_make(size : Int) -> ChemmolpropsstereoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_node_len(s : ChemmolpropsstereoNode) -> Int { s.size }

pub fn chem_mol_props_stereo_node_get(s : ChemmolpropsstereoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_node_set(s : ChemmolpropsstereoNode, i : Int, v : Double) -> ChemmolpropsstereoNode {
  let result = chem_mol_props_stereo_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_node_sum(s : ChemmolpropsstereoNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_stereo_node_mean(s : ChemmolpropsstereoNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_stereo_node_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_stereo_node_scale(s : ChemmolpropsstereoNode, f : Double) -> ChemmolpropsstereoNode {
  let result = chem_mol_props_stereo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_stereo_node_add(a : ChemmolpropsstereoNode, b : ChemmolpropsstereoNode) -> ChemmolpropsstereoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_stereo_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_stereo_node_copy(s : ChemmolpropsstereoNode) -> ChemmolpropsstereoNode {
  let result = chem_mol_props_stereo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_stereo_node_fill(s : ChemmolpropsstereoNode, v : Double) -> ChemmolpropsstereoNode {
  let result = chem_mol_props_stereo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_node_min(s : ChemmolpropsstereoNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_node_max(s : ChemmolpropsstereoNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_node_to_string(s : ChemmolpropsstereoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_edge_make(size : Int) -> ChemmolpropsstereoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_edge_len(s : ChemmolpropsstereoEdge) -> Int { s.size }

pub fn chem_mol_props_stereo_edge_get(s : ChemmolpropsstereoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_edge_set(s : ChemmolpropsstereoEdge, i : Int, v : Double) -> ChemmolpropsstereoEdge {
  let result = chem_mol_props_stereo_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_edge_sum(s : ChemmolpropsstereoEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_stereo_edge_mean(s : ChemmolpropsstereoEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_stereo_edge_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_stereo_edge_scale(s : ChemmolpropsstereoEdge, f : Double) -> ChemmolpropsstereoEdge {
  let result = chem_mol_props_stereo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_stereo_edge_add(a : ChemmolpropsstereoEdge, b : ChemmolpropsstereoEdge) -> ChemmolpropsstereoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_stereo_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_stereo_edge_copy(s : ChemmolpropsstereoEdge) -> ChemmolpropsstereoEdge {
  let result = chem_mol_props_stereo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_stereo_edge_fill(s : ChemmolpropsstereoEdge, v : Double) -> ChemmolpropsstereoEdge {
  let result = chem_mol_props_stereo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_edge_min(s : ChemmolpropsstereoEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_edge_max(s : ChemmolpropsstereoEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_edge_to_string(s : ChemmolpropsstereoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_path_make(size : Int) -> ChemmolpropsstereoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_path_len(s : ChemmolpropsstereoPath) -> Int { s.size }

pub fn chem_mol_props_stereo_path_get(s : ChemmolpropsstereoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_path_set(s : ChemmolpropsstereoPath, i : Int, v : Double) -> ChemmolpropsstereoPath {
  let result = chem_mol_props_stereo_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_path_sum(s : ChemmolpropsstereoPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_stereo_path_mean(s : ChemmolpropsstereoPath) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_stereo_path_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_stereo_path_scale(s : ChemmolpropsstereoPath, f : Double) -> ChemmolpropsstereoPath {
  let result = chem_mol_props_stereo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_stereo_path_add(a : ChemmolpropsstereoPath, b : ChemmolpropsstereoPath) -> ChemmolpropsstereoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_stereo_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_stereo_path_copy(s : ChemmolpropsstereoPath) -> ChemmolpropsstereoPath {
  let result = chem_mol_props_stereo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_stereo_path_fill(s : ChemmolpropsstereoPath, v : Double) -> ChemmolpropsstereoPath {
  let result = chem_mol_props_stereo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_path_min(s : ChemmolpropsstereoPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_path_max(s : ChemmolpropsstereoPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_path_to_string(s : ChemmolpropsstereoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_cluster_make(size : Int) -> ChemmolpropsstereoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_cluster_len(s : ChemmolpropsstereoCluster) -> Int { s.size }

pub fn chem_mol_props_stereo_cluster_get(s : ChemmolpropsstereoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_cluster_set(s : ChemmolpropsstereoCluster, i : Int, v : Double) -> ChemmolpropsstereoCluster {
  let result = chem_mol_props_stereo_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_cluster_sum(s : ChemmolpropsstereoCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_stereo_cluster_mean(s : ChemmolpropsstereoCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_stereo_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_stereo_cluster_scale(s : ChemmolpropsstereoCluster, f : Double) -> ChemmolpropsstereoCluster {
  let result = chem_mol_props_stereo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_stereo_cluster_add(a : ChemmolpropsstereoCluster, b : ChemmolpropsstereoCluster) -> ChemmolpropsstereoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_stereo_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_stereo_cluster_copy(s : ChemmolpropsstereoCluster) -> ChemmolpropsstereoCluster {
  let result = chem_mol_props_stereo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_stereo_cluster_fill(s : ChemmolpropsstereoCluster, v : Double) -> ChemmolpropsstereoCluster {
  let result = chem_mol_props_stereo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_cluster_min(s : ChemmolpropsstereoCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_cluster_max(s : ChemmolpropsstereoCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_cluster_to_string(s : ChemmolpropsstereoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_model_make(size : Int) -> ChemmolpropsstereoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_model_len(s : ChemmolpropsstereoModel) -> Int { s.size }

pub fn chem_mol_props_stereo_model_get(s : ChemmolpropsstereoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_model_set(s : ChemmolpropsstereoModel, i : Int, v : Double) -> ChemmolpropsstereoModel {
  let result = chem_mol_props_stereo_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_model_sum(s : ChemmolpropsstereoModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_stereo_model_mean(s : ChemmolpropsstereoModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_stereo_model_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_stereo_model_scale(s : ChemmolpropsstereoModel, f : Double) -> ChemmolpropsstereoModel {
  let result = chem_mol_props_stereo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_stereo_model_add(a : ChemmolpropsstereoModel, b : ChemmolpropsstereoModel) -> ChemmolpropsstereoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_stereo_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_stereo_model_copy(s : ChemmolpropsstereoModel) -> ChemmolpropsstereoModel {
  let result = chem_mol_props_stereo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_stereo_model_fill(s : ChemmolpropsstereoModel, v : Double) -> ChemmolpropsstereoModel {
  let result = chem_mol_props_stereo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_model_min(s : ChemmolpropsstereoModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_model_max(s : ChemmolpropsstereoModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_model_to_string(s : ChemmolpropsstereoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_layer_make(size : Int) -> ChemmolpropsstereoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_layer_len(s : ChemmolpropsstereoLayer) -> Int { s.size }

pub fn chem_mol_props_stereo_layer_get(s : ChemmolpropsstereoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_layer_set(s : ChemmolpropsstereoLayer, i : Int, v : Double) -> ChemmolpropsstereoLayer {
  let result = chem_mol_props_stereo_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_layer_sum(s : ChemmolpropsstereoLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_stereo_layer_mean(s : ChemmolpropsstereoLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_stereo_layer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_stereo_layer_scale(s : ChemmolpropsstereoLayer, f : Double) -> ChemmolpropsstereoLayer {
  let result = chem_mol_props_stereo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_stereo_layer_add(a : ChemmolpropsstereoLayer, b : ChemmolpropsstereoLayer) -> ChemmolpropsstereoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_stereo_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_stereo_layer_copy(s : ChemmolpropsstereoLayer) -> ChemmolpropsstereoLayer {
  let result = chem_mol_props_stereo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_stereo_layer_fill(s : ChemmolpropsstereoLayer, v : Double) -> ChemmolpropsstereoLayer {
  let result = chem_mol_props_stereo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_layer_min(s : ChemmolpropsstereoLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_layer_max(s : ChemmolpropsstereoLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_layer_to_string(s : ChemmolpropsstereoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_buffer_make(size : Int) -> ChemmolpropsstereoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_buffer_len(s : ChemmolpropsstereoBuffer) -> Int { s.size }

pub fn chem_mol_props_stereo_buffer_get(s : ChemmolpropsstereoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_buffer_set(s : ChemmolpropsstereoBuffer, i : Int, v : Double) -> ChemmolpropsstereoBuffer {
  let result = chem_mol_props_stereo_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_buffer_sum(s : ChemmolpropsstereoBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_stereo_buffer_mean(s : ChemmolpropsstereoBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_stereo_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_stereo_buffer_scale(s : ChemmolpropsstereoBuffer, f : Double) -> ChemmolpropsstereoBuffer {
  let result = chem_mol_props_stereo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_stereo_buffer_add(a : ChemmolpropsstereoBuffer, b : ChemmolpropsstereoBuffer) -> ChemmolpropsstereoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_stereo_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_stereo_buffer_copy(s : ChemmolpropsstereoBuffer) -> ChemmolpropsstereoBuffer {
  let result = chem_mol_props_stereo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_stereo_buffer_fill(s : ChemmolpropsstereoBuffer, v : Double) -> ChemmolpropsstereoBuffer {
  let result = chem_mol_props_stereo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_buffer_min(s : ChemmolpropsstereoBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_buffer_max(s : ChemmolpropsstereoBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_buffer_to_string(s : ChemmolpropsstereoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_cursor_make(size : Int) -> ChemmolpropsstereoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_cursor_len(s : ChemmolpropsstereoCursor) -> Int { s.size }

pub fn chem_mol_props_stereo_cursor_get(s : ChemmolpropsstereoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_cursor_set(s : ChemmolpropsstereoCursor, i : Int, v : Double) -> ChemmolpropsstereoCursor {
  let result = chem_mol_props_stereo_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_cursor_sum(s : ChemmolpropsstereoCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_stereo_cursor_mean(s : ChemmolpropsstereoCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_stereo_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_stereo_cursor_scale(s : ChemmolpropsstereoCursor, f : Double) -> ChemmolpropsstereoCursor {
  let result = chem_mol_props_stereo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_stereo_cursor_add(a : ChemmolpropsstereoCursor, b : ChemmolpropsstereoCursor) -> ChemmolpropsstereoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_stereo_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_stereo_cursor_copy(s : ChemmolpropsstereoCursor) -> ChemmolpropsstereoCursor {
  let result = chem_mol_props_stereo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_stereo_cursor_fill(s : ChemmolpropsstereoCursor, v : Double) -> ChemmolpropsstereoCursor {
  let result = chem_mol_props_stereo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_cursor_min(s : ChemmolpropsstereoCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_cursor_max(s : ChemmolpropsstereoCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_cursor_to_string(s : ChemmolpropsstereoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_view_make(size : Int) -> ChemmolpropsstereoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_view_len(s : ChemmolpropsstereoView) -> Int { s.size }

pub fn chem_mol_props_stereo_view_get(s : ChemmolpropsstereoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_view_set(s : ChemmolpropsstereoView, i : Int, v : Double) -> ChemmolpropsstereoView {
  let result = chem_mol_props_stereo_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_view_sum(s : ChemmolpropsstereoView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_stereo_view_mean(s : ChemmolpropsstereoView) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_stereo_view_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_stereo_view_scale(s : ChemmolpropsstereoView, f : Double) -> ChemmolpropsstereoView {
  let result = chem_mol_props_stereo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_stereo_view_add(a : ChemmolpropsstereoView, b : ChemmolpropsstereoView) -> ChemmolpropsstereoView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_stereo_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_stereo_view_copy(s : ChemmolpropsstereoView) -> ChemmolpropsstereoView {
  let result = chem_mol_props_stereo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_stereo_view_fill(s : ChemmolpropsstereoView, v : Double) -> ChemmolpropsstereoView {
  let result = chem_mol_props_stereo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_view_min(s : ChemmolpropsstereoView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_view_max(s : ChemmolpropsstereoView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_view_to_string(s : ChemmolpropsstereoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_range_make(size : Int) -> ChemmolpropsstereoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_range_len(s : ChemmolpropsstereoRange) -> Int { s.size }

pub fn chem_mol_props_stereo_range_get(s : ChemmolpropsstereoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_range_set(s : ChemmolpropsstereoRange, i : Int, v : Double) -> ChemmolpropsstereoRange {
  let result = chem_mol_props_stereo_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_range_sum(s : ChemmolpropsstereoRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_stereo_range_mean(s : ChemmolpropsstereoRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_stereo_range_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_stereo_range_scale(s : ChemmolpropsstereoRange, f : Double) -> ChemmolpropsstereoRange {
  let result = chem_mol_props_stereo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_stereo_range_add(a : ChemmolpropsstereoRange, b : ChemmolpropsstereoRange) -> ChemmolpropsstereoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_stereo_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_stereo_range_copy(s : ChemmolpropsstereoRange) -> ChemmolpropsstereoRange {
  let result = chem_mol_props_stereo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_stereo_range_fill(s : ChemmolpropsstereoRange, v : Double) -> ChemmolpropsstereoRange {
  let result = chem_mol_props_stereo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_range_min(s : ChemmolpropsstereoRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_range_max(s : ChemmolpropsstereoRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_range_to_string(s : ChemmolpropsstereoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_slice_make(size : Int) -> ChemmolpropsstereoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_stereo_slice_len(s : ChemmolpropsstereoSlice) -> Int { s.size }

pub fn chem_mol_props_stereo_slice_get(s : ChemmolpropsstereoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_stereo_slice_set(s : ChemmolpropsstereoSlice, i : Int, v : Double) -> ChemmolpropsstereoSlice {
  let result = chem_mol_props_stereo_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_slice_sum(s : ChemmolpropsstereoSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_stereo_slice_mean(s : ChemmolpropsstereoSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_stereo_slice_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_stereo_slice_scale(s : ChemmolpropsstereoSlice, f : Double) -> ChemmolpropsstereoSlice {
  let result = chem_mol_props_stereo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_stereo_slice_add(a : ChemmolpropsstereoSlice, b : ChemmolpropsstereoSlice) -> ChemmolpropsstereoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_stereo_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_stereo_slice_copy(s : ChemmolpropsstereoSlice) -> ChemmolpropsstereoSlice {
  let result = chem_mol_props_stereo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_stereo_slice_fill(s : ChemmolpropsstereoSlice, v : Double) -> ChemmolpropsstereoSlice {
  let result = chem_mol_props_stereo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_stereo_slice_min(s : ChemmolpropsstereoSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_slice_max(s : ChemmolpropsstereoSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_stereo_slice_to_string(s : ChemmolpropsstereoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

