///===
/// extcore/math_matrix_decomp

pub(all) struct MathmatrixdecompPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_matrix_decomp_make_point(x : Double, y : Double) -> MathmatrixdecompPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_matrix_decomp_make_point3(x : Double, y : Double, z : Double) -> MathmatrixdecompPoint {
  { x, y, z, label: 0 }
}

pub fn math_matrix_decomp_point_x(pt : MathmatrixdecompPoint) -> Double { pt.x }

pub fn math_matrix_decomp_point_y(pt : MathmatrixdecompPoint) -> Double { pt.y }

pub fn math_matrix_decomp_point_z(pt : MathmatrixdecompPoint) -> Double { pt.z }

pub fn math_matrix_decomp_point_label(pt : MathmatrixdecompPoint) -> Int { pt.label }

pub fn math_matrix_decomp_point_dist(a : MathmatrixdecompPoint, b : MathmatrixdecompPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_matrix_decomp_point_add(a : MathmatrixdecompPoint, b : MathmatrixdecompPoint) -> MathmatrixdecompPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_matrix_decomp_point_sub(a : MathmatrixdecompPoint, b : MathmatrixdecompPoint) -> MathmatrixdecompPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_matrix_decomp_point_scale(pt : MathmatrixdecompPoint, s : Double) -> MathmatrixdecompPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_matrix_decomp_point_dot(a : MathmatrixdecompPoint, b : MathmatrixdecompPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_matrix_decomp_point_cross(a : MathmatrixdecompPoint, b : MathmatrixdecompPoint) -> MathmatrixdecompPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_matrix_decomp_point_norm(pt : MathmatrixdecompPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_matrix_decomp_point_normalize(pt : MathmatrixdecompPoint) -> MathmatrixdecompPoint {
  let n = math_matrix_decomp_point_norm(pt)
  if n < 0.0000001 { pt } else { math_matrix_decomp_point_scale(pt, 1.0 / n) }
}

pub fn math_matrix_decomp_point_negate(pt : MathmatrixdecompPoint) -> MathmatrixdecompPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_matrix_decomp_point_mid(a : MathmatrixdecompPoint, b : MathmatrixdecompPoint) -> MathmatrixdecompPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_matrix_decomp_point_lerp(a : MathmatrixdecompPoint, b : MathmatrixdecompPoint, t : Double) -> MathmatrixdecompPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_matrix_decomp_point_to_string(pt : MathmatrixdecompPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathmatrixdecompSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_matrix_decomp_make_series(vals : Array[Double], name : String) -> MathmatrixdecompSeries {
  { vals, name, meta: 0 }
}

pub fn math_matrix_decomp_series_len(s : MathmatrixdecompSeries) -> Int { s.vals.length() }

pub fn math_matrix_decomp_series_sum(s : MathmatrixdecompSeries) -> Double { @_common.sum(s.vals) }

pub fn math_matrix_decomp_series_mean(s : MathmatrixdecompSeries) -> Double { @_common.mean(s.vals) }

pub fn math_matrix_decomp_series_min(s : MathmatrixdecompSeries) -> Double { @_common.min(s.vals) }

pub fn math_matrix_decomp_series_max(s : MathmatrixdecompSeries) -> Double { @_common.max(s.vals) }

pub fn math_matrix_decomp_series_range(s : MathmatrixdecompSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn math_matrix_decomp_series_var(s : MathmatrixdecompSeries) -> Double { @_common.variance(s.vals) }

pub fn math_matrix_decomp_series_std(s : MathmatrixdecompSeries) -> Double { @_common.std(s.vals) }

pub fn math_matrix_decomp_series_median(s : MathmatrixdecompSeries) -> Double { @_common.median(s.vals) }

pub fn math_matrix_decomp_series_scale(s : MathmatrixdecompSeries, f : Double) -> MathmatrixdecompSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn math_matrix_decomp_series_add(a : MathmatrixdecompSeries, b : MathmatrixdecompSeries) -> MathmatrixdecompSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_matrix_decomp_series_sub(a : MathmatrixdecompSeries, b : MathmatrixdecompSeries) -> MathmatrixdecompSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_matrix_decomp_series_normalize(s : MathmatrixdecompSeries) -> MathmatrixdecompSeries {
  let mn = math_matrix_decomp_series_min(s)
  let mx = math_matrix_decomp_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_matrix_decomp_series_cumsum(s : MathmatrixdecompSeries) -> MathmatrixdecompSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_matrix_decomp_series_to_string(s : MathmatrixdecompSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathmatrixdecompMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_matrix_decomp_make_matrix(rows : Int, cols : Int, val : Double) -> MathmatrixdecompMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_matrix_decomp_matrix_identity(n : Int) -> MathmatrixdecompMatrix {
  let m = math_matrix_decomp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_matrix_decomp_matrix_get(m : MathmatrixdecompMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_matrix_decomp_matrix_transpose(m : MathmatrixdecompMatrix) -> MathmatrixdecompMatrix {
  let result = math_matrix_decomp_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_matrix_decomp_matrix_add(a : MathmatrixdecompMatrix, b : MathmatrixdecompMatrix) -> MathmatrixdecompMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_matrix_decomp_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_matrix_decomp_matrix_scale(m : MathmatrixdecompMatrix, s : Double) -> MathmatrixdecompMatrix {
  let result = math_matrix_decomp_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_matrix_decomp_matrix_multiply(a : MathmatrixdecompMatrix, b : MathmatrixdecompMatrix) -> MathmatrixdecompMatrix {
  if a.cols != b.rows { return math_matrix_decomp_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_matrix_decomp_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_matrix_decomp_matrix_trace(m : MathmatrixdecompMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_matrix_decomp_matrix_det(m : MathmatrixdecompMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_matrix_decomp_matrix_norm(m : MathmatrixdecompMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_matrix_decomp_matrix_to_string(m : MathmatrixdecompMatrix) -> String {
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

pub(all) struct MathmatrixdecompVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_matrix_decomp_make_vector(comps : Array[Double]) -> MathmatrixdecompVector {
  { comps, dim: comps.length() }
}

pub fn math_matrix_decomp_vector_zero(dim : Int) -> MathmatrixdecompVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_matrix_decomp_vector_add(a : MathmatrixdecompVector, b : MathmatrixdecompVector) -> MathmatrixdecompVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn math_matrix_decomp_vector_sub(a : MathmatrixdecompVector, b : MathmatrixdecompVector) -> MathmatrixdecompVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn math_matrix_decomp_vector_scale(v : MathmatrixdecompVector, s : Double) -> MathmatrixdecompVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn math_matrix_decomp_vector_dot(a : MathmatrixdecompVector, b : MathmatrixdecompVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_matrix_decomp_vector_norm(v : MathmatrixdecompVector) -> Double { @_common.sqrt(math_matrix_decomp_vector_dot(v, v)) }

pub fn math_matrix_decomp_vector_normalize(v : MathmatrixdecompVector) -> MathmatrixdecompVector {
  let n = math_matrix_decomp_vector_norm(v)
  if n < 0.0000001 { v } else { math_matrix_decomp_vector_scale(v, 1.0 / n) }
}

pub fn math_matrix_decomp_vector_dist(a : MathmatrixdecompVector, b : MathmatrixdecompVector) -> Double {
  math_matrix_decomp_vector_norm(math_matrix_decomp_vector_sub(a, b))
}

pub fn math_matrix_decomp_vector_to_string(v : MathmatrixdecompVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_matrix_decomp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_matrix_decomp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_matrix_decomp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_matrix_decomp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_matrix_decomp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_matrix_decomp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_matrix_decomp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_matrix_decomp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_matrix_decomp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_matrix_decomp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_matrix_decomp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_matrix_decomp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_matrix_decomp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_matrix_decomp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_matrix_decomp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_matrix_decomp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_matrix_decomp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_matrix_decomp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_matrix_decomp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_matrix_decomp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_matrix_decomp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_matrix_decomp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_matrix_decomp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_matrix_decomp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_matrix_decomp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_matrix_decomp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_matrix_decomp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_matrix_decomp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_matrix_decomp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathmatrixdecompFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_frame_make(size : Int) -> MathmatrixdecompFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_frame_len(s : MathmatrixdecompFrame) -> Int { s.size }

pub fn math_matrix_decomp_frame_get(s : MathmatrixdecompFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_frame_set(s : MathmatrixdecompFrame, i : Int, v : Double) -> MathmatrixdecompFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_frame_sum(s : MathmatrixdecompFrame) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_frame_mean(s : MathmatrixdecompFrame) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_frame_scale(s : MathmatrixdecompFrame, f : Double) -> MathmatrixdecompFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_frame_add(a : MathmatrixdecompFrame, b : MathmatrixdecompFrame) -> MathmatrixdecompFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_frame_copy(s : MathmatrixdecompFrame) -> MathmatrixdecompFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_frame_fill(s : MathmatrixdecompFrame, v : Double) -> MathmatrixdecompFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_frame_min(s : MathmatrixdecompFrame) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_frame_max(s : MathmatrixdecompFrame) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_frame_to_string(s : MathmatrixdecompFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_table_make(size : Int) -> MathmatrixdecompTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_table_len(s : MathmatrixdecompTable) -> Int { s.size }

pub fn math_matrix_decomp_table_get(s : MathmatrixdecompTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_table_set(s : MathmatrixdecompTable, i : Int, v : Double) -> MathmatrixdecompTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_table_sum(s : MathmatrixdecompTable) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_table_mean(s : MathmatrixdecompTable) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_table_scale(s : MathmatrixdecompTable, f : Double) -> MathmatrixdecompTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_table_add(a : MathmatrixdecompTable, b : MathmatrixdecompTable) -> MathmatrixdecompTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_table_copy(s : MathmatrixdecompTable) -> MathmatrixdecompTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_table_fill(s : MathmatrixdecompTable, v : Double) -> MathmatrixdecompTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_table_min(s : MathmatrixdecompTable) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_table_max(s : MathmatrixdecompTable) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_table_to_string(s : MathmatrixdecompTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_graphn_make(size : Int) -> MathmatrixdecompGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_graphn_len(s : MathmatrixdecompGraphN) -> Int { s.size }

pub fn math_matrix_decomp_graphn_get(s : MathmatrixdecompGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_graphn_set(s : MathmatrixdecompGraphN, i : Int, v : Double) -> MathmatrixdecompGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_graphn_sum(s : MathmatrixdecompGraphN) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_graphn_mean(s : MathmatrixdecompGraphN) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_graphn_scale(s : MathmatrixdecompGraphN, f : Double) -> MathmatrixdecompGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_graphn_add(a : MathmatrixdecompGraphN, b : MathmatrixdecompGraphN) -> MathmatrixdecompGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_graphn_copy(s : MathmatrixdecompGraphN) -> MathmatrixdecompGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_graphn_fill(s : MathmatrixdecompGraphN, v : Double) -> MathmatrixdecompGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_graphn_min(s : MathmatrixdecompGraphN) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_graphn_max(s : MathmatrixdecompGraphN) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_graphn_to_string(s : MathmatrixdecompGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_node_make(size : Int) -> MathmatrixdecompNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_node_len(s : MathmatrixdecompNode) -> Int { s.size }

pub fn math_matrix_decomp_node_get(s : MathmatrixdecompNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_node_set(s : MathmatrixdecompNode, i : Int, v : Double) -> MathmatrixdecompNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_node_sum(s : MathmatrixdecompNode) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_node_mean(s : MathmatrixdecompNode) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_node_scale(s : MathmatrixdecompNode, f : Double) -> MathmatrixdecompNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_node_add(a : MathmatrixdecompNode, b : MathmatrixdecompNode) -> MathmatrixdecompNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_node_copy(s : MathmatrixdecompNode) -> MathmatrixdecompNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_node_fill(s : MathmatrixdecompNode, v : Double) -> MathmatrixdecompNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_node_min(s : MathmatrixdecompNode) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_node_max(s : MathmatrixdecompNode) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_node_to_string(s : MathmatrixdecompNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_edge_make(size : Int) -> MathmatrixdecompEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_edge_len(s : MathmatrixdecompEdge) -> Int { s.size }

pub fn math_matrix_decomp_edge_get(s : MathmatrixdecompEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_edge_set(s : MathmatrixdecompEdge, i : Int, v : Double) -> MathmatrixdecompEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_edge_sum(s : MathmatrixdecompEdge) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_edge_mean(s : MathmatrixdecompEdge) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_edge_scale(s : MathmatrixdecompEdge, f : Double) -> MathmatrixdecompEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_edge_add(a : MathmatrixdecompEdge, b : MathmatrixdecompEdge) -> MathmatrixdecompEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_edge_copy(s : MathmatrixdecompEdge) -> MathmatrixdecompEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_edge_fill(s : MathmatrixdecompEdge, v : Double) -> MathmatrixdecompEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_edge_min(s : MathmatrixdecompEdge) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_edge_max(s : MathmatrixdecompEdge) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_edge_to_string(s : MathmatrixdecompEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_path_make(size : Int) -> MathmatrixdecompPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_path_len(s : MathmatrixdecompPath) -> Int { s.size }

pub fn math_matrix_decomp_path_get(s : MathmatrixdecompPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_path_set(s : MathmatrixdecompPath, i : Int, v : Double) -> MathmatrixdecompPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_path_sum(s : MathmatrixdecompPath) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_path_mean(s : MathmatrixdecompPath) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_path_scale(s : MathmatrixdecompPath, f : Double) -> MathmatrixdecompPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_path_add(a : MathmatrixdecompPath, b : MathmatrixdecompPath) -> MathmatrixdecompPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_path_copy(s : MathmatrixdecompPath) -> MathmatrixdecompPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_path_fill(s : MathmatrixdecompPath, v : Double) -> MathmatrixdecompPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_path_min(s : MathmatrixdecompPath) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_path_max(s : MathmatrixdecompPath) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_path_to_string(s : MathmatrixdecompPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_cluster_make(size : Int) -> MathmatrixdecompCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_cluster_len(s : MathmatrixdecompCluster) -> Int { s.size }

pub fn math_matrix_decomp_cluster_get(s : MathmatrixdecompCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_cluster_set(s : MathmatrixdecompCluster, i : Int, v : Double) -> MathmatrixdecompCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_cluster_sum(s : MathmatrixdecompCluster) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_cluster_mean(s : MathmatrixdecompCluster) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_cluster_scale(s : MathmatrixdecompCluster, f : Double) -> MathmatrixdecompCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_cluster_add(a : MathmatrixdecompCluster, b : MathmatrixdecompCluster) -> MathmatrixdecompCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_cluster_copy(s : MathmatrixdecompCluster) -> MathmatrixdecompCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_cluster_fill(s : MathmatrixdecompCluster, v : Double) -> MathmatrixdecompCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_cluster_min(s : MathmatrixdecompCluster) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_cluster_max(s : MathmatrixdecompCluster) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_cluster_to_string(s : MathmatrixdecompCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_model_make(size : Int) -> MathmatrixdecompModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_model_len(s : MathmatrixdecompModel) -> Int { s.size }

pub fn math_matrix_decomp_model_get(s : MathmatrixdecompModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_model_set(s : MathmatrixdecompModel, i : Int, v : Double) -> MathmatrixdecompModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_model_sum(s : MathmatrixdecompModel) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_model_mean(s : MathmatrixdecompModel) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_model_scale(s : MathmatrixdecompModel, f : Double) -> MathmatrixdecompModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_model_add(a : MathmatrixdecompModel, b : MathmatrixdecompModel) -> MathmatrixdecompModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_model_copy(s : MathmatrixdecompModel) -> MathmatrixdecompModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_model_fill(s : MathmatrixdecompModel, v : Double) -> MathmatrixdecompModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_model_min(s : MathmatrixdecompModel) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_model_max(s : MathmatrixdecompModel) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_model_to_string(s : MathmatrixdecompModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_layer_make(size : Int) -> MathmatrixdecompLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_layer_len(s : MathmatrixdecompLayer) -> Int { s.size }

pub fn math_matrix_decomp_layer_get(s : MathmatrixdecompLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_layer_set(s : MathmatrixdecompLayer, i : Int, v : Double) -> MathmatrixdecompLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_layer_sum(s : MathmatrixdecompLayer) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_layer_mean(s : MathmatrixdecompLayer) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_layer_scale(s : MathmatrixdecompLayer, f : Double) -> MathmatrixdecompLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_layer_add(a : MathmatrixdecompLayer, b : MathmatrixdecompLayer) -> MathmatrixdecompLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_layer_copy(s : MathmatrixdecompLayer) -> MathmatrixdecompLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_layer_fill(s : MathmatrixdecompLayer, v : Double) -> MathmatrixdecompLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_layer_min(s : MathmatrixdecompLayer) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_layer_max(s : MathmatrixdecompLayer) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_layer_to_string(s : MathmatrixdecompLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_buffer_make(size : Int) -> MathmatrixdecompBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_buffer_len(s : MathmatrixdecompBuffer) -> Int { s.size }

pub fn math_matrix_decomp_buffer_get(s : MathmatrixdecompBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_buffer_set(s : MathmatrixdecompBuffer, i : Int, v : Double) -> MathmatrixdecompBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_buffer_sum(s : MathmatrixdecompBuffer) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_buffer_mean(s : MathmatrixdecompBuffer) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_buffer_scale(s : MathmatrixdecompBuffer, f : Double) -> MathmatrixdecompBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_buffer_add(a : MathmatrixdecompBuffer, b : MathmatrixdecompBuffer) -> MathmatrixdecompBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_buffer_copy(s : MathmatrixdecompBuffer) -> MathmatrixdecompBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_buffer_fill(s : MathmatrixdecompBuffer, v : Double) -> MathmatrixdecompBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_buffer_min(s : MathmatrixdecompBuffer) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_buffer_max(s : MathmatrixdecompBuffer) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_buffer_to_string(s : MathmatrixdecompBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_cursor_make(size : Int) -> MathmatrixdecompCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_cursor_len(s : MathmatrixdecompCursor) -> Int { s.size }

pub fn math_matrix_decomp_cursor_get(s : MathmatrixdecompCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_cursor_set(s : MathmatrixdecompCursor, i : Int, v : Double) -> MathmatrixdecompCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_cursor_sum(s : MathmatrixdecompCursor) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_cursor_mean(s : MathmatrixdecompCursor) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_cursor_scale(s : MathmatrixdecompCursor, f : Double) -> MathmatrixdecompCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_cursor_add(a : MathmatrixdecompCursor, b : MathmatrixdecompCursor) -> MathmatrixdecompCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_cursor_copy(s : MathmatrixdecompCursor) -> MathmatrixdecompCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_cursor_fill(s : MathmatrixdecompCursor, v : Double) -> MathmatrixdecompCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_cursor_min(s : MathmatrixdecompCursor) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_cursor_max(s : MathmatrixdecompCursor) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_cursor_to_string(s : MathmatrixdecompCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_view_make(size : Int) -> MathmatrixdecompView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_view_len(s : MathmatrixdecompView) -> Int { s.size }

pub fn math_matrix_decomp_view_get(s : MathmatrixdecompView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_view_set(s : MathmatrixdecompView, i : Int, v : Double) -> MathmatrixdecompView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_view_sum(s : MathmatrixdecompView) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_view_mean(s : MathmatrixdecompView) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_view_scale(s : MathmatrixdecompView, f : Double) -> MathmatrixdecompView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_view_add(a : MathmatrixdecompView, b : MathmatrixdecompView) -> MathmatrixdecompView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_view_copy(s : MathmatrixdecompView) -> MathmatrixdecompView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_view_fill(s : MathmatrixdecompView, v : Double) -> MathmatrixdecompView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_view_min(s : MathmatrixdecompView) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_view_max(s : MathmatrixdecompView) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_view_to_string(s : MathmatrixdecompView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_range_make(size : Int) -> MathmatrixdecompRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_range_len(s : MathmatrixdecompRange) -> Int { s.size }

pub fn math_matrix_decomp_range_get(s : MathmatrixdecompRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_range_set(s : MathmatrixdecompRange, i : Int, v : Double) -> MathmatrixdecompRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_range_sum(s : MathmatrixdecompRange) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_range_mean(s : MathmatrixdecompRange) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_range_scale(s : MathmatrixdecompRange, f : Double) -> MathmatrixdecompRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_range_add(a : MathmatrixdecompRange, b : MathmatrixdecompRange) -> MathmatrixdecompRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_range_copy(s : MathmatrixdecompRange) -> MathmatrixdecompRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_range_fill(s : MathmatrixdecompRange, v : Double) -> MathmatrixdecompRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_range_min(s : MathmatrixdecompRange) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_range_max(s : MathmatrixdecompRange) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_range_to_string(s : MathmatrixdecompRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_slice_make(size : Int) -> MathmatrixdecompSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_slice_len(s : MathmatrixdecompSlice) -> Int { s.size }

pub fn math_matrix_decomp_slice_get(s : MathmatrixdecompSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_slice_set(s : MathmatrixdecompSlice, i : Int, v : Double) -> MathmatrixdecompSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_slice_sum(s : MathmatrixdecompSlice) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_slice_mean(s : MathmatrixdecompSlice) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_slice_scale(s : MathmatrixdecompSlice, f : Double) -> MathmatrixdecompSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_slice_add(a : MathmatrixdecompSlice, b : MathmatrixdecompSlice) -> MathmatrixdecompSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_slice_copy(s : MathmatrixdecompSlice) -> MathmatrixdecompSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_slice_fill(s : MathmatrixdecompSlice, v : Double) -> MathmatrixdecompSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_slice_min(s : MathmatrixdecompSlice) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_slice_max(s : MathmatrixdecompSlice) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_slice_to_string(s : MathmatrixdecompSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

