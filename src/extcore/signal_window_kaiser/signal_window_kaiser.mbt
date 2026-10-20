///===
/// extcore/signal_window_kaiser

pub(all) struct SignalwindowkaiserPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_kaiser_make_point(x : Double, y : Double) -> SignalwindowkaiserPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_kaiser_make_point3(x : Double, y : Double, z : Double) -> SignalwindowkaiserPoint {
  { x, y, z, label: 0 }
}

pub fn signal_window_kaiser_point_x(pt : SignalwindowkaiserPoint) -> Double { pt.x }

pub fn signal_window_kaiser_point_y(pt : SignalwindowkaiserPoint) -> Double { pt.y }

pub fn signal_window_kaiser_point_z(pt : SignalwindowkaiserPoint) -> Double { pt.z }

pub fn signal_window_kaiser_point_label(pt : SignalwindowkaiserPoint) -> Int { pt.label }

pub fn signal_window_kaiser_point_dist(a : SignalwindowkaiserPoint, b : SignalwindowkaiserPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_window_kaiser_point_add(a : SignalwindowkaiserPoint, b : SignalwindowkaiserPoint) -> SignalwindowkaiserPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_window_kaiser_point_sub(a : SignalwindowkaiserPoint, b : SignalwindowkaiserPoint) -> SignalwindowkaiserPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_window_kaiser_point_scale(pt : SignalwindowkaiserPoint, s : Double) -> SignalwindowkaiserPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_window_kaiser_point_dot(a : SignalwindowkaiserPoint, b : SignalwindowkaiserPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_window_kaiser_point_cross(a : SignalwindowkaiserPoint, b : SignalwindowkaiserPoint) -> SignalwindowkaiserPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_window_kaiser_point_norm(pt : SignalwindowkaiserPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_window_kaiser_point_normalize(pt : SignalwindowkaiserPoint) -> SignalwindowkaiserPoint {
  let n = signal_window_kaiser_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_window_kaiser_point_scale(pt, 1.0 / n) }
}

pub fn signal_window_kaiser_point_negate(pt : SignalwindowkaiserPoint) -> SignalwindowkaiserPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_window_kaiser_point_mid(a : SignalwindowkaiserPoint, b : SignalwindowkaiserPoint) -> SignalwindowkaiserPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_window_kaiser_point_lerp(a : SignalwindowkaiserPoint, b : SignalwindowkaiserPoint, t : Double) -> SignalwindowkaiserPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_window_kaiser_point_to_string(pt : SignalwindowkaiserPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalwindowkaiserSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_kaiser_make_series(vals : Array[Double], name : String) -> SignalwindowkaiserSeries {
  { vals, name, meta: 0 }
}

pub fn signal_window_kaiser_series_len(s : SignalwindowkaiserSeries) -> Int { s.vals.length() }

pub fn signal_window_kaiser_series_sum(s : SignalwindowkaiserSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn signal_window_kaiser_series_mean(s : SignalwindowkaiserSeries) -> Double { @_common.mean(s.vals) }

pub fn signal_window_kaiser_series_min(s : SignalwindowkaiserSeries) -> Double { @_common.min(s.vals) }

pub fn signal_window_kaiser_series_max(s : SignalwindowkaiserSeries) -> Double { @_common.max(s.vals) }

pub fn signal_window_kaiser_series_range(s : SignalwindowkaiserSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn signal_window_kaiser_series_var(s : SignalwindowkaiserSeries) -> Double { @_common.variance(s.vals) }

pub fn signal_window_kaiser_series_std(s : SignalwindowkaiserSeries) -> Double { @_common.std(s.vals) }

pub fn signal_window_kaiser_series_median(s : SignalwindowkaiserSeries) -> Double { @_common.median(s.vals) }

pub fn signal_window_kaiser_series_scale(s : SignalwindowkaiserSeries, f : Double) -> SignalwindowkaiserSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_window_kaiser_series_add(a : SignalwindowkaiserSeries, b : SignalwindowkaiserSeries) -> SignalwindowkaiserSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_window_kaiser_series_sub(a : SignalwindowkaiserSeries, b : SignalwindowkaiserSeries) -> SignalwindowkaiserSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_window_kaiser_series_normalize(s : SignalwindowkaiserSeries) -> SignalwindowkaiserSeries {
  let mn = signal_window_kaiser_series_min(s)
  let mx = signal_window_kaiser_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_window_kaiser_series_cumsum(s : SignalwindowkaiserSeries) -> SignalwindowkaiserSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_window_kaiser_series_to_string(s : SignalwindowkaiserSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowkaiserMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_kaiser_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowkaiserMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_window_kaiser_matrix_identity(n : Int) -> SignalwindowkaiserMatrix {
  let m = signal_window_kaiser_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_window_kaiser_matrix_get(m : SignalwindowkaiserMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_window_kaiser_matrix_transpose(m : SignalwindowkaiserMatrix) -> SignalwindowkaiserMatrix {
  let result = signal_window_kaiser_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_window_kaiser_matrix_add(a : SignalwindowkaiserMatrix, b : SignalwindowkaiserMatrix) -> SignalwindowkaiserMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_window_kaiser_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_window_kaiser_matrix_scale(m : SignalwindowkaiserMatrix, s : Double) -> SignalwindowkaiserMatrix {
  let result = signal_window_kaiser_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_window_kaiser_matrix_multiply(a : SignalwindowkaiserMatrix, b : SignalwindowkaiserMatrix) -> SignalwindowkaiserMatrix {
  if a.cols != b.rows { return signal_window_kaiser_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_window_kaiser_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_window_kaiser_matrix_trace(m : SignalwindowkaiserMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_window_kaiser_matrix_det(m : SignalwindowkaiserMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_window_kaiser_matrix_norm(m : SignalwindowkaiserMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_window_kaiser_matrix_to_string(m : SignalwindowkaiserMatrix) -> String {
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

pub(all) struct SignalwindowkaiserVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_kaiser_make_vector(comps : Array[Double]) -> SignalwindowkaiserVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_kaiser_vector_zero(dim : Int) -> SignalwindowkaiserVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_window_kaiser_vector_add(a : SignalwindowkaiserVector, b : SignalwindowkaiserVector) -> SignalwindowkaiserVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_window_kaiser_vector_sub(a : SignalwindowkaiserVector, b : SignalwindowkaiserVector) -> SignalwindowkaiserVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_window_kaiser_vector_scale(v : SignalwindowkaiserVector, s : Double) -> SignalwindowkaiserVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_window_kaiser_vector_dot(a : SignalwindowkaiserVector, b : SignalwindowkaiserVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_window_kaiser_vector_norm(v : SignalwindowkaiserVector) -> Double { @_common.sqrt(signal_window_kaiser_vector_dot(v, v)) }

pub fn signal_window_kaiser_vector_normalize(v : SignalwindowkaiserVector) -> SignalwindowkaiserVector {
  let n = signal_window_kaiser_vector_norm(v)
  if n < 0.0000001 { v } else { signal_window_kaiser_vector_scale(v, 1.0 / n) }
}

pub fn signal_window_kaiser_vector_dist(a : SignalwindowkaiserVector, b : SignalwindowkaiserVector) -> Double {
  signal_window_kaiser_vector_norm(signal_window_kaiser_vector_sub(a, b))
}

pub fn signal_window_kaiser_vector_to_string(v : SignalwindowkaiserVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_window_kaiser_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_window_kaiser_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_window_kaiser_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_window_kaiser_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_window_kaiser_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_window_kaiser_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_window_kaiser_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_window_kaiser_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_window_kaiser_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_window_kaiser_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_window_kaiser_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_window_kaiser_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_window_kaiser_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_window_kaiser_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_window_kaiser_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_window_kaiser_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_window_kaiser_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_window_kaiser_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_window_kaiser_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_window_kaiser_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_window_kaiser_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_window_kaiser_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_window_kaiser_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_window_kaiser_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_window_kaiser_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_window_kaiser_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_window_kaiser_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_window_kaiser_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_window_kaiser_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalwindowkaiserFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_frame_make(size : Int) -> SignalwindowkaiserFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_frame_len(s : SignalwindowkaiserFrame) -> Int { s.size }

pub fn signal_window_kaiser_frame_get(s : SignalwindowkaiserFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_frame_set(s : SignalwindowkaiserFrame, i : Int, v : Double) -> SignalwindowkaiserFrame {
  let result = signal_window_kaiser_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_frame_sum(s : SignalwindowkaiserFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_kaiser_frame_mean(s : SignalwindowkaiserFrame) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_kaiser_frame_sum(s) / s.size.to_double() }
}

pub fn signal_window_kaiser_frame_scale(s : SignalwindowkaiserFrame, f : Double) -> SignalwindowkaiserFrame {
  let result = signal_window_kaiser_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_kaiser_frame_add(a : SignalwindowkaiserFrame, b : SignalwindowkaiserFrame) -> SignalwindowkaiserFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_kaiser_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_kaiser_frame_copy(s : SignalwindowkaiserFrame) -> SignalwindowkaiserFrame {
  let result = signal_window_kaiser_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_kaiser_frame_fill(s : SignalwindowkaiserFrame, v : Double) -> SignalwindowkaiserFrame {
  let result = signal_window_kaiser_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_frame_min(s : SignalwindowkaiserFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_frame_max(s : SignalwindowkaiserFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_frame_to_string(s : SignalwindowkaiserFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_table_make(size : Int) -> SignalwindowkaiserTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_table_len(s : SignalwindowkaiserTable) -> Int { s.size }

pub fn signal_window_kaiser_table_get(s : SignalwindowkaiserTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_table_set(s : SignalwindowkaiserTable, i : Int, v : Double) -> SignalwindowkaiserTable {
  let result = signal_window_kaiser_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_table_sum(s : SignalwindowkaiserTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_kaiser_table_mean(s : SignalwindowkaiserTable) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_kaiser_table_sum(s) / s.size.to_double() }
}

pub fn signal_window_kaiser_table_scale(s : SignalwindowkaiserTable, f : Double) -> SignalwindowkaiserTable {
  let result = signal_window_kaiser_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_kaiser_table_add(a : SignalwindowkaiserTable, b : SignalwindowkaiserTable) -> SignalwindowkaiserTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_kaiser_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_kaiser_table_copy(s : SignalwindowkaiserTable) -> SignalwindowkaiserTable {
  let result = signal_window_kaiser_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_kaiser_table_fill(s : SignalwindowkaiserTable, v : Double) -> SignalwindowkaiserTable {
  let result = signal_window_kaiser_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_table_min(s : SignalwindowkaiserTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_table_max(s : SignalwindowkaiserTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_table_to_string(s : SignalwindowkaiserTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_graphn_make(size : Int) -> SignalwindowkaiserGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_graphn_len(s : SignalwindowkaiserGraphN) -> Int { s.size }

pub fn signal_window_kaiser_graphn_get(s : SignalwindowkaiserGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_graphn_set(s : SignalwindowkaiserGraphN, i : Int, v : Double) -> SignalwindowkaiserGraphN {
  let result = signal_window_kaiser_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_graphn_sum(s : SignalwindowkaiserGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_kaiser_graphn_mean(s : SignalwindowkaiserGraphN) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_kaiser_graphn_sum(s) / s.size.to_double() }
}

pub fn signal_window_kaiser_graphn_scale(s : SignalwindowkaiserGraphN, f : Double) -> SignalwindowkaiserGraphN {
  let result = signal_window_kaiser_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_kaiser_graphn_add(a : SignalwindowkaiserGraphN, b : SignalwindowkaiserGraphN) -> SignalwindowkaiserGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_kaiser_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_kaiser_graphn_copy(s : SignalwindowkaiserGraphN) -> SignalwindowkaiserGraphN {
  let result = signal_window_kaiser_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_kaiser_graphn_fill(s : SignalwindowkaiserGraphN, v : Double) -> SignalwindowkaiserGraphN {
  let result = signal_window_kaiser_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_graphn_min(s : SignalwindowkaiserGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_graphn_max(s : SignalwindowkaiserGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_graphn_to_string(s : SignalwindowkaiserGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_node_make(size : Int) -> SignalwindowkaiserNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_node_len(s : SignalwindowkaiserNode) -> Int { s.size }

pub fn signal_window_kaiser_node_get(s : SignalwindowkaiserNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_node_set(s : SignalwindowkaiserNode, i : Int, v : Double) -> SignalwindowkaiserNode {
  let result = signal_window_kaiser_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_node_sum(s : SignalwindowkaiserNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_kaiser_node_mean(s : SignalwindowkaiserNode) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_kaiser_node_sum(s) / s.size.to_double() }
}

pub fn signal_window_kaiser_node_scale(s : SignalwindowkaiserNode, f : Double) -> SignalwindowkaiserNode {
  let result = signal_window_kaiser_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_kaiser_node_add(a : SignalwindowkaiserNode, b : SignalwindowkaiserNode) -> SignalwindowkaiserNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_kaiser_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_kaiser_node_copy(s : SignalwindowkaiserNode) -> SignalwindowkaiserNode {
  let result = signal_window_kaiser_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_kaiser_node_fill(s : SignalwindowkaiserNode, v : Double) -> SignalwindowkaiserNode {
  let result = signal_window_kaiser_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_node_min(s : SignalwindowkaiserNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_node_max(s : SignalwindowkaiserNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_node_to_string(s : SignalwindowkaiserNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_edge_make(size : Int) -> SignalwindowkaiserEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_edge_len(s : SignalwindowkaiserEdge) -> Int { s.size }

pub fn signal_window_kaiser_edge_get(s : SignalwindowkaiserEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_edge_set(s : SignalwindowkaiserEdge, i : Int, v : Double) -> SignalwindowkaiserEdge {
  let result = signal_window_kaiser_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_edge_sum(s : SignalwindowkaiserEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_kaiser_edge_mean(s : SignalwindowkaiserEdge) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_kaiser_edge_sum(s) / s.size.to_double() }
}

pub fn signal_window_kaiser_edge_scale(s : SignalwindowkaiserEdge, f : Double) -> SignalwindowkaiserEdge {
  let result = signal_window_kaiser_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_kaiser_edge_add(a : SignalwindowkaiserEdge, b : SignalwindowkaiserEdge) -> SignalwindowkaiserEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_kaiser_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_kaiser_edge_copy(s : SignalwindowkaiserEdge) -> SignalwindowkaiserEdge {
  let result = signal_window_kaiser_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_kaiser_edge_fill(s : SignalwindowkaiserEdge, v : Double) -> SignalwindowkaiserEdge {
  let result = signal_window_kaiser_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_edge_min(s : SignalwindowkaiserEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_edge_max(s : SignalwindowkaiserEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_edge_to_string(s : SignalwindowkaiserEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_path_make(size : Int) -> SignalwindowkaiserPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_path_len(s : SignalwindowkaiserPath) -> Int { s.size }

pub fn signal_window_kaiser_path_get(s : SignalwindowkaiserPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_path_set(s : SignalwindowkaiserPath, i : Int, v : Double) -> SignalwindowkaiserPath {
  let result = signal_window_kaiser_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_path_sum(s : SignalwindowkaiserPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_kaiser_path_mean(s : SignalwindowkaiserPath) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_kaiser_path_sum(s) / s.size.to_double() }
}

pub fn signal_window_kaiser_path_scale(s : SignalwindowkaiserPath, f : Double) -> SignalwindowkaiserPath {
  let result = signal_window_kaiser_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_kaiser_path_add(a : SignalwindowkaiserPath, b : SignalwindowkaiserPath) -> SignalwindowkaiserPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_kaiser_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_kaiser_path_copy(s : SignalwindowkaiserPath) -> SignalwindowkaiserPath {
  let result = signal_window_kaiser_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_kaiser_path_fill(s : SignalwindowkaiserPath, v : Double) -> SignalwindowkaiserPath {
  let result = signal_window_kaiser_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_path_min(s : SignalwindowkaiserPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_path_max(s : SignalwindowkaiserPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_path_to_string(s : SignalwindowkaiserPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_cluster_make(size : Int) -> SignalwindowkaiserCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_cluster_len(s : SignalwindowkaiserCluster) -> Int { s.size }

pub fn signal_window_kaiser_cluster_get(s : SignalwindowkaiserCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_cluster_set(s : SignalwindowkaiserCluster, i : Int, v : Double) -> SignalwindowkaiserCluster {
  let result = signal_window_kaiser_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_cluster_sum(s : SignalwindowkaiserCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_kaiser_cluster_mean(s : SignalwindowkaiserCluster) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_kaiser_cluster_sum(s) / s.size.to_double() }
}

pub fn signal_window_kaiser_cluster_scale(s : SignalwindowkaiserCluster, f : Double) -> SignalwindowkaiserCluster {
  let result = signal_window_kaiser_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_kaiser_cluster_add(a : SignalwindowkaiserCluster, b : SignalwindowkaiserCluster) -> SignalwindowkaiserCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_kaiser_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_kaiser_cluster_copy(s : SignalwindowkaiserCluster) -> SignalwindowkaiserCluster {
  let result = signal_window_kaiser_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_kaiser_cluster_fill(s : SignalwindowkaiserCluster, v : Double) -> SignalwindowkaiserCluster {
  let result = signal_window_kaiser_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_cluster_min(s : SignalwindowkaiserCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_cluster_max(s : SignalwindowkaiserCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_cluster_to_string(s : SignalwindowkaiserCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_model_make(size : Int) -> SignalwindowkaiserModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_model_len(s : SignalwindowkaiserModel) -> Int { s.size }

pub fn signal_window_kaiser_model_get(s : SignalwindowkaiserModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_model_set(s : SignalwindowkaiserModel, i : Int, v : Double) -> SignalwindowkaiserModel {
  let result = signal_window_kaiser_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_model_sum(s : SignalwindowkaiserModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_kaiser_model_mean(s : SignalwindowkaiserModel) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_kaiser_model_sum(s) / s.size.to_double() }
}

pub fn signal_window_kaiser_model_scale(s : SignalwindowkaiserModel, f : Double) -> SignalwindowkaiserModel {
  let result = signal_window_kaiser_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_kaiser_model_add(a : SignalwindowkaiserModel, b : SignalwindowkaiserModel) -> SignalwindowkaiserModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_kaiser_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_kaiser_model_copy(s : SignalwindowkaiserModel) -> SignalwindowkaiserModel {
  let result = signal_window_kaiser_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_kaiser_model_fill(s : SignalwindowkaiserModel, v : Double) -> SignalwindowkaiserModel {
  let result = signal_window_kaiser_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_model_min(s : SignalwindowkaiserModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_model_max(s : SignalwindowkaiserModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_model_to_string(s : SignalwindowkaiserModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_layer_make(size : Int) -> SignalwindowkaiserLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_layer_len(s : SignalwindowkaiserLayer) -> Int { s.size }

pub fn signal_window_kaiser_layer_get(s : SignalwindowkaiserLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_layer_set(s : SignalwindowkaiserLayer, i : Int, v : Double) -> SignalwindowkaiserLayer {
  let result = signal_window_kaiser_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_layer_sum(s : SignalwindowkaiserLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_kaiser_layer_mean(s : SignalwindowkaiserLayer) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_kaiser_layer_sum(s) / s.size.to_double() }
}

pub fn signal_window_kaiser_layer_scale(s : SignalwindowkaiserLayer, f : Double) -> SignalwindowkaiserLayer {
  let result = signal_window_kaiser_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_kaiser_layer_add(a : SignalwindowkaiserLayer, b : SignalwindowkaiserLayer) -> SignalwindowkaiserLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_kaiser_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_kaiser_layer_copy(s : SignalwindowkaiserLayer) -> SignalwindowkaiserLayer {
  let result = signal_window_kaiser_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_kaiser_layer_fill(s : SignalwindowkaiserLayer, v : Double) -> SignalwindowkaiserLayer {
  let result = signal_window_kaiser_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_layer_min(s : SignalwindowkaiserLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_layer_max(s : SignalwindowkaiserLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_layer_to_string(s : SignalwindowkaiserLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_buffer_make(size : Int) -> SignalwindowkaiserBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_buffer_len(s : SignalwindowkaiserBuffer) -> Int { s.size }

pub fn signal_window_kaiser_buffer_get(s : SignalwindowkaiserBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_buffer_set(s : SignalwindowkaiserBuffer, i : Int, v : Double) -> SignalwindowkaiserBuffer {
  let result = signal_window_kaiser_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_buffer_sum(s : SignalwindowkaiserBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_kaiser_buffer_mean(s : SignalwindowkaiserBuffer) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_kaiser_buffer_sum(s) / s.size.to_double() }
}

pub fn signal_window_kaiser_buffer_scale(s : SignalwindowkaiserBuffer, f : Double) -> SignalwindowkaiserBuffer {
  let result = signal_window_kaiser_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_kaiser_buffer_add(a : SignalwindowkaiserBuffer, b : SignalwindowkaiserBuffer) -> SignalwindowkaiserBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_kaiser_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_kaiser_buffer_copy(s : SignalwindowkaiserBuffer) -> SignalwindowkaiserBuffer {
  let result = signal_window_kaiser_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_kaiser_buffer_fill(s : SignalwindowkaiserBuffer, v : Double) -> SignalwindowkaiserBuffer {
  let result = signal_window_kaiser_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_buffer_min(s : SignalwindowkaiserBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_buffer_max(s : SignalwindowkaiserBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_buffer_to_string(s : SignalwindowkaiserBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_cursor_make(size : Int) -> SignalwindowkaiserCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_cursor_len(s : SignalwindowkaiserCursor) -> Int { s.size }

pub fn signal_window_kaiser_cursor_get(s : SignalwindowkaiserCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_cursor_set(s : SignalwindowkaiserCursor, i : Int, v : Double) -> SignalwindowkaiserCursor {
  let result = signal_window_kaiser_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_cursor_sum(s : SignalwindowkaiserCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_kaiser_cursor_mean(s : SignalwindowkaiserCursor) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_kaiser_cursor_sum(s) / s.size.to_double() }
}

pub fn signal_window_kaiser_cursor_scale(s : SignalwindowkaiserCursor, f : Double) -> SignalwindowkaiserCursor {
  let result = signal_window_kaiser_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_kaiser_cursor_add(a : SignalwindowkaiserCursor, b : SignalwindowkaiserCursor) -> SignalwindowkaiserCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_kaiser_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_kaiser_cursor_copy(s : SignalwindowkaiserCursor) -> SignalwindowkaiserCursor {
  let result = signal_window_kaiser_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_kaiser_cursor_fill(s : SignalwindowkaiserCursor, v : Double) -> SignalwindowkaiserCursor {
  let result = signal_window_kaiser_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_cursor_min(s : SignalwindowkaiserCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_cursor_max(s : SignalwindowkaiserCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_cursor_to_string(s : SignalwindowkaiserCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_view_make(size : Int) -> SignalwindowkaiserView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_view_len(s : SignalwindowkaiserView) -> Int { s.size }

pub fn signal_window_kaiser_view_get(s : SignalwindowkaiserView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_view_set(s : SignalwindowkaiserView, i : Int, v : Double) -> SignalwindowkaiserView {
  let result = signal_window_kaiser_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_view_sum(s : SignalwindowkaiserView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_kaiser_view_mean(s : SignalwindowkaiserView) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_kaiser_view_sum(s) / s.size.to_double() }
}

pub fn signal_window_kaiser_view_scale(s : SignalwindowkaiserView, f : Double) -> SignalwindowkaiserView {
  let result = signal_window_kaiser_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_kaiser_view_add(a : SignalwindowkaiserView, b : SignalwindowkaiserView) -> SignalwindowkaiserView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_kaiser_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_kaiser_view_copy(s : SignalwindowkaiserView) -> SignalwindowkaiserView {
  let result = signal_window_kaiser_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_kaiser_view_fill(s : SignalwindowkaiserView, v : Double) -> SignalwindowkaiserView {
  let result = signal_window_kaiser_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_view_min(s : SignalwindowkaiserView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_view_max(s : SignalwindowkaiserView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_view_to_string(s : SignalwindowkaiserView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_range_make(size : Int) -> SignalwindowkaiserRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_range_len(s : SignalwindowkaiserRange) -> Int { s.size }

pub fn signal_window_kaiser_range_get(s : SignalwindowkaiserRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_range_set(s : SignalwindowkaiserRange, i : Int, v : Double) -> SignalwindowkaiserRange {
  let result = signal_window_kaiser_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_range_sum(s : SignalwindowkaiserRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_kaiser_range_mean(s : SignalwindowkaiserRange) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_kaiser_range_sum(s) / s.size.to_double() }
}

pub fn signal_window_kaiser_range_scale(s : SignalwindowkaiserRange, f : Double) -> SignalwindowkaiserRange {
  let result = signal_window_kaiser_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_kaiser_range_add(a : SignalwindowkaiserRange, b : SignalwindowkaiserRange) -> SignalwindowkaiserRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_kaiser_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_kaiser_range_copy(s : SignalwindowkaiserRange) -> SignalwindowkaiserRange {
  let result = signal_window_kaiser_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_kaiser_range_fill(s : SignalwindowkaiserRange, v : Double) -> SignalwindowkaiserRange {
  let result = signal_window_kaiser_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_range_min(s : SignalwindowkaiserRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_range_max(s : SignalwindowkaiserRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_range_to_string(s : SignalwindowkaiserRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_slice_make(size : Int) -> SignalwindowkaiserSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_slice_len(s : SignalwindowkaiserSlice) -> Int { s.size }

pub fn signal_window_kaiser_slice_get(s : SignalwindowkaiserSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_slice_set(s : SignalwindowkaiserSlice, i : Int, v : Double) -> SignalwindowkaiserSlice {
  let result = signal_window_kaiser_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_slice_sum(s : SignalwindowkaiserSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_kaiser_slice_mean(s : SignalwindowkaiserSlice) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_kaiser_slice_sum(s) / s.size.to_double() }
}

pub fn signal_window_kaiser_slice_scale(s : SignalwindowkaiserSlice, f : Double) -> SignalwindowkaiserSlice {
  let result = signal_window_kaiser_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_kaiser_slice_add(a : SignalwindowkaiserSlice, b : SignalwindowkaiserSlice) -> SignalwindowkaiserSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_kaiser_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_kaiser_slice_copy(s : SignalwindowkaiserSlice) -> SignalwindowkaiserSlice {
  let result = signal_window_kaiser_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_kaiser_slice_fill(s : SignalwindowkaiserSlice, v : Double) -> SignalwindowkaiserSlice {
  let result = signal_window_kaiser_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_kaiser_slice_min(s : SignalwindowkaiserSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_slice_max(s : SignalwindowkaiserSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_kaiser_slice_to_string(s : SignalwindowkaiserSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

