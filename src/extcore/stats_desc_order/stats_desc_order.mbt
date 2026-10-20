///===
/// extcore/stats_desc_order

pub(all) struct StatsdescorderPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_desc_order_make_point(x : Double, y : Double) -> StatsdescorderPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_desc_order_make_point3(x : Double, y : Double, z : Double) -> StatsdescorderPoint {
  { x, y, z, label: 0 }
}

pub fn stats_desc_order_point_x(pt : StatsdescorderPoint) -> Double { pt.x }

pub fn stats_desc_order_point_y(pt : StatsdescorderPoint) -> Double { pt.y }

pub fn stats_desc_order_point_z(pt : StatsdescorderPoint) -> Double { pt.z }

pub fn stats_desc_order_point_label(pt : StatsdescorderPoint) -> Int { pt.label }

pub fn stats_desc_order_point_dist(a : StatsdescorderPoint, b : StatsdescorderPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_desc_order_point_add(a : StatsdescorderPoint, b : StatsdescorderPoint) -> StatsdescorderPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_desc_order_point_sub(a : StatsdescorderPoint, b : StatsdescorderPoint) -> StatsdescorderPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_desc_order_point_scale(pt : StatsdescorderPoint, s : Double) -> StatsdescorderPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_desc_order_point_dot(a : StatsdescorderPoint, b : StatsdescorderPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_desc_order_point_cross(a : StatsdescorderPoint, b : StatsdescorderPoint) -> StatsdescorderPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_desc_order_point_norm(pt : StatsdescorderPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_desc_order_point_normalize(pt : StatsdescorderPoint) -> StatsdescorderPoint {
  let n = stats_desc_order_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_desc_order_point_scale(pt, 1.0 / n) }
}

pub fn stats_desc_order_point_negate(pt : StatsdescorderPoint) -> StatsdescorderPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_desc_order_point_mid(a : StatsdescorderPoint, b : StatsdescorderPoint) -> StatsdescorderPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_desc_order_point_lerp(a : StatsdescorderPoint, b : StatsdescorderPoint, t : Double) -> StatsdescorderPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_desc_order_point_to_string(pt : StatsdescorderPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdescorderSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_desc_order_make_series(vals : Array[Double], name : String) -> StatsdescorderSeries {
  { vals, name, meta: 0 }
}

pub fn stats_desc_order_series_len(s : StatsdescorderSeries) -> Int { s.vals.length() }

pub fn stats_desc_order_series_sum(s : StatsdescorderSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_desc_order_series_mean(s : StatsdescorderSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_desc_order_series_min(s : StatsdescorderSeries) -> Double { @_common.min(s.vals) }

pub fn stats_desc_order_series_max(s : StatsdescorderSeries) -> Double { @_common.max(s.vals) }

pub fn stats_desc_order_series_range(s : StatsdescorderSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_desc_order_series_var(s : StatsdescorderSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_desc_order_series_std(s : StatsdescorderSeries) -> Double { @_common.std(s.vals) }

pub fn stats_desc_order_series_median(s : StatsdescorderSeries) -> Double { @_common.median(s.vals) }

pub fn stats_desc_order_series_scale(s : StatsdescorderSeries, f : Double) -> StatsdescorderSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_desc_order_series_add(a : StatsdescorderSeries, b : StatsdescorderSeries) -> StatsdescorderSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_desc_order_series_sub(a : StatsdescorderSeries, b : StatsdescorderSeries) -> StatsdescorderSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_desc_order_series_normalize(s : StatsdescorderSeries) -> StatsdescorderSeries {
  let mn = stats_desc_order_series_min(s)
  let mx = stats_desc_order_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_desc_order_series_cumsum(s : StatsdescorderSeries) -> StatsdescorderSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_desc_order_series_to_string(s : StatsdescorderSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdescorderMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_desc_order_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdescorderMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_desc_order_matrix_identity(n : Int) -> StatsdescorderMatrix {
  let m = stats_desc_order_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_desc_order_matrix_get(m : StatsdescorderMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_desc_order_matrix_transpose(m : StatsdescorderMatrix) -> StatsdescorderMatrix {
  let result = stats_desc_order_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_desc_order_matrix_add(a : StatsdescorderMatrix, b : StatsdescorderMatrix) -> StatsdescorderMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_desc_order_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_desc_order_matrix_scale(m : StatsdescorderMatrix, s : Double) -> StatsdescorderMatrix {
  let result = stats_desc_order_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_desc_order_matrix_multiply(a : StatsdescorderMatrix, b : StatsdescorderMatrix) -> StatsdescorderMatrix {
  if a.cols != b.rows { return stats_desc_order_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_desc_order_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_desc_order_matrix_trace(m : StatsdescorderMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_desc_order_matrix_det(m : StatsdescorderMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_desc_order_matrix_norm(m : StatsdescorderMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_desc_order_matrix_to_string(m : StatsdescorderMatrix) -> String {
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

pub(all) struct StatsdescorderVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_desc_order_make_vector(comps : Array[Double]) -> StatsdescorderVector {
  { comps, dim: comps.length() }
}

pub fn stats_desc_order_vector_zero(dim : Int) -> StatsdescorderVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_desc_order_vector_add(a : StatsdescorderVector, b : StatsdescorderVector) -> StatsdescorderVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_desc_order_vector_sub(a : StatsdescorderVector, b : StatsdescorderVector) -> StatsdescorderVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_desc_order_vector_scale(v : StatsdescorderVector, s : Double) -> StatsdescorderVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_desc_order_vector_dot(a : StatsdescorderVector, b : StatsdescorderVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_desc_order_vector_norm(v : StatsdescorderVector) -> Double { @_common.sqrt(stats_desc_order_vector_dot(v, v)) }

pub fn stats_desc_order_vector_normalize(v : StatsdescorderVector) -> StatsdescorderVector {
  let n = stats_desc_order_vector_norm(v)
  if n < 0.0000001 { v } else { stats_desc_order_vector_scale(v, 1.0 / n) }
}

pub fn stats_desc_order_vector_dist(a : StatsdescorderVector, b : StatsdescorderVector) -> Double {
  stats_desc_order_vector_norm(stats_desc_order_vector_sub(a, b))
}

pub fn stats_desc_order_vector_to_string(v : StatsdescorderVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_desc_order_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_desc_order_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_desc_order_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_desc_order_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_desc_order_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_desc_order_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_desc_order_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_desc_order_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_desc_order_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_desc_order_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_desc_order_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_desc_order_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_desc_order_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_desc_order_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_desc_order_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_desc_order_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_desc_order_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_desc_order_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_desc_order_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_desc_order_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_desc_order_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_desc_order_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_desc_order_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_desc_order_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_desc_order_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_desc_order_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_desc_order_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_desc_order_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_desc_order_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdescorderFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_frame_make(size : Int) -> StatsdescorderFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_frame_len(s : StatsdescorderFrame) -> Int { s.size }

pub fn stats_desc_order_frame_get(s : StatsdescorderFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_frame_set(s : StatsdescorderFrame, i : Int, v : Double) -> StatsdescorderFrame {
  let result = stats_desc_order_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_frame_sum(s : StatsdescorderFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_order_frame_mean(s : StatsdescorderFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_order_frame_sum(s) / s.size.to_double() }
}

pub fn stats_desc_order_frame_scale(s : StatsdescorderFrame, f : Double) -> StatsdescorderFrame {
  let result = stats_desc_order_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_order_frame_add(a : StatsdescorderFrame, b : StatsdescorderFrame) -> StatsdescorderFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_order_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_order_frame_copy(s : StatsdescorderFrame) -> StatsdescorderFrame {
  let result = stats_desc_order_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_order_frame_fill(s : StatsdescorderFrame, v : Double) -> StatsdescorderFrame {
  let result = stats_desc_order_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_frame_min(s : StatsdescorderFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_frame_max(s : StatsdescorderFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_frame_to_string(s : StatsdescorderFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_table_make(size : Int) -> StatsdescorderTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_table_len(s : StatsdescorderTable) -> Int { s.size }

pub fn stats_desc_order_table_get(s : StatsdescorderTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_table_set(s : StatsdescorderTable, i : Int, v : Double) -> StatsdescorderTable {
  let result = stats_desc_order_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_table_sum(s : StatsdescorderTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_order_table_mean(s : StatsdescorderTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_order_table_sum(s) / s.size.to_double() }
}

pub fn stats_desc_order_table_scale(s : StatsdescorderTable, f : Double) -> StatsdescorderTable {
  let result = stats_desc_order_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_order_table_add(a : StatsdescorderTable, b : StatsdescorderTable) -> StatsdescorderTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_order_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_order_table_copy(s : StatsdescorderTable) -> StatsdescorderTable {
  let result = stats_desc_order_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_order_table_fill(s : StatsdescorderTable, v : Double) -> StatsdescorderTable {
  let result = stats_desc_order_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_table_min(s : StatsdescorderTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_table_max(s : StatsdescorderTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_table_to_string(s : StatsdescorderTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_graphn_make(size : Int) -> StatsdescorderGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_graphn_len(s : StatsdescorderGraphN) -> Int { s.size }

pub fn stats_desc_order_graphn_get(s : StatsdescorderGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_graphn_set(s : StatsdescorderGraphN, i : Int, v : Double) -> StatsdescorderGraphN {
  let result = stats_desc_order_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_graphn_sum(s : StatsdescorderGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_order_graphn_mean(s : StatsdescorderGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_order_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_desc_order_graphn_scale(s : StatsdescorderGraphN, f : Double) -> StatsdescorderGraphN {
  let result = stats_desc_order_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_order_graphn_add(a : StatsdescorderGraphN, b : StatsdescorderGraphN) -> StatsdescorderGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_order_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_order_graphn_copy(s : StatsdescorderGraphN) -> StatsdescorderGraphN {
  let result = stats_desc_order_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_order_graphn_fill(s : StatsdescorderGraphN, v : Double) -> StatsdescorderGraphN {
  let result = stats_desc_order_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_graphn_min(s : StatsdescorderGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_graphn_max(s : StatsdescorderGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_graphn_to_string(s : StatsdescorderGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_node_make(size : Int) -> StatsdescorderNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_node_len(s : StatsdescorderNode) -> Int { s.size }

pub fn stats_desc_order_node_get(s : StatsdescorderNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_node_set(s : StatsdescorderNode, i : Int, v : Double) -> StatsdescorderNode {
  let result = stats_desc_order_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_node_sum(s : StatsdescorderNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_order_node_mean(s : StatsdescorderNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_order_node_sum(s) / s.size.to_double() }
}

pub fn stats_desc_order_node_scale(s : StatsdescorderNode, f : Double) -> StatsdescorderNode {
  let result = stats_desc_order_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_order_node_add(a : StatsdescorderNode, b : StatsdescorderNode) -> StatsdescorderNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_order_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_order_node_copy(s : StatsdescorderNode) -> StatsdescorderNode {
  let result = stats_desc_order_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_order_node_fill(s : StatsdescorderNode, v : Double) -> StatsdescorderNode {
  let result = stats_desc_order_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_node_min(s : StatsdescorderNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_node_max(s : StatsdescorderNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_node_to_string(s : StatsdescorderNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_edge_make(size : Int) -> StatsdescorderEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_edge_len(s : StatsdescorderEdge) -> Int { s.size }

pub fn stats_desc_order_edge_get(s : StatsdescorderEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_edge_set(s : StatsdescorderEdge, i : Int, v : Double) -> StatsdescorderEdge {
  let result = stats_desc_order_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_edge_sum(s : StatsdescorderEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_order_edge_mean(s : StatsdescorderEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_order_edge_sum(s) / s.size.to_double() }
}

pub fn stats_desc_order_edge_scale(s : StatsdescorderEdge, f : Double) -> StatsdescorderEdge {
  let result = stats_desc_order_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_order_edge_add(a : StatsdescorderEdge, b : StatsdescorderEdge) -> StatsdescorderEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_order_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_order_edge_copy(s : StatsdescorderEdge) -> StatsdescorderEdge {
  let result = stats_desc_order_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_order_edge_fill(s : StatsdescorderEdge, v : Double) -> StatsdescorderEdge {
  let result = stats_desc_order_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_edge_min(s : StatsdescorderEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_edge_max(s : StatsdescorderEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_edge_to_string(s : StatsdescorderEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_path_make(size : Int) -> StatsdescorderPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_path_len(s : StatsdescorderPath) -> Int { s.size }

pub fn stats_desc_order_path_get(s : StatsdescorderPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_path_set(s : StatsdescorderPath, i : Int, v : Double) -> StatsdescorderPath {
  let result = stats_desc_order_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_path_sum(s : StatsdescorderPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_order_path_mean(s : StatsdescorderPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_order_path_sum(s) / s.size.to_double() }
}

pub fn stats_desc_order_path_scale(s : StatsdescorderPath, f : Double) -> StatsdescorderPath {
  let result = stats_desc_order_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_order_path_add(a : StatsdescorderPath, b : StatsdescorderPath) -> StatsdescorderPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_order_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_order_path_copy(s : StatsdescorderPath) -> StatsdescorderPath {
  let result = stats_desc_order_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_order_path_fill(s : StatsdescorderPath, v : Double) -> StatsdescorderPath {
  let result = stats_desc_order_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_path_min(s : StatsdescorderPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_path_max(s : StatsdescorderPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_path_to_string(s : StatsdescorderPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_cluster_make(size : Int) -> StatsdescorderCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_cluster_len(s : StatsdescorderCluster) -> Int { s.size }

pub fn stats_desc_order_cluster_get(s : StatsdescorderCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_cluster_set(s : StatsdescorderCluster, i : Int, v : Double) -> StatsdescorderCluster {
  let result = stats_desc_order_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_cluster_sum(s : StatsdescorderCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_order_cluster_mean(s : StatsdescorderCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_order_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_desc_order_cluster_scale(s : StatsdescorderCluster, f : Double) -> StatsdescorderCluster {
  let result = stats_desc_order_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_order_cluster_add(a : StatsdescorderCluster, b : StatsdescorderCluster) -> StatsdescorderCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_order_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_order_cluster_copy(s : StatsdescorderCluster) -> StatsdescorderCluster {
  let result = stats_desc_order_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_order_cluster_fill(s : StatsdescorderCluster, v : Double) -> StatsdescorderCluster {
  let result = stats_desc_order_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_cluster_min(s : StatsdescorderCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_cluster_max(s : StatsdescorderCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_cluster_to_string(s : StatsdescorderCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_model_make(size : Int) -> StatsdescorderModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_model_len(s : StatsdescorderModel) -> Int { s.size }

pub fn stats_desc_order_model_get(s : StatsdescorderModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_model_set(s : StatsdescorderModel, i : Int, v : Double) -> StatsdescorderModel {
  let result = stats_desc_order_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_model_sum(s : StatsdescorderModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_order_model_mean(s : StatsdescorderModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_order_model_sum(s) / s.size.to_double() }
}

pub fn stats_desc_order_model_scale(s : StatsdescorderModel, f : Double) -> StatsdescorderModel {
  let result = stats_desc_order_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_order_model_add(a : StatsdescorderModel, b : StatsdescorderModel) -> StatsdescorderModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_order_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_order_model_copy(s : StatsdescorderModel) -> StatsdescorderModel {
  let result = stats_desc_order_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_order_model_fill(s : StatsdescorderModel, v : Double) -> StatsdescorderModel {
  let result = stats_desc_order_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_model_min(s : StatsdescorderModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_model_max(s : StatsdescorderModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_model_to_string(s : StatsdescorderModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_layer_make(size : Int) -> StatsdescorderLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_layer_len(s : StatsdescorderLayer) -> Int { s.size }

pub fn stats_desc_order_layer_get(s : StatsdescorderLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_layer_set(s : StatsdescorderLayer, i : Int, v : Double) -> StatsdescorderLayer {
  let result = stats_desc_order_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_layer_sum(s : StatsdescorderLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_order_layer_mean(s : StatsdescorderLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_order_layer_sum(s) / s.size.to_double() }
}

pub fn stats_desc_order_layer_scale(s : StatsdescorderLayer, f : Double) -> StatsdescorderLayer {
  let result = stats_desc_order_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_order_layer_add(a : StatsdescorderLayer, b : StatsdescorderLayer) -> StatsdescorderLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_order_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_order_layer_copy(s : StatsdescorderLayer) -> StatsdescorderLayer {
  let result = stats_desc_order_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_order_layer_fill(s : StatsdescorderLayer, v : Double) -> StatsdescorderLayer {
  let result = stats_desc_order_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_layer_min(s : StatsdescorderLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_layer_max(s : StatsdescorderLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_layer_to_string(s : StatsdescorderLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_buffer_make(size : Int) -> StatsdescorderBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_buffer_len(s : StatsdescorderBuffer) -> Int { s.size }

pub fn stats_desc_order_buffer_get(s : StatsdescorderBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_buffer_set(s : StatsdescorderBuffer, i : Int, v : Double) -> StatsdescorderBuffer {
  let result = stats_desc_order_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_buffer_sum(s : StatsdescorderBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_order_buffer_mean(s : StatsdescorderBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_order_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_desc_order_buffer_scale(s : StatsdescorderBuffer, f : Double) -> StatsdescorderBuffer {
  let result = stats_desc_order_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_order_buffer_add(a : StatsdescorderBuffer, b : StatsdescorderBuffer) -> StatsdescorderBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_order_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_order_buffer_copy(s : StatsdescorderBuffer) -> StatsdescorderBuffer {
  let result = stats_desc_order_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_order_buffer_fill(s : StatsdescorderBuffer, v : Double) -> StatsdescorderBuffer {
  let result = stats_desc_order_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_buffer_min(s : StatsdescorderBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_buffer_max(s : StatsdescorderBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_buffer_to_string(s : StatsdescorderBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_cursor_make(size : Int) -> StatsdescorderCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_cursor_len(s : StatsdescorderCursor) -> Int { s.size }

pub fn stats_desc_order_cursor_get(s : StatsdescorderCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_cursor_set(s : StatsdescorderCursor, i : Int, v : Double) -> StatsdescorderCursor {
  let result = stats_desc_order_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_cursor_sum(s : StatsdescorderCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_order_cursor_mean(s : StatsdescorderCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_order_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_desc_order_cursor_scale(s : StatsdescorderCursor, f : Double) -> StatsdescorderCursor {
  let result = stats_desc_order_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_order_cursor_add(a : StatsdescorderCursor, b : StatsdescorderCursor) -> StatsdescorderCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_order_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_order_cursor_copy(s : StatsdescorderCursor) -> StatsdescorderCursor {
  let result = stats_desc_order_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_order_cursor_fill(s : StatsdescorderCursor, v : Double) -> StatsdescorderCursor {
  let result = stats_desc_order_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_cursor_min(s : StatsdescorderCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_cursor_max(s : StatsdescorderCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_cursor_to_string(s : StatsdescorderCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_view_make(size : Int) -> StatsdescorderView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_view_len(s : StatsdescorderView) -> Int { s.size }

pub fn stats_desc_order_view_get(s : StatsdescorderView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_view_set(s : StatsdescorderView, i : Int, v : Double) -> StatsdescorderView {
  let result = stats_desc_order_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_view_sum(s : StatsdescorderView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_order_view_mean(s : StatsdescorderView) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_order_view_sum(s) / s.size.to_double() }
}

pub fn stats_desc_order_view_scale(s : StatsdescorderView, f : Double) -> StatsdescorderView {
  let result = stats_desc_order_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_order_view_add(a : StatsdescorderView, b : StatsdescorderView) -> StatsdescorderView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_order_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_order_view_copy(s : StatsdescorderView) -> StatsdescorderView {
  let result = stats_desc_order_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_order_view_fill(s : StatsdescorderView, v : Double) -> StatsdescorderView {
  let result = stats_desc_order_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_view_min(s : StatsdescorderView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_view_max(s : StatsdescorderView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_view_to_string(s : StatsdescorderView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_range_make(size : Int) -> StatsdescorderRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_range_len(s : StatsdescorderRange) -> Int { s.size }

pub fn stats_desc_order_range_get(s : StatsdescorderRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_range_set(s : StatsdescorderRange, i : Int, v : Double) -> StatsdescorderRange {
  let result = stats_desc_order_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_range_sum(s : StatsdescorderRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_order_range_mean(s : StatsdescorderRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_order_range_sum(s) / s.size.to_double() }
}

pub fn stats_desc_order_range_scale(s : StatsdescorderRange, f : Double) -> StatsdescorderRange {
  let result = stats_desc_order_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_order_range_add(a : StatsdescorderRange, b : StatsdescorderRange) -> StatsdescorderRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_order_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_order_range_copy(s : StatsdescorderRange) -> StatsdescorderRange {
  let result = stats_desc_order_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_order_range_fill(s : StatsdescorderRange, v : Double) -> StatsdescorderRange {
  let result = stats_desc_order_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_range_min(s : StatsdescorderRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_range_max(s : StatsdescorderRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_range_to_string(s : StatsdescorderRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_slice_make(size : Int) -> StatsdescorderSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_slice_len(s : StatsdescorderSlice) -> Int { s.size }

pub fn stats_desc_order_slice_get(s : StatsdescorderSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_slice_set(s : StatsdescorderSlice, i : Int, v : Double) -> StatsdescorderSlice {
  let result = stats_desc_order_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_slice_sum(s : StatsdescorderSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_order_slice_mean(s : StatsdescorderSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_order_slice_sum(s) / s.size.to_double() }
}

pub fn stats_desc_order_slice_scale(s : StatsdescorderSlice, f : Double) -> StatsdescorderSlice {
  let result = stats_desc_order_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_order_slice_add(a : StatsdescorderSlice, b : StatsdescorderSlice) -> StatsdescorderSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_order_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_order_slice_copy(s : StatsdescorderSlice) -> StatsdescorderSlice {
  let result = stats_desc_order_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_order_slice_fill(s : StatsdescorderSlice, v : Double) -> StatsdescorderSlice {
  let result = stats_desc_order_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_order_slice_min(s : StatsdescorderSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_slice_max(s : StatsdescorderSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_order_slice_to_string(s : StatsdescorderSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

