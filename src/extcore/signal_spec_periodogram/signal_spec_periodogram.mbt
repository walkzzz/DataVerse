///===
/// extcore/signal_spec_periodogram

pub(all) struct SignalspecperiodogramPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_periodogram_make_point(x : Double, y : Double) -> SignalspecperiodogramPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_periodogram_make_point3(x : Double, y : Double, z : Double) -> SignalspecperiodogramPoint {
  { x, y, z, label: 0 }
}

pub fn signal_spec_periodogram_point_x(pt : SignalspecperiodogramPoint) -> Double { pt.x }

pub fn signal_spec_periodogram_point_y(pt : SignalspecperiodogramPoint) -> Double { pt.y }

pub fn signal_spec_periodogram_point_z(pt : SignalspecperiodogramPoint) -> Double { pt.z }

pub fn signal_spec_periodogram_point_label(pt : SignalspecperiodogramPoint) -> Int { pt.label }

pub fn signal_spec_periodogram_point_dist(a : SignalspecperiodogramPoint, b : SignalspecperiodogramPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_spec_periodogram_point_add(a : SignalspecperiodogramPoint, b : SignalspecperiodogramPoint) -> SignalspecperiodogramPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_spec_periodogram_point_sub(a : SignalspecperiodogramPoint, b : SignalspecperiodogramPoint) -> SignalspecperiodogramPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_spec_periodogram_point_scale(pt : SignalspecperiodogramPoint, s : Double) -> SignalspecperiodogramPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_spec_periodogram_point_dot(a : SignalspecperiodogramPoint, b : SignalspecperiodogramPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_spec_periodogram_point_cross(a : SignalspecperiodogramPoint, b : SignalspecperiodogramPoint) -> SignalspecperiodogramPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_spec_periodogram_point_norm(pt : SignalspecperiodogramPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_spec_periodogram_point_normalize(pt : SignalspecperiodogramPoint) -> SignalspecperiodogramPoint {
  let n = signal_spec_periodogram_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_spec_periodogram_point_scale(pt, 1.0 / n) }
}

pub fn signal_spec_periodogram_point_negate(pt : SignalspecperiodogramPoint) -> SignalspecperiodogramPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_spec_periodogram_point_mid(a : SignalspecperiodogramPoint, b : SignalspecperiodogramPoint) -> SignalspecperiodogramPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_spec_periodogram_point_lerp(a : SignalspecperiodogramPoint, b : SignalspecperiodogramPoint, t : Double) -> SignalspecperiodogramPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_spec_periodogram_point_to_string(pt : SignalspecperiodogramPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalspecperiodogramSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_periodogram_make_series(vals : Array[Double], name : String) -> SignalspecperiodogramSeries {
  { vals, name, meta: 0 }
}

pub fn signal_spec_periodogram_series_len(s : SignalspecperiodogramSeries) -> Int { s.vals.length() }

pub fn signal_spec_periodogram_series_sum(s : SignalspecperiodogramSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn signal_spec_periodogram_series_mean(s : SignalspecperiodogramSeries) -> Double { @_common.mean(s.vals) }

pub fn signal_spec_periodogram_series_min(s : SignalspecperiodogramSeries) -> Double { @_common.min(s.vals) }

pub fn signal_spec_periodogram_series_max(s : SignalspecperiodogramSeries) -> Double { @_common.max(s.vals) }

pub fn signal_spec_periodogram_series_range(s : SignalspecperiodogramSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn signal_spec_periodogram_series_var(s : SignalspecperiodogramSeries) -> Double { @_common.variance(s.vals) }

pub fn signal_spec_periodogram_series_std(s : SignalspecperiodogramSeries) -> Double { @_common.std(s.vals) }

pub fn signal_spec_periodogram_series_median(s : SignalspecperiodogramSeries) -> Double { @_common.median(s.vals) }

pub fn signal_spec_periodogram_series_scale(s : SignalspecperiodogramSeries, f : Double) -> SignalspecperiodogramSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_spec_periodogram_series_add(a : SignalspecperiodogramSeries, b : SignalspecperiodogramSeries) -> SignalspecperiodogramSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_spec_periodogram_series_sub(a : SignalspecperiodogramSeries, b : SignalspecperiodogramSeries) -> SignalspecperiodogramSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_spec_periodogram_series_normalize(s : SignalspecperiodogramSeries) -> SignalspecperiodogramSeries {
  let mn = signal_spec_periodogram_series_min(s)
  let mx = signal_spec_periodogram_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_spec_periodogram_series_cumsum(s : SignalspecperiodogramSeries) -> SignalspecperiodogramSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_spec_periodogram_series_to_string(s : SignalspecperiodogramSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecperiodogramMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_periodogram_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecperiodogramMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_periodogram_matrix_identity(n : Int) -> SignalspecperiodogramMatrix {
  let m = signal_spec_periodogram_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_spec_periodogram_matrix_get(m : SignalspecperiodogramMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_spec_periodogram_matrix_transpose(m : SignalspecperiodogramMatrix) -> SignalspecperiodogramMatrix {
  let result = signal_spec_periodogram_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_spec_periodogram_matrix_add(a : SignalspecperiodogramMatrix, b : SignalspecperiodogramMatrix) -> SignalspecperiodogramMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_spec_periodogram_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_spec_periodogram_matrix_scale(m : SignalspecperiodogramMatrix, s : Double) -> SignalspecperiodogramMatrix {
  let result = signal_spec_periodogram_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_spec_periodogram_matrix_multiply(a : SignalspecperiodogramMatrix, b : SignalspecperiodogramMatrix) -> SignalspecperiodogramMatrix {
  if a.cols != b.rows { return signal_spec_periodogram_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_spec_periodogram_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_spec_periodogram_matrix_trace(m : SignalspecperiodogramMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_spec_periodogram_matrix_det(m : SignalspecperiodogramMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_spec_periodogram_matrix_norm(m : SignalspecperiodogramMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_spec_periodogram_matrix_to_string(m : SignalspecperiodogramMatrix) -> String {
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

pub(all) struct SignalspecperiodogramVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_periodogram_make_vector(comps : Array[Double]) -> SignalspecperiodogramVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_periodogram_vector_zero(dim : Int) -> SignalspecperiodogramVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_spec_periodogram_vector_add(a : SignalspecperiodogramVector, b : SignalspecperiodogramVector) -> SignalspecperiodogramVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_spec_periodogram_vector_sub(a : SignalspecperiodogramVector, b : SignalspecperiodogramVector) -> SignalspecperiodogramVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_spec_periodogram_vector_scale(v : SignalspecperiodogramVector, s : Double) -> SignalspecperiodogramVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_spec_periodogram_vector_dot(a : SignalspecperiodogramVector, b : SignalspecperiodogramVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_spec_periodogram_vector_norm(v : SignalspecperiodogramVector) -> Double { @_common.sqrt(signal_spec_periodogram_vector_dot(v, v)) }

pub fn signal_spec_periodogram_vector_normalize(v : SignalspecperiodogramVector) -> SignalspecperiodogramVector {
  let n = signal_spec_periodogram_vector_norm(v)
  if n < 0.0000001 { v } else { signal_spec_periodogram_vector_scale(v, 1.0 / n) }
}

pub fn signal_spec_periodogram_vector_dist(a : SignalspecperiodogramVector, b : SignalspecperiodogramVector) -> Double {
  signal_spec_periodogram_vector_norm(signal_spec_periodogram_vector_sub(a, b))
}

pub fn signal_spec_periodogram_vector_to_string(v : SignalspecperiodogramVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_spec_periodogram_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_spec_periodogram_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_spec_periodogram_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_spec_periodogram_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_spec_periodogram_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_spec_periodogram_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_spec_periodogram_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_spec_periodogram_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_spec_periodogram_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_spec_periodogram_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_spec_periodogram_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_spec_periodogram_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_spec_periodogram_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_spec_periodogram_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_spec_periodogram_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_spec_periodogram_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_spec_periodogram_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_spec_periodogram_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_spec_periodogram_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_spec_periodogram_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_spec_periodogram_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_spec_periodogram_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_spec_periodogram_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_spec_periodogram_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_spec_periodogram_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_spec_periodogram_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_spec_periodogram_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_spec_periodogram_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_spec_periodogram_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalspecperiodogramFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_frame_make(size : Int) -> SignalspecperiodogramFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_frame_len(s : SignalspecperiodogramFrame) -> Int { s.size }

pub fn signal_spec_periodogram_frame_get(s : SignalspecperiodogramFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_frame_set(s : SignalspecperiodogramFrame, i : Int, v : Double) -> SignalspecperiodogramFrame {
  let result = signal_spec_periodogram_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_frame_sum(s : SignalspecperiodogramFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_periodogram_frame_mean(s : SignalspecperiodogramFrame) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_periodogram_frame_sum(s) / s.size.to_double() }
}

pub fn signal_spec_periodogram_frame_scale(s : SignalspecperiodogramFrame, f : Double) -> SignalspecperiodogramFrame {
  let result = signal_spec_periodogram_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_periodogram_frame_add(a : SignalspecperiodogramFrame, b : SignalspecperiodogramFrame) -> SignalspecperiodogramFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_periodogram_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_periodogram_frame_copy(s : SignalspecperiodogramFrame) -> SignalspecperiodogramFrame {
  let result = signal_spec_periodogram_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_periodogram_frame_fill(s : SignalspecperiodogramFrame, v : Double) -> SignalspecperiodogramFrame {
  let result = signal_spec_periodogram_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_frame_min(s : SignalspecperiodogramFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_frame_max(s : SignalspecperiodogramFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_frame_to_string(s : SignalspecperiodogramFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_table_make(size : Int) -> SignalspecperiodogramTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_table_len(s : SignalspecperiodogramTable) -> Int { s.size }

pub fn signal_spec_periodogram_table_get(s : SignalspecperiodogramTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_table_set(s : SignalspecperiodogramTable, i : Int, v : Double) -> SignalspecperiodogramTable {
  let result = signal_spec_periodogram_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_table_sum(s : SignalspecperiodogramTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_periodogram_table_mean(s : SignalspecperiodogramTable) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_periodogram_table_sum(s) / s.size.to_double() }
}

pub fn signal_spec_periodogram_table_scale(s : SignalspecperiodogramTable, f : Double) -> SignalspecperiodogramTable {
  let result = signal_spec_periodogram_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_periodogram_table_add(a : SignalspecperiodogramTable, b : SignalspecperiodogramTable) -> SignalspecperiodogramTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_periodogram_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_periodogram_table_copy(s : SignalspecperiodogramTable) -> SignalspecperiodogramTable {
  let result = signal_spec_periodogram_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_periodogram_table_fill(s : SignalspecperiodogramTable, v : Double) -> SignalspecperiodogramTable {
  let result = signal_spec_periodogram_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_table_min(s : SignalspecperiodogramTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_table_max(s : SignalspecperiodogramTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_table_to_string(s : SignalspecperiodogramTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_graphn_make(size : Int) -> SignalspecperiodogramGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_graphn_len(s : SignalspecperiodogramGraphN) -> Int { s.size }

pub fn signal_spec_periodogram_graphn_get(s : SignalspecperiodogramGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_graphn_set(s : SignalspecperiodogramGraphN, i : Int, v : Double) -> SignalspecperiodogramGraphN {
  let result = signal_spec_periodogram_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_graphn_sum(s : SignalspecperiodogramGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_periodogram_graphn_mean(s : SignalspecperiodogramGraphN) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_periodogram_graphn_sum(s) / s.size.to_double() }
}

pub fn signal_spec_periodogram_graphn_scale(s : SignalspecperiodogramGraphN, f : Double) -> SignalspecperiodogramGraphN {
  let result = signal_spec_periodogram_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_periodogram_graphn_add(a : SignalspecperiodogramGraphN, b : SignalspecperiodogramGraphN) -> SignalspecperiodogramGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_periodogram_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_periodogram_graphn_copy(s : SignalspecperiodogramGraphN) -> SignalspecperiodogramGraphN {
  let result = signal_spec_periodogram_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_periodogram_graphn_fill(s : SignalspecperiodogramGraphN, v : Double) -> SignalspecperiodogramGraphN {
  let result = signal_spec_periodogram_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_graphn_min(s : SignalspecperiodogramGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_graphn_max(s : SignalspecperiodogramGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_graphn_to_string(s : SignalspecperiodogramGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_node_make(size : Int) -> SignalspecperiodogramNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_node_len(s : SignalspecperiodogramNode) -> Int { s.size }

pub fn signal_spec_periodogram_node_get(s : SignalspecperiodogramNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_node_set(s : SignalspecperiodogramNode, i : Int, v : Double) -> SignalspecperiodogramNode {
  let result = signal_spec_periodogram_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_node_sum(s : SignalspecperiodogramNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_periodogram_node_mean(s : SignalspecperiodogramNode) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_periodogram_node_sum(s) / s.size.to_double() }
}

pub fn signal_spec_periodogram_node_scale(s : SignalspecperiodogramNode, f : Double) -> SignalspecperiodogramNode {
  let result = signal_spec_periodogram_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_periodogram_node_add(a : SignalspecperiodogramNode, b : SignalspecperiodogramNode) -> SignalspecperiodogramNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_periodogram_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_periodogram_node_copy(s : SignalspecperiodogramNode) -> SignalspecperiodogramNode {
  let result = signal_spec_periodogram_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_periodogram_node_fill(s : SignalspecperiodogramNode, v : Double) -> SignalspecperiodogramNode {
  let result = signal_spec_periodogram_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_node_min(s : SignalspecperiodogramNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_node_max(s : SignalspecperiodogramNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_node_to_string(s : SignalspecperiodogramNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_edge_make(size : Int) -> SignalspecperiodogramEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_edge_len(s : SignalspecperiodogramEdge) -> Int { s.size }

pub fn signal_spec_periodogram_edge_get(s : SignalspecperiodogramEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_edge_set(s : SignalspecperiodogramEdge, i : Int, v : Double) -> SignalspecperiodogramEdge {
  let result = signal_spec_periodogram_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_edge_sum(s : SignalspecperiodogramEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_periodogram_edge_mean(s : SignalspecperiodogramEdge) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_periodogram_edge_sum(s) / s.size.to_double() }
}

pub fn signal_spec_periodogram_edge_scale(s : SignalspecperiodogramEdge, f : Double) -> SignalspecperiodogramEdge {
  let result = signal_spec_periodogram_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_periodogram_edge_add(a : SignalspecperiodogramEdge, b : SignalspecperiodogramEdge) -> SignalspecperiodogramEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_periodogram_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_periodogram_edge_copy(s : SignalspecperiodogramEdge) -> SignalspecperiodogramEdge {
  let result = signal_spec_periodogram_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_periodogram_edge_fill(s : SignalspecperiodogramEdge, v : Double) -> SignalspecperiodogramEdge {
  let result = signal_spec_periodogram_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_edge_min(s : SignalspecperiodogramEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_edge_max(s : SignalspecperiodogramEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_edge_to_string(s : SignalspecperiodogramEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_path_make(size : Int) -> SignalspecperiodogramPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_path_len(s : SignalspecperiodogramPath) -> Int { s.size }

pub fn signal_spec_periodogram_path_get(s : SignalspecperiodogramPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_path_set(s : SignalspecperiodogramPath, i : Int, v : Double) -> SignalspecperiodogramPath {
  let result = signal_spec_periodogram_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_path_sum(s : SignalspecperiodogramPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_periodogram_path_mean(s : SignalspecperiodogramPath) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_periodogram_path_sum(s) / s.size.to_double() }
}

pub fn signal_spec_periodogram_path_scale(s : SignalspecperiodogramPath, f : Double) -> SignalspecperiodogramPath {
  let result = signal_spec_periodogram_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_periodogram_path_add(a : SignalspecperiodogramPath, b : SignalspecperiodogramPath) -> SignalspecperiodogramPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_periodogram_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_periodogram_path_copy(s : SignalspecperiodogramPath) -> SignalspecperiodogramPath {
  let result = signal_spec_periodogram_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_periodogram_path_fill(s : SignalspecperiodogramPath, v : Double) -> SignalspecperiodogramPath {
  let result = signal_spec_periodogram_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_path_min(s : SignalspecperiodogramPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_path_max(s : SignalspecperiodogramPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_path_to_string(s : SignalspecperiodogramPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_cluster_make(size : Int) -> SignalspecperiodogramCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_cluster_len(s : SignalspecperiodogramCluster) -> Int { s.size }

pub fn signal_spec_periodogram_cluster_get(s : SignalspecperiodogramCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_cluster_set(s : SignalspecperiodogramCluster, i : Int, v : Double) -> SignalspecperiodogramCluster {
  let result = signal_spec_periodogram_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_cluster_sum(s : SignalspecperiodogramCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_periodogram_cluster_mean(s : SignalspecperiodogramCluster) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_periodogram_cluster_sum(s) / s.size.to_double() }
}

pub fn signal_spec_periodogram_cluster_scale(s : SignalspecperiodogramCluster, f : Double) -> SignalspecperiodogramCluster {
  let result = signal_spec_periodogram_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_periodogram_cluster_add(a : SignalspecperiodogramCluster, b : SignalspecperiodogramCluster) -> SignalspecperiodogramCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_periodogram_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_periodogram_cluster_copy(s : SignalspecperiodogramCluster) -> SignalspecperiodogramCluster {
  let result = signal_spec_periodogram_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_periodogram_cluster_fill(s : SignalspecperiodogramCluster, v : Double) -> SignalspecperiodogramCluster {
  let result = signal_spec_periodogram_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_cluster_min(s : SignalspecperiodogramCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_cluster_max(s : SignalspecperiodogramCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_cluster_to_string(s : SignalspecperiodogramCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_model_make(size : Int) -> SignalspecperiodogramModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_model_len(s : SignalspecperiodogramModel) -> Int { s.size }

pub fn signal_spec_periodogram_model_get(s : SignalspecperiodogramModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_model_set(s : SignalspecperiodogramModel, i : Int, v : Double) -> SignalspecperiodogramModel {
  let result = signal_spec_periodogram_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_model_sum(s : SignalspecperiodogramModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_periodogram_model_mean(s : SignalspecperiodogramModel) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_periodogram_model_sum(s) / s.size.to_double() }
}

pub fn signal_spec_periodogram_model_scale(s : SignalspecperiodogramModel, f : Double) -> SignalspecperiodogramModel {
  let result = signal_spec_periodogram_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_periodogram_model_add(a : SignalspecperiodogramModel, b : SignalspecperiodogramModel) -> SignalspecperiodogramModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_periodogram_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_periodogram_model_copy(s : SignalspecperiodogramModel) -> SignalspecperiodogramModel {
  let result = signal_spec_periodogram_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_periodogram_model_fill(s : SignalspecperiodogramModel, v : Double) -> SignalspecperiodogramModel {
  let result = signal_spec_periodogram_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_model_min(s : SignalspecperiodogramModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_model_max(s : SignalspecperiodogramModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_model_to_string(s : SignalspecperiodogramModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_layer_make(size : Int) -> SignalspecperiodogramLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_layer_len(s : SignalspecperiodogramLayer) -> Int { s.size }

pub fn signal_spec_periodogram_layer_get(s : SignalspecperiodogramLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_layer_set(s : SignalspecperiodogramLayer, i : Int, v : Double) -> SignalspecperiodogramLayer {
  let result = signal_spec_periodogram_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_layer_sum(s : SignalspecperiodogramLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_periodogram_layer_mean(s : SignalspecperiodogramLayer) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_periodogram_layer_sum(s) / s.size.to_double() }
}

pub fn signal_spec_periodogram_layer_scale(s : SignalspecperiodogramLayer, f : Double) -> SignalspecperiodogramLayer {
  let result = signal_spec_periodogram_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_periodogram_layer_add(a : SignalspecperiodogramLayer, b : SignalspecperiodogramLayer) -> SignalspecperiodogramLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_periodogram_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_periodogram_layer_copy(s : SignalspecperiodogramLayer) -> SignalspecperiodogramLayer {
  let result = signal_spec_periodogram_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_periodogram_layer_fill(s : SignalspecperiodogramLayer, v : Double) -> SignalspecperiodogramLayer {
  let result = signal_spec_periodogram_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_layer_min(s : SignalspecperiodogramLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_layer_max(s : SignalspecperiodogramLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_layer_to_string(s : SignalspecperiodogramLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_buffer_make(size : Int) -> SignalspecperiodogramBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_buffer_len(s : SignalspecperiodogramBuffer) -> Int { s.size }

pub fn signal_spec_periodogram_buffer_get(s : SignalspecperiodogramBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_buffer_set(s : SignalspecperiodogramBuffer, i : Int, v : Double) -> SignalspecperiodogramBuffer {
  let result = signal_spec_periodogram_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_buffer_sum(s : SignalspecperiodogramBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_periodogram_buffer_mean(s : SignalspecperiodogramBuffer) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_periodogram_buffer_sum(s) / s.size.to_double() }
}

pub fn signal_spec_periodogram_buffer_scale(s : SignalspecperiodogramBuffer, f : Double) -> SignalspecperiodogramBuffer {
  let result = signal_spec_periodogram_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_periodogram_buffer_add(a : SignalspecperiodogramBuffer, b : SignalspecperiodogramBuffer) -> SignalspecperiodogramBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_periodogram_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_periodogram_buffer_copy(s : SignalspecperiodogramBuffer) -> SignalspecperiodogramBuffer {
  let result = signal_spec_periodogram_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_periodogram_buffer_fill(s : SignalspecperiodogramBuffer, v : Double) -> SignalspecperiodogramBuffer {
  let result = signal_spec_periodogram_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_buffer_min(s : SignalspecperiodogramBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_buffer_max(s : SignalspecperiodogramBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_buffer_to_string(s : SignalspecperiodogramBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_cursor_make(size : Int) -> SignalspecperiodogramCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_cursor_len(s : SignalspecperiodogramCursor) -> Int { s.size }

pub fn signal_spec_periodogram_cursor_get(s : SignalspecperiodogramCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_cursor_set(s : SignalspecperiodogramCursor, i : Int, v : Double) -> SignalspecperiodogramCursor {
  let result = signal_spec_periodogram_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_cursor_sum(s : SignalspecperiodogramCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_periodogram_cursor_mean(s : SignalspecperiodogramCursor) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_periodogram_cursor_sum(s) / s.size.to_double() }
}

pub fn signal_spec_periodogram_cursor_scale(s : SignalspecperiodogramCursor, f : Double) -> SignalspecperiodogramCursor {
  let result = signal_spec_periodogram_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_periodogram_cursor_add(a : SignalspecperiodogramCursor, b : SignalspecperiodogramCursor) -> SignalspecperiodogramCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_periodogram_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_periodogram_cursor_copy(s : SignalspecperiodogramCursor) -> SignalspecperiodogramCursor {
  let result = signal_spec_periodogram_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_periodogram_cursor_fill(s : SignalspecperiodogramCursor, v : Double) -> SignalspecperiodogramCursor {
  let result = signal_spec_periodogram_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_cursor_min(s : SignalspecperiodogramCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_cursor_max(s : SignalspecperiodogramCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_cursor_to_string(s : SignalspecperiodogramCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_view_make(size : Int) -> SignalspecperiodogramView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_view_len(s : SignalspecperiodogramView) -> Int { s.size }

pub fn signal_spec_periodogram_view_get(s : SignalspecperiodogramView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_view_set(s : SignalspecperiodogramView, i : Int, v : Double) -> SignalspecperiodogramView {
  let result = signal_spec_periodogram_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_view_sum(s : SignalspecperiodogramView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_periodogram_view_mean(s : SignalspecperiodogramView) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_periodogram_view_sum(s) / s.size.to_double() }
}

pub fn signal_spec_periodogram_view_scale(s : SignalspecperiodogramView, f : Double) -> SignalspecperiodogramView {
  let result = signal_spec_periodogram_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_periodogram_view_add(a : SignalspecperiodogramView, b : SignalspecperiodogramView) -> SignalspecperiodogramView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_periodogram_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_periodogram_view_copy(s : SignalspecperiodogramView) -> SignalspecperiodogramView {
  let result = signal_spec_periodogram_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_periodogram_view_fill(s : SignalspecperiodogramView, v : Double) -> SignalspecperiodogramView {
  let result = signal_spec_periodogram_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_view_min(s : SignalspecperiodogramView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_view_max(s : SignalspecperiodogramView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_view_to_string(s : SignalspecperiodogramView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_range_make(size : Int) -> SignalspecperiodogramRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_range_len(s : SignalspecperiodogramRange) -> Int { s.size }

pub fn signal_spec_periodogram_range_get(s : SignalspecperiodogramRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_range_set(s : SignalspecperiodogramRange, i : Int, v : Double) -> SignalspecperiodogramRange {
  let result = signal_spec_periodogram_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_range_sum(s : SignalspecperiodogramRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_periodogram_range_mean(s : SignalspecperiodogramRange) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_periodogram_range_sum(s) / s.size.to_double() }
}

pub fn signal_spec_periodogram_range_scale(s : SignalspecperiodogramRange, f : Double) -> SignalspecperiodogramRange {
  let result = signal_spec_periodogram_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_periodogram_range_add(a : SignalspecperiodogramRange, b : SignalspecperiodogramRange) -> SignalspecperiodogramRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_periodogram_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_periodogram_range_copy(s : SignalspecperiodogramRange) -> SignalspecperiodogramRange {
  let result = signal_spec_periodogram_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_periodogram_range_fill(s : SignalspecperiodogramRange, v : Double) -> SignalspecperiodogramRange {
  let result = signal_spec_periodogram_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_range_min(s : SignalspecperiodogramRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_range_max(s : SignalspecperiodogramRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_range_to_string(s : SignalspecperiodogramRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_slice_make(size : Int) -> SignalspecperiodogramSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_slice_len(s : SignalspecperiodogramSlice) -> Int { s.size }

pub fn signal_spec_periodogram_slice_get(s : SignalspecperiodogramSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_slice_set(s : SignalspecperiodogramSlice, i : Int, v : Double) -> SignalspecperiodogramSlice {
  let result = signal_spec_periodogram_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_slice_sum(s : SignalspecperiodogramSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_periodogram_slice_mean(s : SignalspecperiodogramSlice) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_periodogram_slice_sum(s) / s.size.to_double() }
}

pub fn signal_spec_periodogram_slice_scale(s : SignalspecperiodogramSlice, f : Double) -> SignalspecperiodogramSlice {
  let result = signal_spec_periodogram_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_periodogram_slice_add(a : SignalspecperiodogramSlice, b : SignalspecperiodogramSlice) -> SignalspecperiodogramSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_periodogram_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_periodogram_slice_copy(s : SignalspecperiodogramSlice) -> SignalspecperiodogramSlice {
  let result = signal_spec_periodogram_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_periodogram_slice_fill(s : SignalspecperiodogramSlice, v : Double) -> SignalspecperiodogramSlice {
  let result = signal_spec_periodogram_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_periodogram_slice_min(s : SignalspecperiodogramSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_slice_max(s : SignalspecperiodogramSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_periodogram_slice_to_string(s : SignalspecperiodogramSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

