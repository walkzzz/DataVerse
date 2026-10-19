///===
/// extcore/timeseries_prophet

pub(all) struct TimeseriesprophetPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_prophet_make_point(x : Double, y : Double) -> TimeseriesprophetPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_prophet_make_point3(x : Double, y : Double, z : Double) -> TimeseriesprophetPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_prophet_point_x(pt : TimeseriesprophetPoint) -> Double { pt.x }

pub fn timeseries_prophet_point_y(pt : TimeseriesprophetPoint) -> Double { pt.y }

pub fn timeseries_prophet_point_z(pt : TimeseriesprophetPoint) -> Double { pt.z }

pub fn timeseries_prophet_point_label(pt : TimeseriesprophetPoint) -> Int { pt.label }

pub fn timeseries_prophet_point_dist(a : TimeseriesprophetPoint, b : TimeseriesprophetPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_prophet_point_add(a : TimeseriesprophetPoint, b : TimeseriesprophetPoint) -> TimeseriesprophetPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_prophet_point_sub(a : TimeseriesprophetPoint, b : TimeseriesprophetPoint) -> TimeseriesprophetPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_prophet_point_scale(pt : TimeseriesprophetPoint, s : Double) -> TimeseriesprophetPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_prophet_point_dot(a : TimeseriesprophetPoint, b : TimeseriesprophetPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_prophet_point_cross(a : TimeseriesprophetPoint, b : TimeseriesprophetPoint) -> TimeseriesprophetPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_prophet_point_norm(pt : TimeseriesprophetPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_prophet_point_normalize(pt : TimeseriesprophetPoint) -> TimeseriesprophetPoint {
  let n = timeseries_prophet_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_prophet_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_prophet_point_negate(pt : TimeseriesprophetPoint) -> TimeseriesprophetPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_prophet_point_mid(a : TimeseriesprophetPoint, b : TimeseriesprophetPoint) -> TimeseriesprophetPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_prophet_point_lerp(a : TimeseriesprophetPoint, b : TimeseriesprophetPoint, t : Double) -> TimeseriesprophetPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_prophet_point_to_string(pt : TimeseriesprophetPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesprophetSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_prophet_make_series(vals : Array[Double], name : String) -> TimeseriesprophetSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_prophet_series_len(s : TimeseriesprophetSeries) -> Int { s.vals.length() }

pub fn timeseries_prophet_series_sum(s : TimeseriesprophetSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_prophet_series_mean(s : TimeseriesprophetSeries) -> Double {
  let n = timeseries_prophet_series_len(s)
  if n == 0 { 0.0 } else { timeseries_prophet_series_sum(s) / n.to_double() }
}

pub fn timeseries_prophet_series_min(s : TimeseriesprophetSeries) -> Double {
  let n = timeseries_prophet_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_prophet_series_max(s : TimeseriesprophetSeries) -> Double {
  let n = timeseries_prophet_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_prophet_series_range(s : TimeseriesprophetSeries) -> Double {
  timeseries_prophet_series_max(s) - timeseries_prophet_series_min(s)
}

pub fn timeseries_prophet_series_var(s : TimeseriesprophetSeries) -> Double {
  let n = timeseries_prophet_series_len(s)
  if n == 0 { 0.0 } else {
    let m = timeseries_prophet_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn timeseries_prophet_series_std(s : TimeseriesprophetSeries) -> Double { @_common.sqrt(timeseries_prophet_series_var(s)) }

pub fn timeseries_prophet_series_median(s : TimeseriesprophetSeries) -> Double {
  let n = timeseries_prophet_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = timeseries_prophet_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_prophet_series_scale(s : TimeseriesprophetSeries, f : Double) -> TimeseriesprophetSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_prophet_series_add(a : TimeseriesprophetSeries, b : TimeseriesprophetSeries) -> TimeseriesprophetSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_prophet_series_sub(a : TimeseriesprophetSeries, b : TimeseriesprophetSeries) -> TimeseriesprophetSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_prophet_series_normalize(s : TimeseriesprophetSeries) -> TimeseriesprophetSeries {
  let mn = timeseries_prophet_series_min(s)
  let mx = timeseries_prophet_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_prophet_series_cumsum(s : TimeseriesprophetSeries) -> TimeseriesprophetSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_prophet_series_to_string(s : TimeseriesprophetSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesprophetMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_prophet_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesprophetMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_prophet_matrix_identity(n : Int) -> TimeseriesprophetMatrix {
  let m = timeseries_prophet_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_prophet_matrix_get(m : TimeseriesprophetMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_prophet_matrix_transpose(m : TimeseriesprophetMatrix) -> TimeseriesprophetMatrix {
  let result = timeseries_prophet_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_prophet_matrix_add(a : TimeseriesprophetMatrix, b : TimeseriesprophetMatrix) -> TimeseriesprophetMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_prophet_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_prophet_matrix_scale(m : TimeseriesprophetMatrix, s : Double) -> TimeseriesprophetMatrix {
  let result = timeseries_prophet_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_prophet_matrix_multiply(a : TimeseriesprophetMatrix, b : TimeseriesprophetMatrix) -> TimeseriesprophetMatrix {
  if a.cols != b.rows { return timeseries_prophet_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_prophet_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_prophet_matrix_trace(m : TimeseriesprophetMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_prophet_matrix_det(m : TimeseriesprophetMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_prophet_matrix_norm(m : TimeseriesprophetMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_prophet_matrix_to_string(m : TimeseriesprophetMatrix) -> String {
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

pub(all) struct TimeseriesprophetVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_prophet_make_vector(comps : Array[Double]) -> TimeseriesprophetVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_prophet_vector_zero(dim : Int) -> TimeseriesprophetVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_prophet_vector_add(a : TimeseriesprophetVector, b : TimeseriesprophetVector) -> TimeseriesprophetVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_prophet_vector_sub(a : TimeseriesprophetVector, b : TimeseriesprophetVector) -> TimeseriesprophetVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_prophet_vector_scale(v : TimeseriesprophetVector, s : Double) -> TimeseriesprophetVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_prophet_vector_dot(a : TimeseriesprophetVector, b : TimeseriesprophetVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_prophet_vector_norm(v : TimeseriesprophetVector) -> Double { @_common.sqrt(timeseries_prophet_vector_dot(v, v)) }

pub fn timeseries_prophet_vector_normalize(v : TimeseriesprophetVector) -> TimeseriesprophetVector {
  let n = timeseries_prophet_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_prophet_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_prophet_vector_dist(a : TimeseriesprophetVector, b : TimeseriesprophetVector) -> Double {
  timeseries_prophet_vector_norm(timeseries_prophet_vector_sub(a, b))
}

pub fn timeseries_prophet_vector_to_string(v : TimeseriesprophetVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_prophet_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_prophet_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_prophet_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_prophet_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_prophet_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_prophet_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_prophet_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_prophet_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_prophet_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_prophet_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_prophet_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_prophet_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_prophet_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_prophet_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_prophet_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_prophet_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_prophet_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_prophet_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_prophet_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_prophet_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_prophet_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_prophet_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_prophet_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_prophet_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_prophet_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_prophet_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_prophet_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_prophet_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_prophet_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesprophetFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_frame_make(size : Int) -> TimeseriesprophetFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_frame_len(s : TimeseriesprophetFrame) -> Int { s.size }

pub fn timeseries_prophet_frame_get(s : TimeseriesprophetFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_frame_set(s : TimeseriesprophetFrame, i : Int, v : Double) -> TimeseriesprophetFrame {
  let result = timeseries_prophet_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_frame_sum(s : TimeseriesprophetFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_prophet_frame_mean(s : TimeseriesprophetFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_prophet_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_prophet_frame_scale(s : TimeseriesprophetFrame, f : Double) -> TimeseriesprophetFrame {
  let result = timeseries_prophet_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_prophet_frame_add(a : TimeseriesprophetFrame, b : TimeseriesprophetFrame) -> TimeseriesprophetFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_prophet_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_prophet_frame_copy(s : TimeseriesprophetFrame) -> TimeseriesprophetFrame {
  let result = timeseries_prophet_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_prophet_frame_fill(s : TimeseriesprophetFrame, v : Double) -> TimeseriesprophetFrame {
  let result = timeseries_prophet_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_frame_min(s : TimeseriesprophetFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_frame_max(s : TimeseriesprophetFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_frame_to_string(s : TimeseriesprophetFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_table_make(size : Int) -> TimeseriesprophetTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_table_len(s : TimeseriesprophetTable) -> Int { s.size }

pub fn timeseries_prophet_table_get(s : TimeseriesprophetTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_table_set(s : TimeseriesprophetTable, i : Int, v : Double) -> TimeseriesprophetTable {
  let result = timeseries_prophet_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_table_sum(s : TimeseriesprophetTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_prophet_table_mean(s : TimeseriesprophetTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_prophet_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_prophet_table_scale(s : TimeseriesprophetTable, f : Double) -> TimeseriesprophetTable {
  let result = timeseries_prophet_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_prophet_table_add(a : TimeseriesprophetTable, b : TimeseriesprophetTable) -> TimeseriesprophetTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_prophet_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_prophet_table_copy(s : TimeseriesprophetTable) -> TimeseriesprophetTable {
  let result = timeseries_prophet_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_prophet_table_fill(s : TimeseriesprophetTable, v : Double) -> TimeseriesprophetTable {
  let result = timeseries_prophet_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_table_min(s : TimeseriesprophetTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_table_max(s : TimeseriesprophetTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_table_to_string(s : TimeseriesprophetTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_graphn_make(size : Int) -> TimeseriesprophetGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_graphn_len(s : TimeseriesprophetGraphN) -> Int { s.size }

pub fn timeseries_prophet_graphn_get(s : TimeseriesprophetGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_graphn_set(s : TimeseriesprophetGraphN, i : Int, v : Double) -> TimeseriesprophetGraphN {
  let result = timeseries_prophet_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_graphn_sum(s : TimeseriesprophetGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_prophet_graphn_mean(s : TimeseriesprophetGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_prophet_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_prophet_graphn_scale(s : TimeseriesprophetGraphN, f : Double) -> TimeseriesprophetGraphN {
  let result = timeseries_prophet_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_prophet_graphn_add(a : TimeseriesprophetGraphN, b : TimeseriesprophetGraphN) -> TimeseriesprophetGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_prophet_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_prophet_graphn_copy(s : TimeseriesprophetGraphN) -> TimeseriesprophetGraphN {
  let result = timeseries_prophet_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_prophet_graphn_fill(s : TimeseriesprophetGraphN, v : Double) -> TimeseriesprophetGraphN {
  let result = timeseries_prophet_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_graphn_min(s : TimeseriesprophetGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_graphn_max(s : TimeseriesprophetGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_graphn_to_string(s : TimeseriesprophetGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_node_make(size : Int) -> TimeseriesprophetNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_node_len(s : TimeseriesprophetNode) -> Int { s.size }

pub fn timeseries_prophet_node_get(s : TimeseriesprophetNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_node_set(s : TimeseriesprophetNode, i : Int, v : Double) -> TimeseriesprophetNode {
  let result = timeseries_prophet_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_node_sum(s : TimeseriesprophetNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_prophet_node_mean(s : TimeseriesprophetNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_prophet_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_prophet_node_scale(s : TimeseriesprophetNode, f : Double) -> TimeseriesprophetNode {
  let result = timeseries_prophet_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_prophet_node_add(a : TimeseriesprophetNode, b : TimeseriesprophetNode) -> TimeseriesprophetNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_prophet_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_prophet_node_copy(s : TimeseriesprophetNode) -> TimeseriesprophetNode {
  let result = timeseries_prophet_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_prophet_node_fill(s : TimeseriesprophetNode, v : Double) -> TimeseriesprophetNode {
  let result = timeseries_prophet_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_node_min(s : TimeseriesprophetNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_node_max(s : TimeseriesprophetNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_node_to_string(s : TimeseriesprophetNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_edge_make(size : Int) -> TimeseriesprophetEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_edge_len(s : TimeseriesprophetEdge) -> Int { s.size }

pub fn timeseries_prophet_edge_get(s : TimeseriesprophetEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_edge_set(s : TimeseriesprophetEdge, i : Int, v : Double) -> TimeseriesprophetEdge {
  let result = timeseries_prophet_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_edge_sum(s : TimeseriesprophetEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_prophet_edge_mean(s : TimeseriesprophetEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_prophet_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_prophet_edge_scale(s : TimeseriesprophetEdge, f : Double) -> TimeseriesprophetEdge {
  let result = timeseries_prophet_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_prophet_edge_add(a : TimeseriesprophetEdge, b : TimeseriesprophetEdge) -> TimeseriesprophetEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_prophet_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_prophet_edge_copy(s : TimeseriesprophetEdge) -> TimeseriesprophetEdge {
  let result = timeseries_prophet_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_prophet_edge_fill(s : TimeseriesprophetEdge, v : Double) -> TimeseriesprophetEdge {
  let result = timeseries_prophet_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_edge_min(s : TimeseriesprophetEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_edge_max(s : TimeseriesprophetEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_edge_to_string(s : TimeseriesprophetEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_path_make(size : Int) -> TimeseriesprophetPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_path_len(s : TimeseriesprophetPath) -> Int { s.size }

pub fn timeseries_prophet_path_get(s : TimeseriesprophetPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_path_set(s : TimeseriesprophetPath, i : Int, v : Double) -> TimeseriesprophetPath {
  let result = timeseries_prophet_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_path_sum(s : TimeseriesprophetPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_prophet_path_mean(s : TimeseriesprophetPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_prophet_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_prophet_path_scale(s : TimeseriesprophetPath, f : Double) -> TimeseriesprophetPath {
  let result = timeseries_prophet_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_prophet_path_add(a : TimeseriesprophetPath, b : TimeseriesprophetPath) -> TimeseriesprophetPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_prophet_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_prophet_path_copy(s : TimeseriesprophetPath) -> TimeseriesprophetPath {
  let result = timeseries_prophet_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_prophet_path_fill(s : TimeseriesprophetPath, v : Double) -> TimeseriesprophetPath {
  let result = timeseries_prophet_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_path_min(s : TimeseriesprophetPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_path_max(s : TimeseriesprophetPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_path_to_string(s : TimeseriesprophetPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_cluster_make(size : Int) -> TimeseriesprophetCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_cluster_len(s : TimeseriesprophetCluster) -> Int { s.size }

pub fn timeseries_prophet_cluster_get(s : TimeseriesprophetCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_cluster_set(s : TimeseriesprophetCluster, i : Int, v : Double) -> TimeseriesprophetCluster {
  let result = timeseries_prophet_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_cluster_sum(s : TimeseriesprophetCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_prophet_cluster_mean(s : TimeseriesprophetCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_prophet_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_prophet_cluster_scale(s : TimeseriesprophetCluster, f : Double) -> TimeseriesprophetCluster {
  let result = timeseries_prophet_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_prophet_cluster_add(a : TimeseriesprophetCluster, b : TimeseriesprophetCluster) -> TimeseriesprophetCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_prophet_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_prophet_cluster_copy(s : TimeseriesprophetCluster) -> TimeseriesprophetCluster {
  let result = timeseries_prophet_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_prophet_cluster_fill(s : TimeseriesprophetCluster, v : Double) -> TimeseriesprophetCluster {
  let result = timeseries_prophet_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_cluster_min(s : TimeseriesprophetCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_cluster_max(s : TimeseriesprophetCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_cluster_to_string(s : TimeseriesprophetCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_model_make(size : Int) -> TimeseriesprophetModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_model_len(s : TimeseriesprophetModel) -> Int { s.size }

pub fn timeseries_prophet_model_get(s : TimeseriesprophetModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_model_set(s : TimeseriesprophetModel, i : Int, v : Double) -> TimeseriesprophetModel {
  let result = timeseries_prophet_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_model_sum(s : TimeseriesprophetModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_prophet_model_mean(s : TimeseriesprophetModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_prophet_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_prophet_model_scale(s : TimeseriesprophetModel, f : Double) -> TimeseriesprophetModel {
  let result = timeseries_prophet_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_prophet_model_add(a : TimeseriesprophetModel, b : TimeseriesprophetModel) -> TimeseriesprophetModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_prophet_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_prophet_model_copy(s : TimeseriesprophetModel) -> TimeseriesprophetModel {
  let result = timeseries_prophet_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_prophet_model_fill(s : TimeseriesprophetModel, v : Double) -> TimeseriesprophetModel {
  let result = timeseries_prophet_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_model_min(s : TimeseriesprophetModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_model_max(s : TimeseriesprophetModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_model_to_string(s : TimeseriesprophetModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_layer_make(size : Int) -> TimeseriesprophetLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_layer_len(s : TimeseriesprophetLayer) -> Int { s.size }

pub fn timeseries_prophet_layer_get(s : TimeseriesprophetLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_layer_set(s : TimeseriesprophetLayer, i : Int, v : Double) -> TimeseriesprophetLayer {
  let result = timeseries_prophet_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_layer_sum(s : TimeseriesprophetLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_prophet_layer_mean(s : TimeseriesprophetLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_prophet_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_prophet_layer_scale(s : TimeseriesprophetLayer, f : Double) -> TimeseriesprophetLayer {
  let result = timeseries_prophet_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_prophet_layer_add(a : TimeseriesprophetLayer, b : TimeseriesprophetLayer) -> TimeseriesprophetLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_prophet_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_prophet_layer_copy(s : TimeseriesprophetLayer) -> TimeseriesprophetLayer {
  let result = timeseries_prophet_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_prophet_layer_fill(s : TimeseriesprophetLayer, v : Double) -> TimeseriesprophetLayer {
  let result = timeseries_prophet_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_layer_min(s : TimeseriesprophetLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_layer_max(s : TimeseriesprophetLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_layer_to_string(s : TimeseriesprophetLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_buffer_make(size : Int) -> TimeseriesprophetBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_buffer_len(s : TimeseriesprophetBuffer) -> Int { s.size }

pub fn timeseries_prophet_buffer_get(s : TimeseriesprophetBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_buffer_set(s : TimeseriesprophetBuffer, i : Int, v : Double) -> TimeseriesprophetBuffer {
  let result = timeseries_prophet_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_buffer_sum(s : TimeseriesprophetBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_prophet_buffer_mean(s : TimeseriesprophetBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_prophet_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_prophet_buffer_scale(s : TimeseriesprophetBuffer, f : Double) -> TimeseriesprophetBuffer {
  let result = timeseries_prophet_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_prophet_buffer_add(a : TimeseriesprophetBuffer, b : TimeseriesprophetBuffer) -> TimeseriesprophetBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_prophet_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_prophet_buffer_copy(s : TimeseriesprophetBuffer) -> TimeseriesprophetBuffer {
  let result = timeseries_prophet_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_prophet_buffer_fill(s : TimeseriesprophetBuffer, v : Double) -> TimeseriesprophetBuffer {
  let result = timeseries_prophet_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_buffer_min(s : TimeseriesprophetBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_buffer_max(s : TimeseriesprophetBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_buffer_to_string(s : TimeseriesprophetBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_cursor_make(size : Int) -> TimeseriesprophetCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_cursor_len(s : TimeseriesprophetCursor) -> Int { s.size }

pub fn timeseries_prophet_cursor_get(s : TimeseriesprophetCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_cursor_set(s : TimeseriesprophetCursor, i : Int, v : Double) -> TimeseriesprophetCursor {
  let result = timeseries_prophet_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_cursor_sum(s : TimeseriesprophetCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_prophet_cursor_mean(s : TimeseriesprophetCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_prophet_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_prophet_cursor_scale(s : TimeseriesprophetCursor, f : Double) -> TimeseriesprophetCursor {
  let result = timeseries_prophet_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_prophet_cursor_add(a : TimeseriesprophetCursor, b : TimeseriesprophetCursor) -> TimeseriesprophetCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_prophet_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_prophet_cursor_copy(s : TimeseriesprophetCursor) -> TimeseriesprophetCursor {
  let result = timeseries_prophet_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_prophet_cursor_fill(s : TimeseriesprophetCursor, v : Double) -> TimeseriesprophetCursor {
  let result = timeseries_prophet_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_cursor_min(s : TimeseriesprophetCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_cursor_max(s : TimeseriesprophetCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_cursor_to_string(s : TimeseriesprophetCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_view_make(size : Int) -> TimeseriesprophetView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_view_len(s : TimeseriesprophetView) -> Int { s.size }

pub fn timeseries_prophet_view_get(s : TimeseriesprophetView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_view_set(s : TimeseriesprophetView, i : Int, v : Double) -> TimeseriesprophetView {
  let result = timeseries_prophet_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_view_sum(s : TimeseriesprophetView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_prophet_view_mean(s : TimeseriesprophetView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_prophet_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_prophet_view_scale(s : TimeseriesprophetView, f : Double) -> TimeseriesprophetView {
  let result = timeseries_prophet_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_prophet_view_add(a : TimeseriesprophetView, b : TimeseriesprophetView) -> TimeseriesprophetView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_prophet_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_prophet_view_copy(s : TimeseriesprophetView) -> TimeseriesprophetView {
  let result = timeseries_prophet_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_prophet_view_fill(s : TimeseriesprophetView, v : Double) -> TimeseriesprophetView {
  let result = timeseries_prophet_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_view_min(s : TimeseriesprophetView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_view_max(s : TimeseriesprophetView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_view_to_string(s : TimeseriesprophetView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_range_make(size : Int) -> TimeseriesprophetRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_range_len(s : TimeseriesprophetRange) -> Int { s.size }

pub fn timeseries_prophet_range_get(s : TimeseriesprophetRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_range_set(s : TimeseriesprophetRange, i : Int, v : Double) -> TimeseriesprophetRange {
  let result = timeseries_prophet_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_range_sum(s : TimeseriesprophetRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_prophet_range_mean(s : TimeseriesprophetRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_prophet_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_prophet_range_scale(s : TimeseriesprophetRange, f : Double) -> TimeseriesprophetRange {
  let result = timeseries_prophet_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_prophet_range_add(a : TimeseriesprophetRange, b : TimeseriesprophetRange) -> TimeseriesprophetRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_prophet_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_prophet_range_copy(s : TimeseriesprophetRange) -> TimeseriesprophetRange {
  let result = timeseries_prophet_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_prophet_range_fill(s : TimeseriesprophetRange, v : Double) -> TimeseriesprophetRange {
  let result = timeseries_prophet_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_range_min(s : TimeseriesprophetRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_range_max(s : TimeseriesprophetRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_range_to_string(s : TimeseriesprophetRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_slice_make(size : Int) -> TimeseriesprophetSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_slice_len(s : TimeseriesprophetSlice) -> Int { s.size }

pub fn timeseries_prophet_slice_get(s : TimeseriesprophetSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_slice_set(s : TimeseriesprophetSlice, i : Int, v : Double) -> TimeseriesprophetSlice {
  let result = timeseries_prophet_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_slice_sum(s : TimeseriesprophetSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_prophet_slice_mean(s : TimeseriesprophetSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_prophet_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_prophet_slice_scale(s : TimeseriesprophetSlice, f : Double) -> TimeseriesprophetSlice {
  let result = timeseries_prophet_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_prophet_slice_add(a : TimeseriesprophetSlice, b : TimeseriesprophetSlice) -> TimeseriesprophetSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_prophet_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_prophet_slice_copy(s : TimeseriesprophetSlice) -> TimeseriesprophetSlice {
  let result = timeseries_prophet_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_prophet_slice_fill(s : TimeseriesprophetSlice, v : Double) -> TimeseriesprophetSlice {
  let result = timeseries_prophet_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_prophet_slice_min(s : TimeseriesprophetSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_slice_max(s : TimeseriesprophetSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_prophet_slice_to_string(s : TimeseriesprophetSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

