///===
/// extcore/ds_tree_bst

pub(all) struct DstreebstPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_bst_make_point(x : Double, y : Double) -> DstreebstPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_bst_make_point3(x : Double, y : Double, z : Double) -> DstreebstPoint {
  { x, y, z, label: 0 }
}

pub fn ds_tree_bst_point_x(pt : DstreebstPoint) -> Double { pt.x }

pub fn ds_tree_bst_point_y(pt : DstreebstPoint) -> Double { pt.y }

pub fn ds_tree_bst_point_z(pt : DstreebstPoint) -> Double { pt.z }

pub fn ds_tree_bst_point_label(pt : DstreebstPoint) -> Int { pt.label }

pub fn ds_tree_bst_point_dist(a : DstreebstPoint, b : DstreebstPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_tree_bst_point_add(a : DstreebstPoint, b : DstreebstPoint) -> DstreebstPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_tree_bst_point_sub(a : DstreebstPoint, b : DstreebstPoint) -> DstreebstPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_tree_bst_point_scale(pt : DstreebstPoint, s : Double) -> DstreebstPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_tree_bst_point_dot(a : DstreebstPoint, b : DstreebstPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_tree_bst_point_cross(a : DstreebstPoint, b : DstreebstPoint) -> DstreebstPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_tree_bst_point_norm(pt : DstreebstPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_tree_bst_point_normalize(pt : DstreebstPoint) -> DstreebstPoint {
  let n = ds_tree_bst_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_tree_bst_point_scale(pt, 1.0 / n) }
}

pub fn ds_tree_bst_point_negate(pt : DstreebstPoint) -> DstreebstPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_tree_bst_point_mid(a : DstreebstPoint, b : DstreebstPoint) -> DstreebstPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_tree_bst_point_lerp(a : DstreebstPoint, b : DstreebstPoint, t : Double) -> DstreebstPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_tree_bst_point_to_string(pt : DstreebstPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DstreebstSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_bst_make_series(vals : Array[Double], name : String) -> DstreebstSeries {
  { vals, name, meta: 0 }
}

pub fn ds_tree_bst_series_len(s : DstreebstSeries) -> Int { s.vals.length() }

pub fn ds_tree_bst_series_sum(s : DstreebstSeries) -> Double { @_common.sum(s.vals) }

pub fn ds_tree_bst_series_mean(s : DstreebstSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_tree_bst_series_min(s : DstreebstSeries) -> Double { @_common.min(s.vals) }

pub fn ds_tree_bst_series_max(s : DstreebstSeries) -> Double { @_common.max(s.vals) }

pub fn ds_tree_bst_series_range(s : DstreebstSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_tree_bst_series_var(s : DstreebstSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_tree_bst_series_std(s : DstreebstSeries) -> Double { @_common.std(s.vals) }

pub fn ds_tree_bst_series_median(s : DstreebstSeries) -> Double { @_common.median(s.vals) }

pub fn ds_tree_bst_series_scale(s : DstreebstSeries, f : Double) -> DstreebstSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_tree_bst_series_add(a : DstreebstSeries, b : DstreebstSeries) -> DstreebstSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_tree_bst_series_sub(a : DstreebstSeries, b : DstreebstSeries) -> DstreebstSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_tree_bst_series_normalize(s : DstreebstSeries) -> DstreebstSeries {
  let mn = ds_tree_bst_series_min(s)
  let mx = ds_tree_bst_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_tree_bst_series_cumsum(s : DstreebstSeries) -> DstreebstSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_tree_bst_series_to_string(s : DstreebstSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreebstMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_bst_make_matrix(rows : Int, cols : Int, val : Double) -> DstreebstMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_bst_matrix_identity(n : Int) -> DstreebstMatrix {
  let m = ds_tree_bst_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_tree_bst_matrix_get(m : DstreebstMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_tree_bst_matrix_transpose(m : DstreebstMatrix) -> DstreebstMatrix {
  let result = ds_tree_bst_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_tree_bst_matrix_add(a : DstreebstMatrix, b : DstreebstMatrix) -> DstreebstMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_tree_bst_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_tree_bst_matrix_scale(m : DstreebstMatrix, s : Double) -> DstreebstMatrix {
  let result = ds_tree_bst_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_tree_bst_matrix_multiply(a : DstreebstMatrix, b : DstreebstMatrix) -> DstreebstMatrix {
  if a.cols != b.rows { return ds_tree_bst_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_tree_bst_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_tree_bst_matrix_trace(m : DstreebstMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_tree_bst_matrix_det(m : DstreebstMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_tree_bst_matrix_norm(m : DstreebstMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_tree_bst_matrix_to_string(m : DstreebstMatrix) -> String {
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

pub(all) struct DstreebstVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_bst_make_vector(comps : Array[Double]) -> DstreebstVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_bst_vector_zero(dim : Int) -> DstreebstVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_tree_bst_vector_add(a : DstreebstVector, b : DstreebstVector) -> DstreebstVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_tree_bst_vector_sub(a : DstreebstVector, b : DstreebstVector) -> DstreebstVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_tree_bst_vector_scale(v : DstreebstVector, s : Double) -> DstreebstVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_tree_bst_vector_dot(a : DstreebstVector, b : DstreebstVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_tree_bst_vector_norm(v : DstreebstVector) -> Double { @_common.sqrt(ds_tree_bst_vector_dot(v, v)) }

pub fn ds_tree_bst_vector_normalize(v : DstreebstVector) -> DstreebstVector {
  let n = ds_tree_bst_vector_norm(v)
  if n < 0.0000001 { v } else { ds_tree_bst_vector_scale(v, 1.0 / n) }
}

pub fn ds_tree_bst_vector_dist(a : DstreebstVector, b : DstreebstVector) -> Double {
  ds_tree_bst_vector_norm(ds_tree_bst_vector_sub(a, b))
}

pub fn ds_tree_bst_vector_to_string(v : DstreebstVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_tree_bst_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_tree_bst_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_tree_bst_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_tree_bst_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_tree_bst_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_tree_bst_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_tree_bst_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_tree_bst_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_tree_bst_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_tree_bst_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_tree_bst_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_tree_bst_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_tree_bst_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_tree_bst_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_tree_bst_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_tree_bst_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_tree_bst_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_tree_bst_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_tree_bst_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_tree_bst_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_tree_bst_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_tree_bst_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_tree_bst_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_tree_bst_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_tree_bst_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_tree_bst_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_tree_bst_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_tree_bst_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_tree_bst_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DstreebstFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_frame_make(size : Int) -> DstreebstFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_frame_len(s : DstreebstFrame) -> Int { s.size }

pub fn ds_tree_bst_frame_get(s : DstreebstFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_frame_set(s : DstreebstFrame, i : Int, v : Double) -> DstreebstFrame {
  let result = ds_tree_bst_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_frame_sum(s : DstreebstFrame) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_frame_mean(s : DstreebstFrame) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_frame_scale(s : DstreebstFrame, f : Double) -> DstreebstFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_frame_add(a : DstreebstFrame, b : DstreebstFrame) -> DstreebstFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_frame_copy(s : DstreebstFrame) -> DstreebstFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_frame_fill(s : DstreebstFrame, v : Double) -> DstreebstFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_frame_min(s : DstreebstFrame) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_frame_max(s : DstreebstFrame) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_frame_to_string(s : DstreebstFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_table_make(size : Int) -> DstreebstTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_table_len(s : DstreebstTable) -> Int { s.size }

pub fn ds_tree_bst_table_get(s : DstreebstTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_table_set(s : DstreebstTable, i : Int, v : Double) -> DstreebstTable {
  let result = ds_tree_bst_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_table_sum(s : DstreebstTable) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_table_mean(s : DstreebstTable) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_table_scale(s : DstreebstTable, f : Double) -> DstreebstTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_table_add(a : DstreebstTable, b : DstreebstTable) -> DstreebstTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_table_copy(s : DstreebstTable) -> DstreebstTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_table_fill(s : DstreebstTable, v : Double) -> DstreebstTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_table_min(s : DstreebstTable) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_table_max(s : DstreebstTable) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_table_to_string(s : DstreebstTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_graphn_make(size : Int) -> DstreebstGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_graphn_len(s : DstreebstGraphN) -> Int { s.size }

pub fn ds_tree_bst_graphn_get(s : DstreebstGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_graphn_set(s : DstreebstGraphN, i : Int, v : Double) -> DstreebstGraphN {
  let result = ds_tree_bst_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_graphn_sum(s : DstreebstGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_graphn_mean(s : DstreebstGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_graphn_scale(s : DstreebstGraphN, f : Double) -> DstreebstGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_graphn_add(a : DstreebstGraphN, b : DstreebstGraphN) -> DstreebstGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_graphn_copy(s : DstreebstGraphN) -> DstreebstGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_graphn_fill(s : DstreebstGraphN, v : Double) -> DstreebstGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_graphn_min(s : DstreebstGraphN) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_graphn_max(s : DstreebstGraphN) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_graphn_to_string(s : DstreebstGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_node_make(size : Int) -> DstreebstNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_node_len(s : DstreebstNode) -> Int { s.size }

pub fn ds_tree_bst_node_get(s : DstreebstNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_node_set(s : DstreebstNode, i : Int, v : Double) -> DstreebstNode {
  let result = ds_tree_bst_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_node_sum(s : DstreebstNode) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_node_mean(s : DstreebstNode) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_node_scale(s : DstreebstNode, f : Double) -> DstreebstNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_node_add(a : DstreebstNode, b : DstreebstNode) -> DstreebstNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_node_copy(s : DstreebstNode) -> DstreebstNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_node_fill(s : DstreebstNode, v : Double) -> DstreebstNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_node_min(s : DstreebstNode) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_node_max(s : DstreebstNode) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_node_to_string(s : DstreebstNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_edge_make(size : Int) -> DstreebstEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_edge_len(s : DstreebstEdge) -> Int { s.size }

pub fn ds_tree_bst_edge_get(s : DstreebstEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_edge_set(s : DstreebstEdge, i : Int, v : Double) -> DstreebstEdge {
  let result = ds_tree_bst_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_edge_sum(s : DstreebstEdge) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_edge_mean(s : DstreebstEdge) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_edge_scale(s : DstreebstEdge, f : Double) -> DstreebstEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_edge_add(a : DstreebstEdge, b : DstreebstEdge) -> DstreebstEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_edge_copy(s : DstreebstEdge) -> DstreebstEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_edge_fill(s : DstreebstEdge, v : Double) -> DstreebstEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_edge_min(s : DstreebstEdge) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_edge_max(s : DstreebstEdge) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_edge_to_string(s : DstreebstEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_path_make(size : Int) -> DstreebstPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_path_len(s : DstreebstPath) -> Int { s.size }

pub fn ds_tree_bst_path_get(s : DstreebstPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_path_set(s : DstreebstPath, i : Int, v : Double) -> DstreebstPath {
  let result = ds_tree_bst_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_path_sum(s : DstreebstPath) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_path_mean(s : DstreebstPath) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_path_scale(s : DstreebstPath, f : Double) -> DstreebstPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_path_add(a : DstreebstPath, b : DstreebstPath) -> DstreebstPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_path_copy(s : DstreebstPath) -> DstreebstPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_path_fill(s : DstreebstPath, v : Double) -> DstreebstPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_path_min(s : DstreebstPath) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_path_max(s : DstreebstPath) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_path_to_string(s : DstreebstPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_cluster_make(size : Int) -> DstreebstCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_cluster_len(s : DstreebstCluster) -> Int { s.size }

pub fn ds_tree_bst_cluster_get(s : DstreebstCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_cluster_set(s : DstreebstCluster, i : Int, v : Double) -> DstreebstCluster {
  let result = ds_tree_bst_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_cluster_sum(s : DstreebstCluster) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_cluster_mean(s : DstreebstCluster) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_cluster_scale(s : DstreebstCluster, f : Double) -> DstreebstCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_cluster_add(a : DstreebstCluster, b : DstreebstCluster) -> DstreebstCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_cluster_copy(s : DstreebstCluster) -> DstreebstCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_cluster_fill(s : DstreebstCluster, v : Double) -> DstreebstCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_cluster_min(s : DstreebstCluster) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_cluster_max(s : DstreebstCluster) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_cluster_to_string(s : DstreebstCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_model_make(size : Int) -> DstreebstModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_model_len(s : DstreebstModel) -> Int { s.size }

pub fn ds_tree_bst_model_get(s : DstreebstModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_model_set(s : DstreebstModel, i : Int, v : Double) -> DstreebstModel {
  let result = ds_tree_bst_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_model_sum(s : DstreebstModel) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_model_mean(s : DstreebstModel) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_model_scale(s : DstreebstModel, f : Double) -> DstreebstModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_model_add(a : DstreebstModel, b : DstreebstModel) -> DstreebstModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_model_copy(s : DstreebstModel) -> DstreebstModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_model_fill(s : DstreebstModel, v : Double) -> DstreebstModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_model_min(s : DstreebstModel) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_model_max(s : DstreebstModel) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_model_to_string(s : DstreebstModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_layer_make(size : Int) -> DstreebstLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_layer_len(s : DstreebstLayer) -> Int { s.size }

pub fn ds_tree_bst_layer_get(s : DstreebstLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_layer_set(s : DstreebstLayer, i : Int, v : Double) -> DstreebstLayer {
  let result = ds_tree_bst_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_layer_sum(s : DstreebstLayer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_layer_mean(s : DstreebstLayer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_layer_scale(s : DstreebstLayer, f : Double) -> DstreebstLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_layer_add(a : DstreebstLayer, b : DstreebstLayer) -> DstreebstLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_layer_copy(s : DstreebstLayer) -> DstreebstLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_layer_fill(s : DstreebstLayer, v : Double) -> DstreebstLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_layer_min(s : DstreebstLayer) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_layer_max(s : DstreebstLayer) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_layer_to_string(s : DstreebstLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_buffer_make(size : Int) -> DstreebstBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_buffer_len(s : DstreebstBuffer) -> Int { s.size }

pub fn ds_tree_bst_buffer_get(s : DstreebstBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_buffer_set(s : DstreebstBuffer, i : Int, v : Double) -> DstreebstBuffer {
  let result = ds_tree_bst_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_buffer_sum(s : DstreebstBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_buffer_mean(s : DstreebstBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_buffer_scale(s : DstreebstBuffer, f : Double) -> DstreebstBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_buffer_add(a : DstreebstBuffer, b : DstreebstBuffer) -> DstreebstBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_buffer_copy(s : DstreebstBuffer) -> DstreebstBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_buffer_fill(s : DstreebstBuffer, v : Double) -> DstreebstBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_buffer_min(s : DstreebstBuffer) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_buffer_max(s : DstreebstBuffer) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_buffer_to_string(s : DstreebstBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_cursor_make(size : Int) -> DstreebstCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_cursor_len(s : DstreebstCursor) -> Int { s.size }

pub fn ds_tree_bst_cursor_get(s : DstreebstCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_cursor_set(s : DstreebstCursor, i : Int, v : Double) -> DstreebstCursor {
  let result = ds_tree_bst_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_cursor_sum(s : DstreebstCursor) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_cursor_mean(s : DstreebstCursor) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_cursor_scale(s : DstreebstCursor, f : Double) -> DstreebstCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_cursor_add(a : DstreebstCursor, b : DstreebstCursor) -> DstreebstCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_cursor_copy(s : DstreebstCursor) -> DstreebstCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_cursor_fill(s : DstreebstCursor, v : Double) -> DstreebstCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_cursor_min(s : DstreebstCursor) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_cursor_max(s : DstreebstCursor) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_cursor_to_string(s : DstreebstCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_view_make(size : Int) -> DstreebstView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_view_len(s : DstreebstView) -> Int { s.size }

pub fn ds_tree_bst_view_get(s : DstreebstView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_view_set(s : DstreebstView, i : Int, v : Double) -> DstreebstView {
  let result = ds_tree_bst_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_view_sum(s : DstreebstView) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_view_mean(s : DstreebstView) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_view_scale(s : DstreebstView, f : Double) -> DstreebstView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_view_add(a : DstreebstView, b : DstreebstView) -> DstreebstView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_view_copy(s : DstreebstView) -> DstreebstView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_view_fill(s : DstreebstView, v : Double) -> DstreebstView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_view_min(s : DstreebstView) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_view_max(s : DstreebstView) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_view_to_string(s : DstreebstView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_range_make(size : Int) -> DstreebstRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_range_len(s : DstreebstRange) -> Int { s.size }

pub fn ds_tree_bst_range_get(s : DstreebstRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_range_set(s : DstreebstRange, i : Int, v : Double) -> DstreebstRange {
  let result = ds_tree_bst_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_range_sum(s : DstreebstRange) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_range_mean(s : DstreebstRange) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_range_scale(s : DstreebstRange, f : Double) -> DstreebstRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_range_add(a : DstreebstRange, b : DstreebstRange) -> DstreebstRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_range_copy(s : DstreebstRange) -> DstreebstRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_range_fill(s : DstreebstRange, v : Double) -> DstreebstRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_range_min(s : DstreebstRange) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_range_max(s : DstreebstRange) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_range_to_string(s : DstreebstRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_slice_make(size : Int) -> DstreebstSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_slice_len(s : DstreebstSlice) -> Int { s.size }

pub fn ds_tree_bst_slice_get(s : DstreebstSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_slice_set(s : DstreebstSlice, i : Int, v : Double) -> DstreebstSlice {
  let result = ds_tree_bst_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_slice_sum(s : DstreebstSlice) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_slice_mean(s : DstreebstSlice) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_slice_scale(s : DstreebstSlice, f : Double) -> DstreebstSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_slice_add(a : DstreebstSlice, b : DstreebstSlice) -> DstreebstSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_slice_copy(s : DstreebstSlice) -> DstreebstSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_slice_fill(s : DstreebstSlice, v : Double) -> DstreebstSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_slice_min(s : DstreebstSlice) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_slice_max(s : DstreebstSlice) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_slice_to_string(s : DstreebstSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

