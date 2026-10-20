///===
/// extcore/chem_mol_props_mw

pub(all) struct ChemmolpropsmwPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_mw_make_point(x : Double, y : Double) -> ChemmolpropsmwPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_mw_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropsmwPoint {
  { x, y, z, label: 0 }
}

pub fn chem_mol_props_mw_point_x(pt : ChemmolpropsmwPoint) -> Double { pt.x }

pub fn chem_mol_props_mw_point_y(pt : ChemmolpropsmwPoint) -> Double { pt.y }

pub fn chem_mol_props_mw_point_z(pt : ChemmolpropsmwPoint) -> Double { pt.z }

pub fn chem_mol_props_mw_point_label(pt : ChemmolpropsmwPoint) -> Int { pt.label }

pub fn chem_mol_props_mw_point_dist(a : ChemmolpropsmwPoint, b : ChemmolpropsmwPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_mol_props_mw_point_add(a : ChemmolpropsmwPoint, b : ChemmolpropsmwPoint) -> ChemmolpropsmwPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_mol_props_mw_point_sub(a : ChemmolpropsmwPoint, b : ChemmolpropsmwPoint) -> ChemmolpropsmwPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_mol_props_mw_point_scale(pt : ChemmolpropsmwPoint, s : Double) -> ChemmolpropsmwPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_mol_props_mw_point_dot(a : ChemmolpropsmwPoint, b : ChemmolpropsmwPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_mol_props_mw_point_cross(a : ChemmolpropsmwPoint, b : ChemmolpropsmwPoint) -> ChemmolpropsmwPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_mol_props_mw_point_norm(pt : ChemmolpropsmwPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_mol_props_mw_point_normalize(pt : ChemmolpropsmwPoint) -> ChemmolpropsmwPoint {
  let n = chem_mol_props_mw_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_mol_props_mw_point_scale(pt, 1.0 / n) }
}

pub fn chem_mol_props_mw_point_negate(pt : ChemmolpropsmwPoint) -> ChemmolpropsmwPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_mol_props_mw_point_mid(a : ChemmolpropsmwPoint, b : ChemmolpropsmwPoint) -> ChemmolpropsmwPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_mol_props_mw_point_lerp(a : ChemmolpropsmwPoint, b : ChemmolpropsmwPoint, t : Double) -> ChemmolpropsmwPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_mol_props_mw_point_to_string(pt : ChemmolpropsmwPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemmolpropsmwSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_mw_make_series(vals : Array[Double], name : String) -> ChemmolpropsmwSeries {
  { vals, name, meta: 0 }
}

pub fn chem_mol_props_mw_series_len(s : ChemmolpropsmwSeries) -> Int { s.vals.length() }

pub fn chem_mol_props_mw_series_sum(s : ChemmolpropsmwSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_mol_props_mw_series_mean(s : ChemmolpropsmwSeries) -> Double { @_common.mean(s.vals) }

pub fn chem_mol_props_mw_series_min(s : ChemmolpropsmwSeries) -> Double { @_common.min(s.vals) }

pub fn chem_mol_props_mw_series_max(s : ChemmolpropsmwSeries) -> Double { @_common.max(s.vals) }

pub fn chem_mol_props_mw_series_range(s : ChemmolpropsmwSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn chem_mol_props_mw_series_var(s : ChemmolpropsmwSeries) -> Double { @_common.variance(s.vals) }

pub fn chem_mol_props_mw_series_std(s : ChemmolpropsmwSeries) -> Double { @_common.std(s.vals) }

pub fn chem_mol_props_mw_series_median(s : ChemmolpropsmwSeries) -> Double { @_common.median(s.vals) }

pub fn chem_mol_props_mw_series_scale(s : ChemmolpropsmwSeries, f : Double) -> ChemmolpropsmwSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_mol_props_mw_series_add(a : ChemmolpropsmwSeries, b : ChemmolpropsmwSeries) -> ChemmolpropsmwSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_mol_props_mw_series_sub(a : ChemmolpropsmwSeries, b : ChemmolpropsmwSeries) -> ChemmolpropsmwSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_mol_props_mw_series_normalize(s : ChemmolpropsmwSeries) -> ChemmolpropsmwSeries {
  let mn = chem_mol_props_mw_series_min(s)
  let mx = chem_mol_props_mw_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_mol_props_mw_series_cumsum(s : ChemmolpropsmwSeries) -> ChemmolpropsmwSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_mol_props_mw_series_to_string(s : ChemmolpropsmwSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropsmwMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_mw_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropsmwMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_mw_matrix_identity(n : Int) -> ChemmolpropsmwMatrix {
  let m = chem_mol_props_mw_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_mol_props_mw_matrix_get(m : ChemmolpropsmwMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_mol_props_mw_matrix_transpose(m : ChemmolpropsmwMatrix) -> ChemmolpropsmwMatrix {
  let result = chem_mol_props_mw_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_mol_props_mw_matrix_add(a : ChemmolpropsmwMatrix, b : ChemmolpropsmwMatrix) -> ChemmolpropsmwMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_mol_props_mw_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_mol_props_mw_matrix_scale(m : ChemmolpropsmwMatrix, s : Double) -> ChemmolpropsmwMatrix {
  let result = chem_mol_props_mw_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_mol_props_mw_matrix_multiply(a : ChemmolpropsmwMatrix, b : ChemmolpropsmwMatrix) -> ChemmolpropsmwMatrix {
  if a.cols != b.rows { return chem_mol_props_mw_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_mol_props_mw_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_mol_props_mw_matrix_trace(m : ChemmolpropsmwMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_mol_props_mw_matrix_det(m : ChemmolpropsmwMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_mol_props_mw_matrix_norm(m : ChemmolpropsmwMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_mol_props_mw_matrix_to_string(m : ChemmolpropsmwMatrix) -> String {
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

pub(all) struct ChemmolpropsmwVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_mw_make_vector(comps : Array[Double]) -> ChemmolpropsmwVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_mw_vector_zero(dim : Int) -> ChemmolpropsmwVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_mol_props_mw_vector_add(a : ChemmolpropsmwVector, b : ChemmolpropsmwVector) -> ChemmolpropsmwVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_props_mw_vector_sub(a : ChemmolpropsmwVector, b : ChemmolpropsmwVector) -> ChemmolpropsmwVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_props_mw_vector_scale(v : ChemmolpropsmwVector, s : Double) -> ChemmolpropsmwVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_mol_props_mw_vector_dot(a : ChemmolpropsmwVector, b : ChemmolpropsmwVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_mol_props_mw_vector_norm(v : ChemmolpropsmwVector) -> Double { @_common.sqrt(chem_mol_props_mw_vector_dot(v, v)) }

pub fn chem_mol_props_mw_vector_normalize(v : ChemmolpropsmwVector) -> ChemmolpropsmwVector {
  let n = chem_mol_props_mw_vector_norm(v)
  if n < 0.0000001 { v } else { chem_mol_props_mw_vector_scale(v, 1.0 / n) }
}

pub fn chem_mol_props_mw_vector_dist(a : ChemmolpropsmwVector, b : ChemmolpropsmwVector) -> Double {
  chem_mol_props_mw_vector_norm(chem_mol_props_mw_vector_sub(a, b))
}

pub fn chem_mol_props_mw_vector_to_string(v : ChemmolpropsmwVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_props_mw_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_props_mw_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_props_mw_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_props_mw_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_props_mw_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_props_mw_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_props_mw_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_props_mw_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_props_mw_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_props_mw_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_props_mw_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_props_mw_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_props_mw_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_props_mw_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_props_mw_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_props_mw_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_props_mw_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_props_mw_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_props_mw_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_props_mw_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_props_mw_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_props_mw_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_props_mw_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_props_mw_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_props_mw_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_props_mw_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_props_mw_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_props_mw_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_props_mw_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolpropsmwFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_frame_make(size : Int) -> ChemmolpropsmwFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_frame_len(s : ChemmolpropsmwFrame) -> Int { s.size }

pub fn chem_mol_props_mw_frame_get(s : ChemmolpropsmwFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_frame_set(s : ChemmolpropsmwFrame, i : Int, v : Double) -> ChemmolpropsmwFrame {
  let result = chem_mol_props_mw_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_frame_sum(s : ChemmolpropsmwFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_mw_frame_mean(s : ChemmolpropsmwFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_mw_frame_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_mw_frame_scale(s : ChemmolpropsmwFrame, f : Double) -> ChemmolpropsmwFrame {
  let result = chem_mol_props_mw_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_mw_frame_add(a : ChemmolpropsmwFrame, b : ChemmolpropsmwFrame) -> ChemmolpropsmwFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_mw_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_mw_frame_copy(s : ChemmolpropsmwFrame) -> ChemmolpropsmwFrame {
  let result = chem_mol_props_mw_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_mw_frame_fill(s : ChemmolpropsmwFrame, v : Double) -> ChemmolpropsmwFrame {
  let result = chem_mol_props_mw_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_frame_min(s : ChemmolpropsmwFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_frame_max(s : ChemmolpropsmwFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_frame_to_string(s : ChemmolpropsmwFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_table_make(size : Int) -> ChemmolpropsmwTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_table_len(s : ChemmolpropsmwTable) -> Int { s.size }

pub fn chem_mol_props_mw_table_get(s : ChemmolpropsmwTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_table_set(s : ChemmolpropsmwTable, i : Int, v : Double) -> ChemmolpropsmwTable {
  let result = chem_mol_props_mw_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_table_sum(s : ChemmolpropsmwTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_mw_table_mean(s : ChemmolpropsmwTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_mw_table_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_mw_table_scale(s : ChemmolpropsmwTable, f : Double) -> ChemmolpropsmwTable {
  let result = chem_mol_props_mw_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_mw_table_add(a : ChemmolpropsmwTable, b : ChemmolpropsmwTable) -> ChemmolpropsmwTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_mw_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_mw_table_copy(s : ChemmolpropsmwTable) -> ChemmolpropsmwTable {
  let result = chem_mol_props_mw_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_mw_table_fill(s : ChemmolpropsmwTable, v : Double) -> ChemmolpropsmwTable {
  let result = chem_mol_props_mw_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_table_min(s : ChemmolpropsmwTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_table_max(s : ChemmolpropsmwTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_table_to_string(s : ChemmolpropsmwTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_graphn_make(size : Int) -> ChemmolpropsmwGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_graphn_len(s : ChemmolpropsmwGraphN) -> Int { s.size }

pub fn chem_mol_props_mw_graphn_get(s : ChemmolpropsmwGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_graphn_set(s : ChemmolpropsmwGraphN, i : Int, v : Double) -> ChemmolpropsmwGraphN {
  let result = chem_mol_props_mw_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_graphn_sum(s : ChemmolpropsmwGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_mw_graphn_mean(s : ChemmolpropsmwGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_mw_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_mw_graphn_scale(s : ChemmolpropsmwGraphN, f : Double) -> ChemmolpropsmwGraphN {
  let result = chem_mol_props_mw_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_mw_graphn_add(a : ChemmolpropsmwGraphN, b : ChemmolpropsmwGraphN) -> ChemmolpropsmwGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_mw_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_mw_graphn_copy(s : ChemmolpropsmwGraphN) -> ChemmolpropsmwGraphN {
  let result = chem_mol_props_mw_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_mw_graphn_fill(s : ChemmolpropsmwGraphN, v : Double) -> ChemmolpropsmwGraphN {
  let result = chem_mol_props_mw_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_graphn_min(s : ChemmolpropsmwGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_graphn_max(s : ChemmolpropsmwGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_graphn_to_string(s : ChemmolpropsmwGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_node_make(size : Int) -> ChemmolpropsmwNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_node_len(s : ChemmolpropsmwNode) -> Int { s.size }

pub fn chem_mol_props_mw_node_get(s : ChemmolpropsmwNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_node_set(s : ChemmolpropsmwNode, i : Int, v : Double) -> ChemmolpropsmwNode {
  let result = chem_mol_props_mw_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_node_sum(s : ChemmolpropsmwNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_mw_node_mean(s : ChemmolpropsmwNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_mw_node_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_mw_node_scale(s : ChemmolpropsmwNode, f : Double) -> ChemmolpropsmwNode {
  let result = chem_mol_props_mw_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_mw_node_add(a : ChemmolpropsmwNode, b : ChemmolpropsmwNode) -> ChemmolpropsmwNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_mw_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_mw_node_copy(s : ChemmolpropsmwNode) -> ChemmolpropsmwNode {
  let result = chem_mol_props_mw_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_mw_node_fill(s : ChemmolpropsmwNode, v : Double) -> ChemmolpropsmwNode {
  let result = chem_mol_props_mw_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_node_min(s : ChemmolpropsmwNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_node_max(s : ChemmolpropsmwNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_node_to_string(s : ChemmolpropsmwNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_edge_make(size : Int) -> ChemmolpropsmwEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_edge_len(s : ChemmolpropsmwEdge) -> Int { s.size }

pub fn chem_mol_props_mw_edge_get(s : ChemmolpropsmwEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_edge_set(s : ChemmolpropsmwEdge, i : Int, v : Double) -> ChemmolpropsmwEdge {
  let result = chem_mol_props_mw_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_edge_sum(s : ChemmolpropsmwEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_mw_edge_mean(s : ChemmolpropsmwEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_mw_edge_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_mw_edge_scale(s : ChemmolpropsmwEdge, f : Double) -> ChemmolpropsmwEdge {
  let result = chem_mol_props_mw_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_mw_edge_add(a : ChemmolpropsmwEdge, b : ChemmolpropsmwEdge) -> ChemmolpropsmwEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_mw_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_mw_edge_copy(s : ChemmolpropsmwEdge) -> ChemmolpropsmwEdge {
  let result = chem_mol_props_mw_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_mw_edge_fill(s : ChemmolpropsmwEdge, v : Double) -> ChemmolpropsmwEdge {
  let result = chem_mol_props_mw_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_edge_min(s : ChemmolpropsmwEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_edge_max(s : ChemmolpropsmwEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_edge_to_string(s : ChemmolpropsmwEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_path_make(size : Int) -> ChemmolpropsmwPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_path_len(s : ChemmolpropsmwPath) -> Int { s.size }

pub fn chem_mol_props_mw_path_get(s : ChemmolpropsmwPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_path_set(s : ChemmolpropsmwPath, i : Int, v : Double) -> ChemmolpropsmwPath {
  let result = chem_mol_props_mw_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_path_sum(s : ChemmolpropsmwPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_mw_path_mean(s : ChemmolpropsmwPath) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_mw_path_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_mw_path_scale(s : ChemmolpropsmwPath, f : Double) -> ChemmolpropsmwPath {
  let result = chem_mol_props_mw_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_mw_path_add(a : ChemmolpropsmwPath, b : ChemmolpropsmwPath) -> ChemmolpropsmwPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_mw_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_mw_path_copy(s : ChemmolpropsmwPath) -> ChemmolpropsmwPath {
  let result = chem_mol_props_mw_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_mw_path_fill(s : ChemmolpropsmwPath, v : Double) -> ChemmolpropsmwPath {
  let result = chem_mol_props_mw_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_path_min(s : ChemmolpropsmwPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_path_max(s : ChemmolpropsmwPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_path_to_string(s : ChemmolpropsmwPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_cluster_make(size : Int) -> ChemmolpropsmwCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_cluster_len(s : ChemmolpropsmwCluster) -> Int { s.size }

pub fn chem_mol_props_mw_cluster_get(s : ChemmolpropsmwCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_cluster_set(s : ChemmolpropsmwCluster, i : Int, v : Double) -> ChemmolpropsmwCluster {
  let result = chem_mol_props_mw_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_cluster_sum(s : ChemmolpropsmwCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_mw_cluster_mean(s : ChemmolpropsmwCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_mw_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_mw_cluster_scale(s : ChemmolpropsmwCluster, f : Double) -> ChemmolpropsmwCluster {
  let result = chem_mol_props_mw_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_mw_cluster_add(a : ChemmolpropsmwCluster, b : ChemmolpropsmwCluster) -> ChemmolpropsmwCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_mw_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_mw_cluster_copy(s : ChemmolpropsmwCluster) -> ChemmolpropsmwCluster {
  let result = chem_mol_props_mw_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_mw_cluster_fill(s : ChemmolpropsmwCluster, v : Double) -> ChemmolpropsmwCluster {
  let result = chem_mol_props_mw_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_cluster_min(s : ChemmolpropsmwCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_cluster_max(s : ChemmolpropsmwCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_cluster_to_string(s : ChemmolpropsmwCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_model_make(size : Int) -> ChemmolpropsmwModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_model_len(s : ChemmolpropsmwModel) -> Int { s.size }

pub fn chem_mol_props_mw_model_get(s : ChemmolpropsmwModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_model_set(s : ChemmolpropsmwModel, i : Int, v : Double) -> ChemmolpropsmwModel {
  let result = chem_mol_props_mw_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_model_sum(s : ChemmolpropsmwModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_mw_model_mean(s : ChemmolpropsmwModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_mw_model_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_mw_model_scale(s : ChemmolpropsmwModel, f : Double) -> ChemmolpropsmwModel {
  let result = chem_mol_props_mw_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_mw_model_add(a : ChemmolpropsmwModel, b : ChemmolpropsmwModel) -> ChemmolpropsmwModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_mw_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_mw_model_copy(s : ChemmolpropsmwModel) -> ChemmolpropsmwModel {
  let result = chem_mol_props_mw_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_mw_model_fill(s : ChemmolpropsmwModel, v : Double) -> ChemmolpropsmwModel {
  let result = chem_mol_props_mw_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_model_min(s : ChemmolpropsmwModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_model_max(s : ChemmolpropsmwModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_model_to_string(s : ChemmolpropsmwModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_layer_make(size : Int) -> ChemmolpropsmwLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_layer_len(s : ChemmolpropsmwLayer) -> Int { s.size }

pub fn chem_mol_props_mw_layer_get(s : ChemmolpropsmwLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_layer_set(s : ChemmolpropsmwLayer, i : Int, v : Double) -> ChemmolpropsmwLayer {
  let result = chem_mol_props_mw_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_layer_sum(s : ChemmolpropsmwLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_mw_layer_mean(s : ChemmolpropsmwLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_mw_layer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_mw_layer_scale(s : ChemmolpropsmwLayer, f : Double) -> ChemmolpropsmwLayer {
  let result = chem_mol_props_mw_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_mw_layer_add(a : ChemmolpropsmwLayer, b : ChemmolpropsmwLayer) -> ChemmolpropsmwLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_mw_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_mw_layer_copy(s : ChemmolpropsmwLayer) -> ChemmolpropsmwLayer {
  let result = chem_mol_props_mw_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_mw_layer_fill(s : ChemmolpropsmwLayer, v : Double) -> ChemmolpropsmwLayer {
  let result = chem_mol_props_mw_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_layer_min(s : ChemmolpropsmwLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_layer_max(s : ChemmolpropsmwLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_layer_to_string(s : ChemmolpropsmwLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_buffer_make(size : Int) -> ChemmolpropsmwBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_buffer_len(s : ChemmolpropsmwBuffer) -> Int { s.size }

pub fn chem_mol_props_mw_buffer_get(s : ChemmolpropsmwBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_buffer_set(s : ChemmolpropsmwBuffer, i : Int, v : Double) -> ChemmolpropsmwBuffer {
  let result = chem_mol_props_mw_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_buffer_sum(s : ChemmolpropsmwBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_mw_buffer_mean(s : ChemmolpropsmwBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_mw_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_mw_buffer_scale(s : ChemmolpropsmwBuffer, f : Double) -> ChemmolpropsmwBuffer {
  let result = chem_mol_props_mw_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_mw_buffer_add(a : ChemmolpropsmwBuffer, b : ChemmolpropsmwBuffer) -> ChemmolpropsmwBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_mw_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_mw_buffer_copy(s : ChemmolpropsmwBuffer) -> ChemmolpropsmwBuffer {
  let result = chem_mol_props_mw_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_mw_buffer_fill(s : ChemmolpropsmwBuffer, v : Double) -> ChemmolpropsmwBuffer {
  let result = chem_mol_props_mw_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_buffer_min(s : ChemmolpropsmwBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_buffer_max(s : ChemmolpropsmwBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_buffer_to_string(s : ChemmolpropsmwBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_cursor_make(size : Int) -> ChemmolpropsmwCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_cursor_len(s : ChemmolpropsmwCursor) -> Int { s.size }

pub fn chem_mol_props_mw_cursor_get(s : ChemmolpropsmwCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_cursor_set(s : ChemmolpropsmwCursor, i : Int, v : Double) -> ChemmolpropsmwCursor {
  let result = chem_mol_props_mw_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_cursor_sum(s : ChemmolpropsmwCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_mw_cursor_mean(s : ChemmolpropsmwCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_mw_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_mw_cursor_scale(s : ChemmolpropsmwCursor, f : Double) -> ChemmolpropsmwCursor {
  let result = chem_mol_props_mw_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_mw_cursor_add(a : ChemmolpropsmwCursor, b : ChemmolpropsmwCursor) -> ChemmolpropsmwCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_mw_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_mw_cursor_copy(s : ChemmolpropsmwCursor) -> ChemmolpropsmwCursor {
  let result = chem_mol_props_mw_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_mw_cursor_fill(s : ChemmolpropsmwCursor, v : Double) -> ChemmolpropsmwCursor {
  let result = chem_mol_props_mw_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_cursor_min(s : ChemmolpropsmwCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_cursor_max(s : ChemmolpropsmwCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_cursor_to_string(s : ChemmolpropsmwCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_view_make(size : Int) -> ChemmolpropsmwView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_view_len(s : ChemmolpropsmwView) -> Int { s.size }

pub fn chem_mol_props_mw_view_get(s : ChemmolpropsmwView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_view_set(s : ChemmolpropsmwView, i : Int, v : Double) -> ChemmolpropsmwView {
  let result = chem_mol_props_mw_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_view_sum(s : ChemmolpropsmwView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_mw_view_mean(s : ChemmolpropsmwView) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_mw_view_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_mw_view_scale(s : ChemmolpropsmwView, f : Double) -> ChemmolpropsmwView {
  let result = chem_mol_props_mw_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_mw_view_add(a : ChemmolpropsmwView, b : ChemmolpropsmwView) -> ChemmolpropsmwView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_mw_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_mw_view_copy(s : ChemmolpropsmwView) -> ChemmolpropsmwView {
  let result = chem_mol_props_mw_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_mw_view_fill(s : ChemmolpropsmwView, v : Double) -> ChemmolpropsmwView {
  let result = chem_mol_props_mw_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_view_min(s : ChemmolpropsmwView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_view_max(s : ChemmolpropsmwView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_view_to_string(s : ChemmolpropsmwView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_range_make(size : Int) -> ChemmolpropsmwRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_range_len(s : ChemmolpropsmwRange) -> Int { s.size }

pub fn chem_mol_props_mw_range_get(s : ChemmolpropsmwRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_range_set(s : ChemmolpropsmwRange, i : Int, v : Double) -> ChemmolpropsmwRange {
  let result = chem_mol_props_mw_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_range_sum(s : ChemmolpropsmwRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_mw_range_mean(s : ChemmolpropsmwRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_mw_range_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_mw_range_scale(s : ChemmolpropsmwRange, f : Double) -> ChemmolpropsmwRange {
  let result = chem_mol_props_mw_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_mw_range_add(a : ChemmolpropsmwRange, b : ChemmolpropsmwRange) -> ChemmolpropsmwRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_mw_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_mw_range_copy(s : ChemmolpropsmwRange) -> ChemmolpropsmwRange {
  let result = chem_mol_props_mw_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_mw_range_fill(s : ChemmolpropsmwRange, v : Double) -> ChemmolpropsmwRange {
  let result = chem_mol_props_mw_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_range_min(s : ChemmolpropsmwRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_range_max(s : ChemmolpropsmwRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_range_to_string(s : ChemmolpropsmwRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_slice_make(size : Int) -> ChemmolpropsmwSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_slice_len(s : ChemmolpropsmwSlice) -> Int { s.size }

pub fn chem_mol_props_mw_slice_get(s : ChemmolpropsmwSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_slice_set(s : ChemmolpropsmwSlice, i : Int, v : Double) -> ChemmolpropsmwSlice {
  let result = chem_mol_props_mw_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_slice_sum(s : ChemmolpropsmwSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_mw_slice_mean(s : ChemmolpropsmwSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_mw_slice_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_mw_slice_scale(s : ChemmolpropsmwSlice, f : Double) -> ChemmolpropsmwSlice {
  let result = chem_mol_props_mw_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_mw_slice_add(a : ChemmolpropsmwSlice, b : ChemmolpropsmwSlice) -> ChemmolpropsmwSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_mw_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_mw_slice_copy(s : ChemmolpropsmwSlice) -> ChemmolpropsmwSlice {
  let result = chem_mol_props_mw_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_mw_slice_fill(s : ChemmolpropsmwSlice, v : Double) -> ChemmolpropsmwSlice {
  let result = chem_mol_props_mw_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_mw_slice_min(s : ChemmolpropsmwSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_slice_max(s : ChemmolpropsmwSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_mw_slice_to_string(s : ChemmolpropsmwSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

