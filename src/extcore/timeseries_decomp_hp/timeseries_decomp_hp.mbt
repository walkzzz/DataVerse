///===
/// extcore/timeseries_decomp_hp

pub(all) struct TimeseriesdecomphpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_hp_make_point(x : Double, y : Double) -> TimeseriesdecomphpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_hp_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecomphpPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_decomp_hp_point_x(pt : TimeseriesdecomphpPoint) -> Double { pt.x }

pub fn timeseries_decomp_hp_point_y(pt : TimeseriesdecomphpPoint) -> Double { pt.y }

pub fn timeseries_decomp_hp_point_z(pt : TimeseriesdecomphpPoint) -> Double { pt.z }

pub fn timeseries_decomp_hp_point_label(pt : TimeseriesdecomphpPoint) -> Int { pt.label }

pub fn timeseries_decomp_hp_point_dist(a : TimeseriesdecomphpPoint, b : TimeseriesdecomphpPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_decomp_hp_point_add(a : TimeseriesdecomphpPoint, b : TimeseriesdecomphpPoint) -> TimeseriesdecomphpPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_decomp_hp_point_sub(a : TimeseriesdecomphpPoint, b : TimeseriesdecomphpPoint) -> TimeseriesdecomphpPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_decomp_hp_point_scale(pt : TimeseriesdecomphpPoint, s : Double) -> TimeseriesdecomphpPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_decomp_hp_point_dot(a : TimeseriesdecomphpPoint, b : TimeseriesdecomphpPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_decomp_hp_point_cross(a : TimeseriesdecomphpPoint, b : TimeseriesdecomphpPoint) -> TimeseriesdecomphpPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_decomp_hp_point_norm(pt : TimeseriesdecomphpPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_decomp_hp_point_normalize(pt : TimeseriesdecomphpPoint) -> TimeseriesdecomphpPoint {
  let n = timeseries_decomp_hp_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_decomp_hp_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_decomp_hp_point_negate(pt : TimeseriesdecomphpPoint) -> TimeseriesdecomphpPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_decomp_hp_point_mid(a : TimeseriesdecomphpPoint, b : TimeseriesdecomphpPoint) -> TimeseriesdecomphpPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_decomp_hp_point_lerp(a : TimeseriesdecomphpPoint, b : TimeseriesdecomphpPoint, t : Double) -> TimeseriesdecomphpPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_decomp_hp_point_to_string(pt : TimeseriesdecomphpPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_hp_make_series(vals : Array[Double], name : String) -> TimeseriesdecomphpSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_decomp_hp_series_len(s : TimeseriesdecomphpSeries) -> Int { s.vals.length() }

pub fn timeseries_decomp_hp_series_sum(s : TimeseriesdecomphpSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_decomp_hp_series_mean(s : TimeseriesdecomphpSeries) -> Double {
  let n = timeseries_decomp_hp_series_len(s)
  if n == 0 { 0.0 } else { timeseries_decomp_hp_series_sum(s) / n.to_double() }
}

pub fn timeseries_decomp_hp_series_min(s : TimeseriesdecomphpSeries) -> Double {
  let n = timeseries_decomp_hp_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_series_max(s : TimeseriesdecomphpSeries) -> Double {
  let n = timeseries_decomp_hp_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_series_range(s : TimeseriesdecomphpSeries) -> Double {
  timeseries_decomp_hp_series_max(s) - timeseries_decomp_hp_series_min(s)
}

pub fn timeseries_decomp_hp_series_var(s : TimeseriesdecomphpSeries) -> Double {
  let n = timeseries_decomp_hp_series_len(s)
  if n == 0 { 0.0 } else {
    let m = timeseries_decomp_hp_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn timeseries_decomp_hp_series_std(s : TimeseriesdecomphpSeries) -> Double { @_common.sqrt(timeseries_decomp_hp_series_var(s)) }

pub fn timeseries_decomp_hp_series_median(s : TimeseriesdecomphpSeries) -> Double {
  let n = timeseries_decomp_hp_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = timeseries_decomp_hp_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_decomp_hp_series_scale(s : TimeseriesdecomphpSeries, f : Double) -> TimeseriesdecomphpSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_decomp_hp_series_add(a : TimeseriesdecomphpSeries, b : TimeseriesdecomphpSeries) -> TimeseriesdecomphpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_decomp_hp_series_sub(a : TimeseriesdecomphpSeries, b : TimeseriesdecomphpSeries) -> TimeseriesdecomphpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_decomp_hp_series_normalize(s : TimeseriesdecomphpSeries) -> TimeseriesdecomphpSeries {
  let mn = timeseries_decomp_hp_series_min(s)
  let mx = timeseries_decomp_hp_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_decomp_hp_series_cumsum(s : TimeseriesdecomphpSeries) -> TimeseriesdecomphpSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_decomp_hp_series_to_string(s : TimeseriesdecomphpSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecomphpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_hp_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecomphpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_hp_matrix_identity(n : Int) -> TimeseriesdecomphpMatrix {
  let m = timeseries_decomp_hp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_decomp_hp_matrix_get(m : TimeseriesdecomphpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_decomp_hp_matrix_transpose(m : TimeseriesdecomphpMatrix) -> TimeseriesdecomphpMatrix {
  let result = timeseries_decomp_hp_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_decomp_hp_matrix_add(a : TimeseriesdecomphpMatrix, b : TimeseriesdecomphpMatrix) -> TimeseriesdecomphpMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_decomp_hp_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_decomp_hp_matrix_scale(m : TimeseriesdecomphpMatrix, s : Double) -> TimeseriesdecomphpMatrix {
  let result = timeseries_decomp_hp_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_decomp_hp_matrix_multiply(a : TimeseriesdecomphpMatrix, b : TimeseriesdecomphpMatrix) -> TimeseriesdecomphpMatrix {
  if a.cols != b.rows { return timeseries_decomp_hp_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_decomp_hp_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_decomp_hp_matrix_trace(m : TimeseriesdecomphpMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_decomp_hp_matrix_det(m : TimeseriesdecomphpMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_decomp_hp_matrix_norm(m : TimeseriesdecomphpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_decomp_hp_matrix_to_string(m : TimeseriesdecomphpMatrix) -> String {
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

pub(all) struct TimeseriesdecomphpVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_hp_make_vector(comps : Array[Double]) -> TimeseriesdecomphpVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_hp_vector_zero(dim : Int) -> TimeseriesdecomphpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_decomp_hp_vector_add(a : TimeseriesdecomphpVector, b : TimeseriesdecomphpVector) -> TimeseriesdecomphpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_decomp_hp_vector_sub(a : TimeseriesdecomphpVector, b : TimeseriesdecomphpVector) -> TimeseriesdecomphpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_decomp_hp_vector_scale(v : TimeseriesdecomphpVector, s : Double) -> TimeseriesdecomphpVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_decomp_hp_vector_dot(a : TimeseriesdecomphpVector, b : TimeseriesdecomphpVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_decomp_hp_vector_norm(v : TimeseriesdecomphpVector) -> Double { @_common.sqrt(timeseries_decomp_hp_vector_dot(v, v)) }

pub fn timeseries_decomp_hp_vector_normalize(v : TimeseriesdecomphpVector) -> TimeseriesdecomphpVector {
  let n = timeseries_decomp_hp_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_decomp_hp_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_decomp_hp_vector_dist(a : TimeseriesdecomphpVector, b : TimeseriesdecomphpVector) -> Double {
  timeseries_decomp_hp_vector_norm(timeseries_decomp_hp_vector_sub(a, b))
}

pub fn timeseries_decomp_hp_vector_to_string(v : TimeseriesdecomphpVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_decomp_hp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_decomp_hp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_decomp_hp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_decomp_hp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_decomp_hp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_decomp_hp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_decomp_hp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_decomp_hp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_decomp_hp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_decomp_hp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_decomp_hp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_decomp_hp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_decomp_hp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_decomp_hp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_decomp_hp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_decomp_hp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_decomp_hp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_decomp_hp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_decomp_hp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_decomp_hp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_decomp_hp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_decomp_hp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_decomp_hp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_decomp_hp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_decomp_hp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_decomp_hp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_decomp_hp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_decomp_hp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_decomp_hp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesdecomphpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_frame_make(size : Int) -> TimeseriesdecomphpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_frame_len(s : TimeseriesdecomphpFrame) -> Int { s.size }

pub fn timeseries_decomp_hp_frame_get(s : TimeseriesdecomphpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_frame_set(s : TimeseriesdecomphpFrame, i : Int, v : Double) -> TimeseriesdecomphpFrame {
  let result = timeseries_decomp_hp_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_frame_sum(s : TimeseriesdecomphpFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_frame_mean(s : TimeseriesdecomphpFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_frame_scale(s : TimeseriesdecomphpFrame, f : Double) -> TimeseriesdecomphpFrame {
  let result = timeseries_decomp_hp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_frame_add(a : TimeseriesdecomphpFrame, b : TimeseriesdecomphpFrame) -> TimeseriesdecomphpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_frame_copy(s : TimeseriesdecomphpFrame) -> TimeseriesdecomphpFrame {
  let result = timeseries_decomp_hp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_frame_fill(s : TimeseriesdecomphpFrame, v : Double) -> TimeseriesdecomphpFrame {
  let result = timeseries_decomp_hp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_frame_min(s : TimeseriesdecomphpFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_frame_max(s : TimeseriesdecomphpFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_frame_to_string(s : TimeseriesdecomphpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_table_make(size : Int) -> TimeseriesdecomphpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_table_len(s : TimeseriesdecomphpTable) -> Int { s.size }

pub fn timeseries_decomp_hp_table_get(s : TimeseriesdecomphpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_table_set(s : TimeseriesdecomphpTable, i : Int, v : Double) -> TimeseriesdecomphpTable {
  let result = timeseries_decomp_hp_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_table_sum(s : TimeseriesdecomphpTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_table_mean(s : TimeseriesdecomphpTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_table_scale(s : TimeseriesdecomphpTable, f : Double) -> TimeseriesdecomphpTable {
  let result = timeseries_decomp_hp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_table_add(a : TimeseriesdecomphpTable, b : TimeseriesdecomphpTable) -> TimeseriesdecomphpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_table_copy(s : TimeseriesdecomphpTable) -> TimeseriesdecomphpTable {
  let result = timeseries_decomp_hp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_table_fill(s : TimeseriesdecomphpTable, v : Double) -> TimeseriesdecomphpTable {
  let result = timeseries_decomp_hp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_table_min(s : TimeseriesdecomphpTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_table_max(s : TimeseriesdecomphpTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_table_to_string(s : TimeseriesdecomphpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_graphn_make(size : Int) -> TimeseriesdecomphpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_graphn_len(s : TimeseriesdecomphpGraphN) -> Int { s.size }

pub fn timeseries_decomp_hp_graphn_get(s : TimeseriesdecomphpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_graphn_set(s : TimeseriesdecomphpGraphN, i : Int, v : Double) -> TimeseriesdecomphpGraphN {
  let result = timeseries_decomp_hp_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_graphn_sum(s : TimeseriesdecomphpGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_graphn_mean(s : TimeseriesdecomphpGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_graphn_scale(s : TimeseriesdecomphpGraphN, f : Double) -> TimeseriesdecomphpGraphN {
  let result = timeseries_decomp_hp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_graphn_add(a : TimeseriesdecomphpGraphN, b : TimeseriesdecomphpGraphN) -> TimeseriesdecomphpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_graphn_copy(s : TimeseriesdecomphpGraphN) -> TimeseriesdecomphpGraphN {
  let result = timeseries_decomp_hp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_graphn_fill(s : TimeseriesdecomphpGraphN, v : Double) -> TimeseriesdecomphpGraphN {
  let result = timeseries_decomp_hp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_graphn_min(s : TimeseriesdecomphpGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_graphn_max(s : TimeseriesdecomphpGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_graphn_to_string(s : TimeseriesdecomphpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_node_make(size : Int) -> TimeseriesdecomphpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_node_len(s : TimeseriesdecomphpNode) -> Int { s.size }

pub fn timeseries_decomp_hp_node_get(s : TimeseriesdecomphpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_node_set(s : TimeseriesdecomphpNode, i : Int, v : Double) -> TimeseriesdecomphpNode {
  let result = timeseries_decomp_hp_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_node_sum(s : TimeseriesdecomphpNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_node_mean(s : TimeseriesdecomphpNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_node_scale(s : TimeseriesdecomphpNode, f : Double) -> TimeseriesdecomphpNode {
  let result = timeseries_decomp_hp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_node_add(a : TimeseriesdecomphpNode, b : TimeseriesdecomphpNode) -> TimeseriesdecomphpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_node_copy(s : TimeseriesdecomphpNode) -> TimeseriesdecomphpNode {
  let result = timeseries_decomp_hp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_node_fill(s : TimeseriesdecomphpNode, v : Double) -> TimeseriesdecomphpNode {
  let result = timeseries_decomp_hp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_node_min(s : TimeseriesdecomphpNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_node_max(s : TimeseriesdecomphpNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_node_to_string(s : TimeseriesdecomphpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_edge_make(size : Int) -> TimeseriesdecomphpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_edge_len(s : TimeseriesdecomphpEdge) -> Int { s.size }

pub fn timeseries_decomp_hp_edge_get(s : TimeseriesdecomphpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_edge_set(s : TimeseriesdecomphpEdge, i : Int, v : Double) -> TimeseriesdecomphpEdge {
  let result = timeseries_decomp_hp_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_edge_sum(s : TimeseriesdecomphpEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_edge_mean(s : TimeseriesdecomphpEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_edge_scale(s : TimeseriesdecomphpEdge, f : Double) -> TimeseriesdecomphpEdge {
  let result = timeseries_decomp_hp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_edge_add(a : TimeseriesdecomphpEdge, b : TimeseriesdecomphpEdge) -> TimeseriesdecomphpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_edge_copy(s : TimeseriesdecomphpEdge) -> TimeseriesdecomphpEdge {
  let result = timeseries_decomp_hp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_edge_fill(s : TimeseriesdecomphpEdge, v : Double) -> TimeseriesdecomphpEdge {
  let result = timeseries_decomp_hp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_edge_min(s : TimeseriesdecomphpEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_edge_max(s : TimeseriesdecomphpEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_edge_to_string(s : TimeseriesdecomphpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_path_make(size : Int) -> TimeseriesdecomphpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_path_len(s : TimeseriesdecomphpPath) -> Int { s.size }

pub fn timeseries_decomp_hp_path_get(s : TimeseriesdecomphpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_path_set(s : TimeseriesdecomphpPath, i : Int, v : Double) -> TimeseriesdecomphpPath {
  let result = timeseries_decomp_hp_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_path_sum(s : TimeseriesdecomphpPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_path_mean(s : TimeseriesdecomphpPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_path_scale(s : TimeseriesdecomphpPath, f : Double) -> TimeseriesdecomphpPath {
  let result = timeseries_decomp_hp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_path_add(a : TimeseriesdecomphpPath, b : TimeseriesdecomphpPath) -> TimeseriesdecomphpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_path_copy(s : TimeseriesdecomphpPath) -> TimeseriesdecomphpPath {
  let result = timeseries_decomp_hp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_path_fill(s : TimeseriesdecomphpPath, v : Double) -> TimeseriesdecomphpPath {
  let result = timeseries_decomp_hp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_path_min(s : TimeseriesdecomphpPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_path_max(s : TimeseriesdecomphpPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_path_to_string(s : TimeseriesdecomphpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_cluster_make(size : Int) -> TimeseriesdecomphpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_cluster_len(s : TimeseriesdecomphpCluster) -> Int { s.size }

pub fn timeseries_decomp_hp_cluster_get(s : TimeseriesdecomphpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_cluster_set(s : TimeseriesdecomphpCluster, i : Int, v : Double) -> TimeseriesdecomphpCluster {
  let result = timeseries_decomp_hp_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_cluster_sum(s : TimeseriesdecomphpCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_cluster_mean(s : TimeseriesdecomphpCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_cluster_scale(s : TimeseriesdecomphpCluster, f : Double) -> TimeseriesdecomphpCluster {
  let result = timeseries_decomp_hp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_cluster_add(a : TimeseriesdecomphpCluster, b : TimeseriesdecomphpCluster) -> TimeseriesdecomphpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_cluster_copy(s : TimeseriesdecomphpCluster) -> TimeseriesdecomphpCluster {
  let result = timeseries_decomp_hp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_cluster_fill(s : TimeseriesdecomphpCluster, v : Double) -> TimeseriesdecomphpCluster {
  let result = timeseries_decomp_hp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_cluster_min(s : TimeseriesdecomphpCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_cluster_max(s : TimeseriesdecomphpCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_cluster_to_string(s : TimeseriesdecomphpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_model_make(size : Int) -> TimeseriesdecomphpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_model_len(s : TimeseriesdecomphpModel) -> Int { s.size }

pub fn timeseries_decomp_hp_model_get(s : TimeseriesdecomphpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_model_set(s : TimeseriesdecomphpModel, i : Int, v : Double) -> TimeseriesdecomphpModel {
  let result = timeseries_decomp_hp_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_model_sum(s : TimeseriesdecomphpModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_model_mean(s : TimeseriesdecomphpModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_model_scale(s : TimeseriesdecomphpModel, f : Double) -> TimeseriesdecomphpModel {
  let result = timeseries_decomp_hp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_model_add(a : TimeseriesdecomphpModel, b : TimeseriesdecomphpModel) -> TimeseriesdecomphpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_model_copy(s : TimeseriesdecomphpModel) -> TimeseriesdecomphpModel {
  let result = timeseries_decomp_hp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_model_fill(s : TimeseriesdecomphpModel, v : Double) -> TimeseriesdecomphpModel {
  let result = timeseries_decomp_hp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_model_min(s : TimeseriesdecomphpModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_model_max(s : TimeseriesdecomphpModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_model_to_string(s : TimeseriesdecomphpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_layer_make(size : Int) -> TimeseriesdecomphpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_layer_len(s : TimeseriesdecomphpLayer) -> Int { s.size }

pub fn timeseries_decomp_hp_layer_get(s : TimeseriesdecomphpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_layer_set(s : TimeseriesdecomphpLayer, i : Int, v : Double) -> TimeseriesdecomphpLayer {
  let result = timeseries_decomp_hp_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_layer_sum(s : TimeseriesdecomphpLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_layer_mean(s : TimeseriesdecomphpLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_layer_scale(s : TimeseriesdecomphpLayer, f : Double) -> TimeseriesdecomphpLayer {
  let result = timeseries_decomp_hp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_layer_add(a : TimeseriesdecomphpLayer, b : TimeseriesdecomphpLayer) -> TimeseriesdecomphpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_layer_copy(s : TimeseriesdecomphpLayer) -> TimeseriesdecomphpLayer {
  let result = timeseries_decomp_hp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_layer_fill(s : TimeseriesdecomphpLayer, v : Double) -> TimeseriesdecomphpLayer {
  let result = timeseries_decomp_hp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_layer_min(s : TimeseriesdecomphpLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_layer_max(s : TimeseriesdecomphpLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_layer_to_string(s : TimeseriesdecomphpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_buffer_make(size : Int) -> TimeseriesdecomphpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_buffer_len(s : TimeseriesdecomphpBuffer) -> Int { s.size }

pub fn timeseries_decomp_hp_buffer_get(s : TimeseriesdecomphpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_buffer_set(s : TimeseriesdecomphpBuffer, i : Int, v : Double) -> TimeseriesdecomphpBuffer {
  let result = timeseries_decomp_hp_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_buffer_sum(s : TimeseriesdecomphpBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_buffer_mean(s : TimeseriesdecomphpBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_buffer_scale(s : TimeseriesdecomphpBuffer, f : Double) -> TimeseriesdecomphpBuffer {
  let result = timeseries_decomp_hp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_buffer_add(a : TimeseriesdecomphpBuffer, b : TimeseriesdecomphpBuffer) -> TimeseriesdecomphpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_buffer_copy(s : TimeseriesdecomphpBuffer) -> TimeseriesdecomphpBuffer {
  let result = timeseries_decomp_hp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_buffer_fill(s : TimeseriesdecomphpBuffer, v : Double) -> TimeseriesdecomphpBuffer {
  let result = timeseries_decomp_hp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_buffer_min(s : TimeseriesdecomphpBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_buffer_max(s : TimeseriesdecomphpBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_buffer_to_string(s : TimeseriesdecomphpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_cursor_make(size : Int) -> TimeseriesdecomphpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_cursor_len(s : TimeseriesdecomphpCursor) -> Int { s.size }

pub fn timeseries_decomp_hp_cursor_get(s : TimeseriesdecomphpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_cursor_set(s : TimeseriesdecomphpCursor, i : Int, v : Double) -> TimeseriesdecomphpCursor {
  let result = timeseries_decomp_hp_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_cursor_sum(s : TimeseriesdecomphpCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_cursor_mean(s : TimeseriesdecomphpCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_cursor_scale(s : TimeseriesdecomphpCursor, f : Double) -> TimeseriesdecomphpCursor {
  let result = timeseries_decomp_hp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_cursor_add(a : TimeseriesdecomphpCursor, b : TimeseriesdecomphpCursor) -> TimeseriesdecomphpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_cursor_copy(s : TimeseriesdecomphpCursor) -> TimeseriesdecomphpCursor {
  let result = timeseries_decomp_hp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_cursor_fill(s : TimeseriesdecomphpCursor, v : Double) -> TimeseriesdecomphpCursor {
  let result = timeseries_decomp_hp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_cursor_min(s : TimeseriesdecomphpCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_cursor_max(s : TimeseriesdecomphpCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_cursor_to_string(s : TimeseriesdecomphpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_view_make(size : Int) -> TimeseriesdecomphpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_view_len(s : TimeseriesdecomphpView) -> Int { s.size }

pub fn timeseries_decomp_hp_view_get(s : TimeseriesdecomphpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_view_set(s : TimeseriesdecomphpView, i : Int, v : Double) -> TimeseriesdecomphpView {
  let result = timeseries_decomp_hp_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_view_sum(s : TimeseriesdecomphpView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_view_mean(s : TimeseriesdecomphpView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_view_scale(s : TimeseriesdecomphpView, f : Double) -> TimeseriesdecomphpView {
  let result = timeseries_decomp_hp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_view_add(a : TimeseriesdecomphpView, b : TimeseriesdecomphpView) -> TimeseriesdecomphpView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_view_copy(s : TimeseriesdecomphpView) -> TimeseriesdecomphpView {
  let result = timeseries_decomp_hp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_view_fill(s : TimeseriesdecomphpView, v : Double) -> TimeseriesdecomphpView {
  let result = timeseries_decomp_hp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_view_min(s : TimeseriesdecomphpView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_view_max(s : TimeseriesdecomphpView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_view_to_string(s : TimeseriesdecomphpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_range_make(size : Int) -> TimeseriesdecomphpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_range_len(s : TimeseriesdecomphpRange) -> Int { s.size }

pub fn timeseries_decomp_hp_range_get(s : TimeseriesdecomphpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_range_set(s : TimeseriesdecomphpRange, i : Int, v : Double) -> TimeseriesdecomphpRange {
  let result = timeseries_decomp_hp_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_range_sum(s : TimeseriesdecomphpRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_range_mean(s : TimeseriesdecomphpRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_range_scale(s : TimeseriesdecomphpRange, f : Double) -> TimeseriesdecomphpRange {
  let result = timeseries_decomp_hp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_range_add(a : TimeseriesdecomphpRange, b : TimeseriesdecomphpRange) -> TimeseriesdecomphpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_range_copy(s : TimeseriesdecomphpRange) -> TimeseriesdecomphpRange {
  let result = timeseries_decomp_hp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_range_fill(s : TimeseriesdecomphpRange, v : Double) -> TimeseriesdecomphpRange {
  let result = timeseries_decomp_hp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_range_min(s : TimeseriesdecomphpRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_range_max(s : TimeseriesdecomphpRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_range_to_string(s : TimeseriesdecomphpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_slice_make(size : Int) -> TimeseriesdecomphpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_slice_len(s : TimeseriesdecomphpSlice) -> Int { s.size }

pub fn timeseries_decomp_hp_slice_get(s : TimeseriesdecomphpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_slice_set(s : TimeseriesdecomphpSlice, i : Int, v : Double) -> TimeseriesdecomphpSlice {
  let result = timeseries_decomp_hp_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_slice_sum(s : TimeseriesdecomphpSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_slice_mean(s : TimeseriesdecomphpSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_slice_scale(s : TimeseriesdecomphpSlice, f : Double) -> TimeseriesdecomphpSlice {
  let result = timeseries_decomp_hp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_slice_add(a : TimeseriesdecomphpSlice, b : TimeseriesdecomphpSlice) -> TimeseriesdecomphpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_slice_copy(s : TimeseriesdecomphpSlice) -> TimeseriesdecomphpSlice {
  let result = timeseries_decomp_hp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_slice_fill(s : TimeseriesdecomphpSlice, v : Double) -> TimeseriesdecomphpSlice {
  let result = timeseries_decomp_hp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_slice_min(s : TimeseriesdecomphpSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_slice_max(s : TimeseriesdecomphpSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_slice_to_string(s : TimeseriesdecomphpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

