///===
/// extcore/finance_pricing_american

pub(all) struct FinancepricingamericanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_american_make_point(x : Double, y : Double) -> FinancepricingamericanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_american_make_point3(x : Double, y : Double, z : Double) -> FinancepricingamericanPoint {
  { x, y, z, label: 0 }
}

pub fn finance_pricing_american_point_x(pt : FinancepricingamericanPoint) -> Double { pt.x }

pub fn finance_pricing_american_point_y(pt : FinancepricingamericanPoint) -> Double { pt.y }

pub fn finance_pricing_american_point_z(pt : FinancepricingamericanPoint) -> Double { pt.z }

pub fn finance_pricing_american_point_label(pt : FinancepricingamericanPoint) -> Int { pt.label }

pub fn finance_pricing_american_point_dist(a : FinancepricingamericanPoint, b : FinancepricingamericanPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_pricing_american_point_add(a : FinancepricingamericanPoint, b : FinancepricingamericanPoint) -> FinancepricingamericanPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_pricing_american_point_sub(a : FinancepricingamericanPoint, b : FinancepricingamericanPoint) -> FinancepricingamericanPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_pricing_american_point_scale(pt : FinancepricingamericanPoint, s : Double) -> FinancepricingamericanPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_pricing_american_point_dot(a : FinancepricingamericanPoint, b : FinancepricingamericanPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_pricing_american_point_cross(a : FinancepricingamericanPoint, b : FinancepricingamericanPoint) -> FinancepricingamericanPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_pricing_american_point_norm(pt : FinancepricingamericanPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_pricing_american_point_normalize(pt : FinancepricingamericanPoint) -> FinancepricingamericanPoint {
  let n = finance_pricing_american_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_pricing_american_point_scale(pt, 1.0 / n) }
}

pub fn finance_pricing_american_point_negate(pt : FinancepricingamericanPoint) -> FinancepricingamericanPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_pricing_american_point_mid(a : FinancepricingamericanPoint, b : FinancepricingamericanPoint) -> FinancepricingamericanPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_pricing_american_point_lerp(a : FinancepricingamericanPoint, b : FinancepricingamericanPoint, t : Double) -> FinancepricingamericanPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_pricing_american_point_to_string(pt : FinancepricingamericanPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancepricingamericanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_american_make_series(vals : Array[Double], name : String) -> FinancepricingamericanSeries {
  { vals, name, meta: 0 }
}

pub fn finance_pricing_american_series_len(s : FinancepricingamericanSeries) -> Int { s.vals.length() }

pub fn finance_pricing_american_series_sum(s : FinancepricingamericanSeries) -> Double { @_common.sum(s.vals) }

pub fn finance_pricing_american_series_mean(s : FinancepricingamericanSeries) -> Double { @_common.mean(s.vals) }

pub fn finance_pricing_american_series_min(s : FinancepricingamericanSeries) -> Double { @_common.min(s.vals) }

pub fn finance_pricing_american_series_max(s : FinancepricingamericanSeries) -> Double { @_common.max(s.vals) }

pub fn finance_pricing_american_series_range(s : FinancepricingamericanSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn finance_pricing_american_series_var(s : FinancepricingamericanSeries) -> Double { @_common.variance(s.vals) }

pub fn finance_pricing_american_series_std(s : FinancepricingamericanSeries) -> Double { @_common.std(s.vals) }

pub fn finance_pricing_american_series_median(s : FinancepricingamericanSeries) -> Double { @_common.median(s.vals) }

pub fn finance_pricing_american_series_scale(s : FinancepricingamericanSeries, f : Double) -> FinancepricingamericanSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn finance_pricing_american_series_add(a : FinancepricingamericanSeries, b : FinancepricingamericanSeries) -> FinancepricingamericanSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_pricing_american_series_sub(a : FinancepricingamericanSeries, b : FinancepricingamericanSeries) -> FinancepricingamericanSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_pricing_american_series_normalize(s : FinancepricingamericanSeries) -> FinancepricingamericanSeries {
  let mn = finance_pricing_american_series_min(s)
  let mx = finance_pricing_american_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_pricing_american_series_cumsum(s : FinancepricingamericanSeries) -> FinancepricingamericanSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_pricing_american_series_to_string(s : FinancepricingamericanSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingamericanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_american_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingamericanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_american_matrix_identity(n : Int) -> FinancepricingamericanMatrix {
  let m = finance_pricing_american_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_pricing_american_matrix_get(m : FinancepricingamericanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_pricing_american_matrix_transpose(m : FinancepricingamericanMatrix) -> FinancepricingamericanMatrix {
  let result = finance_pricing_american_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_pricing_american_matrix_add(a : FinancepricingamericanMatrix, b : FinancepricingamericanMatrix) -> FinancepricingamericanMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_pricing_american_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_pricing_american_matrix_scale(m : FinancepricingamericanMatrix, s : Double) -> FinancepricingamericanMatrix {
  let result = finance_pricing_american_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_pricing_american_matrix_multiply(a : FinancepricingamericanMatrix, b : FinancepricingamericanMatrix) -> FinancepricingamericanMatrix {
  if a.cols != b.rows { return finance_pricing_american_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_pricing_american_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_pricing_american_matrix_trace(m : FinancepricingamericanMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_pricing_american_matrix_det(m : FinancepricingamericanMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_pricing_american_matrix_norm(m : FinancepricingamericanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_pricing_american_matrix_to_string(m : FinancepricingamericanMatrix) -> String {
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

pub(all) struct FinancepricingamericanVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_american_make_vector(comps : Array[Double]) -> FinancepricingamericanVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_american_vector_zero(dim : Int) -> FinancepricingamericanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_pricing_american_vector_add(a : FinancepricingamericanVector, b : FinancepricingamericanVector) -> FinancepricingamericanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn finance_pricing_american_vector_sub(a : FinancepricingamericanVector, b : FinancepricingamericanVector) -> FinancepricingamericanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn finance_pricing_american_vector_scale(v : FinancepricingamericanVector, s : Double) -> FinancepricingamericanVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn finance_pricing_american_vector_dot(a : FinancepricingamericanVector, b : FinancepricingamericanVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_pricing_american_vector_norm(v : FinancepricingamericanVector) -> Double { @_common.sqrt(finance_pricing_american_vector_dot(v, v)) }

pub fn finance_pricing_american_vector_normalize(v : FinancepricingamericanVector) -> FinancepricingamericanVector {
  let n = finance_pricing_american_vector_norm(v)
  if n < 0.0000001 { v } else { finance_pricing_american_vector_scale(v, 1.0 / n) }
}

pub fn finance_pricing_american_vector_dist(a : FinancepricingamericanVector, b : FinancepricingamericanVector) -> Double {
  finance_pricing_american_vector_norm(finance_pricing_american_vector_sub(a, b))
}

pub fn finance_pricing_american_vector_to_string(v : FinancepricingamericanVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_pricing_american_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_pricing_american_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_pricing_american_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_pricing_american_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_pricing_american_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_pricing_american_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_pricing_american_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_pricing_american_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_pricing_american_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_pricing_american_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_pricing_american_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_pricing_american_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_pricing_american_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_pricing_american_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_pricing_american_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_pricing_american_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_pricing_american_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_pricing_american_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_pricing_american_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_pricing_american_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_pricing_american_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_pricing_american_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_pricing_american_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_pricing_american_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_pricing_american_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_pricing_american_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_pricing_american_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_pricing_american_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_pricing_american_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancepricingamericanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_frame_make(size : Int) -> FinancepricingamericanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_frame_len(s : FinancepricingamericanFrame) -> Int { s.size }

pub fn finance_pricing_american_frame_get(s : FinancepricingamericanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_frame_set(s : FinancepricingamericanFrame, i : Int, v : Double) -> FinancepricingamericanFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_frame_sum(s : FinancepricingamericanFrame) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_frame_mean(s : FinancepricingamericanFrame) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_frame_scale(s : FinancepricingamericanFrame, f : Double) -> FinancepricingamericanFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_frame_add(a : FinancepricingamericanFrame, b : FinancepricingamericanFrame) -> FinancepricingamericanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_frame_copy(s : FinancepricingamericanFrame) -> FinancepricingamericanFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_frame_fill(s : FinancepricingamericanFrame, v : Double) -> FinancepricingamericanFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_frame_min(s : FinancepricingamericanFrame) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_frame_max(s : FinancepricingamericanFrame) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_frame_to_string(s : FinancepricingamericanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_table_make(size : Int) -> FinancepricingamericanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_table_len(s : FinancepricingamericanTable) -> Int { s.size }

pub fn finance_pricing_american_table_get(s : FinancepricingamericanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_table_set(s : FinancepricingamericanTable, i : Int, v : Double) -> FinancepricingamericanTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_table_sum(s : FinancepricingamericanTable) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_table_mean(s : FinancepricingamericanTable) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_table_scale(s : FinancepricingamericanTable, f : Double) -> FinancepricingamericanTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_table_add(a : FinancepricingamericanTable, b : FinancepricingamericanTable) -> FinancepricingamericanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_table_copy(s : FinancepricingamericanTable) -> FinancepricingamericanTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_table_fill(s : FinancepricingamericanTable, v : Double) -> FinancepricingamericanTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_table_min(s : FinancepricingamericanTable) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_table_max(s : FinancepricingamericanTable) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_table_to_string(s : FinancepricingamericanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_graphn_make(size : Int) -> FinancepricingamericanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_graphn_len(s : FinancepricingamericanGraphN) -> Int { s.size }

pub fn finance_pricing_american_graphn_get(s : FinancepricingamericanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_graphn_set(s : FinancepricingamericanGraphN, i : Int, v : Double) -> FinancepricingamericanGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_graphn_sum(s : FinancepricingamericanGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_graphn_mean(s : FinancepricingamericanGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_graphn_scale(s : FinancepricingamericanGraphN, f : Double) -> FinancepricingamericanGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_graphn_add(a : FinancepricingamericanGraphN, b : FinancepricingamericanGraphN) -> FinancepricingamericanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_graphn_copy(s : FinancepricingamericanGraphN) -> FinancepricingamericanGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_graphn_fill(s : FinancepricingamericanGraphN, v : Double) -> FinancepricingamericanGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_graphn_min(s : FinancepricingamericanGraphN) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_graphn_max(s : FinancepricingamericanGraphN) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_graphn_to_string(s : FinancepricingamericanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_node_make(size : Int) -> FinancepricingamericanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_node_len(s : FinancepricingamericanNode) -> Int { s.size }

pub fn finance_pricing_american_node_get(s : FinancepricingamericanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_node_set(s : FinancepricingamericanNode, i : Int, v : Double) -> FinancepricingamericanNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_node_sum(s : FinancepricingamericanNode) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_node_mean(s : FinancepricingamericanNode) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_node_scale(s : FinancepricingamericanNode, f : Double) -> FinancepricingamericanNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_node_add(a : FinancepricingamericanNode, b : FinancepricingamericanNode) -> FinancepricingamericanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_node_copy(s : FinancepricingamericanNode) -> FinancepricingamericanNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_node_fill(s : FinancepricingamericanNode, v : Double) -> FinancepricingamericanNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_node_min(s : FinancepricingamericanNode) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_node_max(s : FinancepricingamericanNode) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_node_to_string(s : FinancepricingamericanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_edge_make(size : Int) -> FinancepricingamericanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_edge_len(s : FinancepricingamericanEdge) -> Int { s.size }

pub fn finance_pricing_american_edge_get(s : FinancepricingamericanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_edge_set(s : FinancepricingamericanEdge, i : Int, v : Double) -> FinancepricingamericanEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_edge_sum(s : FinancepricingamericanEdge) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_edge_mean(s : FinancepricingamericanEdge) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_edge_scale(s : FinancepricingamericanEdge, f : Double) -> FinancepricingamericanEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_edge_add(a : FinancepricingamericanEdge, b : FinancepricingamericanEdge) -> FinancepricingamericanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_edge_copy(s : FinancepricingamericanEdge) -> FinancepricingamericanEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_edge_fill(s : FinancepricingamericanEdge, v : Double) -> FinancepricingamericanEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_edge_min(s : FinancepricingamericanEdge) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_edge_max(s : FinancepricingamericanEdge) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_edge_to_string(s : FinancepricingamericanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_path_make(size : Int) -> FinancepricingamericanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_path_len(s : FinancepricingamericanPath) -> Int { s.size }

pub fn finance_pricing_american_path_get(s : FinancepricingamericanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_path_set(s : FinancepricingamericanPath, i : Int, v : Double) -> FinancepricingamericanPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_path_sum(s : FinancepricingamericanPath) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_path_mean(s : FinancepricingamericanPath) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_path_scale(s : FinancepricingamericanPath, f : Double) -> FinancepricingamericanPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_path_add(a : FinancepricingamericanPath, b : FinancepricingamericanPath) -> FinancepricingamericanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_path_copy(s : FinancepricingamericanPath) -> FinancepricingamericanPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_path_fill(s : FinancepricingamericanPath, v : Double) -> FinancepricingamericanPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_path_min(s : FinancepricingamericanPath) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_path_max(s : FinancepricingamericanPath) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_path_to_string(s : FinancepricingamericanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_cluster_make(size : Int) -> FinancepricingamericanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_cluster_len(s : FinancepricingamericanCluster) -> Int { s.size }

pub fn finance_pricing_american_cluster_get(s : FinancepricingamericanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_cluster_set(s : FinancepricingamericanCluster, i : Int, v : Double) -> FinancepricingamericanCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_cluster_sum(s : FinancepricingamericanCluster) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_cluster_mean(s : FinancepricingamericanCluster) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_cluster_scale(s : FinancepricingamericanCluster, f : Double) -> FinancepricingamericanCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_cluster_add(a : FinancepricingamericanCluster, b : FinancepricingamericanCluster) -> FinancepricingamericanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_cluster_copy(s : FinancepricingamericanCluster) -> FinancepricingamericanCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_cluster_fill(s : FinancepricingamericanCluster, v : Double) -> FinancepricingamericanCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_cluster_min(s : FinancepricingamericanCluster) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_cluster_max(s : FinancepricingamericanCluster) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_cluster_to_string(s : FinancepricingamericanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_model_make(size : Int) -> FinancepricingamericanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_model_len(s : FinancepricingamericanModel) -> Int { s.size }

pub fn finance_pricing_american_model_get(s : FinancepricingamericanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_model_set(s : FinancepricingamericanModel, i : Int, v : Double) -> FinancepricingamericanModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_model_sum(s : FinancepricingamericanModel) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_model_mean(s : FinancepricingamericanModel) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_model_scale(s : FinancepricingamericanModel, f : Double) -> FinancepricingamericanModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_model_add(a : FinancepricingamericanModel, b : FinancepricingamericanModel) -> FinancepricingamericanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_model_copy(s : FinancepricingamericanModel) -> FinancepricingamericanModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_model_fill(s : FinancepricingamericanModel, v : Double) -> FinancepricingamericanModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_model_min(s : FinancepricingamericanModel) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_model_max(s : FinancepricingamericanModel) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_model_to_string(s : FinancepricingamericanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_layer_make(size : Int) -> FinancepricingamericanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_layer_len(s : FinancepricingamericanLayer) -> Int { s.size }

pub fn finance_pricing_american_layer_get(s : FinancepricingamericanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_layer_set(s : FinancepricingamericanLayer, i : Int, v : Double) -> FinancepricingamericanLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_layer_sum(s : FinancepricingamericanLayer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_layer_mean(s : FinancepricingamericanLayer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_layer_scale(s : FinancepricingamericanLayer, f : Double) -> FinancepricingamericanLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_layer_add(a : FinancepricingamericanLayer, b : FinancepricingamericanLayer) -> FinancepricingamericanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_layer_copy(s : FinancepricingamericanLayer) -> FinancepricingamericanLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_layer_fill(s : FinancepricingamericanLayer, v : Double) -> FinancepricingamericanLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_layer_min(s : FinancepricingamericanLayer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_layer_max(s : FinancepricingamericanLayer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_layer_to_string(s : FinancepricingamericanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_buffer_make(size : Int) -> FinancepricingamericanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_buffer_len(s : FinancepricingamericanBuffer) -> Int { s.size }

pub fn finance_pricing_american_buffer_get(s : FinancepricingamericanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_buffer_set(s : FinancepricingamericanBuffer, i : Int, v : Double) -> FinancepricingamericanBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_buffer_sum(s : FinancepricingamericanBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_buffer_mean(s : FinancepricingamericanBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_buffer_scale(s : FinancepricingamericanBuffer, f : Double) -> FinancepricingamericanBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_buffer_add(a : FinancepricingamericanBuffer, b : FinancepricingamericanBuffer) -> FinancepricingamericanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_buffer_copy(s : FinancepricingamericanBuffer) -> FinancepricingamericanBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_buffer_fill(s : FinancepricingamericanBuffer, v : Double) -> FinancepricingamericanBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_buffer_min(s : FinancepricingamericanBuffer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_buffer_max(s : FinancepricingamericanBuffer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_buffer_to_string(s : FinancepricingamericanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_cursor_make(size : Int) -> FinancepricingamericanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_cursor_len(s : FinancepricingamericanCursor) -> Int { s.size }

pub fn finance_pricing_american_cursor_get(s : FinancepricingamericanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_cursor_set(s : FinancepricingamericanCursor, i : Int, v : Double) -> FinancepricingamericanCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_cursor_sum(s : FinancepricingamericanCursor) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_cursor_mean(s : FinancepricingamericanCursor) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_cursor_scale(s : FinancepricingamericanCursor, f : Double) -> FinancepricingamericanCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_cursor_add(a : FinancepricingamericanCursor, b : FinancepricingamericanCursor) -> FinancepricingamericanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_cursor_copy(s : FinancepricingamericanCursor) -> FinancepricingamericanCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_cursor_fill(s : FinancepricingamericanCursor, v : Double) -> FinancepricingamericanCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_cursor_min(s : FinancepricingamericanCursor) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_cursor_max(s : FinancepricingamericanCursor) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_cursor_to_string(s : FinancepricingamericanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_view_make(size : Int) -> FinancepricingamericanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_view_len(s : FinancepricingamericanView) -> Int { s.size }

pub fn finance_pricing_american_view_get(s : FinancepricingamericanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_view_set(s : FinancepricingamericanView, i : Int, v : Double) -> FinancepricingamericanView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_view_sum(s : FinancepricingamericanView) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_view_mean(s : FinancepricingamericanView) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_view_scale(s : FinancepricingamericanView, f : Double) -> FinancepricingamericanView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_view_add(a : FinancepricingamericanView, b : FinancepricingamericanView) -> FinancepricingamericanView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_view_copy(s : FinancepricingamericanView) -> FinancepricingamericanView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_view_fill(s : FinancepricingamericanView, v : Double) -> FinancepricingamericanView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_view_min(s : FinancepricingamericanView) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_view_max(s : FinancepricingamericanView) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_view_to_string(s : FinancepricingamericanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_range_make(size : Int) -> FinancepricingamericanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_range_len(s : FinancepricingamericanRange) -> Int { s.size }

pub fn finance_pricing_american_range_get(s : FinancepricingamericanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_range_set(s : FinancepricingamericanRange, i : Int, v : Double) -> FinancepricingamericanRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_range_sum(s : FinancepricingamericanRange) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_range_mean(s : FinancepricingamericanRange) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_range_scale(s : FinancepricingamericanRange, f : Double) -> FinancepricingamericanRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_range_add(a : FinancepricingamericanRange, b : FinancepricingamericanRange) -> FinancepricingamericanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_range_copy(s : FinancepricingamericanRange) -> FinancepricingamericanRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_range_fill(s : FinancepricingamericanRange, v : Double) -> FinancepricingamericanRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_range_min(s : FinancepricingamericanRange) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_range_max(s : FinancepricingamericanRange) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_range_to_string(s : FinancepricingamericanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_slice_make(size : Int) -> FinancepricingamericanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_slice_len(s : FinancepricingamericanSlice) -> Int { s.size }

pub fn finance_pricing_american_slice_get(s : FinancepricingamericanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_slice_set(s : FinancepricingamericanSlice, i : Int, v : Double) -> FinancepricingamericanSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_slice_sum(s : FinancepricingamericanSlice) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_slice_mean(s : FinancepricingamericanSlice) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_slice_scale(s : FinancepricingamericanSlice, f : Double) -> FinancepricingamericanSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_slice_add(a : FinancepricingamericanSlice, b : FinancepricingamericanSlice) -> FinancepricingamericanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_slice_copy(s : FinancepricingamericanSlice) -> FinancepricingamericanSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_slice_fill(s : FinancepricingamericanSlice, v : Double) -> FinancepricingamericanSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_slice_min(s : FinancepricingamericanSlice) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_slice_max(s : FinancepricingamericanSlice) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_slice_to_string(s : FinancepricingamericanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

