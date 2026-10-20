///===
/// extcore/chem_mol_repr_cif

pub(all) struct ChemmolreprcifPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_repr_cif_make_point(x : Double, y : Double) -> ChemmolreprcifPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_repr_cif_make_point3(x : Double, y : Double, z : Double) -> ChemmolreprcifPoint {
  { x, y, z, label: 0 }
}

pub fn chem_mol_repr_cif_point_x(pt : ChemmolreprcifPoint) -> Double { pt.x }

pub fn chem_mol_repr_cif_point_y(pt : ChemmolreprcifPoint) -> Double { pt.y }

pub fn chem_mol_repr_cif_point_z(pt : ChemmolreprcifPoint) -> Double { pt.z }

pub fn chem_mol_repr_cif_point_label(pt : ChemmolreprcifPoint) -> Int { pt.label }

pub fn chem_mol_repr_cif_point_dist(a : ChemmolreprcifPoint, b : ChemmolreprcifPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_mol_repr_cif_point_add(a : ChemmolreprcifPoint, b : ChemmolreprcifPoint) -> ChemmolreprcifPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_mol_repr_cif_point_sub(a : ChemmolreprcifPoint, b : ChemmolreprcifPoint) -> ChemmolreprcifPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_mol_repr_cif_point_scale(pt : ChemmolreprcifPoint, s : Double) -> ChemmolreprcifPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_mol_repr_cif_point_dot(a : ChemmolreprcifPoint, b : ChemmolreprcifPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_mol_repr_cif_point_cross(a : ChemmolreprcifPoint, b : ChemmolreprcifPoint) -> ChemmolreprcifPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_mol_repr_cif_point_norm(pt : ChemmolreprcifPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_mol_repr_cif_point_normalize(pt : ChemmolreprcifPoint) -> ChemmolreprcifPoint {
  let n = chem_mol_repr_cif_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_mol_repr_cif_point_scale(pt, 1.0 / n) }
}

pub fn chem_mol_repr_cif_point_negate(pt : ChemmolreprcifPoint) -> ChemmolreprcifPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_mol_repr_cif_point_mid(a : ChemmolreprcifPoint, b : ChemmolreprcifPoint) -> ChemmolreprcifPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_mol_repr_cif_point_lerp(a : ChemmolreprcifPoint, b : ChemmolreprcifPoint, t : Double) -> ChemmolreprcifPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_mol_repr_cif_point_to_string(pt : ChemmolreprcifPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemmolreprcifSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_repr_cif_make_series(vals : Array[Double], name : String) -> ChemmolreprcifSeries {
  { vals, name, meta: 0 }
}

pub fn chem_mol_repr_cif_series_len(s : ChemmolreprcifSeries) -> Int { s.vals.length() }

pub fn chem_mol_repr_cif_series_sum(s : ChemmolreprcifSeries) -> Double { @_common.sum(s.vals) }

pub fn chem_mol_repr_cif_series_mean(s : ChemmolreprcifSeries) -> Double { @_common.mean(s.vals) }

pub fn chem_mol_repr_cif_series_min(s : ChemmolreprcifSeries) -> Double { @_common.min(s.vals) }

pub fn chem_mol_repr_cif_series_max(s : ChemmolreprcifSeries) -> Double { @_common.max(s.vals) }

pub fn chem_mol_repr_cif_series_range(s : ChemmolreprcifSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn chem_mol_repr_cif_series_var(s : ChemmolreprcifSeries) -> Double { @_common.variance(s.vals) }

pub fn chem_mol_repr_cif_series_std(s : ChemmolreprcifSeries) -> Double { @_common.std(s.vals) }

pub fn chem_mol_repr_cif_series_median(s : ChemmolreprcifSeries) -> Double { @_common.median(s.vals) }

pub fn chem_mol_repr_cif_series_scale(s : ChemmolreprcifSeries, f : Double) -> ChemmolreprcifSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn chem_mol_repr_cif_series_add(a : ChemmolreprcifSeries, b : ChemmolreprcifSeries) -> ChemmolreprcifSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_mol_repr_cif_series_sub(a : ChemmolreprcifSeries, b : ChemmolreprcifSeries) -> ChemmolreprcifSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_mol_repr_cif_series_normalize(s : ChemmolreprcifSeries) -> ChemmolreprcifSeries {
  let mn = chem_mol_repr_cif_series_min(s)
  let mx = chem_mol_repr_cif_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_mol_repr_cif_series_cumsum(s : ChemmolreprcifSeries) -> ChemmolreprcifSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_mol_repr_cif_series_to_string(s : ChemmolreprcifSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprcifMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_repr_cif_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolreprcifMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_repr_cif_matrix_identity(n : Int) -> ChemmolreprcifMatrix {
  let m = chem_mol_repr_cif_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_mol_repr_cif_matrix_get(m : ChemmolreprcifMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_mol_repr_cif_matrix_transpose(m : ChemmolreprcifMatrix) -> ChemmolreprcifMatrix {
  let result = chem_mol_repr_cif_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_mol_repr_cif_matrix_add(a : ChemmolreprcifMatrix, b : ChemmolreprcifMatrix) -> ChemmolreprcifMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_mol_repr_cif_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_mol_repr_cif_matrix_scale(m : ChemmolreprcifMatrix, s : Double) -> ChemmolreprcifMatrix {
  let result = chem_mol_repr_cif_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_mol_repr_cif_matrix_multiply(a : ChemmolreprcifMatrix, b : ChemmolreprcifMatrix) -> ChemmolreprcifMatrix {
  if a.cols != b.rows { return chem_mol_repr_cif_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_mol_repr_cif_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_mol_repr_cif_matrix_trace(m : ChemmolreprcifMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_mol_repr_cif_matrix_det(m : ChemmolreprcifMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_mol_repr_cif_matrix_norm(m : ChemmolreprcifMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_mol_repr_cif_matrix_to_string(m : ChemmolreprcifMatrix) -> String {
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

pub(all) struct ChemmolreprcifVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_repr_cif_make_vector(comps : Array[Double]) -> ChemmolreprcifVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_repr_cif_vector_zero(dim : Int) -> ChemmolreprcifVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_mol_repr_cif_vector_add(a : ChemmolreprcifVector, b : ChemmolreprcifVector) -> ChemmolreprcifVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn chem_mol_repr_cif_vector_sub(a : ChemmolreprcifVector, b : ChemmolreprcifVector) -> ChemmolreprcifVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn chem_mol_repr_cif_vector_scale(v : ChemmolreprcifVector, s : Double) -> ChemmolreprcifVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn chem_mol_repr_cif_vector_dot(a : ChemmolreprcifVector, b : ChemmolreprcifVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_mol_repr_cif_vector_norm(v : ChemmolreprcifVector) -> Double { @_common.sqrt(chem_mol_repr_cif_vector_dot(v, v)) }

pub fn chem_mol_repr_cif_vector_normalize(v : ChemmolreprcifVector) -> ChemmolreprcifVector {
  let n = chem_mol_repr_cif_vector_norm(v)
  if n < 0.0000001 { v } else { chem_mol_repr_cif_vector_scale(v, 1.0 / n) }
}

pub fn chem_mol_repr_cif_vector_dist(a : ChemmolreprcifVector, b : ChemmolreprcifVector) -> Double {
  chem_mol_repr_cif_vector_norm(chem_mol_repr_cif_vector_sub(a, b))
}

pub fn chem_mol_repr_cif_vector_to_string(v : ChemmolreprcifVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_repr_cif_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_repr_cif_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_repr_cif_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_repr_cif_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_repr_cif_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_repr_cif_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_repr_cif_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_repr_cif_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_repr_cif_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_repr_cif_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_repr_cif_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_repr_cif_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_repr_cif_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_repr_cif_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_repr_cif_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_repr_cif_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_repr_cif_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_repr_cif_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_repr_cif_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_repr_cif_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_repr_cif_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_repr_cif_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_repr_cif_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_repr_cif_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_repr_cif_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_repr_cif_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_repr_cif_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_repr_cif_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_repr_cif_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolreprcifFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_frame_make(size : Int) -> ChemmolreprcifFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_frame_len(s : ChemmolreprcifFrame) -> Int { s.size }

pub fn chem_mol_repr_cif_frame_get(s : ChemmolreprcifFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_frame_set(s : ChemmolreprcifFrame, i : Int, v : Double) -> ChemmolreprcifFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_frame_sum(s : ChemmolreprcifFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_frame_mean(s : ChemmolreprcifFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_frame_scale(s : ChemmolreprcifFrame, f : Double) -> ChemmolreprcifFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_frame_add(a : ChemmolreprcifFrame, b : ChemmolreprcifFrame) -> ChemmolreprcifFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_frame_copy(s : ChemmolreprcifFrame) -> ChemmolreprcifFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_frame_fill(s : ChemmolreprcifFrame, v : Double) -> ChemmolreprcifFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_frame_min(s : ChemmolreprcifFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_frame_max(s : ChemmolreprcifFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_frame_to_string(s : ChemmolreprcifFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_table_make(size : Int) -> ChemmolreprcifTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_table_len(s : ChemmolreprcifTable) -> Int { s.size }

pub fn chem_mol_repr_cif_table_get(s : ChemmolreprcifTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_table_set(s : ChemmolreprcifTable, i : Int, v : Double) -> ChemmolreprcifTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_table_sum(s : ChemmolreprcifTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_table_mean(s : ChemmolreprcifTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_table_scale(s : ChemmolreprcifTable, f : Double) -> ChemmolreprcifTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_table_add(a : ChemmolreprcifTable, b : ChemmolreprcifTable) -> ChemmolreprcifTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_table_copy(s : ChemmolreprcifTable) -> ChemmolreprcifTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_table_fill(s : ChemmolreprcifTable, v : Double) -> ChemmolreprcifTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_table_min(s : ChemmolreprcifTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_table_max(s : ChemmolreprcifTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_table_to_string(s : ChemmolreprcifTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_graphn_make(size : Int) -> ChemmolreprcifGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_graphn_len(s : ChemmolreprcifGraphN) -> Int { s.size }

pub fn chem_mol_repr_cif_graphn_get(s : ChemmolreprcifGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_graphn_set(s : ChemmolreprcifGraphN, i : Int, v : Double) -> ChemmolreprcifGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_graphn_sum(s : ChemmolreprcifGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_graphn_mean(s : ChemmolreprcifGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_graphn_scale(s : ChemmolreprcifGraphN, f : Double) -> ChemmolreprcifGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_graphn_add(a : ChemmolreprcifGraphN, b : ChemmolreprcifGraphN) -> ChemmolreprcifGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_graphn_copy(s : ChemmolreprcifGraphN) -> ChemmolreprcifGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_graphn_fill(s : ChemmolreprcifGraphN, v : Double) -> ChemmolreprcifGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_graphn_min(s : ChemmolreprcifGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_graphn_max(s : ChemmolreprcifGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_graphn_to_string(s : ChemmolreprcifGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_node_make(size : Int) -> ChemmolreprcifNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_node_len(s : ChemmolreprcifNode) -> Int { s.size }

pub fn chem_mol_repr_cif_node_get(s : ChemmolreprcifNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_node_set(s : ChemmolreprcifNode, i : Int, v : Double) -> ChemmolreprcifNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_node_sum(s : ChemmolreprcifNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_node_mean(s : ChemmolreprcifNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_node_scale(s : ChemmolreprcifNode, f : Double) -> ChemmolreprcifNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_node_add(a : ChemmolreprcifNode, b : ChemmolreprcifNode) -> ChemmolreprcifNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_node_copy(s : ChemmolreprcifNode) -> ChemmolreprcifNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_node_fill(s : ChemmolreprcifNode, v : Double) -> ChemmolreprcifNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_node_min(s : ChemmolreprcifNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_node_max(s : ChemmolreprcifNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_node_to_string(s : ChemmolreprcifNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_edge_make(size : Int) -> ChemmolreprcifEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_edge_len(s : ChemmolreprcifEdge) -> Int { s.size }

pub fn chem_mol_repr_cif_edge_get(s : ChemmolreprcifEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_edge_set(s : ChemmolreprcifEdge, i : Int, v : Double) -> ChemmolreprcifEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_edge_sum(s : ChemmolreprcifEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_edge_mean(s : ChemmolreprcifEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_edge_scale(s : ChemmolreprcifEdge, f : Double) -> ChemmolreprcifEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_edge_add(a : ChemmolreprcifEdge, b : ChemmolreprcifEdge) -> ChemmolreprcifEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_edge_copy(s : ChemmolreprcifEdge) -> ChemmolreprcifEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_edge_fill(s : ChemmolreprcifEdge, v : Double) -> ChemmolreprcifEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_edge_min(s : ChemmolreprcifEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_edge_max(s : ChemmolreprcifEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_edge_to_string(s : ChemmolreprcifEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_path_make(size : Int) -> ChemmolreprcifPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_path_len(s : ChemmolreprcifPath) -> Int { s.size }

pub fn chem_mol_repr_cif_path_get(s : ChemmolreprcifPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_path_set(s : ChemmolreprcifPath, i : Int, v : Double) -> ChemmolreprcifPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_path_sum(s : ChemmolreprcifPath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_path_mean(s : ChemmolreprcifPath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_path_scale(s : ChemmolreprcifPath, f : Double) -> ChemmolreprcifPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_path_add(a : ChemmolreprcifPath, b : ChemmolreprcifPath) -> ChemmolreprcifPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_path_copy(s : ChemmolreprcifPath) -> ChemmolreprcifPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_path_fill(s : ChemmolreprcifPath, v : Double) -> ChemmolreprcifPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_path_min(s : ChemmolreprcifPath) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_path_max(s : ChemmolreprcifPath) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_path_to_string(s : ChemmolreprcifPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_cluster_make(size : Int) -> ChemmolreprcifCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_cluster_len(s : ChemmolreprcifCluster) -> Int { s.size }

pub fn chem_mol_repr_cif_cluster_get(s : ChemmolreprcifCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_cluster_set(s : ChemmolreprcifCluster, i : Int, v : Double) -> ChemmolreprcifCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_cluster_sum(s : ChemmolreprcifCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_cluster_mean(s : ChemmolreprcifCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_cluster_scale(s : ChemmolreprcifCluster, f : Double) -> ChemmolreprcifCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_cluster_add(a : ChemmolreprcifCluster, b : ChemmolreprcifCluster) -> ChemmolreprcifCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_cluster_copy(s : ChemmolreprcifCluster) -> ChemmolreprcifCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_cluster_fill(s : ChemmolreprcifCluster, v : Double) -> ChemmolreprcifCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_cluster_min(s : ChemmolreprcifCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_cluster_max(s : ChemmolreprcifCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_cluster_to_string(s : ChemmolreprcifCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_model_make(size : Int) -> ChemmolreprcifModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_model_len(s : ChemmolreprcifModel) -> Int { s.size }

pub fn chem_mol_repr_cif_model_get(s : ChemmolreprcifModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_model_set(s : ChemmolreprcifModel, i : Int, v : Double) -> ChemmolreprcifModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_model_sum(s : ChemmolreprcifModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_model_mean(s : ChemmolreprcifModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_model_scale(s : ChemmolreprcifModel, f : Double) -> ChemmolreprcifModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_model_add(a : ChemmolreprcifModel, b : ChemmolreprcifModel) -> ChemmolreprcifModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_model_copy(s : ChemmolreprcifModel) -> ChemmolreprcifModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_model_fill(s : ChemmolreprcifModel, v : Double) -> ChemmolreprcifModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_model_min(s : ChemmolreprcifModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_model_max(s : ChemmolreprcifModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_model_to_string(s : ChemmolreprcifModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_layer_make(size : Int) -> ChemmolreprcifLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_layer_len(s : ChemmolreprcifLayer) -> Int { s.size }

pub fn chem_mol_repr_cif_layer_get(s : ChemmolreprcifLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_layer_set(s : ChemmolreprcifLayer, i : Int, v : Double) -> ChemmolreprcifLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_layer_sum(s : ChemmolreprcifLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_layer_mean(s : ChemmolreprcifLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_layer_scale(s : ChemmolreprcifLayer, f : Double) -> ChemmolreprcifLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_layer_add(a : ChemmolreprcifLayer, b : ChemmolreprcifLayer) -> ChemmolreprcifLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_layer_copy(s : ChemmolreprcifLayer) -> ChemmolreprcifLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_layer_fill(s : ChemmolreprcifLayer, v : Double) -> ChemmolreprcifLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_layer_min(s : ChemmolreprcifLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_layer_max(s : ChemmolreprcifLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_layer_to_string(s : ChemmolreprcifLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_buffer_make(size : Int) -> ChemmolreprcifBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_buffer_len(s : ChemmolreprcifBuffer) -> Int { s.size }

pub fn chem_mol_repr_cif_buffer_get(s : ChemmolreprcifBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_buffer_set(s : ChemmolreprcifBuffer, i : Int, v : Double) -> ChemmolreprcifBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_buffer_sum(s : ChemmolreprcifBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_buffer_mean(s : ChemmolreprcifBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_buffer_scale(s : ChemmolreprcifBuffer, f : Double) -> ChemmolreprcifBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_buffer_add(a : ChemmolreprcifBuffer, b : ChemmolreprcifBuffer) -> ChemmolreprcifBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_buffer_copy(s : ChemmolreprcifBuffer) -> ChemmolreprcifBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_buffer_fill(s : ChemmolreprcifBuffer, v : Double) -> ChemmolreprcifBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_buffer_min(s : ChemmolreprcifBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_buffer_max(s : ChemmolreprcifBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_buffer_to_string(s : ChemmolreprcifBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_cursor_make(size : Int) -> ChemmolreprcifCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_cursor_len(s : ChemmolreprcifCursor) -> Int { s.size }

pub fn chem_mol_repr_cif_cursor_get(s : ChemmolreprcifCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_cursor_set(s : ChemmolreprcifCursor, i : Int, v : Double) -> ChemmolreprcifCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_cursor_sum(s : ChemmolreprcifCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_cursor_mean(s : ChemmolreprcifCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_cursor_scale(s : ChemmolreprcifCursor, f : Double) -> ChemmolreprcifCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_cursor_add(a : ChemmolreprcifCursor, b : ChemmolreprcifCursor) -> ChemmolreprcifCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_cursor_copy(s : ChemmolreprcifCursor) -> ChemmolreprcifCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_cursor_fill(s : ChemmolreprcifCursor, v : Double) -> ChemmolreprcifCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_cursor_min(s : ChemmolreprcifCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_cursor_max(s : ChemmolreprcifCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_cursor_to_string(s : ChemmolreprcifCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_view_make(size : Int) -> ChemmolreprcifView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_view_len(s : ChemmolreprcifView) -> Int { s.size }

pub fn chem_mol_repr_cif_view_get(s : ChemmolreprcifView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_view_set(s : ChemmolreprcifView, i : Int, v : Double) -> ChemmolreprcifView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_view_sum(s : ChemmolreprcifView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_view_mean(s : ChemmolreprcifView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_view_scale(s : ChemmolreprcifView, f : Double) -> ChemmolreprcifView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_view_add(a : ChemmolreprcifView, b : ChemmolreprcifView) -> ChemmolreprcifView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_view_copy(s : ChemmolreprcifView) -> ChemmolreprcifView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_view_fill(s : ChemmolreprcifView, v : Double) -> ChemmolreprcifView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_view_min(s : ChemmolreprcifView) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_view_max(s : ChemmolreprcifView) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_view_to_string(s : ChemmolreprcifView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_range_make(size : Int) -> ChemmolreprcifRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_range_len(s : ChemmolreprcifRange) -> Int { s.size }

pub fn chem_mol_repr_cif_range_get(s : ChemmolreprcifRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_range_set(s : ChemmolreprcifRange, i : Int, v : Double) -> ChemmolreprcifRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_range_sum(s : ChemmolreprcifRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_range_mean(s : ChemmolreprcifRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_range_scale(s : ChemmolreprcifRange, f : Double) -> ChemmolreprcifRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_range_add(a : ChemmolreprcifRange, b : ChemmolreprcifRange) -> ChemmolreprcifRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_range_copy(s : ChemmolreprcifRange) -> ChemmolreprcifRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_range_fill(s : ChemmolreprcifRange, v : Double) -> ChemmolreprcifRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_range_min(s : ChemmolreprcifRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_range_max(s : ChemmolreprcifRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_range_to_string(s : ChemmolreprcifRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_slice_make(size : Int) -> ChemmolreprcifSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_slice_len(s : ChemmolreprcifSlice) -> Int { s.size }

pub fn chem_mol_repr_cif_slice_get(s : ChemmolreprcifSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_slice_set(s : ChemmolreprcifSlice, i : Int, v : Double) -> ChemmolreprcifSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_slice_sum(s : ChemmolreprcifSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_cif_slice_mean(s : ChemmolreprcifSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_cif_slice_scale(s : ChemmolreprcifSlice, f : Double) -> ChemmolreprcifSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_slice_add(a : ChemmolreprcifSlice, b : ChemmolreprcifSlice) -> ChemmolreprcifSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_cif_slice_copy(s : ChemmolreprcifSlice) -> ChemmolreprcifSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_slice_fill(s : ChemmolreprcifSlice, v : Double) -> ChemmolreprcifSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_cif_slice_min(s : ChemmolreprcifSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_cif_slice_max(s : ChemmolreprcifSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_cif_slice_to_string(s : ChemmolreprcifSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

