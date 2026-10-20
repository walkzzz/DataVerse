///===
/// extcore/geo_buffer_triangle

pub(all) struct GeobuffertrianglePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_buffer_triangle_make_point(x : Double, y : Double) -> GeobuffertrianglePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_buffer_triangle_make_point3(x : Double, y : Double, z : Double) -> GeobuffertrianglePoint {
  { x, y, z, label: 0 }
}

pub fn geo_buffer_triangle_point_x(pt : GeobuffertrianglePoint) -> Double { pt.x }

pub fn geo_buffer_triangle_point_y(pt : GeobuffertrianglePoint) -> Double { pt.y }

pub fn geo_buffer_triangle_point_z(pt : GeobuffertrianglePoint) -> Double { pt.z }

pub fn geo_buffer_triangle_point_label(pt : GeobuffertrianglePoint) -> Int { pt.label }

pub fn geo_buffer_triangle_point_dist(a : GeobuffertrianglePoint, b : GeobuffertrianglePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_buffer_triangle_point_add(a : GeobuffertrianglePoint, b : GeobuffertrianglePoint) -> GeobuffertrianglePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_buffer_triangle_point_sub(a : GeobuffertrianglePoint, b : GeobuffertrianglePoint) -> GeobuffertrianglePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_buffer_triangle_point_scale(pt : GeobuffertrianglePoint, s : Double) -> GeobuffertrianglePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_buffer_triangle_point_dot(a : GeobuffertrianglePoint, b : GeobuffertrianglePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_buffer_triangle_point_cross(a : GeobuffertrianglePoint, b : GeobuffertrianglePoint) -> GeobuffertrianglePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_buffer_triangle_point_norm(pt : GeobuffertrianglePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_buffer_triangle_point_normalize(pt : GeobuffertrianglePoint) -> GeobuffertrianglePoint {
  let n = geo_buffer_triangle_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_buffer_triangle_point_scale(pt, 1.0 / n) }
}

pub fn geo_buffer_triangle_point_negate(pt : GeobuffertrianglePoint) -> GeobuffertrianglePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_buffer_triangle_point_mid(a : GeobuffertrianglePoint, b : GeobuffertrianglePoint) -> GeobuffertrianglePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_buffer_triangle_point_lerp(a : GeobuffertrianglePoint, b : GeobuffertrianglePoint, t : Double) -> GeobuffertrianglePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_buffer_triangle_point_to_string(pt : GeobuffertrianglePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeobuffertriangleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_buffer_triangle_make_series(vals : Array[Double], name : String) -> GeobuffertriangleSeries {
  { vals, name, meta: 0 }
}

pub fn geo_buffer_triangle_series_len(s : GeobuffertriangleSeries) -> Int { s.vals.length() }

pub fn geo_buffer_triangle_series_sum(s : GeobuffertriangleSeries) -> Double { @_common.sum(s.vals) }

pub fn geo_buffer_triangle_series_mean(s : GeobuffertriangleSeries) -> Double { @_common.mean(s.vals) }

pub fn geo_buffer_triangle_series_min(s : GeobuffertriangleSeries) -> Double { @_common.min(s.vals) }

pub fn geo_buffer_triangle_series_max(s : GeobuffertriangleSeries) -> Double { @_common.max(s.vals) }

pub fn geo_buffer_triangle_series_range(s : GeobuffertriangleSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn geo_buffer_triangle_series_var(s : GeobuffertriangleSeries) -> Double { @_common.variance(s.vals) }

pub fn geo_buffer_triangle_series_std(s : GeobuffertriangleSeries) -> Double { @_common.std(s.vals) }

pub fn geo_buffer_triangle_series_median(s : GeobuffertriangleSeries) -> Double { @_common.median(s.vals) }

pub fn geo_buffer_triangle_series_scale(s : GeobuffertriangleSeries, f : Double) -> GeobuffertriangleSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn geo_buffer_triangle_series_add(a : GeobuffertriangleSeries, b : GeobuffertriangleSeries) -> GeobuffertriangleSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_buffer_triangle_series_sub(a : GeobuffertriangleSeries, b : GeobuffertriangleSeries) -> GeobuffertriangleSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_buffer_triangle_series_normalize(s : GeobuffertriangleSeries) -> GeobuffertriangleSeries {
  let mn = geo_buffer_triangle_series_min(s)
  let mx = geo_buffer_triangle_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_buffer_triangle_series_cumsum(s : GeobuffertriangleSeries) -> GeobuffertriangleSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_buffer_triangle_series_to_string(s : GeobuffertriangleSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobuffertriangleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_buffer_triangle_make_matrix(rows : Int, cols : Int, val : Double) -> GeobuffertriangleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_buffer_triangle_matrix_identity(n : Int) -> GeobuffertriangleMatrix {
  let m = geo_buffer_triangle_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_buffer_triangle_matrix_get(m : GeobuffertriangleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_buffer_triangle_matrix_transpose(m : GeobuffertriangleMatrix) -> GeobuffertriangleMatrix {
  let result = geo_buffer_triangle_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_buffer_triangle_matrix_add(a : GeobuffertriangleMatrix, b : GeobuffertriangleMatrix) -> GeobuffertriangleMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_buffer_triangle_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_buffer_triangle_matrix_scale(m : GeobuffertriangleMatrix, s : Double) -> GeobuffertriangleMatrix {
  let result = geo_buffer_triangle_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_buffer_triangle_matrix_multiply(a : GeobuffertriangleMatrix, b : GeobuffertriangleMatrix) -> GeobuffertriangleMatrix {
  if a.cols != b.rows { return geo_buffer_triangle_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_buffer_triangle_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_buffer_triangle_matrix_trace(m : GeobuffertriangleMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_buffer_triangle_matrix_det(m : GeobuffertriangleMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_buffer_triangle_matrix_norm(m : GeobuffertriangleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_buffer_triangle_matrix_to_string(m : GeobuffertriangleMatrix) -> String {
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

pub(all) struct GeobuffertriangleVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_buffer_triangle_make_vector(comps : Array[Double]) -> GeobuffertriangleVector {
  { comps, dim: comps.length() }
}

pub fn geo_buffer_triangle_vector_zero(dim : Int) -> GeobuffertriangleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_buffer_triangle_vector_add(a : GeobuffertriangleVector, b : GeobuffertriangleVector) -> GeobuffertriangleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn geo_buffer_triangle_vector_sub(a : GeobuffertriangleVector, b : GeobuffertriangleVector) -> GeobuffertriangleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn geo_buffer_triangle_vector_scale(v : GeobuffertriangleVector, s : Double) -> GeobuffertriangleVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn geo_buffer_triangle_vector_dot(a : GeobuffertriangleVector, b : GeobuffertriangleVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_buffer_triangle_vector_norm(v : GeobuffertriangleVector) -> Double { @_common.sqrt(geo_buffer_triangle_vector_dot(v, v)) }

pub fn geo_buffer_triangle_vector_normalize(v : GeobuffertriangleVector) -> GeobuffertriangleVector {
  let n = geo_buffer_triangle_vector_norm(v)
  if n < 0.0000001 { v } else { geo_buffer_triangle_vector_scale(v, 1.0 / n) }
}

pub fn geo_buffer_triangle_vector_dist(a : GeobuffertriangleVector, b : GeobuffertriangleVector) -> Double {
  geo_buffer_triangle_vector_norm(geo_buffer_triangle_vector_sub(a, b))
}

pub fn geo_buffer_triangle_vector_to_string(v : GeobuffertriangleVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_buffer_triangle_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_buffer_triangle_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_buffer_triangle_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_buffer_triangle_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_buffer_triangle_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_buffer_triangle_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_buffer_triangle_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_buffer_triangle_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_buffer_triangle_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_buffer_triangle_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_buffer_triangle_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_buffer_triangle_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_buffer_triangle_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_buffer_triangle_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_buffer_triangle_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_buffer_triangle_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_buffer_triangle_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_buffer_triangle_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_buffer_triangle_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_buffer_triangle_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_buffer_triangle_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_buffer_triangle_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_buffer_triangle_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_buffer_triangle_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_buffer_triangle_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_buffer_triangle_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_buffer_triangle_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_buffer_triangle_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_buffer_triangle_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeobuffertriangleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_frame_make(size : Int) -> GeobuffertriangleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_triangle_frame_len(s : GeobuffertriangleFrame) -> Int { s.size }

pub fn geo_buffer_triangle_frame_get(s : GeobuffertriangleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_triangle_frame_set(s : GeobuffertriangleFrame, i : Int, v : Double) -> GeobuffertriangleFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_frame_sum(s : GeobuffertriangleFrame) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_triangle_frame_mean(s : GeobuffertriangleFrame) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_triangle_frame_scale(s : GeobuffertriangleFrame, f : Double) -> GeobuffertriangleFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_frame_add(a : GeobuffertriangleFrame, b : GeobuffertriangleFrame) -> GeobuffertriangleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_triangle_frame_copy(s : GeobuffertriangleFrame) -> GeobuffertriangleFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_frame_fill(s : GeobuffertriangleFrame, v : Double) -> GeobuffertriangleFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_frame_min(s : GeobuffertriangleFrame) -> Double { @_common.min(s.data) }

pub fn geo_buffer_triangle_frame_max(s : GeobuffertriangleFrame) -> Double { @_common.max(s.data) }

pub fn geo_buffer_triangle_frame_to_string(s : GeobuffertriangleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffertriangleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_table_make(size : Int) -> GeobuffertriangleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_triangle_table_len(s : GeobuffertriangleTable) -> Int { s.size }

pub fn geo_buffer_triangle_table_get(s : GeobuffertriangleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_triangle_table_set(s : GeobuffertriangleTable, i : Int, v : Double) -> GeobuffertriangleTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_table_sum(s : GeobuffertriangleTable) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_triangle_table_mean(s : GeobuffertriangleTable) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_triangle_table_scale(s : GeobuffertriangleTable, f : Double) -> GeobuffertriangleTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_table_add(a : GeobuffertriangleTable, b : GeobuffertriangleTable) -> GeobuffertriangleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_triangle_table_copy(s : GeobuffertriangleTable) -> GeobuffertriangleTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_table_fill(s : GeobuffertriangleTable, v : Double) -> GeobuffertriangleTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_table_min(s : GeobuffertriangleTable) -> Double { @_common.min(s.data) }

pub fn geo_buffer_triangle_table_max(s : GeobuffertriangleTable) -> Double { @_common.max(s.data) }

pub fn geo_buffer_triangle_table_to_string(s : GeobuffertriangleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffertriangleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_graphn_make(size : Int) -> GeobuffertriangleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_triangle_graphn_len(s : GeobuffertriangleGraphN) -> Int { s.size }

pub fn geo_buffer_triangle_graphn_get(s : GeobuffertriangleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_triangle_graphn_set(s : GeobuffertriangleGraphN, i : Int, v : Double) -> GeobuffertriangleGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_graphn_sum(s : GeobuffertriangleGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_triangle_graphn_mean(s : GeobuffertriangleGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_triangle_graphn_scale(s : GeobuffertriangleGraphN, f : Double) -> GeobuffertriangleGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_graphn_add(a : GeobuffertriangleGraphN, b : GeobuffertriangleGraphN) -> GeobuffertriangleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_triangle_graphn_copy(s : GeobuffertriangleGraphN) -> GeobuffertriangleGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_graphn_fill(s : GeobuffertriangleGraphN, v : Double) -> GeobuffertriangleGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_graphn_min(s : GeobuffertriangleGraphN) -> Double { @_common.min(s.data) }

pub fn geo_buffer_triangle_graphn_max(s : GeobuffertriangleGraphN) -> Double { @_common.max(s.data) }

pub fn geo_buffer_triangle_graphn_to_string(s : GeobuffertriangleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffertriangleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_node_make(size : Int) -> GeobuffertriangleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_triangle_node_len(s : GeobuffertriangleNode) -> Int { s.size }

pub fn geo_buffer_triangle_node_get(s : GeobuffertriangleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_triangle_node_set(s : GeobuffertriangleNode, i : Int, v : Double) -> GeobuffertriangleNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_node_sum(s : GeobuffertriangleNode) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_triangle_node_mean(s : GeobuffertriangleNode) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_triangle_node_scale(s : GeobuffertriangleNode, f : Double) -> GeobuffertriangleNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_node_add(a : GeobuffertriangleNode, b : GeobuffertriangleNode) -> GeobuffertriangleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_triangle_node_copy(s : GeobuffertriangleNode) -> GeobuffertriangleNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_node_fill(s : GeobuffertriangleNode, v : Double) -> GeobuffertriangleNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_node_min(s : GeobuffertriangleNode) -> Double { @_common.min(s.data) }

pub fn geo_buffer_triangle_node_max(s : GeobuffertriangleNode) -> Double { @_common.max(s.data) }

pub fn geo_buffer_triangle_node_to_string(s : GeobuffertriangleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffertriangleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_edge_make(size : Int) -> GeobuffertriangleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_triangle_edge_len(s : GeobuffertriangleEdge) -> Int { s.size }

pub fn geo_buffer_triangle_edge_get(s : GeobuffertriangleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_triangle_edge_set(s : GeobuffertriangleEdge, i : Int, v : Double) -> GeobuffertriangleEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_edge_sum(s : GeobuffertriangleEdge) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_triangle_edge_mean(s : GeobuffertriangleEdge) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_triangle_edge_scale(s : GeobuffertriangleEdge, f : Double) -> GeobuffertriangleEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_edge_add(a : GeobuffertriangleEdge, b : GeobuffertriangleEdge) -> GeobuffertriangleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_triangle_edge_copy(s : GeobuffertriangleEdge) -> GeobuffertriangleEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_edge_fill(s : GeobuffertriangleEdge, v : Double) -> GeobuffertriangleEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_edge_min(s : GeobuffertriangleEdge) -> Double { @_common.min(s.data) }

pub fn geo_buffer_triangle_edge_max(s : GeobuffertriangleEdge) -> Double { @_common.max(s.data) }

pub fn geo_buffer_triangle_edge_to_string(s : GeobuffertriangleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffertrianglePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_path_make(size : Int) -> GeobuffertrianglePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_triangle_path_len(s : GeobuffertrianglePath) -> Int { s.size }

pub fn geo_buffer_triangle_path_get(s : GeobuffertrianglePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_triangle_path_set(s : GeobuffertrianglePath, i : Int, v : Double) -> GeobuffertrianglePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_path_sum(s : GeobuffertrianglePath) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_triangle_path_mean(s : GeobuffertrianglePath) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_triangle_path_scale(s : GeobuffertrianglePath, f : Double) -> GeobuffertrianglePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_path_add(a : GeobuffertrianglePath, b : GeobuffertrianglePath) -> GeobuffertrianglePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_triangle_path_copy(s : GeobuffertrianglePath) -> GeobuffertrianglePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_path_fill(s : GeobuffertrianglePath, v : Double) -> GeobuffertrianglePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_path_min(s : GeobuffertrianglePath) -> Double { @_common.min(s.data) }

pub fn geo_buffer_triangle_path_max(s : GeobuffertrianglePath) -> Double { @_common.max(s.data) }

pub fn geo_buffer_triangle_path_to_string(s : GeobuffertrianglePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffertriangleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_cluster_make(size : Int) -> GeobuffertriangleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_triangle_cluster_len(s : GeobuffertriangleCluster) -> Int { s.size }

pub fn geo_buffer_triangle_cluster_get(s : GeobuffertriangleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_triangle_cluster_set(s : GeobuffertriangleCluster, i : Int, v : Double) -> GeobuffertriangleCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_cluster_sum(s : GeobuffertriangleCluster) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_triangle_cluster_mean(s : GeobuffertriangleCluster) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_triangle_cluster_scale(s : GeobuffertriangleCluster, f : Double) -> GeobuffertriangleCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_cluster_add(a : GeobuffertriangleCluster, b : GeobuffertriangleCluster) -> GeobuffertriangleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_triangle_cluster_copy(s : GeobuffertriangleCluster) -> GeobuffertriangleCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_cluster_fill(s : GeobuffertriangleCluster, v : Double) -> GeobuffertriangleCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_cluster_min(s : GeobuffertriangleCluster) -> Double { @_common.min(s.data) }

pub fn geo_buffer_triangle_cluster_max(s : GeobuffertriangleCluster) -> Double { @_common.max(s.data) }

pub fn geo_buffer_triangle_cluster_to_string(s : GeobuffertriangleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffertriangleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_model_make(size : Int) -> GeobuffertriangleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_triangle_model_len(s : GeobuffertriangleModel) -> Int { s.size }

pub fn geo_buffer_triangle_model_get(s : GeobuffertriangleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_triangle_model_set(s : GeobuffertriangleModel, i : Int, v : Double) -> GeobuffertriangleModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_model_sum(s : GeobuffertriangleModel) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_triangle_model_mean(s : GeobuffertriangleModel) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_triangle_model_scale(s : GeobuffertriangleModel, f : Double) -> GeobuffertriangleModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_model_add(a : GeobuffertriangleModel, b : GeobuffertriangleModel) -> GeobuffertriangleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_triangle_model_copy(s : GeobuffertriangleModel) -> GeobuffertriangleModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_model_fill(s : GeobuffertriangleModel, v : Double) -> GeobuffertriangleModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_model_min(s : GeobuffertriangleModel) -> Double { @_common.min(s.data) }

pub fn geo_buffer_triangle_model_max(s : GeobuffertriangleModel) -> Double { @_common.max(s.data) }

pub fn geo_buffer_triangle_model_to_string(s : GeobuffertriangleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffertriangleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_layer_make(size : Int) -> GeobuffertriangleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_triangle_layer_len(s : GeobuffertriangleLayer) -> Int { s.size }

pub fn geo_buffer_triangle_layer_get(s : GeobuffertriangleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_triangle_layer_set(s : GeobuffertriangleLayer, i : Int, v : Double) -> GeobuffertriangleLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_layer_sum(s : GeobuffertriangleLayer) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_triangle_layer_mean(s : GeobuffertriangleLayer) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_triangle_layer_scale(s : GeobuffertriangleLayer, f : Double) -> GeobuffertriangleLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_layer_add(a : GeobuffertriangleLayer, b : GeobuffertriangleLayer) -> GeobuffertriangleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_triangle_layer_copy(s : GeobuffertriangleLayer) -> GeobuffertriangleLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_layer_fill(s : GeobuffertriangleLayer, v : Double) -> GeobuffertriangleLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_layer_min(s : GeobuffertriangleLayer) -> Double { @_common.min(s.data) }

pub fn geo_buffer_triangle_layer_max(s : GeobuffertriangleLayer) -> Double { @_common.max(s.data) }

pub fn geo_buffer_triangle_layer_to_string(s : GeobuffertriangleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffertriangleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_buffer_make(size : Int) -> GeobuffertriangleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_triangle_buffer_len(s : GeobuffertriangleBuffer) -> Int { s.size }

pub fn geo_buffer_triangle_buffer_get(s : GeobuffertriangleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_triangle_buffer_set(s : GeobuffertriangleBuffer, i : Int, v : Double) -> GeobuffertriangleBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_buffer_sum(s : GeobuffertriangleBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_triangle_buffer_mean(s : GeobuffertriangleBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_triangle_buffer_scale(s : GeobuffertriangleBuffer, f : Double) -> GeobuffertriangleBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_buffer_add(a : GeobuffertriangleBuffer, b : GeobuffertriangleBuffer) -> GeobuffertriangleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_triangle_buffer_copy(s : GeobuffertriangleBuffer) -> GeobuffertriangleBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_buffer_fill(s : GeobuffertriangleBuffer, v : Double) -> GeobuffertriangleBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_buffer_min(s : GeobuffertriangleBuffer) -> Double { @_common.min(s.data) }

pub fn geo_buffer_triangle_buffer_max(s : GeobuffertriangleBuffer) -> Double { @_common.max(s.data) }

pub fn geo_buffer_triangle_buffer_to_string(s : GeobuffertriangleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffertriangleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_cursor_make(size : Int) -> GeobuffertriangleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_triangle_cursor_len(s : GeobuffertriangleCursor) -> Int { s.size }

pub fn geo_buffer_triangle_cursor_get(s : GeobuffertriangleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_triangle_cursor_set(s : GeobuffertriangleCursor, i : Int, v : Double) -> GeobuffertriangleCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_cursor_sum(s : GeobuffertriangleCursor) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_triangle_cursor_mean(s : GeobuffertriangleCursor) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_triangle_cursor_scale(s : GeobuffertriangleCursor, f : Double) -> GeobuffertriangleCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_cursor_add(a : GeobuffertriangleCursor, b : GeobuffertriangleCursor) -> GeobuffertriangleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_triangle_cursor_copy(s : GeobuffertriangleCursor) -> GeobuffertriangleCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_cursor_fill(s : GeobuffertriangleCursor, v : Double) -> GeobuffertriangleCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_cursor_min(s : GeobuffertriangleCursor) -> Double { @_common.min(s.data) }

pub fn geo_buffer_triangle_cursor_max(s : GeobuffertriangleCursor) -> Double { @_common.max(s.data) }

pub fn geo_buffer_triangle_cursor_to_string(s : GeobuffertriangleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffertriangleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_view_make(size : Int) -> GeobuffertriangleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_triangle_view_len(s : GeobuffertriangleView) -> Int { s.size }

pub fn geo_buffer_triangle_view_get(s : GeobuffertriangleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_triangle_view_set(s : GeobuffertriangleView, i : Int, v : Double) -> GeobuffertriangleView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_view_sum(s : GeobuffertriangleView) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_triangle_view_mean(s : GeobuffertriangleView) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_triangle_view_scale(s : GeobuffertriangleView, f : Double) -> GeobuffertriangleView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_view_add(a : GeobuffertriangleView, b : GeobuffertriangleView) -> GeobuffertriangleView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_triangle_view_copy(s : GeobuffertriangleView) -> GeobuffertriangleView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_view_fill(s : GeobuffertriangleView, v : Double) -> GeobuffertriangleView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_view_min(s : GeobuffertriangleView) -> Double { @_common.min(s.data) }

pub fn geo_buffer_triangle_view_max(s : GeobuffertriangleView) -> Double { @_common.max(s.data) }

pub fn geo_buffer_triangle_view_to_string(s : GeobuffertriangleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffertriangleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_range_make(size : Int) -> GeobuffertriangleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_triangle_range_len(s : GeobuffertriangleRange) -> Int { s.size }

pub fn geo_buffer_triangle_range_get(s : GeobuffertriangleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_triangle_range_set(s : GeobuffertriangleRange, i : Int, v : Double) -> GeobuffertriangleRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_range_sum(s : GeobuffertriangleRange) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_triangle_range_mean(s : GeobuffertriangleRange) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_triangle_range_scale(s : GeobuffertriangleRange, f : Double) -> GeobuffertriangleRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_range_add(a : GeobuffertriangleRange, b : GeobuffertriangleRange) -> GeobuffertriangleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_triangle_range_copy(s : GeobuffertriangleRange) -> GeobuffertriangleRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_range_fill(s : GeobuffertriangleRange, v : Double) -> GeobuffertriangleRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_range_min(s : GeobuffertriangleRange) -> Double { @_common.min(s.data) }

pub fn geo_buffer_triangle_range_max(s : GeobuffertriangleRange) -> Double { @_common.max(s.data) }

pub fn geo_buffer_triangle_range_to_string(s : GeobuffertriangleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffertriangleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_slice_make(size : Int) -> GeobuffertriangleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_triangle_slice_len(s : GeobuffertriangleSlice) -> Int { s.size }

pub fn geo_buffer_triangle_slice_get(s : GeobuffertriangleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_triangle_slice_set(s : GeobuffertriangleSlice, i : Int, v : Double) -> GeobuffertriangleSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_slice_sum(s : GeobuffertriangleSlice) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_triangle_slice_mean(s : GeobuffertriangleSlice) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_triangle_slice_scale(s : GeobuffertriangleSlice, f : Double) -> GeobuffertriangleSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_slice_add(a : GeobuffertriangleSlice, b : GeobuffertriangleSlice) -> GeobuffertriangleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_triangle_slice_copy(s : GeobuffertriangleSlice) -> GeobuffertriangleSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_slice_fill(s : GeobuffertriangleSlice, v : Double) -> GeobuffertriangleSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_triangle_slice_min(s : GeobuffertriangleSlice) -> Double { @_common.min(s.data) }

pub fn geo_buffer_triangle_slice_max(s : GeobuffertriangleSlice) -> Double { @_common.max(s.data) }

pub fn geo_buffer_triangle_slice_to_string(s : GeobuffertriangleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

