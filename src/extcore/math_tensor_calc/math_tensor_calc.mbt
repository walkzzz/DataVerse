///===
/// extcore/math_tensor_calc

pub(all) struct MathtensorcalcPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_tensor_calc_make_point(x : Double, y : Double) -> MathtensorcalcPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_tensor_calc_make_point3(x : Double, y : Double, z : Double) -> MathtensorcalcPoint {
  { x, y, z, label: 0 }
}

pub fn math_tensor_calc_point_x(pt : MathtensorcalcPoint) -> Double { pt.x }

pub fn math_tensor_calc_point_y(pt : MathtensorcalcPoint) -> Double { pt.y }

pub fn math_tensor_calc_point_z(pt : MathtensorcalcPoint) -> Double { pt.z }

pub fn math_tensor_calc_point_label(pt : MathtensorcalcPoint) -> Int { pt.label }

pub fn math_tensor_calc_point_dist(a : MathtensorcalcPoint, b : MathtensorcalcPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_tensor_calc_point_add(a : MathtensorcalcPoint, b : MathtensorcalcPoint) -> MathtensorcalcPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_tensor_calc_point_sub(a : MathtensorcalcPoint, b : MathtensorcalcPoint) -> MathtensorcalcPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_tensor_calc_point_scale(pt : MathtensorcalcPoint, s : Double) -> MathtensorcalcPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_tensor_calc_point_dot(a : MathtensorcalcPoint, b : MathtensorcalcPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_tensor_calc_point_cross(a : MathtensorcalcPoint, b : MathtensorcalcPoint) -> MathtensorcalcPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_tensor_calc_point_norm(pt : MathtensorcalcPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_tensor_calc_point_normalize(pt : MathtensorcalcPoint) -> MathtensorcalcPoint {
  let n = math_tensor_calc_point_norm(pt)
  if n < 0.0000001 { pt } else { math_tensor_calc_point_scale(pt, 1.0 / n) }
}

pub fn math_tensor_calc_point_negate(pt : MathtensorcalcPoint) -> MathtensorcalcPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_tensor_calc_point_mid(a : MathtensorcalcPoint, b : MathtensorcalcPoint) -> MathtensorcalcPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_tensor_calc_point_lerp(a : MathtensorcalcPoint, b : MathtensorcalcPoint, t : Double) -> MathtensorcalcPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_tensor_calc_point_to_string(pt : MathtensorcalcPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathtensorcalcSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_tensor_calc_make_series(vals : Array[Double], name : String) -> MathtensorcalcSeries {
  { vals, name, meta: 0 }
}

pub fn math_tensor_calc_series_len(s : MathtensorcalcSeries) -> Int { s.vals.length() }

pub fn math_tensor_calc_series_sum(s : MathtensorcalcSeries) -> Double { @_common.sum(s.vals) }

pub fn math_tensor_calc_series_mean(s : MathtensorcalcSeries) -> Double { @_common.mean(s.vals) }

pub fn math_tensor_calc_series_min(s : MathtensorcalcSeries) -> Double { @_common.min(s.vals) }

pub fn math_tensor_calc_series_max(s : MathtensorcalcSeries) -> Double { @_common.max(s.vals) }

pub fn math_tensor_calc_series_range(s : MathtensorcalcSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn math_tensor_calc_series_var(s : MathtensorcalcSeries) -> Double { @_common.variance(s.vals) }

pub fn math_tensor_calc_series_std(s : MathtensorcalcSeries) -> Double { @_common.std(s.vals) }

pub fn math_tensor_calc_series_median(s : MathtensorcalcSeries) -> Double { @_common.median(s.vals) }

pub fn math_tensor_calc_series_scale(s : MathtensorcalcSeries, f : Double) -> MathtensorcalcSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_tensor_calc_series_add(a : MathtensorcalcSeries, b : MathtensorcalcSeries) -> MathtensorcalcSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_tensor_calc_series_sub(a : MathtensorcalcSeries, b : MathtensorcalcSeries) -> MathtensorcalcSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_tensor_calc_series_normalize(s : MathtensorcalcSeries) -> MathtensorcalcSeries {
  let mn = math_tensor_calc_series_min(s)
  let mx = math_tensor_calc_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_tensor_calc_series_cumsum(s : MathtensorcalcSeries) -> MathtensorcalcSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_tensor_calc_series_to_string(s : MathtensorcalcSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathtensorcalcMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_tensor_calc_make_matrix(rows : Int, cols : Int, val : Double) -> MathtensorcalcMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_tensor_calc_matrix_identity(n : Int) -> MathtensorcalcMatrix {
  let m = math_tensor_calc_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_tensor_calc_matrix_get(m : MathtensorcalcMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_tensor_calc_matrix_transpose(m : MathtensorcalcMatrix) -> MathtensorcalcMatrix {
  let result = math_tensor_calc_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_tensor_calc_matrix_add(a : MathtensorcalcMatrix, b : MathtensorcalcMatrix) -> MathtensorcalcMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_tensor_calc_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_tensor_calc_matrix_scale(m : MathtensorcalcMatrix, s : Double) -> MathtensorcalcMatrix {
  let result = math_tensor_calc_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_tensor_calc_matrix_multiply(a : MathtensorcalcMatrix, b : MathtensorcalcMatrix) -> MathtensorcalcMatrix {
  if a.cols != b.rows { return math_tensor_calc_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_tensor_calc_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_tensor_calc_matrix_trace(m : MathtensorcalcMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_tensor_calc_matrix_det(m : MathtensorcalcMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_tensor_calc_matrix_norm(m : MathtensorcalcMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_tensor_calc_matrix_to_string(m : MathtensorcalcMatrix) -> String {
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

pub(all) struct MathtensorcalcVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_tensor_calc_make_vector(comps : Array[Double]) -> MathtensorcalcVector {
  { comps, dim: comps.length() }
}

pub fn math_tensor_calc_vector_zero(dim : Int) -> MathtensorcalcVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_tensor_calc_vector_add(a : MathtensorcalcVector, b : MathtensorcalcVector) -> MathtensorcalcVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_tensor_calc_vector_sub(a : MathtensorcalcVector, b : MathtensorcalcVector) -> MathtensorcalcVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_tensor_calc_vector_scale(v : MathtensorcalcVector, s : Double) -> MathtensorcalcVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_tensor_calc_vector_dot(a : MathtensorcalcVector, b : MathtensorcalcVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_tensor_calc_vector_norm(v : MathtensorcalcVector) -> Double { @_common.sqrt(math_tensor_calc_vector_dot(v, v)) }

pub fn math_tensor_calc_vector_normalize(v : MathtensorcalcVector) -> MathtensorcalcVector {
  let n = math_tensor_calc_vector_norm(v)
  if n < 0.0000001 { v } else { math_tensor_calc_vector_scale(v, 1.0 / n) }
}

pub fn math_tensor_calc_vector_dist(a : MathtensorcalcVector, b : MathtensorcalcVector) -> Double {
  math_tensor_calc_vector_norm(math_tensor_calc_vector_sub(a, b))
}

pub fn math_tensor_calc_vector_to_string(v : MathtensorcalcVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_tensor_calc_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_tensor_calc_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_tensor_calc_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_tensor_calc_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_tensor_calc_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_tensor_calc_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_tensor_calc_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_tensor_calc_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_tensor_calc_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_tensor_calc_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_tensor_calc_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_tensor_calc_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_tensor_calc_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_tensor_calc_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_tensor_calc_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_tensor_calc_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_tensor_calc_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_tensor_calc_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_tensor_calc_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_tensor_calc_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_tensor_calc_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_tensor_calc_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_tensor_calc_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_tensor_calc_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_tensor_calc_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_tensor_calc_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_tensor_calc_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_tensor_calc_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_tensor_calc_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathtensorcalcFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_frame_make(size : Int) -> MathtensorcalcFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_frame_len(s : MathtensorcalcFrame) -> Int { s.size }

pub fn math_tensor_calc_frame_get(s : MathtensorcalcFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_frame_set(s : MathtensorcalcFrame, i : Int, v : Double) -> MathtensorcalcFrame {
  let result = math_tensor_calc_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_tensor_calc_frame_sum(s : MathtensorcalcFrame) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_frame_mean(s : MathtensorcalcFrame) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_frame_scale(s : MathtensorcalcFrame, f : Double) -> MathtensorcalcFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_frame_add(a : MathtensorcalcFrame, b : MathtensorcalcFrame) -> MathtensorcalcFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_frame_copy(s : MathtensorcalcFrame) -> MathtensorcalcFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_frame_fill(s : MathtensorcalcFrame, v : Double) -> MathtensorcalcFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_frame_min(s : MathtensorcalcFrame) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_frame_max(s : MathtensorcalcFrame) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_frame_to_string(s : MathtensorcalcFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_table_make(size : Int) -> MathtensorcalcTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_table_len(s : MathtensorcalcTable) -> Int { s.size }

pub fn math_tensor_calc_table_get(s : MathtensorcalcTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_table_set(s : MathtensorcalcTable, i : Int, v : Double) -> MathtensorcalcTable {
  let result = math_tensor_calc_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_tensor_calc_table_sum(s : MathtensorcalcTable) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_table_mean(s : MathtensorcalcTable) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_table_scale(s : MathtensorcalcTable, f : Double) -> MathtensorcalcTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_table_add(a : MathtensorcalcTable, b : MathtensorcalcTable) -> MathtensorcalcTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_table_copy(s : MathtensorcalcTable) -> MathtensorcalcTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_table_fill(s : MathtensorcalcTable, v : Double) -> MathtensorcalcTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_table_min(s : MathtensorcalcTable) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_table_max(s : MathtensorcalcTable) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_table_to_string(s : MathtensorcalcTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_graphn_make(size : Int) -> MathtensorcalcGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_graphn_len(s : MathtensorcalcGraphN) -> Int { s.size }

pub fn math_tensor_calc_graphn_get(s : MathtensorcalcGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_graphn_set(s : MathtensorcalcGraphN, i : Int, v : Double) -> MathtensorcalcGraphN {
  let result = math_tensor_calc_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_tensor_calc_graphn_sum(s : MathtensorcalcGraphN) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_graphn_mean(s : MathtensorcalcGraphN) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_graphn_scale(s : MathtensorcalcGraphN, f : Double) -> MathtensorcalcGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_graphn_add(a : MathtensorcalcGraphN, b : MathtensorcalcGraphN) -> MathtensorcalcGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_graphn_copy(s : MathtensorcalcGraphN) -> MathtensorcalcGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_graphn_fill(s : MathtensorcalcGraphN, v : Double) -> MathtensorcalcGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_graphn_min(s : MathtensorcalcGraphN) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_graphn_max(s : MathtensorcalcGraphN) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_graphn_to_string(s : MathtensorcalcGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_node_make(size : Int) -> MathtensorcalcNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_node_len(s : MathtensorcalcNode) -> Int { s.size }

pub fn math_tensor_calc_node_get(s : MathtensorcalcNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_node_set(s : MathtensorcalcNode, i : Int, v : Double) -> MathtensorcalcNode {
  let result = math_tensor_calc_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_tensor_calc_node_sum(s : MathtensorcalcNode) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_node_mean(s : MathtensorcalcNode) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_node_scale(s : MathtensorcalcNode, f : Double) -> MathtensorcalcNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_node_add(a : MathtensorcalcNode, b : MathtensorcalcNode) -> MathtensorcalcNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_node_copy(s : MathtensorcalcNode) -> MathtensorcalcNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_node_fill(s : MathtensorcalcNode, v : Double) -> MathtensorcalcNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_node_min(s : MathtensorcalcNode) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_node_max(s : MathtensorcalcNode) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_node_to_string(s : MathtensorcalcNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_edge_make(size : Int) -> MathtensorcalcEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_edge_len(s : MathtensorcalcEdge) -> Int { s.size }

pub fn math_tensor_calc_edge_get(s : MathtensorcalcEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_edge_set(s : MathtensorcalcEdge, i : Int, v : Double) -> MathtensorcalcEdge {
  let result = math_tensor_calc_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_tensor_calc_edge_sum(s : MathtensorcalcEdge) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_edge_mean(s : MathtensorcalcEdge) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_edge_scale(s : MathtensorcalcEdge, f : Double) -> MathtensorcalcEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_edge_add(a : MathtensorcalcEdge, b : MathtensorcalcEdge) -> MathtensorcalcEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_edge_copy(s : MathtensorcalcEdge) -> MathtensorcalcEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_edge_fill(s : MathtensorcalcEdge, v : Double) -> MathtensorcalcEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_edge_min(s : MathtensorcalcEdge) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_edge_max(s : MathtensorcalcEdge) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_edge_to_string(s : MathtensorcalcEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_path_make(size : Int) -> MathtensorcalcPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_path_len(s : MathtensorcalcPath) -> Int { s.size }

pub fn math_tensor_calc_path_get(s : MathtensorcalcPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_path_set(s : MathtensorcalcPath, i : Int, v : Double) -> MathtensorcalcPath {
  let result = math_tensor_calc_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_tensor_calc_path_sum(s : MathtensorcalcPath) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_path_mean(s : MathtensorcalcPath) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_path_scale(s : MathtensorcalcPath, f : Double) -> MathtensorcalcPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_path_add(a : MathtensorcalcPath, b : MathtensorcalcPath) -> MathtensorcalcPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_path_copy(s : MathtensorcalcPath) -> MathtensorcalcPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_path_fill(s : MathtensorcalcPath, v : Double) -> MathtensorcalcPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_path_min(s : MathtensorcalcPath) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_path_max(s : MathtensorcalcPath) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_path_to_string(s : MathtensorcalcPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_cluster_make(size : Int) -> MathtensorcalcCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_cluster_len(s : MathtensorcalcCluster) -> Int { s.size }

pub fn math_tensor_calc_cluster_get(s : MathtensorcalcCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_cluster_set(s : MathtensorcalcCluster, i : Int, v : Double) -> MathtensorcalcCluster {
  let result = math_tensor_calc_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_tensor_calc_cluster_sum(s : MathtensorcalcCluster) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_cluster_mean(s : MathtensorcalcCluster) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_cluster_scale(s : MathtensorcalcCluster, f : Double) -> MathtensorcalcCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_cluster_add(a : MathtensorcalcCluster, b : MathtensorcalcCluster) -> MathtensorcalcCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_cluster_copy(s : MathtensorcalcCluster) -> MathtensorcalcCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_cluster_fill(s : MathtensorcalcCluster, v : Double) -> MathtensorcalcCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_cluster_min(s : MathtensorcalcCluster) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_cluster_max(s : MathtensorcalcCluster) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_cluster_to_string(s : MathtensorcalcCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_model_make(size : Int) -> MathtensorcalcModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_model_len(s : MathtensorcalcModel) -> Int { s.size }

pub fn math_tensor_calc_model_get(s : MathtensorcalcModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_model_set(s : MathtensorcalcModel, i : Int, v : Double) -> MathtensorcalcModel {
  let result = math_tensor_calc_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_tensor_calc_model_sum(s : MathtensorcalcModel) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_model_mean(s : MathtensorcalcModel) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_model_scale(s : MathtensorcalcModel, f : Double) -> MathtensorcalcModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_model_add(a : MathtensorcalcModel, b : MathtensorcalcModel) -> MathtensorcalcModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_model_copy(s : MathtensorcalcModel) -> MathtensorcalcModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_model_fill(s : MathtensorcalcModel, v : Double) -> MathtensorcalcModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_model_min(s : MathtensorcalcModel) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_model_max(s : MathtensorcalcModel) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_model_to_string(s : MathtensorcalcModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_layer_make(size : Int) -> MathtensorcalcLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_layer_len(s : MathtensorcalcLayer) -> Int { s.size }

pub fn math_tensor_calc_layer_get(s : MathtensorcalcLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_layer_set(s : MathtensorcalcLayer, i : Int, v : Double) -> MathtensorcalcLayer {
  let result = math_tensor_calc_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_tensor_calc_layer_sum(s : MathtensorcalcLayer) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_layer_mean(s : MathtensorcalcLayer) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_layer_scale(s : MathtensorcalcLayer, f : Double) -> MathtensorcalcLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_layer_add(a : MathtensorcalcLayer, b : MathtensorcalcLayer) -> MathtensorcalcLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_layer_copy(s : MathtensorcalcLayer) -> MathtensorcalcLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_layer_fill(s : MathtensorcalcLayer, v : Double) -> MathtensorcalcLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_layer_min(s : MathtensorcalcLayer) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_layer_max(s : MathtensorcalcLayer) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_layer_to_string(s : MathtensorcalcLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_buffer_make(size : Int) -> MathtensorcalcBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_buffer_len(s : MathtensorcalcBuffer) -> Int { s.size }

pub fn math_tensor_calc_buffer_get(s : MathtensorcalcBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_buffer_set(s : MathtensorcalcBuffer, i : Int, v : Double) -> MathtensorcalcBuffer {
  let result = math_tensor_calc_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_tensor_calc_buffer_sum(s : MathtensorcalcBuffer) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_buffer_mean(s : MathtensorcalcBuffer) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_buffer_scale(s : MathtensorcalcBuffer, f : Double) -> MathtensorcalcBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_buffer_add(a : MathtensorcalcBuffer, b : MathtensorcalcBuffer) -> MathtensorcalcBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_buffer_copy(s : MathtensorcalcBuffer) -> MathtensorcalcBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_buffer_fill(s : MathtensorcalcBuffer, v : Double) -> MathtensorcalcBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_buffer_min(s : MathtensorcalcBuffer) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_buffer_max(s : MathtensorcalcBuffer) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_buffer_to_string(s : MathtensorcalcBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_cursor_make(size : Int) -> MathtensorcalcCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_cursor_len(s : MathtensorcalcCursor) -> Int { s.size }

pub fn math_tensor_calc_cursor_get(s : MathtensorcalcCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_cursor_set(s : MathtensorcalcCursor, i : Int, v : Double) -> MathtensorcalcCursor {
  let result = math_tensor_calc_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_tensor_calc_cursor_sum(s : MathtensorcalcCursor) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_cursor_mean(s : MathtensorcalcCursor) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_cursor_scale(s : MathtensorcalcCursor, f : Double) -> MathtensorcalcCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_cursor_add(a : MathtensorcalcCursor, b : MathtensorcalcCursor) -> MathtensorcalcCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_cursor_copy(s : MathtensorcalcCursor) -> MathtensorcalcCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_cursor_fill(s : MathtensorcalcCursor, v : Double) -> MathtensorcalcCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_cursor_min(s : MathtensorcalcCursor) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_cursor_max(s : MathtensorcalcCursor) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_cursor_to_string(s : MathtensorcalcCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_view_make(size : Int) -> MathtensorcalcView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_view_len(s : MathtensorcalcView) -> Int { s.size }

pub fn math_tensor_calc_view_get(s : MathtensorcalcView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_view_set(s : MathtensorcalcView, i : Int, v : Double) -> MathtensorcalcView {
  let result = math_tensor_calc_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_tensor_calc_view_sum(s : MathtensorcalcView) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_view_mean(s : MathtensorcalcView) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_view_scale(s : MathtensorcalcView, f : Double) -> MathtensorcalcView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_view_add(a : MathtensorcalcView, b : MathtensorcalcView) -> MathtensorcalcView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_view_copy(s : MathtensorcalcView) -> MathtensorcalcView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_view_fill(s : MathtensorcalcView, v : Double) -> MathtensorcalcView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_view_min(s : MathtensorcalcView) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_view_max(s : MathtensorcalcView) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_view_to_string(s : MathtensorcalcView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_range_make(size : Int) -> MathtensorcalcRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_range_len(s : MathtensorcalcRange) -> Int { s.size }

pub fn math_tensor_calc_range_get(s : MathtensorcalcRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_range_set(s : MathtensorcalcRange, i : Int, v : Double) -> MathtensorcalcRange {
  let result = math_tensor_calc_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_tensor_calc_range_sum(s : MathtensorcalcRange) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_range_mean(s : MathtensorcalcRange) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_range_scale(s : MathtensorcalcRange, f : Double) -> MathtensorcalcRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_range_add(a : MathtensorcalcRange, b : MathtensorcalcRange) -> MathtensorcalcRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_range_copy(s : MathtensorcalcRange) -> MathtensorcalcRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_range_fill(s : MathtensorcalcRange, v : Double) -> MathtensorcalcRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_range_min(s : MathtensorcalcRange) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_range_max(s : MathtensorcalcRange) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_range_to_string(s : MathtensorcalcRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathtensorcalcSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_tensor_calc_slice_make(size : Int) -> MathtensorcalcSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_tensor_calc_slice_len(s : MathtensorcalcSlice) -> Int { s.size }

pub fn math_tensor_calc_slice_get(s : MathtensorcalcSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_tensor_calc_slice_set(s : MathtensorcalcSlice, i : Int, v : Double) -> MathtensorcalcSlice {
  let result = math_tensor_calc_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_tensor_calc_slice_sum(s : MathtensorcalcSlice) -> Double { @_common.sum(s.data) }

pub fn math_tensor_calc_slice_mean(s : MathtensorcalcSlice) -> Double { @_common.mean(s.data) }

pub fn math_tensor_calc_slice_scale(s : MathtensorcalcSlice, f : Double) -> MathtensorcalcSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_slice_add(a : MathtensorcalcSlice, b : MathtensorcalcSlice) -> MathtensorcalcSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_tensor_calc_slice_copy(s : MathtensorcalcSlice) -> MathtensorcalcSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_slice_fill(s : MathtensorcalcSlice, v : Double) -> MathtensorcalcSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_tensor_calc_slice_min(s : MathtensorcalcSlice) -> Double { @_common.min(s.data) }

pub fn math_tensor_calc_slice_max(s : MathtensorcalcSlice) -> Double { @_common.max(s.data) }

pub fn math_tensor_calc_slice_to_string(s : MathtensorcalcSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

