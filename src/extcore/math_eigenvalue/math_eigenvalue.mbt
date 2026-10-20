///===
/// extcore/math_eigenvalue

pub(all) struct MatheigenvaluePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_eigenvalue_make_point(x : Double, y : Double) -> MatheigenvaluePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_eigenvalue_make_point3(x : Double, y : Double, z : Double) -> MatheigenvaluePoint {
  { x, y, z, label: 0 }
}

pub fn math_eigenvalue_point_x(pt : MatheigenvaluePoint) -> Double { pt.x }

pub fn math_eigenvalue_point_y(pt : MatheigenvaluePoint) -> Double { pt.y }

pub fn math_eigenvalue_point_z(pt : MatheigenvaluePoint) -> Double { pt.z }

pub fn math_eigenvalue_point_label(pt : MatheigenvaluePoint) -> Int { pt.label }

pub fn math_eigenvalue_point_dist(a : MatheigenvaluePoint, b : MatheigenvaluePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_eigenvalue_point_add(a : MatheigenvaluePoint, b : MatheigenvaluePoint) -> MatheigenvaluePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_eigenvalue_point_sub(a : MatheigenvaluePoint, b : MatheigenvaluePoint) -> MatheigenvaluePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_eigenvalue_point_scale(pt : MatheigenvaluePoint, s : Double) -> MatheigenvaluePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_eigenvalue_point_dot(a : MatheigenvaluePoint, b : MatheigenvaluePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_eigenvalue_point_cross(a : MatheigenvaluePoint, b : MatheigenvaluePoint) -> MatheigenvaluePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_eigenvalue_point_norm(pt : MatheigenvaluePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_eigenvalue_point_normalize(pt : MatheigenvaluePoint) -> MatheigenvaluePoint {
  let n = math_eigenvalue_point_norm(pt)
  if n < 0.0000001 { pt } else { math_eigenvalue_point_scale(pt, 1.0 / n) }
}

pub fn math_eigenvalue_point_negate(pt : MatheigenvaluePoint) -> MatheigenvaluePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_eigenvalue_point_mid(a : MatheigenvaluePoint, b : MatheigenvaluePoint) -> MatheigenvaluePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_eigenvalue_point_lerp(a : MatheigenvaluePoint, b : MatheigenvaluePoint, t : Double) -> MatheigenvaluePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_eigenvalue_point_to_string(pt : MatheigenvaluePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MatheigenvalueSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_eigenvalue_make_series(vals : Array[Double], name : String) -> MatheigenvalueSeries {
  { vals, name, meta: 0 }
}

pub fn math_eigenvalue_series_len(s : MatheigenvalueSeries) -> Int { s.vals.length() }

pub fn math_eigenvalue_series_sum(s : MatheigenvalueSeries) -> Double { @_common.sum(s.vals) }

pub fn math_eigenvalue_series_mean(s : MatheigenvalueSeries) -> Double { @_common.mean(s.vals) }

pub fn math_eigenvalue_series_min(s : MatheigenvalueSeries) -> Double { @_common.min(s.vals) }

pub fn math_eigenvalue_series_max(s : MatheigenvalueSeries) -> Double { @_common.max(s.vals) }

pub fn math_eigenvalue_series_range(s : MatheigenvalueSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn math_eigenvalue_series_var(s : MatheigenvalueSeries) -> Double { @_common.variance(s.vals) }

pub fn math_eigenvalue_series_std(s : MatheigenvalueSeries) -> Double { @_common.std(s.vals) }

pub fn math_eigenvalue_series_median(s : MatheigenvalueSeries) -> Double { @_common.median(s.vals) }

pub fn math_eigenvalue_series_scale(s : MatheigenvalueSeries, f : Double) -> MatheigenvalueSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_eigenvalue_series_add(a : MatheigenvalueSeries, b : MatheigenvalueSeries) -> MatheigenvalueSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_eigenvalue_series_sub(a : MatheigenvalueSeries, b : MatheigenvalueSeries) -> MatheigenvalueSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_eigenvalue_series_normalize(s : MatheigenvalueSeries) -> MatheigenvalueSeries {
  let mn = math_eigenvalue_series_min(s)
  let mx = math_eigenvalue_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_eigenvalue_series_cumsum(s : MatheigenvalueSeries) -> MatheigenvalueSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_eigenvalue_series_to_string(s : MatheigenvalueSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MatheigenvalueMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_eigenvalue_make_matrix(rows : Int, cols : Int, val : Double) -> MatheigenvalueMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_eigenvalue_matrix_identity(n : Int) -> MatheigenvalueMatrix {
  let m = math_eigenvalue_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_eigenvalue_matrix_get(m : MatheigenvalueMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_eigenvalue_matrix_transpose(m : MatheigenvalueMatrix) -> MatheigenvalueMatrix {
  let result = math_eigenvalue_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_eigenvalue_matrix_add(a : MatheigenvalueMatrix, b : MatheigenvalueMatrix) -> MatheigenvalueMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_eigenvalue_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_eigenvalue_matrix_scale(m : MatheigenvalueMatrix, s : Double) -> MatheigenvalueMatrix {
  let result = math_eigenvalue_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_eigenvalue_matrix_multiply(a : MatheigenvalueMatrix, b : MatheigenvalueMatrix) -> MatheigenvalueMatrix {
  if a.cols != b.rows { return math_eigenvalue_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_eigenvalue_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_eigenvalue_matrix_trace(m : MatheigenvalueMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_eigenvalue_matrix_det(m : MatheigenvalueMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_eigenvalue_matrix_norm(m : MatheigenvalueMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_eigenvalue_matrix_to_string(m : MatheigenvalueMatrix) -> String {
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

pub(all) struct MatheigenvalueVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_eigenvalue_make_vector(comps : Array[Double]) -> MatheigenvalueVector {
  { comps, dim: comps.length() }
}

pub fn math_eigenvalue_vector_zero(dim : Int) -> MatheigenvalueVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_eigenvalue_vector_add(a : MatheigenvalueVector, b : MatheigenvalueVector) -> MatheigenvalueVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_eigenvalue_vector_sub(a : MatheigenvalueVector, b : MatheigenvalueVector) -> MatheigenvalueVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_eigenvalue_vector_scale(v : MatheigenvalueVector, s : Double) -> MatheigenvalueVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_eigenvalue_vector_dot(a : MatheigenvalueVector, b : MatheigenvalueVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_eigenvalue_vector_norm(v : MatheigenvalueVector) -> Double { @_common.sqrt(math_eigenvalue_vector_dot(v, v)) }

pub fn math_eigenvalue_vector_normalize(v : MatheigenvalueVector) -> MatheigenvalueVector {
  let n = math_eigenvalue_vector_norm(v)
  if n < 0.0000001 { v } else { math_eigenvalue_vector_scale(v, 1.0 / n) }
}

pub fn math_eigenvalue_vector_dist(a : MatheigenvalueVector, b : MatheigenvalueVector) -> Double {
  math_eigenvalue_vector_norm(math_eigenvalue_vector_sub(a, b))
}

pub fn math_eigenvalue_vector_to_string(v : MatheigenvalueVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_eigenvalue_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_eigenvalue_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_eigenvalue_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_eigenvalue_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_eigenvalue_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_eigenvalue_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_eigenvalue_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_eigenvalue_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_eigenvalue_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_eigenvalue_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_eigenvalue_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_eigenvalue_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_eigenvalue_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_eigenvalue_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_eigenvalue_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_eigenvalue_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_eigenvalue_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_eigenvalue_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_eigenvalue_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_eigenvalue_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_eigenvalue_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_eigenvalue_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_eigenvalue_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_eigenvalue_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_eigenvalue_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_eigenvalue_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_eigenvalue_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_eigenvalue_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_eigenvalue_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MatheigenvalueFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_frame_make(size : Int) -> MatheigenvalueFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_frame_len(s : MatheigenvalueFrame) -> Int { s.size }

pub fn math_eigenvalue_frame_get(s : MatheigenvalueFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_frame_set(s : MatheigenvalueFrame, i : Int, v : Double) -> MatheigenvalueFrame {
  let result = math_eigenvalue_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_eigenvalue_frame_sum(s : MatheigenvalueFrame) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_frame_mean(s : MatheigenvalueFrame) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_frame_scale(s : MatheigenvalueFrame, f : Double) -> MatheigenvalueFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_frame_add(a : MatheigenvalueFrame, b : MatheigenvalueFrame) -> MatheigenvalueFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_frame_copy(s : MatheigenvalueFrame) -> MatheigenvalueFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_frame_fill(s : MatheigenvalueFrame, v : Double) -> MatheigenvalueFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_frame_min(s : MatheigenvalueFrame) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_frame_max(s : MatheigenvalueFrame) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_frame_to_string(s : MatheigenvalueFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_table_make(size : Int) -> MatheigenvalueTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_table_len(s : MatheigenvalueTable) -> Int { s.size }

pub fn math_eigenvalue_table_get(s : MatheigenvalueTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_table_set(s : MatheigenvalueTable, i : Int, v : Double) -> MatheigenvalueTable {
  let result = math_eigenvalue_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_eigenvalue_table_sum(s : MatheigenvalueTable) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_table_mean(s : MatheigenvalueTable) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_table_scale(s : MatheigenvalueTable, f : Double) -> MatheigenvalueTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_table_add(a : MatheigenvalueTable, b : MatheigenvalueTable) -> MatheigenvalueTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_table_copy(s : MatheigenvalueTable) -> MatheigenvalueTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_table_fill(s : MatheigenvalueTable, v : Double) -> MatheigenvalueTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_table_min(s : MatheigenvalueTable) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_table_max(s : MatheigenvalueTable) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_table_to_string(s : MatheigenvalueTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_graphn_make(size : Int) -> MatheigenvalueGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_graphn_len(s : MatheigenvalueGraphN) -> Int { s.size }

pub fn math_eigenvalue_graphn_get(s : MatheigenvalueGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_graphn_set(s : MatheigenvalueGraphN, i : Int, v : Double) -> MatheigenvalueGraphN {
  let result = math_eigenvalue_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_eigenvalue_graphn_sum(s : MatheigenvalueGraphN) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_graphn_mean(s : MatheigenvalueGraphN) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_graphn_scale(s : MatheigenvalueGraphN, f : Double) -> MatheigenvalueGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_graphn_add(a : MatheigenvalueGraphN, b : MatheigenvalueGraphN) -> MatheigenvalueGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_graphn_copy(s : MatheigenvalueGraphN) -> MatheigenvalueGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_graphn_fill(s : MatheigenvalueGraphN, v : Double) -> MatheigenvalueGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_graphn_min(s : MatheigenvalueGraphN) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_graphn_max(s : MatheigenvalueGraphN) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_graphn_to_string(s : MatheigenvalueGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_node_make(size : Int) -> MatheigenvalueNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_node_len(s : MatheigenvalueNode) -> Int { s.size }

pub fn math_eigenvalue_node_get(s : MatheigenvalueNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_node_set(s : MatheigenvalueNode, i : Int, v : Double) -> MatheigenvalueNode {
  let result = math_eigenvalue_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_eigenvalue_node_sum(s : MatheigenvalueNode) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_node_mean(s : MatheigenvalueNode) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_node_scale(s : MatheigenvalueNode, f : Double) -> MatheigenvalueNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_node_add(a : MatheigenvalueNode, b : MatheigenvalueNode) -> MatheigenvalueNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_node_copy(s : MatheigenvalueNode) -> MatheigenvalueNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_node_fill(s : MatheigenvalueNode, v : Double) -> MatheigenvalueNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_node_min(s : MatheigenvalueNode) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_node_max(s : MatheigenvalueNode) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_node_to_string(s : MatheigenvalueNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_edge_make(size : Int) -> MatheigenvalueEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_edge_len(s : MatheigenvalueEdge) -> Int { s.size }

pub fn math_eigenvalue_edge_get(s : MatheigenvalueEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_edge_set(s : MatheigenvalueEdge, i : Int, v : Double) -> MatheigenvalueEdge {
  let result = math_eigenvalue_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_eigenvalue_edge_sum(s : MatheigenvalueEdge) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_edge_mean(s : MatheigenvalueEdge) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_edge_scale(s : MatheigenvalueEdge, f : Double) -> MatheigenvalueEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_edge_add(a : MatheigenvalueEdge, b : MatheigenvalueEdge) -> MatheigenvalueEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_edge_copy(s : MatheigenvalueEdge) -> MatheigenvalueEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_edge_fill(s : MatheigenvalueEdge, v : Double) -> MatheigenvalueEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_edge_min(s : MatheigenvalueEdge) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_edge_max(s : MatheigenvalueEdge) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_edge_to_string(s : MatheigenvalueEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvaluePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_path_make(size : Int) -> MatheigenvaluePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_path_len(s : MatheigenvaluePath) -> Int { s.size }

pub fn math_eigenvalue_path_get(s : MatheigenvaluePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_path_set(s : MatheigenvaluePath, i : Int, v : Double) -> MatheigenvaluePath {
  let result = math_eigenvalue_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_eigenvalue_path_sum(s : MatheigenvaluePath) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_path_mean(s : MatheigenvaluePath) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_path_scale(s : MatheigenvaluePath, f : Double) -> MatheigenvaluePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_path_add(a : MatheigenvaluePath, b : MatheigenvaluePath) -> MatheigenvaluePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_path_copy(s : MatheigenvaluePath) -> MatheigenvaluePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_path_fill(s : MatheigenvaluePath, v : Double) -> MatheigenvaluePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_path_min(s : MatheigenvaluePath) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_path_max(s : MatheigenvaluePath) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_path_to_string(s : MatheigenvaluePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_cluster_make(size : Int) -> MatheigenvalueCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_cluster_len(s : MatheigenvalueCluster) -> Int { s.size }

pub fn math_eigenvalue_cluster_get(s : MatheigenvalueCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_cluster_set(s : MatheigenvalueCluster, i : Int, v : Double) -> MatheigenvalueCluster {
  let result = math_eigenvalue_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_eigenvalue_cluster_sum(s : MatheigenvalueCluster) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_cluster_mean(s : MatheigenvalueCluster) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_cluster_scale(s : MatheigenvalueCluster, f : Double) -> MatheigenvalueCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_cluster_add(a : MatheigenvalueCluster, b : MatheigenvalueCluster) -> MatheigenvalueCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_cluster_copy(s : MatheigenvalueCluster) -> MatheigenvalueCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_cluster_fill(s : MatheigenvalueCluster, v : Double) -> MatheigenvalueCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_cluster_min(s : MatheigenvalueCluster) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_cluster_max(s : MatheigenvalueCluster) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_cluster_to_string(s : MatheigenvalueCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_model_make(size : Int) -> MatheigenvalueModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_model_len(s : MatheigenvalueModel) -> Int { s.size }

pub fn math_eigenvalue_model_get(s : MatheigenvalueModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_model_set(s : MatheigenvalueModel, i : Int, v : Double) -> MatheigenvalueModel {
  let result = math_eigenvalue_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_eigenvalue_model_sum(s : MatheigenvalueModel) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_model_mean(s : MatheigenvalueModel) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_model_scale(s : MatheigenvalueModel, f : Double) -> MatheigenvalueModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_model_add(a : MatheigenvalueModel, b : MatheigenvalueModel) -> MatheigenvalueModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_model_copy(s : MatheigenvalueModel) -> MatheigenvalueModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_model_fill(s : MatheigenvalueModel, v : Double) -> MatheigenvalueModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_model_min(s : MatheigenvalueModel) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_model_max(s : MatheigenvalueModel) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_model_to_string(s : MatheigenvalueModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_layer_make(size : Int) -> MatheigenvalueLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_layer_len(s : MatheigenvalueLayer) -> Int { s.size }

pub fn math_eigenvalue_layer_get(s : MatheigenvalueLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_layer_set(s : MatheigenvalueLayer, i : Int, v : Double) -> MatheigenvalueLayer {
  let result = math_eigenvalue_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_eigenvalue_layer_sum(s : MatheigenvalueLayer) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_layer_mean(s : MatheigenvalueLayer) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_layer_scale(s : MatheigenvalueLayer, f : Double) -> MatheigenvalueLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_layer_add(a : MatheigenvalueLayer, b : MatheigenvalueLayer) -> MatheigenvalueLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_layer_copy(s : MatheigenvalueLayer) -> MatheigenvalueLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_layer_fill(s : MatheigenvalueLayer, v : Double) -> MatheigenvalueLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_layer_min(s : MatheigenvalueLayer) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_layer_max(s : MatheigenvalueLayer) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_layer_to_string(s : MatheigenvalueLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_buffer_make(size : Int) -> MatheigenvalueBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_buffer_len(s : MatheigenvalueBuffer) -> Int { s.size }

pub fn math_eigenvalue_buffer_get(s : MatheigenvalueBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_buffer_set(s : MatheigenvalueBuffer, i : Int, v : Double) -> MatheigenvalueBuffer {
  let result = math_eigenvalue_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_eigenvalue_buffer_sum(s : MatheigenvalueBuffer) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_buffer_mean(s : MatheigenvalueBuffer) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_buffer_scale(s : MatheigenvalueBuffer, f : Double) -> MatheigenvalueBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_buffer_add(a : MatheigenvalueBuffer, b : MatheigenvalueBuffer) -> MatheigenvalueBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_buffer_copy(s : MatheigenvalueBuffer) -> MatheigenvalueBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_buffer_fill(s : MatheigenvalueBuffer, v : Double) -> MatheigenvalueBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_buffer_min(s : MatheigenvalueBuffer) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_buffer_max(s : MatheigenvalueBuffer) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_buffer_to_string(s : MatheigenvalueBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_cursor_make(size : Int) -> MatheigenvalueCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_cursor_len(s : MatheigenvalueCursor) -> Int { s.size }

pub fn math_eigenvalue_cursor_get(s : MatheigenvalueCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_cursor_set(s : MatheigenvalueCursor, i : Int, v : Double) -> MatheigenvalueCursor {
  let result = math_eigenvalue_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_eigenvalue_cursor_sum(s : MatheigenvalueCursor) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_cursor_mean(s : MatheigenvalueCursor) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_cursor_scale(s : MatheigenvalueCursor, f : Double) -> MatheigenvalueCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_cursor_add(a : MatheigenvalueCursor, b : MatheigenvalueCursor) -> MatheigenvalueCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_cursor_copy(s : MatheigenvalueCursor) -> MatheigenvalueCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_cursor_fill(s : MatheigenvalueCursor, v : Double) -> MatheigenvalueCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_cursor_min(s : MatheigenvalueCursor) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_cursor_max(s : MatheigenvalueCursor) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_cursor_to_string(s : MatheigenvalueCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_view_make(size : Int) -> MatheigenvalueView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_view_len(s : MatheigenvalueView) -> Int { s.size }

pub fn math_eigenvalue_view_get(s : MatheigenvalueView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_view_set(s : MatheigenvalueView, i : Int, v : Double) -> MatheigenvalueView {
  let result = math_eigenvalue_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_eigenvalue_view_sum(s : MatheigenvalueView) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_view_mean(s : MatheigenvalueView) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_view_scale(s : MatheigenvalueView, f : Double) -> MatheigenvalueView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_view_add(a : MatheigenvalueView, b : MatheigenvalueView) -> MatheigenvalueView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_view_copy(s : MatheigenvalueView) -> MatheigenvalueView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_view_fill(s : MatheigenvalueView, v : Double) -> MatheigenvalueView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_view_min(s : MatheigenvalueView) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_view_max(s : MatheigenvalueView) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_view_to_string(s : MatheigenvalueView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_range_make(size : Int) -> MatheigenvalueRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_range_len(s : MatheigenvalueRange) -> Int { s.size }

pub fn math_eigenvalue_range_get(s : MatheigenvalueRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_range_set(s : MatheigenvalueRange, i : Int, v : Double) -> MatheigenvalueRange {
  let result = math_eigenvalue_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_eigenvalue_range_sum(s : MatheigenvalueRange) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_range_mean(s : MatheigenvalueRange) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_range_scale(s : MatheigenvalueRange, f : Double) -> MatheigenvalueRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_range_add(a : MatheigenvalueRange, b : MatheigenvalueRange) -> MatheigenvalueRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_range_copy(s : MatheigenvalueRange) -> MatheigenvalueRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_range_fill(s : MatheigenvalueRange, v : Double) -> MatheigenvalueRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_range_min(s : MatheigenvalueRange) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_range_max(s : MatheigenvalueRange) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_range_to_string(s : MatheigenvalueRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_slice_make(size : Int) -> MatheigenvalueSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_slice_len(s : MatheigenvalueSlice) -> Int { s.size }

pub fn math_eigenvalue_slice_get(s : MatheigenvalueSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_slice_set(s : MatheigenvalueSlice, i : Int, v : Double) -> MatheigenvalueSlice {
  let result = math_eigenvalue_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_eigenvalue_slice_sum(s : MatheigenvalueSlice) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_slice_mean(s : MatheigenvalueSlice) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_slice_scale(s : MatheigenvalueSlice, f : Double) -> MatheigenvalueSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_slice_add(a : MatheigenvalueSlice, b : MatheigenvalueSlice) -> MatheigenvalueSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_slice_copy(s : MatheigenvalueSlice) -> MatheigenvalueSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_slice_fill(s : MatheigenvalueSlice, v : Double) -> MatheigenvalueSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_slice_min(s : MatheigenvalueSlice) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_slice_max(s : MatheigenvalueSlice) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_slice_to_string(s : MatheigenvalueSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

