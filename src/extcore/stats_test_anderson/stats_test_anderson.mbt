///===
/// extcore/stats_test_anderson

pub(all) struct StatstestandersonPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_anderson_make_point(x : Double, y : Double) -> StatstestandersonPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_anderson_make_point3(x : Double, y : Double, z : Double) -> StatstestandersonPoint {
  { x, y, z, label: 0 }
}

pub fn stats_test_anderson_point_x(pt : StatstestandersonPoint) -> Double { pt.x }

pub fn stats_test_anderson_point_y(pt : StatstestandersonPoint) -> Double { pt.y }

pub fn stats_test_anderson_point_z(pt : StatstestandersonPoint) -> Double { pt.z }

pub fn stats_test_anderson_point_label(pt : StatstestandersonPoint) -> Int { pt.label }

pub fn stats_test_anderson_point_dist(a : StatstestandersonPoint, b : StatstestandersonPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_test_anderson_point_add(a : StatstestandersonPoint, b : StatstestandersonPoint) -> StatstestandersonPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_test_anderson_point_sub(a : StatstestandersonPoint, b : StatstestandersonPoint) -> StatstestandersonPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_test_anderson_point_scale(pt : StatstestandersonPoint, s : Double) -> StatstestandersonPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_test_anderson_point_dot(a : StatstestandersonPoint, b : StatstestandersonPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_test_anderson_point_cross(a : StatstestandersonPoint, b : StatstestandersonPoint) -> StatstestandersonPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_test_anderson_point_norm(pt : StatstestandersonPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_test_anderson_point_normalize(pt : StatstestandersonPoint) -> StatstestandersonPoint {
  let n = stats_test_anderson_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_test_anderson_point_scale(pt, 1.0 / n) }
}

pub fn stats_test_anderson_point_negate(pt : StatstestandersonPoint) -> StatstestandersonPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_test_anderson_point_mid(a : StatstestandersonPoint, b : StatstestandersonPoint) -> StatstestandersonPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_test_anderson_point_lerp(a : StatstestandersonPoint, b : StatstestandersonPoint, t : Double) -> StatstestandersonPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_test_anderson_point_to_string(pt : StatstestandersonPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatstestandersonSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_anderson_make_series(vals : Array[Double], name : String) -> StatstestandersonSeries {
  { vals, name, meta: 0 }
}

pub fn stats_test_anderson_series_len(s : StatstestandersonSeries) -> Int { s.vals.length() }

pub fn stats_test_anderson_series_sum(s : StatstestandersonSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_test_anderson_series_mean(s : StatstestandersonSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_test_anderson_series_min(s : StatstestandersonSeries) -> Double { @_common.min(s.vals) }

pub fn stats_test_anderson_series_max(s : StatstestandersonSeries) -> Double { @_common.max(s.vals) }

pub fn stats_test_anderson_series_range(s : StatstestandersonSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_test_anderson_series_var(s : StatstestandersonSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_test_anderson_series_std(s : StatstestandersonSeries) -> Double { @_common.std(s.vals) }

pub fn stats_test_anderson_series_median(s : StatstestandersonSeries) -> Double { @_common.median(s.vals) }

pub fn stats_test_anderson_series_scale(s : StatstestandersonSeries, f : Double) -> StatstestandersonSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_test_anderson_series_add(a : StatstestandersonSeries, b : StatstestandersonSeries) -> StatstestandersonSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_test_anderson_series_sub(a : StatstestandersonSeries, b : StatstestandersonSeries) -> StatstestandersonSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_test_anderson_series_normalize(s : StatstestandersonSeries) -> StatstestandersonSeries {
  let mn = stats_test_anderson_series_min(s)
  let mx = stats_test_anderson_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_test_anderson_series_cumsum(s : StatstestandersonSeries) -> StatstestandersonSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_test_anderson_series_to_string(s : StatstestandersonSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestandersonMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_anderson_make_matrix(rows : Int, cols : Int, val : Double) -> StatstestandersonMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_anderson_matrix_identity(n : Int) -> StatstestandersonMatrix {
  let m = stats_test_anderson_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_test_anderson_matrix_get(m : StatstestandersonMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_test_anderson_matrix_transpose(m : StatstestandersonMatrix) -> StatstestandersonMatrix {
  let result = stats_test_anderson_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_test_anderson_matrix_add(a : StatstestandersonMatrix, b : StatstestandersonMatrix) -> StatstestandersonMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_test_anderson_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_test_anderson_matrix_scale(m : StatstestandersonMatrix, s : Double) -> StatstestandersonMatrix {
  let result = stats_test_anderson_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_test_anderson_matrix_multiply(a : StatstestandersonMatrix, b : StatstestandersonMatrix) -> StatstestandersonMatrix {
  if a.cols != b.rows { return stats_test_anderson_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_test_anderson_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_test_anderson_matrix_trace(m : StatstestandersonMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_test_anderson_matrix_det(m : StatstestandersonMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_test_anderson_matrix_norm(m : StatstestandersonMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_test_anderson_matrix_to_string(m : StatstestandersonMatrix) -> String {
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

pub(all) struct StatstestandersonVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_anderson_make_vector(comps : Array[Double]) -> StatstestandersonVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_anderson_vector_zero(dim : Int) -> StatstestandersonVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_test_anderson_vector_add(a : StatstestandersonVector, b : StatstestandersonVector) -> StatstestandersonVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_test_anderson_vector_sub(a : StatstestandersonVector, b : StatstestandersonVector) -> StatstestandersonVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_test_anderson_vector_scale(v : StatstestandersonVector, s : Double) -> StatstestandersonVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_test_anderson_vector_dot(a : StatstestandersonVector, b : StatstestandersonVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_test_anderson_vector_norm(v : StatstestandersonVector) -> Double { @_common.sqrt(stats_test_anderson_vector_dot(v, v)) }

pub fn stats_test_anderson_vector_normalize(v : StatstestandersonVector) -> StatstestandersonVector {
  let n = stats_test_anderson_vector_norm(v)
  if n < 0.0000001 { v } else { stats_test_anderson_vector_scale(v, 1.0 / n) }
}

pub fn stats_test_anderson_vector_dist(a : StatstestandersonVector, b : StatstestandersonVector) -> Double {
  stats_test_anderson_vector_norm(stats_test_anderson_vector_sub(a, b))
}

pub fn stats_test_anderson_vector_to_string(v : StatstestandersonVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_test_anderson_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_test_anderson_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_test_anderson_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_test_anderson_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_test_anderson_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_test_anderson_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_test_anderson_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_test_anderson_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_test_anderson_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_test_anderson_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_test_anderson_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_test_anderson_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_test_anderson_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_test_anderson_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_test_anderson_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_test_anderson_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_test_anderson_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_test_anderson_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_test_anderson_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_test_anderson_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_test_anderson_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_test_anderson_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_test_anderson_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_test_anderson_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_test_anderson_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_test_anderson_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_test_anderson_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_test_anderson_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_test_anderson_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatstestandersonFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_frame_make(size : Int) -> StatstestandersonFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_anderson_frame_len(s : StatstestandersonFrame) -> Int { s.size }

pub fn stats_test_anderson_frame_get(s : StatstestandersonFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_anderson_frame_set(s : StatstestandersonFrame, i : Int, v : Double) -> StatstestandersonFrame {
  let result = stats_test_anderson_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_frame_sum(s : StatstestandersonFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_anderson_frame_mean(s : StatstestandersonFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_anderson_frame_sum(s) / s.size.to_double() }
}

pub fn stats_test_anderson_frame_scale(s : StatstestandersonFrame, f : Double) -> StatstestandersonFrame {
  let result = stats_test_anderson_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_anderson_frame_add(a : StatstestandersonFrame, b : StatstestandersonFrame) -> StatstestandersonFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_anderson_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_anderson_frame_copy(s : StatstestandersonFrame) -> StatstestandersonFrame {
  let result = stats_test_anderson_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_anderson_frame_fill(s : StatstestandersonFrame, v : Double) -> StatstestandersonFrame {
  let result = stats_test_anderson_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_frame_min(s : StatstestandersonFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_frame_max(s : StatstestandersonFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_frame_to_string(s : StatstestandersonFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestandersonTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_table_make(size : Int) -> StatstestandersonTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_anderson_table_len(s : StatstestandersonTable) -> Int { s.size }

pub fn stats_test_anderson_table_get(s : StatstestandersonTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_anderson_table_set(s : StatstestandersonTable, i : Int, v : Double) -> StatstestandersonTable {
  let result = stats_test_anderson_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_table_sum(s : StatstestandersonTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_anderson_table_mean(s : StatstestandersonTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_anderson_table_sum(s) / s.size.to_double() }
}

pub fn stats_test_anderson_table_scale(s : StatstestandersonTable, f : Double) -> StatstestandersonTable {
  let result = stats_test_anderson_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_anderson_table_add(a : StatstestandersonTable, b : StatstestandersonTable) -> StatstestandersonTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_anderson_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_anderson_table_copy(s : StatstestandersonTable) -> StatstestandersonTable {
  let result = stats_test_anderson_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_anderson_table_fill(s : StatstestandersonTable, v : Double) -> StatstestandersonTable {
  let result = stats_test_anderson_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_table_min(s : StatstestandersonTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_table_max(s : StatstestandersonTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_table_to_string(s : StatstestandersonTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestandersonGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_graphn_make(size : Int) -> StatstestandersonGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_anderson_graphn_len(s : StatstestandersonGraphN) -> Int { s.size }

pub fn stats_test_anderson_graphn_get(s : StatstestandersonGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_anderson_graphn_set(s : StatstestandersonGraphN, i : Int, v : Double) -> StatstestandersonGraphN {
  let result = stats_test_anderson_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_graphn_sum(s : StatstestandersonGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_anderson_graphn_mean(s : StatstestandersonGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_anderson_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_test_anderson_graphn_scale(s : StatstestandersonGraphN, f : Double) -> StatstestandersonGraphN {
  let result = stats_test_anderson_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_anderson_graphn_add(a : StatstestandersonGraphN, b : StatstestandersonGraphN) -> StatstestandersonGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_anderson_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_anderson_graphn_copy(s : StatstestandersonGraphN) -> StatstestandersonGraphN {
  let result = stats_test_anderson_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_anderson_graphn_fill(s : StatstestandersonGraphN, v : Double) -> StatstestandersonGraphN {
  let result = stats_test_anderson_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_graphn_min(s : StatstestandersonGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_graphn_max(s : StatstestandersonGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_graphn_to_string(s : StatstestandersonGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestandersonNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_node_make(size : Int) -> StatstestandersonNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_anderson_node_len(s : StatstestandersonNode) -> Int { s.size }

pub fn stats_test_anderson_node_get(s : StatstestandersonNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_anderson_node_set(s : StatstestandersonNode, i : Int, v : Double) -> StatstestandersonNode {
  let result = stats_test_anderson_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_node_sum(s : StatstestandersonNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_anderson_node_mean(s : StatstestandersonNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_anderson_node_sum(s) / s.size.to_double() }
}

pub fn stats_test_anderson_node_scale(s : StatstestandersonNode, f : Double) -> StatstestandersonNode {
  let result = stats_test_anderson_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_anderson_node_add(a : StatstestandersonNode, b : StatstestandersonNode) -> StatstestandersonNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_anderson_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_anderson_node_copy(s : StatstestandersonNode) -> StatstestandersonNode {
  let result = stats_test_anderson_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_anderson_node_fill(s : StatstestandersonNode, v : Double) -> StatstestandersonNode {
  let result = stats_test_anderson_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_node_min(s : StatstestandersonNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_node_max(s : StatstestandersonNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_node_to_string(s : StatstestandersonNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestandersonEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_edge_make(size : Int) -> StatstestandersonEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_anderson_edge_len(s : StatstestandersonEdge) -> Int { s.size }

pub fn stats_test_anderson_edge_get(s : StatstestandersonEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_anderson_edge_set(s : StatstestandersonEdge, i : Int, v : Double) -> StatstestandersonEdge {
  let result = stats_test_anderson_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_edge_sum(s : StatstestandersonEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_anderson_edge_mean(s : StatstestandersonEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_anderson_edge_sum(s) / s.size.to_double() }
}

pub fn stats_test_anderson_edge_scale(s : StatstestandersonEdge, f : Double) -> StatstestandersonEdge {
  let result = stats_test_anderson_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_anderson_edge_add(a : StatstestandersonEdge, b : StatstestandersonEdge) -> StatstestandersonEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_anderson_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_anderson_edge_copy(s : StatstestandersonEdge) -> StatstestandersonEdge {
  let result = stats_test_anderson_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_anderson_edge_fill(s : StatstestandersonEdge, v : Double) -> StatstestandersonEdge {
  let result = stats_test_anderson_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_edge_min(s : StatstestandersonEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_edge_max(s : StatstestandersonEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_edge_to_string(s : StatstestandersonEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestandersonPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_path_make(size : Int) -> StatstestandersonPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_anderson_path_len(s : StatstestandersonPath) -> Int { s.size }

pub fn stats_test_anderson_path_get(s : StatstestandersonPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_anderson_path_set(s : StatstestandersonPath, i : Int, v : Double) -> StatstestandersonPath {
  let result = stats_test_anderson_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_path_sum(s : StatstestandersonPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_anderson_path_mean(s : StatstestandersonPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_anderson_path_sum(s) / s.size.to_double() }
}

pub fn stats_test_anderson_path_scale(s : StatstestandersonPath, f : Double) -> StatstestandersonPath {
  let result = stats_test_anderson_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_anderson_path_add(a : StatstestandersonPath, b : StatstestandersonPath) -> StatstestandersonPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_anderson_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_anderson_path_copy(s : StatstestandersonPath) -> StatstestandersonPath {
  let result = stats_test_anderson_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_anderson_path_fill(s : StatstestandersonPath, v : Double) -> StatstestandersonPath {
  let result = stats_test_anderson_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_path_min(s : StatstestandersonPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_path_max(s : StatstestandersonPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_path_to_string(s : StatstestandersonPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestandersonCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_cluster_make(size : Int) -> StatstestandersonCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_anderson_cluster_len(s : StatstestandersonCluster) -> Int { s.size }

pub fn stats_test_anderson_cluster_get(s : StatstestandersonCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_anderson_cluster_set(s : StatstestandersonCluster, i : Int, v : Double) -> StatstestandersonCluster {
  let result = stats_test_anderson_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_cluster_sum(s : StatstestandersonCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_anderson_cluster_mean(s : StatstestandersonCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_anderson_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_test_anderson_cluster_scale(s : StatstestandersonCluster, f : Double) -> StatstestandersonCluster {
  let result = stats_test_anderson_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_anderson_cluster_add(a : StatstestandersonCluster, b : StatstestandersonCluster) -> StatstestandersonCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_anderson_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_anderson_cluster_copy(s : StatstestandersonCluster) -> StatstestandersonCluster {
  let result = stats_test_anderson_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_anderson_cluster_fill(s : StatstestandersonCluster, v : Double) -> StatstestandersonCluster {
  let result = stats_test_anderson_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_cluster_min(s : StatstestandersonCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_cluster_max(s : StatstestandersonCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_cluster_to_string(s : StatstestandersonCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestandersonModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_model_make(size : Int) -> StatstestandersonModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_anderson_model_len(s : StatstestandersonModel) -> Int { s.size }

pub fn stats_test_anderson_model_get(s : StatstestandersonModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_anderson_model_set(s : StatstestandersonModel, i : Int, v : Double) -> StatstestandersonModel {
  let result = stats_test_anderson_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_model_sum(s : StatstestandersonModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_anderson_model_mean(s : StatstestandersonModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_anderson_model_sum(s) / s.size.to_double() }
}

pub fn stats_test_anderson_model_scale(s : StatstestandersonModel, f : Double) -> StatstestandersonModel {
  let result = stats_test_anderson_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_anderson_model_add(a : StatstestandersonModel, b : StatstestandersonModel) -> StatstestandersonModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_anderson_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_anderson_model_copy(s : StatstestandersonModel) -> StatstestandersonModel {
  let result = stats_test_anderson_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_anderson_model_fill(s : StatstestandersonModel, v : Double) -> StatstestandersonModel {
  let result = stats_test_anderson_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_model_min(s : StatstestandersonModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_model_max(s : StatstestandersonModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_model_to_string(s : StatstestandersonModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestandersonLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_layer_make(size : Int) -> StatstestandersonLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_anderson_layer_len(s : StatstestandersonLayer) -> Int { s.size }

pub fn stats_test_anderson_layer_get(s : StatstestandersonLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_anderson_layer_set(s : StatstestandersonLayer, i : Int, v : Double) -> StatstestandersonLayer {
  let result = stats_test_anderson_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_layer_sum(s : StatstestandersonLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_anderson_layer_mean(s : StatstestandersonLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_anderson_layer_sum(s) / s.size.to_double() }
}

pub fn stats_test_anderson_layer_scale(s : StatstestandersonLayer, f : Double) -> StatstestandersonLayer {
  let result = stats_test_anderson_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_anderson_layer_add(a : StatstestandersonLayer, b : StatstestandersonLayer) -> StatstestandersonLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_anderson_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_anderson_layer_copy(s : StatstestandersonLayer) -> StatstestandersonLayer {
  let result = stats_test_anderson_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_anderson_layer_fill(s : StatstestandersonLayer, v : Double) -> StatstestandersonLayer {
  let result = stats_test_anderson_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_layer_min(s : StatstestandersonLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_layer_max(s : StatstestandersonLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_layer_to_string(s : StatstestandersonLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestandersonBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_buffer_make(size : Int) -> StatstestandersonBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_anderson_buffer_len(s : StatstestandersonBuffer) -> Int { s.size }

pub fn stats_test_anderson_buffer_get(s : StatstestandersonBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_anderson_buffer_set(s : StatstestandersonBuffer, i : Int, v : Double) -> StatstestandersonBuffer {
  let result = stats_test_anderson_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_buffer_sum(s : StatstestandersonBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_anderson_buffer_mean(s : StatstestandersonBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_anderson_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_test_anderson_buffer_scale(s : StatstestandersonBuffer, f : Double) -> StatstestandersonBuffer {
  let result = stats_test_anderson_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_anderson_buffer_add(a : StatstestandersonBuffer, b : StatstestandersonBuffer) -> StatstestandersonBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_anderson_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_anderson_buffer_copy(s : StatstestandersonBuffer) -> StatstestandersonBuffer {
  let result = stats_test_anderson_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_anderson_buffer_fill(s : StatstestandersonBuffer, v : Double) -> StatstestandersonBuffer {
  let result = stats_test_anderson_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_buffer_min(s : StatstestandersonBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_buffer_max(s : StatstestandersonBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_buffer_to_string(s : StatstestandersonBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestandersonCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_cursor_make(size : Int) -> StatstestandersonCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_anderson_cursor_len(s : StatstestandersonCursor) -> Int { s.size }

pub fn stats_test_anderson_cursor_get(s : StatstestandersonCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_anderson_cursor_set(s : StatstestandersonCursor, i : Int, v : Double) -> StatstestandersonCursor {
  let result = stats_test_anderson_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_cursor_sum(s : StatstestandersonCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_anderson_cursor_mean(s : StatstestandersonCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_anderson_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_test_anderson_cursor_scale(s : StatstestandersonCursor, f : Double) -> StatstestandersonCursor {
  let result = stats_test_anderson_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_anderson_cursor_add(a : StatstestandersonCursor, b : StatstestandersonCursor) -> StatstestandersonCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_anderson_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_anderson_cursor_copy(s : StatstestandersonCursor) -> StatstestandersonCursor {
  let result = stats_test_anderson_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_anderson_cursor_fill(s : StatstestandersonCursor, v : Double) -> StatstestandersonCursor {
  let result = stats_test_anderson_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_cursor_min(s : StatstestandersonCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_cursor_max(s : StatstestandersonCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_cursor_to_string(s : StatstestandersonCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestandersonView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_view_make(size : Int) -> StatstestandersonView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_anderson_view_len(s : StatstestandersonView) -> Int { s.size }

pub fn stats_test_anderson_view_get(s : StatstestandersonView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_anderson_view_set(s : StatstestandersonView, i : Int, v : Double) -> StatstestandersonView {
  let result = stats_test_anderson_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_view_sum(s : StatstestandersonView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_anderson_view_mean(s : StatstestandersonView) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_anderson_view_sum(s) / s.size.to_double() }
}

pub fn stats_test_anderson_view_scale(s : StatstestandersonView, f : Double) -> StatstestandersonView {
  let result = stats_test_anderson_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_anderson_view_add(a : StatstestandersonView, b : StatstestandersonView) -> StatstestandersonView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_anderson_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_anderson_view_copy(s : StatstestandersonView) -> StatstestandersonView {
  let result = stats_test_anderson_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_anderson_view_fill(s : StatstestandersonView, v : Double) -> StatstestandersonView {
  let result = stats_test_anderson_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_view_min(s : StatstestandersonView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_view_max(s : StatstestandersonView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_view_to_string(s : StatstestandersonView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestandersonRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_range_make(size : Int) -> StatstestandersonRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_anderson_range_len(s : StatstestandersonRange) -> Int { s.size }

pub fn stats_test_anderson_range_get(s : StatstestandersonRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_anderson_range_set(s : StatstestandersonRange, i : Int, v : Double) -> StatstestandersonRange {
  let result = stats_test_anderson_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_range_sum(s : StatstestandersonRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_anderson_range_mean(s : StatstestandersonRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_anderson_range_sum(s) / s.size.to_double() }
}

pub fn stats_test_anderson_range_scale(s : StatstestandersonRange, f : Double) -> StatstestandersonRange {
  let result = stats_test_anderson_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_anderson_range_add(a : StatstestandersonRange, b : StatstestandersonRange) -> StatstestandersonRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_anderson_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_anderson_range_copy(s : StatstestandersonRange) -> StatstestandersonRange {
  let result = stats_test_anderson_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_anderson_range_fill(s : StatstestandersonRange, v : Double) -> StatstestandersonRange {
  let result = stats_test_anderson_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_range_min(s : StatstestandersonRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_range_max(s : StatstestandersonRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_range_to_string(s : StatstestandersonRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestandersonSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_anderson_slice_make(size : Int) -> StatstestandersonSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_anderson_slice_len(s : StatstestandersonSlice) -> Int { s.size }

pub fn stats_test_anderson_slice_get(s : StatstestandersonSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_anderson_slice_set(s : StatstestandersonSlice, i : Int, v : Double) -> StatstestandersonSlice {
  let result = stats_test_anderson_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_slice_sum(s : StatstestandersonSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_anderson_slice_mean(s : StatstestandersonSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_anderson_slice_sum(s) / s.size.to_double() }
}

pub fn stats_test_anderson_slice_scale(s : StatstestandersonSlice, f : Double) -> StatstestandersonSlice {
  let result = stats_test_anderson_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_anderson_slice_add(a : StatstestandersonSlice, b : StatstestandersonSlice) -> StatstestandersonSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_anderson_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_anderson_slice_copy(s : StatstestandersonSlice) -> StatstestandersonSlice {
  let result = stats_test_anderson_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_anderson_slice_fill(s : StatstestandersonSlice, v : Double) -> StatstestandersonSlice {
  let result = stats_test_anderson_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_anderson_slice_min(s : StatstestandersonSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_slice_max(s : StatstestandersonSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_anderson_slice_to_string(s : StatstestandersonSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

