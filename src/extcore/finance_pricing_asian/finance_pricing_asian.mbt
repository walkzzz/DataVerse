///===
/// extcore/finance_pricing_asian

pub(all) struct FinancepricingasianPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_asian_make_point(x : Double, y : Double) -> FinancepricingasianPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_asian_make_point3(x : Double, y : Double, z : Double) -> FinancepricingasianPoint {
  { x, y, z, label: 0 }
}

pub fn finance_pricing_asian_point_x(pt : FinancepricingasianPoint) -> Double { pt.x }

pub fn finance_pricing_asian_point_y(pt : FinancepricingasianPoint) -> Double { pt.y }

pub fn finance_pricing_asian_point_z(pt : FinancepricingasianPoint) -> Double { pt.z }

pub fn finance_pricing_asian_point_label(pt : FinancepricingasianPoint) -> Int { pt.label }

pub fn finance_pricing_asian_point_dist(a : FinancepricingasianPoint, b : FinancepricingasianPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_pricing_asian_point_add(a : FinancepricingasianPoint, b : FinancepricingasianPoint) -> FinancepricingasianPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_pricing_asian_point_sub(a : FinancepricingasianPoint, b : FinancepricingasianPoint) -> FinancepricingasianPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_pricing_asian_point_scale(pt : FinancepricingasianPoint, s : Double) -> FinancepricingasianPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_pricing_asian_point_dot(a : FinancepricingasianPoint, b : FinancepricingasianPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_pricing_asian_point_cross(a : FinancepricingasianPoint, b : FinancepricingasianPoint) -> FinancepricingasianPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_pricing_asian_point_norm(pt : FinancepricingasianPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_pricing_asian_point_normalize(pt : FinancepricingasianPoint) -> FinancepricingasianPoint {
  let n = finance_pricing_asian_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_pricing_asian_point_scale(pt, 1.0 / n) }
}

pub fn finance_pricing_asian_point_negate(pt : FinancepricingasianPoint) -> FinancepricingasianPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_pricing_asian_point_mid(a : FinancepricingasianPoint, b : FinancepricingasianPoint) -> FinancepricingasianPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_pricing_asian_point_lerp(a : FinancepricingasianPoint, b : FinancepricingasianPoint, t : Double) -> FinancepricingasianPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_pricing_asian_point_to_string(pt : FinancepricingasianPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancepricingasianSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_asian_make_series(vals : Array[Double], name : String) -> FinancepricingasianSeries {
  { vals, name, meta: 0 }
}

pub fn finance_pricing_asian_series_len(s : FinancepricingasianSeries) -> Int { s.vals.length() }

pub fn finance_pricing_asian_series_sum(s : FinancepricingasianSeries) -> Double { @_common.sum(s.vals) }

pub fn finance_pricing_asian_series_mean(s : FinancepricingasianSeries) -> Double { @_common.mean(s.vals) }

pub fn finance_pricing_asian_series_min(s : FinancepricingasianSeries) -> Double { @_common.min(s.vals) }

pub fn finance_pricing_asian_series_max(s : FinancepricingasianSeries) -> Double { @_common.max(s.vals) }

pub fn finance_pricing_asian_series_range(s : FinancepricingasianSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn finance_pricing_asian_series_var(s : FinancepricingasianSeries) -> Double { @_common.variance(s.vals) }

pub fn finance_pricing_asian_series_std(s : FinancepricingasianSeries) -> Double { @_common.std(s.vals) }

pub fn finance_pricing_asian_series_median(s : FinancepricingasianSeries) -> Double { @_common.median(s.vals) }

pub fn finance_pricing_asian_series_scale(s : FinancepricingasianSeries, f : Double) -> FinancepricingasianSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn finance_pricing_asian_series_add(a : FinancepricingasianSeries, b : FinancepricingasianSeries) -> FinancepricingasianSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_pricing_asian_series_sub(a : FinancepricingasianSeries, b : FinancepricingasianSeries) -> FinancepricingasianSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_pricing_asian_series_normalize(s : FinancepricingasianSeries) -> FinancepricingasianSeries {
  let mn = finance_pricing_asian_series_min(s)
  let mx = finance_pricing_asian_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_pricing_asian_series_cumsum(s : FinancepricingasianSeries) -> FinancepricingasianSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_pricing_asian_series_to_string(s : FinancepricingasianSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingasianMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_asian_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingasianMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_asian_matrix_identity(n : Int) -> FinancepricingasianMatrix {
  let m = finance_pricing_asian_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_pricing_asian_matrix_get(m : FinancepricingasianMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_pricing_asian_matrix_transpose(m : FinancepricingasianMatrix) -> FinancepricingasianMatrix {
  let result = finance_pricing_asian_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_pricing_asian_matrix_add(a : FinancepricingasianMatrix, b : FinancepricingasianMatrix) -> FinancepricingasianMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_pricing_asian_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_pricing_asian_matrix_scale(m : FinancepricingasianMatrix, s : Double) -> FinancepricingasianMatrix {
  let result = finance_pricing_asian_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_pricing_asian_matrix_multiply(a : FinancepricingasianMatrix, b : FinancepricingasianMatrix) -> FinancepricingasianMatrix {
  if a.cols != b.rows { return finance_pricing_asian_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_pricing_asian_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_pricing_asian_matrix_trace(m : FinancepricingasianMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_pricing_asian_matrix_det(m : FinancepricingasianMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_pricing_asian_matrix_norm(m : FinancepricingasianMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_pricing_asian_matrix_to_string(m : FinancepricingasianMatrix) -> String {
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

pub(all) struct FinancepricingasianVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_asian_make_vector(comps : Array[Double]) -> FinancepricingasianVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_asian_vector_zero(dim : Int) -> FinancepricingasianVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_pricing_asian_vector_add(a : FinancepricingasianVector, b : FinancepricingasianVector) -> FinancepricingasianVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn finance_pricing_asian_vector_sub(a : FinancepricingasianVector, b : FinancepricingasianVector) -> FinancepricingasianVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn finance_pricing_asian_vector_scale(v : FinancepricingasianVector, s : Double) -> FinancepricingasianVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn finance_pricing_asian_vector_dot(a : FinancepricingasianVector, b : FinancepricingasianVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_pricing_asian_vector_norm(v : FinancepricingasianVector) -> Double { @_common.sqrt(finance_pricing_asian_vector_dot(v, v)) }

pub fn finance_pricing_asian_vector_normalize(v : FinancepricingasianVector) -> FinancepricingasianVector {
  let n = finance_pricing_asian_vector_norm(v)
  if n < 0.0000001 { v } else { finance_pricing_asian_vector_scale(v, 1.0 / n) }
}

pub fn finance_pricing_asian_vector_dist(a : FinancepricingasianVector, b : FinancepricingasianVector) -> Double {
  finance_pricing_asian_vector_norm(finance_pricing_asian_vector_sub(a, b))
}

pub fn finance_pricing_asian_vector_to_string(v : FinancepricingasianVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_pricing_asian_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_pricing_asian_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_pricing_asian_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_pricing_asian_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_pricing_asian_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_pricing_asian_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_pricing_asian_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_pricing_asian_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_pricing_asian_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_pricing_asian_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_pricing_asian_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_pricing_asian_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_pricing_asian_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_pricing_asian_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_pricing_asian_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_pricing_asian_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_pricing_asian_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_pricing_asian_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_pricing_asian_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_pricing_asian_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_pricing_asian_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_pricing_asian_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_pricing_asian_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_pricing_asian_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_pricing_asian_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_pricing_asian_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_pricing_asian_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_pricing_asian_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_pricing_asian_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancepricingasianFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_frame_make(size : Int) -> FinancepricingasianFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_frame_len(s : FinancepricingasianFrame) -> Int { s.size }

pub fn finance_pricing_asian_frame_get(s : FinancepricingasianFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_frame_set(s : FinancepricingasianFrame, i : Int, v : Double) -> FinancepricingasianFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_frame_sum(s : FinancepricingasianFrame) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_frame_mean(s : FinancepricingasianFrame) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_frame_scale(s : FinancepricingasianFrame, f : Double) -> FinancepricingasianFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_frame_add(a : FinancepricingasianFrame, b : FinancepricingasianFrame) -> FinancepricingasianFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_frame_copy(s : FinancepricingasianFrame) -> FinancepricingasianFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_frame_fill(s : FinancepricingasianFrame, v : Double) -> FinancepricingasianFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_frame_min(s : FinancepricingasianFrame) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_frame_max(s : FinancepricingasianFrame) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_frame_to_string(s : FinancepricingasianFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_table_make(size : Int) -> FinancepricingasianTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_table_len(s : FinancepricingasianTable) -> Int { s.size }

pub fn finance_pricing_asian_table_get(s : FinancepricingasianTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_table_set(s : FinancepricingasianTable, i : Int, v : Double) -> FinancepricingasianTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_table_sum(s : FinancepricingasianTable) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_table_mean(s : FinancepricingasianTable) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_table_scale(s : FinancepricingasianTable, f : Double) -> FinancepricingasianTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_table_add(a : FinancepricingasianTable, b : FinancepricingasianTable) -> FinancepricingasianTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_table_copy(s : FinancepricingasianTable) -> FinancepricingasianTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_table_fill(s : FinancepricingasianTable, v : Double) -> FinancepricingasianTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_table_min(s : FinancepricingasianTable) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_table_max(s : FinancepricingasianTable) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_table_to_string(s : FinancepricingasianTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_graphn_make(size : Int) -> FinancepricingasianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_graphn_len(s : FinancepricingasianGraphN) -> Int { s.size }

pub fn finance_pricing_asian_graphn_get(s : FinancepricingasianGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_graphn_set(s : FinancepricingasianGraphN, i : Int, v : Double) -> FinancepricingasianGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_graphn_sum(s : FinancepricingasianGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_graphn_mean(s : FinancepricingasianGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_graphn_scale(s : FinancepricingasianGraphN, f : Double) -> FinancepricingasianGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_graphn_add(a : FinancepricingasianGraphN, b : FinancepricingasianGraphN) -> FinancepricingasianGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_graphn_copy(s : FinancepricingasianGraphN) -> FinancepricingasianGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_graphn_fill(s : FinancepricingasianGraphN, v : Double) -> FinancepricingasianGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_graphn_min(s : FinancepricingasianGraphN) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_graphn_max(s : FinancepricingasianGraphN) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_graphn_to_string(s : FinancepricingasianGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_node_make(size : Int) -> FinancepricingasianNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_node_len(s : FinancepricingasianNode) -> Int { s.size }

pub fn finance_pricing_asian_node_get(s : FinancepricingasianNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_node_set(s : FinancepricingasianNode, i : Int, v : Double) -> FinancepricingasianNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_node_sum(s : FinancepricingasianNode) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_node_mean(s : FinancepricingasianNode) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_node_scale(s : FinancepricingasianNode, f : Double) -> FinancepricingasianNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_node_add(a : FinancepricingasianNode, b : FinancepricingasianNode) -> FinancepricingasianNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_node_copy(s : FinancepricingasianNode) -> FinancepricingasianNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_node_fill(s : FinancepricingasianNode, v : Double) -> FinancepricingasianNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_node_min(s : FinancepricingasianNode) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_node_max(s : FinancepricingasianNode) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_node_to_string(s : FinancepricingasianNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_edge_make(size : Int) -> FinancepricingasianEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_edge_len(s : FinancepricingasianEdge) -> Int { s.size }

pub fn finance_pricing_asian_edge_get(s : FinancepricingasianEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_edge_set(s : FinancepricingasianEdge, i : Int, v : Double) -> FinancepricingasianEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_edge_sum(s : FinancepricingasianEdge) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_edge_mean(s : FinancepricingasianEdge) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_edge_scale(s : FinancepricingasianEdge, f : Double) -> FinancepricingasianEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_edge_add(a : FinancepricingasianEdge, b : FinancepricingasianEdge) -> FinancepricingasianEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_edge_copy(s : FinancepricingasianEdge) -> FinancepricingasianEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_edge_fill(s : FinancepricingasianEdge, v : Double) -> FinancepricingasianEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_edge_min(s : FinancepricingasianEdge) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_edge_max(s : FinancepricingasianEdge) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_edge_to_string(s : FinancepricingasianEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_path_make(size : Int) -> FinancepricingasianPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_path_len(s : FinancepricingasianPath) -> Int { s.size }

pub fn finance_pricing_asian_path_get(s : FinancepricingasianPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_path_set(s : FinancepricingasianPath, i : Int, v : Double) -> FinancepricingasianPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_path_sum(s : FinancepricingasianPath) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_path_mean(s : FinancepricingasianPath) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_path_scale(s : FinancepricingasianPath, f : Double) -> FinancepricingasianPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_path_add(a : FinancepricingasianPath, b : FinancepricingasianPath) -> FinancepricingasianPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_path_copy(s : FinancepricingasianPath) -> FinancepricingasianPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_path_fill(s : FinancepricingasianPath, v : Double) -> FinancepricingasianPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_path_min(s : FinancepricingasianPath) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_path_max(s : FinancepricingasianPath) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_path_to_string(s : FinancepricingasianPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_cluster_make(size : Int) -> FinancepricingasianCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_cluster_len(s : FinancepricingasianCluster) -> Int { s.size }

pub fn finance_pricing_asian_cluster_get(s : FinancepricingasianCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_cluster_set(s : FinancepricingasianCluster, i : Int, v : Double) -> FinancepricingasianCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_cluster_sum(s : FinancepricingasianCluster) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_cluster_mean(s : FinancepricingasianCluster) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_cluster_scale(s : FinancepricingasianCluster, f : Double) -> FinancepricingasianCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_cluster_add(a : FinancepricingasianCluster, b : FinancepricingasianCluster) -> FinancepricingasianCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_cluster_copy(s : FinancepricingasianCluster) -> FinancepricingasianCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_cluster_fill(s : FinancepricingasianCluster, v : Double) -> FinancepricingasianCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_cluster_min(s : FinancepricingasianCluster) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_cluster_max(s : FinancepricingasianCluster) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_cluster_to_string(s : FinancepricingasianCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_model_make(size : Int) -> FinancepricingasianModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_model_len(s : FinancepricingasianModel) -> Int { s.size }

pub fn finance_pricing_asian_model_get(s : FinancepricingasianModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_model_set(s : FinancepricingasianModel, i : Int, v : Double) -> FinancepricingasianModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_model_sum(s : FinancepricingasianModel) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_model_mean(s : FinancepricingasianModel) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_model_scale(s : FinancepricingasianModel, f : Double) -> FinancepricingasianModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_model_add(a : FinancepricingasianModel, b : FinancepricingasianModel) -> FinancepricingasianModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_model_copy(s : FinancepricingasianModel) -> FinancepricingasianModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_model_fill(s : FinancepricingasianModel, v : Double) -> FinancepricingasianModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_model_min(s : FinancepricingasianModel) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_model_max(s : FinancepricingasianModel) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_model_to_string(s : FinancepricingasianModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_layer_make(size : Int) -> FinancepricingasianLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_layer_len(s : FinancepricingasianLayer) -> Int { s.size }

pub fn finance_pricing_asian_layer_get(s : FinancepricingasianLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_layer_set(s : FinancepricingasianLayer, i : Int, v : Double) -> FinancepricingasianLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_layer_sum(s : FinancepricingasianLayer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_layer_mean(s : FinancepricingasianLayer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_layer_scale(s : FinancepricingasianLayer, f : Double) -> FinancepricingasianLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_layer_add(a : FinancepricingasianLayer, b : FinancepricingasianLayer) -> FinancepricingasianLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_layer_copy(s : FinancepricingasianLayer) -> FinancepricingasianLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_layer_fill(s : FinancepricingasianLayer, v : Double) -> FinancepricingasianLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_layer_min(s : FinancepricingasianLayer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_layer_max(s : FinancepricingasianLayer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_layer_to_string(s : FinancepricingasianLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_buffer_make(size : Int) -> FinancepricingasianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_buffer_len(s : FinancepricingasianBuffer) -> Int { s.size }

pub fn finance_pricing_asian_buffer_get(s : FinancepricingasianBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_buffer_set(s : FinancepricingasianBuffer, i : Int, v : Double) -> FinancepricingasianBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_buffer_sum(s : FinancepricingasianBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_buffer_mean(s : FinancepricingasianBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_buffer_scale(s : FinancepricingasianBuffer, f : Double) -> FinancepricingasianBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_buffer_add(a : FinancepricingasianBuffer, b : FinancepricingasianBuffer) -> FinancepricingasianBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_buffer_copy(s : FinancepricingasianBuffer) -> FinancepricingasianBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_buffer_fill(s : FinancepricingasianBuffer, v : Double) -> FinancepricingasianBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_buffer_min(s : FinancepricingasianBuffer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_buffer_max(s : FinancepricingasianBuffer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_buffer_to_string(s : FinancepricingasianBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_cursor_make(size : Int) -> FinancepricingasianCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_cursor_len(s : FinancepricingasianCursor) -> Int { s.size }

pub fn finance_pricing_asian_cursor_get(s : FinancepricingasianCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_cursor_set(s : FinancepricingasianCursor, i : Int, v : Double) -> FinancepricingasianCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_cursor_sum(s : FinancepricingasianCursor) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_cursor_mean(s : FinancepricingasianCursor) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_cursor_scale(s : FinancepricingasianCursor, f : Double) -> FinancepricingasianCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_cursor_add(a : FinancepricingasianCursor, b : FinancepricingasianCursor) -> FinancepricingasianCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_cursor_copy(s : FinancepricingasianCursor) -> FinancepricingasianCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_cursor_fill(s : FinancepricingasianCursor, v : Double) -> FinancepricingasianCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_cursor_min(s : FinancepricingasianCursor) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_cursor_max(s : FinancepricingasianCursor) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_cursor_to_string(s : FinancepricingasianCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_view_make(size : Int) -> FinancepricingasianView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_view_len(s : FinancepricingasianView) -> Int { s.size }

pub fn finance_pricing_asian_view_get(s : FinancepricingasianView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_view_set(s : FinancepricingasianView, i : Int, v : Double) -> FinancepricingasianView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_view_sum(s : FinancepricingasianView) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_view_mean(s : FinancepricingasianView) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_view_scale(s : FinancepricingasianView, f : Double) -> FinancepricingasianView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_view_add(a : FinancepricingasianView, b : FinancepricingasianView) -> FinancepricingasianView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_view_copy(s : FinancepricingasianView) -> FinancepricingasianView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_view_fill(s : FinancepricingasianView, v : Double) -> FinancepricingasianView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_view_min(s : FinancepricingasianView) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_view_max(s : FinancepricingasianView) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_view_to_string(s : FinancepricingasianView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_range_make(size : Int) -> FinancepricingasianRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_range_len(s : FinancepricingasianRange) -> Int { s.size }

pub fn finance_pricing_asian_range_get(s : FinancepricingasianRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_range_set(s : FinancepricingasianRange, i : Int, v : Double) -> FinancepricingasianRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_range_sum(s : FinancepricingasianRange) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_range_mean(s : FinancepricingasianRange) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_range_scale(s : FinancepricingasianRange, f : Double) -> FinancepricingasianRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_range_add(a : FinancepricingasianRange, b : FinancepricingasianRange) -> FinancepricingasianRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_range_copy(s : FinancepricingasianRange) -> FinancepricingasianRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_range_fill(s : FinancepricingasianRange, v : Double) -> FinancepricingasianRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_range_min(s : FinancepricingasianRange) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_range_max(s : FinancepricingasianRange) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_range_to_string(s : FinancepricingasianRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_slice_make(size : Int) -> FinancepricingasianSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_slice_len(s : FinancepricingasianSlice) -> Int { s.size }

pub fn finance_pricing_asian_slice_get(s : FinancepricingasianSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_slice_set(s : FinancepricingasianSlice, i : Int, v : Double) -> FinancepricingasianSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_slice_sum(s : FinancepricingasianSlice) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_slice_mean(s : FinancepricingasianSlice) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_slice_scale(s : FinancepricingasianSlice, f : Double) -> FinancepricingasianSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_slice_add(a : FinancepricingasianSlice, b : FinancepricingasianSlice) -> FinancepricingasianSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_slice_copy(s : FinancepricingasianSlice) -> FinancepricingasianSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_slice_fill(s : FinancepricingasianSlice, v : Double) -> FinancepricingasianSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_slice_min(s : FinancepricingasianSlice) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_slice_max(s : FinancepricingasianSlice) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_slice_to_string(s : FinancepricingasianSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

