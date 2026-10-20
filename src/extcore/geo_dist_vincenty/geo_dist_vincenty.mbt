///===
/// extcore/geo_dist_vincenty

pub(all) struct GeodistvincentyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_vincenty_make_point(x : Double, y : Double) -> GeodistvincentyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_vincenty_make_point3(x : Double, y : Double, z : Double) -> GeodistvincentyPoint {
  { x, y, z, label: 0 }
}

pub fn geo_dist_vincenty_point_x(pt : GeodistvincentyPoint) -> Double { pt.x }

pub fn geo_dist_vincenty_point_y(pt : GeodistvincentyPoint) -> Double { pt.y }

pub fn geo_dist_vincenty_point_z(pt : GeodistvincentyPoint) -> Double { pt.z }

pub fn geo_dist_vincenty_point_label(pt : GeodistvincentyPoint) -> Int { pt.label }

pub fn geo_dist_vincenty_point_dist(a : GeodistvincentyPoint, b : GeodistvincentyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_dist_vincenty_point_add(a : GeodistvincentyPoint, b : GeodistvincentyPoint) -> GeodistvincentyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_dist_vincenty_point_sub(a : GeodistvincentyPoint, b : GeodistvincentyPoint) -> GeodistvincentyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_dist_vincenty_point_scale(pt : GeodistvincentyPoint, s : Double) -> GeodistvincentyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_dist_vincenty_point_dot(a : GeodistvincentyPoint, b : GeodistvincentyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_dist_vincenty_point_cross(a : GeodistvincentyPoint, b : GeodistvincentyPoint) -> GeodistvincentyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_dist_vincenty_point_norm(pt : GeodistvincentyPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_dist_vincenty_point_normalize(pt : GeodistvincentyPoint) -> GeodistvincentyPoint {
  let n = geo_dist_vincenty_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_dist_vincenty_point_scale(pt, 1.0 / n) }
}

pub fn geo_dist_vincenty_point_negate(pt : GeodistvincentyPoint) -> GeodistvincentyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_dist_vincenty_point_mid(a : GeodistvincentyPoint, b : GeodistvincentyPoint) -> GeodistvincentyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_dist_vincenty_point_lerp(a : GeodistvincentyPoint, b : GeodistvincentyPoint, t : Double) -> GeodistvincentyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_dist_vincenty_point_to_string(pt : GeodistvincentyPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeodistvincentySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_vincenty_make_series(vals : Array[Double], name : String) -> GeodistvincentySeries {
  { vals, name, meta: 0 }
}

pub fn geo_dist_vincenty_series_len(s : GeodistvincentySeries) -> Int { s.vals.length() }

pub fn geo_dist_vincenty_series_sum(s : GeodistvincentySeries) -> Double { @_common.sum(s.vals) }

pub fn geo_dist_vincenty_series_mean(s : GeodistvincentySeries) -> Double { @_common.mean(s.vals) }

pub fn geo_dist_vincenty_series_min(s : GeodistvincentySeries) -> Double { @_common.min(s.vals) }

pub fn geo_dist_vincenty_series_max(s : GeodistvincentySeries) -> Double { @_common.max(s.vals) }

pub fn geo_dist_vincenty_series_range(s : GeodistvincentySeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn geo_dist_vincenty_series_var(s : GeodistvincentySeries) -> Double { @_common.variance(s.vals) }

pub fn geo_dist_vincenty_series_std(s : GeodistvincentySeries) -> Double { @_common.std(s.vals) }

pub fn geo_dist_vincenty_series_median(s : GeodistvincentySeries) -> Double { @_common.median(s.vals) }

pub fn geo_dist_vincenty_series_scale(s : GeodistvincentySeries, f : Double) -> GeodistvincentySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_dist_vincenty_series_add(a : GeodistvincentySeries, b : GeodistvincentySeries) -> GeodistvincentySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_dist_vincenty_series_sub(a : GeodistvincentySeries, b : GeodistvincentySeries) -> GeodistvincentySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_dist_vincenty_series_normalize(s : GeodistvincentySeries) -> GeodistvincentySeries {
  let mn = geo_dist_vincenty_series_min(s)
  let mx = geo_dist_vincenty_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_dist_vincenty_series_cumsum(s : GeodistvincentySeries) -> GeodistvincentySeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_dist_vincenty_series_to_string(s : GeodistvincentySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistvincentyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_vincenty_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistvincentyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_vincenty_matrix_identity(n : Int) -> GeodistvincentyMatrix {
  let m = geo_dist_vincenty_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_dist_vincenty_matrix_get(m : GeodistvincentyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_dist_vincenty_matrix_transpose(m : GeodistvincentyMatrix) -> GeodistvincentyMatrix {
  let result = geo_dist_vincenty_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_dist_vincenty_matrix_add(a : GeodistvincentyMatrix, b : GeodistvincentyMatrix) -> GeodistvincentyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_dist_vincenty_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_dist_vincenty_matrix_scale(m : GeodistvincentyMatrix, s : Double) -> GeodistvincentyMatrix {
  let result = geo_dist_vincenty_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_dist_vincenty_matrix_multiply(a : GeodistvincentyMatrix, b : GeodistvincentyMatrix) -> GeodistvincentyMatrix {
  if a.cols != b.rows { return geo_dist_vincenty_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_dist_vincenty_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_dist_vincenty_matrix_trace(m : GeodistvincentyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_dist_vincenty_matrix_det(m : GeodistvincentyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_dist_vincenty_matrix_norm(m : GeodistvincentyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_dist_vincenty_matrix_to_string(m : GeodistvincentyMatrix) -> String {
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

pub(all) struct GeodistvincentyVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_vincenty_make_vector(comps : Array[Double]) -> GeodistvincentyVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_vincenty_vector_zero(dim : Int) -> GeodistvincentyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_dist_vincenty_vector_add(a : GeodistvincentyVector, b : GeodistvincentyVector) -> GeodistvincentyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_vincenty_vector_sub(a : GeodistvincentyVector, b : GeodistvincentyVector) -> GeodistvincentyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_vincenty_vector_scale(v : GeodistvincentyVector, s : Double) -> GeodistvincentyVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_dist_vincenty_vector_dot(a : GeodistvincentyVector, b : GeodistvincentyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_dist_vincenty_vector_norm(v : GeodistvincentyVector) -> Double { @_common.sqrt(geo_dist_vincenty_vector_dot(v, v)) }

pub fn geo_dist_vincenty_vector_normalize(v : GeodistvincentyVector) -> GeodistvincentyVector {
  let n = geo_dist_vincenty_vector_norm(v)
  if n < 0.0000001 { v } else { geo_dist_vincenty_vector_scale(v, 1.0 / n) }
}

pub fn geo_dist_vincenty_vector_dist(a : GeodistvincentyVector, b : GeodistvincentyVector) -> Double {
  geo_dist_vincenty_vector_norm(geo_dist_vincenty_vector_sub(a, b))
}

pub fn geo_dist_vincenty_vector_to_string(v : GeodistvincentyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_vincenty_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_dist_vincenty_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_dist_vincenty_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_dist_vincenty_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_dist_vincenty_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_dist_vincenty_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_dist_vincenty_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_dist_vincenty_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_dist_vincenty_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_dist_vincenty_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_dist_vincenty_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_dist_vincenty_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_dist_vincenty_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_dist_vincenty_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_dist_vincenty_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_dist_vincenty_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_dist_vincenty_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_dist_vincenty_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_dist_vincenty_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_dist_vincenty_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_dist_vincenty_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_dist_vincenty_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_dist_vincenty_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_dist_vincenty_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_dist_vincenty_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_dist_vincenty_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_dist_vincenty_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_dist_vincenty_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_dist_vincenty_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeodistvincentyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_frame_make(size : Int) -> GeodistvincentyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_frame_len(s : GeodistvincentyFrame) -> Int { s.size }

pub fn geo_dist_vincenty_frame_get(s : GeodistvincentyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_frame_set(s : GeodistvincentyFrame, i : Int, v : Double) -> GeodistvincentyFrame {
  let result = geo_dist_vincenty_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_frame_sum(s : GeodistvincentyFrame) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_frame_mean(s : GeodistvincentyFrame) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_frame_scale(s : GeodistvincentyFrame, f : Double) -> GeodistvincentyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_frame_add(a : GeodistvincentyFrame, b : GeodistvincentyFrame) -> GeodistvincentyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_frame_copy(s : GeodistvincentyFrame) -> GeodistvincentyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_frame_fill(s : GeodistvincentyFrame, v : Double) -> GeodistvincentyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_frame_min(s : GeodistvincentyFrame) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_frame_max(s : GeodistvincentyFrame) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_frame_to_string(s : GeodistvincentyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_table_make(size : Int) -> GeodistvincentyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_table_len(s : GeodistvincentyTable) -> Int { s.size }

pub fn geo_dist_vincenty_table_get(s : GeodistvincentyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_table_set(s : GeodistvincentyTable, i : Int, v : Double) -> GeodistvincentyTable {
  let result = geo_dist_vincenty_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_table_sum(s : GeodistvincentyTable) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_table_mean(s : GeodistvincentyTable) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_table_scale(s : GeodistvincentyTable, f : Double) -> GeodistvincentyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_table_add(a : GeodistvincentyTable, b : GeodistvincentyTable) -> GeodistvincentyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_table_copy(s : GeodistvincentyTable) -> GeodistvincentyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_table_fill(s : GeodistvincentyTable, v : Double) -> GeodistvincentyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_table_min(s : GeodistvincentyTable) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_table_max(s : GeodistvincentyTable) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_table_to_string(s : GeodistvincentyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_graphn_make(size : Int) -> GeodistvincentyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_graphn_len(s : GeodistvincentyGraphN) -> Int { s.size }

pub fn geo_dist_vincenty_graphn_get(s : GeodistvincentyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_graphn_set(s : GeodistvincentyGraphN, i : Int, v : Double) -> GeodistvincentyGraphN {
  let result = geo_dist_vincenty_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_graphn_sum(s : GeodistvincentyGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_graphn_mean(s : GeodistvincentyGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_graphn_scale(s : GeodistvincentyGraphN, f : Double) -> GeodistvincentyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_graphn_add(a : GeodistvincentyGraphN, b : GeodistvincentyGraphN) -> GeodistvincentyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_graphn_copy(s : GeodistvincentyGraphN) -> GeodistvincentyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_graphn_fill(s : GeodistvincentyGraphN, v : Double) -> GeodistvincentyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_graphn_min(s : GeodistvincentyGraphN) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_graphn_max(s : GeodistvincentyGraphN) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_graphn_to_string(s : GeodistvincentyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_node_make(size : Int) -> GeodistvincentyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_node_len(s : GeodistvincentyNode) -> Int { s.size }

pub fn geo_dist_vincenty_node_get(s : GeodistvincentyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_node_set(s : GeodistvincentyNode, i : Int, v : Double) -> GeodistvincentyNode {
  let result = geo_dist_vincenty_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_node_sum(s : GeodistvincentyNode) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_node_mean(s : GeodistvincentyNode) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_node_scale(s : GeodistvincentyNode, f : Double) -> GeodistvincentyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_node_add(a : GeodistvincentyNode, b : GeodistvincentyNode) -> GeodistvincentyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_node_copy(s : GeodistvincentyNode) -> GeodistvincentyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_node_fill(s : GeodistvincentyNode, v : Double) -> GeodistvincentyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_node_min(s : GeodistvincentyNode) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_node_max(s : GeodistvincentyNode) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_node_to_string(s : GeodistvincentyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_edge_make(size : Int) -> GeodistvincentyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_edge_len(s : GeodistvincentyEdge) -> Int { s.size }

pub fn geo_dist_vincenty_edge_get(s : GeodistvincentyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_edge_set(s : GeodistvincentyEdge, i : Int, v : Double) -> GeodistvincentyEdge {
  let result = geo_dist_vincenty_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_edge_sum(s : GeodistvincentyEdge) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_edge_mean(s : GeodistvincentyEdge) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_edge_scale(s : GeodistvincentyEdge, f : Double) -> GeodistvincentyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_edge_add(a : GeodistvincentyEdge, b : GeodistvincentyEdge) -> GeodistvincentyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_edge_copy(s : GeodistvincentyEdge) -> GeodistvincentyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_edge_fill(s : GeodistvincentyEdge, v : Double) -> GeodistvincentyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_edge_min(s : GeodistvincentyEdge) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_edge_max(s : GeodistvincentyEdge) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_edge_to_string(s : GeodistvincentyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_path_make(size : Int) -> GeodistvincentyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_path_len(s : GeodistvincentyPath) -> Int { s.size }

pub fn geo_dist_vincenty_path_get(s : GeodistvincentyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_path_set(s : GeodistvincentyPath, i : Int, v : Double) -> GeodistvincentyPath {
  let result = geo_dist_vincenty_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_path_sum(s : GeodistvincentyPath) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_path_mean(s : GeodistvincentyPath) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_path_scale(s : GeodistvincentyPath, f : Double) -> GeodistvincentyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_path_add(a : GeodistvincentyPath, b : GeodistvincentyPath) -> GeodistvincentyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_path_copy(s : GeodistvincentyPath) -> GeodistvincentyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_path_fill(s : GeodistvincentyPath, v : Double) -> GeodistvincentyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_path_min(s : GeodistvincentyPath) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_path_max(s : GeodistvincentyPath) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_path_to_string(s : GeodistvincentyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_cluster_make(size : Int) -> GeodistvincentyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_cluster_len(s : GeodistvincentyCluster) -> Int { s.size }

pub fn geo_dist_vincenty_cluster_get(s : GeodistvincentyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_cluster_set(s : GeodistvincentyCluster, i : Int, v : Double) -> GeodistvincentyCluster {
  let result = geo_dist_vincenty_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_cluster_sum(s : GeodistvincentyCluster) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_cluster_mean(s : GeodistvincentyCluster) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_cluster_scale(s : GeodistvincentyCluster, f : Double) -> GeodistvincentyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_cluster_add(a : GeodistvincentyCluster, b : GeodistvincentyCluster) -> GeodistvincentyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_cluster_copy(s : GeodistvincentyCluster) -> GeodistvincentyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_cluster_fill(s : GeodistvincentyCluster, v : Double) -> GeodistvincentyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_cluster_min(s : GeodistvincentyCluster) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_cluster_max(s : GeodistvincentyCluster) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_cluster_to_string(s : GeodistvincentyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_model_make(size : Int) -> GeodistvincentyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_model_len(s : GeodistvincentyModel) -> Int { s.size }

pub fn geo_dist_vincenty_model_get(s : GeodistvincentyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_model_set(s : GeodistvincentyModel, i : Int, v : Double) -> GeodistvincentyModel {
  let result = geo_dist_vincenty_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_model_sum(s : GeodistvincentyModel) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_model_mean(s : GeodistvincentyModel) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_model_scale(s : GeodistvincentyModel, f : Double) -> GeodistvincentyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_model_add(a : GeodistvincentyModel, b : GeodistvincentyModel) -> GeodistvincentyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_model_copy(s : GeodistvincentyModel) -> GeodistvincentyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_model_fill(s : GeodistvincentyModel, v : Double) -> GeodistvincentyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_model_min(s : GeodistvincentyModel) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_model_max(s : GeodistvincentyModel) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_model_to_string(s : GeodistvincentyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_layer_make(size : Int) -> GeodistvincentyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_layer_len(s : GeodistvincentyLayer) -> Int { s.size }

pub fn geo_dist_vincenty_layer_get(s : GeodistvincentyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_layer_set(s : GeodistvincentyLayer, i : Int, v : Double) -> GeodistvincentyLayer {
  let result = geo_dist_vincenty_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_layer_sum(s : GeodistvincentyLayer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_layer_mean(s : GeodistvincentyLayer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_layer_scale(s : GeodistvincentyLayer, f : Double) -> GeodistvincentyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_layer_add(a : GeodistvincentyLayer, b : GeodistvincentyLayer) -> GeodistvincentyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_layer_copy(s : GeodistvincentyLayer) -> GeodistvincentyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_layer_fill(s : GeodistvincentyLayer, v : Double) -> GeodistvincentyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_layer_min(s : GeodistvincentyLayer) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_layer_max(s : GeodistvincentyLayer) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_layer_to_string(s : GeodistvincentyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_buffer_make(size : Int) -> GeodistvincentyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_buffer_len(s : GeodistvincentyBuffer) -> Int { s.size }

pub fn geo_dist_vincenty_buffer_get(s : GeodistvincentyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_buffer_set(s : GeodistvincentyBuffer, i : Int, v : Double) -> GeodistvincentyBuffer {
  let result = geo_dist_vincenty_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_buffer_sum(s : GeodistvincentyBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_buffer_mean(s : GeodistvincentyBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_buffer_scale(s : GeodistvincentyBuffer, f : Double) -> GeodistvincentyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_buffer_add(a : GeodistvincentyBuffer, b : GeodistvincentyBuffer) -> GeodistvincentyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_buffer_copy(s : GeodistvincentyBuffer) -> GeodistvincentyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_buffer_fill(s : GeodistvincentyBuffer, v : Double) -> GeodistvincentyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_buffer_min(s : GeodistvincentyBuffer) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_buffer_max(s : GeodistvincentyBuffer) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_buffer_to_string(s : GeodistvincentyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_cursor_make(size : Int) -> GeodistvincentyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_cursor_len(s : GeodistvincentyCursor) -> Int { s.size }

pub fn geo_dist_vincenty_cursor_get(s : GeodistvincentyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_cursor_set(s : GeodistvincentyCursor, i : Int, v : Double) -> GeodistvincentyCursor {
  let result = geo_dist_vincenty_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_cursor_sum(s : GeodistvincentyCursor) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_cursor_mean(s : GeodistvincentyCursor) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_cursor_scale(s : GeodistvincentyCursor, f : Double) -> GeodistvincentyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_cursor_add(a : GeodistvincentyCursor, b : GeodistvincentyCursor) -> GeodistvincentyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_cursor_copy(s : GeodistvincentyCursor) -> GeodistvincentyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_cursor_fill(s : GeodistvincentyCursor, v : Double) -> GeodistvincentyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_cursor_min(s : GeodistvincentyCursor) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_cursor_max(s : GeodistvincentyCursor) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_cursor_to_string(s : GeodistvincentyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_view_make(size : Int) -> GeodistvincentyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_view_len(s : GeodistvincentyView) -> Int { s.size }

pub fn geo_dist_vincenty_view_get(s : GeodistvincentyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_view_set(s : GeodistvincentyView, i : Int, v : Double) -> GeodistvincentyView {
  let result = geo_dist_vincenty_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_view_sum(s : GeodistvincentyView) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_view_mean(s : GeodistvincentyView) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_view_scale(s : GeodistvincentyView, f : Double) -> GeodistvincentyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_view_add(a : GeodistvincentyView, b : GeodistvincentyView) -> GeodistvincentyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_view_copy(s : GeodistvincentyView) -> GeodistvincentyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_view_fill(s : GeodistvincentyView, v : Double) -> GeodistvincentyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_view_min(s : GeodistvincentyView) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_view_max(s : GeodistvincentyView) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_view_to_string(s : GeodistvincentyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_range_make(size : Int) -> GeodistvincentyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_range_len(s : GeodistvincentyRange) -> Int { s.size }

pub fn geo_dist_vincenty_range_get(s : GeodistvincentyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_range_set(s : GeodistvincentyRange, i : Int, v : Double) -> GeodistvincentyRange {
  let result = geo_dist_vincenty_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_range_sum(s : GeodistvincentyRange) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_range_mean(s : GeodistvincentyRange) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_range_scale(s : GeodistvincentyRange, f : Double) -> GeodistvincentyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_range_add(a : GeodistvincentyRange, b : GeodistvincentyRange) -> GeodistvincentyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_range_copy(s : GeodistvincentyRange) -> GeodistvincentyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_range_fill(s : GeodistvincentyRange, v : Double) -> GeodistvincentyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_range_min(s : GeodistvincentyRange) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_range_max(s : GeodistvincentyRange) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_range_to_string(s : GeodistvincentyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_slice_make(size : Int) -> GeodistvincentySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_slice_len(s : GeodistvincentySlice) -> Int { s.size }

pub fn geo_dist_vincenty_slice_get(s : GeodistvincentySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_slice_set(s : GeodistvincentySlice, i : Int, v : Double) -> GeodistvincentySlice {
  let result = geo_dist_vincenty_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_slice_sum(s : GeodistvincentySlice) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_slice_mean(s : GeodistvincentySlice) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_slice_scale(s : GeodistvincentySlice, f : Double) -> GeodistvincentySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_slice_add(a : GeodistvincentySlice, b : GeodistvincentySlice) -> GeodistvincentySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_slice_copy(s : GeodistvincentySlice) -> GeodistvincentySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_slice_fill(s : GeodistvincentySlice, v : Double) -> GeodistvincentySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_slice_min(s : GeodistvincentySlice) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_slice_max(s : GeodistvincentySlice) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_slice_to_string(s : GeodistvincentySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

