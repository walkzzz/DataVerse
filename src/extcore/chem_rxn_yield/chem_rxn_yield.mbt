///===
/// extcore/chem_rxn_yield

pub(all) struct ChemrxnyieldPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_yield_make_point(x : Double, y : Double) -> ChemrxnyieldPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_yield_make_point3(x : Double, y : Double, z : Double) -> ChemrxnyieldPoint {
  { x, y, z, label: 0 }
}

pub fn chem_rxn_yield_point_x(pt : ChemrxnyieldPoint) -> Double { pt.x }

pub fn chem_rxn_yield_point_y(pt : ChemrxnyieldPoint) -> Double { pt.y }

pub fn chem_rxn_yield_point_z(pt : ChemrxnyieldPoint) -> Double { pt.z }

pub fn chem_rxn_yield_point_label(pt : ChemrxnyieldPoint) -> Int { pt.label }

pub fn chem_rxn_yield_point_dist(a : ChemrxnyieldPoint, b : ChemrxnyieldPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_rxn_yield_point_add(a : ChemrxnyieldPoint, b : ChemrxnyieldPoint) -> ChemrxnyieldPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_rxn_yield_point_sub(a : ChemrxnyieldPoint, b : ChemrxnyieldPoint) -> ChemrxnyieldPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_rxn_yield_point_scale(pt : ChemrxnyieldPoint, s : Double) -> ChemrxnyieldPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_rxn_yield_point_dot(a : ChemrxnyieldPoint, b : ChemrxnyieldPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_rxn_yield_point_cross(a : ChemrxnyieldPoint, b : ChemrxnyieldPoint) -> ChemrxnyieldPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_rxn_yield_point_norm(pt : ChemrxnyieldPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_rxn_yield_point_normalize(pt : ChemrxnyieldPoint) -> ChemrxnyieldPoint {
  let n = chem_rxn_yield_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_rxn_yield_point_scale(pt, 1.0 / n) }
}

pub fn chem_rxn_yield_point_negate(pt : ChemrxnyieldPoint) -> ChemrxnyieldPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_rxn_yield_point_mid(a : ChemrxnyieldPoint, b : ChemrxnyieldPoint) -> ChemrxnyieldPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_rxn_yield_point_lerp(a : ChemrxnyieldPoint, b : ChemrxnyieldPoint, t : Double) -> ChemrxnyieldPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_rxn_yield_point_to_string(pt : ChemrxnyieldPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemrxnyieldSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_yield_make_series(vals : Array[Double], name : String) -> ChemrxnyieldSeries {
  { vals, name, meta: 0 }
}

pub fn chem_rxn_yield_series_len(s : ChemrxnyieldSeries) -> Int { s.vals.length() }

pub fn chem_rxn_yield_series_sum(s : ChemrxnyieldSeries) -> Double { @_common.sum(s.vals) }

pub fn chem_rxn_yield_series_mean(s : ChemrxnyieldSeries) -> Double { @_common.mean(s.vals) }

pub fn chem_rxn_yield_series_min(s : ChemrxnyieldSeries) -> Double { @_common.min(s.vals) }

pub fn chem_rxn_yield_series_max(s : ChemrxnyieldSeries) -> Double { @_common.max(s.vals) }

pub fn chem_rxn_yield_series_range(s : ChemrxnyieldSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn chem_rxn_yield_series_var(s : ChemrxnyieldSeries) -> Double { @_common.variance(s.vals) }

pub fn chem_rxn_yield_series_std(s : ChemrxnyieldSeries) -> Double { @_common.std(s.vals) }

pub fn chem_rxn_yield_series_median(s : ChemrxnyieldSeries) -> Double { @_common.median(s.vals) }

pub fn chem_rxn_yield_series_scale(s : ChemrxnyieldSeries, f : Double) -> ChemrxnyieldSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn chem_rxn_yield_series_add(a : ChemrxnyieldSeries, b : ChemrxnyieldSeries) -> ChemrxnyieldSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_rxn_yield_series_sub(a : ChemrxnyieldSeries, b : ChemrxnyieldSeries) -> ChemrxnyieldSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_rxn_yield_series_normalize(s : ChemrxnyieldSeries) -> ChemrxnyieldSeries {
  let mn = chem_rxn_yield_series_min(s)
  let mx = chem_rxn_yield_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_rxn_yield_series_cumsum(s : ChemrxnyieldSeries) -> ChemrxnyieldSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_rxn_yield_series_to_string(s : ChemrxnyieldSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnyieldMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_yield_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxnyieldMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_yield_matrix_identity(n : Int) -> ChemrxnyieldMatrix {
  let m = chem_rxn_yield_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_rxn_yield_matrix_get(m : ChemrxnyieldMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_rxn_yield_matrix_transpose(m : ChemrxnyieldMatrix) -> ChemrxnyieldMatrix {
  let result = chem_rxn_yield_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_rxn_yield_matrix_add(a : ChemrxnyieldMatrix, b : ChemrxnyieldMatrix) -> ChemrxnyieldMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_rxn_yield_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_rxn_yield_matrix_scale(m : ChemrxnyieldMatrix, s : Double) -> ChemrxnyieldMatrix {
  let result = chem_rxn_yield_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_rxn_yield_matrix_multiply(a : ChemrxnyieldMatrix, b : ChemrxnyieldMatrix) -> ChemrxnyieldMatrix {
  if a.cols != b.rows { return chem_rxn_yield_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_rxn_yield_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_rxn_yield_matrix_trace(m : ChemrxnyieldMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_rxn_yield_matrix_det(m : ChemrxnyieldMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_rxn_yield_matrix_norm(m : ChemrxnyieldMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_rxn_yield_matrix_to_string(m : ChemrxnyieldMatrix) -> String {
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

pub(all) struct ChemrxnyieldVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_yield_make_vector(comps : Array[Double]) -> ChemrxnyieldVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_yield_vector_zero(dim : Int) -> ChemrxnyieldVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_rxn_yield_vector_add(a : ChemrxnyieldVector, b : ChemrxnyieldVector) -> ChemrxnyieldVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn chem_rxn_yield_vector_sub(a : ChemrxnyieldVector, b : ChemrxnyieldVector) -> ChemrxnyieldVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn chem_rxn_yield_vector_scale(v : ChemrxnyieldVector, s : Double) -> ChemrxnyieldVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn chem_rxn_yield_vector_dot(a : ChemrxnyieldVector, b : ChemrxnyieldVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_rxn_yield_vector_norm(v : ChemrxnyieldVector) -> Double { @_common.sqrt(chem_rxn_yield_vector_dot(v, v)) }

pub fn chem_rxn_yield_vector_normalize(v : ChemrxnyieldVector) -> ChemrxnyieldVector {
  let n = chem_rxn_yield_vector_norm(v)
  if n < 0.0000001 { v } else { chem_rxn_yield_vector_scale(v, 1.0 / n) }
}

pub fn chem_rxn_yield_vector_dist(a : ChemrxnyieldVector, b : ChemrxnyieldVector) -> Double {
  chem_rxn_yield_vector_norm(chem_rxn_yield_vector_sub(a, b))
}

pub fn chem_rxn_yield_vector_to_string(v : ChemrxnyieldVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_rxn_yield_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_rxn_yield_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_rxn_yield_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_rxn_yield_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_rxn_yield_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_rxn_yield_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_rxn_yield_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_rxn_yield_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_rxn_yield_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_rxn_yield_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_rxn_yield_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_rxn_yield_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_rxn_yield_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_rxn_yield_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_rxn_yield_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_rxn_yield_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_rxn_yield_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_rxn_yield_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_rxn_yield_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_rxn_yield_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_rxn_yield_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_rxn_yield_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_rxn_yield_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_rxn_yield_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_rxn_yield_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_rxn_yield_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_rxn_yield_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_rxn_yield_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_rxn_yield_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemrxnyieldFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_frame_make(size : Int) -> ChemrxnyieldFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_yield_frame_len(s : ChemrxnyieldFrame) -> Int { s.size }

pub fn chem_rxn_yield_frame_get(s : ChemrxnyieldFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_yield_frame_set(s : ChemrxnyieldFrame, i : Int, v : Double) -> ChemrxnyieldFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_frame_sum(s : ChemrxnyieldFrame) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_yield_frame_mean(s : ChemrxnyieldFrame) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_yield_frame_scale(s : ChemrxnyieldFrame, f : Double) -> ChemrxnyieldFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_frame_add(a : ChemrxnyieldFrame, b : ChemrxnyieldFrame) -> ChemrxnyieldFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_yield_frame_copy(s : ChemrxnyieldFrame) -> ChemrxnyieldFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_frame_fill(s : ChemrxnyieldFrame, v : Double) -> ChemrxnyieldFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_frame_min(s : ChemrxnyieldFrame) -> Double { @_common.min(s.data) }

pub fn chem_rxn_yield_frame_max(s : ChemrxnyieldFrame) -> Double { @_common.max(s.data) }

pub fn chem_rxn_yield_frame_to_string(s : ChemrxnyieldFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_table_make(size : Int) -> ChemrxnyieldTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_yield_table_len(s : ChemrxnyieldTable) -> Int { s.size }

pub fn chem_rxn_yield_table_get(s : ChemrxnyieldTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_yield_table_set(s : ChemrxnyieldTable, i : Int, v : Double) -> ChemrxnyieldTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_table_sum(s : ChemrxnyieldTable) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_yield_table_mean(s : ChemrxnyieldTable) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_yield_table_scale(s : ChemrxnyieldTable, f : Double) -> ChemrxnyieldTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_table_add(a : ChemrxnyieldTable, b : ChemrxnyieldTable) -> ChemrxnyieldTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_yield_table_copy(s : ChemrxnyieldTable) -> ChemrxnyieldTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_table_fill(s : ChemrxnyieldTable, v : Double) -> ChemrxnyieldTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_table_min(s : ChemrxnyieldTable) -> Double { @_common.min(s.data) }

pub fn chem_rxn_yield_table_max(s : ChemrxnyieldTable) -> Double { @_common.max(s.data) }

pub fn chem_rxn_yield_table_to_string(s : ChemrxnyieldTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_graphn_make(size : Int) -> ChemrxnyieldGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_yield_graphn_len(s : ChemrxnyieldGraphN) -> Int { s.size }

pub fn chem_rxn_yield_graphn_get(s : ChemrxnyieldGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_yield_graphn_set(s : ChemrxnyieldGraphN, i : Int, v : Double) -> ChemrxnyieldGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_graphn_sum(s : ChemrxnyieldGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_yield_graphn_mean(s : ChemrxnyieldGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_yield_graphn_scale(s : ChemrxnyieldGraphN, f : Double) -> ChemrxnyieldGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_graphn_add(a : ChemrxnyieldGraphN, b : ChemrxnyieldGraphN) -> ChemrxnyieldGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_yield_graphn_copy(s : ChemrxnyieldGraphN) -> ChemrxnyieldGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_graphn_fill(s : ChemrxnyieldGraphN, v : Double) -> ChemrxnyieldGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_graphn_min(s : ChemrxnyieldGraphN) -> Double { @_common.min(s.data) }

pub fn chem_rxn_yield_graphn_max(s : ChemrxnyieldGraphN) -> Double { @_common.max(s.data) }

pub fn chem_rxn_yield_graphn_to_string(s : ChemrxnyieldGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_node_make(size : Int) -> ChemrxnyieldNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_yield_node_len(s : ChemrxnyieldNode) -> Int { s.size }

pub fn chem_rxn_yield_node_get(s : ChemrxnyieldNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_yield_node_set(s : ChemrxnyieldNode, i : Int, v : Double) -> ChemrxnyieldNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_node_sum(s : ChemrxnyieldNode) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_yield_node_mean(s : ChemrxnyieldNode) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_yield_node_scale(s : ChemrxnyieldNode, f : Double) -> ChemrxnyieldNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_node_add(a : ChemrxnyieldNode, b : ChemrxnyieldNode) -> ChemrxnyieldNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_yield_node_copy(s : ChemrxnyieldNode) -> ChemrxnyieldNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_node_fill(s : ChemrxnyieldNode, v : Double) -> ChemrxnyieldNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_node_min(s : ChemrxnyieldNode) -> Double { @_common.min(s.data) }

pub fn chem_rxn_yield_node_max(s : ChemrxnyieldNode) -> Double { @_common.max(s.data) }

pub fn chem_rxn_yield_node_to_string(s : ChemrxnyieldNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_edge_make(size : Int) -> ChemrxnyieldEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_yield_edge_len(s : ChemrxnyieldEdge) -> Int { s.size }

pub fn chem_rxn_yield_edge_get(s : ChemrxnyieldEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_yield_edge_set(s : ChemrxnyieldEdge, i : Int, v : Double) -> ChemrxnyieldEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_edge_sum(s : ChemrxnyieldEdge) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_yield_edge_mean(s : ChemrxnyieldEdge) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_yield_edge_scale(s : ChemrxnyieldEdge, f : Double) -> ChemrxnyieldEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_edge_add(a : ChemrxnyieldEdge, b : ChemrxnyieldEdge) -> ChemrxnyieldEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_yield_edge_copy(s : ChemrxnyieldEdge) -> ChemrxnyieldEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_edge_fill(s : ChemrxnyieldEdge, v : Double) -> ChemrxnyieldEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_edge_min(s : ChemrxnyieldEdge) -> Double { @_common.min(s.data) }

pub fn chem_rxn_yield_edge_max(s : ChemrxnyieldEdge) -> Double { @_common.max(s.data) }

pub fn chem_rxn_yield_edge_to_string(s : ChemrxnyieldEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_path_make(size : Int) -> ChemrxnyieldPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_yield_path_len(s : ChemrxnyieldPath) -> Int { s.size }

pub fn chem_rxn_yield_path_get(s : ChemrxnyieldPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_yield_path_set(s : ChemrxnyieldPath, i : Int, v : Double) -> ChemrxnyieldPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_path_sum(s : ChemrxnyieldPath) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_yield_path_mean(s : ChemrxnyieldPath) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_yield_path_scale(s : ChemrxnyieldPath, f : Double) -> ChemrxnyieldPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_path_add(a : ChemrxnyieldPath, b : ChemrxnyieldPath) -> ChemrxnyieldPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_yield_path_copy(s : ChemrxnyieldPath) -> ChemrxnyieldPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_path_fill(s : ChemrxnyieldPath, v : Double) -> ChemrxnyieldPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_path_min(s : ChemrxnyieldPath) -> Double { @_common.min(s.data) }

pub fn chem_rxn_yield_path_max(s : ChemrxnyieldPath) -> Double { @_common.max(s.data) }

pub fn chem_rxn_yield_path_to_string(s : ChemrxnyieldPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_cluster_make(size : Int) -> ChemrxnyieldCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_yield_cluster_len(s : ChemrxnyieldCluster) -> Int { s.size }

pub fn chem_rxn_yield_cluster_get(s : ChemrxnyieldCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_yield_cluster_set(s : ChemrxnyieldCluster, i : Int, v : Double) -> ChemrxnyieldCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_cluster_sum(s : ChemrxnyieldCluster) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_yield_cluster_mean(s : ChemrxnyieldCluster) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_yield_cluster_scale(s : ChemrxnyieldCluster, f : Double) -> ChemrxnyieldCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_cluster_add(a : ChemrxnyieldCluster, b : ChemrxnyieldCluster) -> ChemrxnyieldCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_yield_cluster_copy(s : ChemrxnyieldCluster) -> ChemrxnyieldCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_cluster_fill(s : ChemrxnyieldCluster, v : Double) -> ChemrxnyieldCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_cluster_min(s : ChemrxnyieldCluster) -> Double { @_common.min(s.data) }

pub fn chem_rxn_yield_cluster_max(s : ChemrxnyieldCluster) -> Double { @_common.max(s.data) }

pub fn chem_rxn_yield_cluster_to_string(s : ChemrxnyieldCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_model_make(size : Int) -> ChemrxnyieldModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_yield_model_len(s : ChemrxnyieldModel) -> Int { s.size }

pub fn chem_rxn_yield_model_get(s : ChemrxnyieldModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_yield_model_set(s : ChemrxnyieldModel, i : Int, v : Double) -> ChemrxnyieldModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_model_sum(s : ChemrxnyieldModel) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_yield_model_mean(s : ChemrxnyieldModel) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_yield_model_scale(s : ChemrxnyieldModel, f : Double) -> ChemrxnyieldModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_model_add(a : ChemrxnyieldModel, b : ChemrxnyieldModel) -> ChemrxnyieldModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_yield_model_copy(s : ChemrxnyieldModel) -> ChemrxnyieldModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_model_fill(s : ChemrxnyieldModel, v : Double) -> ChemrxnyieldModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_model_min(s : ChemrxnyieldModel) -> Double { @_common.min(s.data) }

pub fn chem_rxn_yield_model_max(s : ChemrxnyieldModel) -> Double { @_common.max(s.data) }

pub fn chem_rxn_yield_model_to_string(s : ChemrxnyieldModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_layer_make(size : Int) -> ChemrxnyieldLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_yield_layer_len(s : ChemrxnyieldLayer) -> Int { s.size }

pub fn chem_rxn_yield_layer_get(s : ChemrxnyieldLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_yield_layer_set(s : ChemrxnyieldLayer, i : Int, v : Double) -> ChemrxnyieldLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_layer_sum(s : ChemrxnyieldLayer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_yield_layer_mean(s : ChemrxnyieldLayer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_yield_layer_scale(s : ChemrxnyieldLayer, f : Double) -> ChemrxnyieldLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_layer_add(a : ChemrxnyieldLayer, b : ChemrxnyieldLayer) -> ChemrxnyieldLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_yield_layer_copy(s : ChemrxnyieldLayer) -> ChemrxnyieldLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_layer_fill(s : ChemrxnyieldLayer, v : Double) -> ChemrxnyieldLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_layer_min(s : ChemrxnyieldLayer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_yield_layer_max(s : ChemrxnyieldLayer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_yield_layer_to_string(s : ChemrxnyieldLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_buffer_make(size : Int) -> ChemrxnyieldBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_yield_buffer_len(s : ChemrxnyieldBuffer) -> Int { s.size }

pub fn chem_rxn_yield_buffer_get(s : ChemrxnyieldBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_yield_buffer_set(s : ChemrxnyieldBuffer, i : Int, v : Double) -> ChemrxnyieldBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_buffer_sum(s : ChemrxnyieldBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_yield_buffer_mean(s : ChemrxnyieldBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_yield_buffer_scale(s : ChemrxnyieldBuffer, f : Double) -> ChemrxnyieldBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_buffer_add(a : ChemrxnyieldBuffer, b : ChemrxnyieldBuffer) -> ChemrxnyieldBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_yield_buffer_copy(s : ChemrxnyieldBuffer) -> ChemrxnyieldBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_buffer_fill(s : ChemrxnyieldBuffer, v : Double) -> ChemrxnyieldBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_buffer_min(s : ChemrxnyieldBuffer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_yield_buffer_max(s : ChemrxnyieldBuffer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_yield_buffer_to_string(s : ChemrxnyieldBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_cursor_make(size : Int) -> ChemrxnyieldCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_yield_cursor_len(s : ChemrxnyieldCursor) -> Int { s.size }

pub fn chem_rxn_yield_cursor_get(s : ChemrxnyieldCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_yield_cursor_set(s : ChemrxnyieldCursor, i : Int, v : Double) -> ChemrxnyieldCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_cursor_sum(s : ChemrxnyieldCursor) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_yield_cursor_mean(s : ChemrxnyieldCursor) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_yield_cursor_scale(s : ChemrxnyieldCursor, f : Double) -> ChemrxnyieldCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_cursor_add(a : ChemrxnyieldCursor, b : ChemrxnyieldCursor) -> ChemrxnyieldCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_yield_cursor_copy(s : ChemrxnyieldCursor) -> ChemrxnyieldCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_cursor_fill(s : ChemrxnyieldCursor, v : Double) -> ChemrxnyieldCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_cursor_min(s : ChemrxnyieldCursor) -> Double { @_common.min(s.data) }

pub fn chem_rxn_yield_cursor_max(s : ChemrxnyieldCursor) -> Double { @_common.max(s.data) }

pub fn chem_rxn_yield_cursor_to_string(s : ChemrxnyieldCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_view_make(size : Int) -> ChemrxnyieldView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_yield_view_len(s : ChemrxnyieldView) -> Int { s.size }

pub fn chem_rxn_yield_view_get(s : ChemrxnyieldView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_yield_view_set(s : ChemrxnyieldView, i : Int, v : Double) -> ChemrxnyieldView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_view_sum(s : ChemrxnyieldView) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_yield_view_mean(s : ChemrxnyieldView) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_yield_view_scale(s : ChemrxnyieldView, f : Double) -> ChemrxnyieldView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_view_add(a : ChemrxnyieldView, b : ChemrxnyieldView) -> ChemrxnyieldView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_yield_view_copy(s : ChemrxnyieldView) -> ChemrxnyieldView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_view_fill(s : ChemrxnyieldView, v : Double) -> ChemrxnyieldView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_view_min(s : ChemrxnyieldView) -> Double { @_common.min(s.data) }

pub fn chem_rxn_yield_view_max(s : ChemrxnyieldView) -> Double { @_common.max(s.data) }

pub fn chem_rxn_yield_view_to_string(s : ChemrxnyieldView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_range_make(size : Int) -> ChemrxnyieldRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_yield_range_len(s : ChemrxnyieldRange) -> Int { s.size }

pub fn chem_rxn_yield_range_get(s : ChemrxnyieldRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_yield_range_set(s : ChemrxnyieldRange, i : Int, v : Double) -> ChemrxnyieldRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_range_sum(s : ChemrxnyieldRange) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_yield_range_mean(s : ChemrxnyieldRange) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_yield_range_scale(s : ChemrxnyieldRange, f : Double) -> ChemrxnyieldRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_range_add(a : ChemrxnyieldRange, b : ChemrxnyieldRange) -> ChemrxnyieldRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_yield_range_copy(s : ChemrxnyieldRange) -> ChemrxnyieldRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_range_fill(s : ChemrxnyieldRange, v : Double) -> ChemrxnyieldRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_range_min(s : ChemrxnyieldRange) -> Double { @_common.min(s.data) }

pub fn chem_rxn_yield_range_max(s : ChemrxnyieldRange) -> Double { @_common.max(s.data) }

pub fn chem_rxn_yield_range_to_string(s : ChemrxnyieldRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_slice_make(size : Int) -> ChemrxnyieldSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_yield_slice_len(s : ChemrxnyieldSlice) -> Int { s.size }

pub fn chem_rxn_yield_slice_get(s : ChemrxnyieldSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_yield_slice_set(s : ChemrxnyieldSlice, i : Int, v : Double) -> ChemrxnyieldSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_slice_sum(s : ChemrxnyieldSlice) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_yield_slice_mean(s : ChemrxnyieldSlice) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_yield_slice_scale(s : ChemrxnyieldSlice, f : Double) -> ChemrxnyieldSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_slice_add(a : ChemrxnyieldSlice, b : ChemrxnyieldSlice) -> ChemrxnyieldSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_yield_slice_copy(s : ChemrxnyieldSlice) -> ChemrxnyieldSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_slice_fill(s : ChemrxnyieldSlice, v : Double) -> ChemrxnyieldSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_yield_slice_min(s : ChemrxnyieldSlice) -> Double { @_common.min(s.data) }

pub fn chem_rxn_yield_slice_max(s : ChemrxnyieldSlice) -> Double { @_common.max(s.data) }

pub fn chem_rxn_yield_slice_to_string(s : ChemrxnyieldSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

