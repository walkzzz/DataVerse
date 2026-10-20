///===
/// extcore/finance_portfolio_black_litterman

pub(all) struct FinanceportfolioblacklittermanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_portfolio_black_litterman_make_point(x : Double, y : Double) -> FinanceportfolioblacklittermanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_portfolio_black_litterman_make_point3(x : Double, y : Double, z : Double) -> FinanceportfolioblacklittermanPoint {
  { x, y, z, label: 0 }
}

pub fn finance_portfolio_black_litterman_point_x(pt : FinanceportfolioblacklittermanPoint) -> Double { pt.x }

pub fn finance_portfolio_black_litterman_point_y(pt : FinanceportfolioblacklittermanPoint) -> Double { pt.y }

pub fn finance_portfolio_black_litterman_point_z(pt : FinanceportfolioblacklittermanPoint) -> Double { pt.z }

pub fn finance_portfolio_black_litterman_point_label(pt : FinanceportfolioblacklittermanPoint) -> Int { pt.label }

pub fn finance_portfolio_black_litterman_point_dist(a : FinanceportfolioblacklittermanPoint, b : FinanceportfolioblacklittermanPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_portfolio_black_litterman_point_add(a : FinanceportfolioblacklittermanPoint, b : FinanceportfolioblacklittermanPoint) -> FinanceportfolioblacklittermanPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_portfolio_black_litterman_point_sub(a : FinanceportfolioblacklittermanPoint, b : FinanceportfolioblacklittermanPoint) -> FinanceportfolioblacklittermanPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_portfolio_black_litterman_point_scale(pt : FinanceportfolioblacklittermanPoint, s : Double) -> FinanceportfolioblacklittermanPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_portfolio_black_litterman_point_dot(a : FinanceportfolioblacklittermanPoint, b : FinanceportfolioblacklittermanPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_portfolio_black_litterman_point_cross(a : FinanceportfolioblacklittermanPoint, b : FinanceportfolioblacklittermanPoint) -> FinanceportfolioblacklittermanPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_portfolio_black_litterman_point_norm(pt : FinanceportfolioblacklittermanPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_portfolio_black_litterman_point_normalize(pt : FinanceportfolioblacklittermanPoint) -> FinanceportfolioblacklittermanPoint {
  let n = finance_portfolio_black_litterman_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_portfolio_black_litterman_point_scale(pt, 1.0 / n) }
}

pub fn finance_portfolio_black_litterman_point_negate(pt : FinanceportfolioblacklittermanPoint) -> FinanceportfolioblacklittermanPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_portfolio_black_litterman_point_mid(a : FinanceportfolioblacklittermanPoint, b : FinanceportfolioblacklittermanPoint) -> FinanceportfolioblacklittermanPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_portfolio_black_litterman_point_lerp(a : FinanceportfolioblacklittermanPoint, b : FinanceportfolioblacklittermanPoint, t : Double) -> FinanceportfolioblacklittermanPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_portfolio_black_litterman_point_to_string(pt : FinanceportfolioblacklittermanPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_portfolio_black_litterman_make_series(vals : Array[Double], name : String) -> FinanceportfolioblacklittermanSeries {
  { vals, name, meta: 0 }
}

pub fn finance_portfolio_black_litterman_series_len(s : FinanceportfolioblacklittermanSeries) -> Int { s.vals.length() }

pub fn finance_portfolio_black_litterman_series_sum(s : FinanceportfolioblacklittermanSeries) -> Double { @_common.sum(s.vals) }

pub fn finance_portfolio_black_litterman_series_mean(s : FinanceportfolioblacklittermanSeries) -> Double { @_common.mean(s.vals) }

pub fn finance_portfolio_black_litterman_series_min(s : FinanceportfolioblacklittermanSeries) -> Double { @_common.min(s.vals) }

pub fn finance_portfolio_black_litterman_series_max(s : FinanceportfolioblacklittermanSeries) -> Double { @_common.max(s.vals) }

pub fn finance_portfolio_black_litterman_series_range(s : FinanceportfolioblacklittermanSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn finance_portfolio_black_litterman_series_var(s : FinanceportfolioblacklittermanSeries) -> Double { @_common.variance(s.vals) }

pub fn finance_portfolio_black_litterman_series_std(s : FinanceportfolioblacklittermanSeries) -> Double { @_common.std(s.vals) }

pub fn finance_portfolio_black_litterman_series_median(s : FinanceportfolioblacklittermanSeries) -> Double { @_common.median(s.vals) }

pub fn finance_portfolio_black_litterman_series_scale(s : FinanceportfolioblacklittermanSeries, f : Double) -> FinanceportfolioblacklittermanSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_portfolio_black_litterman_series_add(a : FinanceportfolioblacklittermanSeries, b : FinanceportfolioblacklittermanSeries) -> FinanceportfolioblacklittermanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_portfolio_black_litterman_series_sub(a : FinanceportfolioblacklittermanSeries, b : FinanceportfolioblacklittermanSeries) -> FinanceportfolioblacklittermanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_portfolio_black_litterman_series_normalize(s : FinanceportfolioblacklittermanSeries) -> FinanceportfolioblacklittermanSeries {
  let mn = finance_portfolio_black_litterman_series_min(s)
  let mx = finance_portfolio_black_litterman_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_portfolio_black_litterman_series_cumsum(s : FinanceportfolioblacklittermanSeries) -> FinanceportfolioblacklittermanSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_portfolio_black_litterman_series_to_string(s : FinanceportfolioblacklittermanSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfolioblacklittermanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_portfolio_black_litterman_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceportfolioblacklittermanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_portfolio_black_litterman_matrix_identity(n : Int) -> FinanceportfolioblacklittermanMatrix {
  let m = finance_portfolio_black_litterman_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_portfolio_black_litterman_matrix_get(m : FinanceportfolioblacklittermanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_portfolio_black_litterman_matrix_transpose(m : FinanceportfolioblacklittermanMatrix) -> FinanceportfolioblacklittermanMatrix {
  let result = finance_portfolio_black_litterman_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_portfolio_black_litterman_matrix_add(a : FinanceportfolioblacklittermanMatrix, b : FinanceportfolioblacklittermanMatrix) -> FinanceportfolioblacklittermanMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_portfolio_black_litterman_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_portfolio_black_litterman_matrix_scale(m : FinanceportfolioblacklittermanMatrix, s : Double) -> FinanceportfolioblacklittermanMatrix {
  let result = finance_portfolio_black_litterman_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_portfolio_black_litterman_matrix_multiply(a : FinanceportfolioblacklittermanMatrix, b : FinanceportfolioblacklittermanMatrix) -> FinanceportfolioblacklittermanMatrix {
  if a.cols != b.rows { return finance_portfolio_black_litterman_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_portfolio_black_litterman_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_portfolio_black_litterman_matrix_trace(m : FinanceportfolioblacklittermanMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_portfolio_black_litterman_matrix_det(m : FinanceportfolioblacklittermanMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_portfolio_black_litterman_matrix_norm(m : FinanceportfolioblacklittermanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_portfolio_black_litterman_matrix_to_string(m : FinanceportfolioblacklittermanMatrix) -> String {
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

pub(all) struct FinanceportfolioblacklittermanVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_portfolio_black_litterman_make_vector(comps : Array[Double]) -> FinanceportfolioblacklittermanVector {
  { comps, dim: comps.length() }
}

pub fn finance_portfolio_black_litterman_vector_zero(dim : Int) -> FinanceportfolioblacklittermanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_portfolio_black_litterman_vector_add(a : FinanceportfolioblacklittermanVector, b : FinanceportfolioblacklittermanVector) -> FinanceportfolioblacklittermanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_portfolio_black_litterman_vector_sub(a : FinanceportfolioblacklittermanVector, b : FinanceportfolioblacklittermanVector) -> FinanceportfolioblacklittermanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_portfolio_black_litterman_vector_scale(v : FinanceportfolioblacklittermanVector, s : Double) -> FinanceportfolioblacklittermanVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_portfolio_black_litterman_vector_dot(a : FinanceportfolioblacklittermanVector, b : FinanceportfolioblacklittermanVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_portfolio_black_litterman_vector_norm(v : FinanceportfolioblacklittermanVector) -> Double { @_common.sqrt(finance_portfolio_black_litterman_vector_dot(v, v)) }

pub fn finance_portfolio_black_litterman_vector_normalize(v : FinanceportfolioblacklittermanVector) -> FinanceportfolioblacklittermanVector {
  let n = finance_portfolio_black_litterman_vector_norm(v)
  if n < 0.0000001 { v } else { finance_portfolio_black_litterman_vector_scale(v, 1.0 / n) }
}

pub fn finance_portfolio_black_litterman_vector_dist(a : FinanceportfolioblacklittermanVector, b : FinanceportfolioblacklittermanVector) -> Double {
  finance_portfolio_black_litterman_vector_norm(finance_portfolio_black_litterman_vector_sub(a, b))
}

pub fn finance_portfolio_black_litterman_vector_to_string(v : FinanceportfolioblacklittermanVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_portfolio_black_litterman_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_portfolio_black_litterman_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_portfolio_black_litterman_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_portfolio_black_litterman_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_portfolio_black_litterman_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_portfolio_black_litterman_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_portfolio_black_litterman_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_portfolio_black_litterman_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_portfolio_black_litterman_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_portfolio_black_litterman_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_portfolio_black_litterman_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_portfolio_black_litterman_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_portfolio_black_litterman_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_portfolio_black_litterman_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_portfolio_black_litterman_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_portfolio_black_litterman_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_portfolio_black_litterman_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_portfolio_black_litterman_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_portfolio_black_litterman_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_portfolio_black_litterman_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_portfolio_black_litterman_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_portfolio_black_litterman_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_portfolio_black_litterman_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_portfolio_black_litterman_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_portfolio_black_litterman_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_portfolio_black_litterman_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_portfolio_black_litterman_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_portfolio_black_litterman_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_portfolio_black_litterman_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceportfolioblacklittermanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_frame_make(size : Int) -> FinanceportfolioblacklittermanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_frame_len(s : FinanceportfolioblacklittermanFrame) -> Int { s.size }

pub fn finance_portfolio_black_litterman_frame_get(s : FinanceportfolioblacklittermanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_frame_set(s : FinanceportfolioblacklittermanFrame, i : Int, v : Double) -> FinanceportfolioblacklittermanFrame {
  let result = finance_portfolio_black_litterman_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_black_litterman_frame_sum(s : FinanceportfolioblacklittermanFrame) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_frame_mean(s : FinanceportfolioblacklittermanFrame) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_frame_scale(s : FinanceportfolioblacklittermanFrame, f : Double) -> FinanceportfolioblacklittermanFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_frame_add(a : FinanceportfolioblacklittermanFrame, b : FinanceportfolioblacklittermanFrame) -> FinanceportfolioblacklittermanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_frame_copy(s : FinanceportfolioblacklittermanFrame) -> FinanceportfolioblacklittermanFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_frame_fill(s : FinanceportfolioblacklittermanFrame, v : Double) -> FinanceportfolioblacklittermanFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_frame_min(s : FinanceportfolioblacklittermanFrame) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_frame_max(s : FinanceportfolioblacklittermanFrame) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_frame_to_string(s : FinanceportfolioblacklittermanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_table_make(size : Int) -> FinanceportfolioblacklittermanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_table_len(s : FinanceportfolioblacklittermanTable) -> Int { s.size }

pub fn finance_portfolio_black_litterman_table_get(s : FinanceportfolioblacklittermanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_table_set(s : FinanceportfolioblacklittermanTable, i : Int, v : Double) -> FinanceportfolioblacklittermanTable {
  let result = finance_portfolio_black_litterman_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_black_litterman_table_sum(s : FinanceportfolioblacklittermanTable) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_table_mean(s : FinanceportfolioblacklittermanTable) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_table_scale(s : FinanceportfolioblacklittermanTable, f : Double) -> FinanceportfolioblacklittermanTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_table_add(a : FinanceportfolioblacklittermanTable, b : FinanceportfolioblacklittermanTable) -> FinanceportfolioblacklittermanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_table_copy(s : FinanceportfolioblacklittermanTable) -> FinanceportfolioblacklittermanTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_table_fill(s : FinanceportfolioblacklittermanTable, v : Double) -> FinanceportfolioblacklittermanTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_table_min(s : FinanceportfolioblacklittermanTable) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_table_max(s : FinanceportfolioblacklittermanTable) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_table_to_string(s : FinanceportfolioblacklittermanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_graphn_make(size : Int) -> FinanceportfolioblacklittermanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_graphn_len(s : FinanceportfolioblacklittermanGraphN) -> Int { s.size }

pub fn finance_portfolio_black_litterman_graphn_get(s : FinanceportfolioblacklittermanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_graphn_set(s : FinanceportfolioblacklittermanGraphN, i : Int, v : Double) -> FinanceportfolioblacklittermanGraphN {
  let result = finance_portfolio_black_litterman_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_black_litterman_graphn_sum(s : FinanceportfolioblacklittermanGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_graphn_mean(s : FinanceportfolioblacklittermanGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_graphn_scale(s : FinanceportfolioblacklittermanGraphN, f : Double) -> FinanceportfolioblacklittermanGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_graphn_add(a : FinanceportfolioblacklittermanGraphN, b : FinanceportfolioblacklittermanGraphN) -> FinanceportfolioblacklittermanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_graphn_copy(s : FinanceportfolioblacklittermanGraphN) -> FinanceportfolioblacklittermanGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_graphn_fill(s : FinanceportfolioblacklittermanGraphN, v : Double) -> FinanceportfolioblacklittermanGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_graphn_min(s : FinanceportfolioblacklittermanGraphN) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_graphn_max(s : FinanceportfolioblacklittermanGraphN) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_graphn_to_string(s : FinanceportfolioblacklittermanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_node_make(size : Int) -> FinanceportfolioblacklittermanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_node_len(s : FinanceportfolioblacklittermanNode) -> Int { s.size }

pub fn finance_portfolio_black_litterman_node_get(s : FinanceportfolioblacklittermanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_node_set(s : FinanceportfolioblacklittermanNode, i : Int, v : Double) -> FinanceportfolioblacklittermanNode {
  let result = finance_portfolio_black_litterman_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_black_litterman_node_sum(s : FinanceportfolioblacklittermanNode) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_node_mean(s : FinanceportfolioblacklittermanNode) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_node_scale(s : FinanceportfolioblacklittermanNode, f : Double) -> FinanceportfolioblacklittermanNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_node_add(a : FinanceportfolioblacklittermanNode, b : FinanceportfolioblacklittermanNode) -> FinanceportfolioblacklittermanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_node_copy(s : FinanceportfolioblacklittermanNode) -> FinanceportfolioblacklittermanNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_node_fill(s : FinanceportfolioblacklittermanNode, v : Double) -> FinanceportfolioblacklittermanNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_node_min(s : FinanceportfolioblacklittermanNode) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_node_max(s : FinanceportfolioblacklittermanNode) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_node_to_string(s : FinanceportfolioblacklittermanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_edge_make(size : Int) -> FinanceportfolioblacklittermanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_edge_len(s : FinanceportfolioblacklittermanEdge) -> Int { s.size }

pub fn finance_portfolio_black_litterman_edge_get(s : FinanceportfolioblacklittermanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_edge_set(s : FinanceportfolioblacklittermanEdge, i : Int, v : Double) -> FinanceportfolioblacklittermanEdge {
  let result = finance_portfolio_black_litterman_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_black_litterman_edge_sum(s : FinanceportfolioblacklittermanEdge) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_edge_mean(s : FinanceportfolioblacklittermanEdge) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_edge_scale(s : FinanceportfolioblacklittermanEdge, f : Double) -> FinanceportfolioblacklittermanEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_edge_add(a : FinanceportfolioblacklittermanEdge, b : FinanceportfolioblacklittermanEdge) -> FinanceportfolioblacklittermanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_edge_copy(s : FinanceportfolioblacklittermanEdge) -> FinanceportfolioblacklittermanEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_edge_fill(s : FinanceportfolioblacklittermanEdge, v : Double) -> FinanceportfolioblacklittermanEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_edge_min(s : FinanceportfolioblacklittermanEdge) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_edge_max(s : FinanceportfolioblacklittermanEdge) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_edge_to_string(s : FinanceportfolioblacklittermanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_path_make(size : Int) -> FinanceportfolioblacklittermanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_path_len(s : FinanceportfolioblacklittermanPath) -> Int { s.size }

pub fn finance_portfolio_black_litterman_path_get(s : FinanceportfolioblacklittermanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_path_set(s : FinanceportfolioblacklittermanPath, i : Int, v : Double) -> FinanceportfolioblacklittermanPath {
  let result = finance_portfolio_black_litterman_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_black_litterman_path_sum(s : FinanceportfolioblacklittermanPath) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_path_mean(s : FinanceportfolioblacklittermanPath) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_path_scale(s : FinanceportfolioblacklittermanPath, f : Double) -> FinanceportfolioblacklittermanPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_path_add(a : FinanceportfolioblacklittermanPath, b : FinanceportfolioblacklittermanPath) -> FinanceportfolioblacklittermanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_path_copy(s : FinanceportfolioblacklittermanPath) -> FinanceportfolioblacklittermanPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_path_fill(s : FinanceportfolioblacklittermanPath, v : Double) -> FinanceportfolioblacklittermanPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_path_min(s : FinanceportfolioblacklittermanPath) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_path_max(s : FinanceportfolioblacklittermanPath) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_path_to_string(s : FinanceportfolioblacklittermanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_cluster_make(size : Int) -> FinanceportfolioblacklittermanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_cluster_len(s : FinanceportfolioblacklittermanCluster) -> Int { s.size }

pub fn finance_portfolio_black_litterman_cluster_get(s : FinanceportfolioblacklittermanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_cluster_set(s : FinanceportfolioblacklittermanCluster, i : Int, v : Double) -> FinanceportfolioblacklittermanCluster {
  let result = finance_portfolio_black_litterman_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_black_litterman_cluster_sum(s : FinanceportfolioblacklittermanCluster) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_cluster_mean(s : FinanceportfolioblacklittermanCluster) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_cluster_scale(s : FinanceportfolioblacklittermanCluster, f : Double) -> FinanceportfolioblacklittermanCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_cluster_add(a : FinanceportfolioblacklittermanCluster, b : FinanceportfolioblacklittermanCluster) -> FinanceportfolioblacklittermanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_cluster_copy(s : FinanceportfolioblacklittermanCluster) -> FinanceportfolioblacklittermanCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_cluster_fill(s : FinanceportfolioblacklittermanCluster, v : Double) -> FinanceportfolioblacklittermanCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_cluster_min(s : FinanceportfolioblacklittermanCluster) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_cluster_max(s : FinanceportfolioblacklittermanCluster) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_cluster_to_string(s : FinanceportfolioblacklittermanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_model_make(size : Int) -> FinanceportfolioblacklittermanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_model_len(s : FinanceportfolioblacklittermanModel) -> Int { s.size }

pub fn finance_portfolio_black_litterman_model_get(s : FinanceportfolioblacklittermanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_model_set(s : FinanceportfolioblacklittermanModel, i : Int, v : Double) -> FinanceportfolioblacklittermanModel {
  let result = finance_portfolio_black_litterman_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_black_litterman_model_sum(s : FinanceportfolioblacklittermanModel) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_model_mean(s : FinanceportfolioblacklittermanModel) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_model_scale(s : FinanceportfolioblacklittermanModel, f : Double) -> FinanceportfolioblacklittermanModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_model_add(a : FinanceportfolioblacklittermanModel, b : FinanceportfolioblacklittermanModel) -> FinanceportfolioblacklittermanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_model_copy(s : FinanceportfolioblacklittermanModel) -> FinanceportfolioblacklittermanModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_model_fill(s : FinanceportfolioblacklittermanModel, v : Double) -> FinanceportfolioblacklittermanModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_model_min(s : FinanceportfolioblacklittermanModel) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_model_max(s : FinanceportfolioblacklittermanModel) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_model_to_string(s : FinanceportfolioblacklittermanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_layer_make(size : Int) -> FinanceportfolioblacklittermanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_layer_len(s : FinanceportfolioblacklittermanLayer) -> Int { s.size }

pub fn finance_portfolio_black_litterman_layer_get(s : FinanceportfolioblacklittermanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_layer_set(s : FinanceportfolioblacklittermanLayer, i : Int, v : Double) -> FinanceportfolioblacklittermanLayer {
  let result = finance_portfolio_black_litterman_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_black_litterman_layer_sum(s : FinanceportfolioblacklittermanLayer) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_layer_mean(s : FinanceportfolioblacklittermanLayer) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_layer_scale(s : FinanceportfolioblacklittermanLayer, f : Double) -> FinanceportfolioblacklittermanLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_layer_add(a : FinanceportfolioblacklittermanLayer, b : FinanceportfolioblacklittermanLayer) -> FinanceportfolioblacklittermanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_layer_copy(s : FinanceportfolioblacklittermanLayer) -> FinanceportfolioblacklittermanLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_layer_fill(s : FinanceportfolioblacklittermanLayer, v : Double) -> FinanceportfolioblacklittermanLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_layer_min(s : FinanceportfolioblacklittermanLayer) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_layer_max(s : FinanceportfolioblacklittermanLayer) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_layer_to_string(s : FinanceportfolioblacklittermanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_buffer_make(size : Int) -> FinanceportfolioblacklittermanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_buffer_len(s : FinanceportfolioblacklittermanBuffer) -> Int { s.size }

pub fn finance_portfolio_black_litterman_buffer_get(s : FinanceportfolioblacklittermanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_buffer_set(s : FinanceportfolioblacklittermanBuffer, i : Int, v : Double) -> FinanceportfolioblacklittermanBuffer {
  let result = finance_portfolio_black_litterman_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_black_litterman_buffer_sum(s : FinanceportfolioblacklittermanBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_buffer_mean(s : FinanceportfolioblacklittermanBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_buffer_scale(s : FinanceportfolioblacklittermanBuffer, f : Double) -> FinanceportfolioblacklittermanBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_buffer_add(a : FinanceportfolioblacklittermanBuffer, b : FinanceportfolioblacklittermanBuffer) -> FinanceportfolioblacklittermanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_buffer_copy(s : FinanceportfolioblacklittermanBuffer) -> FinanceportfolioblacklittermanBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_buffer_fill(s : FinanceportfolioblacklittermanBuffer, v : Double) -> FinanceportfolioblacklittermanBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_buffer_min(s : FinanceportfolioblacklittermanBuffer) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_buffer_max(s : FinanceportfolioblacklittermanBuffer) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_buffer_to_string(s : FinanceportfolioblacklittermanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_cursor_make(size : Int) -> FinanceportfolioblacklittermanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_cursor_len(s : FinanceportfolioblacklittermanCursor) -> Int { s.size }

pub fn finance_portfolio_black_litterman_cursor_get(s : FinanceportfolioblacklittermanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_cursor_set(s : FinanceportfolioblacklittermanCursor, i : Int, v : Double) -> FinanceportfolioblacklittermanCursor {
  let result = finance_portfolio_black_litterman_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_black_litterman_cursor_sum(s : FinanceportfolioblacklittermanCursor) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_cursor_mean(s : FinanceportfolioblacklittermanCursor) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_cursor_scale(s : FinanceportfolioblacklittermanCursor, f : Double) -> FinanceportfolioblacklittermanCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_cursor_add(a : FinanceportfolioblacklittermanCursor, b : FinanceportfolioblacklittermanCursor) -> FinanceportfolioblacklittermanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_cursor_copy(s : FinanceportfolioblacklittermanCursor) -> FinanceportfolioblacklittermanCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_cursor_fill(s : FinanceportfolioblacklittermanCursor, v : Double) -> FinanceportfolioblacklittermanCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_cursor_min(s : FinanceportfolioblacklittermanCursor) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_cursor_max(s : FinanceportfolioblacklittermanCursor) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_cursor_to_string(s : FinanceportfolioblacklittermanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_view_make(size : Int) -> FinanceportfolioblacklittermanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_view_len(s : FinanceportfolioblacklittermanView) -> Int { s.size }

pub fn finance_portfolio_black_litterman_view_get(s : FinanceportfolioblacklittermanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_view_set(s : FinanceportfolioblacklittermanView, i : Int, v : Double) -> FinanceportfolioblacklittermanView {
  let result = finance_portfolio_black_litterman_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_black_litterman_view_sum(s : FinanceportfolioblacklittermanView) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_view_mean(s : FinanceportfolioblacklittermanView) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_view_scale(s : FinanceportfolioblacklittermanView, f : Double) -> FinanceportfolioblacklittermanView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_view_add(a : FinanceportfolioblacklittermanView, b : FinanceportfolioblacklittermanView) -> FinanceportfolioblacklittermanView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_view_copy(s : FinanceportfolioblacklittermanView) -> FinanceportfolioblacklittermanView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_view_fill(s : FinanceportfolioblacklittermanView, v : Double) -> FinanceportfolioblacklittermanView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_view_min(s : FinanceportfolioblacklittermanView) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_view_max(s : FinanceportfolioblacklittermanView) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_view_to_string(s : FinanceportfolioblacklittermanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_range_make(size : Int) -> FinanceportfolioblacklittermanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_range_len(s : FinanceportfolioblacklittermanRange) -> Int { s.size }

pub fn finance_portfolio_black_litterman_range_get(s : FinanceportfolioblacklittermanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_range_set(s : FinanceportfolioblacklittermanRange, i : Int, v : Double) -> FinanceportfolioblacklittermanRange {
  let result = finance_portfolio_black_litterman_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_black_litterman_range_sum(s : FinanceportfolioblacklittermanRange) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_range_mean(s : FinanceportfolioblacklittermanRange) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_range_scale(s : FinanceportfolioblacklittermanRange, f : Double) -> FinanceportfolioblacklittermanRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_range_add(a : FinanceportfolioblacklittermanRange, b : FinanceportfolioblacklittermanRange) -> FinanceportfolioblacklittermanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_range_copy(s : FinanceportfolioblacklittermanRange) -> FinanceportfolioblacklittermanRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_range_fill(s : FinanceportfolioblacklittermanRange, v : Double) -> FinanceportfolioblacklittermanRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_range_min(s : FinanceportfolioblacklittermanRange) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_range_max(s : FinanceportfolioblacklittermanRange) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_range_to_string(s : FinanceportfolioblacklittermanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_slice_make(size : Int) -> FinanceportfolioblacklittermanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_slice_len(s : FinanceportfolioblacklittermanSlice) -> Int { s.size }

pub fn finance_portfolio_black_litterman_slice_get(s : FinanceportfolioblacklittermanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_slice_set(s : FinanceportfolioblacklittermanSlice, i : Int, v : Double) -> FinanceportfolioblacklittermanSlice {
  let result = finance_portfolio_black_litterman_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_black_litterman_slice_sum(s : FinanceportfolioblacklittermanSlice) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_slice_mean(s : FinanceportfolioblacklittermanSlice) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_slice_scale(s : FinanceportfolioblacklittermanSlice, f : Double) -> FinanceportfolioblacklittermanSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_slice_add(a : FinanceportfolioblacklittermanSlice, b : FinanceportfolioblacklittermanSlice) -> FinanceportfolioblacklittermanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_slice_copy(s : FinanceportfolioblacklittermanSlice) -> FinanceportfolioblacklittermanSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_slice_fill(s : FinanceportfolioblacklittermanSlice, v : Double) -> FinanceportfolioblacklittermanSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_slice_min(s : FinanceportfolioblacklittermanSlice) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_slice_max(s : FinanceportfolioblacklittermanSlice) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_slice_to_string(s : FinanceportfolioblacklittermanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

