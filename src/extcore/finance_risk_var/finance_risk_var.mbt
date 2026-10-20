///===
/// extcore/finance_risk_var

pub(all) struct FinanceriskvarPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_var_make_point(x : Double, y : Double) -> FinanceriskvarPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_var_make_point3(x : Double, y : Double, z : Double) -> FinanceriskvarPoint {
  { x, y, z, label: 0 }
}

pub fn finance_risk_var_point_x(pt : FinanceriskvarPoint) -> Double { pt.x }

pub fn finance_risk_var_point_y(pt : FinanceriskvarPoint) -> Double { pt.y }

pub fn finance_risk_var_point_z(pt : FinanceriskvarPoint) -> Double { pt.z }

pub fn finance_risk_var_point_label(pt : FinanceriskvarPoint) -> Int { pt.label }

pub fn finance_risk_var_point_dist(a : FinanceriskvarPoint, b : FinanceriskvarPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_risk_var_point_add(a : FinanceriskvarPoint, b : FinanceriskvarPoint) -> FinanceriskvarPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_risk_var_point_sub(a : FinanceriskvarPoint, b : FinanceriskvarPoint) -> FinanceriskvarPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_risk_var_point_scale(pt : FinanceriskvarPoint, s : Double) -> FinanceriskvarPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_risk_var_point_dot(a : FinanceriskvarPoint, b : FinanceriskvarPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_risk_var_point_cross(a : FinanceriskvarPoint, b : FinanceriskvarPoint) -> FinanceriskvarPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_risk_var_point_norm(pt : FinanceriskvarPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_risk_var_point_normalize(pt : FinanceriskvarPoint) -> FinanceriskvarPoint {
  let n = finance_risk_var_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_risk_var_point_scale(pt, 1.0 / n) }
}

pub fn finance_risk_var_point_negate(pt : FinanceriskvarPoint) -> FinanceriskvarPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_risk_var_point_mid(a : FinanceriskvarPoint, b : FinanceriskvarPoint) -> FinanceriskvarPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_risk_var_point_lerp(a : FinanceriskvarPoint, b : FinanceriskvarPoint, t : Double) -> FinanceriskvarPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_risk_var_point_to_string(pt : FinanceriskvarPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinanceriskvarSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_var_make_series(vals : Array[Double], name : String) -> FinanceriskvarSeries {
  { vals, name, meta: 0 }
}

pub fn finance_risk_var_series_len(s : FinanceriskvarSeries) -> Int { s.vals.length() }

pub fn finance_risk_var_series_sum(s : FinanceriskvarSeries) -> Double { @_common.sum(s.vals) }

pub fn finance_risk_var_series_mean(s : FinanceriskvarSeries) -> Double { @_common.mean(s.vals) }

pub fn finance_risk_var_series_min(s : FinanceriskvarSeries) -> Double { @_common.min(s.vals) }

pub fn finance_risk_var_series_max(s : FinanceriskvarSeries) -> Double { @_common.max(s.vals) }

pub fn finance_risk_var_series_range(s : FinanceriskvarSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn finance_risk_var_series_var(s : FinanceriskvarSeries) -> Double { @_common.variance(s.vals) }

pub fn finance_risk_var_series_std(s : FinanceriskvarSeries) -> Double { @_common.std(s.vals) }

pub fn finance_risk_var_series_median(s : FinanceriskvarSeries) -> Double { @_common.median(s.vals) }

pub fn finance_risk_var_series_scale(s : FinanceriskvarSeries, f : Double) -> FinanceriskvarSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn finance_risk_var_series_add(a : FinanceriskvarSeries, b : FinanceriskvarSeries) -> FinanceriskvarSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_risk_var_series_sub(a : FinanceriskvarSeries, b : FinanceriskvarSeries) -> FinanceriskvarSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_risk_var_series_normalize(s : FinanceriskvarSeries) -> FinanceriskvarSeries {
  let mn = finance_risk_var_series_min(s)
  let mx = finance_risk_var_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_risk_var_series_cumsum(s : FinanceriskvarSeries) -> FinanceriskvarSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_risk_var_series_to_string(s : FinanceriskvarSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskvarMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_var_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskvarMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_risk_var_matrix_identity(n : Int) -> FinanceriskvarMatrix {
  let m = finance_risk_var_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_risk_var_matrix_get(m : FinanceriskvarMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_risk_var_matrix_transpose(m : FinanceriskvarMatrix) -> FinanceriskvarMatrix {
  let result = finance_risk_var_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_risk_var_matrix_add(a : FinanceriskvarMatrix, b : FinanceriskvarMatrix) -> FinanceriskvarMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_risk_var_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_risk_var_matrix_scale(m : FinanceriskvarMatrix, s : Double) -> FinanceriskvarMatrix {
  let result = finance_risk_var_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_risk_var_matrix_multiply(a : FinanceriskvarMatrix, b : FinanceriskvarMatrix) -> FinanceriskvarMatrix {
  if a.cols != b.rows { return finance_risk_var_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_risk_var_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_risk_var_matrix_trace(m : FinanceriskvarMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_risk_var_matrix_det(m : FinanceriskvarMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_risk_var_matrix_norm(m : FinanceriskvarMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_risk_var_matrix_to_string(m : FinanceriskvarMatrix) -> String {
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

pub(all) struct FinanceriskvarVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_var_make_vector(comps : Array[Double]) -> FinanceriskvarVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_var_vector_zero(dim : Int) -> FinanceriskvarVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_risk_var_vector_add(a : FinanceriskvarVector, b : FinanceriskvarVector) -> FinanceriskvarVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn finance_risk_var_vector_sub(a : FinanceriskvarVector, b : FinanceriskvarVector) -> FinanceriskvarVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn finance_risk_var_vector_scale(v : FinanceriskvarVector, s : Double) -> FinanceriskvarVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn finance_risk_var_vector_dot(a : FinanceriskvarVector, b : FinanceriskvarVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_risk_var_vector_norm(v : FinanceriskvarVector) -> Double { @_common.sqrt(finance_risk_var_vector_dot(v, v)) }

pub fn finance_risk_var_vector_normalize(v : FinanceriskvarVector) -> FinanceriskvarVector {
  let n = finance_risk_var_vector_norm(v)
  if n < 0.0000001 { v } else { finance_risk_var_vector_scale(v, 1.0 / n) }
}

pub fn finance_risk_var_vector_dist(a : FinanceriskvarVector, b : FinanceriskvarVector) -> Double {
  finance_risk_var_vector_norm(finance_risk_var_vector_sub(a, b))
}

pub fn finance_risk_var_vector_to_string(v : FinanceriskvarVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_risk_var_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_risk_var_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_risk_var_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_risk_var_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_risk_var_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_risk_var_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_risk_var_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_risk_var_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_risk_var_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_risk_var_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_risk_var_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_risk_var_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_risk_var_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_risk_var_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_risk_var_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_risk_var_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_risk_var_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_risk_var_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_risk_var_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_risk_var_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_risk_var_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_risk_var_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_risk_var_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_risk_var_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_risk_var_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_risk_var_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_risk_var_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_risk_var_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_risk_var_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceriskvarFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_frame_make(size : Int) -> FinanceriskvarFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_frame_len(s : FinanceriskvarFrame) -> Int { s.size }

pub fn finance_risk_var_frame_get(s : FinanceriskvarFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_frame_set(s : FinanceriskvarFrame, i : Int, v : Double) -> FinanceriskvarFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_frame_sum(s : FinanceriskvarFrame) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_frame_mean(s : FinanceriskvarFrame) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_frame_scale(s : FinanceriskvarFrame, f : Double) -> FinanceriskvarFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_frame_add(a : FinanceriskvarFrame, b : FinanceriskvarFrame) -> FinanceriskvarFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_frame_copy(s : FinanceriskvarFrame) -> FinanceriskvarFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_frame_fill(s : FinanceriskvarFrame, v : Double) -> FinanceriskvarFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_frame_min(s : FinanceriskvarFrame) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_frame_max(s : FinanceriskvarFrame) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_frame_to_string(s : FinanceriskvarFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_table_make(size : Int) -> FinanceriskvarTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_table_len(s : FinanceriskvarTable) -> Int { s.size }

pub fn finance_risk_var_table_get(s : FinanceriskvarTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_table_set(s : FinanceriskvarTable, i : Int, v : Double) -> FinanceriskvarTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_table_sum(s : FinanceriskvarTable) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_table_mean(s : FinanceriskvarTable) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_table_scale(s : FinanceriskvarTable, f : Double) -> FinanceriskvarTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_table_add(a : FinanceriskvarTable, b : FinanceriskvarTable) -> FinanceriskvarTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_table_copy(s : FinanceriskvarTable) -> FinanceriskvarTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_table_fill(s : FinanceriskvarTable, v : Double) -> FinanceriskvarTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_table_min(s : FinanceriskvarTable) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_table_max(s : FinanceriskvarTable) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_table_to_string(s : FinanceriskvarTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_graphn_make(size : Int) -> FinanceriskvarGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_graphn_len(s : FinanceriskvarGraphN) -> Int { s.size }

pub fn finance_risk_var_graphn_get(s : FinanceriskvarGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_graphn_set(s : FinanceriskvarGraphN, i : Int, v : Double) -> FinanceriskvarGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_graphn_sum(s : FinanceriskvarGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_graphn_mean(s : FinanceriskvarGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_graphn_scale(s : FinanceriskvarGraphN, f : Double) -> FinanceriskvarGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_graphn_add(a : FinanceriskvarGraphN, b : FinanceriskvarGraphN) -> FinanceriskvarGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_graphn_copy(s : FinanceriskvarGraphN) -> FinanceriskvarGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_graphn_fill(s : FinanceriskvarGraphN, v : Double) -> FinanceriskvarGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_graphn_min(s : FinanceriskvarGraphN) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_graphn_max(s : FinanceriskvarGraphN) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_graphn_to_string(s : FinanceriskvarGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_node_make(size : Int) -> FinanceriskvarNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_node_len(s : FinanceriskvarNode) -> Int { s.size }

pub fn finance_risk_var_node_get(s : FinanceriskvarNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_node_set(s : FinanceriskvarNode, i : Int, v : Double) -> FinanceriskvarNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_node_sum(s : FinanceriskvarNode) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_node_mean(s : FinanceriskvarNode) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_node_scale(s : FinanceriskvarNode, f : Double) -> FinanceriskvarNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_node_add(a : FinanceriskvarNode, b : FinanceriskvarNode) -> FinanceriskvarNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_node_copy(s : FinanceriskvarNode) -> FinanceriskvarNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_node_fill(s : FinanceriskvarNode, v : Double) -> FinanceriskvarNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_node_min(s : FinanceriskvarNode) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_node_max(s : FinanceriskvarNode) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_node_to_string(s : FinanceriskvarNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_edge_make(size : Int) -> FinanceriskvarEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_edge_len(s : FinanceriskvarEdge) -> Int { s.size }

pub fn finance_risk_var_edge_get(s : FinanceriskvarEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_edge_set(s : FinanceriskvarEdge, i : Int, v : Double) -> FinanceriskvarEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_edge_sum(s : FinanceriskvarEdge) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_edge_mean(s : FinanceriskvarEdge) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_edge_scale(s : FinanceriskvarEdge, f : Double) -> FinanceriskvarEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_edge_add(a : FinanceriskvarEdge, b : FinanceriskvarEdge) -> FinanceriskvarEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_edge_copy(s : FinanceriskvarEdge) -> FinanceriskvarEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_edge_fill(s : FinanceriskvarEdge, v : Double) -> FinanceriskvarEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_edge_min(s : FinanceriskvarEdge) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_edge_max(s : FinanceriskvarEdge) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_edge_to_string(s : FinanceriskvarEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_path_make(size : Int) -> FinanceriskvarPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_path_len(s : FinanceriskvarPath) -> Int { s.size }

pub fn finance_risk_var_path_get(s : FinanceriskvarPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_path_set(s : FinanceriskvarPath, i : Int, v : Double) -> FinanceriskvarPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_path_sum(s : FinanceriskvarPath) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_path_mean(s : FinanceriskvarPath) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_path_scale(s : FinanceriskvarPath, f : Double) -> FinanceriskvarPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_path_add(a : FinanceriskvarPath, b : FinanceriskvarPath) -> FinanceriskvarPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_path_copy(s : FinanceriskvarPath) -> FinanceriskvarPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_path_fill(s : FinanceriskvarPath, v : Double) -> FinanceriskvarPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_path_min(s : FinanceriskvarPath) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_path_max(s : FinanceriskvarPath) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_path_to_string(s : FinanceriskvarPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_cluster_make(size : Int) -> FinanceriskvarCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_cluster_len(s : FinanceriskvarCluster) -> Int { s.size }

pub fn finance_risk_var_cluster_get(s : FinanceriskvarCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_cluster_set(s : FinanceriskvarCluster, i : Int, v : Double) -> FinanceriskvarCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_cluster_sum(s : FinanceriskvarCluster) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_cluster_mean(s : FinanceriskvarCluster) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_cluster_scale(s : FinanceriskvarCluster, f : Double) -> FinanceriskvarCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_cluster_add(a : FinanceriskvarCluster, b : FinanceriskvarCluster) -> FinanceriskvarCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_cluster_copy(s : FinanceriskvarCluster) -> FinanceriskvarCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_cluster_fill(s : FinanceriskvarCluster, v : Double) -> FinanceriskvarCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_cluster_min(s : FinanceriskvarCluster) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_cluster_max(s : FinanceriskvarCluster) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_cluster_to_string(s : FinanceriskvarCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_model_make(size : Int) -> FinanceriskvarModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_model_len(s : FinanceriskvarModel) -> Int { s.size }

pub fn finance_risk_var_model_get(s : FinanceriskvarModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_model_set(s : FinanceriskvarModel, i : Int, v : Double) -> FinanceriskvarModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_model_sum(s : FinanceriskvarModel) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_model_mean(s : FinanceriskvarModel) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_model_scale(s : FinanceriskvarModel, f : Double) -> FinanceriskvarModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_model_add(a : FinanceriskvarModel, b : FinanceriskvarModel) -> FinanceriskvarModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_model_copy(s : FinanceriskvarModel) -> FinanceriskvarModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_model_fill(s : FinanceriskvarModel, v : Double) -> FinanceriskvarModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_model_min(s : FinanceriskvarModel) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_model_max(s : FinanceriskvarModel) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_model_to_string(s : FinanceriskvarModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_layer_make(size : Int) -> FinanceriskvarLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_layer_len(s : FinanceriskvarLayer) -> Int { s.size }

pub fn finance_risk_var_layer_get(s : FinanceriskvarLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_layer_set(s : FinanceriskvarLayer, i : Int, v : Double) -> FinanceriskvarLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_layer_sum(s : FinanceriskvarLayer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_layer_mean(s : FinanceriskvarLayer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_layer_scale(s : FinanceriskvarLayer, f : Double) -> FinanceriskvarLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_layer_add(a : FinanceriskvarLayer, b : FinanceriskvarLayer) -> FinanceriskvarLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_layer_copy(s : FinanceriskvarLayer) -> FinanceriskvarLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_layer_fill(s : FinanceriskvarLayer, v : Double) -> FinanceriskvarLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_layer_min(s : FinanceriskvarLayer) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_layer_max(s : FinanceriskvarLayer) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_layer_to_string(s : FinanceriskvarLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_buffer_make(size : Int) -> FinanceriskvarBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_buffer_len(s : FinanceriskvarBuffer) -> Int { s.size }

pub fn finance_risk_var_buffer_get(s : FinanceriskvarBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_buffer_set(s : FinanceriskvarBuffer, i : Int, v : Double) -> FinanceriskvarBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_buffer_sum(s : FinanceriskvarBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_buffer_mean(s : FinanceriskvarBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_buffer_scale(s : FinanceriskvarBuffer, f : Double) -> FinanceriskvarBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_buffer_add(a : FinanceriskvarBuffer, b : FinanceriskvarBuffer) -> FinanceriskvarBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_buffer_copy(s : FinanceriskvarBuffer) -> FinanceriskvarBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_buffer_fill(s : FinanceriskvarBuffer, v : Double) -> FinanceriskvarBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_buffer_min(s : FinanceriskvarBuffer) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_buffer_max(s : FinanceriskvarBuffer) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_buffer_to_string(s : FinanceriskvarBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_cursor_make(size : Int) -> FinanceriskvarCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_cursor_len(s : FinanceriskvarCursor) -> Int { s.size }

pub fn finance_risk_var_cursor_get(s : FinanceriskvarCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_cursor_set(s : FinanceriskvarCursor, i : Int, v : Double) -> FinanceriskvarCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_cursor_sum(s : FinanceriskvarCursor) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_cursor_mean(s : FinanceriskvarCursor) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_cursor_scale(s : FinanceriskvarCursor, f : Double) -> FinanceriskvarCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_cursor_add(a : FinanceriskvarCursor, b : FinanceriskvarCursor) -> FinanceriskvarCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_cursor_copy(s : FinanceriskvarCursor) -> FinanceriskvarCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_cursor_fill(s : FinanceriskvarCursor, v : Double) -> FinanceriskvarCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_cursor_min(s : FinanceriskvarCursor) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_cursor_max(s : FinanceriskvarCursor) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_cursor_to_string(s : FinanceriskvarCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_view_make(size : Int) -> FinanceriskvarView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_view_len(s : FinanceriskvarView) -> Int { s.size }

pub fn finance_risk_var_view_get(s : FinanceriskvarView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_view_set(s : FinanceriskvarView, i : Int, v : Double) -> FinanceriskvarView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_view_sum(s : FinanceriskvarView) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_view_mean(s : FinanceriskvarView) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_view_scale(s : FinanceriskvarView, f : Double) -> FinanceriskvarView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_view_add(a : FinanceriskvarView, b : FinanceriskvarView) -> FinanceriskvarView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_view_copy(s : FinanceriskvarView) -> FinanceriskvarView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_view_fill(s : FinanceriskvarView, v : Double) -> FinanceriskvarView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_view_min(s : FinanceriskvarView) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_view_max(s : FinanceriskvarView) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_view_to_string(s : FinanceriskvarView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_range_make(size : Int) -> FinanceriskvarRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_range_len(s : FinanceriskvarRange) -> Int { s.size }

pub fn finance_risk_var_range_get(s : FinanceriskvarRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_range_set(s : FinanceriskvarRange, i : Int, v : Double) -> FinanceriskvarRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_range_sum(s : FinanceriskvarRange) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_range_mean(s : FinanceriskvarRange) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_range_scale(s : FinanceriskvarRange, f : Double) -> FinanceriskvarRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_range_add(a : FinanceriskvarRange, b : FinanceriskvarRange) -> FinanceriskvarRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_range_copy(s : FinanceriskvarRange) -> FinanceriskvarRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_range_fill(s : FinanceriskvarRange, v : Double) -> FinanceriskvarRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_range_min(s : FinanceriskvarRange) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_range_max(s : FinanceriskvarRange) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_range_to_string(s : FinanceriskvarRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_slice_make(size : Int) -> FinanceriskvarSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_slice_len(s : FinanceriskvarSlice) -> Int { s.size }

pub fn finance_risk_var_slice_get(s : FinanceriskvarSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_slice_set(s : FinanceriskvarSlice, i : Int, v : Double) -> FinanceriskvarSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_slice_sum(s : FinanceriskvarSlice) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_slice_mean(s : FinanceriskvarSlice) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_slice_scale(s : FinanceriskvarSlice, f : Double) -> FinanceriskvarSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_slice_add(a : FinanceriskvarSlice, b : FinanceriskvarSlice) -> FinanceriskvarSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_slice_copy(s : FinanceriskvarSlice) -> FinanceriskvarSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_slice_fill(s : FinanceriskvarSlice, v : Double) -> FinanceriskvarSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_slice_min(s : FinanceriskvarSlice) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_slice_max(s : FinanceriskvarSlice) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_slice_to_string(s : FinanceriskvarSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

