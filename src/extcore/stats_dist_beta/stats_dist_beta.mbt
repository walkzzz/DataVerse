///===
/// extcore/stats_dist_beta

pub(all) struct StatsdistbetaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_beta_make_point(x : Double, y : Double) -> StatsdistbetaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_beta_make_point3(x : Double, y : Double, z : Double) -> StatsdistbetaPoint {
  { x, y, z, label: 0 }
}

pub fn stats_dist_beta_point_x(pt : StatsdistbetaPoint) -> Double { pt.x }

pub fn stats_dist_beta_point_y(pt : StatsdistbetaPoint) -> Double { pt.y }

pub fn stats_dist_beta_point_z(pt : StatsdistbetaPoint) -> Double { pt.z }

pub fn stats_dist_beta_point_label(pt : StatsdistbetaPoint) -> Int { pt.label }

pub fn stats_dist_beta_point_dist(a : StatsdistbetaPoint, b : StatsdistbetaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_dist_beta_point_add(a : StatsdistbetaPoint, b : StatsdistbetaPoint) -> StatsdistbetaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_dist_beta_point_sub(a : StatsdistbetaPoint, b : StatsdistbetaPoint) -> StatsdistbetaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_dist_beta_point_scale(pt : StatsdistbetaPoint, s : Double) -> StatsdistbetaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_dist_beta_point_dot(a : StatsdistbetaPoint, b : StatsdistbetaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_dist_beta_point_cross(a : StatsdistbetaPoint, b : StatsdistbetaPoint) -> StatsdistbetaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_dist_beta_point_norm(pt : StatsdistbetaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_dist_beta_point_normalize(pt : StatsdistbetaPoint) -> StatsdistbetaPoint {
  let n = stats_dist_beta_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_dist_beta_point_scale(pt, 1.0 / n) }
}

pub fn stats_dist_beta_point_negate(pt : StatsdistbetaPoint) -> StatsdistbetaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_dist_beta_point_mid(a : StatsdistbetaPoint, b : StatsdistbetaPoint) -> StatsdistbetaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_dist_beta_point_lerp(a : StatsdistbetaPoint, b : StatsdistbetaPoint, t : Double) -> StatsdistbetaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_dist_beta_point_to_string(pt : StatsdistbetaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdistbetaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_beta_make_series(vals : Array[Double], name : String) -> StatsdistbetaSeries {
  { vals, name, meta: 0 }
}

pub fn stats_dist_beta_series_len(s : StatsdistbetaSeries) -> Int { s.vals.length() }

pub fn stats_dist_beta_series_sum(s : StatsdistbetaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_dist_beta_series_mean(s : StatsdistbetaSeries) -> Double {
  let n = stats_dist_beta_series_len(s)
  if n == 0 { 0.0 } else { stats_dist_beta_series_sum(s) / n.to_double() }
}

pub fn stats_dist_beta_series_min(s : StatsdistbetaSeries) -> Double {
  let n = stats_dist_beta_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_dist_beta_series_max(s : StatsdistbetaSeries) -> Double {
  let n = stats_dist_beta_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_dist_beta_series_range(s : StatsdistbetaSeries) -> Double {
  stats_dist_beta_series_max(s) - stats_dist_beta_series_min(s)
}

pub fn stats_dist_beta_series_var(s : StatsdistbetaSeries) -> Double {
  let n = stats_dist_beta_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_dist_beta_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_dist_beta_series_std(s : StatsdistbetaSeries) -> Double { @_common.sqrt(stats_dist_beta_series_var(s)) }

pub fn stats_dist_beta_series_median(s : StatsdistbetaSeries) -> Double {
  let n = stats_dist_beta_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_dist_beta_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_dist_beta_series_scale(s : StatsdistbetaSeries, f : Double) -> StatsdistbetaSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_dist_beta_series_add(a : StatsdistbetaSeries, b : StatsdistbetaSeries) -> StatsdistbetaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_dist_beta_series_sub(a : StatsdistbetaSeries, b : StatsdistbetaSeries) -> StatsdistbetaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_dist_beta_series_normalize(s : StatsdistbetaSeries) -> StatsdistbetaSeries {
  let mn = stats_dist_beta_series_min(s)
  let mx = stats_dist_beta_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_dist_beta_series_cumsum(s : StatsdistbetaSeries) -> StatsdistbetaSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_dist_beta_series_to_string(s : StatsdistbetaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistbetaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_beta_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistbetaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_beta_matrix_identity(n : Int) -> StatsdistbetaMatrix {
  let m = stats_dist_beta_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_dist_beta_matrix_get(m : StatsdistbetaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_dist_beta_matrix_transpose(m : StatsdistbetaMatrix) -> StatsdistbetaMatrix {
  let result = stats_dist_beta_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_dist_beta_matrix_add(a : StatsdistbetaMatrix, b : StatsdistbetaMatrix) -> StatsdistbetaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_dist_beta_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_dist_beta_matrix_scale(m : StatsdistbetaMatrix, s : Double) -> StatsdistbetaMatrix {
  let result = stats_dist_beta_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_dist_beta_matrix_multiply(a : StatsdistbetaMatrix, b : StatsdistbetaMatrix) -> StatsdistbetaMatrix {
  if a.cols != b.rows { return stats_dist_beta_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_dist_beta_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_dist_beta_matrix_trace(m : StatsdistbetaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_dist_beta_matrix_det(m : StatsdistbetaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_dist_beta_matrix_norm(m : StatsdistbetaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_dist_beta_matrix_to_string(m : StatsdistbetaMatrix) -> String {
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

pub(all) struct StatsdistbetaVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_beta_make_vector(comps : Array[Double]) -> StatsdistbetaVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_beta_vector_zero(dim : Int) -> StatsdistbetaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_dist_beta_vector_add(a : StatsdistbetaVector, b : StatsdistbetaVector) -> StatsdistbetaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_beta_vector_sub(a : StatsdistbetaVector, b : StatsdistbetaVector) -> StatsdistbetaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_beta_vector_scale(v : StatsdistbetaVector, s : Double) -> StatsdistbetaVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_dist_beta_vector_dot(a : StatsdistbetaVector, b : StatsdistbetaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_dist_beta_vector_norm(v : StatsdistbetaVector) -> Double { @_common.sqrt(stats_dist_beta_vector_dot(v, v)) }

pub fn stats_dist_beta_vector_normalize(v : StatsdistbetaVector) -> StatsdistbetaVector {
  let n = stats_dist_beta_vector_norm(v)
  if n < 0.0000001 { v } else { stats_dist_beta_vector_scale(v, 1.0 / n) }
}

pub fn stats_dist_beta_vector_dist(a : StatsdistbetaVector, b : StatsdistbetaVector) -> Double {
  stats_dist_beta_vector_norm(stats_dist_beta_vector_sub(a, b))
}

pub fn stats_dist_beta_vector_to_string(v : StatsdistbetaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_beta_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_beta_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_beta_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_beta_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_beta_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_beta_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_beta_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_beta_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_beta_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_beta_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_beta_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_beta_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_beta_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_beta_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_beta_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_beta_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_beta_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_beta_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_beta_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_beta_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_beta_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_beta_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_beta_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_beta_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_beta_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_beta_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_beta_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_beta_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_beta_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistbetaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_frame_make(size : Int) -> StatsdistbetaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_frame_len(s : StatsdistbetaFrame) -> Int { s.size }

pub fn stats_dist_beta_frame_get(s : StatsdistbetaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_frame_set(s : StatsdistbetaFrame, i : Int, v : Double) -> StatsdistbetaFrame {
  let result = stats_dist_beta_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_frame_sum(s : StatsdistbetaFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_beta_frame_mean(s : StatsdistbetaFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_beta_frame_sum(s) / s.size.to_double() }
}

pub fn stats_dist_beta_frame_scale(s : StatsdistbetaFrame, f : Double) -> StatsdistbetaFrame {
  let result = stats_dist_beta_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_beta_frame_add(a : StatsdistbetaFrame, b : StatsdistbetaFrame) -> StatsdistbetaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_beta_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_beta_frame_copy(s : StatsdistbetaFrame) -> StatsdistbetaFrame {
  let result = stats_dist_beta_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_beta_frame_fill(s : StatsdistbetaFrame, v : Double) -> StatsdistbetaFrame {
  let result = stats_dist_beta_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_frame_min(s : StatsdistbetaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_frame_max(s : StatsdistbetaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_frame_to_string(s : StatsdistbetaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_table_make(size : Int) -> StatsdistbetaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_table_len(s : StatsdistbetaTable) -> Int { s.size }

pub fn stats_dist_beta_table_get(s : StatsdistbetaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_table_set(s : StatsdistbetaTable, i : Int, v : Double) -> StatsdistbetaTable {
  let result = stats_dist_beta_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_table_sum(s : StatsdistbetaTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_beta_table_mean(s : StatsdistbetaTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_beta_table_sum(s) / s.size.to_double() }
}

pub fn stats_dist_beta_table_scale(s : StatsdistbetaTable, f : Double) -> StatsdistbetaTable {
  let result = stats_dist_beta_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_beta_table_add(a : StatsdistbetaTable, b : StatsdistbetaTable) -> StatsdistbetaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_beta_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_beta_table_copy(s : StatsdistbetaTable) -> StatsdistbetaTable {
  let result = stats_dist_beta_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_beta_table_fill(s : StatsdistbetaTable, v : Double) -> StatsdistbetaTable {
  let result = stats_dist_beta_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_table_min(s : StatsdistbetaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_table_max(s : StatsdistbetaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_table_to_string(s : StatsdistbetaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_graphn_make(size : Int) -> StatsdistbetaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_graphn_len(s : StatsdistbetaGraphN) -> Int { s.size }

pub fn stats_dist_beta_graphn_get(s : StatsdistbetaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_graphn_set(s : StatsdistbetaGraphN, i : Int, v : Double) -> StatsdistbetaGraphN {
  let result = stats_dist_beta_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_graphn_sum(s : StatsdistbetaGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_beta_graphn_mean(s : StatsdistbetaGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_beta_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_dist_beta_graphn_scale(s : StatsdistbetaGraphN, f : Double) -> StatsdistbetaGraphN {
  let result = stats_dist_beta_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_beta_graphn_add(a : StatsdistbetaGraphN, b : StatsdistbetaGraphN) -> StatsdistbetaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_beta_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_beta_graphn_copy(s : StatsdistbetaGraphN) -> StatsdistbetaGraphN {
  let result = stats_dist_beta_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_beta_graphn_fill(s : StatsdistbetaGraphN, v : Double) -> StatsdistbetaGraphN {
  let result = stats_dist_beta_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_graphn_min(s : StatsdistbetaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_graphn_max(s : StatsdistbetaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_graphn_to_string(s : StatsdistbetaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_node_make(size : Int) -> StatsdistbetaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_node_len(s : StatsdistbetaNode) -> Int { s.size }

pub fn stats_dist_beta_node_get(s : StatsdistbetaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_node_set(s : StatsdistbetaNode, i : Int, v : Double) -> StatsdistbetaNode {
  let result = stats_dist_beta_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_node_sum(s : StatsdistbetaNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_beta_node_mean(s : StatsdistbetaNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_beta_node_sum(s) / s.size.to_double() }
}

pub fn stats_dist_beta_node_scale(s : StatsdistbetaNode, f : Double) -> StatsdistbetaNode {
  let result = stats_dist_beta_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_beta_node_add(a : StatsdistbetaNode, b : StatsdistbetaNode) -> StatsdistbetaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_beta_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_beta_node_copy(s : StatsdistbetaNode) -> StatsdistbetaNode {
  let result = stats_dist_beta_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_beta_node_fill(s : StatsdistbetaNode, v : Double) -> StatsdistbetaNode {
  let result = stats_dist_beta_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_node_min(s : StatsdistbetaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_node_max(s : StatsdistbetaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_node_to_string(s : StatsdistbetaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_edge_make(size : Int) -> StatsdistbetaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_edge_len(s : StatsdistbetaEdge) -> Int { s.size }

pub fn stats_dist_beta_edge_get(s : StatsdistbetaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_edge_set(s : StatsdistbetaEdge, i : Int, v : Double) -> StatsdistbetaEdge {
  let result = stats_dist_beta_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_edge_sum(s : StatsdistbetaEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_beta_edge_mean(s : StatsdistbetaEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_beta_edge_sum(s) / s.size.to_double() }
}

pub fn stats_dist_beta_edge_scale(s : StatsdistbetaEdge, f : Double) -> StatsdistbetaEdge {
  let result = stats_dist_beta_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_beta_edge_add(a : StatsdistbetaEdge, b : StatsdistbetaEdge) -> StatsdistbetaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_beta_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_beta_edge_copy(s : StatsdistbetaEdge) -> StatsdistbetaEdge {
  let result = stats_dist_beta_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_beta_edge_fill(s : StatsdistbetaEdge, v : Double) -> StatsdistbetaEdge {
  let result = stats_dist_beta_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_edge_min(s : StatsdistbetaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_edge_max(s : StatsdistbetaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_edge_to_string(s : StatsdistbetaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_path_make(size : Int) -> StatsdistbetaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_path_len(s : StatsdistbetaPath) -> Int { s.size }

pub fn stats_dist_beta_path_get(s : StatsdistbetaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_path_set(s : StatsdistbetaPath, i : Int, v : Double) -> StatsdistbetaPath {
  let result = stats_dist_beta_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_path_sum(s : StatsdistbetaPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_beta_path_mean(s : StatsdistbetaPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_beta_path_sum(s) / s.size.to_double() }
}

pub fn stats_dist_beta_path_scale(s : StatsdistbetaPath, f : Double) -> StatsdistbetaPath {
  let result = stats_dist_beta_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_beta_path_add(a : StatsdistbetaPath, b : StatsdistbetaPath) -> StatsdistbetaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_beta_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_beta_path_copy(s : StatsdistbetaPath) -> StatsdistbetaPath {
  let result = stats_dist_beta_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_beta_path_fill(s : StatsdistbetaPath, v : Double) -> StatsdistbetaPath {
  let result = stats_dist_beta_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_path_min(s : StatsdistbetaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_path_max(s : StatsdistbetaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_path_to_string(s : StatsdistbetaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_cluster_make(size : Int) -> StatsdistbetaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_cluster_len(s : StatsdistbetaCluster) -> Int { s.size }

pub fn stats_dist_beta_cluster_get(s : StatsdistbetaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_cluster_set(s : StatsdistbetaCluster, i : Int, v : Double) -> StatsdistbetaCluster {
  let result = stats_dist_beta_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_cluster_sum(s : StatsdistbetaCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_beta_cluster_mean(s : StatsdistbetaCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_beta_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_dist_beta_cluster_scale(s : StatsdistbetaCluster, f : Double) -> StatsdistbetaCluster {
  let result = stats_dist_beta_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_beta_cluster_add(a : StatsdistbetaCluster, b : StatsdistbetaCluster) -> StatsdistbetaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_beta_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_beta_cluster_copy(s : StatsdistbetaCluster) -> StatsdistbetaCluster {
  let result = stats_dist_beta_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_beta_cluster_fill(s : StatsdistbetaCluster, v : Double) -> StatsdistbetaCluster {
  let result = stats_dist_beta_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_cluster_min(s : StatsdistbetaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_cluster_max(s : StatsdistbetaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_cluster_to_string(s : StatsdistbetaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_model_make(size : Int) -> StatsdistbetaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_model_len(s : StatsdistbetaModel) -> Int { s.size }

pub fn stats_dist_beta_model_get(s : StatsdistbetaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_model_set(s : StatsdistbetaModel, i : Int, v : Double) -> StatsdistbetaModel {
  let result = stats_dist_beta_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_model_sum(s : StatsdistbetaModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_beta_model_mean(s : StatsdistbetaModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_beta_model_sum(s) / s.size.to_double() }
}

pub fn stats_dist_beta_model_scale(s : StatsdistbetaModel, f : Double) -> StatsdistbetaModel {
  let result = stats_dist_beta_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_beta_model_add(a : StatsdistbetaModel, b : StatsdistbetaModel) -> StatsdistbetaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_beta_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_beta_model_copy(s : StatsdistbetaModel) -> StatsdistbetaModel {
  let result = stats_dist_beta_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_beta_model_fill(s : StatsdistbetaModel, v : Double) -> StatsdistbetaModel {
  let result = stats_dist_beta_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_model_min(s : StatsdistbetaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_model_max(s : StatsdistbetaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_model_to_string(s : StatsdistbetaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_layer_make(size : Int) -> StatsdistbetaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_layer_len(s : StatsdistbetaLayer) -> Int { s.size }

pub fn stats_dist_beta_layer_get(s : StatsdistbetaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_layer_set(s : StatsdistbetaLayer, i : Int, v : Double) -> StatsdistbetaLayer {
  let result = stats_dist_beta_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_layer_sum(s : StatsdistbetaLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_beta_layer_mean(s : StatsdistbetaLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_beta_layer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_beta_layer_scale(s : StatsdistbetaLayer, f : Double) -> StatsdistbetaLayer {
  let result = stats_dist_beta_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_beta_layer_add(a : StatsdistbetaLayer, b : StatsdistbetaLayer) -> StatsdistbetaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_beta_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_beta_layer_copy(s : StatsdistbetaLayer) -> StatsdistbetaLayer {
  let result = stats_dist_beta_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_beta_layer_fill(s : StatsdistbetaLayer, v : Double) -> StatsdistbetaLayer {
  let result = stats_dist_beta_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_layer_min(s : StatsdistbetaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_layer_max(s : StatsdistbetaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_layer_to_string(s : StatsdistbetaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_buffer_make(size : Int) -> StatsdistbetaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_buffer_len(s : StatsdistbetaBuffer) -> Int { s.size }

pub fn stats_dist_beta_buffer_get(s : StatsdistbetaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_buffer_set(s : StatsdistbetaBuffer, i : Int, v : Double) -> StatsdistbetaBuffer {
  let result = stats_dist_beta_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_buffer_sum(s : StatsdistbetaBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_beta_buffer_mean(s : StatsdistbetaBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_beta_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_beta_buffer_scale(s : StatsdistbetaBuffer, f : Double) -> StatsdistbetaBuffer {
  let result = stats_dist_beta_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_beta_buffer_add(a : StatsdistbetaBuffer, b : StatsdistbetaBuffer) -> StatsdistbetaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_beta_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_beta_buffer_copy(s : StatsdistbetaBuffer) -> StatsdistbetaBuffer {
  let result = stats_dist_beta_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_beta_buffer_fill(s : StatsdistbetaBuffer, v : Double) -> StatsdistbetaBuffer {
  let result = stats_dist_beta_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_buffer_min(s : StatsdistbetaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_buffer_max(s : StatsdistbetaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_buffer_to_string(s : StatsdistbetaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_cursor_make(size : Int) -> StatsdistbetaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_cursor_len(s : StatsdistbetaCursor) -> Int { s.size }

pub fn stats_dist_beta_cursor_get(s : StatsdistbetaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_cursor_set(s : StatsdistbetaCursor, i : Int, v : Double) -> StatsdistbetaCursor {
  let result = stats_dist_beta_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_cursor_sum(s : StatsdistbetaCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_beta_cursor_mean(s : StatsdistbetaCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_beta_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_dist_beta_cursor_scale(s : StatsdistbetaCursor, f : Double) -> StatsdistbetaCursor {
  let result = stats_dist_beta_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_beta_cursor_add(a : StatsdistbetaCursor, b : StatsdistbetaCursor) -> StatsdistbetaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_beta_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_beta_cursor_copy(s : StatsdistbetaCursor) -> StatsdistbetaCursor {
  let result = stats_dist_beta_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_beta_cursor_fill(s : StatsdistbetaCursor, v : Double) -> StatsdistbetaCursor {
  let result = stats_dist_beta_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_cursor_min(s : StatsdistbetaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_cursor_max(s : StatsdistbetaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_cursor_to_string(s : StatsdistbetaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_view_make(size : Int) -> StatsdistbetaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_view_len(s : StatsdistbetaView) -> Int { s.size }

pub fn stats_dist_beta_view_get(s : StatsdistbetaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_view_set(s : StatsdistbetaView, i : Int, v : Double) -> StatsdistbetaView {
  let result = stats_dist_beta_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_view_sum(s : StatsdistbetaView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_beta_view_mean(s : StatsdistbetaView) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_beta_view_sum(s) / s.size.to_double() }
}

pub fn stats_dist_beta_view_scale(s : StatsdistbetaView, f : Double) -> StatsdistbetaView {
  let result = stats_dist_beta_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_beta_view_add(a : StatsdistbetaView, b : StatsdistbetaView) -> StatsdistbetaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_beta_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_beta_view_copy(s : StatsdistbetaView) -> StatsdistbetaView {
  let result = stats_dist_beta_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_beta_view_fill(s : StatsdistbetaView, v : Double) -> StatsdistbetaView {
  let result = stats_dist_beta_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_view_min(s : StatsdistbetaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_view_max(s : StatsdistbetaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_view_to_string(s : StatsdistbetaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_range_make(size : Int) -> StatsdistbetaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_range_len(s : StatsdistbetaRange) -> Int { s.size }

pub fn stats_dist_beta_range_get(s : StatsdistbetaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_range_set(s : StatsdistbetaRange, i : Int, v : Double) -> StatsdistbetaRange {
  let result = stats_dist_beta_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_range_sum(s : StatsdistbetaRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_beta_range_mean(s : StatsdistbetaRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_beta_range_sum(s) / s.size.to_double() }
}

pub fn stats_dist_beta_range_scale(s : StatsdistbetaRange, f : Double) -> StatsdistbetaRange {
  let result = stats_dist_beta_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_beta_range_add(a : StatsdistbetaRange, b : StatsdistbetaRange) -> StatsdistbetaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_beta_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_beta_range_copy(s : StatsdistbetaRange) -> StatsdistbetaRange {
  let result = stats_dist_beta_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_beta_range_fill(s : StatsdistbetaRange, v : Double) -> StatsdistbetaRange {
  let result = stats_dist_beta_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_range_min(s : StatsdistbetaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_range_max(s : StatsdistbetaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_range_to_string(s : StatsdistbetaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_slice_make(size : Int) -> StatsdistbetaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_slice_len(s : StatsdistbetaSlice) -> Int { s.size }

pub fn stats_dist_beta_slice_get(s : StatsdistbetaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_slice_set(s : StatsdistbetaSlice, i : Int, v : Double) -> StatsdistbetaSlice {
  let result = stats_dist_beta_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_slice_sum(s : StatsdistbetaSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_beta_slice_mean(s : StatsdistbetaSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_beta_slice_sum(s) / s.size.to_double() }
}

pub fn stats_dist_beta_slice_scale(s : StatsdistbetaSlice, f : Double) -> StatsdistbetaSlice {
  let result = stats_dist_beta_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_beta_slice_add(a : StatsdistbetaSlice, b : StatsdistbetaSlice) -> StatsdistbetaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_beta_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_beta_slice_copy(s : StatsdistbetaSlice) -> StatsdistbetaSlice {
  let result = stats_dist_beta_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_beta_slice_fill(s : StatsdistbetaSlice, v : Double) -> StatsdistbetaSlice {
  let result = stats_dist_beta_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_beta_slice_min(s : StatsdistbetaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_slice_max(s : StatsdistbetaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_beta_slice_to_string(s : StatsdistbetaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

