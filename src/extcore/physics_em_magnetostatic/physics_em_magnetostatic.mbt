///===
/// extcore/physics_em_magnetostatic

pub(all) struct PhysicsemmagnetostaticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_em_magnetostatic_make_point(x : Double, y : Double) -> PhysicsemmagnetostaticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_em_magnetostatic_make_point3(x : Double, y : Double, z : Double) -> PhysicsemmagnetostaticPoint {
  { x, y, z, label: 0 }
}

pub fn physics_em_magnetostatic_point_x(pt : PhysicsemmagnetostaticPoint) -> Double { pt.x }

pub fn physics_em_magnetostatic_point_y(pt : PhysicsemmagnetostaticPoint) -> Double { pt.y }

pub fn physics_em_magnetostatic_point_z(pt : PhysicsemmagnetostaticPoint) -> Double { pt.z }

pub fn physics_em_magnetostatic_point_label(pt : PhysicsemmagnetostaticPoint) -> Int { pt.label }

pub fn physics_em_magnetostatic_point_dist(a : PhysicsemmagnetostaticPoint, b : PhysicsemmagnetostaticPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_em_magnetostatic_point_add(a : PhysicsemmagnetostaticPoint, b : PhysicsemmagnetostaticPoint) -> PhysicsemmagnetostaticPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_em_magnetostatic_point_sub(a : PhysicsemmagnetostaticPoint, b : PhysicsemmagnetostaticPoint) -> PhysicsemmagnetostaticPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_em_magnetostatic_point_scale(pt : PhysicsemmagnetostaticPoint, s : Double) -> PhysicsemmagnetostaticPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_em_magnetostatic_point_dot(a : PhysicsemmagnetostaticPoint, b : PhysicsemmagnetostaticPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_em_magnetostatic_point_cross(a : PhysicsemmagnetostaticPoint, b : PhysicsemmagnetostaticPoint) -> PhysicsemmagnetostaticPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_em_magnetostatic_point_norm(pt : PhysicsemmagnetostaticPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_em_magnetostatic_point_normalize(pt : PhysicsemmagnetostaticPoint) -> PhysicsemmagnetostaticPoint {
  let n = physics_em_magnetostatic_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_em_magnetostatic_point_scale(pt, 1.0 / n) }
}

pub fn physics_em_magnetostatic_point_negate(pt : PhysicsemmagnetostaticPoint) -> PhysicsemmagnetostaticPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_em_magnetostatic_point_mid(a : PhysicsemmagnetostaticPoint, b : PhysicsemmagnetostaticPoint) -> PhysicsemmagnetostaticPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_em_magnetostatic_point_lerp(a : PhysicsemmagnetostaticPoint, b : PhysicsemmagnetostaticPoint, t : Double) -> PhysicsemmagnetostaticPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_em_magnetostatic_point_to_string(pt : PhysicsemmagnetostaticPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_em_magnetostatic_make_series(vals : Array[Double], name : String) -> PhysicsemmagnetostaticSeries {
  { vals, name, meta: 0 }
}

pub fn physics_em_magnetostatic_series_len(s : PhysicsemmagnetostaticSeries) -> Int { s.vals.length() }

pub fn physics_em_magnetostatic_series_sum(s : PhysicsemmagnetostaticSeries) -> Double { @_common.sum(s.vals) }

pub fn physics_em_magnetostatic_series_mean(s : PhysicsemmagnetostaticSeries) -> Double { @_common.mean(s.vals) }

pub fn physics_em_magnetostatic_series_min(s : PhysicsemmagnetostaticSeries) -> Double { @_common.min(s.vals) }

pub fn physics_em_magnetostatic_series_max(s : PhysicsemmagnetostaticSeries) -> Double { @_common.max(s.vals) }

pub fn physics_em_magnetostatic_series_range(s : PhysicsemmagnetostaticSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_em_magnetostatic_series_var(s : PhysicsemmagnetostaticSeries) -> Double { @_common.variance(s.vals) }

pub fn physics_em_magnetostatic_series_std(s : PhysicsemmagnetostaticSeries) -> Double { @_common.std(s.vals) }

pub fn physics_em_magnetostatic_series_median(s : PhysicsemmagnetostaticSeries) -> Double { @_common.median(s.vals) }

pub fn physics_em_magnetostatic_series_scale(s : PhysicsemmagnetostaticSeries, f : Double) -> PhysicsemmagnetostaticSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn physics_em_magnetostatic_series_add(a : PhysicsemmagnetostaticSeries, b : PhysicsemmagnetostaticSeries) -> PhysicsemmagnetostaticSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_em_magnetostatic_series_sub(a : PhysicsemmagnetostaticSeries, b : PhysicsemmagnetostaticSeries) -> PhysicsemmagnetostaticSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_em_magnetostatic_series_normalize(s : PhysicsemmagnetostaticSeries) -> PhysicsemmagnetostaticSeries {
  let mn = physics_em_magnetostatic_series_min(s)
  let mx = physics_em_magnetostatic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_em_magnetostatic_series_cumsum(s : PhysicsemmagnetostaticSeries) -> PhysicsemmagnetostaticSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_em_magnetostatic_series_to_string(s : PhysicsemmagnetostaticSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemmagnetostaticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_em_magnetostatic_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsemmagnetostaticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_em_magnetostatic_matrix_identity(n : Int) -> PhysicsemmagnetostaticMatrix {
  let m = physics_em_magnetostatic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_em_magnetostatic_matrix_get(m : PhysicsemmagnetostaticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_em_magnetostatic_matrix_transpose(m : PhysicsemmagnetostaticMatrix) -> PhysicsemmagnetostaticMatrix {
  let result = physics_em_magnetostatic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_em_magnetostatic_matrix_add(a : PhysicsemmagnetostaticMatrix, b : PhysicsemmagnetostaticMatrix) -> PhysicsemmagnetostaticMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_em_magnetostatic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_em_magnetostatic_matrix_scale(m : PhysicsemmagnetostaticMatrix, s : Double) -> PhysicsemmagnetostaticMatrix {
  let result = physics_em_magnetostatic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_em_magnetostatic_matrix_multiply(a : PhysicsemmagnetostaticMatrix, b : PhysicsemmagnetostaticMatrix) -> PhysicsemmagnetostaticMatrix {
  if a.cols != b.rows { return physics_em_magnetostatic_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_em_magnetostatic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_em_magnetostatic_matrix_trace(m : PhysicsemmagnetostaticMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_em_magnetostatic_matrix_det(m : PhysicsemmagnetostaticMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_em_magnetostatic_matrix_norm(m : PhysicsemmagnetostaticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_em_magnetostatic_matrix_to_string(m : PhysicsemmagnetostaticMatrix) -> String {
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

pub(all) struct PhysicsemmagnetostaticVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_em_magnetostatic_make_vector(comps : Array[Double]) -> PhysicsemmagnetostaticVector {
  { comps, dim: comps.length() }
}

pub fn physics_em_magnetostatic_vector_zero(dim : Int) -> PhysicsemmagnetostaticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_em_magnetostatic_vector_add(a : PhysicsemmagnetostaticVector, b : PhysicsemmagnetostaticVector) -> PhysicsemmagnetostaticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn physics_em_magnetostatic_vector_sub(a : PhysicsemmagnetostaticVector, b : PhysicsemmagnetostaticVector) -> PhysicsemmagnetostaticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn physics_em_magnetostatic_vector_scale(v : PhysicsemmagnetostaticVector, s : Double) -> PhysicsemmagnetostaticVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn physics_em_magnetostatic_vector_dot(a : PhysicsemmagnetostaticVector, b : PhysicsemmagnetostaticVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_em_magnetostatic_vector_norm(v : PhysicsemmagnetostaticVector) -> Double { @_common.sqrt(physics_em_magnetostatic_vector_dot(v, v)) }

pub fn physics_em_magnetostatic_vector_normalize(v : PhysicsemmagnetostaticVector) -> PhysicsemmagnetostaticVector {
  let n = physics_em_magnetostatic_vector_norm(v)
  if n < 0.0000001 { v } else { physics_em_magnetostatic_vector_scale(v, 1.0 / n) }
}

pub fn physics_em_magnetostatic_vector_dist(a : PhysicsemmagnetostaticVector, b : PhysicsemmagnetostaticVector) -> Double {
  physics_em_magnetostatic_vector_norm(physics_em_magnetostatic_vector_sub(a, b))
}

pub fn physics_em_magnetostatic_vector_to_string(v : PhysicsemmagnetostaticVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_em_magnetostatic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_em_magnetostatic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_em_magnetostatic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_em_magnetostatic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_em_magnetostatic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_em_magnetostatic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_em_magnetostatic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_em_magnetostatic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_em_magnetostatic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_em_magnetostatic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_em_magnetostatic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_em_magnetostatic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_em_magnetostatic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_em_magnetostatic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_em_magnetostatic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_em_magnetostatic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_em_magnetostatic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_em_magnetostatic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_em_magnetostatic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_em_magnetostatic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_em_magnetostatic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_em_magnetostatic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_em_magnetostatic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_em_magnetostatic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_em_magnetostatic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_em_magnetostatic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_em_magnetostatic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_em_magnetostatic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_em_magnetostatic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsemmagnetostaticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_frame_make(size : Int) -> PhysicsemmagnetostaticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_frame_len(s : PhysicsemmagnetostaticFrame) -> Int { s.size }

pub fn physics_em_magnetostatic_frame_get(s : PhysicsemmagnetostaticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_frame_set(s : PhysicsemmagnetostaticFrame, i : Int, v : Double) -> PhysicsemmagnetostaticFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_frame_sum(s : PhysicsemmagnetostaticFrame) -> Double { @_common.sum(s.data) }

pub fn physics_em_magnetostatic_frame_mean(s : PhysicsemmagnetostaticFrame) -> Double { @_common.mean(s.data) }

pub fn physics_em_magnetostatic_frame_scale(s : PhysicsemmagnetostaticFrame, f : Double) -> PhysicsemmagnetostaticFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_frame_add(a : PhysicsemmagnetostaticFrame, b : PhysicsemmagnetostaticFrame) -> PhysicsemmagnetostaticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_magnetostatic_frame_copy(s : PhysicsemmagnetostaticFrame) -> PhysicsemmagnetostaticFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_frame_fill(s : PhysicsemmagnetostaticFrame, v : Double) -> PhysicsemmagnetostaticFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_frame_min(s : PhysicsemmagnetostaticFrame) -> Double { @_common.min(s.data) }

pub fn physics_em_magnetostatic_frame_max(s : PhysicsemmagnetostaticFrame) -> Double { @_common.max(s.data) }

pub fn physics_em_magnetostatic_frame_to_string(s : PhysicsemmagnetostaticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_table_make(size : Int) -> PhysicsemmagnetostaticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_table_len(s : PhysicsemmagnetostaticTable) -> Int { s.size }

pub fn physics_em_magnetostatic_table_get(s : PhysicsemmagnetostaticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_table_set(s : PhysicsemmagnetostaticTable, i : Int, v : Double) -> PhysicsemmagnetostaticTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_table_sum(s : PhysicsemmagnetostaticTable) -> Double { @_common.sum(s.data) }

pub fn physics_em_magnetostatic_table_mean(s : PhysicsemmagnetostaticTable) -> Double { @_common.mean(s.data) }

pub fn physics_em_magnetostatic_table_scale(s : PhysicsemmagnetostaticTable, f : Double) -> PhysicsemmagnetostaticTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_table_add(a : PhysicsemmagnetostaticTable, b : PhysicsemmagnetostaticTable) -> PhysicsemmagnetostaticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_magnetostatic_table_copy(s : PhysicsemmagnetostaticTable) -> PhysicsemmagnetostaticTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_table_fill(s : PhysicsemmagnetostaticTable, v : Double) -> PhysicsemmagnetostaticTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_table_min(s : PhysicsemmagnetostaticTable) -> Double { @_common.min(s.data) }

pub fn physics_em_magnetostatic_table_max(s : PhysicsemmagnetostaticTable) -> Double { @_common.max(s.data) }

pub fn physics_em_magnetostatic_table_to_string(s : PhysicsemmagnetostaticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_graphn_make(size : Int) -> PhysicsemmagnetostaticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_graphn_len(s : PhysicsemmagnetostaticGraphN) -> Int { s.size }

pub fn physics_em_magnetostatic_graphn_get(s : PhysicsemmagnetostaticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_graphn_set(s : PhysicsemmagnetostaticGraphN, i : Int, v : Double) -> PhysicsemmagnetostaticGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_graphn_sum(s : PhysicsemmagnetostaticGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_em_magnetostatic_graphn_mean(s : PhysicsemmagnetostaticGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_em_magnetostatic_graphn_scale(s : PhysicsemmagnetostaticGraphN, f : Double) -> PhysicsemmagnetostaticGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_graphn_add(a : PhysicsemmagnetostaticGraphN, b : PhysicsemmagnetostaticGraphN) -> PhysicsemmagnetostaticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_magnetostatic_graphn_copy(s : PhysicsemmagnetostaticGraphN) -> PhysicsemmagnetostaticGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_graphn_fill(s : PhysicsemmagnetostaticGraphN, v : Double) -> PhysicsemmagnetostaticGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_graphn_min(s : PhysicsemmagnetostaticGraphN) -> Double { @_common.min(s.data) }

pub fn physics_em_magnetostatic_graphn_max(s : PhysicsemmagnetostaticGraphN) -> Double { @_common.max(s.data) }

pub fn physics_em_magnetostatic_graphn_to_string(s : PhysicsemmagnetostaticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_node_make(size : Int) -> PhysicsemmagnetostaticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_node_len(s : PhysicsemmagnetostaticNode) -> Int { s.size }

pub fn physics_em_magnetostatic_node_get(s : PhysicsemmagnetostaticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_node_set(s : PhysicsemmagnetostaticNode, i : Int, v : Double) -> PhysicsemmagnetostaticNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_node_sum(s : PhysicsemmagnetostaticNode) -> Double { @_common.sum(s.data) }

pub fn physics_em_magnetostatic_node_mean(s : PhysicsemmagnetostaticNode) -> Double { @_common.mean(s.data) }

pub fn physics_em_magnetostatic_node_scale(s : PhysicsemmagnetostaticNode, f : Double) -> PhysicsemmagnetostaticNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_node_add(a : PhysicsemmagnetostaticNode, b : PhysicsemmagnetostaticNode) -> PhysicsemmagnetostaticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_magnetostatic_node_copy(s : PhysicsemmagnetostaticNode) -> PhysicsemmagnetostaticNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_node_fill(s : PhysicsemmagnetostaticNode, v : Double) -> PhysicsemmagnetostaticNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_node_min(s : PhysicsemmagnetostaticNode) -> Double { @_common.min(s.data) }

pub fn physics_em_magnetostatic_node_max(s : PhysicsemmagnetostaticNode) -> Double { @_common.max(s.data) }

pub fn physics_em_magnetostatic_node_to_string(s : PhysicsemmagnetostaticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_edge_make(size : Int) -> PhysicsemmagnetostaticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_edge_len(s : PhysicsemmagnetostaticEdge) -> Int { s.size }

pub fn physics_em_magnetostatic_edge_get(s : PhysicsemmagnetostaticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_edge_set(s : PhysicsemmagnetostaticEdge, i : Int, v : Double) -> PhysicsemmagnetostaticEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_edge_sum(s : PhysicsemmagnetostaticEdge) -> Double { @_common.sum(s.data) }

pub fn physics_em_magnetostatic_edge_mean(s : PhysicsemmagnetostaticEdge) -> Double { @_common.mean(s.data) }

pub fn physics_em_magnetostatic_edge_scale(s : PhysicsemmagnetostaticEdge, f : Double) -> PhysicsemmagnetostaticEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_edge_add(a : PhysicsemmagnetostaticEdge, b : PhysicsemmagnetostaticEdge) -> PhysicsemmagnetostaticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_magnetostatic_edge_copy(s : PhysicsemmagnetostaticEdge) -> PhysicsemmagnetostaticEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_edge_fill(s : PhysicsemmagnetostaticEdge, v : Double) -> PhysicsemmagnetostaticEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_edge_min(s : PhysicsemmagnetostaticEdge) -> Double { @_common.min(s.data) }

pub fn physics_em_magnetostatic_edge_max(s : PhysicsemmagnetostaticEdge) -> Double { @_common.max(s.data) }

pub fn physics_em_magnetostatic_edge_to_string(s : PhysicsemmagnetostaticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_path_make(size : Int) -> PhysicsemmagnetostaticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_path_len(s : PhysicsemmagnetostaticPath) -> Int { s.size }

pub fn physics_em_magnetostatic_path_get(s : PhysicsemmagnetostaticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_path_set(s : PhysicsemmagnetostaticPath, i : Int, v : Double) -> PhysicsemmagnetostaticPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_path_sum(s : PhysicsemmagnetostaticPath) -> Double { @_common.sum(s.data) }

pub fn physics_em_magnetostatic_path_mean(s : PhysicsemmagnetostaticPath) -> Double { @_common.mean(s.data) }

pub fn physics_em_magnetostatic_path_scale(s : PhysicsemmagnetostaticPath, f : Double) -> PhysicsemmagnetostaticPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_path_add(a : PhysicsemmagnetostaticPath, b : PhysicsemmagnetostaticPath) -> PhysicsemmagnetostaticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_magnetostatic_path_copy(s : PhysicsemmagnetostaticPath) -> PhysicsemmagnetostaticPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_path_fill(s : PhysicsemmagnetostaticPath, v : Double) -> PhysicsemmagnetostaticPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_path_min(s : PhysicsemmagnetostaticPath) -> Double { @_common.min(s.data) }

pub fn physics_em_magnetostatic_path_max(s : PhysicsemmagnetostaticPath) -> Double { @_common.max(s.data) }

pub fn physics_em_magnetostatic_path_to_string(s : PhysicsemmagnetostaticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_cluster_make(size : Int) -> PhysicsemmagnetostaticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_cluster_len(s : PhysicsemmagnetostaticCluster) -> Int { s.size }

pub fn physics_em_magnetostatic_cluster_get(s : PhysicsemmagnetostaticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_cluster_set(s : PhysicsemmagnetostaticCluster, i : Int, v : Double) -> PhysicsemmagnetostaticCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_cluster_sum(s : PhysicsemmagnetostaticCluster) -> Double { @_common.sum(s.data) }

pub fn physics_em_magnetostatic_cluster_mean(s : PhysicsemmagnetostaticCluster) -> Double { @_common.mean(s.data) }

pub fn physics_em_magnetostatic_cluster_scale(s : PhysicsemmagnetostaticCluster, f : Double) -> PhysicsemmagnetostaticCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_cluster_add(a : PhysicsemmagnetostaticCluster, b : PhysicsemmagnetostaticCluster) -> PhysicsemmagnetostaticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_magnetostatic_cluster_copy(s : PhysicsemmagnetostaticCluster) -> PhysicsemmagnetostaticCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_cluster_fill(s : PhysicsemmagnetostaticCluster, v : Double) -> PhysicsemmagnetostaticCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_cluster_min(s : PhysicsemmagnetostaticCluster) -> Double { @_common.min(s.data) }

pub fn physics_em_magnetostatic_cluster_max(s : PhysicsemmagnetostaticCluster) -> Double { @_common.max(s.data) }

pub fn physics_em_magnetostatic_cluster_to_string(s : PhysicsemmagnetostaticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_model_make(size : Int) -> PhysicsemmagnetostaticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_model_len(s : PhysicsemmagnetostaticModel) -> Int { s.size }

pub fn physics_em_magnetostatic_model_get(s : PhysicsemmagnetostaticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_model_set(s : PhysicsemmagnetostaticModel, i : Int, v : Double) -> PhysicsemmagnetostaticModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_model_sum(s : PhysicsemmagnetostaticModel) -> Double { @_common.sum(s.data) }

pub fn physics_em_magnetostatic_model_mean(s : PhysicsemmagnetostaticModel) -> Double { @_common.mean(s.data) }

pub fn physics_em_magnetostatic_model_scale(s : PhysicsemmagnetostaticModel, f : Double) -> PhysicsemmagnetostaticModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_model_add(a : PhysicsemmagnetostaticModel, b : PhysicsemmagnetostaticModel) -> PhysicsemmagnetostaticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_magnetostatic_model_copy(s : PhysicsemmagnetostaticModel) -> PhysicsemmagnetostaticModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_model_fill(s : PhysicsemmagnetostaticModel, v : Double) -> PhysicsemmagnetostaticModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_model_min(s : PhysicsemmagnetostaticModel) -> Double { @_common.min(s.data) }

pub fn physics_em_magnetostatic_model_max(s : PhysicsemmagnetostaticModel) -> Double { @_common.max(s.data) }

pub fn physics_em_magnetostatic_model_to_string(s : PhysicsemmagnetostaticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_layer_make(size : Int) -> PhysicsemmagnetostaticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_layer_len(s : PhysicsemmagnetostaticLayer) -> Int { s.size }

pub fn physics_em_magnetostatic_layer_get(s : PhysicsemmagnetostaticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_layer_set(s : PhysicsemmagnetostaticLayer, i : Int, v : Double) -> PhysicsemmagnetostaticLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_layer_sum(s : PhysicsemmagnetostaticLayer) -> Double { @_common.sum(s.data) }

pub fn physics_em_magnetostatic_layer_mean(s : PhysicsemmagnetostaticLayer) -> Double { @_common.mean(s.data) }

pub fn physics_em_magnetostatic_layer_scale(s : PhysicsemmagnetostaticLayer, f : Double) -> PhysicsemmagnetostaticLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_layer_add(a : PhysicsemmagnetostaticLayer, b : PhysicsemmagnetostaticLayer) -> PhysicsemmagnetostaticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_magnetostatic_layer_copy(s : PhysicsemmagnetostaticLayer) -> PhysicsemmagnetostaticLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_layer_fill(s : PhysicsemmagnetostaticLayer, v : Double) -> PhysicsemmagnetostaticLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_layer_min(s : PhysicsemmagnetostaticLayer) -> Double { @_common.min(s.data) }

pub fn physics_em_magnetostatic_layer_max(s : PhysicsemmagnetostaticLayer) -> Double { @_common.max(s.data) }

pub fn physics_em_magnetostatic_layer_to_string(s : PhysicsemmagnetostaticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_buffer_make(size : Int) -> PhysicsemmagnetostaticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_buffer_len(s : PhysicsemmagnetostaticBuffer) -> Int { s.size }

pub fn physics_em_magnetostatic_buffer_get(s : PhysicsemmagnetostaticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_buffer_set(s : PhysicsemmagnetostaticBuffer, i : Int, v : Double) -> PhysicsemmagnetostaticBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_buffer_sum(s : PhysicsemmagnetostaticBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_em_magnetostatic_buffer_mean(s : PhysicsemmagnetostaticBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_em_magnetostatic_buffer_scale(s : PhysicsemmagnetostaticBuffer, f : Double) -> PhysicsemmagnetostaticBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_buffer_add(a : PhysicsemmagnetostaticBuffer, b : PhysicsemmagnetostaticBuffer) -> PhysicsemmagnetostaticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_magnetostatic_buffer_copy(s : PhysicsemmagnetostaticBuffer) -> PhysicsemmagnetostaticBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_buffer_fill(s : PhysicsemmagnetostaticBuffer, v : Double) -> PhysicsemmagnetostaticBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_buffer_min(s : PhysicsemmagnetostaticBuffer) -> Double { @_common.min(s.data) }

pub fn physics_em_magnetostatic_buffer_max(s : PhysicsemmagnetostaticBuffer) -> Double { @_common.max(s.data) }

pub fn physics_em_magnetostatic_buffer_to_string(s : PhysicsemmagnetostaticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_cursor_make(size : Int) -> PhysicsemmagnetostaticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_cursor_len(s : PhysicsemmagnetostaticCursor) -> Int { s.size }

pub fn physics_em_magnetostatic_cursor_get(s : PhysicsemmagnetostaticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_cursor_set(s : PhysicsemmagnetostaticCursor, i : Int, v : Double) -> PhysicsemmagnetostaticCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_cursor_sum(s : PhysicsemmagnetostaticCursor) -> Double { @_common.sum(s.data) }

pub fn physics_em_magnetostatic_cursor_mean(s : PhysicsemmagnetostaticCursor) -> Double { @_common.mean(s.data) }

pub fn physics_em_magnetostatic_cursor_scale(s : PhysicsemmagnetostaticCursor, f : Double) -> PhysicsemmagnetostaticCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_cursor_add(a : PhysicsemmagnetostaticCursor, b : PhysicsemmagnetostaticCursor) -> PhysicsemmagnetostaticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_magnetostatic_cursor_copy(s : PhysicsemmagnetostaticCursor) -> PhysicsemmagnetostaticCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_cursor_fill(s : PhysicsemmagnetostaticCursor, v : Double) -> PhysicsemmagnetostaticCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_cursor_min(s : PhysicsemmagnetostaticCursor) -> Double { @_common.min(s.data) }

pub fn physics_em_magnetostatic_cursor_max(s : PhysicsemmagnetostaticCursor) -> Double { @_common.max(s.data) }

pub fn physics_em_magnetostatic_cursor_to_string(s : PhysicsemmagnetostaticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_view_make(size : Int) -> PhysicsemmagnetostaticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_view_len(s : PhysicsemmagnetostaticView) -> Int { s.size }

pub fn physics_em_magnetostatic_view_get(s : PhysicsemmagnetostaticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_view_set(s : PhysicsemmagnetostaticView, i : Int, v : Double) -> PhysicsemmagnetostaticView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_view_sum(s : PhysicsemmagnetostaticView) -> Double { @_common.sum(s.data) }

pub fn physics_em_magnetostatic_view_mean(s : PhysicsemmagnetostaticView) -> Double { @_common.mean(s.data) }

pub fn physics_em_magnetostatic_view_scale(s : PhysicsemmagnetostaticView, f : Double) -> PhysicsemmagnetostaticView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_view_add(a : PhysicsemmagnetostaticView, b : PhysicsemmagnetostaticView) -> PhysicsemmagnetostaticView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_magnetostatic_view_copy(s : PhysicsemmagnetostaticView) -> PhysicsemmagnetostaticView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_view_fill(s : PhysicsemmagnetostaticView, v : Double) -> PhysicsemmagnetostaticView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_view_min(s : PhysicsemmagnetostaticView) -> Double { @_common.min(s.data) }

pub fn physics_em_magnetostatic_view_max(s : PhysicsemmagnetostaticView) -> Double { @_common.max(s.data) }

pub fn physics_em_magnetostatic_view_to_string(s : PhysicsemmagnetostaticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_range_make(size : Int) -> PhysicsemmagnetostaticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_range_len(s : PhysicsemmagnetostaticRange) -> Int { s.size }

pub fn physics_em_magnetostatic_range_get(s : PhysicsemmagnetostaticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_range_set(s : PhysicsemmagnetostaticRange, i : Int, v : Double) -> PhysicsemmagnetostaticRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_range_sum(s : PhysicsemmagnetostaticRange) -> Double { @_common.sum(s.data) }

pub fn physics_em_magnetostatic_range_mean(s : PhysicsemmagnetostaticRange) -> Double { @_common.mean(s.data) }

pub fn physics_em_magnetostatic_range_scale(s : PhysicsemmagnetostaticRange, f : Double) -> PhysicsemmagnetostaticRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_range_add(a : PhysicsemmagnetostaticRange, b : PhysicsemmagnetostaticRange) -> PhysicsemmagnetostaticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_magnetostatic_range_copy(s : PhysicsemmagnetostaticRange) -> PhysicsemmagnetostaticRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_range_fill(s : PhysicsemmagnetostaticRange, v : Double) -> PhysicsemmagnetostaticRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_range_min(s : PhysicsemmagnetostaticRange) -> Double { @_common.min(s.data) }

pub fn physics_em_magnetostatic_range_max(s : PhysicsemmagnetostaticRange) -> Double { @_common.max(s.data) }

pub fn physics_em_magnetostatic_range_to_string(s : PhysicsemmagnetostaticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_slice_make(size : Int) -> PhysicsemmagnetostaticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_slice_len(s : PhysicsemmagnetostaticSlice) -> Int { s.size }

pub fn physics_em_magnetostatic_slice_get(s : PhysicsemmagnetostaticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_slice_set(s : PhysicsemmagnetostaticSlice, i : Int, v : Double) -> PhysicsemmagnetostaticSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_slice_sum(s : PhysicsemmagnetostaticSlice) -> Double { @_common.sum(s.data) }

pub fn physics_em_magnetostatic_slice_mean(s : PhysicsemmagnetostaticSlice) -> Double { @_common.mean(s.data) }

pub fn physics_em_magnetostatic_slice_scale(s : PhysicsemmagnetostaticSlice, f : Double) -> PhysicsemmagnetostaticSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_slice_add(a : PhysicsemmagnetostaticSlice, b : PhysicsemmagnetostaticSlice) -> PhysicsemmagnetostaticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_magnetostatic_slice_copy(s : PhysicsemmagnetostaticSlice) -> PhysicsemmagnetostaticSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_slice_fill(s : PhysicsemmagnetostaticSlice, v : Double) -> PhysicsemmagnetostaticSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_magnetostatic_slice_min(s : PhysicsemmagnetostaticSlice) -> Double { @_common.min(s.data) }

pub fn physics_em_magnetostatic_slice_max(s : PhysicsemmagnetostaticSlice) -> Double { @_common.max(s.data) }

pub fn physics_em_magnetostatic_slice_to_string(s : PhysicsemmagnetostaticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

