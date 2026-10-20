///===
/// extcore/ds_tree_fenwick

pub(all) struct DstreefenwickPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_fenwick_make_point(x : Double, y : Double) -> DstreefenwickPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_fenwick_make_point3(x : Double, y : Double, z : Double) -> DstreefenwickPoint {
  { x, y, z, label: 0 }
}

pub fn ds_tree_fenwick_point_x(pt : DstreefenwickPoint) -> Double { pt.x }

pub fn ds_tree_fenwick_point_y(pt : DstreefenwickPoint) -> Double { pt.y }

pub fn ds_tree_fenwick_point_z(pt : DstreefenwickPoint) -> Double { pt.z }

pub fn ds_tree_fenwick_point_label(pt : DstreefenwickPoint) -> Int { pt.label }

pub fn ds_tree_fenwick_point_dist(a : DstreefenwickPoint, b : DstreefenwickPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_tree_fenwick_point_add(a : DstreefenwickPoint, b : DstreefenwickPoint) -> DstreefenwickPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_tree_fenwick_point_sub(a : DstreefenwickPoint, b : DstreefenwickPoint) -> DstreefenwickPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_tree_fenwick_point_scale(pt : DstreefenwickPoint, s : Double) -> DstreefenwickPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_tree_fenwick_point_dot(a : DstreefenwickPoint, b : DstreefenwickPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_tree_fenwick_point_cross(a : DstreefenwickPoint, b : DstreefenwickPoint) -> DstreefenwickPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_tree_fenwick_point_norm(pt : DstreefenwickPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_tree_fenwick_point_normalize(pt : DstreefenwickPoint) -> DstreefenwickPoint {
  let n = ds_tree_fenwick_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_tree_fenwick_point_scale(pt, 1.0 / n) }
}

pub fn ds_tree_fenwick_point_negate(pt : DstreefenwickPoint) -> DstreefenwickPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_tree_fenwick_point_mid(a : DstreefenwickPoint, b : DstreefenwickPoint) -> DstreefenwickPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_tree_fenwick_point_lerp(a : DstreefenwickPoint, b : DstreefenwickPoint, t : Double) -> DstreefenwickPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_tree_fenwick_point_to_string(pt : DstreefenwickPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DstreefenwickSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_fenwick_make_series(vals : Array[Double], name : String) -> DstreefenwickSeries {
  { vals, name, meta: 0 }
}

pub fn ds_tree_fenwick_series_len(s : DstreefenwickSeries) -> Int { s.vals.length() }

pub fn ds_tree_fenwick_series_sum(s : DstreefenwickSeries) -> Double { @_common.sum(s.vals) }

pub fn ds_tree_fenwick_series_mean(s : DstreefenwickSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_tree_fenwick_series_min(s : DstreefenwickSeries) -> Double { @_common.min(s.vals) }

pub fn ds_tree_fenwick_series_max(s : DstreefenwickSeries) -> Double { @_common.max(s.vals) }

pub fn ds_tree_fenwick_series_range(s : DstreefenwickSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_tree_fenwick_series_var(s : DstreefenwickSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_tree_fenwick_series_std(s : DstreefenwickSeries) -> Double { @_common.std(s.vals) }

pub fn ds_tree_fenwick_series_median(s : DstreefenwickSeries) -> Double { @_common.median(s.vals) }

pub fn ds_tree_fenwick_series_scale(s : DstreefenwickSeries, f : Double) -> DstreefenwickSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn ds_tree_fenwick_series_add(a : DstreefenwickSeries, b : DstreefenwickSeries) -> DstreefenwickSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_tree_fenwick_series_sub(a : DstreefenwickSeries, b : DstreefenwickSeries) -> DstreefenwickSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_tree_fenwick_series_normalize(s : DstreefenwickSeries) -> DstreefenwickSeries {
  let mn = ds_tree_fenwick_series_min(s)
  let mx = ds_tree_fenwick_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_tree_fenwick_series_cumsum(s : DstreefenwickSeries) -> DstreefenwickSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_tree_fenwick_series_to_string(s : DstreefenwickSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreefenwickMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_fenwick_make_matrix(rows : Int, cols : Int, val : Double) -> DstreefenwickMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_fenwick_matrix_identity(n : Int) -> DstreefenwickMatrix {
  let m = ds_tree_fenwick_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_tree_fenwick_matrix_get(m : DstreefenwickMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_tree_fenwick_matrix_transpose(m : DstreefenwickMatrix) -> DstreefenwickMatrix {
  let result = ds_tree_fenwick_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_tree_fenwick_matrix_add(a : DstreefenwickMatrix, b : DstreefenwickMatrix) -> DstreefenwickMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_tree_fenwick_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_tree_fenwick_matrix_scale(m : DstreefenwickMatrix, s : Double) -> DstreefenwickMatrix {
  let result = ds_tree_fenwick_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_tree_fenwick_matrix_multiply(a : DstreefenwickMatrix, b : DstreefenwickMatrix) -> DstreefenwickMatrix {
  if a.cols != b.rows { return ds_tree_fenwick_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_tree_fenwick_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_tree_fenwick_matrix_trace(m : DstreefenwickMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_tree_fenwick_matrix_det(m : DstreefenwickMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_tree_fenwick_matrix_norm(m : DstreefenwickMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_tree_fenwick_matrix_to_string(m : DstreefenwickMatrix) -> String {
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

pub(all) struct DstreefenwickVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_fenwick_make_vector(comps : Array[Double]) -> DstreefenwickVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_fenwick_vector_zero(dim : Int) -> DstreefenwickVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_tree_fenwick_vector_add(a : DstreefenwickVector, b : DstreefenwickVector) -> DstreefenwickVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn ds_tree_fenwick_vector_sub(a : DstreefenwickVector, b : DstreefenwickVector) -> DstreefenwickVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn ds_tree_fenwick_vector_scale(v : DstreefenwickVector, s : Double) -> DstreefenwickVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn ds_tree_fenwick_vector_dot(a : DstreefenwickVector, b : DstreefenwickVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_tree_fenwick_vector_norm(v : DstreefenwickVector) -> Double { @_common.sqrt(ds_tree_fenwick_vector_dot(v, v)) }

pub fn ds_tree_fenwick_vector_normalize(v : DstreefenwickVector) -> DstreefenwickVector {
  let n = ds_tree_fenwick_vector_norm(v)
  if n < 0.0000001 { v } else { ds_tree_fenwick_vector_scale(v, 1.0 / n) }
}

pub fn ds_tree_fenwick_vector_dist(a : DstreefenwickVector, b : DstreefenwickVector) -> Double {
  ds_tree_fenwick_vector_norm(ds_tree_fenwick_vector_sub(a, b))
}

pub fn ds_tree_fenwick_vector_to_string(v : DstreefenwickVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_tree_fenwick_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_tree_fenwick_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_tree_fenwick_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_tree_fenwick_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_tree_fenwick_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_tree_fenwick_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_tree_fenwick_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_tree_fenwick_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_tree_fenwick_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_tree_fenwick_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_tree_fenwick_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_tree_fenwick_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_tree_fenwick_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_tree_fenwick_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_tree_fenwick_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_tree_fenwick_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_tree_fenwick_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_tree_fenwick_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_tree_fenwick_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_tree_fenwick_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_tree_fenwick_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_tree_fenwick_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_tree_fenwick_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_tree_fenwick_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_tree_fenwick_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_tree_fenwick_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_tree_fenwick_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_tree_fenwick_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_tree_fenwick_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DstreefenwickFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_frame_make(size : Int) -> DstreefenwickFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_frame_len(s : DstreefenwickFrame) -> Int { s.size }

pub fn ds_tree_fenwick_frame_get(s : DstreefenwickFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_frame_set(s : DstreefenwickFrame, i : Int, v : Double) -> DstreefenwickFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_frame_sum(s : DstreefenwickFrame) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_frame_mean(s : DstreefenwickFrame) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_frame_scale(s : DstreefenwickFrame, f : Double) -> DstreefenwickFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_frame_add(a : DstreefenwickFrame, b : DstreefenwickFrame) -> DstreefenwickFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_frame_copy(s : DstreefenwickFrame) -> DstreefenwickFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_frame_fill(s : DstreefenwickFrame, v : Double) -> DstreefenwickFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_frame_min(s : DstreefenwickFrame) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_frame_max(s : DstreefenwickFrame) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_frame_to_string(s : DstreefenwickFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_table_make(size : Int) -> DstreefenwickTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_table_len(s : DstreefenwickTable) -> Int { s.size }

pub fn ds_tree_fenwick_table_get(s : DstreefenwickTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_table_set(s : DstreefenwickTable, i : Int, v : Double) -> DstreefenwickTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_table_sum(s : DstreefenwickTable) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_table_mean(s : DstreefenwickTable) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_table_scale(s : DstreefenwickTable, f : Double) -> DstreefenwickTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_table_add(a : DstreefenwickTable, b : DstreefenwickTable) -> DstreefenwickTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_table_copy(s : DstreefenwickTable) -> DstreefenwickTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_table_fill(s : DstreefenwickTable, v : Double) -> DstreefenwickTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_table_min(s : DstreefenwickTable) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_table_max(s : DstreefenwickTable) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_table_to_string(s : DstreefenwickTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_graphn_make(size : Int) -> DstreefenwickGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_graphn_len(s : DstreefenwickGraphN) -> Int { s.size }

pub fn ds_tree_fenwick_graphn_get(s : DstreefenwickGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_graphn_set(s : DstreefenwickGraphN, i : Int, v : Double) -> DstreefenwickGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_graphn_sum(s : DstreefenwickGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_graphn_mean(s : DstreefenwickGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_graphn_scale(s : DstreefenwickGraphN, f : Double) -> DstreefenwickGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_graphn_add(a : DstreefenwickGraphN, b : DstreefenwickGraphN) -> DstreefenwickGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_graphn_copy(s : DstreefenwickGraphN) -> DstreefenwickGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_graphn_fill(s : DstreefenwickGraphN, v : Double) -> DstreefenwickGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_graphn_min(s : DstreefenwickGraphN) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_graphn_max(s : DstreefenwickGraphN) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_graphn_to_string(s : DstreefenwickGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_node_make(size : Int) -> DstreefenwickNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_node_len(s : DstreefenwickNode) -> Int { s.size }

pub fn ds_tree_fenwick_node_get(s : DstreefenwickNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_node_set(s : DstreefenwickNode, i : Int, v : Double) -> DstreefenwickNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_node_sum(s : DstreefenwickNode) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_node_mean(s : DstreefenwickNode) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_node_scale(s : DstreefenwickNode, f : Double) -> DstreefenwickNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_node_add(a : DstreefenwickNode, b : DstreefenwickNode) -> DstreefenwickNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_node_copy(s : DstreefenwickNode) -> DstreefenwickNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_node_fill(s : DstreefenwickNode, v : Double) -> DstreefenwickNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_node_min(s : DstreefenwickNode) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_node_max(s : DstreefenwickNode) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_node_to_string(s : DstreefenwickNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_edge_make(size : Int) -> DstreefenwickEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_edge_len(s : DstreefenwickEdge) -> Int { s.size }

pub fn ds_tree_fenwick_edge_get(s : DstreefenwickEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_edge_set(s : DstreefenwickEdge, i : Int, v : Double) -> DstreefenwickEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_edge_sum(s : DstreefenwickEdge) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_edge_mean(s : DstreefenwickEdge) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_edge_scale(s : DstreefenwickEdge, f : Double) -> DstreefenwickEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_edge_add(a : DstreefenwickEdge, b : DstreefenwickEdge) -> DstreefenwickEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_edge_copy(s : DstreefenwickEdge) -> DstreefenwickEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_edge_fill(s : DstreefenwickEdge, v : Double) -> DstreefenwickEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_edge_min(s : DstreefenwickEdge) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_edge_max(s : DstreefenwickEdge) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_edge_to_string(s : DstreefenwickEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_path_make(size : Int) -> DstreefenwickPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_path_len(s : DstreefenwickPath) -> Int { s.size }

pub fn ds_tree_fenwick_path_get(s : DstreefenwickPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_path_set(s : DstreefenwickPath, i : Int, v : Double) -> DstreefenwickPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_path_sum(s : DstreefenwickPath) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_path_mean(s : DstreefenwickPath) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_path_scale(s : DstreefenwickPath, f : Double) -> DstreefenwickPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_path_add(a : DstreefenwickPath, b : DstreefenwickPath) -> DstreefenwickPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_path_copy(s : DstreefenwickPath) -> DstreefenwickPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_path_fill(s : DstreefenwickPath, v : Double) -> DstreefenwickPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_path_min(s : DstreefenwickPath) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_path_max(s : DstreefenwickPath) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_path_to_string(s : DstreefenwickPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_cluster_make(size : Int) -> DstreefenwickCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_cluster_len(s : DstreefenwickCluster) -> Int { s.size }

pub fn ds_tree_fenwick_cluster_get(s : DstreefenwickCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_cluster_set(s : DstreefenwickCluster, i : Int, v : Double) -> DstreefenwickCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_cluster_sum(s : DstreefenwickCluster) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_cluster_mean(s : DstreefenwickCluster) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_cluster_scale(s : DstreefenwickCluster, f : Double) -> DstreefenwickCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_cluster_add(a : DstreefenwickCluster, b : DstreefenwickCluster) -> DstreefenwickCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_cluster_copy(s : DstreefenwickCluster) -> DstreefenwickCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_cluster_fill(s : DstreefenwickCluster, v : Double) -> DstreefenwickCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_cluster_min(s : DstreefenwickCluster) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_cluster_max(s : DstreefenwickCluster) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_cluster_to_string(s : DstreefenwickCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_model_make(size : Int) -> DstreefenwickModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_model_len(s : DstreefenwickModel) -> Int { s.size }

pub fn ds_tree_fenwick_model_get(s : DstreefenwickModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_model_set(s : DstreefenwickModel, i : Int, v : Double) -> DstreefenwickModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_model_sum(s : DstreefenwickModel) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_model_mean(s : DstreefenwickModel) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_model_scale(s : DstreefenwickModel, f : Double) -> DstreefenwickModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_model_add(a : DstreefenwickModel, b : DstreefenwickModel) -> DstreefenwickModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_model_copy(s : DstreefenwickModel) -> DstreefenwickModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_model_fill(s : DstreefenwickModel, v : Double) -> DstreefenwickModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_model_min(s : DstreefenwickModel) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_model_max(s : DstreefenwickModel) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_model_to_string(s : DstreefenwickModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_layer_make(size : Int) -> DstreefenwickLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_layer_len(s : DstreefenwickLayer) -> Int { s.size }

pub fn ds_tree_fenwick_layer_get(s : DstreefenwickLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_layer_set(s : DstreefenwickLayer, i : Int, v : Double) -> DstreefenwickLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_layer_sum(s : DstreefenwickLayer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_layer_mean(s : DstreefenwickLayer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_layer_scale(s : DstreefenwickLayer, f : Double) -> DstreefenwickLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_layer_add(a : DstreefenwickLayer, b : DstreefenwickLayer) -> DstreefenwickLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_layer_copy(s : DstreefenwickLayer) -> DstreefenwickLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_layer_fill(s : DstreefenwickLayer, v : Double) -> DstreefenwickLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_layer_min(s : DstreefenwickLayer) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_layer_max(s : DstreefenwickLayer) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_layer_to_string(s : DstreefenwickLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_buffer_make(size : Int) -> DstreefenwickBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_buffer_len(s : DstreefenwickBuffer) -> Int { s.size }

pub fn ds_tree_fenwick_buffer_get(s : DstreefenwickBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_buffer_set(s : DstreefenwickBuffer, i : Int, v : Double) -> DstreefenwickBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_buffer_sum(s : DstreefenwickBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_buffer_mean(s : DstreefenwickBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_buffer_scale(s : DstreefenwickBuffer, f : Double) -> DstreefenwickBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_buffer_add(a : DstreefenwickBuffer, b : DstreefenwickBuffer) -> DstreefenwickBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_buffer_copy(s : DstreefenwickBuffer) -> DstreefenwickBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_buffer_fill(s : DstreefenwickBuffer, v : Double) -> DstreefenwickBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_buffer_min(s : DstreefenwickBuffer) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_buffer_max(s : DstreefenwickBuffer) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_buffer_to_string(s : DstreefenwickBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_cursor_make(size : Int) -> DstreefenwickCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_cursor_len(s : DstreefenwickCursor) -> Int { s.size }

pub fn ds_tree_fenwick_cursor_get(s : DstreefenwickCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_cursor_set(s : DstreefenwickCursor, i : Int, v : Double) -> DstreefenwickCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_cursor_sum(s : DstreefenwickCursor) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_cursor_mean(s : DstreefenwickCursor) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_cursor_scale(s : DstreefenwickCursor, f : Double) -> DstreefenwickCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_cursor_add(a : DstreefenwickCursor, b : DstreefenwickCursor) -> DstreefenwickCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_cursor_copy(s : DstreefenwickCursor) -> DstreefenwickCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_cursor_fill(s : DstreefenwickCursor, v : Double) -> DstreefenwickCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_cursor_min(s : DstreefenwickCursor) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_cursor_max(s : DstreefenwickCursor) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_cursor_to_string(s : DstreefenwickCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_view_make(size : Int) -> DstreefenwickView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_view_len(s : DstreefenwickView) -> Int { s.size }

pub fn ds_tree_fenwick_view_get(s : DstreefenwickView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_view_set(s : DstreefenwickView, i : Int, v : Double) -> DstreefenwickView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_view_sum(s : DstreefenwickView) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_view_mean(s : DstreefenwickView) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_view_scale(s : DstreefenwickView, f : Double) -> DstreefenwickView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_view_add(a : DstreefenwickView, b : DstreefenwickView) -> DstreefenwickView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_view_copy(s : DstreefenwickView) -> DstreefenwickView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_view_fill(s : DstreefenwickView, v : Double) -> DstreefenwickView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_view_min(s : DstreefenwickView) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_view_max(s : DstreefenwickView) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_view_to_string(s : DstreefenwickView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_range_make(size : Int) -> DstreefenwickRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_range_len(s : DstreefenwickRange) -> Int { s.size }

pub fn ds_tree_fenwick_range_get(s : DstreefenwickRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_range_set(s : DstreefenwickRange, i : Int, v : Double) -> DstreefenwickRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_range_sum(s : DstreefenwickRange) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_range_mean(s : DstreefenwickRange) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_range_scale(s : DstreefenwickRange, f : Double) -> DstreefenwickRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_range_add(a : DstreefenwickRange, b : DstreefenwickRange) -> DstreefenwickRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_range_copy(s : DstreefenwickRange) -> DstreefenwickRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_range_fill(s : DstreefenwickRange, v : Double) -> DstreefenwickRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_range_min(s : DstreefenwickRange) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_range_max(s : DstreefenwickRange) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_range_to_string(s : DstreefenwickRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_slice_make(size : Int) -> DstreefenwickSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_slice_len(s : DstreefenwickSlice) -> Int { s.size }

pub fn ds_tree_fenwick_slice_get(s : DstreefenwickSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_slice_set(s : DstreefenwickSlice, i : Int, v : Double) -> DstreefenwickSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_slice_sum(s : DstreefenwickSlice) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_slice_mean(s : DstreefenwickSlice) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_slice_scale(s : DstreefenwickSlice, f : Double) -> DstreefenwickSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_slice_add(a : DstreefenwickSlice, b : DstreefenwickSlice) -> DstreefenwickSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_slice_copy(s : DstreefenwickSlice) -> DstreefenwickSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_slice_fill(s : DstreefenwickSlice, v : Double) -> DstreefenwickSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_slice_min(s : DstreefenwickSlice) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_slice_max(s : DstreefenwickSlice) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_slice_to_string(s : DstreefenwickSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

