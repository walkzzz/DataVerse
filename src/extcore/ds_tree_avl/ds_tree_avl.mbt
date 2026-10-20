///===
/// extcore/ds_tree_avl

pub(all) struct DstreeavlPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_avl_make_point(x : Double, y : Double) -> DstreeavlPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_avl_make_point3(x : Double, y : Double, z : Double) -> DstreeavlPoint {
  { x, y, z, label: 0 }
}

pub fn ds_tree_avl_point_x(pt : DstreeavlPoint) -> Double { pt.x }

pub fn ds_tree_avl_point_y(pt : DstreeavlPoint) -> Double { pt.y }

pub fn ds_tree_avl_point_z(pt : DstreeavlPoint) -> Double { pt.z }

pub fn ds_tree_avl_point_label(pt : DstreeavlPoint) -> Int { pt.label }

pub fn ds_tree_avl_point_dist(a : DstreeavlPoint, b : DstreeavlPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_tree_avl_point_add(a : DstreeavlPoint, b : DstreeavlPoint) -> DstreeavlPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_tree_avl_point_sub(a : DstreeavlPoint, b : DstreeavlPoint) -> DstreeavlPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_tree_avl_point_scale(pt : DstreeavlPoint, s : Double) -> DstreeavlPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_tree_avl_point_dot(a : DstreeavlPoint, b : DstreeavlPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_tree_avl_point_cross(a : DstreeavlPoint, b : DstreeavlPoint) -> DstreeavlPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_tree_avl_point_norm(pt : DstreeavlPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_tree_avl_point_normalize(pt : DstreeavlPoint) -> DstreeavlPoint {
  let n = ds_tree_avl_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_tree_avl_point_scale(pt, 1.0 / n) }
}

pub fn ds_tree_avl_point_negate(pt : DstreeavlPoint) -> DstreeavlPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_tree_avl_point_mid(a : DstreeavlPoint, b : DstreeavlPoint) -> DstreeavlPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_tree_avl_point_lerp(a : DstreeavlPoint, b : DstreeavlPoint, t : Double) -> DstreeavlPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_tree_avl_point_to_string(pt : DstreeavlPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DstreeavlSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_avl_make_series(vals : Array[Double], name : String) -> DstreeavlSeries {
  { vals, name, meta: 0 }
}

pub fn ds_tree_avl_series_len(s : DstreeavlSeries) -> Int { s.vals.length() }

pub fn ds_tree_avl_series_sum(s : DstreeavlSeries) -> Double { @_common.sum(s.vals) }

pub fn ds_tree_avl_series_mean(s : DstreeavlSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_tree_avl_series_min(s : DstreeavlSeries) -> Double { @_common.min(s.vals) }

pub fn ds_tree_avl_series_max(s : DstreeavlSeries) -> Double { @_common.max(s.vals) }

pub fn ds_tree_avl_series_range(s : DstreeavlSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_tree_avl_series_var(s : DstreeavlSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_tree_avl_series_std(s : DstreeavlSeries) -> Double { @_common.std(s.vals) }

pub fn ds_tree_avl_series_median(s : DstreeavlSeries) -> Double { @_common.median(s.vals) }

pub fn ds_tree_avl_series_scale(s : DstreeavlSeries, f : Double) -> DstreeavlSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_tree_avl_series_add(a : DstreeavlSeries, b : DstreeavlSeries) -> DstreeavlSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_tree_avl_series_sub(a : DstreeavlSeries, b : DstreeavlSeries) -> DstreeavlSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_tree_avl_series_normalize(s : DstreeavlSeries) -> DstreeavlSeries {
  let mn = ds_tree_avl_series_min(s)
  let mx = ds_tree_avl_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_tree_avl_series_cumsum(s : DstreeavlSeries) -> DstreeavlSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_tree_avl_series_to_string(s : DstreeavlSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreeavlMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_avl_make_matrix(rows : Int, cols : Int, val : Double) -> DstreeavlMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_avl_matrix_identity(n : Int) -> DstreeavlMatrix {
  let m = ds_tree_avl_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_tree_avl_matrix_get(m : DstreeavlMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_tree_avl_matrix_transpose(m : DstreeavlMatrix) -> DstreeavlMatrix {
  let result = ds_tree_avl_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_tree_avl_matrix_add(a : DstreeavlMatrix, b : DstreeavlMatrix) -> DstreeavlMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_tree_avl_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_tree_avl_matrix_scale(m : DstreeavlMatrix, s : Double) -> DstreeavlMatrix {
  let result = ds_tree_avl_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_tree_avl_matrix_multiply(a : DstreeavlMatrix, b : DstreeavlMatrix) -> DstreeavlMatrix {
  if a.cols != b.rows { return ds_tree_avl_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_tree_avl_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_tree_avl_matrix_trace(m : DstreeavlMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_tree_avl_matrix_det(m : DstreeavlMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_tree_avl_matrix_norm(m : DstreeavlMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_tree_avl_matrix_to_string(m : DstreeavlMatrix) -> String {
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

pub(all) struct DstreeavlVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_avl_make_vector(comps : Array[Double]) -> DstreeavlVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_avl_vector_zero(dim : Int) -> DstreeavlVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_tree_avl_vector_add(a : DstreeavlVector, b : DstreeavlVector) -> DstreeavlVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_tree_avl_vector_sub(a : DstreeavlVector, b : DstreeavlVector) -> DstreeavlVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_tree_avl_vector_scale(v : DstreeavlVector, s : Double) -> DstreeavlVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_tree_avl_vector_dot(a : DstreeavlVector, b : DstreeavlVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_tree_avl_vector_norm(v : DstreeavlVector) -> Double { @_common.sqrt(ds_tree_avl_vector_dot(v, v)) }

pub fn ds_tree_avl_vector_normalize(v : DstreeavlVector) -> DstreeavlVector {
  let n = ds_tree_avl_vector_norm(v)
  if n < 0.0000001 { v } else { ds_tree_avl_vector_scale(v, 1.0 / n) }
}

pub fn ds_tree_avl_vector_dist(a : DstreeavlVector, b : DstreeavlVector) -> Double {
  ds_tree_avl_vector_norm(ds_tree_avl_vector_sub(a, b))
}

pub fn ds_tree_avl_vector_to_string(v : DstreeavlVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_tree_avl_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_tree_avl_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_tree_avl_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_tree_avl_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_tree_avl_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_tree_avl_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_tree_avl_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_tree_avl_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_tree_avl_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_tree_avl_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_tree_avl_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_tree_avl_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_tree_avl_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_tree_avl_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_tree_avl_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_tree_avl_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_tree_avl_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_tree_avl_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_tree_avl_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_tree_avl_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_tree_avl_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_tree_avl_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_tree_avl_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_tree_avl_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_tree_avl_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_tree_avl_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_tree_avl_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_tree_avl_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_tree_avl_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DstreeavlFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_frame_make(size : Int) -> DstreeavlFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_frame_len(s : DstreeavlFrame) -> Int { s.size }

pub fn ds_tree_avl_frame_get(s : DstreeavlFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_frame_set(s : DstreeavlFrame, i : Int, v : Double) -> DstreeavlFrame {
  let result = ds_tree_avl_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_frame_sum(s : DstreeavlFrame) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_frame_mean(s : DstreeavlFrame) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_frame_scale(s : DstreeavlFrame, f : Double) -> DstreeavlFrame {
  let result = ds_tree_avl_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_frame_add(a : DstreeavlFrame, b : DstreeavlFrame) -> DstreeavlFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_frame_copy(s : DstreeavlFrame) -> DstreeavlFrame {
  let result = ds_tree_avl_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_frame_fill(s : DstreeavlFrame, v : Double) -> DstreeavlFrame {
  let result = ds_tree_avl_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_frame_min(s : DstreeavlFrame) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_frame_max(s : DstreeavlFrame) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_frame_to_string(s : DstreeavlFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_table_make(size : Int) -> DstreeavlTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_table_len(s : DstreeavlTable) -> Int { s.size }

pub fn ds_tree_avl_table_get(s : DstreeavlTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_table_set(s : DstreeavlTable, i : Int, v : Double) -> DstreeavlTable {
  let result = ds_tree_avl_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_table_sum(s : DstreeavlTable) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_table_mean(s : DstreeavlTable) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_table_scale(s : DstreeavlTable, f : Double) -> DstreeavlTable {
  let result = ds_tree_avl_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_table_add(a : DstreeavlTable, b : DstreeavlTable) -> DstreeavlTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_table_copy(s : DstreeavlTable) -> DstreeavlTable {
  let result = ds_tree_avl_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_table_fill(s : DstreeavlTable, v : Double) -> DstreeavlTable {
  let result = ds_tree_avl_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_table_min(s : DstreeavlTable) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_table_max(s : DstreeavlTable) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_table_to_string(s : DstreeavlTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_graphn_make(size : Int) -> DstreeavlGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_graphn_len(s : DstreeavlGraphN) -> Int { s.size }

pub fn ds_tree_avl_graphn_get(s : DstreeavlGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_graphn_set(s : DstreeavlGraphN, i : Int, v : Double) -> DstreeavlGraphN {
  let result = ds_tree_avl_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_graphn_sum(s : DstreeavlGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_graphn_mean(s : DstreeavlGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_graphn_scale(s : DstreeavlGraphN, f : Double) -> DstreeavlGraphN {
  let result = ds_tree_avl_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_graphn_add(a : DstreeavlGraphN, b : DstreeavlGraphN) -> DstreeavlGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_graphn_copy(s : DstreeavlGraphN) -> DstreeavlGraphN {
  let result = ds_tree_avl_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_graphn_fill(s : DstreeavlGraphN, v : Double) -> DstreeavlGraphN {
  let result = ds_tree_avl_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_graphn_min(s : DstreeavlGraphN) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_graphn_max(s : DstreeavlGraphN) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_graphn_to_string(s : DstreeavlGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_node_make(size : Int) -> DstreeavlNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_node_len(s : DstreeavlNode) -> Int { s.size }

pub fn ds_tree_avl_node_get(s : DstreeavlNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_node_set(s : DstreeavlNode, i : Int, v : Double) -> DstreeavlNode {
  let result = ds_tree_avl_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_node_sum(s : DstreeavlNode) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_node_mean(s : DstreeavlNode) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_node_scale(s : DstreeavlNode, f : Double) -> DstreeavlNode {
  let result = ds_tree_avl_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_node_add(a : DstreeavlNode, b : DstreeavlNode) -> DstreeavlNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_node_copy(s : DstreeavlNode) -> DstreeavlNode {
  let result = ds_tree_avl_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_node_fill(s : DstreeavlNode, v : Double) -> DstreeavlNode {
  let result = ds_tree_avl_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_node_min(s : DstreeavlNode) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_node_max(s : DstreeavlNode) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_node_to_string(s : DstreeavlNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_edge_make(size : Int) -> DstreeavlEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_edge_len(s : DstreeavlEdge) -> Int { s.size }

pub fn ds_tree_avl_edge_get(s : DstreeavlEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_edge_set(s : DstreeavlEdge, i : Int, v : Double) -> DstreeavlEdge {
  let result = ds_tree_avl_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_edge_sum(s : DstreeavlEdge) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_edge_mean(s : DstreeavlEdge) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_edge_scale(s : DstreeavlEdge, f : Double) -> DstreeavlEdge {
  let result = ds_tree_avl_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_edge_add(a : DstreeavlEdge, b : DstreeavlEdge) -> DstreeavlEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_edge_copy(s : DstreeavlEdge) -> DstreeavlEdge {
  let result = ds_tree_avl_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_edge_fill(s : DstreeavlEdge, v : Double) -> DstreeavlEdge {
  let result = ds_tree_avl_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_edge_min(s : DstreeavlEdge) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_edge_max(s : DstreeavlEdge) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_edge_to_string(s : DstreeavlEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_path_make(size : Int) -> DstreeavlPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_path_len(s : DstreeavlPath) -> Int { s.size }

pub fn ds_tree_avl_path_get(s : DstreeavlPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_path_set(s : DstreeavlPath, i : Int, v : Double) -> DstreeavlPath {
  let result = ds_tree_avl_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_path_sum(s : DstreeavlPath) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_path_mean(s : DstreeavlPath) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_path_scale(s : DstreeavlPath, f : Double) -> DstreeavlPath {
  let result = ds_tree_avl_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_path_add(a : DstreeavlPath, b : DstreeavlPath) -> DstreeavlPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_path_copy(s : DstreeavlPath) -> DstreeavlPath {
  let result = ds_tree_avl_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_path_fill(s : DstreeavlPath, v : Double) -> DstreeavlPath {
  let result = ds_tree_avl_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_path_min(s : DstreeavlPath) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_path_max(s : DstreeavlPath) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_path_to_string(s : DstreeavlPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_cluster_make(size : Int) -> DstreeavlCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_cluster_len(s : DstreeavlCluster) -> Int { s.size }

pub fn ds_tree_avl_cluster_get(s : DstreeavlCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_cluster_set(s : DstreeavlCluster, i : Int, v : Double) -> DstreeavlCluster {
  let result = ds_tree_avl_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_cluster_sum(s : DstreeavlCluster) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_cluster_mean(s : DstreeavlCluster) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_cluster_scale(s : DstreeavlCluster, f : Double) -> DstreeavlCluster {
  let result = ds_tree_avl_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_cluster_add(a : DstreeavlCluster, b : DstreeavlCluster) -> DstreeavlCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_cluster_copy(s : DstreeavlCluster) -> DstreeavlCluster {
  let result = ds_tree_avl_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_cluster_fill(s : DstreeavlCluster, v : Double) -> DstreeavlCluster {
  let result = ds_tree_avl_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_cluster_min(s : DstreeavlCluster) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_cluster_max(s : DstreeavlCluster) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_cluster_to_string(s : DstreeavlCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_model_make(size : Int) -> DstreeavlModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_model_len(s : DstreeavlModel) -> Int { s.size }

pub fn ds_tree_avl_model_get(s : DstreeavlModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_model_set(s : DstreeavlModel, i : Int, v : Double) -> DstreeavlModel {
  let result = ds_tree_avl_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_model_sum(s : DstreeavlModel) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_model_mean(s : DstreeavlModel) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_model_scale(s : DstreeavlModel, f : Double) -> DstreeavlModel {
  let result = ds_tree_avl_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_model_add(a : DstreeavlModel, b : DstreeavlModel) -> DstreeavlModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_model_copy(s : DstreeavlModel) -> DstreeavlModel {
  let result = ds_tree_avl_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_model_fill(s : DstreeavlModel, v : Double) -> DstreeavlModel {
  let result = ds_tree_avl_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_model_min(s : DstreeavlModel) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_model_max(s : DstreeavlModel) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_model_to_string(s : DstreeavlModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_layer_make(size : Int) -> DstreeavlLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_layer_len(s : DstreeavlLayer) -> Int { s.size }

pub fn ds_tree_avl_layer_get(s : DstreeavlLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_layer_set(s : DstreeavlLayer, i : Int, v : Double) -> DstreeavlLayer {
  let result = ds_tree_avl_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_layer_sum(s : DstreeavlLayer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_layer_mean(s : DstreeavlLayer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_layer_scale(s : DstreeavlLayer, f : Double) -> DstreeavlLayer {
  let result = ds_tree_avl_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_layer_add(a : DstreeavlLayer, b : DstreeavlLayer) -> DstreeavlLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_layer_copy(s : DstreeavlLayer) -> DstreeavlLayer {
  let result = ds_tree_avl_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_layer_fill(s : DstreeavlLayer, v : Double) -> DstreeavlLayer {
  let result = ds_tree_avl_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_layer_min(s : DstreeavlLayer) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_layer_max(s : DstreeavlLayer) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_layer_to_string(s : DstreeavlLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_buffer_make(size : Int) -> DstreeavlBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_buffer_len(s : DstreeavlBuffer) -> Int { s.size }

pub fn ds_tree_avl_buffer_get(s : DstreeavlBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_buffer_set(s : DstreeavlBuffer, i : Int, v : Double) -> DstreeavlBuffer {
  let result = ds_tree_avl_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_buffer_sum(s : DstreeavlBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_buffer_mean(s : DstreeavlBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_buffer_scale(s : DstreeavlBuffer, f : Double) -> DstreeavlBuffer {
  let result = ds_tree_avl_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_buffer_add(a : DstreeavlBuffer, b : DstreeavlBuffer) -> DstreeavlBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_buffer_copy(s : DstreeavlBuffer) -> DstreeavlBuffer {
  let result = ds_tree_avl_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_buffer_fill(s : DstreeavlBuffer, v : Double) -> DstreeavlBuffer {
  let result = ds_tree_avl_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_buffer_min(s : DstreeavlBuffer) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_buffer_max(s : DstreeavlBuffer) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_buffer_to_string(s : DstreeavlBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_cursor_make(size : Int) -> DstreeavlCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_cursor_len(s : DstreeavlCursor) -> Int { s.size }

pub fn ds_tree_avl_cursor_get(s : DstreeavlCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_cursor_set(s : DstreeavlCursor, i : Int, v : Double) -> DstreeavlCursor {
  let result = ds_tree_avl_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_cursor_sum(s : DstreeavlCursor) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_cursor_mean(s : DstreeavlCursor) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_cursor_scale(s : DstreeavlCursor, f : Double) -> DstreeavlCursor {
  let result = ds_tree_avl_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_cursor_add(a : DstreeavlCursor, b : DstreeavlCursor) -> DstreeavlCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_cursor_copy(s : DstreeavlCursor) -> DstreeavlCursor {
  let result = ds_tree_avl_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_cursor_fill(s : DstreeavlCursor, v : Double) -> DstreeavlCursor {
  let result = ds_tree_avl_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_cursor_min(s : DstreeavlCursor) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_cursor_max(s : DstreeavlCursor) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_cursor_to_string(s : DstreeavlCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_view_make(size : Int) -> DstreeavlView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_view_len(s : DstreeavlView) -> Int { s.size }

pub fn ds_tree_avl_view_get(s : DstreeavlView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_view_set(s : DstreeavlView, i : Int, v : Double) -> DstreeavlView {
  let result = ds_tree_avl_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_view_sum(s : DstreeavlView) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_view_mean(s : DstreeavlView) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_view_scale(s : DstreeavlView, f : Double) -> DstreeavlView {
  let result = ds_tree_avl_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_view_add(a : DstreeavlView, b : DstreeavlView) -> DstreeavlView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_view_copy(s : DstreeavlView) -> DstreeavlView {
  let result = ds_tree_avl_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_view_fill(s : DstreeavlView, v : Double) -> DstreeavlView {
  let result = ds_tree_avl_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_view_min(s : DstreeavlView) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_view_max(s : DstreeavlView) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_view_to_string(s : DstreeavlView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_range_make(size : Int) -> DstreeavlRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_range_len(s : DstreeavlRange) -> Int { s.size }

pub fn ds_tree_avl_range_get(s : DstreeavlRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_range_set(s : DstreeavlRange, i : Int, v : Double) -> DstreeavlRange {
  let result = ds_tree_avl_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_range_sum(s : DstreeavlRange) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_range_mean(s : DstreeavlRange) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_range_scale(s : DstreeavlRange, f : Double) -> DstreeavlRange {
  let result = ds_tree_avl_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_range_add(a : DstreeavlRange, b : DstreeavlRange) -> DstreeavlRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_range_copy(s : DstreeavlRange) -> DstreeavlRange {
  let result = ds_tree_avl_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_range_fill(s : DstreeavlRange, v : Double) -> DstreeavlRange {
  let result = ds_tree_avl_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_range_min(s : DstreeavlRange) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_range_max(s : DstreeavlRange) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_range_to_string(s : DstreeavlRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_slice_make(size : Int) -> DstreeavlSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_slice_len(s : DstreeavlSlice) -> Int { s.size }

pub fn ds_tree_avl_slice_get(s : DstreeavlSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_slice_set(s : DstreeavlSlice, i : Int, v : Double) -> DstreeavlSlice {
  let result = ds_tree_avl_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_slice_sum(s : DstreeavlSlice) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_slice_mean(s : DstreeavlSlice) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_slice_scale(s : DstreeavlSlice, f : Double) -> DstreeavlSlice {
  let result = ds_tree_avl_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_slice_add(a : DstreeavlSlice, b : DstreeavlSlice) -> DstreeavlSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_slice_copy(s : DstreeavlSlice) -> DstreeavlSlice {
  let result = ds_tree_avl_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_slice_fill(s : DstreeavlSlice, v : Double) -> DstreeavlSlice {
  let result = ds_tree_avl_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_slice_min(s : DstreeavlSlice) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_slice_max(s : DstreeavlSlice) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_slice_to_string(s : DstreeavlSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

