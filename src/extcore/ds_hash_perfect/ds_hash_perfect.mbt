///===
/// extcore/ds_hash_perfect

pub(all) struct DshashperfectPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_perfect_make_point(x : Double, y : Double) -> DshashperfectPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_perfect_make_point3(x : Double, y : Double, z : Double) -> DshashperfectPoint {
  { x, y, z, label: 0 }
}

pub fn ds_hash_perfect_point_x(pt : DshashperfectPoint) -> Double { pt.x }

pub fn ds_hash_perfect_point_y(pt : DshashperfectPoint) -> Double { pt.y }

pub fn ds_hash_perfect_point_z(pt : DshashperfectPoint) -> Double { pt.z }

pub fn ds_hash_perfect_point_label(pt : DshashperfectPoint) -> Int { pt.label }

pub fn ds_hash_perfect_point_dist(a : DshashperfectPoint, b : DshashperfectPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_hash_perfect_point_add(a : DshashperfectPoint, b : DshashperfectPoint) -> DshashperfectPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_hash_perfect_point_sub(a : DshashperfectPoint, b : DshashperfectPoint) -> DshashperfectPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_hash_perfect_point_scale(pt : DshashperfectPoint, s : Double) -> DshashperfectPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_hash_perfect_point_dot(a : DshashperfectPoint, b : DshashperfectPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_hash_perfect_point_cross(a : DshashperfectPoint, b : DshashperfectPoint) -> DshashperfectPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_hash_perfect_point_norm(pt : DshashperfectPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_hash_perfect_point_normalize(pt : DshashperfectPoint) -> DshashperfectPoint {
  let n = ds_hash_perfect_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_hash_perfect_point_scale(pt, 1.0 / n) }
}

pub fn ds_hash_perfect_point_negate(pt : DshashperfectPoint) -> DshashperfectPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_hash_perfect_point_mid(a : DshashperfectPoint, b : DshashperfectPoint) -> DshashperfectPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_hash_perfect_point_lerp(a : DshashperfectPoint, b : DshashperfectPoint, t : Double) -> DshashperfectPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_hash_perfect_point_to_string(pt : DshashperfectPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DshashperfectSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_perfect_make_series(vals : Array[Double], name : String) -> DshashperfectSeries {
  { vals, name, meta: 0 }
}

pub fn ds_hash_perfect_series_len(s : DshashperfectSeries) -> Int { s.vals.length() }

pub fn ds_hash_perfect_series_sum(s : DshashperfectSeries) -> Double { @_common.sum(s.vals) }

pub fn ds_hash_perfect_series_mean(s : DshashperfectSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_hash_perfect_series_min(s : DshashperfectSeries) -> Double { @_common.min(s.vals) }

pub fn ds_hash_perfect_series_max(s : DshashperfectSeries) -> Double { @_common.max(s.vals) }

pub fn ds_hash_perfect_series_range(s : DshashperfectSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_hash_perfect_series_var(s : DshashperfectSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_hash_perfect_series_std(s : DshashperfectSeries) -> Double { @_common.std(s.vals) }

pub fn ds_hash_perfect_series_median(s : DshashperfectSeries) -> Double { @_common.median(s.vals) }

pub fn ds_hash_perfect_series_scale(s : DshashperfectSeries, f : Double) -> DshashperfectSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_hash_perfect_series_add(a : DshashperfectSeries, b : DshashperfectSeries) -> DshashperfectSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_hash_perfect_series_sub(a : DshashperfectSeries, b : DshashperfectSeries) -> DshashperfectSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_hash_perfect_series_normalize(s : DshashperfectSeries) -> DshashperfectSeries {
  let mn = ds_hash_perfect_series_min(s)
  let mx = ds_hash_perfect_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_hash_perfect_series_cumsum(s : DshashperfectSeries) -> DshashperfectSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_hash_perfect_series_to_string(s : DshashperfectSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashperfectMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_perfect_make_matrix(rows : Int, cols : Int, val : Double) -> DshashperfectMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_perfect_matrix_identity(n : Int) -> DshashperfectMatrix {
  let m = ds_hash_perfect_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_hash_perfect_matrix_get(m : DshashperfectMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_hash_perfect_matrix_transpose(m : DshashperfectMatrix) -> DshashperfectMatrix {
  let result = ds_hash_perfect_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_hash_perfect_matrix_add(a : DshashperfectMatrix, b : DshashperfectMatrix) -> DshashperfectMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_hash_perfect_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_hash_perfect_matrix_scale(m : DshashperfectMatrix, s : Double) -> DshashperfectMatrix {
  let result = ds_hash_perfect_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_hash_perfect_matrix_multiply(a : DshashperfectMatrix, b : DshashperfectMatrix) -> DshashperfectMatrix {
  if a.cols != b.rows { return ds_hash_perfect_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_hash_perfect_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_hash_perfect_matrix_trace(m : DshashperfectMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_hash_perfect_matrix_det(m : DshashperfectMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_hash_perfect_matrix_norm(m : DshashperfectMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_hash_perfect_matrix_to_string(m : DshashperfectMatrix) -> String {
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

pub(all) struct DshashperfectVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_perfect_make_vector(comps : Array[Double]) -> DshashperfectVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_perfect_vector_zero(dim : Int) -> DshashperfectVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_hash_perfect_vector_add(a : DshashperfectVector, b : DshashperfectVector) -> DshashperfectVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_perfect_vector_sub(a : DshashperfectVector, b : DshashperfectVector) -> DshashperfectVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_perfect_vector_scale(v : DshashperfectVector, s : Double) -> DshashperfectVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_hash_perfect_vector_dot(a : DshashperfectVector, b : DshashperfectVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_hash_perfect_vector_norm(v : DshashperfectVector) -> Double { @_common.sqrt(ds_hash_perfect_vector_dot(v, v)) }

pub fn ds_hash_perfect_vector_normalize(v : DshashperfectVector) -> DshashperfectVector {
  let n = ds_hash_perfect_vector_norm(v)
  if n < 0.0000001 { v } else { ds_hash_perfect_vector_scale(v, 1.0 / n) }
}

pub fn ds_hash_perfect_vector_dist(a : DshashperfectVector, b : DshashperfectVector) -> Double {
  ds_hash_perfect_vector_norm(ds_hash_perfect_vector_sub(a, b))
}

pub fn ds_hash_perfect_vector_to_string(v : DshashperfectVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_hash_perfect_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_hash_perfect_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_hash_perfect_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_hash_perfect_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_hash_perfect_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_hash_perfect_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_hash_perfect_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_hash_perfect_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_hash_perfect_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_hash_perfect_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_hash_perfect_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_hash_perfect_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_hash_perfect_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_hash_perfect_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_hash_perfect_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_hash_perfect_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_hash_perfect_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_hash_perfect_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_hash_perfect_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_hash_perfect_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_hash_perfect_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_hash_perfect_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_hash_perfect_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_hash_perfect_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_hash_perfect_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_hash_perfect_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_hash_perfect_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_hash_perfect_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_hash_perfect_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DshashperfectFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_frame_make(size : Int) -> DshashperfectFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_frame_len(s : DshashperfectFrame) -> Int { s.size }

pub fn ds_hash_perfect_frame_get(s : DshashperfectFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_frame_set(s : DshashperfectFrame, i : Int, v : Double) -> DshashperfectFrame {
  let result = ds_hash_perfect_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_frame_sum(s : DshashperfectFrame) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_frame_mean(s : DshashperfectFrame) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_frame_scale(s : DshashperfectFrame, f : Double) -> DshashperfectFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_frame_add(a : DshashperfectFrame, b : DshashperfectFrame) -> DshashperfectFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_frame_copy(s : DshashperfectFrame) -> DshashperfectFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_frame_fill(s : DshashperfectFrame, v : Double) -> DshashperfectFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_frame_min(s : DshashperfectFrame) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_frame_max(s : DshashperfectFrame) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_frame_to_string(s : DshashperfectFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_table_make(size : Int) -> DshashperfectTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_table_len(s : DshashperfectTable) -> Int { s.size }

pub fn ds_hash_perfect_table_get(s : DshashperfectTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_table_set(s : DshashperfectTable, i : Int, v : Double) -> DshashperfectTable {
  let result = ds_hash_perfect_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_table_sum(s : DshashperfectTable) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_table_mean(s : DshashperfectTable) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_table_scale(s : DshashperfectTable, f : Double) -> DshashperfectTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_table_add(a : DshashperfectTable, b : DshashperfectTable) -> DshashperfectTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_table_copy(s : DshashperfectTable) -> DshashperfectTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_table_fill(s : DshashperfectTable, v : Double) -> DshashperfectTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_table_min(s : DshashperfectTable) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_table_max(s : DshashperfectTable) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_table_to_string(s : DshashperfectTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_graphn_make(size : Int) -> DshashperfectGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_graphn_len(s : DshashperfectGraphN) -> Int { s.size }

pub fn ds_hash_perfect_graphn_get(s : DshashperfectGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_graphn_set(s : DshashperfectGraphN, i : Int, v : Double) -> DshashperfectGraphN {
  let result = ds_hash_perfect_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_graphn_sum(s : DshashperfectGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_graphn_mean(s : DshashperfectGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_graphn_scale(s : DshashperfectGraphN, f : Double) -> DshashperfectGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_graphn_add(a : DshashperfectGraphN, b : DshashperfectGraphN) -> DshashperfectGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_graphn_copy(s : DshashperfectGraphN) -> DshashperfectGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_graphn_fill(s : DshashperfectGraphN, v : Double) -> DshashperfectGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_graphn_min(s : DshashperfectGraphN) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_graphn_max(s : DshashperfectGraphN) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_graphn_to_string(s : DshashperfectGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_node_make(size : Int) -> DshashperfectNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_node_len(s : DshashperfectNode) -> Int { s.size }

pub fn ds_hash_perfect_node_get(s : DshashperfectNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_node_set(s : DshashperfectNode, i : Int, v : Double) -> DshashperfectNode {
  let result = ds_hash_perfect_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_node_sum(s : DshashperfectNode) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_node_mean(s : DshashperfectNode) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_node_scale(s : DshashperfectNode, f : Double) -> DshashperfectNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_node_add(a : DshashperfectNode, b : DshashperfectNode) -> DshashperfectNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_node_copy(s : DshashperfectNode) -> DshashperfectNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_node_fill(s : DshashperfectNode, v : Double) -> DshashperfectNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_node_min(s : DshashperfectNode) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_node_max(s : DshashperfectNode) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_node_to_string(s : DshashperfectNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_edge_make(size : Int) -> DshashperfectEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_edge_len(s : DshashperfectEdge) -> Int { s.size }

pub fn ds_hash_perfect_edge_get(s : DshashperfectEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_edge_set(s : DshashperfectEdge, i : Int, v : Double) -> DshashperfectEdge {
  let result = ds_hash_perfect_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_edge_sum(s : DshashperfectEdge) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_edge_mean(s : DshashperfectEdge) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_edge_scale(s : DshashperfectEdge, f : Double) -> DshashperfectEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_edge_add(a : DshashperfectEdge, b : DshashperfectEdge) -> DshashperfectEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_edge_copy(s : DshashperfectEdge) -> DshashperfectEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_edge_fill(s : DshashperfectEdge, v : Double) -> DshashperfectEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_edge_min(s : DshashperfectEdge) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_edge_max(s : DshashperfectEdge) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_edge_to_string(s : DshashperfectEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_path_make(size : Int) -> DshashperfectPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_path_len(s : DshashperfectPath) -> Int { s.size }

pub fn ds_hash_perfect_path_get(s : DshashperfectPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_path_set(s : DshashperfectPath, i : Int, v : Double) -> DshashperfectPath {
  let result = ds_hash_perfect_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_path_sum(s : DshashperfectPath) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_path_mean(s : DshashperfectPath) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_path_scale(s : DshashperfectPath, f : Double) -> DshashperfectPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_path_add(a : DshashperfectPath, b : DshashperfectPath) -> DshashperfectPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_path_copy(s : DshashperfectPath) -> DshashperfectPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_path_fill(s : DshashperfectPath, v : Double) -> DshashperfectPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_path_min(s : DshashperfectPath) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_path_max(s : DshashperfectPath) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_path_to_string(s : DshashperfectPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_cluster_make(size : Int) -> DshashperfectCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_cluster_len(s : DshashperfectCluster) -> Int { s.size }

pub fn ds_hash_perfect_cluster_get(s : DshashperfectCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_cluster_set(s : DshashperfectCluster, i : Int, v : Double) -> DshashperfectCluster {
  let result = ds_hash_perfect_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_cluster_sum(s : DshashperfectCluster) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_cluster_mean(s : DshashperfectCluster) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_cluster_scale(s : DshashperfectCluster, f : Double) -> DshashperfectCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_cluster_add(a : DshashperfectCluster, b : DshashperfectCluster) -> DshashperfectCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_cluster_copy(s : DshashperfectCluster) -> DshashperfectCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_cluster_fill(s : DshashperfectCluster, v : Double) -> DshashperfectCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_cluster_min(s : DshashperfectCluster) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_cluster_max(s : DshashperfectCluster) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_cluster_to_string(s : DshashperfectCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_model_make(size : Int) -> DshashperfectModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_model_len(s : DshashperfectModel) -> Int { s.size }

pub fn ds_hash_perfect_model_get(s : DshashperfectModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_model_set(s : DshashperfectModel, i : Int, v : Double) -> DshashperfectModel {
  let result = ds_hash_perfect_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_model_sum(s : DshashperfectModel) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_model_mean(s : DshashperfectModel) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_model_scale(s : DshashperfectModel, f : Double) -> DshashperfectModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_model_add(a : DshashperfectModel, b : DshashperfectModel) -> DshashperfectModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_model_copy(s : DshashperfectModel) -> DshashperfectModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_model_fill(s : DshashperfectModel, v : Double) -> DshashperfectModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_model_min(s : DshashperfectModel) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_model_max(s : DshashperfectModel) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_model_to_string(s : DshashperfectModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_layer_make(size : Int) -> DshashperfectLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_layer_len(s : DshashperfectLayer) -> Int { s.size }

pub fn ds_hash_perfect_layer_get(s : DshashperfectLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_layer_set(s : DshashperfectLayer, i : Int, v : Double) -> DshashperfectLayer {
  let result = ds_hash_perfect_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_layer_sum(s : DshashperfectLayer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_layer_mean(s : DshashperfectLayer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_layer_scale(s : DshashperfectLayer, f : Double) -> DshashperfectLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_layer_add(a : DshashperfectLayer, b : DshashperfectLayer) -> DshashperfectLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_layer_copy(s : DshashperfectLayer) -> DshashperfectLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_layer_fill(s : DshashperfectLayer, v : Double) -> DshashperfectLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_layer_min(s : DshashperfectLayer) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_layer_max(s : DshashperfectLayer) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_layer_to_string(s : DshashperfectLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_buffer_make(size : Int) -> DshashperfectBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_buffer_len(s : DshashperfectBuffer) -> Int { s.size }

pub fn ds_hash_perfect_buffer_get(s : DshashperfectBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_buffer_set(s : DshashperfectBuffer, i : Int, v : Double) -> DshashperfectBuffer {
  let result = ds_hash_perfect_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_buffer_sum(s : DshashperfectBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_buffer_mean(s : DshashperfectBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_buffer_scale(s : DshashperfectBuffer, f : Double) -> DshashperfectBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_buffer_add(a : DshashperfectBuffer, b : DshashperfectBuffer) -> DshashperfectBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_buffer_copy(s : DshashperfectBuffer) -> DshashperfectBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_buffer_fill(s : DshashperfectBuffer, v : Double) -> DshashperfectBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_buffer_min(s : DshashperfectBuffer) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_buffer_max(s : DshashperfectBuffer) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_buffer_to_string(s : DshashperfectBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_cursor_make(size : Int) -> DshashperfectCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_cursor_len(s : DshashperfectCursor) -> Int { s.size }

pub fn ds_hash_perfect_cursor_get(s : DshashperfectCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_cursor_set(s : DshashperfectCursor, i : Int, v : Double) -> DshashperfectCursor {
  let result = ds_hash_perfect_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_cursor_sum(s : DshashperfectCursor) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_cursor_mean(s : DshashperfectCursor) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_cursor_scale(s : DshashperfectCursor, f : Double) -> DshashperfectCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_cursor_add(a : DshashperfectCursor, b : DshashperfectCursor) -> DshashperfectCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_cursor_copy(s : DshashperfectCursor) -> DshashperfectCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_cursor_fill(s : DshashperfectCursor, v : Double) -> DshashperfectCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_cursor_min(s : DshashperfectCursor) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_cursor_max(s : DshashperfectCursor) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_cursor_to_string(s : DshashperfectCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_view_make(size : Int) -> DshashperfectView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_view_len(s : DshashperfectView) -> Int { s.size }

pub fn ds_hash_perfect_view_get(s : DshashperfectView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_view_set(s : DshashperfectView, i : Int, v : Double) -> DshashperfectView {
  let result = ds_hash_perfect_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_view_sum(s : DshashperfectView) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_view_mean(s : DshashperfectView) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_view_scale(s : DshashperfectView, f : Double) -> DshashperfectView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_view_add(a : DshashperfectView, b : DshashperfectView) -> DshashperfectView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_view_copy(s : DshashperfectView) -> DshashperfectView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_view_fill(s : DshashperfectView, v : Double) -> DshashperfectView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_view_min(s : DshashperfectView) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_view_max(s : DshashperfectView) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_view_to_string(s : DshashperfectView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_range_make(size : Int) -> DshashperfectRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_range_len(s : DshashperfectRange) -> Int { s.size }

pub fn ds_hash_perfect_range_get(s : DshashperfectRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_range_set(s : DshashperfectRange, i : Int, v : Double) -> DshashperfectRange {
  let result = ds_hash_perfect_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_range_sum(s : DshashperfectRange) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_range_mean(s : DshashperfectRange) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_range_scale(s : DshashperfectRange, f : Double) -> DshashperfectRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_range_add(a : DshashperfectRange, b : DshashperfectRange) -> DshashperfectRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_range_copy(s : DshashperfectRange) -> DshashperfectRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_range_fill(s : DshashperfectRange, v : Double) -> DshashperfectRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_range_min(s : DshashperfectRange) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_range_max(s : DshashperfectRange) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_range_to_string(s : DshashperfectRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_slice_make(size : Int) -> DshashperfectSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_slice_len(s : DshashperfectSlice) -> Int { s.size }

pub fn ds_hash_perfect_slice_get(s : DshashperfectSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_slice_set(s : DshashperfectSlice, i : Int, v : Double) -> DshashperfectSlice {
  let result = ds_hash_perfect_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_slice_sum(s : DshashperfectSlice) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_slice_mean(s : DshashperfectSlice) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_slice_scale(s : DshashperfectSlice, f : Double) -> DshashperfectSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_slice_add(a : DshashperfectSlice, b : DshashperfectSlice) -> DshashperfectSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_slice_copy(s : DshashperfectSlice) -> DshashperfectSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_slice_fill(s : DshashperfectSlice, v : Double) -> DshashperfectSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_slice_min(s : DshashperfectSlice) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_slice_max(s : DshashperfectSlice) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_slice_to_string(s : DshashperfectSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

