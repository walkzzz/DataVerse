///===
/// extcore/timeseries_decomp_seats

pub(all) struct TimeseriesdecompseatsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_seats_make_point(x : Double, y : Double) -> TimeseriesdecompseatsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_seats_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecompseatsPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_decomp_seats_point_x(pt : TimeseriesdecompseatsPoint) -> Double { pt.x }

pub fn timeseries_decomp_seats_point_y(pt : TimeseriesdecompseatsPoint) -> Double { pt.y }

pub fn timeseries_decomp_seats_point_z(pt : TimeseriesdecompseatsPoint) -> Double { pt.z }

pub fn timeseries_decomp_seats_point_label(pt : TimeseriesdecompseatsPoint) -> Int { pt.label }

pub fn timeseries_decomp_seats_point_dist(a : TimeseriesdecompseatsPoint, b : TimeseriesdecompseatsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_decomp_seats_point_add(a : TimeseriesdecompseatsPoint, b : TimeseriesdecompseatsPoint) -> TimeseriesdecompseatsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_decomp_seats_point_sub(a : TimeseriesdecompseatsPoint, b : TimeseriesdecompseatsPoint) -> TimeseriesdecompseatsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_decomp_seats_point_scale(pt : TimeseriesdecompseatsPoint, s : Double) -> TimeseriesdecompseatsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_decomp_seats_point_dot(a : TimeseriesdecompseatsPoint, b : TimeseriesdecompseatsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_decomp_seats_point_cross(a : TimeseriesdecompseatsPoint, b : TimeseriesdecompseatsPoint) -> TimeseriesdecompseatsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_decomp_seats_point_norm(pt : TimeseriesdecompseatsPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_decomp_seats_point_normalize(pt : TimeseriesdecompseatsPoint) -> TimeseriesdecompseatsPoint {
  let n = timeseries_decomp_seats_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_decomp_seats_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_decomp_seats_point_negate(pt : TimeseriesdecompseatsPoint) -> TimeseriesdecompseatsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_decomp_seats_point_mid(a : TimeseriesdecompseatsPoint, b : TimeseriesdecompseatsPoint) -> TimeseriesdecompseatsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_decomp_seats_point_lerp(a : TimeseriesdecompseatsPoint, b : TimeseriesdecompseatsPoint, t : Double) -> TimeseriesdecompseatsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_decomp_seats_point_to_string(pt : TimeseriesdecompseatsPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_seats_make_series(vals : Array[Double], name : String) -> TimeseriesdecompseatsSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_decomp_seats_series_len(s : TimeseriesdecompseatsSeries) -> Int { s.vals.length() }

pub fn timeseries_decomp_seats_series_sum(s : TimeseriesdecompseatsSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_decomp_seats_series_mean(s : TimeseriesdecompseatsSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_decomp_seats_series_min(s : TimeseriesdecompseatsSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_decomp_seats_series_max(s : TimeseriesdecompseatsSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_decomp_seats_series_range(s : TimeseriesdecompseatsSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_decomp_seats_series_var(s : TimeseriesdecompseatsSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_decomp_seats_series_std(s : TimeseriesdecompseatsSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_decomp_seats_series_median(s : TimeseriesdecompseatsSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_decomp_seats_series_scale(s : TimeseriesdecompseatsSeries, f : Double) -> TimeseriesdecompseatsSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_decomp_seats_series_add(a : TimeseriesdecompseatsSeries, b : TimeseriesdecompseatsSeries) -> TimeseriesdecompseatsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_decomp_seats_series_sub(a : TimeseriesdecompseatsSeries, b : TimeseriesdecompseatsSeries) -> TimeseriesdecompseatsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_decomp_seats_series_normalize(s : TimeseriesdecompseatsSeries) -> TimeseriesdecompseatsSeries {
  let mn = timeseries_decomp_seats_series_min(s)
  let mx = timeseries_decomp_seats_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_decomp_seats_series_cumsum(s : TimeseriesdecompseatsSeries) -> TimeseriesdecompseatsSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_decomp_seats_series_to_string(s : TimeseriesdecompseatsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompseatsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_seats_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecompseatsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_seats_matrix_identity(n : Int) -> TimeseriesdecompseatsMatrix {
  let m = timeseries_decomp_seats_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_decomp_seats_matrix_get(m : TimeseriesdecompseatsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_decomp_seats_matrix_transpose(m : TimeseriesdecompseatsMatrix) -> TimeseriesdecompseatsMatrix {
  let result = timeseries_decomp_seats_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_decomp_seats_matrix_add(a : TimeseriesdecompseatsMatrix, b : TimeseriesdecompseatsMatrix) -> TimeseriesdecompseatsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_decomp_seats_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_decomp_seats_matrix_scale(m : TimeseriesdecompseatsMatrix, s : Double) -> TimeseriesdecompseatsMatrix {
  let result = timeseries_decomp_seats_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_decomp_seats_matrix_multiply(a : TimeseriesdecompseatsMatrix, b : TimeseriesdecompseatsMatrix) -> TimeseriesdecompseatsMatrix {
  if a.cols != b.rows { return timeseries_decomp_seats_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_decomp_seats_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_decomp_seats_matrix_trace(m : TimeseriesdecompseatsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_decomp_seats_matrix_det(m : TimeseriesdecompseatsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_decomp_seats_matrix_norm(m : TimeseriesdecompseatsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_decomp_seats_matrix_to_string(m : TimeseriesdecompseatsMatrix) -> String {
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

pub(all) struct TimeseriesdecompseatsVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_seats_make_vector(comps : Array[Double]) -> TimeseriesdecompseatsVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_seats_vector_zero(dim : Int) -> TimeseriesdecompseatsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_decomp_seats_vector_add(a : TimeseriesdecompseatsVector, b : TimeseriesdecompseatsVector) -> TimeseriesdecompseatsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_decomp_seats_vector_sub(a : TimeseriesdecompseatsVector, b : TimeseriesdecompseatsVector) -> TimeseriesdecompseatsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_decomp_seats_vector_scale(v : TimeseriesdecompseatsVector, s : Double) -> TimeseriesdecompseatsVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_decomp_seats_vector_dot(a : TimeseriesdecompseatsVector, b : TimeseriesdecompseatsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_decomp_seats_vector_norm(v : TimeseriesdecompseatsVector) -> Double { @_common.sqrt(timeseries_decomp_seats_vector_dot(v, v)) }

pub fn timeseries_decomp_seats_vector_normalize(v : TimeseriesdecompseatsVector) -> TimeseriesdecompseatsVector {
  let n = timeseries_decomp_seats_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_decomp_seats_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_decomp_seats_vector_dist(a : TimeseriesdecompseatsVector, b : TimeseriesdecompseatsVector) -> Double {
  timeseries_decomp_seats_vector_norm(timeseries_decomp_seats_vector_sub(a, b))
}

pub fn timeseries_decomp_seats_vector_to_string(v : TimeseriesdecompseatsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_decomp_seats_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_decomp_seats_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_decomp_seats_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_decomp_seats_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_decomp_seats_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_decomp_seats_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_decomp_seats_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_decomp_seats_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_decomp_seats_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_decomp_seats_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_decomp_seats_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_decomp_seats_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_decomp_seats_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_decomp_seats_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_decomp_seats_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_decomp_seats_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_decomp_seats_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_decomp_seats_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_decomp_seats_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_decomp_seats_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_decomp_seats_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_decomp_seats_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_decomp_seats_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_decomp_seats_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_decomp_seats_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_decomp_seats_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_decomp_seats_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_decomp_seats_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_decomp_seats_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesdecompseatsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_frame_make(size : Int) -> TimeseriesdecompseatsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_frame_len(s : TimeseriesdecompseatsFrame) -> Int { s.size }

pub fn timeseries_decomp_seats_frame_get(s : TimeseriesdecompseatsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_frame_set(s : TimeseriesdecompseatsFrame, i : Int, v : Double) -> TimeseriesdecompseatsFrame {
  let result = timeseries_decomp_seats_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_frame_sum(s : TimeseriesdecompseatsFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_seats_frame_mean(s : TimeseriesdecompseatsFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_seats_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_seats_frame_scale(s : TimeseriesdecompseatsFrame, f : Double) -> TimeseriesdecompseatsFrame {
  let result = timeseries_decomp_seats_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_seats_frame_add(a : TimeseriesdecompseatsFrame, b : TimeseriesdecompseatsFrame) -> TimeseriesdecompseatsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_seats_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_seats_frame_copy(s : TimeseriesdecompseatsFrame) -> TimeseriesdecompseatsFrame {
  let result = timeseries_decomp_seats_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_seats_frame_fill(s : TimeseriesdecompseatsFrame, v : Double) -> TimeseriesdecompseatsFrame {
  let result = timeseries_decomp_seats_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_frame_min(s : TimeseriesdecompseatsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_frame_max(s : TimeseriesdecompseatsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_frame_to_string(s : TimeseriesdecompseatsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_table_make(size : Int) -> TimeseriesdecompseatsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_table_len(s : TimeseriesdecompseatsTable) -> Int { s.size }

pub fn timeseries_decomp_seats_table_get(s : TimeseriesdecompseatsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_table_set(s : TimeseriesdecompseatsTable, i : Int, v : Double) -> TimeseriesdecompseatsTable {
  let result = timeseries_decomp_seats_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_table_sum(s : TimeseriesdecompseatsTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_seats_table_mean(s : TimeseriesdecompseatsTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_seats_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_seats_table_scale(s : TimeseriesdecompseatsTable, f : Double) -> TimeseriesdecompseatsTable {
  let result = timeseries_decomp_seats_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_seats_table_add(a : TimeseriesdecompseatsTable, b : TimeseriesdecompseatsTable) -> TimeseriesdecompseatsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_seats_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_seats_table_copy(s : TimeseriesdecompseatsTable) -> TimeseriesdecompseatsTable {
  let result = timeseries_decomp_seats_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_seats_table_fill(s : TimeseriesdecompseatsTable, v : Double) -> TimeseriesdecompseatsTable {
  let result = timeseries_decomp_seats_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_table_min(s : TimeseriesdecompseatsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_table_max(s : TimeseriesdecompseatsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_table_to_string(s : TimeseriesdecompseatsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_graphn_make(size : Int) -> TimeseriesdecompseatsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_graphn_len(s : TimeseriesdecompseatsGraphN) -> Int { s.size }

pub fn timeseries_decomp_seats_graphn_get(s : TimeseriesdecompseatsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_graphn_set(s : TimeseriesdecompseatsGraphN, i : Int, v : Double) -> TimeseriesdecompseatsGraphN {
  let result = timeseries_decomp_seats_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_graphn_sum(s : TimeseriesdecompseatsGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_seats_graphn_mean(s : TimeseriesdecompseatsGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_seats_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_seats_graphn_scale(s : TimeseriesdecompseatsGraphN, f : Double) -> TimeseriesdecompseatsGraphN {
  let result = timeseries_decomp_seats_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_seats_graphn_add(a : TimeseriesdecompseatsGraphN, b : TimeseriesdecompseatsGraphN) -> TimeseriesdecompseatsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_seats_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_seats_graphn_copy(s : TimeseriesdecompseatsGraphN) -> TimeseriesdecompseatsGraphN {
  let result = timeseries_decomp_seats_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_seats_graphn_fill(s : TimeseriesdecompseatsGraphN, v : Double) -> TimeseriesdecompseatsGraphN {
  let result = timeseries_decomp_seats_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_graphn_min(s : TimeseriesdecompseatsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_graphn_max(s : TimeseriesdecompseatsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_graphn_to_string(s : TimeseriesdecompseatsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_node_make(size : Int) -> TimeseriesdecompseatsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_node_len(s : TimeseriesdecompseatsNode) -> Int { s.size }

pub fn timeseries_decomp_seats_node_get(s : TimeseriesdecompseatsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_node_set(s : TimeseriesdecompseatsNode, i : Int, v : Double) -> TimeseriesdecompseatsNode {
  let result = timeseries_decomp_seats_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_node_sum(s : TimeseriesdecompseatsNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_seats_node_mean(s : TimeseriesdecompseatsNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_seats_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_seats_node_scale(s : TimeseriesdecompseatsNode, f : Double) -> TimeseriesdecompseatsNode {
  let result = timeseries_decomp_seats_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_seats_node_add(a : TimeseriesdecompseatsNode, b : TimeseriesdecompseatsNode) -> TimeseriesdecompseatsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_seats_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_seats_node_copy(s : TimeseriesdecompseatsNode) -> TimeseriesdecompseatsNode {
  let result = timeseries_decomp_seats_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_seats_node_fill(s : TimeseriesdecompseatsNode, v : Double) -> TimeseriesdecompseatsNode {
  let result = timeseries_decomp_seats_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_node_min(s : TimeseriesdecompseatsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_node_max(s : TimeseriesdecompseatsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_node_to_string(s : TimeseriesdecompseatsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_edge_make(size : Int) -> TimeseriesdecompseatsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_edge_len(s : TimeseriesdecompseatsEdge) -> Int { s.size }

pub fn timeseries_decomp_seats_edge_get(s : TimeseriesdecompseatsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_edge_set(s : TimeseriesdecompseatsEdge, i : Int, v : Double) -> TimeseriesdecompseatsEdge {
  let result = timeseries_decomp_seats_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_edge_sum(s : TimeseriesdecompseatsEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_seats_edge_mean(s : TimeseriesdecompseatsEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_seats_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_seats_edge_scale(s : TimeseriesdecompseatsEdge, f : Double) -> TimeseriesdecompseatsEdge {
  let result = timeseries_decomp_seats_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_seats_edge_add(a : TimeseriesdecompseatsEdge, b : TimeseriesdecompseatsEdge) -> TimeseriesdecompseatsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_seats_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_seats_edge_copy(s : TimeseriesdecompseatsEdge) -> TimeseriesdecompseatsEdge {
  let result = timeseries_decomp_seats_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_seats_edge_fill(s : TimeseriesdecompseatsEdge, v : Double) -> TimeseriesdecompseatsEdge {
  let result = timeseries_decomp_seats_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_edge_min(s : TimeseriesdecompseatsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_edge_max(s : TimeseriesdecompseatsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_edge_to_string(s : TimeseriesdecompseatsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_path_make(size : Int) -> TimeseriesdecompseatsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_path_len(s : TimeseriesdecompseatsPath) -> Int { s.size }

pub fn timeseries_decomp_seats_path_get(s : TimeseriesdecompseatsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_path_set(s : TimeseriesdecompseatsPath, i : Int, v : Double) -> TimeseriesdecompseatsPath {
  let result = timeseries_decomp_seats_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_path_sum(s : TimeseriesdecompseatsPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_seats_path_mean(s : TimeseriesdecompseatsPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_seats_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_seats_path_scale(s : TimeseriesdecompseatsPath, f : Double) -> TimeseriesdecompseatsPath {
  let result = timeseries_decomp_seats_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_seats_path_add(a : TimeseriesdecompseatsPath, b : TimeseriesdecompseatsPath) -> TimeseriesdecompseatsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_seats_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_seats_path_copy(s : TimeseriesdecompseatsPath) -> TimeseriesdecompseatsPath {
  let result = timeseries_decomp_seats_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_seats_path_fill(s : TimeseriesdecompseatsPath, v : Double) -> TimeseriesdecompseatsPath {
  let result = timeseries_decomp_seats_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_path_min(s : TimeseriesdecompseatsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_path_max(s : TimeseriesdecompseatsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_path_to_string(s : TimeseriesdecompseatsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_cluster_make(size : Int) -> TimeseriesdecompseatsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_cluster_len(s : TimeseriesdecompseatsCluster) -> Int { s.size }

pub fn timeseries_decomp_seats_cluster_get(s : TimeseriesdecompseatsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_cluster_set(s : TimeseriesdecompseatsCluster, i : Int, v : Double) -> TimeseriesdecompseatsCluster {
  let result = timeseries_decomp_seats_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_cluster_sum(s : TimeseriesdecompseatsCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_seats_cluster_mean(s : TimeseriesdecompseatsCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_seats_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_seats_cluster_scale(s : TimeseriesdecompseatsCluster, f : Double) -> TimeseriesdecompseatsCluster {
  let result = timeseries_decomp_seats_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_seats_cluster_add(a : TimeseriesdecompseatsCluster, b : TimeseriesdecompseatsCluster) -> TimeseriesdecompseatsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_seats_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_seats_cluster_copy(s : TimeseriesdecompseatsCluster) -> TimeseriesdecompseatsCluster {
  let result = timeseries_decomp_seats_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_seats_cluster_fill(s : TimeseriesdecompseatsCluster, v : Double) -> TimeseriesdecompseatsCluster {
  let result = timeseries_decomp_seats_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_cluster_min(s : TimeseriesdecompseatsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_cluster_max(s : TimeseriesdecompseatsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_cluster_to_string(s : TimeseriesdecompseatsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_model_make(size : Int) -> TimeseriesdecompseatsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_model_len(s : TimeseriesdecompseatsModel) -> Int { s.size }

pub fn timeseries_decomp_seats_model_get(s : TimeseriesdecompseatsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_model_set(s : TimeseriesdecompseatsModel, i : Int, v : Double) -> TimeseriesdecompseatsModel {
  let result = timeseries_decomp_seats_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_model_sum(s : TimeseriesdecompseatsModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_seats_model_mean(s : TimeseriesdecompseatsModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_seats_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_seats_model_scale(s : TimeseriesdecompseatsModel, f : Double) -> TimeseriesdecompseatsModel {
  let result = timeseries_decomp_seats_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_seats_model_add(a : TimeseriesdecompseatsModel, b : TimeseriesdecompseatsModel) -> TimeseriesdecompseatsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_seats_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_seats_model_copy(s : TimeseriesdecompseatsModel) -> TimeseriesdecompseatsModel {
  let result = timeseries_decomp_seats_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_seats_model_fill(s : TimeseriesdecompseatsModel, v : Double) -> TimeseriesdecompseatsModel {
  let result = timeseries_decomp_seats_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_model_min(s : TimeseriesdecompseatsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_model_max(s : TimeseriesdecompseatsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_model_to_string(s : TimeseriesdecompseatsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_layer_make(size : Int) -> TimeseriesdecompseatsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_layer_len(s : TimeseriesdecompseatsLayer) -> Int { s.size }

pub fn timeseries_decomp_seats_layer_get(s : TimeseriesdecompseatsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_layer_set(s : TimeseriesdecompseatsLayer, i : Int, v : Double) -> TimeseriesdecompseatsLayer {
  let result = timeseries_decomp_seats_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_layer_sum(s : TimeseriesdecompseatsLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_seats_layer_mean(s : TimeseriesdecompseatsLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_seats_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_seats_layer_scale(s : TimeseriesdecompseatsLayer, f : Double) -> TimeseriesdecompseatsLayer {
  let result = timeseries_decomp_seats_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_seats_layer_add(a : TimeseriesdecompseatsLayer, b : TimeseriesdecompseatsLayer) -> TimeseriesdecompseatsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_seats_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_seats_layer_copy(s : TimeseriesdecompseatsLayer) -> TimeseriesdecompseatsLayer {
  let result = timeseries_decomp_seats_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_seats_layer_fill(s : TimeseriesdecompseatsLayer, v : Double) -> TimeseriesdecompseatsLayer {
  let result = timeseries_decomp_seats_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_layer_min(s : TimeseriesdecompseatsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_layer_max(s : TimeseriesdecompseatsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_layer_to_string(s : TimeseriesdecompseatsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_buffer_make(size : Int) -> TimeseriesdecompseatsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_buffer_len(s : TimeseriesdecompseatsBuffer) -> Int { s.size }

pub fn timeseries_decomp_seats_buffer_get(s : TimeseriesdecompseatsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_buffer_set(s : TimeseriesdecompseatsBuffer, i : Int, v : Double) -> TimeseriesdecompseatsBuffer {
  let result = timeseries_decomp_seats_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_buffer_sum(s : TimeseriesdecompseatsBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_seats_buffer_mean(s : TimeseriesdecompseatsBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_seats_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_seats_buffer_scale(s : TimeseriesdecompseatsBuffer, f : Double) -> TimeseriesdecompseatsBuffer {
  let result = timeseries_decomp_seats_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_seats_buffer_add(a : TimeseriesdecompseatsBuffer, b : TimeseriesdecompseatsBuffer) -> TimeseriesdecompseatsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_seats_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_seats_buffer_copy(s : TimeseriesdecompseatsBuffer) -> TimeseriesdecompseatsBuffer {
  let result = timeseries_decomp_seats_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_seats_buffer_fill(s : TimeseriesdecompseatsBuffer, v : Double) -> TimeseriesdecompseatsBuffer {
  let result = timeseries_decomp_seats_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_buffer_min(s : TimeseriesdecompseatsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_buffer_max(s : TimeseriesdecompseatsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_buffer_to_string(s : TimeseriesdecompseatsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_cursor_make(size : Int) -> TimeseriesdecompseatsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_cursor_len(s : TimeseriesdecompseatsCursor) -> Int { s.size }

pub fn timeseries_decomp_seats_cursor_get(s : TimeseriesdecompseatsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_cursor_set(s : TimeseriesdecompseatsCursor, i : Int, v : Double) -> TimeseriesdecompseatsCursor {
  let result = timeseries_decomp_seats_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_cursor_sum(s : TimeseriesdecompseatsCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_seats_cursor_mean(s : TimeseriesdecompseatsCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_seats_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_seats_cursor_scale(s : TimeseriesdecompseatsCursor, f : Double) -> TimeseriesdecompseatsCursor {
  let result = timeseries_decomp_seats_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_seats_cursor_add(a : TimeseriesdecompseatsCursor, b : TimeseriesdecompseatsCursor) -> TimeseriesdecompseatsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_seats_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_seats_cursor_copy(s : TimeseriesdecompseatsCursor) -> TimeseriesdecompseatsCursor {
  let result = timeseries_decomp_seats_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_seats_cursor_fill(s : TimeseriesdecompseatsCursor, v : Double) -> TimeseriesdecompseatsCursor {
  let result = timeseries_decomp_seats_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_cursor_min(s : TimeseriesdecompseatsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_cursor_max(s : TimeseriesdecompseatsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_cursor_to_string(s : TimeseriesdecompseatsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_view_make(size : Int) -> TimeseriesdecompseatsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_view_len(s : TimeseriesdecompseatsView) -> Int { s.size }

pub fn timeseries_decomp_seats_view_get(s : TimeseriesdecompseatsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_view_set(s : TimeseriesdecompseatsView, i : Int, v : Double) -> TimeseriesdecompseatsView {
  let result = timeseries_decomp_seats_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_view_sum(s : TimeseriesdecompseatsView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_seats_view_mean(s : TimeseriesdecompseatsView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_seats_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_seats_view_scale(s : TimeseriesdecompseatsView, f : Double) -> TimeseriesdecompseatsView {
  let result = timeseries_decomp_seats_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_seats_view_add(a : TimeseriesdecompseatsView, b : TimeseriesdecompseatsView) -> TimeseriesdecompseatsView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_seats_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_seats_view_copy(s : TimeseriesdecompseatsView) -> TimeseriesdecompseatsView {
  let result = timeseries_decomp_seats_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_seats_view_fill(s : TimeseriesdecompseatsView, v : Double) -> TimeseriesdecompseatsView {
  let result = timeseries_decomp_seats_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_view_min(s : TimeseriesdecompseatsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_view_max(s : TimeseriesdecompseatsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_view_to_string(s : TimeseriesdecompseatsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_range_make(size : Int) -> TimeseriesdecompseatsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_range_len(s : TimeseriesdecompseatsRange) -> Int { s.size }

pub fn timeseries_decomp_seats_range_get(s : TimeseriesdecompseatsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_range_set(s : TimeseriesdecompseatsRange, i : Int, v : Double) -> TimeseriesdecompseatsRange {
  let result = timeseries_decomp_seats_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_range_sum(s : TimeseriesdecompseatsRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_seats_range_mean(s : TimeseriesdecompseatsRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_seats_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_seats_range_scale(s : TimeseriesdecompseatsRange, f : Double) -> TimeseriesdecompseatsRange {
  let result = timeseries_decomp_seats_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_seats_range_add(a : TimeseriesdecompseatsRange, b : TimeseriesdecompseatsRange) -> TimeseriesdecompseatsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_seats_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_seats_range_copy(s : TimeseriesdecompseatsRange) -> TimeseriesdecompseatsRange {
  let result = timeseries_decomp_seats_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_seats_range_fill(s : TimeseriesdecompseatsRange, v : Double) -> TimeseriesdecompseatsRange {
  let result = timeseries_decomp_seats_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_range_min(s : TimeseriesdecompseatsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_range_max(s : TimeseriesdecompseatsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_range_to_string(s : TimeseriesdecompseatsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_slice_make(size : Int) -> TimeseriesdecompseatsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_slice_len(s : TimeseriesdecompseatsSlice) -> Int { s.size }

pub fn timeseries_decomp_seats_slice_get(s : TimeseriesdecompseatsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_slice_set(s : TimeseriesdecompseatsSlice, i : Int, v : Double) -> TimeseriesdecompseatsSlice {
  let result = timeseries_decomp_seats_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_slice_sum(s : TimeseriesdecompseatsSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_seats_slice_mean(s : TimeseriesdecompseatsSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_seats_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_seats_slice_scale(s : TimeseriesdecompseatsSlice, f : Double) -> TimeseriesdecompseatsSlice {
  let result = timeseries_decomp_seats_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_seats_slice_add(a : TimeseriesdecompseatsSlice, b : TimeseriesdecompseatsSlice) -> TimeseriesdecompseatsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_seats_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_seats_slice_copy(s : TimeseriesdecompseatsSlice) -> TimeseriesdecompseatsSlice {
  let result = timeseries_decomp_seats_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_seats_slice_fill(s : TimeseriesdecompseatsSlice, v : Double) -> TimeseriesdecompseatsSlice {
  let result = timeseries_decomp_seats_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_seats_slice_min(s : TimeseriesdecompseatsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_slice_max(s : TimeseriesdecompseatsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_seats_slice_to_string(s : TimeseriesdecompseatsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

