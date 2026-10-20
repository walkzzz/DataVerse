///===
/// extcore/chem_mol_props_hba

pub(all) struct ChemmolpropshbaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_hba_make_point(x : Double, y : Double) -> ChemmolpropshbaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_hba_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropshbaPoint {
  { x, y, z, label: 0 }
}

pub fn chem_mol_props_hba_point_x(pt : ChemmolpropshbaPoint) -> Double { pt.x }

pub fn chem_mol_props_hba_point_y(pt : ChemmolpropshbaPoint) -> Double { pt.y }

pub fn chem_mol_props_hba_point_z(pt : ChemmolpropshbaPoint) -> Double { pt.z }

pub fn chem_mol_props_hba_point_label(pt : ChemmolpropshbaPoint) -> Int { pt.label }

pub fn chem_mol_props_hba_point_dist(a : ChemmolpropshbaPoint, b : ChemmolpropshbaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_mol_props_hba_point_add(a : ChemmolpropshbaPoint, b : ChemmolpropshbaPoint) -> ChemmolpropshbaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_mol_props_hba_point_sub(a : ChemmolpropshbaPoint, b : ChemmolpropshbaPoint) -> ChemmolpropshbaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_mol_props_hba_point_scale(pt : ChemmolpropshbaPoint, s : Double) -> ChemmolpropshbaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_mol_props_hba_point_dot(a : ChemmolpropshbaPoint, b : ChemmolpropshbaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_mol_props_hba_point_cross(a : ChemmolpropshbaPoint, b : ChemmolpropshbaPoint) -> ChemmolpropshbaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_mol_props_hba_point_norm(pt : ChemmolpropshbaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_mol_props_hba_point_normalize(pt : ChemmolpropshbaPoint) -> ChemmolpropshbaPoint {
  let n = chem_mol_props_hba_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_mol_props_hba_point_scale(pt, 1.0 / n) }
}

pub fn chem_mol_props_hba_point_negate(pt : ChemmolpropshbaPoint) -> ChemmolpropshbaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_mol_props_hba_point_mid(a : ChemmolpropshbaPoint, b : ChemmolpropshbaPoint) -> ChemmolpropshbaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_mol_props_hba_point_lerp(a : ChemmolpropshbaPoint, b : ChemmolpropshbaPoint, t : Double) -> ChemmolpropshbaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_mol_props_hba_point_to_string(pt : ChemmolpropshbaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemmolpropshbaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_hba_make_series(vals : Array[Double], name : String) -> ChemmolpropshbaSeries {
  { vals, name, meta: 0 }
}

pub fn chem_mol_props_hba_series_len(s : ChemmolpropshbaSeries) -> Int { s.vals.length() }

pub fn chem_mol_props_hba_series_sum(s : ChemmolpropshbaSeries) -> Double { @_common.sum(s.vals) }

pub fn chem_mol_props_hba_series_mean(s : ChemmolpropshbaSeries) -> Double { @_common.mean(s.vals) }

pub fn chem_mol_props_hba_series_min(s : ChemmolpropshbaSeries) -> Double { @_common.min(s.vals) }

pub fn chem_mol_props_hba_series_max(s : ChemmolpropshbaSeries) -> Double { @_common.max(s.vals) }

pub fn chem_mol_props_hba_series_range(s : ChemmolpropshbaSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn chem_mol_props_hba_series_var(s : ChemmolpropshbaSeries) -> Double { @_common.variance(s.vals) }

pub fn chem_mol_props_hba_series_std(s : ChemmolpropshbaSeries) -> Double { @_common.std(s.vals) }

pub fn chem_mol_props_hba_series_median(s : ChemmolpropshbaSeries) -> Double { @_common.median(s.vals) }

pub fn chem_mol_props_hba_series_scale(s : ChemmolpropshbaSeries, f : Double) -> ChemmolpropshbaSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_mol_props_hba_series_add(a : ChemmolpropshbaSeries, b : ChemmolpropshbaSeries) -> ChemmolpropshbaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_mol_props_hba_series_sub(a : ChemmolpropshbaSeries, b : ChemmolpropshbaSeries) -> ChemmolpropshbaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_mol_props_hba_series_normalize(s : ChemmolpropshbaSeries) -> ChemmolpropshbaSeries {
  let mn = chem_mol_props_hba_series_min(s)
  let mx = chem_mol_props_hba_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_mol_props_hba_series_cumsum(s : ChemmolpropshbaSeries) -> ChemmolpropshbaSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_mol_props_hba_series_to_string(s : ChemmolpropshbaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropshbaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_hba_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropshbaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_hba_matrix_identity(n : Int) -> ChemmolpropshbaMatrix {
  let m = chem_mol_props_hba_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_mol_props_hba_matrix_get(m : ChemmolpropshbaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_mol_props_hba_matrix_transpose(m : ChemmolpropshbaMatrix) -> ChemmolpropshbaMatrix {
  let result = chem_mol_props_hba_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_mol_props_hba_matrix_add(a : ChemmolpropshbaMatrix, b : ChemmolpropshbaMatrix) -> ChemmolpropshbaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_mol_props_hba_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_mol_props_hba_matrix_scale(m : ChemmolpropshbaMatrix, s : Double) -> ChemmolpropshbaMatrix {
  let result = chem_mol_props_hba_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_mol_props_hba_matrix_multiply(a : ChemmolpropshbaMatrix, b : ChemmolpropshbaMatrix) -> ChemmolpropshbaMatrix {
  if a.cols != b.rows { return chem_mol_props_hba_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_mol_props_hba_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_mol_props_hba_matrix_trace(m : ChemmolpropshbaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_mol_props_hba_matrix_det(m : ChemmolpropshbaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_mol_props_hba_matrix_norm(m : ChemmolpropshbaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_mol_props_hba_matrix_to_string(m : ChemmolpropshbaMatrix) -> String {
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

pub(all) struct ChemmolpropshbaVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_hba_make_vector(comps : Array[Double]) -> ChemmolpropshbaVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_hba_vector_zero(dim : Int) -> ChemmolpropshbaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_mol_props_hba_vector_add(a : ChemmolpropshbaVector, b : ChemmolpropshbaVector) -> ChemmolpropshbaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_props_hba_vector_sub(a : ChemmolpropshbaVector, b : ChemmolpropshbaVector) -> ChemmolpropshbaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_props_hba_vector_scale(v : ChemmolpropshbaVector, s : Double) -> ChemmolpropshbaVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_mol_props_hba_vector_dot(a : ChemmolpropshbaVector, b : ChemmolpropshbaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_mol_props_hba_vector_norm(v : ChemmolpropshbaVector) -> Double { @_common.sqrt(chem_mol_props_hba_vector_dot(v, v)) }

pub fn chem_mol_props_hba_vector_normalize(v : ChemmolpropshbaVector) -> ChemmolpropshbaVector {
  let n = chem_mol_props_hba_vector_norm(v)
  if n < 0.0000001 { v } else { chem_mol_props_hba_vector_scale(v, 1.0 / n) }
}

pub fn chem_mol_props_hba_vector_dist(a : ChemmolpropshbaVector, b : ChemmolpropshbaVector) -> Double {
  chem_mol_props_hba_vector_norm(chem_mol_props_hba_vector_sub(a, b))
}

pub fn chem_mol_props_hba_vector_to_string(v : ChemmolpropshbaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_props_hba_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_props_hba_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_props_hba_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_props_hba_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_props_hba_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_props_hba_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_props_hba_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_props_hba_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_props_hba_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_props_hba_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_props_hba_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_props_hba_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_props_hba_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_props_hba_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_props_hba_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_props_hba_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_props_hba_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_props_hba_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_props_hba_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_props_hba_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_props_hba_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_props_hba_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_props_hba_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_props_hba_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_props_hba_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_props_hba_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_props_hba_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_props_hba_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_props_hba_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolpropshbaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_frame_make(size : Int) -> ChemmolpropshbaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_frame_len(s : ChemmolpropshbaFrame) -> Int { s.size }

pub fn chem_mol_props_hba_frame_get(s : ChemmolpropshbaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_frame_set(s : ChemmolpropshbaFrame, i : Int, v : Double) -> ChemmolpropshbaFrame {
  let result = chem_mol_props_hba_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_frame_sum(s : ChemmolpropshbaFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hba_frame_mean(s : ChemmolpropshbaFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hba_frame_scale(s : ChemmolpropshbaFrame, f : Double) -> ChemmolpropshbaFrame {
  let result = chem_mol_props_hba_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_frame_add(a : ChemmolpropshbaFrame, b : ChemmolpropshbaFrame) -> ChemmolpropshbaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_frame_copy(s : ChemmolpropshbaFrame) -> ChemmolpropshbaFrame {
  let result = chem_mol_props_hba_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_frame_fill(s : ChemmolpropshbaFrame, v : Double) -> ChemmolpropshbaFrame {
  let result = chem_mol_props_hba_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_frame_min(s : ChemmolpropshbaFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hba_frame_max(s : ChemmolpropshbaFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hba_frame_to_string(s : ChemmolpropshbaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_table_make(size : Int) -> ChemmolpropshbaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_table_len(s : ChemmolpropshbaTable) -> Int { s.size }

pub fn chem_mol_props_hba_table_get(s : ChemmolpropshbaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_table_set(s : ChemmolpropshbaTable, i : Int, v : Double) -> ChemmolpropshbaTable {
  let result = chem_mol_props_hba_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_table_sum(s : ChemmolpropshbaTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hba_table_mean(s : ChemmolpropshbaTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hba_table_scale(s : ChemmolpropshbaTable, f : Double) -> ChemmolpropshbaTable {
  let result = chem_mol_props_hba_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_table_add(a : ChemmolpropshbaTable, b : ChemmolpropshbaTable) -> ChemmolpropshbaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_table_copy(s : ChemmolpropshbaTable) -> ChemmolpropshbaTable {
  let result = chem_mol_props_hba_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_table_fill(s : ChemmolpropshbaTable, v : Double) -> ChemmolpropshbaTable {
  let result = chem_mol_props_hba_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_table_min(s : ChemmolpropshbaTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hba_table_max(s : ChemmolpropshbaTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hba_table_to_string(s : ChemmolpropshbaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_graphn_make(size : Int) -> ChemmolpropshbaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_graphn_len(s : ChemmolpropshbaGraphN) -> Int { s.size }

pub fn chem_mol_props_hba_graphn_get(s : ChemmolpropshbaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_graphn_set(s : ChemmolpropshbaGraphN, i : Int, v : Double) -> ChemmolpropshbaGraphN {
  let result = chem_mol_props_hba_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_graphn_sum(s : ChemmolpropshbaGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hba_graphn_mean(s : ChemmolpropshbaGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hba_graphn_scale(s : ChemmolpropshbaGraphN, f : Double) -> ChemmolpropshbaGraphN {
  let result = chem_mol_props_hba_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_graphn_add(a : ChemmolpropshbaGraphN, b : ChemmolpropshbaGraphN) -> ChemmolpropshbaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_graphn_copy(s : ChemmolpropshbaGraphN) -> ChemmolpropshbaGraphN {
  let result = chem_mol_props_hba_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_graphn_fill(s : ChemmolpropshbaGraphN, v : Double) -> ChemmolpropshbaGraphN {
  let result = chem_mol_props_hba_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_graphn_min(s : ChemmolpropshbaGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hba_graphn_max(s : ChemmolpropshbaGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hba_graphn_to_string(s : ChemmolpropshbaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_node_make(size : Int) -> ChemmolpropshbaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_node_len(s : ChemmolpropshbaNode) -> Int { s.size }

pub fn chem_mol_props_hba_node_get(s : ChemmolpropshbaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_node_set(s : ChemmolpropshbaNode, i : Int, v : Double) -> ChemmolpropshbaNode {
  let result = chem_mol_props_hba_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_node_sum(s : ChemmolpropshbaNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hba_node_mean(s : ChemmolpropshbaNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hba_node_scale(s : ChemmolpropshbaNode, f : Double) -> ChemmolpropshbaNode {
  let result = chem_mol_props_hba_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_node_add(a : ChemmolpropshbaNode, b : ChemmolpropshbaNode) -> ChemmolpropshbaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_node_copy(s : ChemmolpropshbaNode) -> ChemmolpropshbaNode {
  let result = chem_mol_props_hba_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_node_fill(s : ChemmolpropshbaNode, v : Double) -> ChemmolpropshbaNode {
  let result = chem_mol_props_hba_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_node_min(s : ChemmolpropshbaNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hba_node_max(s : ChemmolpropshbaNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hba_node_to_string(s : ChemmolpropshbaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_edge_make(size : Int) -> ChemmolpropshbaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_edge_len(s : ChemmolpropshbaEdge) -> Int { s.size }

pub fn chem_mol_props_hba_edge_get(s : ChemmolpropshbaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_edge_set(s : ChemmolpropshbaEdge, i : Int, v : Double) -> ChemmolpropshbaEdge {
  let result = chem_mol_props_hba_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_edge_sum(s : ChemmolpropshbaEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hba_edge_mean(s : ChemmolpropshbaEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hba_edge_scale(s : ChemmolpropshbaEdge, f : Double) -> ChemmolpropshbaEdge {
  let result = chem_mol_props_hba_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_edge_add(a : ChemmolpropshbaEdge, b : ChemmolpropshbaEdge) -> ChemmolpropshbaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_edge_copy(s : ChemmolpropshbaEdge) -> ChemmolpropshbaEdge {
  let result = chem_mol_props_hba_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_edge_fill(s : ChemmolpropshbaEdge, v : Double) -> ChemmolpropshbaEdge {
  let result = chem_mol_props_hba_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_edge_min(s : ChemmolpropshbaEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hba_edge_max(s : ChemmolpropshbaEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hba_edge_to_string(s : ChemmolpropshbaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_path_make(size : Int) -> ChemmolpropshbaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_path_len(s : ChemmolpropshbaPath) -> Int { s.size }

pub fn chem_mol_props_hba_path_get(s : ChemmolpropshbaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_path_set(s : ChemmolpropshbaPath, i : Int, v : Double) -> ChemmolpropshbaPath {
  let result = chem_mol_props_hba_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_path_sum(s : ChemmolpropshbaPath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hba_path_mean(s : ChemmolpropshbaPath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hba_path_scale(s : ChemmolpropshbaPath, f : Double) -> ChemmolpropshbaPath {
  let result = chem_mol_props_hba_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_path_add(a : ChemmolpropshbaPath, b : ChemmolpropshbaPath) -> ChemmolpropshbaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_path_copy(s : ChemmolpropshbaPath) -> ChemmolpropshbaPath {
  let result = chem_mol_props_hba_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_path_fill(s : ChemmolpropshbaPath, v : Double) -> ChemmolpropshbaPath {
  let result = chem_mol_props_hba_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_path_min(s : ChemmolpropshbaPath) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hba_path_max(s : ChemmolpropshbaPath) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hba_path_to_string(s : ChemmolpropshbaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_cluster_make(size : Int) -> ChemmolpropshbaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_cluster_len(s : ChemmolpropshbaCluster) -> Int { s.size }

pub fn chem_mol_props_hba_cluster_get(s : ChemmolpropshbaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_cluster_set(s : ChemmolpropshbaCluster, i : Int, v : Double) -> ChemmolpropshbaCluster {
  let result = chem_mol_props_hba_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_cluster_sum(s : ChemmolpropshbaCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hba_cluster_mean(s : ChemmolpropshbaCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hba_cluster_scale(s : ChemmolpropshbaCluster, f : Double) -> ChemmolpropshbaCluster {
  let result = chem_mol_props_hba_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_cluster_add(a : ChemmolpropshbaCluster, b : ChemmolpropshbaCluster) -> ChemmolpropshbaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_cluster_copy(s : ChemmolpropshbaCluster) -> ChemmolpropshbaCluster {
  let result = chem_mol_props_hba_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_cluster_fill(s : ChemmolpropshbaCluster, v : Double) -> ChemmolpropshbaCluster {
  let result = chem_mol_props_hba_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_cluster_min(s : ChemmolpropshbaCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hba_cluster_max(s : ChemmolpropshbaCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hba_cluster_to_string(s : ChemmolpropshbaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_model_make(size : Int) -> ChemmolpropshbaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_model_len(s : ChemmolpropshbaModel) -> Int { s.size }

pub fn chem_mol_props_hba_model_get(s : ChemmolpropshbaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_model_set(s : ChemmolpropshbaModel, i : Int, v : Double) -> ChemmolpropshbaModel {
  let result = chem_mol_props_hba_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_model_sum(s : ChemmolpropshbaModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hba_model_mean(s : ChemmolpropshbaModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hba_model_scale(s : ChemmolpropshbaModel, f : Double) -> ChemmolpropshbaModel {
  let result = chem_mol_props_hba_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_model_add(a : ChemmolpropshbaModel, b : ChemmolpropshbaModel) -> ChemmolpropshbaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_model_copy(s : ChemmolpropshbaModel) -> ChemmolpropshbaModel {
  let result = chem_mol_props_hba_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_model_fill(s : ChemmolpropshbaModel, v : Double) -> ChemmolpropshbaModel {
  let result = chem_mol_props_hba_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_model_min(s : ChemmolpropshbaModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hba_model_max(s : ChemmolpropshbaModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hba_model_to_string(s : ChemmolpropshbaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_layer_make(size : Int) -> ChemmolpropshbaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_layer_len(s : ChemmolpropshbaLayer) -> Int { s.size }

pub fn chem_mol_props_hba_layer_get(s : ChemmolpropshbaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_layer_set(s : ChemmolpropshbaLayer, i : Int, v : Double) -> ChemmolpropshbaLayer {
  let result = chem_mol_props_hba_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_layer_sum(s : ChemmolpropshbaLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hba_layer_mean(s : ChemmolpropshbaLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hba_layer_scale(s : ChemmolpropshbaLayer, f : Double) -> ChemmolpropshbaLayer {
  let result = chem_mol_props_hba_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_layer_add(a : ChemmolpropshbaLayer, b : ChemmolpropshbaLayer) -> ChemmolpropshbaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_layer_copy(s : ChemmolpropshbaLayer) -> ChemmolpropshbaLayer {
  let result = chem_mol_props_hba_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_layer_fill(s : ChemmolpropshbaLayer, v : Double) -> ChemmolpropshbaLayer {
  let result = chem_mol_props_hba_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_layer_min(s : ChemmolpropshbaLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hba_layer_max(s : ChemmolpropshbaLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hba_layer_to_string(s : ChemmolpropshbaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_buffer_make(size : Int) -> ChemmolpropshbaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_buffer_len(s : ChemmolpropshbaBuffer) -> Int { s.size }

pub fn chem_mol_props_hba_buffer_get(s : ChemmolpropshbaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_buffer_set(s : ChemmolpropshbaBuffer, i : Int, v : Double) -> ChemmolpropshbaBuffer {
  let result = chem_mol_props_hba_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_buffer_sum(s : ChemmolpropshbaBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hba_buffer_mean(s : ChemmolpropshbaBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hba_buffer_scale(s : ChemmolpropshbaBuffer, f : Double) -> ChemmolpropshbaBuffer {
  let result = chem_mol_props_hba_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_buffer_add(a : ChemmolpropshbaBuffer, b : ChemmolpropshbaBuffer) -> ChemmolpropshbaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_buffer_copy(s : ChemmolpropshbaBuffer) -> ChemmolpropshbaBuffer {
  let result = chem_mol_props_hba_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_buffer_fill(s : ChemmolpropshbaBuffer, v : Double) -> ChemmolpropshbaBuffer {
  let result = chem_mol_props_hba_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_buffer_min(s : ChemmolpropshbaBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hba_buffer_max(s : ChemmolpropshbaBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hba_buffer_to_string(s : ChemmolpropshbaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_cursor_make(size : Int) -> ChemmolpropshbaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_cursor_len(s : ChemmolpropshbaCursor) -> Int { s.size }

pub fn chem_mol_props_hba_cursor_get(s : ChemmolpropshbaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_cursor_set(s : ChemmolpropshbaCursor, i : Int, v : Double) -> ChemmolpropshbaCursor {
  let result = chem_mol_props_hba_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_cursor_sum(s : ChemmolpropshbaCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hba_cursor_mean(s : ChemmolpropshbaCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hba_cursor_scale(s : ChemmolpropshbaCursor, f : Double) -> ChemmolpropshbaCursor {
  let result = chem_mol_props_hba_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_cursor_add(a : ChemmolpropshbaCursor, b : ChemmolpropshbaCursor) -> ChemmolpropshbaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_cursor_copy(s : ChemmolpropshbaCursor) -> ChemmolpropshbaCursor {
  let result = chem_mol_props_hba_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_cursor_fill(s : ChemmolpropshbaCursor, v : Double) -> ChemmolpropshbaCursor {
  let result = chem_mol_props_hba_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_cursor_min(s : ChemmolpropshbaCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hba_cursor_max(s : ChemmolpropshbaCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hba_cursor_to_string(s : ChemmolpropshbaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_view_make(size : Int) -> ChemmolpropshbaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_view_len(s : ChemmolpropshbaView) -> Int { s.size }

pub fn chem_mol_props_hba_view_get(s : ChemmolpropshbaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_view_set(s : ChemmolpropshbaView, i : Int, v : Double) -> ChemmolpropshbaView {
  let result = chem_mol_props_hba_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_view_sum(s : ChemmolpropshbaView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hba_view_mean(s : ChemmolpropshbaView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hba_view_scale(s : ChemmolpropshbaView, f : Double) -> ChemmolpropshbaView {
  let result = chem_mol_props_hba_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_view_add(a : ChemmolpropshbaView, b : ChemmolpropshbaView) -> ChemmolpropshbaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_view_copy(s : ChemmolpropshbaView) -> ChemmolpropshbaView {
  let result = chem_mol_props_hba_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_view_fill(s : ChemmolpropshbaView, v : Double) -> ChemmolpropshbaView {
  let result = chem_mol_props_hba_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_view_min(s : ChemmolpropshbaView) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hba_view_max(s : ChemmolpropshbaView) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hba_view_to_string(s : ChemmolpropshbaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_range_make(size : Int) -> ChemmolpropshbaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_range_len(s : ChemmolpropshbaRange) -> Int { s.size }

pub fn chem_mol_props_hba_range_get(s : ChemmolpropshbaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_range_set(s : ChemmolpropshbaRange, i : Int, v : Double) -> ChemmolpropshbaRange {
  let result = chem_mol_props_hba_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_range_sum(s : ChemmolpropshbaRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hba_range_mean(s : ChemmolpropshbaRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hba_range_scale(s : ChemmolpropshbaRange, f : Double) -> ChemmolpropshbaRange {
  let result = chem_mol_props_hba_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_range_add(a : ChemmolpropshbaRange, b : ChemmolpropshbaRange) -> ChemmolpropshbaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_range_copy(s : ChemmolpropshbaRange) -> ChemmolpropshbaRange {
  let result = chem_mol_props_hba_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_range_fill(s : ChemmolpropshbaRange, v : Double) -> ChemmolpropshbaRange {
  let result = chem_mol_props_hba_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_range_min(s : ChemmolpropshbaRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hba_range_max(s : ChemmolpropshbaRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hba_range_to_string(s : ChemmolpropshbaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_slice_make(size : Int) -> ChemmolpropshbaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_slice_len(s : ChemmolpropshbaSlice) -> Int { s.size }

pub fn chem_mol_props_hba_slice_get(s : ChemmolpropshbaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_slice_set(s : ChemmolpropshbaSlice, i : Int, v : Double) -> ChemmolpropshbaSlice {
  let result = chem_mol_props_hba_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_slice_sum(s : ChemmolpropshbaSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hba_slice_mean(s : ChemmolpropshbaSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hba_slice_scale(s : ChemmolpropshbaSlice, f : Double) -> ChemmolpropshbaSlice {
  let result = chem_mol_props_hba_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_slice_add(a : ChemmolpropshbaSlice, b : ChemmolpropshbaSlice) -> ChemmolpropshbaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_slice_copy(s : ChemmolpropshbaSlice) -> ChemmolpropshbaSlice {
  let result = chem_mol_props_hba_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_slice_fill(s : ChemmolpropshbaSlice, v : Double) -> ChemmolpropshbaSlice {
  let result = chem_mol_props_hba_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_slice_min(s : ChemmolpropshbaSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hba_slice_max(s : ChemmolpropshbaSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hba_slice_to_string(s : ChemmolpropshbaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

