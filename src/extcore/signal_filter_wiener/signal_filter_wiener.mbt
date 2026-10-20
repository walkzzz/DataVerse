///===
/// extcore/signal_filter_wiener

pub(all) struct SignalfilterwienerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_wiener_make_point(x : Double, y : Double) -> SignalfilterwienerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_wiener_make_point3(x : Double, y : Double, z : Double) -> SignalfilterwienerPoint {
  { x, y, z, label: 0 }
}

pub fn signal_filter_wiener_point_x(pt : SignalfilterwienerPoint) -> Double { pt.x }

pub fn signal_filter_wiener_point_y(pt : SignalfilterwienerPoint) -> Double { pt.y }

pub fn signal_filter_wiener_point_z(pt : SignalfilterwienerPoint) -> Double { pt.z }

pub fn signal_filter_wiener_point_label(pt : SignalfilterwienerPoint) -> Int { pt.label }

pub fn signal_filter_wiener_point_dist(a : SignalfilterwienerPoint, b : SignalfilterwienerPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_filter_wiener_point_add(a : SignalfilterwienerPoint, b : SignalfilterwienerPoint) -> SignalfilterwienerPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_filter_wiener_point_sub(a : SignalfilterwienerPoint, b : SignalfilterwienerPoint) -> SignalfilterwienerPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_filter_wiener_point_scale(pt : SignalfilterwienerPoint, s : Double) -> SignalfilterwienerPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_filter_wiener_point_dot(a : SignalfilterwienerPoint, b : SignalfilterwienerPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_filter_wiener_point_cross(a : SignalfilterwienerPoint, b : SignalfilterwienerPoint) -> SignalfilterwienerPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_filter_wiener_point_norm(pt : SignalfilterwienerPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_filter_wiener_point_normalize(pt : SignalfilterwienerPoint) -> SignalfilterwienerPoint {
  let n = signal_filter_wiener_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_filter_wiener_point_scale(pt, 1.0 / n) }
}

pub fn signal_filter_wiener_point_negate(pt : SignalfilterwienerPoint) -> SignalfilterwienerPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_filter_wiener_point_mid(a : SignalfilterwienerPoint, b : SignalfilterwienerPoint) -> SignalfilterwienerPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_filter_wiener_point_lerp(a : SignalfilterwienerPoint, b : SignalfilterwienerPoint, t : Double) -> SignalfilterwienerPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_filter_wiener_point_to_string(pt : SignalfilterwienerPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalfilterwienerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_wiener_make_series(vals : Array[Double], name : String) -> SignalfilterwienerSeries {
  { vals, name, meta: 0 }
}

pub fn signal_filter_wiener_series_len(s : SignalfilterwienerSeries) -> Int { s.vals.length() }

pub fn signal_filter_wiener_series_sum(s : SignalfilterwienerSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn signal_filter_wiener_series_mean(s : SignalfilterwienerSeries) -> Double { @_common.mean(s.vals) }

pub fn signal_filter_wiener_series_min(s : SignalfilterwienerSeries) -> Double { @_common.min(s.vals) }

pub fn signal_filter_wiener_series_max(s : SignalfilterwienerSeries) -> Double { @_common.max(s.vals) }

pub fn signal_filter_wiener_series_range(s : SignalfilterwienerSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn signal_filter_wiener_series_var(s : SignalfilterwienerSeries) -> Double { @_common.variance(s.vals) }

pub fn signal_filter_wiener_series_std(s : SignalfilterwienerSeries) -> Double { @_common.std(s.vals) }

pub fn signal_filter_wiener_series_median(s : SignalfilterwienerSeries) -> Double { @_common.median(s.vals) }

pub fn signal_filter_wiener_series_scale(s : SignalfilterwienerSeries, f : Double) -> SignalfilterwienerSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_filter_wiener_series_add(a : SignalfilterwienerSeries, b : SignalfilterwienerSeries) -> SignalfilterwienerSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_filter_wiener_series_sub(a : SignalfilterwienerSeries, b : SignalfilterwienerSeries) -> SignalfilterwienerSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_filter_wiener_series_normalize(s : SignalfilterwienerSeries) -> SignalfilterwienerSeries {
  let mn = signal_filter_wiener_series_min(s)
  let mx = signal_filter_wiener_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_filter_wiener_series_cumsum(s : SignalfilterwienerSeries) -> SignalfilterwienerSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_filter_wiener_series_to_string(s : SignalfilterwienerSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilterwienerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_wiener_make_matrix(rows : Int, cols : Int, val : Double) -> SignalfilterwienerMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_wiener_matrix_identity(n : Int) -> SignalfilterwienerMatrix {
  let m = signal_filter_wiener_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_filter_wiener_matrix_get(m : SignalfilterwienerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_filter_wiener_matrix_transpose(m : SignalfilterwienerMatrix) -> SignalfilterwienerMatrix {
  let result = signal_filter_wiener_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_filter_wiener_matrix_add(a : SignalfilterwienerMatrix, b : SignalfilterwienerMatrix) -> SignalfilterwienerMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_filter_wiener_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_filter_wiener_matrix_scale(m : SignalfilterwienerMatrix, s : Double) -> SignalfilterwienerMatrix {
  let result = signal_filter_wiener_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_filter_wiener_matrix_multiply(a : SignalfilterwienerMatrix, b : SignalfilterwienerMatrix) -> SignalfilterwienerMatrix {
  if a.cols != b.rows { return signal_filter_wiener_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_filter_wiener_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_filter_wiener_matrix_trace(m : SignalfilterwienerMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_filter_wiener_matrix_det(m : SignalfilterwienerMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_filter_wiener_matrix_norm(m : SignalfilterwienerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_filter_wiener_matrix_to_string(m : SignalfilterwienerMatrix) -> String {
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

pub(all) struct SignalfilterwienerVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_wiener_make_vector(comps : Array[Double]) -> SignalfilterwienerVector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_wiener_vector_zero(dim : Int) -> SignalfilterwienerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_filter_wiener_vector_add(a : SignalfilterwienerVector, b : SignalfilterwienerVector) -> SignalfilterwienerVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_filter_wiener_vector_sub(a : SignalfilterwienerVector, b : SignalfilterwienerVector) -> SignalfilterwienerVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_filter_wiener_vector_scale(v : SignalfilterwienerVector, s : Double) -> SignalfilterwienerVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_filter_wiener_vector_dot(a : SignalfilterwienerVector, b : SignalfilterwienerVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_filter_wiener_vector_norm(v : SignalfilterwienerVector) -> Double { @_common.sqrt(signal_filter_wiener_vector_dot(v, v)) }

pub fn signal_filter_wiener_vector_normalize(v : SignalfilterwienerVector) -> SignalfilterwienerVector {
  let n = signal_filter_wiener_vector_norm(v)
  if n < 0.0000001 { v } else { signal_filter_wiener_vector_scale(v, 1.0 / n) }
}

pub fn signal_filter_wiener_vector_dist(a : SignalfilterwienerVector, b : SignalfilterwienerVector) -> Double {
  signal_filter_wiener_vector_norm(signal_filter_wiener_vector_sub(a, b))
}

pub fn signal_filter_wiener_vector_to_string(v : SignalfilterwienerVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_filter_wiener_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_filter_wiener_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_filter_wiener_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_filter_wiener_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_filter_wiener_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_filter_wiener_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_filter_wiener_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_filter_wiener_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_filter_wiener_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_filter_wiener_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_filter_wiener_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_filter_wiener_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_filter_wiener_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_filter_wiener_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_filter_wiener_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_filter_wiener_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_filter_wiener_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_filter_wiener_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_filter_wiener_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_filter_wiener_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_filter_wiener_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_filter_wiener_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_filter_wiener_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_filter_wiener_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_filter_wiener_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_filter_wiener_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_filter_wiener_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_filter_wiener_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_filter_wiener_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalfilterwienerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_frame_make(size : Int) -> SignalfilterwienerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_frame_len(s : SignalfilterwienerFrame) -> Int { s.size }

pub fn signal_filter_wiener_frame_get(s : SignalfilterwienerFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_frame_set(s : SignalfilterwienerFrame, i : Int, v : Double) -> SignalfilterwienerFrame {
  let result = signal_filter_wiener_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_frame_sum(s : SignalfilterwienerFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_wiener_frame_mean(s : SignalfilterwienerFrame) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_wiener_frame_sum(s) / s.size.to_double() }
}

pub fn signal_filter_wiener_frame_scale(s : SignalfilterwienerFrame, f : Double) -> SignalfilterwienerFrame {
  let result = signal_filter_wiener_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_wiener_frame_add(a : SignalfilterwienerFrame, b : SignalfilterwienerFrame) -> SignalfilterwienerFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_wiener_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_wiener_frame_copy(s : SignalfilterwienerFrame) -> SignalfilterwienerFrame {
  let result = signal_filter_wiener_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_wiener_frame_fill(s : SignalfilterwienerFrame, v : Double) -> SignalfilterwienerFrame {
  let result = signal_filter_wiener_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_frame_min(s : SignalfilterwienerFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_frame_max(s : SignalfilterwienerFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_frame_to_string(s : SignalfilterwienerFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_table_make(size : Int) -> SignalfilterwienerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_table_len(s : SignalfilterwienerTable) -> Int { s.size }

pub fn signal_filter_wiener_table_get(s : SignalfilterwienerTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_table_set(s : SignalfilterwienerTable, i : Int, v : Double) -> SignalfilterwienerTable {
  let result = signal_filter_wiener_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_table_sum(s : SignalfilterwienerTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_wiener_table_mean(s : SignalfilterwienerTable) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_wiener_table_sum(s) / s.size.to_double() }
}

pub fn signal_filter_wiener_table_scale(s : SignalfilterwienerTable, f : Double) -> SignalfilterwienerTable {
  let result = signal_filter_wiener_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_wiener_table_add(a : SignalfilterwienerTable, b : SignalfilterwienerTable) -> SignalfilterwienerTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_wiener_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_wiener_table_copy(s : SignalfilterwienerTable) -> SignalfilterwienerTable {
  let result = signal_filter_wiener_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_wiener_table_fill(s : SignalfilterwienerTable, v : Double) -> SignalfilterwienerTable {
  let result = signal_filter_wiener_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_table_min(s : SignalfilterwienerTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_table_max(s : SignalfilterwienerTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_table_to_string(s : SignalfilterwienerTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_graphn_make(size : Int) -> SignalfilterwienerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_graphn_len(s : SignalfilterwienerGraphN) -> Int { s.size }

pub fn signal_filter_wiener_graphn_get(s : SignalfilterwienerGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_graphn_set(s : SignalfilterwienerGraphN, i : Int, v : Double) -> SignalfilterwienerGraphN {
  let result = signal_filter_wiener_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_graphn_sum(s : SignalfilterwienerGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_wiener_graphn_mean(s : SignalfilterwienerGraphN) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_wiener_graphn_sum(s) / s.size.to_double() }
}

pub fn signal_filter_wiener_graphn_scale(s : SignalfilterwienerGraphN, f : Double) -> SignalfilterwienerGraphN {
  let result = signal_filter_wiener_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_wiener_graphn_add(a : SignalfilterwienerGraphN, b : SignalfilterwienerGraphN) -> SignalfilterwienerGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_wiener_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_wiener_graphn_copy(s : SignalfilterwienerGraphN) -> SignalfilterwienerGraphN {
  let result = signal_filter_wiener_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_wiener_graphn_fill(s : SignalfilterwienerGraphN, v : Double) -> SignalfilterwienerGraphN {
  let result = signal_filter_wiener_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_graphn_min(s : SignalfilterwienerGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_graphn_max(s : SignalfilterwienerGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_graphn_to_string(s : SignalfilterwienerGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_node_make(size : Int) -> SignalfilterwienerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_node_len(s : SignalfilterwienerNode) -> Int { s.size }

pub fn signal_filter_wiener_node_get(s : SignalfilterwienerNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_node_set(s : SignalfilterwienerNode, i : Int, v : Double) -> SignalfilterwienerNode {
  let result = signal_filter_wiener_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_node_sum(s : SignalfilterwienerNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_wiener_node_mean(s : SignalfilterwienerNode) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_wiener_node_sum(s) / s.size.to_double() }
}

pub fn signal_filter_wiener_node_scale(s : SignalfilterwienerNode, f : Double) -> SignalfilterwienerNode {
  let result = signal_filter_wiener_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_wiener_node_add(a : SignalfilterwienerNode, b : SignalfilterwienerNode) -> SignalfilterwienerNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_wiener_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_wiener_node_copy(s : SignalfilterwienerNode) -> SignalfilterwienerNode {
  let result = signal_filter_wiener_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_wiener_node_fill(s : SignalfilterwienerNode, v : Double) -> SignalfilterwienerNode {
  let result = signal_filter_wiener_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_node_min(s : SignalfilterwienerNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_node_max(s : SignalfilterwienerNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_node_to_string(s : SignalfilterwienerNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_edge_make(size : Int) -> SignalfilterwienerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_edge_len(s : SignalfilterwienerEdge) -> Int { s.size }

pub fn signal_filter_wiener_edge_get(s : SignalfilterwienerEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_edge_set(s : SignalfilterwienerEdge, i : Int, v : Double) -> SignalfilterwienerEdge {
  let result = signal_filter_wiener_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_edge_sum(s : SignalfilterwienerEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_wiener_edge_mean(s : SignalfilterwienerEdge) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_wiener_edge_sum(s) / s.size.to_double() }
}

pub fn signal_filter_wiener_edge_scale(s : SignalfilterwienerEdge, f : Double) -> SignalfilterwienerEdge {
  let result = signal_filter_wiener_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_wiener_edge_add(a : SignalfilterwienerEdge, b : SignalfilterwienerEdge) -> SignalfilterwienerEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_wiener_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_wiener_edge_copy(s : SignalfilterwienerEdge) -> SignalfilterwienerEdge {
  let result = signal_filter_wiener_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_wiener_edge_fill(s : SignalfilterwienerEdge, v : Double) -> SignalfilterwienerEdge {
  let result = signal_filter_wiener_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_edge_min(s : SignalfilterwienerEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_edge_max(s : SignalfilterwienerEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_edge_to_string(s : SignalfilterwienerEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_path_make(size : Int) -> SignalfilterwienerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_path_len(s : SignalfilterwienerPath) -> Int { s.size }

pub fn signal_filter_wiener_path_get(s : SignalfilterwienerPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_path_set(s : SignalfilterwienerPath, i : Int, v : Double) -> SignalfilterwienerPath {
  let result = signal_filter_wiener_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_path_sum(s : SignalfilterwienerPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_wiener_path_mean(s : SignalfilterwienerPath) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_wiener_path_sum(s) / s.size.to_double() }
}

pub fn signal_filter_wiener_path_scale(s : SignalfilterwienerPath, f : Double) -> SignalfilterwienerPath {
  let result = signal_filter_wiener_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_wiener_path_add(a : SignalfilterwienerPath, b : SignalfilterwienerPath) -> SignalfilterwienerPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_wiener_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_wiener_path_copy(s : SignalfilterwienerPath) -> SignalfilterwienerPath {
  let result = signal_filter_wiener_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_wiener_path_fill(s : SignalfilterwienerPath, v : Double) -> SignalfilterwienerPath {
  let result = signal_filter_wiener_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_path_min(s : SignalfilterwienerPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_path_max(s : SignalfilterwienerPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_path_to_string(s : SignalfilterwienerPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_cluster_make(size : Int) -> SignalfilterwienerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_cluster_len(s : SignalfilterwienerCluster) -> Int { s.size }

pub fn signal_filter_wiener_cluster_get(s : SignalfilterwienerCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_cluster_set(s : SignalfilterwienerCluster, i : Int, v : Double) -> SignalfilterwienerCluster {
  let result = signal_filter_wiener_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_cluster_sum(s : SignalfilterwienerCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_wiener_cluster_mean(s : SignalfilterwienerCluster) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_wiener_cluster_sum(s) / s.size.to_double() }
}

pub fn signal_filter_wiener_cluster_scale(s : SignalfilterwienerCluster, f : Double) -> SignalfilterwienerCluster {
  let result = signal_filter_wiener_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_wiener_cluster_add(a : SignalfilterwienerCluster, b : SignalfilterwienerCluster) -> SignalfilterwienerCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_wiener_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_wiener_cluster_copy(s : SignalfilterwienerCluster) -> SignalfilterwienerCluster {
  let result = signal_filter_wiener_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_wiener_cluster_fill(s : SignalfilterwienerCluster, v : Double) -> SignalfilterwienerCluster {
  let result = signal_filter_wiener_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_cluster_min(s : SignalfilterwienerCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_cluster_max(s : SignalfilterwienerCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_cluster_to_string(s : SignalfilterwienerCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_model_make(size : Int) -> SignalfilterwienerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_model_len(s : SignalfilterwienerModel) -> Int { s.size }

pub fn signal_filter_wiener_model_get(s : SignalfilterwienerModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_model_set(s : SignalfilterwienerModel, i : Int, v : Double) -> SignalfilterwienerModel {
  let result = signal_filter_wiener_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_model_sum(s : SignalfilterwienerModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_wiener_model_mean(s : SignalfilterwienerModel) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_wiener_model_sum(s) / s.size.to_double() }
}

pub fn signal_filter_wiener_model_scale(s : SignalfilterwienerModel, f : Double) -> SignalfilterwienerModel {
  let result = signal_filter_wiener_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_wiener_model_add(a : SignalfilterwienerModel, b : SignalfilterwienerModel) -> SignalfilterwienerModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_wiener_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_wiener_model_copy(s : SignalfilterwienerModel) -> SignalfilterwienerModel {
  let result = signal_filter_wiener_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_wiener_model_fill(s : SignalfilterwienerModel, v : Double) -> SignalfilterwienerModel {
  let result = signal_filter_wiener_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_model_min(s : SignalfilterwienerModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_model_max(s : SignalfilterwienerModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_model_to_string(s : SignalfilterwienerModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_layer_make(size : Int) -> SignalfilterwienerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_layer_len(s : SignalfilterwienerLayer) -> Int { s.size }

pub fn signal_filter_wiener_layer_get(s : SignalfilterwienerLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_layer_set(s : SignalfilterwienerLayer, i : Int, v : Double) -> SignalfilterwienerLayer {
  let result = signal_filter_wiener_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_layer_sum(s : SignalfilterwienerLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_wiener_layer_mean(s : SignalfilterwienerLayer) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_wiener_layer_sum(s) / s.size.to_double() }
}

pub fn signal_filter_wiener_layer_scale(s : SignalfilterwienerLayer, f : Double) -> SignalfilterwienerLayer {
  let result = signal_filter_wiener_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_wiener_layer_add(a : SignalfilterwienerLayer, b : SignalfilterwienerLayer) -> SignalfilterwienerLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_wiener_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_wiener_layer_copy(s : SignalfilterwienerLayer) -> SignalfilterwienerLayer {
  let result = signal_filter_wiener_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_wiener_layer_fill(s : SignalfilterwienerLayer, v : Double) -> SignalfilterwienerLayer {
  let result = signal_filter_wiener_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_layer_min(s : SignalfilterwienerLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_layer_max(s : SignalfilterwienerLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_layer_to_string(s : SignalfilterwienerLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_buffer_make(size : Int) -> SignalfilterwienerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_buffer_len(s : SignalfilterwienerBuffer) -> Int { s.size }

pub fn signal_filter_wiener_buffer_get(s : SignalfilterwienerBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_buffer_set(s : SignalfilterwienerBuffer, i : Int, v : Double) -> SignalfilterwienerBuffer {
  let result = signal_filter_wiener_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_buffer_sum(s : SignalfilterwienerBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_wiener_buffer_mean(s : SignalfilterwienerBuffer) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_wiener_buffer_sum(s) / s.size.to_double() }
}

pub fn signal_filter_wiener_buffer_scale(s : SignalfilterwienerBuffer, f : Double) -> SignalfilterwienerBuffer {
  let result = signal_filter_wiener_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_wiener_buffer_add(a : SignalfilterwienerBuffer, b : SignalfilterwienerBuffer) -> SignalfilterwienerBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_wiener_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_wiener_buffer_copy(s : SignalfilterwienerBuffer) -> SignalfilterwienerBuffer {
  let result = signal_filter_wiener_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_wiener_buffer_fill(s : SignalfilterwienerBuffer, v : Double) -> SignalfilterwienerBuffer {
  let result = signal_filter_wiener_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_buffer_min(s : SignalfilterwienerBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_buffer_max(s : SignalfilterwienerBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_buffer_to_string(s : SignalfilterwienerBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_cursor_make(size : Int) -> SignalfilterwienerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_cursor_len(s : SignalfilterwienerCursor) -> Int { s.size }

pub fn signal_filter_wiener_cursor_get(s : SignalfilterwienerCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_cursor_set(s : SignalfilterwienerCursor, i : Int, v : Double) -> SignalfilterwienerCursor {
  let result = signal_filter_wiener_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_cursor_sum(s : SignalfilterwienerCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_wiener_cursor_mean(s : SignalfilterwienerCursor) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_wiener_cursor_sum(s) / s.size.to_double() }
}

pub fn signal_filter_wiener_cursor_scale(s : SignalfilterwienerCursor, f : Double) -> SignalfilterwienerCursor {
  let result = signal_filter_wiener_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_wiener_cursor_add(a : SignalfilterwienerCursor, b : SignalfilterwienerCursor) -> SignalfilterwienerCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_wiener_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_wiener_cursor_copy(s : SignalfilterwienerCursor) -> SignalfilterwienerCursor {
  let result = signal_filter_wiener_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_wiener_cursor_fill(s : SignalfilterwienerCursor, v : Double) -> SignalfilterwienerCursor {
  let result = signal_filter_wiener_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_cursor_min(s : SignalfilterwienerCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_cursor_max(s : SignalfilterwienerCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_cursor_to_string(s : SignalfilterwienerCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_view_make(size : Int) -> SignalfilterwienerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_view_len(s : SignalfilterwienerView) -> Int { s.size }

pub fn signal_filter_wiener_view_get(s : SignalfilterwienerView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_view_set(s : SignalfilterwienerView, i : Int, v : Double) -> SignalfilterwienerView {
  let result = signal_filter_wiener_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_view_sum(s : SignalfilterwienerView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_wiener_view_mean(s : SignalfilterwienerView) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_wiener_view_sum(s) / s.size.to_double() }
}

pub fn signal_filter_wiener_view_scale(s : SignalfilterwienerView, f : Double) -> SignalfilterwienerView {
  let result = signal_filter_wiener_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_wiener_view_add(a : SignalfilterwienerView, b : SignalfilterwienerView) -> SignalfilterwienerView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_wiener_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_wiener_view_copy(s : SignalfilterwienerView) -> SignalfilterwienerView {
  let result = signal_filter_wiener_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_wiener_view_fill(s : SignalfilterwienerView, v : Double) -> SignalfilterwienerView {
  let result = signal_filter_wiener_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_view_min(s : SignalfilterwienerView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_view_max(s : SignalfilterwienerView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_view_to_string(s : SignalfilterwienerView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_range_make(size : Int) -> SignalfilterwienerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_range_len(s : SignalfilterwienerRange) -> Int { s.size }

pub fn signal_filter_wiener_range_get(s : SignalfilterwienerRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_range_set(s : SignalfilterwienerRange, i : Int, v : Double) -> SignalfilterwienerRange {
  let result = signal_filter_wiener_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_range_sum(s : SignalfilterwienerRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_wiener_range_mean(s : SignalfilterwienerRange) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_wiener_range_sum(s) / s.size.to_double() }
}

pub fn signal_filter_wiener_range_scale(s : SignalfilterwienerRange, f : Double) -> SignalfilterwienerRange {
  let result = signal_filter_wiener_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_wiener_range_add(a : SignalfilterwienerRange, b : SignalfilterwienerRange) -> SignalfilterwienerRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_wiener_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_wiener_range_copy(s : SignalfilterwienerRange) -> SignalfilterwienerRange {
  let result = signal_filter_wiener_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_wiener_range_fill(s : SignalfilterwienerRange, v : Double) -> SignalfilterwienerRange {
  let result = signal_filter_wiener_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_range_min(s : SignalfilterwienerRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_range_max(s : SignalfilterwienerRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_range_to_string(s : SignalfilterwienerRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_slice_make(size : Int) -> SignalfilterwienerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_slice_len(s : SignalfilterwienerSlice) -> Int { s.size }

pub fn signal_filter_wiener_slice_get(s : SignalfilterwienerSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_slice_set(s : SignalfilterwienerSlice, i : Int, v : Double) -> SignalfilterwienerSlice {
  let result = signal_filter_wiener_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_slice_sum(s : SignalfilterwienerSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_wiener_slice_mean(s : SignalfilterwienerSlice) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_wiener_slice_sum(s) / s.size.to_double() }
}

pub fn signal_filter_wiener_slice_scale(s : SignalfilterwienerSlice, f : Double) -> SignalfilterwienerSlice {
  let result = signal_filter_wiener_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_wiener_slice_add(a : SignalfilterwienerSlice, b : SignalfilterwienerSlice) -> SignalfilterwienerSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_wiener_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_wiener_slice_copy(s : SignalfilterwienerSlice) -> SignalfilterwienerSlice {
  let result = signal_filter_wiener_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_wiener_slice_fill(s : SignalfilterwienerSlice, v : Double) -> SignalfilterwienerSlice {
  let result = signal_filter_wiener_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_wiener_slice_min(s : SignalfilterwienerSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_slice_max(s : SignalfilterwienerSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_wiener_slice_to_string(s : SignalfilterwienerSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

