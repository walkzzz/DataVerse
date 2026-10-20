///===
/// extcore/opt_meta_sa

pub(all) struct OptmetasaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_sa_make_point(x : Double, y : Double) -> OptmetasaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_sa_make_point3(x : Double, y : Double, z : Double) -> OptmetasaPoint {
  { x, y, z, label: 0 }
}

pub fn opt_meta_sa_point_x(pt : OptmetasaPoint) -> Double { pt.x }

pub fn opt_meta_sa_point_y(pt : OptmetasaPoint) -> Double { pt.y }

pub fn opt_meta_sa_point_z(pt : OptmetasaPoint) -> Double { pt.z }

pub fn opt_meta_sa_point_label(pt : OptmetasaPoint) -> Int { pt.label }

pub fn opt_meta_sa_point_dist(a : OptmetasaPoint, b : OptmetasaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_meta_sa_point_add(a : OptmetasaPoint, b : OptmetasaPoint) -> OptmetasaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_meta_sa_point_sub(a : OptmetasaPoint, b : OptmetasaPoint) -> OptmetasaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_meta_sa_point_scale(pt : OptmetasaPoint, s : Double) -> OptmetasaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_meta_sa_point_dot(a : OptmetasaPoint, b : OptmetasaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_meta_sa_point_cross(a : OptmetasaPoint, b : OptmetasaPoint) -> OptmetasaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_meta_sa_point_norm(pt : OptmetasaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_meta_sa_point_normalize(pt : OptmetasaPoint) -> OptmetasaPoint {
  let n = opt_meta_sa_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_meta_sa_point_scale(pt, 1.0 / n) }
}

pub fn opt_meta_sa_point_negate(pt : OptmetasaPoint) -> OptmetasaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_meta_sa_point_mid(a : OptmetasaPoint, b : OptmetasaPoint) -> OptmetasaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_meta_sa_point_lerp(a : OptmetasaPoint, b : OptmetasaPoint, t : Double) -> OptmetasaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_meta_sa_point_to_string(pt : OptmetasaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptmetasaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_sa_make_series(vals : Array[Double], name : String) -> OptmetasaSeries {
  { vals, name, meta: 0 }
}

pub fn opt_meta_sa_series_len(s : OptmetasaSeries) -> Int { s.vals.length() }

pub fn opt_meta_sa_series_sum(s : OptmetasaSeries) -> Double { @_common.sum(s.vals) }

pub fn opt_meta_sa_series_mean(s : OptmetasaSeries) -> Double { @_common.mean(s.vals) }

pub fn opt_meta_sa_series_min(s : OptmetasaSeries) -> Double { @_common.min(s.vals) }

pub fn opt_meta_sa_series_max(s : OptmetasaSeries) -> Double { @_common.max(s.vals) }

pub fn opt_meta_sa_series_range(s : OptmetasaSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn opt_meta_sa_series_var(s : OptmetasaSeries) -> Double { @_common.variance(s.vals) }

pub fn opt_meta_sa_series_std(s : OptmetasaSeries) -> Double { @_common.std(s.vals) }

pub fn opt_meta_sa_series_median(s : OptmetasaSeries) -> Double { @_common.median(s.vals) }

pub fn opt_meta_sa_series_scale(s : OptmetasaSeries, f : Double) -> OptmetasaSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_meta_sa_series_add(a : OptmetasaSeries, b : OptmetasaSeries) -> OptmetasaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_meta_sa_series_sub(a : OptmetasaSeries, b : OptmetasaSeries) -> OptmetasaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_meta_sa_series_normalize(s : OptmetasaSeries) -> OptmetasaSeries {
  let mn = opt_meta_sa_series_min(s)
  let mx = opt_meta_sa_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_meta_sa_series_cumsum(s : OptmetasaSeries) -> OptmetasaSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_meta_sa_series_to_string(s : OptmetasaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetasaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_sa_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetasaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_sa_matrix_identity(n : Int) -> OptmetasaMatrix {
  let m = opt_meta_sa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_meta_sa_matrix_get(m : OptmetasaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_meta_sa_matrix_transpose(m : OptmetasaMatrix) -> OptmetasaMatrix {
  let result = opt_meta_sa_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_meta_sa_matrix_add(a : OptmetasaMatrix, b : OptmetasaMatrix) -> OptmetasaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_meta_sa_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_meta_sa_matrix_scale(m : OptmetasaMatrix, s : Double) -> OptmetasaMatrix {
  let result = opt_meta_sa_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_meta_sa_matrix_multiply(a : OptmetasaMatrix, b : OptmetasaMatrix) -> OptmetasaMatrix {
  if a.cols != b.rows { return opt_meta_sa_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_meta_sa_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_meta_sa_matrix_trace(m : OptmetasaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_meta_sa_matrix_det(m : OptmetasaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_meta_sa_matrix_norm(m : OptmetasaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn opt_meta_sa_matrix_to_string(m : OptmetasaMatrix) -> String {
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

pub(all) struct OptmetasaVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_sa_make_vector(comps : Array[Double]) -> OptmetasaVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_sa_vector_zero(dim : Int) -> OptmetasaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_meta_sa_vector_add(a : OptmetasaVector, b : OptmetasaVector) -> OptmetasaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_meta_sa_vector_sub(a : OptmetasaVector, b : OptmetasaVector) -> OptmetasaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_meta_sa_vector_scale(v : OptmetasaVector, s : Double) -> OptmetasaVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_meta_sa_vector_dot(a : OptmetasaVector, b : OptmetasaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_meta_sa_vector_norm(v : OptmetasaVector) -> Double { @_common.sqrt(opt_meta_sa_vector_dot(v, v)) }

pub fn opt_meta_sa_vector_normalize(v : OptmetasaVector) -> OptmetasaVector {
  let n = opt_meta_sa_vector_norm(v)
  if n < 0.0000001 { v } else { opt_meta_sa_vector_scale(v, 1.0 / n) }
}

pub fn opt_meta_sa_vector_dist(a : OptmetasaVector, b : OptmetasaVector) -> Double {
  opt_meta_sa_vector_norm(opt_meta_sa_vector_sub(a, b))
}

pub fn opt_meta_sa_vector_to_string(v : OptmetasaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_meta_sa_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_meta_sa_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_meta_sa_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_meta_sa_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_meta_sa_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_meta_sa_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_meta_sa_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_meta_sa_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_meta_sa_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_meta_sa_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_meta_sa_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_meta_sa_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_meta_sa_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_meta_sa_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_meta_sa_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_meta_sa_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_meta_sa_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_meta_sa_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_meta_sa_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_meta_sa_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_meta_sa_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_meta_sa_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_meta_sa_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_meta_sa_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_meta_sa_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_meta_sa_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_meta_sa_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_meta_sa_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_meta_sa_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptmetasaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_frame_make(size : Int) -> OptmetasaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_frame_len(s : OptmetasaFrame) -> Int { s.size }

pub fn opt_meta_sa_frame_get(s : OptmetasaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_frame_set(s : OptmetasaFrame, i : Int, v : Double) -> OptmetasaFrame {
  let result = opt_meta_sa_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_frame_sum(s : OptmetasaFrame) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_frame_mean(s : OptmetasaFrame) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_frame_scale(s : OptmetasaFrame, f : Double) -> OptmetasaFrame {
  let result = opt_meta_sa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_frame_add(a : OptmetasaFrame, b : OptmetasaFrame) -> OptmetasaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_frame_copy(s : OptmetasaFrame) -> OptmetasaFrame {
  let result = opt_meta_sa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_frame_fill(s : OptmetasaFrame, v : Double) -> OptmetasaFrame {
  let result = opt_meta_sa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_frame_min(s : OptmetasaFrame) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_frame_max(s : OptmetasaFrame) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_frame_to_string(s : OptmetasaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_table_make(size : Int) -> OptmetasaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_table_len(s : OptmetasaTable) -> Int { s.size }

pub fn opt_meta_sa_table_get(s : OptmetasaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_table_set(s : OptmetasaTable, i : Int, v : Double) -> OptmetasaTable {
  let result = opt_meta_sa_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_table_sum(s : OptmetasaTable) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_table_mean(s : OptmetasaTable) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_table_scale(s : OptmetasaTable, f : Double) -> OptmetasaTable {
  let result = opt_meta_sa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_table_add(a : OptmetasaTable, b : OptmetasaTable) -> OptmetasaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_table_copy(s : OptmetasaTable) -> OptmetasaTable {
  let result = opt_meta_sa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_table_fill(s : OptmetasaTable, v : Double) -> OptmetasaTable {
  let result = opt_meta_sa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_table_min(s : OptmetasaTable) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_table_max(s : OptmetasaTable) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_table_to_string(s : OptmetasaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_graphn_make(size : Int) -> OptmetasaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_graphn_len(s : OptmetasaGraphN) -> Int { s.size }

pub fn opt_meta_sa_graphn_get(s : OptmetasaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_graphn_set(s : OptmetasaGraphN, i : Int, v : Double) -> OptmetasaGraphN {
  let result = opt_meta_sa_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_graphn_sum(s : OptmetasaGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_graphn_mean(s : OptmetasaGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_graphn_scale(s : OptmetasaGraphN, f : Double) -> OptmetasaGraphN {
  let result = opt_meta_sa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_graphn_add(a : OptmetasaGraphN, b : OptmetasaGraphN) -> OptmetasaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_graphn_copy(s : OptmetasaGraphN) -> OptmetasaGraphN {
  let result = opt_meta_sa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_graphn_fill(s : OptmetasaGraphN, v : Double) -> OptmetasaGraphN {
  let result = opt_meta_sa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_graphn_min(s : OptmetasaGraphN) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_graphn_max(s : OptmetasaGraphN) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_graphn_to_string(s : OptmetasaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_node_make(size : Int) -> OptmetasaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_node_len(s : OptmetasaNode) -> Int { s.size }

pub fn opt_meta_sa_node_get(s : OptmetasaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_node_set(s : OptmetasaNode, i : Int, v : Double) -> OptmetasaNode {
  let result = opt_meta_sa_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_node_sum(s : OptmetasaNode) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_node_mean(s : OptmetasaNode) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_node_scale(s : OptmetasaNode, f : Double) -> OptmetasaNode {
  let result = opt_meta_sa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_node_add(a : OptmetasaNode, b : OptmetasaNode) -> OptmetasaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_node_copy(s : OptmetasaNode) -> OptmetasaNode {
  let result = opt_meta_sa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_node_fill(s : OptmetasaNode, v : Double) -> OptmetasaNode {
  let result = opt_meta_sa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_node_min(s : OptmetasaNode) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_node_max(s : OptmetasaNode) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_node_to_string(s : OptmetasaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_edge_make(size : Int) -> OptmetasaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_edge_len(s : OptmetasaEdge) -> Int { s.size }

pub fn opt_meta_sa_edge_get(s : OptmetasaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_edge_set(s : OptmetasaEdge, i : Int, v : Double) -> OptmetasaEdge {
  let result = opt_meta_sa_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_edge_sum(s : OptmetasaEdge) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_edge_mean(s : OptmetasaEdge) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_edge_scale(s : OptmetasaEdge, f : Double) -> OptmetasaEdge {
  let result = opt_meta_sa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_edge_add(a : OptmetasaEdge, b : OptmetasaEdge) -> OptmetasaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_edge_copy(s : OptmetasaEdge) -> OptmetasaEdge {
  let result = opt_meta_sa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_edge_fill(s : OptmetasaEdge, v : Double) -> OptmetasaEdge {
  let result = opt_meta_sa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_edge_min(s : OptmetasaEdge) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_edge_max(s : OptmetasaEdge) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_edge_to_string(s : OptmetasaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_path_make(size : Int) -> OptmetasaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_path_len(s : OptmetasaPath) -> Int { s.size }

pub fn opt_meta_sa_path_get(s : OptmetasaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_path_set(s : OptmetasaPath, i : Int, v : Double) -> OptmetasaPath {
  let result = opt_meta_sa_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_path_sum(s : OptmetasaPath) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_path_mean(s : OptmetasaPath) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_path_scale(s : OptmetasaPath, f : Double) -> OptmetasaPath {
  let result = opt_meta_sa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_path_add(a : OptmetasaPath, b : OptmetasaPath) -> OptmetasaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_path_copy(s : OptmetasaPath) -> OptmetasaPath {
  let result = opt_meta_sa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_path_fill(s : OptmetasaPath, v : Double) -> OptmetasaPath {
  let result = opt_meta_sa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_path_min(s : OptmetasaPath) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_path_max(s : OptmetasaPath) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_path_to_string(s : OptmetasaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_cluster_make(size : Int) -> OptmetasaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_cluster_len(s : OptmetasaCluster) -> Int { s.size }

pub fn opt_meta_sa_cluster_get(s : OptmetasaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_cluster_set(s : OptmetasaCluster, i : Int, v : Double) -> OptmetasaCluster {
  let result = opt_meta_sa_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_cluster_sum(s : OptmetasaCluster) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_cluster_mean(s : OptmetasaCluster) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_cluster_scale(s : OptmetasaCluster, f : Double) -> OptmetasaCluster {
  let result = opt_meta_sa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_cluster_add(a : OptmetasaCluster, b : OptmetasaCluster) -> OptmetasaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_cluster_copy(s : OptmetasaCluster) -> OptmetasaCluster {
  let result = opt_meta_sa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_cluster_fill(s : OptmetasaCluster, v : Double) -> OptmetasaCluster {
  let result = opt_meta_sa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_cluster_min(s : OptmetasaCluster) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_cluster_max(s : OptmetasaCluster) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_cluster_to_string(s : OptmetasaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_model_make(size : Int) -> OptmetasaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_model_len(s : OptmetasaModel) -> Int { s.size }

pub fn opt_meta_sa_model_get(s : OptmetasaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_model_set(s : OptmetasaModel, i : Int, v : Double) -> OptmetasaModel {
  let result = opt_meta_sa_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_model_sum(s : OptmetasaModel) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_model_mean(s : OptmetasaModel) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_model_scale(s : OptmetasaModel, f : Double) -> OptmetasaModel {
  let result = opt_meta_sa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_model_add(a : OptmetasaModel, b : OptmetasaModel) -> OptmetasaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_model_copy(s : OptmetasaModel) -> OptmetasaModel {
  let result = opt_meta_sa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_model_fill(s : OptmetasaModel, v : Double) -> OptmetasaModel {
  let result = opt_meta_sa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_model_min(s : OptmetasaModel) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_model_max(s : OptmetasaModel) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_model_to_string(s : OptmetasaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_layer_make(size : Int) -> OptmetasaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_layer_len(s : OptmetasaLayer) -> Int { s.size }

pub fn opt_meta_sa_layer_get(s : OptmetasaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_layer_set(s : OptmetasaLayer, i : Int, v : Double) -> OptmetasaLayer {
  let result = opt_meta_sa_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_layer_sum(s : OptmetasaLayer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_layer_mean(s : OptmetasaLayer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_layer_scale(s : OptmetasaLayer, f : Double) -> OptmetasaLayer {
  let result = opt_meta_sa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_layer_add(a : OptmetasaLayer, b : OptmetasaLayer) -> OptmetasaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_layer_copy(s : OptmetasaLayer) -> OptmetasaLayer {
  let result = opt_meta_sa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_layer_fill(s : OptmetasaLayer, v : Double) -> OptmetasaLayer {
  let result = opt_meta_sa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_layer_min(s : OptmetasaLayer) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_layer_max(s : OptmetasaLayer) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_layer_to_string(s : OptmetasaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_buffer_make(size : Int) -> OptmetasaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_buffer_len(s : OptmetasaBuffer) -> Int { s.size }

pub fn opt_meta_sa_buffer_get(s : OptmetasaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_buffer_set(s : OptmetasaBuffer, i : Int, v : Double) -> OptmetasaBuffer {
  let result = opt_meta_sa_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_buffer_sum(s : OptmetasaBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_buffer_mean(s : OptmetasaBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_buffer_scale(s : OptmetasaBuffer, f : Double) -> OptmetasaBuffer {
  let result = opt_meta_sa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_buffer_add(a : OptmetasaBuffer, b : OptmetasaBuffer) -> OptmetasaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_buffer_copy(s : OptmetasaBuffer) -> OptmetasaBuffer {
  let result = opt_meta_sa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_buffer_fill(s : OptmetasaBuffer, v : Double) -> OptmetasaBuffer {
  let result = opt_meta_sa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_buffer_min(s : OptmetasaBuffer) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_buffer_max(s : OptmetasaBuffer) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_buffer_to_string(s : OptmetasaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_cursor_make(size : Int) -> OptmetasaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_cursor_len(s : OptmetasaCursor) -> Int { s.size }

pub fn opt_meta_sa_cursor_get(s : OptmetasaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_cursor_set(s : OptmetasaCursor, i : Int, v : Double) -> OptmetasaCursor {
  let result = opt_meta_sa_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_cursor_sum(s : OptmetasaCursor) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_cursor_mean(s : OptmetasaCursor) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_cursor_scale(s : OptmetasaCursor, f : Double) -> OptmetasaCursor {
  let result = opt_meta_sa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_cursor_add(a : OptmetasaCursor, b : OptmetasaCursor) -> OptmetasaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_cursor_copy(s : OptmetasaCursor) -> OptmetasaCursor {
  let result = opt_meta_sa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_cursor_fill(s : OptmetasaCursor, v : Double) -> OptmetasaCursor {
  let result = opt_meta_sa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_cursor_min(s : OptmetasaCursor) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_cursor_max(s : OptmetasaCursor) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_cursor_to_string(s : OptmetasaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_view_make(size : Int) -> OptmetasaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_view_len(s : OptmetasaView) -> Int { s.size }

pub fn opt_meta_sa_view_get(s : OptmetasaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_view_set(s : OptmetasaView, i : Int, v : Double) -> OptmetasaView {
  let result = opt_meta_sa_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_view_sum(s : OptmetasaView) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_view_mean(s : OptmetasaView) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_view_scale(s : OptmetasaView, f : Double) -> OptmetasaView {
  let result = opt_meta_sa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_view_add(a : OptmetasaView, b : OptmetasaView) -> OptmetasaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_view_copy(s : OptmetasaView) -> OptmetasaView {
  let result = opt_meta_sa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_view_fill(s : OptmetasaView, v : Double) -> OptmetasaView {
  let result = opt_meta_sa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_view_min(s : OptmetasaView) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_view_max(s : OptmetasaView) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_view_to_string(s : OptmetasaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_range_make(size : Int) -> OptmetasaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_range_len(s : OptmetasaRange) -> Int { s.size }

pub fn opt_meta_sa_range_get(s : OptmetasaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_range_set(s : OptmetasaRange, i : Int, v : Double) -> OptmetasaRange {
  let result = opt_meta_sa_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_range_sum(s : OptmetasaRange) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_range_mean(s : OptmetasaRange) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_range_scale(s : OptmetasaRange, f : Double) -> OptmetasaRange {
  let result = opt_meta_sa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_range_add(a : OptmetasaRange, b : OptmetasaRange) -> OptmetasaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_range_copy(s : OptmetasaRange) -> OptmetasaRange {
  let result = opt_meta_sa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_range_fill(s : OptmetasaRange, v : Double) -> OptmetasaRange {
  let result = opt_meta_sa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_range_min(s : OptmetasaRange) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_range_max(s : OptmetasaRange) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_range_to_string(s : OptmetasaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_slice_make(size : Int) -> OptmetasaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_slice_len(s : OptmetasaSlice) -> Int { s.size }

pub fn opt_meta_sa_slice_get(s : OptmetasaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_slice_set(s : OptmetasaSlice, i : Int, v : Double) -> OptmetasaSlice {
  let result = opt_meta_sa_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_slice_sum(s : OptmetasaSlice) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_slice_mean(s : OptmetasaSlice) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_slice_scale(s : OptmetasaSlice, f : Double) -> OptmetasaSlice {
  let result = opt_meta_sa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_slice_add(a : OptmetasaSlice, b : OptmetasaSlice) -> OptmetasaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_slice_copy(s : OptmetasaSlice) -> OptmetasaSlice {
  let result = opt_meta_sa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_slice_fill(s : OptmetasaSlice, v : Double) -> OptmetasaSlice {
  let result = opt_meta_sa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_slice_min(s : OptmetasaSlice) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_slice_max(s : OptmetasaSlice) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_slice_to_string(s : OptmetasaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

