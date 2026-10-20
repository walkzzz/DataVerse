///===
/// extcore/stats_infer_nonparam

pub(all) struct StatsinfernonparamPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_infer_nonparam_make_point(x : Double, y : Double) -> StatsinfernonparamPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_infer_nonparam_make_point3(x : Double, y : Double, z : Double) -> StatsinfernonparamPoint {
  { x, y, z, label: 0 }
}

pub fn stats_infer_nonparam_point_x(pt : StatsinfernonparamPoint) -> Double { pt.x }

pub fn stats_infer_nonparam_point_y(pt : StatsinfernonparamPoint) -> Double { pt.y }

pub fn stats_infer_nonparam_point_z(pt : StatsinfernonparamPoint) -> Double { pt.z }

pub fn stats_infer_nonparam_point_label(pt : StatsinfernonparamPoint) -> Int { pt.label }

pub fn stats_infer_nonparam_point_dist(a : StatsinfernonparamPoint, b : StatsinfernonparamPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_infer_nonparam_point_add(a : StatsinfernonparamPoint, b : StatsinfernonparamPoint) -> StatsinfernonparamPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_infer_nonparam_point_sub(a : StatsinfernonparamPoint, b : StatsinfernonparamPoint) -> StatsinfernonparamPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_infer_nonparam_point_scale(pt : StatsinfernonparamPoint, s : Double) -> StatsinfernonparamPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_infer_nonparam_point_dot(a : StatsinfernonparamPoint, b : StatsinfernonparamPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_infer_nonparam_point_cross(a : StatsinfernonparamPoint, b : StatsinfernonparamPoint) -> StatsinfernonparamPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_infer_nonparam_point_norm(pt : StatsinfernonparamPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_infer_nonparam_point_normalize(pt : StatsinfernonparamPoint) -> StatsinfernonparamPoint {
  let n = stats_infer_nonparam_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_infer_nonparam_point_scale(pt, 1.0 / n) }
}

pub fn stats_infer_nonparam_point_negate(pt : StatsinfernonparamPoint) -> StatsinfernonparamPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_infer_nonparam_point_mid(a : StatsinfernonparamPoint, b : StatsinfernonparamPoint) -> StatsinfernonparamPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_infer_nonparam_point_lerp(a : StatsinfernonparamPoint, b : StatsinfernonparamPoint, t : Double) -> StatsinfernonparamPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_infer_nonparam_point_to_string(pt : StatsinfernonparamPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsinfernonparamSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_infer_nonparam_make_series(vals : Array[Double], name : String) -> StatsinfernonparamSeries {
  { vals, name, meta: 0 }
}

pub fn stats_infer_nonparam_series_len(s : StatsinfernonparamSeries) -> Int { s.vals.length() }

pub fn stats_infer_nonparam_series_sum(s : StatsinfernonparamSeries) -> Double { @_common.sum(s.vals) }

pub fn stats_infer_nonparam_series_mean(s : StatsinfernonparamSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_infer_nonparam_series_min(s : StatsinfernonparamSeries) -> Double { @_common.min(s.vals) }

pub fn stats_infer_nonparam_series_max(s : StatsinfernonparamSeries) -> Double { @_common.max(s.vals) }

pub fn stats_infer_nonparam_series_range(s : StatsinfernonparamSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_infer_nonparam_series_var(s : StatsinfernonparamSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_infer_nonparam_series_std(s : StatsinfernonparamSeries) -> Double { @_common.std(s.vals) }

pub fn stats_infer_nonparam_series_median(s : StatsinfernonparamSeries) -> Double { @_common.median(s.vals) }

pub fn stats_infer_nonparam_series_scale(s : StatsinfernonparamSeries, f : Double) -> StatsinfernonparamSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_infer_nonparam_series_add(a : StatsinfernonparamSeries, b : StatsinfernonparamSeries) -> StatsinfernonparamSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_infer_nonparam_series_sub(a : StatsinfernonparamSeries, b : StatsinfernonparamSeries) -> StatsinfernonparamSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_infer_nonparam_series_normalize(s : StatsinfernonparamSeries) -> StatsinfernonparamSeries {
  let mn = stats_infer_nonparam_series_min(s)
  let mx = stats_infer_nonparam_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_infer_nonparam_series_cumsum(s : StatsinfernonparamSeries) -> StatsinfernonparamSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_infer_nonparam_series_to_string(s : StatsinfernonparamSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsinfernonparamMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_infer_nonparam_make_matrix(rows : Int, cols : Int, val : Double) -> StatsinfernonparamMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_infer_nonparam_matrix_identity(n : Int) -> StatsinfernonparamMatrix {
  let m = stats_infer_nonparam_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_infer_nonparam_matrix_get(m : StatsinfernonparamMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_infer_nonparam_matrix_transpose(m : StatsinfernonparamMatrix) -> StatsinfernonparamMatrix {
  let result = stats_infer_nonparam_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_infer_nonparam_matrix_add(a : StatsinfernonparamMatrix, b : StatsinfernonparamMatrix) -> StatsinfernonparamMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_infer_nonparam_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_infer_nonparam_matrix_scale(m : StatsinfernonparamMatrix, s : Double) -> StatsinfernonparamMatrix {
  let result = stats_infer_nonparam_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_infer_nonparam_matrix_multiply(a : StatsinfernonparamMatrix, b : StatsinfernonparamMatrix) -> StatsinfernonparamMatrix {
  if a.cols != b.rows { return stats_infer_nonparam_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_infer_nonparam_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_infer_nonparam_matrix_trace(m : StatsinfernonparamMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_infer_nonparam_matrix_det(m : StatsinfernonparamMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_infer_nonparam_matrix_norm(m : StatsinfernonparamMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_infer_nonparam_matrix_to_string(m : StatsinfernonparamMatrix) -> String {
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

pub(all) struct StatsinfernonparamVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_infer_nonparam_make_vector(comps : Array[Double]) -> StatsinfernonparamVector {
  { comps, dim: comps.length() }
}

pub fn stats_infer_nonparam_vector_zero(dim : Int) -> StatsinfernonparamVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_infer_nonparam_vector_add(a : StatsinfernonparamVector, b : StatsinfernonparamVector) -> StatsinfernonparamVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_infer_nonparam_vector_sub(a : StatsinfernonparamVector, b : StatsinfernonparamVector) -> StatsinfernonparamVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_infer_nonparam_vector_scale(v : StatsinfernonparamVector, s : Double) -> StatsinfernonparamVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_infer_nonparam_vector_dot(a : StatsinfernonparamVector, b : StatsinfernonparamVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_infer_nonparam_vector_norm(v : StatsinfernonparamVector) -> Double { @_common.sqrt(stats_infer_nonparam_vector_dot(v, v)) }

pub fn stats_infer_nonparam_vector_normalize(v : StatsinfernonparamVector) -> StatsinfernonparamVector {
  let n = stats_infer_nonparam_vector_norm(v)
  if n < 0.0000001 { v } else { stats_infer_nonparam_vector_scale(v, 1.0 / n) }
}

pub fn stats_infer_nonparam_vector_dist(a : StatsinfernonparamVector, b : StatsinfernonparamVector) -> Double {
  stats_infer_nonparam_vector_norm(stats_infer_nonparam_vector_sub(a, b))
}

pub fn stats_infer_nonparam_vector_to_string(v : StatsinfernonparamVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_infer_nonparam_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_infer_nonparam_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_infer_nonparam_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_infer_nonparam_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_infer_nonparam_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_infer_nonparam_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_infer_nonparam_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_infer_nonparam_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_infer_nonparam_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_infer_nonparam_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_infer_nonparam_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_infer_nonparam_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_infer_nonparam_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_infer_nonparam_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_infer_nonparam_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_infer_nonparam_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_infer_nonparam_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_infer_nonparam_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_infer_nonparam_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_infer_nonparam_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_infer_nonparam_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_infer_nonparam_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_infer_nonparam_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_infer_nonparam_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_infer_nonparam_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_infer_nonparam_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_infer_nonparam_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_infer_nonparam_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_infer_nonparam_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsinfernonparamFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_frame_make(size : Int) -> StatsinfernonparamFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_frame_len(s : StatsinfernonparamFrame) -> Int { s.size }

pub fn stats_infer_nonparam_frame_get(s : StatsinfernonparamFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_frame_set(s : StatsinfernonparamFrame, i : Int, v : Double) -> StatsinfernonparamFrame {
  let result = stats_infer_nonparam_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_frame_sum(s : StatsinfernonparamFrame) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_frame_mean(s : StatsinfernonparamFrame) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_frame_scale(s : StatsinfernonparamFrame, f : Double) -> StatsinfernonparamFrame {
  let result = stats_infer_nonparam_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_nonparam_frame_add(a : StatsinfernonparamFrame, b : StatsinfernonparamFrame) -> StatsinfernonparamFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_nonparam_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_nonparam_frame_copy(s : StatsinfernonparamFrame) -> StatsinfernonparamFrame {
  let result = stats_infer_nonparam_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_nonparam_frame_fill(s : StatsinfernonparamFrame, v : Double) -> StatsinfernonparamFrame {
  let result = stats_infer_nonparam_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_frame_min(s : StatsinfernonparamFrame) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_frame_max(s : StatsinfernonparamFrame) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_frame_to_string(s : StatsinfernonparamFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_table_make(size : Int) -> StatsinfernonparamTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_table_len(s : StatsinfernonparamTable) -> Int { s.size }

pub fn stats_infer_nonparam_table_get(s : StatsinfernonparamTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_table_set(s : StatsinfernonparamTable, i : Int, v : Double) -> StatsinfernonparamTable {
  let result = stats_infer_nonparam_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_table_sum(s : StatsinfernonparamTable) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_table_mean(s : StatsinfernonparamTable) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_table_scale(s : StatsinfernonparamTable, f : Double) -> StatsinfernonparamTable {
  let result = stats_infer_nonparam_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_nonparam_table_add(a : StatsinfernonparamTable, b : StatsinfernonparamTable) -> StatsinfernonparamTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_nonparam_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_nonparam_table_copy(s : StatsinfernonparamTable) -> StatsinfernonparamTable {
  let result = stats_infer_nonparam_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_nonparam_table_fill(s : StatsinfernonparamTable, v : Double) -> StatsinfernonparamTable {
  let result = stats_infer_nonparam_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_table_min(s : StatsinfernonparamTable) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_table_max(s : StatsinfernonparamTable) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_table_to_string(s : StatsinfernonparamTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_graphn_make(size : Int) -> StatsinfernonparamGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_graphn_len(s : StatsinfernonparamGraphN) -> Int { s.size }

pub fn stats_infer_nonparam_graphn_get(s : StatsinfernonparamGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_graphn_set(s : StatsinfernonparamGraphN, i : Int, v : Double) -> StatsinfernonparamGraphN {
  let result = stats_infer_nonparam_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_graphn_sum(s : StatsinfernonparamGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_graphn_mean(s : StatsinfernonparamGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_graphn_scale(s : StatsinfernonparamGraphN, f : Double) -> StatsinfernonparamGraphN {
  let result = stats_infer_nonparam_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_nonparam_graphn_add(a : StatsinfernonparamGraphN, b : StatsinfernonparamGraphN) -> StatsinfernonparamGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_nonparam_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_nonparam_graphn_copy(s : StatsinfernonparamGraphN) -> StatsinfernonparamGraphN {
  let result = stats_infer_nonparam_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_nonparam_graphn_fill(s : StatsinfernonparamGraphN, v : Double) -> StatsinfernonparamGraphN {
  let result = stats_infer_nonparam_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_graphn_min(s : StatsinfernonparamGraphN) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_graphn_max(s : StatsinfernonparamGraphN) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_graphn_to_string(s : StatsinfernonparamGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_node_make(size : Int) -> StatsinfernonparamNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_node_len(s : StatsinfernonparamNode) -> Int { s.size }

pub fn stats_infer_nonparam_node_get(s : StatsinfernonparamNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_node_set(s : StatsinfernonparamNode, i : Int, v : Double) -> StatsinfernonparamNode {
  let result = stats_infer_nonparam_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_node_sum(s : StatsinfernonparamNode) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_node_mean(s : StatsinfernonparamNode) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_node_scale(s : StatsinfernonparamNode, f : Double) -> StatsinfernonparamNode {
  let result = stats_infer_nonparam_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_nonparam_node_add(a : StatsinfernonparamNode, b : StatsinfernonparamNode) -> StatsinfernonparamNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_nonparam_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_nonparam_node_copy(s : StatsinfernonparamNode) -> StatsinfernonparamNode {
  let result = stats_infer_nonparam_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_nonparam_node_fill(s : StatsinfernonparamNode, v : Double) -> StatsinfernonparamNode {
  let result = stats_infer_nonparam_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_node_min(s : StatsinfernonparamNode) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_node_max(s : StatsinfernonparamNode) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_node_to_string(s : StatsinfernonparamNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_edge_make(size : Int) -> StatsinfernonparamEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_edge_len(s : StatsinfernonparamEdge) -> Int { s.size }

pub fn stats_infer_nonparam_edge_get(s : StatsinfernonparamEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_edge_set(s : StatsinfernonparamEdge, i : Int, v : Double) -> StatsinfernonparamEdge {
  let result = stats_infer_nonparam_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_edge_sum(s : StatsinfernonparamEdge) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_edge_mean(s : StatsinfernonparamEdge) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_edge_scale(s : StatsinfernonparamEdge, f : Double) -> StatsinfernonparamEdge {
  let result = stats_infer_nonparam_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_nonparam_edge_add(a : StatsinfernonparamEdge, b : StatsinfernonparamEdge) -> StatsinfernonparamEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_nonparam_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_nonparam_edge_copy(s : StatsinfernonparamEdge) -> StatsinfernonparamEdge {
  let result = stats_infer_nonparam_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_nonparam_edge_fill(s : StatsinfernonparamEdge, v : Double) -> StatsinfernonparamEdge {
  let result = stats_infer_nonparam_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_edge_min(s : StatsinfernonparamEdge) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_edge_max(s : StatsinfernonparamEdge) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_edge_to_string(s : StatsinfernonparamEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_path_make(size : Int) -> StatsinfernonparamPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_path_len(s : StatsinfernonparamPath) -> Int { s.size }

pub fn stats_infer_nonparam_path_get(s : StatsinfernonparamPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_path_set(s : StatsinfernonparamPath, i : Int, v : Double) -> StatsinfernonparamPath {
  let result = stats_infer_nonparam_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_path_sum(s : StatsinfernonparamPath) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_path_mean(s : StatsinfernonparamPath) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_path_scale(s : StatsinfernonparamPath, f : Double) -> StatsinfernonparamPath {
  let result = stats_infer_nonparam_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_nonparam_path_add(a : StatsinfernonparamPath, b : StatsinfernonparamPath) -> StatsinfernonparamPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_nonparam_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_nonparam_path_copy(s : StatsinfernonparamPath) -> StatsinfernonparamPath {
  let result = stats_infer_nonparam_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_nonparam_path_fill(s : StatsinfernonparamPath, v : Double) -> StatsinfernonparamPath {
  let result = stats_infer_nonparam_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_path_min(s : StatsinfernonparamPath) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_path_max(s : StatsinfernonparamPath) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_path_to_string(s : StatsinfernonparamPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_cluster_make(size : Int) -> StatsinfernonparamCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_cluster_len(s : StatsinfernonparamCluster) -> Int { s.size }

pub fn stats_infer_nonparam_cluster_get(s : StatsinfernonparamCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_cluster_set(s : StatsinfernonparamCluster, i : Int, v : Double) -> StatsinfernonparamCluster {
  let result = stats_infer_nonparam_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_cluster_sum(s : StatsinfernonparamCluster) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_cluster_mean(s : StatsinfernonparamCluster) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_cluster_scale(s : StatsinfernonparamCluster, f : Double) -> StatsinfernonparamCluster {
  let result = stats_infer_nonparam_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_nonparam_cluster_add(a : StatsinfernonparamCluster, b : StatsinfernonparamCluster) -> StatsinfernonparamCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_nonparam_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_nonparam_cluster_copy(s : StatsinfernonparamCluster) -> StatsinfernonparamCluster {
  let result = stats_infer_nonparam_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_nonparam_cluster_fill(s : StatsinfernonparamCluster, v : Double) -> StatsinfernonparamCluster {
  let result = stats_infer_nonparam_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_cluster_min(s : StatsinfernonparamCluster) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_cluster_max(s : StatsinfernonparamCluster) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_cluster_to_string(s : StatsinfernonparamCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_model_make(size : Int) -> StatsinfernonparamModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_model_len(s : StatsinfernonparamModel) -> Int { s.size }

pub fn stats_infer_nonparam_model_get(s : StatsinfernonparamModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_model_set(s : StatsinfernonparamModel, i : Int, v : Double) -> StatsinfernonparamModel {
  let result = stats_infer_nonparam_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_model_sum(s : StatsinfernonparamModel) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_model_mean(s : StatsinfernonparamModel) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_model_scale(s : StatsinfernonparamModel, f : Double) -> StatsinfernonparamModel {
  let result = stats_infer_nonparam_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_nonparam_model_add(a : StatsinfernonparamModel, b : StatsinfernonparamModel) -> StatsinfernonparamModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_nonparam_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_nonparam_model_copy(s : StatsinfernonparamModel) -> StatsinfernonparamModel {
  let result = stats_infer_nonparam_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_nonparam_model_fill(s : StatsinfernonparamModel, v : Double) -> StatsinfernonparamModel {
  let result = stats_infer_nonparam_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_model_min(s : StatsinfernonparamModel) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_model_max(s : StatsinfernonparamModel) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_model_to_string(s : StatsinfernonparamModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_layer_make(size : Int) -> StatsinfernonparamLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_layer_len(s : StatsinfernonparamLayer) -> Int { s.size }

pub fn stats_infer_nonparam_layer_get(s : StatsinfernonparamLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_layer_set(s : StatsinfernonparamLayer, i : Int, v : Double) -> StatsinfernonparamLayer {
  let result = stats_infer_nonparam_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_layer_sum(s : StatsinfernonparamLayer) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_layer_mean(s : StatsinfernonparamLayer) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_layer_scale(s : StatsinfernonparamLayer, f : Double) -> StatsinfernonparamLayer {
  let result = stats_infer_nonparam_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_nonparam_layer_add(a : StatsinfernonparamLayer, b : StatsinfernonparamLayer) -> StatsinfernonparamLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_nonparam_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_nonparam_layer_copy(s : StatsinfernonparamLayer) -> StatsinfernonparamLayer {
  let result = stats_infer_nonparam_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_nonparam_layer_fill(s : StatsinfernonparamLayer, v : Double) -> StatsinfernonparamLayer {
  let result = stats_infer_nonparam_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_layer_min(s : StatsinfernonparamLayer) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_layer_max(s : StatsinfernonparamLayer) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_layer_to_string(s : StatsinfernonparamLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_buffer_make(size : Int) -> StatsinfernonparamBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_buffer_len(s : StatsinfernonparamBuffer) -> Int { s.size }

pub fn stats_infer_nonparam_buffer_get(s : StatsinfernonparamBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_buffer_set(s : StatsinfernonparamBuffer, i : Int, v : Double) -> StatsinfernonparamBuffer {
  let result = stats_infer_nonparam_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_buffer_sum(s : StatsinfernonparamBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_buffer_mean(s : StatsinfernonparamBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_buffer_scale(s : StatsinfernonparamBuffer, f : Double) -> StatsinfernonparamBuffer {
  let result = stats_infer_nonparam_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_nonparam_buffer_add(a : StatsinfernonparamBuffer, b : StatsinfernonparamBuffer) -> StatsinfernonparamBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_nonparam_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_nonparam_buffer_copy(s : StatsinfernonparamBuffer) -> StatsinfernonparamBuffer {
  let result = stats_infer_nonparam_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_nonparam_buffer_fill(s : StatsinfernonparamBuffer, v : Double) -> StatsinfernonparamBuffer {
  let result = stats_infer_nonparam_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_buffer_min(s : StatsinfernonparamBuffer) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_buffer_max(s : StatsinfernonparamBuffer) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_buffer_to_string(s : StatsinfernonparamBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_cursor_make(size : Int) -> StatsinfernonparamCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_cursor_len(s : StatsinfernonparamCursor) -> Int { s.size }

pub fn stats_infer_nonparam_cursor_get(s : StatsinfernonparamCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_cursor_set(s : StatsinfernonparamCursor, i : Int, v : Double) -> StatsinfernonparamCursor {
  let result = stats_infer_nonparam_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_cursor_sum(s : StatsinfernonparamCursor) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_cursor_mean(s : StatsinfernonparamCursor) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_cursor_scale(s : StatsinfernonparamCursor, f : Double) -> StatsinfernonparamCursor {
  let result = stats_infer_nonparam_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_nonparam_cursor_add(a : StatsinfernonparamCursor, b : StatsinfernonparamCursor) -> StatsinfernonparamCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_nonparam_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_nonparam_cursor_copy(s : StatsinfernonparamCursor) -> StatsinfernonparamCursor {
  let result = stats_infer_nonparam_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_nonparam_cursor_fill(s : StatsinfernonparamCursor, v : Double) -> StatsinfernonparamCursor {
  let result = stats_infer_nonparam_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_cursor_min(s : StatsinfernonparamCursor) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_cursor_max(s : StatsinfernonparamCursor) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_cursor_to_string(s : StatsinfernonparamCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_view_make(size : Int) -> StatsinfernonparamView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_view_len(s : StatsinfernonparamView) -> Int { s.size }

pub fn stats_infer_nonparam_view_get(s : StatsinfernonparamView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_view_set(s : StatsinfernonparamView, i : Int, v : Double) -> StatsinfernonparamView {
  let result = stats_infer_nonparam_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_view_sum(s : StatsinfernonparamView) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_view_mean(s : StatsinfernonparamView) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_view_scale(s : StatsinfernonparamView, f : Double) -> StatsinfernonparamView {
  let result = stats_infer_nonparam_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_nonparam_view_add(a : StatsinfernonparamView, b : StatsinfernonparamView) -> StatsinfernonparamView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_nonparam_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_nonparam_view_copy(s : StatsinfernonparamView) -> StatsinfernonparamView {
  let result = stats_infer_nonparam_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_nonparam_view_fill(s : StatsinfernonparamView, v : Double) -> StatsinfernonparamView {
  let result = stats_infer_nonparam_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_view_min(s : StatsinfernonparamView) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_view_max(s : StatsinfernonparamView) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_view_to_string(s : StatsinfernonparamView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_range_make(size : Int) -> StatsinfernonparamRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_range_len(s : StatsinfernonparamRange) -> Int { s.size }

pub fn stats_infer_nonparam_range_get(s : StatsinfernonparamRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_range_set(s : StatsinfernonparamRange, i : Int, v : Double) -> StatsinfernonparamRange {
  let result = stats_infer_nonparam_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_range_sum(s : StatsinfernonparamRange) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_range_mean(s : StatsinfernonparamRange) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_range_scale(s : StatsinfernonparamRange, f : Double) -> StatsinfernonparamRange {
  let result = stats_infer_nonparam_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_nonparam_range_add(a : StatsinfernonparamRange, b : StatsinfernonparamRange) -> StatsinfernonparamRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_nonparam_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_nonparam_range_copy(s : StatsinfernonparamRange) -> StatsinfernonparamRange {
  let result = stats_infer_nonparam_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_nonparam_range_fill(s : StatsinfernonparamRange, v : Double) -> StatsinfernonparamRange {
  let result = stats_infer_nonparam_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_range_min(s : StatsinfernonparamRange) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_range_max(s : StatsinfernonparamRange) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_range_to_string(s : StatsinfernonparamRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_slice_make(size : Int) -> StatsinfernonparamSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_slice_len(s : StatsinfernonparamSlice) -> Int { s.size }

pub fn stats_infer_nonparam_slice_get(s : StatsinfernonparamSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_slice_set(s : StatsinfernonparamSlice, i : Int, v : Double) -> StatsinfernonparamSlice {
  let result = stats_infer_nonparam_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_slice_sum(s : StatsinfernonparamSlice) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_slice_mean(s : StatsinfernonparamSlice) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_slice_scale(s : StatsinfernonparamSlice, f : Double) -> StatsinfernonparamSlice {
  let result = stats_infer_nonparam_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_nonparam_slice_add(a : StatsinfernonparamSlice, b : StatsinfernonparamSlice) -> StatsinfernonparamSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_nonparam_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_nonparam_slice_copy(s : StatsinfernonparamSlice) -> StatsinfernonparamSlice {
  let result = stats_infer_nonparam_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_nonparam_slice_fill(s : StatsinfernonparamSlice, v : Double) -> StatsinfernonparamSlice {
  let result = stats_infer_nonparam_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_nonparam_slice_min(s : StatsinfernonparamSlice) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_slice_max(s : StatsinfernonparamSlice) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_slice_to_string(s : StatsinfernonparamSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

