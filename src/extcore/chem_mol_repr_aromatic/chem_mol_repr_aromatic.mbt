///===
/// extcore/chem_mol_repr_aromatic

pub(all) struct ChemmolrepraromaticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_repr_aromatic_make_point(x : Double, y : Double) -> ChemmolrepraromaticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_repr_aromatic_make_point3(x : Double, y : Double, z : Double) -> ChemmolrepraromaticPoint {
  { x, y, z, label: 0 }
}

pub fn chem_mol_repr_aromatic_point_x(pt : ChemmolrepraromaticPoint) -> Double { pt.x }

pub fn chem_mol_repr_aromatic_point_y(pt : ChemmolrepraromaticPoint) -> Double { pt.y }

pub fn chem_mol_repr_aromatic_point_z(pt : ChemmolrepraromaticPoint) -> Double { pt.z }

pub fn chem_mol_repr_aromatic_point_label(pt : ChemmolrepraromaticPoint) -> Int { pt.label }

pub fn chem_mol_repr_aromatic_point_dist(a : ChemmolrepraromaticPoint, b : ChemmolrepraromaticPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_mol_repr_aromatic_point_add(a : ChemmolrepraromaticPoint, b : ChemmolrepraromaticPoint) -> ChemmolrepraromaticPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_mol_repr_aromatic_point_sub(a : ChemmolrepraromaticPoint, b : ChemmolrepraromaticPoint) -> ChemmolrepraromaticPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_mol_repr_aromatic_point_scale(pt : ChemmolrepraromaticPoint, s : Double) -> ChemmolrepraromaticPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_mol_repr_aromatic_point_dot(a : ChemmolrepraromaticPoint, b : ChemmolrepraromaticPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_mol_repr_aromatic_point_cross(a : ChemmolrepraromaticPoint, b : ChemmolrepraromaticPoint) -> ChemmolrepraromaticPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_mol_repr_aromatic_point_norm(pt : ChemmolrepraromaticPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_mol_repr_aromatic_point_normalize(pt : ChemmolrepraromaticPoint) -> ChemmolrepraromaticPoint {
  let n = chem_mol_repr_aromatic_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_mol_repr_aromatic_point_scale(pt, 1.0 / n) }
}

pub fn chem_mol_repr_aromatic_point_negate(pt : ChemmolrepraromaticPoint) -> ChemmolrepraromaticPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_mol_repr_aromatic_point_mid(a : ChemmolrepraromaticPoint, b : ChemmolrepraromaticPoint) -> ChemmolrepraromaticPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_mol_repr_aromatic_point_lerp(a : ChemmolrepraromaticPoint, b : ChemmolrepraromaticPoint, t : Double) -> ChemmolrepraromaticPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_mol_repr_aromatic_point_to_string(pt : ChemmolrepraromaticPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_repr_aromatic_make_series(vals : Array[Double], name : String) -> ChemmolrepraromaticSeries {
  { vals, name, meta: 0 }
}

pub fn chem_mol_repr_aromatic_series_len(s : ChemmolrepraromaticSeries) -> Int { s.vals.length() }

pub fn chem_mol_repr_aromatic_series_sum(s : ChemmolrepraromaticSeries) -> Double { @_common.sum(s.vals) }

pub fn chem_mol_repr_aromatic_series_mean(s : ChemmolrepraromaticSeries) -> Double { @_common.mean(s.vals) }

pub fn chem_mol_repr_aromatic_series_min(s : ChemmolrepraromaticSeries) -> Double { @_common.min(s.vals) }

pub fn chem_mol_repr_aromatic_series_max(s : ChemmolrepraromaticSeries) -> Double { @_common.max(s.vals) }

pub fn chem_mol_repr_aromatic_series_range(s : ChemmolrepraromaticSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn chem_mol_repr_aromatic_series_var(s : ChemmolrepraromaticSeries) -> Double { @_common.variance(s.vals) }

pub fn chem_mol_repr_aromatic_series_std(s : ChemmolrepraromaticSeries) -> Double { @_common.std(s.vals) }

pub fn chem_mol_repr_aromatic_series_median(s : ChemmolrepraromaticSeries) -> Double { @_common.median(s.vals) }

pub fn chem_mol_repr_aromatic_series_scale(s : ChemmolrepraromaticSeries, f : Double) -> ChemmolrepraromaticSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_mol_repr_aromatic_series_add(a : ChemmolrepraromaticSeries, b : ChemmolrepraromaticSeries) -> ChemmolrepraromaticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_mol_repr_aromatic_series_sub(a : ChemmolrepraromaticSeries, b : ChemmolrepraromaticSeries) -> ChemmolrepraromaticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_mol_repr_aromatic_series_normalize(s : ChemmolrepraromaticSeries) -> ChemmolrepraromaticSeries {
  let mn = chem_mol_repr_aromatic_series_min(s)
  let mx = chem_mol_repr_aromatic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_mol_repr_aromatic_series_cumsum(s : ChemmolrepraromaticSeries) -> ChemmolrepraromaticSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_mol_repr_aromatic_series_to_string(s : ChemmolrepraromaticSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolrepraromaticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_repr_aromatic_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolrepraromaticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_repr_aromatic_matrix_identity(n : Int) -> ChemmolrepraromaticMatrix {
  let m = chem_mol_repr_aromatic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_mol_repr_aromatic_matrix_get(m : ChemmolrepraromaticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_mol_repr_aromatic_matrix_transpose(m : ChemmolrepraromaticMatrix) -> ChemmolrepraromaticMatrix {
  let result = chem_mol_repr_aromatic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_mol_repr_aromatic_matrix_add(a : ChemmolrepraromaticMatrix, b : ChemmolrepraromaticMatrix) -> ChemmolrepraromaticMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_mol_repr_aromatic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_mol_repr_aromatic_matrix_scale(m : ChemmolrepraromaticMatrix, s : Double) -> ChemmolrepraromaticMatrix {
  let result = chem_mol_repr_aromatic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_mol_repr_aromatic_matrix_multiply(a : ChemmolrepraromaticMatrix, b : ChemmolrepraromaticMatrix) -> ChemmolrepraromaticMatrix {
  if a.cols != b.rows { return chem_mol_repr_aromatic_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_mol_repr_aromatic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_mol_repr_aromatic_matrix_trace(m : ChemmolrepraromaticMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_mol_repr_aromatic_matrix_det(m : ChemmolrepraromaticMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_mol_repr_aromatic_matrix_norm(m : ChemmolrepraromaticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_mol_repr_aromatic_matrix_to_string(m : ChemmolrepraromaticMatrix) -> String {
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

pub(all) struct ChemmolrepraromaticVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_repr_aromatic_make_vector(comps : Array[Double]) -> ChemmolrepraromaticVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_repr_aromatic_vector_zero(dim : Int) -> ChemmolrepraromaticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_mol_repr_aromatic_vector_add(a : ChemmolrepraromaticVector, b : ChemmolrepraromaticVector) -> ChemmolrepraromaticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_repr_aromatic_vector_sub(a : ChemmolrepraromaticVector, b : ChemmolrepraromaticVector) -> ChemmolrepraromaticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_repr_aromatic_vector_scale(v : ChemmolrepraromaticVector, s : Double) -> ChemmolrepraromaticVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_mol_repr_aromatic_vector_dot(a : ChemmolrepraromaticVector, b : ChemmolrepraromaticVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_mol_repr_aromatic_vector_norm(v : ChemmolrepraromaticVector) -> Double { @_common.sqrt(chem_mol_repr_aromatic_vector_dot(v, v)) }

pub fn chem_mol_repr_aromatic_vector_normalize(v : ChemmolrepraromaticVector) -> ChemmolrepraromaticVector {
  let n = chem_mol_repr_aromatic_vector_norm(v)
  if n < 0.0000001 { v } else { chem_mol_repr_aromatic_vector_scale(v, 1.0 / n) }
}

pub fn chem_mol_repr_aromatic_vector_dist(a : ChemmolrepraromaticVector, b : ChemmolrepraromaticVector) -> Double {
  chem_mol_repr_aromatic_vector_norm(chem_mol_repr_aromatic_vector_sub(a, b))
}

pub fn chem_mol_repr_aromatic_vector_to_string(v : ChemmolrepraromaticVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_repr_aromatic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_repr_aromatic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_repr_aromatic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_repr_aromatic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_repr_aromatic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_repr_aromatic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_repr_aromatic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_repr_aromatic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_repr_aromatic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_repr_aromatic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_repr_aromatic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_repr_aromatic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_repr_aromatic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_repr_aromatic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_repr_aromatic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_repr_aromatic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_repr_aromatic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_repr_aromatic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_repr_aromatic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_repr_aromatic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_repr_aromatic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_repr_aromatic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_repr_aromatic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_repr_aromatic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_repr_aromatic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_repr_aromatic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_repr_aromatic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_repr_aromatic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_repr_aromatic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolrepraromaticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_frame_make(size : Int) -> ChemmolrepraromaticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_frame_len(s : ChemmolrepraromaticFrame) -> Int { s.size }

pub fn chem_mol_repr_aromatic_frame_get(s : ChemmolrepraromaticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_frame_set(s : ChemmolrepraromaticFrame, i : Int, v : Double) -> ChemmolrepraromaticFrame {
  let result = chem_mol_repr_aromatic_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_aromatic_frame_sum(s : ChemmolrepraromaticFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_frame_mean(s : ChemmolrepraromaticFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_frame_scale(s : ChemmolrepraromaticFrame, f : Double) -> ChemmolrepraromaticFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_frame_add(a : ChemmolrepraromaticFrame, b : ChemmolrepraromaticFrame) -> ChemmolrepraromaticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_frame_copy(s : ChemmolrepraromaticFrame) -> ChemmolrepraromaticFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_frame_fill(s : ChemmolrepraromaticFrame, v : Double) -> ChemmolrepraromaticFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_frame_min(s : ChemmolrepraromaticFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_frame_max(s : ChemmolrepraromaticFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_frame_to_string(s : ChemmolrepraromaticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_table_make(size : Int) -> ChemmolrepraromaticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_table_len(s : ChemmolrepraromaticTable) -> Int { s.size }

pub fn chem_mol_repr_aromatic_table_get(s : ChemmolrepraromaticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_table_set(s : ChemmolrepraromaticTable, i : Int, v : Double) -> ChemmolrepraromaticTable {
  let result = chem_mol_repr_aromatic_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_aromatic_table_sum(s : ChemmolrepraromaticTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_table_mean(s : ChemmolrepraromaticTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_table_scale(s : ChemmolrepraromaticTable, f : Double) -> ChemmolrepraromaticTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_table_add(a : ChemmolrepraromaticTable, b : ChemmolrepraromaticTable) -> ChemmolrepraromaticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_table_copy(s : ChemmolrepraromaticTable) -> ChemmolrepraromaticTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_table_fill(s : ChemmolrepraromaticTable, v : Double) -> ChemmolrepraromaticTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_table_min(s : ChemmolrepraromaticTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_table_max(s : ChemmolrepraromaticTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_table_to_string(s : ChemmolrepraromaticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_graphn_make(size : Int) -> ChemmolrepraromaticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_graphn_len(s : ChemmolrepraromaticGraphN) -> Int { s.size }

pub fn chem_mol_repr_aromatic_graphn_get(s : ChemmolrepraromaticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_graphn_set(s : ChemmolrepraromaticGraphN, i : Int, v : Double) -> ChemmolrepraromaticGraphN {
  let result = chem_mol_repr_aromatic_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_aromatic_graphn_sum(s : ChemmolrepraromaticGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_graphn_mean(s : ChemmolrepraromaticGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_graphn_scale(s : ChemmolrepraromaticGraphN, f : Double) -> ChemmolrepraromaticGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_graphn_add(a : ChemmolrepraromaticGraphN, b : ChemmolrepraromaticGraphN) -> ChemmolrepraromaticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_graphn_copy(s : ChemmolrepraromaticGraphN) -> ChemmolrepraromaticGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_graphn_fill(s : ChemmolrepraromaticGraphN, v : Double) -> ChemmolrepraromaticGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_graphn_min(s : ChemmolrepraromaticGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_graphn_max(s : ChemmolrepraromaticGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_graphn_to_string(s : ChemmolrepraromaticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_node_make(size : Int) -> ChemmolrepraromaticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_node_len(s : ChemmolrepraromaticNode) -> Int { s.size }

pub fn chem_mol_repr_aromatic_node_get(s : ChemmolrepraromaticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_node_set(s : ChemmolrepraromaticNode, i : Int, v : Double) -> ChemmolrepraromaticNode {
  let result = chem_mol_repr_aromatic_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_aromatic_node_sum(s : ChemmolrepraromaticNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_node_mean(s : ChemmolrepraromaticNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_node_scale(s : ChemmolrepraromaticNode, f : Double) -> ChemmolrepraromaticNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_node_add(a : ChemmolrepraromaticNode, b : ChemmolrepraromaticNode) -> ChemmolrepraromaticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_node_copy(s : ChemmolrepraromaticNode) -> ChemmolrepraromaticNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_node_fill(s : ChemmolrepraromaticNode, v : Double) -> ChemmolrepraromaticNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_node_min(s : ChemmolrepraromaticNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_node_max(s : ChemmolrepraromaticNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_node_to_string(s : ChemmolrepraromaticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_edge_make(size : Int) -> ChemmolrepraromaticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_edge_len(s : ChemmolrepraromaticEdge) -> Int { s.size }

pub fn chem_mol_repr_aromatic_edge_get(s : ChemmolrepraromaticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_edge_set(s : ChemmolrepraromaticEdge, i : Int, v : Double) -> ChemmolrepraromaticEdge {
  let result = chem_mol_repr_aromatic_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_aromatic_edge_sum(s : ChemmolrepraromaticEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_edge_mean(s : ChemmolrepraromaticEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_edge_scale(s : ChemmolrepraromaticEdge, f : Double) -> ChemmolrepraromaticEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_edge_add(a : ChemmolrepraromaticEdge, b : ChemmolrepraromaticEdge) -> ChemmolrepraromaticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_edge_copy(s : ChemmolrepraromaticEdge) -> ChemmolrepraromaticEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_edge_fill(s : ChemmolrepraromaticEdge, v : Double) -> ChemmolrepraromaticEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_edge_min(s : ChemmolrepraromaticEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_edge_max(s : ChemmolrepraromaticEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_edge_to_string(s : ChemmolrepraromaticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_path_make(size : Int) -> ChemmolrepraromaticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_path_len(s : ChemmolrepraromaticPath) -> Int { s.size }

pub fn chem_mol_repr_aromatic_path_get(s : ChemmolrepraromaticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_path_set(s : ChemmolrepraromaticPath, i : Int, v : Double) -> ChemmolrepraromaticPath {
  let result = chem_mol_repr_aromatic_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_aromatic_path_sum(s : ChemmolrepraromaticPath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_path_mean(s : ChemmolrepraromaticPath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_path_scale(s : ChemmolrepraromaticPath, f : Double) -> ChemmolrepraromaticPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_path_add(a : ChemmolrepraromaticPath, b : ChemmolrepraromaticPath) -> ChemmolrepraromaticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_path_copy(s : ChemmolrepraromaticPath) -> ChemmolrepraromaticPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_path_fill(s : ChemmolrepraromaticPath, v : Double) -> ChemmolrepraromaticPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_path_min(s : ChemmolrepraromaticPath) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_path_max(s : ChemmolrepraromaticPath) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_path_to_string(s : ChemmolrepraromaticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_cluster_make(size : Int) -> ChemmolrepraromaticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_cluster_len(s : ChemmolrepraromaticCluster) -> Int { s.size }

pub fn chem_mol_repr_aromatic_cluster_get(s : ChemmolrepraromaticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_cluster_set(s : ChemmolrepraromaticCluster, i : Int, v : Double) -> ChemmolrepraromaticCluster {
  let result = chem_mol_repr_aromatic_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_aromatic_cluster_sum(s : ChemmolrepraromaticCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_cluster_mean(s : ChemmolrepraromaticCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_cluster_scale(s : ChemmolrepraromaticCluster, f : Double) -> ChemmolrepraromaticCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_cluster_add(a : ChemmolrepraromaticCluster, b : ChemmolrepraromaticCluster) -> ChemmolrepraromaticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_cluster_copy(s : ChemmolrepraromaticCluster) -> ChemmolrepraromaticCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_cluster_fill(s : ChemmolrepraromaticCluster, v : Double) -> ChemmolrepraromaticCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_cluster_min(s : ChemmolrepraromaticCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_cluster_max(s : ChemmolrepraromaticCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_cluster_to_string(s : ChemmolrepraromaticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_model_make(size : Int) -> ChemmolrepraromaticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_model_len(s : ChemmolrepraromaticModel) -> Int { s.size }

pub fn chem_mol_repr_aromatic_model_get(s : ChemmolrepraromaticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_model_set(s : ChemmolrepraromaticModel, i : Int, v : Double) -> ChemmolrepraromaticModel {
  let result = chem_mol_repr_aromatic_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_aromatic_model_sum(s : ChemmolrepraromaticModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_model_mean(s : ChemmolrepraromaticModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_model_scale(s : ChemmolrepraromaticModel, f : Double) -> ChemmolrepraromaticModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_model_add(a : ChemmolrepraromaticModel, b : ChemmolrepraromaticModel) -> ChemmolrepraromaticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_model_copy(s : ChemmolrepraromaticModel) -> ChemmolrepraromaticModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_model_fill(s : ChemmolrepraromaticModel, v : Double) -> ChemmolrepraromaticModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_model_min(s : ChemmolrepraromaticModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_model_max(s : ChemmolrepraromaticModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_model_to_string(s : ChemmolrepraromaticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_layer_make(size : Int) -> ChemmolrepraromaticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_layer_len(s : ChemmolrepraromaticLayer) -> Int { s.size }

pub fn chem_mol_repr_aromatic_layer_get(s : ChemmolrepraromaticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_layer_set(s : ChemmolrepraromaticLayer, i : Int, v : Double) -> ChemmolrepraromaticLayer {
  let result = chem_mol_repr_aromatic_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_aromatic_layer_sum(s : ChemmolrepraromaticLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_layer_mean(s : ChemmolrepraromaticLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_layer_scale(s : ChemmolrepraromaticLayer, f : Double) -> ChemmolrepraromaticLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_layer_add(a : ChemmolrepraromaticLayer, b : ChemmolrepraromaticLayer) -> ChemmolrepraromaticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_layer_copy(s : ChemmolrepraromaticLayer) -> ChemmolrepraromaticLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_layer_fill(s : ChemmolrepraromaticLayer, v : Double) -> ChemmolrepraromaticLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_layer_min(s : ChemmolrepraromaticLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_layer_max(s : ChemmolrepraromaticLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_layer_to_string(s : ChemmolrepraromaticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_buffer_make(size : Int) -> ChemmolrepraromaticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_buffer_len(s : ChemmolrepraromaticBuffer) -> Int { s.size }

pub fn chem_mol_repr_aromatic_buffer_get(s : ChemmolrepraromaticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_buffer_set(s : ChemmolrepraromaticBuffer, i : Int, v : Double) -> ChemmolrepraromaticBuffer {
  let result = chem_mol_repr_aromatic_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_aromatic_buffer_sum(s : ChemmolrepraromaticBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_buffer_mean(s : ChemmolrepraromaticBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_buffer_scale(s : ChemmolrepraromaticBuffer, f : Double) -> ChemmolrepraromaticBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_buffer_add(a : ChemmolrepraromaticBuffer, b : ChemmolrepraromaticBuffer) -> ChemmolrepraromaticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_buffer_copy(s : ChemmolrepraromaticBuffer) -> ChemmolrepraromaticBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_buffer_fill(s : ChemmolrepraromaticBuffer, v : Double) -> ChemmolrepraromaticBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_buffer_min(s : ChemmolrepraromaticBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_buffer_max(s : ChemmolrepraromaticBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_buffer_to_string(s : ChemmolrepraromaticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_cursor_make(size : Int) -> ChemmolrepraromaticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_cursor_len(s : ChemmolrepraromaticCursor) -> Int { s.size }

pub fn chem_mol_repr_aromatic_cursor_get(s : ChemmolrepraromaticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_cursor_set(s : ChemmolrepraromaticCursor, i : Int, v : Double) -> ChemmolrepraromaticCursor {
  let result = chem_mol_repr_aromatic_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_aromatic_cursor_sum(s : ChemmolrepraromaticCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_cursor_mean(s : ChemmolrepraromaticCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_cursor_scale(s : ChemmolrepraromaticCursor, f : Double) -> ChemmolrepraromaticCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_cursor_add(a : ChemmolrepraromaticCursor, b : ChemmolrepraromaticCursor) -> ChemmolrepraromaticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_cursor_copy(s : ChemmolrepraromaticCursor) -> ChemmolrepraromaticCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_cursor_fill(s : ChemmolrepraromaticCursor, v : Double) -> ChemmolrepraromaticCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_cursor_min(s : ChemmolrepraromaticCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_cursor_max(s : ChemmolrepraromaticCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_cursor_to_string(s : ChemmolrepraromaticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_view_make(size : Int) -> ChemmolrepraromaticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_view_len(s : ChemmolrepraromaticView) -> Int { s.size }

pub fn chem_mol_repr_aromatic_view_get(s : ChemmolrepraromaticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_view_set(s : ChemmolrepraromaticView, i : Int, v : Double) -> ChemmolrepraromaticView {
  let result = chem_mol_repr_aromatic_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_aromatic_view_sum(s : ChemmolrepraromaticView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_view_mean(s : ChemmolrepraromaticView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_view_scale(s : ChemmolrepraromaticView, f : Double) -> ChemmolrepraromaticView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_view_add(a : ChemmolrepraromaticView, b : ChemmolrepraromaticView) -> ChemmolrepraromaticView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_view_copy(s : ChemmolrepraromaticView) -> ChemmolrepraromaticView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_view_fill(s : ChemmolrepraromaticView, v : Double) -> ChemmolrepraromaticView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_view_min(s : ChemmolrepraromaticView) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_view_max(s : ChemmolrepraromaticView) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_view_to_string(s : ChemmolrepraromaticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_range_make(size : Int) -> ChemmolrepraromaticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_range_len(s : ChemmolrepraromaticRange) -> Int { s.size }

pub fn chem_mol_repr_aromatic_range_get(s : ChemmolrepraromaticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_range_set(s : ChemmolrepraromaticRange, i : Int, v : Double) -> ChemmolrepraromaticRange {
  let result = chem_mol_repr_aromatic_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_aromatic_range_sum(s : ChemmolrepraromaticRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_range_mean(s : ChemmolrepraromaticRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_range_scale(s : ChemmolrepraromaticRange, f : Double) -> ChemmolrepraromaticRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_range_add(a : ChemmolrepraromaticRange, b : ChemmolrepraromaticRange) -> ChemmolrepraromaticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_range_copy(s : ChemmolrepraromaticRange) -> ChemmolrepraromaticRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_range_fill(s : ChemmolrepraromaticRange, v : Double) -> ChemmolrepraromaticRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_range_min(s : ChemmolrepraromaticRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_range_max(s : ChemmolrepraromaticRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_range_to_string(s : ChemmolrepraromaticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolrepraromaticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_aromatic_slice_make(size : Int) -> ChemmolrepraromaticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_aromatic_slice_len(s : ChemmolrepraromaticSlice) -> Int { s.size }

pub fn chem_mol_repr_aromatic_slice_get(s : ChemmolrepraromaticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_aromatic_slice_set(s : ChemmolrepraromaticSlice, i : Int, v : Double) -> ChemmolrepraromaticSlice {
  let result = chem_mol_repr_aromatic_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_aromatic_slice_sum(s : ChemmolrepraromaticSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_aromatic_slice_mean(s : ChemmolrepraromaticSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_aromatic_slice_scale(s : ChemmolrepraromaticSlice, f : Double) -> ChemmolrepraromaticSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_slice_add(a : ChemmolrepraromaticSlice, b : ChemmolrepraromaticSlice) -> ChemmolrepraromaticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_aromatic_slice_copy(s : ChemmolrepraromaticSlice) -> ChemmolrepraromaticSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_slice_fill(s : ChemmolrepraromaticSlice, v : Double) -> ChemmolrepraromaticSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_aromatic_slice_min(s : ChemmolrepraromaticSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_aromatic_slice_max(s : ChemmolrepraromaticSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_aromatic_slice_to_string(s : ChemmolrepraromaticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

