///===
/// extcore/bio_struct_distance

pub(all) struct BiostructdistancePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_distance_make_point(x : Double, y : Double) -> BiostructdistancePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_distance_make_point3(x : Double, y : Double, z : Double) -> BiostructdistancePoint {
  { x, y, z, label: 0 }
}

pub fn bio_struct_distance_point_x(pt : BiostructdistancePoint) -> Double { pt.x }

pub fn bio_struct_distance_point_y(pt : BiostructdistancePoint) -> Double { pt.y }

pub fn bio_struct_distance_point_z(pt : BiostructdistancePoint) -> Double { pt.z }

pub fn bio_struct_distance_point_label(pt : BiostructdistancePoint) -> Int { pt.label }

pub fn bio_struct_distance_point_dist(a : BiostructdistancePoint, b : BiostructdistancePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_struct_distance_point_add(a : BiostructdistancePoint, b : BiostructdistancePoint) -> BiostructdistancePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_struct_distance_point_sub(a : BiostructdistancePoint, b : BiostructdistancePoint) -> BiostructdistancePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_struct_distance_point_scale(pt : BiostructdistancePoint, s : Double) -> BiostructdistancePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_struct_distance_point_dot(a : BiostructdistancePoint, b : BiostructdistancePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_struct_distance_point_cross(a : BiostructdistancePoint, b : BiostructdistancePoint) -> BiostructdistancePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_struct_distance_point_norm(pt : BiostructdistancePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_struct_distance_point_normalize(pt : BiostructdistancePoint) -> BiostructdistancePoint {
  let n = bio_struct_distance_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_struct_distance_point_scale(pt, 1.0 / n) }
}

pub fn bio_struct_distance_point_negate(pt : BiostructdistancePoint) -> BiostructdistancePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_struct_distance_point_mid(a : BiostructdistancePoint, b : BiostructdistancePoint) -> BiostructdistancePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_struct_distance_point_lerp(a : BiostructdistancePoint, b : BiostructdistancePoint, t : Double) -> BiostructdistancePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_struct_distance_point_to_string(pt : BiostructdistancePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BiostructdistanceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_distance_make_series(vals : Array[Double], name : String) -> BiostructdistanceSeries {
  { vals, name, meta: 0 }
}

pub fn bio_struct_distance_series_len(s : BiostructdistanceSeries) -> Int { s.vals.length() }

pub fn bio_struct_distance_series_sum(s : BiostructdistanceSeries) -> Double { @_common.sum(s.vals) }

pub fn bio_struct_distance_series_mean(s : BiostructdistanceSeries) -> Double { @_common.mean(s.vals) }

pub fn bio_struct_distance_series_min(s : BiostructdistanceSeries) -> Double { @_common.min(s.vals) }

pub fn bio_struct_distance_series_max(s : BiostructdistanceSeries) -> Double { @_common.max(s.vals) }

pub fn bio_struct_distance_series_range(s : BiostructdistanceSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn bio_struct_distance_series_var(s : BiostructdistanceSeries) -> Double { @_common.variance(s.vals) }

pub fn bio_struct_distance_series_std(s : BiostructdistanceSeries) -> Double { @_common.std(s.vals) }

pub fn bio_struct_distance_series_median(s : BiostructdistanceSeries) -> Double { @_common.median(s.vals) }

pub fn bio_struct_distance_series_scale(s : BiostructdistanceSeries, f : Double) -> BiostructdistanceSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_struct_distance_series_add(a : BiostructdistanceSeries, b : BiostructdistanceSeries) -> BiostructdistanceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_struct_distance_series_sub(a : BiostructdistanceSeries, b : BiostructdistanceSeries) -> BiostructdistanceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_struct_distance_series_normalize(s : BiostructdistanceSeries) -> BiostructdistanceSeries {
  let mn = bio_struct_distance_series_min(s)
  let mx = bio_struct_distance_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_struct_distance_series_cumsum(s : BiostructdistanceSeries) -> BiostructdistanceSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_struct_distance_series_to_string(s : BiostructdistanceSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructdistanceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_distance_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructdistanceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_distance_matrix_identity(n : Int) -> BiostructdistanceMatrix {
  let m = bio_struct_distance_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_struct_distance_matrix_get(m : BiostructdistanceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_struct_distance_matrix_transpose(m : BiostructdistanceMatrix) -> BiostructdistanceMatrix {
  let result = bio_struct_distance_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_struct_distance_matrix_add(a : BiostructdistanceMatrix, b : BiostructdistanceMatrix) -> BiostructdistanceMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_struct_distance_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_struct_distance_matrix_scale(m : BiostructdistanceMatrix, s : Double) -> BiostructdistanceMatrix {
  let result = bio_struct_distance_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_struct_distance_matrix_multiply(a : BiostructdistanceMatrix, b : BiostructdistanceMatrix) -> BiostructdistanceMatrix {
  if a.cols != b.rows { return bio_struct_distance_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_struct_distance_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_struct_distance_matrix_trace(m : BiostructdistanceMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_struct_distance_matrix_det(m : BiostructdistanceMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_struct_distance_matrix_norm(m : BiostructdistanceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_struct_distance_matrix_to_string(m : BiostructdistanceMatrix) -> String {
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

pub(all) struct BiostructdistanceVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_distance_make_vector(comps : Array[Double]) -> BiostructdistanceVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_distance_vector_zero(dim : Int) -> BiostructdistanceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_struct_distance_vector_add(a : BiostructdistanceVector, b : BiostructdistanceVector) -> BiostructdistanceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_struct_distance_vector_sub(a : BiostructdistanceVector, b : BiostructdistanceVector) -> BiostructdistanceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_struct_distance_vector_scale(v : BiostructdistanceVector, s : Double) -> BiostructdistanceVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_struct_distance_vector_dot(a : BiostructdistanceVector, b : BiostructdistanceVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_struct_distance_vector_norm(v : BiostructdistanceVector) -> Double { @_common.sqrt(bio_struct_distance_vector_dot(v, v)) }

pub fn bio_struct_distance_vector_normalize(v : BiostructdistanceVector) -> BiostructdistanceVector {
  let n = bio_struct_distance_vector_norm(v)
  if n < 0.0000001 { v } else { bio_struct_distance_vector_scale(v, 1.0 / n) }
}

pub fn bio_struct_distance_vector_dist(a : BiostructdistanceVector, b : BiostructdistanceVector) -> Double {
  bio_struct_distance_vector_norm(bio_struct_distance_vector_sub(a, b))
}

pub fn bio_struct_distance_vector_to_string(v : BiostructdistanceVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_struct_distance_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_struct_distance_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_struct_distance_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_struct_distance_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_struct_distance_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_struct_distance_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_struct_distance_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_struct_distance_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_struct_distance_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_struct_distance_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_struct_distance_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_struct_distance_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_struct_distance_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_struct_distance_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_struct_distance_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_struct_distance_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_struct_distance_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_struct_distance_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_struct_distance_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_struct_distance_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_struct_distance_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_struct_distance_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_struct_distance_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_struct_distance_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_struct_distance_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_struct_distance_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_struct_distance_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_struct_distance_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_struct_distance_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiostructdistanceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_frame_make(size : Int) -> BiostructdistanceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_frame_len(s : BiostructdistanceFrame) -> Int { s.size }

pub fn bio_struct_distance_frame_get(s : BiostructdistanceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_frame_set(s : BiostructdistanceFrame, i : Int, v : Double) -> BiostructdistanceFrame {
  let result = bio_struct_distance_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_distance_frame_sum(s : BiostructdistanceFrame) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_frame_mean(s : BiostructdistanceFrame) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_frame_scale(s : BiostructdistanceFrame, f : Double) -> BiostructdistanceFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_frame_add(a : BiostructdistanceFrame, b : BiostructdistanceFrame) -> BiostructdistanceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_frame_copy(s : BiostructdistanceFrame) -> BiostructdistanceFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_frame_fill(s : BiostructdistanceFrame, v : Double) -> BiostructdistanceFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_frame_min(s : BiostructdistanceFrame) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_frame_max(s : BiostructdistanceFrame) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_frame_to_string(s : BiostructdistanceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_table_make(size : Int) -> BiostructdistanceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_table_len(s : BiostructdistanceTable) -> Int { s.size }

pub fn bio_struct_distance_table_get(s : BiostructdistanceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_table_set(s : BiostructdistanceTable, i : Int, v : Double) -> BiostructdistanceTable {
  let result = bio_struct_distance_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_distance_table_sum(s : BiostructdistanceTable) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_table_mean(s : BiostructdistanceTable) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_table_scale(s : BiostructdistanceTable, f : Double) -> BiostructdistanceTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_table_add(a : BiostructdistanceTable, b : BiostructdistanceTable) -> BiostructdistanceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_table_copy(s : BiostructdistanceTable) -> BiostructdistanceTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_table_fill(s : BiostructdistanceTable, v : Double) -> BiostructdistanceTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_table_min(s : BiostructdistanceTable) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_table_max(s : BiostructdistanceTable) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_table_to_string(s : BiostructdistanceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_graphn_make(size : Int) -> BiostructdistanceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_graphn_len(s : BiostructdistanceGraphN) -> Int { s.size }

pub fn bio_struct_distance_graphn_get(s : BiostructdistanceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_graphn_set(s : BiostructdistanceGraphN, i : Int, v : Double) -> BiostructdistanceGraphN {
  let result = bio_struct_distance_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_distance_graphn_sum(s : BiostructdistanceGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_graphn_mean(s : BiostructdistanceGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_graphn_scale(s : BiostructdistanceGraphN, f : Double) -> BiostructdistanceGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_graphn_add(a : BiostructdistanceGraphN, b : BiostructdistanceGraphN) -> BiostructdistanceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_graphn_copy(s : BiostructdistanceGraphN) -> BiostructdistanceGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_graphn_fill(s : BiostructdistanceGraphN, v : Double) -> BiostructdistanceGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_graphn_min(s : BiostructdistanceGraphN) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_graphn_max(s : BiostructdistanceGraphN) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_graphn_to_string(s : BiostructdistanceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_node_make(size : Int) -> BiostructdistanceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_node_len(s : BiostructdistanceNode) -> Int { s.size }

pub fn bio_struct_distance_node_get(s : BiostructdistanceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_node_set(s : BiostructdistanceNode, i : Int, v : Double) -> BiostructdistanceNode {
  let result = bio_struct_distance_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_distance_node_sum(s : BiostructdistanceNode) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_node_mean(s : BiostructdistanceNode) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_node_scale(s : BiostructdistanceNode, f : Double) -> BiostructdistanceNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_node_add(a : BiostructdistanceNode, b : BiostructdistanceNode) -> BiostructdistanceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_node_copy(s : BiostructdistanceNode) -> BiostructdistanceNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_node_fill(s : BiostructdistanceNode, v : Double) -> BiostructdistanceNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_node_min(s : BiostructdistanceNode) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_node_max(s : BiostructdistanceNode) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_node_to_string(s : BiostructdistanceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_edge_make(size : Int) -> BiostructdistanceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_edge_len(s : BiostructdistanceEdge) -> Int { s.size }

pub fn bio_struct_distance_edge_get(s : BiostructdistanceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_edge_set(s : BiostructdistanceEdge, i : Int, v : Double) -> BiostructdistanceEdge {
  let result = bio_struct_distance_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_distance_edge_sum(s : BiostructdistanceEdge) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_edge_mean(s : BiostructdistanceEdge) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_edge_scale(s : BiostructdistanceEdge, f : Double) -> BiostructdistanceEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_edge_add(a : BiostructdistanceEdge, b : BiostructdistanceEdge) -> BiostructdistanceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_edge_copy(s : BiostructdistanceEdge) -> BiostructdistanceEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_edge_fill(s : BiostructdistanceEdge, v : Double) -> BiostructdistanceEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_edge_min(s : BiostructdistanceEdge) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_edge_max(s : BiostructdistanceEdge) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_edge_to_string(s : BiostructdistanceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistancePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_path_make(size : Int) -> BiostructdistancePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_path_len(s : BiostructdistancePath) -> Int { s.size }

pub fn bio_struct_distance_path_get(s : BiostructdistancePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_path_set(s : BiostructdistancePath, i : Int, v : Double) -> BiostructdistancePath {
  let result = bio_struct_distance_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_distance_path_sum(s : BiostructdistancePath) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_path_mean(s : BiostructdistancePath) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_path_scale(s : BiostructdistancePath, f : Double) -> BiostructdistancePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_path_add(a : BiostructdistancePath, b : BiostructdistancePath) -> BiostructdistancePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_path_copy(s : BiostructdistancePath) -> BiostructdistancePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_path_fill(s : BiostructdistancePath, v : Double) -> BiostructdistancePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_path_min(s : BiostructdistancePath) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_path_max(s : BiostructdistancePath) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_path_to_string(s : BiostructdistancePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_cluster_make(size : Int) -> BiostructdistanceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_cluster_len(s : BiostructdistanceCluster) -> Int { s.size }

pub fn bio_struct_distance_cluster_get(s : BiostructdistanceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_cluster_set(s : BiostructdistanceCluster, i : Int, v : Double) -> BiostructdistanceCluster {
  let result = bio_struct_distance_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_distance_cluster_sum(s : BiostructdistanceCluster) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_cluster_mean(s : BiostructdistanceCluster) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_cluster_scale(s : BiostructdistanceCluster, f : Double) -> BiostructdistanceCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_cluster_add(a : BiostructdistanceCluster, b : BiostructdistanceCluster) -> BiostructdistanceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_cluster_copy(s : BiostructdistanceCluster) -> BiostructdistanceCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_cluster_fill(s : BiostructdistanceCluster, v : Double) -> BiostructdistanceCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_cluster_min(s : BiostructdistanceCluster) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_cluster_max(s : BiostructdistanceCluster) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_cluster_to_string(s : BiostructdistanceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_model_make(size : Int) -> BiostructdistanceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_model_len(s : BiostructdistanceModel) -> Int { s.size }

pub fn bio_struct_distance_model_get(s : BiostructdistanceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_model_set(s : BiostructdistanceModel, i : Int, v : Double) -> BiostructdistanceModel {
  let result = bio_struct_distance_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_distance_model_sum(s : BiostructdistanceModel) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_model_mean(s : BiostructdistanceModel) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_model_scale(s : BiostructdistanceModel, f : Double) -> BiostructdistanceModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_model_add(a : BiostructdistanceModel, b : BiostructdistanceModel) -> BiostructdistanceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_model_copy(s : BiostructdistanceModel) -> BiostructdistanceModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_model_fill(s : BiostructdistanceModel, v : Double) -> BiostructdistanceModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_model_min(s : BiostructdistanceModel) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_model_max(s : BiostructdistanceModel) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_model_to_string(s : BiostructdistanceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_layer_make(size : Int) -> BiostructdistanceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_layer_len(s : BiostructdistanceLayer) -> Int { s.size }

pub fn bio_struct_distance_layer_get(s : BiostructdistanceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_layer_set(s : BiostructdistanceLayer, i : Int, v : Double) -> BiostructdistanceLayer {
  let result = bio_struct_distance_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_distance_layer_sum(s : BiostructdistanceLayer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_layer_mean(s : BiostructdistanceLayer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_layer_scale(s : BiostructdistanceLayer, f : Double) -> BiostructdistanceLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_layer_add(a : BiostructdistanceLayer, b : BiostructdistanceLayer) -> BiostructdistanceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_layer_copy(s : BiostructdistanceLayer) -> BiostructdistanceLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_layer_fill(s : BiostructdistanceLayer, v : Double) -> BiostructdistanceLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_layer_min(s : BiostructdistanceLayer) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_layer_max(s : BiostructdistanceLayer) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_layer_to_string(s : BiostructdistanceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_buffer_make(size : Int) -> BiostructdistanceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_buffer_len(s : BiostructdistanceBuffer) -> Int { s.size }

pub fn bio_struct_distance_buffer_get(s : BiostructdistanceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_buffer_set(s : BiostructdistanceBuffer, i : Int, v : Double) -> BiostructdistanceBuffer {
  let result = bio_struct_distance_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_distance_buffer_sum(s : BiostructdistanceBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_buffer_mean(s : BiostructdistanceBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_buffer_scale(s : BiostructdistanceBuffer, f : Double) -> BiostructdistanceBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_buffer_add(a : BiostructdistanceBuffer, b : BiostructdistanceBuffer) -> BiostructdistanceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_buffer_copy(s : BiostructdistanceBuffer) -> BiostructdistanceBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_buffer_fill(s : BiostructdistanceBuffer, v : Double) -> BiostructdistanceBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_buffer_min(s : BiostructdistanceBuffer) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_buffer_max(s : BiostructdistanceBuffer) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_buffer_to_string(s : BiostructdistanceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_cursor_make(size : Int) -> BiostructdistanceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_cursor_len(s : BiostructdistanceCursor) -> Int { s.size }

pub fn bio_struct_distance_cursor_get(s : BiostructdistanceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_cursor_set(s : BiostructdistanceCursor, i : Int, v : Double) -> BiostructdistanceCursor {
  let result = bio_struct_distance_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_distance_cursor_sum(s : BiostructdistanceCursor) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_cursor_mean(s : BiostructdistanceCursor) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_cursor_scale(s : BiostructdistanceCursor, f : Double) -> BiostructdistanceCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_cursor_add(a : BiostructdistanceCursor, b : BiostructdistanceCursor) -> BiostructdistanceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_cursor_copy(s : BiostructdistanceCursor) -> BiostructdistanceCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_cursor_fill(s : BiostructdistanceCursor, v : Double) -> BiostructdistanceCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_cursor_min(s : BiostructdistanceCursor) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_cursor_max(s : BiostructdistanceCursor) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_cursor_to_string(s : BiostructdistanceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_view_make(size : Int) -> BiostructdistanceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_view_len(s : BiostructdistanceView) -> Int { s.size }

pub fn bio_struct_distance_view_get(s : BiostructdistanceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_view_set(s : BiostructdistanceView, i : Int, v : Double) -> BiostructdistanceView {
  let result = bio_struct_distance_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_distance_view_sum(s : BiostructdistanceView) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_view_mean(s : BiostructdistanceView) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_view_scale(s : BiostructdistanceView, f : Double) -> BiostructdistanceView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_view_add(a : BiostructdistanceView, b : BiostructdistanceView) -> BiostructdistanceView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_view_copy(s : BiostructdistanceView) -> BiostructdistanceView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_view_fill(s : BiostructdistanceView, v : Double) -> BiostructdistanceView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_view_min(s : BiostructdistanceView) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_view_max(s : BiostructdistanceView) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_view_to_string(s : BiostructdistanceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_range_make(size : Int) -> BiostructdistanceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_range_len(s : BiostructdistanceRange) -> Int { s.size }

pub fn bio_struct_distance_range_get(s : BiostructdistanceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_range_set(s : BiostructdistanceRange, i : Int, v : Double) -> BiostructdistanceRange {
  let result = bio_struct_distance_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_distance_range_sum(s : BiostructdistanceRange) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_range_mean(s : BiostructdistanceRange) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_range_scale(s : BiostructdistanceRange, f : Double) -> BiostructdistanceRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_range_add(a : BiostructdistanceRange, b : BiostructdistanceRange) -> BiostructdistanceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_range_copy(s : BiostructdistanceRange) -> BiostructdistanceRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_range_fill(s : BiostructdistanceRange, v : Double) -> BiostructdistanceRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_range_min(s : BiostructdistanceRange) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_range_max(s : BiostructdistanceRange) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_range_to_string(s : BiostructdistanceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_slice_make(size : Int) -> BiostructdistanceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_slice_len(s : BiostructdistanceSlice) -> Int { s.size }

pub fn bio_struct_distance_slice_get(s : BiostructdistanceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_slice_set(s : BiostructdistanceSlice, i : Int, v : Double) -> BiostructdistanceSlice {
  let result = bio_struct_distance_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_distance_slice_sum(s : BiostructdistanceSlice) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_slice_mean(s : BiostructdistanceSlice) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_slice_scale(s : BiostructdistanceSlice, f : Double) -> BiostructdistanceSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_slice_add(a : BiostructdistanceSlice, b : BiostructdistanceSlice) -> BiostructdistanceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_slice_copy(s : BiostructdistanceSlice) -> BiostructdistanceSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_slice_fill(s : BiostructdistanceSlice, v : Double) -> BiostructdistanceSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_slice_min(s : BiostructdistanceSlice) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_slice_max(s : BiostructdistanceSlice) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_slice_to_string(s : BiostructdistanceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

