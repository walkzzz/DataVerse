///===
/// extcore/chem_desc_topological

pub(all) struct ChemdesctopologicalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_topological_make_point(x : Double, y : Double) -> ChemdesctopologicalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_topological_make_point3(x : Double, y : Double, z : Double) -> ChemdesctopologicalPoint {
  { x, y, z, label: 0 }
}

pub fn chem_desc_topological_point_x(pt : ChemdesctopologicalPoint) -> Double { pt.x }

pub fn chem_desc_topological_point_y(pt : ChemdesctopologicalPoint) -> Double { pt.y }

pub fn chem_desc_topological_point_z(pt : ChemdesctopologicalPoint) -> Double { pt.z }

pub fn chem_desc_topological_point_label(pt : ChemdesctopologicalPoint) -> Int { pt.label }

pub fn chem_desc_topological_point_dist(a : ChemdesctopologicalPoint, b : ChemdesctopologicalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_desc_topological_point_add(a : ChemdesctopologicalPoint, b : ChemdesctopologicalPoint) -> ChemdesctopologicalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_desc_topological_point_sub(a : ChemdesctopologicalPoint, b : ChemdesctopologicalPoint) -> ChemdesctopologicalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_desc_topological_point_scale(pt : ChemdesctopologicalPoint, s : Double) -> ChemdesctopologicalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_desc_topological_point_dot(a : ChemdesctopologicalPoint, b : ChemdesctopologicalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_desc_topological_point_cross(a : ChemdesctopologicalPoint, b : ChemdesctopologicalPoint) -> ChemdesctopologicalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_desc_topological_point_norm(pt : ChemdesctopologicalPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_desc_topological_point_normalize(pt : ChemdesctopologicalPoint) -> ChemdesctopologicalPoint {
  let n = chem_desc_topological_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_desc_topological_point_scale(pt, 1.0 / n) }
}

pub fn chem_desc_topological_point_negate(pt : ChemdesctopologicalPoint) -> ChemdesctopologicalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_desc_topological_point_mid(a : ChemdesctopologicalPoint, b : ChemdesctopologicalPoint) -> ChemdesctopologicalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_desc_topological_point_lerp(a : ChemdesctopologicalPoint, b : ChemdesctopologicalPoint, t : Double) -> ChemdesctopologicalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_desc_topological_point_to_string(pt : ChemdesctopologicalPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemdesctopologicalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_topological_make_series(vals : Array[Double], name : String) -> ChemdesctopologicalSeries {
  { vals, name, meta: 0 }
}

pub fn chem_desc_topological_series_len(s : ChemdesctopologicalSeries) -> Int { s.vals.length() }

pub fn chem_desc_topological_series_sum(s : ChemdesctopologicalSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_desc_topological_series_mean(s : ChemdesctopologicalSeries) -> Double {
  let n = chem_desc_topological_series_len(s)
  if n == 0 { 0.0 } else { chem_desc_topological_series_sum(s) / n.to_double() }
}

pub fn chem_desc_topological_series_min(s : ChemdesctopologicalSeries) -> Double {
  let n = chem_desc_topological_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn chem_desc_topological_series_max(s : ChemdesctopologicalSeries) -> Double {
  let n = chem_desc_topological_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn chem_desc_topological_series_range(s : ChemdesctopologicalSeries) -> Double {
  chem_desc_topological_series_max(s) - chem_desc_topological_series_min(s)
}

pub fn chem_desc_topological_series_var(s : ChemdesctopologicalSeries) -> Double {
  let n = chem_desc_topological_series_len(s)
  if n == 0 { 0.0 } else {
    let m = chem_desc_topological_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn chem_desc_topological_series_std(s : ChemdesctopologicalSeries) -> Double { @_common.sqrt(chem_desc_topological_series_var(s)) }

pub fn chem_desc_topological_series_median(s : ChemdesctopologicalSeries) -> Double {
  let n = chem_desc_topological_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = chem_desc_topological_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_desc_topological_series_scale(s : ChemdesctopologicalSeries, f : Double) -> ChemdesctopologicalSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_desc_topological_series_add(a : ChemdesctopologicalSeries, b : ChemdesctopologicalSeries) -> ChemdesctopologicalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_desc_topological_series_sub(a : ChemdesctopologicalSeries, b : ChemdesctopologicalSeries) -> ChemdesctopologicalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_desc_topological_series_normalize(s : ChemdesctopologicalSeries) -> ChemdesctopologicalSeries {
  let mn = chem_desc_topological_series_min(s)
  let mx = chem_desc_topological_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_desc_topological_series_cumsum(s : ChemdesctopologicalSeries) -> ChemdesctopologicalSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_desc_topological_series_to_string(s : ChemdesctopologicalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdesctopologicalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_topological_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdesctopologicalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_desc_topological_matrix_identity(n : Int) -> ChemdesctopologicalMatrix {
  let m = chem_desc_topological_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_desc_topological_matrix_get(m : ChemdesctopologicalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_desc_topological_matrix_transpose(m : ChemdesctopologicalMatrix) -> ChemdesctopologicalMatrix {
  let result = chem_desc_topological_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_desc_topological_matrix_add(a : ChemdesctopologicalMatrix, b : ChemdesctopologicalMatrix) -> ChemdesctopologicalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_desc_topological_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_desc_topological_matrix_scale(m : ChemdesctopologicalMatrix, s : Double) -> ChemdesctopologicalMatrix {
  let result = chem_desc_topological_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_desc_topological_matrix_multiply(a : ChemdesctopologicalMatrix, b : ChemdesctopologicalMatrix) -> ChemdesctopologicalMatrix {
  if a.cols != b.rows { return chem_desc_topological_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_desc_topological_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_desc_topological_matrix_trace(m : ChemdesctopologicalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_desc_topological_matrix_det(m : ChemdesctopologicalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_desc_topological_matrix_norm(m : ChemdesctopologicalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_desc_topological_matrix_to_string(m : ChemdesctopologicalMatrix) -> String {
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

pub(all) struct ChemdesctopologicalVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_topological_make_vector(comps : Array[Double]) -> ChemdesctopologicalVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_topological_vector_zero(dim : Int) -> ChemdesctopologicalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_desc_topological_vector_add(a : ChemdesctopologicalVector, b : ChemdesctopologicalVector) -> ChemdesctopologicalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_desc_topological_vector_sub(a : ChemdesctopologicalVector, b : ChemdesctopologicalVector) -> ChemdesctopologicalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_desc_topological_vector_scale(v : ChemdesctopologicalVector, s : Double) -> ChemdesctopologicalVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_desc_topological_vector_dot(a : ChemdesctopologicalVector, b : ChemdesctopologicalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_desc_topological_vector_norm(v : ChemdesctopologicalVector) -> Double { @_common.sqrt(chem_desc_topological_vector_dot(v, v)) }

pub fn chem_desc_topological_vector_normalize(v : ChemdesctopologicalVector) -> ChemdesctopologicalVector {
  let n = chem_desc_topological_vector_norm(v)
  if n < 0.0000001 { v } else { chem_desc_topological_vector_scale(v, 1.0 / n) }
}

pub fn chem_desc_topological_vector_dist(a : ChemdesctopologicalVector, b : ChemdesctopologicalVector) -> Double {
  chem_desc_topological_vector_norm(chem_desc_topological_vector_sub(a, b))
}

pub fn chem_desc_topological_vector_to_string(v : ChemdesctopologicalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_desc_topological_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_desc_topological_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_desc_topological_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_desc_topological_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_desc_topological_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_desc_topological_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_desc_topological_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_desc_topological_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_desc_topological_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_desc_topological_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_desc_topological_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_desc_topological_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_desc_topological_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_desc_topological_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_desc_topological_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_desc_topological_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_desc_topological_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_desc_topological_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_desc_topological_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_desc_topological_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_desc_topological_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_desc_topological_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_desc_topological_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_desc_topological_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_desc_topological_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_desc_topological_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_desc_topological_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_desc_topological_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_desc_topological_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemdesctopologicalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_frame_make(size : Int) -> ChemdesctopologicalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_topological_frame_len(s : ChemdesctopologicalFrame) -> Int { s.size }

pub fn chem_desc_topological_frame_get(s : ChemdesctopologicalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_topological_frame_set(s : ChemdesctopologicalFrame, i : Int, v : Double) -> ChemdesctopologicalFrame {
  let result = chem_desc_topological_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_frame_sum(s : ChemdesctopologicalFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_topological_frame_mean(s : ChemdesctopologicalFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_topological_frame_sum(s) / s.size.to_double() }
}

pub fn chem_desc_topological_frame_scale(s : ChemdesctopologicalFrame, f : Double) -> ChemdesctopologicalFrame {
  let result = chem_desc_topological_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_topological_frame_add(a : ChemdesctopologicalFrame, b : ChemdesctopologicalFrame) -> ChemdesctopologicalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_topological_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_topological_frame_copy(s : ChemdesctopologicalFrame) -> ChemdesctopologicalFrame {
  let result = chem_desc_topological_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_topological_frame_fill(s : ChemdesctopologicalFrame, v : Double) -> ChemdesctopologicalFrame {
  let result = chem_desc_topological_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_frame_min(s : ChemdesctopologicalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_frame_max(s : ChemdesctopologicalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_frame_to_string(s : ChemdesctopologicalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_table_make(size : Int) -> ChemdesctopologicalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_topological_table_len(s : ChemdesctopologicalTable) -> Int { s.size }

pub fn chem_desc_topological_table_get(s : ChemdesctopologicalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_topological_table_set(s : ChemdesctopologicalTable, i : Int, v : Double) -> ChemdesctopologicalTable {
  let result = chem_desc_topological_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_table_sum(s : ChemdesctopologicalTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_topological_table_mean(s : ChemdesctopologicalTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_topological_table_sum(s) / s.size.to_double() }
}

pub fn chem_desc_topological_table_scale(s : ChemdesctopologicalTable, f : Double) -> ChemdesctopologicalTable {
  let result = chem_desc_topological_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_topological_table_add(a : ChemdesctopologicalTable, b : ChemdesctopologicalTable) -> ChemdesctopologicalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_topological_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_topological_table_copy(s : ChemdesctopologicalTable) -> ChemdesctopologicalTable {
  let result = chem_desc_topological_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_topological_table_fill(s : ChemdesctopologicalTable, v : Double) -> ChemdesctopologicalTable {
  let result = chem_desc_topological_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_table_min(s : ChemdesctopologicalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_table_max(s : ChemdesctopologicalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_table_to_string(s : ChemdesctopologicalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_graphn_make(size : Int) -> ChemdesctopologicalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_topological_graphn_len(s : ChemdesctopologicalGraphN) -> Int { s.size }

pub fn chem_desc_topological_graphn_get(s : ChemdesctopologicalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_topological_graphn_set(s : ChemdesctopologicalGraphN, i : Int, v : Double) -> ChemdesctopologicalGraphN {
  let result = chem_desc_topological_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_graphn_sum(s : ChemdesctopologicalGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_topological_graphn_mean(s : ChemdesctopologicalGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_topological_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_desc_topological_graphn_scale(s : ChemdesctopologicalGraphN, f : Double) -> ChemdesctopologicalGraphN {
  let result = chem_desc_topological_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_topological_graphn_add(a : ChemdesctopologicalGraphN, b : ChemdesctopologicalGraphN) -> ChemdesctopologicalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_topological_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_topological_graphn_copy(s : ChemdesctopologicalGraphN) -> ChemdesctopologicalGraphN {
  let result = chem_desc_topological_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_topological_graphn_fill(s : ChemdesctopologicalGraphN, v : Double) -> ChemdesctopologicalGraphN {
  let result = chem_desc_topological_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_graphn_min(s : ChemdesctopologicalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_graphn_max(s : ChemdesctopologicalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_graphn_to_string(s : ChemdesctopologicalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_node_make(size : Int) -> ChemdesctopologicalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_topological_node_len(s : ChemdesctopologicalNode) -> Int { s.size }

pub fn chem_desc_topological_node_get(s : ChemdesctopologicalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_topological_node_set(s : ChemdesctopologicalNode, i : Int, v : Double) -> ChemdesctopologicalNode {
  let result = chem_desc_topological_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_node_sum(s : ChemdesctopologicalNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_topological_node_mean(s : ChemdesctopologicalNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_topological_node_sum(s) / s.size.to_double() }
}

pub fn chem_desc_topological_node_scale(s : ChemdesctopologicalNode, f : Double) -> ChemdesctopologicalNode {
  let result = chem_desc_topological_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_topological_node_add(a : ChemdesctopologicalNode, b : ChemdesctopologicalNode) -> ChemdesctopologicalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_topological_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_topological_node_copy(s : ChemdesctopologicalNode) -> ChemdesctopologicalNode {
  let result = chem_desc_topological_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_topological_node_fill(s : ChemdesctopologicalNode, v : Double) -> ChemdesctopologicalNode {
  let result = chem_desc_topological_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_node_min(s : ChemdesctopologicalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_node_max(s : ChemdesctopologicalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_node_to_string(s : ChemdesctopologicalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_edge_make(size : Int) -> ChemdesctopologicalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_topological_edge_len(s : ChemdesctopologicalEdge) -> Int { s.size }

pub fn chem_desc_topological_edge_get(s : ChemdesctopologicalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_topological_edge_set(s : ChemdesctopologicalEdge, i : Int, v : Double) -> ChemdesctopologicalEdge {
  let result = chem_desc_topological_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_edge_sum(s : ChemdesctopologicalEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_topological_edge_mean(s : ChemdesctopologicalEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_topological_edge_sum(s) / s.size.to_double() }
}

pub fn chem_desc_topological_edge_scale(s : ChemdesctopologicalEdge, f : Double) -> ChemdesctopologicalEdge {
  let result = chem_desc_topological_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_topological_edge_add(a : ChemdesctopologicalEdge, b : ChemdesctopologicalEdge) -> ChemdesctopologicalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_topological_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_topological_edge_copy(s : ChemdesctopologicalEdge) -> ChemdesctopologicalEdge {
  let result = chem_desc_topological_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_topological_edge_fill(s : ChemdesctopologicalEdge, v : Double) -> ChemdesctopologicalEdge {
  let result = chem_desc_topological_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_edge_min(s : ChemdesctopologicalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_edge_max(s : ChemdesctopologicalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_edge_to_string(s : ChemdesctopologicalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_path_make(size : Int) -> ChemdesctopologicalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_topological_path_len(s : ChemdesctopologicalPath) -> Int { s.size }

pub fn chem_desc_topological_path_get(s : ChemdesctopologicalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_topological_path_set(s : ChemdesctopologicalPath, i : Int, v : Double) -> ChemdesctopologicalPath {
  let result = chem_desc_topological_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_path_sum(s : ChemdesctopologicalPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_topological_path_mean(s : ChemdesctopologicalPath) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_topological_path_sum(s) / s.size.to_double() }
}

pub fn chem_desc_topological_path_scale(s : ChemdesctopologicalPath, f : Double) -> ChemdesctopologicalPath {
  let result = chem_desc_topological_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_topological_path_add(a : ChemdesctopologicalPath, b : ChemdesctopologicalPath) -> ChemdesctopologicalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_topological_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_topological_path_copy(s : ChemdesctopologicalPath) -> ChemdesctopologicalPath {
  let result = chem_desc_topological_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_topological_path_fill(s : ChemdesctopologicalPath, v : Double) -> ChemdesctopologicalPath {
  let result = chem_desc_topological_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_path_min(s : ChemdesctopologicalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_path_max(s : ChemdesctopologicalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_path_to_string(s : ChemdesctopologicalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_cluster_make(size : Int) -> ChemdesctopologicalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_topological_cluster_len(s : ChemdesctopologicalCluster) -> Int { s.size }

pub fn chem_desc_topological_cluster_get(s : ChemdesctopologicalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_topological_cluster_set(s : ChemdesctopologicalCluster, i : Int, v : Double) -> ChemdesctopologicalCluster {
  let result = chem_desc_topological_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_cluster_sum(s : ChemdesctopologicalCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_topological_cluster_mean(s : ChemdesctopologicalCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_topological_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_desc_topological_cluster_scale(s : ChemdesctopologicalCluster, f : Double) -> ChemdesctopologicalCluster {
  let result = chem_desc_topological_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_topological_cluster_add(a : ChemdesctopologicalCluster, b : ChemdesctopologicalCluster) -> ChemdesctopologicalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_topological_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_topological_cluster_copy(s : ChemdesctopologicalCluster) -> ChemdesctopologicalCluster {
  let result = chem_desc_topological_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_topological_cluster_fill(s : ChemdesctopologicalCluster, v : Double) -> ChemdesctopologicalCluster {
  let result = chem_desc_topological_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_cluster_min(s : ChemdesctopologicalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_cluster_max(s : ChemdesctopologicalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_cluster_to_string(s : ChemdesctopologicalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_model_make(size : Int) -> ChemdesctopologicalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_topological_model_len(s : ChemdesctopologicalModel) -> Int { s.size }

pub fn chem_desc_topological_model_get(s : ChemdesctopologicalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_topological_model_set(s : ChemdesctopologicalModel, i : Int, v : Double) -> ChemdesctopologicalModel {
  let result = chem_desc_topological_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_model_sum(s : ChemdesctopologicalModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_topological_model_mean(s : ChemdesctopologicalModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_topological_model_sum(s) / s.size.to_double() }
}

pub fn chem_desc_topological_model_scale(s : ChemdesctopologicalModel, f : Double) -> ChemdesctopologicalModel {
  let result = chem_desc_topological_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_topological_model_add(a : ChemdesctopologicalModel, b : ChemdesctopologicalModel) -> ChemdesctopologicalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_topological_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_topological_model_copy(s : ChemdesctopologicalModel) -> ChemdesctopologicalModel {
  let result = chem_desc_topological_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_topological_model_fill(s : ChemdesctopologicalModel, v : Double) -> ChemdesctopologicalModel {
  let result = chem_desc_topological_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_model_min(s : ChemdesctopologicalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_model_max(s : ChemdesctopologicalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_model_to_string(s : ChemdesctopologicalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_layer_make(size : Int) -> ChemdesctopologicalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_topological_layer_len(s : ChemdesctopologicalLayer) -> Int { s.size }

pub fn chem_desc_topological_layer_get(s : ChemdesctopologicalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_topological_layer_set(s : ChemdesctopologicalLayer, i : Int, v : Double) -> ChemdesctopologicalLayer {
  let result = chem_desc_topological_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_layer_sum(s : ChemdesctopologicalLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_topological_layer_mean(s : ChemdesctopologicalLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_topological_layer_sum(s) / s.size.to_double() }
}

pub fn chem_desc_topological_layer_scale(s : ChemdesctopologicalLayer, f : Double) -> ChemdesctopologicalLayer {
  let result = chem_desc_topological_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_topological_layer_add(a : ChemdesctopologicalLayer, b : ChemdesctopologicalLayer) -> ChemdesctopologicalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_topological_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_topological_layer_copy(s : ChemdesctopologicalLayer) -> ChemdesctopologicalLayer {
  let result = chem_desc_topological_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_topological_layer_fill(s : ChemdesctopologicalLayer, v : Double) -> ChemdesctopologicalLayer {
  let result = chem_desc_topological_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_layer_min(s : ChemdesctopologicalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_layer_max(s : ChemdesctopologicalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_layer_to_string(s : ChemdesctopologicalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_buffer_make(size : Int) -> ChemdesctopologicalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_topological_buffer_len(s : ChemdesctopologicalBuffer) -> Int { s.size }

pub fn chem_desc_topological_buffer_get(s : ChemdesctopologicalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_topological_buffer_set(s : ChemdesctopologicalBuffer, i : Int, v : Double) -> ChemdesctopologicalBuffer {
  let result = chem_desc_topological_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_buffer_sum(s : ChemdesctopologicalBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_topological_buffer_mean(s : ChemdesctopologicalBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_topological_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_desc_topological_buffer_scale(s : ChemdesctopologicalBuffer, f : Double) -> ChemdesctopologicalBuffer {
  let result = chem_desc_topological_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_topological_buffer_add(a : ChemdesctopologicalBuffer, b : ChemdesctopologicalBuffer) -> ChemdesctopologicalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_topological_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_topological_buffer_copy(s : ChemdesctopologicalBuffer) -> ChemdesctopologicalBuffer {
  let result = chem_desc_topological_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_topological_buffer_fill(s : ChemdesctopologicalBuffer, v : Double) -> ChemdesctopologicalBuffer {
  let result = chem_desc_topological_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_buffer_min(s : ChemdesctopologicalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_buffer_max(s : ChemdesctopologicalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_buffer_to_string(s : ChemdesctopologicalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_cursor_make(size : Int) -> ChemdesctopologicalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_topological_cursor_len(s : ChemdesctopologicalCursor) -> Int { s.size }

pub fn chem_desc_topological_cursor_get(s : ChemdesctopologicalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_topological_cursor_set(s : ChemdesctopologicalCursor, i : Int, v : Double) -> ChemdesctopologicalCursor {
  let result = chem_desc_topological_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_cursor_sum(s : ChemdesctopologicalCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_topological_cursor_mean(s : ChemdesctopologicalCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_topological_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_desc_topological_cursor_scale(s : ChemdesctopologicalCursor, f : Double) -> ChemdesctopologicalCursor {
  let result = chem_desc_topological_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_topological_cursor_add(a : ChemdesctopologicalCursor, b : ChemdesctopologicalCursor) -> ChemdesctopologicalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_topological_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_topological_cursor_copy(s : ChemdesctopologicalCursor) -> ChemdesctopologicalCursor {
  let result = chem_desc_topological_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_topological_cursor_fill(s : ChemdesctopologicalCursor, v : Double) -> ChemdesctopologicalCursor {
  let result = chem_desc_topological_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_cursor_min(s : ChemdesctopologicalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_cursor_max(s : ChemdesctopologicalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_cursor_to_string(s : ChemdesctopologicalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_view_make(size : Int) -> ChemdesctopologicalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_topological_view_len(s : ChemdesctopologicalView) -> Int { s.size }

pub fn chem_desc_topological_view_get(s : ChemdesctopologicalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_topological_view_set(s : ChemdesctopologicalView, i : Int, v : Double) -> ChemdesctopologicalView {
  let result = chem_desc_topological_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_view_sum(s : ChemdesctopologicalView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_topological_view_mean(s : ChemdesctopologicalView) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_topological_view_sum(s) / s.size.to_double() }
}

pub fn chem_desc_topological_view_scale(s : ChemdesctopologicalView, f : Double) -> ChemdesctopologicalView {
  let result = chem_desc_topological_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_topological_view_add(a : ChemdesctopologicalView, b : ChemdesctopologicalView) -> ChemdesctopologicalView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_topological_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_topological_view_copy(s : ChemdesctopologicalView) -> ChemdesctopologicalView {
  let result = chem_desc_topological_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_topological_view_fill(s : ChemdesctopologicalView, v : Double) -> ChemdesctopologicalView {
  let result = chem_desc_topological_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_view_min(s : ChemdesctopologicalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_view_max(s : ChemdesctopologicalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_view_to_string(s : ChemdesctopologicalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_range_make(size : Int) -> ChemdesctopologicalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_topological_range_len(s : ChemdesctopologicalRange) -> Int { s.size }

pub fn chem_desc_topological_range_get(s : ChemdesctopologicalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_topological_range_set(s : ChemdesctopologicalRange, i : Int, v : Double) -> ChemdesctopologicalRange {
  let result = chem_desc_topological_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_range_sum(s : ChemdesctopologicalRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_topological_range_mean(s : ChemdesctopologicalRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_topological_range_sum(s) / s.size.to_double() }
}

pub fn chem_desc_topological_range_scale(s : ChemdesctopologicalRange, f : Double) -> ChemdesctopologicalRange {
  let result = chem_desc_topological_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_topological_range_add(a : ChemdesctopologicalRange, b : ChemdesctopologicalRange) -> ChemdesctopologicalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_topological_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_topological_range_copy(s : ChemdesctopologicalRange) -> ChemdesctopologicalRange {
  let result = chem_desc_topological_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_topological_range_fill(s : ChemdesctopologicalRange, v : Double) -> ChemdesctopologicalRange {
  let result = chem_desc_topological_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_range_min(s : ChemdesctopologicalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_range_max(s : ChemdesctopologicalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_range_to_string(s : ChemdesctopologicalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_slice_make(size : Int) -> ChemdesctopologicalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_topological_slice_len(s : ChemdesctopologicalSlice) -> Int { s.size }

pub fn chem_desc_topological_slice_get(s : ChemdesctopologicalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_topological_slice_set(s : ChemdesctopologicalSlice, i : Int, v : Double) -> ChemdesctopologicalSlice {
  let result = chem_desc_topological_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_slice_sum(s : ChemdesctopologicalSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_topological_slice_mean(s : ChemdesctopologicalSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_topological_slice_sum(s) / s.size.to_double() }
}

pub fn chem_desc_topological_slice_scale(s : ChemdesctopologicalSlice, f : Double) -> ChemdesctopologicalSlice {
  let result = chem_desc_topological_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_topological_slice_add(a : ChemdesctopologicalSlice, b : ChemdesctopologicalSlice) -> ChemdesctopologicalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_topological_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_topological_slice_copy(s : ChemdesctopologicalSlice) -> ChemdesctopologicalSlice {
  let result = chem_desc_topological_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_topological_slice_fill(s : ChemdesctopologicalSlice, v : Double) -> ChemdesctopologicalSlice {
  let result = chem_desc_topological_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_topological_slice_min(s : ChemdesctopologicalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_slice_max(s : ChemdesctopologicalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_topological_slice_to_string(s : ChemdesctopologicalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

