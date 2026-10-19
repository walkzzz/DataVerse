///===
/// extcore/finance_time_regime

pub(all) struct FinancetimeregimePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_regime_make_point(x : Double, y : Double) -> FinancetimeregimePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_regime_make_point3(x : Double, y : Double, z : Double) -> FinancetimeregimePoint {
  { x, y, z, label: 0 }
}

pub fn finance_time_regime_point_x(pt : FinancetimeregimePoint) -> Double { pt.x }

pub fn finance_time_regime_point_y(pt : FinancetimeregimePoint) -> Double { pt.y }

pub fn finance_time_regime_point_z(pt : FinancetimeregimePoint) -> Double { pt.z }

pub fn finance_time_regime_point_label(pt : FinancetimeregimePoint) -> Int { pt.label }

pub fn finance_time_regime_point_dist(a : FinancetimeregimePoint, b : FinancetimeregimePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_time_regime_point_add(a : FinancetimeregimePoint, b : FinancetimeregimePoint) -> FinancetimeregimePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_time_regime_point_sub(a : FinancetimeregimePoint, b : FinancetimeregimePoint) -> FinancetimeregimePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_time_regime_point_scale(pt : FinancetimeregimePoint, s : Double) -> FinancetimeregimePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_time_regime_point_dot(a : FinancetimeregimePoint, b : FinancetimeregimePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_time_regime_point_cross(a : FinancetimeregimePoint, b : FinancetimeregimePoint) -> FinancetimeregimePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_time_regime_point_norm(pt : FinancetimeregimePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_time_regime_point_normalize(pt : FinancetimeregimePoint) -> FinancetimeregimePoint {
  let n = finance_time_regime_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_time_regime_point_scale(pt, 1.0 / n) }
}

pub fn finance_time_regime_point_negate(pt : FinancetimeregimePoint) -> FinancetimeregimePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_time_regime_point_mid(a : FinancetimeregimePoint, b : FinancetimeregimePoint) -> FinancetimeregimePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_time_regime_point_lerp(a : FinancetimeregimePoint, b : FinancetimeregimePoint, t : Double) -> FinancetimeregimePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_time_regime_point_to_string(pt : FinancetimeregimePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancetimeregimeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_regime_make_series(vals : Array[Double], name : String) -> FinancetimeregimeSeries {
  { vals, name, meta: 0 }
}

pub fn finance_time_regime_series_len(s : FinancetimeregimeSeries) -> Int { s.vals.length() }

pub fn finance_time_regime_series_sum(s : FinancetimeregimeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_time_regime_series_mean(s : FinancetimeregimeSeries) -> Double {
  let n = finance_time_regime_series_len(s)
  if n == 0 { 0.0 } else { finance_time_regime_series_sum(s) / n.to_double() }
}

pub fn finance_time_regime_series_min(s : FinancetimeregimeSeries) -> Double {
  let n = finance_time_regime_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_time_regime_series_max(s : FinancetimeregimeSeries) -> Double {
  let n = finance_time_regime_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_time_regime_series_range(s : FinancetimeregimeSeries) -> Double {
  finance_time_regime_series_max(s) - finance_time_regime_series_min(s)
}

pub fn finance_time_regime_series_var(s : FinancetimeregimeSeries) -> Double {
  let n = finance_time_regime_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_time_regime_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_time_regime_series_std(s : FinancetimeregimeSeries) -> Double { @_common.sqrt(finance_time_regime_series_var(s)) }

pub fn finance_time_regime_series_median(s : FinancetimeregimeSeries) -> Double {
  let n = finance_time_regime_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_time_regime_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_time_regime_series_scale(s : FinancetimeregimeSeries, f : Double) -> FinancetimeregimeSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_time_regime_series_add(a : FinancetimeregimeSeries, b : FinancetimeregimeSeries) -> FinancetimeregimeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_time_regime_series_sub(a : FinancetimeregimeSeries, b : FinancetimeregimeSeries) -> FinancetimeregimeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_time_regime_series_normalize(s : FinancetimeregimeSeries) -> FinancetimeregimeSeries {
  let mn = finance_time_regime_series_min(s)
  let mx = finance_time_regime_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_time_regime_series_cumsum(s : FinancetimeregimeSeries) -> FinancetimeregimeSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_time_regime_series_to_string(s : FinancetimeregimeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimeregimeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_regime_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimeregimeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_regime_matrix_identity(n : Int) -> FinancetimeregimeMatrix {
  let m = finance_time_regime_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_time_regime_matrix_get(m : FinancetimeregimeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_time_regime_matrix_transpose(m : FinancetimeregimeMatrix) -> FinancetimeregimeMatrix {
  let result = finance_time_regime_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_time_regime_matrix_add(a : FinancetimeregimeMatrix, b : FinancetimeregimeMatrix) -> FinancetimeregimeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_time_regime_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_time_regime_matrix_scale(m : FinancetimeregimeMatrix, s : Double) -> FinancetimeregimeMatrix {
  let result = finance_time_regime_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_time_regime_matrix_multiply(a : FinancetimeregimeMatrix, b : FinancetimeregimeMatrix) -> FinancetimeregimeMatrix {
  if a.cols != b.rows { return finance_time_regime_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_time_regime_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_time_regime_matrix_trace(m : FinancetimeregimeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_time_regime_matrix_det(m : FinancetimeregimeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_time_regime_matrix_norm(m : FinancetimeregimeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_time_regime_matrix_to_string(m : FinancetimeregimeMatrix) -> String {
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

pub(all) struct FinancetimeregimeVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_regime_make_vector(comps : Array[Double]) -> FinancetimeregimeVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_regime_vector_zero(dim : Int) -> FinancetimeregimeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_time_regime_vector_add(a : FinancetimeregimeVector, b : FinancetimeregimeVector) -> FinancetimeregimeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_regime_vector_sub(a : FinancetimeregimeVector, b : FinancetimeregimeVector) -> FinancetimeregimeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_regime_vector_scale(v : FinancetimeregimeVector, s : Double) -> FinancetimeregimeVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_time_regime_vector_dot(a : FinancetimeregimeVector, b : FinancetimeregimeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_time_regime_vector_norm(v : FinancetimeregimeVector) -> Double { @_common.sqrt(finance_time_regime_vector_dot(v, v)) }

pub fn finance_time_regime_vector_normalize(v : FinancetimeregimeVector) -> FinancetimeregimeVector {
  let n = finance_time_regime_vector_norm(v)
  if n < 0.0000001 { v } else { finance_time_regime_vector_scale(v, 1.0 / n) }
}

pub fn finance_time_regime_vector_dist(a : FinancetimeregimeVector, b : FinancetimeregimeVector) -> Double {
  finance_time_regime_vector_norm(finance_time_regime_vector_sub(a, b))
}

pub fn finance_time_regime_vector_to_string(v : FinancetimeregimeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_time_regime_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_time_regime_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_time_regime_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_time_regime_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_time_regime_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_time_regime_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_time_regime_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_time_regime_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_time_regime_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_time_regime_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_time_regime_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_time_regime_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_time_regime_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_time_regime_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_time_regime_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_time_regime_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_time_regime_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_time_regime_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_time_regime_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_time_regime_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_time_regime_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_time_regime_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_time_regime_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_time_regime_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_time_regime_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_time_regime_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_time_regime_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_time_regime_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_time_regime_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancetimeregimeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_frame_make(size : Int) -> FinancetimeregimeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_frame_len(s : FinancetimeregimeFrame) -> Int { s.size }

pub fn finance_time_regime_frame_get(s : FinancetimeregimeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_frame_set(s : FinancetimeregimeFrame, i : Int, v : Double) -> FinancetimeregimeFrame {
  let result = finance_time_regime_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_frame_sum(s : FinancetimeregimeFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_regime_frame_mean(s : FinancetimeregimeFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_regime_frame_sum(s) / s.size.to_double() }
}

pub fn finance_time_regime_frame_scale(s : FinancetimeregimeFrame, f : Double) -> FinancetimeregimeFrame {
  let result = finance_time_regime_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_regime_frame_add(a : FinancetimeregimeFrame, b : FinancetimeregimeFrame) -> FinancetimeregimeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_regime_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_regime_frame_copy(s : FinancetimeregimeFrame) -> FinancetimeregimeFrame {
  let result = finance_time_regime_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_regime_frame_fill(s : FinancetimeregimeFrame, v : Double) -> FinancetimeregimeFrame {
  let result = finance_time_regime_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_frame_min(s : FinancetimeregimeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_frame_max(s : FinancetimeregimeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_frame_to_string(s : FinancetimeregimeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_table_make(size : Int) -> FinancetimeregimeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_table_len(s : FinancetimeregimeTable) -> Int { s.size }

pub fn finance_time_regime_table_get(s : FinancetimeregimeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_table_set(s : FinancetimeregimeTable, i : Int, v : Double) -> FinancetimeregimeTable {
  let result = finance_time_regime_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_table_sum(s : FinancetimeregimeTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_regime_table_mean(s : FinancetimeregimeTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_regime_table_sum(s) / s.size.to_double() }
}

pub fn finance_time_regime_table_scale(s : FinancetimeregimeTable, f : Double) -> FinancetimeregimeTable {
  let result = finance_time_regime_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_regime_table_add(a : FinancetimeregimeTable, b : FinancetimeregimeTable) -> FinancetimeregimeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_regime_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_regime_table_copy(s : FinancetimeregimeTable) -> FinancetimeregimeTable {
  let result = finance_time_regime_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_regime_table_fill(s : FinancetimeregimeTable, v : Double) -> FinancetimeregimeTable {
  let result = finance_time_regime_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_table_min(s : FinancetimeregimeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_table_max(s : FinancetimeregimeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_table_to_string(s : FinancetimeregimeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_graphn_make(size : Int) -> FinancetimeregimeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_graphn_len(s : FinancetimeregimeGraphN) -> Int { s.size }

pub fn finance_time_regime_graphn_get(s : FinancetimeregimeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_graphn_set(s : FinancetimeregimeGraphN, i : Int, v : Double) -> FinancetimeregimeGraphN {
  let result = finance_time_regime_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_graphn_sum(s : FinancetimeregimeGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_regime_graphn_mean(s : FinancetimeregimeGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_regime_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_time_regime_graphn_scale(s : FinancetimeregimeGraphN, f : Double) -> FinancetimeregimeGraphN {
  let result = finance_time_regime_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_regime_graphn_add(a : FinancetimeregimeGraphN, b : FinancetimeregimeGraphN) -> FinancetimeregimeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_regime_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_regime_graphn_copy(s : FinancetimeregimeGraphN) -> FinancetimeregimeGraphN {
  let result = finance_time_regime_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_regime_graphn_fill(s : FinancetimeregimeGraphN, v : Double) -> FinancetimeregimeGraphN {
  let result = finance_time_regime_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_graphn_min(s : FinancetimeregimeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_graphn_max(s : FinancetimeregimeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_graphn_to_string(s : FinancetimeregimeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_node_make(size : Int) -> FinancetimeregimeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_node_len(s : FinancetimeregimeNode) -> Int { s.size }

pub fn finance_time_regime_node_get(s : FinancetimeregimeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_node_set(s : FinancetimeregimeNode, i : Int, v : Double) -> FinancetimeregimeNode {
  let result = finance_time_regime_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_node_sum(s : FinancetimeregimeNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_regime_node_mean(s : FinancetimeregimeNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_regime_node_sum(s) / s.size.to_double() }
}

pub fn finance_time_regime_node_scale(s : FinancetimeregimeNode, f : Double) -> FinancetimeregimeNode {
  let result = finance_time_regime_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_regime_node_add(a : FinancetimeregimeNode, b : FinancetimeregimeNode) -> FinancetimeregimeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_regime_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_regime_node_copy(s : FinancetimeregimeNode) -> FinancetimeregimeNode {
  let result = finance_time_regime_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_regime_node_fill(s : FinancetimeregimeNode, v : Double) -> FinancetimeregimeNode {
  let result = finance_time_regime_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_node_min(s : FinancetimeregimeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_node_max(s : FinancetimeregimeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_node_to_string(s : FinancetimeregimeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_edge_make(size : Int) -> FinancetimeregimeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_edge_len(s : FinancetimeregimeEdge) -> Int { s.size }

pub fn finance_time_regime_edge_get(s : FinancetimeregimeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_edge_set(s : FinancetimeregimeEdge, i : Int, v : Double) -> FinancetimeregimeEdge {
  let result = finance_time_regime_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_edge_sum(s : FinancetimeregimeEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_regime_edge_mean(s : FinancetimeregimeEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_regime_edge_sum(s) / s.size.to_double() }
}

pub fn finance_time_regime_edge_scale(s : FinancetimeregimeEdge, f : Double) -> FinancetimeregimeEdge {
  let result = finance_time_regime_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_regime_edge_add(a : FinancetimeregimeEdge, b : FinancetimeregimeEdge) -> FinancetimeregimeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_regime_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_regime_edge_copy(s : FinancetimeregimeEdge) -> FinancetimeregimeEdge {
  let result = finance_time_regime_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_regime_edge_fill(s : FinancetimeregimeEdge, v : Double) -> FinancetimeregimeEdge {
  let result = finance_time_regime_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_edge_min(s : FinancetimeregimeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_edge_max(s : FinancetimeregimeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_edge_to_string(s : FinancetimeregimeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_path_make(size : Int) -> FinancetimeregimePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_path_len(s : FinancetimeregimePath) -> Int { s.size }

pub fn finance_time_regime_path_get(s : FinancetimeregimePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_path_set(s : FinancetimeregimePath, i : Int, v : Double) -> FinancetimeregimePath {
  let result = finance_time_regime_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_path_sum(s : FinancetimeregimePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_regime_path_mean(s : FinancetimeregimePath) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_regime_path_sum(s) / s.size.to_double() }
}

pub fn finance_time_regime_path_scale(s : FinancetimeregimePath, f : Double) -> FinancetimeregimePath {
  let result = finance_time_regime_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_regime_path_add(a : FinancetimeregimePath, b : FinancetimeregimePath) -> FinancetimeregimePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_regime_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_regime_path_copy(s : FinancetimeregimePath) -> FinancetimeregimePath {
  let result = finance_time_regime_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_regime_path_fill(s : FinancetimeregimePath, v : Double) -> FinancetimeregimePath {
  let result = finance_time_regime_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_path_min(s : FinancetimeregimePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_path_max(s : FinancetimeregimePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_path_to_string(s : FinancetimeregimePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_cluster_make(size : Int) -> FinancetimeregimeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_cluster_len(s : FinancetimeregimeCluster) -> Int { s.size }

pub fn finance_time_regime_cluster_get(s : FinancetimeregimeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_cluster_set(s : FinancetimeregimeCluster, i : Int, v : Double) -> FinancetimeregimeCluster {
  let result = finance_time_regime_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_cluster_sum(s : FinancetimeregimeCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_regime_cluster_mean(s : FinancetimeregimeCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_regime_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_time_regime_cluster_scale(s : FinancetimeregimeCluster, f : Double) -> FinancetimeregimeCluster {
  let result = finance_time_regime_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_regime_cluster_add(a : FinancetimeregimeCluster, b : FinancetimeregimeCluster) -> FinancetimeregimeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_regime_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_regime_cluster_copy(s : FinancetimeregimeCluster) -> FinancetimeregimeCluster {
  let result = finance_time_regime_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_regime_cluster_fill(s : FinancetimeregimeCluster, v : Double) -> FinancetimeregimeCluster {
  let result = finance_time_regime_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_cluster_min(s : FinancetimeregimeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_cluster_max(s : FinancetimeregimeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_cluster_to_string(s : FinancetimeregimeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_model_make(size : Int) -> FinancetimeregimeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_model_len(s : FinancetimeregimeModel) -> Int { s.size }

pub fn finance_time_regime_model_get(s : FinancetimeregimeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_model_set(s : FinancetimeregimeModel, i : Int, v : Double) -> FinancetimeregimeModel {
  let result = finance_time_regime_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_model_sum(s : FinancetimeregimeModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_regime_model_mean(s : FinancetimeregimeModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_regime_model_sum(s) / s.size.to_double() }
}

pub fn finance_time_regime_model_scale(s : FinancetimeregimeModel, f : Double) -> FinancetimeregimeModel {
  let result = finance_time_regime_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_regime_model_add(a : FinancetimeregimeModel, b : FinancetimeregimeModel) -> FinancetimeregimeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_regime_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_regime_model_copy(s : FinancetimeregimeModel) -> FinancetimeregimeModel {
  let result = finance_time_regime_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_regime_model_fill(s : FinancetimeregimeModel, v : Double) -> FinancetimeregimeModel {
  let result = finance_time_regime_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_model_min(s : FinancetimeregimeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_model_max(s : FinancetimeregimeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_model_to_string(s : FinancetimeregimeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_layer_make(size : Int) -> FinancetimeregimeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_layer_len(s : FinancetimeregimeLayer) -> Int { s.size }

pub fn finance_time_regime_layer_get(s : FinancetimeregimeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_layer_set(s : FinancetimeregimeLayer, i : Int, v : Double) -> FinancetimeregimeLayer {
  let result = finance_time_regime_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_layer_sum(s : FinancetimeregimeLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_regime_layer_mean(s : FinancetimeregimeLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_regime_layer_sum(s) / s.size.to_double() }
}

pub fn finance_time_regime_layer_scale(s : FinancetimeregimeLayer, f : Double) -> FinancetimeregimeLayer {
  let result = finance_time_regime_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_regime_layer_add(a : FinancetimeregimeLayer, b : FinancetimeregimeLayer) -> FinancetimeregimeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_regime_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_regime_layer_copy(s : FinancetimeregimeLayer) -> FinancetimeregimeLayer {
  let result = finance_time_regime_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_regime_layer_fill(s : FinancetimeregimeLayer, v : Double) -> FinancetimeregimeLayer {
  let result = finance_time_regime_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_layer_min(s : FinancetimeregimeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_layer_max(s : FinancetimeregimeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_layer_to_string(s : FinancetimeregimeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_buffer_make(size : Int) -> FinancetimeregimeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_buffer_len(s : FinancetimeregimeBuffer) -> Int { s.size }

pub fn finance_time_regime_buffer_get(s : FinancetimeregimeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_buffer_set(s : FinancetimeregimeBuffer, i : Int, v : Double) -> FinancetimeregimeBuffer {
  let result = finance_time_regime_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_buffer_sum(s : FinancetimeregimeBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_regime_buffer_mean(s : FinancetimeregimeBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_regime_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_time_regime_buffer_scale(s : FinancetimeregimeBuffer, f : Double) -> FinancetimeregimeBuffer {
  let result = finance_time_regime_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_regime_buffer_add(a : FinancetimeregimeBuffer, b : FinancetimeregimeBuffer) -> FinancetimeregimeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_regime_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_regime_buffer_copy(s : FinancetimeregimeBuffer) -> FinancetimeregimeBuffer {
  let result = finance_time_regime_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_regime_buffer_fill(s : FinancetimeregimeBuffer, v : Double) -> FinancetimeregimeBuffer {
  let result = finance_time_regime_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_buffer_min(s : FinancetimeregimeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_buffer_max(s : FinancetimeregimeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_buffer_to_string(s : FinancetimeregimeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_cursor_make(size : Int) -> FinancetimeregimeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_cursor_len(s : FinancetimeregimeCursor) -> Int { s.size }

pub fn finance_time_regime_cursor_get(s : FinancetimeregimeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_cursor_set(s : FinancetimeregimeCursor, i : Int, v : Double) -> FinancetimeregimeCursor {
  let result = finance_time_regime_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_cursor_sum(s : FinancetimeregimeCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_regime_cursor_mean(s : FinancetimeregimeCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_regime_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_time_regime_cursor_scale(s : FinancetimeregimeCursor, f : Double) -> FinancetimeregimeCursor {
  let result = finance_time_regime_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_regime_cursor_add(a : FinancetimeregimeCursor, b : FinancetimeregimeCursor) -> FinancetimeregimeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_regime_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_regime_cursor_copy(s : FinancetimeregimeCursor) -> FinancetimeregimeCursor {
  let result = finance_time_regime_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_regime_cursor_fill(s : FinancetimeregimeCursor, v : Double) -> FinancetimeregimeCursor {
  let result = finance_time_regime_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_cursor_min(s : FinancetimeregimeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_cursor_max(s : FinancetimeregimeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_cursor_to_string(s : FinancetimeregimeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_view_make(size : Int) -> FinancetimeregimeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_view_len(s : FinancetimeregimeView) -> Int { s.size }

pub fn finance_time_regime_view_get(s : FinancetimeregimeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_view_set(s : FinancetimeregimeView, i : Int, v : Double) -> FinancetimeregimeView {
  let result = finance_time_regime_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_view_sum(s : FinancetimeregimeView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_regime_view_mean(s : FinancetimeregimeView) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_regime_view_sum(s) / s.size.to_double() }
}

pub fn finance_time_regime_view_scale(s : FinancetimeregimeView, f : Double) -> FinancetimeregimeView {
  let result = finance_time_regime_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_regime_view_add(a : FinancetimeregimeView, b : FinancetimeregimeView) -> FinancetimeregimeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_regime_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_regime_view_copy(s : FinancetimeregimeView) -> FinancetimeregimeView {
  let result = finance_time_regime_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_regime_view_fill(s : FinancetimeregimeView, v : Double) -> FinancetimeregimeView {
  let result = finance_time_regime_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_view_min(s : FinancetimeregimeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_view_max(s : FinancetimeregimeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_view_to_string(s : FinancetimeregimeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_range_make(size : Int) -> FinancetimeregimeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_range_len(s : FinancetimeregimeRange) -> Int { s.size }

pub fn finance_time_regime_range_get(s : FinancetimeregimeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_range_set(s : FinancetimeregimeRange, i : Int, v : Double) -> FinancetimeregimeRange {
  let result = finance_time_regime_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_range_sum(s : FinancetimeregimeRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_regime_range_mean(s : FinancetimeregimeRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_regime_range_sum(s) / s.size.to_double() }
}

pub fn finance_time_regime_range_scale(s : FinancetimeregimeRange, f : Double) -> FinancetimeregimeRange {
  let result = finance_time_regime_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_regime_range_add(a : FinancetimeregimeRange, b : FinancetimeregimeRange) -> FinancetimeregimeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_regime_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_regime_range_copy(s : FinancetimeregimeRange) -> FinancetimeregimeRange {
  let result = finance_time_regime_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_regime_range_fill(s : FinancetimeregimeRange, v : Double) -> FinancetimeregimeRange {
  let result = finance_time_regime_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_range_min(s : FinancetimeregimeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_range_max(s : FinancetimeregimeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_range_to_string(s : FinancetimeregimeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_slice_make(size : Int) -> FinancetimeregimeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_slice_len(s : FinancetimeregimeSlice) -> Int { s.size }

pub fn finance_time_regime_slice_get(s : FinancetimeregimeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_slice_set(s : FinancetimeregimeSlice, i : Int, v : Double) -> FinancetimeregimeSlice {
  let result = finance_time_regime_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_slice_sum(s : FinancetimeregimeSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_regime_slice_mean(s : FinancetimeregimeSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_regime_slice_sum(s) / s.size.to_double() }
}

pub fn finance_time_regime_slice_scale(s : FinancetimeregimeSlice, f : Double) -> FinancetimeregimeSlice {
  let result = finance_time_regime_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_regime_slice_add(a : FinancetimeregimeSlice, b : FinancetimeregimeSlice) -> FinancetimeregimeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_regime_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_regime_slice_copy(s : FinancetimeregimeSlice) -> FinancetimeregimeSlice {
  let result = finance_time_regime_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_regime_slice_fill(s : FinancetimeregimeSlice, v : Double) -> FinancetimeregimeSlice {
  let result = finance_time_regime_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_regime_slice_min(s : FinancetimeregimeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_slice_max(s : FinancetimeregimeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_regime_slice_to_string(s : FinancetimeregimeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

