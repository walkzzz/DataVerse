///===
/// extcore/net_sec_rate_limit

pub(all) struct NetsecratelimitPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_sec_rate_limit_make_point(x : Double, y : Double) -> NetsecratelimitPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_sec_rate_limit_make_point3(x : Double, y : Double, z : Double) -> NetsecratelimitPoint {
  { x, y, z, label: 0 }
}

pub fn net_sec_rate_limit_point_x(pt : NetsecratelimitPoint) -> Double { pt.x }

pub fn net_sec_rate_limit_point_y(pt : NetsecratelimitPoint) -> Double { pt.y }

pub fn net_sec_rate_limit_point_z(pt : NetsecratelimitPoint) -> Double { pt.z }

pub fn net_sec_rate_limit_point_label(pt : NetsecratelimitPoint) -> Int { pt.label }

pub fn net_sec_rate_limit_point_dist(a : NetsecratelimitPoint, b : NetsecratelimitPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_sec_rate_limit_point_add(a : NetsecratelimitPoint, b : NetsecratelimitPoint) -> NetsecratelimitPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_sec_rate_limit_point_sub(a : NetsecratelimitPoint, b : NetsecratelimitPoint) -> NetsecratelimitPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_sec_rate_limit_point_scale(pt : NetsecratelimitPoint, s : Double) -> NetsecratelimitPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_sec_rate_limit_point_dot(a : NetsecratelimitPoint, b : NetsecratelimitPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_sec_rate_limit_point_cross(a : NetsecratelimitPoint, b : NetsecratelimitPoint) -> NetsecratelimitPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_sec_rate_limit_point_norm(pt : NetsecratelimitPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_sec_rate_limit_point_normalize(pt : NetsecratelimitPoint) -> NetsecratelimitPoint {
  let n = net_sec_rate_limit_point_norm(pt)
  if n < 0.0000001 { pt } else { net_sec_rate_limit_point_scale(pt, 1.0 / n) }
}

pub fn net_sec_rate_limit_point_negate(pt : NetsecratelimitPoint) -> NetsecratelimitPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_sec_rate_limit_point_mid(a : NetsecratelimitPoint, b : NetsecratelimitPoint) -> NetsecratelimitPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_sec_rate_limit_point_lerp(a : NetsecratelimitPoint, b : NetsecratelimitPoint, t : Double) -> NetsecratelimitPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_sec_rate_limit_point_to_string(pt : NetsecratelimitPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetsecratelimitSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_sec_rate_limit_make_series(vals : Array[Double], name : String) -> NetsecratelimitSeries {
  { vals, name, meta: 0 }
}

pub fn net_sec_rate_limit_series_len(s : NetsecratelimitSeries) -> Int { s.vals.length() }

pub fn net_sec_rate_limit_series_sum(s : NetsecratelimitSeries) -> Double { @_common.sum(s.vals) }

pub fn net_sec_rate_limit_series_mean(s : NetsecratelimitSeries) -> Double { @_common.mean(s.vals) }

pub fn net_sec_rate_limit_series_min(s : NetsecratelimitSeries) -> Double { @_common.min(s.vals) }

pub fn net_sec_rate_limit_series_max(s : NetsecratelimitSeries) -> Double { @_common.max(s.vals) }

pub fn net_sec_rate_limit_series_range(s : NetsecratelimitSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn net_sec_rate_limit_series_var(s : NetsecratelimitSeries) -> Double { @_common.variance(s.vals) }

pub fn net_sec_rate_limit_series_std(s : NetsecratelimitSeries) -> Double { @_common.std(s.vals) }

pub fn net_sec_rate_limit_series_median(s : NetsecratelimitSeries) -> Double { @_common.median(s.vals) }

pub fn net_sec_rate_limit_series_scale(s : NetsecratelimitSeries, f : Double) -> NetsecratelimitSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_sec_rate_limit_series_add(a : NetsecratelimitSeries, b : NetsecratelimitSeries) -> NetsecratelimitSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_sec_rate_limit_series_sub(a : NetsecratelimitSeries, b : NetsecratelimitSeries) -> NetsecratelimitSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_sec_rate_limit_series_normalize(s : NetsecratelimitSeries) -> NetsecratelimitSeries {
  let mn = net_sec_rate_limit_series_min(s)
  let mx = net_sec_rate_limit_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_sec_rate_limit_series_cumsum(s : NetsecratelimitSeries) -> NetsecratelimitSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_sec_rate_limit_series_to_string(s : NetsecratelimitSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecratelimitMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_sec_rate_limit_make_matrix(rows : Int, cols : Int, val : Double) -> NetsecratelimitMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_sec_rate_limit_matrix_identity(n : Int) -> NetsecratelimitMatrix {
  let m = net_sec_rate_limit_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_sec_rate_limit_matrix_get(m : NetsecratelimitMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_sec_rate_limit_matrix_transpose(m : NetsecratelimitMatrix) -> NetsecratelimitMatrix {
  let result = net_sec_rate_limit_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_sec_rate_limit_matrix_add(a : NetsecratelimitMatrix, b : NetsecratelimitMatrix) -> NetsecratelimitMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_sec_rate_limit_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_sec_rate_limit_matrix_scale(m : NetsecratelimitMatrix, s : Double) -> NetsecratelimitMatrix {
  let result = net_sec_rate_limit_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_sec_rate_limit_matrix_multiply(a : NetsecratelimitMatrix, b : NetsecratelimitMatrix) -> NetsecratelimitMatrix {
  if a.cols != b.rows { return net_sec_rate_limit_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_sec_rate_limit_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_sec_rate_limit_matrix_trace(m : NetsecratelimitMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_sec_rate_limit_matrix_det(m : NetsecratelimitMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_sec_rate_limit_matrix_norm(m : NetsecratelimitMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_sec_rate_limit_matrix_to_string(m : NetsecratelimitMatrix) -> String {
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

pub(all) struct NetsecratelimitVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_sec_rate_limit_make_vector(comps : Array[Double]) -> NetsecratelimitVector {
  { comps, dim: comps.length() }
}

pub fn net_sec_rate_limit_vector_zero(dim : Int) -> NetsecratelimitVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_sec_rate_limit_vector_add(a : NetsecratelimitVector, b : NetsecratelimitVector) -> NetsecratelimitVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_sec_rate_limit_vector_sub(a : NetsecratelimitVector, b : NetsecratelimitVector) -> NetsecratelimitVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_sec_rate_limit_vector_scale(v : NetsecratelimitVector, s : Double) -> NetsecratelimitVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_sec_rate_limit_vector_dot(a : NetsecratelimitVector, b : NetsecratelimitVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_sec_rate_limit_vector_norm(v : NetsecratelimitVector) -> Double { @_common.sqrt(net_sec_rate_limit_vector_dot(v, v)) }

pub fn net_sec_rate_limit_vector_normalize(v : NetsecratelimitVector) -> NetsecratelimitVector {
  let n = net_sec_rate_limit_vector_norm(v)
  if n < 0.0000001 { v } else { net_sec_rate_limit_vector_scale(v, 1.0 / n) }
}

pub fn net_sec_rate_limit_vector_dist(a : NetsecratelimitVector, b : NetsecratelimitVector) -> Double {
  net_sec_rate_limit_vector_norm(net_sec_rate_limit_vector_sub(a, b))
}

pub fn net_sec_rate_limit_vector_to_string(v : NetsecratelimitVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_sec_rate_limit_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_sec_rate_limit_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_sec_rate_limit_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_sec_rate_limit_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_sec_rate_limit_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_sec_rate_limit_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_sec_rate_limit_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_sec_rate_limit_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_sec_rate_limit_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_sec_rate_limit_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_sec_rate_limit_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_sec_rate_limit_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_sec_rate_limit_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_sec_rate_limit_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_sec_rate_limit_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_sec_rate_limit_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_sec_rate_limit_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_sec_rate_limit_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_sec_rate_limit_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_sec_rate_limit_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_sec_rate_limit_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_sec_rate_limit_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_sec_rate_limit_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_sec_rate_limit_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_sec_rate_limit_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_sec_rate_limit_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_sec_rate_limit_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_sec_rate_limit_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_sec_rate_limit_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetsecratelimitFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_frame_make(size : Int) -> NetsecratelimitFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_frame_len(s : NetsecratelimitFrame) -> Int { s.size }

pub fn net_sec_rate_limit_frame_get(s : NetsecratelimitFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_frame_set(s : NetsecratelimitFrame, i : Int, v : Double) -> NetsecratelimitFrame {
  let result = net_sec_rate_limit_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_frame_sum(s : NetsecratelimitFrame) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_frame_mean(s : NetsecratelimitFrame) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_frame_scale(s : NetsecratelimitFrame, f : Double) -> NetsecratelimitFrame {
  let result = net_sec_rate_limit_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_rate_limit_frame_add(a : NetsecratelimitFrame, b : NetsecratelimitFrame) -> NetsecratelimitFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_rate_limit_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_rate_limit_frame_copy(s : NetsecratelimitFrame) -> NetsecratelimitFrame {
  let result = net_sec_rate_limit_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_rate_limit_frame_fill(s : NetsecratelimitFrame, v : Double) -> NetsecratelimitFrame {
  let result = net_sec_rate_limit_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_frame_min(s : NetsecratelimitFrame) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_frame_max(s : NetsecratelimitFrame) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_frame_to_string(s : NetsecratelimitFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_table_make(size : Int) -> NetsecratelimitTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_table_len(s : NetsecratelimitTable) -> Int { s.size }

pub fn net_sec_rate_limit_table_get(s : NetsecratelimitTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_table_set(s : NetsecratelimitTable, i : Int, v : Double) -> NetsecratelimitTable {
  let result = net_sec_rate_limit_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_table_sum(s : NetsecratelimitTable) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_table_mean(s : NetsecratelimitTable) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_table_scale(s : NetsecratelimitTable, f : Double) -> NetsecratelimitTable {
  let result = net_sec_rate_limit_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_rate_limit_table_add(a : NetsecratelimitTable, b : NetsecratelimitTable) -> NetsecratelimitTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_rate_limit_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_rate_limit_table_copy(s : NetsecratelimitTable) -> NetsecratelimitTable {
  let result = net_sec_rate_limit_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_rate_limit_table_fill(s : NetsecratelimitTable, v : Double) -> NetsecratelimitTable {
  let result = net_sec_rate_limit_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_table_min(s : NetsecratelimitTable) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_table_max(s : NetsecratelimitTable) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_table_to_string(s : NetsecratelimitTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_graphn_make(size : Int) -> NetsecratelimitGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_graphn_len(s : NetsecratelimitGraphN) -> Int { s.size }

pub fn net_sec_rate_limit_graphn_get(s : NetsecratelimitGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_graphn_set(s : NetsecratelimitGraphN, i : Int, v : Double) -> NetsecratelimitGraphN {
  let result = net_sec_rate_limit_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_graphn_sum(s : NetsecratelimitGraphN) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_graphn_mean(s : NetsecratelimitGraphN) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_graphn_scale(s : NetsecratelimitGraphN, f : Double) -> NetsecratelimitGraphN {
  let result = net_sec_rate_limit_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_rate_limit_graphn_add(a : NetsecratelimitGraphN, b : NetsecratelimitGraphN) -> NetsecratelimitGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_rate_limit_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_rate_limit_graphn_copy(s : NetsecratelimitGraphN) -> NetsecratelimitGraphN {
  let result = net_sec_rate_limit_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_rate_limit_graphn_fill(s : NetsecratelimitGraphN, v : Double) -> NetsecratelimitGraphN {
  let result = net_sec_rate_limit_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_graphn_min(s : NetsecratelimitGraphN) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_graphn_max(s : NetsecratelimitGraphN) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_graphn_to_string(s : NetsecratelimitGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_node_make(size : Int) -> NetsecratelimitNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_node_len(s : NetsecratelimitNode) -> Int { s.size }

pub fn net_sec_rate_limit_node_get(s : NetsecratelimitNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_node_set(s : NetsecratelimitNode, i : Int, v : Double) -> NetsecratelimitNode {
  let result = net_sec_rate_limit_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_node_sum(s : NetsecratelimitNode) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_node_mean(s : NetsecratelimitNode) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_node_scale(s : NetsecratelimitNode, f : Double) -> NetsecratelimitNode {
  let result = net_sec_rate_limit_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_rate_limit_node_add(a : NetsecratelimitNode, b : NetsecratelimitNode) -> NetsecratelimitNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_rate_limit_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_rate_limit_node_copy(s : NetsecratelimitNode) -> NetsecratelimitNode {
  let result = net_sec_rate_limit_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_rate_limit_node_fill(s : NetsecratelimitNode, v : Double) -> NetsecratelimitNode {
  let result = net_sec_rate_limit_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_node_min(s : NetsecratelimitNode) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_node_max(s : NetsecratelimitNode) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_node_to_string(s : NetsecratelimitNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_edge_make(size : Int) -> NetsecratelimitEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_edge_len(s : NetsecratelimitEdge) -> Int { s.size }

pub fn net_sec_rate_limit_edge_get(s : NetsecratelimitEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_edge_set(s : NetsecratelimitEdge, i : Int, v : Double) -> NetsecratelimitEdge {
  let result = net_sec_rate_limit_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_edge_sum(s : NetsecratelimitEdge) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_edge_mean(s : NetsecratelimitEdge) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_edge_scale(s : NetsecratelimitEdge, f : Double) -> NetsecratelimitEdge {
  let result = net_sec_rate_limit_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_rate_limit_edge_add(a : NetsecratelimitEdge, b : NetsecratelimitEdge) -> NetsecratelimitEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_rate_limit_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_rate_limit_edge_copy(s : NetsecratelimitEdge) -> NetsecratelimitEdge {
  let result = net_sec_rate_limit_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_rate_limit_edge_fill(s : NetsecratelimitEdge, v : Double) -> NetsecratelimitEdge {
  let result = net_sec_rate_limit_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_edge_min(s : NetsecratelimitEdge) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_edge_max(s : NetsecratelimitEdge) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_edge_to_string(s : NetsecratelimitEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_path_make(size : Int) -> NetsecratelimitPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_path_len(s : NetsecratelimitPath) -> Int { s.size }

pub fn net_sec_rate_limit_path_get(s : NetsecratelimitPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_path_set(s : NetsecratelimitPath, i : Int, v : Double) -> NetsecratelimitPath {
  let result = net_sec_rate_limit_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_path_sum(s : NetsecratelimitPath) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_path_mean(s : NetsecratelimitPath) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_path_scale(s : NetsecratelimitPath, f : Double) -> NetsecratelimitPath {
  let result = net_sec_rate_limit_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_rate_limit_path_add(a : NetsecratelimitPath, b : NetsecratelimitPath) -> NetsecratelimitPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_rate_limit_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_rate_limit_path_copy(s : NetsecratelimitPath) -> NetsecratelimitPath {
  let result = net_sec_rate_limit_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_rate_limit_path_fill(s : NetsecratelimitPath, v : Double) -> NetsecratelimitPath {
  let result = net_sec_rate_limit_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_path_min(s : NetsecratelimitPath) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_path_max(s : NetsecratelimitPath) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_path_to_string(s : NetsecratelimitPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_cluster_make(size : Int) -> NetsecratelimitCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_cluster_len(s : NetsecratelimitCluster) -> Int { s.size }

pub fn net_sec_rate_limit_cluster_get(s : NetsecratelimitCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_cluster_set(s : NetsecratelimitCluster, i : Int, v : Double) -> NetsecratelimitCluster {
  let result = net_sec_rate_limit_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_cluster_sum(s : NetsecratelimitCluster) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_cluster_mean(s : NetsecratelimitCluster) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_cluster_scale(s : NetsecratelimitCluster, f : Double) -> NetsecratelimitCluster {
  let result = net_sec_rate_limit_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_rate_limit_cluster_add(a : NetsecratelimitCluster, b : NetsecratelimitCluster) -> NetsecratelimitCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_rate_limit_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_rate_limit_cluster_copy(s : NetsecratelimitCluster) -> NetsecratelimitCluster {
  let result = net_sec_rate_limit_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_rate_limit_cluster_fill(s : NetsecratelimitCluster, v : Double) -> NetsecratelimitCluster {
  let result = net_sec_rate_limit_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_cluster_min(s : NetsecratelimitCluster) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_cluster_max(s : NetsecratelimitCluster) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_cluster_to_string(s : NetsecratelimitCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_model_make(size : Int) -> NetsecratelimitModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_model_len(s : NetsecratelimitModel) -> Int { s.size }

pub fn net_sec_rate_limit_model_get(s : NetsecratelimitModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_model_set(s : NetsecratelimitModel, i : Int, v : Double) -> NetsecratelimitModel {
  let result = net_sec_rate_limit_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_model_sum(s : NetsecratelimitModel) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_model_mean(s : NetsecratelimitModel) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_model_scale(s : NetsecratelimitModel, f : Double) -> NetsecratelimitModel {
  let result = net_sec_rate_limit_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_rate_limit_model_add(a : NetsecratelimitModel, b : NetsecratelimitModel) -> NetsecratelimitModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_rate_limit_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_rate_limit_model_copy(s : NetsecratelimitModel) -> NetsecratelimitModel {
  let result = net_sec_rate_limit_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_rate_limit_model_fill(s : NetsecratelimitModel, v : Double) -> NetsecratelimitModel {
  let result = net_sec_rate_limit_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_model_min(s : NetsecratelimitModel) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_model_max(s : NetsecratelimitModel) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_model_to_string(s : NetsecratelimitModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_layer_make(size : Int) -> NetsecratelimitLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_layer_len(s : NetsecratelimitLayer) -> Int { s.size }

pub fn net_sec_rate_limit_layer_get(s : NetsecratelimitLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_layer_set(s : NetsecratelimitLayer, i : Int, v : Double) -> NetsecratelimitLayer {
  let result = net_sec_rate_limit_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_layer_sum(s : NetsecratelimitLayer) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_layer_mean(s : NetsecratelimitLayer) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_layer_scale(s : NetsecratelimitLayer, f : Double) -> NetsecratelimitLayer {
  let result = net_sec_rate_limit_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_rate_limit_layer_add(a : NetsecratelimitLayer, b : NetsecratelimitLayer) -> NetsecratelimitLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_rate_limit_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_rate_limit_layer_copy(s : NetsecratelimitLayer) -> NetsecratelimitLayer {
  let result = net_sec_rate_limit_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_rate_limit_layer_fill(s : NetsecratelimitLayer, v : Double) -> NetsecratelimitLayer {
  let result = net_sec_rate_limit_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_layer_min(s : NetsecratelimitLayer) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_layer_max(s : NetsecratelimitLayer) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_layer_to_string(s : NetsecratelimitLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_buffer_make(size : Int) -> NetsecratelimitBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_buffer_len(s : NetsecratelimitBuffer) -> Int { s.size }

pub fn net_sec_rate_limit_buffer_get(s : NetsecratelimitBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_buffer_set(s : NetsecratelimitBuffer, i : Int, v : Double) -> NetsecratelimitBuffer {
  let result = net_sec_rate_limit_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_buffer_sum(s : NetsecratelimitBuffer) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_buffer_mean(s : NetsecratelimitBuffer) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_buffer_scale(s : NetsecratelimitBuffer, f : Double) -> NetsecratelimitBuffer {
  let result = net_sec_rate_limit_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_rate_limit_buffer_add(a : NetsecratelimitBuffer, b : NetsecratelimitBuffer) -> NetsecratelimitBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_rate_limit_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_rate_limit_buffer_copy(s : NetsecratelimitBuffer) -> NetsecratelimitBuffer {
  let result = net_sec_rate_limit_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_rate_limit_buffer_fill(s : NetsecratelimitBuffer, v : Double) -> NetsecratelimitBuffer {
  let result = net_sec_rate_limit_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_buffer_min(s : NetsecratelimitBuffer) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_buffer_max(s : NetsecratelimitBuffer) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_buffer_to_string(s : NetsecratelimitBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_cursor_make(size : Int) -> NetsecratelimitCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_cursor_len(s : NetsecratelimitCursor) -> Int { s.size }

pub fn net_sec_rate_limit_cursor_get(s : NetsecratelimitCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_cursor_set(s : NetsecratelimitCursor, i : Int, v : Double) -> NetsecratelimitCursor {
  let result = net_sec_rate_limit_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_cursor_sum(s : NetsecratelimitCursor) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_cursor_mean(s : NetsecratelimitCursor) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_cursor_scale(s : NetsecratelimitCursor, f : Double) -> NetsecratelimitCursor {
  let result = net_sec_rate_limit_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_rate_limit_cursor_add(a : NetsecratelimitCursor, b : NetsecratelimitCursor) -> NetsecratelimitCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_rate_limit_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_rate_limit_cursor_copy(s : NetsecratelimitCursor) -> NetsecratelimitCursor {
  let result = net_sec_rate_limit_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_rate_limit_cursor_fill(s : NetsecratelimitCursor, v : Double) -> NetsecratelimitCursor {
  let result = net_sec_rate_limit_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_cursor_min(s : NetsecratelimitCursor) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_cursor_max(s : NetsecratelimitCursor) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_cursor_to_string(s : NetsecratelimitCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_view_make(size : Int) -> NetsecratelimitView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_view_len(s : NetsecratelimitView) -> Int { s.size }

pub fn net_sec_rate_limit_view_get(s : NetsecratelimitView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_view_set(s : NetsecratelimitView, i : Int, v : Double) -> NetsecratelimitView {
  let result = net_sec_rate_limit_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_view_sum(s : NetsecratelimitView) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_view_mean(s : NetsecratelimitView) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_view_scale(s : NetsecratelimitView, f : Double) -> NetsecratelimitView {
  let result = net_sec_rate_limit_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_rate_limit_view_add(a : NetsecratelimitView, b : NetsecratelimitView) -> NetsecratelimitView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_rate_limit_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_rate_limit_view_copy(s : NetsecratelimitView) -> NetsecratelimitView {
  let result = net_sec_rate_limit_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_rate_limit_view_fill(s : NetsecratelimitView, v : Double) -> NetsecratelimitView {
  let result = net_sec_rate_limit_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_view_min(s : NetsecratelimitView) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_view_max(s : NetsecratelimitView) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_view_to_string(s : NetsecratelimitView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_range_make(size : Int) -> NetsecratelimitRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_range_len(s : NetsecratelimitRange) -> Int { s.size }

pub fn net_sec_rate_limit_range_get(s : NetsecratelimitRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_range_set(s : NetsecratelimitRange, i : Int, v : Double) -> NetsecratelimitRange {
  let result = net_sec_rate_limit_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_range_sum(s : NetsecratelimitRange) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_range_mean(s : NetsecratelimitRange) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_range_scale(s : NetsecratelimitRange, f : Double) -> NetsecratelimitRange {
  let result = net_sec_rate_limit_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_rate_limit_range_add(a : NetsecratelimitRange, b : NetsecratelimitRange) -> NetsecratelimitRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_rate_limit_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_rate_limit_range_copy(s : NetsecratelimitRange) -> NetsecratelimitRange {
  let result = net_sec_rate_limit_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_rate_limit_range_fill(s : NetsecratelimitRange, v : Double) -> NetsecratelimitRange {
  let result = net_sec_rate_limit_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_range_min(s : NetsecratelimitRange) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_range_max(s : NetsecratelimitRange) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_range_to_string(s : NetsecratelimitRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_slice_make(size : Int) -> NetsecratelimitSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_slice_len(s : NetsecratelimitSlice) -> Int { s.size }

pub fn net_sec_rate_limit_slice_get(s : NetsecratelimitSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_slice_set(s : NetsecratelimitSlice, i : Int, v : Double) -> NetsecratelimitSlice {
  let result = net_sec_rate_limit_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_slice_sum(s : NetsecratelimitSlice) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_slice_mean(s : NetsecratelimitSlice) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_slice_scale(s : NetsecratelimitSlice, f : Double) -> NetsecratelimitSlice {
  let result = net_sec_rate_limit_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_rate_limit_slice_add(a : NetsecratelimitSlice, b : NetsecratelimitSlice) -> NetsecratelimitSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_rate_limit_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_rate_limit_slice_copy(s : NetsecratelimitSlice) -> NetsecratelimitSlice {
  let result = net_sec_rate_limit_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_rate_limit_slice_fill(s : NetsecratelimitSlice, v : Double) -> NetsecratelimitSlice {
  let result = net_sec_rate_limit_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_rate_limit_slice_min(s : NetsecratelimitSlice) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_slice_max(s : NetsecratelimitSlice) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_slice_to_string(s : NetsecratelimitSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

