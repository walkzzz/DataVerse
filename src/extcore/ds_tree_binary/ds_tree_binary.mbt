///===
/// extcore/ds_tree_binary

pub(all) struct DstreebinaryPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_binary_make_point(x : Double, y : Double) -> DstreebinaryPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_binary_make_point3(x : Double, y : Double, z : Double) -> DstreebinaryPoint {
  { x, y, z, label: 0 }
}

pub fn ds_tree_binary_point_x(pt : DstreebinaryPoint) -> Double { pt.x }

pub fn ds_tree_binary_point_y(pt : DstreebinaryPoint) -> Double { pt.y }

pub fn ds_tree_binary_point_z(pt : DstreebinaryPoint) -> Double { pt.z }

pub fn ds_tree_binary_point_label(pt : DstreebinaryPoint) -> Int { pt.label }

pub fn ds_tree_binary_point_dist(a : DstreebinaryPoint, b : DstreebinaryPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_tree_binary_point_add(a : DstreebinaryPoint, b : DstreebinaryPoint) -> DstreebinaryPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_tree_binary_point_sub(a : DstreebinaryPoint, b : DstreebinaryPoint) -> DstreebinaryPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_tree_binary_point_scale(pt : DstreebinaryPoint, s : Double) -> DstreebinaryPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_tree_binary_point_dot(a : DstreebinaryPoint, b : DstreebinaryPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_tree_binary_point_cross(a : DstreebinaryPoint, b : DstreebinaryPoint) -> DstreebinaryPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_tree_binary_point_norm(pt : DstreebinaryPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_tree_binary_point_normalize(pt : DstreebinaryPoint) -> DstreebinaryPoint {
  let n = ds_tree_binary_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_tree_binary_point_scale(pt, 1.0 / n) }
}

pub fn ds_tree_binary_point_negate(pt : DstreebinaryPoint) -> DstreebinaryPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_tree_binary_point_mid(a : DstreebinaryPoint, b : DstreebinaryPoint) -> DstreebinaryPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_tree_binary_point_lerp(a : DstreebinaryPoint, b : DstreebinaryPoint, t : Double) -> DstreebinaryPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_tree_binary_point_to_string(pt : DstreebinaryPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DstreebinarySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_binary_make_series(vals : Array[Double], name : String) -> DstreebinarySeries {
  { vals, name, meta: 0 }
}

pub fn ds_tree_binary_series_len(s : DstreebinarySeries) -> Int { s.vals.length() }

pub fn ds_tree_binary_series_sum(s : DstreebinarySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_tree_binary_series_mean(s : DstreebinarySeries) -> Double { @_common.mean(s.vals) }

pub fn ds_tree_binary_series_min(s : DstreebinarySeries) -> Double { @_common.min(s.vals) }

pub fn ds_tree_binary_series_max(s : DstreebinarySeries) -> Double { @_common.max(s.vals) }

pub fn ds_tree_binary_series_range(s : DstreebinarySeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_tree_binary_series_var(s : DstreebinarySeries) -> Double { @_common.variance(s.vals) }

pub fn ds_tree_binary_series_std(s : DstreebinarySeries) -> Double { @_common.std(s.vals) }

pub fn ds_tree_binary_series_median(s : DstreebinarySeries) -> Double { @_common.median(s.vals) }

pub fn ds_tree_binary_series_scale(s : DstreebinarySeries, f : Double) -> DstreebinarySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_tree_binary_series_add(a : DstreebinarySeries, b : DstreebinarySeries) -> DstreebinarySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_tree_binary_series_sub(a : DstreebinarySeries, b : DstreebinarySeries) -> DstreebinarySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_tree_binary_series_normalize(s : DstreebinarySeries) -> DstreebinarySeries {
  let mn = ds_tree_binary_series_min(s)
  let mx = ds_tree_binary_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_tree_binary_series_cumsum(s : DstreebinarySeries) -> DstreebinarySeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_tree_binary_series_to_string(s : DstreebinarySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreebinaryMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_binary_make_matrix(rows : Int, cols : Int, val : Double) -> DstreebinaryMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_binary_matrix_identity(n : Int) -> DstreebinaryMatrix {
  let m = ds_tree_binary_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_tree_binary_matrix_get(m : DstreebinaryMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_tree_binary_matrix_transpose(m : DstreebinaryMatrix) -> DstreebinaryMatrix {
  let result = ds_tree_binary_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_tree_binary_matrix_add(a : DstreebinaryMatrix, b : DstreebinaryMatrix) -> DstreebinaryMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_tree_binary_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_tree_binary_matrix_scale(m : DstreebinaryMatrix, s : Double) -> DstreebinaryMatrix {
  let result = ds_tree_binary_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_tree_binary_matrix_multiply(a : DstreebinaryMatrix, b : DstreebinaryMatrix) -> DstreebinaryMatrix {
  if a.cols != b.rows { return ds_tree_binary_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_tree_binary_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_tree_binary_matrix_trace(m : DstreebinaryMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_tree_binary_matrix_det(m : DstreebinaryMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_tree_binary_matrix_norm(m : DstreebinaryMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_tree_binary_matrix_to_string(m : DstreebinaryMatrix) -> String {
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

pub(all) struct DstreebinaryVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_binary_make_vector(comps : Array[Double]) -> DstreebinaryVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_binary_vector_zero(dim : Int) -> DstreebinaryVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_tree_binary_vector_add(a : DstreebinaryVector, b : DstreebinaryVector) -> DstreebinaryVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_tree_binary_vector_sub(a : DstreebinaryVector, b : DstreebinaryVector) -> DstreebinaryVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_tree_binary_vector_scale(v : DstreebinaryVector, s : Double) -> DstreebinaryVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_tree_binary_vector_dot(a : DstreebinaryVector, b : DstreebinaryVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_tree_binary_vector_norm(v : DstreebinaryVector) -> Double { @_common.sqrt(ds_tree_binary_vector_dot(v, v)) }

pub fn ds_tree_binary_vector_normalize(v : DstreebinaryVector) -> DstreebinaryVector {
  let n = ds_tree_binary_vector_norm(v)
  if n < 0.0000001 { v } else { ds_tree_binary_vector_scale(v, 1.0 / n) }
}

pub fn ds_tree_binary_vector_dist(a : DstreebinaryVector, b : DstreebinaryVector) -> Double {
  ds_tree_binary_vector_norm(ds_tree_binary_vector_sub(a, b))
}

pub fn ds_tree_binary_vector_to_string(v : DstreebinaryVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_tree_binary_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_tree_binary_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_tree_binary_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_tree_binary_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_tree_binary_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_tree_binary_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_tree_binary_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_tree_binary_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_tree_binary_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_tree_binary_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_tree_binary_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_tree_binary_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_tree_binary_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_tree_binary_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_tree_binary_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_tree_binary_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_tree_binary_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_tree_binary_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_tree_binary_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_tree_binary_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_tree_binary_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_tree_binary_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_tree_binary_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_tree_binary_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_tree_binary_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_tree_binary_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_tree_binary_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_tree_binary_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_tree_binary_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DstreebinaryFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_frame_make(size : Int) -> DstreebinaryFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_frame_len(s : DstreebinaryFrame) -> Int { s.size }

pub fn ds_tree_binary_frame_get(s : DstreebinaryFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_frame_set(s : DstreebinaryFrame, i : Int, v : Double) -> DstreebinaryFrame {
  let result = ds_tree_binary_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_frame_sum(s : DstreebinaryFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_binary_frame_mean(s : DstreebinaryFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_binary_frame_sum(s) / s.size.to_double() }
}

pub fn ds_tree_binary_frame_scale(s : DstreebinaryFrame, f : Double) -> DstreebinaryFrame {
  let result = ds_tree_binary_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_binary_frame_add(a : DstreebinaryFrame, b : DstreebinaryFrame) -> DstreebinaryFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_binary_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_binary_frame_copy(s : DstreebinaryFrame) -> DstreebinaryFrame {
  let result = ds_tree_binary_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_binary_frame_fill(s : DstreebinaryFrame, v : Double) -> DstreebinaryFrame {
  let result = ds_tree_binary_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_frame_min(s : DstreebinaryFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_frame_max(s : DstreebinaryFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_frame_to_string(s : DstreebinaryFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinaryTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_table_make(size : Int) -> DstreebinaryTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_table_len(s : DstreebinaryTable) -> Int { s.size }

pub fn ds_tree_binary_table_get(s : DstreebinaryTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_table_set(s : DstreebinaryTable, i : Int, v : Double) -> DstreebinaryTable {
  let result = ds_tree_binary_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_table_sum(s : DstreebinaryTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_binary_table_mean(s : DstreebinaryTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_binary_table_sum(s) / s.size.to_double() }
}

pub fn ds_tree_binary_table_scale(s : DstreebinaryTable, f : Double) -> DstreebinaryTable {
  let result = ds_tree_binary_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_binary_table_add(a : DstreebinaryTable, b : DstreebinaryTable) -> DstreebinaryTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_binary_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_binary_table_copy(s : DstreebinaryTable) -> DstreebinaryTable {
  let result = ds_tree_binary_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_binary_table_fill(s : DstreebinaryTable, v : Double) -> DstreebinaryTable {
  let result = ds_tree_binary_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_table_min(s : DstreebinaryTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_table_max(s : DstreebinaryTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_table_to_string(s : DstreebinaryTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinaryGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_graphn_make(size : Int) -> DstreebinaryGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_graphn_len(s : DstreebinaryGraphN) -> Int { s.size }

pub fn ds_tree_binary_graphn_get(s : DstreebinaryGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_graphn_set(s : DstreebinaryGraphN, i : Int, v : Double) -> DstreebinaryGraphN {
  let result = ds_tree_binary_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_graphn_sum(s : DstreebinaryGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_binary_graphn_mean(s : DstreebinaryGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_binary_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_tree_binary_graphn_scale(s : DstreebinaryGraphN, f : Double) -> DstreebinaryGraphN {
  let result = ds_tree_binary_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_binary_graphn_add(a : DstreebinaryGraphN, b : DstreebinaryGraphN) -> DstreebinaryGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_binary_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_binary_graphn_copy(s : DstreebinaryGraphN) -> DstreebinaryGraphN {
  let result = ds_tree_binary_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_binary_graphn_fill(s : DstreebinaryGraphN, v : Double) -> DstreebinaryGraphN {
  let result = ds_tree_binary_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_graphn_min(s : DstreebinaryGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_graphn_max(s : DstreebinaryGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_graphn_to_string(s : DstreebinaryGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinaryNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_node_make(size : Int) -> DstreebinaryNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_node_len(s : DstreebinaryNode) -> Int { s.size }

pub fn ds_tree_binary_node_get(s : DstreebinaryNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_node_set(s : DstreebinaryNode, i : Int, v : Double) -> DstreebinaryNode {
  let result = ds_tree_binary_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_node_sum(s : DstreebinaryNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_binary_node_mean(s : DstreebinaryNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_binary_node_sum(s) / s.size.to_double() }
}

pub fn ds_tree_binary_node_scale(s : DstreebinaryNode, f : Double) -> DstreebinaryNode {
  let result = ds_tree_binary_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_binary_node_add(a : DstreebinaryNode, b : DstreebinaryNode) -> DstreebinaryNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_binary_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_binary_node_copy(s : DstreebinaryNode) -> DstreebinaryNode {
  let result = ds_tree_binary_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_binary_node_fill(s : DstreebinaryNode, v : Double) -> DstreebinaryNode {
  let result = ds_tree_binary_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_node_min(s : DstreebinaryNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_node_max(s : DstreebinaryNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_node_to_string(s : DstreebinaryNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinaryEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_edge_make(size : Int) -> DstreebinaryEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_edge_len(s : DstreebinaryEdge) -> Int { s.size }

pub fn ds_tree_binary_edge_get(s : DstreebinaryEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_edge_set(s : DstreebinaryEdge, i : Int, v : Double) -> DstreebinaryEdge {
  let result = ds_tree_binary_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_edge_sum(s : DstreebinaryEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_binary_edge_mean(s : DstreebinaryEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_binary_edge_sum(s) / s.size.to_double() }
}

pub fn ds_tree_binary_edge_scale(s : DstreebinaryEdge, f : Double) -> DstreebinaryEdge {
  let result = ds_tree_binary_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_binary_edge_add(a : DstreebinaryEdge, b : DstreebinaryEdge) -> DstreebinaryEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_binary_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_binary_edge_copy(s : DstreebinaryEdge) -> DstreebinaryEdge {
  let result = ds_tree_binary_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_binary_edge_fill(s : DstreebinaryEdge, v : Double) -> DstreebinaryEdge {
  let result = ds_tree_binary_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_edge_min(s : DstreebinaryEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_edge_max(s : DstreebinaryEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_edge_to_string(s : DstreebinaryEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinaryPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_path_make(size : Int) -> DstreebinaryPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_path_len(s : DstreebinaryPath) -> Int { s.size }

pub fn ds_tree_binary_path_get(s : DstreebinaryPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_path_set(s : DstreebinaryPath, i : Int, v : Double) -> DstreebinaryPath {
  let result = ds_tree_binary_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_path_sum(s : DstreebinaryPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_binary_path_mean(s : DstreebinaryPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_binary_path_sum(s) / s.size.to_double() }
}

pub fn ds_tree_binary_path_scale(s : DstreebinaryPath, f : Double) -> DstreebinaryPath {
  let result = ds_tree_binary_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_binary_path_add(a : DstreebinaryPath, b : DstreebinaryPath) -> DstreebinaryPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_binary_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_binary_path_copy(s : DstreebinaryPath) -> DstreebinaryPath {
  let result = ds_tree_binary_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_binary_path_fill(s : DstreebinaryPath, v : Double) -> DstreebinaryPath {
  let result = ds_tree_binary_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_path_min(s : DstreebinaryPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_path_max(s : DstreebinaryPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_path_to_string(s : DstreebinaryPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinaryCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_cluster_make(size : Int) -> DstreebinaryCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_cluster_len(s : DstreebinaryCluster) -> Int { s.size }

pub fn ds_tree_binary_cluster_get(s : DstreebinaryCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_cluster_set(s : DstreebinaryCluster, i : Int, v : Double) -> DstreebinaryCluster {
  let result = ds_tree_binary_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_cluster_sum(s : DstreebinaryCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_binary_cluster_mean(s : DstreebinaryCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_binary_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_tree_binary_cluster_scale(s : DstreebinaryCluster, f : Double) -> DstreebinaryCluster {
  let result = ds_tree_binary_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_binary_cluster_add(a : DstreebinaryCluster, b : DstreebinaryCluster) -> DstreebinaryCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_binary_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_binary_cluster_copy(s : DstreebinaryCluster) -> DstreebinaryCluster {
  let result = ds_tree_binary_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_binary_cluster_fill(s : DstreebinaryCluster, v : Double) -> DstreebinaryCluster {
  let result = ds_tree_binary_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_cluster_min(s : DstreebinaryCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_cluster_max(s : DstreebinaryCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_cluster_to_string(s : DstreebinaryCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinaryModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_model_make(size : Int) -> DstreebinaryModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_model_len(s : DstreebinaryModel) -> Int { s.size }

pub fn ds_tree_binary_model_get(s : DstreebinaryModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_model_set(s : DstreebinaryModel, i : Int, v : Double) -> DstreebinaryModel {
  let result = ds_tree_binary_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_model_sum(s : DstreebinaryModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_binary_model_mean(s : DstreebinaryModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_binary_model_sum(s) / s.size.to_double() }
}

pub fn ds_tree_binary_model_scale(s : DstreebinaryModel, f : Double) -> DstreebinaryModel {
  let result = ds_tree_binary_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_binary_model_add(a : DstreebinaryModel, b : DstreebinaryModel) -> DstreebinaryModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_binary_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_binary_model_copy(s : DstreebinaryModel) -> DstreebinaryModel {
  let result = ds_tree_binary_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_binary_model_fill(s : DstreebinaryModel, v : Double) -> DstreebinaryModel {
  let result = ds_tree_binary_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_model_min(s : DstreebinaryModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_model_max(s : DstreebinaryModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_model_to_string(s : DstreebinaryModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinaryLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_layer_make(size : Int) -> DstreebinaryLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_layer_len(s : DstreebinaryLayer) -> Int { s.size }

pub fn ds_tree_binary_layer_get(s : DstreebinaryLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_layer_set(s : DstreebinaryLayer, i : Int, v : Double) -> DstreebinaryLayer {
  let result = ds_tree_binary_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_layer_sum(s : DstreebinaryLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_binary_layer_mean(s : DstreebinaryLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_binary_layer_sum(s) / s.size.to_double() }
}

pub fn ds_tree_binary_layer_scale(s : DstreebinaryLayer, f : Double) -> DstreebinaryLayer {
  let result = ds_tree_binary_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_binary_layer_add(a : DstreebinaryLayer, b : DstreebinaryLayer) -> DstreebinaryLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_binary_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_binary_layer_copy(s : DstreebinaryLayer) -> DstreebinaryLayer {
  let result = ds_tree_binary_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_binary_layer_fill(s : DstreebinaryLayer, v : Double) -> DstreebinaryLayer {
  let result = ds_tree_binary_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_layer_min(s : DstreebinaryLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_layer_max(s : DstreebinaryLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_layer_to_string(s : DstreebinaryLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinaryBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_buffer_make(size : Int) -> DstreebinaryBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_buffer_len(s : DstreebinaryBuffer) -> Int { s.size }

pub fn ds_tree_binary_buffer_get(s : DstreebinaryBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_buffer_set(s : DstreebinaryBuffer, i : Int, v : Double) -> DstreebinaryBuffer {
  let result = ds_tree_binary_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_buffer_sum(s : DstreebinaryBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_binary_buffer_mean(s : DstreebinaryBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_binary_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_tree_binary_buffer_scale(s : DstreebinaryBuffer, f : Double) -> DstreebinaryBuffer {
  let result = ds_tree_binary_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_binary_buffer_add(a : DstreebinaryBuffer, b : DstreebinaryBuffer) -> DstreebinaryBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_binary_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_binary_buffer_copy(s : DstreebinaryBuffer) -> DstreebinaryBuffer {
  let result = ds_tree_binary_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_binary_buffer_fill(s : DstreebinaryBuffer, v : Double) -> DstreebinaryBuffer {
  let result = ds_tree_binary_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_buffer_min(s : DstreebinaryBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_buffer_max(s : DstreebinaryBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_buffer_to_string(s : DstreebinaryBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinaryCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_cursor_make(size : Int) -> DstreebinaryCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_cursor_len(s : DstreebinaryCursor) -> Int { s.size }

pub fn ds_tree_binary_cursor_get(s : DstreebinaryCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_cursor_set(s : DstreebinaryCursor, i : Int, v : Double) -> DstreebinaryCursor {
  let result = ds_tree_binary_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_cursor_sum(s : DstreebinaryCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_binary_cursor_mean(s : DstreebinaryCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_binary_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_tree_binary_cursor_scale(s : DstreebinaryCursor, f : Double) -> DstreebinaryCursor {
  let result = ds_tree_binary_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_binary_cursor_add(a : DstreebinaryCursor, b : DstreebinaryCursor) -> DstreebinaryCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_binary_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_binary_cursor_copy(s : DstreebinaryCursor) -> DstreebinaryCursor {
  let result = ds_tree_binary_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_binary_cursor_fill(s : DstreebinaryCursor, v : Double) -> DstreebinaryCursor {
  let result = ds_tree_binary_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_cursor_min(s : DstreebinaryCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_cursor_max(s : DstreebinaryCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_cursor_to_string(s : DstreebinaryCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinaryView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_view_make(size : Int) -> DstreebinaryView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_view_len(s : DstreebinaryView) -> Int { s.size }

pub fn ds_tree_binary_view_get(s : DstreebinaryView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_view_set(s : DstreebinaryView, i : Int, v : Double) -> DstreebinaryView {
  let result = ds_tree_binary_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_view_sum(s : DstreebinaryView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_binary_view_mean(s : DstreebinaryView) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_binary_view_sum(s) / s.size.to_double() }
}

pub fn ds_tree_binary_view_scale(s : DstreebinaryView, f : Double) -> DstreebinaryView {
  let result = ds_tree_binary_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_binary_view_add(a : DstreebinaryView, b : DstreebinaryView) -> DstreebinaryView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_binary_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_binary_view_copy(s : DstreebinaryView) -> DstreebinaryView {
  let result = ds_tree_binary_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_binary_view_fill(s : DstreebinaryView, v : Double) -> DstreebinaryView {
  let result = ds_tree_binary_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_view_min(s : DstreebinaryView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_view_max(s : DstreebinaryView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_view_to_string(s : DstreebinaryView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinaryRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_range_make(size : Int) -> DstreebinaryRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_range_len(s : DstreebinaryRange) -> Int { s.size }

pub fn ds_tree_binary_range_get(s : DstreebinaryRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_range_set(s : DstreebinaryRange, i : Int, v : Double) -> DstreebinaryRange {
  let result = ds_tree_binary_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_range_sum(s : DstreebinaryRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_binary_range_mean(s : DstreebinaryRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_binary_range_sum(s) / s.size.to_double() }
}

pub fn ds_tree_binary_range_scale(s : DstreebinaryRange, f : Double) -> DstreebinaryRange {
  let result = ds_tree_binary_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_binary_range_add(a : DstreebinaryRange, b : DstreebinaryRange) -> DstreebinaryRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_binary_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_binary_range_copy(s : DstreebinaryRange) -> DstreebinaryRange {
  let result = ds_tree_binary_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_binary_range_fill(s : DstreebinaryRange, v : Double) -> DstreebinaryRange {
  let result = ds_tree_binary_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_range_min(s : DstreebinaryRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_range_max(s : DstreebinaryRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_range_to_string(s : DstreebinaryRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinarySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_slice_make(size : Int) -> DstreebinarySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_slice_len(s : DstreebinarySlice) -> Int { s.size }

pub fn ds_tree_binary_slice_get(s : DstreebinarySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_slice_set(s : DstreebinarySlice, i : Int, v : Double) -> DstreebinarySlice {
  let result = ds_tree_binary_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_slice_sum(s : DstreebinarySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_binary_slice_mean(s : DstreebinarySlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_binary_slice_sum(s) / s.size.to_double() }
}

pub fn ds_tree_binary_slice_scale(s : DstreebinarySlice, f : Double) -> DstreebinarySlice {
  let result = ds_tree_binary_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_binary_slice_add(a : DstreebinarySlice, b : DstreebinarySlice) -> DstreebinarySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_binary_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_binary_slice_copy(s : DstreebinarySlice) -> DstreebinarySlice {
  let result = ds_tree_binary_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_binary_slice_fill(s : DstreebinarySlice, v : Double) -> DstreebinarySlice {
  let result = ds_tree_binary_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_binary_slice_min(s : DstreebinarySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_slice_max(s : DstreebinarySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_binary_slice_to_string(s : DstreebinarySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

