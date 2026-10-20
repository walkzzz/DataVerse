///===
/// extcore/chem_rxn_type

pub(all) struct ChemrxntypePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_type_make_point(x : Double, y : Double) -> ChemrxntypePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_type_make_point3(x : Double, y : Double, z : Double) -> ChemrxntypePoint {
  { x, y, z, label: 0 }
}

pub fn chem_rxn_type_point_x(pt : ChemrxntypePoint) -> Double { pt.x }

pub fn chem_rxn_type_point_y(pt : ChemrxntypePoint) -> Double { pt.y }

pub fn chem_rxn_type_point_z(pt : ChemrxntypePoint) -> Double { pt.z }

pub fn chem_rxn_type_point_label(pt : ChemrxntypePoint) -> Int { pt.label }

pub fn chem_rxn_type_point_dist(a : ChemrxntypePoint, b : ChemrxntypePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_rxn_type_point_add(a : ChemrxntypePoint, b : ChemrxntypePoint) -> ChemrxntypePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_rxn_type_point_sub(a : ChemrxntypePoint, b : ChemrxntypePoint) -> ChemrxntypePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_rxn_type_point_scale(pt : ChemrxntypePoint, s : Double) -> ChemrxntypePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_rxn_type_point_dot(a : ChemrxntypePoint, b : ChemrxntypePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_rxn_type_point_cross(a : ChemrxntypePoint, b : ChemrxntypePoint) -> ChemrxntypePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_rxn_type_point_norm(pt : ChemrxntypePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_rxn_type_point_normalize(pt : ChemrxntypePoint) -> ChemrxntypePoint {
  let n = chem_rxn_type_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_rxn_type_point_scale(pt, 1.0 / n) }
}

pub fn chem_rxn_type_point_negate(pt : ChemrxntypePoint) -> ChemrxntypePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_rxn_type_point_mid(a : ChemrxntypePoint, b : ChemrxntypePoint) -> ChemrxntypePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_rxn_type_point_lerp(a : ChemrxntypePoint, b : ChemrxntypePoint, t : Double) -> ChemrxntypePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_rxn_type_point_to_string(pt : ChemrxntypePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemrxntypeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_type_make_series(vals : Array[Double], name : String) -> ChemrxntypeSeries {
  { vals, name, meta: 0 }
}

pub fn chem_rxn_type_series_len(s : ChemrxntypeSeries) -> Int { s.vals.length() }

pub fn chem_rxn_type_series_sum(s : ChemrxntypeSeries) -> Double { @_common.sum(s.vals) }

pub fn chem_rxn_type_series_mean(s : ChemrxntypeSeries) -> Double { @_common.mean(s.vals) }

pub fn chem_rxn_type_series_min(s : ChemrxntypeSeries) -> Double { @_common.min(s.vals) }

pub fn chem_rxn_type_series_max(s : ChemrxntypeSeries) -> Double { @_common.max(s.vals) }

pub fn chem_rxn_type_series_range(s : ChemrxntypeSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn chem_rxn_type_series_var(s : ChemrxntypeSeries) -> Double { @_common.variance(s.vals) }

pub fn chem_rxn_type_series_std(s : ChemrxntypeSeries) -> Double { @_common.std(s.vals) }

pub fn chem_rxn_type_series_median(s : ChemrxntypeSeries) -> Double { @_common.median(s.vals) }

pub fn chem_rxn_type_series_scale(s : ChemrxntypeSeries, f : Double) -> ChemrxntypeSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_rxn_type_series_add(a : ChemrxntypeSeries, b : ChemrxntypeSeries) -> ChemrxntypeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_rxn_type_series_sub(a : ChemrxntypeSeries, b : ChemrxntypeSeries) -> ChemrxntypeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_rxn_type_series_normalize(s : ChemrxntypeSeries) -> ChemrxntypeSeries {
  let mn = chem_rxn_type_series_min(s)
  let mx = chem_rxn_type_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_rxn_type_series_cumsum(s : ChemrxntypeSeries) -> ChemrxntypeSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_rxn_type_series_to_string(s : ChemrxntypeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxntypeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_type_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxntypeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_type_matrix_identity(n : Int) -> ChemrxntypeMatrix {
  let m = chem_rxn_type_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_rxn_type_matrix_get(m : ChemrxntypeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_rxn_type_matrix_transpose(m : ChemrxntypeMatrix) -> ChemrxntypeMatrix {
  let result = chem_rxn_type_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_rxn_type_matrix_add(a : ChemrxntypeMatrix, b : ChemrxntypeMatrix) -> ChemrxntypeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_rxn_type_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_rxn_type_matrix_scale(m : ChemrxntypeMatrix, s : Double) -> ChemrxntypeMatrix {
  let result = chem_rxn_type_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_rxn_type_matrix_multiply(a : ChemrxntypeMatrix, b : ChemrxntypeMatrix) -> ChemrxntypeMatrix {
  if a.cols != b.rows { return chem_rxn_type_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_rxn_type_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_rxn_type_matrix_trace(m : ChemrxntypeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_rxn_type_matrix_det(m : ChemrxntypeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_rxn_type_matrix_norm(m : ChemrxntypeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_rxn_type_matrix_to_string(m : ChemrxntypeMatrix) -> String {
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

pub(all) struct ChemrxntypeVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_type_make_vector(comps : Array[Double]) -> ChemrxntypeVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_type_vector_zero(dim : Int) -> ChemrxntypeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_rxn_type_vector_add(a : ChemrxntypeVector, b : ChemrxntypeVector) -> ChemrxntypeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_rxn_type_vector_sub(a : ChemrxntypeVector, b : ChemrxntypeVector) -> ChemrxntypeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_rxn_type_vector_scale(v : ChemrxntypeVector, s : Double) -> ChemrxntypeVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_rxn_type_vector_dot(a : ChemrxntypeVector, b : ChemrxntypeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_rxn_type_vector_norm(v : ChemrxntypeVector) -> Double { @_common.sqrt(chem_rxn_type_vector_dot(v, v)) }

pub fn chem_rxn_type_vector_normalize(v : ChemrxntypeVector) -> ChemrxntypeVector {
  let n = chem_rxn_type_vector_norm(v)
  if n < 0.0000001 { v } else { chem_rxn_type_vector_scale(v, 1.0 / n) }
}

pub fn chem_rxn_type_vector_dist(a : ChemrxntypeVector, b : ChemrxntypeVector) -> Double {
  chem_rxn_type_vector_norm(chem_rxn_type_vector_sub(a, b))
}

pub fn chem_rxn_type_vector_to_string(v : ChemrxntypeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_rxn_type_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_rxn_type_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_rxn_type_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_rxn_type_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_rxn_type_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_rxn_type_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_rxn_type_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_rxn_type_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_rxn_type_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_rxn_type_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_rxn_type_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_rxn_type_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_rxn_type_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_rxn_type_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_rxn_type_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_rxn_type_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_rxn_type_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_rxn_type_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_rxn_type_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_rxn_type_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_rxn_type_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_rxn_type_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_rxn_type_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_rxn_type_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_rxn_type_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_rxn_type_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_rxn_type_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_rxn_type_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_rxn_type_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemrxntypeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_frame_make(size : Int) -> ChemrxntypeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_frame_len(s : ChemrxntypeFrame) -> Int { s.size }

pub fn chem_rxn_type_frame_get(s : ChemrxntypeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_frame_set(s : ChemrxntypeFrame, i : Int, v : Double) -> ChemrxntypeFrame {
  let result = chem_rxn_type_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_frame_sum(s : ChemrxntypeFrame) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_frame_mean(s : ChemrxntypeFrame) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_frame_scale(s : ChemrxntypeFrame, f : Double) -> ChemrxntypeFrame {
  let result = chem_rxn_type_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_type_frame_add(a : ChemrxntypeFrame, b : ChemrxntypeFrame) -> ChemrxntypeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_type_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_type_frame_copy(s : ChemrxntypeFrame) -> ChemrxntypeFrame {
  let result = chem_rxn_type_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_type_frame_fill(s : ChemrxntypeFrame, v : Double) -> ChemrxntypeFrame {
  let result = chem_rxn_type_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_frame_min(s : ChemrxntypeFrame) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_frame_max(s : ChemrxntypeFrame) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_frame_to_string(s : ChemrxntypeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_table_make(size : Int) -> ChemrxntypeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_table_len(s : ChemrxntypeTable) -> Int { s.size }

pub fn chem_rxn_type_table_get(s : ChemrxntypeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_table_set(s : ChemrxntypeTable, i : Int, v : Double) -> ChemrxntypeTable {
  let result = chem_rxn_type_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_table_sum(s : ChemrxntypeTable) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_table_mean(s : ChemrxntypeTable) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_table_scale(s : ChemrxntypeTable, f : Double) -> ChemrxntypeTable {
  let result = chem_rxn_type_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_type_table_add(a : ChemrxntypeTable, b : ChemrxntypeTable) -> ChemrxntypeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_type_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_type_table_copy(s : ChemrxntypeTable) -> ChemrxntypeTable {
  let result = chem_rxn_type_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_type_table_fill(s : ChemrxntypeTable, v : Double) -> ChemrxntypeTable {
  let result = chem_rxn_type_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_table_min(s : ChemrxntypeTable) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_table_max(s : ChemrxntypeTable) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_table_to_string(s : ChemrxntypeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_graphn_make(size : Int) -> ChemrxntypeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_graphn_len(s : ChemrxntypeGraphN) -> Int { s.size }

pub fn chem_rxn_type_graphn_get(s : ChemrxntypeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_graphn_set(s : ChemrxntypeGraphN, i : Int, v : Double) -> ChemrxntypeGraphN {
  let result = chem_rxn_type_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_graphn_sum(s : ChemrxntypeGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_graphn_mean(s : ChemrxntypeGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_graphn_scale(s : ChemrxntypeGraphN, f : Double) -> ChemrxntypeGraphN {
  let result = chem_rxn_type_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_type_graphn_add(a : ChemrxntypeGraphN, b : ChemrxntypeGraphN) -> ChemrxntypeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_type_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_type_graphn_copy(s : ChemrxntypeGraphN) -> ChemrxntypeGraphN {
  let result = chem_rxn_type_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_type_graphn_fill(s : ChemrxntypeGraphN, v : Double) -> ChemrxntypeGraphN {
  let result = chem_rxn_type_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_graphn_min(s : ChemrxntypeGraphN) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_graphn_max(s : ChemrxntypeGraphN) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_graphn_to_string(s : ChemrxntypeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_node_make(size : Int) -> ChemrxntypeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_node_len(s : ChemrxntypeNode) -> Int { s.size }

pub fn chem_rxn_type_node_get(s : ChemrxntypeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_node_set(s : ChemrxntypeNode, i : Int, v : Double) -> ChemrxntypeNode {
  let result = chem_rxn_type_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_node_sum(s : ChemrxntypeNode) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_node_mean(s : ChemrxntypeNode) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_node_scale(s : ChemrxntypeNode, f : Double) -> ChemrxntypeNode {
  let result = chem_rxn_type_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_type_node_add(a : ChemrxntypeNode, b : ChemrxntypeNode) -> ChemrxntypeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_type_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_type_node_copy(s : ChemrxntypeNode) -> ChemrxntypeNode {
  let result = chem_rxn_type_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_type_node_fill(s : ChemrxntypeNode, v : Double) -> ChemrxntypeNode {
  let result = chem_rxn_type_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_node_min(s : ChemrxntypeNode) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_node_max(s : ChemrxntypeNode) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_node_to_string(s : ChemrxntypeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_edge_make(size : Int) -> ChemrxntypeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_edge_len(s : ChemrxntypeEdge) -> Int { s.size }

pub fn chem_rxn_type_edge_get(s : ChemrxntypeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_edge_set(s : ChemrxntypeEdge, i : Int, v : Double) -> ChemrxntypeEdge {
  let result = chem_rxn_type_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_edge_sum(s : ChemrxntypeEdge) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_edge_mean(s : ChemrxntypeEdge) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_edge_scale(s : ChemrxntypeEdge, f : Double) -> ChemrxntypeEdge {
  let result = chem_rxn_type_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_type_edge_add(a : ChemrxntypeEdge, b : ChemrxntypeEdge) -> ChemrxntypeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_type_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_type_edge_copy(s : ChemrxntypeEdge) -> ChemrxntypeEdge {
  let result = chem_rxn_type_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_type_edge_fill(s : ChemrxntypeEdge, v : Double) -> ChemrxntypeEdge {
  let result = chem_rxn_type_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_edge_min(s : ChemrxntypeEdge) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_edge_max(s : ChemrxntypeEdge) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_edge_to_string(s : ChemrxntypeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_path_make(size : Int) -> ChemrxntypePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_path_len(s : ChemrxntypePath) -> Int { s.size }

pub fn chem_rxn_type_path_get(s : ChemrxntypePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_path_set(s : ChemrxntypePath, i : Int, v : Double) -> ChemrxntypePath {
  let result = chem_rxn_type_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_path_sum(s : ChemrxntypePath) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_path_mean(s : ChemrxntypePath) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_path_scale(s : ChemrxntypePath, f : Double) -> ChemrxntypePath {
  let result = chem_rxn_type_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_type_path_add(a : ChemrxntypePath, b : ChemrxntypePath) -> ChemrxntypePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_type_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_type_path_copy(s : ChemrxntypePath) -> ChemrxntypePath {
  let result = chem_rxn_type_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_type_path_fill(s : ChemrxntypePath, v : Double) -> ChemrxntypePath {
  let result = chem_rxn_type_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_path_min(s : ChemrxntypePath) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_path_max(s : ChemrxntypePath) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_path_to_string(s : ChemrxntypePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_cluster_make(size : Int) -> ChemrxntypeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_cluster_len(s : ChemrxntypeCluster) -> Int { s.size }

pub fn chem_rxn_type_cluster_get(s : ChemrxntypeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_cluster_set(s : ChemrxntypeCluster, i : Int, v : Double) -> ChemrxntypeCluster {
  let result = chem_rxn_type_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_cluster_sum(s : ChemrxntypeCluster) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_cluster_mean(s : ChemrxntypeCluster) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_cluster_scale(s : ChemrxntypeCluster, f : Double) -> ChemrxntypeCluster {
  let result = chem_rxn_type_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_type_cluster_add(a : ChemrxntypeCluster, b : ChemrxntypeCluster) -> ChemrxntypeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_type_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_type_cluster_copy(s : ChemrxntypeCluster) -> ChemrxntypeCluster {
  let result = chem_rxn_type_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_type_cluster_fill(s : ChemrxntypeCluster, v : Double) -> ChemrxntypeCluster {
  let result = chem_rxn_type_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_cluster_min(s : ChemrxntypeCluster) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_cluster_max(s : ChemrxntypeCluster) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_cluster_to_string(s : ChemrxntypeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_model_make(size : Int) -> ChemrxntypeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_model_len(s : ChemrxntypeModel) -> Int { s.size }

pub fn chem_rxn_type_model_get(s : ChemrxntypeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_model_set(s : ChemrxntypeModel, i : Int, v : Double) -> ChemrxntypeModel {
  let result = chem_rxn_type_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_model_sum(s : ChemrxntypeModel) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_model_mean(s : ChemrxntypeModel) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_model_scale(s : ChemrxntypeModel, f : Double) -> ChemrxntypeModel {
  let result = chem_rxn_type_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_type_model_add(a : ChemrxntypeModel, b : ChemrxntypeModel) -> ChemrxntypeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_type_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_type_model_copy(s : ChemrxntypeModel) -> ChemrxntypeModel {
  let result = chem_rxn_type_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_type_model_fill(s : ChemrxntypeModel, v : Double) -> ChemrxntypeModel {
  let result = chem_rxn_type_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_model_min(s : ChemrxntypeModel) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_model_max(s : ChemrxntypeModel) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_model_to_string(s : ChemrxntypeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_layer_make(size : Int) -> ChemrxntypeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_layer_len(s : ChemrxntypeLayer) -> Int { s.size }

pub fn chem_rxn_type_layer_get(s : ChemrxntypeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_layer_set(s : ChemrxntypeLayer, i : Int, v : Double) -> ChemrxntypeLayer {
  let result = chem_rxn_type_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_layer_sum(s : ChemrxntypeLayer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_layer_mean(s : ChemrxntypeLayer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_layer_scale(s : ChemrxntypeLayer, f : Double) -> ChemrxntypeLayer {
  let result = chem_rxn_type_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_type_layer_add(a : ChemrxntypeLayer, b : ChemrxntypeLayer) -> ChemrxntypeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_type_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_type_layer_copy(s : ChemrxntypeLayer) -> ChemrxntypeLayer {
  let result = chem_rxn_type_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_type_layer_fill(s : ChemrxntypeLayer, v : Double) -> ChemrxntypeLayer {
  let result = chem_rxn_type_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_layer_min(s : ChemrxntypeLayer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_layer_max(s : ChemrxntypeLayer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_layer_to_string(s : ChemrxntypeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_buffer_make(size : Int) -> ChemrxntypeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_buffer_len(s : ChemrxntypeBuffer) -> Int { s.size }

pub fn chem_rxn_type_buffer_get(s : ChemrxntypeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_buffer_set(s : ChemrxntypeBuffer, i : Int, v : Double) -> ChemrxntypeBuffer {
  let result = chem_rxn_type_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_buffer_sum(s : ChemrxntypeBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_buffer_mean(s : ChemrxntypeBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_buffer_scale(s : ChemrxntypeBuffer, f : Double) -> ChemrxntypeBuffer {
  let result = chem_rxn_type_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_type_buffer_add(a : ChemrxntypeBuffer, b : ChemrxntypeBuffer) -> ChemrxntypeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_type_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_type_buffer_copy(s : ChemrxntypeBuffer) -> ChemrxntypeBuffer {
  let result = chem_rxn_type_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_type_buffer_fill(s : ChemrxntypeBuffer, v : Double) -> ChemrxntypeBuffer {
  let result = chem_rxn_type_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_buffer_min(s : ChemrxntypeBuffer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_buffer_max(s : ChemrxntypeBuffer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_buffer_to_string(s : ChemrxntypeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_cursor_make(size : Int) -> ChemrxntypeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_cursor_len(s : ChemrxntypeCursor) -> Int { s.size }

pub fn chem_rxn_type_cursor_get(s : ChemrxntypeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_cursor_set(s : ChemrxntypeCursor, i : Int, v : Double) -> ChemrxntypeCursor {
  let result = chem_rxn_type_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_cursor_sum(s : ChemrxntypeCursor) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_cursor_mean(s : ChemrxntypeCursor) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_cursor_scale(s : ChemrxntypeCursor, f : Double) -> ChemrxntypeCursor {
  let result = chem_rxn_type_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_type_cursor_add(a : ChemrxntypeCursor, b : ChemrxntypeCursor) -> ChemrxntypeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_type_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_type_cursor_copy(s : ChemrxntypeCursor) -> ChemrxntypeCursor {
  let result = chem_rxn_type_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_type_cursor_fill(s : ChemrxntypeCursor, v : Double) -> ChemrxntypeCursor {
  let result = chem_rxn_type_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_cursor_min(s : ChemrxntypeCursor) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_cursor_max(s : ChemrxntypeCursor) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_cursor_to_string(s : ChemrxntypeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_view_make(size : Int) -> ChemrxntypeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_view_len(s : ChemrxntypeView) -> Int { s.size }

pub fn chem_rxn_type_view_get(s : ChemrxntypeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_view_set(s : ChemrxntypeView, i : Int, v : Double) -> ChemrxntypeView {
  let result = chem_rxn_type_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_view_sum(s : ChemrxntypeView) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_view_mean(s : ChemrxntypeView) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_view_scale(s : ChemrxntypeView, f : Double) -> ChemrxntypeView {
  let result = chem_rxn_type_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_type_view_add(a : ChemrxntypeView, b : ChemrxntypeView) -> ChemrxntypeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_type_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_type_view_copy(s : ChemrxntypeView) -> ChemrxntypeView {
  let result = chem_rxn_type_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_type_view_fill(s : ChemrxntypeView, v : Double) -> ChemrxntypeView {
  let result = chem_rxn_type_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_view_min(s : ChemrxntypeView) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_view_max(s : ChemrxntypeView) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_view_to_string(s : ChemrxntypeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_range_make(size : Int) -> ChemrxntypeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_range_len(s : ChemrxntypeRange) -> Int { s.size }

pub fn chem_rxn_type_range_get(s : ChemrxntypeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_range_set(s : ChemrxntypeRange, i : Int, v : Double) -> ChemrxntypeRange {
  let result = chem_rxn_type_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_range_sum(s : ChemrxntypeRange) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_range_mean(s : ChemrxntypeRange) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_range_scale(s : ChemrxntypeRange, f : Double) -> ChemrxntypeRange {
  let result = chem_rxn_type_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_type_range_add(a : ChemrxntypeRange, b : ChemrxntypeRange) -> ChemrxntypeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_type_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_type_range_copy(s : ChemrxntypeRange) -> ChemrxntypeRange {
  let result = chem_rxn_type_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_type_range_fill(s : ChemrxntypeRange, v : Double) -> ChemrxntypeRange {
  let result = chem_rxn_type_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_range_min(s : ChemrxntypeRange) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_range_max(s : ChemrxntypeRange) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_range_to_string(s : ChemrxntypeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_slice_make(size : Int) -> ChemrxntypeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_slice_len(s : ChemrxntypeSlice) -> Int { s.size }

pub fn chem_rxn_type_slice_get(s : ChemrxntypeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_slice_set(s : ChemrxntypeSlice, i : Int, v : Double) -> ChemrxntypeSlice {
  let result = chem_rxn_type_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_slice_sum(s : ChemrxntypeSlice) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_slice_mean(s : ChemrxntypeSlice) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_slice_scale(s : ChemrxntypeSlice, f : Double) -> ChemrxntypeSlice {
  let result = chem_rxn_type_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_type_slice_add(a : ChemrxntypeSlice, b : ChemrxntypeSlice) -> ChemrxntypeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_type_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_type_slice_copy(s : ChemrxntypeSlice) -> ChemrxntypeSlice {
  let result = chem_rxn_type_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_type_slice_fill(s : ChemrxntypeSlice, v : Double) -> ChemrxntypeSlice {
  let result = chem_rxn_type_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_type_slice_min(s : ChemrxntypeSlice) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_slice_max(s : ChemrxntypeSlice) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_slice_to_string(s : ChemrxntypeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

