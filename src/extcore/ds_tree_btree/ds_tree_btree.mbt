///===
/// extcore/ds_tree_btree

pub(all) struct DstreebtreePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_btree_make_point(x : Double, y : Double) -> DstreebtreePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_btree_make_point3(x : Double, y : Double, z : Double) -> DstreebtreePoint {
  { x, y, z, label: 0 }
}

pub fn ds_tree_btree_point_x(pt : DstreebtreePoint) -> Double { pt.x }

pub fn ds_tree_btree_point_y(pt : DstreebtreePoint) -> Double { pt.y }

pub fn ds_tree_btree_point_z(pt : DstreebtreePoint) -> Double { pt.z }

pub fn ds_tree_btree_point_label(pt : DstreebtreePoint) -> Int { pt.label }

pub fn ds_tree_btree_point_dist(a : DstreebtreePoint, b : DstreebtreePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_tree_btree_point_add(a : DstreebtreePoint, b : DstreebtreePoint) -> DstreebtreePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_tree_btree_point_sub(a : DstreebtreePoint, b : DstreebtreePoint) -> DstreebtreePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_tree_btree_point_scale(pt : DstreebtreePoint, s : Double) -> DstreebtreePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_tree_btree_point_dot(a : DstreebtreePoint, b : DstreebtreePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_tree_btree_point_cross(a : DstreebtreePoint, b : DstreebtreePoint) -> DstreebtreePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_tree_btree_point_norm(pt : DstreebtreePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_tree_btree_point_normalize(pt : DstreebtreePoint) -> DstreebtreePoint {
  let n = ds_tree_btree_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_tree_btree_point_scale(pt, 1.0 / n) }
}

pub fn ds_tree_btree_point_negate(pt : DstreebtreePoint) -> DstreebtreePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_tree_btree_point_mid(a : DstreebtreePoint, b : DstreebtreePoint) -> DstreebtreePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_tree_btree_point_lerp(a : DstreebtreePoint, b : DstreebtreePoint, t : Double) -> DstreebtreePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_tree_btree_point_to_string(pt : DstreebtreePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DstreebtreeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_btree_make_series(vals : Array[Double], name : String) -> DstreebtreeSeries {
  { vals, name, meta: 0 }
}

pub fn ds_tree_btree_series_len(s : DstreebtreeSeries) -> Int { s.vals.length() }

pub fn ds_tree_btree_series_sum(s : DstreebtreeSeries) -> Double { @_common.sum(s.vals) }

pub fn ds_tree_btree_series_mean(s : DstreebtreeSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_tree_btree_series_min(s : DstreebtreeSeries) -> Double { @_common.min(s.vals) }

pub fn ds_tree_btree_series_max(s : DstreebtreeSeries) -> Double { @_common.max(s.vals) }

pub fn ds_tree_btree_series_range(s : DstreebtreeSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_tree_btree_series_var(s : DstreebtreeSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_tree_btree_series_std(s : DstreebtreeSeries) -> Double { @_common.std(s.vals) }

pub fn ds_tree_btree_series_median(s : DstreebtreeSeries) -> Double { @_common.median(s.vals) }

pub fn ds_tree_btree_series_scale(s : DstreebtreeSeries, f : Double) -> DstreebtreeSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_tree_btree_series_add(a : DstreebtreeSeries, b : DstreebtreeSeries) -> DstreebtreeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_tree_btree_series_sub(a : DstreebtreeSeries, b : DstreebtreeSeries) -> DstreebtreeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_tree_btree_series_normalize(s : DstreebtreeSeries) -> DstreebtreeSeries {
  let mn = ds_tree_btree_series_min(s)
  let mx = ds_tree_btree_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_tree_btree_series_cumsum(s : DstreebtreeSeries) -> DstreebtreeSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_tree_btree_series_to_string(s : DstreebtreeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreebtreeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_btree_make_matrix(rows : Int, cols : Int, val : Double) -> DstreebtreeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_btree_matrix_identity(n : Int) -> DstreebtreeMatrix {
  let m = ds_tree_btree_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_tree_btree_matrix_get(m : DstreebtreeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_tree_btree_matrix_transpose(m : DstreebtreeMatrix) -> DstreebtreeMatrix {
  let result = ds_tree_btree_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_tree_btree_matrix_add(a : DstreebtreeMatrix, b : DstreebtreeMatrix) -> DstreebtreeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_tree_btree_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_tree_btree_matrix_scale(m : DstreebtreeMatrix, s : Double) -> DstreebtreeMatrix {
  let result = ds_tree_btree_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_tree_btree_matrix_multiply(a : DstreebtreeMatrix, b : DstreebtreeMatrix) -> DstreebtreeMatrix {
  if a.cols != b.rows { return ds_tree_btree_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_tree_btree_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_tree_btree_matrix_trace(m : DstreebtreeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_tree_btree_matrix_det(m : DstreebtreeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_tree_btree_matrix_norm(m : DstreebtreeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_tree_btree_matrix_to_string(m : DstreebtreeMatrix) -> String {
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

pub(all) struct DstreebtreeVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_btree_make_vector(comps : Array[Double]) -> DstreebtreeVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_btree_vector_zero(dim : Int) -> DstreebtreeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_tree_btree_vector_add(a : DstreebtreeVector, b : DstreebtreeVector) -> DstreebtreeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_tree_btree_vector_sub(a : DstreebtreeVector, b : DstreebtreeVector) -> DstreebtreeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_tree_btree_vector_scale(v : DstreebtreeVector, s : Double) -> DstreebtreeVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_tree_btree_vector_dot(a : DstreebtreeVector, b : DstreebtreeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_tree_btree_vector_norm(v : DstreebtreeVector) -> Double { @_common.sqrt(ds_tree_btree_vector_dot(v, v)) }

pub fn ds_tree_btree_vector_normalize(v : DstreebtreeVector) -> DstreebtreeVector {
  let n = ds_tree_btree_vector_norm(v)
  if n < 0.0000001 { v } else { ds_tree_btree_vector_scale(v, 1.0 / n) }
}

pub fn ds_tree_btree_vector_dist(a : DstreebtreeVector, b : DstreebtreeVector) -> Double {
  ds_tree_btree_vector_norm(ds_tree_btree_vector_sub(a, b))
}

pub fn ds_tree_btree_vector_to_string(v : DstreebtreeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_tree_btree_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_tree_btree_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_tree_btree_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_tree_btree_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_tree_btree_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_tree_btree_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_tree_btree_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_tree_btree_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_tree_btree_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_tree_btree_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_tree_btree_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_tree_btree_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_tree_btree_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_tree_btree_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_tree_btree_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_tree_btree_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_tree_btree_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_tree_btree_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_tree_btree_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_tree_btree_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_tree_btree_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_tree_btree_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_tree_btree_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_tree_btree_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_tree_btree_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_tree_btree_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_tree_btree_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_tree_btree_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_tree_btree_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DstreebtreeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_frame_make(size : Int) -> DstreebtreeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_frame_len(s : DstreebtreeFrame) -> Int { s.size }

pub fn ds_tree_btree_frame_get(s : DstreebtreeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_frame_set(s : DstreebtreeFrame, i : Int, v : Double) -> DstreebtreeFrame {
  let result = ds_tree_btree_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_frame_sum(s : DstreebtreeFrame) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_frame_mean(s : DstreebtreeFrame) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_frame_scale(s : DstreebtreeFrame, f : Double) -> DstreebtreeFrame {
  let result = ds_tree_btree_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_btree_frame_add(a : DstreebtreeFrame, b : DstreebtreeFrame) -> DstreebtreeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_btree_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_btree_frame_copy(s : DstreebtreeFrame) -> DstreebtreeFrame {
  let result = ds_tree_btree_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_btree_frame_fill(s : DstreebtreeFrame, v : Double) -> DstreebtreeFrame {
  let result = ds_tree_btree_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_frame_min(s : DstreebtreeFrame) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_frame_max(s : DstreebtreeFrame) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_frame_to_string(s : DstreebtreeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_table_make(size : Int) -> DstreebtreeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_table_len(s : DstreebtreeTable) -> Int { s.size }

pub fn ds_tree_btree_table_get(s : DstreebtreeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_table_set(s : DstreebtreeTable, i : Int, v : Double) -> DstreebtreeTable {
  let result = ds_tree_btree_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_table_sum(s : DstreebtreeTable) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_table_mean(s : DstreebtreeTable) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_table_scale(s : DstreebtreeTable, f : Double) -> DstreebtreeTable {
  let result = ds_tree_btree_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_btree_table_add(a : DstreebtreeTable, b : DstreebtreeTable) -> DstreebtreeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_btree_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_btree_table_copy(s : DstreebtreeTable) -> DstreebtreeTable {
  let result = ds_tree_btree_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_btree_table_fill(s : DstreebtreeTable, v : Double) -> DstreebtreeTable {
  let result = ds_tree_btree_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_table_min(s : DstreebtreeTable) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_table_max(s : DstreebtreeTable) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_table_to_string(s : DstreebtreeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_graphn_make(size : Int) -> DstreebtreeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_graphn_len(s : DstreebtreeGraphN) -> Int { s.size }

pub fn ds_tree_btree_graphn_get(s : DstreebtreeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_graphn_set(s : DstreebtreeGraphN, i : Int, v : Double) -> DstreebtreeGraphN {
  let result = ds_tree_btree_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_graphn_sum(s : DstreebtreeGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_graphn_mean(s : DstreebtreeGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_graphn_scale(s : DstreebtreeGraphN, f : Double) -> DstreebtreeGraphN {
  let result = ds_tree_btree_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_btree_graphn_add(a : DstreebtreeGraphN, b : DstreebtreeGraphN) -> DstreebtreeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_btree_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_btree_graphn_copy(s : DstreebtreeGraphN) -> DstreebtreeGraphN {
  let result = ds_tree_btree_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_btree_graphn_fill(s : DstreebtreeGraphN, v : Double) -> DstreebtreeGraphN {
  let result = ds_tree_btree_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_graphn_min(s : DstreebtreeGraphN) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_graphn_max(s : DstreebtreeGraphN) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_graphn_to_string(s : DstreebtreeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_node_make(size : Int) -> DstreebtreeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_node_len(s : DstreebtreeNode) -> Int { s.size }

pub fn ds_tree_btree_node_get(s : DstreebtreeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_node_set(s : DstreebtreeNode, i : Int, v : Double) -> DstreebtreeNode {
  let result = ds_tree_btree_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_node_sum(s : DstreebtreeNode) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_node_mean(s : DstreebtreeNode) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_node_scale(s : DstreebtreeNode, f : Double) -> DstreebtreeNode {
  let result = ds_tree_btree_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_btree_node_add(a : DstreebtreeNode, b : DstreebtreeNode) -> DstreebtreeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_btree_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_btree_node_copy(s : DstreebtreeNode) -> DstreebtreeNode {
  let result = ds_tree_btree_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_btree_node_fill(s : DstreebtreeNode, v : Double) -> DstreebtreeNode {
  let result = ds_tree_btree_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_node_min(s : DstreebtreeNode) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_node_max(s : DstreebtreeNode) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_node_to_string(s : DstreebtreeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_edge_make(size : Int) -> DstreebtreeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_edge_len(s : DstreebtreeEdge) -> Int { s.size }

pub fn ds_tree_btree_edge_get(s : DstreebtreeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_edge_set(s : DstreebtreeEdge, i : Int, v : Double) -> DstreebtreeEdge {
  let result = ds_tree_btree_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_edge_sum(s : DstreebtreeEdge) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_edge_mean(s : DstreebtreeEdge) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_edge_scale(s : DstreebtreeEdge, f : Double) -> DstreebtreeEdge {
  let result = ds_tree_btree_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_btree_edge_add(a : DstreebtreeEdge, b : DstreebtreeEdge) -> DstreebtreeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_btree_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_btree_edge_copy(s : DstreebtreeEdge) -> DstreebtreeEdge {
  let result = ds_tree_btree_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_btree_edge_fill(s : DstreebtreeEdge, v : Double) -> DstreebtreeEdge {
  let result = ds_tree_btree_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_edge_min(s : DstreebtreeEdge) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_edge_max(s : DstreebtreeEdge) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_edge_to_string(s : DstreebtreeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_path_make(size : Int) -> DstreebtreePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_path_len(s : DstreebtreePath) -> Int { s.size }

pub fn ds_tree_btree_path_get(s : DstreebtreePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_path_set(s : DstreebtreePath, i : Int, v : Double) -> DstreebtreePath {
  let result = ds_tree_btree_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_path_sum(s : DstreebtreePath) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_path_mean(s : DstreebtreePath) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_path_scale(s : DstreebtreePath, f : Double) -> DstreebtreePath {
  let result = ds_tree_btree_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_btree_path_add(a : DstreebtreePath, b : DstreebtreePath) -> DstreebtreePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_btree_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_btree_path_copy(s : DstreebtreePath) -> DstreebtreePath {
  let result = ds_tree_btree_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_btree_path_fill(s : DstreebtreePath, v : Double) -> DstreebtreePath {
  let result = ds_tree_btree_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_path_min(s : DstreebtreePath) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_path_max(s : DstreebtreePath) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_path_to_string(s : DstreebtreePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_cluster_make(size : Int) -> DstreebtreeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_cluster_len(s : DstreebtreeCluster) -> Int { s.size }

pub fn ds_tree_btree_cluster_get(s : DstreebtreeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_cluster_set(s : DstreebtreeCluster, i : Int, v : Double) -> DstreebtreeCluster {
  let result = ds_tree_btree_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_cluster_sum(s : DstreebtreeCluster) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_cluster_mean(s : DstreebtreeCluster) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_cluster_scale(s : DstreebtreeCluster, f : Double) -> DstreebtreeCluster {
  let result = ds_tree_btree_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_btree_cluster_add(a : DstreebtreeCluster, b : DstreebtreeCluster) -> DstreebtreeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_btree_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_btree_cluster_copy(s : DstreebtreeCluster) -> DstreebtreeCluster {
  let result = ds_tree_btree_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_btree_cluster_fill(s : DstreebtreeCluster, v : Double) -> DstreebtreeCluster {
  let result = ds_tree_btree_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_cluster_min(s : DstreebtreeCluster) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_cluster_max(s : DstreebtreeCluster) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_cluster_to_string(s : DstreebtreeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_model_make(size : Int) -> DstreebtreeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_model_len(s : DstreebtreeModel) -> Int { s.size }

pub fn ds_tree_btree_model_get(s : DstreebtreeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_model_set(s : DstreebtreeModel, i : Int, v : Double) -> DstreebtreeModel {
  let result = ds_tree_btree_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_model_sum(s : DstreebtreeModel) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_model_mean(s : DstreebtreeModel) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_model_scale(s : DstreebtreeModel, f : Double) -> DstreebtreeModel {
  let result = ds_tree_btree_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_btree_model_add(a : DstreebtreeModel, b : DstreebtreeModel) -> DstreebtreeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_btree_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_btree_model_copy(s : DstreebtreeModel) -> DstreebtreeModel {
  let result = ds_tree_btree_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_btree_model_fill(s : DstreebtreeModel, v : Double) -> DstreebtreeModel {
  let result = ds_tree_btree_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_model_min(s : DstreebtreeModel) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_model_max(s : DstreebtreeModel) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_model_to_string(s : DstreebtreeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_layer_make(size : Int) -> DstreebtreeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_layer_len(s : DstreebtreeLayer) -> Int { s.size }

pub fn ds_tree_btree_layer_get(s : DstreebtreeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_layer_set(s : DstreebtreeLayer, i : Int, v : Double) -> DstreebtreeLayer {
  let result = ds_tree_btree_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_layer_sum(s : DstreebtreeLayer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_layer_mean(s : DstreebtreeLayer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_layer_scale(s : DstreebtreeLayer, f : Double) -> DstreebtreeLayer {
  let result = ds_tree_btree_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_btree_layer_add(a : DstreebtreeLayer, b : DstreebtreeLayer) -> DstreebtreeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_btree_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_btree_layer_copy(s : DstreebtreeLayer) -> DstreebtreeLayer {
  let result = ds_tree_btree_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_btree_layer_fill(s : DstreebtreeLayer, v : Double) -> DstreebtreeLayer {
  let result = ds_tree_btree_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_layer_min(s : DstreebtreeLayer) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_layer_max(s : DstreebtreeLayer) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_layer_to_string(s : DstreebtreeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_buffer_make(size : Int) -> DstreebtreeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_buffer_len(s : DstreebtreeBuffer) -> Int { s.size }

pub fn ds_tree_btree_buffer_get(s : DstreebtreeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_buffer_set(s : DstreebtreeBuffer, i : Int, v : Double) -> DstreebtreeBuffer {
  let result = ds_tree_btree_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_buffer_sum(s : DstreebtreeBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_buffer_mean(s : DstreebtreeBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_buffer_scale(s : DstreebtreeBuffer, f : Double) -> DstreebtreeBuffer {
  let result = ds_tree_btree_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_btree_buffer_add(a : DstreebtreeBuffer, b : DstreebtreeBuffer) -> DstreebtreeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_btree_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_btree_buffer_copy(s : DstreebtreeBuffer) -> DstreebtreeBuffer {
  let result = ds_tree_btree_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_btree_buffer_fill(s : DstreebtreeBuffer, v : Double) -> DstreebtreeBuffer {
  let result = ds_tree_btree_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_buffer_min(s : DstreebtreeBuffer) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_buffer_max(s : DstreebtreeBuffer) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_buffer_to_string(s : DstreebtreeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_cursor_make(size : Int) -> DstreebtreeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_cursor_len(s : DstreebtreeCursor) -> Int { s.size }

pub fn ds_tree_btree_cursor_get(s : DstreebtreeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_cursor_set(s : DstreebtreeCursor, i : Int, v : Double) -> DstreebtreeCursor {
  let result = ds_tree_btree_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_cursor_sum(s : DstreebtreeCursor) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_cursor_mean(s : DstreebtreeCursor) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_cursor_scale(s : DstreebtreeCursor, f : Double) -> DstreebtreeCursor {
  let result = ds_tree_btree_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_btree_cursor_add(a : DstreebtreeCursor, b : DstreebtreeCursor) -> DstreebtreeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_btree_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_btree_cursor_copy(s : DstreebtreeCursor) -> DstreebtreeCursor {
  let result = ds_tree_btree_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_btree_cursor_fill(s : DstreebtreeCursor, v : Double) -> DstreebtreeCursor {
  let result = ds_tree_btree_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_cursor_min(s : DstreebtreeCursor) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_cursor_max(s : DstreebtreeCursor) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_cursor_to_string(s : DstreebtreeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_view_make(size : Int) -> DstreebtreeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_view_len(s : DstreebtreeView) -> Int { s.size }

pub fn ds_tree_btree_view_get(s : DstreebtreeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_view_set(s : DstreebtreeView, i : Int, v : Double) -> DstreebtreeView {
  let result = ds_tree_btree_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_view_sum(s : DstreebtreeView) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_view_mean(s : DstreebtreeView) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_view_scale(s : DstreebtreeView, f : Double) -> DstreebtreeView {
  let result = ds_tree_btree_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_btree_view_add(a : DstreebtreeView, b : DstreebtreeView) -> DstreebtreeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_btree_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_btree_view_copy(s : DstreebtreeView) -> DstreebtreeView {
  let result = ds_tree_btree_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_btree_view_fill(s : DstreebtreeView, v : Double) -> DstreebtreeView {
  let result = ds_tree_btree_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_view_min(s : DstreebtreeView) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_view_max(s : DstreebtreeView) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_view_to_string(s : DstreebtreeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_range_make(size : Int) -> DstreebtreeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_range_len(s : DstreebtreeRange) -> Int { s.size }

pub fn ds_tree_btree_range_get(s : DstreebtreeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_range_set(s : DstreebtreeRange, i : Int, v : Double) -> DstreebtreeRange {
  let result = ds_tree_btree_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_range_sum(s : DstreebtreeRange) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_range_mean(s : DstreebtreeRange) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_range_scale(s : DstreebtreeRange, f : Double) -> DstreebtreeRange {
  let result = ds_tree_btree_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_btree_range_add(a : DstreebtreeRange, b : DstreebtreeRange) -> DstreebtreeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_btree_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_btree_range_copy(s : DstreebtreeRange) -> DstreebtreeRange {
  let result = ds_tree_btree_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_btree_range_fill(s : DstreebtreeRange, v : Double) -> DstreebtreeRange {
  let result = ds_tree_btree_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_range_min(s : DstreebtreeRange) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_range_max(s : DstreebtreeRange) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_range_to_string(s : DstreebtreeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_slice_make(size : Int) -> DstreebtreeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_slice_len(s : DstreebtreeSlice) -> Int { s.size }

pub fn ds_tree_btree_slice_get(s : DstreebtreeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_slice_set(s : DstreebtreeSlice, i : Int, v : Double) -> DstreebtreeSlice {
  let result = ds_tree_btree_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_slice_sum(s : DstreebtreeSlice) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_slice_mean(s : DstreebtreeSlice) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_slice_scale(s : DstreebtreeSlice, f : Double) -> DstreebtreeSlice {
  let result = ds_tree_btree_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_btree_slice_add(a : DstreebtreeSlice, b : DstreebtreeSlice) -> DstreebtreeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_btree_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_btree_slice_copy(s : DstreebtreeSlice) -> DstreebtreeSlice {
  let result = ds_tree_btree_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_btree_slice_fill(s : DstreebtreeSlice, v : Double) -> DstreebtreeSlice {
  let result = ds_tree_btree_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_btree_slice_min(s : DstreebtreeSlice) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_slice_max(s : DstreebtreeSlice) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_slice_to_string(s : DstreebtreeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

