///===
/// extcore/signal_transform_dwt

pub(all) struct SignaltransformdwtPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_dwt_make_point(x : Double, y : Double) -> SignaltransformdwtPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_dwt_make_point3(x : Double, y : Double, z : Double) -> SignaltransformdwtPoint {
  { x, y, z, label: 0 }
}

pub fn signal_transform_dwt_point_x(pt : SignaltransformdwtPoint) -> Double { pt.x }

pub fn signal_transform_dwt_point_y(pt : SignaltransformdwtPoint) -> Double { pt.y }

pub fn signal_transform_dwt_point_z(pt : SignaltransformdwtPoint) -> Double { pt.z }

pub fn signal_transform_dwt_point_label(pt : SignaltransformdwtPoint) -> Int { pt.label }

pub fn signal_transform_dwt_point_dist(a : SignaltransformdwtPoint, b : SignaltransformdwtPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_transform_dwt_point_add(a : SignaltransformdwtPoint, b : SignaltransformdwtPoint) -> SignaltransformdwtPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_transform_dwt_point_sub(a : SignaltransformdwtPoint, b : SignaltransformdwtPoint) -> SignaltransformdwtPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_transform_dwt_point_scale(pt : SignaltransformdwtPoint, s : Double) -> SignaltransformdwtPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_transform_dwt_point_dot(a : SignaltransformdwtPoint, b : SignaltransformdwtPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_transform_dwt_point_cross(a : SignaltransformdwtPoint, b : SignaltransformdwtPoint) -> SignaltransformdwtPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_transform_dwt_point_norm(pt : SignaltransformdwtPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_transform_dwt_point_normalize(pt : SignaltransformdwtPoint) -> SignaltransformdwtPoint {
  let n = signal_transform_dwt_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_transform_dwt_point_scale(pt, 1.0 / n) }
}

pub fn signal_transform_dwt_point_negate(pt : SignaltransformdwtPoint) -> SignaltransformdwtPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_transform_dwt_point_mid(a : SignaltransformdwtPoint, b : SignaltransformdwtPoint) -> SignaltransformdwtPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_transform_dwt_point_lerp(a : SignaltransformdwtPoint, b : SignaltransformdwtPoint, t : Double) -> SignaltransformdwtPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_transform_dwt_point_to_string(pt : SignaltransformdwtPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignaltransformdwtSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_dwt_make_series(vals : Array[Double], name : String) -> SignaltransformdwtSeries {
  { vals, name, meta: 0 }
}

pub fn signal_transform_dwt_series_len(s : SignaltransformdwtSeries) -> Int { s.vals.length() }

pub fn signal_transform_dwt_series_sum(s : SignaltransformdwtSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn signal_transform_dwt_series_mean(s : SignaltransformdwtSeries) -> Double {
  let n = signal_transform_dwt_series_len(s)
  if n == 0 { 0.0 } else { signal_transform_dwt_series_sum(s) / n.to_double() }
}

pub fn signal_transform_dwt_series_min(s : SignaltransformdwtSeries) -> Double {
  let n = signal_transform_dwt_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn signal_transform_dwt_series_max(s : SignaltransformdwtSeries) -> Double {
  let n = signal_transform_dwt_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn signal_transform_dwt_series_range(s : SignaltransformdwtSeries) -> Double {
  signal_transform_dwt_series_max(s) - signal_transform_dwt_series_min(s)
}

pub fn signal_transform_dwt_series_var(s : SignaltransformdwtSeries) -> Double {
  let n = signal_transform_dwt_series_len(s)
  if n == 0 { 0.0 } else {
    let m = signal_transform_dwt_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn signal_transform_dwt_series_std(s : SignaltransformdwtSeries) -> Double { @_common.sqrt(signal_transform_dwt_series_var(s)) }

pub fn signal_transform_dwt_series_median(s : SignaltransformdwtSeries) -> Double {
  let n = signal_transform_dwt_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = signal_transform_dwt_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_transform_dwt_series_scale(s : SignaltransformdwtSeries, f : Double) -> SignaltransformdwtSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_transform_dwt_series_add(a : SignaltransformdwtSeries, b : SignaltransformdwtSeries) -> SignaltransformdwtSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_transform_dwt_series_sub(a : SignaltransformdwtSeries, b : SignaltransformdwtSeries) -> SignaltransformdwtSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_transform_dwt_series_normalize(s : SignaltransformdwtSeries) -> SignaltransformdwtSeries {
  let mn = signal_transform_dwt_series_min(s)
  let mx = signal_transform_dwt_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_transform_dwt_series_cumsum(s : SignaltransformdwtSeries) -> SignaltransformdwtSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_transform_dwt_series_to_string(s : SignaltransformdwtSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformdwtMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_dwt_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformdwtMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_dwt_matrix_identity(n : Int) -> SignaltransformdwtMatrix {
  let m = signal_transform_dwt_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_transform_dwt_matrix_get(m : SignaltransformdwtMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_transform_dwt_matrix_transpose(m : SignaltransformdwtMatrix) -> SignaltransformdwtMatrix {
  let result = signal_transform_dwt_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_transform_dwt_matrix_add(a : SignaltransformdwtMatrix, b : SignaltransformdwtMatrix) -> SignaltransformdwtMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_transform_dwt_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_transform_dwt_matrix_scale(m : SignaltransformdwtMatrix, s : Double) -> SignaltransformdwtMatrix {
  let result = signal_transform_dwt_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_transform_dwt_matrix_multiply(a : SignaltransformdwtMatrix, b : SignaltransformdwtMatrix) -> SignaltransformdwtMatrix {
  if a.cols != b.rows { return signal_transform_dwt_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_transform_dwt_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_transform_dwt_matrix_trace(m : SignaltransformdwtMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_transform_dwt_matrix_det(m : SignaltransformdwtMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_transform_dwt_matrix_norm(m : SignaltransformdwtMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_transform_dwt_matrix_to_string(m : SignaltransformdwtMatrix) -> String {
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

pub(all) struct SignaltransformdwtVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_dwt_make_vector(comps : Array[Double]) -> SignaltransformdwtVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_dwt_vector_zero(dim : Int) -> SignaltransformdwtVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_transform_dwt_vector_add(a : SignaltransformdwtVector, b : SignaltransformdwtVector) -> SignaltransformdwtVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_transform_dwt_vector_sub(a : SignaltransformdwtVector, b : SignaltransformdwtVector) -> SignaltransformdwtVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_transform_dwt_vector_scale(v : SignaltransformdwtVector, s : Double) -> SignaltransformdwtVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_transform_dwt_vector_dot(a : SignaltransformdwtVector, b : SignaltransformdwtVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_transform_dwt_vector_norm(v : SignaltransformdwtVector) -> Double { @_common.sqrt(signal_transform_dwt_vector_dot(v, v)) }

pub fn signal_transform_dwt_vector_normalize(v : SignaltransformdwtVector) -> SignaltransformdwtVector {
  let n = signal_transform_dwt_vector_norm(v)
  if n < 0.0000001 { v } else { signal_transform_dwt_vector_scale(v, 1.0 / n) }
}

pub fn signal_transform_dwt_vector_dist(a : SignaltransformdwtVector, b : SignaltransformdwtVector) -> Double {
  signal_transform_dwt_vector_norm(signal_transform_dwt_vector_sub(a, b))
}

pub fn signal_transform_dwt_vector_to_string(v : SignaltransformdwtVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_transform_dwt_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_transform_dwt_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_transform_dwt_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_transform_dwt_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_transform_dwt_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_transform_dwt_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_transform_dwt_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_transform_dwt_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_transform_dwt_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_transform_dwt_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_transform_dwt_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_transform_dwt_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_transform_dwt_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_transform_dwt_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_transform_dwt_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_transform_dwt_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_transform_dwt_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_transform_dwt_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_transform_dwt_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_transform_dwt_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_transform_dwt_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_transform_dwt_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_transform_dwt_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_transform_dwt_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_transform_dwt_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_transform_dwt_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_transform_dwt_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_transform_dwt_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_transform_dwt_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignaltransformdwtFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_frame_make(size : Int) -> SignaltransformdwtFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_frame_len(s : SignaltransformdwtFrame) -> Int { s.size }

pub fn signal_transform_dwt_frame_get(s : SignaltransformdwtFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_frame_set(s : SignaltransformdwtFrame, i : Int, v : Double) -> SignaltransformdwtFrame {
  let result = signal_transform_dwt_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_frame_sum(s : SignaltransformdwtFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dwt_frame_mean(s : SignaltransformdwtFrame) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dwt_frame_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dwt_frame_scale(s : SignaltransformdwtFrame, f : Double) -> SignaltransformdwtFrame {
  let result = signal_transform_dwt_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dwt_frame_add(a : SignaltransformdwtFrame, b : SignaltransformdwtFrame) -> SignaltransformdwtFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dwt_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dwt_frame_copy(s : SignaltransformdwtFrame) -> SignaltransformdwtFrame {
  let result = signal_transform_dwt_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dwt_frame_fill(s : SignaltransformdwtFrame, v : Double) -> SignaltransformdwtFrame {
  let result = signal_transform_dwt_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_frame_min(s : SignaltransformdwtFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_frame_max(s : SignaltransformdwtFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_frame_to_string(s : SignaltransformdwtFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_table_make(size : Int) -> SignaltransformdwtTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_table_len(s : SignaltransformdwtTable) -> Int { s.size }

pub fn signal_transform_dwt_table_get(s : SignaltransformdwtTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_table_set(s : SignaltransformdwtTable, i : Int, v : Double) -> SignaltransformdwtTable {
  let result = signal_transform_dwt_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_table_sum(s : SignaltransformdwtTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dwt_table_mean(s : SignaltransformdwtTable) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dwt_table_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dwt_table_scale(s : SignaltransformdwtTable, f : Double) -> SignaltransformdwtTable {
  let result = signal_transform_dwt_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dwt_table_add(a : SignaltransformdwtTable, b : SignaltransformdwtTable) -> SignaltransformdwtTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dwt_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dwt_table_copy(s : SignaltransformdwtTable) -> SignaltransformdwtTable {
  let result = signal_transform_dwt_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dwt_table_fill(s : SignaltransformdwtTable, v : Double) -> SignaltransformdwtTable {
  let result = signal_transform_dwt_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_table_min(s : SignaltransformdwtTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_table_max(s : SignaltransformdwtTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_table_to_string(s : SignaltransformdwtTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_graphn_make(size : Int) -> SignaltransformdwtGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_graphn_len(s : SignaltransformdwtGraphN) -> Int { s.size }

pub fn signal_transform_dwt_graphn_get(s : SignaltransformdwtGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_graphn_set(s : SignaltransformdwtGraphN, i : Int, v : Double) -> SignaltransformdwtGraphN {
  let result = signal_transform_dwt_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_graphn_sum(s : SignaltransformdwtGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dwt_graphn_mean(s : SignaltransformdwtGraphN) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dwt_graphn_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dwt_graphn_scale(s : SignaltransformdwtGraphN, f : Double) -> SignaltransformdwtGraphN {
  let result = signal_transform_dwt_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dwt_graphn_add(a : SignaltransformdwtGraphN, b : SignaltransformdwtGraphN) -> SignaltransformdwtGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dwt_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dwt_graphn_copy(s : SignaltransformdwtGraphN) -> SignaltransformdwtGraphN {
  let result = signal_transform_dwt_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dwt_graphn_fill(s : SignaltransformdwtGraphN, v : Double) -> SignaltransformdwtGraphN {
  let result = signal_transform_dwt_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_graphn_min(s : SignaltransformdwtGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_graphn_max(s : SignaltransformdwtGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_graphn_to_string(s : SignaltransformdwtGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_node_make(size : Int) -> SignaltransformdwtNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_node_len(s : SignaltransformdwtNode) -> Int { s.size }

pub fn signal_transform_dwt_node_get(s : SignaltransformdwtNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_node_set(s : SignaltransformdwtNode, i : Int, v : Double) -> SignaltransformdwtNode {
  let result = signal_transform_dwt_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_node_sum(s : SignaltransformdwtNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dwt_node_mean(s : SignaltransformdwtNode) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dwt_node_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dwt_node_scale(s : SignaltransformdwtNode, f : Double) -> SignaltransformdwtNode {
  let result = signal_transform_dwt_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dwt_node_add(a : SignaltransformdwtNode, b : SignaltransformdwtNode) -> SignaltransformdwtNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dwt_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dwt_node_copy(s : SignaltransformdwtNode) -> SignaltransformdwtNode {
  let result = signal_transform_dwt_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dwt_node_fill(s : SignaltransformdwtNode, v : Double) -> SignaltransformdwtNode {
  let result = signal_transform_dwt_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_node_min(s : SignaltransformdwtNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_node_max(s : SignaltransformdwtNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_node_to_string(s : SignaltransformdwtNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_edge_make(size : Int) -> SignaltransformdwtEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_edge_len(s : SignaltransformdwtEdge) -> Int { s.size }

pub fn signal_transform_dwt_edge_get(s : SignaltransformdwtEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_edge_set(s : SignaltransformdwtEdge, i : Int, v : Double) -> SignaltransformdwtEdge {
  let result = signal_transform_dwt_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_edge_sum(s : SignaltransformdwtEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dwt_edge_mean(s : SignaltransformdwtEdge) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dwt_edge_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dwt_edge_scale(s : SignaltransformdwtEdge, f : Double) -> SignaltransformdwtEdge {
  let result = signal_transform_dwt_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dwt_edge_add(a : SignaltransformdwtEdge, b : SignaltransformdwtEdge) -> SignaltransformdwtEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dwt_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dwt_edge_copy(s : SignaltransformdwtEdge) -> SignaltransformdwtEdge {
  let result = signal_transform_dwt_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dwt_edge_fill(s : SignaltransformdwtEdge, v : Double) -> SignaltransformdwtEdge {
  let result = signal_transform_dwt_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_edge_min(s : SignaltransformdwtEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_edge_max(s : SignaltransformdwtEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_edge_to_string(s : SignaltransformdwtEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_path_make(size : Int) -> SignaltransformdwtPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_path_len(s : SignaltransformdwtPath) -> Int { s.size }

pub fn signal_transform_dwt_path_get(s : SignaltransformdwtPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_path_set(s : SignaltransformdwtPath, i : Int, v : Double) -> SignaltransformdwtPath {
  let result = signal_transform_dwt_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_path_sum(s : SignaltransformdwtPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dwt_path_mean(s : SignaltransformdwtPath) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dwt_path_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dwt_path_scale(s : SignaltransformdwtPath, f : Double) -> SignaltransformdwtPath {
  let result = signal_transform_dwt_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dwt_path_add(a : SignaltransformdwtPath, b : SignaltransformdwtPath) -> SignaltransformdwtPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dwt_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dwt_path_copy(s : SignaltransformdwtPath) -> SignaltransformdwtPath {
  let result = signal_transform_dwt_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dwt_path_fill(s : SignaltransformdwtPath, v : Double) -> SignaltransformdwtPath {
  let result = signal_transform_dwt_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_path_min(s : SignaltransformdwtPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_path_max(s : SignaltransformdwtPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_path_to_string(s : SignaltransformdwtPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_cluster_make(size : Int) -> SignaltransformdwtCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_cluster_len(s : SignaltransformdwtCluster) -> Int { s.size }

pub fn signal_transform_dwt_cluster_get(s : SignaltransformdwtCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_cluster_set(s : SignaltransformdwtCluster, i : Int, v : Double) -> SignaltransformdwtCluster {
  let result = signal_transform_dwt_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_cluster_sum(s : SignaltransformdwtCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dwt_cluster_mean(s : SignaltransformdwtCluster) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dwt_cluster_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dwt_cluster_scale(s : SignaltransformdwtCluster, f : Double) -> SignaltransformdwtCluster {
  let result = signal_transform_dwt_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dwt_cluster_add(a : SignaltransformdwtCluster, b : SignaltransformdwtCluster) -> SignaltransformdwtCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dwt_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dwt_cluster_copy(s : SignaltransformdwtCluster) -> SignaltransformdwtCluster {
  let result = signal_transform_dwt_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dwt_cluster_fill(s : SignaltransformdwtCluster, v : Double) -> SignaltransformdwtCluster {
  let result = signal_transform_dwt_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_cluster_min(s : SignaltransformdwtCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_cluster_max(s : SignaltransformdwtCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_cluster_to_string(s : SignaltransformdwtCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_model_make(size : Int) -> SignaltransformdwtModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_model_len(s : SignaltransformdwtModel) -> Int { s.size }

pub fn signal_transform_dwt_model_get(s : SignaltransformdwtModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_model_set(s : SignaltransformdwtModel, i : Int, v : Double) -> SignaltransformdwtModel {
  let result = signal_transform_dwt_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_model_sum(s : SignaltransformdwtModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dwt_model_mean(s : SignaltransformdwtModel) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dwt_model_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dwt_model_scale(s : SignaltransformdwtModel, f : Double) -> SignaltransformdwtModel {
  let result = signal_transform_dwt_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dwt_model_add(a : SignaltransformdwtModel, b : SignaltransformdwtModel) -> SignaltransformdwtModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dwt_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dwt_model_copy(s : SignaltransformdwtModel) -> SignaltransformdwtModel {
  let result = signal_transform_dwt_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dwt_model_fill(s : SignaltransformdwtModel, v : Double) -> SignaltransformdwtModel {
  let result = signal_transform_dwt_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_model_min(s : SignaltransformdwtModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_model_max(s : SignaltransformdwtModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_model_to_string(s : SignaltransformdwtModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_layer_make(size : Int) -> SignaltransformdwtLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_layer_len(s : SignaltransformdwtLayer) -> Int { s.size }

pub fn signal_transform_dwt_layer_get(s : SignaltransformdwtLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_layer_set(s : SignaltransformdwtLayer, i : Int, v : Double) -> SignaltransformdwtLayer {
  let result = signal_transform_dwt_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_layer_sum(s : SignaltransformdwtLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dwt_layer_mean(s : SignaltransformdwtLayer) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dwt_layer_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dwt_layer_scale(s : SignaltransformdwtLayer, f : Double) -> SignaltransformdwtLayer {
  let result = signal_transform_dwt_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dwt_layer_add(a : SignaltransformdwtLayer, b : SignaltransformdwtLayer) -> SignaltransformdwtLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dwt_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dwt_layer_copy(s : SignaltransformdwtLayer) -> SignaltransformdwtLayer {
  let result = signal_transform_dwt_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dwt_layer_fill(s : SignaltransformdwtLayer, v : Double) -> SignaltransformdwtLayer {
  let result = signal_transform_dwt_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_layer_min(s : SignaltransformdwtLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_layer_max(s : SignaltransformdwtLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_layer_to_string(s : SignaltransformdwtLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_buffer_make(size : Int) -> SignaltransformdwtBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_buffer_len(s : SignaltransformdwtBuffer) -> Int { s.size }

pub fn signal_transform_dwt_buffer_get(s : SignaltransformdwtBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_buffer_set(s : SignaltransformdwtBuffer, i : Int, v : Double) -> SignaltransformdwtBuffer {
  let result = signal_transform_dwt_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_buffer_sum(s : SignaltransformdwtBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dwt_buffer_mean(s : SignaltransformdwtBuffer) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dwt_buffer_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dwt_buffer_scale(s : SignaltransformdwtBuffer, f : Double) -> SignaltransformdwtBuffer {
  let result = signal_transform_dwt_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dwt_buffer_add(a : SignaltransformdwtBuffer, b : SignaltransformdwtBuffer) -> SignaltransformdwtBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dwt_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dwt_buffer_copy(s : SignaltransformdwtBuffer) -> SignaltransformdwtBuffer {
  let result = signal_transform_dwt_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dwt_buffer_fill(s : SignaltransformdwtBuffer, v : Double) -> SignaltransformdwtBuffer {
  let result = signal_transform_dwt_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_buffer_min(s : SignaltransformdwtBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_buffer_max(s : SignaltransformdwtBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_buffer_to_string(s : SignaltransformdwtBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_cursor_make(size : Int) -> SignaltransformdwtCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_cursor_len(s : SignaltransformdwtCursor) -> Int { s.size }

pub fn signal_transform_dwt_cursor_get(s : SignaltransformdwtCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_cursor_set(s : SignaltransformdwtCursor, i : Int, v : Double) -> SignaltransformdwtCursor {
  let result = signal_transform_dwt_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_cursor_sum(s : SignaltransformdwtCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dwt_cursor_mean(s : SignaltransformdwtCursor) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dwt_cursor_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dwt_cursor_scale(s : SignaltransformdwtCursor, f : Double) -> SignaltransformdwtCursor {
  let result = signal_transform_dwt_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dwt_cursor_add(a : SignaltransformdwtCursor, b : SignaltransformdwtCursor) -> SignaltransformdwtCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dwt_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dwt_cursor_copy(s : SignaltransformdwtCursor) -> SignaltransformdwtCursor {
  let result = signal_transform_dwt_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dwt_cursor_fill(s : SignaltransformdwtCursor, v : Double) -> SignaltransformdwtCursor {
  let result = signal_transform_dwt_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_cursor_min(s : SignaltransformdwtCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_cursor_max(s : SignaltransformdwtCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_cursor_to_string(s : SignaltransformdwtCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_view_make(size : Int) -> SignaltransformdwtView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_view_len(s : SignaltransformdwtView) -> Int { s.size }

pub fn signal_transform_dwt_view_get(s : SignaltransformdwtView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_view_set(s : SignaltransformdwtView, i : Int, v : Double) -> SignaltransformdwtView {
  let result = signal_transform_dwt_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_view_sum(s : SignaltransformdwtView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dwt_view_mean(s : SignaltransformdwtView) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dwt_view_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dwt_view_scale(s : SignaltransformdwtView, f : Double) -> SignaltransformdwtView {
  let result = signal_transform_dwt_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dwt_view_add(a : SignaltransformdwtView, b : SignaltransformdwtView) -> SignaltransformdwtView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dwt_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dwt_view_copy(s : SignaltransformdwtView) -> SignaltransformdwtView {
  let result = signal_transform_dwt_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dwt_view_fill(s : SignaltransformdwtView, v : Double) -> SignaltransformdwtView {
  let result = signal_transform_dwt_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_view_min(s : SignaltransformdwtView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_view_max(s : SignaltransformdwtView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_view_to_string(s : SignaltransformdwtView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_range_make(size : Int) -> SignaltransformdwtRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_range_len(s : SignaltransformdwtRange) -> Int { s.size }

pub fn signal_transform_dwt_range_get(s : SignaltransformdwtRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_range_set(s : SignaltransformdwtRange, i : Int, v : Double) -> SignaltransformdwtRange {
  let result = signal_transform_dwt_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_range_sum(s : SignaltransformdwtRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dwt_range_mean(s : SignaltransformdwtRange) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dwt_range_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dwt_range_scale(s : SignaltransformdwtRange, f : Double) -> SignaltransformdwtRange {
  let result = signal_transform_dwt_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dwt_range_add(a : SignaltransformdwtRange, b : SignaltransformdwtRange) -> SignaltransformdwtRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dwt_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dwt_range_copy(s : SignaltransformdwtRange) -> SignaltransformdwtRange {
  let result = signal_transform_dwt_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dwt_range_fill(s : SignaltransformdwtRange, v : Double) -> SignaltransformdwtRange {
  let result = signal_transform_dwt_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_range_min(s : SignaltransformdwtRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_range_max(s : SignaltransformdwtRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_range_to_string(s : SignaltransformdwtRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_slice_make(size : Int) -> SignaltransformdwtSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_slice_len(s : SignaltransformdwtSlice) -> Int { s.size }

pub fn signal_transform_dwt_slice_get(s : SignaltransformdwtSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_slice_set(s : SignaltransformdwtSlice, i : Int, v : Double) -> SignaltransformdwtSlice {
  let result = signal_transform_dwt_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_slice_sum(s : SignaltransformdwtSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dwt_slice_mean(s : SignaltransformdwtSlice) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dwt_slice_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dwt_slice_scale(s : SignaltransformdwtSlice, f : Double) -> SignaltransformdwtSlice {
  let result = signal_transform_dwt_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dwt_slice_add(a : SignaltransformdwtSlice, b : SignaltransformdwtSlice) -> SignaltransformdwtSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dwt_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dwt_slice_copy(s : SignaltransformdwtSlice) -> SignaltransformdwtSlice {
  let result = signal_transform_dwt_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dwt_slice_fill(s : SignaltransformdwtSlice, v : Double) -> SignaltransformdwtSlice {
  let result = signal_transform_dwt_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dwt_slice_min(s : SignaltransformdwtSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_slice_max(s : SignaltransformdwtSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dwt_slice_to_string(s : SignaltransformdwtSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

