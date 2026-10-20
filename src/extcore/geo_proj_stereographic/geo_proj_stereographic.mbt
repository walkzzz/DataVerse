///===
/// extcore/geo_proj_stereographic

pub(all) struct GeoprojstereographicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_stereographic_make_point(x : Double, y : Double) -> GeoprojstereographicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_stereographic_make_point3(x : Double, y : Double, z : Double) -> GeoprojstereographicPoint {
  { x, y, z, label: 0 }
}

pub fn geo_proj_stereographic_point_x(pt : GeoprojstereographicPoint) -> Double { pt.x }

pub fn geo_proj_stereographic_point_y(pt : GeoprojstereographicPoint) -> Double { pt.y }

pub fn geo_proj_stereographic_point_z(pt : GeoprojstereographicPoint) -> Double { pt.z }

pub fn geo_proj_stereographic_point_label(pt : GeoprojstereographicPoint) -> Int { pt.label }

pub fn geo_proj_stereographic_point_dist(a : GeoprojstereographicPoint, b : GeoprojstereographicPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_proj_stereographic_point_add(a : GeoprojstereographicPoint, b : GeoprojstereographicPoint) -> GeoprojstereographicPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_proj_stereographic_point_sub(a : GeoprojstereographicPoint, b : GeoprojstereographicPoint) -> GeoprojstereographicPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_proj_stereographic_point_scale(pt : GeoprojstereographicPoint, s : Double) -> GeoprojstereographicPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_proj_stereographic_point_dot(a : GeoprojstereographicPoint, b : GeoprojstereographicPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_proj_stereographic_point_cross(a : GeoprojstereographicPoint, b : GeoprojstereographicPoint) -> GeoprojstereographicPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_proj_stereographic_point_norm(pt : GeoprojstereographicPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_proj_stereographic_point_normalize(pt : GeoprojstereographicPoint) -> GeoprojstereographicPoint {
  let n = geo_proj_stereographic_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_proj_stereographic_point_scale(pt, 1.0 / n) }
}

pub fn geo_proj_stereographic_point_negate(pt : GeoprojstereographicPoint) -> GeoprojstereographicPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_proj_stereographic_point_mid(a : GeoprojstereographicPoint, b : GeoprojstereographicPoint) -> GeoprojstereographicPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_proj_stereographic_point_lerp(a : GeoprojstereographicPoint, b : GeoprojstereographicPoint, t : Double) -> GeoprojstereographicPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_proj_stereographic_point_to_string(pt : GeoprojstereographicPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeoprojstereographicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_stereographic_make_series(vals : Array[Double], name : String) -> GeoprojstereographicSeries {
  { vals, name, meta: 0 }
}

pub fn geo_proj_stereographic_series_len(s : GeoprojstereographicSeries) -> Int { s.vals.length() }

pub fn geo_proj_stereographic_series_sum(s : GeoprojstereographicSeries) -> Double { @_common.sum(s.vals) }

pub fn geo_proj_stereographic_series_mean(s : GeoprojstereographicSeries) -> Double { @_common.mean(s.vals) }

pub fn geo_proj_stereographic_series_min(s : GeoprojstereographicSeries) -> Double { @_common.min(s.vals) }

pub fn geo_proj_stereographic_series_max(s : GeoprojstereographicSeries) -> Double { @_common.max(s.vals) }

pub fn geo_proj_stereographic_series_range(s : GeoprojstereographicSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn geo_proj_stereographic_series_var(s : GeoprojstereographicSeries) -> Double { @_common.variance(s.vals) }

pub fn geo_proj_stereographic_series_std(s : GeoprojstereographicSeries) -> Double { @_common.std(s.vals) }

pub fn geo_proj_stereographic_series_median(s : GeoprojstereographicSeries) -> Double { @_common.median(s.vals) }

pub fn geo_proj_stereographic_series_scale(s : GeoprojstereographicSeries, f : Double) -> GeoprojstereographicSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn geo_proj_stereographic_series_add(a : GeoprojstereographicSeries, b : GeoprojstereographicSeries) -> GeoprojstereographicSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_proj_stereographic_series_sub(a : GeoprojstereographicSeries, b : GeoprojstereographicSeries) -> GeoprojstereographicSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_proj_stereographic_series_normalize(s : GeoprojstereographicSeries) -> GeoprojstereographicSeries {
  let mn = geo_proj_stereographic_series_min(s)
  let mx = geo_proj_stereographic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_proj_stereographic_series_cumsum(s : GeoprojstereographicSeries) -> GeoprojstereographicSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_proj_stereographic_series_to_string(s : GeoprojstereographicSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojstereographicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_stereographic_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojstereographicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_proj_stereographic_matrix_identity(n : Int) -> GeoprojstereographicMatrix {
  let m = geo_proj_stereographic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_proj_stereographic_matrix_get(m : GeoprojstereographicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_proj_stereographic_matrix_transpose(m : GeoprojstereographicMatrix) -> GeoprojstereographicMatrix {
  let result = geo_proj_stereographic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_proj_stereographic_matrix_add(a : GeoprojstereographicMatrix, b : GeoprojstereographicMatrix) -> GeoprojstereographicMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_proj_stereographic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_proj_stereographic_matrix_scale(m : GeoprojstereographicMatrix, s : Double) -> GeoprojstereographicMatrix {
  let result = geo_proj_stereographic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_proj_stereographic_matrix_multiply(a : GeoprojstereographicMatrix, b : GeoprojstereographicMatrix) -> GeoprojstereographicMatrix {
  if a.cols != b.rows { return geo_proj_stereographic_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_proj_stereographic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_proj_stereographic_matrix_trace(m : GeoprojstereographicMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_proj_stereographic_matrix_det(m : GeoprojstereographicMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_proj_stereographic_matrix_norm(m : GeoprojstereographicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_proj_stereographic_matrix_to_string(m : GeoprojstereographicMatrix) -> String {
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

pub(all) struct GeoprojstereographicVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_stereographic_make_vector(comps : Array[Double]) -> GeoprojstereographicVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_stereographic_vector_zero(dim : Int) -> GeoprojstereographicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_proj_stereographic_vector_add(a : GeoprojstereographicVector, b : GeoprojstereographicVector) -> GeoprojstereographicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn geo_proj_stereographic_vector_sub(a : GeoprojstereographicVector, b : GeoprojstereographicVector) -> GeoprojstereographicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn geo_proj_stereographic_vector_scale(v : GeoprojstereographicVector, s : Double) -> GeoprojstereographicVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn geo_proj_stereographic_vector_dot(a : GeoprojstereographicVector, b : GeoprojstereographicVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_proj_stereographic_vector_norm(v : GeoprojstereographicVector) -> Double { @_common.sqrt(geo_proj_stereographic_vector_dot(v, v)) }

pub fn geo_proj_stereographic_vector_normalize(v : GeoprojstereographicVector) -> GeoprojstereographicVector {
  let n = geo_proj_stereographic_vector_norm(v)
  if n < 0.0000001 { v } else { geo_proj_stereographic_vector_scale(v, 1.0 / n) }
}

pub fn geo_proj_stereographic_vector_dist(a : GeoprojstereographicVector, b : GeoprojstereographicVector) -> Double {
  geo_proj_stereographic_vector_norm(geo_proj_stereographic_vector_sub(a, b))
}

pub fn geo_proj_stereographic_vector_to_string(v : GeoprojstereographicVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_proj_stereographic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_proj_stereographic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_proj_stereographic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_proj_stereographic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_proj_stereographic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_proj_stereographic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_proj_stereographic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_proj_stereographic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_proj_stereographic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_proj_stereographic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_proj_stereographic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_proj_stereographic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_proj_stereographic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_proj_stereographic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_proj_stereographic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_proj_stereographic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_proj_stereographic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_proj_stereographic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_proj_stereographic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_proj_stereographic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_proj_stereographic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_proj_stereographic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_proj_stereographic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_proj_stereographic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_proj_stereographic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_proj_stereographic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_proj_stereographic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_proj_stereographic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_proj_stereographic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeoprojstereographicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_frame_make(size : Int) -> GeoprojstereographicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_frame_len(s : GeoprojstereographicFrame) -> Int { s.size }

pub fn geo_proj_stereographic_frame_get(s : GeoprojstereographicFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_frame_set(s : GeoprojstereographicFrame, i : Int, v : Double) -> GeoprojstereographicFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_frame_sum(s : GeoprojstereographicFrame) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_frame_mean(s : GeoprojstereographicFrame) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_frame_scale(s : GeoprojstereographicFrame, f : Double) -> GeoprojstereographicFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_frame_add(a : GeoprojstereographicFrame, b : GeoprojstereographicFrame) -> GeoprojstereographicFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_frame_copy(s : GeoprojstereographicFrame) -> GeoprojstereographicFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_frame_fill(s : GeoprojstereographicFrame, v : Double) -> GeoprojstereographicFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_frame_min(s : GeoprojstereographicFrame) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_frame_max(s : GeoprojstereographicFrame) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_frame_to_string(s : GeoprojstereographicFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_table_make(size : Int) -> GeoprojstereographicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_table_len(s : GeoprojstereographicTable) -> Int { s.size }

pub fn geo_proj_stereographic_table_get(s : GeoprojstereographicTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_table_set(s : GeoprojstereographicTable, i : Int, v : Double) -> GeoprojstereographicTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_table_sum(s : GeoprojstereographicTable) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_table_mean(s : GeoprojstereographicTable) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_table_scale(s : GeoprojstereographicTable, f : Double) -> GeoprojstereographicTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_table_add(a : GeoprojstereographicTable, b : GeoprojstereographicTable) -> GeoprojstereographicTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_table_copy(s : GeoprojstereographicTable) -> GeoprojstereographicTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_table_fill(s : GeoprojstereographicTable, v : Double) -> GeoprojstereographicTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_table_min(s : GeoprojstereographicTable) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_table_max(s : GeoprojstereographicTable) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_table_to_string(s : GeoprojstereographicTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_graphn_make(size : Int) -> GeoprojstereographicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_graphn_len(s : GeoprojstereographicGraphN) -> Int { s.size }

pub fn geo_proj_stereographic_graphn_get(s : GeoprojstereographicGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_graphn_set(s : GeoprojstereographicGraphN, i : Int, v : Double) -> GeoprojstereographicGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_graphn_sum(s : GeoprojstereographicGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_graphn_mean(s : GeoprojstereographicGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_graphn_scale(s : GeoprojstereographicGraphN, f : Double) -> GeoprojstereographicGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_graphn_add(a : GeoprojstereographicGraphN, b : GeoprojstereographicGraphN) -> GeoprojstereographicGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_graphn_copy(s : GeoprojstereographicGraphN) -> GeoprojstereographicGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_graphn_fill(s : GeoprojstereographicGraphN, v : Double) -> GeoprojstereographicGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_graphn_min(s : GeoprojstereographicGraphN) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_graphn_max(s : GeoprojstereographicGraphN) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_graphn_to_string(s : GeoprojstereographicGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_node_make(size : Int) -> GeoprojstereographicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_node_len(s : GeoprojstereographicNode) -> Int { s.size }

pub fn geo_proj_stereographic_node_get(s : GeoprojstereographicNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_node_set(s : GeoprojstereographicNode, i : Int, v : Double) -> GeoprojstereographicNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_node_sum(s : GeoprojstereographicNode) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_node_mean(s : GeoprojstereographicNode) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_node_scale(s : GeoprojstereographicNode, f : Double) -> GeoprojstereographicNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_node_add(a : GeoprojstereographicNode, b : GeoprojstereographicNode) -> GeoprojstereographicNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_node_copy(s : GeoprojstereographicNode) -> GeoprojstereographicNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_node_fill(s : GeoprojstereographicNode, v : Double) -> GeoprojstereographicNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_node_min(s : GeoprojstereographicNode) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_node_max(s : GeoprojstereographicNode) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_node_to_string(s : GeoprojstereographicNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_edge_make(size : Int) -> GeoprojstereographicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_edge_len(s : GeoprojstereographicEdge) -> Int { s.size }

pub fn geo_proj_stereographic_edge_get(s : GeoprojstereographicEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_edge_set(s : GeoprojstereographicEdge, i : Int, v : Double) -> GeoprojstereographicEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_edge_sum(s : GeoprojstereographicEdge) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_edge_mean(s : GeoprojstereographicEdge) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_edge_scale(s : GeoprojstereographicEdge, f : Double) -> GeoprojstereographicEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_edge_add(a : GeoprojstereographicEdge, b : GeoprojstereographicEdge) -> GeoprojstereographicEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_edge_copy(s : GeoprojstereographicEdge) -> GeoprojstereographicEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_edge_fill(s : GeoprojstereographicEdge, v : Double) -> GeoprojstereographicEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_edge_min(s : GeoprojstereographicEdge) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_edge_max(s : GeoprojstereographicEdge) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_edge_to_string(s : GeoprojstereographicEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_path_make(size : Int) -> GeoprojstereographicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_path_len(s : GeoprojstereographicPath) -> Int { s.size }

pub fn geo_proj_stereographic_path_get(s : GeoprojstereographicPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_path_set(s : GeoprojstereographicPath, i : Int, v : Double) -> GeoprojstereographicPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_path_sum(s : GeoprojstereographicPath) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_path_mean(s : GeoprojstereographicPath) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_path_scale(s : GeoprojstereographicPath, f : Double) -> GeoprojstereographicPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_path_add(a : GeoprojstereographicPath, b : GeoprojstereographicPath) -> GeoprojstereographicPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_path_copy(s : GeoprojstereographicPath) -> GeoprojstereographicPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_path_fill(s : GeoprojstereographicPath, v : Double) -> GeoprojstereographicPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_path_min(s : GeoprojstereographicPath) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_path_max(s : GeoprojstereographicPath) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_path_to_string(s : GeoprojstereographicPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_cluster_make(size : Int) -> GeoprojstereographicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_cluster_len(s : GeoprojstereographicCluster) -> Int { s.size }

pub fn geo_proj_stereographic_cluster_get(s : GeoprojstereographicCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_cluster_set(s : GeoprojstereographicCluster, i : Int, v : Double) -> GeoprojstereographicCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_cluster_sum(s : GeoprojstereographicCluster) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_cluster_mean(s : GeoprojstereographicCluster) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_cluster_scale(s : GeoprojstereographicCluster, f : Double) -> GeoprojstereographicCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_cluster_add(a : GeoprojstereographicCluster, b : GeoprojstereographicCluster) -> GeoprojstereographicCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_cluster_copy(s : GeoprojstereographicCluster) -> GeoprojstereographicCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_cluster_fill(s : GeoprojstereographicCluster, v : Double) -> GeoprojstereographicCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_cluster_min(s : GeoprojstereographicCluster) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_cluster_max(s : GeoprojstereographicCluster) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_cluster_to_string(s : GeoprojstereographicCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_model_make(size : Int) -> GeoprojstereographicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_model_len(s : GeoprojstereographicModel) -> Int { s.size }

pub fn geo_proj_stereographic_model_get(s : GeoprojstereographicModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_model_set(s : GeoprojstereographicModel, i : Int, v : Double) -> GeoprojstereographicModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_model_sum(s : GeoprojstereographicModel) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_model_mean(s : GeoprojstereographicModel) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_model_scale(s : GeoprojstereographicModel, f : Double) -> GeoprojstereographicModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_model_add(a : GeoprojstereographicModel, b : GeoprojstereographicModel) -> GeoprojstereographicModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_model_copy(s : GeoprojstereographicModel) -> GeoprojstereographicModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_model_fill(s : GeoprojstereographicModel, v : Double) -> GeoprojstereographicModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_model_min(s : GeoprojstereographicModel) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_model_max(s : GeoprojstereographicModel) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_model_to_string(s : GeoprojstereographicModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_layer_make(size : Int) -> GeoprojstereographicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_layer_len(s : GeoprojstereographicLayer) -> Int { s.size }

pub fn geo_proj_stereographic_layer_get(s : GeoprojstereographicLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_layer_set(s : GeoprojstereographicLayer, i : Int, v : Double) -> GeoprojstereographicLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_layer_sum(s : GeoprojstereographicLayer) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_layer_mean(s : GeoprojstereographicLayer) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_layer_scale(s : GeoprojstereographicLayer, f : Double) -> GeoprojstereographicLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_layer_add(a : GeoprojstereographicLayer, b : GeoprojstereographicLayer) -> GeoprojstereographicLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_layer_copy(s : GeoprojstereographicLayer) -> GeoprojstereographicLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_layer_fill(s : GeoprojstereographicLayer, v : Double) -> GeoprojstereographicLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_layer_min(s : GeoprojstereographicLayer) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_layer_max(s : GeoprojstereographicLayer) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_layer_to_string(s : GeoprojstereographicLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_buffer_make(size : Int) -> GeoprojstereographicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_buffer_len(s : GeoprojstereographicBuffer) -> Int { s.size }

pub fn geo_proj_stereographic_buffer_get(s : GeoprojstereographicBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_buffer_set(s : GeoprojstereographicBuffer, i : Int, v : Double) -> GeoprojstereographicBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_buffer_sum(s : GeoprojstereographicBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_buffer_mean(s : GeoprojstereographicBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_buffer_scale(s : GeoprojstereographicBuffer, f : Double) -> GeoprojstereographicBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_buffer_add(a : GeoprojstereographicBuffer, b : GeoprojstereographicBuffer) -> GeoprojstereographicBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_buffer_copy(s : GeoprojstereographicBuffer) -> GeoprojstereographicBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_buffer_fill(s : GeoprojstereographicBuffer, v : Double) -> GeoprojstereographicBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_buffer_min(s : GeoprojstereographicBuffer) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_buffer_max(s : GeoprojstereographicBuffer) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_buffer_to_string(s : GeoprojstereographicBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_cursor_make(size : Int) -> GeoprojstereographicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_cursor_len(s : GeoprojstereographicCursor) -> Int { s.size }

pub fn geo_proj_stereographic_cursor_get(s : GeoprojstereographicCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_cursor_set(s : GeoprojstereographicCursor, i : Int, v : Double) -> GeoprojstereographicCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_cursor_sum(s : GeoprojstereographicCursor) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_cursor_mean(s : GeoprojstereographicCursor) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_cursor_scale(s : GeoprojstereographicCursor, f : Double) -> GeoprojstereographicCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_cursor_add(a : GeoprojstereographicCursor, b : GeoprojstereographicCursor) -> GeoprojstereographicCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_cursor_copy(s : GeoprojstereographicCursor) -> GeoprojstereographicCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_cursor_fill(s : GeoprojstereographicCursor, v : Double) -> GeoprojstereographicCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_cursor_min(s : GeoprojstereographicCursor) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_cursor_max(s : GeoprojstereographicCursor) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_cursor_to_string(s : GeoprojstereographicCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_view_make(size : Int) -> GeoprojstereographicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_view_len(s : GeoprojstereographicView) -> Int { s.size }

pub fn geo_proj_stereographic_view_get(s : GeoprojstereographicView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_view_set(s : GeoprojstereographicView, i : Int, v : Double) -> GeoprojstereographicView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_view_sum(s : GeoprojstereographicView) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_view_mean(s : GeoprojstereographicView) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_view_scale(s : GeoprojstereographicView, f : Double) -> GeoprojstereographicView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_view_add(a : GeoprojstereographicView, b : GeoprojstereographicView) -> GeoprojstereographicView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_view_copy(s : GeoprojstereographicView) -> GeoprojstereographicView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_view_fill(s : GeoprojstereographicView, v : Double) -> GeoprojstereographicView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_view_min(s : GeoprojstereographicView) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_view_max(s : GeoprojstereographicView) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_view_to_string(s : GeoprojstereographicView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_range_make(size : Int) -> GeoprojstereographicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_range_len(s : GeoprojstereographicRange) -> Int { s.size }

pub fn geo_proj_stereographic_range_get(s : GeoprojstereographicRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_range_set(s : GeoprojstereographicRange, i : Int, v : Double) -> GeoprojstereographicRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_range_sum(s : GeoprojstereographicRange) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_range_mean(s : GeoprojstereographicRange) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_range_scale(s : GeoprojstereographicRange, f : Double) -> GeoprojstereographicRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_range_add(a : GeoprojstereographicRange, b : GeoprojstereographicRange) -> GeoprojstereographicRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_range_copy(s : GeoprojstereographicRange) -> GeoprojstereographicRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_range_fill(s : GeoprojstereographicRange, v : Double) -> GeoprojstereographicRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_range_min(s : GeoprojstereographicRange) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_range_max(s : GeoprojstereographicRange) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_range_to_string(s : GeoprojstereographicRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_slice_make(size : Int) -> GeoprojstereographicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_slice_len(s : GeoprojstereographicSlice) -> Int { s.size }

pub fn geo_proj_stereographic_slice_get(s : GeoprojstereographicSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_slice_set(s : GeoprojstereographicSlice, i : Int, v : Double) -> GeoprojstereographicSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_slice_sum(s : GeoprojstereographicSlice) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_slice_mean(s : GeoprojstereographicSlice) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_slice_scale(s : GeoprojstereographicSlice, f : Double) -> GeoprojstereographicSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_slice_add(a : GeoprojstereographicSlice, b : GeoprojstereographicSlice) -> GeoprojstereographicSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_slice_copy(s : GeoprojstereographicSlice) -> GeoprojstereographicSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_slice_fill(s : GeoprojstereographicSlice, v : Double) -> GeoprojstereographicSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_slice_min(s : GeoprojstereographicSlice) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_slice_max(s : GeoprojstereographicSlice) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_slice_to_string(s : GeoprojstereographicSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

