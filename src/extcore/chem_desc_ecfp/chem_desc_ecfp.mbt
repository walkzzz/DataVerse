///===
/// extcore/chem_desc_ecfp

pub(all) struct ChemdescecfpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_ecfp_make_point(x : Double, y : Double) -> ChemdescecfpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_ecfp_make_point3(x : Double, y : Double, z : Double) -> ChemdescecfpPoint {
  { x, y, z, label: 0 }
}

pub fn chem_desc_ecfp_point_x(pt : ChemdescecfpPoint) -> Double { pt.x }

pub fn chem_desc_ecfp_point_y(pt : ChemdescecfpPoint) -> Double { pt.y }

pub fn chem_desc_ecfp_point_z(pt : ChemdescecfpPoint) -> Double { pt.z }

pub fn chem_desc_ecfp_point_label(pt : ChemdescecfpPoint) -> Int { pt.label }

pub fn chem_desc_ecfp_point_dist(a : ChemdescecfpPoint, b : ChemdescecfpPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_desc_ecfp_point_add(a : ChemdescecfpPoint, b : ChemdescecfpPoint) -> ChemdescecfpPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_desc_ecfp_point_sub(a : ChemdescecfpPoint, b : ChemdescecfpPoint) -> ChemdescecfpPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_desc_ecfp_point_scale(pt : ChemdescecfpPoint, s : Double) -> ChemdescecfpPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_desc_ecfp_point_dot(a : ChemdescecfpPoint, b : ChemdescecfpPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_desc_ecfp_point_cross(a : ChemdescecfpPoint, b : ChemdescecfpPoint) -> ChemdescecfpPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_desc_ecfp_point_norm(pt : ChemdescecfpPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_desc_ecfp_point_normalize(pt : ChemdescecfpPoint) -> ChemdescecfpPoint {
  let n = chem_desc_ecfp_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_desc_ecfp_point_scale(pt, 1.0 / n) }
}

pub fn chem_desc_ecfp_point_negate(pt : ChemdescecfpPoint) -> ChemdescecfpPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_desc_ecfp_point_mid(a : ChemdescecfpPoint, b : ChemdescecfpPoint) -> ChemdescecfpPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_desc_ecfp_point_lerp(a : ChemdescecfpPoint, b : ChemdescecfpPoint, t : Double) -> ChemdescecfpPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_desc_ecfp_point_to_string(pt : ChemdescecfpPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemdescecfpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_ecfp_make_series(vals : Array[Double], name : String) -> ChemdescecfpSeries {
  { vals, name, meta: 0 }
}

pub fn chem_desc_ecfp_series_len(s : ChemdescecfpSeries) -> Int { s.vals.length() }

pub fn chem_desc_ecfp_series_sum(s : ChemdescecfpSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_desc_ecfp_series_mean(s : ChemdescecfpSeries) -> Double { @_common.mean(s.vals) }

pub fn chem_desc_ecfp_series_min(s : ChemdescecfpSeries) -> Double { @_common.min(s.vals) }

pub fn chem_desc_ecfp_series_max(s : ChemdescecfpSeries) -> Double { @_common.max(s.vals) }

pub fn chem_desc_ecfp_series_range(s : ChemdescecfpSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn chem_desc_ecfp_series_var(s : ChemdescecfpSeries) -> Double { @_common.variance(s.vals) }

pub fn chem_desc_ecfp_series_std(s : ChemdescecfpSeries) -> Double { @_common.std(s.vals) }

pub fn chem_desc_ecfp_series_median(s : ChemdescecfpSeries) -> Double { @_common.median(s.vals) }

pub fn chem_desc_ecfp_series_scale(s : ChemdescecfpSeries, f : Double) -> ChemdescecfpSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_desc_ecfp_series_add(a : ChemdescecfpSeries, b : ChemdescecfpSeries) -> ChemdescecfpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_desc_ecfp_series_sub(a : ChemdescecfpSeries, b : ChemdescecfpSeries) -> ChemdescecfpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_desc_ecfp_series_normalize(s : ChemdescecfpSeries) -> ChemdescecfpSeries {
  let mn = chem_desc_ecfp_series_min(s)
  let mx = chem_desc_ecfp_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_desc_ecfp_series_cumsum(s : ChemdescecfpSeries) -> ChemdescecfpSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_desc_ecfp_series_to_string(s : ChemdescecfpSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescecfpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_ecfp_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdescecfpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_desc_ecfp_matrix_identity(n : Int) -> ChemdescecfpMatrix {
  let m = chem_desc_ecfp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_desc_ecfp_matrix_get(m : ChemdescecfpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_desc_ecfp_matrix_transpose(m : ChemdescecfpMatrix) -> ChemdescecfpMatrix {
  let result = chem_desc_ecfp_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_desc_ecfp_matrix_add(a : ChemdescecfpMatrix, b : ChemdescecfpMatrix) -> ChemdescecfpMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_desc_ecfp_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_desc_ecfp_matrix_scale(m : ChemdescecfpMatrix, s : Double) -> ChemdescecfpMatrix {
  let result = chem_desc_ecfp_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_desc_ecfp_matrix_multiply(a : ChemdescecfpMatrix, b : ChemdescecfpMatrix) -> ChemdescecfpMatrix {
  if a.cols != b.rows { return chem_desc_ecfp_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_desc_ecfp_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_desc_ecfp_matrix_trace(m : ChemdescecfpMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_desc_ecfp_matrix_det(m : ChemdescecfpMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_desc_ecfp_matrix_norm(m : ChemdescecfpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_desc_ecfp_matrix_to_string(m : ChemdescecfpMatrix) -> String {
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

pub(all) struct ChemdescecfpVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_ecfp_make_vector(comps : Array[Double]) -> ChemdescecfpVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_ecfp_vector_zero(dim : Int) -> ChemdescecfpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_desc_ecfp_vector_add(a : ChemdescecfpVector, b : ChemdescecfpVector) -> ChemdescecfpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_desc_ecfp_vector_sub(a : ChemdescecfpVector, b : ChemdescecfpVector) -> ChemdescecfpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_desc_ecfp_vector_scale(v : ChemdescecfpVector, s : Double) -> ChemdescecfpVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_desc_ecfp_vector_dot(a : ChemdescecfpVector, b : ChemdescecfpVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_desc_ecfp_vector_norm(v : ChemdescecfpVector) -> Double { @_common.sqrt(chem_desc_ecfp_vector_dot(v, v)) }

pub fn chem_desc_ecfp_vector_normalize(v : ChemdescecfpVector) -> ChemdescecfpVector {
  let n = chem_desc_ecfp_vector_norm(v)
  if n < 0.0000001 { v } else { chem_desc_ecfp_vector_scale(v, 1.0 / n) }
}

pub fn chem_desc_ecfp_vector_dist(a : ChemdescecfpVector, b : ChemdescecfpVector) -> Double {
  chem_desc_ecfp_vector_norm(chem_desc_ecfp_vector_sub(a, b))
}

pub fn chem_desc_ecfp_vector_to_string(v : ChemdescecfpVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_desc_ecfp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_desc_ecfp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_desc_ecfp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_desc_ecfp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_desc_ecfp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_desc_ecfp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_desc_ecfp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_desc_ecfp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_desc_ecfp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_desc_ecfp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_desc_ecfp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_desc_ecfp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_desc_ecfp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_desc_ecfp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_desc_ecfp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_desc_ecfp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_desc_ecfp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_desc_ecfp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_desc_ecfp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_desc_ecfp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_desc_ecfp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_desc_ecfp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_desc_ecfp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_desc_ecfp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_desc_ecfp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_desc_ecfp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_desc_ecfp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_desc_ecfp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_desc_ecfp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemdescecfpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_frame_make(size : Int) -> ChemdescecfpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_frame_len(s : ChemdescecfpFrame) -> Int { s.size }

pub fn chem_desc_ecfp_frame_get(s : ChemdescecfpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_frame_set(s : ChemdescecfpFrame, i : Int, v : Double) -> ChemdescecfpFrame {
  let result = chem_desc_ecfp_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_frame_sum(s : ChemdescecfpFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_ecfp_frame_mean(s : ChemdescecfpFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_ecfp_frame_sum(s) / s.size.to_double() }
}

pub fn chem_desc_ecfp_frame_scale(s : ChemdescecfpFrame, f : Double) -> ChemdescecfpFrame {
  let result = chem_desc_ecfp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_ecfp_frame_add(a : ChemdescecfpFrame, b : ChemdescecfpFrame) -> ChemdescecfpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_ecfp_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_ecfp_frame_copy(s : ChemdescecfpFrame) -> ChemdescecfpFrame {
  let result = chem_desc_ecfp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_ecfp_frame_fill(s : ChemdescecfpFrame, v : Double) -> ChemdescecfpFrame {
  let result = chem_desc_ecfp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_frame_min(s : ChemdescecfpFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_frame_max(s : ChemdescecfpFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_frame_to_string(s : ChemdescecfpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_table_make(size : Int) -> ChemdescecfpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_table_len(s : ChemdescecfpTable) -> Int { s.size }

pub fn chem_desc_ecfp_table_get(s : ChemdescecfpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_table_set(s : ChemdescecfpTable, i : Int, v : Double) -> ChemdescecfpTable {
  let result = chem_desc_ecfp_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_table_sum(s : ChemdescecfpTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_ecfp_table_mean(s : ChemdescecfpTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_ecfp_table_sum(s) / s.size.to_double() }
}

pub fn chem_desc_ecfp_table_scale(s : ChemdescecfpTable, f : Double) -> ChemdescecfpTable {
  let result = chem_desc_ecfp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_ecfp_table_add(a : ChemdescecfpTable, b : ChemdescecfpTable) -> ChemdescecfpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_ecfp_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_ecfp_table_copy(s : ChemdescecfpTable) -> ChemdescecfpTable {
  let result = chem_desc_ecfp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_ecfp_table_fill(s : ChemdescecfpTable, v : Double) -> ChemdescecfpTable {
  let result = chem_desc_ecfp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_table_min(s : ChemdescecfpTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_table_max(s : ChemdescecfpTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_table_to_string(s : ChemdescecfpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_graphn_make(size : Int) -> ChemdescecfpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_graphn_len(s : ChemdescecfpGraphN) -> Int { s.size }

pub fn chem_desc_ecfp_graphn_get(s : ChemdescecfpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_graphn_set(s : ChemdescecfpGraphN, i : Int, v : Double) -> ChemdescecfpGraphN {
  let result = chem_desc_ecfp_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_graphn_sum(s : ChemdescecfpGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_ecfp_graphn_mean(s : ChemdescecfpGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_ecfp_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_desc_ecfp_graphn_scale(s : ChemdescecfpGraphN, f : Double) -> ChemdescecfpGraphN {
  let result = chem_desc_ecfp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_ecfp_graphn_add(a : ChemdescecfpGraphN, b : ChemdescecfpGraphN) -> ChemdescecfpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_ecfp_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_ecfp_graphn_copy(s : ChemdescecfpGraphN) -> ChemdescecfpGraphN {
  let result = chem_desc_ecfp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_ecfp_graphn_fill(s : ChemdescecfpGraphN, v : Double) -> ChemdescecfpGraphN {
  let result = chem_desc_ecfp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_graphn_min(s : ChemdescecfpGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_graphn_max(s : ChemdescecfpGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_graphn_to_string(s : ChemdescecfpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_node_make(size : Int) -> ChemdescecfpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_node_len(s : ChemdescecfpNode) -> Int { s.size }

pub fn chem_desc_ecfp_node_get(s : ChemdescecfpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_node_set(s : ChemdescecfpNode, i : Int, v : Double) -> ChemdescecfpNode {
  let result = chem_desc_ecfp_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_node_sum(s : ChemdescecfpNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_ecfp_node_mean(s : ChemdescecfpNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_ecfp_node_sum(s) / s.size.to_double() }
}

pub fn chem_desc_ecfp_node_scale(s : ChemdescecfpNode, f : Double) -> ChemdescecfpNode {
  let result = chem_desc_ecfp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_ecfp_node_add(a : ChemdescecfpNode, b : ChemdescecfpNode) -> ChemdescecfpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_ecfp_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_ecfp_node_copy(s : ChemdescecfpNode) -> ChemdescecfpNode {
  let result = chem_desc_ecfp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_ecfp_node_fill(s : ChemdescecfpNode, v : Double) -> ChemdescecfpNode {
  let result = chem_desc_ecfp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_node_min(s : ChemdescecfpNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_node_max(s : ChemdescecfpNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_node_to_string(s : ChemdescecfpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_edge_make(size : Int) -> ChemdescecfpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_edge_len(s : ChemdescecfpEdge) -> Int { s.size }

pub fn chem_desc_ecfp_edge_get(s : ChemdescecfpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_edge_set(s : ChemdescecfpEdge, i : Int, v : Double) -> ChemdescecfpEdge {
  let result = chem_desc_ecfp_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_edge_sum(s : ChemdescecfpEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_ecfp_edge_mean(s : ChemdescecfpEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_ecfp_edge_sum(s) / s.size.to_double() }
}

pub fn chem_desc_ecfp_edge_scale(s : ChemdescecfpEdge, f : Double) -> ChemdescecfpEdge {
  let result = chem_desc_ecfp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_ecfp_edge_add(a : ChemdescecfpEdge, b : ChemdescecfpEdge) -> ChemdescecfpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_ecfp_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_ecfp_edge_copy(s : ChemdescecfpEdge) -> ChemdescecfpEdge {
  let result = chem_desc_ecfp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_ecfp_edge_fill(s : ChemdescecfpEdge, v : Double) -> ChemdescecfpEdge {
  let result = chem_desc_ecfp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_edge_min(s : ChemdescecfpEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_edge_max(s : ChemdescecfpEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_edge_to_string(s : ChemdescecfpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_path_make(size : Int) -> ChemdescecfpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_path_len(s : ChemdescecfpPath) -> Int { s.size }

pub fn chem_desc_ecfp_path_get(s : ChemdescecfpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_path_set(s : ChemdescecfpPath, i : Int, v : Double) -> ChemdescecfpPath {
  let result = chem_desc_ecfp_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_path_sum(s : ChemdescecfpPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_ecfp_path_mean(s : ChemdescecfpPath) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_ecfp_path_sum(s) / s.size.to_double() }
}

pub fn chem_desc_ecfp_path_scale(s : ChemdescecfpPath, f : Double) -> ChemdescecfpPath {
  let result = chem_desc_ecfp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_ecfp_path_add(a : ChemdescecfpPath, b : ChemdescecfpPath) -> ChemdescecfpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_ecfp_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_ecfp_path_copy(s : ChemdescecfpPath) -> ChemdescecfpPath {
  let result = chem_desc_ecfp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_ecfp_path_fill(s : ChemdescecfpPath, v : Double) -> ChemdescecfpPath {
  let result = chem_desc_ecfp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_path_min(s : ChemdescecfpPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_path_max(s : ChemdescecfpPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_path_to_string(s : ChemdescecfpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_cluster_make(size : Int) -> ChemdescecfpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_cluster_len(s : ChemdescecfpCluster) -> Int { s.size }

pub fn chem_desc_ecfp_cluster_get(s : ChemdescecfpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_cluster_set(s : ChemdescecfpCluster, i : Int, v : Double) -> ChemdescecfpCluster {
  let result = chem_desc_ecfp_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_cluster_sum(s : ChemdescecfpCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_ecfp_cluster_mean(s : ChemdescecfpCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_ecfp_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_desc_ecfp_cluster_scale(s : ChemdescecfpCluster, f : Double) -> ChemdescecfpCluster {
  let result = chem_desc_ecfp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_ecfp_cluster_add(a : ChemdescecfpCluster, b : ChemdescecfpCluster) -> ChemdescecfpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_ecfp_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_ecfp_cluster_copy(s : ChemdescecfpCluster) -> ChemdescecfpCluster {
  let result = chem_desc_ecfp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_ecfp_cluster_fill(s : ChemdescecfpCluster, v : Double) -> ChemdescecfpCluster {
  let result = chem_desc_ecfp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_cluster_min(s : ChemdescecfpCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_cluster_max(s : ChemdescecfpCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_cluster_to_string(s : ChemdescecfpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_model_make(size : Int) -> ChemdescecfpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_model_len(s : ChemdescecfpModel) -> Int { s.size }

pub fn chem_desc_ecfp_model_get(s : ChemdescecfpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_model_set(s : ChemdescecfpModel, i : Int, v : Double) -> ChemdescecfpModel {
  let result = chem_desc_ecfp_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_model_sum(s : ChemdescecfpModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_ecfp_model_mean(s : ChemdescecfpModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_ecfp_model_sum(s) / s.size.to_double() }
}

pub fn chem_desc_ecfp_model_scale(s : ChemdescecfpModel, f : Double) -> ChemdescecfpModel {
  let result = chem_desc_ecfp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_ecfp_model_add(a : ChemdescecfpModel, b : ChemdescecfpModel) -> ChemdescecfpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_ecfp_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_ecfp_model_copy(s : ChemdescecfpModel) -> ChemdescecfpModel {
  let result = chem_desc_ecfp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_ecfp_model_fill(s : ChemdescecfpModel, v : Double) -> ChemdescecfpModel {
  let result = chem_desc_ecfp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_model_min(s : ChemdescecfpModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_model_max(s : ChemdescecfpModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_model_to_string(s : ChemdescecfpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_layer_make(size : Int) -> ChemdescecfpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_layer_len(s : ChemdescecfpLayer) -> Int { s.size }

pub fn chem_desc_ecfp_layer_get(s : ChemdescecfpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_layer_set(s : ChemdescecfpLayer, i : Int, v : Double) -> ChemdescecfpLayer {
  let result = chem_desc_ecfp_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_layer_sum(s : ChemdescecfpLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_ecfp_layer_mean(s : ChemdescecfpLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_ecfp_layer_sum(s) / s.size.to_double() }
}

pub fn chem_desc_ecfp_layer_scale(s : ChemdescecfpLayer, f : Double) -> ChemdescecfpLayer {
  let result = chem_desc_ecfp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_ecfp_layer_add(a : ChemdescecfpLayer, b : ChemdescecfpLayer) -> ChemdescecfpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_ecfp_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_ecfp_layer_copy(s : ChemdescecfpLayer) -> ChemdescecfpLayer {
  let result = chem_desc_ecfp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_ecfp_layer_fill(s : ChemdescecfpLayer, v : Double) -> ChemdescecfpLayer {
  let result = chem_desc_ecfp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_layer_min(s : ChemdescecfpLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_layer_max(s : ChemdescecfpLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_layer_to_string(s : ChemdescecfpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_buffer_make(size : Int) -> ChemdescecfpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_buffer_len(s : ChemdescecfpBuffer) -> Int { s.size }

pub fn chem_desc_ecfp_buffer_get(s : ChemdescecfpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_buffer_set(s : ChemdescecfpBuffer, i : Int, v : Double) -> ChemdescecfpBuffer {
  let result = chem_desc_ecfp_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_buffer_sum(s : ChemdescecfpBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_ecfp_buffer_mean(s : ChemdescecfpBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_ecfp_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_desc_ecfp_buffer_scale(s : ChemdescecfpBuffer, f : Double) -> ChemdescecfpBuffer {
  let result = chem_desc_ecfp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_ecfp_buffer_add(a : ChemdescecfpBuffer, b : ChemdescecfpBuffer) -> ChemdescecfpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_ecfp_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_ecfp_buffer_copy(s : ChemdescecfpBuffer) -> ChemdescecfpBuffer {
  let result = chem_desc_ecfp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_ecfp_buffer_fill(s : ChemdescecfpBuffer, v : Double) -> ChemdescecfpBuffer {
  let result = chem_desc_ecfp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_buffer_min(s : ChemdescecfpBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_buffer_max(s : ChemdescecfpBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_buffer_to_string(s : ChemdescecfpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_cursor_make(size : Int) -> ChemdescecfpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_cursor_len(s : ChemdescecfpCursor) -> Int { s.size }

pub fn chem_desc_ecfp_cursor_get(s : ChemdescecfpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_cursor_set(s : ChemdescecfpCursor, i : Int, v : Double) -> ChemdescecfpCursor {
  let result = chem_desc_ecfp_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_cursor_sum(s : ChemdescecfpCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_ecfp_cursor_mean(s : ChemdescecfpCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_ecfp_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_desc_ecfp_cursor_scale(s : ChemdescecfpCursor, f : Double) -> ChemdescecfpCursor {
  let result = chem_desc_ecfp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_ecfp_cursor_add(a : ChemdescecfpCursor, b : ChemdescecfpCursor) -> ChemdescecfpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_ecfp_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_ecfp_cursor_copy(s : ChemdescecfpCursor) -> ChemdescecfpCursor {
  let result = chem_desc_ecfp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_ecfp_cursor_fill(s : ChemdescecfpCursor, v : Double) -> ChemdescecfpCursor {
  let result = chem_desc_ecfp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_cursor_min(s : ChemdescecfpCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_cursor_max(s : ChemdescecfpCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_cursor_to_string(s : ChemdescecfpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_view_make(size : Int) -> ChemdescecfpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_view_len(s : ChemdescecfpView) -> Int { s.size }

pub fn chem_desc_ecfp_view_get(s : ChemdescecfpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_view_set(s : ChemdescecfpView, i : Int, v : Double) -> ChemdescecfpView {
  let result = chem_desc_ecfp_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_view_sum(s : ChemdescecfpView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_ecfp_view_mean(s : ChemdescecfpView) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_ecfp_view_sum(s) / s.size.to_double() }
}

pub fn chem_desc_ecfp_view_scale(s : ChemdescecfpView, f : Double) -> ChemdescecfpView {
  let result = chem_desc_ecfp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_ecfp_view_add(a : ChemdescecfpView, b : ChemdescecfpView) -> ChemdescecfpView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_ecfp_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_ecfp_view_copy(s : ChemdescecfpView) -> ChemdescecfpView {
  let result = chem_desc_ecfp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_ecfp_view_fill(s : ChemdescecfpView, v : Double) -> ChemdescecfpView {
  let result = chem_desc_ecfp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_view_min(s : ChemdescecfpView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_view_max(s : ChemdescecfpView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_view_to_string(s : ChemdescecfpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_range_make(size : Int) -> ChemdescecfpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_range_len(s : ChemdescecfpRange) -> Int { s.size }

pub fn chem_desc_ecfp_range_get(s : ChemdescecfpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_range_set(s : ChemdescecfpRange, i : Int, v : Double) -> ChemdescecfpRange {
  let result = chem_desc_ecfp_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_range_sum(s : ChemdescecfpRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_ecfp_range_mean(s : ChemdescecfpRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_ecfp_range_sum(s) / s.size.to_double() }
}

pub fn chem_desc_ecfp_range_scale(s : ChemdescecfpRange, f : Double) -> ChemdescecfpRange {
  let result = chem_desc_ecfp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_ecfp_range_add(a : ChemdescecfpRange, b : ChemdescecfpRange) -> ChemdescecfpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_ecfp_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_ecfp_range_copy(s : ChemdescecfpRange) -> ChemdescecfpRange {
  let result = chem_desc_ecfp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_ecfp_range_fill(s : ChemdescecfpRange, v : Double) -> ChemdescecfpRange {
  let result = chem_desc_ecfp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_range_min(s : ChemdescecfpRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_range_max(s : ChemdescecfpRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_range_to_string(s : ChemdescecfpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_slice_make(size : Int) -> ChemdescecfpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_slice_len(s : ChemdescecfpSlice) -> Int { s.size }

pub fn chem_desc_ecfp_slice_get(s : ChemdescecfpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_slice_set(s : ChemdescecfpSlice, i : Int, v : Double) -> ChemdescecfpSlice {
  let result = chem_desc_ecfp_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_slice_sum(s : ChemdescecfpSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_ecfp_slice_mean(s : ChemdescecfpSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_ecfp_slice_sum(s) / s.size.to_double() }
}

pub fn chem_desc_ecfp_slice_scale(s : ChemdescecfpSlice, f : Double) -> ChemdescecfpSlice {
  let result = chem_desc_ecfp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_ecfp_slice_add(a : ChemdescecfpSlice, b : ChemdescecfpSlice) -> ChemdescecfpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_ecfp_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_ecfp_slice_copy(s : ChemdescecfpSlice) -> ChemdescecfpSlice {
  let result = chem_desc_ecfp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_ecfp_slice_fill(s : ChemdescecfpSlice, v : Double) -> ChemdescecfpSlice {
  let result = chem_desc_ecfp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_ecfp_slice_min(s : ChemdescecfpSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_slice_max(s : ChemdescecfpSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_ecfp_slice_to_string(s : ChemdescecfpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

