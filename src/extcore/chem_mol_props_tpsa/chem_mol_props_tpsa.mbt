///===
/// extcore/chem_mol_props_tpsa

pub(all) struct ChemmolpropstpsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_tpsa_make_point(x : Double, y : Double) -> ChemmolpropstpsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_tpsa_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropstpsaPoint {
  { x, y, z, label: 0 }
}

pub fn chem_mol_props_tpsa_point_x(pt : ChemmolpropstpsaPoint) -> Double { pt.x }

pub fn chem_mol_props_tpsa_point_y(pt : ChemmolpropstpsaPoint) -> Double { pt.y }

pub fn chem_mol_props_tpsa_point_z(pt : ChemmolpropstpsaPoint) -> Double { pt.z }

pub fn chem_mol_props_tpsa_point_label(pt : ChemmolpropstpsaPoint) -> Int { pt.label }

pub fn chem_mol_props_tpsa_point_dist(a : ChemmolpropstpsaPoint, b : ChemmolpropstpsaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_mol_props_tpsa_point_add(a : ChemmolpropstpsaPoint, b : ChemmolpropstpsaPoint) -> ChemmolpropstpsaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_mol_props_tpsa_point_sub(a : ChemmolpropstpsaPoint, b : ChemmolpropstpsaPoint) -> ChemmolpropstpsaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_mol_props_tpsa_point_scale(pt : ChemmolpropstpsaPoint, s : Double) -> ChemmolpropstpsaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_mol_props_tpsa_point_dot(a : ChemmolpropstpsaPoint, b : ChemmolpropstpsaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_mol_props_tpsa_point_cross(a : ChemmolpropstpsaPoint, b : ChemmolpropstpsaPoint) -> ChemmolpropstpsaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_mol_props_tpsa_point_norm(pt : ChemmolpropstpsaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_mol_props_tpsa_point_normalize(pt : ChemmolpropstpsaPoint) -> ChemmolpropstpsaPoint {
  let n = chem_mol_props_tpsa_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_mol_props_tpsa_point_scale(pt, 1.0 / n) }
}

pub fn chem_mol_props_tpsa_point_negate(pt : ChemmolpropstpsaPoint) -> ChemmolpropstpsaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_mol_props_tpsa_point_mid(a : ChemmolpropstpsaPoint, b : ChemmolpropstpsaPoint) -> ChemmolpropstpsaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_mol_props_tpsa_point_lerp(a : ChemmolpropstpsaPoint, b : ChemmolpropstpsaPoint, t : Double) -> ChemmolpropstpsaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_mol_props_tpsa_point_to_string(pt : ChemmolpropstpsaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_tpsa_make_series(vals : Array[Double], name : String) -> ChemmolpropstpsaSeries {
  { vals, name, meta: 0 }
}

pub fn chem_mol_props_tpsa_series_len(s : ChemmolpropstpsaSeries) -> Int { s.vals.length() }

pub fn chem_mol_props_tpsa_series_sum(s : ChemmolpropstpsaSeries) -> Double { @_common.sum(s.vals) }

pub fn chem_mol_props_tpsa_series_mean(s : ChemmolpropstpsaSeries) -> Double { @_common.mean(s.vals) }

pub fn chem_mol_props_tpsa_series_min(s : ChemmolpropstpsaSeries) -> Double { @_common.min(s.vals) }

pub fn chem_mol_props_tpsa_series_max(s : ChemmolpropstpsaSeries) -> Double { @_common.max(s.vals) }

pub fn chem_mol_props_tpsa_series_range(s : ChemmolpropstpsaSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn chem_mol_props_tpsa_series_var(s : ChemmolpropstpsaSeries) -> Double { @_common.variance(s.vals) }

pub fn chem_mol_props_tpsa_series_std(s : ChemmolpropstpsaSeries) -> Double { @_common.std(s.vals) }

pub fn chem_mol_props_tpsa_series_median(s : ChemmolpropstpsaSeries) -> Double { @_common.median(s.vals) }

pub fn chem_mol_props_tpsa_series_scale(s : ChemmolpropstpsaSeries, f : Double) -> ChemmolpropstpsaSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn chem_mol_props_tpsa_series_add(a : ChemmolpropstpsaSeries, b : ChemmolpropstpsaSeries) -> ChemmolpropstpsaSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_mol_props_tpsa_series_sub(a : ChemmolpropstpsaSeries, b : ChemmolpropstpsaSeries) -> ChemmolpropstpsaSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_mol_props_tpsa_series_normalize(s : ChemmolpropstpsaSeries) -> ChemmolpropstpsaSeries {
  let mn = chem_mol_props_tpsa_series_min(s)
  let mx = chem_mol_props_tpsa_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_mol_props_tpsa_series_cumsum(s : ChemmolpropstpsaSeries) -> ChemmolpropstpsaSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_mol_props_tpsa_series_to_string(s : ChemmolpropstpsaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropstpsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_tpsa_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropstpsaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_tpsa_matrix_identity(n : Int) -> ChemmolpropstpsaMatrix {
  let m = chem_mol_props_tpsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_mol_props_tpsa_matrix_get(m : ChemmolpropstpsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_mol_props_tpsa_matrix_transpose(m : ChemmolpropstpsaMatrix) -> ChemmolpropstpsaMatrix {
  let result = chem_mol_props_tpsa_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_mol_props_tpsa_matrix_add(a : ChemmolpropstpsaMatrix, b : ChemmolpropstpsaMatrix) -> ChemmolpropstpsaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_mol_props_tpsa_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_mol_props_tpsa_matrix_scale(m : ChemmolpropstpsaMatrix, s : Double) -> ChemmolpropstpsaMatrix {
  let result = chem_mol_props_tpsa_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_mol_props_tpsa_matrix_multiply(a : ChemmolpropstpsaMatrix, b : ChemmolpropstpsaMatrix) -> ChemmolpropstpsaMatrix {
  if a.cols != b.rows { return chem_mol_props_tpsa_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_mol_props_tpsa_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_mol_props_tpsa_matrix_trace(m : ChemmolpropstpsaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_mol_props_tpsa_matrix_det(m : ChemmolpropstpsaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_mol_props_tpsa_matrix_norm(m : ChemmolpropstpsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_mol_props_tpsa_matrix_to_string(m : ChemmolpropstpsaMatrix) -> String {
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

pub(all) struct ChemmolpropstpsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_tpsa_make_vector(comps : Array[Double]) -> ChemmolpropstpsaVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_tpsa_vector_zero(dim : Int) -> ChemmolpropstpsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_mol_props_tpsa_vector_add(a : ChemmolpropstpsaVector, b : ChemmolpropstpsaVector) -> ChemmolpropstpsaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn chem_mol_props_tpsa_vector_sub(a : ChemmolpropstpsaVector, b : ChemmolpropstpsaVector) -> ChemmolpropstpsaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn chem_mol_props_tpsa_vector_scale(v : ChemmolpropstpsaVector, s : Double) -> ChemmolpropstpsaVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn chem_mol_props_tpsa_vector_dot(a : ChemmolpropstpsaVector, b : ChemmolpropstpsaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_mol_props_tpsa_vector_norm(v : ChemmolpropstpsaVector) -> Double { @_common.sqrt(chem_mol_props_tpsa_vector_dot(v, v)) }

pub fn chem_mol_props_tpsa_vector_normalize(v : ChemmolpropstpsaVector) -> ChemmolpropstpsaVector {
  let n = chem_mol_props_tpsa_vector_norm(v)
  if n < 0.0000001 { v } else { chem_mol_props_tpsa_vector_scale(v, 1.0 / n) }
}

pub fn chem_mol_props_tpsa_vector_dist(a : ChemmolpropstpsaVector, b : ChemmolpropstpsaVector) -> Double {
  chem_mol_props_tpsa_vector_norm(chem_mol_props_tpsa_vector_sub(a, b))
}

pub fn chem_mol_props_tpsa_vector_to_string(v : ChemmolpropstpsaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_props_tpsa_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_props_tpsa_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_props_tpsa_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_props_tpsa_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_props_tpsa_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_props_tpsa_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_props_tpsa_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_props_tpsa_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_props_tpsa_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_props_tpsa_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_props_tpsa_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_props_tpsa_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_props_tpsa_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_props_tpsa_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_props_tpsa_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_props_tpsa_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_props_tpsa_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_props_tpsa_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_props_tpsa_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_props_tpsa_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_props_tpsa_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_props_tpsa_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_props_tpsa_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_props_tpsa_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_props_tpsa_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_props_tpsa_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_props_tpsa_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_props_tpsa_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_props_tpsa_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolpropstpsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_frame_make(size : Int) -> ChemmolpropstpsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_frame_len(s : ChemmolpropstpsaFrame) -> Int { s.size }

pub fn chem_mol_props_tpsa_frame_get(s : ChemmolpropstpsaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_frame_set(s : ChemmolpropstpsaFrame, i : Int, v : Double) -> ChemmolpropstpsaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_frame_sum(s : ChemmolpropstpsaFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_frame_mean(s : ChemmolpropstpsaFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_frame_scale(s : ChemmolpropstpsaFrame, f : Double) -> ChemmolpropstpsaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_frame_add(a : ChemmolpropstpsaFrame, b : ChemmolpropstpsaFrame) -> ChemmolpropstpsaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_frame_copy(s : ChemmolpropstpsaFrame) -> ChemmolpropstpsaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_frame_fill(s : ChemmolpropstpsaFrame, v : Double) -> ChemmolpropstpsaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_frame_min(s : ChemmolpropstpsaFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_frame_max(s : ChemmolpropstpsaFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_frame_to_string(s : ChemmolpropstpsaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_table_make(size : Int) -> ChemmolpropstpsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_table_len(s : ChemmolpropstpsaTable) -> Int { s.size }

pub fn chem_mol_props_tpsa_table_get(s : ChemmolpropstpsaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_table_set(s : ChemmolpropstpsaTable, i : Int, v : Double) -> ChemmolpropstpsaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_table_sum(s : ChemmolpropstpsaTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_table_mean(s : ChemmolpropstpsaTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_table_scale(s : ChemmolpropstpsaTable, f : Double) -> ChemmolpropstpsaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_table_add(a : ChemmolpropstpsaTable, b : ChemmolpropstpsaTable) -> ChemmolpropstpsaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_table_copy(s : ChemmolpropstpsaTable) -> ChemmolpropstpsaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_table_fill(s : ChemmolpropstpsaTable, v : Double) -> ChemmolpropstpsaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_table_min(s : ChemmolpropstpsaTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_table_max(s : ChemmolpropstpsaTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_table_to_string(s : ChemmolpropstpsaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_graphn_make(size : Int) -> ChemmolpropstpsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_graphn_len(s : ChemmolpropstpsaGraphN) -> Int { s.size }

pub fn chem_mol_props_tpsa_graphn_get(s : ChemmolpropstpsaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_graphn_set(s : ChemmolpropstpsaGraphN, i : Int, v : Double) -> ChemmolpropstpsaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_graphn_sum(s : ChemmolpropstpsaGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_graphn_mean(s : ChemmolpropstpsaGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_graphn_scale(s : ChemmolpropstpsaGraphN, f : Double) -> ChemmolpropstpsaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_graphn_add(a : ChemmolpropstpsaGraphN, b : ChemmolpropstpsaGraphN) -> ChemmolpropstpsaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_graphn_copy(s : ChemmolpropstpsaGraphN) -> ChemmolpropstpsaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_graphn_fill(s : ChemmolpropstpsaGraphN, v : Double) -> ChemmolpropstpsaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_graphn_min(s : ChemmolpropstpsaGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_graphn_max(s : ChemmolpropstpsaGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_graphn_to_string(s : ChemmolpropstpsaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_node_make(size : Int) -> ChemmolpropstpsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_node_len(s : ChemmolpropstpsaNode) -> Int { s.size }

pub fn chem_mol_props_tpsa_node_get(s : ChemmolpropstpsaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_node_set(s : ChemmolpropstpsaNode, i : Int, v : Double) -> ChemmolpropstpsaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_node_sum(s : ChemmolpropstpsaNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_node_mean(s : ChemmolpropstpsaNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_node_scale(s : ChemmolpropstpsaNode, f : Double) -> ChemmolpropstpsaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_node_add(a : ChemmolpropstpsaNode, b : ChemmolpropstpsaNode) -> ChemmolpropstpsaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_node_copy(s : ChemmolpropstpsaNode) -> ChemmolpropstpsaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_node_fill(s : ChemmolpropstpsaNode, v : Double) -> ChemmolpropstpsaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_node_min(s : ChemmolpropstpsaNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_node_max(s : ChemmolpropstpsaNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_node_to_string(s : ChemmolpropstpsaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_edge_make(size : Int) -> ChemmolpropstpsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_edge_len(s : ChemmolpropstpsaEdge) -> Int { s.size }

pub fn chem_mol_props_tpsa_edge_get(s : ChemmolpropstpsaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_edge_set(s : ChemmolpropstpsaEdge, i : Int, v : Double) -> ChemmolpropstpsaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_edge_sum(s : ChemmolpropstpsaEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_edge_mean(s : ChemmolpropstpsaEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_edge_scale(s : ChemmolpropstpsaEdge, f : Double) -> ChemmolpropstpsaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_edge_add(a : ChemmolpropstpsaEdge, b : ChemmolpropstpsaEdge) -> ChemmolpropstpsaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_edge_copy(s : ChemmolpropstpsaEdge) -> ChemmolpropstpsaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_edge_fill(s : ChemmolpropstpsaEdge, v : Double) -> ChemmolpropstpsaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_edge_min(s : ChemmolpropstpsaEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_edge_max(s : ChemmolpropstpsaEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_edge_to_string(s : ChemmolpropstpsaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_path_make(size : Int) -> ChemmolpropstpsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_path_len(s : ChemmolpropstpsaPath) -> Int { s.size }

pub fn chem_mol_props_tpsa_path_get(s : ChemmolpropstpsaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_path_set(s : ChemmolpropstpsaPath, i : Int, v : Double) -> ChemmolpropstpsaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_path_sum(s : ChemmolpropstpsaPath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_path_mean(s : ChemmolpropstpsaPath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_path_scale(s : ChemmolpropstpsaPath, f : Double) -> ChemmolpropstpsaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_path_add(a : ChemmolpropstpsaPath, b : ChemmolpropstpsaPath) -> ChemmolpropstpsaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_path_copy(s : ChemmolpropstpsaPath) -> ChemmolpropstpsaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_path_fill(s : ChemmolpropstpsaPath, v : Double) -> ChemmolpropstpsaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_path_min(s : ChemmolpropstpsaPath) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_path_max(s : ChemmolpropstpsaPath) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_path_to_string(s : ChemmolpropstpsaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_cluster_make(size : Int) -> ChemmolpropstpsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_cluster_len(s : ChemmolpropstpsaCluster) -> Int { s.size }

pub fn chem_mol_props_tpsa_cluster_get(s : ChemmolpropstpsaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_cluster_set(s : ChemmolpropstpsaCluster, i : Int, v : Double) -> ChemmolpropstpsaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_cluster_sum(s : ChemmolpropstpsaCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_cluster_mean(s : ChemmolpropstpsaCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_cluster_scale(s : ChemmolpropstpsaCluster, f : Double) -> ChemmolpropstpsaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_cluster_add(a : ChemmolpropstpsaCluster, b : ChemmolpropstpsaCluster) -> ChemmolpropstpsaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_cluster_copy(s : ChemmolpropstpsaCluster) -> ChemmolpropstpsaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_cluster_fill(s : ChemmolpropstpsaCluster, v : Double) -> ChemmolpropstpsaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_cluster_min(s : ChemmolpropstpsaCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_cluster_max(s : ChemmolpropstpsaCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_cluster_to_string(s : ChemmolpropstpsaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_model_make(size : Int) -> ChemmolpropstpsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_model_len(s : ChemmolpropstpsaModel) -> Int { s.size }

pub fn chem_mol_props_tpsa_model_get(s : ChemmolpropstpsaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_model_set(s : ChemmolpropstpsaModel, i : Int, v : Double) -> ChemmolpropstpsaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_model_sum(s : ChemmolpropstpsaModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_model_mean(s : ChemmolpropstpsaModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_model_scale(s : ChemmolpropstpsaModel, f : Double) -> ChemmolpropstpsaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_model_add(a : ChemmolpropstpsaModel, b : ChemmolpropstpsaModel) -> ChemmolpropstpsaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_model_copy(s : ChemmolpropstpsaModel) -> ChemmolpropstpsaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_model_fill(s : ChemmolpropstpsaModel, v : Double) -> ChemmolpropstpsaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_model_min(s : ChemmolpropstpsaModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_model_max(s : ChemmolpropstpsaModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_model_to_string(s : ChemmolpropstpsaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_layer_make(size : Int) -> ChemmolpropstpsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_layer_len(s : ChemmolpropstpsaLayer) -> Int { s.size }

pub fn chem_mol_props_tpsa_layer_get(s : ChemmolpropstpsaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_layer_set(s : ChemmolpropstpsaLayer, i : Int, v : Double) -> ChemmolpropstpsaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_layer_sum(s : ChemmolpropstpsaLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_layer_mean(s : ChemmolpropstpsaLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_layer_scale(s : ChemmolpropstpsaLayer, f : Double) -> ChemmolpropstpsaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_layer_add(a : ChemmolpropstpsaLayer, b : ChemmolpropstpsaLayer) -> ChemmolpropstpsaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_layer_copy(s : ChemmolpropstpsaLayer) -> ChemmolpropstpsaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_layer_fill(s : ChemmolpropstpsaLayer, v : Double) -> ChemmolpropstpsaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_layer_min(s : ChemmolpropstpsaLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_layer_max(s : ChemmolpropstpsaLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_layer_to_string(s : ChemmolpropstpsaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_buffer_make(size : Int) -> ChemmolpropstpsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_buffer_len(s : ChemmolpropstpsaBuffer) -> Int { s.size }

pub fn chem_mol_props_tpsa_buffer_get(s : ChemmolpropstpsaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_buffer_set(s : ChemmolpropstpsaBuffer, i : Int, v : Double) -> ChemmolpropstpsaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_buffer_sum(s : ChemmolpropstpsaBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_buffer_mean(s : ChemmolpropstpsaBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_buffer_scale(s : ChemmolpropstpsaBuffer, f : Double) -> ChemmolpropstpsaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_buffer_add(a : ChemmolpropstpsaBuffer, b : ChemmolpropstpsaBuffer) -> ChemmolpropstpsaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_buffer_copy(s : ChemmolpropstpsaBuffer) -> ChemmolpropstpsaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_buffer_fill(s : ChemmolpropstpsaBuffer, v : Double) -> ChemmolpropstpsaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_buffer_min(s : ChemmolpropstpsaBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_buffer_max(s : ChemmolpropstpsaBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_buffer_to_string(s : ChemmolpropstpsaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_cursor_make(size : Int) -> ChemmolpropstpsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_cursor_len(s : ChemmolpropstpsaCursor) -> Int { s.size }

pub fn chem_mol_props_tpsa_cursor_get(s : ChemmolpropstpsaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_cursor_set(s : ChemmolpropstpsaCursor, i : Int, v : Double) -> ChemmolpropstpsaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_cursor_sum(s : ChemmolpropstpsaCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_cursor_mean(s : ChemmolpropstpsaCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_cursor_scale(s : ChemmolpropstpsaCursor, f : Double) -> ChemmolpropstpsaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_cursor_add(a : ChemmolpropstpsaCursor, b : ChemmolpropstpsaCursor) -> ChemmolpropstpsaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_cursor_copy(s : ChemmolpropstpsaCursor) -> ChemmolpropstpsaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_cursor_fill(s : ChemmolpropstpsaCursor, v : Double) -> ChemmolpropstpsaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_cursor_min(s : ChemmolpropstpsaCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_cursor_max(s : ChemmolpropstpsaCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_cursor_to_string(s : ChemmolpropstpsaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_view_make(size : Int) -> ChemmolpropstpsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_view_len(s : ChemmolpropstpsaView) -> Int { s.size }

pub fn chem_mol_props_tpsa_view_get(s : ChemmolpropstpsaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_view_set(s : ChemmolpropstpsaView, i : Int, v : Double) -> ChemmolpropstpsaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_view_sum(s : ChemmolpropstpsaView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_view_mean(s : ChemmolpropstpsaView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_view_scale(s : ChemmolpropstpsaView, f : Double) -> ChemmolpropstpsaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_view_add(a : ChemmolpropstpsaView, b : ChemmolpropstpsaView) -> ChemmolpropstpsaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_view_copy(s : ChemmolpropstpsaView) -> ChemmolpropstpsaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_view_fill(s : ChemmolpropstpsaView, v : Double) -> ChemmolpropstpsaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_view_min(s : ChemmolpropstpsaView) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_view_max(s : ChemmolpropstpsaView) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_view_to_string(s : ChemmolpropstpsaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_range_make(size : Int) -> ChemmolpropstpsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_range_len(s : ChemmolpropstpsaRange) -> Int { s.size }

pub fn chem_mol_props_tpsa_range_get(s : ChemmolpropstpsaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_range_set(s : ChemmolpropstpsaRange, i : Int, v : Double) -> ChemmolpropstpsaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_range_sum(s : ChemmolpropstpsaRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_range_mean(s : ChemmolpropstpsaRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_range_scale(s : ChemmolpropstpsaRange, f : Double) -> ChemmolpropstpsaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_range_add(a : ChemmolpropstpsaRange, b : ChemmolpropstpsaRange) -> ChemmolpropstpsaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_range_copy(s : ChemmolpropstpsaRange) -> ChemmolpropstpsaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_range_fill(s : ChemmolpropstpsaRange, v : Double) -> ChemmolpropstpsaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_range_min(s : ChemmolpropstpsaRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_range_max(s : ChemmolpropstpsaRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_range_to_string(s : ChemmolpropstpsaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_slice_make(size : Int) -> ChemmolpropstpsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_slice_len(s : ChemmolpropstpsaSlice) -> Int { s.size }

pub fn chem_mol_props_tpsa_slice_get(s : ChemmolpropstpsaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_slice_set(s : ChemmolpropstpsaSlice, i : Int, v : Double) -> ChemmolpropstpsaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_slice_sum(s : ChemmolpropstpsaSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_slice_mean(s : ChemmolpropstpsaSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_slice_scale(s : ChemmolpropstpsaSlice, f : Double) -> ChemmolpropstpsaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_slice_add(a : ChemmolpropstpsaSlice, b : ChemmolpropstpsaSlice) -> ChemmolpropstpsaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_slice_copy(s : ChemmolpropstpsaSlice) -> ChemmolpropstpsaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_slice_fill(s : ChemmolpropstpsaSlice, v : Double) -> ChemmolpropstpsaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_slice_min(s : ChemmolpropstpsaSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_slice_max(s : ChemmolpropstpsaSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_slice_to_string(s : ChemmolpropstpsaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

