///===
/// extcore/ds_heap_binary

pub(all) struct DsheapbinaryPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_binary_make_point(x : Double, y : Double) -> DsheapbinaryPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_binary_make_point3(x : Double, y : Double, z : Double) -> DsheapbinaryPoint {
  { x, y, z, label: 0 }
}

pub fn ds_heap_binary_point_x(pt : DsheapbinaryPoint) -> Double { pt.x }

pub fn ds_heap_binary_point_y(pt : DsheapbinaryPoint) -> Double { pt.y }

pub fn ds_heap_binary_point_z(pt : DsheapbinaryPoint) -> Double { pt.z }

pub fn ds_heap_binary_point_label(pt : DsheapbinaryPoint) -> Int { pt.label }

pub fn ds_heap_binary_point_dist(a : DsheapbinaryPoint, b : DsheapbinaryPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_heap_binary_point_add(a : DsheapbinaryPoint, b : DsheapbinaryPoint) -> DsheapbinaryPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_heap_binary_point_sub(a : DsheapbinaryPoint, b : DsheapbinaryPoint) -> DsheapbinaryPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_heap_binary_point_scale(pt : DsheapbinaryPoint, s : Double) -> DsheapbinaryPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_heap_binary_point_dot(a : DsheapbinaryPoint, b : DsheapbinaryPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_heap_binary_point_cross(a : DsheapbinaryPoint, b : DsheapbinaryPoint) -> DsheapbinaryPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_heap_binary_point_norm(pt : DsheapbinaryPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_heap_binary_point_normalize(pt : DsheapbinaryPoint) -> DsheapbinaryPoint {
  let n = ds_heap_binary_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_heap_binary_point_scale(pt, 1.0 / n) }
}

pub fn ds_heap_binary_point_negate(pt : DsheapbinaryPoint) -> DsheapbinaryPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_heap_binary_point_mid(a : DsheapbinaryPoint, b : DsheapbinaryPoint) -> DsheapbinaryPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_heap_binary_point_lerp(a : DsheapbinaryPoint, b : DsheapbinaryPoint, t : Double) -> DsheapbinaryPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_heap_binary_point_to_string(pt : DsheapbinaryPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsheapbinarySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_binary_make_series(vals : Array[Double], name : String) -> DsheapbinarySeries {
  { vals, name, meta: 0 }
}

pub fn ds_heap_binary_series_len(s : DsheapbinarySeries) -> Int { s.vals.length() }

pub fn ds_heap_binary_series_sum(s : DsheapbinarySeries) -> Double { @_common.sum(s.vals) }

pub fn ds_heap_binary_series_mean(s : DsheapbinarySeries) -> Double { @_common.mean(s.vals) }

pub fn ds_heap_binary_series_min(s : DsheapbinarySeries) -> Double { @_common.min(s.vals) }

pub fn ds_heap_binary_series_max(s : DsheapbinarySeries) -> Double { @_common.max(s.vals) }

pub fn ds_heap_binary_series_range(s : DsheapbinarySeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_heap_binary_series_var(s : DsheapbinarySeries) -> Double { @_common.variance(s.vals) }

pub fn ds_heap_binary_series_std(s : DsheapbinarySeries) -> Double { @_common.std(s.vals) }

pub fn ds_heap_binary_series_median(s : DsheapbinarySeries) -> Double { @_common.median(s.vals) }

pub fn ds_heap_binary_series_scale(s : DsheapbinarySeries, f : Double) -> DsheapbinarySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_heap_binary_series_add(a : DsheapbinarySeries, b : DsheapbinarySeries) -> DsheapbinarySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_heap_binary_series_sub(a : DsheapbinarySeries, b : DsheapbinarySeries) -> DsheapbinarySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_heap_binary_series_normalize(s : DsheapbinarySeries) -> DsheapbinarySeries {
  let mn = ds_heap_binary_series_min(s)
  let mx = ds_heap_binary_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_heap_binary_series_cumsum(s : DsheapbinarySeries) -> DsheapbinarySeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_heap_binary_series_to_string(s : DsheapbinarySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapbinaryMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_binary_make_matrix(rows : Int, cols : Int, val : Double) -> DsheapbinaryMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_binary_matrix_identity(n : Int) -> DsheapbinaryMatrix {
  let m = ds_heap_binary_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_heap_binary_matrix_get(m : DsheapbinaryMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_heap_binary_matrix_transpose(m : DsheapbinaryMatrix) -> DsheapbinaryMatrix {
  let result = ds_heap_binary_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_heap_binary_matrix_add(a : DsheapbinaryMatrix, b : DsheapbinaryMatrix) -> DsheapbinaryMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_heap_binary_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_heap_binary_matrix_scale(m : DsheapbinaryMatrix, s : Double) -> DsheapbinaryMatrix {
  let result = ds_heap_binary_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_heap_binary_matrix_multiply(a : DsheapbinaryMatrix, b : DsheapbinaryMatrix) -> DsheapbinaryMatrix {
  if a.cols != b.rows { return ds_heap_binary_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_heap_binary_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_heap_binary_matrix_trace(m : DsheapbinaryMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_heap_binary_matrix_det(m : DsheapbinaryMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_heap_binary_matrix_norm(m : DsheapbinaryMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_heap_binary_matrix_to_string(m : DsheapbinaryMatrix) -> String {
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

pub(all) struct DsheapbinaryVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_binary_make_vector(comps : Array[Double]) -> DsheapbinaryVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_binary_vector_zero(dim : Int) -> DsheapbinaryVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_heap_binary_vector_add(a : DsheapbinaryVector, b : DsheapbinaryVector) -> DsheapbinaryVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_heap_binary_vector_sub(a : DsheapbinaryVector, b : DsheapbinaryVector) -> DsheapbinaryVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_heap_binary_vector_scale(v : DsheapbinaryVector, s : Double) -> DsheapbinaryVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_heap_binary_vector_dot(a : DsheapbinaryVector, b : DsheapbinaryVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_heap_binary_vector_norm(v : DsheapbinaryVector) -> Double { @_common.sqrt(ds_heap_binary_vector_dot(v, v)) }

pub fn ds_heap_binary_vector_normalize(v : DsheapbinaryVector) -> DsheapbinaryVector {
  let n = ds_heap_binary_vector_norm(v)
  if n < 0.0000001 { v } else { ds_heap_binary_vector_scale(v, 1.0 / n) }
}

pub fn ds_heap_binary_vector_dist(a : DsheapbinaryVector, b : DsheapbinaryVector) -> Double {
  ds_heap_binary_vector_norm(ds_heap_binary_vector_sub(a, b))
}

pub fn ds_heap_binary_vector_to_string(v : DsheapbinaryVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_heap_binary_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_heap_binary_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_heap_binary_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_heap_binary_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_heap_binary_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_heap_binary_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_heap_binary_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_heap_binary_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_heap_binary_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_heap_binary_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_heap_binary_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_heap_binary_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_heap_binary_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_heap_binary_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_heap_binary_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_heap_binary_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_heap_binary_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_heap_binary_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_heap_binary_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_heap_binary_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_heap_binary_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_heap_binary_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_heap_binary_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_heap_binary_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_heap_binary_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_heap_binary_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_heap_binary_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_heap_binary_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_heap_binary_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsheapbinaryFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_frame_make(size : Int) -> DsheapbinaryFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_frame_len(s : DsheapbinaryFrame) -> Int { s.size }

pub fn ds_heap_binary_frame_get(s : DsheapbinaryFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_frame_set(s : DsheapbinaryFrame, i : Int, v : Double) -> DsheapbinaryFrame {
  let result = ds_heap_binary_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_frame_sum(s : DsheapbinaryFrame) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binary_frame_mean(s : DsheapbinaryFrame) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binary_frame_scale(s : DsheapbinaryFrame, f : Double) -> DsheapbinaryFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_frame_add(a : DsheapbinaryFrame, b : DsheapbinaryFrame) -> DsheapbinaryFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binary_frame_copy(s : DsheapbinaryFrame) -> DsheapbinaryFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_frame_fill(s : DsheapbinaryFrame, v : Double) -> DsheapbinaryFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_frame_min(s : DsheapbinaryFrame) -> Double { @_common.min(s.data) }

pub fn ds_heap_binary_frame_max(s : DsheapbinaryFrame) -> Double { @_common.max(s.data) }

pub fn ds_heap_binary_frame_to_string(s : DsheapbinaryFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_table_make(size : Int) -> DsheapbinaryTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_table_len(s : DsheapbinaryTable) -> Int { s.size }

pub fn ds_heap_binary_table_get(s : DsheapbinaryTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_table_set(s : DsheapbinaryTable, i : Int, v : Double) -> DsheapbinaryTable {
  let result = ds_heap_binary_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_table_sum(s : DsheapbinaryTable) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binary_table_mean(s : DsheapbinaryTable) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binary_table_scale(s : DsheapbinaryTable, f : Double) -> DsheapbinaryTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_table_add(a : DsheapbinaryTable, b : DsheapbinaryTable) -> DsheapbinaryTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binary_table_copy(s : DsheapbinaryTable) -> DsheapbinaryTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_table_fill(s : DsheapbinaryTable, v : Double) -> DsheapbinaryTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_table_min(s : DsheapbinaryTable) -> Double { @_common.min(s.data) }

pub fn ds_heap_binary_table_max(s : DsheapbinaryTable) -> Double { @_common.max(s.data) }

pub fn ds_heap_binary_table_to_string(s : DsheapbinaryTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_graphn_make(size : Int) -> DsheapbinaryGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_graphn_len(s : DsheapbinaryGraphN) -> Int { s.size }

pub fn ds_heap_binary_graphn_get(s : DsheapbinaryGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_graphn_set(s : DsheapbinaryGraphN, i : Int, v : Double) -> DsheapbinaryGraphN {
  let result = ds_heap_binary_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_graphn_sum(s : DsheapbinaryGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binary_graphn_mean(s : DsheapbinaryGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binary_graphn_scale(s : DsheapbinaryGraphN, f : Double) -> DsheapbinaryGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_graphn_add(a : DsheapbinaryGraphN, b : DsheapbinaryGraphN) -> DsheapbinaryGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binary_graphn_copy(s : DsheapbinaryGraphN) -> DsheapbinaryGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_graphn_fill(s : DsheapbinaryGraphN, v : Double) -> DsheapbinaryGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_graphn_min(s : DsheapbinaryGraphN) -> Double { @_common.min(s.data) }

pub fn ds_heap_binary_graphn_max(s : DsheapbinaryGraphN) -> Double { @_common.max(s.data) }

pub fn ds_heap_binary_graphn_to_string(s : DsheapbinaryGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_node_make(size : Int) -> DsheapbinaryNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_node_len(s : DsheapbinaryNode) -> Int { s.size }

pub fn ds_heap_binary_node_get(s : DsheapbinaryNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_node_set(s : DsheapbinaryNode, i : Int, v : Double) -> DsheapbinaryNode {
  let result = ds_heap_binary_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_node_sum(s : DsheapbinaryNode) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binary_node_mean(s : DsheapbinaryNode) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binary_node_scale(s : DsheapbinaryNode, f : Double) -> DsheapbinaryNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_node_add(a : DsheapbinaryNode, b : DsheapbinaryNode) -> DsheapbinaryNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binary_node_copy(s : DsheapbinaryNode) -> DsheapbinaryNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_node_fill(s : DsheapbinaryNode, v : Double) -> DsheapbinaryNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_node_min(s : DsheapbinaryNode) -> Double { @_common.min(s.data) }

pub fn ds_heap_binary_node_max(s : DsheapbinaryNode) -> Double { @_common.max(s.data) }

pub fn ds_heap_binary_node_to_string(s : DsheapbinaryNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_edge_make(size : Int) -> DsheapbinaryEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_edge_len(s : DsheapbinaryEdge) -> Int { s.size }

pub fn ds_heap_binary_edge_get(s : DsheapbinaryEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_edge_set(s : DsheapbinaryEdge, i : Int, v : Double) -> DsheapbinaryEdge {
  let result = ds_heap_binary_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_edge_sum(s : DsheapbinaryEdge) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binary_edge_mean(s : DsheapbinaryEdge) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binary_edge_scale(s : DsheapbinaryEdge, f : Double) -> DsheapbinaryEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_edge_add(a : DsheapbinaryEdge, b : DsheapbinaryEdge) -> DsheapbinaryEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binary_edge_copy(s : DsheapbinaryEdge) -> DsheapbinaryEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_edge_fill(s : DsheapbinaryEdge, v : Double) -> DsheapbinaryEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_edge_min(s : DsheapbinaryEdge) -> Double { @_common.min(s.data) }

pub fn ds_heap_binary_edge_max(s : DsheapbinaryEdge) -> Double { @_common.max(s.data) }

pub fn ds_heap_binary_edge_to_string(s : DsheapbinaryEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_path_make(size : Int) -> DsheapbinaryPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_path_len(s : DsheapbinaryPath) -> Int { s.size }

pub fn ds_heap_binary_path_get(s : DsheapbinaryPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_path_set(s : DsheapbinaryPath, i : Int, v : Double) -> DsheapbinaryPath {
  let result = ds_heap_binary_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_path_sum(s : DsheapbinaryPath) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binary_path_mean(s : DsheapbinaryPath) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binary_path_scale(s : DsheapbinaryPath, f : Double) -> DsheapbinaryPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_path_add(a : DsheapbinaryPath, b : DsheapbinaryPath) -> DsheapbinaryPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binary_path_copy(s : DsheapbinaryPath) -> DsheapbinaryPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_path_fill(s : DsheapbinaryPath, v : Double) -> DsheapbinaryPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_path_min(s : DsheapbinaryPath) -> Double { @_common.min(s.data) }

pub fn ds_heap_binary_path_max(s : DsheapbinaryPath) -> Double { @_common.max(s.data) }

pub fn ds_heap_binary_path_to_string(s : DsheapbinaryPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_cluster_make(size : Int) -> DsheapbinaryCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_cluster_len(s : DsheapbinaryCluster) -> Int { s.size }

pub fn ds_heap_binary_cluster_get(s : DsheapbinaryCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_cluster_set(s : DsheapbinaryCluster, i : Int, v : Double) -> DsheapbinaryCluster {
  let result = ds_heap_binary_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_cluster_sum(s : DsheapbinaryCluster) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binary_cluster_mean(s : DsheapbinaryCluster) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binary_cluster_scale(s : DsheapbinaryCluster, f : Double) -> DsheapbinaryCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_cluster_add(a : DsheapbinaryCluster, b : DsheapbinaryCluster) -> DsheapbinaryCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binary_cluster_copy(s : DsheapbinaryCluster) -> DsheapbinaryCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_cluster_fill(s : DsheapbinaryCluster, v : Double) -> DsheapbinaryCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_cluster_min(s : DsheapbinaryCluster) -> Double { @_common.min(s.data) }

pub fn ds_heap_binary_cluster_max(s : DsheapbinaryCluster) -> Double { @_common.max(s.data) }

pub fn ds_heap_binary_cluster_to_string(s : DsheapbinaryCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_model_make(size : Int) -> DsheapbinaryModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_model_len(s : DsheapbinaryModel) -> Int { s.size }

pub fn ds_heap_binary_model_get(s : DsheapbinaryModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_model_set(s : DsheapbinaryModel, i : Int, v : Double) -> DsheapbinaryModel {
  let result = ds_heap_binary_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_model_sum(s : DsheapbinaryModel) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binary_model_mean(s : DsheapbinaryModel) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binary_model_scale(s : DsheapbinaryModel, f : Double) -> DsheapbinaryModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_model_add(a : DsheapbinaryModel, b : DsheapbinaryModel) -> DsheapbinaryModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binary_model_copy(s : DsheapbinaryModel) -> DsheapbinaryModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_model_fill(s : DsheapbinaryModel, v : Double) -> DsheapbinaryModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_model_min(s : DsheapbinaryModel) -> Double { @_common.min(s.data) }

pub fn ds_heap_binary_model_max(s : DsheapbinaryModel) -> Double { @_common.max(s.data) }

pub fn ds_heap_binary_model_to_string(s : DsheapbinaryModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_layer_make(size : Int) -> DsheapbinaryLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_layer_len(s : DsheapbinaryLayer) -> Int { s.size }

pub fn ds_heap_binary_layer_get(s : DsheapbinaryLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_layer_set(s : DsheapbinaryLayer, i : Int, v : Double) -> DsheapbinaryLayer {
  let result = ds_heap_binary_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_layer_sum(s : DsheapbinaryLayer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binary_layer_mean(s : DsheapbinaryLayer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binary_layer_scale(s : DsheapbinaryLayer, f : Double) -> DsheapbinaryLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_layer_add(a : DsheapbinaryLayer, b : DsheapbinaryLayer) -> DsheapbinaryLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binary_layer_copy(s : DsheapbinaryLayer) -> DsheapbinaryLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_layer_fill(s : DsheapbinaryLayer, v : Double) -> DsheapbinaryLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_layer_min(s : DsheapbinaryLayer) -> Double { @_common.min(s.data) }

pub fn ds_heap_binary_layer_max(s : DsheapbinaryLayer) -> Double { @_common.max(s.data) }

pub fn ds_heap_binary_layer_to_string(s : DsheapbinaryLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_buffer_make(size : Int) -> DsheapbinaryBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_buffer_len(s : DsheapbinaryBuffer) -> Int { s.size }

pub fn ds_heap_binary_buffer_get(s : DsheapbinaryBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_buffer_set(s : DsheapbinaryBuffer, i : Int, v : Double) -> DsheapbinaryBuffer {
  let result = ds_heap_binary_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_buffer_sum(s : DsheapbinaryBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binary_buffer_mean(s : DsheapbinaryBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binary_buffer_scale(s : DsheapbinaryBuffer, f : Double) -> DsheapbinaryBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_buffer_add(a : DsheapbinaryBuffer, b : DsheapbinaryBuffer) -> DsheapbinaryBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binary_buffer_copy(s : DsheapbinaryBuffer) -> DsheapbinaryBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_buffer_fill(s : DsheapbinaryBuffer, v : Double) -> DsheapbinaryBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_buffer_min(s : DsheapbinaryBuffer) -> Double { @_common.min(s.data) }

pub fn ds_heap_binary_buffer_max(s : DsheapbinaryBuffer) -> Double { @_common.max(s.data) }

pub fn ds_heap_binary_buffer_to_string(s : DsheapbinaryBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_cursor_make(size : Int) -> DsheapbinaryCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_cursor_len(s : DsheapbinaryCursor) -> Int { s.size }

pub fn ds_heap_binary_cursor_get(s : DsheapbinaryCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_cursor_set(s : DsheapbinaryCursor, i : Int, v : Double) -> DsheapbinaryCursor {
  let result = ds_heap_binary_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_cursor_sum(s : DsheapbinaryCursor) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binary_cursor_mean(s : DsheapbinaryCursor) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binary_cursor_scale(s : DsheapbinaryCursor, f : Double) -> DsheapbinaryCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_cursor_add(a : DsheapbinaryCursor, b : DsheapbinaryCursor) -> DsheapbinaryCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binary_cursor_copy(s : DsheapbinaryCursor) -> DsheapbinaryCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_cursor_fill(s : DsheapbinaryCursor, v : Double) -> DsheapbinaryCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_cursor_min(s : DsheapbinaryCursor) -> Double { @_common.min(s.data) }

pub fn ds_heap_binary_cursor_max(s : DsheapbinaryCursor) -> Double { @_common.max(s.data) }

pub fn ds_heap_binary_cursor_to_string(s : DsheapbinaryCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_view_make(size : Int) -> DsheapbinaryView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_view_len(s : DsheapbinaryView) -> Int { s.size }

pub fn ds_heap_binary_view_get(s : DsheapbinaryView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_view_set(s : DsheapbinaryView, i : Int, v : Double) -> DsheapbinaryView {
  let result = ds_heap_binary_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_view_sum(s : DsheapbinaryView) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binary_view_mean(s : DsheapbinaryView) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binary_view_scale(s : DsheapbinaryView, f : Double) -> DsheapbinaryView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_view_add(a : DsheapbinaryView, b : DsheapbinaryView) -> DsheapbinaryView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binary_view_copy(s : DsheapbinaryView) -> DsheapbinaryView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_view_fill(s : DsheapbinaryView, v : Double) -> DsheapbinaryView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_view_min(s : DsheapbinaryView) -> Double { @_common.min(s.data) }

pub fn ds_heap_binary_view_max(s : DsheapbinaryView) -> Double { @_common.max(s.data) }

pub fn ds_heap_binary_view_to_string(s : DsheapbinaryView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_range_make(size : Int) -> DsheapbinaryRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_range_len(s : DsheapbinaryRange) -> Int { s.size }

pub fn ds_heap_binary_range_get(s : DsheapbinaryRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_range_set(s : DsheapbinaryRange, i : Int, v : Double) -> DsheapbinaryRange {
  let result = ds_heap_binary_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_range_sum(s : DsheapbinaryRange) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binary_range_mean(s : DsheapbinaryRange) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binary_range_scale(s : DsheapbinaryRange, f : Double) -> DsheapbinaryRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_range_add(a : DsheapbinaryRange, b : DsheapbinaryRange) -> DsheapbinaryRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binary_range_copy(s : DsheapbinaryRange) -> DsheapbinaryRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_range_fill(s : DsheapbinaryRange, v : Double) -> DsheapbinaryRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_range_min(s : DsheapbinaryRange) -> Double { @_common.min(s.data) }

pub fn ds_heap_binary_range_max(s : DsheapbinaryRange) -> Double { @_common.max(s.data) }

pub fn ds_heap_binary_range_to_string(s : DsheapbinaryRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinarySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_slice_make(size : Int) -> DsheapbinarySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_slice_len(s : DsheapbinarySlice) -> Int { s.size }

pub fn ds_heap_binary_slice_get(s : DsheapbinarySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_slice_set(s : DsheapbinarySlice, i : Int, v : Double) -> DsheapbinarySlice {
  let result = ds_heap_binary_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_slice_sum(s : DsheapbinarySlice) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binary_slice_mean(s : DsheapbinarySlice) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binary_slice_scale(s : DsheapbinarySlice, f : Double) -> DsheapbinarySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_slice_add(a : DsheapbinarySlice, b : DsheapbinarySlice) -> DsheapbinarySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binary_slice_copy(s : DsheapbinarySlice) -> DsheapbinarySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_slice_fill(s : DsheapbinarySlice, v : Double) -> DsheapbinarySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binary_slice_min(s : DsheapbinarySlice) -> Double { @_common.min(s.data) }

pub fn ds_heap_binary_slice_max(s : DsheapbinarySlice) -> Double { @_common.max(s.data) }

pub fn ds_heap_binary_slice_to_string(s : DsheapbinarySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

