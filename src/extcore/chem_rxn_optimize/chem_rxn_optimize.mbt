///===
/// extcore/chem_rxn_optimize

pub(all) struct ChemrxnoptimizePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_optimize_make_point(x : Double, y : Double) -> ChemrxnoptimizePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_optimize_make_point3(x : Double, y : Double, z : Double) -> ChemrxnoptimizePoint {
  { x, y, z, label: 0 }
}

pub fn chem_rxn_optimize_point_x(pt : ChemrxnoptimizePoint) -> Double { pt.x }

pub fn chem_rxn_optimize_point_y(pt : ChemrxnoptimizePoint) -> Double { pt.y }

pub fn chem_rxn_optimize_point_z(pt : ChemrxnoptimizePoint) -> Double { pt.z }

pub fn chem_rxn_optimize_point_label(pt : ChemrxnoptimizePoint) -> Int { pt.label }

pub fn chem_rxn_optimize_point_dist(a : ChemrxnoptimizePoint, b : ChemrxnoptimizePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_rxn_optimize_point_add(a : ChemrxnoptimizePoint, b : ChemrxnoptimizePoint) -> ChemrxnoptimizePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_rxn_optimize_point_sub(a : ChemrxnoptimizePoint, b : ChemrxnoptimizePoint) -> ChemrxnoptimizePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_rxn_optimize_point_scale(pt : ChemrxnoptimizePoint, s : Double) -> ChemrxnoptimizePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_rxn_optimize_point_dot(a : ChemrxnoptimizePoint, b : ChemrxnoptimizePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_rxn_optimize_point_cross(a : ChemrxnoptimizePoint, b : ChemrxnoptimizePoint) -> ChemrxnoptimizePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_rxn_optimize_point_norm(pt : ChemrxnoptimizePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_rxn_optimize_point_normalize(pt : ChemrxnoptimizePoint) -> ChemrxnoptimizePoint {
  let n = chem_rxn_optimize_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_rxn_optimize_point_scale(pt, 1.0 / n) }
}

pub fn chem_rxn_optimize_point_negate(pt : ChemrxnoptimizePoint) -> ChemrxnoptimizePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_rxn_optimize_point_mid(a : ChemrxnoptimizePoint, b : ChemrxnoptimizePoint) -> ChemrxnoptimizePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_rxn_optimize_point_lerp(a : ChemrxnoptimizePoint, b : ChemrxnoptimizePoint, t : Double) -> ChemrxnoptimizePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_rxn_optimize_point_to_string(pt : ChemrxnoptimizePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_optimize_make_series(vals : Array[Double], name : String) -> ChemrxnoptimizeSeries {
  { vals, name, meta: 0 }
}

pub fn chem_rxn_optimize_series_len(s : ChemrxnoptimizeSeries) -> Int { s.vals.length() }

pub fn chem_rxn_optimize_series_sum(s : ChemrxnoptimizeSeries) -> Double { @_common.sum(s.vals) }

pub fn chem_rxn_optimize_series_mean(s : ChemrxnoptimizeSeries) -> Double { @_common.mean(s.vals) }

pub fn chem_rxn_optimize_series_min(s : ChemrxnoptimizeSeries) -> Double { @_common.min(s.vals) }

pub fn chem_rxn_optimize_series_max(s : ChemrxnoptimizeSeries) -> Double { @_common.max(s.vals) }

pub fn chem_rxn_optimize_series_range(s : ChemrxnoptimizeSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn chem_rxn_optimize_series_var(s : ChemrxnoptimizeSeries) -> Double { @_common.variance(s.vals) }

pub fn chem_rxn_optimize_series_std(s : ChemrxnoptimizeSeries) -> Double { @_common.std(s.vals) }

pub fn chem_rxn_optimize_series_median(s : ChemrxnoptimizeSeries) -> Double { @_common.median(s.vals) }

pub fn chem_rxn_optimize_series_scale(s : ChemrxnoptimizeSeries, f : Double) -> ChemrxnoptimizeSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_rxn_optimize_series_add(a : ChemrxnoptimizeSeries, b : ChemrxnoptimizeSeries) -> ChemrxnoptimizeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_rxn_optimize_series_sub(a : ChemrxnoptimizeSeries, b : ChemrxnoptimizeSeries) -> ChemrxnoptimizeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_rxn_optimize_series_normalize(s : ChemrxnoptimizeSeries) -> ChemrxnoptimizeSeries {
  let mn = chem_rxn_optimize_series_min(s)
  let mx = chem_rxn_optimize_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_rxn_optimize_series_cumsum(s : ChemrxnoptimizeSeries) -> ChemrxnoptimizeSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_rxn_optimize_series_to_string(s : ChemrxnoptimizeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnoptimizeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_optimize_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxnoptimizeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_optimize_matrix_identity(n : Int) -> ChemrxnoptimizeMatrix {
  let m = chem_rxn_optimize_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_rxn_optimize_matrix_get(m : ChemrxnoptimizeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_rxn_optimize_matrix_transpose(m : ChemrxnoptimizeMatrix) -> ChemrxnoptimizeMatrix {
  let result = chem_rxn_optimize_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_rxn_optimize_matrix_add(a : ChemrxnoptimizeMatrix, b : ChemrxnoptimizeMatrix) -> ChemrxnoptimizeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_rxn_optimize_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_rxn_optimize_matrix_scale(m : ChemrxnoptimizeMatrix, s : Double) -> ChemrxnoptimizeMatrix {
  let result = chem_rxn_optimize_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_rxn_optimize_matrix_multiply(a : ChemrxnoptimizeMatrix, b : ChemrxnoptimizeMatrix) -> ChemrxnoptimizeMatrix {
  if a.cols != b.rows { return chem_rxn_optimize_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_rxn_optimize_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_rxn_optimize_matrix_trace(m : ChemrxnoptimizeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_rxn_optimize_matrix_det(m : ChemrxnoptimizeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_rxn_optimize_matrix_norm(m : ChemrxnoptimizeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_rxn_optimize_matrix_to_string(m : ChemrxnoptimizeMatrix) -> String {
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

pub(all) struct ChemrxnoptimizeVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_optimize_make_vector(comps : Array[Double]) -> ChemrxnoptimizeVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_optimize_vector_zero(dim : Int) -> ChemrxnoptimizeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_rxn_optimize_vector_add(a : ChemrxnoptimizeVector, b : ChemrxnoptimizeVector) -> ChemrxnoptimizeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_rxn_optimize_vector_sub(a : ChemrxnoptimizeVector, b : ChemrxnoptimizeVector) -> ChemrxnoptimizeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_rxn_optimize_vector_scale(v : ChemrxnoptimizeVector, s : Double) -> ChemrxnoptimizeVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_rxn_optimize_vector_dot(a : ChemrxnoptimizeVector, b : ChemrxnoptimizeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_rxn_optimize_vector_norm(v : ChemrxnoptimizeVector) -> Double { @_common.sqrt(chem_rxn_optimize_vector_dot(v, v)) }

pub fn chem_rxn_optimize_vector_normalize(v : ChemrxnoptimizeVector) -> ChemrxnoptimizeVector {
  let n = chem_rxn_optimize_vector_norm(v)
  if n < 0.0000001 { v } else { chem_rxn_optimize_vector_scale(v, 1.0 / n) }
}

pub fn chem_rxn_optimize_vector_dist(a : ChemrxnoptimizeVector, b : ChemrxnoptimizeVector) -> Double {
  chem_rxn_optimize_vector_norm(chem_rxn_optimize_vector_sub(a, b))
}

pub fn chem_rxn_optimize_vector_to_string(v : ChemrxnoptimizeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_rxn_optimize_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_rxn_optimize_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_rxn_optimize_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_rxn_optimize_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_rxn_optimize_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_rxn_optimize_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_rxn_optimize_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_rxn_optimize_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_rxn_optimize_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_rxn_optimize_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_rxn_optimize_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_rxn_optimize_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_rxn_optimize_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_rxn_optimize_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_rxn_optimize_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_rxn_optimize_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_rxn_optimize_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_rxn_optimize_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_rxn_optimize_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_rxn_optimize_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_rxn_optimize_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_rxn_optimize_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_rxn_optimize_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_rxn_optimize_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_rxn_optimize_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_rxn_optimize_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_rxn_optimize_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_rxn_optimize_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_rxn_optimize_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemrxnoptimizeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_frame_make(size : Int) -> ChemrxnoptimizeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_frame_len(s : ChemrxnoptimizeFrame) -> Int { s.size }

pub fn chem_rxn_optimize_frame_get(s : ChemrxnoptimizeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_frame_set(s : ChemrxnoptimizeFrame, i : Int, v : Double) -> ChemrxnoptimizeFrame {
  let result = chem_rxn_optimize_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_frame_sum(s : ChemrxnoptimizeFrame) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_frame_mean(s : ChemrxnoptimizeFrame) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_frame_scale(s : ChemrxnoptimizeFrame, f : Double) -> ChemrxnoptimizeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_frame_add(a : ChemrxnoptimizeFrame, b : ChemrxnoptimizeFrame) -> ChemrxnoptimizeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_frame_copy(s : ChemrxnoptimizeFrame) -> ChemrxnoptimizeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_frame_fill(s : ChemrxnoptimizeFrame, v : Double) -> ChemrxnoptimizeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_frame_min(s : ChemrxnoptimizeFrame) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_frame_max(s : ChemrxnoptimizeFrame) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_frame_to_string(s : ChemrxnoptimizeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_table_make(size : Int) -> ChemrxnoptimizeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_table_len(s : ChemrxnoptimizeTable) -> Int { s.size }

pub fn chem_rxn_optimize_table_get(s : ChemrxnoptimizeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_table_set(s : ChemrxnoptimizeTable, i : Int, v : Double) -> ChemrxnoptimizeTable {
  let result = chem_rxn_optimize_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_table_sum(s : ChemrxnoptimizeTable) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_table_mean(s : ChemrxnoptimizeTable) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_table_scale(s : ChemrxnoptimizeTable, f : Double) -> ChemrxnoptimizeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_table_add(a : ChemrxnoptimizeTable, b : ChemrxnoptimizeTable) -> ChemrxnoptimizeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_table_copy(s : ChemrxnoptimizeTable) -> ChemrxnoptimizeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_table_fill(s : ChemrxnoptimizeTable, v : Double) -> ChemrxnoptimizeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_table_min(s : ChemrxnoptimizeTable) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_table_max(s : ChemrxnoptimizeTable) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_table_to_string(s : ChemrxnoptimizeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_graphn_make(size : Int) -> ChemrxnoptimizeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_graphn_len(s : ChemrxnoptimizeGraphN) -> Int { s.size }

pub fn chem_rxn_optimize_graphn_get(s : ChemrxnoptimizeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_graphn_set(s : ChemrxnoptimizeGraphN, i : Int, v : Double) -> ChemrxnoptimizeGraphN {
  let result = chem_rxn_optimize_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_graphn_sum(s : ChemrxnoptimizeGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_graphn_mean(s : ChemrxnoptimizeGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_graphn_scale(s : ChemrxnoptimizeGraphN, f : Double) -> ChemrxnoptimizeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_graphn_add(a : ChemrxnoptimizeGraphN, b : ChemrxnoptimizeGraphN) -> ChemrxnoptimizeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_graphn_copy(s : ChemrxnoptimizeGraphN) -> ChemrxnoptimizeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_graphn_fill(s : ChemrxnoptimizeGraphN, v : Double) -> ChemrxnoptimizeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_graphn_min(s : ChemrxnoptimizeGraphN) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_graphn_max(s : ChemrxnoptimizeGraphN) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_graphn_to_string(s : ChemrxnoptimizeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_node_make(size : Int) -> ChemrxnoptimizeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_node_len(s : ChemrxnoptimizeNode) -> Int { s.size }

pub fn chem_rxn_optimize_node_get(s : ChemrxnoptimizeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_node_set(s : ChemrxnoptimizeNode, i : Int, v : Double) -> ChemrxnoptimizeNode {
  let result = chem_rxn_optimize_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_node_sum(s : ChemrxnoptimizeNode) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_node_mean(s : ChemrxnoptimizeNode) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_node_scale(s : ChemrxnoptimizeNode, f : Double) -> ChemrxnoptimizeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_node_add(a : ChemrxnoptimizeNode, b : ChemrxnoptimizeNode) -> ChemrxnoptimizeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_node_copy(s : ChemrxnoptimizeNode) -> ChemrxnoptimizeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_node_fill(s : ChemrxnoptimizeNode, v : Double) -> ChemrxnoptimizeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_node_min(s : ChemrxnoptimizeNode) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_node_max(s : ChemrxnoptimizeNode) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_node_to_string(s : ChemrxnoptimizeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_edge_make(size : Int) -> ChemrxnoptimizeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_edge_len(s : ChemrxnoptimizeEdge) -> Int { s.size }

pub fn chem_rxn_optimize_edge_get(s : ChemrxnoptimizeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_edge_set(s : ChemrxnoptimizeEdge, i : Int, v : Double) -> ChemrxnoptimizeEdge {
  let result = chem_rxn_optimize_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_edge_sum(s : ChemrxnoptimizeEdge) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_edge_mean(s : ChemrxnoptimizeEdge) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_edge_scale(s : ChemrxnoptimizeEdge, f : Double) -> ChemrxnoptimizeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_edge_add(a : ChemrxnoptimizeEdge, b : ChemrxnoptimizeEdge) -> ChemrxnoptimizeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_edge_copy(s : ChemrxnoptimizeEdge) -> ChemrxnoptimizeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_edge_fill(s : ChemrxnoptimizeEdge, v : Double) -> ChemrxnoptimizeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_edge_min(s : ChemrxnoptimizeEdge) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_edge_max(s : ChemrxnoptimizeEdge) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_edge_to_string(s : ChemrxnoptimizeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_path_make(size : Int) -> ChemrxnoptimizePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_path_len(s : ChemrxnoptimizePath) -> Int { s.size }

pub fn chem_rxn_optimize_path_get(s : ChemrxnoptimizePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_path_set(s : ChemrxnoptimizePath, i : Int, v : Double) -> ChemrxnoptimizePath {
  let result = chem_rxn_optimize_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_path_sum(s : ChemrxnoptimizePath) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_path_mean(s : ChemrxnoptimizePath) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_path_scale(s : ChemrxnoptimizePath, f : Double) -> ChemrxnoptimizePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_path_add(a : ChemrxnoptimizePath, b : ChemrxnoptimizePath) -> ChemrxnoptimizePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_path_copy(s : ChemrxnoptimizePath) -> ChemrxnoptimizePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_path_fill(s : ChemrxnoptimizePath, v : Double) -> ChemrxnoptimizePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_path_min(s : ChemrxnoptimizePath) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_path_max(s : ChemrxnoptimizePath) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_path_to_string(s : ChemrxnoptimizePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_cluster_make(size : Int) -> ChemrxnoptimizeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_cluster_len(s : ChemrxnoptimizeCluster) -> Int { s.size }

pub fn chem_rxn_optimize_cluster_get(s : ChemrxnoptimizeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_cluster_set(s : ChemrxnoptimizeCluster, i : Int, v : Double) -> ChemrxnoptimizeCluster {
  let result = chem_rxn_optimize_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_cluster_sum(s : ChemrxnoptimizeCluster) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_cluster_mean(s : ChemrxnoptimizeCluster) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_cluster_scale(s : ChemrxnoptimizeCluster, f : Double) -> ChemrxnoptimizeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_cluster_add(a : ChemrxnoptimizeCluster, b : ChemrxnoptimizeCluster) -> ChemrxnoptimizeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_cluster_copy(s : ChemrxnoptimizeCluster) -> ChemrxnoptimizeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_cluster_fill(s : ChemrxnoptimizeCluster, v : Double) -> ChemrxnoptimizeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_cluster_min(s : ChemrxnoptimizeCluster) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_cluster_max(s : ChemrxnoptimizeCluster) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_cluster_to_string(s : ChemrxnoptimizeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_model_make(size : Int) -> ChemrxnoptimizeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_model_len(s : ChemrxnoptimizeModel) -> Int { s.size }

pub fn chem_rxn_optimize_model_get(s : ChemrxnoptimizeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_model_set(s : ChemrxnoptimizeModel, i : Int, v : Double) -> ChemrxnoptimizeModel {
  let result = chem_rxn_optimize_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_model_sum(s : ChemrxnoptimizeModel) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_model_mean(s : ChemrxnoptimizeModel) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_model_scale(s : ChemrxnoptimizeModel, f : Double) -> ChemrxnoptimizeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_model_add(a : ChemrxnoptimizeModel, b : ChemrxnoptimizeModel) -> ChemrxnoptimizeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_model_copy(s : ChemrxnoptimizeModel) -> ChemrxnoptimizeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_model_fill(s : ChemrxnoptimizeModel, v : Double) -> ChemrxnoptimizeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_model_min(s : ChemrxnoptimizeModel) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_model_max(s : ChemrxnoptimizeModel) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_model_to_string(s : ChemrxnoptimizeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_layer_make(size : Int) -> ChemrxnoptimizeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_layer_len(s : ChemrxnoptimizeLayer) -> Int { s.size }

pub fn chem_rxn_optimize_layer_get(s : ChemrxnoptimizeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_layer_set(s : ChemrxnoptimizeLayer, i : Int, v : Double) -> ChemrxnoptimizeLayer {
  let result = chem_rxn_optimize_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_layer_sum(s : ChemrxnoptimizeLayer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_layer_mean(s : ChemrxnoptimizeLayer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_layer_scale(s : ChemrxnoptimizeLayer, f : Double) -> ChemrxnoptimizeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_layer_add(a : ChemrxnoptimizeLayer, b : ChemrxnoptimizeLayer) -> ChemrxnoptimizeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_layer_copy(s : ChemrxnoptimizeLayer) -> ChemrxnoptimizeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_layer_fill(s : ChemrxnoptimizeLayer, v : Double) -> ChemrxnoptimizeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_layer_min(s : ChemrxnoptimizeLayer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_layer_max(s : ChemrxnoptimizeLayer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_layer_to_string(s : ChemrxnoptimizeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_buffer_make(size : Int) -> ChemrxnoptimizeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_buffer_len(s : ChemrxnoptimizeBuffer) -> Int { s.size }

pub fn chem_rxn_optimize_buffer_get(s : ChemrxnoptimizeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_buffer_set(s : ChemrxnoptimizeBuffer, i : Int, v : Double) -> ChemrxnoptimizeBuffer {
  let result = chem_rxn_optimize_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_buffer_sum(s : ChemrxnoptimizeBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_buffer_mean(s : ChemrxnoptimizeBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_buffer_scale(s : ChemrxnoptimizeBuffer, f : Double) -> ChemrxnoptimizeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_buffer_add(a : ChemrxnoptimizeBuffer, b : ChemrxnoptimizeBuffer) -> ChemrxnoptimizeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_buffer_copy(s : ChemrxnoptimizeBuffer) -> ChemrxnoptimizeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_buffer_fill(s : ChemrxnoptimizeBuffer, v : Double) -> ChemrxnoptimizeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_buffer_min(s : ChemrxnoptimizeBuffer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_buffer_max(s : ChemrxnoptimizeBuffer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_buffer_to_string(s : ChemrxnoptimizeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_cursor_make(size : Int) -> ChemrxnoptimizeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_cursor_len(s : ChemrxnoptimizeCursor) -> Int { s.size }

pub fn chem_rxn_optimize_cursor_get(s : ChemrxnoptimizeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_cursor_set(s : ChemrxnoptimizeCursor, i : Int, v : Double) -> ChemrxnoptimizeCursor {
  let result = chem_rxn_optimize_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_cursor_sum(s : ChemrxnoptimizeCursor) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_cursor_mean(s : ChemrxnoptimizeCursor) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_cursor_scale(s : ChemrxnoptimizeCursor, f : Double) -> ChemrxnoptimizeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_cursor_add(a : ChemrxnoptimizeCursor, b : ChemrxnoptimizeCursor) -> ChemrxnoptimizeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_cursor_copy(s : ChemrxnoptimizeCursor) -> ChemrxnoptimizeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_cursor_fill(s : ChemrxnoptimizeCursor, v : Double) -> ChemrxnoptimizeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_cursor_min(s : ChemrxnoptimizeCursor) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_cursor_max(s : ChemrxnoptimizeCursor) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_cursor_to_string(s : ChemrxnoptimizeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_view_make(size : Int) -> ChemrxnoptimizeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_view_len(s : ChemrxnoptimizeView) -> Int { s.size }

pub fn chem_rxn_optimize_view_get(s : ChemrxnoptimizeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_view_set(s : ChemrxnoptimizeView, i : Int, v : Double) -> ChemrxnoptimizeView {
  let result = chem_rxn_optimize_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_view_sum(s : ChemrxnoptimizeView) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_view_mean(s : ChemrxnoptimizeView) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_view_scale(s : ChemrxnoptimizeView, f : Double) -> ChemrxnoptimizeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_view_add(a : ChemrxnoptimizeView, b : ChemrxnoptimizeView) -> ChemrxnoptimizeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_view_copy(s : ChemrxnoptimizeView) -> ChemrxnoptimizeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_view_fill(s : ChemrxnoptimizeView, v : Double) -> ChemrxnoptimizeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_view_min(s : ChemrxnoptimizeView) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_view_max(s : ChemrxnoptimizeView) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_view_to_string(s : ChemrxnoptimizeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_range_make(size : Int) -> ChemrxnoptimizeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_range_len(s : ChemrxnoptimizeRange) -> Int { s.size }

pub fn chem_rxn_optimize_range_get(s : ChemrxnoptimizeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_range_set(s : ChemrxnoptimizeRange, i : Int, v : Double) -> ChemrxnoptimizeRange {
  let result = chem_rxn_optimize_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_range_sum(s : ChemrxnoptimizeRange) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_range_mean(s : ChemrxnoptimizeRange) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_range_scale(s : ChemrxnoptimizeRange, f : Double) -> ChemrxnoptimizeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_range_add(a : ChemrxnoptimizeRange, b : ChemrxnoptimizeRange) -> ChemrxnoptimizeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_range_copy(s : ChemrxnoptimizeRange) -> ChemrxnoptimizeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_range_fill(s : ChemrxnoptimizeRange, v : Double) -> ChemrxnoptimizeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_range_min(s : ChemrxnoptimizeRange) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_range_max(s : ChemrxnoptimizeRange) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_range_to_string(s : ChemrxnoptimizeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_slice_make(size : Int) -> ChemrxnoptimizeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_slice_len(s : ChemrxnoptimizeSlice) -> Int { s.size }

pub fn chem_rxn_optimize_slice_get(s : ChemrxnoptimizeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_slice_set(s : ChemrxnoptimizeSlice, i : Int, v : Double) -> ChemrxnoptimizeSlice {
  let result = chem_rxn_optimize_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_slice_sum(s : ChemrxnoptimizeSlice) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_slice_mean(s : ChemrxnoptimizeSlice) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_slice_scale(s : ChemrxnoptimizeSlice, f : Double) -> ChemrxnoptimizeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_slice_add(a : ChemrxnoptimizeSlice, b : ChemrxnoptimizeSlice) -> ChemrxnoptimizeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_slice_copy(s : ChemrxnoptimizeSlice) -> ChemrxnoptimizeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_slice_fill(s : ChemrxnoptimizeSlice, v : Double) -> ChemrxnoptimizeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_slice_min(s : ChemrxnoptimizeSlice) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_slice_max(s : ChemrxnoptimizeSlice) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_slice_to_string(s : ChemrxnoptimizeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

