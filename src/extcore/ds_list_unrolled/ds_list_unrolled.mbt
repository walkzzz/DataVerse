///===
/// extcore/ds_list_unrolled

pub(all) struct DslistunrolledPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_unrolled_make_point(x : Double, y : Double) -> DslistunrolledPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_unrolled_make_point3(x : Double, y : Double, z : Double) -> DslistunrolledPoint {
  { x, y, z, label: 0 }
}

pub fn ds_list_unrolled_point_x(pt : DslistunrolledPoint) -> Double { pt.x }

pub fn ds_list_unrolled_point_y(pt : DslistunrolledPoint) -> Double { pt.y }

pub fn ds_list_unrolled_point_z(pt : DslistunrolledPoint) -> Double { pt.z }

pub fn ds_list_unrolled_point_label(pt : DslistunrolledPoint) -> Int { pt.label }

pub fn ds_list_unrolled_point_dist(a : DslistunrolledPoint, b : DslistunrolledPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_list_unrolled_point_add(a : DslistunrolledPoint, b : DslistunrolledPoint) -> DslistunrolledPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_list_unrolled_point_sub(a : DslistunrolledPoint, b : DslistunrolledPoint) -> DslistunrolledPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_list_unrolled_point_scale(pt : DslistunrolledPoint, s : Double) -> DslistunrolledPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_list_unrolled_point_dot(a : DslistunrolledPoint, b : DslistunrolledPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_list_unrolled_point_cross(a : DslistunrolledPoint, b : DslistunrolledPoint) -> DslistunrolledPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_list_unrolled_point_norm(pt : DslistunrolledPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_list_unrolled_point_normalize(pt : DslistunrolledPoint) -> DslistunrolledPoint {
  let n = ds_list_unrolled_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_list_unrolled_point_scale(pt, 1.0 / n) }
}

pub fn ds_list_unrolled_point_negate(pt : DslistunrolledPoint) -> DslistunrolledPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_list_unrolled_point_mid(a : DslistunrolledPoint, b : DslistunrolledPoint) -> DslistunrolledPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_list_unrolled_point_lerp(a : DslistunrolledPoint, b : DslistunrolledPoint, t : Double) -> DslistunrolledPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_list_unrolled_point_to_string(pt : DslistunrolledPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DslistunrolledSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_unrolled_make_series(vals : Array[Double], name : String) -> DslistunrolledSeries {
  { vals, name, meta: 0 }
}

pub fn ds_list_unrolled_series_len(s : DslistunrolledSeries) -> Int { s.vals.length() }

pub fn ds_list_unrolled_series_sum(s : DslistunrolledSeries) -> Double { @_common.sum(s.vals) }

pub fn ds_list_unrolled_series_mean(s : DslistunrolledSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_list_unrolled_series_min(s : DslistunrolledSeries) -> Double { @_common.min(s.vals) }

pub fn ds_list_unrolled_series_max(s : DslistunrolledSeries) -> Double { @_common.max(s.vals) }

pub fn ds_list_unrolled_series_range(s : DslistunrolledSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_list_unrolled_series_var(s : DslistunrolledSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_list_unrolled_series_std(s : DslistunrolledSeries) -> Double { @_common.std(s.vals) }

pub fn ds_list_unrolled_series_median(s : DslistunrolledSeries) -> Double { @_common.median(s.vals) }

pub fn ds_list_unrolled_series_scale(s : DslistunrolledSeries, f : Double) -> DslistunrolledSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn ds_list_unrolled_series_add(a : DslistunrolledSeries, b : DslistunrolledSeries) -> DslistunrolledSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_list_unrolled_series_sub(a : DslistunrolledSeries, b : DslistunrolledSeries) -> DslistunrolledSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_list_unrolled_series_normalize(s : DslistunrolledSeries) -> DslistunrolledSeries {
  let mn = ds_list_unrolled_series_min(s)
  let mx = ds_list_unrolled_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_list_unrolled_series_cumsum(s : DslistunrolledSeries) -> DslistunrolledSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_list_unrolled_series_to_string(s : DslistunrolledSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistunrolledMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_unrolled_make_matrix(rows : Int, cols : Int, val : Double) -> DslistunrolledMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_unrolled_matrix_identity(n : Int) -> DslistunrolledMatrix {
  let m = ds_list_unrolled_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_list_unrolled_matrix_get(m : DslistunrolledMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_list_unrolled_matrix_transpose(m : DslistunrolledMatrix) -> DslistunrolledMatrix {
  let result = ds_list_unrolled_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_list_unrolled_matrix_add(a : DslistunrolledMatrix, b : DslistunrolledMatrix) -> DslistunrolledMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_list_unrolled_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_list_unrolled_matrix_scale(m : DslistunrolledMatrix, s : Double) -> DslistunrolledMatrix {
  let result = ds_list_unrolled_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_list_unrolled_matrix_multiply(a : DslistunrolledMatrix, b : DslistunrolledMatrix) -> DslistunrolledMatrix {
  if a.cols != b.rows { return ds_list_unrolled_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_list_unrolled_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_list_unrolled_matrix_trace(m : DslistunrolledMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_list_unrolled_matrix_det(m : DslistunrolledMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_list_unrolled_matrix_norm(m : DslistunrolledMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_list_unrolled_matrix_to_string(m : DslistunrolledMatrix) -> String {
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

pub(all) struct DslistunrolledVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_unrolled_make_vector(comps : Array[Double]) -> DslistunrolledVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_unrolled_vector_zero(dim : Int) -> DslistunrolledVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_list_unrolled_vector_add(a : DslistunrolledVector, b : DslistunrolledVector) -> DslistunrolledVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn ds_list_unrolled_vector_sub(a : DslistunrolledVector, b : DslistunrolledVector) -> DslistunrolledVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn ds_list_unrolled_vector_scale(v : DslistunrolledVector, s : Double) -> DslistunrolledVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn ds_list_unrolled_vector_dot(a : DslistunrolledVector, b : DslistunrolledVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_list_unrolled_vector_norm(v : DslistunrolledVector) -> Double { @_common.sqrt(ds_list_unrolled_vector_dot(v, v)) }

pub fn ds_list_unrolled_vector_normalize(v : DslistunrolledVector) -> DslistunrolledVector {
  let n = ds_list_unrolled_vector_norm(v)
  if n < 0.0000001 { v } else { ds_list_unrolled_vector_scale(v, 1.0 / n) }
}

pub fn ds_list_unrolled_vector_dist(a : DslistunrolledVector, b : DslistunrolledVector) -> Double {
  ds_list_unrolled_vector_norm(ds_list_unrolled_vector_sub(a, b))
}

pub fn ds_list_unrolled_vector_to_string(v : DslistunrolledVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_unrolled_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_list_unrolled_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_list_unrolled_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_list_unrolled_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_list_unrolled_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_list_unrolled_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_list_unrolled_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_list_unrolled_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_list_unrolled_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_list_unrolled_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_list_unrolled_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_list_unrolled_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_list_unrolled_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_list_unrolled_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_list_unrolled_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_list_unrolled_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_list_unrolled_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_list_unrolled_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_list_unrolled_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_list_unrolled_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_list_unrolled_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_list_unrolled_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_list_unrolled_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_list_unrolled_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_list_unrolled_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_list_unrolled_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_list_unrolled_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_list_unrolled_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_list_unrolled_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DslistunrolledFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_frame_make(size : Int) -> DslistunrolledFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_frame_len(s : DslistunrolledFrame) -> Int { s.size }

pub fn ds_list_unrolled_frame_get(s : DslistunrolledFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_frame_set(s : DslistunrolledFrame, i : Int, v : Double) -> DslistunrolledFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_frame_sum(s : DslistunrolledFrame) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_frame_mean(s : DslistunrolledFrame) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_frame_scale(s : DslistunrolledFrame, f : Double) -> DslistunrolledFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_frame_add(a : DslistunrolledFrame, b : DslistunrolledFrame) -> DslistunrolledFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_frame_copy(s : DslistunrolledFrame) -> DslistunrolledFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_frame_fill(s : DslistunrolledFrame, v : Double) -> DslistunrolledFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_frame_min(s : DslistunrolledFrame) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_frame_max(s : DslistunrolledFrame) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_frame_to_string(s : DslistunrolledFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_table_make(size : Int) -> DslistunrolledTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_table_len(s : DslistunrolledTable) -> Int { s.size }

pub fn ds_list_unrolled_table_get(s : DslistunrolledTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_table_set(s : DslistunrolledTable, i : Int, v : Double) -> DslistunrolledTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_table_sum(s : DslistunrolledTable) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_table_mean(s : DslistunrolledTable) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_table_scale(s : DslistunrolledTable, f : Double) -> DslistunrolledTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_table_add(a : DslistunrolledTable, b : DslistunrolledTable) -> DslistunrolledTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_table_copy(s : DslistunrolledTable) -> DslistunrolledTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_table_fill(s : DslistunrolledTable, v : Double) -> DslistunrolledTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_table_min(s : DslistunrolledTable) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_table_max(s : DslistunrolledTable) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_table_to_string(s : DslistunrolledTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_graphn_make(size : Int) -> DslistunrolledGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_graphn_len(s : DslistunrolledGraphN) -> Int { s.size }

pub fn ds_list_unrolled_graphn_get(s : DslistunrolledGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_graphn_set(s : DslistunrolledGraphN, i : Int, v : Double) -> DslistunrolledGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_graphn_sum(s : DslistunrolledGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_graphn_mean(s : DslistunrolledGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_graphn_scale(s : DslistunrolledGraphN, f : Double) -> DslistunrolledGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_graphn_add(a : DslistunrolledGraphN, b : DslistunrolledGraphN) -> DslistunrolledGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_graphn_copy(s : DslistunrolledGraphN) -> DslistunrolledGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_graphn_fill(s : DslistunrolledGraphN, v : Double) -> DslistunrolledGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_graphn_min(s : DslistunrolledGraphN) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_graphn_max(s : DslistunrolledGraphN) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_graphn_to_string(s : DslistunrolledGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_node_make(size : Int) -> DslistunrolledNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_node_len(s : DslistunrolledNode) -> Int { s.size }

pub fn ds_list_unrolled_node_get(s : DslistunrolledNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_node_set(s : DslistunrolledNode, i : Int, v : Double) -> DslistunrolledNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_node_sum(s : DslistunrolledNode) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_node_mean(s : DslistunrolledNode) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_node_scale(s : DslistunrolledNode, f : Double) -> DslistunrolledNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_node_add(a : DslistunrolledNode, b : DslistunrolledNode) -> DslistunrolledNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_node_copy(s : DslistunrolledNode) -> DslistunrolledNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_node_fill(s : DslistunrolledNode, v : Double) -> DslistunrolledNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_node_min(s : DslistunrolledNode) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_node_max(s : DslistunrolledNode) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_node_to_string(s : DslistunrolledNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_edge_make(size : Int) -> DslistunrolledEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_edge_len(s : DslistunrolledEdge) -> Int { s.size }

pub fn ds_list_unrolled_edge_get(s : DslistunrolledEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_edge_set(s : DslistunrolledEdge, i : Int, v : Double) -> DslistunrolledEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_edge_sum(s : DslistunrolledEdge) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_edge_mean(s : DslistunrolledEdge) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_edge_scale(s : DslistunrolledEdge, f : Double) -> DslistunrolledEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_edge_add(a : DslistunrolledEdge, b : DslistunrolledEdge) -> DslistunrolledEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_edge_copy(s : DslistunrolledEdge) -> DslistunrolledEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_edge_fill(s : DslistunrolledEdge, v : Double) -> DslistunrolledEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_edge_min(s : DslistunrolledEdge) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_edge_max(s : DslistunrolledEdge) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_edge_to_string(s : DslistunrolledEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_path_make(size : Int) -> DslistunrolledPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_path_len(s : DslistunrolledPath) -> Int { s.size }

pub fn ds_list_unrolled_path_get(s : DslistunrolledPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_path_set(s : DslistunrolledPath, i : Int, v : Double) -> DslistunrolledPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_path_sum(s : DslistunrolledPath) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_path_mean(s : DslistunrolledPath) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_path_scale(s : DslistunrolledPath, f : Double) -> DslistunrolledPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_path_add(a : DslistunrolledPath, b : DslistunrolledPath) -> DslistunrolledPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_path_copy(s : DslistunrolledPath) -> DslistunrolledPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_path_fill(s : DslistunrolledPath, v : Double) -> DslistunrolledPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_path_min(s : DslistunrolledPath) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_path_max(s : DslistunrolledPath) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_path_to_string(s : DslistunrolledPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_cluster_make(size : Int) -> DslistunrolledCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_cluster_len(s : DslistunrolledCluster) -> Int { s.size }

pub fn ds_list_unrolled_cluster_get(s : DslistunrolledCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_cluster_set(s : DslistunrolledCluster, i : Int, v : Double) -> DslistunrolledCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_cluster_sum(s : DslistunrolledCluster) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_cluster_mean(s : DslistunrolledCluster) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_cluster_scale(s : DslistunrolledCluster, f : Double) -> DslistunrolledCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_cluster_add(a : DslistunrolledCluster, b : DslistunrolledCluster) -> DslistunrolledCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_cluster_copy(s : DslistunrolledCluster) -> DslistunrolledCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_cluster_fill(s : DslistunrolledCluster, v : Double) -> DslistunrolledCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_cluster_min(s : DslistunrolledCluster) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_cluster_max(s : DslistunrolledCluster) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_cluster_to_string(s : DslistunrolledCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_model_make(size : Int) -> DslistunrolledModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_model_len(s : DslistunrolledModel) -> Int { s.size }

pub fn ds_list_unrolled_model_get(s : DslistunrolledModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_model_set(s : DslistunrolledModel, i : Int, v : Double) -> DslistunrolledModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_model_sum(s : DslistunrolledModel) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_model_mean(s : DslistunrolledModel) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_model_scale(s : DslistunrolledModel, f : Double) -> DslistunrolledModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_model_add(a : DslistunrolledModel, b : DslistunrolledModel) -> DslistunrolledModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_model_copy(s : DslistunrolledModel) -> DslistunrolledModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_model_fill(s : DslistunrolledModel, v : Double) -> DslistunrolledModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_model_min(s : DslistunrolledModel) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_model_max(s : DslistunrolledModel) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_model_to_string(s : DslistunrolledModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_layer_make(size : Int) -> DslistunrolledLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_layer_len(s : DslistunrolledLayer) -> Int { s.size }

pub fn ds_list_unrolled_layer_get(s : DslistunrolledLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_layer_set(s : DslistunrolledLayer, i : Int, v : Double) -> DslistunrolledLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_layer_sum(s : DslistunrolledLayer) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_layer_mean(s : DslistunrolledLayer) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_layer_scale(s : DslistunrolledLayer, f : Double) -> DslistunrolledLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_layer_add(a : DslistunrolledLayer, b : DslistunrolledLayer) -> DslistunrolledLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_layer_copy(s : DslistunrolledLayer) -> DslistunrolledLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_layer_fill(s : DslistunrolledLayer, v : Double) -> DslistunrolledLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_layer_min(s : DslistunrolledLayer) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_layer_max(s : DslistunrolledLayer) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_layer_to_string(s : DslistunrolledLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_buffer_make(size : Int) -> DslistunrolledBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_buffer_len(s : DslistunrolledBuffer) -> Int { s.size }

pub fn ds_list_unrolled_buffer_get(s : DslistunrolledBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_buffer_set(s : DslistunrolledBuffer, i : Int, v : Double) -> DslistunrolledBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_buffer_sum(s : DslistunrolledBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_buffer_mean(s : DslistunrolledBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_buffer_scale(s : DslistunrolledBuffer, f : Double) -> DslistunrolledBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_buffer_add(a : DslistunrolledBuffer, b : DslistunrolledBuffer) -> DslistunrolledBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_buffer_copy(s : DslistunrolledBuffer) -> DslistunrolledBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_buffer_fill(s : DslistunrolledBuffer, v : Double) -> DslistunrolledBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_buffer_min(s : DslistunrolledBuffer) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_buffer_max(s : DslistunrolledBuffer) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_buffer_to_string(s : DslistunrolledBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_cursor_make(size : Int) -> DslistunrolledCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_cursor_len(s : DslistunrolledCursor) -> Int { s.size }

pub fn ds_list_unrolled_cursor_get(s : DslistunrolledCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_cursor_set(s : DslistunrolledCursor, i : Int, v : Double) -> DslistunrolledCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_cursor_sum(s : DslistunrolledCursor) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_cursor_mean(s : DslistunrolledCursor) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_cursor_scale(s : DslistunrolledCursor, f : Double) -> DslistunrolledCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_cursor_add(a : DslistunrolledCursor, b : DslistunrolledCursor) -> DslistunrolledCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_cursor_copy(s : DslistunrolledCursor) -> DslistunrolledCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_cursor_fill(s : DslistunrolledCursor, v : Double) -> DslistunrolledCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_cursor_min(s : DslistunrolledCursor) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_cursor_max(s : DslistunrolledCursor) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_cursor_to_string(s : DslistunrolledCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_view_make(size : Int) -> DslistunrolledView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_view_len(s : DslistunrolledView) -> Int { s.size }

pub fn ds_list_unrolled_view_get(s : DslistunrolledView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_view_set(s : DslistunrolledView, i : Int, v : Double) -> DslistunrolledView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_view_sum(s : DslistunrolledView) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_view_mean(s : DslistunrolledView) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_view_scale(s : DslistunrolledView, f : Double) -> DslistunrolledView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_view_add(a : DslistunrolledView, b : DslistunrolledView) -> DslistunrolledView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_view_copy(s : DslistunrolledView) -> DslistunrolledView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_view_fill(s : DslistunrolledView, v : Double) -> DslistunrolledView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_view_min(s : DslistunrolledView) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_view_max(s : DslistunrolledView) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_view_to_string(s : DslistunrolledView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_range_make(size : Int) -> DslistunrolledRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_range_len(s : DslistunrolledRange) -> Int { s.size }

pub fn ds_list_unrolled_range_get(s : DslistunrolledRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_range_set(s : DslistunrolledRange, i : Int, v : Double) -> DslistunrolledRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_range_sum(s : DslistunrolledRange) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_range_mean(s : DslistunrolledRange) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_range_scale(s : DslistunrolledRange, f : Double) -> DslistunrolledRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_range_add(a : DslistunrolledRange, b : DslistunrolledRange) -> DslistunrolledRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_range_copy(s : DslistunrolledRange) -> DslistunrolledRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_range_fill(s : DslistunrolledRange, v : Double) -> DslistunrolledRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_range_min(s : DslistunrolledRange) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_range_max(s : DslistunrolledRange) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_range_to_string(s : DslistunrolledRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_slice_make(size : Int) -> DslistunrolledSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_slice_len(s : DslistunrolledSlice) -> Int { s.size }

pub fn ds_list_unrolled_slice_get(s : DslistunrolledSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_slice_set(s : DslistunrolledSlice, i : Int, v : Double) -> DslistunrolledSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_slice_sum(s : DslistunrolledSlice) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_slice_mean(s : DslistunrolledSlice) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_slice_scale(s : DslistunrolledSlice, f : Double) -> DslistunrolledSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_slice_add(a : DslistunrolledSlice, b : DslistunrolledSlice) -> DslistunrolledSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_slice_copy(s : DslistunrolledSlice) -> DslistunrolledSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_slice_fill(s : DslistunrolledSlice, v : Double) -> DslistunrolledSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_slice_min(s : DslistunrolledSlice) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_slice_max(s : DslistunrolledSlice) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_slice_to_string(s : DslistunrolledSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

