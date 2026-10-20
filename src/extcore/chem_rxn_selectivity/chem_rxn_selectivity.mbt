///===
/// extcore/chem_rxn_selectivity

pub(all) struct ChemrxnselectivityPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_selectivity_make_point(x : Double, y : Double) -> ChemrxnselectivityPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_selectivity_make_point3(x : Double, y : Double, z : Double) -> ChemrxnselectivityPoint {
  { x, y, z, label: 0 }
}

pub fn chem_rxn_selectivity_point_x(pt : ChemrxnselectivityPoint) -> Double { pt.x }

pub fn chem_rxn_selectivity_point_y(pt : ChemrxnselectivityPoint) -> Double { pt.y }

pub fn chem_rxn_selectivity_point_z(pt : ChemrxnselectivityPoint) -> Double { pt.z }

pub fn chem_rxn_selectivity_point_label(pt : ChemrxnselectivityPoint) -> Int { pt.label }

pub fn chem_rxn_selectivity_point_dist(a : ChemrxnselectivityPoint, b : ChemrxnselectivityPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_rxn_selectivity_point_add(a : ChemrxnselectivityPoint, b : ChemrxnselectivityPoint) -> ChemrxnselectivityPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_rxn_selectivity_point_sub(a : ChemrxnselectivityPoint, b : ChemrxnselectivityPoint) -> ChemrxnselectivityPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_rxn_selectivity_point_scale(pt : ChemrxnselectivityPoint, s : Double) -> ChemrxnselectivityPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_rxn_selectivity_point_dot(a : ChemrxnselectivityPoint, b : ChemrxnselectivityPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_rxn_selectivity_point_cross(a : ChemrxnselectivityPoint, b : ChemrxnselectivityPoint) -> ChemrxnselectivityPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_rxn_selectivity_point_norm(pt : ChemrxnselectivityPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_rxn_selectivity_point_normalize(pt : ChemrxnselectivityPoint) -> ChemrxnselectivityPoint {
  let n = chem_rxn_selectivity_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_rxn_selectivity_point_scale(pt, 1.0 / n) }
}

pub fn chem_rxn_selectivity_point_negate(pt : ChemrxnselectivityPoint) -> ChemrxnselectivityPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_rxn_selectivity_point_mid(a : ChemrxnselectivityPoint, b : ChemrxnselectivityPoint) -> ChemrxnselectivityPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_rxn_selectivity_point_lerp(a : ChemrxnselectivityPoint, b : ChemrxnselectivityPoint, t : Double) -> ChemrxnselectivityPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_rxn_selectivity_point_to_string(pt : ChemrxnselectivityPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemrxnselectivitySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_selectivity_make_series(vals : Array[Double], name : String) -> ChemrxnselectivitySeries {
  { vals, name, meta: 0 }
}

pub fn chem_rxn_selectivity_series_len(s : ChemrxnselectivitySeries) -> Int { s.vals.length() }

pub fn chem_rxn_selectivity_series_sum(s : ChemrxnselectivitySeries) -> Double { @_common.sum(s.vals) }

pub fn chem_rxn_selectivity_series_mean(s : ChemrxnselectivitySeries) -> Double { @_common.mean(s.vals) }

pub fn chem_rxn_selectivity_series_min(s : ChemrxnselectivitySeries) -> Double { @_common.min(s.vals) }

pub fn chem_rxn_selectivity_series_max(s : ChemrxnselectivitySeries) -> Double { @_common.max(s.vals) }

pub fn chem_rxn_selectivity_series_range(s : ChemrxnselectivitySeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn chem_rxn_selectivity_series_var(s : ChemrxnselectivitySeries) -> Double { @_common.variance(s.vals) }

pub fn chem_rxn_selectivity_series_std(s : ChemrxnselectivitySeries) -> Double { @_common.std(s.vals) }

pub fn chem_rxn_selectivity_series_median(s : ChemrxnselectivitySeries) -> Double { @_common.median(s.vals) }

pub fn chem_rxn_selectivity_series_scale(s : ChemrxnselectivitySeries, f : Double) -> ChemrxnselectivitySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_rxn_selectivity_series_add(a : ChemrxnselectivitySeries, b : ChemrxnselectivitySeries) -> ChemrxnselectivitySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_rxn_selectivity_series_sub(a : ChemrxnselectivitySeries, b : ChemrxnselectivitySeries) -> ChemrxnselectivitySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_rxn_selectivity_series_normalize(s : ChemrxnselectivitySeries) -> ChemrxnselectivitySeries {
  let mn = chem_rxn_selectivity_series_min(s)
  let mx = chem_rxn_selectivity_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_rxn_selectivity_series_cumsum(s : ChemrxnselectivitySeries) -> ChemrxnselectivitySeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_rxn_selectivity_series_to_string(s : ChemrxnselectivitySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnselectivityMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_selectivity_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxnselectivityMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_selectivity_matrix_identity(n : Int) -> ChemrxnselectivityMatrix {
  let m = chem_rxn_selectivity_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_rxn_selectivity_matrix_get(m : ChemrxnselectivityMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_rxn_selectivity_matrix_transpose(m : ChemrxnselectivityMatrix) -> ChemrxnselectivityMatrix {
  let result = chem_rxn_selectivity_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_rxn_selectivity_matrix_add(a : ChemrxnselectivityMatrix, b : ChemrxnselectivityMatrix) -> ChemrxnselectivityMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_rxn_selectivity_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_rxn_selectivity_matrix_scale(m : ChemrxnselectivityMatrix, s : Double) -> ChemrxnselectivityMatrix {
  let result = chem_rxn_selectivity_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_rxn_selectivity_matrix_multiply(a : ChemrxnselectivityMatrix, b : ChemrxnselectivityMatrix) -> ChemrxnselectivityMatrix {
  if a.cols != b.rows { return chem_rxn_selectivity_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_rxn_selectivity_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_rxn_selectivity_matrix_trace(m : ChemrxnselectivityMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_rxn_selectivity_matrix_det(m : ChemrxnselectivityMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_rxn_selectivity_matrix_norm(m : ChemrxnselectivityMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_rxn_selectivity_matrix_to_string(m : ChemrxnselectivityMatrix) -> String {
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

pub(all) struct ChemrxnselectivityVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_selectivity_make_vector(comps : Array[Double]) -> ChemrxnselectivityVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_selectivity_vector_zero(dim : Int) -> ChemrxnselectivityVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_rxn_selectivity_vector_add(a : ChemrxnselectivityVector, b : ChemrxnselectivityVector) -> ChemrxnselectivityVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_rxn_selectivity_vector_sub(a : ChemrxnselectivityVector, b : ChemrxnselectivityVector) -> ChemrxnselectivityVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_rxn_selectivity_vector_scale(v : ChemrxnselectivityVector, s : Double) -> ChemrxnselectivityVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_rxn_selectivity_vector_dot(a : ChemrxnselectivityVector, b : ChemrxnselectivityVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_rxn_selectivity_vector_norm(v : ChemrxnselectivityVector) -> Double { @_common.sqrt(chem_rxn_selectivity_vector_dot(v, v)) }

pub fn chem_rxn_selectivity_vector_normalize(v : ChemrxnselectivityVector) -> ChemrxnselectivityVector {
  let n = chem_rxn_selectivity_vector_norm(v)
  if n < 0.0000001 { v } else { chem_rxn_selectivity_vector_scale(v, 1.0 / n) }
}

pub fn chem_rxn_selectivity_vector_dist(a : ChemrxnselectivityVector, b : ChemrxnselectivityVector) -> Double {
  chem_rxn_selectivity_vector_norm(chem_rxn_selectivity_vector_sub(a, b))
}

pub fn chem_rxn_selectivity_vector_to_string(v : ChemrxnselectivityVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_rxn_selectivity_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_rxn_selectivity_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_rxn_selectivity_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_rxn_selectivity_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_rxn_selectivity_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_rxn_selectivity_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_rxn_selectivity_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_rxn_selectivity_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_rxn_selectivity_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_rxn_selectivity_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_rxn_selectivity_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_rxn_selectivity_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_rxn_selectivity_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_rxn_selectivity_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_rxn_selectivity_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_rxn_selectivity_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_rxn_selectivity_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_rxn_selectivity_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_rxn_selectivity_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_rxn_selectivity_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_rxn_selectivity_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_rxn_selectivity_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_rxn_selectivity_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_rxn_selectivity_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_rxn_selectivity_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_rxn_selectivity_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_rxn_selectivity_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_rxn_selectivity_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_rxn_selectivity_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemrxnselectivityFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_frame_make(size : Int) -> ChemrxnselectivityFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_frame_len(s : ChemrxnselectivityFrame) -> Int { s.size }

pub fn chem_rxn_selectivity_frame_get(s : ChemrxnselectivityFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_frame_set(s : ChemrxnselectivityFrame, i : Int, v : Double) -> ChemrxnselectivityFrame {
  let result = chem_rxn_selectivity_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_selectivity_frame_sum(s : ChemrxnselectivityFrame) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_frame_mean(s : ChemrxnselectivityFrame) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_frame_scale(s : ChemrxnselectivityFrame, f : Double) -> ChemrxnselectivityFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_frame_add(a : ChemrxnselectivityFrame, b : ChemrxnselectivityFrame) -> ChemrxnselectivityFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_frame_copy(s : ChemrxnselectivityFrame) -> ChemrxnselectivityFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_frame_fill(s : ChemrxnselectivityFrame, v : Double) -> ChemrxnselectivityFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_frame_min(s : ChemrxnselectivityFrame) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_frame_max(s : ChemrxnselectivityFrame) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_frame_to_string(s : ChemrxnselectivityFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_table_make(size : Int) -> ChemrxnselectivityTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_table_len(s : ChemrxnselectivityTable) -> Int { s.size }

pub fn chem_rxn_selectivity_table_get(s : ChemrxnselectivityTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_table_set(s : ChemrxnselectivityTable, i : Int, v : Double) -> ChemrxnselectivityTable {
  let result = chem_rxn_selectivity_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_selectivity_table_sum(s : ChemrxnselectivityTable) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_table_mean(s : ChemrxnselectivityTable) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_table_scale(s : ChemrxnselectivityTable, f : Double) -> ChemrxnselectivityTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_table_add(a : ChemrxnselectivityTable, b : ChemrxnselectivityTable) -> ChemrxnselectivityTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_table_copy(s : ChemrxnselectivityTable) -> ChemrxnselectivityTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_table_fill(s : ChemrxnselectivityTable, v : Double) -> ChemrxnselectivityTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_table_min(s : ChemrxnselectivityTable) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_table_max(s : ChemrxnselectivityTable) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_table_to_string(s : ChemrxnselectivityTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_graphn_make(size : Int) -> ChemrxnselectivityGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_graphn_len(s : ChemrxnselectivityGraphN) -> Int { s.size }

pub fn chem_rxn_selectivity_graphn_get(s : ChemrxnselectivityGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_graphn_set(s : ChemrxnselectivityGraphN, i : Int, v : Double) -> ChemrxnselectivityGraphN {
  let result = chem_rxn_selectivity_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_selectivity_graphn_sum(s : ChemrxnselectivityGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_graphn_mean(s : ChemrxnselectivityGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_graphn_scale(s : ChemrxnselectivityGraphN, f : Double) -> ChemrxnselectivityGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_graphn_add(a : ChemrxnselectivityGraphN, b : ChemrxnselectivityGraphN) -> ChemrxnselectivityGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_graphn_copy(s : ChemrxnselectivityGraphN) -> ChemrxnselectivityGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_graphn_fill(s : ChemrxnselectivityGraphN, v : Double) -> ChemrxnselectivityGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_graphn_min(s : ChemrxnselectivityGraphN) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_graphn_max(s : ChemrxnselectivityGraphN) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_graphn_to_string(s : ChemrxnselectivityGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_node_make(size : Int) -> ChemrxnselectivityNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_node_len(s : ChemrxnselectivityNode) -> Int { s.size }

pub fn chem_rxn_selectivity_node_get(s : ChemrxnselectivityNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_node_set(s : ChemrxnselectivityNode, i : Int, v : Double) -> ChemrxnselectivityNode {
  let result = chem_rxn_selectivity_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_selectivity_node_sum(s : ChemrxnselectivityNode) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_node_mean(s : ChemrxnselectivityNode) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_node_scale(s : ChemrxnselectivityNode, f : Double) -> ChemrxnselectivityNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_node_add(a : ChemrxnselectivityNode, b : ChemrxnselectivityNode) -> ChemrxnselectivityNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_node_copy(s : ChemrxnselectivityNode) -> ChemrxnselectivityNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_node_fill(s : ChemrxnselectivityNode, v : Double) -> ChemrxnselectivityNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_node_min(s : ChemrxnselectivityNode) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_node_max(s : ChemrxnselectivityNode) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_node_to_string(s : ChemrxnselectivityNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_edge_make(size : Int) -> ChemrxnselectivityEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_edge_len(s : ChemrxnselectivityEdge) -> Int { s.size }

pub fn chem_rxn_selectivity_edge_get(s : ChemrxnselectivityEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_edge_set(s : ChemrxnselectivityEdge, i : Int, v : Double) -> ChemrxnselectivityEdge {
  let result = chem_rxn_selectivity_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_selectivity_edge_sum(s : ChemrxnselectivityEdge) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_edge_mean(s : ChemrxnselectivityEdge) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_edge_scale(s : ChemrxnselectivityEdge, f : Double) -> ChemrxnselectivityEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_edge_add(a : ChemrxnselectivityEdge, b : ChemrxnselectivityEdge) -> ChemrxnselectivityEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_edge_copy(s : ChemrxnselectivityEdge) -> ChemrxnselectivityEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_edge_fill(s : ChemrxnselectivityEdge, v : Double) -> ChemrxnselectivityEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_edge_min(s : ChemrxnselectivityEdge) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_edge_max(s : ChemrxnselectivityEdge) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_edge_to_string(s : ChemrxnselectivityEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_path_make(size : Int) -> ChemrxnselectivityPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_path_len(s : ChemrxnselectivityPath) -> Int { s.size }

pub fn chem_rxn_selectivity_path_get(s : ChemrxnselectivityPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_path_set(s : ChemrxnselectivityPath, i : Int, v : Double) -> ChemrxnselectivityPath {
  let result = chem_rxn_selectivity_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_selectivity_path_sum(s : ChemrxnselectivityPath) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_path_mean(s : ChemrxnselectivityPath) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_path_scale(s : ChemrxnselectivityPath, f : Double) -> ChemrxnselectivityPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_path_add(a : ChemrxnselectivityPath, b : ChemrxnselectivityPath) -> ChemrxnselectivityPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_path_copy(s : ChemrxnselectivityPath) -> ChemrxnselectivityPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_path_fill(s : ChemrxnselectivityPath, v : Double) -> ChemrxnselectivityPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_path_min(s : ChemrxnselectivityPath) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_path_max(s : ChemrxnselectivityPath) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_path_to_string(s : ChemrxnselectivityPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_cluster_make(size : Int) -> ChemrxnselectivityCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_cluster_len(s : ChemrxnselectivityCluster) -> Int { s.size }

pub fn chem_rxn_selectivity_cluster_get(s : ChemrxnselectivityCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_cluster_set(s : ChemrxnselectivityCluster, i : Int, v : Double) -> ChemrxnselectivityCluster {
  let result = chem_rxn_selectivity_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_selectivity_cluster_sum(s : ChemrxnselectivityCluster) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_cluster_mean(s : ChemrxnselectivityCluster) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_cluster_scale(s : ChemrxnselectivityCluster, f : Double) -> ChemrxnselectivityCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_cluster_add(a : ChemrxnselectivityCluster, b : ChemrxnselectivityCluster) -> ChemrxnselectivityCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_cluster_copy(s : ChemrxnselectivityCluster) -> ChemrxnselectivityCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_cluster_fill(s : ChemrxnselectivityCluster, v : Double) -> ChemrxnselectivityCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_cluster_min(s : ChemrxnselectivityCluster) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_cluster_max(s : ChemrxnselectivityCluster) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_cluster_to_string(s : ChemrxnselectivityCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_model_make(size : Int) -> ChemrxnselectivityModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_model_len(s : ChemrxnselectivityModel) -> Int { s.size }

pub fn chem_rxn_selectivity_model_get(s : ChemrxnselectivityModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_model_set(s : ChemrxnselectivityModel, i : Int, v : Double) -> ChemrxnselectivityModel {
  let result = chem_rxn_selectivity_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_selectivity_model_sum(s : ChemrxnselectivityModel) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_model_mean(s : ChemrxnselectivityModel) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_model_scale(s : ChemrxnselectivityModel, f : Double) -> ChemrxnselectivityModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_model_add(a : ChemrxnselectivityModel, b : ChemrxnselectivityModel) -> ChemrxnselectivityModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_model_copy(s : ChemrxnselectivityModel) -> ChemrxnselectivityModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_model_fill(s : ChemrxnselectivityModel, v : Double) -> ChemrxnselectivityModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_model_min(s : ChemrxnselectivityModel) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_model_max(s : ChemrxnselectivityModel) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_model_to_string(s : ChemrxnselectivityModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_layer_make(size : Int) -> ChemrxnselectivityLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_layer_len(s : ChemrxnselectivityLayer) -> Int { s.size }

pub fn chem_rxn_selectivity_layer_get(s : ChemrxnselectivityLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_layer_set(s : ChemrxnselectivityLayer, i : Int, v : Double) -> ChemrxnselectivityLayer {
  let result = chem_rxn_selectivity_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_selectivity_layer_sum(s : ChemrxnselectivityLayer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_layer_mean(s : ChemrxnselectivityLayer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_layer_scale(s : ChemrxnselectivityLayer, f : Double) -> ChemrxnselectivityLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_layer_add(a : ChemrxnselectivityLayer, b : ChemrxnselectivityLayer) -> ChemrxnselectivityLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_layer_copy(s : ChemrxnselectivityLayer) -> ChemrxnselectivityLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_layer_fill(s : ChemrxnselectivityLayer, v : Double) -> ChemrxnselectivityLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_layer_min(s : ChemrxnselectivityLayer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_layer_max(s : ChemrxnselectivityLayer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_layer_to_string(s : ChemrxnselectivityLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_buffer_make(size : Int) -> ChemrxnselectivityBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_buffer_len(s : ChemrxnselectivityBuffer) -> Int { s.size }

pub fn chem_rxn_selectivity_buffer_get(s : ChemrxnselectivityBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_buffer_set(s : ChemrxnselectivityBuffer, i : Int, v : Double) -> ChemrxnselectivityBuffer {
  let result = chem_rxn_selectivity_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_selectivity_buffer_sum(s : ChemrxnselectivityBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_buffer_mean(s : ChemrxnselectivityBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_buffer_scale(s : ChemrxnselectivityBuffer, f : Double) -> ChemrxnselectivityBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_buffer_add(a : ChemrxnselectivityBuffer, b : ChemrxnselectivityBuffer) -> ChemrxnselectivityBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_buffer_copy(s : ChemrxnselectivityBuffer) -> ChemrxnselectivityBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_buffer_fill(s : ChemrxnselectivityBuffer, v : Double) -> ChemrxnselectivityBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_buffer_min(s : ChemrxnselectivityBuffer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_buffer_max(s : ChemrxnselectivityBuffer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_buffer_to_string(s : ChemrxnselectivityBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_cursor_make(size : Int) -> ChemrxnselectivityCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_cursor_len(s : ChemrxnselectivityCursor) -> Int { s.size }

pub fn chem_rxn_selectivity_cursor_get(s : ChemrxnselectivityCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_cursor_set(s : ChemrxnselectivityCursor, i : Int, v : Double) -> ChemrxnselectivityCursor {
  let result = chem_rxn_selectivity_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_selectivity_cursor_sum(s : ChemrxnselectivityCursor) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_cursor_mean(s : ChemrxnselectivityCursor) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_cursor_scale(s : ChemrxnselectivityCursor, f : Double) -> ChemrxnselectivityCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_cursor_add(a : ChemrxnselectivityCursor, b : ChemrxnselectivityCursor) -> ChemrxnselectivityCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_cursor_copy(s : ChemrxnselectivityCursor) -> ChemrxnselectivityCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_cursor_fill(s : ChemrxnselectivityCursor, v : Double) -> ChemrxnselectivityCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_cursor_min(s : ChemrxnselectivityCursor) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_cursor_max(s : ChemrxnselectivityCursor) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_cursor_to_string(s : ChemrxnselectivityCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_view_make(size : Int) -> ChemrxnselectivityView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_view_len(s : ChemrxnselectivityView) -> Int { s.size }

pub fn chem_rxn_selectivity_view_get(s : ChemrxnselectivityView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_view_set(s : ChemrxnselectivityView, i : Int, v : Double) -> ChemrxnselectivityView {
  let result = chem_rxn_selectivity_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_selectivity_view_sum(s : ChemrxnselectivityView) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_view_mean(s : ChemrxnselectivityView) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_view_scale(s : ChemrxnselectivityView, f : Double) -> ChemrxnselectivityView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_view_add(a : ChemrxnselectivityView, b : ChemrxnselectivityView) -> ChemrxnselectivityView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_view_copy(s : ChemrxnselectivityView) -> ChemrxnselectivityView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_view_fill(s : ChemrxnselectivityView, v : Double) -> ChemrxnselectivityView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_view_min(s : ChemrxnselectivityView) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_view_max(s : ChemrxnselectivityView) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_view_to_string(s : ChemrxnselectivityView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_range_make(size : Int) -> ChemrxnselectivityRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_range_len(s : ChemrxnselectivityRange) -> Int { s.size }

pub fn chem_rxn_selectivity_range_get(s : ChemrxnselectivityRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_range_set(s : ChemrxnselectivityRange, i : Int, v : Double) -> ChemrxnselectivityRange {
  let result = chem_rxn_selectivity_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_selectivity_range_sum(s : ChemrxnselectivityRange) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_range_mean(s : ChemrxnselectivityRange) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_range_scale(s : ChemrxnselectivityRange, f : Double) -> ChemrxnselectivityRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_range_add(a : ChemrxnselectivityRange, b : ChemrxnselectivityRange) -> ChemrxnselectivityRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_range_copy(s : ChemrxnselectivityRange) -> ChemrxnselectivityRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_range_fill(s : ChemrxnselectivityRange, v : Double) -> ChemrxnselectivityRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_range_min(s : ChemrxnselectivityRange) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_range_max(s : ChemrxnselectivityRange) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_range_to_string(s : ChemrxnselectivityRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivitySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_slice_make(size : Int) -> ChemrxnselectivitySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_slice_len(s : ChemrxnselectivitySlice) -> Int { s.size }

pub fn chem_rxn_selectivity_slice_get(s : ChemrxnselectivitySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_slice_set(s : ChemrxnselectivitySlice, i : Int, v : Double) -> ChemrxnselectivitySlice {
  let result = chem_rxn_selectivity_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_selectivity_slice_sum(s : ChemrxnselectivitySlice) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_slice_mean(s : ChemrxnselectivitySlice) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_slice_scale(s : ChemrxnselectivitySlice, f : Double) -> ChemrxnselectivitySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_slice_add(a : ChemrxnselectivitySlice, b : ChemrxnselectivitySlice) -> ChemrxnselectivitySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_slice_copy(s : ChemrxnselectivitySlice) -> ChemrxnselectivitySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_slice_fill(s : ChemrxnselectivitySlice, v : Double) -> ChemrxnselectivitySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_slice_min(s : ChemrxnselectivitySlice) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_slice_max(s : ChemrxnselectivitySlice) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_slice_to_string(s : ChemrxnselectivitySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

