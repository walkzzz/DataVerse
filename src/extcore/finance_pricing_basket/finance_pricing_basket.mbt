///===
/// extcore/finance_pricing_basket

pub(all) struct FinancepricingbasketPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_basket_make_point(x : Double, y : Double) -> FinancepricingbasketPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_basket_make_point3(x : Double, y : Double, z : Double) -> FinancepricingbasketPoint {
  { x, y, z, label: 0 }
}

pub fn finance_pricing_basket_point_x(pt : FinancepricingbasketPoint) -> Double { pt.x }

pub fn finance_pricing_basket_point_y(pt : FinancepricingbasketPoint) -> Double { pt.y }

pub fn finance_pricing_basket_point_z(pt : FinancepricingbasketPoint) -> Double { pt.z }

pub fn finance_pricing_basket_point_label(pt : FinancepricingbasketPoint) -> Int { pt.label }

pub fn finance_pricing_basket_point_dist(a : FinancepricingbasketPoint, b : FinancepricingbasketPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_pricing_basket_point_add(a : FinancepricingbasketPoint, b : FinancepricingbasketPoint) -> FinancepricingbasketPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_pricing_basket_point_sub(a : FinancepricingbasketPoint, b : FinancepricingbasketPoint) -> FinancepricingbasketPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_pricing_basket_point_scale(pt : FinancepricingbasketPoint, s : Double) -> FinancepricingbasketPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_pricing_basket_point_dot(a : FinancepricingbasketPoint, b : FinancepricingbasketPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_pricing_basket_point_cross(a : FinancepricingbasketPoint, b : FinancepricingbasketPoint) -> FinancepricingbasketPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_pricing_basket_point_norm(pt : FinancepricingbasketPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_pricing_basket_point_normalize(pt : FinancepricingbasketPoint) -> FinancepricingbasketPoint {
  let n = finance_pricing_basket_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_pricing_basket_point_scale(pt, 1.0 / n) }
}

pub fn finance_pricing_basket_point_negate(pt : FinancepricingbasketPoint) -> FinancepricingbasketPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_pricing_basket_point_mid(a : FinancepricingbasketPoint, b : FinancepricingbasketPoint) -> FinancepricingbasketPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_pricing_basket_point_lerp(a : FinancepricingbasketPoint, b : FinancepricingbasketPoint, t : Double) -> FinancepricingbasketPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_pricing_basket_point_to_string(pt : FinancepricingbasketPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancepricingbasketSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_basket_make_series(vals : Array[Double], name : String) -> FinancepricingbasketSeries {
  { vals, name, meta: 0 }
}

pub fn finance_pricing_basket_series_len(s : FinancepricingbasketSeries) -> Int { s.vals.length() }

pub fn finance_pricing_basket_series_sum(s : FinancepricingbasketSeries) -> Double { @_common.sum(s.vals) }

pub fn finance_pricing_basket_series_mean(s : FinancepricingbasketSeries) -> Double { @_common.mean(s.vals) }

pub fn finance_pricing_basket_series_min(s : FinancepricingbasketSeries) -> Double { @_common.min(s.vals) }

pub fn finance_pricing_basket_series_max(s : FinancepricingbasketSeries) -> Double { @_common.max(s.vals) }

pub fn finance_pricing_basket_series_range(s : FinancepricingbasketSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn finance_pricing_basket_series_var(s : FinancepricingbasketSeries) -> Double { @_common.variance(s.vals) }

pub fn finance_pricing_basket_series_std(s : FinancepricingbasketSeries) -> Double { @_common.std(s.vals) }

pub fn finance_pricing_basket_series_median(s : FinancepricingbasketSeries) -> Double { @_common.median(s.vals) }

pub fn finance_pricing_basket_series_scale(s : FinancepricingbasketSeries, f : Double) -> FinancepricingbasketSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn finance_pricing_basket_series_add(a : FinancepricingbasketSeries, b : FinancepricingbasketSeries) -> FinancepricingbasketSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_pricing_basket_series_sub(a : FinancepricingbasketSeries, b : FinancepricingbasketSeries) -> FinancepricingbasketSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_pricing_basket_series_normalize(s : FinancepricingbasketSeries) -> FinancepricingbasketSeries {
  let mn = finance_pricing_basket_series_min(s)
  let mx = finance_pricing_basket_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_pricing_basket_series_cumsum(s : FinancepricingbasketSeries) -> FinancepricingbasketSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_pricing_basket_series_to_string(s : FinancepricingbasketSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingbasketMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_basket_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingbasketMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_basket_matrix_identity(n : Int) -> FinancepricingbasketMatrix {
  let m = finance_pricing_basket_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_pricing_basket_matrix_get(m : FinancepricingbasketMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_pricing_basket_matrix_transpose(m : FinancepricingbasketMatrix) -> FinancepricingbasketMatrix {
  let result = finance_pricing_basket_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_pricing_basket_matrix_add(a : FinancepricingbasketMatrix, b : FinancepricingbasketMatrix) -> FinancepricingbasketMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_pricing_basket_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_pricing_basket_matrix_scale(m : FinancepricingbasketMatrix, s : Double) -> FinancepricingbasketMatrix {
  let result = finance_pricing_basket_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_pricing_basket_matrix_multiply(a : FinancepricingbasketMatrix, b : FinancepricingbasketMatrix) -> FinancepricingbasketMatrix {
  if a.cols != b.rows { return finance_pricing_basket_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_pricing_basket_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_pricing_basket_matrix_trace(m : FinancepricingbasketMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_pricing_basket_matrix_det(m : FinancepricingbasketMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_pricing_basket_matrix_norm(m : FinancepricingbasketMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_pricing_basket_matrix_to_string(m : FinancepricingbasketMatrix) -> String {
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

pub(all) struct FinancepricingbasketVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_basket_make_vector(comps : Array[Double]) -> FinancepricingbasketVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_basket_vector_zero(dim : Int) -> FinancepricingbasketVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_pricing_basket_vector_add(a : FinancepricingbasketVector, b : FinancepricingbasketVector) -> FinancepricingbasketVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn finance_pricing_basket_vector_sub(a : FinancepricingbasketVector, b : FinancepricingbasketVector) -> FinancepricingbasketVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn finance_pricing_basket_vector_scale(v : FinancepricingbasketVector, s : Double) -> FinancepricingbasketVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn finance_pricing_basket_vector_dot(a : FinancepricingbasketVector, b : FinancepricingbasketVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_pricing_basket_vector_norm(v : FinancepricingbasketVector) -> Double { @_common.sqrt(finance_pricing_basket_vector_dot(v, v)) }

pub fn finance_pricing_basket_vector_normalize(v : FinancepricingbasketVector) -> FinancepricingbasketVector {
  let n = finance_pricing_basket_vector_norm(v)
  if n < 0.0000001 { v } else { finance_pricing_basket_vector_scale(v, 1.0 / n) }
}

pub fn finance_pricing_basket_vector_dist(a : FinancepricingbasketVector, b : FinancepricingbasketVector) -> Double {
  finance_pricing_basket_vector_norm(finance_pricing_basket_vector_sub(a, b))
}

pub fn finance_pricing_basket_vector_to_string(v : FinancepricingbasketVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_pricing_basket_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_pricing_basket_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_pricing_basket_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_pricing_basket_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_pricing_basket_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_pricing_basket_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_pricing_basket_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_pricing_basket_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_pricing_basket_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_pricing_basket_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_pricing_basket_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_pricing_basket_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_pricing_basket_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_pricing_basket_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_pricing_basket_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_pricing_basket_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_pricing_basket_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_pricing_basket_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_pricing_basket_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_pricing_basket_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_pricing_basket_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_pricing_basket_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_pricing_basket_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_pricing_basket_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_pricing_basket_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_pricing_basket_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_pricing_basket_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_pricing_basket_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_pricing_basket_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancepricingbasketFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_frame_make(size : Int) -> FinancepricingbasketFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_basket_frame_len(s : FinancepricingbasketFrame) -> Int { s.size }

pub fn finance_pricing_basket_frame_get(s : FinancepricingbasketFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_basket_frame_set(s : FinancepricingbasketFrame, i : Int, v : Double) -> FinancepricingbasketFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_frame_sum(s : FinancepricingbasketFrame) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_basket_frame_mean(s : FinancepricingbasketFrame) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_basket_frame_scale(s : FinancepricingbasketFrame, f : Double) -> FinancepricingbasketFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_frame_add(a : FinancepricingbasketFrame, b : FinancepricingbasketFrame) -> FinancepricingbasketFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_basket_frame_copy(s : FinancepricingbasketFrame) -> FinancepricingbasketFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_frame_fill(s : FinancepricingbasketFrame, v : Double) -> FinancepricingbasketFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_frame_min(s : FinancepricingbasketFrame) -> Double { @_common.min(s.data) }

pub fn finance_pricing_basket_frame_max(s : FinancepricingbasketFrame) -> Double { @_common.max(s.data) }

pub fn finance_pricing_basket_frame_to_string(s : FinancepricingbasketFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_table_make(size : Int) -> FinancepricingbasketTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_basket_table_len(s : FinancepricingbasketTable) -> Int { s.size }

pub fn finance_pricing_basket_table_get(s : FinancepricingbasketTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_basket_table_set(s : FinancepricingbasketTable, i : Int, v : Double) -> FinancepricingbasketTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_table_sum(s : FinancepricingbasketTable) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_basket_table_mean(s : FinancepricingbasketTable) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_basket_table_scale(s : FinancepricingbasketTable, f : Double) -> FinancepricingbasketTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_table_add(a : FinancepricingbasketTable, b : FinancepricingbasketTable) -> FinancepricingbasketTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_basket_table_copy(s : FinancepricingbasketTable) -> FinancepricingbasketTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_table_fill(s : FinancepricingbasketTable, v : Double) -> FinancepricingbasketTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_table_min(s : FinancepricingbasketTable) -> Double { @_common.min(s.data) }

pub fn finance_pricing_basket_table_max(s : FinancepricingbasketTable) -> Double { @_common.max(s.data) }

pub fn finance_pricing_basket_table_to_string(s : FinancepricingbasketTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_graphn_make(size : Int) -> FinancepricingbasketGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_basket_graphn_len(s : FinancepricingbasketGraphN) -> Int { s.size }

pub fn finance_pricing_basket_graphn_get(s : FinancepricingbasketGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_basket_graphn_set(s : FinancepricingbasketGraphN, i : Int, v : Double) -> FinancepricingbasketGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_graphn_sum(s : FinancepricingbasketGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_basket_graphn_mean(s : FinancepricingbasketGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_basket_graphn_scale(s : FinancepricingbasketGraphN, f : Double) -> FinancepricingbasketGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_graphn_add(a : FinancepricingbasketGraphN, b : FinancepricingbasketGraphN) -> FinancepricingbasketGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_basket_graphn_copy(s : FinancepricingbasketGraphN) -> FinancepricingbasketGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_graphn_fill(s : FinancepricingbasketGraphN, v : Double) -> FinancepricingbasketGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_graphn_min(s : FinancepricingbasketGraphN) -> Double { @_common.min(s.data) }

pub fn finance_pricing_basket_graphn_max(s : FinancepricingbasketGraphN) -> Double { @_common.max(s.data) }

pub fn finance_pricing_basket_graphn_to_string(s : FinancepricingbasketGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_node_make(size : Int) -> FinancepricingbasketNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_basket_node_len(s : FinancepricingbasketNode) -> Int { s.size }

pub fn finance_pricing_basket_node_get(s : FinancepricingbasketNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_basket_node_set(s : FinancepricingbasketNode, i : Int, v : Double) -> FinancepricingbasketNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_node_sum(s : FinancepricingbasketNode) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_basket_node_mean(s : FinancepricingbasketNode) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_basket_node_scale(s : FinancepricingbasketNode, f : Double) -> FinancepricingbasketNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_node_add(a : FinancepricingbasketNode, b : FinancepricingbasketNode) -> FinancepricingbasketNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_basket_node_copy(s : FinancepricingbasketNode) -> FinancepricingbasketNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_node_fill(s : FinancepricingbasketNode, v : Double) -> FinancepricingbasketNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_node_min(s : FinancepricingbasketNode) -> Double { @_common.min(s.data) }

pub fn finance_pricing_basket_node_max(s : FinancepricingbasketNode) -> Double { @_common.max(s.data) }

pub fn finance_pricing_basket_node_to_string(s : FinancepricingbasketNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_edge_make(size : Int) -> FinancepricingbasketEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_basket_edge_len(s : FinancepricingbasketEdge) -> Int { s.size }

pub fn finance_pricing_basket_edge_get(s : FinancepricingbasketEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_basket_edge_set(s : FinancepricingbasketEdge, i : Int, v : Double) -> FinancepricingbasketEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_edge_sum(s : FinancepricingbasketEdge) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_basket_edge_mean(s : FinancepricingbasketEdge) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_basket_edge_scale(s : FinancepricingbasketEdge, f : Double) -> FinancepricingbasketEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_edge_add(a : FinancepricingbasketEdge, b : FinancepricingbasketEdge) -> FinancepricingbasketEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_basket_edge_copy(s : FinancepricingbasketEdge) -> FinancepricingbasketEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_edge_fill(s : FinancepricingbasketEdge, v : Double) -> FinancepricingbasketEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_edge_min(s : FinancepricingbasketEdge) -> Double { @_common.min(s.data) }

pub fn finance_pricing_basket_edge_max(s : FinancepricingbasketEdge) -> Double { @_common.max(s.data) }

pub fn finance_pricing_basket_edge_to_string(s : FinancepricingbasketEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_path_make(size : Int) -> FinancepricingbasketPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_basket_path_len(s : FinancepricingbasketPath) -> Int { s.size }

pub fn finance_pricing_basket_path_get(s : FinancepricingbasketPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_basket_path_set(s : FinancepricingbasketPath, i : Int, v : Double) -> FinancepricingbasketPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_path_sum(s : FinancepricingbasketPath) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_basket_path_mean(s : FinancepricingbasketPath) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_basket_path_scale(s : FinancepricingbasketPath, f : Double) -> FinancepricingbasketPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_path_add(a : FinancepricingbasketPath, b : FinancepricingbasketPath) -> FinancepricingbasketPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_basket_path_copy(s : FinancepricingbasketPath) -> FinancepricingbasketPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_path_fill(s : FinancepricingbasketPath, v : Double) -> FinancepricingbasketPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_path_min(s : FinancepricingbasketPath) -> Double { @_common.min(s.data) }

pub fn finance_pricing_basket_path_max(s : FinancepricingbasketPath) -> Double { @_common.max(s.data) }

pub fn finance_pricing_basket_path_to_string(s : FinancepricingbasketPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_cluster_make(size : Int) -> FinancepricingbasketCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_basket_cluster_len(s : FinancepricingbasketCluster) -> Int { s.size }

pub fn finance_pricing_basket_cluster_get(s : FinancepricingbasketCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_basket_cluster_set(s : FinancepricingbasketCluster, i : Int, v : Double) -> FinancepricingbasketCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_cluster_sum(s : FinancepricingbasketCluster) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_basket_cluster_mean(s : FinancepricingbasketCluster) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_basket_cluster_scale(s : FinancepricingbasketCluster, f : Double) -> FinancepricingbasketCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_cluster_add(a : FinancepricingbasketCluster, b : FinancepricingbasketCluster) -> FinancepricingbasketCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_basket_cluster_copy(s : FinancepricingbasketCluster) -> FinancepricingbasketCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_cluster_fill(s : FinancepricingbasketCluster, v : Double) -> FinancepricingbasketCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_cluster_min(s : FinancepricingbasketCluster) -> Double { @_common.min(s.data) }

pub fn finance_pricing_basket_cluster_max(s : FinancepricingbasketCluster) -> Double { @_common.max(s.data) }

pub fn finance_pricing_basket_cluster_to_string(s : FinancepricingbasketCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_model_make(size : Int) -> FinancepricingbasketModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_basket_model_len(s : FinancepricingbasketModel) -> Int { s.size }

pub fn finance_pricing_basket_model_get(s : FinancepricingbasketModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_basket_model_set(s : FinancepricingbasketModel, i : Int, v : Double) -> FinancepricingbasketModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_model_sum(s : FinancepricingbasketModel) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_basket_model_mean(s : FinancepricingbasketModel) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_basket_model_scale(s : FinancepricingbasketModel, f : Double) -> FinancepricingbasketModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_model_add(a : FinancepricingbasketModel, b : FinancepricingbasketModel) -> FinancepricingbasketModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_basket_model_copy(s : FinancepricingbasketModel) -> FinancepricingbasketModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_model_fill(s : FinancepricingbasketModel, v : Double) -> FinancepricingbasketModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_model_min(s : FinancepricingbasketModel) -> Double { @_common.min(s.data) }

pub fn finance_pricing_basket_model_max(s : FinancepricingbasketModel) -> Double { @_common.max(s.data) }

pub fn finance_pricing_basket_model_to_string(s : FinancepricingbasketModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_layer_make(size : Int) -> FinancepricingbasketLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_basket_layer_len(s : FinancepricingbasketLayer) -> Int { s.size }

pub fn finance_pricing_basket_layer_get(s : FinancepricingbasketLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_basket_layer_set(s : FinancepricingbasketLayer, i : Int, v : Double) -> FinancepricingbasketLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_layer_sum(s : FinancepricingbasketLayer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_basket_layer_mean(s : FinancepricingbasketLayer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_basket_layer_scale(s : FinancepricingbasketLayer, f : Double) -> FinancepricingbasketLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_layer_add(a : FinancepricingbasketLayer, b : FinancepricingbasketLayer) -> FinancepricingbasketLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_basket_layer_copy(s : FinancepricingbasketLayer) -> FinancepricingbasketLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_layer_fill(s : FinancepricingbasketLayer, v : Double) -> FinancepricingbasketLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_layer_min(s : FinancepricingbasketLayer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_basket_layer_max(s : FinancepricingbasketLayer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_basket_layer_to_string(s : FinancepricingbasketLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_buffer_make(size : Int) -> FinancepricingbasketBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_basket_buffer_len(s : FinancepricingbasketBuffer) -> Int { s.size }

pub fn finance_pricing_basket_buffer_get(s : FinancepricingbasketBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_basket_buffer_set(s : FinancepricingbasketBuffer, i : Int, v : Double) -> FinancepricingbasketBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_buffer_sum(s : FinancepricingbasketBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_basket_buffer_mean(s : FinancepricingbasketBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_basket_buffer_scale(s : FinancepricingbasketBuffer, f : Double) -> FinancepricingbasketBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_buffer_add(a : FinancepricingbasketBuffer, b : FinancepricingbasketBuffer) -> FinancepricingbasketBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_basket_buffer_copy(s : FinancepricingbasketBuffer) -> FinancepricingbasketBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_buffer_fill(s : FinancepricingbasketBuffer, v : Double) -> FinancepricingbasketBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_buffer_min(s : FinancepricingbasketBuffer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_basket_buffer_max(s : FinancepricingbasketBuffer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_basket_buffer_to_string(s : FinancepricingbasketBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_cursor_make(size : Int) -> FinancepricingbasketCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_basket_cursor_len(s : FinancepricingbasketCursor) -> Int { s.size }

pub fn finance_pricing_basket_cursor_get(s : FinancepricingbasketCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_basket_cursor_set(s : FinancepricingbasketCursor, i : Int, v : Double) -> FinancepricingbasketCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_cursor_sum(s : FinancepricingbasketCursor) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_basket_cursor_mean(s : FinancepricingbasketCursor) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_basket_cursor_scale(s : FinancepricingbasketCursor, f : Double) -> FinancepricingbasketCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_cursor_add(a : FinancepricingbasketCursor, b : FinancepricingbasketCursor) -> FinancepricingbasketCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_basket_cursor_copy(s : FinancepricingbasketCursor) -> FinancepricingbasketCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_cursor_fill(s : FinancepricingbasketCursor, v : Double) -> FinancepricingbasketCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_cursor_min(s : FinancepricingbasketCursor) -> Double { @_common.min(s.data) }

pub fn finance_pricing_basket_cursor_max(s : FinancepricingbasketCursor) -> Double { @_common.max(s.data) }

pub fn finance_pricing_basket_cursor_to_string(s : FinancepricingbasketCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_view_make(size : Int) -> FinancepricingbasketView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_basket_view_len(s : FinancepricingbasketView) -> Int { s.size }

pub fn finance_pricing_basket_view_get(s : FinancepricingbasketView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_basket_view_set(s : FinancepricingbasketView, i : Int, v : Double) -> FinancepricingbasketView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_view_sum(s : FinancepricingbasketView) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_basket_view_mean(s : FinancepricingbasketView) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_basket_view_scale(s : FinancepricingbasketView, f : Double) -> FinancepricingbasketView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_view_add(a : FinancepricingbasketView, b : FinancepricingbasketView) -> FinancepricingbasketView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_basket_view_copy(s : FinancepricingbasketView) -> FinancepricingbasketView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_view_fill(s : FinancepricingbasketView, v : Double) -> FinancepricingbasketView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_view_min(s : FinancepricingbasketView) -> Double { @_common.min(s.data) }

pub fn finance_pricing_basket_view_max(s : FinancepricingbasketView) -> Double { @_common.max(s.data) }

pub fn finance_pricing_basket_view_to_string(s : FinancepricingbasketView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_range_make(size : Int) -> FinancepricingbasketRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_basket_range_len(s : FinancepricingbasketRange) -> Int { s.size }

pub fn finance_pricing_basket_range_get(s : FinancepricingbasketRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_basket_range_set(s : FinancepricingbasketRange, i : Int, v : Double) -> FinancepricingbasketRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_range_sum(s : FinancepricingbasketRange) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_basket_range_mean(s : FinancepricingbasketRange) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_basket_range_scale(s : FinancepricingbasketRange, f : Double) -> FinancepricingbasketRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_range_add(a : FinancepricingbasketRange, b : FinancepricingbasketRange) -> FinancepricingbasketRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_basket_range_copy(s : FinancepricingbasketRange) -> FinancepricingbasketRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_range_fill(s : FinancepricingbasketRange, v : Double) -> FinancepricingbasketRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_range_min(s : FinancepricingbasketRange) -> Double { @_common.min(s.data) }

pub fn finance_pricing_basket_range_max(s : FinancepricingbasketRange) -> Double { @_common.max(s.data) }

pub fn finance_pricing_basket_range_to_string(s : FinancepricingbasketRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_slice_make(size : Int) -> FinancepricingbasketSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_basket_slice_len(s : FinancepricingbasketSlice) -> Int { s.size }

pub fn finance_pricing_basket_slice_get(s : FinancepricingbasketSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_basket_slice_set(s : FinancepricingbasketSlice, i : Int, v : Double) -> FinancepricingbasketSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_slice_sum(s : FinancepricingbasketSlice) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_basket_slice_mean(s : FinancepricingbasketSlice) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_basket_slice_scale(s : FinancepricingbasketSlice, f : Double) -> FinancepricingbasketSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_slice_add(a : FinancepricingbasketSlice, b : FinancepricingbasketSlice) -> FinancepricingbasketSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_basket_slice_copy(s : FinancepricingbasketSlice) -> FinancepricingbasketSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_slice_fill(s : FinancepricingbasketSlice, v : Double) -> FinancepricingbasketSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_basket_slice_min(s : FinancepricingbasketSlice) -> Double { @_common.min(s.data) }

pub fn finance_pricing_basket_slice_max(s : FinancepricingbasketSlice) -> Double { @_common.max(s.data) }

pub fn finance_pricing_basket_slice_to_string(s : FinancepricingbasketSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

