///===
/// extcore/math_approx_wavelet

pub(all) struct MathapproxwaveletPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_wavelet_make_point(x : Double, y : Double) -> MathapproxwaveletPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_wavelet_make_point3(x : Double, y : Double, z : Double) -> MathapproxwaveletPoint {
  { x, y, z, label: 0 }
}

pub fn math_approx_wavelet_point_x(pt : MathapproxwaveletPoint) -> Double { pt.x }

pub fn math_approx_wavelet_point_y(pt : MathapproxwaveletPoint) -> Double { pt.y }

pub fn math_approx_wavelet_point_z(pt : MathapproxwaveletPoint) -> Double { pt.z }

pub fn math_approx_wavelet_point_label(pt : MathapproxwaveletPoint) -> Int { pt.label }

pub fn math_approx_wavelet_point_dist(a : MathapproxwaveletPoint, b : MathapproxwaveletPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_approx_wavelet_point_add(a : MathapproxwaveletPoint, b : MathapproxwaveletPoint) -> MathapproxwaveletPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_approx_wavelet_point_sub(a : MathapproxwaveletPoint, b : MathapproxwaveletPoint) -> MathapproxwaveletPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_approx_wavelet_point_scale(pt : MathapproxwaveletPoint, s : Double) -> MathapproxwaveletPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_approx_wavelet_point_dot(a : MathapproxwaveletPoint, b : MathapproxwaveletPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_approx_wavelet_point_cross(a : MathapproxwaveletPoint, b : MathapproxwaveletPoint) -> MathapproxwaveletPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_approx_wavelet_point_norm(pt : MathapproxwaveletPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_approx_wavelet_point_normalize(pt : MathapproxwaveletPoint) -> MathapproxwaveletPoint {
  let n = math_approx_wavelet_point_norm(pt)
  if n < 0.0000001 { pt } else { math_approx_wavelet_point_scale(pt, 1.0 / n) }
}

pub fn math_approx_wavelet_point_negate(pt : MathapproxwaveletPoint) -> MathapproxwaveletPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_approx_wavelet_point_mid(a : MathapproxwaveletPoint, b : MathapproxwaveletPoint) -> MathapproxwaveletPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_approx_wavelet_point_lerp(a : MathapproxwaveletPoint, b : MathapproxwaveletPoint, t : Double) -> MathapproxwaveletPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_approx_wavelet_point_to_string(pt : MathapproxwaveletPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathapproxwaveletSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_wavelet_make_series(vals : Array[Double], name : String) -> MathapproxwaveletSeries {
  { vals, name, meta: 0 }
}

pub fn math_approx_wavelet_series_len(s : MathapproxwaveletSeries) -> Int { s.vals.length() }

pub fn math_approx_wavelet_series_sum(s : MathapproxwaveletSeries) -> Double { @_common.sum(s.vals) }

pub fn math_approx_wavelet_series_mean(s : MathapproxwaveletSeries) -> Double { @_common.mean(s.vals) }

pub fn math_approx_wavelet_series_min(s : MathapproxwaveletSeries) -> Double { @_common.min(s.vals) }

pub fn math_approx_wavelet_series_max(s : MathapproxwaveletSeries) -> Double { @_common.max(s.vals) }

pub fn math_approx_wavelet_series_range(s : MathapproxwaveletSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn math_approx_wavelet_series_var(s : MathapproxwaveletSeries) -> Double { @_common.variance(s.vals) }

pub fn math_approx_wavelet_series_std(s : MathapproxwaveletSeries) -> Double { @_common.std(s.vals) }

pub fn math_approx_wavelet_series_median(s : MathapproxwaveletSeries) -> Double { @_common.median(s.vals) }

pub fn math_approx_wavelet_series_scale(s : MathapproxwaveletSeries, f : Double) -> MathapproxwaveletSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn math_approx_wavelet_series_add(a : MathapproxwaveletSeries, b : MathapproxwaveletSeries) -> MathapproxwaveletSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_approx_wavelet_series_sub(a : MathapproxwaveletSeries, b : MathapproxwaveletSeries) -> MathapproxwaveletSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_approx_wavelet_series_normalize(s : MathapproxwaveletSeries) -> MathapproxwaveletSeries {
  let mn = math_approx_wavelet_series_min(s)
  let mx = math_approx_wavelet_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_approx_wavelet_series_cumsum(s : MathapproxwaveletSeries) -> MathapproxwaveletSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_approx_wavelet_series_to_string(s : MathapproxwaveletSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxwaveletMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_wavelet_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxwaveletMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_wavelet_matrix_identity(n : Int) -> MathapproxwaveletMatrix {
  let m = math_approx_wavelet_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_approx_wavelet_matrix_get(m : MathapproxwaveletMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_approx_wavelet_matrix_transpose(m : MathapproxwaveletMatrix) -> MathapproxwaveletMatrix {
  let result = math_approx_wavelet_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_approx_wavelet_matrix_add(a : MathapproxwaveletMatrix, b : MathapproxwaveletMatrix) -> MathapproxwaveletMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_approx_wavelet_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_approx_wavelet_matrix_scale(m : MathapproxwaveletMatrix, s : Double) -> MathapproxwaveletMatrix {
  let result = math_approx_wavelet_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_approx_wavelet_matrix_multiply(a : MathapproxwaveletMatrix, b : MathapproxwaveletMatrix) -> MathapproxwaveletMatrix {
  if a.cols != b.rows { return math_approx_wavelet_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_approx_wavelet_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_approx_wavelet_matrix_trace(m : MathapproxwaveletMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_approx_wavelet_matrix_det(m : MathapproxwaveletMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_approx_wavelet_matrix_norm(m : MathapproxwaveletMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_approx_wavelet_matrix_to_string(m : MathapproxwaveletMatrix) -> String {
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

pub(all) struct MathapproxwaveletVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_wavelet_make_vector(comps : Array[Double]) -> MathapproxwaveletVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_wavelet_vector_zero(dim : Int) -> MathapproxwaveletVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_approx_wavelet_vector_add(a : MathapproxwaveletVector, b : MathapproxwaveletVector) -> MathapproxwaveletVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn math_approx_wavelet_vector_sub(a : MathapproxwaveletVector, b : MathapproxwaveletVector) -> MathapproxwaveletVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn math_approx_wavelet_vector_scale(v : MathapproxwaveletVector, s : Double) -> MathapproxwaveletVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn math_approx_wavelet_vector_dot(a : MathapproxwaveletVector, b : MathapproxwaveletVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_approx_wavelet_vector_norm(v : MathapproxwaveletVector) -> Double { @_common.sqrt(math_approx_wavelet_vector_dot(v, v)) }

pub fn math_approx_wavelet_vector_normalize(v : MathapproxwaveletVector) -> MathapproxwaveletVector {
  let n = math_approx_wavelet_vector_norm(v)
  if n < 0.0000001 { v } else { math_approx_wavelet_vector_scale(v, 1.0 / n) }
}

pub fn math_approx_wavelet_vector_dist(a : MathapproxwaveletVector, b : MathapproxwaveletVector) -> Double {
  math_approx_wavelet_vector_norm(math_approx_wavelet_vector_sub(a, b))
}

pub fn math_approx_wavelet_vector_to_string(v : MathapproxwaveletVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_wavelet_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_approx_wavelet_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_approx_wavelet_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_approx_wavelet_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_approx_wavelet_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_approx_wavelet_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_approx_wavelet_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_approx_wavelet_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_approx_wavelet_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_approx_wavelet_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_approx_wavelet_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_approx_wavelet_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_approx_wavelet_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_approx_wavelet_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_approx_wavelet_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_approx_wavelet_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_approx_wavelet_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_approx_wavelet_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_approx_wavelet_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_approx_wavelet_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_approx_wavelet_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_approx_wavelet_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_approx_wavelet_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_approx_wavelet_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_approx_wavelet_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_approx_wavelet_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_approx_wavelet_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_approx_wavelet_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_approx_wavelet_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathapproxwaveletFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_frame_make(size : Int) -> MathapproxwaveletFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_frame_len(s : MathapproxwaveletFrame) -> Int { s.size }

pub fn math_approx_wavelet_frame_get(s : MathapproxwaveletFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_frame_set(s : MathapproxwaveletFrame, i : Int, v : Double) -> MathapproxwaveletFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_frame_sum(s : MathapproxwaveletFrame) -> Double { @_common.sum(s.data) }

pub fn math_approx_wavelet_frame_mean(s : MathapproxwaveletFrame) -> Double { @_common.mean(s.data) }

pub fn math_approx_wavelet_frame_scale(s : MathapproxwaveletFrame, f : Double) -> MathapproxwaveletFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_frame_add(a : MathapproxwaveletFrame, b : MathapproxwaveletFrame) -> MathapproxwaveletFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_wavelet_frame_copy(s : MathapproxwaveletFrame) -> MathapproxwaveletFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_frame_fill(s : MathapproxwaveletFrame, v : Double) -> MathapproxwaveletFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_frame_min(s : MathapproxwaveletFrame) -> Double { @_common.min(s.data) }

pub fn math_approx_wavelet_frame_max(s : MathapproxwaveletFrame) -> Double { @_common.max(s.data) }

pub fn math_approx_wavelet_frame_to_string(s : MathapproxwaveletFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_table_make(size : Int) -> MathapproxwaveletTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_table_len(s : MathapproxwaveletTable) -> Int { s.size }

pub fn math_approx_wavelet_table_get(s : MathapproxwaveletTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_table_set(s : MathapproxwaveletTable, i : Int, v : Double) -> MathapproxwaveletTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_table_sum(s : MathapproxwaveletTable) -> Double { @_common.sum(s.data) }

pub fn math_approx_wavelet_table_mean(s : MathapproxwaveletTable) -> Double { @_common.mean(s.data) }

pub fn math_approx_wavelet_table_scale(s : MathapproxwaveletTable, f : Double) -> MathapproxwaveletTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_table_add(a : MathapproxwaveletTable, b : MathapproxwaveletTable) -> MathapproxwaveletTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_wavelet_table_copy(s : MathapproxwaveletTable) -> MathapproxwaveletTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_table_fill(s : MathapproxwaveletTable, v : Double) -> MathapproxwaveletTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_table_min(s : MathapproxwaveletTable) -> Double { @_common.min(s.data) }

pub fn math_approx_wavelet_table_max(s : MathapproxwaveletTable) -> Double { @_common.max(s.data) }

pub fn math_approx_wavelet_table_to_string(s : MathapproxwaveletTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_graphn_make(size : Int) -> MathapproxwaveletGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_graphn_len(s : MathapproxwaveletGraphN) -> Int { s.size }

pub fn math_approx_wavelet_graphn_get(s : MathapproxwaveletGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_graphn_set(s : MathapproxwaveletGraphN, i : Int, v : Double) -> MathapproxwaveletGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_graphn_sum(s : MathapproxwaveletGraphN) -> Double { @_common.sum(s.data) }

pub fn math_approx_wavelet_graphn_mean(s : MathapproxwaveletGraphN) -> Double { @_common.mean(s.data) }

pub fn math_approx_wavelet_graphn_scale(s : MathapproxwaveletGraphN, f : Double) -> MathapproxwaveletGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_graphn_add(a : MathapproxwaveletGraphN, b : MathapproxwaveletGraphN) -> MathapproxwaveletGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_wavelet_graphn_copy(s : MathapproxwaveletGraphN) -> MathapproxwaveletGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_graphn_fill(s : MathapproxwaveletGraphN, v : Double) -> MathapproxwaveletGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_graphn_min(s : MathapproxwaveletGraphN) -> Double { @_common.min(s.data) }

pub fn math_approx_wavelet_graphn_max(s : MathapproxwaveletGraphN) -> Double { @_common.max(s.data) }

pub fn math_approx_wavelet_graphn_to_string(s : MathapproxwaveletGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_node_make(size : Int) -> MathapproxwaveletNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_node_len(s : MathapproxwaveletNode) -> Int { s.size }

pub fn math_approx_wavelet_node_get(s : MathapproxwaveletNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_node_set(s : MathapproxwaveletNode, i : Int, v : Double) -> MathapproxwaveletNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_node_sum(s : MathapproxwaveletNode) -> Double { @_common.sum(s.data) }

pub fn math_approx_wavelet_node_mean(s : MathapproxwaveletNode) -> Double { @_common.mean(s.data) }

pub fn math_approx_wavelet_node_scale(s : MathapproxwaveletNode, f : Double) -> MathapproxwaveletNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_node_add(a : MathapproxwaveletNode, b : MathapproxwaveletNode) -> MathapproxwaveletNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_wavelet_node_copy(s : MathapproxwaveletNode) -> MathapproxwaveletNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_node_fill(s : MathapproxwaveletNode, v : Double) -> MathapproxwaveletNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_node_min(s : MathapproxwaveletNode) -> Double { @_common.min(s.data) }

pub fn math_approx_wavelet_node_max(s : MathapproxwaveletNode) -> Double { @_common.max(s.data) }

pub fn math_approx_wavelet_node_to_string(s : MathapproxwaveletNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_edge_make(size : Int) -> MathapproxwaveletEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_edge_len(s : MathapproxwaveletEdge) -> Int { s.size }

pub fn math_approx_wavelet_edge_get(s : MathapproxwaveletEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_edge_set(s : MathapproxwaveletEdge, i : Int, v : Double) -> MathapproxwaveletEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_edge_sum(s : MathapproxwaveletEdge) -> Double { @_common.sum(s.data) }

pub fn math_approx_wavelet_edge_mean(s : MathapproxwaveletEdge) -> Double { @_common.mean(s.data) }

pub fn math_approx_wavelet_edge_scale(s : MathapproxwaveletEdge, f : Double) -> MathapproxwaveletEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_edge_add(a : MathapproxwaveletEdge, b : MathapproxwaveletEdge) -> MathapproxwaveletEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_wavelet_edge_copy(s : MathapproxwaveletEdge) -> MathapproxwaveletEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_edge_fill(s : MathapproxwaveletEdge, v : Double) -> MathapproxwaveletEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_edge_min(s : MathapproxwaveletEdge) -> Double { @_common.min(s.data) }

pub fn math_approx_wavelet_edge_max(s : MathapproxwaveletEdge) -> Double { @_common.max(s.data) }

pub fn math_approx_wavelet_edge_to_string(s : MathapproxwaveletEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_path_make(size : Int) -> MathapproxwaveletPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_path_len(s : MathapproxwaveletPath) -> Int { s.size }

pub fn math_approx_wavelet_path_get(s : MathapproxwaveletPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_path_set(s : MathapproxwaveletPath, i : Int, v : Double) -> MathapproxwaveletPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_path_sum(s : MathapproxwaveletPath) -> Double { @_common.sum(s.data) }

pub fn math_approx_wavelet_path_mean(s : MathapproxwaveletPath) -> Double { @_common.mean(s.data) }

pub fn math_approx_wavelet_path_scale(s : MathapproxwaveletPath, f : Double) -> MathapproxwaveletPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_path_add(a : MathapproxwaveletPath, b : MathapproxwaveletPath) -> MathapproxwaveletPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_wavelet_path_copy(s : MathapproxwaveletPath) -> MathapproxwaveletPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_path_fill(s : MathapproxwaveletPath, v : Double) -> MathapproxwaveletPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_path_min(s : MathapproxwaveletPath) -> Double { @_common.min(s.data) }

pub fn math_approx_wavelet_path_max(s : MathapproxwaveletPath) -> Double { @_common.max(s.data) }

pub fn math_approx_wavelet_path_to_string(s : MathapproxwaveletPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_cluster_make(size : Int) -> MathapproxwaveletCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_cluster_len(s : MathapproxwaveletCluster) -> Int { s.size }

pub fn math_approx_wavelet_cluster_get(s : MathapproxwaveletCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_cluster_set(s : MathapproxwaveletCluster, i : Int, v : Double) -> MathapproxwaveletCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_cluster_sum(s : MathapproxwaveletCluster) -> Double { @_common.sum(s.data) }

pub fn math_approx_wavelet_cluster_mean(s : MathapproxwaveletCluster) -> Double { @_common.mean(s.data) }

pub fn math_approx_wavelet_cluster_scale(s : MathapproxwaveletCluster, f : Double) -> MathapproxwaveletCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_cluster_add(a : MathapproxwaveletCluster, b : MathapproxwaveletCluster) -> MathapproxwaveletCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_wavelet_cluster_copy(s : MathapproxwaveletCluster) -> MathapproxwaveletCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_cluster_fill(s : MathapproxwaveletCluster, v : Double) -> MathapproxwaveletCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_cluster_min(s : MathapproxwaveletCluster) -> Double { @_common.min(s.data) }

pub fn math_approx_wavelet_cluster_max(s : MathapproxwaveletCluster) -> Double { @_common.max(s.data) }

pub fn math_approx_wavelet_cluster_to_string(s : MathapproxwaveletCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_model_make(size : Int) -> MathapproxwaveletModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_model_len(s : MathapproxwaveletModel) -> Int { s.size }

pub fn math_approx_wavelet_model_get(s : MathapproxwaveletModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_model_set(s : MathapproxwaveletModel, i : Int, v : Double) -> MathapproxwaveletModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_model_sum(s : MathapproxwaveletModel) -> Double { @_common.sum(s.data) }

pub fn math_approx_wavelet_model_mean(s : MathapproxwaveletModel) -> Double { @_common.mean(s.data) }

pub fn math_approx_wavelet_model_scale(s : MathapproxwaveletModel, f : Double) -> MathapproxwaveletModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_model_add(a : MathapproxwaveletModel, b : MathapproxwaveletModel) -> MathapproxwaveletModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_wavelet_model_copy(s : MathapproxwaveletModel) -> MathapproxwaveletModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_model_fill(s : MathapproxwaveletModel, v : Double) -> MathapproxwaveletModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_model_min(s : MathapproxwaveletModel) -> Double { @_common.min(s.data) }

pub fn math_approx_wavelet_model_max(s : MathapproxwaveletModel) -> Double { @_common.max(s.data) }

pub fn math_approx_wavelet_model_to_string(s : MathapproxwaveletModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_layer_make(size : Int) -> MathapproxwaveletLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_layer_len(s : MathapproxwaveletLayer) -> Int { s.size }

pub fn math_approx_wavelet_layer_get(s : MathapproxwaveletLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_layer_set(s : MathapproxwaveletLayer, i : Int, v : Double) -> MathapproxwaveletLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_layer_sum(s : MathapproxwaveletLayer) -> Double { @_common.sum(s.data) }

pub fn math_approx_wavelet_layer_mean(s : MathapproxwaveletLayer) -> Double { @_common.mean(s.data) }

pub fn math_approx_wavelet_layer_scale(s : MathapproxwaveletLayer, f : Double) -> MathapproxwaveletLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_layer_add(a : MathapproxwaveletLayer, b : MathapproxwaveletLayer) -> MathapproxwaveletLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_wavelet_layer_copy(s : MathapproxwaveletLayer) -> MathapproxwaveletLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_layer_fill(s : MathapproxwaveletLayer, v : Double) -> MathapproxwaveletLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_layer_min(s : MathapproxwaveletLayer) -> Double { @_common.min(s.data) }

pub fn math_approx_wavelet_layer_max(s : MathapproxwaveletLayer) -> Double { @_common.max(s.data) }

pub fn math_approx_wavelet_layer_to_string(s : MathapproxwaveletLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_buffer_make(size : Int) -> MathapproxwaveletBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_buffer_len(s : MathapproxwaveletBuffer) -> Int { s.size }

pub fn math_approx_wavelet_buffer_get(s : MathapproxwaveletBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_buffer_set(s : MathapproxwaveletBuffer, i : Int, v : Double) -> MathapproxwaveletBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_buffer_sum(s : MathapproxwaveletBuffer) -> Double { @_common.sum(s.data) }

pub fn math_approx_wavelet_buffer_mean(s : MathapproxwaveletBuffer) -> Double { @_common.mean(s.data) }

pub fn math_approx_wavelet_buffer_scale(s : MathapproxwaveletBuffer, f : Double) -> MathapproxwaveletBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_buffer_add(a : MathapproxwaveletBuffer, b : MathapproxwaveletBuffer) -> MathapproxwaveletBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_wavelet_buffer_copy(s : MathapproxwaveletBuffer) -> MathapproxwaveletBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_buffer_fill(s : MathapproxwaveletBuffer, v : Double) -> MathapproxwaveletBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_buffer_min(s : MathapproxwaveletBuffer) -> Double { @_common.min(s.data) }

pub fn math_approx_wavelet_buffer_max(s : MathapproxwaveletBuffer) -> Double { @_common.max(s.data) }

pub fn math_approx_wavelet_buffer_to_string(s : MathapproxwaveletBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_cursor_make(size : Int) -> MathapproxwaveletCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_cursor_len(s : MathapproxwaveletCursor) -> Int { s.size }

pub fn math_approx_wavelet_cursor_get(s : MathapproxwaveletCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_cursor_set(s : MathapproxwaveletCursor, i : Int, v : Double) -> MathapproxwaveletCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_cursor_sum(s : MathapproxwaveletCursor) -> Double { @_common.sum(s.data) }

pub fn math_approx_wavelet_cursor_mean(s : MathapproxwaveletCursor) -> Double { @_common.mean(s.data) }

pub fn math_approx_wavelet_cursor_scale(s : MathapproxwaveletCursor, f : Double) -> MathapproxwaveletCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_cursor_add(a : MathapproxwaveletCursor, b : MathapproxwaveletCursor) -> MathapproxwaveletCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_wavelet_cursor_copy(s : MathapproxwaveletCursor) -> MathapproxwaveletCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_cursor_fill(s : MathapproxwaveletCursor, v : Double) -> MathapproxwaveletCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_cursor_min(s : MathapproxwaveletCursor) -> Double { @_common.min(s.data) }

pub fn math_approx_wavelet_cursor_max(s : MathapproxwaveletCursor) -> Double { @_common.max(s.data) }

pub fn math_approx_wavelet_cursor_to_string(s : MathapproxwaveletCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_view_make(size : Int) -> MathapproxwaveletView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_view_len(s : MathapproxwaveletView) -> Int { s.size }

pub fn math_approx_wavelet_view_get(s : MathapproxwaveletView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_view_set(s : MathapproxwaveletView, i : Int, v : Double) -> MathapproxwaveletView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_view_sum(s : MathapproxwaveletView) -> Double { @_common.sum(s.data) }

pub fn math_approx_wavelet_view_mean(s : MathapproxwaveletView) -> Double { @_common.mean(s.data) }

pub fn math_approx_wavelet_view_scale(s : MathapproxwaveletView, f : Double) -> MathapproxwaveletView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_view_add(a : MathapproxwaveletView, b : MathapproxwaveletView) -> MathapproxwaveletView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_wavelet_view_copy(s : MathapproxwaveletView) -> MathapproxwaveletView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_view_fill(s : MathapproxwaveletView, v : Double) -> MathapproxwaveletView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_view_min(s : MathapproxwaveletView) -> Double { @_common.min(s.data) }

pub fn math_approx_wavelet_view_max(s : MathapproxwaveletView) -> Double { @_common.max(s.data) }

pub fn math_approx_wavelet_view_to_string(s : MathapproxwaveletView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_range_make(size : Int) -> MathapproxwaveletRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_range_len(s : MathapproxwaveletRange) -> Int { s.size }

pub fn math_approx_wavelet_range_get(s : MathapproxwaveletRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_range_set(s : MathapproxwaveletRange, i : Int, v : Double) -> MathapproxwaveletRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_range_sum(s : MathapproxwaveletRange) -> Double { @_common.sum(s.data) }

pub fn math_approx_wavelet_range_mean(s : MathapproxwaveletRange) -> Double { @_common.mean(s.data) }

pub fn math_approx_wavelet_range_scale(s : MathapproxwaveletRange, f : Double) -> MathapproxwaveletRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_range_add(a : MathapproxwaveletRange, b : MathapproxwaveletRange) -> MathapproxwaveletRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_wavelet_range_copy(s : MathapproxwaveletRange) -> MathapproxwaveletRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_range_fill(s : MathapproxwaveletRange, v : Double) -> MathapproxwaveletRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_range_min(s : MathapproxwaveletRange) -> Double { @_common.min(s.data) }

pub fn math_approx_wavelet_range_max(s : MathapproxwaveletRange) -> Double { @_common.max(s.data) }

pub fn math_approx_wavelet_range_to_string(s : MathapproxwaveletRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_slice_make(size : Int) -> MathapproxwaveletSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_slice_len(s : MathapproxwaveletSlice) -> Int { s.size }

pub fn math_approx_wavelet_slice_get(s : MathapproxwaveletSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_slice_set(s : MathapproxwaveletSlice, i : Int, v : Double) -> MathapproxwaveletSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_slice_sum(s : MathapproxwaveletSlice) -> Double { @_common.sum(s.data) }

pub fn math_approx_wavelet_slice_mean(s : MathapproxwaveletSlice) -> Double { @_common.mean(s.data) }

pub fn math_approx_wavelet_slice_scale(s : MathapproxwaveletSlice, f : Double) -> MathapproxwaveletSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_slice_add(a : MathapproxwaveletSlice, b : MathapproxwaveletSlice) -> MathapproxwaveletSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_wavelet_slice_copy(s : MathapproxwaveletSlice) -> MathapproxwaveletSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_slice_fill(s : MathapproxwaveletSlice, v : Double) -> MathapproxwaveletSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_wavelet_slice_min(s : MathapproxwaveletSlice) -> Double { @_common.min(s.data) }

pub fn math_approx_wavelet_slice_max(s : MathapproxwaveletSlice) -> Double { @_common.max(s.data) }

pub fn math_approx_wavelet_slice_to_string(s : MathapproxwaveletSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

