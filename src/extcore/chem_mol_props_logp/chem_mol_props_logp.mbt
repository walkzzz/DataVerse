///===
/// extcore/chem_mol_props_logp

pub(all) struct ChemmolpropslogpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_logp_make_point(x : Double, y : Double) -> ChemmolpropslogpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_logp_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropslogpPoint {
  { x, y, z, label: 0 }
}

pub fn chem_mol_props_logp_point_x(pt : ChemmolpropslogpPoint) -> Double { pt.x }

pub fn chem_mol_props_logp_point_y(pt : ChemmolpropslogpPoint) -> Double { pt.y }

pub fn chem_mol_props_logp_point_z(pt : ChemmolpropslogpPoint) -> Double { pt.z }

pub fn chem_mol_props_logp_point_label(pt : ChemmolpropslogpPoint) -> Int { pt.label }

pub fn chem_mol_props_logp_point_dist(a : ChemmolpropslogpPoint, b : ChemmolpropslogpPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_mol_props_logp_point_add(a : ChemmolpropslogpPoint, b : ChemmolpropslogpPoint) -> ChemmolpropslogpPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_mol_props_logp_point_sub(a : ChemmolpropslogpPoint, b : ChemmolpropslogpPoint) -> ChemmolpropslogpPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_mol_props_logp_point_scale(pt : ChemmolpropslogpPoint, s : Double) -> ChemmolpropslogpPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_mol_props_logp_point_dot(a : ChemmolpropslogpPoint, b : ChemmolpropslogpPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_mol_props_logp_point_cross(a : ChemmolpropslogpPoint, b : ChemmolpropslogpPoint) -> ChemmolpropslogpPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_mol_props_logp_point_norm(pt : ChemmolpropslogpPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_mol_props_logp_point_normalize(pt : ChemmolpropslogpPoint) -> ChemmolpropslogpPoint {
  let n = chem_mol_props_logp_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_mol_props_logp_point_scale(pt, 1.0 / n) }
}

pub fn chem_mol_props_logp_point_negate(pt : ChemmolpropslogpPoint) -> ChemmolpropslogpPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_mol_props_logp_point_mid(a : ChemmolpropslogpPoint, b : ChemmolpropslogpPoint) -> ChemmolpropslogpPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_mol_props_logp_point_lerp(a : ChemmolpropslogpPoint, b : ChemmolpropslogpPoint, t : Double) -> ChemmolpropslogpPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_mol_props_logp_point_to_string(pt : ChemmolpropslogpPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemmolpropslogpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_logp_make_series(vals : Array[Double], name : String) -> ChemmolpropslogpSeries {
  { vals, name, meta: 0 }
}

pub fn chem_mol_props_logp_series_len(s : ChemmolpropslogpSeries) -> Int { s.vals.length() }

pub fn chem_mol_props_logp_series_sum(s : ChemmolpropslogpSeries) -> Double { @_common.sum(s.vals) }

pub fn chem_mol_props_logp_series_mean(s : ChemmolpropslogpSeries) -> Double { @_common.mean(s.vals) }

pub fn chem_mol_props_logp_series_min(s : ChemmolpropslogpSeries) -> Double { @_common.min(s.vals) }

pub fn chem_mol_props_logp_series_max(s : ChemmolpropslogpSeries) -> Double { @_common.max(s.vals) }

pub fn chem_mol_props_logp_series_range(s : ChemmolpropslogpSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn chem_mol_props_logp_series_var(s : ChemmolpropslogpSeries) -> Double { @_common.variance(s.vals) }

pub fn chem_mol_props_logp_series_std(s : ChemmolpropslogpSeries) -> Double { @_common.std(s.vals) }

pub fn chem_mol_props_logp_series_median(s : ChemmolpropslogpSeries) -> Double { @_common.median(s.vals) }

pub fn chem_mol_props_logp_series_scale(s : ChemmolpropslogpSeries, f : Double) -> ChemmolpropslogpSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_mol_props_logp_series_add(a : ChemmolpropslogpSeries, b : ChemmolpropslogpSeries) -> ChemmolpropslogpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_mol_props_logp_series_sub(a : ChemmolpropslogpSeries, b : ChemmolpropslogpSeries) -> ChemmolpropslogpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_mol_props_logp_series_normalize(s : ChemmolpropslogpSeries) -> ChemmolpropslogpSeries {
  let mn = chem_mol_props_logp_series_min(s)
  let mx = chem_mol_props_logp_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_mol_props_logp_series_cumsum(s : ChemmolpropslogpSeries) -> ChemmolpropslogpSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_mol_props_logp_series_to_string(s : ChemmolpropslogpSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropslogpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_logp_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropslogpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_logp_matrix_identity(n : Int) -> ChemmolpropslogpMatrix {
  let m = chem_mol_props_logp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_mol_props_logp_matrix_get(m : ChemmolpropslogpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_mol_props_logp_matrix_transpose(m : ChemmolpropslogpMatrix) -> ChemmolpropslogpMatrix {
  let result = chem_mol_props_logp_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_mol_props_logp_matrix_add(a : ChemmolpropslogpMatrix, b : ChemmolpropslogpMatrix) -> ChemmolpropslogpMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_mol_props_logp_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_mol_props_logp_matrix_scale(m : ChemmolpropslogpMatrix, s : Double) -> ChemmolpropslogpMatrix {
  let result = chem_mol_props_logp_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_mol_props_logp_matrix_multiply(a : ChemmolpropslogpMatrix, b : ChemmolpropslogpMatrix) -> ChemmolpropslogpMatrix {
  if a.cols != b.rows { return chem_mol_props_logp_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_mol_props_logp_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_mol_props_logp_matrix_trace(m : ChemmolpropslogpMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_mol_props_logp_matrix_det(m : ChemmolpropslogpMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_mol_props_logp_matrix_norm(m : ChemmolpropslogpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_mol_props_logp_matrix_to_string(m : ChemmolpropslogpMatrix) -> String {
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

pub(all) struct ChemmolpropslogpVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_logp_make_vector(comps : Array[Double]) -> ChemmolpropslogpVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_logp_vector_zero(dim : Int) -> ChemmolpropslogpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_mol_props_logp_vector_add(a : ChemmolpropslogpVector, b : ChemmolpropslogpVector) -> ChemmolpropslogpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_props_logp_vector_sub(a : ChemmolpropslogpVector, b : ChemmolpropslogpVector) -> ChemmolpropslogpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_props_logp_vector_scale(v : ChemmolpropslogpVector, s : Double) -> ChemmolpropslogpVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_mol_props_logp_vector_dot(a : ChemmolpropslogpVector, b : ChemmolpropslogpVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_mol_props_logp_vector_norm(v : ChemmolpropslogpVector) -> Double { @_common.sqrt(chem_mol_props_logp_vector_dot(v, v)) }

pub fn chem_mol_props_logp_vector_normalize(v : ChemmolpropslogpVector) -> ChemmolpropslogpVector {
  let n = chem_mol_props_logp_vector_norm(v)
  if n < 0.0000001 { v } else { chem_mol_props_logp_vector_scale(v, 1.0 / n) }
}

pub fn chem_mol_props_logp_vector_dist(a : ChemmolpropslogpVector, b : ChemmolpropslogpVector) -> Double {
  chem_mol_props_logp_vector_norm(chem_mol_props_logp_vector_sub(a, b))
}

pub fn chem_mol_props_logp_vector_to_string(v : ChemmolpropslogpVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_props_logp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_props_logp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_props_logp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_props_logp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_props_logp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_props_logp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_props_logp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_props_logp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_props_logp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_props_logp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_props_logp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_props_logp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_props_logp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_props_logp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_props_logp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_props_logp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_props_logp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_props_logp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_props_logp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_props_logp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_props_logp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_props_logp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_props_logp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_props_logp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_props_logp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_props_logp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_props_logp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_props_logp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_props_logp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolpropslogpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_frame_make(size : Int) -> ChemmolpropslogpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_frame_len(s : ChemmolpropslogpFrame) -> Int { s.size }

pub fn chem_mol_props_logp_frame_get(s : ChemmolpropslogpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_frame_set(s : ChemmolpropslogpFrame, i : Int, v : Double) -> ChemmolpropslogpFrame {
  let result = chem_mol_props_logp_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_logp_frame_sum(s : ChemmolpropslogpFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_frame_mean(s : ChemmolpropslogpFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_frame_scale(s : ChemmolpropslogpFrame, f : Double) -> ChemmolpropslogpFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_frame_add(a : ChemmolpropslogpFrame, b : ChemmolpropslogpFrame) -> ChemmolpropslogpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_frame_copy(s : ChemmolpropslogpFrame) -> ChemmolpropslogpFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_frame_fill(s : ChemmolpropslogpFrame, v : Double) -> ChemmolpropslogpFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_frame_min(s : ChemmolpropslogpFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_frame_max(s : ChemmolpropslogpFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_frame_to_string(s : ChemmolpropslogpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_table_make(size : Int) -> ChemmolpropslogpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_table_len(s : ChemmolpropslogpTable) -> Int { s.size }

pub fn chem_mol_props_logp_table_get(s : ChemmolpropslogpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_table_set(s : ChemmolpropslogpTable, i : Int, v : Double) -> ChemmolpropslogpTable {
  let result = chem_mol_props_logp_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_logp_table_sum(s : ChemmolpropslogpTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_table_mean(s : ChemmolpropslogpTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_table_scale(s : ChemmolpropslogpTable, f : Double) -> ChemmolpropslogpTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_table_add(a : ChemmolpropslogpTable, b : ChemmolpropslogpTable) -> ChemmolpropslogpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_table_copy(s : ChemmolpropslogpTable) -> ChemmolpropslogpTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_table_fill(s : ChemmolpropslogpTable, v : Double) -> ChemmolpropslogpTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_table_min(s : ChemmolpropslogpTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_table_max(s : ChemmolpropslogpTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_table_to_string(s : ChemmolpropslogpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_graphn_make(size : Int) -> ChemmolpropslogpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_graphn_len(s : ChemmolpropslogpGraphN) -> Int { s.size }

pub fn chem_mol_props_logp_graphn_get(s : ChemmolpropslogpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_graphn_set(s : ChemmolpropslogpGraphN, i : Int, v : Double) -> ChemmolpropslogpGraphN {
  let result = chem_mol_props_logp_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_logp_graphn_sum(s : ChemmolpropslogpGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_graphn_mean(s : ChemmolpropslogpGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_graphn_scale(s : ChemmolpropslogpGraphN, f : Double) -> ChemmolpropslogpGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_graphn_add(a : ChemmolpropslogpGraphN, b : ChemmolpropslogpGraphN) -> ChemmolpropslogpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_graphn_copy(s : ChemmolpropslogpGraphN) -> ChemmolpropslogpGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_graphn_fill(s : ChemmolpropslogpGraphN, v : Double) -> ChemmolpropslogpGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_graphn_min(s : ChemmolpropslogpGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_graphn_max(s : ChemmolpropslogpGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_graphn_to_string(s : ChemmolpropslogpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_node_make(size : Int) -> ChemmolpropslogpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_node_len(s : ChemmolpropslogpNode) -> Int { s.size }

pub fn chem_mol_props_logp_node_get(s : ChemmolpropslogpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_node_set(s : ChemmolpropslogpNode, i : Int, v : Double) -> ChemmolpropslogpNode {
  let result = chem_mol_props_logp_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_logp_node_sum(s : ChemmolpropslogpNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_node_mean(s : ChemmolpropslogpNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_node_scale(s : ChemmolpropslogpNode, f : Double) -> ChemmolpropslogpNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_node_add(a : ChemmolpropslogpNode, b : ChemmolpropslogpNode) -> ChemmolpropslogpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_node_copy(s : ChemmolpropslogpNode) -> ChemmolpropslogpNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_node_fill(s : ChemmolpropslogpNode, v : Double) -> ChemmolpropslogpNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_node_min(s : ChemmolpropslogpNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_node_max(s : ChemmolpropslogpNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_node_to_string(s : ChemmolpropslogpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_edge_make(size : Int) -> ChemmolpropslogpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_edge_len(s : ChemmolpropslogpEdge) -> Int { s.size }

pub fn chem_mol_props_logp_edge_get(s : ChemmolpropslogpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_edge_set(s : ChemmolpropslogpEdge, i : Int, v : Double) -> ChemmolpropslogpEdge {
  let result = chem_mol_props_logp_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_logp_edge_sum(s : ChemmolpropslogpEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_edge_mean(s : ChemmolpropslogpEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_edge_scale(s : ChemmolpropslogpEdge, f : Double) -> ChemmolpropslogpEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_edge_add(a : ChemmolpropslogpEdge, b : ChemmolpropslogpEdge) -> ChemmolpropslogpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_edge_copy(s : ChemmolpropslogpEdge) -> ChemmolpropslogpEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_edge_fill(s : ChemmolpropslogpEdge, v : Double) -> ChemmolpropslogpEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_edge_min(s : ChemmolpropslogpEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_edge_max(s : ChemmolpropslogpEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_edge_to_string(s : ChemmolpropslogpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_path_make(size : Int) -> ChemmolpropslogpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_path_len(s : ChemmolpropslogpPath) -> Int { s.size }

pub fn chem_mol_props_logp_path_get(s : ChemmolpropslogpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_path_set(s : ChemmolpropslogpPath, i : Int, v : Double) -> ChemmolpropslogpPath {
  let result = chem_mol_props_logp_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_logp_path_sum(s : ChemmolpropslogpPath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_path_mean(s : ChemmolpropslogpPath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_path_scale(s : ChemmolpropslogpPath, f : Double) -> ChemmolpropslogpPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_path_add(a : ChemmolpropslogpPath, b : ChemmolpropslogpPath) -> ChemmolpropslogpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_path_copy(s : ChemmolpropslogpPath) -> ChemmolpropslogpPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_path_fill(s : ChemmolpropslogpPath, v : Double) -> ChemmolpropslogpPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_path_min(s : ChemmolpropslogpPath) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_path_max(s : ChemmolpropslogpPath) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_path_to_string(s : ChemmolpropslogpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_cluster_make(size : Int) -> ChemmolpropslogpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_cluster_len(s : ChemmolpropslogpCluster) -> Int { s.size }

pub fn chem_mol_props_logp_cluster_get(s : ChemmolpropslogpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_cluster_set(s : ChemmolpropslogpCluster, i : Int, v : Double) -> ChemmolpropslogpCluster {
  let result = chem_mol_props_logp_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_logp_cluster_sum(s : ChemmolpropslogpCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_cluster_mean(s : ChemmolpropslogpCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_cluster_scale(s : ChemmolpropslogpCluster, f : Double) -> ChemmolpropslogpCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_cluster_add(a : ChemmolpropslogpCluster, b : ChemmolpropslogpCluster) -> ChemmolpropslogpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_cluster_copy(s : ChemmolpropslogpCluster) -> ChemmolpropslogpCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_cluster_fill(s : ChemmolpropslogpCluster, v : Double) -> ChemmolpropslogpCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_cluster_min(s : ChemmolpropslogpCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_cluster_max(s : ChemmolpropslogpCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_cluster_to_string(s : ChemmolpropslogpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_model_make(size : Int) -> ChemmolpropslogpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_model_len(s : ChemmolpropslogpModel) -> Int { s.size }

pub fn chem_mol_props_logp_model_get(s : ChemmolpropslogpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_model_set(s : ChemmolpropslogpModel, i : Int, v : Double) -> ChemmolpropslogpModel {
  let result = chem_mol_props_logp_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_logp_model_sum(s : ChemmolpropslogpModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_model_mean(s : ChemmolpropslogpModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_model_scale(s : ChemmolpropslogpModel, f : Double) -> ChemmolpropslogpModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_model_add(a : ChemmolpropslogpModel, b : ChemmolpropslogpModel) -> ChemmolpropslogpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_model_copy(s : ChemmolpropslogpModel) -> ChemmolpropslogpModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_model_fill(s : ChemmolpropslogpModel, v : Double) -> ChemmolpropslogpModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_model_min(s : ChemmolpropslogpModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_model_max(s : ChemmolpropslogpModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_model_to_string(s : ChemmolpropslogpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_layer_make(size : Int) -> ChemmolpropslogpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_layer_len(s : ChemmolpropslogpLayer) -> Int { s.size }

pub fn chem_mol_props_logp_layer_get(s : ChemmolpropslogpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_layer_set(s : ChemmolpropslogpLayer, i : Int, v : Double) -> ChemmolpropslogpLayer {
  let result = chem_mol_props_logp_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_logp_layer_sum(s : ChemmolpropslogpLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_layer_mean(s : ChemmolpropslogpLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_layer_scale(s : ChemmolpropslogpLayer, f : Double) -> ChemmolpropslogpLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_layer_add(a : ChemmolpropslogpLayer, b : ChemmolpropslogpLayer) -> ChemmolpropslogpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_layer_copy(s : ChemmolpropslogpLayer) -> ChemmolpropslogpLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_layer_fill(s : ChemmolpropslogpLayer, v : Double) -> ChemmolpropslogpLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_layer_min(s : ChemmolpropslogpLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_layer_max(s : ChemmolpropslogpLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_layer_to_string(s : ChemmolpropslogpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_buffer_make(size : Int) -> ChemmolpropslogpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_buffer_len(s : ChemmolpropslogpBuffer) -> Int { s.size }

pub fn chem_mol_props_logp_buffer_get(s : ChemmolpropslogpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_buffer_set(s : ChemmolpropslogpBuffer, i : Int, v : Double) -> ChemmolpropslogpBuffer {
  let result = chem_mol_props_logp_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_logp_buffer_sum(s : ChemmolpropslogpBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_buffer_mean(s : ChemmolpropslogpBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_buffer_scale(s : ChemmolpropslogpBuffer, f : Double) -> ChemmolpropslogpBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_buffer_add(a : ChemmolpropslogpBuffer, b : ChemmolpropslogpBuffer) -> ChemmolpropslogpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_buffer_copy(s : ChemmolpropslogpBuffer) -> ChemmolpropslogpBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_buffer_fill(s : ChemmolpropslogpBuffer, v : Double) -> ChemmolpropslogpBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_buffer_min(s : ChemmolpropslogpBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_buffer_max(s : ChemmolpropslogpBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_buffer_to_string(s : ChemmolpropslogpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_cursor_make(size : Int) -> ChemmolpropslogpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_cursor_len(s : ChemmolpropslogpCursor) -> Int { s.size }

pub fn chem_mol_props_logp_cursor_get(s : ChemmolpropslogpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_cursor_set(s : ChemmolpropslogpCursor, i : Int, v : Double) -> ChemmolpropslogpCursor {
  let result = chem_mol_props_logp_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_logp_cursor_sum(s : ChemmolpropslogpCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_cursor_mean(s : ChemmolpropslogpCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_cursor_scale(s : ChemmolpropslogpCursor, f : Double) -> ChemmolpropslogpCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_cursor_add(a : ChemmolpropslogpCursor, b : ChemmolpropslogpCursor) -> ChemmolpropslogpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_cursor_copy(s : ChemmolpropslogpCursor) -> ChemmolpropslogpCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_cursor_fill(s : ChemmolpropslogpCursor, v : Double) -> ChemmolpropslogpCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_cursor_min(s : ChemmolpropslogpCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_cursor_max(s : ChemmolpropslogpCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_cursor_to_string(s : ChemmolpropslogpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_view_make(size : Int) -> ChemmolpropslogpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_view_len(s : ChemmolpropslogpView) -> Int { s.size }

pub fn chem_mol_props_logp_view_get(s : ChemmolpropslogpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_view_set(s : ChemmolpropslogpView, i : Int, v : Double) -> ChemmolpropslogpView {
  let result = chem_mol_props_logp_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_logp_view_sum(s : ChemmolpropslogpView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_view_mean(s : ChemmolpropslogpView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_view_scale(s : ChemmolpropslogpView, f : Double) -> ChemmolpropslogpView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_view_add(a : ChemmolpropslogpView, b : ChemmolpropslogpView) -> ChemmolpropslogpView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_view_copy(s : ChemmolpropslogpView) -> ChemmolpropslogpView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_view_fill(s : ChemmolpropslogpView, v : Double) -> ChemmolpropslogpView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_view_min(s : ChemmolpropslogpView) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_view_max(s : ChemmolpropslogpView) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_view_to_string(s : ChemmolpropslogpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_range_make(size : Int) -> ChemmolpropslogpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_range_len(s : ChemmolpropslogpRange) -> Int { s.size }

pub fn chem_mol_props_logp_range_get(s : ChemmolpropslogpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_range_set(s : ChemmolpropslogpRange, i : Int, v : Double) -> ChemmolpropslogpRange {
  let result = chem_mol_props_logp_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_logp_range_sum(s : ChemmolpropslogpRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_range_mean(s : ChemmolpropslogpRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_range_scale(s : ChemmolpropslogpRange, f : Double) -> ChemmolpropslogpRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_range_add(a : ChemmolpropslogpRange, b : ChemmolpropslogpRange) -> ChemmolpropslogpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_range_copy(s : ChemmolpropslogpRange) -> ChemmolpropslogpRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_range_fill(s : ChemmolpropslogpRange, v : Double) -> ChemmolpropslogpRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_range_min(s : ChemmolpropslogpRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_range_max(s : ChemmolpropslogpRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_range_to_string(s : ChemmolpropslogpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_slice_make(size : Int) -> ChemmolpropslogpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_slice_len(s : ChemmolpropslogpSlice) -> Int { s.size }

pub fn chem_mol_props_logp_slice_get(s : ChemmolpropslogpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_slice_set(s : ChemmolpropslogpSlice, i : Int, v : Double) -> ChemmolpropslogpSlice {
  let result = chem_mol_props_logp_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_logp_slice_sum(s : ChemmolpropslogpSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_slice_mean(s : ChemmolpropslogpSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_slice_scale(s : ChemmolpropslogpSlice, f : Double) -> ChemmolpropslogpSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_slice_add(a : ChemmolpropslogpSlice, b : ChemmolpropslogpSlice) -> ChemmolpropslogpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_slice_copy(s : ChemmolpropslogpSlice) -> ChemmolpropslogpSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_slice_fill(s : ChemmolpropslogpSlice, v : Double) -> ChemmolpropslogpSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_slice_min(s : ChemmolpropslogpSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_slice_max(s : ChemmolpropslogpSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_slice_to_string(s : ChemmolpropslogpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

