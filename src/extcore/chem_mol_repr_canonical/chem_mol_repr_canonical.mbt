///===
/// extcore/chem_mol_repr_canonical

pub(all) struct ChemmolreprcanonicalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_repr_canonical_make_point(x : Double, y : Double) -> ChemmolreprcanonicalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_repr_canonical_make_point3(x : Double, y : Double, z : Double) -> ChemmolreprcanonicalPoint {
  { x, y, z, label: 0 }
}

pub fn chem_mol_repr_canonical_point_x(pt : ChemmolreprcanonicalPoint) -> Double { pt.x }

pub fn chem_mol_repr_canonical_point_y(pt : ChemmolreprcanonicalPoint) -> Double { pt.y }

pub fn chem_mol_repr_canonical_point_z(pt : ChemmolreprcanonicalPoint) -> Double { pt.z }

pub fn chem_mol_repr_canonical_point_label(pt : ChemmolreprcanonicalPoint) -> Int { pt.label }

pub fn chem_mol_repr_canonical_point_dist(a : ChemmolreprcanonicalPoint, b : ChemmolreprcanonicalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_mol_repr_canonical_point_add(a : ChemmolreprcanonicalPoint, b : ChemmolreprcanonicalPoint) -> ChemmolreprcanonicalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_mol_repr_canonical_point_sub(a : ChemmolreprcanonicalPoint, b : ChemmolreprcanonicalPoint) -> ChemmolreprcanonicalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_mol_repr_canonical_point_scale(pt : ChemmolreprcanonicalPoint, s : Double) -> ChemmolreprcanonicalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_mol_repr_canonical_point_dot(a : ChemmolreprcanonicalPoint, b : ChemmolreprcanonicalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_mol_repr_canonical_point_cross(a : ChemmolreprcanonicalPoint, b : ChemmolreprcanonicalPoint) -> ChemmolreprcanonicalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_mol_repr_canonical_point_norm(pt : ChemmolreprcanonicalPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_mol_repr_canonical_point_normalize(pt : ChemmolreprcanonicalPoint) -> ChemmolreprcanonicalPoint {
  let n = chem_mol_repr_canonical_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_mol_repr_canonical_point_scale(pt, 1.0 / n) }
}

pub fn chem_mol_repr_canonical_point_negate(pt : ChemmolreprcanonicalPoint) -> ChemmolreprcanonicalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_mol_repr_canonical_point_mid(a : ChemmolreprcanonicalPoint, b : ChemmolreprcanonicalPoint) -> ChemmolreprcanonicalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_mol_repr_canonical_point_lerp(a : ChemmolreprcanonicalPoint, b : ChemmolreprcanonicalPoint, t : Double) -> ChemmolreprcanonicalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_mol_repr_canonical_point_to_string(pt : ChemmolreprcanonicalPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_repr_canonical_make_series(vals : Array[Double], name : String) -> ChemmolreprcanonicalSeries {
  { vals, name, meta: 0 }
}

pub fn chem_mol_repr_canonical_series_len(s : ChemmolreprcanonicalSeries) -> Int { s.vals.length() }

pub fn chem_mol_repr_canonical_series_sum(s : ChemmolreprcanonicalSeries) -> Double { @_common.sum(s.vals) }

pub fn chem_mol_repr_canonical_series_mean(s : ChemmolreprcanonicalSeries) -> Double { @_common.mean(s.vals) }

pub fn chem_mol_repr_canonical_series_min(s : ChemmolreprcanonicalSeries) -> Double { @_common.min(s.vals) }

pub fn chem_mol_repr_canonical_series_max(s : ChemmolreprcanonicalSeries) -> Double { @_common.max(s.vals) }

pub fn chem_mol_repr_canonical_series_range(s : ChemmolreprcanonicalSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn chem_mol_repr_canonical_series_var(s : ChemmolreprcanonicalSeries) -> Double { @_common.variance(s.vals) }

pub fn chem_mol_repr_canonical_series_std(s : ChemmolreprcanonicalSeries) -> Double { @_common.std(s.vals) }

pub fn chem_mol_repr_canonical_series_median(s : ChemmolreprcanonicalSeries) -> Double { @_common.median(s.vals) }

pub fn chem_mol_repr_canonical_series_scale(s : ChemmolreprcanonicalSeries, f : Double) -> ChemmolreprcanonicalSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn chem_mol_repr_canonical_series_add(a : ChemmolreprcanonicalSeries, b : ChemmolreprcanonicalSeries) -> ChemmolreprcanonicalSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_mol_repr_canonical_series_sub(a : ChemmolreprcanonicalSeries, b : ChemmolreprcanonicalSeries) -> ChemmolreprcanonicalSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_mol_repr_canonical_series_normalize(s : ChemmolreprcanonicalSeries) -> ChemmolreprcanonicalSeries {
  let mn = chem_mol_repr_canonical_series_min(s)
  let mx = chem_mol_repr_canonical_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_mol_repr_canonical_series_cumsum(s : ChemmolreprcanonicalSeries) -> ChemmolreprcanonicalSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_mol_repr_canonical_series_to_string(s : ChemmolreprcanonicalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprcanonicalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_repr_canonical_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolreprcanonicalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_repr_canonical_matrix_identity(n : Int) -> ChemmolreprcanonicalMatrix {
  let m = chem_mol_repr_canonical_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_mol_repr_canonical_matrix_get(m : ChemmolreprcanonicalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_mol_repr_canonical_matrix_transpose(m : ChemmolreprcanonicalMatrix) -> ChemmolreprcanonicalMatrix {
  let result = chem_mol_repr_canonical_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_mol_repr_canonical_matrix_add(a : ChemmolreprcanonicalMatrix, b : ChemmolreprcanonicalMatrix) -> ChemmolreprcanonicalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_mol_repr_canonical_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_mol_repr_canonical_matrix_scale(m : ChemmolreprcanonicalMatrix, s : Double) -> ChemmolreprcanonicalMatrix {
  let result = chem_mol_repr_canonical_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_mol_repr_canonical_matrix_multiply(a : ChemmolreprcanonicalMatrix, b : ChemmolreprcanonicalMatrix) -> ChemmolreprcanonicalMatrix {
  if a.cols != b.rows { return chem_mol_repr_canonical_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_mol_repr_canonical_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_mol_repr_canonical_matrix_trace(m : ChemmolreprcanonicalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_mol_repr_canonical_matrix_det(m : ChemmolreprcanonicalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_mol_repr_canonical_matrix_norm(m : ChemmolreprcanonicalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_mol_repr_canonical_matrix_to_string(m : ChemmolreprcanonicalMatrix) -> String {
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

pub(all) struct ChemmolreprcanonicalVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_repr_canonical_make_vector(comps : Array[Double]) -> ChemmolreprcanonicalVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_repr_canonical_vector_zero(dim : Int) -> ChemmolreprcanonicalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_mol_repr_canonical_vector_add(a : ChemmolreprcanonicalVector, b : ChemmolreprcanonicalVector) -> ChemmolreprcanonicalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn chem_mol_repr_canonical_vector_sub(a : ChemmolreprcanonicalVector, b : ChemmolreprcanonicalVector) -> ChemmolreprcanonicalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn chem_mol_repr_canonical_vector_scale(v : ChemmolreprcanonicalVector, s : Double) -> ChemmolreprcanonicalVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn chem_mol_repr_canonical_vector_dot(a : ChemmolreprcanonicalVector, b : ChemmolreprcanonicalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_mol_repr_canonical_vector_norm(v : ChemmolreprcanonicalVector) -> Double { @_common.sqrt(chem_mol_repr_canonical_vector_dot(v, v)) }

pub fn chem_mol_repr_canonical_vector_normalize(v : ChemmolreprcanonicalVector) -> ChemmolreprcanonicalVector {
  let n = chem_mol_repr_canonical_vector_norm(v)
  if n < 0.0000001 { v } else { chem_mol_repr_canonical_vector_scale(v, 1.0 / n) }
}

pub fn chem_mol_repr_canonical_vector_dist(a : ChemmolreprcanonicalVector, b : ChemmolreprcanonicalVector) -> Double {
  chem_mol_repr_canonical_vector_norm(chem_mol_repr_canonical_vector_sub(a, b))
}

pub fn chem_mol_repr_canonical_vector_to_string(v : ChemmolreprcanonicalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_repr_canonical_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_repr_canonical_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_repr_canonical_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_repr_canonical_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_repr_canonical_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_repr_canonical_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_repr_canonical_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_repr_canonical_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_repr_canonical_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_repr_canonical_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_repr_canonical_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_repr_canonical_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_repr_canonical_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_repr_canonical_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_repr_canonical_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_repr_canonical_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_repr_canonical_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_repr_canonical_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_repr_canonical_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_repr_canonical_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_repr_canonical_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_repr_canonical_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_repr_canonical_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_repr_canonical_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_repr_canonical_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_repr_canonical_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_repr_canonical_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_repr_canonical_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_repr_canonical_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolreprcanonicalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_frame_make(size : Int) -> ChemmolreprcanonicalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_frame_len(s : ChemmolreprcanonicalFrame) -> Int { s.size }

pub fn chem_mol_repr_canonical_frame_get(s : ChemmolreprcanonicalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_frame_set(s : ChemmolreprcanonicalFrame, i : Int, v : Double) -> ChemmolreprcanonicalFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_frame_sum(s : ChemmolreprcanonicalFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_canonical_frame_mean(s : ChemmolreprcanonicalFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_canonical_frame_scale(s : ChemmolreprcanonicalFrame, f : Double) -> ChemmolreprcanonicalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_frame_add(a : ChemmolreprcanonicalFrame, b : ChemmolreprcanonicalFrame) -> ChemmolreprcanonicalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_canonical_frame_copy(s : ChemmolreprcanonicalFrame) -> ChemmolreprcanonicalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_frame_fill(s : ChemmolreprcanonicalFrame, v : Double) -> ChemmolreprcanonicalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_frame_min(s : ChemmolreprcanonicalFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_canonical_frame_max(s : ChemmolreprcanonicalFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_canonical_frame_to_string(s : ChemmolreprcanonicalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_table_make(size : Int) -> ChemmolreprcanonicalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_table_len(s : ChemmolreprcanonicalTable) -> Int { s.size }

pub fn chem_mol_repr_canonical_table_get(s : ChemmolreprcanonicalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_table_set(s : ChemmolreprcanonicalTable, i : Int, v : Double) -> ChemmolreprcanonicalTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_table_sum(s : ChemmolreprcanonicalTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_canonical_table_mean(s : ChemmolreprcanonicalTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_canonical_table_scale(s : ChemmolreprcanonicalTable, f : Double) -> ChemmolreprcanonicalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_table_add(a : ChemmolreprcanonicalTable, b : ChemmolreprcanonicalTable) -> ChemmolreprcanonicalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_canonical_table_copy(s : ChemmolreprcanonicalTable) -> ChemmolreprcanonicalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_table_fill(s : ChemmolreprcanonicalTable, v : Double) -> ChemmolreprcanonicalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_table_min(s : ChemmolreprcanonicalTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_canonical_table_max(s : ChemmolreprcanonicalTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_canonical_table_to_string(s : ChemmolreprcanonicalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_graphn_make(size : Int) -> ChemmolreprcanonicalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_graphn_len(s : ChemmolreprcanonicalGraphN) -> Int { s.size }

pub fn chem_mol_repr_canonical_graphn_get(s : ChemmolreprcanonicalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_graphn_set(s : ChemmolreprcanonicalGraphN, i : Int, v : Double) -> ChemmolreprcanonicalGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_graphn_sum(s : ChemmolreprcanonicalGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_canonical_graphn_mean(s : ChemmolreprcanonicalGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_canonical_graphn_scale(s : ChemmolreprcanonicalGraphN, f : Double) -> ChemmolreprcanonicalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_graphn_add(a : ChemmolreprcanonicalGraphN, b : ChemmolreprcanonicalGraphN) -> ChemmolreprcanonicalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_canonical_graphn_copy(s : ChemmolreprcanonicalGraphN) -> ChemmolreprcanonicalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_graphn_fill(s : ChemmolreprcanonicalGraphN, v : Double) -> ChemmolreprcanonicalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_graphn_min(s : ChemmolreprcanonicalGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_canonical_graphn_max(s : ChemmolreprcanonicalGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_canonical_graphn_to_string(s : ChemmolreprcanonicalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_node_make(size : Int) -> ChemmolreprcanonicalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_node_len(s : ChemmolreprcanonicalNode) -> Int { s.size }

pub fn chem_mol_repr_canonical_node_get(s : ChemmolreprcanonicalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_node_set(s : ChemmolreprcanonicalNode, i : Int, v : Double) -> ChemmolreprcanonicalNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_node_sum(s : ChemmolreprcanonicalNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_canonical_node_mean(s : ChemmolreprcanonicalNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_canonical_node_scale(s : ChemmolreprcanonicalNode, f : Double) -> ChemmolreprcanonicalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_node_add(a : ChemmolreprcanonicalNode, b : ChemmolreprcanonicalNode) -> ChemmolreprcanonicalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_canonical_node_copy(s : ChemmolreprcanonicalNode) -> ChemmolreprcanonicalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_node_fill(s : ChemmolreprcanonicalNode, v : Double) -> ChemmolreprcanonicalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_node_min(s : ChemmolreprcanonicalNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_canonical_node_max(s : ChemmolreprcanonicalNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_canonical_node_to_string(s : ChemmolreprcanonicalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_edge_make(size : Int) -> ChemmolreprcanonicalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_edge_len(s : ChemmolreprcanonicalEdge) -> Int { s.size }

pub fn chem_mol_repr_canonical_edge_get(s : ChemmolreprcanonicalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_edge_set(s : ChemmolreprcanonicalEdge, i : Int, v : Double) -> ChemmolreprcanonicalEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_edge_sum(s : ChemmolreprcanonicalEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_canonical_edge_mean(s : ChemmolreprcanonicalEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_canonical_edge_scale(s : ChemmolreprcanonicalEdge, f : Double) -> ChemmolreprcanonicalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_edge_add(a : ChemmolreprcanonicalEdge, b : ChemmolreprcanonicalEdge) -> ChemmolreprcanonicalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_canonical_edge_copy(s : ChemmolreprcanonicalEdge) -> ChemmolreprcanonicalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_edge_fill(s : ChemmolreprcanonicalEdge, v : Double) -> ChemmolreprcanonicalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_edge_min(s : ChemmolreprcanonicalEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_canonical_edge_max(s : ChemmolreprcanonicalEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_canonical_edge_to_string(s : ChemmolreprcanonicalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_path_make(size : Int) -> ChemmolreprcanonicalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_path_len(s : ChemmolreprcanonicalPath) -> Int { s.size }

pub fn chem_mol_repr_canonical_path_get(s : ChemmolreprcanonicalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_path_set(s : ChemmolreprcanonicalPath, i : Int, v : Double) -> ChemmolreprcanonicalPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_path_sum(s : ChemmolreprcanonicalPath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_canonical_path_mean(s : ChemmolreprcanonicalPath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_canonical_path_scale(s : ChemmolreprcanonicalPath, f : Double) -> ChemmolreprcanonicalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_path_add(a : ChemmolreprcanonicalPath, b : ChemmolreprcanonicalPath) -> ChemmolreprcanonicalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_canonical_path_copy(s : ChemmolreprcanonicalPath) -> ChemmolreprcanonicalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_path_fill(s : ChemmolreprcanonicalPath, v : Double) -> ChemmolreprcanonicalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_path_min(s : ChemmolreprcanonicalPath) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_canonical_path_max(s : ChemmolreprcanonicalPath) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_canonical_path_to_string(s : ChemmolreprcanonicalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_cluster_make(size : Int) -> ChemmolreprcanonicalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_cluster_len(s : ChemmolreprcanonicalCluster) -> Int { s.size }

pub fn chem_mol_repr_canonical_cluster_get(s : ChemmolreprcanonicalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_cluster_set(s : ChemmolreprcanonicalCluster, i : Int, v : Double) -> ChemmolreprcanonicalCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_cluster_sum(s : ChemmolreprcanonicalCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_canonical_cluster_mean(s : ChemmolreprcanonicalCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_canonical_cluster_scale(s : ChemmolreprcanonicalCluster, f : Double) -> ChemmolreprcanonicalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_cluster_add(a : ChemmolreprcanonicalCluster, b : ChemmolreprcanonicalCluster) -> ChemmolreprcanonicalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_canonical_cluster_copy(s : ChemmolreprcanonicalCluster) -> ChemmolreprcanonicalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_cluster_fill(s : ChemmolreprcanonicalCluster, v : Double) -> ChemmolreprcanonicalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_cluster_min(s : ChemmolreprcanonicalCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_canonical_cluster_max(s : ChemmolreprcanonicalCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_canonical_cluster_to_string(s : ChemmolreprcanonicalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_model_make(size : Int) -> ChemmolreprcanonicalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_model_len(s : ChemmolreprcanonicalModel) -> Int { s.size }

pub fn chem_mol_repr_canonical_model_get(s : ChemmolreprcanonicalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_model_set(s : ChemmolreprcanonicalModel, i : Int, v : Double) -> ChemmolreprcanonicalModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_model_sum(s : ChemmolreprcanonicalModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_canonical_model_mean(s : ChemmolreprcanonicalModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_canonical_model_scale(s : ChemmolreprcanonicalModel, f : Double) -> ChemmolreprcanonicalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_model_add(a : ChemmolreprcanonicalModel, b : ChemmolreprcanonicalModel) -> ChemmolreprcanonicalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_canonical_model_copy(s : ChemmolreprcanonicalModel) -> ChemmolreprcanonicalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_model_fill(s : ChemmolreprcanonicalModel, v : Double) -> ChemmolreprcanonicalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_model_min(s : ChemmolreprcanonicalModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_canonical_model_max(s : ChemmolreprcanonicalModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_canonical_model_to_string(s : ChemmolreprcanonicalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_layer_make(size : Int) -> ChemmolreprcanonicalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_layer_len(s : ChemmolreprcanonicalLayer) -> Int { s.size }

pub fn chem_mol_repr_canonical_layer_get(s : ChemmolreprcanonicalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_layer_set(s : ChemmolreprcanonicalLayer, i : Int, v : Double) -> ChemmolreprcanonicalLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_layer_sum(s : ChemmolreprcanonicalLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_canonical_layer_mean(s : ChemmolreprcanonicalLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_canonical_layer_scale(s : ChemmolreprcanonicalLayer, f : Double) -> ChemmolreprcanonicalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_layer_add(a : ChemmolreprcanonicalLayer, b : ChemmolreprcanonicalLayer) -> ChemmolreprcanonicalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_canonical_layer_copy(s : ChemmolreprcanonicalLayer) -> ChemmolreprcanonicalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_layer_fill(s : ChemmolreprcanonicalLayer, v : Double) -> ChemmolreprcanonicalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_layer_min(s : ChemmolreprcanonicalLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_canonical_layer_max(s : ChemmolreprcanonicalLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_canonical_layer_to_string(s : ChemmolreprcanonicalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_buffer_make(size : Int) -> ChemmolreprcanonicalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_buffer_len(s : ChemmolreprcanonicalBuffer) -> Int { s.size }

pub fn chem_mol_repr_canonical_buffer_get(s : ChemmolreprcanonicalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_buffer_set(s : ChemmolreprcanonicalBuffer, i : Int, v : Double) -> ChemmolreprcanonicalBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_buffer_sum(s : ChemmolreprcanonicalBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_canonical_buffer_mean(s : ChemmolreprcanonicalBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_canonical_buffer_scale(s : ChemmolreprcanonicalBuffer, f : Double) -> ChemmolreprcanonicalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_buffer_add(a : ChemmolreprcanonicalBuffer, b : ChemmolreprcanonicalBuffer) -> ChemmolreprcanonicalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_canonical_buffer_copy(s : ChemmolreprcanonicalBuffer) -> ChemmolreprcanonicalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_buffer_fill(s : ChemmolreprcanonicalBuffer, v : Double) -> ChemmolreprcanonicalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_buffer_min(s : ChemmolreprcanonicalBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_canonical_buffer_max(s : ChemmolreprcanonicalBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_canonical_buffer_to_string(s : ChemmolreprcanonicalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_cursor_make(size : Int) -> ChemmolreprcanonicalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_cursor_len(s : ChemmolreprcanonicalCursor) -> Int { s.size }

pub fn chem_mol_repr_canonical_cursor_get(s : ChemmolreprcanonicalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_cursor_set(s : ChemmolreprcanonicalCursor, i : Int, v : Double) -> ChemmolreprcanonicalCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_cursor_sum(s : ChemmolreprcanonicalCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_canonical_cursor_mean(s : ChemmolreprcanonicalCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_canonical_cursor_scale(s : ChemmolreprcanonicalCursor, f : Double) -> ChemmolreprcanonicalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_cursor_add(a : ChemmolreprcanonicalCursor, b : ChemmolreprcanonicalCursor) -> ChemmolreprcanonicalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_canonical_cursor_copy(s : ChemmolreprcanonicalCursor) -> ChemmolreprcanonicalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_cursor_fill(s : ChemmolreprcanonicalCursor, v : Double) -> ChemmolreprcanonicalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_cursor_min(s : ChemmolreprcanonicalCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_canonical_cursor_max(s : ChemmolreprcanonicalCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_canonical_cursor_to_string(s : ChemmolreprcanonicalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_view_make(size : Int) -> ChemmolreprcanonicalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_view_len(s : ChemmolreprcanonicalView) -> Int { s.size }

pub fn chem_mol_repr_canonical_view_get(s : ChemmolreprcanonicalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_view_set(s : ChemmolreprcanonicalView, i : Int, v : Double) -> ChemmolreprcanonicalView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_view_sum(s : ChemmolreprcanonicalView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_canonical_view_mean(s : ChemmolreprcanonicalView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_canonical_view_scale(s : ChemmolreprcanonicalView, f : Double) -> ChemmolreprcanonicalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_view_add(a : ChemmolreprcanonicalView, b : ChemmolreprcanonicalView) -> ChemmolreprcanonicalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_canonical_view_copy(s : ChemmolreprcanonicalView) -> ChemmolreprcanonicalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_view_fill(s : ChemmolreprcanonicalView, v : Double) -> ChemmolreprcanonicalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_view_min(s : ChemmolreprcanonicalView) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_canonical_view_max(s : ChemmolreprcanonicalView) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_canonical_view_to_string(s : ChemmolreprcanonicalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_range_make(size : Int) -> ChemmolreprcanonicalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_range_len(s : ChemmolreprcanonicalRange) -> Int { s.size }

pub fn chem_mol_repr_canonical_range_get(s : ChemmolreprcanonicalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_range_set(s : ChemmolreprcanonicalRange, i : Int, v : Double) -> ChemmolreprcanonicalRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_range_sum(s : ChemmolreprcanonicalRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_canonical_range_mean(s : ChemmolreprcanonicalRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_canonical_range_scale(s : ChemmolreprcanonicalRange, f : Double) -> ChemmolreprcanonicalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_range_add(a : ChemmolreprcanonicalRange, b : ChemmolreprcanonicalRange) -> ChemmolreprcanonicalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_canonical_range_copy(s : ChemmolreprcanonicalRange) -> ChemmolreprcanonicalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_range_fill(s : ChemmolreprcanonicalRange, v : Double) -> ChemmolreprcanonicalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_range_min(s : ChemmolreprcanonicalRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_canonical_range_max(s : ChemmolreprcanonicalRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_canonical_range_to_string(s : ChemmolreprcanonicalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_slice_make(size : Int) -> ChemmolreprcanonicalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_slice_len(s : ChemmolreprcanonicalSlice) -> Int { s.size }

pub fn chem_mol_repr_canonical_slice_get(s : ChemmolreprcanonicalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_slice_set(s : ChemmolreprcanonicalSlice, i : Int, v : Double) -> ChemmolreprcanonicalSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_slice_sum(s : ChemmolreprcanonicalSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_canonical_slice_mean(s : ChemmolreprcanonicalSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_canonical_slice_scale(s : ChemmolreprcanonicalSlice, f : Double) -> ChemmolreprcanonicalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_slice_add(a : ChemmolreprcanonicalSlice, b : ChemmolreprcanonicalSlice) -> ChemmolreprcanonicalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_canonical_slice_copy(s : ChemmolreprcanonicalSlice) -> ChemmolreprcanonicalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_slice_fill(s : ChemmolreprcanonicalSlice, v : Double) -> ChemmolreprcanonicalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_canonical_slice_min(s : ChemmolreprcanonicalSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_canonical_slice_max(s : ChemmolreprcanonicalSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_canonical_slice_to_string(s : ChemmolreprcanonicalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

