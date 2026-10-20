///===
/// extcore/chem_mol_repr_smiles

pub(all) struct ChemmolreprsmilesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_repr_smiles_make_point(x : Double, y : Double) -> ChemmolreprsmilesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_repr_smiles_make_point3(x : Double, y : Double, z : Double) -> ChemmolreprsmilesPoint {
  { x, y, z, label: 0 }
}

pub fn chem_mol_repr_smiles_point_x(pt : ChemmolreprsmilesPoint) -> Double { pt.x }

pub fn chem_mol_repr_smiles_point_y(pt : ChemmolreprsmilesPoint) -> Double { pt.y }

pub fn chem_mol_repr_smiles_point_z(pt : ChemmolreprsmilesPoint) -> Double { pt.z }

pub fn chem_mol_repr_smiles_point_label(pt : ChemmolreprsmilesPoint) -> Int { pt.label }

pub fn chem_mol_repr_smiles_point_dist(a : ChemmolreprsmilesPoint, b : ChemmolreprsmilesPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_mol_repr_smiles_point_add(a : ChemmolreprsmilesPoint, b : ChemmolreprsmilesPoint) -> ChemmolreprsmilesPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_mol_repr_smiles_point_sub(a : ChemmolreprsmilesPoint, b : ChemmolreprsmilesPoint) -> ChemmolreprsmilesPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_mol_repr_smiles_point_scale(pt : ChemmolreprsmilesPoint, s : Double) -> ChemmolreprsmilesPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_mol_repr_smiles_point_dot(a : ChemmolreprsmilesPoint, b : ChemmolreprsmilesPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_mol_repr_smiles_point_cross(a : ChemmolreprsmilesPoint, b : ChemmolreprsmilesPoint) -> ChemmolreprsmilesPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_mol_repr_smiles_point_norm(pt : ChemmolreprsmilesPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_mol_repr_smiles_point_normalize(pt : ChemmolreprsmilesPoint) -> ChemmolreprsmilesPoint {
  let n = chem_mol_repr_smiles_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_mol_repr_smiles_point_scale(pt, 1.0 / n) }
}

pub fn chem_mol_repr_smiles_point_negate(pt : ChemmolreprsmilesPoint) -> ChemmolreprsmilesPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_mol_repr_smiles_point_mid(a : ChemmolreprsmilesPoint, b : ChemmolreprsmilesPoint) -> ChemmolreprsmilesPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_mol_repr_smiles_point_lerp(a : ChemmolreprsmilesPoint, b : ChemmolreprsmilesPoint, t : Double) -> ChemmolreprsmilesPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_mol_repr_smiles_point_to_string(pt : ChemmolreprsmilesPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_repr_smiles_make_series(vals : Array[Double], name : String) -> ChemmolreprsmilesSeries {
  { vals, name, meta: 0 }
}

pub fn chem_mol_repr_smiles_series_len(s : ChemmolreprsmilesSeries) -> Int { s.vals.length() }

pub fn chem_mol_repr_smiles_series_sum(s : ChemmolreprsmilesSeries) -> Double { @_common.sum(s.vals) }

pub fn chem_mol_repr_smiles_series_mean(s : ChemmolreprsmilesSeries) -> Double { @_common.mean(s.vals) }

pub fn chem_mol_repr_smiles_series_min(s : ChemmolreprsmilesSeries) -> Double { @_common.min(s.vals) }

pub fn chem_mol_repr_smiles_series_max(s : ChemmolreprsmilesSeries) -> Double { @_common.max(s.vals) }

pub fn chem_mol_repr_smiles_series_range(s : ChemmolreprsmilesSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn chem_mol_repr_smiles_series_var(s : ChemmolreprsmilesSeries) -> Double { @_common.variance(s.vals) }

pub fn chem_mol_repr_smiles_series_std(s : ChemmolreprsmilesSeries) -> Double { @_common.std(s.vals) }

pub fn chem_mol_repr_smiles_series_median(s : ChemmolreprsmilesSeries) -> Double { @_common.median(s.vals) }

pub fn chem_mol_repr_smiles_series_scale(s : ChemmolreprsmilesSeries, f : Double) -> ChemmolreprsmilesSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn chem_mol_repr_smiles_series_add(a : ChemmolreprsmilesSeries, b : ChemmolreprsmilesSeries) -> ChemmolreprsmilesSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_mol_repr_smiles_series_sub(a : ChemmolreprsmilesSeries, b : ChemmolreprsmilesSeries) -> ChemmolreprsmilesSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_mol_repr_smiles_series_normalize(s : ChemmolreprsmilesSeries) -> ChemmolreprsmilesSeries {
  let mn = chem_mol_repr_smiles_series_min(s)
  let mx = chem_mol_repr_smiles_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_mol_repr_smiles_series_cumsum(s : ChemmolreprsmilesSeries) -> ChemmolreprsmilesSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_mol_repr_smiles_series_to_string(s : ChemmolreprsmilesSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprsmilesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_repr_smiles_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolreprsmilesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_repr_smiles_matrix_identity(n : Int) -> ChemmolreprsmilesMatrix {
  let m = chem_mol_repr_smiles_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_mol_repr_smiles_matrix_get(m : ChemmolreprsmilesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_mol_repr_smiles_matrix_transpose(m : ChemmolreprsmilesMatrix) -> ChemmolreprsmilesMatrix {
  let result = chem_mol_repr_smiles_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_mol_repr_smiles_matrix_add(a : ChemmolreprsmilesMatrix, b : ChemmolreprsmilesMatrix) -> ChemmolreprsmilesMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_mol_repr_smiles_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_mol_repr_smiles_matrix_scale(m : ChemmolreprsmilesMatrix, s : Double) -> ChemmolreprsmilesMatrix {
  let result = chem_mol_repr_smiles_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_mol_repr_smiles_matrix_multiply(a : ChemmolreprsmilesMatrix, b : ChemmolreprsmilesMatrix) -> ChemmolreprsmilesMatrix {
  if a.cols != b.rows { return chem_mol_repr_smiles_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_mol_repr_smiles_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_mol_repr_smiles_matrix_trace(m : ChemmolreprsmilesMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_mol_repr_smiles_matrix_det(m : ChemmolreprsmilesMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_mol_repr_smiles_matrix_norm(m : ChemmolreprsmilesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_mol_repr_smiles_matrix_to_string(m : ChemmolreprsmilesMatrix) -> String {
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

pub(all) struct ChemmolreprsmilesVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_repr_smiles_make_vector(comps : Array[Double]) -> ChemmolreprsmilesVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_repr_smiles_vector_zero(dim : Int) -> ChemmolreprsmilesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_mol_repr_smiles_vector_add(a : ChemmolreprsmilesVector, b : ChemmolreprsmilesVector) -> ChemmolreprsmilesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn chem_mol_repr_smiles_vector_sub(a : ChemmolreprsmilesVector, b : ChemmolreprsmilesVector) -> ChemmolreprsmilesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn chem_mol_repr_smiles_vector_scale(v : ChemmolreprsmilesVector, s : Double) -> ChemmolreprsmilesVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn chem_mol_repr_smiles_vector_dot(a : ChemmolreprsmilesVector, b : ChemmolreprsmilesVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_mol_repr_smiles_vector_norm(v : ChemmolreprsmilesVector) -> Double { @_common.sqrt(chem_mol_repr_smiles_vector_dot(v, v)) }

pub fn chem_mol_repr_smiles_vector_normalize(v : ChemmolreprsmilesVector) -> ChemmolreprsmilesVector {
  let n = chem_mol_repr_smiles_vector_norm(v)
  if n < 0.0000001 { v } else { chem_mol_repr_smiles_vector_scale(v, 1.0 / n) }
}

pub fn chem_mol_repr_smiles_vector_dist(a : ChemmolreprsmilesVector, b : ChemmolreprsmilesVector) -> Double {
  chem_mol_repr_smiles_vector_norm(chem_mol_repr_smiles_vector_sub(a, b))
}

pub fn chem_mol_repr_smiles_vector_to_string(v : ChemmolreprsmilesVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_repr_smiles_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_repr_smiles_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_repr_smiles_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_repr_smiles_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_repr_smiles_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_repr_smiles_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_repr_smiles_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_repr_smiles_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_repr_smiles_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_repr_smiles_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_repr_smiles_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_repr_smiles_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_repr_smiles_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_repr_smiles_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_repr_smiles_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_repr_smiles_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_repr_smiles_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_repr_smiles_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_repr_smiles_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_repr_smiles_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_repr_smiles_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_repr_smiles_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_repr_smiles_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_repr_smiles_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_repr_smiles_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_repr_smiles_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_repr_smiles_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_repr_smiles_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_repr_smiles_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolreprsmilesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_frame_make(size : Int) -> ChemmolreprsmilesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_frame_len(s : ChemmolreprsmilesFrame) -> Int { s.size }

pub fn chem_mol_repr_smiles_frame_get(s : ChemmolreprsmilesFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_frame_set(s : ChemmolreprsmilesFrame, i : Int, v : Double) -> ChemmolreprsmilesFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_frame_sum(s : ChemmolreprsmilesFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_frame_mean(s : ChemmolreprsmilesFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_frame_scale(s : ChemmolreprsmilesFrame, f : Double) -> ChemmolreprsmilesFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_frame_add(a : ChemmolreprsmilesFrame, b : ChemmolreprsmilesFrame) -> ChemmolreprsmilesFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_frame_copy(s : ChemmolreprsmilesFrame) -> ChemmolreprsmilesFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_frame_fill(s : ChemmolreprsmilesFrame, v : Double) -> ChemmolreprsmilesFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_frame_min(s : ChemmolreprsmilesFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_frame_max(s : ChemmolreprsmilesFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_frame_to_string(s : ChemmolreprsmilesFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_table_make(size : Int) -> ChemmolreprsmilesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_table_len(s : ChemmolreprsmilesTable) -> Int { s.size }

pub fn chem_mol_repr_smiles_table_get(s : ChemmolreprsmilesTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_table_set(s : ChemmolreprsmilesTable, i : Int, v : Double) -> ChemmolreprsmilesTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_table_sum(s : ChemmolreprsmilesTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_table_mean(s : ChemmolreprsmilesTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_table_scale(s : ChemmolreprsmilesTable, f : Double) -> ChemmolreprsmilesTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_table_add(a : ChemmolreprsmilesTable, b : ChemmolreprsmilesTable) -> ChemmolreprsmilesTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_table_copy(s : ChemmolreprsmilesTable) -> ChemmolreprsmilesTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_table_fill(s : ChemmolreprsmilesTable, v : Double) -> ChemmolreprsmilesTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_table_min(s : ChemmolreprsmilesTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_table_max(s : ChemmolreprsmilesTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_table_to_string(s : ChemmolreprsmilesTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_graphn_make(size : Int) -> ChemmolreprsmilesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_graphn_len(s : ChemmolreprsmilesGraphN) -> Int { s.size }

pub fn chem_mol_repr_smiles_graphn_get(s : ChemmolreprsmilesGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_graphn_set(s : ChemmolreprsmilesGraphN, i : Int, v : Double) -> ChemmolreprsmilesGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_graphn_sum(s : ChemmolreprsmilesGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_graphn_mean(s : ChemmolreprsmilesGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_graphn_scale(s : ChemmolreprsmilesGraphN, f : Double) -> ChemmolreprsmilesGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_graphn_add(a : ChemmolreprsmilesGraphN, b : ChemmolreprsmilesGraphN) -> ChemmolreprsmilesGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_graphn_copy(s : ChemmolreprsmilesGraphN) -> ChemmolreprsmilesGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_graphn_fill(s : ChemmolreprsmilesGraphN, v : Double) -> ChemmolreprsmilesGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_graphn_min(s : ChemmolreprsmilesGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_graphn_max(s : ChemmolreprsmilesGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_graphn_to_string(s : ChemmolreprsmilesGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_node_make(size : Int) -> ChemmolreprsmilesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_node_len(s : ChemmolreprsmilesNode) -> Int { s.size }

pub fn chem_mol_repr_smiles_node_get(s : ChemmolreprsmilesNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_node_set(s : ChemmolreprsmilesNode, i : Int, v : Double) -> ChemmolreprsmilesNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_node_sum(s : ChemmolreprsmilesNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_node_mean(s : ChemmolreprsmilesNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_node_scale(s : ChemmolreprsmilesNode, f : Double) -> ChemmolreprsmilesNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_node_add(a : ChemmolreprsmilesNode, b : ChemmolreprsmilesNode) -> ChemmolreprsmilesNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_node_copy(s : ChemmolreprsmilesNode) -> ChemmolreprsmilesNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_node_fill(s : ChemmolreprsmilesNode, v : Double) -> ChemmolreprsmilesNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_node_min(s : ChemmolreprsmilesNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_node_max(s : ChemmolreprsmilesNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_node_to_string(s : ChemmolreprsmilesNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_edge_make(size : Int) -> ChemmolreprsmilesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_edge_len(s : ChemmolreprsmilesEdge) -> Int { s.size }

pub fn chem_mol_repr_smiles_edge_get(s : ChemmolreprsmilesEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_edge_set(s : ChemmolreprsmilesEdge, i : Int, v : Double) -> ChemmolreprsmilesEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_edge_sum(s : ChemmolreprsmilesEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_edge_mean(s : ChemmolreprsmilesEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_edge_scale(s : ChemmolreprsmilesEdge, f : Double) -> ChemmolreprsmilesEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_edge_add(a : ChemmolreprsmilesEdge, b : ChemmolreprsmilesEdge) -> ChemmolreprsmilesEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_edge_copy(s : ChemmolreprsmilesEdge) -> ChemmolreprsmilesEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_edge_fill(s : ChemmolreprsmilesEdge, v : Double) -> ChemmolreprsmilesEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_edge_min(s : ChemmolreprsmilesEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_edge_max(s : ChemmolreprsmilesEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_edge_to_string(s : ChemmolreprsmilesEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_path_make(size : Int) -> ChemmolreprsmilesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_path_len(s : ChemmolreprsmilesPath) -> Int { s.size }

pub fn chem_mol_repr_smiles_path_get(s : ChemmolreprsmilesPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_path_set(s : ChemmolreprsmilesPath, i : Int, v : Double) -> ChemmolreprsmilesPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_path_sum(s : ChemmolreprsmilesPath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_path_mean(s : ChemmolreprsmilesPath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_path_scale(s : ChemmolreprsmilesPath, f : Double) -> ChemmolreprsmilesPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_path_add(a : ChemmolreprsmilesPath, b : ChemmolreprsmilesPath) -> ChemmolreprsmilesPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_path_copy(s : ChemmolreprsmilesPath) -> ChemmolreprsmilesPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_path_fill(s : ChemmolreprsmilesPath, v : Double) -> ChemmolreprsmilesPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_path_min(s : ChemmolreprsmilesPath) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_path_max(s : ChemmolreprsmilesPath) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_path_to_string(s : ChemmolreprsmilesPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_cluster_make(size : Int) -> ChemmolreprsmilesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_cluster_len(s : ChemmolreprsmilesCluster) -> Int { s.size }

pub fn chem_mol_repr_smiles_cluster_get(s : ChemmolreprsmilesCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_cluster_set(s : ChemmolreprsmilesCluster, i : Int, v : Double) -> ChemmolreprsmilesCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_cluster_sum(s : ChemmolreprsmilesCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_cluster_mean(s : ChemmolreprsmilesCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_cluster_scale(s : ChemmolreprsmilesCluster, f : Double) -> ChemmolreprsmilesCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_cluster_add(a : ChemmolreprsmilesCluster, b : ChemmolreprsmilesCluster) -> ChemmolreprsmilesCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_cluster_copy(s : ChemmolreprsmilesCluster) -> ChemmolreprsmilesCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_cluster_fill(s : ChemmolreprsmilesCluster, v : Double) -> ChemmolreprsmilesCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_cluster_min(s : ChemmolreprsmilesCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_cluster_max(s : ChemmolreprsmilesCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_cluster_to_string(s : ChemmolreprsmilesCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_model_make(size : Int) -> ChemmolreprsmilesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_model_len(s : ChemmolreprsmilesModel) -> Int { s.size }

pub fn chem_mol_repr_smiles_model_get(s : ChemmolreprsmilesModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_model_set(s : ChemmolreprsmilesModel, i : Int, v : Double) -> ChemmolreprsmilesModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_model_sum(s : ChemmolreprsmilesModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_model_mean(s : ChemmolreprsmilesModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_model_scale(s : ChemmolreprsmilesModel, f : Double) -> ChemmolreprsmilesModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_model_add(a : ChemmolreprsmilesModel, b : ChemmolreprsmilesModel) -> ChemmolreprsmilesModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_model_copy(s : ChemmolreprsmilesModel) -> ChemmolreprsmilesModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_model_fill(s : ChemmolreprsmilesModel, v : Double) -> ChemmolreprsmilesModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_model_min(s : ChemmolreprsmilesModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_model_max(s : ChemmolreprsmilesModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_model_to_string(s : ChemmolreprsmilesModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_layer_make(size : Int) -> ChemmolreprsmilesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_layer_len(s : ChemmolreprsmilesLayer) -> Int { s.size }

pub fn chem_mol_repr_smiles_layer_get(s : ChemmolreprsmilesLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_layer_set(s : ChemmolreprsmilesLayer, i : Int, v : Double) -> ChemmolreprsmilesLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_layer_sum(s : ChemmolreprsmilesLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_layer_mean(s : ChemmolreprsmilesLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_layer_scale(s : ChemmolreprsmilesLayer, f : Double) -> ChemmolreprsmilesLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_layer_add(a : ChemmolreprsmilesLayer, b : ChemmolreprsmilesLayer) -> ChemmolreprsmilesLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_layer_copy(s : ChemmolreprsmilesLayer) -> ChemmolreprsmilesLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_layer_fill(s : ChemmolreprsmilesLayer, v : Double) -> ChemmolreprsmilesLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_layer_min(s : ChemmolreprsmilesLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_layer_max(s : ChemmolreprsmilesLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_layer_to_string(s : ChemmolreprsmilesLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_buffer_make(size : Int) -> ChemmolreprsmilesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_buffer_len(s : ChemmolreprsmilesBuffer) -> Int { s.size }

pub fn chem_mol_repr_smiles_buffer_get(s : ChemmolreprsmilesBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_buffer_set(s : ChemmolreprsmilesBuffer, i : Int, v : Double) -> ChemmolreprsmilesBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_buffer_sum(s : ChemmolreprsmilesBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_buffer_mean(s : ChemmolreprsmilesBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_buffer_scale(s : ChemmolreprsmilesBuffer, f : Double) -> ChemmolreprsmilesBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_buffer_add(a : ChemmolreprsmilesBuffer, b : ChemmolreprsmilesBuffer) -> ChemmolreprsmilesBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_buffer_copy(s : ChemmolreprsmilesBuffer) -> ChemmolreprsmilesBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_buffer_fill(s : ChemmolreprsmilesBuffer, v : Double) -> ChemmolreprsmilesBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_buffer_min(s : ChemmolreprsmilesBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_buffer_max(s : ChemmolreprsmilesBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_buffer_to_string(s : ChemmolreprsmilesBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_cursor_make(size : Int) -> ChemmolreprsmilesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_cursor_len(s : ChemmolreprsmilesCursor) -> Int { s.size }

pub fn chem_mol_repr_smiles_cursor_get(s : ChemmolreprsmilesCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_cursor_set(s : ChemmolreprsmilesCursor, i : Int, v : Double) -> ChemmolreprsmilesCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_cursor_sum(s : ChemmolreprsmilesCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_cursor_mean(s : ChemmolreprsmilesCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_cursor_scale(s : ChemmolreprsmilesCursor, f : Double) -> ChemmolreprsmilesCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_cursor_add(a : ChemmolreprsmilesCursor, b : ChemmolreprsmilesCursor) -> ChemmolreprsmilesCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_cursor_copy(s : ChemmolreprsmilesCursor) -> ChemmolreprsmilesCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_cursor_fill(s : ChemmolreprsmilesCursor, v : Double) -> ChemmolreprsmilesCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_cursor_min(s : ChemmolreprsmilesCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_cursor_max(s : ChemmolreprsmilesCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_cursor_to_string(s : ChemmolreprsmilesCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_view_make(size : Int) -> ChemmolreprsmilesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_view_len(s : ChemmolreprsmilesView) -> Int { s.size }

pub fn chem_mol_repr_smiles_view_get(s : ChemmolreprsmilesView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_view_set(s : ChemmolreprsmilesView, i : Int, v : Double) -> ChemmolreprsmilesView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_view_sum(s : ChemmolreprsmilesView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_view_mean(s : ChemmolreprsmilesView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_view_scale(s : ChemmolreprsmilesView, f : Double) -> ChemmolreprsmilesView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_view_add(a : ChemmolreprsmilesView, b : ChemmolreprsmilesView) -> ChemmolreprsmilesView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_view_copy(s : ChemmolreprsmilesView) -> ChemmolreprsmilesView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_view_fill(s : ChemmolreprsmilesView, v : Double) -> ChemmolreprsmilesView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_view_min(s : ChemmolreprsmilesView) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_view_max(s : ChemmolreprsmilesView) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_view_to_string(s : ChemmolreprsmilesView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_range_make(size : Int) -> ChemmolreprsmilesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_range_len(s : ChemmolreprsmilesRange) -> Int { s.size }

pub fn chem_mol_repr_smiles_range_get(s : ChemmolreprsmilesRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_range_set(s : ChemmolreprsmilesRange, i : Int, v : Double) -> ChemmolreprsmilesRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_range_sum(s : ChemmolreprsmilesRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_range_mean(s : ChemmolreprsmilesRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_range_scale(s : ChemmolreprsmilesRange, f : Double) -> ChemmolreprsmilesRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_range_add(a : ChemmolreprsmilesRange, b : ChemmolreprsmilesRange) -> ChemmolreprsmilesRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_range_copy(s : ChemmolreprsmilesRange) -> ChemmolreprsmilesRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_range_fill(s : ChemmolreprsmilesRange, v : Double) -> ChemmolreprsmilesRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_range_min(s : ChemmolreprsmilesRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_range_max(s : ChemmolreprsmilesRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_range_to_string(s : ChemmolreprsmilesRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_slice_make(size : Int) -> ChemmolreprsmilesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_smiles_slice_len(s : ChemmolreprsmilesSlice) -> Int { s.size }

pub fn chem_mol_repr_smiles_slice_get(s : ChemmolreprsmilesSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_smiles_slice_set(s : ChemmolreprsmilesSlice, i : Int, v : Double) -> ChemmolreprsmilesSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_slice_sum(s : ChemmolreprsmilesSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_smiles_slice_mean(s : ChemmolreprsmilesSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_smiles_slice_scale(s : ChemmolreprsmilesSlice, f : Double) -> ChemmolreprsmilesSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_slice_add(a : ChemmolreprsmilesSlice, b : ChemmolreprsmilesSlice) -> ChemmolreprsmilesSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_smiles_slice_copy(s : ChemmolreprsmilesSlice) -> ChemmolreprsmilesSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_slice_fill(s : ChemmolreprsmilesSlice, v : Double) -> ChemmolreprsmilesSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_smiles_slice_min(s : ChemmolreprsmilesSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_smiles_slice_max(s : ChemmolreprsmilesSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_smiles_slice_to_string(s : ChemmolreprsmilesSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

