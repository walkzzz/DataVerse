///===
/// extcore/ds_list_lockfree

pub(all) struct DslistlockfreePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_lockfree_make_point(x : Double, y : Double) -> DslistlockfreePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_lockfree_make_point3(x : Double, y : Double, z : Double) -> DslistlockfreePoint {
  { x, y, z, label: 0 }
}

pub fn ds_list_lockfree_point_x(pt : DslistlockfreePoint) -> Double { pt.x }

pub fn ds_list_lockfree_point_y(pt : DslistlockfreePoint) -> Double { pt.y }

pub fn ds_list_lockfree_point_z(pt : DslistlockfreePoint) -> Double { pt.z }

pub fn ds_list_lockfree_point_label(pt : DslistlockfreePoint) -> Int { pt.label }

pub fn ds_list_lockfree_point_dist(a : DslistlockfreePoint, b : DslistlockfreePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_list_lockfree_point_add(a : DslistlockfreePoint, b : DslistlockfreePoint) -> DslistlockfreePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_list_lockfree_point_sub(a : DslistlockfreePoint, b : DslistlockfreePoint) -> DslistlockfreePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_list_lockfree_point_scale(pt : DslistlockfreePoint, s : Double) -> DslistlockfreePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_list_lockfree_point_dot(a : DslistlockfreePoint, b : DslistlockfreePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_list_lockfree_point_cross(a : DslistlockfreePoint, b : DslistlockfreePoint) -> DslistlockfreePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_list_lockfree_point_norm(pt : DslistlockfreePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_list_lockfree_point_normalize(pt : DslistlockfreePoint) -> DslistlockfreePoint {
  let n = ds_list_lockfree_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_list_lockfree_point_scale(pt, 1.0 / n) }
}

pub fn ds_list_lockfree_point_negate(pt : DslistlockfreePoint) -> DslistlockfreePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_list_lockfree_point_mid(a : DslistlockfreePoint, b : DslistlockfreePoint) -> DslistlockfreePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_list_lockfree_point_lerp(a : DslistlockfreePoint, b : DslistlockfreePoint, t : Double) -> DslistlockfreePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_list_lockfree_point_to_string(pt : DslistlockfreePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DslistlockfreeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_lockfree_make_series(vals : Array[Double], name : String) -> DslistlockfreeSeries {
  { vals, name, meta: 0 }
}

pub fn ds_list_lockfree_series_len(s : DslistlockfreeSeries) -> Int { s.vals.length() }

pub fn ds_list_lockfree_series_sum(s : DslistlockfreeSeries) -> Double { @_common.sum(s.vals) }

pub fn ds_list_lockfree_series_mean(s : DslistlockfreeSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_list_lockfree_series_min(s : DslistlockfreeSeries) -> Double { @_common.min(s.vals) }

pub fn ds_list_lockfree_series_max(s : DslistlockfreeSeries) -> Double { @_common.max(s.vals) }

pub fn ds_list_lockfree_series_range(s : DslistlockfreeSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_list_lockfree_series_var(s : DslistlockfreeSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_list_lockfree_series_std(s : DslistlockfreeSeries) -> Double { @_common.std(s.vals) }

pub fn ds_list_lockfree_series_median(s : DslistlockfreeSeries) -> Double { @_common.median(s.vals) }

pub fn ds_list_lockfree_series_scale(s : DslistlockfreeSeries, f : Double) -> DslistlockfreeSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn ds_list_lockfree_series_add(a : DslistlockfreeSeries, b : DslistlockfreeSeries) -> DslistlockfreeSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_list_lockfree_series_sub(a : DslistlockfreeSeries, b : DslistlockfreeSeries) -> DslistlockfreeSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_list_lockfree_series_normalize(s : DslistlockfreeSeries) -> DslistlockfreeSeries {
  let mn = ds_list_lockfree_series_min(s)
  let mx = ds_list_lockfree_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_list_lockfree_series_cumsum(s : DslistlockfreeSeries) -> DslistlockfreeSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_list_lockfree_series_to_string(s : DslistlockfreeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistlockfreeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_lockfree_make_matrix(rows : Int, cols : Int, val : Double) -> DslistlockfreeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_lockfree_matrix_identity(n : Int) -> DslistlockfreeMatrix {
  let m = ds_list_lockfree_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_list_lockfree_matrix_get(m : DslistlockfreeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_list_lockfree_matrix_transpose(m : DslistlockfreeMatrix) -> DslistlockfreeMatrix {
  let result = ds_list_lockfree_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_list_lockfree_matrix_add(a : DslistlockfreeMatrix, b : DslistlockfreeMatrix) -> DslistlockfreeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_list_lockfree_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_list_lockfree_matrix_scale(m : DslistlockfreeMatrix, s : Double) -> DslistlockfreeMatrix {
  let result = ds_list_lockfree_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_list_lockfree_matrix_multiply(a : DslistlockfreeMatrix, b : DslistlockfreeMatrix) -> DslistlockfreeMatrix {
  if a.cols != b.rows { return ds_list_lockfree_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_list_lockfree_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_list_lockfree_matrix_trace(m : DslistlockfreeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_list_lockfree_matrix_det(m : DslistlockfreeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_list_lockfree_matrix_norm(m : DslistlockfreeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_list_lockfree_matrix_to_string(m : DslistlockfreeMatrix) -> String {
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

pub(all) struct DslistlockfreeVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_lockfree_make_vector(comps : Array[Double]) -> DslistlockfreeVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_lockfree_vector_zero(dim : Int) -> DslistlockfreeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_list_lockfree_vector_add(a : DslistlockfreeVector, b : DslistlockfreeVector) -> DslistlockfreeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn ds_list_lockfree_vector_sub(a : DslistlockfreeVector, b : DslistlockfreeVector) -> DslistlockfreeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn ds_list_lockfree_vector_scale(v : DslistlockfreeVector, s : Double) -> DslistlockfreeVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn ds_list_lockfree_vector_dot(a : DslistlockfreeVector, b : DslistlockfreeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_list_lockfree_vector_norm(v : DslistlockfreeVector) -> Double { @_common.sqrt(ds_list_lockfree_vector_dot(v, v)) }

pub fn ds_list_lockfree_vector_normalize(v : DslistlockfreeVector) -> DslistlockfreeVector {
  let n = ds_list_lockfree_vector_norm(v)
  if n < 0.0000001 { v } else { ds_list_lockfree_vector_scale(v, 1.0 / n) }
}

pub fn ds_list_lockfree_vector_dist(a : DslistlockfreeVector, b : DslistlockfreeVector) -> Double {
  ds_list_lockfree_vector_norm(ds_list_lockfree_vector_sub(a, b))
}

pub fn ds_list_lockfree_vector_to_string(v : DslistlockfreeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_lockfree_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_list_lockfree_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_list_lockfree_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_list_lockfree_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_list_lockfree_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_list_lockfree_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_list_lockfree_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_list_lockfree_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_list_lockfree_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_list_lockfree_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_list_lockfree_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_list_lockfree_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_list_lockfree_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_list_lockfree_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_list_lockfree_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_list_lockfree_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_list_lockfree_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_list_lockfree_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_list_lockfree_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_list_lockfree_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_list_lockfree_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_list_lockfree_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_list_lockfree_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_list_lockfree_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_list_lockfree_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_list_lockfree_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_list_lockfree_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_list_lockfree_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_list_lockfree_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DslistlockfreeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_frame_make(size : Int) -> DslistlockfreeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_lockfree_frame_len(s : DslistlockfreeFrame) -> Int { s.size }

pub fn ds_list_lockfree_frame_get(s : DslistlockfreeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_lockfree_frame_set(s : DslistlockfreeFrame, i : Int, v : Double) -> DslistlockfreeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_frame_sum(s : DslistlockfreeFrame) -> Double { @_common.sum(s.data) }

pub fn ds_list_lockfree_frame_mean(s : DslistlockfreeFrame) -> Double { @_common.mean(s.data) }

pub fn ds_list_lockfree_frame_scale(s : DslistlockfreeFrame, f : Double) -> DslistlockfreeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_frame_add(a : DslistlockfreeFrame, b : DslistlockfreeFrame) -> DslistlockfreeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_lockfree_frame_copy(s : DslistlockfreeFrame) -> DslistlockfreeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_frame_fill(s : DslistlockfreeFrame, v : Double) -> DslistlockfreeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_frame_min(s : DslistlockfreeFrame) -> Double { @_common.min(s.data) }

pub fn ds_list_lockfree_frame_max(s : DslistlockfreeFrame) -> Double { @_common.max(s.data) }

pub fn ds_list_lockfree_frame_to_string(s : DslistlockfreeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistlockfreeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_table_make(size : Int) -> DslistlockfreeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_lockfree_table_len(s : DslistlockfreeTable) -> Int { s.size }

pub fn ds_list_lockfree_table_get(s : DslistlockfreeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_lockfree_table_set(s : DslistlockfreeTable, i : Int, v : Double) -> DslistlockfreeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_table_sum(s : DslistlockfreeTable) -> Double { @_common.sum(s.data) }

pub fn ds_list_lockfree_table_mean(s : DslistlockfreeTable) -> Double { @_common.mean(s.data) }

pub fn ds_list_lockfree_table_scale(s : DslistlockfreeTable, f : Double) -> DslistlockfreeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_table_add(a : DslistlockfreeTable, b : DslistlockfreeTable) -> DslistlockfreeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_lockfree_table_copy(s : DslistlockfreeTable) -> DslistlockfreeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_table_fill(s : DslistlockfreeTable, v : Double) -> DslistlockfreeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_table_min(s : DslistlockfreeTable) -> Double { @_common.min(s.data) }

pub fn ds_list_lockfree_table_max(s : DslistlockfreeTable) -> Double { @_common.max(s.data) }

pub fn ds_list_lockfree_table_to_string(s : DslistlockfreeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistlockfreeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_graphn_make(size : Int) -> DslistlockfreeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_lockfree_graphn_len(s : DslistlockfreeGraphN) -> Int { s.size }

pub fn ds_list_lockfree_graphn_get(s : DslistlockfreeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_lockfree_graphn_set(s : DslistlockfreeGraphN, i : Int, v : Double) -> DslistlockfreeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_graphn_sum(s : DslistlockfreeGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_list_lockfree_graphn_mean(s : DslistlockfreeGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_list_lockfree_graphn_scale(s : DslistlockfreeGraphN, f : Double) -> DslistlockfreeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_graphn_add(a : DslistlockfreeGraphN, b : DslistlockfreeGraphN) -> DslistlockfreeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_lockfree_graphn_copy(s : DslistlockfreeGraphN) -> DslistlockfreeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_graphn_fill(s : DslistlockfreeGraphN, v : Double) -> DslistlockfreeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_graphn_min(s : DslistlockfreeGraphN) -> Double { @_common.min(s.data) }

pub fn ds_list_lockfree_graphn_max(s : DslistlockfreeGraphN) -> Double { @_common.max(s.data) }

pub fn ds_list_lockfree_graphn_to_string(s : DslistlockfreeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistlockfreeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_node_make(size : Int) -> DslistlockfreeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_lockfree_node_len(s : DslistlockfreeNode) -> Int { s.size }

pub fn ds_list_lockfree_node_get(s : DslistlockfreeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_lockfree_node_set(s : DslistlockfreeNode, i : Int, v : Double) -> DslistlockfreeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_node_sum(s : DslistlockfreeNode) -> Double { @_common.sum(s.data) }

pub fn ds_list_lockfree_node_mean(s : DslistlockfreeNode) -> Double { @_common.mean(s.data) }

pub fn ds_list_lockfree_node_scale(s : DslistlockfreeNode, f : Double) -> DslistlockfreeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_node_add(a : DslistlockfreeNode, b : DslistlockfreeNode) -> DslistlockfreeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_lockfree_node_copy(s : DslistlockfreeNode) -> DslistlockfreeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_node_fill(s : DslistlockfreeNode, v : Double) -> DslistlockfreeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_node_min(s : DslistlockfreeNode) -> Double { @_common.min(s.data) }

pub fn ds_list_lockfree_node_max(s : DslistlockfreeNode) -> Double { @_common.max(s.data) }

pub fn ds_list_lockfree_node_to_string(s : DslistlockfreeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistlockfreeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_edge_make(size : Int) -> DslistlockfreeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_lockfree_edge_len(s : DslistlockfreeEdge) -> Int { s.size }

pub fn ds_list_lockfree_edge_get(s : DslistlockfreeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_lockfree_edge_set(s : DslistlockfreeEdge, i : Int, v : Double) -> DslistlockfreeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_edge_sum(s : DslistlockfreeEdge) -> Double { @_common.sum(s.data) }

pub fn ds_list_lockfree_edge_mean(s : DslistlockfreeEdge) -> Double { @_common.mean(s.data) }

pub fn ds_list_lockfree_edge_scale(s : DslistlockfreeEdge, f : Double) -> DslistlockfreeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_edge_add(a : DslistlockfreeEdge, b : DslistlockfreeEdge) -> DslistlockfreeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_lockfree_edge_copy(s : DslistlockfreeEdge) -> DslistlockfreeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_edge_fill(s : DslistlockfreeEdge, v : Double) -> DslistlockfreeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_edge_min(s : DslistlockfreeEdge) -> Double { @_common.min(s.data) }

pub fn ds_list_lockfree_edge_max(s : DslistlockfreeEdge) -> Double { @_common.max(s.data) }

pub fn ds_list_lockfree_edge_to_string(s : DslistlockfreeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistlockfreePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_path_make(size : Int) -> DslistlockfreePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_lockfree_path_len(s : DslistlockfreePath) -> Int { s.size }

pub fn ds_list_lockfree_path_get(s : DslistlockfreePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_lockfree_path_set(s : DslistlockfreePath, i : Int, v : Double) -> DslistlockfreePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_path_sum(s : DslistlockfreePath) -> Double { @_common.sum(s.data) }

pub fn ds_list_lockfree_path_mean(s : DslistlockfreePath) -> Double { @_common.mean(s.data) }

pub fn ds_list_lockfree_path_scale(s : DslistlockfreePath, f : Double) -> DslistlockfreePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_path_add(a : DslistlockfreePath, b : DslistlockfreePath) -> DslistlockfreePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_lockfree_path_copy(s : DslistlockfreePath) -> DslistlockfreePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_path_fill(s : DslistlockfreePath, v : Double) -> DslistlockfreePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_path_min(s : DslistlockfreePath) -> Double { @_common.min(s.data) }

pub fn ds_list_lockfree_path_max(s : DslistlockfreePath) -> Double { @_common.max(s.data) }

pub fn ds_list_lockfree_path_to_string(s : DslistlockfreePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistlockfreeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_cluster_make(size : Int) -> DslistlockfreeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_lockfree_cluster_len(s : DslistlockfreeCluster) -> Int { s.size }

pub fn ds_list_lockfree_cluster_get(s : DslistlockfreeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_lockfree_cluster_set(s : DslistlockfreeCluster, i : Int, v : Double) -> DslistlockfreeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_cluster_sum(s : DslistlockfreeCluster) -> Double { @_common.sum(s.data) }

pub fn ds_list_lockfree_cluster_mean(s : DslistlockfreeCluster) -> Double { @_common.mean(s.data) }

pub fn ds_list_lockfree_cluster_scale(s : DslistlockfreeCluster, f : Double) -> DslistlockfreeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_cluster_add(a : DslistlockfreeCluster, b : DslistlockfreeCluster) -> DslistlockfreeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_lockfree_cluster_copy(s : DslistlockfreeCluster) -> DslistlockfreeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_cluster_fill(s : DslistlockfreeCluster, v : Double) -> DslistlockfreeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_cluster_min(s : DslistlockfreeCluster) -> Double { @_common.min(s.data) }

pub fn ds_list_lockfree_cluster_max(s : DslistlockfreeCluster) -> Double { @_common.max(s.data) }

pub fn ds_list_lockfree_cluster_to_string(s : DslistlockfreeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistlockfreeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_model_make(size : Int) -> DslistlockfreeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_lockfree_model_len(s : DslistlockfreeModel) -> Int { s.size }

pub fn ds_list_lockfree_model_get(s : DslistlockfreeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_lockfree_model_set(s : DslistlockfreeModel, i : Int, v : Double) -> DslistlockfreeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_model_sum(s : DslistlockfreeModel) -> Double { @_common.sum(s.data) }

pub fn ds_list_lockfree_model_mean(s : DslistlockfreeModel) -> Double { @_common.mean(s.data) }

pub fn ds_list_lockfree_model_scale(s : DslistlockfreeModel, f : Double) -> DslistlockfreeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_model_add(a : DslistlockfreeModel, b : DslistlockfreeModel) -> DslistlockfreeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_lockfree_model_copy(s : DslistlockfreeModel) -> DslistlockfreeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_model_fill(s : DslistlockfreeModel, v : Double) -> DslistlockfreeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_model_min(s : DslistlockfreeModel) -> Double { @_common.min(s.data) }

pub fn ds_list_lockfree_model_max(s : DslistlockfreeModel) -> Double { @_common.max(s.data) }

pub fn ds_list_lockfree_model_to_string(s : DslistlockfreeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistlockfreeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_layer_make(size : Int) -> DslistlockfreeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_lockfree_layer_len(s : DslistlockfreeLayer) -> Int { s.size }

pub fn ds_list_lockfree_layer_get(s : DslistlockfreeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_lockfree_layer_set(s : DslistlockfreeLayer, i : Int, v : Double) -> DslistlockfreeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_layer_sum(s : DslistlockfreeLayer) -> Double { @_common.sum(s.data) }

pub fn ds_list_lockfree_layer_mean(s : DslistlockfreeLayer) -> Double { @_common.mean(s.data) }

pub fn ds_list_lockfree_layer_scale(s : DslistlockfreeLayer, f : Double) -> DslistlockfreeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_layer_add(a : DslistlockfreeLayer, b : DslistlockfreeLayer) -> DslistlockfreeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_lockfree_layer_copy(s : DslistlockfreeLayer) -> DslistlockfreeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_layer_fill(s : DslistlockfreeLayer, v : Double) -> DslistlockfreeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_layer_min(s : DslistlockfreeLayer) -> Double { @_common.min(s.data) }

pub fn ds_list_lockfree_layer_max(s : DslistlockfreeLayer) -> Double { @_common.max(s.data) }

pub fn ds_list_lockfree_layer_to_string(s : DslistlockfreeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistlockfreeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_buffer_make(size : Int) -> DslistlockfreeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_lockfree_buffer_len(s : DslistlockfreeBuffer) -> Int { s.size }

pub fn ds_list_lockfree_buffer_get(s : DslistlockfreeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_lockfree_buffer_set(s : DslistlockfreeBuffer, i : Int, v : Double) -> DslistlockfreeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_buffer_sum(s : DslistlockfreeBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_list_lockfree_buffer_mean(s : DslistlockfreeBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_list_lockfree_buffer_scale(s : DslistlockfreeBuffer, f : Double) -> DslistlockfreeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_buffer_add(a : DslistlockfreeBuffer, b : DslistlockfreeBuffer) -> DslistlockfreeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_lockfree_buffer_copy(s : DslistlockfreeBuffer) -> DslistlockfreeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_buffer_fill(s : DslistlockfreeBuffer, v : Double) -> DslistlockfreeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_buffer_min(s : DslistlockfreeBuffer) -> Double { @_common.min(s.data) }

pub fn ds_list_lockfree_buffer_max(s : DslistlockfreeBuffer) -> Double { @_common.max(s.data) }

pub fn ds_list_lockfree_buffer_to_string(s : DslistlockfreeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistlockfreeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_cursor_make(size : Int) -> DslistlockfreeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_lockfree_cursor_len(s : DslistlockfreeCursor) -> Int { s.size }

pub fn ds_list_lockfree_cursor_get(s : DslistlockfreeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_lockfree_cursor_set(s : DslistlockfreeCursor, i : Int, v : Double) -> DslistlockfreeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_cursor_sum(s : DslistlockfreeCursor) -> Double { @_common.sum(s.data) }

pub fn ds_list_lockfree_cursor_mean(s : DslistlockfreeCursor) -> Double { @_common.mean(s.data) }

pub fn ds_list_lockfree_cursor_scale(s : DslistlockfreeCursor, f : Double) -> DslistlockfreeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_cursor_add(a : DslistlockfreeCursor, b : DslistlockfreeCursor) -> DslistlockfreeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_lockfree_cursor_copy(s : DslistlockfreeCursor) -> DslistlockfreeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_cursor_fill(s : DslistlockfreeCursor, v : Double) -> DslistlockfreeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_cursor_min(s : DslistlockfreeCursor) -> Double { @_common.min(s.data) }

pub fn ds_list_lockfree_cursor_max(s : DslistlockfreeCursor) -> Double { @_common.max(s.data) }

pub fn ds_list_lockfree_cursor_to_string(s : DslistlockfreeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistlockfreeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_view_make(size : Int) -> DslistlockfreeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_lockfree_view_len(s : DslistlockfreeView) -> Int { s.size }

pub fn ds_list_lockfree_view_get(s : DslistlockfreeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_lockfree_view_set(s : DslistlockfreeView, i : Int, v : Double) -> DslistlockfreeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_view_sum(s : DslistlockfreeView) -> Double { @_common.sum(s.data) }

pub fn ds_list_lockfree_view_mean(s : DslistlockfreeView) -> Double { @_common.mean(s.data) }

pub fn ds_list_lockfree_view_scale(s : DslistlockfreeView, f : Double) -> DslistlockfreeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_view_add(a : DslistlockfreeView, b : DslistlockfreeView) -> DslistlockfreeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_lockfree_view_copy(s : DslistlockfreeView) -> DslistlockfreeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_view_fill(s : DslistlockfreeView, v : Double) -> DslistlockfreeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_view_min(s : DslistlockfreeView) -> Double { @_common.min(s.data) }

pub fn ds_list_lockfree_view_max(s : DslistlockfreeView) -> Double { @_common.max(s.data) }

pub fn ds_list_lockfree_view_to_string(s : DslistlockfreeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistlockfreeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_range_make(size : Int) -> DslistlockfreeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_lockfree_range_len(s : DslistlockfreeRange) -> Int { s.size }

pub fn ds_list_lockfree_range_get(s : DslistlockfreeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_lockfree_range_set(s : DslistlockfreeRange, i : Int, v : Double) -> DslistlockfreeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_range_sum(s : DslistlockfreeRange) -> Double { @_common.sum(s.data) }

pub fn ds_list_lockfree_range_mean(s : DslistlockfreeRange) -> Double { @_common.mean(s.data) }

pub fn ds_list_lockfree_range_scale(s : DslistlockfreeRange, f : Double) -> DslistlockfreeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_range_add(a : DslistlockfreeRange, b : DslistlockfreeRange) -> DslistlockfreeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_lockfree_range_copy(s : DslistlockfreeRange) -> DslistlockfreeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_range_fill(s : DslistlockfreeRange, v : Double) -> DslistlockfreeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_range_min(s : DslistlockfreeRange) -> Double { @_common.min(s.data) }

pub fn ds_list_lockfree_range_max(s : DslistlockfreeRange) -> Double { @_common.max(s.data) }

pub fn ds_list_lockfree_range_to_string(s : DslistlockfreeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistlockfreeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_lockfree_slice_make(size : Int) -> DslistlockfreeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_lockfree_slice_len(s : DslistlockfreeSlice) -> Int { s.size }

pub fn ds_list_lockfree_slice_get(s : DslistlockfreeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_lockfree_slice_set(s : DslistlockfreeSlice, i : Int, v : Double) -> DslistlockfreeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_slice_sum(s : DslistlockfreeSlice) -> Double { @_common.sum(s.data) }

pub fn ds_list_lockfree_slice_mean(s : DslistlockfreeSlice) -> Double { @_common.mean(s.data) }

pub fn ds_list_lockfree_slice_scale(s : DslistlockfreeSlice, f : Double) -> DslistlockfreeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_slice_add(a : DslistlockfreeSlice, b : DslistlockfreeSlice) -> DslistlockfreeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_lockfree_slice_copy(s : DslistlockfreeSlice) -> DslistlockfreeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_slice_fill(s : DslistlockfreeSlice, v : Double) -> DslistlockfreeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_lockfree_slice_min(s : DslistlockfreeSlice) -> Double { @_common.min(s.data) }

pub fn ds_list_lockfree_slice_max(s : DslistlockfreeSlice) -> Double { @_common.max(s.data) }

pub fn ds_list_lockfree_slice_to_string(s : DslistlockfreeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

