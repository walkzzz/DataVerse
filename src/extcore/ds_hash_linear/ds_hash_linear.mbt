///===
/// extcore/ds_hash_linear

pub(all) struct DshashlinearPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_linear_make_point(x : Double, y : Double) -> DshashlinearPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_linear_make_point3(x : Double, y : Double, z : Double) -> DshashlinearPoint {
  { x, y, z, label: 0 }
}

pub fn ds_hash_linear_point_x(pt : DshashlinearPoint) -> Double { pt.x }

pub fn ds_hash_linear_point_y(pt : DshashlinearPoint) -> Double { pt.y }

pub fn ds_hash_linear_point_z(pt : DshashlinearPoint) -> Double { pt.z }

pub fn ds_hash_linear_point_label(pt : DshashlinearPoint) -> Int { pt.label }

pub fn ds_hash_linear_point_dist(a : DshashlinearPoint, b : DshashlinearPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_hash_linear_point_add(a : DshashlinearPoint, b : DshashlinearPoint) -> DshashlinearPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_hash_linear_point_sub(a : DshashlinearPoint, b : DshashlinearPoint) -> DshashlinearPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_hash_linear_point_scale(pt : DshashlinearPoint, s : Double) -> DshashlinearPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_hash_linear_point_dot(a : DshashlinearPoint, b : DshashlinearPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_hash_linear_point_cross(a : DshashlinearPoint, b : DshashlinearPoint) -> DshashlinearPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_hash_linear_point_norm(pt : DshashlinearPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_hash_linear_point_normalize(pt : DshashlinearPoint) -> DshashlinearPoint {
  let n = ds_hash_linear_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_hash_linear_point_scale(pt, 1.0 / n) }
}

pub fn ds_hash_linear_point_negate(pt : DshashlinearPoint) -> DshashlinearPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_hash_linear_point_mid(a : DshashlinearPoint, b : DshashlinearPoint) -> DshashlinearPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_hash_linear_point_lerp(a : DshashlinearPoint, b : DshashlinearPoint, t : Double) -> DshashlinearPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_hash_linear_point_to_string(pt : DshashlinearPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DshashlinearSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_linear_make_series(vals : Array[Double], name : String) -> DshashlinearSeries {
  { vals, name, meta: 0 }
}

pub fn ds_hash_linear_series_len(s : DshashlinearSeries) -> Int { s.vals.length() }

pub fn ds_hash_linear_series_sum(s : DshashlinearSeries) -> Double { @_common.sum(s.vals) }

pub fn ds_hash_linear_series_mean(s : DshashlinearSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_hash_linear_series_min(s : DshashlinearSeries) -> Double { @_common.min(s.vals) }

pub fn ds_hash_linear_series_max(s : DshashlinearSeries) -> Double { @_common.max(s.vals) }

pub fn ds_hash_linear_series_range(s : DshashlinearSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_hash_linear_series_var(s : DshashlinearSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_hash_linear_series_std(s : DshashlinearSeries) -> Double { @_common.std(s.vals) }

pub fn ds_hash_linear_series_median(s : DshashlinearSeries) -> Double { @_common.median(s.vals) }

pub fn ds_hash_linear_series_scale(s : DshashlinearSeries, f : Double) -> DshashlinearSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_hash_linear_series_add(a : DshashlinearSeries, b : DshashlinearSeries) -> DshashlinearSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_hash_linear_series_sub(a : DshashlinearSeries, b : DshashlinearSeries) -> DshashlinearSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_hash_linear_series_normalize(s : DshashlinearSeries) -> DshashlinearSeries {
  let mn = ds_hash_linear_series_min(s)
  let mx = ds_hash_linear_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_hash_linear_series_cumsum(s : DshashlinearSeries) -> DshashlinearSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_hash_linear_series_to_string(s : DshashlinearSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashlinearMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_linear_make_matrix(rows : Int, cols : Int, val : Double) -> DshashlinearMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_linear_matrix_identity(n : Int) -> DshashlinearMatrix {
  let m = ds_hash_linear_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_hash_linear_matrix_get(m : DshashlinearMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_hash_linear_matrix_transpose(m : DshashlinearMatrix) -> DshashlinearMatrix {
  let result = ds_hash_linear_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_hash_linear_matrix_add(a : DshashlinearMatrix, b : DshashlinearMatrix) -> DshashlinearMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_hash_linear_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_hash_linear_matrix_scale(m : DshashlinearMatrix, s : Double) -> DshashlinearMatrix {
  let result = ds_hash_linear_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_hash_linear_matrix_multiply(a : DshashlinearMatrix, b : DshashlinearMatrix) -> DshashlinearMatrix {
  if a.cols != b.rows { return ds_hash_linear_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_hash_linear_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_hash_linear_matrix_trace(m : DshashlinearMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_hash_linear_matrix_det(m : DshashlinearMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_hash_linear_matrix_norm(m : DshashlinearMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_hash_linear_matrix_to_string(m : DshashlinearMatrix) -> String {
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

pub(all) struct DshashlinearVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_linear_make_vector(comps : Array[Double]) -> DshashlinearVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_linear_vector_zero(dim : Int) -> DshashlinearVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_hash_linear_vector_add(a : DshashlinearVector, b : DshashlinearVector) -> DshashlinearVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_linear_vector_sub(a : DshashlinearVector, b : DshashlinearVector) -> DshashlinearVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_linear_vector_scale(v : DshashlinearVector, s : Double) -> DshashlinearVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_hash_linear_vector_dot(a : DshashlinearVector, b : DshashlinearVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_hash_linear_vector_norm(v : DshashlinearVector) -> Double { @_common.sqrt(ds_hash_linear_vector_dot(v, v)) }

pub fn ds_hash_linear_vector_normalize(v : DshashlinearVector) -> DshashlinearVector {
  let n = ds_hash_linear_vector_norm(v)
  if n < 0.0000001 { v } else { ds_hash_linear_vector_scale(v, 1.0 / n) }
}

pub fn ds_hash_linear_vector_dist(a : DshashlinearVector, b : DshashlinearVector) -> Double {
  ds_hash_linear_vector_norm(ds_hash_linear_vector_sub(a, b))
}

pub fn ds_hash_linear_vector_to_string(v : DshashlinearVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_hash_linear_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_hash_linear_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_hash_linear_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_hash_linear_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_hash_linear_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_hash_linear_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_hash_linear_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_hash_linear_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_hash_linear_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_hash_linear_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_hash_linear_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_hash_linear_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_hash_linear_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_hash_linear_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_hash_linear_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_hash_linear_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_hash_linear_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_hash_linear_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_hash_linear_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_hash_linear_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_hash_linear_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_hash_linear_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_hash_linear_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_hash_linear_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_hash_linear_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_hash_linear_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_hash_linear_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_hash_linear_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_hash_linear_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DshashlinearFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_frame_make(size : Int) -> DshashlinearFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_frame_len(s : DshashlinearFrame) -> Int { s.size }

pub fn ds_hash_linear_frame_get(s : DshashlinearFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_frame_set(s : DshashlinearFrame, i : Int, v : Double) -> DshashlinearFrame {
  let result = ds_hash_linear_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_frame_sum(s : DshashlinearFrame) -> Double { @_common.sum(s.data) }

pub fn ds_hash_linear_frame_mean(s : DshashlinearFrame) -> Double { @_common.mean(s.data) }

pub fn ds_hash_linear_frame_scale(s : DshashlinearFrame, f : Double) -> DshashlinearFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_frame_add(a : DshashlinearFrame, b : DshashlinearFrame) -> DshashlinearFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_linear_frame_copy(s : DshashlinearFrame) -> DshashlinearFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_frame_fill(s : DshashlinearFrame, v : Double) -> DshashlinearFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_frame_min(s : DshashlinearFrame) -> Double { @_common.min(s.data) }

pub fn ds_hash_linear_frame_max(s : DshashlinearFrame) -> Double { @_common.max(s.data) }

pub fn ds_hash_linear_frame_to_string(s : DshashlinearFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_table_make(size : Int) -> DshashlinearTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_table_len(s : DshashlinearTable) -> Int { s.size }

pub fn ds_hash_linear_table_get(s : DshashlinearTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_table_set(s : DshashlinearTable, i : Int, v : Double) -> DshashlinearTable {
  let result = ds_hash_linear_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_table_sum(s : DshashlinearTable) -> Double { @_common.sum(s.data) }

pub fn ds_hash_linear_table_mean(s : DshashlinearTable) -> Double { @_common.mean(s.data) }

pub fn ds_hash_linear_table_scale(s : DshashlinearTable, f : Double) -> DshashlinearTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_table_add(a : DshashlinearTable, b : DshashlinearTable) -> DshashlinearTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_linear_table_copy(s : DshashlinearTable) -> DshashlinearTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_table_fill(s : DshashlinearTable, v : Double) -> DshashlinearTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_table_min(s : DshashlinearTable) -> Double { @_common.min(s.data) }

pub fn ds_hash_linear_table_max(s : DshashlinearTable) -> Double { @_common.max(s.data) }

pub fn ds_hash_linear_table_to_string(s : DshashlinearTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_graphn_make(size : Int) -> DshashlinearGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_graphn_len(s : DshashlinearGraphN) -> Int { s.size }

pub fn ds_hash_linear_graphn_get(s : DshashlinearGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_graphn_set(s : DshashlinearGraphN, i : Int, v : Double) -> DshashlinearGraphN {
  let result = ds_hash_linear_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_graphn_sum(s : DshashlinearGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_hash_linear_graphn_mean(s : DshashlinearGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_hash_linear_graphn_scale(s : DshashlinearGraphN, f : Double) -> DshashlinearGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_graphn_add(a : DshashlinearGraphN, b : DshashlinearGraphN) -> DshashlinearGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_linear_graphn_copy(s : DshashlinearGraphN) -> DshashlinearGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_graphn_fill(s : DshashlinearGraphN, v : Double) -> DshashlinearGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_graphn_min(s : DshashlinearGraphN) -> Double { @_common.min(s.data) }

pub fn ds_hash_linear_graphn_max(s : DshashlinearGraphN) -> Double { @_common.max(s.data) }

pub fn ds_hash_linear_graphn_to_string(s : DshashlinearGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_node_make(size : Int) -> DshashlinearNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_node_len(s : DshashlinearNode) -> Int { s.size }

pub fn ds_hash_linear_node_get(s : DshashlinearNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_node_set(s : DshashlinearNode, i : Int, v : Double) -> DshashlinearNode {
  let result = ds_hash_linear_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_node_sum(s : DshashlinearNode) -> Double { @_common.sum(s.data) }

pub fn ds_hash_linear_node_mean(s : DshashlinearNode) -> Double { @_common.mean(s.data) }

pub fn ds_hash_linear_node_scale(s : DshashlinearNode, f : Double) -> DshashlinearNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_node_add(a : DshashlinearNode, b : DshashlinearNode) -> DshashlinearNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_linear_node_copy(s : DshashlinearNode) -> DshashlinearNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_node_fill(s : DshashlinearNode, v : Double) -> DshashlinearNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_node_min(s : DshashlinearNode) -> Double { @_common.min(s.data) }

pub fn ds_hash_linear_node_max(s : DshashlinearNode) -> Double { @_common.max(s.data) }

pub fn ds_hash_linear_node_to_string(s : DshashlinearNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_edge_make(size : Int) -> DshashlinearEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_edge_len(s : DshashlinearEdge) -> Int { s.size }

pub fn ds_hash_linear_edge_get(s : DshashlinearEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_edge_set(s : DshashlinearEdge, i : Int, v : Double) -> DshashlinearEdge {
  let result = ds_hash_linear_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_edge_sum(s : DshashlinearEdge) -> Double { @_common.sum(s.data) }

pub fn ds_hash_linear_edge_mean(s : DshashlinearEdge) -> Double { @_common.mean(s.data) }

pub fn ds_hash_linear_edge_scale(s : DshashlinearEdge, f : Double) -> DshashlinearEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_edge_add(a : DshashlinearEdge, b : DshashlinearEdge) -> DshashlinearEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_linear_edge_copy(s : DshashlinearEdge) -> DshashlinearEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_edge_fill(s : DshashlinearEdge, v : Double) -> DshashlinearEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_edge_min(s : DshashlinearEdge) -> Double { @_common.min(s.data) }

pub fn ds_hash_linear_edge_max(s : DshashlinearEdge) -> Double { @_common.max(s.data) }

pub fn ds_hash_linear_edge_to_string(s : DshashlinearEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_path_make(size : Int) -> DshashlinearPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_path_len(s : DshashlinearPath) -> Int { s.size }

pub fn ds_hash_linear_path_get(s : DshashlinearPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_path_set(s : DshashlinearPath, i : Int, v : Double) -> DshashlinearPath {
  let result = ds_hash_linear_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_path_sum(s : DshashlinearPath) -> Double { @_common.sum(s.data) }

pub fn ds_hash_linear_path_mean(s : DshashlinearPath) -> Double { @_common.mean(s.data) }

pub fn ds_hash_linear_path_scale(s : DshashlinearPath, f : Double) -> DshashlinearPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_path_add(a : DshashlinearPath, b : DshashlinearPath) -> DshashlinearPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_linear_path_copy(s : DshashlinearPath) -> DshashlinearPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_path_fill(s : DshashlinearPath, v : Double) -> DshashlinearPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_path_min(s : DshashlinearPath) -> Double { @_common.min(s.data) }

pub fn ds_hash_linear_path_max(s : DshashlinearPath) -> Double { @_common.max(s.data) }

pub fn ds_hash_linear_path_to_string(s : DshashlinearPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_cluster_make(size : Int) -> DshashlinearCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_cluster_len(s : DshashlinearCluster) -> Int { s.size }

pub fn ds_hash_linear_cluster_get(s : DshashlinearCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_cluster_set(s : DshashlinearCluster, i : Int, v : Double) -> DshashlinearCluster {
  let result = ds_hash_linear_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_cluster_sum(s : DshashlinearCluster) -> Double { @_common.sum(s.data) }

pub fn ds_hash_linear_cluster_mean(s : DshashlinearCluster) -> Double { @_common.mean(s.data) }

pub fn ds_hash_linear_cluster_scale(s : DshashlinearCluster, f : Double) -> DshashlinearCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_cluster_add(a : DshashlinearCluster, b : DshashlinearCluster) -> DshashlinearCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_linear_cluster_copy(s : DshashlinearCluster) -> DshashlinearCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_cluster_fill(s : DshashlinearCluster, v : Double) -> DshashlinearCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_cluster_min(s : DshashlinearCluster) -> Double { @_common.min(s.data) }

pub fn ds_hash_linear_cluster_max(s : DshashlinearCluster) -> Double { @_common.max(s.data) }

pub fn ds_hash_linear_cluster_to_string(s : DshashlinearCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_model_make(size : Int) -> DshashlinearModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_model_len(s : DshashlinearModel) -> Int { s.size }

pub fn ds_hash_linear_model_get(s : DshashlinearModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_model_set(s : DshashlinearModel, i : Int, v : Double) -> DshashlinearModel {
  let result = ds_hash_linear_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_model_sum(s : DshashlinearModel) -> Double { @_common.sum(s.data) }

pub fn ds_hash_linear_model_mean(s : DshashlinearModel) -> Double { @_common.mean(s.data) }

pub fn ds_hash_linear_model_scale(s : DshashlinearModel, f : Double) -> DshashlinearModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_model_add(a : DshashlinearModel, b : DshashlinearModel) -> DshashlinearModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_linear_model_copy(s : DshashlinearModel) -> DshashlinearModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_model_fill(s : DshashlinearModel, v : Double) -> DshashlinearModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_model_min(s : DshashlinearModel) -> Double { @_common.min(s.data) }

pub fn ds_hash_linear_model_max(s : DshashlinearModel) -> Double { @_common.max(s.data) }

pub fn ds_hash_linear_model_to_string(s : DshashlinearModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_layer_make(size : Int) -> DshashlinearLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_layer_len(s : DshashlinearLayer) -> Int { s.size }

pub fn ds_hash_linear_layer_get(s : DshashlinearLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_layer_set(s : DshashlinearLayer, i : Int, v : Double) -> DshashlinearLayer {
  let result = ds_hash_linear_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_layer_sum(s : DshashlinearLayer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_linear_layer_mean(s : DshashlinearLayer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_linear_layer_scale(s : DshashlinearLayer, f : Double) -> DshashlinearLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_layer_add(a : DshashlinearLayer, b : DshashlinearLayer) -> DshashlinearLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_linear_layer_copy(s : DshashlinearLayer) -> DshashlinearLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_layer_fill(s : DshashlinearLayer, v : Double) -> DshashlinearLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_layer_min(s : DshashlinearLayer) -> Double { @_common.min(s.data) }

pub fn ds_hash_linear_layer_max(s : DshashlinearLayer) -> Double { @_common.max(s.data) }

pub fn ds_hash_linear_layer_to_string(s : DshashlinearLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_buffer_make(size : Int) -> DshashlinearBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_buffer_len(s : DshashlinearBuffer) -> Int { s.size }

pub fn ds_hash_linear_buffer_get(s : DshashlinearBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_buffer_set(s : DshashlinearBuffer, i : Int, v : Double) -> DshashlinearBuffer {
  let result = ds_hash_linear_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_buffer_sum(s : DshashlinearBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_linear_buffer_mean(s : DshashlinearBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_linear_buffer_scale(s : DshashlinearBuffer, f : Double) -> DshashlinearBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_buffer_add(a : DshashlinearBuffer, b : DshashlinearBuffer) -> DshashlinearBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_linear_buffer_copy(s : DshashlinearBuffer) -> DshashlinearBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_buffer_fill(s : DshashlinearBuffer, v : Double) -> DshashlinearBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_buffer_min(s : DshashlinearBuffer) -> Double { @_common.min(s.data) }

pub fn ds_hash_linear_buffer_max(s : DshashlinearBuffer) -> Double { @_common.max(s.data) }

pub fn ds_hash_linear_buffer_to_string(s : DshashlinearBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_cursor_make(size : Int) -> DshashlinearCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_cursor_len(s : DshashlinearCursor) -> Int { s.size }

pub fn ds_hash_linear_cursor_get(s : DshashlinearCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_cursor_set(s : DshashlinearCursor, i : Int, v : Double) -> DshashlinearCursor {
  let result = ds_hash_linear_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_cursor_sum(s : DshashlinearCursor) -> Double { @_common.sum(s.data) }

pub fn ds_hash_linear_cursor_mean(s : DshashlinearCursor) -> Double { @_common.mean(s.data) }

pub fn ds_hash_linear_cursor_scale(s : DshashlinearCursor, f : Double) -> DshashlinearCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_cursor_add(a : DshashlinearCursor, b : DshashlinearCursor) -> DshashlinearCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_linear_cursor_copy(s : DshashlinearCursor) -> DshashlinearCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_cursor_fill(s : DshashlinearCursor, v : Double) -> DshashlinearCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_cursor_min(s : DshashlinearCursor) -> Double { @_common.min(s.data) }

pub fn ds_hash_linear_cursor_max(s : DshashlinearCursor) -> Double { @_common.max(s.data) }

pub fn ds_hash_linear_cursor_to_string(s : DshashlinearCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_view_make(size : Int) -> DshashlinearView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_view_len(s : DshashlinearView) -> Int { s.size }

pub fn ds_hash_linear_view_get(s : DshashlinearView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_view_set(s : DshashlinearView, i : Int, v : Double) -> DshashlinearView {
  let result = ds_hash_linear_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_view_sum(s : DshashlinearView) -> Double { @_common.sum(s.data) }

pub fn ds_hash_linear_view_mean(s : DshashlinearView) -> Double { @_common.mean(s.data) }

pub fn ds_hash_linear_view_scale(s : DshashlinearView, f : Double) -> DshashlinearView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_view_add(a : DshashlinearView, b : DshashlinearView) -> DshashlinearView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_linear_view_copy(s : DshashlinearView) -> DshashlinearView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_view_fill(s : DshashlinearView, v : Double) -> DshashlinearView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_view_min(s : DshashlinearView) -> Double { @_common.min(s.data) }

pub fn ds_hash_linear_view_max(s : DshashlinearView) -> Double { @_common.max(s.data) }

pub fn ds_hash_linear_view_to_string(s : DshashlinearView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_range_make(size : Int) -> DshashlinearRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_range_len(s : DshashlinearRange) -> Int { s.size }

pub fn ds_hash_linear_range_get(s : DshashlinearRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_range_set(s : DshashlinearRange, i : Int, v : Double) -> DshashlinearRange {
  let result = ds_hash_linear_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_range_sum(s : DshashlinearRange) -> Double { @_common.sum(s.data) }

pub fn ds_hash_linear_range_mean(s : DshashlinearRange) -> Double { @_common.mean(s.data) }

pub fn ds_hash_linear_range_scale(s : DshashlinearRange, f : Double) -> DshashlinearRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_range_add(a : DshashlinearRange, b : DshashlinearRange) -> DshashlinearRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_linear_range_copy(s : DshashlinearRange) -> DshashlinearRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_range_fill(s : DshashlinearRange, v : Double) -> DshashlinearRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_range_min(s : DshashlinearRange) -> Double { @_common.min(s.data) }

pub fn ds_hash_linear_range_max(s : DshashlinearRange) -> Double { @_common.max(s.data) }

pub fn ds_hash_linear_range_to_string(s : DshashlinearRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_slice_make(size : Int) -> DshashlinearSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_slice_len(s : DshashlinearSlice) -> Int { s.size }

pub fn ds_hash_linear_slice_get(s : DshashlinearSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_slice_set(s : DshashlinearSlice, i : Int, v : Double) -> DshashlinearSlice {
  let result = ds_hash_linear_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_slice_sum(s : DshashlinearSlice) -> Double { @_common.sum(s.data) }

pub fn ds_hash_linear_slice_mean(s : DshashlinearSlice) -> Double { @_common.mean(s.data) }

pub fn ds_hash_linear_slice_scale(s : DshashlinearSlice, f : Double) -> DshashlinearSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_slice_add(a : DshashlinearSlice, b : DshashlinearSlice) -> DshashlinearSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_linear_slice_copy(s : DshashlinearSlice) -> DshashlinearSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_slice_fill(s : DshashlinearSlice, v : Double) -> DshashlinearSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_linear_slice_min(s : DshashlinearSlice) -> Double { @_common.min(s.data) }

pub fn ds_hash_linear_slice_max(s : DshashlinearSlice) -> Double { @_common.max(s.data) }

pub fn ds_hash_linear_slice_to_string(s : DshashlinearSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

