///===
/// extcore/finance_pricing_barrier

pub(all) struct FinancepricingbarrierPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_barrier_make_point(x : Double, y : Double) -> FinancepricingbarrierPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_barrier_make_point3(x : Double, y : Double, z : Double) -> FinancepricingbarrierPoint {
  { x, y, z, label: 0 }
}

pub fn finance_pricing_barrier_point_x(pt : FinancepricingbarrierPoint) -> Double { pt.x }

pub fn finance_pricing_barrier_point_y(pt : FinancepricingbarrierPoint) -> Double { pt.y }

pub fn finance_pricing_barrier_point_z(pt : FinancepricingbarrierPoint) -> Double { pt.z }

pub fn finance_pricing_barrier_point_label(pt : FinancepricingbarrierPoint) -> Int { pt.label }

pub fn finance_pricing_barrier_point_dist(a : FinancepricingbarrierPoint, b : FinancepricingbarrierPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_pricing_barrier_point_add(a : FinancepricingbarrierPoint, b : FinancepricingbarrierPoint) -> FinancepricingbarrierPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_pricing_barrier_point_sub(a : FinancepricingbarrierPoint, b : FinancepricingbarrierPoint) -> FinancepricingbarrierPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_pricing_barrier_point_scale(pt : FinancepricingbarrierPoint, s : Double) -> FinancepricingbarrierPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_pricing_barrier_point_dot(a : FinancepricingbarrierPoint, b : FinancepricingbarrierPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_pricing_barrier_point_cross(a : FinancepricingbarrierPoint, b : FinancepricingbarrierPoint) -> FinancepricingbarrierPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_pricing_barrier_point_norm(pt : FinancepricingbarrierPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_pricing_barrier_point_normalize(pt : FinancepricingbarrierPoint) -> FinancepricingbarrierPoint {
  let n = finance_pricing_barrier_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_pricing_barrier_point_scale(pt, 1.0 / n) }
}

pub fn finance_pricing_barrier_point_negate(pt : FinancepricingbarrierPoint) -> FinancepricingbarrierPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_pricing_barrier_point_mid(a : FinancepricingbarrierPoint, b : FinancepricingbarrierPoint) -> FinancepricingbarrierPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_pricing_barrier_point_lerp(a : FinancepricingbarrierPoint, b : FinancepricingbarrierPoint, t : Double) -> FinancepricingbarrierPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_pricing_barrier_point_to_string(pt : FinancepricingbarrierPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancepricingbarrierSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_barrier_make_series(vals : Array[Double], name : String) -> FinancepricingbarrierSeries {
  { vals, name, meta: 0 }
}

pub fn finance_pricing_barrier_series_len(s : FinancepricingbarrierSeries) -> Int { s.vals.length() }

pub fn finance_pricing_barrier_series_sum(s : FinancepricingbarrierSeries) -> Double { @_common.sum(s.vals) }

pub fn finance_pricing_barrier_series_mean(s : FinancepricingbarrierSeries) -> Double { @_common.mean(s.vals) }

pub fn finance_pricing_barrier_series_min(s : FinancepricingbarrierSeries) -> Double { @_common.min(s.vals) }

pub fn finance_pricing_barrier_series_max(s : FinancepricingbarrierSeries) -> Double { @_common.max(s.vals) }

pub fn finance_pricing_barrier_series_range(s : FinancepricingbarrierSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn finance_pricing_barrier_series_var(s : FinancepricingbarrierSeries) -> Double { @_common.variance(s.vals) }

pub fn finance_pricing_barrier_series_std(s : FinancepricingbarrierSeries) -> Double { @_common.std(s.vals) }

pub fn finance_pricing_barrier_series_median(s : FinancepricingbarrierSeries) -> Double { @_common.median(s.vals) }

pub fn finance_pricing_barrier_series_scale(s : FinancepricingbarrierSeries, f : Double) -> FinancepricingbarrierSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_pricing_barrier_series_add(a : FinancepricingbarrierSeries, b : FinancepricingbarrierSeries) -> FinancepricingbarrierSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_pricing_barrier_series_sub(a : FinancepricingbarrierSeries, b : FinancepricingbarrierSeries) -> FinancepricingbarrierSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_pricing_barrier_series_normalize(s : FinancepricingbarrierSeries) -> FinancepricingbarrierSeries {
  let mn = finance_pricing_barrier_series_min(s)
  let mx = finance_pricing_barrier_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_pricing_barrier_series_cumsum(s : FinancepricingbarrierSeries) -> FinancepricingbarrierSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_pricing_barrier_series_to_string(s : FinancepricingbarrierSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingbarrierMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_barrier_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingbarrierMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_barrier_matrix_identity(n : Int) -> FinancepricingbarrierMatrix {
  let m = finance_pricing_barrier_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_pricing_barrier_matrix_get(m : FinancepricingbarrierMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_pricing_barrier_matrix_transpose(m : FinancepricingbarrierMatrix) -> FinancepricingbarrierMatrix {
  let result = finance_pricing_barrier_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_pricing_barrier_matrix_add(a : FinancepricingbarrierMatrix, b : FinancepricingbarrierMatrix) -> FinancepricingbarrierMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_pricing_barrier_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_pricing_barrier_matrix_scale(m : FinancepricingbarrierMatrix, s : Double) -> FinancepricingbarrierMatrix {
  let result = finance_pricing_barrier_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_pricing_barrier_matrix_multiply(a : FinancepricingbarrierMatrix, b : FinancepricingbarrierMatrix) -> FinancepricingbarrierMatrix {
  if a.cols != b.rows { return finance_pricing_barrier_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_pricing_barrier_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_pricing_barrier_matrix_trace(m : FinancepricingbarrierMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_pricing_barrier_matrix_det(m : FinancepricingbarrierMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_pricing_barrier_matrix_norm(m : FinancepricingbarrierMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_pricing_barrier_matrix_to_string(m : FinancepricingbarrierMatrix) -> String {
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

pub(all) struct FinancepricingbarrierVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_barrier_make_vector(comps : Array[Double]) -> FinancepricingbarrierVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_barrier_vector_zero(dim : Int) -> FinancepricingbarrierVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_pricing_barrier_vector_add(a : FinancepricingbarrierVector, b : FinancepricingbarrierVector) -> FinancepricingbarrierVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_pricing_barrier_vector_sub(a : FinancepricingbarrierVector, b : FinancepricingbarrierVector) -> FinancepricingbarrierVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_pricing_barrier_vector_scale(v : FinancepricingbarrierVector, s : Double) -> FinancepricingbarrierVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_pricing_barrier_vector_dot(a : FinancepricingbarrierVector, b : FinancepricingbarrierVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_pricing_barrier_vector_norm(v : FinancepricingbarrierVector) -> Double { @_common.sqrt(finance_pricing_barrier_vector_dot(v, v)) }

pub fn finance_pricing_barrier_vector_normalize(v : FinancepricingbarrierVector) -> FinancepricingbarrierVector {
  let n = finance_pricing_barrier_vector_norm(v)
  if n < 0.0000001 { v } else { finance_pricing_barrier_vector_scale(v, 1.0 / n) }
}

pub fn finance_pricing_barrier_vector_dist(a : FinancepricingbarrierVector, b : FinancepricingbarrierVector) -> Double {
  finance_pricing_barrier_vector_norm(finance_pricing_barrier_vector_sub(a, b))
}

pub fn finance_pricing_barrier_vector_to_string(v : FinancepricingbarrierVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_pricing_barrier_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_pricing_barrier_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_pricing_barrier_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_pricing_barrier_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_pricing_barrier_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_pricing_barrier_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_pricing_barrier_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_pricing_barrier_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_pricing_barrier_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_pricing_barrier_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_pricing_barrier_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_pricing_barrier_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_pricing_barrier_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_pricing_barrier_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_pricing_barrier_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_pricing_barrier_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_pricing_barrier_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_pricing_barrier_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_pricing_barrier_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_pricing_barrier_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_pricing_barrier_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_pricing_barrier_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_pricing_barrier_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_pricing_barrier_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_pricing_barrier_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_pricing_barrier_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_pricing_barrier_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_pricing_barrier_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_pricing_barrier_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancepricingbarrierFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_frame_make(size : Int) -> FinancepricingbarrierFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_frame_len(s : FinancepricingbarrierFrame) -> Int { s.size }

pub fn finance_pricing_barrier_frame_get(s : FinancepricingbarrierFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_frame_set(s : FinancepricingbarrierFrame, i : Int, v : Double) -> FinancepricingbarrierFrame {
  let result = finance_pricing_barrier_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_barrier_frame_sum(s : FinancepricingbarrierFrame) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_frame_mean(s : FinancepricingbarrierFrame) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_frame_scale(s : FinancepricingbarrierFrame, f : Double) -> FinancepricingbarrierFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_frame_add(a : FinancepricingbarrierFrame, b : FinancepricingbarrierFrame) -> FinancepricingbarrierFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_frame_copy(s : FinancepricingbarrierFrame) -> FinancepricingbarrierFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_frame_fill(s : FinancepricingbarrierFrame, v : Double) -> FinancepricingbarrierFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_frame_min(s : FinancepricingbarrierFrame) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_frame_max(s : FinancepricingbarrierFrame) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_frame_to_string(s : FinancepricingbarrierFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_table_make(size : Int) -> FinancepricingbarrierTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_table_len(s : FinancepricingbarrierTable) -> Int { s.size }

pub fn finance_pricing_barrier_table_get(s : FinancepricingbarrierTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_table_set(s : FinancepricingbarrierTable, i : Int, v : Double) -> FinancepricingbarrierTable {
  let result = finance_pricing_barrier_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_barrier_table_sum(s : FinancepricingbarrierTable) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_table_mean(s : FinancepricingbarrierTable) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_table_scale(s : FinancepricingbarrierTable, f : Double) -> FinancepricingbarrierTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_table_add(a : FinancepricingbarrierTable, b : FinancepricingbarrierTable) -> FinancepricingbarrierTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_table_copy(s : FinancepricingbarrierTable) -> FinancepricingbarrierTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_table_fill(s : FinancepricingbarrierTable, v : Double) -> FinancepricingbarrierTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_table_min(s : FinancepricingbarrierTable) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_table_max(s : FinancepricingbarrierTable) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_table_to_string(s : FinancepricingbarrierTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_graphn_make(size : Int) -> FinancepricingbarrierGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_graphn_len(s : FinancepricingbarrierGraphN) -> Int { s.size }

pub fn finance_pricing_barrier_graphn_get(s : FinancepricingbarrierGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_graphn_set(s : FinancepricingbarrierGraphN, i : Int, v : Double) -> FinancepricingbarrierGraphN {
  let result = finance_pricing_barrier_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_barrier_graphn_sum(s : FinancepricingbarrierGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_graphn_mean(s : FinancepricingbarrierGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_graphn_scale(s : FinancepricingbarrierGraphN, f : Double) -> FinancepricingbarrierGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_graphn_add(a : FinancepricingbarrierGraphN, b : FinancepricingbarrierGraphN) -> FinancepricingbarrierGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_graphn_copy(s : FinancepricingbarrierGraphN) -> FinancepricingbarrierGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_graphn_fill(s : FinancepricingbarrierGraphN, v : Double) -> FinancepricingbarrierGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_graphn_min(s : FinancepricingbarrierGraphN) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_graphn_max(s : FinancepricingbarrierGraphN) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_graphn_to_string(s : FinancepricingbarrierGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_node_make(size : Int) -> FinancepricingbarrierNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_node_len(s : FinancepricingbarrierNode) -> Int { s.size }

pub fn finance_pricing_barrier_node_get(s : FinancepricingbarrierNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_node_set(s : FinancepricingbarrierNode, i : Int, v : Double) -> FinancepricingbarrierNode {
  let result = finance_pricing_barrier_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_barrier_node_sum(s : FinancepricingbarrierNode) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_node_mean(s : FinancepricingbarrierNode) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_node_scale(s : FinancepricingbarrierNode, f : Double) -> FinancepricingbarrierNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_node_add(a : FinancepricingbarrierNode, b : FinancepricingbarrierNode) -> FinancepricingbarrierNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_node_copy(s : FinancepricingbarrierNode) -> FinancepricingbarrierNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_node_fill(s : FinancepricingbarrierNode, v : Double) -> FinancepricingbarrierNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_node_min(s : FinancepricingbarrierNode) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_node_max(s : FinancepricingbarrierNode) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_node_to_string(s : FinancepricingbarrierNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_edge_make(size : Int) -> FinancepricingbarrierEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_edge_len(s : FinancepricingbarrierEdge) -> Int { s.size }

pub fn finance_pricing_barrier_edge_get(s : FinancepricingbarrierEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_edge_set(s : FinancepricingbarrierEdge, i : Int, v : Double) -> FinancepricingbarrierEdge {
  let result = finance_pricing_barrier_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_barrier_edge_sum(s : FinancepricingbarrierEdge) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_edge_mean(s : FinancepricingbarrierEdge) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_edge_scale(s : FinancepricingbarrierEdge, f : Double) -> FinancepricingbarrierEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_edge_add(a : FinancepricingbarrierEdge, b : FinancepricingbarrierEdge) -> FinancepricingbarrierEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_edge_copy(s : FinancepricingbarrierEdge) -> FinancepricingbarrierEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_edge_fill(s : FinancepricingbarrierEdge, v : Double) -> FinancepricingbarrierEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_edge_min(s : FinancepricingbarrierEdge) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_edge_max(s : FinancepricingbarrierEdge) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_edge_to_string(s : FinancepricingbarrierEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_path_make(size : Int) -> FinancepricingbarrierPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_path_len(s : FinancepricingbarrierPath) -> Int { s.size }

pub fn finance_pricing_barrier_path_get(s : FinancepricingbarrierPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_path_set(s : FinancepricingbarrierPath, i : Int, v : Double) -> FinancepricingbarrierPath {
  let result = finance_pricing_barrier_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_barrier_path_sum(s : FinancepricingbarrierPath) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_path_mean(s : FinancepricingbarrierPath) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_path_scale(s : FinancepricingbarrierPath, f : Double) -> FinancepricingbarrierPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_path_add(a : FinancepricingbarrierPath, b : FinancepricingbarrierPath) -> FinancepricingbarrierPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_path_copy(s : FinancepricingbarrierPath) -> FinancepricingbarrierPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_path_fill(s : FinancepricingbarrierPath, v : Double) -> FinancepricingbarrierPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_path_min(s : FinancepricingbarrierPath) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_path_max(s : FinancepricingbarrierPath) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_path_to_string(s : FinancepricingbarrierPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_cluster_make(size : Int) -> FinancepricingbarrierCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_cluster_len(s : FinancepricingbarrierCluster) -> Int { s.size }

pub fn finance_pricing_barrier_cluster_get(s : FinancepricingbarrierCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_cluster_set(s : FinancepricingbarrierCluster, i : Int, v : Double) -> FinancepricingbarrierCluster {
  let result = finance_pricing_barrier_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_barrier_cluster_sum(s : FinancepricingbarrierCluster) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_cluster_mean(s : FinancepricingbarrierCluster) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_cluster_scale(s : FinancepricingbarrierCluster, f : Double) -> FinancepricingbarrierCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_cluster_add(a : FinancepricingbarrierCluster, b : FinancepricingbarrierCluster) -> FinancepricingbarrierCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_cluster_copy(s : FinancepricingbarrierCluster) -> FinancepricingbarrierCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_cluster_fill(s : FinancepricingbarrierCluster, v : Double) -> FinancepricingbarrierCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_cluster_min(s : FinancepricingbarrierCluster) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_cluster_max(s : FinancepricingbarrierCluster) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_cluster_to_string(s : FinancepricingbarrierCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_model_make(size : Int) -> FinancepricingbarrierModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_model_len(s : FinancepricingbarrierModel) -> Int { s.size }

pub fn finance_pricing_barrier_model_get(s : FinancepricingbarrierModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_model_set(s : FinancepricingbarrierModel, i : Int, v : Double) -> FinancepricingbarrierModel {
  let result = finance_pricing_barrier_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_barrier_model_sum(s : FinancepricingbarrierModel) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_model_mean(s : FinancepricingbarrierModel) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_model_scale(s : FinancepricingbarrierModel, f : Double) -> FinancepricingbarrierModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_model_add(a : FinancepricingbarrierModel, b : FinancepricingbarrierModel) -> FinancepricingbarrierModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_model_copy(s : FinancepricingbarrierModel) -> FinancepricingbarrierModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_model_fill(s : FinancepricingbarrierModel, v : Double) -> FinancepricingbarrierModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_model_min(s : FinancepricingbarrierModel) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_model_max(s : FinancepricingbarrierModel) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_model_to_string(s : FinancepricingbarrierModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_layer_make(size : Int) -> FinancepricingbarrierLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_layer_len(s : FinancepricingbarrierLayer) -> Int { s.size }

pub fn finance_pricing_barrier_layer_get(s : FinancepricingbarrierLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_layer_set(s : FinancepricingbarrierLayer, i : Int, v : Double) -> FinancepricingbarrierLayer {
  let result = finance_pricing_barrier_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_barrier_layer_sum(s : FinancepricingbarrierLayer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_layer_mean(s : FinancepricingbarrierLayer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_layer_scale(s : FinancepricingbarrierLayer, f : Double) -> FinancepricingbarrierLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_layer_add(a : FinancepricingbarrierLayer, b : FinancepricingbarrierLayer) -> FinancepricingbarrierLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_layer_copy(s : FinancepricingbarrierLayer) -> FinancepricingbarrierLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_layer_fill(s : FinancepricingbarrierLayer, v : Double) -> FinancepricingbarrierLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_layer_min(s : FinancepricingbarrierLayer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_layer_max(s : FinancepricingbarrierLayer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_layer_to_string(s : FinancepricingbarrierLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_buffer_make(size : Int) -> FinancepricingbarrierBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_buffer_len(s : FinancepricingbarrierBuffer) -> Int { s.size }

pub fn finance_pricing_barrier_buffer_get(s : FinancepricingbarrierBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_buffer_set(s : FinancepricingbarrierBuffer, i : Int, v : Double) -> FinancepricingbarrierBuffer {
  let result = finance_pricing_barrier_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_barrier_buffer_sum(s : FinancepricingbarrierBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_buffer_mean(s : FinancepricingbarrierBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_buffer_scale(s : FinancepricingbarrierBuffer, f : Double) -> FinancepricingbarrierBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_buffer_add(a : FinancepricingbarrierBuffer, b : FinancepricingbarrierBuffer) -> FinancepricingbarrierBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_buffer_copy(s : FinancepricingbarrierBuffer) -> FinancepricingbarrierBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_buffer_fill(s : FinancepricingbarrierBuffer, v : Double) -> FinancepricingbarrierBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_buffer_min(s : FinancepricingbarrierBuffer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_buffer_max(s : FinancepricingbarrierBuffer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_buffer_to_string(s : FinancepricingbarrierBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_cursor_make(size : Int) -> FinancepricingbarrierCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_cursor_len(s : FinancepricingbarrierCursor) -> Int { s.size }

pub fn finance_pricing_barrier_cursor_get(s : FinancepricingbarrierCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_cursor_set(s : FinancepricingbarrierCursor, i : Int, v : Double) -> FinancepricingbarrierCursor {
  let result = finance_pricing_barrier_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_barrier_cursor_sum(s : FinancepricingbarrierCursor) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_cursor_mean(s : FinancepricingbarrierCursor) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_cursor_scale(s : FinancepricingbarrierCursor, f : Double) -> FinancepricingbarrierCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_cursor_add(a : FinancepricingbarrierCursor, b : FinancepricingbarrierCursor) -> FinancepricingbarrierCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_cursor_copy(s : FinancepricingbarrierCursor) -> FinancepricingbarrierCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_cursor_fill(s : FinancepricingbarrierCursor, v : Double) -> FinancepricingbarrierCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_cursor_min(s : FinancepricingbarrierCursor) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_cursor_max(s : FinancepricingbarrierCursor) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_cursor_to_string(s : FinancepricingbarrierCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_view_make(size : Int) -> FinancepricingbarrierView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_view_len(s : FinancepricingbarrierView) -> Int { s.size }

pub fn finance_pricing_barrier_view_get(s : FinancepricingbarrierView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_view_set(s : FinancepricingbarrierView, i : Int, v : Double) -> FinancepricingbarrierView {
  let result = finance_pricing_barrier_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_barrier_view_sum(s : FinancepricingbarrierView) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_view_mean(s : FinancepricingbarrierView) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_view_scale(s : FinancepricingbarrierView, f : Double) -> FinancepricingbarrierView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_view_add(a : FinancepricingbarrierView, b : FinancepricingbarrierView) -> FinancepricingbarrierView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_view_copy(s : FinancepricingbarrierView) -> FinancepricingbarrierView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_view_fill(s : FinancepricingbarrierView, v : Double) -> FinancepricingbarrierView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_view_min(s : FinancepricingbarrierView) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_view_max(s : FinancepricingbarrierView) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_view_to_string(s : FinancepricingbarrierView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_range_make(size : Int) -> FinancepricingbarrierRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_range_len(s : FinancepricingbarrierRange) -> Int { s.size }

pub fn finance_pricing_barrier_range_get(s : FinancepricingbarrierRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_range_set(s : FinancepricingbarrierRange, i : Int, v : Double) -> FinancepricingbarrierRange {
  let result = finance_pricing_barrier_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_barrier_range_sum(s : FinancepricingbarrierRange) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_range_mean(s : FinancepricingbarrierRange) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_range_scale(s : FinancepricingbarrierRange, f : Double) -> FinancepricingbarrierRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_range_add(a : FinancepricingbarrierRange, b : FinancepricingbarrierRange) -> FinancepricingbarrierRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_range_copy(s : FinancepricingbarrierRange) -> FinancepricingbarrierRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_range_fill(s : FinancepricingbarrierRange, v : Double) -> FinancepricingbarrierRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_range_min(s : FinancepricingbarrierRange) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_range_max(s : FinancepricingbarrierRange) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_range_to_string(s : FinancepricingbarrierRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_slice_make(size : Int) -> FinancepricingbarrierSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_slice_len(s : FinancepricingbarrierSlice) -> Int { s.size }

pub fn finance_pricing_barrier_slice_get(s : FinancepricingbarrierSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_slice_set(s : FinancepricingbarrierSlice, i : Int, v : Double) -> FinancepricingbarrierSlice {
  let result = finance_pricing_barrier_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_barrier_slice_sum(s : FinancepricingbarrierSlice) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_slice_mean(s : FinancepricingbarrierSlice) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_slice_scale(s : FinancepricingbarrierSlice, f : Double) -> FinancepricingbarrierSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_slice_add(a : FinancepricingbarrierSlice, b : FinancepricingbarrierSlice) -> FinancepricingbarrierSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_slice_copy(s : FinancepricingbarrierSlice) -> FinancepricingbarrierSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_slice_fill(s : FinancepricingbarrierSlice, v : Double) -> FinancepricingbarrierSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_slice_min(s : FinancepricingbarrierSlice) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_slice_max(s : FinancepricingbarrierSlice) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_slice_to_string(s : FinancepricingbarrierSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

