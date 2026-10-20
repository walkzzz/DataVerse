///===
/// extcore/chem_rxn_thermo

pub(all) struct ChemrxnthermoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_thermo_make_point(x : Double, y : Double) -> ChemrxnthermoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_thermo_make_point3(x : Double, y : Double, z : Double) -> ChemrxnthermoPoint {
  { x, y, z, label: 0 }
}

pub fn chem_rxn_thermo_point_x(pt : ChemrxnthermoPoint) -> Double { pt.x }

pub fn chem_rxn_thermo_point_y(pt : ChemrxnthermoPoint) -> Double { pt.y }

pub fn chem_rxn_thermo_point_z(pt : ChemrxnthermoPoint) -> Double { pt.z }

pub fn chem_rxn_thermo_point_label(pt : ChemrxnthermoPoint) -> Int { pt.label }

pub fn chem_rxn_thermo_point_dist(a : ChemrxnthermoPoint, b : ChemrxnthermoPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_rxn_thermo_point_add(a : ChemrxnthermoPoint, b : ChemrxnthermoPoint) -> ChemrxnthermoPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_rxn_thermo_point_sub(a : ChemrxnthermoPoint, b : ChemrxnthermoPoint) -> ChemrxnthermoPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_rxn_thermo_point_scale(pt : ChemrxnthermoPoint, s : Double) -> ChemrxnthermoPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_rxn_thermo_point_dot(a : ChemrxnthermoPoint, b : ChemrxnthermoPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_rxn_thermo_point_cross(a : ChemrxnthermoPoint, b : ChemrxnthermoPoint) -> ChemrxnthermoPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_rxn_thermo_point_norm(pt : ChemrxnthermoPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_rxn_thermo_point_normalize(pt : ChemrxnthermoPoint) -> ChemrxnthermoPoint {
  let n = chem_rxn_thermo_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_rxn_thermo_point_scale(pt, 1.0 / n) }
}

pub fn chem_rxn_thermo_point_negate(pt : ChemrxnthermoPoint) -> ChemrxnthermoPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_rxn_thermo_point_mid(a : ChemrxnthermoPoint, b : ChemrxnthermoPoint) -> ChemrxnthermoPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_rxn_thermo_point_lerp(a : ChemrxnthermoPoint, b : ChemrxnthermoPoint, t : Double) -> ChemrxnthermoPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_rxn_thermo_point_to_string(pt : ChemrxnthermoPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemrxnthermoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_thermo_make_series(vals : Array[Double], name : String) -> ChemrxnthermoSeries {
  { vals, name, meta: 0 }
}

pub fn chem_rxn_thermo_series_len(s : ChemrxnthermoSeries) -> Int { s.vals.length() }

pub fn chem_rxn_thermo_series_sum(s : ChemrxnthermoSeries) -> Double { @_common.sum(s.vals) }

pub fn chem_rxn_thermo_series_mean(s : ChemrxnthermoSeries) -> Double { @_common.mean(s.vals) }

pub fn chem_rxn_thermo_series_min(s : ChemrxnthermoSeries) -> Double { @_common.min(s.vals) }

pub fn chem_rxn_thermo_series_max(s : ChemrxnthermoSeries) -> Double { @_common.max(s.vals) }

pub fn chem_rxn_thermo_series_range(s : ChemrxnthermoSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn chem_rxn_thermo_series_var(s : ChemrxnthermoSeries) -> Double { @_common.variance(s.vals) }

pub fn chem_rxn_thermo_series_std(s : ChemrxnthermoSeries) -> Double { @_common.std(s.vals) }

pub fn chem_rxn_thermo_series_median(s : ChemrxnthermoSeries) -> Double { @_common.median(s.vals) }

pub fn chem_rxn_thermo_series_scale(s : ChemrxnthermoSeries, f : Double) -> ChemrxnthermoSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_rxn_thermo_series_add(a : ChemrxnthermoSeries, b : ChemrxnthermoSeries) -> ChemrxnthermoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_rxn_thermo_series_sub(a : ChemrxnthermoSeries, b : ChemrxnthermoSeries) -> ChemrxnthermoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_rxn_thermo_series_normalize(s : ChemrxnthermoSeries) -> ChemrxnthermoSeries {
  let mn = chem_rxn_thermo_series_min(s)
  let mx = chem_rxn_thermo_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_rxn_thermo_series_cumsum(s : ChemrxnthermoSeries) -> ChemrxnthermoSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_rxn_thermo_series_to_string(s : ChemrxnthermoSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnthermoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_thermo_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxnthermoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_thermo_matrix_identity(n : Int) -> ChemrxnthermoMatrix {
  let m = chem_rxn_thermo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_rxn_thermo_matrix_get(m : ChemrxnthermoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_rxn_thermo_matrix_transpose(m : ChemrxnthermoMatrix) -> ChemrxnthermoMatrix {
  let result = chem_rxn_thermo_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_rxn_thermo_matrix_add(a : ChemrxnthermoMatrix, b : ChemrxnthermoMatrix) -> ChemrxnthermoMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_rxn_thermo_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_rxn_thermo_matrix_scale(m : ChemrxnthermoMatrix, s : Double) -> ChemrxnthermoMatrix {
  let result = chem_rxn_thermo_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_rxn_thermo_matrix_multiply(a : ChemrxnthermoMatrix, b : ChemrxnthermoMatrix) -> ChemrxnthermoMatrix {
  if a.cols != b.rows { return chem_rxn_thermo_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_rxn_thermo_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_rxn_thermo_matrix_trace(m : ChemrxnthermoMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_rxn_thermo_matrix_det(m : ChemrxnthermoMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_rxn_thermo_matrix_norm(m : ChemrxnthermoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_rxn_thermo_matrix_to_string(m : ChemrxnthermoMatrix) -> String {
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

pub(all) struct ChemrxnthermoVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_thermo_make_vector(comps : Array[Double]) -> ChemrxnthermoVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_thermo_vector_zero(dim : Int) -> ChemrxnthermoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_rxn_thermo_vector_add(a : ChemrxnthermoVector, b : ChemrxnthermoVector) -> ChemrxnthermoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_rxn_thermo_vector_sub(a : ChemrxnthermoVector, b : ChemrxnthermoVector) -> ChemrxnthermoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_rxn_thermo_vector_scale(v : ChemrxnthermoVector, s : Double) -> ChemrxnthermoVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_rxn_thermo_vector_dot(a : ChemrxnthermoVector, b : ChemrxnthermoVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_rxn_thermo_vector_norm(v : ChemrxnthermoVector) -> Double { @_common.sqrt(chem_rxn_thermo_vector_dot(v, v)) }

pub fn chem_rxn_thermo_vector_normalize(v : ChemrxnthermoVector) -> ChemrxnthermoVector {
  let n = chem_rxn_thermo_vector_norm(v)
  if n < 0.0000001 { v } else { chem_rxn_thermo_vector_scale(v, 1.0 / n) }
}

pub fn chem_rxn_thermo_vector_dist(a : ChemrxnthermoVector, b : ChemrxnthermoVector) -> Double {
  chem_rxn_thermo_vector_norm(chem_rxn_thermo_vector_sub(a, b))
}

pub fn chem_rxn_thermo_vector_to_string(v : ChemrxnthermoVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_rxn_thermo_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_rxn_thermo_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_rxn_thermo_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_rxn_thermo_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_rxn_thermo_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_rxn_thermo_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_rxn_thermo_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_rxn_thermo_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_rxn_thermo_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_rxn_thermo_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_rxn_thermo_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_rxn_thermo_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_rxn_thermo_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_rxn_thermo_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_rxn_thermo_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_rxn_thermo_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_rxn_thermo_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_rxn_thermo_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_rxn_thermo_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_rxn_thermo_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_rxn_thermo_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_rxn_thermo_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_rxn_thermo_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_rxn_thermo_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_rxn_thermo_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_rxn_thermo_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_rxn_thermo_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_rxn_thermo_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_rxn_thermo_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemrxnthermoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_frame_make(size : Int) -> ChemrxnthermoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_frame_len(s : ChemrxnthermoFrame) -> Int { s.size }

pub fn chem_rxn_thermo_frame_get(s : ChemrxnthermoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_frame_set(s : ChemrxnthermoFrame, i : Int, v : Double) -> ChemrxnthermoFrame {
  let result = chem_rxn_thermo_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_frame_sum(s : ChemrxnthermoFrame) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_frame_mean(s : ChemrxnthermoFrame) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_frame_scale(s : ChemrxnthermoFrame, f : Double) -> ChemrxnthermoFrame {
  let result = chem_rxn_thermo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_frame_add(a : ChemrxnthermoFrame, b : ChemrxnthermoFrame) -> ChemrxnthermoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_frame_copy(s : ChemrxnthermoFrame) -> ChemrxnthermoFrame {
  let result = chem_rxn_thermo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_frame_fill(s : ChemrxnthermoFrame, v : Double) -> ChemrxnthermoFrame {
  let result = chem_rxn_thermo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_frame_min(s : ChemrxnthermoFrame) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_frame_max(s : ChemrxnthermoFrame) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_frame_to_string(s : ChemrxnthermoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_table_make(size : Int) -> ChemrxnthermoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_table_len(s : ChemrxnthermoTable) -> Int { s.size }

pub fn chem_rxn_thermo_table_get(s : ChemrxnthermoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_table_set(s : ChemrxnthermoTable, i : Int, v : Double) -> ChemrxnthermoTable {
  let result = chem_rxn_thermo_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_table_sum(s : ChemrxnthermoTable) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_table_mean(s : ChemrxnthermoTable) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_table_scale(s : ChemrxnthermoTable, f : Double) -> ChemrxnthermoTable {
  let result = chem_rxn_thermo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_table_add(a : ChemrxnthermoTable, b : ChemrxnthermoTable) -> ChemrxnthermoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_table_copy(s : ChemrxnthermoTable) -> ChemrxnthermoTable {
  let result = chem_rxn_thermo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_table_fill(s : ChemrxnthermoTable, v : Double) -> ChemrxnthermoTable {
  let result = chem_rxn_thermo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_table_min(s : ChemrxnthermoTable) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_table_max(s : ChemrxnthermoTable) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_table_to_string(s : ChemrxnthermoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_graphn_make(size : Int) -> ChemrxnthermoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_graphn_len(s : ChemrxnthermoGraphN) -> Int { s.size }

pub fn chem_rxn_thermo_graphn_get(s : ChemrxnthermoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_graphn_set(s : ChemrxnthermoGraphN, i : Int, v : Double) -> ChemrxnthermoGraphN {
  let result = chem_rxn_thermo_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_graphn_sum(s : ChemrxnthermoGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_graphn_mean(s : ChemrxnthermoGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_graphn_scale(s : ChemrxnthermoGraphN, f : Double) -> ChemrxnthermoGraphN {
  let result = chem_rxn_thermo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_graphn_add(a : ChemrxnthermoGraphN, b : ChemrxnthermoGraphN) -> ChemrxnthermoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_graphn_copy(s : ChemrxnthermoGraphN) -> ChemrxnthermoGraphN {
  let result = chem_rxn_thermo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_graphn_fill(s : ChemrxnthermoGraphN, v : Double) -> ChemrxnthermoGraphN {
  let result = chem_rxn_thermo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_graphn_min(s : ChemrxnthermoGraphN) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_graphn_max(s : ChemrxnthermoGraphN) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_graphn_to_string(s : ChemrxnthermoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_node_make(size : Int) -> ChemrxnthermoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_node_len(s : ChemrxnthermoNode) -> Int { s.size }

pub fn chem_rxn_thermo_node_get(s : ChemrxnthermoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_node_set(s : ChemrxnthermoNode, i : Int, v : Double) -> ChemrxnthermoNode {
  let result = chem_rxn_thermo_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_node_sum(s : ChemrxnthermoNode) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_node_mean(s : ChemrxnthermoNode) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_node_scale(s : ChemrxnthermoNode, f : Double) -> ChemrxnthermoNode {
  let result = chem_rxn_thermo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_node_add(a : ChemrxnthermoNode, b : ChemrxnthermoNode) -> ChemrxnthermoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_node_copy(s : ChemrxnthermoNode) -> ChemrxnthermoNode {
  let result = chem_rxn_thermo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_node_fill(s : ChemrxnthermoNode, v : Double) -> ChemrxnthermoNode {
  let result = chem_rxn_thermo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_node_min(s : ChemrxnthermoNode) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_node_max(s : ChemrxnthermoNode) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_node_to_string(s : ChemrxnthermoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_edge_make(size : Int) -> ChemrxnthermoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_edge_len(s : ChemrxnthermoEdge) -> Int { s.size }

pub fn chem_rxn_thermo_edge_get(s : ChemrxnthermoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_edge_set(s : ChemrxnthermoEdge, i : Int, v : Double) -> ChemrxnthermoEdge {
  let result = chem_rxn_thermo_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_edge_sum(s : ChemrxnthermoEdge) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_edge_mean(s : ChemrxnthermoEdge) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_edge_scale(s : ChemrxnthermoEdge, f : Double) -> ChemrxnthermoEdge {
  let result = chem_rxn_thermo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_edge_add(a : ChemrxnthermoEdge, b : ChemrxnthermoEdge) -> ChemrxnthermoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_edge_copy(s : ChemrxnthermoEdge) -> ChemrxnthermoEdge {
  let result = chem_rxn_thermo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_edge_fill(s : ChemrxnthermoEdge, v : Double) -> ChemrxnthermoEdge {
  let result = chem_rxn_thermo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_edge_min(s : ChemrxnthermoEdge) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_edge_max(s : ChemrxnthermoEdge) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_edge_to_string(s : ChemrxnthermoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_path_make(size : Int) -> ChemrxnthermoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_path_len(s : ChemrxnthermoPath) -> Int { s.size }

pub fn chem_rxn_thermo_path_get(s : ChemrxnthermoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_path_set(s : ChemrxnthermoPath, i : Int, v : Double) -> ChemrxnthermoPath {
  let result = chem_rxn_thermo_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_path_sum(s : ChemrxnthermoPath) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_path_mean(s : ChemrxnthermoPath) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_path_scale(s : ChemrxnthermoPath, f : Double) -> ChemrxnthermoPath {
  let result = chem_rxn_thermo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_path_add(a : ChemrxnthermoPath, b : ChemrxnthermoPath) -> ChemrxnthermoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_path_copy(s : ChemrxnthermoPath) -> ChemrxnthermoPath {
  let result = chem_rxn_thermo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_path_fill(s : ChemrxnthermoPath, v : Double) -> ChemrxnthermoPath {
  let result = chem_rxn_thermo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_path_min(s : ChemrxnthermoPath) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_path_max(s : ChemrxnthermoPath) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_path_to_string(s : ChemrxnthermoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_cluster_make(size : Int) -> ChemrxnthermoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_cluster_len(s : ChemrxnthermoCluster) -> Int { s.size }

pub fn chem_rxn_thermo_cluster_get(s : ChemrxnthermoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_cluster_set(s : ChemrxnthermoCluster, i : Int, v : Double) -> ChemrxnthermoCluster {
  let result = chem_rxn_thermo_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_cluster_sum(s : ChemrxnthermoCluster) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_cluster_mean(s : ChemrxnthermoCluster) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_cluster_scale(s : ChemrxnthermoCluster, f : Double) -> ChemrxnthermoCluster {
  let result = chem_rxn_thermo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_cluster_add(a : ChemrxnthermoCluster, b : ChemrxnthermoCluster) -> ChemrxnthermoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_cluster_copy(s : ChemrxnthermoCluster) -> ChemrxnthermoCluster {
  let result = chem_rxn_thermo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_cluster_fill(s : ChemrxnthermoCluster, v : Double) -> ChemrxnthermoCluster {
  let result = chem_rxn_thermo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_cluster_min(s : ChemrxnthermoCluster) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_cluster_max(s : ChemrxnthermoCluster) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_cluster_to_string(s : ChemrxnthermoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_model_make(size : Int) -> ChemrxnthermoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_model_len(s : ChemrxnthermoModel) -> Int { s.size }

pub fn chem_rxn_thermo_model_get(s : ChemrxnthermoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_model_set(s : ChemrxnthermoModel, i : Int, v : Double) -> ChemrxnthermoModel {
  let result = chem_rxn_thermo_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_model_sum(s : ChemrxnthermoModel) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_model_mean(s : ChemrxnthermoModel) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_model_scale(s : ChemrxnthermoModel, f : Double) -> ChemrxnthermoModel {
  let result = chem_rxn_thermo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_model_add(a : ChemrxnthermoModel, b : ChemrxnthermoModel) -> ChemrxnthermoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_model_copy(s : ChemrxnthermoModel) -> ChemrxnthermoModel {
  let result = chem_rxn_thermo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_model_fill(s : ChemrxnthermoModel, v : Double) -> ChemrxnthermoModel {
  let result = chem_rxn_thermo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_model_min(s : ChemrxnthermoModel) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_model_max(s : ChemrxnthermoModel) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_model_to_string(s : ChemrxnthermoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_layer_make(size : Int) -> ChemrxnthermoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_layer_len(s : ChemrxnthermoLayer) -> Int { s.size }

pub fn chem_rxn_thermo_layer_get(s : ChemrxnthermoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_layer_set(s : ChemrxnthermoLayer, i : Int, v : Double) -> ChemrxnthermoLayer {
  let result = chem_rxn_thermo_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_layer_sum(s : ChemrxnthermoLayer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_layer_mean(s : ChemrxnthermoLayer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_layer_scale(s : ChemrxnthermoLayer, f : Double) -> ChemrxnthermoLayer {
  let result = chem_rxn_thermo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_layer_add(a : ChemrxnthermoLayer, b : ChemrxnthermoLayer) -> ChemrxnthermoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_layer_copy(s : ChemrxnthermoLayer) -> ChemrxnthermoLayer {
  let result = chem_rxn_thermo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_layer_fill(s : ChemrxnthermoLayer, v : Double) -> ChemrxnthermoLayer {
  let result = chem_rxn_thermo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_layer_min(s : ChemrxnthermoLayer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_layer_max(s : ChemrxnthermoLayer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_layer_to_string(s : ChemrxnthermoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_buffer_make(size : Int) -> ChemrxnthermoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_buffer_len(s : ChemrxnthermoBuffer) -> Int { s.size }

pub fn chem_rxn_thermo_buffer_get(s : ChemrxnthermoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_buffer_set(s : ChemrxnthermoBuffer, i : Int, v : Double) -> ChemrxnthermoBuffer {
  let result = chem_rxn_thermo_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_buffer_sum(s : ChemrxnthermoBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_buffer_mean(s : ChemrxnthermoBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_buffer_scale(s : ChemrxnthermoBuffer, f : Double) -> ChemrxnthermoBuffer {
  let result = chem_rxn_thermo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_buffer_add(a : ChemrxnthermoBuffer, b : ChemrxnthermoBuffer) -> ChemrxnthermoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_buffer_copy(s : ChemrxnthermoBuffer) -> ChemrxnthermoBuffer {
  let result = chem_rxn_thermo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_buffer_fill(s : ChemrxnthermoBuffer, v : Double) -> ChemrxnthermoBuffer {
  let result = chem_rxn_thermo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_buffer_min(s : ChemrxnthermoBuffer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_buffer_max(s : ChemrxnthermoBuffer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_buffer_to_string(s : ChemrxnthermoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_cursor_make(size : Int) -> ChemrxnthermoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_cursor_len(s : ChemrxnthermoCursor) -> Int { s.size }

pub fn chem_rxn_thermo_cursor_get(s : ChemrxnthermoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_cursor_set(s : ChemrxnthermoCursor, i : Int, v : Double) -> ChemrxnthermoCursor {
  let result = chem_rxn_thermo_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_cursor_sum(s : ChemrxnthermoCursor) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_cursor_mean(s : ChemrxnthermoCursor) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_cursor_scale(s : ChemrxnthermoCursor, f : Double) -> ChemrxnthermoCursor {
  let result = chem_rxn_thermo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_cursor_add(a : ChemrxnthermoCursor, b : ChemrxnthermoCursor) -> ChemrxnthermoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_cursor_copy(s : ChemrxnthermoCursor) -> ChemrxnthermoCursor {
  let result = chem_rxn_thermo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_cursor_fill(s : ChemrxnthermoCursor, v : Double) -> ChemrxnthermoCursor {
  let result = chem_rxn_thermo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_cursor_min(s : ChemrxnthermoCursor) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_cursor_max(s : ChemrxnthermoCursor) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_cursor_to_string(s : ChemrxnthermoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_view_make(size : Int) -> ChemrxnthermoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_view_len(s : ChemrxnthermoView) -> Int { s.size }

pub fn chem_rxn_thermo_view_get(s : ChemrxnthermoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_view_set(s : ChemrxnthermoView, i : Int, v : Double) -> ChemrxnthermoView {
  let result = chem_rxn_thermo_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_view_sum(s : ChemrxnthermoView) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_view_mean(s : ChemrxnthermoView) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_view_scale(s : ChemrxnthermoView, f : Double) -> ChemrxnthermoView {
  let result = chem_rxn_thermo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_view_add(a : ChemrxnthermoView, b : ChemrxnthermoView) -> ChemrxnthermoView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_view_copy(s : ChemrxnthermoView) -> ChemrxnthermoView {
  let result = chem_rxn_thermo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_view_fill(s : ChemrxnthermoView, v : Double) -> ChemrxnthermoView {
  let result = chem_rxn_thermo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_view_min(s : ChemrxnthermoView) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_view_max(s : ChemrxnthermoView) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_view_to_string(s : ChemrxnthermoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_range_make(size : Int) -> ChemrxnthermoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_range_len(s : ChemrxnthermoRange) -> Int { s.size }

pub fn chem_rxn_thermo_range_get(s : ChemrxnthermoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_range_set(s : ChemrxnthermoRange, i : Int, v : Double) -> ChemrxnthermoRange {
  let result = chem_rxn_thermo_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_range_sum(s : ChemrxnthermoRange) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_range_mean(s : ChemrxnthermoRange) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_range_scale(s : ChemrxnthermoRange, f : Double) -> ChemrxnthermoRange {
  let result = chem_rxn_thermo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_range_add(a : ChemrxnthermoRange, b : ChemrxnthermoRange) -> ChemrxnthermoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_range_copy(s : ChemrxnthermoRange) -> ChemrxnthermoRange {
  let result = chem_rxn_thermo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_range_fill(s : ChemrxnthermoRange, v : Double) -> ChemrxnthermoRange {
  let result = chem_rxn_thermo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_range_min(s : ChemrxnthermoRange) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_range_max(s : ChemrxnthermoRange) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_range_to_string(s : ChemrxnthermoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_slice_make(size : Int) -> ChemrxnthermoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_slice_len(s : ChemrxnthermoSlice) -> Int { s.size }

pub fn chem_rxn_thermo_slice_get(s : ChemrxnthermoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_slice_set(s : ChemrxnthermoSlice, i : Int, v : Double) -> ChemrxnthermoSlice {
  let result = chem_rxn_thermo_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_slice_sum(s : ChemrxnthermoSlice) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_slice_mean(s : ChemrxnthermoSlice) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_slice_scale(s : ChemrxnthermoSlice, f : Double) -> ChemrxnthermoSlice {
  let result = chem_rxn_thermo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_slice_add(a : ChemrxnthermoSlice, b : ChemrxnthermoSlice) -> ChemrxnthermoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_slice_copy(s : ChemrxnthermoSlice) -> ChemrxnthermoSlice {
  let result = chem_rxn_thermo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_slice_fill(s : ChemrxnthermoSlice, v : Double) -> ChemrxnthermoSlice {
  let result = chem_rxn_thermo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_slice_min(s : ChemrxnthermoSlice) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_slice_max(s : ChemrxnthermoSlice) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_slice_to_string(s : ChemrxnthermoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

