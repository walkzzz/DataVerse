///===
/// extcore/signal_window_planck

pub(all) struct SignalwindowplanckPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_planck_make_point(x : Double, y : Double) -> SignalwindowplanckPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_planck_make_point3(x : Double, y : Double, z : Double) -> SignalwindowplanckPoint {
  { x, y, z, label: 0 }
}

pub fn signal_window_planck_point_x(pt : SignalwindowplanckPoint) -> Double { pt.x }

pub fn signal_window_planck_point_y(pt : SignalwindowplanckPoint) -> Double { pt.y }

pub fn signal_window_planck_point_z(pt : SignalwindowplanckPoint) -> Double { pt.z }

pub fn signal_window_planck_point_label(pt : SignalwindowplanckPoint) -> Int { pt.label }

pub fn signal_window_planck_point_dist(a : SignalwindowplanckPoint, b : SignalwindowplanckPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_window_planck_point_add(a : SignalwindowplanckPoint, b : SignalwindowplanckPoint) -> SignalwindowplanckPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_window_planck_point_sub(a : SignalwindowplanckPoint, b : SignalwindowplanckPoint) -> SignalwindowplanckPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_window_planck_point_scale(pt : SignalwindowplanckPoint, s : Double) -> SignalwindowplanckPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_window_planck_point_dot(a : SignalwindowplanckPoint, b : SignalwindowplanckPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_window_planck_point_cross(a : SignalwindowplanckPoint, b : SignalwindowplanckPoint) -> SignalwindowplanckPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_window_planck_point_norm(pt : SignalwindowplanckPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_window_planck_point_normalize(pt : SignalwindowplanckPoint) -> SignalwindowplanckPoint {
  let n = signal_window_planck_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_window_planck_point_scale(pt, 1.0 / n) }
}

pub fn signal_window_planck_point_negate(pt : SignalwindowplanckPoint) -> SignalwindowplanckPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_window_planck_point_mid(a : SignalwindowplanckPoint, b : SignalwindowplanckPoint) -> SignalwindowplanckPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_window_planck_point_lerp(a : SignalwindowplanckPoint, b : SignalwindowplanckPoint, t : Double) -> SignalwindowplanckPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_window_planck_point_to_string(pt : SignalwindowplanckPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalwindowplanckSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_planck_make_series(vals : Array[Double], name : String) -> SignalwindowplanckSeries {
  { vals, name, meta: 0 }
}

pub fn signal_window_planck_series_len(s : SignalwindowplanckSeries) -> Int { s.vals.length() }

pub fn signal_window_planck_series_sum(s : SignalwindowplanckSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn signal_window_planck_series_mean(s : SignalwindowplanckSeries) -> Double {
  let n = signal_window_planck_series_len(s)
  if n == 0 { 0.0 } else { signal_window_planck_series_sum(s) / n.to_double() }
}

pub fn signal_window_planck_series_min(s : SignalwindowplanckSeries) -> Double {
  let n = signal_window_planck_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn signal_window_planck_series_max(s : SignalwindowplanckSeries) -> Double {
  let n = signal_window_planck_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn signal_window_planck_series_range(s : SignalwindowplanckSeries) -> Double {
  signal_window_planck_series_max(s) - signal_window_planck_series_min(s)
}

pub fn signal_window_planck_series_var(s : SignalwindowplanckSeries) -> Double {
  let n = signal_window_planck_series_len(s)
  if n == 0 { 0.0 } else {
    let m = signal_window_planck_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn signal_window_planck_series_std(s : SignalwindowplanckSeries) -> Double { @_common.sqrt(signal_window_planck_series_var(s)) }

pub fn signal_window_planck_series_median(s : SignalwindowplanckSeries) -> Double {
  let n = signal_window_planck_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = signal_window_planck_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_window_planck_series_scale(s : SignalwindowplanckSeries, f : Double) -> SignalwindowplanckSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_window_planck_series_add(a : SignalwindowplanckSeries, b : SignalwindowplanckSeries) -> SignalwindowplanckSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_window_planck_series_sub(a : SignalwindowplanckSeries, b : SignalwindowplanckSeries) -> SignalwindowplanckSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_window_planck_series_normalize(s : SignalwindowplanckSeries) -> SignalwindowplanckSeries {
  let mn = signal_window_planck_series_min(s)
  let mx = signal_window_planck_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_window_planck_series_cumsum(s : SignalwindowplanckSeries) -> SignalwindowplanckSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_window_planck_series_to_string(s : SignalwindowplanckSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowplanckMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_planck_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowplanckMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_window_planck_matrix_identity(n : Int) -> SignalwindowplanckMatrix {
  let m = signal_window_planck_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_window_planck_matrix_get(m : SignalwindowplanckMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_window_planck_matrix_transpose(m : SignalwindowplanckMatrix) -> SignalwindowplanckMatrix {
  let result = signal_window_planck_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_window_planck_matrix_add(a : SignalwindowplanckMatrix, b : SignalwindowplanckMatrix) -> SignalwindowplanckMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_window_planck_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_window_planck_matrix_scale(m : SignalwindowplanckMatrix, s : Double) -> SignalwindowplanckMatrix {
  let result = signal_window_planck_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_window_planck_matrix_multiply(a : SignalwindowplanckMatrix, b : SignalwindowplanckMatrix) -> SignalwindowplanckMatrix {
  if a.cols != b.rows { return signal_window_planck_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_window_planck_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_window_planck_matrix_trace(m : SignalwindowplanckMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_window_planck_matrix_det(m : SignalwindowplanckMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_window_planck_matrix_norm(m : SignalwindowplanckMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_window_planck_matrix_to_string(m : SignalwindowplanckMatrix) -> String {
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

pub(all) struct SignalwindowplanckVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_planck_make_vector(comps : Array[Double]) -> SignalwindowplanckVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_planck_vector_zero(dim : Int) -> SignalwindowplanckVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_window_planck_vector_add(a : SignalwindowplanckVector, b : SignalwindowplanckVector) -> SignalwindowplanckVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_window_planck_vector_sub(a : SignalwindowplanckVector, b : SignalwindowplanckVector) -> SignalwindowplanckVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_window_planck_vector_scale(v : SignalwindowplanckVector, s : Double) -> SignalwindowplanckVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_window_planck_vector_dot(a : SignalwindowplanckVector, b : SignalwindowplanckVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_window_planck_vector_norm(v : SignalwindowplanckVector) -> Double { @_common.sqrt(signal_window_planck_vector_dot(v, v)) }

pub fn signal_window_planck_vector_normalize(v : SignalwindowplanckVector) -> SignalwindowplanckVector {
  let n = signal_window_planck_vector_norm(v)
  if n < 0.0000001 { v } else { signal_window_planck_vector_scale(v, 1.0 / n) }
}

pub fn signal_window_planck_vector_dist(a : SignalwindowplanckVector, b : SignalwindowplanckVector) -> Double {
  signal_window_planck_vector_norm(signal_window_planck_vector_sub(a, b))
}

pub fn signal_window_planck_vector_to_string(v : SignalwindowplanckVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_window_planck_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_window_planck_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_window_planck_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_window_planck_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_window_planck_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_window_planck_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_window_planck_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_window_planck_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_window_planck_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_window_planck_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_window_planck_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_window_planck_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_window_planck_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_window_planck_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_window_planck_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_window_planck_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_window_planck_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_window_planck_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_window_planck_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_window_planck_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_window_planck_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_window_planck_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_window_planck_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_window_planck_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_window_planck_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_window_planck_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_window_planck_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_window_planck_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_window_planck_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalwindowplanckFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_frame_make(size : Int) -> SignalwindowplanckFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_frame_len(s : SignalwindowplanckFrame) -> Int { s.size }

pub fn signal_window_planck_frame_get(s : SignalwindowplanckFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_frame_set(s : SignalwindowplanckFrame, i : Int, v : Double) -> SignalwindowplanckFrame {
  let result = signal_window_planck_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_frame_sum(s : SignalwindowplanckFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_planck_frame_mean(s : SignalwindowplanckFrame) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_planck_frame_sum(s) / s.size.to_double() }
}

pub fn signal_window_planck_frame_scale(s : SignalwindowplanckFrame, f : Double) -> SignalwindowplanckFrame {
  let result = signal_window_planck_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_planck_frame_add(a : SignalwindowplanckFrame, b : SignalwindowplanckFrame) -> SignalwindowplanckFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_planck_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_planck_frame_copy(s : SignalwindowplanckFrame) -> SignalwindowplanckFrame {
  let result = signal_window_planck_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_planck_frame_fill(s : SignalwindowplanckFrame, v : Double) -> SignalwindowplanckFrame {
  let result = signal_window_planck_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_frame_min(s : SignalwindowplanckFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_frame_max(s : SignalwindowplanckFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_frame_to_string(s : SignalwindowplanckFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_table_make(size : Int) -> SignalwindowplanckTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_table_len(s : SignalwindowplanckTable) -> Int { s.size }

pub fn signal_window_planck_table_get(s : SignalwindowplanckTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_table_set(s : SignalwindowplanckTable, i : Int, v : Double) -> SignalwindowplanckTable {
  let result = signal_window_planck_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_table_sum(s : SignalwindowplanckTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_planck_table_mean(s : SignalwindowplanckTable) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_planck_table_sum(s) / s.size.to_double() }
}

pub fn signal_window_planck_table_scale(s : SignalwindowplanckTable, f : Double) -> SignalwindowplanckTable {
  let result = signal_window_planck_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_planck_table_add(a : SignalwindowplanckTable, b : SignalwindowplanckTable) -> SignalwindowplanckTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_planck_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_planck_table_copy(s : SignalwindowplanckTable) -> SignalwindowplanckTable {
  let result = signal_window_planck_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_planck_table_fill(s : SignalwindowplanckTable, v : Double) -> SignalwindowplanckTable {
  let result = signal_window_planck_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_table_min(s : SignalwindowplanckTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_table_max(s : SignalwindowplanckTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_table_to_string(s : SignalwindowplanckTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_graphn_make(size : Int) -> SignalwindowplanckGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_graphn_len(s : SignalwindowplanckGraphN) -> Int { s.size }

pub fn signal_window_planck_graphn_get(s : SignalwindowplanckGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_graphn_set(s : SignalwindowplanckGraphN, i : Int, v : Double) -> SignalwindowplanckGraphN {
  let result = signal_window_planck_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_graphn_sum(s : SignalwindowplanckGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_planck_graphn_mean(s : SignalwindowplanckGraphN) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_planck_graphn_sum(s) / s.size.to_double() }
}

pub fn signal_window_planck_graphn_scale(s : SignalwindowplanckGraphN, f : Double) -> SignalwindowplanckGraphN {
  let result = signal_window_planck_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_planck_graphn_add(a : SignalwindowplanckGraphN, b : SignalwindowplanckGraphN) -> SignalwindowplanckGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_planck_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_planck_graphn_copy(s : SignalwindowplanckGraphN) -> SignalwindowplanckGraphN {
  let result = signal_window_planck_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_planck_graphn_fill(s : SignalwindowplanckGraphN, v : Double) -> SignalwindowplanckGraphN {
  let result = signal_window_planck_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_graphn_min(s : SignalwindowplanckGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_graphn_max(s : SignalwindowplanckGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_graphn_to_string(s : SignalwindowplanckGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_node_make(size : Int) -> SignalwindowplanckNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_node_len(s : SignalwindowplanckNode) -> Int { s.size }

pub fn signal_window_planck_node_get(s : SignalwindowplanckNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_node_set(s : SignalwindowplanckNode, i : Int, v : Double) -> SignalwindowplanckNode {
  let result = signal_window_planck_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_node_sum(s : SignalwindowplanckNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_planck_node_mean(s : SignalwindowplanckNode) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_planck_node_sum(s) / s.size.to_double() }
}

pub fn signal_window_planck_node_scale(s : SignalwindowplanckNode, f : Double) -> SignalwindowplanckNode {
  let result = signal_window_planck_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_planck_node_add(a : SignalwindowplanckNode, b : SignalwindowplanckNode) -> SignalwindowplanckNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_planck_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_planck_node_copy(s : SignalwindowplanckNode) -> SignalwindowplanckNode {
  let result = signal_window_planck_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_planck_node_fill(s : SignalwindowplanckNode, v : Double) -> SignalwindowplanckNode {
  let result = signal_window_planck_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_node_min(s : SignalwindowplanckNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_node_max(s : SignalwindowplanckNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_node_to_string(s : SignalwindowplanckNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_edge_make(size : Int) -> SignalwindowplanckEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_edge_len(s : SignalwindowplanckEdge) -> Int { s.size }

pub fn signal_window_planck_edge_get(s : SignalwindowplanckEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_edge_set(s : SignalwindowplanckEdge, i : Int, v : Double) -> SignalwindowplanckEdge {
  let result = signal_window_planck_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_edge_sum(s : SignalwindowplanckEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_planck_edge_mean(s : SignalwindowplanckEdge) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_planck_edge_sum(s) / s.size.to_double() }
}

pub fn signal_window_planck_edge_scale(s : SignalwindowplanckEdge, f : Double) -> SignalwindowplanckEdge {
  let result = signal_window_planck_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_planck_edge_add(a : SignalwindowplanckEdge, b : SignalwindowplanckEdge) -> SignalwindowplanckEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_planck_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_planck_edge_copy(s : SignalwindowplanckEdge) -> SignalwindowplanckEdge {
  let result = signal_window_planck_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_planck_edge_fill(s : SignalwindowplanckEdge, v : Double) -> SignalwindowplanckEdge {
  let result = signal_window_planck_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_edge_min(s : SignalwindowplanckEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_edge_max(s : SignalwindowplanckEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_edge_to_string(s : SignalwindowplanckEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_path_make(size : Int) -> SignalwindowplanckPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_path_len(s : SignalwindowplanckPath) -> Int { s.size }

pub fn signal_window_planck_path_get(s : SignalwindowplanckPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_path_set(s : SignalwindowplanckPath, i : Int, v : Double) -> SignalwindowplanckPath {
  let result = signal_window_planck_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_path_sum(s : SignalwindowplanckPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_planck_path_mean(s : SignalwindowplanckPath) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_planck_path_sum(s) / s.size.to_double() }
}

pub fn signal_window_planck_path_scale(s : SignalwindowplanckPath, f : Double) -> SignalwindowplanckPath {
  let result = signal_window_planck_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_planck_path_add(a : SignalwindowplanckPath, b : SignalwindowplanckPath) -> SignalwindowplanckPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_planck_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_planck_path_copy(s : SignalwindowplanckPath) -> SignalwindowplanckPath {
  let result = signal_window_planck_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_planck_path_fill(s : SignalwindowplanckPath, v : Double) -> SignalwindowplanckPath {
  let result = signal_window_planck_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_path_min(s : SignalwindowplanckPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_path_max(s : SignalwindowplanckPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_path_to_string(s : SignalwindowplanckPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_cluster_make(size : Int) -> SignalwindowplanckCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_cluster_len(s : SignalwindowplanckCluster) -> Int { s.size }

pub fn signal_window_planck_cluster_get(s : SignalwindowplanckCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_cluster_set(s : SignalwindowplanckCluster, i : Int, v : Double) -> SignalwindowplanckCluster {
  let result = signal_window_planck_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_cluster_sum(s : SignalwindowplanckCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_planck_cluster_mean(s : SignalwindowplanckCluster) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_planck_cluster_sum(s) / s.size.to_double() }
}

pub fn signal_window_planck_cluster_scale(s : SignalwindowplanckCluster, f : Double) -> SignalwindowplanckCluster {
  let result = signal_window_planck_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_planck_cluster_add(a : SignalwindowplanckCluster, b : SignalwindowplanckCluster) -> SignalwindowplanckCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_planck_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_planck_cluster_copy(s : SignalwindowplanckCluster) -> SignalwindowplanckCluster {
  let result = signal_window_planck_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_planck_cluster_fill(s : SignalwindowplanckCluster, v : Double) -> SignalwindowplanckCluster {
  let result = signal_window_planck_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_cluster_min(s : SignalwindowplanckCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_cluster_max(s : SignalwindowplanckCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_cluster_to_string(s : SignalwindowplanckCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_model_make(size : Int) -> SignalwindowplanckModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_model_len(s : SignalwindowplanckModel) -> Int { s.size }

pub fn signal_window_planck_model_get(s : SignalwindowplanckModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_model_set(s : SignalwindowplanckModel, i : Int, v : Double) -> SignalwindowplanckModel {
  let result = signal_window_planck_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_model_sum(s : SignalwindowplanckModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_planck_model_mean(s : SignalwindowplanckModel) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_planck_model_sum(s) / s.size.to_double() }
}

pub fn signal_window_planck_model_scale(s : SignalwindowplanckModel, f : Double) -> SignalwindowplanckModel {
  let result = signal_window_planck_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_planck_model_add(a : SignalwindowplanckModel, b : SignalwindowplanckModel) -> SignalwindowplanckModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_planck_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_planck_model_copy(s : SignalwindowplanckModel) -> SignalwindowplanckModel {
  let result = signal_window_planck_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_planck_model_fill(s : SignalwindowplanckModel, v : Double) -> SignalwindowplanckModel {
  let result = signal_window_planck_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_model_min(s : SignalwindowplanckModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_model_max(s : SignalwindowplanckModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_model_to_string(s : SignalwindowplanckModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_layer_make(size : Int) -> SignalwindowplanckLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_layer_len(s : SignalwindowplanckLayer) -> Int { s.size }

pub fn signal_window_planck_layer_get(s : SignalwindowplanckLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_layer_set(s : SignalwindowplanckLayer, i : Int, v : Double) -> SignalwindowplanckLayer {
  let result = signal_window_planck_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_layer_sum(s : SignalwindowplanckLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_planck_layer_mean(s : SignalwindowplanckLayer) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_planck_layer_sum(s) / s.size.to_double() }
}

pub fn signal_window_planck_layer_scale(s : SignalwindowplanckLayer, f : Double) -> SignalwindowplanckLayer {
  let result = signal_window_planck_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_planck_layer_add(a : SignalwindowplanckLayer, b : SignalwindowplanckLayer) -> SignalwindowplanckLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_planck_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_planck_layer_copy(s : SignalwindowplanckLayer) -> SignalwindowplanckLayer {
  let result = signal_window_planck_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_planck_layer_fill(s : SignalwindowplanckLayer, v : Double) -> SignalwindowplanckLayer {
  let result = signal_window_planck_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_layer_min(s : SignalwindowplanckLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_layer_max(s : SignalwindowplanckLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_layer_to_string(s : SignalwindowplanckLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_buffer_make(size : Int) -> SignalwindowplanckBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_buffer_len(s : SignalwindowplanckBuffer) -> Int { s.size }

pub fn signal_window_planck_buffer_get(s : SignalwindowplanckBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_buffer_set(s : SignalwindowplanckBuffer, i : Int, v : Double) -> SignalwindowplanckBuffer {
  let result = signal_window_planck_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_buffer_sum(s : SignalwindowplanckBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_planck_buffer_mean(s : SignalwindowplanckBuffer) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_planck_buffer_sum(s) / s.size.to_double() }
}

pub fn signal_window_planck_buffer_scale(s : SignalwindowplanckBuffer, f : Double) -> SignalwindowplanckBuffer {
  let result = signal_window_planck_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_planck_buffer_add(a : SignalwindowplanckBuffer, b : SignalwindowplanckBuffer) -> SignalwindowplanckBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_planck_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_planck_buffer_copy(s : SignalwindowplanckBuffer) -> SignalwindowplanckBuffer {
  let result = signal_window_planck_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_planck_buffer_fill(s : SignalwindowplanckBuffer, v : Double) -> SignalwindowplanckBuffer {
  let result = signal_window_planck_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_buffer_min(s : SignalwindowplanckBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_buffer_max(s : SignalwindowplanckBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_buffer_to_string(s : SignalwindowplanckBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_cursor_make(size : Int) -> SignalwindowplanckCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_cursor_len(s : SignalwindowplanckCursor) -> Int { s.size }

pub fn signal_window_planck_cursor_get(s : SignalwindowplanckCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_cursor_set(s : SignalwindowplanckCursor, i : Int, v : Double) -> SignalwindowplanckCursor {
  let result = signal_window_planck_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_cursor_sum(s : SignalwindowplanckCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_planck_cursor_mean(s : SignalwindowplanckCursor) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_planck_cursor_sum(s) / s.size.to_double() }
}

pub fn signal_window_planck_cursor_scale(s : SignalwindowplanckCursor, f : Double) -> SignalwindowplanckCursor {
  let result = signal_window_planck_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_planck_cursor_add(a : SignalwindowplanckCursor, b : SignalwindowplanckCursor) -> SignalwindowplanckCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_planck_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_planck_cursor_copy(s : SignalwindowplanckCursor) -> SignalwindowplanckCursor {
  let result = signal_window_planck_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_planck_cursor_fill(s : SignalwindowplanckCursor, v : Double) -> SignalwindowplanckCursor {
  let result = signal_window_planck_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_cursor_min(s : SignalwindowplanckCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_cursor_max(s : SignalwindowplanckCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_cursor_to_string(s : SignalwindowplanckCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_view_make(size : Int) -> SignalwindowplanckView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_view_len(s : SignalwindowplanckView) -> Int { s.size }

pub fn signal_window_planck_view_get(s : SignalwindowplanckView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_view_set(s : SignalwindowplanckView, i : Int, v : Double) -> SignalwindowplanckView {
  let result = signal_window_planck_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_view_sum(s : SignalwindowplanckView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_planck_view_mean(s : SignalwindowplanckView) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_planck_view_sum(s) / s.size.to_double() }
}

pub fn signal_window_planck_view_scale(s : SignalwindowplanckView, f : Double) -> SignalwindowplanckView {
  let result = signal_window_planck_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_planck_view_add(a : SignalwindowplanckView, b : SignalwindowplanckView) -> SignalwindowplanckView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_planck_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_planck_view_copy(s : SignalwindowplanckView) -> SignalwindowplanckView {
  let result = signal_window_planck_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_planck_view_fill(s : SignalwindowplanckView, v : Double) -> SignalwindowplanckView {
  let result = signal_window_planck_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_view_min(s : SignalwindowplanckView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_view_max(s : SignalwindowplanckView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_view_to_string(s : SignalwindowplanckView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_range_make(size : Int) -> SignalwindowplanckRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_range_len(s : SignalwindowplanckRange) -> Int { s.size }

pub fn signal_window_planck_range_get(s : SignalwindowplanckRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_range_set(s : SignalwindowplanckRange, i : Int, v : Double) -> SignalwindowplanckRange {
  let result = signal_window_planck_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_range_sum(s : SignalwindowplanckRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_planck_range_mean(s : SignalwindowplanckRange) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_planck_range_sum(s) / s.size.to_double() }
}

pub fn signal_window_planck_range_scale(s : SignalwindowplanckRange, f : Double) -> SignalwindowplanckRange {
  let result = signal_window_planck_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_planck_range_add(a : SignalwindowplanckRange, b : SignalwindowplanckRange) -> SignalwindowplanckRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_planck_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_planck_range_copy(s : SignalwindowplanckRange) -> SignalwindowplanckRange {
  let result = signal_window_planck_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_planck_range_fill(s : SignalwindowplanckRange, v : Double) -> SignalwindowplanckRange {
  let result = signal_window_planck_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_range_min(s : SignalwindowplanckRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_range_max(s : SignalwindowplanckRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_range_to_string(s : SignalwindowplanckRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_slice_make(size : Int) -> SignalwindowplanckSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_slice_len(s : SignalwindowplanckSlice) -> Int { s.size }

pub fn signal_window_planck_slice_get(s : SignalwindowplanckSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_slice_set(s : SignalwindowplanckSlice, i : Int, v : Double) -> SignalwindowplanckSlice {
  let result = signal_window_planck_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_slice_sum(s : SignalwindowplanckSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_planck_slice_mean(s : SignalwindowplanckSlice) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_planck_slice_sum(s) / s.size.to_double() }
}

pub fn signal_window_planck_slice_scale(s : SignalwindowplanckSlice, f : Double) -> SignalwindowplanckSlice {
  let result = signal_window_planck_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_planck_slice_add(a : SignalwindowplanckSlice, b : SignalwindowplanckSlice) -> SignalwindowplanckSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_planck_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_planck_slice_copy(s : SignalwindowplanckSlice) -> SignalwindowplanckSlice {
  let result = signal_window_planck_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_planck_slice_fill(s : SignalwindowplanckSlice, v : Double) -> SignalwindowplanckSlice {
  let result = signal_window_planck_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_planck_slice_min(s : SignalwindowplanckSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_slice_max(s : SignalwindowplanckSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_planck_slice_to_string(s : SignalwindowplanckSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

