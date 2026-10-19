///===
/// extcore/geo_buffer_line

pub(all) struct GeobufferlinePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_buffer_line_make_point(x : Double, y : Double) -> GeobufferlinePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_buffer_line_make_point3(x : Double, y : Double, z : Double) -> GeobufferlinePoint {
  { x, y, z, label: 0 }
}

pub fn geo_buffer_line_point_x(pt : GeobufferlinePoint) -> Double { pt.x }

pub fn geo_buffer_line_point_y(pt : GeobufferlinePoint) -> Double { pt.y }

pub fn geo_buffer_line_point_z(pt : GeobufferlinePoint) -> Double { pt.z }

pub fn geo_buffer_line_point_label(pt : GeobufferlinePoint) -> Int { pt.label }

pub fn geo_buffer_line_point_dist(a : GeobufferlinePoint, b : GeobufferlinePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_buffer_line_point_add(a : GeobufferlinePoint, b : GeobufferlinePoint) -> GeobufferlinePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_buffer_line_point_sub(a : GeobufferlinePoint, b : GeobufferlinePoint) -> GeobufferlinePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_buffer_line_point_scale(pt : GeobufferlinePoint, s : Double) -> GeobufferlinePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_buffer_line_point_dot(a : GeobufferlinePoint, b : GeobufferlinePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_buffer_line_point_cross(a : GeobufferlinePoint, b : GeobufferlinePoint) -> GeobufferlinePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_buffer_line_point_norm(pt : GeobufferlinePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_buffer_line_point_normalize(pt : GeobufferlinePoint) -> GeobufferlinePoint {
  let n = geo_buffer_line_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_buffer_line_point_scale(pt, 1.0 / n) }
}

pub fn geo_buffer_line_point_negate(pt : GeobufferlinePoint) -> GeobufferlinePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_buffer_line_point_mid(a : GeobufferlinePoint, b : GeobufferlinePoint) -> GeobufferlinePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_buffer_line_point_lerp(a : GeobufferlinePoint, b : GeobufferlinePoint, t : Double) -> GeobufferlinePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_buffer_line_point_to_string(pt : GeobufferlinePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeobufferlineSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_buffer_line_make_series(vals : Array[Double], name : String) -> GeobufferlineSeries {
  { vals, name, meta: 0 }
}

pub fn geo_buffer_line_series_len(s : GeobufferlineSeries) -> Int { s.vals.length() }

pub fn geo_buffer_line_series_sum(s : GeobufferlineSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_buffer_line_series_mean(s : GeobufferlineSeries) -> Double {
  let n = geo_buffer_line_series_len(s)
  if n == 0 { 0.0 } else { geo_buffer_line_series_sum(s) / n.to_double() }
}

pub fn geo_buffer_line_series_min(s : GeobufferlineSeries) -> Double {
  let n = geo_buffer_line_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn geo_buffer_line_series_max(s : GeobufferlineSeries) -> Double {
  let n = geo_buffer_line_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn geo_buffer_line_series_range(s : GeobufferlineSeries) -> Double {
  geo_buffer_line_series_max(s) - geo_buffer_line_series_min(s)
}

pub fn geo_buffer_line_series_var(s : GeobufferlineSeries) -> Double {
  let n = geo_buffer_line_series_len(s)
  if n == 0 { 0.0 } else {
    let m = geo_buffer_line_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn geo_buffer_line_series_std(s : GeobufferlineSeries) -> Double { @_common.sqrt(geo_buffer_line_series_var(s)) }

pub fn geo_buffer_line_series_median(s : GeobufferlineSeries) -> Double {
  let n = geo_buffer_line_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = geo_buffer_line_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_buffer_line_series_scale(s : GeobufferlineSeries, f : Double) -> GeobufferlineSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_buffer_line_series_add(a : GeobufferlineSeries, b : GeobufferlineSeries) -> GeobufferlineSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_buffer_line_series_sub(a : GeobufferlineSeries, b : GeobufferlineSeries) -> GeobufferlineSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_buffer_line_series_normalize(s : GeobufferlineSeries) -> GeobufferlineSeries {
  let mn = geo_buffer_line_series_min(s)
  let mx = geo_buffer_line_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_buffer_line_series_cumsum(s : GeobufferlineSeries) -> GeobufferlineSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_buffer_line_series_to_string(s : GeobufferlineSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobufferlineMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_buffer_line_make_matrix(rows : Int, cols : Int, val : Double) -> GeobufferlineMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_buffer_line_matrix_identity(n : Int) -> GeobufferlineMatrix {
  let m = geo_buffer_line_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_buffer_line_matrix_get(m : GeobufferlineMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_buffer_line_matrix_transpose(m : GeobufferlineMatrix) -> GeobufferlineMatrix {
  let result = geo_buffer_line_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_buffer_line_matrix_add(a : GeobufferlineMatrix, b : GeobufferlineMatrix) -> GeobufferlineMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_buffer_line_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_buffer_line_matrix_scale(m : GeobufferlineMatrix, s : Double) -> GeobufferlineMatrix {
  let result = geo_buffer_line_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_buffer_line_matrix_multiply(a : GeobufferlineMatrix, b : GeobufferlineMatrix) -> GeobufferlineMatrix {
  if a.cols != b.rows { return geo_buffer_line_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_buffer_line_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_buffer_line_matrix_trace(m : GeobufferlineMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_buffer_line_matrix_det(m : GeobufferlineMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_buffer_line_matrix_norm(m : GeobufferlineMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_buffer_line_matrix_to_string(m : GeobufferlineMatrix) -> String {
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

pub(all) struct GeobufferlineVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_buffer_line_make_vector(comps : Array[Double]) -> GeobufferlineVector {
  { comps, dim: comps.length() }
}

pub fn geo_buffer_line_vector_zero(dim : Int) -> GeobufferlineVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_buffer_line_vector_add(a : GeobufferlineVector, b : GeobufferlineVector) -> GeobufferlineVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_buffer_line_vector_sub(a : GeobufferlineVector, b : GeobufferlineVector) -> GeobufferlineVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_buffer_line_vector_scale(v : GeobufferlineVector, s : Double) -> GeobufferlineVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_buffer_line_vector_dot(a : GeobufferlineVector, b : GeobufferlineVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_buffer_line_vector_norm(v : GeobufferlineVector) -> Double { @_common.sqrt(geo_buffer_line_vector_dot(v, v)) }

pub fn geo_buffer_line_vector_normalize(v : GeobufferlineVector) -> GeobufferlineVector {
  let n = geo_buffer_line_vector_norm(v)
  if n < 0.0000001 { v } else { geo_buffer_line_vector_scale(v, 1.0 / n) }
}

pub fn geo_buffer_line_vector_dist(a : GeobufferlineVector, b : GeobufferlineVector) -> Double {
  geo_buffer_line_vector_norm(geo_buffer_line_vector_sub(a, b))
}

pub fn geo_buffer_line_vector_to_string(v : GeobufferlineVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_buffer_line_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_buffer_line_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_buffer_line_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_buffer_line_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_buffer_line_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_buffer_line_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_buffer_line_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_buffer_line_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_buffer_line_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_buffer_line_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_buffer_line_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_buffer_line_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_buffer_line_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_buffer_line_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_buffer_line_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_buffer_line_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_buffer_line_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_buffer_line_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_buffer_line_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_buffer_line_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_buffer_line_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_buffer_line_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_buffer_line_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_buffer_line_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_buffer_line_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_buffer_line_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_buffer_line_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_buffer_line_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_buffer_line_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeobufferlineFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_frame_make(size : Int) -> GeobufferlineFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_frame_len(s : GeobufferlineFrame) -> Int { s.size }

pub fn geo_buffer_line_frame_get(s : GeobufferlineFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_frame_set(s : GeobufferlineFrame, i : Int, v : Double) -> GeobufferlineFrame {
  let result = geo_buffer_line_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_frame_sum(s : GeobufferlineFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_line_frame_mean(s : GeobufferlineFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_line_frame_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_line_frame_scale(s : GeobufferlineFrame, f : Double) -> GeobufferlineFrame {
  let result = geo_buffer_line_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_line_frame_add(a : GeobufferlineFrame, b : GeobufferlineFrame) -> GeobufferlineFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_line_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_line_frame_copy(s : GeobufferlineFrame) -> GeobufferlineFrame {
  let result = geo_buffer_line_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_line_frame_fill(s : GeobufferlineFrame, v : Double) -> GeobufferlineFrame {
  let result = geo_buffer_line_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_frame_min(s : GeobufferlineFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_frame_max(s : GeobufferlineFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_frame_to_string(s : GeobufferlineFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlineTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_table_make(size : Int) -> GeobufferlineTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_table_len(s : GeobufferlineTable) -> Int { s.size }

pub fn geo_buffer_line_table_get(s : GeobufferlineTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_table_set(s : GeobufferlineTable, i : Int, v : Double) -> GeobufferlineTable {
  let result = geo_buffer_line_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_table_sum(s : GeobufferlineTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_line_table_mean(s : GeobufferlineTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_line_table_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_line_table_scale(s : GeobufferlineTable, f : Double) -> GeobufferlineTable {
  let result = geo_buffer_line_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_line_table_add(a : GeobufferlineTable, b : GeobufferlineTable) -> GeobufferlineTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_line_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_line_table_copy(s : GeobufferlineTable) -> GeobufferlineTable {
  let result = geo_buffer_line_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_line_table_fill(s : GeobufferlineTable, v : Double) -> GeobufferlineTable {
  let result = geo_buffer_line_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_table_min(s : GeobufferlineTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_table_max(s : GeobufferlineTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_table_to_string(s : GeobufferlineTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlineGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_graphn_make(size : Int) -> GeobufferlineGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_graphn_len(s : GeobufferlineGraphN) -> Int { s.size }

pub fn geo_buffer_line_graphn_get(s : GeobufferlineGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_graphn_set(s : GeobufferlineGraphN, i : Int, v : Double) -> GeobufferlineGraphN {
  let result = geo_buffer_line_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_graphn_sum(s : GeobufferlineGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_line_graphn_mean(s : GeobufferlineGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_line_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_line_graphn_scale(s : GeobufferlineGraphN, f : Double) -> GeobufferlineGraphN {
  let result = geo_buffer_line_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_line_graphn_add(a : GeobufferlineGraphN, b : GeobufferlineGraphN) -> GeobufferlineGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_line_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_line_graphn_copy(s : GeobufferlineGraphN) -> GeobufferlineGraphN {
  let result = geo_buffer_line_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_line_graphn_fill(s : GeobufferlineGraphN, v : Double) -> GeobufferlineGraphN {
  let result = geo_buffer_line_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_graphn_min(s : GeobufferlineGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_graphn_max(s : GeobufferlineGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_graphn_to_string(s : GeobufferlineGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlineNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_node_make(size : Int) -> GeobufferlineNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_node_len(s : GeobufferlineNode) -> Int { s.size }

pub fn geo_buffer_line_node_get(s : GeobufferlineNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_node_set(s : GeobufferlineNode, i : Int, v : Double) -> GeobufferlineNode {
  let result = geo_buffer_line_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_node_sum(s : GeobufferlineNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_line_node_mean(s : GeobufferlineNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_line_node_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_line_node_scale(s : GeobufferlineNode, f : Double) -> GeobufferlineNode {
  let result = geo_buffer_line_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_line_node_add(a : GeobufferlineNode, b : GeobufferlineNode) -> GeobufferlineNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_line_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_line_node_copy(s : GeobufferlineNode) -> GeobufferlineNode {
  let result = geo_buffer_line_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_line_node_fill(s : GeobufferlineNode, v : Double) -> GeobufferlineNode {
  let result = geo_buffer_line_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_node_min(s : GeobufferlineNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_node_max(s : GeobufferlineNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_node_to_string(s : GeobufferlineNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlineEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_edge_make(size : Int) -> GeobufferlineEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_edge_len(s : GeobufferlineEdge) -> Int { s.size }

pub fn geo_buffer_line_edge_get(s : GeobufferlineEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_edge_set(s : GeobufferlineEdge, i : Int, v : Double) -> GeobufferlineEdge {
  let result = geo_buffer_line_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_edge_sum(s : GeobufferlineEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_line_edge_mean(s : GeobufferlineEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_line_edge_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_line_edge_scale(s : GeobufferlineEdge, f : Double) -> GeobufferlineEdge {
  let result = geo_buffer_line_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_line_edge_add(a : GeobufferlineEdge, b : GeobufferlineEdge) -> GeobufferlineEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_line_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_line_edge_copy(s : GeobufferlineEdge) -> GeobufferlineEdge {
  let result = geo_buffer_line_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_line_edge_fill(s : GeobufferlineEdge, v : Double) -> GeobufferlineEdge {
  let result = geo_buffer_line_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_edge_min(s : GeobufferlineEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_edge_max(s : GeobufferlineEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_edge_to_string(s : GeobufferlineEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlinePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_path_make(size : Int) -> GeobufferlinePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_path_len(s : GeobufferlinePath) -> Int { s.size }

pub fn geo_buffer_line_path_get(s : GeobufferlinePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_path_set(s : GeobufferlinePath, i : Int, v : Double) -> GeobufferlinePath {
  let result = geo_buffer_line_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_path_sum(s : GeobufferlinePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_line_path_mean(s : GeobufferlinePath) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_line_path_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_line_path_scale(s : GeobufferlinePath, f : Double) -> GeobufferlinePath {
  let result = geo_buffer_line_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_line_path_add(a : GeobufferlinePath, b : GeobufferlinePath) -> GeobufferlinePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_line_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_line_path_copy(s : GeobufferlinePath) -> GeobufferlinePath {
  let result = geo_buffer_line_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_line_path_fill(s : GeobufferlinePath, v : Double) -> GeobufferlinePath {
  let result = geo_buffer_line_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_path_min(s : GeobufferlinePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_path_max(s : GeobufferlinePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_path_to_string(s : GeobufferlinePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlineCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_cluster_make(size : Int) -> GeobufferlineCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_cluster_len(s : GeobufferlineCluster) -> Int { s.size }

pub fn geo_buffer_line_cluster_get(s : GeobufferlineCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_cluster_set(s : GeobufferlineCluster, i : Int, v : Double) -> GeobufferlineCluster {
  let result = geo_buffer_line_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_cluster_sum(s : GeobufferlineCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_line_cluster_mean(s : GeobufferlineCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_line_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_line_cluster_scale(s : GeobufferlineCluster, f : Double) -> GeobufferlineCluster {
  let result = geo_buffer_line_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_line_cluster_add(a : GeobufferlineCluster, b : GeobufferlineCluster) -> GeobufferlineCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_line_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_line_cluster_copy(s : GeobufferlineCluster) -> GeobufferlineCluster {
  let result = geo_buffer_line_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_line_cluster_fill(s : GeobufferlineCluster, v : Double) -> GeobufferlineCluster {
  let result = geo_buffer_line_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_cluster_min(s : GeobufferlineCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_cluster_max(s : GeobufferlineCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_cluster_to_string(s : GeobufferlineCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlineModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_model_make(size : Int) -> GeobufferlineModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_model_len(s : GeobufferlineModel) -> Int { s.size }

pub fn geo_buffer_line_model_get(s : GeobufferlineModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_model_set(s : GeobufferlineModel, i : Int, v : Double) -> GeobufferlineModel {
  let result = geo_buffer_line_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_model_sum(s : GeobufferlineModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_line_model_mean(s : GeobufferlineModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_line_model_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_line_model_scale(s : GeobufferlineModel, f : Double) -> GeobufferlineModel {
  let result = geo_buffer_line_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_line_model_add(a : GeobufferlineModel, b : GeobufferlineModel) -> GeobufferlineModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_line_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_line_model_copy(s : GeobufferlineModel) -> GeobufferlineModel {
  let result = geo_buffer_line_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_line_model_fill(s : GeobufferlineModel, v : Double) -> GeobufferlineModel {
  let result = geo_buffer_line_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_model_min(s : GeobufferlineModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_model_max(s : GeobufferlineModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_model_to_string(s : GeobufferlineModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlineLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_layer_make(size : Int) -> GeobufferlineLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_layer_len(s : GeobufferlineLayer) -> Int { s.size }

pub fn geo_buffer_line_layer_get(s : GeobufferlineLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_layer_set(s : GeobufferlineLayer, i : Int, v : Double) -> GeobufferlineLayer {
  let result = geo_buffer_line_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_layer_sum(s : GeobufferlineLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_line_layer_mean(s : GeobufferlineLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_line_layer_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_line_layer_scale(s : GeobufferlineLayer, f : Double) -> GeobufferlineLayer {
  let result = geo_buffer_line_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_line_layer_add(a : GeobufferlineLayer, b : GeobufferlineLayer) -> GeobufferlineLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_line_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_line_layer_copy(s : GeobufferlineLayer) -> GeobufferlineLayer {
  let result = geo_buffer_line_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_line_layer_fill(s : GeobufferlineLayer, v : Double) -> GeobufferlineLayer {
  let result = geo_buffer_line_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_layer_min(s : GeobufferlineLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_layer_max(s : GeobufferlineLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_layer_to_string(s : GeobufferlineLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlineBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_buffer_make(size : Int) -> GeobufferlineBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_buffer_len(s : GeobufferlineBuffer) -> Int { s.size }

pub fn geo_buffer_line_buffer_get(s : GeobufferlineBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_buffer_set(s : GeobufferlineBuffer, i : Int, v : Double) -> GeobufferlineBuffer {
  let result = geo_buffer_line_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_buffer_sum(s : GeobufferlineBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_line_buffer_mean(s : GeobufferlineBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_line_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_line_buffer_scale(s : GeobufferlineBuffer, f : Double) -> GeobufferlineBuffer {
  let result = geo_buffer_line_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_line_buffer_add(a : GeobufferlineBuffer, b : GeobufferlineBuffer) -> GeobufferlineBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_line_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_line_buffer_copy(s : GeobufferlineBuffer) -> GeobufferlineBuffer {
  let result = geo_buffer_line_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_line_buffer_fill(s : GeobufferlineBuffer, v : Double) -> GeobufferlineBuffer {
  let result = geo_buffer_line_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_buffer_min(s : GeobufferlineBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_buffer_max(s : GeobufferlineBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_buffer_to_string(s : GeobufferlineBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlineCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_cursor_make(size : Int) -> GeobufferlineCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_cursor_len(s : GeobufferlineCursor) -> Int { s.size }

pub fn geo_buffer_line_cursor_get(s : GeobufferlineCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_cursor_set(s : GeobufferlineCursor, i : Int, v : Double) -> GeobufferlineCursor {
  let result = geo_buffer_line_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_cursor_sum(s : GeobufferlineCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_line_cursor_mean(s : GeobufferlineCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_line_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_line_cursor_scale(s : GeobufferlineCursor, f : Double) -> GeobufferlineCursor {
  let result = geo_buffer_line_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_line_cursor_add(a : GeobufferlineCursor, b : GeobufferlineCursor) -> GeobufferlineCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_line_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_line_cursor_copy(s : GeobufferlineCursor) -> GeobufferlineCursor {
  let result = geo_buffer_line_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_line_cursor_fill(s : GeobufferlineCursor, v : Double) -> GeobufferlineCursor {
  let result = geo_buffer_line_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_cursor_min(s : GeobufferlineCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_cursor_max(s : GeobufferlineCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_cursor_to_string(s : GeobufferlineCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlineView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_view_make(size : Int) -> GeobufferlineView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_view_len(s : GeobufferlineView) -> Int { s.size }

pub fn geo_buffer_line_view_get(s : GeobufferlineView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_view_set(s : GeobufferlineView, i : Int, v : Double) -> GeobufferlineView {
  let result = geo_buffer_line_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_view_sum(s : GeobufferlineView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_line_view_mean(s : GeobufferlineView) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_line_view_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_line_view_scale(s : GeobufferlineView, f : Double) -> GeobufferlineView {
  let result = geo_buffer_line_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_line_view_add(a : GeobufferlineView, b : GeobufferlineView) -> GeobufferlineView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_line_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_line_view_copy(s : GeobufferlineView) -> GeobufferlineView {
  let result = geo_buffer_line_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_line_view_fill(s : GeobufferlineView, v : Double) -> GeobufferlineView {
  let result = geo_buffer_line_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_view_min(s : GeobufferlineView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_view_max(s : GeobufferlineView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_view_to_string(s : GeobufferlineView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlineRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_range_make(size : Int) -> GeobufferlineRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_range_len(s : GeobufferlineRange) -> Int { s.size }

pub fn geo_buffer_line_range_get(s : GeobufferlineRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_range_set(s : GeobufferlineRange, i : Int, v : Double) -> GeobufferlineRange {
  let result = geo_buffer_line_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_range_sum(s : GeobufferlineRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_line_range_mean(s : GeobufferlineRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_line_range_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_line_range_scale(s : GeobufferlineRange, f : Double) -> GeobufferlineRange {
  let result = geo_buffer_line_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_line_range_add(a : GeobufferlineRange, b : GeobufferlineRange) -> GeobufferlineRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_line_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_line_range_copy(s : GeobufferlineRange) -> GeobufferlineRange {
  let result = geo_buffer_line_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_line_range_fill(s : GeobufferlineRange, v : Double) -> GeobufferlineRange {
  let result = geo_buffer_line_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_range_min(s : GeobufferlineRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_range_max(s : GeobufferlineRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_range_to_string(s : GeobufferlineRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlineSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_slice_make(size : Int) -> GeobufferlineSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_slice_len(s : GeobufferlineSlice) -> Int { s.size }

pub fn geo_buffer_line_slice_get(s : GeobufferlineSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_slice_set(s : GeobufferlineSlice, i : Int, v : Double) -> GeobufferlineSlice {
  let result = geo_buffer_line_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_slice_sum(s : GeobufferlineSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_line_slice_mean(s : GeobufferlineSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_line_slice_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_line_slice_scale(s : GeobufferlineSlice, f : Double) -> GeobufferlineSlice {
  let result = geo_buffer_line_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_line_slice_add(a : GeobufferlineSlice, b : GeobufferlineSlice) -> GeobufferlineSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_line_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_line_slice_copy(s : GeobufferlineSlice) -> GeobufferlineSlice {
  let result = geo_buffer_line_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_line_slice_fill(s : GeobufferlineSlice, v : Double) -> GeobufferlineSlice {
  let result = geo_buffer_line_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_line_slice_min(s : GeobufferlineSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_slice_max(s : GeobufferlineSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_line_slice_to_string(s : GeobufferlineSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

