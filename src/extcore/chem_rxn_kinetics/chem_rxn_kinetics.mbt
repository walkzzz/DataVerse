///===
/// extcore/chem_rxn_kinetics

pub(all) struct ChemrxnkineticsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_kinetics_make_point(x : Double, y : Double) -> ChemrxnkineticsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_kinetics_make_point3(x : Double, y : Double, z : Double) -> ChemrxnkineticsPoint {
  { x, y, z, label: 0 }
}

pub fn chem_rxn_kinetics_point_x(pt : ChemrxnkineticsPoint) -> Double { pt.x }

pub fn chem_rxn_kinetics_point_y(pt : ChemrxnkineticsPoint) -> Double { pt.y }

pub fn chem_rxn_kinetics_point_z(pt : ChemrxnkineticsPoint) -> Double { pt.z }

pub fn chem_rxn_kinetics_point_label(pt : ChemrxnkineticsPoint) -> Int { pt.label }

pub fn chem_rxn_kinetics_point_dist(a : ChemrxnkineticsPoint, b : ChemrxnkineticsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_rxn_kinetics_point_add(a : ChemrxnkineticsPoint, b : ChemrxnkineticsPoint) -> ChemrxnkineticsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_rxn_kinetics_point_sub(a : ChemrxnkineticsPoint, b : ChemrxnkineticsPoint) -> ChemrxnkineticsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_rxn_kinetics_point_scale(pt : ChemrxnkineticsPoint, s : Double) -> ChemrxnkineticsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_rxn_kinetics_point_dot(a : ChemrxnkineticsPoint, b : ChemrxnkineticsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_rxn_kinetics_point_cross(a : ChemrxnkineticsPoint, b : ChemrxnkineticsPoint) -> ChemrxnkineticsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_rxn_kinetics_point_norm(pt : ChemrxnkineticsPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_rxn_kinetics_point_normalize(pt : ChemrxnkineticsPoint) -> ChemrxnkineticsPoint {
  let n = chem_rxn_kinetics_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_rxn_kinetics_point_scale(pt, 1.0 / n) }
}

pub fn chem_rxn_kinetics_point_negate(pt : ChemrxnkineticsPoint) -> ChemrxnkineticsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_rxn_kinetics_point_mid(a : ChemrxnkineticsPoint, b : ChemrxnkineticsPoint) -> ChemrxnkineticsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_rxn_kinetics_point_lerp(a : ChemrxnkineticsPoint, b : ChemrxnkineticsPoint, t : Double) -> ChemrxnkineticsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_rxn_kinetics_point_to_string(pt : ChemrxnkineticsPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemrxnkineticsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_kinetics_make_series(vals : Array[Double], name : String) -> ChemrxnkineticsSeries {
  { vals, name, meta: 0 }
}

pub fn chem_rxn_kinetics_series_len(s : ChemrxnkineticsSeries) -> Int { s.vals.length() }

pub fn chem_rxn_kinetics_series_sum(s : ChemrxnkineticsSeries) -> Double { @_common.sum(s.vals) }

pub fn chem_rxn_kinetics_series_mean(s : ChemrxnkineticsSeries) -> Double { @_common.mean(s.vals) }

pub fn chem_rxn_kinetics_series_min(s : ChemrxnkineticsSeries) -> Double { @_common.min(s.vals) }

pub fn chem_rxn_kinetics_series_max(s : ChemrxnkineticsSeries) -> Double { @_common.max(s.vals) }

pub fn chem_rxn_kinetics_series_range(s : ChemrxnkineticsSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn chem_rxn_kinetics_series_var(s : ChemrxnkineticsSeries) -> Double { @_common.variance(s.vals) }

pub fn chem_rxn_kinetics_series_std(s : ChemrxnkineticsSeries) -> Double { @_common.std(s.vals) }

pub fn chem_rxn_kinetics_series_median(s : ChemrxnkineticsSeries) -> Double { @_common.median(s.vals) }

pub fn chem_rxn_kinetics_series_scale(s : ChemrxnkineticsSeries, f : Double) -> ChemrxnkineticsSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_rxn_kinetics_series_add(a : ChemrxnkineticsSeries, b : ChemrxnkineticsSeries) -> ChemrxnkineticsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_rxn_kinetics_series_sub(a : ChemrxnkineticsSeries, b : ChemrxnkineticsSeries) -> ChemrxnkineticsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_rxn_kinetics_series_normalize(s : ChemrxnkineticsSeries) -> ChemrxnkineticsSeries {
  let mn = chem_rxn_kinetics_series_min(s)
  let mx = chem_rxn_kinetics_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_rxn_kinetics_series_cumsum(s : ChemrxnkineticsSeries) -> ChemrxnkineticsSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_rxn_kinetics_series_to_string(s : ChemrxnkineticsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnkineticsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_kinetics_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxnkineticsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_kinetics_matrix_identity(n : Int) -> ChemrxnkineticsMatrix {
  let m = chem_rxn_kinetics_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_rxn_kinetics_matrix_get(m : ChemrxnkineticsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_rxn_kinetics_matrix_transpose(m : ChemrxnkineticsMatrix) -> ChemrxnkineticsMatrix {
  let result = chem_rxn_kinetics_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_rxn_kinetics_matrix_add(a : ChemrxnkineticsMatrix, b : ChemrxnkineticsMatrix) -> ChemrxnkineticsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_rxn_kinetics_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_rxn_kinetics_matrix_scale(m : ChemrxnkineticsMatrix, s : Double) -> ChemrxnkineticsMatrix {
  let result = chem_rxn_kinetics_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_rxn_kinetics_matrix_multiply(a : ChemrxnkineticsMatrix, b : ChemrxnkineticsMatrix) -> ChemrxnkineticsMatrix {
  if a.cols != b.rows { return chem_rxn_kinetics_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_rxn_kinetics_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_rxn_kinetics_matrix_trace(m : ChemrxnkineticsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_rxn_kinetics_matrix_det(m : ChemrxnkineticsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_rxn_kinetics_matrix_norm(m : ChemrxnkineticsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_rxn_kinetics_matrix_to_string(m : ChemrxnkineticsMatrix) -> String {
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

pub(all) struct ChemrxnkineticsVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_kinetics_make_vector(comps : Array[Double]) -> ChemrxnkineticsVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_kinetics_vector_zero(dim : Int) -> ChemrxnkineticsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_rxn_kinetics_vector_add(a : ChemrxnkineticsVector, b : ChemrxnkineticsVector) -> ChemrxnkineticsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_rxn_kinetics_vector_sub(a : ChemrxnkineticsVector, b : ChemrxnkineticsVector) -> ChemrxnkineticsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_rxn_kinetics_vector_scale(v : ChemrxnkineticsVector, s : Double) -> ChemrxnkineticsVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_rxn_kinetics_vector_dot(a : ChemrxnkineticsVector, b : ChemrxnkineticsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_rxn_kinetics_vector_norm(v : ChemrxnkineticsVector) -> Double { @_common.sqrt(chem_rxn_kinetics_vector_dot(v, v)) }

pub fn chem_rxn_kinetics_vector_normalize(v : ChemrxnkineticsVector) -> ChemrxnkineticsVector {
  let n = chem_rxn_kinetics_vector_norm(v)
  if n < 0.0000001 { v } else { chem_rxn_kinetics_vector_scale(v, 1.0 / n) }
}

pub fn chem_rxn_kinetics_vector_dist(a : ChemrxnkineticsVector, b : ChemrxnkineticsVector) -> Double {
  chem_rxn_kinetics_vector_norm(chem_rxn_kinetics_vector_sub(a, b))
}

pub fn chem_rxn_kinetics_vector_to_string(v : ChemrxnkineticsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_rxn_kinetics_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_rxn_kinetics_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_rxn_kinetics_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_rxn_kinetics_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_rxn_kinetics_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_rxn_kinetics_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_rxn_kinetics_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_rxn_kinetics_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_rxn_kinetics_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_rxn_kinetics_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_rxn_kinetics_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_rxn_kinetics_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_rxn_kinetics_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_rxn_kinetics_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_rxn_kinetics_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_rxn_kinetics_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_rxn_kinetics_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_rxn_kinetics_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_rxn_kinetics_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_rxn_kinetics_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_rxn_kinetics_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_rxn_kinetics_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_rxn_kinetics_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_rxn_kinetics_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_rxn_kinetics_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_rxn_kinetics_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_rxn_kinetics_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_rxn_kinetics_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_rxn_kinetics_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemrxnkineticsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_frame_make(size : Int) -> ChemrxnkineticsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_frame_len(s : ChemrxnkineticsFrame) -> Int { s.size }

pub fn chem_rxn_kinetics_frame_get(s : ChemrxnkineticsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_frame_set(s : ChemrxnkineticsFrame, i : Int, v : Double) -> ChemrxnkineticsFrame {
  let result = chem_rxn_kinetics_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_frame_sum(s : ChemrxnkineticsFrame) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_frame_mean(s : ChemrxnkineticsFrame) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_frame_scale(s : ChemrxnkineticsFrame, f : Double) -> ChemrxnkineticsFrame {
  let result = chem_rxn_kinetics_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_frame_add(a : ChemrxnkineticsFrame, b : ChemrxnkineticsFrame) -> ChemrxnkineticsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_frame_copy(s : ChemrxnkineticsFrame) -> ChemrxnkineticsFrame {
  let result = chem_rxn_kinetics_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_frame_fill(s : ChemrxnkineticsFrame, v : Double) -> ChemrxnkineticsFrame {
  let result = chem_rxn_kinetics_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_frame_min(s : ChemrxnkineticsFrame) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_frame_max(s : ChemrxnkineticsFrame) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_frame_to_string(s : ChemrxnkineticsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_table_make(size : Int) -> ChemrxnkineticsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_table_len(s : ChemrxnkineticsTable) -> Int { s.size }

pub fn chem_rxn_kinetics_table_get(s : ChemrxnkineticsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_table_set(s : ChemrxnkineticsTable, i : Int, v : Double) -> ChemrxnkineticsTable {
  let result = chem_rxn_kinetics_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_table_sum(s : ChemrxnkineticsTable) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_table_mean(s : ChemrxnkineticsTable) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_table_scale(s : ChemrxnkineticsTable, f : Double) -> ChemrxnkineticsTable {
  let result = chem_rxn_kinetics_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_table_add(a : ChemrxnkineticsTable, b : ChemrxnkineticsTable) -> ChemrxnkineticsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_table_copy(s : ChemrxnkineticsTable) -> ChemrxnkineticsTable {
  let result = chem_rxn_kinetics_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_table_fill(s : ChemrxnkineticsTable, v : Double) -> ChemrxnkineticsTable {
  let result = chem_rxn_kinetics_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_table_min(s : ChemrxnkineticsTable) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_table_max(s : ChemrxnkineticsTable) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_table_to_string(s : ChemrxnkineticsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_graphn_make(size : Int) -> ChemrxnkineticsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_graphn_len(s : ChemrxnkineticsGraphN) -> Int { s.size }

pub fn chem_rxn_kinetics_graphn_get(s : ChemrxnkineticsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_graphn_set(s : ChemrxnkineticsGraphN, i : Int, v : Double) -> ChemrxnkineticsGraphN {
  let result = chem_rxn_kinetics_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_graphn_sum(s : ChemrxnkineticsGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_graphn_mean(s : ChemrxnkineticsGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_graphn_scale(s : ChemrxnkineticsGraphN, f : Double) -> ChemrxnkineticsGraphN {
  let result = chem_rxn_kinetics_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_graphn_add(a : ChemrxnkineticsGraphN, b : ChemrxnkineticsGraphN) -> ChemrxnkineticsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_graphn_copy(s : ChemrxnkineticsGraphN) -> ChemrxnkineticsGraphN {
  let result = chem_rxn_kinetics_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_graphn_fill(s : ChemrxnkineticsGraphN, v : Double) -> ChemrxnkineticsGraphN {
  let result = chem_rxn_kinetics_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_graphn_min(s : ChemrxnkineticsGraphN) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_graphn_max(s : ChemrxnkineticsGraphN) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_graphn_to_string(s : ChemrxnkineticsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_node_make(size : Int) -> ChemrxnkineticsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_node_len(s : ChemrxnkineticsNode) -> Int { s.size }

pub fn chem_rxn_kinetics_node_get(s : ChemrxnkineticsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_node_set(s : ChemrxnkineticsNode, i : Int, v : Double) -> ChemrxnkineticsNode {
  let result = chem_rxn_kinetics_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_node_sum(s : ChemrxnkineticsNode) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_node_mean(s : ChemrxnkineticsNode) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_node_scale(s : ChemrxnkineticsNode, f : Double) -> ChemrxnkineticsNode {
  let result = chem_rxn_kinetics_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_node_add(a : ChemrxnkineticsNode, b : ChemrxnkineticsNode) -> ChemrxnkineticsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_node_copy(s : ChemrxnkineticsNode) -> ChemrxnkineticsNode {
  let result = chem_rxn_kinetics_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_node_fill(s : ChemrxnkineticsNode, v : Double) -> ChemrxnkineticsNode {
  let result = chem_rxn_kinetics_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_node_min(s : ChemrxnkineticsNode) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_node_max(s : ChemrxnkineticsNode) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_node_to_string(s : ChemrxnkineticsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_edge_make(size : Int) -> ChemrxnkineticsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_edge_len(s : ChemrxnkineticsEdge) -> Int { s.size }

pub fn chem_rxn_kinetics_edge_get(s : ChemrxnkineticsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_edge_set(s : ChemrxnkineticsEdge, i : Int, v : Double) -> ChemrxnkineticsEdge {
  let result = chem_rxn_kinetics_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_edge_sum(s : ChemrxnkineticsEdge) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_edge_mean(s : ChemrxnkineticsEdge) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_edge_scale(s : ChemrxnkineticsEdge, f : Double) -> ChemrxnkineticsEdge {
  let result = chem_rxn_kinetics_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_edge_add(a : ChemrxnkineticsEdge, b : ChemrxnkineticsEdge) -> ChemrxnkineticsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_edge_copy(s : ChemrxnkineticsEdge) -> ChemrxnkineticsEdge {
  let result = chem_rxn_kinetics_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_edge_fill(s : ChemrxnkineticsEdge, v : Double) -> ChemrxnkineticsEdge {
  let result = chem_rxn_kinetics_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_edge_min(s : ChemrxnkineticsEdge) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_edge_max(s : ChemrxnkineticsEdge) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_edge_to_string(s : ChemrxnkineticsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_path_make(size : Int) -> ChemrxnkineticsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_path_len(s : ChemrxnkineticsPath) -> Int { s.size }

pub fn chem_rxn_kinetics_path_get(s : ChemrxnkineticsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_path_set(s : ChemrxnkineticsPath, i : Int, v : Double) -> ChemrxnkineticsPath {
  let result = chem_rxn_kinetics_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_path_sum(s : ChemrxnkineticsPath) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_path_mean(s : ChemrxnkineticsPath) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_path_scale(s : ChemrxnkineticsPath, f : Double) -> ChemrxnkineticsPath {
  let result = chem_rxn_kinetics_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_path_add(a : ChemrxnkineticsPath, b : ChemrxnkineticsPath) -> ChemrxnkineticsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_path_copy(s : ChemrxnkineticsPath) -> ChemrxnkineticsPath {
  let result = chem_rxn_kinetics_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_path_fill(s : ChemrxnkineticsPath, v : Double) -> ChemrxnkineticsPath {
  let result = chem_rxn_kinetics_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_path_min(s : ChemrxnkineticsPath) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_path_max(s : ChemrxnkineticsPath) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_path_to_string(s : ChemrxnkineticsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_cluster_make(size : Int) -> ChemrxnkineticsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_cluster_len(s : ChemrxnkineticsCluster) -> Int { s.size }

pub fn chem_rxn_kinetics_cluster_get(s : ChemrxnkineticsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_cluster_set(s : ChemrxnkineticsCluster, i : Int, v : Double) -> ChemrxnkineticsCluster {
  let result = chem_rxn_kinetics_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_cluster_sum(s : ChemrxnkineticsCluster) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_cluster_mean(s : ChemrxnkineticsCluster) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_cluster_scale(s : ChemrxnkineticsCluster, f : Double) -> ChemrxnkineticsCluster {
  let result = chem_rxn_kinetics_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_cluster_add(a : ChemrxnkineticsCluster, b : ChemrxnkineticsCluster) -> ChemrxnkineticsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_cluster_copy(s : ChemrxnkineticsCluster) -> ChemrxnkineticsCluster {
  let result = chem_rxn_kinetics_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_cluster_fill(s : ChemrxnkineticsCluster, v : Double) -> ChemrxnkineticsCluster {
  let result = chem_rxn_kinetics_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_cluster_min(s : ChemrxnkineticsCluster) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_cluster_max(s : ChemrxnkineticsCluster) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_cluster_to_string(s : ChemrxnkineticsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_model_make(size : Int) -> ChemrxnkineticsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_model_len(s : ChemrxnkineticsModel) -> Int { s.size }

pub fn chem_rxn_kinetics_model_get(s : ChemrxnkineticsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_model_set(s : ChemrxnkineticsModel, i : Int, v : Double) -> ChemrxnkineticsModel {
  let result = chem_rxn_kinetics_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_model_sum(s : ChemrxnkineticsModel) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_model_mean(s : ChemrxnkineticsModel) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_model_scale(s : ChemrxnkineticsModel, f : Double) -> ChemrxnkineticsModel {
  let result = chem_rxn_kinetics_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_model_add(a : ChemrxnkineticsModel, b : ChemrxnkineticsModel) -> ChemrxnkineticsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_model_copy(s : ChemrxnkineticsModel) -> ChemrxnkineticsModel {
  let result = chem_rxn_kinetics_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_model_fill(s : ChemrxnkineticsModel, v : Double) -> ChemrxnkineticsModel {
  let result = chem_rxn_kinetics_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_model_min(s : ChemrxnkineticsModel) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_model_max(s : ChemrxnkineticsModel) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_model_to_string(s : ChemrxnkineticsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_layer_make(size : Int) -> ChemrxnkineticsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_layer_len(s : ChemrxnkineticsLayer) -> Int { s.size }

pub fn chem_rxn_kinetics_layer_get(s : ChemrxnkineticsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_layer_set(s : ChemrxnkineticsLayer, i : Int, v : Double) -> ChemrxnkineticsLayer {
  let result = chem_rxn_kinetics_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_layer_sum(s : ChemrxnkineticsLayer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_layer_mean(s : ChemrxnkineticsLayer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_layer_scale(s : ChemrxnkineticsLayer, f : Double) -> ChemrxnkineticsLayer {
  let result = chem_rxn_kinetics_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_layer_add(a : ChemrxnkineticsLayer, b : ChemrxnkineticsLayer) -> ChemrxnkineticsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_layer_copy(s : ChemrxnkineticsLayer) -> ChemrxnkineticsLayer {
  let result = chem_rxn_kinetics_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_layer_fill(s : ChemrxnkineticsLayer, v : Double) -> ChemrxnkineticsLayer {
  let result = chem_rxn_kinetics_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_layer_min(s : ChemrxnkineticsLayer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_layer_max(s : ChemrxnkineticsLayer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_layer_to_string(s : ChemrxnkineticsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_buffer_make(size : Int) -> ChemrxnkineticsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_buffer_len(s : ChemrxnkineticsBuffer) -> Int { s.size }

pub fn chem_rxn_kinetics_buffer_get(s : ChemrxnkineticsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_buffer_set(s : ChemrxnkineticsBuffer, i : Int, v : Double) -> ChemrxnkineticsBuffer {
  let result = chem_rxn_kinetics_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_buffer_sum(s : ChemrxnkineticsBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_buffer_mean(s : ChemrxnkineticsBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_buffer_scale(s : ChemrxnkineticsBuffer, f : Double) -> ChemrxnkineticsBuffer {
  let result = chem_rxn_kinetics_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_buffer_add(a : ChemrxnkineticsBuffer, b : ChemrxnkineticsBuffer) -> ChemrxnkineticsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_buffer_copy(s : ChemrxnkineticsBuffer) -> ChemrxnkineticsBuffer {
  let result = chem_rxn_kinetics_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_buffer_fill(s : ChemrxnkineticsBuffer, v : Double) -> ChemrxnkineticsBuffer {
  let result = chem_rxn_kinetics_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_buffer_min(s : ChemrxnkineticsBuffer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_buffer_max(s : ChemrxnkineticsBuffer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_buffer_to_string(s : ChemrxnkineticsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_cursor_make(size : Int) -> ChemrxnkineticsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_cursor_len(s : ChemrxnkineticsCursor) -> Int { s.size }

pub fn chem_rxn_kinetics_cursor_get(s : ChemrxnkineticsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_cursor_set(s : ChemrxnkineticsCursor, i : Int, v : Double) -> ChemrxnkineticsCursor {
  let result = chem_rxn_kinetics_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_cursor_sum(s : ChemrxnkineticsCursor) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_cursor_mean(s : ChemrxnkineticsCursor) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_cursor_scale(s : ChemrxnkineticsCursor, f : Double) -> ChemrxnkineticsCursor {
  let result = chem_rxn_kinetics_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_cursor_add(a : ChemrxnkineticsCursor, b : ChemrxnkineticsCursor) -> ChemrxnkineticsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_cursor_copy(s : ChemrxnkineticsCursor) -> ChemrxnkineticsCursor {
  let result = chem_rxn_kinetics_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_cursor_fill(s : ChemrxnkineticsCursor, v : Double) -> ChemrxnkineticsCursor {
  let result = chem_rxn_kinetics_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_cursor_min(s : ChemrxnkineticsCursor) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_cursor_max(s : ChemrxnkineticsCursor) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_cursor_to_string(s : ChemrxnkineticsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_view_make(size : Int) -> ChemrxnkineticsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_view_len(s : ChemrxnkineticsView) -> Int { s.size }

pub fn chem_rxn_kinetics_view_get(s : ChemrxnkineticsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_view_set(s : ChemrxnkineticsView, i : Int, v : Double) -> ChemrxnkineticsView {
  let result = chem_rxn_kinetics_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_view_sum(s : ChemrxnkineticsView) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_view_mean(s : ChemrxnkineticsView) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_view_scale(s : ChemrxnkineticsView, f : Double) -> ChemrxnkineticsView {
  let result = chem_rxn_kinetics_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_view_add(a : ChemrxnkineticsView, b : ChemrxnkineticsView) -> ChemrxnkineticsView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_view_copy(s : ChemrxnkineticsView) -> ChemrxnkineticsView {
  let result = chem_rxn_kinetics_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_view_fill(s : ChemrxnkineticsView, v : Double) -> ChemrxnkineticsView {
  let result = chem_rxn_kinetics_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_view_min(s : ChemrxnkineticsView) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_view_max(s : ChemrxnkineticsView) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_view_to_string(s : ChemrxnkineticsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_range_make(size : Int) -> ChemrxnkineticsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_range_len(s : ChemrxnkineticsRange) -> Int { s.size }

pub fn chem_rxn_kinetics_range_get(s : ChemrxnkineticsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_range_set(s : ChemrxnkineticsRange, i : Int, v : Double) -> ChemrxnkineticsRange {
  let result = chem_rxn_kinetics_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_range_sum(s : ChemrxnkineticsRange) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_range_mean(s : ChemrxnkineticsRange) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_range_scale(s : ChemrxnkineticsRange, f : Double) -> ChemrxnkineticsRange {
  let result = chem_rxn_kinetics_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_range_add(a : ChemrxnkineticsRange, b : ChemrxnkineticsRange) -> ChemrxnkineticsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_range_copy(s : ChemrxnkineticsRange) -> ChemrxnkineticsRange {
  let result = chem_rxn_kinetics_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_range_fill(s : ChemrxnkineticsRange, v : Double) -> ChemrxnkineticsRange {
  let result = chem_rxn_kinetics_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_range_min(s : ChemrxnkineticsRange) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_range_max(s : ChemrxnkineticsRange) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_range_to_string(s : ChemrxnkineticsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_slice_make(size : Int) -> ChemrxnkineticsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_slice_len(s : ChemrxnkineticsSlice) -> Int { s.size }

pub fn chem_rxn_kinetics_slice_get(s : ChemrxnkineticsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_slice_set(s : ChemrxnkineticsSlice, i : Int, v : Double) -> ChemrxnkineticsSlice {
  let result = chem_rxn_kinetics_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_slice_sum(s : ChemrxnkineticsSlice) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_slice_mean(s : ChemrxnkineticsSlice) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_slice_scale(s : ChemrxnkineticsSlice, f : Double) -> ChemrxnkineticsSlice {
  let result = chem_rxn_kinetics_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_slice_add(a : ChemrxnkineticsSlice, b : ChemrxnkineticsSlice) -> ChemrxnkineticsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_slice_copy(s : ChemrxnkineticsSlice) -> ChemrxnkineticsSlice {
  let result = chem_rxn_kinetics_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_slice_fill(s : ChemrxnkineticsSlice, v : Double) -> ChemrxnkineticsSlice {
  let result = chem_rxn_kinetics_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_slice_min(s : ChemrxnkineticsSlice) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_slice_max(s : ChemrxnkineticsSlice) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_slice_to_string(s : ChemrxnkineticsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

