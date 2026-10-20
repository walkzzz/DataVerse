///===
/// extcore/finance_portfolio_robust

pub(all) struct FinanceportfoliorobustPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_portfolio_robust_make_point(x : Double, y : Double) -> FinanceportfoliorobustPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_portfolio_robust_make_point3(x : Double, y : Double, z : Double) -> FinanceportfoliorobustPoint {
  { x, y, z, label: 0 }
}

pub fn finance_portfolio_robust_point_x(pt : FinanceportfoliorobustPoint) -> Double { pt.x }

pub fn finance_portfolio_robust_point_y(pt : FinanceportfoliorobustPoint) -> Double { pt.y }

pub fn finance_portfolio_robust_point_z(pt : FinanceportfoliorobustPoint) -> Double { pt.z }

pub fn finance_portfolio_robust_point_label(pt : FinanceportfoliorobustPoint) -> Int { pt.label }

pub fn finance_portfolio_robust_point_dist(a : FinanceportfoliorobustPoint, b : FinanceportfoliorobustPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_portfolio_robust_point_add(a : FinanceportfoliorobustPoint, b : FinanceportfoliorobustPoint) -> FinanceportfoliorobustPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_portfolio_robust_point_sub(a : FinanceportfoliorobustPoint, b : FinanceportfoliorobustPoint) -> FinanceportfoliorobustPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_portfolio_robust_point_scale(pt : FinanceportfoliorobustPoint, s : Double) -> FinanceportfoliorobustPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_portfolio_robust_point_dot(a : FinanceportfoliorobustPoint, b : FinanceportfoliorobustPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_portfolio_robust_point_cross(a : FinanceportfoliorobustPoint, b : FinanceportfoliorobustPoint) -> FinanceportfoliorobustPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_portfolio_robust_point_norm(pt : FinanceportfoliorobustPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_portfolio_robust_point_normalize(pt : FinanceportfoliorobustPoint) -> FinanceportfoliorobustPoint {
  let n = finance_portfolio_robust_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_portfolio_robust_point_scale(pt, 1.0 / n) }
}

pub fn finance_portfolio_robust_point_negate(pt : FinanceportfoliorobustPoint) -> FinanceportfoliorobustPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_portfolio_robust_point_mid(a : FinanceportfoliorobustPoint, b : FinanceportfoliorobustPoint) -> FinanceportfoliorobustPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_portfolio_robust_point_lerp(a : FinanceportfoliorobustPoint, b : FinanceportfoliorobustPoint, t : Double) -> FinanceportfoliorobustPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_portfolio_robust_point_to_string(pt : FinanceportfoliorobustPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_portfolio_robust_make_series(vals : Array[Double], name : String) -> FinanceportfoliorobustSeries {
  { vals, name, meta: 0 }
}

pub fn finance_portfolio_robust_series_len(s : FinanceportfoliorobustSeries) -> Int { s.vals.length() }

pub fn finance_portfolio_robust_series_sum(s : FinanceportfoliorobustSeries) -> Double { @_common.sum(s.vals) }

pub fn finance_portfolio_robust_series_mean(s : FinanceportfoliorobustSeries) -> Double { @_common.mean(s.vals) }

pub fn finance_portfolio_robust_series_min(s : FinanceportfoliorobustSeries) -> Double { @_common.min(s.vals) }

pub fn finance_portfolio_robust_series_max(s : FinanceportfoliorobustSeries) -> Double { @_common.max(s.vals) }

pub fn finance_portfolio_robust_series_range(s : FinanceportfoliorobustSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn finance_portfolio_robust_series_var(s : FinanceportfoliorobustSeries) -> Double { @_common.variance(s.vals) }

pub fn finance_portfolio_robust_series_std(s : FinanceportfoliorobustSeries) -> Double { @_common.std(s.vals) }

pub fn finance_portfolio_robust_series_median(s : FinanceportfoliorobustSeries) -> Double { @_common.median(s.vals) }

pub fn finance_portfolio_robust_series_scale(s : FinanceportfoliorobustSeries, f : Double) -> FinanceportfoliorobustSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn finance_portfolio_robust_series_add(a : FinanceportfoliorobustSeries, b : FinanceportfoliorobustSeries) -> FinanceportfoliorobustSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_portfolio_robust_series_sub(a : FinanceportfoliorobustSeries, b : FinanceportfoliorobustSeries) -> FinanceportfoliorobustSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_portfolio_robust_series_normalize(s : FinanceportfoliorobustSeries) -> FinanceportfoliorobustSeries {
  let mn = finance_portfolio_robust_series_min(s)
  let mx = finance_portfolio_robust_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_portfolio_robust_series_cumsum(s : FinanceportfoliorobustSeries) -> FinanceportfoliorobustSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_portfolio_robust_series_to_string(s : FinanceportfoliorobustSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfoliorobustMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_portfolio_robust_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceportfoliorobustMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_portfolio_robust_matrix_identity(n : Int) -> FinanceportfoliorobustMatrix {
  let m = finance_portfolio_robust_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_portfolio_robust_matrix_get(m : FinanceportfoliorobustMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_portfolio_robust_matrix_transpose(m : FinanceportfoliorobustMatrix) -> FinanceportfoliorobustMatrix {
  let result = finance_portfolio_robust_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_portfolio_robust_matrix_add(a : FinanceportfoliorobustMatrix, b : FinanceportfoliorobustMatrix) -> FinanceportfoliorobustMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_portfolio_robust_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_portfolio_robust_matrix_scale(m : FinanceportfoliorobustMatrix, s : Double) -> FinanceportfoliorobustMatrix {
  let result = finance_portfolio_robust_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_portfolio_robust_matrix_multiply(a : FinanceportfoliorobustMatrix, b : FinanceportfoliorobustMatrix) -> FinanceportfoliorobustMatrix {
  if a.cols != b.rows { return finance_portfolio_robust_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_portfolio_robust_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_portfolio_robust_matrix_trace(m : FinanceportfoliorobustMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_portfolio_robust_matrix_det(m : FinanceportfoliorobustMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_portfolio_robust_matrix_norm(m : FinanceportfoliorobustMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_portfolio_robust_matrix_to_string(m : FinanceportfoliorobustMatrix) -> String {
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

pub(all) struct FinanceportfoliorobustVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_portfolio_robust_make_vector(comps : Array[Double]) -> FinanceportfoliorobustVector {
  { comps, dim: comps.length() }
}

pub fn finance_portfolio_robust_vector_zero(dim : Int) -> FinanceportfoliorobustVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_portfolio_robust_vector_add(a : FinanceportfoliorobustVector, b : FinanceportfoliorobustVector) -> FinanceportfoliorobustVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn finance_portfolio_robust_vector_sub(a : FinanceportfoliorobustVector, b : FinanceportfoliorobustVector) -> FinanceportfoliorobustVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn finance_portfolio_robust_vector_scale(v : FinanceportfoliorobustVector, s : Double) -> FinanceportfoliorobustVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn finance_portfolio_robust_vector_dot(a : FinanceportfoliorobustVector, b : FinanceportfoliorobustVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_portfolio_robust_vector_norm(v : FinanceportfoliorobustVector) -> Double { @_common.sqrt(finance_portfolio_robust_vector_dot(v, v)) }

pub fn finance_portfolio_robust_vector_normalize(v : FinanceportfoliorobustVector) -> FinanceportfoliorobustVector {
  let n = finance_portfolio_robust_vector_norm(v)
  if n < 0.0000001 { v } else { finance_portfolio_robust_vector_scale(v, 1.0 / n) }
}

pub fn finance_portfolio_robust_vector_dist(a : FinanceportfoliorobustVector, b : FinanceportfoliorobustVector) -> Double {
  finance_portfolio_robust_vector_norm(finance_portfolio_robust_vector_sub(a, b))
}

pub fn finance_portfolio_robust_vector_to_string(v : FinanceportfoliorobustVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_portfolio_robust_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_portfolio_robust_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_portfolio_robust_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_portfolio_robust_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_portfolio_robust_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_portfolio_robust_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_portfolio_robust_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_portfolio_robust_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_portfolio_robust_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_portfolio_robust_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_portfolio_robust_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_portfolio_robust_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_portfolio_robust_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_portfolio_robust_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_portfolio_robust_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_portfolio_robust_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_portfolio_robust_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_portfolio_robust_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_portfolio_robust_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_portfolio_robust_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_portfolio_robust_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_portfolio_robust_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_portfolio_robust_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_portfolio_robust_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_portfolio_robust_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_portfolio_robust_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_portfolio_robust_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_portfolio_robust_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_portfolio_robust_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceportfoliorobustFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_frame_make(size : Int) -> FinanceportfoliorobustFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_frame_len(s : FinanceportfoliorobustFrame) -> Int { s.size }

pub fn finance_portfolio_robust_frame_get(s : FinanceportfoliorobustFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_frame_set(s : FinanceportfoliorobustFrame, i : Int, v : Double) -> FinanceportfoliorobustFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_frame_sum(s : FinanceportfoliorobustFrame) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_frame_mean(s : FinanceportfoliorobustFrame) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_frame_scale(s : FinanceportfoliorobustFrame, f : Double) -> FinanceportfoliorobustFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_frame_add(a : FinanceportfoliorobustFrame, b : FinanceportfoliorobustFrame) -> FinanceportfoliorobustFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_frame_copy(s : FinanceportfoliorobustFrame) -> FinanceportfoliorobustFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_frame_fill(s : FinanceportfoliorobustFrame, v : Double) -> FinanceportfoliorobustFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_frame_min(s : FinanceportfoliorobustFrame) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_frame_max(s : FinanceportfoliorobustFrame) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_frame_to_string(s : FinanceportfoliorobustFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_table_make(size : Int) -> FinanceportfoliorobustTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_table_len(s : FinanceportfoliorobustTable) -> Int { s.size }

pub fn finance_portfolio_robust_table_get(s : FinanceportfoliorobustTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_table_set(s : FinanceportfoliorobustTable, i : Int, v : Double) -> FinanceportfoliorobustTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_table_sum(s : FinanceportfoliorobustTable) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_table_mean(s : FinanceportfoliorobustTable) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_table_scale(s : FinanceportfoliorobustTable, f : Double) -> FinanceportfoliorobustTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_table_add(a : FinanceportfoliorobustTable, b : FinanceportfoliorobustTable) -> FinanceportfoliorobustTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_table_copy(s : FinanceportfoliorobustTable) -> FinanceportfoliorobustTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_table_fill(s : FinanceportfoliorobustTable, v : Double) -> FinanceportfoliorobustTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_table_min(s : FinanceportfoliorobustTable) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_table_max(s : FinanceportfoliorobustTable) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_table_to_string(s : FinanceportfoliorobustTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_graphn_make(size : Int) -> FinanceportfoliorobustGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_graphn_len(s : FinanceportfoliorobustGraphN) -> Int { s.size }

pub fn finance_portfolio_robust_graphn_get(s : FinanceportfoliorobustGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_graphn_set(s : FinanceportfoliorobustGraphN, i : Int, v : Double) -> FinanceportfoliorobustGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_graphn_sum(s : FinanceportfoliorobustGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_graphn_mean(s : FinanceportfoliorobustGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_graphn_scale(s : FinanceportfoliorobustGraphN, f : Double) -> FinanceportfoliorobustGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_graphn_add(a : FinanceportfoliorobustGraphN, b : FinanceportfoliorobustGraphN) -> FinanceportfoliorobustGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_graphn_copy(s : FinanceportfoliorobustGraphN) -> FinanceportfoliorobustGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_graphn_fill(s : FinanceportfoliorobustGraphN, v : Double) -> FinanceportfoliorobustGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_graphn_min(s : FinanceportfoliorobustGraphN) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_graphn_max(s : FinanceportfoliorobustGraphN) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_graphn_to_string(s : FinanceportfoliorobustGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_node_make(size : Int) -> FinanceportfoliorobustNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_node_len(s : FinanceportfoliorobustNode) -> Int { s.size }

pub fn finance_portfolio_robust_node_get(s : FinanceportfoliorobustNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_node_set(s : FinanceportfoliorobustNode, i : Int, v : Double) -> FinanceportfoliorobustNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_node_sum(s : FinanceportfoliorobustNode) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_node_mean(s : FinanceportfoliorobustNode) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_node_scale(s : FinanceportfoliorobustNode, f : Double) -> FinanceportfoliorobustNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_node_add(a : FinanceportfoliorobustNode, b : FinanceportfoliorobustNode) -> FinanceportfoliorobustNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_node_copy(s : FinanceportfoliorobustNode) -> FinanceportfoliorobustNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_node_fill(s : FinanceportfoliorobustNode, v : Double) -> FinanceportfoliorobustNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_node_min(s : FinanceportfoliorobustNode) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_node_max(s : FinanceportfoliorobustNode) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_node_to_string(s : FinanceportfoliorobustNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_edge_make(size : Int) -> FinanceportfoliorobustEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_edge_len(s : FinanceportfoliorobustEdge) -> Int { s.size }

pub fn finance_portfolio_robust_edge_get(s : FinanceportfoliorobustEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_edge_set(s : FinanceportfoliorobustEdge, i : Int, v : Double) -> FinanceportfoliorobustEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_edge_sum(s : FinanceportfoliorobustEdge) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_edge_mean(s : FinanceportfoliorobustEdge) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_edge_scale(s : FinanceportfoliorobustEdge, f : Double) -> FinanceportfoliorobustEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_edge_add(a : FinanceportfoliorobustEdge, b : FinanceportfoliorobustEdge) -> FinanceportfoliorobustEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_edge_copy(s : FinanceportfoliorobustEdge) -> FinanceportfoliorobustEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_edge_fill(s : FinanceportfoliorobustEdge, v : Double) -> FinanceportfoliorobustEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_edge_min(s : FinanceportfoliorobustEdge) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_edge_max(s : FinanceportfoliorobustEdge) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_edge_to_string(s : FinanceportfoliorobustEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_path_make(size : Int) -> FinanceportfoliorobustPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_path_len(s : FinanceportfoliorobustPath) -> Int { s.size }

pub fn finance_portfolio_robust_path_get(s : FinanceportfoliorobustPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_path_set(s : FinanceportfoliorobustPath, i : Int, v : Double) -> FinanceportfoliorobustPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_path_sum(s : FinanceportfoliorobustPath) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_path_mean(s : FinanceportfoliorobustPath) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_path_scale(s : FinanceportfoliorobustPath, f : Double) -> FinanceportfoliorobustPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_path_add(a : FinanceportfoliorobustPath, b : FinanceportfoliorobustPath) -> FinanceportfoliorobustPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_path_copy(s : FinanceportfoliorobustPath) -> FinanceportfoliorobustPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_path_fill(s : FinanceportfoliorobustPath, v : Double) -> FinanceportfoliorobustPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_path_min(s : FinanceportfoliorobustPath) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_path_max(s : FinanceportfoliorobustPath) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_path_to_string(s : FinanceportfoliorobustPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_cluster_make(size : Int) -> FinanceportfoliorobustCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_cluster_len(s : FinanceportfoliorobustCluster) -> Int { s.size }

pub fn finance_portfolio_robust_cluster_get(s : FinanceportfoliorobustCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_cluster_set(s : FinanceportfoliorobustCluster, i : Int, v : Double) -> FinanceportfoliorobustCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_cluster_sum(s : FinanceportfoliorobustCluster) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_cluster_mean(s : FinanceportfoliorobustCluster) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_cluster_scale(s : FinanceportfoliorobustCluster, f : Double) -> FinanceportfoliorobustCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_cluster_add(a : FinanceportfoliorobustCluster, b : FinanceportfoliorobustCluster) -> FinanceportfoliorobustCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_cluster_copy(s : FinanceportfoliorobustCluster) -> FinanceportfoliorobustCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_cluster_fill(s : FinanceportfoliorobustCluster, v : Double) -> FinanceportfoliorobustCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_cluster_min(s : FinanceportfoliorobustCluster) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_cluster_max(s : FinanceportfoliorobustCluster) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_cluster_to_string(s : FinanceportfoliorobustCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_model_make(size : Int) -> FinanceportfoliorobustModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_model_len(s : FinanceportfoliorobustModel) -> Int { s.size }

pub fn finance_portfolio_robust_model_get(s : FinanceportfoliorobustModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_model_set(s : FinanceportfoliorobustModel, i : Int, v : Double) -> FinanceportfoliorobustModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_model_sum(s : FinanceportfoliorobustModel) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_model_mean(s : FinanceportfoliorobustModel) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_model_scale(s : FinanceportfoliorobustModel, f : Double) -> FinanceportfoliorobustModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_model_add(a : FinanceportfoliorobustModel, b : FinanceportfoliorobustModel) -> FinanceportfoliorobustModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_model_copy(s : FinanceportfoliorobustModel) -> FinanceportfoliorobustModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_model_fill(s : FinanceportfoliorobustModel, v : Double) -> FinanceportfoliorobustModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_model_min(s : FinanceportfoliorobustModel) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_model_max(s : FinanceportfoliorobustModel) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_model_to_string(s : FinanceportfoliorobustModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_layer_make(size : Int) -> FinanceportfoliorobustLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_layer_len(s : FinanceportfoliorobustLayer) -> Int { s.size }

pub fn finance_portfolio_robust_layer_get(s : FinanceportfoliorobustLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_layer_set(s : FinanceportfoliorobustLayer, i : Int, v : Double) -> FinanceportfoliorobustLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_layer_sum(s : FinanceportfoliorobustLayer) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_layer_mean(s : FinanceportfoliorobustLayer) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_layer_scale(s : FinanceportfoliorobustLayer, f : Double) -> FinanceportfoliorobustLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_layer_add(a : FinanceportfoliorobustLayer, b : FinanceportfoliorobustLayer) -> FinanceportfoliorobustLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_layer_copy(s : FinanceportfoliorobustLayer) -> FinanceportfoliorobustLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_layer_fill(s : FinanceportfoliorobustLayer, v : Double) -> FinanceportfoliorobustLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_layer_min(s : FinanceportfoliorobustLayer) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_layer_max(s : FinanceportfoliorobustLayer) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_layer_to_string(s : FinanceportfoliorobustLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_buffer_make(size : Int) -> FinanceportfoliorobustBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_buffer_len(s : FinanceportfoliorobustBuffer) -> Int { s.size }

pub fn finance_portfolio_robust_buffer_get(s : FinanceportfoliorobustBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_buffer_set(s : FinanceportfoliorobustBuffer, i : Int, v : Double) -> FinanceportfoliorobustBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_buffer_sum(s : FinanceportfoliorobustBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_buffer_mean(s : FinanceportfoliorobustBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_buffer_scale(s : FinanceportfoliorobustBuffer, f : Double) -> FinanceportfoliorobustBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_buffer_add(a : FinanceportfoliorobustBuffer, b : FinanceportfoliorobustBuffer) -> FinanceportfoliorobustBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_buffer_copy(s : FinanceportfoliorobustBuffer) -> FinanceportfoliorobustBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_buffer_fill(s : FinanceportfoliorobustBuffer, v : Double) -> FinanceportfoliorobustBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_buffer_min(s : FinanceportfoliorobustBuffer) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_buffer_max(s : FinanceportfoliorobustBuffer) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_buffer_to_string(s : FinanceportfoliorobustBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_cursor_make(size : Int) -> FinanceportfoliorobustCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_cursor_len(s : FinanceportfoliorobustCursor) -> Int { s.size }

pub fn finance_portfolio_robust_cursor_get(s : FinanceportfoliorobustCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_cursor_set(s : FinanceportfoliorobustCursor, i : Int, v : Double) -> FinanceportfoliorobustCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_cursor_sum(s : FinanceportfoliorobustCursor) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_cursor_mean(s : FinanceportfoliorobustCursor) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_cursor_scale(s : FinanceportfoliorobustCursor, f : Double) -> FinanceportfoliorobustCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_cursor_add(a : FinanceportfoliorobustCursor, b : FinanceportfoliorobustCursor) -> FinanceportfoliorobustCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_cursor_copy(s : FinanceportfoliorobustCursor) -> FinanceportfoliorobustCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_cursor_fill(s : FinanceportfoliorobustCursor, v : Double) -> FinanceportfoliorobustCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_cursor_min(s : FinanceportfoliorobustCursor) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_cursor_max(s : FinanceportfoliorobustCursor) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_cursor_to_string(s : FinanceportfoliorobustCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_view_make(size : Int) -> FinanceportfoliorobustView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_view_len(s : FinanceportfoliorobustView) -> Int { s.size }

pub fn finance_portfolio_robust_view_get(s : FinanceportfoliorobustView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_view_set(s : FinanceportfoliorobustView, i : Int, v : Double) -> FinanceportfoliorobustView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_view_sum(s : FinanceportfoliorobustView) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_view_mean(s : FinanceportfoliorobustView) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_view_scale(s : FinanceportfoliorobustView, f : Double) -> FinanceportfoliorobustView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_view_add(a : FinanceportfoliorobustView, b : FinanceportfoliorobustView) -> FinanceportfoliorobustView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_view_copy(s : FinanceportfoliorobustView) -> FinanceportfoliorobustView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_view_fill(s : FinanceportfoliorobustView, v : Double) -> FinanceportfoliorobustView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_view_min(s : FinanceportfoliorobustView) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_view_max(s : FinanceportfoliorobustView) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_view_to_string(s : FinanceportfoliorobustView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_range_make(size : Int) -> FinanceportfoliorobustRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_range_len(s : FinanceportfoliorobustRange) -> Int { s.size }

pub fn finance_portfolio_robust_range_get(s : FinanceportfoliorobustRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_range_set(s : FinanceportfoliorobustRange, i : Int, v : Double) -> FinanceportfoliorobustRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_range_sum(s : FinanceportfoliorobustRange) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_range_mean(s : FinanceportfoliorobustRange) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_range_scale(s : FinanceportfoliorobustRange, f : Double) -> FinanceportfoliorobustRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_range_add(a : FinanceportfoliorobustRange, b : FinanceportfoliorobustRange) -> FinanceportfoliorobustRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_range_copy(s : FinanceportfoliorobustRange) -> FinanceportfoliorobustRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_range_fill(s : FinanceportfoliorobustRange, v : Double) -> FinanceportfoliorobustRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_range_min(s : FinanceportfoliorobustRange) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_range_max(s : FinanceportfoliorobustRange) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_range_to_string(s : FinanceportfoliorobustRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_slice_make(size : Int) -> FinanceportfoliorobustSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_slice_len(s : FinanceportfoliorobustSlice) -> Int { s.size }

pub fn finance_portfolio_robust_slice_get(s : FinanceportfoliorobustSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_slice_set(s : FinanceportfoliorobustSlice, i : Int, v : Double) -> FinanceportfoliorobustSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_slice_sum(s : FinanceportfoliorobustSlice) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_slice_mean(s : FinanceportfoliorobustSlice) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_slice_scale(s : FinanceportfoliorobustSlice, f : Double) -> FinanceportfoliorobustSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_slice_add(a : FinanceportfoliorobustSlice, b : FinanceportfoliorobustSlice) -> FinanceportfoliorobustSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_slice_copy(s : FinanceportfoliorobustSlice) -> FinanceportfoliorobustSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_slice_fill(s : FinanceportfoliorobustSlice, v : Double) -> FinanceportfoliorobustSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_slice_min(s : FinanceportfoliorobustSlice) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_slice_max(s : FinanceportfoliorobustSlice) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_slice_to_string(s : FinanceportfoliorobustSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

