///===
/// extcore/physics_em_bem

pub(all) struct PhysicsembemPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_em_bem_make_point(x : Double, y : Double) -> PhysicsembemPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_em_bem_make_point3(x : Double, y : Double, z : Double) -> PhysicsembemPoint {
  { x, y, z, label: 0 }
}

pub fn physics_em_bem_point_x(pt : PhysicsembemPoint) -> Double { pt.x }

pub fn physics_em_bem_point_y(pt : PhysicsembemPoint) -> Double { pt.y }

pub fn physics_em_bem_point_z(pt : PhysicsembemPoint) -> Double { pt.z }

pub fn physics_em_bem_point_label(pt : PhysicsembemPoint) -> Int { pt.label }

pub fn physics_em_bem_point_dist(a : PhysicsembemPoint, b : PhysicsembemPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_em_bem_point_add(a : PhysicsembemPoint, b : PhysicsembemPoint) -> PhysicsembemPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_em_bem_point_sub(a : PhysicsembemPoint, b : PhysicsembemPoint) -> PhysicsembemPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_em_bem_point_scale(pt : PhysicsembemPoint, s : Double) -> PhysicsembemPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_em_bem_point_dot(a : PhysicsembemPoint, b : PhysicsembemPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_em_bem_point_cross(a : PhysicsembemPoint, b : PhysicsembemPoint) -> PhysicsembemPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_em_bem_point_norm(pt : PhysicsembemPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_em_bem_point_normalize(pt : PhysicsembemPoint) -> PhysicsembemPoint {
  let n = physics_em_bem_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_em_bem_point_scale(pt, 1.0 / n) }
}

pub fn physics_em_bem_point_negate(pt : PhysicsembemPoint) -> PhysicsembemPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_em_bem_point_mid(a : PhysicsembemPoint, b : PhysicsembemPoint) -> PhysicsembemPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_em_bem_point_lerp(a : PhysicsembemPoint, b : PhysicsembemPoint, t : Double) -> PhysicsembemPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_em_bem_point_to_string(pt : PhysicsembemPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsembemSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_em_bem_make_series(vals : Array[Double], name : String) -> PhysicsembemSeries {
  { vals, name, meta: 0 }
}

pub fn physics_em_bem_series_len(s : PhysicsembemSeries) -> Int { s.vals.length() }

pub fn physics_em_bem_series_sum(s : PhysicsembemSeries) -> Double { @_common.sum(s.vals) }

pub fn physics_em_bem_series_mean(s : PhysicsembemSeries) -> Double { @_common.mean(s.vals) }

pub fn physics_em_bem_series_min(s : PhysicsembemSeries) -> Double { @_common.min(s.vals) }

pub fn physics_em_bem_series_max(s : PhysicsembemSeries) -> Double { @_common.max(s.vals) }

pub fn physics_em_bem_series_range(s : PhysicsembemSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_em_bem_series_var(s : PhysicsembemSeries) -> Double { @_common.variance(s.vals) }

pub fn physics_em_bem_series_std(s : PhysicsembemSeries) -> Double { @_common.std(s.vals) }

pub fn physics_em_bem_series_median(s : PhysicsembemSeries) -> Double { @_common.median(s.vals) }

pub fn physics_em_bem_series_scale(s : PhysicsembemSeries, f : Double) -> PhysicsembemSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn physics_em_bem_series_add(a : PhysicsembemSeries, b : PhysicsembemSeries) -> PhysicsembemSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_em_bem_series_sub(a : PhysicsembemSeries, b : PhysicsembemSeries) -> PhysicsembemSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_em_bem_series_normalize(s : PhysicsembemSeries) -> PhysicsembemSeries {
  let mn = physics_em_bem_series_min(s)
  let mx = physics_em_bem_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_em_bem_series_cumsum(s : PhysicsembemSeries) -> PhysicsembemSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_em_bem_series_to_string(s : PhysicsembemSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsembemMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_em_bem_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsembemMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_em_bem_matrix_identity(n : Int) -> PhysicsembemMatrix {
  let m = physics_em_bem_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_em_bem_matrix_get(m : PhysicsembemMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_em_bem_matrix_transpose(m : PhysicsembemMatrix) -> PhysicsembemMatrix {
  let result = physics_em_bem_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_em_bem_matrix_add(a : PhysicsembemMatrix, b : PhysicsembemMatrix) -> PhysicsembemMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_em_bem_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_em_bem_matrix_scale(m : PhysicsembemMatrix, s : Double) -> PhysicsembemMatrix {
  let result = physics_em_bem_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_em_bem_matrix_multiply(a : PhysicsembemMatrix, b : PhysicsembemMatrix) -> PhysicsembemMatrix {
  if a.cols != b.rows { return physics_em_bem_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_em_bem_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_em_bem_matrix_trace(m : PhysicsembemMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_em_bem_matrix_det(m : PhysicsembemMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_em_bem_matrix_norm(m : PhysicsembemMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_em_bem_matrix_to_string(m : PhysicsembemMatrix) -> String {
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

pub(all) struct PhysicsembemVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_em_bem_make_vector(comps : Array[Double]) -> PhysicsembemVector {
  { comps, dim: comps.length() }
}

pub fn physics_em_bem_vector_zero(dim : Int) -> PhysicsembemVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_em_bem_vector_add(a : PhysicsembemVector, b : PhysicsembemVector) -> PhysicsembemVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn physics_em_bem_vector_sub(a : PhysicsembemVector, b : PhysicsembemVector) -> PhysicsembemVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn physics_em_bem_vector_scale(v : PhysicsembemVector, s : Double) -> PhysicsembemVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn physics_em_bem_vector_dot(a : PhysicsembemVector, b : PhysicsembemVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_em_bem_vector_norm(v : PhysicsembemVector) -> Double { @_common.sqrt(physics_em_bem_vector_dot(v, v)) }

pub fn physics_em_bem_vector_normalize(v : PhysicsembemVector) -> PhysicsembemVector {
  let n = physics_em_bem_vector_norm(v)
  if n < 0.0000001 { v } else { physics_em_bem_vector_scale(v, 1.0 / n) }
}

pub fn physics_em_bem_vector_dist(a : PhysicsembemVector, b : PhysicsembemVector) -> Double {
  physics_em_bem_vector_norm(physics_em_bem_vector_sub(a, b))
}

pub fn physics_em_bem_vector_to_string(v : PhysicsembemVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_em_bem_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_em_bem_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_em_bem_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_em_bem_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_em_bem_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_em_bem_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_em_bem_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_em_bem_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_em_bem_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_em_bem_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_em_bem_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_em_bem_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_em_bem_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_em_bem_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_em_bem_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_em_bem_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_em_bem_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_em_bem_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_em_bem_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_em_bem_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_em_bem_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_em_bem_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_em_bem_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_em_bem_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_em_bem_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_em_bem_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_em_bem_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_em_bem_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_em_bem_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsembemFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_bem_frame_make(size : Int) -> PhysicsembemFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_bem_frame_len(s : PhysicsembemFrame) -> Int { s.size }

pub fn physics_em_bem_frame_get(s : PhysicsembemFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_bem_frame_set(s : PhysicsembemFrame, i : Int, v : Double) -> PhysicsembemFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_bem_frame_sum(s : PhysicsembemFrame) -> Double { @_common.sum(s.data) }

pub fn physics_em_bem_frame_mean(s : PhysicsembemFrame) -> Double { @_common.mean(s.data) }

pub fn physics_em_bem_frame_scale(s : PhysicsembemFrame, f : Double) -> PhysicsembemFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_frame_add(a : PhysicsembemFrame, b : PhysicsembemFrame) -> PhysicsembemFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_bem_frame_copy(s : PhysicsembemFrame) -> PhysicsembemFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_frame_fill(s : PhysicsembemFrame, v : Double) -> PhysicsembemFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_frame_min(s : PhysicsembemFrame) -> Double { @_common.min(s.data) }

pub fn physics_em_bem_frame_max(s : PhysicsembemFrame) -> Double { @_common.max(s.data) }

pub fn physics_em_bem_frame_to_string(s : PhysicsembemFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsembemTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_bem_table_make(size : Int) -> PhysicsembemTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_bem_table_len(s : PhysicsembemTable) -> Int { s.size }

pub fn physics_em_bem_table_get(s : PhysicsembemTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_bem_table_set(s : PhysicsembemTable, i : Int, v : Double) -> PhysicsembemTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_bem_table_sum(s : PhysicsembemTable) -> Double { @_common.sum(s.data) }

pub fn physics_em_bem_table_mean(s : PhysicsembemTable) -> Double { @_common.mean(s.data) }

pub fn physics_em_bem_table_scale(s : PhysicsembemTable, f : Double) -> PhysicsembemTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_table_add(a : PhysicsembemTable, b : PhysicsembemTable) -> PhysicsembemTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_bem_table_copy(s : PhysicsembemTable) -> PhysicsembemTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_table_fill(s : PhysicsembemTable, v : Double) -> PhysicsembemTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_table_min(s : PhysicsembemTable) -> Double { @_common.min(s.data) }

pub fn physics_em_bem_table_max(s : PhysicsembemTable) -> Double { @_common.max(s.data) }

pub fn physics_em_bem_table_to_string(s : PhysicsembemTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsembemGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_bem_graphn_make(size : Int) -> PhysicsembemGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_bem_graphn_len(s : PhysicsembemGraphN) -> Int { s.size }

pub fn physics_em_bem_graphn_get(s : PhysicsembemGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_bem_graphn_set(s : PhysicsembemGraphN, i : Int, v : Double) -> PhysicsembemGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_bem_graphn_sum(s : PhysicsembemGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_em_bem_graphn_mean(s : PhysicsembemGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_em_bem_graphn_scale(s : PhysicsembemGraphN, f : Double) -> PhysicsembemGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_graphn_add(a : PhysicsembemGraphN, b : PhysicsembemGraphN) -> PhysicsembemGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_bem_graphn_copy(s : PhysicsembemGraphN) -> PhysicsembemGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_graphn_fill(s : PhysicsembemGraphN, v : Double) -> PhysicsembemGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_graphn_min(s : PhysicsembemGraphN) -> Double { @_common.min(s.data) }

pub fn physics_em_bem_graphn_max(s : PhysicsembemGraphN) -> Double { @_common.max(s.data) }

pub fn physics_em_bem_graphn_to_string(s : PhysicsembemGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsembemNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_bem_node_make(size : Int) -> PhysicsembemNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_bem_node_len(s : PhysicsembemNode) -> Int { s.size }

pub fn physics_em_bem_node_get(s : PhysicsembemNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_bem_node_set(s : PhysicsembemNode, i : Int, v : Double) -> PhysicsembemNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_bem_node_sum(s : PhysicsembemNode) -> Double { @_common.sum(s.data) }

pub fn physics_em_bem_node_mean(s : PhysicsembemNode) -> Double { @_common.mean(s.data) }

pub fn physics_em_bem_node_scale(s : PhysicsembemNode, f : Double) -> PhysicsembemNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_node_add(a : PhysicsembemNode, b : PhysicsembemNode) -> PhysicsembemNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_bem_node_copy(s : PhysicsembemNode) -> PhysicsembemNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_node_fill(s : PhysicsembemNode, v : Double) -> PhysicsembemNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_node_min(s : PhysicsembemNode) -> Double { @_common.min(s.data) }

pub fn physics_em_bem_node_max(s : PhysicsembemNode) -> Double { @_common.max(s.data) }

pub fn physics_em_bem_node_to_string(s : PhysicsembemNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsembemEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_bem_edge_make(size : Int) -> PhysicsembemEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_bem_edge_len(s : PhysicsembemEdge) -> Int { s.size }

pub fn physics_em_bem_edge_get(s : PhysicsembemEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_bem_edge_set(s : PhysicsembemEdge, i : Int, v : Double) -> PhysicsembemEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_bem_edge_sum(s : PhysicsembemEdge) -> Double { @_common.sum(s.data) }

pub fn physics_em_bem_edge_mean(s : PhysicsembemEdge) -> Double { @_common.mean(s.data) }

pub fn physics_em_bem_edge_scale(s : PhysicsembemEdge, f : Double) -> PhysicsembemEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_edge_add(a : PhysicsembemEdge, b : PhysicsembemEdge) -> PhysicsembemEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_bem_edge_copy(s : PhysicsembemEdge) -> PhysicsembemEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_edge_fill(s : PhysicsembemEdge, v : Double) -> PhysicsembemEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_edge_min(s : PhysicsembemEdge) -> Double { @_common.min(s.data) }

pub fn physics_em_bem_edge_max(s : PhysicsembemEdge) -> Double { @_common.max(s.data) }

pub fn physics_em_bem_edge_to_string(s : PhysicsembemEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsembemPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_bem_path_make(size : Int) -> PhysicsembemPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_bem_path_len(s : PhysicsembemPath) -> Int { s.size }

pub fn physics_em_bem_path_get(s : PhysicsembemPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_bem_path_set(s : PhysicsembemPath, i : Int, v : Double) -> PhysicsembemPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_bem_path_sum(s : PhysicsembemPath) -> Double { @_common.sum(s.data) }

pub fn physics_em_bem_path_mean(s : PhysicsembemPath) -> Double { @_common.mean(s.data) }

pub fn physics_em_bem_path_scale(s : PhysicsembemPath, f : Double) -> PhysicsembemPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_path_add(a : PhysicsembemPath, b : PhysicsembemPath) -> PhysicsembemPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_bem_path_copy(s : PhysicsembemPath) -> PhysicsembemPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_path_fill(s : PhysicsembemPath, v : Double) -> PhysicsembemPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_path_min(s : PhysicsembemPath) -> Double { @_common.min(s.data) }

pub fn physics_em_bem_path_max(s : PhysicsembemPath) -> Double { @_common.max(s.data) }

pub fn physics_em_bem_path_to_string(s : PhysicsembemPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsembemCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_bem_cluster_make(size : Int) -> PhysicsembemCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_bem_cluster_len(s : PhysicsembemCluster) -> Int { s.size }

pub fn physics_em_bem_cluster_get(s : PhysicsembemCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_bem_cluster_set(s : PhysicsembemCluster, i : Int, v : Double) -> PhysicsembemCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_bem_cluster_sum(s : PhysicsembemCluster) -> Double { @_common.sum(s.data) }

pub fn physics_em_bem_cluster_mean(s : PhysicsembemCluster) -> Double { @_common.mean(s.data) }

pub fn physics_em_bem_cluster_scale(s : PhysicsembemCluster, f : Double) -> PhysicsembemCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_cluster_add(a : PhysicsembemCluster, b : PhysicsembemCluster) -> PhysicsembemCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_bem_cluster_copy(s : PhysicsembemCluster) -> PhysicsembemCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_cluster_fill(s : PhysicsembemCluster, v : Double) -> PhysicsembemCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_cluster_min(s : PhysicsembemCluster) -> Double { @_common.min(s.data) }

pub fn physics_em_bem_cluster_max(s : PhysicsembemCluster) -> Double { @_common.max(s.data) }

pub fn physics_em_bem_cluster_to_string(s : PhysicsembemCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsembemModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_bem_model_make(size : Int) -> PhysicsembemModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_bem_model_len(s : PhysicsembemModel) -> Int { s.size }

pub fn physics_em_bem_model_get(s : PhysicsembemModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_bem_model_set(s : PhysicsembemModel, i : Int, v : Double) -> PhysicsembemModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_bem_model_sum(s : PhysicsembemModel) -> Double { @_common.sum(s.data) }

pub fn physics_em_bem_model_mean(s : PhysicsembemModel) -> Double { @_common.mean(s.data) }

pub fn physics_em_bem_model_scale(s : PhysicsembemModel, f : Double) -> PhysicsembemModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_model_add(a : PhysicsembemModel, b : PhysicsembemModel) -> PhysicsembemModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_bem_model_copy(s : PhysicsembemModel) -> PhysicsembemModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_model_fill(s : PhysicsembemModel, v : Double) -> PhysicsembemModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_model_min(s : PhysicsembemModel) -> Double { @_common.min(s.data) }

pub fn physics_em_bem_model_max(s : PhysicsembemModel) -> Double { @_common.max(s.data) }

pub fn physics_em_bem_model_to_string(s : PhysicsembemModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsembemLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_bem_layer_make(size : Int) -> PhysicsembemLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_bem_layer_len(s : PhysicsembemLayer) -> Int { s.size }

pub fn physics_em_bem_layer_get(s : PhysicsembemLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_bem_layer_set(s : PhysicsembemLayer, i : Int, v : Double) -> PhysicsembemLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_bem_layer_sum(s : PhysicsembemLayer) -> Double { @_common.sum(s.data) }

pub fn physics_em_bem_layer_mean(s : PhysicsembemLayer) -> Double { @_common.mean(s.data) }

pub fn physics_em_bem_layer_scale(s : PhysicsembemLayer, f : Double) -> PhysicsembemLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_layer_add(a : PhysicsembemLayer, b : PhysicsembemLayer) -> PhysicsembemLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_bem_layer_copy(s : PhysicsembemLayer) -> PhysicsembemLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_layer_fill(s : PhysicsembemLayer, v : Double) -> PhysicsembemLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_layer_min(s : PhysicsembemLayer) -> Double { @_common.min(s.data) }

pub fn physics_em_bem_layer_max(s : PhysicsembemLayer) -> Double { @_common.max(s.data) }

pub fn physics_em_bem_layer_to_string(s : PhysicsembemLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsembemBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_bem_buffer_make(size : Int) -> PhysicsembemBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_bem_buffer_len(s : PhysicsembemBuffer) -> Int { s.size }

pub fn physics_em_bem_buffer_get(s : PhysicsembemBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_bem_buffer_set(s : PhysicsembemBuffer, i : Int, v : Double) -> PhysicsembemBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_bem_buffer_sum(s : PhysicsembemBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_em_bem_buffer_mean(s : PhysicsembemBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_em_bem_buffer_scale(s : PhysicsembemBuffer, f : Double) -> PhysicsembemBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_buffer_add(a : PhysicsembemBuffer, b : PhysicsembemBuffer) -> PhysicsembemBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_bem_buffer_copy(s : PhysicsembemBuffer) -> PhysicsembemBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_buffer_fill(s : PhysicsembemBuffer, v : Double) -> PhysicsembemBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_buffer_min(s : PhysicsembemBuffer) -> Double { @_common.min(s.data) }

pub fn physics_em_bem_buffer_max(s : PhysicsembemBuffer) -> Double { @_common.max(s.data) }

pub fn physics_em_bem_buffer_to_string(s : PhysicsembemBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsembemCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_bem_cursor_make(size : Int) -> PhysicsembemCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_bem_cursor_len(s : PhysicsembemCursor) -> Int { s.size }

pub fn physics_em_bem_cursor_get(s : PhysicsembemCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_bem_cursor_set(s : PhysicsembemCursor, i : Int, v : Double) -> PhysicsembemCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_bem_cursor_sum(s : PhysicsembemCursor) -> Double { @_common.sum(s.data) }

pub fn physics_em_bem_cursor_mean(s : PhysicsembemCursor) -> Double { @_common.mean(s.data) }

pub fn physics_em_bem_cursor_scale(s : PhysicsembemCursor, f : Double) -> PhysicsembemCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_cursor_add(a : PhysicsembemCursor, b : PhysicsembemCursor) -> PhysicsembemCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_bem_cursor_copy(s : PhysicsembemCursor) -> PhysicsembemCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_cursor_fill(s : PhysicsembemCursor, v : Double) -> PhysicsembemCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_cursor_min(s : PhysicsembemCursor) -> Double { @_common.min(s.data) }

pub fn physics_em_bem_cursor_max(s : PhysicsembemCursor) -> Double { @_common.max(s.data) }

pub fn physics_em_bem_cursor_to_string(s : PhysicsembemCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsembemView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_bem_view_make(size : Int) -> PhysicsembemView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_bem_view_len(s : PhysicsembemView) -> Int { s.size }

pub fn physics_em_bem_view_get(s : PhysicsembemView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_bem_view_set(s : PhysicsembemView, i : Int, v : Double) -> PhysicsembemView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_bem_view_sum(s : PhysicsembemView) -> Double { @_common.sum(s.data) }

pub fn physics_em_bem_view_mean(s : PhysicsembemView) -> Double { @_common.mean(s.data) }

pub fn physics_em_bem_view_scale(s : PhysicsembemView, f : Double) -> PhysicsembemView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_view_add(a : PhysicsembemView, b : PhysicsembemView) -> PhysicsembemView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_bem_view_copy(s : PhysicsembemView) -> PhysicsembemView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_view_fill(s : PhysicsembemView, v : Double) -> PhysicsembemView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_view_min(s : PhysicsembemView) -> Double { @_common.min(s.data) }

pub fn physics_em_bem_view_max(s : PhysicsembemView) -> Double { @_common.max(s.data) }

pub fn physics_em_bem_view_to_string(s : PhysicsembemView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsembemRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_bem_range_make(size : Int) -> PhysicsembemRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_bem_range_len(s : PhysicsembemRange) -> Int { s.size }

pub fn physics_em_bem_range_get(s : PhysicsembemRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_bem_range_set(s : PhysicsembemRange, i : Int, v : Double) -> PhysicsembemRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_bem_range_sum(s : PhysicsembemRange) -> Double { @_common.sum(s.data) }

pub fn physics_em_bem_range_mean(s : PhysicsembemRange) -> Double { @_common.mean(s.data) }

pub fn physics_em_bem_range_scale(s : PhysicsembemRange, f : Double) -> PhysicsembemRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_range_add(a : PhysicsembemRange, b : PhysicsembemRange) -> PhysicsembemRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_bem_range_copy(s : PhysicsembemRange) -> PhysicsembemRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_range_fill(s : PhysicsembemRange, v : Double) -> PhysicsembemRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_range_min(s : PhysicsembemRange) -> Double { @_common.min(s.data) }

pub fn physics_em_bem_range_max(s : PhysicsembemRange) -> Double { @_common.max(s.data) }

pub fn physics_em_bem_range_to_string(s : PhysicsembemRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsembemSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_bem_slice_make(size : Int) -> PhysicsembemSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_bem_slice_len(s : PhysicsembemSlice) -> Int { s.size }

pub fn physics_em_bem_slice_get(s : PhysicsembemSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_bem_slice_set(s : PhysicsembemSlice, i : Int, v : Double) -> PhysicsembemSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_bem_slice_sum(s : PhysicsembemSlice) -> Double { @_common.sum(s.data) }

pub fn physics_em_bem_slice_mean(s : PhysicsembemSlice) -> Double { @_common.mean(s.data) }

pub fn physics_em_bem_slice_scale(s : PhysicsembemSlice, f : Double) -> PhysicsembemSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_slice_add(a : PhysicsembemSlice, b : PhysicsembemSlice) -> PhysicsembemSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_bem_slice_copy(s : PhysicsembemSlice) -> PhysicsembemSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_slice_fill(s : PhysicsembemSlice, v : Double) -> PhysicsembemSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_bem_slice_min(s : PhysicsembemSlice) -> Double { @_common.min(s.data) }

pub fn physics_em_bem_slice_max(s : PhysicsembemSlice) -> Double { @_common.max(s.data) }

pub fn physics_em_bem_slice_to_string(s : PhysicsembemSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

