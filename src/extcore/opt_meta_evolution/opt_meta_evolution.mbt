///===
/// extcore/opt_meta_evolution

pub(all) struct OptmetaevolutionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_evolution_make_point(x : Double, y : Double) -> OptmetaevolutionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_evolution_make_point3(x : Double, y : Double, z : Double) -> OptmetaevolutionPoint {
  { x, y, z, label: 0 }
}

pub fn opt_meta_evolution_point_x(pt : OptmetaevolutionPoint) -> Double { pt.x }

pub fn opt_meta_evolution_point_y(pt : OptmetaevolutionPoint) -> Double { pt.y }

pub fn opt_meta_evolution_point_z(pt : OptmetaevolutionPoint) -> Double { pt.z }

pub fn opt_meta_evolution_point_label(pt : OptmetaevolutionPoint) -> Int { pt.label }

pub fn opt_meta_evolution_point_dist(a : OptmetaevolutionPoint, b : OptmetaevolutionPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_meta_evolution_point_add(a : OptmetaevolutionPoint, b : OptmetaevolutionPoint) -> OptmetaevolutionPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_meta_evolution_point_sub(a : OptmetaevolutionPoint, b : OptmetaevolutionPoint) -> OptmetaevolutionPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_meta_evolution_point_scale(pt : OptmetaevolutionPoint, s : Double) -> OptmetaevolutionPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_meta_evolution_point_dot(a : OptmetaevolutionPoint, b : OptmetaevolutionPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_meta_evolution_point_cross(a : OptmetaevolutionPoint, b : OptmetaevolutionPoint) -> OptmetaevolutionPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_meta_evolution_point_norm(pt : OptmetaevolutionPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_meta_evolution_point_normalize(pt : OptmetaevolutionPoint) -> OptmetaevolutionPoint {
  let n = opt_meta_evolution_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_meta_evolution_point_scale(pt, 1.0 / n) }
}

pub fn opt_meta_evolution_point_negate(pt : OptmetaevolutionPoint) -> OptmetaevolutionPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_meta_evolution_point_mid(a : OptmetaevolutionPoint, b : OptmetaevolutionPoint) -> OptmetaevolutionPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_meta_evolution_point_lerp(a : OptmetaevolutionPoint, b : OptmetaevolutionPoint, t : Double) -> OptmetaevolutionPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_meta_evolution_point_to_string(pt : OptmetaevolutionPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptmetaevolutionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_evolution_make_series(vals : Array[Double], name : String) -> OptmetaevolutionSeries {
  { vals, name, meta: 0 }
}

pub fn opt_meta_evolution_series_len(s : OptmetaevolutionSeries) -> Int { s.vals.length() }

pub fn opt_meta_evolution_series_sum(s : OptmetaevolutionSeries) -> Double { @_common.sum(s.vals) }

pub fn opt_meta_evolution_series_mean(s : OptmetaevolutionSeries) -> Double { @_common.mean(s.vals) }

pub fn opt_meta_evolution_series_min(s : OptmetaevolutionSeries) -> Double { @_common.min(s.vals) }

pub fn opt_meta_evolution_series_max(s : OptmetaevolutionSeries) -> Double { @_common.max(s.vals) }

pub fn opt_meta_evolution_series_range(s : OptmetaevolutionSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn opt_meta_evolution_series_var(s : OptmetaevolutionSeries) -> Double { @_common.variance(s.vals) }

pub fn opt_meta_evolution_series_std(s : OptmetaevolutionSeries) -> Double { @_common.std(s.vals) }

pub fn opt_meta_evolution_series_median(s : OptmetaevolutionSeries) -> Double { @_common.median(s.vals) }

pub fn opt_meta_evolution_series_scale(s : OptmetaevolutionSeries, f : Double) -> OptmetaevolutionSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_meta_evolution_series_add(a : OptmetaevolutionSeries, b : OptmetaevolutionSeries) -> OptmetaevolutionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_meta_evolution_series_sub(a : OptmetaevolutionSeries, b : OptmetaevolutionSeries) -> OptmetaevolutionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_meta_evolution_series_normalize(s : OptmetaevolutionSeries) -> OptmetaevolutionSeries {
  let mn = opt_meta_evolution_series_min(s)
  let mx = opt_meta_evolution_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_meta_evolution_series_cumsum(s : OptmetaevolutionSeries) -> OptmetaevolutionSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_meta_evolution_series_to_string(s : OptmetaevolutionSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetaevolutionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_evolution_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetaevolutionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_evolution_matrix_identity(n : Int) -> OptmetaevolutionMatrix {
  let m = opt_meta_evolution_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_meta_evolution_matrix_get(m : OptmetaevolutionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_meta_evolution_matrix_transpose(m : OptmetaevolutionMatrix) -> OptmetaevolutionMatrix {
  let result = opt_meta_evolution_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_meta_evolution_matrix_add(a : OptmetaevolutionMatrix, b : OptmetaevolutionMatrix) -> OptmetaevolutionMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_meta_evolution_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_meta_evolution_matrix_scale(m : OptmetaevolutionMatrix, s : Double) -> OptmetaevolutionMatrix {
  let result = opt_meta_evolution_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_meta_evolution_matrix_multiply(a : OptmetaevolutionMatrix, b : OptmetaevolutionMatrix) -> OptmetaevolutionMatrix {
  if a.cols != b.rows { return opt_meta_evolution_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_meta_evolution_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_meta_evolution_matrix_trace(m : OptmetaevolutionMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_meta_evolution_matrix_det(m : OptmetaevolutionMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_meta_evolution_matrix_norm(m : OptmetaevolutionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn opt_meta_evolution_matrix_to_string(m : OptmetaevolutionMatrix) -> String {
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

pub(all) struct OptmetaevolutionVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_evolution_make_vector(comps : Array[Double]) -> OptmetaevolutionVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_evolution_vector_zero(dim : Int) -> OptmetaevolutionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_meta_evolution_vector_add(a : OptmetaevolutionVector, b : OptmetaevolutionVector) -> OptmetaevolutionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_meta_evolution_vector_sub(a : OptmetaevolutionVector, b : OptmetaevolutionVector) -> OptmetaevolutionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_meta_evolution_vector_scale(v : OptmetaevolutionVector, s : Double) -> OptmetaevolutionVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_meta_evolution_vector_dot(a : OptmetaevolutionVector, b : OptmetaevolutionVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_meta_evolution_vector_norm(v : OptmetaevolutionVector) -> Double { @_common.sqrt(opt_meta_evolution_vector_dot(v, v)) }

pub fn opt_meta_evolution_vector_normalize(v : OptmetaevolutionVector) -> OptmetaevolutionVector {
  let n = opt_meta_evolution_vector_norm(v)
  if n < 0.0000001 { v } else { opt_meta_evolution_vector_scale(v, 1.0 / n) }
}

pub fn opt_meta_evolution_vector_dist(a : OptmetaevolutionVector, b : OptmetaevolutionVector) -> Double {
  opt_meta_evolution_vector_norm(opt_meta_evolution_vector_sub(a, b))
}

pub fn opt_meta_evolution_vector_to_string(v : OptmetaevolutionVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_meta_evolution_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_meta_evolution_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_meta_evolution_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_meta_evolution_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_meta_evolution_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_meta_evolution_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_meta_evolution_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_meta_evolution_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_meta_evolution_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_meta_evolution_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_meta_evolution_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_meta_evolution_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_meta_evolution_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_meta_evolution_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_meta_evolution_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_meta_evolution_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_meta_evolution_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_meta_evolution_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_meta_evolution_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_meta_evolution_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_meta_evolution_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_meta_evolution_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_meta_evolution_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_meta_evolution_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_meta_evolution_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_meta_evolution_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_meta_evolution_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_meta_evolution_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_meta_evolution_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptmetaevolutionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_frame_make(size : Int) -> OptmetaevolutionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_frame_len(s : OptmetaevolutionFrame) -> Int { s.size }

pub fn opt_meta_evolution_frame_get(s : OptmetaevolutionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_frame_set(s : OptmetaevolutionFrame, i : Int, v : Double) -> OptmetaevolutionFrame {
  let result = opt_meta_evolution_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_frame_sum(s : OptmetaevolutionFrame) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_frame_mean(s : OptmetaevolutionFrame) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_frame_scale(s : OptmetaevolutionFrame, f : Double) -> OptmetaevolutionFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_frame_add(a : OptmetaevolutionFrame, b : OptmetaevolutionFrame) -> OptmetaevolutionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_frame_copy(s : OptmetaevolutionFrame) -> OptmetaevolutionFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_frame_fill(s : OptmetaevolutionFrame, v : Double) -> OptmetaevolutionFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_frame_min(s : OptmetaevolutionFrame) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_frame_max(s : OptmetaevolutionFrame) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_frame_to_string(s : OptmetaevolutionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_table_make(size : Int) -> OptmetaevolutionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_table_len(s : OptmetaevolutionTable) -> Int { s.size }

pub fn opt_meta_evolution_table_get(s : OptmetaevolutionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_table_set(s : OptmetaevolutionTable, i : Int, v : Double) -> OptmetaevolutionTable {
  let result = opt_meta_evolution_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_table_sum(s : OptmetaevolutionTable) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_table_mean(s : OptmetaevolutionTable) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_table_scale(s : OptmetaevolutionTable, f : Double) -> OptmetaevolutionTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_table_add(a : OptmetaevolutionTable, b : OptmetaevolutionTable) -> OptmetaevolutionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_table_copy(s : OptmetaevolutionTable) -> OptmetaevolutionTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_table_fill(s : OptmetaevolutionTable, v : Double) -> OptmetaevolutionTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_table_min(s : OptmetaevolutionTable) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_table_max(s : OptmetaevolutionTable) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_table_to_string(s : OptmetaevolutionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_graphn_make(size : Int) -> OptmetaevolutionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_graphn_len(s : OptmetaevolutionGraphN) -> Int { s.size }

pub fn opt_meta_evolution_graphn_get(s : OptmetaevolutionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_graphn_set(s : OptmetaevolutionGraphN, i : Int, v : Double) -> OptmetaevolutionGraphN {
  let result = opt_meta_evolution_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_graphn_sum(s : OptmetaevolutionGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_graphn_mean(s : OptmetaevolutionGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_graphn_scale(s : OptmetaevolutionGraphN, f : Double) -> OptmetaevolutionGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_graphn_add(a : OptmetaevolutionGraphN, b : OptmetaevolutionGraphN) -> OptmetaevolutionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_graphn_copy(s : OptmetaevolutionGraphN) -> OptmetaevolutionGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_graphn_fill(s : OptmetaevolutionGraphN, v : Double) -> OptmetaevolutionGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_graphn_min(s : OptmetaevolutionGraphN) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_graphn_max(s : OptmetaevolutionGraphN) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_graphn_to_string(s : OptmetaevolutionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_node_make(size : Int) -> OptmetaevolutionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_node_len(s : OptmetaevolutionNode) -> Int { s.size }

pub fn opt_meta_evolution_node_get(s : OptmetaevolutionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_node_set(s : OptmetaevolutionNode, i : Int, v : Double) -> OptmetaevolutionNode {
  let result = opt_meta_evolution_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_node_sum(s : OptmetaevolutionNode) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_node_mean(s : OptmetaevolutionNode) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_node_scale(s : OptmetaevolutionNode, f : Double) -> OptmetaevolutionNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_node_add(a : OptmetaevolutionNode, b : OptmetaevolutionNode) -> OptmetaevolutionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_node_copy(s : OptmetaevolutionNode) -> OptmetaevolutionNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_node_fill(s : OptmetaevolutionNode, v : Double) -> OptmetaevolutionNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_node_min(s : OptmetaevolutionNode) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_node_max(s : OptmetaevolutionNode) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_node_to_string(s : OptmetaevolutionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_edge_make(size : Int) -> OptmetaevolutionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_edge_len(s : OptmetaevolutionEdge) -> Int { s.size }

pub fn opt_meta_evolution_edge_get(s : OptmetaevolutionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_edge_set(s : OptmetaevolutionEdge, i : Int, v : Double) -> OptmetaevolutionEdge {
  let result = opt_meta_evolution_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_edge_sum(s : OptmetaevolutionEdge) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_edge_mean(s : OptmetaevolutionEdge) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_edge_scale(s : OptmetaevolutionEdge, f : Double) -> OptmetaevolutionEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_edge_add(a : OptmetaevolutionEdge, b : OptmetaevolutionEdge) -> OptmetaevolutionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_edge_copy(s : OptmetaevolutionEdge) -> OptmetaevolutionEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_edge_fill(s : OptmetaevolutionEdge, v : Double) -> OptmetaevolutionEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_edge_min(s : OptmetaevolutionEdge) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_edge_max(s : OptmetaevolutionEdge) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_edge_to_string(s : OptmetaevolutionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_path_make(size : Int) -> OptmetaevolutionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_path_len(s : OptmetaevolutionPath) -> Int { s.size }

pub fn opt_meta_evolution_path_get(s : OptmetaevolutionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_path_set(s : OptmetaevolutionPath, i : Int, v : Double) -> OptmetaevolutionPath {
  let result = opt_meta_evolution_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_path_sum(s : OptmetaevolutionPath) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_path_mean(s : OptmetaevolutionPath) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_path_scale(s : OptmetaevolutionPath, f : Double) -> OptmetaevolutionPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_path_add(a : OptmetaevolutionPath, b : OptmetaevolutionPath) -> OptmetaevolutionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_path_copy(s : OptmetaevolutionPath) -> OptmetaevolutionPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_path_fill(s : OptmetaevolutionPath, v : Double) -> OptmetaevolutionPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_path_min(s : OptmetaevolutionPath) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_path_max(s : OptmetaevolutionPath) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_path_to_string(s : OptmetaevolutionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_cluster_make(size : Int) -> OptmetaevolutionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_cluster_len(s : OptmetaevolutionCluster) -> Int { s.size }

pub fn opt_meta_evolution_cluster_get(s : OptmetaevolutionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_cluster_set(s : OptmetaevolutionCluster, i : Int, v : Double) -> OptmetaevolutionCluster {
  let result = opt_meta_evolution_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_cluster_sum(s : OptmetaevolutionCluster) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_cluster_mean(s : OptmetaevolutionCluster) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_cluster_scale(s : OptmetaevolutionCluster, f : Double) -> OptmetaevolutionCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_cluster_add(a : OptmetaevolutionCluster, b : OptmetaevolutionCluster) -> OptmetaevolutionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_cluster_copy(s : OptmetaevolutionCluster) -> OptmetaevolutionCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_cluster_fill(s : OptmetaevolutionCluster, v : Double) -> OptmetaevolutionCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_cluster_min(s : OptmetaevolutionCluster) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_cluster_max(s : OptmetaevolutionCluster) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_cluster_to_string(s : OptmetaevolutionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_model_make(size : Int) -> OptmetaevolutionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_model_len(s : OptmetaevolutionModel) -> Int { s.size }

pub fn opt_meta_evolution_model_get(s : OptmetaevolutionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_model_set(s : OptmetaevolutionModel, i : Int, v : Double) -> OptmetaevolutionModel {
  let result = opt_meta_evolution_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_model_sum(s : OptmetaevolutionModel) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_model_mean(s : OptmetaevolutionModel) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_model_scale(s : OptmetaevolutionModel, f : Double) -> OptmetaevolutionModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_model_add(a : OptmetaevolutionModel, b : OptmetaevolutionModel) -> OptmetaevolutionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_model_copy(s : OptmetaevolutionModel) -> OptmetaevolutionModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_model_fill(s : OptmetaevolutionModel, v : Double) -> OptmetaevolutionModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_model_min(s : OptmetaevolutionModel) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_model_max(s : OptmetaevolutionModel) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_model_to_string(s : OptmetaevolutionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_layer_make(size : Int) -> OptmetaevolutionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_layer_len(s : OptmetaevolutionLayer) -> Int { s.size }

pub fn opt_meta_evolution_layer_get(s : OptmetaevolutionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_layer_set(s : OptmetaevolutionLayer, i : Int, v : Double) -> OptmetaevolutionLayer {
  let result = opt_meta_evolution_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_layer_sum(s : OptmetaevolutionLayer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_layer_mean(s : OptmetaevolutionLayer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_layer_scale(s : OptmetaevolutionLayer, f : Double) -> OptmetaevolutionLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_layer_add(a : OptmetaevolutionLayer, b : OptmetaevolutionLayer) -> OptmetaevolutionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_layer_copy(s : OptmetaevolutionLayer) -> OptmetaevolutionLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_layer_fill(s : OptmetaevolutionLayer, v : Double) -> OptmetaevolutionLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_layer_min(s : OptmetaevolutionLayer) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_layer_max(s : OptmetaevolutionLayer) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_layer_to_string(s : OptmetaevolutionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_buffer_make(size : Int) -> OptmetaevolutionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_buffer_len(s : OptmetaevolutionBuffer) -> Int { s.size }

pub fn opt_meta_evolution_buffer_get(s : OptmetaevolutionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_buffer_set(s : OptmetaevolutionBuffer, i : Int, v : Double) -> OptmetaevolutionBuffer {
  let result = opt_meta_evolution_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_buffer_sum(s : OptmetaevolutionBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_buffer_mean(s : OptmetaevolutionBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_buffer_scale(s : OptmetaevolutionBuffer, f : Double) -> OptmetaevolutionBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_buffer_add(a : OptmetaevolutionBuffer, b : OptmetaevolutionBuffer) -> OptmetaevolutionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_buffer_copy(s : OptmetaevolutionBuffer) -> OptmetaevolutionBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_buffer_fill(s : OptmetaevolutionBuffer, v : Double) -> OptmetaevolutionBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_buffer_min(s : OptmetaevolutionBuffer) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_buffer_max(s : OptmetaevolutionBuffer) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_buffer_to_string(s : OptmetaevolutionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_cursor_make(size : Int) -> OptmetaevolutionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_cursor_len(s : OptmetaevolutionCursor) -> Int { s.size }

pub fn opt_meta_evolution_cursor_get(s : OptmetaevolutionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_cursor_set(s : OptmetaevolutionCursor, i : Int, v : Double) -> OptmetaevolutionCursor {
  let result = opt_meta_evolution_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_cursor_sum(s : OptmetaevolutionCursor) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_cursor_mean(s : OptmetaevolutionCursor) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_cursor_scale(s : OptmetaevolutionCursor, f : Double) -> OptmetaevolutionCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_cursor_add(a : OptmetaevolutionCursor, b : OptmetaevolutionCursor) -> OptmetaevolutionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_cursor_copy(s : OptmetaevolutionCursor) -> OptmetaevolutionCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_cursor_fill(s : OptmetaevolutionCursor, v : Double) -> OptmetaevolutionCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_cursor_min(s : OptmetaevolutionCursor) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_cursor_max(s : OptmetaevolutionCursor) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_cursor_to_string(s : OptmetaevolutionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_view_make(size : Int) -> OptmetaevolutionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_view_len(s : OptmetaevolutionView) -> Int { s.size }

pub fn opt_meta_evolution_view_get(s : OptmetaevolutionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_view_set(s : OptmetaevolutionView, i : Int, v : Double) -> OptmetaevolutionView {
  let result = opt_meta_evolution_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_view_sum(s : OptmetaevolutionView) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_view_mean(s : OptmetaevolutionView) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_view_scale(s : OptmetaevolutionView, f : Double) -> OptmetaevolutionView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_view_add(a : OptmetaevolutionView, b : OptmetaevolutionView) -> OptmetaevolutionView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_view_copy(s : OptmetaevolutionView) -> OptmetaevolutionView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_view_fill(s : OptmetaevolutionView, v : Double) -> OptmetaevolutionView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_view_min(s : OptmetaevolutionView) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_view_max(s : OptmetaevolutionView) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_view_to_string(s : OptmetaevolutionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_range_make(size : Int) -> OptmetaevolutionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_range_len(s : OptmetaevolutionRange) -> Int { s.size }

pub fn opt_meta_evolution_range_get(s : OptmetaevolutionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_range_set(s : OptmetaevolutionRange, i : Int, v : Double) -> OptmetaevolutionRange {
  let result = opt_meta_evolution_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_range_sum(s : OptmetaevolutionRange) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_range_mean(s : OptmetaevolutionRange) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_range_scale(s : OptmetaevolutionRange, f : Double) -> OptmetaevolutionRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_range_add(a : OptmetaevolutionRange, b : OptmetaevolutionRange) -> OptmetaevolutionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_range_copy(s : OptmetaevolutionRange) -> OptmetaevolutionRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_range_fill(s : OptmetaevolutionRange, v : Double) -> OptmetaevolutionRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_range_min(s : OptmetaevolutionRange) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_range_max(s : OptmetaevolutionRange) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_range_to_string(s : OptmetaevolutionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_slice_make(size : Int) -> OptmetaevolutionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_slice_len(s : OptmetaevolutionSlice) -> Int { s.size }

pub fn opt_meta_evolution_slice_get(s : OptmetaevolutionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_slice_set(s : OptmetaevolutionSlice, i : Int, v : Double) -> OptmetaevolutionSlice {
  let result = opt_meta_evolution_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_slice_sum(s : OptmetaevolutionSlice) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_slice_mean(s : OptmetaevolutionSlice) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_slice_scale(s : OptmetaevolutionSlice, f : Double) -> OptmetaevolutionSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_slice_add(a : OptmetaevolutionSlice, b : OptmetaevolutionSlice) -> OptmetaevolutionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_slice_copy(s : OptmetaevolutionSlice) -> OptmetaevolutionSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_slice_fill(s : OptmetaevolutionSlice, v : Double) -> OptmetaevolutionSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_slice_min(s : OptmetaevolutionSlice) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_slice_max(s : OptmetaevolutionSlice) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_slice_to_string(s : OptmetaevolutionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

