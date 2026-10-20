///===
/// extcore/bio_struct_surface

pub(all) struct BiostructsurfacePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_surface_make_point(x : Double, y : Double) -> BiostructsurfacePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_surface_make_point3(x : Double, y : Double, z : Double) -> BiostructsurfacePoint {
  { x, y, z, label: 0 }
}

pub fn bio_struct_surface_point_x(pt : BiostructsurfacePoint) -> Double { pt.x }

pub fn bio_struct_surface_point_y(pt : BiostructsurfacePoint) -> Double { pt.y }

pub fn bio_struct_surface_point_z(pt : BiostructsurfacePoint) -> Double { pt.z }

pub fn bio_struct_surface_point_label(pt : BiostructsurfacePoint) -> Int { pt.label }

pub fn bio_struct_surface_point_dist(a : BiostructsurfacePoint, b : BiostructsurfacePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_struct_surface_point_add(a : BiostructsurfacePoint, b : BiostructsurfacePoint) -> BiostructsurfacePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_struct_surface_point_sub(a : BiostructsurfacePoint, b : BiostructsurfacePoint) -> BiostructsurfacePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_struct_surface_point_scale(pt : BiostructsurfacePoint, s : Double) -> BiostructsurfacePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_struct_surface_point_dot(a : BiostructsurfacePoint, b : BiostructsurfacePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_struct_surface_point_cross(a : BiostructsurfacePoint, b : BiostructsurfacePoint) -> BiostructsurfacePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_struct_surface_point_norm(pt : BiostructsurfacePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_struct_surface_point_normalize(pt : BiostructsurfacePoint) -> BiostructsurfacePoint {
  let n = bio_struct_surface_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_struct_surface_point_scale(pt, 1.0 / n) }
}

pub fn bio_struct_surface_point_negate(pt : BiostructsurfacePoint) -> BiostructsurfacePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_struct_surface_point_mid(a : BiostructsurfacePoint, b : BiostructsurfacePoint) -> BiostructsurfacePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_struct_surface_point_lerp(a : BiostructsurfacePoint, b : BiostructsurfacePoint, t : Double) -> BiostructsurfacePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_struct_surface_point_to_string(pt : BiostructsurfacePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BiostructsurfaceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_surface_make_series(vals : Array[Double], name : String) -> BiostructsurfaceSeries {
  { vals, name, meta: 0 }
}

pub fn bio_struct_surface_series_len(s : BiostructsurfaceSeries) -> Int { s.vals.length() }

pub fn bio_struct_surface_series_sum(s : BiostructsurfaceSeries) -> Double { @_common.sum(s.vals) }

pub fn bio_struct_surface_series_mean(s : BiostructsurfaceSeries) -> Double { @_common.mean(s.vals) }

pub fn bio_struct_surface_series_min(s : BiostructsurfaceSeries) -> Double { @_common.min(s.vals) }

pub fn bio_struct_surface_series_max(s : BiostructsurfaceSeries) -> Double { @_common.max(s.vals) }

pub fn bio_struct_surface_series_range(s : BiostructsurfaceSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn bio_struct_surface_series_var(s : BiostructsurfaceSeries) -> Double { @_common.variance(s.vals) }

pub fn bio_struct_surface_series_std(s : BiostructsurfaceSeries) -> Double { @_common.std(s.vals) }

pub fn bio_struct_surface_series_median(s : BiostructsurfaceSeries) -> Double { @_common.median(s.vals) }

pub fn bio_struct_surface_series_scale(s : BiostructsurfaceSeries, f : Double) -> BiostructsurfaceSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_struct_surface_series_add(a : BiostructsurfaceSeries, b : BiostructsurfaceSeries) -> BiostructsurfaceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_struct_surface_series_sub(a : BiostructsurfaceSeries, b : BiostructsurfaceSeries) -> BiostructsurfaceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_struct_surface_series_normalize(s : BiostructsurfaceSeries) -> BiostructsurfaceSeries {
  let mn = bio_struct_surface_series_min(s)
  let mx = bio_struct_surface_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_struct_surface_series_cumsum(s : BiostructsurfaceSeries) -> BiostructsurfaceSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_struct_surface_series_to_string(s : BiostructsurfaceSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructsurfaceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_surface_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructsurfaceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_surface_matrix_identity(n : Int) -> BiostructsurfaceMatrix {
  let m = bio_struct_surface_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_struct_surface_matrix_get(m : BiostructsurfaceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_struct_surface_matrix_transpose(m : BiostructsurfaceMatrix) -> BiostructsurfaceMatrix {
  let result = bio_struct_surface_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_struct_surface_matrix_add(a : BiostructsurfaceMatrix, b : BiostructsurfaceMatrix) -> BiostructsurfaceMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_struct_surface_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_struct_surface_matrix_scale(m : BiostructsurfaceMatrix, s : Double) -> BiostructsurfaceMatrix {
  let result = bio_struct_surface_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_struct_surface_matrix_multiply(a : BiostructsurfaceMatrix, b : BiostructsurfaceMatrix) -> BiostructsurfaceMatrix {
  if a.cols != b.rows { return bio_struct_surface_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_struct_surface_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_struct_surface_matrix_trace(m : BiostructsurfaceMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_struct_surface_matrix_det(m : BiostructsurfaceMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_struct_surface_matrix_norm(m : BiostructsurfaceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_struct_surface_matrix_to_string(m : BiostructsurfaceMatrix) -> String {
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

pub(all) struct BiostructsurfaceVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_surface_make_vector(comps : Array[Double]) -> BiostructsurfaceVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_surface_vector_zero(dim : Int) -> BiostructsurfaceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_struct_surface_vector_add(a : BiostructsurfaceVector, b : BiostructsurfaceVector) -> BiostructsurfaceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_struct_surface_vector_sub(a : BiostructsurfaceVector, b : BiostructsurfaceVector) -> BiostructsurfaceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_struct_surface_vector_scale(v : BiostructsurfaceVector, s : Double) -> BiostructsurfaceVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_struct_surface_vector_dot(a : BiostructsurfaceVector, b : BiostructsurfaceVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_struct_surface_vector_norm(v : BiostructsurfaceVector) -> Double { @_common.sqrt(bio_struct_surface_vector_dot(v, v)) }

pub fn bio_struct_surface_vector_normalize(v : BiostructsurfaceVector) -> BiostructsurfaceVector {
  let n = bio_struct_surface_vector_norm(v)
  if n < 0.0000001 { v } else { bio_struct_surface_vector_scale(v, 1.0 / n) }
}

pub fn bio_struct_surface_vector_dist(a : BiostructsurfaceVector, b : BiostructsurfaceVector) -> Double {
  bio_struct_surface_vector_norm(bio_struct_surface_vector_sub(a, b))
}

pub fn bio_struct_surface_vector_to_string(v : BiostructsurfaceVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_struct_surface_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_struct_surface_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_struct_surface_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_struct_surface_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_struct_surface_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_struct_surface_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_struct_surface_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_struct_surface_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_struct_surface_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_struct_surface_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_struct_surface_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_struct_surface_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_struct_surface_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_struct_surface_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_struct_surface_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_struct_surface_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_struct_surface_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_struct_surface_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_struct_surface_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_struct_surface_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_struct_surface_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_struct_surface_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_struct_surface_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_struct_surface_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_struct_surface_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_struct_surface_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_struct_surface_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_struct_surface_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_struct_surface_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiostructsurfaceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_frame_make(size : Int) -> BiostructsurfaceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_frame_len(s : BiostructsurfaceFrame) -> Int { s.size }

pub fn bio_struct_surface_frame_get(s : BiostructsurfaceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_frame_set(s : BiostructsurfaceFrame, i : Int, v : Double) -> BiostructsurfaceFrame {
  let result = bio_struct_surface_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_frame_sum(s : BiostructsurfaceFrame) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_frame_mean(s : BiostructsurfaceFrame) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_frame_scale(s : BiostructsurfaceFrame, f : Double) -> BiostructsurfaceFrame {
  let result = bio_struct_surface_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_surface_frame_add(a : BiostructsurfaceFrame, b : BiostructsurfaceFrame) -> BiostructsurfaceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_surface_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_surface_frame_copy(s : BiostructsurfaceFrame) -> BiostructsurfaceFrame {
  let result = bio_struct_surface_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_surface_frame_fill(s : BiostructsurfaceFrame, v : Double) -> BiostructsurfaceFrame {
  let result = bio_struct_surface_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_frame_min(s : BiostructsurfaceFrame) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_frame_max(s : BiostructsurfaceFrame) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_frame_to_string(s : BiostructsurfaceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_table_make(size : Int) -> BiostructsurfaceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_table_len(s : BiostructsurfaceTable) -> Int { s.size }

pub fn bio_struct_surface_table_get(s : BiostructsurfaceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_table_set(s : BiostructsurfaceTable, i : Int, v : Double) -> BiostructsurfaceTable {
  let result = bio_struct_surface_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_table_sum(s : BiostructsurfaceTable) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_table_mean(s : BiostructsurfaceTable) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_table_scale(s : BiostructsurfaceTable, f : Double) -> BiostructsurfaceTable {
  let result = bio_struct_surface_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_surface_table_add(a : BiostructsurfaceTable, b : BiostructsurfaceTable) -> BiostructsurfaceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_surface_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_surface_table_copy(s : BiostructsurfaceTable) -> BiostructsurfaceTable {
  let result = bio_struct_surface_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_surface_table_fill(s : BiostructsurfaceTable, v : Double) -> BiostructsurfaceTable {
  let result = bio_struct_surface_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_table_min(s : BiostructsurfaceTable) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_table_max(s : BiostructsurfaceTable) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_table_to_string(s : BiostructsurfaceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_graphn_make(size : Int) -> BiostructsurfaceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_graphn_len(s : BiostructsurfaceGraphN) -> Int { s.size }

pub fn bio_struct_surface_graphn_get(s : BiostructsurfaceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_graphn_set(s : BiostructsurfaceGraphN, i : Int, v : Double) -> BiostructsurfaceGraphN {
  let result = bio_struct_surface_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_graphn_sum(s : BiostructsurfaceGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_graphn_mean(s : BiostructsurfaceGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_graphn_scale(s : BiostructsurfaceGraphN, f : Double) -> BiostructsurfaceGraphN {
  let result = bio_struct_surface_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_surface_graphn_add(a : BiostructsurfaceGraphN, b : BiostructsurfaceGraphN) -> BiostructsurfaceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_surface_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_surface_graphn_copy(s : BiostructsurfaceGraphN) -> BiostructsurfaceGraphN {
  let result = bio_struct_surface_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_surface_graphn_fill(s : BiostructsurfaceGraphN, v : Double) -> BiostructsurfaceGraphN {
  let result = bio_struct_surface_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_graphn_min(s : BiostructsurfaceGraphN) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_graphn_max(s : BiostructsurfaceGraphN) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_graphn_to_string(s : BiostructsurfaceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_node_make(size : Int) -> BiostructsurfaceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_node_len(s : BiostructsurfaceNode) -> Int { s.size }

pub fn bio_struct_surface_node_get(s : BiostructsurfaceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_node_set(s : BiostructsurfaceNode, i : Int, v : Double) -> BiostructsurfaceNode {
  let result = bio_struct_surface_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_node_sum(s : BiostructsurfaceNode) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_node_mean(s : BiostructsurfaceNode) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_node_scale(s : BiostructsurfaceNode, f : Double) -> BiostructsurfaceNode {
  let result = bio_struct_surface_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_surface_node_add(a : BiostructsurfaceNode, b : BiostructsurfaceNode) -> BiostructsurfaceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_surface_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_surface_node_copy(s : BiostructsurfaceNode) -> BiostructsurfaceNode {
  let result = bio_struct_surface_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_surface_node_fill(s : BiostructsurfaceNode, v : Double) -> BiostructsurfaceNode {
  let result = bio_struct_surface_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_node_min(s : BiostructsurfaceNode) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_node_max(s : BiostructsurfaceNode) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_node_to_string(s : BiostructsurfaceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_edge_make(size : Int) -> BiostructsurfaceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_edge_len(s : BiostructsurfaceEdge) -> Int { s.size }

pub fn bio_struct_surface_edge_get(s : BiostructsurfaceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_edge_set(s : BiostructsurfaceEdge, i : Int, v : Double) -> BiostructsurfaceEdge {
  let result = bio_struct_surface_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_edge_sum(s : BiostructsurfaceEdge) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_edge_mean(s : BiostructsurfaceEdge) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_edge_scale(s : BiostructsurfaceEdge, f : Double) -> BiostructsurfaceEdge {
  let result = bio_struct_surface_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_surface_edge_add(a : BiostructsurfaceEdge, b : BiostructsurfaceEdge) -> BiostructsurfaceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_surface_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_surface_edge_copy(s : BiostructsurfaceEdge) -> BiostructsurfaceEdge {
  let result = bio_struct_surface_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_surface_edge_fill(s : BiostructsurfaceEdge, v : Double) -> BiostructsurfaceEdge {
  let result = bio_struct_surface_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_edge_min(s : BiostructsurfaceEdge) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_edge_max(s : BiostructsurfaceEdge) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_edge_to_string(s : BiostructsurfaceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfacePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_path_make(size : Int) -> BiostructsurfacePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_path_len(s : BiostructsurfacePath) -> Int { s.size }

pub fn bio_struct_surface_path_get(s : BiostructsurfacePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_path_set(s : BiostructsurfacePath, i : Int, v : Double) -> BiostructsurfacePath {
  let result = bio_struct_surface_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_path_sum(s : BiostructsurfacePath) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_path_mean(s : BiostructsurfacePath) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_path_scale(s : BiostructsurfacePath, f : Double) -> BiostructsurfacePath {
  let result = bio_struct_surface_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_surface_path_add(a : BiostructsurfacePath, b : BiostructsurfacePath) -> BiostructsurfacePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_surface_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_surface_path_copy(s : BiostructsurfacePath) -> BiostructsurfacePath {
  let result = bio_struct_surface_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_surface_path_fill(s : BiostructsurfacePath, v : Double) -> BiostructsurfacePath {
  let result = bio_struct_surface_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_path_min(s : BiostructsurfacePath) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_path_max(s : BiostructsurfacePath) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_path_to_string(s : BiostructsurfacePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_cluster_make(size : Int) -> BiostructsurfaceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_cluster_len(s : BiostructsurfaceCluster) -> Int { s.size }

pub fn bio_struct_surface_cluster_get(s : BiostructsurfaceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_cluster_set(s : BiostructsurfaceCluster, i : Int, v : Double) -> BiostructsurfaceCluster {
  let result = bio_struct_surface_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_cluster_sum(s : BiostructsurfaceCluster) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_cluster_mean(s : BiostructsurfaceCluster) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_cluster_scale(s : BiostructsurfaceCluster, f : Double) -> BiostructsurfaceCluster {
  let result = bio_struct_surface_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_surface_cluster_add(a : BiostructsurfaceCluster, b : BiostructsurfaceCluster) -> BiostructsurfaceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_surface_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_surface_cluster_copy(s : BiostructsurfaceCluster) -> BiostructsurfaceCluster {
  let result = bio_struct_surface_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_surface_cluster_fill(s : BiostructsurfaceCluster, v : Double) -> BiostructsurfaceCluster {
  let result = bio_struct_surface_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_cluster_min(s : BiostructsurfaceCluster) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_cluster_max(s : BiostructsurfaceCluster) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_cluster_to_string(s : BiostructsurfaceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_model_make(size : Int) -> BiostructsurfaceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_model_len(s : BiostructsurfaceModel) -> Int { s.size }

pub fn bio_struct_surface_model_get(s : BiostructsurfaceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_model_set(s : BiostructsurfaceModel, i : Int, v : Double) -> BiostructsurfaceModel {
  let result = bio_struct_surface_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_model_sum(s : BiostructsurfaceModel) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_model_mean(s : BiostructsurfaceModel) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_model_scale(s : BiostructsurfaceModel, f : Double) -> BiostructsurfaceModel {
  let result = bio_struct_surface_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_surface_model_add(a : BiostructsurfaceModel, b : BiostructsurfaceModel) -> BiostructsurfaceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_surface_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_surface_model_copy(s : BiostructsurfaceModel) -> BiostructsurfaceModel {
  let result = bio_struct_surface_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_surface_model_fill(s : BiostructsurfaceModel, v : Double) -> BiostructsurfaceModel {
  let result = bio_struct_surface_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_model_min(s : BiostructsurfaceModel) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_model_max(s : BiostructsurfaceModel) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_model_to_string(s : BiostructsurfaceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_layer_make(size : Int) -> BiostructsurfaceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_layer_len(s : BiostructsurfaceLayer) -> Int { s.size }

pub fn bio_struct_surface_layer_get(s : BiostructsurfaceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_layer_set(s : BiostructsurfaceLayer, i : Int, v : Double) -> BiostructsurfaceLayer {
  let result = bio_struct_surface_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_layer_sum(s : BiostructsurfaceLayer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_layer_mean(s : BiostructsurfaceLayer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_layer_scale(s : BiostructsurfaceLayer, f : Double) -> BiostructsurfaceLayer {
  let result = bio_struct_surface_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_surface_layer_add(a : BiostructsurfaceLayer, b : BiostructsurfaceLayer) -> BiostructsurfaceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_surface_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_surface_layer_copy(s : BiostructsurfaceLayer) -> BiostructsurfaceLayer {
  let result = bio_struct_surface_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_surface_layer_fill(s : BiostructsurfaceLayer, v : Double) -> BiostructsurfaceLayer {
  let result = bio_struct_surface_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_layer_min(s : BiostructsurfaceLayer) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_layer_max(s : BiostructsurfaceLayer) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_layer_to_string(s : BiostructsurfaceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_buffer_make(size : Int) -> BiostructsurfaceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_buffer_len(s : BiostructsurfaceBuffer) -> Int { s.size }

pub fn bio_struct_surface_buffer_get(s : BiostructsurfaceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_buffer_set(s : BiostructsurfaceBuffer, i : Int, v : Double) -> BiostructsurfaceBuffer {
  let result = bio_struct_surface_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_buffer_sum(s : BiostructsurfaceBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_buffer_mean(s : BiostructsurfaceBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_buffer_scale(s : BiostructsurfaceBuffer, f : Double) -> BiostructsurfaceBuffer {
  let result = bio_struct_surface_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_surface_buffer_add(a : BiostructsurfaceBuffer, b : BiostructsurfaceBuffer) -> BiostructsurfaceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_surface_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_surface_buffer_copy(s : BiostructsurfaceBuffer) -> BiostructsurfaceBuffer {
  let result = bio_struct_surface_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_surface_buffer_fill(s : BiostructsurfaceBuffer, v : Double) -> BiostructsurfaceBuffer {
  let result = bio_struct_surface_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_buffer_min(s : BiostructsurfaceBuffer) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_buffer_max(s : BiostructsurfaceBuffer) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_buffer_to_string(s : BiostructsurfaceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_cursor_make(size : Int) -> BiostructsurfaceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_cursor_len(s : BiostructsurfaceCursor) -> Int { s.size }

pub fn bio_struct_surface_cursor_get(s : BiostructsurfaceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_cursor_set(s : BiostructsurfaceCursor, i : Int, v : Double) -> BiostructsurfaceCursor {
  let result = bio_struct_surface_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_cursor_sum(s : BiostructsurfaceCursor) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_cursor_mean(s : BiostructsurfaceCursor) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_cursor_scale(s : BiostructsurfaceCursor, f : Double) -> BiostructsurfaceCursor {
  let result = bio_struct_surface_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_surface_cursor_add(a : BiostructsurfaceCursor, b : BiostructsurfaceCursor) -> BiostructsurfaceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_surface_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_surface_cursor_copy(s : BiostructsurfaceCursor) -> BiostructsurfaceCursor {
  let result = bio_struct_surface_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_surface_cursor_fill(s : BiostructsurfaceCursor, v : Double) -> BiostructsurfaceCursor {
  let result = bio_struct_surface_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_cursor_min(s : BiostructsurfaceCursor) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_cursor_max(s : BiostructsurfaceCursor) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_cursor_to_string(s : BiostructsurfaceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_view_make(size : Int) -> BiostructsurfaceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_view_len(s : BiostructsurfaceView) -> Int { s.size }

pub fn bio_struct_surface_view_get(s : BiostructsurfaceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_view_set(s : BiostructsurfaceView, i : Int, v : Double) -> BiostructsurfaceView {
  let result = bio_struct_surface_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_view_sum(s : BiostructsurfaceView) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_view_mean(s : BiostructsurfaceView) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_view_scale(s : BiostructsurfaceView, f : Double) -> BiostructsurfaceView {
  let result = bio_struct_surface_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_surface_view_add(a : BiostructsurfaceView, b : BiostructsurfaceView) -> BiostructsurfaceView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_surface_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_surface_view_copy(s : BiostructsurfaceView) -> BiostructsurfaceView {
  let result = bio_struct_surface_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_surface_view_fill(s : BiostructsurfaceView, v : Double) -> BiostructsurfaceView {
  let result = bio_struct_surface_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_view_min(s : BiostructsurfaceView) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_view_max(s : BiostructsurfaceView) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_view_to_string(s : BiostructsurfaceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_range_make(size : Int) -> BiostructsurfaceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_range_len(s : BiostructsurfaceRange) -> Int { s.size }

pub fn bio_struct_surface_range_get(s : BiostructsurfaceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_range_set(s : BiostructsurfaceRange, i : Int, v : Double) -> BiostructsurfaceRange {
  let result = bio_struct_surface_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_range_sum(s : BiostructsurfaceRange) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_range_mean(s : BiostructsurfaceRange) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_range_scale(s : BiostructsurfaceRange, f : Double) -> BiostructsurfaceRange {
  let result = bio_struct_surface_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_surface_range_add(a : BiostructsurfaceRange, b : BiostructsurfaceRange) -> BiostructsurfaceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_surface_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_surface_range_copy(s : BiostructsurfaceRange) -> BiostructsurfaceRange {
  let result = bio_struct_surface_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_surface_range_fill(s : BiostructsurfaceRange, v : Double) -> BiostructsurfaceRange {
  let result = bio_struct_surface_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_range_min(s : BiostructsurfaceRange) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_range_max(s : BiostructsurfaceRange) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_range_to_string(s : BiostructsurfaceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_slice_make(size : Int) -> BiostructsurfaceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_surface_slice_len(s : BiostructsurfaceSlice) -> Int { s.size }

pub fn bio_struct_surface_slice_get(s : BiostructsurfaceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_surface_slice_set(s : BiostructsurfaceSlice, i : Int, v : Double) -> BiostructsurfaceSlice {
  let result = bio_struct_surface_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_slice_sum(s : BiostructsurfaceSlice) -> Double { @_common.sum(s.data) }

pub fn bio_struct_surface_slice_mean(s : BiostructsurfaceSlice) -> Double { @_common.mean(s.data) }

pub fn bio_struct_surface_slice_scale(s : BiostructsurfaceSlice, f : Double) -> BiostructsurfaceSlice {
  let result = bio_struct_surface_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_surface_slice_add(a : BiostructsurfaceSlice, b : BiostructsurfaceSlice) -> BiostructsurfaceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_surface_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_surface_slice_copy(s : BiostructsurfaceSlice) -> BiostructsurfaceSlice {
  let result = bio_struct_surface_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_surface_slice_fill(s : BiostructsurfaceSlice, v : Double) -> BiostructsurfaceSlice {
  let result = bio_struct_surface_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_surface_slice_min(s : BiostructsurfaceSlice) -> Double { @_common.min(s.data) }

pub fn bio_struct_surface_slice_max(s : BiostructsurfaceSlice) -> Double { @_common.max(s.data) }

pub fn bio_struct_surface_slice_to_string(s : BiostructsurfaceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

