///===
/// extcore/finance_portfolio_risk_parity

pub(all) struct FinanceportfolioriskparityPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_portfolio_risk_parity_make_point(x : Double, y : Double) -> FinanceportfolioriskparityPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_portfolio_risk_parity_make_point3(x : Double, y : Double, z : Double) -> FinanceportfolioriskparityPoint {
  { x, y, z, label: 0 }
}

pub fn finance_portfolio_risk_parity_point_x(pt : FinanceportfolioriskparityPoint) -> Double { pt.x }

pub fn finance_portfolio_risk_parity_point_y(pt : FinanceportfolioriskparityPoint) -> Double { pt.y }

pub fn finance_portfolio_risk_parity_point_z(pt : FinanceportfolioriskparityPoint) -> Double { pt.z }

pub fn finance_portfolio_risk_parity_point_label(pt : FinanceportfolioriskparityPoint) -> Int { pt.label }

pub fn finance_portfolio_risk_parity_point_dist(a : FinanceportfolioriskparityPoint, b : FinanceportfolioriskparityPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_portfolio_risk_parity_point_add(a : FinanceportfolioriskparityPoint, b : FinanceportfolioriskparityPoint) -> FinanceportfolioriskparityPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_portfolio_risk_parity_point_sub(a : FinanceportfolioriskparityPoint, b : FinanceportfolioriskparityPoint) -> FinanceportfolioriskparityPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_portfolio_risk_parity_point_scale(pt : FinanceportfolioriskparityPoint, s : Double) -> FinanceportfolioriskparityPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_portfolio_risk_parity_point_dot(a : FinanceportfolioriskparityPoint, b : FinanceportfolioriskparityPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_portfolio_risk_parity_point_cross(a : FinanceportfolioriskparityPoint, b : FinanceportfolioriskparityPoint) -> FinanceportfolioriskparityPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_portfolio_risk_parity_point_norm(pt : FinanceportfolioriskparityPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_portfolio_risk_parity_point_normalize(pt : FinanceportfolioriskparityPoint) -> FinanceportfolioriskparityPoint {
  let n = finance_portfolio_risk_parity_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_portfolio_risk_parity_point_scale(pt, 1.0 / n) }
}

pub fn finance_portfolio_risk_parity_point_negate(pt : FinanceportfolioriskparityPoint) -> FinanceportfolioriskparityPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_portfolio_risk_parity_point_mid(a : FinanceportfolioriskparityPoint, b : FinanceportfolioriskparityPoint) -> FinanceportfolioriskparityPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_portfolio_risk_parity_point_lerp(a : FinanceportfolioriskparityPoint, b : FinanceportfolioriskparityPoint, t : Double) -> FinanceportfolioriskparityPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_portfolio_risk_parity_point_to_string(pt : FinanceportfolioriskparityPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparitySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_portfolio_risk_parity_make_series(vals : Array[Double], name : String) -> FinanceportfolioriskparitySeries {
  { vals, name, meta: 0 }
}

pub fn finance_portfolio_risk_parity_series_len(s : FinanceportfolioriskparitySeries) -> Int { s.vals.length() }

pub fn finance_portfolio_risk_parity_series_sum(s : FinanceportfolioriskparitySeries) -> Double { @_common.sum(s.vals) }

pub fn finance_portfolio_risk_parity_series_mean(s : FinanceportfolioriskparitySeries) -> Double { @_common.mean(s.vals) }

pub fn finance_portfolio_risk_parity_series_min(s : FinanceportfolioriskparitySeries) -> Double { @_common.min(s.vals) }

pub fn finance_portfolio_risk_parity_series_max(s : FinanceportfolioriskparitySeries) -> Double { @_common.max(s.vals) }

pub fn finance_portfolio_risk_parity_series_range(s : FinanceportfolioriskparitySeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn finance_portfolio_risk_parity_series_var(s : FinanceportfolioriskparitySeries) -> Double { @_common.variance(s.vals) }

pub fn finance_portfolio_risk_parity_series_std(s : FinanceportfolioriskparitySeries) -> Double { @_common.std(s.vals) }

pub fn finance_portfolio_risk_parity_series_median(s : FinanceportfolioriskparitySeries) -> Double { @_common.median(s.vals) }

pub fn finance_portfolio_risk_parity_series_scale(s : FinanceportfolioriskparitySeries, f : Double) -> FinanceportfolioriskparitySeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn finance_portfolio_risk_parity_series_add(a : FinanceportfolioriskparitySeries, b : FinanceportfolioriskparitySeries) -> FinanceportfolioriskparitySeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_portfolio_risk_parity_series_sub(a : FinanceportfolioriskparitySeries, b : FinanceportfolioriskparitySeries) -> FinanceportfolioriskparitySeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_portfolio_risk_parity_series_normalize(s : FinanceportfolioriskparitySeries) -> FinanceportfolioriskparitySeries {
  let mn = finance_portfolio_risk_parity_series_min(s)
  let mx = finance_portfolio_risk_parity_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_portfolio_risk_parity_series_cumsum(s : FinanceportfolioriskparitySeries) -> FinanceportfolioriskparitySeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_portfolio_risk_parity_series_to_string(s : FinanceportfolioriskparitySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfolioriskparityMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_portfolio_risk_parity_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceportfolioriskparityMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_portfolio_risk_parity_matrix_identity(n : Int) -> FinanceportfolioriskparityMatrix {
  let m = finance_portfolio_risk_parity_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_portfolio_risk_parity_matrix_get(m : FinanceportfolioriskparityMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_portfolio_risk_parity_matrix_transpose(m : FinanceportfolioriskparityMatrix) -> FinanceportfolioriskparityMatrix {
  let result = finance_portfolio_risk_parity_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_portfolio_risk_parity_matrix_add(a : FinanceportfolioriskparityMatrix, b : FinanceportfolioriskparityMatrix) -> FinanceportfolioriskparityMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_portfolio_risk_parity_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_portfolio_risk_parity_matrix_scale(m : FinanceportfolioriskparityMatrix, s : Double) -> FinanceportfolioriskparityMatrix {
  let result = finance_portfolio_risk_parity_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_portfolio_risk_parity_matrix_multiply(a : FinanceportfolioriskparityMatrix, b : FinanceportfolioriskparityMatrix) -> FinanceportfolioriskparityMatrix {
  if a.cols != b.rows { return finance_portfolio_risk_parity_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_portfolio_risk_parity_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_portfolio_risk_parity_matrix_trace(m : FinanceportfolioriskparityMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_portfolio_risk_parity_matrix_det(m : FinanceportfolioriskparityMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_portfolio_risk_parity_matrix_norm(m : FinanceportfolioriskparityMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_portfolio_risk_parity_matrix_to_string(m : FinanceportfolioriskparityMatrix) -> String {
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

pub(all) struct FinanceportfolioriskparityVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_portfolio_risk_parity_make_vector(comps : Array[Double]) -> FinanceportfolioriskparityVector {
  { comps, dim: comps.length() }
}

pub fn finance_portfolio_risk_parity_vector_zero(dim : Int) -> FinanceportfolioriskparityVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_portfolio_risk_parity_vector_add(a : FinanceportfolioriskparityVector, b : FinanceportfolioriskparityVector) -> FinanceportfolioriskparityVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn finance_portfolio_risk_parity_vector_sub(a : FinanceportfolioriskparityVector, b : FinanceportfolioriskparityVector) -> FinanceportfolioriskparityVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn finance_portfolio_risk_parity_vector_scale(v : FinanceportfolioriskparityVector, s : Double) -> FinanceportfolioriskparityVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn finance_portfolio_risk_parity_vector_dot(a : FinanceportfolioriskparityVector, b : FinanceportfolioriskparityVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_portfolio_risk_parity_vector_norm(v : FinanceportfolioriskparityVector) -> Double { @_common.sqrt(finance_portfolio_risk_parity_vector_dot(v, v)) }

pub fn finance_portfolio_risk_parity_vector_normalize(v : FinanceportfolioriskparityVector) -> FinanceportfolioriskparityVector {
  let n = finance_portfolio_risk_parity_vector_norm(v)
  if n < 0.0000001 { v } else { finance_portfolio_risk_parity_vector_scale(v, 1.0 / n) }
}

pub fn finance_portfolio_risk_parity_vector_dist(a : FinanceportfolioriskparityVector, b : FinanceportfolioriskparityVector) -> Double {
  finance_portfolio_risk_parity_vector_norm(finance_portfolio_risk_parity_vector_sub(a, b))
}

pub fn finance_portfolio_risk_parity_vector_to_string(v : FinanceportfolioriskparityVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_portfolio_risk_parity_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_portfolio_risk_parity_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_portfolio_risk_parity_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_portfolio_risk_parity_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_portfolio_risk_parity_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_portfolio_risk_parity_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_portfolio_risk_parity_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_portfolio_risk_parity_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_portfolio_risk_parity_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_portfolio_risk_parity_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_portfolio_risk_parity_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_portfolio_risk_parity_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_portfolio_risk_parity_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_portfolio_risk_parity_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_portfolio_risk_parity_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_portfolio_risk_parity_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_portfolio_risk_parity_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_portfolio_risk_parity_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_portfolio_risk_parity_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_portfolio_risk_parity_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_portfolio_risk_parity_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_portfolio_risk_parity_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_portfolio_risk_parity_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_portfolio_risk_parity_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_portfolio_risk_parity_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_portfolio_risk_parity_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_portfolio_risk_parity_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_portfolio_risk_parity_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_portfolio_risk_parity_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceportfolioriskparityFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_frame_make(size : Int) -> FinanceportfolioriskparityFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_frame_len(s : FinanceportfolioriskparityFrame) -> Int { s.size }

pub fn finance_portfolio_risk_parity_frame_get(s : FinanceportfolioriskparityFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_frame_set(s : FinanceportfolioriskparityFrame, i : Int, v : Double) -> FinanceportfolioriskparityFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_frame_sum(s : FinanceportfolioriskparityFrame) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_frame_mean(s : FinanceportfolioriskparityFrame) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_frame_scale(s : FinanceportfolioriskparityFrame, f : Double) -> FinanceportfolioriskparityFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_frame_add(a : FinanceportfolioriskparityFrame, b : FinanceportfolioriskparityFrame) -> FinanceportfolioriskparityFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_frame_copy(s : FinanceportfolioriskparityFrame) -> FinanceportfolioriskparityFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_frame_fill(s : FinanceportfolioriskparityFrame, v : Double) -> FinanceportfolioriskparityFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_frame_min(s : FinanceportfolioriskparityFrame) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_frame_max(s : FinanceportfolioriskparityFrame) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_frame_to_string(s : FinanceportfolioriskparityFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_table_make(size : Int) -> FinanceportfolioriskparityTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_table_len(s : FinanceportfolioriskparityTable) -> Int { s.size }

pub fn finance_portfolio_risk_parity_table_get(s : FinanceportfolioriskparityTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_table_set(s : FinanceportfolioriskparityTable, i : Int, v : Double) -> FinanceportfolioriskparityTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_table_sum(s : FinanceportfolioriskparityTable) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_table_mean(s : FinanceportfolioriskparityTable) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_table_scale(s : FinanceportfolioriskparityTable, f : Double) -> FinanceportfolioriskparityTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_table_add(a : FinanceportfolioriskparityTable, b : FinanceportfolioriskparityTable) -> FinanceportfolioriskparityTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_table_copy(s : FinanceportfolioriskparityTable) -> FinanceportfolioriskparityTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_table_fill(s : FinanceportfolioriskparityTable, v : Double) -> FinanceportfolioriskparityTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_table_min(s : FinanceportfolioriskparityTable) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_table_max(s : FinanceportfolioriskparityTable) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_table_to_string(s : FinanceportfolioriskparityTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_graphn_make(size : Int) -> FinanceportfolioriskparityGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_graphn_len(s : FinanceportfolioriskparityGraphN) -> Int { s.size }

pub fn finance_portfolio_risk_parity_graphn_get(s : FinanceportfolioriskparityGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_graphn_set(s : FinanceportfolioriskparityGraphN, i : Int, v : Double) -> FinanceportfolioriskparityGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_graphn_sum(s : FinanceportfolioriskparityGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_graphn_mean(s : FinanceportfolioriskparityGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_graphn_scale(s : FinanceportfolioriskparityGraphN, f : Double) -> FinanceportfolioriskparityGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_graphn_add(a : FinanceportfolioriskparityGraphN, b : FinanceportfolioriskparityGraphN) -> FinanceportfolioriskparityGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_graphn_copy(s : FinanceportfolioriskparityGraphN) -> FinanceportfolioriskparityGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_graphn_fill(s : FinanceportfolioriskparityGraphN, v : Double) -> FinanceportfolioriskparityGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_graphn_min(s : FinanceportfolioriskparityGraphN) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_graphn_max(s : FinanceportfolioriskparityGraphN) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_graphn_to_string(s : FinanceportfolioriskparityGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_node_make(size : Int) -> FinanceportfolioriskparityNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_node_len(s : FinanceportfolioriskparityNode) -> Int { s.size }

pub fn finance_portfolio_risk_parity_node_get(s : FinanceportfolioriskparityNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_node_set(s : FinanceportfolioriskparityNode, i : Int, v : Double) -> FinanceportfolioriskparityNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_node_sum(s : FinanceportfolioriskparityNode) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_node_mean(s : FinanceportfolioriskparityNode) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_node_scale(s : FinanceportfolioriskparityNode, f : Double) -> FinanceportfolioriskparityNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_node_add(a : FinanceportfolioriskparityNode, b : FinanceportfolioriskparityNode) -> FinanceportfolioriskparityNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_node_copy(s : FinanceportfolioriskparityNode) -> FinanceportfolioriskparityNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_node_fill(s : FinanceportfolioriskparityNode, v : Double) -> FinanceportfolioriskparityNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_node_min(s : FinanceportfolioriskparityNode) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_node_max(s : FinanceportfolioriskparityNode) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_node_to_string(s : FinanceportfolioriskparityNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_edge_make(size : Int) -> FinanceportfolioriskparityEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_edge_len(s : FinanceportfolioriskparityEdge) -> Int { s.size }

pub fn finance_portfolio_risk_parity_edge_get(s : FinanceportfolioriskparityEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_edge_set(s : FinanceportfolioriskparityEdge, i : Int, v : Double) -> FinanceportfolioriskparityEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_edge_sum(s : FinanceportfolioriskparityEdge) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_edge_mean(s : FinanceportfolioriskparityEdge) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_edge_scale(s : FinanceportfolioriskparityEdge, f : Double) -> FinanceportfolioriskparityEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_edge_add(a : FinanceportfolioriskparityEdge, b : FinanceportfolioriskparityEdge) -> FinanceportfolioriskparityEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_edge_copy(s : FinanceportfolioriskparityEdge) -> FinanceportfolioriskparityEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_edge_fill(s : FinanceportfolioriskparityEdge, v : Double) -> FinanceportfolioriskparityEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_edge_min(s : FinanceportfolioriskparityEdge) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_edge_max(s : FinanceportfolioriskparityEdge) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_edge_to_string(s : FinanceportfolioriskparityEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_path_make(size : Int) -> FinanceportfolioriskparityPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_path_len(s : FinanceportfolioriskparityPath) -> Int { s.size }

pub fn finance_portfolio_risk_parity_path_get(s : FinanceportfolioriskparityPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_path_set(s : FinanceportfolioriskparityPath, i : Int, v : Double) -> FinanceportfolioriskparityPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_path_sum(s : FinanceportfolioriskparityPath) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_path_mean(s : FinanceportfolioriskparityPath) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_path_scale(s : FinanceportfolioriskparityPath, f : Double) -> FinanceportfolioriskparityPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_path_add(a : FinanceportfolioriskparityPath, b : FinanceportfolioriskparityPath) -> FinanceportfolioriskparityPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_path_copy(s : FinanceportfolioriskparityPath) -> FinanceportfolioriskparityPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_path_fill(s : FinanceportfolioriskparityPath, v : Double) -> FinanceportfolioriskparityPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_path_min(s : FinanceportfolioriskparityPath) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_path_max(s : FinanceportfolioriskparityPath) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_path_to_string(s : FinanceportfolioriskparityPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_cluster_make(size : Int) -> FinanceportfolioriskparityCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_cluster_len(s : FinanceportfolioriskparityCluster) -> Int { s.size }

pub fn finance_portfolio_risk_parity_cluster_get(s : FinanceportfolioriskparityCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_cluster_set(s : FinanceportfolioriskparityCluster, i : Int, v : Double) -> FinanceportfolioriskparityCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_cluster_sum(s : FinanceportfolioriskparityCluster) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_cluster_mean(s : FinanceportfolioriskparityCluster) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_cluster_scale(s : FinanceportfolioriskparityCluster, f : Double) -> FinanceportfolioriskparityCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_cluster_add(a : FinanceportfolioriskparityCluster, b : FinanceportfolioriskparityCluster) -> FinanceportfolioriskparityCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_cluster_copy(s : FinanceportfolioriskparityCluster) -> FinanceportfolioriskparityCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_cluster_fill(s : FinanceportfolioriskparityCluster, v : Double) -> FinanceportfolioriskparityCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_cluster_min(s : FinanceportfolioriskparityCluster) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_cluster_max(s : FinanceportfolioriskparityCluster) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_cluster_to_string(s : FinanceportfolioriskparityCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_model_make(size : Int) -> FinanceportfolioriskparityModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_model_len(s : FinanceportfolioriskparityModel) -> Int { s.size }

pub fn finance_portfolio_risk_parity_model_get(s : FinanceportfolioriskparityModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_model_set(s : FinanceportfolioriskparityModel, i : Int, v : Double) -> FinanceportfolioriskparityModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_model_sum(s : FinanceportfolioriskparityModel) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_model_mean(s : FinanceportfolioriskparityModel) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_model_scale(s : FinanceportfolioriskparityModel, f : Double) -> FinanceportfolioriskparityModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_model_add(a : FinanceportfolioriskparityModel, b : FinanceportfolioriskparityModel) -> FinanceportfolioriskparityModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_model_copy(s : FinanceportfolioriskparityModel) -> FinanceportfolioriskparityModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_model_fill(s : FinanceportfolioriskparityModel, v : Double) -> FinanceportfolioriskparityModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_model_min(s : FinanceportfolioriskparityModel) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_model_max(s : FinanceportfolioriskparityModel) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_model_to_string(s : FinanceportfolioriskparityModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_layer_make(size : Int) -> FinanceportfolioriskparityLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_layer_len(s : FinanceportfolioriskparityLayer) -> Int { s.size }

pub fn finance_portfolio_risk_parity_layer_get(s : FinanceportfolioriskparityLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_layer_set(s : FinanceportfolioriskparityLayer, i : Int, v : Double) -> FinanceportfolioriskparityLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_layer_sum(s : FinanceportfolioriskparityLayer) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_layer_mean(s : FinanceportfolioriskparityLayer) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_layer_scale(s : FinanceportfolioriskparityLayer, f : Double) -> FinanceportfolioriskparityLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_layer_add(a : FinanceportfolioriskparityLayer, b : FinanceportfolioriskparityLayer) -> FinanceportfolioriskparityLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_layer_copy(s : FinanceportfolioriskparityLayer) -> FinanceportfolioriskparityLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_layer_fill(s : FinanceportfolioriskparityLayer, v : Double) -> FinanceportfolioriskparityLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_layer_min(s : FinanceportfolioriskparityLayer) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_layer_max(s : FinanceportfolioriskparityLayer) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_layer_to_string(s : FinanceportfolioriskparityLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_buffer_make(size : Int) -> FinanceportfolioriskparityBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_buffer_len(s : FinanceportfolioriskparityBuffer) -> Int { s.size }

pub fn finance_portfolio_risk_parity_buffer_get(s : FinanceportfolioriskparityBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_buffer_set(s : FinanceportfolioriskparityBuffer, i : Int, v : Double) -> FinanceportfolioriskparityBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_buffer_sum(s : FinanceportfolioriskparityBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_buffer_mean(s : FinanceportfolioriskparityBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_buffer_scale(s : FinanceportfolioriskparityBuffer, f : Double) -> FinanceportfolioriskparityBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_buffer_add(a : FinanceportfolioriskparityBuffer, b : FinanceportfolioriskparityBuffer) -> FinanceportfolioriskparityBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_buffer_copy(s : FinanceportfolioriskparityBuffer) -> FinanceportfolioriskparityBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_buffer_fill(s : FinanceportfolioriskparityBuffer, v : Double) -> FinanceportfolioriskparityBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_buffer_min(s : FinanceportfolioriskparityBuffer) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_buffer_max(s : FinanceportfolioriskparityBuffer) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_buffer_to_string(s : FinanceportfolioriskparityBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_cursor_make(size : Int) -> FinanceportfolioriskparityCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_cursor_len(s : FinanceportfolioriskparityCursor) -> Int { s.size }

pub fn finance_portfolio_risk_parity_cursor_get(s : FinanceportfolioriskparityCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_cursor_set(s : FinanceportfolioriskparityCursor, i : Int, v : Double) -> FinanceportfolioriskparityCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_cursor_sum(s : FinanceportfolioriskparityCursor) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_cursor_mean(s : FinanceportfolioriskparityCursor) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_cursor_scale(s : FinanceportfolioriskparityCursor, f : Double) -> FinanceportfolioriskparityCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_cursor_add(a : FinanceportfolioriskparityCursor, b : FinanceportfolioriskparityCursor) -> FinanceportfolioriskparityCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_cursor_copy(s : FinanceportfolioriskparityCursor) -> FinanceportfolioriskparityCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_cursor_fill(s : FinanceportfolioriskparityCursor, v : Double) -> FinanceportfolioriskparityCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_cursor_min(s : FinanceportfolioriskparityCursor) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_cursor_max(s : FinanceportfolioriskparityCursor) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_cursor_to_string(s : FinanceportfolioriskparityCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_view_make(size : Int) -> FinanceportfolioriskparityView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_view_len(s : FinanceportfolioriskparityView) -> Int { s.size }

pub fn finance_portfolio_risk_parity_view_get(s : FinanceportfolioriskparityView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_view_set(s : FinanceportfolioriskparityView, i : Int, v : Double) -> FinanceportfolioriskparityView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_view_sum(s : FinanceportfolioriskparityView) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_view_mean(s : FinanceportfolioriskparityView) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_view_scale(s : FinanceportfolioriskparityView, f : Double) -> FinanceportfolioriskparityView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_view_add(a : FinanceportfolioriskparityView, b : FinanceportfolioriskparityView) -> FinanceportfolioriskparityView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_view_copy(s : FinanceportfolioriskparityView) -> FinanceportfolioriskparityView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_view_fill(s : FinanceportfolioriskparityView, v : Double) -> FinanceportfolioriskparityView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_view_min(s : FinanceportfolioriskparityView) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_view_max(s : FinanceportfolioriskparityView) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_view_to_string(s : FinanceportfolioriskparityView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_range_make(size : Int) -> FinanceportfolioriskparityRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_range_len(s : FinanceportfolioriskparityRange) -> Int { s.size }

pub fn finance_portfolio_risk_parity_range_get(s : FinanceportfolioriskparityRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_range_set(s : FinanceportfolioriskparityRange, i : Int, v : Double) -> FinanceportfolioriskparityRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_range_sum(s : FinanceportfolioriskparityRange) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_range_mean(s : FinanceportfolioriskparityRange) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_range_scale(s : FinanceportfolioriskparityRange, f : Double) -> FinanceportfolioriskparityRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_range_add(a : FinanceportfolioriskparityRange, b : FinanceportfolioriskparityRange) -> FinanceportfolioriskparityRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_range_copy(s : FinanceportfolioriskparityRange) -> FinanceportfolioriskparityRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_range_fill(s : FinanceportfolioriskparityRange, v : Double) -> FinanceportfolioriskparityRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_range_min(s : FinanceportfolioriskparityRange) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_range_max(s : FinanceportfolioriskparityRange) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_range_to_string(s : FinanceportfolioriskparityRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparitySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_slice_make(size : Int) -> FinanceportfolioriskparitySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_slice_len(s : FinanceportfolioriskparitySlice) -> Int { s.size }

pub fn finance_portfolio_risk_parity_slice_get(s : FinanceportfolioriskparitySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_slice_set(s : FinanceportfolioriskparitySlice, i : Int, v : Double) -> FinanceportfolioriskparitySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_slice_sum(s : FinanceportfolioriskparitySlice) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_slice_mean(s : FinanceportfolioriskparitySlice) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_slice_scale(s : FinanceportfolioriskparitySlice, f : Double) -> FinanceportfolioriskparitySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_slice_add(a : FinanceportfolioriskparitySlice, b : FinanceportfolioriskparitySlice) -> FinanceportfolioriskparitySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_slice_copy(s : FinanceportfolioriskparitySlice) -> FinanceportfolioriskparitySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_slice_fill(s : FinanceportfolioriskparitySlice, v : Double) -> FinanceportfolioriskparitySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_slice_min(s : FinanceportfolioriskparitySlice) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_slice_max(s : FinanceportfolioriskparitySlice) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_slice_to_string(s : FinanceportfolioriskparitySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

