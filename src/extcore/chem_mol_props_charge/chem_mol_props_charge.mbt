///===
/// extcore/chem_mol_props_charge

pub(all) struct ChemmolpropschargePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_charge_make_point(x : Double, y : Double) -> ChemmolpropschargePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_charge_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropschargePoint {
  { x, y, z, label: 0 }
}

pub fn chem_mol_props_charge_point_x(pt : ChemmolpropschargePoint) -> Double { pt.x }

pub fn chem_mol_props_charge_point_y(pt : ChemmolpropschargePoint) -> Double { pt.y }

pub fn chem_mol_props_charge_point_z(pt : ChemmolpropschargePoint) -> Double { pt.z }

pub fn chem_mol_props_charge_point_label(pt : ChemmolpropschargePoint) -> Int { pt.label }

pub fn chem_mol_props_charge_point_dist(a : ChemmolpropschargePoint, b : ChemmolpropschargePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_mol_props_charge_point_add(a : ChemmolpropschargePoint, b : ChemmolpropschargePoint) -> ChemmolpropschargePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_mol_props_charge_point_sub(a : ChemmolpropschargePoint, b : ChemmolpropschargePoint) -> ChemmolpropschargePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_mol_props_charge_point_scale(pt : ChemmolpropschargePoint, s : Double) -> ChemmolpropschargePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_mol_props_charge_point_dot(a : ChemmolpropschargePoint, b : ChemmolpropschargePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_mol_props_charge_point_cross(a : ChemmolpropschargePoint, b : ChemmolpropschargePoint) -> ChemmolpropschargePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_mol_props_charge_point_norm(pt : ChemmolpropschargePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_mol_props_charge_point_normalize(pt : ChemmolpropschargePoint) -> ChemmolpropschargePoint {
  let n = chem_mol_props_charge_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_mol_props_charge_point_scale(pt, 1.0 / n) }
}

pub fn chem_mol_props_charge_point_negate(pt : ChemmolpropschargePoint) -> ChemmolpropschargePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_mol_props_charge_point_mid(a : ChemmolpropschargePoint, b : ChemmolpropschargePoint) -> ChemmolpropschargePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_mol_props_charge_point_lerp(a : ChemmolpropschargePoint, b : ChemmolpropschargePoint, t : Double) -> ChemmolpropschargePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_mol_props_charge_point_to_string(pt : ChemmolpropschargePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemmolpropschargeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_charge_make_series(vals : Array[Double], name : String) -> ChemmolpropschargeSeries {
  { vals, name, meta: 0 }
}

pub fn chem_mol_props_charge_series_len(s : ChemmolpropschargeSeries) -> Int { s.vals.length() }

pub fn chem_mol_props_charge_series_sum(s : ChemmolpropschargeSeries) -> Double { @_common.sum(s.vals) }

pub fn chem_mol_props_charge_series_mean(s : ChemmolpropschargeSeries) -> Double { @_common.mean(s.vals) }

pub fn chem_mol_props_charge_series_min(s : ChemmolpropschargeSeries) -> Double { @_common.min(s.vals) }

pub fn chem_mol_props_charge_series_max(s : ChemmolpropschargeSeries) -> Double { @_common.max(s.vals) }

pub fn chem_mol_props_charge_series_range(s : ChemmolpropschargeSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn chem_mol_props_charge_series_var(s : ChemmolpropschargeSeries) -> Double { @_common.variance(s.vals) }

pub fn chem_mol_props_charge_series_std(s : ChemmolpropschargeSeries) -> Double { @_common.std(s.vals) }

pub fn chem_mol_props_charge_series_median(s : ChemmolpropschargeSeries) -> Double { @_common.median(s.vals) }

pub fn chem_mol_props_charge_series_scale(s : ChemmolpropschargeSeries, f : Double) -> ChemmolpropschargeSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn chem_mol_props_charge_series_add(a : ChemmolpropschargeSeries, b : ChemmolpropschargeSeries) -> ChemmolpropschargeSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_mol_props_charge_series_sub(a : ChemmolpropschargeSeries, b : ChemmolpropschargeSeries) -> ChemmolpropschargeSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_mol_props_charge_series_normalize(s : ChemmolpropschargeSeries) -> ChemmolpropschargeSeries {
  let mn = chem_mol_props_charge_series_min(s)
  let mx = chem_mol_props_charge_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_mol_props_charge_series_cumsum(s : ChemmolpropschargeSeries) -> ChemmolpropschargeSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_mol_props_charge_series_to_string(s : ChemmolpropschargeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropschargeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_charge_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropschargeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_charge_matrix_identity(n : Int) -> ChemmolpropschargeMatrix {
  let m = chem_mol_props_charge_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_mol_props_charge_matrix_get(m : ChemmolpropschargeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_mol_props_charge_matrix_transpose(m : ChemmolpropschargeMatrix) -> ChemmolpropschargeMatrix {
  let result = chem_mol_props_charge_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_mol_props_charge_matrix_add(a : ChemmolpropschargeMatrix, b : ChemmolpropschargeMatrix) -> ChemmolpropschargeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_mol_props_charge_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_mol_props_charge_matrix_scale(m : ChemmolpropschargeMatrix, s : Double) -> ChemmolpropschargeMatrix {
  let result = chem_mol_props_charge_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_mol_props_charge_matrix_multiply(a : ChemmolpropschargeMatrix, b : ChemmolpropschargeMatrix) -> ChemmolpropschargeMatrix {
  if a.cols != b.rows { return chem_mol_props_charge_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_mol_props_charge_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_mol_props_charge_matrix_trace(m : ChemmolpropschargeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_mol_props_charge_matrix_det(m : ChemmolpropschargeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_mol_props_charge_matrix_norm(m : ChemmolpropschargeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_mol_props_charge_matrix_to_string(m : ChemmolpropschargeMatrix) -> String {
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

pub(all) struct ChemmolpropschargeVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_charge_make_vector(comps : Array[Double]) -> ChemmolpropschargeVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_charge_vector_zero(dim : Int) -> ChemmolpropschargeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_mol_props_charge_vector_add(a : ChemmolpropschargeVector, b : ChemmolpropschargeVector) -> ChemmolpropschargeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn chem_mol_props_charge_vector_sub(a : ChemmolpropschargeVector, b : ChemmolpropschargeVector) -> ChemmolpropschargeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn chem_mol_props_charge_vector_scale(v : ChemmolpropschargeVector, s : Double) -> ChemmolpropschargeVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn chem_mol_props_charge_vector_dot(a : ChemmolpropschargeVector, b : ChemmolpropschargeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_mol_props_charge_vector_norm(v : ChemmolpropschargeVector) -> Double { @_common.sqrt(chem_mol_props_charge_vector_dot(v, v)) }

pub fn chem_mol_props_charge_vector_normalize(v : ChemmolpropschargeVector) -> ChemmolpropschargeVector {
  let n = chem_mol_props_charge_vector_norm(v)
  if n < 0.0000001 { v } else { chem_mol_props_charge_vector_scale(v, 1.0 / n) }
}

pub fn chem_mol_props_charge_vector_dist(a : ChemmolpropschargeVector, b : ChemmolpropschargeVector) -> Double {
  chem_mol_props_charge_vector_norm(chem_mol_props_charge_vector_sub(a, b))
}

pub fn chem_mol_props_charge_vector_to_string(v : ChemmolpropschargeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_props_charge_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_props_charge_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_props_charge_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_props_charge_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_props_charge_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_props_charge_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_props_charge_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_props_charge_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_props_charge_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_props_charge_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_props_charge_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_props_charge_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_props_charge_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_props_charge_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_props_charge_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_props_charge_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_props_charge_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_props_charge_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_props_charge_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_props_charge_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_props_charge_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_props_charge_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_props_charge_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_props_charge_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_props_charge_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_props_charge_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_props_charge_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_props_charge_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_props_charge_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolpropschargeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_frame_make(size : Int) -> ChemmolpropschargeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_frame_len(s : ChemmolpropschargeFrame) -> Int { s.size }

pub fn chem_mol_props_charge_frame_get(s : ChemmolpropschargeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_frame_set(s : ChemmolpropschargeFrame, i : Int, v : Double) -> ChemmolpropschargeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_frame_sum(s : ChemmolpropschargeFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_frame_mean(s : ChemmolpropschargeFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_frame_scale(s : ChemmolpropschargeFrame, f : Double) -> ChemmolpropschargeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_frame_add(a : ChemmolpropschargeFrame, b : ChemmolpropschargeFrame) -> ChemmolpropschargeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_frame_copy(s : ChemmolpropschargeFrame) -> ChemmolpropschargeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_frame_fill(s : ChemmolpropschargeFrame, v : Double) -> ChemmolpropschargeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_frame_min(s : ChemmolpropschargeFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_frame_max(s : ChemmolpropschargeFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_frame_to_string(s : ChemmolpropschargeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_table_make(size : Int) -> ChemmolpropschargeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_table_len(s : ChemmolpropschargeTable) -> Int { s.size }

pub fn chem_mol_props_charge_table_get(s : ChemmolpropschargeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_table_set(s : ChemmolpropschargeTable, i : Int, v : Double) -> ChemmolpropschargeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_table_sum(s : ChemmolpropschargeTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_table_mean(s : ChemmolpropschargeTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_table_scale(s : ChemmolpropschargeTable, f : Double) -> ChemmolpropschargeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_table_add(a : ChemmolpropschargeTable, b : ChemmolpropschargeTable) -> ChemmolpropschargeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_table_copy(s : ChemmolpropschargeTable) -> ChemmolpropschargeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_table_fill(s : ChemmolpropschargeTable, v : Double) -> ChemmolpropschargeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_table_min(s : ChemmolpropschargeTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_table_max(s : ChemmolpropschargeTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_table_to_string(s : ChemmolpropschargeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_graphn_make(size : Int) -> ChemmolpropschargeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_graphn_len(s : ChemmolpropschargeGraphN) -> Int { s.size }

pub fn chem_mol_props_charge_graphn_get(s : ChemmolpropschargeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_graphn_set(s : ChemmolpropschargeGraphN, i : Int, v : Double) -> ChemmolpropschargeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_graphn_sum(s : ChemmolpropschargeGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_graphn_mean(s : ChemmolpropschargeGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_graphn_scale(s : ChemmolpropschargeGraphN, f : Double) -> ChemmolpropschargeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_graphn_add(a : ChemmolpropschargeGraphN, b : ChemmolpropschargeGraphN) -> ChemmolpropschargeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_graphn_copy(s : ChemmolpropschargeGraphN) -> ChemmolpropschargeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_graphn_fill(s : ChemmolpropschargeGraphN, v : Double) -> ChemmolpropschargeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_graphn_min(s : ChemmolpropschargeGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_graphn_max(s : ChemmolpropschargeGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_graphn_to_string(s : ChemmolpropschargeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_node_make(size : Int) -> ChemmolpropschargeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_node_len(s : ChemmolpropschargeNode) -> Int { s.size }

pub fn chem_mol_props_charge_node_get(s : ChemmolpropschargeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_node_set(s : ChemmolpropschargeNode, i : Int, v : Double) -> ChemmolpropschargeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_node_sum(s : ChemmolpropschargeNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_node_mean(s : ChemmolpropschargeNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_node_scale(s : ChemmolpropschargeNode, f : Double) -> ChemmolpropschargeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_node_add(a : ChemmolpropschargeNode, b : ChemmolpropschargeNode) -> ChemmolpropschargeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_node_copy(s : ChemmolpropschargeNode) -> ChemmolpropschargeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_node_fill(s : ChemmolpropschargeNode, v : Double) -> ChemmolpropschargeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_node_min(s : ChemmolpropschargeNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_node_max(s : ChemmolpropschargeNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_node_to_string(s : ChemmolpropschargeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_edge_make(size : Int) -> ChemmolpropschargeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_edge_len(s : ChemmolpropschargeEdge) -> Int { s.size }

pub fn chem_mol_props_charge_edge_get(s : ChemmolpropschargeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_edge_set(s : ChemmolpropschargeEdge, i : Int, v : Double) -> ChemmolpropschargeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_edge_sum(s : ChemmolpropschargeEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_edge_mean(s : ChemmolpropschargeEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_edge_scale(s : ChemmolpropschargeEdge, f : Double) -> ChemmolpropschargeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_edge_add(a : ChemmolpropschargeEdge, b : ChemmolpropschargeEdge) -> ChemmolpropschargeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_edge_copy(s : ChemmolpropschargeEdge) -> ChemmolpropschargeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_edge_fill(s : ChemmolpropschargeEdge, v : Double) -> ChemmolpropschargeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_edge_min(s : ChemmolpropschargeEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_edge_max(s : ChemmolpropschargeEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_edge_to_string(s : ChemmolpropschargeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_path_make(size : Int) -> ChemmolpropschargePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_path_len(s : ChemmolpropschargePath) -> Int { s.size }

pub fn chem_mol_props_charge_path_get(s : ChemmolpropschargePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_path_set(s : ChemmolpropschargePath, i : Int, v : Double) -> ChemmolpropschargePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_path_sum(s : ChemmolpropschargePath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_path_mean(s : ChemmolpropschargePath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_path_scale(s : ChemmolpropschargePath, f : Double) -> ChemmolpropschargePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_path_add(a : ChemmolpropschargePath, b : ChemmolpropschargePath) -> ChemmolpropschargePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_path_copy(s : ChemmolpropschargePath) -> ChemmolpropschargePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_path_fill(s : ChemmolpropschargePath, v : Double) -> ChemmolpropschargePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_path_min(s : ChemmolpropschargePath) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_path_max(s : ChemmolpropschargePath) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_path_to_string(s : ChemmolpropschargePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_cluster_make(size : Int) -> ChemmolpropschargeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_cluster_len(s : ChemmolpropschargeCluster) -> Int { s.size }

pub fn chem_mol_props_charge_cluster_get(s : ChemmolpropschargeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_cluster_set(s : ChemmolpropschargeCluster, i : Int, v : Double) -> ChemmolpropschargeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_cluster_sum(s : ChemmolpropschargeCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_cluster_mean(s : ChemmolpropschargeCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_cluster_scale(s : ChemmolpropschargeCluster, f : Double) -> ChemmolpropschargeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_cluster_add(a : ChemmolpropschargeCluster, b : ChemmolpropschargeCluster) -> ChemmolpropschargeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_cluster_copy(s : ChemmolpropschargeCluster) -> ChemmolpropschargeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_cluster_fill(s : ChemmolpropschargeCluster, v : Double) -> ChemmolpropschargeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_cluster_min(s : ChemmolpropschargeCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_cluster_max(s : ChemmolpropschargeCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_cluster_to_string(s : ChemmolpropschargeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_model_make(size : Int) -> ChemmolpropschargeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_model_len(s : ChemmolpropschargeModel) -> Int { s.size }

pub fn chem_mol_props_charge_model_get(s : ChemmolpropschargeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_model_set(s : ChemmolpropschargeModel, i : Int, v : Double) -> ChemmolpropschargeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_model_sum(s : ChemmolpropschargeModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_model_mean(s : ChemmolpropschargeModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_model_scale(s : ChemmolpropschargeModel, f : Double) -> ChemmolpropschargeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_model_add(a : ChemmolpropschargeModel, b : ChemmolpropschargeModel) -> ChemmolpropschargeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_model_copy(s : ChemmolpropschargeModel) -> ChemmolpropschargeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_model_fill(s : ChemmolpropschargeModel, v : Double) -> ChemmolpropschargeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_model_min(s : ChemmolpropschargeModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_model_max(s : ChemmolpropschargeModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_model_to_string(s : ChemmolpropschargeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_layer_make(size : Int) -> ChemmolpropschargeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_layer_len(s : ChemmolpropschargeLayer) -> Int { s.size }

pub fn chem_mol_props_charge_layer_get(s : ChemmolpropschargeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_layer_set(s : ChemmolpropschargeLayer, i : Int, v : Double) -> ChemmolpropschargeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_layer_sum(s : ChemmolpropschargeLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_layer_mean(s : ChemmolpropschargeLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_layer_scale(s : ChemmolpropschargeLayer, f : Double) -> ChemmolpropschargeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_layer_add(a : ChemmolpropschargeLayer, b : ChemmolpropschargeLayer) -> ChemmolpropschargeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_layer_copy(s : ChemmolpropschargeLayer) -> ChemmolpropschargeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_layer_fill(s : ChemmolpropschargeLayer, v : Double) -> ChemmolpropschargeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_layer_min(s : ChemmolpropschargeLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_layer_max(s : ChemmolpropschargeLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_layer_to_string(s : ChemmolpropschargeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_buffer_make(size : Int) -> ChemmolpropschargeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_buffer_len(s : ChemmolpropschargeBuffer) -> Int { s.size }

pub fn chem_mol_props_charge_buffer_get(s : ChemmolpropschargeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_buffer_set(s : ChemmolpropschargeBuffer, i : Int, v : Double) -> ChemmolpropschargeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_buffer_sum(s : ChemmolpropschargeBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_buffer_mean(s : ChemmolpropschargeBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_buffer_scale(s : ChemmolpropschargeBuffer, f : Double) -> ChemmolpropschargeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_buffer_add(a : ChemmolpropschargeBuffer, b : ChemmolpropschargeBuffer) -> ChemmolpropschargeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_buffer_copy(s : ChemmolpropschargeBuffer) -> ChemmolpropschargeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_buffer_fill(s : ChemmolpropschargeBuffer, v : Double) -> ChemmolpropschargeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_buffer_min(s : ChemmolpropschargeBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_buffer_max(s : ChemmolpropschargeBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_buffer_to_string(s : ChemmolpropschargeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_cursor_make(size : Int) -> ChemmolpropschargeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_cursor_len(s : ChemmolpropschargeCursor) -> Int { s.size }

pub fn chem_mol_props_charge_cursor_get(s : ChemmolpropschargeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_cursor_set(s : ChemmolpropschargeCursor, i : Int, v : Double) -> ChemmolpropschargeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_cursor_sum(s : ChemmolpropschargeCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_cursor_mean(s : ChemmolpropschargeCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_cursor_scale(s : ChemmolpropschargeCursor, f : Double) -> ChemmolpropschargeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_cursor_add(a : ChemmolpropschargeCursor, b : ChemmolpropschargeCursor) -> ChemmolpropschargeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_cursor_copy(s : ChemmolpropschargeCursor) -> ChemmolpropschargeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_cursor_fill(s : ChemmolpropschargeCursor, v : Double) -> ChemmolpropschargeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_cursor_min(s : ChemmolpropschargeCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_cursor_max(s : ChemmolpropschargeCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_cursor_to_string(s : ChemmolpropschargeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_view_make(size : Int) -> ChemmolpropschargeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_view_len(s : ChemmolpropschargeView) -> Int { s.size }

pub fn chem_mol_props_charge_view_get(s : ChemmolpropschargeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_view_set(s : ChemmolpropschargeView, i : Int, v : Double) -> ChemmolpropschargeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_view_sum(s : ChemmolpropschargeView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_view_mean(s : ChemmolpropschargeView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_view_scale(s : ChemmolpropschargeView, f : Double) -> ChemmolpropschargeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_view_add(a : ChemmolpropschargeView, b : ChemmolpropschargeView) -> ChemmolpropschargeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_view_copy(s : ChemmolpropschargeView) -> ChemmolpropschargeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_view_fill(s : ChemmolpropschargeView, v : Double) -> ChemmolpropschargeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_view_min(s : ChemmolpropschargeView) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_view_max(s : ChemmolpropschargeView) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_view_to_string(s : ChemmolpropschargeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_range_make(size : Int) -> ChemmolpropschargeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_range_len(s : ChemmolpropschargeRange) -> Int { s.size }

pub fn chem_mol_props_charge_range_get(s : ChemmolpropschargeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_range_set(s : ChemmolpropschargeRange, i : Int, v : Double) -> ChemmolpropschargeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_range_sum(s : ChemmolpropschargeRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_range_mean(s : ChemmolpropschargeRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_range_scale(s : ChemmolpropschargeRange, f : Double) -> ChemmolpropschargeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_range_add(a : ChemmolpropschargeRange, b : ChemmolpropschargeRange) -> ChemmolpropschargeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_range_copy(s : ChemmolpropschargeRange) -> ChemmolpropschargeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_range_fill(s : ChemmolpropschargeRange, v : Double) -> ChemmolpropschargeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_range_min(s : ChemmolpropschargeRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_range_max(s : ChemmolpropschargeRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_range_to_string(s : ChemmolpropschargeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_slice_make(size : Int) -> ChemmolpropschargeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_slice_len(s : ChemmolpropschargeSlice) -> Int { s.size }

pub fn chem_mol_props_charge_slice_get(s : ChemmolpropschargeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_slice_set(s : ChemmolpropschargeSlice, i : Int, v : Double) -> ChemmolpropschargeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_slice_sum(s : ChemmolpropschargeSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_slice_mean(s : ChemmolpropschargeSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_slice_scale(s : ChemmolpropschargeSlice, f : Double) -> ChemmolpropschargeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_slice_add(a : ChemmolpropschargeSlice, b : ChemmolpropschargeSlice) -> ChemmolpropschargeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_slice_copy(s : ChemmolpropschargeSlice) -> ChemmolpropschargeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_slice_fill(s : ChemmolpropschargeSlice, v : Double) -> ChemmolpropschargeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_slice_min(s : ChemmolpropschargeSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_slice_max(s : ChemmolpropschargeSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_slice_to_string(s : ChemmolpropschargeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

