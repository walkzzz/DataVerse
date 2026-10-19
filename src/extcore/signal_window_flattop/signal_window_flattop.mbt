///===
/// extcore/signal_window_flattop

pub(all) struct SignalwindowflattopPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_flattop_make_point(x : Double, y : Double) -> SignalwindowflattopPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_flattop_make_point3(x : Double, y : Double, z : Double) -> SignalwindowflattopPoint {
  { x, y, z, label: 0 }
}

pub fn signal_window_flattop_point_x(pt : SignalwindowflattopPoint) -> Double { pt.x }

pub fn signal_window_flattop_point_y(pt : SignalwindowflattopPoint) -> Double { pt.y }

pub fn signal_window_flattop_point_z(pt : SignalwindowflattopPoint) -> Double { pt.z }

pub fn signal_window_flattop_point_label(pt : SignalwindowflattopPoint) -> Int { pt.label }

pub fn signal_window_flattop_point_dist(a : SignalwindowflattopPoint, b : SignalwindowflattopPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_window_flattop_point_add(a : SignalwindowflattopPoint, b : SignalwindowflattopPoint) -> SignalwindowflattopPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_window_flattop_point_sub(a : SignalwindowflattopPoint, b : SignalwindowflattopPoint) -> SignalwindowflattopPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_window_flattop_point_scale(pt : SignalwindowflattopPoint, s : Double) -> SignalwindowflattopPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_window_flattop_point_dot(a : SignalwindowflattopPoint, b : SignalwindowflattopPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_window_flattop_point_cross(a : SignalwindowflattopPoint, b : SignalwindowflattopPoint) -> SignalwindowflattopPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_window_flattop_point_norm(pt : SignalwindowflattopPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_window_flattop_point_normalize(pt : SignalwindowflattopPoint) -> SignalwindowflattopPoint {
  let n = signal_window_flattop_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_window_flattop_point_scale(pt, 1.0 / n) }
}

pub fn signal_window_flattop_point_negate(pt : SignalwindowflattopPoint) -> SignalwindowflattopPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_window_flattop_point_mid(a : SignalwindowflattopPoint, b : SignalwindowflattopPoint) -> SignalwindowflattopPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_window_flattop_point_lerp(a : SignalwindowflattopPoint, b : SignalwindowflattopPoint, t : Double) -> SignalwindowflattopPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_window_flattop_point_to_string(pt : SignalwindowflattopPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalwindowflattopSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_flattop_make_series(vals : Array[Double], name : String) -> SignalwindowflattopSeries {
  { vals, name, meta: 0 }
}

pub fn signal_window_flattop_series_len(s : SignalwindowflattopSeries) -> Int { s.vals.length() }

pub fn signal_window_flattop_series_sum(s : SignalwindowflattopSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn signal_window_flattop_series_mean(s : SignalwindowflattopSeries) -> Double {
  let n = signal_window_flattop_series_len(s)
  if n == 0 { 0.0 } else { signal_window_flattop_series_sum(s) / n.to_double() }
}

pub fn signal_window_flattop_series_min(s : SignalwindowflattopSeries) -> Double {
  let n = signal_window_flattop_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn signal_window_flattop_series_max(s : SignalwindowflattopSeries) -> Double {
  let n = signal_window_flattop_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn signal_window_flattop_series_range(s : SignalwindowflattopSeries) -> Double {
  signal_window_flattop_series_max(s) - signal_window_flattop_series_min(s)
}

pub fn signal_window_flattop_series_var(s : SignalwindowflattopSeries) -> Double {
  let n = signal_window_flattop_series_len(s)
  if n == 0 { 0.0 } else {
    let m = signal_window_flattop_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn signal_window_flattop_series_std(s : SignalwindowflattopSeries) -> Double { @_common.sqrt(signal_window_flattop_series_var(s)) }

pub fn signal_window_flattop_series_median(s : SignalwindowflattopSeries) -> Double {
  let n = signal_window_flattop_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = signal_window_flattop_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_window_flattop_series_scale(s : SignalwindowflattopSeries, f : Double) -> SignalwindowflattopSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_window_flattop_series_add(a : SignalwindowflattopSeries, b : SignalwindowflattopSeries) -> SignalwindowflattopSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_window_flattop_series_sub(a : SignalwindowflattopSeries, b : SignalwindowflattopSeries) -> SignalwindowflattopSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_window_flattop_series_normalize(s : SignalwindowflattopSeries) -> SignalwindowflattopSeries {
  let mn = signal_window_flattop_series_min(s)
  let mx = signal_window_flattop_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_window_flattop_series_cumsum(s : SignalwindowflattopSeries) -> SignalwindowflattopSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_window_flattop_series_to_string(s : SignalwindowflattopSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowflattopMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_flattop_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowflattopMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_window_flattop_matrix_identity(n : Int) -> SignalwindowflattopMatrix {
  let m = signal_window_flattop_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_window_flattop_matrix_get(m : SignalwindowflattopMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_window_flattop_matrix_transpose(m : SignalwindowflattopMatrix) -> SignalwindowflattopMatrix {
  let result = signal_window_flattop_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_window_flattop_matrix_add(a : SignalwindowflattopMatrix, b : SignalwindowflattopMatrix) -> SignalwindowflattopMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_window_flattop_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_window_flattop_matrix_scale(m : SignalwindowflattopMatrix, s : Double) -> SignalwindowflattopMatrix {
  let result = signal_window_flattop_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_window_flattop_matrix_multiply(a : SignalwindowflattopMatrix, b : SignalwindowflattopMatrix) -> SignalwindowflattopMatrix {
  if a.cols != b.rows { return signal_window_flattop_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_window_flattop_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_window_flattop_matrix_trace(m : SignalwindowflattopMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_window_flattop_matrix_det(m : SignalwindowflattopMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_window_flattop_matrix_norm(m : SignalwindowflattopMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_window_flattop_matrix_to_string(m : SignalwindowflattopMatrix) -> String {
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

pub(all) struct SignalwindowflattopVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_flattop_make_vector(comps : Array[Double]) -> SignalwindowflattopVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_flattop_vector_zero(dim : Int) -> SignalwindowflattopVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_window_flattop_vector_add(a : SignalwindowflattopVector, b : SignalwindowflattopVector) -> SignalwindowflattopVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_window_flattop_vector_sub(a : SignalwindowflattopVector, b : SignalwindowflattopVector) -> SignalwindowflattopVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_window_flattop_vector_scale(v : SignalwindowflattopVector, s : Double) -> SignalwindowflattopVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_window_flattop_vector_dot(a : SignalwindowflattopVector, b : SignalwindowflattopVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_window_flattop_vector_norm(v : SignalwindowflattopVector) -> Double { @_common.sqrt(signal_window_flattop_vector_dot(v, v)) }

pub fn signal_window_flattop_vector_normalize(v : SignalwindowflattopVector) -> SignalwindowflattopVector {
  let n = signal_window_flattop_vector_norm(v)
  if n < 0.0000001 { v } else { signal_window_flattop_vector_scale(v, 1.0 / n) }
}

pub fn signal_window_flattop_vector_dist(a : SignalwindowflattopVector, b : SignalwindowflattopVector) -> Double {
  signal_window_flattop_vector_norm(signal_window_flattop_vector_sub(a, b))
}

pub fn signal_window_flattop_vector_to_string(v : SignalwindowflattopVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_window_flattop_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_window_flattop_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_window_flattop_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_window_flattop_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_window_flattop_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_window_flattop_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_window_flattop_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_window_flattop_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_window_flattop_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_window_flattop_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_window_flattop_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_window_flattop_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_window_flattop_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_window_flattop_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_window_flattop_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_window_flattop_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_window_flattop_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_window_flattop_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_window_flattop_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_window_flattop_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_window_flattop_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_window_flattop_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_window_flattop_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_window_flattop_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_window_flattop_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_window_flattop_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_window_flattop_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_window_flattop_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_window_flattop_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalwindowflattopFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_frame_make(size : Int) -> SignalwindowflattopFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_frame_len(s : SignalwindowflattopFrame) -> Int { s.size }

pub fn signal_window_flattop_frame_get(s : SignalwindowflattopFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_frame_set(s : SignalwindowflattopFrame, i : Int, v : Double) -> SignalwindowflattopFrame {
  let result = signal_window_flattop_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_frame_sum(s : SignalwindowflattopFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_flattop_frame_mean(s : SignalwindowflattopFrame) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_flattop_frame_sum(s) / s.size.to_double() }
}

pub fn signal_window_flattop_frame_scale(s : SignalwindowflattopFrame, f : Double) -> SignalwindowflattopFrame {
  let result = signal_window_flattop_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_flattop_frame_add(a : SignalwindowflattopFrame, b : SignalwindowflattopFrame) -> SignalwindowflattopFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_flattop_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_flattop_frame_copy(s : SignalwindowflattopFrame) -> SignalwindowflattopFrame {
  let result = signal_window_flattop_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_flattop_frame_fill(s : SignalwindowflattopFrame, v : Double) -> SignalwindowflattopFrame {
  let result = signal_window_flattop_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_frame_min(s : SignalwindowflattopFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_frame_max(s : SignalwindowflattopFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_frame_to_string(s : SignalwindowflattopFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_table_make(size : Int) -> SignalwindowflattopTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_table_len(s : SignalwindowflattopTable) -> Int { s.size }

pub fn signal_window_flattop_table_get(s : SignalwindowflattopTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_table_set(s : SignalwindowflattopTable, i : Int, v : Double) -> SignalwindowflattopTable {
  let result = signal_window_flattop_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_table_sum(s : SignalwindowflattopTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_flattop_table_mean(s : SignalwindowflattopTable) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_flattop_table_sum(s) / s.size.to_double() }
}

pub fn signal_window_flattop_table_scale(s : SignalwindowflattopTable, f : Double) -> SignalwindowflattopTable {
  let result = signal_window_flattop_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_flattop_table_add(a : SignalwindowflattopTable, b : SignalwindowflattopTable) -> SignalwindowflattopTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_flattop_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_flattop_table_copy(s : SignalwindowflattopTable) -> SignalwindowflattopTable {
  let result = signal_window_flattop_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_flattop_table_fill(s : SignalwindowflattopTable, v : Double) -> SignalwindowflattopTable {
  let result = signal_window_flattop_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_table_min(s : SignalwindowflattopTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_table_max(s : SignalwindowflattopTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_table_to_string(s : SignalwindowflattopTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_graphn_make(size : Int) -> SignalwindowflattopGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_graphn_len(s : SignalwindowflattopGraphN) -> Int { s.size }

pub fn signal_window_flattop_graphn_get(s : SignalwindowflattopGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_graphn_set(s : SignalwindowflattopGraphN, i : Int, v : Double) -> SignalwindowflattopGraphN {
  let result = signal_window_flattop_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_graphn_sum(s : SignalwindowflattopGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_flattop_graphn_mean(s : SignalwindowflattopGraphN) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_flattop_graphn_sum(s) / s.size.to_double() }
}

pub fn signal_window_flattop_graphn_scale(s : SignalwindowflattopGraphN, f : Double) -> SignalwindowflattopGraphN {
  let result = signal_window_flattop_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_flattop_graphn_add(a : SignalwindowflattopGraphN, b : SignalwindowflattopGraphN) -> SignalwindowflattopGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_flattop_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_flattop_graphn_copy(s : SignalwindowflattopGraphN) -> SignalwindowflattopGraphN {
  let result = signal_window_flattop_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_flattop_graphn_fill(s : SignalwindowflattopGraphN, v : Double) -> SignalwindowflattopGraphN {
  let result = signal_window_flattop_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_graphn_min(s : SignalwindowflattopGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_graphn_max(s : SignalwindowflattopGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_graphn_to_string(s : SignalwindowflattopGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_node_make(size : Int) -> SignalwindowflattopNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_node_len(s : SignalwindowflattopNode) -> Int { s.size }

pub fn signal_window_flattop_node_get(s : SignalwindowflattopNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_node_set(s : SignalwindowflattopNode, i : Int, v : Double) -> SignalwindowflattopNode {
  let result = signal_window_flattop_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_node_sum(s : SignalwindowflattopNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_flattop_node_mean(s : SignalwindowflattopNode) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_flattop_node_sum(s) / s.size.to_double() }
}

pub fn signal_window_flattop_node_scale(s : SignalwindowflattopNode, f : Double) -> SignalwindowflattopNode {
  let result = signal_window_flattop_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_flattop_node_add(a : SignalwindowflattopNode, b : SignalwindowflattopNode) -> SignalwindowflattopNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_flattop_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_flattop_node_copy(s : SignalwindowflattopNode) -> SignalwindowflattopNode {
  let result = signal_window_flattop_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_flattop_node_fill(s : SignalwindowflattopNode, v : Double) -> SignalwindowflattopNode {
  let result = signal_window_flattop_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_node_min(s : SignalwindowflattopNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_node_max(s : SignalwindowflattopNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_node_to_string(s : SignalwindowflattopNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_edge_make(size : Int) -> SignalwindowflattopEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_edge_len(s : SignalwindowflattopEdge) -> Int { s.size }

pub fn signal_window_flattop_edge_get(s : SignalwindowflattopEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_edge_set(s : SignalwindowflattopEdge, i : Int, v : Double) -> SignalwindowflattopEdge {
  let result = signal_window_flattop_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_edge_sum(s : SignalwindowflattopEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_flattop_edge_mean(s : SignalwindowflattopEdge) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_flattop_edge_sum(s) / s.size.to_double() }
}

pub fn signal_window_flattop_edge_scale(s : SignalwindowflattopEdge, f : Double) -> SignalwindowflattopEdge {
  let result = signal_window_flattop_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_flattop_edge_add(a : SignalwindowflattopEdge, b : SignalwindowflattopEdge) -> SignalwindowflattopEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_flattop_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_flattop_edge_copy(s : SignalwindowflattopEdge) -> SignalwindowflattopEdge {
  let result = signal_window_flattop_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_flattop_edge_fill(s : SignalwindowflattopEdge, v : Double) -> SignalwindowflattopEdge {
  let result = signal_window_flattop_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_edge_min(s : SignalwindowflattopEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_edge_max(s : SignalwindowflattopEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_edge_to_string(s : SignalwindowflattopEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_path_make(size : Int) -> SignalwindowflattopPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_path_len(s : SignalwindowflattopPath) -> Int { s.size }

pub fn signal_window_flattop_path_get(s : SignalwindowflattopPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_path_set(s : SignalwindowflattopPath, i : Int, v : Double) -> SignalwindowflattopPath {
  let result = signal_window_flattop_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_path_sum(s : SignalwindowflattopPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_flattop_path_mean(s : SignalwindowflattopPath) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_flattop_path_sum(s) / s.size.to_double() }
}

pub fn signal_window_flattop_path_scale(s : SignalwindowflattopPath, f : Double) -> SignalwindowflattopPath {
  let result = signal_window_flattop_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_flattop_path_add(a : SignalwindowflattopPath, b : SignalwindowflattopPath) -> SignalwindowflattopPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_flattop_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_flattop_path_copy(s : SignalwindowflattopPath) -> SignalwindowflattopPath {
  let result = signal_window_flattop_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_flattop_path_fill(s : SignalwindowflattopPath, v : Double) -> SignalwindowflattopPath {
  let result = signal_window_flattop_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_path_min(s : SignalwindowflattopPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_path_max(s : SignalwindowflattopPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_path_to_string(s : SignalwindowflattopPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_cluster_make(size : Int) -> SignalwindowflattopCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_cluster_len(s : SignalwindowflattopCluster) -> Int { s.size }

pub fn signal_window_flattop_cluster_get(s : SignalwindowflattopCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_cluster_set(s : SignalwindowflattopCluster, i : Int, v : Double) -> SignalwindowflattopCluster {
  let result = signal_window_flattop_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_cluster_sum(s : SignalwindowflattopCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_flattop_cluster_mean(s : SignalwindowflattopCluster) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_flattop_cluster_sum(s) / s.size.to_double() }
}

pub fn signal_window_flattop_cluster_scale(s : SignalwindowflattopCluster, f : Double) -> SignalwindowflattopCluster {
  let result = signal_window_flattop_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_flattop_cluster_add(a : SignalwindowflattopCluster, b : SignalwindowflattopCluster) -> SignalwindowflattopCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_flattop_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_flattop_cluster_copy(s : SignalwindowflattopCluster) -> SignalwindowflattopCluster {
  let result = signal_window_flattop_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_flattop_cluster_fill(s : SignalwindowflattopCluster, v : Double) -> SignalwindowflattopCluster {
  let result = signal_window_flattop_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_cluster_min(s : SignalwindowflattopCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_cluster_max(s : SignalwindowflattopCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_cluster_to_string(s : SignalwindowflattopCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_model_make(size : Int) -> SignalwindowflattopModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_model_len(s : SignalwindowflattopModel) -> Int { s.size }

pub fn signal_window_flattop_model_get(s : SignalwindowflattopModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_model_set(s : SignalwindowflattopModel, i : Int, v : Double) -> SignalwindowflattopModel {
  let result = signal_window_flattop_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_model_sum(s : SignalwindowflattopModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_flattop_model_mean(s : SignalwindowflattopModel) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_flattop_model_sum(s) / s.size.to_double() }
}

pub fn signal_window_flattop_model_scale(s : SignalwindowflattopModel, f : Double) -> SignalwindowflattopModel {
  let result = signal_window_flattop_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_flattop_model_add(a : SignalwindowflattopModel, b : SignalwindowflattopModel) -> SignalwindowflattopModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_flattop_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_flattop_model_copy(s : SignalwindowflattopModel) -> SignalwindowflattopModel {
  let result = signal_window_flattop_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_flattop_model_fill(s : SignalwindowflattopModel, v : Double) -> SignalwindowflattopModel {
  let result = signal_window_flattop_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_model_min(s : SignalwindowflattopModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_model_max(s : SignalwindowflattopModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_model_to_string(s : SignalwindowflattopModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_layer_make(size : Int) -> SignalwindowflattopLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_layer_len(s : SignalwindowflattopLayer) -> Int { s.size }

pub fn signal_window_flattop_layer_get(s : SignalwindowflattopLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_layer_set(s : SignalwindowflattopLayer, i : Int, v : Double) -> SignalwindowflattopLayer {
  let result = signal_window_flattop_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_layer_sum(s : SignalwindowflattopLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_flattop_layer_mean(s : SignalwindowflattopLayer) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_flattop_layer_sum(s) / s.size.to_double() }
}

pub fn signal_window_flattop_layer_scale(s : SignalwindowflattopLayer, f : Double) -> SignalwindowflattopLayer {
  let result = signal_window_flattop_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_flattop_layer_add(a : SignalwindowflattopLayer, b : SignalwindowflattopLayer) -> SignalwindowflattopLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_flattop_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_flattop_layer_copy(s : SignalwindowflattopLayer) -> SignalwindowflattopLayer {
  let result = signal_window_flattop_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_flattop_layer_fill(s : SignalwindowflattopLayer, v : Double) -> SignalwindowflattopLayer {
  let result = signal_window_flattop_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_layer_min(s : SignalwindowflattopLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_layer_max(s : SignalwindowflattopLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_layer_to_string(s : SignalwindowflattopLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_buffer_make(size : Int) -> SignalwindowflattopBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_buffer_len(s : SignalwindowflattopBuffer) -> Int { s.size }

pub fn signal_window_flattop_buffer_get(s : SignalwindowflattopBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_buffer_set(s : SignalwindowflattopBuffer, i : Int, v : Double) -> SignalwindowflattopBuffer {
  let result = signal_window_flattop_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_buffer_sum(s : SignalwindowflattopBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_flattop_buffer_mean(s : SignalwindowflattopBuffer) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_flattop_buffer_sum(s) / s.size.to_double() }
}

pub fn signal_window_flattop_buffer_scale(s : SignalwindowflattopBuffer, f : Double) -> SignalwindowflattopBuffer {
  let result = signal_window_flattop_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_flattop_buffer_add(a : SignalwindowflattopBuffer, b : SignalwindowflattopBuffer) -> SignalwindowflattopBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_flattop_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_flattop_buffer_copy(s : SignalwindowflattopBuffer) -> SignalwindowflattopBuffer {
  let result = signal_window_flattop_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_flattop_buffer_fill(s : SignalwindowflattopBuffer, v : Double) -> SignalwindowflattopBuffer {
  let result = signal_window_flattop_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_buffer_min(s : SignalwindowflattopBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_buffer_max(s : SignalwindowflattopBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_buffer_to_string(s : SignalwindowflattopBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_cursor_make(size : Int) -> SignalwindowflattopCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_cursor_len(s : SignalwindowflattopCursor) -> Int { s.size }

pub fn signal_window_flattop_cursor_get(s : SignalwindowflattopCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_cursor_set(s : SignalwindowflattopCursor, i : Int, v : Double) -> SignalwindowflattopCursor {
  let result = signal_window_flattop_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_cursor_sum(s : SignalwindowflattopCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_flattop_cursor_mean(s : SignalwindowflattopCursor) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_flattop_cursor_sum(s) / s.size.to_double() }
}

pub fn signal_window_flattop_cursor_scale(s : SignalwindowflattopCursor, f : Double) -> SignalwindowflattopCursor {
  let result = signal_window_flattop_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_flattop_cursor_add(a : SignalwindowflattopCursor, b : SignalwindowflattopCursor) -> SignalwindowflattopCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_flattop_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_flattop_cursor_copy(s : SignalwindowflattopCursor) -> SignalwindowflattopCursor {
  let result = signal_window_flattop_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_flattop_cursor_fill(s : SignalwindowflattopCursor, v : Double) -> SignalwindowflattopCursor {
  let result = signal_window_flattop_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_cursor_min(s : SignalwindowflattopCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_cursor_max(s : SignalwindowflattopCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_cursor_to_string(s : SignalwindowflattopCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_view_make(size : Int) -> SignalwindowflattopView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_view_len(s : SignalwindowflattopView) -> Int { s.size }

pub fn signal_window_flattop_view_get(s : SignalwindowflattopView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_view_set(s : SignalwindowflattopView, i : Int, v : Double) -> SignalwindowflattopView {
  let result = signal_window_flattop_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_view_sum(s : SignalwindowflattopView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_flattop_view_mean(s : SignalwindowflattopView) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_flattop_view_sum(s) / s.size.to_double() }
}

pub fn signal_window_flattop_view_scale(s : SignalwindowflattopView, f : Double) -> SignalwindowflattopView {
  let result = signal_window_flattop_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_flattop_view_add(a : SignalwindowflattopView, b : SignalwindowflattopView) -> SignalwindowflattopView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_flattop_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_flattop_view_copy(s : SignalwindowflattopView) -> SignalwindowflattopView {
  let result = signal_window_flattop_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_flattop_view_fill(s : SignalwindowflattopView, v : Double) -> SignalwindowflattopView {
  let result = signal_window_flattop_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_view_min(s : SignalwindowflattopView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_view_max(s : SignalwindowflattopView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_view_to_string(s : SignalwindowflattopView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_range_make(size : Int) -> SignalwindowflattopRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_range_len(s : SignalwindowflattopRange) -> Int { s.size }

pub fn signal_window_flattop_range_get(s : SignalwindowflattopRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_range_set(s : SignalwindowflattopRange, i : Int, v : Double) -> SignalwindowflattopRange {
  let result = signal_window_flattop_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_range_sum(s : SignalwindowflattopRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_flattop_range_mean(s : SignalwindowflattopRange) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_flattop_range_sum(s) / s.size.to_double() }
}

pub fn signal_window_flattop_range_scale(s : SignalwindowflattopRange, f : Double) -> SignalwindowflattopRange {
  let result = signal_window_flattop_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_flattop_range_add(a : SignalwindowflattopRange, b : SignalwindowflattopRange) -> SignalwindowflattopRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_flattop_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_flattop_range_copy(s : SignalwindowflattopRange) -> SignalwindowflattopRange {
  let result = signal_window_flattop_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_flattop_range_fill(s : SignalwindowflattopRange, v : Double) -> SignalwindowflattopRange {
  let result = signal_window_flattop_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_range_min(s : SignalwindowflattopRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_range_max(s : SignalwindowflattopRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_range_to_string(s : SignalwindowflattopRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_slice_make(size : Int) -> SignalwindowflattopSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_slice_len(s : SignalwindowflattopSlice) -> Int { s.size }

pub fn signal_window_flattop_slice_get(s : SignalwindowflattopSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_slice_set(s : SignalwindowflattopSlice, i : Int, v : Double) -> SignalwindowflattopSlice {
  let result = signal_window_flattop_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_slice_sum(s : SignalwindowflattopSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_flattop_slice_mean(s : SignalwindowflattopSlice) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_flattop_slice_sum(s) / s.size.to_double() }
}

pub fn signal_window_flattop_slice_scale(s : SignalwindowflattopSlice, f : Double) -> SignalwindowflattopSlice {
  let result = signal_window_flattop_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_flattop_slice_add(a : SignalwindowflattopSlice, b : SignalwindowflattopSlice) -> SignalwindowflattopSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_flattop_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_flattop_slice_copy(s : SignalwindowflattopSlice) -> SignalwindowflattopSlice {
  let result = signal_window_flattop_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_flattop_slice_fill(s : SignalwindowflattopSlice, v : Double) -> SignalwindowflattopSlice {
  let result = signal_window_flattop_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_flattop_slice_min(s : SignalwindowflattopSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_slice_max(s : SignalwindowflattopSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_flattop_slice_to_string(s : SignalwindowflattopSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

