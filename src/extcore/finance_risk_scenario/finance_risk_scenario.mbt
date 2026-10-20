///===
/// extcore/finance_risk_scenario

pub(all) struct FinanceriskscenarioPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_scenario_make_point(x : Double, y : Double) -> FinanceriskscenarioPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_scenario_make_point3(x : Double, y : Double, z : Double) -> FinanceriskscenarioPoint {
  { x, y, z, label: 0 }
}

pub fn finance_risk_scenario_point_x(pt : FinanceriskscenarioPoint) -> Double { pt.x }

pub fn finance_risk_scenario_point_y(pt : FinanceriskscenarioPoint) -> Double { pt.y }

pub fn finance_risk_scenario_point_z(pt : FinanceriskscenarioPoint) -> Double { pt.z }

pub fn finance_risk_scenario_point_label(pt : FinanceriskscenarioPoint) -> Int { pt.label }

pub fn finance_risk_scenario_point_dist(a : FinanceriskscenarioPoint, b : FinanceriskscenarioPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_risk_scenario_point_add(a : FinanceriskscenarioPoint, b : FinanceriskscenarioPoint) -> FinanceriskscenarioPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_risk_scenario_point_sub(a : FinanceriskscenarioPoint, b : FinanceriskscenarioPoint) -> FinanceriskscenarioPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_risk_scenario_point_scale(pt : FinanceriskscenarioPoint, s : Double) -> FinanceriskscenarioPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_risk_scenario_point_dot(a : FinanceriskscenarioPoint, b : FinanceriskscenarioPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_risk_scenario_point_cross(a : FinanceriskscenarioPoint, b : FinanceriskscenarioPoint) -> FinanceriskscenarioPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_risk_scenario_point_norm(pt : FinanceriskscenarioPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_risk_scenario_point_normalize(pt : FinanceriskscenarioPoint) -> FinanceriskscenarioPoint {
  let n = finance_risk_scenario_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_risk_scenario_point_scale(pt, 1.0 / n) }
}

pub fn finance_risk_scenario_point_negate(pt : FinanceriskscenarioPoint) -> FinanceriskscenarioPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_risk_scenario_point_mid(a : FinanceriskscenarioPoint, b : FinanceriskscenarioPoint) -> FinanceriskscenarioPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_risk_scenario_point_lerp(a : FinanceriskscenarioPoint, b : FinanceriskscenarioPoint, t : Double) -> FinanceriskscenarioPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_risk_scenario_point_to_string(pt : FinanceriskscenarioPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinanceriskscenarioSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_scenario_make_series(vals : Array[Double], name : String) -> FinanceriskscenarioSeries {
  { vals, name, meta: 0 }
}

pub fn finance_risk_scenario_series_len(s : FinanceriskscenarioSeries) -> Int { s.vals.length() }

pub fn finance_risk_scenario_series_sum(s : FinanceriskscenarioSeries) -> Double { @_common.sum(s.vals) }

pub fn finance_risk_scenario_series_mean(s : FinanceriskscenarioSeries) -> Double { @_common.mean(s.vals) }

pub fn finance_risk_scenario_series_min(s : FinanceriskscenarioSeries) -> Double { @_common.min(s.vals) }

pub fn finance_risk_scenario_series_max(s : FinanceriskscenarioSeries) -> Double { @_common.max(s.vals) }

pub fn finance_risk_scenario_series_range(s : FinanceriskscenarioSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn finance_risk_scenario_series_var(s : FinanceriskscenarioSeries) -> Double { @_common.variance(s.vals) }

pub fn finance_risk_scenario_series_std(s : FinanceriskscenarioSeries) -> Double { @_common.std(s.vals) }

pub fn finance_risk_scenario_series_median(s : FinanceriskscenarioSeries) -> Double { @_common.median(s.vals) }

pub fn finance_risk_scenario_series_scale(s : FinanceriskscenarioSeries, f : Double) -> FinanceriskscenarioSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn finance_risk_scenario_series_add(a : FinanceriskscenarioSeries, b : FinanceriskscenarioSeries) -> FinanceriskscenarioSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_risk_scenario_series_sub(a : FinanceriskscenarioSeries, b : FinanceriskscenarioSeries) -> FinanceriskscenarioSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_risk_scenario_series_normalize(s : FinanceriskscenarioSeries) -> FinanceriskscenarioSeries {
  let mn = finance_risk_scenario_series_min(s)
  let mx = finance_risk_scenario_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_risk_scenario_series_cumsum(s : FinanceriskscenarioSeries) -> FinanceriskscenarioSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_risk_scenario_series_to_string(s : FinanceriskscenarioSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskscenarioMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_scenario_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskscenarioMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_risk_scenario_matrix_identity(n : Int) -> FinanceriskscenarioMatrix {
  let m = finance_risk_scenario_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_risk_scenario_matrix_get(m : FinanceriskscenarioMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_risk_scenario_matrix_transpose(m : FinanceriskscenarioMatrix) -> FinanceriskscenarioMatrix {
  let result = finance_risk_scenario_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_risk_scenario_matrix_add(a : FinanceriskscenarioMatrix, b : FinanceriskscenarioMatrix) -> FinanceriskscenarioMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_risk_scenario_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_risk_scenario_matrix_scale(m : FinanceriskscenarioMatrix, s : Double) -> FinanceriskscenarioMatrix {
  let result = finance_risk_scenario_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_risk_scenario_matrix_multiply(a : FinanceriskscenarioMatrix, b : FinanceriskscenarioMatrix) -> FinanceriskscenarioMatrix {
  if a.cols != b.rows { return finance_risk_scenario_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_risk_scenario_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_risk_scenario_matrix_trace(m : FinanceriskscenarioMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_risk_scenario_matrix_det(m : FinanceriskscenarioMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_risk_scenario_matrix_norm(m : FinanceriskscenarioMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_risk_scenario_matrix_to_string(m : FinanceriskscenarioMatrix) -> String {
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

pub(all) struct FinanceriskscenarioVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_scenario_make_vector(comps : Array[Double]) -> FinanceriskscenarioVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_scenario_vector_zero(dim : Int) -> FinanceriskscenarioVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_risk_scenario_vector_add(a : FinanceriskscenarioVector, b : FinanceriskscenarioVector) -> FinanceriskscenarioVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn finance_risk_scenario_vector_sub(a : FinanceriskscenarioVector, b : FinanceriskscenarioVector) -> FinanceriskscenarioVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn finance_risk_scenario_vector_scale(v : FinanceriskscenarioVector, s : Double) -> FinanceriskscenarioVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn finance_risk_scenario_vector_dot(a : FinanceriskscenarioVector, b : FinanceriskscenarioVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_risk_scenario_vector_norm(v : FinanceriskscenarioVector) -> Double { @_common.sqrt(finance_risk_scenario_vector_dot(v, v)) }

pub fn finance_risk_scenario_vector_normalize(v : FinanceriskscenarioVector) -> FinanceriskscenarioVector {
  let n = finance_risk_scenario_vector_norm(v)
  if n < 0.0000001 { v } else { finance_risk_scenario_vector_scale(v, 1.0 / n) }
}

pub fn finance_risk_scenario_vector_dist(a : FinanceriskscenarioVector, b : FinanceriskscenarioVector) -> Double {
  finance_risk_scenario_vector_norm(finance_risk_scenario_vector_sub(a, b))
}

pub fn finance_risk_scenario_vector_to_string(v : FinanceriskscenarioVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_risk_scenario_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_risk_scenario_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_risk_scenario_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_risk_scenario_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_risk_scenario_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_risk_scenario_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_risk_scenario_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_risk_scenario_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_risk_scenario_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_risk_scenario_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_risk_scenario_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_risk_scenario_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_risk_scenario_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_risk_scenario_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_risk_scenario_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_risk_scenario_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_risk_scenario_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_risk_scenario_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_risk_scenario_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_risk_scenario_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_risk_scenario_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_risk_scenario_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_risk_scenario_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_risk_scenario_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_risk_scenario_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_risk_scenario_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_risk_scenario_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_risk_scenario_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_risk_scenario_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceriskscenarioFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_frame_make(size : Int) -> FinanceriskscenarioFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_frame_len(s : FinanceriskscenarioFrame) -> Int { s.size }

pub fn finance_risk_scenario_frame_get(s : FinanceriskscenarioFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_frame_set(s : FinanceriskscenarioFrame, i : Int, v : Double) -> FinanceriskscenarioFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_frame_sum(s : FinanceriskscenarioFrame) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_frame_mean(s : FinanceriskscenarioFrame) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_frame_scale(s : FinanceriskscenarioFrame, f : Double) -> FinanceriskscenarioFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_frame_add(a : FinanceriskscenarioFrame, b : FinanceriskscenarioFrame) -> FinanceriskscenarioFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_frame_copy(s : FinanceriskscenarioFrame) -> FinanceriskscenarioFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_frame_fill(s : FinanceriskscenarioFrame, v : Double) -> FinanceriskscenarioFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_frame_min(s : FinanceriskscenarioFrame) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_frame_max(s : FinanceriskscenarioFrame) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_frame_to_string(s : FinanceriskscenarioFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_table_make(size : Int) -> FinanceriskscenarioTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_table_len(s : FinanceriskscenarioTable) -> Int { s.size }

pub fn finance_risk_scenario_table_get(s : FinanceriskscenarioTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_table_set(s : FinanceriskscenarioTable, i : Int, v : Double) -> FinanceriskscenarioTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_table_sum(s : FinanceriskscenarioTable) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_table_mean(s : FinanceriskscenarioTable) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_table_scale(s : FinanceriskscenarioTable, f : Double) -> FinanceriskscenarioTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_table_add(a : FinanceriskscenarioTable, b : FinanceriskscenarioTable) -> FinanceriskscenarioTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_table_copy(s : FinanceriskscenarioTable) -> FinanceriskscenarioTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_table_fill(s : FinanceriskscenarioTable, v : Double) -> FinanceriskscenarioTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_table_min(s : FinanceriskscenarioTable) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_table_max(s : FinanceriskscenarioTable) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_table_to_string(s : FinanceriskscenarioTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_graphn_make(size : Int) -> FinanceriskscenarioGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_graphn_len(s : FinanceriskscenarioGraphN) -> Int { s.size }

pub fn finance_risk_scenario_graphn_get(s : FinanceriskscenarioGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_graphn_set(s : FinanceriskscenarioGraphN, i : Int, v : Double) -> FinanceriskscenarioGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_graphn_sum(s : FinanceriskscenarioGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_graphn_mean(s : FinanceriskscenarioGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_graphn_scale(s : FinanceriskscenarioGraphN, f : Double) -> FinanceriskscenarioGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_graphn_add(a : FinanceriskscenarioGraphN, b : FinanceriskscenarioGraphN) -> FinanceriskscenarioGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_graphn_copy(s : FinanceriskscenarioGraphN) -> FinanceriskscenarioGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_graphn_fill(s : FinanceriskscenarioGraphN, v : Double) -> FinanceriskscenarioGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_graphn_min(s : FinanceriskscenarioGraphN) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_graphn_max(s : FinanceriskscenarioGraphN) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_graphn_to_string(s : FinanceriskscenarioGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_node_make(size : Int) -> FinanceriskscenarioNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_node_len(s : FinanceriskscenarioNode) -> Int { s.size }

pub fn finance_risk_scenario_node_get(s : FinanceriskscenarioNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_node_set(s : FinanceriskscenarioNode, i : Int, v : Double) -> FinanceriskscenarioNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_node_sum(s : FinanceriskscenarioNode) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_node_mean(s : FinanceriskscenarioNode) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_node_scale(s : FinanceriskscenarioNode, f : Double) -> FinanceriskscenarioNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_node_add(a : FinanceriskscenarioNode, b : FinanceriskscenarioNode) -> FinanceriskscenarioNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_node_copy(s : FinanceriskscenarioNode) -> FinanceriskscenarioNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_node_fill(s : FinanceriskscenarioNode, v : Double) -> FinanceriskscenarioNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_node_min(s : FinanceriskscenarioNode) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_node_max(s : FinanceriskscenarioNode) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_node_to_string(s : FinanceriskscenarioNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_edge_make(size : Int) -> FinanceriskscenarioEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_edge_len(s : FinanceriskscenarioEdge) -> Int { s.size }

pub fn finance_risk_scenario_edge_get(s : FinanceriskscenarioEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_edge_set(s : FinanceriskscenarioEdge, i : Int, v : Double) -> FinanceriskscenarioEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_edge_sum(s : FinanceriskscenarioEdge) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_edge_mean(s : FinanceriskscenarioEdge) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_edge_scale(s : FinanceriskscenarioEdge, f : Double) -> FinanceriskscenarioEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_edge_add(a : FinanceriskscenarioEdge, b : FinanceriskscenarioEdge) -> FinanceriskscenarioEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_edge_copy(s : FinanceriskscenarioEdge) -> FinanceriskscenarioEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_edge_fill(s : FinanceriskscenarioEdge, v : Double) -> FinanceriskscenarioEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_edge_min(s : FinanceriskscenarioEdge) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_edge_max(s : FinanceriskscenarioEdge) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_edge_to_string(s : FinanceriskscenarioEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_path_make(size : Int) -> FinanceriskscenarioPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_path_len(s : FinanceriskscenarioPath) -> Int { s.size }

pub fn finance_risk_scenario_path_get(s : FinanceriskscenarioPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_path_set(s : FinanceriskscenarioPath, i : Int, v : Double) -> FinanceriskscenarioPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_path_sum(s : FinanceriskscenarioPath) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_path_mean(s : FinanceriskscenarioPath) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_path_scale(s : FinanceriskscenarioPath, f : Double) -> FinanceriskscenarioPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_path_add(a : FinanceriskscenarioPath, b : FinanceriskscenarioPath) -> FinanceriskscenarioPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_path_copy(s : FinanceriskscenarioPath) -> FinanceriskscenarioPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_path_fill(s : FinanceriskscenarioPath, v : Double) -> FinanceriskscenarioPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_path_min(s : FinanceriskscenarioPath) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_path_max(s : FinanceriskscenarioPath) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_path_to_string(s : FinanceriskscenarioPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_cluster_make(size : Int) -> FinanceriskscenarioCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_cluster_len(s : FinanceriskscenarioCluster) -> Int { s.size }

pub fn finance_risk_scenario_cluster_get(s : FinanceriskscenarioCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_cluster_set(s : FinanceriskscenarioCluster, i : Int, v : Double) -> FinanceriskscenarioCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_cluster_sum(s : FinanceriskscenarioCluster) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_cluster_mean(s : FinanceriskscenarioCluster) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_cluster_scale(s : FinanceriskscenarioCluster, f : Double) -> FinanceriskscenarioCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_cluster_add(a : FinanceriskscenarioCluster, b : FinanceriskscenarioCluster) -> FinanceriskscenarioCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_cluster_copy(s : FinanceriskscenarioCluster) -> FinanceriskscenarioCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_cluster_fill(s : FinanceriskscenarioCluster, v : Double) -> FinanceriskscenarioCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_cluster_min(s : FinanceriskscenarioCluster) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_cluster_max(s : FinanceriskscenarioCluster) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_cluster_to_string(s : FinanceriskscenarioCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_model_make(size : Int) -> FinanceriskscenarioModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_model_len(s : FinanceriskscenarioModel) -> Int { s.size }

pub fn finance_risk_scenario_model_get(s : FinanceriskscenarioModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_model_set(s : FinanceriskscenarioModel, i : Int, v : Double) -> FinanceriskscenarioModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_model_sum(s : FinanceriskscenarioModel) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_model_mean(s : FinanceriskscenarioModel) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_model_scale(s : FinanceriskscenarioModel, f : Double) -> FinanceriskscenarioModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_model_add(a : FinanceriskscenarioModel, b : FinanceriskscenarioModel) -> FinanceriskscenarioModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_model_copy(s : FinanceriskscenarioModel) -> FinanceriskscenarioModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_model_fill(s : FinanceriskscenarioModel, v : Double) -> FinanceriskscenarioModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_model_min(s : FinanceriskscenarioModel) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_model_max(s : FinanceriskscenarioModel) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_model_to_string(s : FinanceriskscenarioModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_layer_make(size : Int) -> FinanceriskscenarioLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_layer_len(s : FinanceriskscenarioLayer) -> Int { s.size }

pub fn finance_risk_scenario_layer_get(s : FinanceriskscenarioLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_layer_set(s : FinanceriskscenarioLayer, i : Int, v : Double) -> FinanceriskscenarioLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_layer_sum(s : FinanceriskscenarioLayer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_layer_mean(s : FinanceriskscenarioLayer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_layer_scale(s : FinanceriskscenarioLayer, f : Double) -> FinanceriskscenarioLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_layer_add(a : FinanceriskscenarioLayer, b : FinanceriskscenarioLayer) -> FinanceriskscenarioLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_layer_copy(s : FinanceriskscenarioLayer) -> FinanceriskscenarioLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_layer_fill(s : FinanceriskscenarioLayer, v : Double) -> FinanceriskscenarioLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_layer_min(s : FinanceriskscenarioLayer) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_layer_max(s : FinanceriskscenarioLayer) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_layer_to_string(s : FinanceriskscenarioLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_buffer_make(size : Int) -> FinanceriskscenarioBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_buffer_len(s : FinanceriskscenarioBuffer) -> Int { s.size }

pub fn finance_risk_scenario_buffer_get(s : FinanceriskscenarioBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_buffer_set(s : FinanceriskscenarioBuffer, i : Int, v : Double) -> FinanceriskscenarioBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_buffer_sum(s : FinanceriskscenarioBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_buffer_mean(s : FinanceriskscenarioBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_buffer_scale(s : FinanceriskscenarioBuffer, f : Double) -> FinanceriskscenarioBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_buffer_add(a : FinanceriskscenarioBuffer, b : FinanceriskscenarioBuffer) -> FinanceriskscenarioBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_buffer_copy(s : FinanceriskscenarioBuffer) -> FinanceriskscenarioBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_buffer_fill(s : FinanceriskscenarioBuffer, v : Double) -> FinanceriskscenarioBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_buffer_min(s : FinanceriskscenarioBuffer) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_buffer_max(s : FinanceriskscenarioBuffer) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_buffer_to_string(s : FinanceriskscenarioBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_cursor_make(size : Int) -> FinanceriskscenarioCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_cursor_len(s : FinanceriskscenarioCursor) -> Int { s.size }

pub fn finance_risk_scenario_cursor_get(s : FinanceriskscenarioCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_cursor_set(s : FinanceriskscenarioCursor, i : Int, v : Double) -> FinanceriskscenarioCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_cursor_sum(s : FinanceriskscenarioCursor) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_cursor_mean(s : FinanceriskscenarioCursor) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_cursor_scale(s : FinanceriskscenarioCursor, f : Double) -> FinanceriskscenarioCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_cursor_add(a : FinanceriskscenarioCursor, b : FinanceriskscenarioCursor) -> FinanceriskscenarioCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_cursor_copy(s : FinanceriskscenarioCursor) -> FinanceriskscenarioCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_cursor_fill(s : FinanceriskscenarioCursor, v : Double) -> FinanceriskscenarioCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_cursor_min(s : FinanceriskscenarioCursor) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_cursor_max(s : FinanceriskscenarioCursor) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_cursor_to_string(s : FinanceriskscenarioCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_view_make(size : Int) -> FinanceriskscenarioView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_view_len(s : FinanceriskscenarioView) -> Int { s.size }

pub fn finance_risk_scenario_view_get(s : FinanceriskscenarioView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_view_set(s : FinanceriskscenarioView, i : Int, v : Double) -> FinanceriskscenarioView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_view_sum(s : FinanceriskscenarioView) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_view_mean(s : FinanceriskscenarioView) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_view_scale(s : FinanceriskscenarioView, f : Double) -> FinanceriskscenarioView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_view_add(a : FinanceriskscenarioView, b : FinanceriskscenarioView) -> FinanceriskscenarioView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_view_copy(s : FinanceriskscenarioView) -> FinanceriskscenarioView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_view_fill(s : FinanceriskscenarioView, v : Double) -> FinanceriskscenarioView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_view_min(s : FinanceriskscenarioView) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_view_max(s : FinanceriskscenarioView) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_view_to_string(s : FinanceriskscenarioView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_range_make(size : Int) -> FinanceriskscenarioRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_range_len(s : FinanceriskscenarioRange) -> Int { s.size }

pub fn finance_risk_scenario_range_get(s : FinanceriskscenarioRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_range_set(s : FinanceriskscenarioRange, i : Int, v : Double) -> FinanceriskscenarioRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_range_sum(s : FinanceriskscenarioRange) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_range_mean(s : FinanceriskscenarioRange) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_range_scale(s : FinanceriskscenarioRange, f : Double) -> FinanceriskscenarioRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_range_add(a : FinanceriskscenarioRange, b : FinanceriskscenarioRange) -> FinanceriskscenarioRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_range_copy(s : FinanceriskscenarioRange) -> FinanceriskscenarioRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_range_fill(s : FinanceriskscenarioRange, v : Double) -> FinanceriskscenarioRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_range_min(s : FinanceriskscenarioRange) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_range_max(s : FinanceriskscenarioRange) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_range_to_string(s : FinanceriskscenarioRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_slice_make(size : Int) -> FinanceriskscenarioSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_slice_len(s : FinanceriskscenarioSlice) -> Int { s.size }

pub fn finance_risk_scenario_slice_get(s : FinanceriskscenarioSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_slice_set(s : FinanceriskscenarioSlice, i : Int, v : Double) -> FinanceriskscenarioSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_slice_sum(s : FinanceriskscenarioSlice) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_slice_mean(s : FinanceriskscenarioSlice) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_slice_scale(s : FinanceriskscenarioSlice, f : Double) -> FinanceriskscenarioSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_slice_add(a : FinanceriskscenarioSlice, b : FinanceriskscenarioSlice) -> FinanceriskscenarioSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_slice_copy(s : FinanceriskscenarioSlice) -> FinanceriskscenarioSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_slice_fill(s : FinanceriskscenarioSlice, v : Double) -> FinanceriskscenarioSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_slice_min(s : FinanceriskscenarioSlice) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_slice_max(s : FinanceriskscenarioSlice) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_slice_to_string(s : FinanceriskscenarioSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

