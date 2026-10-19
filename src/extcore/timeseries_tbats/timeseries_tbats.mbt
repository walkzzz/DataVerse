///===
/// extcore/timeseries_tbats

pub(all) struct TimeseriestbatsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_tbats_make_point(x : Double, y : Double) -> TimeseriestbatsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_tbats_make_point3(x : Double, y : Double, z : Double) -> TimeseriestbatsPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_tbats_point_x(pt : TimeseriestbatsPoint) -> Double { pt.x }

pub fn timeseries_tbats_point_y(pt : TimeseriestbatsPoint) -> Double { pt.y }

pub fn timeseries_tbats_point_z(pt : TimeseriestbatsPoint) -> Double { pt.z }

pub fn timeseries_tbats_point_label(pt : TimeseriestbatsPoint) -> Int { pt.label }

pub fn timeseries_tbats_point_dist(a : TimeseriestbatsPoint, b : TimeseriestbatsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_tbats_point_add(a : TimeseriestbatsPoint, b : TimeseriestbatsPoint) -> TimeseriestbatsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_tbats_point_sub(a : TimeseriestbatsPoint, b : TimeseriestbatsPoint) -> TimeseriestbatsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_tbats_point_scale(pt : TimeseriestbatsPoint, s : Double) -> TimeseriestbatsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_tbats_point_dot(a : TimeseriestbatsPoint, b : TimeseriestbatsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_tbats_point_cross(a : TimeseriestbatsPoint, b : TimeseriestbatsPoint) -> TimeseriestbatsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_tbats_point_norm(pt : TimeseriestbatsPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_tbats_point_normalize(pt : TimeseriestbatsPoint) -> TimeseriestbatsPoint {
  let n = timeseries_tbats_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_tbats_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_tbats_point_negate(pt : TimeseriestbatsPoint) -> TimeseriestbatsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_tbats_point_mid(a : TimeseriestbatsPoint, b : TimeseriestbatsPoint) -> TimeseriestbatsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_tbats_point_lerp(a : TimeseriestbatsPoint, b : TimeseriestbatsPoint, t : Double) -> TimeseriestbatsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_tbats_point_to_string(pt : TimeseriestbatsPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriestbatsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_tbats_make_series(vals : Array[Double], name : String) -> TimeseriestbatsSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_tbats_series_len(s : TimeseriestbatsSeries) -> Int { s.vals.length() }

pub fn timeseries_tbats_series_sum(s : TimeseriestbatsSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_tbats_series_mean(s : TimeseriestbatsSeries) -> Double {
  let n = timeseries_tbats_series_len(s)
  if n == 0 { 0.0 } else { timeseries_tbats_series_sum(s) / n.to_double() }
}

pub fn timeseries_tbats_series_min(s : TimeseriestbatsSeries) -> Double {
  let n = timeseries_tbats_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_tbats_series_max(s : TimeseriestbatsSeries) -> Double {
  let n = timeseries_tbats_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_tbats_series_range(s : TimeseriestbatsSeries) -> Double {
  timeseries_tbats_series_max(s) - timeseries_tbats_series_min(s)
}

pub fn timeseries_tbats_series_var(s : TimeseriestbatsSeries) -> Double {
  let n = timeseries_tbats_series_len(s)
  if n == 0 { 0.0 } else {
    let m = timeseries_tbats_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn timeseries_tbats_series_std(s : TimeseriestbatsSeries) -> Double { @_common.sqrt(timeseries_tbats_series_var(s)) }

pub fn timeseries_tbats_series_median(s : TimeseriestbatsSeries) -> Double {
  let n = timeseries_tbats_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = timeseries_tbats_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_tbats_series_scale(s : TimeseriestbatsSeries, f : Double) -> TimeseriestbatsSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_tbats_series_add(a : TimeseriestbatsSeries, b : TimeseriestbatsSeries) -> TimeseriestbatsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_tbats_series_sub(a : TimeseriestbatsSeries, b : TimeseriestbatsSeries) -> TimeseriestbatsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_tbats_series_normalize(s : TimeseriestbatsSeries) -> TimeseriestbatsSeries {
  let mn = timeseries_tbats_series_min(s)
  let mx = timeseries_tbats_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_tbats_series_cumsum(s : TimeseriestbatsSeries) -> TimeseriestbatsSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_tbats_series_to_string(s : TimeseriestbatsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriestbatsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_tbats_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriestbatsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_tbats_matrix_identity(n : Int) -> TimeseriestbatsMatrix {
  let m = timeseries_tbats_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_tbats_matrix_get(m : TimeseriestbatsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_tbats_matrix_transpose(m : TimeseriestbatsMatrix) -> TimeseriestbatsMatrix {
  let result = timeseries_tbats_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_tbats_matrix_add(a : TimeseriestbatsMatrix, b : TimeseriestbatsMatrix) -> TimeseriestbatsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_tbats_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_tbats_matrix_scale(m : TimeseriestbatsMatrix, s : Double) -> TimeseriestbatsMatrix {
  let result = timeseries_tbats_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_tbats_matrix_multiply(a : TimeseriestbatsMatrix, b : TimeseriestbatsMatrix) -> TimeseriestbatsMatrix {
  if a.cols != b.rows { return timeseries_tbats_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_tbats_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_tbats_matrix_trace(m : TimeseriestbatsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_tbats_matrix_det(m : TimeseriestbatsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_tbats_matrix_norm(m : TimeseriestbatsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_tbats_matrix_to_string(m : TimeseriestbatsMatrix) -> String {
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

pub(all) struct TimeseriestbatsVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_tbats_make_vector(comps : Array[Double]) -> TimeseriestbatsVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_tbats_vector_zero(dim : Int) -> TimeseriestbatsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_tbats_vector_add(a : TimeseriestbatsVector, b : TimeseriestbatsVector) -> TimeseriestbatsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_tbats_vector_sub(a : TimeseriestbatsVector, b : TimeseriestbatsVector) -> TimeseriestbatsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_tbats_vector_scale(v : TimeseriestbatsVector, s : Double) -> TimeseriestbatsVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_tbats_vector_dot(a : TimeseriestbatsVector, b : TimeseriestbatsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_tbats_vector_norm(v : TimeseriestbatsVector) -> Double { @_common.sqrt(timeseries_tbats_vector_dot(v, v)) }

pub fn timeseries_tbats_vector_normalize(v : TimeseriestbatsVector) -> TimeseriestbatsVector {
  let n = timeseries_tbats_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_tbats_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_tbats_vector_dist(a : TimeseriestbatsVector, b : TimeseriestbatsVector) -> Double {
  timeseries_tbats_vector_norm(timeseries_tbats_vector_sub(a, b))
}

pub fn timeseries_tbats_vector_to_string(v : TimeseriestbatsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_tbats_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_tbats_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_tbats_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_tbats_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_tbats_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_tbats_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_tbats_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_tbats_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_tbats_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_tbats_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_tbats_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_tbats_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_tbats_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_tbats_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_tbats_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_tbats_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_tbats_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_tbats_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_tbats_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_tbats_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_tbats_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_tbats_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_tbats_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_tbats_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_tbats_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_tbats_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_tbats_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_tbats_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_tbats_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriestbatsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_frame_make(size : Int) -> TimeseriestbatsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_frame_len(s : TimeseriestbatsFrame) -> Int { s.size }

pub fn timeseries_tbats_frame_get(s : TimeseriestbatsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_frame_set(s : TimeseriestbatsFrame, i : Int, v : Double) -> TimeseriestbatsFrame {
  let result = timeseries_tbats_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_frame_sum(s : TimeseriestbatsFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_tbats_frame_mean(s : TimeseriestbatsFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_tbats_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_tbats_frame_scale(s : TimeseriestbatsFrame, f : Double) -> TimeseriestbatsFrame {
  let result = timeseries_tbats_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_tbats_frame_add(a : TimeseriestbatsFrame, b : TimeseriestbatsFrame) -> TimeseriestbatsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_tbats_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_tbats_frame_copy(s : TimeseriestbatsFrame) -> TimeseriestbatsFrame {
  let result = timeseries_tbats_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_tbats_frame_fill(s : TimeseriestbatsFrame, v : Double) -> TimeseriestbatsFrame {
  let result = timeseries_tbats_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_frame_min(s : TimeseriestbatsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_frame_max(s : TimeseriestbatsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_frame_to_string(s : TimeseriestbatsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_table_make(size : Int) -> TimeseriestbatsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_table_len(s : TimeseriestbatsTable) -> Int { s.size }

pub fn timeseries_tbats_table_get(s : TimeseriestbatsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_table_set(s : TimeseriestbatsTable, i : Int, v : Double) -> TimeseriestbatsTable {
  let result = timeseries_tbats_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_table_sum(s : TimeseriestbatsTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_tbats_table_mean(s : TimeseriestbatsTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_tbats_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_tbats_table_scale(s : TimeseriestbatsTable, f : Double) -> TimeseriestbatsTable {
  let result = timeseries_tbats_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_tbats_table_add(a : TimeseriestbatsTable, b : TimeseriestbatsTable) -> TimeseriestbatsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_tbats_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_tbats_table_copy(s : TimeseriestbatsTable) -> TimeseriestbatsTable {
  let result = timeseries_tbats_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_tbats_table_fill(s : TimeseriestbatsTable, v : Double) -> TimeseriestbatsTable {
  let result = timeseries_tbats_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_table_min(s : TimeseriestbatsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_table_max(s : TimeseriestbatsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_table_to_string(s : TimeseriestbatsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_graphn_make(size : Int) -> TimeseriestbatsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_graphn_len(s : TimeseriestbatsGraphN) -> Int { s.size }

pub fn timeseries_tbats_graphn_get(s : TimeseriestbatsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_graphn_set(s : TimeseriestbatsGraphN, i : Int, v : Double) -> TimeseriestbatsGraphN {
  let result = timeseries_tbats_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_graphn_sum(s : TimeseriestbatsGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_tbats_graphn_mean(s : TimeseriestbatsGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_tbats_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_tbats_graphn_scale(s : TimeseriestbatsGraphN, f : Double) -> TimeseriestbatsGraphN {
  let result = timeseries_tbats_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_tbats_graphn_add(a : TimeseriestbatsGraphN, b : TimeseriestbatsGraphN) -> TimeseriestbatsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_tbats_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_tbats_graphn_copy(s : TimeseriestbatsGraphN) -> TimeseriestbatsGraphN {
  let result = timeseries_tbats_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_tbats_graphn_fill(s : TimeseriestbatsGraphN, v : Double) -> TimeseriestbatsGraphN {
  let result = timeseries_tbats_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_graphn_min(s : TimeseriestbatsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_graphn_max(s : TimeseriestbatsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_graphn_to_string(s : TimeseriestbatsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_node_make(size : Int) -> TimeseriestbatsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_node_len(s : TimeseriestbatsNode) -> Int { s.size }

pub fn timeseries_tbats_node_get(s : TimeseriestbatsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_node_set(s : TimeseriestbatsNode, i : Int, v : Double) -> TimeseriestbatsNode {
  let result = timeseries_tbats_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_node_sum(s : TimeseriestbatsNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_tbats_node_mean(s : TimeseriestbatsNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_tbats_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_tbats_node_scale(s : TimeseriestbatsNode, f : Double) -> TimeseriestbatsNode {
  let result = timeseries_tbats_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_tbats_node_add(a : TimeseriestbatsNode, b : TimeseriestbatsNode) -> TimeseriestbatsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_tbats_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_tbats_node_copy(s : TimeseriestbatsNode) -> TimeseriestbatsNode {
  let result = timeseries_tbats_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_tbats_node_fill(s : TimeseriestbatsNode, v : Double) -> TimeseriestbatsNode {
  let result = timeseries_tbats_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_node_min(s : TimeseriestbatsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_node_max(s : TimeseriestbatsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_node_to_string(s : TimeseriestbatsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_edge_make(size : Int) -> TimeseriestbatsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_edge_len(s : TimeseriestbatsEdge) -> Int { s.size }

pub fn timeseries_tbats_edge_get(s : TimeseriestbatsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_edge_set(s : TimeseriestbatsEdge, i : Int, v : Double) -> TimeseriestbatsEdge {
  let result = timeseries_tbats_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_edge_sum(s : TimeseriestbatsEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_tbats_edge_mean(s : TimeseriestbatsEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_tbats_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_tbats_edge_scale(s : TimeseriestbatsEdge, f : Double) -> TimeseriestbatsEdge {
  let result = timeseries_tbats_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_tbats_edge_add(a : TimeseriestbatsEdge, b : TimeseriestbatsEdge) -> TimeseriestbatsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_tbats_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_tbats_edge_copy(s : TimeseriestbatsEdge) -> TimeseriestbatsEdge {
  let result = timeseries_tbats_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_tbats_edge_fill(s : TimeseriestbatsEdge, v : Double) -> TimeseriestbatsEdge {
  let result = timeseries_tbats_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_edge_min(s : TimeseriestbatsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_edge_max(s : TimeseriestbatsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_edge_to_string(s : TimeseriestbatsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_path_make(size : Int) -> TimeseriestbatsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_path_len(s : TimeseriestbatsPath) -> Int { s.size }

pub fn timeseries_tbats_path_get(s : TimeseriestbatsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_path_set(s : TimeseriestbatsPath, i : Int, v : Double) -> TimeseriestbatsPath {
  let result = timeseries_tbats_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_path_sum(s : TimeseriestbatsPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_tbats_path_mean(s : TimeseriestbatsPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_tbats_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_tbats_path_scale(s : TimeseriestbatsPath, f : Double) -> TimeseriestbatsPath {
  let result = timeseries_tbats_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_tbats_path_add(a : TimeseriestbatsPath, b : TimeseriestbatsPath) -> TimeseriestbatsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_tbats_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_tbats_path_copy(s : TimeseriestbatsPath) -> TimeseriestbatsPath {
  let result = timeseries_tbats_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_tbats_path_fill(s : TimeseriestbatsPath, v : Double) -> TimeseriestbatsPath {
  let result = timeseries_tbats_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_path_min(s : TimeseriestbatsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_path_max(s : TimeseriestbatsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_path_to_string(s : TimeseriestbatsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_cluster_make(size : Int) -> TimeseriestbatsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_cluster_len(s : TimeseriestbatsCluster) -> Int { s.size }

pub fn timeseries_tbats_cluster_get(s : TimeseriestbatsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_cluster_set(s : TimeseriestbatsCluster, i : Int, v : Double) -> TimeseriestbatsCluster {
  let result = timeseries_tbats_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_cluster_sum(s : TimeseriestbatsCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_tbats_cluster_mean(s : TimeseriestbatsCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_tbats_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_tbats_cluster_scale(s : TimeseriestbatsCluster, f : Double) -> TimeseriestbatsCluster {
  let result = timeseries_tbats_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_tbats_cluster_add(a : TimeseriestbatsCluster, b : TimeseriestbatsCluster) -> TimeseriestbatsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_tbats_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_tbats_cluster_copy(s : TimeseriestbatsCluster) -> TimeseriestbatsCluster {
  let result = timeseries_tbats_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_tbats_cluster_fill(s : TimeseriestbatsCluster, v : Double) -> TimeseriestbatsCluster {
  let result = timeseries_tbats_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_cluster_min(s : TimeseriestbatsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_cluster_max(s : TimeseriestbatsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_cluster_to_string(s : TimeseriestbatsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_model_make(size : Int) -> TimeseriestbatsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_model_len(s : TimeseriestbatsModel) -> Int { s.size }

pub fn timeseries_tbats_model_get(s : TimeseriestbatsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_model_set(s : TimeseriestbatsModel, i : Int, v : Double) -> TimeseriestbatsModel {
  let result = timeseries_tbats_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_model_sum(s : TimeseriestbatsModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_tbats_model_mean(s : TimeseriestbatsModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_tbats_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_tbats_model_scale(s : TimeseriestbatsModel, f : Double) -> TimeseriestbatsModel {
  let result = timeseries_tbats_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_tbats_model_add(a : TimeseriestbatsModel, b : TimeseriestbatsModel) -> TimeseriestbatsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_tbats_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_tbats_model_copy(s : TimeseriestbatsModel) -> TimeseriestbatsModel {
  let result = timeseries_tbats_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_tbats_model_fill(s : TimeseriestbatsModel, v : Double) -> TimeseriestbatsModel {
  let result = timeseries_tbats_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_model_min(s : TimeseriestbatsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_model_max(s : TimeseriestbatsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_model_to_string(s : TimeseriestbatsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_layer_make(size : Int) -> TimeseriestbatsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_layer_len(s : TimeseriestbatsLayer) -> Int { s.size }

pub fn timeseries_tbats_layer_get(s : TimeseriestbatsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_layer_set(s : TimeseriestbatsLayer, i : Int, v : Double) -> TimeseriestbatsLayer {
  let result = timeseries_tbats_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_layer_sum(s : TimeseriestbatsLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_tbats_layer_mean(s : TimeseriestbatsLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_tbats_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_tbats_layer_scale(s : TimeseriestbatsLayer, f : Double) -> TimeseriestbatsLayer {
  let result = timeseries_tbats_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_tbats_layer_add(a : TimeseriestbatsLayer, b : TimeseriestbatsLayer) -> TimeseriestbatsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_tbats_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_tbats_layer_copy(s : TimeseriestbatsLayer) -> TimeseriestbatsLayer {
  let result = timeseries_tbats_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_tbats_layer_fill(s : TimeseriestbatsLayer, v : Double) -> TimeseriestbatsLayer {
  let result = timeseries_tbats_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_layer_min(s : TimeseriestbatsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_layer_max(s : TimeseriestbatsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_layer_to_string(s : TimeseriestbatsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_buffer_make(size : Int) -> TimeseriestbatsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_buffer_len(s : TimeseriestbatsBuffer) -> Int { s.size }

pub fn timeseries_tbats_buffer_get(s : TimeseriestbatsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_buffer_set(s : TimeseriestbatsBuffer, i : Int, v : Double) -> TimeseriestbatsBuffer {
  let result = timeseries_tbats_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_buffer_sum(s : TimeseriestbatsBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_tbats_buffer_mean(s : TimeseriestbatsBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_tbats_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_tbats_buffer_scale(s : TimeseriestbatsBuffer, f : Double) -> TimeseriestbatsBuffer {
  let result = timeseries_tbats_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_tbats_buffer_add(a : TimeseriestbatsBuffer, b : TimeseriestbatsBuffer) -> TimeseriestbatsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_tbats_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_tbats_buffer_copy(s : TimeseriestbatsBuffer) -> TimeseriestbatsBuffer {
  let result = timeseries_tbats_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_tbats_buffer_fill(s : TimeseriestbatsBuffer, v : Double) -> TimeseriestbatsBuffer {
  let result = timeseries_tbats_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_buffer_min(s : TimeseriestbatsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_buffer_max(s : TimeseriestbatsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_buffer_to_string(s : TimeseriestbatsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_cursor_make(size : Int) -> TimeseriestbatsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_cursor_len(s : TimeseriestbatsCursor) -> Int { s.size }

pub fn timeseries_tbats_cursor_get(s : TimeseriestbatsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_cursor_set(s : TimeseriestbatsCursor, i : Int, v : Double) -> TimeseriestbatsCursor {
  let result = timeseries_tbats_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_cursor_sum(s : TimeseriestbatsCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_tbats_cursor_mean(s : TimeseriestbatsCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_tbats_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_tbats_cursor_scale(s : TimeseriestbatsCursor, f : Double) -> TimeseriestbatsCursor {
  let result = timeseries_tbats_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_tbats_cursor_add(a : TimeseriestbatsCursor, b : TimeseriestbatsCursor) -> TimeseriestbatsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_tbats_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_tbats_cursor_copy(s : TimeseriestbatsCursor) -> TimeseriestbatsCursor {
  let result = timeseries_tbats_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_tbats_cursor_fill(s : TimeseriestbatsCursor, v : Double) -> TimeseriestbatsCursor {
  let result = timeseries_tbats_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_cursor_min(s : TimeseriestbatsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_cursor_max(s : TimeseriestbatsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_cursor_to_string(s : TimeseriestbatsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_view_make(size : Int) -> TimeseriestbatsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_view_len(s : TimeseriestbatsView) -> Int { s.size }

pub fn timeseries_tbats_view_get(s : TimeseriestbatsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_view_set(s : TimeseriestbatsView, i : Int, v : Double) -> TimeseriestbatsView {
  let result = timeseries_tbats_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_view_sum(s : TimeseriestbatsView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_tbats_view_mean(s : TimeseriestbatsView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_tbats_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_tbats_view_scale(s : TimeseriestbatsView, f : Double) -> TimeseriestbatsView {
  let result = timeseries_tbats_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_tbats_view_add(a : TimeseriestbatsView, b : TimeseriestbatsView) -> TimeseriestbatsView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_tbats_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_tbats_view_copy(s : TimeseriestbatsView) -> TimeseriestbatsView {
  let result = timeseries_tbats_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_tbats_view_fill(s : TimeseriestbatsView, v : Double) -> TimeseriestbatsView {
  let result = timeseries_tbats_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_view_min(s : TimeseriestbatsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_view_max(s : TimeseriestbatsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_view_to_string(s : TimeseriestbatsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_range_make(size : Int) -> TimeseriestbatsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_range_len(s : TimeseriestbatsRange) -> Int { s.size }

pub fn timeseries_tbats_range_get(s : TimeseriestbatsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_range_set(s : TimeseriestbatsRange, i : Int, v : Double) -> TimeseriestbatsRange {
  let result = timeseries_tbats_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_range_sum(s : TimeseriestbatsRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_tbats_range_mean(s : TimeseriestbatsRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_tbats_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_tbats_range_scale(s : TimeseriestbatsRange, f : Double) -> TimeseriestbatsRange {
  let result = timeseries_tbats_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_tbats_range_add(a : TimeseriestbatsRange, b : TimeseriestbatsRange) -> TimeseriestbatsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_tbats_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_tbats_range_copy(s : TimeseriestbatsRange) -> TimeseriestbatsRange {
  let result = timeseries_tbats_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_tbats_range_fill(s : TimeseriestbatsRange, v : Double) -> TimeseriestbatsRange {
  let result = timeseries_tbats_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_range_min(s : TimeseriestbatsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_range_max(s : TimeseriestbatsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_range_to_string(s : TimeseriestbatsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_slice_make(size : Int) -> TimeseriestbatsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_slice_len(s : TimeseriestbatsSlice) -> Int { s.size }

pub fn timeseries_tbats_slice_get(s : TimeseriestbatsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_slice_set(s : TimeseriestbatsSlice, i : Int, v : Double) -> TimeseriestbatsSlice {
  let result = timeseries_tbats_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_slice_sum(s : TimeseriestbatsSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_tbats_slice_mean(s : TimeseriestbatsSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_tbats_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_tbats_slice_scale(s : TimeseriestbatsSlice, f : Double) -> TimeseriestbatsSlice {
  let result = timeseries_tbats_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_tbats_slice_add(a : TimeseriestbatsSlice, b : TimeseriestbatsSlice) -> TimeseriestbatsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_tbats_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_tbats_slice_copy(s : TimeseriestbatsSlice) -> TimeseriestbatsSlice {
  let result = timeseries_tbats_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_tbats_slice_fill(s : TimeseriestbatsSlice, v : Double) -> TimeseriestbatsSlice {
  let result = timeseries_tbats_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_tbats_slice_min(s : TimeseriestbatsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_slice_max(s : TimeseriestbatsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_tbats_slice_to_string(s : TimeseriestbatsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

