///===
/// extcore/finance_risk_component

pub(all) struct FinanceriskcomponentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_component_make_point(x : Double, y : Double) -> FinanceriskcomponentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_component_make_point3(x : Double, y : Double, z : Double) -> FinanceriskcomponentPoint {
  { x, y, z, label: 0 }
}

pub fn finance_risk_component_point_x(pt : FinanceriskcomponentPoint) -> Double { pt.x }

pub fn finance_risk_component_point_y(pt : FinanceriskcomponentPoint) -> Double { pt.y }

pub fn finance_risk_component_point_z(pt : FinanceriskcomponentPoint) -> Double { pt.z }

pub fn finance_risk_component_point_label(pt : FinanceriskcomponentPoint) -> Int { pt.label }

pub fn finance_risk_component_point_dist(a : FinanceriskcomponentPoint, b : FinanceriskcomponentPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_risk_component_point_add(a : FinanceriskcomponentPoint, b : FinanceriskcomponentPoint) -> FinanceriskcomponentPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_risk_component_point_sub(a : FinanceriskcomponentPoint, b : FinanceriskcomponentPoint) -> FinanceriskcomponentPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_risk_component_point_scale(pt : FinanceriskcomponentPoint, s : Double) -> FinanceriskcomponentPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_risk_component_point_dot(a : FinanceriskcomponentPoint, b : FinanceriskcomponentPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_risk_component_point_cross(a : FinanceriskcomponentPoint, b : FinanceriskcomponentPoint) -> FinanceriskcomponentPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_risk_component_point_norm(pt : FinanceriskcomponentPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_risk_component_point_normalize(pt : FinanceriskcomponentPoint) -> FinanceriskcomponentPoint {
  let n = finance_risk_component_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_risk_component_point_scale(pt, 1.0 / n) }
}

pub fn finance_risk_component_point_negate(pt : FinanceriskcomponentPoint) -> FinanceriskcomponentPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_risk_component_point_mid(a : FinanceriskcomponentPoint, b : FinanceriskcomponentPoint) -> FinanceriskcomponentPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_risk_component_point_lerp(a : FinanceriskcomponentPoint, b : FinanceriskcomponentPoint, t : Double) -> FinanceriskcomponentPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_risk_component_point_to_string(pt : FinanceriskcomponentPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinanceriskcomponentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_component_make_series(vals : Array[Double], name : String) -> FinanceriskcomponentSeries {
  { vals, name, meta: 0 }
}

pub fn finance_risk_component_series_len(s : FinanceriskcomponentSeries) -> Int { s.vals.length() }

pub fn finance_risk_component_series_sum(s : FinanceriskcomponentSeries) -> Double { @_common.sum(s.vals) }

pub fn finance_risk_component_series_mean(s : FinanceriskcomponentSeries) -> Double { @_common.mean(s.vals) }

pub fn finance_risk_component_series_min(s : FinanceriskcomponentSeries) -> Double { @_common.min(s.vals) }

pub fn finance_risk_component_series_max(s : FinanceriskcomponentSeries) -> Double { @_common.max(s.vals) }

pub fn finance_risk_component_series_range(s : FinanceriskcomponentSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn finance_risk_component_series_var(s : FinanceriskcomponentSeries) -> Double { @_common.variance(s.vals) }

pub fn finance_risk_component_series_std(s : FinanceriskcomponentSeries) -> Double { @_common.std(s.vals) }

pub fn finance_risk_component_series_median(s : FinanceriskcomponentSeries) -> Double { @_common.median(s.vals) }

pub fn finance_risk_component_series_scale(s : FinanceriskcomponentSeries, f : Double) -> FinanceriskcomponentSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn finance_risk_component_series_add(a : FinanceriskcomponentSeries, b : FinanceriskcomponentSeries) -> FinanceriskcomponentSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_risk_component_series_sub(a : FinanceriskcomponentSeries, b : FinanceriskcomponentSeries) -> FinanceriskcomponentSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_risk_component_series_normalize(s : FinanceriskcomponentSeries) -> FinanceriskcomponentSeries {
  let mn = finance_risk_component_series_min(s)
  let mx = finance_risk_component_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_risk_component_series_cumsum(s : FinanceriskcomponentSeries) -> FinanceriskcomponentSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_risk_component_series_to_string(s : FinanceriskcomponentSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskcomponentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_component_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskcomponentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_risk_component_matrix_identity(n : Int) -> FinanceriskcomponentMatrix {
  let m = finance_risk_component_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_risk_component_matrix_get(m : FinanceriskcomponentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_risk_component_matrix_transpose(m : FinanceriskcomponentMatrix) -> FinanceriskcomponentMatrix {
  let result = finance_risk_component_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_risk_component_matrix_add(a : FinanceriskcomponentMatrix, b : FinanceriskcomponentMatrix) -> FinanceriskcomponentMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_risk_component_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_risk_component_matrix_scale(m : FinanceriskcomponentMatrix, s : Double) -> FinanceriskcomponentMatrix {
  let result = finance_risk_component_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_risk_component_matrix_multiply(a : FinanceriskcomponentMatrix, b : FinanceriskcomponentMatrix) -> FinanceriskcomponentMatrix {
  if a.cols != b.rows { return finance_risk_component_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_risk_component_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_risk_component_matrix_trace(m : FinanceriskcomponentMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_risk_component_matrix_det(m : FinanceriskcomponentMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_risk_component_matrix_norm(m : FinanceriskcomponentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_risk_component_matrix_to_string(m : FinanceriskcomponentMatrix) -> String {
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

pub(all) struct FinanceriskcomponentVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_component_make_vector(comps : Array[Double]) -> FinanceriskcomponentVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_component_vector_zero(dim : Int) -> FinanceriskcomponentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_risk_component_vector_add(a : FinanceriskcomponentVector, b : FinanceriskcomponentVector) -> FinanceriskcomponentVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn finance_risk_component_vector_sub(a : FinanceriskcomponentVector, b : FinanceriskcomponentVector) -> FinanceriskcomponentVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn finance_risk_component_vector_scale(v : FinanceriskcomponentVector, s : Double) -> FinanceriskcomponentVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn finance_risk_component_vector_dot(a : FinanceriskcomponentVector, b : FinanceriskcomponentVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_risk_component_vector_norm(v : FinanceriskcomponentVector) -> Double { @_common.sqrt(finance_risk_component_vector_dot(v, v)) }

pub fn finance_risk_component_vector_normalize(v : FinanceriskcomponentVector) -> FinanceriskcomponentVector {
  let n = finance_risk_component_vector_norm(v)
  if n < 0.0000001 { v } else { finance_risk_component_vector_scale(v, 1.0 / n) }
}

pub fn finance_risk_component_vector_dist(a : FinanceriskcomponentVector, b : FinanceriskcomponentVector) -> Double {
  finance_risk_component_vector_norm(finance_risk_component_vector_sub(a, b))
}

pub fn finance_risk_component_vector_to_string(v : FinanceriskcomponentVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_risk_component_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_risk_component_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_risk_component_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_risk_component_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_risk_component_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_risk_component_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_risk_component_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_risk_component_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_risk_component_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_risk_component_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_risk_component_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_risk_component_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_risk_component_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_risk_component_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_risk_component_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_risk_component_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_risk_component_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_risk_component_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_risk_component_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_risk_component_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_risk_component_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_risk_component_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_risk_component_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_risk_component_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_risk_component_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_risk_component_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_risk_component_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_risk_component_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_risk_component_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceriskcomponentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_frame_make(size : Int) -> FinanceriskcomponentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_frame_len(s : FinanceriskcomponentFrame) -> Int { s.size }

pub fn finance_risk_component_frame_get(s : FinanceriskcomponentFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_frame_set(s : FinanceriskcomponentFrame, i : Int, v : Double) -> FinanceriskcomponentFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_frame_sum(s : FinanceriskcomponentFrame) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_frame_mean(s : FinanceriskcomponentFrame) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_frame_scale(s : FinanceriskcomponentFrame, f : Double) -> FinanceriskcomponentFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_frame_add(a : FinanceriskcomponentFrame, b : FinanceriskcomponentFrame) -> FinanceriskcomponentFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_frame_copy(s : FinanceriskcomponentFrame) -> FinanceriskcomponentFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_frame_fill(s : FinanceriskcomponentFrame, v : Double) -> FinanceriskcomponentFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_frame_min(s : FinanceriskcomponentFrame) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_frame_max(s : FinanceriskcomponentFrame) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_frame_to_string(s : FinanceriskcomponentFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_table_make(size : Int) -> FinanceriskcomponentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_table_len(s : FinanceriskcomponentTable) -> Int { s.size }

pub fn finance_risk_component_table_get(s : FinanceriskcomponentTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_table_set(s : FinanceriskcomponentTable, i : Int, v : Double) -> FinanceriskcomponentTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_table_sum(s : FinanceriskcomponentTable) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_table_mean(s : FinanceriskcomponentTable) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_table_scale(s : FinanceriskcomponentTable, f : Double) -> FinanceriskcomponentTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_table_add(a : FinanceriskcomponentTable, b : FinanceriskcomponentTable) -> FinanceriskcomponentTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_table_copy(s : FinanceriskcomponentTable) -> FinanceriskcomponentTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_table_fill(s : FinanceriskcomponentTable, v : Double) -> FinanceriskcomponentTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_table_min(s : FinanceriskcomponentTable) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_table_max(s : FinanceriskcomponentTable) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_table_to_string(s : FinanceriskcomponentTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_graphn_make(size : Int) -> FinanceriskcomponentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_graphn_len(s : FinanceriskcomponentGraphN) -> Int { s.size }

pub fn finance_risk_component_graphn_get(s : FinanceriskcomponentGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_graphn_set(s : FinanceriskcomponentGraphN, i : Int, v : Double) -> FinanceriskcomponentGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_graphn_sum(s : FinanceriskcomponentGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_graphn_mean(s : FinanceriskcomponentGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_graphn_scale(s : FinanceriskcomponentGraphN, f : Double) -> FinanceriskcomponentGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_graphn_add(a : FinanceriskcomponentGraphN, b : FinanceriskcomponentGraphN) -> FinanceriskcomponentGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_graphn_copy(s : FinanceriskcomponentGraphN) -> FinanceriskcomponentGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_graphn_fill(s : FinanceriskcomponentGraphN, v : Double) -> FinanceriskcomponentGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_graphn_min(s : FinanceriskcomponentGraphN) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_graphn_max(s : FinanceriskcomponentGraphN) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_graphn_to_string(s : FinanceriskcomponentGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_node_make(size : Int) -> FinanceriskcomponentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_node_len(s : FinanceriskcomponentNode) -> Int { s.size }

pub fn finance_risk_component_node_get(s : FinanceriskcomponentNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_node_set(s : FinanceriskcomponentNode, i : Int, v : Double) -> FinanceriskcomponentNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_node_sum(s : FinanceriskcomponentNode) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_node_mean(s : FinanceriskcomponentNode) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_node_scale(s : FinanceriskcomponentNode, f : Double) -> FinanceriskcomponentNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_node_add(a : FinanceriskcomponentNode, b : FinanceriskcomponentNode) -> FinanceriskcomponentNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_node_copy(s : FinanceriskcomponentNode) -> FinanceriskcomponentNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_node_fill(s : FinanceriskcomponentNode, v : Double) -> FinanceriskcomponentNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_node_min(s : FinanceriskcomponentNode) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_node_max(s : FinanceriskcomponentNode) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_node_to_string(s : FinanceriskcomponentNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_edge_make(size : Int) -> FinanceriskcomponentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_edge_len(s : FinanceriskcomponentEdge) -> Int { s.size }

pub fn finance_risk_component_edge_get(s : FinanceriskcomponentEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_edge_set(s : FinanceriskcomponentEdge, i : Int, v : Double) -> FinanceriskcomponentEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_edge_sum(s : FinanceriskcomponentEdge) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_edge_mean(s : FinanceriskcomponentEdge) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_edge_scale(s : FinanceriskcomponentEdge, f : Double) -> FinanceriskcomponentEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_edge_add(a : FinanceriskcomponentEdge, b : FinanceriskcomponentEdge) -> FinanceriskcomponentEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_edge_copy(s : FinanceriskcomponentEdge) -> FinanceriskcomponentEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_edge_fill(s : FinanceriskcomponentEdge, v : Double) -> FinanceriskcomponentEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_edge_min(s : FinanceriskcomponentEdge) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_edge_max(s : FinanceriskcomponentEdge) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_edge_to_string(s : FinanceriskcomponentEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_path_make(size : Int) -> FinanceriskcomponentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_path_len(s : FinanceriskcomponentPath) -> Int { s.size }

pub fn finance_risk_component_path_get(s : FinanceriskcomponentPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_path_set(s : FinanceriskcomponentPath, i : Int, v : Double) -> FinanceriskcomponentPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_path_sum(s : FinanceriskcomponentPath) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_path_mean(s : FinanceriskcomponentPath) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_path_scale(s : FinanceriskcomponentPath, f : Double) -> FinanceriskcomponentPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_path_add(a : FinanceriskcomponentPath, b : FinanceriskcomponentPath) -> FinanceriskcomponentPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_path_copy(s : FinanceriskcomponentPath) -> FinanceriskcomponentPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_path_fill(s : FinanceriskcomponentPath, v : Double) -> FinanceriskcomponentPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_path_min(s : FinanceriskcomponentPath) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_path_max(s : FinanceriskcomponentPath) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_path_to_string(s : FinanceriskcomponentPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_cluster_make(size : Int) -> FinanceriskcomponentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_cluster_len(s : FinanceriskcomponentCluster) -> Int { s.size }

pub fn finance_risk_component_cluster_get(s : FinanceriskcomponentCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_cluster_set(s : FinanceriskcomponentCluster, i : Int, v : Double) -> FinanceriskcomponentCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_cluster_sum(s : FinanceriskcomponentCluster) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_cluster_mean(s : FinanceriskcomponentCluster) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_cluster_scale(s : FinanceriskcomponentCluster, f : Double) -> FinanceriskcomponentCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_cluster_add(a : FinanceriskcomponentCluster, b : FinanceriskcomponentCluster) -> FinanceriskcomponentCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_cluster_copy(s : FinanceriskcomponentCluster) -> FinanceriskcomponentCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_cluster_fill(s : FinanceriskcomponentCluster, v : Double) -> FinanceriskcomponentCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_cluster_min(s : FinanceriskcomponentCluster) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_cluster_max(s : FinanceriskcomponentCluster) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_cluster_to_string(s : FinanceriskcomponentCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_model_make(size : Int) -> FinanceriskcomponentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_model_len(s : FinanceriskcomponentModel) -> Int { s.size }

pub fn finance_risk_component_model_get(s : FinanceriskcomponentModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_model_set(s : FinanceriskcomponentModel, i : Int, v : Double) -> FinanceriskcomponentModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_model_sum(s : FinanceriskcomponentModel) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_model_mean(s : FinanceriskcomponentModel) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_model_scale(s : FinanceriskcomponentModel, f : Double) -> FinanceriskcomponentModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_model_add(a : FinanceriskcomponentModel, b : FinanceriskcomponentModel) -> FinanceriskcomponentModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_model_copy(s : FinanceriskcomponentModel) -> FinanceriskcomponentModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_model_fill(s : FinanceriskcomponentModel, v : Double) -> FinanceriskcomponentModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_model_min(s : FinanceriskcomponentModel) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_model_max(s : FinanceriskcomponentModel) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_model_to_string(s : FinanceriskcomponentModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_layer_make(size : Int) -> FinanceriskcomponentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_layer_len(s : FinanceriskcomponentLayer) -> Int { s.size }

pub fn finance_risk_component_layer_get(s : FinanceriskcomponentLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_layer_set(s : FinanceriskcomponentLayer, i : Int, v : Double) -> FinanceriskcomponentLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_layer_sum(s : FinanceriskcomponentLayer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_layer_mean(s : FinanceriskcomponentLayer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_layer_scale(s : FinanceriskcomponentLayer, f : Double) -> FinanceriskcomponentLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_layer_add(a : FinanceriskcomponentLayer, b : FinanceriskcomponentLayer) -> FinanceriskcomponentLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_layer_copy(s : FinanceriskcomponentLayer) -> FinanceriskcomponentLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_layer_fill(s : FinanceriskcomponentLayer, v : Double) -> FinanceriskcomponentLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_layer_min(s : FinanceriskcomponentLayer) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_layer_max(s : FinanceriskcomponentLayer) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_layer_to_string(s : FinanceriskcomponentLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_buffer_make(size : Int) -> FinanceriskcomponentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_buffer_len(s : FinanceriskcomponentBuffer) -> Int { s.size }

pub fn finance_risk_component_buffer_get(s : FinanceriskcomponentBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_buffer_set(s : FinanceriskcomponentBuffer, i : Int, v : Double) -> FinanceriskcomponentBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_buffer_sum(s : FinanceriskcomponentBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_buffer_mean(s : FinanceriskcomponentBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_buffer_scale(s : FinanceriskcomponentBuffer, f : Double) -> FinanceriskcomponentBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_buffer_add(a : FinanceriskcomponentBuffer, b : FinanceriskcomponentBuffer) -> FinanceriskcomponentBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_buffer_copy(s : FinanceriskcomponentBuffer) -> FinanceriskcomponentBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_buffer_fill(s : FinanceriskcomponentBuffer, v : Double) -> FinanceriskcomponentBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_buffer_min(s : FinanceriskcomponentBuffer) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_buffer_max(s : FinanceriskcomponentBuffer) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_buffer_to_string(s : FinanceriskcomponentBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_cursor_make(size : Int) -> FinanceriskcomponentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_cursor_len(s : FinanceriskcomponentCursor) -> Int { s.size }

pub fn finance_risk_component_cursor_get(s : FinanceriskcomponentCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_cursor_set(s : FinanceriskcomponentCursor, i : Int, v : Double) -> FinanceriskcomponentCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_cursor_sum(s : FinanceriskcomponentCursor) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_cursor_mean(s : FinanceriskcomponentCursor) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_cursor_scale(s : FinanceriskcomponentCursor, f : Double) -> FinanceriskcomponentCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_cursor_add(a : FinanceriskcomponentCursor, b : FinanceriskcomponentCursor) -> FinanceriskcomponentCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_cursor_copy(s : FinanceriskcomponentCursor) -> FinanceriskcomponentCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_cursor_fill(s : FinanceriskcomponentCursor, v : Double) -> FinanceriskcomponentCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_cursor_min(s : FinanceriskcomponentCursor) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_cursor_max(s : FinanceriskcomponentCursor) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_cursor_to_string(s : FinanceriskcomponentCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_view_make(size : Int) -> FinanceriskcomponentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_view_len(s : FinanceriskcomponentView) -> Int { s.size }

pub fn finance_risk_component_view_get(s : FinanceriskcomponentView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_view_set(s : FinanceriskcomponentView, i : Int, v : Double) -> FinanceriskcomponentView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_view_sum(s : FinanceriskcomponentView) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_view_mean(s : FinanceriskcomponentView) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_view_scale(s : FinanceriskcomponentView, f : Double) -> FinanceriskcomponentView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_view_add(a : FinanceriskcomponentView, b : FinanceriskcomponentView) -> FinanceriskcomponentView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_view_copy(s : FinanceriskcomponentView) -> FinanceriskcomponentView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_view_fill(s : FinanceriskcomponentView, v : Double) -> FinanceriskcomponentView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_view_min(s : FinanceriskcomponentView) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_view_max(s : FinanceriskcomponentView) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_view_to_string(s : FinanceriskcomponentView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_range_make(size : Int) -> FinanceriskcomponentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_range_len(s : FinanceriskcomponentRange) -> Int { s.size }

pub fn finance_risk_component_range_get(s : FinanceriskcomponentRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_range_set(s : FinanceriskcomponentRange, i : Int, v : Double) -> FinanceriskcomponentRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_range_sum(s : FinanceriskcomponentRange) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_range_mean(s : FinanceriskcomponentRange) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_range_scale(s : FinanceriskcomponentRange, f : Double) -> FinanceriskcomponentRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_range_add(a : FinanceriskcomponentRange, b : FinanceriskcomponentRange) -> FinanceriskcomponentRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_range_copy(s : FinanceriskcomponentRange) -> FinanceriskcomponentRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_range_fill(s : FinanceriskcomponentRange, v : Double) -> FinanceriskcomponentRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_range_min(s : FinanceriskcomponentRange) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_range_max(s : FinanceriskcomponentRange) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_range_to_string(s : FinanceriskcomponentRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_slice_make(size : Int) -> FinanceriskcomponentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_slice_len(s : FinanceriskcomponentSlice) -> Int { s.size }

pub fn finance_risk_component_slice_get(s : FinanceriskcomponentSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_slice_set(s : FinanceriskcomponentSlice, i : Int, v : Double) -> FinanceriskcomponentSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_slice_sum(s : FinanceriskcomponentSlice) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_slice_mean(s : FinanceriskcomponentSlice) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_slice_scale(s : FinanceriskcomponentSlice, f : Double) -> FinanceriskcomponentSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_slice_add(a : FinanceriskcomponentSlice, b : FinanceriskcomponentSlice) -> FinanceriskcomponentSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_slice_copy(s : FinanceriskcomponentSlice) -> FinanceriskcomponentSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_slice_fill(s : FinanceriskcomponentSlice, v : Double) -> FinanceriskcomponentSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_slice_min(s : FinanceriskcomponentSlice) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_slice_max(s : FinanceriskcomponentSlice) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_slice_to_string(s : FinanceriskcomponentSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

