///===
/// extcore/chem_desc_maccs

pub(all) struct ChemdescmaccsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_maccs_make_point(x : Double, y : Double) -> ChemdescmaccsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_maccs_make_point3(x : Double, y : Double, z : Double) -> ChemdescmaccsPoint {
  { x, y, z, label: 0 }
}

pub fn chem_desc_maccs_point_x(pt : ChemdescmaccsPoint) -> Double { pt.x }

pub fn chem_desc_maccs_point_y(pt : ChemdescmaccsPoint) -> Double { pt.y }

pub fn chem_desc_maccs_point_z(pt : ChemdescmaccsPoint) -> Double { pt.z }

pub fn chem_desc_maccs_point_label(pt : ChemdescmaccsPoint) -> Int { pt.label }

pub fn chem_desc_maccs_point_dist(a : ChemdescmaccsPoint, b : ChemdescmaccsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_desc_maccs_point_add(a : ChemdescmaccsPoint, b : ChemdescmaccsPoint) -> ChemdescmaccsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_desc_maccs_point_sub(a : ChemdescmaccsPoint, b : ChemdescmaccsPoint) -> ChemdescmaccsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_desc_maccs_point_scale(pt : ChemdescmaccsPoint, s : Double) -> ChemdescmaccsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_desc_maccs_point_dot(a : ChemdescmaccsPoint, b : ChemdescmaccsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_desc_maccs_point_cross(a : ChemdescmaccsPoint, b : ChemdescmaccsPoint) -> ChemdescmaccsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_desc_maccs_point_norm(pt : ChemdescmaccsPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_desc_maccs_point_normalize(pt : ChemdescmaccsPoint) -> ChemdescmaccsPoint {
  let n = chem_desc_maccs_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_desc_maccs_point_scale(pt, 1.0 / n) }
}

pub fn chem_desc_maccs_point_negate(pt : ChemdescmaccsPoint) -> ChemdescmaccsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_desc_maccs_point_mid(a : ChemdescmaccsPoint, b : ChemdescmaccsPoint) -> ChemdescmaccsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_desc_maccs_point_lerp(a : ChemdescmaccsPoint, b : ChemdescmaccsPoint, t : Double) -> ChemdescmaccsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_desc_maccs_point_to_string(pt : ChemdescmaccsPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemdescmaccsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_maccs_make_series(vals : Array[Double], name : String) -> ChemdescmaccsSeries {
  { vals, name, meta: 0 }
}

pub fn chem_desc_maccs_series_len(s : ChemdescmaccsSeries) -> Int { s.vals.length() }

pub fn chem_desc_maccs_series_sum(s : ChemdescmaccsSeries) -> Double { @_common.sum(s.vals) }

pub fn chem_desc_maccs_series_mean(s : ChemdescmaccsSeries) -> Double { @_common.mean(s.vals) }

pub fn chem_desc_maccs_series_min(s : ChemdescmaccsSeries) -> Double { @_common.min(s.vals) }

pub fn chem_desc_maccs_series_max(s : ChemdescmaccsSeries) -> Double { @_common.max(s.vals) }

pub fn chem_desc_maccs_series_range(s : ChemdescmaccsSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn chem_desc_maccs_series_var(s : ChemdescmaccsSeries) -> Double { @_common.variance(s.vals) }

pub fn chem_desc_maccs_series_std(s : ChemdescmaccsSeries) -> Double { @_common.std(s.vals) }

pub fn chem_desc_maccs_series_median(s : ChemdescmaccsSeries) -> Double { @_common.median(s.vals) }

pub fn chem_desc_maccs_series_scale(s : ChemdescmaccsSeries, f : Double) -> ChemdescmaccsSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_desc_maccs_series_add(a : ChemdescmaccsSeries, b : ChemdescmaccsSeries) -> ChemdescmaccsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_desc_maccs_series_sub(a : ChemdescmaccsSeries, b : ChemdescmaccsSeries) -> ChemdescmaccsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_desc_maccs_series_normalize(s : ChemdescmaccsSeries) -> ChemdescmaccsSeries {
  let mn = chem_desc_maccs_series_min(s)
  let mx = chem_desc_maccs_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_desc_maccs_series_cumsum(s : ChemdescmaccsSeries) -> ChemdescmaccsSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_desc_maccs_series_to_string(s : ChemdescmaccsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescmaccsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_maccs_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdescmaccsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_desc_maccs_matrix_identity(n : Int) -> ChemdescmaccsMatrix {
  let m = chem_desc_maccs_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_desc_maccs_matrix_get(m : ChemdescmaccsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_desc_maccs_matrix_transpose(m : ChemdescmaccsMatrix) -> ChemdescmaccsMatrix {
  let result = chem_desc_maccs_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_desc_maccs_matrix_add(a : ChemdescmaccsMatrix, b : ChemdescmaccsMatrix) -> ChemdescmaccsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_desc_maccs_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_desc_maccs_matrix_scale(m : ChemdescmaccsMatrix, s : Double) -> ChemdescmaccsMatrix {
  let result = chem_desc_maccs_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_desc_maccs_matrix_multiply(a : ChemdescmaccsMatrix, b : ChemdescmaccsMatrix) -> ChemdescmaccsMatrix {
  if a.cols != b.rows { return chem_desc_maccs_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_desc_maccs_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_desc_maccs_matrix_trace(m : ChemdescmaccsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_desc_maccs_matrix_det(m : ChemdescmaccsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_desc_maccs_matrix_norm(m : ChemdescmaccsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_desc_maccs_matrix_to_string(m : ChemdescmaccsMatrix) -> String {
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

pub(all) struct ChemdescmaccsVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_maccs_make_vector(comps : Array[Double]) -> ChemdescmaccsVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_maccs_vector_zero(dim : Int) -> ChemdescmaccsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_desc_maccs_vector_add(a : ChemdescmaccsVector, b : ChemdescmaccsVector) -> ChemdescmaccsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_desc_maccs_vector_sub(a : ChemdescmaccsVector, b : ChemdescmaccsVector) -> ChemdescmaccsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_desc_maccs_vector_scale(v : ChemdescmaccsVector, s : Double) -> ChemdescmaccsVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_desc_maccs_vector_dot(a : ChemdescmaccsVector, b : ChemdescmaccsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_desc_maccs_vector_norm(v : ChemdescmaccsVector) -> Double { @_common.sqrt(chem_desc_maccs_vector_dot(v, v)) }

pub fn chem_desc_maccs_vector_normalize(v : ChemdescmaccsVector) -> ChemdescmaccsVector {
  let n = chem_desc_maccs_vector_norm(v)
  if n < 0.0000001 { v } else { chem_desc_maccs_vector_scale(v, 1.0 / n) }
}

pub fn chem_desc_maccs_vector_dist(a : ChemdescmaccsVector, b : ChemdescmaccsVector) -> Double {
  chem_desc_maccs_vector_norm(chem_desc_maccs_vector_sub(a, b))
}

pub fn chem_desc_maccs_vector_to_string(v : ChemdescmaccsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_desc_maccs_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_desc_maccs_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_desc_maccs_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_desc_maccs_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_desc_maccs_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_desc_maccs_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_desc_maccs_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_desc_maccs_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_desc_maccs_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_desc_maccs_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_desc_maccs_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_desc_maccs_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_desc_maccs_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_desc_maccs_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_desc_maccs_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_desc_maccs_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_desc_maccs_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_desc_maccs_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_desc_maccs_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_desc_maccs_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_desc_maccs_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_desc_maccs_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_desc_maccs_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_desc_maccs_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_desc_maccs_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_desc_maccs_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_desc_maccs_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_desc_maccs_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_desc_maccs_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemdescmaccsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_frame_make(size : Int) -> ChemdescmaccsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_frame_len(s : ChemdescmaccsFrame) -> Int { s.size }

pub fn chem_desc_maccs_frame_get(s : ChemdescmaccsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_frame_set(s : ChemdescmaccsFrame, i : Int, v : Double) -> ChemdescmaccsFrame {
  let result = chem_desc_maccs_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_maccs_frame_sum(s : ChemdescmaccsFrame) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_frame_mean(s : ChemdescmaccsFrame) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_frame_scale(s : ChemdescmaccsFrame, f : Double) -> ChemdescmaccsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_frame_add(a : ChemdescmaccsFrame, b : ChemdescmaccsFrame) -> ChemdescmaccsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_frame_copy(s : ChemdescmaccsFrame) -> ChemdescmaccsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_frame_fill(s : ChemdescmaccsFrame, v : Double) -> ChemdescmaccsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_frame_min(s : ChemdescmaccsFrame) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_frame_max(s : ChemdescmaccsFrame) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_frame_to_string(s : ChemdescmaccsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_table_make(size : Int) -> ChemdescmaccsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_table_len(s : ChemdescmaccsTable) -> Int { s.size }

pub fn chem_desc_maccs_table_get(s : ChemdescmaccsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_table_set(s : ChemdescmaccsTable, i : Int, v : Double) -> ChemdescmaccsTable {
  let result = chem_desc_maccs_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_maccs_table_sum(s : ChemdescmaccsTable) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_table_mean(s : ChemdescmaccsTable) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_table_scale(s : ChemdescmaccsTable, f : Double) -> ChemdescmaccsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_table_add(a : ChemdescmaccsTable, b : ChemdescmaccsTable) -> ChemdescmaccsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_table_copy(s : ChemdescmaccsTable) -> ChemdescmaccsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_table_fill(s : ChemdescmaccsTable, v : Double) -> ChemdescmaccsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_table_min(s : ChemdescmaccsTable) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_table_max(s : ChemdescmaccsTable) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_table_to_string(s : ChemdescmaccsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_graphn_make(size : Int) -> ChemdescmaccsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_graphn_len(s : ChemdescmaccsGraphN) -> Int { s.size }

pub fn chem_desc_maccs_graphn_get(s : ChemdescmaccsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_graphn_set(s : ChemdescmaccsGraphN, i : Int, v : Double) -> ChemdescmaccsGraphN {
  let result = chem_desc_maccs_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_maccs_graphn_sum(s : ChemdescmaccsGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_graphn_mean(s : ChemdescmaccsGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_graphn_scale(s : ChemdescmaccsGraphN, f : Double) -> ChemdescmaccsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_graphn_add(a : ChemdescmaccsGraphN, b : ChemdescmaccsGraphN) -> ChemdescmaccsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_graphn_copy(s : ChemdescmaccsGraphN) -> ChemdescmaccsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_graphn_fill(s : ChemdescmaccsGraphN, v : Double) -> ChemdescmaccsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_graphn_min(s : ChemdescmaccsGraphN) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_graphn_max(s : ChemdescmaccsGraphN) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_graphn_to_string(s : ChemdescmaccsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_node_make(size : Int) -> ChemdescmaccsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_node_len(s : ChemdescmaccsNode) -> Int { s.size }

pub fn chem_desc_maccs_node_get(s : ChemdescmaccsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_node_set(s : ChemdescmaccsNode, i : Int, v : Double) -> ChemdescmaccsNode {
  let result = chem_desc_maccs_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_maccs_node_sum(s : ChemdescmaccsNode) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_node_mean(s : ChemdescmaccsNode) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_node_scale(s : ChemdescmaccsNode, f : Double) -> ChemdescmaccsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_node_add(a : ChemdescmaccsNode, b : ChemdescmaccsNode) -> ChemdescmaccsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_node_copy(s : ChemdescmaccsNode) -> ChemdescmaccsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_node_fill(s : ChemdescmaccsNode, v : Double) -> ChemdescmaccsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_node_min(s : ChemdescmaccsNode) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_node_max(s : ChemdescmaccsNode) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_node_to_string(s : ChemdescmaccsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_edge_make(size : Int) -> ChemdescmaccsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_edge_len(s : ChemdescmaccsEdge) -> Int { s.size }

pub fn chem_desc_maccs_edge_get(s : ChemdescmaccsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_edge_set(s : ChemdescmaccsEdge, i : Int, v : Double) -> ChemdescmaccsEdge {
  let result = chem_desc_maccs_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_maccs_edge_sum(s : ChemdescmaccsEdge) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_edge_mean(s : ChemdescmaccsEdge) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_edge_scale(s : ChemdescmaccsEdge, f : Double) -> ChemdescmaccsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_edge_add(a : ChemdescmaccsEdge, b : ChemdescmaccsEdge) -> ChemdescmaccsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_edge_copy(s : ChemdescmaccsEdge) -> ChemdescmaccsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_edge_fill(s : ChemdescmaccsEdge, v : Double) -> ChemdescmaccsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_edge_min(s : ChemdescmaccsEdge) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_edge_max(s : ChemdescmaccsEdge) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_edge_to_string(s : ChemdescmaccsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_path_make(size : Int) -> ChemdescmaccsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_path_len(s : ChemdescmaccsPath) -> Int { s.size }

pub fn chem_desc_maccs_path_get(s : ChemdescmaccsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_path_set(s : ChemdescmaccsPath, i : Int, v : Double) -> ChemdescmaccsPath {
  let result = chem_desc_maccs_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_maccs_path_sum(s : ChemdescmaccsPath) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_path_mean(s : ChemdescmaccsPath) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_path_scale(s : ChemdescmaccsPath, f : Double) -> ChemdescmaccsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_path_add(a : ChemdescmaccsPath, b : ChemdescmaccsPath) -> ChemdescmaccsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_path_copy(s : ChemdescmaccsPath) -> ChemdescmaccsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_path_fill(s : ChemdescmaccsPath, v : Double) -> ChemdescmaccsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_path_min(s : ChemdescmaccsPath) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_path_max(s : ChemdescmaccsPath) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_path_to_string(s : ChemdescmaccsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_cluster_make(size : Int) -> ChemdescmaccsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_cluster_len(s : ChemdescmaccsCluster) -> Int { s.size }

pub fn chem_desc_maccs_cluster_get(s : ChemdescmaccsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_cluster_set(s : ChemdescmaccsCluster, i : Int, v : Double) -> ChemdescmaccsCluster {
  let result = chem_desc_maccs_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_maccs_cluster_sum(s : ChemdescmaccsCluster) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_cluster_mean(s : ChemdescmaccsCluster) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_cluster_scale(s : ChemdescmaccsCluster, f : Double) -> ChemdescmaccsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_cluster_add(a : ChemdescmaccsCluster, b : ChemdescmaccsCluster) -> ChemdescmaccsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_cluster_copy(s : ChemdescmaccsCluster) -> ChemdescmaccsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_cluster_fill(s : ChemdescmaccsCluster, v : Double) -> ChemdescmaccsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_cluster_min(s : ChemdescmaccsCluster) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_cluster_max(s : ChemdescmaccsCluster) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_cluster_to_string(s : ChemdescmaccsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_model_make(size : Int) -> ChemdescmaccsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_model_len(s : ChemdescmaccsModel) -> Int { s.size }

pub fn chem_desc_maccs_model_get(s : ChemdescmaccsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_model_set(s : ChemdescmaccsModel, i : Int, v : Double) -> ChemdescmaccsModel {
  let result = chem_desc_maccs_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_maccs_model_sum(s : ChemdescmaccsModel) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_model_mean(s : ChemdescmaccsModel) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_model_scale(s : ChemdescmaccsModel, f : Double) -> ChemdescmaccsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_model_add(a : ChemdescmaccsModel, b : ChemdescmaccsModel) -> ChemdescmaccsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_model_copy(s : ChemdescmaccsModel) -> ChemdescmaccsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_model_fill(s : ChemdescmaccsModel, v : Double) -> ChemdescmaccsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_model_min(s : ChemdescmaccsModel) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_model_max(s : ChemdescmaccsModel) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_model_to_string(s : ChemdescmaccsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_layer_make(size : Int) -> ChemdescmaccsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_layer_len(s : ChemdescmaccsLayer) -> Int { s.size }

pub fn chem_desc_maccs_layer_get(s : ChemdescmaccsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_layer_set(s : ChemdescmaccsLayer, i : Int, v : Double) -> ChemdescmaccsLayer {
  let result = chem_desc_maccs_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_maccs_layer_sum(s : ChemdescmaccsLayer) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_layer_mean(s : ChemdescmaccsLayer) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_layer_scale(s : ChemdescmaccsLayer, f : Double) -> ChemdescmaccsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_layer_add(a : ChemdescmaccsLayer, b : ChemdescmaccsLayer) -> ChemdescmaccsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_layer_copy(s : ChemdescmaccsLayer) -> ChemdescmaccsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_layer_fill(s : ChemdescmaccsLayer, v : Double) -> ChemdescmaccsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_layer_min(s : ChemdescmaccsLayer) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_layer_max(s : ChemdescmaccsLayer) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_layer_to_string(s : ChemdescmaccsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_buffer_make(size : Int) -> ChemdescmaccsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_buffer_len(s : ChemdescmaccsBuffer) -> Int { s.size }

pub fn chem_desc_maccs_buffer_get(s : ChemdescmaccsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_buffer_set(s : ChemdescmaccsBuffer, i : Int, v : Double) -> ChemdescmaccsBuffer {
  let result = chem_desc_maccs_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_maccs_buffer_sum(s : ChemdescmaccsBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_buffer_mean(s : ChemdescmaccsBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_buffer_scale(s : ChemdescmaccsBuffer, f : Double) -> ChemdescmaccsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_buffer_add(a : ChemdescmaccsBuffer, b : ChemdescmaccsBuffer) -> ChemdescmaccsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_buffer_copy(s : ChemdescmaccsBuffer) -> ChemdescmaccsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_buffer_fill(s : ChemdescmaccsBuffer, v : Double) -> ChemdescmaccsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_buffer_min(s : ChemdescmaccsBuffer) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_buffer_max(s : ChemdescmaccsBuffer) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_buffer_to_string(s : ChemdescmaccsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_cursor_make(size : Int) -> ChemdescmaccsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_cursor_len(s : ChemdescmaccsCursor) -> Int { s.size }

pub fn chem_desc_maccs_cursor_get(s : ChemdescmaccsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_cursor_set(s : ChemdescmaccsCursor, i : Int, v : Double) -> ChemdescmaccsCursor {
  let result = chem_desc_maccs_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_maccs_cursor_sum(s : ChemdescmaccsCursor) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_cursor_mean(s : ChemdescmaccsCursor) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_cursor_scale(s : ChemdescmaccsCursor, f : Double) -> ChemdescmaccsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_cursor_add(a : ChemdescmaccsCursor, b : ChemdescmaccsCursor) -> ChemdescmaccsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_cursor_copy(s : ChemdescmaccsCursor) -> ChemdescmaccsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_cursor_fill(s : ChemdescmaccsCursor, v : Double) -> ChemdescmaccsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_cursor_min(s : ChemdescmaccsCursor) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_cursor_max(s : ChemdescmaccsCursor) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_cursor_to_string(s : ChemdescmaccsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_view_make(size : Int) -> ChemdescmaccsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_view_len(s : ChemdescmaccsView) -> Int { s.size }

pub fn chem_desc_maccs_view_get(s : ChemdescmaccsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_view_set(s : ChemdescmaccsView, i : Int, v : Double) -> ChemdescmaccsView {
  let result = chem_desc_maccs_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_maccs_view_sum(s : ChemdescmaccsView) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_view_mean(s : ChemdescmaccsView) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_view_scale(s : ChemdescmaccsView, f : Double) -> ChemdescmaccsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_view_add(a : ChemdescmaccsView, b : ChemdescmaccsView) -> ChemdescmaccsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_view_copy(s : ChemdescmaccsView) -> ChemdescmaccsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_view_fill(s : ChemdescmaccsView, v : Double) -> ChemdescmaccsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_view_min(s : ChemdescmaccsView) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_view_max(s : ChemdescmaccsView) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_view_to_string(s : ChemdescmaccsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_range_make(size : Int) -> ChemdescmaccsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_range_len(s : ChemdescmaccsRange) -> Int { s.size }

pub fn chem_desc_maccs_range_get(s : ChemdescmaccsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_range_set(s : ChemdescmaccsRange, i : Int, v : Double) -> ChemdescmaccsRange {
  let result = chem_desc_maccs_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_maccs_range_sum(s : ChemdescmaccsRange) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_range_mean(s : ChemdescmaccsRange) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_range_scale(s : ChemdescmaccsRange, f : Double) -> ChemdescmaccsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_range_add(a : ChemdescmaccsRange, b : ChemdescmaccsRange) -> ChemdescmaccsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_range_copy(s : ChemdescmaccsRange) -> ChemdescmaccsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_range_fill(s : ChemdescmaccsRange, v : Double) -> ChemdescmaccsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_range_min(s : ChemdescmaccsRange) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_range_max(s : ChemdescmaccsRange) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_range_to_string(s : ChemdescmaccsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_slice_make(size : Int) -> ChemdescmaccsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_maccs_slice_len(s : ChemdescmaccsSlice) -> Int { s.size }

pub fn chem_desc_maccs_slice_get(s : ChemdescmaccsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_maccs_slice_set(s : ChemdescmaccsSlice, i : Int, v : Double) -> ChemdescmaccsSlice {
  let result = chem_desc_maccs_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_maccs_slice_sum(s : ChemdescmaccsSlice) -> Double { @_common.sum(s.data) }

pub fn chem_desc_maccs_slice_mean(s : ChemdescmaccsSlice) -> Double { @_common.mean(s.data) }

pub fn chem_desc_maccs_slice_scale(s : ChemdescmaccsSlice, f : Double) -> ChemdescmaccsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_slice_add(a : ChemdescmaccsSlice, b : ChemdescmaccsSlice) -> ChemdescmaccsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_maccs_slice_copy(s : ChemdescmaccsSlice) -> ChemdescmaccsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_slice_fill(s : ChemdescmaccsSlice, v : Double) -> ChemdescmaccsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_maccs_slice_min(s : ChemdescmaccsSlice) -> Double { @_common.min(s.data) }

pub fn chem_desc_maccs_slice_max(s : ChemdescmaccsSlice) -> Double { @_common.max(s.data) }

pub fn chem_desc_maccs_slice_to_string(s : ChemdescmaccsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

