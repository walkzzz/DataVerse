///===
/// extcore/ds_heap_lazy

pub(all) struct DsheaplazyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_lazy_make_point(x : Double, y : Double) -> DsheaplazyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_lazy_make_point3(x : Double, y : Double, z : Double) -> DsheaplazyPoint {
  { x, y, z, label: 0 }
}

pub fn ds_heap_lazy_point_x(pt : DsheaplazyPoint) -> Double { pt.x }

pub fn ds_heap_lazy_point_y(pt : DsheaplazyPoint) -> Double { pt.y }

pub fn ds_heap_lazy_point_z(pt : DsheaplazyPoint) -> Double { pt.z }

pub fn ds_heap_lazy_point_label(pt : DsheaplazyPoint) -> Int { pt.label }

pub fn ds_heap_lazy_point_dist(a : DsheaplazyPoint, b : DsheaplazyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_heap_lazy_point_add(a : DsheaplazyPoint, b : DsheaplazyPoint) -> DsheaplazyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_heap_lazy_point_sub(a : DsheaplazyPoint, b : DsheaplazyPoint) -> DsheaplazyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_heap_lazy_point_scale(pt : DsheaplazyPoint, s : Double) -> DsheaplazyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_heap_lazy_point_dot(a : DsheaplazyPoint, b : DsheaplazyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_heap_lazy_point_cross(a : DsheaplazyPoint, b : DsheaplazyPoint) -> DsheaplazyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_heap_lazy_point_norm(pt : DsheaplazyPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_heap_lazy_point_normalize(pt : DsheaplazyPoint) -> DsheaplazyPoint {
  let n = ds_heap_lazy_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_heap_lazy_point_scale(pt, 1.0 / n) }
}

pub fn ds_heap_lazy_point_negate(pt : DsheaplazyPoint) -> DsheaplazyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_heap_lazy_point_mid(a : DsheaplazyPoint, b : DsheaplazyPoint) -> DsheaplazyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_heap_lazy_point_lerp(a : DsheaplazyPoint, b : DsheaplazyPoint, t : Double) -> DsheaplazyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_heap_lazy_point_to_string(pt : DsheaplazyPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsheaplazySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_lazy_make_series(vals : Array[Double], name : String) -> DsheaplazySeries {
  { vals, name, meta: 0 }
}

pub fn ds_heap_lazy_series_len(s : DsheaplazySeries) -> Int { s.vals.length() }

pub fn ds_heap_lazy_series_sum(s : DsheaplazySeries) -> Double { @_common.sum(s.vals) }

pub fn ds_heap_lazy_series_mean(s : DsheaplazySeries) -> Double { @_common.mean(s.vals) }

pub fn ds_heap_lazy_series_min(s : DsheaplazySeries) -> Double { @_common.min(s.vals) }

pub fn ds_heap_lazy_series_max(s : DsheaplazySeries) -> Double { @_common.max(s.vals) }

pub fn ds_heap_lazy_series_range(s : DsheaplazySeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_heap_lazy_series_var(s : DsheaplazySeries) -> Double { @_common.variance(s.vals) }

pub fn ds_heap_lazy_series_std(s : DsheaplazySeries) -> Double { @_common.std(s.vals) }

pub fn ds_heap_lazy_series_median(s : DsheaplazySeries) -> Double { @_common.median(s.vals) }

pub fn ds_heap_lazy_series_scale(s : DsheaplazySeries, f : Double) -> DsheaplazySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_heap_lazy_series_add(a : DsheaplazySeries, b : DsheaplazySeries) -> DsheaplazySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_heap_lazy_series_sub(a : DsheaplazySeries, b : DsheaplazySeries) -> DsheaplazySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_heap_lazy_series_normalize(s : DsheaplazySeries) -> DsheaplazySeries {
  let mn = ds_heap_lazy_series_min(s)
  let mx = ds_heap_lazy_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_heap_lazy_series_cumsum(s : DsheaplazySeries) -> DsheaplazySeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_heap_lazy_series_to_string(s : DsheaplazySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheaplazyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_lazy_make_matrix(rows : Int, cols : Int, val : Double) -> DsheaplazyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_lazy_matrix_identity(n : Int) -> DsheaplazyMatrix {
  let m = ds_heap_lazy_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_heap_lazy_matrix_get(m : DsheaplazyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_heap_lazy_matrix_transpose(m : DsheaplazyMatrix) -> DsheaplazyMatrix {
  let result = ds_heap_lazy_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_heap_lazy_matrix_add(a : DsheaplazyMatrix, b : DsheaplazyMatrix) -> DsheaplazyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_heap_lazy_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_heap_lazy_matrix_scale(m : DsheaplazyMatrix, s : Double) -> DsheaplazyMatrix {
  let result = ds_heap_lazy_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_heap_lazy_matrix_multiply(a : DsheaplazyMatrix, b : DsheaplazyMatrix) -> DsheaplazyMatrix {
  if a.cols != b.rows { return ds_heap_lazy_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_heap_lazy_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_heap_lazy_matrix_trace(m : DsheaplazyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_heap_lazy_matrix_det(m : DsheaplazyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_heap_lazy_matrix_norm(m : DsheaplazyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_heap_lazy_matrix_to_string(m : DsheaplazyMatrix) -> String {
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

pub(all) struct DsheaplazyVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_lazy_make_vector(comps : Array[Double]) -> DsheaplazyVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_lazy_vector_zero(dim : Int) -> DsheaplazyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_heap_lazy_vector_add(a : DsheaplazyVector, b : DsheaplazyVector) -> DsheaplazyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_heap_lazy_vector_sub(a : DsheaplazyVector, b : DsheaplazyVector) -> DsheaplazyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_heap_lazy_vector_scale(v : DsheaplazyVector, s : Double) -> DsheaplazyVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_heap_lazy_vector_dot(a : DsheaplazyVector, b : DsheaplazyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_heap_lazy_vector_norm(v : DsheaplazyVector) -> Double { @_common.sqrt(ds_heap_lazy_vector_dot(v, v)) }

pub fn ds_heap_lazy_vector_normalize(v : DsheaplazyVector) -> DsheaplazyVector {
  let n = ds_heap_lazy_vector_norm(v)
  if n < 0.0000001 { v } else { ds_heap_lazy_vector_scale(v, 1.0 / n) }
}

pub fn ds_heap_lazy_vector_dist(a : DsheaplazyVector, b : DsheaplazyVector) -> Double {
  ds_heap_lazy_vector_norm(ds_heap_lazy_vector_sub(a, b))
}

pub fn ds_heap_lazy_vector_to_string(v : DsheaplazyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_heap_lazy_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_heap_lazy_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_heap_lazy_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_heap_lazy_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_heap_lazy_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_heap_lazy_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_heap_lazy_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_heap_lazy_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_heap_lazy_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_heap_lazy_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_heap_lazy_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_heap_lazy_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_heap_lazy_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_heap_lazy_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_heap_lazy_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_heap_lazy_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_heap_lazy_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_heap_lazy_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_heap_lazy_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_heap_lazy_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_heap_lazy_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_heap_lazy_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_heap_lazy_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_heap_lazy_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_heap_lazy_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_heap_lazy_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_heap_lazy_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_heap_lazy_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_heap_lazy_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsheaplazyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_frame_make(size : Int) -> DsheaplazyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_frame_len(s : DsheaplazyFrame) -> Int { s.size }

pub fn ds_heap_lazy_frame_get(s : DsheaplazyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_frame_set(s : DsheaplazyFrame, i : Int, v : Double) -> DsheaplazyFrame {
  let result = ds_heap_lazy_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_frame_sum(s : DsheaplazyFrame) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_frame_mean(s : DsheaplazyFrame) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_frame_scale(s : DsheaplazyFrame, f : Double) -> DsheaplazyFrame {
  let result = ds_heap_lazy_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_lazy_frame_add(a : DsheaplazyFrame, b : DsheaplazyFrame) -> DsheaplazyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_lazy_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_lazy_frame_copy(s : DsheaplazyFrame) -> DsheaplazyFrame {
  let result = ds_heap_lazy_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_lazy_frame_fill(s : DsheaplazyFrame, v : Double) -> DsheaplazyFrame {
  let result = ds_heap_lazy_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_frame_min(s : DsheaplazyFrame) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_frame_max(s : DsheaplazyFrame) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_frame_to_string(s : DsheaplazyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_table_make(size : Int) -> DsheaplazyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_table_len(s : DsheaplazyTable) -> Int { s.size }

pub fn ds_heap_lazy_table_get(s : DsheaplazyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_table_set(s : DsheaplazyTable, i : Int, v : Double) -> DsheaplazyTable {
  let result = ds_heap_lazy_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_table_sum(s : DsheaplazyTable) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_table_mean(s : DsheaplazyTable) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_table_scale(s : DsheaplazyTable, f : Double) -> DsheaplazyTable {
  let result = ds_heap_lazy_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_lazy_table_add(a : DsheaplazyTable, b : DsheaplazyTable) -> DsheaplazyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_lazy_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_lazy_table_copy(s : DsheaplazyTable) -> DsheaplazyTable {
  let result = ds_heap_lazy_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_lazy_table_fill(s : DsheaplazyTable, v : Double) -> DsheaplazyTable {
  let result = ds_heap_lazy_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_table_min(s : DsheaplazyTable) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_table_max(s : DsheaplazyTable) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_table_to_string(s : DsheaplazyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_graphn_make(size : Int) -> DsheaplazyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_graphn_len(s : DsheaplazyGraphN) -> Int { s.size }

pub fn ds_heap_lazy_graphn_get(s : DsheaplazyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_graphn_set(s : DsheaplazyGraphN, i : Int, v : Double) -> DsheaplazyGraphN {
  let result = ds_heap_lazy_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_graphn_sum(s : DsheaplazyGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_graphn_mean(s : DsheaplazyGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_graphn_scale(s : DsheaplazyGraphN, f : Double) -> DsheaplazyGraphN {
  let result = ds_heap_lazy_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_lazy_graphn_add(a : DsheaplazyGraphN, b : DsheaplazyGraphN) -> DsheaplazyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_lazy_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_lazy_graphn_copy(s : DsheaplazyGraphN) -> DsheaplazyGraphN {
  let result = ds_heap_lazy_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_lazy_graphn_fill(s : DsheaplazyGraphN, v : Double) -> DsheaplazyGraphN {
  let result = ds_heap_lazy_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_graphn_min(s : DsheaplazyGraphN) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_graphn_max(s : DsheaplazyGraphN) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_graphn_to_string(s : DsheaplazyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_node_make(size : Int) -> DsheaplazyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_node_len(s : DsheaplazyNode) -> Int { s.size }

pub fn ds_heap_lazy_node_get(s : DsheaplazyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_node_set(s : DsheaplazyNode, i : Int, v : Double) -> DsheaplazyNode {
  let result = ds_heap_lazy_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_node_sum(s : DsheaplazyNode) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_node_mean(s : DsheaplazyNode) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_node_scale(s : DsheaplazyNode, f : Double) -> DsheaplazyNode {
  let result = ds_heap_lazy_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_lazy_node_add(a : DsheaplazyNode, b : DsheaplazyNode) -> DsheaplazyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_lazy_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_lazy_node_copy(s : DsheaplazyNode) -> DsheaplazyNode {
  let result = ds_heap_lazy_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_lazy_node_fill(s : DsheaplazyNode, v : Double) -> DsheaplazyNode {
  let result = ds_heap_lazy_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_node_min(s : DsheaplazyNode) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_node_max(s : DsheaplazyNode) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_node_to_string(s : DsheaplazyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_edge_make(size : Int) -> DsheaplazyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_edge_len(s : DsheaplazyEdge) -> Int { s.size }

pub fn ds_heap_lazy_edge_get(s : DsheaplazyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_edge_set(s : DsheaplazyEdge, i : Int, v : Double) -> DsheaplazyEdge {
  let result = ds_heap_lazy_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_edge_sum(s : DsheaplazyEdge) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_edge_mean(s : DsheaplazyEdge) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_edge_scale(s : DsheaplazyEdge, f : Double) -> DsheaplazyEdge {
  let result = ds_heap_lazy_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_lazy_edge_add(a : DsheaplazyEdge, b : DsheaplazyEdge) -> DsheaplazyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_lazy_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_lazy_edge_copy(s : DsheaplazyEdge) -> DsheaplazyEdge {
  let result = ds_heap_lazy_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_lazy_edge_fill(s : DsheaplazyEdge, v : Double) -> DsheaplazyEdge {
  let result = ds_heap_lazy_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_edge_min(s : DsheaplazyEdge) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_edge_max(s : DsheaplazyEdge) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_edge_to_string(s : DsheaplazyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_path_make(size : Int) -> DsheaplazyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_path_len(s : DsheaplazyPath) -> Int { s.size }

pub fn ds_heap_lazy_path_get(s : DsheaplazyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_path_set(s : DsheaplazyPath, i : Int, v : Double) -> DsheaplazyPath {
  let result = ds_heap_lazy_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_path_sum(s : DsheaplazyPath) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_path_mean(s : DsheaplazyPath) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_path_scale(s : DsheaplazyPath, f : Double) -> DsheaplazyPath {
  let result = ds_heap_lazy_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_lazy_path_add(a : DsheaplazyPath, b : DsheaplazyPath) -> DsheaplazyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_lazy_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_lazy_path_copy(s : DsheaplazyPath) -> DsheaplazyPath {
  let result = ds_heap_lazy_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_lazy_path_fill(s : DsheaplazyPath, v : Double) -> DsheaplazyPath {
  let result = ds_heap_lazy_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_path_min(s : DsheaplazyPath) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_path_max(s : DsheaplazyPath) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_path_to_string(s : DsheaplazyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_cluster_make(size : Int) -> DsheaplazyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_cluster_len(s : DsheaplazyCluster) -> Int { s.size }

pub fn ds_heap_lazy_cluster_get(s : DsheaplazyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_cluster_set(s : DsheaplazyCluster, i : Int, v : Double) -> DsheaplazyCluster {
  let result = ds_heap_lazy_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_cluster_sum(s : DsheaplazyCluster) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_cluster_mean(s : DsheaplazyCluster) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_cluster_scale(s : DsheaplazyCluster, f : Double) -> DsheaplazyCluster {
  let result = ds_heap_lazy_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_lazy_cluster_add(a : DsheaplazyCluster, b : DsheaplazyCluster) -> DsheaplazyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_lazy_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_lazy_cluster_copy(s : DsheaplazyCluster) -> DsheaplazyCluster {
  let result = ds_heap_lazy_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_lazy_cluster_fill(s : DsheaplazyCluster, v : Double) -> DsheaplazyCluster {
  let result = ds_heap_lazy_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_cluster_min(s : DsheaplazyCluster) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_cluster_max(s : DsheaplazyCluster) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_cluster_to_string(s : DsheaplazyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_model_make(size : Int) -> DsheaplazyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_model_len(s : DsheaplazyModel) -> Int { s.size }

pub fn ds_heap_lazy_model_get(s : DsheaplazyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_model_set(s : DsheaplazyModel, i : Int, v : Double) -> DsheaplazyModel {
  let result = ds_heap_lazy_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_model_sum(s : DsheaplazyModel) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_model_mean(s : DsheaplazyModel) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_model_scale(s : DsheaplazyModel, f : Double) -> DsheaplazyModel {
  let result = ds_heap_lazy_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_lazy_model_add(a : DsheaplazyModel, b : DsheaplazyModel) -> DsheaplazyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_lazy_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_lazy_model_copy(s : DsheaplazyModel) -> DsheaplazyModel {
  let result = ds_heap_lazy_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_lazy_model_fill(s : DsheaplazyModel, v : Double) -> DsheaplazyModel {
  let result = ds_heap_lazy_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_model_min(s : DsheaplazyModel) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_model_max(s : DsheaplazyModel) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_model_to_string(s : DsheaplazyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_layer_make(size : Int) -> DsheaplazyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_layer_len(s : DsheaplazyLayer) -> Int { s.size }

pub fn ds_heap_lazy_layer_get(s : DsheaplazyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_layer_set(s : DsheaplazyLayer, i : Int, v : Double) -> DsheaplazyLayer {
  let result = ds_heap_lazy_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_layer_sum(s : DsheaplazyLayer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_layer_mean(s : DsheaplazyLayer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_layer_scale(s : DsheaplazyLayer, f : Double) -> DsheaplazyLayer {
  let result = ds_heap_lazy_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_lazy_layer_add(a : DsheaplazyLayer, b : DsheaplazyLayer) -> DsheaplazyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_lazy_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_lazy_layer_copy(s : DsheaplazyLayer) -> DsheaplazyLayer {
  let result = ds_heap_lazy_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_lazy_layer_fill(s : DsheaplazyLayer, v : Double) -> DsheaplazyLayer {
  let result = ds_heap_lazy_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_layer_min(s : DsheaplazyLayer) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_layer_max(s : DsheaplazyLayer) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_layer_to_string(s : DsheaplazyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_buffer_make(size : Int) -> DsheaplazyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_buffer_len(s : DsheaplazyBuffer) -> Int { s.size }

pub fn ds_heap_lazy_buffer_get(s : DsheaplazyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_buffer_set(s : DsheaplazyBuffer, i : Int, v : Double) -> DsheaplazyBuffer {
  let result = ds_heap_lazy_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_buffer_sum(s : DsheaplazyBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_buffer_mean(s : DsheaplazyBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_buffer_scale(s : DsheaplazyBuffer, f : Double) -> DsheaplazyBuffer {
  let result = ds_heap_lazy_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_lazy_buffer_add(a : DsheaplazyBuffer, b : DsheaplazyBuffer) -> DsheaplazyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_lazy_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_lazy_buffer_copy(s : DsheaplazyBuffer) -> DsheaplazyBuffer {
  let result = ds_heap_lazy_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_lazy_buffer_fill(s : DsheaplazyBuffer, v : Double) -> DsheaplazyBuffer {
  let result = ds_heap_lazy_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_buffer_min(s : DsheaplazyBuffer) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_buffer_max(s : DsheaplazyBuffer) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_buffer_to_string(s : DsheaplazyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_cursor_make(size : Int) -> DsheaplazyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_cursor_len(s : DsheaplazyCursor) -> Int { s.size }

pub fn ds_heap_lazy_cursor_get(s : DsheaplazyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_cursor_set(s : DsheaplazyCursor, i : Int, v : Double) -> DsheaplazyCursor {
  let result = ds_heap_lazy_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_cursor_sum(s : DsheaplazyCursor) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_cursor_mean(s : DsheaplazyCursor) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_cursor_scale(s : DsheaplazyCursor, f : Double) -> DsheaplazyCursor {
  let result = ds_heap_lazy_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_lazy_cursor_add(a : DsheaplazyCursor, b : DsheaplazyCursor) -> DsheaplazyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_lazy_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_lazy_cursor_copy(s : DsheaplazyCursor) -> DsheaplazyCursor {
  let result = ds_heap_lazy_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_lazy_cursor_fill(s : DsheaplazyCursor, v : Double) -> DsheaplazyCursor {
  let result = ds_heap_lazy_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_cursor_min(s : DsheaplazyCursor) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_cursor_max(s : DsheaplazyCursor) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_cursor_to_string(s : DsheaplazyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_view_make(size : Int) -> DsheaplazyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_view_len(s : DsheaplazyView) -> Int { s.size }

pub fn ds_heap_lazy_view_get(s : DsheaplazyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_view_set(s : DsheaplazyView, i : Int, v : Double) -> DsheaplazyView {
  let result = ds_heap_lazy_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_view_sum(s : DsheaplazyView) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_view_mean(s : DsheaplazyView) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_view_scale(s : DsheaplazyView, f : Double) -> DsheaplazyView {
  let result = ds_heap_lazy_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_lazy_view_add(a : DsheaplazyView, b : DsheaplazyView) -> DsheaplazyView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_lazy_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_lazy_view_copy(s : DsheaplazyView) -> DsheaplazyView {
  let result = ds_heap_lazy_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_lazy_view_fill(s : DsheaplazyView, v : Double) -> DsheaplazyView {
  let result = ds_heap_lazy_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_view_min(s : DsheaplazyView) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_view_max(s : DsheaplazyView) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_view_to_string(s : DsheaplazyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_range_make(size : Int) -> DsheaplazyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_range_len(s : DsheaplazyRange) -> Int { s.size }

pub fn ds_heap_lazy_range_get(s : DsheaplazyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_range_set(s : DsheaplazyRange, i : Int, v : Double) -> DsheaplazyRange {
  let result = ds_heap_lazy_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_range_sum(s : DsheaplazyRange) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_range_mean(s : DsheaplazyRange) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_range_scale(s : DsheaplazyRange, f : Double) -> DsheaplazyRange {
  let result = ds_heap_lazy_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_lazy_range_add(a : DsheaplazyRange, b : DsheaplazyRange) -> DsheaplazyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_lazy_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_lazy_range_copy(s : DsheaplazyRange) -> DsheaplazyRange {
  let result = ds_heap_lazy_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_lazy_range_fill(s : DsheaplazyRange, v : Double) -> DsheaplazyRange {
  let result = ds_heap_lazy_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_range_min(s : DsheaplazyRange) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_range_max(s : DsheaplazyRange) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_range_to_string(s : DsheaplazyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_slice_make(size : Int) -> DsheaplazySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_slice_len(s : DsheaplazySlice) -> Int { s.size }

pub fn ds_heap_lazy_slice_get(s : DsheaplazySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_slice_set(s : DsheaplazySlice, i : Int, v : Double) -> DsheaplazySlice {
  let result = ds_heap_lazy_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_slice_sum(s : DsheaplazySlice) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_slice_mean(s : DsheaplazySlice) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_slice_scale(s : DsheaplazySlice, f : Double) -> DsheaplazySlice {
  let result = ds_heap_lazy_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_lazy_slice_add(a : DsheaplazySlice, b : DsheaplazySlice) -> DsheaplazySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_lazy_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_lazy_slice_copy(s : DsheaplazySlice) -> DsheaplazySlice {
  let result = ds_heap_lazy_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_lazy_slice_fill(s : DsheaplazySlice, v : Double) -> DsheaplazySlice {
  let result = ds_heap_lazy_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_lazy_slice_min(s : DsheaplazySlice) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_slice_max(s : DsheaplazySlice) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_slice_to_string(s : DsheaplazySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

