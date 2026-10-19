///===
/// extcore/signal_filter_kalman

pub(all) struct SignalfilterkalmanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_kalman_make_point(x : Double, y : Double) -> SignalfilterkalmanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_kalman_make_point3(x : Double, y : Double, z : Double) -> SignalfilterkalmanPoint {
  { x, y, z, label: 0 }
}

pub fn signal_filter_kalman_point_x(pt : SignalfilterkalmanPoint) -> Double { pt.x }

pub fn signal_filter_kalman_point_y(pt : SignalfilterkalmanPoint) -> Double { pt.y }

pub fn signal_filter_kalman_point_z(pt : SignalfilterkalmanPoint) -> Double { pt.z }

pub fn signal_filter_kalman_point_label(pt : SignalfilterkalmanPoint) -> Int { pt.label }

pub fn signal_filter_kalman_point_dist(a : SignalfilterkalmanPoint, b : SignalfilterkalmanPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_filter_kalman_point_add(a : SignalfilterkalmanPoint, b : SignalfilterkalmanPoint) -> SignalfilterkalmanPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_filter_kalman_point_sub(a : SignalfilterkalmanPoint, b : SignalfilterkalmanPoint) -> SignalfilterkalmanPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_filter_kalman_point_scale(pt : SignalfilterkalmanPoint, s : Double) -> SignalfilterkalmanPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_filter_kalman_point_dot(a : SignalfilterkalmanPoint, b : SignalfilterkalmanPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_filter_kalman_point_cross(a : SignalfilterkalmanPoint, b : SignalfilterkalmanPoint) -> SignalfilterkalmanPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_filter_kalman_point_norm(pt : SignalfilterkalmanPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_filter_kalman_point_normalize(pt : SignalfilterkalmanPoint) -> SignalfilterkalmanPoint {
  let n = signal_filter_kalman_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_filter_kalman_point_scale(pt, 1.0 / n) }
}

pub fn signal_filter_kalman_point_negate(pt : SignalfilterkalmanPoint) -> SignalfilterkalmanPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_filter_kalman_point_mid(a : SignalfilterkalmanPoint, b : SignalfilterkalmanPoint) -> SignalfilterkalmanPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_filter_kalman_point_lerp(a : SignalfilterkalmanPoint, b : SignalfilterkalmanPoint, t : Double) -> SignalfilterkalmanPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_filter_kalman_point_to_string(pt : SignalfilterkalmanPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalfilterkalmanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_kalman_make_series(vals : Array[Double], name : String) -> SignalfilterkalmanSeries {
  { vals, name, meta: 0 }
}

pub fn signal_filter_kalman_series_len(s : SignalfilterkalmanSeries) -> Int { s.vals.length() }

pub fn signal_filter_kalman_series_sum(s : SignalfilterkalmanSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn signal_filter_kalman_series_mean(s : SignalfilterkalmanSeries) -> Double {
  let n = signal_filter_kalman_series_len(s)
  if n == 0 { 0.0 } else { signal_filter_kalman_series_sum(s) / n.to_double() }
}

pub fn signal_filter_kalman_series_min(s : SignalfilterkalmanSeries) -> Double {
  let n = signal_filter_kalman_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn signal_filter_kalman_series_max(s : SignalfilterkalmanSeries) -> Double {
  let n = signal_filter_kalman_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn signal_filter_kalman_series_range(s : SignalfilterkalmanSeries) -> Double {
  signal_filter_kalman_series_max(s) - signal_filter_kalman_series_min(s)
}

pub fn signal_filter_kalman_series_var(s : SignalfilterkalmanSeries) -> Double {
  let n = signal_filter_kalman_series_len(s)
  if n == 0 { 0.0 } else {
    let m = signal_filter_kalman_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn signal_filter_kalman_series_std(s : SignalfilterkalmanSeries) -> Double { @_common.sqrt(signal_filter_kalman_series_var(s)) }

pub fn signal_filter_kalman_series_median(s : SignalfilterkalmanSeries) -> Double {
  let n = signal_filter_kalman_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = signal_filter_kalman_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_filter_kalman_series_scale(s : SignalfilterkalmanSeries, f : Double) -> SignalfilterkalmanSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_filter_kalman_series_add(a : SignalfilterkalmanSeries, b : SignalfilterkalmanSeries) -> SignalfilterkalmanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_filter_kalman_series_sub(a : SignalfilterkalmanSeries, b : SignalfilterkalmanSeries) -> SignalfilterkalmanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_filter_kalman_series_normalize(s : SignalfilterkalmanSeries) -> SignalfilterkalmanSeries {
  let mn = signal_filter_kalman_series_min(s)
  let mx = signal_filter_kalman_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_filter_kalman_series_cumsum(s : SignalfilterkalmanSeries) -> SignalfilterkalmanSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_filter_kalman_series_to_string(s : SignalfilterkalmanSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilterkalmanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_kalman_make_matrix(rows : Int, cols : Int, val : Double) -> SignalfilterkalmanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_kalman_matrix_identity(n : Int) -> SignalfilterkalmanMatrix {
  let m = signal_filter_kalman_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_filter_kalman_matrix_get(m : SignalfilterkalmanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_filter_kalman_matrix_transpose(m : SignalfilterkalmanMatrix) -> SignalfilterkalmanMatrix {
  let result = signal_filter_kalman_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_filter_kalman_matrix_add(a : SignalfilterkalmanMatrix, b : SignalfilterkalmanMatrix) -> SignalfilterkalmanMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_filter_kalman_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_filter_kalman_matrix_scale(m : SignalfilterkalmanMatrix, s : Double) -> SignalfilterkalmanMatrix {
  let result = signal_filter_kalman_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_filter_kalman_matrix_multiply(a : SignalfilterkalmanMatrix, b : SignalfilterkalmanMatrix) -> SignalfilterkalmanMatrix {
  if a.cols != b.rows { return signal_filter_kalman_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_filter_kalman_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_filter_kalman_matrix_trace(m : SignalfilterkalmanMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_filter_kalman_matrix_det(m : SignalfilterkalmanMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_filter_kalman_matrix_norm(m : SignalfilterkalmanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_filter_kalman_matrix_to_string(m : SignalfilterkalmanMatrix) -> String {
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

pub(all) struct SignalfilterkalmanVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_kalman_make_vector(comps : Array[Double]) -> SignalfilterkalmanVector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_kalman_vector_zero(dim : Int) -> SignalfilterkalmanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_filter_kalman_vector_add(a : SignalfilterkalmanVector, b : SignalfilterkalmanVector) -> SignalfilterkalmanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_filter_kalman_vector_sub(a : SignalfilterkalmanVector, b : SignalfilterkalmanVector) -> SignalfilterkalmanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_filter_kalman_vector_scale(v : SignalfilterkalmanVector, s : Double) -> SignalfilterkalmanVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_filter_kalman_vector_dot(a : SignalfilterkalmanVector, b : SignalfilterkalmanVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_filter_kalman_vector_norm(v : SignalfilterkalmanVector) -> Double { @_common.sqrt(signal_filter_kalman_vector_dot(v, v)) }

pub fn signal_filter_kalman_vector_normalize(v : SignalfilterkalmanVector) -> SignalfilterkalmanVector {
  let n = signal_filter_kalman_vector_norm(v)
  if n < 0.0000001 { v } else { signal_filter_kalman_vector_scale(v, 1.0 / n) }
}

pub fn signal_filter_kalman_vector_dist(a : SignalfilterkalmanVector, b : SignalfilterkalmanVector) -> Double {
  signal_filter_kalman_vector_norm(signal_filter_kalman_vector_sub(a, b))
}

pub fn signal_filter_kalman_vector_to_string(v : SignalfilterkalmanVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_filter_kalman_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_filter_kalman_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_filter_kalman_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_filter_kalman_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_filter_kalman_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_filter_kalman_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_filter_kalman_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_filter_kalman_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_filter_kalman_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_filter_kalman_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_filter_kalman_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_filter_kalman_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_filter_kalman_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_filter_kalman_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_filter_kalman_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_filter_kalman_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_filter_kalman_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_filter_kalman_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_filter_kalman_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_filter_kalman_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_filter_kalman_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_filter_kalman_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_filter_kalman_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_filter_kalman_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_filter_kalman_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_filter_kalman_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_filter_kalman_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_filter_kalman_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_filter_kalman_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalfilterkalmanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_frame_make(size : Int) -> SignalfilterkalmanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_frame_len(s : SignalfilterkalmanFrame) -> Int { s.size }

pub fn signal_filter_kalman_frame_get(s : SignalfilterkalmanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_frame_set(s : SignalfilterkalmanFrame, i : Int, v : Double) -> SignalfilterkalmanFrame {
  let result = signal_filter_kalman_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_frame_sum(s : SignalfilterkalmanFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_kalman_frame_mean(s : SignalfilterkalmanFrame) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_kalman_frame_sum(s) / s.size.to_double() }
}

pub fn signal_filter_kalman_frame_scale(s : SignalfilterkalmanFrame, f : Double) -> SignalfilterkalmanFrame {
  let result = signal_filter_kalman_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_kalman_frame_add(a : SignalfilterkalmanFrame, b : SignalfilterkalmanFrame) -> SignalfilterkalmanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_kalman_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_kalman_frame_copy(s : SignalfilterkalmanFrame) -> SignalfilterkalmanFrame {
  let result = signal_filter_kalman_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_kalman_frame_fill(s : SignalfilterkalmanFrame, v : Double) -> SignalfilterkalmanFrame {
  let result = signal_filter_kalman_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_frame_min(s : SignalfilterkalmanFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_frame_max(s : SignalfilterkalmanFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_frame_to_string(s : SignalfilterkalmanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_table_make(size : Int) -> SignalfilterkalmanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_table_len(s : SignalfilterkalmanTable) -> Int { s.size }

pub fn signal_filter_kalman_table_get(s : SignalfilterkalmanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_table_set(s : SignalfilterkalmanTable, i : Int, v : Double) -> SignalfilterkalmanTable {
  let result = signal_filter_kalman_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_table_sum(s : SignalfilterkalmanTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_kalman_table_mean(s : SignalfilterkalmanTable) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_kalman_table_sum(s) / s.size.to_double() }
}

pub fn signal_filter_kalman_table_scale(s : SignalfilterkalmanTable, f : Double) -> SignalfilterkalmanTable {
  let result = signal_filter_kalman_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_kalman_table_add(a : SignalfilterkalmanTable, b : SignalfilterkalmanTable) -> SignalfilterkalmanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_kalman_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_kalman_table_copy(s : SignalfilterkalmanTable) -> SignalfilterkalmanTable {
  let result = signal_filter_kalman_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_kalman_table_fill(s : SignalfilterkalmanTable, v : Double) -> SignalfilterkalmanTable {
  let result = signal_filter_kalman_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_table_min(s : SignalfilterkalmanTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_table_max(s : SignalfilterkalmanTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_table_to_string(s : SignalfilterkalmanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_graphn_make(size : Int) -> SignalfilterkalmanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_graphn_len(s : SignalfilterkalmanGraphN) -> Int { s.size }

pub fn signal_filter_kalman_graphn_get(s : SignalfilterkalmanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_graphn_set(s : SignalfilterkalmanGraphN, i : Int, v : Double) -> SignalfilterkalmanGraphN {
  let result = signal_filter_kalman_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_graphn_sum(s : SignalfilterkalmanGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_kalman_graphn_mean(s : SignalfilterkalmanGraphN) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_kalman_graphn_sum(s) / s.size.to_double() }
}

pub fn signal_filter_kalman_graphn_scale(s : SignalfilterkalmanGraphN, f : Double) -> SignalfilterkalmanGraphN {
  let result = signal_filter_kalman_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_kalman_graphn_add(a : SignalfilterkalmanGraphN, b : SignalfilterkalmanGraphN) -> SignalfilterkalmanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_kalman_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_kalman_graphn_copy(s : SignalfilterkalmanGraphN) -> SignalfilterkalmanGraphN {
  let result = signal_filter_kalman_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_kalman_graphn_fill(s : SignalfilterkalmanGraphN, v : Double) -> SignalfilterkalmanGraphN {
  let result = signal_filter_kalman_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_graphn_min(s : SignalfilterkalmanGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_graphn_max(s : SignalfilterkalmanGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_graphn_to_string(s : SignalfilterkalmanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_node_make(size : Int) -> SignalfilterkalmanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_node_len(s : SignalfilterkalmanNode) -> Int { s.size }

pub fn signal_filter_kalman_node_get(s : SignalfilterkalmanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_node_set(s : SignalfilterkalmanNode, i : Int, v : Double) -> SignalfilterkalmanNode {
  let result = signal_filter_kalman_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_node_sum(s : SignalfilterkalmanNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_kalman_node_mean(s : SignalfilterkalmanNode) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_kalman_node_sum(s) / s.size.to_double() }
}

pub fn signal_filter_kalman_node_scale(s : SignalfilterkalmanNode, f : Double) -> SignalfilterkalmanNode {
  let result = signal_filter_kalman_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_kalman_node_add(a : SignalfilterkalmanNode, b : SignalfilterkalmanNode) -> SignalfilterkalmanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_kalman_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_kalman_node_copy(s : SignalfilterkalmanNode) -> SignalfilterkalmanNode {
  let result = signal_filter_kalman_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_kalman_node_fill(s : SignalfilterkalmanNode, v : Double) -> SignalfilterkalmanNode {
  let result = signal_filter_kalman_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_node_min(s : SignalfilterkalmanNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_node_max(s : SignalfilterkalmanNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_node_to_string(s : SignalfilterkalmanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_edge_make(size : Int) -> SignalfilterkalmanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_edge_len(s : SignalfilterkalmanEdge) -> Int { s.size }

pub fn signal_filter_kalman_edge_get(s : SignalfilterkalmanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_edge_set(s : SignalfilterkalmanEdge, i : Int, v : Double) -> SignalfilterkalmanEdge {
  let result = signal_filter_kalman_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_edge_sum(s : SignalfilterkalmanEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_kalman_edge_mean(s : SignalfilterkalmanEdge) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_kalman_edge_sum(s) / s.size.to_double() }
}

pub fn signal_filter_kalman_edge_scale(s : SignalfilterkalmanEdge, f : Double) -> SignalfilterkalmanEdge {
  let result = signal_filter_kalman_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_kalman_edge_add(a : SignalfilterkalmanEdge, b : SignalfilterkalmanEdge) -> SignalfilterkalmanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_kalman_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_kalman_edge_copy(s : SignalfilterkalmanEdge) -> SignalfilterkalmanEdge {
  let result = signal_filter_kalman_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_kalman_edge_fill(s : SignalfilterkalmanEdge, v : Double) -> SignalfilterkalmanEdge {
  let result = signal_filter_kalman_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_edge_min(s : SignalfilterkalmanEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_edge_max(s : SignalfilterkalmanEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_edge_to_string(s : SignalfilterkalmanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_path_make(size : Int) -> SignalfilterkalmanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_path_len(s : SignalfilterkalmanPath) -> Int { s.size }

pub fn signal_filter_kalman_path_get(s : SignalfilterkalmanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_path_set(s : SignalfilterkalmanPath, i : Int, v : Double) -> SignalfilterkalmanPath {
  let result = signal_filter_kalman_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_path_sum(s : SignalfilterkalmanPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_kalman_path_mean(s : SignalfilterkalmanPath) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_kalman_path_sum(s) / s.size.to_double() }
}

pub fn signal_filter_kalman_path_scale(s : SignalfilterkalmanPath, f : Double) -> SignalfilterkalmanPath {
  let result = signal_filter_kalman_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_kalman_path_add(a : SignalfilterkalmanPath, b : SignalfilterkalmanPath) -> SignalfilterkalmanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_kalman_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_kalman_path_copy(s : SignalfilterkalmanPath) -> SignalfilterkalmanPath {
  let result = signal_filter_kalman_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_kalman_path_fill(s : SignalfilterkalmanPath, v : Double) -> SignalfilterkalmanPath {
  let result = signal_filter_kalman_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_path_min(s : SignalfilterkalmanPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_path_max(s : SignalfilterkalmanPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_path_to_string(s : SignalfilterkalmanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_cluster_make(size : Int) -> SignalfilterkalmanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_cluster_len(s : SignalfilterkalmanCluster) -> Int { s.size }

pub fn signal_filter_kalman_cluster_get(s : SignalfilterkalmanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_cluster_set(s : SignalfilterkalmanCluster, i : Int, v : Double) -> SignalfilterkalmanCluster {
  let result = signal_filter_kalman_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_cluster_sum(s : SignalfilterkalmanCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_kalman_cluster_mean(s : SignalfilterkalmanCluster) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_kalman_cluster_sum(s) / s.size.to_double() }
}

pub fn signal_filter_kalman_cluster_scale(s : SignalfilterkalmanCluster, f : Double) -> SignalfilterkalmanCluster {
  let result = signal_filter_kalman_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_kalman_cluster_add(a : SignalfilterkalmanCluster, b : SignalfilterkalmanCluster) -> SignalfilterkalmanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_kalman_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_kalman_cluster_copy(s : SignalfilterkalmanCluster) -> SignalfilterkalmanCluster {
  let result = signal_filter_kalman_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_kalman_cluster_fill(s : SignalfilterkalmanCluster, v : Double) -> SignalfilterkalmanCluster {
  let result = signal_filter_kalman_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_cluster_min(s : SignalfilterkalmanCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_cluster_max(s : SignalfilterkalmanCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_cluster_to_string(s : SignalfilterkalmanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_model_make(size : Int) -> SignalfilterkalmanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_model_len(s : SignalfilterkalmanModel) -> Int { s.size }

pub fn signal_filter_kalman_model_get(s : SignalfilterkalmanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_model_set(s : SignalfilterkalmanModel, i : Int, v : Double) -> SignalfilterkalmanModel {
  let result = signal_filter_kalman_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_model_sum(s : SignalfilterkalmanModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_kalman_model_mean(s : SignalfilterkalmanModel) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_kalman_model_sum(s) / s.size.to_double() }
}

pub fn signal_filter_kalman_model_scale(s : SignalfilterkalmanModel, f : Double) -> SignalfilterkalmanModel {
  let result = signal_filter_kalman_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_kalman_model_add(a : SignalfilterkalmanModel, b : SignalfilterkalmanModel) -> SignalfilterkalmanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_kalman_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_kalman_model_copy(s : SignalfilterkalmanModel) -> SignalfilterkalmanModel {
  let result = signal_filter_kalman_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_kalman_model_fill(s : SignalfilterkalmanModel, v : Double) -> SignalfilterkalmanModel {
  let result = signal_filter_kalman_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_model_min(s : SignalfilterkalmanModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_model_max(s : SignalfilterkalmanModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_model_to_string(s : SignalfilterkalmanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_layer_make(size : Int) -> SignalfilterkalmanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_layer_len(s : SignalfilterkalmanLayer) -> Int { s.size }

pub fn signal_filter_kalman_layer_get(s : SignalfilterkalmanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_layer_set(s : SignalfilterkalmanLayer, i : Int, v : Double) -> SignalfilterkalmanLayer {
  let result = signal_filter_kalman_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_layer_sum(s : SignalfilterkalmanLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_kalman_layer_mean(s : SignalfilterkalmanLayer) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_kalman_layer_sum(s) / s.size.to_double() }
}

pub fn signal_filter_kalman_layer_scale(s : SignalfilterkalmanLayer, f : Double) -> SignalfilterkalmanLayer {
  let result = signal_filter_kalman_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_kalman_layer_add(a : SignalfilterkalmanLayer, b : SignalfilterkalmanLayer) -> SignalfilterkalmanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_kalman_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_kalman_layer_copy(s : SignalfilterkalmanLayer) -> SignalfilterkalmanLayer {
  let result = signal_filter_kalman_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_kalman_layer_fill(s : SignalfilterkalmanLayer, v : Double) -> SignalfilterkalmanLayer {
  let result = signal_filter_kalman_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_layer_min(s : SignalfilterkalmanLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_layer_max(s : SignalfilterkalmanLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_layer_to_string(s : SignalfilterkalmanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_buffer_make(size : Int) -> SignalfilterkalmanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_buffer_len(s : SignalfilterkalmanBuffer) -> Int { s.size }

pub fn signal_filter_kalman_buffer_get(s : SignalfilterkalmanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_buffer_set(s : SignalfilterkalmanBuffer, i : Int, v : Double) -> SignalfilterkalmanBuffer {
  let result = signal_filter_kalman_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_buffer_sum(s : SignalfilterkalmanBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_kalman_buffer_mean(s : SignalfilterkalmanBuffer) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_kalman_buffer_sum(s) / s.size.to_double() }
}

pub fn signal_filter_kalman_buffer_scale(s : SignalfilterkalmanBuffer, f : Double) -> SignalfilterkalmanBuffer {
  let result = signal_filter_kalman_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_kalman_buffer_add(a : SignalfilterkalmanBuffer, b : SignalfilterkalmanBuffer) -> SignalfilterkalmanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_kalman_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_kalman_buffer_copy(s : SignalfilterkalmanBuffer) -> SignalfilterkalmanBuffer {
  let result = signal_filter_kalman_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_kalman_buffer_fill(s : SignalfilterkalmanBuffer, v : Double) -> SignalfilterkalmanBuffer {
  let result = signal_filter_kalman_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_buffer_min(s : SignalfilterkalmanBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_buffer_max(s : SignalfilterkalmanBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_buffer_to_string(s : SignalfilterkalmanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_cursor_make(size : Int) -> SignalfilterkalmanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_cursor_len(s : SignalfilterkalmanCursor) -> Int { s.size }

pub fn signal_filter_kalman_cursor_get(s : SignalfilterkalmanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_cursor_set(s : SignalfilterkalmanCursor, i : Int, v : Double) -> SignalfilterkalmanCursor {
  let result = signal_filter_kalman_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_cursor_sum(s : SignalfilterkalmanCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_kalman_cursor_mean(s : SignalfilterkalmanCursor) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_kalman_cursor_sum(s) / s.size.to_double() }
}

pub fn signal_filter_kalman_cursor_scale(s : SignalfilterkalmanCursor, f : Double) -> SignalfilterkalmanCursor {
  let result = signal_filter_kalman_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_kalman_cursor_add(a : SignalfilterkalmanCursor, b : SignalfilterkalmanCursor) -> SignalfilterkalmanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_kalman_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_kalman_cursor_copy(s : SignalfilterkalmanCursor) -> SignalfilterkalmanCursor {
  let result = signal_filter_kalman_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_kalman_cursor_fill(s : SignalfilterkalmanCursor, v : Double) -> SignalfilterkalmanCursor {
  let result = signal_filter_kalman_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_cursor_min(s : SignalfilterkalmanCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_cursor_max(s : SignalfilterkalmanCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_cursor_to_string(s : SignalfilterkalmanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_view_make(size : Int) -> SignalfilterkalmanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_view_len(s : SignalfilterkalmanView) -> Int { s.size }

pub fn signal_filter_kalman_view_get(s : SignalfilterkalmanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_view_set(s : SignalfilterkalmanView, i : Int, v : Double) -> SignalfilterkalmanView {
  let result = signal_filter_kalman_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_view_sum(s : SignalfilterkalmanView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_kalman_view_mean(s : SignalfilterkalmanView) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_kalman_view_sum(s) / s.size.to_double() }
}

pub fn signal_filter_kalman_view_scale(s : SignalfilterkalmanView, f : Double) -> SignalfilterkalmanView {
  let result = signal_filter_kalman_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_kalman_view_add(a : SignalfilterkalmanView, b : SignalfilterkalmanView) -> SignalfilterkalmanView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_kalman_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_kalman_view_copy(s : SignalfilterkalmanView) -> SignalfilterkalmanView {
  let result = signal_filter_kalman_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_kalman_view_fill(s : SignalfilterkalmanView, v : Double) -> SignalfilterkalmanView {
  let result = signal_filter_kalman_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_view_min(s : SignalfilterkalmanView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_view_max(s : SignalfilterkalmanView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_view_to_string(s : SignalfilterkalmanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_range_make(size : Int) -> SignalfilterkalmanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_range_len(s : SignalfilterkalmanRange) -> Int { s.size }

pub fn signal_filter_kalman_range_get(s : SignalfilterkalmanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_range_set(s : SignalfilterkalmanRange, i : Int, v : Double) -> SignalfilterkalmanRange {
  let result = signal_filter_kalman_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_range_sum(s : SignalfilterkalmanRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_kalman_range_mean(s : SignalfilterkalmanRange) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_kalman_range_sum(s) / s.size.to_double() }
}

pub fn signal_filter_kalman_range_scale(s : SignalfilterkalmanRange, f : Double) -> SignalfilterkalmanRange {
  let result = signal_filter_kalman_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_kalman_range_add(a : SignalfilterkalmanRange, b : SignalfilterkalmanRange) -> SignalfilterkalmanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_kalman_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_kalman_range_copy(s : SignalfilterkalmanRange) -> SignalfilterkalmanRange {
  let result = signal_filter_kalman_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_kalman_range_fill(s : SignalfilterkalmanRange, v : Double) -> SignalfilterkalmanRange {
  let result = signal_filter_kalman_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_range_min(s : SignalfilterkalmanRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_range_max(s : SignalfilterkalmanRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_range_to_string(s : SignalfilterkalmanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_slice_make(size : Int) -> SignalfilterkalmanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_slice_len(s : SignalfilterkalmanSlice) -> Int { s.size }

pub fn signal_filter_kalman_slice_get(s : SignalfilterkalmanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_slice_set(s : SignalfilterkalmanSlice, i : Int, v : Double) -> SignalfilterkalmanSlice {
  let result = signal_filter_kalman_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_slice_sum(s : SignalfilterkalmanSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_kalman_slice_mean(s : SignalfilterkalmanSlice) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_kalman_slice_sum(s) / s.size.to_double() }
}

pub fn signal_filter_kalman_slice_scale(s : SignalfilterkalmanSlice, f : Double) -> SignalfilterkalmanSlice {
  let result = signal_filter_kalman_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_kalman_slice_add(a : SignalfilterkalmanSlice, b : SignalfilterkalmanSlice) -> SignalfilterkalmanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_kalman_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_kalman_slice_copy(s : SignalfilterkalmanSlice) -> SignalfilterkalmanSlice {
  let result = signal_filter_kalman_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_kalman_slice_fill(s : SignalfilterkalmanSlice, v : Double) -> SignalfilterkalmanSlice {
  let result = signal_filter_kalman_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_kalman_slice_min(s : SignalfilterkalmanSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_slice_max(s : SignalfilterkalmanSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_kalman_slice_to_string(s : SignalfilterkalmanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

