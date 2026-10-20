///===
/// extcore/ds_hash_quadratic

pub(all) struct DshashquadraticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_quadratic_make_point(x : Double, y : Double) -> DshashquadraticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_quadratic_make_point3(x : Double, y : Double, z : Double) -> DshashquadraticPoint {
  { x, y, z, label: 0 }
}

pub fn ds_hash_quadratic_point_x(pt : DshashquadraticPoint) -> Double { pt.x }

pub fn ds_hash_quadratic_point_y(pt : DshashquadraticPoint) -> Double { pt.y }

pub fn ds_hash_quadratic_point_z(pt : DshashquadraticPoint) -> Double { pt.z }

pub fn ds_hash_quadratic_point_label(pt : DshashquadraticPoint) -> Int { pt.label }

pub fn ds_hash_quadratic_point_dist(a : DshashquadraticPoint, b : DshashquadraticPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_hash_quadratic_point_add(a : DshashquadraticPoint, b : DshashquadraticPoint) -> DshashquadraticPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_hash_quadratic_point_sub(a : DshashquadraticPoint, b : DshashquadraticPoint) -> DshashquadraticPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_hash_quadratic_point_scale(pt : DshashquadraticPoint, s : Double) -> DshashquadraticPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_hash_quadratic_point_dot(a : DshashquadraticPoint, b : DshashquadraticPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_hash_quadratic_point_cross(a : DshashquadraticPoint, b : DshashquadraticPoint) -> DshashquadraticPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_hash_quadratic_point_norm(pt : DshashquadraticPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_hash_quadratic_point_normalize(pt : DshashquadraticPoint) -> DshashquadraticPoint {
  let n = ds_hash_quadratic_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_hash_quadratic_point_scale(pt, 1.0 / n) }
}

pub fn ds_hash_quadratic_point_negate(pt : DshashquadraticPoint) -> DshashquadraticPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_hash_quadratic_point_mid(a : DshashquadraticPoint, b : DshashquadraticPoint) -> DshashquadraticPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_hash_quadratic_point_lerp(a : DshashquadraticPoint, b : DshashquadraticPoint, t : Double) -> DshashquadraticPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_hash_quadratic_point_to_string(pt : DshashquadraticPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DshashquadraticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_quadratic_make_series(vals : Array[Double], name : String) -> DshashquadraticSeries {
  { vals, name, meta: 0 }
}

pub fn ds_hash_quadratic_series_len(s : DshashquadraticSeries) -> Int { s.vals.length() }

pub fn ds_hash_quadratic_series_sum(s : DshashquadraticSeries) -> Double { @_common.sum(s.vals) }

pub fn ds_hash_quadratic_series_mean(s : DshashquadraticSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_hash_quadratic_series_min(s : DshashquadraticSeries) -> Double { @_common.min(s.vals) }

pub fn ds_hash_quadratic_series_max(s : DshashquadraticSeries) -> Double { @_common.max(s.vals) }

pub fn ds_hash_quadratic_series_range(s : DshashquadraticSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_hash_quadratic_series_var(s : DshashquadraticSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_hash_quadratic_series_std(s : DshashquadraticSeries) -> Double { @_common.std(s.vals) }

pub fn ds_hash_quadratic_series_median(s : DshashquadraticSeries) -> Double { @_common.median(s.vals) }

pub fn ds_hash_quadratic_series_scale(s : DshashquadraticSeries, f : Double) -> DshashquadraticSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn ds_hash_quadratic_series_add(a : DshashquadraticSeries, b : DshashquadraticSeries) -> DshashquadraticSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_hash_quadratic_series_sub(a : DshashquadraticSeries, b : DshashquadraticSeries) -> DshashquadraticSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_hash_quadratic_series_normalize(s : DshashquadraticSeries) -> DshashquadraticSeries {
  let mn = ds_hash_quadratic_series_min(s)
  let mx = ds_hash_quadratic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_hash_quadratic_series_cumsum(s : DshashquadraticSeries) -> DshashquadraticSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_hash_quadratic_series_to_string(s : DshashquadraticSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashquadraticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_quadratic_make_matrix(rows : Int, cols : Int, val : Double) -> DshashquadraticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_quadratic_matrix_identity(n : Int) -> DshashquadraticMatrix {
  let m = ds_hash_quadratic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_hash_quadratic_matrix_get(m : DshashquadraticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_hash_quadratic_matrix_transpose(m : DshashquadraticMatrix) -> DshashquadraticMatrix {
  let result = ds_hash_quadratic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_hash_quadratic_matrix_add(a : DshashquadraticMatrix, b : DshashquadraticMatrix) -> DshashquadraticMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_hash_quadratic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_hash_quadratic_matrix_scale(m : DshashquadraticMatrix, s : Double) -> DshashquadraticMatrix {
  let result = ds_hash_quadratic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_hash_quadratic_matrix_multiply(a : DshashquadraticMatrix, b : DshashquadraticMatrix) -> DshashquadraticMatrix {
  if a.cols != b.rows { return ds_hash_quadratic_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_hash_quadratic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_hash_quadratic_matrix_trace(m : DshashquadraticMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_hash_quadratic_matrix_det(m : DshashquadraticMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_hash_quadratic_matrix_norm(m : DshashquadraticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_hash_quadratic_matrix_to_string(m : DshashquadraticMatrix) -> String {
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

pub(all) struct DshashquadraticVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_quadratic_make_vector(comps : Array[Double]) -> DshashquadraticVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_quadratic_vector_zero(dim : Int) -> DshashquadraticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_hash_quadratic_vector_add(a : DshashquadraticVector, b : DshashquadraticVector) -> DshashquadraticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn ds_hash_quadratic_vector_sub(a : DshashquadraticVector, b : DshashquadraticVector) -> DshashquadraticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn ds_hash_quadratic_vector_scale(v : DshashquadraticVector, s : Double) -> DshashquadraticVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn ds_hash_quadratic_vector_dot(a : DshashquadraticVector, b : DshashquadraticVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_hash_quadratic_vector_norm(v : DshashquadraticVector) -> Double { @_common.sqrt(ds_hash_quadratic_vector_dot(v, v)) }

pub fn ds_hash_quadratic_vector_normalize(v : DshashquadraticVector) -> DshashquadraticVector {
  let n = ds_hash_quadratic_vector_norm(v)
  if n < 0.0000001 { v } else { ds_hash_quadratic_vector_scale(v, 1.0 / n) }
}

pub fn ds_hash_quadratic_vector_dist(a : DshashquadraticVector, b : DshashquadraticVector) -> Double {
  ds_hash_quadratic_vector_norm(ds_hash_quadratic_vector_sub(a, b))
}

pub fn ds_hash_quadratic_vector_to_string(v : DshashquadraticVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_hash_quadratic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_hash_quadratic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_hash_quadratic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_hash_quadratic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_hash_quadratic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_hash_quadratic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_hash_quadratic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_hash_quadratic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_hash_quadratic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_hash_quadratic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_hash_quadratic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_hash_quadratic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_hash_quadratic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_hash_quadratic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_hash_quadratic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_hash_quadratic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_hash_quadratic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_hash_quadratic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_hash_quadratic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_hash_quadratic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_hash_quadratic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_hash_quadratic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_hash_quadratic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_hash_quadratic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_hash_quadratic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_hash_quadratic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_hash_quadratic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_hash_quadratic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_hash_quadratic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DshashquadraticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_frame_make(size : Int) -> DshashquadraticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_frame_len(s : DshashquadraticFrame) -> Int { s.size }

pub fn ds_hash_quadratic_frame_get(s : DshashquadraticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_frame_set(s : DshashquadraticFrame, i : Int, v : Double) -> DshashquadraticFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_frame_sum(s : DshashquadraticFrame) -> Double { @_common.sum(s.data) }

pub fn ds_hash_quadratic_frame_mean(s : DshashquadraticFrame) -> Double { @_common.mean(s.data) }

pub fn ds_hash_quadratic_frame_scale(s : DshashquadraticFrame, f : Double) -> DshashquadraticFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_frame_add(a : DshashquadraticFrame, b : DshashquadraticFrame) -> DshashquadraticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_quadratic_frame_copy(s : DshashquadraticFrame) -> DshashquadraticFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_frame_fill(s : DshashquadraticFrame, v : Double) -> DshashquadraticFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_frame_min(s : DshashquadraticFrame) -> Double { @_common.min(s.data) }

pub fn ds_hash_quadratic_frame_max(s : DshashquadraticFrame) -> Double { @_common.max(s.data) }

pub fn ds_hash_quadratic_frame_to_string(s : DshashquadraticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_table_make(size : Int) -> DshashquadraticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_table_len(s : DshashquadraticTable) -> Int { s.size }

pub fn ds_hash_quadratic_table_get(s : DshashquadraticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_table_set(s : DshashquadraticTable, i : Int, v : Double) -> DshashquadraticTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_table_sum(s : DshashquadraticTable) -> Double { @_common.sum(s.data) }

pub fn ds_hash_quadratic_table_mean(s : DshashquadraticTable) -> Double { @_common.mean(s.data) }

pub fn ds_hash_quadratic_table_scale(s : DshashquadraticTable, f : Double) -> DshashquadraticTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_table_add(a : DshashquadraticTable, b : DshashquadraticTable) -> DshashquadraticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_quadratic_table_copy(s : DshashquadraticTable) -> DshashquadraticTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_table_fill(s : DshashquadraticTable, v : Double) -> DshashquadraticTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_table_min(s : DshashquadraticTable) -> Double { @_common.min(s.data) }

pub fn ds_hash_quadratic_table_max(s : DshashquadraticTable) -> Double { @_common.max(s.data) }

pub fn ds_hash_quadratic_table_to_string(s : DshashquadraticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_graphn_make(size : Int) -> DshashquadraticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_graphn_len(s : DshashquadraticGraphN) -> Int { s.size }

pub fn ds_hash_quadratic_graphn_get(s : DshashquadraticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_graphn_set(s : DshashquadraticGraphN, i : Int, v : Double) -> DshashquadraticGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_graphn_sum(s : DshashquadraticGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_hash_quadratic_graphn_mean(s : DshashquadraticGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_hash_quadratic_graphn_scale(s : DshashquadraticGraphN, f : Double) -> DshashquadraticGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_graphn_add(a : DshashquadraticGraphN, b : DshashquadraticGraphN) -> DshashquadraticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_quadratic_graphn_copy(s : DshashquadraticGraphN) -> DshashquadraticGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_graphn_fill(s : DshashquadraticGraphN, v : Double) -> DshashquadraticGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_graphn_min(s : DshashquadraticGraphN) -> Double { @_common.min(s.data) }

pub fn ds_hash_quadratic_graphn_max(s : DshashquadraticGraphN) -> Double { @_common.max(s.data) }

pub fn ds_hash_quadratic_graphn_to_string(s : DshashquadraticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_node_make(size : Int) -> DshashquadraticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_node_len(s : DshashquadraticNode) -> Int { s.size }

pub fn ds_hash_quadratic_node_get(s : DshashquadraticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_node_set(s : DshashquadraticNode, i : Int, v : Double) -> DshashquadraticNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_node_sum(s : DshashquadraticNode) -> Double { @_common.sum(s.data) }

pub fn ds_hash_quadratic_node_mean(s : DshashquadraticNode) -> Double { @_common.mean(s.data) }

pub fn ds_hash_quadratic_node_scale(s : DshashquadraticNode, f : Double) -> DshashquadraticNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_node_add(a : DshashquadraticNode, b : DshashquadraticNode) -> DshashquadraticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_quadratic_node_copy(s : DshashquadraticNode) -> DshashquadraticNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_node_fill(s : DshashquadraticNode, v : Double) -> DshashquadraticNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_node_min(s : DshashquadraticNode) -> Double { @_common.min(s.data) }

pub fn ds_hash_quadratic_node_max(s : DshashquadraticNode) -> Double { @_common.max(s.data) }

pub fn ds_hash_quadratic_node_to_string(s : DshashquadraticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_edge_make(size : Int) -> DshashquadraticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_edge_len(s : DshashquadraticEdge) -> Int { s.size }

pub fn ds_hash_quadratic_edge_get(s : DshashquadraticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_edge_set(s : DshashquadraticEdge, i : Int, v : Double) -> DshashquadraticEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_edge_sum(s : DshashquadraticEdge) -> Double { @_common.sum(s.data) }

pub fn ds_hash_quadratic_edge_mean(s : DshashquadraticEdge) -> Double { @_common.mean(s.data) }

pub fn ds_hash_quadratic_edge_scale(s : DshashquadraticEdge, f : Double) -> DshashquadraticEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_edge_add(a : DshashquadraticEdge, b : DshashquadraticEdge) -> DshashquadraticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_quadratic_edge_copy(s : DshashquadraticEdge) -> DshashquadraticEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_edge_fill(s : DshashquadraticEdge, v : Double) -> DshashquadraticEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_edge_min(s : DshashquadraticEdge) -> Double { @_common.min(s.data) }

pub fn ds_hash_quadratic_edge_max(s : DshashquadraticEdge) -> Double { @_common.max(s.data) }

pub fn ds_hash_quadratic_edge_to_string(s : DshashquadraticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_path_make(size : Int) -> DshashquadraticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_path_len(s : DshashquadraticPath) -> Int { s.size }

pub fn ds_hash_quadratic_path_get(s : DshashquadraticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_path_set(s : DshashquadraticPath, i : Int, v : Double) -> DshashquadraticPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_path_sum(s : DshashquadraticPath) -> Double { @_common.sum(s.data) }

pub fn ds_hash_quadratic_path_mean(s : DshashquadraticPath) -> Double { @_common.mean(s.data) }

pub fn ds_hash_quadratic_path_scale(s : DshashquadraticPath, f : Double) -> DshashquadraticPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_path_add(a : DshashquadraticPath, b : DshashquadraticPath) -> DshashquadraticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_quadratic_path_copy(s : DshashquadraticPath) -> DshashquadraticPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_path_fill(s : DshashquadraticPath, v : Double) -> DshashquadraticPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_path_min(s : DshashquadraticPath) -> Double { @_common.min(s.data) }

pub fn ds_hash_quadratic_path_max(s : DshashquadraticPath) -> Double { @_common.max(s.data) }

pub fn ds_hash_quadratic_path_to_string(s : DshashquadraticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_cluster_make(size : Int) -> DshashquadraticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_cluster_len(s : DshashquadraticCluster) -> Int { s.size }

pub fn ds_hash_quadratic_cluster_get(s : DshashquadraticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_cluster_set(s : DshashquadraticCluster, i : Int, v : Double) -> DshashquadraticCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_cluster_sum(s : DshashquadraticCluster) -> Double { @_common.sum(s.data) }

pub fn ds_hash_quadratic_cluster_mean(s : DshashquadraticCluster) -> Double { @_common.mean(s.data) }

pub fn ds_hash_quadratic_cluster_scale(s : DshashquadraticCluster, f : Double) -> DshashquadraticCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_cluster_add(a : DshashquadraticCluster, b : DshashquadraticCluster) -> DshashquadraticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_quadratic_cluster_copy(s : DshashquadraticCluster) -> DshashquadraticCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_cluster_fill(s : DshashquadraticCluster, v : Double) -> DshashquadraticCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_cluster_min(s : DshashquadraticCluster) -> Double { @_common.min(s.data) }

pub fn ds_hash_quadratic_cluster_max(s : DshashquadraticCluster) -> Double { @_common.max(s.data) }

pub fn ds_hash_quadratic_cluster_to_string(s : DshashquadraticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_model_make(size : Int) -> DshashquadraticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_model_len(s : DshashquadraticModel) -> Int { s.size }

pub fn ds_hash_quadratic_model_get(s : DshashquadraticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_model_set(s : DshashquadraticModel, i : Int, v : Double) -> DshashquadraticModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_model_sum(s : DshashquadraticModel) -> Double { @_common.sum(s.data) }

pub fn ds_hash_quadratic_model_mean(s : DshashquadraticModel) -> Double { @_common.mean(s.data) }

pub fn ds_hash_quadratic_model_scale(s : DshashquadraticModel, f : Double) -> DshashquadraticModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_model_add(a : DshashquadraticModel, b : DshashquadraticModel) -> DshashquadraticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_quadratic_model_copy(s : DshashquadraticModel) -> DshashquadraticModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_model_fill(s : DshashquadraticModel, v : Double) -> DshashquadraticModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_model_min(s : DshashquadraticModel) -> Double { @_common.min(s.data) }

pub fn ds_hash_quadratic_model_max(s : DshashquadraticModel) -> Double { @_common.max(s.data) }

pub fn ds_hash_quadratic_model_to_string(s : DshashquadraticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_layer_make(size : Int) -> DshashquadraticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_layer_len(s : DshashquadraticLayer) -> Int { s.size }

pub fn ds_hash_quadratic_layer_get(s : DshashquadraticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_layer_set(s : DshashquadraticLayer, i : Int, v : Double) -> DshashquadraticLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_layer_sum(s : DshashquadraticLayer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_quadratic_layer_mean(s : DshashquadraticLayer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_quadratic_layer_scale(s : DshashquadraticLayer, f : Double) -> DshashquadraticLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_layer_add(a : DshashquadraticLayer, b : DshashquadraticLayer) -> DshashquadraticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_quadratic_layer_copy(s : DshashquadraticLayer) -> DshashquadraticLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_layer_fill(s : DshashquadraticLayer, v : Double) -> DshashquadraticLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_layer_min(s : DshashquadraticLayer) -> Double { @_common.min(s.data) }

pub fn ds_hash_quadratic_layer_max(s : DshashquadraticLayer) -> Double { @_common.max(s.data) }

pub fn ds_hash_quadratic_layer_to_string(s : DshashquadraticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_buffer_make(size : Int) -> DshashquadraticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_buffer_len(s : DshashquadraticBuffer) -> Int { s.size }

pub fn ds_hash_quadratic_buffer_get(s : DshashquadraticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_buffer_set(s : DshashquadraticBuffer, i : Int, v : Double) -> DshashquadraticBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_buffer_sum(s : DshashquadraticBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_quadratic_buffer_mean(s : DshashquadraticBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_quadratic_buffer_scale(s : DshashquadraticBuffer, f : Double) -> DshashquadraticBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_buffer_add(a : DshashquadraticBuffer, b : DshashquadraticBuffer) -> DshashquadraticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_quadratic_buffer_copy(s : DshashquadraticBuffer) -> DshashquadraticBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_buffer_fill(s : DshashquadraticBuffer, v : Double) -> DshashquadraticBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_buffer_min(s : DshashquadraticBuffer) -> Double { @_common.min(s.data) }

pub fn ds_hash_quadratic_buffer_max(s : DshashquadraticBuffer) -> Double { @_common.max(s.data) }

pub fn ds_hash_quadratic_buffer_to_string(s : DshashquadraticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_cursor_make(size : Int) -> DshashquadraticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_cursor_len(s : DshashquadraticCursor) -> Int { s.size }

pub fn ds_hash_quadratic_cursor_get(s : DshashquadraticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_cursor_set(s : DshashquadraticCursor, i : Int, v : Double) -> DshashquadraticCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_cursor_sum(s : DshashquadraticCursor) -> Double { @_common.sum(s.data) }

pub fn ds_hash_quadratic_cursor_mean(s : DshashquadraticCursor) -> Double { @_common.mean(s.data) }

pub fn ds_hash_quadratic_cursor_scale(s : DshashquadraticCursor, f : Double) -> DshashquadraticCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_cursor_add(a : DshashquadraticCursor, b : DshashquadraticCursor) -> DshashquadraticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_quadratic_cursor_copy(s : DshashquadraticCursor) -> DshashquadraticCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_cursor_fill(s : DshashquadraticCursor, v : Double) -> DshashquadraticCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_cursor_min(s : DshashquadraticCursor) -> Double { @_common.min(s.data) }

pub fn ds_hash_quadratic_cursor_max(s : DshashquadraticCursor) -> Double { @_common.max(s.data) }

pub fn ds_hash_quadratic_cursor_to_string(s : DshashquadraticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_view_make(size : Int) -> DshashquadraticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_view_len(s : DshashquadraticView) -> Int { s.size }

pub fn ds_hash_quadratic_view_get(s : DshashquadraticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_view_set(s : DshashquadraticView, i : Int, v : Double) -> DshashquadraticView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_view_sum(s : DshashquadraticView) -> Double { @_common.sum(s.data) }

pub fn ds_hash_quadratic_view_mean(s : DshashquadraticView) -> Double { @_common.mean(s.data) }

pub fn ds_hash_quadratic_view_scale(s : DshashquadraticView, f : Double) -> DshashquadraticView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_view_add(a : DshashquadraticView, b : DshashquadraticView) -> DshashquadraticView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_quadratic_view_copy(s : DshashquadraticView) -> DshashquadraticView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_view_fill(s : DshashquadraticView, v : Double) -> DshashquadraticView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_view_min(s : DshashquadraticView) -> Double { @_common.min(s.data) }

pub fn ds_hash_quadratic_view_max(s : DshashquadraticView) -> Double { @_common.max(s.data) }

pub fn ds_hash_quadratic_view_to_string(s : DshashquadraticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_range_make(size : Int) -> DshashquadraticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_range_len(s : DshashquadraticRange) -> Int { s.size }

pub fn ds_hash_quadratic_range_get(s : DshashquadraticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_range_set(s : DshashquadraticRange, i : Int, v : Double) -> DshashquadraticRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_range_sum(s : DshashquadraticRange) -> Double { @_common.sum(s.data) }

pub fn ds_hash_quadratic_range_mean(s : DshashquadraticRange) -> Double { @_common.mean(s.data) }

pub fn ds_hash_quadratic_range_scale(s : DshashquadraticRange, f : Double) -> DshashquadraticRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_range_add(a : DshashquadraticRange, b : DshashquadraticRange) -> DshashquadraticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_quadratic_range_copy(s : DshashquadraticRange) -> DshashquadraticRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_range_fill(s : DshashquadraticRange, v : Double) -> DshashquadraticRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_range_min(s : DshashquadraticRange) -> Double { @_common.min(s.data) }

pub fn ds_hash_quadratic_range_max(s : DshashquadraticRange) -> Double { @_common.max(s.data) }

pub fn ds_hash_quadratic_range_to_string(s : DshashquadraticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_slice_make(size : Int) -> DshashquadraticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_slice_len(s : DshashquadraticSlice) -> Int { s.size }

pub fn ds_hash_quadratic_slice_get(s : DshashquadraticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_slice_set(s : DshashquadraticSlice, i : Int, v : Double) -> DshashquadraticSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_slice_sum(s : DshashquadraticSlice) -> Double { @_common.sum(s.data) }

pub fn ds_hash_quadratic_slice_mean(s : DshashquadraticSlice) -> Double { @_common.mean(s.data) }

pub fn ds_hash_quadratic_slice_scale(s : DshashquadraticSlice, f : Double) -> DshashquadraticSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_slice_add(a : DshashquadraticSlice, b : DshashquadraticSlice) -> DshashquadraticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_quadratic_slice_copy(s : DshashquadraticSlice) -> DshashquadraticSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_slice_fill(s : DshashquadraticSlice, v : Double) -> DshashquadraticSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_quadratic_slice_min(s : DshashquadraticSlice) -> Double { @_common.min(s.data) }

pub fn ds_hash_quadratic_slice_max(s : DshashquadraticSlice) -> Double { @_common.max(s.data) }

pub fn ds_hash_quadratic_slice_to_string(s : DshashquadraticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

