///===
/// extcore/stats_infer_param

pub(all) struct StatsinferparamPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_infer_param_make_point(x : Double, y : Double) -> StatsinferparamPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_infer_param_make_point3(x : Double, y : Double, z : Double) -> StatsinferparamPoint {
  { x, y, z, label: 0 }
}

pub fn stats_infer_param_point_x(pt : StatsinferparamPoint) -> Double { pt.x }

pub fn stats_infer_param_point_y(pt : StatsinferparamPoint) -> Double { pt.y }

pub fn stats_infer_param_point_z(pt : StatsinferparamPoint) -> Double { pt.z }

pub fn stats_infer_param_point_label(pt : StatsinferparamPoint) -> Int { pt.label }

pub fn stats_infer_param_point_dist(a : StatsinferparamPoint, b : StatsinferparamPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_infer_param_point_add(a : StatsinferparamPoint, b : StatsinferparamPoint) -> StatsinferparamPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_infer_param_point_sub(a : StatsinferparamPoint, b : StatsinferparamPoint) -> StatsinferparamPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_infer_param_point_scale(pt : StatsinferparamPoint, s : Double) -> StatsinferparamPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_infer_param_point_dot(a : StatsinferparamPoint, b : StatsinferparamPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_infer_param_point_cross(a : StatsinferparamPoint, b : StatsinferparamPoint) -> StatsinferparamPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_infer_param_point_norm(pt : StatsinferparamPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_infer_param_point_normalize(pt : StatsinferparamPoint) -> StatsinferparamPoint {
  let n = stats_infer_param_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_infer_param_point_scale(pt, 1.0 / n) }
}

pub fn stats_infer_param_point_negate(pt : StatsinferparamPoint) -> StatsinferparamPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_infer_param_point_mid(a : StatsinferparamPoint, b : StatsinferparamPoint) -> StatsinferparamPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_infer_param_point_lerp(a : StatsinferparamPoint, b : StatsinferparamPoint, t : Double) -> StatsinferparamPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_infer_param_point_to_string(pt : StatsinferparamPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsinferparamSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_infer_param_make_series(vals : Array[Double], name : String) -> StatsinferparamSeries {
  { vals, name, meta: 0 }
}

pub fn stats_infer_param_series_len(s : StatsinferparamSeries) -> Int { s.vals.length() }

pub fn stats_infer_param_series_sum(s : StatsinferparamSeries) -> Double { @_common.sum(s.vals) }

pub fn stats_infer_param_series_mean(s : StatsinferparamSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_infer_param_series_min(s : StatsinferparamSeries) -> Double { @_common.min(s.vals) }

pub fn stats_infer_param_series_max(s : StatsinferparamSeries) -> Double { @_common.max(s.vals) }

pub fn stats_infer_param_series_range(s : StatsinferparamSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_infer_param_series_var(s : StatsinferparamSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_infer_param_series_std(s : StatsinferparamSeries) -> Double { @_common.std(s.vals) }

pub fn stats_infer_param_series_median(s : StatsinferparamSeries) -> Double { @_common.median(s.vals) }

pub fn stats_infer_param_series_scale(s : StatsinferparamSeries, f : Double) -> StatsinferparamSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_infer_param_series_add(a : StatsinferparamSeries, b : StatsinferparamSeries) -> StatsinferparamSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_infer_param_series_sub(a : StatsinferparamSeries, b : StatsinferparamSeries) -> StatsinferparamSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_infer_param_series_normalize(s : StatsinferparamSeries) -> StatsinferparamSeries {
  let mn = stats_infer_param_series_min(s)
  let mx = stats_infer_param_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_infer_param_series_cumsum(s : StatsinferparamSeries) -> StatsinferparamSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_infer_param_series_to_string(s : StatsinferparamSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsinferparamMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_infer_param_make_matrix(rows : Int, cols : Int, val : Double) -> StatsinferparamMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_infer_param_matrix_identity(n : Int) -> StatsinferparamMatrix {
  let m = stats_infer_param_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_infer_param_matrix_get(m : StatsinferparamMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_infer_param_matrix_transpose(m : StatsinferparamMatrix) -> StatsinferparamMatrix {
  let result = stats_infer_param_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_infer_param_matrix_add(a : StatsinferparamMatrix, b : StatsinferparamMatrix) -> StatsinferparamMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_infer_param_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_infer_param_matrix_scale(m : StatsinferparamMatrix, s : Double) -> StatsinferparamMatrix {
  let result = stats_infer_param_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_infer_param_matrix_multiply(a : StatsinferparamMatrix, b : StatsinferparamMatrix) -> StatsinferparamMatrix {
  if a.cols != b.rows { return stats_infer_param_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_infer_param_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_infer_param_matrix_trace(m : StatsinferparamMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_infer_param_matrix_det(m : StatsinferparamMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_infer_param_matrix_norm(m : StatsinferparamMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_infer_param_matrix_to_string(m : StatsinferparamMatrix) -> String {
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

pub(all) struct StatsinferparamVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_infer_param_make_vector(comps : Array[Double]) -> StatsinferparamVector {
  { comps, dim: comps.length() }
}

pub fn stats_infer_param_vector_zero(dim : Int) -> StatsinferparamVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_infer_param_vector_add(a : StatsinferparamVector, b : StatsinferparamVector) -> StatsinferparamVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_infer_param_vector_sub(a : StatsinferparamVector, b : StatsinferparamVector) -> StatsinferparamVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_infer_param_vector_scale(v : StatsinferparamVector, s : Double) -> StatsinferparamVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_infer_param_vector_dot(a : StatsinferparamVector, b : StatsinferparamVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_infer_param_vector_norm(v : StatsinferparamVector) -> Double { @_common.sqrt(stats_infer_param_vector_dot(v, v)) }

pub fn stats_infer_param_vector_normalize(v : StatsinferparamVector) -> StatsinferparamVector {
  let n = stats_infer_param_vector_norm(v)
  if n < 0.0000001 { v } else { stats_infer_param_vector_scale(v, 1.0 / n) }
}

pub fn stats_infer_param_vector_dist(a : StatsinferparamVector, b : StatsinferparamVector) -> Double {
  stats_infer_param_vector_norm(stats_infer_param_vector_sub(a, b))
}

pub fn stats_infer_param_vector_to_string(v : StatsinferparamVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_infer_param_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_infer_param_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_infer_param_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_infer_param_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_infer_param_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_infer_param_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_infer_param_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_infer_param_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_infer_param_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_infer_param_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_infer_param_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_infer_param_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_infer_param_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_infer_param_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_infer_param_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_infer_param_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_infer_param_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_infer_param_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_infer_param_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_infer_param_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_infer_param_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_infer_param_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_infer_param_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_infer_param_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_infer_param_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_infer_param_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_infer_param_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_infer_param_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_infer_param_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsinferparamFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_frame_make(size : Int) -> StatsinferparamFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_frame_len(s : StatsinferparamFrame) -> Int { s.size }

pub fn stats_infer_param_frame_get(s : StatsinferparamFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_frame_set(s : StatsinferparamFrame, i : Int, v : Double) -> StatsinferparamFrame {
  let result = stats_infer_param_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_frame_sum(s : StatsinferparamFrame) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_frame_mean(s : StatsinferparamFrame) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_frame_scale(s : StatsinferparamFrame, f : Double) -> StatsinferparamFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_frame_add(a : StatsinferparamFrame, b : StatsinferparamFrame) -> StatsinferparamFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_frame_copy(s : StatsinferparamFrame) -> StatsinferparamFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_frame_fill(s : StatsinferparamFrame, v : Double) -> StatsinferparamFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_frame_min(s : StatsinferparamFrame) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_frame_max(s : StatsinferparamFrame) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_frame_to_string(s : StatsinferparamFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_table_make(size : Int) -> StatsinferparamTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_table_len(s : StatsinferparamTable) -> Int { s.size }

pub fn stats_infer_param_table_get(s : StatsinferparamTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_table_set(s : StatsinferparamTable, i : Int, v : Double) -> StatsinferparamTable {
  let result = stats_infer_param_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_table_sum(s : StatsinferparamTable) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_table_mean(s : StatsinferparamTable) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_table_scale(s : StatsinferparamTable, f : Double) -> StatsinferparamTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_table_add(a : StatsinferparamTable, b : StatsinferparamTable) -> StatsinferparamTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_table_copy(s : StatsinferparamTable) -> StatsinferparamTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_table_fill(s : StatsinferparamTable, v : Double) -> StatsinferparamTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_table_min(s : StatsinferparamTable) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_table_max(s : StatsinferparamTable) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_table_to_string(s : StatsinferparamTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_graphn_make(size : Int) -> StatsinferparamGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_graphn_len(s : StatsinferparamGraphN) -> Int { s.size }

pub fn stats_infer_param_graphn_get(s : StatsinferparamGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_graphn_set(s : StatsinferparamGraphN, i : Int, v : Double) -> StatsinferparamGraphN {
  let result = stats_infer_param_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_graphn_sum(s : StatsinferparamGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_graphn_mean(s : StatsinferparamGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_graphn_scale(s : StatsinferparamGraphN, f : Double) -> StatsinferparamGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_graphn_add(a : StatsinferparamGraphN, b : StatsinferparamGraphN) -> StatsinferparamGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_graphn_copy(s : StatsinferparamGraphN) -> StatsinferparamGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_graphn_fill(s : StatsinferparamGraphN, v : Double) -> StatsinferparamGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_graphn_min(s : StatsinferparamGraphN) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_graphn_max(s : StatsinferparamGraphN) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_graphn_to_string(s : StatsinferparamGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_node_make(size : Int) -> StatsinferparamNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_node_len(s : StatsinferparamNode) -> Int { s.size }

pub fn stats_infer_param_node_get(s : StatsinferparamNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_node_set(s : StatsinferparamNode, i : Int, v : Double) -> StatsinferparamNode {
  let result = stats_infer_param_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_node_sum(s : StatsinferparamNode) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_node_mean(s : StatsinferparamNode) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_node_scale(s : StatsinferparamNode, f : Double) -> StatsinferparamNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_node_add(a : StatsinferparamNode, b : StatsinferparamNode) -> StatsinferparamNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_node_copy(s : StatsinferparamNode) -> StatsinferparamNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_node_fill(s : StatsinferparamNode, v : Double) -> StatsinferparamNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_node_min(s : StatsinferparamNode) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_node_max(s : StatsinferparamNode) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_node_to_string(s : StatsinferparamNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_edge_make(size : Int) -> StatsinferparamEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_edge_len(s : StatsinferparamEdge) -> Int { s.size }

pub fn stats_infer_param_edge_get(s : StatsinferparamEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_edge_set(s : StatsinferparamEdge, i : Int, v : Double) -> StatsinferparamEdge {
  let result = stats_infer_param_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_edge_sum(s : StatsinferparamEdge) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_edge_mean(s : StatsinferparamEdge) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_edge_scale(s : StatsinferparamEdge, f : Double) -> StatsinferparamEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_edge_add(a : StatsinferparamEdge, b : StatsinferparamEdge) -> StatsinferparamEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_edge_copy(s : StatsinferparamEdge) -> StatsinferparamEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_edge_fill(s : StatsinferparamEdge, v : Double) -> StatsinferparamEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_edge_min(s : StatsinferparamEdge) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_edge_max(s : StatsinferparamEdge) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_edge_to_string(s : StatsinferparamEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_path_make(size : Int) -> StatsinferparamPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_path_len(s : StatsinferparamPath) -> Int { s.size }

pub fn stats_infer_param_path_get(s : StatsinferparamPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_path_set(s : StatsinferparamPath, i : Int, v : Double) -> StatsinferparamPath {
  let result = stats_infer_param_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_path_sum(s : StatsinferparamPath) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_path_mean(s : StatsinferparamPath) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_path_scale(s : StatsinferparamPath, f : Double) -> StatsinferparamPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_path_add(a : StatsinferparamPath, b : StatsinferparamPath) -> StatsinferparamPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_path_copy(s : StatsinferparamPath) -> StatsinferparamPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_path_fill(s : StatsinferparamPath, v : Double) -> StatsinferparamPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_path_min(s : StatsinferparamPath) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_path_max(s : StatsinferparamPath) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_path_to_string(s : StatsinferparamPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_cluster_make(size : Int) -> StatsinferparamCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_cluster_len(s : StatsinferparamCluster) -> Int { s.size }

pub fn stats_infer_param_cluster_get(s : StatsinferparamCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_cluster_set(s : StatsinferparamCluster, i : Int, v : Double) -> StatsinferparamCluster {
  let result = stats_infer_param_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_cluster_sum(s : StatsinferparamCluster) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_cluster_mean(s : StatsinferparamCluster) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_cluster_scale(s : StatsinferparamCluster, f : Double) -> StatsinferparamCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_cluster_add(a : StatsinferparamCluster, b : StatsinferparamCluster) -> StatsinferparamCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_cluster_copy(s : StatsinferparamCluster) -> StatsinferparamCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_cluster_fill(s : StatsinferparamCluster, v : Double) -> StatsinferparamCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_cluster_min(s : StatsinferparamCluster) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_cluster_max(s : StatsinferparamCluster) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_cluster_to_string(s : StatsinferparamCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_model_make(size : Int) -> StatsinferparamModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_model_len(s : StatsinferparamModel) -> Int { s.size }

pub fn stats_infer_param_model_get(s : StatsinferparamModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_model_set(s : StatsinferparamModel, i : Int, v : Double) -> StatsinferparamModel {
  let result = stats_infer_param_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_model_sum(s : StatsinferparamModel) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_model_mean(s : StatsinferparamModel) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_model_scale(s : StatsinferparamModel, f : Double) -> StatsinferparamModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_model_add(a : StatsinferparamModel, b : StatsinferparamModel) -> StatsinferparamModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_model_copy(s : StatsinferparamModel) -> StatsinferparamModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_model_fill(s : StatsinferparamModel, v : Double) -> StatsinferparamModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_model_min(s : StatsinferparamModel) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_model_max(s : StatsinferparamModel) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_model_to_string(s : StatsinferparamModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_layer_make(size : Int) -> StatsinferparamLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_layer_len(s : StatsinferparamLayer) -> Int { s.size }

pub fn stats_infer_param_layer_get(s : StatsinferparamLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_layer_set(s : StatsinferparamLayer, i : Int, v : Double) -> StatsinferparamLayer {
  let result = stats_infer_param_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_layer_sum(s : StatsinferparamLayer) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_layer_mean(s : StatsinferparamLayer) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_layer_scale(s : StatsinferparamLayer, f : Double) -> StatsinferparamLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_layer_add(a : StatsinferparamLayer, b : StatsinferparamLayer) -> StatsinferparamLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_layer_copy(s : StatsinferparamLayer) -> StatsinferparamLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_layer_fill(s : StatsinferparamLayer, v : Double) -> StatsinferparamLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_layer_min(s : StatsinferparamLayer) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_layer_max(s : StatsinferparamLayer) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_layer_to_string(s : StatsinferparamLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_buffer_make(size : Int) -> StatsinferparamBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_buffer_len(s : StatsinferparamBuffer) -> Int { s.size }

pub fn stats_infer_param_buffer_get(s : StatsinferparamBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_buffer_set(s : StatsinferparamBuffer, i : Int, v : Double) -> StatsinferparamBuffer {
  let result = stats_infer_param_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_buffer_sum(s : StatsinferparamBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_buffer_mean(s : StatsinferparamBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_buffer_scale(s : StatsinferparamBuffer, f : Double) -> StatsinferparamBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_buffer_add(a : StatsinferparamBuffer, b : StatsinferparamBuffer) -> StatsinferparamBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_buffer_copy(s : StatsinferparamBuffer) -> StatsinferparamBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_buffer_fill(s : StatsinferparamBuffer, v : Double) -> StatsinferparamBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_buffer_min(s : StatsinferparamBuffer) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_buffer_max(s : StatsinferparamBuffer) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_buffer_to_string(s : StatsinferparamBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_cursor_make(size : Int) -> StatsinferparamCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_cursor_len(s : StatsinferparamCursor) -> Int { s.size }

pub fn stats_infer_param_cursor_get(s : StatsinferparamCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_cursor_set(s : StatsinferparamCursor, i : Int, v : Double) -> StatsinferparamCursor {
  let result = stats_infer_param_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_cursor_sum(s : StatsinferparamCursor) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_cursor_mean(s : StatsinferparamCursor) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_cursor_scale(s : StatsinferparamCursor, f : Double) -> StatsinferparamCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_cursor_add(a : StatsinferparamCursor, b : StatsinferparamCursor) -> StatsinferparamCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_cursor_copy(s : StatsinferparamCursor) -> StatsinferparamCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_cursor_fill(s : StatsinferparamCursor, v : Double) -> StatsinferparamCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_cursor_min(s : StatsinferparamCursor) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_cursor_max(s : StatsinferparamCursor) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_cursor_to_string(s : StatsinferparamCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_view_make(size : Int) -> StatsinferparamView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_view_len(s : StatsinferparamView) -> Int { s.size }

pub fn stats_infer_param_view_get(s : StatsinferparamView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_view_set(s : StatsinferparamView, i : Int, v : Double) -> StatsinferparamView {
  let result = stats_infer_param_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_view_sum(s : StatsinferparamView) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_view_mean(s : StatsinferparamView) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_view_scale(s : StatsinferparamView, f : Double) -> StatsinferparamView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_view_add(a : StatsinferparamView, b : StatsinferparamView) -> StatsinferparamView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_view_copy(s : StatsinferparamView) -> StatsinferparamView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_view_fill(s : StatsinferparamView, v : Double) -> StatsinferparamView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_view_min(s : StatsinferparamView) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_view_max(s : StatsinferparamView) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_view_to_string(s : StatsinferparamView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_range_make(size : Int) -> StatsinferparamRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_range_len(s : StatsinferparamRange) -> Int { s.size }

pub fn stats_infer_param_range_get(s : StatsinferparamRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_range_set(s : StatsinferparamRange, i : Int, v : Double) -> StatsinferparamRange {
  let result = stats_infer_param_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_range_sum(s : StatsinferparamRange) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_range_mean(s : StatsinferparamRange) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_range_scale(s : StatsinferparamRange, f : Double) -> StatsinferparamRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_range_add(a : StatsinferparamRange, b : StatsinferparamRange) -> StatsinferparamRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_range_copy(s : StatsinferparamRange) -> StatsinferparamRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_range_fill(s : StatsinferparamRange, v : Double) -> StatsinferparamRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_range_min(s : StatsinferparamRange) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_range_max(s : StatsinferparamRange) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_range_to_string(s : StatsinferparamRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_slice_make(size : Int) -> StatsinferparamSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_slice_len(s : StatsinferparamSlice) -> Int { s.size }

pub fn stats_infer_param_slice_get(s : StatsinferparamSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_slice_set(s : StatsinferparamSlice, i : Int, v : Double) -> StatsinferparamSlice {
  let result = stats_infer_param_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_slice_sum(s : StatsinferparamSlice) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_slice_mean(s : StatsinferparamSlice) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_slice_scale(s : StatsinferparamSlice, f : Double) -> StatsinferparamSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_slice_add(a : StatsinferparamSlice, b : StatsinferparamSlice) -> StatsinferparamSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_slice_copy(s : StatsinferparamSlice) -> StatsinferparamSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_slice_fill(s : StatsinferparamSlice, v : Double) -> StatsinferparamSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_slice_min(s : StatsinferparamSlice) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_slice_max(s : StatsinferparamSlice) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_slice_to_string(s : StatsinferparamSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

