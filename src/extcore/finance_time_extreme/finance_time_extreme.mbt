///===
/// extcore/finance_time_extreme

pub(all) struct FinancetimeextremePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_extreme_make_point(x : Double, y : Double) -> FinancetimeextremePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_extreme_make_point3(x : Double, y : Double, z : Double) -> FinancetimeextremePoint {
  { x, y, z, label: 0 }
}

pub fn finance_time_extreme_point_x(pt : FinancetimeextremePoint) -> Double { pt.x }

pub fn finance_time_extreme_point_y(pt : FinancetimeextremePoint) -> Double { pt.y }

pub fn finance_time_extreme_point_z(pt : FinancetimeextremePoint) -> Double { pt.z }

pub fn finance_time_extreme_point_label(pt : FinancetimeextremePoint) -> Int { pt.label }

pub fn finance_time_extreme_point_dist(a : FinancetimeextremePoint, b : FinancetimeextremePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_time_extreme_point_add(a : FinancetimeextremePoint, b : FinancetimeextremePoint) -> FinancetimeextremePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_time_extreme_point_sub(a : FinancetimeextremePoint, b : FinancetimeextremePoint) -> FinancetimeextremePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_time_extreme_point_scale(pt : FinancetimeextremePoint, s : Double) -> FinancetimeextremePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_time_extreme_point_dot(a : FinancetimeextremePoint, b : FinancetimeextremePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_time_extreme_point_cross(a : FinancetimeextremePoint, b : FinancetimeextremePoint) -> FinancetimeextremePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_time_extreme_point_norm(pt : FinancetimeextremePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_time_extreme_point_normalize(pt : FinancetimeextremePoint) -> FinancetimeextremePoint {
  let n = finance_time_extreme_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_time_extreme_point_scale(pt, 1.0 / n) }
}

pub fn finance_time_extreme_point_negate(pt : FinancetimeextremePoint) -> FinancetimeextremePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_time_extreme_point_mid(a : FinancetimeextremePoint, b : FinancetimeextremePoint) -> FinancetimeextremePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_time_extreme_point_lerp(a : FinancetimeextremePoint, b : FinancetimeextremePoint, t : Double) -> FinancetimeextremePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_time_extreme_point_to_string(pt : FinancetimeextremePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancetimeextremeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_extreme_make_series(vals : Array[Double], name : String) -> FinancetimeextremeSeries {
  { vals, name, meta: 0 }
}

pub fn finance_time_extreme_series_len(s : FinancetimeextremeSeries) -> Int { s.vals.length() }

pub fn finance_time_extreme_series_sum(s : FinancetimeextremeSeries) -> Double { @_common.sum(s.vals) }

pub fn finance_time_extreme_series_mean(s : FinancetimeextremeSeries) -> Double { @_common.mean(s.vals) }

pub fn finance_time_extreme_series_min(s : FinancetimeextremeSeries) -> Double { @_common.min(s.vals) }

pub fn finance_time_extreme_series_max(s : FinancetimeextremeSeries) -> Double { @_common.max(s.vals) }

pub fn finance_time_extreme_series_range(s : FinancetimeextremeSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn finance_time_extreme_series_var(s : FinancetimeextremeSeries) -> Double { @_common.variance(s.vals) }

pub fn finance_time_extreme_series_std(s : FinancetimeextremeSeries) -> Double { @_common.std(s.vals) }

pub fn finance_time_extreme_series_median(s : FinancetimeextremeSeries) -> Double { @_common.median(s.vals) }

pub fn finance_time_extreme_series_scale(s : FinancetimeextremeSeries, f : Double) -> FinancetimeextremeSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_time_extreme_series_add(a : FinancetimeextremeSeries, b : FinancetimeextremeSeries) -> FinancetimeextremeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_time_extreme_series_sub(a : FinancetimeextremeSeries, b : FinancetimeextremeSeries) -> FinancetimeextremeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_time_extreme_series_normalize(s : FinancetimeextremeSeries) -> FinancetimeextremeSeries {
  let mn = finance_time_extreme_series_min(s)
  let mx = finance_time_extreme_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_time_extreme_series_cumsum(s : FinancetimeextremeSeries) -> FinancetimeextremeSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_time_extreme_series_to_string(s : FinancetimeextremeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimeextremeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_extreme_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimeextremeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_extreme_matrix_identity(n : Int) -> FinancetimeextremeMatrix {
  let m = finance_time_extreme_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_time_extreme_matrix_get(m : FinancetimeextremeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_time_extreme_matrix_transpose(m : FinancetimeextremeMatrix) -> FinancetimeextremeMatrix {
  let result = finance_time_extreme_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_time_extreme_matrix_add(a : FinancetimeextremeMatrix, b : FinancetimeextremeMatrix) -> FinancetimeextremeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_time_extreme_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_time_extreme_matrix_scale(m : FinancetimeextremeMatrix, s : Double) -> FinancetimeextremeMatrix {
  let result = finance_time_extreme_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_time_extreme_matrix_multiply(a : FinancetimeextremeMatrix, b : FinancetimeextremeMatrix) -> FinancetimeextremeMatrix {
  if a.cols != b.rows { return finance_time_extreme_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_time_extreme_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_time_extreme_matrix_trace(m : FinancetimeextremeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_time_extreme_matrix_det(m : FinancetimeextremeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_time_extreme_matrix_norm(m : FinancetimeextremeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_time_extreme_matrix_to_string(m : FinancetimeextremeMatrix) -> String {
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

pub(all) struct FinancetimeextremeVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_extreme_make_vector(comps : Array[Double]) -> FinancetimeextremeVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_extreme_vector_zero(dim : Int) -> FinancetimeextremeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_time_extreme_vector_add(a : FinancetimeextremeVector, b : FinancetimeextremeVector) -> FinancetimeextremeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_extreme_vector_sub(a : FinancetimeextremeVector, b : FinancetimeextremeVector) -> FinancetimeextremeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_extreme_vector_scale(v : FinancetimeextremeVector, s : Double) -> FinancetimeextremeVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_time_extreme_vector_dot(a : FinancetimeextremeVector, b : FinancetimeextremeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_time_extreme_vector_norm(v : FinancetimeextremeVector) -> Double { @_common.sqrt(finance_time_extreme_vector_dot(v, v)) }

pub fn finance_time_extreme_vector_normalize(v : FinancetimeextremeVector) -> FinancetimeextremeVector {
  let n = finance_time_extreme_vector_norm(v)
  if n < 0.0000001 { v } else { finance_time_extreme_vector_scale(v, 1.0 / n) }
}

pub fn finance_time_extreme_vector_dist(a : FinancetimeextremeVector, b : FinancetimeextremeVector) -> Double {
  finance_time_extreme_vector_norm(finance_time_extreme_vector_sub(a, b))
}

pub fn finance_time_extreme_vector_to_string(v : FinancetimeextremeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_time_extreme_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_time_extreme_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_time_extreme_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_time_extreme_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_time_extreme_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_time_extreme_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_time_extreme_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_time_extreme_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_time_extreme_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_time_extreme_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_time_extreme_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_time_extreme_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_time_extreme_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_time_extreme_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_time_extreme_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_time_extreme_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_time_extreme_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_time_extreme_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_time_extreme_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_time_extreme_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_time_extreme_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_time_extreme_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_time_extreme_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_time_extreme_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_time_extreme_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_time_extreme_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_time_extreme_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_time_extreme_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_time_extreme_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancetimeextremeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_frame_make(size : Int) -> FinancetimeextremeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_frame_len(s : FinancetimeextremeFrame) -> Int { s.size }

pub fn finance_time_extreme_frame_get(s : FinancetimeextremeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_frame_set(s : FinancetimeextremeFrame, i : Int, v : Double) -> FinancetimeextremeFrame {
  let result = finance_time_extreme_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_frame_sum(s : FinancetimeextremeFrame) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_frame_mean(s : FinancetimeextremeFrame) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_frame_scale(s : FinancetimeextremeFrame, f : Double) -> FinancetimeextremeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_frame_add(a : FinancetimeextremeFrame, b : FinancetimeextremeFrame) -> FinancetimeextremeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_frame_copy(s : FinancetimeextremeFrame) -> FinancetimeextremeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_frame_fill(s : FinancetimeextremeFrame, v : Double) -> FinancetimeextremeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_frame_min(s : FinancetimeextremeFrame) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_frame_max(s : FinancetimeextremeFrame) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_frame_to_string(s : FinancetimeextremeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_table_make(size : Int) -> FinancetimeextremeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_table_len(s : FinancetimeextremeTable) -> Int { s.size }

pub fn finance_time_extreme_table_get(s : FinancetimeextremeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_table_set(s : FinancetimeextremeTable, i : Int, v : Double) -> FinancetimeextremeTable {
  let result = finance_time_extreme_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_table_sum(s : FinancetimeextremeTable) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_table_mean(s : FinancetimeextremeTable) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_table_scale(s : FinancetimeextremeTable, f : Double) -> FinancetimeextremeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_table_add(a : FinancetimeextremeTable, b : FinancetimeextremeTable) -> FinancetimeextremeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_table_copy(s : FinancetimeextremeTable) -> FinancetimeextremeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_table_fill(s : FinancetimeextremeTable, v : Double) -> FinancetimeextremeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_table_min(s : FinancetimeextremeTable) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_table_max(s : FinancetimeextremeTable) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_table_to_string(s : FinancetimeextremeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_graphn_make(size : Int) -> FinancetimeextremeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_graphn_len(s : FinancetimeextremeGraphN) -> Int { s.size }

pub fn finance_time_extreme_graphn_get(s : FinancetimeextremeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_graphn_set(s : FinancetimeextremeGraphN, i : Int, v : Double) -> FinancetimeextremeGraphN {
  let result = finance_time_extreme_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_graphn_sum(s : FinancetimeextremeGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_graphn_mean(s : FinancetimeextremeGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_graphn_scale(s : FinancetimeextremeGraphN, f : Double) -> FinancetimeextremeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_graphn_add(a : FinancetimeextremeGraphN, b : FinancetimeextremeGraphN) -> FinancetimeextremeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_graphn_copy(s : FinancetimeextremeGraphN) -> FinancetimeextremeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_graphn_fill(s : FinancetimeextremeGraphN, v : Double) -> FinancetimeextremeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_graphn_min(s : FinancetimeextremeGraphN) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_graphn_max(s : FinancetimeextremeGraphN) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_graphn_to_string(s : FinancetimeextremeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_node_make(size : Int) -> FinancetimeextremeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_node_len(s : FinancetimeextremeNode) -> Int { s.size }

pub fn finance_time_extreme_node_get(s : FinancetimeextremeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_node_set(s : FinancetimeextremeNode, i : Int, v : Double) -> FinancetimeextremeNode {
  let result = finance_time_extreme_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_node_sum(s : FinancetimeextremeNode) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_node_mean(s : FinancetimeextremeNode) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_node_scale(s : FinancetimeextremeNode, f : Double) -> FinancetimeextremeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_node_add(a : FinancetimeextremeNode, b : FinancetimeextremeNode) -> FinancetimeextremeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_node_copy(s : FinancetimeextremeNode) -> FinancetimeextremeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_node_fill(s : FinancetimeextremeNode, v : Double) -> FinancetimeextremeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_node_min(s : FinancetimeextremeNode) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_node_max(s : FinancetimeextremeNode) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_node_to_string(s : FinancetimeextremeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_edge_make(size : Int) -> FinancetimeextremeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_edge_len(s : FinancetimeextremeEdge) -> Int { s.size }

pub fn finance_time_extreme_edge_get(s : FinancetimeextremeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_edge_set(s : FinancetimeextremeEdge, i : Int, v : Double) -> FinancetimeextremeEdge {
  let result = finance_time_extreme_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_edge_sum(s : FinancetimeextremeEdge) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_edge_mean(s : FinancetimeextremeEdge) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_edge_scale(s : FinancetimeextremeEdge, f : Double) -> FinancetimeextremeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_edge_add(a : FinancetimeextremeEdge, b : FinancetimeextremeEdge) -> FinancetimeextremeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_edge_copy(s : FinancetimeextremeEdge) -> FinancetimeextremeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_edge_fill(s : FinancetimeextremeEdge, v : Double) -> FinancetimeextremeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_edge_min(s : FinancetimeextremeEdge) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_edge_max(s : FinancetimeextremeEdge) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_edge_to_string(s : FinancetimeextremeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_path_make(size : Int) -> FinancetimeextremePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_path_len(s : FinancetimeextremePath) -> Int { s.size }

pub fn finance_time_extreme_path_get(s : FinancetimeextremePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_path_set(s : FinancetimeextremePath, i : Int, v : Double) -> FinancetimeextremePath {
  let result = finance_time_extreme_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_path_sum(s : FinancetimeextremePath) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_path_mean(s : FinancetimeextremePath) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_path_scale(s : FinancetimeextremePath, f : Double) -> FinancetimeextremePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_path_add(a : FinancetimeextremePath, b : FinancetimeextremePath) -> FinancetimeextremePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_path_copy(s : FinancetimeextremePath) -> FinancetimeextremePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_path_fill(s : FinancetimeextremePath, v : Double) -> FinancetimeextremePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_path_min(s : FinancetimeextremePath) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_path_max(s : FinancetimeextremePath) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_path_to_string(s : FinancetimeextremePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_cluster_make(size : Int) -> FinancetimeextremeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_cluster_len(s : FinancetimeextremeCluster) -> Int { s.size }

pub fn finance_time_extreme_cluster_get(s : FinancetimeextremeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_cluster_set(s : FinancetimeextremeCluster, i : Int, v : Double) -> FinancetimeextremeCluster {
  let result = finance_time_extreme_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_cluster_sum(s : FinancetimeextremeCluster) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_cluster_mean(s : FinancetimeextremeCluster) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_cluster_scale(s : FinancetimeextremeCluster, f : Double) -> FinancetimeextremeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_cluster_add(a : FinancetimeextremeCluster, b : FinancetimeextremeCluster) -> FinancetimeextremeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_cluster_copy(s : FinancetimeextremeCluster) -> FinancetimeextremeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_cluster_fill(s : FinancetimeextremeCluster, v : Double) -> FinancetimeextremeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_cluster_min(s : FinancetimeextremeCluster) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_cluster_max(s : FinancetimeextremeCluster) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_cluster_to_string(s : FinancetimeextremeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_model_make(size : Int) -> FinancetimeextremeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_model_len(s : FinancetimeextremeModel) -> Int { s.size }

pub fn finance_time_extreme_model_get(s : FinancetimeextremeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_model_set(s : FinancetimeextremeModel, i : Int, v : Double) -> FinancetimeextremeModel {
  let result = finance_time_extreme_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_model_sum(s : FinancetimeextremeModel) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_model_mean(s : FinancetimeextremeModel) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_model_scale(s : FinancetimeextremeModel, f : Double) -> FinancetimeextremeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_model_add(a : FinancetimeextremeModel, b : FinancetimeextremeModel) -> FinancetimeextremeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_model_copy(s : FinancetimeextremeModel) -> FinancetimeextremeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_model_fill(s : FinancetimeextremeModel, v : Double) -> FinancetimeextremeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_model_min(s : FinancetimeextremeModel) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_model_max(s : FinancetimeextremeModel) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_model_to_string(s : FinancetimeextremeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_layer_make(size : Int) -> FinancetimeextremeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_layer_len(s : FinancetimeextremeLayer) -> Int { s.size }

pub fn finance_time_extreme_layer_get(s : FinancetimeextremeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_layer_set(s : FinancetimeextremeLayer, i : Int, v : Double) -> FinancetimeextremeLayer {
  let result = finance_time_extreme_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_layer_sum(s : FinancetimeextremeLayer) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_layer_mean(s : FinancetimeextremeLayer) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_layer_scale(s : FinancetimeextremeLayer, f : Double) -> FinancetimeextremeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_layer_add(a : FinancetimeextremeLayer, b : FinancetimeextremeLayer) -> FinancetimeextremeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_layer_copy(s : FinancetimeextremeLayer) -> FinancetimeextremeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_layer_fill(s : FinancetimeextremeLayer, v : Double) -> FinancetimeextremeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_layer_min(s : FinancetimeextremeLayer) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_layer_max(s : FinancetimeextremeLayer) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_layer_to_string(s : FinancetimeextremeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_buffer_make(size : Int) -> FinancetimeextremeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_buffer_len(s : FinancetimeextremeBuffer) -> Int { s.size }

pub fn finance_time_extreme_buffer_get(s : FinancetimeextremeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_buffer_set(s : FinancetimeextremeBuffer, i : Int, v : Double) -> FinancetimeextremeBuffer {
  let result = finance_time_extreme_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_buffer_sum(s : FinancetimeextremeBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_buffer_mean(s : FinancetimeextremeBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_buffer_scale(s : FinancetimeextremeBuffer, f : Double) -> FinancetimeextremeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_buffer_add(a : FinancetimeextremeBuffer, b : FinancetimeextremeBuffer) -> FinancetimeextremeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_buffer_copy(s : FinancetimeextremeBuffer) -> FinancetimeextremeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_buffer_fill(s : FinancetimeextremeBuffer, v : Double) -> FinancetimeextremeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_buffer_min(s : FinancetimeextremeBuffer) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_buffer_max(s : FinancetimeextremeBuffer) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_buffer_to_string(s : FinancetimeextremeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_cursor_make(size : Int) -> FinancetimeextremeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_cursor_len(s : FinancetimeextremeCursor) -> Int { s.size }

pub fn finance_time_extreme_cursor_get(s : FinancetimeextremeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_cursor_set(s : FinancetimeextremeCursor, i : Int, v : Double) -> FinancetimeextremeCursor {
  let result = finance_time_extreme_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_cursor_sum(s : FinancetimeextremeCursor) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_cursor_mean(s : FinancetimeextremeCursor) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_cursor_scale(s : FinancetimeextremeCursor, f : Double) -> FinancetimeextremeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_cursor_add(a : FinancetimeextremeCursor, b : FinancetimeextremeCursor) -> FinancetimeextremeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_cursor_copy(s : FinancetimeextremeCursor) -> FinancetimeextremeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_cursor_fill(s : FinancetimeextremeCursor, v : Double) -> FinancetimeextremeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_cursor_min(s : FinancetimeextremeCursor) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_cursor_max(s : FinancetimeextremeCursor) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_cursor_to_string(s : FinancetimeextremeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_view_make(size : Int) -> FinancetimeextremeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_view_len(s : FinancetimeextremeView) -> Int { s.size }

pub fn finance_time_extreme_view_get(s : FinancetimeextremeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_view_set(s : FinancetimeextremeView, i : Int, v : Double) -> FinancetimeextremeView {
  let result = finance_time_extreme_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_view_sum(s : FinancetimeextremeView) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_view_mean(s : FinancetimeextremeView) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_view_scale(s : FinancetimeextremeView, f : Double) -> FinancetimeextremeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_view_add(a : FinancetimeextremeView, b : FinancetimeextremeView) -> FinancetimeextremeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_view_copy(s : FinancetimeextremeView) -> FinancetimeextremeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_view_fill(s : FinancetimeextremeView, v : Double) -> FinancetimeextremeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_view_min(s : FinancetimeextremeView) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_view_max(s : FinancetimeextremeView) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_view_to_string(s : FinancetimeextremeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_range_make(size : Int) -> FinancetimeextremeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_range_len(s : FinancetimeextremeRange) -> Int { s.size }

pub fn finance_time_extreme_range_get(s : FinancetimeextremeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_range_set(s : FinancetimeextremeRange, i : Int, v : Double) -> FinancetimeextremeRange {
  let result = finance_time_extreme_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_range_sum(s : FinancetimeextremeRange) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_range_mean(s : FinancetimeextremeRange) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_range_scale(s : FinancetimeextremeRange, f : Double) -> FinancetimeextremeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_range_add(a : FinancetimeextremeRange, b : FinancetimeextremeRange) -> FinancetimeextremeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_range_copy(s : FinancetimeextremeRange) -> FinancetimeextremeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_range_fill(s : FinancetimeextremeRange, v : Double) -> FinancetimeextremeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_range_min(s : FinancetimeextremeRange) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_range_max(s : FinancetimeextremeRange) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_range_to_string(s : FinancetimeextremeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_slice_make(size : Int) -> FinancetimeextremeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_slice_len(s : FinancetimeextremeSlice) -> Int { s.size }

pub fn finance_time_extreme_slice_get(s : FinancetimeextremeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_slice_set(s : FinancetimeextremeSlice, i : Int, v : Double) -> FinancetimeextremeSlice {
  let result = finance_time_extreme_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_extreme_slice_sum(s : FinancetimeextremeSlice) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_slice_mean(s : FinancetimeextremeSlice) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_slice_scale(s : FinancetimeextremeSlice, f : Double) -> FinancetimeextremeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_slice_add(a : FinancetimeextremeSlice, b : FinancetimeextremeSlice) -> FinancetimeextremeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_slice_copy(s : FinancetimeextremeSlice) -> FinancetimeextremeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_slice_fill(s : FinancetimeextremeSlice, v : Double) -> FinancetimeextremeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_slice_min(s : FinancetimeextremeSlice) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_slice_max(s : FinancetimeextremeSlice) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_slice_to_string(s : FinancetimeextremeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

