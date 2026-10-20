///===
/// extcore/chem_mol_props_rings

pub(all) struct ChemmolpropsringsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_rings_make_point(x : Double, y : Double) -> ChemmolpropsringsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_rings_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropsringsPoint {
  { x, y, z, label: 0 }
}

pub fn chem_mol_props_rings_point_x(pt : ChemmolpropsringsPoint) -> Double { pt.x }

pub fn chem_mol_props_rings_point_y(pt : ChemmolpropsringsPoint) -> Double { pt.y }

pub fn chem_mol_props_rings_point_z(pt : ChemmolpropsringsPoint) -> Double { pt.z }

pub fn chem_mol_props_rings_point_label(pt : ChemmolpropsringsPoint) -> Int { pt.label }

pub fn chem_mol_props_rings_point_dist(a : ChemmolpropsringsPoint, b : ChemmolpropsringsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_mol_props_rings_point_add(a : ChemmolpropsringsPoint, b : ChemmolpropsringsPoint) -> ChemmolpropsringsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_mol_props_rings_point_sub(a : ChemmolpropsringsPoint, b : ChemmolpropsringsPoint) -> ChemmolpropsringsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_mol_props_rings_point_scale(pt : ChemmolpropsringsPoint, s : Double) -> ChemmolpropsringsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_mol_props_rings_point_dot(a : ChemmolpropsringsPoint, b : ChemmolpropsringsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_mol_props_rings_point_cross(a : ChemmolpropsringsPoint, b : ChemmolpropsringsPoint) -> ChemmolpropsringsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_mol_props_rings_point_norm(pt : ChemmolpropsringsPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_mol_props_rings_point_normalize(pt : ChemmolpropsringsPoint) -> ChemmolpropsringsPoint {
  let n = chem_mol_props_rings_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_mol_props_rings_point_scale(pt, 1.0 / n) }
}

pub fn chem_mol_props_rings_point_negate(pt : ChemmolpropsringsPoint) -> ChemmolpropsringsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_mol_props_rings_point_mid(a : ChemmolpropsringsPoint, b : ChemmolpropsringsPoint) -> ChemmolpropsringsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_mol_props_rings_point_lerp(a : ChemmolpropsringsPoint, b : ChemmolpropsringsPoint, t : Double) -> ChemmolpropsringsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_mol_props_rings_point_to_string(pt : ChemmolpropsringsPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemmolpropsringsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_rings_make_series(vals : Array[Double], name : String) -> ChemmolpropsringsSeries {
  { vals, name, meta: 0 }
}

pub fn chem_mol_props_rings_series_len(s : ChemmolpropsringsSeries) -> Int { s.vals.length() }

pub fn chem_mol_props_rings_series_sum(s : ChemmolpropsringsSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_mol_props_rings_series_mean(s : ChemmolpropsringsSeries) -> Double { @_common.mean(s.vals) }

pub fn chem_mol_props_rings_series_min(s : ChemmolpropsringsSeries) -> Double { @_common.min(s.vals) }

pub fn chem_mol_props_rings_series_max(s : ChemmolpropsringsSeries) -> Double { @_common.max(s.vals) }

pub fn chem_mol_props_rings_series_range(s : ChemmolpropsringsSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn chem_mol_props_rings_series_var(s : ChemmolpropsringsSeries) -> Double { @_common.variance(s.vals) }

pub fn chem_mol_props_rings_series_std(s : ChemmolpropsringsSeries) -> Double { @_common.std(s.vals) }

pub fn chem_mol_props_rings_series_median(s : ChemmolpropsringsSeries) -> Double { @_common.median(s.vals) }

pub fn chem_mol_props_rings_series_scale(s : ChemmolpropsringsSeries, f : Double) -> ChemmolpropsringsSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_mol_props_rings_series_add(a : ChemmolpropsringsSeries, b : ChemmolpropsringsSeries) -> ChemmolpropsringsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_mol_props_rings_series_sub(a : ChemmolpropsringsSeries, b : ChemmolpropsringsSeries) -> ChemmolpropsringsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_mol_props_rings_series_normalize(s : ChemmolpropsringsSeries) -> ChemmolpropsringsSeries {
  let mn = chem_mol_props_rings_series_min(s)
  let mx = chem_mol_props_rings_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_mol_props_rings_series_cumsum(s : ChemmolpropsringsSeries) -> ChemmolpropsringsSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_mol_props_rings_series_to_string(s : ChemmolpropsringsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropsringsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_rings_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropsringsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_rings_matrix_identity(n : Int) -> ChemmolpropsringsMatrix {
  let m = chem_mol_props_rings_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_mol_props_rings_matrix_get(m : ChemmolpropsringsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_mol_props_rings_matrix_transpose(m : ChemmolpropsringsMatrix) -> ChemmolpropsringsMatrix {
  let result = chem_mol_props_rings_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_mol_props_rings_matrix_add(a : ChemmolpropsringsMatrix, b : ChemmolpropsringsMatrix) -> ChemmolpropsringsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_mol_props_rings_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_mol_props_rings_matrix_scale(m : ChemmolpropsringsMatrix, s : Double) -> ChemmolpropsringsMatrix {
  let result = chem_mol_props_rings_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_mol_props_rings_matrix_multiply(a : ChemmolpropsringsMatrix, b : ChemmolpropsringsMatrix) -> ChemmolpropsringsMatrix {
  if a.cols != b.rows { return chem_mol_props_rings_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_mol_props_rings_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_mol_props_rings_matrix_trace(m : ChemmolpropsringsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_mol_props_rings_matrix_det(m : ChemmolpropsringsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_mol_props_rings_matrix_norm(m : ChemmolpropsringsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_mol_props_rings_matrix_to_string(m : ChemmolpropsringsMatrix) -> String {
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

pub(all) struct ChemmolpropsringsVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_rings_make_vector(comps : Array[Double]) -> ChemmolpropsringsVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_rings_vector_zero(dim : Int) -> ChemmolpropsringsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_mol_props_rings_vector_add(a : ChemmolpropsringsVector, b : ChemmolpropsringsVector) -> ChemmolpropsringsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_props_rings_vector_sub(a : ChemmolpropsringsVector, b : ChemmolpropsringsVector) -> ChemmolpropsringsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_props_rings_vector_scale(v : ChemmolpropsringsVector, s : Double) -> ChemmolpropsringsVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_mol_props_rings_vector_dot(a : ChemmolpropsringsVector, b : ChemmolpropsringsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_mol_props_rings_vector_norm(v : ChemmolpropsringsVector) -> Double { @_common.sqrt(chem_mol_props_rings_vector_dot(v, v)) }

pub fn chem_mol_props_rings_vector_normalize(v : ChemmolpropsringsVector) -> ChemmolpropsringsVector {
  let n = chem_mol_props_rings_vector_norm(v)
  if n < 0.0000001 { v } else { chem_mol_props_rings_vector_scale(v, 1.0 / n) }
}

pub fn chem_mol_props_rings_vector_dist(a : ChemmolpropsringsVector, b : ChemmolpropsringsVector) -> Double {
  chem_mol_props_rings_vector_norm(chem_mol_props_rings_vector_sub(a, b))
}

pub fn chem_mol_props_rings_vector_to_string(v : ChemmolpropsringsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_props_rings_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_props_rings_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_props_rings_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_props_rings_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_props_rings_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_props_rings_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_props_rings_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_props_rings_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_props_rings_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_props_rings_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_props_rings_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_props_rings_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_props_rings_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_props_rings_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_props_rings_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_props_rings_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_props_rings_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_props_rings_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_props_rings_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_props_rings_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_props_rings_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_props_rings_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_props_rings_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_props_rings_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_props_rings_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_props_rings_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_props_rings_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_props_rings_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_props_rings_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolpropsringsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_frame_make(size : Int) -> ChemmolpropsringsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_frame_len(s : ChemmolpropsringsFrame) -> Int { s.size }

pub fn chem_mol_props_rings_frame_get(s : ChemmolpropsringsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_frame_set(s : ChemmolpropsringsFrame, i : Int, v : Double) -> ChemmolpropsringsFrame {
  let result = chem_mol_props_rings_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_frame_sum(s : ChemmolpropsringsFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rings_frame_mean(s : ChemmolpropsringsFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rings_frame_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rings_frame_scale(s : ChemmolpropsringsFrame, f : Double) -> ChemmolpropsringsFrame {
  let result = chem_mol_props_rings_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rings_frame_add(a : ChemmolpropsringsFrame, b : ChemmolpropsringsFrame) -> ChemmolpropsringsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rings_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rings_frame_copy(s : ChemmolpropsringsFrame) -> ChemmolpropsringsFrame {
  let result = chem_mol_props_rings_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rings_frame_fill(s : ChemmolpropsringsFrame, v : Double) -> ChemmolpropsringsFrame {
  let result = chem_mol_props_rings_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_frame_min(s : ChemmolpropsringsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_frame_max(s : ChemmolpropsringsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_frame_to_string(s : ChemmolpropsringsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_table_make(size : Int) -> ChemmolpropsringsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_table_len(s : ChemmolpropsringsTable) -> Int { s.size }

pub fn chem_mol_props_rings_table_get(s : ChemmolpropsringsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_table_set(s : ChemmolpropsringsTable, i : Int, v : Double) -> ChemmolpropsringsTable {
  let result = chem_mol_props_rings_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_table_sum(s : ChemmolpropsringsTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rings_table_mean(s : ChemmolpropsringsTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rings_table_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rings_table_scale(s : ChemmolpropsringsTable, f : Double) -> ChemmolpropsringsTable {
  let result = chem_mol_props_rings_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rings_table_add(a : ChemmolpropsringsTable, b : ChemmolpropsringsTable) -> ChemmolpropsringsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rings_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rings_table_copy(s : ChemmolpropsringsTable) -> ChemmolpropsringsTable {
  let result = chem_mol_props_rings_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rings_table_fill(s : ChemmolpropsringsTable, v : Double) -> ChemmolpropsringsTable {
  let result = chem_mol_props_rings_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_table_min(s : ChemmolpropsringsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_table_max(s : ChemmolpropsringsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_table_to_string(s : ChemmolpropsringsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_graphn_make(size : Int) -> ChemmolpropsringsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_graphn_len(s : ChemmolpropsringsGraphN) -> Int { s.size }

pub fn chem_mol_props_rings_graphn_get(s : ChemmolpropsringsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_graphn_set(s : ChemmolpropsringsGraphN, i : Int, v : Double) -> ChemmolpropsringsGraphN {
  let result = chem_mol_props_rings_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_graphn_sum(s : ChemmolpropsringsGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rings_graphn_mean(s : ChemmolpropsringsGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rings_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rings_graphn_scale(s : ChemmolpropsringsGraphN, f : Double) -> ChemmolpropsringsGraphN {
  let result = chem_mol_props_rings_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rings_graphn_add(a : ChemmolpropsringsGraphN, b : ChemmolpropsringsGraphN) -> ChemmolpropsringsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rings_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rings_graphn_copy(s : ChemmolpropsringsGraphN) -> ChemmolpropsringsGraphN {
  let result = chem_mol_props_rings_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rings_graphn_fill(s : ChemmolpropsringsGraphN, v : Double) -> ChemmolpropsringsGraphN {
  let result = chem_mol_props_rings_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_graphn_min(s : ChemmolpropsringsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_graphn_max(s : ChemmolpropsringsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_graphn_to_string(s : ChemmolpropsringsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_node_make(size : Int) -> ChemmolpropsringsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_node_len(s : ChemmolpropsringsNode) -> Int { s.size }

pub fn chem_mol_props_rings_node_get(s : ChemmolpropsringsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_node_set(s : ChemmolpropsringsNode, i : Int, v : Double) -> ChemmolpropsringsNode {
  let result = chem_mol_props_rings_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_node_sum(s : ChemmolpropsringsNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rings_node_mean(s : ChemmolpropsringsNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rings_node_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rings_node_scale(s : ChemmolpropsringsNode, f : Double) -> ChemmolpropsringsNode {
  let result = chem_mol_props_rings_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rings_node_add(a : ChemmolpropsringsNode, b : ChemmolpropsringsNode) -> ChemmolpropsringsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rings_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rings_node_copy(s : ChemmolpropsringsNode) -> ChemmolpropsringsNode {
  let result = chem_mol_props_rings_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rings_node_fill(s : ChemmolpropsringsNode, v : Double) -> ChemmolpropsringsNode {
  let result = chem_mol_props_rings_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_node_min(s : ChemmolpropsringsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_node_max(s : ChemmolpropsringsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_node_to_string(s : ChemmolpropsringsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_edge_make(size : Int) -> ChemmolpropsringsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_edge_len(s : ChemmolpropsringsEdge) -> Int { s.size }

pub fn chem_mol_props_rings_edge_get(s : ChemmolpropsringsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_edge_set(s : ChemmolpropsringsEdge, i : Int, v : Double) -> ChemmolpropsringsEdge {
  let result = chem_mol_props_rings_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_edge_sum(s : ChemmolpropsringsEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rings_edge_mean(s : ChemmolpropsringsEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rings_edge_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rings_edge_scale(s : ChemmolpropsringsEdge, f : Double) -> ChemmolpropsringsEdge {
  let result = chem_mol_props_rings_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rings_edge_add(a : ChemmolpropsringsEdge, b : ChemmolpropsringsEdge) -> ChemmolpropsringsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rings_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rings_edge_copy(s : ChemmolpropsringsEdge) -> ChemmolpropsringsEdge {
  let result = chem_mol_props_rings_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rings_edge_fill(s : ChemmolpropsringsEdge, v : Double) -> ChemmolpropsringsEdge {
  let result = chem_mol_props_rings_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_edge_min(s : ChemmolpropsringsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_edge_max(s : ChemmolpropsringsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_edge_to_string(s : ChemmolpropsringsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_path_make(size : Int) -> ChemmolpropsringsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_path_len(s : ChemmolpropsringsPath) -> Int { s.size }

pub fn chem_mol_props_rings_path_get(s : ChemmolpropsringsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_path_set(s : ChemmolpropsringsPath, i : Int, v : Double) -> ChemmolpropsringsPath {
  let result = chem_mol_props_rings_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_path_sum(s : ChemmolpropsringsPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rings_path_mean(s : ChemmolpropsringsPath) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rings_path_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rings_path_scale(s : ChemmolpropsringsPath, f : Double) -> ChemmolpropsringsPath {
  let result = chem_mol_props_rings_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rings_path_add(a : ChemmolpropsringsPath, b : ChemmolpropsringsPath) -> ChemmolpropsringsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rings_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rings_path_copy(s : ChemmolpropsringsPath) -> ChemmolpropsringsPath {
  let result = chem_mol_props_rings_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rings_path_fill(s : ChemmolpropsringsPath, v : Double) -> ChemmolpropsringsPath {
  let result = chem_mol_props_rings_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_path_min(s : ChemmolpropsringsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_path_max(s : ChemmolpropsringsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_path_to_string(s : ChemmolpropsringsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_cluster_make(size : Int) -> ChemmolpropsringsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_cluster_len(s : ChemmolpropsringsCluster) -> Int { s.size }

pub fn chem_mol_props_rings_cluster_get(s : ChemmolpropsringsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_cluster_set(s : ChemmolpropsringsCluster, i : Int, v : Double) -> ChemmolpropsringsCluster {
  let result = chem_mol_props_rings_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_cluster_sum(s : ChemmolpropsringsCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rings_cluster_mean(s : ChemmolpropsringsCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rings_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rings_cluster_scale(s : ChemmolpropsringsCluster, f : Double) -> ChemmolpropsringsCluster {
  let result = chem_mol_props_rings_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rings_cluster_add(a : ChemmolpropsringsCluster, b : ChemmolpropsringsCluster) -> ChemmolpropsringsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rings_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rings_cluster_copy(s : ChemmolpropsringsCluster) -> ChemmolpropsringsCluster {
  let result = chem_mol_props_rings_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rings_cluster_fill(s : ChemmolpropsringsCluster, v : Double) -> ChemmolpropsringsCluster {
  let result = chem_mol_props_rings_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_cluster_min(s : ChemmolpropsringsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_cluster_max(s : ChemmolpropsringsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_cluster_to_string(s : ChemmolpropsringsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_model_make(size : Int) -> ChemmolpropsringsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_model_len(s : ChemmolpropsringsModel) -> Int { s.size }

pub fn chem_mol_props_rings_model_get(s : ChemmolpropsringsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_model_set(s : ChemmolpropsringsModel, i : Int, v : Double) -> ChemmolpropsringsModel {
  let result = chem_mol_props_rings_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_model_sum(s : ChemmolpropsringsModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rings_model_mean(s : ChemmolpropsringsModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rings_model_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rings_model_scale(s : ChemmolpropsringsModel, f : Double) -> ChemmolpropsringsModel {
  let result = chem_mol_props_rings_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rings_model_add(a : ChemmolpropsringsModel, b : ChemmolpropsringsModel) -> ChemmolpropsringsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rings_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rings_model_copy(s : ChemmolpropsringsModel) -> ChemmolpropsringsModel {
  let result = chem_mol_props_rings_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rings_model_fill(s : ChemmolpropsringsModel, v : Double) -> ChemmolpropsringsModel {
  let result = chem_mol_props_rings_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_model_min(s : ChemmolpropsringsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_model_max(s : ChemmolpropsringsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_model_to_string(s : ChemmolpropsringsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_layer_make(size : Int) -> ChemmolpropsringsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_layer_len(s : ChemmolpropsringsLayer) -> Int { s.size }

pub fn chem_mol_props_rings_layer_get(s : ChemmolpropsringsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_layer_set(s : ChemmolpropsringsLayer, i : Int, v : Double) -> ChemmolpropsringsLayer {
  let result = chem_mol_props_rings_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_layer_sum(s : ChemmolpropsringsLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rings_layer_mean(s : ChemmolpropsringsLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rings_layer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rings_layer_scale(s : ChemmolpropsringsLayer, f : Double) -> ChemmolpropsringsLayer {
  let result = chem_mol_props_rings_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rings_layer_add(a : ChemmolpropsringsLayer, b : ChemmolpropsringsLayer) -> ChemmolpropsringsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rings_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rings_layer_copy(s : ChemmolpropsringsLayer) -> ChemmolpropsringsLayer {
  let result = chem_mol_props_rings_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rings_layer_fill(s : ChemmolpropsringsLayer, v : Double) -> ChemmolpropsringsLayer {
  let result = chem_mol_props_rings_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_layer_min(s : ChemmolpropsringsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_layer_max(s : ChemmolpropsringsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_layer_to_string(s : ChemmolpropsringsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_buffer_make(size : Int) -> ChemmolpropsringsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_buffer_len(s : ChemmolpropsringsBuffer) -> Int { s.size }

pub fn chem_mol_props_rings_buffer_get(s : ChemmolpropsringsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_buffer_set(s : ChemmolpropsringsBuffer, i : Int, v : Double) -> ChemmolpropsringsBuffer {
  let result = chem_mol_props_rings_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_buffer_sum(s : ChemmolpropsringsBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rings_buffer_mean(s : ChemmolpropsringsBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rings_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rings_buffer_scale(s : ChemmolpropsringsBuffer, f : Double) -> ChemmolpropsringsBuffer {
  let result = chem_mol_props_rings_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rings_buffer_add(a : ChemmolpropsringsBuffer, b : ChemmolpropsringsBuffer) -> ChemmolpropsringsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rings_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rings_buffer_copy(s : ChemmolpropsringsBuffer) -> ChemmolpropsringsBuffer {
  let result = chem_mol_props_rings_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rings_buffer_fill(s : ChemmolpropsringsBuffer, v : Double) -> ChemmolpropsringsBuffer {
  let result = chem_mol_props_rings_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_buffer_min(s : ChemmolpropsringsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_buffer_max(s : ChemmolpropsringsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_buffer_to_string(s : ChemmolpropsringsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_cursor_make(size : Int) -> ChemmolpropsringsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_cursor_len(s : ChemmolpropsringsCursor) -> Int { s.size }

pub fn chem_mol_props_rings_cursor_get(s : ChemmolpropsringsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_cursor_set(s : ChemmolpropsringsCursor, i : Int, v : Double) -> ChemmolpropsringsCursor {
  let result = chem_mol_props_rings_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_cursor_sum(s : ChemmolpropsringsCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rings_cursor_mean(s : ChemmolpropsringsCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rings_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rings_cursor_scale(s : ChemmolpropsringsCursor, f : Double) -> ChemmolpropsringsCursor {
  let result = chem_mol_props_rings_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rings_cursor_add(a : ChemmolpropsringsCursor, b : ChemmolpropsringsCursor) -> ChemmolpropsringsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rings_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rings_cursor_copy(s : ChemmolpropsringsCursor) -> ChemmolpropsringsCursor {
  let result = chem_mol_props_rings_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rings_cursor_fill(s : ChemmolpropsringsCursor, v : Double) -> ChemmolpropsringsCursor {
  let result = chem_mol_props_rings_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_cursor_min(s : ChemmolpropsringsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_cursor_max(s : ChemmolpropsringsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_cursor_to_string(s : ChemmolpropsringsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_view_make(size : Int) -> ChemmolpropsringsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_view_len(s : ChemmolpropsringsView) -> Int { s.size }

pub fn chem_mol_props_rings_view_get(s : ChemmolpropsringsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_view_set(s : ChemmolpropsringsView, i : Int, v : Double) -> ChemmolpropsringsView {
  let result = chem_mol_props_rings_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_view_sum(s : ChemmolpropsringsView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rings_view_mean(s : ChemmolpropsringsView) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rings_view_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rings_view_scale(s : ChemmolpropsringsView, f : Double) -> ChemmolpropsringsView {
  let result = chem_mol_props_rings_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rings_view_add(a : ChemmolpropsringsView, b : ChemmolpropsringsView) -> ChemmolpropsringsView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rings_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rings_view_copy(s : ChemmolpropsringsView) -> ChemmolpropsringsView {
  let result = chem_mol_props_rings_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rings_view_fill(s : ChemmolpropsringsView, v : Double) -> ChemmolpropsringsView {
  let result = chem_mol_props_rings_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_view_min(s : ChemmolpropsringsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_view_max(s : ChemmolpropsringsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_view_to_string(s : ChemmolpropsringsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_range_make(size : Int) -> ChemmolpropsringsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_range_len(s : ChemmolpropsringsRange) -> Int { s.size }

pub fn chem_mol_props_rings_range_get(s : ChemmolpropsringsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_range_set(s : ChemmolpropsringsRange, i : Int, v : Double) -> ChemmolpropsringsRange {
  let result = chem_mol_props_rings_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_range_sum(s : ChemmolpropsringsRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rings_range_mean(s : ChemmolpropsringsRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rings_range_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rings_range_scale(s : ChemmolpropsringsRange, f : Double) -> ChemmolpropsringsRange {
  let result = chem_mol_props_rings_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rings_range_add(a : ChemmolpropsringsRange, b : ChemmolpropsringsRange) -> ChemmolpropsringsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rings_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rings_range_copy(s : ChemmolpropsringsRange) -> ChemmolpropsringsRange {
  let result = chem_mol_props_rings_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rings_range_fill(s : ChemmolpropsringsRange, v : Double) -> ChemmolpropsringsRange {
  let result = chem_mol_props_rings_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_range_min(s : ChemmolpropsringsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_range_max(s : ChemmolpropsringsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_range_to_string(s : ChemmolpropsringsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_slice_make(size : Int) -> ChemmolpropsringsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_slice_len(s : ChemmolpropsringsSlice) -> Int { s.size }

pub fn chem_mol_props_rings_slice_get(s : ChemmolpropsringsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_slice_set(s : ChemmolpropsringsSlice, i : Int, v : Double) -> ChemmolpropsringsSlice {
  let result = chem_mol_props_rings_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_slice_sum(s : ChemmolpropsringsSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rings_slice_mean(s : ChemmolpropsringsSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rings_slice_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rings_slice_scale(s : ChemmolpropsringsSlice, f : Double) -> ChemmolpropsringsSlice {
  let result = chem_mol_props_rings_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rings_slice_add(a : ChemmolpropsringsSlice, b : ChemmolpropsringsSlice) -> ChemmolpropsringsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rings_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rings_slice_copy(s : ChemmolpropsringsSlice) -> ChemmolpropsringsSlice {
  let result = chem_mol_props_rings_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rings_slice_fill(s : ChemmolpropsringsSlice, v : Double) -> ChemmolpropsringsSlice {
  let result = chem_mol_props_rings_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rings_slice_min(s : ChemmolpropsringsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_slice_max(s : ChemmolpropsringsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rings_slice_to_string(s : ChemmolpropsringsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

