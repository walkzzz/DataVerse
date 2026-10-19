///===
/// extcore/finance_portfolio_hierarchical

pub(all) struct FinanceportfoliohierarchicalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_portfolio_hierarchical_make_point(x : Double, y : Double) -> FinanceportfoliohierarchicalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_portfolio_hierarchical_make_point3(x : Double, y : Double, z : Double) -> FinanceportfoliohierarchicalPoint {
  { x, y, z, label: 0 }
}

pub fn finance_portfolio_hierarchical_point_x(pt : FinanceportfoliohierarchicalPoint) -> Double { pt.x }

pub fn finance_portfolio_hierarchical_point_y(pt : FinanceportfoliohierarchicalPoint) -> Double { pt.y }

pub fn finance_portfolio_hierarchical_point_z(pt : FinanceportfoliohierarchicalPoint) -> Double { pt.z }

pub fn finance_portfolio_hierarchical_point_label(pt : FinanceportfoliohierarchicalPoint) -> Int { pt.label }

pub fn finance_portfolio_hierarchical_point_dist(a : FinanceportfoliohierarchicalPoint, b : FinanceportfoliohierarchicalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_portfolio_hierarchical_point_add(a : FinanceportfoliohierarchicalPoint, b : FinanceportfoliohierarchicalPoint) -> FinanceportfoliohierarchicalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_portfolio_hierarchical_point_sub(a : FinanceportfoliohierarchicalPoint, b : FinanceportfoliohierarchicalPoint) -> FinanceportfoliohierarchicalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_portfolio_hierarchical_point_scale(pt : FinanceportfoliohierarchicalPoint, s : Double) -> FinanceportfoliohierarchicalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_portfolio_hierarchical_point_dot(a : FinanceportfoliohierarchicalPoint, b : FinanceportfoliohierarchicalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_portfolio_hierarchical_point_cross(a : FinanceportfoliohierarchicalPoint, b : FinanceportfoliohierarchicalPoint) -> FinanceportfoliohierarchicalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_portfolio_hierarchical_point_norm(pt : FinanceportfoliohierarchicalPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_portfolio_hierarchical_point_normalize(pt : FinanceportfoliohierarchicalPoint) -> FinanceportfoliohierarchicalPoint {
  let n = finance_portfolio_hierarchical_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_portfolio_hierarchical_point_scale(pt, 1.0 / n) }
}

pub fn finance_portfolio_hierarchical_point_negate(pt : FinanceportfoliohierarchicalPoint) -> FinanceportfoliohierarchicalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_portfolio_hierarchical_point_mid(a : FinanceportfoliohierarchicalPoint, b : FinanceportfoliohierarchicalPoint) -> FinanceportfoliohierarchicalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_portfolio_hierarchical_point_lerp(a : FinanceportfoliohierarchicalPoint, b : FinanceportfoliohierarchicalPoint, t : Double) -> FinanceportfoliohierarchicalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_portfolio_hierarchical_point_to_string(pt : FinanceportfoliohierarchicalPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinanceportfoliohierarchicalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_portfolio_hierarchical_make_series(vals : Array[Double], name : String) -> FinanceportfoliohierarchicalSeries {
  { vals, name, meta: 0 }
}

pub fn finance_portfolio_hierarchical_series_len(s : FinanceportfoliohierarchicalSeries) -> Int { s.vals.length() }

pub fn finance_portfolio_hierarchical_series_sum(s : FinanceportfoliohierarchicalSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_portfolio_hierarchical_series_mean(s : FinanceportfoliohierarchicalSeries) -> Double {
  let n = finance_portfolio_hierarchical_series_len(s)
  if n == 0 { 0.0 } else { finance_portfolio_hierarchical_series_sum(s) / n.to_double() }
}

pub fn finance_portfolio_hierarchical_series_min(s : FinanceportfoliohierarchicalSeries) -> Double {
  let n = finance_portfolio_hierarchical_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_series_max(s : FinanceportfoliohierarchicalSeries) -> Double {
  let n = finance_portfolio_hierarchical_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_series_range(s : FinanceportfoliohierarchicalSeries) -> Double {
  finance_portfolio_hierarchical_series_max(s) - finance_portfolio_hierarchical_series_min(s)
}

pub fn finance_portfolio_hierarchical_series_var(s : FinanceportfoliohierarchicalSeries) -> Double {
  let n = finance_portfolio_hierarchical_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_portfolio_hierarchical_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_portfolio_hierarchical_series_std(s : FinanceportfoliohierarchicalSeries) -> Double { @_common.sqrt(finance_portfolio_hierarchical_series_var(s)) }

pub fn finance_portfolio_hierarchical_series_median(s : FinanceportfoliohierarchicalSeries) -> Double {
  let n = finance_portfolio_hierarchical_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_portfolio_hierarchical_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_portfolio_hierarchical_series_scale(s : FinanceportfoliohierarchicalSeries, f : Double) -> FinanceportfoliohierarchicalSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_portfolio_hierarchical_series_add(a : FinanceportfoliohierarchicalSeries, b : FinanceportfoliohierarchicalSeries) -> FinanceportfoliohierarchicalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_portfolio_hierarchical_series_sub(a : FinanceportfoliohierarchicalSeries, b : FinanceportfoliohierarchicalSeries) -> FinanceportfoliohierarchicalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_portfolio_hierarchical_series_normalize(s : FinanceportfoliohierarchicalSeries) -> FinanceportfoliohierarchicalSeries {
  let mn = finance_portfolio_hierarchical_series_min(s)
  let mx = finance_portfolio_hierarchical_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_portfolio_hierarchical_series_cumsum(s : FinanceportfoliohierarchicalSeries) -> FinanceportfoliohierarchicalSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_portfolio_hierarchical_series_to_string(s : FinanceportfoliohierarchicalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfoliohierarchicalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_portfolio_hierarchical_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceportfoliohierarchicalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_portfolio_hierarchical_matrix_identity(n : Int) -> FinanceportfoliohierarchicalMatrix {
  let m = finance_portfolio_hierarchical_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_portfolio_hierarchical_matrix_get(m : FinanceportfoliohierarchicalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_portfolio_hierarchical_matrix_transpose(m : FinanceportfoliohierarchicalMatrix) -> FinanceportfoliohierarchicalMatrix {
  let result = finance_portfolio_hierarchical_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_portfolio_hierarchical_matrix_add(a : FinanceportfoliohierarchicalMatrix, b : FinanceportfoliohierarchicalMatrix) -> FinanceportfoliohierarchicalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_portfolio_hierarchical_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_portfolio_hierarchical_matrix_scale(m : FinanceportfoliohierarchicalMatrix, s : Double) -> FinanceportfoliohierarchicalMatrix {
  let result = finance_portfolio_hierarchical_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_portfolio_hierarchical_matrix_multiply(a : FinanceportfoliohierarchicalMatrix, b : FinanceportfoliohierarchicalMatrix) -> FinanceportfoliohierarchicalMatrix {
  if a.cols != b.rows { return finance_portfolio_hierarchical_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_portfolio_hierarchical_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_portfolio_hierarchical_matrix_trace(m : FinanceportfoliohierarchicalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_portfolio_hierarchical_matrix_det(m : FinanceportfoliohierarchicalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_portfolio_hierarchical_matrix_norm(m : FinanceportfoliohierarchicalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_portfolio_hierarchical_matrix_to_string(m : FinanceportfoliohierarchicalMatrix) -> String {
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

pub(all) struct FinanceportfoliohierarchicalVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_portfolio_hierarchical_make_vector(comps : Array[Double]) -> FinanceportfoliohierarchicalVector {
  { comps, dim: comps.length() }
}

pub fn finance_portfolio_hierarchical_vector_zero(dim : Int) -> FinanceportfoliohierarchicalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_portfolio_hierarchical_vector_add(a : FinanceportfoliohierarchicalVector, b : FinanceportfoliohierarchicalVector) -> FinanceportfoliohierarchicalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_portfolio_hierarchical_vector_sub(a : FinanceportfoliohierarchicalVector, b : FinanceportfoliohierarchicalVector) -> FinanceportfoliohierarchicalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_portfolio_hierarchical_vector_scale(v : FinanceportfoliohierarchicalVector, s : Double) -> FinanceportfoliohierarchicalVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_portfolio_hierarchical_vector_dot(a : FinanceportfoliohierarchicalVector, b : FinanceportfoliohierarchicalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_portfolio_hierarchical_vector_norm(v : FinanceportfoliohierarchicalVector) -> Double { @_common.sqrt(finance_portfolio_hierarchical_vector_dot(v, v)) }

pub fn finance_portfolio_hierarchical_vector_normalize(v : FinanceportfoliohierarchicalVector) -> FinanceportfoliohierarchicalVector {
  let n = finance_portfolio_hierarchical_vector_norm(v)
  if n < 0.0000001 { v } else { finance_portfolio_hierarchical_vector_scale(v, 1.0 / n) }
}

pub fn finance_portfolio_hierarchical_vector_dist(a : FinanceportfoliohierarchicalVector, b : FinanceportfoliohierarchicalVector) -> Double {
  finance_portfolio_hierarchical_vector_norm(finance_portfolio_hierarchical_vector_sub(a, b))
}

pub fn finance_portfolio_hierarchical_vector_to_string(v : FinanceportfoliohierarchicalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_portfolio_hierarchical_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_portfolio_hierarchical_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_portfolio_hierarchical_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_portfolio_hierarchical_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_portfolio_hierarchical_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_portfolio_hierarchical_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_portfolio_hierarchical_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_portfolio_hierarchical_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_portfolio_hierarchical_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_portfolio_hierarchical_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_portfolio_hierarchical_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_portfolio_hierarchical_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_portfolio_hierarchical_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_portfolio_hierarchical_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_portfolio_hierarchical_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_portfolio_hierarchical_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_portfolio_hierarchical_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_portfolio_hierarchical_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_portfolio_hierarchical_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_portfolio_hierarchical_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_portfolio_hierarchical_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_portfolio_hierarchical_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_portfolio_hierarchical_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_portfolio_hierarchical_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_portfolio_hierarchical_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_portfolio_hierarchical_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_portfolio_hierarchical_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_portfolio_hierarchical_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_portfolio_hierarchical_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceportfoliohierarchicalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_hierarchical_frame_make(size : Int) -> FinanceportfoliohierarchicalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_hierarchical_frame_len(s : FinanceportfoliohierarchicalFrame) -> Int { s.size }

pub fn finance_portfolio_hierarchical_frame_get(s : FinanceportfoliohierarchicalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_hierarchical_frame_set(s : FinanceportfoliohierarchicalFrame, i : Int, v : Double) -> FinanceportfoliohierarchicalFrame {
  let result = finance_portfolio_hierarchical_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_frame_sum(s : FinanceportfoliohierarchicalFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_hierarchical_frame_mean(s : FinanceportfoliohierarchicalFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_hierarchical_frame_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_hierarchical_frame_scale(s : FinanceportfoliohierarchicalFrame, f : Double) -> FinanceportfoliohierarchicalFrame {
  let result = finance_portfolio_hierarchical_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_hierarchical_frame_add(a : FinanceportfoliohierarchicalFrame, b : FinanceportfoliohierarchicalFrame) -> FinanceportfoliohierarchicalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_hierarchical_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_frame_copy(s : FinanceportfoliohierarchicalFrame) -> FinanceportfoliohierarchicalFrame {
  let result = finance_portfolio_hierarchical_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_frame_fill(s : FinanceportfoliohierarchicalFrame, v : Double) -> FinanceportfoliohierarchicalFrame {
  let result = finance_portfolio_hierarchical_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_frame_min(s : FinanceportfoliohierarchicalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_frame_max(s : FinanceportfoliohierarchicalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_frame_to_string(s : FinanceportfoliohierarchicalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliohierarchicalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_hierarchical_table_make(size : Int) -> FinanceportfoliohierarchicalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_hierarchical_table_len(s : FinanceportfoliohierarchicalTable) -> Int { s.size }

pub fn finance_portfolio_hierarchical_table_get(s : FinanceportfoliohierarchicalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_hierarchical_table_set(s : FinanceportfoliohierarchicalTable, i : Int, v : Double) -> FinanceportfoliohierarchicalTable {
  let result = finance_portfolio_hierarchical_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_table_sum(s : FinanceportfoliohierarchicalTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_hierarchical_table_mean(s : FinanceportfoliohierarchicalTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_hierarchical_table_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_hierarchical_table_scale(s : FinanceportfoliohierarchicalTable, f : Double) -> FinanceportfoliohierarchicalTable {
  let result = finance_portfolio_hierarchical_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_hierarchical_table_add(a : FinanceportfoliohierarchicalTable, b : FinanceportfoliohierarchicalTable) -> FinanceportfoliohierarchicalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_hierarchical_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_table_copy(s : FinanceportfoliohierarchicalTable) -> FinanceportfoliohierarchicalTable {
  let result = finance_portfolio_hierarchical_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_table_fill(s : FinanceportfoliohierarchicalTable, v : Double) -> FinanceportfoliohierarchicalTable {
  let result = finance_portfolio_hierarchical_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_table_min(s : FinanceportfoliohierarchicalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_table_max(s : FinanceportfoliohierarchicalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_table_to_string(s : FinanceportfoliohierarchicalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliohierarchicalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_hierarchical_graphn_make(size : Int) -> FinanceportfoliohierarchicalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_hierarchical_graphn_len(s : FinanceportfoliohierarchicalGraphN) -> Int { s.size }

pub fn finance_portfolio_hierarchical_graphn_get(s : FinanceportfoliohierarchicalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_hierarchical_graphn_set(s : FinanceportfoliohierarchicalGraphN, i : Int, v : Double) -> FinanceportfoliohierarchicalGraphN {
  let result = finance_portfolio_hierarchical_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_graphn_sum(s : FinanceportfoliohierarchicalGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_hierarchical_graphn_mean(s : FinanceportfoliohierarchicalGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_hierarchical_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_hierarchical_graphn_scale(s : FinanceportfoliohierarchicalGraphN, f : Double) -> FinanceportfoliohierarchicalGraphN {
  let result = finance_portfolio_hierarchical_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_hierarchical_graphn_add(a : FinanceportfoliohierarchicalGraphN, b : FinanceportfoliohierarchicalGraphN) -> FinanceportfoliohierarchicalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_hierarchical_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_graphn_copy(s : FinanceportfoliohierarchicalGraphN) -> FinanceportfoliohierarchicalGraphN {
  let result = finance_portfolio_hierarchical_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_graphn_fill(s : FinanceportfoliohierarchicalGraphN, v : Double) -> FinanceportfoliohierarchicalGraphN {
  let result = finance_portfolio_hierarchical_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_graphn_min(s : FinanceportfoliohierarchicalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_graphn_max(s : FinanceportfoliohierarchicalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_graphn_to_string(s : FinanceportfoliohierarchicalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliohierarchicalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_hierarchical_node_make(size : Int) -> FinanceportfoliohierarchicalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_hierarchical_node_len(s : FinanceportfoliohierarchicalNode) -> Int { s.size }

pub fn finance_portfolio_hierarchical_node_get(s : FinanceportfoliohierarchicalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_hierarchical_node_set(s : FinanceportfoliohierarchicalNode, i : Int, v : Double) -> FinanceportfoliohierarchicalNode {
  let result = finance_portfolio_hierarchical_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_node_sum(s : FinanceportfoliohierarchicalNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_hierarchical_node_mean(s : FinanceportfoliohierarchicalNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_hierarchical_node_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_hierarchical_node_scale(s : FinanceportfoliohierarchicalNode, f : Double) -> FinanceportfoliohierarchicalNode {
  let result = finance_portfolio_hierarchical_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_hierarchical_node_add(a : FinanceportfoliohierarchicalNode, b : FinanceportfoliohierarchicalNode) -> FinanceportfoliohierarchicalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_hierarchical_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_node_copy(s : FinanceportfoliohierarchicalNode) -> FinanceportfoliohierarchicalNode {
  let result = finance_portfolio_hierarchical_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_node_fill(s : FinanceportfoliohierarchicalNode, v : Double) -> FinanceportfoliohierarchicalNode {
  let result = finance_portfolio_hierarchical_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_node_min(s : FinanceportfoliohierarchicalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_node_max(s : FinanceportfoliohierarchicalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_node_to_string(s : FinanceportfoliohierarchicalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliohierarchicalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_hierarchical_edge_make(size : Int) -> FinanceportfoliohierarchicalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_hierarchical_edge_len(s : FinanceportfoliohierarchicalEdge) -> Int { s.size }

pub fn finance_portfolio_hierarchical_edge_get(s : FinanceportfoliohierarchicalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_hierarchical_edge_set(s : FinanceportfoliohierarchicalEdge, i : Int, v : Double) -> FinanceportfoliohierarchicalEdge {
  let result = finance_portfolio_hierarchical_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_edge_sum(s : FinanceportfoliohierarchicalEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_hierarchical_edge_mean(s : FinanceportfoliohierarchicalEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_hierarchical_edge_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_hierarchical_edge_scale(s : FinanceportfoliohierarchicalEdge, f : Double) -> FinanceportfoliohierarchicalEdge {
  let result = finance_portfolio_hierarchical_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_hierarchical_edge_add(a : FinanceportfoliohierarchicalEdge, b : FinanceportfoliohierarchicalEdge) -> FinanceportfoliohierarchicalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_hierarchical_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_edge_copy(s : FinanceportfoliohierarchicalEdge) -> FinanceportfoliohierarchicalEdge {
  let result = finance_portfolio_hierarchical_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_edge_fill(s : FinanceportfoliohierarchicalEdge, v : Double) -> FinanceportfoliohierarchicalEdge {
  let result = finance_portfolio_hierarchical_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_edge_min(s : FinanceportfoliohierarchicalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_edge_max(s : FinanceportfoliohierarchicalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_edge_to_string(s : FinanceportfoliohierarchicalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliohierarchicalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_hierarchical_path_make(size : Int) -> FinanceportfoliohierarchicalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_hierarchical_path_len(s : FinanceportfoliohierarchicalPath) -> Int { s.size }

pub fn finance_portfolio_hierarchical_path_get(s : FinanceportfoliohierarchicalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_hierarchical_path_set(s : FinanceportfoliohierarchicalPath, i : Int, v : Double) -> FinanceportfoliohierarchicalPath {
  let result = finance_portfolio_hierarchical_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_path_sum(s : FinanceportfoliohierarchicalPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_hierarchical_path_mean(s : FinanceportfoliohierarchicalPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_hierarchical_path_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_hierarchical_path_scale(s : FinanceportfoliohierarchicalPath, f : Double) -> FinanceportfoliohierarchicalPath {
  let result = finance_portfolio_hierarchical_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_hierarchical_path_add(a : FinanceportfoliohierarchicalPath, b : FinanceportfoliohierarchicalPath) -> FinanceportfoliohierarchicalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_hierarchical_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_path_copy(s : FinanceportfoliohierarchicalPath) -> FinanceportfoliohierarchicalPath {
  let result = finance_portfolio_hierarchical_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_path_fill(s : FinanceportfoliohierarchicalPath, v : Double) -> FinanceportfoliohierarchicalPath {
  let result = finance_portfolio_hierarchical_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_path_min(s : FinanceportfoliohierarchicalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_path_max(s : FinanceportfoliohierarchicalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_path_to_string(s : FinanceportfoliohierarchicalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliohierarchicalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_hierarchical_cluster_make(size : Int) -> FinanceportfoliohierarchicalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_hierarchical_cluster_len(s : FinanceportfoliohierarchicalCluster) -> Int { s.size }

pub fn finance_portfolio_hierarchical_cluster_get(s : FinanceportfoliohierarchicalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_hierarchical_cluster_set(s : FinanceportfoliohierarchicalCluster, i : Int, v : Double) -> FinanceportfoliohierarchicalCluster {
  let result = finance_portfolio_hierarchical_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_cluster_sum(s : FinanceportfoliohierarchicalCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_hierarchical_cluster_mean(s : FinanceportfoliohierarchicalCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_hierarchical_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_hierarchical_cluster_scale(s : FinanceportfoliohierarchicalCluster, f : Double) -> FinanceportfoliohierarchicalCluster {
  let result = finance_portfolio_hierarchical_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_hierarchical_cluster_add(a : FinanceportfoliohierarchicalCluster, b : FinanceportfoliohierarchicalCluster) -> FinanceportfoliohierarchicalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_hierarchical_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_cluster_copy(s : FinanceportfoliohierarchicalCluster) -> FinanceportfoliohierarchicalCluster {
  let result = finance_portfolio_hierarchical_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_cluster_fill(s : FinanceportfoliohierarchicalCluster, v : Double) -> FinanceportfoliohierarchicalCluster {
  let result = finance_portfolio_hierarchical_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_cluster_min(s : FinanceportfoliohierarchicalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_cluster_max(s : FinanceportfoliohierarchicalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_cluster_to_string(s : FinanceportfoliohierarchicalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliohierarchicalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_hierarchical_model_make(size : Int) -> FinanceportfoliohierarchicalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_hierarchical_model_len(s : FinanceportfoliohierarchicalModel) -> Int { s.size }

pub fn finance_portfolio_hierarchical_model_get(s : FinanceportfoliohierarchicalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_hierarchical_model_set(s : FinanceportfoliohierarchicalModel, i : Int, v : Double) -> FinanceportfoliohierarchicalModel {
  let result = finance_portfolio_hierarchical_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_model_sum(s : FinanceportfoliohierarchicalModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_hierarchical_model_mean(s : FinanceportfoliohierarchicalModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_hierarchical_model_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_hierarchical_model_scale(s : FinanceportfoliohierarchicalModel, f : Double) -> FinanceportfoliohierarchicalModel {
  let result = finance_portfolio_hierarchical_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_hierarchical_model_add(a : FinanceportfoliohierarchicalModel, b : FinanceportfoliohierarchicalModel) -> FinanceportfoliohierarchicalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_hierarchical_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_model_copy(s : FinanceportfoliohierarchicalModel) -> FinanceportfoliohierarchicalModel {
  let result = finance_portfolio_hierarchical_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_model_fill(s : FinanceportfoliohierarchicalModel, v : Double) -> FinanceportfoliohierarchicalModel {
  let result = finance_portfolio_hierarchical_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_model_min(s : FinanceportfoliohierarchicalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_model_max(s : FinanceportfoliohierarchicalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_model_to_string(s : FinanceportfoliohierarchicalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliohierarchicalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_hierarchical_layer_make(size : Int) -> FinanceportfoliohierarchicalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_hierarchical_layer_len(s : FinanceportfoliohierarchicalLayer) -> Int { s.size }

pub fn finance_portfolio_hierarchical_layer_get(s : FinanceportfoliohierarchicalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_hierarchical_layer_set(s : FinanceportfoliohierarchicalLayer, i : Int, v : Double) -> FinanceportfoliohierarchicalLayer {
  let result = finance_portfolio_hierarchical_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_layer_sum(s : FinanceportfoliohierarchicalLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_hierarchical_layer_mean(s : FinanceportfoliohierarchicalLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_hierarchical_layer_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_hierarchical_layer_scale(s : FinanceportfoliohierarchicalLayer, f : Double) -> FinanceportfoliohierarchicalLayer {
  let result = finance_portfolio_hierarchical_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_hierarchical_layer_add(a : FinanceportfoliohierarchicalLayer, b : FinanceportfoliohierarchicalLayer) -> FinanceportfoliohierarchicalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_hierarchical_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_layer_copy(s : FinanceportfoliohierarchicalLayer) -> FinanceportfoliohierarchicalLayer {
  let result = finance_portfolio_hierarchical_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_layer_fill(s : FinanceportfoliohierarchicalLayer, v : Double) -> FinanceportfoliohierarchicalLayer {
  let result = finance_portfolio_hierarchical_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_layer_min(s : FinanceportfoliohierarchicalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_layer_max(s : FinanceportfoliohierarchicalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_layer_to_string(s : FinanceportfoliohierarchicalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliohierarchicalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_hierarchical_buffer_make(size : Int) -> FinanceportfoliohierarchicalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_hierarchical_buffer_len(s : FinanceportfoliohierarchicalBuffer) -> Int { s.size }

pub fn finance_portfolio_hierarchical_buffer_get(s : FinanceportfoliohierarchicalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_hierarchical_buffer_set(s : FinanceportfoliohierarchicalBuffer, i : Int, v : Double) -> FinanceportfoliohierarchicalBuffer {
  let result = finance_portfolio_hierarchical_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_buffer_sum(s : FinanceportfoliohierarchicalBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_hierarchical_buffer_mean(s : FinanceportfoliohierarchicalBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_hierarchical_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_hierarchical_buffer_scale(s : FinanceportfoliohierarchicalBuffer, f : Double) -> FinanceportfoliohierarchicalBuffer {
  let result = finance_portfolio_hierarchical_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_hierarchical_buffer_add(a : FinanceportfoliohierarchicalBuffer, b : FinanceportfoliohierarchicalBuffer) -> FinanceportfoliohierarchicalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_hierarchical_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_buffer_copy(s : FinanceportfoliohierarchicalBuffer) -> FinanceportfoliohierarchicalBuffer {
  let result = finance_portfolio_hierarchical_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_buffer_fill(s : FinanceportfoliohierarchicalBuffer, v : Double) -> FinanceportfoliohierarchicalBuffer {
  let result = finance_portfolio_hierarchical_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_buffer_min(s : FinanceportfoliohierarchicalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_buffer_max(s : FinanceportfoliohierarchicalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_buffer_to_string(s : FinanceportfoliohierarchicalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliohierarchicalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_hierarchical_cursor_make(size : Int) -> FinanceportfoliohierarchicalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_hierarchical_cursor_len(s : FinanceportfoliohierarchicalCursor) -> Int { s.size }

pub fn finance_portfolio_hierarchical_cursor_get(s : FinanceportfoliohierarchicalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_hierarchical_cursor_set(s : FinanceportfoliohierarchicalCursor, i : Int, v : Double) -> FinanceportfoliohierarchicalCursor {
  let result = finance_portfolio_hierarchical_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_cursor_sum(s : FinanceportfoliohierarchicalCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_hierarchical_cursor_mean(s : FinanceportfoliohierarchicalCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_hierarchical_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_hierarchical_cursor_scale(s : FinanceportfoliohierarchicalCursor, f : Double) -> FinanceportfoliohierarchicalCursor {
  let result = finance_portfolio_hierarchical_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_hierarchical_cursor_add(a : FinanceportfoliohierarchicalCursor, b : FinanceportfoliohierarchicalCursor) -> FinanceportfoliohierarchicalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_hierarchical_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_cursor_copy(s : FinanceportfoliohierarchicalCursor) -> FinanceportfoliohierarchicalCursor {
  let result = finance_portfolio_hierarchical_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_cursor_fill(s : FinanceportfoliohierarchicalCursor, v : Double) -> FinanceportfoliohierarchicalCursor {
  let result = finance_portfolio_hierarchical_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_cursor_min(s : FinanceportfoliohierarchicalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_cursor_max(s : FinanceportfoliohierarchicalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_cursor_to_string(s : FinanceportfoliohierarchicalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliohierarchicalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_hierarchical_view_make(size : Int) -> FinanceportfoliohierarchicalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_hierarchical_view_len(s : FinanceportfoliohierarchicalView) -> Int { s.size }

pub fn finance_portfolio_hierarchical_view_get(s : FinanceportfoliohierarchicalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_hierarchical_view_set(s : FinanceportfoliohierarchicalView, i : Int, v : Double) -> FinanceportfoliohierarchicalView {
  let result = finance_portfolio_hierarchical_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_view_sum(s : FinanceportfoliohierarchicalView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_hierarchical_view_mean(s : FinanceportfoliohierarchicalView) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_hierarchical_view_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_hierarchical_view_scale(s : FinanceportfoliohierarchicalView, f : Double) -> FinanceportfoliohierarchicalView {
  let result = finance_portfolio_hierarchical_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_hierarchical_view_add(a : FinanceportfoliohierarchicalView, b : FinanceportfoliohierarchicalView) -> FinanceportfoliohierarchicalView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_hierarchical_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_view_copy(s : FinanceportfoliohierarchicalView) -> FinanceportfoliohierarchicalView {
  let result = finance_portfolio_hierarchical_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_view_fill(s : FinanceportfoliohierarchicalView, v : Double) -> FinanceportfoliohierarchicalView {
  let result = finance_portfolio_hierarchical_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_view_min(s : FinanceportfoliohierarchicalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_view_max(s : FinanceportfoliohierarchicalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_view_to_string(s : FinanceportfoliohierarchicalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliohierarchicalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_hierarchical_range_make(size : Int) -> FinanceportfoliohierarchicalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_hierarchical_range_len(s : FinanceportfoliohierarchicalRange) -> Int { s.size }

pub fn finance_portfolio_hierarchical_range_get(s : FinanceportfoliohierarchicalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_hierarchical_range_set(s : FinanceportfoliohierarchicalRange, i : Int, v : Double) -> FinanceportfoliohierarchicalRange {
  let result = finance_portfolio_hierarchical_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_range_sum(s : FinanceportfoliohierarchicalRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_hierarchical_range_mean(s : FinanceportfoliohierarchicalRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_hierarchical_range_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_hierarchical_range_scale(s : FinanceportfoliohierarchicalRange, f : Double) -> FinanceportfoliohierarchicalRange {
  let result = finance_portfolio_hierarchical_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_hierarchical_range_add(a : FinanceportfoliohierarchicalRange, b : FinanceportfoliohierarchicalRange) -> FinanceportfoliohierarchicalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_hierarchical_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_range_copy(s : FinanceportfoliohierarchicalRange) -> FinanceportfoliohierarchicalRange {
  let result = finance_portfolio_hierarchical_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_range_fill(s : FinanceportfoliohierarchicalRange, v : Double) -> FinanceportfoliohierarchicalRange {
  let result = finance_portfolio_hierarchical_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_range_min(s : FinanceportfoliohierarchicalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_range_max(s : FinanceportfoliohierarchicalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_range_to_string(s : FinanceportfoliohierarchicalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliohierarchicalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_hierarchical_slice_make(size : Int) -> FinanceportfoliohierarchicalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_hierarchical_slice_len(s : FinanceportfoliohierarchicalSlice) -> Int { s.size }

pub fn finance_portfolio_hierarchical_slice_get(s : FinanceportfoliohierarchicalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_hierarchical_slice_set(s : FinanceportfoliohierarchicalSlice, i : Int, v : Double) -> FinanceportfoliohierarchicalSlice {
  let result = finance_portfolio_hierarchical_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_slice_sum(s : FinanceportfoliohierarchicalSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_portfolio_hierarchical_slice_mean(s : FinanceportfoliohierarchicalSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_portfolio_hierarchical_slice_sum(s) / s.size.to_double() }
}

pub fn finance_portfolio_hierarchical_slice_scale(s : FinanceportfoliohierarchicalSlice, f : Double) -> FinanceportfoliohierarchicalSlice {
  let result = finance_portfolio_hierarchical_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_portfolio_hierarchical_slice_add(a : FinanceportfoliohierarchicalSlice, b : FinanceportfoliohierarchicalSlice) -> FinanceportfoliohierarchicalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_portfolio_hierarchical_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_slice_copy(s : FinanceportfoliohierarchicalSlice) -> FinanceportfoliohierarchicalSlice {
  let result = finance_portfolio_hierarchical_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_portfolio_hierarchical_slice_fill(s : FinanceportfoliohierarchicalSlice, v : Double) -> FinanceportfoliohierarchicalSlice {
  let result = finance_portfolio_hierarchical_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_portfolio_hierarchical_slice_min(s : FinanceportfoliohierarchicalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_slice_max(s : FinanceportfoliohierarchicalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_portfolio_hierarchical_slice_to_string(s : FinanceportfoliohierarchicalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

