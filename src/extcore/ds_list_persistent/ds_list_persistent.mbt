///===
/// extcore/ds_list_persistent

pub(all) struct DslistpersistentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_persistent_make_point(x : Double, y : Double) -> DslistpersistentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_persistent_make_point3(x : Double, y : Double, z : Double) -> DslistpersistentPoint {
  { x, y, z, label: 0 }
}

pub fn ds_list_persistent_point_x(pt : DslistpersistentPoint) -> Double { pt.x }

pub fn ds_list_persistent_point_y(pt : DslistpersistentPoint) -> Double { pt.y }

pub fn ds_list_persistent_point_z(pt : DslistpersistentPoint) -> Double { pt.z }

pub fn ds_list_persistent_point_label(pt : DslistpersistentPoint) -> Int { pt.label }

pub fn ds_list_persistent_point_dist(a : DslistpersistentPoint, b : DslistpersistentPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_list_persistent_point_add(a : DslistpersistentPoint, b : DslistpersistentPoint) -> DslistpersistentPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_list_persistent_point_sub(a : DslistpersistentPoint, b : DslistpersistentPoint) -> DslistpersistentPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_list_persistent_point_scale(pt : DslistpersistentPoint, s : Double) -> DslistpersistentPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_list_persistent_point_dot(a : DslistpersistentPoint, b : DslistpersistentPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_list_persistent_point_cross(a : DslistpersistentPoint, b : DslistpersistentPoint) -> DslistpersistentPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_list_persistent_point_norm(pt : DslistpersistentPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_list_persistent_point_normalize(pt : DslistpersistentPoint) -> DslistpersistentPoint {
  let n = ds_list_persistent_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_list_persistent_point_scale(pt, 1.0 / n) }
}

pub fn ds_list_persistent_point_negate(pt : DslistpersistentPoint) -> DslistpersistentPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_list_persistent_point_mid(a : DslistpersistentPoint, b : DslistpersistentPoint) -> DslistpersistentPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_list_persistent_point_lerp(a : DslistpersistentPoint, b : DslistpersistentPoint, t : Double) -> DslistpersistentPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_list_persistent_point_to_string(pt : DslistpersistentPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DslistpersistentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_persistent_make_series(vals : Array[Double], name : String) -> DslistpersistentSeries {
  { vals, name, meta: 0 }
}

pub fn ds_list_persistent_series_len(s : DslistpersistentSeries) -> Int { s.vals.length() }

pub fn ds_list_persistent_series_sum(s : DslistpersistentSeries) -> Double { @_common.sum(s.vals) }

pub fn ds_list_persistent_series_mean(s : DslistpersistentSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_list_persistent_series_min(s : DslistpersistentSeries) -> Double { @_common.min(s.vals) }

pub fn ds_list_persistent_series_max(s : DslistpersistentSeries) -> Double { @_common.max(s.vals) }

pub fn ds_list_persistent_series_range(s : DslistpersistentSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_list_persistent_series_var(s : DslistpersistentSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_list_persistent_series_std(s : DslistpersistentSeries) -> Double { @_common.std(s.vals) }

pub fn ds_list_persistent_series_median(s : DslistpersistentSeries) -> Double { @_common.median(s.vals) }

pub fn ds_list_persistent_series_scale(s : DslistpersistentSeries, f : Double) -> DslistpersistentSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn ds_list_persistent_series_add(a : DslistpersistentSeries, b : DslistpersistentSeries) -> DslistpersistentSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_list_persistent_series_sub(a : DslistpersistentSeries, b : DslistpersistentSeries) -> DslistpersistentSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_list_persistent_series_normalize(s : DslistpersistentSeries) -> DslistpersistentSeries {
  let mn = ds_list_persistent_series_min(s)
  let mx = ds_list_persistent_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_list_persistent_series_cumsum(s : DslistpersistentSeries) -> DslistpersistentSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_list_persistent_series_to_string(s : DslistpersistentSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistpersistentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_persistent_make_matrix(rows : Int, cols : Int, val : Double) -> DslistpersistentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_persistent_matrix_identity(n : Int) -> DslistpersistentMatrix {
  let m = ds_list_persistent_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_list_persistent_matrix_get(m : DslistpersistentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_list_persistent_matrix_transpose(m : DslistpersistentMatrix) -> DslistpersistentMatrix {
  let result = ds_list_persistent_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_list_persistent_matrix_add(a : DslistpersistentMatrix, b : DslistpersistentMatrix) -> DslistpersistentMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_list_persistent_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_list_persistent_matrix_scale(m : DslistpersistentMatrix, s : Double) -> DslistpersistentMatrix {
  let result = ds_list_persistent_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_list_persistent_matrix_multiply(a : DslistpersistentMatrix, b : DslistpersistentMatrix) -> DslistpersistentMatrix {
  if a.cols != b.rows { return ds_list_persistent_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_list_persistent_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_list_persistent_matrix_trace(m : DslistpersistentMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_list_persistent_matrix_det(m : DslistpersistentMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_list_persistent_matrix_norm(m : DslistpersistentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_list_persistent_matrix_to_string(m : DslistpersistentMatrix) -> String {
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

pub(all) struct DslistpersistentVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_persistent_make_vector(comps : Array[Double]) -> DslistpersistentVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_persistent_vector_zero(dim : Int) -> DslistpersistentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_list_persistent_vector_add(a : DslistpersistentVector, b : DslistpersistentVector) -> DslistpersistentVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn ds_list_persistent_vector_sub(a : DslistpersistentVector, b : DslistpersistentVector) -> DslistpersistentVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn ds_list_persistent_vector_scale(v : DslistpersistentVector, s : Double) -> DslistpersistentVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn ds_list_persistent_vector_dot(a : DslistpersistentVector, b : DslistpersistentVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_list_persistent_vector_norm(v : DslistpersistentVector) -> Double { @_common.sqrt(ds_list_persistent_vector_dot(v, v)) }

pub fn ds_list_persistent_vector_normalize(v : DslistpersistentVector) -> DslistpersistentVector {
  let n = ds_list_persistent_vector_norm(v)
  if n < 0.0000001 { v } else { ds_list_persistent_vector_scale(v, 1.0 / n) }
}

pub fn ds_list_persistent_vector_dist(a : DslistpersistentVector, b : DslistpersistentVector) -> Double {
  ds_list_persistent_vector_norm(ds_list_persistent_vector_sub(a, b))
}

pub fn ds_list_persistent_vector_to_string(v : DslistpersistentVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_persistent_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_list_persistent_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_list_persistent_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_list_persistent_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_list_persistent_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_list_persistent_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_list_persistent_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_list_persistent_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_list_persistent_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_list_persistent_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_list_persistent_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_list_persistent_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_list_persistent_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_list_persistent_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_list_persistent_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_list_persistent_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_list_persistent_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_list_persistent_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_list_persistent_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_list_persistent_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_list_persistent_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_list_persistent_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_list_persistent_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_list_persistent_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_list_persistent_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_list_persistent_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_list_persistent_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_list_persistent_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_list_persistent_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DslistpersistentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_frame_make(size : Int) -> DslistpersistentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_frame_len(s : DslistpersistentFrame) -> Int { s.size }

pub fn ds_list_persistent_frame_get(s : DslistpersistentFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_frame_set(s : DslistpersistentFrame, i : Int, v : Double) -> DslistpersistentFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_frame_sum(s : DslistpersistentFrame) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_frame_mean(s : DslistpersistentFrame) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_frame_scale(s : DslistpersistentFrame, f : Double) -> DslistpersistentFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_frame_add(a : DslistpersistentFrame, b : DslistpersistentFrame) -> DslistpersistentFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_frame_copy(s : DslistpersistentFrame) -> DslistpersistentFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_frame_fill(s : DslistpersistentFrame, v : Double) -> DslistpersistentFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_frame_min(s : DslistpersistentFrame) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_frame_max(s : DslistpersistentFrame) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_frame_to_string(s : DslistpersistentFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_table_make(size : Int) -> DslistpersistentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_table_len(s : DslistpersistentTable) -> Int { s.size }

pub fn ds_list_persistent_table_get(s : DslistpersistentTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_table_set(s : DslistpersistentTable, i : Int, v : Double) -> DslistpersistentTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_table_sum(s : DslistpersistentTable) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_table_mean(s : DslistpersistentTable) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_table_scale(s : DslistpersistentTable, f : Double) -> DslistpersistentTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_table_add(a : DslistpersistentTable, b : DslistpersistentTable) -> DslistpersistentTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_table_copy(s : DslistpersistentTable) -> DslistpersistentTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_table_fill(s : DslistpersistentTable, v : Double) -> DslistpersistentTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_table_min(s : DslistpersistentTable) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_table_max(s : DslistpersistentTable) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_table_to_string(s : DslistpersistentTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_graphn_make(size : Int) -> DslistpersistentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_graphn_len(s : DslistpersistentGraphN) -> Int { s.size }

pub fn ds_list_persistent_graphn_get(s : DslistpersistentGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_graphn_set(s : DslistpersistentGraphN, i : Int, v : Double) -> DslistpersistentGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_graphn_sum(s : DslistpersistentGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_graphn_mean(s : DslistpersistentGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_graphn_scale(s : DslistpersistentGraphN, f : Double) -> DslistpersistentGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_graphn_add(a : DslistpersistentGraphN, b : DslistpersistentGraphN) -> DslistpersistentGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_graphn_copy(s : DslistpersistentGraphN) -> DslistpersistentGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_graphn_fill(s : DslistpersistentGraphN, v : Double) -> DslistpersistentGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_graphn_min(s : DslistpersistentGraphN) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_graphn_max(s : DslistpersistentGraphN) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_graphn_to_string(s : DslistpersistentGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_node_make(size : Int) -> DslistpersistentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_node_len(s : DslistpersistentNode) -> Int { s.size }

pub fn ds_list_persistent_node_get(s : DslistpersistentNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_node_set(s : DslistpersistentNode, i : Int, v : Double) -> DslistpersistentNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_node_sum(s : DslistpersistentNode) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_node_mean(s : DslistpersistentNode) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_node_scale(s : DslistpersistentNode, f : Double) -> DslistpersistentNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_node_add(a : DslistpersistentNode, b : DslistpersistentNode) -> DslistpersistentNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_node_copy(s : DslistpersistentNode) -> DslistpersistentNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_node_fill(s : DslistpersistentNode, v : Double) -> DslistpersistentNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_node_min(s : DslistpersistentNode) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_node_max(s : DslistpersistentNode) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_node_to_string(s : DslistpersistentNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_edge_make(size : Int) -> DslistpersistentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_edge_len(s : DslistpersistentEdge) -> Int { s.size }

pub fn ds_list_persistent_edge_get(s : DslistpersistentEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_edge_set(s : DslistpersistentEdge, i : Int, v : Double) -> DslistpersistentEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_edge_sum(s : DslistpersistentEdge) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_edge_mean(s : DslistpersistentEdge) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_edge_scale(s : DslistpersistentEdge, f : Double) -> DslistpersistentEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_edge_add(a : DslistpersistentEdge, b : DslistpersistentEdge) -> DslistpersistentEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_edge_copy(s : DslistpersistentEdge) -> DslistpersistentEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_edge_fill(s : DslistpersistentEdge, v : Double) -> DslistpersistentEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_edge_min(s : DslistpersistentEdge) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_edge_max(s : DslistpersistentEdge) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_edge_to_string(s : DslistpersistentEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_path_make(size : Int) -> DslistpersistentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_path_len(s : DslistpersistentPath) -> Int { s.size }

pub fn ds_list_persistent_path_get(s : DslistpersistentPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_path_set(s : DslistpersistentPath, i : Int, v : Double) -> DslistpersistentPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_path_sum(s : DslistpersistentPath) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_path_mean(s : DslistpersistentPath) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_path_scale(s : DslistpersistentPath, f : Double) -> DslistpersistentPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_path_add(a : DslistpersistentPath, b : DslistpersistentPath) -> DslistpersistentPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_path_copy(s : DslistpersistentPath) -> DslistpersistentPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_path_fill(s : DslistpersistentPath, v : Double) -> DslistpersistentPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_path_min(s : DslistpersistentPath) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_path_max(s : DslistpersistentPath) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_path_to_string(s : DslistpersistentPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_cluster_make(size : Int) -> DslistpersistentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_cluster_len(s : DslistpersistentCluster) -> Int { s.size }

pub fn ds_list_persistent_cluster_get(s : DslistpersistentCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_cluster_set(s : DslistpersistentCluster, i : Int, v : Double) -> DslistpersistentCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_cluster_sum(s : DslistpersistentCluster) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_cluster_mean(s : DslistpersistentCluster) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_cluster_scale(s : DslistpersistentCluster, f : Double) -> DslistpersistentCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_cluster_add(a : DslistpersistentCluster, b : DslistpersistentCluster) -> DslistpersistentCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_cluster_copy(s : DslistpersistentCluster) -> DslistpersistentCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_cluster_fill(s : DslistpersistentCluster, v : Double) -> DslistpersistentCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_cluster_min(s : DslistpersistentCluster) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_cluster_max(s : DslistpersistentCluster) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_cluster_to_string(s : DslistpersistentCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_model_make(size : Int) -> DslistpersistentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_model_len(s : DslistpersistentModel) -> Int { s.size }

pub fn ds_list_persistent_model_get(s : DslistpersistentModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_model_set(s : DslistpersistentModel, i : Int, v : Double) -> DslistpersistentModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_model_sum(s : DslistpersistentModel) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_model_mean(s : DslistpersistentModel) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_model_scale(s : DslistpersistentModel, f : Double) -> DslistpersistentModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_model_add(a : DslistpersistentModel, b : DslistpersistentModel) -> DslistpersistentModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_model_copy(s : DslistpersistentModel) -> DslistpersistentModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_model_fill(s : DslistpersistentModel, v : Double) -> DslistpersistentModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_model_min(s : DslistpersistentModel) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_model_max(s : DslistpersistentModel) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_model_to_string(s : DslistpersistentModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_layer_make(size : Int) -> DslistpersistentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_layer_len(s : DslistpersistentLayer) -> Int { s.size }

pub fn ds_list_persistent_layer_get(s : DslistpersistentLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_layer_set(s : DslistpersistentLayer, i : Int, v : Double) -> DslistpersistentLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_layer_sum(s : DslistpersistentLayer) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_layer_mean(s : DslistpersistentLayer) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_layer_scale(s : DslistpersistentLayer, f : Double) -> DslistpersistentLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_layer_add(a : DslistpersistentLayer, b : DslistpersistentLayer) -> DslistpersistentLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_layer_copy(s : DslistpersistentLayer) -> DslistpersistentLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_layer_fill(s : DslistpersistentLayer, v : Double) -> DslistpersistentLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_layer_min(s : DslistpersistentLayer) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_layer_max(s : DslistpersistentLayer) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_layer_to_string(s : DslistpersistentLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_buffer_make(size : Int) -> DslistpersistentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_buffer_len(s : DslistpersistentBuffer) -> Int { s.size }

pub fn ds_list_persistent_buffer_get(s : DslistpersistentBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_buffer_set(s : DslistpersistentBuffer, i : Int, v : Double) -> DslistpersistentBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_buffer_sum(s : DslistpersistentBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_buffer_mean(s : DslistpersistentBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_buffer_scale(s : DslistpersistentBuffer, f : Double) -> DslistpersistentBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_buffer_add(a : DslistpersistentBuffer, b : DslistpersistentBuffer) -> DslistpersistentBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_buffer_copy(s : DslistpersistentBuffer) -> DslistpersistentBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_buffer_fill(s : DslistpersistentBuffer, v : Double) -> DslistpersistentBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_buffer_min(s : DslistpersistentBuffer) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_buffer_max(s : DslistpersistentBuffer) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_buffer_to_string(s : DslistpersistentBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_cursor_make(size : Int) -> DslistpersistentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_cursor_len(s : DslistpersistentCursor) -> Int { s.size }

pub fn ds_list_persistent_cursor_get(s : DslistpersistentCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_cursor_set(s : DslistpersistentCursor, i : Int, v : Double) -> DslistpersistentCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_cursor_sum(s : DslistpersistentCursor) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_cursor_mean(s : DslistpersistentCursor) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_cursor_scale(s : DslistpersistentCursor, f : Double) -> DslistpersistentCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_cursor_add(a : DslistpersistentCursor, b : DslistpersistentCursor) -> DslistpersistentCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_cursor_copy(s : DslistpersistentCursor) -> DslistpersistentCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_cursor_fill(s : DslistpersistentCursor, v : Double) -> DslistpersistentCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_cursor_min(s : DslistpersistentCursor) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_cursor_max(s : DslistpersistentCursor) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_cursor_to_string(s : DslistpersistentCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_view_make(size : Int) -> DslistpersistentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_view_len(s : DslistpersistentView) -> Int { s.size }

pub fn ds_list_persistent_view_get(s : DslistpersistentView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_view_set(s : DslistpersistentView, i : Int, v : Double) -> DslistpersistentView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_view_sum(s : DslistpersistentView) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_view_mean(s : DslistpersistentView) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_view_scale(s : DslistpersistentView, f : Double) -> DslistpersistentView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_view_add(a : DslistpersistentView, b : DslistpersistentView) -> DslistpersistentView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_view_copy(s : DslistpersistentView) -> DslistpersistentView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_view_fill(s : DslistpersistentView, v : Double) -> DslistpersistentView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_view_min(s : DslistpersistentView) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_view_max(s : DslistpersistentView) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_view_to_string(s : DslistpersistentView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_range_make(size : Int) -> DslistpersistentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_range_len(s : DslistpersistentRange) -> Int { s.size }

pub fn ds_list_persistent_range_get(s : DslistpersistentRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_range_set(s : DslistpersistentRange, i : Int, v : Double) -> DslistpersistentRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_range_sum(s : DslistpersistentRange) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_range_mean(s : DslistpersistentRange) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_range_scale(s : DslistpersistentRange, f : Double) -> DslistpersistentRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_range_add(a : DslistpersistentRange, b : DslistpersistentRange) -> DslistpersistentRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_range_copy(s : DslistpersistentRange) -> DslistpersistentRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_range_fill(s : DslistpersistentRange, v : Double) -> DslistpersistentRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_range_min(s : DslistpersistentRange) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_range_max(s : DslistpersistentRange) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_range_to_string(s : DslistpersistentRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_slice_make(size : Int) -> DslistpersistentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_slice_len(s : DslistpersistentSlice) -> Int { s.size }

pub fn ds_list_persistent_slice_get(s : DslistpersistentSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_slice_set(s : DslistpersistentSlice, i : Int, v : Double) -> DslistpersistentSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_slice_sum(s : DslistpersistentSlice) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_slice_mean(s : DslistpersistentSlice) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_slice_scale(s : DslistpersistentSlice, f : Double) -> DslistpersistentSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_slice_add(a : DslistpersistentSlice, b : DslistpersistentSlice) -> DslistpersistentSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_slice_copy(s : DslistpersistentSlice) -> DslistpersistentSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_slice_fill(s : DslistpersistentSlice, v : Double) -> DslistpersistentSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_slice_min(s : DslistpersistentSlice) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_slice_max(s : DslistpersistentSlice) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_slice_to_string(s : DslistpersistentSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

