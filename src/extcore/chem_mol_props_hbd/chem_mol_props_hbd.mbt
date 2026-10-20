///===
/// extcore/chem_mol_props_hbd

pub(all) struct ChemmolpropshbdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_hbd_make_point(x : Double, y : Double) -> ChemmolpropshbdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_hbd_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropshbdPoint {
  { x, y, z, label: 0 }
}

pub fn chem_mol_props_hbd_point_x(pt : ChemmolpropshbdPoint) -> Double { pt.x }

pub fn chem_mol_props_hbd_point_y(pt : ChemmolpropshbdPoint) -> Double { pt.y }

pub fn chem_mol_props_hbd_point_z(pt : ChemmolpropshbdPoint) -> Double { pt.z }

pub fn chem_mol_props_hbd_point_label(pt : ChemmolpropshbdPoint) -> Int { pt.label }

pub fn chem_mol_props_hbd_point_dist(a : ChemmolpropshbdPoint, b : ChemmolpropshbdPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_mol_props_hbd_point_add(a : ChemmolpropshbdPoint, b : ChemmolpropshbdPoint) -> ChemmolpropshbdPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_mol_props_hbd_point_sub(a : ChemmolpropshbdPoint, b : ChemmolpropshbdPoint) -> ChemmolpropshbdPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_mol_props_hbd_point_scale(pt : ChemmolpropshbdPoint, s : Double) -> ChemmolpropshbdPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_mol_props_hbd_point_dot(a : ChemmolpropshbdPoint, b : ChemmolpropshbdPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_mol_props_hbd_point_cross(a : ChemmolpropshbdPoint, b : ChemmolpropshbdPoint) -> ChemmolpropshbdPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_mol_props_hbd_point_norm(pt : ChemmolpropshbdPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_mol_props_hbd_point_normalize(pt : ChemmolpropshbdPoint) -> ChemmolpropshbdPoint {
  let n = chem_mol_props_hbd_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_mol_props_hbd_point_scale(pt, 1.0 / n) }
}

pub fn chem_mol_props_hbd_point_negate(pt : ChemmolpropshbdPoint) -> ChemmolpropshbdPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_mol_props_hbd_point_mid(a : ChemmolpropshbdPoint, b : ChemmolpropshbdPoint) -> ChemmolpropshbdPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_mol_props_hbd_point_lerp(a : ChemmolpropshbdPoint, b : ChemmolpropshbdPoint, t : Double) -> ChemmolpropshbdPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_mol_props_hbd_point_to_string(pt : ChemmolpropshbdPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemmolpropshbdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_hbd_make_series(vals : Array[Double], name : String) -> ChemmolpropshbdSeries {
  { vals, name, meta: 0 }
}

pub fn chem_mol_props_hbd_series_len(s : ChemmolpropshbdSeries) -> Int { s.vals.length() }

pub fn chem_mol_props_hbd_series_sum(s : ChemmolpropshbdSeries) -> Double { @_common.sum(s.vals) }

pub fn chem_mol_props_hbd_series_mean(s : ChemmolpropshbdSeries) -> Double { @_common.mean(s.vals) }

pub fn chem_mol_props_hbd_series_min(s : ChemmolpropshbdSeries) -> Double { @_common.min(s.vals) }

pub fn chem_mol_props_hbd_series_max(s : ChemmolpropshbdSeries) -> Double { @_common.max(s.vals) }

pub fn chem_mol_props_hbd_series_range(s : ChemmolpropshbdSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn chem_mol_props_hbd_series_var(s : ChemmolpropshbdSeries) -> Double { @_common.variance(s.vals) }

pub fn chem_mol_props_hbd_series_std(s : ChemmolpropshbdSeries) -> Double { @_common.std(s.vals) }

pub fn chem_mol_props_hbd_series_median(s : ChemmolpropshbdSeries) -> Double { @_common.median(s.vals) }

pub fn chem_mol_props_hbd_series_scale(s : ChemmolpropshbdSeries, f : Double) -> ChemmolpropshbdSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_mol_props_hbd_series_add(a : ChemmolpropshbdSeries, b : ChemmolpropshbdSeries) -> ChemmolpropshbdSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_mol_props_hbd_series_sub(a : ChemmolpropshbdSeries, b : ChemmolpropshbdSeries) -> ChemmolpropshbdSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_mol_props_hbd_series_normalize(s : ChemmolpropshbdSeries) -> ChemmolpropshbdSeries {
  let mn = chem_mol_props_hbd_series_min(s)
  let mx = chem_mol_props_hbd_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_mol_props_hbd_series_cumsum(s : ChemmolpropshbdSeries) -> ChemmolpropshbdSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_mol_props_hbd_series_to_string(s : ChemmolpropshbdSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropshbdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_hbd_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropshbdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_hbd_matrix_identity(n : Int) -> ChemmolpropshbdMatrix {
  let m = chem_mol_props_hbd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_mol_props_hbd_matrix_get(m : ChemmolpropshbdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_mol_props_hbd_matrix_transpose(m : ChemmolpropshbdMatrix) -> ChemmolpropshbdMatrix {
  let result = chem_mol_props_hbd_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_mol_props_hbd_matrix_add(a : ChemmolpropshbdMatrix, b : ChemmolpropshbdMatrix) -> ChemmolpropshbdMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_mol_props_hbd_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_mol_props_hbd_matrix_scale(m : ChemmolpropshbdMatrix, s : Double) -> ChemmolpropshbdMatrix {
  let result = chem_mol_props_hbd_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_mol_props_hbd_matrix_multiply(a : ChemmolpropshbdMatrix, b : ChemmolpropshbdMatrix) -> ChemmolpropshbdMatrix {
  if a.cols != b.rows { return chem_mol_props_hbd_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_mol_props_hbd_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_mol_props_hbd_matrix_trace(m : ChemmolpropshbdMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_mol_props_hbd_matrix_det(m : ChemmolpropshbdMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_mol_props_hbd_matrix_norm(m : ChemmolpropshbdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_mol_props_hbd_matrix_to_string(m : ChemmolpropshbdMatrix) -> String {
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

pub(all) struct ChemmolpropshbdVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_hbd_make_vector(comps : Array[Double]) -> ChemmolpropshbdVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_hbd_vector_zero(dim : Int) -> ChemmolpropshbdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_mol_props_hbd_vector_add(a : ChemmolpropshbdVector, b : ChemmolpropshbdVector) -> ChemmolpropshbdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_props_hbd_vector_sub(a : ChemmolpropshbdVector, b : ChemmolpropshbdVector) -> ChemmolpropshbdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_props_hbd_vector_scale(v : ChemmolpropshbdVector, s : Double) -> ChemmolpropshbdVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_mol_props_hbd_vector_dot(a : ChemmolpropshbdVector, b : ChemmolpropshbdVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_mol_props_hbd_vector_norm(v : ChemmolpropshbdVector) -> Double { @_common.sqrt(chem_mol_props_hbd_vector_dot(v, v)) }

pub fn chem_mol_props_hbd_vector_normalize(v : ChemmolpropshbdVector) -> ChemmolpropshbdVector {
  let n = chem_mol_props_hbd_vector_norm(v)
  if n < 0.0000001 { v } else { chem_mol_props_hbd_vector_scale(v, 1.0 / n) }
}

pub fn chem_mol_props_hbd_vector_dist(a : ChemmolpropshbdVector, b : ChemmolpropshbdVector) -> Double {
  chem_mol_props_hbd_vector_norm(chem_mol_props_hbd_vector_sub(a, b))
}

pub fn chem_mol_props_hbd_vector_to_string(v : ChemmolpropshbdVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_props_hbd_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_props_hbd_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_props_hbd_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_props_hbd_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_props_hbd_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_props_hbd_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_props_hbd_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_props_hbd_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_props_hbd_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_props_hbd_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_props_hbd_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_props_hbd_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_props_hbd_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_props_hbd_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_props_hbd_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_props_hbd_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_props_hbd_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_props_hbd_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_props_hbd_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_props_hbd_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_props_hbd_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_props_hbd_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_props_hbd_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_props_hbd_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_props_hbd_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_props_hbd_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_props_hbd_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_props_hbd_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_props_hbd_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolpropshbdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_frame_make(size : Int) -> ChemmolpropshbdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_frame_len(s : ChemmolpropshbdFrame) -> Int { s.size }

pub fn chem_mol_props_hbd_frame_get(s : ChemmolpropshbdFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_frame_set(s : ChemmolpropshbdFrame, i : Int, v : Double) -> ChemmolpropshbdFrame {
  let result = chem_mol_props_hbd_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_frame_sum(s : ChemmolpropshbdFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hbd_frame_mean(s : ChemmolpropshbdFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hbd_frame_scale(s : ChemmolpropshbdFrame, f : Double) -> ChemmolpropshbdFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_frame_add(a : ChemmolpropshbdFrame, b : ChemmolpropshbdFrame) -> ChemmolpropshbdFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_hbd_frame_copy(s : ChemmolpropshbdFrame) -> ChemmolpropshbdFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_frame_fill(s : ChemmolpropshbdFrame, v : Double) -> ChemmolpropshbdFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_frame_min(s : ChemmolpropshbdFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hbd_frame_max(s : ChemmolpropshbdFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hbd_frame_to_string(s : ChemmolpropshbdFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_table_make(size : Int) -> ChemmolpropshbdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_table_len(s : ChemmolpropshbdTable) -> Int { s.size }

pub fn chem_mol_props_hbd_table_get(s : ChemmolpropshbdTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_table_set(s : ChemmolpropshbdTable, i : Int, v : Double) -> ChemmolpropshbdTable {
  let result = chem_mol_props_hbd_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_table_sum(s : ChemmolpropshbdTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hbd_table_mean(s : ChemmolpropshbdTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hbd_table_scale(s : ChemmolpropshbdTable, f : Double) -> ChemmolpropshbdTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_table_add(a : ChemmolpropshbdTable, b : ChemmolpropshbdTable) -> ChemmolpropshbdTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_hbd_table_copy(s : ChemmolpropshbdTable) -> ChemmolpropshbdTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_table_fill(s : ChemmolpropshbdTable, v : Double) -> ChemmolpropshbdTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_table_min(s : ChemmolpropshbdTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hbd_table_max(s : ChemmolpropshbdTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hbd_table_to_string(s : ChemmolpropshbdTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_graphn_make(size : Int) -> ChemmolpropshbdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_graphn_len(s : ChemmolpropshbdGraphN) -> Int { s.size }

pub fn chem_mol_props_hbd_graphn_get(s : ChemmolpropshbdGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_graphn_set(s : ChemmolpropshbdGraphN, i : Int, v : Double) -> ChemmolpropshbdGraphN {
  let result = chem_mol_props_hbd_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_graphn_sum(s : ChemmolpropshbdGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hbd_graphn_mean(s : ChemmolpropshbdGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hbd_graphn_scale(s : ChemmolpropshbdGraphN, f : Double) -> ChemmolpropshbdGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_graphn_add(a : ChemmolpropshbdGraphN, b : ChemmolpropshbdGraphN) -> ChemmolpropshbdGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_hbd_graphn_copy(s : ChemmolpropshbdGraphN) -> ChemmolpropshbdGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_graphn_fill(s : ChemmolpropshbdGraphN, v : Double) -> ChemmolpropshbdGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_graphn_min(s : ChemmolpropshbdGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hbd_graphn_max(s : ChemmolpropshbdGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hbd_graphn_to_string(s : ChemmolpropshbdGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_node_make(size : Int) -> ChemmolpropshbdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_node_len(s : ChemmolpropshbdNode) -> Int { s.size }

pub fn chem_mol_props_hbd_node_get(s : ChemmolpropshbdNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_node_set(s : ChemmolpropshbdNode, i : Int, v : Double) -> ChemmolpropshbdNode {
  let result = chem_mol_props_hbd_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_node_sum(s : ChemmolpropshbdNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hbd_node_mean(s : ChemmolpropshbdNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hbd_node_scale(s : ChemmolpropshbdNode, f : Double) -> ChemmolpropshbdNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_node_add(a : ChemmolpropshbdNode, b : ChemmolpropshbdNode) -> ChemmolpropshbdNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_hbd_node_copy(s : ChemmolpropshbdNode) -> ChemmolpropshbdNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_node_fill(s : ChemmolpropshbdNode, v : Double) -> ChemmolpropshbdNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_node_min(s : ChemmolpropshbdNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hbd_node_max(s : ChemmolpropshbdNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hbd_node_to_string(s : ChemmolpropshbdNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_edge_make(size : Int) -> ChemmolpropshbdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_edge_len(s : ChemmolpropshbdEdge) -> Int { s.size }

pub fn chem_mol_props_hbd_edge_get(s : ChemmolpropshbdEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_edge_set(s : ChemmolpropshbdEdge, i : Int, v : Double) -> ChemmolpropshbdEdge {
  let result = chem_mol_props_hbd_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_edge_sum(s : ChemmolpropshbdEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hbd_edge_mean(s : ChemmolpropshbdEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hbd_edge_scale(s : ChemmolpropshbdEdge, f : Double) -> ChemmolpropshbdEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_edge_add(a : ChemmolpropshbdEdge, b : ChemmolpropshbdEdge) -> ChemmolpropshbdEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_hbd_edge_copy(s : ChemmolpropshbdEdge) -> ChemmolpropshbdEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_edge_fill(s : ChemmolpropshbdEdge, v : Double) -> ChemmolpropshbdEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_edge_min(s : ChemmolpropshbdEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hbd_edge_max(s : ChemmolpropshbdEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hbd_edge_to_string(s : ChemmolpropshbdEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_path_make(size : Int) -> ChemmolpropshbdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_path_len(s : ChemmolpropshbdPath) -> Int { s.size }

pub fn chem_mol_props_hbd_path_get(s : ChemmolpropshbdPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_path_set(s : ChemmolpropshbdPath, i : Int, v : Double) -> ChemmolpropshbdPath {
  let result = chem_mol_props_hbd_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_path_sum(s : ChemmolpropshbdPath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hbd_path_mean(s : ChemmolpropshbdPath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hbd_path_scale(s : ChemmolpropshbdPath, f : Double) -> ChemmolpropshbdPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_path_add(a : ChemmolpropshbdPath, b : ChemmolpropshbdPath) -> ChemmolpropshbdPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_hbd_path_copy(s : ChemmolpropshbdPath) -> ChemmolpropshbdPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_path_fill(s : ChemmolpropshbdPath, v : Double) -> ChemmolpropshbdPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_path_min(s : ChemmolpropshbdPath) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hbd_path_max(s : ChemmolpropshbdPath) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hbd_path_to_string(s : ChemmolpropshbdPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_cluster_make(size : Int) -> ChemmolpropshbdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_cluster_len(s : ChemmolpropshbdCluster) -> Int { s.size }

pub fn chem_mol_props_hbd_cluster_get(s : ChemmolpropshbdCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_cluster_set(s : ChemmolpropshbdCluster, i : Int, v : Double) -> ChemmolpropshbdCluster {
  let result = chem_mol_props_hbd_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_cluster_sum(s : ChemmolpropshbdCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hbd_cluster_mean(s : ChemmolpropshbdCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hbd_cluster_scale(s : ChemmolpropshbdCluster, f : Double) -> ChemmolpropshbdCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_cluster_add(a : ChemmolpropshbdCluster, b : ChemmolpropshbdCluster) -> ChemmolpropshbdCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_hbd_cluster_copy(s : ChemmolpropshbdCluster) -> ChemmolpropshbdCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_cluster_fill(s : ChemmolpropshbdCluster, v : Double) -> ChemmolpropshbdCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_cluster_min(s : ChemmolpropshbdCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hbd_cluster_max(s : ChemmolpropshbdCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hbd_cluster_to_string(s : ChemmolpropshbdCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_model_make(size : Int) -> ChemmolpropshbdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_model_len(s : ChemmolpropshbdModel) -> Int { s.size }

pub fn chem_mol_props_hbd_model_get(s : ChemmolpropshbdModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_model_set(s : ChemmolpropshbdModel, i : Int, v : Double) -> ChemmolpropshbdModel {
  let result = chem_mol_props_hbd_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_model_sum(s : ChemmolpropshbdModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hbd_model_mean(s : ChemmolpropshbdModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hbd_model_scale(s : ChemmolpropshbdModel, f : Double) -> ChemmolpropshbdModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_model_add(a : ChemmolpropshbdModel, b : ChemmolpropshbdModel) -> ChemmolpropshbdModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_hbd_model_copy(s : ChemmolpropshbdModel) -> ChemmolpropshbdModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_model_fill(s : ChemmolpropshbdModel, v : Double) -> ChemmolpropshbdModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_model_min(s : ChemmolpropshbdModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hbd_model_max(s : ChemmolpropshbdModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hbd_model_to_string(s : ChemmolpropshbdModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_layer_make(size : Int) -> ChemmolpropshbdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_layer_len(s : ChemmolpropshbdLayer) -> Int { s.size }

pub fn chem_mol_props_hbd_layer_get(s : ChemmolpropshbdLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_layer_set(s : ChemmolpropshbdLayer, i : Int, v : Double) -> ChemmolpropshbdLayer {
  let result = chem_mol_props_hbd_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_layer_sum(s : ChemmolpropshbdLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hbd_layer_mean(s : ChemmolpropshbdLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hbd_layer_scale(s : ChemmolpropshbdLayer, f : Double) -> ChemmolpropshbdLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_layer_add(a : ChemmolpropshbdLayer, b : ChemmolpropshbdLayer) -> ChemmolpropshbdLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_hbd_layer_copy(s : ChemmolpropshbdLayer) -> ChemmolpropshbdLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_layer_fill(s : ChemmolpropshbdLayer, v : Double) -> ChemmolpropshbdLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_layer_min(s : ChemmolpropshbdLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hbd_layer_max(s : ChemmolpropshbdLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hbd_layer_to_string(s : ChemmolpropshbdLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_buffer_make(size : Int) -> ChemmolpropshbdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_buffer_len(s : ChemmolpropshbdBuffer) -> Int { s.size }

pub fn chem_mol_props_hbd_buffer_get(s : ChemmolpropshbdBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_buffer_set(s : ChemmolpropshbdBuffer, i : Int, v : Double) -> ChemmolpropshbdBuffer {
  let result = chem_mol_props_hbd_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_buffer_sum(s : ChemmolpropshbdBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hbd_buffer_mean(s : ChemmolpropshbdBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hbd_buffer_scale(s : ChemmolpropshbdBuffer, f : Double) -> ChemmolpropshbdBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_buffer_add(a : ChemmolpropshbdBuffer, b : ChemmolpropshbdBuffer) -> ChemmolpropshbdBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_hbd_buffer_copy(s : ChemmolpropshbdBuffer) -> ChemmolpropshbdBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_buffer_fill(s : ChemmolpropshbdBuffer, v : Double) -> ChemmolpropshbdBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_buffer_min(s : ChemmolpropshbdBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hbd_buffer_max(s : ChemmolpropshbdBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hbd_buffer_to_string(s : ChemmolpropshbdBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_cursor_make(size : Int) -> ChemmolpropshbdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_cursor_len(s : ChemmolpropshbdCursor) -> Int { s.size }

pub fn chem_mol_props_hbd_cursor_get(s : ChemmolpropshbdCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_cursor_set(s : ChemmolpropshbdCursor, i : Int, v : Double) -> ChemmolpropshbdCursor {
  let result = chem_mol_props_hbd_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_cursor_sum(s : ChemmolpropshbdCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hbd_cursor_mean(s : ChemmolpropshbdCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hbd_cursor_scale(s : ChemmolpropshbdCursor, f : Double) -> ChemmolpropshbdCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_cursor_add(a : ChemmolpropshbdCursor, b : ChemmolpropshbdCursor) -> ChemmolpropshbdCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_hbd_cursor_copy(s : ChemmolpropshbdCursor) -> ChemmolpropshbdCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_cursor_fill(s : ChemmolpropshbdCursor, v : Double) -> ChemmolpropshbdCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_cursor_min(s : ChemmolpropshbdCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hbd_cursor_max(s : ChemmolpropshbdCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hbd_cursor_to_string(s : ChemmolpropshbdCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_view_make(size : Int) -> ChemmolpropshbdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_view_len(s : ChemmolpropshbdView) -> Int { s.size }

pub fn chem_mol_props_hbd_view_get(s : ChemmolpropshbdView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_view_set(s : ChemmolpropshbdView, i : Int, v : Double) -> ChemmolpropshbdView {
  let result = chem_mol_props_hbd_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_view_sum(s : ChemmolpropshbdView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hbd_view_mean(s : ChemmolpropshbdView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hbd_view_scale(s : ChemmolpropshbdView, f : Double) -> ChemmolpropshbdView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_view_add(a : ChemmolpropshbdView, b : ChemmolpropshbdView) -> ChemmolpropshbdView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_hbd_view_copy(s : ChemmolpropshbdView) -> ChemmolpropshbdView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_view_fill(s : ChemmolpropshbdView, v : Double) -> ChemmolpropshbdView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_view_min(s : ChemmolpropshbdView) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hbd_view_max(s : ChemmolpropshbdView) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hbd_view_to_string(s : ChemmolpropshbdView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_range_make(size : Int) -> ChemmolpropshbdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_range_len(s : ChemmolpropshbdRange) -> Int { s.size }

pub fn chem_mol_props_hbd_range_get(s : ChemmolpropshbdRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_range_set(s : ChemmolpropshbdRange, i : Int, v : Double) -> ChemmolpropshbdRange {
  let result = chem_mol_props_hbd_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_range_sum(s : ChemmolpropshbdRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hbd_range_mean(s : ChemmolpropshbdRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hbd_range_scale(s : ChemmolpropshbdRange, f : Double) -> ChemmolpropshbdRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_range_add(a : ChemmolpropshbdRange, b : ChemmolpropshbdRange) -> ChemmolpropshbdRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_hbd_range_copy(s : ChemmolpropshbdRange) -> ChemmolpropshbdRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_range_fill(s : ChemmolpropshbdRange, v : Double) -> ChemmolpropshbdRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_range_min(s : ChemmolpropshbdRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hbd_range_max(s : ChemmolpropshbdRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hbd_range_to_string(s : ChemmolpropshbdRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_slice_make(size : Int) -> ChemmolpropshbdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_slice_len(s : ChemmolpropshbdSlice) -> Int { s.size }

pub fn chem_mol_props_hbd_slice_get(s : ChemmolpropshbdSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_slice_set(s : ChemmolpropshbdSlice, i : Int, v : Double) -> ChemmolpropshbdSlice {
  let result = chem_mol_props_hbd_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_slice_sum(s : ChemmolpropshbdSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_hbd_slice_mean(s : ChemmolpropshbdSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_hbd_slice_scale(s : ChemmolpropshbdSlice, f : Double) -> ChemmolpropshbdSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_slice_add(a : ChemmolpropshbdSlice, b : ChemmolpropshbdSlice) -> ChemmolpropshbdSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_hbd_slice_copy(s : ChemmolpropshbdSlice) -> ChemmolpropshbdSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_slice_fill(s : ChemmolpropshbdSlice, v : Double) -> ChemmolpropshbdSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_hbd_slice_min(s : ChemmolpropshbdSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_hbd_slice_max(s : ChemmolpropshbdSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_hbd_slice_to_string(s : ChemmolpropshbdSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

