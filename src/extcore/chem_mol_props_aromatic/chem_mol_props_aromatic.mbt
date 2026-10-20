///===
/// extcore/chem_mol_props_aromatic

pub(all) struct ChemmolpropsaromaticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_aromatic_make_point(x : Double, y : Double) -> ChemmolpropsaromaticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_aromatic_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropsaromaticPoint {
  { x, y, z, label: 0 }
}

pub fn chem_mol_props_aromatic_point_x(pt : ChemmolpropsaromaticPoint) -> Double { pt.x }

pub fn chem_mol_props_aromatic_point_y(pt : ChemmolpropsaromaticPoint) -> Double { pt.y }

pub fn chem_mol_props_aromatic_point_z(pt : ChemmolpropsaromaticPoint) -> Double { pt.z }

pub fn chem_mol_props_aromatic_point_label(pt : ChemmolpropsaromaticPoint) -> Int { pt.label }

pub fn chem_mol_props_aromatic_point_dist(a : ChemmolpropsaromaticPoint, b : ChemmolpropsaromaticPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_mol_props_aromatic_point_add(a : ChemmolpropsaromaticPoint, b : ChemmolpropsaromaticPoint) -> ChemmolpropsaromaticPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_mol_props_aromatic_point_sub(a : ChemmolpropsaromaticPoint, b : ChemmolpropsaromaticPoint) -> ChemmolpropsaromaticPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_mol_props_aromatic_point_scale(pt : ChemmolpropsaromaticPoint, s : Double) -> ChemmolpropsaromaticPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_mol_props_aromatic_point_dot(a : ChemmolpropsaromaticPoint, b : ChemmolpropsaromaticPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_mol_props_aromatic_point_cross(a : ChemmolpropsaromaticPoint, b : ChemmolpropsaromaticPoint) -> ChemmolpropsaromaticPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_mol_props_aromatic_point_norm(pt : ChemmolpropsaromaticPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_mol_props_aromatic_point_normalize(pt : ChemmolpropsaromaticPoint) -> ChemmolpropsaromaticPoint {
  let n = chem_mol_props_aromatic_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_mol_props_aromatic_point_scale(pt, 1.0 / n) }
}

pub fn chem_mol_props_aromatic_point_negate(pt : ChemmolpropsaromaticPoint) -> ChemmolpropsaromaticPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_mol_props_aromatic_point_mid(a : ChemmolpropsaromaticPoint, b : ChemmolpropsaromaticPoint) -> ChemmolpropsaromaticPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_mol_props_aromatic_point_lerp(a : ChemmolpropsaromaticPoint, b : ChemmolpropsaromaticPoint, t : Double) -> ChemmolpropsaromaticPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_mol_props_aromatic_point_to_string(pt : ChemmolpropsaromaticPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_aromatic_make_series(vals : Array[Double], name : String) -> ChemmolpropsaromaticSeries {
  { vals, name, meta: 0 }
}

pub fn chem_mol_props_aromatic_series_len(s : ChemmolpropsaromaticSeries) -> Int { s.vals.length() }

pub fn chem_mol_props_aromatic_series_sum(s : ChemmolpropsaromaticSeries) -> Double { @_common.sum(s.vals) }

pub fn chem_mol_props_aromatic_series_mean(s : ChemmolpropsaromaticSeries) -> Double { @_common.mean(s.vals) }

pub fn chem_mol_props_aromatic_series_min(s : ChemmolpropsaromaticSeries) -> Double { @_common.min(s.vals) }

pub fn chem_mol_props_aromatic_series_max(s : ChemmolpropsaromaticSeries) -> Double { @_common.max(s.vals) }

pub fn chem_mol_props_aromatic_series_range(s : ChemmolpropsaromaticSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn chem_mol_props_aromatic_series_var(s : ChemmolpropsaromaticSeries) -> Double { @_common.variance(s.vals) }

pub fn chem_mol_props_aromatic_series_std(s : ChemmolpropsaromaticSeries) -> Double { @_common.std(s.vals) }

pub fn chem_mol_props_aromatic_series_median(s : ChemmolpropsaromaticSeries) -> Double { @_common.median(s.vals) }

pub fn chem_mol_props_aromatic_series_scale(s : ChemmolpropsaromaticSeries, f : Double) -> ChemmolpropsaromaticSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_mol_props_aromatic_series_add(a : ChemmolpropsaromaticSeries, b : ChemmolpropsaromaticSeries) -> ChemmolpropsaromaticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_mol_props_aromatic_series_sub(a : ChemmolpropsaromaticSeries, b : ChemmolpropsaromaticSeries) -> ChemmolpropsaromaticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_mol_props_aromatic_series_normalize(s : ChemmolpropsaromaticSeries) -> ChemmolpropsaromaticSeries {
  let mn = chem_mol_props_aromatic_series_min(s)
  let mx = chem_mol_props_aromatic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_mol_props_aromatic_series_cumsum(s : ChemmolpropsaromaticSeries) -> ChemmolpropsaromaticSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_mol_props_aromatic_series_to_string(s : ChemmolpropsaromaticSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropsaromaticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_aromatic_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropsaromaticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_aromatic_matrix_identity(n : Int) -> ChemmolpropsaromaticMatrix {
  let m = chem_mol_props_aromatic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_mol_props_aromatic_matrix_get(m : ChemmolpropsaromaticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_mol_props_aromatic_matrix_transpose(m : ChemmolpropsaromaticMatrix) -> ChemmolpropsaromaticMatrix {
  let result = chem_mol_props_aromatic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_mol_props_aromatic_matrix_add(a : ChemmolpropsaromaticMatrix, b : ChemmolpropsaromaticMatrix) -> ChemmolpropsaromaticMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_mol_props_aromatic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_mol_props_aromatic_matrix_scale(m : ChemmolpropsaromaticMatrix, s : Double) -> ChemmolpropsaromaticMatrix {
  let result = chem_mol_props_aromatic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_mol_props_aromatic_matrix_multiply(a : ChemmolpropsaromaticMatrix, b : ChemmolpropsaromaticMatrix) -> ChemmolpropsaromaticMatrix {
  if a.cols != b.rows { return chem_mol_props_aromatic_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_mol_props_aromatic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_mol_props_aromatic_matrix_trace(m : ChemmolpropsaromaticMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_mol_props_aromatic_matrix_det(m : ChemmolpropsaromaticMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_mol_props_aromatic_matrix_norm(m : ChemmolpropsaromaticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_mol_props_aromatic_matrix_to_string(m : ChemmolpropsaromaticMatrix) -> String {
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

pub(all) struct ChemmolpropsaromaticVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_aromatic_make_vector(comps : Array[Double]) -> ChemmolpropsaromaticVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_aromatic_vector_zero(dim : Int) -> ChemmolpropsaromaticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_mol_props_aromatic_vector_add(a : ChemmolpropsaromaticVector, b : ChemmolpropsaromaticVector) -> ChemmolpropsaromaticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_props_aromatic_vector_sub(a : ChemmolpropsaromaticVector, b : ChemmolpropsaromaticVector) -> ChemmolpropsaromaticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_props_aromatic_vector_scale(v : ChemmolpropsaromaticVector, s : Double) -> ChemmolpropsaromaticVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_mol_props_aromatic_vector_dot(a : ChemmolpropsaromaticVector, b : ChemmolpropsaromaticVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_mol_props_aromatic_vector_norm(v : ChemmolpropsaromaticVector) -> Double { @_common.sqrt(chem_mol_props_aromatic_vector_dot(v, v)) }

pub fn chem_mol_props_aromatic_vector_normalize(v : ChemmolpropsaromaticVector) -> ChemmolpropsaromaticVector {
  let n = chem_mol_props_aromatic_vector_norm(v)
  if n < 0.0000001 { v } else { chem_mol_props_aromatic_vector_scale(v, 1.0 / n) }
}

pub fn chem_mol_props_aromatic_vector_dist(a : ChemmolpropsaromaticVector, b : ChemmolpropsaromaticVector) -> Double {
  chem_mol_props_aromatic_vector_norm(chem_mol_props_aromatic_vector_sub(a, b))
}

pub fn chem_mol_props_aromatic_vector_to_string(v : ChemmolpropsaromaticVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_props_aromatic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_props_aromatic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_props_aromatic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_props_aromatic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_props_aromatic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_props_aromatic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_props_aromatic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_props_aromatic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_props_aromatic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_props_aromatic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_props_aromatic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_props_aromatic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_props_aromatic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_props_aromatic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_props_aromatic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_props_aromatic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_props_aromatic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_props_aromatic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_props_aromatic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_props_aromatic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_props_aromatic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_props_aromatic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_props_aromatic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_props_aromatic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_props_aromatic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_props_aromatic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_props_aromatic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_props_aromatic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_props_aromatic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolpropsaromaticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_frame_make(size : Int) -> ChemmolpropsaromaticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_frame_len(s : ChemmolpropsaromaticFrame) -> Int { s.size }

pub fn chem_mol_props_aromatic_frame_get(s : ChemmolpropsaromaticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_frame_set(s : ChemmolpropsaromaticFrame, i : Int, v : Double) -> ChemmolpropsaromaticFrame {
  let result = chem_mol_props_aromatic_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_frame_sum(s : ChemmolpropsaromaticFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_frame_mean(s : ChemmolpropsaromaticFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_frame_scale(s : ChemmolpropsaromaticFrame, f : Double) -> ChemmolpropsaromaticFrame {
  let result = chem_mol_props_aromatic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_aromatic_frame_add(a : ChemmolpropsaromaticFrame, b : ChemmolpropsaromaticFrame) -> ChemmolpropsaromaticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_aromatic_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_aromatic_frame_copy(s : ChemmolpropsaromaticFrame) -> ChemmolpropsaromaticFrame {
  let result = chem_mol_props_aromatic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_aromatic_frame_fill(s : ChemmolpropsaromaticFrame, v : Double) -> ChemmolpropsaromaticFrame {
  let result = chem_mol_props_aromatic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_frame_min(s : ChemmolpropsaromaticFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_frame_max(s : ChemmolpropsaromaticFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_frame_to_string(s : ChemmolpropsaromaticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_table_make(size : Int) -> ChemmolpropsaromaticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_table_len(s : ChemmolpropsaromaticTable) -> Int { s.size }

pub fn chem_mol_props_aromatic_table_get(s : ChemmolpropsaromaticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_table_set(s : ChemmolpropsaromaticTable, i : Int, v : Double) -> ChemmolpropsaromaticTable {
  let result = chem_mol_props_aromatic_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_table_sum(s : ChemmolpropsaromaticTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_table_mean(s : ChemmolpropsaromaticTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_table_scale(s : ChemmolpropsaromaticTable, f : Double) -> ChemmolpropsaromaticTable {
  let result = chem_mol_props_aromatic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_aromatic_table_add(a : ChemmolpropsaromaticTable, b : ChemmolpropsaromaticTable) -> ChemmolpropsaromaticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_aromatic_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_aromatic_table_copy(s : ChemmolpropsaromaticTable) -> ChemmolpropsaromaticTable {
  let result = chem_mol_props_aromatic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_aromatic_table_fill(s : ChemmolpropsaromaticTable, v : Double) -> ChemmolpropsaromaticTable {
  let result = chem_mol_props_aromatic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_table_min(s : ChemmolpropsaromaticTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_table_max(s : ChemmolpropsaromaticTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_table_to_string(s : ChemmolpropsaromaticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_graphn_make(size : Int) -> ChemmolpropsaromaticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_graphn_len(s : ChemmolpropsaromaticGraphN) -> Int { s.size }

pub fn chem_mol_props_aromatic_graphn_get(s : ChemmolpropsaromaticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_graphn_set(s : ChemmolpropsaromaticGraphN, i : Int, v : Double) -> ChemmolpropsaromaticGraphN {
  let result = chem_mol_props_aromatic_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_graphn_sum(s : ChemmolpropsaromaticGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_graphn_mean(s : ChemmolpropsaromaticGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_graphn_scale(s : ChemmolpropsaromaticGraphN, f : Double) -> ChemmolpropsaromaticGraphN {
  let result = chem_mol_props_aromatic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_aromatic_graphn_add(a : ChemmolpropsaromaticGraphN, b : ChemmolpropsaromaticGraphN) -> ChemmolpropsaromaticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_aromatic_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_aromatic_graphn_copy(s : ChemmolpropsaromaticGraphN) -> ChemmolpropsaromaticGraphN {
  let result = chem_mol_props_aromatic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_aromatic_graphn_fill(s : ChemmolpropsaromaticGraphN, v : Double) -> ChemmolpropsaromaticGraphN {
  let result = chem_mol_props_aromatic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_graphn_min(s : ChemmolpropsaromaticGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_graphn_max(s : ChemmolpropsaromaticGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_graphn_to_string(s : ChemmolpropsaromaticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_node_make(size : Int) -> ChemmolpropsaromaticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_node_len(s : ChemmolpropsaromaticNode) -> Int { s.size }

pub fn chem_mol_props_aromatic_node_get(s : ChemmolpropsaromaticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_node_set(s : ChemmolpropsaromaticNode, i : Int, v : Double) -> ChemmolpropsaromaticNode {
  let result = chem_mol_props_aromatic_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_node_sum(s : ChemmolpropsaromaticNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_node_mean(s : ChemmolpropsaromaticNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_node_scale(s : ChemmolpropsaromaticNode, f : Double) -> ChemmolpropsaromaticNode {
  let result = chem_mol_props_aromatic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_aromatic_node_add(a : ChemmolpropsaromaticNode, b : ChemmolpropsaromaticNode) -> ChemmolpropsaromaticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_aromatic_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_aromatic_node_copy(s : ChemmolpropsaromaticNode) -> ChemmolpropsaromaticNode {
  let result = chem_mol_props_aromatic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_aromatic_node_fill(s : ChemmolpropsaromaticNode, v : Double) -> ChemmolpropsaromaticNode {
  let result = chem_mol_props_aromatic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_node_min(s : ChemmolpropsaromaticNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_node_max(s : ChemmolpropsaromaticNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_node_to_string(s : ChemmolpropsaromaticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_edge_make(size : Int) -> ChemmolpropsaromaticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_edge_len(s : ChemmolpropsaromaticEdge) -> Int { s.size }

pub fn chem_mol_props_aromatic_edge_get(s : ChemmolpropsaromaticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_edge_set(s : ChemmolpropsaromaticEdge, i : Int, v : Double) -> ChemmolpropsaromaticEdge {
  let result = chem_mol_props_aromatic_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_edge_sum(s : ChemmolpropsaromaticEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_edge_mean(s : ChemmolpropsaromaticEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_edge_scale(s : ChemmolpropsaromaticEdge, f : Double) -> ChemmolpropsaromaticEdge {
  let result = chem_mol_props_aromatic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_aromatic_edge_add(a : ChemmolpropsaromaticEdge, b : ChemmolpropsaromaticEdge) -> ChemmolpropsaromaticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_aromatic_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_aromatic_edge_copy(s : ChemmolpropsaromaticEdge) -> ChemmolpropsaromaticEdge {
  let result = chem_mol_props_aromatic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_aromatic_edge_fill(s : ChemmolpropsaromaticEdge, v : Double) -> ChemmolpropsaromaticEdge {
  let result = chem_mol_props_aromatic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_edge_min(s : ChemmolpropsaromaticEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_edge_max(s : ChemmolpropsaromaticEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_edge_to_string(s : ChemmolpropsaromaticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_path_make(size : Int) -> ChemmolpropsaromaticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_path_len(s : ChemmolpropsaromaticPath) -> Int { s.size }

pub fn chem_mol_props_aromatic_path_get(s : ChemmolpropsaromaticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_path_set(s : ChemmolpropsaromaticPath, i : Int, v : Double) -> ChemmolpropsaromaticPath {
  let result = chem_mol_props_aromatic_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_path_sum(s : ChemmolpropsaromaticPath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_path_mean(s : ChemmolpropsaromaticPath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_path_scale(s : ChemmolpropsaromaticPath, f : Double) -> ChemmolpropsaromaticPath {
  let result = chem_mol_props_aromatic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_aromatic_path_add(a : ChemmolpropsaromaticPath, b : ChemmolpropsaromaticPath) -> ChemmolpropsaromaticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_aromatic_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_aromatic_path_copy(s : ChemmolpropsaromaticPath) -> ChemmolpropsaromaticPath {
  let result = chem_mol_props_aromatic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_aromatic_path_fill(s : ChemmolpropsaromaticPath, v : Double) -> ChemmolpropsaromaticPath {
  let result = chem_mol_props_aromatic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_path_min(s : ChemmolpropsaromaticPath) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_path_max(s : ChemmolpropsaromaticPath) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_path_to_string(s : ChemmolpropsaromaticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_cluster_make(size : Int) -> ChemmolpropsaromaticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_cluster_len(s : ChemmolpropsaromaticCluster) -> Int { s.size }

pub fn chem_mol_props_aromatic_cluster_get(s : ChemmolpropsaromaticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_cluster_set(s : ChemmolpropsaromaticCluster, i : Int, v : Double) -> ChemmolpropsaromaticCluster {
  let result = chem_mol_props_aromatic_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_cluster_sum(s : ChemmolpropsaromaticCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_cluster_mean(s : ChemmolpropsaromaticCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_cluster_scale(s : ChemmolpropsaromaticCluster, f : Double) -> ChemmolpropsaromaticCluster {
  let result = chem_mol_props_aromatic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_aromatic_cluster_add(a : ChemmolpropsaromaticCluster, b : ChemmolpropsaromaticCluster) -> ChemmolpropsaromaticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_aromatic_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_aromatic_cluster_copy(s : ChemmolpropsaromaticCluster) -> ChemmolpropsaromaticCluster {
  let result = chem_mol_props_aromatic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_aromatic_cluster_fill(s : ChemmolpropsaromaticCluster, v : Double) -> ChemmolpropsaromaticCluster {
  let result = chem_mol_props_aromatic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_cluster_min(s : ChemmolpropsaromaticCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_cluster_max(s : ChemmolpropsaromaticCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_cluster_to_string(s : ChemmolpropsaromaticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_model_make(size : Int) -> ChemmolpropsaromaticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_model_len(s : ChemmolpropsaromaticModel) -> Int { s.size }

pub fn chem_mol_props_aromatic_model_get(s : ChemmolpropsaromaticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_model_set(s : ChemmolpropsaromaticModel, i : Int, v : Double) -> ChemmolpropsaromaticModel {
  let result = chem_mol_props_aromatic_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_model_sum(s : ChemmolpropsaromaticModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_model_mean(s : ChemmolpropsaromaticModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_model_scale(s : ChemmolpropsaromaticModel, f : Double) -> ChemmolpropsaromaticModel {
  let result = chem_mol_props_aromatic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_aromatic_model_add(a : ChemmolpropsaromaticModel, b : ChemmolpropsaromaticModel) -> ChemmolpropsaromaticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_aromatic_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_aromatic_model_copy(s : ChemmolpropsaromaticModel) -> ChemmolpropsaromaticModel {
  let result = chem_mol_props_aromatic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_aromatic_model_fill(s : ChemmolpropsaromaticModel, v : Double) -> ChemmolpropsaromaticModel {
  let result = chem_mol_props_aromatic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_model_min(s : ChemmolpropsaromaticModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_model_max(s : ChemmolpropsaromaticModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_model_to_string(s : ChemmolpropsaromaticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_layer_make(size : Int) -> ChemmolpropsaromaticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_layer_len(s : ChemmolpropsaromaticLayer) -> Int { s.size }

pub fn chem_mol_props_aromatic_layer_get(s : ChemmolpropsaromaticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_layer_set(s : ChemmolpropsaromaticLayer, i : Int, v : Double) -> ChemmolpropsaromaticLayer {
  let result = chem_mol_props_aromatic_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_layer_sum(s : ChemmolpropsaromaticLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_layer_mean(s : ChemmolpropsaromaticLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_layer_scale(s : ChemmolpropsaromaticLayer, f : Double) -> ChemmolpropsaromaticLayer {
  let result = chem_mol_props_aromatic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_aromatic_layer_add(a : ChemmolpropsaromaticLayer, b : ChemmolpropsaromaticLayer) -> ChemmolpropsaromaticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_aromatic_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_aromatic_layer_copy(s : ChemmolpropsaromaticLayer) -> ChemmolpropsaromaticLayer {
  let result = chem_mol_props_aromatic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_aromatic_layer_fill(s : ChemmolpropsaromaticLayer, v : Double) -> ChemmolpropsaromaticLayer {
  let result = chem_mol_props_aromatic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_layer_min(s : ChemmolpropsaromaticLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_layer_max(s : ChemmolpropsaromaticLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_layer_to_string(s : ChemmolpropsaromaticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_buffer_make(size : Int) -> ChemmolpropsaromaticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_buffer_len(s : ChemmolpropsaromaticBuffer) -> Int { s.size }

pub fn chem_mol_props_aromatic_buffer_get(s : ChemmolpropsaromaticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_buffer_set(s : ChemmolpropsaromaticBuffer, i : Int, v : Double) -> ChemmolpropsaromaticBuffer {
  let result = chem_mol_props_aromatic_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_buffer_sum(s : ChemmolpropsaromaticBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_buffer_mean(s : ChemmolpropsaromaticBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_buffer_scale(s : ChemmolpropsaromaticBuffer, f : Double) -> ChemmolpropsaromaticBuffer {
  let result = chem_mol_props_aromatic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_aromatic_buffer_add(a : ChemmolpropsaromaticBuffer, b : ChemmolpropsaromaticBuffer) -> ChemmolpropsaromaticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_aromatic_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_aromatic_buffer_copy(s : ChemmolpropsaromaticBuffer) -> ChemmolpropsaromaticBuffer {
  let result = chem_mol_props_aromatic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_aromatic_buffer_fill(s : ChemmolpropsaromaticBuffer, v : Double) -> ChemmolpropsaromaticBuffer {
  let result = chem_mol_props_aromatic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_buffer_min(s : ChemmolpropsaromaticBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_buffer_max(s : ChemmolpropsaromaticBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_buffer_to_string(s : ChemmolpropsaromaticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_cursor_make(size : Int) -> ChemmolpropsaromaticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_cursor_len(s : ChemmolpropsaromaticCursor) -> Int { s.size }

pub fn chem_mol_props_aromatic_cursor_get(s : ChemmolpropsaromaticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_cursor_set(s : ChemmolpropsaromaticCursor, i : Int, v : Double) -> ChemmolpropsaromaticCursor {
  let result = chem_mol_props_aromatic_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_cursor_sum(s : ChemmolpropsaromaticCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_cursor_mean(s : ChemmolpropsaromaticCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_cursor_scale(s : ChemmolpropsaromaticCursor, f : Double) -> ChemmolpropsaromaticCursor {
  let result = chem_mol_props_aromatic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_aromatic_cursor_add(a : ChemmolpropsaromaticCursor, b : ChemmolpropsaromaticCursor) -> ChemmolpropsaromaticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_aromatic_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_aromatic_cursor_copy(s : ChemmolpropsaromaticCursor) -> ChemmolpropsaromaticCursor {
  let result = chem_mol_props_aromatic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_aromatic_cursor_fill(s : ChemmolpropsaromaticCursor, v : Double) -> ChemmolpropsaromaticCursor {
  let result = chem_mol_props_aromatic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_cursor_min(s : ChemmolpropsaromaticCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_cursor_max(s : ChemmolpropsaromaticCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_cursor_to_string(s : ChemmolpropsaromaticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_view_make(size : Int) -> ChemmolpropsaromaticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_view_len(s : ChemmolpropsaromaticView) -> Int { s.size }

pub fn chem_mol_props_aromatic_view_get(s : ChemmolpropsaromaticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_view_set(s : ChemmolpropsaromaticView, i : Int, v : Double) -> ChemmolpropsaromaticView {
  let result = chem_mol_props_aromatic_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_view_sum(s : ChemmolpropsaromaticView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_view_mean(s : ChemmolpropsaromaticView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_view_scale(s : ChemmolpropsaromaticView, f : Double) -> ChemmolpropsaromaticView {
  let result = chem_mol_props_aromatic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_aromatic_view_add(a : ChemmolpropsaromaticView, b : ChemmolpropsaromaticView) -> ChemmolpropsaromaticView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_aromatic_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_aromatic_view_copy(s : ChemmolpropsaromaticView) -> ChemmolpropsaromaticView {
  let result = chem_mol_props_aromatic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_aromatic_view_fill(s : ChemmolpropsaromaticView, v : Double) -> ChemmolpropsaromaticView {
  let result = chem_mol_props_aromatic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_view_min(s : ChemmolpropsaromaticView) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_view_max(s : ChemmolpropsaromaticView) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_view_to_string(s : ChemmolpropsaromaticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_range_make(size : Int) -> ChemmolpropsaromaticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_range_len(s : ChemmolpropsaromaticRange) -> Int { s.size }

pub fn chem_mol_props_aromatic_range_get(s : ChemmolpropsaromaticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_range_set(s : ChemmolpropsaromaticRange, i : Int, v : Double) -> ChemmolpropsaromaticRange {
  let result = chem_mol_props_aromatic_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_range_sum(s : ChemmolpropsaromaticRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_range_mean(s : ChemmolpropsaromaticRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_range_scale(s : ChemmolpropsaromaticRange, f : Double) -> ChemmolpropsaromaticRange {
  let result = chem_mol_props_aromatic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_aromatic_range_add(a : ChemmolpropsaromaticRange, b : ChemmolpropsaromaticRange) -> ChemmolpropsaromaticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_aromatic_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_aromatic_range_copy(s : ChemmolpropsaromaticRange) -> ChemmolpropsaromaticRange {
  let result = chem_mol_props_aromatic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_aromatic_range_fill(s : ChemmolpropsaromaticRange, v : Double) -> ChemmolpropsaromaticRange {
  let result = chem_mol_props_aromatic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_range_min(s : ChemmolpropsaromaticRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_range_max(s : ChemmolpropsaromaticRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_range_to_string(s : ChemmolpropsaromaticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_slice_make(size : Int) -> ChemmolpropsaromaticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_slice_len(s : ChemmolpropsaromaticSlice) -> Int { s.size }

pub fn chem_mol_props_aromatic_slice_get(s : ChemmolpropsaromaticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_slice_set(s : ChemmolpropsaromaticSlice, i : Int, v : Double) -> ChemmolpropsaromaticSlice {
  let result = chem_mol_props_aromatic_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_slice_sum(s : ChemmolpropsaromaticSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_slice_mean(s : ChemmolpropsaromaticSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_slice_scale(s : ChemmolpropsaromaticSlice, f : Double) -> ChemmolpropsaromaticSlice {
  let result = chem_mol_props_aromatic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_aromatic_slice_add(a : ChemmolpropsaromaticSlice, b : ChemmolpropsaromaticSlice) -> ChemmolpropsaromaticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_aromatic_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_aromatic_slice_copy(s : ChemmolpropsaromaticSlice) -> ChemmolpropsaromaticSlice {
  let result = chem_mol_props_aromatic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_aromatic_slice_fill(s : ChemmolpropsaromaticSlice, v : Double) -> ChemmolpropsaromaticSlice {
  let result = chem_mol_props_aromatic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_aromatic_slice_min(s : ChemmolpropsaromaticSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_slice_max(s : ChemmolpropsaromaticSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_slice_to_string(s : ChemmolpropsaromaticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

