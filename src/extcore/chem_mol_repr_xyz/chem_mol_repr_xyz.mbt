///===
/// extcore/chem_mol_repr_xyz

pub(all) struct ChemmolreprxyzPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_repr_xyz_make_point(x : Double, y : Double) -> ChemmolreprxyzPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_repr_xyz_make_point3(x : Double, y : Double, z : Double) -> ChemmolreprxyzPoint {
  { x, y, z, label: 0 }
}

pub fn chem_mol_repr_xyz_point_x(pt : ChemmolreprxyzPoint) -> Double { pt.x }

pub fn chem_mol_repr_xyz_point_y(pt : ChemmolreprxyzPoint) -> Double { pt.y }

pub fn chem_mol_repr_xyz_point_z(pt : ChemmolreprxyzPoint) -> Double { pt.z }

pub fn chem_mol_repr_xyz_point_label(pt : ChemmolreprxyzPoint) -> Int { pt.label }

pub fn chem_mol_repr_xyz_point_dist(a : ChemmolreprxyzPoint, b : ChemmolreprxyzPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_mol_repr_xyz_point_add(a : ChemmolreprxyzPoint, b : ChemmolreprxyzPoint) -> ChemmolreprxyzPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_mol_repr_xyz_point_sub(a : ChemmolreprxyzPoint, b : ChemmolreprxyzPoint) -> ChemmolreprxyzPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_mol_repr_xyz_point_scale(pt : ChemmolreprxyzPoint, s : Double) -> ChemmolreprxyzPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_mol_repr_xyz_point_dot(a : ChemmolreprxyzPoint, b : ChemmolreprxyzPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_mol_repr_xyz_point_cross(a : ChemmolreprxyzPoint, b : ChemmolreprxyzPoint) -> ChemmolreprxyzPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_mol_repr_xyz_point_norm(pt : ChemmolreprxyzPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_mol_repr_xyz_point_normalize(pt : ChemmolreprxyzPoint) -> ChemmolreprxyzPoint {
  let n = chem_mol_repr_xyz_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_mol_repr_xyz_point_scale(pt, 1.0 / n) }
}

pub fn chem_mol_repr_xyz_point_negate(pt : ChemmolreprxyzPoint) -> ChemmolreprxyzPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_mol_repr_xyz_point_mid(a : ChemmolreprxyzPoint, b : ChemmolreprxyzPoint) -> ChemmolreprxyzPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_mol_repr_xyz_point_lerp(a : ChemmolreprxyzPoint, b : ChemmolreprxyzPoint, t : Double) -> ChemmolreprxyzPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_mol_repr_xyz_point_to_string(pt : ChemmolreprxyzPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemmolreprxyzSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_repr_xyz_make_series(vals : Array[Double], name : String) -> ChemmolreprxyzSeries {
  { vals, name, meta: 0 }
}

pub fn chem_mol_repr_xyz_series_len(s : ChemmolreprxyzSeries) -> Int { s.vals.length() }

pub fn chem_mol_repr_xyz_series_sum(s : ChemmolreprxyzSeries) -> Double { @_common.sum(s.vals) }

pub fn chem_mol_repr_xyz_series_mean(s : ChemmolreprxyzSeries) -> Double { @_common.mean(s.vals) }

pub fn chem_mol_repr_xyz_series_min(s : ChemmolreprxyzSeries) -> Double { @_common.min(s.vals) }

pub fn chem_mol_repr_xyz_series_max(s : ChemmolreprxyzSeries) -> Double { @_common.max(s.vals) }

pub fn chem_mol_repr_xyz_series_range(s : ChemmolreprxyzSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn chem_mol_repr_xyz_series_var(s : ChemmolreprxyzSeries) -> Double { @_common.variance(s.vals) }

pub fn chem_mol_repr_xyz_series_std(s : ChemmolreprxyzSeries) -> Double { @_common.std(s.vals) }

pub fn chem_mol_repr_xyz_series_median(s : ChemmolreprxyzSeries) -> Double { @_common.median(s.vals) }

pub fn chem_mol_repr_xyz_series_scale(s : ChemmolreprxyzSeries, f : Double) -> ChemmolreprxyzSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_mol_repr_xyz_series_add(a : ChemmolreprxyzSeries, b : ChemmolreprxyzSeries) -> ChemmolreprxyzSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_mol_repr_xyz_series_sub(a : ChemmolreprxyzSeries, b : ChemmolreprxyzSeries) -> ChemmolreprxyzSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_mol_repr_xyz_series_normalize(s : ChemmolreprxyzSeries) -> ChemmolreprxyzSeries {
  let mn = chem_mol_repr_xyz_series_min(s)
  let mx = chem_mol_repr_xyz_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_mol_repr_xyz_series_cumsum(s : ChemmolreprxyzSeries) -> ChemmolreprxyzSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_mol_repr_xyz_series_to_string(s : ChemmolreprxyzSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprxyzMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_repr_xyz_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolreprxyzMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_repr_xyz_matrix_identity(n : Int) -> ChemmolreprxyzMatrix {
  let m = chem_mol_repr_xyz_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_mol_repr_xyz_matrix_get(m : ChemmolreprxyzMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_mol_repr_xyz_matrix_transpose(m : ChemmolreprxyzMatrix) -> ChemmolreprxyzMatrix {
  let result = chem_mol_repr_xyz_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_mol_repr_xyz_matrix_add(a : ChemmolreprxyzMatrix, b : ChemmolreprxyzMatrix) -> ChemmolreprxyzMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_mol_repr_xyz_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_mol_repr_xyz_matrix_scale(m : ChemmolreprxyzMatrix, s : Double) -> ChemmolreprxyzMatrix {
  let result = chem_mol_repr_xyz_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_mol_repr_xyz_matrix_multiply(a : ChemmolreprxyzMatrix, b : ChemmolreprxyzMatrix) -> ChemmolreprxyzMatrix {
  if a.cols != b.rows { return chem_mol_repr_xyz_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_mol_repr_xyz_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_mol_repr_xyz_matrix_trace(m : ChemmolreprxyzMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_mol_repr_xyz_matrix_det(m : ChemmolreprxyzMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_mol_repr_xyz_matrix_norm(m : ChemmolreprxyzMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_mol_repr_xyz_matrix_to_string(m : ChemmolreprxyzMatrix) -> String {
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

pub(all) struct ChemmolreprxyzVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_repr_xyz_make_vector(comps : Array[Double]) -> ChemmolreprxyzVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_repr_xyz_vector_zero(dim : Int) -> ChemmolreprxyzVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_mol_repr_xyz_vector_add(a : ChemmolreprxyzVector, b : ChemmolreprxyzVector) -> ChemmolreprxyzVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_repr_xyz_vector_sub(a : ChemmolreprxyzVector, b : ChemmolreprxyzVector) -> ChemmolreprxyzVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_repr_xyz_vector_scale(v : ChemmolreprxyzVector, s : Double) -> ChemmolreprxyzVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_mol_repr_xyz_vector_dot(a : ChemmolreprxyzVector, b : ChemmolreprxyzVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_mol_repr_xyz_vector_norm(v : ChemmolreprxyzVector) -> Double { @_common.sqrt(chem_mol_repr_xyz_vector_dot(v, v)) }

pub fn chem_mol_repr_xyz_vector_normalize(v : ChemmolreprxyzVector) -> ChemmolreprxyzVector {
  let n = chem_mol_repr_xyz_vector_norm(v)
  if n < 0.0000001 { v } else { chem_mol_repr_xyz_vector_scale(v, 1.0 / n) }
}

pub fn chem_mol_repr_xyz_vector_dist(a : ChemmolreprxyzVector, b : ChemmolreprxyzVector) -> Double {
  chem_mol_repr_xyz_vector_norm(chem_mol_repr_xyz_vector_sub(a, b))
}

pub fn chem_mol_repr_xyz_vector_to_string(v : ChemmolreprxyzVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_repr_xyz_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_repr_xyz_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_repr_xyz_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_repr_xyz_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_repr_xyz_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_repr_xyz_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_repr_xyz_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_repr_xyz_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_repr_xyz_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_repr_xyz_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_repr_xyz_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_repr_xyz_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_repr_xyz_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_repr_xyz_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_repr_xyz_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_repr_xyz_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_repr_xyz_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_repr_xyz_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_repr_xyz_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_repr_xyz_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_repr_xyz_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_repr_xyz_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_repr_xyz_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_repr_xyz_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_repr_xyz_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_repr_xyz_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_repr_xyz_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_repr_xyz_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_repr_xyz_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolreprxyzFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_frame_make(size : Int) -> ChemmolreprxyzFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_frame_len(s : ChemmolreprxyzFrame) -> Int { s.size }

pub fn chem_mol_repr_xyz_frame_get(s : ChemmolreprxyzFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_frame_set(s : ChemmolreprxyzFrame, i : Int, v : Double) -> ChemmolreprxyzFrame {
  let result = chem_mol_repr_xyz_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_xyz_frame_sum(s : ChemmolreprxyzFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_frame_mean(s : ChemmolreprxyzFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_frame_scale(s : ChemmolreprxyzFrame, f : Double) -> ChemmolreprxyzFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_frame_add(a : ChemmolreprxyzFrame, b : ChemmolreprxyzFrame) -> ChemmolreprxyzFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_frame_copy(s : ChemmolreprxyzFrame) -> ChemmolreprxyzFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_frame_fill(s : ChemmolreprxyzFrame, v : Double) -> ChemmolreprxyzFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_frame_min(s : ChemmolreprxyzFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_frame_max(s : ChemmolreprxyzFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_frame_to_string(s : ChemmolreprxyzFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_table_make(size : Int) -> ChemmolreprxyzTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_table_len(s : ChemmolreprxyzTable) -> Int { s.size }

pub fn chem_mol_repr_xyz_table_get(s : ChemmolreprxyzTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_table_set(s : ChemmolreprxyzTable, i : Int, v : Double) -> ChemmolreprxyzTable {
  let result = chem_mol_repr_xyz_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_xyz_table_sum(s : ChemmolreprxyzTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_table_mean(s : ChemmolreprxyzTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_table_scale(s : ChemmolreprxyzTable, f : Double) -> ChemmolreprxyzTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_table_add(a : ChemmolreprxyzTable, b : ChemmolreprxyzTable) -> ChemmolreprxyzTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_table_copy(s : ChemmolreprxyzTable) -> ChemmolreprxyzTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_table_fill(s : ChemmolreprxyzTable, v : Double) -> ChemmolreprxyzTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_table_min(s : ChemmolreprxyzTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_table_max(s : ChemmolreprxyzTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_table_to_string(s : ChemmolreprxyzTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_graphn_make(size : Int) -> ChemmolreprxyzGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_graphn_len(s : ChemmolreprxyzGraphN) -> Int { s.size }

pub fn chem_mol_repr_xyz_graphn_get(s : ChemmolreprxyzGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_graphn_set(s : ChemmolreprxyzGraphN, i : Int, v : Double) -> ChemmolreprxyzGraphN {
  let result = chem_mol_repr_xyz_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_xyz_graphn_sum(s : ChemmolreprxyzGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_graphn_mean(s : ChemmolreprxyzGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_graphn_scale(s : ChemmolreprxyzGraphN, f : Double) -> ChemmolreprxyzGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_graphn_add(a : ChemmolreprxyzGraphN, b : ChemmolreprxyzGraphN) -> ChemmolreprxyzGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_graphn_copy(s : ChemmolreprxyzGraphN) -> ChemmolreprxyzGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_graphn_fill(s : ChemmolreprxyzGraphN, v : Double) -> ChemmolreprxyzGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_graphn_min(s : ChemmolreprxyzGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_graphn_max(s : ChemmolreprxyzGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_graphn_to_string(s : ChemmolreprxyzGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_node_make(size : Int) -> ChemmolreprxyzNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_node_len(s : ChemmolreprxyzNode) -> Int { s.size }

pub fn chem_mol_repr_xyz_node_get(s : ChemmolreprxyzNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_node_set(s : ChemmolreprxyzNode, i : Int, v : Double) -> ChemmolreprxyzNode {
  let result = chem_mol_repr_xyz_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_xyz_node_sum(s : ChemmolreprxyzNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_node_mean(s : ChemmolreprxyzNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_node_scale(s : ChemmolreprxyzNode, f : Double) -> ChemmolreprxyzNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_node_add(a : ChemmolreprxyzNode, b : ChemmolreprxyzNode) -> ChemmolreprxyzNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_node_copy(s : ChemmolreprxyzNode) -> ChemmolreprxyzNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_node_fill(s : ChemmolreprxyzNode, v : Double) -> ChemmolreprxyzNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_node_min(s : ChemmolreprxyzNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_node_max(s : ChemmolreprxyzNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_node_to_string(s : ChemmolreprxyzNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_edge_make(size : Int) -> ChemmolreprxyzEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_edge_len(s : ChemmolreprxyzEdge) -> Int { s.size }

pub fn chem_mol_repr_xyz_edge_get(s : ChemmolreprxyzEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_edge_set(s : ChemmolreprxyzEdge, i : Int, v : Double) -> ChemmolreprxyzEdge {
  let result = chem_mol_repr_xyz_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_xyz_edge_sum(s : ChemmolreprxyzEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_edge_mean(s : ChemmolreprxyzEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_edge_scale(s : ChemmolreprxyzEdge, f : Double) -> ChemmolreprxyzEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_edge_add(a : ChemmolreprxyzEdge, b : ChemmolreprxyzEdge) -> ChemmolreprxyzEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_edge_copy(s : ChemmolreprxyzEdge) -> ChemmolreprxyzEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_edge_fill(s : ChemmolreprxyzEdge, v : Double) -> ChemmolreprxyzEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_edge_min(s : ChemmolreprxyzEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_edge_max(s : ChemmolreprxyzEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_edge_to_string(s : ChemmolreprxyzEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_path_make(size : Int) -> ChemmolreprxyzPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_path_len(s : ChemmolreprxyzPath) -> Int { s.size }

pub fn chem_mol_repr_xyz_path_get(s : ChemmolreprxyzPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_path_set(s : ChemmolreprxyzPath, i : Int, v : Double) -> ChemmolreprxyzPath {
  let result = chem_mol_repr_xyz_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_xyz_path_sum(s : ChemmolreprxyzPath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_path_mean(s : ChemmolreprxyzPath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_path_scale(s : ChemmolreprxyzPath, f : Double) -> ChemmolreprxyzPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_path_add(a : ChemmolreprxyzPath, b : ChemmolreprxyzPath) -> ChemmolreprxyzPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_path_copy(s : ChemmolreprxyzPath) -> ChemmolreprxyzPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_path_fill(s : ChemmolreprxyzPath, v : Double) -> ChemmolreprxyzPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_path_min(s : ChemmolreprxyzPath) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_path_max(s : ChemmolreprxyzPath) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_path_to_string(s : ChemmolreprxyzPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_cluster_make(size : Int) -> ChemmolreprxyzCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_cluster_len(s : ChemmolreprxyzCluster) -> Int { s.size }

pub fn chem_mol_repr_xyz_cluster_get(s : ChemmolreprxyzCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_cluster_set(s : ChemmolreprxyzCluster, i : Int, v : Double) -> ChemmolreprxyzCluster {
  let result = chem_mol_repr_xyz_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_xyz_cluster_sum(s : ChemmolreprxyzCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_cluster_mean(s : ChemmolreprxyzCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_cluster_scale(s : ChemmolreprxyzCluster, f : Double) -> ChemmolreprxyzCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_cluster_add(a : ChemmolreprxyzCluster, b : ChemmolreprxyzCluster) -> ChemmolreprxyzCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_cluster_copy(s : ChemmolreprxyzCluster) -> ChemmolreprxyzCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_cluster_fill(s : ChemmolreprxyzCluster, v : Double) -> ChemmolreprxyzCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_cluster_min(s : ChemmolreprxyzCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_cluster_max(s : ChemmolreprxyzCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_cluster_to_string(s : ChemmolreprxyzCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_model_make(size : Int) -> ChemmolreprxyzModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_model_len(s : ChemmolreprxyzModel) -> Int { s.size }

pub fn chem_mol_repr_xyz_model_get(s : ChemmolreprxyzModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_model_set(s : ChemmolreprxyzModel, i : Int, v : Double) -> ChemmolreprxyzModel {
  let result = chem_mol_repr_xyz_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_xyz_model_sum(s : ChemmolreprxyzModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_model_mean(s : ChemmolreprxyzModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_model_scale(s : ChemmolreprxyzModel, f : Double) -> ChemmolreprxyzModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_model_add(a : ChemmolreprxyzModel, b : ChemmolreprxyzModel) -> ChemmolreprxyzModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_model_copy(s : ChemmolreprxyzModel) -> ChemmolreprxyzModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_model_fill(s : ChemmolreprxyzModel, v : Double) -> ChemmolreprxyzModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_model_min(s : ChemmolreprxyzModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_model_max(s : ChemmolreprxyzModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_model_to_string(s : ChemmolreprxyzModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_layer_make(size : Int) -> ChemmolreprxyzLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_layer_len(s : ChemmolreprxyzLayer) -> Int { s.size }

pub fn chem_mol_repr_xyz_layer_get(s : ChemmolreprxyzLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_layer_set(s : ChemmolreprxyzLayer, i : Int, v : Double) -> ChemmolreprxyzLayer {
  let result = chem_mol_repr_xyz_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_xyz_layer_sum(s : ChemmolreprxyzLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_layer_mean(s : ChemmolreprxyzLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_layer_scale(s : ChemmolreprxyzLayer, f : Double) -> ChemmolreprxyzLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_layer_add(a : ChemmolreprxyzLayer, b : ChemmolreprxyzLayer) -> ChemmolreprxyzLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_layer_copy(s : ChemmolreprxyzLayer) -> ChemmolreprxyzLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_layer_fill(s : ChemmolreprxyzLayer, v : Double) -> ChemmolreprxyzLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_layer_min(s : ChemmolreprxyzLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_layer_max(s : ChemmolreprxyzLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_layer_to_string(s : ChemmolreprxyzLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_buffer_make(size : Int) -> ChemmolreprxyzBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_buffer_len(s : ChemmolreprxyzBuffer) -> Int { s.size }

pub fn chem_mol_repr_xyz_buffer_get(s : ChemmolreprxyzBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_buffer_set(s : ChemmolreprxyzBuffer, i : Int, v : Double) -> ChemmolreprxyzBuffer {
  let result = chem_mol_repr_xyz_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_xyz_buffer_sum(s : ChemmolreprxyzBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_buffer_mean(s : ChemmolreprxyzBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_buffer_scale(s : ChemmolreprxyzBuffer, f : Double) -> ChemmolreprxyzBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_buffer_add(a : ChemmolreprxyzBuffer, b : ChemmolreprxyzBuffer) -> ChemmolreprxyzBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_buffer_copy(s : ChemmolreprxyzBuffer) -> ChemmolreprxyzBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_buffer_fill(s : ChemmolreprxyzBuffer, v : Double) -> ChemmolreprxyzBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_buffer_min(s : ChemmolreprxyzBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_buffer_max(s : ChemmolreprxyzBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_buffer_to_string(s : ChemmolreprxyzBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_cursor_make(size : Int) -> ChemmolreprxyzCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_cursor_len(s : ChemmolreprxyzCursor) -> Int { s.size }

pub fn chem_mol_repr_xyz_cursor_get(s : ChemmolreprxyzCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_cursor_set(s : ChemmolreprxyzCursor, i : Int, v : Double) -> ChemmolreprxyzCursor {
  let result = chem_mol_repr_xyz_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_xyz_cursor_sum(s : ChemmolreprxyzCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_cursor_mean(s : ChemmolreprxyzCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_cursor_scale(s : ChemmolreprxyzCursor, f : Double) -> ChemmolreprxyzCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_cursor_add(a : ChemmolreprxyzCursor, b : ChemmolreprxyzCursor) -> ChemmolreprxyzCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_cursor_copy(s : ChemmolreprxyzCursor) -> ChemmolreprxyzCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_cursor_fill(s : ChemmolreprxyzCursor, v : Double) -> ChemmolreprxyzCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_cursor_min(s : ChemmolreprxyzCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_cursor_max(s : ChemmolreprxyzCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_cursor_to_string(s : ChemmolreprxyzCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_view_make(size : Int) -> ChemmolreprxyzView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_view_len(s : ChemmolreprxyzView) -> Int { s.size }

pub fn chem_mol_repr_xyz_view_get(s : ChemmolreprxyzView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_view_set(s : ChemmolreprxyzView, i : Int, v : Double) -> ChemmolreprxyzView {
  let result = chem_mol_repr_xyz_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_xyz_view_sum(s : ChemmolreprxyzView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_view_mean(s : ChemmolreprxyzView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_view_scale(s : ChemmolreprxyzView, f : Double) -> ChemmolreprxyzView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_view_add(a : ChemmolreprxyzView, b : ChemmolreprxyzView) -> ChemmolreprxyzView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_view_copy(s : ChemmolreprxyzView) -> ChemmolreprxyzView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_view_fill(s : ChemmolreprxyzView, v : Double) -> ChemmolreprxyzView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_view_min(s : ChemmolreprxyzView) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_view_max(s : ChemmolreprxyzView) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_view_to_string(s : ChemmolreprxyzView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_range_make(size : Int) -> ChemmolreprxyzRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_range_len(s : ChemmolreprxyzRange) -> Int { s.size }

pub fn chem_mol_repr_xyz_range_get(s : ChemmolreprxyzRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_range_set(s : ChemmolreprxyzRange, i : Int, v : Double) -> ChemmolreprxyzRange {
  let result = chem_mol_repr_xyz_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_xyz_range_sum(s : ChemmolreprxyzRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_range_mean(s : ChemmolreprxyzRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_range_scale(s : ChemmolreprxyzRange, f : Double) -> ChemmolreprxyzRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_range_add(a : ChemmolreprxyzRange, b : ChemmolreprxyzRange) -> ChemmolreprxyzRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_range_copy(s : ChemmolreprxyzRange) -> ChemmolreprxyzRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_range_fill(s : ChemmolreprxyzRange, v : Double) -> ChemmolreprxyzRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_range_min(s : ChemmolreprxyzRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_range_max(s : ChemmolreprxyzRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_range_to_string(s : ChemmolreprxyzRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_slice_make(size : Int) -> ChemmolreprxyzSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_slice_len(s : ChemmolreprxyzSlice) -> Int { s.size }

pub fn chem_mol_repr_xyz_slice_get(s : ChemmolreprxyzSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_slice_set(s : ChemmolreprxyzSlice, i : Int, v : Double) -> ChemmolreprxyzSlice {
  let result = chem_mol_repr_xyz_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_xyz_slice_sum(s : ChemmolreprxyzSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_slice_mean(s : ChemmolreprxyzSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_slice_scale(s : ChemmolreprxyzSlice, f : Double) -> ChemmolreprxyzSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_slice_add(a : ChemmolreprxyzSlice, b : ChemmolreprxyzSlice) -> ChemmolreprxyzSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_slice_copy(s : ChemmolreprxyzSlice) -> ChemmolreprxyzSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_slice_fill(s : ChemmolreprxyzSlice, v : Double) -> ChemmolreprxyzSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_slice_min(s : ChemmolreprxyzSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_slice_max(s : ChemmolreprxyzSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_slice_to_string(s : ChemmolreprxyzSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

